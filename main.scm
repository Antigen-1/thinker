(import (app) (ice-9 match) (ice-9 rdelim))

(define (main args)
    (define thinker (make-thinker))
    (for-each 
        (lambda (a)
            (call-with-input-file
             a
             (lambda (in)
                (let loop ()
                    (let ((r (read in)))
                        (if (eof-object? r)
                            #f
                            (begin (loop) (thinker 'add r))))))))
        (cdr args))
    (let loop ()
        (define r (read (open-input-string (read-line))))
        (if (eof-object? r)
            #f
            (match r
                (('save (? string? path))
                 (call-with-output-file path (lambda (out) (map (lambda (f) (write f out)) (thinker 'list))))
                 (loop))
                (('exit) #f)
                (v
                 (write (apply thinker v)) (newline)
                 (loop))))))