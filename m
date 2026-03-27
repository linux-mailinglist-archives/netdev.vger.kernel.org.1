Return-Path: <netdev+bounces-272529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKu3Fwx0xmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:11:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F72344035
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B698302B817
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C3396588;
	Fri, 27 Mar 2026 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a6x6gIJT"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDF393DC2;
	Fri, 27 Mar 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613481; cv=none; b=h8p1SJYefZfMDb9Hs+IKqOd3FmQcC965x0tiGjEkJlzX9Wzsj9StpED63dsbu5qaew1QSqT6GxOvaOfn8k63XTQ6AR86bt1z1Af9aKNJbmb9xUVgMGUYFcD/fFK1c3INbuiLwjJcomS205Y+SYaJsoL5vGMP4NfE0vAvFJ3rd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613481; c=relaxed/simple;
	bh=bpQ6y/65bHZT32ea2Gn7Ea1p+jdudmwG5Mt9iE0TMME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IssZdlkyp8/r1mPIYKp85LNF9JB3DS2n7UCDwvyMuhuIKioNQEz7av0IIC5E0P/iaa8jrV1K62OXcbsIp9ByjxvCHeHiZm9oSLpGfP13c9BGni26wceYLNgUKABxe4X5D5jbohy2351XXv1bjDoHaEgYd+JCpLud75gBtlJr0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a6x6gIJT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IwH/LR7y4a6c9+RlTfVV0oAnXYJvj4vcOOSUu0MiP+w=; b=a6x6gIJTWLp5jmvg7kqM06y9bq
	vSd+zzqnT60sImX7/AjiVsvHtCMsSMEKVE5YZq0tFB39e8/Rk1dRYZhf75tuDfFxaRzmiPY6oH+sB
	IUD33M/TAxVVgl2iQSI4hYMHgpATeTiSIA9S5AVsztssl3ltBqqEtmrRo8F6zz3PT8gBJ9LHiAQDh
	dfr4hwSR3NkCblJBo55uqTVBRXmGhu08WqeeZmzaFuOImt841d/lcd4J4NvklkpJv6SQkK09baciN
	xeSB5tN0msoiT61U2STyuG3jwXIcLdT5Zy06j5cFktLRb3C84FXDq/AcG8uK56VejlzjE+oO+9FN9
	I7w9Jazg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w661e-000AMP-0k;
	Fri, 27 Mar 2026 13:10:54 +0100
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
Subject: [PATCH net-next v10 02/14] net: Implement netdev_nl_queue_create_doit
Date: Fri, 27 Mar 2026 13:10:37 +0100
Message-ID: <20260327121049.334562-3-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272529-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei.uk:email]
X-Rspamd-Queue-Id: A6F72344035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement netdev_nl_queue_create_doit which creates a new rx queue in a
virtual netdev and then leases it to a rx queue in a physical netdev.

Example with ynl client:

  # ynl --family netdev --output-json --do queue-create \
        --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
  {'id': 1}

Note that the netdevice locking order is always from the virtual to
the physical device.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 Documentation/networking/netdevices.rst |   6 +
 include/linux/netdevice.h               |   9 +-
 include/net/netdev_queues.h             |  19 ++-
 include/net/netdev_rx_queue.h           |  15 ++-
 include/net/xdp_sock_drv.h              |   2 +-
 net/core/dev.c                          |   8 ++
 net/core/dev.h                          |   5 +
 net/core/netdev-genl.c                  | 164 +++++++++++++++++++++++-
 net/core/netdev_queues.c                |  62 +++++++++
 net/core/netdev_rx_queue.c              |  46 ++++++-
 net/xdp/xsk.c                           |   2 +-
 11 files changed, 325 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 35704d115312..83e28b96884f 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -329,6 +329,12 @@ by setting ``request_ops_lock`` to true. Code comments and docs refer
 to drivers which have ops called under the instance lock as "ops locked".
 See also the documentation of the ``lock`` member of struct net_device.
 
+There is also a case of taking two per-netdev locks in sequence when netdev
+queues are leased, that is, the netdev-scope lock is taken for both the
+virtual and the physical device. To prevent deadlocks, the virtual device's
+lock must always be acquired before the physical device's (see
+``netdev_nl_queue_create_doit``).
+
 In the future, there will be an option for individual
 drivers to opt out of using ``rtnl_lock`` and instead perform their control
 operations directly under the netdev instance lock.
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e15367373f7c..e8aa9cc4075d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2561,7 +2561,14 @@ struct net_device {
 	 * Also protects some fields in:
 	 *	struct napi_struct, struct netdev_queue, struct netdev_rx_queue
 	 *
-	 * Ordering: take after rtnl_lock.
+	 * Ordering:
+	 *
+	 * - take after rtnl_lock
+	 *
+	 * - for the case of netdev queue leasing, the netdev-scope lock is
+	 *   taken for both the virtual and the physical device; to prevent
+	 *   deadlocks, the virtual device's lock must always be acquired
+	 *   before the physical device's (see netdev_nl_queue_create_doit)
 	 */
 	struct mutex		lock;
 
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 95ed28212f4e..748b70552ed1 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -150,6 +150,11 @@ enum {
  *			When NIC-wide config is changed the callback will
  *			be invoked for all queues.
  *
+ * @ndo_queue_create:	Create a new RX queue on a virtual device that will
+ *			be paired with a physical device's queue via leasing.
+ *			Return the new queue id on success, negative error
+ *			on failure.
+ *
  * @supported_params:	Bitmask of supported parameters, see QCFG_*.
  *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
@@ -178,6 +183,8 @@ struct netdev_queue_mgmt_ops {
 				     struct netlink_ext_ack *extack);
 	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
 						 int idx);
+	int	(*ndo_queue_create)(struct net_device *dev,
+				    struct netlink_ext_ack *extack);
 
 	unsigned int supported_params;
 };
@@ -185,7 +192,7 @@ struct netdev_queue_mgmt_ops {
 void netdev_queue_config(struct net_device *dev, int rxq,
 			 struct netdev_queue_config *qcfg);
 
-bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
+bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx);
 
 /**
  * DOC: Lockless queue stopping / waking helpers.
@@ -374,5 +381,11 @@ static inline unsigned int netif_xmit_timeout_ms(struct netdev_queue *txq)
 	})
 
 struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
-
-#endif
+bool netdev_can_create_queue(const struct net_device *dev,
+			     struct netlink_ext_ack *extack);
+bool netdev_can_lease_queue(const struct net_device *dev,
+			    struct netlink_ext_ack *extack);
+bool netdev_queue_busy(struct net_device *dev, unsigned int idx,
+		       enum netdev_queue_type type,
+		       struct netlink_ext_ack *extack);
+#endif /* _LINUX_NET_QUEUES_H */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 08f81329fc11..1d41c253f0a3 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -31,6 +31,14 @@ struct netdev_rx_queue {
 	struct napi_struct		*napi;
 	struct netdev_queue_config	qcfg;
 	struct pp_memory_provider_params mp_params;
+
+	/* If a queue is leased, then the lease pointer is always
+	 * valid. From the physical device it points to the virtual
+	 * queue, and from the virtual device it points to the
+	 * physical queue.
+	 */
+	struct netdev_rx_queue		*lease;
+	netdevice_tracker		lease_tracker;
 } ____cacheline_aligned_in_smp;
 
 /*
@@ -60,5 +68,8 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 }
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
-
-#endif
+void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
+			   struct netdev_rx_queue *rxq_src);
+void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
+			     struct netdev_rx_queue *rxq_src);
+#endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..06d4609b6ebd 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -28,7 +28,7 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
-struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
+struct xsk_buff_pool *xsk_get_pool_from_qid(const struct net_device *dev,
 					    u16 queue_id);
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
diff --git a/net/core/dev.c b/net/core/dev.c
index ae8fe706c486..59b7b86bb171 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1121,6 +1121,14 @@ netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
 	return __netdev_put_lock_ops_compat(dev, net);
 }
 
+struct net_device *
+netdev_put_lock(struct net_device *dev, struct net *net,
+		netdevice_tracker *tracker)
+{
+	netdev_tracker_free(dev, tracker);
+	return __netdev_put_lock(dev, net);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
diff --git a/net/core/dev.h b/net/core/dev.h
index 781619e76b3e..6516ce2b5517 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -31,6 +31,8 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
 struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
+struct net_device *netdev_put_lock(struct net_device *dev, struct net *net,
+				   netdevice_tracker *tracker);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index);
@@ -96,6 +98,9 @@ int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
 				 struct netdev_queue_config *qcfg,
 				 struct netlink_ext_ack *extack);
 
+bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
+bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
+
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
 	struct hlist_node hlist;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index aae75431858d..5d5e5b9a8af0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1122,7 +1122,169 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	const int qmaxtype = ARRAY_SIZE(netdev_queue_id_nl_policy) - 1;
+	const int lmaxtype = ARRAY_SIZE(netdev_lease_nl_policy) - 1;
+	int err, ifindex, ifindex_lease, queue_id, queue_id_lease;
+	struct nlattr *qtb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
+	struct nlattr *ltb[ARRAY_SIZE(netdev_lease_nl_policy)];
+	struct netdev_rx_queue *rxq, *rxq_lease;
+	struct net_device *dev, *dev_lease;
+	netdevice_tracker dev_tracker;
+	s32 netns_lease = -1;
+	struct nlattr *nest;
+	struct sk_buff *rsp;
+	struct net *net;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_LEASE))
+		return -EINVAL;
+	if (nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]) !=
+	    NETDEV_QUEUE_TYPE_RX) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_QUEUE_TYPE]);
+		return -EINVAL;
+	}
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
+
+	nest = info->attrs[NETDEV_A_QUEUE_LEASE];
+	err = nla_parse_nested(ltb, lmaxtype, nest,
+			       netdev_lease_nl_policy, info->extack);
+	if (err < 0)
+		return err;
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_IFINDEX) ||
+	    NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_QUEUE))
+		return -EINVAL;
+	if (ltb[NETDEV_A_LEASE_NETNS_ID]) {
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		netns_lease = nla_get_s32(ltb[NETDEV_A_LEASE_NETNS_ID]);
+	}
+
+	ifindex_lease = nla_get_u32(ltb[NETDEV_A_LEASE_IFINDEX]);
+
+	nest = ltb[NETDEV_A_LEASE_QUEUE];
+	err = nla_parse_nested(qtb, qmaxtype, nest,
+			       netdev_queue_id_nl_policy, info->extack);
+	if (err < 0)
+		return err;
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_TYPE))
+		return -EINVAL;
+	if (nla_get_u32(qtb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
+		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_TYPE]);
+		return -EINVAL;
+	}
+
+	queue_id_lease = nla_get_u32(qtb[NETDEV_A_QUEUE_ID]);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	/* Locking order is always from the virtual to the physical device
+	 * since this is also the same order when applications open the
+	 * memory provider later on.
+	 */
+	dev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	if (!dev) {
+		err = -ENODEV;
+		goto err_genlmsg_free;
+	}
+	if (!netdev_can_create_queue(dev, info->extack)) {
+		err = -EINVAL;
+		goto err_unlock_dev;
+	}
+
+	net = genl_info_net(info);
+	if (netns_lease >= 0) {
+		net = get_net_ns_by_id(net, netns_lease);
+		if (!net) {
+			err = -ENONET;
+			goto err_unlock_dev;
+		}
+	}
+
+	dev_lease = netdev_get_by_index(net, ifindex_lease, &dev_tracker,
+					GFP_KERNEL);
+	if (!dev_lease) {
+		err = -ENODEV;
+		goto err_put_netns;
+	}
+	if (!netdev_can_lease_queue(dev_lease, info->extack)) {
+		netdev_put(dev_lease, &dev_tracker);
+		err = -EINVAL;
+		goto err_put_netns;
+	}
+
+	dev_lease = netdev_put_lock(dev_lease, net, &dev_tracker);
+	if (!dev_lease) {
+		err = -ENODEV;
+		goto err_put_netns;
+	}
+	if (queue_id_lease >= dev_lease->real_num_rx_queues) {
+		err = -ERANGE;
+		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_ID]);
+		goto err_unlock_dev_lease;
+	}
+	if (netdev_queue_busy(dev_lease, queue_id_lease, NETDEV_QUEUE_TYPE_RX,
+			      info->extack)) {
+		err = -EBUSY;
+		goto err_unlock_dev_lease;
+	}
+
+	rxq_lease = __netif_get_rx_queue(dev_lease, queue_id_lease);
+	rxq = __netif_get_rx_queue(dev, dev->real_num_rx_queues - 1);
+
+	/* Leasing queues from different physical devices is currently
+	 * not supported. Capabilities such as XDP features and DMA
+	 * device may differ between physical devices, and computing
+	 * a correct intersection for the virtual device is not yet
+	 * implemented.
+	 */
+	if (rxq->lease && rxq->lease->dev != dev_lease) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Leasing queues from different devices not supported");
+		goto err_unlock_dev_lease;
+	}
+
+	queue_id = dev->queue_mgmt_ops->ndo_queue_create(dev, info->extack);
+	if (queue_id < 0) {
+		err = queue_id;
+		goto err_unlock_dev_lease;
+	}
+	rxq = __netif_get_rx_queue(dev, queue_id);
+
+	netdev_rx_queue_lease(rxq, rxq_lease);
+
+	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
+	genlmsg_end(rsp, hdr);
+
+	netdev_unlock(dev_lease);
+	netdev_unlock(dev);
+	if (netns_lease >= 0)
+		put_net(net);
+
+	return genlmsg_reply(rsp, info);
+
+err_unlock_dev_lease:
+	netdev_unlock(dev_lease);
+err_put_netns:
+	if (netns_lease >= 0)
+		put_net(net);
+err_unlock_dev:
+	netdev_unlock(dev);
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
 }
 
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 251f27a8307f..177401828e79 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
+
+#include "dev.h"
 
 /**
  * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
@@ -25,3 +29,61 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
 	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
 }
 
+bool netdev_can_create_queue(const struct net_device *dev,
+			     struct netlink_ext_ack *extack)
+{
+	if (dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "Device is not a virtual device");
+		return false;
+	}
+	if (!dev->queue_mgmt_ops ||
+	    !dev->queue_mgmt_ops->ndo_queue_create) {
+		NL_SET_ERR_MSG(extack, "Device does not support queue creation");
+		return false;
+	}
+	if (dev->real_num_rx_queues < 1 ||
+	    dev->real_num_tx_queues < 1) {
+		NL_SET_ERR_MSG(extack, "Device must have at least one real queue");
+		return false;
+	}
+	return true;
+}
+
+bool netdev_can_lease_queue(const struct net_device *dev,
+			    struct netlink_ext_ack *extack)
+{
+	if (!dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "Lease device is a virtual device");
+		return false;
+	}
+	if (!netif_device_present(dev)) {
+		NL_SET_ERR_MSG(extack, "Lease device has been removed from the system");
+		return false;
+	}
+	if (!dev->queue_mgmt_ops) {
+		NL_SET_ERR_MSG(extack, "Lease device does not support queue management operations");
+		return false;
+	}
+	return true;
+}
+
+bool netdev_queue_busy(struct net_device *dev, unsigned int idx,
+		       enum netdev_queue_type type,
+		       struct netlink_ext_ack *extack)
+{
+	if (xsk_get_pool_from_qid(dev, idx)) {
+		NL_SET_ERR_MSG(extack, "Device queue in use by AF_XDP");
+		return true;
+	}
+	if (type == NETDEV_QUEUE_TYPE_TX)
+		return false;
+	if (netif_rxq_is_leased(dev, idx)) {
+		NL_SET_ERR_MSG(extack, "Device queue in use due to queue leasing");
+		return true;
+	}
+	if (netif_rxq_has_mp(dev, idx)) {
+		NL_SET_ERR_MSG(extack, "Device queue in use by memory provider");
+		return true;
+	}
+	return false;
+}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 668a90658f25..a1f23c2c96d4 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -10,15 +10,53 @@
 #include "dev.h"
 #include "page_pool_priv.h"
 
-/* See also page_pool_is_unreadable() */
-bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
+void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
+			   struct netdev_rx_queue *rxq_src)
 {
-	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
+	netdev_assert_locked(rxq_src->dev);
+	netdev_assert_locked(rxq_dst->dev);
+
+	netdev_hold(rxq_src->dev, &rxq_src->lease_tracker, GFP_KERNEL);
 
-	return !!rxq->mp_params.mp_ops;
+	WRITE_ONCE(rxq_src->lease, rxq_dst);
+	WRITE_ONCE(rxq_dst->lease, rxq_src);
+}
+
+void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
+			     struct netdev_rx_queue *rxq_src)
+{
+	netdev_assert_locked(rxq_dst->dev);
+	netdev_assert_locked(rxq_src->dev);
+
+	WRITE_ONCE(rxq_src->lease, NULL);
+	WRITE_ONCE(rxq_dst->lease, NULL);
+
+	netdev_put(rxq_src->dev, &rxq_src->lease_tracker);
+}
+
+bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx)
+{
+	if (rxq_idx < dev->real_num_rx_queues)
+		return READ_ONCE(__netif_get_rx_queue(dev, rxq_idx)->lease);
+	return false;
+}
+
+/* See also page_pool_is_unreadable() */
+bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
+{
+	if (rxq_idx < dev->real_num_rx_queues)
+		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
+	return false;
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
+bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx)
+{
+	if (rxq_idx < dev->real_num_rx_queues)
+		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_priv;
+	return false;
+}
+
 static int netdev_rx_queue_reconfig(struct net_device *dev,
 				    unsigned int rxq_idx,
 				    struct netdev_queue_config *qcfg_old,
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..79f31705276f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -103,7 +103,7 @@ bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
 }
 EXPORT_SYMBOL(xsk_uses_need_wakeup);
 
-struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
+struct xsk_buff_pool *xsk_get_pool_from_qid(const struct net_device *dev,
 					    u16 queue_id)
 {
 	if (queue_id < dev->real_num_rx_queues)
-- 
2.43.0


