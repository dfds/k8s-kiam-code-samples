FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

WORKDIR /app
COPY ./output ./

ENTRYPOINT [ "dotnet", "csharp-kiam_upload_to_s3.dll" ]