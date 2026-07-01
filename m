Return-Path: <netdev+bounces-303587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pfpPC8fvRGpx3goAu9opvQ
	(envelope-from <netdev+bounces-303587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:45:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B3B6EC55B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:45:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=47HS0+3Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303587-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303587-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB295301CFAB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55314192F2;
	Wed,  1 Jul 2026 10:41:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E9367B88
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902503; cv=fail; b=KnTB4qrFhNhCsJd9LdY4PP6K0/Gy4R2qzHvIQ/l61X6ih3Hl5Mocn3hZ13qtqSHtRvF5KONTT6uBFolz2ePncndfzMfVI8qCeM7wpwNKZOXuSRSd5u6Pzw57Ju7dgiZw55eWALzdMS2z3BOHyIfRxuC43hFMcUUg8Kf2yY8BgqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902503; c=relaxed/simple;
	bh=5M0cz0NneNNQJvlp1Akp4pj2y3Ofvq/vZ8E5fypnXZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH7Juc4wQXvH4mDAI35z66Uy3rIjBA1H1n1rYJwa6eFv3DXjgbLI3lNBzY1e5ZNUGHeGD8T7zXq07j9cL9m9NEtWtekPuN4i8uD5+izWhhsXrpEErrgLnUM6/SyXLLmx6LH8cj8KhhvLhKjFO5mEMjf4sfZNT2aEx+76EBCGmts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=47HS0+3Z; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es6drqDJVWdnGs0qVX/mgUMYtbTdecKZWDYRi5GQXMfR10bMOCUKLkTs2tWwQXWaOG5UnQHHGEdDnG38mPX8hJkg/4fzE55kY40RBlxtgi8vS3ZGkRWJ5EoTAlv5Ufmta6dh/xXtifikNktqzxPtMnCQqT+MS5HlezkrOya4Mk59rJFGfxV+ZuUi4fnK9txXI9DZBaYfs8whXm//nyxjvoGcjgxsHcMtNiF8Y+KhA2Q/b7G0TwtSxUUOWScXJnGdSYLnviUyMGKsVP2F2R+VuquQ3ijCpGQckhpbLwvsKMGqXrTXvC4L5gAc/jj8UdRcWPNyd6EPF3CE0QWr7rCDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6X4ILMkEKE+S8V9eRhW6ReEeTC4keA6zoXaO+6jUmU=;
 b=Fqu31acXBHpa431+ekaAnZmZF6NY4LQ1YScrywK6LLcZ1Zndk+e+1X2UV9mgag/0C5AJ2z08UNz3iFOg5TB0DIQ/f+o4q+hE4NlrTwR3J8ZQ4zFgSEk2JAALiOXpwC9NfykaVSAZXStK3rr1uOwKBCJ6ApI6JHCzVDGkwSDx0yfeEpRcImU/zjGDbGMLxAS+zn69694C4MLtzR9ZtJbLxLIgjL3ursaDqfX/Y8ser0u641kvoHyPKL/pXhQcA+lrO7o1GJKaQEDH0EzbpyG0iqOgjvg+zclZPNBsvzqLA+rCFHvQFHf8jx28Ko9glHpLShbQj1y7CQLVWuOG+Cwdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6X4ILMkEKE+S8V9eRhW6ReEeTC4keA6zoXaO+6jUmU=;
 b=47HS0+3Zj6u/rTtw1pDghV2fKtm/0iiA5JHJKJLn8nqzsiBNc7XTovJvd1xOIvWNqyGr49YFDMe5Ou60vqE3ir/0ZDElCSN0zvGtVDe/418jsSwia5AsSG9oWcacjo1nayUqKZf5i+gAXix03/+yrlZK/yUeJ7jP9XP46VjrrcA=
Received: from SA9PR13CA0133.namprd13.prod.outlook.com (2603:10b6:806:27::18)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:41:38 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::3a) by SA9PR13CA0133.outlook.office365.com
 (2603:10b6:806:27::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 10:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:41:37 -0700
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Dan Williams <djbw@kernel.org>
Subject: [PATCH net 6/7] sfc: obtain and map cxl range using devm_cxl_probe_mem
Date: Wed, 1 Jul 2026 12:38:04 +0100
Message-ID: <20260701113805.14072-7-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: afeb76ca-f0e4-40a9-86f1-08ded75d54b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|13003099007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	U0B+8lCfu0utRYxeOy+V9uYvunsv0ZAHfFrBCztL5i082wOzB7rfTIqLZIw0D4bqbLPmtlEbfaRJsRLQtd6EVTi/vy29KJU3g2lvXQSjNV/p0AMpDb78XEXpHid6qRjmgvMIrtHYUlfKGhcGFvWclXd2wcbWBvWDnnI76pP65phhJCCbfyjs0B7drTDbBqEA3rT6GHYPkyf6KVjCerz3gBwoEoVeELMMKPbaBq23jsr5gWsN87JHj5ksxqHre6RFHQdZszn2vmHz5ZfuFYWqWGbXmfFxpyMflQUZqFqe22mp+UMxchjMvpzCF9m7b0KLcqDnnVFEE9RoyFzViHufTX3WPudYQ2W3uDu5MCaiDti4/cGM1A4HaV8uoPPcPwAZqxFZfw0lQrJs3zXvOgB6NJa1vC4HCeYx2Cxbbx4080qLP04u8x0amQRk3PRjTcV14cyhwYgqtiU33vOvtIsSbcE0hvBslCtOdh+8B9iXvSvlsAmi8Mu8QloCcXJOJ40SzA1WrF4XenhIvl/SExBee2TXWpwSZUiATEHaMLivziAkpRDi08/4NgKQ3BV/Y4k8ZCnjQmh+JEzeqmGash/XKBqSkvELnfFwHZgAkSNm00jBdo7eMOLCLaIOvU6M0oQtIlmPyxbeXzmfhrewXXbUpKv9sUvIw7BPUgUhHAgqvU8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(13003099007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WtQxgIgOqyaihevbWPLeOwCQPKV1JxiPwDY89xdzRZt2g6CNjT3WDOf1JRaGpdvpTVj10e8oj56PPh3KRexx+26B/DZ4KUGtYJqbPmU9uNCPmd6PWHsx8/fSpsWO9X1R5lX7wCGIjRFcwUz8hPjJhypgrlvljWlKCZSPdLoMuXSX85eMLh3onTkCSS8w9fcbYWk8aBcsR30e4dMsMwP93sB1KY0qvs1mwQ3lSuaybs1rMuLl8lnrGmETR3PQFClvS/cj2Hc++MRSbvQun19LJhb8SWlVunMSXqDzaG0v/ELNe8KvlwLHsrvkQAdXcIIJKoKRnHR2JMX4WhUaRq+V+9MPOuJbuzXW5NNNEicmKxDPicxMSv89JUzDEeQVrphkbfknudserv7rkaoKY0rr+jgIiFu2vBUvtRvB/lYVsrU4F4XLIWOD/Idl4C5rgJQ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:38.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afeb76ca-f0e4-40a9-86f1-08ded75d54b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:ecree.xilinx@gmail.com,m:djbw@kernel.org,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303587-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,msgid.link:url,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80B3B6EC55B

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
Signed-off-by: Dan Williams <djbw@kernel.org>
Link: https://patch.msgid.link/20260630151346.31201-5-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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


