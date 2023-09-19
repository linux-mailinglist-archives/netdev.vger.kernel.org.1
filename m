Return-Path: <netdev+bounces-35085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B07A6E7B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FDA2811F7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC83B282;
	Tue, 19 Sep 2023 22:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7593AC1A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:14:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00F1B4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWtCFbTy2v4SI9uwMRPrDSkdOsAzVlw/MDVc5l1bk7n76B9teeQaAPzEvYA9P+oEfeRdWifAC0DIm/E+BO9b7/dpLgnqYIj8+xM2VUuCg4ZinkLgiorWg2gI3F0k9o1Wur9cFkRr10koExcu6FX3Dk6B3FBUdbnQBQ6+dhkjL0ZPqBhfUmODJY7B3Muoxd0SGKEVq1Q2lwb4fw6MNpbYAJN8eFGkjeEpLgdRTLCPywOSXxC9OfpN89VIrAJXNfZqYmTa1SZhPf1sXTDt8wmR3adqKkl8fpM48XX1oYdEbmow8k2jbYHYmbZ7MipcwmsZHkJthV2JTytjQIeb554HLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9GQVquevL0TkDm27rT6txSGyNY3SXYr7Y3acPfVwgo=;
 b=BFmtSf0UGLmn7tnD6oL+sTdRPQcbYfIlBeHl9nBtuLRp6IIc3ke83gH1Q8bEG4QD00e6LDdpnF4y2IE3xqaNzCkKNmh0XocL64MoLfV1WOAt8sS9IFLDpUVeyqiLmDCXnnjoyI8Cc/WwEb7eQuX+g+aNgS+SxzZiYX1lU1+WaYNw3P9NGEOiEl8NxBSEWGypT8+yeCKpPpI43COst2jUDmhyH03EsfJ1xynTpnvVLLUpsqf3whNutYIiflt1QOS+TeDRUV0+Wkrmrn0UEUO5UzKI2EKpC4mI9JFIsiVRXro1B4iJVztourGCOwSYmYeAXkp4dpWeZftQrcVFslYzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9GQVquevL0TkDm27rT6txSGyNY3SXYr7Y3acPfVwgo=;
 b=T5lpXMQkjI7K/K0r3gAKGFF2jgYsvJTOZwmJuxGMe3b7XOKSinoZXeGJ8PHgWfXux1qgFR//+qyjRjHJb5FIpzf5Y+W5bYZebt+Soj3bBNbFq8y+eBRX/51BavyCtt1zGfb0VJOUSXrGgN9o/pXItYdF6LJXuabcPa+zJ7lQROE2DejpD61fs75lkJQZq4+5Y7OkGkJfc9qOe1lumcjzFdffUfHFGgLeVnCB5gefjY1+swxvWNxpdGfMCnnpgnod9pu0vh0xkxhGKT2XLW4VRFlfYYSPzNmr9EqC9aSoVSBHapekgs38uY7Ok/wU871Wxpi5cbS2A9t1NYKztP+//g==
Received: from CH0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:33::11)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Tue, 19 Sep
 2023 22:13:29 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::ab) by CH0PR08CA0006.outlook.office365.com
 (2603:10b6:610:33::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 22:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 22:13:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 15:13:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 15:13:18 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 15:13:17 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v1 3/3] mlxbf_gige: Enable the GigE port in mlxbf_gige_open
Date: Tue, 19 Sep 2023 18:13:08 -0400
Message-ID: <20230919221308.30735-4-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230919221308.30735-1-asmaa@nvidia.com>
References: <20230919221308.30735-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7502004d-540c-40dd-478f-08dbb95da6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1gm8G6NtkNF5uDGMpOEh1/qdr5y0j401iJ1bsgWU8qsMO5NKj3BBd42S6FuFxaQtmsO2a00zc9oJgXWgbokSqbiHNGgxHsobZR+PO1xM5maEsh++FRn/D/Hw6onH2WXX36nKHT03wkeLZjyFvZHdKJ6orzUqw2cVyk5jILTRd80GtEzUAldWsVxvYQkpPMRrYQ/ct9ESbPUCFZkWbTk0rV3zdEJyNVJyVGUqgnD0im+q5IaOHGPLQJHJrezJUPxCLi3bu2Z6+8u3uD7OjeyyAgkGQH4z6S+LNoZ2oj6bC/3otfR5tg46eoXnThSRFhEyLrmZK90FFBGGFhhwqTTAAVbcrOYiVQh6a652IabIqAAfc0QNHsxDhK5YQhgopXe5Kc7qEuDqy8+1kF7cIK5Dp+YB26b21K+g/0x3xqs1FLleRSfsQWLn11qkCtc+w0b9TZDuKbAWg8Jd3qGZ0SQEGg/PmyEQ32v0T6EH5tTqTNyPPX0uYYidqiwWSTiOAYqXrzvgmSOey+kaQ0E9N8FvbkcfWIgE8YHqXac78AyqmDwoKVD52SLnCigLyM4+ICiFQ+2CJK9ePbchp5RUIHUt9/zzlLxGXt3HFn93V5iyTlzk/Jv9SdRctwhIUsXlo1jd5+wN/XLt+pJk/pXVgd9V4ZMVXSUWJmwrkVACiD8du9j+H0dIEi3zsCEFouqDow6onLNTCOqYdUHLeioFP9vNFU5nWA6FyiF0FeapGrdEE+93j9F8GSVAMmGJhR5tHqJV
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(4326008)(8676002)(8936002)(70206006)(110136005)(5660300002)(316002)(54906003)(82740400003)(2906002)(40460700003)(70586007)(1076003)(356005)(36860700001)(40480700001)(83380400001)(7636003)(336012)(6666004)(26005)(2616005)(426003)(107886003)(86362001)(47076005)(36756003)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 22:13:28.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7502004d-540c-40dd-478f-08dbb95da6ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 7d132a132a29..b285a9d0a66f 100644
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
+	control = readq(base + MLXBF_GIGE_CONTROL);
+	control |= MLXBF_GIGE_CONTROL_PORT_EN;
+	writeq(control, base + MLXBF_GIGE_CONTROL);
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


