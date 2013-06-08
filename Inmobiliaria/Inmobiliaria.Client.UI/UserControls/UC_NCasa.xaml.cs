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
    /// Lógica de interacción para UC_NCasa.xaml
    /// </summary>
    public partial class UC_NCasa : UserControl, IActionUserControl
    {
        ListBox _lbx_DataList;
        Dictionary<HelpImage.InfoImage, object> _dicInfoImage;
        string _idUbicacion;
        string _idUbicacionDetalle;
        string _idTipoCasa;
        public UC_NCasa(ListBox lbx_DataList)
        {
            InitializeComponent();
            _lbx_DataList = lbx_DataList;
            cbx_TipoCasa.ItemsSource = LocalDataStore.ListTipoCasa;
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

        public void Aceptar(object sender, EventArgs e)
        {
            try
            {
                if (HelpValidacionesDeControles.SomeoneIsEmpty() || _dicInfoImage == null)
                {
                    IsPosibleClose = false;
                    MessageBox.Show("Algunos campos son requeridos", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                    return;
                }
                IsPosibleClose = true;

                Model.Casa newCasa = new Model.Casa();
                newCasa.Mts2 = txt_Mts2.Text;
                newCasa.Id_TipoCasa = _idTipoCasa;
                newCasa.Inmueble = new Model.Inmueble();
                newCasa.Id_inmueble = "I_001";//es temporal
                newCasa.Inmueble.Foto = @"http://localhost:2360/" + _dicInfoImage[HelpImage.InfoImage.IMAGENAME];
                newCasa.Inmueble.A_Construccion = calendar1.SelectedDate.Value;
                newCasa.Inmueble.Inf_adicional = txt_IAdicional.Text;
                newCasa.Inmueble.Id_Ubi_Detalle = _idUbicacionDetalle;
                newCasa.Inmueble.Direccion = txt_Direccion.Text;
                bool response = LocalDataStore.GuardarCasa(newCasa);
                if (response == true)
                {
                    _lbx_DataList.ItemsSource = LocalDataStore.ListCasa;
                    MessageBox.Show("El registro fue exitoso", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error en el servidor", ex.Message, MessageBoxButton.OK, MessageBoxImage.Warning);

            }
        }

        public void Cancelar(object sender, EventArgs e)
        {
            
        }

        public bool IsPosibleClose { get; set; }

        private void cbx_TipoCasa_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Model.Tipo_Casa tipo_casa = cbx_TipoCasa.SelectedItem as Model.Tipo_Casa;
            if (tipo_casa == null) return;
            _idTipoCasa = tipo_casa.Id;
        }

    }
}
