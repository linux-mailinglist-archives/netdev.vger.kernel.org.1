Return-Path: <netdev+bounces-285289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGMML/97/Gl0QgAAu9opvQ
	(envelope-from <netdev+bounces-285289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3D4E7B52
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA7B3004F2A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2F3CF689;
	Thu,  7 May 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="igdw+j9T"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E839C01D
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154492; cv=fail; b=q9iwiY5Cfi7NNCZWxONftCpBNEXiuFyNWEKF2odxKt6o7R7rinhNcA8hoEe5X/JIJfnuERdFSHpbtqujobyWwT5T48sCPw091IF7//kE8xBPo8srpR/o+jv9uAWX4WYlWBGDboUYLN+Os/FAh9l/QsUBsUvfMYNyCfz8jPNyDds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154492; c=relaxed/simple;
	bh=JrngMcReOeMDJm+1j8pVqDE5Rg7706m5JGEDSUt6BpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdEkRILuuXxksr3wBCaFdOsF/YsTNxg8TWobgDxKMIzuNCuUPJsgJ7XKCxVExRXOijMvU/QAYudO/JChl33a2V/lnqs20snoj2yB+4R0RvTq3vTZwDUtMbAPh8nXe/rEkdDSpQRFYP3+KN2sA2OXNKJiubf1Jngy9gQmtDxIP5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=igdw+j9T; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw7x/mHiWEJKZU1/ohgmwPVML1D2O84sNiT66DpXV7GYsWfknQxfYEJz0yex1F0huZZJ51LnQ4cclbN3Ommv36YvrzpL6zckPx/jFbizjcsJdlbws9MsSEWnr13TV/2VmhELPVG4UJ8cEGug9yAyzyyrMkZ/5VvIht36zOyb9PViKFOFXuAmIk8PoqXNKh3k8kXWWuQiCTGOlRFuztzfHgHms08FQWfoY8sNOGKrGQdD8dwCqyv784BrXggV7ShCBjhWBlvJnqcc11IyUFcRrUtKgIJHyeDpXdrcUlJXOaPVVGinTMzt4j0Ortq+Q4WHB2rzdOA1CHIMxzT1OW21jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9cIj7UZsR+p1SyV+UROduSAeKnVvf82KOYZLZBEoLc=;
 b=r6z7KzhJ7CoYiRjQu0jt6T/I5tEiGliXCCAy461c9ldlRpiuY/+5BDgzh09OrMkkGjJMpmhEd+1VcbZrB2+2vejRnS7uvGCLyp9YQocIEOSumSGJuiG6sbfaKhgCyGOd0j+E9RsnSfIct9ptjiE9/bOERW/JOa64TCFU+gS/J0E7gsc5LC1xJTdsGXMINClzoCu/E/OISvSR9KbskgB5TgsIw7kS7x1WSzxy/wmthPPrP8UWsSqspQ9s27deTlHFYrNzrEY39jdYRFPdlJ1aw2Dfbnn3f1tbrtEQV5TrKY+V3Yrj42REJ2bpluVho98jP990o5BLlnmHqQd2UK9SyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9cIj7UZsR+p1SyV+UROduSAeKnVvf82KOYZLZBEoLc=;
 b=igdw+j9TJOUF/Kvv0VL4LO0uz7qeeT0kBkt+rQv4rE0OvCCqj1aVAGVKm0cJfo8DTqXdb+3iXkx9h1Dtu4vCucpI2ZFTafAseoeJVhMwk3UzN9srNk/y4uEEVREDALGV9gt+pkkqac4J/5eU4sOtEnxE92YTEMKYpnsl+7X3n58BS/ue3nB4zRrf3/emp8uzwGSC9aXhIYGT4gw6j2GD45SPiyFsnLdx8tsusbmylnIKbuio7t29VBClvmf7j4N5dWQfc7C+Oy6svjRuFSXyDyqXzUWjZ/KSX9QzPyqieyes73mcQo5nzlKWTrfj4jySFk1CjBFQwhEhYG8xsgfBdA==
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:48:06 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::27) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 11:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:48:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 04:47:48 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 04:47:46 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next 2/5] sfpid: Refactor sff8079_show_all_nl() to separate page retrieval from display
Date: Thu, 7 May 2026 14:47:18 +0300
Message-ID: <20260507114721.3409128-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507114721.3409128-1-danieller@nvidia.com>
References: <20260507114721.3409128-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: b76dc38b-bbb4-4e5d-51c4-08deac2e809f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	wsuQ06FMDVrsCNzpqaBM5kqLlwg/bp7LKNDyI5KO0RuFYRCGAtJNo8sT1zwy9/PvH/67xSdITk8w3tC31FgJaYNllzux9XBB7NuSz73x7rpOdvekuS3e4zEXzIGMq1/U6KntrL0PVX3ruYrPpJBnpE981duPpX3PePKsPC87LLSbyHrIVET9FyeXGOw+teWBEtfwp+r2mXu8zubD2pFO39XekacoMmtGIza+lF08IoRSGP2LA+xVHf+VPPVi1GIAVvFSQdqdaPjwH1DyhDr/dD4+ZD0N634XxF55I0qxdIXzY5UooMkydcM9x637rmyyJLIJuO953qRY0c5u/07Wxro5p0ss2exOO7VNStsyV+tw9lqupN1s/F38bONpYhMQ2P9j2h/GC7DaCfpQpttZmW71L/DBdXHNZhnPKwQxWhtk12eSe2IyV1f7Nd83oRWyH6s8fuv314i1pLbCMpyaG1jIknYedlUc1vOpOeERB6xBu4fZqFFV0m17pKhn8tjlY52wgOtYPFvtsf2qVVicyaK+ifwQ9iyL+voAsQi0t9YdmZmwiccJOwGIevDiaM/WPPLCmM+Uu3YPtvUBV4iJ5mSUgBtNSDRc52sK5qreeLybNBBwgA/knmqyg/7XvDgC/lSK7FB+W/CFGBMnU+9BU1y8vLPv2bgtnLwW8JbrGLPlB7QmEBZkhMkqcpXCcHeHEPrEOwRQ+9tcXPTM6aDMg6ntKCDYFX+VHGGSj3uCq3s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eJATTsRvx8soHvRZzy0KiKXrh/Hbjv1a+IkznVxi1IoUav2FM3IT7nDOfhiin4Ap4KYlo9TMXXJk8vIjQz3vIlQuyMgDC7pXdVhPjQ6V7Sq75SDA5Yrx2ORWVHWfDujTKFNXUUEBiLlrz6B2tcpM06uBrOqvX05sgQ8V04HKM47HU5MFWpLsCAGhOPrzaDdqB6lyqpMGNnXGWNEZAc23ovBaW+3Dsln0tmPCh/Cso50TQLiASDUNixBK96tVkKxw6on+mq43evvVUwAskw5/BF+Sz+ZT3PEg8mqPnUqi9QxBiuUBFDCePn1HbkBxVIQfJmXavUqkC5Df93CxVxFNpa572MoN3m7xRkQn8Y8iSu1CUhzVe6IWZhl+gPoK6Hxp7UE9ZJup/iuinCizzXlxTHkFEgKcS3GE5UqxAODLeNrOPUBGlice2vNv7jn5W4oA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:48:05.7643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76dc38b-bbb4-4e5d-51c4-08deac2e809f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
X-Rspamd-Queue-Id: 56C3D4E7B52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Restructure sff8079_show_all_nl() to first retrieve all the necessary
pages (A0h and optionally A2h) and then pretty-print them, matching the
pattern already used in cmis_show_all_nl() and sff8636_show_all_nl().

This prepares for the next patch which extends the function with a hex
dump mode.

Note that if reading A2h fails, the function now returns an error
without producing partial output, matching the behavior of the other
parsers.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 sfpid.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index 228b3ee..f753917 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -500,6 +500,7 @@ static int sff8079_get_eeprom_page(struct cmd_context *ctx, u8 i2c_address,
 
 int sff8079_show_all_nl(struct cmd_context *ctx)
 {
+	bool a2h_present;
 	u8 *buf;
 	int ret;
 
@@ -516,24 +517,26 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	if (ret)
 		goto out;
 
+	/* Check if A2h page is present */
+	a2h_present = buf[92] & (1 << 6);
+
+	if (a2h_present) {
+		/* Read A2h page */
+		ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
+					      buf + ETH_MODULE_SFF_8079_LEN);
+		if (ret) {
+			fprintf(stderr, "Failed to read Page A2h\n");
+			goto out;
+		}
+	}
+
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 	sff8079_show_all_common(buf);
 
-	/* Finish if A2h page is not present */
-	if (!(buf[92] & (1 << 6)))
-		goto out_json;
-
-	/* Read A2h page */
-	ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
-				      buf + ETH_MODULE_SFF_8079_LEN);
-	if (ret) {
-		fprintf(stderr, "Failed to read Page A2h.\n");
-		goto out_json;
-	}
+	if (a2h_present)
+		sff8472_show_all(buf);
 
-	sff8472_show_all(buf);
-out_json:
 	close_json_object();
 	delete_json_obj();
 out:
-- 
2.51.0


