FROM ruby:2.2.3-onbuild
# https://stackoverflow.com/questions/21236608/dynamically-scheduling-background-jobs-evenly-according-to-number-of-objects
CMD ["bundle", "exec", "whenever", "--update-crontab", "store"]
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "5000"]
