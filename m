Return-Path: <netdev+bounces-282275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOlhD7G68Wl1kAEAu9opvQ
	(envelope-from <netdev+bounces-282275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4803490E10
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B22A530783BA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF03A6EF0;
	Wed, 29 Apr 2026 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fKqkm0BW"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF783A544A;
	Wed, 29 Apr 2026 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449505; cv=fail; b=dOELyP092x7agtxSULo5KeEemyNtZ1bt3/D8PEIiWRswWDFL1WSnYvh/IVjuhZwPAZvTKaeHWT7Tj+vX0t3DyYKvBwfE0tZ4fsp0iRqjGFl8Of7OhoGJRyL0D1Ur4BfDAHmhg1efk/+wkbfKkYN4aFNe/xdjWParddlflpAdw5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449505; c=relaxed/simple;
	bh=Pxfj0aMFAjgOC68mesnrDf0itOVSZrZsmsJxJGjmVZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hpw6fWZsl0ZcC4Jbyt3RHhwYVZvIXAJGOAX3rU3YTllR2LJtn7zc3YbiiJmgN0DIe4ww43PJSj0s2VEv9LGsQdpgtmtq0wUn7ZAaWhwijArLGI1OOA+tuMiIRDuOmrrNEjDKuK2hdfmbbcSpmHd4rTehSH8xVlQChM1b1nWQdGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fKqkm0BW; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj051g2SqHqzKcLu02/X6nVhAXSBY0FDOWjFn7/4J/fY8VCfdzDJXX7nufTYvfXfGgCcOWdsZ8wLXUOt5SnGzWch3cuOuKrWgRlJadw1+DaqLYbiPbx7brVWgfoBSCU6cpt0SNBtqF95uru3I/H1vM+PH3sdLCuEWzIhJvQ5Eoa6hBOX46QVjWlWAx3UsVRSc/jmbDlnVbdO42Llfxqb5lo4BGLk5+raZNC0KznpUQUvkB++60OmV1zZdGFGnMokw14/XLJ5oG3PB4L35LdSinB9+d+2F0akhCa1vwQqibZS/PpzWjz3bvLJn3HuWFnHJMslcHqd5FY3i033x+7PLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdtAtnpBAO3qpDcIHt2f/jzL8Y7+0rmyYfn49+UY9yc=;
 b=uoL9NZfPgunYxdyeZzbQQLTCLCe5XdMsg+XzMHqzctUGoK4vB7KPm6BmdxIe+w93zsystaC4d0/eBbjZ2dyC463AOjyS8ub8woCQ+5Y+5PjPcndgzSI4vk0LqNv1yTUyfcFYi9/EV1wuj9uP6+Y+evTqXZ6pJywGHncMNr9KTH4Hhz8CJlh5seYVOWdYvulsBa4WHN3TMsiN3d+x1X7eUPLysnkNi2kDssGAC3RHeV4dhn46JXkUBbdX39dFPprHc9rPOBOnpCtKd4AZrgaGxD8+umx6yXmZ7yP85MRHSqUZnJkVBvQV6kOl8eAPApoEBeCYuuBtGFsAAmaJk8DEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdtAtnpBAO3qpDcIHt2f/jzL8Y7+0rmyYfn49+UY9yc=;
 b=fKqkm0BW9ua2jV85bzV9l/YhY0uF0LdW5HLreXPl6eWwA25lTZcfniyFZsCaQUUpqYeUVqA22Mvhc/DfJSuSfVZskhidTNOtK1cNmRIv8BtVBME45usja/+YqrQIeJ+GznacBRAN0boHUIcPgFC7hAchecPJAMumfKKLn+QuJCo=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 07:58:19 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::3a) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 07:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:58:19 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 02:58:17 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 07:58:06 +0000
Subject: [PATCH 2/6] pds_core: add support for identity version 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-2-e43b6c92e46c@amd.com>
References: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: a8eeedb1-e69a-4762-d6e1-08dea5c513bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	q3AlyP4AOoI9sgqIGgUYRgEt6H+aNMpYEAFEiACEWUZm0UnU80MEsSeKGOHoflsm3nHct8x5RR/oNF9y3A2JEzEfdtIsshKFEPm2xegSRE+JqNxA6xlfznUCnX/kgZfUn+Io6pzfoU53r/hdsVXndWPrSNKqw/bMikOxtsYy31y+hIRcfUD5p3js/0tgE+g2x0Bv0vOGbkYW7LqVCOkjPv/bT8J7K52YzBjSlkEEnwh/gU5Fz/otxQgkU1cR4+aOgOnFWrYv4Y3eRXv1xkgD1NF91+aAwhD7rtJcF3RVJxGs/C24KLha34vSIWu3RLk5chNhrI/dweJ9b9zorYUOoL9S9ZvS0Hkhv2d5WQNMjRKMXNMBInVBl7XAdMC2Q5iTDM89UTgGcuzmYvm8isSHTZcLcPP7sLDAgs5pyMNzWTAQRKP+415+hHf2NOdcDo7VS94IxaX3f2Mo/sDJ2NO9/gqbAZDQuDdbYENbbV8oDUNmMR46/U+Zcq6ii0NyciuNPbC9I1+r8ca0CuezfBvgh7CnCs7qBJDLRLFkfxrhsFNcB7NXA69UFK9bh+GQQhsp9XQby8nD8INdkE/8DYkF4yH00pnW51DFW+P+go3GulTliHgN6wZpNzww7Ry69YADmxK0/72vtYRRKXKmCF3amRevLjWGHSzpnPYSA6KdmWIjnvZIlDqCDgM8EV4jhhgowt5mf5BiDwB2HUaV/RE35kzwHBNljSduBCeSsDJJ54EFkmKR2T1egJ+tD8dc/CF6xtj26N/3VfVglj8NoJUJvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ofPj45QBmJz0x5RgWVJ+E62z0OK31Y9ss38YfAkgzNJYcxQDRDQ6w5Br8De+YPVNvU8jl4dD/YHEVcW+EZUGb6Cee6T0ZY3uBjO9R1KxhFwvERYOAqXIG0APNEGLTi6JIEXfhwpzQsP8gIMSdNXD+PxcUp7CsPgmDHP6yYvR6yPD0I/vpZkJDAZZLE5mDQLGPPImAghZs5/D4mEVyXBcfU9VnjwkI4gRoBk+fUWcZsFX4njrp3GHqnrI8Sx07wT9KjvkvFol0j7hwmF3TLKY026fJy4jxXPF4gBH//kWZlvewEquGqUcJN+qyr7ShXzDq00KA6fBC8zV1mgIYPaFwzia9N8GKnPr4mfbpmUue4s+1768I7CIR4oP/RzdD5+41PNYMderYN3AlcOLV4IBpJSYHCjbcb9fzYKBHHyVYpoJOJjs4cFEOmPhC19JaN3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:58:19.1266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eeedb1-e69a-4762-d6e1-08dea5c513bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
X-Rspamd-Queue-Id: C4803490E10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282275-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

Add a new capabilities field in struct pds_core_drv_identity,
which requires bumping the identity version to 2, i.e.
PDS_CORE_IDENTITY_VERSION_2. If version 2 negotiation fails,
then quietly fall back to version 1. If version 1 negotiation
fails, then driver load will fail.

Another patch in the series will make use of the capabilities
field.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 28 +++++++++++++++++++++++-----
 include/linux/pds/pds_core_if.h         |  4 ++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 5b86d6cd0ac3..f77bd5e48b92 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -243,15 +243,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
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
@@ -274,8 +276,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -298,7 +301,7 @@ static int pdsc_identify(struct pdsc *pdsc)
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
@@ -327,6 +330,21 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTIFY_VERSION_1
+	 * instead of returning the max supported identify version, so retry if
+	 * firmware doesn't support PDS_CORE_IDENTIFY_VERSION_2
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


