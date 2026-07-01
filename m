Return-Path: <netdev+bounces-303584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 72DAJZfvRGpO3goAu9opvQ
	(envelope-from <netdev+bounces-303584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2AC6EC51C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=5ZABdzJx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303584-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303584-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1743630DAAE3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3637423A8A;
	Wed,  1 Jul 2026 10:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145441931D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902499; cv=fail; b=FrNvkVCbxl9neN/EXSkKsZFBPQJj+3ti6KeC184Tx9h9DRzqdoFjLia7/UYtqCRtV5sxgaA3ZaNFx8CizEoTjE/bfv3Vh0ciNNKE6j7xOQEnEAXqMjqK1UcYPmQuh7uyPlb1yzKo3/7u3qC14F2RZDEUWBC7EHm8n7NkclrjkgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902499; c=relaxed/simple;
	bh=om+pQDXzQbXCBNZSDFt7mAajCCPV9zaTgSxKkftMxak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYxKvMlhhxr6B3bVY/IejG9zvLIL+2zFhHVJXXyrz2Y5UmwI49QIil57ouFbR75zvimfSs+Zsv1W+KOOZMqKO4ZTunrggLe301mFXnwvD3naRKutnlhaoGdzTlgHJXJjJaVI04AtUQ3zr/ZnB4oMHSJbtdX9LcgAqRpMGvcZQzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ZABdzJx; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeztY2mcswaXaWssMJyO7GnPBHDUYF53Sh2RD05IctDUZZw40VLkfakQqWyt2GMtjtIPDl1WDvFr04LghaPpT+mIMkmC1zyYT2HKoaiECHOpZAUlrFFRNYnRIO/Ma78vWho/SjAHsLAbaDFg8Hqd0yFBwPW3A2wM6P3akrk916FfMpN9l9YBz6vhfO6gLCGVk7YCRZb25GNk4lT13NDfUluDOMFru5WvdvavGbo9R0FhodIr0dFsisslaFL/TE4jxsrzxn7cz67o75fJUjvQTNHV7ANsV1RlZd3siC3u1ORM74wnRBYhcZ2yCPgtgw1Ly5NMvyoVbxJptmL+z4s7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjwPbf+ZjHUoOE+3JKQHpHlnlUJD7lxd+0DKXUOsVFE=;
 b=IV3T+VYwl4zOxeFGNSdO053CEhIrshq5tnS447qzQ3xjz+c19JT1G9idl0gjZokZ9y2/TJN7CUGeCJwKy8uG1lLBIi5v8z7O2vtcmoGfEJ6faOLWZS+PI+KuXQnEnE5zqX2RjGOmbCfPgsq5x9AsigfXaLPe7A02+ZgJ6ujFtcfjUhApJgzhOUei8q8pZM4FCewS9UvCcWsK5F4zZWpOkgNzRFOWIZ8xDACwde6iupPSLa6L4OlVHyH7BLLaaCar6lDyiadtwa2r+qbMJuGnJSfX/OrqV5bUFsRH37Ps5eRhqWjmBCVuUR90Sb8b7Wd2AtlqkLJ5hZ1bNCeR9O579g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjwPbf+ZjHUoOE+3JKQHpHlnlUJD7lxd+0DKXUOsVFE=;
 b=5ZABdzJx24vHk5OQ/ulssKkVWhMM3sM8wPiyxNeP0E7a1nw/MGk4ZL+9QCkHQ++ApvSUxOU7LASgPjLzDmXBJtSh8FnEiHD0pBpask6xhwnNiNc44i07UlqlO7/FtmMezPPGhjxgT9Fzw+/kp7Ukf/imY7OVMIW6nMh3f9g1Cj4=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by CH8PR12MB9813.namprd12.prod.outlook.com (2603:10b6:610:260::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 10:41:35 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::80) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 10:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:41:34 -0700
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH net 4/7] sfc: Map cxl regs
Date: Wed, 1 Jul 2026 12:38:02 +0100
Message-ID: <20260701113805.14072-5-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CH8PR12MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b8c452-a1bb-4d18-9af2-08ded75d52bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|13003099007|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	JTjQqYgljMeNIku9Rucc698I33wNR3ogYjXH6H5DGpnk0/jNlMjFX6K9eq71m2pcmOXC/yweZqnDJfV/aknYqJU6TL2HaBpt+D8xTgdwzy708GXpbI1Nx5XRjEIU0LLYWZHCfbEOngyR9cW9wSiW9pGfq2hVvqdjIRxnZ+LWqhvS5knywlB9bf2TimovkKTTr8O2zOAVP8UutIbRCC+YIFDNL2g4b+j4tw6NZbK4BQor6xuzv4C2TKvQW/0gObLCswhmrmWmk5ptVVSTkaKzk43XIQLN337khraTRjqt4FQmaHWcnQDiHP2A+bFvkCKl5ambDwP0U/BjvklvZm6oqCgT81C64Y/BwIUWpqT1pv0aLI4JpICeQYkgkbI++DYYph2XN8you7aUxSehhq7t2eRPNxO3ToVh7sxpn6jFkneJ65tOTU6PNK3BuCwYSi1hQiE2XmT8EAcSEyzh1E9h8vXNB6iktnehRaPXbkyfHe2kk7npH+1UG0bGaId4y/QbhGHJhQEnoOtI2LXo327zuYJluftOTIhwfmGR5vBR16zcV/KG9VfoXWnMSfIy+xKpUsdin8G8rpy/Jk+uUrHQw80tEaZiTkuH/HJfo61XjJCvfB+povAcSk5qcPldxtQLfKLP1HBwo5QAfnJJKFsA7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qHkOK32ic6fHEbLdNLGvErFN7CHqLnkE92Q7G01srluo80Jb21t2euqcnZErgV3yAfn9/ZKXAvQhh3Fw5WTE+5MjQ8wRbznASqlPAiNzzQ93FCedS62smqXFRwAM5eGbW77YcUmnnAB+XH7URblfZR1+YdVms2Gt/XtGPEpAZAcmz2dHWAy6sPJJkkG5JIr8Q2yjP3M1AlZChpuanJ+Qh1zF9NO6Rc7CleUBvfI23bgFmMl66fv8kr58nofnHk98H19VqJb9eErpEpaWM5mTtlL4LSsl0WjWx/EtQh8p6WzWAok6rMltEy/CkXrEy94rYlLIDnh8h1l9ctKRFbHr8XFZX/q5hC/fBMeyeGtlmQ3fnF5LVAGT7z+R58H0VeLVQh3nsoKXqDFMNMQxs6y8fi/B8v8xzluJIO4KdIuE/dARc+qtNZoOshueIRHgkTEz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:35.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b8c452-a1bb-4d18-9af2-08ded75d52bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9813
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
	TAGGED_FROM(0.00)[bounces-303584-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:Jonathan.Cameron@huawei.com,m:benjamin.cheatham@amd.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,huawei.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,huawei.com:email,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE2AC6EC51C

From: Alejandro Lucero <alucerop@amd.com>

Use cxl core functions for discovering and mapping CXL device registers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/20260630151346.31201-3-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index be252af972ab..704b0ebae937 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -7,6 +7,8 @@
 
 #include <linux/pci.h>
 
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
 
@@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	/* Is the device configured with and using CXL? */
 	if (!pcie_is_cxl(pci_dev))
@@ -42,6 +45,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		pci_err(pci_dev, "No component registers\n");
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pci_dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
+		pci_err(pci_dev, "Expected RAS component register not found\n");
+		return -ENODEV;
+	}
+
+	/* Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


