# Partly taken from https://medium.com/@nielsenramon/automated-deployment-of-jekyll-projects-to-github-pages-using-kickster-and-circle-ci-6ccc0b6cb872#.qxsy1xf1m
# Partly taken from https://github.com/fastlane/docs

# Exit if any subcommand fails.
set -e

echo "Starting deploy to https://krausefx.com"

# Build the docs page locally
bundle exec jekyll build

# Bots need names too
git config --global user.email "krausefx-bot@krausefx.com"
git config --global user.name "KrauseFx-Bot"

# Delete old directories (if any)
rm -rf "/tmp/krausefx.com"
# Copy the generated website to the temporary directory
cp -R "_site/" "/tmp/krausefx.com"

# Check out gh-pages and clear all files
git reset --hard HEAD # we don't want the `git checkout` to cause issues (e.g. https://circleci.com/gh/fastlane/docs/730)
git remote update # needed for CI
git fetch --all # needed for CI
git pull --all # needed for CI
git checkout gh-pages
git pull
rm -rf *
# Copy the finished HTML pages to the current directory
cp -R /tmp/krausefx.com/* .

# We need a CNAME file for GitHub
echo "krausefx.com" > "CNAME"

# We also need a circle.yml file on the gh-pages branch, otherwise the build fails
echo "test:
  override:
  - echo 'Running on gh-pages branch'" > "circle.yml"

# Commit all the changes and push it to the remote
git add -A
git commit -m "Deployed with $(jekyll -v)"
git push origin gh-pages

# Post a Slack message
git checkout master

echo "Deployed successfully, check out https://krausefx.com"
echo "If you're running this on your local machine, please make sure to reset your git user credentials (username and email) to not be the bot"

exit 0
