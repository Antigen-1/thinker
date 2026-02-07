(library (thinker parallel entail)
    (export entails?)
    (import (rnrs (6)) (ice-9 futures) (srfi srfi-41)
            (thinker data connective) (thinker data primitive) (thinker data node)
            (thinker algo env) (thinker algo eval) (thinker algo label) (thinker algo list)
            (thinker exn contract))
    
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