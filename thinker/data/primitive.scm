(library (thinker data primitive)
  (export Prim primitive? primitive-name)
  (import (rnrs (6)) (thinker data node)
	        (thinker exn contract))

  (define-record-type (primitive make-primitive primitive?)
    (fields (immutable name primitive-name))
    (parent Node))

  (define (Prim name)
    (unless (string? name)
	    (raise-contract-error 'Prim "string?" name))
    (make-primitive name)))
