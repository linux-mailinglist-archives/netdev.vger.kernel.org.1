Return-Path: <netdev+bounces-269061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEZpGpfAumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:11:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E12BDECC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A003320C996
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC03DFC8E;
	Wed, 18 Mar 2026 15:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6B3E0233
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846198; cv=none; b=rWqvTltf+hd2PMXPqs5MXq1/YgYji69NQ6C/56+NK8YvVKtJaiWicFXnxbxP6kS9dbbgvGXGh7uriJbddVuobEqHS8MIeJ3KKCWCpsqXZL5EVZKaZHQDXSXcVvgBh6mzPIDtoZkaxaMxqgagu1XBwbjY2SeEcG6xKp00ku5ApEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846198; c=relaxed/simple;
	bh=WStRe1/0Wz+hf4gR4e3RW1oufmmkSS+wZ/H5+uXCgV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPiLdbu4NpmEy1fQq5jwpEpVuQqtnGszc6Wd6J9ABbvmkEfYlnN7xU0XhoNPDD9PlVrxlTh7hbsstMdOdzPfpALN09FjibO55jcBG4PI3/4ywzwvD8fRWR7Y9DfwEG53Ne9bUtP6I0rBgYix8DssXDBjTICH+VqURrAMo95DR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1279eced0b9so9853424c88.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846192; x=1774450992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iTqzBOwdX4uC4eD+hYEJXSIIw+hEOfHwxGCB1JltZQ=;
        b=K+r+Zc89L6Agusaz7ooKqIPCX1ZUQpZPAO4TixrjZUyq1LYisiiex6Qn/UucEoGvLl
         CqkJcrFV/OUCbEMGUcA0bQ92Qenqai1eQuY9luDQhW6U9xOiRa02KSPXO81/K2X/bg6O
         gX4UKEXmnwKziRo6pJXopFDYOz738M16lDhJ6Bho+2api5hCfTAH2i6zXLtScDtFOG23
         gRltTwkXQ8i+omYCOSiUhgsnn3DowmM1vgziag1TnKeKsdN/FS8pp2fYOOt/qum07lJw
         FhzAf6F3WQo/BNqehoSV7Lj+2vXB205XTYDwxqEWmb0dTlniG0RG9TP4DHvKJoUUPuxT
         Nkmg==
X-Gm-Message-State: AOJu0YxmqRkMg3gngVNTSxMZ933xqh4aV6S3DFOCTDyKkXCepK9Qac/A
	SeQAd52TAM10Kucr/kyalEaO2Kb0nIIRtrmtc3jL10KD88sJyIvlLQYxWZoz
X-Gm-Gg: ATEYQzxbflc+tzuiXnK3lTvHRntZiQkeWW6f/DbvGmkpWMfMTyu6/SjH6kx500ZthKn
	fJ/8mK0HklI161devWhi5pRyK6tOZUX40GBzk60PZJ7Asdzk81NmFQMiZdG6IKWJ1mcZbcXKCpv
	VVqWWEsbgNxhzcIFiG2oAa52h0xQSONUCZvDYoRO3BHb2kwmCQkuYcPNJXf82L9dKRM6970Dah0
	3HGo7uUlCvg0whfJNzs+sZX+GnFqbHCFdIX/tS93uDgTyvg+nu6v1UVBgpKjWG1k0qBcRr2SbJe
	2CKXoAtde0lktR7+BzKwgIQ/8MwYWmlNZyf6Y5pMwcT9rYXTSsSlrdP9EW0Z+5Eim4IC6QTkFCz
	3fddjLVwXvesBPz8VqSNr7+MtgxrzLGOlr3XPQT/KF0wL1Pk6xbsc/o9lQgjGWPNllCSocSWC8C
	LTpXrPdn5ZXbtHV0MvkJaKniFWeG8WFEfUzn4AxLLBhJeq3sFpisllMUyqpft614tb1nx5mADFH
	KjouM4XQezifuEtgw==
X-Received: by 2002:a05:7022:30b:b0:123:345b:ba05 with SMTP id a92af1059eb24-129a7147911mr1815897c88.22.1773846191975;
        Wed, 18 Mar 2026 08:03:11 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129a723f9d7sm3590178c88.2.2026.03.18.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 03/13] net: introduce ndo_set_rx_mode_async and dev_rx_mode_work
Date: Wed, 18 Mar 2026 08:02:55 -0700
Message-ID: <20260318150305.123900-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269061-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.111];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: DD5E12BDECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ndo_set_rx_mode_async callback that drivers can implement instead
of the legacy ndo_set_rx_mode. The legacy callback runs under the
netif_addr_lock spinlock with BHs disabled, preventing drivers from
sleeping. The async variant runs from a work queue with rtnl_lock and
netdev_lock_ops held, in fully sleepable context.

When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
dev_rx_mode_work instead of calling the driver inline. The work
function takes two snapshots of each address list (uc/mc) under
the addr_lock, then drops the lock and calls the driver with the
work copies. After the driver returns, it reconciles the snapshots
back to the real lists under the lock.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |  8 +++
 include/linux/netdevice.h               | 20 ++++++
 net/core/dev.c                          | 94 +++++++++++++++++++++++--
 3 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 35704d115312..dc83d78d3b27 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -289,6 +289,14 @@ struct net_device synchronization rules
 ndo_set_rx_mode:
 	Synchronization: netif_addr_lock spinlock.
 	Context: BHs disabled
+	Notes: Deprecated in favor of sleepable ndo_set_rx_mode_async.
+
+ndo_set_rx_mode_async:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+	Context: process (from a work queue)
+	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
+	of the unicast and multicast address lists.
 
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 469b7cdb3237..7ede1f56bd70 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1117,6 +1117,16 @@ struct netdev_net_notifier {
  *	This function is called device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
  *	IFF_UNICAST_FLT in its priv_flags.
+ *	Cannot sleep, called with netif_addr_lock_bh held.
+ *	Deprecated in favor of sleepable ndo_set_rx_mode_async.
+ *
+ * void (*ndo_set_rx_mode_async)(struct net_device *dev,
+ *				  struct netdev_hw_addr_list *uc,
+ *				  struct netdev_hw_addr_list *mc);
+ *	Sleepable version of ndo_set_rx_mode. Called from a work queue
+ *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
+ *	are snapshots of the address lists - iterate with
+ *	netdev_hw_addr_list_for_each(ha, uc).
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1437,6 +1447,9 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_set_rx_mode_async)(struct net_device *dev,
+					struct netdev_hw_addr_list *uc,
+					struct netdev_hw_addr_list *mc);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1903,6 +1916,7 @@ enum netdev_reg_state {
  *				has been enabled due to the need to listen to
  *				additional unicast addresses in a device that
  *				does not implement ndo_set_rx_mode()
+ *	@rx_mode_work:		Work queue entry for ndo_set_rx_mode_async()
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2293,6 +2307,7 @@ struct net_device {
 	unsigned int		promiscuity;
 	unsigned int		allmulti;
 	bool			uc_promisc;
+	struct work_struct	rx_mode_work;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
@@ -4661,6 +4676,11 @@ static inline bool netif_device_present(const struct net_device *dev)
 	return test_bit(__LINK_STATE_PRESENT, &dev->state);
 }
 
+static inline bool netif_up_and_present(const struct net_device *dev)
+{
+	return (dev->flags & IFF_UP) && netif_device_present(dev);
+}
+
 void netif_device_detach(struct net_device *dev);
 
 void netif_device_attach(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..77fdbe836754 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2381,6 +2381,8 @@ static void netstamp_clear(struct work_struct *work)
 static DECLARE_WORK(netstamp_work, netstamp_clear);
 #endif
 
+static struct workqueue_struct *rx_mode_wq;
+
 void net_enable_timestamp(void)
 {
 #ifdef CONFIG_JUMP_LABEL
@@ -9669,22 +9671,83 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
-/*
- *	Upload unicast and multicast address lists to device and
- *	configure RX filtering. When the device doesn't support unicast
- *	filtering it is put in promiscuous mode while unicast addresses
- *	are present.
+static void dev_rx_mode_work(struct work_struct *work)
+{
+	struct net_device *dev = container_of(work, struct net_device,
+					      rx_mode_work);
+	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
+
+	__hw_addr_init(&uc_snap);
+	__hw_addr_init(&mc_snap);
+	__hw_addr_init(&uc_ref);
+	__hw_addr_init(&mc_ref);
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+
+	if (!netif_up_and_present(dev))
+		goto out;
+
+	if (ops->ndo_set_rx_mode_async) {
+		netif_addr_lock_bh(dev);
+
+		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
+					      dev->addr_len);
+		if (!err)
+			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
+						      dev->addr_len);
+		if (!err)
+			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
+						      dev->addr_len);
+		if (!err)
+			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
+						      dev->addr_len);
+		netif_addr_unlock_bh(dev);
+
+		if (err) {
+			__hw_addr_flush(&uc_snap);
+			__hw_addr_flush(&uc_ref);
+			__hw_addr_flush(&mc_snap);
+			goto out;
+		}
+
+		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+
+		netif_addr_lock_bh(dev);
+		__hw_addr_list_reconcile(&dev->uc, &uc_snap,
+					 &uc_ref, dev->addr_len);
+		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
+					 &mc_ref, dev->addr_len);
+		netif_addr_unlock_bh(dev);
+	}
+
+out:
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+}
+
+/**
+ * __dev_set_rx_mode() - upload unicast and multicast address lists to device
+ * and configure RX filtering.
+ * @dev: device
+ *
+ * When the device doesn't support unicast filtering it is put in promiscuous
+ * mode while unicast addresses are present.
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
 	/* dev_open will call this function so the list will stay sane. */
-	if (!(dev->flags&IFF_UP))
+	if (!netif_up_and_present(dev))
 		return;
 
-	if (!netif_device_present(dev))
+	if (ops->ndo_set_rx_mode_async) {
+		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
+	}
 
 	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
 		/* Unicast addresses changes may only happen under the rtnl,
@@ -11708,6 +11771,16 @@ void netdev_run_todo(void)
 
 	__rtnl_unlock();
 
+	/* Make sure all pending rx_mode work completes before returning.
+	 *
+	 * rx_mode_wq may be NULL during early boot:
+	 * core_initcall(netlink_proto_init) vs subsys_initcall(net_dev_init).
+	 *
+	 * Check current_work() to avoid flushing from the wq.
+	 */
+	if (rx_mode_wq && !current_work())
+		flush_workqueue(rx_mode_wq);
+
 	/* Wait for rcu callbacks to finish before next phase */
 	if (!list_empty(&list))
 		rcu_barrier();
@@ -12099,6 +12172,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #endif
 
 	mutex_init(&dev->lock);
+	INIT_WORK(&dev->rx_mode_work, dev_rx_mode_work);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
@@ -12203,6 +12277,8 @@ void free_netdev(struct net_device *dev)
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
+	cancel_work_sync(&dev->rx_mode_work);
+
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
@@ -13296,6 +13372,10 @@ static int __init net_dev_init(void)
 	if (register_pernet_device(&default_device_ops))
 		goto out;
 
+	rx_mode_wq = alloc_ordered_workqueue("rx_mode_wq", 0);
+	if (!rx_mode_wq)
+		goto out;
+
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
 	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 
-- 
2.53.0


