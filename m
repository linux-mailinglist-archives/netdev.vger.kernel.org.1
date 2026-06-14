Return-Path: <netdev+bounces-299143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RloGEL81LmoXqwQAu9opvQ
	(envelope-from <netdev+bounces-299143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83A6805F8
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:01:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=FrqQgQiK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299143-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299143-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82161302BDE4
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750530C630;
	Sun, 14 Jun 2026 05:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DB307AC6
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:01:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781413284; cv=fail; b=RX9Oyx9+6qOo+Zt5MiANFddVpiojPpyc7XPUYMkB5xUTcl1vZIyfuJ/vBlSwRuALCxcgIxn+cJOjXrFkuIRQsWvxKlRjmcv2M0AinCYYhjKU8vPuQC2U5O47h+4SxrYMP4kbrqal++3Ncna8mNV8Aj219P8rG9EfeH4rVKgWG5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781413284; c=relaxed/simple;
	bh=w2I1molMWkbcjeidl2UxxQD8MD1gWw2ZcgNNdF4jlKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4XnWQH3Ns7WJI/Gu0y4z3D6uZcP3pv0JVm+bLtZhnWaCDYJk2O9hkl8/JloEzf4GPyWP09X9weCXV6hF4VuyLw9L7Eur9tFOCpi613megDwyXs3kSjiYcaocbAdP2b5QNfndHSXLyTXGREizYWhI5eklmOSyfmuwSaZPMuavJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FrqQgQiK; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nN1UzZjMpeTtwiIZJQo3w2K+pmJB60I2J8WwIrtRSEZ/o/KvrRF8KVW3qWbTdfxn0xRn34EKxvjqYLUM1T6hoYEYkpd3PfztTMLaZ8j/uFwizvTDhaN2QzlwiM3UWgH/eHZrYnqDIASK0ssnl6Km+E62faOX2fNoTxyle4grceH39dwpwmMQoF9JIn5JCF5hnfXZe6Z08J7s42bRuzfJgIj2bZi9LJPXgmAa4LiyUv3cnrAi1KgLEUMxqdiBUmpT3s7MQ95/p8z32kqO9p6mhrOentd3QPR4DwCh+U8bW8bKlBMcdkDw7sNJSffGgtVHqUTSdm4TBWhWylMT4XHnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=XfAw//k3Qzv0r00ZRywRJBQHG74uu1WQt5GhvuV+0t7VUSSy4vgxNVXU75i5/mVa17eEKNWFB9vE7KbHy/zUG+DXcl0HlW9bmZ7rk++oz63WG7shRoHDXhtY+vmkRO3ytLP/z+y6aNKGMjnvGWtfdWcLKtIwDCV9WN4DaBuJhUssFAFVE2OdBGCOPP2MdUBzCLdJ2ck6qwJBwQthKzV82V6aakWfLXY7QQTw2czWOg+ZM/jibu9XTGPrjPsw+cuyCsWvjPZXUC5JgTfs41Per+yqPX7jNs238vYe7DM+xPSZA6mD7K8SOMosSbp04xwYsU9lia17Kzn5kM8AIdRO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=FrqQgQiKkohIQ3ULgEDRFZR/7z35fAU/rE3z/1VzDKW0cs1bWnHv45jBTmd+xYkUO/ZIKxiqb3ZRBV6CIlJNBUFytCB3yWYQMALSBMHc9l4VoNHa6BjPk3siJd50Uf7fgPGQkj2PYzF3LDtHW/d/5bO6CL8lRX62oDdLp6Xhsts=
Received: from CY5PR13CA0086.namprd13.prod.outlook.com (2603:10b6:930:a::44)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Sun, 14 Jun
 2026 05:01:18 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::15) by CY5PR13CA0086.outlook.office365.com
 (2603:10b6:930:a::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 05:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 05:01:17 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 00:01:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH v4 2/6] pds_core: add support for identity version 2
Date: Sun, 14 Jun 2026 05:00:48 +0000
Message-ID: <20260614050052.1048328-3-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 21815b2a-e5cc-4e1f-1dc1-08dec9d1f7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	K5271rbB+Wsrboo1tQ4vzxL5dvfozKlDokKYTfEDTch5pvbAF1+mLNTrGj6GMgEFQyufRYDtMD0JijwA+2Bo/qDvlpAHkS1SN8oNtv27sMM9DBC+VQu3F+WCLcIizLGIJe5scLTgwC4tWmMu6ecxu4Qf+NXW6CMSmikciLOIu97NabWRqB7dGCaB4KXHsix4jVz021oPG2sjXniy3+iYUyqLU4nF9qkkmVnlbdRR/1wDsaRmV+RsJPrwaJtCW0UCOjEI1HyUxOunsgYT54+3jENFJx6JtR64mG6q+5CDmZ1QUc9cgh8UlO3RX/ppIQ6NyofBau8oZTtAH6LOchdM+ICvlvHicVSaWy2GHAE+SKad3NTfE4DmB+hpX+MINfkkwrB4ZWWKB1Z3c2FqVqPzv+3QqCcOzgdMzW7NgOJOjsmUN9EY4yhmnFEj1CLStQijN3ordhPzGxzHexnQ4VsVypVOUMZjrwfgq/dtw9DHaCK0vkPo9glR5EVYy3DtLO3a9oYgKhsNnHAiBfKkQapDfzypIcf7NcRlqNCfrhEdSRwQbE7kZr2Nyhyh86p3hCbIkbUzlUCarfV8f26SVYW614DVBb7vya2r540X6NZItXoPehnkgz/kCk20htKhgQu+BpJckhjShYXBvOfJ0S+APvvBYwt4H5W3bk1RLNghQl5G8WDwENepaW8UaM29D3LepD3h2Xpxhx2QRQYbc7mUNzpPdkZo/y5uAtaPZfTPNFM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lo/ZvQ36SYMPw+R97kTt5K3Grmeyiu9kIgzabnuWytQ/PLX8rBu35F7kQ/UjMdakxmnFmJaJPXb4imynwQ9Ho/DNGTo5thZmR67Ky6zae7iixWB1Kg/S73M3H+IYGwSHPWtsQDieXnEBdAdmLarNhspcemxwAt3kTuyfGLYufHMe6FtMBqcGa8jasKx5KASwvvIPNJ5H0ev9qbaZ0ywo1sJUVJh/uxbwD3LRUL1IJwuBdd0brzxgz9h8YW+81yhZHtyu4DmGAyPrZ2OkHVsr5bJkGmsaRNRngIz6aeklAM+tg75NTgz7RhXkEISYgwZF3rtsYAT7v2wS9NzEQTaBeFZtgwKjHLL3a4+NnnFrPHC8n+EkMlB3cDDIQW0tXQMXrNKOhdJKHgMohAso7CrCt2Vlp1ju4wUnNvU+Zg7RXeNJ9RvvsOFkvfV1lhqODpve
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 05:01:17.7438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21815b2a-e5cc-4e1f-1dc1-08dec9d1f7f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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
	TAGGED_FROM(0.00)[bounces-299143-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B83A6805F8

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


