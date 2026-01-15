(library (algo label)
    (export get-labels)
    (import (data connective) (data primitive) (data node) (exn contract) (srfi srfi-69) (rnrs (6)))
    
    (define (get-labels node)
        (unless (node? node)
            (raise-contract-error 'get-labels "node?" node))
        (define table (make-hash-table string=?))
        (let loop ((node node))
            (cond ((primitive? node) (hash-table-set! table (primitive-name node) 0))
                  (else (for-each loop (children node)))))
        (hash-table-keys table))

)