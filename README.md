## Turbo - Rent your dream car today!

App home: [Turbo - Rent your dream car today!](https://car-rental-1715-bba1fbc9061d.herokuapp.com)
<br><br>
Turbo is a car rental app that allows you to rent super cars in Japan.

<img width="1469" alt="Screenshot 2024-09-03 at 16 13 01" src="https://github.com/user-attachments/assets/e84617b1-ebb1-4daa-bee8-478c097cd549">
<br>
<img width="1470" alt="Screenshot 2024-09-03 at 16 13 36" src="https://github.com/user-attachments/assets/9e3563e6-97b9-41f9-82e4-98e0c88b8823">
<br>
<img width="1470" alt="Screenshot 2024-09-03 at 16 14 34" src="https://github.com/user-attachments/assets/90f97f0f-4338-44a3-aa0c-f7f70e25d72c">
<br>
<img width="1324" alt="Screenshot 2024-09-03 at 16 14 58" src="https://github.com/user-attachments/assets/901973e2-457f-4d02-b8da-9299f53952da">

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Acknowledgements
Inspired by many calisthenics content creators I have been following over the years

## Team Members
- [Nicholas Matsumoto](https://www.linkedin.com/in/nicholas-matsumoto-18596a7b/)
- [Chaewan Shin](https://github.com/chaeshin)
- [Ryo Imakoa](https://github.com/rimaoka18)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
