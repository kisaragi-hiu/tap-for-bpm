public class TapForBPM : Gtk.Application {
    public TapForBPM () {
        Object (
            application_id: "com.kisaragi-hiu.tap-for-bpm",
            flags: ApplicationFlags.FLAGS_NONE
            );
    }

    public int count = 0;
    public int64 tap_first;
    public int64 tap_current;
    public int reset_threshold = 5 * 1000 * 1000; // 5s represented as μs

    double on_bpm_clicked () {
        // should I return values or the final string?

        double average;
        // reset if left for too long
        if ((tap_current - tap_first) > reset_threshold) {
            count = 0;
            tap_current = tap_first = 0;
            return 0;
        }

        if (count == 0) {
            tap_first = get_monotonic_time ();
            count += 1;
            return 0;
        } else {
            tap_current = get_monotonic_time ();
            count += 1;
            average = 60000000 * count / (tap_current - tap_first);
            return average;
        }
    }

    protected override void activate () {
        var average_label = new Gtk.Label (_("Average BPM:"));
        var average_tracker = new Gtk.Label ("");
        var count_label = new Gtk.Label (_("Taps:"));
        var count_tracker = new Gtk.Label ("");
        var integer_label = new Gtk.Label (_("Closest Integer:"));
        var integer_tracker = new Gtk.Label ("");

        var button = new Gtk.Button.with_label (_("Click"));
        button.clicked.connect (() => {
                double average = on_bpm_clicked ();
                integer_tracker.label = average.to_string (); // TODO
                average_tracker.label = average.to_string ();
                count_tracker.label = count.to_string ();
            });

        var header = new Gtk.HeaderBar ();
        var title = new Gtk.Label (_("Tap for BPM"));
        header.custom_title = title;
        header.show_close_button = true;

        var layout = new Gtk.Grid ();
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.column_spacing = 6;
        layout.row_spacing = 6;

        layout.attach (button, 0, 0, 1, 1);
        layout.attach (average_label, 0, 1, 1, 1);
        layout.attach (integer_label, 0, 2, 1, 1);
        layout.attach (integer_tracker, 1, 0, 1, 1);
        layout.attach (average_tracker, 1, 1, 1, 1);
        layout.attach (count_tracker, 1, 2, 1, 1);
        // layout.attach (closest_integer, 1, 0, 2, 1);

        var window = new Gtk.ApplicationWindow (this);
        window.add (layout);
        window.set_titlebar (header);
        window.default_width = 300;
        window.default_height = 100;
        window.border_width = 10;
        window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TapForBPM ();
        return app.run (args);
    }
}
