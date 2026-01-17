(library (parallel consistency)
    (export check-consistency)
    (import (rnrs (6)) (exn contract) (exn internal) (algo list) (srfi srfi-28) (ice-9 futures))
    
    (define (check-consistency possibilities)
        (unless (and (list? possibilities) 
                     (pair? possibilities)
                     (andmap list? possibilities) 
                     (andmap (lambda (l) (andmap pair? l)) possibilities)
                     (apply = (map length possibilities)))
            (raise-contract-error 'check-consistency "A non-empty list of alists of the same length" possibilities))
        (let ((pair-matrix (apply map (lambda ps ps) possibilities)))
            (for-each
             (lambda (pl)
                (unless (apply equal? (map car pl))
                        (raise-internal-error 'check-consistency (format "Different keys in ~s" pl))))
             pair-matrix)
            (map
                touch
                (map 
                    (lambda (pl)
                        (future
                            (let ((true? (andmap cdr pl)))
                                (if true? 
                                    (cons (caar pl) 'true)
                                    (let ((false? (andmap (lambda (p) (not (cdr p))) pl)))
                                        (if false? (cons (caar pl) 'false) (cons (caar pl) 'uncertain)))))))
                    pair-matrix)))))