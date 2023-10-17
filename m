Return-Path: <netdev+bounces-41646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E27CB81C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FA2281681
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E963D1;
	Tue, 17 Oct 2023 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fj5FPjfT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AA523F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:47:31 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A74E6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a4cbdad3fso6652346276.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697507249; x=1698112049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag00SrIeXR+nNdpW1Tvz6qmjaKUViA16AD6fjgXDB4E=;
        b=Fj5FPjfTwcZbe0ZeVV4dPpbCWVCtWo4LUopYtiJkE1okGacmL8X/MIeH1ZLHTXQy3e
         zbqV4cBhxZjXahwva/21vv703fbExObHjiEgAY4IQjRbvnHuL88DSHeFwgRgAL2dhbYv
         i2YpQ017TqnUAlNcpU87g/KmBQbZMN6XMKIT+UD+4aH/YvsVFdaCjNoH2JyPfoA0m3/Q
         8PZYwQfd4LCbTTqhk6/l9HKUeaO7iwg7nGWCRq0PkPNT106XiyjWvzWf/9zck71iEerG
         xYPxRdbw4v9h57zyiFo/lweB8DoC/hYqCiYuD3iempZtrqJuDPyXPT+wMbBAqCYYWsT6
         b1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697507249; x=1698112049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag00SrIeXR+nNdpW1Tvz6qmjaKUViA16AD6fjgXDB4E=;
        b=kmOof371+QgLSTPSMa/wxH4RglW+BvmebddJXt5+Aulz73imosaV1dei8DtKpsmwNb
         +Yb3nhdwYc48+Y2DceZrY/6PrLT4N5VFpSoR7+ZEE2ajNiSMlqF4KNw/NfDbvrd6NMp1
         nuO8sz4hEu5sSAXPFJPMc0IsGDYxQX6CxusY8RhyuApUTyczby/CASbminwL7+w3BN3E
         3dpzFxWOWndjLr6V1kz2lPdc/vBk889565Y4dIDfSWFfJfshX4rX9BB78xI1aF8LQ7YY
         y2wZIIZ3UGo9UmQjwOHABflE1jz66Onad701Z3xcwurP/IA5ownh8MnKTKkK5UKcVX1A
         pRuA==
X-Gm-Message-State: AOJu0Yx071EOV0/Gg6TgHXvyn7lHz3AlenxCbLj3w23YqoLB1OwUfmzI
	71SwV6BKwfNdGa2MjCQNnHTS0jL2MmR0pEg=
X-Google-Smtp-Source: AGHT+IHVDlVcWY/YXmmd+tCETlVPVO6FcIMFoZVRZ+na4G7G3AdQhVnvjQNZQ5+8ajZRtqoQuLMh7bajkn4rv2g=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:b110:0:b0:d9a:5e10:c34d with SMTP id
 g16-20020a25b110000000b00d9a5e10c34dmr16195ybj.11.1697507249118; Mon, 16 Oct
 2023 18:47:29 -0700 (PDT)
Date: Tue, 17 Oct 2023 01:47:15 +0000
In-Reply-To: <20231017014716.3944813-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017014716.3944813-5-lixiaoyan@google.com>
Subject: [PATCH v2 net-next 4/5] net-device: reorganize net_device fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reorganize fast path variables on tx-txrx-rx order
Fastpath variables end after npinfo.

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 4

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/linux/netdevice.h | 99 ++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c7681263d302..d72b71b76bf82 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2053,6 +2053,58 @@ enum netdev_ml_priv_type {
  */
 
 struct net_device {
+	/* Caacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/net_device.rst.
+	 * Please update the document when adding new fields.
+	 */
+
+	/* TX read-mostly hotpath */
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
+
 	char			name[IFNAMSIZ];
 	struct netdev_name_node	*name_node;
 	struct dev_ifalias	__rcu *ifalias;
@@ -2077,7 +2129,6 @@ struct net_device {
 	struct list_head	unreg_list;
 	struct list_head	close_list;
 	struct list_head	ptype_all;
-	struct list_head	ptype_specific;
 
 	struct {
 		struct list_head upper;
@@ -2085,25 +2136,12 @@ struct net_device {
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
@@ -2147,8 +2185,6 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
-	const struct header_ops *header_ops;
-
 	unsigned char		operstate;
 	unsigned char		link_mode;
 
@@ -2189,9 +2225,7 @@ struct net_device {
 
 
 	/* Protocol-specific pointers */
-
 	struct in_device __rcu	*ip_ptr;
-	struct inet6_dev __rcu	*ip6_ptr;
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	struct vlan_info __rcu	*vlan_info;
 #endif
@@ -2226,23 +2260,14 @@ struct net_device {
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
@@ -2260,24 +2285,15 @@ struct net_device {
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
@@ -2317,12 +2333,6 @@ struct net_device {
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
@@ -2356,20 +2366,15 @@ struct net_device {
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
-- 
2.42.0.655.g421f12c284-goog


