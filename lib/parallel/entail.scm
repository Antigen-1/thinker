(library (parallel entail)
    (export entails?)
    (import (rnrs (6)) (ice-9 futures) (srfi srfi-41)
            (data connective) (data primitive) (data node)
            (algo env) (algo eval) (algo label) (algo list)
            (exn contract))
    
    (define (entails? KB prop)
        (unless (node? KB)
                (raise-contract-error 'solve "node?" prop))
        (unless (node? prop)
                (raise-contract-error 'solve "node?" prop))
        (let*  ((labels (get-labels (& KB prop)))
                (env-stream (labels->env-stream labels)))
                (andmap
                        touch
                        (stream->list (stream-map 
                                        (lambda (env) 
                                                (future (or (not (eval-proposition KB env)) (eval-proposition prop env)))) 
                                        env-stream)))))
)