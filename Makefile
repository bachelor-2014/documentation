all: report_format.pdf

report_format.pdf: report_format.md
	pandoc report_format.md -o report_format.pdf
