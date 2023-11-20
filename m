Return-Path: <netdev+bounces-49344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE37F1C60
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AA9B21482
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646B31A6D;
	Mon, 20 Nov 2023 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWIRJeGh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F957C4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hADNlHH63Tbfb7g8dFL/OwAjxrirkkoLzbJsE+AhttFOcqB0z2LbdQzNGl6CIhHcmlSv0CfGFmUBXHp9lmjl5FNPVDjpgc+jsc+TEZab8X3XMm2tYANP8oSrAd4W3rcpBbEtnHKCmVSsC9GpRkFaCvo+X6aNe9ZKU1V5L1zhJF2rF3Qvn97jK+jLn+jVm+qK/Kfd3gDBu/0VcrF7oIMCAi2UcAs1lGgQVcpmDyZjJiZmcCf9ZTHGPvl8SUAo0d8HGo+3anRkPKOEkt5Ks4rDWpkYXhy3n8RPG1b/nbsC7acn7yMi0PAsUKk1eVG5pk8v1I9+DHPOw8iN7yg5lM3nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Txxai6xPi8zlDHPyPDjNLRnmH1ufSVHCa/85ZVk+k=;
 b=ieZZTiATFjYCPUSGOzIgjSTFtUEgMDH2F3UCnDRJ0LZORzuOdjAOMd+bdHtom/ITlC1T7L2Scw3WHNrHIid/ysCwNJOl9oX00/StSN128dpID4hyHiwheZJ8tXw9s71Zh2tjuRSLDiIEyvKDaiw7ls4wAuRgR9OELGaOmbPAWq7jFsRiuRCC8G4yYYZZ3aBFqCHYURSPdSiQheDsS4o1iac8ejiufM0pX4nWGnKXizAEVGny6WnnsRY88axfVI6etcBEOOUn9BIOYiXFaLpbn6lMsyW28D1cXjVISYbgIBmTEjzPVepw7x6sYhNBxm7y3B37nvMImkNpp5r7RJgO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5Txxai6xPi8zlDHPyPDjNLRnmH1ufSVHCa/85ZVk+k=;
 b=OWIRJeGhF/bMFKHfrYP+Ulm9R7oC9DjTYHHX6gefEwuoloBg5ADYUfzdcEqrrz7Fjmdw3xRmh/Aw8T7jkYavNc3WdedAK7Siy7cl8cEaZSmiR/poiL+rSLbp/hF3TRjNfbjW7SeCQE1JA/JyVmTTnJCYZgz5K9dlTnmLOx+mFSPiskzhynAF7KtXU0LWbOw75+rnPIywcY93fwP+LAqdVyYxCexnSXhI4wIPopzvM2AU4Y0QLgbNHoj9trv3mpzsqr2Y5EnLdUlY6VOQlLLqiJBQtE6BLi7YqbsHnelAkUBkMPiCzRag4NY1y/1f/fafCwip+cWYNk2jzfAiPHOW5w==
Received: from DM6PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:100::18)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:28:15 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::36) by DM6PR03CA0041.outlook.office365.com
 (2603:10b6:5:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:01 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/14] mlxsw: pci: Permit enabling CFF mode
Date: Mon, 20 Nov 2023 19:25:27 +0100
Message-ID: <41640a0ee58e0a9538f820f7b601a0e35f6449e4.1700503644.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c04653e-d2bb-4b74-8e01-08dbe9f67563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EYkdKFAQjvS/MVoMijzRmYvg+ZSMnGH0s29bI3g7Br5raNXDkXYX8JNtxI9DohH28ZNZTor8SZm74pGEoOEdGyksBGOlQwpmb0l6uLVw6qoUBMatr14cm2P1RIpklgYDI/n2UbX4jPbh8P4onMMHmUS0vrGhMiCS20+4rYLkcnXrUAHgNzg5z8mJRfbXrNGGy8uzxmQd4BSZl5eXS8pzhS8Cl+SK/x7Y3riezHXAYVMEFDDfCXIW2nBo7wY2Lw3KgVPUOMeWteckjv4xv61woN5Zs2eZsvMLHHWHKtPqdM09L/J+zll+pJkDOU82OhhmIrx/nY1yJFheMUPwXgZgPDx4GxwZ71BKmvs2Dpzas8y46pdzxUm8KuxMrvGd7AQG1QSx25Ca/DXnu0kZ6cV0ssx7Iiw9dU91biYUuipRf6gQjQ7Z8mao34hkoKVlDM2WcxbXn26Sy67rAOYp6CQfGO5v0JQQqRsPePg1v4jIoJAnwA3IPbB4zkcfUf30AqmwgJPi6TvUcbY/lfJ0oVlyiL4XVIDSK7jXP7zjxzwzlJR9hT9oQAisNvx9dGK1GO1B1Dk9VekwZU0Ls/ULDz59kduZisukzx+UUHz8COpVbNnlZPsg6UdB4LWOooTE29DZ4kCmF0WqHvXiAOJhGpaOg2v2xQV6infYZp3/QYLRI/QFqbcH7WdL0mwDJygMrDgKSIMhjd/RZi8zxLsuyy43OpDNFAFcpvr/J2DUBKaVmmvk3RvqraZhkCKDV95m2eJ9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(70586007)(110136005)(70206006)(54906003)(316002)(478600001)(40460700003)(6666004)(5660300002)(86362001)(41300700001)(36756003)(2906002)(8936002)(8676002)(4326008)(2616005)(107886003)(26005)(16526019)(83380400001)(7636003)(40480700001)(47076005)(36860700001)(356005)(82740400003)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:14.2179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c04653e-d2bb-4b74-8e01-08dbe9f67563
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440

There are FW versions out there that do not support CFF flood mode, and on
Spectrum-1 in particular, there is no plan to support it at all. mlxsw will
therefore have to support both controlled flood mode as well as CFF. There
are also FW versions out there that claim to support CFF flood mode, but
then reject or ignore configurations enabling the same. The driver thus has
to have a say in whether an attempt to configure CFF flood mode should even
be made, and what to use as a fallback.

Hence express the feature in terms of "does the driver prefer CFF flood
mode?", and "what flood mode the PCI module managed to configure the FW
with". This gives to the driver a chance to determine whether CFF flood
mode configuration should be attempted.

The latter bit was added in previous patches. In this patch, add the bit
that allows the driver to determine whether CFF enablement should be
attempted, and the enablement code itself.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.h | 6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index a93e9c38848a..6d11225594dd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -324,7 +324,12 @@ struct mlxsw_config_profile {
 	u16	max_regions;
 	u8	max_flood_tables;
 	u8	max_vid_flood_tables;
+
+	/* Flood mode to use if used_flood_mode. If flood_mode_prefer_cff,
+	 * the backup flood mode (if any) when CFF unsupported.
+	 */
 	u8	flood_mode;
+
 	u8	max_fid_offset_flood_tables;
 	u16	fid_offset_flood_table_size;
 	u8	max_fid_flood_tables;
@@ -340,6 +345,7 @@ struct mlxsw_config_profile {
 	u8	kvd_hash_double_parts;
 	u8	cqe_time_stamp_type;
 	bool	lag_mode_prefer_sw;
+	bool	flood_mode_prefer_cff;
 	struct mlxsw_swid_config swid_config[MLXSW_CONFIG_PROFILE_SWID_COUNT];
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 845edd43032b..0d58f13a7c7d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1248,7 +1248,14 @@ static int mlxsw_pci_config_profile(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		mlxsw_cmd_mbox_config_profile_fid_flood_table_size_set(
 			mbox, profile->fid_flood_table_size);
 	}
-	if (profile->used_flood_mode) {
+	if (profile->flood_mode_prefer_cff && mlxsw_pci->cff_support) {
+		enum mlxsw_cmd_mbox_config_profile_flood_mode flood_mode =
+			MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF;
+
+		mlxsw_cmd_mbox_config_profile_set_flood_mode_set(mbox, 1);
+		mlxsw_cmd_mbox_config_profile_flood_mode_set(mbox, flood_mode);
+		mlxsw_pci->flood_mode = flood_mode;
+	} else if (profile->used_flood_mode) {
 		mlxsw_cmd_mbox_config_profile_set_flood_mode_set(
 			mbox, 1);
 		mlxsw_cmd_mbox_config_profile_flood_mode_set(
-- 
2.41.0


