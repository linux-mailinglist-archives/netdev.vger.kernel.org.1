Return-Path: <netdev+bounces-272533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKCtHeh0xmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:15:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5B3440F3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75982310958D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB939A7F2;
	Fri, 27 Mar 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VBWHct3o"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E485393DF1;
	Fri, 27 Mar 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613483; cv=none; b=cBWQQxNG1hVGhpIh2j+v/38LibiYNISKkMXFGWR7Alx93iGfwPgGJ9De6OchbR9DzmGw1ypR2kBQiCQrLiK3RmZTqvsVR0nRvgsfPrzrTOI/DCHJtkpU8Olwq0Mfp3RZYGArilYTXrFzQ6HudvsmTdI4GEkQnPpI3LIcYV1BKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613483; c=relaxed/simple;
	bh=RVIHuNExM/fSgFwaQ5YydD7R9aGcWqSrXJpTVOj99nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaYZ4nQprCjkx/YiXg9dlTdCWr4iNUvGjR2dpkHMf1cmaOKNTTe4dpLxpEpysOQDx358btludq/YF8+D66DVs1F0zlT89Au3sEFeuvOB2/AnP+tbFkR0wKug2i9/q4pxQVnqFJrh/LImgGm+rcuUcA/xEiGZlZY+JmlP5pagN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VBWHct3o; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DdDAD24m3+OkNXKExlQoK94iuAQ4w+JeU1/OlaU15dY=; b=VBWHct3ozpdbz6VhRODCKP4jJW
	CWnRZGg5LxHbIEZNifZoRXBh6GfLIA2iL/zs5sLZid8uUmiR3ly8nSEKC7IcBRA2HZ7ukF9brZe+K
	jMO719fegM5YVq3w2uG93j+duMh/oVBP9p6GhAEcFlog84YwbDUakicM1R/h7JxgAy0QBXH3aDU83
	VDJ0Xm/BPtn47tpFIf7ceKjvyRF99z6rvaRFrBhANjgwY5WYCsClsiIaF7Z9SX8QdOJcOxK15VMi4
	9so0rbY/tTxrV9ns5rNWRVj2CbVVk+B8c8oylM1duzC8R2BRyFI1MS8Rb0RB9GzYK2cp9FV1LeIcS
	zr5VjRUg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w661i-000ANF-2x;
	Fri, 27 Mar 2026 13:10:58 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v10 06/14] net: Proxy netif_mp_{open,close}_rxq for leased queues
Date: Fri, 27 Mar 2026 13:10:41 +0100
Message-ID: <20260327121049.334562-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327121049.334562-1-daniel@iogearbox.net>
References: <20260327121049.334562-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27953/Fri Mar 27 07:24:46 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272533-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid]
X-Rspamd-Queue-Id: CAC5B3440F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Wei <dw@davidwei.uk>

When a process in a container wants to setup a memory provider, it will
use the virtual netdev and a leased rxq, and call netif_mp_{open,close}_rxq
to try and restart the queue. At this point, proxy the queue restart on
the real rxq in the physical netdev.

For memory providers (io_uring zero-copy rx and devmem), it causes the
real rxq in the physical netdev to be filled from a memory provider that
has DMA mapped memory from a process within a container.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/dev.h             |  2 +
 net/core/netdev_rx_queue.c | 93 +++++++++++++++++++++++++++++++-------
 2 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 6516ce2b5517..bf09a536adb5 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -101,6 +101,8 @@ int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
 bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
 bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
 
+void netif_rxq_cleanup_phys_lease(struct netdev_rx_queue *rxq);
+
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
 	struct hlist_node hlist;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 06ac3bd5507f..1f4c28273c70 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -31,6 +31,7 @@ void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
 	WRITE_ONCE(rxq_src->lease, NULL);
 	WRITE_ONCE(rxq_dst->lease, NULL);
 
+	netif_rxq_cleanup_phys_lease(rxq_src);
 	netdev_put(rxq_src->dev, &rxq_src->lease_tracker);
 }
 
@@ -200,24 +201,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
-int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
-		      const struct pp_memory_provider_params *p,
-		      struct netlink_ext_ack *extack)
+static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+			       const struct pp_memory_provider_params *p,
+			       struct netlink_ext_ack *extack)
 {
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int ret;
 
-	if (!netdev_need_ops_lock(dev))
-		return -EOPNOTSUPP;
-
-	if (rxq_idx >= dev->real_num_rx_queues) {
-		NL_SET_ERR_MSG(extack, "rx queue index out of range");
-		return -ERANGE;
-	}
-	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
-
 	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
 		return -EINVAL;
@@ -264,16 +256,48 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
-			const struct pp_memory_provider_params *old_p)
+int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		      const struct pp_memory_provider_params *p,
+		      struct netlink_ext_ack *extack)
+{
+	struct net_device *orig_dev = dev;
+	int ret;
+
+	if (!netdev_need_ops_lock(dev))
+		return -EOPNOTSUPP;
+
+	if (rxq_idx >= dev->real_num_rx_queues) {
+		NL_SET_ERR_MSG(extack, "rx queue index out of range");
+		return -ERANGE;
+	}
+	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
+
+	if (!netif_rxq_is_leased(dev, rxq_idx))
+		return __netif_mp_open_rxq(dev, rxq_idx, p, extack);
+
+	if (!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)) {
+		NL_SET_ERR_MSG(extack, "rx queue leased to a virtual netdev");
+		return -EBUSY;
+	}
+	if (!dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "rx queue belongs to a virtual netdev");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = __netif_mp_open_rxq(dev, rxq_idx, p, extack);
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return ret;
+}
+
+static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+				 const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int err;
 
-	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
-		return;
-
 	rxq = __netif_get_rx_queue(dev, ifq_idx);
 
 	/* Callers holding a netdev ref may get here after we already
@@ -294,3 +318,38 @@ void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
 	WARN_ON(err && err != -ENETDOWN);
 }
+
+void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+			const struct pp_memory_provider_params *old_p)
+{
+	struct net_device *orig_dev = dev;
+
+	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+		return;
+	if (!netif_rxq_is_leased(dev, ifq_idx))
+		return __netif_mp_close_rxq(dev, ifq_idx, old_p);
+
+	if (WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &ifq_idx)))
+		return;
+
+	__netif_mp_close_rxq(dev, ifq_idx, old_p);
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+}
+
+void netif_rxq_cleanup_phys_lease(struct netdev_rx_queue *rxq)
+{
+	/* If a memory provider was installed on the physical queue via
+	 * the lease, close it now. The memory provider is a property of
+	 * the queue itself, and it was guaranteed to be installed on the
+	 * physical queue via the lease redirection.
+	 *
+	 * After the lease pointers are NULL'ed, netif_mp_close_rxq() can
+	 * no longer follow the lease to reach the physical queue. The
+	 * physical device is still running, so the queue is reconfigured
+	 * to replace the memory provider's page pool with a default one.
+	 */
+	if (rxq->mp_params.mp_ops)
+		__netif_mp_close_rxq(rxq->dev,
+				     get_netdev_rx_queue_index(rxq),
+				     &rxq->mp_params);
+}
-- 
2.43.0


