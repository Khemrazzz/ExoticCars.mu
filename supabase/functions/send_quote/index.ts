import { serve } from "https://deno.land/std@0.200.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

serve(async (req) => {
  const { email, car_name } = await req.json().catch(() => ({ }));

  if (!email || !car_name) {
    return new Response(
      JSON.stringify({ error: "Invalid request" }),
      { status: 400, headers: { "Content-Type": "application/json" } },
    );
  }

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
  );

  await supabase.from("quote_requests").insert({ email, car_name });

  const apiKey = Deno.env.get("SENDGRID_API_KEY");
  const fromEmail = Deno.env.get("SENDGRID_FROM_EMAIL");

  if (apiKey && fromEmail) {
    const subject = `Quote request for ${car_name}`;
    const body =
      `Thanks for requesting a quote for the ${car_name}. We'll reach out soon.`;
    try {
      await fetch("https://api.sendgrid.com/v3/mail/send", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${apiKey}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          personalizations: [
            { to: [{ email }], subject },
          ],
          from: { email: fromEmail },
          content: [
            { type: "text/plain", value: body },
          ],
        }),
      });
    } catch (err) {
      console.error("Failed to send confirmation email", err);
    }
  }

  return new Response(
    JSON.stringify({ message: "Quote request submitted" }),
    { headers: { "Content-Type": "application/json" } },
  );
});
