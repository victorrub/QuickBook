using System;

namespace Domain.Entities.Core
{
    public class EntityBase
    {
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
        public bool Enable { get; set; } = true;
    }
}
