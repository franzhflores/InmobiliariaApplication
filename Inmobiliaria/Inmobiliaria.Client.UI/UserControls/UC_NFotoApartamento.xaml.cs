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
    /// Lógica de interacción para UC_NFotoApartamento.xaml
    /// </summary>
    public partial class UC_NFotoApartamento : UserControl,IActionUserControl
    {
        string _id_apartamento;
        string _IdInfra;
        Dictionary<HelpImage.InfoImage, object> _dicInfoImage;

        public UC_NFotoApartamento(string id_apartamento)
        {
            InitializeComponent();
            _id_apartamento = id_apartamento;
            this.Loaded += new RoutedEventHandler(UC_NFotoApartamento_Loaded);
            IsPosibleClose = true;       
        }

        void UC_NFotoApartamento_Loaded(object sender, RoutedEventArgs e)
        {
           cbx_infra.ItemsSource = LocalDataStore.GetInfraestructuraDetalleForFoto(_id_apartamento);
        }

        public bool IsPosibleClose { get; set; }

        public void Aceptar(object sender, EventArgs e)
        {
            Model.Fotos_Apartamento newFotoApart = new Model.Fotos_Apartamento();
            newFotoApart.Foto = @"http://localhost:2360/" + _dicInfoImage[HelpImage.InfoImage.IMAGENAME];
            newFotoApart.Descripcion = txt_descripcion.Text;
            newFotoApart.Id_Infra_Detalle = _IdInfra;
            newFotoApart.Id_Apartamento = _id_apartamento;
            bool response = LocalDataStore.GuardarFotoApartamento(newFotoApart);
            if (response)
            {
                //_lbx_DataList.Items.Refresh();
                MessageBox.Show("El registro fue exitoso", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        public void Cancelar(object sender, EventArgs e)
        {
        }

        private void btn_LoadFoto_Click(object sender, RoutedEventArgs e)
        {
            _dicInfoImage = HelpImage.GetInfoImage();
            if (_dicInfoImage != null)
            {
                Foto.Source = _dicInfoImage[HelpImage.InfoImage.IMAGE] as BitmapImage;
            }
        }

        private void cbx_infra_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Model.Infraestructura_Detalle infra = cbx_infra.SelectedItem as Model.Infraestructura_Detalle;
            if (infra == null) return;
            _IdInfra = infra.Id;
        }
    }
}
