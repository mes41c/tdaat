import { createFileRoute, Outlet, redirect } from "@tanstack/react-router";
import { supabase } from "@/integrations/supabase/client";

export const Route = createFileRoute("/_authenticated")({
  beforeLoad: async () => {
    // getUser() awaits session hydration and revalidates with the auth server,
    // which is required after an OAuth redirect back into the app. getSession()
    // can return null on the first render after a callback and bounce the user
    // back to /auth.
    const { data, error } = await supabase.auth.getUser();
    if (error || !data.user) {
      throw redirect({ to: "/auth" });
    }
  },
  component: () => <Outlet />,
});
