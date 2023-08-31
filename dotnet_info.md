#### install

- https://docs.microsoft.com/ru-ru/dotnet/core/install/linux-scripted-manual#scripted-install

```
wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0
```


#### new project

```
dotnet new console
dotnet restore
dotnet run
```

- https://docs.microsoft.com/ru-ru/dotnet/framework/install/guide-for-developers

```
v4.6.1
```

##### Sample create project

If you have dotnet core installed just create a root folder for your solution. Then open terminal in root folder and type for a mvc project:

```
dotnet new mvc -o SolutionName.Web
```
remember -o parameter creates a folder for new project and if it was -n project was going to be created in the folder you are in.

and for class library project

```
dotnet new classlib -o SolutionName.Library
cd SolutionName.Web
```
this line to add reference to use this library.

```
dotnet add reference ../SolutionName.Library/SolutionName.Library.csproj
```
get to root folder again

```
cd ..

dotnet new sln -n SolutionName
```

we talked about -n. After we created solution we will add projects to solution.

```
dotnet sln add SolutionName.Web/SolutionName.Web.csproj

dotnet sln add SolutionName.Library/SolutionName.Library.csproj

dotnet build
```

##### github actions

- https://www.pmichaels.net/tag/the-current-working-directory-does-not-contain-a-project-or-solution-file/


##### iiko preinstall

```
# visual studio 2017
https://my.visualstudio.com/Downloads?q=visual%20studio%202017&wt.mc_id=o~msft~vscom~older-downloads

# iiko
https://ru.iiko.help/articles/#!iikooffice-7-6/install-iiko

запустить visual studio под админом
```
