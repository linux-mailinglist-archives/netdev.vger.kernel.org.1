Return-Path: <netdev+bounces-302848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fdZ6Bpj5QmoBLAoAu9opvQ
	(envelope-from <netdev+bounces-302848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3A6DF216
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=170dfL0F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302848-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302848-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C532A301254D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496335A393;
	Mon, 29 Jun 2026 23:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785137269B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:02:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774163; cv=fail; b=Hv06udtBkmxyB4H48ZLND1P+zNLGC+qIR51bj29IeJamZBhW4rjOoGwaklYc9zQlZAe+Z3SXrHuOe40FAIfzyvkKm4Pe7Hu9bHAGFUtVFRKLZ5AWszJVDIqNukP8H6w+qrqfRD/MMJE/z1dGtWmwsmTJrhXtuLOxpAv/GKTAuGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774163; c=relaxed/simple;
	bh=G4aTGuPzwGCBtUMvvM0uBZPsgpif3/z9j8bXe7lB7ms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k03C7k+djzT9yBSuZHtxjBZSyvtgKDR22gB0KB9Os4IY3aQWqYDFniaYPk05OlOKQXmgdm0l9fdEwpG23TrYCuyoizH5oxuTMm845nQjPB6u77GmIdRO+75HOQ0zRFrPqC27+jUVdJpl12DKVxY2Ssr6WjFEX4yTwtlQYZASiQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=170dfL0F; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ciz0rRBjDad6HPvd3LM5ud+g91qOsgBvzhqTwgK95x8e0Zkpu+/P1ftL/BCJ9zRvhUFeOwu1HrBPtCYeDrVKtMi+P2zyxPBauc0df4DccX+PchIh6uasULzftJc1WFyoUDiBYHkwBcZl0r9d2VMxN0A6H/JfV7JiS4f8uweHQSvOxdMSqxzZ9bE11wGtPZ0xIKrAhKeZvsDe4HbIIBt0KFYuE7o32zYTjpraw9otZUOwcVkNC/0k9+2qn03Oz7kKZQJjN0g7yil/Gori8aJvwcsbrAa9i754/FcKY8PxqBLLgObSXf6Dy8NPQ5ZkbXJ1GVFXOZB7mqcQqMZ9KkYPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6odXhVBc9faQkriRLxVLhVFwtNcLRbw50ef1cqwK3Y=;
 b=nwOWDL5Ezfm9rJ4P0wCLbjpdfLAuSLybcfqWvemyF3hEa0UP+Fbd6RYGSnsgpCKm8jTN5f7yjNjWz8fs0VKULufGA7GXPe1vWCqNDOiOayAoi8sFD9fg5HclBFO4lRoOCBrpqlLNtgvJNLW6M5CZxmtB6WzxECDEMnCt8rwiP2Nvwa0wu/I1teWIybO5EpCrwaamIUoYTvl0PlILH62dgiXE6PmVTkmGxho1UpvQAnsMTP6eC7lYvYAy9DO/U/F6mtWSGwmN9tyJefM/2uctam46NAxs40YxojK/j9uEOc1wVHaV7ScsSycisAVr/esqaV81+MNl5bj7TXRYnCOJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6odXhVBc9faQkriRLxVLhVFwtNcLRbw50ef1cqwK3Y=;
 b=170dfL0FRFWpZcfRGhdBcEHQVs0jJBtYl2J6mjVphaMX6AWt5WezblztCMDjXnlVHfYQadBLCm6JqlUEeAK99WqQ0mdYTmeti/ba6Hzwt6LCh1riZvoixwDilx69xwRovfkeneQca4Ab9jZc0a8ZHxHWz87KsdQAzWk6EVFJ8uk=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:02:32 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::26) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 23:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 23:02:31 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 18:02:30 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 4/6] pds_core: add PLDM component info display
Date: Mon, 29 Jun 2026 23:01:58 +0000
Message-ID: <20260629230200.82092-5-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629230200.82092-1-nikhil.rao@amd.com>
References: <20260629230200.82092-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d35d00-0932-47ef-9ab9-08ded6327fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sxt4y5eq2cbMl2CvVfN5WTOJaH6mctugeIYOGlxzljjxGNQfPvxeHVjVHl1AVroTiCTnzwAZ4ebsLqhtWhMqqBeo2Ya2YBfbvU8A04L8D4yh0vzxZQuPUPBCvrU7xpuz7LS6MZsGzSH0AGa+/vYsOmkO2Wcl7hocVglH6L0CdzsqzzvfwcIkTtDu/ntsTAmhCmI3mYi4uJ7D3Ug811i6Sp4xSVVpn8aeiV1NEubovypLdVClAfW3Mm7dXA08mA9FeImjvCQVWE3hAlgtsRfPTpf6HokIIdlO+WxF1lL7xWilOptUj/vRkYcS5EI9ucunFZ/1y15y4a9NqniOPziIEXV0Q6alhRRyZSAtuK6LMM9Jo//AjVJRL5lCLu604kKyFn0CUe5b9DHULgFhegFDG0N5ziERG1YoRFBzdJhw2KE1HsQOVXtHpEsuclSfUVCQ/o+ETyW4GPclvhewBEkiM4rW4ROK0udJOhhlazZsLAIaSN9S29pMwFX0LkgQjxruYXWZfZszYK7zKLXxayXGp50hHfV2aqwCTRUbvdu1OXph9oEG/cXWygFQvTi74FzPz6sVCzUXNXXFowBr2r2MmxF6oH6FNrQD6ab2bBv0ZnmuoMAWPXDM3/EZLiJMc0T0hP/LrTDymjdAmyDX9MmWGYPYJuAJDC5yG5qSaWOnYI2/1y5nrOdXjwlh/eJGNvSnQTDH3tikP60f+8ffT0pZYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+wasEzPn2uYNLfqQZi2UA/CF6T2sRMy5dJdKTUG07zfDJdYf08k0kYZRrB1Db872cnDd6vSJ34Weq0hNepP69SS9WfB1GiLOTvssNV5ZiUpchS8TxmlMiDu9JG+3ejTPOlHOVs5hpDR3wSCkwxKXRCccs8Q8Zg2zGykGA1Lay6LApdFU0ZOtOKAJwD1J0sy3zY1GWfVu/m7mDG3/FL/na53pSReTv+DkrTHxdAWo6EHsCXIYHf7wHNXa7wWq7btAxeZAF7amjSHof7TtJq09oiQ229/EzUHGRSLMNkleTqZbvwt8j4p+vv9OFlsZaMAmyhsKWplh7eB7MngkOFnlX/RMwsG9Fr+2n7ZSoRR8kk93kSEfWb9537Pj3Q93wIXBENBZxS1ZK458HrTP4P/YZdNesmnTF6RhHphtn/Wv2pHqT9PJcF4Uk4XJr6M7lRjN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:02:31.1396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d35d00-0932-47ef-9ab9-08ded6327fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302848-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AA3A6DF216

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
index 38a2446571af..4d9ab8b74ec6 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -580,6 +580,8 @@ void pdsc_fw_up(struct pdsc *pdsc)
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
index 3b763ee1715e..bd234c3c50b2 100644
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
+		if (err || !pdsc->fw_components.num_components)
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
index 433b0a8df4c1..6d7e06921ff1 100644
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


