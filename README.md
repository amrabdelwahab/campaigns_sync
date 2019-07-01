# Campaign Sync project

## Introduction

This project is meant to solve the exercise [specified here](https://github.com/heyjobs/ruby-task).

## Prerequisites

For this project to run locally you need to have docker daemon and docker-compose installed on your machine.

## Setup

* Clone the project
* cd into the project directory
* Run `make setup`

## Run specs
Either
* Run `make test` 
Or
* Run `make dev`
* Run `rspec`

## Run the script to get an output based on mock data
* Run `make run`

## Assumptions

This code is written under the following assumptions:
* The exercise does not require building the database adapter or API client, in order to switch the current all you need to do is implement a new data_source class and use it in its relevant repository.
* Both sources have no missing items, so all the ads in one source exists in the other source and vice verca.

