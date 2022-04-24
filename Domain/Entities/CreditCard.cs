using Domain.Entities.Core;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class CreditCard : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        public int FinancialInstitutionId { get; set; }

        [Required]
        [Precision(12, 2)]
        public decimal Limit { get; set; }

        [Required]
        public byte InvoiceClosingDate { get; set; }

        [Required]
        public byte InvoiceDueDate { get; set; }


        // Relationships
        public FinancialInstitution FinancialInstitution { get; set; }
        public IList<Invoice> Invoices { get; set; }
    }
}
