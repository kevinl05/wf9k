# Weather Forecaster 9000

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.6.3.-p62]
- Rails [5.2.4.3]
- Postgresql [12]

##### 1. Check out the repository

```bash
git clone git@github.com:kevinl05/wf9k.git
```

##### 2. Create database.yml file

Modify the database.yml file and edit the database configuration as required.

```bash
vi config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000
