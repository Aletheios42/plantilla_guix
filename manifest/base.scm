(use-modules (guix packages)
             (guix profiles)
             (gnu packages))

(define base-packages
  (map specification->package
       '("coreutils"
         "grep"
         "sed"
         "gawk"
         "findutils"
         "diffutils"
         "patch"
         "tar"
         "gzip"
         "bzip2"
         "xz"
         "glibc-locales")))

(define base-manifest
  (packages->manifest base-packages))

base-manifest
