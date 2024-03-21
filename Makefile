# Set up variables which figure out paths relative to this file
DB_DATA_ETC=$(shell basename `pwd`)_db-data-etc
DB_DATA_VAR=$(shell basename `pwd`)_db-data-var
DIST_PACKAGES=$(shell basename `pwd`)_dist-packages
NEO4J_PLUGINS=$(shell basename `pwd`)_neo4j-plugins
NEO4J_DATA=$(shell basename `pwd`)_neo4j-data
NEO4J_IMPORT=$(shell basename `pwd`)_neo4j-import
NEO4J_EXPORT=$(shell basename `pwd`)_neo4j-export

NB_UID=$(shell id -u)
NB_GID=$(shell id -g)

# There shouldn't be any docker-related data hanging around after this (except for images).
clean: ## Stop and delete all containers and volumes.
	docker compose kill; \
	docker compose rm -f; \
	docker volume rm ${DB_DATA_ETC}; \
	docker volume rm ${DB_DATA_VAR}; \
	docker volume rm ${DIST_PACKAGES}; \
	docker volume rm ${NEO4J_PLUGINS}; \
	docker volume rm ${NEO4J_DATA}; \
	docker volume rm ${NEO4J_IMPORT}; \
	docker volume rm ${NEO4J_EXPORT};


run: ## Normal command for running a dev environment.
	@ echo "${NB_UID}:${NB_GID}"
	export NB_UID=${NB_UID}; \
	export NB_GID=${NB_GID}; \
	docker compose --file docker-compose.yml kill; \
	docker compose --file docker-compose.yml rm -f; \
	docker compose --file docker-compose.yml up --build -d; \
	docker compose --file docker-compose.yml logs --tail 10 --follow;


init-jupyter: ## Build jupyter
	@ echo "${NB_UID}:${NB_GID}"
	export NB_UID=${NB_UID}; \
	export NB_GID=${NB_GID}; \
	docker compose --file docker-compose.yml up --force-recreate --build jupyter


run-jupyter: ## Run jupyter service
	@ echo "${NB_UID}:${NB_GID}"
	export NB_UID=${NB_UID}; \
	export NB_GID=${NB_GID}; \
	docker compose --file docker-compose.yml kill jupyter; \
	docker compose --file docker-compose.yml rm -f jupyter; \
	docker compose --file docker-compose.yml up --build -d jupyter; \
	docker compose --file docker-compose.yml logs --tail 10 --follow jupyter;

	@echo ""
	@echo "Run Jupyter Notebook lab by connecting to http://localhost:8888"


run-neo4j: ## Run Neo4j service
	docker compose --file docker-compose.yml kill neo4j; \
	docker compose --file docker-compose.yml rm -f neo4j; \
	docker compose --file docker-compose.yml up --build -d neo4j; \
	docker compose --file docker-compose.yml logs --tail 10 --follow neo4j;

	@echo ""
	@echo "Connect to Neo4j by navigating to http://localhost:7474"


logs: ## Show logs for all running containers
	docker compose logs --tail 100 --follow


stop: ## Stop containers
	docker compose --file docker-compose.yml stop


kill: ## Kill all containers
	docker compose --file docker-compose.yml kill

destroy: ## Complete wipe of docker
	docker stop $$(docker ps -a -q); \
	docker rm $$(docker ps -a -q); \
	docker rmi $$(docker images -q); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q)


test: ## Run unit tests (Note: not yet implemented here). Requires that containers are running
	docker compose exec db bash -c "sudo -u postgres psql -c 'ALTER USER user CREATEDB;'"
	docker compose exec web python3 manage.py test --keepdb


install-pre-commit: ## Install the pre-commit tool for git
	pip3 install pre-commit
	pre-commit install
	@echo
	@echo "pre-commit has been installed."
	@echo "It will run on any staged files when you 'git commit'"
	@echo
	@echo "To test it without doing a commit, stage some changes then use 'pre-commit run'"
	@echo


.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
