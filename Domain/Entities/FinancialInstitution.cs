using Domain.Entities.Core;
using Domain.Enums;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class FinancialInstitution : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public FinancialInstitutionTypeEnum TypeId { get; set; }

        public int CountryId { get; set; }


        // Relationships
        public Country Country { get; set; }
    }
}
