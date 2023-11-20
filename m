Return-Path: <netdev+bounces-49336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7F7F1C58
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F1CB2194E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321A30F9F;
	Mon, 20 Nov 2023 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fp11W3oW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACEB92
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0F5E/JgiV2WOLdDv5A/gf8gf/y9IyOLuxRgy0NtIfTcjMgu7D3OBttPFVS5NYuAPWkKeNA55BgjchVF0XBq4ZyLoMMr2CZILOtvXxkKUmc5Xm5AMydh0S8ca03iLoUuZGL50thlAjCKKq8VmzJ+MXyn6IjYxUrhbPMzXaiaEguse/CHGEiPSwT5nyjWHRizhp8kpYdWVD8IODugJJu3soT6re3zy+gEvgusLV9XjdJaqI7wXRfkBEm9CUlTZ96FitPx3uBAASkIS4FI7+rdHbzIaESKgNQ+NNzhTW2DKNSJ6g6zrm7sdsVjlzd3wn4wOni9uO0Zfr5byMsZzHIJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dg5MyjUXnBrdYYxG1GQi2i2EcAoSw3vIeeVC87Ydks=;
 b=MEGclEq5XtzIcNl1W6QVH35BS7XCOw9zlyDmlyLFeSvhKf/L9wSOumGMMEfCjVb0kNNH2+K2WbuHW0fDPv+pRE0fToInL3YZRoQzCj9GH1kXGtw9jndHdGcttO5QcvNqFFN26E69BgfLhKL3N4H7M1NOrSuwZAivdHNXWpPg5Tg74gEaI4+2HpyUdfYpFUvAwBxvpnG+2opE4PZvwnBDFbLYbUCwshEpcRMeqHqqLj5rhd//Rpv0oIUx4Vgi34Bi71SlYBrvHyBxGGk0qIN+It1I4ebtYPjD11eWjLsTl6qOMHdbeVosmb/I7+4lDK+KIJUzKZb5Z5geLLg+k2qc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dg5MyjUXnBrdYYxG1GQi2i2EcAoSw3vIeeVC87Ydks=;
 b=Fp11W3oWXfft/Pzti1D9O9kmvrnhVGj/RuYuTik0PY7OG9B9t2XiYCYfJc6kCFKZ75wlpNLnxy/cot6IsRnVJhuYTiHAzhgfLpTCqXz5yndXK/69ZE9DOQOzifW6EQ81rhFtfOdwtoQlq5JtOAhQn6zctm33D4wBTvMxIx1nUlIbdvNp7BW9mC9OsnwIWFJtNr7Yb/c+r58RCljKdWqDUkIKbrCP341DZJSlra3E7iNh0J8/F46XmIvg6l9qumdOEHZR9Trq4CHrjdweM57FiHNdWYIo8BpTLZnUjKJu7kTcef4bcmRDvwuoS0qtETBwUrR62epw8lLu6NGQgBZhJw==
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:27:47 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::c3) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:27:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:33 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:29 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/14] mlxsw: cmd: Add MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF
Date: Mon, 20 Nov 2023 19:25:19 +0100
Message-ID: <fc2e063742856492f8f22b0b87abf431ea6d53d0.1700503643.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dadbbd-efd5-4456-382f-08dbe9f66516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gtO/IUIbMOkSWXXk/8fpjobJdSAU2E9oeLdonp+JQIgldqEInorbagZU4Bt1xCwfF4uhz9NrTxayACPgMIMtikS9bzKET1gZae5JKFDxkdWEssfgGhiNQ4zVAWL/5YYAfK7OMhxAGtIqPBGdG49dafI+16tJcnx2BHCQ9ErtVj7fQ0J+8lN/tf+Er4kfEXFkIwm2saUOnrwHQ6Erwb6wS9rpOppU/Y+wGSS/Vfo3h5ce4RpT5OUj1iu//PLarfuIMs19kTW9W6W3OHOdf8nzodpaJ3BA0mZD+Cwc8jrdPNjzXjkG6wn+7wFHzIiKZTrPSJG5X1IddBdkvkZh7DAeetRaFxDeno89SYqgqOhIWd+gloHPuZCghhb4Pp3Mkac680v9KTExMAxhwMZzN/tOPabFhsfBrukl3kRRcJ7gm1CFwrP4mZmhtmCsXH1Ry0LcnqZaYPWBBrsoF5KSLEfQchBv1DluQPr2CLrviPlWPcDXodxpCLGwHsrUhZGXgetC3UV+MNlC6+V0q7CUwyLYpPTh+ftemoaUwa2t/pHsd301oNIdhNu+oky7J14kueumz+faLBuv1QFhr5vJrk+VOBQgIkvBqc0vFp4Yzk8l0LR7gLMsvL3VMfFDYJDN53M6GVbasIsVvxG7xE27C/npDLAKAGZTXI/NE7u+lMjtaw+Wbd6iRnoRT4NjrM2jPNF674WFUrdHMYGhoJTRgBQkKd5rGD3suYYL4VmROYj4sU1vQUkeXI/ZAKd1MrGkMPN9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(16526019)(426003)(336012)(83380400001)(36756003)(82740400003)(86362001)(47076005)(7636003)(356005)(36860700001)(70206006)(70586007)(110136005)(54906003)(316002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(2906002)(107886003)(26005)(2616005)(40480700001)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:46.8676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dadbbd-efd5-4456-382f-08dbe9f66516
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

PGT, a port-group table is an in-HW block of specialized memory that holds
sets of ports. Allocated within the PGT are series of flood tables that
describe to which ports traffic of various types (unknown UC, BC, MC)
should be flooded from which FID. The hitherto-used layout of these flood
tables is being replaced with a more flexible scheme, called compressed FID
flooding (CFF). CFF can be configured through CONFIG_PROFILE.flood_mode.

In this patch, add MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF, the value
to use to enable the CFF mode.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/cmd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/cmd.h b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
index b45c9a04fcc4..e3271c845ee6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
@@ -785,6 +785,11 @@ enum mlxsw_cmd_mbox_config_profile_flood_mode {
 	 * used.
 	 */
 	MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CONTROLLED = 4,
+	/* CFF - Compressed FID Flood (CFF) mode.
+	 * Reserved when legacy bridge model is used.
+	 * Supported only by Spectrum-2+.
+	 */
+	MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF = 5,
 };
 
 /* cmd_mbox_config_profile_flood_mode
-- 
2.41.0


