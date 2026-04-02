Return-Path: <netdev+bounces-274726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEqMNzr0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8938EE99
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4958B303D309
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35D3D47C1;
	Thu,  2 Apr 2026 22:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80431E82A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170543; cv=none; b=mx3KchVZyBnJ0w5dax0muz8qSYzKWqPYz6D7P9dyX+kgh3kAlP4EfmoIs5dO5a04+JWKy6AgwyRq2JGs7PxNF81+/lVQpX2TTXnxSOFf7rlbRAsR2x7isH3IyX42/52ypZU28oNRMnBBmb0Wk7OOFEjgOaXB0XdSIFPPS4VEGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170543; c=relaxed/simple;
	bh=i51jXvUiNab45g+OHZ6Ylm1arF2Y7OEsAKtK/0SWZj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDX/u2aJuJ1KY3v1QyxneKVnQgxrR9NQCw8Dv/OG4myQsUOlGM3mgvo07MbWDRsH1LHTDzbIHnBEDIfORGpU9w7WYqpqo6Ib+i5xHr6rpAjZbyqhhF70T6M2msqF1xzwAVchmnFO9zlnzi64oVie8kZ252Qfn5JDOnrJ8vWgyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2cc1534e026so154859eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170540; x=1775775340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/kWZk6DHeBYgPdpwnO406rbhIY0ezwD1KqAmA/LXsc=;
        b=L5JhksMM1y50NT1tw24ilmMtHA/Bey1AUb86T8s3sZxTUp6u+mTCtInslwS5YvkdFF
         qBQsbqedHqJAnMf2ImS+UYlNrft0qhhxXIrDRldOvZ48S+jvWPAc2SVeybzNqzOcghKs
         E2M+i53yo5ju8a3CJsc32KcPMDUFZJIaZeE61lyAh89hZownxMmJoXpIBu3Ll7zXvDmi
         MZFyc6yJp13CHrn8AwA5HzkD1gMNHfqIjZz/8UgF1QWAXSUclll1kYMLjg3i7e67DSZ2
         8JHkj4bbE87zhTniWceS7+pJV1pj0dCw7ya+J5mj5hamQ3nLVb5B0u2fz5LhR0YrnLTe
         rveg==
X-Gm-Message-State: AOJu0Yyb5vz9Si5wlrKnf/e6KWJY1fv/cJu1dnxS1e08lzp89dGxw/YS
	/L2/Q+cACGqOgYhEJQcnnFkakqpj7LLYfqBol4DVgPaat6SyjmY7unILefVt
X-Gm-Gg: AeBDietIDnBM3EFrl+vNN1Nc63KMGxkrwX2MxeZXuYGCQUs78mioFTOSkKDtijY2oMW
	ktwO8v+92JXo8mttD/Ougsh4U+3UpzhQJdjEgSayOusSuskvbhfa7zEuaRW0eoYp0IeFccVePde
	jK2p4pGXw/ipowKJHozjbSPGXQGOLN+VjnSgyx1u/SBQF44eHhCCxlID/QtvX/pep8+jdi73aXY
	679V/thfBcAYR1q9M+nkNDejOcS/gJEUBGsPxthtSxRaWi6VpOb468476Y46duSMwww2FMGufy9
	J4ZOwYQ9RbqF3IbhIdDfbyYX3GHbSvDZDqEaPh336ol7od/XfsUpttST3I4RHMnYoQhiox2GbK9
	v9+ZZM/SH/ACh6rxDYv/XOJGUK+kXuKOFJctZ4hN3N+b8dyE5J5Qk32ShRgzOOfVGBFywUyIb2s
	dcdMejrwiZz8rs/iW0BBa7b9MhFS4B47QoShw1BH0PBHjUFWIThdxRzreXOQ78ies0yFS2iTq8u
	jDbPKu9fh9uIlFcuA==
X-Received: by 2002:a05:7300:cd8a:b0:2c7:2c0b:f334 with SMTP id 5a478bee46e88-2cbfb4a6039mr511696eec.18.1775170539756;
        Thu, 02 Apr 2026 15:55:39 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm3476899eec.7.2026.04.02.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:39 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 03/14] net: move promiscuity handling into netdev_rx_mode_work
Date: Thu,  2 Apr 2026 15:55:24 -0700
Message-ID: <20260402225535.4124525-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,intel.com:email]
X-Rspamd-Queue-Id: 40B8938EE99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move unicast promiscuity tracking into netdev_rx_mode_work so it runs
under netdev_ops_lock instead of under the addr_lock spinlock. This
is required because __dev_set_promiscuity calls dev_change_rx_flags
and __dev_notify_flags, both of which may need to sleep.

Change ASSERT_RTNL() to netdev_ops_assert_locked() in
__dev_set_promiscuity, netif_set_allmulti and __dev_change_flags
since these are now called from the work queue under the ops lock.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |  4 ++
 net/core/dev.c                          | 16 ++---
 net/core/dev_addr_lists.c               | 82 ++++++++++++++++++-------
 3 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 8a488c21fd7c..390537323457 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -299,6 +299,10 @@ struct net_device synchronization rules
 	Notes: Async version of ndo_set_rx_mode which runs in process
 	context. Receives snapshots of the unicast and multicast address lists.
 
+ndo_change_rx_flags:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
 	(i.e. no ``rtnl_lock`` and no device instance lock). The rest of
diff --git a/net/core/dev.c b/net/core/dev.c
index b9f9e6a30963..ae1fd30d1ef9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9581,7 +9581,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9617,16 +9617,8 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 
 		dev_change_rx_flags(dev, IFF_PROMISC);
 	}
-	if (notify) {
-		/* The ops lock is only required to ensure consistent locking
-		 * for `NETDEV_CHANGE` notifiers. This function is sometimes
-		 * called without the lock, even for devices that are ops
-		 * locked, such as in `dev_uc_sync_multiple` when using
-		 * bonding or teaming.
-		 */
-		netdev_ops_assert_locked(dev);
+	if (notify)
 		__dev_notify_flags(dev, old_flags, IFF_PROMISC, 0, NULL);
-	}
 	return 0;
 }
 
@@ -9648,7 +9640,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9716,7 +9708,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	unsigned int old_flags = dev->flags;
 	int ret;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/*
 	 *	Set the flags on our device.
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index a05db3ac43ea..61589537b2d3 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1204,10 +1204,34 @@ static void netif_addr_lists_reconcile(struct net_device *dev,
 	__hw_addr_list_reconcile(&dev->mc, mc_snap, mc_ref, dev->addr_len);
 }
 
+/**
+ * netif_uc_promisc_update() - evaluate whether uc_promisc should be toggled.
+ * @dev: device
+ *
+ * Must be called under netif_addr_lock_bh.
+ * Return: +1 to enter promisc, -1 to leave, 0 for no change.
+ */
+static int netif_uc_promisc_update(struct net_device *dev)
+{
+	if (dev->priv_flags & IFF_UNICAST_FLT)
+		return 0;
+
+	if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
+		dev->uc_promisc = true;
+		return 1;
+	}
+	if (netdev_uc_empty(dev) && dev->uc_promisc) {
+		dev->uc_promisc = false;
+		return -1;
+	}
+	return 0;
+}
+
 static void netif_rx_mode_run(struct net_device *dev)
 {
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 	int err;
 
 	might_sleep();
@@ -1221,22 +1245,39 @@ static void netif_rx_mode_run(struct net_device *dev)
 	if (!(dev->flags & IFF_UP) || !netif_device_present(dev))
 		return;
 
-	netif_addr_lock_bh(dev);
-	err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
-					&uc_ref, &mc_ref);
-	if (err) {
-		netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+	if (ops->ndo_set_rx_mode_async) {
+		netif_addr_lock_bh(dev);
+		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
+						&uc_ref, &mc_ref);
+		if (err) {
+			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+			netif_addr_unlock_bh(dev);
+			return;
+		}
+
+		promisc_inc = netif_uc_promisc_update(dev);
+		netif_addr_unlock_bh(dev);
+	} else {
+		netif_addr_lock_bh(dev);
+		promisc_inc = netif_uc_promisc_update(dev);
 		netif_addr_unlock_bh(dev);
-		return;
 	}
-	netif_addr_unlock_bh(dev);
 
-	ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 
-	netif_addr_lock_bh(dev);
-	netif_addr_lists_reconcile(dev, &uc_snap, &mc_snap,
-				   &uc_ref, &mc_ref);
-	netif_addr_unlock_bh(dev);
+	if (ops->ndo_set_rx_mode_async) {
+		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+
+		netif_addr_lock_bh(dev);
+		netif_addr_lists_reconcile(dev, &uc_snap, &mc_snap,
+					   &uc_ref, &mc_ref);
+		netif_addr_unlock_bh(dev);
+	} else if (ops->ndo_set_rx_mode) {
+		netif_addr_lock_bh(dev);
+		ops->ndo_set_rx_mode(dev);
+		netif_addr_unlock_bh(dev);
+	}
 }
 
 static void netdev_rx_mode_work(struct work_struct *work)
@@ -1287,6 +1328,7 @@ static void netif_rx_mode_queue(struct net_device *dev)
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags & IFF_UP))
@@ -1295,20 +1337,16 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_device_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
 		netif_rx_mode_queue(dev);
 		return;
 	}
 
-	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
-		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
-			__dev_set_promiscuity(dev, 1, false);
-			dev->uc_promisc = true;
-		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
-			__dev_set_promiscuity(dev, -1, false);
-			dev->uc_promisc = false;
-		}
-	}
+	/* Legacy path for non-ops-locked HW devices. */
+
+	promisc_inc = netif_uc_promisc_update(dev);
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 
 	if (ops->ndo_set_rx_mode)
 		ops->ndo_set_rx_mode(dev);
-- 
2.53.0


