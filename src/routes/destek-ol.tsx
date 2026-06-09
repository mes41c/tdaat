import { createFileRoute, Link } from "@tanstack/react-router";
import { Heart, HandCoins, Users, Mail, Check, Sparkles, Target, Megaphone } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

export const Route = createFileRoute("/destek-ol")({
  head: () => ({
    meta: [
      { title: "Destek Ol — TDAAT" },
      {
        name: "description",
        content:
          "Türk Dünyası Akademik Araştırmalar Topluluğu'na bağış, sponsorluk ve gönüllülükle destek ol. Sponsorluk paketleri ve katkının nasıl kullanıldığını gör.",
      },
      { property: "og:title", content: "Destek Ol — TDAAT" },
      {
        property: "og:description",
        content: "Bağış, sponsorluk ve gönüllülük ile topluluğumuza destek ol.",
      },
      { property: "og:url", content: "https://tdaat.lovable.app/destek-ol" },
    ],
    links: [{ rel: "canonical", href: "https://tdaat.lovable.app/destek-ol" }],
  }),
  component: DestekOl,
});

const ways = [
  {
    icon: HandCoins,
    title: "Bağış Yap",
    desc: "Tek seferlik veya düzenli bağışlarınla etkinliklerimizi sürdürmemize yardım et.",
    href: "/contact" as const,
    label: "İletişime Geç",
  },
  {
    icon: Sparkles,
    title: "Sponsor Ol",
    desc: "Kurumun adını topluluk etkinliklerimizde görünür kıl, öğrencilere ulaş.",
    href: "/contact" as const,
    label: "Sponsorluk Görüş",
  },
  {
    icon: Users,
    title: "Gönüllü Ol",
    desc: "Organizasyon, içerik üretimi ve saha çalışmalarımızda aktif rol al.",
    href: "/uye-ol" as const,
    label: "Üye Ol",
  },
  {
    icon: Mail,
    title: "Bilgi Al",
    desc: "İş birliği, protokol ve etkinlik fikirleri için bizimle iletişime geç.",
    href: "/contact" as const,
    label: "İletişim",
  },
];

const tiers = [
  {
    name: "Dost",
    price: "₺1.000+",
    desc: "Bireysel destekçiler ve küçük işletmeler için.",
    features: [
      "Etkinlik broşürlerinde isim",
      "Sosyal medyada teşekkür paylaşımı",
      "Topluluk bültenine özel davet",
    ],
    highlight: false,
  },
  {
    name: "İlk Destek",
    price: "₺5.000+",
    desc: "Bir akademik dönem boyunca yanımızda olmak isteyenler için.",
    features: [
      "Tüm 'Dost' avantajları",
      "Etkinlik afiş ve dijital materyallerde logo",
      "Web sitesi sponsorlar bölümünde logo",
      "Bir etkinlikte stant / söz hakkı",
    ],
    highlight: true,
  },
  {
    name: "Stratejik Ortak",
    price: "₺15.000+",
    desc: "Yıllık iş birliği ve uzun vadeli görünürlük arayan kurumlar için.",
    features: [
      "Tüm 'İlk Destek' avantajları",
      "Yıl boyunca ana sponsor görünürlüğü",
      "Ortak etkinlik / panel düzenleme",
      "Özel iş birliği protokolü",
      "Yıllık etki raporu",
    ],
    highlight: false,
  },
];

const impact = [
  {
    icon: Target,
    percent: "40%",
    title: "Etkinlikler",
    desc: "Konferans, panel, atölye, gezi ve kültürel buluşmalar.",
  },
  {
    icon: Megaphone,
    percent: "35%",
    title: "İçerik & Yayın",
    desc: "Makale, dergi, video, podcast ve dijital içerik üretimi.",
  },
  {
    icon: Users,
    percent: "25%",
    title: "Topluluk",
    desc: "Üye gelişimi, eğitim materyalleri ve operasyonel giderler.",
  },
];

function DestekOl() {
  return (
    <div className="mx-auto w-full max-w-6xl px-4 py-16 sm:px-6 lg:px-8">
      {/* Hero */}
      <header className="text-center">
        <div className="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-medium text-primary ring-1 ring-inset ring-primary/20">
          <Heart className="h-3.5 w-3.5" />
          Birlikte daha güçlüyüz
        </div>
        <h1 className="mt-6 font-[var(--font-heading)] text-3xl font-bold tracking-tight text-foreground sm:text-4xl lg:text-5xl">
          Destek Ol
        </h1>
        <p className="mx-auto mt-4 max-w-2xl text-muted-foreground leading-relaxed">
          Türk Dünyası Akademik Araştırmalar Topluluğu çalışmalarını gönüllü emekle yürütüyor.
          Bağış, sponsorluk veya gönüllülükle yanımızda olabilir; akademik üretimi ve kültürel
          mirası yaşatma çabamıza ortak olabilirsin.
        </p>
      </header>

      {/* Ways */}
      <section className="mt-16">
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {ways.map((w) => (
            <div
              key={w.title}
              className="flex flex-col rounded-xl border border-border/60 bg-card p-6 transition-colors hover:border-primary/20 hover:bg-accent/50"
            >
              <div className="inline-flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                <w.icon className="h-5 w-5" />
              </div>
              <h2 className="mt-4 font-[var(--font-heading)] text-base font-semibold text-foreground">
                {w.title}
              </h2>
              <p className="mt-2 flex-1 text-sm leading-relaxed text-muted-foreground">{w.desc}</p>
              <div className="mt-5">
                <Button asChild variant="outline" size="sm" className="font-[var(--font-heading)]">
                  <Link to={w.href}>{w.label}</Link>
                </Button>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Sponsorship Tiers */}
      <section className="mt-20">
        <div className="text-center">
          <h2 className="font-[var(--font-heading)] text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
            Sponsorluk Paketleri
          </h2>
          <p className="mx-auto mt-3 max-w-2xl text-muted-foreground">
            Kurumun veya markan için sana uygun paketi seç. Tüm paketler özel ihtiyaçlara göre
            şekillendirilebilir.
          </p>
        </div>

        <div className="mt-10 grid gap-6 lg:grid-cols-3">
          {tiers.map((t) => (
            <div
              key={t.name}
              className={`relative flex flex-col rounded-2xl border bg-card p-8 transition-shadow hover:shadow-md ${
                t.highlight
                  ? "border-primary/40 ring-1 ring-primary/20"
                  : "border-border/60"
              }`}
            >
              {t.highlight && (
                <Badge className="absolute -top-3 left-1/2 -translate-x-1/2">
                  Önerilen
                </Badge>
              )}
              <h3 className="font-[var(--font-heading)] text-xl font-bold text-foreground">
                {t.name}
              </h3>
              <div className="mt-2 font-[var(--font-heading)] text-3xl font-bold text-primary">
                {t.price}
              </div>
              <p className="mt-2 text-sm text-muted-foreground">{t.desc}</p>
              <ul className="mt-6 flex-1 space-y-3">
                {t.features.map((f) => (
                  <li key={f} className="flex items-start gap-2 text-sm text-foreground/90">
                    <Check className="mt-0.5 h-4 w-4 shrink-0 text-primary" />
                    <span>{f}</span>
                  </li>
                ))}
              </ul>
              <Button
                asChild
                className="mt-8 font-[var(--font-heading)]"
                variant={t.highlight ? "default" : "outline"}
              >
                <Link to="/contact">İletişime Geç</Link>
              </Button>
            </div>
          ))}
        </div>
      </section>

      {/* Impact Distribution */}
      <section className="mt-20">
        <div className="text-center">
          <h2 className="font-[var(--font-heading)] text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
            Katkın Nereye Gidiyor?
          </h2>
          <p className="mx-auto mt-3 max-w-2xl text-muted-foreground">
            Şeffaflık bizim için önemli. Topluluğa yapılan katkılar şu üç alana yönlendiriliyor.
          </p>
        </div>

        <div className="mt-10 grid gap-6 sm:grid-cols-3">
          {impact.map((i) => (
            <div
              key={i.title}
              className="rounded-xl border border-border/60 bg-card p-6 text-center"
            >
              <div className="mx-auto inline-flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                <i.icon className="h-5 w-5" />
              </div>
              <div className="mt-4 font-[var(--font-heading)] text-3xl font-bold text-primary">
                {i.percent}
              </div>
              <h3 className="mt-2 font-[var(--font-heading)] text-base font-semibold text-foreground">
                {i.title}
              </h3>
              <p className="mt-2 text-sm leading-relaxed text-muted-foreground">{i.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Final CTA */}
      <section className="mt-20 rounded-2xl bg-primary px-6 py-12 text-center text-primary-foreground">
        <h2 className="font-[var(--font-heading)] text-2xl font-bold tracking-tight sm:text-3xl">
          Bir sonraki etkinliği birlikte ayağa kaldıralım
        </h2>
        <p className="mx-auto mt-3 max-w-xl opacity-90">
          Sponsorluk, bağış veya iş birliği için bize yaz. 48 saat içinde geri dönüş yapıyoruz.
        </p>
        <div className="mt-6 flex flex-wrap justify-center gap-3">
          <Button
            asChild
            size="lg"
            className="bg-primary-foreground font-[var(--font-heading)] text-primary hover:bg-primary-foreground/90"
          >
            <Link to="/contact">İletişime Geç</Link>
          </Button>
        </div>
      </section>
    </div>
  );
}
