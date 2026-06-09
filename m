Return-Path: <netdev+bounces-297289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gB6RHIiAKGpDFgMAu9opvQ
	(envelope-from <netdev+bounces-297289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:07:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4D664321
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:07:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=VWSrQh6v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 233F330AFB12
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458C3E2AB1;
	Tue,  9 Jun 2026 21:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F23E8686;
	Tue,  9 Jun 2026 21:06:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039209; cv=fail; b=X5t3X1+cYEMJcy7ngGime/2jTvZajcWSODGjhIXVswF5OaOrNExYrMtcR8unXw03tu7tEJ2ZN7yRJI59FbtIk9Og8FhWq0cKav4C5AJ/+GF9kJdse9Z7n3Ni56r869wGg3ZskoWdG+sMEzWI8zvwPAecr5wJ9kITsEZzQd+NuRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039209; c=relaxed/simple;
	bh=DoEXFX6A48008hhxn4gnHrrCOYoifenYWokILQ8OyCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPP2JLlnRyiaMpO9qvc4ZAQAumhSw4TKwrpSK4+58VMjOmyQTR0lz49Dj8PWW7h7KZgta96XTsQJtSvGVA9C785+k/Ue58Yc8I/F4RT2Ja/SY3JXO7D0CC4it50+UTVZK0mpOWEBIt1LsIY38b5I0zGlkdycYxEHMgqdQK+4AI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VWSrQh6v; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnHvrkDxWhG+MiZQ/bn52SUvRo2e4n1DBFvhGk0z0hdOC+yO2h/DRYpI8Cx6vpg63oznd1IVf6NQiRFmPxbezS3rxMOK+pCM/BR8uGu2+b9H4emR4o8Cu7rt8kqNYQbVX6BaozzG4ERabRJVzcVZRbOZSwo3jf7WQn1UjORDJ4xxmq3PdbHOgHnLlCpH7eZQ8RpTzYaVJtZ+8UPJkM3F1nNf35GkPfGBOx0l6BC6gO+VBXGajmPqXy7mfjSzqkTOLGE29whwi/q2M4VhmTpvs9NcV5XwLArMdWcoMKOLMAf9dOs86tXITwyzZDApuOE0vk+SJvGdYkk7VXJf0oyjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhuctOcvxGMpPzw51UzTwPjmxGdTvT/Z6I9B1IAlSk0=;
 b=GT1eDygjQJIUOonW2HDOrBx/fxrKnWIWd1uZiGcUhcnH6HTGguVdYR6aR8cOk5TRu9/l06lRQ58E2fF9PzROzyOoOZg8bktFJtUozBBG6bOA8guQvqvwX7fzMr8DOQdq9llWxE9jsBI2BVpr/7eIxdqUPxviUkUwngbqM/uiWk7nlK0FD88gb4/1rjppxhiRlCPFqjQQ95b2QQ9CdAZ6r7aFaebnDN3Y9/q4aFpwlfSPK0WM11xkmcKz4zpABk/7oPDfRki4HJLLblwAxBsnjZ4AKi1gWLJjJysO4ufUOEc9E3I5vY023ijP98uP14JGwpLtzFGcqe8YBB93yOwakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhuctOcvxGMpPzw51UzTwPjmxGdTvT/Z6I9B1IAlSk0=;
 b=VWSrQh6vNxkfMmWhw93Tzu/zT6NPIOcVP6dyjx4inb3CbWDMDF1FZfCYcbt8/8prstPAx7rtRpe2E99acjpddMH24ametz3Ea2oeAWF3wGeLyhdPDWrKeYkFfXOmmQsgp0r+REUdMC1qXTAlrtjuQYAbQZ2lZBERrUyGktM2C64=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 21:06:38 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::6b) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Tue, 9
 Jun 2026 21:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 21:06:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 16:06:34 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 9 Jun 2026 16:06:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <djbw@kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v27 4/5] sfc: obtain and map cxl range using devm_cxl_probe_mem
Date: Tue, 9 Jun 2026 22:57:54 +0100
Message-ID: <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: c6be3137-d1b0-47b6-892b-08dec66afee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ys+EA9F540nehDFkhMlRe2C160fW/xUyR6TvfO/wdjGVejpNTnF6CUWeAEljOGaqRi6Agh+0vMBhnYJp3Hs50lNaI0w5TyrtAsIUJ2UrAx1qqUA8vQvsGDKRkTUNeblEy5vswmtj0r8dSABq4D5y1hR72smUkHNiIgggGP+YKCaOiMv4oAUxmz0kRk4Uhc+Yx8ANO/NK778rlcjJt/+ZkfHNMizZHO5gw51zT8GbZg7UNPN/j9g/ARv6484dYbDo5T3wZUcnErOqTPXH57QO+kfWU7O8kkvYIzIM8Q1c/h7I8jZfuBf1iWkAccUOKbPFL7ayQBHzCbYNy3ZaIazrAghdQNxHSpiNuYjj9MdMq82qRpF8JQzpjxRWxJT09yrYUrQWJHmYhTJ81jgMbK/d+LE2nsdu46jOHEh/gpyaQFIEKbbqPW/YdJ7Ai/eqCTuvRG5at5pfFYctWpKnrZl1RJ5dElV+hdsrJRfPSvNOaN8MNPz89oGclFif6tvjjc8NQuywh8R0va537Z5IcGut01lc4ibEY0DGtBeXV3BLHoeAR2gBdtdDXr/44PBEnu/wzzqeTN5UOyjbsKgxa/0L86qhaesAX9eGGLZJVQdiNcTPnqfiHC0ddQ3ElZrAIu4uzNC/cLmQhFFQ4v2HsVI3+7ezy2qhlZ6ZxnuSn591bxRXIOWRB416wcIVRHMQ9DNQtUgdX5YDX1cDLQg1C+rPvNT2z8B70G4kyE4JSgg0+sA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iaNJpKOrc4bOCns4sGpel9stPUkng+elIHOGtNdS5vfHzONF+Rv+yDnpjC+huPWSGIp7/aqcb6Ajy3MeZRTCz8CKgUMTW6MPRyj5nBuCudHEN4cWQDEEaMG3/2slr7g8ywtaFamuFBoHIgqpPtnDlC7vzWk6f5GL3H4SuGFMY+vqsvAudse/3ITnib8GMwpcET0V5fNAM9mjSF7l703YRHZzV9j3/bcCtrd8A82az/l5Ax7NHXhqH6h+KNYgAnNbPVJ01ki+bofEQwBEQwNP07SL1r/YgaMSr3yiUIX2mq+n8HYdgdUzbVeJMEXq5IEs5PrXCoQE+r9gZ/VqKuFgBcl8nCfxaWSRzs2Vn4IE0Zq0gCLH/Ppt2qpocRhoj/eVzDdjApsxBhj9s3bi/FTa2jwTjlZFY8XsIdj6QUnRAFMpdBo8zsAGpmgLos8TZKYz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 21:06:37.7791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6be3137-d1b0-47b6-892b-08dec66afee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297289-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDD4D664321

From: Alejandro Lucero <alucerop@amd.com>

Use core API for safely obtain the CXL range linked to an HDM committed
by the BIOS. Map such a range for being used as the ctpio buffer.

A potential user space action through sysfs unbinding or core cxl
modules remove will trigger sfc driver device detachment, with that case
not racing with this mapping as this is done during driver probe and
therefore protected with device lock against those user space actions.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx.c     |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 90ccbe310386..578054c21e79 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_fini_io(efx);
 
 	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
 
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4d55c08cf2a1..d5766a40e2cf 100644
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
@@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
+	probe_data->cxl_pio_initialised = true;
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


