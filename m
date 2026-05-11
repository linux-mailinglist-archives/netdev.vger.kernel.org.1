Return-Path: <netdev+bounces-286524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD9DLiiVAWoefAEAu9opvQ
	(envelope-from <netdev+bounces-286524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C6F50A2FB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8C62300F5E6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5413BFE3B;
	Mon, 11 May 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YC2WnmHn"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FC3BED32;
	Mon, 11 May 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488540; cv=fail; b=eVS9sG5594AO30tw6wrnKdM4BU5EsNgZ3GTz+5N99IdtrX1PRMRcQBnCtnE7gKb9CNBzLqlzDls7cxF9EAQsHqsHUroOVgH+J8pKaFdJzwJ2ZNKf4swhzChf1WOlwVWILVHDuPr3T0O6PuIr2JWAxNd7BlvtwQoDydT5G8nIkIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488540; c=relaxed/simple;
	bh=WiJvnZIzF6vNc5FQ0etw0fe0LHiLbze73mz3Sginzz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwPGUSW0NJzIQrtYQ7DNTp3WwvWArPiakAEn3+iMEap0rxAaqQZg7yLSUyLQF2hA+j4TsV3sHCwFXmG5tbP+fGuVm0yOG4nxMSH9KHm30kgf0FFgc8saEFubQVYeHHTis3ywlHW7uGYojsCvqcigWquXfnEfg+PKXJKOGD25TN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YC2WnmHn; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ2u7BPxfYNsgJJ5iX+5vdgW0BHl2k0c7yk8gsW0fVziDc7ypSM6IZ8clqcviPM81K/Ju6UPz18wfR8boo6xnnoFsJTZTTd9fScyF9RzangXXe7jmHO3eSAgbt6llCISulUc+TKckvC7c6XyOHT9z1xS3ZSC3RASWF4zStQO+RM6d0noyQmSy/OLOiwsB7W11/QWNnhGULsXj1rYhfHVzgdB82cPEJfPdX3IEdF0yZxcM7RKA8D9DdqqFN6aU4YQxCP2Js85ruRpSPPYoq3t7CEP81T9J/JMz2dCKzrkCO4ik3nkLlhabnK5ErXMEguQyLpCqq8fSuW4G0P0QWRxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/GMabFPV46vWBKf1mmOIC4K7YhAqIflMjxcMqSloHI=;
 b=MBfhpFudfdfJ6ZyiUHzYSITo25VjwkiYYHrjuoywBdtnEAWDbj5naBAqs6W+oPBf7XfBvamDkxiqXSPqS+a1AD74HDvxLm+IHx9lWeDT6KtDoD364JvAc/CBqoIeYUCWMHoG5m7Y7XTtlzEJzSQEo4G+sxQ6jvm2K887x1TahH9jY4zw4rzh4PtKWX4tWxB7Y5A7Zz7Ws3MwzhxJNlDkpItGFeCcf7mhWfNT7kXDbYtkYQD2bp/uZWXl1UX8FSJl0akG2swjC2n3OFr1SkxzHPp3xSvrzyyKP6QHD9yyj/8/NEglljZQ88fpU6VbJKUCf/4o4ysjsLsj3OmmEmAhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/GMabFPV46vWBKf1mmOIC4K7YhAqIflMjxcMqSloHI=;
 b=YC2WnmHnnf8wvq5oxiP1xPZyMnI0+gdkgZ23rdcnxsarQsEZbDt2JzM8DJsK8IYqFqL/k15OQFyoJWr96WpXLZJpYrBcW+42DbdS1s03EbwNxzEmQsBpWkiqeo63E4yqGcCYJr5wFbV9jE0FZ1EbXwG35ZbFfjMbr5w1AIZpoM615gRZ2T1qNXCPkYTke0UE2UDbthgT+tAg9w7wdy+bCoo9JAzd0YqzorJ756LSvof7oYqF7YjNa8Yf/okw1/6jXSrX4ZlK84hOr0Lp7wB++RUd0OzKqVyFOCdQM0ySLd6Mj4LjRM7bJJ02KX2rI8NJgZJ3zRdljxznOlWl/ewc2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:35:09 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:09 +0000
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
Subject: [PATCH net-next 09/15] net: enetc: align v1 CBDR API with v4 for VF driver sharing
Date: Mon, 11 May 2026 16:07:59 +0800
Message-Id: <20260511080805.2052495-10-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc350e5-8479-480e-d954-08deaf383614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	doIflZL42IbH6HqYnK9fq/Ftx6bAJdDgI/CKIFlUq3Vt1AP3v9dZsanLcwMhdAU8ordLCPuFHiLP82jX3fC4d+rj01Pu9Rzk5Hd6Uur4LTyrVkfNEyaXd/gc+StH4CKTaVeFAui5ReRlUks2CiqrWEetw4XzWe4oFYBx4YVVJlSYb4OITOKaQOF5Kp0cLoNiEZRfDgMoZmY5WcLXtEMINHT+SVs1lH8nsJMJQz43AWnXwWhIV3TekA1C1VFSg3dErJI/LW+LyhxIxWPFWt1TsOFJoDWCDZ3aNL++F7U1aMUXVINUZHfH6Svcx/A7yqr/ViMwCDvjHxaHf//UlHm/J6H1bnsSrmvwFTuKN0oERuThcaCMb3nsGynPuDrReVpWMDgeYH+yQ1NrITdFhcqEVvnXzbGVCc5eybZfaRB5HlqSWI3fNs71Ey1gP62vSScjxYD4/FCRegmEufhTYPQTIzVx6iIGYMDxHgXCR8k9x/NQt0E9ViyxLOoavuMlILpTa/JBkvG2UAhwxYy0EtDFx/ol2DMpNpS8+tGPKXFiulkOG4cqmEWrq1spfSU2CuVagId/NTcbr0ouSZtWvb9LwsyRg/DNQRJPJIR2fdyoyVHV/jEum3WnZ2CGuGOb+o8tMvFlFMFoa5aRBaJVab86nHLlcFfeqbdofwHdWG3ldHyD/L95zMKOukCh09iTKfp40gMCSK1qkjhYUtUtO0ZfzL27PIwgS3J7RajeR5egoguqpea7gfujCUwiXXASTtz3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBhHym8cDLPjQw88WwwRuOPfSo5NOMI/5gNVeUTwaAJs2x6GbX29bEKIBSx5?=
 =?us-ascii?Q?STR/U4+yJhI3tSXunDD2ET1FEYlouGHMGecSYtUBXok7et8WTh9MiA5sLZ89?=
 =?us-ascii?Q?ivRBZU6jix+Zj2TXwRXXfAAhPDeWgZDfU0FmgB0BknnX54R4oRBkovp9dBsT?=
 =?us-ascii?Q?X8DQWxwXjMqvV6ad5MmgGz+un8iEZlwzmuMO22JcDfj+IHQX99dyccJfAZaR?=
 =?us-ascii?Q?gvXSIZcMuI/ADyjF8N3acntnseUWP58knavQl7OQPufsp60uEdxoMsXOQu9t?=
 =?us-ascii?Q?uidl+RrlFYIl2Zm8s8cl7IDC/IjsNvtnL8a+OwrE+yPld8RdcuEFM5ayoc5W?=
 =?us-ascii?Q?2stnoGq28FF0oTPJG9zZL+FcqGSYVtL8MomfFfMw3A/3kIb3nbHo9wHgeDox?=
 =?us-ascii?Q?0++zy6dMk+BxCBqa60LppSeYKsXu9NyJ1UoN3prXF2PPaiS7ywvpGmxN0PO8?=
 =?us-ascii?Q?pWBpsXT7C8K4I87BIujn5XlHZRfX+WsgRyTSE++h5KzObUJm9EyNOVbybpTN?=
 =?us-ascii?Q?BF/ZQZaGv2KcNGlficYFRVqdjgA/AKwJb9yQZx2ICrTfZe4VSFTP0MELwgFk?=
 =?us-ascii?Q?fE3nHlULW10wx5m/nQ4EeCWImSNCTB2dYj3bTG5m4cbgI61LEJoV3sPMbueB?=
 =?us-ascii?Q?/gdjN2FOsQnI0cvhugShCgv7bFBm47dixCJHzed1TDAs1YMLUNFa1ly5YAPD?=
 =?us-ascii?Q?Tiz+ao5MJR7PvVvy0kPCnjHzhMi7nyf2sbxMNZyhJCeE7sUqYo7yqqWVdBjd?=
 =?us-ascii?Q?RcOuNbsrU9FKpUhpRtmBDwP8Otekkvl4T/aBqbOD2H03c8LbA6jVtvRy3IpW?=
 =?us-ascii?Q?CZaLV3QO/ZC54WRzE9miEad3XaHGcDKZ3NsQbNHcojt05Ip0cJqXCUQ2S5Sb?=
 =?us-ascii?Q?rJqSAg/sbJj0felXzziSz4mItpEF885uekcrk1o/P4/VEA1m7NpGK7RlLIrN?=
 =?us-ascii?Q?uYqwVWcdnAGIeum+iNBClWPXxXpMa5m/tLmzpqVdqVPM93MpI4KZc12Mrc34?=
 =?us-ascii?Q?PhYmwWeBijbySwWLBhoS/wk72Q73hj1Pat1BzFZy4+4s4BgR17Bk5TtpZnpt?=
 =?us-ascii?Q?i6UAHIm4dWvgoS57w9rck/Z2eXxyrElww89x6G8p3VCLWxtHk1APOWIRgJLU?=
 =?us-ascii?Q?QswHsW+By9mZ8n3fjoHbQYnZrdsPVF3FhIQPq78psaWpX4FSUfThxw3NiGKE?=
 =?us-ascii?Q?2aeMw5ObdtgIO5Xz7onNfOhMCUacw0duNL7bZOb0ArW4KSWfGrENzEte+WAc?=
 =?us-ascii?Q?eYJZix/QZs6QJeB6sOEL9OfadOWsS3Auaxby4rCnIc+tckNdo6Q/Bfaw8kMC?=
 =?us-ascii?Q?z1N2DWLSz3XHf4npJYXshteS5FAhCiEy65swDfHBIJ1pk6ifu0eJfVLdzUHG?=
 =?us-ascii?Q?R0YkNZzLZvfyTWyv0GMuBNa12kb0Sg7WYhCNagiYZwQlXNEgPPIg8K73Lrva?=
 =?us-ascii?Q?YoRXgyPOlwZGnFzSVSTYB0WR0QgROSBTjCGASUPVgrS4cQdc3xwe+9lQr8ss?=
 =?us-ascii?Q?5uXOulcWxH/bNPMujX/172rfGZVYkIAzPRw0SNBzx2SodD9rQVgkFzhhmV9Y?=
 =?us-ascii?Q?DsK1/3pdv6hz7N+aDS3GdJQ/qbcYKZkiDNwE60/0/3gA2T2UvEy6ib0qsOLY?=
 =?us-ascii?Q?dJ5UEQNHYY3VayeMpw97jVygQrNFTN6NYfcKCg1np5YlhpGbqIWSNEq5C2OR?=
 =?us-ascii?Q?vaA31Fseq4I2l63LSVZPLwVhua8Zd3S9HX5zuFbS5mEYb3mQS65yQap47Njt?=
 =?us-ascii?Q?UhK1lpMa0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc350e5-8479-480e-d954-08deaf383614
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:09.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRkq9UbYu8oC5cFpxJUhp9ga9x1OkNzrXJGnc+aXKMs6BIk+6Mzq8xPX7QMpKKc6fYeZ5JmEfJ8Jv6NFC8Lmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: A3C6F50A2FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286524-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The upcoming ENETC v4 VF will share the enetc-vf driver with the v1 VF.
However, ENETC v4 introduces different CBDR (command BD ring) setup and
teardown semantics that are incompatible with v1.

To support both versions in the same driver, add setup_cbdr() and
teardown_cbdr() hooks to struct enetc_si_ops, allowing the driver to
register version-specific implementations. This patch refactors the v1
CBDR functions to match the v4-style interface (taking struct enetc_si*
instead of individual parameters), enabling them to be registered via
si_ops.

Changes:
- Update enetc_setup_cbdr() and enetc_teardown_cbdr() prototypes to
  take 'struct enetc_si *' as the sole parameter
- Extract parameters (dev, hw, bd_count) from the enetc_si structure
  within the function implementations
- Update all call sites in enetc_pf.c and enetc_vf.c

No functional changes. This prepares for adding v4-specific CBDR handling
in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h     |  5 ++---
 .../net/ethernet/freescale/enetc/enetc_cbdr.c    | 16 ++++++++++------
 drivers/net/ethernet/freescale/enetc/enetc_pf.c  |  7 +++----
 drivers/net/ethernet/freescale/enetc/enetc_vf.c  |  7 +++----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index b70b625328ea..772f0ab2f8c1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -537,9 +537,8 @@ void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link);
 void enetc_mm_commit_preemptible_tcs(struct enetc_ndev_priv *priv);
 
 /* control buffer descriptor ring (CBDR) */
-int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
-		     struct enetc_cbdr *cbdr);
-void enetc_teardown_cbdr(struct enetc_cbdr *cbdr);
+int enetc_setup_cbdr(struct enetc_si *si);
+void enetc_teardown_cbdr(struct enetc_si *si);
 int enetc4_setup_cbdr(struct enetc_si *si);
 void enetc4_teardown_cbdr(struct enetc_si *si);
 int enetc_set_mac_flt_entry(struct enetc_si *si, int index,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
index a635bfdc30af..e4a393a8a58e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
@@ -3,10 +3,12 @@
 
 #include "enetc.h"
 
-int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
-		     struct enetc_cbdr *cbdr)
+int enetc_setup_cbdr(struct enetc_si *si)
 {
-	int size = bd_count * sizeof(struct enetc_cbd);
+	int size = ENETC_CBDR_DEFAULT_SIZE * sizeof(struct enetc_cbd);
+	struct enetc_cbdr *cbdr = &si->cbd_ring;
+	struct device *dev = &si->pdev->dev;
+	struct enetc_hw *hw = &si->hw;
 
 	cbdr->bd_base = dma_alloc_coherent(dev, size, &cbdr->bd_dma_base,
 					   GFP_KERNEL);
@@ -23,7 +25,7 @@ int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
 	cbdr->next_to_clean = 0;
 	cbdr->next_to_use = 0;
 	cbdr->dma_dev = dev;
-	cbdr->bd_count = bd_count;
+	cbdr->bd_count = ENETC_CBDR_DEFAULT_SIZE;
 
 	cbdr->pir = hw->reg + ENETC_SICBDRPIR;
 	cbdr->cir = hw->reg + ENETC_SICBDRCIR;
@@ -46,13 +48,15 @@ int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
 }
 EXPORT_SYMBOL_GPL(enetc_setup_cbdr);
 
-void enetc_teardown_cbdr(struct enetc_cbdr *cbdr)
+void enetc_teardown_cbdr(struct enetc_si *si)
 {
-	int size = cbdr->bd_count * sizeof(struct enetc_cbd);
+	struct enetc_cbdr *cbdr = &si->cbd_ring;
+	int size;
 
 	/* disable ring */
 	enetc_wr_reg(cbdr->mr, 0);
 
+	size = cbdr->bd_count * sizeof(struct enetc_cbd);
 	dma_free_coherent(cbdr->dma_dev, size, cbdr->bd_base,
 			  cbdr->bd_dma_base);
 	cbdr->bd_base = NULL;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index fea5cb6a1662..b126a624e6dd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -798,8 +798,7 @@ static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 		goto out_pci_remove;
 	}
 
-	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
-			       &si->cbd_ring);
+	err = enetc_setup_cbdr(si);
 	if (err)
 		goto out_pci_remove;
 
@@ -818,7 +817,7 @@ static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 	return si;
 
 out_teardown_cbdr:
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 out_pci_remove:
 	enetc_pci_remove(pdev);
 out:
@@ -829,7 +828,7 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 {
 	struct enetc_si *si = pci_get_drvdata(pdev);
 
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 	enetc_pci_remove(pdev);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index d17ab5b2306d..eb6f8065e1ea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -320,8 +320,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_init_si_rings_params(priv);
 
-	err = enetc_setup_cbdr(priv->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
-			       &si->cbd_ring);
+	err = enetc_setup_cbdr(si);
 	if (err)
 		goto err_setup_cbdr;
 
@@ -357,7 +356,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 err_alloc_msix:
 	enetc_free_si_resources(priv);
 err_alloc_si_res:
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 err_setup_cbdr:
 	si->ndev = NULL;
 	free_netdev(ndev);
@@ -379,7 +378,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 
 	free_netdev(si->ndev);
 
-- 
2.34.1


