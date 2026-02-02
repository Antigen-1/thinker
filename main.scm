(add-to-load-path (in-vicinity (dirname (current-filename)) "lib"))

(import (app) (ice-9 match) (ice-9 rdelim))

(define current-dir (dirname (current-filename)))

;; The script loader
(define (make-new-module)
    (reload-module (resolve-module '(scheme base))))
(define (load-script path)
    (define mod (current-module))
    (dynamic-wind
        (lambda () (set-current-module (make-new-module)))
        (lambda () (load path))
        (lambda () (set-current-module mod))))

;; Test the script loader
(load-script (in-vicinity current-dir (in-vicinity "examples" "connectives.scm")))

(define thinker (make-thinker))

(let loop ()
    (define r (read (open-input-string (read-line))))
    (if (eof-object? r)
        #f
        (match r
            (('save (? string? path))
             (call-with-output-file path (lambda (out) (map (lambda (f) (write f out)) (thinker 'list))))
             (loop))
            (('load (? string? path))
             (call-with-input-file path (lambda (in) (let loop () (let ((f (read in))) (if (eof-object? f) #f (begin (thinker 'add f) (loop)))))))
             (loop))
            (('load-script (? string? path))
             (load-script path)
             (loop))
            (('exit) #f)
            (('commands)
             (map (lambda (d) (display d) (newline))
                  '((save "<path>")
                    (load "<path>")
                    (load-script "<path>")
                    (exit)
                    (commands)
                    ;; Supported by app.scm
                    (add "<form>")
                    (remove "<index>")
                    (list)
                    (list-prims)
                    (list-conns)
                    (entails? "<form>")
                    (clear)))
             (loop))
            (v
             (let ((r (apply thinker v)))
                (unless (unspecified? r)
                    (write r) (newline))
                (loop))))))