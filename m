Return-Path: <netdev+bounces-282285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GM1M7q+8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308C49116B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F0E3004F4D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26A3A7F52;
	Wed, 29 Apr 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/EzF1DZ"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C1E3A7F66;
	Wed, 29 Apr 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450633; cv=fail; b=n3HfBCNFPIu0n/3trYhkS0yj08tlf/M1ZUTHY/rs72Xu+cykh/KKR2rp93nscZ4vO9n+5TtdFSDa0vbrpxMXTUE0y4HP3YFkB/NXEThu0eSA9jBxdZntg419Oo9ZybRobE0THgn5f5E4U2dL4xSWajwUoLGvpoasxatJQpBCiNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450633; c=relaxed/simple;
	bh=ySBjn0bcSNyKmMs7t14L0101ITHjuTp5JOfxwINnXrg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CQgkRvPUMLVnaS2J1pf3WKAz/+3ZIVHYO8WqTv8juYGsa/kgYa0v8gwz1ykysSKquzkmb/qijaBMKrKVDmo4vpYjiLX1aFmtnziARsamo6L0ewyfG0QoBlfJmzGBAifNVHM6pw1yJ2ACzeed/ivos1tMiFmOBXj2R6lpFla9bAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/EzF1DZ; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqXum/mlseSoB1Vpw8nEo32Dc879BiAf5oU/4aojc6zRSgJ39GZvv6n+EU/dFjC9M8fAY+CLgJy/FWMETwFJZvKueHIyvYWsEQ+uYpkkODKA6WSxL3h3S27Zz9LxFcOzeoWpv5NtXFuwmHXVMn5yrim8j+qtZvtjaqZUWtPHeKu1tqV180MJLb3w3OiD75Cr9cDJU4OOaqJ9ljd9P11lN/LsWC7rBDlK5XOSDN8COsGM02aMUYcSRVHWI8P2VrktIUS9JW0SjmnAks23fAUaFJOepJntO+tBigD31HrAfZzANAoW/MoX9oB6V+TH92HKHfnflYdfWDIsB6ZA2v2nQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klZKtubyBp9AGbUORaSehvvKecEvcoVvJIXHNmRQaGU=;
 b=x3E9pu6mZCaCO8+FxoIbN7aY4tQ2IH6uOxhyV/JbM9POKjqUQfG5uJUl02yiKZss5VBOvpJG3xiGHVuxuNfi7cJNKER/2EgNxuCX9jxrSB74C5oARtSiHHGhG029yJESVU2z8TLmHzKJrAHFRyraKLnHD7xkOGnZUjnciie5vGS9Kia4dLq3N1riM+PAbKmcRiBM6mB2gfBNN5bN8fTQcJHEvkYAXPxfdD8qe2dsVwxR9uLdYf9ZUvPg4j9CZwe1t4FFQt/2KdV13DdRaCm1gjZo31u3QH0in8oU4L8R/5uQlvRYAATAmrmVyomPZGaiD195No63Mi5e2ivDYW6+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klZKtubyBp9AGbUORaSehvvKecEvcoVvJIXHNmRQaGU=;
 b=D/EzF1DZ89opBj74Sx2BdBk/00OmmSi+FI5A5CdTakV7jbFZMO4in68OT/W/jqYxMAsiZUAD+VJzeFvJ8TQ0PAD3CXuDDqMfots0NO7F4BC2xmikOlV0ZnWiI91ls9rc2PAOCXyVjSv9ZZIZzNz/cXzDx8k+gXJS+61YeH4HOSZSTgFwc73VESvqX7qqYeQck+fLR9etSiSjrXmFjvTXNgNQFD9Zq9OgZElRvkWtLfzOrqnmLYpOTHU5j37++oGp5G2WIQSlP0vkze3dz8qB9LwPohoCIV8amQbw6EJhSq5bF4NcBOL7ia8WImn5CYTqj0FGJizgeA2XygkqUpVcJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GVXPR04MB10874.eurprd04.prod.outlook.com (2603:10a6:150:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 08:17:07 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 08:17:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net] net: enetc: fix VSI mailbox timeout handling and DMA lifecycle
Date: Wed, 29 Apr 2026 16:19:30 +0800
Message-Id: <20260429081930.3259824-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::12) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GVXPR04MB10874:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b54708-1a15-49e7-761e-08dea5c7b41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ka1Fa5ciVFAnjVa0pxuF8GmM8CQGUuDu2pwxXYR+lGrGmV95dmOF7iicwOKV0ZxovFYBwDFtcxL5wjQlqD9sWgKT+kRq3Tzr8kcCAvNhS4Fk+aIg+nty443kRLxLBtzidD0qFWaF5hGMbkpVHcMSfAHvfYAOYqByOSEdCYnM+stC85qPGMosUZVUFTCDRHt3bI3zzMYHBJfgI8y4GIMLB8vqtyjAu18FiI8njmg+5zq68mS5Zkh92rogJhCQ+x2h6QmuIE5cbV2NAS3ruJFIlb2+5ThUYDZEkR5aHAB+1EQTT0KcS/06ue8soX9DXkBbpo+ZszbiZkJS/PB66gONhFBUDj1RNfuEbomT1WHO3BFyeKoo+kwTV9Itewu7LVOHRU3Nn8EjQ2Zhe0cxJeO6ew3OooF6XR5We/HpF+4hvisU29ivNf8Z3uenNj7Hudpq4Ua2Eb2PLITbjcpZWjX/B9qEL7RwCY/jPu8xNb7JlvPK3waXC4lj8SFDnnVz9MSo6Wh1SgOVeHRiLhn3R7XEjNhtIONEc3T3XFpoQfNQh6Xlo1NFELQAx6c0j1IDBFAT0gvUz2j+dkLGNBxEd/j6towG2Io63TkQ43THRYy6nri80Lkr8KxcaSOyzNLJ1ehknrpDT4HlA2UAvFh7Lv7XqAQbEB71/cgc3ujjq/TmjcSrsW8PMAS4vDI8YfGxzxu5k9YenhIdzvtFHNePcEUqaShvEB0INVgYVI8abh4PXfjN8KMXMcLY2KuxVxAUQAIDEXJzOK8E53A59TnMT0OsGTEJTRPNf23Ca87az54zOPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skgbAUtU/pe/Aey37Kxqq7JkAjTLkhBfzsGujQxOdWIlcXEtr4BuL3JIO0il?=
 =?us-ascii?Q?mijjl1iw8S0LW9iP9ewolGoDj9DgkmUqhzdVkbcAaUWuN9RoJWJK9dTUUSXc?=
 =?us-ascii?Q?JG4qP1OP3YxhfPf4aHwT6opVhr+M85w7ToeJyUgiD+E6zp/QUCGp7X080e1+?=
 =?us-ascii?Q?EE//lcv/yKalWep7+jKFBfy5VrFf94GGEZIUWBOOU4lgG3PkTVPNmcc5gRWq?=
 =?us-ascii?Q?/2Dw2JZ+EfjF7MhSpXl2wryFVi8+CIvnVfhM+M00cTvaaT0vi9IE6vTaYozc?=
 =?us-ascii?Q?VXp9W8hIea5yC110ihN+Kux+TvKaAZmAIs1/TUuYOomOZV9MURj6dS3c3o2s?=
 =?us-ascii?Q?qB2kPDCBy+iCvFmGosBVUiUMAIE/xccj6P3cAe+p5New2pP5jiFsRVPEuvPK?=
 =?us-ascii?Q?DJqCq3Y/iVY0danlY1mhpq6fOQg+I8nOBSove2eH+9uVCGf0Muh6tqFrqxDG?=
 =?us-ascii?Q?s82n0Js3Uyac3CRGj4D2YgcHGXRg+TgNuI/qrhsbQ/yM0s+NULc7kGMQh46S?=
 =?us-ascii?Q?LLHDDrkE75LKiySWbksUzz3ysoU4mNfGTluFWxP7VGLIvFcY6MDxaHolezK8?=
 =?us-ascii?Q?mfcgeGx8brjlyzfKNUAGKfEuOBvhXJH/zAK6tdVlHV2m9G/RsikZ/iZQUJAI?=
 =?us-ascii?Q?9LQ9Q4HwMzTVGj2GSATzistp9WAuJs+t1017dcxiDXoTQv63bjAvVDY9OhIF?=
 =?us-ascii?Q?lomT6ApDrTHG6mmCb7oK61xpxJLYe/XvIZZ880ewRto9yPzE0MNiT6q28GHd?=
 =?us-ascii?Q?JJSxF9zMfKsPe+EFnrMv+PkKUFA+vq32AoPJDFd4xcpc48loWI0PtxlyMOLV?=
 =?us-ascii?Q?u4719PnKClHU1d90W0PAbM95R1UyDrKcM7g4V9j+JVQxlena/ySkSC9qsUAa?=
 =?us-ascii?Q?dyMi9oUuRbjNVpJ6WjZQ0c+sQjHmzjD89n46nqMxtrk/XAkYoHU2MvG2fp4/?=
 =?us-ascii?Q?75QhKxilTT2wdn4l5XDBCyYtWu4iMmdtc9j0M1eywLbv1Z3o8VQTjNl77haA?=
 =?us-ascii?Q?9Hfa4hRfOJs1ARhzlk2a6L/uo9CUp/NG+J83+o9YBY7ExSEg1/TQll2hKMoZ?=
 =?us-ascii?Q?TfKsBAskIlweYuNM63KEUQttK+Oqb/thojK7m+HPCEoTIyLFyMo+CjqeOW3H?=
 =?us-ascii?Q?TWpouBAP4yo5wHblbiURBwGY4DWZhNyPkf1V6u5VOUfPMwIXNpbidOB5exnI?=
 =?us-ascii?Q?NGcsxMuw5JnZECEGAzNnH0z1gUyQe81zcnjF5ms1yxZitLjMXBtdSgD/zAiF?=
 =?us-ascii?Q?iv7sl8JLvqokb64V1SrRVKuhYxkRI/+y2ZOti2f/9bimTgiYqf++lRASzIAA?=
 =?us-ascii?Q?O+cLHSSd1O5NehbXdiZRrFSGSA4lLeysqklhSUCfCY2vxwlu0cQIWyXg1fF6?=
 =?us-ascii?Q?5EX/QnXHEysvwmWNDHbdsforBdyg+PYCGu4mN7KpbpZOz4G4GPP/zIN0gIcq?=
 =?us-ascii?Q?rqPMPV0YpUfj5XHz/iWeXvvxfJ73VYF0f3yZuxqh3UTu0Toc6iy5DzK8cczv?=
 =?us-ascii?Q?PpmZigHCT//yMEL00rSZx2SWg2VRu8ajQzGQ/47RWYpyPgjUfM7BExqssRcH?=
 =?us-ascii?Q?0n2tRkAMNaE9kVR+5Kbe6VWz2A/n43286QUQi6b5KanuuyMqoXMPGLxr+8Ok?=
 =?us-ascii?Q?at0BKB3Bo5fJsBkw7B787Mm1yz9s3hDBeYq+RgQLf1C1Trs4onNZC3tvRmim?=
 =?us-ascii?Q?Ifii4lELWhhntefjnz/0SWLlUFvfdnrN4rLuO+7SaLqYTCFm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b54708-1a15-49e7-761e-08dea5c7b41a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:17:07.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaH7AS/R7VsfF9j8Xg40I8C5cTWgsvYFQEaqDH+Vy+X+y5PnVW2w1tr1SgNuo31OhqkmdAHTCZ1s1wIARh20sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10874
X-Rspamd-Queue-Id: 4308C49116B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-282285-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

In the current VSI mailbox implementation, the VSI allocates a DMA buffer
to store the message sent to the PSI. When the PSI receives the message
request from the VSI, the hardware copies the message data from this DMA
buffer to PSI's DMA buffer for processing.

When enetc_msg_vsi_send() times out, two scenarios can occur:

1) Use-after-free: If the hardware hasn't completed message copying when
   the VSI frees the buffer, the hardware may subsequently copy the data
   from freed memory to PSI's DMA buffer.

2) Message race: If PSI hasn't processed the previous message when the
   next message is sent, the VSI may receive the previous message's
   reply, leading to incorrect handling.

To address these issues, implement the following changes:

- Check the mailbox busy status before sending a new message. If the
  mailbox is in busy state, it indicates the previous message is still
  being processed, so return an error immediately.

- Add the 'msg' field to struct enetc_si to preserve the DMA buffer
  information. The caller of enetc_msg_vsi_send() no longer frees the
  DMA buffer. Instead, defer freeing until it is safe to do so (when
  mailbox is not busy on next send).

- Add cleanup in enetc_vf_remove() to free the last message buffer.

This ensures the DMA buffer remains valid during message copying and
prevents message reply mismatches.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v3:
1. Save si->msg after unregister_netdev() to avoid a race between the
local copy and a concurrent ndo callback.
v2:
1. Update commit message
2. Return -EIO instead of -EBUSY when VSIMSGSR_MB bit check fails
3. Move enetc_msg_dma_free() after enetc_pci_remove()
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 42 +++++++++++++++----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index e663bb5e614e..e691144e8756 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -330,6 +330,7 @@ struct enetc_si {
 	struct workqueue_struct *workqueue;
 	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
+	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 6c4b374bcb0e..df8e95cc47d0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -17,11 +17,36 @@ static void enetc_msg_vsi_write_msg(struct enetc_hw *hw,
 	enetc_wr(hw, ENETC_VSIMSGSNDAR0, val);
 }
 
+static void enetc_msg_dma_free(struct device *dev, struct enetc_msg_swbd *msg)
+{
+	if (msg->vaddr) {
+		dma_free_coherent(dev, msg->size, msg->vaddr, msg->dma);
+		msg->vaddr = NULL;
+	}
+}
+
 static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
+	struct device *dev = &si->pdev->dev;
 	int timeout = 100;
 	u32 vsimsgsr;
 
+	/* The VSI mailbox may be busy if last message was not yet processed
+	 * by PSI. So need to check the mailbox status before sending.
+	 */
+	vsimsgsr = enetc_rd(&si->hw, ENETC_VSIMSGSR);
+	if (vsimsgsr & ENETC_VSIMSGSR_MB) {
+		/* It is safe to free the DMA buffer here, the caller does
+		 * not access the DMA buffer if enetc_msg_vsi_send() fails.
+		 */
+		enetc_msg_dma_free(dev, msg);
+		dev_err(dev, "VSI mailbox is busy\n");
+		return -EIO;
+	}
+
+	/* Free the DMA buffer of the last message */
+	enetc_msg_dma_free(dev, &si->msg);
+	si->msg = *msg;
 	enetc_msg_vsi_write_msg(&si->hw, msg);
 
 	do {
@@ -32,12 +57,15 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		usleep_range(1000, 2000);
 	} while (--timeout);
 
-	if (!timeout)
+	if (!timeout) {
+		dev_err(dev, "VSI mailbox timeout\n");
+
 		return -ETIMEDOUT;
+	}
 
 	/* check for message delivery error */
 	if (vsimsgsr & ENETC_VSIMSGSR_MS) {
-		dev_err(&si->pdev->dev, "VSI command execute error: %d\n",
+		dev_err(dev, "VSI command execute error: %d\n",
 			ENETC_SIMSGSR_GET_MC(vsimsgsr));
 		return -EIO;
 	}
@@ -50,7 +78,6 @@ static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 {
 	struct enetc_msg_cmd_set_primary_mac *cmd;
 	struct enetc_msg_swbd msg;
-	int err;
 
 	msg.size = ALIGN(sizeof(struct enetc_msg_cmd_set_primary_mac), 64);
 	msg.vaddr = dma_alloc_coherent(priv->dev, msg.size, &msg.dma,
@@ -67,11 +94,7 @@ static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 	memcpy(&cmd->mac, saddr, sizeof(struct sockaddr));
 
 	/* send the command and wait */
-	err = enetc_msg_vsi_send(priv->si, &msg);
-
-	dma_free_coherent(priv->dev, msg.size, msg.vaddr, msg.dma);
-
-	return err;
+	return enetc_msg_vsi_send(priv->si, &msg);
 }
 
 static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
@@ -259,6 +282,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 {
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_ndev_priv *priv;
+	struct enetc_msg_swbd msg;
 
 	priv = netdev_priv(si->ndev);
 	unregister_netdev(si->ndev);
@@ -270,7 +294,9 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 
 	free_netdev(si->ndev);
 
+	msg = si->msg;
 	enetc_pci_remove(pdev);
+	enetc_msg_dma_free(&pdev->dev, &msg);
 }
 
 static const struct pci_device_id enetc_vf_id_table[] = {
-- 
2.34.1


