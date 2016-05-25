FROM redmine
RUN cd plugins && \
    apt-get update && \
    apt-get -qq install zip && \
    curl -o redmine_backlogs.zip https://codeload.github.com/backlogs/redmine_backlogs/zip/v1.0.6 && \
    unzip redmine_backlogs && \
    rm redmine_backlogs.zip && \
    mv redmine_backlogs-1.0.6 redmine_backlogs && \
    cd .. && \
    export RAILS_ENV=production && \
    bundle exec rake db:migrate && \
    bundle exec rake redmine:backlogs:install
