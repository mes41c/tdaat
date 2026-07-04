
CREATE OR REPLACE FUNCTION public.tg_set_updated_at()
RETURNS trigger LANGUAGE plpgsql SET search_path = public AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$;

CREATE TABLE public.events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  date_label text NOT NULL,
  time_label text NOT NULL DEFAULT '—',
  location text NOT NULL,
  category text NOT NULL,
  description text NOT NULL,
  long_description text NOT NULL,
  start_date timestamptz NOT NULL,
  end_date timestamptz NOT NULL,
  image_url text,
  is_upcoming boolean NOT NULL DEFAULT false,
  created_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.events TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.events TO authenticated;
GRANT ALL ON public.events TO service_role;
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "events public read" ON public.events FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "events admin insert" ON public.events FOR INSERT TO authenticated WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "events admin update" ON public.events FOR UPDATE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role)) WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "events admin delete" ON public.events FOR DELETE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE TRIGGER events_set_updated_at BEFORE UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

CREATE TABLE public.blog_posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  excerpt text NOT NULL,
  date_label text NOT NULL,
  author text NOT NULL,
  reading_time text NOT NULL DEFAULT '5 dk',
  category text NOT NULL,
  content text NOT NULL,
  cover_url text,
  published_at timestamptz NOT NULL DEFAULT now(),
  created_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.blog_posts TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.blog_posts TO authenticated;
GRANT ALL ON public.blog_posts TO service_role;
ALTER TABLE public.blog_posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "blog public read" ON public.blog_posts FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "blog admin insert" ON public.blog_posts FOR INSERT TO authenticated WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "blog admin update" ON public.blog_posts FOR UPDATE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role)) WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "blog admin delete" ON public.blog_posts FOR DELETE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE TRIGGER blog_set_updated_at BEFORE UPDATE ON public.blog_posts FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

CREATE TABLE public.news_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  summary text NOT NULL,
  content text[] NOT NULL DEFAULT '{}',
  source text NOT NULL,
  date_label text NOT NULL,
  country text NOT NULL,
  flag text NOT NULL,
  category text NOT NULL,
  created_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.news_items TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.news_items TO authenticated;
GRANT ALL ON public.news_items TO service_role;
ALTER TABLE public.news_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "news public read" ON public.news_items FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "news admin insert" ON public.news_items FOR INSERT TO authenticated WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "news admin update" ON public.news_items FOR UPDATE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role)) WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "news admin delete" ON public.news_items FOR DELETE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE TRIGGER news_set_updated_at BEFORE UPDATE ON public.news_items FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

CREATE TABLE public.gallery_images (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL DEFAULT '',
  caption text NOT NULL DEFAULT '',
  image_url text NOT NULL,
  sort_order int NOT NULL DEFAULT 0,
  created_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.gallery_images TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.gallery_images TO authenticated;
GRANT ALL ON public.gallery_images TO service_role;
ALTER TABLE public.gallery_images ENABLE ROW LEVEL SECURITY;
CREATE POLICY "gallery public read" ON public.gallery_images FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "gallery admin insert" ON public.gallery_images FOR INSERT TO authenticated WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "gallery admin update" ON public.gallery_images FOR UPDATE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role)) WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "gallery admin delete" ON public.gallery_images FOR DELETE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE TRIGGER gallery_set_updated_at BEFORE UPDATE ON public.gallery_images FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

CREATE POLICY "admin read membership" ON public.membership_applications FOR SELECT TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "admin update membership" ON public.membership_applications FOR UPDATE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role)) WITH CHECK (private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "admin delete membership" ON public.membership_applications FOR DELETE TO authenticated USING (private.has_role(auth.uid(), 'admin'::public.app_role));

INSERT INTO public.events (slug, title, date_label, time_label, location, category, description, long_description, start_date, end_date, image_url, is_upcoming) VALUES
('ortak-turk-medyasi-paneli-2026','Türk Dünyasında Ortak Türk Medyası: Sorunlar ve Çözüm Önerileri','30 Nisan 2026','İki oturum','EÜ Türk Dünyası Araştırmaları Enstitüsü Konferans Salonu','Panel',
'Türk devletleri arasında enformasyon akışı, dezenformasyonla mücadele ve ortak yayıncılık politikalarının ele alındığı iki oturumlu panel.',
'TDAAT, TDAE ve ÜNİDES iş birliğiyle düzenlenen panelde Türk Dünyasından gazeteciler ve medya temsilcileri bir araya geldi. EÜ Rektörü Prof. Dr. Musa Alcı ve TDAE Müdürü Prof. Dr. Atıf Akgün''ün de katıldığı etkinlikte, Türk devletleri arasındaki enformasyon akışının güçlendirilmesi, küresel dezenformasyonla mücadele ve ortak yayıncılık politikalarının geliştirilmesi tartışıldı. Azerbaycanlı gazeteci Agil Alesger de panelistler arasındaydı. Her iki oturum YouTube kanalımızda yayımlandı.',
'2026-04-30T14:00:00+03:00','2026-04-30T17:30:00+03:00','/__l5e/assets-v1/57a41ffd-5aa0-4855-bd16-acd75a30675b/medya-paneli.jpg',false),
('dogu-turkistan-paneli-2026','Doğu Türkistan''da Asimilasyon ve Soykırım — Panel ve Sergi','16 Nisan 2026','Tüm gün','EÜ Türk Dünyası Araştırmaları Enstitüsü Konferans Salonu','Panel',
'Çin''in Doğu Türkistan''daki asimilasyon politikalarını ele alan panel; eşliğinde resim ve geleneksel Uygur kıyafeti sergisi.',
'Prof. Dr. Alimcan İnayet''in moderatörlüğünde düzenlenen panelde Prof. Dr. Erkin Emet (Ankara Üniversitesi / Dünya Uygur Kurultayı sözcüsü), araştırmacı-yazar Hamit Göktürk ve eğitimci-yazar Gazi Karabulut konuşmacı olarak yer aldı. Etkinlik kapsamında Uygur Türklerine yönelik uygulamaları konu alan bir resim sergisi ile geleneksel Uygur kıyafetlerinden oluşan bir sergi de açıldı. Farklı fakültelerden dekanlar etkinliğe katıldı; Prof. Dr. Erkin Emet topluluğa kitap bağışında bulundu.',
'2026-04-16T14:00:00+03:00','2026-04-16T17:00:00+03:00','/__l5e/assets-v1/0687a86b-093c-4198-8e0b-a38f31206594/dogu-turkistan.jpg',false),
('suriye-turkleri-paneli-2026','Türkiye''nin Güneyinde Güncel Gelişmeler ve Suriye Türklerinin Durumu','9 Mart 2026','—','Ege Üniversitesi Kültür Sanat Evi','Panel',
'Suriye''deki son gelişmeler, güney sınırının geleceği ve Suriye Türkmenlerinin önemi üzerine jeopolitik odaklı panel.',
'TDAE Müdürü Prof. Dr. Atıf Akgün''ün moderatörlüğündeki panelde, Yıldız Teknik Üniversitesi''nden Prof. Dr. Mehmet Akif Okur ve Suriyeli Türkmen Dernekler Federasyonu Başkanı / Halep Milletvekili Dr. Tarık Sülo Cevizci konuşmacı olarak yer aldı. Türkiye''nin güney sınırındaki güvenlik durumu ele alındı ve Türkmenlerin Suriye''nin yeniden yapılanmasında kurucu unsur olarak tanınması gerektiği vurgulandı.',
'2026-03-09T14:00:00+03:00','2026-03-09T16:30:00+03:00','/__l5e/assets-v1/98905381-8601-42fb-9b6d-f7b3b836cc37/suriye-turkleri-paneli-2026.jpg',false),
('ortak-kimlik-paneli-2025','Türk Dünyası ve Ortak Türk Kimliğinin İnşası','23 Aralık 2025','—','EÜ Prof. Dr. Nuri Bilgin Konferans Salonu','Panel',
'Kültür, dil, din ve tarih oturumlarıyla Türk Dünyasının ortak kimliğini ele alan kapsamlı panel.',
'Topluluğun en kapsamlı etkinliklerinden biri olarak gerçekleşen panelin Kültür oturumunu Doç. Dr. Fazıl Özdamar modere etti; Prof. Dr. Metin Ekici (EÜ TDAE), Prof. Dr. Mustafa Aksoy (Munzur Üniversitesi) ve Prof. Dr. Saadettin Yağmur Gömeç (Ankara Üniversitesi) konuşmacı olarak yer aldı. Açılış ve kapanış konuşmalarını EÜ Rektör Yardımcısı Prof. Dr. Mehmet Ersan yaptı. Prof. Dr. Ekici Nevruz, Hıdırellez ve Dede Korkut anlatılarının birleştirici rolüne dikkat çekerken; Prof. Dr. Gömeç kimliğin töre ve millî ruhla ayakta durduğunu vurguladı.',
'2025-12-23T14:00:00+03:00','2025-12-23T17:30:00+03:00','/__l5e/assets-v1/04663dc0-bbde-47c6-8d96-15e368363e68/ortak-kimlik-paneli-2025.jpg',false),
('feto-konferansi-2025','FETÖ''nün Türkiye''nin Türk Dünyasıyla İlişkilerine Verdiği Hasar','21 Kasım 2025','—','EÜ Türk Dünyası Araştırmaları Enstitüsü Konferans Salonu','Konferans',
'Prof. Dr. İbrahim Maraş''ın konuşmacı olduğu, FETÖ''nün Türk Dünyası ilişkilerine etkilerini ele alan konferans.',
'TDAAT ve TDAE iş birliğiyle düzenlenen konferansa Ankara Üniversitesi İlahiyat Fakültesi''nden Prof. Dr. İbrahim Maraş konuşmacı olarak katıldı. Açılışı TDAE Müdürü Prof. Dr. Abdullah Temizkan yaptı. İstiklal Marşı ve saygı duruşuyla başlayan programda, Türkiye''nin Orta Asya ve Türk coğrafyasıyla kurduğu derin ilişkilerin nasıl sekteye uğratıldığı akademik düzeyde tartışıldı.',
'2025-11-21T14:00:00+03:00','2025-11-21T16:00:00+03:00','/__l5e/assets-v1/715ed3b2-2142-45f0-b17a-5a3cb0f18432/feto-konferansi-2025.png',false),
('ateizm-deizm-soylesisi-2025','Türk Dünyası Bağlamında Ateizm ve Deizm','14 Mayıs 2025','—','EÜ Edebiyat Fakültesi Ahmet Arslan Konferans Salonu','Söyleşi',
'Topluluğun ilk resmî etkinliği: Prof. Dr. İsmail Yakıt ile ateizm ve deizm kavramları üzerine söyleşi.',
'TDAAT''ın ilk resmî etkinliği olarak tarihe geçen söyleşide Akdeniz Üniversitesi öğretim üyesi Prof. Dr. İsmail Yakıt; ateizm ve deizm kavramlarını tarihsel kökleri, felsefi yansımaları ve dilsel karşılıkları bağlamında ele aldı. Türkçede ateizmin tam karşılığının bulunmadığını; Arapça "ilhad", Osmanlıca "zındık" ve İslam literatüründe "dehrî/mülhid" gibi terimlerle ifade edildiğini açıkladı. Etkinlik, EÜ İlahiyat Fakültesi Dekanı Prof. Dr. Hanefi Palabıyık''ın da katılımıyla sona erdi; konuşmacıya Yesevi Mührü takdim edildi.',
'2025-05-14T14:00:00+03:00','2025-05-14T16:00:00+03:00','/soylesi-ateizm-deizm-2025.jpg',false);

INSERT INTO public.blog_posts (slug, title, excerpt, date_label, author, reading_time, category, content) VALUES
('turk-dunyasi-neden-onemli','Türk Dünyası Neden Önemli?',
'Ortak tarih, dil ve kültür mirasının çağımız üniversite öğrencisi için ne ifade ettiğine dair kısa bir giriş.',
'15 Mayıs 2026','TDAAT Yayın Kurulu','5 dk','Kültür',
'Türk dünyası, bugün altı bağımsız devlet ve milyonlarca insanı kapsayan geniş bir coğrafyaya yayılır. Ortak tarih, akraba diller ve paylaşılan kültürel kodlar; akademik araştırma, ekonomi, sanat ve diplomasi için zengin bir zemin sunar. Bu yazıda, üniversite öğrencisi olarak bu mirası neden tanımanın değerli olduğunu kısaca özetliyoruz.'),
('topluluk-kurulus-hikayesi','TDAAT Nasıl Kuruldu?',
'Bir grup öğrencinin Ege Üniversitesi''nde Türk Dünyası Akademik Araştırmalar Topluluğu''nu kurma yolculuğu.',
'1 Mayıs 2026','Muharrem Turgut','4 dk','Topluluk',
'TDAAT, 2025-2026 akademik yılında, Ege Üniversitesi''nde Türk dünyası ile ilgilenen bir grup öğrencinin bir araya gelmesiyle kuruldu. İlk toplantılarımızdan ilk panele kadar geçen sürede neler yaşadığımızı, hangi engellerle karşılaştığımızı ve neyi başarmaya çalıştığımızı bu yazıda anlatıyoruz.'),
('mangala-nedir','Mangala: Türk Zekâ Oyunu',
'Geleneksel Mangala oyununun kısa tarihi, kuralları ve neden bir ''Türk satrancı'' sayılabileceği.',
'20 Nisan 2026','Alparslan Cengiz','6 dk','Oyun & Spor',
'Mangala, taş ve çukurlardan oluşan basit ama derin bir strateji oyunudur. Türk kültüründe yüzyıllardır oynanır, modern Türkiye''de okul müsabakalarıyla yeniden popüler olmuştur. Bu yazıda kuralları, temel stratejileri ve neden bir ''düşünme antrenmanı'' olarak değerli olduğunu ele alıyoruz.');

INSERT INTO public.news_items (slug, title, summary, content, source, date_label, country, flag, category) VALUES
('turkic-council-summit','Türk Devletleri Teşkilatı Zirvesi',
'Türk Devletleri Teşkilatı üyesi devletlerin devlet başkanları, ortak eğitim, bilim ve kültür projelerini görüşmek üzere bir araya geldi.',
ARRAY[
'Türk Devletleri Teşkilatı (TDT) üyesi devletlerin devlet başkanları, Astana''da düzenlenen zirvede ortak eğitim, bilim ve kültür projelerini ele almak üzere bir araya geldi. Zirveye Türkiye, Azerbaycan, Kazakistan, Kırgızistan, Özbekistan ve gözlemci üye Türkmenistan''ın temsilcileri katıldı.',
'Zirvenin en önemli sonuçlarından biri, üye ülkeler arasında üniversiteler arası öğrenci değişim programlarının önümüzdeki üç yıl içinde iki katına çıkarılması kararı oldu. Program kapsamında her yıl en az 5.000 öğrencinin Türk dünyasındaki farklı üniversitelerde bir veya iki dönem eğitim alması hedefleniyor.',
'Ayrıca ortak bir dijital kütüphane platformu kurulması, Türk lehçeleri arasında otomatik çeviri sağlayan bir yapay zekâ projesinin başlatılması ve bilim insanları için ortak araştırma fonlarının oluşturulması da gündeme alındı.',
'Zirvenin kapanış bildirgesinde, gençlik buluşmalarının her yıl farklı bir başkentte düzenlenmesi ve 2027 yılının ''Türk Dünyası Gençlik Yılı'' ilan edilmesi kararlaştırıldı.'
],'Türk Devletleri Teşkilatı','25 Mayıs 2026','Kazakistan','kz','education'),
('turkmen-akhmet-yasawi','Hoca Ahmet Yesevi Yılı Kutlamaları',
'Türkmenistan''da Hoca Ahmet Yesevi anısına düzenlenen uluslararası bilimsel sempozyum, Türk dünyası sufî geleneği üzerine önemli tartışmalara ev sahipliği yaptı.',
ARRAY[
'Türkmenistan''ın başkenti Aşkabat''ta düzenlenen ''Hoca Ahmet Yesevi ve Türk Dünyası'' uluslararası sempozyumu, 12 ülkeden 200''ü aşkın akademisyeni bir araya getirdi. Sempozyum, Pir-i Türkistan olarak da bilinen Yesevi''nin düşüncelerinin günümüz eğitim felsefesine etkilerini ele aldı.',
'Üç gün süren etkinlik boyunca tasavvuf geleneği, hikmet edebiyatı, ahlâk eğitimi ve Türk dünyasında ortak değerlerin inşası gibi başlıklar tartışıldı. Türkiye''den katılan öğretim üyeleri, Yesevi''nin ''Divan-ı Hikmet'' eserinin günümüz Türk lehçelerine yapılan yeni çevirilerini tanıttı.',
'Sempozyum sonunda yayımlanan bildirgede, Yesevi düşüncesinin ortaokul ve lise müfredatlarına seçmeli ders olarak girmesi ve Türk dünyasında ortak bir ''Yesevi Akademisi''nin kurulması önerildi.'
],'Türkmenistan Kültür Bakanlığı','18 Mayıs 2026','Türkmenistan','tm','culture'),
('azerbaijan-green-energy','Azerbaycan''ın Yeşil Enerji Hamlesi',
'Azerbaycan, Hazar Denizi kıyısında kurduğu rüzgar enerjisi santralleriyle bölgesel enerji işbirliğinde öncü rol oynamaya devam ediyor.',
ARRAY[
'Azerbaycan, Hazar Denizi kıyısında devreye aldığı yeni rüzgar enerjisi santralleriyle yenilenebilir enerji üretimini son bir yılda %40 artırdı. Hükümet, 2030 yılına kadar üretilen elektriğin yarısının yenilenebilir kaynaklardan sağlanmasını hedefliyor.',
'Projenin en dikkat çekici yönü, üretilen fazla enerjinin Türkiye ve Gürcistan üzerinden Avrupa''ya, doğuya doğru ise Türkistan Türk cumhuriyetlerine iletilmesi planı. Bu kapsamda Hazar geçişli bir denizaltı elektrik kablosu projesi için fizibilite çalışmaları başlatıldı.',
'Türk Devletleri Teşkilatı çatısı altında oluşturulması planlanan ''Türk Enerji Koridoru'', özellikle Özbekistan ve Kırgızistan gibi enerji talebi hızla artan ülkeler için kritik önemde değerlendiriliyor.',
'Azerbaycan ayrıca yeşil hidrojen üretimi konusunda Türk üniversiteleriyle ortak araştırma anlaşmaları imzaladı.'
],'Azerbaycan Enerji Bakanlığı','10 Mayıs 2026','Azerbaycan','az','economy'),
('kyrgyz-manuscript','Kırgızistan''da Nadir El Yazması Bulundu',
'Kırgızistan Millî Kütüphanesi''nde, 15. yüzyıla ait Çağatayca bir tıp el yazması keşfedildi.',
ARRAY[
'Kırgızistan Millî Kütüphanesi''nin arşivlerinde yürütülen tasnif çalışmaları sırasında, 15. yüzyıla tarihlenen Çağatayca bir tıp el yazması keşfedildi. 240 sayfalık eser, dönemin bitki temelli tedavi yöntemlerini ve cerrahi uygulamalarını ayrıntılı biçimde anlatıyor.',
'Eserin müellifi henüz kesin olarak tespit edilebilmiş değil; ancak yazı üslubu ve kullanılan terminoloji, müellifin Timurlular döneminde Semerkant veya Buhara''da yetişmiş bir hekim olduğuna işaret ediyor.',
'Türkiye, Kazakistan ve Özbekistan''dan akademisyenlerin de katıldığı uluslararası bir komisyon, eserin dijitalleştirilmesi ve modern Türk lehçelerine çevirisi için çalışma başlattı. Eser, önümüzdeki yıl Bişkek''te düzenlenecek özel bir sergide kamuoyuyla paylaşılacak.',
'Bu keşif, Türk dünyası ortak bilim mirasının ne kadar geniş ve hâlâ keşfedilmeyi bekleyen zenginlikte olduğunu bir kez daha gösterdi.'
],'Kırgızistan Millî Kütüphanesi','3 Mayıs 2026','Kırgızistan','kg','science'),
('uzbek-restoration','Özbekistan''daki Tarihi Medrese Restorasyonu Tamamlandı',
'Semerkant''taki bir medrese, yıllar süren restorasyon çalışmalarının ardından ziyaretçilere açıldı.',
ARRAY[
'Semerkant''ın Registan Meydanı''na yakın bir konumda yer alan ve 17. yüzyıldan kalma tarihi medrese, yedi yıl süren titiz restorasyon çalışmalarının ardından ziyaretçilere açıldı. Çalışmalar süresince yapının özgün çini desenleri, ahşap işçilikleri ve kaligrafi panoları aslına uygun şekilde yenilendi.',
'Restorasyon projesinde Türkiye, Özbekistan ve Azerbaycan''dan uzmanlar ortak çalıştı. UNESCO Dünya Mirası kapsamında değerlendirilen yapı, Türk-İslam mimarisinin önemli örneklerinden biri olarak kabul ediliyor.',
'Medrese, sadece bir müze olarak değil, aynı zamanda Türk dünyasından gelen öğrencilere ev sahipliği yapacak bir kültür merkezi olarak da işlev görecek. Açılış programı çerçevesinde öğrenci gruplarına ücretsiz rehberli turlar düzenleniyor.',
'Yetkililer, benzer restorasyon projelerinin Buhara ve Hive''de de başlatılacağını duyurdu.'
],'Özbekistan Turizm Bakanlığı','28 Nisan 2026','Özbekistan','uz','culture'),
('turkey-turkic-world-festival','İstanbul''da Türk Dünyası Kültür Festivali',
'İstanbul''da düzenlenen Türk Dünyası Kültür Festivali''nde altı bağımsız devletten sanatçılar ve akademisyenler bir araya geldi.',
ARRAY[
'İstanbul Büyükşehir Belediyesi''nin ev sahipliğinde düzenlenen ''Türk Dünyası Kültür Festivali'', bir hafta boyunca şehrin farklı noktalarında konserler, sergiler, söyleşiler ve atölyelerle Türk dünyasının zengin kültürel mirasını sergiledi.',
'Festivale Türkiye, Azerbaycan, Kazakistan, Kırgızistan, Özbekistan ve Türkmenistan''dan yüzlerce sanatçı, akademisyen ve zanaatkâr katıldı. Etkinlikler arasında geleneksel müzik konserleri, halk dansları gösterileri, el sanatları atölyeleri ve modern Türk edebiyatı üzerine paneller yer aldı.',
'Sultanahmet Meydanı''nda kurulan büyük açık hava sahnesinde, her ülkenin geleneksel çalgılarını birleştiren özel orkestra konserleri büyük ilgi gördü. Ayrıca Gülhane Parkı''nda kurulan ''Türk Dünyası Çarşısı''nda altı ülkenin geleneksel yemekleri ve el sanatları ziyaretçilere sunuldu.',
'Festivalin gelecek yıl Bakü''de, 2028''de ise Taşkent''te düzenlenmesi planlanıyor.'
],'İstanbul Kültür ve Turizm Müdürlüğü','15 Nisan 2026','Türkiye','tr','culture');

CREATE OR REPLACE FUNCTION public.tg_auto_admin_on_signup()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF NEW.email = 'yhk24052206@gmail.com' THEN
    INSERT INTO public.user_roles (user_id, role) VALUES (NEW.id, 'admin'::public.app_role)
      ON CONFLICT (user_id, role) DO NOTHING;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS auto_admin_on_signup ON auth.users;
CREATE TRIGGER auto_admin_on_signup
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.tg_auto_admin_on_signup();

INSERT INTO public.user_roles (user_id, role)
SELECT id, 'admin'::public.app_role FROM auth.users WHERE email = 'yhk24052206@gmail.com'
ON CONFLICT (user_id, role) DO NOTHING;
