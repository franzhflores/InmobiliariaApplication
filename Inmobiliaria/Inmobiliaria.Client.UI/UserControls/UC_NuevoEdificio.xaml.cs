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
    /// Lógica de interacción para UC_NuevoEdificio.xaml
    /// </summary>
    public partial class UC_NuevoEdificio : UserControl, IActionUserControl
    {

        ListBox _lbx_DataList;
        Dictionary<HelpImage.InfoImage, object> _dicInfoImage;
        string _idUbicacion;
        string _idUbicacionDetalle;
        public UC_NuevoEdificio(ListBox lbx_DataList)
        {
            InitializeComponent();
            _lbx_DataList = lbx_DataList;
            cbx_Provincia.ItemsSource = LocalDataStore.ListUbicaciones;
            UIElementCollection temp = grid_parent.Children;
            HelpValidacionesDeControles.AddListenControlers(grid_parent.Children);
            IsPosibleClose = true;
        }

        private void cbx_Provincia_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Model.Ubicacion ubicacion = cbx_Provincia.SelectedItem as Model.Ubicacion;
            if (ubicacion == null) return;
            _idUbicacion = ubicacion.Id;
            cbx_Zona.ItemsSource = LocalDataStore.GetUbicacionDetalle(ubicacion);
        }

        private void cbx_Zona_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Model.Ubicacion_Detalle ubiDetalle = cbx_Zona.SelectedItem as Model.Ubicacion_Detalle;
            if (ubiDetalle == null) return;
            _idUbicacionDetalle = ubiDetalle.Id;
        }

        private void btn_AgregarFoto_Click(object sender, RoutedEventArgs e)
        {
            _dicInfoImage = HelpImage.GetInfoImage();
            if (_dicInfoImage != null)
            {
                ima_main.Source = _dicInfoImage[HelpImage.InfoImage.IMAGE] as BitmapImage;
            }
        }

        public bool IsPosibleClose { get; set; }

        public void Aceptar(object sender, EventArgs e)
        {
            if (HelpValidacionesDeControles.SomeoneIsEmpty() || _dicInfoImage == null)
            {
                IsPosibleClose = false;
                MessageBox.Show("Algunos campos son requeridos", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }
            IsPosibleClose = true;
            Model.Edificio newEdificio = new Model.Edificio();
            newEdificio.Nombre = txt_Nombre.Text;
            newEdificio.N_Plantas = Convert.ToInt16(txt_NPlantas.Text);
            newEdificio.mainfoto = @"http://localhost:2360/" + _dicInfoImage[HelpImage.InfoImage.IMAGENAME];
            newEdificio.A_Contruccion = calendar1.SelectedDate.Value;
            newEdificio.Inf_Adicional = txt_IAdicional.Text;
            newEdificio.Id_Ubi_Detalle = _idUbicacionDetalle;
            bool response = LocalDataStore.GuardarEdificio(newEdificio, _dicInfoImage[HelpImage.InfoImage.FULLPATH].ToString());
            if (response == true)
            {
                _lbx_DataList.Items.Refresh();
                MessageBox.Show("El registro fue exitoso", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            //Help.UploadFile(newEdificio.mainfoto,_dicInfoImage[Help.InfoImage.FULLPATH].ToString()) ;
        }

        public void Cancelar(object sender, EventArgs e)
        {
        }

    }
}
