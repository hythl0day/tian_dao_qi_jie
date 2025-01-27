import 'package:flame/components.dart' show Vector2;

final kGridSize = Vector2(32.0, 28.0);
final kTileSpriteSrcSize = Vector2(32.0, 64.0);
final kTileOffset = Vector2(0.0, 16.0);
final kTileFogOffset = Vector2(-8.0, 0.0);
final kTileMapObjectSpriteSrcSize = Vector2(32.0, 48.0);

const kSpriteWater = 0;
const kSpriteLand = 1;
const kSpriteForest = 2;
const kSpriteMountain = 3;
const kSpriteFarmField = 4;
const kSpriteDungeonStonePavedTile = 5;

const kSpriteCity = 'object/city.png';
const kSpriteDungeon = 'object/dungeon.png';
const kSpriteArray = 'object/portalArray.png';
const kSpriteDungeonLever = 'object/lever.png';
const kSpriteDungeonLeverOn = 'object/leverOn.png';
const kSpriteTreasureBox = 'object/treasureBox.png';
const kSpriteTreasureBoxOpened = 'object/treasureBoxOpened.png';
const kSpriteDungeonGlowingTile = 'object/glowingTile.png';

const kSpriteCharacterYoungMan = 'object/characterYoungMan.png';
const kSpriteCharacterMan = 'object/characterMan.png';
const kSpriteCharacterOldMan = 'object/characterOldMan.png';
const kSpriteCharacterYoungWoman = 'object/characterYoungWoman.png';

const kTerrainKindVoid = 'void';
const kTerrainKindPlain = 'plain';
const kTerrainKindMountain = 'mountain';
const kTerrainKindForest = 'forest';
const kTerrainKindShore = 'shore';
const kTerrainKindLake = 'lake';
const kTerrainKindSea = 'sea';
const kTerrainKindRiver = 'river';
const kTerrainKindRoad = 'road';

const kColorModeZone = 0;
const kColorModeOrganization = 1;

const kMinHeroAge = 10;
const kMaxHeroAge = 20;

const kWorldMapAnimationPriority = 15000;

const kCloudPriority = 20000;
const kCouldKindsCount = 12;

const kSiteCardPriority = 500;

const kMouseCursorEffectPriority = 99999999;
