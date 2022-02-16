## Do Goodr Backend ##
Do Goodr Backend a back-end application that exposes an API to support the user-facing application to which allows individuals to find volunteer opportunities near to them. The API exposed will allow front-end developers to show users organizations and events, and to search for them by zip code.

The goal of this project was to deploy a service-oriented architecture to expose an API that satisfied the front-end team’s requirements.

Main functional accomplishments:
Expose an API for CRUD functionality.
Expose an API that uses an external API and internal logic to filter by distance.
Utilize background workers to send confimatory emails to users.
Develop additional functions that support future application growth.

### Prerequisites ###
- Rails 5.2.6
- Ruby 2.7.2
- Sidekiq
- Redis
- API key from Mapquest

- And a SMTP-configured email server if email support is desired.

### Installation ###
Fork & clone this repo.

Run `bundle install` to install gem packages.

Run `rails db:{drop,create,migrate}` to set up the database.

Run `bundle exec figaro install` then add your API key to the config/application.yml file as: MAPQUEST_API_KEY for MapQuest. To use mailer functionality, REDIS and email variables will need to be defined as well, with the following keys: REDIS_PROVIDER, MAILER_EMAIL, MAILER_PASSWORD. `config/environments/production.rb` & `development.rb` may also need to be configured with your email server's needs.

To consume Do Goodr endpoints locally, run `bundle exec sidekiq`, `redis-server`, and `rails s` (all as different procceses) and navigate to `localhost:3000`. 

### Endpoints ###
*Notes:*
*- The application is fully deployed and can be accessed using `https://do-goodr-be.herokuapp.com` as the base URL, in addition to the locally-hosted option described above. In addition, this document describes endpoints that are not currently being consumed by the Do Goodr front-end application, to allow for future growth.*

*- Dynamic segments of the URI are show is a preceeding colon, as `/:dynamic_segment`. These would need to be replaced with the appropriate corresponding segment, typically an event or organization id, such as `/1`. For visual clarity, query params are show detached from the URI and without supplying the values, but should be enchained with URL/URI, with values defined, as shown in this example: `https://do-goodr-be.herokuapp.com/api/v1/search?zip=80214&distance=10`.*

*- Categories for events are defined as `enum category: {"Nursing Home" => 0, "Grounds Cleanup" => 1, "Animal Care" => 2, "Campaigning" => 3, "Food Service" => 4, "Youth Mentorship" => 5, "Community Development" => 6, "Healthcare" => 7, "Other" => 8}`. Either the string or the integer may be used when referring to categories.*

**Events**
  
Request GET `/api/v1/events` to return all events. 
Accepts no query params.
  
Sample Response:

```

```

Request GET `api/v1/events/:event_id` to return a specific event.
Accepts no query params. 

Sample Response:

```

```

 
Request POST `api/v1/events` to create a new event
Query params: `?organization_id=&name=&category=

Sample Response:

```

```

 
Request PATCH `api/v1/events/:event_id` to edit an event

Sample Response:

```

```

 
Request DELETE `api/v1/events/:event_id` to delete an event

Sample Response:

```

```

**Organizations**

Request GET `api/v1/organizations` to return all organizations.

Sample Response:

```

```

 
Request GET `api/v1/organizations/:organization_id` to return a specific organization

Sample Response:

```

```

 
 

Contacts
Matt Holmes
Ted Staros 

Acknowledgements
Do-Goodr Front End Team
API from Map Quest


