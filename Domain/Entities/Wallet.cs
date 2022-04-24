using Domain.Entities.Core;
using Domain.Enums;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class Wallet : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        public string Description { get; set; }

        [Required]
        public WalletTypeEnum TypeId { get; set; }

        public int FinancialInstitutionId { get; set; }

        [Required]
        public CurrencyEnum CurrencyId { get; set; }

        [Required]
        [Precision(16, 2)]
        public decimal PreCalculatedBalance { get; set; } = 0;

        [Required]
        [Precision(16, 2)]
        public decimal OpeningBalance { get; set; } = 0;


        // Relationships
        public FinancialInstitution FinancialInstitution { get; set; }
        public IList<Transaction> OriginTransactions { get; set; }
        public IList<Transaction> DestinationTransactions { get; set; }
    }
}
