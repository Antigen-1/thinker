(library (app)
    (export rules->thinker)
    (import (parallel entail) (data node) (data connective) (rnrs (6)) (algo list) (exn contract))
    
    (define (rules->thinker . KB)
        (for-each 
            (lambda (p)
                (unless (node? p)
                    (raise-contract-error 'rules->thinker "node?" p)))
            KB)
        (lambda ps
            (for-each 
             (lambda (p)
                (unless (node? p)
                    (raise-contract-error 'rules->thinker "node?" p)))
             ps)
            (entails? (apply & KB) (apply & ps)))))