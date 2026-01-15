(library (parallel solve)
    (export solve)
    (import (rnrs (6)) (ice-9 futures) (srfi srfi-41)
            (data connective) (data primitive) (data node)
            (algo env) (algo eval) (algo label) (algo list)
            (exn contract))
    
    (define (solve prop)
        (unless (node? prop)
                (raise-contract-error 'solve "node?" prop))
        (let*  ((labels (get-labels prop))
                (env-stream (labels->env-stream labels)))
                (filter-map 
                        touch
                        (stream->list (stream-map (lambda (env) (future (if (eval-proposition prop env) env #f))) env-stream)))))
)