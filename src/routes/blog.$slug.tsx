import { createFileRoute, Link, notFound } from "@tanstack/react-router";
import { ArrowLeft, Calendar, User, Clock } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { findPost } from "@/lib/blog-data";

export const Route = createFileRoute("/blog/$slug")({
  loader: ({ params }) => {
    const post = findPost(params.slug);
    if (!post) throw notFound();
    return { post };
  },
  head: ({ loaderData }) => {
    const p = loaderData?.post;
    if (!p) return {};
    return {
      meta: [
        { title: `${p.title} — TDAAT Blog` },
        { name: "description", content: p.excerpt },
        { property: "og:title", content: p.title },
        { property: "og:description", content: p.excerpt },
        { property: "og:type", content: "article" },
        { property: "og:url", content: `https://tdaat.lovable.app/blog/${p.slug}` },
      ],
      links: [{ rel: "canonical", href: `https://tdaat.lovable.app/blog/${p.slug}` }],
      scripts: [
        {
          type: "application/ld+json",
          children: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "Article",
            headline: p.title,
            description: p.excerpt,
            author: { "@type": "Person", name: p.author },
            datePublished: p.date,
          }),
        },
      ],
    };
  },
  notFoundComponent: () => (
    <div className="mx-auto max-w-2xl px-4 py-24 text-center">
      <h1 className="font-[var(--font-heading)] text-3xl font-bold">Yazı bulunamadı</h1>
      <Button asChild className="mt-6">
        <Link to="/blog">Tüm Yazılar</Link>
      </Button>
    </div>
  ),
  component: PostDetail,
});

function PostDetail() {
  const { post } = Route.useLoaderData();
  return (
    <article className="mx-auto w-full max-w-3xl px-4 py-16 sm:px-6 lg:px-8">
      <Link
        to="/blog"
        className="inline-flex items-center gap-1.5 text-sm text-muted-foreground transition-colors hover:text-primary"
      >
        <ArrowLeft className="h-4 w-4" /> Tüm Yazılar
      </Link>
      <Badge variant="secondary" className="mt-6">{post.category}</Badge>
      <h1 className="mt-3 font-[var(--font-heading)] text-3xl font-bold tracking-tight text-foreground sm:text-4xl">
        {post.title}
      </h1>
      <div className="mt-4 flex flex-wrap gap-4 text-sm text-muted-foreground">
        <span className="inline-flex items-center gap-1.5"><User className="h-4 w-4" /> {post.author}</span>
        <span className="inline-flex items-center gap-1.5"><Calendar className="h-4 w-4" /> {post.date}</span>
        <span className="inline-flex items-center gap-1.5"><Clock className="h-4 w-4" /> {post.readingTime}</span>
      </div>
      <div className="prose prose-neutral mt-10 max-w-none leading-relaxed text-foreground/90 dark:prose-invert">
        {post.content.split("\n\n").map((para, i) => (
          <p key={i} className="mb-4">{para}</p>
        ))}
      </div>
    </article>
  );
}
