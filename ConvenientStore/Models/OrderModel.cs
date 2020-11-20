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
    public class OrderModel
    {
        public Bill bill { get; set; }
        public BillDetail billDetail { get; set; }
        public Product product { get; set; }
    }
}