using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Inmobiliaria.Client.UI.UserControls
{
    public interface IActionUserControl
    {
        void Aceptar(object sender, EventArgs e);
        void Cancelar(object sender, EventArgs e);
        bool IsPosibleClose { get; set; }
    }
}
