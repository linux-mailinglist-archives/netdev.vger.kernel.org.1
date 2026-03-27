Return-Path: <netdev+bounces-272538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDs/F0B1xmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:17:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2434413A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB60302DB50
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322A3B3888;
	Fri, 27 Mar 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XXARV8a2"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8ED3939DD;
	Fri, 27 Mar 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613485; cv=none; b=FsgoGTwxS1+A8KC7Y6KkF+I6k2pP59EegX7JFyacQjj9kMai2DFoaYlrAxwpJT7NrfE8/iEuaHuFkb2xZUBEVje7eOfm7SADlZ/FAoxmAUV2GJEDDCBVsbmTe8JKbt1T17UdAzKrcvN9rMUZtvS2vsSoXWyfkkyMV7ozFpvWkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613485; c=relaxed/simple;
	bh=iOS1yAsOlJM/aquU71i4nK9IXmy16d3ILK34nf7S128=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRBO/WOhxjCZ3IimO5U9ZFpIHvP7r8EiCbuUjkdtGNf1Lsl9WpL9Pjh3dkCujZv0icOjLYst7dYy9kJ+GGJqaCXVYHobWrWRQyIWV/fyyrrSYIJIfGiXesScrUntOcJBWatn6i4Q+oL8ebpzd8/y3LPmp+ApIeG7w9Rmf7hgrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XXARV8a2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bPaDoeZ5tSUJqJYblntPuS+D2oGZgcH8mnm1BV/c8Mw=; b=XXARV8a2nZEXvqUWHCy2w5AMnL
	CXG4WyhZ6ldOlymMELI84QEw3L9k4xKOmF1xlXdv+vD1hkMD3z9ZyARp8sEk6yvm9Nfr+YcFSiHLY
	IDTNHpvQ5mDXiPZHjEiRCbOPsF+f1VYRbKCp+qG1h3qu5fYI8q59Ua673JcjQKnJICW5luF+qqOUk
	dwNHZcAoZt17JoSMxpCpNM5Y6wt57kKlYWkR4y6VnWvnRPoV+1gKmxNhbqcEWG5dbWoVJVqukjjkJ
	gxZO3sIeh/0UJDhCsBpzzz/SQid30zJbtGw0naw3iXD73+3Qi1punhKeNMW9W0Ietc0hCK2xDs1IF
	A+dX051Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w661p-000APQ-2N;
	Fri, 27 Mar 2026 13:11:05 +0100
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
Subject: [PATCH net-next v10 12/14] netkit: Add netkit notifier to check for unregistering devices
Date: Fri, 27 Mar 2026 13:10:47 +0100
Message-ID: <20260327121049.334562-13-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272538-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,blackwall.org:email,none:email,davidwei.uk:email]
X-Rspamd-Queue-Id: 9FA2434413A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a netdevice notifier in netkit to watch for NETDEV_UNREGISTER events.
If the target device is indeed NETREG_UNREGISTERING and previously leased
a queue to a netkit device, then collect the related netkit devices and
batch-unregister_netdevice_many() them.

If this were not done, then the netkit device would hold a reference on
the physical device preventing it from going away. However, in case of
both io_uring zero-copy as well as AF_XDP this situation is handled
gracefully and the allocated resources are torn down.

In the case where mentioned infra is used through netkit, the applications
have a reference on netkit, and netkit in turn holds a reference on the
physical device. In order to have netkit release the reference on the
physical device, we need such watcher to then unregister the netkit ones.

This is generally quite similar to the dependency handling in case of
tunnels (e.g. vxlan bound to a underlying netdev) where the tunnel device
gets removed along with the physical device.

  # ip a
  [...]
  4: enp10s0f0np0: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN group default qlen 1000
      link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
      inet 10.0.0.2/24 scope global enp10s0f0np0
         valid_lft forever preferred_lft forever
  [...]
  8: nk@NONE: <BROADCAST,MULTICAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
  [...]

  # rmmod mlx5_ib
  # rmmod mlx5_core
  [...]
  [  309.261822] mlx5_core 0000:0a:00.0 mlx5_0: Port: 1 Link DOWN
  [  344.235236] mlx5_core 0000:0a:00.1: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.246948] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.463754] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.770155] mlx5_core 0000:0a:00.1: E-Switch: cleanup
  [...]

  # ip a
  [...]
  [ both enp10s0f0np0 and nk gone ]
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c      | 69 +++++++++++++++++++++++++++++++++++++--
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            |  6 ++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a96fa81b098b..f0066c1cbb1c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -981,7 +981,15 @@ static void netkit_del_link(struct net_device *dev, struct list_head *head)
 	if (peer) {
 		nk = netkit_priv(peer);
 		RCU_INIT_POINTER(nk->peer, NULL);
-		unregister_netdevice_queue(peer, head);
+		/* Guard against the peer already being in an unregister
+		 * list (e.g. same-namespace teardown where the peer is
+		 * in the caller's dev_kill_list). list_move_tail() on an
+		 * already-queued device would otherwise corrupt that
+		 * list's iteration. This situation can occur via netkit
+		 * notifier, hence guard against this scenario.
+		 */
+		if (!unregister_netdevice_queued(peer))
+			unregister_netdevice_queue(peer, head);
 	}
 }
 
@@ -1049,6 +1057,50 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
+static void netkit_check_lease_unregister(struct net_device *dev)
+{
+	LIST_HEAD(list_kill);
+	u32 q_idx;
+
+	if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||
+	    !dev->dev.parent)
+		return;
+
+	netdev_lock_ops(dev);
+	for (q_idx = 0; q_idx < dev->real_num_rx_queues; q_idx++) {
+		struct net_device *tmp = dev;
+		struct netdev_rx_queue *rxq;
+		u32 tmp_q_idx = q_idx;
+
+		rxq = __netif_get_rx_queue_lease(&tmp, &tmp_q_idx,
+						 NETIF_PHYS_TO_VIRT);
+		if (rxq && tmp != dev &&
+		    tmp->netdev_ops == &netkit_netdev_ops) {
+			/* A single phys device can have multiple queues leased
+			 * to one netkit device. We can only queue that netkit
+			 * device once to the list_kill. Queues of that phys
+			 * device can be leased with different individual netkit
+			 * devices, hence we batch via list_kill.
+			 */
+			if (unregister_netdevice_queued(tmp))
+				continue;
+			netkit_del_link(tmp, &list_kill);
+		}
+	}
+	netdev_unlock_ops(dev);
+	unregister_netdevice_many(&list_kill);
+}
+
+static int netkit_notifier(struct notifier_block *this,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (event == NETDEV_UNREGISTER)
+		netkit_check_lease_unregister(dev);
+	return NOTIFY_DONE;
+}
+
 static size_t netkit_get_size(const struct net_device *dev)
 {
 	return nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_POLICY */
@@ -1125,18 +1177,31 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
+static struct notifier_block netkit_netdev_notifier = {
+	.notifier_call	= netkit_notifier,
+};
+
 static __init int netkit_mod_init(void)
 {
+	int ret;
+
 	BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
 		     (int)NETKIT_PASS != (int)TCX_PASS ||
 		     (int)NETKIT_DROP != (int)TCX_DROP ||
 		     (int)NETKIT_REDIRECT != (int)TCX_REDIRECT);
 
-	return rtnl_link_register(&netkit_link_ops);
+	ret = rtnl_link_register(&netkit_link_ops);
+	if (ret)
+		return ret;
+	ret = register_netdevice_notifier(&netkit_netdev_notifier);
+	if (ret)
+		rtnl_link_unregister(&netkit_link_ops);
+	return ret;
 }
 
 static __exit void netkit_mod_exit(void)
 {
+	unregister_netdevice_notifier(&netkit_netdev_notifier);
 	rtnl_link_unregister(&netkit_link_ops);
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e8aa9cc4075d..47417b2d48a4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3420,6 +3420,8 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
+bool unregister_netdevice_queued(const struct net_device *dev);
+
 static inline void unregister_netdevice(struct net_device *dev)
 {
 	unregister_netdevice_queue(dev, NULL);
diff --git a/net/core/dev.c b/net/core/dev.c
index 59b7b86bb171..ab74152ad907 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12373,6 +12373,12 @@ static void netif_close_many_and_unlock_cond(struct list_head *close_head)
 #endif
 }
 
+bool unregister_netdevice_queued(const struct net_device *dev)
+{
+	ASSERT_RTNL();
+	return !list_empty(&dev->unreg_list);
+}
+
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh)
 {
-- 
2.43.0


