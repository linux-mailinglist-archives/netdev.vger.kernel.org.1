Return-Path: <netdev+bounces-256332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJGPJkMPgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:07:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA52DB117
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63078301F202
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E943AEF29;
	Tue,  3 Feb 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CwBXm1Qj"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7423AEF5F;
	Tue,  3 Feb 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130667; cv=fail; b=TXkr0cGhBNbEA3RcaxlQhXt8vaS+ZcjluYRQyx0L7R7vTE5NRYkSdYfgpHOyRyy2hkstTmrxB4+WFfiLuzSo6TP9urin7lRTQG1816hl48a1qo1RGhtSPPF3YdWVv+1Vg2eEDt7w4JZjZq1xWMyVwuCUOnyGcaNBHqTQiWa+G14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130667; c=relaxed/simple;
	bh=3CqwYHufsiNARqBhUxDipF2D/qsKFkMz68t1yBafdVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNRS038OrJXs5iQAvlMslsNkJSND+CHNY26JyTuq1e1/gTtfJoJg+xVpNiWRDf4qHeT43ZIocRjGa++XChFN7MicTUc0+Lcn/DsDjEgY9+JJ3r7o4LPNpJKPbTA4FpGcC5nq7/18ZAvEihDwGwQFtf8VjXNiHwQGbLx26SNhWp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CwBXm1Qj; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAYlrZiVPLCFbOWXGtNHCk0jdSZj7zDKHCk5bznO4kw1c9elbGE5mxDsj1H6Hfd467/JhBxh5hOLePpL1iv6p/+J5pZfLxd3w4VNkrr/rz/EZ90Bcvnp8XhhLDdn23PDOlLwD0LvTD2abNN//HHN0a4HOVmOCkm9Ubaogix22YXbty2XiPTbZMp0nOUHBLT5HrJM1adDUsXwH9xe33TAdrXRs3vmK6DUWozlK7m69RtbKNOQ0kzT0FQp8giG7UuVQ/UP2Wkoh02o3r/6BeoInyvt3iv599JFKh8fJuCoQ/tcdQzI6LqqlkyrNFgU8U/+m+erZGwsCS20FgdbfGevXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL3rNF3bVIWWesjUtRMnKUzcAdmx/Q4qIjuI7iMM2fY=;
 b=iXDNzdrqem6g1j1qaROHiLMXJxuZQihCV03ky2xm2vmq3VttJRB0adBymu3RNy9hyksmtzpdT0owlMRykChkMAr97PdtKXAKZh5RQvvcXclb8Q95lS+QAWPRgbTKADimC+rP6DwPri34AYH5KU1D/Tax33YQMadpiAQ/c0D5pkd42Mj9v9aHDH9My/c1nrJYRuwww9YGqGBLPvPYjrfEjK361al0Ltn9MhG69ejgBLVJiyBpTPEbfucNk5Qmh8Bc3O1Q4WXqB2NpLF7qO3qB5Zm1OgLjLjrSjhyoe19jZcX343pBLKs5NKcK51Sb9aC3SYULY4dob9r2cnuNOFAbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL3rNF3bVIWWesjUtRMnKUzcAdmx/Q4qIjuI7iMM2fY=;
 b=CwBXm1Qjj1Oo+SQSsBUBgGHSbWbbqIsXXCFACmPXajq6SQxdJ0OWhxn1RO4gzYWYJLi02SU+cV1r0kWp5d8OcWqOp0h5HgOVoiB7mhqVADHnRH7S5chOvD4Xssfu8nNXqDespDTop4z8JxLG69p9Ups1z0+Z51btwmqFKEDsOSo=
Received: from PH7PR17CA0032.namprd17.prod.outlook.com (2603:10b6:510:323::22)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 14:57:39 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::e4) by PH7PR17CA0032.outlook.office365.com
 (2603:10b6:510:323::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 3 Feb 2026 14:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:57:38 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:57:34 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 4/4] amd-xgbe: add RSS ethtool self-test
Date: Tue, 3 Feb 2026 20:26:58 +0530
Message-ID: <20260203145658.2936778-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
References: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a57fd0d-a800-403d-30bc-08de633492f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXLNXEZCwtzWZ4OgipKq9QfdAxWdy5+i0xkRjdwEh1HHQXIO2nB0srH+hKTK?=
 =?us-ascii?Q?q6a9AHUYBJBKUCar9tYb61cMP6RhIL1QWqqK43oZPYiA6QOTJGPud5/ICT2Y?=
 =?us-ascii?Q?PNavZoHjABT95nc3VkjE6iDLhC7GCvFv+q2+n7GuUYUXaZD/yPR3TcJBbVJG?=
 =?us-ascii?Q?N5YAYovOO4/N+WmdzKvPs445qIR1JSCPPPYzxHAfftgddklmt1vqvW9IA5eG?=
 =?us-ascii?Q?sts8CkIV+iJKGtSdcr8jy/j2R2oXS/m4WrW1hdqI9X0ULsXbAwW7d9vyho8m?=
 =?us-ascii?Q?OTODLfXA3i9cnEQ4v1z+TvyBiQfHslcq9+/k2uaXQZ8KgfVagZDOf5dbNTTA?=
 =?us-ascii?Q?znkDvMNK7lilSqm1V4Fil9WrYmzEE/HnvvT3Fn5LH6aMdtGvehmtCC3BSX+O?=
 =?us-ascii?Q?gIrAVj1idAs3AnKHGlrTLoBwJx6aLsZD6JB6yzTK/FiD41otmctqkuQ5kqsL?=
 =?us-ascii?Q?Lh045uCVHCQgvakoLE7p4pOLmW9X3bp61E+X1ZUuek48XIh2+0HObywEN1vq?=
 =?us-ascii?Q?bQsG7lYtLu0fsEqLIxjm+QrHc17biV75j2CEu2QfzNf0hHzecyQCNxiGGUsr?=
 =?us-ascii?Q?ID5ZnsASW+3mDCUe8NqFFjtS3l2l/aJJld4eDBUSDmIUck0v6qZTo80B9O+7?=
 =?us-ascii?Q?fMH6bxkd7xA+dWjdiz8wcctUzsaLHNIOQjRM7l2Tnd1oweAeH7ken89bRklu?=
 =?us-ascii?Q?/RbcP+ZdtGahkB6/cuxZhFy0OS/NWHMauaCT6j5ItFa0fGBRMAIxZBxKF8CS?=
 =?us-ascii?Q?0pGyjOgyh6iM47r2VkDoFwWqWq615zf2vzFKeoxiXqIsw4Qc53XVVJZykUig?=
 =?us-ascii?Q?kjEeTeZzoNONDk19ajZ0iBIniLLJqTOrITX32oLmpdGO6cQnNr3opBf5J3Z8?=
 =?us-ascii?Q?baKsedxbpygu7mTSw0pR8jNPCSdf9CSqQOUuNcEEDBULZ6K58sctue9FHHwK?=
 =?us-ascii?Q?HEryWoBbM80d0MC+2XKv1k9/e4VbF0i+2tnM8qcmuz7JjQHuIpdZmApZGD5U?=
 =?us-ascii?Q?F2+bWRREHLpvfhlGoNvgDYGj8gL6CAc46noHVMKLgkDRAxWIYXZCP2wY8Ll8?=
 =?us-ascii?Q?cFMVTTnfGPveuJR67EVw7kapNJ/emGXrWEyeYzsNTfbPaW2K1iAvHhUrKHTk?=
 =?us-ascii?Q?N5gjI0EFO+yIfwjhzlwUKGptrv+kOeiR0RyDd8l6JWfa4f9QRlGCT6Fpmgos?=
 =?us-ascii?Q?3u3IiJjm9ABKbvDOs36Avn4BbFSMtO6Fv6rS5binnN0Mvs/J+afZd5PIc90m?=
 =?us-ascii?Q?cDigyklGszko909Rq5GAqHA3WyNjZSr9b0vIw5MFMiYaEkhaBs4VYF6CDiIQ?=
 =?us-ascii?Q?a+RKdFtR/FW6kI4IeAzfUUowOJUaW9M+ftaZvcMask1vtF6pLRrDwla1xltw?=
 =?us-ascii?Q?1CbZuW3OrPt4S4y6W836KLs3x7G611bSLlcachq93cQFAHf1/rDWJQYvPD2f?=
 =?us-ascii?Q?VWCorhyWdT0paTmyVV5m49VfNQn4UX91H7S0AkJOiiO1uRDqtDe8bW7SawNT?=
 =?us-ascii?Q?zwsMFgcxGDFpFLpYmnwUONBe8Osucb9/Mi7ysIlxuX9H4DYJXoDGkgk8ip2m?=
 =?us-ascii?Q?uEz6NoY0tqz/Q/ZnGgO9nzhXub0dQuSz5iSJjUCdxeFZflxoWMqTLqPtCfHC?=
 =?us-ascii?Q?rEGAMWhaDoijbMr7qWB0/mx8gkZs1JrApMkOtRHGIw6xnp6ej0BzhnmA+XKl?=
 =?us-ascii?Q?aZ4wyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tglQ2rWrnz6XkJbkiRV+8+hI5Wl54EjJXxUAP8oNHR04SuK5RWCZZHXNqn+2+p+1qsFonV52ZFCOsnL1kvDKXREu4oii7m8geMoOomzJ7QaESiwutmJMPrPgQprRdvDPP7iI3awfPkv0ZY4kdzycbDlal4B067+zIv7pBBkJVzh7zrY4ow8FzL1lMjscc+05d183+7dzGX70gJq8jGqrQwbkPYE5vaTGHTRw7vCipzaUVwF/Om810SXWgG+KTe0X5T+P365gZyJZfOlw7bFmELT2fo45MqOSzaQhGnBRoWhl368DjFQwIkN1DhCQnmZXFE8ZUA5HlqkJ9KBaNW/Wuq/rEyOl7q0Gml01HFBmxIc50ZtmCnjwaKnlkTOa/UDMg6FVRUJUXAk/7hjCRxhYf5/xuVeg3PaewaUUjKL2ltstW5ecIMdhpkLF1qhIWfx4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:57:38.7498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a57fd0d-a800-403d-30bc-08de633492f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256332-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[attr.sport:url,amd.com:email,amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BDA52DB117
X-Rspamd-Action: no action

Add a Receive Side Scaling (RSS) self-test to the ethtool diagnostic
suite to verify that the hardware correctly computes hash values for
incoming packets.

The test validates RSS functionality by:
1. Checking for RSS hardware feature support (rss bit in MAC_HWF1R)
2. Sending a test packet with specific TCP/UDP ports to trigger
   hash computation
3. Verifying that the received packet has a non-zero hash value
   computed by the hardware

The test uses the existing loopback infrastructure and requires
PHY loopback mode. It uses specific port values (sport=0xabc,
dport=0xdef) to generate a deterministic hash that exercises
the RSS hash computation logic.

This test helps users verify that RSS is properly configured and
functioning, which is essential for multi-queue performance on
multi-core systems.

Usage:
  $ ethtool -t <interface>

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 32 +++++++++++++++++++
 include/net/selftests.h                       |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index b57826a91361..a4e7decf768f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -213,8 +213,13 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	if (tdata->packet->id != hdr->id)
 		goto out;
 
+	/* Validate RSS hash if expected */
+	if (tdata->packet->exp_hash && !skb->hash)
+		goto out;
+
 	tdata->ok = true;
 	complete(&tdata->comp);
+
 out:
 	kfree_skb(skb);
 	return 0;
@@ -267,6 +272,29 @@ static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
 	return ret;
 }
 
+static int xgbe_test_rss(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int ret;
+
+	/* Check for RSS hardware support */
+	if (!pdata->hw_feat.rss)
+		return -EOPNOTSUPP;
+
+	attr.dst = pdata->netdev->dev_addr;
+	/*
+	 * Use specific port values to generate a hash.
+	 * The asymmetric port values ensure the hash computation
+	 * produces a non-zero result for test validation.
+	 */
+	attr.sport = 0xabc;
+	attr.dport = 0xdef;
+	attr.exp_hash = true;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	return ret;
+}
+
 static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 {
 	struct net_packet_attrs attr = {};
@@ -370,6 +398,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "ARP Offload    ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_arpoffload,
+	}, {
+		.name = "RSS           ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_rss,
 	}
 };
 
diff --git a/include/net/selftests.h b/include/net/selftests.h
index c36e07406ad4..18a9b4830dfc 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -19,6 +19,7 @@ struct net_packet_attrs {
 	u8 id;
 	u16 queue_mapping;
 	bool bad_csum;
+	u32 exp_hash;
 };
 
 struct net_test_priv {
-- 
2.34.1


