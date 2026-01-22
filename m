Return-Path: <netdev+bounces-252352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPDzJpEkcmnhdgAAu9opvQ
	(envelope-from <netdev+bounces-252352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2267383
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB922788EF7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9022FDC5E;
	Thu, 22 Jan 2026 13:12:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01351286D70
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087544; cv=none; b=aECBW1a6Azq534O2z0AKZbXBOOAnrYm4TAs0bBVtP/pYsDeNgbi9Ke6hJDul54K0vE8Rad+I7ZxBGxDdh7dtBp7Ek4qJ7rBl21d7DaegbdHbE3d08G6oVKIqLKuaJTIxT2mHkgbQ6tyiiHvgG3IJkHQ+IOl8AAsBVY2DTGgB4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087544; c=relaxed/simple;
	bh=URguZv+z+GzFNe+cJ2zMPSHRjgwbLnOTJ/PrC+X4qs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQvO41jfF0qDWrw2NVZs18mqbL69plWZO3PJoMvc156GjnoVIiZxiQ7nJ8gha4pEQsg3heWcof7boSwC66vEe8RoZAA58pQnpF8/ezDXWUKW/ZJTWAV29H/ibriXTAfYp95LcfLNimLcD7EG+DeKqNzpQ9VabkPjns0x0QUusXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-941063da73eso442958241.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769087541; x=1769692341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04o5YPIM/ynG9CDHLB19er8qSsbuftkYbcHCNFB6R4Q=;
        b=tIx4tW2jCccAFoWKdXtrZNuX4FB9KAwm4BU7lDHLjX9xEUw5Ewl11lU6d7KX83j3nH
         kgmPqF0j2NIIECgdjuvBEU0LjoAabVnEivcEoPEma1v0AA6sLWRUPVMPrIoFFOuUCync
         JBEZfOc+ywZxp/9rJBO1uJM3S80Ol3UC+IYnUzGmwly9MkJz3uSceuc7GfX+/htfyWAD
         91fe4s4iZXHiUdCEonoASCbJ5Pem2cL5qw1F8ssLPKwE5RpXF0ci8hEWqAT7t2mt2lUb
         r/TvEh0+9O6cgne2lxMEBIEsk6Dgz++08EEszRnlcPK0hO7/fqVtXRC1pKEElJz6cqcm
         9xbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOoFi9jfm1iOtHj8ukjdA/Co7w93A5NaNKEJ2wiht3jqVMjrR5eRMkHqEbo+YkIfk9/ZKXEv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHV1MHApYB3spxPSygQIwQ7ILifyQR4dnaoDegyaYkkQYX/q8o
	a8CG8zlAPeoJPlO5TVjThRXAQmto9ok0lnN+0P69pd12MbLC99UdqZJ6F3h03A==
X-Gm-Gg: AZuq6aLMOC4Pr/j2PvqUmdRVIOeQW3zwyZYP+94H9A1juc01J/QzzaF5i5xN6M181TL
	AtJEs2z3WOb+4maOR+GIliItwu005ieYhOWebMgEaGxLPny3su8AMD6w2j4Y4WDlXCELXKxlfFW
	i704k82eT2KxKEVaTZyPW0DfU0IKpKRXa8CZU7IsXi7X7TXUFut96F94K4cyoUxqh9Lwzr4uGK9
	Xm+ATMVpXyRA2kH/CIvT0g5XW17dI/b41uaZjjMQTn5yfhjqazjvrx/3Pikjot0dWM58y3g9LfZ
	DxMdlwM/783V7UFu968aEOdFBeZcbby5X9GU7ecx0fTeikFrZasDesAzuur4sdIcZIsY0abqtn6
	bqyLANqaFAsD9NuT4mZg0gGbPr6PgoN6EhJsmpbdH63KXAVZmWv1MgOluhBh9E59NmyEagN8ski
	iUiw==
X-Received: by 2002:a05:6830:7304:b0:7c7:26e:468f with SMTP id 46e09a7af769-7cfdee2b737mr8142806a34.22.1769081554106;
        Thu, 22 Jan 2026 03:32:34 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a60f1sm12036266a34.23.2026.01.22.03.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:32:33 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 03:32:11 -0800
Subject: [PATCH net-next v3 3/5] netconsole: convert to NBCON console
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-nbcon-v3-3-a722f2f0dfa5@debian.org>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
In-Reply-To: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcgrNnBzlq2sCqvYqNWopVniZXZwhF+EAy0FZt
 /lJur4VjiOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXIKzQAKCRA1o5Of/Hh3
 bQgrD/9LJPolJfqcMzc7xid17bEvJo25PdG3c6+kGt1qwOXC596udfOZRcEhn5Qm14JVzbejD/g
 JQM3P1aflYOCJSiKSA8E4GQGCz3w5zEmhu0vDF1fetEEuY3AFqJmHpWpbSQAV0n60e5Wa/BZ6DL
 pfDjWYOcio/XpOaikwdd6W23F9pGt4FZxdeFoVvL308VVVFlr6KYkztaeHLsQ7dVVoHortUfKEs
 KUw/zU0hEtJrI8l7sfpwNy6SrnJWat/a/EkrIgYLoCKG92Z2OMsFekAnTEMbegfn8+C6vGKrrFE
 Pr82pHiZ0xAl7xOalemmNEvQWKRcBxqqbKIRvqFgJDd8Ls/rarknuZabBZeDmLdzWyJMZDCl8yW
 TLPcvLLvmTmlhahIGHEb951aTQhAuABOpbUtyPQveo1r3ZdwnXbr3NmS3J3hSgCwlVzzjfQGd6r
 aCRpz5Y8AzTTkIWuOhQmkA/0s7Z94xneWMOfVODD6IuRAGzTKAJim3vxxEH9hlJf9Z1dEuYXc5a
 qBszkoW+U7p+m0c+QwkwQLMKQxmliwEuzL8EeCZ3XTukqwVONOrUspivL0PRoBVyDEmA59q7DCW
 cPFRjO7idJ5X9PgPHq8BulGvM8+5e+pB+e0OsKzv4YRBXs443VgdE7XUlTwuyn4YjqF1/FDQs4a
 U6JlsStVydjYXXQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-252352-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 44A2267383
X-Rspamd-Action: no action

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


