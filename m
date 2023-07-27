Return-Path: <netdev+bounces-21976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF676582E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703761C21557
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520451802A;
	Thu, 27 Jul 2023 16:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5D19881
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:24 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FED271D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok8WL1ps5MEySt8iR/YPYNFRPV8ATk0RLssSKaj+q0yhtcHnh/H1Y0oID167tbDGDXIvy0aH53npg5Qbr/GYFlrzdoXo/mioAko74k3yUIoHp9+xKLJw1qgmbWzYbAdFotqVIwLr/0z4LMNPa2LXkg4EmFT5P5aRdRSZyekN5tyxcqF1r5i3d1kHbWRgMKuTHdrLzRLhhza42BXnDp2fwXKJfGtY9IOAjwZ21bA3A0Xv57aEr0nlRw/MIzy6cvpqptLTmqMiZTiXVOmor5yeLV/SLwd5l5X080P0H8oORGK8CvBGfegPTCJUTds29z6cG6g/XI0IEw5zCr2CJamtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqBQ89P9s9Aq/ubxUExOk6COg4HDxE+LKoVqQ36ky58=;
 b=KFUPkhyipybWXA6lYuerlFEP2v0vc1ov0sWaMfiD7YsbsskjclsmT22ReMrGqqcUFQI3P16w8vnYuqPjb3Glpip/jkNwxiys3wxr5nR71YBJ5X8TV8NoUV9lr9T+/elS1iSAsmN+iWuY7Ffb7xu1LdytPpfSSGKVdsH+nASH3ExjXx6ATOzsIxh/kSfZE0F7AQLPdhoOu9IQAJ1PNSJp71BoX2/qtMHaPU7lMKrptBs4L8TT8B5N2uvSqmDkeMplS7T37pf+kbl0UZ/0jnH04fcpVNj4WNiQvFu1cnobIcYh4NBabLUCGU/wLImg37UCOPm1SudGgZSbJGHnDN0rEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqBQ89P9s9Aq/ubxUExOk6COg4HDxE+LKoVqQ36ky58=;
 b=PWl2q5a/BeUfSWSUlECbCj4pDDzrqlaCH5zFHk77PRESiI0hAyyfvCN0FhuTLh3BWGnKgsGS6IKRIX5qdkHd4omRMwglq6GCfylmw9xTc5OmnvpCjwBSg23LEV9g3IGBDDD5YbIHVa4syu5ZKoIxaYyRt5U+oGQKEvQP8j0i92VSEvqrvljk8N7ujPXbVirMZ1+pdmE5rjMQ6vxf5ex0o9I+fFftguvjxhewWXuNlEopQ4hDh5jVvacx46QwGXGd+kW/Cbm2aLuvCjEGzhpvu/bxttUfdQjXteeQrG42OZsOQdkpvjz/gDBbJ15Mgdn31QmnwLcRXplexcy2ZYdHWw==
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:19 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::34) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:06 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 09:00:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 3/7] mlxsw: spectrum_switchdev: Use tracker helpers to hold & put netdevices
Date: Thu, 27 Jul 2023 17:59:21 +0200
Message-ID: <774c3d7b5b0231f1435df2ec9dd660192e382756.1690471774.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: abf6e998-1299-45f0-f60e-08db8eba936a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i32f7quyI3sEnmmWqS8RB5V7c3ZVw6V/Ivz9dARGVnLYVCu1X6BCQbDnNAAEJNnSSCEZCQ4rkyQUe81WYczJngGQ9XLu4LQnZyG1qYjeWbfQTILXaOat2rSUwLLuVAXst0AZTG3DrvmUoFmLisXLvVmh65TqR7ixu5BZSXq9FoFVorQkXbBFENy8A4NSCeuIdrGYOmWX3LKFkO1UFGFHUXHGTCg+gjHMiXzc/HfaiJYRix9+4U+7QkLnG76nTtq3BjP9mwKrL7ZHhWWBEwyZKjC7vRQZCdiljfoLh8W7AiSPRkR7WdbXz2B74LtXGcqtp9Rs557FF6Eb6SPviAiQSzRcmbULpLZL9x4MaRh3iUIg61X1r6V+ZBYIEeYxnJ1J5sC2cKpGUCyXjiKFGcdKFHGMsQQUBbDDxEqhjY7LesLu0jrn2rDjoVzjZc9Fiocda5Dy51F79B7kKm/TEc+GeezLGaXAQPeZyUYP4607+jiGP3JtgRCbCpHtKVLld1WiSlsn0KHBgvxbnofAl/Kp8XiyeKgGhhIGiPNIbXOL74nmzEkBJIyQ9HqpcWu3RLaAUeI2+kzrn1QScqR4JAtpe7BV1JxkOvb8suAmBaZ/Ya8FYfhDM0mnuSPa1jY7PIC7XvQ5GvLsvbSy6n/WF5goSN0jL1CEdhzw/iMukA9aXTWB4NB46jisGrIPPCKJB0K2vt+BpaQOjiC90SL+e5OGkj79EOEK6X5BQZRrViPSl6I/OHyBVTShJITud5aNUmRA
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(186003)(2616005)(26005)(336012)(16526019)(47076005)(36860700001)(83380400001)(4326008)(316002)(8676002)(70586007)(70206006)(8936002)(5660300002)(41300700001)(6666004)(7696005)(2906002)(478600001)(54906003)(110136005)(40480700001)(82740400003)(356005)(7636003)(36756003)(86362001)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:18.9504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf6e998-1299-45f0-f60e-08db8eba936a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using the tracking helpers makes it easier to debug netdevice refcount
imbalances when CONFIG_NET_DEV_REFCNT_TRACKER is enabled.

Convert dev_hold() / dev_put() to netdev_hold() / netdev_put() in the
switchdev module.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index dffb67c1038e..5376d4af5f91 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3380,6 +3380,7 @@ static void mlxsw_sp_fdb_notify_work(struct work_struct *work)
 
 struct mlxsw_sp_switchdev_event_work {
 	struct work_struct work;
+	netdevice_tracker dev_tracker;
 	union {
 		struct switchdev_notifier_fdb_info fdb_info;
 		struct switchdev_notifier_vxlan_fdb_info vxlan_fdb_info;
@@ -3536,8 +3537,8 @@ static void mlxsw_sp_switchdev_bridge_fdb_event_work(struct work_struct *work)
 out:
 	rtnl_unlock();
 	kfree(switchdev_work->fdb_info.addr);
+	netdev_put(dev, &switchdev_work->dev_tracker);
 	kfree(switchdev_work);
-	dev_put(dev);
 }
 
 static void
@@ -3692,8 +3693,8 @@ static void mlxsw_sp_switchdev_vxlan_fdb_event_work(struct work_struct *work)
 
 out:
 	rtnl_unlock();
+	netdev_put(dev, &switchdev_work->dev_tracker);
 	kfree(switchdev_work);
-	dev_put(dev);
 }
 
 static int
@@ -3793,7 +3794,7 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 		 * upper device containig mlxsw_sp_port or just a
 		 * mlxsw_sp_port
 		 */
-		dev_hold(dev);
+		netdev_hold(dev, &switchdev_work->dev_tracker, GFP_ATOMIC);
 		break;
 	case SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE:
@@ -3803,7 +3804,7 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 							    info);
 		if (err)
 			goto err_vxlan_work_prepare;
-		dev_hold(dev);
+		netdev_hold(dev, &switchdev_work->dev_tracker, GFP_ATOMIC);
 		break;
 	default:
 		kfree(switchdev_work);
-- 
2.41.0


