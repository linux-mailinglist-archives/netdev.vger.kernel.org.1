Return-Path: <netdev+bounces-18971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938F7593D4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B61C20FB6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3614ABE;
	Wed, 19 Jul 2023 11:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1A14A92
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:03:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102C186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B16RH+3IV4AqEncuZBg6HEFyjAxP7KcjNAb0UpmKCNyj8ARxlCzKqq6WyUXfw3venXoylAn9STlh9zTSvQjkRP1ReMBlk2clX7NB9W/FFgoRA8j4ue12ijuQKiT0mma4Z1eWGXuEKV6HnxnV/mnZqNvLpcrL93rN/OYsGFuhsRWD8Ei/7UgdEHdj3xfv7RddQoaeMg0jvel5LXzGEG8oiURjywCCEkG4aRSBbXDWCwDGqXIrlQcfxwBEe5Y0T94ncL4ru2n7su+IA4GLXqvntPKuMnnyzYXACCDgXc5xbX0+oWikQtcF/IjjDb6PNRZXsEgKflpVww7KErmAR2tYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn1XTbjXqXt1qRvEhkhBvfejGGYJ+424vvw7awi/jRc=;
 b=IeKo7cs7DRCHl2F0ymfhLfl2zWpLrloK7YX/4pCeNuMffbrDk4qimbjCAFV01zi/sXqvbfB8a47WPGP7H8NySSjM0+65F1RTPL7aDjsrsCugrYXRvo8ocbeVTV5BeI+1oHnPGzBqHQFBcTu4qQwmIbJYVBKTq+TprNjMZtVLIB+IvuolOrHaDdLIKFlTDkGJpK0av48oPXg6eb6CsgznqXDwkZHi16XSQ+B6ZMMDuH+MzdYwUPyEDczQrvVLc+pIwAnuJU34Y5ZIg4ivozm2IcpxYJno2jt08DUYC777DuQ6rlPisSx7sM858SIS/4ax13QAfFhFf4M9HiOAtxLefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn1XTbjXqXt1qRvEhkhBvfejGGYJ+424vvw7awi/jRc=;
 b=FWRnzf5jOD+jMKUzSJdYASQqEvw34DGhagSNAlkyFPO6hOXbiQvWGyu8d9Q1hCi8aEOw4YcyOLlA+pOs9nOMHGro/ZaSc+CIIyLnajWdf8XhKqTFXQotafcgu4qysBei5cQa4vhlFBbjlCrclYZDqZRdNj+0v6J9fGtaD21cxwne7aRi9Blokx15ImweIjxISAaLUmpReYqUchw9qIB79YdCqDCRXQMNWkQNs5SdvlEuIB8x78b0gCu6E5SKUp9f4PwZ5XiqJ5SMD1u/FM8GbhwA/FKU3a2COxdc1Jyg6MS2yzY1dcvLuad6jufBEqlnT/hYrg6KDm157M4qd3OTjA==
Received: from BN9PR03CA0166.namprd03.prod.outlook.com (2603:10b6:408:f4::21)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 11:02:58 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::d6) by BN9PR03CA0166.outlook.office365.com
 (2603:10b6:408:f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:41 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 16/17] mlxsw: spectrum_router: Replay IP NETDEV_UP on device deslavement
Date: Wed, 19 Jul 2023 13:01:31 +0200
Message-ID: <e0ea0390bb10f407c6f4e009add197e04b9923ba.1689763089.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 389f39de-1205-488c-a4a7-08db8847b5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pv9Nr/z83I6944V7AK+JhKT5h0rSUvanm8y9FwuEKVc/Qm4X8hMAQnUruy6I5RHZbk2K61xSBhB2wRGqM4U+mNlfxzDrNcKXh0pE9iLksvH96rrUZmZeTxtzyMGj8b0lWkZ0yIdqPiFDcP0WGhcHZOArYiSeL2mQCpjc5C9lW0Lua6UqpUn/XzgYpF2xGSRHjIePs8T3tzaP5sdtoTShio+BcxEggA3D2qjwDT1az7WFZWw8SSOINKOv4BdzuCF7QXFad7Y4SwRRvtZaT9hFYR0tLkfMQvW8XcbheZij5/gh9s390ZLTaXYKvjcF4xIMMv5T9FrkJOHB3XlEm+HY/hRb9bkgnE8hGJ4K6DXSKv3Djsvr6wbOKNMIqgY+Kev4B1tgT4LprjcuI93acvI6cixrff3LvNOwRoYNdrhDNPTPU9kVLN6CmUxgUNOPHFTyEpxTWBBcpU/YogQPWiU36Z5VAtjJoGPgE62D7RyfUV9W4IT3qxTGPo/y/wpoA8vwzjSXvapxfQrdA7prx4A3F5ZStWJLBj+Ra24mVkLuqTsJepD8Kbgbsw6tsUBEWvWtSI+UdlIws+LFJcVLoyyIyPb22FXUMx9DyW7Np4VXparCv++MzYXeMflShSmjJCAb1+fhthNLtGRRQXRbjntT+Nfp/SDkesQE48KwCoLJGEjyCULD5bgPfqJeAWyZp0v+P6GWfWUQ3FGFbJGTqWZpIQaeF6BmEsy/yiPJm5f82OM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(478600001)(54906003)(6666004)(110136005)(2616005)(66574015)(83380400001)(47076005)(86362001)(40460700003)(36860700001)(40480700001)(2906002)(316002)(70586007)(336012)(36756003)(107886003)(26005)(16526019)(7636003)(82740400003)(356005)(70206006)(186003)(5660300002)(426003)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:57.3727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389f39de-1205-488c-a4a7-08db8847b5b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When a netdevice is removed from a bridge or a LAG, and it has an IP
address, it should join the router and gain a RIF. Do that by replaying
address addition event on the netdevice.

When handling deslavement of LAG or its upper from a bridge device, the
replay should be done after all the lowers of the LAG have left the bridge.
Thus these scenarios are handled by passing replay_deslavement of false,
and by invoking, after the lowers have been processed, a new helper,
mlxsw_sp_netdevice_post_lag_event(), which does the per-LAG / -upper
handling, and in particular invokes the replay.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 48 ++++++++++++++++---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 23 ++++++++-
 .../ethernet/mellanox/mlxsw/spectrum_router.h |  2 +
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 0dcd988ffce1..b955511fe5a2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4838,15 +4838,20 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
 		if (netif_is_bridge_master(upper_dev)) {
-			if (info->linking)
+			if (info->linking) {
 				err = mlxsw_sp_port_bridge_join(mlxsw_sp_port,
 								lower_dev,
 								upper_dev,
 								extack);
-			else
+			} else {
 				mlxsw_sp_port_bridge_leave(mlxsw_sp_port,
 							   lower_dev,
 							   upper_dev);
+				if (!replay_deslavement)
+					break;
+				mlxsw_sp_netdevice_deslavement_replay(mlxsw_sp,
+								      lower_dev);
+			}
 		} else if (netif_is_lag_master(upper_dev)) {
 			if (info->linking) {
 				err = mlxsw_sp_port_lag_join(mlxsw_sp_port,
@@ -4855,6 +4860,8 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 				mlxsw_sp_port_lag_col_dist_disable(mlxsw_sp_port);
 				mlxsw_sp_port_lag_leave(mlxsw_sp_port,
 							upper_dev);
+				mlxsw_sp_netdevice_deslavement_replay(mlxsw_sp,
+								      dev);
 			}
 		} else if (netif_is_ovs_master(upper_dev)) {
 			if (info->linking)
@@ -4924,6 +4931,30 @@ static int mlxsw_sp_netdevice_port_event(struct net_device *lower_dev,
 	return 0;
 }
 
+/* Called for LAG or its upper VLAN after the per-LAG-lower processing was done,
+ * to do any per-LAG / per-LAG-upper processing.
+ */
+static int mlxsw_sp_netdevice_post_lag_event(struct net_device *dev,
+					     unsigned long event,
+					     void *ptr)
+{
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(dev);
+	struct netdev_notifier_changeupper_info *info = ptr;
+
+	if (!mlxsw_sp)
+		return 0;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		if (info->linking)
+			break;
+		if (netif_is_bridge_master(info->upper_dev))
+			mlxsw_sp_netdevice_deslavement_replay(mlxsw_sp, dev);
+		break;
+	}
+	return 0;
+}
+
 static int mlxsw_sp_netdevice_lag_event(struct net_device *lag_dev,
 					unsigned long event, void *ptr)
 {
@@ -4940,7 +4971,7 @@ static int mlxsw_sp_netdevice_lag_event(struct net_device *lag_dev,
 		}
 	}
 
-	return 0;
+	return mlxsw_sp_netdevice_post_lag_event(lag_dev, event, ptr);
 }
 
 static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
@@ -4984,15 +5015,20 @@ static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
 		if (netif_is_bridge_master(upper_dev)) {
-			if (info->linking)
+			if (info->linking) {
 				err = mlxsw_sp_port_bridge_join(mlxsw_sp_port,
 								vlan_dev,
 								upper_dev,
 								extack);
-			else
+			} else {
 				mlxsw_sp_port_bridge_leave(mlxsw_sp_port,
 							   vlan_dev,
 							   upper_dev);
+				if (!replay_deslavement)
+					break;
+				mlxsw_sp_netdevice_deslavement_replay(mlxsw_sp,
+								      vlan_dev);
+			}
 		} else if (netif_is_macvlan(upper_dev)) {
 			if (!info->linking)
 				mlxsw_sp_rif_macvlan_del(mlxsw_sp, upper_dev);
@@ -5022,7 +5058,7 @@ static int mlxsw_sp_netdevice_lag_port_vlan_event(struct net_device *vlan_dev,
 		}
 	}
 
-	return 0;
+	return mlxsw_sp_netdevice_post_lag_event(vlan_dev, event, ptr);
 }
 
 static int mlxsw_sp_netdevice_bridge_vlan_event(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 18d1bcbb3fdf..57f0faac836c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -9785,12 +9785,14 @@ struct mlxsw_sp_router_replay_inetaddr_up {
 	struct mlxsw_sp *mlxsw_sp;
 	struct netlink_ext_ack *extack;
 	unsigned int done;
+	bool deslavement;
 };
 
 static int mlxsw_sp_router_replay_inetaddr_up(struct net_device *dev,
 					      struct netdev_nested_priv *priv)
 {
 	struct mlxsw_sp_router_replay_inetaddr_up *ctx = priv->data;
+	bool nomaster = ctx->deslavement;
 	struct mlxsw_sp_crif *crif;
 	int err;
 
@@ -9805,7 +9807,7 @@ static int mlxsw_sp_router_replay_inetaddr_up(struct net_device *dev,
 		return 0;
 
 	err = __mlxsw_sp_inetaddr_event(ctx->mlxsw_sp, dev, NETDEV_UP,
-					false, ctx->extack);
+					nomaster, ctx->extack);
 	if (err)
 		return err;
 
@@ -9817,6 +9819,7 @@ static int mlxsw_sp_router_unreplay_inetaddr_up(struct net_device *dev,
 						struct netdev_nested_priv *priv)
 {
 	struct mlxsw_sp_router_replay_inetaddr_up *ctx = priv->data;
+	bool nomaster = ctx->deslavement;
 	struct mlxsw_sp_crif *crif;
 
 	if (!ctx->done)
@@ -9833,7 +9836,8 @@ static int mlxsw_sp_router_unreplay_inetaddr_up(struct net_device *dev,
 	if (!mlxsw_sp_rif_should_config(crif->rif, dev, NETDEV_UP))
 		return 0;
 
-	__mlxsw_sp_inetaddr_event(ctx->mlxsw_sp, dev, NETDEV_DOWN, false, NULL);
+	__mlxsw_sp_inetaddr_event(ctx->mlxsw_sp, dev, NETDEV_DOWN, nomaster,
+				  NULL);
 
 	ctx->done--;
 	return 0;
@@ -9846,6 +9850,7 @@ int mlxsw_sp_netdevice_enslavement_replay(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_router_replay_inetaddr_up ctx = {
 		.mlxsw_sp = mlxsw_sp,
 		.extack = extack,
+		.deslavement = false,
 	};
 	struct netdev_nested_priv priv = {
 		.data = &ctx,
@@ -9872,6 +9877,20 @@ int mlxsw_sp_netdevice_enslavement_replay(struct mlxsw_sp *mlxsw_sp,
 	return err;
 }
 
+void mlxsw_sp_netdevice_deslavement_replay(struct mlxsw_sp *mlxsw_sp,
+					   struct net_device *dev)
+{
+	struct mlxsw_sp_router_replay_inetaddr_up ctx = {
+		.mlxsw_sp = mlxsw_sp,
+		.deslavement = true,
+	};
+	struct netdev_nested_priv priv = {
+		.data = &ctx,
+	};
+
+	mlxsw_sp_router_replay_inetaddr_up(dev, &priv);
+}
+
 static int
 mlxsw_sp_port_vid_router_join_existing(struct mlxsw_sp_port *mlxsw_sp_port,
 				       u16 vid, struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index eed04fbf719f..ed3b628caafe 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -183,5 +183,7 @@ void mlxsw_sp_router_port_leave_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 int mlxsw_sp_netdevice_enslavement_replay(struct mlxsw_sp *mlxsw_sp,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack);
+void mlxsw_sp_netdevice_deslavement_replay(struct mlxsw_sp *mlxsw_sp,
+					   struct net_device *dev);
 
 #endif /* _MLXSW_ROUTER_H_*/
-- 
2.40.1


