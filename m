Return-Path: <netdev+bounces-296761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hHW4KMpFJ2rauAIAu9opvQ
	(envelope-from <netdev+bounces-296761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:44:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68E65B0BE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:44:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=k75hsQy7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296761-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296761-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F23713057211
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA03B995D;
	Mon,  8 Jun 2026 22:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4803B42ED;
	Mon,  8 Jun 2026 22:41:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958465; cv=fail; b=jzEglbO7hHdCXP1KSGTrXd1D6h/E8P4QkzfpXjAO7Ep0LmJ1coSRGn/uC4a+eFpK/YTLaecskSwolif5Eadv60h+COEiFlXjh/06lzYNOaCv75O8mJMxmf4P3OxV+vXRJPdzDf1600vIono0+SVQk940B/Bc7HDKrOa1UVR0ffY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958465; c=relaxed/simple;
	bh=w2I1molMWkbcjeidl2UxxQD8MD1gWw2ZcgNNdF4jlKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZy5PwHdTPir+eKP0s6In0IUFYa6UaXTM5PLbk5E6YeZ2A9tR5AGN6AsKuUBu5vRG9u/ThRNt61g9UmmXFxF0HXhpw6B6aUCbdXkhG1fLdOl3wgbi2I/U09UBbK4aXx3uOoXK16FICsSm44pzGaztz4aF9MJ2yEdKfzGkd611zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k75hsQy7; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJQ559CR5+TFxKOPK+tlplAzRjIE+0PiSIcfBxgMkLCp03zC9x5LzLOnrpzC6ilrBH1Ab/Y6LAqxKReCi/nOSXZyT5ANynp1h3GzR6iKL67sgMFlxX+MsiFiS/4H7geugTJHZUCmBLhtd5kwt36pDG071s+ojSBtTL7eCjvsKh2B/3IxXssY6K+FK64b9igxEv8LFIVoXSFyMVp+iSsJn4HWyxViLIHAf19aHXb335gBbv0yopbBBANd8OuFrlEOdpCGasRAwG+OG6Lp6F+IxTM2R3i9JmeosoqvmZGR32UuqHSiw8DZbThSnzfD4UxiyIfT3+gr7X5ZP8qBNCOZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=b95UGasLlt6NMwZx/e7iK/u1ms9M7mTO+b5B2iAboFFeZlXflpeNzM1Q041W8auNojYfh2R8RAazWyKsufJCFyTPk6gcKGl8302RdZQyQL8yt/4FA84AqeXVapnn6pfhmFCGvxjBoTwimmREEx4LKMBjK6WP+xg07eT8XQQlbdaI/iE9Jsr2LAZ7hqKKUi572WnBD5WDitajYj3/9GGQ2AoUlJrWMWE6fGmqTzrh/4UdlrQQcxQDjFD0knWJdX74TRIkT5z+6zzANmQwociX0rnXBC/biCIe6LG9YJtSgy15mdsezE5Lw7LH5qMWseBShG0tVpfug90Bypz1rjMhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=k75hsQy7jCWt6rpMXTdLCAtisfufe7icqhzfGVB/PVHq86y3K4fsqLGYoF6M7CxRWGftd/FRifC6tHa6Q7n+hX5b4CsdIgZqPLqBoaDcVFT3+QxjO4MWy+5kzT2SvOpLx5iEtTP1kdpsBPX+ngWlVG3OLSaA8aVUc4AWKwvAqqg=
Received: from BLAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:32b::21)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 22:40:59 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::19) by BLAPR03CA0016.outlook.office365.com
 (2603:10b6:208:32b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 22:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:40:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:40:54 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:33:12 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH v3 2/6] pds_core: add support for identity version 2
Date: Mon, 8 Jun 2026 22:32:52 +0000
Message-ID: <20260608223256.12357-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608223256.12357-1-nikhil.rao@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0166779c-a1de-4f1b-8d6a-08dec5af033a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a8peWQSxq1e4OHpN+3Kew3xJvP6uzeQh74DPyGOyX0PYJfs2nnj7F6dS1mmoowB56be5w4FTmOLMfdOj9pRQA27PrMcQ+389AZ0Z2ctIWZxHkrAk7cELmoA1Z3ItTsXQBBflQ74VnWai/A5bQa1/SD9VA6CbhFJI8aTkelpRvX3o3GflmlJLbj2W4fCDY0ThNj197RskMyTySlZyV9DYe3s5PX0qi5hs/V703BkIumUO5V6RliKpgKZ70H5AWLnzZaML6/Nimg47TNe4m03lg1Z+tLtnStgjIBarkTiyULYsQ4bCbLyqSYfhKVsOJNAyGimqiUqVnMxniq8Roc1lz5cKrTUF4AvWawa/LuEQOaEYOWW2yhBdLsqUX+09zknsNvDLDZtuW7cXqvxp/hr7QfZhA6s9sZBuXb0iPOVePJkbWgwIaAtq3hiRadwwW4fpkJ1cGF2uspYry7PoISBXTVVdjTufz+Nv2z613f17UT9Gm00F+tpiBFPhmsBFjvspuUq7EK3LQEiLhjzsZzP/YXG3k3DV/rT2QkHskMy2UnMpOlbir3d0Fo8eq0F+OoGlLep7wd5t7rBx2LEowYFUPtX10BBCl3EXnDwIG4GQjPeQ0kK3B6LqKAQfk5kLsdKWahvz6rmLiy3icJD5RSEy11V0oUt0sCCULOfWD7o9TRNOxQEzkYsaG7kbiYmgtHX8EKCS3vLc3ywsO80Rt0k0m+WkUV7E9/Qe8Ltg4dFnqTY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L86MTEY1YgJa1uisv44TqieRL3XCGGeVlE62CXKlIxc+yecXCBy6dsypps30l7+EbBAM60vjrFdOpeHVOkTlc7Djk1z2ubsMEcZ/iJMpQkLBlUpWt06kpe0DMHjnHpgxJT38cXV/pNQyibnJ/tVcZuhYM3QFWTxai113Fc2hOcEdMnA6b/M5N2tqRvmBElzW9OLn4c55H7VXZBa4Yxzxq/QQ0ENI8wlt1Xo16JwFnKGJuCZMMKp4mb1B4Fb2udsh1hR7B/qX8h93iVgKsFIas6LGTn0QofHnYy5qFpvgDs+FDcNf/0wtLQrBB2DrgdcnZLykceGnOX9xK3vD2Wkm31EQsJyCKbkH5hZs7abe/KPzaTZA80iU01jKtprTDYrEDyaBmyOMKkPgYVOz/qQq/5GENcxQ3ofnQJt+FCd6zohSFDRi+U5yWBft3AqM7tpy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:40:59.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166779c-a1de-4f1b-8d6a-08dec5af033a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296761-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A68E65B0BE

From: Brett Creeley <brett.creeley@amd.com>

Add a new capabilities field in struct pds_core_dev_identity,
which requires bumping the identity version to 2, i.e.
PDS_CORE_IDENTITY_VERSION_2. If version 2 negotiation fails,
then quietly fall back to version 1. If version 1 negotiation
fails, then driver load will fail.

Another patch in the series will make use of the capabilities
field.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 39 ++++++++++++++++++++-----
 include/linux/pds/pds_core_if.h         |  4 +++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index dd9989cfe6b3..5c0ca3d0b000 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -250,15 +250,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
-static int pdsc_devcmd_identify_locked(struct pdsc *pdsc)
+static int pdsc_devcmd_identify_locked(struct pdsc *pdsc, u8 drv_ident_ver,
+				       bool do_msg)
 {
 	union pds_core_dev_comp comp = {};
 	union pds_core_dev_cmd cmd = {
 		.identify.opcode = PDS_CORE_CMD_IDENTIFY,
-		.identify.ver = PDS_CORE_IDENTITY_VERSION_1,
+		.identify.ver = drv_ident_ver,
 	};
 
-	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	return __pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout,
+				    do_msg);
 }
 
 static void pdsc_init_devinfo(struct pdsc *pdsc)
@@ -281,8 +283,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -305,17 +308,24 @@ static int pdsc_identify(struct pdsc *pdsc)
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
 		memcpy_fromio(&pdsc->dev_ident, &pdsc->cmd_regs->data, sz);
+
+		/* V1 firmware doesn't set capabilities, so the field may
+		 * contain garbage from the outgoing driver identity.
+		 */
+		if (pdsc->dev_ident.version < PDS_CORE_IDENTITY_VERSION_2)
+			pdsc->dev_ident.capabilities = 0;
 	}
 	mutex_unlock(&pdsc->devcmd_lock);
 
 	if (err) {
-		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
-			ERR_PTR(err));
+		if (do_msg)
+			dev_err(pdsc->dev, "Cannot identify device: %pe\n",
+				ERR_PTR(err));
 		return err;
 	}
 
@@ -334,6 +344,21 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTITY_VERSION_1
+	 * instead of returning the max supported identity version, so retry if
+	 * firmware doesn't support PDS_CORE_IDENTITY_VERSION_2
+	 */
+	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
+	if (err)
+		err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_1);
+
+	return err;
+}
+
 void pdsc_dev_uninit(struct pdsc *pdsc)
 {
 	if (pdsc->intr_info) {
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 17a87c1a55d7..619186f26b5b 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -119,6 +119,8 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @capabilities:     Device capabilities
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
 struct pds_core_dev_identity {
 	u8     version;
@@ -131,9 +133,11 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le64 capabilities;
 };
 
 #define PDS_CORE_IDENTITY_VERSION_1	1
+#define PDS_CORE_IDENTITY_VERSION_2	2
 
 /**
  * struct pds_core_dev_identify_cmd - Driver/device identify command
-- 
2.43.0


