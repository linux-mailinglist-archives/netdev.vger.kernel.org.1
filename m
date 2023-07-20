Return-Path: <netdev+bounces-19647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D09B75B901
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF11C214E5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357D16424;
	Thu, 20 Jul 2023 20:56:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0D2FA5B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:56:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6ED19A6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK1ukEpViabd/guQc78wOkmuNCEpPjjO75zUjZtQv7xrKP6AykluWnryuiUnL1foY8HNVXv4iGCkOr1vPN514TYAoQ866tn0BxVLfcP4il1/V3vYjb1RoLdJHyCwP71lBK5Yte8Sr1+GmzcQqt6GvBrhWWgSxATJU1WaQnsXLTGeah+kuA7eX/sgCCoYrqMh8ZzV+sUPmMGdah6jgnVSHkjgCKbwbKMtqfY4N+5sOjvuf+AQh0F5giAW2yIdu1Xj3TEFLjH6VEITl1z2bqhfRsxMU4fUVM4EdEq66wL4nhYYQncMwMS0G1UgvARFTPzoU2w7pRVpOhQk1Wvgtz2l0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+0FGD4hy6SflKcehezfhM1xXnVGTGZKf9/N7nCboa8=;
 b=FPwts2JF7rx9MISSq64zMSuUF3j62tW0Mj3IjnoiOeL/4GeUqmfeNkVAOJpfLYu7mJvAq5ziqJnVkbPhxGk3+u9QYQ5L5D4CJy033LclWrY21UseYH6xB83SwLAMiqLy/XaGJSPdXJB926+xZGODfoF9RLs5IstRwPEvi/yK6Jgdqbw9B8H4dBk4hPuu1rvscp1rYXukc+L2cFOa0MgAuJQr/iAVwTM8cxb9bl3MrKZQ+4cWwOGGNGp92wx4xjaILQ74eJ6Y5E71SZd+tdNiAXxiTpJKjobLdsn4I50qvuU1FpsTyW+eaj03dIj3nuzxycX35ZVHZZSWZBRfHxNhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+0FGD4hy6SflKcehezfhM1xXnVGTGZKf9/N7nCboa8=;
 b=DMEhmo0pvTIsMi41kZdOaFk2IqkahZbGnXPC+qNLPH7iVfrB+5TVEwptmYPk1vS+JOKQ3xDnzafY520iYW2lxLMsrPkrsw/y1opsspdMleL2di2l1j9RZZWC2Oo82LenOj+M0RNt0fgzDfiQuhjuilFv7VSn2ERF76YMXdzcP9NxVii79JFfftDx/YTh7SE2uVPV/nbbqQlXkr+hUEJQ4Lj01kpKk2Qk5Sk91YAGO1ID4JQh1aLpKI10yUg1G+Z3P47KSsVl1Tm25OWDDM24zozQJTQi5TmfjnAh/KcH2D0jInmuS7HMQ3gIjQ44UjGBZ7+RpJyznuaEvvD5E6RX6g==
Received: from BN0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:e8::22)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 20:56:44 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::54) by BN0PR04CA0047.outlook.office365.com
 (2603:10b6:408:e8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 20:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.25 via Frontend Transport; Thu, 20 Jul 2023 20:56:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 13:56:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 13:56:24 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 20 Jul
 2023 13:56:22 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<sridhar.samudrala@intel.com>, <maciej.fijalkowski@intel.com>,
	<olteanv@gmail.com>, <davthompson@nvidia.com>
Subject: [PATCH net v3 1/1] mlxbf_gige: Fix kernel panic at shutdown
Date: Thu, 20 Jul 2023 16:56:20 -0400
Message-ID: <20230720205620.7019-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: cd534f81-f31a-46fd-8fca-08db8963d2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nbahjev2BH0rGTtUSKWjlNHTnLquy0K7W1gW2mtdAE12I4ZGezs20tQsTd0ifp4BcO83BaytLsOBEh77rWQND71OHK806A0K4TfCxMWgS+lCBYfWNE4hJYp6l+pVgeTSp0yTINGosut3I5cxQbdZPEeCAt1RQuMcU4OlDrka2wdNaahMqcZ2yKBrDBydDlf2LMKjOd76g6O9SmAMD6yc+vnyqXxgPsIz2epX7Sw+ceQeY18c/xGkb60Dc9KueH7qMatH0fT2PBWkEFBrUIt92vfTvpv9XbMB2tqY2Oo9ZjLHkITQMNuTNfv5Je6zy+6QbqSoJypZ+D3l+beLoWA4yaVTpEMtLrfEGiVH3XaLsay9tp+8qFj2H7C4gm2YSP/FKxcP1Ywa005I9dKJaRqr3WMiQtIygu5jUBg+STN/Q8pX4mhxUBVUnVLQvIJ8LCTdmI5duiMLlFFEVhwGtJeX27dvOb/UI0qaUWmjSGPewmZM1xn2uF1kOrTXHVj5w2l2i8GJv3vMsq/xF0j1JEVh0bQ1oGLC1Ypm5voY4r8mEyG720hbekYB6SSbEMKBKie95DKnPpQ9zOb0+HF/otVcJsehbVk4LT4dUup0dHgulMVMv1nUVXzBNipc/4w0ofV5drgBURa+83vfYt1QLSk4VHUZ2WkXDJhzsgxkk0g3UT1RfT7iCEUl7sxLc4asb0btJc3WXQB4nYbofzQ5N0VQjsm2sq/Lu1dwsjTTWaeQl/sksyewzM2khmFOkQqXuSOF
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(110136005)(478600001)(7696005)(54906003)(36860700001)(2616005)(47076005)(40460700003)(86362001)(36756003)(83380400001)(40480700001)(426003)(2906002)(336012)(70206006)(186003)(1076003)(26005)(107886003)(82740400003)(5660300002)(7636003)(356005)(4326008)(8676002)(316002)(8936002)(70586007)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:56:43.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd534f81-f31a-46fd-8fca-08db8963d2ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a race condition happening during shutdown due to pending
napi transactions. Since mlxbf_gige_poll is still running, it tries
to access a NULL pointer and as a result causes a kernel panic.
To fix this during shutdown, invoke mlxbf_gige_remove to disable and
dequeue napi.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v2-v3:
 - remove mlxbf_gige_shutdown() since it is redundant with mlxbf_gige_remove().
v1->v2:
 - fixed the tag from net-next to net
 - check that the "priv" pointer is not NULL in mlxbf_gige_remove()

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c  | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 694de9513b9f..31b84d6417de 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -475,6 +475,9 @@ static int mlxbf_gige_remove(struct platform_device *pdev)
 {
 	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
 
+	if (!priv)
+		return 0;
+
 	unregister_netdev(priv->netdev);
 	phy_disconnect(priv->netdev->phydev);
 	mlxbf_gige_mdio_remove(priv);
@@ -483,14 +486,6 @@ static int mlxbf_gige_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void mlxbf_gige_shutdown(struct platform_device *pdev)
-{
-	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
-
-	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
-	mlxbf_gige_clean_port(priv);
-}
-
 static const struct acpi_device_id __maybe_unused mlxbf_gige_acpi_match[] = {
 	{ "MLNXBF17", 0 },
 	{},
@@ -500,7 +495,7 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_gige_acpi_match);
 static struct platform_driver mlxbf_gige_driver = {
 	.probe = mlxbf_gige_probe,
 	.remove = mlxbf_gige_remove,
-	.shutdown = mlxbf_gige_shutdown,
+	.shutdown = mlxbf_gige_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = ACPI_PTR(mlxbf_gige_acpi_match),
-- 
2.30.1


