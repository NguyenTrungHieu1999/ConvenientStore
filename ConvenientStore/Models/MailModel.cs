using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ConvenientStore.Models
{
    public class MailModel
    {
        public string From { get; set; }
        [Required(ErrorMessage ="Xin hãy nhập email")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ")]
        public string To { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
    }
}