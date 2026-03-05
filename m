Return-Path: <netdev+bounces-264164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNilOIj0qGmfzgAAu9opvQ
	(envelope-from <netdev+bounces-264164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:12:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1020A738
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C7B307AA4D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60533279346;
	Thu,  5 Mar 2026 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rh9jLmx6"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C09275AE4;
	Thu,  5 Mar 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680240; cv=fail; b=JZQzZnBKXWe6b7JuTSUY7NV/EB/BL4VPJoCDCVXv6QvXRhuhCR7NaWrYU4zvC1OfkklVCkSo/w37EUkymlFMwLOaaWiClZHYeZJMyuthWdoIC6Kj/PofC9lOTMTZYknMpgUfiaNKEzs/sN4bBAnBPaqcftkvajTc3NnHT1bUi2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680240; c=relaxed/simple;
	bh=AKSk2ta0SrVD6P+WfiVuhpwl0Tm+bQ7BNuE2n3dOnS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vE6U2kmwKxH3okoqiku8rE5HPi03UrY4SO8n2r8B/T0JC9DHyGs5ig3hH+UcDfK0ZZzC6so5myoZBSxm+Q8SH9Mcd92xAZT3lY7myKAT5PpiL4+2gWdYx5rJVlDWW8txQamhD8Vyz96SN4+r4uET8fX+f6RujfRiU5QO4A5uiZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rh9jLmx6; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBFwK1IXbNxnLzELXrnwDtl03vgc5Q1zbosTljv9tSp3MmoIIR7yg9CpjIqS/X1RzZ+0ghvIh7Y/BwU8Jxyyzw9ieQ/WHKZAgI4/AOfIxMai4TkKpkolHjWgYt9LAQYaGNnf4X9q4potZD3NpMTYOIHd55i6SYQJuh8pOJlASWRedAR4Tf8OAcfILUEapuE042znsLkKFUn6Bg/FQdHEUZc6DM+8gZVxevTV8bIEp4XZq5vFlHbLnoZu3x7kToNN4lY764OQqOcfwV6tsgdojSUrqBon2lhL93jfSzqYVfipjpYhlOucStaFO6vaWToMRkUyP6CrzTLUwyD72ACCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuYM7iCc9VYVabx/jf+pAxul4M6O8wHDQVOf1fw5768=;
 b=Fufour1LxssnPB3t19jBLyfYu19oJXtSMOCtA8LwESPWEy0har0vhoWjvZHX+Ne5KHq2zcysRxBA/5q3miPTIUkgFewSvm+L5T8O2nO8fe7ig0ccKjQlHVrInJHRuixYl3ywVZ7idMpOdTemYMqNapCQ+4BxLrOJvTBvYo5K9R3lMvdJxkp+JZb5O6xxgzkjzWdrAVmyaSGesxqdXjiCEshqHO77Bnxy6BpgWoIeDh9AO+QdiuAcZODCRPs3Snq5KPjk/CNvkbAc9KR2AOukWgq0IAWGUjzK3O/8aAGdnMml32Tk7jnYiuR6Sk5W1JjRtGqiyWQPOJy1UMdFAkhTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuYM7iCc9VYVabx/jf+pAxul4M6O8wHDQVOf1fw5768=;
 b=Rh9jLmx6QpqcEZTVfgB/C9KGI3dwsjt3eMTdcyLHJ5nDaStbA3h5ATI6UOLv4P1I3WhhurVFVV7cMUo+m0cu31Di4rPPa234XJh8IanzJOO1H+jcrjfWSp/KxYst2XOjwFsMs1ejWvhSQEnZ+ls/GzlHYmdelpZPEgthlfCBxBjhJxQYFbKz9LfVnTBljLjFa1z6xQ480zNal0WSO0Bzineh/TQ6grmJhXjA3IPjNpDN/LECciKPAqi8R5JCA5zLnZLC7/GWFAP1avogJ4l7uz31YYGlR2SpGZgF2RMyBUOzQr3d3umHP3H7xNlJTEXTzVzHfMDlfWbgrRqmBBKoOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11471.eurprd04.prod.outlook.com (2603:10a6:102:4e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:10:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 03:10:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexander.stein@ew.tq-group.com
Cc: aziz.sellami@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 1/2] net: enetc: fix incorrect fallback PHY address handling
Date: Thu,  5 Mar 2026 11:12:10 +0800
Message-Id: <20260305031211.904812-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305031211.904812-1-wei.fang@nxp.com>
References: <20260305031211.904812-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB11471:EE_
X-MS-Office365-Filtering-Correlation-Id: f30bc658-1065-420d-48ab-08de7a64c612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	PUj4mxWpozqCzJi9MG5jFhk9ikhgkMMnFU2YAJuUB5Bfv38tkQNQDf/Ec2rL2flsieAaLLanPT+sdjB+LRE032VxeOWC34LmzpwVFvhgc4we4QBebKgmMPVMnaY17m6Fb2dogXa1uzAANsViMQsB3BCo7svM5BSmIP3uJsKKb0ujGVYWE0vy8elL7FcpOdVACYMPJhH9GElDm6BCheyy2dFdAN1JLUHD4MY3Np0FXHvsiPClKiLP1FHFlssllmH4P9m8FcldYPsXsaiLGjVUQfQV67Ws1W12YZgUSlKNJDxcZ8v7lXGIF5pdeYyzhFR+rYOkv1Z2uRs+ObRPIU1mrqzMxWdvkRZWeH03Jm2yzHuEZxIU4JSziyo9f9zruqQDzrNo0MW3V7ekAYJtlKfvB2Pl7Nh4Ar9aZO8lsmp0ie4/yQnbousK2L0syDAzwxDkFdciX6H+NJdipTy+NavXsBuWN1Hhv+r6tmEeWXsil30iq8z2MxhrAtG140cPxeB/+xzxLAK9QgjB8sny4uiZ7Qi0SecWl7xTDS2bUnMxz4Yj8LQyf217IZNhnCG689SVWsYehitaqrabsgRVTrGKwYc3aRSqh/Ai9nzCjC9/Ea8T7r+vAlgRozr7kBYyvQC+70bbsOgGJOHm7EID9HVtlTSvSlRQ7t0nGhXl6XUtFcQfcQ3DRpQcpAUjR/DNGeRkdC/Bmzgt3BEQNEBsh6S/XwhaGvcc44E3tCCeR/IDKx0NN7s8jjJgWRVJMqJok5Si8FlBIos3deKj7DiqMR6hj1C4OMlxAlZ4FblzFbNAhTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8knVoZOz95nYsQyCPvn6gQDZq/ww9eLuh5mY1S7q5Pl1a3q9n2KzAZjxQ8T?=
 =?us-ascii?Q?zsPaM4U8PkCPxwWeXzpn+kxXcga6YIf3iE4miA7WMJ4Eg48j4XEKg+Vq2/j7?=
 =?us-ascii?Q?PTBtTZGmaJN8FOCkewoHFdlweh+Saxdet7vjd7Qior3QWahovakIa+x/eJe7?=
 =?us-ascii?Q?YbN7y5LDVQTJtJlSyub7Kz8KdWUdCB1EgxmW7KiDECQQh3Alo37YEqU06P3v?=
 =?us-ascii?Q?qfcfU/aFPXg1nFFpsplsiCHpAa4nKFOzAJR0dkBKsF1QY1StDGvlQ5hVmenI?=
 =?us-ascii?Q?4IO3HAElJdLmM2w19UHj1XzEITo/lpdXxglWq/hGC1ifg+2D7u2/4/+4SHmL?=
 =?us-ascii?Q?HNSYjLAU2fCpOk4JyOTyZuH97HiGMFyrJkV3Yx+dEs0TAEP+WGCAHXVPccyI?=
 =?us-ascii?Q?W/cgguDEP8xvpzaDAqJIUAm8U2OzrbiRP1y+GkkZ0cIqrJPTVFuNnxHX5quF?=
 =?us-ascii?Q?i6yV7PdJjpLiRp+wBmUsYcPerFPDdNDu9AMzjwrGT6bVVjaAx3KNj5/7z93G?=
 =?us-ascii?Q?f28HUFODU/diEqOZdIMwZjW0dnOvAfL9MEmUVW/fie/5ffWTyrjM+nefE+uH?=
 =?us-ascii?Q?tZ40iclFgvpYDkHbW9inIRlFLYV5RoFousJZ5Q4uE+AlCSQF64ML/z70Ctp8?=
 =?us-ascii?Q?Q8AREwO+XPcyLWOV45JR581GETohtypVu/GtF0kNO/X2NvDsc3CMmY48zwq1?=
 =?us-ascii?Q?kRYpuLyQHFg5rbj179HJaD9iLY/IMAz2Er7qnKrbtRsEOu4pgXboesj6NWRh?=
 =?us-ascii?Q?682DT++MbNjls9NMQPoBgNsFHLxU87BFeLaHcUxYyp6R0wZJfiTvaC0l3FId?=
 =?us-ascii?Q?9xlLo52PWhfE91BA3072kc3BR5iiV2WQkgNTOLlIhNPUO1cpHdSBgMrsY1gd?=
 =?us-ascii?Q?Eyk+sQTe0wjp9GxkiNBKmhm2PPSMnFpdRkcNGG+WJgCFeSsYbJ9kqr82BCvR?=
 =?us-ascii?Q?8J1MWqZhJNY4Vd/wX7Zem7u1BA6OXff3B1C+2ZioTlnAs4J7GSXVIW2q8BPu?=
 =?us-ascii?Q?M2ZeY2659f/Okas/lCOOGkNpBJ6DNRrsqGGXnv7NO3FlgvTLss6OBdIPTfEm?=
 =?us-ascii?Q?QSeuh+AcQ40QCoYP74/31EGkoyX++800JC4PF0avpw00c7xjzIq2MyusDhNK?=
 =?us-ascii?Q?9DyMiwgQM+pmXyWNBzm3yA61cDNTt9NhqfDxEW6QExzL5kVvdEOAe69Xjk5p?=
 =?us-ascii?Q?wg0NkIiDs3RhsH5W+NXdqe37PDCgoa2okbUDML6HqvE2FPwbRh+vFAXdm62Q?=
 =?us-ascii?Q?pYRNtee+aYVigOHyV7p9tiMCeKqcFQltbDFYd0zWQdPGp2kgR1uqLJ9Sb5ua?=
 =?us-ascii?Q?o5JymCkjQA1fYfvSONB2qsputNjIijzzY0YfLXnkGj4AOTikJlx29IXmU+jw?=
 =?us-ascii?Q?H8Xd8l/s7SV7DlICwEfF/etdxt2aoGxLSej3RkvKllBH4LEXb4CpfUSgo7Pn?=
 =?us-ascii?Q?8jNh6Sk+tCyg+OwARRazHAqLhVGY07h/aZ4aalZIWHnydGBhI1iarCxk63cQ?=
 =?us-ascii?Q?Sq1yDTw9fCVHN1HIdHsIGigrHw8JN1Xev48ijscGmoRxiJ5BkW3Re/wpMr3z?=
 =?us-ascii?Q?MiMzbnzL7L5I70xkWq4xV8vjlVjW7P07MlFv+INv8s5WP2PSkwRR2YVAOHyB?=
 =?us-ascii?Q?gRYPUTCQQ1ca0cMbflRtKLnCAkKOghNv72XdAehRPUyjuyOzGstzV7PQVCDH?=
 =?us-ascii?Q?GKcqKoc53OgH6IVnNe3gjbPFTzm/w98Cn5PKVwNQrz2byJnU4IMTf+xJmKA+?=
 =?us-ascii?Q?u0IiqTQY2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30bc658-1065-420d-48ab-08de7a64c612
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:10:37.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Bfqbuf0Mhtu8/E04dMcChZkmr8EZ4VbTDU2kjT8HU5/G98K9N+ZQgF+51icnjxHz3AQ9O2bO0nwIXeyozO8Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11471
X-Rspamd-Queue-Id: 59A1020A738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264164-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The current netc_get_phy_addr() implementation falls back to PHY address
0 when the "mdio" node or the PHY child node is missing. On i.MX95, this
causes failures when a real PHY is actually assigned address 0 and is
managed through the EMDIO interface. Because the bit 0 of phy_mask will
be set, leading imx95_enetc_mdio_phyaddr_config() to return an error, and
the netc_blk_ctrl driver probe subsequently fails. Fix this by returning
-ENODEV when neither an "mdio" node nor any PHY node is present, it means
that ENETC port MDIO is not used to manage the PHY, so there is no need
to configure LaBCR[MDIO_PHYAD_PRTAD].

Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Closes: https://lore.kernel.org/all/7825188.GXAFRqVoOG@steina-w
Fixes: 6633df05f3ad ("net: enetc: set the external PHY address in IERB for port MDIO usage")
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 7fd39f895290..f0e103615e88 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -333,11 +333,13 @@ static int netc_get_phy_addr(struct device_node *np)
 
 	mdio_node = of_get_child_by_name(np, "mdio");
 	if (!mdio_node)
-		return 0;
+		return -ENODEV;
 
 	phy_node = of_get_next_child(mdio_node, NULL);
-	if (!phy_node)
+	if (!phy_node) {
+		err = -ENODEV;
 		goto of_put_mdio_node;
+	}
 
 	err = of_property_read_u32(phy_node, "reg", &addr);
 	if (err)
@@ -423,6 +425,9 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 
 			addr = netc_get_phy_addr(gchild);
 			if (addr < 0) {
+				if (addr == -ENODEV)
+					continue;
+
 				dev_err(dev, "Failed to get PHY address\n");
 				return addr;
 			}
@@ -578,6 +583,9 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 
 	addr = netc_get_phy_addr(np);
 	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
 		dev_err(dev, "Failed to get PHY address\n");
 		return addr;
 	}
-- 
2.34.1


