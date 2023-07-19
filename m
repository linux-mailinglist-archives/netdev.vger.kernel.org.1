Return-Path: <netdev+bounces-18969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B27593D1
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CE1C20EFC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09DE14291;
	Wed, 19 Jul 2023 11:02:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D914A92
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7B186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd3fLzIzlN/Si69kEwE+pvNmoBp1V96veNy1aVpycyxlLEGptg3Leis8Jp9g1LFBrGfnPz7wE4YqghqBjCSs3ehfc2k9S8aw1vZUXj+d9y1EFgWfVZjLEvAbUpK9EsmX+EU8rRZp3JqgicDxIA41xNkSVe4rOL1WP83U2UjyMkVy6WuhJoCO2JtwV96V/aMwXzgrNUWkSK9jRTwnltLQmrsqu8vggPnm9mGfyfAMylTWLo+tFc18WGKFjYI5ypI6NdAu8+RXMFeN5dIyArmdjztVfnpDLfYq0YE0hIvD53GGTjr8lXzd0+Pm3gbHujJkSHBWU/vGYv90gjOBx+FXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DFiNflvX/KmA1OHV2+0raRpx1n0Spqh79Ws/DtieP0=;
 b=O2fGbYeuZ3Kaw+HNddM2uKt+QZAkl4b61KsYwSB4V512wMHFkf6S3Rle9CovtpTCK+IXpp9GenLNYHzodlhtd8b1XxAZAX6I7L6QPoyLf3cNYetIGYbgqabh/2CkwS3JvlDcEDDDp9g6zyWyvec4lvOd0VLpzUnBRInSPDpUF2HrzbG2TeYdnI+jHQrwbla1rd3TmJ31mphnDIibZDc45r2AK8JJ17TBNrF6kmAmaaMD+tF3KPtoTOaHtrSoYoGOa1o8ZUwafkjxLsSKrdMZ+H9mCkWWr/IHbUEpYQ1Y5GI78Pi5KuKt+HUJfFqxChKeC7mF+nycnlu/L29p5jqZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DFiNflvX/KmA1OHV2+0raRpx1n0Spqh79Ws/DtieP0=;
 b=bpBjqizJsAioy+8Fry6fvNj6H3Vw5k6MsLk6CCqAs5kkmz2uim6GOm94LcktjCt94aLg1C5FwrBxMFlYfj1M2ld44QprmAIlueSHn5MJ9kdnf5yIZZw1AmzR0VCqcZbebsaybacpdC3hiM9Ez6oWj0yVsNQo7poJZgJP20XRh+u6cpoviIrv5Y7BRWzzYxe82k+vWw+RNQdyNDrKDoizGzWNO8TW2vMZTRGQ8+yL0Dh4k12ChFjfBpiGq09ht8KtuPzlRZkkvgL9agJSZYyjhALZtWOl/dNk6cVWyci8lusbtsbC80QmRP28naxGTB82lX4W4owQ+Q5E2IKxnRFkjg==
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 19 Jul
 2023 11:02:55 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::fe) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Wed, 19 Jul 2023 11:02:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:38 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 15/17] mlxsw: spectrum_router: Replay IP NETDEV_UP on device enslavement
Date: Wed, 19 Jul 2023 13:01:30 +0200
Message-ID: <2d6e226cc1b5824251fa6bd89c47459d7d2e79b4.1689763089.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: bb40f632-4155-4a8f-b8ab-08db8847b42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XirvRUI53wnNKD0/GTSf3j7vq+9o5ozMDz9j4vanTgplou/N4vXNJhumTkLah1S9yqJKsNrtFkeImhf30bxT4qCKcM3qIf+6oUInmnGC+tUWaoy8HhwgM9uevVz4WwYsxW8iwR8/oJiDtmVB5K68BiM0JTJ2BXHUvb51ucW8jbdtIrxNeJ01rsH92M7aXazCVviibzLdlxsIku5vbJJXgrFAXTIy8SGRGtaclFmYrMMgVJ1W58mIjkSRVXYLf35D+K2ZjEy2nyeqEcHFsL6Z4poST7cf0c4PQn0S4vILzK/J96lOKyRbvAkkK4/NoGCFk/vEPmY/uDmvKz6nIKGEOWi//qhVjklNwDu7yjMdWPSLtMCPiy7QnbJFdNqZIpu5AHvDw04C2rnINr5Eby45iNSJ38QYSa7F2KXUAlYmSVxkEp5ZwrGktPYOGDHsX03Ly6nmAfRv993PgNM2qR1KKdlMtcDq9JpCpvNqEIMLzWXNTa1QYxkyBBaVlwNbJzlW9ueQSUpDuBrg+nVFCuJBvLPPOISHLpEh80PyggUnz2nJcN13GEAX5LRmpfN+wWdifjJWZceIicoNkS9DwhL9FFZCm0GGR6QaYw1VKTu/qGZS9Ynylx4hQ2sIDB1lNzQI9O29oHlrEvSlfaW07X7n2YzmzKrSAPoO6NipW7JrSf/JoQspdRiLPbUqHf2DxA1KjV/zrlvgUzLNimv6DhGbLSN4QJxM3pc/ckw8o3HSMJw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(4326008)(478600001)(83380400001)(6666004)(110136005)(70206006)(54906003)(426003)(40480700001)(36860700001)(336012)(47076005)(66574015)(86362001)(36756003)(2906002)(2616005)(8676002)(26005)(186003)(41300700001)(107886003)(40460700003)(5660300002)(356005)(7636003)(82740400003)(316002)(8936002)(16526019)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:54.7911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb40f632-4155-4a8f-b8ab-08db8847b42c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enslaving of front panel ports (and their uppers) to netdevices that
already have uppers is currently forbidden. When this is permitted, any
uppers with IP addresses need to have the NETDEV_UP inetaddr event
replayed, so that any RIFs are created.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   6 +
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 119 ++++++++++++++++++
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   5 +
 .../mellanox/mlxsw/spectrum_switchdev.c       |   7 ++
 4 files changed, 137 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 4346cc736579..0dcd988ffce1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4469,8 +4469,14 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (err)
 		goto err_router_join;
 
+	err = mlxsw_sp_netdevice_enslavement_replay(mlxsw_sp, lag_dev, extack);
+	if (err)
+		goto err_replay;
+
 	return 0;
 
+err_replay:
+	mlxsw_sp_router_port_leave_lag(mlxsw_sp_port, lag_dev);
 err_router_join:
 	lag->ref_count--;
 	mlxsw_sp_port->lagged = 0;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 9263a914bcc7..18d1bcbb3fdf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -9781,6 +9781,97 @@ mlxsw_sp_netdevice_vrf_event(struct net_device *l3_dev, unsigned long event,
 	return err;
 }
 
+struct mlxsw_sp_router_replay_inetaddr_up {
+	struct mlxsw_sp *mlxsw_sp;
+	struct netlink_ext_ack *extack;
+	unsigned int done;
+};
+
+static int mlxsw_sp_router_replay_inetaddr_up(struct net_device *dev,
+					      struct netdev_nested_priv *priv)
+{
+	struct mlxsw_sp_router_replay_inetaddr_up *ctx = priv->data;
+	struct mlxsw_sp_crif *crif;
+	int err;
+
+	if (mlxsw_sp_dev_addr_list_empty(dev))
+		return 0;
+
+	crif = mlxsw_sp_crif_lookup(ctx->mlxsw_sp->router, dev);
+	if (!crif || crif->rif)
+		return 0;
+
+	if (!mlxsw_sp_rif_should_config(crif->rif, dev, NETDEV_UP))
+		return 0;
+
+	err = __mlxsw_sp_inetaddr_event(ctx->mlxsw_sp, dev, NETDEV_UP,
+					false, ctx->extack);
+	if (err)
+		return err;
+
+	ctx->done++;
+	return 0;
+}
+
+static int mlxsw_sp_router_unreplay_inetaddr_up(struct net_device *dev,
+						struct netdev_nested_priv *priv)
+{
+	struct mlxsw_sp_router_replay_inetaddr_up *ctx = priv->data;
+	struct mlxsw_sp_crif *crif;
+
+	if (!ctx->done)
+		return 0;
+
+	if (mlxsw_sp_dev_addr_list_empty(dev))
+		return 0;
+
+	crif = mlxsw_sp_crif_lookup(ctx->mlxsw_sp->router, dev);
+	if (!crif || !crif->rif)
+		return 0;
+
+	/* We are rolling back NETDEV_UP, so ask for that. */
+	if (!mlxsw_sp_rif_should_config(crif->rif, dev, NETDEV_UP))
+		return 0;
+
+	__mlxsw_sp_inetaddr_event(ctx->mlxsw_sp, dev, NETDEV_DOWN, false, NULL);
+
+	ctx->done--;
+	return 0;
+}
+
+int mlxsw_sp_netdevice_enslavement_replay(struct mlxsw_sp *mlxsw_sp,
+					  struct net_device *upper_dev,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_router_replay_inetaddr_up ctx = {
+		.mlxsw_sp = mlxsw_sp,
+		.extack = extack,
+	};
+	struct netdev_nested_priv priv = {
+		.data = &ctx,
+	};
+	int err;
+
+	err = mlxsw_sp_router_replay_inetaddr_up(upper_dev, &priv);
+	if (err)
+		return err;
+
+	err = netdev_walk_all_upper_dev_rcu(upper_dev,
+					    mlxsw_sp_router_replay_inetaddr_up,
+					    &priv);
+	if (err)
+		goto err_replay_up;
+
+	return 0;
+
+err_replay_up:
+	netdev_walk_all_upper_dev_rcu(upper_dev,
+				      mlxsw_sp_router_unreplay_inetaddr_up,
+				      &priv);
+	mlxsw_sp_router_unreplay_inetaddr_up(upper_dev, &priv);
+	return err;
+}
+
 static int
 mlxsw_sp_port_vid_router_join_existing(struct mlxsw_sp_port *mlxsw_sp_port,
 				       u16 vid, struct net_device *dev,
@@ -9857,6 +9948,26 @@ static int __mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 	return err;
 }
 
+static void
+__mlxsw_sp_router_port_leave_lag(struct mlxsw_sp_port *mlxsw_sp_port,
+				 struct net_device *lag_dev)
+{
+	u16 default_vid = MLXSW_SP_DEFAULT_VID;
+	struct net_device *upper_dev;
+	struct list_head *iter;
+	u16 vid;
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		vid = vlan_dev_vlan_id(upper_dev);
+		mlxsw_sp_port_vid_router_leave(mlxsw_sp_port, vid, upper_dev);
+	}
+
+	mlxsw_sp_port_vid_router_leave(mlxsw_sp_port, default_vid, lag_dev);
+}
+
 int mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct net_device *lag_dev,
 				  struct netlink_ext_ack *extack)
@@ -9870,6 +9981,14 @@ int mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 	return err;
 }
 
+void mlxsw_sp_router_port_leave_lag(struct mlxsw_sp_port *mlxsw_sp_port,
+				    struct net_device *lag_dev)
+{
+	mutex_lock(&mlxsw_sp_port->mlxsw_sp->router->lock);
+	__mlxsw_sp_router_port_leave_lag(mlxsw_sp_port, lag_dev);
+	mutex_unlock(&mlxsw_sp_port->mlxsw_sp->router->lock);
+}
+
 static int mlxsw_sp_router_netdevice_event(struct notifier_block *nb,
 					   unsigned long event, void *ptr)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index 74242220a0cf..eed04fbf719f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -178,5 +178,10 @@ int mlxsw_sp_router_bridge_vlan_add(struct mlxsw_sp *mlxsw_sp,
 int mlxsw_sp_router_port_join_lag(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct net_device *lag_dev,
 				  struct netlink_ext_ack *extack);
+void mlxsw_sp_router_port_leave_lag(struct mlxsw_sp_port *mlxsw_sp_port,
+				    struct net_device *lag_dev);
+int mlxsw_sp_netdevice_enslavement_replay(struct mlxsw_sp *mlxsw_sp,
+					  struct net_device *upper_dev,
+					  struct netlink_ext_ack *extack);
 
 #endif /* _MLXSW_ROUTER_H_*/
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 982eae6bd63e..dffb67c1038e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2894,8 +2894,15 @@ int mlxsw_sp_port_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (err)
 		goto err_port_join;
 
+	err = mlxsw_sp_netdevice_enslavement_replay(mlxsw_sp, br_dev, extack);
+	if (err)
+		goto err_replay;
+
 	return 0;
 
+err_replay:
+	bridge_device->ops->port_leave(bridge_device, bridge_port,
+				       mlxsw_sp_port);
 err_port_join:
 	mlxsw_sp_bridge_port_put(mlxsw_sp->bridge, bridge_port);
 	return err;
-- 
2.40.1


