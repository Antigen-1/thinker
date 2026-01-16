(library (app)
    (export rules->thinker)
    (import (parallel solve) (data node) (data connective) (rnrs (6)) (algo list) (algo consistency) (exn contract))
    
    (define (rules->thinker . r)
        (for-each 
            (lambda (p)
                (unless (node? p)
                    (raise-contract-error 'rules->thinker "node?" p)))
            r)
        (lambda knowledge
            (for-each 
             (lambda (p)
                (unless (node? p)
                    (raise-contract-error 'rules->thinker "node?" p)))
             knowledge)
            (check-consistency (solve (apply & (append r knowledge)))))))