# Backup dir to AWS Object Storage

## Docker

### Build and Run
```
docker build . -t backup-folder && docker run --env-file=".env" backup-folder
```

### Build from ARM (Apple M Series) to X86
If you have a Mac with M Series chip and you want to build for x86 hadware, you can use this:
```
docker buildx build --platform=linux/amd64 . -t backup-folder
```

## Kubernetes
You can run a cronjob task with 200m of CPU and 256Mi of RAM.

## License
MIT
