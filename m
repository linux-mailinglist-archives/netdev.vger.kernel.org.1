Return-Path: <netdev+bounces-21979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63052765832
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA82821EA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605571AA8A;
	Thu, 27 Jul 2023 16:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46D1AA84
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03BB271D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNYilFvvBP0pwcLHGvokdQl8OrQ+9Wl55Hhp6K/AY4ROwLGzwM9y7DTKPaZme6jgna5vSup/cp+YXihzhrsBz/5qN51sgFHAUkSHa0Qu00Ktltq8sY6iZifPRlYJE0C/cGBFZrQ1jcw6uyMVkItfHCpM4EBstHSXccKsZKE0fv8uZcG38ZSF2KvMYI8qVl9pNBB01QWxTt3OpQRWErGRgAGgA7wodAYHZWrvE9J55Rd9sIfQIxVWTFCrBt5yz/wGDDSs2io2+nlH4S7UTm0n3NwPK+dzHRTFkOx6Q3+OOheHNzONPPJwS2AEQhOmtlTKsgiJY7WJBVA4wPZyVty0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=priOAlBsqsZrCHZVXbQ/MdYGoWM6/K6ryEon3UZekqQ=;
 b=B8MSEJ+trmCTxYs0axuGAPDBPl+MO029iPPuf5mnAICUF5LOpCYyL7LFFnEcp3HttSb9/qYzq/vUvzvM1wZDUgxxdgANzGMVbVvLxZbDbslFqnauelel3v14H5s/2Qc6h22ME0MDEvxueAbkMNjq6/FZkJa5y59GCWzVyezEawHJXCmbSmUS3J1MYDV8yg4/yjDkpgdaP9UiD3wmeY78JIbrDqWNN58/u69SFbU9gxbxsSbdr8q6q4d++ajr0CYbhZk7wS8NhGK+HjYGKns189Vmzd/osj0vJ8e5MeAbJ2hSFcpi8RNwo0zxUBFwQr0fW3M5VKz1kuPquHYFZcTSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=priOAlBsqsZrCHZVXbQ/MdYGoWM6/K6ryEon3UZekqQ=;
 b=q5i3UB/IZrxaoRusJGucv3/tyMcM4llp5NsuM0MJkdVnQzuhgvhEithMTk3Sx+tjWmhkp9mJo8YsrIX6fh2ksoyZIQrw74eZXm/FEmHMtT8Q/nzqyiJv1IATDQ4ChyqlrXTdU6bTdCnXjQrij6AdsMvEJ/GMZa7PPYdCGord3nb5WWYl6Zn9KVnAZ9rVUzAprBpAM/wx6e/SEzm0YLE6Kb/PDjpH25tMwt75GGtNUqKtM5ydW0vZBi2plLCgn60IRKPEDMYlJqaMfOHTbJIGggGUnhiUkm7K3l3SkZXZVPGMZlELXA8QGCXuGa8sfuj4SH8h7bdYezACVTRoiSspOg==
Received: from BN8PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:94::38)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:29 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::22) by BN8PR03CA0025.outlook.office365.com
 (2603:10b6:408:94::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:13 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 09:00:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 6/7] mlxsw: spectrum_router: RIF: Use tracker helpers to hold & put netdevices
Date: Thu, 27 Jul 2023 17:59:24 +0200
Message-ID: <8b7701a7b439ac268e4be4040eff99d01e27ae47.1690471775.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690471774.git.petrm@nvidia.com>
References: <cover.1690471774.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: aa64c653-08e6-40ae-462c-08db8eba9905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DiloOF116czxKcYaRasplODMj2SqUjhyhDJXyl6+DOLOOtX/VMXr4iB99Y7JCj+q/p1SGXNd4GMUXZtIne5mCT3I13gpqZDY4QHBmPCsz2Nn5QX19xeMt1+fhCt341vO4CI+5RgLB1mAXlUe3ta7blGBL3JY6BhIVjNxSQq5kZxnygKrjallw5hOiZxHoPF68UkQB/UGodWQ9t7DLHtVuHUk3D3SBAMlLSLKREFTWjFo7sqbaaLriom7zdKPFN24q51erk2NYlh+XIn1W6y054DqrjGcLUNdZuAU085oolRJcgN0UDdGyHuYUy9rp5nj/bEarTsWonL555auLGTHpll/qRSbHAAw7tliGWwPvrLfXfI4gCQQeF1SeeAyb1Y1+mBwcn3HXQ/3RMbJFbZUosoXh1OuIIL/CaO/C71Z9szvrzvei8O784nrSqSfoKTL9vkTbeXPfXpH4QdlIY9kl+Tfx61tFqgGPvtg1ZCqkba4QrBgKMBTJ+y33ZJxl4Uouvtk3epEGsy6YSSK4UQKy7NaF3urrzAqqgoPYKp9T6Ixwe4Rs06xaOJ8mYs7LEE4CwTZyXRcy8E6eA2SPFuQeoYnoN/qJ3tI0D1szC+8mI3vLJzUM0vYIgxf1ObngvliGdyEkH7exGFRuoC+TIrvj1pPc4/cjXTFi3wkvzQqkQiBm/Yj+SvLJdJOilpNmwtrKrpF9H2hhEAK9XwNWOypU2acqAlrcQo6v57qsKWm65gQBliHt/5vb2jePkGKritm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(6666004)(478600001)(2616005)(426003)(86362001)(110136005)(8676002)(16526019)(54906003)(5660300002)(8936002)(41300700001)(26005)(336012)(186003)(2906002)(7636003)(107886003)(82740400003)(356005)(36756003)(4326008)(70586007)(70206006)(47076005)(40460700003)(316002)(36860700001)(83380400001)(66899021)(66574015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:28.3346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa64c653-08e6-40ae-462c-08db8eba9905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using the tracking helpers makes it easier to debug netdevice refcount
imbalances when CONFIG_NET_DEV_REFCNT_TRACKER is enabled.

Convert dev_hold() / dev_put() to netdev_hold() / netdev_put() in the
router code that deals with RIF allocation.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 3ecd34ad0743..59d12cf45939 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -71,6 +71,7 @@ static const struct rhashtable_params mlxsw_sp_crif_ht_params = {
 
 struct mlxsw_sp_rif {
 	struct mlxsw_sp_crif *crif; /* NULL for underlay RIF */
+	netdevice_tracker dev_tracker;
 	struct list_head neigh_list;
 	struct mlxsw_sp_fid *fid;
 	unsigned char addr[ETH_ALEN];
@@ -8412,7 +8413,7 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 		err = -ENOMEM;
 		goto err_rif_alloc;
 	}
-	dev_hold(params->dev);
+	netdev_hold(params->dev, &rif->dev_tracker, GFP_KERNEL);
 	mlxsw_sp->router->rifs[rif_index] = rif;
 	rif->mlxsw_sp = mlxsw_sp;
 	rif->ops = ops;
@@ -8469,7 +8470,7 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 		mlxsw_sp_fid_put(fid);
 err_fid_get:
 	mlxsw_sp->router->rifs[rif_index] = NULL;
-	dev_put(params->dev);
+	netdev_put(params->dev, &rif->dev_tracker);
 	mlxsw_sp_rif_free(rif);
 err_rif_alloc:
 err_crif_lookup:
@@ -8511,7 +8512,7 @@ static void mlxsw_sp_rif_destroy(struct mlxsw_sp_rif *rif)
 		/* Loopback RIFs are not associated with a FID. */
 		mlxsw_sp_fid_put(fid);
 	mlxsw_sp->router->rifs[rif->rif_index] = NULL;
-	dev_put(dev);
+	netdev_put(dev, &rif->dev_tracker);
 	mlxsw_sp_rif_free(rif);
 	mlxsw_sp_rif_index_free(mlxsw_sp, rif_index, rif_entries);
 	vr->rif_count--;
-- 
2.41.0


