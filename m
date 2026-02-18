Return-Path: <netdev+bounces-259362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF4nBGMvlmm5bwIAu9opvQ
	(envelope-from <netdev+bounces-259362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:30:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CCF15A192
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B1483001F99
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4A433123A;
	Wed, 18 Feb 2026 21:27:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from helium.schroedingers-bit.net (helium.schroedingers-bit.net [94.16.120.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1133065A
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.120.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450074; cv=none; b=GPoKR2X0Y2dQVYdHwEGv2wNpdRvz6mqNoDDwDitPiOPmhndPbey5+tCqorBq7dONWyZ2Fuaka8gTg7NoANUMQHmjjHBasL13dWWnv+e7qcCwOdTzNzakbxIHXEniR9U+o498UNpBX/jGQkgTvpiyquVzpV46hue8RUSfxNhtJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450074; c=relaxed/simple;
	bh=4P5HkoC2BU5XWlTqhB9thnyU1IPqc35TCgxAd5Ip01o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zoy6t10Ja3VIMjZbCeO55DW9IGbQlghI0PEoBJlOrBsUDYbxgpTubstV08SwCbgHknaatUfjmU/wTP4lRZOxFV66dD1WSOlQqrejPgqMxdemosi5ghFfN1CtlU+1hPVgU0dppd6pxz82k8kcJDR3GMuLdzvWp6AJUmb9FaFEzw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schroedingers-bit.net; spf=pass smtp.mailfrom=schroedingers-bit.net; arc=none smtp.client-ip=94.16.120.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schroedingers-bit.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schroedingers-bit.net
Received: from [IPV6:2a0a:a54a:ec35:0:ea9c:25ff:fe12:908b] (2a0a-a54a-ec35-0-ea9c-25ff-fe12-908b.ipv6dyn.netcologne.de [IPv6:2a0a:a54a:ec35:0:ea9c:25ff:fe12:908b])
	by helium.schroedingers-bit.net (Postfix) with ESMTPSA id CE61484012;
	Wed, 18 Feb 2026 21:19:55 +0000 (UTC)
Message-ID: <b0414a07-f26e-4795-a697-37fb32d05595@schroedingers-bit.net>
Date: Wed, 18 Feb 2026 22:19:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US-large, de-DE
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>
From: Daniel Schulte <trilader@schroedingers-bit.net>
Subject: [PATCH iproute2-next] ss: Remove trailing whitespace when output is
 not a TTY
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=trilader@schroedingers-bit.net; keydata=
 xsFNBFz+MtkBEACxqrUVSvjuaLg2NWN9UcMxwY8lIHg8WOuR9Udrq/3eGMNalEK4QW/Ez7H2
 bdbn5cbCjCfiz2naEeOeQmkNZx7yJOeZCfKpdW7QsPKmRWymlrHMcCnxShw06USt1bLqRG0e
 eyW6NBzSCWqiqzXcw/Xox4F2O8DsNbC4R7tm24Z/rys166RSjSTcP+WOq09aSsS0x6lylsdp
 7oh6ymBmp6MuJRP2HoJNSbHlGO5d/DCnL9fVL3pKJ9bgIXqJY2S0d2DK6MBXkQH9OK2DnWE8
 2b2stU1WWC/0JaPiq8MqJNQSj6uhRyG8nq0DOt4yIZXoJ0nXSaBj5+O4S6Rm2xXIxqhJR8X0
 yHj/KMbZD1IBcyEcM3YImJzlI1KTerGUpaKPbJu+6wr2KiwMRRQ+j7D1o7vjCQmPEUenFad+
 QXubywjyxg6kNOcZwmACUCYTmIt9mKYYZ8Ov20pEKKXz4Ru6geRv+qks550Bzpq7Bmj5pKtB
 HbZILs2uZGBZab0ed4CMgT6zUz7oT14q5CfbEARIzf6RsbGwI6ncaVBovt4WuzB0SmX6wyoo
 pzIkvRKAydu25zBGT36+h4iHdXPkCpRBqkaK8dcM5XvM3rl8q9pn1PodxmHPpYpUiMEbHfPZ
 dTe7BVLKvWlN3xT+Zp71fUPgGfQ9RFiYHU5r/CvEOP0dKIZ49QARAQABzSl0cmlsYWRlciA8
 dHJpbGFkZXJAc2Nocm9lZGluZ2Vycy1iaXQubmV0PsLBjgQTAQgAOBYhBGmJHcnoNFmoqGha
 cPavPw0TiRJsBQJc/jLZAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEPavPw0TiRJs
 hFUQAKPwrEaxJE+RgWJJFfx5scUnHBbAh2d87i7AWcuoAqshPYe2PCaL74RC7BtJPm4w0qf9
 M5Dx/tom4MXB4JIWT+QGzslmhRuAHawVImxLDnzl6DiU+d+k3Lrq84Gfa+lBea7dop//7qPz
 f05ZPr0sszBR59r0TOx2NQpTkW1Ih6tXKzCxyomB+7DJi8A61JccFQiL0X1v22MnwSUAvqho
 gfjBED9EOJJ7MtSE5O6MWhvR/B32WYnFr2FrIWn/73u+JIgpKLxen78YM71NJ0RkXqYuK2qJ
 lqHJ8pKHgl2FCc2RCzWZ8TOs9xwythLwH3Hfuji9O2YZVxUt5t5HDDuis1yu7J4fGd1NoTil
 idQbQ85LrOWjYEkx6FpXafx6/3wouU/TlnWvRmiKUbKJ4PIcsXI6zvkUjTbkF42W/KDIJVyl
 mWhede1Ie2oZkUpPE85Hm4wsOcVGWehXOgb3WCdle0IRnKBSOijVRizyT4bCcQOQ+/JXFFYo
 4zIiPrMD3dJl9f1iGzXOjGsNYGFW2iymJGPrmUGPFXBCXQc4k3WZYQYWKBguymcmOrS9qtCu
 MS2fTiychhtdNyAm12dxRLRXbSOBo4gGugW1cSLLoC/KynYBT0tbqvvrFkjGHUBHhhdITA35
 aNpF3YI9XeovKwcet3umoR7WZDUsnqNc7EggJCZAzsFNBFz+MtkBEADIP4kK23Ags61F7jgH
 fLH08kHYsWdi9FVAB9oyGoygsLMgTScOQjXkqFmW0gqnFNBniRBdSTC/RHfAT1GCVBMeXJFy
 hW49zmNB2xZFLwbj1K18Klgy+AndqCfkhMjuMBlNrX1+K0+Lr8LUrRL6Zcsc73x9ZiODL8Vq
 Nmx/q4FxSFXOZCLxa4xGEGyt55WRtxdygDFvjLu9nCftcBsX93L9xLNJo79BGdESiqMtoGZz
 D+TCjj27sH80aW7kk2LfBPPivZzTu89eyTPav/9uIxtzb2W7prI83jKZj0BJgax/18FnBjKE
 lTbNDFHaW+9SX9svMlrSFxVgegm26nij30zDJuoQLaTinaJzDsHhi00PIo2O77Fv/HupT2MG
 zcDVK5FdiPX1/N8KmCUlNE+k+zC8E5uUEU9awtYRmzXXpG2tqlVrpSxiD0t5DL0O6BoXPCiO
 vvmYikhzHSPLtSGleeEZzGRufilHYBQi+RVzxqVjUb49g5Pq4rMLvJ6765/W2PQKsNFFWBfk
 nRrPfpGwiTJLMrpQdxvSIcjAfctznMDXHZVgZjNoN8SqPHk7lIN5TdmLEInrhC0iKKayBV96
 +yD9PzD9uyQDBSNxaj9gDcV9z1y1I2lxZPBFsqzc2W+AXG6lthq8G1G+NI503ZZfyzgTMpGB
 npTuJtbTYR4doCjZJQARAQABwsF2BBgBCAAgFiEEaYkdyeg0WaioaFpw9q8/DROJEmwFAlz+
 MtkCGwwACgkQ9q8/DROJEmydMA//ST1zXIqhSZCDnH0l8lgI+wXjoAwo0xNOH6O+xYzCLMdh
 aR/bCiEx7zFqdDbWDyjjE9EVxvcUrSaQeRQ7pAhdgW9uMvjl+oLyrKYmjkAF39pCbF4vlVKO
 PZqe0JtDwyn4nVO0efwWK2POeAP2yZDLwmKRYoAznB7m6nJ5D95Rakrl1GvSCYsPTb3oKGvu
 340wfaCqe8pWfkVRNlWY5tHHdaR+pYgLDEPei0CIeLGDwalryUQ1cayBEA8I90vG54l5pbo0
 rLmmfqDuVMl8IsLag49arHgXi5sauKJfhrE6K6H8rwlK5T1ha14HAvpw4ejWlLKyu7SLGsdS
 kcHWXSgefuHyqgwJCEbIifdicIlNcoIVUUX+Oprp1b5J3BO3KkMrLFDB72UGJhU9iafA4OJb
 H+jtKkbqk0c/YrEy3xWflx/bDq2P1RE71/+YDrIVpHrHUPL1BLd+hrcSmwz6jxXqJl2SeZAk
 gIH0K959aNkadlHU8gu+ApBJmUjdFtmbHY8+JIAQnoy2pyTUVIf50zRufnzKDd+Hynmn/sdq
 o/2pggxcThPPhCp7RG77we1v7YfQlRog8gb/gnfZZu/NyVbDx7Ss3/woyPfACZyReltBfLZG
 afQEKmAt9lUDOEMxEuT/rrd8jdTijkZkvT67ewozfuUwvojtgDjxLnwaV02fKJY=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schroedingers-bit.net : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilader@schroedingers-bit.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.956];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,schroedingers-bit.net:mid,schroedingers-bit.net:email]
X-Rspamd-Queue-Id: 52CCF15A192
X-Rspamd-Action: no action

Sometimes a value in the last column might be very long.
When grepping ss output the matched lines are also padded to the longest value.
In some cases this can result in multiple lines of the terminal getting filled
with spaces.

Don't print right padding in last visible column when ss can't determine the
screen width.

Signed-off-by: Daniel Schulte <trilader@schroedingers-bit.net>
---
  misc/ss.c | 20 +++++++++++++++-----
  1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index b3566f6b..2cd6b470 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1211,7 +1211,7 @@ static int render_screen_width(void)
   * aligned across lines. Available screen space is equally spread between fields
   * as additional spacing.
   */
-static void render_calc_width(void)
+static bool render_calc_width(void)
  {
      int screen_width, first, len = 0, linecols = 0;
      struct column *c, *eol = columns - 1;
@@ -1245,7 +1245,7 @@ static void render_calc_width(void)
  
      if (compact_output) {
          /* Compact output, skip extending columns. */
-        return;
+        return compact_output;
      }
  
      /* Second pass: find out newlines and distribute available spacing */
@@ -1304,6 +1304,7 @@ newline:
          len = 0;
          linecols = 0;
      }
+    return compact_output;
  }
  
  /* Render buffered output with spacing and delimiters, then free up buffers */
@@ -1311,7 +1312,8 @@ static void render(void)
  {
      struct buf_token *token;
      int printed, line_started = 0;
-    struct column *f;
+    struct column *f, *last_visible_column = 0;
+    bool compact_output = false;
  
      if (!buffer.head)
          return;
@@ -1321,11 +1323,18 @@ static void render(void)
      /* Ensure end alignment of last token, it wasn't necessarily flushed */
      buffer.tail->end += buffer.cur->len % 2;
  
-    render_calc_width();
+    compact_output = render_calc_width();
  
      /* Rewind and replay */
      buffer.tail = buffer.head;
  
+    f = columns;
+    while (!field_is_last(f)) {
+        if (!f->disabled)
+            last_visible_column = f;
+        f++;
+    }
+
      f = columns;
      while (!f->width)
          f++;
@@ -1340,7 +1349,8 @@ static void render(void)
          /* Print field content from token data with spacing */
          printed += print_left_spacing(f, token->len, printed);
          printed += fwrite(token->data, 1, token->len, stdout);
-        print_right_spacing(f, printed);
+        if (!compact_output || f != last_visible_column)
+            print_right_spacing(f, printed);
  
          /* Go to next non-empty field, deal with end-of-line */
          do {
-- 
2.53.0



