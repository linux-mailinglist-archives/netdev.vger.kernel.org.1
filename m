Return-Path: <netdev+bounces-302847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id no07Ed/5Qmo6LAoAu9opvQ
	(envelope-from <netdev+bounces-302847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A973E6DF22D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:03:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=FpWOYH15;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302847-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C283041480
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B13BB134;
	Mon, 29 Jun 2026 23:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883622744F
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:02:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774161; cv=fail; b=RVC3lXne6fC4UPkROQgzERQBdZKvRZgIl/97kaxxlT6P9NvaciBAQy9Tq4gUmmFw2+m9cDb+kZwWuv8oqnfWLv1YmsytBsC1j+Wyr6EheycDyplP1D+968sB6Qas0SE1ufVTO6Z/LMR5TKacE6IVCaMzQrfhgv8NS2jKW/QZDKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774161; c=relaxed/simple;
	bh=irboITYDJP3BjbfOdIB6mClWnyudpss9PdOV/0LIGJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loLVb2qizeNHVP2mqfRuuCNXk0bd5lxWG+is6tljbU5dow6CrkyqU+UF5uJwNo9Ti9lTTbkMJNDWqMBKW1qPabseVePPABq24nbvpyAbcLMr5YdFXxFswfqF6xzB8EJD0O5Km86CpYuwsidN2tilmAIQXdgd1LK9IVxZV3pLKlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FpWOYH15; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffnF6nfYuhJL/3K02fUq4ZgzjB6MichaGGpwWc9ioPc0E8J2a6DRNwL4FRVt6ClOZ7PVcBaCsqbnkZXHD1xpnYaY9wJwaDKQZdlhccz/uzF7MSuIBp3uXyMRgMOLEpkMwF4cxZxCE8w5lIblYkaamnHlL7f2rM2CdzIN/faIScWF5S1GYLsx4HDlp1YBh98rcCdbYyOJ024B8Ql0uizFrX0wsy9ibWqriQF4rG/SeCWb40P1TkZjZePKw3pwK+Z1LOf+i6IOTi6752vsBR436IEYQ6U/eqt3pRKH3GjP0zEIwepxpnekqRJkzY3lXvdp8JUfEvANx8eorZXMYM774g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMZflWaES1qOfbfCCQCf7H2IoQTh6EuYZLNrHIT27dE=;
 b=HTX4Ote+pg6N3CZUJEzshrGkJcrzfErloI4g0E/GVDps8Fgj0xFR9bfBTzpczgZL5Gj/sqHajA1A3UdwxxaGxdDhE/9CUL9JiHufThD5EhTZOQaNlxJRmsRlI9IG1ewRazGGNuvE1IYmRnhBa7ao+oDoiSsznSUlrYmWJKZAsQShtKGiZEgICtmOjZxOgv/qUQxVgTjJGLgU2sGaxjnYNP2Rbu3mlRzr230X0iA4d17DxDGt8cnlwBTiofr7v/OtgM926Z89V23qzTzjJbyJRvYGVxuPxuMq072Qfw9y+QxbHatcThby0TplWnyvYrXBaNiewFDeO5YIp/BovrDeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMZflWaES1qOfbfCCQCf7H2IoQTh6EuYZLNrHIT27dE=;
 b=FpWOYH15UT9clJOSRTFCvud/zBaabVLKkbqlU92YrKyHmDhMcwj/qcpUbJmXnUdQU9i7xlT6p85E6hH9SOwW3WL8O3GqL/t+bMzWfOS2xh7tOqOkwoKw+46+/C0Czq5pwLuyhEx5Pziyz6Ya2wwrz2e8X2tiDVoW8Qe+zJoIDSk=
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 23:02:32 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::67) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 23:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 23:02:32 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 18:02:31 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v6 5/6] pds_core: add host backed memory support for firmware
Date: Mon, 29 Jun 2026 23:01:59 +0000
Message-ID: <20260629230200.82092-6-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629230200.82092-1-nikhil.rao@amd.com>
References: <20260629230200.82092-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f14e8c-1474-41d5-1f10-08ded632803e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jFud2JnRQtlamXdgb9YlhZ/AbL7+Vtx6Yb7JGvp2eGs1dh4DKAgJNl9gSoefBEciulhgqTk+pAlMeJ+r7sKDhKzhv+gRy6LbuoHHbKh8xsmeE/Fp8rjAkTtREPXGBg5ad69KoIB5l/RFfMiUpRUcmmqcI+XU+15AF5qkyIcyW25c8dnt1jF6PmECCJZimMa4xAjQR8ArAhEV/bo1KYWO9iPorz6UuQTvjTxfb1sJNQVvUgMGfkhTEBdcu7mDO/SiYU+iTeciN7s2tPu2k68BLLdb7292NKg8nGVOEo7eyqZGvDRipzwqUCEGrua8bPG8zwL9staMzgHb1o3V+sTHGB3CamHdgrMOrZOviVDqvSReu9Q7UFYYai8wijWTwJG24L1TNI9muyNCM1vgvN37ajBUYz8yg8Y7bbnG/S4eq5Yw/C6UPXhNnaNUnJ26gGEn57nCw4y1+JyB4H32VL0bWtTOlYTxxYR8/VLGbsXp0EUhzA4wWTemro/4iO6F2CFQZRFOTJpORxwalcXxxcR4CXpQ7mWFB2FM9QPvqsRK54fdBa0yT4q5+0mkBcRZRytJ3Phdd3hKWEky+iowKDidJl7hccnDk4rvWW2XQ6XX63I4KacuVXVo9vRU+SBvjLNiJ5fiIQCZi5QeURvNbMISz446IJ+rpb4i3Zpl3gMWldMVG6jO5+E7/DYjNnQjqkjbJAIPilb9J8VIiYS9aRc/0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oKkLY0B0odjFVZtNrOlssiB+fXYfEyCUidqeC+doKjNAYtDBNVnA6JH+cM42RpxvsMyf91I8SPdNL3Z9aIw41/knpQjuiWJvOmeBUDqzrhL1p3dRAavI8UXw+OYCFWaYPJ2pH39csZc+UJsMicJvfsDGDbg/+Ena1+Tv6zlue6AB9zOtqLVNG0kKocmaoH3800FDuXnnXNYcrpx3fPHEAHGcq8X3kccPRpvmEhCoggpaxOsIuXpSpTHgF1BGhPfj67XD+c/KkIEZebiL2IQAwKfnRkLVojXfCn2FSWKgJ0KMIintzlgHVEGHsEg+oTuctPB8dFSImmrnSQmB0Pc1u6hoPx/ljcohYjOl7ekgicSVe4sTX1NT6+q5ljL4utbNmDFlZfHiI5L9az0BR/BSf8eNR7n0gE3G6/CehbFm7xogMRrh3VMViq9Rl+7ycSqJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:02:32.0648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f14e8c-1474-41d5-1f10-08ded632803e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302847-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:Vamsi.Atluri@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A973E6DF22D

From: Vamsi Atluri <Vamsi.Atluri@amd.com>

Some newer AMD/Pensando cards have minimal memory and there are cases
where components, specifically in the control plane, need more memory.
This series adds support for host backed DMA memory that can be used
by the firmware for the previously mentioned cases.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 160 +++++++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/core.h |  22 ++++
 drivers/net/ethernet/amd/pds_core/main.c |   4 +-
 include/linux/pds/pds_core_if.h          |  64 +++++++++
 4 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 4d9ab8b74ec6..be8d802ca921 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -491,6 +491,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -500,6 +501,7 @@ int pdsc_start(struct pdsc *pdsc)
 {
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
+	pdsc_host_mem_add(pdsc);
 
 	return 0;
 }
@@ -664,3 +666,161 @@ void pdsc_health_thread(struct work_struct *work)
 out_unlock:
 	mutex_unlock(&pdsc->config_lock);
 }
+
+static void pdsc_host_mem_del_one(struct pdsc *pdsc, u16 tag, u8 reason)
+{
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {
+		.host_mem.opcode = PDS_CORE_CMD_HOST_MEM,
+		.host_mem.oper = PDS_CORE_HOST_MEM_DEL,
+		.host_mem.tag = cpu_to_le16(tag),
+		.host_mem.reason = reason,
+	};
+
+	dev_dbg(pdsc->dev, "Sending devcmd for mem del tag %d\n", tag);
+	pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+}
+
+static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
+{
+	struct pdsc_host_mem *hm = &pdsc->host_mem_reqs[index];
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {};
+	int err;
+
+	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
+	cmd.host_mem.oper = PDS_CORE_HOST_MEM_QUERY;
+	cmd.host_mem.index = cpu_to_le16(index);
+	dev_dbg(pdsc->dev, "Sending devcmd for mem query index %d\n", index);
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem query failed err %d status %d\n",
+			err, comp.status);
+		return err ? err : -EIO;
+	}
+	hm->size = le32_to_cpu(comp.host_mem.size);
+	hm->tag = le16_to_cpu(comp.host_mem.tag);
+	dev_dbg(pdsc->dev, "mem query returned size %d tag %d\n",
+		hm->size, hm->tag);
+
+	if (!hm->size || hm->size > PDSC_HOST_MEM_MAX_CONTIG) {
+		dev_err(pdsc->dev, "invalid size %d for tag %d\n",
+			hm->size, hm->tag);
+		err = -EINVAL;
+		goto err_del;
+	}
+
+	hm->order = get_order(hm->size);
+	hm->pg = alloc_pages(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN, hm->order);
+	if (!hm->pg) {
+		dev_warn(pdsc->dev, "alloc order %d failed for tag %d\n",
+			 hm->order, hm->tag);
+		err = -ENOMEM;
+		goto err_del;
+	}
+
+	hm->pa = dma_map_page(pdsc->dev, hm->pg, 0, hm->size,
+			      DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(pdsc->dev, hm->pa)) {
+		dev_err(pdsc->dev, "dma map failed for tag %d size %d\n",
+			hm->tag, hm->size);
+		__free_pages(hm->pg, hm->order);
+		hm->pg = NULL;
+		err = -EIO;
+		goto err_del;
+	}
+
+	/* Track this allocation so pdsc_host_mem_free() can clean it up */
+	pdsc->num_host_mem_reqs++;
+
+	memset(&cmd, 0, sizeof(cmd));
+	memset(&comp, 0, sizeof(comp));
+	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
+	cmd.host_mem.oper = PDS_CORE_HOST_MEM_ADD;
+	cmd.host_mem.tag = cpu_to_le16(hm->tag);
+	cmd.host_mem.size = cpu_to_le32(hm->size);
+	cmd.host_mem.buf_pa = cpu_to_le64(hm->pa);
+
+	dev_dbg(pdsc->dev, "Sending devcmd for mem add tag %d size %d pa %pad\n",
+		hm->tag, hm->size, &hm->pa);
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
+			err, comp.status, hm->tag);
+		err = err ? err : -EIO;
+		goto err_del;
+	}
+	dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
+
+	return 0;
+
+err_del:
+	/* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
+	pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
+	return err;
+}
+
+void pdsc_host_mem_add(struct pdsc *pdsc)
+{
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {};
+	u16 count;
+	int err;
+	int i;
+
+	if (!(pdsc->dev_ident.capabilities &
+	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
+	cmd.host_mem.oper = PDS_CORE_HOST_MEM_GET_COUNT;
+	cmd.host_mem.index = cpu_to_le16(PDSC_HOST_MEM_MAX_COUNT);
+	cmd.host_mem.max_contig = cpu_to_le32(PDSC_HOST_MEM_MAX_CONTIG);
+	dev_dbg(pdsc->dev, "Sending devcmd for mem get count max_contig %u\n",
+		PDSC_HOST_MEM_MAX_CONTIG);
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem get count failed err %d status %d\n",
+			err, comp.status);
+		return;
+	}
+
+	count = min(le16_to_cpu(comp.host_mem.count),
+		    PDSC_HOST_MEM_MAX_COUNT);
+	dev_dbg(pdsc->dev, "mem get count returned count %d\n", count);
+	if (count == 0)
+		return;
+
+	pdsc->host_mem_reqs = kzalloc_objs(*pdsc->host_mem_reqs, count,
+					   GFP_KERNEL);
+	if (!pdsc->host_mem_reqs) {
+		dev_err(pdsc->dev, "failed to alloc host_mem_reqs array\n");
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		err = pdsc_host_mem_add_one(pdsc, i);
+		if (err)
+			break;
+	}
+}
+
+void pdsc_host_mem_free(struct pdsc *pdsc)
+{
+	int i;
+
+	if (!pdsc->host_mem_reqs)
+		return;
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
+			       pdsc->host_mem_reqs[i].size,
+			       DMA_BIDIRECTIONAL);
+		__free_pages(pdsc->host_mem_reqs[i].pg,
+			     pdsc->host_mem_reqs[i].order);
+	}
+
+	kfree(pdsc->host_mem_reqs);
+	pdsc->host_mem_reqs = NULL;
+	pdsc->num_host_mem_reqs = 0;
+}
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 73356c74bb9f..085f2e988aa0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -5,6 +5,7 @@
 #define _PDSC_H_
 
 #include <linux/debugfs.h>
+#include <linux/mmzone.h>
 #include <net/devlink.h>
 
 #include <linux/pds/pds_common.h>
@@ -23,6 +24,12 @@
 #define PDSC_SETUP_RECOVERY	false
 #define PDSC_SETUP_INIT		true
 
+/* Use fixed 4MB instead of PAGE_SIZE << MAX_PAGE_ORDER to avoid
+ * cpu_to_le32() truncation on large-page configs
+ */
+#define PDSC_HOST_MEM_MAX_CONTIG (4 * 1024 * 1024)
+#define PDSC_HOST_MEM_MAX_COUNT  256
+
 struct pdsc_deferred_dma {
 	struct list_head list;
 	dma_addr_t dma_addr;
@@ -149,6 +156,14 @@ struct pdsc_viftype {
 	struct pds_auxiliary_dev *padev;
 };
 
+struct pdsc_host_mem {
+	u32 size;
+	u16 tag;
+	u8 order;
+	struct page *pg;
+	dma_addr_t pa;
+};
+
 /* No state flags set means we are in a steady running state */
 enum pdsc_state_flags {
 	PDSC_S_FW_DEAD,		    /* stopped, wait on startup or recovery */
@@ -210,6 +225,9 @@ struct pdsc {
 	struct pdsc_viftype *viftype_status;
 	struct work_struct pci_reset_work;
 
+	struct pdsc_host_mem *host_mem_reqs;
+	u16 num_host_mem_reqs;
+
 	struct pds_core_component_list_info fw_components;
 };
 
@@ -287,6 +305,7 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
 void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
@@ -346,6 +365,9 @@ void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
 void pdsc_pci_reset_thread(struct work_struct *work);
 
+void pdsc_host_mem_add(struct pdsc *pdsc);
+void pdsc_host_mem_free(struct pdsc *pdsc);
+
 void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
 			   dma_addr_t dma_addr, void *va, size_t size,
 			   enum dma_data_direction dir);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 02ff5e51f617..a6f327f1c1d5 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -21,6 +21,8 @@ static const struct pci_device_id pdsc_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, pdsc_id_table);
 
+static void pdsc_stop_health_thread(struct pdsc *pdsc);
+
 static void pdsc_wdtimer_cb(struct timer_list *t)
 {
 	struct pdsc *pdsc = timer_container_of(pdsc, t, wdtimer);
@@ -437,7 +439,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_sriov_configure(pdev, 0);
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
-		timer_shutdown_sync(&pdsc->wdtimer);
+		pdsc_stop_health_thread(pdsc);
 		if (pdsc->wq)
 			destroy_workqueue(pdsc->wq);
 
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 5a1fafaccf20..901e1e628f89 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -46,6 +46,7 @@ enum pds_core_cmd_opcode {
 	PDS_CORE_CMD_SEND_COMPONENT	= 9,
 	PDS_CORE_CMD_FINALIZE_UPDATE	= 10,
 	PDS_CORE_CMD_MATCH_RECORD_DESC	= 11,
+	PDS_CORE_CMD_HOST_MEM		= 12,
 
 	/* SR/IOV commands */
 	PDS_CORE_CMD_VF_GETATTR		= 60,
@@ -110,9 +111,11 @@ struct pds_core_drv_identity {
 /**
  * enum pds_core_dev_capability - Device capabilities
  * @PDS_CORE_DEV_CAP_PLDM_FW_UPDATE: Device only supports FW update via PLDM
+ * @PDS_CORE_DEV_CAP_HOST_MEM: Device supports host memory for fw use
  */
 enum pds_core_dev_capability {
 	PDS_CORE_DEV_CAP_PLDM_FW_UPDATE = BIT(0),
+	PDS_CORE_DEV_CAP_HOST_MEM = BIT(1),
 };
 
 #define PDS_DEV_TYPE_MAX	16
@@ -837,6 +840,65 @@ struct pds_core_match_record_desc_comp {
 	u8 rsvd;
 };
 
+/**
+ * enum pds_core_host_mem_oper - HOST_MEM sub-operations
+ * @PDS_CORE_HOST_MEM_GET_COUNT: Query number of memory requests
+ * @PDS_CORE_HOST_MEM_QUERY:     Query details of a memory request
+ * @PDS_CORE_HOST_MEM_ADD:       Provide allocated memory to firmware
+ * @PDS_CORE_HOST_MEM_DEL:       Notify firmware of memory deallocation
+ */
+enum pds_core_host_mem_oper {
+	PDS_CORE_HOST_MEM_GET_COUNT	= 0,
+	PDS_CORE_HOST_MEM_QUERY		= 1,
+	PDS_CORE_HOST_MEM_ADD		= 2,
+	PDS_CORE_HOST_MEM_DEL		= 3,
+};
+
+/**
+ * struct pds_core_host_mem_cmd - HOST_MEM command
+ * @opcode:     Opcode PDS_CORE_CMD_HOST_MEM
+ * @oper:       Operation (enum pds_core_host_mem_oper)
+ * @index:      Memory request index (GET_COUNT: max_count, QUERY: index)
+ * @tag:        Tag for this memory request (ADD/DEL)
+ * @reason:     Reason for deletion (DEL only)
+ * @rsvd:       Reserved
+ * @max_contig: Maximum contiguous memory size (GET_COUNT only)
+ * @size:       Size of memory in bytes (ADD only)
+ * @buf_pa:     DMA address of memory (ADD only)
+ *
+ * Unified command for all host memory operations. Fields are reused
+ * across operations to minimize opcode space usage.
+ */
+struct pds_core_host_mem_cmd {
+	u8     opcode;
+	u8     oper;
+	__le16 index;
+	__le16 tag;
+	u8     reason;
+	u8     rsvd;
+	__le32 max_contig;
+	__le32 size;
+	__le64 buf_pa;
+};
+
+/**
+ * struct pds_core_host_mem_comp - HOST_MEM completion
+ * @status:       Status of the command (enum pds_core_status_code)
+ * @oper:         Operation that was performed
+ * @count:        Number of memory requests (GET_COUNT)
+ * @size:         Size of memory request in bytes (QUERY)
+ * @tag:          Tag for this memory request (QUERY/DEL)
+ * @rsvd:         Reserved
+ */
+struct pds_core_host_mem_comp {
+	u8     status;
+	u8     oper;
+	__le16 count;
+	__le32 size;
+	__le16 tag;
+	u8     rsvd[6];
+};
+
 /*
  * union pds_core_dev_cmd - Overlay of core device command structures
  */
@@ -860,6 +922,7 @@ union pds_core_dev_cmd {
 	struct pds_core_send_component_cmd     send_component;
 	struct pds_core_finalize_update_cmd    finalize_update;
 	struct pds_core_match_record_desc_cmd  match_record_desc;
+	struct pds_core_host_mem_cmd           host_mem;
 };
 
 /*
@@ -885,6 +948,7 @@ union pds_core_dev_comp {
 	struct pds_core_send_component_comp     send_component;
 	struct pds_core_finalize_update_comp    finalize_update;
 	struct pds_core_match_record_desc_comp  match_record_desc;
+	struct pds_core_host_mem_comp           host_mem;
 };
 
 /**
-- 
2.43.0


