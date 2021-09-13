#include "raylib.h"

#define WINDOW_WIDTH  640
#define WINDOW_HEIGHT 480

typedef struct {
    int x;
    int y;
    int radiusV;
    int radiusH;
    Color color;
} EntityEllipse;

Color colors[] = {
    RED,
    BLUE,
    GREEN,
    PURPLE,
    PINK,
    YELLOW,
    VIOLET
};
const int colors_Size = sizeof(colors)/sizeof(colors[0]);

int main()
{
    int dx = 2;
    int dy = 2;

    EntityEllipse logo;
    logo.x = WINDOW_WIDTH / 2;
    logo.y = WINDOW_HEIGHT / 2;
    logo.radiusV = 50;
    logo.radiusH = 100;
    logo.color = colors[GetRandomValue(0, colors_Size-1)];

    InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "DEE BEE DEE");
    SetTargetFPS(60);

    while(!WindowShouldClose()) {

        BeginDrawing();
		ClearBackground(BLACK);
		DrawEllipse(logo.x, logo.y, logo.radiusH, logo.radiusV, logo.color);
        EndDrawing();

        logo.x += dx;
        logo.y += dy;

        if (logo.x + logo.radiusH > WINDOW_WIDTH || logo.x - logo.radiusH < 0) {
            dx = -dx;
            logo.color = colors[GetRandomValue(0, colors_Size-1)];
        }

        if (logo.y + logo.radiusV > WINDOW_HEIGHT || logo.y - logo.radiusV < 0) {
            dy = -dy;
            logo.color = colors[GetRandomValue(0, colors_Size-1)];
        }
    }

    
    CloseWindow();
    return 0;
}
