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
    /// Lógica de interacción para UC_NFotoEdificio.xaml
    /// </summary>
    public partial class UC_NFotoEdificio : UserControl, IActionUserControl
    {
        string _id_Edificio;
        Dictionary<HelpImage.InfoImage, object> _dicInfoImage;
        public UC_NFotoEdificio(string id_Edificio)
        {
            InitializeComponent();
            UIElementCollection temp = grid_parent.Children;
            HelpValidacionesDeControles.AddListenControlers(grid_parent.Children);
            _id_Edificio = id_Edificio;
            IsPosibleClose = true;     
        }

        private void btn_LoadFoto_Click(object sender, RoutedEventArgs e)
        {
            _dicInfoImage = HelpImage.GetInfoImage();
            if (_dicInfoImage != null)
            {
                Foto.Source = _dicInfoImage[HelpImage.InfoImage.IMAGE] as BitmapImage;
            }
        }

        public void Aceptar(object sender, EventArgs e)
        {
            if (HelpValidacionesDeControles.SomeoneIsEmpty() || _dicInfoImage == null)
            {
                IsPosibleClose = false;
                MessageBox.Show("Algunos campos son requeridos", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }
            IsPosibleClose = true;
            Model.Foto_Edificio newFotoEdificio = new Model.Foto_Edificio();
            newFotoEdificio.Foto = @"http://localhost:2360/" + _dicInfoImage[HelpImage.InfoImage.IMAGENAME];
            newFotoEdificio.Descripcion = txt_descripcion.Text;
            newFotoEdificio.Id_Edificio = _id_Edificio;
            bool response = LocalDataStore.GuardarFotoEdificio(newFotoEdificio);
            if (response)
            {
                //_lbx_DataList.Items.Refresh();
                MessageBox.Show("El registro fue exitoso", "Añadir nuevo elemento", MessageBoxButton.OK, MessageBoxImage.Information);
            }

        }

        public void Cancelar(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        public bool IsPosibleClose { get; set; }
    }
}
