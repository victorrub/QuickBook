using Domain.Entities;
using Domain.Entities.Core;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Infrastructure.Data
{
    public class QuickBookDbContext : DbContext
    {
        public DbSet<Category> Categories { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<CreditCard> CreditCards { get; set; }
        public DbSet<FinancialInstitution> FinancialInstitutions { get; set; }
        public DbSet<Installment> Installments { get; set; }
        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<Language> Languages { get; set; }
        public DbSet<Loan> Loans { get; set; }
        public DbSet<SubCategory> SubCategories { get; set; }
        public DbSet<Transaction> Transactions { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Wallet> Wallets { get; set; }


        public QuickBookDbContext() { }
        public QuickBookDbContext(DbContextOptions<QuickBookDbContext> options) : base(options) { }


        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            if (!options.IsConfigured)
            {
                options.UseSqlServer($"Server=localhost;Database=QuickBook;User Id=SA;Password=Local@2022;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // User Entity
            modelBuilder.Entity<User>()
                        .Property(x => x.Id)
                        .HasDefaultValueSql("NEWID()");

            // Transaction Entity
            modelBuilder.Entity<Transaction>()
                        .HasOne(t => t.OriginWallet)
                        .WithMany(w => w.OriginTransactions)
                        .HasForeignKey(t => t.OriginWalletId)
                        .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Transaction>()
                        .HasOne(t => t.DestinationWallet)
                        .WithMany(w => w.DestinationTransactions)
                        .HasForeignKey(t => t.DestinationWalletId)
                        .OnDelete(DeleteBehavior.Restrict);
        }

        public override int SaveChanges()
        {
            UpdateDateTimeOnEditedEntities();
            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync
        (
            bool acceptAllChangesOnSuccess,
            CancellationToken cancellationToken = default
        )
        {
            UpdateDateTimeOnEditedEntities();
            return base.SaveChangesAsync(acceptAllChangesOnSuccess, cancellationToken);
        }

        private void UpdateDateTimeOnEditedEntities()
        {
            var editedEntities = ChangeTracker
                .Entries()
                .Where(e => e.Entity is EntityBase && e.State == EntityState.Modified)
                .ToList();

            editedEntities.ForEach(e => 
                ((EntityBase)e.Entity).UpdatedAt = DateTime.UtcNow);
        }
    }
}
