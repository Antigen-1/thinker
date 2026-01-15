(library (parallel solve)
    (export solve)
    (import (rnrs (6)) (ice-9 futures) (srfi srfi-41)
            (data connective) (data primitive)
            (algo env) (algo eval) (algo label) (algo list)
            (exn contract))
    
    (define (solve prop)
        (unless (or (and? prop) (or? prop) (not? prop) (primitive? prop))
                (raise-contract-error 'solve "(or/c (and? prop) (or? prop) (not? prop) (primitive? prop))" prop))
        (let*  ((labels (get-labels prop))
                (env-stream (labels->env-stream labels)))
                (filter-map 
                        touch
                        (stream->list (stream-map (lambda (env) (future (if (eval-proposition prop env) env #f))) env-stream)))))
)