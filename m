Return-Path: <netdev+bounces-304314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fIasBI3+RmpOgQsAu9opvQ
	(envelope-from <netdev+bounces-304314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:13:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 941766FD90D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:13:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wELq+DKu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304314-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8FC3081364
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0C1F5834;
	Fri,  3 Jul 2026 00:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE91E0DE8
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037424; cv=none; b=B+zEs3YOESwoTWwpinVDUKqVUnCXlLGymiAGfkFXW/0mOgvUjK07lhm0ii5Z5NUyOUXus3k3/26Hr/ca0nh1lHFph/6omAJgdSDb2dHp27UA663+e+C9YswtFz0PTm+F0R2qoE6Dv75d3BSKbixZ4HQuNpD04xEXJTq+uWgztj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037424; c=relaxed/simple;
	bh=aw9fWqlAsHCcyIfxj5ZCOQZ0Mkd+jxgDUdg0pSdkW1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HAqZ6b4qdOmrkhXSgpT2MlHgFlVGR0OY5q4WOBHhCFJVd+EaozKNHYZrEAwj1vj0smTeL9A5vFsOjDWx1+lNd6v+9LApT8kOl4fpG1PMlGT9E9Kol5x8/FbPa+shIRO02m0sqh7K2MzybwZhcUCLQ7SFw883ZoTrROd0BPxw8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wELq+DKu; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3811279d51aso893337a91.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037422; x=1783642222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VQDd26UR2o/sAL9/9RYYC9eSMAdRKMgOdUXnLBkMGo=;
        b=wELq+DKuu+I6LUzXmYbSFJLDxzVL5CnnMLg0V4hmNTypRiMundn5lBoBBj7vSv219F
         414yMGHzNsqQE6LGkNIhJ5Z0FQXxuJrxnbkItxj1eILIwia0uh6HhXJAVPbpYUObm7rK
         Vyy7L1Wso/kLKBTC6Lw5PSO11Rvg1Y4/uCWGB6UHByOd0S20QSQStu8y4+zl7ttbHeih
         aAILwrJ6aCzC4C4w868C28YclsQmCZU4RE9Lsw0GWUVFFasAAwFhBlCAK73drz1wssBi
         WxfuvUSlDkBWXYmwt8JktBCB2BkdCIhyieh3bNXbIjjBeRKIxCL+vzg2lXLzFyJUvX2o
         Uwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037422; x=1783642222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VQDd26UR2o/sAL9/9RYYC9eSMAdRKMgOdUXnLBkMGo=;
        b=SrO0Faap9pxAdryA52fT4D0VmUhJ4jgTlNhGu0ou1w4rOPxy1uUUv/hONafDUq9H8t
         7GwmzmEF0OfQ/zT2GtPPUUiGrxq+BKpGtdwWk+wrNnG+2ZQxev+0x7W+RO5mQuOhnFbQ
         Xpo6yMSotGljbO8X2v8hx37heLKfYvkHtuMi8eiOHnx6pD4K4/bZmQWXras7nu4MVKjn
         xeTomFf18+/39pO1uA2KRVvm2t6QH7Y7diGblPdcuIDURKPIteBwNCq2WZsTamG204CY
         X1ECYQIvULHGpDmui3Uk1yqdJoLjKCPQnVmv6E9OCvMoVWHq7R29ogSRWDHpU4d+GXth
         PoGw==
X-Forwarded-Encrypted: i=1; AHgh+Rrnl3R/3PSMRuGBMCdkjHg8bTRqZf29xUeynnTcFpdRsRmy1UZ6SeOfPTuaJyNvdrdeAVPoCh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmyxi9w0u53kTYWEw+HCBdsBhkToi20skR80n4RsO2emTxKF+g
	sb9DwiTlUlGjnZI85UFfpZ+9TAtC7EF//u6WtaZ7ptMlV6Nx7mlFNUz5mXrogI6TbE+aGixmqPd
	C4GEeNg==
X-Received: from pjbnh15.prod.google.com ([2002:a17:90b:364f:b0:37c:57ea:cd49])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f85:b0:37e:1bc4:b6ae
 with SMTP id 98e67ed59e1d1-380ba868ebcmr8965841a91.8.1783037421771; Thu, 02
 Jul 2026 17:10:21 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:24 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/14] ipvlan: Protect ipvl_port.ipvlans with mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304314-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 941766FD90D

struct ipvl_port is shared between a lower device and its upper
ipvlan devices.

All upper devices are linked to ipvl_port.ipvlans.

Once RTNL is removed, the list can be modified concurrently from
different netns due to device removal.

Let's protect it with a per-port mutex.

NETDEV_PRECHANGEUPPER and NETDEV_CHANGEUPPER are explicitly
skipped to avoid deadlock for netdev_upper_dev_unlink() called
from NETDEV_UNREGISTER.

Note that __ipvtap_dellink_ptr is added for CONFIG_IPVLAN=y
but CONFIG_TAP=m and CONFIG_IPVTAP=m.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add __ipvtap_dellink_ptr for CONFIG_IPVLAN=y and CONFIG_TAP=m
---
 drivers/net/ipvlan/ipvlan.h      |  8 +++++-
 drivers/net/ipvlan/ipvlan_main.c | 49 ++++++++++++++++++++++++++++----
 drivers/net/ipvlan/ipvtap.c      | 23 ++++++++++++---
 3 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 78f9107fa752..9d3835c14e5e 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -91,6 +91,7 @@ struct ipvl_port {
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
 	spinlock_t		addrs_lock; /* guards hash-table and addrs */
 	struct list_head	ipvlans;
+	struct mutex		pnodes_lock;
 	u16			mode;
 	u16			flags;
 	u16			dev_id_start;
@@ -168,7 +169,7 @@ void ipvlan_count_rx(const struct ipvl_dev *ipvlan,
 		     unsigned int len, bool success, bool mcast);
 int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 		    struct netlink_ext_ack *extack);
-void ipvlan_link_delete(struct net_device *dev, struct list_head *head);
+void __ipvlan_link_delete(struct net_device *dev, struct list_head *head);
 void ipvlan_link_setup(struct net_device *dev);
 int ipvlan_link_register(struct rtnl_link_ops *ops);
 #ifdef CONFIG_IPVLAN_L3S
@@ -207,4 +208,9 @@ static inline bool netif_is_ipvlan_port(const struct net_device *dev)
 	return rcu_access_pointer(dev->rx_handler) == ipvlan_handle_frame;
 }
 
+#if IS_ENABLED(CONFIG_IPVTAP)
+extern void (*__ipvtap_dellink_ptr)(struct net_device *dev,
+				    struct list_head *head);
+#endif
+
 #endif /* __IPVLAN_H */
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 7adad781e9b5..6d7479a8a9c6 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -7,6 +7,12 @@
 
 #include "ipvlan.h"
 
+#if IS_ENABLED(CONFIG_IPVTAP)
+void (*__ipvtap_dellink_ptr)(struct net_device *dev,
+			     struct list_head *head);
+EXPORT_SYMBOL(__ipvtap_dellink_ptr);
+#endif
+
 static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 				struct netlink_ext_ack *extack)
 {
@@ -16,6 +22,8 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 
 	ASSERT_RTNL();
 	if (port->mode != nval) {
+		mutex_lock(&port->pnodes_lock);
+
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			flags = ipvlan->dev->flags;
 			if (nval == IPVLAN_MODE_L3 || nval == IPVLAN_MODE_L3S) {
@@ -40,6 +48,8 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 			ipvlan_l3s_unregister(port);
 		}
 		port->mode = nval;
+
+		mutex_unlock(&port->pnodes_lock);
 	}
 	return 0;
 
@@ -56,6 +66,8 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 					 NULL);
 	}
 
+	mutex_unlock(&port->pnodes_lock);
+
 	return err;
 }
 
@@ -76,6 +88,7 @@ static int ipvlan_port_create(struct net_device *dev)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
 	spin_lock_init(&port->addrs_lock);
+	mutex_init(&port->pnodes_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
@@ -676,7 +689,10 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (err)
 		goto unlink_netdev;
 
+	mutex_lock(&port->pnodes_lock);
 	list_add_tail_rcu(&ipvlan->pnode, &port->ipvlans);
+	mutex_unlock(&port->pnodes_lock);
+
 	netif_stacked_transfer_operstate(phy_dev, dev);
 	return 0;
 
@@ -690,7 +706,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_new);
 
-void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+void __ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
@@ -708,7 +724,16 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 	netdev_upper_dev_unlink(ipvlan->phy_dev, dev);
 }
-EXPORT_SYMBOL_GPL(ipvlan_link_delete);
+EXPORT_SYMBOL(__ipvlan_link_delete);
+
+static void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	mutex_lock(&ipvlan->port->pnodes_lock);
+	__ipvlan_link_delete(dev, head);
+	mutex_unlock(&ipvlan->port->pnodes_lock);
+}
 
 void ipvlan_link_setup(struct net_device *dev)
 {
@@ -770,10 +795,16 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	struct ipvl_port *port;
 	LIST_HEAD(lst_kill);
 
+	if (event == NETDEV_PRECHANGEUPPER ||
+	    event == NETDEV_CHANGEUPPER)
+		return ret;
+
 	port = ipvlan_port_get(dev);
 	if (!port)
 		return ret;
 
+	mutex_lock(&port->pnodes_lock);
+
 	switch (event) {
 	case NETDEV_UP:
 	case NETDEV_DOWN:
@@ -800,9 +831,15 @@ static int ipvlan_device_event(struct notifier_block *unused,
 		if (dev->reg_state != NETREG_UNREGISTERING)
 			break;
 
-		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode)
-			ipvlan->dev->rtnl_link_ops->dellink(ipvlan->dev,
-							    &lst_kill);
+		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode) {
+#if IS_ENABLED(CONFIG_IPVTAP)
+			if (ipvlan->dev->rtnl_link_ops != &ipvlan_link_ops)
+				__ipvtap_dellink_ptr(ipvlan->dev, &lst_kill);
+			else
+#endif
+				__ipvlan_link_delete(ipvlan->dev, &lst_kill);
+		}
+
 		unregister_netdevice_many(&lst_kill);
 		break;
 
@@ -850,6 +887,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 			call_netdevice_notifiers(event, ipvlan->dev);
 	}
 
+	mutex_unlock(&port->pnodes_lock);
+
 	ipvlan_port_put(port);
 
 	return ret;
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 2d6bbddd1edd..99eaa29057b4 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -109,14 +109,24 @@ static int ipvtap_newlink(struct net_device *dev,
 	return err;
 }
 
+static void __ipvtap_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct ipvtap_dev *vlantap = netdev_priv(dev);
+
+	netdev_rx_handler_unregister(dev);
+	tap_del_queues(&vlantap->tap);
+	__ipvlan_link_delete(dev, head);
+}
+
 static void ipvtap_dellink(struct net_device *dev,
 			   struct list_head *head)
 {
-	struct ipvtap_dev *vlan = netdev_priv(dev);
+	struct ipvtap_dev *vlantap = netdev_priv(dev);
+	struct ipvl_port *port = vlantap->vlan.port;
 
-	netdev_rx_handler_unregister(dev);
-	tap_del_queues(&vlan->tap);
-	ipvlan_link_delete(dev, head);
+	mutex_lock(&port->pnodes_lock);
+	__ipvtap_dellink(dev, head);
+	mutex_unlock(&port->pnodes_lock);
 }
 
 static void ipvtap_setup(struct net_device *dev)
@@ -198,6 +208,8 @@ static int __init ipvtap_init(void)
 {
 	int err;
 
+	__ipvtap_dellink_ptr = __ipvtap_dellink;
+
 	err = tap_create_cdev(&ipvtap_cdev, &ipvtap_major, "ipvtap",
 			      THIS_MODULE);
 	if (err)
@@ -224,6 +236,8 @@ static int __init ipvtap_init(void)
 out2:
 	tap_destroy_cdev(ipvtap_major, &ipvtap_cdev);
 out1:
+	__ipvtap_dellink_ptr = NULL;
+
 	return err;
 }
 module_init(ipvtap_init);
@@ -234,6 +248,7 @@ static void __exit ipvtap_exit(void)
 	unregister_netdevice_notifier(&ipvtap_notifier_block);
 	class_unregister(&ipvtap_class);
 	tap_destroy_cdev(ipvtap_major, &ipvtap_cdev);
+	__ipvtap_dellink_ptr = NULL;
 }
 module_exit(ipvtap_exit);
 MODULE_ALIAS_RTNL_LINK("ipvtap");
-- 
2.55.0.rc0.799.gd6f94ed593-goog


