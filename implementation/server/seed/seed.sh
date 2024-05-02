#!/bin/bash
SCRIPT_PATH=$(dirname -- "$( readlink -f -- "${BASH_SOURCE:-$0}"; )")
LDES_PATH=$SCRIPT_PATH/ldes
LDES_SERVER_ADMIN_BASE="${LDES_SERVER_ADMIN_BASE:-http://localhost:8080}"
LDES_SERVER_CURL_CUSTOM_HEADER="${LDES_SERVER_CURL_CUSTOM_HEADER:-}"
POST="POST $LDES_SERVER_CURL_CUSTOM_HEADER"

# Create Observations LDES
curl --fail -X $POST "$LDES_SERVER_ADMIN_BASE/admin/api/v1/eventstreams" -H "Content-Type: text/turtle" -d "@$LDES_PATH/observations.ttl"
code=$?
if [ $code != 0 ] 
    then exit $code
fi

# Add "default" view fragmented by page
curl --fail -X $POST "$LDES_SERVER_ADMIN_BASE/admin/api/v1/eventstreams/observations/views" -H "Content-Type: text/turtle" -d "@$LDES_PATH/observations-by-page.ttl"
code=$?
if [ $code != 0 ] 
    then exit $code
fi

# Add additional view fragmented by location (geospatial tile at zoom level 13) and then paged within the tile
curl --fail -X $POST "$LDES_SERVER_ADMIN_BASE/admin/api/v1/eventstreams/observations/views" -H "Content-Type: text/turtle" -d "@$LDES_PATH/observations-by-location.ttl"
code=$?
if [ $code != 0 ] 
    then exit $code
fi

# Add additional view fragmented by time (up to hour level) and then paged within the tile
curl --fail -X $POST "$LDES_SERVER_ADMIN_BASE/admin/api/v1/eventstreams/observations/views" -H "Content-Type: text/turtle" -d "@$LDES_PATH/observations-by-time.ttl"
code=$?
if [ $code != 0 ] 
    then exit $code
fi
