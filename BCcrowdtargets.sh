sudo rm output.txt
sudo rm output.json
base_url="https://bugcrowd.com/crowdstream.json?filter_by=accepted%2Cdisclosures&page="
page=1
while true; do
    # Make the curl request
    response=$(curl -s "${base_url}${page}")
    if [ -z "$response" ] || [ "$(echo "$response" | jq '.results | length')" -eq 0 ]; then
        echo "No more pages. Exiting."
        break
    fi
    echo "$response" | jq -r '.results[].target' | grep -v ' ' | grep -v 'null' >> output.txt
    page=$((page + 1))
done
