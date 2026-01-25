(library (io)
    (export read-proposition)
    (import (rnrs (6)) (algo parse) (exn contract) (ice-9 binary-ports))
    
    (define (read-proposition port)
        (unless (input-port? port)
            (raise-contract-error 'read-proposition "input-port?" port))
        (define r (read port))
        (if (eof-object? r) r (parse-tree r))))