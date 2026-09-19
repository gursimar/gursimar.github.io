# Gursimran's webpage

## Instructions

### Local deployment

Install the required system packages once:

```bash
sudo apt install ruby-bundler ruby-dev build-essential
```

Install gems inside the project and start Jekyll:

```bash
bundle config set --local path vendor/bundle
bundle install
bundle exec ruby scripts/patch_bibtex_ruby.rb
bundle exec jekyll serve
```

Open <http://127.0.0.1:4000>. Do not use `rake deploy` for local viewing.

#### Ruby 3 and `bibtex-ruby` fix

This legacy site resolves to `bibtex-ruby` 4.4.7. Its `Entry#each` and
`Bibliography#each` methods use implicit `Proc.new` block capture, which Ruby 3
no longer supports. The resulting error is `tried to create Proc object without
a block` while rendering the VAE post.

The tracked `scripts/patch_bibtex_ruby.rb` script updates those two methods in
the project-local gem installation to accept and forward an explicit block.
Run it after a fresh `bundle install`; it is safe to run more than once.

Do not commit `.bundle/` or `vendor/bundle/`. They contain machine-specific,
generated dependencies and are ignored by Git. Commit the Gemfile, lockfile,
compatibility script, and source changes instead.

### Remote source
- `git pull origin source`
- `git add .`
- `git commit -m "blah blah"`
- `git push origin source`
  
### Remote master deployment
- `bundle exec jekyll serve (locally)`
- `rake deploy`

### Rejected! master
- Go to branches on github
- Delete master
- 'rake deploy'


## References
- kramdown
- jekyll-scholar
- mathjax
- logam theme (adapted)

## Maintenance update (August 30, 2026)

- Verified that the site builds successfully with Jekyll.
- Updated the legacy Jekyll and Ruby dependencies for compatibility with the current Ruby environment.
- Added Ruby 3 compatibility handling for the bibliography plugin.
- Removed the CV navigation link.
- Removed the Facebook, Google+, and RSS/Atom links from the site layout and configuration.
- Rebuilt `_site` and verified that the removed links are absent from the generated HTML.
- Kept the generated Atom feed itself; only its visible and metadata links were removed.
