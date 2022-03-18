# Campground Manager

#####  RESTful API for managing campground availability and pricing 🏕

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
     <li>
      <a href="#application-description">About This Application</a>
      <ul>
        <li><a href="#versions">Versions</a></li>
        <li><a href="#important-gems">Important Gems</a></li>
        <li><a href="#database-schema">Database Schema</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#repository-set-up">Set Up</a></li>
        <li><a href="#use-of-this-repository">Use of this Repository</a>
    </li>
    </ul>
    <li>
      <a href="#api">API</a>
      <details>
        <summary>Available Endpoints</summary>
        <ul>
          <li><a href="#campground-endpoints">Campground Endpoints</a></li>
          <li><a href="#campsite-endpoints">Campsite Endpoints</a></li>
        </ul>
      </details>
    </li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

----------

## Application Description

This is a Ruby on Rails API built as a take-home tech challenge. The goal is to create an API as a campground management tool to work with availability and pricing. 

----------

### Versions

- `Ruby 2.7.2`
- `Rails 5.2.6`

----------

### Important Gems
- Database:
  - `pg, '>= 0.18', '< 2.0'`

- Development & Testing: 
 - `rspec-rails`
 - `pry`
 - `capybara`
 - `simplecov`
 - `factory_bot_rails`
 - `faker`
 - `shoulda-matchers`


- API: 
  - `jsonapi-serializer`

----------

## Database Schema
  ```
  create_table "campgrounds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```
```
create_table "campsites", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "booked_dates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campground_id"
    t.index ["campground_id"], name: "index_campsites_on_campground_id"
  end
  ```
  ```
create_table "bookings", force: :cascade do |t|
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campsite_id"
    t.index ["campsite_id"], name: "index_bookings_on_campsite_id"
  end
  ```
----------

## Getting Started

### Repository Set Up
On your local system, open a terminal session to run the following commands:
1. Fork & Clone this repository `$ git clone git@github.com:Sierra-T-9598/campground_manager.git`
2. Navigate to the newly cloned directory `$ cd campground_manager`
3. If bundler is not installed run `$ gem install bundler`
4. If or after bundler is installed run `$ bundle install` to install the required Gems
5. If errors occur, check for proper installation and versions of `bundler`, `ruby`, and `rails`
6. Set up the database locally with `$ rails db:{:drop,:create,:migrate}`
7. To seed the development database run `$ rails csv_load:all`  **Note this will load campground and booking CSV data to the database **
  - To seed just the campground csv data: `$ rails csv_load:campgrounds`
8. Open your text editor and check to see that `schema.rb` exists
9. Run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning as expected.

### Use of this Repository

**Backend Server**
 
On your command line:
1. Navigate to the local directory where the backend repo is housed
2. Run `$ rails s` to run the server locally
3. Open a web browser and navigate to http://localhost:3000/ 
4. Here you are able to explore the endpoints exposed by the API!

----------

## API V1
Available endpoints


### Campground Endpoints

| http verb | name | params(optional) | description | example |
| --- | --- | --- | --- | --- |
| GET | /campgrounds | none | Returns all campgrounds | /api/v1/campgrounds |
| GET | /campgrounds/:id | none | Returns a single campground | /api/v1/campgrounds/{{2}}|
| GET | /campgrounds/:id/campsites | none | Returns all sites associated with a campground | /api/v1/campgrounds/{{2}}/campsites |
| POST | /campgrounds | none | Returns a new campground record | /api/v1/campgrounds |
| PATCH | /campgrounds/:id | none | Updates an exisiting campground record | /api/v1/campgrounds/{{2}} |
| DELETE | /campgrounds/:id |none| Deletes a campground record | /api/v1/campgrounds/{{2}} |
| GET | /campgrounds | from, to (both required) | Returns all campgrounds available for the date range | /api/v1/campgrounds?from={date}&to={date} |
| GET | /campgrounds | order | Returns all campgrounds ordered by either `high_to_low` or `low_to_high` | /api/v1/campgrounds?order=high_to_low |

<details>
    <summary> JSON response example </summary>

One Campground:
  ```
  {
    "data": {
        "id": "1",
        "type": "campground",
        "attributes": {
            "name": "Bicentennial Campground",
            "booked_dates": [
                "[\"4/5/22\", \"4/6/22\", \"5/5/22\"], 01",
                "[\"5/5/22\", \"5/6/22\", \"5/7/22\"], 02",
                "[\"5/7/22\", \"5/8/22\"], 03"
            ],
            "price_range": "$33.0 to $35.0"
        }
    }
}
```

</details>


### Campsite Endpoints

| http verb | name | description | example |
| --- | --- | --- | --- |
| GET | /campsites |  Returns all campsites | /api/v1/campsites |
| GET | /campsites/:id | Returns a specific campsite | /api/v1/campsites/{{2}} |
| POST | /campsites | Returns new campsite record | api/v1/campsites |
| PATCH | /campsites/:id | Returns updated campsite record | api/v1/campsites/{{2}} |
| DELETE | /campsites/:id | Deltes a campsite record | api/v1/campsites{{2}} |


<details>
  <summary> JSON response examples </summary>

One Campsite:
  
  ```
  {
    "data": {
        "id": "2",
        "type": "campsite",
        "attributes": {
            "name": "02",
            "booked_dates": [
                "5/5/22",
                "5/6/22",
                "5/7/22"
            ],
            "price": 33.0
        }
    }
}
```

</details>

## Contributors 
🌞 Sierra Tucker - [LinkedIn](https://www.linkedin.com/in/sierra-tucker-a254201a8/)
