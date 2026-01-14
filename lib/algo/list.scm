(library (algo list)
    (export andmap ormap index)
    (import (rnrs (6)) (exn contract))
    
    (define (andmap p l)
        (unless (list? l)
            (raise-contract-error 'andmap "list?" l))
        (call/cc 
            (lambda (cc)
                (for-each (lambda (e) (unless (p e) (cc #f))) l)
                #t)))
    (define (ormap p l)
        (unless (list? l)
            (raise-contract-error 'ormap "list?" l))
        (call/cc
            (lambda (cc)
                (for-each (lambda (e) (if (p e) (cc #t))) l)
                #f)))
    (define (index l v eq)
        (unless (list? l)
            (raise-contract-error 'ormap "list?" l))
        (let loop ((i 0) (l l))
            (if (null? l)
                #f
                (let ((f (car l)) (r (cdr l)))
                    (if (eq f v)
                        i
                        (loop (+ i 1) r))))))
)