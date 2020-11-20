namespace Models.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BillDetail")]
    public partial class BillDetail
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ID { get; set; }

        public long BillID { get; set; }

        public long ProductID { get; set; }

        [Required(ErrorMessage = "Xin hãy nhập số lượng")]
        public int? Quantity { get; set; }

        public decimal? Price { get; set; }
    }
}
