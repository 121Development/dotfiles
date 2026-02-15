

source /Users/pdo/.docker/init-bash.sh || true # Added by Docker Desktop

alias fabric='poetry run which fabric'

alias fabric-api='poetry run which fabric-api'

alias fabric-webui='poetry run which fabric-webui'
if [ -f "/Users/pdo/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/pdo/.config/fabric/fabric-bootstrap.inc"; fi