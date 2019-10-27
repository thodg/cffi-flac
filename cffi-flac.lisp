
(in-package :cffi-flac)

(define-foreign-library libflac
  (t (:default "libFLAC")))

(use-foreign-library libflac)

(defcfun ("FLAC__metadata_get_tags" flac--metadata-get-tags) flac--bool
  (filename :string)
  (tags (:pointer (:pointer (:struct flac--stream-metadata)))))

(defun metadata-get-tags (filename)
  (when (pathnamep filename)
    (setq filename (namestring filename)))
  (let ((tag-strings))
    (with-foreign-object (tags :pointer)
      (flac--metadata-get-tags filename tags)
      (with-foreign-slots ((type is-last length data)
                           (mem-aref tags :pointer)
                           (:struct flac--stream-metadata))
        (with-foreign-slots ((num-comments comments)
                             data
                             (:struct flac--stream-metadata-vorbis-comment))
          (dotimes (i num-comments)
            (with-foreign-slots ((entry)
                                 (mem-aptr comments '(:struct flac--stream-metadata-vorbis-comment-entry) i)
                                 (:struct flac--stream-metadata-vorbis-comment-entry))
              (let* ((entry-string (foreign-string-to-lisp entry))
                     (= (position #\= entry-string))
                     (name (subseq entry-string 0 =))
                     (value (subseq entry-string (1+ =))))
                (push (cons name value) tag-strings)))))))
    tag-strings))
