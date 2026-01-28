(add-to-load-path (in-vicinity (dirname (current-filename)) "lib"))

(import (app) (ice-9 match) (ice-9 rdelim))

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
(load-script (in-vicinity (dirname (current-filename)) (in-vicinity "examples" "connectives.scm")))

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
            (('reset)
             (thinker 'clear)
             (loop))
            (('exit) #f)
            (v
             (let ((r (apply thinker v)))
                (unless (unspecified? r)
                    (write r) (newline))
                (loop))))))