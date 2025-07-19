import { serve } from "https://deno.land/std@0.200.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { SmtpClient } from "https://deno.land/x/smtp/mod.ts";
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

  const gmailUser = Deno.env.get("GMAIL_USERNAME");
  const gmailPass = Deno.env.get("GMAIL_APP_PASSWORD");

  if (gmailUser && gmailPass) {
    const subject = `Quote request for ${car_name}`;
    const body =
      `Thanks for requesting a quote for the ${car_name}. We'll reach out soon.`;
    const client = new SmtpClient();
    try {
      await client.connectTLS({
        hostname: "smtp.gmail.com",
        port: 465,
        username: gmailUser,
        password: gmailPass,
      });

      await client.send({
        from: gmailUser,
        to: email,
        subject,
        content: body,
      });

      await client.close();
    } catch (err) {
      console.error("Failed to send confirmation email", err);
    }
  }

  return new Response(
    JSON.stringify({ message: "Quote request submitted" }),
    { headers: { "Content-Type": "application/json" } },
  );
});
