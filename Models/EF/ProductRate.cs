using System.Web.Mvc;
namespace Models.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProductRate")]
    public partial class ProductRate
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ID { get; set; }
        public long UserID { get; set; }
        public long ProductID { get; set; }
        public double? RateStar { get; set; }
        [StringLength(250)]
        public string CommentContent { get; set; }
    }
}
