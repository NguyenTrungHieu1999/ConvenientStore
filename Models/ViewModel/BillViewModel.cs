using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Models.ViewModel
{
    [Serializable]
    public class BillViewModel
    {
        public long billID { get; set; }
        public long userID { get; set; }
        [StringLength(250)]
        public string name { get; set; }
        public DateTime? createDate { get; set; }
        public decimal? totalMoney { get; set; }
        public int status { get; set; }
        [StringLength(250)]
        public string billStatus { get; set; }
        [StringLength(250)]
        public string address { get; set; }
        [StringLength(250)]
        public string creditCard { get; set; }
    }
}
