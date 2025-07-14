Return-Path: <netdev+bounces-206863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1FB04A76
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6024B4A1F74
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF3287519;
	Mon, 14 Jul 2025 22:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE848280327
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531541; cv=none; b=JYnrNDym+OF8K9rXv23yfiXNLqj4A9KPi98xAi4v8N3uqbbMNgepY4Me8A0BrM5FmuVp6KfIidDIQt+AxEmh88BlBjg+cH3Y763ADl7X9X5WsQNkakhOE769Km6C/PiKwwJMh+q6gbWgmvRmffA9HZcyTZS/txFPmkiT6Lo1k+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531541; c=relaxed/simple;
	bh=n/YwMp/KXAufzroXMmt1WnMTazBjq+0eqBynwPiQdRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBeF92kLKSg+N7lzaMVruBocnl/Z5BqEMMoh2l3zn2cb9plSNteBBx3Ymk/BIZzycEjRIMmWbcFNgGlR8p7eyUHdkX2AJLvpihsWeuwES8jC8LZitc7H5EGRk1B6wS+B0nGEzRmrIW8kSXTJUzl+SsfSv+R0cWDiW3nGclbvvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34c068faf8so5036194a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531539; x=1753136339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF4q5oGffvxbB7aXBzUZCMsmy/foIMEZSNKnmYkplsY=;
        b=G7RKe8T2zfAXEo/eeWumi5g7MDs5cif9KZWbHBnZOsAJgTRmxPDbwfTF66TL0pjFlT
         rMlZaMpx/dWHc122IvhsUzZQMnjqZUUXimJuQqsJh6B0/ogrOmx2ndRrgVLHC7+d05b4
         HB2WHyFRRF0JWMhndOtF6N7HBaQXUw/rW5IdIR+zOPDzY1kTSi3I24B0u+fDBtME+aBY
         GntfkpV8sdeQZDMlptAbjz4VOIkC0eBozXiBTh8HCiuRzCQ9d4yJl3Vywzwp8NBcB2z4
         rRkUIcsqp93ghEa1Fotq7m+M3MTpJByXYORKqsSrlPHinAU/L/l4vaRb2o/4Pmmv0LZ8
         Y9DA==
X-Gm-Message-State: AOJu0YwBuorF140b+HcKqfGaLQBXsrX6uvE5ffDrbbm2ARJT3RxR3ldu
	pD/KzcYrvvn8S3HJIfkAY5BvtLmLNU04SvWjD2UeCj7aVjW0dr+hVq/FPdvX
X-Gm-Gg: ASbGncvZvo144jdbMpaLfTfyP3MqpoYebDF3XtoPZYsJm/MHzyLrQthTgE/pgDS0l2h
	5mLpsMOx7ZV9TzGsLaAPr0GLO9lJS63GcX3FwESDjrCVoRnzgZStXWR6QwkA8yeOu4ffHtfwB/O
	PMZR7bfVokL56OkDzMwoUIl98pp4WP6wVF53Z+XOOpDj2R6PR90g5oRnHUXnna8hCtmBa5iRn1h
	C9a0lyZs1Eua4d57SaXx7Q2XDgF07Y/Fl1HQmx/hFjpId+UChpfTVdaGqsngwiy+mVq/pSyW8sV
	FaxaR8k+KID2sJM1j6XKAWzSkxAo2ko7ynnilMH+eNHpgazw6dWa6YptsaK/pvxo1/7tyDgnnlv
	bKyADlV3HQH5qC3co2Z56A0WxBva59ksM4UBf5RTC0IbMrvXMjHTnF6wMM9c=
X-Google-Smtp-Source: AGHT+IGHG3QdFIlcf2ZJzETKE27Akr9lQES/MgEndF405KpAz2pqmY+EY+aKLE3sglXhd9f0YBsabA==
X-Received: by 2002:a17:90b:1c05:b0:311:ad7f:329c with SMTP id 98e67ed59e1d1-31c4ccea7bfmr24787542a91.18.1752531538659;
        Mon, 14 Jul 2025 15:18:58 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c3eb45c7csm10889152a91.25.2025.07.14.15.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:18:58 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 1/7] net: s/dev_get_port_parent_id/netif_get_port_parent_id/
Date: Mon, 14 Jul 2025 15:18:49 -0700
Message-ID: <20250714221855.3795752-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714221855.3795752-1-sdf@fomichev.me>
References: <20250714221855.3795752-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
 include/linux/netdevice.h                     |  4 +--
 net/bridge/br_switchdev.c                     |  2 +-
 net/core/dev.c                                | 25 ++++++++++---------
 net/core/net-sysfs.c                          |  2 +-
 net/core/rtnetlink.c                          |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index fef418e1ed1a..32c07a8b03d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5446,7 +5446,7 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 		goto err_action_counter;
 	}
 
-	err = dev_get_port_parent_id(priv->netdev, &ppid, false);
+	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
 		memcpy(&key, &ppid.id, sizeof(key));
 		mlx5_esw_offloads_devcom_init(esw, key);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a80d21a14612..a8a275fb05c3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4222,8 +4222,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
-int dev_get_port_parent_id(struct net_device *dev,
-			   struct netdev_phys_item_id *ppid, bool recurse);
+int netif_get_port_parent_id(struct net_device *dev,
+			     struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
 
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..1385ff604bbd 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -834,7 +834,7 @@ int br_switchdev_port_offload(struct net_bridge_port *p,
 	struct netdev_phys_item_id ppid;
 	int err;
 
-	err = dev_get_port_parent_id(dev, &ppid, false);
+	err = netif_get_port_parent_id(dev, &ppid, false);
 	if (err)
 		return err;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index e365b099484e..3567cd09920e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9815,16 +9815,17 @@ int dev_get_phys_port_name(struct net_device *dev,
 }
 
 /**
- *	dev_get_port_parent_id - Get the device's port parent identifier
- *	@dev: network device
- *	@ppid: pointer to a storage for the port's parent identifier
- *	@recurse: allow/disallow recursion to lower devices
+ * netif_get_port_parent_id() - Get the device's port parent identifier
+ * @dev: network device
+ * @ppid: pointer to a storage for the port's parent identifier
+ * @recurse: allow/disallow recursion to lower devices
+ *
+ * Get the devices's port parent identifier.
  *
- *	Get the devices's port parent identifier
+ * Return: 0 on success, -errno on failure.
  */
-int dev_get_port_parent_id(struct net_device *dev,
-			   struct netdev_phys_item_id *ppid,
-			   bool recurse)
+int netif_get_port_parent_id(struct net_device *dev,
+			     struct netdev_phys_item_id *ppid, bool recurse)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	struct netdev_phys_item_id first = { };
@@ -9843,7 +9844,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 		return err;
 
 	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = dev_get_port_parent_id(lower_dev, ppid, true);
+		err = netif_get_port_parent_id(lower_dev, ppid, true);
 		if (err)
 			break;
 		if (!first.id_len)
@@ -9854,7 +9855,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL(dev_get_port_parent_id);
+EXPORT_SYMBOL(netif_get_port_parent_id);
 
 /**
  *	netdev_port_same_parent_id - Indicate if two network devices have
@@ -9867,8 +9868,8 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 	struct netdev_phys_item_id a_id = { };
 	struct netdev_phys_item_id b_id = { };
 
-	if (dev_get_port_parent_id(a, &a_id, true) ||
-	    dev_get_port_parent_id(b, &b_id, true))
+	if (netif_get_port_parent_id(a, &a_id, true) ||
+	    netif_get_port_parent_id(b, &b_id, true))
 		return false;
 
 	return netdev_phys_item_id_same(&a_id, &b_id);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8f897e2c8b4f..f7a6cc7aea79 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -687,7 +687,7 @@ static ssize_t phys_switch_id_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = dev_get_port_parent_id(netdev, &ppid, false);
+	ret = netif_get_port_parent_id(netdev, &ppid, false);
 	if (!ret)
 		ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a9555bfc372f..108995b6eced 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1448,7 +1448,7 @@ static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_phys_item_id ppid = { };
 	int err;
 
-	err = dev_get_port_parent_id(dev, &ppid, false);
+	err = netif_get_port_parent_id(dev, &ppid, false);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3a2044e6033d..e86a8a862c41 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -901,7 +901,7 @@ static int vif_add(struct net *net, struct mr_table *mrt,
 			vifc->vifc_flags | (!mrtsock ? VIFF_STATIC : 0),
 			(VIFF_TUNNEL | VIFF_REGISTER));
 
-	err = dev_get_port_parent_id(dev, &ppid, true);
+	err = netif_get_port_parent_id(dev, &ppid, true);
 	if (err == 0) {
 		memcpy(v->dev_parent_id.id, ppid.id, ppid.id_len);
 		v->dev_parent_id.id_len = ppid.id_len;
-- 
2.50.0


