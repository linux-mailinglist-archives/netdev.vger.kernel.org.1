Return-Path: <netdev+bounces-287082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7M+uLJcFA2owzwEAu9opvQ
	(envelope-from <netdev+bounces-287082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:48:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F14151ED60
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA47C3033ADE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135638E8A2;
	Tue, 12 May 2026 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uTbKbL9k"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59E395AE4;
	Tue, 12 May 2026 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582917; cv=none; b=H+3zPXofqA+Nk9R7DwQPwT42P5QE+Q/fPKCNeC9LjMvr6koUs5MKdOb0ulL931nVOt5kYzwLPU3sBzawlEx27Fi6msWOgb+NN3YW3sSK64yCPs7igMSH+R4jlEOdwyfF94PxVT3uoLIs6a9LzPM36tu1W7Ohg7ySFqbn/SdOA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582917; c=relaxed/simple;
	bh=07fpaNueP6L3dRf3qAgX/iGIbF3PMuZyCj3Rbbal+1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e31jcyMaFeyNxkeKjq76pGN5Z0Reanfkq3bUK8FZqmD/C2foeWe+7rJtA1LiyyLRkM4TVNhnPNpUFmTCHRxRDVPSTS8rAUlhLM60SdBYCTS9rVJGSfo8rPelvPvJLf8SU6dEjlQmBVKpvJnG31nADPlOkVJVjYhZg3aMUAcIfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uTbKbL9k; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yVdjh0Hy07tpCUlFlB396VlkTSHh7UpPORhLbR9du7k=; b=uTbKbL9k9NG1WXWvLGNg5BBLFT
	8i87gsU1xTLMIaigkvL+lGGNUxGzyDEsCJoV68l2o8ZP+D+uM15MQ3RRNTr02qDBpgHW7By7JcEzr
	aLEYAkBjOTmNhdwNAm/VIbvZrH8ouO6xzB+NWqBEb7Nf67UcrZiqGW6VnVIl2WagLEsnLTfDJLP00
	7Sv4AlL8xLA4dKNGKgvpy8pjVoq8UrEHBFYCM1rNPlPAm7EVuuGSaodbg634Qqw2eQ0Zd/PcgH3g2
	ga3IK7qU4TjAXyBh909NNgHv8HPw66WHYpcd9KWhQxwKt7+cGY9Y5iZsGtf+jJIX8RUI2hxQNF3a6
	tHJ1Hqsg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkez-002K1N-28;
	Tue, 12 May 2026 10:48:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:34 -0700
Subject: [PATCH net-next v2 1/9] netpoll: expose UDP packet builder helpers
 for netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-1-1191d14ad66d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4355; i=leitao@debian.org;
 h=from:subject:message-id; bh=07fpaNueP6L3dRf3qAgX/iGIbF3PMuZyCj3Rbbal+1s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrcrsvPmME5oqQnZbk7whQQn3mi1pmT6sSJ
 fQegAs9HnSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bbMrD/9CRDhCXIutckTm7iTek7SDX2rcXDv2BL3998vvg78RsC5hv70ClL3ZcsiCLn0an4xcA5g
 9/EICpHLXLHbj86VxDt2dbujONHvY9b77ryFQW030hDln9QyPVJiAEuCw8+XptnTLWRVRvoCqkv
 lXxSk+SM+LvNG5A3fUA/H/4bkHYTkD1KFox+mvsKxHd9Uqq+ChWhCMXO0sNiXX9SSVUVW0uG9lX
 K2Vzy3NQYmfJk1t53vpPJkMR7FUXERuUdOYZ27Zg0tzzhBvinCy2a5mCXndm/oubZ4vWPue3jYk
 5LxG5GANTeDvGnYMpKX668mhZvTuGGDJb5XJX5QKpkjWq9TbWpQWIsDdY4/ql7+JTGJna+S+RyZ
 4lZ35ybckazvuxrpONvLV9XSq4T8Kyv/lEPCrjk76pap+/Vxa/f2jYkp6NdbKvs3vemjGQql/8i
 m1iaNfppu3EmLVQ0aDQpgubmI/nhxWdfeUvAbhbCd/wD4jz/YeWIjid21jgE6qz28lG4CMN8+6s
 MXy/n2OzpqTKDom/DAJP3wkG+Mn4X7foz4+WUM0Ht2Mufm5cejwUU/LHUXHh97B08track5O++u
 xVG2GwCSvD0Jq4o0InWTxyyrYxNBh+YibY+03o0N3raUYtDy9Dlkw3B7RYvXalhE9hLoQngk+yr
 rmCzXV3f1s5N16A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 3F14151ED60
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287082-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Promote each from file-static to EXPORT_SYMBOL_GPL and forward-
declare them in include/linux/netpoll.h so netconsole can call
them once netpoll_send_udp() moves out.

These exports are kept until the end of the series, when
al of them move into netconsole.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  6 ++++++
 net/core/netpoll.c      | 20 +++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f22eec4660405..e68c80b329411 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,6 +74,12 @@ void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
+struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
+void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
+void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len);
+void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len);
+void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
+void push_eth(struct netpoll *np, struct sk_buff *skb);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 84faace50ac28..41305056c56ff 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -268,7 +268,7 @@ static void zap_completion_queue(void)
 	put_cpu_var(softnet_data);
 }
 
-static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
 	struct sk_buff *skb;
@@ -294,6 +294,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	skb_reserve(skb, reserve);
 	return skb;
 }
+EXPORT_SYMBOL_GPL(find_skb);
 
 static int netpoll_owner_active(struct net_device *dev)
 {
@@ -369,8 +370,8 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	return ret;
 }
 
-static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
-				 int len)
+void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
+			  int len)
 {
 	struct udphdr *udph;
 	int udp_len;
@@ -393,6 +394,7 @@ static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 	if (udph->check == 0)
 		udph->check = CSUM_MANGLED_0;
 }
+EXPORT_SYMBOL_GPL(netpoll_udp_checksum);
 
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
@@ -411,7 +413,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
+void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct ipv6hdr *ip6h;
 
@@ -433,8 +435,9 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 
 	skb->protocol = htons(ETH_P_IPV6);
 }
+EXPORT_SYMBOL_GPL(push_ipv6);
 
-static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
+void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	static atomic_t ip_ident;
 	struct iphdr *iph;
@@ -460,8 +463,9 @@ static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
 	skb->protocol = htons(ETH_P_IP);
 }
+EXPORT_SYMBOL_GPL(push_ipv4);
 
-static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct udphdr *udph;
 	int udp_len;
@@ -478,8 +482,9 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 
 	netpoll_udp_checksum(np, skb, len);
 }
+EXPORT_SYMBOL_GPL(push_udp);
 
-static void push_eth(struct netpoll *np, struct sk_buff *skb)
+void push_eth(struct netpoll *np, struct sk_buff *skb)
 {
 	struct ethhdr *eth;
 
@@ -492,6 +497,7 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 	else
 		eth->h_proto = htons(ETH_P_IP);
 }
+EXPORT_SYMBOL_GPL(push_eth);
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {

-- 
2.53.0-Meta


