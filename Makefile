all: 
	docker build -t nuvi/deis-workflow-cli:latest .
	docker push nuvi/deis-workflow-cli:latest
