#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -e

# Run start command if only options given.
if [ "${1:0:1}" = '-' ]; then
  set -- startserver.sh -configfile=serverconfig.xml
fi

# Run boot scripts before starting the server.
if [ "$1" = 'startserver.sh' ]; then
  # Prepare the data directory.
  mkdir -p /data

  SERVER_CONFIG_PATH=/data/serverconfig.xml
  # Copy the default serverconfig.xml if it doesn't exist
  if [ ! -f $SERVER_CONFIG_PATH ]
  then
    echo 'Copying default serverconfig.xml' \
      && cp $SD2D_HOME/serverconfig.xml $SERVER_CONFIG_PATH
  fi

  # Override it if necessary and replace carriage returns with line feeds
  if [ ! -z "$SERVERCONFIG_OVERRIDE" ]
  then
    echo 'Overriding serverconfig.xml' \
      && echo $SERVERCONFIG_OVERRIDE > $SERVER_CONFIG_PATH \
      && awk 'BEGIN{RS="^$";ORS="";getline;gsub("\r","\n");print>ARGV[1]}' $SERVER_CONFIG_PATH
  fi

  # Link save games
  SD2D_DATA=/data/7DaysToDie
  SD2D_STEAM_SAVE=$STEAM_HOME/.local/share/7DaysToDie
  mkdir -p $SD2D_DATA `dirname $SD2D_STEAM_SAVE`
  rm -rf $STEAM_HOME/.local/share/7DaysToDie
  ln -sf $SD2D_DATA $STEAM_HOME/.local/share/7DaysToDie


  # Link Log file
  # TODO: Remove stdout linking and just use -logfile /dev/stdout after replacing the default startserver.sh
  S2DS_LOG_PATH=$SD2D_HOME/7DaysToDieServer_Data/`date +output_log__%Y-%m-%d__%H-%M-%S.txt`
  ln -s /dev/stdout $S2DS_LOG_PATH

  chown -R $STEAM_USER:$STEAM_USER -R /data
  chown -R $STEAM_USER:$STEAM_USER -R $STEAM_HOME/.local

  # Run via steam user if the command is `startserver.sh`.
  cd $SD2D_HOME
  set -- gosu $STEAM_USER "./$@"
fi

# Execute the command.
exec "$@"
