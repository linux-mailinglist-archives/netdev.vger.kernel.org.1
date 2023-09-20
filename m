Return-Path: <netdev+bounces-35293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D47A8A9C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BFF281F28
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDFA3FB04;
	Wed, 20 Sep 2023 17:26:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C13E48A
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:26:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC1B4
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjiNj7g7QSvZT5xVuKqtHFiRuUpQtQLCCNqE2XmJFWkbh/35vw2bZBRVzKIXuL4mD18vKq7ktxqGI1F1uMkFHJHmCKehDn563hsQej/3XflC9Kidt810mbSwqd62nl8ooZ4sgpokfTkmw5Ac44hV302Z2XBLg1TxcYjo/fXYNxNzlltqn27/jqywc/LPL675M1NLHn+su2TbUg+4XTQYB6WSr2YbZIsdNrhi1UwklxGxnmCJzsF/uoflFCQospzBLoi8gB2TpN3TI8LYBSpURv3Ee+LPDxCZlY6jv9mhC70vzgAACd7ZB1IGuwBate4Rb8fIpRKcVm1MkC+BoUEzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMbgY9PMS6DY19xauGFRbQGmn4QMn7zZYAbA3kC9f+c=;
 b=ce6px5SidT4FMN5cwC3BoDjdlD91Z0IvLiW7bTOhGC2pjf8tANerGpbsponbUEfz704IFz+IHdZUZkt4YUS0AVjRG+4STSU/qtde3q0yDDy0Pkn74RGIU0MiY1vIQFQdx6YtxGTjSJ5xhGW60/E0T5ZQmBQUiJjOotUU7TT0zKICKTYDjyTuNDSrEnLuKbGAfwMWxKv7IHBXKCnRuzQhJeiR1W4rNpk3gDGirY7R8s83L6ufHNySgaL2uusoQcLPe5n5xV63gAQsWHpcSGZHE4TFKOqvertfjsWpXhAD8EXEzycpGVhMrzxFzPDrhGJMTy0DHjNqHBe8DicetX13lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMbgY9PMS6DY19xauGFRbQGmn4QMn7zZYAbA3kC9f+c=;
 b=kVm7Ci42F/NUjoDGehqtpAP59HOOAgI+ckJQi5RAWJ5RTvDEoHZZnZbBLg3g0N2GNcRyPAOd3yGVPN1eKMa+OknO4Hcr7MiVIgvTOgF+EQa8bp8pcmq4b976beFTZboa98Y/zZoLE6sBcfVrzL7K9cIW+Cs5pa6g/OsnHDSVQxuroQJFeZaHLMW0gEanwd2b+ioQQhdZArguVPMkSHxpdUPCj2ANaYOxCD5nnuoZcS83Yb/tJRks3s+aULaAo+sBNt+wHHB8K9v4vZO2MCrMw2GIFsbNpbhXnWRpyFOB0k0J1fbJqHQFoSNdGmJqH4Wls+fkkiKyDltGEvX0KpxF6w==
Received: from SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) by LV2PR12MB5870.namprd12.prod.outlook.com
 (2603:10b6:408:175::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 17:26:36 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::ab) by SN6PR2101CA0017.outlook.office365.com
 (2603:10b6:805:106::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.4 via Frontend
 Transport; Wed, 20 Sep 2023 17:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:26:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:21 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 20 Sep
 2023 10:26:20 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v2 3/3] mlxbf_gige: Enable the GigE port in mlxbf_gige_open
Date: Wed, 20 Sep 2023 13:26:09 -0400
Message-ID: <20230920172609.11929-4-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a20befb-e612-4256-07f3-08dbb9febde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wsNY3NjFJkc292A+7zyRQ3f9AKlBSG7mK/rdz3dmxYTynBVe/NfPUhs9c1zOzQFKVDYVPXEpOLOUpj7+IpUFCsx2GTGxj1nwb+XNnhjKpFmT0k/nci6x1Yke1YGTn1eDLPVgqXDQoxZEp5AtRqth+atZXSGaGkenfKSm54qupokLQsHSU385wKZlryS1sVkqn8MuOonA1/yqSXi0Wq4HWrhPn08s48H1hqNrMUkE9jEzdTzxykOzJ6YrSgthb8YR7CR8TtF8Qmw9U+eDoA+bgxGw5uqutKv8RmVqUWW06jWE/Kcc6bRZFK5RLp4YgInP2KXjQPp+iGFHn+QXcIJ3edNpL4XhtTK8hkHYHFyNUwjrOZNuE79+Aw2OwoHfA8Y4k3on7pcz8uosMTW9PfAIaLsS7f6ejMgOu+wJsNxtp1rrM8qGHi5CdVQv3XcHaGpGGfzkA8YtY+ZduPJjmwlOXUELnVO5WfXGgQLo11adlx6ausT/EWMusEkkf+sGs9ukCHsZdWQHPYdTrwlkHI1iJZLeA2ZCwBse+4TF1D2cTnk/lPZzAXiymxHZJaEspRpucqPiJNQVXBawxKB3JVXBBA/3S7I4pZnbazby5JsdR0nDkcNarAsbz3aYNw6XPZz03lLFMcOeDvjrnXDqOyNds007rGNqdLQpG2v3TNlPDAqRjU1DM+VKYuc1ieILgsgv6r6qCNU/LtBJZx3ggEuCo3dTXXnkTVbcLZptW7CwPjQdexS2WeV8A72OFkWB5arg
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(83380400001)(4326008)(47076005)(2616005)(2906002)(107886003)(336012)(26005)(426003)(316002)(70206006)(54906003)(1076003)(70586007)(478600001)(5660300002)(8936002)(110136005)(41300700001)(8676002)(40460700003)(82740400003)(40480700001)(356005)(36860700001)(36756003)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:26:36.0361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a20befb-e612-4256-07f3-08dbb9febde7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

At the moment, the GigE port is enabled in the mlxbf_gige_probe
function. If the mlxbf_gige_open is not executed, this could cause
pause frames to increase in the case where there is high backgroud
traffic. This results in clogging the port.
So move enabling the OOB port to mlxbf_gige_open.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
v1->v2:
- Fix typo: "base" to "priv->base"

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index f233c2c7b6c1..f46d94256e2c 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -130,9 +130,15 @@ static int mlxbf_gige_open(struct net_device *netdev)
 {
 	struct mlxbf_gige *priv = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
+	u64 control;
 	u64 int_en;
 	int err;
 
+	/* Perform general init of GigE block */
+	control = readq(priv->base + MLXBF_GIGE_CONTROL);
+	control |= MLXBF_GIGE_CONTROL_PORT_EN;
+	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
+
 	err = mlxbf_gige_request_irqs(priv);
 	if (err)
 		return err;
@@ -365,7 +371,6 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	void __iomem *plu_base;
 	void __iomem *base;
 	int addr, phy_irq;
-	u64 control;
 	int err;
 
 	base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_MAC);
@@ -380,11 +385,6 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	if (IS_ERR(plu_base))
 		return PTR_ERR(plu_base);
 
-	/* Perform general init of GigE block */
-	control = readq(base + MLXBF_GIGE_CONTROL);
-	control |= MLXBF_GIGE_CONTROL_PORT_EN;
-	writeq(control, base + MLXBF_GIGE_CONTROL);
-
 	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;
-- 
2.30.1


