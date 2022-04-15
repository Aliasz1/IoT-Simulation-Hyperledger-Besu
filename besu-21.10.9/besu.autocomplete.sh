#!/usr/bin/env bash
#
# besu Bash Completion
# =======================
#
# Bash completion support for the `besu` command,
# generated by [picocli](http://picocli.info/) version 4.6.1.
#
# Installation
# ------------
#
# 1. Source all completion scripts in your .bash_profile
#
#   cd $YOUR_APP_HOME/bin
#   for f in $(find . -name "*_completion"); do line=". $(pwd)/$f"; grep "$line" ~/.bash_profile || echo "$line" >> ~/.bash_profile; done
#
# 2. Open a new bash console, and type `besu [TAB][TAB]`
#
# 1a. Alternatively, if you have [bash-completion](https://github.com/scop/bash-completion) installed:
#     Place this file in a `bash-completion.d` folder:
#
#   * /etc/bash-completion.d
#   * /usr/local/etc/bash-completion.d
#   * ~/bash-completion.d
#
# Documentation
# -------------
# The script is called by bash whenever [TAB] or [TAB][TAB] is pressed after
# 'besu (..)'. By reading entered command line parameters,
# it determines possible bash completions and writes them to the COMPREPLY variable.
# Bash then completes the user input if only one entry is listed in the variable or
# shows the options if more than one is listed in COMPREPLY.
#
# References
# ----------
# [1] http://stackoverflow.com/a/12495480/1440785
# [2] http://tiswww.case.edu/php/chet/bash/FAQ
# [3] https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# [4] http://zsh.sourceforge.net/Doc/Release/Options.html#index-COMPLETE_005fALIASES
# [5] https://stackoverflow.com/questions/17042057/bash-check-element-in-array-for-elements-in-another-array/17042655#17042655
# [6] https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html#Programmable-Completion
# [7] https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh/27853970#27853970
#

if [ -n "$BASH_VERSION" ]; then
  # Enable programmable completion facilities when using bash (see [3])
  shopt -s progcomp
elif [ -n "$ZSH_VERSION" ]; then
  # Make alias a distinct command for completion purposes when using zsh (see [4])
  setopt COMPLETE_ALIASES
  alias compopt=complete

  # Enable bash completion in zsh (see [7])
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi

# CompWordsContainsArray takes an array and then checks
# if all elements of this array are in the global COMP_WORDS array.
#
# Returns zero (no error) if all elements of the array are in the COMP_WORDS array,
# otherwise returns 1 (error).
function CompWordsContainsArray() {
  declare -a localArray
  localArray=("$@")
  local findme
  for findme in "${localArray[@]}"; do
    if ElementNotInCompWords "$findme"; then return 1; fi
  done
  return 0
}
function ElementNotInCompWords() {
  local findme="$1"
  local element
  for element in "${COMP_WORDS[@]}"; do
    if [[ "$findme" = "$element" ]]; then return 1; fi
  done
  return 0
}

# The `currentPositionalIndex` function calculates the index of the current positional parameter.
#
# currentPositionalIndex takes three parameters:
# the command name,
# a space-separated string with the names of options that take a parameter, and
# a space-separated string with the names of boolean options (that don't take any params).
# When done, this function echos the current positional index to std_out.
#
# Example usage:
# local currIndex=$(currentPositionalIndex "mysubcommand" "$ARG_OPTS" "$FLAG_OPTS")
function currentPositionalIndex() {
  local commandName="$1"
  local optionsWithArgs="$2"
  local booleanOptions="$3"
  local previousWord
  local result=0

  for i in $(seq $((COMP_CWORD - 1)) -1 0); do
    previousWord=${COMP_WORDS[i]}
    if [ "${previousWord}" = "$commandName" ]; then
      break
    fi
    if [[ "${optionsWithArgs}" =~ ${previousWord} ]]; then
      ((result-=2)) # Arg option and its value not counted as positional param
    elif [[ "${booleanOptions}" =~ ${previousWord} ]]; then
      ((result-=1)) # Flag option itself not counted as positional param
    fi
    ((result++))
  done
  echo "$result"
}

# Bash completion entry point function.
# _complete_besu finds which commands and subcommands have been specified
# on the command line and delegates to the appropriate function
# to generate possible options and subcommands for the last specified subcommand.
function _complete_besu() {
  local cmds0=(blocks)
  local cmds1=(public-key)
  local cmds2=(password)
  local cmds3=(retesteth)
  local cmds4=(rlp)
  local cmds5=(operator)
  local cmds6=(validate-config)
  local cmds7=(blocks import)
  local cmds8=(blocks export)
  local cmds9=(public-key export)
  local cmds10=(public-key export-address)
  local cmds11=(password hash)
  local cmds12=(rlp encode)
  local cmds13=(operator generate-blockchain-config)
  local cmds14=(operator generate-log-bloom-cache)
  local cmds15=(operator x-backup-state)
  local cmds16=(operator x-restore-state)

  if CompWordsContainsArray "${cmds16[@]}"; then _picocli_besu_operator_xrestorestate; return $?; fi
  if CompWordsContainsArray "${cmds15[@]}"; then _picocli_besu_operator_xbackupstate; return $?; fi
  if CompWordsContainsArray "${cmds14[@]}"; then _picocli_besu_operator_generatelogbloomcache; return $?; fi
  if CompWordsContainsArray "${cmds13[@]}"; then _picocli_besu_operator_generateblockchainconfig; return $?; fi
  if CompWordsContainsArray "${cmds12[@]}"; then _picocli_besu_rlp_encode; return $?; fi
  if CompWordsContainsArray "${cmds11[@]}"; then _picocli_besu_password_hash; return $?; fi
  if CompWordsContainsArray "${cmds10[@]}"; then _picocli_besu_publickey_exportaddress; return $?; fi
  if CompWordsContainsArray "${cmds9[@]}"; then _picocli_besu_publickey_export; return $?; fi
  if CompWordsContainsArray "${cmds8[@]}"; then _picocli_besu_blocks_export; return $?; fi
  if CompWordsContainsArray "${cmds7[@]}"; then _picocli_besu_blocks_import; return $?; fi
  if CompWordsContainsArray "${cmds6[@]}"; then _picocli_besu_validateconfig; return $?; fi
  if CompWordsContainsArray "${cmds5[@]}"; then _picocli_besu_operator; return $?; fi
  if CompWordsContainsArray "${cmds4[@]}"; then _picocli_besu_rlp; return $?; fi
  if CompWordsContainsArray "${cmds3[@]}"; then _picocli_besu_retesteth; return $?; fi
  if CompWordsContainsArray "${cmds2[@]}"; then _picocli_besu_password; return $?; fi
  if CompWordsContainsArray "${cmds1[@]}"; then _picocli_besu_publickey; return $?; fi
  if CompWordsContainsArray "${cmds0[@]}"; then _picocli_besu_blocks; return $?; fi

  # No subcommands were specified; generate completions for the top-level command.
  _picocli_besu; return $?;
}

# Generates completions for the options and subcommands of the `besu` command.
function _picocli_besu() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="blocks public-key password retesteth rlp operator validate-config"
  local flag_opts="--p2p-enabled --discovery-enabled --remote-connections-limit-enabled --random-peer-priority-enabled --graphql-http-enabled --rpc-http-enabled --rpc-http-authentication-enabled --rpc-http-tls-enabled --rpc-http-tls-client-auth-enabled --rpc-http-tls-ca-clients-enabled --rpc-ws-enabled --rpc-ws-authentication-enabled --privacy-tls-enabled --metrics-enabled --metrics-push-enabled --color-enabled --miner-enabled --miner-stratum-enabled --pruning-enabled --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --permissions-nodes-contract-enabled --permissions-accounts-contract-enabled --privacy-enabled --privacy-multi-tenancy-enabled --revert-reason-enabled --privacy-enable-database-migration --privacy-flexible-groups-enabled --privacy-onchain-groups-enabled --auto-log-bloom-caching-enabled -h --help -V --version --compatibility-eth64-forkid-enabled"
  local arg_opts="--config-file --data-path --genesis-file --identity --bootnodes --max-peers --remote-connections-max-percentage --sync-mode --fast-sync-min-peers --network --p2p-host --p2p-interface --p2p-port --nat-method --network-id --graphql-http-host --graphql-http-port --graphql-http-cors-origins --rpc-http-host --rpc-http-port --rpc-http-max-active-connections --rpc-http-cors-origins --rpc-http-api --rpc-http-apis --rpc-http-authentication-credentials-file --rpc-http-authentication-jwt-public-key-file --rpc-http-authentication-jwt-algorithm --rpc-ws-authentication-jwt-algorithm --rpc-http-tls-keystore-file --rpc-http-tls-keystore-password-file --rpc-http-tls-known-clients-file --rpc-ws-host --rpc-ws-port --rpc-ws-max-active-connections --rpc-ws-api --rpc-ws-apis --rpc-ws-authentication-credentials-file --rpc-ws-authentication-jwt-public-key-file --privacy-tls-keystore-file --privacy-tls-keystore-password-file --privacy-tls-known-enclave-file --metrics-protocol --metrics-host --metrics-port --metrics-category --metrics-categories --metrics-push-host --metrics-push-port --metrics-push-interval --metrics-push-prometheus-job --host-allowlist --logging -l --reorg-logging-threshold --miner-stratum-host --miner-stratum-port --miner-coinbase --min-gas-price --rpc-tx-feecap --min-block-occupancy-ratio --miner-extra-data --permissions-nodes-config-file --permissions-accounts-config-file --permissions-nodes-contract-address --permissions-nodes-contract-version --permissions-accounts-contract-address --required-blocks --required-block --privacy-url --privacy-public-key-file --privacy-marker-transaction-signing-key-file --target-gas-limit --tx-pool-max-size --tx-pool-hashes-max-size --tx-pool-retention-hours --tx-pool-price-bump --key-value-storage --security-module --pruning-blocks-retained --pruning-block-confirmations --pid-path --api-gas-price-blocks --api-gas-price-percentile --api-gas-price-max --static-nodes-file --discovery-dns-url --banned-node-ids --banned-node-id --ethstats --ethstats-contact --node-private-key-file"
  local MODE_option_args="FULL FAST" # --sync-mode values
  local NETWORK_option_args="MAINNET RINKEBY ROPSTEN SEPOLIA GOERLI DEV CLASSIC KOTTI MORDOR ECIP1049_DEV ASTOR" # --network values
  local natMethod_option_args="UPNP DOCKER KUBERNETES AUTO NONE" # --nat-method values
  local rpcHttpAuthenticationAlgorithm_option_args="RS256 RS384 RS512 ES256 ES384 ES512" # --rpc-http-authentication-jwt-algorithm values
  local rpcWebsocketsAuthenticationAlgorithm_option_args="RS256 RS384 RS512 ES256 ES384 ES512" # --rpc-ws-authentication-jwt-algorithm values
  local metricsProtocol_option_args="PROMETHEUS OPENTELEMETRY NONE" # --metrics-protocol values

  compopt +o default

  case ${prev_word} in
    --config-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --data-path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --genesis-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --identity)
      return
      ;;
    --bootnodes)
      return
      ;;
    --max-peers)
      return
      ;;
    --remote-connections-max-percentage)
      return
      ;;
    --sync-mode)
      COMPREPLY=( $( compgen -W "${MODE_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --fast-sync-min-peers)
      return
      ;;
    --network)
      COMPREPLY=( $( compgen -W "${NETWORK_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --p2p-host)
      return
      ;;
    --p2p-interface)
      return
      ;;
    --p2p-port)
      return
      ;;
    --nat-method)
      COMPREPLY=( $( compgen -W "${natMethod_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --network-id)
      return
      ;;
    --graphql-http-host)
      return
      ;;
    --graphql-http-port)
      return
      ;;
    --graphql-http-cors-origins)
      return
      ;;
    --rpc-http-host)
      return
      ;;
    --rpc-http-port)
      return
      ;;
    --rpc-http-max-active-connections)
      return
      ;;
    --rpc-http-cors-origins)
      return
      ;;
    --rpc-http-api|--rpc-http-apis)
      return
      ;;
    --rpc-http-authentication-credentials-file)
      return
      ;;
    --rpc-http-authentication-jwt-public-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --rpc-http-authentication-jwt-algorithm)
      COMPREPLY=( $( compgen -W "${rpcHttpAuthenticationAlgorithm_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --rpc-ws-authentication-jwt-algorithm)
      COMPREPLY=( $( compgen -W "${rpcWebsocketsAuthenticationAlgorithm_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --rpc-http-tls-keystore-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --rpc-http-tls-keystore-password-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --rpc-http-tls-known-clients-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --rpc-ws-host)
      return
      ;;
    --rpc-ws-port)
      return
      ;;
    --rpc-ws-max-active-connections)
      return
      ;;
    --rpc-ws-api|--rpc-ws-apis)
      return
      ;;
    --rpc-ws-authentication-credentials-file)
      return
      ;;
    --rpc-ws-authentication-jwt-public-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --privacy-tls-keystore-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --privacy-tls-keystore-password-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --privacy-tls-known-enclave-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --metrics-protocol)
      COMPREPLY=( $( compgen -W "${metricsProtocol_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --metrics-host)
      return
      ;;
    --metrics-port)
      return
      ;;
    --metrics-category|--metrics-categories)
      return
      ;;
    --metrics-push-host)
      return
      ;;
    --metrics-push-port)
      return
      ;;
    --metrics-push-interval)
      return
      ;;
    --metrics-push-prometheus-job)
      return
      ;;
    --host-allowlist)
      return
      ;;
    --logging|-l)
      return
      ;;
    --reorg-logging-threshold)
      return
      ;;
    --miner-stratum-host)
      return
      ;;
    --miner-stratum-port)
      return
      ;;
    --miner-coinbase)
      return
      ;;
    --min-gas-price)
      return
      ;;
    --rpc-tx-feecap)
      return
      ;;
    --min-block-occupancy-ratio)
      return
      ;;
    --miner-extra-data)
      return
      ;;
    --permissions-nodes-config-file)
      return
      ;;
    --permissions-accounts-config-file)
      return
      ;;
    --permissions-nodes-contract-address)
      return
      ;;
    --permissions-nodes-contract-version)
      return
      ;;
    --permissions-accounts-contract-address)
      return
      ;;
    --required-blocks|--required-block)
      return
      ;;
    --privacy-url)
      return
      ;;
    --privacy-public-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --privacy-marker-transaction-signing-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --target-gas-limit)
      return
      ;;
    --tx-pool-max-size)
      return
      ;;
    --tx-pool-hashes-max-size)
      return
      ;;
    --tx-pool-retention-hours)
      return
      ;;
    --tx-pool-price-bump)
      return
      ;;
    --key-value-storage)
      return
      ;;
    --security-module)
      return
      ;;
    --pruning-blocks-retained)
      return
      ;;
    --pruning-block-confirmations)
      return
      ;;
    --pid-path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --api-gas-price-blocks)
      return
      ;;
    --api-gas-price-percentile)
      return
      ;;
    --api-gas-price-max)
      return
      ;;
    --static-nodes-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --discovery-dns-url)
      return
      ;;
    --banned-node-ids|--banned-node-id)
      return
      ;;
    --ethstats)
      return
      ;;
    --ethstats-contact)
      return
      ;;
    --node-private-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `blocks` subcommand.
function _picocli_besu_blocks() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="import export"
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `public-key` subcommand.
function _picocli_besu_publickey() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="export export-address"
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `password` subcommand.
function _picocli_besu_password() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="hash"
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `retesteth` subcommand.
function _picocli_besu_retesteth() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--data-path --logging -l --rpc-http-host --rpc-http-port --host-allowlist --host-whitelist"

  compopt +o default

  case ${prev_word} in
    --data-path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --logging|-l)
      return
      ;;
    --rpc-http-host)
      return
      ;;
    --rpc-http-port)
      return
      ;;
    --host-allowlist|--host-whitelist)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `rlp` subcommand.
function _picocli_besu_rlp() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="encode"
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `operator` subcommand.
function _picocli_besu_operator() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="generate-blockchain-config generate-log-bloom-cache x-backup-state x-restore-state"
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `validate-config` subcommand.
function _picocli_besu_validateconfig() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--config-file"

  compopt +o default

  case ${prev_word} in
    --config-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `import` subcommand.
function _picocli_besu_blocks_import() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--skip-pow-validation-enabled --run -h --help -V --version"
  local arg_opts="--from --format --start-time --start-block --end-block"
  local format_option_args="RLP JSON" # --format values

  compopt +o default

  case ${prev_word} in
    --from)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --format)
      COMPREPLY=( $( compgen -W "${format_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --start-time)
      return
      ;;
    --start-block)
      return
      ;;
    --end-block)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    local currIndex
    currIndex=$(currentPositionalIndex "import" "${arg_opts}" "${flag_opts}")
    if (( currIndex >= 0 && currIndex <= 2147483647 )); then
      compopt -o filenames
      positionals=$( compgen -f -- "${curr_word}" ) # files
    fi
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `export` subcommand.
function _picocli_besu_blocks_export() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--start-block --end-block --to"

  compopt +o default

  case ${prev_word} in
    --start-block)
      return
      ;;
    --end-block)
      return
      ;;
    --to)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `export` subcommand.
function _picocli_besu_publickey_export() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--node-private-key-file --to"

  compopt +o default

  case ${prev_word} in
    --node-private-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --to)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `export-address` subcommand.
function _picocli_besu_publickey_exportaddress() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--node-private-key-file --to"

  compopt +o default

  case ${prev_word} in
    --node-private-key-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --to)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `hash` subcommand.
function _picocli_besu_password_hash() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--password"

  compopt +o default

  case ${prev_word} in
    --password)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `encode` subcommand.
function _picocli_besu_rlp_encode() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--type --from --to"
  local type_option_args="IBFT_EXTRA_DATA QBFT_EXTRA_DATA" # --type values

  compopt +o default

  case ${prev_word} in
    --type)
      COMPREPLY=( $( compgen -W "${type_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --from)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --to)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `generate-blockchain-config` subcommand.
function _picocli_besu_operator_generateblockchainconfig() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--config-file --to --genesis-file-name --private-key-file-name --public-key-file-name"

  compopt +o default

  case ${prev_word} in
    --config-file)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --to)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
    --genesis-file-name)
      return
      ;;
    --private-key-file-name)
      return
      ;;
    --public-key-file-name)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `generate-log-bloom-cache` subcommand.
function _picocli_besu_operator_generatelogbloomcache() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--start-block --end-block"

  compopt +o default

  case ${prev_word} in
    --start-block)
      return
      ;;
    --end-block)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `x-backup-state` subcommand.
function _picocli_besu_operator_xbackupstate() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="--compression-enabled -h --help -V --version"
  local arg_opts="--block --backup-path"

  compopt +o default

  case ${prev_word} in
    --block)
      return
      ;;
    --backup-path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `x-restore-state` subcommand.
function _picocli_besu_operator_xrestorestate() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts="--backup-path"

  compopt +o default

  case ${prev_word} in
    --backup-path)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Define a completion specification (a compspec) for the
# `besu`, `besu.sh`, and `besu.bash` commands.
# Uses the bash `complete` builtin (see [6]) to specify that shell function
# `_complete_besu` is responsible for generating possible completions for the
# current word on the command line.
# The `-o default` option means that if the function generated no matches, the
# default Bash completions and the Readline default filename completions are performed.
complete -F _complete_besu -o default besu besu.sh besu.bash

