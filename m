Return-Path: <netdev+bounces-296762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ykQCGl5FJ2rCuAIAu9opvQ
	(envelope-from <netdev+bounces-296762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:42:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F374A65B085
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:42:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=bGc7UYYP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296762-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296762-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CE75303EA65
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F03BB68B;
	Mon,  8 Jun 2026 22:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73153B993B;
	Mon,  8 Jun 2026 22:41:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958466; cv=fail; b=l76J4d+8Ee6GoQbuQHyLZt5aTIeQiM5+3U1Xm70OOddrvm785t8Ivhrw88rgZF3KW+CQHzslIbnFjeTpZKV95a2W7phQtsm3AJ0rHM8g/yVqLH3Es5FhWCvXsajgbn8uoGOyAIE/N2PdPSrEHNzl7xDpygDW2s2trvpPB7uN69o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958466; c=relaxed/simple;
	bh=pAI4ITWuOcTeh5Ry7fRJwRmP9VqaR3xNyLPyVRi9BYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSRA0JvxK6ZgWjPSroZ/I+A1J2/yxrIsBWCbvu61QujQpKF6vajhFtgD2EnliVHmNpXpLDIwxjECo+5S1peYRhu5B5dPWecxP2mwksCIbUU7j3n2Vvpb6GwsEFWnP+wsQLFzxoDH1tvKTRiMes4kmwvP/L/XIZnz6Lh+mhFJzOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGc7UYYP; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dq0v2UZ1PcSoWwCQolw0ZI+lAUdtJP/2Ri7AWmuqbOcdEQKjOOQthAqAOfgQiyd2ZJmdJS5euyzFjwHkO8F3OBRF9XTwmuvdAR4nB7nxsfFHOrJmMA+TobXmlE7J14tLmjtI+ktI5p2g0ufZHEsg3eNdlHuv0B3BdkGVoyBWLe7DFqrzyhNZ5BnqjrpjNOWB6mfvHCIghUIOXb3kL0B5OVdNJumY2ILeZbP42fr7KmMeIUe4Z3FiEfSymUGho5gDK5DY+8QDcO0uYY0uBfsJLKU870dcDVD6mBxrpoImAJt4MHNin6Beq7mB9eqonjxBbhqGyCb9Fzi3e3UKG3ERKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpN0IUuY5ZD8BHh5FFvAZvbvSCY9Pj+MrDEypW+orhQ=;
 b=Pu1KhJq1p19D3UpOlvt5vTbAXraF5laVQUylfLKqTcl+leYRpqYOspUyRdq4wHA0DbrcEjS2wRzE8NtkbB9ZOy4B93vBMZrr4e4pEDiJVn1UPQ/yeoOTjH7ldB33mOVQxHZJrL8f7Za1fAGr2ffjZprNZ1pRUqABW20ieqsOaB5cPLe64tixquyor+pzCZM2cWFzzILvJbpIYMSPxNFKrb7JIHJBeWlIxhlHQd4sPUDly4vpJ8Pe/Tjm5ZT60GMGu/GiI5S5s23Z2jtXnBYP5Ka7Xt0nrf3BmdoSbev1/SPhS+6UXIo4NBpaik5rHCZ2sLwlEPFueHPcKTXcsZPh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpN0IUuY5ZD8BHh5FFvAZvbvSCY9Pj+MrDEypW+orhQ=;
 b=bGc7UYYPawZpwqcrxPP9DEGxdXsoZhAPoEZcxvYdFyt8ZHMlgKW2uzhvNCR9LLXxCslfHbP1f+9iQ7ZU5YH92pjGlhILG0y4RCkQmj/NelEabK/ZjsG+ApT9RRpc2EAF5XAh882cF5DK2QrsGHFQwVdSOAOwYCos1moZBtPPLgI=
Received: from IA4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::10)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 22:41:00 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:558:cafe::45) by IA4P220CA0009.outlook.office365.com
 (2603:10b6:208:558::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 22:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:41:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:40:54 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:33:14 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH v3 4/6] pds_core: add PLDM component info display
Date: Mon, 8 Jun 2026 22:32:54 +0000
Message-ID: <20260608223256.12357-5-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608223256.12357-1-nikhil.rao@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4e0a79-acda-469c-560f-08dec5af037e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KwJ+vaQtKtViyCo5yjkbuG6wTOQ5uE/QwdHM5rROoj+YZMxZAAz362/AOwXcirCwrSha3GD1KMQwE6mRn6MrWv18xLfHFaB3n/HAJJLUnoAev8b/ppaz5mK8NX40LQA/q1mMzxRUEcbD1qQ0ltM/cXOoxMFgKz4R/BuYrdrAdDwTi7juUq2FEJn5fJeYvywf3vXiuRQhUlYvHf/v0lHtahxRK3wAbYHbXdyfBDxMmpKAWeB+8ny5hPxs5xgVA1Jxcdf514pnbkeKyl3kFLAnyys56q+CgVs7XmCS0TxWY2J7ad0H4U/lyFJWKgc8fffOEV85KMyIXxdxkLlIvq4LP7ENnTIGX+MkBGIQWgvYWyxwADMPIrmKDsZ0TfUpkrx0vUq4Q5PP99y925cZpy010jfBTqTyhKQWhrtaPmclEsM5ZCeNW82k7Q59tnMM7/GU+Zc3rLQQjF5ckw2dig3b4UUR0VUhC359UbFC6ZUzE3725L+D4yXiQEQEtZm/7OupXz2zGzGC/BUd9ifSqAbBeV9vrgw26mRHilyqaAnZHgorkq3n9aZkjhZHL3dENQmMp4lqwo7z3bLFxIwMQ/xOTtqEAC+H7+BRuGhzWQHWA0GlYvZhtlBuCr+UidlmCYj8Qh8p51OmgDIJhdLGF06GhPP3xv2funvrrGtixTDhTWbbm3qxIdBmswvZiJ0BN0IeYQ0D8BLiZqehv4TNxo65sucw4iLkI7k+AIom5BV1ItE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UmpIkWSsUq5mZNEm2pwbeHOziuzgU0I1VMjuVEJcJdPPsoH+brnLfymwKCGoyXkBYamIQA3kn4i3RlpkyHzRte50cj4SFa/NDw5UIsRnljOqoQ9bfwnWQbbZOHrDHM65ijZeSyUA80ivyZc/6Dy72Fw+TK3BnXuK130DcIKlQ5eq3NQLzHD6BfRXUrnOBUHBqdJcPzC0lpdL42H6VHwWVf9ycKwrBQG7MqNfJWzD4dqrCCeElM9IU2A1Qv0x53KkowAXABWXS0AbX0nhRN61ZDas3QNsfaAoVoasdxWbH9KLWqFf/Qb/oHenwdiNvxwion7dN/k9oLwKpQXScqokeKo43o0heDEFMFxtJdO6VthDIXxjOrXU2IUbUBDsIJY6WUin54NRDrDJDf+QQoYc9pjZaRq/WzR1BZUNCltPPLb0DwELMcXjzldjZjBCQe4Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:41:00.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4e0a79-acda-469c-560f-08dec5af037e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296762-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F374A65B085

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
      fw.mainfw 1.60.0-73
      fw.cpld 3.18
      fw 1.60.0-73
    stored:
      fw.bootloader 1.2.3
      fw.uboot 1.60.0-73
      fw.uboot.gold 1.50.0-22
      fw.mainfw.gold 1.50.0-22
      fw.mainfw 1.60.0-73
      fw.cpld 3.18

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 105 +++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 3b763ee1715e..4be34d0cbb59 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -93,14 +93,97 @@ int pdsc_dl_flash_update(struct devlink *dl,
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
+	name = pdsc_fw_type_to_name(info->component_type);
+	if (!name)
+		return 0;
+
+	if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
+		snprintf(buf, sizeof(buf), "fw.%s.gold", name);
+	else
+		snprintf(buf, sizeof(buf), "fw.%s", name);
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
@@ -134,6 +217,24 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			return err;
 	}
 
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
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2)
+		err = pdsc_dl_component_info_get(dl, req, extack);
+	else
+		err = pdsc_dl_fw_list_info_get(dl, req, extack);
+	if (err)
+		dev_warn_once(pdsc->dev, "Failed to get component info: %pe\n",
+			      ERR_PTR(err));
+
 	err = devlink_info_version_running_put(req,
 					       DEVLINK_INFO_VERSION_GENERIC_FW,
 					       pdsc->dev_info.fw_version);
-- 
2.43.0


