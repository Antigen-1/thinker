(library (data node)
    (export Node node?)
    (import (rnrs (6)))
    (define-record-type (Node _ node?)))