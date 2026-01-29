Return-Path: <netdev+bounces-254931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLR0A/bfe2lyJAIAu9opvQ
	(envelope-from <netdev+bounces-254931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5ADB55C4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9AB3019911
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49836AB71;
	Thu, 29 Jan 2026 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gtxRwRfS"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E436B06F;
	Thu, 29 Jan 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725744; cv=none; b=k0FkD5QxU1Wd3AbFBPgkviOpSKQ9RJTjlBKV4B+ta9RVSJOkWpGqP01mtP8pXT9v3MQO16tIERdYnph+5e56Ju2yUj/TOabcFTQUeOX6T2nkPQ8hmkDWgTqi/GbxFdbU/yKXYo9F2wBqgV1m6lqAj/U5dg0CgC6N+MI7a3Lh3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725744; c=relaxed/simple;
	bh=GahdlpydzfYDN8oHpu/rlXQRpUnYkR/ZKO5eJchIId8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X91z8WKtw1PwY7HFbgL0jND+QMsS3HwYTTm3LpVe+B/h7ZpK7oOmWupFa/Q8RYiJSk6pOqL9zzPk6oDDbTEsSYyoDt6j+A+nYguYsuyZNbv3tki7lfj8dvQd6Vq1+tgTJvDb2/QzddgcqNmeMAzwOGCaRU/mCH6DalMQb5R8xMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gtxRwRfS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XYi1N1QB5dXM2rGNdQJ8CohCC8iMcPA7hQNozDsLcX8=; b=gtxRwRfSs8s6y674r8NpYiE0ec
	mL11KECG0zCaOt0FqI/PfB8CZ8DLGZBomegomEJo4G2Q85zsNNo/oHXpAxLvO+PyKcVzWTihUWGd/
	pjDK0OEiLg+XUgVNVnXmLDL7PdU+4HCHGi5keWEcpgWEflM5xdQBrbCwN6v+zW6KXeW5Jqs12TXCu
	hhL7pc6xb1TaP/BC62RYigiDSUemn44Kp/KAp2Uyw10FHltFC5XNt6VOMm0MORBl5FbF/sUiEwJB7
	fif2TbegSdFYQgPfWvbtGeMeSHbxKkrLbkr5piBh1iXagljtz2gecRwo81gCOMMVgtpSqgu/S07aN
	I/q0eJyg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVJ-0008pl-1O;
	Thu, 29 Jan 2026 23:28:45 +0100
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
Subject: [PATCH net-next v8 12/16] netkit: Add netkit notifier to check for unregistering devices
Date: Thu, 29 Jan 2026 23:28:26 +0100
Message-ID: <20260129222830.439687-13-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254931-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:email,none:email]
X-Rspamd-Queue-Id: 5F5ADB55C4
X-Rspamd-Action: no action

Add a netdevice notifier in netkit to watch for NETDEV_UNREGISTER events.
If the target device is indeed NETREG_UNREGISTERING and previously leased
a queue to a netkit device, then collect the related netkit devices and
batch-unregister_netdevice_many() them.

If this would not be done, then the netkit device would hold a reference
on the physical device preventing it from going away. However, in case of
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

  [  309.261822] mlx5_core 0000:0a:00.0 mlx5_0: Port: 1 Link DOWN
  [  344.235236] mlx5_core 0000:0a:00.1: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.246948] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.463754] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  344.770155] mlx5_core 0000:0a:00.1: E-Switch: cleanup
  [  345.345709] mlx5_core 0000:0a:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  345.357524] mlx5_core 0000:0a:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  350.995989] mlx5_core 0000:0a:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
  [  351.574396] mlx5_core 0000:0a:00.0: E-Switch: cleanup

  # ip a
  [...]
  [ both enp10s0f0np0 and nk gone ]
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c      | 57 ++++++++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h |  6 +++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index c6688b604337..5c417c6055d8 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -1039,6 +1039,48 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
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
+		u32 tmp_q_idx = q_idx;
+
+		if (netif_rx_queue_lease_get_owner(&tmp, &tmp_q_idx)) {
+			if (tmp->netdev_ops != &netkit_netdev_ops)
+				continue;
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
@@ -1115,18 +1157,31 @@ static struct rtnl_link_ops netkit_link_ops = {
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
index d4e6e00bb90a..6ad348f17d93 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3403,11 +3403,17 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
+
 static inline void unregister_netdevice(struct net_device *dev)
 {
 	unregister_netdevice_queue(dev, NULL);
 }
 
+static inline bool unregister_netdevice_queued(const struct net_device *dev)
+{
+	return !list_empty(&dev->unreg_list);
+}
+
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 
-- 
2.43.0


