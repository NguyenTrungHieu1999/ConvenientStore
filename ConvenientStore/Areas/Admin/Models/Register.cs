using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ConvenientStore.Areas.Admin.Models
{
    public class Register
    {
        [Display(Name = "UserName")]
        [Required(ErrorMessage = "Xin hãy nhập username")]
        public string UserName { get; set; }

        [Display(Name = "Email")]
        [Required(ErrorMessage = "Xin hãy nhập email")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ")]
        public string Email { get; set; }


        [Display(Name = "Password")]
        [Required(ErrorMessage = "Xin hãy nhập mật khẩu")]
        public string PassWord { get; set; }

        [Display(Name = "ComfirmPassWord")]
        [Required(ErrorMessage = "Xin hãy nhập lại mật khẩu")]
        public string ConfirmPassWord { get; set; }
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
        [Required(ErrorMessage = "Xin hãy nhập số điện thoại")]
        public string Phone { get; set; }
    }
}