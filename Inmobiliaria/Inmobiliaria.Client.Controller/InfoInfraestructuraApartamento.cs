using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Inmobiliaria.Client.Controller
{
    public class InfoInfraestructuraApartamento
    {
        public string IdIDetalle {get;set;}
        public string IdApartament { get; set; }
        public string NombreInfraestructura { get; set; }
        public string DescripcionInfraestructura { get; set; }
        public int? Cantidad { get; set; }
        public string TamanoInfraestructura { get; set; }
    }
}
