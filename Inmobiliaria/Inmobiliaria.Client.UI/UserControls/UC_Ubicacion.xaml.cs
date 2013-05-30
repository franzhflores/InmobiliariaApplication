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
    /// Lógica de interacción para UC_Ubicacion.xaml
    /// </summary>
    public partial class UC_Ubicacion : UserControl, IActionUserControl
    {
        public string ProvinciaSelected { get; private set; }
        public string ZonaSelected { get; private set; }
        public bool PressAceptar { get; set; }

        public UC_Ubicacion()
        {
            InitializeComponent();
            cbx_Provincia.ItemsSource = LocalDataStore.ListUbicaciones;
            IsPosibleClose = true;    
        }

        private void cbx_Provincia_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Model.Ubicacion ubicacion = cbx_Provincia.SelectedItem as Model.Ubicacion;
            if (ubicacion == null) return;
            cbx_Zona.ItemsSource = LocalDataStore.GetUbicacionDetalle(ubicacion);
            ProvinciaSelected = ubicacion.Provincia;
        }

        private void cbx_Zona_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Model.Ubicacion_Detalle ubiDetalle = cbx_Zona.SelectedItem as Model.Ubicacion_Detalle;
            if (ubiDetalle == null) return;
            ZonaSelected = ubiDetalle.Zona;
        }


        public void Aceptar(object sender, EventArgs e)
        {
            PressAceptar = true;
        }

        public void Cancelar(object sender, EventArgs e)
        {
            PressAceptar = false;
        }

        public bool IsPosibleClose { get; set; }
    }
}
