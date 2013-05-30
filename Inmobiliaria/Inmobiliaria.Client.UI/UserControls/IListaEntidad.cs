using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;

namespace Inmobiliaria.Client.UI.UserControls
{
    public interface IListaEntidad
    {
        event EventHandler ListSelectionChange;
        event EventHandler OnDeleteClick;
        event EventHandler OnUpdateClick;
        event EventHandler OnAddFotoClick;
        event EventHandler OnButtonExtraClick;//Para mas acciones contenidas en el item de la lista
        event EventHandler OnButtonExtra1Click;//Para mas acciones contenidas en la lista

        ListBox Lbx_DataList { get;  }
    }
}
