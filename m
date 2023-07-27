Return-Path: <netdev+bounces-21978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE2765830
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C341C21396
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AE91802E;
	Thu, 27 Jul 2023 16:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58319881
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E054271E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdCk9uaUAgFEvfgmGggrYEx8BVc7JtGDhwImleNDMaYSgcZ3z6r57/Jz9vNiFsgvK1JTJjy8pBsQpvYEEzU52P4TFrHGaHnuryXrheNfEPnjZX1JSu6JguelHDrWMae5GBWAxw43quA7Insm+rpR9MFJCXTAnIf9+WSeeqLPLxASnYnr4J+VH/blOOIcYA/zw6yNnQ8wHIFxNeT/ImCgC4yhiwJytF6Q5lveL9zNbXhmXyDo7Jcg/I47UJfKeyr4q8mUdgkKgvuX3i8amsTwCLKl7LrAD0FeGasL5AaS/xPvOT1eFWD+FDe7Icb3TK2p+fu8yak678WC+g7DEX6rOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E6RcOPzxOzk6wCd/b+ZOmfBf96ioDHUzLUGqriFMOU=;
 b=MV8c2WEmxJE1+b9NFUDCtBZOOIKCzmJsKXTcNRV3RUbwUZ53z0h2laE18UNzwF51Ghvl9uOedJbXxa9C09JwbYehhyj1r/En87Fj89h5wM77rrDMJQVPvRaHFEXJyg3vlx26uJ2f+L3h3juyxhFKSu1bftezeqhAPfJrqz+soR1132JdTIV3+RoQt/C23zQc/SSzSiK+CYNtvnncbZybMt87aVp1q05FCGyrO3nOf9gJBssZky008hkHbRwhZRj1uYPojBVM276a2PSKOsPCOptz7z6cAOaIvMIp/FIT4g2TG1pVYRbgHV+O+qwSxb96fmlNvwYaYqHY/h/ZN0IM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E6RcOPzxOzk6wCd/b+ZOmfBf96ioDHUzLUGqriFMOU=;
 b=mqiGKa6sdkidfGuorx5FkzogG1Y/+8K64LUqtu7HcEZCv5SLtFHf2hPmEO5PCHOGQTKR5DxjZaenT6JADTajM0ZbMkawPwzY5dKgUGe7pOXZ5RW3xPsxtpfCW+ilLnPfjPe/HawfC4iPEhcY3OFC14/Bk3iyi27m7crHkEnaxjPbD7s/ZRVZFrW0H/1WucH7P8m60T2HIeMvdOy0AFJHvESw26/kSlfckOpt0qrFs5Liub845kcT4nwCg5FCNanc4VrcOoINn5RaUlY6nqswWkBKD7H8Jevlmf0SY1Vf9Y0i+q3g17TV1xquMt0bAu6ksos8R7oD2goMNaSw2ww1lQ==
Received: from BN9PR03CA0929.namprd03.prod.outlook.com (2603:10b6:408:107::34)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:27 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::6e) by BN9PR03CA0929.outlook.office365.com
 (2603:10b6:408:107::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:11 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 09:00:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 5/7] mlxsw: spectrum_router: hw_stats: Use tracker helpers to hold & put netdevices
Date: Thu, 27 Jul 2023 17:59:23 +0200
Message-ID: <b972314cfef4f4c24e66e60d13cffa5d606d1bf3.1690471774.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 702a9ca1-161d-495e-b456-08db8eba9769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+UY4Rvp09p9Ide9ZTf2RtxoYX0Q++wSbzouhZ9uFwjaAhto7H7oTTTCD48x/m6ZjbHiMqbc6dwPEbLllImwsVreVF+2Q9ISHypujUVM8xH9gDZOHHKnHllDtfiK9dM5llZPT31oJ4TcVUGfKT6CLuokWlJpoy2R3OR8KEyEwZGacgkVInocJD4JJgHOlI4ZEd549u0V6kAbD45dAd0qfkR8vJ7nAQ+6nqbHoMYnGI12Ahkd5/yvb7CALz4g05ug1Zyd0TEEt+zqQFK3OxWTdEjfRChlOI5Hr3kuA9UwNKOAqqv+dx1MjDFYqa9357kIcCTHIW2RXhCCwwrv8j09n3qva7+Ifi+7ePjqaW5ssKFkzj2pkgWbyvPfxdRlB8ePnxWxDEWp68Uac5dMKkk32msvQGUsePjoYDEJ7AwTQ1RpM3cwhQfCVF1+o1hihKnLgR/KdFIYZh4v68EkPwlmamEjd32nYHqMWZbtGX+Z3OdkzSu2BbHunastgahOmVtKj+LyO9cdlqQjayO2K6X25WBu3t8QLqCeu5DpY4o2EtyUPddVGT9smcv82xgBoUNpAYyve6jj/Vs5PpbOGbe60mSrY5xSulUk/Pf3tJIEDMxOxGiRWQSSn9ySIo8H5qNTQDlCsse0bJLoruUYpf09uDN99sd8BBpWRZ/rcPMyB7m7aWepSakO9oRICRVVuYbJ13YIOkRz46/v91vU3JX2CVPRM5vSlwLTdFHzp8DZdkca3EsTS6C5uFB/OgzRkv+2+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(356005)(7636003)(26005)(54906003)(110136005)(478600001)(66574015)(82740400003)(107886003)(186003)(336012)(16526019)(426003)(7696005)(6666004)(47076005)(4326008)(2616005)(83380400001)(36860700001)(70206006)(70586007)(5660300002)(41300700001)(40460700003)(66899021)(316002)(2906002)(8676002)(8936002)(40480700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:25.6530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702a9ca1-161d-495e-b456-08db8eba9769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using the tracking helpers makes it easier to debug netdevice refcount
imbalances when CONFIG_NET_DEV_REFCNT_TRACKER is enabled.

Convert dev_hold() / dev_put() to netdev_hold() / netdev_put() in the
router code that deals with hw_stats events.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 0744497f2762..3ecd34ad0743 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8308,6 +8308,7 @@ mlxsw_sp_router_port_l3_stats_report_delta(struct mlxsw_sp_rif *rif,
 struct mlxsw_sp_router_hwstats_notify_work {
 	struct work_struct work;
 	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 };
 
 static void mlxsw_sp_router_hwstats_notify_work(struct work_struct *work)
@@ -8319,7 +8320,7 @@ static void mlxsw_sp_router_hwstats_notify_work(struct work_struct *work)
 	rtnl_lock();
 	rtnl_offload_xstats_notify(hws_work->dev);
 	rtnl_unlock();
-	dev_put(hws_work->dev);
+	netdev_put(hws_work->dev, &hws_work->dev_tracker);
 	kfree(hws_work);
 }
 
@@ -8339,7 +8340,7 @@ mlxsw_sp_router_hwstats_notify_schedule(struct net_device *dev)
 		return;
 
 	INIT_WORK(&hws_work->work, mlxsw_sp_router_hwstats_notify_work);
-	dev_hold(dev);
+	netdev_hold(dev, &hws_work->dev_tracker, GFP_KERNEL);
 	hws_work->dev = dev;
 	mlxsw_core_schedule_work(&hws_work->work);
 }
-- 
2.41.0


