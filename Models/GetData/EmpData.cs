using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using Models.ViewModel;
using PagedList;

namespace Models.GetData
{
    public class EmpData
    {
        ConvenientStoreDBContext db = null;
        public EmpData()
        {
            db = new ConvenientStoreDBContext();
        }
        public EmployeeViewModel GetByID(long ID)
        {
            var model = (from a in db.Employees
                         join b in db.Users
                         on a.EmpID equals b.UserID
                         select new EmployeeViewModel()
                         {
                             ID = a.ID,
                             EmpID = b.UserID,
                             UserName = b.UserName,
                             Password = b.Password,
                             GroupID = b.GroupID,
                             Name = b.Name,
                             DateOfBirth = b.DateOfBirth,
                             Sex = b.Sex,
                             Address = b.Address,
                             Email = b.Email,
                             Phone = b.Phone,
                             Status = b.Status,
                             Salary = a.Salary,
                         }).OrderBy(x => x.Name);
            foreach(var item in model)
            {
                if(item.ID == ID)
                {
                    return item;
                }
            }
            return null;
        }

        public Employee GetByIDEmployee(long id)
        {
            return db.Employees.Find(id);
        }
        public Employee GetByEmpID(long empID)
        {
            return db.Employees.SingleOrDefault(x => x.EmpID == empID);
        }
        //Lấy id nhân viên cho drop down list hóa đơn
        public List<EmployeeViewModel> ListAll()
        {
            var model = (from a in db.Employees
                         join b in db.Users
                         on a.EmpID equals b.UserID
                         select new EmployeeViewModel()
                         {
                             ID = a.ID,
                             EmpID = b.UserID,
                             UserName = b.UserName,
                             Password = b.Password,
                             GroupID = b.GroupID,
                             Name = b.Name,
                             DateOfBirth = b.DateOfBirth,
                             Sex = b.Sex,
                             Address = b.Address,
                             Email = b.Email,
                             Phone = b.Phone,
                             Status = b.Status,
                             Salary = a.Salary
                         }).OrderBy(x => x.Name);
            return model.ToList();
        }
        public EmployeeViewModel GetByUserName(string userName)
        {
            var model = (from a in db.Employees
                         join b in db.Users
                         on a.EmpID equals b.UserID
                         select new EmployeeViewModel()
                         {
                             ID=a.ID,
                             EmpID = b.UserID,
                             UserName = b.UserName,
                             Password = b.Password,
                             GroupID = b.GroupID,
                             Name = b.Name,
                             DateOfBirth = b.DateOfBirth,
                             Sex = b.Sex,
                             Address = b.Address,
                             Email = b.Email,
                             Phone = b.Phone,
                             Status = b.Status,
                             Salary = a.Salary
                         }).OrderBy(x => x.Name);
            foreach (var item in model)
            {
                if (item.UserName == userName)
                {
                    return item;
                }
            }
            return null;
        }

        public IEnumerable<EmployeeViewModel> ListAllEmployee(string searchString, int page, int pageSize)
        {
            if(!string.IsNullOrEmpty(searchString))
            {
                var emp = (from a in db.Employees
                             join b in db.Users
                             on a.EmpID equals b.UserID
                             where b.Name.Contains(searchString) && b.GroupID=="EMP"
                             select new EmployeeViewModel()
                             {
                                 ID = a.ID,
                                 EmpID = b.UserID,
                                 UserName = b.UserName,
                                 Password = b.Password,
                                 GroupID = b.GroupID,
                                 Name = b.Name,
                                 DateOfBirth = b.DateOfBirth,
                                 Sex = b.Sex,
                                 Address = b.Address,
                                 Email = b.Email,
                                 Phone = b.Phone,
                                 Status = b.Status,
                                 Salary = a.Salary
                             }).OrderBy(x => x.Name);
                return emp.OrderBy(x => x.Name).ToPagedList(page, pageSize);
            }
            var model = (from a in db.Employees
                         join b in db.Users
                         on a.EmpID equals b.UserID
                         where b.GroupID == "EMP"
                         select new EmployeeViewModel()
                         {
                             ID = a.ID,
                             EmpID = b.UserID,
                             UserName = b.UserName,
                             Password = b.Password,
                             GroupID = b.GroupID,
                             Name = b.Name,
                             DateOfBirth = b.DateOfBirth,
                             Sex = b.Sex,
                             Address = b.Address,
                             Email = b.Email,
                             Phone = b.Phone,
                             Status = b.Status,
                             Salary = a.Salary
                         }).OrderBy(x => x.Name);
            return model.OrderBy(x=>x.Name).ToPagedList(page, pageSize);
        }
        public long insert(EmployeeViewModel entity)
        {
            var emp = db.Employees.SingleOrDefault(x=>x.EmpID == entity.EmpID);
            if(emp == null)
            {
                var employee = new Employee();
                employee.EmpID = entity.EmpID;
                employee.Salary = entity.Salary;
                db.Employees.Add(employee);
                db.SaveChanges();
                var user = db.Users.Find(entity.EmpID);
                user.GroupID = entity.GroupID;
                db.SaveChanges();
                return entity.EmpID;
            }
            return -1;
        }
        public bool update(EmployeeViewModel entity)
        {
            try
            {
                var user = db.Users.Find(entity.EmpID);
                user.Name = entity.Name;
                user.GroupID = entity.GroupID;
                db.SaveChanges();
                var employee = GetByIDEmployee(entity.ID);
                employee.Salary = entity.Salary;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool UpdateGroupID(User entity)
        {
            try
            {
                var user = db.Users.Find(entity.UserID);
                user.GroupID = entity.GroupID;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool Delete(long ID)
        {
            try
            {
                var employee = db.Employees.Find(ID);
                db.Employees.Remove(employee);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
