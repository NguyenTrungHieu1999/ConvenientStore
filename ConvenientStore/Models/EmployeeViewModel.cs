using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ConvenientStore.Areas.Admin.Models;
using ConvenientStore.Common;
using Models.EF;
using Models.GetData;

namespace ConvenientStore.Models
{
    public class EmployeeViewModel
    {
        public User User { get; set; }
        public Employee Employee { get; set; }

    }
}