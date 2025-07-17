Return-Path: <netdev+bounces-207988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48CB0931D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0D45A2F91
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426472FE39D;
	Thu, 17 Jul 2025 17:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929752FE392
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773023; cv=none; b=j7/3iWvNEK5NWxS+m4DRgfbPPe0kjM11glwlEbZwHovFsvakBMgge4P9eoG1s3uNsEP/bMD3BW8WSnCzGCUcGOHzDIvIDoz9hTRFiMGjf77lQNqjoYe24Qt1YaWV17DmqRfZx7TFZzjecuNwNistJXa8OcPz3Z2qOIdcd7ovwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773023; c=relaxed/simple;
	bh=sP4hCDI+c1Glj0n5khJy9A+n/emaTnw+rEI8v3P9lpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/i9JmYJ6Z/dTSAQEhrXtm6kKed5ZBVM9HXEfi+VQYclso87oe9pAecEz/DX/WJ36WVVBVpGNDFMeit9eqeFvOjqRj2RnjsKN7aioHs3rRZs1lQ3k2EdvPp4F/z5GcMBmZZRXApaHimo5w1GNYmsWlHl78UZVaR+FZ7F7aTim+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747e41d5469so1533228b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773021; x=1753377821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j15U2S5H80WwANmC/xcPZqMaOxqq4k/Q957qOI+IXBU=;
        b=qvp295Zr4Id7fqxpOFNKuiZfyQuF37cctQMXGSJyHnA0b3B+4Qb/Yj5SjmgbEv1OGF
         aVgma7lqHqkeGxNi4w8IwiwJF9kgprP8M0m9W57gVXG+pPQgnooxH9J2ESPi/NYhnVue
         6P+TiGt0nX1O9hWyy6aVyJjnN3/+AzqwpxY+1v2uXLS3umFMtMZ0+Zqa1iqBlIarEsQr
         8PSgy86+RDwIBW+Yqu6R1y9jkuJO/PjiN6Nwf/vVabG7+nw2NkE0+KN9yYkK8sdsOp/O
         6ZQSTZXH12QlKoy9mOrw3XDCwXLOwNP3xQzEJpUOw/4WkyMjrSN4sd3bBruEhwazLAY6
         lTJA==
X-Gm-Message-State: AOJu0YzUIJodQ2HhoCNG/WhY8EG9PDu7sx5vc+Xbkxnm659J2sNV0sM2
	2reTdrgh7eKkA49ETD6KydzrJGzvxgoYpC0FU/iUcJHkrh+V8Vtjzzuswdoi
X-Gm-Gg: ASbGncsUMn9duaNggepMvBKt7gcHMqKf6C6krut/M/SN0DO0ISDibrrvoVYGZL25gVN
	L4afDP12xSdTNbi+lpM2r+jMZWhsOCmIhZjjmEhLAicoMXDEgdtZsdqF4FIOzufzz4awwzjLaUL
	Vye5Am+GiYIGNU7PP1+5Q36a0ZW3xKBC4FxDLitjYyMZtsPpRirVKrAOY7/5XjIctQZgkY9YX5o
	JZ2ABsqX0tLKY/D/cRylHt15QHIPZQFloUEbaHHbRWyujN8dCQhKOhpbH/+iH2lbseKxN0osbB7
	h7Z8WeleK9bFMc2flJANb3zuU03Wc3+ItzYjVkot0rJGktUSnLeaS6+ZI1HySfAutDKBNF41DzG
	OsLnDGmf4A9E7S/qZiQ6qDlQeNIL/wCwdQSGO5I85TCTAPENfjsbXnSWClPs6KJtTZgNsSA==
X-Google-Smtp-Source: AGHT+IE8hwYLW7d5NM4xn8kerTakcGCOwl2DK6RXuYzxG/sKnrmsBq89dPHxqzZ2l8Kn+RSySpnwjQ==
X-Received: by 2002:a05:6a00:1acb:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-7572357ee82mr10680363b3a.6.1752773020601;
        Thu, 17 Jul 2025 10:23:40 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9e06c72sm16867145b3a.66.2025.07.17.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:40 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 6/7] net: s/dev_set_threaded/netif_set_threaded/
Date: Thu, 17 Jul 2025 10:23:32 -0700
Message-ID: <20250717172333.1288349-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717172333.1288349-1-sdf@fomichev.me>
References: <20250717172333.1288349-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

Note that one dev_set_threaded call still remains in mt76 for debugfs file.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../networking/net_cachelines/net_device.rst         |  2 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c      |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c            |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c             |  2 +-
 drivers/net/wireguard/device.c                       |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c               |  2 +-
 include/linux/netdevice.h                            |  1 +
 net/core/dev.c                                       |  6 +++---
 net/core/dev_api.c                                   | 12 ++++++++++++
 net/core/net-sysfs.c                                 |  2 +-
 10 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index c69cc89c958e..2d3dc4692d20 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -165,7 +165,7 @@ struct sfp_bus*                     sfp_bus
 struct lock_class_key*              qdisc_tx_busylock
 bool                                proto_down
 unsigned:1                          wol_enabled
-unsigned:1                          threaded                                                            napi_poll(napi_enable,dev_set_threaded)
+unsigned:1                          threaded                                                            napi_poll(napi_enable,netif_set_threaded)
 unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index ef1a51347351..3a9ad4a9c1cb 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	dev_set_threaded(netdev, true);
+	netif_set_threaded(netdev, true);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 058dcabfaa2e..a2e97b712a3d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	netif_set_threaded(mlxsw_pci->napi_dev_rx, true);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c9f4976a3527..4e79bf88688a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			dev_set_threaded(ndev, true);
+			netif_set_threaded(ndev, true);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 4a529f1f9bea..5afec5a865f4 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -366,7 +366,7 @@ static int wg_newlink(struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	dev_set_threaded(dev, true);
+	netif_set_threaded(dev, true);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index d51f2e5a79a4..0ee68d3dad12 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -936,7 +936,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(ar->napi_dev, true);
+	netif_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
 	/* IRQs are left enabled when we restart due to a firmware crash */
 	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8370cd0f8f6b..7929ddfd4433 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -589,6 +589,7 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
+int netif_set_threaded(struct net_device *dev, bool threaded);
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
 void napi_disable(struct napi_struct *n);
diff --git a/net/core/dev.c b/net/core/dev.c
index 40ddeb4e0717..99f1e87f8274 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4798,7 +4798,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 
 	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
 		/* Paired with smp_mb__before_atomic() in
-		 * napi_enable()/dev_set_threaded().
+		 * napi_enable()/netif_set_threaded().
 		 * Use READ_ONCE() to guarantee a complete
 		 * read on napi->thread. Only call
 		 * wake_up_process() when it's not NULL.
@@ -6986,7 +6986,7 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
 	return 0;
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int netif_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
 	int err = 0;
@@ -7027,7 +7027,7 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 
 	return err;
 }
-EXPORT_SYMBOL(dev_set_threaded);
+EXPORT_SYMBOL(netif_set_threaded);
 
 /**
  * netif_queue_set_napi - Associate queue with the napi
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 1bf0153195f2..dd7f57013ce5 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -367,3 +367,15 @@ void netdev_state_change(struct net_device *dev)
 	netdev_unlock_ops(dev);
 }
 EXPORT_SYMBOL(netdev_state_change);
+
+int dev_set_threaded(struct net_device *dev, bool threaded)
+{
+	int ret;
+
+	netdev_lock(dev);
+	ret = netif_set_threaded(dev, threaded);
+	netdev_unlock(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_threaded);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e41ad1890e49..c28cd6665444 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -757,7 +757,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (val != 0 && val != 1)
 		return -EOPNOTSUPP;
 
-	ret = dev_set_threaded(dev, val);
+	ret = netif_set_threaded(dev, val);
 
 	return ret;
 }
-- 
2.50.1


