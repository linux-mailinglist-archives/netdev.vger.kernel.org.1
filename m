Return-Path: <netdev+bounces-162795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A3A27F27
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EEE3A06DA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3821C18A;
	Tue,  4 Feb 2025 23:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34208206F16
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710063; cv=none; b=aazxlqq9dLDGoQddGTxk9h117MIomVWONvobptQI79nqrn5f9b93xhOS1G6E3xorxHHhV422LPt9gg6tyrLi1NYZrxyTvqZFayG+hF5aPpGVm3x5hGWzewzHA2wLt58t7wdiPuvMHNeZh0EZFSw/vkxRBh/tM8bYFkf0fDEzeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710063; c=relaxed/simple;
	bh=r4pLZP27SnGk+NUHU8GerlNYnqnEDtaakLxWmssmaXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeebNc3BBHHOsUqSCQ5oNHF2FmHrtTSG3Wga4LVqcwTvYB3JZTiD9AzP40uI9RMETcbxxsVKEMPLH0yTfjSVNmRWqHPEEdolzTB/+e/kHj2eLJ9bu0qJvCaYGW/OrBXbdk6A9JAYH+X4Wf0hOx8B+9E452tW/D4q0D7NdAVJUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163dc5155fso108573235ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 15:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738710060; x=1739314860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElQb9U4uQw6ven++d30UUeDXa84HifTkFMszzPFiP4M=;
        b=lSYC/NZpsAtpUExgiwQ5N1UV96tlZ1n8kA4VX7KHxmx/UeFVVRZilnSU+XEBkYKxIw
         uuKUZYhxxkgxXKdKHawAAIh9z5ofecMRQ/b15aTT7NFvx7buamue6OM2lWXy5rKWX7EK
         QGQlAXP04xsA8eZnvI+g6iQ8lVvGmZxjArEtd8fuIHbb3CgMunaRFZKJu9/TEfBMsTY6
         OtRXBI/eki5SaCC/PUgM0aUUi1Cc3eQAV3S/xPN8JfriVcoM4IO59P0xVvKX7h2vQfnF
         ZRuqBgcLFb6lvr45MRMvriXvi0OnsOvdLxqabT762Hp/gPu5lb+XHWBGf7vMbSlQrdQg
         TFVg==
X-Gm-Message-State: AOJu0Yxmpy+/Z9ISnnXESrACgcr61b1mZlpszUgV04HxuZCQqZr8jaUX
	h8TLLXJVMUF2wr3lBA8FEbwpS+ZsGurrfCrQDb9j4+JSGHgqz4u2n5wn
X-Gm-Gg: ASbGncv1hHOoCqqPgSnMBJj20qrvOu0DIfBzLbLuNnwk7tXgQehTCJ8c1YhYr8+Khjl
	pEpa0/HlGdLZDiuD+wmqd+8zPjOh7NkCl2yYMU9XR413mLIuLXOgIBZ99arK1th6icQtPOpgq8W
	TWsq55SBhhUjYdpcpZQH/gfk52MASFeHvHPGoFimQj4UR2CApc83eabtnTG9aV7sab2vxW5/p5p
	tr++aAxvML/pPjXnJvRKXWgkmgPP+n4cBgbrqbxRceHbm6PvpzgTjg0vp0joAxVK75t9EdqWJGl
	RsF8U6bX3xXM2sY=
X-Google-Smtp-Source: AGHT+IEmOnfAJ9my4yJ3mm8rM7h5TDMuOxxQs5p8g6UUpb/82MJzF1bynncwi1SDlIZ2wtNL2ZNmIg==
X-Received: by 2002:a05:6a00:28cc:b0:725:f1b1:cbc5 with SMTP id d2e1a72fcca58-730350f96demr1316232b3a.3.1738710059931;
        Tue, 04 Feb 2025 15:00:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-acebe384272sm9110022a12.18.2025.02.04.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:00:59 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [RFC net-next 1/4] net: Hold netdev instance lock during ndo_open/ndo_stop
Date: Tue,  4 Feb 2025 15:00:54 -0800
Message-ID: <20250204230057.1270362-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204230057.1270362-1-sdf@fomichev.me>
References: <20250204230057.1270362-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the drivers that use shaper API, switch to the mode where
core stack holds the netdev lock. This affects two drivers:

* iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
         remove these
* netdevsim - switch to _locked APIs to avoid deadlock

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst     |  6 ++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
 drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
 include/linux/netdevice.h                   | 23 +++++++++++++++++++++
 net/core/dev.c                              | 12 +++++++++++
 net/core/dev.h                              |  6 ++++--
 6 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1d37038e9fbe..78213e476ce6 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -210,11 +210,13 @@ packets is preferred.
 struct net_device synchronization rules
 =======================================
 ndo_open:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
 	Context: process
 
 ndo_stop:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
 	Context: process
 	Note: netif_running() is guaranteed false
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2d7a18fcc3be..176f9bb871d0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4375,22 +4375,21 @@ static int iavf_open(struct net_device *netdev)
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int err;
 
+	netdev_assert_locked(netdev);
+
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
 		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
 		return -EIO;
 	}
 
-	netdev_lock(netdev);
 	while (!mutex_trylock(&adapter->crit_lock)) {
 		/* If we are in __IAVF_INIT_CONFIG_ADAPTER state the crit_lock
 		 * is already taken and iavf_open is called from an upper
 		 * device's notifier reacting on NETDEV_REGISTER event.
 		 * We have to leave here to avoid dead lock.
 		 */
-		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER) {
-			netdev_unlock(netdev);
+		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER)
 			return -EBUSY;
-		}
 
 		usleep_range(500, 1000);
 	}
@@ -4439,7 +4438,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_irq_enable(adapter, true);
 
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return 0;
 
@@ -4452,7 +4450,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_free_all_tx_resources(adapter);
 err_unlock:
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return err;
 }
@@ -4474,12 +4471,12 @@ static int iavf_close(struct net_device *netdev)
 	u64 aq_to_restore;
 	int status;
 
-	netdev_lock(netdev);
+	netdev_assert_locked(netdev);
+
 	mutex_lock(&adapter->crit_lock);
 
 	if (adapter->state <= __IAVF_DOWN_PENDING) {
 		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
 		return 0;
 	}
 
@@ -4532,6 +4529,7 @@ static int iavf_close(struct net_device *netdev)
 	if (!status)
 		netdev_warn(netdev, "Device resources not yet released\n");
 
+	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 	adapter->aq_required |= aq_to_restore;
 	mutex_unlock(&adapter->crit_lock);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdcee..efec03b34c9f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -401,7 +401,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
+		netif_napi_add_config_locked(dev, &rq->napi, nsim_poll, i);
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
@@ -421,7 +421,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++)
-		__netif_napi_del(&ns->rq[i]->napi);
+		__netif_napi_del_locked(&ns->rq[i]->napi);
 
 	return err;
 }
@@ -435,7 +435,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 		struct nsim_rq *rq = ns->rq[i];
 
 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
-		napi_enable(&rq->napi);
+		napi_enable_locked(&rq->napi);
 	}
 }
 
@@ -444,6 +444,8 @@ static int nsim_open(struct net_device *dev)
 	struct netdevsim *ns = netdev_priv(dev);
 	int err;
 
+	netdev_assert_locked(dev);
+
 	err = nsim_init_napi(ns);
 	if (err)
 		return err;
@@ -461,8 +463,8 @@ static void nsim_del_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		struct nsim_rq *rq = ns->rq[i];
 
-		napi_disable(&rq->napi);
-		__netif_napi_del(&rq->napi);
+		napi_disable_locked(&rq->napi);
+		__netif_napi_del_locked(&rq->napi);
 	}
 	synchronize_net();
 
@@ -477,6 +479,8 @@ static int nsim_stop(struct net_device *dev)
 	struct netdevsim *ns = netdev_priv(dev);
 	struct netdevsim *peer;
 
+	netdev_assert_locked(dev);
+
 	netif_carrier_off(dev);
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2a59034a5fa2..962774cbce55 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2717,6 +2717,29 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 		netdev_assert_locked(dev);
 }
 
+static inline bool need_netdev_ops_lock(struct net_device *dev)
+{
+	bool ret = false;
+
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	ret |= !!(dev)->netdev_ops->net_shaper_ops;
+#endif
+
+	return ret;
+}
+
+static inline void netdev_lock_ops(struct net_device *dev)
+{
+	if (need_netdev_ops_lock(dev))
+		netdev_lock(dev);
+}
+
+static inline void netdev_unlock_ops(struct net_device *dev)
+{
+	if (need_netdev_ops_lock(dev))
+		netdev_unlock(dev);
+}
+
 static inline void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..fda42b2415fc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1595,6 +1595,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ret)
 		return ret;
 
+	netdev_lock_ops(dev);
+
 	set_bit(__LINK_STATE_START, &dev->state);
 
 	if (ops->ndo_validate_addr)
@@ -1614,6 +1616,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 		add_device_randomness(dev->dev_addr, dev->addr_len);
 	}
 
+	netdev_unlock_ops(dev);
+
 	return ret;
 }
 
@@ -1684,11 +1688,19 @@ static void __dev_close_many(struct list_head *head)
 		 *	We allow it to be called even after a DETACH hot-plug
 		 *	event.
 		 */
+
+		/* TODO: move the lock up before clearing __LINK_STATE_START.
+		 * Generates spurious lockdep warning.
+		 */
+		netdev_lock_ops(dev);
+
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
+
+		netdev_unlock_ops(dev);
 	}
 }
 
diff --git a/net/core/dev.h b/net/core/dev.h
index a5b166bbd169..18070c0452e3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -134,9 +134,11 @@ static inline void netif_set_up(struct net_device *dev, bool value)
 	else
 		dev->flags &= ~IFF_UP;
 
-	netdev_lock(dev);
+	if (!need_netdev_ops_lock(dev))
+		netdev_lock(dev);
 	dev->up = value;
-	netdev_unlock(dev);
+	if (!need_netdev_ops_lock(dev))
+		netdev_unlock(dev);
 }
 
 static inline void netif_set_gso_max_size(struct net_device *dev,
-- 
2.48.1


