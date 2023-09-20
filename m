Return-Path: <netdev+bounces-35290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9EA7A8A92
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BBE281DFC
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834B1A5AC;
	Wed, 20 Sep 2023 17:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CB1A58C
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:26:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB9AA3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C71ldU8gwAAEbvvx2UtA77SBrgGPjItk0OhhrbgrJLPCTLybSIzkBWwhNTZdMS1q85CSjeUqwDxnCr1DT5e/PDaIGkEX9xNd4tsi+LxnHFJfvn++by8d9uCEGo6s+Cnxk7dYFzanmlXN0Af6WVd2TtZnfAWKDxRWy3wcWfeiiN9GhjXx8aBNaXaXQ1Ge9fBIx4vG67oPJp7OdYQ8mUk1cM/1VOQvAj/BToZ0Kn3V5pvCqE0eNZ8egiyasbRSCxRUjEygFDD/L9DZqt+qeujACXT4RKy6zoNGgEsHvFz9rXJVGFK0Nx12ICnVrUU4Ct8TF0zZetE0J4McR67Z4mSkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8v0HFaArkSMvr8SYavrrK+r7cEQXyYKL/7DqEW8oVk=;
 b=Fb9qktVl/RosRtnccVN7luBjlh0QfmwohotfmXGY07PmFLBAB4LHbz2JDKSzkR4HxhZwtFgjvytdXpef9tM2LAsCvlZKOmGFM7tdR4MN350c4XLicj8CoXerrEh5ZkF8uoKOWuEAgWYevPgO5gwe9LjBTYOJ6xTvFbX4KO4iRSDj04D1rXT2Ec7dc1yCcBQP99tCa3ZU7X2srmmKc/D3qDmXcqzzRspHhUJe6apuYzVKFEj56m8Z+lZvf/MPNoZGiLEH12CLVvLczB1Bimrpku4ctVwHTwh1kfGb5hAxItNbcAf/YZVKlYCsf1egAnRvf0Qm8aDwiCH7e2bwCrqQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8v0HFaArkSMvr8SYavrrK+r7cEQXyYKL/7DqEW8oVk=;
 b=l9MqKOFLV2jsCQfQsElYJOCsnYtgTgKK4yfTDRySbDApzLz6xmAjGUyfpjImN+rfPznOzKh4ByMifT96SaYwDK+H/gxDGqCCq4EqP+1TVLZvjpP7aqShxmTnYWmfHeTK/uPu0PnVTj//IO7RdwFxt+SWeb9aizo/61vCNGcPIuPlamH2Mlh0kh7I+WOovGhMjJMOT3MP34ZDZ74x2eWk//fhMScQFTFtsbHlWSlOfIZlqEzoMNpf892xgi8AYZge1+dVvQO0tD/qK8kCklbXabGrVf3FuSjcb9/rIRtGnWWNdH3PP4bGqFRNK/FU0CHX7EdpEET/8LIbng14r2N25w==
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 17:26:31 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::81) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 17:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:26:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:15 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 20 Sep
 2023 10:26:14 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v2 1/3] mlxbf_gige: Fix kernel panic at shutdown
Date: Wed, 20 Sep 2023 13:26:07 -0400
Message-ID: <20230920172609.11929-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230920172609.11929-1-asmaa@nvidia.com>
References: <20230920172609.11929-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c893b2e-c193-4335-7e73-08dbb9febb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BnpNbPrtCgpjBY3bt1OAz3/1qJtolxkAIbZGyJtC5EB8PfvkNWooCVP0qsqym1Utdkpv8qrUW0xVvPSxU5+XCQOHaz7m2fd+NbuMDT5lK6Ac5iIqNTdKoIZSO2WD49JMPKSBZrjr7aMnmQdlENo8WrWEedEHhcMobbvhm5UPiHqX6baoKPvuzbbZ75efrQ0FzibITT32Yyqo9cORmDDNlhR7+xMbWASiphFuX9XlUBd+X0ytV3Q5EciEcnyG8X9oXmFpeynjS1n+rm7t9mpVPETPc3fck96Sq/N5ycjgGgLs4bK47qpLQ9qQrLo4icyixFkilgbPiUKPlQYmENMaEHK+yQHLLvn9zWKIM5pritjEDHSOXoup7q3JNeV5rJ7Qf/X7uK2sBwK+nQ6/jSfMa1IQnBF6mhIzUEkO2XZi0ZqHdxNLcWrx89qnb5sd5zxTXYhbd1vtRoKBDR3GK9va7+P6gZ99R4ugA5DXKtqOxWr1aGb/Aphe9N/IxKV1ZSFkpYvSbK1HcI6IYRi8yt2Cbltpgu1d/lKz2eVLj5MGYsOj2iDVBh+CGDIGyb5QpY/+FlygYeaVNA6mWVtY/v+mYnemDPBUAGLGwoSGxPiBGpHW4AbFfRY51QSQdeOrMStF522uqOc/u7yx2hAVGFNH4lHiJzzoG06epUXW4+uQe4dLjEU6NhX3/D082jdMyCiQ9V8EdS2+BGzFKjUvx1zE/wzb4LVc/rLR2vQlMjYWaYvHOaWoPdzO+YjKhaLZg1qU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(316002)(70586007)(70206006)(110136005)(54906003)(40480700001)(478600001)(6666004)(40460700003)(2906002)(36756003)(86362001)(41300700001)(5660300002)(4326008)(8936002)(336012)(426003)(26005)(83380400001)(2616005)(107886003)(8676002)(1076003)(36860700001)(47076005)(356005)(82740400003)(7636003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:26:31.2237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c893b2e-c193-4335-7e73-08dbb9febb0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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
v1-v2:
- make mlxbf_gige_shutdown() the same as the mlxbf_gige_remove()

 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 19 +++++++------------
 .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       |  3 +++
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 694de9513b9f..98f75c97b500 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -471,24 +471,19 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mlxbf_gige_remove(struct platform_device *pdev)
+static void mlxbf_gige_remove(struct platform_device *pdev)
 {
 	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
 
+	if (!priv)
+		return;
+
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
@@ -499,8 +494,8 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_gige_acpi_match);
 
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


