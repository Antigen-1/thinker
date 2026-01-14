(library (data connective)
  (export & || ! and? or? not? children)
  (import (only (srfi srfi-9) define-record-type) (except (rnrs (6)) define-record-type)
	  (exn contract) (data primitive))
  
  (define-record-type And
    (AND children)
    and?
    (children and-children))
  (define-record-type Or
    (OR children)
    or?
    (children or-children))
  (define-record-type Not
    (NOT children)
    not?
    (children not-children))

  (define (check-node-list name l)
    (for-each
     (lambda (n)
       (if
	      (not (or (and? n) (or? n) (not? n) (primitive? n)))
	      (raise-contract-error name "(or/c and? or? not? primitive?)" n)))
     l))
  
  (define (& . c)
    (check-node-list '& c)
    (AND c))
  (define (|| . c)
    (check-node-list '|| c)
    (OR c))
  (define (! c)
    (check-node-list '! (list c))
    (NOT (list c)))
  
  (define (children rc)
    (cond ((and? rc) (and-children rc))
	  ((or? rc) (or-children rc))
	  ((not? rc) (not-children rc))
          (else (raise-contract-error 'children "(or/c and? or? not?)" rc))))
  )

