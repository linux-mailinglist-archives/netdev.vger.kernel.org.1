Return-Path: <netdev+bounces-37654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2A7B67CE
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 531191C204F5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBCB21368;
	Tue,  3 Oct 2023 11:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F7210F8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:26:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723BA7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuo/4WgFRikvRexyyFlikaRFpp+mnLUNneFXtpfx7weoPGgR/J2TrCd+y39DqQ6KuAbzTwAKjB5F9RZzYQVpxrhCjLKs1HBeB/IgDOwnykrryq1R2arszy02+aVIYAhT4iRG3j26mmWH5suwEXIhqlNg2hqZQiMXmXQaFUaRAqL2bhiAy58H76vdV6myWAD2QoRcEIR6aNtWTzjJgPjHqmrN7GkTA+0lg/BRB66jzS3t/6VWexwpVRDCDQqbz2JW7ZZdlK8ma204864/JqnqGE/jkwtozRRqRaoJQ6Gj9uztRYsTLCCFSqiQXGUWMy6cibeWJdjJ2FNCEi/cTaXvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWNMBLL4C63PG5Kf5m6oAwmoxSFxWITjxnRLI3e7Rys=;
 b=mbzzRNoAaMUDIzl6Xvy6S4ImbJUEnRU9qAnDlK+ULYB+sS8eWvn+0dDmQr2mUvb4+QsHIMR7Gg2cMxNTcQg2vFIpmSs8HAsz/du10ZYkpEkF3mRUzkBjkAH6CdkIZ1kJf7VD+B6CjTGh6JfCtPkfR1r5Z7g5xXkCnCIAn3s12lDqgJ4C59kUaYdEEk76/lkalAAXDZPoIgTFG48ngbk6GbpYQ54UnaZYotkv6VG5Mqni8tfVmr6O9Vf1j6yuLrEz/ogdX9yGs5BpL2dGxSb8+rhxeiU9Bs3NoNkHNTSmuk2ZhwW5tmYL6GB6kqeJydbF47b0gvgDeEB8AvYcS8Mrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWNMBLL4C63PG5Kf5m6oAwmoxSFxWITjxnRLI3e7Rys=;
 b=b4y06c31QRj9CwN6zAXx1tTn4n4LlB4uXpUOKKJmSZhHCXWFyBvESjOWPIwd1ag4NF/IIStRS4Q2CnKFzOv2u5Sdy3I2+34mGMjuaWpq1I64np7UwJBWXQNtHyhMokrmLYrpbimxge0FuYBBO9nIpLHfFAejMy9sczS2fDKIoB2i8FzRxWeH1QMZRcExqWQm1Uc8ssbNsfuei62t8We0pxWQ9H0I1ZEaR/JbilEmOpoPLmbkbn/1E+aHlRdvb+gCPMgnGW+jEvARM4x6K5g656B8UzAgu8o4cSmIDA9fUB2HVVtUmQeHYUHNKCv10HXWMQJnmB65gnDMxQCL+chz6Q==
Received: from SN4PR0501CA0026.namprd05.prod.outlook.com
 (2603:10b6:803:40::39) by PH0PR12MB7469.namprd12.prod.outlook.com
 (2603:10b6:510:1e9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 11:26:02 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::3a) by SN4PR0501CA0026.outlook.office365.com
 (2603:10b6:803:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Tue, 3 Oct 2023 11:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:26:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 04:25:49 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 04:25:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/5] mlxsw: Mark high entropy key blocks
Date: Tue, 3 Oct 2023 13:25:26 +0200
Message-ID: <7bd964e525278b1d0b7af0cd2edf380a71202bf9.1696330098.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696330098.git.petrm@nvidia.com>
References: <cover.1696330098.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: dad54d74-6e6d-43ee-9cc8-08dbc403867b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8+UK86JNuFc507RVdeXvAIdX6sFJChOjid8tOTaj1/Zwm/6RuelXtFCYVgk0fkIGvIxhmMv2baAkEMNKYw0JXB/1+tEbbKfx2o/ohwLkNcGCS0yUWqyrHu1KjF+PtyTZzXCFuij76QF6D/EXDhEcr3mNoIqB61AWTvFvlMrwiV95lfQAL63nFZp0lPdFH3Y2numHsuiJK9tf2s9OKYA7M8QkbcqoVbctSEjqBgjLWxREn5KUsh0l0WfWfqORbSskugR1ZgyH8PLAj6vpTPngUWKf7tDiAS05ieHWm62GL3iz8StnCt7OWU0duNhPiduRPS5OOiLAhkOSWWyoP2EhXI6bl1W7pGocGoqiZw4rq9sHOpD/hfN7E84h4bZKkvpw3WSHVD4HIGPBIkdFRYEbkcKJNQBIJXCL1wnlWxwkmXIBNqs8FHkx+5DkR3hBvUS7Nsf4NbeD9bffiRse4+IMJ7X5JnQO7f9aOcK1haalHuAjMPIE21IUlYKqpcCnFhv8De09UVvyyH7zm2igZaI/2QB+/3yd0o706Y/3IXgIs9X5KwyelFT1luEDXfJSjMY19JUSr6BhTEAzKfx0FoN9OU7GExUf4t5jXbrOSGZLL/rgs10yYPZsKJOGDCuK3XwJyXt7YBCCcIp3rTjRIkCO3Qn45Cf2xrP2HrVRXQXX5C6zzUOj9zqFg9MdMlMWU+BGIwpOygmKicHuqGmQ74gDcOXGdQUYajbSgYMZPFcXYAfCgw6B9AudVcciuHCVejpD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(316002)(110136005)(70586007)(5660300002)(70206006)(54906003)(6666004)(8936002)(4326008)(26005)(478600001)(7696005)(8676002)(16526019)(2906002)(336012)(426003)(2616005)(107886003)(47076005)(83380400001)(41300700001)(36860700001)(356005)(7636003)(82740400003)(86362001)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:26:02.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad54d74-6e6d-43ee-9cc8-08dbc403867b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

For 12 key blocks in the A-TCAM, rules are split into two records, which
constitute two lookups. The two records are linked using a
"large entry key ID".

Due to a Spectrum-4 hardware issue, KVD entries that correspond to key
blocks 0 to 5 of 12 key blocks A-TCAM entries will be placed in the same
KVD pipe if they only differ in their "large entry key ID", as it is
ignored. This results in a reduced scale. To reduce the probability of this
issue, we can place key blocks with high entropy in blocks 0 to 5. The idea
is to place blocks that are changed often in blocks 0 to 5, for
example, key blocks that match on IPv4 addresses or the LSBs of IPv6
addresses. Such placement will reduce the probability of these blocks to be
same.

Mark several blocks with 'high_entropy' flag, so later we will take into
account this flag and place them in blocks 0 to 5.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h |  9 +++++++++
 .../ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c | 12 ++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 1c76aa3ffab7..98a05598178b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -119,6 +119,7 @@ struct mlxsw_afk_block {
 	u16 encoding; /* block ID */
 	struct mlxsw_afk_element_inst *instances;
 	unsigned int instances_count;
+	bool high_entropy;
 };
 
 #define MLXSW_AFK_BLOCK(_encoding, _instances)					\
@@ -128,6 +129,14 @@ struct mlxsw_afk_block {
 		.instances_count = ARRAY_SIZE(_instances),			\
 	}
 
+#define MLXSW_AFK_BLOCK_HIGH_ENTROPY(_encoding, _instances)			\
+	{									\
+		.encoding = _encoding,						\
+		.instances = _instances,					\
+		.instances_count = ARRAY_SIZE(_instances),			\
+		.high_entropy = true,						\
+	}
+
 struct mlxsw_afk_element_usage {
 	DECLARE_BITMAP(usage, MLXSW_AFK_ELEMENT_MAX);
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index 4b3564f5fd65..eaad78605602 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -334,14 +334,14 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
 };
 
 static const struct mlxsw_afk_block mlxsw_sp4_afk_blocks[] = {
-	MLXSW_AFK_BLOCK(0x10, mlxsw_sp_afk_element_info_mac_0),
-	MLXSW_AFK_BLOCK(0x11, mlxsw_sp_afk_element_info_mac_1),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x10, mlxsw_sp_afk_element_info_mac_0),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x11, mlxsw_sp_afk_element_info_mac_1),
 	MLXSW_AFK_BLOCK(0x12, mlxsw_sp_afk_element_info_mac_2),
 	MLXSW_AFK_BLOCK(0x13, mlxsw_sp_afk_element_info_mac_3),
 	MLXSW_AFK_BLOCK(0x14, mlxsw_sp_afk_element_info_mac_4),
-	MLXSW_AFK_BLOCK(0x1A, mlxsw_sp_afk_element_info_mac_5b),
-	MLXSW_AFK_BLOCK(0x38, mlxsw_sp_afk_element_info_ipv4_0),
-	MLXSW_AFK_BLOCK(0x39, mlxsw_sp_afk_element_info_ipv4_1),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x1A, mlxsw_sp_afk_element_info_mac_5b),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x38, mlxsw_sp_afk_element_info_ipv4_0),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x39, mlxsw_sp_afk_element_info_ipv4_1),
 	MLXSW_AFK_BLOCK(0x3A, mlxsw_sp_afk_element_info_ipv4_2),
 	MLXSW_AFK_BLOCK(0x36, mlxsw_sp_afk_element_info_ipv4_5b),
 	MLXSW_AFK_BLOCK(0x40, mlxsw_sp_afk_element_info_ipv6_0),
@@ -350,7 +350,7 @@ static const struct mlxsw_afk_block mlxsw_sp4_afk_blocks[] = {
 	MLXSW_AFK_BLOCK(0x43, mlxsw_sp_afk_element_info_ipv6_3),
 	MLXSW_AFK_BLOCK(0x44, mlxsw_sp_afk_element_info_ipv6_4),
 	MLXSW_AFK_BLOCK(0x45, mlxsw_sp_afk_element_info_ipv6_5),
-	MLXSW_AFK_BLOCK(0x90, mlxsw_sp_afk_element_info_l4_0),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x90, mlxsw_sp_afk_element_info_l4_0),
 	MLXSW_AFK_BLOCK(0x92, mlxsw_sp_afk_element_info_l4_2),
 };
 
-- 
2.41.0


