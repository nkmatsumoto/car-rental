# Turbo — rent your dream car today

[Turbo](https://car-rental-rl5y.onrender.com) is a Rails car-rental marketplace for discovering and booking performance cars across Japan.

> The production app runs on Render and uses Neon Postgres. The previous Heroku deployment is no longer the production host.

<img width="1469" alt="Turbo home page" src="https://github.com/user-attachments/assets/e84617b1-ebb1-4daa-bee8-478c097cd549">
<br>
<img width="1470" alt="Turbo car listings" src="https://github.com/user-attachments/assets/9e3563e6-97b9-41f9-82e4-98e0c88b8823">
<br>
<img width="1470" alt="Turbo car details" src="https://github.com/user-attachments/assets/90f97f0f-4338-44a3-aa0c-f7f70e25d72c">
<br>
<img width="1324" alt="Turbo bookings" src="https://github.com/user-attachments/assets/901973e2-457f-4d02-b8da-9299f53952da">

## Features

- Search cars by city, brand, model, or year
- View car details, Cloudinary-hosted photos, and Mapbox locations
- Register and sign in with Devise
- Create bookings and track their status
- List cars and approve or reject bookings as an owner

## Technology

- Ruby 3.3.12
- Rails 7.1.6
- PostgreSQL 16 on Neon
- Docker on a free Render Web Service
- Puma 6.6.1
- Hotwire, Stimulus, Bootstrap, and import maps
- Devise authentication
- Cloudinary image storage
- Mapbox maps and geocoding

## Local development

### Requirements

- Ruby 3.3.12
- PostgreSQL
- Bundler

### Setup

```bash
bundle install
bin/rails db:prepare
```

Create a local `.env` file. Environment files are ignored by Git and must never be committed.

```dotenv
CLOUDINARY_URL=your_cloudinary_url
MAPBOX_API_KEY=your_mapbox_api_key
```

Start the application:

```bash
bin/rails server
```

Run the test suite:

```bash
bin/rails test
```

## Production

The production architecture is:

- **Source:** GitHub `master`
- **Application:** free Render Docker Web Service in Ohio
- **Database:** Neon Free PostgreSQL 16 in AWS US East 2
- **Images:** Cloudinary through Active Storage
- **Maps:** Mapbox
- **Health check:** `GET /up`

Production secrets are configured in Render, not stored in this repository:

| Variable | Purpose |
| --- | --- |
| `DATABASE_URL` | Neon PostgreSQL connection URL |
| `CLOUDINARY_URL` | Cloudinary credentials and cloud name |
| `MAPBOX_API_KEY` | Mapbox browser and geocoding access |
| `SECRET_KEY_BASE` | Rails production cookie and message encryption |
| `RAILS_MASTER_KEY` | Only required when encrypted Rails credentials are used |

The Render service is defined in [`render.yaml`](render.yaml). Automatic deploys are disabled, so changes merged into `master` are released with **Manual Deploy → Deploy latest commit** in Render.

See [Production deployment and migration](docs/DEPLOYMENT.md) for setup, release, restore, verification, and rollback procedures.

## Migration status

The application and its data were migrated from Heroku to Render and Neon on 2026-08-02. Users, authentication hashes, cars, bookings, images, database constraints, and sequences were verified after the move. Heroku resources were intentionally retained pending separate cleanup authorization.

See [CHANGELOG.md](CHANGELOG.md) for the complete change history.

## Team

- [Nicholas Matsumoto](https://www.linkedin.com/in/nicholas-matsumoto-18596a7b/)
- [Chaewan Shin](https://github.com/chaeshin)
- [Ryo Imaoka](https://github.com/rimaoka18)

## Contributing

Pull requests are welcome. For major changes, open an issue first to discuss the proposed change.

## License

This project is licensed under the MIT License.
