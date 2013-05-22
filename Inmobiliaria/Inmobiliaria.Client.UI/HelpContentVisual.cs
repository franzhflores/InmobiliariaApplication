using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Media;
using System.Windows.Controls;
using System.Text;
using System.Windows.Documents;


namespace Inmobiliaria.Client.UI
{
    public static class HelpContentVisual
    {
        /*
         * 
         * Clase usada para obtner los elementos visuales contenidos en un Control como hijos
         * /
         /**/


        public static  childItem FindVisualChild<childItem>(DependencyObject obj) where childItem : DependencyObject
        {
            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(obj); i++)
            {
                DependencyObject child = VisualTreeHelper.GetChild(obj, i);
                if (child != null && child is childItem)
                    return (childItem)child;
                else
                {
                    childItem childOfChild = FindVisualChild<childItem>(child);
                    if (childOfChild != null)
                        return childOfChild;
                }
            }
            return null;
        }

        public static UIElement GetChildFromListBoxItem<UIElement>(ListBoxItem listBoxItem, string elementNameToFind)
        {
            ContentPresenter contentpresenter = FindVisualChild<ContentPresenter>(listBoxItem);
            DataTemplate dataTemplate = contentpresenter.ContentTemplate;
            return (UIElement)dataTemplate.FindName(elementNameToFind, contentpresenter);
        }

        public static void GetListChild<UIElement>(ListBox lbx_DataList, List<UIElement> listCheckBox, string elementNameToFind) where UIElement : class, new()
        {
            foreach (var item in lbx_DataList.ItemsSource)
            {
                ListBoxItem listBoxItem = (ListBoxItem)(lbx_DataList.ItemContainerGenerator.ContainerFromItem(item));
                if (listBoxItem != null)
                    listCheckBox.Add(HelpContentVisual.GetChildFromListBoxItem<UIElement>(listBoxItem, elementNameToFind));
            }
        }

        /*public static TUIElement GetChildExpander<TUIElement>(Expander exp_Container ,string elementNameToFind)
        {
            //ContentPresenter contentpresenter = FindVisualChild<ContentPresenter>(listBoxItem);
            //exp_Container.
        }*/
            
        static List<Expander> _listExpander;
        //al primer elemento se le establece su propiedad IsExpanded en True
         public static void ListenExpanded(params Expander [] expander)
        {
            if (expander.Count() == 0) return;
            expander[0].IsExpanded = true;
            _listExpander = expander.ToList();
            foreach (Expander exp in expander)
            {
                exp.Tag = exp.GetHashCode();
                exp.Expanded += EventHandler_Expanded;
            }
        }

         public static void ListenExpanded(List<Expander> listExpander)
         {
             if (listExpander.Count() == 0) return;
             listExpander[0].IsExpanded = true;
             _listExpander = listExpander;
             foreach (Expander exp in listExpander)
                 exp.Expanded += EventHandler_Expanded;
         }

         public static void ListenExpanded(Expander expander)
         {
             expander.Expanded += EventHandler_Expanded;
             _listExpander.Add(expander); 
         }

        static void EventHandler_Expanded(object sender, System.Windows.RoutedEventArgs e)
        {
            foreach (Expander exp in _listExpander)
            {
                if (exp.Tag != ((Expander)sender).Tag)                
                    if (exp.IsExpanded == true)
                        exp.IsExpanded = false;                                             
            }
        }

    }
}
