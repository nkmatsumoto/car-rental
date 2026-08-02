# Changelog

All notable project and production-infrastructure changes are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). This application does not currently publish semantic version tags.

## [Unreleased]

### Added

- Production deployment and migration runbook.
- Expanded local setup, production environment, and release documentation.

## [2026-08-02] — Render and Neon migration

### Added

- Free Render Docker Web Service in Ohio.
- `render.yaml` Blueprint configuration targeting `master`.
- Rails health endpoint at `/up` for Render health checks.
- Neon Free PostgreSQL 16 database named `car_rental` with the dedicated `car_rental_owner` role.
- Independent Heroku PostgreSQL backup and checksum before migration.

### Changed

- Moved production application hosting from Heroku to Render.
- Moved production PostgreSQL from Heroku Postgres to Neon in AWS US East 2.
- Upgraded Ruby from 3.1.2 to 3.3.12.
- Updated Rails from 7.1.3.4 to 7.1.6 and Puma to 6.6.1.
- Updated compatible runtime dependencies, including Devise 4.9.x.
- Configured production database access through `DATABASE_URL`.
- Updated production mailer URLs to use Render's external hostname.
- Hardened the multi-stage Docker image and excluded development and test gems from production.
- Configured the Docker entrypoint to run `bin/rails db:prepare` before starting the server.

### Migrated

- Preserved 14 users, including all authentication hashes.
- Preserved 21 cars and 2 bookings with their statuses.
- Preserved 97 Active Storage blobs and 97 attachments backed by Cloudinary.
- Verified schema migrations, sequences, indexes, and five foreign keys.
- Verified authentication, booking workflows, Mapbox maps, and Cloudinary image delivery on Render.

### Security

- Kept database credentials, Cloudinary credentials, Mapbox keys, and Rails secrets out of Git.
- Configured production credentials as Render environment secrets.

### Removed

- Removed the empty default Neon `neondb` database and `neondb_owner` role after the production database was verified.

### Retained

- Retained Heroku resources pending separate, explicit cleanup authorization.
