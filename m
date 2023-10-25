Return-Path: <netdev+bounces-44067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF67D5F7B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D13B21100
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB317C6;
	Wed, 25 Oct 2023 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxsDZuQO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF1185C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:24:28 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3A10D1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da04fb79246so1128133276.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698197066; x=1698801866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Aw/d6I8OKCWOd/jVoybOcrJguchnezsTqQIl28LXg=;
        b=XxsDZuQOXKfx5XEwkrSWcESoZBXkEyt1Ah8zl1IysnpKIb3xUB0y/IPcUKsn6QmhU4
         uWJ0VWwwJ64x73C/mmeeIoirY11fgYFKq5gHpNYOVqEuZm3QIercWLgMbBVBfN02WGto
         TuPnOpJQEO1cpsPPE0VGR4fDFqQCqyoFASHRgEQ6+yjlCxxHJ+MzWvUjYHw48oP30Fzr
         ptlKT7IanB7bOk/HS94y+wqnCoskYRibRtAe3S1W5oqW8FQOQa6LT3/1HLx1oCKsbBIV
         FK3DerH2XybLZaIbOKw3CQ2FOEqmk3bH97WVWSC/JE3/0aFj6ZA9YGhqFNsfCsuG8VCE
         8Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698197066; x=1698801866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Aw/d6I8OKCWOd/jVoybOcrJguchnezsTqQIl28LXg=;
        b=ATQIVSCS1A94KgIBdHR9QHKWP4MGmiVU/vhngnGXIEwXUu9uKwxiEkQN1di+k4uzM7
         YQyMppI5CC8Fme/wkLmhGC9u8LVuH3m7u+xeDtx+QMwewVbILkk0OXGwPAlTvqJATg+W
         qnnvrXKZKKnDSfVgOXMI2ofGI5eKBzOFPmagr/MSew3lOexBB0nbfKEE+VaO7HccT24O
         /B6wB2EBAHyOdFxi3La/iDyhjgih77U1fo40KF/eNwLa0kQSoQU7OOQwI2+XSiMT1ian
         Ay7q4QDng5hUB3qau0gADgGtqtmRX+6NaDlWWr2xtkvmOcHYZGOGJHuBqmX2eRqeLcdi
         P8TQ==
X-Gm-Message-State: AOJu0YyI9xwnSsLfYX5VKoRPWwNmNeKFaUcKZxrazZwsr3T59KBINNA6
	a90KkfcwuROBY59LsDC+tcocGSPd6fZVQPE=
X-Google-Smtp-Source: AGHT+IHe9IlUJeBAChXUWlHOjo4oUKCG2NDHjaOzseM4oFpTnMeNsK1oKsaYSFo5PaqomBXwZ7uBSlphjl2AfOw=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:aaa9:0:b0:d9a:3a14:a5a2 with SMTP id
 t38-20020a25aaa9000000b00d9a3a14a5a2mr254200ybi.13.1698197065717; Tue, 24 Oct
 2023 18:24:25 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:24:10 +0000
In-Reply-To: <20231025012411.2096053-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025012411.2096053-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025012411.2096053-6-lixiaoyan@google.com>
Subject: [PATCH v3 net-next 5/6] net-device: reorganize net_device fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reorganize fast path variables on tx-txrx-rx order
Fastpath variables end after npinfo.

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 4

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/linux/netdevice.h | 101 ++++++++++++++++++++------------------
 net/core/dev.c            |  45 +++++++++++++++++
 2 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b8bf669212cce..d4a8c42d9a9aa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2076,6 +2076,60 @@ enum netdev_ml_priv_type {
  */
 
 struct net_device {
+	/* Caacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/net_device.rst.
+	 * Please update the document when adding new fields.
+	 */
+
+	/* TX read-mostly hotpath */
+	__cacheline_group_begin(net_device_read);
+	unsigned long long	priv_flags;
+	const struct net_device_ops *netdev_ops;
+	const struct header_ops *header_ops;
+	struct netdev_queue	*_tx;
+	unsigned int		real_num_tx_queues;
+	unsigned int		gso_max_size;
+	unsigned int		gso_ipv4_max_size;
+	u16			gso_max_segs;
+	s16			num_tc;
+	/* Note : dev->mtu is often read without holding a lock.
+	 * Writers usually hold RTNL.
+	 * It is recommended to use READ_ONCE() to annotate the reads,
+	 * and to use WRITE_ONCE() to annotate the writes.
+	 */
+	unsigned int		mtu;
+	unsigned short		needed_headroom;
+	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
+#ifdef CONFIG_XPS
+	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
+#endif
+#ifdef CONFIG_NETFILTER_EGRESS
+	struct nf_hook_entries __rcu *nf_hooks_egress;
+#endif
+
+	/* TXRX read-mostly hotpath */
+	unsigned int		flags;
+	unsigned short		hard_header_len;
+	netdev_features_t	features;
+	struct inet6_dev __rcu	*ip6_ptr;
+
+	/* RX read-mostly hotpath */
+	struct list_head	ptype_specific;
+	int			ifindex;
+	unsigned int		real_num_rx_queues;
+	struct netdev_rx_queue	*_rx;
+	unsigned long		gro_flush_timeout;
+	int			napi_defer_hard_irqs;
+	unsigned int		gro_max_size;
+	unsigned int		gro_ipv4_max_size;
+	rx_handler_func_t __rcu	*rx_handler;
+	void __rcu		*rx_handler_data;
+	possible_net_t			nd_net;
+#ifdef CONFIG_NETPOLL
+	struct netpoll_info __rcu	*npinfo;
+#endif
+	__cacheline_group_end(net_device_read);
+
 	char			name[IFNAMSIZ];
 	struct netdev_name_node	*name_node;
 	struct dev_ifalias	__rcu *ifalias;
@@ -2100,7 +2154,6 @@ struct net_device {
 	struct list_head	unreg_list;
 	struct list_head	close_list;
 	struct list_head	ptype_all;
-	struct list_head	ptype_specific;
 
 	struct {
 		struct list_head upper;
@@ -2108,25 +2161,12 @@ struct net_device {
 	} adj_list;
 
 	/* Read-mostly cache-line for fast-path access */
-	unsigned int		flags;
 	xdp_features_t		xdp_features;
-	unsigned long long	priv_flags;
-	const struct net_device_ops *netdev_ops;
 	const struct xdp_metadata_ops *xdp_metadata_ops;
-	int			ifindex;
 	unsigned short		gflags;
-	unsigned short		hard_header_len;
 
-	/* Note : dev->mtu is often read without holding a lock.
-	 * Writers usually hold RTNL.
-	 * It is recommended to use READ_ONCE() to annotate the reads,
-	 * and to use WRITE_ONCE() to annotate the writes.
-	 */
-	unsigned int		mtu;
-	unsigned short		needed_headroom;
 	unsigned short		needed_tailroom;
 
-	netdev_features_t	features;
 	netdev_features_t	hw_features;
 	netdev_features_t	wanted_features;
 	netdev_features_t	vlan_features;
@@ -2170,8 +2210,6 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
-	const struct header_ops *header_ops;
-
 	unsigned char		operstate;
 	unsigned char		link_mode;
 
@@ -2212,9 +2250,7 @@ struct net_device {
 
 
 	/* Protocol-specific pointers */
-
 	struct in_device __rcu	*ip_ptr;
-	struct inet6_dev __rcu	*ip6_ptr;
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	struct vlan_info __rcu	*vlan_info;
 #endif
@@ -2249,23 +2285,14 @@ struct net_device {
 	/* Interface address info used in eth_type_trans() */
 	const unsigned char	*dev_addr;
 
-	struct netdev_rx_queue	*_rx;
 	unsigned int		num_rx_queues;
-	unsigned int		real_num_rx_queues;
-
 	struct bpf_prog __rcu	*xdp_prog;
-	unsigned long		gro_flush_timeout;
-	int			napi_defer_hard_irqs;
 #define GRO_LEGACY_MAX_SIZE	65536u
 /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
  * and shinfo->gso_segs is a 16bit field.
  */
 #define GRO_MAX_SIZE		(8 * 65535u)
-	unsigned int		gro_max_size;
-	unsigned int		gro_ipv4_max_size;
 	unsigned int		xdp_zc_max_segs;
-	rx_handler_func_t __rcu	*rx_handler;
-	void __rcu		*rx_handler_data;
 #ifdef CONFIG_NET_XGRESS
 	struct bpf_mprog_entry __rcu *tcx_ingress;
 #endif
@@ -2283,24 +2310,15 @@ struct net_device {
 /*
  * Cache lines mostly used on transmit path
  */
-	struct netdev_queue	*_tx ____cacheline_aligned_in_smp;
 	unsigned int		num_tx_queues;
-	unsigned int		real_num_tx_queues;
 	struct Qdisc __rcu	*qdisc;
 	unsigned int		tx_queue_len;
 	spinlock_t		tx_global_lock;
 
 	struct xdp_dev_bulk_queue __percpu *xdp_bulkq;
-
-#ifdef CONFIG_XPS
-	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
-#endif
 #ifdef CONFIG_NET_XGRESS
 	struct bpf_mprog_entry __rcu *tcx_egress;
 #endif
-#ifdef CONFIG_NETFILTER_EGRESS
-	struct nf_hook_entries __rcu *nf_hooks_egress;
-#endif
 
 #ifdef CONFIG_NET_SCHED
 	DECLARE_HASHTABLE	(qdisc_hash, 4);
@@ -2340,12 +2358,6 @@ struct net_device {
 	bool needs_free_netdev;
 	void (*priv_destructor)(struct net_device *dev);
 
-#ifdef CONFIG_NETPOLL
-	struct netpoll_info __rcu	*npinfo;
-#endif
-
-	possible_net_t			nd_net;
-
 	/* mid-layer private */
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
@@ -2379,20 +2391,15 @@ struct net_device {
  */
 #define GSO_MAX_SIZE		(8 * GSO_MAX_SEGS)
 
-	unsigned int		gso_max_size;
 #define TSO_LEGACY_MAX_SIZE	65536
 #define TSO_MAX_SIZE		UINT_MAX
 	unsigned int		tso_max_size;
-	u16			gso_max_segs;
 #define TSO_MAX_SEGS		U16_MAX
 	u16			tso_max_segs;
-	unsigned int		gso_ipv4_max_size;
 
 #ifdef CONFIG_DCB
 	const struct dcbnl_rtnl_ops *dcbnl_ops;
 #endif
-	s16			num_tc;
-	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
 	u8			prio_tc_map[TC_BITMASK + 1];
 
 #if IS_ENABLED(CONFIG_FCOE)
diff --git a/net/core/dev.c b/net/core/dev.c
index a37a932a3e145..6e82feede0d95 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11511,6 +11511,49 @@ static struct pernet_operations __net_initdata default_device_ops = {
 	.exit_batch = default_device_exit_batch,
 };
 
+static void __init net_dev_struct_check(void)
+{
+	/* TX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, priv_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, netdev_ops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, header_ops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, _tx);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, real_num_tx_queues);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, gso_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, gso_ipv4_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, gso_max_segs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, num_tc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, mtu);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, needed_headroom);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, tc_to_txq);
+#ifdef CONFIG_XPS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, xps_maps);
+#endif
+#ifdef CONFIG_NETFILTER_EGRESS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, nf_hooks_egress);
+#endif
+	/* TXRX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, hard_header_len);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, features);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, ip6_ptr);
+	/* RX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, ptype_specific);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, ifindex);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, real_num_rx_queues);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, _rx);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, gro_flush_timeout);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, napi_defer_hard_irqs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, gro_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, gro_ipv4_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, rx_handler);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, rx_handler_data);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, nd_net);
+#ifdef CONFIG_NETPOLL
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read, npinfo);
+#endif
+}
+
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
  *	unhooks any devices that fail to initialise (normally hardware not
@@ -11528,6 +11571,8 @@ static int __init net_dev_init(void)
 
 	BUG_ON(!dev_boot_phase);
 
+	net_dev_struct_check();
+
 	if (dev_proc_init())
 		goto out;
 
-- 
2.42.0.758.gaed0368e0e-goog


