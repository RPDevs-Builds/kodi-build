#!/bin/zsh

# Kodi Build Fleet Monitor (Zsh Version)
# Requirements: gh, jq

builders=(
    "xbmc-build|Kodi Core"
    "repo-plugins-build|Plugins"
    "repo-scripts-build|Scripts"
    "repo-scrapers-build|Scrapers"
    "inputstream.ffmpegdirect-build|FFmpegDirect"
    "inputstream.adaptive-build|Adaptive"
)

refresh_interval=30

while true; do
    clear
    echo "============================================================"
    echo "🚢 KODI BUILD FLEET MONITOR (Zsh) - $(date +'%H:%M:%S')"
    echo "============================================================"
    printf "%-15s | %-10s | %-25s\n" "Component" "Status" "Current/Last Step"
    echo "------------------------------------------------------------"

    for entry in $builders; do
        repo=$(echo $entry | cut -d'|' -f1)
        name=$(echo $entry | cut -d'|' -f2)

        # Get latest run data
        run_data=$(gh run list --repo IamRPDev/$repo --workflow=build.yml --limit 1 --json databaseId,status,conclusion,displayTitle 2>/dev/null)
        
        if [[ -z "$run_data" || "$run_data" == "[]" ]]; then
            printf "%-15s | %-10s | %-25s\n" "$name" "⚪ None" "N/A"
            continue
        fi

        id=$(echo $run_data | jq -r '.[0].databaseId')
        run_status=$(echo $run_data | jq -r '.[0].status')
        conclusion=$(echo $run_data | jq -r '.[0].conclusion')
        title=$(echo $run_data | jq -r '.[0].displayTitle')

        # Get current step
        # We look for the first step that isn't 'completed' or the last 'completed' step
        step_data=$(gh run view --repo IamRPDev/$repo $id --json jobs 2>/dev/null)
        
        # Extract the most relevant step from the first non-setup job
        current_step=$(echo $step_data | jq -r '.jobs[] | select(.name != "setup-matrix") | .steps[] | select(.status != "completed") | .name' | head -n 1)
        
        if [[ -z "$current_step" ]]; then
            # If all steps are completed, get the last one
            current_step=$(echo $step_data | jq -r '.jobs[] | select(.name != "setup-matrix") | .steps[-1].name' | head -n 1)
        fi

        icon="🟡"
        [[ "$run_status" == "completed" && "$conclusion" == "success" ]] && icon="✅"
        [[ "$run_status" == "completed" && "$conclusion" == "failure" ]] && icon="❌"
        [[ "$run_status" == "completed" && "$conclusion" == "cancelled" ]] && icon="🔘"

        printf "%-15s | %-10s | %-25s\n" "$name" "$icon ${run_status:0:7}" "${current_step:0:25}"
    done

    echo "============================================================"
    echo "Auto-refresh in ${refresh_interval}s. Press [ENTER] to refresh now."
    
    # Wait for enter or timeout
    read -t $refresh_interval
done
