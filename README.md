# Template for micro-service in Julia

[![Build Status](https://dev.azure.com/butzist/DevOpsDemo/_apis/build/status/DevOpsDemoTF.DevOpsDemo-template-Julia?branchName=master)](https://dev.azure.com/butzist/DevOpsDemo/_build/latest?definitionId=10&branchName=master)

### Description

Micro-service template to use with my
[DevOpsDemo](https://github.com/DevOpsDemoTF/DevOpsDemo)

### Features

- Build in multi-stage Docker container
- Configuration via environment variables
- State passed to API handlers
- Logging in JSON
- Health-check endpoint
- API/integration tests with docker-compose

### TODO

- Prometheus metrics
- Unit tests with JUnit-compatible output

### Links

- https://docs.microsoft.com/en-us/azure/devops/pipelines/languages/docker?view=azure-devops
