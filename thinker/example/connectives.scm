(library (thinker example connectives (1 0))
    (export intall)
    (import (thinker data expand) (rnrs (6)))

    (define (install)
        (install-connective! '=> (lambda (A B) `(or (not ,(expand-proposition A)) ,(expand-proposition B))))
        (install-connective! '<=> (lambda (A B) `(and (=> ,A ,B) (=> ,B ,A))))))