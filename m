Return-Path: <netdev+bounces-305997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cbNTEG/ATmrcTQIAu9opvQ
	(envelope-from <netdev+bounces-305997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:26:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1472A841
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:26:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=5n0CuYxl;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305997-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305997-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8372308720E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4C43F54C9;
	Wed,  8 Jul 2026 21:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127D3C4176
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:23:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545812; cv=fail; b=ExC5aBMXgHfnCfh+rZ9QjXpWmWytILDRIlAlKHKIBy02TIyoh6MuBGyOmpYLSSEqQ67CTCBhAKTHB93Gdz5Dd1HV3DBIHxvJbMexSPz1kzVbo+E2qPZrvRBAAOQ6q5bbwt71z7AwKU51jKNjB08xQsbDz5LNUwtmRwDh9TcIHAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545812; c=relaxed/simple;
	bh=MuwbSGks5dQGz5fWJbeBl0JhbENV/dnIZkLRAQ9+sxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFL69HBC7x2uoqRGZlQczB/ABdco90EM3UKV8W9HKoLDIEWA8qJXPRH2t1nu2keSkIOT4OyQN4GIoouDfGyvoOSsSR1wOK3kQ1iSsEnknPrZB0xqf1NvWGPEGeARXdeQfmj5B0SLuFADZqU/Gz6ETget7OqWOZnzZcpyx6FQQsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5n0CuYxl; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4dcWcUc2UV50sWXQMs26HVptrSV3O/PrZ48Iek5zY450bnFrFGjKxlgt5+R3TjaglLkc9XaWLN9QDdK8rg9zkoM1x1v4yXm95ypDNXgZ8u+zD08jGccef8yA9btfURt3m1c/XHzQsPMJ3d+7jniawWycE5p0wx2zZC4m+OZ8xKsgOlLCmby3B8ujKv7lQqatsK5145W+0SNJRj1GXQiGSIaiSBldJw3Y5Mx7IhHvw4YGQenr4bbIBGLP8oRptdJDY4JMi6m5yZ7rGwHPGcgMa96sIHe6ieV9Cz4Op+PDZQjWIM7PFOLN0Q3k3klVXWnPeTArWvDB8npsKOzPZtWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOpQYbGttIjhfDaldSf5nX4YY7vLI5zp6d8tg5pT6KY=;
 b=tB49YkvVuICEHpRFuq0PqvUuXwUrTnjYBWJawwdW17LFX5yPpXl9+Gy2PoXJeOYLm3nV2IeFajIiTSU1+MRWzRVuZcqjrOIT6dTIiL0ZQR/BR3eUfcG2TQ3cY5lg92EjMCqH/UqKurS9gRhwuLxnmmBSZzw7XjtEdqmrRxoeGQoqZ6AP6qQSUUy/Gf4GXETjCjqEEbM23Q4AwdOTEl0danUqaK5JC8WM1nH++7AfqoyQcjFfdpDLrNxaC5Zu8p8XHEsvgQA/MQl9oI6EFnvV4IcN6WGS+SdRAsD2yPKsTXGNtVn6bn0LI43Iy5fDVtq8ytS7WFMm29gvTc7+0nTXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOpQYbGttIjhfDaldSf5nX4YY7vLI5zp6d8tg5pT6KY=;
 b=5n0CuYxlld3pmgoou0BC5I6GkUjgTbYZJ7v8+GKIoxOnM9uTnbiPjz/ZjyguIoq9KInzcZqiWEjRJYJ9n0BNUIaqOLG/F7/kJNaCkUgu+2KOiTNwT4v1wBOPkDDT5MsGIzSxMCETyNUn4G/Be1zGaNignlGd2qr7mhqpVNtPKFc=
Received: from CH0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:610:74::7)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 21:23:20 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::3b) by CH0PR04CA0062.outlook.office365.com
 (2603:10b6:610:74::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:23:20 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:23:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH 3/6] pds_core: add PLDM firmware update support via devlink flash
Date: Wed, 8 Jul 2026 21:22:19 +0000
Message-ID: <20260708212222.296202-4-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e89507-af8c-4ba4-0511-08dedd372286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|22082099003|18002099003|6133799003|56012099006|5023799004|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	c/94SAllmu+ZtUJTVqWER38zF0K7mjFzUdnORm+9AhLAzrQxS9aFj4jAr/HeafLf8b8vYZx1QFr8uzoTxlscFg+ZjVBkw04FxFq6qoztA4n7LATwn5Hi3F7quYZfPmIK6ZCOCfypBMMeZsHvod8e2scPZ+jjVkwDwJqhtBRmnKf8aPjRtXpKKOq7SE00ZnJgKw1/uOGwhZmkeTw7xyXTSY2ceFFxI1wWg0nIpYlxrzJBl+U3b9lL+R0QK1Zm7YcQOl2V3yJ5NuWxo2oubOs6PuCpobqe0C2n4e027ziSHtGxu/3vdBmn51wzDlFwi/Kcr6sTqRqcbjh83Xr984rWosVInGK0sMLagXuvQQ4BiXD/KkawLMowbZ1JqL04EJIJoc+kjZ+i6jbAYHmaibP4KWBKY1CvK7oPGp0cKEt5UxMf6yr8oc275VFsVRUDM/3VFpcFKwprLcb6BAR2yv3kc2dutVE2c7vDthQUk7NZMiCRg9bX7QgIrxjImMasIpSYYKwnRsaz19Nk9jDhfqOnukfPZFcQRECSTEV2jr9LXPqQhf4atsSk0d+yxMVpZXGk/XlDwEOQTL6X+LYceHCkgOjaOe3bU2kM9jlZdQvK1XOHYmKDBxszhgDFNlWmABNfrdL9F/t21rubQ/Vr+LWJHLF6nVPrTWZIt2BgzeFMIHk6R6+ntLhqU8OK87FWM3UGd7BboIQFVxkZ0O0qqPm9Iw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(6133799003)(56012099006)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sb9IGEMnEtIx4F/sd18BBXQFw4WqdYH+r2uuaDyK878Q34UHO4IClZEjTcH+n9s0mXissLUNTbz5v0xCDWmI+x2SQERQarOVABhdOT2ROgacirtiK1mOuPJ37J2x/c30fDfn0AWYI32OdIVBKlQ+gsVMRoXr6dikwebxhFNNlgb9TZUx95vk0fQ5ZGdaBI9cPdHx1ZXQTahQlsYIhSlnpWKrbYgAExZTN7x112I6xdzdKZBmkvBj0Qx8nLOl8Cb6lLXJmH4g8UQyyD7gcDg1Am7clz3dtev/fk8dzUTBH7rYCbueukgj/NAR7BeZ0Ana+OHasUGR2S9ObXyC57LMOkM/s7rjVh5hrxbyi9YAL/uTUthNzj67irzABnpOIBXJE1HWlL29C8SC4VrG7GYNBmimdDhyUiTxppddJsoB48IAJ6kveHagDQHtOinu3/3F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:23:20.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e89507-af8c-4ba4-0511-08dedd372286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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
	TAGGED_FROM(0.00)[bounces-305997-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp,fw.gold:url];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DA1472A841

From: Brett Creeley <brett.creeley@amd.com>

Implement PLDM FW Update in the pds_core driver using the upstream
pldmfw API. This allows updating an entire PLDM FW package at once
or updating specific firmware components by name.

Flash the entire image:
  devlink dev flash pci/0000:b5:00.0 file firmware.pldmfw

Flash a specific component from the PLDM FW package:
  devlink dev flash pci/0000:b5:00.0 \
    file firmware.pldmfw component fw.cpld

Per-component update uses driver-defined component names (fw, fw.cpld,
etc.). Not all components support per-component update - devlink will
reject the request if the specified component cannot be updated.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 .../device_drivers/ethernet/amd/pds_core.rst  |  89 ++
 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/pds_core/core.c      |   9 +
 drivers/net/ethernet/amd/pds_core/core.h      |  30 +-
 drivers/net/ethernet/amd/pds_core/dev.c       |  82 ++
 drivers/net/ethernet/amd/pds_core/devlink.c   |   2 +-
 drivers/net/ethernet/amd/pds_core/fw.c        | 781 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c      |   5 +
 include/linux/pds/pds_core_if.h               | 401 +++++++++
 9 files changed, 1395 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst b/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
index 9e8a16c44102..49487a35c163 100644
--- a/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
+++ b/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
@@ -102,6 +102,95 @@ currently in use, and that bank will used for the next boot::
   # devlink dev flash pci/0000:b5:00.0 \
             file pensando/dsc_fw_1.63.0-22.tar
 
+Firmware Management (PLDM)
+==========================
+
+Firmware that supports PLDM can be updated using the devlink flash command
+with a PLDM firmware package. The entire package can be updated at once::
+
+  # devlink dev flash pci/0000:b5:00.0 file firmware.pldmfw
+
+Individual components can also be updated by specifying the component name::
+
+  # devlink dev flash pci/0000:b5:00.0 \
+            file firmware.pldmfw component fw.cpld
+
+Per-component update uses driver-defined component names (fw, fw.cpld,
+etc.). Not all components support per-component update -
+devlink will reject the request if the specified component cannot
+be updated.
+
+Gold (recovery) components can be updated by specifying the base component
+name (e.g., ``fw`` for ``fw.gold``) with a goldfw package file when the
+device supports per-component update. The ``.gold`` suffix in devlink info
+output indicates the gold slot version, not a flash target.
+
+Info versions (PLDM)
+====================
+
+Firmware that supports PLDM reports component versions using driver-defined
+names. The driver reports the following component versions:
+
+.. list-table:: devlink info versions for PLDM-capable firmware
+   :widths: 5 5 90
+
+   * - Name
+     - Type
+     - Description
+   * - ``fw``
+     - running, stored
+     - Main firmware
+   * - ``fw.gold``
+     - stored
+     - Gold (recovery) firmware
+   * - ``fw.bootloader``
+     - running, stored
+     - Boot loader
+   * - ``fw.cpld``
+     - running, stored
+     - CPLD
+   * - ``fw.secure``
+     - running, stored
+     - Secure boot firmware
+   * - ``fw.fpga``
+     - running, stored
+     - FPGA configuration
+   * - ``fw.suc``
+     - running, stored
+     - System Unit Controller firmware
+   * - ``fw.suc.bootloader``
+     - running, stored
+     - System Unit Controller bootloader
+   * - ``fw.uboot``
+     - running, stored
+     - U-Boot bootloader
+   * - ``asic.id``
+     - fixed
+     - The ASIC type for this device
+   * - ``asic.rev``
+     - fixed
+     - The revision of the ASIC for this device
+
+Example output::
+
+  $ devlink dev info pci/0000:00:05.0
+  pci/0000:00:05.0:
+    driver pds_core
+    serial_number FLM18420073
+    versions:
+        fixed:
+          asic.id 0x0
+          asic.rev 0x0
+        running:
+          fw.bootloader 1.2.3
+          fw 1.3.0
+          fw.cpld 3.18
+        stored:
+          fw.bootloader 1.2.3
+          fw.gold 1.2.0
+          fw 1.3.0
+          fw.cpld 3.18
+
 Health Reporters
 ================
 
diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index e35991141a1a..743e3d4b6b94 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -171,6 +171,7 @@ config PDS_CORE
 	depends on 64BIT && PCI
 	select AUXILIARY_BUS
 	select NET_DEVLINK
+	select PLDMFW
 	help
 	  This enables the support for the AMD/Pensando Core device family of
 	  adapters.  More specific information on this driver can be
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 38a2446571af..6c62ff7a32f0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -483,6 +483,15 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		cancel_work_sync(&pdsc->adminqcq.work);
 
 	pci_clear_master(pdsc->pdev);
+	if (!pdsc->pdev->is_virtfn) {
+		u16 val;
+
+		/* Flush any in-flight DMA before freeing buffers.
+		 * A config read completion cannot return until all prior
+		 * device-initiated memory writes have completed.
+		 */
+		pci_read_config_word(pdsc->pdev, PCI_VENDOR_ID, &val);
+	}
 
 	pdsc_core_uninit(pdsc);
 
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index b7fe9ad73349..c686f0bbbaeb 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -23,6 +23,14 @@
 #define PDSC_SETUP_RECOVERY	false
 #define PDSC_SETUP_INIT		true
 
+struct pdsc_deferred_dma {
+	struct list_head list;
+	dma_addr_t dma_addr;
+	void *va;
+	size_t size;
+	enum dma_data_direction dir;
+};
+
 struct pdsc_dev_bar {
 	void __iomem *vaddr;
 	phys_addr_t bus_addr;
@@ -185,6 +193,8 @@ struct pdsc {
 	struct mutex devcmd_lock;	/* lock for dev_cmd operations */
 	struct mutex config_lock;	/* lock for configuration operations */
 	spinlock_t adminq_lock;		/* lock for adminq operations */
+	struct list_head deferred_dma_list;
+	spinlock_t deferred_dma_lock;	/* lock for deferred DMA list */
 	refcount_t adminq_refcnt;
 	struct pds_core_dev_info_regs __iomem *info_regs;
 	struct pds_core_dev_cmd_regs __iomem *cmd_regs;
@@ -199,6 +209,8 @@ struct pdsc {
 	u64 last_eid;
 	struct pdsc_viftype *viftype_status;
 	struct work_struct pci_reset_work;
+
+	struct pds_core_component_list_info fw_components;
 };
 
 /** enum pds_core_dbell_bits - bitwise composition of dbell values.
@@ -281,8 +293,16 @@ bool pdsc_is_fw_running(struct pdsc *pdsc);
 bool pdsc_is_fw_good(struct pdsc *pdsc);
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds);
+int pdsc_devcmd_with_data(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			  const void *data, size_t data_len,
+			  union pds_core_dev_comp *comp, int max_seconds);
+int pdsc_devcmd_with_data_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				const void *data, size_t data_len,
+				union pds_core_dev_comp *comp, int max_seconds);
 int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		       union pds_core_dev_comp *comp, int max_seconds);
+int pdsc_devcmd_locked_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			     union pds_core_dev_comp *comp, int max_seconds);
 int pdsc_devcmd_init(struct pdsc *pdsc);
 int pdsc_devcmd_reset(struct pdsc *pdsc);
 int pdsc_dev_init(struct pdsc *pdsc);
@@ -315,11 +335,19 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq);
 void pdsc_work_thread(struct work_struct *work);
 irqreturn_t pdsc_adminq_isr(int irq, void *data);
 
-int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
+int pdsc_firmware_update(struct pdsc *pdsc,
+			 struct devlink_flash_update_params *params,
 			 struct netlink_ext_ack *extack);
+int pdsc_get_component_info(struct pdsc *pdsc);
+const char *pdsc_fw_type_to_name(u8 type);
 
 void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
 void pdsc_pci_reset_thread(struct work_struct *work);
 
+void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
+			   dma_addr_t dma_addr, void *va, size_t size,
+			   enum dma_data_direction dir);
+void pdsc_deferred_dma_free(struct pdsc *pdsc);
+
 #endif /* _PDSC_H_ */
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 84ea502ecb12..b149d29bd256 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -206,15 +206,56 @@ static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	else
 		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
+	if (err != -ETIMEDOUT && err != -EAGAIN)
+		pdsc_deferred_dma_free(pdsc);
+
 	return err;
 }
 
+void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
+			   dma_addr_t dma_addr, void *va, size_t size,
+			   enum dma_data_direction dir)
+{
+	entry->dma_addr = dma_addr;
+	entry->va = va;
+	entry->size = size;
+	entry->dir = dir;
+
+	spin_lock(&pdsc->deferred_dma_lock);
+	list_add_tail(&entry->list, &pdsc->deferred_dma_list);
+	spin_unlock(&pdsc->deferred_dma_lock);
+}
+
+void pdsc_deferred_dma_free(struct pdsc *pdsc)
+{
+	struct pdsc_deferred_dma *entry, *tmp;
+	LIST_HEAD(local_list);
+
+	spin_lock(&pdsc->deferred_dma_lock);
+	list_splice_init(&pdsc->deferred_dma_list, &local_list);
+	spin_unlock(&pdsc->deferred_dma_lock);
+
+	list_for_each_entry_safe(entry, tmp, &local_list, list) {
+		dma_unmap_single(pdsc->dev, entry->dma_addr,
+				 entry->size, entry->dir);
+		kfree(entry->va);
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
 int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		       union pds_core_dev_comp *comp, int max_seconds)
 {
 	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
 }
 
+int pdsc_devcmd_locked_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			     union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, false);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {
@@ -227,6 +268,47 @@ int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+static int __pdsc_devcmd_with_data(struct pdsc *pdsc,
+				   union pds_core_dev_cmd *cmd,
+				   const void *data, size_t data_len,
+				   union pds_core_dev_comp *comp,
+				   int max_seconds, bool do_msg)
+{
+	int err;
+
+	mutex_lock(&pdsc->devcmd_lock);
+	if (!pdsc->cmd_regs) {
+		err = -ENXIO;
+		goto unlock;
+	}
+	if (data_len > sizeof(pdsc->cmd_regs->data)) {
+		err = -ENOSPC;
+		goto unlock;
+	}
+	memcpy_toio(&pdsc->cmd_regs->data, data, data_len);
+	err = __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, do_msg);
+unlock:
+	mutex_unlock(&pdsc->devcmd_lock);
+
+	return err;
+}
+
+int pdsc_devcmd_with_data(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			  const void *data, size_t data_len,
+			  union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_with_data(pdsc, cmd, data, data_len,
+				       comp, max_seconds, true);
+}
+
+int pdsc_devcmd_with_data_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				const void *data, size_t data_len,
+				union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_with_data(pdsc, cmd, data, data_len,
+				       comp, max_seconds, false);
+}
+
 int pdsc_devcmd_init(struct pdsc *pdsc)
 {
 	union pds_core_dev_comp comp = {};
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 2ea97e1c5939..3b763ee1715e 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -90,7 +90,7 @@ int pdsc_dl_flash_update(struct devlink *dl,
 {
 	struct pdsc *pdsc = devlink_priv(dl);
 
-	return pdsc_firmware_update(pdsc, params->fw, extack);
+	return pdsc_firmware_update(pdsc, params, extack);
 }
 
 static char *fw_slotnames[] = {
diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index fa626719e68d..dc793005ec70 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2023 Advanced Micro Devices, Inc */
 
+#include <linux/pldmfw.h>
+#include <linux/vmalloc.h>
+
 #include "core.h"
 
 /* The worst case wait for the install activity is about 25 minutes when
@@ -14,6 +17,52 @@
 /* Number of periodic log updates during fw file download */
 #define PDSC_FW_INTERVAL_FRACTION	32
 
+#define PDSC_FW_COMPONENT_PREFIX		"fw."
+#define PDSC_FW_COMPONENT_FULL_NAME_BUFLEN \
+	(sizeof(PDSC_FW_COMPONENT_PREFIX) + PDS_CORE_FW_COMPONENT_NAME_BUFLEN)
+
+/* Driver-defined component type to name mapping.
+ * PDS_CORE_FW_TYPE_MAIN is NULL - handled specially as "fw" without prefix.
+ */
+static const char * const pdsc_fw_type_names[] = {
+	[PDS_CORE_FW_TYPE_MAIN]      = NULL,
+	[PDS_CORE_FW_TYPE_BOOT]      = "bootloader",
+	[PDS_CORE_FW_TYPE_CPLD]      = "cpld",
+	[PDS_CORE_FW_TYPE_SECURE]    = "secure",
+	[PDS_CORE_FW_TYPE_FPGA]      = "fpga",
+	[PDS_CORE_FW_TYPE_SUC_MAIN]  = "suc",
+	[PDS_CORE_FW_TYPE_SUC_BOOT]  = "suc.bootloader",
+	[PDS_CORE_FW_TYPE_UBOOT]     = "uboot",
+};
+
+const char *pdsc_fw_type_to_name(u8 type)
+{
+	if (type < ARRAY_SIZE(pdsc_fw_type_names) && pdsc_fw_type_names[type])
+		return pdsc_fw_type_names[type];
+	return NULL;
+}
+
+static u8 pdsc_name_to_fw_type(const char *name)
+{
+	size_t prefix_len;
+	int i;
+
+	/* "fw" without suffix maps to main firmware */
+	if (!strcmp(name, "fw"))
+		return PDS_CORE_FW_TYPE_MAIN;
+
+	prefix_len = str_has_prefix(name, PDSC_FW_COMPONENT_PREFIX);
+	if (prefix_len)
+		name += prefix_len;
+
+	for (i = 1; i < ARRAY_SIZE(pdsc_fw_type_names); i++) {
+		if (pdsc_fw_type_names[i] &&
+		    !strcmp(name, pdsc_fw_type_names[i]))
+			return i;
+	}
+	return 0;
+}
+
 static int pdsc_devcmd_fw_download_locked(struct pdsc *pdsc, u64 addr,
 					  u32 offset, u32 length)
 {
@@ -23,7 +72,7 @@ static int pdsc_devcmd_fw_download_locked(struct pdsc *pdsc, u64 addr,
 		.fw_download.addr = cpu_to_le64(addr),
 		.fw_download.length = cpu_to_le32(length),
 	};
-	union pds_core_dev_comp comp;
+	union pds_core_dev_comp comp = {};
 
 	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
@@ -95,9 +144,12 @@ static int pdsc_fw_status_long_wait(struct pdsc *pdsc,
 	return err;
 }
 
-int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
-			 struct netlink_ext_ack *extack)
+static int
+pdsc_legacy_firmware_update(struct pdsc *pdsc,
+			    struct devlink_flash_update_params *params,
+			    struct netlink_ext_ack *extack)
 {
+	const struct firmware *fw = params->fw;
 	u32 buf_sz, copy_sz, offset;
 	struct devlink *dl;
 	int next_interval;
@@ -105,6 +157,12 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 	int err = 0;
 	int fw_slot;
 
+	if (params->component) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Component update not supported by this device");
+		return -EOPNOTSUPP;
+	}
+
 	dev_info(pdsc->dev, "Installing firmware\n");
 
 	if (!pdsc->cmd_regs)
@@ -195,3 +253,720 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 						   NULL, 0, 0);
 	return err;
 }
+
+struct pdsc_component_priv {
+	u16 component_id;
+	bool skip;
+	struct list_head list_entry;
+};
+
+struct pds_core_fwu_priv {
+	struct pldmfw context;
+	struct devlink_flash_update_params *params;
+	struct netlink_ext_ack *extack;
+	struct pdsc *pdsc;
+	struct list_head components;
+};
+
+static void pdsc_free_fwu_priv(struct pds_core_fwu_priv *priv)
+{
+	struct pdsc_component_priv *component_priv, *tmp;
+
+	list_for_each_entry_safe(component_priv, tmp, &priv->components,
+				 list_entry) {
+		list_del(&component_priv->list_entry);
+		kfree(component_priv);
+	}
+}
+
+static int pdsc_devcmd_match_record_desc(struct pdsc *pdsc, u16 desc_type,
+					 u16 desc_size, const u8 *desc_data,
+					 u8 *match)
+{
+	union pds_core_dev_cmd cmd = {
+		.match_record_desc.opcode = PDS_CORE_CMD_MATCH_RECORD_DESC,
+		.match_record_desc.ver = 1,
+		.match_record_desc.type = cpu_to_le16(desc_type),
+		.match_record_desc.size = cpu_to_le16(desc_size),
+	};
+	union pds_core_dev_comp comp = {};
+	int err;
+
+	err = pdsc_devcmd_with_data(pdsc, &cmd, desc_data, desc_size,
+				    &comp, pdsc->devcmd_timeout);
+	*match = comp.match_record_desc.match;
+
+	return err;
+}
+
+static bool pdsc_match_record_descs(struct pldmfw *context,
+				    struct pldmfw_record *record)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct pdsc *pdsc = priv->pdsc;
+	struct pldmfw_desc_tlv *desc;
+
+	if (!pldmfw_op_pci_match_record(context, record))
+		return false;
+
+	list_for_each_entry(desc, &record->descs, entry) {
+		u8 match;
+		int err;
+
+		switch (desc->type) {
+		/* skip types checked in pldmfw_op_pci_match_record */
+		case PLDM_DESC_ID_PCI_VENDOR_ID:
+		case PLDM_DESC_ID_PCI_DEVICE_ID:
+		case PLDM_DESC_ID_PCI_SUBVENDOR_ID:
+		case PLDM_DESC_ID_PCI_SUBDEV_ID:
+			continue;
+		}
+
+		if (!desc->size)
+			return false;
+
+		err = pdsc_devcmd_match_record_desc(pdsc, desc->type,
+						    desc->size, desc->data,
+						    &match);
+		if (err) {
+			dev_err(pdsc->dev,
+				"match_record_desc failed type: 0x%04x size: %u, err %d\n",
+				desc->type, desc->size, err);
+			return false;
+		}
+		/* all record descriptors must match */
+		if (!match)
+			return false;
+	}
+
+	return true;
+}
+
+static int pdsc_devcmd_send_package_data(struct pdsc *pdsc, u64 addr,
+					 u16 length, u16 offset, u16 total_len)
+{
+	union pds_core_dev_cmd cmd = {
+		.send_pkg_data.opcode = PDS_CORE_CMD_SEND_PKG_DATA,
+		.send_pkg_data.ver = 1,
+		.send_pkg_data.data_pa = cpu_to_le64(addr),
+		.send_pkg_data.data_len = cpu_to_le16(length),
+		.send_pkg_data.offset = cpu_to_le16(offset),
+		.send_pkg_data.total_len = cpu_to_le16(total_len),
+	};
+	union pds_core_dev_comp comp = {};
+
+	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+}
+
+static int pdsc_send_package_data(struct pldmfw *context, const u8 *data,
+				  u16 length)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct pdsc_deferred_dma *deferred;
+	struct device *dev = context->dev;
+	struct pdsc *pdsc = priv->pdsc;
+	dma_addr_t dma_addr;
+	u8 *package_data;
+	u32 offset;
+	int err;
+
+	if (!length)
+		return 0;
+
+	deferred = kmalloc_obj(*deferred, GFP_KERNEL);
+	if (!deferred)
+		return -ENOMEM;
+
+	package_data = kmemdup(data, length, GFP_KERNEL);
+	if (!package_data) {
+		kfree(deferred);
+		return -ENOMEM;
+	}
+
+	dma_addr = dma_map_single(dev, package_data, length, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma_addr)) {
+		dev_err(dev, "Failed to dma_map package_data length 0x%x\n",
+			length);
+		kfree(package_data);
+		kfree(deferred);
+		return -ENOMEM;
+	}
+
+	for (offset = 0; offset < length; offset += PDS_PAGE_SIZE) {
+		u32 copy_sz;
+
+		copy_sz = min_t(unsigned int, PDS_PAGE_SIZE, length - offset);
+		err = pdsc_devcmd_send_package_data(pdsc, dma_addr + offset,
+						    copy_sz, offset, length);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(priv->extack,
+					   "Failed to send package data");
+			break;
+		}
+	}
+
+	if (err == -ETIMEDOUT || err == -EAGAIN) {
+		pdsc_deferred_dma_add(pdsc, deferred, dma_addr,
+				      package_data, length, DMA_TO_DEVICE);
+		return err;
+	}
+
+	kfree(deferred);
+	dma_unmap_single(dev, dma_addr, length, DMA_TO_DEVICE);
+	kfree(package_data);
+	return err;
+}
+
+static bool pdsc_component_type_exists(struct pdsc *pdsc, u8 type)
+{
+	int i;
+
+	for (i = 0; i < pdsc->fw_components.num_components; i++) {
+		if (pdsc->fw_components.info[i].component_type == type)
+			return true;
+	}
+	return false;
+}
+
+static u8 pdsc_get_component_type_by_id(struct pdsc *pdsc, u16 component_id)
+{
+	int i;
+
+	for (i = 0; i < pdsc->fw_components.num_components; i++) {
+		struct pds_core_fw_component_info *info =
+			&pdsc->fw_components.info[i];
+
+		if (info->identifier == component_id)
+			return info->component_type;
+	}
+	return 0;
+}
+
+static bool pdsc_component_id_matches_type(struct pdsc *pdsc,
+					   u8 component_id, u8 type)
+{
+	int i;
+
+	for (i = 0; i < pdsc->fw_components.num_components; i++) {
+		struct pds_core_fw_component_info *info =
+			&pdsc->fw_components.info[i];
+
+		if (info->identifier == component_id &&
+		    info->component_type == type)
+			return true;
+	}
+	return false;
+}
+
+static bool pdsc_skip_component(struct pds_core_fwu_priv *priv,
+				u16 component_id)
+{
+	struct pdsc_component_priv *component_priv;
+
+	list_for_each_entry(component_priv, &priv->components, list_entry) {
+		if (component_priv->component_id == component_id)
+			return component_priv->skip;
+	}
+
+	return false;
+}
+
+static int pdsc_send_component_table(struct pldmfw *context,
+				     struct pldmfw_component *component,
+				     u8 transfer_flag)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct pds_core_component_tbl *component_tbl;
+	struct pdsc_component_priv *component_priv;
+	struct device *dev = context->dev;
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {};
+	struct pdsc *pdsc = priv->pdsc;
+	bool skip_component = false;
+	u8 requested_type = 0;
+	u16 buf_sz, tbl_sz;
+	int err = 0;
+
+	dev_dbg(dev,
+		"component name %s classification %u id %u activation_method %u ver_len %d ver_str %.*s index %u size %u transfer_flag 0x%02x\n",
+		priv->params->component, component->classification,
+		component->identifier, component->activation_method,
+		component->version_len, component->version_len,
+		component->version_string, component->index,
+		component->component_size, transfer_flag);
+
+	component_priv = kzalloc_obj(*component_priv, GFP_KERNEL);
+	if (!component_priv)
+		return -ENOMEM;
+
+	if (priv->params->component) {
+		requested_type = pdsc_name_to_fw_type(priv->params->component);
+		if (component->identifier > U8_MAX ||
+		    !pdsc_component_id_matches_type(pdsc,
+						    component->identifier,
+						    requested_type)) {
+			skip_component = true;
+			goto add_component_priv;
+		}
+	}
+
+	buf_sz = sizeof(pdsc->cmd_regs->data);
+	tbl_sz = struct_size(component_tbl, version_str,
+			     component->version_len);
+	if (tbl_sz > buf_sz) {
+		dev_err(dev, "component_tbl size %d too big, max size: %d\n",
+			tbl_sz, buf_sz);
+		err = -ENOSPC;
+		goto free_component_priv;
+	}
+	component_tbl = kzalloc(tbl_sz, GFP_KERNEL);
+	if (!component_tbl) {
+		err = -ENOMEM;
+		goto free_component_priv;
+	}
+
+	component_tbl->comparison_stamp =
+		cpu_to_le32(component->comparison_stamp);
+	component_tbl->classification = cpu_to_le16(component->classification);
+	component_tbl->identifier = cpu_to_le16(component->identifier);
+	component_tbl->transfer_flag = transfer_flag;
+	component_tbl->version_str_type = component->version_type;
+	component_tbl->version_str_len = component->version_len;
+	memcpy(component_tbl->version_str, component->version_string,
+	       component->version_len);
+
+	cmd.send_component_tbl.opcode = PDS_CORE_CMD_SEND_COMPONENT_TBL;
+	cmd.send_component_tbl.ver = 1;
+	cmd.send_component_tbl.slot_id = PDS_CORE_FW_SLOT_INVALID;
+
+	err = pdsc_devcmd_with_data(pdsc, &cmd, component_tbl, tbl_sz,
+				    &comp, pdsc->devcmd_timeout);
+	kfree(component_tbl);
+	if (err) {
+		dev_err(dev, "Failed sending component table: %pe\n",
+			ERR_PTR(err));
+		goto free_component_priv;
+	}
+
+	if (comp.send_component_tbl.response == 1 &&
+	    comp.send_component_tbl.response_code ==
+		PDS_CORE_COMPONENT_PREREQS_NOT_MET)
+		skip_component = true;
+
+add_component_priv:
+	component_priv->skip = skip_component;
+	component_priv->component_id = component->identifier;
+	list_add(&component_priv->list_entry, &priv->components);
+
+	return 0;
+
+free_component_priv:
+	kfree(component_priv);
+	return err;
+}
+
+int pdsc_get_component_info(struct pdsc *pdsc)
+{
+	union pds_core_dev_cmd cmd = {
+		.get_component_info.opcode = PDS_CORE_CMD_GET_COMPONENT_INFO,
+		.get_component_info.ver = 1,
+	};
+	struct pds_core_component_list_info *list_info;
+	struct pdsc_deferred_dma *deferred;
+	union pds_core_dev_comp comp = {};
+	dma_addr_t dma_addr;
+	u8 num_components;
+	int err, i;
+
+	deferred = kmalloc_obj(*deferred);
+	if (!deferred)
+		return -ENOMEM;
+
+	list_info = kzalloc(PDS_PAGE_SIZE, GFP_KERNEL);
+	if (!list_info) {
+		kfree(deferred);
+		return -ENOMEM;
+	}
+
+	dma_addr = dma_map_single(pdsc->dev, list_info, PDS_PAGE_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(pdsc->dev, dma_addr)) {
+		dev_err(pdsc->dev,
+			"Failed to dma_map component_list_info length %d\n",
+			PDS_PAGE_SIZE);
+		kfree(list_info);
+		kfree(deferred);
+		return -ENOMEM;
+	}
+
+	cmd.get_component_info.data_len = cpu_to_le16(PDS_PAGE_SIZE);
+	cmd.get_component_info.data_pa = cpu_to_le64(dma_addr);
+
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
+	if (err == -ETIMEDOUT || err == -EAGAIN) {
+		pdsc_deferred_dma_add(pdsc, deferred, dma_addr, list_info,
+				      PDS_PAGE_SIZE, DMA_FROM_DEVICE);
+		return err;
+	}
+
+	kfree(deferred);
+	dma_unmap_single(pdsc->dev, dma_addr, PDS_PAGE_SIZE, DMA_FROM_DEVICE);
+	if (err)
+		goto out;
+
+	if (comp.get_component_info.ver == 0) {
+		/* Don't support backward compatibility as version 0 has
+		 * alignment issues, so give a hint to users to update
+		 * their firmware
+		 */
+		dev_warn_once(pdsc->dev,
+			      "Incompatible get_component_info version %u reported by firmware\n",
+			      comp.get_component_info.ver);
+		err = 0;
+		goto out;
+	}
+
+	num_components = list_info->num_components;
+	if (num_components > PDS_CORE_FW_COMPONENT_LIST_LEN) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pdsc->fw_components.num_components = num_components;
+	for (i = 0; i < num_components; i++) {
+		struct pds_core_fw_component_info *info =
+			&pdsc->fw_components.info[i];
+
+		memcpy(info, &list_info->info[i], sizeof(*info));
+		info->version[PDS_CORE_FW_COMPONENT_VER_BUFLEN - 1] = 0;
+		info->name[PDS_CORE_FW_COMPONENT_NAME_BUFLEN - 1] = 0;
+	}
+
+out:
+	kfree(list_info);
+	return err;
+}
+
+static int pdsc_devcmd_send_component(struct pdsc *pdsc,
+				      struct pds_core_flash_component *info,
+				      u16 info_sz, dma_addr_t addr, u32 length,
+				      u32 offset, u16 slot_id,
+				      union pds_core_dev_comp *comp)
+{
+	union pds_core_dev_cmd cmd = {
+		.send_component.opcode = PDS_CORE_CMD_SEND_COMPONENT,
+		.send_component.ver = 1,
+		.send_component.operation = PDS_CORE_SEND_COMPONENT_START,
+		.send_component.data_pa = cpu_to_le64(addr),
+		.send_component.data_len = cpu_to_le32(length),
+		.send_component.offset = cpu_to_le32(offset),
+		.send_component.slot_id = slot_id,
+	};
+	unsigned long timeout = 300 * HZ;
+	unsigned long start_time;
+	unsigned long end_time;
+	int err;
+
+	start_time = jiffies;
+	end_time = start_time + timeout;
+	do {
+		/* prevent noisy/benign devcmd failures */
+		err = pdsc_devcmd_with_data_nomsg(pdsc, &cmd, info, info_sz,
+						  comp, 60);
+		if (err != -EAGAIN)
+			break;
+
+		/* if required, subsequent commands check status of
+		 * PDS_CORE_CMD_SEND_COMPONENT command, which returns
+		 * EAGAIN while the command is still running,
+		 * else we get the final command status.
+		 */
+		cmd.send_component.operation = PDS_CORE_SEND_COMPONENT_STATUS;
+		msleep(20);
+	} while (time_before(jiffies, end_time));
+
+	if (err == -EAGAIN || err == -ETIMEDOUT)
+		dev_err(pdsc->dev, "PDS_CORE_CMD_SEND_COMPONENT timed out\n");
+
+	return err;
+}
+
+static int pdsc_flash_component_chunk(struct pdsc *pdsc, struct device *dev,
+				      struct pds_core_flash_component *info,
+				      u16 info_sz, const u8 *data, u16 copy_sz,
+				      u32 offset, u8 slot_id,
+				      union pds_core_dev_comp *comp)
+{
+	struct pdsc_deferred_dma *deferred;
+	dma_addr_t dma_addr;
+	u8 *component_data;
+	int err;
+
+	deferred = kmalloc_obj(*deferred, GFP_KERNEL);
+	if (!deferred)
+		return -ENOMEM;
+
+	component_data = kmemdup(data, copy_sz, GFP_KERNEL);
+	if (!component_data) {
+		kfree(deferred);
+		return -ENOMEM;
+	}
+
+	dma_addr = dma_map_single(dev, component_data, copy_sz, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma_addr)) {
+		dev_err(dev,
+			"Failed to dma_map component_data at offset 0x%x copy_sz 0x%x\n",
+			offset, copy_sz);
+		kfree(component_data);
+		kfree(deferred);
+		return -ENOMEM;
+	}
+
+	err = pdsc_devcmd_send_component(pdsc, info, info_sz, dma_addr,
+					 copy_sz, offset, slot_id, comp);
+	if (err == -ETIMEDOUT || err == -EAGAIN) {
+		pdsc_deferred_dma_add(pdsc, deferred, dma_addr,
+				      component_data, copy_sz, DMA_TO_DEVICE);
+		return err;
+	}
+
+	kfree(deferred);
+	dma_unmap_single(dev, dma_addr, copy_sz, DMA_TO_DEVICE);
+	kfree(component_data);
+
+	return err;
+}
+
+static int pdsc_flash_component(struct pldmfw *context,
+				struct pldmfw_component *component)
+{
+	char component_name_buf[PDSC_FW_COMPONENT_FULL_NAME_BUFLEN];
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct pds_core_flash_component *component_info;
+	const char *component_name = NULL;
+	struct device *dev = context->dev;
+	struct pdsc *pdsc = priv->pdsc;
+	u16 buf_sz, info_sz;
+	struct devlink *dl;
+	u8 component_type;
+	u32 total_len;
+	u32 offset;
+	int err;
+
+	if (pdsc_skip_component(priv, component->identifier))
+		return 0;
+
+	component_type = pdsc_get_component_type_by_id(pdsc,
+						       component->identifier);
+	if (component_type) {
+		const char *type_name = pdsc_fw_type_to_name(component_type);
+
+		if (type_name) {
+			snprintf(component_name_buf, sizeof(component_name_buf),
+				 "%s%s", PDSC_FW_COMPONENT_PREFIX, type_name);
+			component_name = component_name_buf;
+		}
+	}
+
+	total_len = component->component_size;
+	dev_dbg(dev,
+		"component name %s class %u id %u act_meth %u ver_str %.*s index %u size %u\n",
+		component_name ?: "(unknown)", component->classification,
+		component->identifier, component->activation_method,
+		component->version_len, component->version_string,
+		component->index, component->component_size);
+
+	buf_sz = sizeof(pdsc->cmd_regs->data);
+	info_sz = struct_size(component_info, version_str,
+			      component->version_len);
+	if (info_sz > buf_sz) {
+		dev_err(dev, "component_info size %d too big, max size: %d\n",
+			info_sz, buf_sz);
+		return -ENOSPC;
+	}
+	component_info = vzalloc(info_sz);
+	if (!component_info)
+		return -ENOMEM;
+
+	component_info->comparison_stamp =
+		cpu_to_le32(component->comparison_stamp);
+	component_info->image_size = cpu_to_le32(total_len);
+	component_info->classification = cpu_to_le16(component->classification);
+	component_info->identifier = cpu_to_le16(component->identifier);
+	component_info->options = cpu_to_le16(component->options);
+	component_info->version_str_type = component->version_type;
+	component_info->version_str_len = component->version_len;
+	memcpy(component_info->version_str, component->version_string,
+	       component->version_len);
+
+	dl = priv_to_devlink(pdsc);
+
+	offset = 0;
+	while (offset < total_len) {
+		union pds_core_dev_comp comp = {};
+		u16 copy_sz;
+
+		copy_sz = min_t(unsigned int, PDS_PAGE_SIZE,
+				total_len - offset);
+
+		err = pdsc_flash_component_chunk(pdsc, dev, component_info,
+						 info_sz,
+						 component->component_data +
+						 offset, copy_sz, offset,
+						 PDS_CORE_FW_SLOT_INVALID,
+						 &comp);
+		if (err &&
+		    comp.send_component.compat_response &&
+		    (comp.send_component.compat_response_code ==
+		     PDS_CORE_COMPONENT_STAMP_IDENTICAL ||
+		     comp.send_component.compat_response_code ==
+		     PDS_CORE_COMPONENT_STAMP_LOWER)) {
+			err = 0;
+			devlink_flash_update_status_notify(dl, "Skipped",
+							   component_name,
+							   0, 0);
+			goto skip_component;
+		}
+
+		if (err) {
+			NL_SET_ERR_MSG_MOD(priv->extack,
+					   "Failed to flash component");
+			goto err_out;
+		}
+
+		offset += copy_sz;
+		devlink_flash_update_status_notify(dl,
+						   "Erasing/Flashing",
+						   component_name, offset,
+						   total_len);
+	}
+
+	vfree(component_info);
+	return 0;
+
+err_out:
+	devlink_flash_update_status_notify(dl,
+					   "Erasing/Flashing Component Failed",
+					   component_name, 0, 0);
+skip_component:
+	vfree(component_info);
+	return err;
+}
+
+static int pdsc_devcmd_finalize_update(struct pdsc *pdsc)
+{
+	union pds_core_dev_cmd cmd = {
+		.finalize_update.opcode = PDS_CORE_CMD_FINALIZE_UPDATE,
+		.finalize_update.ver = 1,
+	};
+	union pds_core_dev_comp comp = {};
+
+	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+}
+
+static int pdsc_finalize_update(struct pldmfw *context)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	const char *component_name = priv->params->component;
+	unsigned long start_time, end_time;
+	struct device *dev = context->dev;
+	struct pdsc *pdsc = priv->pdsc;
+	struct devlink *dl;
+	int err;
+
+	dl = priv_to_devlink(pdsc);
+
+	start_time = jiffies;
+	end_time = start_time + (PDSC_FW_INSTALL_TIMEOUT * HZ);
+	do {
+		err = pdsc_devcmd_finalize_update(pdsc);
+		if (err != -EAGAIN)
+			break;
+
+		dev_dbg(dev, "retrying finalize_update: %pe\n", ERR_PTR(err));
+		msleep(20);
+	} while (time_before(jiffies, end_time) && err == -EAGAIN);
+
+	if (err) {
+		devlink_flash_update_status_notify(dl, "Finalize Update Failed",
+						   component_name, 0, 0);
+		NL_SET_ERR_MSG_MOD(priv->extack, "Finalize update failed");
+		return err;
+	}
+
+	devlink_flash_update_status_notify(dl, "Finalized Update",
+					   component_name, 0, 0);
+	return 0;
+}
+
+static const struct pldmfw_ops pdsc_pldmfw_ops = {
+	.match_record = pdsc_match_record_descs,
+	.send_package_data = pdsc_send_package_data,
+	.send_component_table = pdsc_send_component_table,
+	.flash_component = pdsc_flash_component,
+	.finalize_update = pdsc_finalize_update
+};
+
+static int pdsc_pldm_firmware_update(struct pdsc *pdsc,
+				     struct devlink_flash_update_params *params,
+				     struct netlink_ext_ack *extack,
+				     const struct firmware *fw)
+{
+	struct pds_core_fwu_priv priv = {};
+	int err;
+
+	if (!pdsc->fw_components.num_components) {
+		err = pdsc_get_component_info(pdsc);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to get component info");
+			return err;
+		}
+	}
+
+	if (params->component) {
+		u8 type = pdsc_name_to_fw_type(params->component);
+
+		if (!type || !pdsc_component_type_exists(pdsc, type)) {
+			NL_SET_ERR_MSG_MOD(extack, "Unknown component name");
+			return -ENOENT;
+		}
+	}
+
+	INIT_LIST_HEAD(&priv.components);
+	priv.context.ops = &pdsc_pldmfw_ops;
+	priv.context.dev = pdsc->dev;
+	priv.params = params;
+	priv.extack = extack;
+	priv.pdsc = pdsc;
+
+	err = pldmfw_flash_image(&priv.context, fw);
+	pdsc_free_fwu_priv(&priv);
+
+	return err;
+}
+
+int pdsc_firmware_update(struct pdsc *pdsc,
+			 struct devlink_flash_update_params *params,
+			 struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
+	    pdsc->dev_ident.capabilities &
+		cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
+		err = pdsc_pldm_firmware_update(pdsc, params, extack,
+						params->fw);
+	else
+		err = pdsc_legacy_firmware_update(pdsc, params, extack);
+
+	/* Invalidate cached component info so next info_get refreshes */
+	pdsc->fw_components.num_components = 0;
+
+	return err;
+}
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..17b64177871a 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -246,6 +246,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	mutex_init(&pdsc->devcmd_lock);
 	mutex_init(&pdsc->config_lock);
 	spin_lock_init(&pdsc->adminq_lock);
+	INIT_LIST_HEAD(&pdsc->deferred_dma_list);
+	spin_lock_init(&pdsc->deferred_dma_lock);
 
 	mutex_lock(&pdsc->config_lock);
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -311,6 +313,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 		destroy_workqueue(pdsc->wq);
 	mutex_destroy(&pdsc->config_lock);
 	mutex_destroy(&pdsc->devcmd_lock);
+	pdsc_deferred_dma_free(pdsc);
 	pci_free_irq_vectors(pdsc->pdev);
 	pdsc_unmap_bars(pdsc);
 err_out_release_regions:
@@ -452,6 +455,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 	}
 
 	pci_disable_device(pdev);
+	pdsc_deferred_dma_free(pdsc);
 
 	ida_free(&pdsc_ida, pdsc->uid);
 	pdsc_debugfs_del_dev(pdsc);
@@ -499,6 +503,7 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
+	pdsc_deferred_dma_free(pdsc);
 }
 
 static void pdsc_reset_done(struct pci_dev *pdev)
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 619186f26b5b..5a1fafaccf20 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -40,6 +40,13 @@ enum pds_core_cmd_opcode {
 	PDS_CORE_CMD_FW_DOWNLOAD	= 4,
 	PDS_CORE_CMD_FW_CONTROL		= 5,
 
+	PDS_CORE_CMD_GET_COMPONENT_INFO	= 6,
+	PDS_CORE_CMD_SEND_PKG_DATA	= 7,
+	PDS_CORE_CMD_SEND_COMPONENT_TBL	= 8,
+	PDS_CORE_CMD_SEND_COMPONENT	= 9,
+	PDS_CORE_CMD_FINALIZE_UPDATE	= 10,
+	PDS_CORE_CMD_MATCH_RECORD_DESC	= 11,
+
 	/* SR/IOV commands */
 	PDS_CORE_CMD_VF_GETATTR		= 60,
 	PDS_CORE_CMD_VF_SETATTR		= 61,
@@ -100,6 +107,14 @@ struct pds_core_drv_identity {
 	char   driver_ver_str[32];
 };
 
+/**
+ * enum pds_core_dev_capability - Device capabilities
+ * @PDS_CORE_DEV_CAP_PLDM_FW_UPDATE: Device only supports FW update via PLDM
+ */
+enum pds_core_dev_capability {
+	PDS_CORE_DEV_CAP_PLDM_FW_UPDATE = BIT(0),
+};
+
 #define PDS_DEV_TYPE_MAX	16
 /**
  * struct pds_core_dev_identity - Device identity information
@@ -119,6 +134,9 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @max_fw_slots:     Number of firmware components reported by device
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
+ * @rsvd2:	      Word boundary padding
  * @capabilities:     Device capabilities
  *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
@@ -133,6 +151,8 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le16 max_fw_slots;
+	u8     rsvd2[6];
 	__le64 capabilities;
 };
 
@@ -279,11 +299,20 @@ enum pds_core_fw_control_oper {
 	PDS_CORE_FW_GET_LIST               = 7,
 };
 
+/**
+ * enum pds_core_fw_slot - Firmware slot identifiers
+ * @PDS_CORE_FW_SLOT_INVALID: Let firmware select slot based on package metadata
+ * @PDS_CORE_FW_SLOT_A:       Primary firmware slot A
+ * @PDS_CORE_FW_SLOT_B:       Primary firmware slot B
+ * @PDS_CORE_FW_SLOT_GOLD:    Gold/recovery firmware slot
+ * @PDS_CORE_FW_SLOT_MAX:     Sentinel value indicating no slot resolved
+ */
 enum pds_core_fw_slot {
 	PDS_CORE_FW_SLOT_INVALID    = 0,
 	PDS_CORE_FW_SLOT_A	    = 1,
 	PDS_CORE_FW_SLOT_B          = 2,
 	PDS_CORE_FW_SLOT_GOLD       = 3,
+	PDS_CORE_FW_SLOT_MAX        = 0xff,
 };
 
 /**
@@ -450,6 +479,364 @@ struct pds_core_vf_ctrl_comp {
 	u8	status;
 };
 
+/**
+ * struct pds_core_send_pkg_data_cmd - Send package data command
+ * @opcode: Opcode PDS_CORE_CMD_SEND_PKG_DATA
+ * @ver: Driver's max support version of this command
+ * @total_len: Total length of the package data
+ * @offset: Offset in the package data, non-zero if multiple commands are
+ *	    needed for sending the package data
+ * @data_len: Length of data stored at data_pa
+ * @data_pa: Data physical address for DMA to device
+ *
+ * The package data may be too large to store in a single buffer, so multiple
+ * PDS_CORE_CMD_SEND_PKG_DATA devcmds may be needed.
+ */
+struct pds_core_send_pkg_data_cmd {
+	u8 opcode;
+	u8 ver;
+	__le16 total_len;
+	__le16 offset;
+	__le16 data_len;
+	__le64 data_pa;
+};
+
+/**
+ * struct pds_core_send_pkg_data_comp - Send package data completion
+ * @status: Status of the command (enum pds_core_status_code)
+ * @ver: Device's max supported version of this command
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_send_pkg_data_comp {
+	u8 status;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_component_tbl - Component table details
+ * @comparison_stamp: Comparison stamp used for component version checks
+ * @classification: Vendor specific classification info
+ * @identifier: Component's ID
+ * @transfer_flag: Part of the component table this request represents
+ * @version_str_type: The types of strings used
+ * @version_str_len: Length of @version_str
+ * @version_str: Component version information
+ */
+struct pds_core_component_tbl {
+	__le32 comparison_stamp;
+	__le16 classification;
+	__le16 identifier;
+	u8     transfer_flag;
+	u8     version_str_type;
+	u8     version_str_len;
+	u8     version_str[];
+};
+
+/**
+ * struct pds_core_send_component_tbl_cmd - Send component table command
+ * @opcode: Opcode PDS_CORE_CMD_SEND_COMPONENT_TBL
+ * @ver: Driver's max support version of this command
+ * @slot_id: enum pds_core_fw_slot
+ * @rsvd: Word boundary padding
+ *
+ * Expects to find component table info (struct pds_core_component_tbl)
+ * in cmd_regs->data.  Driver should keep the devcmd interface locked
+ * while preparing the component table info.
+ */
+struct pds_core_send_component_tbl_cmd {
+	u8 opcode;
+	u8 ver;
+	u8 slot_id;
+	u8 rsvd;
+};
+
+enum pds_core_component_resp_code {
+	PDS_CORE_COMPONENT_VALID = 0x0,
+	PDS_CORE_COMPONENT_STAMP_IDENTICAL = 0x1,
+	PDS_CORE_COMPONENT_STAMP_LOWER = 0x2,
+	PDS_CORE_COMPONENT_STAMP_OR_VERSION_INVALID = 0x3,
+	PDS_CORE_COMPONENT_CONFLICT = 0x4,
+	PDS_CORE_COMPONENT_PREREQS_NOT_MET = 0x5,
+	PDS_CORE_COMPONENT_NOT_SUPPORTED = 0x6,
+	PDS_CORE_COMPONENT_FW_TYPE_INVALID = 0xd0,
+};
+
+/**
+ * struct pds_core_send_component_tbl_comp - Send component table completion
+ * @status: Status of the command (enum pds_core_status_code)
+ * @ver: Device's max supported version of this command
+ * @completion_code: Component completion code
+ * @response: Component response
+ * @response_code: Component response code
+ * @slot_id: Actual slot_id of the component (enum pds_core_fw_slot)
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_send_component_tbl_comp {
+	u8 status;
+	u8 ver;
+	u8 completion_code;
+	u8 response;
+	u8 response_code;
+	u8 slot_id;
+	u8 rsvd[2];
+};
+
+/**
+ * enum pds_core_send_component_op - PDS_CORE_CMD_SEND_COMPONENT operation
+ * @PDS_CORE_SEND_COMPONENT_START: Initial operation to start transfer
+ * @PDS_CORE_SEND_COMPONENT_STATUS: Subsequent calls to check on status
+ */
+enum pds_core_send_component_op {
+	PDS_CORE_SEND_COMPONENT_START = 0,
+	PDS_CORE_SEND_COMPONENT_STATUS = 1,
+};
+
+#define PDS_CORE_FW_COMPONENT_ID_INVALID 0xFFFF
+/**
+ * struct pds_core_flash_component - Component details
+ * @comparison_stamp: Comparison stamp used for component version checks
+ * @image_size: Component image size
+ * @classification: Vendor specific classification info
+ * @identifier: Component's ID
+ * @options: Component options
+ * @rsvd: Word boundary padding
+ * @version_str_type: The types of strings used
+ * @version_str_len: Length of @version_str
+ * @version_str: Component version information
+ */
+struct pds_core_flash_component {
+	__le32 comparison_stamp;
+	__le32 image_size;
+	__le16 classification;
+	__le16 identifier;
+	__le16 options;
+	u8 rsvd[3];
+	u8 version_str_type;
+	u8 version_str_len;
+	u8 version_str[];
+};
+
+/**
+ * struct pds_core_send_component_cmd - Send component command
+ * @opcode: Opcode PDS_CORE_CMD_SEND_COMPONENT
+ * @ver: Driver's max supported version of this command
+ * @slot_id: enum pds_core_fw_slot
+ * @operation: enum pds_core_send_component_op
+ * @offset: Offset into the component, non-zero if multiple commands
+ *	    are needed for a single component
+ * @data_len: Length of this part of the component stored at @data_pa
+ * @rsvd: Word boundary padding
+ * @data_pa: DMA address of the component
+ *
+ * A component may be too large to store in a single buffer, so multiple
+ * PDS_CORE_CMD_SEND_COMPONENT devcmds may be needed.
+ *
+ * Expects to find flash component info (struct pds_core_flash_component)
+ * in cmd_regs->data. Driver should keep the devcmd interface locked
+ * while preparing and sending the flash component info.
+ */
+struct pds_core_send_component_cmd {
+	u8 opcode;
+	u8 ver;
+	u8 slot_id;
+	u8 operation;
+	__le32 offset;
+	__le32 data_len;
+	u8 rsvd[4];
+	__le64 data_pa;
+};
+
+/**
+ * struct pds_core_send_component_comp - Send component completion
+ * @status: Status of the command (enum pds_core_status_code)
+ * @ver: Device's max supported version of this command
+ * @completion_code: Completion code
+ * @compat_response: Compatibility response (0 = Component can be updated)
+ * @compat_response_code: Compatibility response code
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_send_component_comp {
+	u8 status;
+	u8 ver;
+	u8 completion_code;
+	u8 compat_response;
+	u8 compat_response_code;
+	u8 rsvd[3];
+};
+
+/**
+ * enum pds_core_fw_component_type - Firmware component type
+ * @PDS_CORE_FW_TYPE_UNKNOWN: Unknown component type
+ * @PDS_CORE_FW_TYPE_MAIN: Main firmware
+ * @PDS_CORE_FW_TYPE_BOOT: Boot loader
+ * @PDS_CORE_FW_TYPE_CPLD: CPLD firmware
+ * @PDS_CORE_FW_TYPE_SECURE: Secure firmware
+ * @PDS_CORE_FW_TYPE_FPGA: FPGA configuration
+ * @PDS_CORE_FW_TYPE_SUC_MAIN: System Unit Controller firmware
+ * @PDS_CORE_FW_TYPE_SUC_BOOT: System Unit Controller bootloader
+ * @PDS_CORE_FW_TYPE_UBOOT: U-Boot bootloader
+ *
+ * Gold/recovery variants are identified by slot_id == PDS_CORE_FW_SLOT_GOLD
+ * and reported with a ".gold" suffix (e.g., fw.gold).
+ */
+enum pds_core_fw_component_type {
+	PDS_CORE_FW_TYPE_UNKNOWN   = 0,
+	PDS_CORE_FW_TYPE_MAIN      = 1,
+	PDS_CORE_FW_TYPE_BOOT      = 2,
+	PDS_CORE_FW_TYPE_CPLD      = 3,
+	PDS_CORE_FW_TYPE_SECURE    = 4,
+	PDS_CORE_FW_TYPE_FPGA      = 5,
+	PDS_CORE_FW_TYPE_SUC_MAIN  = 6,
+	PDS_CORE_FW_TYPE_SUC_BOOT  = 7,
+	PDS_CORE_FW_TYPE_UBOOT     = 8,
+};
+
+/**
+ * enum pds_core_component_info_flags - Component info flags
+ * @PDS_CORE_FW_COMPONENT_INFO_F_RUNNING: Component is currently running
+ * @PDS_CORE_FW_COMPONENT_INFO_F_STARTUP: Component version on next FW boot
+ * @PDS_CORE_FW_COMPONENT_INFO_F_FIXED: Component is fixed and cannot be updated
+ * @PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME: Component can be updated
+ *	by name
+ */
+enum pds_core_component_info_flags {
+	PDS_CORE_FW_COMPONENT_INFO_F_RUNNING = BIT(0),
+	PDS_CORE_FW_COMPONENT_INFO_F_STARTUP = BIT(1),
+	PDS_CORE_FW_COMPONENT_INFO_F_FIXED = BIT(2),
+	PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME = BIT(3),
+};
+
+/**
+ * struct pds_core_fw_component_info - GET_COMPONENT_INFO entry
+ * @name: Component's name
+ * @component_type: enum pds_core_fw_component_type
+ * @rsvd: Word boundary padding
+ * @flags: enum pds_core_component_info_flags
+ * @identifier: Component's identifier
+ * @slot_id: Component's slot identifier
+ * @version: Component's version
+ */
+struct pds_core_fw_component_info {
+#define PDS_CORE_FW_COMPONENT_NAME_BUFLEN 24
+	char name[PDS_CORE_FW_COMPONENT_NAME_BUFLEN];
+	u8 component_type;
+	u8 rsvd[3];
+	__le16 flags;
+	u8 identifier;
+	u8 slot_id;
+#define PDS_CORE_FW_COMPONENT_VER_BUFLEN 32
+	char version[PDS_CORE_FW_COMPONENT_VER_BUFLEN];
+};
+
+#define PDS_CORE_FW_COMPONENT_LIST_LEN	((PDS_PAGE_SIZE - 8) / \
+		sizeof(struct pds_core_fw_component_info))
+
+/**
+ * struct pds_core_component_list_info - GET_COMPONENT_INFO completion data
+ * @num_components: Number of valid components
+ * @rsvd: Word boundary padding
+ * @info: List of valid components
+ */
+struct pds_core_component_list_info {
+	u8 num_components;
+	u8 rsvd[7];
+	struct pds_core_fw_component_info info[PDS_CORE_FW_COMPONENT_LIST_LEN];
+};
+
+/**
+ * struct pds_core_get_component_info_cmd - GET_COMPONENT_INFO command
+ * @opcode: PDS_CORE_CMD_GET_COMPONENT_INFO
+ * @ver: Driver's max supported version of this command
+ * @data_len: Length of data at data_pa
+ * @rsvd: Word boundary padding
+ * @data_pa: DMA address of data
+ *
+ * FW populates struct pds_core_component_list_info pointed to by @data_pa
+ */
+struct pds_core_get_component_info_cmd {
+	u8 opcode;
+	u8 ver;
+	__le16 data_len;
+	u8 rsvd[4];
+	__le64 data_pa;
+};
+
+/**
+ * struct pds_core_get_component_info_comp - GET_COMPONENT_INFO completion
+ * @status: enum pds_core_status_code
+ * @ver: Device's max supported version of this command
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_get_component_info_comp {
+	u8 status;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_finalize_update_cmd - FINALIZE_UPDATE command
+ * @opcode: PDS_CORE_CMD_FINALIZE_UPDATE
+ * @ver: Driver's max support version of this command
+ * @rsvd: Word boundary padding
+ *
+ * Driver sends at the end of updating all components to finalize the update
+ */
+struct pds_core_finalize_update_cmd {
+	u8 opcode;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_finalize_update_comp - FINALIZE_UPDATE completion
+ * @status: enum pds_core_status_code
+ * @ver: Device's max supported version of this command
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_finalize_update_comp {
+	u8 status;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_match_record_desc_cmd - MATCH_RECORD_DESC command
+ * @opcode: PDS_CORE_CMD_MATCH_RECORD_DESC
+ * @ver: Driver's max supported version of this command
+ * @type: PLDM Descriptor Identifier Type
+ * @size: Length of the Descriptor Identifier Value
+ * @rsvd: Word boundary padding
+ *
+ * Expects to find the Descriptor Identifier Data in cmd_regs->data. Driver
+ * should keep the devcmd interface locked while preparing and sending this
+ * command.
+ */
+struct pds_core_match_record_desc_cmd {
+	u8 opcode;
+	u8 ver;
+	__le16 type;
+	__le16 size;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_match_record_desc_comp - MATCH_RECORD_DESC completion
+ * @status: enum pds_core_status_code
+ * @ver: Device's max supported version of this command
+ * @match: Whether or not the Record Descriptor matches the device
+ * @rsvd: Word boundary padding
+ *
+ * When status is PDS_RC_SUCCESS, then @match is valid, otherwise it's
+ * undefined.
+ */
+struct pds_core_match_record_desc_comp {
+	u8 status;
+	u8 ver;
+	u8 match;
+	u8 rsvd;
+};
+
 /*
  * union pds_core_dev_cmd - Overlay of core device command structures
  */
@@ -466,6 +853,13 @@ union pds_core_dev_cmd {
 	struct pds_core_vf_setattr_cmd   vf_setattr;
 	struct pds_core_vf_getattr_cmd   vf_getattr;
 	struct pds_core_vf_ctrl_cmd      vf_ctrl;
+
+	struct pds_core_get_component_info_cmd get_component_info;
+	struct pds_core_send_pkg_data_cmd      send_pkg_data;
+	struct pds_core_send_component_tbl_cmd send_component_tbl;
+	struct pds_core_send_component_cmd     send_component;
+	struct pds_core_finalize_update_cmd    finalize_update;
+	struct pds_core_match_record_desc_cmd  match_record_desc;
 };
 
 /*
@@ -484,6 +878,13 @@ union pds_core_dev_comp {
 	struct pds_core_vf_setattr_comp   vf_setattr;
 	struct pds_core_vf_getattr_comp   vf_getattr;
 	struct pds_core_vf_ctrl_comp      vf_ctrl;
+
+	struct pds_core_get_component_info_comp get_component_info;
+	struct pds_core_send_pkg_data_comp      send_pkg_data;
+	struct pds_core_send_component_tbl_comp send_component_tbl;
+	struct pds_core_send_component_comp     send_component;
+	struct pds_core_finalize_update_comp    finalize_update;
+	struct pds_core_match_record_desc_comp  match_record_desc;
 };
 
 /**
-- 
2.43.0


