dc=docker-compose -f ./docker/docker-compose.yml $(1)
dc-run=$(call dc, run --rm web $(1))

usage:
	@echo "Available targets:"
	@echo "  * setup        		  - Initiates everything (building images, installing gems, creating db and migrating"
	@echo "  * build        		  - Build image"
	@echo "  * bundle       		  - Install missing gems"
	@echo "  * dev          		  - Fires a shell inside your container"
	@echo "  * run           		  - Runs the script"
	@echo "  * tear-down    		  - Removes all the containers and tears down the setup"
	@echo "  * stop         		  - Stops the server"
	@echo "  * test         		  - Runs rspec"

setup: build bundle


build:
	$(call dc, build)
bundle:
	$(call dc-run, bundle install)
dev:
	$(call dc-run, ash)
run:
	$(call dc, up)
tear-down:
	$(call dc, down)
stop:
	$(call dc, stop)
lint:
	$(call dc-run, bundle exec rubocop -a)

.PHONY: test
test:
	$(call dc-run, bundle exec rspec)
