(import (data connective) (data primitive) (parallel entail) (srfi srfi-64))

(test-begin "entail")
(test-assert (not (entails? (& (Prim "A") (|| (Prim "B") (! (Prim "C")))) (& (Prim "A") (! (Prim "C"))))))
(test-assert (entails? (& (Prim "A") (|| (Prim "B") (! (Prim "C")))) (Prim "A")))
(test-end "entail")