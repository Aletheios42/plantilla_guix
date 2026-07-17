(use-modules (guix packages)
             (guix profiles)
             (gnu packages))

(define base-manifest
  (load "base.scm"))

(define prod-packages
  (map specification->package
       '(;; TODO: añadir dependencias de producción
         )))

(define prod-manifest
  (combine-manifests
   (list base-manifest
         (packages->manifest prod-packages))))

prod-manifest
