current_dir := $(shell pwd)
helm3_image := docker.io/baloisegroup/helm:v3.12.3
helm_command := docker run --rm -w /apps/ -v $(current_dir):/apps $(helm3_image)
tests_args := $(shell find tests/**/test.yaml | sed 's:tests/:-f tests/:g')

test:
	$(helm_command) unittest $(tests_args) .

test-update:
	$(helm_command) unittest -u $(tests_args) .

template:
	$(helm_command) template -f values.yaml -f .values-example.yaml example-app .
