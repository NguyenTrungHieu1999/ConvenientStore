using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Models.ViewModel
{
    [Serializable]
    public class EmployeeViewModel
    {

        public long ID { get; set; }
        [Index(IsUnique = true)]
        public long EmpID { get; set; }
        [Index(IsUnique = true)]
        [StringLength(50)]
        public string UserName { get; set; }

        [StringLength(32)]
        public string Password { get; set; }

        [StringLength(20)]
        public string GroupID { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        public DateTime? DateOfBirth { get; set; }

        public bool Sex { get; set; }

        [StringLength(50)]
        public string Address { get; set; }

        [StringLength(50)]
        public string Email { get; set; }

        [StringLength(50)]
        public string Phone { get; set; }

        public bool Status { get; set; }
        public decimal? Salary { get; set; }

    }
}
