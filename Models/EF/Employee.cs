namespace Models.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Employee")]
    public partial class Employee
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ID { get; set; }
        [Index(IsUnique = true)]
        public long EmpID { get; set; }
        [Required(ErrorMessage = "Xin hãy nhập lương nhân viên")]
        public decimal? Salary { get; set; }
    }
}
