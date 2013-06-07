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
    /// Lógica de interacción para UC_ViewFotos.xaml
    /// </summary>
    public partial class UC_ViewFotos : UserControl
    {

        List<InfoCategoriaFoto> _listinfoCategoriaFoto;
        string idFoto;
        public UC_ViewFotos(List<InfoCategoriaFoto> listinfoCategoriaFoto)
        {
            InitializeComponent();
            this.Loaded += new RoutedEventHandler(UC_ViewFotos_Loaded);
            _listinfoCategoriaFoto = listinfoCategoriaFoto;
        }

        void UC_ViewFotos_Loaded(object sender, RoutedEventArgs e)
        {
            lbx_Fotos.ItemsSource = _listinfoCategoriaFoto;
        }

        private void btn_ImageContent_Click(object sender, RoutedEventArgs e)
        {
            List<InfoGeneralFoto> listFotos = (List<InfoGeneralFoto>)((Button)sender).Tag;
            InfoGeneralFoto infoSelected = listFotos.Find(I => I.Id == idFoto);
            Win_VerPhotos verfotos = new Win_VerPhotos(listFotos,infoSelected);
            verfotos.ShowDialog();

        }

        private void Image_MouseEnter(object sender, MouseEventArgs e)
        {
            idFoto = ((Image)sender).Tag.ToString(); 
        }

    }
}
