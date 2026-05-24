Return-Path: <netdev+bounces-291210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMJMB6EkE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:17:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE45C3137
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66CE4301B924
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990573AB496;
	Sun, 24 May 2026 16:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC23AA1BB
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639157; cv=none; b=K5VcHdvCMDbEYn/FmmDUuXrjG8Iym1zchNftyUYF7IWnR9tpeVEm5G58ytuoAY8PiHJpDa0Xmx358bychpP9JkBOVAaWe7f3yU2LsJItnPeg6bHcNHNMuj+C2+NSwLRIP53KP51PjI85WpjTRS7uU8udVBi2nPYDq/0uh2MzQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639157; c=relaxed/simple;
	bh=Yoy7b4IX7Q3gIK8QWyqTSh51xiLDR24883Jvqpd8ZGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szYxvrqgwmYT39Xn4d6AEKJBgCZmgHLm8I7bnp5qlhyvelzhTRH6qbGKDb7JvpPLIozGzGnqOdS1/oAWSY8TsFhzIJuK6Hi68owXqbyFnQLSPNfqYqmGpL3jTPIH89usGQ9nODGyeA82b0gehE9UiyNXMdWATnEsPrJ9HDPpuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-47c7b282d73so5853403b6e.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639152; x=1780243952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQ5ZFv4zqTjU+YraDC0YfxKk0Y8XgFqrJVhkuiFQ0YE=;
        b=O93Rq6IVQhosjKmu602d/SwxrXQoASoWgL4TH1FG1LxHpQFMJrw0hwJb5THqg6nzPl
         0uHEZ7AKB1pgS2L7CUF8JlTZddTfyqIjJuR7rt72dHVvYu25mKjLVKfGhY5d2wH5nLoc
         7EwHalpwHvHR98g6FQT1Ce0qaI+mCWHB86V85htRWomDqrimv4Nzv8/7taMOpSJjKG4Q
         Pj86GP9DaR4GOKWhx4KNgUGzvcrHSS6vBCnq90FIh8GvxlxShiJfPq7O5JEuRA5QbMXe
         75N0TcarjjkRC7WxH2e0udvSeT8ytAwGhE0JVGuWCPCNsBCy0mvzGDuhbiKpQc97tMSl
         49bQ==
X-Gm-Message-State: AOJu0YwVOiXO97dmR2ZuXJ9KXZUyjomS66dEocHM4OZ51ny4+ld7l0d+
	09BV7Us5eJIOs/ti82u2KIpNfuWxdofgcxe2B+Rgms0yjRkqDfqnwLNDXJXHYagC
X-Gm-Gg: Acq92OFCU9SvQwd71vC2On3uNYF8zA6SZFAR9qLKsjTuD4uy8fqL3cnAZxOCUhwpk/P
	f5KfrgXu7duuqUM4vhq9qX6pAARvM8qhQtxPzm1FFaSj4w+VoAEc0O6WT7x8fAiQ7w1BQnPHhky
	pYHbPjTsl+4sE+XajPHnMfSNpqbg/OIDNBGYDxnU7yiPm2gecgxuNMKjryRGVSr583vQI88RRu+
	65vkhUJpOOgbGMeBYiVQcyjaXjEO/LXIZ5qHjtDYsyupwrLdsR1YFolL9vGLQ2rcf5za8Z5aU6u
	jFAVJNSZgY0QRu4kqH/j0/iivz7mRJlwIi8Sl3QyA6yBEvLQtYcYJ0KvhrwZhxHhnbFFknxZM0p
	BN4HbrRLAL8/P31Fx9nHC0Xse869E6d/n0DddSF27k6yJ4x3rIL1kGpiFdHqEzcrrhy5vHVbglV
	iwpoAMrTkGTuKHsWWCK1u1oo8IKFZUpeFhYLY=
X-Received: by 2002:a05:6808:1521:b0:485:1174:4582 with SMTP id 5614622812f47-4854a0eb6ebmr7684343b6e.13.1779639152191;
        Sun, 24 May 2026 09:12:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6065e6aabsm5589238a34.13.2026.05.24.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:24 -0700
Subject: [PATCH 8/9] netconsole: move remote_port from struct netpoll to
 netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-8-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=leitao@debian.org;
 h=from:subject:message-id; bh=Yoy7b4IX7Q3gIK8QWyqTSh51xiLDR24883Jvqpd8ZGI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlcbGdUtW03jM9/bec0QsfkwZSiZIKAhBU2
 pGLl7xndXOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 baxlEACEGNJcQ/LVw0+2GDdZfjS97JnL4p6NPMZGcDYosrotkT8Eo55iHERFzbG1v95f1O2zkJ8
 RFdTq2zkoei+XxiyKypt3W3015Uk76iad7IbB7xq1MZn3uSqVPMyVFNTMmBnwWGxH16hSM2h3kQ
 i05KQhc6alXuzkBJd0hNr1fY8cGNjfYoGnw0Fd+P5YgCqt+7DYUZIFKOzPeeG1KXf0t72USvho+
 N3cp0/0VxITppI4nHYYePli8T+uXEa5rzxl3ujl9gfi4s68vXv4ShHqthDDD1R9DhDitx3J55R3
 8mKakGgZcRfv1fMwVKgP8x0dtEVXWDshzYobywYAp2HI/aX3SLKTWFvT5zdE+Fo6/uR1I55KL1Z
 yFNED+0AJ6oBk6fxvyEaIEgthP1ORpTRZc0e7NZTCneOjzJmUtNFzIPozZeguf03K5WGd1hY05x
 GtPFa22YphyUuHU+4pJYgCTueJ+KPOSDkmATyT6sJ+HbRK9spNJExdwLanNbwtwMMhm4tkdyXuS
 nvGMFkg470UW5UFw8fYltGDZGlyd1ur+sKcn1AmjffjBv/9Zy45f5tS7ihAKduHSYubDYrNmtca
 OE5r4I1uAAM7Ex8eyL2nwnnzfJrjcgfOO84L2AcVbiaxNOwlyvnxabszELPeJkFsIvssRXetwpC
 /HpCD3J3S6BcWZQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291210-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.776];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6CE45C3137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The UDP destination port used to build outgoing log packets is pure
netconsole configuration. net/core/netpoll.c never reads it, and
no other struct netpoll consumer touches it.

Add remote_port to struct netconsole_target, drop it from struct
netpoll, and update alloc_and_init(), the remote_port_show /
remote_port_store configfs handlers, push_udp(),
netconsole_print_banner() and netconsole_parser_cmdline() to read
it from nt-> rather than np->. The struct netconsole_target *
parameter threaded through these helpers by the previous patch
already gives them access to the new home.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 ++++++++------
 include/linux/netpoll.h  |  1 -
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a4f34560cee5..32e2a925f915 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -177,6 +177,7 @@ enum target_state {
  *		that netpoll core still reads (local_ip, remote_ip, ipv6,
  *		dev_name, dev_mac).
  * @local_port:	UDP source port used to build outgoing log packets.
+ * @remote_port:	UDP destination port used to build outgoing log packets.
  * @buf:	The buffer used to send the full msg to the network stack
  * @resume_wq:	Workqueue to resume deactivated target
  * @skb_pool:	Per-target fallback skb pool consulted by find_skb() when
@@ -205,6 +206,7 @@ struct netconsole_target {
 	bool			release;
 	struct netpoll		np;
 	u16			local_port;
+	u16			remote_port;
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
 	struct work_struct	resume_wq;
@@ -430,7 +432,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->local_port = 6665;
-	nt->np.remote_port = 6666;
+	nt->remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
@@ -479,7 +481,7 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
 	np_info(np, "interface name '%s'\n", np->dev_name);
 	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
-	np_info(np, "remote port %d\n", np->remote_port);
+	np_info(np, "remote port %d\n", nt->remote_port);
 	if (np->ipv6)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
 	else
@@ -607,7 +609,7 @@ static ssize_t local_port_show(struct config_item *item, char *buf)
 
 static ssize_t remote_port_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->np.remote_port);
+	return sysfs_emit(buf, "%d\n", to_target(item)->remote_port);
 }
 
 static ssize_t local_ip_show(struct config_item *item, char *buf)
@@ -958,7 +960,7 @@ static ssize_t remote_port_store(struct config_item *item,
 		goto out_unlock;
 	}
 
-	ret = kstrtou16(buf, 10, &nt->np.remote_port);
+	ret = kstrtou16(buf, 10, &nt->remote_port);
 	if (ret < 0)
 		goto out_unlock;
 	ret = count;
@@ -1800,7 +1802,7 @@ static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
 
 	udph = udp_hdr(skb);
 	udph->source = htons(nt->local_port);
-	udph->dest = htons(np->remote_port);
+	udph->dest = htons(nt->remote_port);
 	udph->len = htons(udp_len);
 
 	netpoll_udp_checksum(np, skb, len);
@@ -2274,7 +2276,7 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 		*delim = 0;
 		if (*cur == ' ' || *cur == '\t')
 			np_info(np, "warning: whitespace is not allowed\n");
-		if (kstrtou16(cur, 10, &np->remote_port))
+		if (kstrtou16(cur, 10, &nt->remote_port))
 			goto parse_failed;
 		cur = delim;
 	}
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index dcea36713720..12467a45929e 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -33,7 +33,6 @@ struct netpoll {
 
 	union inet_addr local_ip, remote_ip;
 	bool ipv6;
-	u16 remote_port;
 	u8 remote_mac[ETH_ALEN];
 };
 

-- 
2.54.0


