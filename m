Return-Path: <netdev+bounces-285838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELMMCDjm/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979434F71D5
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82D43308890A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14D3E3C54;
	Fri,  8 May 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IFmXFs5M"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360983EC2E9;
	Fri,  8 May 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247012; cv=none; b=HgmXol5fQL2W/E4I+tAW1N4pO0IvTivbemmg8x67yb5P2nvsvkdLXO7foKtqQWev49w8lgJGtcOYM5CQT7Um3+jLl1oO2F/F+iAs57kg2C3r/NHNYWRCFX5XFPukPadqCOh3qnCcj4JW8CpFIr24JKg7sa0RMK6I3XJsOgqtZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247012; c=relaxed/simple;
	bh=4INTG1+oJfjYqTw/8Iufhxk8oIaC+BZeDBdAE6GSv2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1grb6XFqxxU6z9Mpk7rlBFUo6bWW7Xrgg974UodB8cUFsbNjOEk8zdFA2gCy/ewSIzdwiWG1bqrN1tW4YUJ3CtoK7US2SjHMM50/SvGut1tZ5WthcqpKwwdzW/Q+TylApBOVvx3wZFUuMwcsKu8g7Ou2VgbRmbFAiXYsAFWs9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IFmXFs5M; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qycDlW1R0cbLg2Vqh/6w/U4a7rxfxey6kPJF0LXVgko=; b=IFmXFs5MCqwlZ2oy1pkuVetCj+
	GbXS+l3cRDcp2P51kfCxJ5zJeZWe3cQUf6sa4jtL6h6/987mtoeZOxevfyC8/8BQZCQPK3zEh3e+A
	keTNgHRLXC6bDpDWYNeM8iMvjOwZB5k+ac+YxDxMsHo3Bv7Aw9XW7zyTFBx70PFZqjgjuUH3OGPPU
	XPjMDSBdki3uI4lXKSmjGvwAcNyBN4JNRDftLuw+SopFgUz+EMZRFhkvaEXNwn4OkV/FKxZRata/q
	1gUJRnhtzYnoTwaK6a15EinnQcvTnhF+Il8TVayLb0XTW1++44uL9K+Q/UC7N7UuxiYYHghFoSq2e
	nGAeW1iw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLHE-005Azr-2s;
	Fri, 08 May 2026 13:30:01 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:20 -0700
Subject: [PATCH net-next 6/8] netconsole: move push_udp() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-6-0f660e62841f@debian.org>
References: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
In-Reply-To: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; i=leitao@debian.org;
 h=from:subject:message-id; bh=4INTG1+oJfjYqTw/8Iufhxk8oIaC+BZeDBdAE6GSv2Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU46lOV4dIaUZoED2/oYJAqO7dSgg5hrPKMo
 VMbhOOVDyuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bWcZD/95gSRQqF7anw9yiyJLbPygw6q651m/JIh3onSmOowhSEWb3HzNvSXL2558R5tg4r4X583
 EmaCAQX6V131gJFpnj/LJfARcwqzsOUqavPrBfpYZTSGBQ3PAoSuR3y4x6HdMPPvfTlf2i110QW
 +V+2hUUmtVlpFBR9bv8WjR9b8XJI/eAV08sqBdbzJnfgxIOHJC8tnDNKibsHf5aPPpPb2oOLoF5
 CV9j5xHUbJNZ6FG6fTWj5yacCbguyczFQnRIv+vT79JaNF5cTY2vB7dtbEVhQ1AhDA9lkGFXW6z
 KDbeRJTC+A4wX5hFsI/AlFZjgxQAw5zM/o+svBlPLK59QRlUz1ptAAjwpcfvwNyVIU3MGheZhET
 mCWlDjAlZQQOLZqBgbA6M3RBGOW7Cr899yKOOeHYHQLer404rzz5OQyVBgGJXik0c4N/DZytGOn
 zzwqSqtoOu6ejObB5Rq+yY7W/TXdpiP4w6wR7hZs8H27OoVCsMcWC5s0DuF76IHyYNKNqB730FT
 Kz9/E8morAyEaEGG5AoMRNY51VUqWuoUx9e7ecpC5MzTfWAQ3NZ62SeXMOShKgpWiz8DHQdBm3u
 cxzXm8Pc4tmyA+TQw7JwcUopaBSpOcgKp0hlcDgjo25NJCLVuxzQthFn50tGZEbuxA21vYjVe/D
 uCFmSeQmwpKwasQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 979434F71D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285838-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

push_udp() builds the UDP header (and triggers the checksum) for
netconsole's UDP packets. Move it into drivers/net/netconsole.c as
a file-static helper; drop its EXPORT_SYMBOL_GPL and remove the
prototype from include/linux/netpoll.h.

push_udp() was the last udp_hdr() consumer in net/core/netpoll.c,
so swap <net/udp.h> for <linux/udp.h> there: MAX_SKB_SIZE still
needs struct udphdr.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 18 ++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 21 +--------------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bcedc161b13ec..e8d96e482fe05 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1652,6 +1652,24 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+
+	skb_push(skb, sizeof(struct udphdr));
+	skb_reset_transport_header(skb);
+
+	udph = udp_hdr(skb);
+	udph->source = htons(np->local_port);
+	udph->dest = htons(np->remote_port);
+	udph->len = htons(udp_len);
+
+	netpoll_udp_checksum(np, skb, len);
+}
+
 static void push_eth(struct netpoll *np, struct sk_buff *skb)
 {
 	struct ethhdr *eth;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 11eb95b3248e2..03a49953a3d8a 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,7 +75,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
-void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 12165667705f3..4ec9e309dfe6c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -29,8 +29,8 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/if_vlan.h>
+#include <linux/udp.h>
 #include <net/tcp.h>
-#include <net/udp.h>
 #include <net/addrconf.h>
 #include <net/ndisc.h>
 #include <net/ip6_checksum.h>
@@ -412,25 +412,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
-{
-	struct udphdr *udph;
-	int udp_len;
-
-	udp_len = len + sizeof(struct udphdr);
-
-	skb_push(skb, sizeof(struct udphdr));
-	skb_reset_transport_header(skb);
-
-	udph = udp_hdr(skb);
-	udph->source = htons(np->local_port);
-	udph->dest = htons(np->remote_port);
-	udph->len = htons(udp_len);
-
-	netpoll_udp_checksum(np, skb, len);
-}
-EXPORT_SYMBOL_GPL(push_udp);
-
 static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;

-- 
2.53.0-Meta


