(import (data expand))
(install-connective! '=> (lambda (A B) `(or (not ,(expand-proposition A)) ,(expand-proposition B))))
(install-connective! '<=> (lambda (A B) `(and (or (not ,(expand-proposition A)) ,(expand-proposition B)) (or (not ,(expand-proposition B)) ,(expand-proposition A)))))