
CREATE POLICY "media public read" ON storage.objects FOR SELECT TO anon, authenticated USING (bucket_id = 'public-media');
CREATE POLICY "media admin insert" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = 'public-media' AND private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "media admin update" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = 'public-media' AND private.has_role(auth.uid(), 'admin'::public.app_role));
CREATE POLICY "media admin delete" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = 'public-media' AND private.has_role(auth.uid(), 'admin'::public.app_role));
