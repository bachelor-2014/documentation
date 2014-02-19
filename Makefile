all: arwen_requirements.pdf choice_of_language.pdf group_agreement.pdf image_stitching_algorithms.pdf microscope.pdf

%.pdf: %.md
	pandoc -o $@ $^

#arwen_requirements.pdf: arwen_requirements.md
#	pandoc arwen_requirements.md -o arwen_requirements.pdf
#
#choice_of_language.pdf: choice_of_language.md
#	pandoc choice_of_language.md -o choice_of_language.pdf
#
#group_agreement.pdf: group_agreement.md
#	pandoc group_agreement.md -o group_agreement.pdf
#
#image_stitching_algorithms.pdf: image_stitching_algorithms.md
#	pandoc image_stitching_algorithms.md -o image_stitching_algorithms.pdf
#
#microscope.pdf: microscope.md
#	pandoc microscope.md -o microscope.pdf
#
#report_format.pdf: report_format.md
#	pandoc report_format.md -o report_format.pdf
