Return-Path: <netdev+bounces-49342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC07F1C5E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781BC1C21826
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8590315A1;
	Mon, 20 Nov 2023 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZGlRzZM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E2CD
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpd/USGO7Z2K3bLooY3h/tEJwOHUoNPgQbtmVEPCucdw258pTuMrqiXUoGx1Qu9wyWX+u1nn70aYzIKsic+UjSXZyYdgtvO4j3QEJ6lIp0KLKAUJrvCYGZOQVWKufbxlWDnUrd8pASKc0TPmi1rnslN6FdH/iHErvSSIC2QT2aTHeuAErL1sQHU8Y4khu0RMlyWdWVmPFBtXUXuzuXE7jc5M9OtJVOwI2Nkav4c0DyF5zHF6JYruN8IqpX+57/v0sL4/hhEePQG6N0+FF2gS0DiicFv7TyAsav1R/iw6VCwZbgAjXUmT5oBmH19KbshTHlKQIhhB6rPyZqxgdnwSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boZxz/xjX7Ezdu7RPsHPP9FwafHiFxZeETALMJc+1m4=;
 b=lo2nAHY5FbAF0Q3o5OFfMVbt6V3gn/x/YXmHZzYZC0DkHwv9rCGMdezBt5r/R5UsXQxojs5qLLPZDasbLyK3t0pZvqjhhARaWFJADRgEy3SncygDv6WDeEVR1vSg0U3orPvUba7AH4GupnsTExCBhXH+jTeViGwO60TEatefbMZxGLisEGBI3D1woBN9zg9abgIUC0GRnzo+VjjyB156g/DpvGDLEVEKxpZALKfIGxYYKkiQKKJT2vEJmgbEfGec/rttEKrK/CMS2b8j/vcILYCUeAysYXwDkHCFHvst5xn9F6Vu9bb92zRYOIbUEbtdKV/JsEYMRG2RgbHEEkNKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boZxz/xjX7Ezdu7RPsHPP9FwafHiFxZeETALMJc+1m4=;
 b=sZGlRzZMCdPDVVKfnJsHyyUt/J0wECPlauN9bMFWRQ+wV6fRHnrNwZYpsTI/vv8B+U4W5qEtlF7RLu8Vuy6L16l1HhKsy3P4FnPKh1Lsgcd1spzxABtKMwjjteNkHwFk9j7KdbidwKtfrK/YMsulXkBFuR0VaexraA680+0lvFjo7gu6Bp/bgSrhvXlvgdjT9ygE54hSeGHCS0bFwd3GivpMSITJIwomakvCrLKUbICDQJHqT31Y7kvGmsihiDhhuIyfSixWRgRvZKCTRv3YPs1u7Nkp8gUAzYdtuj21Ks/M3ZPzDFVilPCIimYAVq6PCblBWIsUdTQfWhf5u4k0fg==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:28:07 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::88) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:54 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:50 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/14] mlxsw: reg: Add to SFMR register the fields related to CFF flood mode
Date: Mon, 20 Nov 2023 19:25:25 +0100
Message-ID: <3ad7ae38cf6534bedcd876f16090d109a814b3e3.1700503644.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: d570390e-8b31-40ed-81d0-08dbe9f670ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GCLgfDHl6iT2yJwFAFdZ4U5nPNyZy1RcQPfaD0JHR+fkYPI3ewSeSepYRiOHy0EmnB6+6Vq4mWZbJA2VmKKGDqBXqMFvvKb0UqglwU3EzjSf2XsoZgdWSqWZ4AKJM/3AQpF/WcGnMsOaGLpJSjmQEqTcwrer2o8ArCtSZbUJlhBUUh5gWtb2qsyS36NrGFQdSfFzKeDH1Qvf/7MKlkcc1ukBSY1WaTJUE3pMDkubHPEn2w0GcgCIu4AK/5Kg5cS8wUwbp6FKStHFLSk/lpRJet9RYUs2rvEmIcIWIzkM/xyySZNLJ3zbEc7mc4GlnldW7B/tPKWHCZCr62F0M2FV3gEULFwJzNu8wssYmzu41dHzcFPSHnibSIPW+2+5u1UjD6i5LqdxwzExip3eTyd6pv9tsFY7VolMQHGc3EyLMVhhznNWXw+pkCqnq3hkjwWL1yDXzHHOibgnWqWIs7kA4EF6MTYRhv+sqPDeYxBF5XgmDMsQweuOW60l+gJbB72xYMhg4tus2FtrV8BGPqNlhufvL5a5e113B6+rqap2lWNRZuU+Y7G4pL2VZ3yFyolIcdjdeJLqW854jHl4euo4HxQRjkbqFxO1Fie+wJ3xibfdrrkhpZAqONCgEZg6iNuUEp2Ds7ltI3isaQpAg9qUhkZl+IGjeKXqLPEdyJPDjQGZsn+C9jpQtsPe6p+ZDkdrKLQkWwHW7xA5fCXgrHeTs81ym+94vK6nZ8WpNYpX7Rs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(36756003)(86362001)(5660300002)(2906002)(40460700003)(40480700001)(36860700001)(478600001)(6666004)(83380400001)(47076005)(7636003)(356005)(107886003)(8676002)(26005)(8936002)(4326008)(316002)(16526019)(82740400003)(110136005)(54906003)(70206006)(70586007)(336012)(2616005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:06.7269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d570390e-8b31-40ed-81d0-08dbe9f670ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219

Add the field cff_mid_base, which specifies at which point in PGT the
per-FID flood table is stored. Add cff_prf_id, the profile ID, which
determines on which row of the flood table a flood vector can be found for
a given traffic type.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index bd709f7fcae1..3aae4467e431 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -1944,6 +1944,26 @@ MLXSW_ITEM32(reg, sfmr, irif_v, 0x14, 24, 1);
  */
 MLXSW_ITEM32(reg, sfmr, irif, 0x14, 0, 16);
 
+/* reg_sfmr_cff_mid_base
+ * Pointer to PGT table.
+ * Range: 0..(cap_max_pgt-1)
+ * Access: RW
+ *
+ * Note: Reserved when SwitchX/-2 and Spectrum-1.
+ * Supported when CONFIG_PROFILE.flood_mode = CFF.
+ */
+MLXSW_ITEM32(reg, sfmr, cff_mid_base, 0x20, 0, 16);
+
+/* reg_sfmr_cff_prf_id
+ * Compressed Fid Flooding profile_id
+ * Range 0..(max_cap_nve_flood_prf-1)
+ * Access: RW
+ *
+ * Note: Reserved when SwitchX/-2 and Spectrum-1
+ * Supported only when CONFIG_PROFLE.flood_mode = CFF.
+ */
+MLXSW_ITEM32(reg, sfmr, cff_prf_id, 0x24, 0, 2);
+
 /* reg_sfmr_smpe_valid
  * SMPE is valid.
  * Access: RW
-- 
2.41.0


