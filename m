Return-Path: <netdev+bounces-50481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115797F5EB3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C5E1C20ED5
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7BC241ED;
	Thu, 23 Nov 2023 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKUJ+kZr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B1110
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 04:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V32f/hQY/P6oWPi27V+yJBdKPjL2BGLm4d7bxBqtpvVx3g7eMX6t6GW/xrlLlmqRom0LHsHz/oZGjECqyFkOLAwsxKr20w3+4xBWubXE6g+gVGMFZ8aiLhjeWH3aew5i8TShIHJr/dBwiSzm9tNRwP4ceH8pblPV7SJ/Tli2L9cu7JY7fu+xg8i5beyTFvFd6hh721X1sKSbJwY1VxixgNPKt7RSwhGd7scbKUPP8PNGJxWcZCz6pcHnHlEOL38w+/c7Oc/CSgUXdBIsbVR4GZBWhxUSeMRUjcYcCfCjRadQdGz1hGTbauM5d8r1ctfjF7OgkLe2pBC/ewcY3I/mAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ/zs9ugS/y0mGEA8gPQ6LnD2GZGRRI7j/Auf2UHoWc=;
 b=QjwF0tZLXixSqeFhUJfPpT1dTH0XY4BoGq+jwqtGawBVzw6pyk8lZFrRDMIfwdg+CaIP5/t4i/FegaYw4H8EFd3hQBpSMGzvMWNbnJW2CD8Pt152godzjYJmRazBIYzHCZ4HH+9+xgdGRzEWxHfzQ9pK5pHpRWsuTTTNHkfRTnDUrPg622eBgVawUksk6vVnAxC62DCSjD/BMJv60VdRgRrrA85ADzzvMN75mjO7ZPxNDQCt8IJqTO3IbqNoi+FcoEh3AiqL2VuCf6VAK0bpk9+y0caug7ZTeD7hypOY725mlXEKX1Rog7xgMuRpCEJPOD4pdM6RzsfKAXUtIhFsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ/zs9ugS/y0mGEA8gPQ6LnD2GZGRRI7j/Auf2UHoWc=;
 b=DKUJ+kZrYUCYo6F1cL4I6M7euevT+xedTIxaVg8APLZHgF4Ejc5utgqtRipC30lYgiZe2AMgO1Fb0vXQOquDujfs2vdmMeUXrte767ttP1YouX7RjG9LhEwLD7YMqRfT90wKTTSWRZ3nB2lV3W+LRhmcxvlw9Du5I60vvX38DW9K2Rs9unwPd/u58DFxBXmvduZcgnu+75/O6VaMBaMZ0Dmqmedx3szhpFXrcd81M2rw4EWLBA48NJjv3gKLUcgtMU2PrPRdXs9bPjZC9Qvc07Xl5XboPwBhBb8nGsARHgHB8pdo35Te5H8mkj/CSqyjYqvJ7eG2CXKrQdGeHj9dXQ==
Received: from MW4PR04CA0242.namprd04.prod.outlook.com (2603:10b6:303:88::7)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 12:05:04 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::3f) by MW4PR04CA0242.outlook.office365.com
 (2603:10b6:303:88::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 12:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 12:05:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Nov
 2023 04:04:46 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Nov
 2023 04:04:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, <mlxsw@nvidia.com>, Coverity Scan
	<scan-admin@coverity.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next] mlxsw: pci: Fix missing error checking
Date: Thu, 23 Nov 2023 13:01:35 +0100
Message-ID: <b5a455a64f774adc18dfe2eec7a54413e0cfb2e2.1700740705.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcf4d84-e931-4c42-b6dd-08dbec1c6c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3fhpoGfc9xJo/O1GBtsjj8VhNGBD3gZTG7PMtqHrB8DvxZNrbWeAd2Wv0+WTJBSV0Kf2S0zKHa8xDpe/SR0D3Mgqj1re8EFowdpOJ9BXVDLZxhEZAMe/PoDSTqYpXdq4zZgox0qZ4FueuUnqn4bnN5C627lcbGQu1ub47p8lTzeJMEtzbBBeOJl+bzHXmpj8uDRswUySsQFWvoZg/ZZrDm9F8CBTjMrXyHeVcbmvEp0eBJ5+liSa3eliluVAa0QjIsYwzFKLIhhoeInX1XPaIjHkkY5qPaMjQr6dxPIz1PvBN4clkWFC1mfzA1MhIR07umlHb1Epw1JmpqJm1gVlePv7tL7iI7+GjENHeWEY+R58OnRWMqQoXg9Z0/0tGdUiELpZu7QMTZ5IDuJaGhhWsw0MZCYWRfPtrlKvdxglaPx7ubGgDBMz1hnskvmtFf2VT+at/Q67LA/nbWSr6WZf2cv2PLvtO3VPKigV2109gzsVgypLKddgwmZ2XWXyhutCrvNj0e22TdXBrRehwruNkefGsGlvD6cTYWcl8Sd42Icr25qW+vzhK97gXhYzapt4bJ1PD+Kl6j4M1JpGzOBNvpwSdBpI3PigYgv16P9VrN7yJWHxl4LaAANLb4o6n64CryHmrgNsbDTRHna3pbJPWZNbo8X4H7nCLTz50WKxRbtrGZytWH0ppq3d8gdG0qL6O1DBD9t0U+Nxjcn3A0AtqVBp/pqTG68lSrDCUhfcF0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70586007)(54906003)(110136005)(70206006)(82740400003)(36756003)(7636003)(356005)(86362001)(6666004)(36860700001)(478600001)(426003)(16526019)(107886003)(83380400001)(336012)(2616005)(5660300002)(4744005)(2906002)(316002)(47076005)(8936002)(41300700001)(4326008)(26005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:05:02.1045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcf4d84-e931-4c42-b6dd-08dbec1c6c42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

From: Ido Schimmel <idosch@nvidia.com>

I accidentally removed the error checking after issuing the reset.
Restore it.

Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0d58f13a7c7d..af99bf17eb36 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1561,6 +1561,8 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		pci_dbg(pdev, "Starting software reset flow\n");
 		err = mlxsw_pci_reset_sw(mlxsw_pci);
 	}
+	if (err)
+		return err;
 
 	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, id, &sys_status);
 	if (err) {
-- 
2.41.0


