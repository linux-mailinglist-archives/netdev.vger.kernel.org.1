Return-Path: <netdev+bounces-274729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F7NDWb0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:57:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A584B38EEB7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805CA3050D7E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB363D6CA4;
	Thu,  2 Apr 2026 22:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2083D566E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170545; cv=none; b=WA+JPJM3yAMP8NUltR56NLtJxqPu7S72Y8S1QNnLN+BOnTdCpYAEEhV3voBpYkkftgzD/GPS/V/bEUM7jfSlij2m+57PjuZycF96bsqqT1rlzlaIQsidbAF0enMf3v9Bn3mYLZ7CNWDTuumHYxjvYHcPLrdoQHl+SgoeutJ2Ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170545; c=relaxed/simple;
	bh=f+3FGjn+bTn2MUx854WfUPPHF70DXDJ5xOJzwBUnKTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLVEtwBRQX+x1ol5ZixnPXQHXumP+2EV7PBxGkV2kw8Luy+gvsuvibj3j+6XYzRAAw1zAW75vKeseV3SWzdAx613KKrgwS4cSDfc2qVsUfr04vSOtzZE4e9lkQzlPo1mcsm8chc4hV4d/4TNEoQ8fdc9kEQPg0mQwrJsApvxGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1683894eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170543; x=1775775343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NaOx4GTxvD1M91hwtK7bQbqsfJer30MFL33W9rn/uh4=;
        b=Xy2ia7NLvd6G7I2fGC68+3KutOb6GPdz2Tw3VegcSVJWltf1EMcU6DLzcQLo4yyL/D
         WFg7+He0qBVJOMUsd4kT4vhXpUkgSfv1Sn5eQz40wUruBb3qmKq4a+4jdlLh6k2InY8T
         uUB/z7ShLCW3/ziLKsHF+74r1KFDmr94qf9Uz26HLM4IQ1ijxlH8SKbFC9SRkoi+k2tW
         t2mGKIHTTvmyGVJ7AWqB6lTCRYoWkEmOkJm5gzsJSDyeUQR+h2Xhn687ElP05S0h6sWG
         CusMweZ7cttraS7upS+Q7VudBwz39JJmcC6j19rDgzw0+d2kAv4jZjk9LQcNbzwHJgMg
         HgCA==
X-Gm-Message-State: AOJu0YzPyWW8hra7LPkJapswaPB+JUdX7FQk36I/qWLteNOnY01HfGE+
	LZLt44da5vvX8q0ucA5Go1PnMdx5lhdU40nICfjeuEwQ3i1vHLEG410COooO
X-Gm-Gg: ATEYQzwIPADf89/m0yXQGgky1SxY4I0rE1td0wTQ8r3hAG5CjWu3EKbHtkVoGnrqiVu
	bI0xEscx423peWnaPRAL/u1lVAXNJg9dGHYxAaj6GdP7Jx0eneTOTxBG5jMwh0SBpdQpGYwvv7Z
	gKDSN2dxEqiVUyWlpMri1DT+gZ4XmyZO75s+0IN6ddu6Nfcm8cpLQ2jEdp8D5/qMNDLUrgFcmkK
	Z9GG9FQBTNQd3iqNOh1F5uP1NOb8hYABszSFSwBuUOyPTN8+nou1coNYK3o6na3NqtT/PoA2KdT
	3ZU1nf3DGYOIiq4+XBxLbeGHOvR2jR9jm5ugOJQ/nvwKAOpjla2Xsg6Xx5TItVdOfIVmy0YQWFu
	A//sWEVve3gU5tUGiV7DSe7mbJN08HStkq7nenrvhjyBrkf85idgRfNXet9wMTfZ4QgbXR6ASJ1
	it+VLvll+Ii7GeDOq7UIxio4t1uAgqLq7BgC/M8Uguj4SvtHL2+q4F5GQ8BPBZHs+QMiyhnf0Bo
	nMj/JZ2U+rym+UJew==
X-Received: by 2002:a05:7022:10d:b0:12b:f616:1a4e with SMTP id a92af1059eb24-12bfb745ebcmr386390c88.23.1775170542862;
        Thu, 02 Apr 2026 15:55:42 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede54ba8sm5048663c88.10.2026.04.02.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:42 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 06/14] mlx5: convert to ndo_set_rx_mode_async
Date: Thu,  2 Apr 2026 15:55:27 -0700
Message-ID: <20260402225535.4124525-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274729-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,fomichev.me:email,fomichev.me:mid,intel.com:email]
X-Rspamd-Queue-Id: A584B38EEB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
mlx5e_fs_set_rx_mode_work directly instead of queueing work.

mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

Fallback to netdev's uc/mc in a few places and grab addr lock.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 32 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 13 +++++---
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index c3408b3f7010..091b80a67189 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_nu
 void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
 int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_num);
 void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
-void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs, struct net_device *netdev);
+void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc);
 int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
 			     struct net_device *netdev,
 			     __be16 proto, u16 vid);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index fdfe9d1cfe21..12492c4a5d41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -609,20 +609,26 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
 }
 
 static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
-				   struct net_device *netdev)
+				   struct net_device *netdev,
+				   struct netdev_hw_addr_list *uc,
+				   struct netdev_hw_addr_list *mc)
 {
 	struct netdev_hw_addr *ha;
 
-	netif_addr_lock_bh(netdev);
+	if (!uc || !mc) {
+		netif_addr_lock_bh(netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc, &netdev->mc);
+		netif_addr_unlock_bh(netdev);
+		return;
+	}
 
 	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
-	netdev_for_each_uc_addr(ha, netdev)
+
+	netdev_hw_addr_list_for_each(ha, uc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
 
-	netdev_for_each_mc_addr(ha, netdev)
+	netdev_hw_addr_list_for_each(ha, mc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
-
-	netif_addr_unlock_bh(netdev);
 }
 
 static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs, int list_type,
@@ -724,7 +730,9 @@ static void mlx5e_apply_netdev_addr(struct mlx5e_flow_steering *fs)
 }
 
 static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
-				     struct net_device *netdev)
+				     struct net_device *netdev,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_hash_node *hn;
 	struct hlist_node *tmp;
@@ -736,7 +744,7 @@ static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
 		hn->action = MLX5E_ACTION_DEL;
 
 	if (fs->state_destroy)
-		mlx5e_sync_netdev_addr(fs, netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
 
 	mlx5e_apply_netdev_addr(fs);
 }
@@ -820,13 +828,15 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 }
 
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
-			       struct net_device *netdev)
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_l2_table *ea = &fs->l2;
 
 	if (mlx5e_is_uplink_rep(priv)) {
-		mlx5e_handle_netdev_addr(fs, netdev);
+		mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 		goto update_vport_context;
 	}
 
@@ -856,7 +866,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	if (enable_broadcast)
 		mlx5e_add_l2_flow_rule(fs, &ea->broadcast, MLX5E_FULLMATCH);
 
-	mlx5e_handle_netdev_addr(fs, netdev);
+	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 
 	if (disable_broadcast)
 		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1238e5356012..45f5bacef255 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4105,11 +4105,13 @@ static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
-static void mlx5e_set_rx_mode(struct net_device *dev)
+static void mlx5e_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	mlx5e_nic_set_rx_mode(priv);
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
 }
 
 static int mlx5e_set_mac(struct net_device *netdev, void *addr)
@@ -5284,7 +5286,7 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_setup_tc            = mlx5e_setup_tc,
 	.ndo_select_queue        = mlx5e_select_queue,
 	.ndo_get_stats64         = mlx5e_get_stats,
-	.ndo_set_rx_mode         = mlx5e_set_rx_mode,
+	.ndo_set_rx_mode_async   = mlx5e_set_rx_mode,
 	.ndo_set_mac_address     = mlx5e_set_mac,
 	.ndo_vlan_rx_add_vid     = mlx5e_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid    = mlx5e_vlan_rx_kill_vid,
@@ -6269,8 +6271,11 @@ void mlx5e_set_rx_mode_work(struct work_struct *work)
 {
 	struct mlx5e_priv *priv = container_of(work, struct mlx5e_priv,
 					       set_rx_mode_work);
+	struct net_device *dev = priv->netdev;
 
-	return mlx5e_fs_set_rx_mode_work(priv->fs, priv->netdev);
+	netdev_lock_ops(dev);
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, NULL, NULL);
+	netdev_unlock_ops(dev);
 }
 
 /* mlx5e generic netdev management API (move to en_common.c) */
-- 
2.53.0


