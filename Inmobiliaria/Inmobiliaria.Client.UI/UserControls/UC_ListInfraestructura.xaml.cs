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
    /// Lógica de interacción para UC_ListInfraestructura.xaml
    /// </summary>
    public partial class UC_ListInfraestructura : UserControl, IActionUserControl
    {
        
        Action<List<Model.Infraestructura>> _notificarElementosSelected;
        /*
         * 
         * tipo de controles manejados por los listbox
         * */
        List<CheckBox> _listCheckBoxes;

        public UC_ListInfraestructura(Action<List<Model.Infraestructura>> notificarElementosSelected)
        {
            InitializeComponent();
            lbx_DataList.ItemsSource = LocalDataStore.ListInfraestructura;
            _notificarElementosSelected = notificarElementosSelected;
            this.Loaded += new RoutedEventHandler(UC_ListInfraestructura_Loaded);
            IsPosibleClose = true;
        }

        void UC_ListInfraestructura_Loaded(object sender, RoutedEventArgs e)
        {
            _listCheckBoxes = new List<CheckBox>();
            HelpContentVisual.GetListChild<CheckBox>(lbx_DataList,_listCheckBoxes,"checkBox");
        }

        private void cbx_Select_Checked(object sender, RoutedEventArgs e)
        {
            cbx_Select.Content = "UnSelect All";
            ActionCheckBox(true);
        }

        private void cbx_Select_Unchecked(object sender, RoutedEventArgs e)
        {
            cbx_Select.Content = "Select All";
            ActionCheckBox(false);
        }

        public void ActionCheckBox(bool isSelect)
        {
            foreach (var checkBox in _listCheckBoxes)
                checkBox.IsChecked = isSelect;
        }

        public void Aceptar(object sender, EventArgs e)
        {
            List<Model.Infraestructura> _listItemsSelected = lbx_DataList.ItemsSource as List<Model.Infraestructura>;
            foreach (CheckBox item in _listCheckBoxes.FindAll(P=>P.IsChecked == false))
                _listItemsSelected.RemoveAll(P => P.Id == item.Tag.ToString()); 
            _notificarElementosSelected(_listItemsSelected);
        }

        public void Cancelar(object sender, EventArgs e)
        {
        }

        public bool IsPosibleClose { get; set; }
    }
}
