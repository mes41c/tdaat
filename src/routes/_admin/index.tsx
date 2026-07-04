import { createFileRoute } from "@tanstack/react-router";
import { useSuspenseQuery } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";

export const Route = createFileRoute("/_admin/")({
  component: AdminDashboard,
});

function useCount(table: "events" | "blog_posts" | "news_items" | "gallery_images" | "membership_applications") {
  return useSuspenseQuery({
    queryKey: ["admin-count", table],
    queryFn: async () => {
      const { count } = await supabase.from(table).select("id", { count: "exact", head: true });
      return count ?? 0;
    },
  });
}

function AdminDashboard() {
  const events = useCount("events");
  const blog = useCount("blog_posts");
  const news = useCount("news_items");
  const gallery = useCount("gallery_images");
  const memberships = useCount("membership_applications");

  const stats = [
    { label: "Etkinlik", value: events.data },
    { label: "Blog Yazısı", value: blog.data },
    { label: "Haber", value: news.data },
    { label: "Galeri Görseli", value: gallery.data },
    { label: "Üyelik Başvurusu", value: memberships.data },
  ];

  return (
    <div>
      <h1 className="font-[var(--font-heading)] text-2xl font-bold text-foreground">
        Hoş geldin
      </h1>
      <p className="mt-1 text-sm text-muted-foreground">
        Soldaki menüden içerikleri yönetebilirsin.
      </p>
      <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {stats.map((s) => (
          <div key={s.label} className="rounded-xl border border-border/60 bg-card p-5">
            <div className="text-xs uppercase tracking-wide text-muted-foreground">{s.label}</div>
            <div className="mt-2 text-3xl font-bold text-foreground">{s.value}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
