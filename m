Return-Path: <netdev+bounces-178341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02451A76AAC
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB5166D15
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99F21C193;
	Mon, 31 Mar 2025 15:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B721C9E7
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433575; cv=none; b=GW7y/Ihkk0WVNfkW7QLo0dYHBYOH8OrmQJ3qjZb8W4z5ZJu14RYIb9PCZ6Q16bXdoByWvbd8LZmqvCB8k0s4CI8wlcTAFceOmc9hiQxXZmRMaP6YR3ZMzwSTtRS2Uo2pC/y+dhldYQT25/bPB60CDB21DFEXKldXFhGK2joFrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433575; c=relaxed/simple;
	bh=fk6PCYPeCeRjRPK+RnICodseYYpTy/4gvY4+yGXBwgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqblb9NfsvvWUVyxCSpiWLMGlyezXgxqtdDKLBUShzgG/833//utLeIBFC4Jlb+NwirGrEbwJe2ybipNT5ePfk7WEkJGstrw7AmxnGxwQN8SCXYhCSckZSfnvBvv0EJhcoUvHNxX15Yc+v4Cw8MPIGPDAx1Jw1PUaE6qdSbFxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso102788575ad.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433572; x=1744038372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxdX0i18cLiiRxO0Z5z7ViZeMQPVjKCK2cApBMaWKX8=;
        b=t4MPT0c97yYZYIY6HJeDwTzK7KVNifFRbgMPT7kVujZxmMkJ7mpJbRmxCTJJ81CNBR
         lBit6CX9OGuh0RCd+wXkVOeNedX+KxIURqsoVizU/JYtzl9pH4ChWiKZjB14FfjulYGk
         BAGqCNecxNVcOwBGsc3uFIli8UwXhfVkw9vbO5rglvMPG+QQTAF5fIAaTKfbhT0rjCuZ
         yDrWqlgflqeKFVefqFHTeVHpRqI5r8vhyl4muABr/Tln3krNTZKH0miRQKZkgTvZNuP1
         Gm8lK6tS7eeH912Hqznkl1jFtlJRTTS1OGyCLAugxYLn9NocZ0Zb8ITwi1Qcwxk/Krxa
         sR1w==
X-Gm-Message-State: AOJu0YzZWsO1tB/qvl+RzLsuO//0KfJxS/HaJDuGW361sPMEx6J23ncN
	YL+6UhvRFjtRehoKi64i7d5Uj0MObUwHl18KUozlj38Ex92Psl0J7dlc
X-Gm-Gg: ASbGnctwUUr9fI2qW7PZoiIN7fZVapPucqT2twbALN25xBhvALKyaq/IlGbPaQFSp8I
	hlUXWL2Gqhc3zLJM9LMuH17Dta+zq7HJIrzBT0Ti9OmtKqLFBe7HCojPgd4T+Am/Lwr5D/tvpZS
	p5763MXXtR274rDqrMZnHmVRfdF8hgYZrvrlVJtWjzZ2XiSBzAhYGmVKvitkNTxaH+03NBC+wnE
	s0AMnKpdYvC532SaszN5v6IpULDI13JG1sQ7pFMH4aMxZfOIY5tGfHbwAJjPU6rfFpBwceeZBr9
	aAhF0+ogFFtfXygR/O75TxiTG4vMuvWXFjAXB1dERk9e
X-Google-Smtp-Source: AGHT+IEqCrR9xJQPy8FIRCcbMYV9UYrrRg6Y8lBR/Pe6O9CVZs0c7oRfkexb+8WO5U78Ul6npDHRDg==
X-Received: by 2002:a17:90b:2e4f:b0:2fa:3b6b:3370 with SMTP id 98e67ed59e1d1-3051c9702d9mr19727872a91.16.1743433572510;
        Mon, 31 Mar 2025 08:06:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d3cdf9sm7333350a91.7.2025.03.31.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 05/11] netdevsim: add dummy device notifiers
Date: Mon, 31 Mar 2025 08:05:57 -0700
Message-ID: <20250331150603.1906635-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to exercise and verify notifiers' locking assumptions,
register dummy notifiers (via register_netdevice_notifier_dev_net).
Share notifier event handler that enforces the assumptions with
lock_debug.c (rename and export rtnl_net_debug_event as
netdev_debug_event). Add ops lock asserts to netdev_debug_event.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c    | 10 ++++++++++
 drivers/net/netdevsim/netdevsim.h |  3 +++
 include/net/netdev_lock.h         | 11 +++++++++++
 net/core/lock_debug.c             | 14 +++++++++-----
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b67af4651185..6188699aa241 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -939,6 +939,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
@@ -960,6 +961,11 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
+
+	ns->nb.notifier_call = netdev_debug_event;
+	if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb, &ns->nn))
+		ns->nb.notifier_call = NULL;
+
 	return 0;
 
 err_ipsec_teardown:
@@ -1043,6 +1049,10 @@ void nsim_destroy(struct netdevsim *ns)
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
+	if (ns->nb.notifier_call)
+		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
+						      &ns->nn);
+
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 665020d18f29..d04401f0bdf7 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -144,6 +144,9 @@ struct netdevsim {
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
+
+	struct notifier_block nb;
+	struct netdev_net_notifier nn;
 };
 
 struct netdevsim *
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 1c0c9a94cc22..5f712de5bf8a 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -98,4 +98,15 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				  &qdisc_xmit_lock_key);	\
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_NET)
+int netdev_debug_event(struct notifier_block *nb, unsigned long event,
+		       void *ptr);
+#else
+static inline int netdev_debug_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 7ecd28cc1c22..506899164f31 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -6,10 +6,11 @@
 #include <linux/notifier.h>
 #include <linux/rtnetlink.h>
 #include <net/net_namespace.h>
+#include <net/netdev_lock.h>
 #include <net/netns/generic.h>
 
-static int rtnl_net_debug_event(struct notifier_block *nb,
-				unsigned long event, void *ptr)
+int netdev_debug_event(struct notifier_block *nb, unsigned long event,
+		       void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
@@ -17,11 +18,13 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 
 	/* Keep enum and don't add default to trigger -Werror=switch */
 	switch (cmd) {
+	case NETDEV_REGISTER:
 	case NETDEV_UP:
+		netdev_ops_assert_locked(dev);
+		fallthrough;
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
 	case NETDEV_CHANGE:
-	case NETDEV_REGISTER:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
@@ -66,6 +69,7 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 
 	return NOTIFY_DONE;
 }
+EXPORT_SYMBOL_GPL(netdev_debug_event);
 
 static int rtnl_net_debug_net_id;
 
@@ -74,7 +78,7 @@ static int __net_init rtnl_net_debug_net_init(struct net *net)
 	struct notifier_block *nb;
 
 	nb = net_generic(net, rtnl_net_debug_net_id);
-	nb->notifier_call = rtnl_net_debug_event;
+	nb->notifier_call = netdev_debug_event;
 
 	return register_netdevice_notifier_net(net, nb);
 }
@@ -95,7 +99,7 @@ static struct pernet_operations rtnl_net_debug_net_ops __net_initdata = {
 };
 
 static struct notifier_block rtnl_net_debug_block = {
-	.notifier_call = rtnl_net_debug_event,
+	.notifier_call = netdev_debug_event,
 };
 
 static int __init rtnl_net_debug_init(void)
-- 
2.48.1


