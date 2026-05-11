Return-Path: <netdev+bounces-286527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMRGAWOVAWoefAEAu9opvQ
	(envelope-from <netdev+bounces-286527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:37:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4E50A332
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA6EC301178B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6273B8920;
	Mon, 11 May 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1zg+P7S"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB73BE147;
	Mon, 11 May 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488548; cv=fail; b=CIHVCVRLGR5g2TUzI6UzutOzwY4pYyXrvb2QBcOm37ueqnKlUVU4895Tc+wOTtAp8LUxHcA6aKnt3w6hMacIdYrptFrHHU17g0cDT5soI1nBDy6Xms4fFq4PQnaw4gK7mR1cTxTuohVuvqNe6pudyeERe3Fw373zkUVEN4tr4Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488548; c=relaxed/simple;
	bh=ESqqooA1FffEJOOPbLxlIkePuLTGG08H2KzPEj7EBbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuFZKj3l24DySDOvKQaAOyBAaXIizxWv0RzdMs2TWh+aXnT6u+ZHqSCdJQIbodSH9AVy76M4HzwAot9DWFo/JwORFR/HKv1UR1dQIHvatHUFwN+yoSTsN3sAHk+X/4DmP6hNxo+26E2E8T5yN5cV7SI6iCH91ms0tvy3trcYj5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1zg+P7S; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so0kWRPBmjHfWeZLkNFYTANt+po/KTdusoTbQUs53rh/YEnToyf0ndKG1pu+oTAMOq4mLH5kLOgRh9r6Jf7vZ7ibTtlprI+d+p/T0QeZB34sowp/w4RpLlvErsJy8UhPYZTSohKW7bf0Sb/mp+nWTYRvHZLq+R8FjPTCSyNZjbo07/2F+E54oNHDQQTVk+8fuOYYeu+NCSLRRHbuG9/WEPs80KdW9NeeFjHD5cJU8UwzzOLh55EAbqPYyN0fNZU3YWACot5fbd9XdSkRFBexpRk08IIdYRzXEymqk9e1KGbOTtXk6ei0YDN4FuCs0hnRWOXDy4gu8VOvrvT7ZG0P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xbScWCO8L/JN68HVfU8YguE3U2jSN2n1pAtYriWRsY=;
 b=a/oToivPvM/wdVRQKbNYroivxlyP0w+hxKRjJcV1LUlS6nB9kh8IYt/Nnv1jmywNctlGr01XrXNZajvVOhMTOLSaMdIdDsoflOpfPnkBvhHQfLx3kq7Io4v1BIgo8xu23LnUtKoqByOXhaBVnt+BxxR7oVooFQQX7GnJgRWgEDh5oq6tC320TeL0BlFUa+niNGSoyqlP4PWGn6VHkghmKqZkgUN0d457+CeyQS/NiI6MqgIBSDzsXxARhJ7l1GwzDZustS/cft57WpApJycqr3l4hi8ysXYN03ad9H0V/vI3ENrznNZlYYpDAZgfP3yofZWgVXLnw2uD0c1K+yD36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xbScWCO8L/JN68HVfU8YguE3U2jSN2n1pAtYriWRsY=;
 b=J1zg+P7SO6L7xsSWTSPI4ehTOwotjxU9gTwrH040jw/ryB6XRlMb3yrXjU1tmrNbTMwHyniL85UyqNoTYWYe6fT8MFJjm7mfv44KvgU4M7uhmbpWV7AyjQ2tW6p+2TiiLGZT6kxfJJzWIukpz4bMr8/vt0rWR2O1YdzpJdiWKkqEiAXPBbowqf8YID3xFccIJzZ/Kiv+SXGWK/mkjUdxKNTGhZRlJffBU5jj0ZvbL11Z7sDJPyNAJ0aMaYhGVK/b4dbXiouaZGw6GjuhuYpHGGNDoPDJ/VWF9AhgjfAWS4V69MjAsTwtvi0tgfFn+8cjmDazp4Er/CLaClmySB6mWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:35:23 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 13/15] net: enetc: dynamically allocate rxmsg based on VF count
Date: Mon, 11 May 2026 16:08:03 +0800
Message-Id: <20260511080805.2052495-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|AM9PR04MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5f33ce-f0d4-400d-a41f-08deaf383e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	07W12L7WchsXlUz0bLyqA4EXHeiC3pPPW8KCWAJynHCst3dVg9M8DwU6pM9pQyOuCgHUuEdmdaxMT/LkDsA3j0/I5KQ+XubBBk2FDGmquw3GUozUpRyGs/Fpllz0z79+QmLKR81ubNbLywiU7JN72IGV8kKAyFIkJthEmfLD9kJzNYi8sfHT1Dgyzknhe8ZsfeQ1s0aCEyDr6qyzJKJ98Hh+DxtlJB9Z33V+/XDf9hw8OL5IlCLzAmKcZ06EOOFeOfY+N0gflIH/CWzs1RjT/5UFCjfYnHf+v/u2iVpUDW2hM/ZBqEMw23V/7avP4YPEvIwdXfxdC2vEB6X+v9b6CQy+DyhFVgKyLaXapFOICNkCrb63clUpmoZFJ9HcNplt4GS01LssYeCh7HdtYl9FgqWQSn/F8F00BdV/0xt3ezoweEJbvi/oOmYBYr+BlEh255SZ3jOp7meB2OwOuH3qH+2nSHkeYSJ97W8bMVDP2NNb7qYtLK5oPcIDLmfKeziheYbTco/UJ/1EYLST910OkvfC5lyG8KnxH8Jzd5N8bFErp6wskahLZJJLku/9kgGX8S5POtJrmQ1YTLFqZQFmzoH26B3zhe8Vlbjb+sO4f6ZXIM8UZdqeLokpENdzzzsRiGTQLPI8w3zT7DcUgkrucWbW2oAgdEmpLFNS7fo65C0aVuRBUMT55EUVb9wz9dcUTeOj8eHtkhlaRZ4vwVMLx5/nm9i9MKwP2cpC5a2HFuTJPrDp5Wxp2kix4JcvEEXe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XaSkjeoz9r908z/TvI2olXUmqJ3E5Oa8LDW8OzcYkGPurg30K83jIH0LkIL?=
 =?us-ascii?Q?Twgi7PXHHWI0ukH/vz3jVjxwEaXj/wpfXxnKJ3VCIBW1Yy3ArrnV10ExPeNe?=
 =?us-ascii?Q?Je+P3LOi43oAOSdTmxrKVSS+h+y3BnG/XbdtvTOJlVKuX0HC0Em601NY7CD3?=
 =?us-ascii?Q?+WFHbLjCy+Flj0AT5gjMVzgOWCyyIaDMsIPpCUX2vG4SejeAh0XzcYq/Ko1O?=
 =?us-ascii?Q?WS81TJwRvOciQUXU95bfNlqYSQ+THiNDzoRww4IKyzeFYTzzBK4TfASIC+lk?=
 =?us-ascii?Q?KviZMw2ndC3kLY/+PK6aHhxXJaMw4gywwCl5MBV715NTTiriDqxTlV4+6zzx?=
 =?us-ascii?Q?J2co9ddw2dLEPKwoKbau+Px3a2lm3hT9jjbQgkcLKb9y8CNpHTZnaqM9F4LS?=
 =?us-ascii?Q?iT+PVWHhJ7qhW7GgLrMPmTYxnL8i8MnmOkNNalP2V96wmtKZhHWtUm6HhJL1?=
 =?us-ascii?Q?hephAkEF8heYQHZRBrINfQlZas1N+DmT1pN6gdCOJKH+Z5xcpSmX9w9ig5Y/?=
 =?us-ascii?Q?yxlHViscXgmaMOl8rOY8OfSyuwnZRel92kJUpYPcvldjZMCrbRFtn99LaB5O?=
 =?us-ascii?Q?+bE0XeSkEFWA8MCzKHZXbG8ioPP1qdWwEIKj0R1n/YqDJMYhQWah9U6SqZIi?=
 =?us-ascii?Q?Lg1KMfKfEctiKIRw7qSsZy3keYC/Q/AYmKYUrI5rjl7bG2k92PUZPemwcBeh?=
 =?us-ascii?Q?g3zEeFXcSIVIP5542bdy/X4BYv6nEpq/nK8UsJAH4KVFTfrpEoHN99grFhPw?=
 =?us-ascii?Q?v3Y4pkECe8uWfZ+g7yaGyh1dewJ7qp9vqEWESUAGFSl/kmfT0zx5nuf2iXvK?=
 =?us-ascii?Q?TsVkuKxt7Cwwbu5uv4zy77pxIXQbvqVNZ22x/jjxvIsIW1tQXL/7onmkEsv/?=
 =?us-ascii?Q?s3rwbEDWI6ZPP0jpF1wAdT/cdDtvIEKX2nYb7RDJ8/0D5uu0J+ZCBKsi8AiV?=
 =?us-ascii?Q?DKJpZBvdZB6DJjC+LI8a0spsGCoHxpKG+5oWRGkf+btuaHBUJTJKm9cr+Yjm?=
 =?us-ascii?Q?k86dHtrNtiwahb5QzWA91sZN6Ck0YdPD7OEIGjTkbva1XqLoU2rwhgExtf9F?=
 =?us-ascii?Q?5DUdHww5c9jKWRAjgGrb5FxD14qf2IOnFNujuRPOcZ5fRL1cJf+wc+fm6jdf?=
 =?us-ascii?Q?G94RPIQtAc2g8SL8r8b6JiEArS/Ypxi04b2mj6PKqy6MNR6fvV2KomlqvLlm?=
 =?us-ascii?Q?ymb0GJdJdSSJOuEo9IWtkADkTSVSRvcgtczO2uAK7Q5U22IVqDquusmy4m0w?=
 =?us-ascii?Q?kftuAzZG4F0QUt3PWnJG7U0Fzo89rfIjhwxomemtko48QBIhVAYRnA5z+Kdu?=
 =?us-ascii?Q?xSqxpdO1yRx2cNL0/ZGdfhjLRCGotbTILb+8HXG7Oz3nOIMTMyTq0oy56EIE?=
 =?us-ascii?Q?p7BooIueqmubDRDiK7vsoSvcqFlulwOaLrH6Ye/0QQ1qPE3sUy2wnOtZre/b?=
 =?us-ascii?Q?wJgieBg5B2roIBtmfHeGhR0atG0JU24yBFnBce3/gDJO58QTxh9jkeWA4GRg?=
 =?us-ascii?Q?US7kS+VtgaLgz0z4AWoBmLBzUddMr9qXsqqcwZlm6e1R6IbNCoMU1fRoQKXz?=
 =?us-ascii?Q?tq5HsNDt/ouQOitjwP+lGXaTGw+GWYuPnqp5gluFIo+sfhx39VFT1afGEyHQ?=
 =?us-ascii?Q?hLl6fcQMQSqrx7Qh89NTASczWbB3PiQPKCJTuDGit2dQCCbCP+eseSzjKh6m?=
 =?us-ascii?Q?1GNdsLYXPLVOig5f6+Wwctvys6VdNViJTFDPHyIxuxau9R2OnGySFLmEwdqF?=
 =?us-ascii?Q?iPJvfqAm1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5f33ce-f0d4-400d-a41f-08deaf383e26
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:23.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6zCLyKsQNVldLnKYBeHVaDK6r9vahNsPrBJK+86EMqJj35O/+KpvlC1uGJpwT3ctMOHeXGiWvIke4doCiuIVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Rspamd-Queue-Id: B8C4E50A332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286527-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The constant ENETC_MAX_NUM_VFS is defined as 2 when enabling support for
LS1028A. This works for LS1028A because its ENETC hardware supports up
to 2 VFs. However, ENETC v4 has varying VF capabilities depending on the
SoC:

i.MX94 standalone ENETC: 0 VFs
i.MX94 internal ENETC:   3 VFs
i.MX952:                 1 VF

Using a fixed ENETC_MAX_NUM_VFS for memory allocation leads to
over-allocation on SoCs with fewer or no VF support. To better match
hardware capabilities and avoid unnecessary memory usage, change rxmsg
memory allocation from a fixed-size array to dynamic allocation based
on the actual VF count retrieved via pci_sriov_get_totalvfs().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_hw.h        | 1 -
 drivers/net/ethernet/freescale/enetc/enetc_pf.h        | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 662e4fbafb74..94f53762cea8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -672,7 +672,6 @@ union enetc_rx_bd {
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
 #define EMETC_MAC_ADDR_FILT_RES	3 /* # of reserved entries at the beginning */
-#define ENETC_MAX_NUM_VFS	2
 
 #define ENETC_CBD_FLAGS_SF	BIT(7) /* short format */
 #define ENETC_CBD_STATUS_MASK	0xf
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 9fcf1c58d59b..d4f1041587f7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -42,7 +42,7 @@ struct enetc_pf {
 
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 
-	struct enetc_msg_swbd rxmsg[ENETC_MAX_NUM_VFS];
+	struct enetc_msg_swbd *rxmsg;
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 60a330ee03b7..43225aaab54e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -449,6 +449,12 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 	if (!pf->vf_state)
 		return -ENOMEM;
 
+	pf->rxmsg = devm_kcalloc(dev, pf->total_vfs,
+				 sizeof(struct enetc_msg_swbd),
+				 GFP_KERNEL);
+	if (!pf->rxmsg)
+		return -ENOMEM;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
-- 
2.34.1


