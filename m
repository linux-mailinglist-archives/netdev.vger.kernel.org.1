Return-Path: <netdev+bounces-13085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4973A1E8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F6C281979
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5A1ED52;
	Thu, 22 Jun 2023 13:34:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874451D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:34:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B5BC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM/EddSnflJgiRsUyFJ0wUYhOT05Yf7Eyx5ufsFDnPdrMZgFc/2kVYYpWKvlq5quI0mCXpT3PZlCQ8D1i+qkDlkxKGeDnhkdpplyHlIx6q/o3GJJvlwQVZ+JTWKPFSHGcIfSTSWEcqZ8yWrQQasDW17vqVSuAqYg2Fg1wA1ydBFUr8rqWFh8D9Hq6PBbH17pGqFexQu3+SGNYJ9LkRGaMv0nAwUsygMgwasD740S4Pu66rnW8ofPKznEWA7g0gMHMFWUEhIlw6Ihw/grTQ262D5JC6hpHajDnys8B6DzSYFLK4+MrQ8QdG4wnRVd5QuMFpL6E08oEUuqwGwj27S5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUaHzGmg7+aiQ9SWuNNiNsAs+Lq1F3SuCJOh33u4fBI=;
 b=U/P3+XHfvW60yFPYfdSiPr7QSHW60Q/jjMmbPeUIVJMbB05vBRhuN/ftkG+yHDNGPM0ZxKY8VXf/XgT+0EHTkvOvJxIpTrfxUnHQSuIl1QQ6an7d+68nm2M9Q8TEaTEojWHnHnEER5L1Hdi0MymwYnQx58o2fhDcjq4crvykhTfWW3AvcOBlrj6oIx8hBxxXqDrsvIhU7SzbME0KU8rLxhI9X28mG6JMsRA04BOlkdm+Hr8iHlExUTd2X4xIYZ4RXHNzKlzUd3sHMVDQRsUIqSSoCUZgD3N1Az04RRKkoUnGEmx32qXmIBPY3SK8WAYg7M7NH/u194i7LAPV/GG9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUaHzGmg7+aiQ9SWuNNiNsAs+Lq1F3SuCJOh33u4fBI=;
 b=cIwYoQ7nnxc/x336IJOucYkTOcb4ffphr+YZLxmMMnF70A8NhvR7elN80Z9ugmsO7QqKKRe2XZQzj1wBiGUl1D8yophP+kT+a62n3/zGQ97gIYDnN60i8uYRygzV+xeD7XUvTee1v+ujAI1fN+/8afbKCXNmO2ny/h6wDJai3Njkumj8XT8jHcH/ILL2JaWi8QCQmxy/ddyZzjr0ihSh3RziuG6/hEgqpRGkqMt02mlvDyJp+mXRqsPVt6FONsiIt8h9lQIkTxZL/VSlLyDbr8VFlmWcGZFnhnSKTyJUwaSf/SzwAezApXnjLCsqaySxiWySCqPbaV0Pzja9RBXoPw==
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 13:33:59 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::2e) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 13:33:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:45 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 7/8] mlxsw: spectrum_router: Split nexthop finalization to two stages
Date: Thu, 22 Jun 2023 15:33:08 +0200
Message-ID: <7134559534c5f5c4807c3a1569fae56f8887e763.1687438411.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687438411.git.petrm@nvidia.com>
References: <cover.1687438411.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bbbfe4-def0-4952-bb9e-08db73255586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z5belSxbflW5pRFB+9aJ6DmgqkPfHFvEFjXr7tA7H1AqUQY+mWT/jjD4nkyzf5ocmQEsQkOI7XJ6QQiOWd3Ya2h2YnzhKJ2ysbuMIOpcODW2pYIXmSyy66jZnhQ2/CFjDl6SHKlx13aTsMgqjaHzgx/IeA+VJZPWQp0DaELEkAPwGNtsh0RFY8F7FMzmqnnIbJs5sMIanmQ5d380CFeE/rg7zSe/I3N8LRen6lh7iF+CEFj4JCnFqNc4JOWHoJERtwcehfsI4B9cHQEu52yg9mfmQK24LWBsH7WUyvUe8Ikl4Vrk+XGbklz4ntu4UgUZRCwvxQaz8iV5xBF+TtZNRiQl3OkGIuBEbEO+VCjJbKr0bfKdAxSPyz+TDiXq06bFG/xxI0PbpUOBfqdHznffG0w06jyvYXt0KRbYXv18wMYs5eh6Vqp9M543uSQ3rUPWoCsancOerOgBYJPomNRzp8cZNF8mEiqPCrUIwI32JGXSgd9GCCWQIydy9NEAy2UDTpIrHiFkvgfruc7XdmlEug73fs8/Sfonp2S0xz4ev+u7ei6Fhye3PvGbaXHgjyWVMW2Y5u5Pe9AB528SWyMYer87Bq41mJA90f1n7YpFs9IfL60pzof8/3TPtkhaPqczo5a/b4othhWNdbMzdeHX0YEvWY3bnzZQKI15t7JMvYluoNAbfCqipa0w8iM9Xpvl2UtNAabd6R2JFi73BAQkxE77iRVXa3Kf+CnOuOQAWQE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(478600001)(36860700001)(82310400005)(47076005)(36756003)(16526019)(66574015)(83380400001)(426003)(186003)(2616005)(336012)(86362001)(356005)(7636003)(40480700001)(82740400003)(107886003)(26005)(40460700003)(8936002)(8676002)(41300700001)(5660300002)(2906002)(110136005)(54906003)(70586007)(316002)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:58.7372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bbbfe4-def0-4952-bb9e-08db73255586
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nexthop finalization consists of two steps: the part where the offload is
removed, because the backing RIF is now gone; and the part where the
association to the RIF is severed.

Extract from mlxsw_sp_nexthop_type_fini() a helper that covers the
unoffloading part, mlxsw_sp_nexthop_type_rif_gone(), so that it can later
be called independently.

Note that this swaps around the ordering of mlxsw_sp_nexthop_ipip_fini()
vs. mlxsw_sp_nexthop_rif_fini(). The current ordering is more of a
historical happenstance than a conscious decision. The two cleanups do not
depend on each other, and this change should have no observable effects.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index acd6f1b5eef9..6c9244c35192 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -4369,21 +4369,26 @@ static int mlxsw_sp_nexthop_type_init(struct mlxsw_sp *mlxsw_sp,
 	return err;
 }
 
-static void mlxsw_sp_nexthop_type_fini(struct mlxsw_sp *mlxsw_sp,
-				       struct mlxsw_sp_nexthop *nh)
+static void mlxsw_sp_nexthop_type_rif_gone(struct mlxsw_sp *mlxsw_sp,
+					   struct mlxsw_sp_nexthop *nh)
 {
 	switch (nh->type) {
 	case MLXSW_SP_NEXTHOP_TYPE_ETH:
 		mlxsw_sp_nexthop_neigh_fini(mlxsw_sp, nh);
-		mlxsw_sp_nexthop_rif_fini(nh);
 		break;
 	case MLXSW_SP_NEXTHOP_TYPE_IPIP:
-		mlxsw_sp_nexthop_rif_fini(nh);
 		mlxsw_sp_nexthop_ipip_fini(mlxsw_sp, nh);
 		break;
 	}
 }
 
+static void mlxsw_sp_nexthop_type_fini(struct mlxsw_sp *mlxsw_sp,
+				       struct mlxsw_sp_nexthop *nh)
+{
+	mlxsw_sp_nexthop_type_rif_gone(mlxsw_sp, nh);
+	mlxsw_sp_nexthop_rif_fini(nh);
+}
+
 static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 				  struct mlxsw_sp_nexthop_group *nh_grp,
 				  struct mlxsw_sp_nexthop *nh,
-- 
2.40.1


