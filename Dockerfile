FROM redmine
RUN cd plugins && \
    apt-get update && \
    apt-get -qq install zip && \
    curl -o redmin_backlogs.zip https://codeload.github.com/backlogs/redmine_backlogs/zip/v1.0.6 && \
    unzip redmine_backlogs && \
    mv redmine_backlogs-1.0.6 redmine_backlogs && \
    export RAILS_ENV=production && \
    bundle exec rake db:migrate && \
    cd .. && \
    bundle exec rake redmine:backlogs:install
