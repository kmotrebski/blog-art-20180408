[![Build Status](https://travis-ci.org/kmotrebski/blog-art-20180408.svg?branch=master)](https://travis-ci.org/kmotrebski/blog-art-20180408)

This is a project for a blog post. It's a simple web app in PHP that has a single entrypoint where it displays an awesome integer from a 1 to 100 range. You can read the article that this app supports [here]().

# How to run

### Running "production" version

If you want to just see the app running and have awesome numbers to be generated then run a "production" image with all the code inside already:
```bash
docker run -p "80:80" --rm kmotrebski/blog-app-1:prod
```
Docker will download an image from Docker Hub and start the app. Then visit [localhost](http://localhost) in your browser.

### Development version

If you want to play with the project type the following commands:

```bash
git clone https://github.com/kmotrebski/blog-art-20180408 kmotrebski-blog-app-1
cd kmotrebski-blog-app-1
./new_developer.sh
```
The above will clone the project and start a script that will:
- create a config file
- download all Composer dependencies 
- start the app

# Forking

If you are going to fork this repository then it will run fine in Travis. If you want Travis to automatically push Docker image to Docker Hub then you have to set environment variables in Travis:

- `TRAVIS_ART1_DOCKER_REG` with your Docker Hub login.
- `TRAVIS_ART1_DOCKER_REG_PASSWORD` encrypted value  with your Docker Hub password. One more time, don't forget to set it up as encrypted value! [See here for how to do it](link).

