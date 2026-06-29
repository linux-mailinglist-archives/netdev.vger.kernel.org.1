Return-Path: <netdev+bounces-302586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bVEbAw9ZQmq65AkAu9opvQ
	(envelope-from <netdev+bounces-302586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:37:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE4A6D9834
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:37:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=nSKuexVF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302586-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302586-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 407193207605
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC9F40315B;
	Mon, 29 Jun 2026 11:23:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B82402BB6;
	Mon, 29 Jun 2026 11:23:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732235; cv=fail; b=ewZG3laEbZlfEX4E7ONSeXVmow3H+RF1d4k8o91mTL0P14bF0VxTRPmoY7fiValy1SGVERa4nTPjWhEloBJLA8m2Nq5pOQBPVHkj31Pzhs6H02DWCkyJJxRYvXY7zGYHassFZr0LLwM6CGC8kQ94qEEmT8HLHNnGKZvioPjZapA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732235; c=relaxed/simple;
	bh=sruG/B4TZEujFb8L1XV5chloqq7yYYGEjq9itl6ymac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVhYLVEWF9FqJBu3mEHN0XphfipdI0wQ3S8j/6oejxuL6TuJrLwHUmHv/ac7P0tj6/56IrDVxlnHr1Buos5QjuKi6G5095vPvUCv82gZTJZRZ07YRYp6xc9+nE2C0i0LwuCUvXlZ6glmS2spgtqLllLrTxRTHwkG6EqcDacfrbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nSKuexVF; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS0tKrUV9HciZjRRhv5RwKSOqsswPRDKfUzL2RIdzBihJmJxX2Dgm0eSvNMBQIg3+3mRxu1DWoQK7mUmt9P+HoGvIoGD5ECme+mFPEXna/0zfdhVcanT8pU/SfWzMTrpXwmLww4DrHp3zh+hqBlpMTC6fQcbgi9Y2Hk3TACMUEHN6XpsHt7HtJOIQUMclz9YeyRiSotYCN0HaFJsfIEFbp5filugHP96QOXoVnLFoc1AIkXGfNqmlVsybVjzIdBcyIPMkYHZy9I0258/Em8J8yAJyJsXfRpWyiTUTe7FucTLR83/MoX7N/DmSWUXdov4JyN2hxBac6m1qVi4Qk4oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWE7Dfc0l9pgSVJCk2qL5RUtEKX8GPuSxxMyJ9q73MY=;
 b=BqnhCxbJcU27SbwxzhWeu57pDw5PskoH/gveDquCeVZ5Yc3Pj6m5l2v6w4TCdWtIfQchDNTe/glQUore/o6JW0bSZHyFXRm3njixhVvhv3g/TxCtXmFXalXhr5EM4nHyCGx8Eft7qkS9TCpYOh0QXJDR8UcQl3QxU7WHxAi29sSRX55MJupfOQ7l38bWHMyCEL+h2jgYw0UkyWNbVq7iiXMnu27vWDNTCDrxNL6CsYOjn6adSLWb5RPjR+KatfLoCMAB1qljTR0i8bmThxiDjB0JE61rcCCRmhLxaz/GRknLGxxO64PKG0oTcUgK3kvuoI5zb+RLMWn9UMfAZOR4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWE7Dfc0l9pgSVJCk2qL5RUtEKX8GPuSxxMyJ9q73MY=;
 b=nSKuexVFHf2r/+LA2QRi1ocEp632za5ozU2PYPM1HLcg2Vl7z11q/mxi2ndrfCAKLsSy4PsInl6QCyh1lryAnTFhZluAlOGo8IypoywVCoB+//8uj6Kxiqkg9E0ilml9n55AK12J89cS9TVgzRLRbRVLxKdYPxGtrpkU+a/Ch0HTH0wgUr+N8GeLAvM+QetEOX0IKj9A3c8TQJcyhJHfmdSZjM1ykWPl7RyqplCpZ67dOfrWuThY6U3gmW8C+GsfAs840TWXzcfjOG+BvEXf3sc/VgjWxqbqqkxOYQojQal7KLwigdygd4TeXxeaqH1k/fPBElt/SPiB4R2Mb/jDIw==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:50 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:50 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 12/13] dpaa2-switch: trap all link local reserved addresses to the CPU
Date: Mon, 29 Jun 2026 14:23:08 +0300
Message-Id: <20260629112309.154328-13-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0065.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::10) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 1540340d-e838-4c48-7099-08ded5d0e4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	U+K+pxvvWZJUKn83JEfvigDbSZJksN8awYKw0P9qY2d3MOyMWJNJtMjALeeG7G5/Fq3ApOKXVW6ZrCaOoD90eHOH4uMRtb0ltIBiOr8SHekXMo57JfJ0+G2HjuWjwEfxtjdLDA5KetDrWB+oHHUW19I1v3O+KEhYE/OUMtBC9+i/1ttqvJCLNarbBAlP+Jrkz6ZBQ+wXh/PzsCBeXpRitzKvZzhGRGZ8neZas6gfxWGU2pDfqdVPD93YJnJO9OpnTUiicV19l9FWXdR6ARUlJQxOxnHfdEgdIH0tZDrxAakqR8IU8UCV5W+BawxEyfNRXKiX5Tt9V5+omSWpOGXtD39UXSZ7X7BskQhk3ZKpOJOj5KdzTnWxmnPxtFPkGUEzSFpvNuH91gRHun9QlhuO1KQrGJCACvYgJrPD58t7h1Zlh8pPqdX2zMRL7VzqnR5J2ZUhEV5jR7N6d4Wf3hP6cZsnA96/QAMca+rk2wUL+qG9017JHOUyVPZf/RdsXgJrXmP47N8QJwuD8qbCfpoYm/OrV5RWp8FGI0cAmTrvEqjkSMFH1pZZg/ca2KpkWS6yqitl6hWb2X8r6xTuA7gboGTtcvBR8iNyKM8HwMd1WbqrHlvBLYMOY/JczfO6Wdc41ZevlQJy4DcrClHkqHxgTjISl+AvURaaodmsWfHKoKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/EN73UjW15fxgnmCIH1aQ7H4humCfzO5xtf1rruCU2l82yYRlWpEh2WZNRh?=
 =?us-ascii?Q?Can3R5vTIRyjVY3BknywlFR/LwRoKbNlxWsDFAgn+2WEqs19tetJJ0CMNDzg?=
 =?us-ascii?Q?gzGir+6VswVQzpC17axQVVdu/2uwpMfOW3E2cSohtpLhKg0YIcFHiFCMRTtH?=
 =?us-ascii?Q?zOWBDkhyGH80psDP0HREy00OAi7y0DUFxMp3hOONnolOuhZXeaLoGw7CRFdo?=
 =?us-ascii?Q?+UL1NmlQPtx8MO8qbi3aVUFhIHkc3ufrWQ6zY/eMwGQM7PKL8uFc1qPi7cOD?=
 =?us-ascii?Q?ARqZ/8i650ulFKwmiS22pGc/Hx27oi27NyNDE70r2d3mM4SbclubsclwDT5+?=
 =?us-ascii?Q?nzLgcBRoCHGWlQaG7QSv8HqOhmqjKG6z3QZ1s66Sc9LZsi1rBJG9zNl6YABg?=
 =?us-ascii?Q?2lgBiRfcHuAfA7l8wZRnKNGncvPilEJgroOwPkL67JsTPvagYFeni58Qsu3J?=
 =?us-ascii?Q?WuHEXfUx3g2L2vXF7x6IyxiwCiU7VqjxJF/nGaKdoHXyx2MkVUIGp+efz96P?=
 =?us-ascii?Q?VI/YgGCvOE7R9n6QzsHjTMN9KZ02v/05mFIe/t0ug9f+iQ4Feh9ETiIMYJy/?=
 =?us-ascii?Q?qHlXY9QSPfeoe2pq7NbJUid4jYKd83SsXETDEaZMCqoGcC/1uf317n201mHS?=
 =?us-ascii?Q?hYdT97eN1acBtW2NsIBTzWAPEvpd4cobpRdmqLdYUeFB1EKCsUBCQ2ZOahGd?=
 =?us-ascii?Q?cx8E/ImHOCuuTbIh05nP9sK7ybsbFOTk1V9mvzDsmrcdpa8SXYJLXaMbX/+6?=
 =?us-ascii?Q?0UG8+7qMsXrfThvH4AQNeF1zjKUFUl1dS6QgjeMDyKTf9eomYfpMTqFS+oWr?=
 =?us-ascii?Q?eQrXhS2D3zBMm4PFzubC+U7Ck7wu7SFb97bjBHiHyipupsKmyu3+PNA7RymB?=
 =?us-ascii?Q?4Wll45/vSxqTsziwcJLU/iMZhiABOcTT8jHSPyEZ8llKuYzhRdN2zPXt2hEP?=
 =?us-ascii?Q?wa3dIOe6CTLqV6QN+Qe18oQisUhlASQ5Fc5111k2JaEZQ5akwUat7JPMuvyW?=
 =?us-ascii?Q?auzK3b1UR8u9lrI/LIKML1Rvwz5EXpOgWagnNAYaxMQ39sSR3YJl65/cEjsK?=
 =?us-ascii?Q?PqDXF5FAsfKBAhJfbFf3EgvRBjcoqwZ9LMOP6HrzGwyfnzWOrhZUI4UgZdNv?=
 =?us-ascii?Q?SMZjHI6kytm0TTe/jqaL1F1TRAAPuv8fn5wU8+plTPBNVlmuTEMRYX/Uzndv?=
 =?us-ascii?Q?KZDjDY3uKe/1iKfIyDsGg/i60gG5XJIffGd3Yh4PQkEglXFCjGUZBKkEQx6V?=
 =?us-ascii?Q?EgwLnJMW4vaX0NsZSb5CftDE29VhOHzwAQ8vhAHg7zdnKuXeKepF5//BmDfm?=
 =?us-ascii?Q?Fc5sHjtLCjCVesRNjPSrdtZBgpmhqoHxm9C0Q16zCIrRSL0l2eb0h3WE3Udi?=
 =?us-ascii?Q?us+U6EcrkAJWtYHxYm0Mo7zvyOAQy+35rjYDCSDtVd2Sw0d9i6t21Q1FZbwU?=
 =?us-ascii?Q?uTaDVstNrGDN6POhQrWk1PbRB7DwXUP7IR0KcRFOib1L+r2OKkOs+CK/rReP?=
 =?us-ascii?Q?yOAKsePDjcEKNL9GsuG3AEr+3gFpwHoYbdpP9e6eil5rXHLNv3vi58GSufvi?=
 =?us-ascii?Q?QDxCF+RAhpZ4TmfvvcYNA2d7SToFm/rAlkmYDl2UsFxLydfelRN8fPYWmC09?=
 =?us-ascii?Q?ksi6jhXFh9fzP281vMIjvv92vz7vnhfKSGJ/uoXLs4N+UEvCJWMQxIl1FVnq?=
 =?us-ascii?Q?Te/YSJBa50CC6dG6UqErWEuRV7N5AJ3cLqa8wKnzB8DBrlD0/A05FzC58hW4?=
 =?us-ascii?Q?zaMKeuMpbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1540340d-e838-4c48-7099-08ded5d0e4f8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:50.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkLOA2q+UNu07A00CzqfH0l04LM6HDK8YVQ1nQgM1WpIpNB9N8UaxxG0nmF8my3V31M70xi4Y2V4DpopfenC3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302586-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AE4A6D9834

Do not trap only STP frames to the control interface but rather trap all
link local reserved addresses. This will still be done by looking at the
destination MAC address but keeping in mind to not take into account the
last byte.

This change will benefit LACP frames which now will reach the control
interface.

While at it, change the prototype of the
dpaa2_switch_port_trap_mac_addr() function so that we directly pass a
'const u8 *' so that it matches the ether_addr_copy() used.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- none

Changes in v3:
- Change the mask so that we restrict the trap only to the link local
addresses (01:80:c2:00:00:00 to 01:80:c2:00:00:0F) instead of the entire
reserved bridge block of addresses

Changes in v2:
- none
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 1f7875ecefe2..b94d83f5ef06 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3828,17 +3828,15 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 	return err;
 }
 
-/* Add an ACL to redirect frames with specific destination MAC address to
- * control interface
- */
+/* Add an ACL to redirect frames to control interface based on the dst MAC */
 static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
-					   const char *mac)
+					   const u8 *mac, const u8 *mask)
 {
 	struct dpaa2_switch_acl_entry acl_entry = {0};
 
 	/* Match on the destination MAC address */
 	ether_addr_copy(acl_entry.key.match.l2_dest_mac, mac);
-	eth_broadcast_addr(acl_entry.key.mask.l2_dest_mac);
+	ether_addr_copy(acl_entry.key.mask.l2_dest_mac, mask);
 
 	/* Trap to CPU */
 	acl_entry.cfg.precedence = 0;
@@ -3849,7 +3847,8 @@ static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
 
 static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
-	const char stpa[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mac[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mask[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xf0};
 	struct switchdev_obj_port_vlan vlan = {
 		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
 		.vid = DEFAULT_VLAN_ID,
@@ -3924,7 +3923,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		return err;
 
-	err = dpaa2_switch_port_trap_mac_addr(port_priv, stpa);
+	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
 	if (err)
 		return err;
 
-- 
2.25.1


