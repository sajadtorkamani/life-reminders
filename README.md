# Docs

## Local setup

### System requirements

- [Ruby 3.1.1](https://www.ruby-lang.org)
- [Postgres 14](https://www.postgresql.org/)
- [MailHog](https://github.com/mailhog/MailHog)

If using macOS, consider
running [`brew bundle`](https://github.com/Homebrew/homebrew-bundle)
to automate installation of dependencies listen in the [`Brewfile`](Brewfile).

#### Create `config/master.key`

Create `config/master.key` and paste the key from LastPass.

#### Install gems

```bash
./bin/bundle install
```

#### Configure Postgres

Ensure Postgres is installed and running.

 ```bash
 brew services start postgresql
 
Ensure you can connect to postgres as your OS user (e.g., `sajad`).
 ```

#### Create database

```bash
./bin/rails db:create
```

#### Run migrations:

```bash
./bin/rails db:migrate
```

#### Setup MailHog

Install and start Mailhog

```bash
mailhog
```

#### Start dev server

```bash
./bin/dev
```

### Available scripts

#### `bin/dev`

Start all the processes needed for development. See `Procfile.dev` for details.

#### `bin/test`

Run all RSpec tests in the `spec/` directory.

#### `bin/mailhog`

Opens the MailHog UI at [http://localhost:8025](http://localhost:8025). 

### Deployment

URL: App is hoted at 
[life-reminders.herokuapp.com](https://life-reminders.herokuapp.com/)

#### Ensure environment variables are set

If a change has introduced a dependency on an environment variable, ensure 
that variable is listed in the table below and is configured in Heroku.

| Name                   | Description                                                  |
|------------------------|--------------------------------------------------------------|
| `HOST`                 | Domain where app is hosted.                                  |
| `DEFAULT_SENDER_EMAIL` | The email to be used as the sender for any outgoing emails.  |

#### Push to Heroku

Pushing to `heroku master` will trigger deployment on Heroku.

```bash
git push heroku master
```

#### Run migrations

```bash
heroku run rake db:migrate
```

### Smoke test
Play around with [app](https://life-reminders.herokuapp.com/) to ensure nothing is broken.