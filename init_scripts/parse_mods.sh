#! /bin/bash
# Author -- meevs
# Creation Date -- 2023-11-14
# File Name -- parse_mod_list.sh
# Notes --
# 	-- 2023-11-14 -- This script assumes that downloads will be via Github. This script may be able to work with other sites, but is primarily focused on Github
# 	-- 2023-12-19 -- Version two utilizes the Steam Workshop through steamcmd rather than relying on arbitrary links


export STEAM_WORKSHOP_DIR="${HOME}/.local/share/Steam/steamapps/workshop/content"

function parse_mod () {
	if [[ "$#" -ge 1 && ! -z "${MOD_DIR}" ]]
	then
		if [[ ! -f "${1}" ]]
		then
			echo -e "\e[38;2;200;0;200m<<WARN>> -- Mod list ${1} does not exist!\e[0m"
		else
			echo -e "<<INFO>> -- Parsing mod list \e[38;2;200;200;0m${1}\e[0m"
	
			if [[ -z "${STEAM_LOGIN}" ]]
			then
				echo -e "\e[38;2;200;0;200m<<WARN>> -- No login provided, will not attempt to download/update any mods!\033[0m"
			fi
	
			let index=0
			while [[ "$(jq -Mrc .mods[${index}] ${1})"  != "null" ]]
			do
				jq ".mods[${index}]" "${1}"
	
				# Get mod data
				mod_name="$(jq -Mrc .mods[${index}].mod_name ${1})"
				workshop_id="$(jq -Mrc .mods[${index}].workshop_id ${1})"
	
				# Ensure we have a valid workshop id
				if [[ "${workshop_id}" == "null" ]]
				then
					echo -e "\e[38;2;255;0;0mNo workshop id provided, skipping mod ${index}!\e[0m"
					((index++))
					continue
				fi
	
				# Check mod name is populated
				if [[ "${mod_name}" == "null" ]]
				then
					echo -e "\e[38;200;0;200m<<WARN>> -- No modname provided for ${workshop_id}, using id in leu of...\e[0m"
					mod_name="${workshop_id}"
				fi
	
				if [[ ! -z "${STEAM_LOGIN}" ]]
				then
					echo -e "\e[38;2;0;255;0mDownloading ${workshop_id}" to "${MOD_DIR}/${mod_name}\e[0m"
					steamcmd +login "${STEAM_LOGIN}" +workshop_download_item "${APP_ID}" "${workshop_id}" +quit
				fi
				
				if [[ -d "${STEAM_WORKSHOP_DIR}/${APP_ID}/${workshop_id}" ]]
				then
					cp --recursive "${STEAM_WORKSHOP_DIR}/${APP_ID}/${workshop_id}" "${MOD_DIR}/${mod_name}"
					echo -e "\e[38;0;200;200;0mAdded ${mod_name}\e[0m"
					if [[ -z "${MODS}" ]]
					then
						export MODS="mods/${mod_name}"
					else
						export MODS="mods/${mod_name};${MODS}"
					fi
				else
					echo -e "\e[38;2;200;0;200m<<WARN>> -- ${mod_name} was not successfully installed!\e[0m"
				fi
						
				((index++))
			done
	
			echo -e "<<INFO>> -- Parsing \e[38;2;200;200;0m${SERVER_MOD_LIST}\e[0m complete!"
		fi
	elif [[ "$#" -eq 0 ]]
	then
		echo -e "\033[38;2;200;0;200m<<WARN>> -- No mod file provided.\033[0m"
	else 
		echo -e "\033[38;2;255;0;0m<<WARN>> -- Variable \"MOD_DIR\" not defined.\033[0m"
	fi
}
