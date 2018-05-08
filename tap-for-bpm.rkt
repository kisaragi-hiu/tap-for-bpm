#lang racket
(require srfi/19
         data/collection)

;; Key functions:
;;     (click)
;;       Saves a Tap in the current list, triggered by a keypress.
;;     (calculate-bpm beats duration-in-ms)
;;       (* (/ beats duration-in-ms) ; beats per milisecond
;;          60000) milisecond -> minute
;;     (clear)
;;       Clear current-taps

(define current-taps (make-parameter '()))
(struct Tap (time key))

(define (Tap-delta . taps)
  (define sorted-taps (sort taps time<? #:key Tap-time))
  (time-difference (first sorted-taps) (last sorted-taps)))

(define (click [key #f])
  (current-taps (conj (current-taps)
                      (Tap (current-time) key))))

(define (calculate-bpm beats duration-in-ms)
  ;; duration is in miliseconds
  (* 60000 (/ beats duration-in-ms)))
