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
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "aspnetcore-docker-logging.dll"]