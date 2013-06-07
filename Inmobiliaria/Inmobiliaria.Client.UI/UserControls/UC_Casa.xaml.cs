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

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Lógica de interacción para UC_Casa.xaml
    /// </summary>
    public partial class UC_Casa : UserControl
    {
        ControladorUserControls _controlerUserControls;
        public UC_Casa(ControladorUserControls controlerUserControls)
        {
            InitializeComponent();
            _controlerUserControls = controlerUserControls;
        }

        private void btn_AgregarCasa_Click(object sender, RoutedEventArgs e)
        {
            //_controlerUserControls.PutUserControlIntoWin(new UC_NApartament(_IdEdificio, _uCListEntidad.Lbx_DataList));
        }

        private void btn_AgregarInfoestructura_Click(object sender, RoutedEventArgs e)
        {
        }

        private void btn_servicios_Click(object sender, RoutedEventArgs e)
        {
        }

        private void btn_Fotos_Click(object sender, RoutedEventArgs e)
        {
        }


        private void lbx_DataList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
        }

 
    }
}
