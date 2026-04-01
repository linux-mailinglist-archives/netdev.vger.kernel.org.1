Return-Path: <netdev+bounces-274028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFKbKfn0zGkFYgYAu9opvQ
	(envelope-from <netdev+bounces-274028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2FB37898A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EF9D30DE659
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C603E51DB;
	Wed,  1 Apr 2026 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWZnzfGX"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0421D3D2;
	Wed,  1 Apr 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039402; cv=fail; b=oIcGIGVZyr46f4PSNbimJhomEHLWGQQDzjHnpHIH6UOy6SWA83rTg8CvwJ8Z7vuczdc+TbyM84kZa3/C5YLrMkhvGm0F/6Bpk8f5mUBP26RipHHOAji5gErrYeJHuuHt+bbQvVKZy8kaAKyl1Oi6EC1fB7fbtkGd08rUMBOZAoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039402; c=relaxed/simple;
	bh=PwCYgnz3FiN4gZh/TIQhg8qHBdvgukDKR863bC+Qt28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W01JrIY+DfL263gugHXbUg4e6DHY3g5nn9W6+2vXtN6/N3c4xfg5f4AMRHBwg0UbbzhRj7L4ka/qrNIlZHdvLVTJ9wd9tks6DxAQ42PTVarXUU+FUhZngGVUDY8l8MbZCtdNNjlOBBEHcCl3Ws3ZcEik+pEsHHNtKKwvZ9yxz44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWZnzfGX; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5a9LNfKGnroAk2k86yFu9cfHI6H+UX6eU7jEOGrxnB7qPUfHSjVJa61cBbEOnW/Fe2PSjJXs8LLl2HhN0QBn3GJSL2V+YVjq/l9W7lUCLimBWTeb9PTIkdut1xUkW/o7p9DEeeYfBgtTlwpqvaH7+6+DWvg9hh+/l2kPjnNL59yykDqUhh6KuYkB3SemDzTu1G/jzXkFvC0fAe/TaxaVeDo39xRUcgG4FmBV9+iKnbnpwkc6RgO6o7PdWAnAe2Cl+c9ioRIbRzNfZECzCEyUKUCNbKELzmtwY6FIWHAHShhpW7upQUg1jvTl7JE5R9XGts51iHc27VsIIDm4t2FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKOL05Ic6LmKCZffYWiMvKk9yL5oiSo54tybJmknTQE=;
 b=MWrj7KJ/pUGdZSr1tSxVMDbGgclSq92/V/Rp732+ucxjG8OSuMucH0wZV5QgDO1cmG6NF9ISWt5qtzoRsmxWNofF3N05fgeJVtDU0tZdZ495/JEWvGWDPqqkUmuXSu1IU4StfWgEaGTCdKiXcDdBEbHU7xyMtmDjWRtQgbSVi+ueY0FInICtvcF68gAUryGO9dYETDWZfA+/0H0lFZRicNyu3pvRkrIx7L9jbxFiNr2SfEvLf/2xHhDFP7D4q6FizyUX/aRTy7Wzg4YK78ig4QfUQw/CTnmTFQmx2cV8IhmQpQ6nEWpuPGRM95V9lEMElU2haSRo3Wf7G0KflWe1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKOL05Ic6LmKCZffYWiMvKk9yL5oiSo54tybJmknTQE=;
 b=BWZnzfGXvbuetTygfQ+agFzLXmYrXDEI7jROjCqCE7RbVYIo/g6XsKfpBNp+2tPoxQKyCXXhtBdxe1FbkIX4fVWSkYPSSUf9b/fjpTQoiRusatqWr8PNCPBaxDuJEmXN5oSi3wB7y/h8rSvUlOkhkf3ZQiVahUKTRzWmFtFKNqTk9KNpR+uPlnS3aqYXyN0INgxzRm7tRmNbmntQvxq6XCM7FKZ/jHcFBf1WBj8paf2fZv/jsPMslpLZuqGuHzqvRWI4fVvjWmXQjI1NmyZR1sCIFT2p9I8reGTxvbhVbwd1YtN9ftu5cBqgCSMeUU5o2w33lilhbElDMyJp2efMdA==
Received: from IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::13)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:29:55 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::a7) by IA4P221CA0010.outlook.office365.com
 (2603:10b6:208:559::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 10:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:29:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 03:29:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 03:29:52 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 03:29:50 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 1/3] net: stmmac: Fix PTP ref clock for Tegra234
Date: Wed, 1 Apr 2026 11:29:39 +0100
Message-ID: <20260401102941.17466-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401102941.17466-1-jonathanh@nvidia.com>
References: <20260401102941.17466-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a7c11c-a1b9-4f15-af98-08de8fd99d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xvj0JS/WIezLNJgnWgvSJOsZy6480r4Id2r0rCr2sWnMwUgVBxM8zcEpCJwE4w5UA4mz15a9zgZF00iZE95o8bxyiwOaytg6eQrC0qw9KZOv9q8WWh7CVgmj2a8aRei/owITJv3bJIDualEu66OpfZhNzzxlKKd2jT8BsKJT2/47ingYridDAp55BA65Bkz4ztE3AJ1NGIiEx8e3icv7OrO5zU1ha0IZf5GjvHM8OdsxXdPmtvZnnFbRADKe3No+GQjHBfxxsQR+oecYDoK9dFodE/9S9KcPENMZbEpW8GGuzytay8PvrWNkW/34OuecaWqv7KzEuw9QZKEsiB/qlk6kC3Q8i8nZHiAo9kkSxtsKwNcXLRq3Jw1JXsE/F10naESZUa6Yc5/4SYzWe1ePMrQBBcT3f3dlnUyoKzk5e7sL5b5uLGUFqV06wgo/WxiWKLSVelrrkiS2GioAJVEo613zzRowgAaWE0fbFizJyKRBNjplLurEyGRN8OPpyHq0VG+oEn43kFe6Qk5rICB+0AE2MU6psTFS72Kc1wnkvPb5o0VF/ZZxVyHDgLEDmjpPYWdsuephR7WLUUsORofM9u3DaLPQTWKbx9o2TA0XhQdHcTBX0JNvJOtuv5XuP6eV8+afAg8OKmjIvaKJCImTpMb9zd+zBYsNyqJ05CkVJXZJ33A8rMu2fOqogLfXoyg7fT68yLl1a2zYWp/aLQn5kzVuS8conzgqgVW0xOgBcVcSnEDki74repJUk+BucyaWl0VkKPo+JgthvXN1ypEEpw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Yau2fZfhBHwEtFoOD47bGGP5Q1xkZaGNRepGgk5gzSTubVLFwRGtH4GHVtAzAKFgourvbewEUtbAlM0Kv4iv4w1685gVFDt4UukO4QHgBafSP7lRzTLjUOepdg37Al2WZebiF8bjkjWx5lXCXurCxaPI34C80AFx/0ZyUhmqFd9T4HpY3etTAWelu1k6XFuO+TvpxHvhqdF6USTrIAg9ynn1TyoIwIHXSdC3nx4pajGSx+Iyp6HCqHmnrHG74Ij3QGNM+VgoxgUreT0FUrlm/BlrWHDgzCeJghgO3r8dri3I8Pc4xisWd/rkWtf2tlN4bYzfBaLXwet7/mi9qkJfOBih1L7EDE+zeVuoubQx9APPK1euP0pMvJsi1L0ECj69fgFr2vulgFESZg5OhGFs6XCnqmIO3Bu/+MV840OdEpc+szOrDrNDhI3iAVRbIaV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:29:54.2808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a7c11c-a1b9-4f15-af98-08de8fd99d68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274028-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4D2FB37898A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
0 before configuring timestamping") was added the following error is
observed on Tegra234:

 ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
 WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed

It turns out that the Tegra234 device-tree binding defines the PTP ref
clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
exposes this and that the PTP clock is not configured correctly.

In order to update device-tree to use the correct 'ptp_ref' name, update
the Tegra MGBE driver to use 'ptp_ref' by default and fallback to using
'ptp-ref' if this clock name is present.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index b4b39e6a169e..3af2f001fada 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -9,7 +9,7 @@
 #include "stmmac_platform.h"
 
 static const char *const mgbe_clks[] = {
-	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp-ref", "mac"
+	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp_ref", "mac"
 };
 
 struct tegra_mgbe {
@@ -216,6 +216,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_resources res;
 	struct tegra_mgbe *mgbe;
+	bool use_legacy_ptp = false;
 	int irq, err, i;
 	u32 value;
 
@@ -257,9 +258,24 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (!mgbe->clks)
 		return -ENOMEM;
 
-	for (i = 0; i <  ARRAY_SIZE(mgbe_clks); i++)
+	/*
+	 * Older device-trees use 'ptp-ref' rather than 'ptp_ref'.
+	 * Fall back when the legacy name is present.
+	 */
+	if (of_property_match_string(pdev->dev.of_node, "clock-names",
+				     "ptp-ref") >= 0)
+		use_legacy_ptp = true;
+
+	for (i = 0; i < ARRAY_SIZE(mgbe_clks); i++) {
 		mgbe->clks[i].id = mgbe_clks[i];
 
+		if (use_legacy_ptp && !strcmp(mgbe_clks[i], "ptp_ref")) {
+			dev_warn(mgbe->dev,
+				 "Device-tree update needed for PTP clock!\n");
+			mgbe->clks[i].id = "ptp-ref";
+		}
+	}
+
 	err = devm_clk_bulk_get(mgbe->dev, ARRAY_SIZE(mgbe_clks), mgbe->clks);
 	if (err < 0)
 		return err;
-- 
2.43.0


