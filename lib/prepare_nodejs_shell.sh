#!/usr/bin/env bash
function install_npm_package() {
    package="${1}"
    
    output=$(echo "${installed_packages}" | grep "${package}")
    result=$?
    
    if [ $result -ne 0 ]; then
        echo "Installing missing package: ${package}"
        npm install -g "${package}"
    else
        echo "${package} already installed"
    fi
}

packages=( "$@" )

node_modules_path="${HOME}/.node_modules"
export npm_config_prefix="${node_modules_path}"
if [ ! -d "${node_modules_path}" ]; then
    mkdir -p "${node_modules_path}/lib"
fi

installed_packages=$(npm list --global --parsable)

export PATH=$HOME/.node_modules/bin:$PATH

for package in ${packages[@]}; do
    install_npm_package "${package}"
done
