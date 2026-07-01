Return-Path: <netdev+bounces-303585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yx+uASXwRGp73goAu9opvQ
	(envelope-from <netdev+bounces-303585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:47:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7766EC581
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=rILWX0nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303585-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1816300C7D3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C58423A9B;
	Wed,  1 Jul 2026 10:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505341B351
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902500; cv=fail; b=fLhRZ7BH6K4NiRMVPsge/gFA5S2yMeK83cpEU1QJ8Dr8G3ode0wpDq8hjLDJECUjymd213JHl7fEErQgAC2Ioknx6XtyPMJfwAeF1gdoqN4Hh2ZZVQw2TxHbGMjTaxyOZY5NH9f9W8zXIk6qfC+cHFH4up7BxOxSVt8a1Ku64q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902500; c=relaxed/simple;
	bh=dlXb2zYYGGp8HdZRO6mABDDLmObehOfWz16FjSYSJ7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzGPUG1QKeM3PSaeLebm0pSn3uha/RJtP3I8fIEw8lTNVz7/XKtONdlnhl6TzeLUN9g6ZSIkc7V4Pd5jhiK2c7mWjMumTkZA26BWTxMt2dcy8P3KpFTXdHbewC7UcqChdEW0wHXPFwaORslVCCR6dFGUVBtrnQ+qGA9dSYaruJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rILWX0nl; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaQbpg+m67+k0aTuUXrY/6Ci2r4RvuJIA+q8qSvIvTsn/UfLQMd7MY8fla/AsR/ozMqYwKccev54aeWA9N3pa/MLusR10nVcaiIOyfQMqwGYOyzCsq4kF7cKvj8Wz6msEVPfJeRJW+6JWsRpuIGZGL57K2NQ6TVJe6mVi0+/r6QjZGbZdeLc6Z9J6RFOlrm4o7caw9DS6Tnecl8ZvT4WUjQfLn9NCQjOyLudTqQqmMyZvfyz1FVq1ir+i7aGvr4G/vHOc8u5XdRdArY+nIxRDr+eNWhb5UBd88wpwNsGUcJhvdn8TODv5aUYVZorv1uNjzF8UGU3NiF9eE22gAwBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y6em/6nQDvgYir1yDP9H+tUyfj0nvt068ZJhTG9TIo=;
 b=qIusDmqBGyHl3i5mbkJYzBeFT7Jzg8RTsREuv0gzJ9VyGGI3Tgnmk0XTU4Vm5Ps4KWMqzPkqgfewc4HLex4vD/DbUeopt4eAfp++7fMEMfl2nrebKpPhLzbiFyQvEAswVJyOKoNVjG6GYK1myanhVLMUMElhY/JnmWnZveF3BvrDjm35dyP5fVAwr3804Pdc8QXqWDmwV1SaavPE0xOCAzHE8Zoef7owRt3i29OWWqmvH+Ref2gznLeHXBeb3fI2lBku+MXHpMAek+2Nx1bZwsk2HfsN+eoHzQ46YqenT8ecTBRNqSfmS4Efk9hY+Inf61/ru0NW6lJSZ5vPvVB0Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y6em/6nQDvgYir1yDP9H+tUyfj0nvt068ZJhTG9TIo=;
 b=rILWX0nlO16CGqp8t+n0M4Yo1Lb9YClpqiNDALF6qRBhBA7wSJcHEQHJuErFmk1ZuzD8R8q+t/Sk2EH6DupOBbURLICdXQknRxzpPsF2Pmv3ya0UCtvE7qJogF8X0yqux4c0oFzaIJ0DYi6j6eLiq7nHEIDdRW/VOEhazbiVwFQ=
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 10:41:34 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::a9) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:41:33 -0700
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:31 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: [PATCH net 3/7] sfc: add cxl support
Date: Wed, 1 Jul 2026 12:38:01 +0100
Message-ID: <20260701113805.14072-4-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d831f2-55e9-4ca7-7471-08ded75d51da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qAIWIl3HZ9yPtkeGr9JcrM/NOpy+K1Y9jxdf+cG0YdHfpzddaSwK4ZgCe0cmbjs6nvZ31BfZc6cgikhYXvc3IqniFHRGkQZ9yE7xkifRtWe19HdOUqDq/iqhwHgsRluNY8WrruJaA0QPLeaiv5Y3eiPR24Rk8J1eVpjhRmsewjddjRjVfEr3O93K5bv5RWZ1T4cvMGLzg2Aq+VPIQyxd5ANy+96Ld16A4W86bmWA4sHLjpjcBOtIySqUrL8O/WFlR+H/o963qbm6/FWf+meps5TsHKHegO0BvKJcBX2hjjwPzXYC+ncTnLktDrkTnDyqqMzvoW1XSueaPKGOraDpL0vlpZIKPDyiCr2F94Xj0F/Is+vl0JRGJnwE1/Yt1fNd9t3nj+K1L0eFVkVipmlmgSERBzg2KHzB6nznFePjaFmlTP7PnOWLEEinqkSu2zDio4u+u7aaYqFBmY81wvyFYXeTtA8X4oEwW9wqXlnLuUAe+oq6gzUJ1B0L5xSzq44+UCAVB95liSgGOHQIjvZVQO8VoJbAD/Fi8ihQNEV0DZy3DGqyhh2TyIwl8r5BiXZUYSaw92kB78AfrfEhd+MPBmxdBHZ75N67NOIFTWi/siWuPE9mdZEdMBgDIrNCbSCnOIktTTvmS2HCpCDwBp921Srrx6N2xTI5snjr0wWT2SE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RfbzMnAGj49HXhWlrNxm5OgW3MBT87q3U9IPISOiRMW0lHAc6fLnYFlC3MpcX1FnbUlDPuNA57DvuCul3prUwXFKvZYzRHIAddF60q0FOKdPgMnDM9qvl/mbp/2YpPWbiSJwljY1Z/5c9jgSz3Z0UWpm+4Nn+JDd1H9fZRbOSXL9L9tGNI4G/KmYt8IIccrRndQd9STZ60/Ap8r9uLBE0LzI3+RnKofrMjEdN2dqpioTqpPx98RYHipAzZqcE7lc5cPa2qiz13fdQpSgplrMre/vBw59cFDtIhi6O7LUvtumL/jjmIvRy/U8OklbAl1xrlEEBAVSqKZHTdWInJhc9bMSigBLEf3dbqWMzdp+MGX8oiTYON5s8e0M50Xpo4VTc8+KFvVGojQ4kPb5GmYAWi22aP83QdDX0cFvJwZWDvKyVgA7OGDjLN75JljXjvl5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:33.7781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d831f2-55e9-4ca7-7471-08ded75d51da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:Jonathan.Cameron@huawei.com,m:ecree.xilinx@gmail.com,m:alison.schofield@intel.com,m:dan.j.williams@intel.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com,intel.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F7766EC581

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260630151346.31201-2-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 16 ++++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 50 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 29 ++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  8 +++++
 6 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index c4c43434f314..979f2801e2a8 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS >= SFC
+	default SFC
+	help
+	  This enables SFC CXL support if the kernel is configuring CXL for
+	  using CTPIO with CXL.mem. The SFC device with CXL support and
+	  with a CXL-aware firmware can be used for minimizing latencies
+	  when sending through CTPIO.
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
 source "drivers/net/ethernet/sfc/siena/Kconfig"
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index d99039ec468d..bb0f1891cde6 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
 
+sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
 obj-$(CONFIG_SFC)	+= sfc.o
 
 obj-$(CONFIG_SFC_FALCON) += falcon/
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 8f136a11d396..61cbb6cfc360 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -981,12 +982,14 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1190,6 +1193,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used. If there is CXL
+	 * support and the cxl initialization fails, the driver probe fails.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc) {
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+		goto fail3;
+	}
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..be252af972ab
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+
+int efx_cxl_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	u16 dvsec;
+
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec) {
+		pci_info(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
+		return 0;
+	}
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
+	 * specifying no mbox available.
+	 */
+	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+					pci_get_dsn(pci_dev), dvsec,
+					struct efx_cxl, cxlds, false);
+
+	if (!cxl)
+		return -ENOMEM;
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..04e46278464d
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+#ifdef CONFIG_SFC_CXL
+
+#include <cxl/cxl.h>
+
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+};
+
+int efx_cxl_init(struct efx_probe_data *probe_data);
+#else
+static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..563e6a6e85f1 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1197,14 +1197,22 @@ struct efx_nic {
 	atomic_t n_rx_noskb_drops;
 };
 
+#ifdef CONFIG_SFC_CXL
+struct efx_cxl;
+#endif
+
 /**
  * struct efx_probe_data - State after hardware probe
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
+ * @cxl: details of related cxl objects
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
+#ifdef CONFIG_SFC_CXL
+	struct efx_cxl *cxl;
+#endif
 };
 
 static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
-- 
2.34.1


