Return-Path: <netdev+bounces-13080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15073A1E0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170A51C21130
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278461ED55;
	Thu, 22 Jun 2023 13:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6081E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:33:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE2199F
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRlbiwszc9N4+3JTH+vewdI+SSXy6nNT6vg5SGP37Yc1Osig3LoWw7weDRCOHuqRZ/VqfYujkXLceQMBRBMTOetmuYj0zgtm3z20353tZXh0OykSuA3x106VtgUBOVibX+lzLCCbG31/awYFPBsvrEN4OMzoIDreP9+mRDqoMya5eJaoJxdAsdyFXPqPKuLTlvjVXy4LtR/sKmiLHmlF5qRii1XEB1csyd5GvNRzxHhl3DYPD1tvdFAGZIWaIA7bF6mgdMjrS17dr4W92DuiaP24h04omQCRuDUelqlQwQq9jz2S/4X+4HHNXHa7EiO68PSyu8MyUFW529/dSZg2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZEfRUFuuirAqyjhYoayS5gcpQYSA6/ccU+ogDtK8Qw=;
 b=gPGVv+f7KH6l2aaNI/HHkqpX2/VbO0bDVjKj0c4d5nXzzoKBd/ymtdYdvk38gmXDwBEzYX1gGwq9J2HlK6iUSLuX66hAdol/meXLDBZHoPgtHptKMmBwXmG1oHxEBQ4L2VkwttfAWRDh1olXVK8Iu+Xwi/3SuO3pXHX2KGeBTrQDGeesYn3Z+22Ckl8RMjE/lGRigqZM+pQGhnulVGGjPf2fbTz29ff5jgnFCkGxh7rV4IDEnlfx5olMYGOyHasO2BCsfF0J8trb+UHThHvcJKvhbQHORFeh1XVUEJDl4g9liNGD2fIx6Mo9f5bGX7u3YugMu0dVmxUtJQg2BvOy3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZEfRUFuuirAqyjhYoayS5gcpQYSA6/ccU+ogDtK8Qw=;
 b=Pt69DMH+M6rb6ry1DPI8MBmQEj/9qbO//W3l08zc+iyS4bhdkQI4n5EorgVp7QqN1OCpPcUf/OwP4/YN+6Gry41cg9SCvGoGtWsOb6zy5/7uMnAq8Ib0VzKD+1bgP5UUqMrqgRnWHdzQe69MoBaE5EiAuGoYEpYlDZfmX89KFnpG6Wi9mVlo2GK2seOPz8k1RGc6ZbwfzewPttx7fyuYpR9QNIZ4Vg+up/QIdHPercj3PZjFzb7j1GqjtAG3Z2gDzZBiAF5KTJQascVA5DXZo70Gv1w72SblK1nvjVTroX4kT3CekUKcgunk8L2RV2jEt3mTjADKrF5ltrEKuwFwEg==
Received: from DS7PR03CA0162.namprd03.prod.outlook.com (2603:10b6:5:3b2::17)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:33:38 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::71) by DS7PR03CA0162.outlook.office365.com
 (2603:10b6:5:3b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 13:33:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:30 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/8] mlxsw: spectrum_router: Add extack argument to mlxsw_sp_lb_rif_init()
Date: Thu, 22 Jun 2023 15:33:02 +0200
Message-ID: <e87ba300121010d580b80a281877573a7b1377ca.1687438411.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: b34f0ba1-0be3-482e-25db-08db73254963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v0LCRxWi6pM4VJtmgPn0j5WDpVNW0dEBWV5njmO0x1/J48VjkAfbNfUpMCHyf2w2SpjVST6GpvZH5ERoulYz+JvHQ2MgRPJxVmAwp+FRg2RZAgGNxFzcWMMAJW6cOG+sEtsBxG08Ofuoc0VnK5uUIhNn0ORLb4SYmikmO0iGOdm47GYcdOr4FqAomyWHJwloY9lFftcixBdvRCO3FPnATXw17eSkSqzkUcgKYs2Jnhfy527NRpF/0tupW1Hti6xvWqMjhp/9qaY9XZ+d2Wccp3XzT5HF9FtsmLStyFxPDCIqSSWuZATABIFVpOx9iFPm+k8nbfp/BMKhtLywo6xL5i0CZCDajArymON6ZLe+zmZiqO4ttPlLf21p9hzsoRVFcGHJAS+lxmfWO1qsGLOJSpqosYiS6j6YPw5SaCuEGSV12nBMwtQLlBlL5sotIzkoqa7pr+gql1mkEB4LycNpp5vETEa8z55tfuax0SNGgBOD2bgpiWSzHisDssx1sy23VVj7pQzIzlkobEySfOgo2Vhw3MqldSBDRJM0eZADQYz4btaU8WTEMON5/lkYiQby/0MZcHK/tGnHJRU11yaQ3uGngMdbExonI1QCT307DvUQw8JPHI2vMbL0HXA5fZOVdpCJvhAGM2C87nh/ZE/haQnvmcnP9sqXR/ar2sdKluh23/cKgtcCTRrXY68Lri/zOBrusqbtp2SiVU6sfx1MEUgLtatclNxu/6HUB2cooWXszBCJ+jQ7J+AwQSUfVWCJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(41300700001)(8676002)(40460700003)(186003)(2906002)(26005)(16526019)(54906003)(110136005)(70586007)(4326008)(70206006)(86362001)(316002)(2616005)(6666004)(82310400005)(356005)(7636003)(82740400003)(478600001)(83380400001)(107886003)(426003)(336012)(36860700001)(36756003)(40480700001)(66574015)(47076005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:38.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34f0ba1-0be3-482e-25db-08db73254963
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The extack will be handy in later patches.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 43e8f19c7a0a..0b1c17819388 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -10561,7 +10561,8 @@ static void __mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp)
 	mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(rgcr), rgcr_pl);
 }
 
-static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp)
+static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
+				struct netlink_ext_ack *extack)
 {
 	u16 lb_rif_index;
 	int err;
@@ -10674,7 +10675,7 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_vrs_init;
 
-	err = mlxsw_sp_lb_rif_init(mlxsw_sp);
+	err = mlxsw_sp_lb_rif_init(mlxsw_sp, extack);
 	if (err)
 		goto err_lb_rif_init;
 
-- 
2.40.1


