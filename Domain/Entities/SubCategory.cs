using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class SubCategory
    {
        [Key]
        public int Id { get; set; }

        public int CategoryId { get; set; }

        [Required]
        public string Name { get; set; }


        // Relationships
        public Category Category { get; set; }
    }
}
