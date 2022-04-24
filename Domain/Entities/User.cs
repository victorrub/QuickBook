using Domain.Entities.Core;
using Domain.Enums;
using System;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class User : EntityBase
    {
        [Key]
        public Guid Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Username { get; set; }

        [Required]
        public string Email { get; set; }

        [Required]
        public string PassHash { get; set; }

        [Required]
        public CurrencyEnum CurrencyId { get; set; }

        public int CountryId { get; set; }

        public int LanguageId { get; set; }


        // Relationships
        public Country Country { get; set; }
        public Language Language { get; set; }
    }
}
 