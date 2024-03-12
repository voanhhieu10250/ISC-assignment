USE master
GO

if exists (select * from sysdatabases where name='PlantShop')
begin
  raiserror('Dropping existing PlantShop database ....',0,1)
  DROP database PlantShop
end
GO

create database PlantShop
GO
use PlantShop
GO
create table accounts(
    id int identity(1,1) primary key not null,
    email varchar(30) unique not null,
    "password" char(64) not null,
    name nvarchar(30) not null,
    phone varchar(12) not null,
    role int not null check(role=1 or role=0)   -- 1:admin, 0:user
)
GO
create table categories(
    id int identity(1,1) primary key not null,
    name nvarchar(30) not null
)
GO
create table products(
    id int identity(1,1) primary key not null,
    name nvarchar(255) not null,
    price decimal(9,2) check(price>=0) not null default 0,
    quantity int check(quantity>=0) not null default 0,
    image_path varchar(255),
    description ntext,
	created_at datetime not null default GETDATE(),
	updated_at datetime  not null default GETDATE(),
    category_id int foreign key references categories(id)
)
GO
create table orders(
    id int identity(1,1) primary key,
    order_date datetime not null default GETDATE(),
    status int check(status =1 or status=2 or status=3) not null,--1:processing, 2: completed, 3:cancel
    address nvarchar(255) not null,
    account_id int foreign key references accounts(id)
)
GO
create table order_details(
    order_id int foreign key references orders(id),
    product_id int foreign key references products(id),
    quantity int check(quantity>=1) not null,
	price decimal(9,2) check(price>=0) not null default 0,
    CONSTRAINT pk_order_detail PRIMARY KEY (order_id, product_id)
)
--insert admin account 
--email: admin@gmail.com
--password: 12345
insert into accounts(email, password, name, phone, role)
values ('admin@gmail.com', '5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5', 'admin', '0987654321', 1);

insert into categories(name)
values 
		('Feng Shui'),
		('Low Light'),
		('Pets Friendly');

insert into products(name, price, quantity, image_path, description, category_id)
values 
		('Japanese Black Pine Bonsai', 108, 500, '/assets/images/product/Japanese Black Pine Bonsai_1.webp', 'Japanese black pine bonsai (Pinus thunbergii) is a beautiful, slow-growing tree that makes an excellent addition to any home. It is native to Japan and Korea and is often used in bonsai due to its unique shape and slow growth rate. With patience and care, it can last for many years.', 1),
		('Copper Coin in SOOP Ceramic Pot', 45, 500, '/assets/images/product/Copper Coin in SOOP Ceramic Pot_1.webp', 'Hydrocotyle Vulgaris is a small creeping perennial aquatic herb commonly mistaken for a Pilea due to its coin-like leaves. It is a versatile oxygenator when grown in tanks or ponds.', 1),
		('Ficus Elastica Shivereana in RAYON Ceramic Pot', 48, 500, '/assets/images/product/Ficus Elastica Shivereana in RAYON Ceramic Pot_1.webp', 'The Ficus Elastica Shivereana is a rare and unique variety of Ficus, with rubbery leaves variegated with lime and dark green. New growth is peachy pink and fades to green as it matures.', 1),
		('Jacaranda Obtusifolia in BETONI Concrete Pot', 55, 500, '/assets/images/product/Jacaranda Obtusifolia in BETONI Concrete Pot_1.webp', 'Jacaranda obtusifolia or commonly known as Jacaranda obtusifolia can be easily identified with its opposite leaves crowded at the end of long branches. At the right season, it produces flower that are violet in color.', 1),
		
		('Cunninghamia Lanceolata in SOOP Ceramic Pot', 45, 1000, '/assets/images/product/Cunninghamia Lanceolata in SOOP Ceramic Pot_2.webp', 'Cunninghamia lanceolata is a species of tree in the cypress family. Also commonly known as Chinese fir, it is able to reach heights of 150 feet (46 meters) in tropical climate.', 2),
		('Dischidia Oiantha (Variegated) in BALI Ceramic Pot', 45, 1000, '/assets/images/product/Dischidia Oiantha (Variegated) in BALI Ceramic Pot_2.webp', 'Dischidia Oiantha leaves are oval, succulent and have white edges. The plant is easy to care for despite their ornate appearance. Being epiphytic in nature, they prefer to dry out a little between each watering.', 2),
		('Podocarpus Seedlings in SOOP Ceramic Pot', 48, 1000, '/assets/images/product/Podocarpus Seedlings in SOOP Ceramic Pot_2.webp', 'Podocarpus bonsai is a small to medium size tree native to Japan and China. It originated in Japan and is the state tree of Chiba Prefecture, Japan. It is also known as Buddhist pine, Fern pine, Yew plum pine, Arhat pine, Inumaki, and Kusamaki.', 2),
		('Japanese Maple Tree in SOOP Ceramic Pot', 62, 1000, '/assets/images/product/Japanese Maple Tree in SOOP Ceramic Pot_2.webp', 'Japanese Maples are a specimen and ornamental tree. The leaves of this seeding maple are light green with pink in Spring developing to a slightly deeper green in Summer. In Autumn it provides a rich and glorious display of orange to red autumn foliage.', 2),

		('Peace Lily in LIN Ceramic Pot', 42, 500, '/assets/images/product/Peace Lily in LIN Ceramic Pot_3.webp', 'The Spathiphyllum, also widely know as the Peace Lily, is well-loved for its ability to purify the air by removing harmful chemicals, thus making it an excellent choice for interior decor and workplace planting.', 3),
		('Asparagus Fern in SOOP Ceramic Pot', 42, 500, '/assets/images/product/Asparagus Fern in SOOP Ceramic Pot_3.webp', 'Asparagus setaceus plumosus is an elegant fern with long wiry stems and frond-like sprays that scramble outwards horizontally. It is a member of the lily family and is fast growing and easy to care for, making it an ideal plant for beginners.', 3),
		('Sansevieria Trifasciata (Snake Plant) in RAYON Ceramic Pott', 42, 500, '/assets/images/product/Sansevieria Trifasciata (Snake Plant) in RAYON Ceramic Pot_3.webp', 'Sansevieria Trifasciata, also known as the Snake Plant, is one of the most carefree house plants you can grow. Any problems with growing Sansevieria are usually related to watering.', 3),
		('Philodendron Red Congo in SOOP Ceramic Pot', 58, 500, '/assets/images/product/Philodendron Red Congo in SOOP Ceramic Pot_3.webp', 'The Philodendron Red Congo is a rare philodendron known for its glossy leaves that unfurl to reveal a striking red color. It can come in a burgundy light red or even a much darker orange, before deepening to a deep green as it is exposed to more light.', 3),
		----
		('Monstera Deliciosa in LIN Ceramic Pot', 52, 1000, '/assets/images/product/Monstera Deliciosa in LIN Ceramic Pot_1.webp', 'Monstera deliciosa, also commonly known as the Swiss Cheese Plant makes a big impression in a room. Its one of the most instagrammable plant. Give those leaves space to sprawl out and it can it can grow several feet tall, perforated leaves to 30 cm long or more.', 1),
		('Dieffenbachia Exotica Camilla in RAYON Ceramic Pot', 48, 1000, '/assets/images/product/Dieffenbachia Exotica Camilla in RAYON Ceramic Pot_1.webp', 'Dieffenbachia Camilla is a popular houseplant with distinctive white leaves edged in green. It is easy to care for and has beautiful variegated green and white foliage.', 1),
		('Peacock (Calathea Makoyana) in LIN Ceramic Pot', 42, 1000, '/assets/images/product/Peacock (Calathea Makoyana) in LIN Ceramic Pot_1.webp', 'Peacock Plant is a member of the Marantaceae family of prayer plants, known for its bold, decorative leaves that resemble a tail of peacock.', 1),
		('Aglaonema Pink Star in SOOP Ceramic Pot ', 42, 1000, '/assets/images/product/Aglaonema Pink Star in SOOP Ceramic Pot_1.webp', 'Aglonema commutatum is a Chinese Evergreen "Pink Star" native to tropical and subtropical regions of Asia and New Guinea, with variegated green foliage and light green leaves.', 1),

		('Norfolk Island Pine in SOOP Ceramic Pot', 45, 500, '/assets/images/product/Norfolk Island Pine in SOOP Ceramic Pot_2.webp', 'The Araucaria heterophylla, which is a species of conifer, is commonly known as Norfolk Island pine. It requires minimal care and is often used as a christmas tree.', 2),
		('Olive Tree in SOOP Ceramic Pot', 82, 500, '/assets/images/product/Olive Tree in SOOP Ceramic Pot_2.webp', 'Bringing a touch of the Mediterranean to your living space? The Olive tree will help you achieve that. Known for gracing the balmy landscapes of the Mediterranean, these ancient plants are particularly tolerant of warmer weather arrives, hence, making it an adaptable houseplant in sunny Singapore.', 2),
		('Alocasia Nobilis in LIN Ceramic Pot', 48, 500, '/assets/images/product/Alocasia Nobilis in LIN Ceramic Pot_2.webp', 'The Alocasia Sanderiana Nobilis is a rare and new cultivar with dark green leaves with three main pointed corners forming a V-shape and distinctive white veins.', 2),
		('Japan Olive Tree in BILLE Ceramic Pot', 58, 500, '/assets/images/product/Japan Olive Tree in BILLE Ceramic Pot_2.webp', 'This Olive Tree imported from Japan is an ideal houseplant for Singapore, as it is native to the Mediterranean and is adaptable to warmer weather.', 2),

		('Baby Birds of Paradise in RAYON Ceramic Pot', 48, 1000, '/assets/images/product/Baby Birds of Paradise in RAYON Ceramic Pot_3.webp', 'The Strelitzia Nicolai is a popular tropical rainforest plant with many different names. It is known for its glossy, verdant leaves that bring the tropical rainforest to your home.', 3),
		('Chorisia Speciosa (Silk Floss Tree) in MATTE Concrete Pot', 52, 1000, '/assets/images/product/Chorisia Speciosa (Silk Floss Tree) in MATTE Concrete Pot_3.webp', 'The silk floss tree (Ceiba pentandra) is a graceful and fascinating tree with long emerald-green pinnate leaves native to South America. It belongs to the Malvaceae family, which includes significant plants such as hibiscus, durian and cacao.', 3),
		('Philodendron(Ring of Fire) in SOOP Ceramic Pot', 72, 1000, '/assets/images/product/Philodendron (Ring of Fire) in SOOP Ceramic Pot_3.webp', 'Philodendron (Ring of Fire) is a hybrid between Philodendron tortum and Wendlandii. The leaves mature to a slender serrated lance shape and are a vibrant green with splashes of yellow variegation. New leaves emerge a pinkish, caramel colour and fade to green as they age, giving the plant its name.', 3),
		('Opuntia (Prickly Pear) in SOOP Ceramic Pot', 48, 1000, '/assets/images/product/Opuntia (Prickly Pear) in SOOP Ceramic Pot_3.webp', 'Prickly pear is a general term used to describe the Opuntia species, members of the Cactaceae family. Native to the Americas, prickly pear is a spiny, drought-resistant succulent that rapidly invades pastures and natural areas and overwhelms other vegetation.', 3),
		----
		('Olive Tree in RAYON Ceramic Pot', 78, 500, '/assets/images/product/Olive Tree in RAYON Ceramic Pot_1.webp', 'Bringing a touch of the Mediterranean to your living space? The Olive tree will help you achieve that. Known for gracing the balmy landscapes of the Mediterranean, these ancient plants are particularly tolerant of warmer weather arrives, hence, making it an adaptable houseplant in sunny Singapore.', 1),
		('Dieffenbachia Maculata Tiki in SOOP Ceramic Pot', 48, 500, '/assets/images/product/Dieffenbachia Maculata Tiki in SOOP Ceramic Pot_1.webp', 'Dieffenbachia Maculata �Tiki�, commonly known as Dumb Cane, is the newest addition to our shop from our favourite Aracae family! The lush green foliage is stylishly flushed with silver-green colour and adorned with white speckles.', 1),
		('Juniper Bonsai in SOOP Ceramic Pot', 88, 500, '/assets/images/product/Juniper Bonsai in SOOP Ceramic Pot_1.webp', 'Juniper Bonsai are characterized by a great hardiness and longevity. Juniper bonsai also grows slowly, as a result, the maintenance effort is low. The Chinese juniper is a species of plant in the cypress family Cupressaceae, native to China, Myanmar, Japan, Korea and the Russian Far East.', 1),
		('Philodendron Gloriosum Zebra in SOOP Ceramic Pot', 68, 500, '/assets/images/product/Philodendron Gloriosum Zebra in SOOP Ceramic Pot_1.webp', 'Philodendron Gloriosum Zebra is an evergreen, perennial creeping flowering plant native to mainly Colombia. Its lovely large, heart-shaped, velvety deep green leaves with prominent whitish veins and, at times, pinkish margin make it one of the most attractive houseplants ever. Also, it is easy to grow and makes an excellent indoor plant.', 1),

		('Ficus Lyrata in LIN Ceramic Pot', 62, 1000, '/assets/images/product/Ficus Lyrata in LIN Ceramic Pot_2.webp', 'The Ficus Lyrata, also known as Leaf Fig, is one of the most instagrammable plant. It can be easily spotted with its very large, heavily veined, violin-shaped leaves.  They thrive in very warm and wet conditions.', 2),
		('Baby Ficus Elastica Shivereana in SOOP Ceramic Pot', 45, 1000, '/assets/images/product/Baby Ficus Elastica Shivereana in SOOP Ceramic Pot_2.webp', 'The Ficus Elastica Shivereana is an a rare and unique variety of the Ficus family. Its rubbery leaves are beautifully variegated with speckles of lime and dark green, new growth emerges a beautiful shade of peachy pink and fades to green as the leaf matures.', 2),
		('Calathea White Star in LIN Ceramic Pot', 42, 1000, '/assets/images/product/Calathea White Star in LIN Ceramic Pot_2.webp', 'Calathea White Star is a tropical plant with unique features that make an excellent addition to any plant lover�s collection. Its contrasting white and green foliage with violet undersides and subtle pink blush is definitely a style statement.', 2),
		('Cotyledon Tomentosa (Paw of Bear) in STADA Cone Ceramic Pot', 32, 1000, '/assets/images/product/Cotyledon Tomentosa (Paw of Bear) in STADA Cone Ceramic Pot_2.webp', 'Cotyledon Tomentosa, a fascinating drought tolerant plant, which is also know as the Bear�s Paw Succulent has leaves that are a soft mid green. Along the leaf magins are red to brown raised markings and these are the claws. The plant is also referred to Cat Paws and Woolly Cotyledon.', 2),

		('THE HOUSE Faux Red Berry Stick', 35, 500, '/assets/images/product/THE HOUSE Faux Red Berry Stick_3.webp', 'Porcelain vase is not included. Vase in photo contains 12 sticks.', 3),
		('Philodendron Burle Marx in BOWL Ceramic Pot', 52, 500, '/assets/images/product/Philodendron Burle Marx in BOWL Ceramic Pot_3.webp', 'Gorgeous clumping Philodendron with striking variegated leaves in cream and yellow hues. The leaves are an elongated heart shape, each one with unique and beautiful variegation. Philodendron Burle Marx is named after Roberto Burle Marx who was was the first architect to use native plants in modern landscape designs.', 3),
		('Peperomia Obtusifolia in RAYON Ceramic Pot', 38, 500, '/assets/images/product/Peperomia Obtusifolia in RAYON Ceramic Pot_3.webp', 'Also known as the Baby Rubber Plant, Peperomia obtusifolia variegata (Peperomia obtusifolia variegata) displays glossy cupped leaves in multiple shades of olive green, mid green and creamy white.', 3),
		('Spathiphyllum Diamond in ENKEL Terrazzo Pot', 108, 500, '/assets/images/product/Spathiphyllum Diamond in ENKEL Terrazzo Pot_3.webp', 'Spathiphyllum (Diamond) has gorgeous dark green foliage contrasts with the pale marbled variegation of speckles and streaks, resulting in an elegant yet striking choice of Peace Lily.', 3),
		----
		('Plectranthus Prostratus (Tangled Hearts) in MARIO Ceramic Pot', 42, 100, '/assets/images/product/Plectranthus Prostratus (Tangled Hearts) in MARIO Ceramic Pot_1.webp', 'The botanical name of Tangled hearts is Plectranthus Prostratus. A tangled heart is also called as Pillow plant or Swedish ivy. They are native to Africa. It is a small succulent creeper plant that produces small beautiful flowers rarely.', 1),
		('Adenium Desert Rose in STADA Cone Ceramic Pot', 42, 100, '/assets/images/product/Adenium Desert Rose in STADA Cone Ceramic Pot_1.webp', 'Adenium Desert Rose is a succulent with a swollen caudex above-ground and muscular roots. The caudex, or swollen trunk, is used to store water and food during dry spells and to survive long droughts.', 1),
		('Philodendron Billietiae in TILLE Ceramic Pot', 58, 100, '/assets/images/product/Philodendron Billietiae in TILLE Ceramic Pot_1.webp', 'The Philodendron Billietiae is native to Brazil, Guyana, and French Guiana. Philodendron Billietiae is known especially for its distinctive orange-yellow petioles and wavy, ridged leaf edges. This little plant may look tiny now but once established it will produce slender, glossy green leaves up to 1 metre in length in maturity.', 1),
		('Ficus Elastica Shivereana in MARIO Ceramic Pot', 68, 100, '/assets/images/product/Ficus Elastica Shivereana in MARIO Ceramic Pot_1.webp', 'The Ficus Elastica Shivereana is an a rare and unique variety of the Ficus family. Its rubbery leaves are beautifully variegated with speckles of lime and dark green, new growth emerges a beautiful shade of peachy pink and fades to green as the leaf matures.', 1);

