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

namespace Inmobiliaria.Client.UI.UserControls
{
    /// <summary>
    /// Lógica de interacción para Win_ContenedorUserControls.xaml
    /// </summary>
    public partial class Win_ContenedorUserControls : Window
    {
        public Win_ContenedorUserControls()
        {
            InitializeComponent();
        }

        public void LoadUserControlToPanel(UserControl uc_Actual)
        {
            this.Height = uc_Actual.Height + 10;
            this.Width = uc_Actual.Width + 10;
            MainPanel.Children.Add(uc_Actual);
            //btn_Cancelar.Click += uc.Cancelar;
        }

    }
}
