using Domain.Entities.Core;
using Domain.Enums;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class Category : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public CategoryTypeEnum TypeId { get; set; }


        // Relationships
        public IList<SubCategory> SubCategories { get; set; }
    }
}
