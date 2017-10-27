build-docker:
	docker build -t nikofil/helib-go .

run-docker:
	docker run --rm nikofil/helib-go:latest
