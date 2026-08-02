# Production deployment and migration

This runbook documents the current Render and Neon production environment. Never paste credentials, database passwords, connection URLs, Rails keys, or API keys into issues, pull requests, logs, or Git.

## Architecture

| Component | Production service |
| --- | --- |
| Source repository | `nkmatsumoto/car-rental`, branch `master` |
| Rails application | Free Render Docker Web Service, Ohio |
| PostgreSQL | Neon Free, PostgreSQL 16, AWS US East 2 |
| Production database | `car_rental`, owned by `car_rental_owner` |
| Image storage | Cloudinary through Active Storage |
| Maps and geocoding | Mapbox |
| Health endpoint | `GET /up` |

The Render service uses the repository's multi-stage `Dockerfile`. Its entrypoint runs `bin/rails db:prepare` before starting Rails, which applies pending migrations safely during deployment.

## Render configuration

The version-controlled service definition is [`render.yaml`](../render.yaml):

- runtime: Docker
- plan: Free
- region: Ohio
- source branch: `master`
- health check: `/up`
- automatic deployment: off

Configure these values as secret environment variables in the Render dashboard:

- `DATABASE_URL`
- `CLOUDINARY_URL`
- `MAPBOX_API_KEY`
- `SECRET_KEY_BASE`
- `RAILS_MASTER_KEY` only if encrypted Rails credentials are used

Render supplies `RENDER_EXTERNAL_HOSTNAME` and `PORT` automatically. Do not duplicate or hard-code them.

## Deploying a release

1. Merge the reviewed pull request into `master`.
2. Open the `car-rental` Web Service in Render.
3. Confirm **Settings → Build → Branch** is `master`.
4. Select **Manual Deploy → Deploy latest commit**.
5. Confirm the deployment checks out the expected `master` commit.
6. Wait until the deployment status is **Live** and `/up` returns HTTP 200.
7. Run the production smoke tests below.

Free Render services can spin down after inactivity, so the first request may take up to approximately one minute.

## Production smoke tests

After every deployment, verify:

1. The home page and `/cars` load successfully.
2. Search returns matching cars.
3. A car detail page displays its Cloudinary images.
4. The Mapbox map and marker load.
5. Devise registration and login pages load.
6. An authenticated user can view bookings and submit a valid booking.
7. An owner can view incoming bookings and their statuses.
8. `GET /up` returns HTTP 200.
9. Render logs contain no new application exceptions or database connection errors.

## Database backup and restore

Create a backup before any restore or destructive database operation. Keep the backup outside the repository and record its checksum separately.

Use environment variables or a password manager to supply connection URLs without printing them:

```bash
pg_dump --format=custom --no-owner --no-acl \
  --dbname "$SOURCE_DATABASE_URL" \
  --file car-rental-backup.dump

shasum -a 256 car-rental-backup.dump
```

Restore only into an empty, explicitly verified target database:

```bash
pg_restore --no-owner --no-acl \
  --dbname "$TARGET_DATABASE_URL" \
  car-rental-backup.dump
```

Do not put either connection variable in shell history, chat, screenshots, or repository files.

## Restore verification

Compare the source and target independently after an import:

- schema and migration versions
- table list and table count
- row count for every table
- primary-key sequences
- foreign keys and indexes
- all Devise password hashes present
- cars, bookings, and booking statuses
- Active Storage blobs and attachments
- Cloudinary service names and image delivery
- authenticated user and owner workflows
- Mapbox rendering and geocoding

The 2026-08-02 migration verified these production row counts:

| Table | Rows |
| --- | ---: |
| `users` | 14 |
| `cars` | 21 |
| `bookings` | 2 |
| `active_storage_blobs` | 97 |
| `active_storage_attachments` | 97 |
| `active_storage_variant_records` | 0 |
| `ar_internal_metadata` | 1 |
| `schema_migrations` | 7 |

These counts are a migration record, not permanent expectations; production data will change over time.

## Rollback and cleanup

- Keep the previous production database and an independent backup until the Render deployment and Neon data have been fully verified.
- Do not delete Heroku resources as part of a normal Render deployment.
- Heroku cleanup requires separate, explicit authorization immediately before deletion.
- If a release fails, keep the database intact and redeploy the last known-good commit from Render.
- Never delete the Neon production database or its owner role during application rollback.
