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
    /// Lógica de interacción para UC_ListServicios.xaml
    /// </summary>
    public partial class UC_ListServicios : UserControl, IActionUserControl
    {
        List<CheckBox> _listCheckBoxes;
        string _id_apartamento;

        public UC_ListServicios(string id_apartamento)
        {
            InitializeComponent();
            lbx_DataList.ItemsSource = LocalDataStore.ListServicios;
            
            _id_apartamento = id_apartamento;
            this.Loaded += new RoutedEventHandler(UC_ListServicios_Loaded);
            IsPosibleClose = true;
        }

        void UC_ListServicios_Loaded(object sender, RoutedEventArgs e)
        {
            tb_Title.Text = "Apartamento  -  " + _id_apartamento;
            _listCheckBoxes = new List<CheckBox>();
            HelpContentVisual.GetListChild<CheckBox>(lbx_DataList, _listCheckBoxes, "checkBox");
        }

        public bool IsPosibleClose { get; set; }

        public void Aceptar(object sender, EventArgs e)
        {
            List<Model.Servicios> _listItemsSelected = lbx_DataList.ItemsSource as List<Model.Servicios>;
            List<Model.Servicios> temp = new List<Model.Servicios>();
            _listCheckBoxes.Clear();
            HelpContentVisual.GetListChild<CheckBox>(lbx_DataList, _listCheckBoxes, "checkBox");
             foreach (CheckBox item in _listCheckBoxes.FindAll(P => P.IsChecked == true))
             {
                 var elemFound =  _listItemsSelected.Find(P => P.Id == item.Tag.ToString());
                if(elemFound!=null)
                {
                    temp.Add(new Model.Servicios()
                    {
                        Id = elemFound.Id,
                        Nombre = elemFound.Nombre,
                        Descripcion = elemFound.Descripcion,
                        Tipo = elemFound.Tipo,
                    });
                }
             }
            if (_listItemsSelected.Count == 0)
            {
                MessageBox.Show("Selecione un servicio", "Registro de Servicio", MessageBoxButton.OK, MessageBoxImage.Information);
                return; 
            }
            if(LocalDataStore.GuardarServicioApartamento(temp, _id_apartamento))
              {
                MessageBox.Show("Se guardo exitosamente", "Registro de Servicio", MessageBoxButton.OK, MessageBoxImage.Information);
             }
            else MessageBox.Show("No se guardo", "Registro de Servicio", MessageBoxButton.OK, MessageBoxImage.Exclamation);
        }

        public void Cancelar(object sender, EventArgs e)
        {
            
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

        public void EventHandler_Agregar(object sender, EventArgs e)
        {
            Model.Servicios nuevoServicio = new Model.Servicios()
            {
                Nombre = txt_Nombre.Text,
                Tipo = (string)(cbx_Tipo.SelectedValue as ComboBoxItem).Content,
                Descripcion = GetString(rtb_Descripcion)
            };
            if (LocalDataStore.GuardarServicio(nuevoServicio))
            {
                lbx_DataList.Items.Refresh();
                MessageBox.Show("Se guardo exitosamente", "Registro de Servicio", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else MessageBox.Show("No se guardo", "Registro de Servicio", MessageBoxButton.OK, MessageBoxImage.Exclamation);
        }

        string GetString(RichTextBox rtbx)
        {
            var textRange = new TextRange(rtbx.Document.ContentStart, rtbx.Document.ContentEnd);
            return textRange.Text;
        }
    }
}
