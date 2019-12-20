FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-alpine AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-alpine AS build
WORKDIR /src
COPY ./src/aspnetcore-docker-logging.csproj ./
RUN dotnet restore ./aspnetcore-docker-logging.csproj
COPY ./src .
RUN dotnet build aspnetcore-docker-logging.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish aspnetcore-docker-logging.csproj -c Release -o /app

FROM base AS final

# good practice to provide medatadata for the image
# see a good schema to follow at http://label-schema.org/
LABEL com.sharamok.name="aspnetcore-docker-logging" \
    com.sharamok.description="ASPNET Core example of writing application logs into container STDOUT/STDERR." \
    com.sharamok.usage="https://hub.docker.com/repository/docker/ivansharamok/aspnetcore-docker-logging" \
    com.sharamok.docker.build.cmd="docker build -t ivansharamok/aspnetcore-docker-logging -f Dockerfile ." \
    com.sharamok.docker.cmd="docker run --rm -it -p 8000:80 ivansharamok/aspnetcore-docker-logging:latest" \
    com.sharamok.docker.params="ASPNETCORE_ENVIRONMENT=Development sets development environment for .NET Core that enables debugging capabilities. ASPNETCORE_DETAILEDERRORS=1 allows to the app to output detailed error messages. DOTNET_RUNNING_IN_CONTAINER=true configures .NET engine for container environment." \
    com.sharamok.docker.debug="docker run --rm -it -e ASPNETCORE_ENVIRONMENT=Development -e ASPNETCORE_DETAILEDERRORS=1 -p 8000:80 ivansharamok/aspnetcore-docker-logging:latest"

WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "aspnetcore-docker-logging.dll"]