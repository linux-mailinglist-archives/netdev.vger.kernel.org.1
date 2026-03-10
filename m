Return-Path: <netdev+bounces-265912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJGPIZHMr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:47:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8F24698E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD323059FC6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A02362127;
	Tue, 10 Mar 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayD+6jEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D13363C53
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128817; cv=none; b=rYVK7T57CYIzUV8zMy+3GlLp92fmBCexgb8L5mKOOM8hanvTwZ1mEZUip/d++oek+RYUkMrtkoNegeNMlH5yyMbQL53rc+PA5QhNIvtWV5z4FrS6a4nXwn61CptTRL0C7PmzehJUpzKBzApxEJLYxIGbZQ1zzOuPBlfruLkq3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128817; c=relaxed/simple;
	bh=o63DNLwMJ9dnH9VRG7yBQJ58q0sgrk58BDknwrX9fmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WARN3xV8aPUGUaYaJvcT3phHdTx4+PsNcYxnTnvzCsJGo2I9mVW4Z4WKK3MWTmdNwW1bExXcOyw5Z/7VEY6egfYyHTuRGVnzLpCS4vvsk/aFS+9uWIlelboO3yvmrZVpNs3SKbOsdUQiqcnkppunByVlWbYwN3W1YQEtsJj+BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayD+6jEq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso6906792a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128814; x=1773733614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZszkswRmv7zKXo3BtgB+URbNhojevOx1NtYtxreOH/Y=;
        b=ayD+6jEqXAwFT3qihwGehyMF6KA77cxiOHOT27j9yTl063cDtkiu1kHNZOf05mBIVb
         lShaWhgkxsh+F6MyIiiI1rVBrEzREQc6nt7XsQHYZM4mCdlLcVyAIzNqrT7ENXWyVNs9
         ZCBxo4WD/RukRV6Be07Mse9obZavWyAdnOZBs3p88m7r92xvL/TTj5o7WhB2CDcIqmtj
         582ogt+ZxQ7WXdbgE5bHI+FjnKQmSykB5IqN3UOSRHAitO8v3LbmBHcdFkPrphbsnzp1
         yO/DqHG8bnikiz5GPD0E1eedabn8GoXIVU62keqL0fnbDZ1S3/bEbvOR6Vjhn5o/xt5a
         jNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128814; x=1773733614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZszkswRmv7zKXo3BtgB+URbNhojevOx1NtYtxreOH/Y=;
        b=vEE2CxYpqbSbxskVZnYU549vI++d/zKbBdcHcEanvQnskGHgaBDpn/wawGMNigFW2L
         CbLzq+QcxRBPlO7aeksKZIYkWK436vXs1WS/lXy/YXoOUYFAmE8yGGWrzNPTnIb39Cum
         lp6Okgk3cyXAzJK3scpeO/to5vIiW5ISV0iA5NttkBJ3l+Ukn6fCbuUbo4ZX6ydVsNWV
         QfZ/OnYrpjJPljHeg+8j1cJ0q72vUXj3POvHA68JLJZ02jfVslxIe5v6dU2PsYY6eh8J
         8BoBSWt41kEpjcu7GuUy17TVGI5YOg3TY/Y/lSa4Ld/gVi9g6OdLTYcN3VAIQ3b6Ll9R
         JI8g==
X-Gm-Message-State: AOJu0YzlVTOsWZztTq3WZ4cUMu5BUI3w4herHCTinG3BHoRrkTfFWv0u
	ZaROYWbBLYIBCN6JhELKhjMIzugxeoDF3hlY16WVI3J3uZkekBWvrbF2
X-Gm-Gg: ATEYQzwKDvmEqe2n9t58+jnOnoN+o+OtDi/vNDTUG9Gee2hw6L1+CdhLE9dq9XQpnZ2
	yHqrRYJD4Pfo++zjZIDyRnwwuKi2rnS0Gox9NyEcmJ3vcjin14ikR+3Uqp3yUG1NWTBq6iiqaAM
	8r5II4nyXTgIQzRZDFYzZrNrEsQy09ofMia3MwOSKN/T+dOyiFOy+L54VYAwWgxxJdFfmtEu6qU
	l3uOaKeFtcfV8p/PY4NxwwuyCsifjXHCnORQFRw+g2IWaPRQNmmQTm7MKpWXOTYWIsyPVqmqLzL
	EZG8wDBPQepWOAnJHBPUYDp8rL4l/RVP6CwjVDOVAnR74xBcw6xXrPY0s9K6nwZ4Dy41xlyRTk5
	ljTOP+lEfi+PK6pO6wNEWFhDNUZjyVidlUKrpLfuXR44JURfWw9ackOw1hLVUuqthYaErgqAE6H
	+9yIpc0DCf9gGF7XO1yo9TlGYKc51qkTPgwM8rtLp9ka2iRnIozeDSMXzN1VRF4cLjZxk0OZJe9
	NBrNVpijfeDLzKPlJhlEBGTKJrIRYu1Y88xrFkbEf9jRCYrN2FFeg==
X-Received: by 2002:a17:90b:3f8f:b0:359:f8c3:dada with SMTP id 98e67ed59e1d1-359f8c3e121mr363546a91.13.1773128813962;
        Tue, 10 Mar 2026 00:46:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:46:53 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 10 Mar 2026 15:45:05 +0800
Subject: [PATCH net-next 1/3] net: use ndo_set_features to set offload
 features for bonding/bridge/team
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-offload_compute-v1-1-3df79c09ea65@gmail.com>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
In-Reply-To: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: E0B8F24698E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert bonding, bridge, and team drivers to use ndo_set_features callback
instead of manually calling netdev_compute_master_upper_features() during
port add/remove operations.

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
        - ndo_set_features()
          - netdev_compute_master_upper_features()

This ensures offload features are computed automatically when
upper/lower device links change, removing the need for manual
feature computation calls in the driver code.

The netdev_change_features() call in team_uninit() is also removed
since it calls team_port_del() for each port, which now triggers
feature updates automatically.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 11 ++++++++---
 drivers/net/team/team_core.c    | 12 ++++++++----
 net/bridge/br_device.c          |  7 +++++++
 net/bridge/br_if.c              |  4 ----
 net/core/dev.c                  |  8 ++++++--
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0ccf928eecde..4d32b06079ee 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1509,6 +1509,12 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int bond_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, true);
+	return 0;
+}
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -2228,7 +2234,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2483,7 +2488,6 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -3975,7 +3979,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			netdev_compute_master_upper_features(bond->dev, true);
+			netdev_change_features(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -5897,6 +5901,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_add_slave		= bond_enslave,
 	.ndo_del_slave		= bond_release,
 	.ndo_fix_features	= bond_fix_features,
+	.ndo_set_features	= bond_set_features,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
 	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index b7282f5c9632..4906ea3717b1 100644
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
@@ -1972,6 +1969,12 @@ static netdev_features_t team_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int team_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, true);
+	return 0;
+}
+
 static int team_change_carrier(struct net_device *dev, bool new_carrier)
 {
 	struct team *team = netdev_priv(dev);
@@ -2007,6 +2010,7 @@ static const struct net_device_ops team_netdev_ops = {
 	.ndo_add_slave		= team_add_slave,
 	.ndo_del_slave		= team_del_slave,
 	.ndo_fix_features	= team_fix_features,
+	.ndo_set_features	= team_set_features,
 	.ndo_change_carrier     = team_change_carrier,
 	.ndo_features_check	= passthru_features_check,
 };
@@ -2944,7 +2948,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			netdev_compute_master_upper_features(port->team->dev, true);
+			netdev_change_features(port->team->dev);
 			port->team->notifier_ctx = false;
 		}
 		break;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f7502e62dd35..f82082050e36 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -289,6 +289,12 @@ static netdev_features_t br_fix_features(struct net_device *dev,
 	return br_features_recompute(br, features);
 }
 
+static int br_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, false);
+	return 0;
+}
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void br_poll_controller(struct net_device *br_dev)
 {
@@ -456,6 +462,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_add_slave		 = br_add_slave,
 	.ndo_del_slave		 = br_del_slave,
 	.ndo_fix_features        = br_fix_features,
+	.ndo_set_features        = br_set_features,
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
index 6fc9350f0be8..ce1d9c73e6ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8919,6 +8919,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
 
+	/* re-compute all features after adding link */
+	netdev_change_features(upper_dev);
+
 	return 0;
 
 rollback:
@@ -9011,6 +9014,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
 	__netdev_update_lower_level(upper_dev, priv);
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
+
+	/* re-compute all features after removing link */
+	netdev_change_features(upper_dev);
 }
 
 /**
@@ -12873,8 +12879,6 @@ void netdev_compute_master_upper_features(struct net_device *dev, bool update_he
 
 	netif_set_tso_max_segs(dev, tso_max_segs);
 	netif_set_tso_max_size(dev, tso_max_size);
-
-	netdev_change_features(dev);
 }
 EXPORT_SYMBOL(netdev_compute_master_upper_features);
 

-- 
Git-155)


