Return-Path: <netdev+bounces-299719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNiDO2K3MGoyWgUAu9opvQ
	(envelope-from <netdev+bounces-299719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194468B835
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=xPL17y3Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299719-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB2D313433B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627FC3ABD98;
	Tue, 16 Jun 2026 02:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEA3C1973
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:36:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577385; cv=fail; b=rZczF4/nvnRbZ0ToaR3bm6m2RkcoOZycSs7N3IRXKkGRvj4a/0SsN4DW28CsjvUT830Y5Rf2E0On7Ax3BFBHtV65jcBpzpgRcDH1rQZ0se9z6PZMyd2x/IZXhKysxBPWehHbH8OvqdZeq8qG/5pdVwJ65uSqQB3bpoa8O+Vgg7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577385; c=relaxed/simple;
	bh=5JTPkHKc4NgoExMxO5Yo5eMa1I+v+Mi4miLYFI9j2F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlVjkHi4aObBo2sYs4O825SpUEbOPDF/Db5OjOnGPUwsd1HkCeQqIwK/jvA5Lbmj3BEQ/7HZUGLJHhfTAJ9EwHleA79cexCPAJokL0/E8vFNd1YaLLx3amwg5G3pWq458pHdhCY6GmVNDWviNvYoOWm7cTCV+g3l3UaW3BQ1k0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xPL17y3Z; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB9bSHWABqunjJ8uetfhGrABIp1ew0Fwis4SCGf+o7X/IYSTMrKaIho1Cg/Kch2Ibw82aKdupgu1O8Gj7Rbtj+ngi7SWazxeseRq9nfGx1yvcLne5S4KGCZhhLUSn4qkMviiYEMlhRiKAInsXnr61YAhAcks9MvQWVZMItzwb5NRn3I7JbRCSRG96xOMXTx+ZuLKU4TA56/GtaNYuXUw/IuS362xyIr0hNTeH6xqPUWrovZ1NvIi2AvNF0Azu8ULORm4N7qidXg6ESTXYSlS2iaPL3Z0czGDPg5d5mY+pP1gZY0bhitE1Je4mgliGJpqoF4YEJU6WatRrkDkEP4d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lILFp15qJZxXn0fE+rTc4FSn0Qxyt954zuDXhzhouqU=;
 b=NImVLN59lUH85BFF9xnzjV+DPrmQghwmHnr0oDX1MAiZhb5FpPC3U0Ig8YtpPgbeWqlnCb5thyQpJOeOXyqr7OmTdeVuElsOEu8Ep39a7Uctr0EzqiT7JTB3bQe2cUd2WW0/LhrfwOWnWFaAYOH4LsYLTTy7UQW06rSSxzLHHajM1GNK//eUeHsEZ+HiejNDFSWJhXQpD1WkbUJad/cxprlXGmZsjpuyP2burM6OC3dyepjPATyzKGN6yU97HCpnfqPI9liwNSi1UV2YuXPkaKIUtgzNunRriPa1UAGg6lWxhn+enht20uFs+MKH/o3Fd29L9FaY5dm5XZgq3myVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lILFp15qJZxXn0fE+rTc4FSn0Qxyt954zuDXhzhouqU=;
 b=xPL17y3ZysFDMxyzU7IqQknI60tVhZabEN8x6L5C6nCspInFJrNyhkwKRFaEvcCLda8pnT6PUABWmfrdbFKFSKvwoHoka7VWJXZkR77biPIW3JLzyCmZF9rcyJAL9xrq7wFfJAnnR5RlWJ+RuomIk20NBKNpz9iiZNg9Rf/km6s=
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:36:19 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::2d) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 02:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 02:36:19 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 21:36:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH net-next v5 4/6] pds_core: add PLDM component info display
Date: Tue, 16 Jun 2026 02:35:52 +0000
Message-ID: <20260616023554.258764-5-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a318006-6bbc-424b-f29a-08decb500c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	EM+sJvZ9QXiSbm1IGQhcEAc9pk7FsmrP/sDIilWS9PYja+EG/7V0EJn/PGfnT7X9Ogad60mGoTSNJClKiu20WfM+ilJ7mFkymrhG1HA5YA0k/Vty4eFt4gItLLxretymAU+XStW44kukk9GE0JA4xZviHT4qVgEt87bqhCJ8W66pk73PuB0e6lv5mmmVS1nO9rx24ctUJIMaTRWGY8m3HtjnY2MOdlCSdssb1T9Valot8Na5vSdBrm3+MzN6UjjLpHuproKH9+Y6cW5NhrkRVtcgkw8nlYMNuK8M9t3plxytjSKT2uy4bMwoO6KmuIoGwrICwEyLd4rUjIPBapVi8dqPAtpD/YV9fLG+/qut2wzApEDybac867kuD4x/F4IM81Y/+Ud5it1BlXiw7FAHg62Bd/8hTsoqD3Qwp8ihErhY/phO4wr1t2hm7RrEf3PKXeaugrr3U9KU6RDb+j0gXXnrGWiOfkVZaQPUfhredQkO5jzgeZoPG2BCsLg1eYA2+H0FUqbXc6JPqQO2VODn18LAf9pjpTadKF15Tb40ZmCN5oRo/XQk6JOKdL4yn+/umGvBL3/mVVEUxD6vwqwk/vN5sC4kIFjr8Casia1ncU19pvRJ5YN1eWvAa9g7LOZYuaW6Ba3eT3n80n9EXDGNIQZbwxWeDnO4PBtYEsQ2nL81IjiFbvgOJm1XLKrkCQud8gyCeaegMXp4VcWCkjqkRRY2D1W60KOT8mHoPcwQPkc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EcHNkb2C+Y39zgM7yonqhkeyjiRP9LOeb/2ffhj/6NNHF/IAP11h6zLLEY1TWfIbz7KUqh8J/KX1b+XbkkVbX5Aj8NSCTnGcNHhYZDNtpLXq60kxMyeK8w4dC8RtjExXdXDlpSUsCf/oG4B08nR548CvgH3RVha9X7f5YNUj1I4xEWYwK8mI7LMISClnFMP9djLREBAINeC2JLS31BYfyxjgV+lfam3+RJ51w5uUf7bGnlDn4+5B2shMpsjfr0s8srvNkhM6ej83mjPy1JE2U9aEr0ysz/xREpPKEoBb3duEFtLoCe75qJyU6i01Mh+O571nXtx7047LgYDsjFSa6NTxq8WGKya4lqen3KPwk7vgHNurYnOqsCPn/KrpQ6m8CaSjhLcKhREfTgo9Oh9KbEtphtOlPAbd9EgeU14LMOQ+FAC7mRjTVgKfUnx27VM2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:36:19.4580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a318006-6bbc-424b-f29a-08decb500c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299719-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fw.gold:url,uboot.gold:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5194468B835

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
 drivers/net/ethernet/amd/pds_core/core.c    |   2 +
 drivers/net/ethernet/amd/pds_core/core.h    |   1 +
 drivers/net/ethernet/amd/pds_core/devlink.c | 135 +++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/fw.c      |  11 +-
 4 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 705cab7b0727..00164cbd9f08 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -576,6 +576,8 @@ void pdsc_fw_up(struct pdsc *pdsc)
 		return;
 	}
 
+	pdsc_fw_components_invalidate(pdsc);
+
 	err = pdsc_setup(pdsc, PDSC_SETUP_RECOVERY);
 	if (err)
 		goto err_out;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index c686f0bbbaeb..73356c74bb9f 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -340,6 +340,7 @@ int pdsc_firmware_update(struct pdsc *pdsc,
 			 struct netlink_ext_ack *extack);
 int pdsc_get_component_info(struct pdsc *pdsc);
 const char *pdsc_fw_type_to_name(u8 type);
+void pdsc_fw_components_invalidate(struct pdsc *pdsc);
 
 void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 3b763ee1715e..aa759c6dbe10 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -93,14 +93,110 @@ int pdsc_dl_flash_update(struct devlink *dl,
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
+static int pdsc_dl_report_fw_ver(struct devlink_info_req *req, char *fw_ver)
+{
+	return devlink_info_version_running_put(req,
+						DEVLINK_INFO_VERSION_GENERIC_FW,
+						fw_ver);
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
+		if (err)
+			return pdsc_dl_report_fw_ver(req,
+						    pdsc->dev_info.fw_version);
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
@@ -134,12 +230,41 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			return err;
 	}
 
-	err = devlink_info_version_running_put(req,
-					       DEVLINK_INFO_VERSION_GENERIC_FW,
-					       pdsc->dev_info.fw_version);
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
 	if (err)
 		return err;
 
+	/* Version 1: report fw from dev_info (running only) */
+	return pdsc_dl_report_fw_ver(req, pdsc->dev_info.fw_version);
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
+			return err;
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
index c15bcd26ad9b..c007dd2a749d 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -42,6 +42,11 @@ const char *pdsc_fw_type_to_name(u8 type)
 	return NULL;
 }
 
+void pdsc_fw_components_invalidate(struct pdsc *pdsc)
+{
+	pdsc->fw_components.num_components = 0;
+}
+
 static u8 pdsc_name_to_fw_type(const char *name)
 {
 	size_t prefix_len;
@@ -758,7 +763,9 @@ static int pdsc_flash_component(struct pldmfw *context,
 	if (component_type) {
 		const char *type_name = pdsc_fw_type_to_name(component_type);
 
-		if (type_name) {
+		if (component_type == PDS_CORE_FW_TYPE_MAIN) {
+			component_name = "fw";
+		} else if (type_name) {
 			snprintf(component_name_buf, sizeof(component_name_buf),
 				 "%s%s", PDSC_FW_COMPONENT_PREFIX, type_name);
 			component_name = component_name_buf;
@@ -958,7 +965,7 @@ int pdsc_firmware_update(struct pdsc *pdsc,
 		err = pdsc_legacy_firmware_update(pdsc, params->fw, extack);
 
 	/* Invalidate cached component info so next info_get refreshes */
-	pdsc->fw_components.num_components = 0;
+	pdsc_fw_components_invalidate(pdsc);
 
 	return err;
 }
-- 
2.43.0


