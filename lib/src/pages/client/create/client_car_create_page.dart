import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:uber_clone_flutter/src/pages/client/create/client_car_create_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/brandCars.dart';


List brands = [{"brand": "Seat", "models": ["Alhambra", "Altea", "Altea XL", "Arosa", "Cordoba", "Cordoba Vario", "Exeo", "Ibiza", "Ibiza ST", "Exeo ST", "Leon", "Leon ST", "Inca", "Mii", "Toledo"]},
  {"brand": "Renault", "models": ["Captur", "Clio", "Clio Grandtour", "Espace", "Express", "Fluence", "Grand Espace", "Grand Modus", "Grand Scenic", "Kadjar", "Kangoo", "Kangoo Express", "Koleos", "Laguna", "Laguna Grandtour", "Latitude", "Mascott", "Mégane", "Mégane CC", "Mégane Combi", "Mégane Grandtour", "Mégane Coupé", "Mégane Scénic", "Scénic", "Talisman", "Talisman Grandtour", "Thalia", "Twingo", "Wind", "Zoé"]},
  {"brand": "Peugeot", "models": ["1007", "107", "106", "108", "2008", "205", "205 Cabrio", "206", "206 CC", "206 SW", "207", "207 CC", "207 SW", "306", "307", "307 CC", "307 SW", "308", "308 CC", "308 SW", "309", "4007", "4008", "405", "406", "407", "407 SW", "5008", "508", "508 SW", "605", "806", "607", "807", "Bipper", "RCZ"]},
  {"brand": "Dacia", "models": ["Dokker", "Duster", "Lodgy", "Logan", "Logan MCV", "Logan Van", "Sandero", "Solenza"]},
  {"brand": "Citroën", "models": ["Berlingo", "C-Crosser", "C-Elissée", "C-Zero", "C1", "C2", "C3", "C3 Picasso", "C4", "C4 Aircross", "C4 Cactus", "C4 Coupé", "C4 Grand Picasso", "C4 Sedan", "C5", "C5 Break", "C5 Tourer", "C6", "C8", "DS3", "DS4", "DS5", "Evasion", "Jumper", "Jumpy", "Saxo", "Nemo", "Xantia", "Xsara"]},
  {"brand": "Opel", "models": ["Agila", "Ampera", "Antara", "Astra", "Astra cabrio", "Astra caravan", "Astra coupé", "Calibra", "Campo", "Cascada", "Corsa", "Frontera", "Insignia", "Insignia kombi", "Kadett", "Meriva", "Mokka", "Movano", "Omega", "Signum", "Vectra", "Vectra Caravan", "Vivaro", "Vivaro Kombi", "Zafira"]},
  {"brand": "Alfa Romeo", "models": ["145", "146", "147", "155", "156", "156 Sportwagon", "159", "159 Sportwagon", "164", "166", "4C", "Brera", "GTV", "MiTo", "Crosswagon", "Spider", "GT", "Giulietta", "Giulia"]},
  {"brand": "Škoda", "models": ["Favorit", "Felicia", "Citigo", "Fabia", "Fabia Combi", "Fabia Sedan", "Felicia Combi", "Octavia", "Octavia Combi", "Roomster", "Yeti", "Rapid", "Rapid Spaceback", "Superb", "Superb Combi"]},
  {"brand": "Chevrolet", "models": ["Alero", "Aveo", "Camaro", "Captiva", "Corvette", "Cruze", "Cruze SW", "Epica", "Equinox", "Evanda", "HHR", "Kalos", "Lacetti", "Lacetti SW", "Lumina", "Malibu", "Matiz", "Monte Carlo", "Nubira", "Orlando", "Spark", "Suburban", "Tacuma", "Tahoe", "Trax"]},
  {"brand": "Porsche", "models": ["911 Carrera", "911 Carrera Cabrio", "911 Targa", "911 Turbo", "924", "944", "997", "Boxster", "Cayenne", "Cayman", "Macan", "Panamera"]},
  {"brand": "Honda", "models": ["Accord", "Accord Coupé", "Accord Tourer", "City", "Civic", "Civic Aerodeck", "Civic Coupé", "Civic Tourer", "Civic Type R", "CR-V", "CR-X", "CR-Z", "FR-V", "HR-V", "Insight", "Integra", "Jazz", "Legend", "Prelude"]},
  {"brand": "Subaru", "models": ["BRZ", "Forester", "Impreza", "Impreza Wagon", "Justy", "Legacy", "Legacy Wagon", "Legacy Outback", "Levorg", "Outback", "SVX", "Tribeca", "Tribeca B9", "XV"]},
  {"brand": "Mazda", "models": ["121", "2", "3", "323", "323 Combi", "323 Coupé", "323 F", "5", "6", "6 Combi", "626", "626 Combi", "B-Fighter", "B2500", "BT", "CX-3", "CX-5", "CX-7", "CX-9", "Demio", "MPV", "MX-3", "MX-5", "MX-6", "Premacy", "RX-7", "RX-8", "Xedox 6"]},
  {"brand": "Mitsubishi", "models": ["3000 GT", "ASX", "Carisma", "Colt", "Colt CC", "Eclipse", "Fuso canter", "Galant", "Galant Combi", "Grandis", "L200", "L200 Pick up", "L200 Pick up Allrad", "L300", "Lancer", "Lancer Combi", "Lancer Evo", "Lancer Sportback", "Outlander", "Pajero", "Pajeto Pinin", "Pajero Pinin Wagon", "Pajero Sport", "Pajero Wagon", "Space Star"]},
  {"brand": "Lexus", "models": ["CT", "GS", "GS 300", "GX", "IS", "IS 200", "IS 250 C", "IS-F", "LS", "LX", "NX", "RC F", "RX", "RX 300", "RX 400h", "RX 450h", "SC 430"]},
  {"brand": "Toyota", "models": ["4-Runner", "Auris", "Avensis", "Avensis Combi", "Avensis Van Verso", "Aygo", "Camry", "Carina", "Celica", "Corolla", "Corolla Combi", "Corolla sedan", "Corolla Verso", "FJ Cruiser", "GT86", "Hiace", "Hiace Van", "Highlander", "Hilux", "Land Cruiser", "MR2", "Paseo", "Picnic", "Prius", "RAV4", "Sequoia", "Starlet", "Supra", "Tundra", "Urban Cruiser", "Verso", "Yaris", "Yaris Verso"]},
  {"brand": "BMW", "models": ["i3", "i8", "M3", "M4", "M5", "M6", "Rad 1", "Rad 1 Cabrio", "Rad 1 Coupé", "Rad 2", "Rad 2 Active Tourer", "Rad 2 Coupé", "Rad 2 Gran Tourer", "Rad 3", "Rad 3 Cabrio", "Rad 3 Compact", "Rad 3 Coupé", "Rad 3 GT", "Rad 3 Touring", "Rad 4", "Rad 4 Cabrio", "Rad 4 Gran Coupé", "Rad 5", "Rad 5 GT", "Rad 5 Touring", "Rad 6", "Rad 6 Cabrio", "Rad 6 Coupé", "Rad 6 Gran Coupé", "Rad 7", "Rad 8 Coupé", "X1", "X3", "X4", "X5", "X6", "Z3", "Z3 Coupé", "Z3 Roadster", "Z4", "Z4 Roadster"]},
  {"brand": "Volkswagen", "models": ["Amarok", "Beetle", "Bora", "Bora Variant", "Caddy", "Caddy Van", "Life", "California", "Caravelle", "CC", "Crafter", "Crafter Van", "Crafter Kombi", "CrossTouran", "Eos", "Fox", "Golf", "Golf Cabrio", "Golf Plus", "Golf Sportvan", "Golf Variant", "Jetta", "LT", "Lupo", "Multivan", "New Beetle", "New Beetle Cabrio", "Passat", "Passat Alltrack", "Passat CC", "Passat Variant", "Passat Variant Van", "Phaeton", "Polo", "Polo Van", "Polo Variant", "Scirocco", "Sharan", "T4", "T4 Caravelle", "T4 Multivan", "T5", "T5 Caravelle", "T5 Multivan", "T5 Transporter Shuttle", "Tiguan", "Touareg", "Touran"]},
  {"brand": "Suzuki", "models": ["Alto", "Baleno", "Baleno kombi", "Grand Vitara", "Grand Vitara XL-7", "Ignis", "Jimny", "Kizashi", "Liana", "Samurai", "Splash", "Swift", "SX4", "SX4 Sedan", "Vitara", "Wagon R+"]},
  {"brand": "Mercedes-Benz", "models": ["100 D", "115", "124", "126", "190", "190 D", "190 E", "200 - 300", "200 D", "200 E", "210 Van", "210 kombi", "310 Van", "310 kombi", "230 - 300 CE Coupé", "260 - 560 SE", "260 - 560 SEL", "500 - 600 SEC Coupé", "Trieda A", "A", "A L", "AMG GT", "Trieda B", "Trieda C", "C", "C Sportcoupé", "C T", "Citan", "CL", "CL", "CLA", "CLC", "CLK Cabrio", "CLK Coupé", "CLS", "Trieda E", "E", "E Cabrio", "E Coupé", "E T", "Trieda G", "G Cabrio", "GL", "GLA", "GLC", "GLE", "GLK", "Trieda M", "MB 100", "Trieda R", "Trieda S", "S", "S Coupé", "SL", "SLC", "SLK", "SLR", "Sprinter"]},
  {"brand": "Saab", "models": ["9-3", "9-3 Cabriolet", "9-3 Coupé", "9-3 SportCombi", "9-5", "9-5 SportCombi", "900", "900 C", "900 C Turbo", "9000"]},
  {"brand": "Audi", "models": ["100", "100 Avant", "80", "80 Avant", "80 Cabrio", "90", "A1", "A2", "A3", "A3 Cabriolet", "A3 Limuzina", "A3 Sportback", "A4", "A4 Allroad", "A4 Avant", "A4 Cabriolet", "A5", "A5 Cabriolet", "A5 Sportback", "A6", "A6 Allroad", "A6 Avant", "A7", "A8", "A8 Long", "Q3", "Q5", "Q7", "R8", "RS4 Cabriolet", "RS4/RS4 Avant", "RS5", "RS6 Avant", "RS7", "S3/S3 Sportback", "S4 Cabriolet", "S4/S4 Avant", "S5/S5 Cabriolet", "S6/RS6", "S7", "S8", "SQ5", "TT Coupé", "TT Roadster", "TTS"]},
  {"brand": "Kia", "models": ["Avella", "Besta", "Carens", "Carnival", "Cee`d", "Cee`d SW", "Cerato", "K 2500", "Magentis", "Opirus", "Optima", "Picanto", "Pregio", "Pride", "Pro Cee`d", "Rio", "Rio Combi", "Rio sedan", "Sephia", "Shuma", "Sorento", "Soul", "Sportage", "Venga"]},
  {"brand": "Land Rover", "models": ["109", "Defender", "Discovery", "Discovery Sport", "Freelander", "Range Rover", "Range Rover Evoque", "Range Rover Sport"]},
  {"brand": "Dodge", "models": ["Avenger", "Caliber", "Challenger", "Charger", "Grand Caravan", "Journey", "Magnum", "Nitro", "RAM", "Stealth", "Viper"]},
  {"brand": "Chrysler", "models": ["300 C", "300 C Touring", "300 M", "Crossfire", "Grand Voyager", "LHS", "Neon", "Pacifica", "Plymouth", "PT Cruiser", "Sebring", "Sebring Convertible", "Stratus", "Stratus Cabrio", "Town & Country", "Voyager"]},
  {"brand": "Ford", "models": ["Aerostar", "B-Max", "C-Max", "Cortina", "Cougar", "Edge", "Escort", "Escort Cabrio", "Escort kombi", "Explorer", "F-150", "F-250", "Fiesta", "Focus", "Focus C-Max", "Focus CC", "Focus kombi", "Fusion", "Galaxy", "Grand C-Max", "Ka", "Kuga", "Maverick", "Mondeo", "Mondeo Combi", "Mustang", "Orion", "Puma", "Ranger", "S-Max", "Sierra", "Street Ka", "Tourneo Connect", "Tourneo Custom", "Transit", "Transit", "Transit Bus", "Transit Connect LWB", "Transit Courier", "Transit Custom", "Transit kombi", "Transit Tourneo", "Transit Valnik", "Transit Van", "Transit Van 350", "Windstar"]},
  {"brand": "Hummer", "models": ["H2", "H3"]},
  {"brand": "Hyundai", "models": ["Accent", "Atos", "Atos Prime", "Coupé", "Elantra", "Galloper", "Genesis", "Getz", "Grandeur", "H 350", "H1", "H1 Bus", "H1 Van", "H200", "i10", "i20", "i30", "i30 CW", "i40", "i40 CW", "ix20", "ix35", "ix55", "Lantra", "Matrix", "Santa Fe", "Sonata", "Terracan", "Trajet", "Tucson", "Veloster"]},
  {"brand": "Infiniti", "models": ["EX", "FX", "G", "G Coupé", "M", "Q", "QX"]},
  {"brand": "Jaguar", "models": ["Daimler", "F-Pace", "F-Type", "S-Type", "Sovereign", "X-Type", "X-type Estate", "XE", "XF", "XJ", "XJ12", "XJ6", "XJ8", "XJ8", "XJR", "XK", "XK8 Convertible", "XKR", "XKR Convertible"]},
  {"brand": "Jeep", "models": ["Cherokee", "Commander", "Compass", "Grand Cherokee", "Patriot", "Renegade", "Wrangler"]},
  {"brand": "Nissan", "models": ["100 NX", "200 SX", "350 Z", "350 Z Roadster", "370 Z", "Almera", "Almera Tino", "Cabstar E - T", "Cabstar TL2 Valnik", "e-NV200", "GT-R", "Insterstar", "Juke", "King Cab", "Leaf", "Maxima", "Maxima QX", "Micra", "Murano", "Navara", "Note", "NP300 Pickup", "NV200", "NV400", "Pathfinder", "Patrol", "Patrol GR", "Pickup", "Pixo", "Primastar", "Primastar Combi", "Primera", "Primera Combi", "Pulsar", "Qashqai", "Serena", "Sunny", "Terrano", "Tiida", "Trade", "Vanette Cargo", "X-Trail"]},
  {"brand": "Volvo", "models": ["240", "340", "360", "460", "850", "850 kombi", "C30", "C70", "C70 Cabrio", "C70 Coupé", "S40", "S60", "S70", "S80", "S90", "V40", "V50", "V60", "V70", "V90", "XC60", "XC70", "XC90"]},
  {"brand": "Daewoo", "models": ["Espero", "Kalos", "Lacetti", "Lanos", "Leganza", "Lublin", "Matiz", "Nexia", "Nubira", "Nubira kombi", "Racer", "Tacuma", "Tico"]},
  {"brand": "Fiat", "models": ["1100", "126", "500", "500L", "500X", "850", "Barchetta", "Brava", "Cinquecento", "Coupé", "Croma", "Doblo", "Doblo Cargo", "Doblo Cargo Combi", "Ducato", "Ducato Van", "Ducato Kombi", "Ducato Podvozok", "Florino", "Florino Combi", "Freemont", "Grande Punto", "Idea", "Linea", "Marea", "Marea Weekend", "Multipla", "Palio Weekend", "Panda", "Panda Van", "Punto", "Punto Cabriolet", "Punto Evo", "Punto Van", "Qubo", "Scudo", "Scudo Van", "Scudo Kombi", "Sedici", "Seicento", "Stilo", "Stilo Multiwagon", "Strada", "Talento", "Tipo", "Ulysse", "Uno", "X1/9"]},
  {"brand": "MINI", "models": ["Cooper", "Cooper Cabrio", "Cooper Clubman", "Cooper D", "Cooper D Clubman", "Cooper S", "Cooper S Cabrio", "Cooper S Clubman", "Countryman", "Mini One", "One D"]},
  {"brand": "Rover", "models": ["200", "214", "218", "25", "400", "414", "416", "620", "75"]},
  {"brand": "Smart", "models": ["Cabrio", "City-Coupé", "Compact Pulse", "Forfour", "Fortwo cabrio", "Fortwo coupé", "Roadster"]}];

List marcasFacheritas = [ "Alhambra", "Altea", "Altea XL", "Arosa", "Cordoba", "Cordoba Vario", "Exeo", "Ibiza", "Ibiza ST", "Exeo ST", "Leon", "Leon ST", "Inca", "Mii", "Toledo",
  "Captur", "Clio", "Clio Grandtour", "Espace", "Express", "Fluence", "Grand Espace", "Grand Modus", "Grand Scenic", "Kadjar", "Kangoo", "Kangoo Express", "Koleos", "Laguna", "Laguna Grandtour", "Latitude", "Mascott", "Mégane", "Mégane CC", "Mégane Combi", "Mégane Grandtour", "Mégane Coupé", "Mégane Scénic", "Scénic", "Talisman", "Talisman Grandtour", "Thalia", "Twingo", "Wind", "Zoé",
  "1007", "107", "106", "108", "2008", "205", "205 Cabrio", "206", "206 CC", "206 SW", "207", "207 CC", "207 SW", "306", "307", "307 CC", "307 SW", "308", "308 CC", "308 SW", "309", "4007", "4008", "405", "406", "407", "407 SW", "5008", "508", "508 SW", "605", "806", "607", "807", "Bipper", "RCZ",
  "Dokker", "Duster", "Lodgy", "Logan", "Logan MCV", "Logan Van", "Sandero", "Solenza",
  "Berlingo", "C-Crosser", "C-Elissée", "C-Zero", "C1", "C2", "C3", "C3 Picasso", "C4", "C4 Aircross", "C4 Cactus", "C4 Coupé", "C4 Grand Picasso", "C4 Sedan", "C5", "C5 Break", "C5 Tourer", "C6", "C8", "DS3", "DS4", "DS5", "Evasion", "Jumper", "Jumpy", "Saxo", "Nemo", "Xantia", "Xsara",
  "Agila", "Ampera", "Antara", "Astra", "Astra cabrio", "Astra caravan", "Astra coupé", "Calibra", "Campo", "Cascada", "Corsa", "Frontera", "Insignia", "Insignia kombi", "Kadett", "Meriva", "Mokka", "Movano", "Omega", "Signum", "Vectra", "Vectra Caravan", "Vivaro", "Vivaro Kombi", "Zafira",
  "145", "146", "147", "155", "156", "156 Sportwagon", "159", "159 Sportwagon", "164", "166", "4C", "Brera", "GTV", "MiTo", "Crosswagon", "Spider", "GT", "Giulietta", "Giulia",
  "Favorit", "Felicia", "Citigo", "Fabia", "Fabia Combi", "Fabia Sedan", "Felicia Combi", "Octavia", "Octavia Combi", "Roomster", "Yeti", "Rapid", "Rapid Spaceback", "Superb", "Superb Combi",
  "Alero", "Aveo", "Camaro", "Captiva", "Corvette", "Cruze", "Cruze SW", "Epica", "Equinox", "Evanda", "HHR", "Kalos", "Lacetti", "Lacetti SW", "Lumina", "Malibu", "Matiz", "Monte Carlo", "Nubira", "Orlando", "Spark", "Suburban", "Tacuma", "Tahoe", "Trax",
  "911 Carrera", "911 Carrera Cabrio", "911 Targa", "911 Turbo", "924", "944", "997", "Boxster", "Cayenne", "Cayman", "Macan", "Panamera",
  "Accord", "Accord Coupé", "Accord Tourer", "City", "Civic", "Civic Aerodeck", "Civic Coupé", "Civic Tourer", "Civic Type R", "CR-V", "CR-X", "CR-Z", "FR-V", "HR-V", "Insight", "Integra", "Jazz", "Legend", "Prelude",
  "BRZ", "Forester", "Impreza", "Impreza Wagon", "Justy", "Legacy", "Legacy Wagon", "Legacy Outback", "Levorg", "Outback", "SVX", "Tribeca", "Tribeca B9", "XV",
  "121", "2", "3", "323", "323 Combi", "323 Coupé", "323 F", "5", "6", "6 Combi", "626", "626 Combi", "B-Fighter", "B2500", "BT", "CX-3", "CX-5", "CX-7", "CX-9", "Demio", "MPV", "MX-3", "MX-5", "MX-6", "Premacy", "RX-7", "RX-8", "Xedox 6",
  "3000 GT", "ASX", "Carisma", "Colt", "Colt CC", "Eclipse", "Fuso canter", "Galant", "Galant Combi", "Grandis", "L200", "L200 Pick up", "L200 Pick up Allrad", "L300", "Lancer", "Lancer Combi", "Lancer Evo", "Lancer Sportback", "Outlander", "Pajero", "Pajeto Pinin", "Pajero Pinin Wagon", "Pajero Sport", "Pajero Wagon", "Space Star",
  "CT", "GS", "GS 300", "GX", "IS", "IS 200", "IS 250 C", "IS-F", "LS", "LX", "NX", "RC F", "RX", "RX 300", "RX 400h", "RX 450h", "SC 430",
  "4-Runner", "Auris", "Avensis", "Avensis Combi", "Avensis Van Verso", "Aygo", "Camry", "Carina", "Celica", "Corolla", "Corolla Combi", "Corolla sedan", "Corolla Verso", "FJ Cruiser", "GT86", "Hiace", "Hiace Van", "Highlander", "Hilux", "Land Cruiser", "MR2", "Paseo", "Picnic", "Prius", "RAV4", "Sequoia", "Starlet", "Supra", "Tundra", "Urban Cruiser", "Verso", "Yaris", "Yaris Verso",
  "i3", "i8", "M3", "M4", "M5", "M6", "Rad 1", "Rad 1 Cabrio", "Rad 1 Coupé", "Rad 2", "Rad 2 Active Tourer", "Rad 2 Coupé", "Rad 2 Gran Tourer", "Rad 3", "Rad 3 Cabrio", "Rad 3 Compact", "Rad 3 Coupé", "Rad 3 GT", "Rad 3 Touring", "Rad 4", "Rad 4 Cabrio", "Rad 4 Gran Coupé", "Rad 5", "Rad 5 GT", "Rad 5 Touring", "Rad 6", "Rad 6 Cabrio", "Rad 6 Coupé", "Rad 6 Gran Coupé", "Rad 7", "Rad 8 Coupé", "X1", "X3", "X4", "X5", "X6", "Z3", "Z3 Coupé", "Z3 Roadster", "Z4", "Z4 Roadster",
  "Amarok", "Beetle", "Bora", "Bora Variant", "Caddy", "Caddy Van", "Life", "California", "Caravelle", "CC", "Crafter", "Crafter Van", "Crafter Kombi", "CrossTouran", "Eos", "Fox", "Golf", "Golf Cabrio", "Golf Plus", "Golf Sportvan", "Golf Variant", "Jetta", "LT", "Lupo", "Multivan", "New Beetle", "New Beetle Cabrio", "Passat", "Passat Alltrack", "Passat CC", "Passat Variant", "Passat Variant Van", "Phaeton", "Polo", "Polo Van", "Polo Variant", "Scirocco", "Sharan", "T4", "T4 Caravelle", "T4 Multivan", "T5", "T5 Caravelle", "T5 Multivan", "T5 Transporter Shuttle", "Tiguan", "Touareg", "Touran",
  "Alto", "Baleno", "Baleno kombi", "Grand Vitara", "Grand Vitara XL-7", "Ignis", "Jimny", "Kizashi", "Liana", "Samurai", "Splash", "Swift", "SX4", "SX4 Sedan", "Vitara", "Wagon R+",
  "100 D", "115", "124", "126", "190", "190 D", "190 E", "200 - 300", "200 D", "200 E", "210 Van", "210 kombi", "310 Van", "310 kombi", "230 - 300 CE Coupé", "260 - 560 SE", "260 - 560 SEL", "500 - 600 SEC Coupé", "Trieda A", "A", "A L", "AMG GT", "Trieda B", "Trieda C", "C", "C Sportcoupé", "C T", "Citan", "CL", "CL", "CLA", "CLC", "CLK Cabrio", "CLK Coupé", "CLS", "Trieda E", "E", "E Cabrio", "E Coupé", "E T", "Trieda G", "G Cabrio", "GL", "GLA", "GLC", "GLE", "GLK", "Trieda M", "MB 100", "Trieda R", "Trieda S", "S", "S Coupé", "SL", "SLC", "SLK", "SLR", "Sprinter",
  "9-3", "9-3 Cabriolet", "9-3 Coupé", "9-3 SportCombi", "9-5", "9-5 SportCombi", "900", "900 C", "900 C Turbo", "9000",
  "100", "100 Avant", "80", "80 Avant", "80 Cabrio", "90", "A1", "A2", "A3", "A3 Cabriolet", "A3 Limuzina", "A3 Sportback", "A4", "A4 Allroad", "A4 Avant", "A4 Cabriolet", "A5", "A5 Cabriolet", "A5 Sportback", "A6", "A6 Allroad", "A6 Avant", "A7", "A8", "A8 Long", "Q3", "Q5", "Q7", "R8", "RS4 Cabriolet", "RS4/RS4 Avant", "RS5", "RS6 Avant", "RS7", "S3/S3 Sportback", "S4 Cabriolet", "S4/S4 Avant", "S5/S5 Cabriolet", "S6/RS6", "S7", "S8", "SQ5", "TT Coupé", "TT Roadster", "TTS",
  "Avella", "Besta", "Carens", "Carnival", "Cee`d", "Cee`d SW", "Cerato", "K 2500", "Magentis", "Opirus", "Optima", "Picanto", "Pregio", "Pride", "Pro Cee`d", "Rio", "Rio Combi", "Rio sedan", "Sephia", "Shuma", "Sorento", "Soul", "Sportage", "Venga",
  "109", "Defender", "Discovery", "Discovery Sport", "Freelander", "Range Rover", "Range Rover Evoque", "Range Rover Sport",
  "Avenger", "Caliber", "Challenger", "Charger", "Grand Caravan", "Journey", "Magnum", "Nitro", "RAM", "Stealth", "Viper",
  "300 C", "300 C Touring", "300 M", "Crossfire", "Grand Voyager", "LHS", "Neon", "Pacifica", "Plymouth", "PT Cruiser", "Sebring", "Sebring Convertible", "Stratus", "Stratus Cabrio", "Town & Country", "Voyager",
  "Aerostar", "B-Max", "C-Max", "Cortina", "Cougar", "Edge", "Escort", "Escort Cabrio", "Escort kombi", "Explorer", "F-150", "F-250", "Fiesta", "Focus", "Focus C-Max", "Focus CC", "Focus kombi", "Fusion", "Galaxy", "Grand C-Max", "Ka", "Kuga", "Maverick", "Mondeo", "Mondeo Combi", "Mustang", "Orion", "Puma", "Ranger", "S-Max", "Sierra", "Street Ka", "Tourneo Connect", "Tourneo Custom", "Transit", "Transit", "Transit Bus", "Transit Connect LWB", "Transit Courier", "Transit Custom", "Transit kombi", "Transit Tourneo", "Transit Valnik", "Transit Van", "Transit Van 350", "Windstar",
  "H2", "H3",
  "Accent", "Atos", "Atos Prime", "Coupé", "Elantra", "Galloper", "Genesis", "Getz", "Grandeur", "H 350", "H1", "H1 Bus", "H1 Van", "H200", "i10", "i20", "i30", "i30 CW", "i40", "i40 CW", "ix20", "ix35", "ix55", "Lantra", "Matrix", "Santa Fe", "Sonata", "Terracan", "Trajet", "Tucson", "Veloster",
  "EX", "FX", "G", "G Coupé", "M", "Q", "QX",
  "Daimler", "F-Pace", "F-Type", "S-Type", "Sovereign", "X-Type", "X-type Estate", "XE", "XF", "XJ", "XJ12", "XJ6", "XJ8", "XJ8", "XJR", "XK", "XK8 Convertible", "XKR", "XKR Convertible",
  "Cherokee", "Commander", "Compass", "Grand Cherokee", "Patriot", "Renegade", "Wrangler",
  "100 NX", "200 SX", "350 Z", "350 Z Roadster", "370 Z", "Almera", "Almera Tino", "Cabstar E - T", "Cabstar TL2 Valnik", "e-NV200", "GT-R", "Insterstar", "Juke", "King Cab", "Leaf", "Maxima", "Maxima QX", "Micra", "Murano", "Navara", "Note", "NP300 Pickup", "NV200", "NV400", "Pathfinder", "Patrol", "Patrol GR", "Pickup", "Pixo", "Primastar", "Primastar Combi", "Primera", "Primera Combi", "Pulsar", "Qashqai", "Serena", "Sunny", "Terrano", "Tiida", "Trade", "Vanette Cargo", "X-Trail",
  "240", "340", "360", "460", "850", "850 kombi", "C30", "C70", "C70 Cabrio", "C70 Coupé", "S40", "S60", "S70", "S80", "S90", "V40", "V50", "V60", "V70", "V90", "XC60", "XC70", "XC90",
  "Espero", "Kalos", "Lacetti", "Lanos", "Leganza", "Lublin", "Matiz", "Nexia", "Nubira", "Nubira kombi", "Racer", "Tacuma", "Tico",
  "1100", "126", "500", "500L", "500X", "850", "Barchetta", "Brava", "Cinquecento", "Coupé", "Croma", "Doblo", "Doblo Cargo", "Doblo Cargo Combi", "Ducato", "Ducato Van", "Ducato Kombi", "Ducato Podvozok", "Florino", "Florino Combi", "Freemont", "Grande Punto", "Idea", "Linea", "Marea", "Marea Weekend", "Multipla", "Palio Weekend", "Panda", "Panda Van", "Punto", "Punto Cabriolet", "Punto Evo", "Punto Van", "Qubo", "Scudo", "Scudo Van", "Scudo Kombi", "Sedici", "Seicento", "Stilo", "Stilo Multiwagon", "Strada", "Talento", "Tipo", "Ulysse", "Uno", "X1/9",
  "Cooper", "Cooper Cabrio", "Cooper Clubman", "Cooper D", "Cooper D Clubman", "Cooper S", "Cooper S Cabrio", "Cooper S Clubman", "Countryman", "Mini One", "One D",
  "200", "214", "218", "25", "400", "414", "416", "620", "75",
  "Cabrio", "City-Coupé", "Compact Pulse", "Forfour", "Fortwo cabrio", "Fortwo coupé", "Roadster"];



class CLientCarCreatePage extends StatefulWidget {
  const CLientCarCreatePage({Key key}) : super(key: key);

  @override
  _CLientCarCreatePageState createState() => _CLientCarCreatePageState();
}

class _CLientCarCreatePageState extends State<CLientCarCreatePage> {
  String holder = '';
  String holder2 = '';
  String dropdownValueBrand = "Seleccccc";
  String dropdownValueBrand2 = "Seleccccc";
  void getDropDownItem(){

    setState(() {
      holder = dropdownValueBrand ;
      holder2 = dropdownValueBrand2 ;

    });


  }

  ClientCarCreateController _con = new ClientCarCreateController();
  //DEFAULT CAR COLOR
  Color currentColor = Colors.limeAccent;
  String dropdownValue = 'Año';
  //SET COLOR TO CURRENT COLOR
  //void changeColor(Color color) => setState(() => currentColor = color);
  void setStateColor(Color color){
    setState(() {
      currentColor = color;
      //_con.selectedCarColor =currentColor.toString();
      _con.onSelectedColor(currentColor.toString());
    });
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();


    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(//BODY BACKGROUND COLOR

        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/img/encamino.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect( // make sure we apply clip it properly
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),

    child: Scaffold(
        //Bottom overflowed by x pixels when showing keyboard
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Agrega un auto'),
        ),
        body: Column(
          children: [
            _textImg(),
            _photoColorCar(),
            _marcaModelo(),
            _yearDescripcion(),
            _placa(),
            _changeColor(),
            _imageColorCar()
          ],

        ),


        bottomNavigationBar: _buttonCreate(),
      ),
    )
        )
    );
  }

  //TWO ELEMENTS
  Widget _marcaModelo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
         child: _textFieldMarca(),
        ),
        Expanded(
          child: _textFieldModelo(),
        ),

      ],
    );
  }

  Widget _yearDescripcion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _textFieldYear()
        )
      ],
    );
  }

  Widget _placa(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _textFieldPlaca()
        )
      ],
    );
  }


  Widget _changeColor(){
    return Container(
      margin: EdgeInsets.only(top: 0,bottom:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: _color()
          )
        ],
      ),
    );
  }

  Widget _color(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
            elevation: 1.0,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: currentColor,
                        onColorChanged: setStateColor,
                        colorPickerWidth: 300.0,
                        pickerAreaHeightPercent: 0.2,
                        enableAlpha: true,
                        displayThumbColor: true,
                        showLabel: true,
                        paletteType: PaletteType.hsv,
                        pickerAreaBorderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(2.0),
                          topRight: const Radius.circular(2.0),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text('Selecciona color',
            style: TextStyle(
              fontFamily: 'Lexendeca-Regular',
            ),),
            color: Colors.black,
            textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _textImg() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          "Seleciona o toma una foto",
          style:  TextStyle(
          color: Colors.white,
          fontFamily: 'Lexendeca-Regular',
          )
        ),

    );
  }


  Widget _photoColorCar() {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: GestureDetector(
        onTap: _con.showAlertDialog,
        child: CircleAvatar(
          backgroundImage: _con.imageFile != null
              ? FileImage(_con.imageFile)
              : AssetImage('assets/img/pushf.png'),
          radius: 60,
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _imageColorCar() {
    return GestureDetector(
      onTap: (){},
      child: CircleAvatar(
        backgroundImage:
        AssetImage('assets/img/car_color.png'),
        radius: 50,
          backgroundColor: currentColor,

      ),
    );
  }


  Widget _textFieldMarca() {
    BrandCars carss;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      // child: TextField(
      //   inputFormatters: [
      //     UpperCaseTextFormatter(),
      //   ],
      //   controller: _con.marcaController,
      //   decoration: InputDecoration(
      //       hintText: 'Marca',
      //       border: InputBorder.none,
      //       contentPadding: EdgeInsets.all(15),
      //       hintStyle: TextStyle(
      //           color: MyColors.primaryColorDark,
      //           fontFamily: 'Lexendeca-Black',
      //       ),
      //     suffixIcon:  Image.asset('assets/img/mcarro.png', width: 30, height: 30),
      //   ),
      // ),
      child: DropdownSearch<dynamic>(
        mode: Mode.MENU,
        items: brands.map((e) => e['brand']).toList(),
        showSearchBox: true,
        // label: "Menu mode",
        // hint: "country in menu mode",
        onChanged: (value) {
          setState(() {
            dropdownValueBrand = value;
          });

        },
        selectedItem: "Selecciona",
      ),


    );
  }

  Widget _textFieldModelo() {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),

      child: DropdownSearch<dynamic>(
        mode: Mode.MENU,
        items: marcasFacheritas.map((e) => e).toList(),
        showSearchBox: true,
        // label: "Menu mode",
        // hint: "country in menu mode",
        onChanged: (value) {
          setState(() {
            dropdownValueBrand = value;
          });
          print('*************** $value');
        },
        selectedItem: "Selecciona",
      ),
    );
  }


  Widget _textFieldYear() {

    return Container(

      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 179),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(30)
      ),
      child:DropdownSearch<String>(
        popupBackgroundColor: Colors.grey[200],
        mode: Mode.MENU,

        showSelectedItems: true,
          items: <String>['AÑO', '2022', '2021', '2020','2019','2018','2017','2016','2015'
          ,'2014','2013','2012','2011','2010','2009','2008','2007','2006','2005','2004',
          '2003','2002','2001','2000','1999','1998','1997','1996','1995','1994','1993',
            '1992','1991','1990','1989','1988','1987','1986','1985','1984','1983','1982',
          '1981','1980','1979','1978','1977','1976','1975','1974','1973','1972','1971',
          '1970','1969','1968','1967','1966','1965','1964','1963','1962','1961','1960',
          '1959','1958','1957','1956','1955','1954','1953','1952','1951','1950','OTRO'],

        dropdownSearchDecoration: InputDecoration(
        labelText: "Selecciona Año",
        hintText: "AÑo",

          fillColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
      ),

        onChanged: (String newValue) {
          setState(() {
            _con.onSelected(newValue);
            dropdownValue = newValue;
          });
        },
        selectedItem: "Año",
      )

        );
  }
  Widget _textFieldPlaca() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 160),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        inputFormatters: [
          UpperCaseTextFormatter(),
        ],
        controller: _con.placaController,
        decoration: InputDecoration(
            hintText: 'Placa',

            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark,
              fontFamily: 'Lexendeca-Black',
            ),
          suffixIcon:  Image.asset('assets/img/car_plate.png', width: 30, height: 30),
        ),
      ),
    );
  }



  Widget _buttonCreate() {
    return Container(
      height:70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 135, vertical: 40),
      child: ElevatedButton(
        onPressed: _con.createCar,
        child: Text('Agregar Auto',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
          fontFamily: 'Lexendeca-Black',
        ),),
        style: ElevatedButton.styleFrom(

          onPrimary: Colors.black,
            primary: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 5),

        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }




}
