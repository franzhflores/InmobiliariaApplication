using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Inmobiliaria.Client.Controller;
using Model = Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Lógica de interacción para UC_ModificarEdificio.xaml
    /// </summary>
    public partial class UC_ModificarEdificio : UserControl, IActionUserControl
    {
        ListBox _lbx_DataList;
        public UC_ModificarEdificio(Model.Edificio edificio, ListBox lbx_DataList)
        {
            InitializeComponent();
            main.DataContext = edificio;
            _lbx_DataList = lbx_DataList;
            IsPosibleClose = true;
        }

        public bool IsPosibleClose { get; set; }

        public void Aceptar(object sender, EventArgs e)
        {
            LocalDataStore.modificarEdificio(main.DataContext as Model.Edificio);
            if (true)
                MessageBox.Show("El registro se modifico correctamente", "Modificando registro", MessageBoxButton.OK, MessageBoxImage.Information);
            _lbx_DataList.Items.Refresh();
        }

        public void Cancelar(object sender, EventArgs e)
        {
        }
    }
}
