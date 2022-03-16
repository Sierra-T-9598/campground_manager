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

- Testing: 
 - `rspec-rails`
 - `pry`
 - `capybara`
 - `simplecov`
 - `webmock`
 - `vcr`

- API: 
  - `jsonapi-serializer`

----------

## Database Schema

----------

## Getting Started

### Repository Set Up
On your local system, open a terminal session to run the following commands:
1. Clone this repository `$ git clone git@github.com:Sierra-T-9598/whether_sweater.git`
2. Navigate to the newly cloned directory `$ cd whether_sweater`
3. If bundler is not installed run `$ gem install bundler`
4. If or after bundler is installed run `$ bundle install` to install the required Gems
5. If errors occur, check for proper installation and versions of `bundler`, `ruby`, and `rails`
6. Set up the database locally with `$ rails db:{:drop,:create,:migrate,:seed}`
7. RAKE TASK HERE
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

## API
Available endpoints

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/99ba3fb57c77a60e7249?action=collection%2Fimport)

### Campground Endpoints

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /forecast | location| Returns current, daily, and hourly weather data for the given location | /api/v1/forecast?location=bozeman,mt |

Data sourced from [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) and [OpenWeather One Call API](https://openweathermap.org/api/one-call-api)

<details>
    <summary> JSON response examples </summary>

Forecast by location:
  ```
  { "data": { 
      "id":null,
      "type":"forecast",
      "attributes": { 
            "current_weather": {
                  "date_time":"12:28 PM, March 08, -0700",
                  "sunrise":"06:49 AM, March 08, -0700",
                  "sunset":"06:20 PM, March 08, -0700",
                  "temperature":19.87,
                  "feels_like":11.79,
                  "humidity":73,
                  "uvi":2.56,
                  "visibility":10000,
                  "conditions":"overcast clouds",
                  "icon":"04d"},
           "daily_weather": [
              { 
                  "date":"08-03-2022",
                  "sunrise":"06:49 AM, March 08, -0700",
                  "sunset":"06:20 PM, March 08, -0700",
                  "max_temp":24.15,
                  "min_temp":6.08,
                  "conditions":"snow",
                  "icon":"13d"
              },
              {
                  "date":"09-03-2022",
                  "sunrise":"06:48 AM, March 09, -0700",
                  "sunset":"06:21 PM, March 09, -0700",
                  "max_temp":12.7,
                  "min_temp":-5.71,
                  "conditions":"overcast clouds",
                  "icon":"04d"
              },
              {
                  "date":"10-03-2022",
                  "sunrise":"06:46 AM, March 10, -0700",
                  "sunset":"06:22 PM, March 10, -0700",
                  "max_temp":19.89,
                  "min_temp":-5.62,
                  "conditions":"overcast clouds",
                  "icon":"04d"
              },
              {
                  "date":"11-03-2022",
                  "sunrise":"06:44 AM, March 11, -0700",
                  "sunset":"06:24 PM, March 11, -0700",
                  "max_temp":31.68,
                  "min_temp":11.97,
                  "conditions":"light snow", 
                  "icon":"13d"
              },
              {
                  "date":"12-03-2022",
                  "sunrise":"06:42 AM, March 12, -0700",
                  "sunset":"06:25 PM, March 12, -0700",
                  "max_temp":40.44,
                  "min_temp":24.53,
                  "conditions":"overcast clouds",
                  "icon":"04d"
              }
            ],
            "hourly_weather": [
                {"time":"12:00 PM","temperature":19.87,"conditions":"light snow","icon":"13d"},
                {"time":"01:00 PM","temperature":20.01,"conditions":"light snow","icon":"13d"},
                {"time":"02:00 PM","temperature":20.16,"conditions":"light snow","icon":"13d"},
                {"time":"03:00 PM","temperature":20.07,"conditions":"light snow","icon":"13d"},
                {"time":"04:00 PM","temperature":19.62,"conditions":"light snow","icon":"13d"},
                {"time":"05:00 PM","temperature":18.25,"conditions":"light snow","icon":"13d"},
                {"time":"06:00 PM","temperature":16.23,"conditions":"light snow","icon":"13d"},
                {"time":"07:00 PM","temperature":14.02,"conditions":"light snow","icon":"13n"}
            ]
          }
        }
      }
```

</details>


### Campsite Endpoints

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /backgrounds | location| Returns an image from the given location | /api/v1/backgrounds?location=bozeman,mt |

Data sourced from [Unplash API](https://unsplash.com/developers)

<details>
  <summary> JSON response examples </summary>

Background Image:
  
  ```
  {
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "location": "chicago,IL",
            "description": "white and brown concrete building",
            "urls": {
                "raw": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1",
                "full": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?crop=entropy&cs=srgb&fm=jpg&ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1&q=85",
                "regular": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1&q=80&w=1080",
                "thumb": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1&q=80&w=200"
            },
            "photographer_credit": {
                "name": "Dylan LaPierre",
                "bio": null,
                "portfolio": "https://api.unsplash.com/users/drench777/portfolio"
            }
        }
    }
}
```

</details>
