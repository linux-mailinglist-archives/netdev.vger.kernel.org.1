Return-Path: <netdev+bounces-301104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CEVfIIItOWr7nwcAu9opvQ
	(envelope-from <netdev+bounces-301104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:41:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731236AF81C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:41:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=eaGe9qfU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301104-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 801B2300808D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B313AB260;
	Mon, 22 Jun 2026 12:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B03AB5C7;
	Mon, 22 Jun 2026 12:40:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132047; cv=fail; b=k1kVRvpQJk/Yt0F99zaipK5l33qHSvmLTBtBD1mFGQ8iFFr5g5y0hSdoAx70wGlAeeOd8NVCPz2BG/uCvCp1CX43DjDI/o1P6G1lgENKt/Ngv6Bz7qXJi8+5GFK3Px6smMeRuDyzJcVY1ARW0P0Iv6Q3cKP7wvav7U/OuMQtGLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132047; c=relaxed/simple;
	bh=MrE0T8/LLOAWq8xMfN1hwPJaoveMMUOgbFq046uE9Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGZbLfK2ZyLWfmlL+3lr6B649mz7ObSCfbcxbj+89acpJOgSDZb7MVEeko8uLbLBV+904B9/ClD600bcWJULQK6LeJ4LPP2s6fnvqvmTE/0uXAiRALPLwXOKANlnNvqAbvmMH3ZRKxPt/praRuQlqfyWSAobLoenk6I3Q5p5kCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eaGe9qfU; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOBWx2AI2gCdGdXqO5eu2dsgFWy+Dgl1lqj4Qslvsc0HDGp7v7T1o4eWljAJQu8Lx9G52pKw6DzHA/nqBJo29ycGceEc11odrk/pxdkvYSS0Ln7AxZZg9sOQG3cTrHVk0JZM11qTnwJcSDdvXoZDKg9WV22OXYEybwahhJml/CnBFMX+e+oaQrNegdnKmhhs+rNwkTAKsZVikqJXrmMvnoEWbOkdhZP0Sk9/5meDqEG2uwms+ZIaGbJxEXWq61eh7cW5bqy7dM73XAifYbolwXSzpFBpNtYGdzjaazTY2hoDStvOh++bfd2WItVXYXPjsitHYIOzHvhnVkZPh+/GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe6vbR5a9FdMKZGDKM6K0e3IUYubzLRAxcZEPhNq44M=;
 b=Y0qAaIbhBo+jPW9fYGKI52N7xVMC84XI17/yf24SpMRPPw3vpkYPnbEx4Gb9GEWREed48druOtdHBpAkNyoOb6NeLhcLQrLiT4MoY8Qoitm696BUZkhh5lFshW2scYbGkwe5mnUfOh0fHs6JvzAXjvAH+yF0khi+G+EbFHnFe7KH03U0XeBM9lToUlnQpTIvJO8spjCVEEcCIebN/PeMmdqpKREHL6Pt57VnuJ/UkGuP91bJFjbhG5Cx7je9XaYZfYEdDGufNIsquM8olX8hluOQBfh5rVNv5EqNzLWdvqH5EjFhX65McQZUyHGyhLxiCs6bAALrVzMk8C2Ds4bnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe6vbR5a9FdMKZGDKM6K0e3IUYubzLRAxcZEPhNq44M=;
 b=eaGe9qfUlE3I6VMEGUPgcOf/C8RC0LB9LN622ItqpOO3uiyy55jIMUCHPN/AcNfWIHLwbZHvIIcquHLks8IGAAlQUHW0uYY3tY8U0DuVzvJhCK8XtGjhBGb/JUZHy8Vu+0H0oPE7US+WiwQ9cn7Ws3sxRTpjAo5sBhFcRO9V/0M=
Received: from BN9PR03CA0783.namprd03.prod.outlook.com (2603:10b6:408:13f::8)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 12:40:39 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::28) by BN9PR03CA0783.outlook.office365.com
 (2603:10b6:408:13f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 12:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 12:40:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 07:40:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 05:40:30 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Mon, 22 Jun 2026 07:40:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v29 4/5] sfc: obtain and map cxl range using devm_cxl_probe_mem
Date: Mon, 22 Jun 2026 13:40:09 +0100
Message-ID: <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b393cc-c6a7-4a5a-71dc-08ded05b7750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bmF2swXeDYeQ9FZeTHxX2U95jwbMSrHq1PbkTeFca152FxJu2DcBKIkYII+GFlQKDR3nHxK5kmJ/KTEzgjx0dQeHmtkkFz+tVcZWIxbXALvr6qblP4BO4iteyKep6RaIl3kZOSLgOoSXS+gpZDePk5R2TSmeeXMub4xXTUbGRi3KB7Bn93FwgPF/9IJ/YUClmhI9HsM0+18udUQ4qgIYRFl8FOi8GLBKHSmaes75DFRx2rGxoi1bWk9UUiGXR9DDOk+DSmtY3+I7e2hT7O5CuErOZR24nK4TWUxp9wfcgFm2ZyB1eur6vAhR81oBOgG7PiTdz01PqDSTKCyeYsqmF+wHp40VhvZbPVS8D77k62yJT04b2HkSOpphVhGqX8oNR3637K86s7dvJPCS9rehDy5wZok25+npn0KUCe6oMfPlO2NgvJ6//SleokiigXk0oawnKm8w2oCcIaVASHGzY2qzNZVcClE2J/PZsHuFEslcg+Of8MQTzLqBEbYhZDNtcSCcBu3d/FfJZWDe3louUK4FH3OeJ/Ad59iIPNloNEG7YAEHJIbNxTjupYS1bCtXPareRnE8RmqDz0cY/5DXZy3SP8D+sCmS+TtdP1b/pS0ydGaykTEV65vsPEreU4le5V/LZjEO0d84xzVcjJOQuvqB5OCwJak6+b004yrEDPhVTLCKvfEQaKWknjFD9/Vjr7UeYtyfUotSIcK7yxvf5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cKAyNigcTeMR72n4Gscn2+MiNMKJGWdlVowSKw5BKd79TsGX9JJr4WAaKYQPTzY0rlca4puPtZyWJt/evy2g+BIlSazmqAtsWR+jFow4K7AC341anaxdLT5HmPo8fa81+ZAyLgjIWspuBX/3Bpc3Ls9yKuU7NssSJTlvuum/loOXQb3jlDRLdSUW3ZMq98+UNme8cMrBZb7EExS5mCozMlk4TrKp2Ixt1OnMMna5aYhfjBvM1amSB6rlxPYn6L1cW7g95Vd5i9xXOlnsyyPWWPPHPAJ3bVUZKNpk656v7BrkDaNBCUawNRjo8aim8eDbkuS/cfAPqe3tPiK+gkM//oid4qE0/2WWUgzxqMIjeh271YnFpJCdkxZ05Jl3iN6UiIhWh8AYhxIt6o5+/mtvhnPwBUyYeNPoXJNt9wFPxIC+jVYsZ+RXhoyE1dwjx30B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:40:39.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b393cc-c6a7-4a5a-71dc-08ded05b7750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301104-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 731236AF81C

From: Alejandro Lucero <alucerop@amd.com>

Use core API for safely obtain the CXL range linked to an HDM committed
by the BIOS. Map such a range for being used as the ctpio buffer.

A potential user space action through sysfs unbinding or core cxl
modules remove will trigger sfc driver device detachment, with that case
not racing with this mapping as this is done during driver probe and
therefore protected with device lock against those user space actions.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c     |  2 ++
 drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 61cbb6cfc360..3806cd3dd7f4 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_fini_io(efx);
 
 	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
 
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
@@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	return 0;
 
  fail3:
+	efx_cxl_exit(probe_data);
 	efx_fini_io(efx);
  fail2:
 	efx_fini_struct(efx);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 18b535b3ea40..3e7c950f83e9 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	struct range cxl_pio_range;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed\n");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
+	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
+				    range_len(&cxl_pio_range));
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
+			&cxl_pio_range);
+		return -ENOMEM;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 }
 
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+}
+
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 04e46278464d..3e2705cb063f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -20,10 +20,13 @@ struct efx_probe_data;
 struct efx_cxl {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
+	void __iomem *ctpio_cxl;
 };
 
 int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
 #else
 static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
 #endif
 #endif
-- 
2.34.1


