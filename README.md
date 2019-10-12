# aspnetcore-docker-logging

Example of ASP.NET Core app with container logging.

## create ASP.NET Core app

To create a new app exec this line:

```bash
dotnet new web -o src/ -n aspnetcore-docker-logging
```

ASP.NET Core 3.0 app has three types of default loggers:

- `Microsoft.Extensions.Logging.Console.ConsoleLogger`
- `Microsoft.Extensions.Logging.Debug.DebugLogger`
- `Microsoft.Extensions.Logging.EventSource.EventSourceLogger`

Once you start the app inside of the container, you should be able to view its logs by pulling container logs:

```bash
docker logs <containerId>
```

## build the app

build the app using `docker build` command:

```bash
docker build -t aspnetcore-docker-logging .
```

build the app using VS Code task:

- open Command Palette (`Cmd + Shift + P`)
- choose or type in `Tasks: Run Task`
- choose or type in the task name - `build`

## run the app

run the app via `dotnet` CLI command:

```bash
dotnet run --project yourProject.csproj
```

run the app in a container using `docker-compose`:

```bash
docker-compose up
```

run the app as a Kubernetes deployment (assuming you have local kube instance running):

```bash
# deploy app to kubernetes
kubectl create -f deployment.yml
# verify that app runs on exposed NodePort
curl http://localhost:31000
```

>Make sure to set `ASPNETCORE_ENVIRONMENT` environment variable to `Kubernetes` value to allow the app run in the container on Kube.

## debug the app in VS Code

- open the app folder in VS Code and switch to `Debug` view
- choose between `Docker: Launch .NET Core (Preview)` or `.NET Core Launch (web)` option
- start the app in debug mode
