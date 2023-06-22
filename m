Return-Path: <netdev+bounces-13083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7073A1E4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9906C2819B1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36721F18A;
	Thu, 22 Jun 2023 13:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D271E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:33:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D21995
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJqBsqJy+in/tDyKzAgeISdNvoTBoVkKIQg2e8tFoah1leR7S7+nto9VeL372xgZmt2nqwjyxQj6usPqxMfQfq7pgE90SBr3/stLT6Rv2HaIU4Zc1u08AR2K2mPYwWhq9mU5tq8XbuJBSH+HNiyTT4V557AUMLI9CJwd6n0NOzAU8QuXRL5Xtkiwra1WWZlQxyUf9tNHMKtZ7/duZ3qhyw1agYwBmtsaeiSYimCKnvHi512skn8n4FDRCMoRgrjNgoDR+SNeglpAPiI41jrd2C0vFhzc2/+t3Gh7pM8NGAujXA78GyLW9Wkm169WPLJUFtUp5aDUsfbTDkSTTBl+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr/FEgmOLNm9bT6KUEFOqXnPQR+96lYDC8FiKBPg2R4=;
 b=YQyhtSQ/Yir9QNZtk58s7bCReiM30UwuB0U8yHJfAWlvdpRFskJaDJHrRjuGtGWdX3nodP3Bm7YNVx3q6MpOij0lLjLd5BT+vUvV2vfMwyPae4o/lOSpmIinK7T+s/6GhycTbmAuX/LWsZmFhSXH21j5VkbjhGm+g9P4ewN0KIgck6krZ8O9CPElLXFK9KNw5BeexABA6Yryhkkou10izE05TRJEED0a8Xb6KgOBBTW8pajWplzA4VQDGw2uGrmypNMbymbP0Cst2Msd7uIsfX3hJNegvVMO4SNExh7E8zAM5RFyF04FX0WDDdjhWa7vKhOptVjJCVqP1t0uAbiIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr/FEgmOLNm9bT6KUEFOqXnPQR+96lYDC8FiKBPg2R4=;
 b=mpRgcHN4/U4/UqsL7QF4PM1GoSo8LEUnbtLAn9vKklc8a1DYFTu1nycZrAj2q87I7asVY3Gw5AIP54DTMTQAmvvlYzTFbd/Fg08ftC+6DwgiBxe76HmDFRVWyFTP4j/BBLIn7TtczY32cHJQZoMb/JhH6n4Sbv6qlpJyxL961SE1YN6Vea6HaxTcYE3D/HVOIepGk6ychwttexkmOYbPquDW1YHosKIeMOw6U+7K/ozjA0YPZ2Zk/fUTWnw8KD3V13UM7l6FhqMyLqoBlWrdQ19CQFvmPexSOconhLCnBV3BEFPdEwXqNqakPy/CBWytloH1rOdbfb4+fDGs7kedUg==
Received: from SA9PR13CA0180.namprd13.prod.outlook.com (2603:10b6:806:28::35)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:33:46 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::5) by SA9PR13CA0180.outlook.office365.com
 (2603:10b6:806:28::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 13:33:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:38 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/8] mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF
Date: Thu, 22 Jun 2023 15:33:05 +0200
Message-ID: <7f2b2fcc98770167ed1254a904c3f7f585ba43f0.1687438411.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH0PR12MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ada375-829c-429a-c50d-08db73254dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pp6WdgkF1yMCHsRIPPMo6P7AY0rEfghDycUNUm37pp6m2M0xmzXignVB0GnRql/k8m6dT/RMUcA9Fqk16DxbPIOGT0Ce9AyAVocShDWj8f3819StZEw5FzUxmQhroiiVWu4S6COsrW48NJLKkaP2BO/5JsjYZyMc9vfU/WIm2GFVqao0o2r6glJn8dYS7aLd+Mvel0obMSg09EAUIZGgPPFR6GPvxwP/xSuUzPBdGfCdxGA0plXBX9bZ2jSJVC3fopHXAfT1Yh9wx3abLt3JN6I1y7OtU/xdfaPJ2NefkLWOUu6TQQWZim0hEdxsJqtxRvFTsmBIrdI6TuzC405Ajcs4STaQYruyCUNVOdJ4YVJcfhJSBWzSjpT97Xa5imLx94VUeQilq0jbNxUSsitDy0JlgXXzjJn5sHnkoFQWAyTUA9jyXwsHCvqsN8ynWA+2GayAI4NTaoW+37ap7WSEWYfn20otTVoj2PK3YzDce2LR+IQHuG2vQhfg6qj+DHcdkzvBN13acfaEavgu35ic+Jedg7cZqY931/s0lZGXpvp+h6Gg1M+xY6hUweXYB2xeYto4CnYomZVr+B6VAb5LmOkS9FkvSwm3fWtbV1u3ZYyiwzaYfxloxJNB48SQ53bXiA2g1xoZaD6mbAC0NF4M29RDqmHoeuTHtuYLtUE/54GeBoLQ48n+ss4NprFzkxlnjPT4dLKOVkATF78geru3U8Q/VZNIiU6SQRkzipHecZmKnUr6h1W0bFu2ZPFpS/yb
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(40480700001)(40460700003)(86362001)(8676002)(41300700001)(8936002)(336012)(70586007)(70206006)(316002)(2616005)(83380400001)(5660300002)(66574015)(426003)(47076005)(478600001)(6666004)(107886003)(4326008)(186003)(16526019)(26005)(54906003)(110136005)(82740400003)(356005)(7636003)(36860700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:45.8530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ada375-829c-429a-c50d-08db73254dd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CRIFs are generally not maintained for loopback RIFs. However, the RIF for
the default VRF is used for offloading of blackhole nexthops. Nexthops
expect to have a valid CRIF. Therefore in this patch, add code to maintain
CRIF for the loopback RIF as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c    | 12 +++++++++++-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.h    |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index d251a926d140..c4d538e0169e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -10731,9 +10731,14 @@ static void __mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 				struct netlink_ext_ack *extack)
 {
+	struct mlxsw_sp_router *router = mlxsw_sp->router;
 	struct mlxsw_sp_rif *lb_rif;
 	int err;
 
+	router->lb_crif = mlxsw_sp_crif_alloc(NULL);
+	if (IS_ERR(router->lb_crif))
+		return PTR_ERR(router->lb_crif);
+
 	/* Create a generic loopback RIF associated with the main table
 	 * (default VRF). Any table can be used, but the main table exists
 	 * anyway, so we do not waste resources.
@@ -10741,17 +10746,22 @@ static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 	lb_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, RT_TABLE_MAIN, extack);
 	if (IS_ERR(lb_rif)) {
 		err = PTR_ERR(lb_rif);
-		return err;
+		goto err_ul_rif_get;
 	}
 
 	mlxsw_sp->router->lb_rif_index = lb_rif->rif_index;
 
 	return 0;
+
+err_ul_rif_get:
+	mlxsw_sp_crif_free(router->lb_crif);
+	return err;
 }
 
 static void mlxsw_sp_lb_rif_fini(struct mlxsw_sp *mlxsw_sp)
 {
 	mlxsw_sp_router_ul_rif_put(mlxsw_sp, mlxsw_sp->router->lb_rif_index);
+	mlxsw_sp_crif_free(mlxsw_sp->router->lb_crif);
 }
 
 static int mlxsw_sp1_router_init(struct mlxsw_sp *mlxsw_sp)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index b223e80303f5..0909cf229c86 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -61,6 +61,7 @@ struct mlxsw_sp_router {
 	struct mutex lock; /* Protects shared router resources */
 	struct mlxsw_sp_fib_entry_op_ctx *ll_op_ctx;
 	u16 lb_rif_index;
+	struct mlxsw_sp_crif *lb_crif;
 	const struct mlxsw_sp_adj_grp_size_range *adj_grp_size_ranges;
 	size_t adj_grp_size_ranges_count;
 	struct delayed_work nh_grp_activity_dw;
-- 
2.40.1


