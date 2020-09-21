using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ToDoList
{
    public class AList
    {
        public int ItemID { get; set; }
        public int LoginID { get; set; }
        public string IsComplete { get; set; }
        public string Description { get; set; }
        public DateTime LAstEdit { get; set; }


        public AList()
        {
            LAstEdit = DateTime.Now;
        }


    }
}