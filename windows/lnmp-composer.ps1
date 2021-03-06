#
# https://github.com/composer/composer
#

. "$PSScriptRoot/common.ps1"
. "$PSScriptRoot/../config/composer/.env.example.ps1"
. "$PSScriptRoot/../config/composer/.env.ps1"

$NETWORK="lnmp_backend"
if ($null -eq $(docker network ls -f name="lnmp_backend" -q)){
  $NETWORK="bridge"
}

docker run -it --rm `
    --mount type=bind,src=$PWD,target=/app `
    --mount src=lnmp_composer_cache-data,target=${COMPOSER_CACHE_DIR} `
    --mount src=lnmp_composer_home-data,target=${COMPOSER_HOME} `
    --mount type=bind,src=$PSScriptRoot/../config/composer/config.json,target=${COMPOSER_HOME}/config.json `
    --env-file $PSScriptRoot/../config/composer/.env `
    --network ${NETWORK} `
    khs1994/php:7.3.11-composer-alpine `
    composer $args
