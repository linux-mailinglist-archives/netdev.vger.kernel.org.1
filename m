Return-Path: <netdev+bounces-116831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21494BD61
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CCF1F2392D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0918E033;
	Thu,  8 Aug 2024 12:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD818DF79;
	Thu,  8 Aug 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119934; cv=none; b=uIXU37mDKzTIfYFa3xtEgG8AeWHquBzxxGWdl7qRDVCLjTlDhiOwDklfqKI/wLeZMuhEcuvDoB9+GW8mt8t8bNVVCQ9je3taKHwI/XSMolwS9S/UeB8CLaSyuw8iTlzSXQPqPX7Nt/B5qSgDec+QDqoAXHPkTw1MESB8GyxU44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119934; c=relaxed/simple;
	bh=21NE45D05kd+63ejuqgp1rSDb0fTwjxyjDDlDLdKAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGAOKu1pvkOQOPhgwgns63l+eafqWUOJNDB/Pt08zj9++RbkNI8h/dOf8VuvfMJHwW2+Q8dr6fMpzpC2VYuyO9RDs5sxBCBLAv9wCaA0MboqRsIQQ22JH5Tq3X8DDIMFk9poWlkXuJSe1vrSzaL4XJx54XPuaTLhBL/s0hrdrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a83a968ddso101058066b.0;
        Thu, 08 Aug 2024 05:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119929; x=1723724729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oetxee9IMfZJjcpz+QqY4cG+Xmvizi5jKcfwfQxazyM=;
        b=IvwtdGR+KEV89yp9EiVqmHyoRTWP64BMJ1yE57IfQnfs+q5yZn8TLy0m8Pn8nV9Hy8
         J/9H2YXsOWOPbLSQtmcJV4M1dmWD2rNYMlGM4XhSoy0AKBhfnr+eYmi0JHNN8uv7Gw6i
         O+DW4siqPlRMoewM1QJl0yYml9K90usyRi6UkcLcPS5Ccty2uxStBrcPXgHdPf7Sl2tP
         pHniLkQyA+UPIM+ijhzr6ee+poJfTiNrp8u1qXgVR3PJmntdLzy9kQE2nb1XqsaUoTtu
         RADexqIRcXjM9lKfbRd4JRVS4fXYB5pWyIrIyBah1u/E2UzjeonK8KJAV3RBV1+QtOvA
         lSAg==
X-Forwarded-Encrypted: i=1; AJvYcCUEYrfKxVnqBkp4k4S1jTrXkj6JfYr3+l7TSbzzBwz4vKdsRF2nF+rQMmHbLQVYhS4r0RUKXcz624Nkqnns4bBBPjfy2gBebIC+5WtfVjO9GUnFxdwPndr692TpI6y3VswL9lMd
X-Gm-Message-State: AOJu0Yw4a1nbTRPttrK9EPwmxd6y5HdzG+1xNAH9Gl7yK0Mlfle/n6oB
	Hdz60USB6Et3iFMG5n0teTgDgiPhxmaQo83FdGKBw9pkkJflD0Gx
X-Google-Smtp-Source: AGHT+IFeyf71IZdc5qIXVp3SwJjPT4RpTtvIOqRQYR0rG7xzU0sBIJ8uS8MHh+0md/VzgBPFt6V6vg==
X-Received: by 2002:a17:907:e698:b0:a7d:a29e:5c41 with SMTP id a640c23a62f3a-a8090dc0e7amr111218866b.40.1723119929307;
        Thu, 08 Aug 2024 05:25:29 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecabb2sm732411166b.214.2024.08.08.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:28 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/5] net: netpoll: extract core of netpoll_cleanup
Date: Thu,  8 Aug 2024 05:25:07 -0700
Message-ID: <20240808122518.498166-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808122518.498166-1-leitao@debian.org>
References: <20240808122518.498166-1-leitao@debian.org>
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
Reviewed-by: Rik van Riel <riel@surriel.com>
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
2.43.5


