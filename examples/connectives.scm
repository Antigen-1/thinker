(import (data expand))
(install-connective! '=> (lambda (A B) `(or (not ,A) ,B)))
(install-connective! '<=> (lambda (A B) `(and (or (not ,A) ,B) (or (not ,B) ,A))))