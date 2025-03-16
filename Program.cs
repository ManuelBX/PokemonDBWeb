using PokeDex.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

// Register database connection
builder.Services.AddSingleton<IDatabaseConnectionFactory>(provider =>
    new SqlConnectionFactory(builder.Configuration.GetConnectionString("DefaultConnection")));

// Register services
builder.Services.AddScoped<IPokemonService, PokemonService>();
builder.Services.AddScoped<IMoveService, MoveService>();
builder.Services.AddScoped<ITypeService, TypeService>();
builder.Services.AddScoped<IEvolutionService, EvolutionService>();
builder.Services.AddScoped<IAbilityService, AbilityService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();
