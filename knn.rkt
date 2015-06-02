#lang racket
;; k nearest neighbors
;; written by Luke Miles in May/June 2015
;; adapted from http://jeremykun.com/2012/08/26/k-nearest-neighbors-and-handwritten-digit-classification/

;; returns the most common element in a list
(define (mode ls)
  (argmax (λ (elm)
             (count ((curry eq?) elm) ls))
          (remove-duplicates ls)))

(require "n-smallest.rkt")
;; given a list of labeled points, a natural k, and a distance function,
;; return a classifier that takes a point
;; and gives the mode-label of the k nearest neighbors under distance
(define (make-knn-classifier labeled-data k distance)
  (lambda (point)
    (define closest-labeled-points
      (n-smallest k labeled-data
                  (λ (labeled-point)
                     (distance point (cdr labeled-point)))))
    (mode (map car closest-labeled-points))))

;; given a classifier and some labeled points,
;; return the fraction that the classifier labels correctly
(define (test-knn-classifier classifier test-data)
  (/ (count (λ (point) (eq? (car point) (classifier (cdr point))))
            test-data)
     (exact->inexact (length test-data))))

(provide make-knn-classifier test-knn-classifier)
; TODO: add contracts
