Return-Path: <netdev+bounces-18967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C834C7593CF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E228177C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B212B81;
	Wed, 19 Jul 2023 11:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2414291
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051C186
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6rX4AZ44OKB20wr5hMyzg5zJvQa6u93U/0k34RG9pweyBNo/dS3wyQ4AI+L7ktva2WuH7+4RZILu3RZuv2ERz1f3YWQXh2Zo2rrot7O+N70ewkpuvSuaUdhEYOst53t64JqoGa6iajJ2UYHm4xm9BNPyoq2LGlAUDbUw4imkqJilJzU/eAjAxpNmLvwH2KqRxIkjdiTc+FhmlsUzH9IblNHr7EE+y5bvPunK/PAVHmqVyV7g2Qf2AQlwwdNXjpJk0YSsY2sSGDYdDGoIVZIEGIMWDpK991PtOJaqHVwGMX68DpbYcMjsHjqK9LbWKsBD3TOMc67qMfgkIavqFyHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS5BCzz6HPt+RjcmZWP91Yybz1CdZRosy9L0UN5yq0Q=;
 b=XAr2k/NuSj+KEq4Gx6+fKeBqWD5AgMq9vy12dVFYgqDD3Op2GiaP1umzRKhytk86l8MnORNHjsWSRJS8DteaguoBR+DL0pBnCSGK+dtV5KSCO7QuI3Q4qyVxi6ye4VRh+8oD/PD+YWVvlsE0fvehvns+b9dLFlKsOxVtKBDQUUiofBeVwoJD5NK2o/o5qhJ/HkfOoExZg+dax2Tb7eB5La5st2eN6GtAE4jb5ySWX7Ctavh4BWSNkoFDAhCaH2/Tk9PK0QlgMbwBuySjsBZrsHzg22TKG+BRwLiyaeIlnNZF9FSievPiiKskDqLMlirdl22M3fyd8rLr1rZgmXmuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS5BCzz6HPt+RjcmZWP91Yybz1CdZRosy9L0UN5yq0Q=;
 b=NftDvLM+zf48N8UdnjvrfbEO+B8lTR7K3/+/5aaIkkydV4tsTbiedJ8FOpVA5SSgSdCeas+MJ6vjjcZFQ4R0CUQ2S/R7/KTPg1+2wS74PO45SRO4ydXi8bM/XiYpFyK0LunXIhq4DW7tAYIEbj6wMuXgL6ry7lhm1p3QcVRDwu4mZD3nw8LklmoQKGpPCJcoouDiYZiK3333284rV5gSOQpctKKFNhJDSPF91FA06uMtQ4LAKfcJZm9LIrIP45LOx5oni62GmmcOj6v4wCTUFrzpHnScP+uNFqGuqRgi1o5l1qHgpED7b6W7O2J5FUTxNs9sopBPDUA1dG2oN+WBGw==
Received: from BN1PR14CA0021.namprd14.prod.outlook.com (2603:10b6:408:e3::26)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 11:02:46 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::60) by BN1PR14CA0021.outlook.office365.com
 (2603:10b6:408:e3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:30 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 12/17] mlxsw: spectrum_router: Offload ethernet nexthops when RIF is made
Date: Wed, 19 Jul 2023 13:01:27 +0200
Message-ID: <25880c3e71288cdcd4aeb86edb366361108a1ac7.1689763089.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 474bd3b1-c86d-4cc2-2388-08db8847aedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zqd2Su0ErBHtpmHPRXaPGwE7LfNjLjcwC0b0Zrx/UB4cywASVYqQswuTTh2a+oABih6fsLXfVfahxFDusPKkil26hL9KKTTCIj2czwcSE6W2lHW1YIB7+Z3QKYsh/xylo5kZliFaMGACqQ9SVSo3WeEmF09dCzZE9/RONCIFWCxFV9WWVub6sKJ//2htiUet/BxBhreTm58ewmcK6MF18FlYnlvXJMJpWKvP9e2r5KsHFPmrJDV7S6wrP//vlFfdqGGvx1gXWz1H58wkRh6Uig0Mki5jMwypKrFCEN4GBSxRBknFYKRUgV6NXDyLCA7vNf4aPc8wAXWgVHWLNQC8I4lIYqZEIM/uAhyo0Q66kWlIJGdXNj0hG/efKLeY6X8EHIZPjIM+BZjtDuVOkePbLOVMDjlwB7Et3XA0VP1Wd1Z9CXYbAGMwGZnMpYwJvPFUdYmv7qZ/GkW0c93m8eAjAPLQmeizN9El8hhnUfKMeRH1MuuLGQZ4Jl3kle7WNYXgdDhgnYWAR3eks37mlCNL+ZdsKvxxpwWFqrmyjiJuaYJAHwdy5/GM909blfzU8HGZH1HRzr6BdgHrzSrUXu+KVpk0AmW9vYesBImWT+IlZPhmAloZfOef0yVD0iJgIX1PKjfcslGtKyuQEj8TG5p3eBq3VosmydQcAuKnPILI1b8KVufYW0JyjHq7tUebRGMm1A5WIDvO69O6I5uWxN2JmpDWksDmI7XA378ILcYkILwAbg3uxDkT8crLvRSoBD7g
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(70586007)(4326008)(316002)(86362001)(70206006)(40480700001)(40460700003)(82740400003)(107886003)(478600001)(110136005)(2616005)(54906003)(8936002)(66574015)(336012)(41300700001)(47076005)(8676002)(5660300002)(426003)(26005)(186003)(16526019)(356005)(2906002)(83380400001)(36756003)(36860700001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:45.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 474bd3b1-c86d-4cc2-2388-08db8847aedb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As RIF is created, refresh each netxhop group tracked at the CRIF for which
the RIF was created.

Note that nothing needs to be done for IPIP nexthops. The RIF for these is
either available from the get-go, or will never be available, so no after
the fact offloading needs to be done.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index ae2d5e760f1b..fe1855cc2c76 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -4404,6 +4404,19 @@ static int mlxsw_sp_nexthop_type_init(struct mlxsw_sp *mlxsw_sp,
 	return err;
 }
 
+static int mlxsw_sp_nexthop_type_rif_made(struct mlxsw_sp *mlxsw_sp,
+					  struct mlxsw_sp_nexthop *nh)
+{
+	switch (nh->type) {
+	case MLXSW_SP_NEXTHOP_TYPE_ETH:
+		return mlxsw_sp_nexthop_neigh_init(mlxsw_sp, nh);
+	case MLXSW_SP_NEXTHOP_TYPE_IPIP:
+		break;
+	}
+
+	return 0;
+}
+
 static void mlxsw_sp_nexthop_type_rif_gone(struct mlxsw_sp *mlxsw_sp,
 					   struct mlxsw_sp_nexthop *nh)
 {
@@ -4532,6 +4545,35 @@ static void mlxsw_sp_nexthop_rif_update(struct mlxsw_sp *mlxsw_sp,
 	}
 }
 
+static int mlxsw_sp_nexthop_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
+					  struct mlxsw_sp_rif *rif)
+{
+	struct mlxsw_sp_nexthop *nh, *tmp;
+	unsigned int n = 0;
+	int err;
+
+	list_for_each_entry_safe(nh, tmp, &rif->crif->nexthop_list,
+				 crif_list_node) {
+		err = mlxsw_sp_nexthop_type_rif_made(mlxsw_sp, nh);
+		if (err)
+			goto err_nexthop_type_rif;
+		mlxsw_sp_nexthop_group_refresh(mlxsw_sp, nh->nhgi->nh_grp);
+		n++;
+	}
+
+	return 0;
+
+err_nexthop_type_rif:
+	list_for_each_entry_safe(nh, tmp, &rif->crif->nexthop_list,
+				 crif_list_node) {
+		if (!n--)
+			break;
+		mlxsw_sp_nexthop_type_rif_gone(mlxsw_sp, nh);
+		mlxsw_sp_nexthop_group_refresh(mlxsw_sp, nh->nhgi->nh_grp);
+	}
+	return err;
+}
+
 static void mlxsw_sp_nexthop_rif_gone_sync(struct mlxsw_sp *mlxsw_sp,
 					   struct mlxsw_sp_rif *rif)
 {
@@ -7892,6 +7934,12 @@ static int mlxsw_sp_router_rif_disable(struct mlxsw_sp *mlxsw_sp, u16 rif)
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(ritr), ritr_pl);
 }
 
+static int mlxsw_sp_router_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
+					 struct mlxsw_sp_rif *rif)
+{
+	return mlxsw_sp_nexthop_rif_made_sync(mlxsw_sp, rif);
+}
+
 static void mlxsw_sp_router_rif_gone_sync(struct mlxsw_sp *mlxsw_sp,
 					  struct mlxsw_sp_rif *rif)
 {
@@ -8329,6 +8377,10 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 			goto err_mr_rif_add;
 	}
 
+	err = mlxsw_sp_router_rif_made_sync(mlxsw_sp, rif);
+	if (err)
+		goto err_rif_made_sync;
+
 	if (netdev_offload_xstats_enabled(params->dev,
 					  NETDEV_OFFLOAD_XSTATS_TYPE_L3)) {
 		err = mlxsw_sp_router_port_l3_stats_enable(rif);
@@ -8343,6 +8395,8 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 	return rif;
 
 err_stats_enable:
+	mlxsw_sp_router_rif_gone_sync(mlxsw_sp, rif);
+err_rif_made_sync:
 err_mr_rif_add:
 	for (i--; i >= 0; i--)
 		mlxsw_sp_mr_rif_del(vr->mr_table[i], rif);
-- 
2.40.1


