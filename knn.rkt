#lang racket
;; Luke Miles, June 2015

(define (euclidean-distance p1 p2)
  (sqrt (for/sum ([x1 p1] [x2 p2]) (expt (- x1 x2) 2))))

;; returns the most common element in a list
(define (mode ls)
  (argmax (λ (elm)
             (count ((curry eq?) elm) ls))
          (remove-duplicates ls)))

(require "n-smallest.rkt")
;; given a list of labeled points, a natural k, and a distance function,
;; return a classifier that takes a point
;; and gives the mode-label of the k nearest neighbors under distance
(define (make-knn-classifier labeled-data k [distance euclidean-distance])
  (lambda (point)
    (define closest-labeled-points
      (n-smallest k labeled-data
                  (λ (labeled-point)
                     (distance point (car labeled-point)))))
    (mode (map cdr closest-labeled-points))))

;; given a classifier and some labeled points,
;; return the fraction that the classifier labels correctly
(define (test-classifier classifier test-data)
  (/ (count (λ (point) (eq? (classifier (car point)) (cdr point)))
            test-data)
     (exact->inexact (length test-data))))

(provide (contract-out
           [euclidean-distance (-> (listof real?)
                                   (listof real?)
                                   real?)]
           [mode (-> list any/c)]
           [make-knn-classifier (->* ((listof pair?)
                                      integer?)
                                     ((-> any/c any/c real?))
                                     (-> any/c any/c))]
           [test-classifier (-> (-> any/c any/c)
                                    (listof pair?)
                                    real?)]))
