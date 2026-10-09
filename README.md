# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Nutr Challenge API

Backend API for the Nutr Challenge application, built with Ruby on Rails.

The API provides the backend services consumed by the [Nutr Challenge Frontend](https://github.com/EmanuelNRodrigues/nutr_challenge_fr).

## Tech Stack

* Ruby on Rails
* PostgreSQL
* Sidekiq for background job processing
* RSpec for testing
* Docker and Docker Compose

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/EmanuelNRodrigues/nutr_challenge_api.git
cd nutr_challenge_api
```

### 2. Configure the environment

Review `compose.yaml` and the application's database configuration.

**Update the GEOCODER_EMAIL to a valid email.**

Do not commit credentials, API keys, or other secrets.

NOTE: In a real app I would use https://github.com/bkeepers/dotenv gem and set them in the .env.development for local use.
On prod level, we could do different approaches:
1. Use the credentials.yml encripted file
2. Pass them via, for example CloudFormation on AWS, storing them in a template project or storing them in a AWS Parameter Store

### 3. Start the application with Docker

```bash
docker compose up --build
```

The Compose configuration exposes the API on port `3000`.

If this is the first run, initialize the database in a separate terminal:

```bash
docker compose exec web bash
```

With this terminal you can setup the database by running:
```bash
rails db:prepare
```

With this terminal you can run the specs by running:
```bash
bundle exec rspec
```

To stop the application:

```bash
docker compose down
```

To stop the application and remove the database volume as well:

```bash
docker compose down -v
```

**Warning:** The last command deletes the persisted PostgreSQL data managed by this Compose project.


## Running Tests

Run the test suite with RSpec:

```bash
bundle exec rspec
```

Add links to Swagger/OpenAPI documentation if available.

## Related Repository

* [Nutr Challenge Frontend](https://github.com/EmanuelNRodrigues/nutr_challenge_fr)

## Notes

* PostgreSQL is used for persistent application data.
* Redis is used by the background job infrastructure.
* Sidekiq runs as a separate service in Docker Compose.
* Environment-specific configuration should be kept outside source control.

