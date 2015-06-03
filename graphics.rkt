#lang racket/gui
(require "array.rkt")
(require "knn-digits.rkt")

(define grid (make-array 32 32 0))

(define (clip minn n maxx)
  (min (max minn n) maxx))

(define (get-mouse-buttons) 
  (let-values ([(__ buttons) (get-current-mouse-state)])
    buttons))

(define frame (new frame% [label "Example"] [width 360] [height 360]))
 
(send frame show #t)

; TODO: only calculate w-with & w-height when the window is stretched)

(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; mouse events
    (define/override (on-event event)
      (when (and (send event dragging?)
                 (member 'left (get-mouse-buttons)))
          (send dc set-brush "red" 'solid)
          (send dc set-pen "black" 0 'transparent)
          (let* ([w-width (send canvas get-width)]
                 [w-height (send canvas get-height)]
                 [mouse-x (send event get-x)]
                 [mouse-y (send event get-y)]
                 [b-width (quotient w-width 32)]
                 [b-height (quotient w-height 32)]
                 [row (quotient mouse-y b-width)]
                 [col (quotient mouse-x b-height)])
            (for ([row (in-list (list (- row 1) row (+ row 1) row row))]
                  [col (in-list (list col col col (- col 1) (+ col 1)))])
              (let ([row (clip 0 row 31)]
                    [col (clip 0 col 31)])
                (array-set! grid row col 1)
                (send dc draw-rectangle (* col b-width) (* row b-height)
                                        b-width b-height))))))
    ; keyboard events
    (define/override (on-char event)
        (case (send event get-key-code)
          [(#\r) (set! grid (make-array 32 32 0))
                 (send dc clear)]
          [(#\g) (send dc set-scale 2 2)
                 (send dc set-text-foreground "black")
                 (send dc draw-text
                       (format "guess: ~a" (knn-digits (array->list grid)))
                       0 0)
                 (send dc set-scale 1 1)]))
    (super-new)))
 
(define canvas (new my-canvas% [parent frame]))

(define dc (send canvas get-dc))
