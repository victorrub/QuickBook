using Domain.Entities.Core;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class Loan : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        public string Description { get; set; }

        public int FinancialInstitutionId { get; set; }

        [Required]
        [Precision(14, 2)]
        public decimal LoanAmount { get; set; }

        [Required]
        [Precision(14, 2)]
        public decimal TotalAmountPayable { get; set; }

        [Required]
        public byte TotalInstallments { get; set; }

        [Required]
        [Precision(12, 2)]
        public decimal InstallmentValue { get; set; }


        // Relationships
        public FinancialInstitution FinancialInstitution { get; set; }
        public IList<Installment> Installments { get; set; }
    }
}
