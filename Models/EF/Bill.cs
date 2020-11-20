namespace Models.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Bill")]
    public partial class Bill
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long BillID { get; set; }
        [Display(Name = "UserID")]

        public long UserID { get; set; }
        [DataType(DataType.DateTime)]
        //[DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? CreateDate { get; set; }

        public decimal? TotalMoney { get; set; }
        public int Status { get; set; }
        [StringLength(250)]
        [Required(ErrorMessage = "Xin hãy nhập địa chỉ")]
        public string Address { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Xin hãy chọn thông tin thanh toán")]
        public string CreditCard { get; set; }
    }
}
