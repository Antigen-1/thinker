(library (data primitive)
  (export Prim primitive? primitive-name)
  (import (except (rnrs (6)) define-record-type) (only (srfi srfi-9) define-record-type)
	  (exn contract))

  (define-record-type primitive
    (make-primitive name)
    primitive?
    (name primitive-name)
    )

  (define (Prim name)
    (if (not (string? name))
	(raise-contract-error 'Prim "string?" name))
    (make-primitive name)))
