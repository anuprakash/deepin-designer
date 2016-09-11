using Gtk;
using Gee;
using Layouts;

namespace Widgets {
    public class LayoutManager {
        public ArrayList<Layouts.Layout> layout_list;
        
        public LayoutManager() {
            layout_list = new ArrayList<Layouts.Layout>();
        }
        
        public Layouts.Layout? add_layout(string layout_type, int x, int y, int w, int h) {
            Layouts.Layout? layout = null;
            if (layout_type == "Rectangle") {
                layout = Layouts.create_rectangle_layout(x, y, w, h);
            } else if (layout_type == "Triangle") {
                layout = Layouts.create_triangle_layout(x, y, w, h);
            }
            
            if (layout != null) {
                layout_list.add(layout);
            }
            
            return layout;
        }
    }
}