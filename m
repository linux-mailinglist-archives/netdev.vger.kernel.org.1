Return-Path: <netdev+bounces-142887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D59C0A8A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FCB1F21155
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2A215C77;
	Thu,  7 Nov 2024 15:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C1215C6A;
	Thu,  7 Nov 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995042; cv=none; b=clz+2q8wyLWkR0K8pRYjkdpWs85XL6ffjvmGKU8I8MjeMz88ufTY0UAjjO8rhUX31JlehXp/PDEW/O0FywHTRZALXLqG/AQmSuYBlEexpfNROmmcuzoILfGEKbHlt1F2Z/FEzwIJn37+nakc/8QihahEAO0pv1WNvE2MBgUeHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995042; c=relaxed/simple;
	bh=l/0wZIy7SkdSRdFTGTTWstgdulRmA7dbmH3XYkTeIRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/vAitWMM/pxG0pjxlLvYh3wsbBQUO/Cf63rxW2uY6/qbZYjfBElsAnqo7T0LiZTJeXF1RUyqYxyfHXxEU43WewbhddkotewzkcbbA1cjQkwsui+iRZrlFGhkFFggp6Bfox9VFWPZiUZK3BCwmF7mzZI6Vuoi2nVd39gyN1GdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so177496366b.1;
        Thu, 07 Nov 2024 07:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995036; x=1731599836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzst0PFb8vN+5CtSNyjHKngR6IOzkyemapq2li6Vfbs=;
        b=wxDuwfgAQTd8m4CUQgTYAJXPYo5naLWCdcEscIVkLyFNnnbIcmhnwUL1dek9kQWkuh
         31nPFrfTDMwH3SIbUovpfQxSH0IRsaKAI22yxz4zKbLQP4ceoliA/gcKnX0ARlD49Qv/
         pfImuv2yzjvdDRZUm/y+x5AuPmFz7/QkIQ0cfCEpVIeZuhDfv3TE30F6bc5hON6IcCah
         qufJjruETK0LZOYBpezsn01QNNna3aob0uH4hXgvtjID8/UJzZDAMAXsTgoMhuy3bHnz
         f3G1q58dYhk871vNwaiBJjoenHg4HtU/zPaWa/7hOH6jJ1JzaLiMvvKaogGwAZ9BHYFp
         XgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZb4oh8/D8uDvNPDbxjAEtgUoO/bfXzwcvUct55XJgP0zCT2cDd6khuhmW2u4u2UXq6Z8RxmlZCv8mUyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyU5d8evPyaI2NKhJK+/FQw4Zj/hhZpidWhCGO9oAdqorgNOb
	tkMWBzpGTyTfaplhK0oHqiWmgQGnC4OY8HGhvYgCTFiZ2ouxJg9m08A/Yg==
X-Google-Smtp-Source: AGHT+IEzDwoi95xhMMuHZgubLehCalpiaR8rUAzXf/DRrhLMuddonNKFMl/C25ZnFX2V4O7hQG+2+Q==
X-Received: by 2002:a17:907:2687:b0:a9a:2afc:e4ed with SMTP id a640c23a62f3a-a9eeaefc7c7mr41016266b.32.1730995036463;
        Thu, 07 Nov 2024 07:57:16 -0800 (PST)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defb61sm108826666b.150.2024.11.07.07.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:57:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 Nov 2024 07:57:06 -0800
Subject: [PATCH net-next v2 1/2] net: netpoll: Individualize the skb pool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-skb_buffers_v2-v2-1-288c6264ba4f@debian.org>
References: <20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org>
In-Reply-To: <20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=leitao@debian.org;
 h=from:subject:message-id; bh=l/0wZIy7SkdSRdFTGTTWstgdulRmA7dbmH3XYkTeIRU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLONZVOc3C8bsORLiLKniO8jahyMHqRR4634kF
 KH5CID95xaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyzjWQAKCRA1o5Of/Hh3
 bRvND/9JDVObUiBBbAkmjSkcfz+vTq0fof9B/MUryFzYByklPMc8Svu2T4jmc2IwSraWH5wKlWQ
 xAgpn4j6+CtLwj5FSRiGtJ1yIh/70cR3kyify7e1m+Hx9xFU8ZtiJq3tshxm5p4sX5KJ+dbmeQm
 bkZ9It7XgBiuzLRaijlMtYi/oVExw8USNDbqZDfa+L1ibXKoo5ufA3ef6HyYo2tttQ2YjWK1K7P
 mGEBmbWG8uuKxv9wajBdgTl0YiSLAFQflT+GSq7Ta3V20bE7bjXUePO48Bc4pQOqpRD1FsEpe9G
 kJF8Y7JDg83SlHu2f0OlKLnVXsa542AOt6j7/yqHNKkYQ4aLTFLvEZCVvBzCQnNEz5dT/wa5MDO
 ZkBjqFx7fVufOvQl7PYTiPpAAwuDOtcC8eV/3j+KTgSfxakhamwyaIZU4Rhc/oGaGRoh7gRMcVH
 rGVOiFfKTAvlL0sq6QgMNQBCzyK4a7VZiYBBpRbtZRq1qyR5oWm0QhcKRoVB7UNjg2kyIBSwzMj
 hrMfEZUm1q4OG6IOKQhocqRiUmDOwEZ+UkS3HtlAXp0jsvqj5kkEbHnnaItyq8ENuZH60Hf1k/X
 XDyiSayAwzj7QvoiGH0f1yY0X+jqbyLTi6ZvZPsqSxWjPoM8Emofn19zAWzl8VUk6nVBkjy22QJ
 QWXbu3ixtS6Ijug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The current implementation of the netpoll system uses a global skb
pool, which can lead to inefficient memory usage and
waste when targets are disabled or no longer in use.

This can result in a significant amount of memory being unnecessarily
allocated and retained, potentially causing performance issues and
limiting the availability of resources for other system components.

Modify the netpoll system to assign a skb pool to each target instead of
using a global one.

This approach allows for more fine-grained control over memory
allocation and deallocation, ensuring that resources are only allocated
and retained as needed.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 31 +++++++++++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index cd4e28db0cbd77572a579aff2067b5864d1a904a..77635b885c18b7d405642c2e7f39f5ff2c7d469d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -32,6 +32,7 @@ struct netpoll {
 	bool ipv6;
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
+	struct sk_buff_head skb_pool;
 };
 
 struct netpoll_info {
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 94b7f07a952fff3358cc609fb29de33ae8ae8626..719c9aae845fbeb6f5b53a2bef675d3cb8cd44a7 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -45,9 +45,6 @@
 
 #define MAX_UDP_CHUNK 1460
 #define MAX_SKBS 32
-
-static struct sk_buff_head skb_pool;
-
 #define USEC_PER_POLL	50
 
 #define MAX_SKB_SIZE							\
@@ -234,20 +231,23 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-static void refill_skbs(void)
+static void refill_skbs(struct netpoll *np)
 {
+	struct sk_buff_head *skb_pool;
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	spin_lock_irqsave(&skb_pool.lock, flags);
-	while (skb_pool.qlen < MAX_SKBS) {
+	skb_pool = &np->skb_pool;
+
+	spin_lock_irqsave(&skb_pool->lock, flags);
+	while (skb_pool->qlen < MAX_SKBS) {
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
 			break;
 
-		__skb_queue_tail(&skb_pool, skb);
+		__skb_queue_tail(skb_pool, skb);
 	}
-	spin_unlock_irqrestore(&skb_pool.lock, flags);
+	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 
 static void zap_completion_queue(void)
@@ -284,12 +284,12 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	struct sk_buff *skb;
 
 	zap_completion_queue();
-	refill_skbs();
+	refill_skbs(np);
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb)
-		skb = skb_dequeue(&skb_pool);
+		skb = skb_dequeue(&np->skb_pool);
 
 	if (!skb) {
 		if (++count < 10) {
@@ -673,6 +673,8 @@ int netpoll_setup(struct netpoll *np)
 	struct in_device *in_dev;
 	int err;
 
+	skb_queue_head_init(&np->skb_pool);
+
 	rtnl_lock();
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
@@ -773,7 +775,7 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	/* fill up the skb queue */
-	refill_skbs();
+	refill_skbs(np);
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
@@ -792,13 +794,6 @@ int netpoll_setup(struct netpoll *np)
 }
 EXPORT_SYMBOL(netpoll_setup);
 
-static int __init netpoll_init(void)
-{
-	skb_queue_head_init(&skb_pool);
-	return 0;
-}
-core_initcall(netpoll_init);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.43.5


