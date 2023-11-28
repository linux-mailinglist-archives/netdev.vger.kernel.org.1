Return-Path: <netdev+bounces-51741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06877FBE86
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F27A1C20B56
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796F5E0B1;
	Tue, 28 Nov 2023 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDmEc9ER"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC05D2
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZbS7nedSYWqMfo4X5rlFRe3GKYElEvMSOH85275g6LY4UnanTGdH8Gu435EUW9G9iWe3dOUfhT99K2Qp5MaYmjK6REYvM7EPQgS69/fahkS0BM9IzK7BjiLDEuDGeAFtHSNrSH5QFoGdwXCEp4Nz68SyTjm0SZgT6nAa9ZFJShqucvSsYnwgARUReNxyRcAzeX4ngqwpkSrrjH48evc3cDCEd+Lv3DNlrzpaDYids4HoCWhlcxW6/JLJ1OmoA+/jq3BKAKkk0dmGnXFLT7yX9hZPTzyaf88+8G1w83UCPXKFyWe8ALD+jBzBKZFfKpb6g+nZwjau8ATj76ZnNjy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7oxjkx/U8qbSfZTLtUa3pRwlKmLAk63BG7BbiBO47I=;
 b=kvYyKAgdSybgXn/58Id0q5J4Kz0PnGHaF/CLmLM8K6rPCInYVkg9k9AGsV82tBVHr2UNgbnJF31Cg2o1cOf+Hue8LIb3S09w8Ecg8LSLJXhlATs1/L0CE+DrEBkHVarAQqp7ay8qxcchGeKGfKrYKN1EKuwGVZFrprpbQr0ChCOIPv/wUp/97msyYQneSbZA3gQXrYRwYVRg/EDAG3PQsmR+s6hk9NjZcPD7dJ+dKcmQy6zKLy7zICsTdMeSaO2Clc1Q+lHUeVs3d3cqO0mFa8eaYMXQJA1AALp3GYlrETItlth70TXOOxOs2YslRhold5Dzqw6vntOcffNXOJzJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7oxjkx/U8qbSfZTLtUa3pRwlKmLAk63BG7BbiBO47I=;
 b=NDmEc9ERXEkdUG7e6v5PCkeBoqpW9gPVSm+tzMlHB/ZKXuKDaFCqvSepY8JO7P2ZQlVrwZJVbjrFmR5iwzm2NXaqXuCzgzO7hIjiK2XEohFfwrAtwp6gAEgzln8hbUFbKishACVEX6toQ0ER2yDv/dxJggnKgAM6QLGhZ9LkGGdXRVtpej1METAN2JF1sbXoYfuA8XGvDhPyEgOlZEMFFCducueenE5zcvbg39vWMtsrueKUKP+tHmrB1/9WMYwtTsE+1aLXXVkEA9uW1x9//VwCknvg34AXJ6kteTzJjanXo4xTCwEOsw8DAWDYrLBfjy7cWEPkNRJQEVZOsLW+eA==
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:36 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d0) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:28 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:26 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/17] mlxsw: spectrum_fid: Add an op to get PGT address of a FID
Date: Tue, 28 Nov 2023 16:50:41 +0100
Message-ID: <00e8f6ad79009a9a77a5c95d596ea9574776dc95.1701183892.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 275f276c-d4c1-4e81-83ad-08dbf029e73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/u2GIX1KVUEAJ2jfojer/gdOpQ4m1cY5khX8z0Gaz8/6XCXBxdnhS4+oTdB9KMjsYpMTfuFPLhY3NePzgZpfTi2QNcKqXXm8A6xFn+yum447yew3DDAq0q02ELTU/ULO3vc3S9pkPJfbkc9rigDsg6GfAgE2/8C5/v4yBtB4KAeDLqmUizsSWTjPWLFwLnqqwqhf91jFAfQMKjSjzREwGG5kNRlugzpQfHHXzD0QJXbKlPt2MLnTEgrLYqOGCpJl7ede+bGz637eMMnXRL+HtsmBWKT/RjBuSrRYNY0+hJK70VV/0W3eIwQxCSOG/q1S4RbJCqtOgoN0Vj2uskJLVlbfi8hZvcdRRNx3BQmaSpOam4IPhlF3ToKjjno0P6HYbHsFWzf2oo1BJ4ecNXz/8kCY7dUpcJRIJB7EImqcEGmBlVgoAqA45TGeId3WOIUB9FuCFRFtxvHpJz9EL6shlCS6kV2eOhVKuuHsjX0VmOkbJF2KQRc7f3yS5pDc+irV7d+a9k5Cs56JFRctrpuAKhRrBJxOzgKJkAEg7m4ZZBC8vS50YUOlT30fFfZT2Q8gP9goEo5bYkgMblxN4heJj6/7b7PrKYJ4m/w7suNTXlMoTfxDbwT80hq4wnCaCeLbOZfcvN7UXzHEefqn4o4TW1lG2V4iRhxDfzB6QbxDZOlToP7uoEYcWtQ72qJYpWM7YauubUbjQCAHM0s+Zu0SUnyBOzFZV4ITaVoIJEKmxIwdEbnHVc4Lh3ShklUBcY6v
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(4326008)(6666004)(8936002)(8676002)(110136005)(54906003)(316002)(478600001)(40460700003)(356005)(47076005)(7636003)(36756003)(40480700001)(41300700001)(86362001)(107886003)(26005)(2906002)(36860700001)(70586007)(2616005)(426003)(83380400001)(16526019)(70206006)(82740400003)(5660300002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:36.5922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275f276c-d4c1-4e81-83ad-08dbf029e73e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

In the CFF flood mode, the way to determine a PGT address where a given FID
/ flood table resides is different from the controlled flood mode, which
mlxsw currently uses. Furthermore, this will differ between rFID family and
bridge families. The operation therefore needs to be dynamically
dispatched. To that end, add an op to FID-family ops.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_fid.c   | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index e8327c5b0b82..c3f4ce3cf4e7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -99,6 +99,8 @@ struct mlxsw_sp_fid_ops {
 				const struct mlxsw_sp_flood_table *flood_table);
 	int (*pgt_size)(const struct mlxsw_sp_fid_family *fid_family,
 			u16 *p_pgt_size);
+	u16 (*fid_mid)(const struct mlxsw_sp_fid *fid,
+		       const struct mlxsw_sp_flood_table *flood_table);
 };
 
 struct mlxsw_sp_fid_family {
@@ -345,12 +347,11 @@ mlxsw_sp_fid_pgt_base_ctl(const struct mlxsw_sp_fid_family *fid_family,
 }
 
 static u16
-mlxsw_sp_fid_flood_table_mid(const struct mlxsw_sp_fid_family *fid_family,
-			     const struct mlxsw_sp_flood_table *flood_table,
-			     u16 fid_offset)
+mlxsw_sp_fid_fid_mid_ctl(const struct mlxsw_sp_fid *fid,
+			 const struct mlxsw_sp_flood_table *flood_table)
 {
-	return mlxsw_sp_fid_pgt_base_ctl(fid_family, flood_table) +
-	       fid_offset;
+	return mlxsw_sp_fid_pgt_base_ctl(fid->fid_family, flood_table) +
+	       fid->fid_offset;
 }
 
 int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
@@ -368,8 +369,7 @@ int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
 	if (!flood_table)
 		return -ESRCH;
 
-	mid_index = mlxsw_sp_fid_flood_table_mid(fid_family, flood_table,
-						 fid->fid_offset);
+	mid_index = fid_family->ops->fid_mid(fid, flood_table);
 	return mlxsw_sp_pgt_entry_port_set(fid_family->mlxsw_sp, mid_index,
 					   fid->fid_index, local_port, member);
 }
@@ -1129,6 +1129,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_8021d_vid_to_fid_rif_update,
 	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
 	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
+	.fid_mid		= mlxsw_sp_fid_fid_mid_ctl,
 };
 
 #define MLXSW_SP_FID_8021Q_MAX (VLAN_N_VID - 2)
@@ -1472,6 +1473,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_ctl = {
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_8021q_vid_to_fid_rif_update,
 	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
 	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
+	.fid_mid		= mlxsw_sp_fid_fid_mid_ctl,
 };
 
 /* There are 4K-2 802.1Q FIDs */
-- 
2.41.0


