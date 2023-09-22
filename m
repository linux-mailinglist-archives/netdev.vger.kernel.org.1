Return-Path: <netdev+bounces-35889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2FE7AB7C6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B1287282918
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B15436B1;
	Fri, 22 Sep 2023 17:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7B436A3
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:36:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0A99
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvFTbDAhMHK1C5Zvf54DC3LidwZarSxJBS6JZ/Hk37o2zYUaY/PS0pa5Iv1YwmR/ojSOIKeTED2Hg4BW349oyy0STnTh6pSryNJhyIrxfEeTSWUq2bby30CMipeLntd4I02DJ/SBaImXFY4leODt0TTaU0+5OIk99m2jiDfHGgy2k63l580rnON/IT+zpPchtCGtBbyXHkTMrrRN+yJRt58yXlXYHySwfsSkBUjMx8A8B6SmOyOlQxwCcfNP3Qmj284lkgafUWhtihyichDYeGjSqmZJoeINsAC/8sbOnEYTpsKuXmqtkljv+XedY4VxnXbaK/M2oersFcKLPJQPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DF+Lt4Enup8LYliIx9yQvDj2u5yAJKBo89URmoEK38=;
 b=QizMYtNBwmlTvV5FNCM1jZPrFo9FpVJ1ggCBFQJ/9B0jyDofmzq7nMB15XbWhCcwdauSKFtTRLDSiKFmcvj2VA0rTdVvTvNJNhhSqLHq8LBCfqwyC9hPQnI6aANnl9jl9+aPOmu3fuInGWkIrjJorJtr30VHLyxjeFwDJWTepuLrq301tMjeMuysbkfym+XD6e8lEQKS+PXj6rGzrGAEYnB9LyE9Sa7My7dEoiS4MPxdK7p4Ib1JM+SQKX2bQ5VO1QFhEfhOO2uXccEHivxkgEOqZNrAWtXaYA5G8YIRLQ2uCyzUn+N5pkzSzS4yeSeAWG95W1Q4/9x7Cp2TTxiQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DF+Lt4Enup8LYliIx9yQvDj2u5yAJKBo89URmoEK38=;
 b=ly4tTXYK1Wbkj7IPhRSBYXcTdNjcWvfD5vlaJvSruHLfw7meo2+DucE/vXNe28NWmuF46zk+k9sWnaPv5mwv6Wc0XyReVC+f6Xgg52B3pNzYIvutH+C9QHZhF6/oXNEznzgCf/NJkgBnZLhd/u51C6nW1dCk4rSkFQP7yGDRQl1QmK7d6x/VxM5dBadVsZYuTwaOBDBqQZccuwYwicpiWivDr+rMpVcaxXJJ4PCTcOO5YGriwVzzDpOqUWMty+frhkCJYS5OVzfAbexXr/8BOFziTS2Y6r98M14SXZo6broD4C/ApGJMiT+Q2c+3BkS7i1sqilZAsFYRNxd2AnxhDg==
Received: from BN8PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:94::34)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 17:36:44 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::48) by BN8PR03CA0021.outlook.office365.com
 (2603:10b6:408:94::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 17:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 17:36:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:36:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:36:31 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:30 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v3 1/3] mlxbf_gige: Fix kernel panic at shutdown
Date: Fri, 22 Sep 2023 13:36:24 -0400
Message-ID: <20230922173626.23790-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230922173626.23790-1-asmaa@nvidia.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e535613-e34d-40ac-4fc0-08dbbb927d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ax+acN929xZMBR2onSETZciOKxSKrOB16388XB5H/KNuwq28ZjGdBBGfbcQfc/8OWVVAkgb+fkp8kRKPG4JlR60Yzophlnh2bxIxELUCba1oAKg7EZIpknuLK4tkUeiH60Q8af98Xcosd1MIYD3qqsPNGVesq66TB502x6sSk0WOKdN7sg2U+Ydq0B+tAP+v/KjEfXWTcneM6F6Z0pIdfqE4FMq4KHJXryk5a+NXPj5K/53Zo3CfRVJiGajpCgNNRvciDkqJXR1UZewN5AX1Sj+Nnru+VqCfTo2N6C16uaY30uZ24XvrckVmjMmiyOoaT22YIXO+H4kdvxpSWTBBtndS9oxZXsssCP1jReyhM6IBPjyuIIbI4dAcvJq8s/+QsKh2HrbAgFGH7WCpmCX9otPjG7R0qxVdOCLu1hTeAkW34R3e4+vLqpHOkGLGQ7PI+2uOD9U2VWcum0gvC+aULOoGYrG6SrpZSrozhpMnNWPNMPSX9VxWqCvedBsevuGcI5vYXckWIqOf45yGhWDVZJNoPJyvB4t+6Jc5G33csC0O09016uXZWQinrzJbwPxrPk68JsaqYxZhh+gR9s/x5lmXVDMbcGQCgyo8i7XtbZjmufvW09bSHdtcqCJU3kForEsWutg+L7/FuLA51TqjO5lRPkznx/AGDAlQK/q+CNwuJaG/334nzYFdvnDAs6gpRjBUknYKMPKLxBb/6vp5lZAlfJKX3ns1Fm6NSfeAg61dpOuaKfsGQHpkFKg3jyNx/tRAZ2cchRclzk1kQJsxg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(1800799009)(230921699003)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(107886003)(8936002)(40460700003)(5660300002)(336012)(83380400001)(1076003)(2616005)(26005)(36860700001)(47076005)(70206006)(54906003)(478600001)(110136005)(70586007)(316002)(41300700001)(8676002)(7696005)(6666004)(82740400003)(426003)(4326008)(356005)(2906002)(7636003)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:36:44.0237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e535613-e34d-40ac-4fc0-08dbbb927d19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a race condition happening during shutdown due to pending napi transactions.
Since mlxbf_gige_poll is still running, it tries to access a NULL pointer and as a
result causes a kernel panic:

[  284.074822] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
...
[  284.322326] Call trace:
[  284.324757]  mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
[  284.330924]  mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
[  284.335876]  __napi_poll+0x40/0x1c8
[  284.339353]  net_rx_action+0x314/0x3a0
[  284.343086]  __do_softirq+0x128/0x334
[  284.346734]  run_ksoftirqd+0x54/0x6c
[  284.350294]  smpboot_thread_fn+0x14c/0x190
[  284.354375]  kthread+0x10c/0x110
[  284.357588]  ret_from_fork+0x10/0x20
[  284.361150] Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
[  284.367227] ---[ end trace a18340bbb9ea2fa7 ]---

To fix this, invoke mlxbf_gige_remove to disable and dequeue napi during shutdown,
and also return in the case where "priv" is NULL in the poll function.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
v2->v3:
- Add the logic to clean the port to the remove() function
v1-v2:
- make mlxbf_gige_shutdown() the same as the mlxbf_gige_remove()

 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 21 ++++++++-----------
 .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       |  3 +++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 694de9513b9f..74185b02daa0 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -471,24 +471,21 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mlxbf_gige_remove(struct platform_device *pdev)
+static void mlxbf_gige_remove(struct platform_device *pdev)
 {
 	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
 
+	if (!priv)
+		return;
+
+	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
+        mlxbf_gige_clean_port(priv);
 	unregister_netdev(priv->netdev);
 	phy_disconnect(priv->netdev->phydev);
 	mlxbf_gige_mdio_remove(priv);
-	platform_set_drvdata(pdev, NULL);
-
-	return 0;
-}
-
-static void mlxbf_gige_shutdown(struct platform_device *pdev)
-{
-	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
-
 	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
 	mlxbf_gige_clean_port(priv);
+	platform_set_drvdata(pdev, NULL);
 }
 
 static const struct acpi_device_id __maybe_unused mlxbf_gige_acpi_match[] = {
@@ -499,8 +496,8 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_gige_acpi_match);
 
 static struct platform_driver mlxbf_gige_driver = {
 	.probe = mlxbf_gige_probe,
-	.remove = mlxbf_gige_remove,
-	.shutdown = mlxbf_gige_shutdown,
+	.remove_new = mlxbf_gige_remove,
+	.shutdown = mlxbf_gige_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = ACPI_PTR(mlxbf_gige_acpi_match),
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 0d5a41a2ae01..cfb8fb957f0c 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -298,6 +298,9 @@ int mlxbf_gige_poll(struct napi_struct *napi, int budget)
 
 	priv = container_of(napi, struct mlxbf_gige, napi);
 
+	if (!priv)
+		return 0;
+
 	mlxbf_gige_handle_tx_complete(priv);
 
 	do {
-- 
2.30.1


