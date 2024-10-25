Return-Path: <netdev+bounces-139130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ABB9B0595
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A451F24991
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA720651B;
	Fri, 25 Oct 2024 14:20:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7720BB25;
	Fri, 25 Oct 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866050; cv=none; b=GA/IXy6szBRmkSnTQpkwiQ3sGYTXKrmTCO3DyVz0twxPDffinFuzk3fwb9MV+1X/SODYWqOelRsWaaqia2V0tSIh5S3cswkdfFMeRlL9R05FXAtV634pkUdAFhCXZFKbsvVNTwbsJ2e3TO7iONtaYBVB7t9ZoEEOXOHgvlAo74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866050; c=relaxed/simple;
	bh=kTXqbVT8/aFlhf2HvwbGxRoLYxDWqQGUVvq6m5IFA4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqjXc8vhkqPQ75M8eWpDdNa+QAq8EOL308rkJUgFg0bhgveVDe9HJoy3J4vfXY7qnQJXqM64tunX/6VCKQu0zsT+mr2ROJt4cHoHrzdsCXSbChhhYiXxQCWSP7l2C45Mzf/7e2cwNzNjTwQd4uK9cTu+ZrxzBf7iyfL24BUDBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99ea294480so144683566b.2;
        Fri, 25 Oct 2024 07:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866046; x=1730470846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck924se1om31UyjoafpndFOU4rDT4hZQ5rZ/Zwk6iDI=;
        b=J1QGtHeiDQ9NlCUVrRfgqIwQUggQ8Ebr9oq/uMhr6+PUK1KG9PlIfoDDqD6zTJNLPk
         5h/JztzOouOBc8QmbZ0y6reLrU9NYTfjbNLCZsJBGfUIx1wd0uvQjqn7xIJu7A+gZyKH
         G0cVzC/MWa3qlLOKcq5oAjpJ4QAEEFjPtDIzE/azg+px+TNwm0QZyqALDR69q4hc+JjL
         Ml46oKF5B+zRNCBBty9syac5J15P2OMQ+boLQ3BYJiiSLE4AQp205CWwvtnfgL8Nm227
         7AlDYDYi7zmQQJ1DE+1oPSPhrYBlTID0aYo5caO3v6ONW1i/odi/1tRiaaxoXLRNDeFS
         wJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6G+LmCv8LeDDM87463MM+hYcselNoASVE9v40vkle1U5gYZKAHruCokAD4HpAUPkVbT7ZOAGQdmJesbY=@vger.kernel.org, AJvYcCVv7SMrn/UfNGp2s0dXDm05DnC5RMZllWpCNAMqJp+ZuzRJqEVZsXFf/zoEtAIYelU5CwJL0biI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaskdr9qpVkCbwdNReICu56/MBnYWvCa4YsLee0HN+YkzRsmcD
	Pd0eb+4v9fYQkjouXenkbD/BFrTLgPOYIKdNxMnmTtgOtuV1pM/B
X-Google-Smtp-Source: AGHT+IETnJCpvGq9y8Sy6S/Rh8w9SGTLCR33+tk+O1VMx6SYqVv0L4zb0FRLNEe2F/IZtlBQ2LpzrQ==
X-Received: by 2002:a05:6402:1956:b0:5c8:8290:47bf with SMTP id 4fb4d7f45d1cf-5cb8b1ea74amr10463758a12.21.1729866046014;
        Fri, 25 Oct 2024 07:20:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6349675sm665994a12.94.2024.10.25.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:20:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	jiri@resnulli.us,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	aehkn@xenhub.one,
	Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH net-next 2/3] net: netpoll: Individualize the skb pool
Date: Fri, 25 Oct 2024 07:20:19 -0700
Message-ID: <20241025142025.3558051-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025142025.3558051-1-leitao@debian.org>
References: <20241025142025.3558051-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the netpoll system uses a global skb pool,
which can lead to inefficient memory usage and waste when targets are
disabled or no longer in use.

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
 net/core/netpoll.c      | 29 +++++++++++------------------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index cd4e28db0cbd..77635b885c18 100644
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
index e83fd8bdce36..c9a9e37e2d74 100644
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
@@ -778,7 +778,7 @@ int netpoll_setup(struct netpoll *np)
 	rtnl_unlock();
 
 	/* fill up the skb queue */
-	refill_skbs();
+	refill_skbs(np);
 	return 0;
 
 put:
@@ -792,13 +792,6 @@ int netpoll_setup(struct netpoll *np)
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


