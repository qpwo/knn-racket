#lang racket
(require graphics/graphics)

(define WIDTH 640)
(define HEIGHT 480)

(open-graphics)
(define my-viewport
  (open-viewport "Hi!" WIDTH HEIGHT))

(define (clip minn x maxx)
  (min (max minn x) maxx))

(define my-thread
  (let ([drawer (draw-viewport my-viewport)])
    (thread (λ ()
              (do () (#f)
                (let* ([mouse-click (get-mouse-click my-viewport)]
                       [mouse-posn (mouse-click-posn mouse-click)]
                       [mouse-x (clip 0 (posn-x mouse-posn) WIDTH)]
                       [mouse-y (clip 0 (posn-y mouse-posn) HEIGHT)])
                  (drawer (make-rgb (/ mouse-x WIDTH)
                                    (/ mouse-y HEIGHT)
                                    0))))))))

;; OLD CODE ----------------------------------------------------------
;(define-values (mouse-x mouse-y) (values 0 0))
;(define mouse-posn-thread
;  (thread (λ ()
;            (do () (#f)
;              (sleep 1/60)
;              (let ([mouse-posn (query-mouse-posn my-viewport)])
;                (set! mouse-x (clip 0 (posn-x mouse-posn) WIDTH))
;                (set! mouse-y (clip 0 (posn-y mouse-posn) HEIGHT)))))))
;
;(define draw-window-thread
;  (let ([drawer (draw-viewport my-viewport)])
;    (thread (λ ()
;              (do () (#f)
;                (sleep 1/2)
;                (drawer (make-rgb (/ mouse-x WIDTH)
;                                  (/ mouse-y HEIGHT)
;                                  0)))))))
