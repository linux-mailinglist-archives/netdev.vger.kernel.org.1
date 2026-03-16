Return-Path: <netdev+bounces-268023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBxKOKmGt2mOSAEAu9opvQ
	(envelope-from <netdev+bounces-268023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:27:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C6C2948CF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89380300D14E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5332A3E5;
	Mon, 16 Mar 2026 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIZPvFKr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8A339708
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635239; cv=none; b=HIOLOqULLa0uov0ouus1XG6J9LPoCe5488J23lPiu8LS1HZgqZn17xDM44QHmp053JDcJWndFNRX5YXiBXggqRmb5kbC7DSBsJTcdW5wHBqdlp2RkVXPAReeL3c6haKTAIam7fk8uPi01ldT0LEatxBkX88rF1aPzfCmVI413vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635239; c=relaxed/simple;
	bh=uOA8Btfuyt1fRyZXJtbLTVld/QlqU0lmL5OyV/kUGLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pl/MawvQH/OuCxOdGdAI9WBuKAFd00hQ+5I4OPN7B1xhOiKEhp66Y/iHtLc0j7jC8PJw3+/ps0b1AVWzguOcrQ9f39wSfs4w/nHKPRvPzro6nD7NJyGj6Qu8Ps8fuUPqhqW6/kADiZUgRma/NBKG1zLNqFHYJ2kOu2ZtjFGFaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIZPvFKr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8296d553142so1746103b3a.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635238; x=1774240038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZnXe6ZII/Ekwqx2euSYzckFZIl5gweSRd+FY9OyPQE=;
        b=HIZPvFKrMiyOBDcpqGDJWdzUUe78cH4cfpR70RZJpuVsqASDtD71qTeRuP5s0vMmKv
         rrThqggMs7ncy8nFhzeBcGrpyto36HF9q2Wy+w7MpWtEdUzS81LgwDu/CEkUoFpUd0Yc
         fpDraKN84z9KA3JftfK0eCXmGX14nmZlsZRbpTZM/p6IuEm4kL6UsuB1Io4hF7iZSvvp
         mCpN+jMBFNefte7y+8nK7hvdnx0kSuAeZ92VpzdS5ucvEuL/IcWLKd/BtRrBnilop8Yh
         3650BIQ6JrfXn/TCvVUkd5C32NIGnneFuLci6aDsknrhPmeyvXuHHKdJhtsQ0ARXOe0N
         RwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635238; x=1774240038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XZnXe6ZII/Ekwqx2euSYzckFZIl5gweSRd+FY9OyPQE=;
        b=rBTH+g39P6Qxvrj7A2Rb9OujHSv3hEIHrJr8JYlhvYN5FKxjrfxPEtZy9dqxwYkLDy
         eYZMJWJDWF9sEEW8UK74xX5HCQrbc6uOLNYlwIe7k5I6E/ZdxkyCoYxag5prTzgez7TK
         DAbYftYzvqri3Xz0GxnBKDF8cB4ei26SLMfmvyPT/Gj1kdl7OanP6uRgBKVTuxMg+NH7
         Hd56G/thib31YeqrAIGEFE6xMsU1CfllzwXmVaovGsQpZ0LDcUfd0/QcRNN6LOinWicY
         I7S5DErdPuIbb/P/+0diCI0eqBtRpde+pVm5mYbGpf92kcUbU0TlajNnHw2dJxZ7QVXe
         Btwg==
X-Gm-Message-State: AOJu0YwbAhNvxYs8/S6mDquL0MqSRtEcl4JVYfd84a/8TwGkgmRIw7z9
	E1PE6S+vsthRnsxobgCAMZo5GGHsY1MY3DDqb8GV3asOFOeHmzqckBte
X-Gm-Gg: ATEYQzzu4cYgC2rKHiqJjv7CFHDZS9nYjcj+vWckAbwC/vXgQ11w+CqTBaEtvPBxYOF
	FKLRj9b2fgE81g5l0kWxMvg98+u4FRW8soWYuoDBYw8eRb+RLHGt1h5nWGhK0TIjtR3iFWtHIOt
	/n9P5BLjtbhMy9PIq0XLPddWg47A7TUWUsPxY1MIv3pTYfSyf2LGmp4NUuNVhPLB/iWK/ByfWRU
	Lc+izLJJnCZb849saz2Jjn8B4u64gTKutU1MzEIXSIjS/B5XT9I/bzTSO7iSF6PwsoT0xPRU3Ng
	WxWvETaIRzYcwjpwneIRIfpSN7ifU2QrTlibTZjX/yMEFkOMl2lBtQS3XHM+xlQ1cwDkwXoUyM5
	mjGls2XcFRIefC8Udc5CyE4KFcUKRGZ7BxF60Ngo1HipZeh8H0ZpD9BYJl50F8LJ4E/MYk+YiFb
	fTh0Ws7xG/2v6DH3aIxmi3UwUlAPAAIKfi7DHS4V91SF49+1WmIaatNZF0iA==
X-Received: by 2002:a05:6a00:a803:b0:82a:8aa:cbb6 with SMTP id d2e1a72fcca58-82a19925747mr10091291b3a.55.1773635237584;
        Sun, 15 Mar 2026 21:27:17 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:10 +0800
Subject: [PATCH net-next v3 2/5] net: use ndo_update_offloads to set
 offload features for bonding/bridge/team
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-2-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99C6C2948CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert bonding, bridge, and team drivers to use the new
ndo_update_offloads callback instead of manually calling
netdev_compute_master_upper_features() during port add/remove operations.

This change centralizes the feature computation flow:

Before:
- netdev_master_upper_dev_link()
- netdev_compute_master_upper_features()  <- called manually
  - compute offload features
  - netdev_change_features()
    - __netdev_update_features()
      - update other features

After:
- netdev_master_upper_dev_link()
  - __netdev_upper_dev_link()
    - netdev_change_features()
      - __netdev_update_features()
        - ndo_update_offloads()
          - netdev_compute_master_upper_features()
        - update other features

This ensures offload features are computed automatically when
upper/lower device links change, removing the need for manual
feature computation calls in the driver code.

The netdev_change_features() call in team_uninit() is also removed
since it calls team_port_del() for each port, which now triggers
feature updates automatically.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 10 +++++++---
 drivers/net/team/team_core.c    | 11 +++++++----
 net/bridge/br_device.c          |  6 ++++++
 net/bridge/br_if.c              |  4 ----
 net/core/dev.c                  |  8 ++++++--
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 90b71bd53040..ea6bb20f9348 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1509,6 +1509,11 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static void bond_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 			      unsigned short type, const void *daddr,
 			      const void *saddr, unsigned int len)
@@ -2273,7 +2278,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2528,7 +2532,6 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4026,7 +4029,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			netdev_compute_master_upper_features(bond->dev, true);
+			netdev_change_features(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -5953,6 +5956,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_add_slave		= bond_enslave,
 	.ndo_del_slave		= bond_release,
 	.ndo_fix_features	= bond_fix_features,
+	.ndo_update_offloads	= bond_update_offloads,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
 	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index b7282f5c9632..affbcc6fc130 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1247,7 +1247,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	netdev_compute_master_upper_features(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1337,7 +1336,6 @@ static int team_port_del(struct team *team, struct net_device *port_dev, bool un
 	}
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	netdev_compute_master_upper_features(team->dev, true);
 
 	return 0;
 }
@@ -1645,7 +1643,6 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	netdev_change_features(dev);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1972,6 +1969,11 @@ static netdev_features_t team_fix_features(struct net_device *dev,
 	return features;
 }
 
+static void team_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static int team_change_carrier(struct net_device *dev, bool new_carrier)
 {
 	struct team *team = netdev_priv(dev);
@@ -2007,6 +2009,7 @@ static const struct net_device_ops team_netdev_ops = {
 	.ndo_add_slave		= team_add_slave,
 	.ndo_del_slave		= team_del_slave,
 	.ndo_fix_features	= team_fix_features,
+	.ndo_update_offloads	= team_update_offloads,
 	.ndo_change_carrier     = team_change_carrier,
 	.ndo_features_check	= passthru_features_check,
 };
@@ -2944,7 +2947,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			netdev_compute_master_upper_features(port->team->dev, true);
+			netdev_change_features(port->team->dev);
 			port->team->notifier_ctx = false;
 		}
 		break;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f7502e62dd35..137cad13379b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -289,6 +289,11 @@ static netdev_features_t br_fix_features(struct net_device *dev,
 	return br_features_recompute(br, features);
 }
 
+static void br_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, false);
+}
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void br_poll_controller(struct net_device *br_dev)
 {
@@ -456,6 +461,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_add_slave		 = br_add_slave,
 	.ndo_del_slave		 = br_del_slave,
 	.ndo_fix_features        = br_fix_features,
+	.ndo_update_offloads	 = br_update_offloads,
 	.ndo_fdb_add		 = br_fdb_add,
 	.ndo_fdb_del		 = br_fdb_delete,
 	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d39571e13744..030248bc94c5 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -680,8 +680,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 
 	br_mtu_auto_adjust(br);
 
-	netdev_compute_master_upper_features(br->dev, false);
-
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 
 	return 0;
@@ -734,8 +732,6 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	netdev_compute_master_upper_features(br->dev, false);
-
 	return 0;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index bbd532aa6a1b..8bcbf7c22830 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8923,6 +8923,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
 
+	/* re-compute all features after adding link */
+	netdev_change_features(upper_dev);
+
 	return 0;
 
 rollback:
@@ -9015,6 +9018,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
 	__netdev_update_lower_level(upper_dev, priv);
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
+
+	/* re-compute all features after removing link */
+	netdev_change_features(upper_dev);
 }
 
 /**
@@ -12880,8 +12886,6 @@ void netdev_compute_master_upper_features(struct net_device *dev, bool update_he
 
 	netif_set_tso_max_segs(dev, tso_max_segs);
 	netif_set_tso_max_size(dev, tso_max_size);
-
-	netdev_change_features(dev);
 }
 EXPORT_SYMBOL(netdev_compute_master_upper_features);
 

-- 
Git-155)


