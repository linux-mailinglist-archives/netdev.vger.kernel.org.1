Return-Path: <netdev+bounces-302842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mkdVAJD5Qmr3KwoAu9opvQ
	(envelope-from <netdev+bounces-302842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 775146DF20E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=FcOborOe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302842-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE60A300D753
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105A35A393;
	Mon, 29 Jun 2026 23:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB721D3E8
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:02:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774157; cv=fail; b=hrBiR7JgIjil2OxlkaBHvhYPIvCJ+d/6IuE/AD3fQvn71DfcY+N1CHKSd6s84ggodaU1vkFGXQmR68jnU3uYS7bd7TwAekYTLfA4KEF3LF3YezJZ5BB8ez0ZVH2gE5JlH3ZEN3+H66rYOq2vEYAl7tqUcJBt0njtCRa4zOhi91Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774157; c=relaxed/simple;
	bh=w2I1molMWkbcjeidl2UxxQD8MD1gWw2ZcgNNdF4jlKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv5AOVwVie9SS20OwPoCbD59oWaaillmjHj/UVqq0hmgal6noFGYITA5NifJpWxb8Fvl9lc437yHFRGjD8fhbUlwSXStI9vsGqJwGzBWLfX+/jC1pBtOjSvoLkzhNPCOmh2Hq1ZRynFgYcCRcdEqzvoroYSw7PYGb4wnzvKwgqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FcOborOe; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITxVRqnXc8ugVPOhDy4o7jbe6CULcRmjQEa5JGnEc3b2Q+JkCnOO6H6xcKwqqQfdkrIgc/RWPwOYRg3aoCnnqAGzaQFDmxC4vN1CglrU28lUNqKhhNNbXekIoKZ2ACpylMFliSrXofodK5x2vgr7Dr8ELuwOk9wMa5c0dV4MkGH5kOU+CIojyV72w9O7TQlaLb1tknVN5RGFlh9bojCDI9LMrA/4jbj4dfcdcFAOrJ9fF8QSCxBmOc+eqT2WP/jp2ZmgI8Pr/xuNsrKPZXuPu7/XTdL61UIwvv6LSqkC2oxHCYOY9onfvxralwk/Ii0crBfADKorWJRSDNHBWnKSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=mhjjdo3xj7HM7CKdK1EY9byoaF+4kCOjvAyH+3rycexQRWJbTu/JNjFkYTYc98JXuC/Fp8vkG5z8fKk5wNg3cczWsFK6Gell4QUMKcuVcmMDk/6bF/iMaEsxhWJdOLmAxRRk2svmAEA1JMU3p0SQWeqT6Rw7qJt1lbVZg8py7IeFl4S/pzQa/LY9CGvHvvlQgIio7jyBbbwfkBvI8hR+tl9nRqCVmAOH7/tGfiR7Bpq+Mw2YDRZBf5e2yHof8Sn+Bxk0yY6sAYtxe+7uVsiSAsUwmHvyln01aZGcbDLtAvWlJc8LD52JRnZQHSjwl4NRMICNdDaP+AY/KeQr+ZDljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=FcOborOefLnaiGYLd7k4HxXMiM6uM6WnVDyZCLjuqzynfaHcpmEdHJJye8dUrgOGhtaVpmZmG8tkxoHjLSOeo/nbKZjq8Ik4HnVzicSaEo/CxN2Zn8EubWBBPJxEvUAw4i5oq9jC8UBVynd7hDEBS86ou9qqVOn5RiODSZ7xtT8=
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:02:29 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::81) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 23:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 23:02:29 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 18:02:28 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 2/6] pds_core: add support for identity version 2
Date: Mon, 29 Jun 2026 23:01:56 +0000
Message-ID: <20260629230200.82092-3-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: df5a4707-7272-4581-3fd8-08ded6327ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|56012099006|22082099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SaS0RfAmMRG1Qt9GH8udHlWf0a0pNTwo7c7zExtrn6PpZtdD99Hal5Vol5I12QQjHkzOyUPFZ2HSAjGbCE+ZEtlKeVYF48iBkPmrGMZWEU7XEL90jQBd5gfNcTgWwWM4IaFbZdP17cOtGhRjtyBjjveeZvJvN5TgjbDVj77oIcVMojK8VVnWIm/0Qh1ti1JSu2GT7z8xoejNcYL6btJ95x61OuoUUNO0MjVg2N17FfroR2PbVJ74WsZIK553CPmFD/KkNK6D3yGpzRM/UPTVw7+xHriw9nBnz7H+gKjfyu+9jUDxX9PefNYHoIfV0OW2WtcfkQoq1c71eDh2+PCfNBGMDrNaRpBN6ZyV82MBMkQsOVBWREGuxJicSrlAeDfl+t3zmIoYkZUTwfshE37129Jv2SpwT7ckpJ+zXDCSJ6UvXN11XxLXRATIH4licRLBTfsXnZDp9vtrgulyy4PfCbu5Ho9nyMjz2Yl5oJikdVL752qFwv/mTXtBGYVKXmOSHYyuADDQd7mI64mo1v3+t1b8ZhCbOd0RFIMlxOBDgFWMojqCHwLwuAgnE59QBFKyXuyFAnCc44YTbn+1pXIpjcMtMVSD8b55bySBdH6Pcg5hRzTaxogPx6RwlfADhMYJV73w/aTU+2D5XNLprtkPkmo4b6hfSzfB9f7Q9jSg3ieymxxteMTYNOikvpk+6rwRw9Q6qrmEvW1k6WAr4J0KEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fFc8zAx8Jc0GHCCWpePR3LovwqXPmstRU3DTFgD2eHLHf0lYZv5wI9cqqK07gBJVB14n7zPMycRyGj3AY/pThyuUdxJr1Pp3TJRnc2+0a6kRhkc2Kgtn0Y1kakftGdXC/IqkBBcqeyZDJlqQ3aXBFe53a1XH/PWnNOsXpNwXuESipuIWiq+ghsX7LdbHeISXp+SzQTt42kTAbRelPi2OckrGQ0A7UyXSJ5yhJw1sN+HGVHYbsakOYpS7h+MHYRnVC1eKPnqezL/urrE2TeEksMtrWFbBxsTIungeDvYwCozJQiSVZUh6SSANhGxbfwkThAo4P7FWLs5lUbmcBULBGj7uqe9jF9NM3+qegsSFn7Wat/u4sNU1Y/n3kxeBqLrPAAF1KnPUxVrP+u5NQO9q7fL6R70UxK9jkSXU9bauMLSK2zqUrmdKzP6bkzuTICSm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:02:29.4730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5a4707-7272-4581-3fd8-08ded6327ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302842-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 775146DF20E

From: Brett Creeley <brett.creeley@amd.com>

Add a new capabilities field in struct pds_core_dev_identity,
which requires bumping the identity version to 2, i.e.
PDS_CORE_IDENTITY_VERSION_2. If version 2 negotiation fails,
then quietly fall back to version 1. If version 1 negotiation
fails, then driver load will fail.

Another patch in the series will make use of the capabilities
field.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 39 ++++++++++++++++++++-----
 include/linux/pds/pds_core_if.h         |  4 +++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index dd9989cfe6b3..5c0ca3d0b000 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -250,15 +250,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
-static int pdsc_devcmd_identify_locked(struct pdsc *pdsc)
+static int pdsc_devcmd_identify_locked(struct pdsc *pdsc, u8 drv_ident_ver,
+				       bool do_msg)
 {
 	union pds_core_dev_comp comp = {};
 	union pds_core_dev_cmd cmd = {
 		.identify.opcode = PDS_CORE_CMD_IDENTIFY,
-		.identify.ver = PDS_CORE_IDENTITY_VERSION_1,
+		.identify.ver = drv_ident_ver,
 	};
 
-	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	return __pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout,
+				    do_msg);
 }
 
 static void pdsc_init_devinfo(struct pdsc *pdsc)
@@ -281,8 +283,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -305,17 +308,24 @@ static int pdsc_identify(struct pdsc *pdsc)
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
 		memcpy_fromio(&pdsc->dev_ident, &pdsc->cmd_regs->data, sz);
+
+		/* V1 firmware doesn't set capabilities, so the field may
+		 * contain garbage from the outgoing driver identity.
+		 */
+		if (pdsc->dev_ident.version < PDS_CORE_IDENTITY_VERSION_2)
+			pdsc->dev_ident.capabilities = 0;
 	}
 	mutex_unlock(&pdsc->devcmd_lock);
 
 	if (err) {
-		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
-			ERR_PTR(err));
+		if (do_msg)
+			dev_err(pdsc->dev, "Cannot identify device: %pe\n",
+				ERR_PTR(err));
 		return err;
 	}
 
@@ -334,6 +344,21 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTITY_VERSION_1
+	 * instead of returning the max supported identity version, so retry if
+	 * firmware doesn't support PDS_CORE_IDENTITY_VERSION_2
+	 */
+	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
+	if (err)
+		err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_1);
+
+	return err;
+}
+
 void pdsc_dev_uninit(struct pdsc *pdsc)
 {
 	if (pdsc->intr_info) {
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 17a87c1a55d7..619186f26b5b 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -119,6 +119,8 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @capabilities:     Device capabilities
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
 struct pds_core_dev_identity {
 	u8     version;
@@ -131,9 +133,11 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le64 capabilities;
 };
 
 #define PDS_CORE_IDENTITY_VERSION_1	1
+#define PDS_CORE_IDENTITY_VERSION_2	2
 
 /**
  * struct pds_core_dev_identify_cmd - Driver/device identify command
-- 
2.43.0


