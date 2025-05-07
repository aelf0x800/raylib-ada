with Interfaces.C;
with System;

package Raylib is
    use Interfaces.C;
    use System;

    --///////////////////////////////////////////////////////////////////////
    -- Structures Definition
    --//////////////////////////////////////////////////////////////////////
    -- Vector_2, 2 components
    type Vector_2 is record
        X, Y : Float; -- Vector X and Y components
    end record
        with Convention => C_Pass_By_Copy;

    -- Vector_3, 3 components
    type Vector_3 is record
        X, Y, Z : Float; -- Vector X, Y and Z components
    end record
        with Convention => C_Pass_By_Copy;

    -- Vector_4, 4 components
    type Vector_4 is record
        X, Y, Z, W : Float; -- Vector X, Y, Z and W components
    end record
        with Convention => C_Pass_By_Copy;

    -- Quaternion, 4 components (Vector_4 alias)
    type Quaternion is new Vector_4;

    -- Matrix, 4x4 components, column major, OpenGL style, right-handed
    type Matrix is record
        M_0, M_4, M_8, M_12  : Float; -- Matrix first row (4 components)
        M_1, M_5, M_9, M_13  : Float; -- Matrix second row (4 components)
        M_2, M_6, M_10, M_14 : Float; -- Matrix third row (4 conponents)
        M_3, M_7, M_11, M_15 : Float; -- Matrix fourth row (4 conponents)
    end record
        with Convention => C_Pass_By_Copy;

    -- Color, 4 components, R8G8B8A8 (32-bit)
    type Color is record
        R, G, B, A : unsigned_char; -- Color red, green, blue and alpha values
    end record
        with Convention => C_Pass_By_Copy;

    -- Rectangle, 4 components
    type Rectangle is record
        X, Y          : Float; -- Rectangle top-left corner X and Y position
        Width, Height : Float; -- Rectangle width and height
    end record
        with Convention => C_Pass_By_Copy;

    -- Image, pixel data stored in CPU memory (RAM)
    type Image is record
        Data          : System.Address; -- Image raw data
        Width, Height : int;            -- Image base width and height
        Mipmaps       : int;            -- Mipmap levels, 1 by default
        Format        : int;            -- Data format (PixelFormat type)
    end record
        with Convention => C_Pass_By_Copy;

    -- Texture_2D, tex data stored in GPU memory (VRAM)
    type Texture_2D is record
        ID            : unsigned; -- OpenGL texture ID
        Width, Height : int;      -- Texture base width and height
        Mipmaps       : int;      -- Mipmap levels, 1 by default
        Format        : int;      -- Data format (PixelFormat type)
    end record
        with Convention => C_Pass_By_Copy;

    -- Render_Texture_2D, FBO for texture rendering
    type Render_Texture_2D is record
        ID      : unsigned;   -- OpenGL framebuffer object ID
        Texture : Texture_2D; -- Color buffer attachment texture
        Depth   : Texture_2D; -- Depth buffer attachment texture
    end record
        with Convention => C_Pass_By_Copy;

    -- NPatch_Info, n-patch layout info
    type NPatch_Info is record
        Source                   : Rectangle; -- Texture source rectangle
        Left, Top, Right, Bottom : int;       -- Character border offsets
        Layout                   : int;       -- Layout of the n-patch : 3x3, 1x3 or 3x1
    end record
        with Convention => C_Pass_By_Copy;

    -- Glyph_Info, font characters glyphs info
    type Glyph_Info is record
        Value            : int;   -- Character value (Unicode)
        OffsetX, OffsetY : int;   -- Character X and Y offset when drawing
        AdvanceX         : int;   -- Charcater advance position X
        Img              : Image; -- Character image data
    end record
        with Convention => C_Pass_By_Copy;

    -- Font, font texture and Glyph_Info array data
    type Font is record
        BaseSize     : int;               -- Base size (default chars height)
        GlyphCount   : int;               -- Number of glyph characters
        GlyphPadding : int;               -- Padding around the glyph characters;
        Texture      : Texture_2D;        -- Texture atlas containing the glyphs;
        Rectangles   : access Rectangle;  -- Rectangles in texture for the glyphs;
        Glyphs       : access Glyph_Info; -- Glyphs info data
    end record
        with Convention => C_Pass_By_Copy;

    -- Camera_3D, defines position and orientation in 3D space
    type Camera_3D is record
        Position   : Vector_3; -- Camera position
        Target     : Vector_3; -- Camera target it looks-at
        Up         : Vector_3; -- Camera up vector (rotation over its axis)
        Fov_Y      : Float;    -- Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthohtaphic
        Projection : int;      -- Camera projection : CameraProjection.Perspective or CameraProjection.Orthographic
    end record
        with Convention => C_Pass_By_Copy;

    -- Camera_2D, defines position and orientation in 2D space
    type Camera_2D is record
        Offset   : Vector_2; -- Camera offset (displacement from target)
        Target   : Vector_2; -- Camera target (rotation and zoom origin)
        Rotation : Float;    -- Camera rotation in degrees
        Zoom     : Float;    -- Camera zoom (scaling), should be 1.0f by default
    end record
        with Convention => C_Pass_By_Copy;

    -- Mesh, vertex data and VAO/VBO
    type Mesh is record
        Vertex_Count   : int; -- Number of verticies stored in arrays
        Triangle_Count : int; -- Number of triangles stored (indexed or not)

        -- Vertex attributes data
        Verticies        : access Float;         -- Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
        Texture_Coords   : access Float;         -- Vertex texture coordinates (UV - 2 components per vertex (shader-location = 1)
        Texture_Coords_2 : access Float;         -- Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
        Normals          : access Float;         -- Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
        Tangents         : access Float;         -- Vertex tangents (XYZW - 4 components per vertex) (shader-location = 3)
        Colors           : access unsigned_char; -- Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
        Indicies         : access unsigned_char; -- Vertex indicies (in case vertex data comes indexed)
    
        -- Animation vertex data
        Anim_Verticies : access Float;         -- Animated vertex positions (after bones transformations)
        Anim_Normals   : access Float;         -- Animated normals (after bones transformations)
        Bone_IDs       : access unsigned_char; -- Vertex bone IDs, max 255 bone IDs, up to 4 bones influence by vertex (skinning) (shader-location = 6)
        Bone_Weights   : access Float;         -- Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
        Bone_Matricies : access Matrix;        -- Bones animated transformations matricies
        Bone_Count     : int;                  -- Number of bones

        -- OpenGL identifiers
        VAO_ID : unsigned; -- OpenGL Vertex Array Object ID
        VBO_ID : unsigned; -- OpenGL Vertex Buffer Objects ID (default vertex data)
    end record
        with Convention => C_Pass_By_Copy;

    -- Shader
    type Shader is record
        ID   : unsigned;   -- Shader program ID
        Locs : access int; -- Shader locations array
    end record
        with Convention => C_Pass_By_Copy;

    -- Material_Map
    type Material_Map is record
        Texture : Texture_2D; -- Material map texture
        Colr    : Color;      -- Material map color
        Value   : Float;      -- Material map value
    end record
        with Convention => C_Pass_By_Copy;

    -- Material, includes shader and maps
    type Material_Params is Array (0 .. 2) of Float;
    type Material is record
        Shadr  : Shader;              -- Material shader
        Maps   : access Material_Map; -- Material maps array
        Params : Material_Params;     -- Material generic parameters (if required)
    end record
        with Convention => C_Pass_By_Copy;

    -- Transform, vertex transformation data
    type Transform is record
        Translation : Vector_3;   -- Translation
        Rotation    : Quaternion; -- Rotation
        Scale       : Vector_3;   -- Scale
    end record 
        with Convention => C_Pass_By_Copy;

    -- Bone_Info, skeletal animation bone
    type Bone_Info_Name is Array (0 .. 31) of char;
    type Bone_Info is record 
        Name   : Bone_Info_Name; -- Bone name
        Parent : int;            -- Bone parent
    end record 
        with Convention => C_Pass_By_Copy;

    -- Model, meshes, materials and animation data
    type Model is record 
        Matrix : Transform;  -- Local transformation matrix

        Mesh_Count     : int;             -- Number of meshes
        Material_Count : int;             -- Number of materials
        Meshes         : access Mesh;   -- Meshes array
        Materials      : access Material; -- Materials array
        Mesh_Material  : int;             -- Mesh material number

        -- Animation data
        Bone_Count : int;              -- Number of bones
        Bones      : access Bone_Info; -- Bones information (skeleton)
        Bind_Pose  : access Transform; -- Bones base transformation (pose)
    end record 
        with Convention => C_Pass_By_Copy;

    -- Model_Animation
    type Model_Animation_Name is Array (0 .. 31) of char;
    type Model_Animation is record 
        Bone_Count  : int;                  -- Number of bones
        Frame_Count : int;                  -- Number of animation frames
        Bones       : access Bone_Info;     -- Bones information (skeleton)
        Name        : Model_Animation_Name; -- Animation name
    end record 
        with Convention => C_Pass_By_Copy;

    -- Ray, ray for raycasting
    type Ray is record 
        Position  : Vector_3; -- Ray position (origin)
        Direction : Vector_3; -- Ray direction (normalized)
    end record 
        with Convention => C_Pass_By_Copy;

    -- TODO : Ray_Collision

    -- Bounding_Box
    type Bounding_Box is record 
        Min : Vector_3; -- Minimum vertex box-corner
        Max : Vector_3; -- Maximum vertex box-corner
    end record 
        with Convention => C_Pass_By_Copy;

    -- Wave, audio wave data
    type Wave is record 
        Frame_Count : unsigned;       -- Total number of frames (considering channels)
        Sample_Rate : unsigned;       -- Frequency (samples per second)
        Sample_Size : unsigned;       -- Bit depth (bits per sample): 8, 16, 32 (24 not supported) 
        Channels    : unsigned;       -- Number of channels (1-mono, 2-stereo, ...)
        Data        : System.Address; -- Buffer data pointer
    end record 
        with Convention => C_Pass_By_Copy;

    -- TODO : rAudioBuffer
    -- TODO : rAudioProcessor

    -- Audio_Stream, custom audio stream
    type Audio_Stream is record 
        -- buffer
        -- processor
        
        Sample_Rate : unsigned; -- Frequency (samples per second)
        Sample_Size : unsigned; -- Bit depth (bits per sample): 8, 16, 32 (24 not supported) 
        Channels    : unsigned; -- Number of channels (1-mono, 2-stereo, ...)
    end record 
        with Convention => C_Pass_By_Copy;

    -- Sound
    type Sound is record
        Stream      : Audio_Stream; -- Audio stream
        Frame_Count : unsigned;     -- Total number of frames (considering channels)
    end record
        with Convention => C_Pass_By_Copy;

    -- Music, audio stream, anything longer than ~10 seconds should be streamed
    type Music is record 
        Stream : Audio_Stream;
        Frame_Count : unsigned;

    end record 
        with Convention => C_Pass_By_Copy;

    -- TODO : file stuff

    --///////////////////////////////////////////////////////////////////////
    -- Enumerators Definition
    --///////////////////////////////////////////////////////////////////////

    --///////////////////////////////////////////////////////////////////////
    -- Predefined color constants
    --///////////////////////////////////////////////////////////////////////
    Light_Gray  : constant Color := (200, 200, 200, 255);
    Gray        : constant Color := (130, 130, 130, 255);
    Dark_Gray   : constant Color := (80, 80, 80, 255);
    Yellow      : constant Color := (253, 249, 0, 255);
    Gold        : constant Color := (255, 203, 0, 255);
    Orange      : constant Color := (255, 161, 0, 255);
    Pink        : constant Color := (255, 109, 194, 255);
    Red         : constant Color := (230, 41, 55, 255);
    Maroon      : constant Color := (190, 33, 55, 255);
    Green       : constant Color := (0, 228, 48, 255);
    Lime        : constant Color := (0, 158, 47, 255);
    Dark_Green  : constant Color := (0, 117, 44, 255);
    Sky_Blue    : constant Color := (102, 191, 255, 255);
    Blue        : constant Color := (0, 121, 241, 255);
    Dark_Blue   : constant Color := (0, 82, 172, 255);
    Purple      : constant Color := (200, 122, 255, 255);
    Violet      : constant Color := (135, 60, 190, 255);
    Dark_Purple : constant Color := (112, 31, 126, 255);
    Beige       : constant Color := (211, 176, 131, 255);
    Brown       : constant Color := (127, 106, 79, 255);
    Dark_Brown  : constant Color := (76, 63, 47, 255);

    White     : constant Color := (255, 255, 255, 255);
    Black     : constant Color := (0, 0, 0, 255);
    Blank     : constant Color := (0, 0, 0, 0);
    Magenta   : constant Color := (255, 0, 255, 255);
    Ray_White : constant Color := (245, 245, 245, 255);

    package Window is
        -- Initialize window and OpenGL context
        procedure Init (Width, Height : int; Title : String);
        -- Close window and unload OpenGL context
        procedure Close
            with Import        => true,
                 Convention    => C,
                 External_Name => "CloseWindow";
        -- Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
        function Should_Close return Boolean;
        -- Check if window has been initialized successfully
        function Is_Ready return Boolean;

    end Window;

    package Drawing is
        procedure Clear_Background (C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "ClearBackground";
        --
        -- Initializers and deinitializers for drawing modes
        --
        -- Setup the canvas (framebuffer) to start drawing
        procedure Start
            with Import        => true,
                 Convention    => C,
                 External_Name => "BeginDrawing";
        -- End drawing and swap buffers (double buffering)
        procedure Stop
            with Import        => true,
                 Convention    => C,
                 External_Name => "EndDrawing";
        -- Begin 2D mode with a custom camera (2D)
        procedure Start_2D_Mode (Camera : Camera_2D)
            with Import        => true,
                 Convention    => C,
                 External_Name => "BeginMode2D";
        -- End 2D mode with custom camera
        procedure Stop_2D_Mode
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "EndMode2D";
        -- Begin drawing to render texture
        procedure Start_Texture_Mode (Target : Render_Texture_2D) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "StartTextureMode";
        -- End drawing to render texture
        procedure Stop_Texture_Mode 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "EndTextureMode";
        -- Begin blending mode (alpha, addictive, multiplied, subtract, custom)
        procedure Start_Blend_Mode (Mode : int) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "BeginBlendMode";
        -- End blending mode (reset to default : alpha blending)
        procedure Stop_Blend_Mode 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "EndBlendMode";
        -- Begin scissor mode (define screen area for following drawing)
        procedure Start_Scissor_Mode (X, Y, Width, Height : int) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "BeginScissorMode";
        -- End scissor mode
        procedure Stop_Scissor_Mode 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "EndScissorMode";
       
        --///////////////////////////////////////////////////////////////////////
        -- Basic shapes Drawing functions (Module : shapes)
        --//////////////////////////////////////////////////////////////////////
        -- Draw a pixel using geometry (Can be slow, use with care)
        procedure Draw_Pixel (X, Y : int; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "DrawPixel";
        -- Draw a pixel using geometry (Vector version) (Can be slow, use with care)
        procedure Draw_Pixel_V (V : Vector_2; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "Draw_Pixel_V";
        -- Draw a line
        procedure Draw_Line (Start_X, Start_Y, End_X, End_Y : int; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "DrawLine";
        -- Draw a line (using GL lines)
        procedure Draw_Line_V (Start_Pos, End_Pos : Vector_2; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "DrawLineV";
        -- Draw a line (using triangles/quads)
        procedure Draw_Line_Ex (Start_Pos, End_Pos : Vector_2; Thick : Float; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "DrawLineEx";
        -- Draw lines sequence (using GL lines)
        procedure Draw_Line_Strip (Points : access Vector_2; Point_Count : int; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "DrawLineStrip";
        -- Draw a line segment cubic-bezier in-out interpolation
        procedure Draw_Line_Bezier (Start_Pos, End_Pos : Vector_2; Thick : Float; C : Color)
            with Import        => true,
                 Convention    => C,
                 External_Name => "DrawLineBezier";
        -- Draw a color-filled circle
        procedure Draw_Circle (Center_X, Center_Y : int; Radius : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircle";
        -- Draw a piece of a circle
        procedure Draw_Circle_Sector (Center : Vector_2; Radius, Start_Angle, End_Angle : Float; Segments : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircleSector";
        -- Draw circle sector outline
        procedure Draw_Circle_Sector_Lines (Center : Vector_2; Radius, Start_Angle, End_Angle : Float; Segments : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircleSectorLines";
        -- Draw gradient-filled circle
        procedure Draw_Circle_Gradient (Center_X, Center_Y : int; Radius : Float; Inner, Outer : Color)
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircleGradient";
        -- Draw color-filled circle (Vector version)
        procedure Draw_Circle_V (Center : Vector_2; Radius : Float; C : Color)
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircleV";
        -- Draw circle outline
        procedure Draw_Circle_Lines (Center_X, Center_Y : int; Radius : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircleLines";
        -- Draw circle outline (Vector version)
        procedure Draw_Circle_Lines_V (Center : Vector_2; Radius : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawCircleLinesV";
        -- Draw ellipse
        procedure Draw_Ellipse (Center_X, Center_Y : int; Radius_H, Radius_V : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawEllipse";
        -- Draw ellipse outline
        procedure Draw_Ellipse_Lines (Center_X, Center_Y : int; Radius_H, Radius_V : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawEllipseLines";
        -- Draw ring
        procedure Draw_Ring (Center : Vector_2; Inner_Radius, Outer_Radius, Start_Angle, End_Angle : Float; Segments : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRing";
        -- Draw ring outline
        procedure Draw_Ring_Lines (Center : Vector_2; Inner_Radius, Outer_Radius, Start_Angle, End_Angle : Float; Segments : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRingLines";
        -- Draw a color-filled rectangle
        procedure Draw_Rectangle (Pos_X, Pos_Y, Width, Height : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangle";
        -- Draw a color-filled rectangle (Vector version)
        procedure Draw_Rectangle_V (Position, Size : Vector_2; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleV";
        -- Draw a color-filled rectangle
        procedure Draw_Rectangle_Rec (Rec : Rectangle; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleRec";
        -- Draw a color-filled rectangle with pro parameters
        procedure Draw_Rectangle_Pro (Rec : Rectangle; Origin : Vector_2; Rotation : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectanglePro";
        -- Draw a vertical-gradient-filled rectangle
        procedure Draw_Rectangle_Gradient_V (Pos_X, Pos_Y, Width, Height : int; Top, Bottom : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleGradientV";
        -- Draw a horizontal-gradient-filled rectangle
        procedure Draw_Rectangle_Gradient_H (Pos_X, Pos_Y : int; Width, Height : int; Left, Right : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleGradientH";
        -- Draw a gradient-filled rectangle with custom vertex colors)
        procedure Draw_Rectangle_Gradient_Ex (Rec : Rectangle; Top_Left, Bottom_Left, Top_Right, Bottom_Right : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleGradientEx";
        -- Draw rectangle outline 
        procedure Draw_Rectangle_Lines (Pos_X, Pos_Y, Width, Height : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleLines";
        -- Draw rectangle outline with extended parameters
        procedure Draw_Rectangle_Lines_Ex (Rec : Rectangle; Line_Thick : Float; C : Color)
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleLinesEx";
        -- Draw rectangle with rounded edges
        procedure Draw_Rectangle_Rounded (Rec : Rectangle; Roundness : Float; Segments : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleRounded";
        -- Draw rectangle lines with rounded edges
        procedure Draw_Rectangle_Rounded_Lines (Rec : Rectangle; Roundness : Float; Segments : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleRoundedLines";
        -- Draw rectangle with rounded edges outline
        procedure Draw_Rectangle_Rounded_Lines_Ex (Rec : Rectangle; Roundness : Float; Segments : int; Line_Thick : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawRectangleRoundedLinesEx";
        -- Draw a color-filled triangle (vertex in counter-clockwise order!)
        procedure Draw_Triangle (V_1, V_2, V_3 : Vector_2; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawTriangle";
        -- Draw triangle outline (vertex in counter-clockwise order!)
        procedure Draw_Triangle_Lines (V_1, V_2, V_3 : Vector_2; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawTriangleLines";
        -- Draw a triangle fan defined by points (first vertex is the center)
        procedure Draw_Triangle_Fan (Points : access Vector_2; Point_Count : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawTriangleFan";
        -- Draw a triangle strip defined by points
        procedure Draw_Triangle_Strip (Points : access Vector_2; Point_Count : int; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawTriangleStrip";
        -- Draw a regular polygon (Vector version)
        procedure Draw_Poly (Center : Vector_2; Sides : int; Radius, Rotation : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawPoly";
        -- Draw a polygon outline of n sides
        procedure Draw_Poly_Lines (Center : Vector_2; Sides : int; Radius, Rotation : Float; C : Color) 
            with Import        => true,
                 Convention    => C, 
                 External_Name => "DrawPolyLines";
        -- Draw a polygon outline of n sides with extended parameters
        procedure Draw_Poly_Lines_Ex (Center : Vector_2; Sides : int; Radius, Rotation, Line_Thick : Float; C : Color) 
            with Import        => true, 
                 Convention    => C, 
                 External_Name => "DrawPolyLinesEx";
    end Drawing;

    package Timing is
        -- Set target FPS (maximum)
        procedure Set_Target_FPS (FPS : int)
            with Import        => true,
                 Convention    => C,
                 External_Name => "SetTargetFPS";
        -- Get time in seconds for last frame drawn (delta time)
        function Get_Frame_Time return Float
            with Import        => true,
                 Convention    => C,
                 External_Name => "GetFrameTime";
        -- Get time elapsed since InitWindow()
        function Get_Time return Double
            with Import        => true,
                 Convention    => C,
                 External_Name => "GetTime";
        -- Get current FPS
        function Get_FPS return int
            with Import        => true,
                 Convention    => C,
                 External_Name => "GetFPS";
    end Timing;
end Raylib;
