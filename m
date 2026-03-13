Return-Path: <netdev+bounces-267490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CF0L64ntGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766428586F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED6732CF938
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E183AEF57;
	Fri, 13 Mar 2026 14:51:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B513AEF5C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413482; cv=none; b=PW993YjUnp5UpZV0GtJ4O+iHcFo0RX0cZ5kAQeMJvIEHYiS3VTH+N+YajnyqSqiBWJG2V9M+XHY8xhUt3GyO9eKr/dIOgvZyXLlgwrA7WRYUz0Sy4loWLfgnKdvs17jt+1r0spPMQHA23gLHBgLqfWV8vNq+pC4INKmVzLrNZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413482; c=relaxed/simple;
	bh=Ox2ei4h2tAR7ypg+P25196/As4ti2WceOPIsJT/iHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V43gZ/jiOyZtoA5AC4OGh3ZhA4E4ioqkWueelc3tFBOXHOoRaEXDpeZOr7jTlM/MGg50bl4QpDA1ZabQUgPLUCNCpu9RYSNKpPeYL/QOiBtN4NhiRvDty1En9k0XFVQejSxJ3AjjswHphmDIZdAkulqnhFbnwpW0R5qQiBYDmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be9c886a0fso2937195eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413480; x=1774018280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rw4PNOArPdEXsi9AQFyNFnSlGmCZ/hPaUqwpjsbqQVg=;
        b=b8coEXsywsqwew3z0/52BYP5h+TbJ3rIMlhz6iSagdlFdKAlExLUQFHKC1h9scdk0P
         SVzOePT+4W31UgSc9An6mMQKFz5n8MSQBHcWzCDSPNiUq/RUUPasbX9mFfHMstwBj9Xy
         WuLO3VjQiaNcXCzf5OnThe6bgFieNejPtAkZuUq7M6iGz4Ayt7QWPcdusIls25WZpy75
         cXjSr43zzbyCvl8M/dFwojvBK5DnkGz8NoAWD6q4xpVsRZuZQ8s0ADKnJG4vrQzfrPjP
         +O8oUzPOn9T6xL1Sk8AeTqLzpBdkiE1B71eL9ruPg6shHY4/xj8CjsFuK+CXPy22zK6b
         e9DA==
X-Gm-Message-State: AOJu0Yz+SMpOadZSEfLtPd8K0gaY7CVM4hYLLEATJ8cuH1KmWqPk+JOL
	2Q4SC5epK+/49Ql94pypv4wy5Mj8AcwLuWO2nD9hg2NBEk25IGCCRP9wUHJL
X-Gm-Gg: ATEYQzx+asn0ivRDEKyw60CoecSz3dGduiIPh4784x3bP/IWO1EskG1mZGw3SOIJqDY
	Y+1afHnWRFIRLKBiv+cbFnUYHK1Yz5U6aPjAiJvVnTdY78DSSxBHNPWEfzXMc4Fu8JXba1sk9Ly
	y122q7RURJneZ/JBoFqV45iAqqvEMPNV3931Ozs4QYnWHCS2OiKg3JjoVDqJe8uXdWcDbZ4JUNp
	c0q/Fl6M9Eg4ur+x54rSxJvaDLChT1HFiNL8McbgVIBCTEdsKfo18vU7Ks5Td3y+feDfLG0rwId
	wGoKMBibmG+I+pLw09YQZOvgZg9JJuCoNw9YLjU4xsE2c/LaDEBcuVKWxBbAIMBpc5ahHtyeaVi
	B7zh2wK58TAUcO/57p6ZVdi+VOoUN01u2LgyF88ieH7jncaLklVCa5Jimcj0ZhZ5EEWqB5G+JTt
	ZoL3lZdk9CoHXZ0C2hMZq5MT/cFVxOeQYRT/pQqLBKNERwqkMCxu6EPqh1w7qFQ9l8haryRW1s3
	bfciVD7izF2tzWlaw==
X-Received: by 2002:a05:7300:a54c:b0:2ba:7606:ace0 with SMTP id 5a478bee46e88-2bea554b2d2mr1994702eec.25.1773413480091;
        Fri, 13 Mar 2026 07:51:20 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3eec52sm3154824eec.14.2026.03.13.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:19 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 05/11] mlx5: convert to ndo_set_rx_mode_async
Date: Fri, 13 Mar 2026 07:51:07 -0700
Message-ID: <20260313145113.1424442-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267490-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.957];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 6766428586F
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
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 33 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 16 ++++++---
 3 files changed, 40 insertions(+), 14 deletions(-)

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
index 9352e2183312..3469b5a197db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -610,20 +610,31 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
 }
 
 static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
-				   struct net_device *netdev)
+				   struct net_device *netdev,
+				   struct netdev_hw_addr_list *uc,
+				   struct netdev_hw_addr_list *mc)
 {
 	struct netdev_hw_addr *ha;
+	bool unlock = false;
 
-	netif_addr_lock_bh(netdev);
+	if (!uc || !mc) {
+		uc = &netdev->uc;
+		mc = &netdev->mc;
+
+		netif_addr_lock_bh(netdev);
+		unlock = true;
+	}
 
 	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
-	netdev_for_each_uc_addr(ha, netdev)
+
+	netdev_hw_addr_list_for_each(ha, uc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
 
-	netdev_for_each_mc_addr(ha, netdev)
+	netdev_hw_addr_list_for_each(ha, mc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
 
-	netif_addr_unlock_bh(netdev);
+	if (unlock)
+		netif_addr_unlock_bh(netdev);
 }
 
 static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs, int list_type,
@@ -725,7 +736,9 @@ static void mlx5e_apply_netdev_addr(struct mlx5e_flow_steering *fs)
 }
 
 static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
-				     struct net_device *netdev)
+				     struct net_device *netdev,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_hash_node *hn;
 	struct hlist_node *tmp;
@@ -737,7 +750,7 @@ static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
 		hn->action = MLX5E_ACTION_DEL;
 
 	if (fs->state_destroy)
-		mlx5e_sync_netdev_addr(fs, netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
 
 	mlx5e_apply_netdev_addr(fs);
 }
@@ -821,7 +834,9 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 }
 
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
-			       struct net_device *netdev)
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_table *ea = &fs->l2;
 
@@ -851,7 +866,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	if (enable_broadcast)
 		mlx5e_add_l2_flow_rule(fs, &ea->broadcast, MLX5E_FULLMATCH);
 
-	mlx5e_handle_netdev_addr(fs, netdev);
+	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 
 	if (disable_broadcast)
 		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..e86cf1ee108d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4108,11 +4108,16 @@ static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
-static void mlx5e_set_rx_mode(struct net_device *dev)
+static void mlx5e_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	mlx5e_nic_set_rx_mode(priv);
+	if (mlx5e_is_uplink_rep(priv))
+		return; /* no rx mode for uplink rep */
+
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
 }
 
 static int mlx5e_set_mac(struct net_device *netdev, void *addr)
@@ -5287,7 +5292,7 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_setup_tc            = mlx5e_setup_tc,
 	.ndo_select_queue        = mlx5e_select_queue,
 	.ndo_get_stats64         = mlx5e_get_stats,
-	.ndo_set_rx_mode         = mlx5e_set_rx_mode,
+	.ndo_set_rx_mode_async   = mlx5e_set_rx_mode,
 	.ndo_set_mac_address     = mlx5e_set_mac,
 	.ndo_vlan_rx_add_vid     = mlx5e_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid    = mlx5e_vlan_rx_kill_vid,
@@ -6272,8 +6277,11 @@ void mlx5e_set_rx_mode_work(struct work_struct *work)
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


