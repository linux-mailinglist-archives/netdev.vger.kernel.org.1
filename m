Return-Path: <netdev+bounces-251584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCx9I2zSb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:07:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57F4A03F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDF10A81BBD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DC53C00BB;
	Tue, 20 Jan 2026 18:26:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEF33B97B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933603; cv=none; b=cSe5NY1IQn0cNRNhYoKTgBZGC5VaWBeJLThN9WZOVVBLT9zPVABZtuzfKLwphJ8xes5VrFyDaewwFsM1i3TdW3Y1W67xHH1DEmuZeZCEFHQprqh3eMMhQFYACBdBXN0ll/UsHY/BcAMgxekqaxbYYmeRDPisvx7Dgar7D8ZhKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933603; c=relaxed/simple;
	bh=URguZv+z+GzFNe+cJ2zMPSHRjgwbLnOTJ/PrC+X4qs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEAA0r5fZK930F9y3xcKvXCHJx+qw+0H3GyuSD6MeXa1IGcSM94pEvpzfFHa6We4OtFKy8MkSjFs5vJAJ56b3CqEphaJAV3hSdOsDEzdpsgYD8CssZsvRuiNIGy+LsIjnBa8MBUe6uJjwJ8sGtZkS0mjeXW4YDRHjCkICiIBjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e93c5961cso4710984b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933601; x=1769538401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04o5YPIM/ynG9CDHLB19er8qSsbuftkYbcHCNFB6R4Q=;
        b=mi7sU6SyA0r4uNdurNJOnoKlmD3CjivWWht39iGpqdPmqoiCPsFzLVyha/CsMzwtp9
         qQI26kEEGOyS2bHJ74n5b1LPEPC+XFI4Qq40S9idXlCE80plLfU+Rhz8yMimGTCtYAP2
         JhHk3nYLFkylSztIa8W9N4tLVaMNIkGGoIHl+4BnTSKjH3czBQqXb4v+QfrsJfnGgl2r
         38shvC1oX20FFZL9nfCuEBMrgGO2ZoPrFMvV+lOnE3Yn0NMsk4KqKNWw1xU0Nft1uQn6
         hCzfcWkOuIE+e9qIDU2XYNty5Sc/IduxNcJ/snhAUwnxDNLipH6IuxWJamTTS0DZr6V+
         LOjA==
X-Forwarded-Encrypted: i=1; AJvYcCUVWWsf6LOjAulixj1Vur+lvhXW/oXyifydYcgBYw1UCfypiTMwVgwhmpVBPwfMY8aQzjaiTQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgkshGEpNdhRt9TcjtYm+VS+j5emmfGl1+LXGQ2c8jFTNFz7A
	uRdEUYFmOJPKv9rDpJd4YFRTpQihvCJHi+J7oVvTsRXrYQeVcOH9sLl1
X-Gm-Gg: AZuq6aLfA4BFscAVaNA7Nc/COj5ZxaHqx7mvuiHpn4ASY8jiXYCVN5cnWVSpEH+OfWM
	NfaM/a9QgKLnscMixqAge8/+EXf/4Bqjzya9vkQcAfIqLRnBIVtihqbd9glbdYbhAUa6cJXE/VN
	p2yNov0G57GKVCbrGBYLH/5n2a1pbLzJFqkKnjFli700SuMJOwZFkZLI5A7vw7/XEpF7eFjL3pB
	FAZVz2KrloaRhIj1PYTB7Rbzv7VXW6SA69X62arc7BIAmjB7KJhsb9bvDuVedzlHtO0TRH4za/m
	H1UJ8AJHqL6sFhu1Sm1nmGTFCq7y027qWX6A/DkkWSi0C1ft5tmyZPdgw0QdoGPfdQvfDiRPTtv
	4gaJ3IjATN1chV6SwlNvziUxmcYR5+Bub290QESY8N2ZwY3WVqjgjklGQkF5f9SQUM6ORPyJUd1
	80FWPdqLKDtL7x
X-Received: by 2002:a05:6808:bd1:b0:453:7a2a:62cd with SMTP id 5614622812f47-45e8aa74004mr810527b6e.50.1768926248216;
        Tue, 20 Jan 2026 08:24:08 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5b00esm9168566fac.15.2026.01.20.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 20 Jan 2026 08:23:49 -0800
Subject: [PATCH net-next v2 3/5] netconsole: convert to NBCON console
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-nbcon-v2-3-b61f960587a8@debian.org>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
In-Reply-To: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5459; i=leitao@debian.org;
 h=from:subject:message-id; bh=URguZv+z+GzFNe+cJ2zMPSHRjgwbLnOTJ/PrC+X4qs0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpb6widhBlttuzOawbHxAveWRni5+IZPIISE4jr
 8QIE6VCjaCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaW+sIgAKCRA1o5Of/Hh3
 bWNTD/97j5o5CuRXZxOvUp9rq3WeHpW32Bs2KxnvW29M7PYhsa2Pw/c+NyqFAP0OxkfxHxeLwX+
 BbBe5OlpBebjbryO0kzQdXnNlOpolQanFpaNExqtnqdqWpvhtO3DvtEefBESftjwQemUg+QCjPG
 aA3bpuILcNA6YZOTa10lBD2doTuh7wSO9OcWTc6ywxHwXkRdTYE9BoR3eCZ3ElVXw8V0MA9O65o
 PN/wcDm1njBNl+Y2h7Gs/fZDuM6mZPUJEVo5zIB02sPwv2Jhj6Jd7QZ4DgtIUlMm03n9gOwKSj2
 wZEOS/XSDrTSaiFs8ZPypV/s0oHM5XVHcGsNSlu8k1qrxYgS5xLW8QNs+c+urFD6pm3nvIt+BbP
 YLA7RdiUYVuP1zWQHguMTm7GrLvGK9VDFsc97fn0y/OQIjGP4C/IY3uRM+hHaSRmnfaL+J5ndku
 1B/OslgDhCOK+r+2wrIaGFIUpRLpSm4D/H1ucPT8LR3Nvb6ksGFvfg+F/nqnWZNToSH9uDlMA08
 n7CIf0tfiWkFf/Ey/hbcGejXtQ090KBnScZyxPExEEnZ28WnPMEibrBi4Bo7JhOykoaGlsg3jpI
 Qzz2tMQnq+hcJ5zHsmJQwqcxuUkbxKcDIDL6VH+g47UBWRrZ1E3vneiHumEJ4WBU59teLt/VlCs
 zKTK06U/ezAuV7A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251584-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AD57F4A03F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netconsole from the legacy console API to the NBCON framework.
NBCON provides threaded printing which unblocks printk()s and flushes in
a thread, decoupling network TX from printk() when netconsole is
in use.

Since netconsole relies on the network stack which cannot safely operate
from all atomic contexts, mark both consoles with
CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])

CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
scenarios (panic) where regular messages are sent in threaded mode.

Implementation changes:
- Unify write_ext_msg() and write_msg() into netconsole_write()
- Add device_lock/device_unlock callbacks to manage target_list_lock
- Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
  operations.
  - If nbcon_enter_unsafe() fails, just return given netconsole lost
    the ownership of the console.
- Set write_thread and write_atomic callbacks (both use same function)

Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 97 ++++++++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 37 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index dc3bd7c9b0498..c5d7e97fe2a78 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1709,22 +1709,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 				   sysdata_len);
 }
 
-static void write_ext_msg(struct console *con, const char *msg,
-			  unsigned int len)
-{
-	struct netconsole_target *nt;
-	unsigned long flags;
-
-	if ((oops_only && !oops_in_progress) || list_empty(&target_list))
-		return;
-
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
-			send_ext_msg_udp(nt, msg, len);
-	spin_unlock_irqrestore(&target_list_lock, flags);
-}
-
 static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 			 unsigned int len)
 {
@@ -1739,29 +1723,62 @@ static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
-static void write_msg(struct console *con, const char *msg, unsigned int len)
+/**
+ * netconsole_write - Generic function to send a msg to all targets
+ * @wctxt: nbcon write context
+ * @extended: "true" for extended console mode
+ *
+ * Given an nbcon write context, send the message to the netconsole targets
+ */
+static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 {
-	unsigned long flags;
 	struct netconsole_target *nt;
 
 	if (oops_only && !oops_in_progress)
 		return;
-	/* Avoid taking lock and disabling interrupts unnecessarily */
-	if (list_empty(&target_list))
-		return;
 
-	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
-			/*
-			 * We nest this inside the for-each-target loop above
-			 * so that we're able to get as much logging out to
-			 * at least one target if we die inside here, instead
-			 * of unnecessarily keeping all targets in lock-step.
-			 */
-			send_msg_udp(nt, msg, len);
-		}
+		if (nt->extended != extended || !nt->enabled ||
+		    !netif_running(nt->np.dev))
+			continue;
+
+		/* If nbcon_enter_unsafe() fails, just return given netconsole
+		 * lost the ownership, and iterating over the targets will not
+		 * be able to re-acquire.
+		 */
+		if (!nbcon_enter_unsafe(wctxt))
+			return;
+
+		if (extended)
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+		else
+			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+
+		nbcon_exit_unsafe(wctxt);
 	}
+}
+
+static void netconsole_write_ext(struct console *con __always_unused,
+				 struct nbcon_write_context *wctxt)
+{
+	netconsole_write(wctxt, true);
+}
+
+static void netconsole_write_basic(struct console *con __always_unused,
+				   struct nbcon_write_context *wctxt)
+{
+	netconsole_write(wctxt, false);
+}
+
+static void netconsole_device_lock(struct console *con __always_unused,
+				   unsigned long *flags)
+{
+	spin_lock_irqsave(&target_list_lock, *flags);
+}
+
+static void netconsole_device_unlock(struct console *con __always_unused,
+				     unsigned long flags)
+{
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
@@ -1924,15 +1941,21 @@ static void free_param_target(struct netconsole_target *nt)
 }
 
 static struct console netconsole_ext = {
-	.name	= "netcon_ext",
-	.flags	= CON_ENABLED | CON_EXTENDED,
-	.write	= write_ext_msg,
+	.name = "netcon_ext",
+	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netconsole_write_ext,
+	.write_atomic = netconsole_write_ext,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
 };
 
 static struct console netconsole = {
-	.name	= "netcon",
-	.flags	= CON_ENABLED,
-	.write	= write_msg,
+	.name = "netcon",
+	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netconsole_write_basic,
+	.write_atomic = netconsole_write_basic,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
 };
 
 static int __init init_netconsole(void)

-- 
2.47.3


