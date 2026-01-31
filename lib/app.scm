(library (app)
    (export make-thinker)
    (import (rnrs (6)) (srfi srfi-28) (srfi srfi-69)
            (algo list) (algo label) 
            (data expand) (data parse)
            (data connective) (parallel entail) (exn contract))
    
    (define (check-arguments op args preds hints)
        (unless (= (length args) (length preds))
            (raise-contract-error op (format "~a argument(s)" (length preds)) args))
        (map (lambda (p h a) 
                (unless (p a)
                    (raise-contract-error op h a)))
             preds hints args))

    (define (expand+parse-proposition f)
        (parse-proposition (expand-proposition f)))

    (define (make-thinker)
        (let* ((KB '())
               (op-table (make-hash-table eq?))
               (apply-op (lambda (op . args) 
                            (define record (hash-table-ref op-table op))
                            (apply check-arguments op args (cdr record)) 
                            (apply (car record) args))))
            (hash-table-set! op-table 
                'add 
                (list 
                    (lambda (p)
                        (set! KB (cons (expand+parse-proposition p) KB)))
                    (list expandable-form?) 
                    '("expandable-form?")))
            (hash-table-set! op-table 
                'remove 
                (list (lambda (n) (set! KB (remove/index KB n)))
                      (list (lambda (n) (and (integer? n) (exact? n) (>= n 0) (< n (length KB))))) 
                      (list (format "(and/c exact-integer? (>=/c 0) (</c ~a))" (length KB)))))
            (hash-table-set! op-table 'list (list (lambda () (map unparse-proposition KB)) '() '()))
            (hash-table-set! op-table 'list-prims (list (lambda () (get-labels (apply & KB))) '() '()))
            (hash-table-set! op-table 'entails?
                (list (lambda (r) (entails? (apply & KB) (expand+parse-proposition r))) 
                      (list expandable-form?)
                      (list "expandable-form?")))
            (hash-table-set! op-table 'clear
                (list (lambda () (set! KB '())) '() '()))
            (define op-list (hash-table-keys op-table))
            (lambda (op . args)
                (unless (index op-list op eq?)
                    (raise-contract-error 'thinker (format "~s" (cons 'or/c (map (lambda (op) (list 'quote op)) op-list))) op))
                (apply apply-op op args)))))