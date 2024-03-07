vizzly() {
    PEM=$(mktemp)
    heroku config:get -a hykoapi VIZZLY_PRIVATE_KEY > $PEM
    npx @vizzly/cli@0.2.4 config-manager -pk $PEM -q https://onfolk-vizzly.herokuapp.com
}

vizzly-staging() {
    PEM=$(mktemp)
    heroku config:get -a onfolk-sandbox VIZZLY_PRIVATE_KEY > $PEM
    npx @vizzly/cli@0.2.4 config-manager -pk $PEM -q https://onfolk-vizzly-staging.herokuapp.com
}
