FROM ruby:2.7.6
WORKDIR /booking
COPY Gemfile* .
RUN bundle install
COPY . .
EXPOSE 3000
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails","server","-b","0.0.0.0"]