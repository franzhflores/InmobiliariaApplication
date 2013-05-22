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
    /// Lógica de interacción para UC_DetalleInfraestructura.xaml
    /// </summary>
    public partial class UC_DetalleInfraestructura : UserControl, IActionUserControl
    {
        List<Expander> _listExpander;
        Expander currentExpander;//actual expander sobre el q el usuario esta
        //ListBox currentListBox;//Contiene la lista actual de la infraestructura q corresponde al expander
        Model.Infraestructura_Detalle _infraDetalleSelected;
        string _id_Apartamento;
        public UC_DetalleInfraestructura(List<Model.Infraestructura> listSelected, string id_Apartamento)
        {
            InitializeComponent();
            this.Loaded += new RoutedEventHandler(UC_DetalleInfraestructura_Loaded);
            lbx_DataList.ItemsSource = listSelected;
            _id_Apartamento = id_Apartamento;
            IsPosibleClose = true;
        }
       
        void UC_DetalleInfraestructura_Loaded(object sender, RoutedEventArgs e)
        {
            this. _listExpander = new List<Expander>();
            HelpContentVisual.GetListChild<Expander>(lbx_DataList, _listExpander, "expander");
            HelpContentVisual.ListenExpanded(_listExpander);
            foreach (var item in _listExpander)
            {
                ListBox lbx = item.FindName("lbx_childExpander") as ListBox;
                lbx.ItemsSource = LocalDataStore.GetInfraestructuraDetalle(item.Tag.ToString());
            }
        }

        public void Aceptar(object sender, EventArgs e)
        {
            //cuando das click en la ventana en voton aceptar este metodo es el manejador de evento
        }

        public void Cancelar(object sender, EventArgs e)
        {
            //
        }

        public bool IsPosibleClose {get;set;}

        public void EventHandler_Agregar(object sender, EventArgs e)
        {
            Button btnCurrent = (sender as Button);
            ListBox lbxInfraDetalle = currentExpander.FindName("lbx_childExpander") as ListBox;

            Grid gridExpander = currentExpander.FindName("gridExpander") as Grid;
            Expander expanderAgregar = currentExpander.FindName("expanderAgregar") as Expander;
            TextBox txt_tamano = gridExpander.FindName("textBox") as TextBox;
            RichTextBox rtbx_descripcion = gridExpander.FindName("richTextBox") as RichTextBox;
            Model.Infraestructura_Detalle nuevoInfraDetalle = new Model.Infraestructura_Detalle()
            {
                Id_Infra = btnCurrent.Tag.ToString(),
                Tamano = txt_tamano.Text,
                Descripcion = GetString(rtbx_descripcion)
            };

            if (LocalDataStore.GuardarDetalleInfraestructura(nuevoInfraDetalle))
            {
                lbxInfraDetalle.ItemsSource = LocalDataStore.GetInfraestructuraDetalle(btnCurrent.Tag.ToString());
                lbxInfraDetalle.Items.Refresh();
                MessageBox.Show("Se guardo exitosamente", "Registro de Detalle Infraestructura", MessageBoxButton.OK, MessageBoxImage.Information);
                txt_tamano.Text = "";
                FlowDocument fd = new FlowDocument();
                fd.Blocks.Add(new Paragraph(new Run("")));
                rtbx_descripcion.Document = fd;
                expanderAgregar.IsExpanded = false;
            }
            else MessageBox.Show("No se guardo", "Registro de Detalle Infraestructura", MessageBoxButton.OK, MessageBoxImage.Exclamation);

           
        }

        string GetString(RichTextBox rtbx)
        {
            var textRange = new TextRange(rtbx.Document.ContentStart, rtbx.Document.ContentEnd);
            return textRange.Text;
        }

        private void EventHandler_Expanded(object sender, RoutedEventArgs e)
        {
            currentExpander = sender as Expander;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Button b_ok = sender as Button;
            ListBox  lbxInfraDetalle = currentExpander.FindName("lbx_childExpander") as ListBox ;
            List<Grid> temp = new List<Grid>();
            HelpContentVisual.GetListChild<Grid>(lbxInfraDetalle, temp, "grid");
            Grid gridfound = temp.Find(G => G.Tag.ToString() == b_ok.Tag.ToString());
            CheckBox checkSelected = gridfound.FindName("chbx_DetalleInfra") as CheckBox;
            if (!(bool)checkSelected.IsChecked)
            {
                MessageBox.Show("Selecione un opcion");
                return;
            }

            ComboBox combo = gridfound.FindName("cbx_Numbers") as ComboBox;
            ComboBoxItem elem = combo.SelectedValue as ComboBoxItem;
            if (elem == null)
            {
                MessageBox.Show("Selecione una cantidad", "", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            var containerItem = lbxInfraDetalle.FindName("Grid_ContainerItem") ;
            foreach (Model.Infraestructura_Detalle infra in lbxInfraDetalle.Items)
            {
                if (b_ok.Tag.ToString() == infra.Id)
                {
                    _infraDetalleSelected = infra;
                    break;
                }
            }
           
      
            Model.Infraestructura_Apartamento nuevoInfraApartamento = new Model.Infraestructura_Apartamento();
            nuevoInfraApartamento.Id_Apartamento = _id_Apartamento;
            nuevoInfraApartamento.Cantidad = Convert.ToInt16(elem.Content );
            nuevoInfraApartamento.Id_Infrac_Detalle = _infraDetalleSelected.Id;
            if (LocalDataStore.GuardarInfraestructuraApartamento(nuevoInfraApartamento))
                MessageBox.Show("Se guardo exitosamente","Registro de Infraestructura",MessageBoxButton.OK,MessageBoxImage.Information);
            else MessageBox.Show("No se guardo", "Registro de Infraestructura", MessageBoxButton.OK, MessageBoxImage.Exclamation);

          
        }


    }
}
