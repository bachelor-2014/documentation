all: report_format.pdf image_stitching_algorithms.pdf

report_format.pdf: report_format.md
	pandoc report_format.md -o report_format.pdf

image_stitching_algorithms.pdf: image_stitching_algorithms.md
	pandoc image_stitching_algorithms.md -o image_stitching_algorithms.pdf