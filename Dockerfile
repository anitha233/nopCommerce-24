FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
RUN git clone https://github.com/anitha233/nopCommerce.git
RUN cd nopCommerce && mkdir published
RUN dotnet publish -c Release -o published/ nopCommerce/src/Presentation/Nop.Web/Nop.Web.csproj
RUN cd published && mkdir bin logs


FROM mcr.microsoft.com/dotnet/aspnet:8.0 
RUN useradd -d /app -m -s /bin/bash nop 
USER nop 
WORKDIR /nop 
COPY --from=build --chown=nop:nop published/ /nop  
EXPOSE 5000 
CMD [ "dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000" ]
