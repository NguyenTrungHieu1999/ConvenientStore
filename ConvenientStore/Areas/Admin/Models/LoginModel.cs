using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ConvenientStore.Areas.Admin.Models
{
    public class LoginModel
    {
        [Display(Name = "UserName")]
        [Required(ErrorMessage = "Please enter your name")]
        public string UserName { get; set; }
        [Display(Name = "Password")]
        [Required(ErrorMessage = "Please enter your password")]
        public string Password { get; set; }
        //[Display(Name = "Email")]
        //[Required(ErrorMessage = "Please enter your email")]
        //[EmailAddress(ErrorMessage = "Email is invalid")]
        //public string Email { get; set; }
    }
}