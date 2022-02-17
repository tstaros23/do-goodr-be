## Do Goodr Backend ##
Do Goodr Backend is a back-end application that exposes an API to support the user-facing application which allows individuals to find volunteer opportunities within their area. The exposed API will allow front-end developers to display users, organizations and events. Users will be able to search via zip code.

The goal of this project was to deploy a service-oriented architecture to expose an API that would satisfy the front-end team’s requirements.

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
- SMTP-configured email server if email support is desired.

### Installation ###
1. Fork & clone this repo.
2. Run `bundle install` to install gem packages.
3. Run `rails db:{drop,create,migrate}` to set up the database.
4. Run `bundle exec figaro install` then add your API key to the `config/application.yml` file as: `MAPQUEST_API_KEY` for MapQuest. To use mailer functionality, Redis and email variables will need to be defined as well, with the following keys: `REDIS_PROVIDER`, `MAILER_EMAIL`, and `MAILER_PASSWORD`. `config/environments/production.rb` & `development.rb` may also need to be configured with your email server's needs.
5. To consume Do Goodr endpoints locally, run `bundle exec sidekiq`, `redis-server`, and `rails s` (all as different procceses) and navigate to `localhost:3000`. 

### Endpoints ###
*Notes:*

*The application is fully deployed and can be accessed using `https://do-goodr-be.herokuapp.com` as the base URL, in addition to the locally-hosted option described above. In addition, this document describes endpoints that are not currently being consumed by the Do Goodr front-end application, to allow for future growth.*

*Dynamic segments of the URI are show is a preceeding colon, as `/:dynamic_segment`. These would need to be replaced with the appropriate corresponding segment, typically an event or organization id, such as `/1`. For visual clarity, query params are show detached from the URI and without supplying the values, but should be enchained with URL/URI, with values defined, as shown in this example: `https://do-goodr-be.herokuapp.com/api/v1/search?zip=80214&distance=10`. Any date/time params should be supplied as `YYYY-MM-DD HH:MM`*

*Categories for events are defined as `enum category: {"Nursing Home" => 0, "Grounds Cleanup" => 1, "Animal Care" => 2, "Campaigning" => 3, "Food Service" => 4, "Youth Mentorship" => 5, "Community Development" => 6, "Healthcare" => 7, "Other" => 8}`. Either the string or the integer may be used when referring to categories.*


**Events**
  
Request GET `/api/v1/events` to return all events. 
Accepts no query params.
  
Sample Response:

```
{
    "type": "event",
    "data": [
        {
            "id": 2,
            "organization_id": 1,
            "organization_name": "Ocean United",
            "name": "Beach Cleanup",
            "category": "Grounds Cleanup",
            "address": "1 Alki Beach Rd, Alki Beach, Seattle, WA 98101",
            "phone": "(555)456-4564",
            "description": "Description: We are looking for volunteers to help clean up the litter and large chunks of seaweed on the shores of Alki Beach. During low tide, the trash is really prevalent. We will have garbage bags and gloves for volunteers. Since we are outside, masks are not needed.",
            "vols_required": 20,
            "date": "06/16/2023",
            "start_time": "08:30 AM",
            "end_time": "10:30 AM"
        },
        {
            "id": 4,
            "organization_id": 2,
            "organization_name": "Habitat for Humanity",
            "name": "Build a Home",
            "category": "Community Development",
            "address": "3245 Eliot St, Denver CO 80211",
            "phone": "(928)778-7857",
            "description": "Construction volunteers make a tangible difference with each and every day they help build and repair homes. No construction experience is necessary. Many first-time volunteers have never picked up a hammer!",
            "vols_required": 25,
            "date": "02/23/2022",
            "start_time": "12:00 PM",
            "end_time": "05:00 PM"
        },
        ADDITIONAL RESPONSES DELETED FOR BREVITY
    ]
}
```

Request GET `/api/v1/events/:event_id` to return a specific event.
Accepts no query params. 

Sample Response:

```
{
    "type": "event",
    "data": [
        {
            "id": 8,
            "organization_id": 3,
            "organization_name": "Denver Animal Shelter",
            "name": "Shelter Dog Walking",
            "category": "Animal Care",
            "address": "12 Paws Lane Denver CO 80203",
            "phone": "9287787857",
            "description": "We are short staffed and looking for dog lovers to kindly walk the shelter dogs the morning of the 22nd. The dogs are in need of attention, love and exercise. We greatly appreciate it!",
            "vols_required": 4,
            "date": "09/22/2022",
            "start_time": "06:00 AM",
            "end_time": "09:00 AM"
        }
    ]
}
```
 
Request POST `/api/v1/events` to create a new event.
Query params: `?organization_id=&name=&category=&address=&description=&phone=&vols_required&start_time=&end_time=`.

Response returns the created event.


Request PATCH `/api/v1/events/:event_id` to edit an event.
Query params: `?organization_id=&name=&category=&address=&description=&phone=&vols_required&start_time=&end_time=`.

Response returns the edited event.

 
Request DELETE `/api/v1/events/:event_id` to delete an event. 
Accepts no query params.

Response returns the deleted event.


**Organizations**

Request GET `/api/v1/organizations` to return all organizations.
Accepts no query params.

Sample Response:

```
{
    "type": "organization",
    "data": [
        {
            "id": 1,
            "name": "Ocean United",
            "location": "567 Nirvana Ave Seattle WA 98101",
            "phone": "(435) 985-7264",
            "email": "oceanunited@email.com"
        },
        {
            "id": 2,
            "name": "Habitat for Humanity",
            "location": "3245 Eliot St, Denver CO 80211",
            "phone": "(928) 778-7857",
            "email": "habitatforhumanity@email.com"
        },
        ADDITONAL RESPONSES DELETED FOR BREVITY
    ]
}
```

 
Request GET `/api/v1/organizations/:organization_id` to return a specific organization.
Accepts no query params.

Sample Response:

```
{
    "type": "organization",
    "data": [
        {
            "id": 6,
            "name": "Goodwill",
            "location": "21 S Broadway, Denver, CO 80209",
            "phone": "(928) 778-7857",
            "email": "goodwill@email.com"
        }
    ]
}
```


Request GET `/api/v1/organizations/:organization_id/events` to return all events associated with a specific organization.
Accepts no query params.


Request POST `/api/v1/organizations/` to create a new organization.
Query params: `?name=&location=&phone=&email=`.

Returns the created organization.


Request PATCH `/api/v1/organizations/:organization_id` to create a new organization.
Query params: `?name=&location=&phone=&email=`.

Returns the edited organization.

 
Request DELETE `/api/v1/organizations/:organization_id` to delete a new organization.
Accepts no query params.

Returns the deleted organization.


**Search**

Request GET `/api/v1/search` returns events within given radius from zip, ordered from closest.
Query params: `?zip=&distance=`.
 
Sample Response:

```
{
    "type": "event",
    "data": [
        {
            "id": 6,
            "distance": 4.186,
            "organization_id": 4,
            "organization_name": "American Red Cross",
            "name": "Blood Drive",
            "category": "Healthcare",
            "address": "5280 Wadsworth Blvd, Arvada CO 80002",
            "phone": "(928)778-7857",
            "description": "The need for blood is universal, but access to blood for all those who need it is not. Blood shortages are particularly acute in developing countries. To ensure that everyone who needs safe blood has access to it, all countries need voluntary, unpaid donors who give blood regularly.  Please join us for this blood drive and make an impact!",
            "vols_required": 50,
            "date": "10/07/2022",
            "start_time": "12:00 PM",
            "end_time": "05:00 PM"
        },
        {
            "id": 4,
            "distance": 4.463,
            "organization_id": 2,
            "organization_name": "Habitat for Humanity",
            "name": "Build a Home",
            "category": "Community Development",
            "address": "3245 Eliot St, Denver CO 80211",
            "phone": "(928)778-7857",
            "description": "Construction volunteers make a tangible difference with each and every day they help build and repair homes. No construction experience is necessary. Many first-time volunteers have never picked up a hammer!",
            "vols_required": 25,
            "date": "02/23/2022",
            "start_time": "12:00 PM",
            "end_time": "05:00 PM"
        }
    ]
}
```
 

### Contacts ###
- Matt Holmes     |  [Github](https://github.com/matthewjholmes)   |   [LinkedIn](https://www.linkedin.com/in/matthew-j-holmes/)
- Ted Staros      |  [Github](https://github.com/matthewjholmes)   |   [LinkedIn](https://www.linkedin.com/in/ted-staros/)

**Acknowledgements**
Do-Goodr Front End Team:
- Adam Burgess
- Colgan Meanor
- Michele Comfort

Map Quest API


