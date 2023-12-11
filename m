Return-Path: <netdev+bounces-55859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FFA80C8E7
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5851E1F20FA1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03038F9A;
	Mon, 11 Dec 2023 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mj3kZ5yE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D44D1BD2
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnkMaC9AwITSgb3rdJcSd3q8uKzlK8aFH8kxqTxQoXi44Le6ZTRjntzcN6x9C+OVT4oqRdVcxK0n7vWKRRB0/Iw1UGxABzdfQLTwXm01jUQtkgbm7czE9EelFVuNeAD1dNSQSUgHzZeM/DIGbivsEJ48Ia2dZsr4HRZXQTKVQQworviPPp0R3T/ymigFcCK3gMeoWoJ9/T51R5g381CZFOvnLEosw3K4C5GcpD+MDV5PIKlo4woFW4sjgpKqCJ/C3O+StItFU9msehLRbp1XWNBudTxEVgR+F+cpuJmGIT6QV2BLtV5nIJvLU6LkRovkdzXizuNNA42Hy7Ve0AQZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYNT3H4jgZO9Ik1XXrR4ez8Kub1YqLgOzAy4bARSXhI=;
 b=jvrvEvuMY5DwE2C6GVhBM05YsGvbrNrl93kbwOBJ0arnuigXS+bf+he79VZ5BI8GLUL8WsV8Fy3rTq20IM66Iv2g1iQBmAhqxDRgFuM3BjkMws1pMSXUUpiq2U38txVPN9flGwyc/QMBdR5XfNXCtzbACsMGC+3gFN9NCNAlCdLZSPzPKiEsW9rngeI58xYN0Lt+7rbbqkuiJ0HtzLuprAR2T0qk6IZDrH1BhskdS9JKEmFdpeO4b0tp0Mmt5W7dG9xEVA3SFIfKQVedGWhzEVa62JXBB27Hv16qGwqnrGZjt5WUZ/5tMKP3xLCLNT5fAEIVA2UuBoy4ZYER4VxVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYNT3H4jgZO9Ik1XXrR4ez8Kub1YqLgOzAy4bARSXhI=;
 b=mj3kZ5yECTnFYVHeKjtSi7h/GdDbT7SXJcMPZyvW7trLEZRHlBqHpOz+J3WKajgDb1V6xQPHr/Tlp2SQghjx3zQZCUXPuNHoDv/TNxndvxW3sp0t4cfn9Aj/JLy2aJb+W7pKUnEhg5Zph1w3R5YUs/OqrW95FVTtkuqKBjktqku15hjQTQ4RrW2eEvXqlVc2GyYPSiF4tV9yd/wXbrcGz5PrIMVcehoa2Us0gA7qVovj2pGH2cyiPgCqleBchxeYTsI7Wmbm+Sf7UFkrFQ688vh9Gfl7Tk9JIRtPStRVjZGC7jnYb98EuFep65euve5vBm7JranCPPK8MjfqCsuqEw==
Received: from PR0P264CA0136.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::28)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:02:28 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10a6:100:1a:cafe::40) by PR0P264CA0136.outlook.office365.com
 (2603:10a6:100:1a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:02:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:02:10 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:02:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: forwarding: Import top-level lib.sh through $lib_dir
Date: Mon, 11 Dec 2023 13:01:06 +0100
Message-ID: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: a829711b-df3d-4cfd-ddd8-08dbfa410af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	atxtVu1xvSiCer7xRdhSGowNBaS+4AEMrNVN9OlfUmpVTINfqsj3oZCxMIo91GH79qaaAzwozFzyAy1b1t96wew/wh4KT3xKMwWzXs4AEs7UqSQc2+HVoi1xJ9ZrnRmz5B35w9AWgAMJ2o8MhZQU8vNw0NJmwP+EWixHPlaJHvd7OHZVviBoJe0A2UE5EibL3TA1KsF8O2sfUN5o5HuKAzF6ZsEfA2yL3th6dtlyQBlFLbMO2lV9Ak/X44p/vEvHcM88eO45XdgB1iMP5GwsSo85s4xrLaZdkbI+NbsvqOSoUtHsff8UbSZO/DEuc0sMxFs2Gtwpx9zASRRMWD86kQmsZDoEWsfplLpRl+VHMXF+vL6rBxyv3hLHfa+nOVq104bLDrqxbAqTSsCCCggPfj+Do6wzAY2fRSEVeyC6XG4FMcKC8cg0aCv8WjvnVhUFJl8TfVJUfzHDyQA7R0FptOR8uMP1BbfDzE6CS5TE9q683X0Bx4AUQ9MNP3QGEDl6CP77+uJG3dtuA5TLzynYTQKGcr8+yiYM5SYrVJho0E1skyphFgcKTpnfoT/X3t7n6DjtlrbknAm1Q1aWvhq7bEZoDyYMemodylxA426LZl9rdb82AXMU2hoQgBLN+/5ONEFMSEg3OIvzD+atVMCpCvK8wWR4YD6lS/jNDvcz4bYFVY5JTuG/9KgBS08/Zt5b5ZYCKEY7WWCiJCeYWexfW/pjRJJ9+3QeyUAwRXDe7xlWX+2c1HU4pKJjmJiD9yrq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(83380400001)(2906002)(82740400003)(41300700001)(478600001)(356005)(7636003)(70206006)(70586007)(54906003)(426003)(40480700001)(110136005)(316002)(86362001)(4326008)(8936002)(8676002)(40460700003)(36756003)(47076005)(5660300002)(36860700001)(336012)(26005)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:02:26.5092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a829711b-df3d-4cfd-ddd8-08dbfa410af1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

The commit cited below moved code from net/forwarding/lib.sh to net/lib.sh,
and had the former source the latter. This causes issues with selftests
from directories other than net/forwarding/, in particular drivers/net/...
For those files, the line "source ../lib.sh" would look for lib.sh in the
directory above the script file's one, which is incorrect. The way these
selftests source net/forwarding/lib.sh is like this:

	lib_dir=$(dirname $0)/../../../net/forwarding
	source $lib_dir/lib.sh

Reuse the variable lib_dir, if set, in net/forwarding/lib.sh to source
net/lib.sh as well.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Cc: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 038b7d956722..0feb4e400110 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
-source ../lib.sh
+source ${lib_dir-.}/../lib.sh
 ##############################################################################
 # Sanity checks
 
-- 
2.41.0


