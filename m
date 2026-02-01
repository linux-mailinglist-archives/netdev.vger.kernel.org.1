Return-Path: <netdev+bounces-255631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMHGJwB4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:57:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793FC65E0
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551C1302F274
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B024469E;
	Sun,  1 Feb 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aorbb4lf"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658623D2B1;
	Sun,  1 Feb 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961313; cv=fail; b=q00ND8pXRt9OXt/ofZNAODuIY+LoQL255+N5mefPU/RtW+Qix4WS675Tb3pkt46jKcae5N0aGxigwl047IIUD9ULmJGiggYgDwopn2kJQqf95nURpv6WtCmzWkDCFbNXbhEeHUCOz1hQ95wXJFutLI5joFTYpug64he7rXmNqDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961313; c=relaxed/simple;
	bh=GeueDa6RetcI7T7Jz6ixBiOl+BMxDhuU7jv+6OljQ9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvmfxsIcCrwB0Y377HKMyFOJ+9gGIL+6YZVjKsNayCgHAWngC6ahO9XAHCt9IAqb8du9hbmsHjCiWzhq8vgnDWUaXLRe9mMw5v4FJWPeAVVEgja25ZX6s7OtikCmdEpYmXsLxV5xnSdvCTuSswf6KNc/b9sY65/snMBX5vs+Gw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aorbb4lf; arc=fail smtp.client-ip=52.101.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR5N58Juu3O0+H4yL8pnMPVT5+vYuU35TwK1u/46mLTaLrJH+lwjo9CyjOjwA6cBg6x7qKK0nBEbv4CaHofwo1CKUhdj2wTuCuX7T6QVseBLNQb+J4ueuNU0zmJbxT3+6ZbXNxRw/KqgKYoPcnngvT9wOpu+RvRHzXJjnMsi7Dh1PuypsCq3fqqHz68DVoK4A6S9AwoZ9gp8s6l8qKdIq9tSNvGBq+3UhrY2EkNd1PxEG5XdCIGVAhFi6//cLvry5QSa5xElq2DwijZh1SO5+/95XxCsdbHocFN9vhn9uUcnGvVaLBk5tTfF965d2B3Ihf00OvnNwshRtXe4VhXBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBGWsNHkmKx7G0/wIRcQTr8UPMFtCA6QLcisppQTZpU=;
 b=Ek1k4BSI4WA8EBK01re6I6JmqV2ab8jt1Fa0CS48DDK3BTA90LIJkm+g5bt8NFuzkPkEa+HOkrIdf3dOn+vz457FnNSS1JHnJhioLpOkK5ziUSjQ+G9yy6C/B+RA7NGvl9mJu/GHvqNLIBxzUPvgRghHWI7lPRDFwLH6f0tEcCYbvA+E+N93XtAs0UF3ylIvrVZG8y8sxhIsClhHoYh6VajHvq9B/a0rMVch6lAQXxazpfZMZHNl7GfGOSTJ9fPnsrA5FimEzXg3KM2H7vJyPoaij2mjOOUWY8F+cQSLKy20+hQsOUfn04AZi83oj78r0xJGbZpojZO/vM53R+loZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBGWsNHkmKx7G0/wIRcQTr8UPMFtCA6QLcisppQTZpU=;
 b=aorbb4lff7cv35T5f6PIDmR7fAZjMGuYaFC1M8upqA8cWyobVCwRub+tdLUqfJghcndz03+V4245H92cQ9khglhSyRctVExGxxjUzUJP5KYPaicC/I1vB4fuhvADDxY1c53l5LCkjCO3lb0SOupVarJxVpDkEr0wVv+GugbXJ3M=
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by IA0PPFC855560D7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:55:07 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::67) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Sun,
 1 Feb 2026 15:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:02 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:01 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v23 10/22] cxl: Export function for unwinding cxl by accelerators
Date: Sun, 1 Feb 2026 15:54:26 +0000
Message-ID: <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: ac48fa87-f22e-4820-ee16-08de61aa45b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lj5G7KjKE1Ph9pter5yAa9ILgDt0nVV3LvDVJHktZgOKBMOY9UvQKxbeHg4q?=
 =?us-ascii?Q?PvVQY1znl/3duixxUsx1nXsaXD6HMAIPoX86wpS2430HLjKpixyyRqYHwOp3?=
 =?us-ascii?Q?fbEi89hMtqVpQlZlYWJGnD3iplEF2RfNPFH19bAelnqYGskba8kF3Xq5t+oF?=
 =?us-ascii?Q?VdDcmQW1JqqAKG5SOP8CIdzen5ZflcAy9DbZc+uU6Riy/LYM5n/LQ4YY4rJ6?=
 =?us-ascii?Q?NJGdLGdaoIDCSQs5pQfIcnpF+NEsCt10tdI/lBvBCKA79XuIid+RLZKTexOH?=
 =?us-ascii?Q?6pG8YbZ6Tkv3vwf4lRFVC3eUHUvEUN0BeIz0/IRNzGygoz4Pkc3wxAPIe4Gq?=
 =?us-ascii?Q?GhGrivl0v266cE7XfMFBoaSX+GsOIYl4PjO4G11J2Ie4jJMmMo6TW+GzaftH?=
 =?us-ascii?Q?7PQplFmLJKkxiWO6wl0wtONZUlSevty+or47xE/+6E+jVlu/mOp4mGLsqtds?=
 =?us-ascii?Q?1Da1qcYp6VUh9H4yMoZJGeqzFkwodT+nXjr0MXGdjuqbW3HG11QpMbyv/cIz?=
 =?us-ascii?Q?+Q0dPkagmrlm9dqzFK0LEcLt1zq22r0nID+HX4dIMnkhB9xobyBfidtuXYBN?=
 =?us-ascii?Q?yL5yFgb0yiGm8WonhvRU794iLMMzp5+Lblc/hzInrDPxmrn98TnBzVPKSHdH?=
 =?us-ascii?Q?8/Ek/9pmYbIdtPwE2B+l7cvWoMXTvK3m2UGiQt3WtBh2oZNgq5mGrgycPRQh?=
 =?us-ascii?Q?4lUiI3oPFdQaooJQsNcnjAHIdUuopg/B1Bx5DggYVvdALJCwS/LA4+HxMv4Y?=
 =?us-ascii?Q?EDBlrSI4Wk+j2LdzlLNZt3LLGKQPpFsRQzLUrW2Q9Q3TDAw4P2OQCr5Mskzu?=
 =?us-ascii?Q?VceP7iHmahoaE6giM6HFzW17HExmyaDhCg8qdyxwYOtVqaZ0hNC6LbK4zOLS?=
 =?us-ascii?Q?hwuSCltKgMm9/x0YUGkeT/CS4X/1dgf88d7ZUG95w/lY7suoGcJ5Az9I8cRU?=
 =?us-ascii?Q?JggZm5J0xzXioKSBaH+Da1O6rNTVJeIL6bdxRrHKlQnEjhQgmPpCoNkJ9dzB?=
 =?us-ascii?Q?Jzp1YviK3PqtW1Ej4NG61J1HA3CFnxCDnZ3LpnNF8giJCCCRL+erVovmJxTn?=
 =?us-ascii?Q?OzuJGNZjyfHesRrF6YZu4Q70v3wKyDz6WowLp6TrPf1SnEFzbOtWjw39vEk5?=
 =?us-ascii?Q?NQq0nehgaZ37OBP2L0Y+IODc3ULLSUnw8d1UXvMvipmP/mLgZT+LGCOgCY3S?=
 =?us-ascii?Q?FC8ZVry7y6ywSRbgG47AwveTIaF/Sh0cTzt+r8HkwzsitcTefF+tqOv6v9LQ?=
 =?us-ascii?Q?ZFbk6SYnST1ovpveIfC/ZTwi8hFkuFitApQ22+52IqybDgJXfBRzDLwtVV4e?=
 =?us-ascii?Q?3PVtc0sr61w3ReR1xIR6pD7jd20wrbTt/gtx9rUZisXvEuEVFVKrQlxCPMy9?=
 =?us-ascii?Q?9vcH2PfWwL/VkijDISaikGwnTAWwBuXTxIEmX0tYSRUyc2SZvswx0dbKN/Kz?=
 =?us-ascii?Q?CZDcR/gzqwAzNq7/9zyLpNwIjDdcifu38lyz5+QEDIU9AbcDyxFxZZ1k5Nt+?=
 =?us-ascii?Q?2m+T8Cg2WUumgPrsiIbur7rEladDXq3GMbP6vRdg3CPqWB2evXJbwhS9ykZK?=
 =?us-ascii?Q?5XaK8kyjU1YXerBS6BG8Td592/gyebJS1WyW5FVi+ApTcRduGFP9eErlqCRo?=
 =?us-ascii?Q?doWbxkXyjR5dU+5WitihYVvPjcWmaZI2/OsHee2Uubz1mzsoSbxe5TzxUs7k?=
 =?us-ascii?Q?JnIKlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tyKY1y0DODp9Ys9Etx6UcBLJ1t5kyAQU8C2Y9lFBVaRadbI+9mxta8DvRUmUpgYZIWRbqiq5ZVj4zfDw4jZM36wnxoho8oGdMjx6Cf8zngzQMzqp9MclUnjfmCsJqXxi6bOAqJcRU51F1hHOuFFoJOpCwggoobR5lyotggSxpv9LKakKeWGs+G6dnrzMDXqyWpkIoZEmUDHSuEvMfEEEydGnQwmzhfDiQPeQOHUXRZbbd5iha+TM71hFACfuJFgwx2iC6Er6fWsqS8x3k6NOen/ZxZJHyClMooNXC0vtiDyRJdW4bOwWVAoXHvMVm0PiJjS/0uaySkhLIQmJMrrKDCbbl6YdibIqp6TXW37ryuO9OdLme5pgxy8jrqOMOSyTEFZqmPsP5rnNZ/Oi6e0FrddNhuUrTEzeprf/1v6ymqKvNjrRsuLEXM6FqYmHwuxq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:07.4462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac48fa87-f22e-4820-ee16-08de61aa45b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255631-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2793FC65E0
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Add cxl_unregister_region() to the accelerator driver API
for a clean exit.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 17 ++++++++++++-----
 include/cxl/cxl.h         |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index acf29ba3b205..954b8fcdbac6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2438,9 +2438,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *_cxlr)
+void cxl_unregister_region(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = _cxlr;
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
@@ -2457,6 +2456,14 @@ static void unregister_region(void *_cxlr)
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
+
+static void __unregister_region(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+
+	return cxl_unregister_region(cxlr);
+}
 
 static struct lock_class_key cxl_region_key;
 
@@ -2608,7 +2615,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
+	rc = devm_add_action_or_reset(port->uport_dev, __unregister_region, cxlr);
 	if (rc)
 		return ERR_PTR(rc);
 
@@ -2762,7 +2769,7 @@ static ssize_t delete_region_store(struct device *dev,
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	devm_release_action(port->uport_dev, __unregister_region, cxlr);
 	put_device(&cxlr->dev);
 
 	return len;
@@ -3878,7 +3885,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
-		devm_release_action(port->uport_dev, unregister_region, cxlr);
+		devm_release_action(port->uport_dev, __unregister_region, cxlr);
 		return ERR_PTR(rc);
 	}
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 906065e0d2a6..92880c26b2d5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -254,4 +254,5 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 						       struct cxl_region **cxlr);
 struct range;
 int cxl_get_region_range(struct cxl_region *region, struct range *range);
+void cxl_unregister_region(struct cxl_region *cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


