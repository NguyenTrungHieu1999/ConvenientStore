using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Models.ViewModel
{
    [Serializable]
    public class OrderViewModel
    {
        public long billID { get; set; }
        public long userID { get; set; }
        public long productID { get; set; }
        public string metaTitle { get; set; }
        public int? quantity { get; set; }
        public decimal? price { get; set; }
        [StringLength(250)]
        public string name { get; set; }
        [StringLength(250)]
        public string image { get; set; }
    }
}
