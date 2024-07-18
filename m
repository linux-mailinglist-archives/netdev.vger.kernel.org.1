Return-Path: <netdev+bounces-112115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99A9351D9
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20511F21B39
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF34145A19;
	Thu, 18 Jul 2024 18:43:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3E145A1A;
	Thu, 18 Jul 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721328211; cv=none; b=QF6A5CYgwLqbpxa3a4R1Yg+ve5qHmvXAIX5cKsylfOGp4quLy8tH9a9il7BHyD2zmEj7LBq9y/R/pQFPlZ4iF41eGIaHqGLGyKJFY5GaJF6Ekf9N/DHNFvSF/VXwztpJqxc76Q8l6J4hEMISlHw7GdjvYMp9XhvK7TvA5thL6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721328211; c=relaxed/simple;
	bh=Sm07o6Ufp8do35ESzkLqvQJpM2dkBIWWSAhOTGIZwDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzgreR1ons2ajNByD01loneUV7BKmejv1X3RlGTcg5lvUCsM5nRNZb9hOYinQ0Foq2Nb9J6u0WIjW1fi0hY110zYQgdbuYedVHhJlzzS+PKm9LNV8F7WXL6+3icoUMB6K7f2XYd0Gj6Mfv6SI41OLi7sUa7kOjS2S8guaJXRI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso1014391e87.2;
        Thu, 18 Jul 2024 11:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721328207; x=1721933007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V4xx6aRhiInn14syAhPQsREkEPC+V+Yp/bBmaUNJu4=;
        b=LZsFnJc2akTFIyxZHsTOAG8f/luy8CktNm21r0FaZqDJUF449uAGfpCyus84f2YnXa
         e2dmeisjyJhr2f/zIc7PGVD1BOgvKgO0rss7Dqg2cAUr6x10TNqc3hX8ehDyL6sNSAO3
         81cz1bRfQLUa8ho7Df17l/l8MdDxzFQnQc0RQ4mtzJMynwomZ9pW8SLwu+NZdt0M35i4
         zRWXFiGB+SM3B9pZOlyhloHqdRMgDfiUfYmL7LIcN/UCLVCMfmubzNUBcWKi1OF7wOye
         4oLyj+/qx5utltjXtaI7RkOLKn/8Hj9mNZ+Jr1VQZbkPiJLFpE3jhjA7G6/eIV9w4yNR
         lJOA==
X-Forwarded-Encrypted: i=1; AJvYcCW10kKGCbU/xtJlXp24exiFCDzgpnfCBAleupsz5DatlznPJoN/DikZbKpfEjOH+Oapo2KqBzyTjdZNHs7r1W/3ceXROzOK/mRkQ33A3m/JO1EYpFEc8N2aQWaRfDSeYybzo3Ui
X-Gm-Message-State: AOJu0YwOibiR/xSnzK5hY+M9i+K5Ovh+Sf0IUgc75Fq5lgp/jGgxZJJE
	xM77tQHPWC6jgDNf4LHhE90K4tGDNM5GavN4j4jerOtl0VYb0DLm
X-Google-Smtp-Source: AGHT+IF3SlY6/dSViasbUcmZZxIDT7kaR/U3VYe5G2G02PeFA+1s2nqaXGYJ7IR/grLZCIrDolNIhg==
X-Received: by 2002:ac2:4c41:0:b0:52e:9cc7:4462 with SMTP id 2adb3069b0e04-52ee53a7234mr5530432e87.11.1721328207121;
        Thu, 18 Jul 2024 11:43:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc80112fsm592386466b.183.2024.07.18.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:43:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [RFC PATCH 1/2] netpoll: extract core of netpoll_cleanup
Date: Thu, 18 Jul 2024 11:43:05 -0700
Message-ID: <20240718184311.3950526-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718184311.3950526-1-leitao@debian.org>
References: <20240718184311.3950526-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the core part of netpoll_cleanup(), so, it could be called from
a caller that has the rtnl lock already.

Netconsole uses this in a weird way right now:

	__netpoll_cleanup(&nt->np);
	spin_lock_irqsave(&target_list_lock, flags);
	netdev_put(nt->np.dev, &nt->np.dev_tracker);
	nt->np.dev = NULL;
	nt->enabled = false;

This will be replaced by do_netpoll_cleanup() as the locking situation
is overhauled.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index bd19c4b91e31..cd4e28db0cbd 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -64,6 +64,7 @@ int netpoll_setup(struct netpoll *np);
 void __netpoll_cleanup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
+void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 55bcacf67df3..a58ea724790c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -853,14 +853,20 @@ void __netpoll_free(struct netpoll *np)
 }
 EXPORT_SYMBOL_GPL(__netpoll_free);
 
+void do_netpoll_cleanup(struct netpoll *np)
+{
+	__netpoll_cleanup(np);
+	netdev_put(np->dev, &np->dev_tracker);
+	np->dev = NULL;
+}
+EXPORT_SYMBOL(do_netpoll_cleanup);
+
 void netpoll_cleanup(struct netpoll *np)
 {
 	rtnl_lock();
 	if (!np->dev)
 		goto out;
-	__netpoll_cleanup(np);
-	netdev_put(np->dev, &np->dev_tracker);
-	np->dev = NULL;
+	do_netpoll_cleanup(np);
 out:
 	rtnl_unlock();
 }
-- 
2.43.0


