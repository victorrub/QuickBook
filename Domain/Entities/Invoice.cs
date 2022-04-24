using Domain.Entities.Core;
using Domain.Enums;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class Invoice : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int CreditCardId { get; set; }

        [Required]
        public DateTime InvoiceDate { get; set; }

        [Required]
        [Precision(12, 2)]
        public decimal PreCalculatedValue { get; set; } = 0;

        [Required]
        public PaymentStatusEnum PaymentStatusId { get; set; } = PaymentStatusEnum.Pending;

        public DateTime? PaymentDate { get; set; }


        // Relationships
        public CreditCard CreditCard { get; set; }
        public IList<Transaction> Transactions { get; set; }
    }
}
 