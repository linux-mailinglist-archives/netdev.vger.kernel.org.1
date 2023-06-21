Return-Path: <netdev+bounces-12745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F43B738C75
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05356281684
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACE19914;
	Wed, 21 Jun 2023 16:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FA18B18
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:59:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58533C7;
	Wed, 21 Jun 2023 09:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghA1ts+CodbTcpn/nzjF3a33gDJpwmmPywVy8I3s+hp+Dt0yITJAvg2TQhUV/cibEX7ugW4tn8qzVdp4kkjX3oHg7MSjqHD60R2abwcZpewgMAgeMrkEWLSBHmbIJeBDGZKhi99qYeDuyZBbZDYxqwZnD9leHqfx8DTx7+F7kU+53irAyt6otWVyF3T5n3km3PpHposHvp9IyTTGAVazOvsZefJyg2wvTTrvMkJbK5tZ9Ae72VL96YmSz18KGcg17up24I3z16Qz7tZn/4e1n8Ugrp80bCRELCVRpOiMZ2P6l47+9dLPLnMaK92HZOzBvXxX3cnlK7wlrAYcFEf5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5AAVOcVzor2yPgNtPQCu4sdFmAc2U1Zs6ETD4PG4sI=;
 b=I7/XBn0dtqQUFsGwT1j4OmpSa6QlQeihBZ6ROczs4jeHG3rsyKIVB2/PkgYH2opWtmv1VWtzZMNHKT/VHgDglzSsG0uepHgZcOD3eBCOYmWuwceXFRcxXWuPDg6CeVB5KzwscvZfRnwNSiEUVybPN62hkzLOQA+zZ0qfGKMyiUiFPpUh9DhNtiD2MR3iYVcdc/e/UZYNioEcxbxAHcQzODQ3XXBxBIpu7Fb7UFtR6qhKGIvNHaERhR68NZjIEYI2AhUudkVunAoJpdoE7+5sM9N3kPKR92MVIc73JWiW7+VIO0T61xHRdHJnWcgGcyOvaUy4Syh+jrCPMoOWcZ5iiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5AAVOcVzor2yPgNtPQCu4sdFmAc2U1Zs6ETD4PG4sI=;
 b=OwTFGOT96t4rvRuAnPaFMU5bm8rJbvc77+IhNT/XbqVDtZwcFgTq7JOZliOLOv7xrdNiWKw7yxbwJmKvCtoQCbejxDJJZ+G1Se/un9fZQTPLgbS6GIidlOaECyxxmwy64CEzxUyt7HcHiy3ee7BrRQlabSGtoOw9O6Z3buvP13Dbg0V5fCUDk880e1nY8KyZAGIuwwnEtHS9p5b1KxtpvpbTeyalI+oJoAGXM+BW0/1W3kv1+27/0sRBBzEPLdvpSA4ueCOsho/sEE1zfeKW49nfU55Av0gdYdShA0fpg/TP/bX/kXGTTIze5gQU5EvxssykZP9HUqjTmiB2ruBidQ==
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:59:14 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c0) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Wed, 21 Jun 2023 16:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 16:59:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 09:59:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 21 Jun 2023 09:59:04 -0700
Received: from buildserver-hdc-comms.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Wed, 21 Jun 2023 09:59:02 -0700
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <netdev@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, Revanth Kumar Uppala <ruppala@nvidia.com>,
	Narayan Reddy <narayanr@nvidia.com>
Subject: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Date: Wed, 21 Jun 2023 22:28:53 +0530
Message-ID: <20230621165853.52273-1-ruppala@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: bd64788a-303f-4ca9-746f-08db7278d73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E+XPkYp/xyuLjXWweHIFy/OKx6kVGfr9x26ebcO3be42OURyrtwj2u4O5IY80aeOW5v9yDB9ke1Flx7WKkAV4dE0cfvFEAEWrjD5VcKgz/DiNZrKGoZu0CNGYGGnrqzqFND3TQx85oUk5xeFrq6yxrci9/9uepomTnQWVeWEww6Khp9wlUY7yPJ814vbNe5vUOLGCCaMi603Pp+6+9N2nMw8Z3FFk2flTVTgI8buPxvxYeefAs90hWszV8oip5zStdKHDsP89extqi5FA13+12FroR5NSyxmsycT89+loAgIRkxSv4NTzZdky82RGwUsn6+4vwsC8XoupjTM4v7X7REq+yzCQeR5go/V198Z1SQevfpTkv5Pc7h+NdudRXqPkNxR2+X2O/nFhCfIPb56XFUmRehVBjiof1UrSL1e6LJKYnP4kMOi01VxnJkl44XiHOp7Z4516yq0m2GJKueu+3V74Cga4mAdREuheCW3rwSW1YA5W1ZIaLVlvufrzroV5PX8MX0vXTMAStcZtH1QtaP1JO11PYsa8+BlnPAxlMdHPJXKoxsieyVRGC45dgklhP+7pgWu8yH+PPkZuRfZ0KRx+yKMCtH01f4pzeirT2Engc2FXp076O+1D5KsjwmKf7qyYrUTxQPyn9mnjSAIW7PYUZqqkdSBmTt+t+oVrd9Kv2NSSa0HcYGd8Fx/3gxHPr5UJzYfKUm2nDarX74kJ6+j+eT0iajPIhPaHDvHfjpBL+JMUoqMe/nufQBMhkM1
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(107886003)(186003)(26005)(1076003)(2616005)(336012)(82740400003)(54906003)(426003)(82310400005)(7696005)(36756003)(2906002)(47076005)(478600001)(36860700001)(6666004)(110136005)(40480700001)(4326008)(70586007)(70206006)(40460700003)(316002)(8676002)(86362001)(8936002)(41300700001)(7636003)(5660300002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:59:13.4981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd64788a-303f-4ca9-746f-08db7278d73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add 10G and 5G speed entries for fixed PHY
framework.These are needed for the platforms which
doesn't have a PHY driver.

Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
---
 drivers/net/phy/swphy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/swphy.c b/drivers/net/phy/swphy.c
index 59f1ba4d49bc..5380f952e846 100644
--- a/drivers/net/phy/swphy.c
+++ b/drivers/net/phy/swphy.c
@@ -8,6 +8,7 @@
  *         Anton Vorontsov <avorontsov@ru.mvista.com>
  *
  * Copyright (c) 2006-2007 MontaVista Software, Inc.
+ * Copyright (c) 2023, NVIDIA CORPORATION.  All rights reserved.
  */
 #include <linux/export.h>
 #include <linux/mii.h>
@@ -29,6 +30,8 @@ enum {
 	SWMII_SPEED_10 = 0,
 	SWMII_SPEED_100,
 	SWMII_SPEED_1000,
+	SWMII_SPEED_5000,
+	SWMII_SPEED_10000,
 	SWMII_DUPLEX_HALF = 0,
 	SWMII_DUPLEX_FULL,
 };
@@ -51,6 +54,10 @@ static const struct swmii_regs speed[] = {
 		.lpagb = LPA_1000FULL | LPA_1000HALF,
 		.estat = ESTATUS_1000_TFULL | ESTATUS_1000_THALF,
 	},
+	[SWMII_SPEED_5000] = {
+	},
+	[SWMII_SPEED_10000] = {
+	},
 };
 
 static const struct swmii_regs duplex[] = {
@@ -71,6 +78,10 @@ static const struct swmii_regs duplex[] = {
 static int swphy_decode_speed(int speed)
 {
 	switch (speed) {
+	case 10000:
+		return SWMII_SPEED_10000;
+	case 5000:
+		return SWMII_SPEED_5000;
 	case 1000:
 		return SWMII_SPEED_1000;
 	case 100:
-- 
2.17.1


