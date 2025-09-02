Return-Path: <netdev+bounces-219204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7EB4072A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E1F3AE6F9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E22338F29;
	Tue,  2 Sep 2025 14:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11F334389;
	Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823816; cv=none; b=dnwetPoPqnwyO7QlNwS/XGm+xGl7fuv6PHN1AjgVUQA3YR9T47SrvbzNOXRpqKxQEBBZdOU59AzZvbhKOu2a+wxDpcc0OIqSEJ95axtkZYpnRtq9VH/KWo7YSa75HialA7PwbFzGMKcBeVVRu9G/f0P3PLRG5PqBrUWjO3AyzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823816; c=relaxed/simple;
	bh=hEoM6CFJdWE31w8xFW6aTHY60k+r+bWwOR/kv/6lIlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/4nFhjlEKfCT/XyS9z03zGCfl8QtkkuNSKvG35CIHovZRvzOCSQ0JLn+LPyO5lkclWZ5TX/Bo2ybDB+ncOmUrQCdMbbZMr1ge82eeJ5/1+2nap/8lQuptfHzO2s7EBWs4QGPxbxTu3PBeeuonL+z26IRfAKTsrDqKnFiGx2ymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b04271cfc3eso283731366b.3;
        Tue, 02 Sep 2025 07:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823812; x=1757428612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRNRDuYiIKp0gOeHmM6Ebihd3noRhR1pzhy50CtibRc=;
        b=YB5zbCo5FMmzELhtgVT8d80a93IyW8iUgL3ipxNJrM4fChLZy3/e05bI6t/OFi77Hr
         sGgaxYD0Yey165E/TjDv4CYJbYfgQTs5VqDZen/VzCC4QhfAAGuWD5pgX+gZLiWCTJ2S
         jHrbE9oBz4z/BdZkX8HzjfGb+sP5s+C5cAzPkoHCPVX1cQ1WKYm1CimHoKDdw5la9Oio
         o3oiZYZazMdXg1bp4Qlxw6UhgNSzWi4hEZkWlqUmWJh0vt2ncKjkOq9E2Yno/tK+tGEM
         q6DZBf5BEPQR6WEdVpAzFcYqLZkhllWiBYVjUg//q51mp4+sBAS6pwzVU+LeBEJzz/4l
         l97Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe8BilBCtcUSViw4WTTqNaTcv7DzvHCtOPugv/0RX1st1Jv8qwToSwYxHNK3/6pkYYJLo4dRjlxzILytU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXeodP/uRHuhCLp+1Fft0Oo5OpOxRNfIhdvlhenjk90EDKLNEU
	zpSwo5fVnyA82TP8u1N/dJy/6tt+FCQ3zVMHd7i4X5AIrm3HuvDTfxxrDp1FBw==
X-Gm-Gg: ASbGncsVXCjYBWxBEQc9qdWHKUJiXotOyQy7AmK5JEtPYe4hI5+hpTi9f42SKhd6Q3F
	TmRfzt2k9+yC85dx2nrddR4Dl7/ilSrSjyvPjn+T3+JwyAChLlSl62lBvcSIZBY7eg41be7bkXl
	jgcqc8DrnlxPxDWc3Wd5QK96etOOQPfSeMujsbMQ9TgkD5FJ1ihkTTnOOhVmOkCkUkVhrOcuUU1
	o3nK23KqaQUhHbOWi63anO0gr1TjwP6GhVTKeqf2ILwxs96UVRmFNCkYXU1HnW/4zgtUrwlTGQn
	9ugq27BDpkJj5Jv5MHZbO/4lAsqU7NKhvxtbbHop6etpCUTKn4aS8ASe6hfNACg/77p8m2wEsFG
	5qEQL+GstplUN
X-Google-Smtp-Source: AGHT+IG/WSpRufGwBIFMbBbi+61qwCv7PSPv3muO5uBC52/ZhXkQb7Fx32UBp+CjF7KUcWoQPUAUkw==
X-Received: by 2002:a17:907:72ce:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b0461aa6b6fmr6842766b.7.1756823812082;
        Tue, 02 Sep 2025 07:36:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042b0046ecsm523369366b.71.2025.09.02.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:28 -0700
Subject: [PATCH 6/7] netpoll: Move find_skb() to netconsole and make it
 static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-6-51a03d6411be@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890; i=leitao@debian.org;
 h=from:subject:message-id; bh=hEoM6CFJdWE31w8xFW6aTHY60k+r+bWwOR/kv/6lIlw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5xjohKd6EfSj8DIEFNfTJu4cHqZEarDmav
 ttZ7edvlSSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bXUVEAChtWWNrf/dSg9KAE95hR4+7Hqmjea00XpB7Kh+1klR1Igo/rVxU76NaLGb5LpGYXUOAnw
 9bhWEyULgeChkHaOoUAZ7b5+6zajPlyD4q3AhIR+4SRVZCIQRZiE2Hj1Swa9JXFxVFQcsJc0aTf
 NnJcgFAhD6l8elm2vnGN2cOn3RHavdnW11pVwAx4mmJgVHgY3mBuAZTWniHRoKO9vLyTlJwSiv8
 ODa7UwXT11sdxjPhZkbeNAXXVWghNp3mqvNUI08kqemEWPLck+elTmea7Y7ZRyt9oBqKApNNUHq
 ZRX4d3N7fxsB0iK+R1YWmri1hg532j/4yZTboJAh6cEvn92jXsyoPkB27+cThknfPwtXktSrWhA
 ttpSLiBQ+qgML5egeZorXWZ4qec1MwW50XvD6xiWC7+Vu06Mo+52YO90MzM6wSvv/BnX7W6y+Pl
 Tbn4h9CToSI0SlHE8PU3UNeu2N8JO9pDFHHWBgSXZDx4j9rRDe9S4OubXgVjWepOrwenxcokDxj
 DHcMgJ9i3VXs/AT4nlQZN67O+wdSjUSYyCMg4GGEgZ3b3lRd7JOTlsx/8VVZxD7NJG3zaDsXc8D
 IFHbC54zCkKjnyZsq4PkQdzjyE1A6SyA+Z5LOewNXwrg/KGueUy4dq4OOGWdtDtqJJcNuuw1vdq
 5vI0O6NBUG/W5MQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Complete the SKB pool management refactoring by moving find_skb() from
netpoll core to netconsole driver, making it a static function.

This is the final step in removing SKB pool management from the generic
netpoll infrastructure. With this change:

1. Netpoll core is now purely transmission-focused: Contains only
   the essential netpoll_send_skb() function for low-level packet
   transmission, with no knowledge of SKB allocation or pool management.

2. Complete encapsulation in netconsole: All SKB lifecycle
   management (allocation, pool handling, packet construction) is now
   contained within the netconsole driver where it belongs.

3. Cleaner API surface: Removes the last SKB management export from
   netpoll, leaving only zap_completion_queue() as a utility function
   and netpoll_send_skb() for transmission.

4. Better maintainability: Changes to SKB allocation strategies or
   pool management can now be made entirely within netconsole without
   affecting the core netpoll infrastructure.

The find_skb() function is made static since it's now only used within
netconsole.c for its internal SKB allocation needs.

This completes the architectural cleanup that separates generic netpoll
transmission capabilities from console-specific resource management.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 27 +++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 28 ----------------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3fe55db07cfe5..bf7bab7a9c2f0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1655,6 +1655,33 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 		eth->h_proto = htons(ETH_P_IP);
 }
 
+static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+{
+	int count = 0;
+	struct sk_buff *skb;
+
+	zap_completion_queue();
+repeat:
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb) {
+		skb = skb_dequeue(&np->skb_pool);
+		schedule_work(&np->refill_wq);
+	}
+
+	if (!skb) {
+		if (++count < 10) {
+			netpoll_poll_dev(np->dev);
+			goto repeat;
+		}
+		return NULL;
+	}
+
+	refcount_set(&skb->users, 1);
+	skb_reserve(skb, reserve);
+	return skb;
+}
+
 static struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
 					   int len)
 {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 7f8b4d758a1e7..f89bc9fb1f773 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 94c75f39787bb..5aa83c9c09e05 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -235,34 +235,6 @@ void zap_completion_queue(void)
 }
 EXPORT_SYMBOL_GPL(zap_completion_queue);
 
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
-{
-	int count = 0;
-	struct sk_buff *skb;
-
-	zap_completion_queue();
-repeat:
-
-	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
-	}
-
-	if (!skb) {
-		if (++count < 10) {
-			netpoll_poll_dev(np->dev);
-			goto repeat;
-		}
-		return NULL;
-	}
-
-	refcount_set(&skb->users, 1);
-	skb_reserve(skb, reserve);
-	return skb;
-}
-EXPORT_SYMBOL_GPL(find_skb);
-
 static int netpoll_owner_active(struct net_device *dev)
 {
 	struct napi_struct *napi;

-- 
2.47.3


