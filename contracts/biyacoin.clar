;; Biyacoin - a simple SIP-010-style fungible token implemented with Clarity built-ins
;; This contract exposes standard read-only views and a transfer entrypoint.

(define-fungible-token BIYA)

(define-constant ERR-UNAUTHORIZED u100)

;; --- SIP-010 view functions ---
(define-read-only (get-name)
  (ok "Biyacoin")
)

(define-read-only (get-symbol)
  (ok "BIYA")
)

(define-read-only (get-decimals)
  (ok u6)
)

(define-read-only (get-balance-of (who principal))
  (ok (ft-get-balance BIYA who))
)

(define-read-only (get-total-supply)
  (ok (some (ft-get-supply BIYA)))
)

(define-read-only (get-token-uri)
  (ok (some u"https://example.com/biyacoin/metadata.json"))
)

;; --- public entrypoints ---
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (try! (ft-transfer? BIYA amount sender recipient))
    (ok true)
  )
)
