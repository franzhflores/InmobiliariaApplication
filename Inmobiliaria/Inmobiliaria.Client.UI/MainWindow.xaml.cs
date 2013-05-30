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


namespace Inmobiliaria.Client.UI
{
    /// <summary>
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        ControladorUserControls _controlerUserControls = new ControladorUserControls();

        public MainWindow()
        {
            InitializeComponent();
        }

        private void LoadUCActual(UserControl usercontrol )
        {

            if (gridUCContainer.Children.Count != 0)
                gridUCContainer.Children.RemoveAt(0);

            gridUCContainer.Children.Add(usercontrol);
        }

        private void btnOpenEdificio_Click(object sender, RoutedEventArgs e)
        {
            LoadUCActual(new UserControls.UCEdificio(_controlerUserControls, this.gridUCContainer));
        }

        private void btn_uploadImage_Click(object sender, RoutedEventArgs e)
        {
            //Help.UploadFile(@"http://localhost:1835/Images/cha.jpg", @"C:\Users\Franz\Pictures\cha.jpg");
        }

        private void btn_OpenCasa_Click(object sender, RoutedEventArgs e)
        {
            LoadUCActual(new UserControls.UC_Casa(_controlerUserControls));
        }
   
    }
}
