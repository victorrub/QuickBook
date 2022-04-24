using Domain.Entities.Core;
using Domain.Enums;
using Microsoft.EntityFrameworkCore;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Domain.Entities
{
    public class Transaction : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Description { get; set; }

        [Required]
        public TransactionTypeEnum TypeId { get; set; }

        public int CategoryId { get; set; }

        public int? SubCategoryId { get; set; }

        [Required]
        public DateTime TransactionDate { get; set; } = DateTime.UtcNow;

        [Required]
        [Precision(14, 2)]
        public decimal Value { get; set; }

        public int? OriginWalletId { get; set; }

        public int? DestinationWalletId { get; set; }

        public int? CreditCardInvoiceId { get; set; }

        public int? LoanId { get; set; }

        public int? LoanInstallmentId { get; set; }

        public string Notes { get; set; }


        // Relationships
        [ForeignKey("CategoryId")]
        public Category Category { get; set; }

        [ForeignKey("SubCategoryId")]
        public SubCategory SubCategory { get; set; }

        [ForeignKey("OriginWalletId")]
        public Wallet OriginWallet { get; set; }

        [ForeignKey("DestinationWalletId")]
        public Wallet DestinationWallet { get; set; }

        [ForeignKey("CreditCardInvoiceId")]
        public Invoice CreditCardInvoice { get; set; }

        [ForeignKey("LoanId")]
        public Loan Loan { get; set; }

        [ForeignKey("LoanInstallmentId")]
        public Installment LoanInstallment { get; set; }
    }
}
