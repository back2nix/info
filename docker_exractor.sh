if [ -z "$1" ]; then
  echo "Usage: $0 <image_name>"
  exit 1
fi
IMAGE=$1
OUTPUT_DIR="image_info"
mkdir -p $OUTPUT_DIR
echo "Getting image history..."
docker history --no-trunc $IMAGE >"$OUTPUT_DIR/history.txt"
echo "Getting image config..."
docker image inspect $IMAGE >"$OUTPUT_DIR/inspect.json"
echo "Generating Dockerfile..."
echo "# Generated Dockerfile from $IMAGE" >"$OUTPUT_DIR/Dockerfile"
BASE_IMAGE=$(docker image inspect -f '{{.Config.Image}}' $IMAGE)
echo "FROM $BASE_IMAGE" >>"$OUTPUT_DIR/Dockerfile"
docker image inspect -f '{{range .Config.Env}}ENV {{.}}
{{end}}' $IMAGE >>"$OUTPUT_DIR/Dockerfile"
docker image inspect -f '{{if .Config.WorkingDir}}WORKDIR {{.Config.WorkingDir}}{{end}}' $IMAGE >>"$OUTPUT_DIR/Dockerfile"
docker image inspect -f '{{range $port, $_ := .Config.ExposedPorts}}EXPOSE {{$port}}
{{end}}' $IMAGE >>"$OUTPUT_DIR/Dockerfile"
docker image inspect -f '{{range $key, $value := .Config.Volumes}}VOLUME {{$key}}
{{end}}' $IMAGE >>"$OUTPUT_DIR/Dockerfile"
docker image inspect -f '{{if .Config.Entrypoint}}ENTRYPOINT {{json .Config.Entrypoint}}{{end}}' $IMAGE >>"$OUTPUT_DIR/Dockerfile"
docker image inspect -f '{{if .Config.Cmd}}CMD {{json .Config.Cmd}}{{end}}' $IMAGE >>"$OUTPUT_DIR/Dockerfile"
echo "" >>"$OUTPUT_DIR/Dockerfile"
echo "# Commands from image history:" >>"$OUTPUT_DIR/Dockerfile"
docker history --no-trunc --format "{{if .CreatedBy}}RUN {{.CreatedBy}}{{end}}" $IMAGE | grep -v '<missing>' | tac >>"$OUTPUT_DIR/Dockerfile"
echo "Generated Dockerfile and image information in $OUTPUT_DIR/"
