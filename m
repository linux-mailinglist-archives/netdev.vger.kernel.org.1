Return-Path: <netdev+bounces-285837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOlSIhHm/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B84F71CD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BC3D307B8F4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667EF3DFC68;
	Fri,  8 May 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Gg20uitJ"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF553E7166;
	Fri,  8 May 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247008; cv=none; b=XXaRUwPAh73v1Qb0Zpe0vwPjN1ju58UrfJEJvHAoLURSJxBcmaPwl1LgbbqwS3dYg/qDf2Ivgt9aXYVDj1XfFngWdOzQtFHydjMDbFmNVGSIqyGQ6e38fqVEjaDYlkBOjv8NxeiQd6vKigXChrG73E3Y8UrfnveSh4IQZP7SfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247008; c=relaxed/simple;
	bh=PMpPkJWHttQX5kh4Gi1+W+Qb2aqcl2x//u13feAjgAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HW49blipzUIR1dMNOcfQJ7NQ/v1TzHZLes4VT5MV2lxJh2T+Un/Rh7xKDnn4RkVJc2zgOgKKT9m2sV+hi0TFgXqLUCH2Vau4XHZpI0fnP3BAMbdCwpwLQRXMt0MU2hNG+SeG/kGzH7zXRXBol+0cUKZasZZkbPjam/b+3ZwVfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Gg20uitJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ZvvQm/zY3VAgs6XRZ+pEkISjtTM4U0Plb8SiYTnxo3M=; b=Gg20uitJxJWxnG6KjAYAcAHpwe
	C0fw8z20X7hPDbi/028xV4SrXEf25sEa3cXqnagEL29YL2cu3T6vd94tQMrEVEvIh6GeKlUKGyGKi
	oICW6brb1IVqq72VPDavVBW7MPa4+E8SIzUg8CZ8J6JuR6jahCpQugr/L0s8wDPkJq0jiL3bO//r4
	Tw3E6rz4RGq5x/pDoo/HU7amvu6YbKtVnASb69RlrzwJhCwmxtNGuqlYxJS4aBme42GbsDUhS99Y3
	Rt5xvyZ1Tx9zTDGyZVRpvyD1oT1eB+lhzh7gRVaMoDps9alz9fxuDT56xM22ORdEDGUZTR6E9A+v1
	awUUnFMQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLHA-005AzL-0z;
	Fri, 08 May 2026 13:29:56 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:19 -0700
Subject: [PATCH net-next 5/8] netconsole: move push_eth() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-5-0f660e62841f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=leitao@debian.org;
 h=from:subject:message-id; bh=PMpPkJWHttQX5kh4Gi1+W+Qb2aqcl2x//u13feAjgAU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4D0tBg0kHmPz41CQsjovX2PRvuv3v5uiM0
 +gAF1eaFvmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bVlFD/4/5QHcvzBAOudvYEnr1a/75f+odo3YgFVZ2OEAaXx53gLXxBT2s2Qtv6PlvxzldHgSWyd
 0cSiusL8Ebfe7odS3moMJEr8aHE0oXQeNzaw8ruib6uJHdAN0vdLc/n/6mF78FUeFrLw736VXnK
 vnCXnulkkU7IewYJZyDJm/+sD2sge0mwvq6GgjTlTbFy9a5LnnCSuFUUY5p2HBf3/QU3diVyJIm
 AljoH7ajir3904uWMxnhfziillVvQdcfGCfcy/pi9aYwjmSH2Pm/dJRrwEaXldt3B5Fdr878BJP
 AjCBUUCVX27GbmHCamNpb3wACYq/Q2ObSZyvaOGCEmjHuo5SLawuTsEBrjpk30A8DNxYDnbRSI4
 i9B73vOeDjiPlWOeE58hCtwjkrZiwKScDLtLU9yUTW5t4a1jWA29sOsF7HEX/9QP1SMfqM2cxoW
 AEBSCKO8qEhU28IzJZOMIhh3NKGj97p02TElBpAxKpC/5ayUf4cy7Bhqr4HcB8ewybNYuLI87JL
 QPmyGMWGEXkceNTvaYhC7aYwdTtQlEoc8Nqe6gqxXiR6uxa6ATljUVehGHD7btAiw+3q/7ismr3
 sBR392oQi5tvqxsBg1psRvvRuFPx9lj1nQfptAKO8XaMZdnaJW/eNL8fEVBXZi2NiL1HwgR9djg
 SOtkfgXPO2vOMww==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 020B84F71CD
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
	TAGGED_FROM(0.00)[bounces-285837-lists,netdev=lfdr.de];
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


