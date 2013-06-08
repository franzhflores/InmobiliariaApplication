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
using Model = Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Lógica de interacción para UC_ListCasa.xaml
    /// </summary>
    public partial class UC_ListCasa : UserControl, IListaEntidad
    {

        public UC_ListCasa(IEnumerable<Model.Casa> _listCasa)
        {
            InitializeComponent();
            lbx_DataList.ItemsSource = _listCasa;
        }

        public event EventHandler ListSelectionChange;

        public event EventHandler OnDeleteClick;

        public event EventHandler OnUpdateClick;

        public event EventHandler OnAddFotoClick;

        public event EventHandler OnButtonExtraClick;

        public event EventHandler OnButtonExtra1Click;

        public ListBox Lbx_DataList
        {
            get { return this.lbx_DataList; }

        }

        private void lbx_DataList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ListSelectionChange != null)
                ListSelectionChange(sender, e);
        }

        private void btn_Update_Click(object sender, RoutedEventArgs e)
        {
            if (OnUpdateClick != null)
                OnUpdateClick(sender, e);
        }

        private void btn_Delete_Click(object sender, RoutedEventArgs e)
        {
            if (OnDeleteClick != null)
                OnDeleteClick(sender, e);
        }

        private void btn_AgregarInfoestructura_Click(object sender, RoutedEventArgs e)
        {
            if (OnButtonExtraClick != null)
                OnButtonExtraClick(sender, e);
        }

        private void btn_servicios_Click(object sender, RoutedEventArgs e)
        {
            if (OnButtonExtra1Click != null)
                OnButtonExtra1Click(sender, e);
        }


        private void btn_Foto_Click(object sender, RoutedEventArgs e)
        {
            if (OnAddFotoClick != null)
                OnAddFotoClick(sender, e);
        }
    }
}
