Return-Path: <netdev+bounces-304315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yaFMJpj+RmpPgQsAu9opvQ
	(envelope-from <netdev+bounces-304315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0F6FD910
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=q0Dr1Pwj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304315-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7992C3088551
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F611FE44A;
	Fri,  3 Jul 2026 00:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D91F09A5
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037425; cv=none; b=eBjsd1ZGDuggVljLuKEPlqMgIF1z5w/zelcU2Klz1Fg2BridzoiM4HR87smbsnOGwubcMvn5GFghyMf8tLZI/iZYpHD4gT6h9UkgbAHs1fdVTEl1Jk1XGp6HJBcc4Bga3NvpNq+fsbiyP7Nw8fgBG0T5XsjDiCqpfCxiiMC4JNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037425; c=relaxed/simple;
	bh=FJ3ume9/eQwPwke6+ukIBKR0Fn9gqHfqdYzp9Peh9Jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hbTmhWv1IDz2QJTbuUssmwfMOhOgbJFx0TtNsbjZOegOCx+HVgHhJrusZkYF5Zb+Kk/gqG8MLKTLdkfq3ZDqcrwMEIlQBZnLk7rFlrww0p7WdeLsi0Y3rIB9xWtIGOXm5vgs7CydZAXAQ06APsRJIF+TGqrkOEhoYTMJBxdJ9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0Dr1Pwj; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6a20348ceso33000885ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037423; x=1783642223; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59i8kyLJILQSZ4Y6fZP/vJN1lA9JbTSTajzE3/3nyI4=;
        b=q0Dr1PwjarN8k8aSPug1cKp3ba7Aj95AE3e6J+ZG9FGVzR6LgAVMnpRMDKd1+LG2lx
         Lh4Tve1G2rYwiL8ornbbawqgniqoCNdHLv1tfGOQmq3KIetGY4LIEQ0LzqMtSauDWjSY
         IredRAVNuRIGN9uPfOW1vnplV0FNZlgOu4PEftwYUKgUvhE/kxbYp+6RynPZQM4i+izL
         hwPVOcLkz24b/2iFp1b/J/M4gb//WgQA28ig/YKnWFzPGayhmJCHQen3ntDupiUxpTMf
         sOWrRAeeh+fk/vCkQ3YCfVwP/2NTue7xmjqQcddIWEX9oDYnD6/3eBo4rBWRYQp1FHyY
         gG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037423; x=1783642223;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59i8kyLJILQSZ4Y6fZP/vJN1lA9JbTSTajzE3/3nyI4=;
        b=eXV2lyaGQXrGkQEfSBC+TrQLIcChUSLBGQaJ+20pq+XrSjjulk0NLqK2g0PMXnNIay
         dvr3X1CJi3BgETJro7lrrSWlGJ//b1SUzF7LpQ2AAqbRRGb+n9znK/HzO6HXrlyRen2R
         siQyPrO8OTQPrfOqhRuNIMGKhVpxqw6dxvgROQ71RmcCjF4sf8GpExif3hOL4EOCXvqq
         e3YQvlTbGL/LQutTHXa7H/AksuGjePmV3KU1K+Op5AqKt5Rp02QVhbe5e9Bj+5Y3fH1s
         mR/MgNhQ0OteCEyLR6UNU/auTI/lXNdjsV4x1S3DDGd+ZMO8ig3hCyz0mwro4ORn2sVv
         yBIA==
X-Forwarded-Encrypted: i=1; AHgh+Rqj9nadPYa8Pimj7U65lFcZrSmZVAiRJ5YJp7d9m7geOmLWP9ggo4jveT8cs41yJS/9H+9fAHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FpBtDg6UQdDkuezLFI8IoHcxI7jwu+f4r6l7KOVw9zp7gfzJ
	AMRVbDDqJK+RG+DFEq4GhPrppRZhaC9pdDccKABB3cKdIGPSWu/6XGvUV3fGm3nkpg6197+ArM/
	443CZ3g==
X-Received: from plch6.prod.google.com ([2002:a17:902:f2c6:b0:2ca:d6eb:2a36])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c65:b0:2c9:c083:cd50
 with SMTP id d9443c01a7336-2ca9114e60bmr78279505ad.17.1783037422559; Thu, 02
 Jul 2026 17:10:22 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:25 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-15-kuniyu@google.com>
Subject: [PATCH v2 net-next 14/14] ipvlan: Support per-netns netdev unregistration.
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
	TAGGED_FROM(0.00)[bounces-304315-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 11F0F6FD910

When a lower device is unregistered, its upper ipvlan devices
must also be unregistered.  However, these upper devices may
reside in different netns than the lower device.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration for ipvlan.

The new dying flag in struct ipvl_dev is used to avoid a race
that ipvlan_link_delete() is called while its lower device is
being removed in ipvlan_device_event().

If dying is true in ipvlan_link_delete(), the ipvlan device is
already destructed but not yet unregistered.  In this case,
unregistration will be done in __rtnl_net_unlock() of the
->dellink() caller.

Tested:

1. Create veth in ns1 and two ipvlan devices in ns2 and ns3.

  # ip netns add ns1
  # ip netns add ns2
  # ip netns add ns3
  # ip -n ns1 link add veth0 type veth peer veth1
  # ip -n ns2 link add ipvl2 link veth0 link-netns ns1 type ipvlan mode l2
  # ip -n ns3 link add ipvl3 link veth0 link-netns ns1 type ipvlan mode l2

2. Run bpftrace to check that veth is unregistered first but
   wait ipvlan to be unregistered

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:ipvlan_uninit,
  kprobe:veth_dellink,
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

3. Remove the lower veth0 in ns1.

  # ip -n ns1 link del veth0

We can see that veth0 is freed after unregistering ipvl2 and ipvl3
in per-netns work because ipvl_port holds refcount of veth0.

  PID: 2010 | DEV: veth0
          veth_dellink+5
          rtnl_dellink+1213
          rtnetlink_rcv_msg+1791
  ...
  PID: 440 | DEV: ipvl2
          ipvlan_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 440 | DEV: ipvl2
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...
  PID: 440 | DEV: ipvl3
          ipvlan_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 2010 | DEV: veth0
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
  ...
  PID: 440 | DEV: ipvl3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ipvlan/ipvlan.h      |  6 ++++--
 drivers/net/ipvlan/ipvlan_main.c | 22 ++++++++++++++--------
 drivers/net/ipvlan/ipvtap.c      |  8 +++++---
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 9d3835c14e5e..8d05ad480438 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -69,6 +69,7 @@ struct ipvl_dev {
 	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
 	netdev_features_t	sfeatures;
 	u32			msg_enable;
+	bool			dying;
 };
 
 struct ipvl_addr {
@@ -169,7 +170,8 @@ void ipvlan_count_rx(const struct ipvl_dev *ipvlan,
 		     unsigned int len, bool success, bool mcast);
 int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 		    struct netlink_ext_ack *extack);
-void __ipvlan_link_delete(struct net_device *dev, struct list_head *head);
+void __ipvlan_link_delete(struct net *net, struct net_device *dev,
+			  struct list_head *head);
 void ipvlan_link_setup(struct net_device *dev);
 int ipvlan_link_register(struct rtnl_link_ops *ops);
 #ifdef CONFIG_IPVLAN_L3S
@@ -209,7 +211,7 @@ static inline bool netif_is_ipvlan_port(const struct net_device *dev)
 }
 
 #if IS_ENABLED(CONFIG_IPVTAP)
-extern void (*__ipvtap_dellink_ptr)(struct net_device *dev,
+extern void (*__ipvtap_dellink_ptr)(struct net *net, struct net_device *dev,
 				    struct list_head *head);
 #endif
 
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 6d7479a8a9c6..ee46a55f73d1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -8,7 +8,7 @@
 #include "ipvlan.h"
 
 #if IS_ENABLED(CONFIG_IPVTAP)
-void (*__ipvtap_dellink_ptr)(struct net_device *dev,
+void (*__ipvtap_dellink_ptr)(struct net *net, struct net_device *dev,
 			     struct list_head *head);
 EXPORT_SYMBOL(__ipvtap_dellink_ptr);
 #endif
@@ -706,7 +706,8 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_new);
 
-void __ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+void __ipvlan_link_delete(struct net *net, struct net_device *dev,
+			  struct list_head *head)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
@@ -721,7 +722,7 @@ void __ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 
 	ida_free(&ipvlan->port->ida, dev->dev_id);
 	list_del_rcu(&ipvlan->pnode);
-	unregister_netdevice_queue(dev, head);
+	unregister_netdevice_queue_net(net, dev, head);
 	netdev_upper_dev_unlink(ipvlan->phy_dev, dev);
 }
 EXPORT_SYMBOL(__ipvlan_link_delete);
@@ -731,7 +732,8 @@ static void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 
 	mutex_lock(&ipvlan->port->pnodes_lock);
-	__ipvlan_link_delete(dev, head);
+	if (!ipvlan->dying)
+		__ipvlan_link_delete(dev_net(dev), dev, head);
 	mutex_unlock(&ipvlan->port->pnodes_lock);
 }
 
@@ -827,22 +829,26 @@ static int ipvlan_device_event(struct notifier_block *unused,
 			ipvlan_migrate_l3s_hook(oldnet, newnet);
 		break;
 	}
-	case NETDEV_UNREGISTER:
+	case NETDEV_UNREGISTER: {
+		struct net *net = dev_net(dev);
+
 		if (dev->reg_state != NETREG_UNREGISTERING)
 			break;
 
 		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode) {
+			ipvlan->dying = true;
+
 #if IS_ENABLED(CONFIG_IPVTAP)
 			if (ipvlan->dev->rtnl_link_ops != &ipvlan_link_ops)
-				__ipvtap_dellink_ptr(ipvlan->dev, &lst_kill);
+				__ipvtap_dellink_ptr(net, ipvlan->dev, &lst_kill);
 			else
 #endif
-				__ipvlan_link_delete(ipvlan->dev, &lst_kill);
+				__ipvlan_link_delete(net, ipvlan->dev, &lst_kill);
 		}
 
 		unregister_netdevice_many(&lst_kill);
 		break;
-
+	}
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			netif_inherit_tso_max(ipvlan->dev, dev);
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 99eaa29057b4..66c949d94261 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -109,13 +109,14 @@ static int ipvtap_newlink(struct net_device *dev,
 	return err;
 }
 
-static void __ipvtap_dellink(struct net_device *dev, struct list_head *head)
+static void __ipvtap_dellink(struct net *net, struct net_device *dev,
+			     struct list_head *head)
 {
 	struct ipvtap_dev *vlantap = netdev_priv(dev);
 
 	netdev_rx_handler_unregister(dev);
 	tap_del_queues(&vlantap->tap);
-	__ipvlan_link_delete(dev, head);
+	__ipvlan_link_delete(net, dev, head);
 }
 
 static void ipvtap_dellink(struct net_device *dev,
@@ -125,7 +126,8 @@ static void ipvtap_dellink(struct net_device *dev,
 	struct ipvl_port *port = vlantap->vlan.port;
 
 	mutex_lock(&port->pnodes_lock);
-	__ipvtap_dellink(dev, head);
+	if (!vlantap->vlan.dying)
+		__ipvtap_dellink(dev_net(dev), dev, head);
 	mutex_unlock(&port->pnodes_lock);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


