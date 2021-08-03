//Площадка для костра
module firecamp(){
    //Радиус костра
    radius=1000;
    //Ряды дров
    difference(){
        for(i=[0:-1000:-3000]){
            rotate([0,0,i])
            translate([0,0,i])
            for(i=[0:10:350]){
                translate([sin(i)*radius,cos                    (i)*radius,0])
                rotate([cos(i)*20,-sin(i)*20                    ,0])
            log();
            }
        }
        //Удаление фрагнменов под землёй
        translate([0,0,-2500])
        cube(5000,center=true);
    }
    //Подложка кострища
    raft(3000);
}
//Бревно для костра
module log(){
    color("brown")
    cylinder(2900,30,30,$fn=30);
}
//Кострище
module raft(radius){
    //Кирпичи по краю
    for(i=[0:6.5:359]){
        translate([sin(i)*radius,cos(i)*radius,0])
        rotate([0,0,-i])
        color("orange")
        brick();
    }
    //Песчанное покрытие
    color("grey")
    cylinder(1,radius,radius);
}
//Кирпич
module brick(){
    radius=5;
    rotate([0,0,90])
    //Построение кирпича по точкам в углах
    hull(){
        translate([50,150,0])
        sphere(radius);
        translate([-50,150,0])
        sphere(radius);
        translate([50,-150,0])
        sphere(radius);
        translate([-50,-150,0])
        sphere(radius);
        translate([50,150,100])
        sphere(radius);
        translate([-50,150,100])
        sphere(radius);
        translate([50,-150,100])
        sphere(radius);
        translate([-50,-150,100])
        sphere(radius);
    }
}
//Ракета
module rocket(){
    //Центральный столб
    cylinder(5000,30,30);
    //Кольца
    for(i=[0:1:6]){
        translate([0,0,500*i])
        rocketTor(1000,10);
    }
    //Вертикальные детали
    for(i=[0:60:359]){
        translate([sin(i)*1000,cos(i)*1000,0])
        rotate([0,0,-i])
        union(){
            translate([0,0,-500])
            cylinder(3500,10,10);
            translate([0,0,3000])
            rotate([30,0,0])
            cylinder(2000,10,10);
            //Опоры
            if(i%120==0){
                translate([0,0,500])
                rotate([-150,0,0])
                cylinder(600,10,10);
                translate([0,300,-500])
                cylinder(500,10,10);
            }
        }
    }
}
//Кольцо ракеты
module rocketTor(radius,thickness){
    rotate_extrude(angle=360)
    translate([radius,0])
    circle(thickness);
    for(i=[0:60:359]){
        rotate([0,90,i+30])
        cylinder(radius,10,10);
    }
}
//Скамейка
module brunch(){
    //Две опоры
    color("blue")
    translate([0,1500,0])
    prop();
    color("blue")
    translate([0,-1500,0])
    rotate([0,0,180])
    prop();
    //Доски
    translate([0,0,360])
    color("orange")
    union(){
        translate([100,0,0])
        cube([90,3100,100], center=true);
        translate([-100,0,0])
        cube([90,3100,100], center=true);
        cube([90,3100,100], center=true);
    }
}
//Опора скамейки
module prop(){
    cylinder(300,125,125);
    translate([0,0,300+5])
    cube([300,100,10],center=true);
    translate([0,50,300+50])
    rotate([90,0,0])
    cube([300,100,10],center=true);
}
//Трава (фон)
module grass(width,depth){
    color("green")
    cube([width,depth,1],center=true);
}
//Дорога
module road(lenght,width){
    for(i=[lenght/(-2):500:lenght/2]){
        for(j=[width/(-2):500:width/2]){
            translate([i,j,1])
            //Установка цветов в шахматном порядке
            color((i+j)%200==0?"grey":"orange")
            cube([500,500,1],center=true);
        }
    }
}
//Размещение объектов
translate([6000,5000,2])
rotate([0,0,-65])
road(100000,3000);

grass(100000,100000);

firecamp();

translate([5000,-5000,500])
rocket();

translate([-3500,0,0])
brunch();

translate([-2300,3000,0])
rotate([0,0,-45])
brunch();

translate([-2300,-3000,0])
rotate([0,0,45])
brunch();