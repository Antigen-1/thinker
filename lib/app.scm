(library (app)
    (export make-thinker)
    (import (rnrs (6)) (srfi srfi-28) (srfi srfi-69) (ice-9 threads)
            (algo parse) (algo list) (data connective) (parallel entail) (exn contract))
    
    (define (check-arguments op args preds hints)
        (unless (= (length args) (length preds))
            (raise-contract-error op (format "~a argument(s)" (length preds)) args))
        (map (lambda (p h a) 
                (unless (p a)
                    (raise-contract-error op h a)))
             preds hints args))

    (define (make-thinker)
        (let* ((KB '())
               (mutex (make-mutex))
               (op-table (make-hash-table eq?))
               (apply-op (lambda (op . args) 
                            (define record (hash-table-ref op-table op))
                            (apply check-arguments op args (cdr record)) 
                            (apply (car record) args))))
            (hash-table-set! op-table 
                'add 
                (list 
                    (lambda (p)
                        (set! KB (cons (parse-proposition p) KB)))
                    (list proposition-representation?) 
                    '("proposition-representation?")))
            (hash-table-set! op-table 
                'remove 
                (list (lambda (n) (set! KB (remove/index KB n)))
                      (list (lambda (n) (and (integer? n) (exact? n) (>= n 0) (< n (length KB))))) 
                      (list (format "(and/c exact-integer? (>=/c 0) (</c ~a))" (length KB)))))
            (hash-table-set! op-table 'list (list (lambda () (map unparse-proposition KB)) '() '()))
            (hash-table-set! op-table 'lock (list (lambda () (lock-mutex mutex)) '() '()))
            (hash-table-set! op-table 'unlock (list (lambda () (unlock-mutex mutex)) '() '()))
            (hash-table-set! op-table 'entails?
                (list (lambda (r) (entails? (apply & KB) (parse-proposition r))) 
                      (list proposition-representation?)
                      (list "proposition-representation?")))
            (lambda (op . args)
                (apply apply-op op args)))))