Return-Path: <netdev+bounces-21980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DF765835
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A090D28245F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E681318035;
	Thu, 27 Jul 2023 16:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA020C8EA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE18BC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBdOaOncCU+FYQ6xN2c200p3rSJ6mJuyBViIJ10GcqMekXJGplGvjpr4j1mF+cQuvgKMdIgVYAa7BkaKrvYR287U8XK592CnajBcWkRsMChlfZ/PYBnLGXkFnxkbmiOQpZVRd7/ukuTqb1MqMVN7+E1MBxV4OAY1Q4YW6KrMl/zhiq04360r6rRw5wPAl3DgBegGquvvH7zaEp0IJS/9d1LalSLTRkvINQfs0mPvLYpRswGtlCME0GpBti7m0Xb2iak0EXY74fjGBEhscI/Wg7WKO4DlK7/ZhgNHTD1djsfhGKhWn13OryGfMmodadhTlFIa/bks812COPS6iMZNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xLzT66g2F2J1TT++Uy87psvxahsrMt3JD6vfvZuW7c=;
 b=D2EhBmag20J2mn+t/xIFAEqezMbt+0QyMzy/wh7LI9Y4Bf6kkTVaACSsdqBdCZ7zd4no7Ugk35LNnW4vZpAynyUyDy/bKjcwQQuFLITJziEY7tCsujHsTbRwcrjz0Wano/xD2skNu0bqRBW1V1gx1J0AX4sxCzCbJE79q5D1KA7qs/qjSaBKXl+lwnzXLCmNvtErPbUqJJ1ltQ6dU9F+TmXlHvAVMBSGz+7PD10/NhpbSopMuA7o6T6LsCUgwO3fyTWjugx9sMwQCVX1DULgWm/BVZJ+VTfALxsK3apOWPNNNH/Z2+VZkSzdnj1EEirDqKAbfbwbzFKS6VFJpiYGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xLzT66g2F2J1TT++Uy87psvxahsrMt3JD6vfvZuW7c=;
 b=hd7FgjOx+AKIOob6Kwdcdz3Z7kndNyY3mxZw19dCEeJjObWDuDkxE3JDo28+hNm0D2VHUGDzyy97VlIx7pbL1MVzTGnX/Oo6KOE3eXwCd/ML7zpdSISAC0g8H05D6AJBPDvaP+CSXPYyVFQKzRRqXmkbXCPsXw/bc/Z7jdTmu22xjA2Aq186X4fC4cH2jiTF//r2fExm4FaqL2zdHNrMXlgOhux/Y1Mmkw+BM3oURjOU3GpygGosp4hy0wUdsaWsZpM7IhK+fp6Wyf+oaakDLPI3w3KdozR7NQxTF1M9gMo8/jZj4rvt6oxwS7p3Hr4kJjvucMagKgmDA62i64s/7Q==
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:35 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::ad) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:15 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 09:00:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 7/7] mlxsw: spectrum_router: IPv6 events: Use tracker helpers to hold & put netdevices
Date: Thu, 27 Jul 2023 17:59:25 +0200
Message-ID: <f0af6ad4722b4ca6e598fd4fda8311a3041651ec.1690471775.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4360fda3-708b-4845-b6a2-08db8eba9ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kO4UF67ujv4JVa4hYoSd0AZYx+ydPhLGd/C/Eq6XVKdGK074VmmQ64+N0xhS4+4vKPBTrp6kZcQXLNlXVdPZY6mTodYao3g5dOuHLnKvN+ZZG9ljZIQNyXy/VwFDPJ2d7zggNeFTdw+9TPeZeBTVkO4ZrGTEWwDGRhH2zVELtbmM2HZpCFZNl4uq7rKYSde1RgtANgSiBn0RHHDiYTPdxWRVDLZdtPh5VVuRRGCUJvmYmsXEg4TtCFmZrmvsM7OUAHnKlL61EcQBb/Zkq9MEbXslsADohBqU0y2tj9e5z6KF6DALJCaKPOyMG/Y/l41zRuqudBE5yKKQL/htOyeznsZNk7hjgamu7/pT91WKPK1mOjh4lKNIPSEjWcNgRtSGS+CUXNNdLZ+5vmbXJfkMV7lvAXt5wB8IwwrYCOWCvguvjkQ3siZJN18+vvbzSAuoFv5ung12xJaG7u3u6S78khleT+CnYo1CskrLuDeb0WBwAtitTkHQkOrUZ+Vkpb9OjBZiYte7ASFvREt1uPrx0P39TmiWuIq/8SmphGgoKB+JYPke8Wi1zkbgB/35epPkUtkClRLYyP+tlXH3Ng7g41agGmJt62K8wnsfE5fMjei7OTsayOoQZvUYZKk/e45lq8h7UPE2yMC1XbQwtPl83IWtAZpypdOVy2VaXdr/81RLCpcJeuAkiLML/dM1Vo2K9QjIjgiW6U24YJRh99zXAE/xF0EyuZ1GcM9i7SO5HhOs9EfLmD4g9Y9JrkCcUeCj
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(54906003)(2616005)(110136005)(7636003)(7696005)(478600001)(6666004)(356005)(70586007)(41300700001)(8676002)(5660300002)(70206006)(8936002)(82740400003)(4326008)(316002)(66574015)(16526019)(336012)(36860700001)(186003)(47076005)(426003)(83380400001)(26005)(107886003)(86362001)(2906002)(36756003)(66899021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:34.4062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4360fda3-708b-4845-b6a2-08db8eba9ca3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using the tracking helpers makes it easier to debug netdevice refcount
imbalances when CONFIG_NET_DEV_REFCNT_TRACKER is enabled.

Convert dev_hold() / dev_put() to netdev_hold() / netdev_put() in the
router code that deals with IPv6 address events.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 59d12cf45939..debd2c466f11 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -9333,6 +9333,7 @@ struct mlxsw_sp_inet6addr_event_work {
 	struct work_struct work;
 	struct mlxsw_sp *mlxsw_sp;
 	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	unsigned long event;
 };
 
@@ -9356,7 +9357,7 @@ static void mlxsw_sp_inet6addr_event_work(struct work_struct *work)
 out:
 	mutex_unlock(&mlxsw_sp->router->lock);
 	rtnl_unlock();
-	dev_put(dev);
+	netdev_put(dev, &inet6addr_work->dev_tracker);
 	kfree(inet6addr_work);
 }
 
@@ -9382,7 +9383,7 @@ static int mlxsw_sp_inet6addr_event(struct notifier_block *nb,
 	inet6addr_work->mlxsw_sp = router->mlxsw_sp;
 	inet6addr_work->dev = dev;
 	inet6addr_work->event = event;
-	dev_hold(dev);
+	netdev_hold(dev, &inet6addr_work->dev_tracker, GFP_ATOMIC);
 	mlxsw_core_schedule_work(&inet6addr_work->work);
 
 	return NOTIFY_DONE;
-- 
2.41.0


