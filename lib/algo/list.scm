(library (algo list)
    (export andmap ormap insert-last)
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
)