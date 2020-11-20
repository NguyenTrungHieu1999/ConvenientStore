using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Models.ViewModel
{
    [Serializable]
    public class ProductViewModel
    {
        public long productID { get; set; }
        public string productName { get; set; }
        public int? quantity { get; set; }
    }
}