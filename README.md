# Docs

## Local setup

##### System requirements

- [Ruby 3.1.1](https://www.ruby-lang.org)
- [Postgres 14](https://www.postgresql.org/)
- [MailHog](https://github.com/mailhog/MailHog)

If using macOS, consider
running [`brew bundle`](https://github.com/Homebrew/homebrew-bundle)
to automate installation of dependencies listen in the [`Brewfile`](Brewfile).

- Create `config/master.key` and paste the key from LastPass.
- Install gems:
  - `./bin/bundle install`
- Ensure Postgres is installed and running.
  - `brew services start postgresql`
  - Ensure you can connect to postgres as your OS user (e.g., `sajad`).
- Create database:
  - `./bin/rails db:create`
- Run migrations:
  - `./bin/rails db:migrate`
- Start dev server:
  - `./bin/dev`