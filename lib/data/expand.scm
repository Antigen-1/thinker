(library (data expand)
    (export expand-proposition expandable-form? install-connective! list-connectives)
    (import (data parse) (algo pkg) (algo list) (scheme base) (srfi srfi-69) (srfi srfi-28) (exn contract) (exn internal) (ice-9 match))

    (define-values (original-install! get-connective has-connective? original-list-connectives) (make-pkg-manager))

    (define (install-connective! name proc)
        (unless (and (symbol? name) (not (index '(or not and) name eq?)))
            (raise-contract-error 'install-connective! "(and/c symbol? (not/c (or/c 'or 'and 'not)))" name))
        (original-install! 
            name
            (lambda args 
                (let loop ((r (apply proc args)))
                    (cond ((proposition-representation? r) r)
                          ((expandable-form? r) (expand-proposition r))
                          (else (raise-contract-error name "(or/c proposition-representation? expandable-form?)" r)))))))
    (define (list-connectives)
        (append '(and or not) (original-list-connectives)))
    
    (define (expandable-form? f)
        (or (string? f)
            (match f
                (('not c) (expandable-form? c))
                (((or 'and 'or) cs ...) (andmap expandable-form? cs))
                (((? symbol? conn) cs ...) (has-connective? conn))
                (_ #f))))
    (define (expand-proposition f)
        (let loop ((f f))
            (match f
                (((and (or 'and 'or) conn) cs ...)
                 (cons conn (map loop cs)))
                (('not c)
                 (list 'not (loop c)))
                ((? string? v)
                 v)
                (((? symbol? conn) cs ...)
                 (unless (has-connective? conn)
                    (raise-internal-error 'expand-proposition (format "connective ~s not found" conn)))
                 (apply (get-connective conn) cs))
                (form (raise-internal-error 'expand-proposition (format "malformed proposition ~s" form)))))))