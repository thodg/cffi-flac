(in-package :cffi-flac)

(include "FLAC/format.h")
(include "FLAC/metadata.h")

(ctype flac--metadata-type "FLAC__MetadataType")
(ctype flac--bool "FLAC__bool")
(ctype flac--uint32 "FLAC__uint32")
(ctype flac--uint64 "FLAC__uint64")
(ctype flac--byte "FLAC__byte")

(cstruct flac--stream-metadata-stream-info
         "FLAC__StreamMetadata_StreamInfo"
         (min-blocksize "min_blocksize" :type :unsigned-int)
         (max-blocksize "max_blocksize" :type :unsigned-int)
         (min-framesize "min_framesize" :type :unsigned-int)
         (max-framesize "max_framesize" :type :unsigned-int)
         (sample-rate "sample_rate" :type :unsigned-int)
         (channels "channels" :type :unsigned-int)
         (bits-per-sample "bits_per_sample" :type :unsigned-int)
         (total-samples "total_samples" :type flac--uint64)
         (md5sum "md5sum" :type flac--byte :count 16))

(cstruct flac--stream-metadata-vorbis-comment-entry
         "FLAC__StreamMetadata_VorbisComment_Entry"
         (length "length" :type flac--uint32)
         (entry "entry" :type (:pointer flac--byte)))

(cstruct flac--stream-metadata-vorbis-comment
         "FLAC__StreamMetadata_VorbisComment"
         (vendor-string "vendor_string" :type (:struct flac--stream-metadata-vorbis-comment-entry))
         (num-comments "num_comments" :type flac--uint32)
         (comments "comments" :type (:pointer (:struct flac--stream-metadata-vorbis-comment-entry))))

(cunion flac--stream-metadata-data
        "union { FLAC__StreamMetadata_VorbisComment vorbis_comment }"
        (vorbis-comment "vorbis_comment" :type (:struct flac--stream-metadata-vorbis-comment)))

(cstruct flac--stream-metadata
         "FLAC__StreamMetadata"
         (type "type" :type flac--metadata-type)
         (is-last "is_last" :type flac--bool)
         (length "length" :type :unsigned-int)
         (data "data" :type (:union flac--stream-metadata-data)))
