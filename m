Return-Path: <netdev+bounces-306536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5VCMMzfUGq36gIAu9opvQ
	(envelope-from <netdev+bounces-306536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E373A812
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=dFScEvKM;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306536-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306536-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9506309FFA5
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036D4279E0;
	Fri, 10 Jul 2026 11:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F33101D8;
	Fri, 10 Jul 2026 11:54:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684498; cv=none; b=eiSEV7mgeIo5vl3ExDavcFTUppmOAOhjd7kKlYd0xS0GMOhLJVAr1Kb6hNwDK5rASct3Z8tXj4/UCAOvh+q4rNvO75rqtBZFgbmYiYjXLQDRmcLeQ4gaQiCBCSGLpCBK+U28VgRZ3rI1ajVxcNJt0PJcX3VUD+KLE1AmEkLM0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684498; c=relaxed/simple;
	bh=rGGUtumckKrJIKYQ75Bk9G294xyMletBd7cPywIk138=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLrccAYEA457yAW98HkzjiHhDLXzENSNfEE/BRaLOjH6g4IfoaijB+WBQq779SWaiXLYleTOO5Mddl29WCqk0+pIxi5XTy+7TeKC29GveUTxs9HSVj/mfhL8UgV8EkOrgqcuD+5x3Xanx6WDXA8lXpRq8y59zVXMqStl5gHZlVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dFScEvKM; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pIIeqJjexWwEnHyf9qzByjfWu006804orK1mRN1Vwgk=; b=dFScEvKMvpUYxIIoU7ARmE+SWw
	+hL8fsEKreZiWwEJRxD38ge7R/xF9JA/zlRYOYfO6G63bdXrDZwSQKGjsELy5JSMaNTeJs4ZjhhzR
	EOMSpyQQYsxnXQVhRsXZ1U+o7VlIWARuW2Ah3RXDfooLPOKxcVPcrFY3m5zVoMKPfJyYcaC2XXr2+
	pwAwqkyQTE83A38zlKQGcbV+Cssmqj20+G974I+qlPOq/qS6sa/lJQNVtYcSFuHLRmUfqD7cG+UZb
	ZhHLBQInGFnJYkTnLsmMonIUYQkgl1luhKL0XwO488LvIG3kbUTY35DExZxhDlIee0zPULB7I4Kyv
	dsRLmfzg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9of-004SZe-0C;
	Fri, 10 Jul 2026 11:54:49 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:39:00 -0700
Subject: [PATCH net-next v3 8/9] netconsole: move local_port / remote_port
 from struct netpoll to netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-8-6f63f76b28bc@debian.org>
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7725; i=leitao@debian.org;
 h=from:subject:message-id; bh=rGGUtumckKrJIKYQ75Bk9G294xyMletBd7cPywIk138=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jJvWxXKLbRtZkA+zaxMBDW6kHYXWGNJPK8
 qjKShYoSRaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bcLnD/4h4VByBs+OsRx1pCGlvVT8OIK28rBGKcRYFSEAtLbDxbehF8H62QcRcVF/ftN1lHnBEkZ
 jFqNXOYgCwcg+VBwE5Levs/wyDLY0kfx+paBRK4AShSYGNGgbTXnaMxpPv7yYA4/6lzI6wvrAIf
 e920VJTFxMR98DSo3bsjJIS7nv4zSBHje4r6z9XUjqJ1OAZfoJiPWQEeY2RYy9EpwYH19dwXnO/
 psSxq+/VMmcnP12/a1NCem9SptkJM0C4Mt6lk/Ge0msJ5fUgM06a0jjzcBgjI3ADnng7vfbCo80
 JMeeOU1IcqfvF4njDqTuwCfRonFZdEenl3yOkBTZ67UO7zNqM1XKTkx5sf+lFxMtsHcLv1cxJSv
 59YyvcVj8qPXoDbK9gfgbZsrGt9mzxt0JF5ezwBR5RkjKzNGjYMm0tnBNWOBOLXh42O6bfl0OTV
 gmGadPIXyLj34heSBc1zpfBJNxz4pnhpjbWqtPpXXiua/33wlk3wZHfWgLLOWxwSN9JG8/GlB8Q
 VcPZSoouQK9Re4BCHQSIo55rKqIUcyq4129qThlghPFqmBpZFuWBgM94dritg8VtIepS6/ged3j
 uTcUO16hWwMejZTItqaANaKoEn5aY1AjKmYda/o20BWXHWKhJq7tJzlDXP/3/sZlefwSbBWxFOw
 jRwjWY7Wuu7tz3g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306536-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B5E373A812

The source and destination UDP ports live in struct netpoll but are
netconsole configuration. No other netpoll user (bonding, team, vlan,
bridge, macvlan, dsa) touches np->local_port or np->remote_port; they
only use the netpoll TX/forwarding path. Only netconsole's UDP framing
and its configfs/cmdline interface read these fields.

Move both into struct netconsole_target and convert the three helpers
that read them - push_udp(), netconsole_print_banner() and
netconsole_parser_cmdline() - to take the netconsole_target. The
configfs show/store handlers already have the target in hand.

No functional change; the local_port / remote_port sysfs attributes are
unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 47 ++++++++++++++++++++++++++---------------------
 include/linux/netpoll.h  |  1 -
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index cf591ae667362..d0739b45f66e1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -175,12 +175,12 @@ enum target_state {
  * @np:		The netpoll structure for this target.
  *		Contains the other userspace visible parameters:
  *		dev_name	(read-write)
- *		local_port	(read-write)
- *		remote_port	(read-write)
  *		local_ip	(read-write)
  *		remote_ip	(read-write)
  *		local_mac	(read-only)
  *		remote_mac	(read-write)
+ * @local_port:	Source UDP port of the target (read-write).
+ * @remote_port: Destination UDP port of the target (read-write).
  * @buf:	The buffer used to send the full msg to the network stack
  * @resume_wq:	Workqueue to resume deactivated target
  * @skb_pool:	Per-target fallback skb pool consulted by find_skb() when
@@ -208,6 +208,7 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
+	u16			local_port, remote_port;
 	/* protected by target_list_lock; +1 gives scnprintf() room for its
 	 * NUL terminator so a full MAX_PRINT_CHUNK payload is not truncated
 	 */
@@ -459,8 +460,8 @@ static struct netconsole_target *alloc_and_init(void)
 
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-	nt->np.local_port = 6665;
-	nt->np.remote_port = 6666;
+	nt->local_port = 6665;
+	nt->remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
 	INIT_WORK(&nt->resume_wq, process_resume_target);
@@ -499,16 +500,18 @@ static void netconsole_process_cleanups_core(void)
 	mutex_unlock(&target_cleanup_list_lock);
 }
 
-static void netconsole_print_banner(struct netpoll *np)
+static void netconsole_print_banner(struct netconsole_target *nt)
 {
-	np_info(np, "local port %d\n", np->local_port);
+	struct netpoll *np = &nt->np;
+
+	np_info(np, "local port %d\n", nt->local_port);
 	if (np->ipv6)
 		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
 	else
 		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
 	np_info(np, "interface name '%s'\n", np->dev_name);
 	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
-	np_info(np, "remote port %d\n", np->remote_port);
+	np_info(np, "remote port %d\n", nt->remote_port);
 	if (np->ipv6)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
 	else
@@ -631,12 +634,12 @@ static ssize_t dev_name_show(struct config_item *item, char *buf)
 
 static ssize_t local_port_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->np.local_port);
+	return sysfs_emit(buf, "%d\n", to_target(item)->local_port);
 }
 
 static ssize_t remote_port_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->np.remote_port);
+	return sysfs_emit(buf, "%d\n", to_target(item)->remote_port);
 }
 
 static ssize_t local_ip_show(struct config_item *item, char *buf)
@@ -826,7 +829,7 @@ static ssize_t enabled_store(struct config_item *item,
 		 * Skip netconsole_parser_cmdline() -- all the attributes are
 		 * already configured via configfs. Just print them out.
 		 */
-		netconsole_print_banner(&nt->np);
+		netconsole_print_banner(nt);
 
 		/* Initialise the skb pool before netpoll_setup() so the pool
 		 * is valid as soon as nt->np.dev becomes visible to
@@ -965,7 +968,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ret = kstrtou16(buf, 10, &nt->np.local_port);
+	ret = kstrtou16(buf, 10, &nt->local_port);
 	if (ret < 0)
 		goto out_unlock;
 	ret = count;
@@ -987,7 +990,7 @@ static ssize_t remote_port_store(struct config_item *item,
 		goto out_unlock;
 	}
 
-	ret = kstrtou16(buf, 10, &nt->np.remote_port);
+	ret = kstrtou16(buf, 10, &nt->remote_port);
 	if (ret < 0)
 		goto out_unlock;
 	ret = count;
@@ -1863,8 +1866,9 @@ static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 		udph->check = CSUM_MANGLED_0;
 }
 
-static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
 {
+	struct netpoll *np = &nt->np;
 	struct udphdr *udph;
 	int udp_len;
 
@@ -1874,8 +1878,8 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 	skb_reset_transport_header(skb);
 
 	udph = udp_hdr(skb);
-	udph->source = htons(np->local_port);
-	udph->dest = htons(np->remote_port);
+	udph->source = htons(nt->local_port);
+	udph->dest = htons(nt->remote_port);
 	udph->len = htons(udp_len);
 
 	netpoll_udp_checksum(np, skb, len);
@@ -1971,7 +1975,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
 
-	push_udp(np, skb, len);
+	push_udp(nt, skb, len);
 	if (np->ipv6)
 		push_ipv6(np, skb, len);
 	else
@@ -2289,8 +2293,9 @@ __releases(&target_list_lock)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
+static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 {
+	struct netpoll *np = &nt->np;
 	bool ipversion_set = false;
 	char *cur = opt;
 	char *delim;
@@ -2301,7 +2306,7 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 		if (!delim)
 			goto parse_failed;
 		*delim = 0;
-		if (kstrtou16(cur, 10, &np->local_port))
+		if (kstrtou16(cur, 10, &nt->local_port))
 			goto parse_failed;
 		cur = delim;
 	}
@@ -2348,7 +2353,7 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 		*delim = 0;
 		if (*cur == ' ' || *cur == '\t')
 			np_info(np, "warning: whitespace is not allowed\n");
-		if (kstrtou16(cur, 10, &np->remote_port))
+		if (kstrtou16(cur, 10, &nt->remote_port))
 			goto parse_failed;
 		cur = delim;
 	}
@@ -2374,7 +2379,7 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 			goto parse_failed;
 	}
 
-	netconsole_print_banner(np);
+	netconsole_print_banner(nt);
 
 	return 0;
 
@@ -2412,7 +2417,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	}
 
 	/* Parse parameters and setup netpoll */
-	err = netconsole_parser_cmdline(&nt->np, target_config);
+	err = netconsole_parser_cmdline(nt, target_config);
 	if (err)
 		goto fail;
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f377fdf7839ca..5ca79fa7d9431 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -35,7 +35,6 @@ struct netpoll {
 
 	union inet_addr local_ip, remote_ip;
 	bool ipv6;
-	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
 };
 

-- 
2.53.0-Meta


