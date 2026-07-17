-- script by scrambled_egg3

-- i think ive mastered lua now...

-- edit just finished this script:
-- I AM SO PROUD OF THIS THIS IS THE BEST SCRIPT I HAVE EVER WRITTEN PLEASE IF YOU'RE GONNA USE THIS
-- PLEASE PLEASE PLEASE PLEASE PLEASE PLEASE PLEASE PLEASE PLEASE PLEASE PLEASE JUST CREDIT ME SOMEWHERE
-- ANYWHERE JUST A COMMENT IN THE CODE OH MY GOD

function goodNoteHit(index, noteData, noteType, isSustain)
    i = noteData -- super cool thing where each strum is handled seperately
    --i = 5 -- i use this one to show the differences side by side
        
    if noteType == 'Blythe Sing' then -- change this to your custom note
        setPropertyFromGroup('playerStrums', i, 'rgbShader.b', 0xAAAAAA) -- these are the custom note colors
        setPropertyFromGroup('playerStrums', i, 'rgbShader.g', 0xDDDDDD)
        setPropertyFromGroup('playerStrums', i, 'rgbShader.r', 0xFFFFFF)
    elseif noteType == '' then
        if noteData == 0 then
            defaultR = ZEROR
            defaultG = ZEROG
            defaultB = ZEROB
        elseif noteData == 1 then
            defaultR = UNOR
            defaultG = UNOG
            defaultB = UNOB
        elseif noteData == 2 then
            defaultR = TWOR
            defaultG = TWOG
            defaultB = TWOB
        elseif noteData == 3 then
            defaultR = TRESR
            defaultG = TRESG
            defaultB = TRESB
        end

        setPropertyFromGroup('playerStrums', i, 'rgbShader.b', defaultB)
        setPropertyFromGroup('playerStrums', i, 'rgbShader.g', defaultG)
        setPropertyFromGroup('playerStrums', i, 'rgbShader.r', defaultR)
    end
end

function onCreatePost()
    runHaxeCode([[
        import psychlua.FunkinLua;

        // "i haven't mastered haxe/hscript but i can definitely work with it"
        // i said, right before i starting locking in on the code

        var ZERORGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[0];
        var UNORGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[1];
        var TWORGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[2];
        var TRESRGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[3];

        var ZEROR:Int = ZERORGBValues[0];
        var ZEROG:Int = ZERORGBValues[1];
        var ZEROB:Int = ZERORGBValues[2];

        var UNOR:Int = UNORGBValues[0];
        var UNOG:Int = UNORGBValues[1];
        var UNOB:Int = UNORGBValues[2];

        var TWOR:Int = TWORGBValues[0];
        var TWOG:Int = TWORGBValues[1];
        var TWOB:Int = TWORGBValues[2];

        var TRESR:Int = TRESRGBValues[0];
        var TRESG:Int = TRESRGBValues[1];
        var TRESB:Int = TRESRGBValues[2];
        
        setOnScripts('ZEROR', ZEROR);
        setOnScripts('ZEROG', ZEROG);
        setOnScripts('ZEROB', ZEROB);
        
        setOnScripts('UNOR', UNOR);
        setOnScripts('UNOG', UNOG);
        setOnScripts('UNOB', UNOB);
        
        setOnScripts('TWOR', TWOR);
        setOnScripts('TWOG', TWOG);
        setOnScripts('TWOB', TWOB);
        
        setOnScripts('TRESR', TRESR);
        setOnScripts('TRESG', TRESG);
        setOnScripts('TRESB', TRESB);
    ]])
end