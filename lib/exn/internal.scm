(library (exn internal)
    (export raise-internal-error)
    (import (rnrs (6)) (ice-9 exceptions))
    
    (define (raise-internal-error name msg)
        (raise (make-exception 
                (make-exception-with-origin name)
                (make-exception-with-message msg)
                (make-programming-error)))))