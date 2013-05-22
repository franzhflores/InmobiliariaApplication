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
using System.Windows.Shapes;
using Inmobiliaria.Client.Controller;
using Model = Inmobiliaria.Client.Controller.ServiceInmobiliaria;

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Lógica de interacción para Win_ModificarEdificio.xaml
    /// </summary>
    public partial class Win_ModificarEdificio : Window
    {
        
        public Win_ModificarEdificio(Model.Edificio edificio)
        {
            InitializeComponent();
            main.DataContext = edificio;
        }

        private void btn_Aceptar_Click(object sender, RoutedEventArgs e)
        {
            LocalDataStore.modificarEdificio(main.DataContext as Model.Edificio);
            if (true)
                MessageBox.Show("El registro se modifico correctamente", "Modificando registro", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
        }

        private void btn_Cancelar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
