#chmod +x compileLocationPlugin.sh

scons target=debug arch=arm64 simulator=no plugin=Location version=$1
scons target=release arch=arm64 simulator=no plugin=Location version=$1
./scripts/generate_xcframework.sh Location debug $1
./scripts/generate_xcframework.sh Location release $1