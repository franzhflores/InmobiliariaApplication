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

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Lógica de interacción para Win_VerPhotos.xaml
    /// </summary>
    public partial class Win_VerPhotos : Window
    {
        public Win_VerPhotos(List<InfoGeneralFoto> fotos, InfoGeneralFoto firstElement)
        {
            InitializeComponent();

            //
            lbx_Fotos.ItemsSource = fotos;
            //img_Foto.Source = HelpImage.GetImage(firstElement.Foto);
        }

    }
}
