with Raylib;

procedure Test is
begin
    Raylib.Window.Init (640, 480, "Hello wrodl!");
    while not Raylib.Window.Should_Close loop
        null;
    end loop;
    Raylib.Window.Close;
end Test; 
