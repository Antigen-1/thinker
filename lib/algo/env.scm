(library (algo env)
    (export labels->env-stream)
    (import (srfi srfi-41) (exn contract) (rnrs (6)))
    
    (define (labels->env-stream ls)
        (for-each 
            (lambda (l)
                (unless (string? l)
                    (raise-contract-error 'labels->env-stream "string?" l)))
            ls)
        (let loop ((ls ls))
            (cond ((null? ls) (stream-cons '() stream-null))
                  (else
                    (let ((f (car ls))
                          (rs (loop (cdr ls))))
                        (stream-append 
                            (stream-map (lambda (r) (cons (cons f #f) r)) rs)
                            (stream-map (lambda (r) (cons (cons f #t) r)) rs)))))))
)