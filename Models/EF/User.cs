namespace Models.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("User")]
    public partial class User
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long UserID { get; set; }
        [Index(IsUnique = true)]
        [StringLength(50)]
        [Required(ErrorMessage = "Xin hãy nhập tên tài khoản")]
        public string UserName { get; set; }

        [StringLength(500)]
        [Required(ErrorMessage = "Xin hãy nhập mật khẩu")]
        public string Password { get; set; }

        [StringLength(20)]
        public string GroupID { get; set; }

        [StringLength(50)]
        [Required(ErrorMessage = "Xin hãy nhập tên khách hàng")]
        public string Name { get; set; }
        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Required(ErrorMessage = "Xin hãy nhập ngày sinh")]
        public DateTime? DateOfBirth { get; set; }

        public bool Sex { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Xin hãy nhập địa chỉ")]
        public string Address { get; set; }

        [StringLength(50)]
        [Required(ErrorMessage = "Xin hãy nhập email")]
        public string Email { get; set; }

        [StringLength(50)]
        [Required(ErrorMessage = "Xin hãy nhập số điện thoại")]
        public string Phone { get; set; }

        public bool Status { get; set; }
    }
}
