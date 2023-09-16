Return-Path: <netdev+bounces-34212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722337A2CD6
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F3A28599D
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21F137C;
	Sat, 16 Sep 2023 01:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02B46B4
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:06:37 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3290
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c27703cc6so8771597b3.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694826395; x=1695431195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qz4V3XLqv+E98DDYmVT2fp6gpWlZyDG6UyupNw3+L0=;
        b=Uny8XMeE+lgZ9X3RT5tlPonqaPOKWnh71sTnsgCQ/r7vk5xK/Kizp6vqzCA73k1mEL
         hT843nfhmdHJ8/bB5/V3CcE4K+ZgbOf6eaA67OFf3jL4DLX1PO3fLbTLNFWZufC4D38K
         m+IwkZYxZLRGhEkecSr57XqozD9Z3ag3E+GOn7IF5Y3Zw6qbznKNpvnprJKk4PXHG4/z
         ons4Bo5evUSKRKyiBLRLOUpT8CAZmNY0vmYGmdxQKINs/TSAPiPRLtdPdstFP/TfDR3u
         QA1ZjpnCnhOj5FFEDLUV3ngIeb3w1cKuiECrYWOJD2Wk/miJpEIxy0EBE0F36/w3fIZe
         87zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826395; x=1695431195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qz4V3XLqv+E98DDYmVT2fp6gpWlZyDG6UyupNw3+L0=;
        b=DKs98mO77wNCAuTZ2QpddyV7PFHmz2E3eO3LTWmYVEjN3Pv67O15Y3GLK3NTWmidYR
         Hf9s41xKbAsU+9EYRgQVMIiV45zdvD6V+1m9M3BdoXB9SWeN4ZC8Rb7cspnNpf0Uflo5
         5kzl8eVoFO+36kkT1Hfh/Ns95dobQKvWSgYgaookURNkC7mPYS5R0sJ51fBApD5FCXUG
         qd1+mOTlV4qZp3FZSGEFkWwZ+T1tVCP91D0gL1kDcNungldC7Zm/P3KZohuaTlCnottJ
         Fm1SEmk4raZk9tS8rowTqfgKt3tYIaBqrF37NmQXZWy7G+AVWIb0+F9SizZYeuEmP1Iz
         DyHA==
X-Gm-Message-State: AOJu0Yyel/a+6NUs76j1N9yLjKQeMibS+N+vjfEhF5vgEq/GXBZsO8Iv
	1Eb9UAeNnduBk3O+coyGPnF574GOzGzCfr4=
X-Google-Smtp-Source: AGHT+IGgTWhaZLVrsyduuScQsJ3cCj+moGP8e8ROSFp5zopYp8WPg3qqnAXCRP0dIQJF7OX3qRJqI/VmagQZrDw=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a81:ad64:0:b0:59b:eea4:a5a6 with SMTP id
 l36-20020a81ad64000000b0059beea4a5a6mr81737ywk.0.1694826395202; Fri, 15 Sep
 2023 18:06:35 -0700 (PDT)
Date: Sat, 16 Sep 2023 01:06:24 +0000
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916010625.2771731-5-lixiaoyan@google.com>
Subject: [PATCH v1 net-next 4/5] net-device: reorganize net_device fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reorganize fast path variables on tx-txrx-rx order
Fastpath variables end after npinfo.

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 4

Tested:
Built and installed.

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 96 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7b..e52ee8d51add5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2054,6 +2054,54 @@ enum netdev_ml_priv_type {
  */
 
 struct net_device {
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
+	unsigned		threaded:1;
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
@@ -2078,7 +2126,6 @@ struct net_device {
 	struct list_head	unreg_list;
 	struct list_head	close_list;
 	struct list_head	ptype_all;
-	struct list_head	ptype_specific;
 
 	struct {
 		struct list_head upper;
@@ -2086,25 +2133,12 @@ struct net_device {
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
@@ -2148,8 +2182,6 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
-	const struct header_ops *header_ops;
-
 	unsigned char		operstate;
 	unsigned char		link_mode;
 
@@ -2190,9 +2222,7 @@ struct net_device {
 
 
 	/* Protocol-specific pointers */
-
 	struct in_device __rcu	*ip_ptr;
-	struct inet6_dev __rcu	*ip6_ptr;
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	struct vlan_info __rcu	*vlan_info;
 #endif
@@ -2227,23 +2257,14 @@ struct net_device {
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
@@ -2261,24 +2282,15 @@ struct net_device {
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
@@ -2318,12 +2330,6 @@ struct net_device {
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
@@ -2357,20 +2363,15 @@ struct net_device {
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
@@ -2384,7 +2385,6 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	unsigned		wol_enabled:1;
-	unsigned		threaded:1;
 
 	struct list_head	net_notifier_list;
 
-- 
2.42.0.459.ge4e396fd5e-goog


