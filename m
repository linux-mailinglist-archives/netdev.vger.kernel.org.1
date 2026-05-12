Return-Path: <netdev+bounces-287086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCchHd0FA2r1zgEAu9opvQ
	(envelope-from <netdev+bounces-287086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:50:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A851EDB4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B17AC3030E11
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5031838E8A5;
	Tue, 12 May 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RjlqZSjh"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA238C2C0;
	Tue, 12 May 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582925; cv=none; b=lRQWyAK97UsCCJoclmicU0SZmJDQcSVzo4SaJZTjBnmOW6wGA4HjE48Jd7CGv2ONEAd6eQuspmsh3b+xF18uVU0M729wsuRegr1XXK3CYqh+0mFyMjueFsTtxJq93Kk3XFpxKqaZeE6RxQ8N+VLV/y1DyBUa6bmSSsvZrMb40do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582925; c=relaxed/simple;
	bh=PMpPkJWHttQX5kh4Gi1+W+Qb2aqcl2x//u13feAjgAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oV8BArmDUPjjUNvylBp4DZLrRskj7VrQmqJc0Si0DeR/mjl/trpmMzg+tH1NLwhWHoduuE9g5qQJowZNma4P2pCqwu/yNNzH+n6DbzAHKSIXHY9E3L7BXPlEX7e/Ovf+7xN1L3vefKCiZYUT7nJF4GoGb4phbOUVueBQu3DK/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RjlqZSjh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ZvvQm/zY3VAgs6XRZ+pEkISjtTM4U0Plb8SiYTnxo3M=; b=RjlqZSjh4On2ZkrUMvm78qqLEz
	d9wKtmWKN+45c4fqqqgp4ei7tlMqmqlq2xjmzJnx2pDnE5DS877pU3ZXaMsxCn7lFK+PKiNkfH7xm
	4fChRk1Pe/7L3MEbYIj+TIY3+qEcFhrBGM8PLQbw89V/KX/2MR2CtQiECZkyjCg6Gd7KYorNdOmAr
	4pLBR0KRHsOczfY+cB8XJETJbIXJdXyMtXkT00+UcX3oQf493TtkdXdw8Wco7xwUXFpOrhAhRwl1J
	EUvfSr2YM9J+BnnhHWYAVfGn6NaoRw1T3UJ24L8JRTF5GwUH8z69WEBN+zxQPisep85I6K31Vx6Y4
	IuXQ7bUw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkfH-002K2D-1o;
	Tue, 12 May 2026 10:48:39 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:38 -0700
Subject: [PATCH net-next v2 5/9] netconsole: move push_eth() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-5-1191d14ad66d@debian.org>
References: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
In-Reply-To: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=leitao@debian.org;
 h=from:subject:message-id; bh=PMpPkJWHttQX5kh4Gi1+W+Qb2aqcl2x//u13feAjgAU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVr6pZmenfFsoBbW78vH44duPepVBAEJEazX
 Xy7pUetPiuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bWHYD/47+lCw3Alw4OsYTwvkkyKnG05vlZx5CpImwwOTlvvKDUeMi0kdN3l65+AY3t+h1piMUww
 vN+xGkPyEcKUWV86KNTGCEoakfhuuzwMzkVQL0tWS0yxFCIV5FspJx0fZCxiD5H9hdZub2FCGtk
 GC0W7Ls2dibL0h/CzcY1af9LrpVohcd48s0eH+Bx1ilZZlYRJiRZ7BHsCb184SEkDR/cSjd6LrV
 bROwHKBKCx/ymtc4bMNkAFnA+t7Dvy+k+R81gHyQzlo7sDEjnwoIve/InjqXzSqUQUM2dkWAvFJ
 cePxcBexe2fZF4ZDyOs1m60bKsL55VmcPQlSG3RLY2zXbdxQgd4UHuEIxZDCFOQOAnhNIOdiD9k
 Vices7f9eMNQDhVQV09Zqz9xbyECHUMww4bqHQfl3uKEcCjYgMpB0EwlXJbX5XHt+yO/hw8eBte
 l6BWUZ49p+ycE3FdVnZDWmN5mQS4E9UmL9kWQpjQmnjfo9SEY+tq8RgVOEbKw3JWgrdrr4BFJfr
 zxasqetaNNFLXrJk+y3AJxIbFblJ//w/9/4NwUQ6cl6xI4NSB8a3upErEdWObx39NzxPuXrjTX4
 jpHP4Yn6S7EFnxzt3SXErV3Nd3KJSiV01oKWDiTNXoTRubTS86v00EEz8+H3u/B2gvIEZMaSld/
 pFHbDscYzFSh1bA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 3B1A851EDB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287086-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

push_eth() builds the Ethernet header for netconsole's UDP packets.
Move it into drivers/net/netconsole.c as a file-static helper; drop
its EXPORT_SYMBOL_GPL and remove the prototype from
include/linux/netpoll.h.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 ++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 15 ---------------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 84f90b53a10f7..bcedc161b13ec 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1652,6 +1652,20 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void push_eth(struct netpoll *np, struct sk_buff *skb)
+{
+	struct ethhdr *eth;
+
+	eth = skb_push(skb, ETH_HLEN);
+	skb_reset_mac_header(skb);
+	ether_addr_copy(eth->h_source, np->dev->dev_addr);
+	ether_addr_copy(eth->h_dest, np->remote_mac);
+	if (np->ipv6)
+		eth->h_proto = htons(ETH_P_IPV6);
+	else
+		eth->h_proto = htons(ETH_P_IP);
+}
+
 static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	static atomic_t ip_ident;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1fcde9c87b8c2..11eb95b3248e2 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -76,7 +76,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
 void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
-void push_eth(struct netpoll *np, struct sk_buff *skb);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 030424e43bfb4..12165667705f3 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -431,21 +431,6 @@ void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 }
 EXPORT_SYMBOL_GPL(push_udp);
 
-void push_eth(struct netpoll *np, struct sk_buff *skb)
-{
-	struct ethhdr *eth;
-
-	eth = skb_push(skb, ETH_HLEN);
-	skb_reset_mac_header(skb);
-	ether_addr_copy(eth->h_source, np->dev->dev_addr);
-	ether_addr_copy(eth->h_dest, np->remote_mac);
-	if (np->ipv6)
-		eth->h_proto = htons(ETH_P_IPV6);
-	else
-		eth->h_proto = htons(ETH_P_IP);
-}
-EXPORT_SYMBOL_GPL(push_eth);
-
 static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;

-- 
2.53.0-Meta


