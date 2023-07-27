Return-Path: <netdev+bounces-21977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33E76582F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821A61C21557
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41FC198A7;
	Thu, 27 Jul 2023 16:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1719881
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E8BC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzQMjymh4pj53xb7bz4Zar1AAnM0alvj8QY/zylL7EOMI11GZFLfTLOizhGBYeqPMpYwMw18mmNFx0By4FQxdpDKJ3gOWd1pyELDlerj3VHB0CTNNnK1s+C8reLhTMJDF2Bq56OlNiH8gAOm8ecnxgcI6wSl+Z/hI6zw/aHCRt5KjG7eVILSEmcI9iRjhIRU7qoiTful8vmSiePvgA4TQb3HLWCBvxyJMbyRqcEfm+7ULX2f1/aGmXuHfhmI9qWmGwiMML5mtM/LYIFxZeBKSKOdETfyoIT8JXPkeoBrfBkoSjET64VRnwlYu5wiiBQb6Ly5UOmG3ngwNs0OgCjGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u+uiaO2raHRtovAQACz9cieL/02lP0+qxQH4MgUi38=;
 b=UP4G3iyKx/NAx22q+rPxUR8ry4ynjlGjRfzslVpLl1BslqTnsqg0QSl2H9IPBlQQ1ft22rzc5KFPcNMbzbRuRjxsc31jAoaNgkuZi3aw3EqeJvYU3n6X7YsLWrEh3SLFdnRpob9EoN+qZqaMdRovuzCY+JSTk9EOONw1InojP9URoWmfF+DyB/vZMnC8dN+/WLB2ULkv4waEcxBY6bwhc4CRij6MFuckxWJrMTMHHBnc5t2fASluyDlmLr4qfk43/57xh9N+g7udoGyFG89K/jBu1diUDEt5eGQB4KroRnEFoje9cBLgiVn3Njfk0PhPsxnH8+CwkHWZxq5VFGaFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u+uiaO2raHRtovAQACz9cieL/02lP0+qxQH4MgUi38=;
 b=ufRL4NbVPYu7QrpHneVGSsrDxDkvJd/xB4T1NJGpFy4xrYSQyqE3Z/bjHphdplMSgWVM5+78VlEuWbCkoNiHopRt7PqN/JcAJcNBPOTbth4GCzQh1B6/I77jV0Eu+5wvzL9Vi1FgvawSRLYdfn9oBDeiO7Syid4rGhUGbtJGjgMdzNRpwC8Gd9m+5zcErp9AZUAN6Ztux2FYjQVqtETK0SdaZEy/nLIpgRo3nQCMyIwyiGolIdIduTBTK9Pz1kIcmnCmZmgJEGnVPo7P4Y2sPuuVafZnovvQ+iVuBFX/0X0JqUllu23mTlaBabZEuKdik6PcZILpWxmb7AVJYI2ZBA==
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:23 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::f6) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:09 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 09:00:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 4/7] mlxsw: spectrum_router: FIB: Use tracker helpers to hold & put netdevices
Date: Thu, 27 Jul 2023 17:59:22 +0200
Message-ID: <5221a92e751c40447c55959f622267ccc999ed04.1690471774.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ca6fc8-cde0-4bd4-d0ae-08db8eba9571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	atxhk6DTflCHMBMfOds6Jz4xZ5YjC2hn0zOD5bdlQbZZLY6Hl2FLH8K/J1B7bMvz6HJuowSU4BQJb70OHGu3pn6aRZRthIsXJ9g3j23MdJSryUxc5VmlYMcjfuIbroK99CRCUVb3K4dIEd+udGpfSDVDeb7tnD89O8Bryq0A8KoI2t2kawyZBXONQw5f9ZzgJW0pZ2ZkR16XU+TkBrUQPOXK+hryjPZwq+K/1nn6c4BjxcKCima8KUDB13+g07dbBrVLjmOkTFeVKPiUGcMUS+BUI6oxubwa4GMPE9LOJtLk/yVoJEdEP2Q6BeEcGrveaV5wPmmTHL5Ez9gbAkdIPpEMyEku+mpJTN9JYSgJLCVhbAscU50JqbCgMh4q8fArnHFJH3GAOL2qs8feStRsXeLqs+wuEJYSDX5EEqRyEjoIf14K8Sf+aQtjBbrpraTs4DP8XLgmV1ncqGzYZr52nTjtPMsSZ68+pU7JbgV0dPnRMFOdeAbBR+upByWbOKFz5MsdWoCJT5aJPX9HeIvRiaBwNbqyE7KvDKpONvwSPy4rGTwDTi6/IvYkuqrkwm2lQKVQ5z/vH+KVH7PGferranlLkHIGEVp34W8G2M1hcVZr1VPKfhyU8hTR0G0DgsXl7TmJAxOyCZRDh6D1tWGAVELsuiUgguVULUSb7pXVH/tN4yxH1pkTJ7Y8BsHUewpt2mWhvrXtF7XMvp5oipQ7yiZ48dN0t9trWSCSyz2faOdcV3iykLp6+eWOEvVW6d6s
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(66899021)(478600001)(54906003)(110136005)(66574015)(356005)(47076005)(5660300002)(8676002)(8936002)(36756003)(2906002)(2616005)(426003)(41300700001)(16526019)(40480700001)(7636003)(70206006)(70586007)(86362001)(4326008)(316002)(107886003)(40460700003)(26005)(82740400003)(6666004)(7696005)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:22.3351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ca6fc8-cde0-4bd4-d0ae-08db8eba9571
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using the tracking helpers makes it easier to debug netdevice refcount
imbalances when CONFIG_NET_DEV_REFCNT_TRACKER is enabled.

Convert dev_hold() / dev_put() to netdev_hold() / netdev_put() in the
router code that deals with FIB events.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 57f0faac836c..0744497f2762 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -7547,6 +7547,7 @@ struct mlxsw_sp_fib6_event_work {
 
 struct mlxsw_sp_fib_event_work {
 	struct work_struct work;
+	netdevice_tracker dev_tracker;
 	union {
 		struct mlxsw_sp_fib6_event_work fib6_work;
 		struct fib_entry_notifier_info fen_info;
@@ -7720,12 +7721,12 @@ static void mlxsw_sp_router_fibmr_event_work(struct work_struct *work)
 						    &fib_work->ven_info);
 		if (err)
 			dev_warn(mlxsw_sp->bus_info->dev, "MR VIF add failed.\n");
-		dev_put(fib_work->ven_info.dev);
+		netdev_put(fib_work->ven_info.dev, &fib_work->dev_tracker);
 		break;
 	case FIB_EVENT_VIF_DEL:
 		mlxsw_sp_router_fibmr_vif_del(mlxsw_sp,
 					      &fib_work->ven_info);
-		dev_put(fib_work->ven_info.dev);
+		netdev_put(fib_work->ven_info.dev, &fib_work->dev_tracker);
 		break;
 	}
 	mutex_unlock(&mlxsw_sp->router->lock);
@@ -7796,7 +7797,8 @@ mlxsw_sp_router_fibmr_event(struct mlxsw_sp_fib_event_work *fib_work,
 	case FIB_EVENT_VIF_ADD:
 	case FIB_EVENT_VIF_DEL:
 		memcpy(&fib_work->ven_info, info, sizeof(fib_work->ven_info));
-		dev_hold(fib_work->ven_info.dev);
+		netdev_hold(fib_work->ven_info.dev, &fib_work->dev_tracker,
+			    GFP_ATOMIC);
 		break;
 	}
 }
-- 
2.41.0


