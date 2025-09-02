Return-Path: <netdev+bounces-219200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6192B4071F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A72F3A1B87
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBC322C92;
	Tue,  2 Sep 2025 14:36:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69573126CF;
	Tue,  2 Sep 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823808; cv=none; b=IYwkIbZqF9ZbtPsiHlPkRqZsQf+TWlo6w0mzDtpGrxCosgnOsWDnLYZGeL4hP/+HTy1HBnIw5UMAkSAL/W2DxQ9IviClRuySjrLxWSAcnBeYH31mKOSzYuUSYwQZ4YY5IMHzEe1GOjxuCgHazu43DYZtlEcnqEtOW2HdagLIr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823808; c=relaxed/simple;
	bh=uv+sRDVE9UdYp/rrXBaRI2PRNEO+AlIgCJajD1luaOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxNAvNXSJ1Wow+7zJs9f9PAvqrO11B3CRAYl+Ho6p6MhbbnQ2ui81lPX3Aq/R6B9It0O1e43eY+9k+UQZZuCmqxBhfAab9aBe9Aj/kv+ZbZqVbBX7pBhdq8+7Y8JGza6kcfs+gTzXG7PXp1zNoZzPFMoK9ENkPQ9VkJxX4qIaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso6339786a12.2;
        Tue, 02 Sep 2025 07:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823805; x=1757428605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ixDvZ/+7M4TDPK7mHzqbLvaRWPSa4oHJo2q4oJdkek=;
        b=pduvmmtfyhjaHmpzgf/HaBuo6iSVIGemGAVvPd3Gj27igMfkxXDRSjFvG7bQjod2nX
         ErYlFQUxKIJGc4GrgFNRvMZOfKjSPnFoHBcZyTjrGEpCGdBVsxffhgR9ZdbYbuGmV/u7
         1LbJjGxg418QPgH7HEXiH9/bU3QatcAfVznuzfvUTkTbD2mvbwjZUyn8NHObIbcaOazk
         pHqYWvTSorzwVv6103H/QqVy2pqQUfhTjWuRlr0DI8xm0xvWCPow96mogEIb5FjPACmW
         wfJoJUTX6qZOqUMvKOpUqIDoXM+kQ7Qq8Z9ydszK0wGX0TMqRf+CTNS2brdOEda8YtQ8
         7cug==
X-Forwarded-Encrypted: i=1; AJvYcCXYajrw2Wdx03kILRHo2NCMq/lNPUwOR3RWihSz60LgZbN93wP/d+KdzzWzszlMZjpGSsvTgW6kK8CTMVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9ysoeq1NX1yTiHytAp7R2oinBFARmGRMActdub24KduniyOo
	yqtAraXkI6QvodpD4qOIm/adXcgJtAhMs3HyyeMwISdNn+Tng1feLz8H
X-Gm-Gg: ASbGncuAEV0L2IpFAqNIQbY6sYoVLtlW11agGN7f7B2PFYF+afwsw6WQI/4Yy6xtvL7
	fs116uVnRE1jIXs73BBGF2PNlaNSBH/leRPuKfnG7LJNiC9uO5s0o/gqY9GC640dPt7M50BWyzO
	MtfzGodwpfi0rK2iggQWNrA67TJtRgAkjYygxQ3TpZabPpteAkFe3p7jDYJI0b3nfUPyuQikDIm
	uP/IkhzjlJqdFmmA7zCcBSjHUxic2+rTpH8e4joMADNQxi4POLhOa0JI5uG8/BnRzMu/WI1h0B2
	mlnO8hD5fx3P9FgXsB+CHA0vYfRDq1mIHM6vEq2M5JuxguUa48L6w/Ahgcyn7hhazkm/0pbkqD5
	jWNyknwcAHp4P
X-Google-Smtp-Source: AGHT+IEJ8WIFf9X4wGSznvxjCKq9+or8baY6JK/xSM4+M8dwgeLla+mziXvq/7bTmdPlq+UE2gO+Pg==
X-Received: by 2002:a17:907:3f9a:b0:b04:590a:a5b5 with SMTP id a640c23a62f3a-b04590ace5fmr169723166b.24.1756823804683;
        Tue, 02 Sep 2025 07:36:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0432937d7esm447457966b.17.2025.09.02.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:23 -0700
Subject: [PATCH 1/7] netconsole: Split UDP message building and sending
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-1-51a03d6411be@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3991; i=leitao@debian.org;
 h=from:subject:message-id; bh=uv+sRDVE9UdYp/rrXBaRI2PRNEO+AlIgCJajD1luaOc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5rHYtgODXvDjBr+4mxuJmvXSRnDOQlekjb
 8uY3bQrCaSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bQZoEACHZ96Nadl46FRJbWI/4E1Gzzlm+kqKGlfPX+MXLMSXtiA6t/LNDeliZvwvYJiYzN8+7r8
 Awb69iYfvz9djH/hl3znBuNkTrOmRsESsRyS/PXm5zImdPeRKl2p1tyS1sZQ1YMqrTZEYdMAZQR
 kctI5ZkHKBMPlcG04WXstHdTivxfFwHd2tKSxzZURVM37KCL2xbkyWAhQAKwozTjUqLurnZ5t3i
 IlxxhHdfTHJRd2uLPeg+Rw+WiJX0YWDIzb93Vw7JW5rPO62VpeBwLZBsrnc624n0CGt3jBMIGo7
 auEEY6aUqYigyZRb4kFheTVV/5FPxRkBPVUn9+zZ0zku1Ot/LvYW0EvYz9aKTVuXL5fMW98B4A8
 cjMZCBkjXKtZzdUp6JncE/QBh7A3ZT4tGPgqrlCid7oxxkR9aunXzg9JWwREbCR7q9KDtI9Neqv
 Rd6sYGZ8ulftOsHlBt7w7yjmn80r2H/ZEqVdq1+wM34HfGCOnVegXeb27o1syUR4kiRhAAPHRzR
 rLmlSbXSzLNYBBMMmctb8hyS9l/pVQtEHR/ljDRUcvDqHqT6RB4P3YsSQ5Ju4cBF6BvP+VBQ9uC
 1Cr5a4sDBf2dtiMFUOEFHhclZycDQSQzdPAHCJmFj911hdVSNMlUaeXsTRQhD27uVkLuaPCAvhR
 iOXVNTHBxNMOGCw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Split the netpoll_send_udp() function into two separate operations:
netpoll_prepare_skb() for message preparation and netpoll_send_skb()
for transmission.

This improves separation of concerns. SKB building logic is now isolated
from the actual network transmission, improving code modularity and
testability.

Why?

The separation of SKB preparation and transmission operations enables
more granular locking strategies. The netconsole buffer requires lock
protection during packet construction, but the transmission phase can
proceed without holding the same lock.

Also, this makes netpoll only reponsible for handling SKB.

netpoll_prepare_skb() is now exported, but, in the upcoming change, it
will be moved to netconsole, and become static.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 21 ++++++++++++++-------
 include/linux/netpoll.h  |  2 ++
 net/core/netpoll.c       |  9 +++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493b..5b8af2de719a2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1492,18 +1492,25 @@ static struct notifier_block netconsole_netdev_notifier = {
  */
 static void send_udp(struct netconsole_target *nt, const char *msg, int len)
 {
-	int result = netpoll_send_udp(&nt->np, msg, len);
+	struct sk_buff *skb;
+	netdev_tx_t result;
 
-	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
-		if (result == NET_XMIT_DROP) {
-			u64_stats_update_begin(&nt->stats.syncp);
-			u64_stats_inc(&nt->stats.xmit_drop_count);
-			u64_stats_update_end(&nt->stats.syncp);
-		} else if (result == -ENOMEM) {
+	skb = netpoll_prepare_skb(&nt->np, msg, len);
+	if (!skb) {
+		if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
 			u64_stats_update_begin(&nt->stats.syncp);
 			u64_stats_inc(&nt->stats.enomem_count);
 			u64_stats_update_end(&nt->stats.syncp);
 		}
+		return;
+	}
+
+	result = netpoll_send_skb(&nt->np, skb);
+
+	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC) && result == NET_XMIT_DROP) {
+		u64_stats_update_begin(&nt->stats.syncp);
+		u64_stats_inc(&nt->stats.xmit_drop_count);
+		u64_stats_update_end(&nt->stats.syncp);
 	}
 }
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b5ea9882eda8b..ed74889e126c7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,6 +69,8 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
+				    int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..e2098c19987f4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -496,7 +496,8 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 		eth->h_proto = htons(ETH_P_IP);
 }
 
-int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
+				    int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
@@ -515,7 +516,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb = find_skb(np, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
-		return -ENOMEM;
+		return NULL;
 
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
@@ -528,9 +529,9 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	push_eth(np, skb);
 	skb->dev = np->dev;
 
-	return (int)netpoll_send_skb(np, skb);
+	return skb;
 }
-EXPORT_SYMBOL(netpoll_send_udp);
+EXPORT_SYMBOL(netpoll_prepare_skb);
 
 
 static void skb_pool_flush(struct netpoll *np)

-- 
2.47.3


