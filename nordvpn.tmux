#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

nvpn_output=$(nordvpn status)

nvpn_status="#($CURRENT_DIR/scripts/status.sh)"
nvpn_server="#($CURRENT_DIR/scripts/server.sh)"
nvpn_country="#($CURRENT_DIR/scripts/country.sh)"
nvpn_city="#($CURRENT_DIR/scripts/city.sh)"

nvpn_status_ph="\#{nordvpn_status}"
nvpn_server_ph="\#{nordvpn_server}"
nvpn_country_ph="\#{nordvpn_country}"
nvpn_city_ph="\#{nordvpn_city}"

do_interpolation() {
  local string="$1"
  local interpolated=""

  interpolated="${string/$nvpn_status_ph/$nvpn_status}"
  interpolated="${interpolated/$nvpn_server_ph/$nvpn_server}"
  interpolated="${interpolated/$nvpn_country_ph/$nvpn_country}"
  interpolated="${interpolated/$nvpn_city_ph/$nvpn_city}"

  echo $interpolated
}

update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
