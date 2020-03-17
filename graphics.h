extern int current_video_mode;

void video_mode(int m);

void pixel(int x, int y, int color);

void line(int x1, int y1, int x2, int y2, int color);

void circle(int x, int y, int r, int color);

void draw(int x, int y, int c, char *s);

void scroll_up();