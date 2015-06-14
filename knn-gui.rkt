#lang racket
;; Luke Miles, June 2015
(require "n-smallest.rkt")
(require (only-in "knn.rkt" mode [euclidean-distance distance]))

(define points
  (make-parameter
    (call-with-input-file "data/gui.txt"
      (λ (in) (port->list read in)))))

(define (add-point labeled-point)
  (with-output-to-file "data/gui.txt" #:exists 'append
    (λ () (display "\n")
          (write labeled-point)
          (points (cons labeled-point (points))))))

(define (knn-gui point)
  (define closest-labeled-points
    (n-smallest 8 (points)
                (λ (labeled-point)
                  (distance point (car labeled-point)))))
  (mode (map cdr closest-labeled-points)))

(provide points add-point knn-gui)
