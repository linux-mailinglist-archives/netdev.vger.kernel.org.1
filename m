Return-Path: <netdev+bounces-297287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AWHAHpKBKGpaFgMAu9opvQ
	(envelope-from <netdev+bounces-297287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:11:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF93C664359
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:11:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=rmS0o5mi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297287-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6830A308C5EE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C23E3147;
	Tue,  9 Jun 2026 21:06:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50443E316E;
	Tue,  9 Jun 2026 21:06:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039206; cv=fail; b=XoqY5CJ0ljVQBuDm3KFzYhW9O7fzEHGNKiMGLh4yNg3dqeUCdDcqHk7ISQ/Zj214vZWgmol7q/xz2eZHaDzYGPAeXmKA66II2JHuleLK00Fsy1aYFBsiTZsrb+1gGPfxwpr2kpvz+m7iesNonhZ+ZOZpK8Vol3hjNY6WEmhaQeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039206; c=relaxed/simple;
	bh=c0A5DGH/Cy7pv7MwKk9jR+uwCIV3cl4PHpL0GW30j0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIrshyeULfhqyUoNN7CeduFzJM0kLukolRrO0wsW5MTq+40fFr+7gbZaQ0vtLjHfc6HMDGcnJW8jmOJUPYnnKOHqZWLrFcFapW4kHgNgR48PN3p8YP7rZzL68AjOE1pmmhGbUVGuUViSVD+9CWEk8rOYclA30kyMDmA5QbvXBaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rmS0o5mi; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Zafw/QISbCZJOFRASz+o0NcMjB1H1fYLLVx5apIx9iOJzX0t4nGSAQeWOv0KVamSTgL6yFXUvgZ8DnSp1F1tzHXOoU7HXykTYTHqpEWlk6WHwKJnOefHuS2RSw742vkEYO0xfUS0XIfBfTtn8ucxtTo39+zeOGDnKUbQ6eYxsQTsEOtwd067OTDm2M28CxVXBTEXev+O5hwnBrULCOXfSHmk7ytBGM6nv/6rc9ej4hauFOohKf75juUISg/jnL9jSJsdSflv2e8hw/Q75nixbA2f08Y1kt/4roQPCS2vsApOSGn+9oYYPh7TgjfvfZBCYEwBRgKiNE8qtFdCs7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy6EPi4Yv10YqPzW9tAiv3loqeEiy3lRS5O9HYY8W4g=;
 b=aQrQOLa53MYCi5YEIBEbY3H97KKtWm1YvLa63caHETrHTwqhYPhqIx0UOFhKBPNAdRSu+b0+GtbCvwUVmNZIipuTq6qkvBwTdldeVQ22bpKyLW9d2tcnI1owwAdfUh2JpaIS8uhnpGSKAwLqnx3C1lnSELwJTqyprWqz5OCQ0qjHeZ7UpwMx406Z2RrzyF1g34bhmWnBsjjDbn0+0QzxjZrl2jra0M28Zt6bq6l8/f3lgwm0qMP8oZE9MxACV+wOJDzIl0W5AgtRK3Q6FwTZN+g2yC9dkPHU9ewX4cBImoIi3Bfs7onWMkggJAblFdj6sQp/BZpf38FGy9pD1QKQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy6EPi4Yv10YqPzW9tAiv3loqeEiy3lRS5O9HYY8W4g=;
 b=rmS0o5miReEByqOjYeiGAElysWwgA0EhM1tvu54NtlGnhg6+ZLFK79HCelHxOnifPA8M2/XHRWrMO/aIZ5/us1qyXU7FkXsfVXQJQ0H+eOf+Lo8uoFu0l0XgAcY0lIBaWaDnjxA3o4BggOPjIzw10NoOpsMuUFhwWogMMB2zhpQ=
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 21:06:33 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::82) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 21:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 21:06:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 16:06:29 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 9 Jun 2026 16:06:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <djbw@kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v27 2/5] cxl/sfc: Map cxl regs
Date: Tue, 9 Jun 2026 22:57:52 +0100
Message-ID: <20260609215755.8685-3-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d9891b-8ab3-42e8-df1a-08dec66afc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I6+pdeQU0NGmmbS/1odbgLbZcBNUOM1H/CswpFQmugIk2Z7JcwkmhpajjH2R82ycVACdJH/NiQgKk0GXYCnKU70uEwsulhjjFg0zXOmK2EROXKPAQAU2scgBTAJPzse/XcSRzrPHrWCNGeFqcNTDGMNkQI2XdaiK4nS1PIRmD5OkQLzNvzY09tD8ZtpHs6Fkryy/KA1e9hOuOSae2LC4DDDjPf24QbcICpF9EctrHLIdt1g8UPy4/Q95lUgTfTY+TcM5T0XyqmwZzAz0NhgBpHxV7Bnjc9gENNz1fwrWFLExQdAdbcifSiCCjMxpQaIN91/mZmvaC+2IV//qSxrBkSVE4t6ccj42CNVdtFklvRuvZwGf0W+ss3iJkdR4OrgMhXN3zIDbBWOHtAtpK5KbXpHVLN+OxqE/C9L1puwEVv+3Dd5OM1hI4C/FuTeWWwnDRaGU6XAtMyj+fTPGKDSPB0qSwYHkdubNNEmBKBaM+a7DLYPtQlPtEtL+sFCm/zWfop/SHAMOyxpCeQKLZimT7uHhR3MsXPrDyAuvpV1DQS/K/bYg/hW0n9pgnk71B+HoTUm2bxX3BAlQ4KhMO7kgPfhSsApUZQt6In/VqRuvEdc5YZD4XbKzOGSHUfl1EQ47gb6eSioTxKzp7haQgM//EcTfMvf3m9N0ynRnRfc1x2wjXpLc3RJ1T1oXijm2rHOmnGaUksqEtA5lLYbimvJaWsr2xCMdKrH6+QFLS13GrgY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nS71vNN7eAOCPzyKSmnLvervRBo79HN8p80ISMDh/osf35ommu4CTt+Qc/96ePgirDb4k2Cuns9Hye2iFTErGgBFlgRRUH4Uy7+VfdXBnred+2cdfBsfgjtoWrBeKp5VXLbII4HhKHZcV+HCMrbm2CBxwheuPxbrjPmCzpuM+W4slnScGQeNKaQKnn/KJ+gu/OKqZnjZu4MUmHee+kiWkGkFv0OMgPexcDCM+3NhHI9jxK+ordiLYe7kxocqxxD4RDqmlZ5PTOrH+sHO6W+TjCOL1zp3SlW8E6GQ1DbAdWM7q8CAaov+TomnuKL/z3UDK4OKMlJx8gzVhWF2Qsmon8Ys8zYFQpWo1uwgt49I4vdAjYAYrDuXGab8lvUxG/GMINier5pis2eHjqxFxdHh9T6o1RjCFY0Gnexi6SAfC5mBgXtrLqZgqVVkJMYgyotB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 21:06:32.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d9891b-8ab3-42e8-df1a-08dec66afc0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-297287-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:Jonathan.Cameron@huawei.com,m:benjamin.cheatham@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF93C664359

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c             |  1 +
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxlpci.h               | 12 ------------
 drivers/cxl/pci.c                  |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
 include/cxl/pci.h                  | 22 ++++++++++++++++++++++
 7 files changed, 52 insertions(+), 12 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..2bcd683aa286 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..cb633e19151b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..20c2d9fbcfe7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7b..110ec9c44f09 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16
 
-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
@@ -112,6 +102,4 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..bb892dbfdd6d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index b7e8d85a43d3..f88c2b3fbb2c 100644
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
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -44,6 +47,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..3e0000015871
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+struct cxl_register_map;
+struct pci_dev;
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
+#endif
-- 
2.34.1


