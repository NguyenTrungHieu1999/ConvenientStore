using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ConvenientStore.Areas.Admin.Models
{
    public class ChangePassword
    {
        [Display(Name="Tên tài khoản")]
        public string userName { get; set; }
        [Display(Name = "Mật khẩu")]
        [Required(ErrorMessage = "Xin hãy nhập mật khẩu")]
        public string passWord { get; set; }

        [Display(Name = "Nhập lại mật khẩu")]
        [Required(ErrorMessage = "Xin hãy nhập lại mật khẩu")]
        public string confirmPassWord { get; set; }
        [Display(Name ="Mã bảo mật")]
        [Required(ErrorMessage = "Xin hãy nhập mã bảo mật")]
        public string securityCode { get; set; }
    }
}