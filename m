Return-Path: <netdev+bounces-303586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vO86A7TvRGpr3goAu9opvQ
	(envelope-from <netdev+bounces-303586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:45:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532526EC54A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:45:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Ur6vx00r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303586-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303586-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7E630EF2B5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FD8423A9B;
	Wed,  1 Jul 2026 10:41:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73775421F12
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902501; cv=fail; b=BiylG2K3ZRVk/DmULtguvlGhQ6/NmsqSSFkUdmvOfltHD+/y9fURcZFBjSevvZZYo65E1bzK+UYKmsg20cgPmRxj/Q9eWQUG2vuh47QmIUfOHKtqECI2F3JGPM79oFXwwZk2gCOGT9Cd5okQ4apNN28HRwDmgIE2dBEMPSwffJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902501; c=relaxed/simple;
	bh=LE0437w9hiff5pJxWY8srYQa8H948E1zVD8uBEGzhYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5Z6KVnxEij3KQu6B79qG/yAuOjnYNxj0Z58Qr4KL4zV57rMA0LNYN0stZVBovwpOzfFQ+wMmFvDYt14wj1wVBT7kXM0D48piIzecbWKb7hIfkbd+u8reRdmoviJhxqd8ZLrCcrv7WHbVkgCGv+ecZFFKK7yCqFoRs62HLmc4xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ur6vx00r; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfXu2vAYagcUf3vPjM/r2eDO4fuwNn2xDE4YW9SpwgIvabgwdh15HJKGKvsf1k8A0eaqS0G3iYSTCRNlHhUss2yfU5gZCeyD59kySEQOH5ryo8BywORmu1zaKW1GHgvZEuvwBWEoU/qLsr3apxopwqx9GQHP7uCwAEqiToX4B7RpxWLN95PqWPQ8WmR2arJo9HUYCyKyWUqD4koDEiUYyyyRnmg3Ncb6TKWXMFZAuIpe01ndJBSEIEHhfFrDW3YbDt4aiaCIydqbbvVyd3dN36pQ0K55h3HGEX6Yohyd2EJIIe8iPrpOxLr9Jtbdaw+c8KWdsGU6yMB1d3fdm/gMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fPhsTrtjSbuaQci7J85na7oBUkU2dXZOfSBFXXIjoA=;
 b=t+7mKXiOmk62Kn8xuzYNRWKlzpPG/ZaNw6inInW+PIc905JP8UHCS3JMQIbXKt+jSMPAEwD6oZfmcBYBD2x1nzr1iXV/UXUEvq3rKQhlYQsU0g0AAeu/9k76OujbZYJDKPbmFttmpf2Vz9HODNmya8Jls2oTM8aMFXKP+LnUXZzqdjz2MOixOpQv+WQX66+APGOQeKSdPpQ79dMF1bDFpa2u5p5+4Ykd+cl1cJGTSwTPPnzqQIGHep42rdfh3gX1/V+BNgv4Ms2u360Xc3Ax5C+npFcTvPX6n466V/a8WV2ZmQ6JLZK8jSbeVm5njiLB7Q7ACpEgz2qaVywrYr74kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fPhsTrtjSbuaQci7J85na7oBUkU2dXZOfSBFXXIjoA=;
 b=Ur6vx00rYPZEawdjX9kXl5d1XZFigQevrjH2wD8eEiqDQEOHoyLsfsJazYfH4wx7LV/r9gbG9L+gHrpKw8nlFv2rcEY8uidzSOPoHPuL1CtJLXYAgFtJmpc8IdxjTZhw3xiOvtJoNP9WdOVkDdGP3YVGPW5mB3Id4BCnCoCzy1s=
Received: from MN2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:208:234::7)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:41:32 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::50) by MN2PR16CA0038.outlook.office365.com
 (2603:10b6:208:234::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:31 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH net 2/7] cxl: Support dpa without a mailbox
Date: Wed, 1 Jul 2026 12:38:00 +0100
Message-ID: <20260701113805.14072-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
References: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9b7b05-eaa0-4bef-f380-08ded75d50bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|23010399003|82310400026|3023799007|6133799003|56012099006|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	QTNRROzfxgpXZFjIiSFJLa4gl43VG+9a+5pxVHtkBUijrtDNUKFKgaAOMijPPc0mLpoymPX05978PpKiwMDip4cEvWtKgO4qHqNfn0/pMoZsMNOrAOp5LpWFAcLGB+i9OSxTEyl8V0GYrVJPs+NuRJ7b0bn34wn1R8e2Uri+Oo6yisZKP5Gw8LNW6d5qqQLm4g94Qa6pnAn2tTLZM5eJXqUedaQa6VF7MxIeIIFvOFL399k/FsrQpsRqGI4fpbJyqcmd7Gl/+1ClmorS7MUNbCInIIHQBzqZp9BBMjxN9hBtxWYdfiPkhTH5ePGJ+zMwZhCQD+AVCDPt3L8BbtfK7EtWE5Wqt6jADt9OQ2QZiKUAaCGxcEPFbGk3ex7ej1MI5wGj+22ZTiavMaysjLd3+cHC3dr5BMevuy7l8mZsJEB9bC+WxmFDd45Fk5LPYGHJ3I/keP5cZCIHuckAfvcwdlLCSWnBlIqQZxbM7jvrTVkNj24YeRhtB600DaatJYQmJQneg6Qe5bPu50ib/oo3uF9Ljcq/VQP44GqVMmK/7W1C/F1RSBOb39ULtDtVH+12xiiLSFbKOfw/lHw7Xa9v9K28x+WkI+hudQWgTagaNYmWiwa+snaztKkSJuPaQcnQiBvMV9FWUnSh2kxkjumrjYF4Wvpit4qCrWGv0qs//yU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(23010399003)(82310400026)(3023799007)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	snoJPp58dEBLExXSrFGUDAjPqiekyhGQRhZV5EgCj050vQSt7kuTyiGm8nY6A7bAKhxfckdb/DqAJN+3kjYkFOCgye9KfBRQiXeN6CcxRp1RWQTPLYMTxKplnZMa370YP5drNC1hpY3z1cXl58XYJ6LNHlsJN3Ap9VXTV5VfL73cEDkMSst3Mis+WivhxG0AyQBYzvl7WmZZ4L2fi88dWM3S0DEJze+0FleNJbZzeLx4ZlqtBIy941/z2kBQQiSH0FhgQQ+A0GT1cIHR3jwqvvtGpKE8XdTsV5S3dTagOtCnp7m5vPAT+O8CSm1ctp2P/tMLCOm9Ou+DSZnNkVfmfO+lhH4HbdowIkY/eJrQQN+Cv8wO2MSoopppJfiC8ucUh5tr6hDOE2wbyvl+rvWoB7bPQ5koE47l8uzSpYfXD+51poaj7WJOAd0RQ+k57wzc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:31.9437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9b7b05-eaa0-4bef-f380-08ded75d50bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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
	TAGGED_FROM(0.00)[bounces-303586-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:benjamin.cheatham@amd.com,m:Jonathan.Cameron@huawei.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,huawei.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,huawei.com:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 532526EC54A

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/20260629183727.51502-3-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h   |  2 ++
 drivers/cxl/core/mbox.c   | 51 +----------------------------
 drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 4 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..f7cebb026552 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -101,6 +101,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+struct cxl_memdev_state;
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..97b1e61ad018 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1152,7 +1152,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL @8.2.9.5.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1308,55 +1308,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
-{
-	int i = info->nr_partitions;
-
-	if (size == 0)
-		return;
-
-	info->part[i].range = (struct range) {
-		.start = start,
-		.end = start + size - 1,
-	};
-	info->part[i].mode = mode;
-	info->nr_partitions++;
-}
-
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
-{
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
-	int rc;
-
-	if (!cxlds->media_ready) {
-		info->size = 0;
-		return 0;
-	}
-
-	info->size = mds->total_bytes;
-
-	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
-		return 0;
-	}
-
-	rc = cxl_mem_get_partition_info(mds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
-	}
-
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
-
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 33a3d2e7b13a..2e457b1ebc7d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -594,6 +594,73 @@ bool is_cxl_memdev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
+static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+{
+	int i = info->nr_partitions;
+
+	if (size == 0)
+		return;
+
+	info->part[i].range = (struct range) {
+		.start = start,
+		.end = start + size - 1,
+	};
+	info->part[i].mode = mode;
+	info->nr_partitions++;
+}
+
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = cxlds->dev;
+	int rc;
+
+	if (!cxlds->media_ready) {
+		info->size = 0;
+		return 0;
+	}
+
+	info->size = mds->total_bytes;
+
+	if (mds->partition_align_bytes == 0) {
+		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
+		add_part(info, mds->volatile_only_bytes,
+			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		return 0;
+	}
+
+	rc = cxl_mem_get_partition_info(mds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
+
+
+/**
+ * cxl_set_capacity: initialize dpa by a driver without a mailbox.
+ *
+ * @cxlds: pointer to cxl_dev_state
+ * @capacity: device volatile memory size
+ */
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
+{
+	struct cxl_dpa_info range_info = {
+		.size = capacity,
+	};
+
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	return cxl_dpa_setup(cxlds, &range_info);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
+
 /**
  * set_exclusive_cxl_commands() - atomically disable user cxl commands
  * @mds: The device state to operate on
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 016c74fb747c..802b143de83d 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -226,4 +226,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
+
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


