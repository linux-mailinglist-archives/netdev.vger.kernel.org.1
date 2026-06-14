Return-Path: <netdev+bounces-299145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ULqHIeY1LmobqwQAu9opvQ
	(envelope-from <netdev+bounces-299145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:02:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF0680600
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:02:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=qKQCVBCm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299145-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 516D9303298E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6373090C5;
	Sun, 14 Jun 2026 05:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266C3093DB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:01:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781413288; cv=fail; b=OJKNdhqmBa6nD1flnBwiskrLs9NNR6ecoTbJvWBgx/HkBzx0bG4LZ8r3JFSnuB1R687zCpWdFYvc5RXbDrRlkIXkwQM/RmjVRGKKRo361G9gm7fQCK3UkBFXfiYuqftg8C++a849oEaM7saM5sa5xgPr1Nus+OtFqOUq/pL2u3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781413288; c=relaxed/simple;
	bh=USM3663R4Mik7Ye2jpSNNWKprDpWo9sjvKnYoPjmOAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Olw7RnfQeVULt20ARwXeu23nGsIpHE6w1Aak2hiSjQDyG/CXqvJeegMQINR7aJMu6+0cPN90C6gjodzM5dMJ53o88nRgEcFyBs63IHxdziEEOAxF0qwUEDYyZP+vwXbKCQyjb7kXPAMOEcYTIhIKpktCyatPqltql6Iee3gltno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qKQCVBCm; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZ7eif7dU4lFUtdUpc9CeUMfD+Mh1vbWYQY7Wui6TKGW+YfIDPaKcERb56a85xecJG06fXnwgZgO2dD+EKOLDlvBi9Hq6do0E2nfFCj1UrsNJg7Ss+5uZuGeiH4jwiaMzuK9dFixaereBr0MbQNsxUHzx95NLn+wA6W6A6r79aL7M4ZFA1DfSxtNgliJH2Ak+tNj9DuR59dJMQljgDjLTa2iSj0cxjoHHswSY2zZdIllYDdOdbKMmtbqbrbAIRhGWcOq4UhHAZOQML+zYVFvy1ANoaSy0QNmk7Ni+Y+I17sKw3dqrTOU6fOOGFokHK9pSDF8BWfBCRnnaaQ/yirH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzjGu2lYpQ/Tg5uFafDaHrM5sA7BOY3PIdVAf1hT4f4=;
 b=C7R0F1k4oZUptVbovSj17ju2nnpLgLSmm1DBDfYBdnkUIaWtt/VFoYTxq5Is6jY4UbWcekaVL/8Z8fTt5MBh5NbrURolX8vEiQ6WyPJpvTbhJ2NATTCjBNY/u0n6nBTL1sMAUE7MFHddcr5Y88Udu9AEbqiCa1wgiKILVg8AVBtGrqUZ4YuFsl+79sVm1RcgDO2Odh9oYLbYBRUxxajrUBCT5E0aDsFK0iMnAoIjOWUnngIzsRMgmpLUxttTAs2iNei4yyY5nHjBGQuZBN2pEu5qcy9Ab9TiaSwhdwx7lRtszQJJe9YmevfneCgQ9rwj5CsWwBbhTqUAqznhOeMxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzjGu2lYpQ/Tg5uFafDaHrM5sA7BOY3PIdVAf1hT4f4=;
 b=qKQCVBCm+454Lx+WRtCigvzb9bqisrNoVSUu0eBmm4wjrS8LcN9PEDlXGRoQkJaN5VA6BluOsCf9oiQLeAiq7HRBZpPfJYMjl1QXXa9St0Lnp0hM0bPzmeV/NiDcKYkASlRIvlNveQBGp1eZTjuiVvCcc+XeRXLL+mY7XKZdkuI=
Received: from CY5PR13CA0062.namprd13.prod.outlook.com (2603:10b6:930:a::13)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 05:01:19 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::91) by CY5PR13CA0062.outlook.office365.com
 (2603:10b6:930:a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 05:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 05:01:19 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 00:01:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH v4 4/6] pds_core: add PLDM component info display
Date: Sun, 14 Jun 2026 05:00:50 +0000
Message-ID: <20260614050052.1048328-5-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614050052.1048328-1-nikhil.rao@amd.com>
References: <20260614050052.1048328-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 05031b3d-9cfc-4c70-15de-08dec9d1f8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	LKLBSL2JpE+Taearf/sLtuLP1gX6hj/5Cf+aH+66lMQOAp0ujPsa+nKhS4F33iXbMZKL/OD0c7++b4aS5w7DVkLhW9IZhEyFaXv99jvFl92IqrZhfhh3cNxaNUtCON2opTaySRqm9OaKQIpf2068+m5biwj7BJoC5qqMN6/bI5vZuyIbf8dSHU/Dx7odMgZz5pjQ40C6Lym8EUtQZKpcmAMDABgLkBzLuXCJRiiwYF3LtYTi3WqOGOLPnwnXgZeU2lLBEwjG0e+JeVujjDvOUYCI3a2E1KTLHF0slTh+zHPuliOK2YxI9JPU/9sz0ubZZYPXjv8DEfrk1avxIATPLX7R2zaZc9cEzlJroTnZK4gWqzxKb0RgRjyoACFxkUFO4a+g2+l+7/v/B1uWmJflD2wvMCwC8KT33uW6vVEOvjxtmsENKs0Q+KoRZxq3iAELB07pxkD4mceogyqkbeCHw8UIAljKdDXcRFC8bJ900+hH+FOgO2IeBi8qeaPSD7oTDA52g07tngIcC08VHpjNW7t2o7+rRPmwdJrfpTvVEA+y3axsSlZAwr4+nv+mCxdaoP0sz++XElPQoSbiX7/dDqM8dYXx7XehCh2ssdhofAbgjddArVqF/mH72lALEzKBayoYfZkPfncVTd40VZBkfHab4rk8L8cEIHIsZGTQ2BR/ZfzKm4M5/+Y9k+DVKVyYLHRRXDlLAaEOCRoDnvTdMMh6PK5xcaiSf0WvdgDghyo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8blai3SuiUIZtvE6c7jJfmm9aPb4TknBRlc9LAXbZlKphzeIBpOa96J3itxfmq/MPxCvhSH2Cy3ik+balsM6DZtEFWpsaeUvehWMH4KpFy8hvQ16BoFwyFKRb0SiXj4RM9nKjxwOpFJ1uEY0d/cDkKNFqkzTVub8gwUjkkftAhwGegkEC0IIR6iTr5OfoZgoMuN5c6NRRe4xEp9HwyN+smsSE6O0WhOjCF+Z2iElAXHG2bnULNuO8ecu9GJD1D8xrbDT4W5RljkQ5R46rfUTihgTq/8EMooxsQcxyVQGJtxfJx1E54xPhZmNR8cjFSZrCvX4enFHX1PXrQX+ETzFbck7U5xzztaNYOr//n3lwTh1blAd3H38ag8g76/QPfblIEgXCMzVDzUe7bS5Fq4Unx3hhVsEF0lPsPPeK1wuaGjUOJM7BL9JTMJickPmYVLE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 05:01:19.4805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05031b3d-9cfc-4c70-15de-08dec9d1f8f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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
	TAGGED_FROM(0.00)[bounces-299145-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,fw.gold:url,uboot.gold:url];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4EF0680600

From: Brett Creeley <brett.creeley@amd.com>

Add detailed component information display via devlink info. This
allows users to see individual firmware components and their versions.
Components are reported as fixed, running, or stored based on their
firmware-provided flags.

Example output:
  $ devlink dev info pci/0000:00:05.0
  versions:
    fixed:
      asic.id 0x0
      asic.rev 0x0
    running:
      fw.bootloader 1.2.3
      fw.uboot 1.60.0-73
      fw 1.60.0-73
      fw.cpld 3.18
    stored:
      fw.bootloader 1.2.3
      fw.uboot 1.60.0-73
      fw.uboot.gold 1.50.0-22
      fw.gold 1.50.0-22
      fw 1.60.0-73
      fw.cpld 3.18

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 .../device_drivers/ethernet/amd/pds_core.rst  |  16 +--
 drivers/net/ethernet/amd/pds_core/devlink.c   | 132 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/fw.c        |  14 +-
 3 files changed, 147 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst b/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
index 71f0222589bb..9444daeaae1b 100644
--- a/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
+++ b/Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
@@ -115,8 +115,8 @@ Individual components can also be updated by specifying the component name::
   # devlink dev flash pci/0000:b5:00.0 \
             file firmware.pldmfw component fw.cpld
 
-Per-component update uses driver-defined component names (fw.mainfw,
-fw.cpld, etc.). Not all components support per-component update -
+Per-component update uses driver-defined component names (fw, fw.cpld,
+etc.). Not all components support per-component update -
 devlink will reject the request if the specified component cannot
 be updated.
 
@@ -133,12 +133,9 @@ names. The driver reports the following component versions:
      - Type
      - Description
    * - ``fw``
-     - running
-     - Version of firmware running on the device
-   * - ``fw.mainfw``
      - running, stored
      - Main firmware
-   * - ``fw.mainfw.gold``
+   * - ``fw.gold``
      - stored
      - Gold (recovery) firmware
    * - ``fw.bootloader``
@@ -181,13 +178,12 @@ Example output::
           asic.rev 0x0
         running:
           fw.bootloader 1.2.3
-          fw.mainfw 1.3.0
-          fw.cpld 3.18
           fw 1.3.0
+          fw.cpld 3.18
         stored:
           fw.bootloader 1.2.3
-          fw.mainfw.gold 1.2.0
-          fw.mainfw 1.3.0
+          fw.gold 1.2.0
+          fw 1.3.0
           fw.cpld 3.18
 
 Health Reporters
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 3b763ee1715e..2f40b97affd6 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -93,14 +93,105 @@ int pdsc_dl_flash_update(struct devlink *dl,
 	return pdsc_firmware_update(pdsc, params, extack);
 }
 
+static int pdsc_dl_report_component(struct devlink_info_req *req,
+				    struct pds_core_fw_component_info *info)
+{
+	enum devlink_info_version_type ver_type;
+	u16 flags = le16_to_cpu(info->flags);
+	char *ver = info->version;
+	const char *name;
+	char buf[32];
+
+	/* Main firmware is reported as generic "fw" */
+	if (info->component_type == PDS_CORE_FW_TYPE_MAIN) {
+		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
+			snprintf(buf, sizeof(buf), "fw.gold");
+		else
+			snprintf(buf, sizeof(buf), "fw");
+	} else {
+		name = pdsc_fw_type_to_name(info->component_type);
+		if (!name)
+			return 0;
+
+		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
+			snprintf(buf, sizeof(buf), "fw.%s.gold", name);
+		else
+			snprintf(buf, sizeof(buf), "fw.%s", name);
+	}
+
+	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
+		ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED) {
+		int err;
+
+		err = devlink_info_version_fixed_put(req, buf, ver);
+		if (err)
+			return err;
+	}
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING) {
+		int err;
+
+		err = devlink_info_version_running_put_ext(req, buf,
+							   ver, ver_type);
+		if (err)
+			return err;
+	}
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_STARTUP) {
+		int err;
+
+		err = devlink_info_version_stored_put_ext(req, buf,
+							  ver, ver_type);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int pdsc_dl_component_info_get(struct devlink *dl,
+				      struct devlink_info_req *req,
+				      struct netlink_ext_ack *extack)
+{
+	struct pds_core_component_list_info *list_info;
+	struct pdsc *pdsc = devlink_priv(dl);
+	u8 num_components;
+	int err;
+	int i;
+
+	if (!pdsc->fw_components.num_components) {
+		err = pdsc_get_component_info(pdsc);
+		if (err) {
+			dev_err(pdsc->dev, "Failed to get component_info %pe\n",
+				ERR_PTR(err));
+			return err;
+		}
+	}
+
+	list_info = &pdsc->fw_components;
+	num_components = min_t(u16, list_info->num_components,
+			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));
+	for (i = 0; i < num_components; i++) {
+		err = pdsc_dl_report_component(req, &list_info->info[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static char *fw_slotnames[] = {
 	"fw.goldfw",
 	"fw.mainfwa",
 	"fw.mainfwb",
 };
 
-int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
-		     struct netlink_ext_ack *extack)
+static int pdsc_dl_fw_list_info_get(struct devlink *dl,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
 {
 	union pds_core_dev_cmd cmd = {
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
@@ -134,12 +225,49 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			return err;
 	}
 
+	return 0;
+}
+
+static int pdsc_dl_info_get_v1(struct devlink *dl,
+			       struct devlink_info_req *req,
+			       struct netlink_ext_ack *extack)
+{
+	struct pdsc *pdsc = devlink_priv(dl);
+	int err;
+
+	err = pdsc_dl_fw_list_info_get(dl, req, extack);
+	if (err)
+		dev_warn_once(pdsc->dev, "Failed to get fw list: %pe\n",
+			      ERR_PTR(err));
+
+	/* Version 1: report fw from dev_info (running only) */
 	err = devlink_info_version_running_put(req,
 					       DEVLINK_INFO_VERSION_GENERIC_FW,
 					       pdsc->dev_info.fw_version);
 	if (err)
 		return err;
 
+	return 0;
+}
+
+int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
+		     struct netlink_ext_ack *extack)
+{
+	struct pdsc *pdsc = devlink_priv(dl);
+	char buf[32];
+	int err;
+
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2) {
+		err = pdsc_dl_component_info_get(dl, req, extack);
+		if (err)
+			dev_warn_once(pdsc->dev, "Failed to get component info: %pe\n",
+				      ERR_PTR(err));
+	} else {
+		err = pdsc_dl_info_get_v1(dl, req, extack);
+		if (err)
+			return err;
+	}
+
 	snprintf(buf, sizeof(buf), "0x%x", pdsc->dev_info.asic_type);
 	err = devlink_info_version_fixed_put(req,
 					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index 0ef34869fdc0..1374d7bea013 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -21,9 +21,11 @@
 #define PDSC_FW_COMPONENT_FULL_NAME_BUFLEN \
 	(sizeof(PDSC_FW_COMPONENT_PREFIX) + PDS_CORE_FW_COMPONENT_NAME_BUFLEN)
 
-/* Driver-defined component type to name mapping */
+/* Driver-defined component type to name mapping.
+ * PDS_CORE_FW_TYPE_MAIN is NULL - handled specially as "fw" without prefix.
+ */
 static const char * const pdsc_fw_type_names[] = {
-	[PDS_CORE_FW_TYPE_MAIN]      = "mainfw",
+	[PDS_CORE_FW_TYPE_MAIN]      = NULL,
 	[PDS_CORE_FW_TYPE_BOOT]      = "bootloader",
 	[PDS_CORE_FW_TYPE_CPLD]      = "cpld",
 	[PDS_CORE_FW_TYPE_SECURE]    = "secure",
@@ -45,6 +47,10 @@ static u8 pdsc_name_to_fw_type(const char *name)
 	size_t prefix_len;
 	int i;
 
+	/* "fw" without suffix maps to main firmware */
+	if (!strcmp(name, "fw"))
+		return PDS_CORE_FW_TYPE_MAIN;
+
 	prefix_len = str_has_prefix(name, PDSC_FW_COMPONENT_PREFIX);
 	if (prefix_len)
 		name += prefix_len;
@@ -752,7 +758,9 @@ static int pdsc_flash_component(struct pldmfw *context,
 	if (component_type) {
 		const char *type_name = pdsc_fw_type_to_name(component_type);
 
-		if (type_name) {
+		if (component_type == PDS_CORE_FW_TYPE_MAIN) {
+			component_name = "fw";
+		} else if (type_name) {
 			snprintf(component_name_buf, sizeof(component_name_buf),
 				 "%s%s", PDSC_FW_COMPONENT_PREFIX, type_name);
 			component_name = component_name_buf;
-- 
2.43.0


