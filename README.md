# Persona-infra

Infrastructure project of the [persona](https://github.com/pchomond/persona) service. 
Sets up a local QA enviornment to run and test the app[^1]. As of now it contains:
- Initialization of a Postgres instance
- Docker compose to spin up a local Jenkins instance (the controller)
- Image definition of the worker nodes used by Jenkins

## Upcoming enhancements
Upcoming enhancements beyond the normal development cycle include:
- Complete automated Jenkins setup using Jenkins Code as Configuration (JCasS) plugin
- Postgres image security hardening and integration with a secret manager
- Set up of OpenBao for configuration handling and secret management

[^1]: *This repo is intended to be a side-piece to the persona service and showcase a close-to-enterprise-level development environment while maintaining its scope to a manageable level for a local-first project*
