using System.Web.Mvc;
namespace Models.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ProductID { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage ="Xin hãy nhập tên sản phẩm")]
        public string Name { get; set; }

        [StringLength(250)]
        public string BarCode { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(500)]

        [Required(ErrorMessage = "Xin hãy nhập mô tả")]
        public string Descriptions { get; set; }

        [StringLength(250)]
        public string Image { get; set; }


        [Required(ErrorMessage ="Xin hãy nhập giá sản phẩm")]
        public decimal? Price { get; set; }
        [Required(ErrorMessage = "Xin hãy nhập giá khuyến mãi")]

        public decimal? PromotionPrice { get; set; }

        public int Quantity { get; set; }

        [Required(ErrorMessage ="Xin hãy chọn loại sản phẩm")]
        public long CategoryID { get; set; }
        [AllowHtml]
        [Column(TypeName = "ntext")]
        [Required(ErrorMessage = "Xin hãy nhập thông tin sản phẩm")]
        public string Detail { get; set; }


        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? CreateDate { get; set; }

        [StringLength(50)]
        public string CreateBy { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? ModifiedDate { get; set; }

        [StringLength(50)]
        public string ModifiedBy { get; set; }

        public bool Status { get; set; }

        [StringLength(250)]
        public string PopupID { get; set; }

        public double? RateStar { get; set; }
    }
}
