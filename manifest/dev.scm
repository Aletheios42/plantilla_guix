(use-modules (guix packages)
             (guix profiles)
             (gnu packages))

(define base-manifest
  (load "base.scm"))

(define dev-packages
  (map specification->package
       '(;; TODO: añadir linter específico del lenguaje
         ;; TODO: añadir depurador
         ;; TODO: añadir framework de testing
         )))

(define dev-manifest
  (combine-manifests
   (list base-manifest
         (packages->manifest dev-packages))))

dev-manifest
