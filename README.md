# Phoenix & Elm landing page

This is my sandbox for the [Phoenix and Elm landing page app][], created by
[Ricardo García Vega][] over [a series of posts][App blog posts] over at
[his blog][codeloveandboards].

I find that in order to really understand an app built over the course of a
tutorial, I need to re-write it in a way that I can understand it, and that is
what I've done here.  I've isolated out `Lead`, `Recaptcha`, and `SubscribeForm`
concerns, and moved a lot of code around in an attempt to re-architect the app,
so just consider this another take on what is a great example app.

## Install

```sh
git clone git@github.com:paulfioravanti/phoenix-and-elm-landing-page.git
cd phoenix-and-elm-landing-page
cp config/dev.example.exs config/dev.exs
```

Then, your Recaptcha secret key in the config to use locally.

## Deploy

The app is also currently deployed to [Heroku][] here:

<https://phoenix-and-elm-landing-page.herokuapp.com/>

[App blog posts]: http://codeloveandboards.com/blog/2017/12/02/phoenix-elm-landing-page-pt-1/
[Heroku]: https://www.heroku.com/
[Phoenix and Elm landing page app]: https://github.com/bigardone/phoenix-and-elm-landing-page
[Ricardo García Vega]: https://twitter.com/bigardone
[codeloveandboards]: http://codeloveandboards.com/
