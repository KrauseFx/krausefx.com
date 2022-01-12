<h1><a href="https://krausefx.com">krausefx.com</a></h1>

To run the server locally:

- `git clone https://github.com/KrauseFx/krausefx.com`
- `bundle install`
- `bundle exec jekyll serve`
- Open [http://127.0.0.1:4000](http://127.0.0.1:4000)

## Update data & graphs

Update the entries in `./data/data.yml`, and then run

```
bundle exec ruby graphs/update.rb
```
