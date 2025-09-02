Return-Path: <netdev+bounces-219201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6AAB4072B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E420374C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84234324B32;
	Tue,  2 Sep 2025 14:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F152322C99;
	Tue,  2 Sep 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823811; cv=none; b=SDkDALkHSUKa8vCyIBX0Acvv3PsVNtcfgX+SLz9GiXHl6yfEEDX/GwUzHrg3NPOsdFP3N+3DgnGiZkKOmP4xgIjRhFkyzgfjJo/CLDIisHJNIpsNfTMFrovqt/FYqRnqQvQQLYO6m0ZJdF4p1XrZ336JjnQFxt74GuDyqx0NUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823811; c=relaxed/simple;
	bh=QH91dZqx9n+fa6UJWQhKmr6KoM9wkO/zEYWaL3iLxbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhXjarzV1kJscq6szAsYiJcLN/3L/Fhy5McpQCM/agDj2Xk8IA0UPR07LvoIxanwUTlf7PQufk8Ve22iOEXi8vs/CBmAIxh8JMDVM+OyypgD0gjwJodWbOtyswfXRSsXGE9vLeTKa/96FNJA+/1Bt7zNeQLO368k55gYA6kg3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b043da5a55fso242486766b.0;
        Tue, 02 Sep 2025 07:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823806; x=1757428606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSUfMX9h9/cWRq/fgGMN/opuKAJc5EH3ViaOxfsE3gs=;
        b=uVXYQEn6TqvnQuH/sOGPnme+6NGnSJb0qUnW4TgXb0SR/c+Y/kQCTOLdLZff4zA0q4
         4K+/dWbRQKrCpi82JsyvZZTOJbU6aRDoYRYtwTGXoE/7WSBsCIKZNprl70eNNJ2zbIQm
         DIIMxwIwNKApo+06Qus/MyKoTSqmmz47gJarVR641ZK4qonsoKTSpXd/WxtodiIMGrkJ
         QrVpSc0mvUfI1VydPC6qHf3GzBCxGrA9Ti67n7RnllZhliUbNnS5t+/1r1Yz8mH8ZrCx
         O9T5ZKHTpc8Njf62NvNd04iDd/UxWeCV0Rw1QZ3Otgghdu/H8hv+qB/P4sl03qxJAMG0
         On6g==
X-Forwarded-Encrypted: i=1; AJvYcCVMHiu+TaAmUyNgrzUXvglz00OMmZa/mglx+BE88GHSJt7Cggmev2MrVZTVCymX57J8PrFNAhMVWlqwwN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37zmq+Me+5pJLQl1fxGKxvBj8xwaKXpWIg+zMzXbM5Adr8mV6
	7PMHW7wHWGEYx5x+anT1aYYCexQZz1MPzY6PgDqTmYziFoLJo8q7KiAMRYG/Sg==
X-Gm-Gg: ASbGncsrpQ67Ak8bo77I/3mkXuOHdPMnm6YznhCy+WAICf/gl1P8ID1/pIAw6LEBGGG
	mJwumUt8sMYncEHFCl6mUZxKqdPkURM0XVohLT7Q6kozKYGUtma3MnAD0Gyh43Zhsj+PYApt7MS
	J+m6FDqit2f2UT8/1cFkdLXq7MIwopQGOYuN33q9VeWmj3hrVL6XmwqQBmkhA8b+b89O9XCm40C
	abkhV05RQ/RfidJrZu1jZHpge2LFr11u/1/VYv+i4El0B6TQzZ7HBnkrn3bwEI7uO3rCiq2a1j0
	BQkN/zEKB8nJnqK8k7aIK5ltHwP+OWEm5E9LUVqvCEKxl7DC1NhtKYuYbRhMxSdN+mF1yTmBZvn
	q1UJc6sn/IsbKCTLDF7KC0do=
X-Google-Smtp-Source: AGHT+IHfacPAJ0eqlJ4ikR5eNCtobwVkC6Qxg+UKHjXDyjYPFMM+X27TbG9HQkfnuOzbL9fqKbVNmQ==
X-Received: by 2002:a17:907:2da7:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b01d97744a5mr1142142366b.51.1756823806238;
        Tue, 02 Sep 2025 07:36:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0444252c2dsm295439166b.81.2025.09.02.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:24 -0700
Subject: [PATCH 2/7] netpoll: move prepare skb functions to netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-2-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=11674; i=leitao@debian.org;
 h=from:subject:message-id; bh=QH91dZqx9n+fa6UJWQhKmr6KoM9wkO/zEYWaL3iLxbw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5UNbLZUNgiNKJYGRkTDovTVZyqOaKlSyK6
 TYgooOeZG+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bSg4D/9JoRLSmgTNXM77atgyT/Q6ZeVcXmI56CiK9qdz5y3XbAYDusi5xwbc+ZWmjhUpquk0IXL
 XTJxIshkfa/qgv6MNO4R0JqQT5Us1VudXtJacbAnI9LDgsKk+zwlIrx0VdAgGgTSO5a/QyRs5pd
 NyoINFQwDu760evpMlWAB3Q0xMKT46h9bdh7SonuiJ5WvTLiwlNA8paRYjekubZCYjqzkeGZvDq
 ppJDm0OLCoYDUV9mDFjojd3Q63jWNwp8D+cR+5ZrqQ5VkcZ5UIQDkm1G1LFiSILlNIwfIJcn6jM
 15Lsti3eaTZThyiiLotFxtw2chqlw3mt3HRLXp+5pxUm4NtkD/0a2kD1YcaqWkMpeOMfZDvzzT7
 7Ep3aMTivqViwlTxuiVy3YhKWPCYLtVQPUEgRR06/RooT9o17pC6sStucB0gFopF5fmPe0sHwFJ
 W2z6yyXx39MiprNtlJK8oQl+6cVYiSjH0LhPm1LBiBwiTITwuMlI2owgz75JTpTwbsMk5KVFQb4
 McQx0uYrUhwqC7fPCXMxlN0gpAAShfygaxit4zYtIWVCjvpl78wuLZscDjraWINVoHmKYFj4X29
 EcJYIrAmUPwhkMvAxXNNBXDVckswpi3hP1ee5SOplkldDBChICDN0KEJYMKc/sWYDqagcTs3xYZ
 Tf2uaRd/ktyWCoQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move the UDP packet preparation logic from netpoll core to netconsole
driver, consolidating network console-specific functionality.

Changes include:
- Move netpoll_prepare_skb() from net/core/netpoll.c to netconsole.c
- Move all UDP/IP header construction helpers (push_udp, push_ipv4,
  push_ipv6, push_eth, netpoll_udp_checksum) to netconsole.c
- Add necessary network header includes to netconsole.c
- Export find_skb() from netpoll core to allow netconsole access
  * This is temporary, given that skb pool management is a netconsole
    thing. This will be removed in the upcoming change in this patchset.

With this in mind, netconsole become another usual netpoll user, by
calling it with SKBs instead of msgs and len.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 147 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netpoll.h  |   3 +-
 net/core/netpoll.c       | 151 +----------------------------------------------
 3 files changed, 150 insertions(+), 151 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5b8af2de719a2..30731711571be 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -40,6 +40,10 @@
 #include <linux/utsname.h>
 #include <linux/rtnetlink.h>
 
+#include <net/ip6_checksum.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+
 MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
@@ -1480,6 +1484,149 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
+				 int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+	udph = udp_hdr(skb);
+
+	/* check needs to be set, since it will be consumed in csum_partial */
+	udph->check = 0;
+	if (np->ipv6)
+		udph->check = csum_ipv6_magic(&np->local_ip.in6,
+					      &np->remote_ip.in6,
+					      udp_len, IPPROTO_UDP,
+					      csum_partial(udph, udp_len, 0));
+	else
+		udph->check = csum_tcpudp_magic(np->local_ip.ip,
+						np->remote_ip.ip,
+						udp_len, IPPROTO_UDP,
+						csum_partial(udph, udp_len, 0));
+	if (udph->check == 0)
+		udph->check = CSUM_MANGLED_0;
+}
+
+static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	struct ipv6hdr *ip6h;
+
+	skb_push(skb, sizeof(struct ipv6hdr));
+	skb_reset_network_header(skb);
+	ip6h = ipv6_hdr(skb);
+
+	/* ip6h->version = 6; ip6h->priority = 0; */
+	*(unsigned char *)ip6h = 0x60;
+	ip6h->flow_lbl[0] = 0;
+	ip6h->flow_lbl[1] = 0;
+	ip6h->flow_lbl[2] = 0;
+
+	ip6h->payload_len = htons(sizeof(struct udphdr) + len);
+	ip6h->nexthdr = IPPROTO_UDP;
+	ip6h->hop_limit = 32;
+	ip6h->saddr = np->local_ip.in6;
+	ip6h->daddr = np->remote_ip.in6;
+
+	skb->protocol = htons(ETH_P_IPV6);
+}
+
+static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	static atomic_t ip_ident;
+	struct iphdr *iph;
+	int ip_len;
+
+	ip_len = len + sizeof(struct udphdr) + sizeof(struct iphdr);
+
+	skb_push(skb, sizeof(struct iphdr));
+	skb_reset_network_header(skb);
+	iph = ip_hdr(skb);
+
+	/* iph->version = 4; iph->ihl = 5; */
+	*(unsigned char *)iph = 0x45;
+	iph->tos = 0;
+	put_unaligned(htons(ip_len), &iph->tot_len);
+	iph->id = htons(atomic_inc_return(&ip_ident));
+	iph->frag_off = 0;
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->check = 0;
+	put_unaligned(np->local_ip.ip, &iph->saddr);
+	put_unaligned(np->remote_ip.ip, &iph->daddr);
+	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
+	skb->protocol = htons(ETH_P_IP);
+}
+
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
+static struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
+					   int len)
+{
+	int total_len, ip_len, udp_len;
+	struct sk_buff *skb;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		WARN_ON_ONCE(!irqs_disabled());
+
+	udp_len = len + sizeof(struct udphdr);
+	if (np->ipv6)
+		ip_len = udp_len + sizeof(struct ipv6hdr);
+	else
+		ip_len = udp_len + sizeof(struct iphdr);
+
+	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
+
+	skb = find_skb(np, total_len + np->dev->needed_tailroom,
+		       total_len - len);
+	if (!skb)
+		return NULL;
+
+	skb_copy_to_linear_data(skb, msg, len);
+	skb_put(skb, len);
+
+	push_udp(np, skb, len);
+	if (np->ipv6)
+		push_ipv6(np, skb, len);
+	else
+		push_ipv4(np, skb, len);
+	push_eth(np, skb);
+	skb->dev = np->dev;
+
+	return skb;
+}
+
 /**
  * send_udp - Wrapper for netpoll_send_udp that counts errors
  * @nt: target to send message to
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index ed74889e126c7..481ec474fa6b9 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,14 +69,13 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
-struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
-				    int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
+struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e2098c19987f4..b4634e91568e8 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -29,11 +29,8 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/if_vlan.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <net/addrconf.h>
 #include <net/ndisc.h>
-#include <net/ip6_checksum.h>
 #include <linux/unaligned.h>
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
@@ -271,7 +268,7 @@ static void zap_completion_queue(void)
 	put_cpu_var(softnet_data);
 }
 
-static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
 	struct sk_buff *skb;
@@ -297,6 +294,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	skb_reserve(skb, reserve);
 	return skb;
 }
+EXPORT_SYMBOL_GPL(find_skb);
 
 static int netpoll_owner_active(struct net_device *dev)
 {
@@ -372,31 +370,6 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	return ret;
 }
 
-static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
-				 int len)
-{
-	struct udphdr *udph;
-	int udp_len;
-
-	udp_len = len + sizeof(struct udphdr);
-	udph = udp_hdr(skb);
-
-	/* check needs to be set, since it will be consumed in csum_partial */
-	udph->check = 0;
-	if (np->ipv6)
-		udph->check = csum_ipv6_magic(&np->local_ip.in6,
-					      &np->remote_ip.in6,
-					      udp_len, IPPROTO_UDP,
-					      csum_partial(udph, udp_len, 0));
-	else
-		udph->check = csum_tcpudp_magic(np->local_ip.ip,
-						np->remote_ip.ip,
-						udp_len, IPPROTO_UDP,
-						csum_partial(udph, udp_len, 0));
-	if (udph->check == 0)
-		udph->check = CSUM_MANGLED_0;
-}
-
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	unsigned long flags;
@@ -414,126 +387,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
-{
-	struct ipv6hdr *ip6h;
-
-	skb_push(skb, sizeof(struct ipv6hdr));
-	skb_reset_network_header(skb);
-	ip6h = ipv6_hdr(skb);
-
-	/* ip6h->version = 6; ip6h->priority = 0; */
-	*(unsigned char *)ip6h = 0x60;
-	ip6h->flow_lbl[0] = 0;
-	ip6h->flow_lbl[1] = 0;
-	ip6h->flow_lbl[2] = 0;
-
-	ip6h->payload_len = htons(sizeof(struct udphdr) + len);
-	ip6h->nexthdr = IPPROTO_UDP;
-	ip6h->hop_limit = 32;
-	ip6h->saddr = np->local_ip.in6;
-	ip6h->daddr = np->remote_ip.in6;
-
-	skb->protocol = htons(ETH_P_IPV6);
-}
-
-static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
-{
-	static atomic_t ip_ident;
-	struct iphdr *iph;
-	int ip_len;
-
-	ip_len = len + sizeof(struct udphdr) + sizeof(struct iphdr);
-
-	skb_push(skb, sizeof(struct iphdr));
-	skb_reset_network_header(skb);
-	iph = ip_hdr(skb);
-
-	/* iph->version = 4; iph->ihl = 5; */
-	*(unsigned char *)iph = 0x45;
-	iph->tos = 0;
-	put_unaligned(htons(ip_len), &iph->tot_len);
-	iph->id = htons(atomic_inc_return(&ip_ident));
-	iph->frag_off = 0;
-	iph->ttl = 64;
-	iph->protocol = IPPROTO_UDP;
-	iph->check = 0;
-	put_unaligned(np->local_ip.ip, &iph->saddr);
-	put_unaligned(np->remote_ip.ip, &iph->daddr);
-	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
-	skb->protocol = htons(ETH_P_IP);
-}
-
-static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
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
-
-static void push_eth(struct netpoll *np, struct sk_buff *skb)
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
-
-struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
-				    int len)
-{
-	int total_len, ip_len, udp_len;
-	struct sk_buff *skb;
-
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		WARN_ON_ONCE(!irqs_disabled());
-
-	udp_len = len + sizeof(struct udphdr);
-	if (np->ipv6)
-		ip_len = udp_len + sizeof(struct ipv6hdr);
-	else
-		ip_len = udp_len + sizeof(struct iphdr);
-
-	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
-
-	skb = find_skb(np, total_len + np->dev->needed_tailroom,
-		       total_len - len);
-	if (!skb)
-		return NULL;
-
-	skb_copy_to_linear_data(skb, msg, len);
-	skb_put(skb, len);
-
-	push_udp(np, skb, len);
-	if (np->ipv6)
-		push_ipv6(np, skb, len);
-	else
-		push_ipv4(np, skb, len);
-	push_eth(np, skb);
-	skb->dev = np->dev;
-
-	return skb;
-}
-EXPORT_SYMBOL(netpoll_prepare_skb);
-
-
 static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;

-- 
2.47.3


