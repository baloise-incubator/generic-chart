current_dir := $(shell pwd)
helm3_image := quay.balgroupit.com/library/helm:v3.9.2-2022.07.23-16.44.06
helm_command := docker run --rm -w /apps/ -v $(current_dir):/apps $(helm3_image)
tests_args := $(shell find tests/**/test.yaml | sed 's:tests/:-f tests/:g')

test:
	$(helm_command) unittest -3 $(tests_args) .

test-update:
	$(helm_command) unittest -u -3 $(tests_args) .

template:
	$(helm_command) template -f values.yaml -f .values-example.yaml example-app .
