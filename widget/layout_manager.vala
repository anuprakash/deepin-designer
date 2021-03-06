using Gtk;
using Gee;
using Layouts;

namespace Widgets {
    public class LayoutManager : Object {
        public ArrayList<Layouts.Layout> layout_list;
        
        public LayoutManager() {
            layout_list = new ArrayList<Layouts.Layout>();
        }
        
        public Layouts.Layout? add_layout(string layout_type) {
            Layouts.Layout? layout;
            if (layout_type == "Rectangle") {
                layout = new Layouts.RectangleLayout();
            } else if (layout_type == "Rounded_Rectangle") {
                layout = new Layouts.RoundedRectangleLayout();
            } else if (layout_type == "Triangle") {
                layout = new Layouts.TriangleLayout();
            } else if (layout_type == "Five_Pointed_Star") {
                layout = new Layouts.FivePointedStarLayout();
            } else if (layout_type == "Pentagon") {
                layout = new Layouts.PentagonLayout();
            } else if (layout_type == "Line") {
                layout = new Layouts.LineLayout();
            } else if (layout_type == "Pencil") {
                layout = new Layouts.PencilLayout();
            } else if (layout_type == "Oval") {
                layout = new Layouts.OvalLayout();
            } else if (layout_type == "Text") {
                layout = new Layouts.TextLayout();
            } else if (layout_type == "Image") {
                layout = new Layouts.ImageLayout();
            } else {
                print("Can't create layout with type: %s\n", layout_type);
                
                return null;
            }
            
            layout.type = layout_type;
            
            layout_list.add(layout);
            
            return layout;
        }
    }
}