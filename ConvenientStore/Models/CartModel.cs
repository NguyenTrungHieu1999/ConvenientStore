using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Models.EF;

namespace ConvenientStore.Models
{
    [Serializable]
    public class CartModel
    {
        public long CartID { get; set; }
        public long UserID { get; set; }
        public Product Product { get; set; }
        public int Quantity { get; set; }
    }
}