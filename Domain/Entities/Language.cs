using Domain.Entities.Core;
using System.ComponentModel.DataAnnotations;

namespace Domain.Entities
{
    public class Language : EntityBase
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }
    }
}
