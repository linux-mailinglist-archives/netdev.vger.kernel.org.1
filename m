Return-Path: <netdev+bounces-305998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +2GpDn7ATmrhTQIAu9opvQ
	(envelope-from <netdev+bounces-305998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:26:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587C72A848
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:26:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=rg9jQlcc;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305998-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305998-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8CF30C336A
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32573F4DF5;
	Wed,  8 Jul 2026 21:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A973F4DCE
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:23:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545813; cv=fail; b=gLEmAqeH9iC/Vq57YQ0ZtUf+r+mMilvw0eoCDmhHf2jX2ZkakIHRUWzx+b+pnB+I6NgUEjKVnkhADtZlE9U2xheLyt/ScJpPMfnfDFuvkk2StOmkUgYxYt5+gvM5CWA1VRsCKp2OsFgEldAO9qMW8MqW3Zk8viOeyqw3ode4+VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545813; c=relaxed/simple;
	bh=KVtJLt3kTukp+rS8+KnOHwb9S1RuN2pUzAN4k5ZGNT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGl5Vix8QpDWYvAgX1miAOQEXu/h+ERsyK+DvacgrtmLeL9cckSLz2JvV9ze/PKkqKmaKA2g0ueWadQAax27rEDCqGQq58Pk+X0WrKzhgKJ1dEmFmFzOf67kmacN94EV/rj/4dFhtX+o6iKuMQQgkrLf38oyz9iExRnWd3rAGU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rg9jQlcc; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb19wjsxrCF8cxk+1+geBt18KpT16A50Nea/g0GIoCumDU2tomCQqmhgOd2ra8pkYnMp6boX8FnXtKqlZsiBbaNFXVnSD7dLzSz0KbDT8jWDHviPfXWKtVv8VEb5by5QSqstdf5XbWQ30ELNryQtcmasL8rODOHIjyYmWg5CB3Y22G++EfqeE4yq07K7Vn7vY9YhrblCx1vyQMD507W7P4NObuYIKmbiVn8JXIvAH+AFswtYl63B8eTOPOH4CLIllmox+++liBeTqHE9ULXi/mhZ0dx0EPmHNOS8Yv1yUpBLbkx/OAnu/wDfYUtCfJfERFXIr1TZWiqj+Smj93fI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxWHW1zPqeBq5KuYDdmIcmuokned7jbVwKfw4R6WOvA=;
 b=qY9RUcqlF+hNmDx4jwcs6iykXUO9ZJVLiFTeOKLPFJNPm7CgOXKpeBzUax2rS3iDMxGzEIppetP8cZ58ESx36I0e4Jeddya0uBtaHHf4FCSTK+z/QU70zUlUef+QhXj9iWZDm4bo+BkIqZ9hKTdPMy+3dN495aOGtXzBo8JPl6M6lJ929MLx+LYoRv0fvtgvjD5iMvmlh5sWK2A19QZ7yVjNyShtr6sz1LE+2/JHUr7H/+w9WlHeuziuJJaYybuSujCl4V472criMbUh7vyt8bzbvRM+UpWF1Vo+LYMvHOPhAcgCm9xO/QXVsY/tgqothMvymkTtCJjUC3Z1hOS7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxWHW1zPqeBq5KuYDdmIcmuokned7jbVwKfw4R6WOvA=;
 b=rg9jQlccCIfZAsX4X25Nn+KMKWJTL7lo27vhCXepCQEpcDeDTwDKgNFVx0nEDIPIJJiILGsXf4UCCZemO3jouF/awVgKWZBS36kRu0C5qxQVmaZUqkqkEUEASjrurxm2jlrVmq5tZDY8XeI2pqq4n6wp6x8EerBqEFcuowOwPfs=
Received: from CH2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:610:60::15)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 21:23:24 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::6b) by CH2PR14CA0005.outlook.office365.com
 (2603:10b6:610:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:23:24 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:23:22 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
Subject: [PATCH 5/6] pds_core: add host backed memory support for firmware
Date: Wed, 8 Jul 2026 21:22:21 +0000
Message-ID: <20260708212222.296202-6-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708212222.296202-1-nikhil.rao@amd.com>
References: <20260708212222.296202-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f17c312-9885-448a-c490-08dedd3724e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qU1HnERkIpIcQcqtNg+6igdkKjzNl2H5VxzEZTZevIubU6f7eb30RO5KECDUGBD6EmsVa+vRpmGK7cQjzfd5ojnIuyiCYL4+cfT42hRPMeansGjwXgCKpRFSSueG0tYf3F7STwAFPhuoQeHaUz6BBYe1xt4GlBOe9c3Pq8R+vS/7cFRfvFy9J5m2pakxn9rl1ZybN1x4Kr4ZFs00cF193Fe9RM3lUTFTLqqrmLr8nlWiSwKDt1nbZj34ESRR17q19O8T1BUTFh1svjRoq8hYD1xwmaBM423q5/Vnw2SRk2ts1ImudCJjRNpwnDc1w1h/+kphhn1H4ebvs+3s96xH4ktHlXAyZ+mQisBMGmM31hdw9gtOz4T6db34PNhqjQ+fqpRoQfDMikUiIf8/iiJnPzr9h3EUH2opQsUkklrxYQKB94YhCJ+nY3Z+MZXNtQFptXt+6RKqit7sztY0r5oIEYWr/csUilPyIinG5aZn1Wx4lNlV9AL/RHaOWrxa+qtZMHhunAJRD3VFNJRjxo3+j1gkyR60vGlF0KXF07ZH9a/oHkft2xgHYMUhrY7W6gmxdotgO81dt3EXq1KTokUmJghJH8HRNpY5mxwBlZzh7TR/z3xodcQvcLDZXjQtRJRJI0gSwR1ZXRCEYPu/UEppIkYsm2WaEAUtZydWsY9T7mZP5+mdwTHalkHE7tqbjy0UElF4Zy/QTAKy10Lm09drRQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kjynA3SwSWdBQdQiRa3bmxKXwiyiymRlYWMld1kX7hhlfD36W7TaBCQrtPRZatqhKcaMiB3YQzu/anN9gayqIy6pSxU8BsRsS3Nbmr63pSrjx8tMsWhJgiWirq2XQ6WBSdH+vpyBoV36gDstiRs+xCIvm4sbq7OnxDNHdthR0pASHzrKZd34Pzp7TTxSoV/T77EtWZj1B2uLzE+62z8ZpUH6V0ei+I5xXbc/suhqKBSKlGzLdBamOnBtkS6ukX5Cl04yPj5CnfRhtGgljX3ibytwgPDhBhIBuDY0sjFF21D2C96h09SH5ifkZENxyo89hO7rp/ukYi1kOM7B20lAfgTp9B564uDXzJ6XRGJ0E4pXme1NFLaS8hLBg74tm02vvv62M2mT84Ixu+Lc0mJbOMfjjItpdyFgSuyXeABVW6jdUwAfoBFApJL39bqOsxQk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:23:24.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f17c312-9885-448a-c490-08dedd3724e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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
	TAGGED_FROM(0.00)[bounces-305998-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8587C72A848

Some newer AMD/Pensando cards have minimal memory and there are cases
where components, specifically in the control plane, need more memory.
This series adds support for host backed DMA memory that can be used
by the firmware for the previously mentioned cases.

Host memory allocation is best-effort: if some allocations fail, the
driver continues with whatever succeeded. Firmware gracefully degrades
when less memory is available than requested.

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
index a7a0bcf98ed3..356a69c895b6 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -500,6 +500,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -509,6 +510,7 @@ int pdsc_start(struct pdsc *pdsc)
 {
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
+	pdsc_host_mem_add(pdsc);
 
 	return 0;
 }
@@ -673,3 +675,161 @@ void pdsc_health_thread(struct work_struct *work)
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
index 17b64177871a..bb619f360f3c 100644
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


