const std = @import("std");
const c = @cImport({
    @cInclude("X11/X.h");
    @cInclude("X11/Xlib.h");
    @cInclude("GL/gl.h");
    @cInclude("GL/glx.h");
});

// Translation of macro DefaultRootWindow from X.h
fn default_root_window(dpy: *c.Display) c.Window {
    return dpy.*.default_screen.*.root;
    // return screen_of_display(dpy, c.DefaultScreen(dpy)).*.root;
}

// Translation of macro ScreenOfDisplay from X.h
// fn screen_of_display(dpy: *c.Display, scr: c._XPrivDisplay) c.Screen {
//     return dpy.*.screens[scr];
// }

pub fn main() !void {
    std.debug.warn("Opening display\n", .{});

    const display = c.XOpenDisplay(null);

    if (display == null) {
        std.debug.warn("Could not connect to X server\n", .{});
        return error.XCouldNotConnect;
    }

    const root = c.DefaultRootWindow(display);

    const gl_attributes = .{
        c.GLX_RGBA, c.GLX_DEPTH_SIZE, 24, c.GLX_DOUBLEBUFFER, c.None
    };
}
