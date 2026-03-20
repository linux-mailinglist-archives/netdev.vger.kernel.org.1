Return-Path: <netdev+bounces-270093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JdYF7zIvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E86F82E1B9D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2299308B989
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E43A9627;
	Fri, 20 Mar 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mb6DcdD0"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38136605E;
	Fri, 20 Mar 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045130; cv=none; b=l8C44iVe/IWP4rnIgd4LQt2JBVIDELjdn5iQAYIF+Re1y+ZVWVCqptA/34m3lptR90UenG+YDwU0mPvM1KGP/vok3g6mwLvJnMkECaobhTNQOLWDsRWbjpRcJZ3VPKORjrBIAWWkvJ/TL/0U5y262aEws7DDrRoPsjg0LD1U3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045130; c=relaxed/simple;
	bh=zIkLBIJxSVUB2QcotN954M58sx5dX3PVrb0IDncWgCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUUSy9nlOgbhf321qcI0fvpzy5CGjx79glf8DdRpSZBB+MqcX6JauUKnleyisKw671cQN/UIsYDdW8VA+mBTbNz86zN+BdEXcNnkcVY+nd9WTnn7QxyxJ+x+v0qhP0UcJEqNfj3TamWJOH90W0+Lckgx396wOzP6mEv3nN3PwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mb6DcdD0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lxP0LiDg8QqkRnaIrc7++u33pc+kT/kWmPqkzVVTXvQ=; b=mb6DcdD0MBYJxDYBSnE3ZlVu9B
	BtLNyfv5UtV/X8bSMzhSHDj8ZiHONaGt5XZTq09RZJ/wvy3qRDhhk02Dx1zwpcpYeWePsrdXKiLuA
	Hv9iqzQ8uKTFNUug11HoxtS7rsjCnsm5zglXO5iG3WW7OpJeq/d+Mh+qKP6HylSumTVA5Yb7VqAFW
	qy2sDNAkunwzEwwNVt04lERqJsA2yL6fcSARSjslo5+NSgkPaTDBoU6VIc4nvxhyqklRyWpiz9VBU
	bobxI3C+niZbEXnyF0bdM7vjnQVvHQDrKmM1Vqbnj51m0qqFD0BtjzZk/UBIS5Sx1ZWP1MYSuVeW6
	bjx0Rktw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAo-000H0k-1k;
	Fri, 20 Mar 2026 23:18:30 +0100
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
Subject: [PATCH net-next v9 12/14] netkit: Add netkit notifier to check for unregistering devices
Date: Fri, 20 Mar 2026 23:18:12 +0100
Message-ID: <20260320221814.236775-13-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320221814.236775-1-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270093-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,blackwall.org:email,davidwei.uk:email]
X-Rspamd-Queue-Id: E86F82E1B9D
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
 drivers/net/netkit.c      | 59 ++++++++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            |  6 ++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index ed0d56bfb60c..018734c9897b 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -1048,6 +1048,50 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
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
@@ -1124,18 +1168,31 @@ static struct rtnl_link_ops netkit_link_ops = {
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
index 35b194e57c3f..0b26b27a3d92 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3411,6 +3411,8 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
+bool unregister_netdevice_queued(const struct net_device *dev);
+
 static inline void unregister_netdevice(struct net_device *dev)
 {
 	unregister_netdevice_queue(dev, NULL);
diff --git a/net/core/dev.c b/net/core/dev.c
index 763a2c6c3bf1..60d23a49c929 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12360,6 +12360,12 @@ static void netif_close_many_and_unlock_cond(struct list_head *close_head)
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


