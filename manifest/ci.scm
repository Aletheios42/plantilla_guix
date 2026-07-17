(use-modules (guix packages)
             (guix profiles)
             (gnu packages))

(define base-manifest
  (load "base.scm"))

(define ci-packages
  (map specification->package
       '(;; TODO: añadir linter
         ;; TODO: añadir test runner
         ;; TODO: añadir build tool
         )))

(define ci-manifest
  (combine-manifests
   (list base-manifest
         (packages->manifest ci-packages))))

ci-manifest
