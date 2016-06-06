FROM redmine:3.2.2
COPY config/database_template.yml config/database_template.yml
COPY start_container.sh start_container.sh
RUN apt-get update && \
    apt-get -qq install zip && \
    apt-get -qq install build-essential g++ gettext && \
    cd plugins && \
    curl -o redmine_backlogs.zip https://codeload.github.com/backlogs/redmine_backlogs/zip/feature/redmine3 && \
    unzip redmine_backlogs && \
    rm redmine_backlogs.zip && \
    mv redmine_backlogs-feature-redmine3 redmine_backlogs && \
    cd redmine_backlogs && \
    sed -i -e 's/gem \"nokogiri\"/# gem "nokogiri"/g' Gemfile && \
    sed -i -e 's/gem \"capybara\", \"~> 1\"/# gem "capybara", "~> 1"/g' Gemfile && \
    # sed -i -e 's/gem \"simplecov\", \"~>0.6\"//g' Gemfile && \
    cd ../.. && \
    # gem uninstall htmlentities -v 4.3.1 && gem install htmlentities -v 4.3.4 && \
    export RAILS_ENV=production && \
    bundle update && \
    bundle install --without development test
CMD "./start_container.sh"
# CMD ["", "exec", "rake", "redmine:backlogs:install"]
# CMD ["rails", "server", "-b", "0.0.0.0"]
# CMD envsubst < "config/database_template.yml" > "config/database.yml"  && rails server -b 0.0.0.0

# echo "hello world" && if [ $MIGRATE ]; then echo "in if" && 
# && bundle exec rake db:migrate && bundle exec rake redmine:load_default_data && bundle exec rake redmine:backlogs:install; fi && pwd # rails server -b 0.0.0.0
