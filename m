Return-Path: <netdev+bounces-299722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W8eQMY+3MGo4WgUAu9opvQ
	(envelope-from <netdev+bounces-299722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2567B68B83E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=dL3LgifP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299722-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299722-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2CE314DF0F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9451C3BD246;
	Tue, 16 Jun 2026 02:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929A373BEC
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:36:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577391; cv=fail; b=RZI4aoM2HtfD5bqMnGCuKa8UlJDbAJHzyohqs47zm5DWYcCftHwogarHGnosQOwkJ6r+FlXT44zn7+w1iq2gtEhfA+Pbx0QstHH8Uu1KOCw37Nn9+uiokMTNLOneIWPGIRc8By7IfhxYrdd6zsUOqaT9pJ1GR3EyTEfWPXPMTx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577391; c=relaxed/simple;
	bh=Uc756yA8Cjkvv8DRGAdUmpEfgQn6UYgcwCe1XekskdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1x9utJZBiSdZaEAUp9tS6va4L4yyuAVCl0lP8STnpQu9Trso5f1WtZfpKFKRNR0wGBX4dSGFeewVprL+kR/YCSWUEznYz/P9eq3x3joD0JYQG3y5Q9s+1fWBPef7Iy3fL+rwCiRs6TQM/WcDP1EvPmn/m+pLals2/oLnQTYavc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dL3LgifP; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV5ZZnGQfRg4988YgQTTT4bxRN0NyHxWjnBnhNAPapl9EeySv1XEESUxL44+6XS7Kmo7JJZw5I2ySht5uTA8uhovAdWvaKv6KJslaaZMFPeOPHeBOV3iJnGF787S7WIaa7b9HA+CCx1Q4woxdQpMxTe6zTr0ZaVjHiwc1VxSbSXqkEvVQBJ5PFVOdqW5Q9RDFD42BUPLNmCff8N/MPCnWFLwbC7QgZO+3rG8Ivpto7BZlIVkZg+hk6Zf92quI04QnD5DWeS57bhd///c1w/Rj37Uz1pRl3Yt922JSenHpkRxjtBlbaOIrn3YUFyHThsCNNUYXU6aYjgTo/6KIZpRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4yLg0sgjHjwaOUabXnGBGzUuUN09QUVBBf7A6lwyug=;
 b=snuiHAw61mVHcU4YzxZm2rEP8sgoXYlaw4Yxe/2q2h1++icQdis9P7/pVdTEHGfqSdf9APPrbJ8dMOAl/t+74tPrY305ad/P8pPjFk/6CkBP02EpXbMlGrQwl3D879HGtrsndvhb0st/nWOLw3Z6fT6X+EkYF/M018ErArTMFb3etiwlny9n9+R+gkxf5rk9ZdMdRxEQ4lC1t+eX3fbEiJ4RMxBoWIpB2oCR+BpXeb1Jmeza7zFaayBXrTYgyBtch45YMvujKFWHQ0I+7XkxHEqFcricK2jghpPfo1DzgL1VxdzhMLqAvQcfQ2K2+3pVTQ5Zcgyh1DJJJ32M47tuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4yLg0sgjHjwaOUabXnGBGzUuUN09QUVBBf7A6lwyug=;
 b=dL3LgifPz2kDGfKSNntMwisD/E/fj4VH6wW5Yhk2FhljwyFb7iFziIp5uUPRJijAo88gKkrXJdhAFZrQ7kJ/AYZNkaf7bh+jJhqSQGnHXuFDcYvtE7Yr3ejnKi2Bqr7IhB9AAdL/kLQXJmDxGwJ41egviqgdnBghcVHmmNOSWEQ=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:36:20 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::23) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 02:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 02:36:20 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 21:36:19 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v5 5/6] pds_core: add host backed memory support for firmware
Date: Tue, 16 Jun 2026 02:35:53 +0000
Message-ID: <20260616023554.258764-6-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616023554.258764-1-nikhil.rao@amd.com>
References: <20260616023554.258764-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 7901e563-2bca-40f8-73f4-08decb500cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	O8qNc/9T6tAlzH4JGEzSO4T4gIXVfak3pMOwKwfABw60CdNiJQH/SAVRN+//areViOTvsa10/k7I9yGKHmBBXj2dc0jy3QUU5yLk9VnUKjDmPvQpi8/2ph18ybM/HS58AKs3cPS6tKWYzVYkjwfh6UWnqDUkBktRZuGOqMJ8iyrIa5C7AP2l8wzSn5awSCXB88sMIq7FRwQH7MUxBTAcUqYyQCs5NmksGUCoZUnlK0YfxjOaNq1izPA03AHAfw2uNemH7I6HjEbeALw86hbbE8pYFLanBFeSq913gXmVbopSsYC+7vtp/wJtQj3+AXioOGlDBWhUuZGoHU9E07ax40WmIu/gC26CdRUSB00uYYKP+6wnu/nSI7S5o0aKY4kBK4RzwK1CGTJmMXiqGYfjKcl2ZweAF9KdeTPAAvo8U6RV7iYCuJK1gEP+QW2/OqgX+5vHL0Gsrs3FJxeFEtvjuGxk4vLXAFS3zpcJwRiU6lAPNlZRPXDU8FkUMJmYIbbB88mf7vSIBzoQVB7emr6SnhPY+ROHw4hoTJsevivSBuGeDuovUN8DALbeYDttuOUcUCbm+bdNg5dvvgudjWhsPMMgA81PU0KwTYFcIsQUGeyiu87Znewe+hrGv16loWcGwduUODjN518W2w2eX4tVHWK+vzE/EX83NzZfKhQeXV3bYM9s9uRXMFfzdB/tEVJfPL47X4gvpQeN3pfan1eCb+t/eXucqWyrZliIIEZBj/E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s3iTtmq9sDx2JwIG2SPlJblFE5LWIyKECvG1DfzyfKwtEL9jnssRja7qQ5UyrLqyWUB9OShFWtZXKEvzg8uflU76UnddQ4RU3DuUI8neh8q7H4fQceKDCOsaJGbZFfGcTwZeFsjy88RUe4yMqR1U5lBAdHLL5zUw/1IW1riUA45/dXFt1czk8J2hFltbE5DLfDG1vMLT58RUeJSIrX3tsRMHgC/vdREQgv3maujAhU9Qouy0ghpLjRC8O588OklH7/RNheAtd0CinKdcKmj8HypR00jvAGqHbcDIGLMEdzJAHDVUZDruqF+qY0eNP8ax5x4hxQb+Fr+2sYHsShPg5/6MslUGP7jQoBOrnzLG/pnXPhmDFFfVAUyZfA9+xzM8n+Y+rAs/zaH6T9G/4z+0bMoS15oA8eUzojsdiU+yPppSxJNIYyw378COYc4Oc5SY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:36:20.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7901e563-2bca-40f8-73f4-08decb500cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299722-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:Vamsi.Atluri@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2567B68B83E

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
 drivers/net/ethernet/amd/pds_core/core.h |  20 +++
 drivers/net/ethernet/amd/pds_core/main.c |   4 +-
 include/linux/pds/pds_core_if.h          |  64 +++++++++
 4 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 00164cbd9f08..511482713d15 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -487,6 +487,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -496,6 +497,7 @@ int pdsc_start(struct pdsc *pdsc)
 {
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
+	pdsc_host_mem_add(pdsc);
 
 	return 0;
 }
@@ -660,3 +662,161 @@ void pdsc_health_thread(struct work_struct *work)
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
index 73356c74bb9f..1f80219edc6a 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -5,6 +5,7 @@
 #define _PDSC_H_
 
 #include <linux/debugfs.h>
+#include <linux/mmzone.h>
 #include <net/devlink.h>
 
 #include <linux/pds/pds_common.h>
@@ -23,6 +24,10 @@
 #define PDSC_SETUP_RECOVERY	false
 #define PDSC_SETUP_INIT		true
 
+/* Use fixed 4MB max to avoid cpu_to_le32() truncation on large-page configs */
+#define PDSC_HOST_MEM_MAX_CONTIG (4 * 1024 * 1024)
+#define PDSC_HOST_MEM_MAX_COUNT  256
+
 struct pdsc_deferred_dma {
 	struct list_head list;
 	dma_addr_t dma_addr;
@@ -149,6 +154,14 @@ struct pdsc_viftype {
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
@@ -210,6 +223,9 @@ struct pdsc {
 	struct pdsc_viftype *viftype_status;
 	struct work_struct pci_reset_work;
 
+	struct pdsc_host_mem *host_mem_reqs;
+	u16 num_host_mem_reqs;
+
 	struct pds_core_component_list_info fw_components;
 };
 
@@ -287,6 +303,7 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
 void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
@@ -346,6 +363,9 @@ void pdsc_fw_down(struct pdsc *pdsc);
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
index 188b80690d1b..131c3fb20033 100644
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
@@ -838,6 +841,65 @@ struct pds_core_match_record_desc_comp {
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
@@ -861,6 +923,7 @@ union pds_core_dev_cmd {
 	struct pds_core_send_component_cmd     send_component;
 	struct pds_core_finalize_update_cmd    finalize_update;
 	struct pds_core_match_record_desc_cmd  match_record_desc;
+	struct pds_core_host_mem_cmd           host_mem;
 };
 
 /*
@@ -886,6 +949,7 @@ union pds_core_dev_comp {
 	struct pds_core_send_component_comp     send_component;
 	struct pds_core_finalize_update_comp    finalize_update;
 	struct pds_core_match_record_desc_comp  match_record_desc;
+	struct pds_core_host_mem_comp           host_mem;
 };
 
 /**
-- 
2.43.0


