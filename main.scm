(add-to-load-path (in-vicinity (dirname (current-filename)) "lib"))

(import (app) (ice-9 match) (ice-9 rdelim))

(define (main _)
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
                (('reset)
                 (thinker 'clear)
                 (loop))
                (('exit) #f)
                (v
                 (let ((r (apply thinker v)))
                    (unless (unspecified? r)
                        (write r) (newline))
                    (loop)))))))