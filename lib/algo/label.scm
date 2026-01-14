(library (algo label)
    (export get-labels)
    (import (data connective) (data primitive) (exn contract) (srfi srfi-69) (rnrs (6)))
    
    (define (get-labels node)
        (unless (or (and? node) (not? node) (or? node) (primitive? node)) 
            (raise-contract-error 'get-labels "(or/c not? and? or? primitive?)" node))
        (define table (make-hash-table string=?))
        (let loop ((node node))
            (cond ((primitive? node) (hash-table-set! table (primitive-name node) 0))
                  (else (for-each loop (children node)))))
        (hash-table-keys table))

)