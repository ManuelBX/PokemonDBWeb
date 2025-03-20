# PokemonDBWeb2
This application is a database containing data on all Pokemon, moves, and abilities in the main-line Pokemon games controlled via webpage. It was developed from January to March 2025 by Manuel Braje, Jaxon Bundy, Hajira Rana. Joey Chuang, and Gelzin Crisanto as a class project for CSS 475: Database Systems.

## Prerequisites

### Windows
- **.NET SDK**  
  Install the latest [.NET SDK](https://dotnet.microsoft.com/download) (.NET 8).
- **MS SQL Server 2022**  
  Install [MS SQL Server 2022](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (We use Developer but Express edition works too).
- **Visual Studio 2022 (Optional, recommended for developers)**  
  Download and install [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) ensuring that the **ASP.NET and web development** workload is selected.
- **SQL Server Management Studio (Optional, recommended for developers)**  
  [Download SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) for an easy interface to run and manage SQL scripts.

### macOS & Linux
#### -- DANGER ZONE, WE HAVE NOT TESTED THIS ON MAC OR LINUX SYSTEMS --
- **.NET SDK**  
  Install the latest [.NET SDK](https://dotnet.microsoft.com/download) (e.g., .NET 8 or later). You can use [Visual Studio Code](https://code.visualstudio.com/) or [JetBrains Rider](https://www.jetbrains.com/rider/) as your IDE.
- **MS SQL Server via Docker**  
  Since a native SQL Server installation isn’t available, run MS SQL Server in a Docker container. For example:
  ```bash
  docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrong@Passw0rd" \
    -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest
  ```
- **Azure Data Studio (Optional)**  
  Use [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio) for managing your SQL Server instance and running scripts.

---

## Setup Instructions

1. **Clone the Repository**  
   Clone your project repository to your local machine:
   ```bash
   git clone https://github.com/ManuelBX/PokemonDBWeb.git
   cd your-repo-folder
   ```

2. **Configure the Database**
   - **Run SQL Scripts**:  
     Execute the provided `CreateDB.sql` and `InsertData.sql` scripts to create the database and populate it with initial data.
     - On **Windows**: Use SQL Server Management Studio or the `sqlcmd` command-line tool to connect to your server and run the scripts.
     - On **macOS/Linux**: Use the `sqlcmd` command-line tool or Azure Data Studio.
   - **Update Connection String**:  
     In the project’s `appsettings.json`, update the connection string with the appropriate details for your environment. For example:
     ```json
     {
       "ConnectionStrings": {
         "DefaultConnection": "Server={YOUR-DB-SERVER-NAME or localhost};Database=PokemonDB;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True"
       }
     }
     ```

3. **Restore NuGet Packages**
   Restore the required packages by running:
   ```bash
   dotnet restore
   ```

4. **Build and Run the Application**
   Build and run the application using the following command:
   ```bash
   dotnet run
   ```
   Alternatively, open the project in your preffered IDE (Visual Studio is recommended for development) and run it from there.

---

## Additional Notes
- **Docker Considerations**:  
  If you are using Docker for SQL Server on macOS/Linux, ensure that your container is running and accessible on port `1433`.
- **Troubleshooting**:  
  If you run into connectivity issues, double-check your firewall settings and ensure that the Docker container (or SQL Server service) is running correctly.

