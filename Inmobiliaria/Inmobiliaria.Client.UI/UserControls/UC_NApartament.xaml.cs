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
    /// Lógica de interacción para UC_NApartament.xaml
    /// </summary>
    public partial class UC_NApartament : UserControl, IActionUserControl
    {

        string _idEdificio;
        ListBox _lbx_dataList;

        public UC_NApartament()
        {
            InitializeComponent();
        }

        public UC_NApartament(string idEdifico, ListBox lbx_dataList)
        {
            InitializeComponent();
            rb_BloqueA.IsChecked = true;
            _idEdificio = idEdifico;
            _lbx_dataList = lbx_dataList;
            IsPosibleClose = true;
        }

        public bool IsPosibleClose { get; set; }

        public void Aceptar(object sender, EventArgs e)
        {
            Model.Apartamento nuevoApartamento= new Model.Apartamento();
            nuevoApartamento.Id_Edificio = _idEdificio;
            nuevoApartamento.N_Piso = int.Parse(txt_N_Piso.Text);
            nuevoApartamento.N_Puerta = int.Parse(txt_N_Puerta.Text);
            nuevoApartamento.Bloque = GetBloqueChecked();
            bool response = LocalDataStore.GuardarApartamento(nuevoApartamento);
            if (response == true)
            {
                MessageBox.Show("El registro fue exitoso", "Añadir nuevo Apartamento", MessageBoxButton.OK, MessageBoxImage.Information);
                //_lbx_dataList.Items.Refresh();
                _lbx_dataList.ItemsSource = LocalDataStore.GetApartamentsOf(_idEdificio);
            }
            else
            MessageBox.Show("El registro no fue agregado", "Añadir nuevo Apartamento", MessageBoxButton.OK, MessageBoxImage.Exclamation);
        }

        public void Cancelar(object sender, EventArgs e)
        {
            
        }

        public string GetBloqueChecked()
        {
            if (rb_BloqueA.IsChecked == true) return "A";
            return "B";
        }
    }
}
