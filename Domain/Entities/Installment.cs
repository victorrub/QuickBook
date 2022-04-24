using Domain.Enums;
using Microsoft.EntityFrameworkCore;
using System;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class Installment
    {
        [Key]
        public int Id { get; set; }

        public int LoanId { get; set; }

        [Required]
        public byte InstallmentNumber { get; set; }

        [Required]
        public DateTime InstallmentDate { get; set; }

        [Required]
        [Precision(12, 2)]
        public decimal PreCalculatedValue { get; set; } = 0;

        [Required]
        public PaymentStatusEnum PaymentStatusId { get; set; } = PaymentStatusEnum.Pending;

        public DateTime? PaymentDate { get; set; }


        // Relationships
        public Loan Loan { get; set; }
    }
}
