Return-Path: <netdev+bounces-294789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jiIeGFk/IGrezAAAu9opvQ
	(envelope-from <netdev+bounces-294789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:51:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B41638C99
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:51:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="J7X/RLIW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294789-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E22243055040
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69E3DA7D1;
	Wed,  3 Jun 2026 14:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0D3D9DBC;
	Wed,  3 Jun 2026 14:37:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497431; cv=fail; b=CpLQGf5dxvT3pAvVjMNWtALhshaYFcPvqJsg3mI+mAbpiJXPPsoDmWuXewtTln6M7b1w2VjXxnghUPSnDrQnY79UJr9CxUyYcHXmVQi4QEV9wKDYkDKpDA/AgxqxVHB32/FJ9He/8AEf0MpUHP2VEhRJnZKx26fv7IVG9Q4V/U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497431; c=relaxed/simple;
	bh=x4QC8cZjc//VCTiSUCEo32nM+DYQBzhMgkZvtIAyuRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhrkvwQ0frYyVyD+ocQuXnxiLQd9tNbuD2n+/bijMHJEaJOgCDkhg0FKAKz0+3Aso9VD5vepR97gUUZErz2rSGzxNdqslHABrH1ylhfE3f8G9dJ868ymhuODMW/Vki1hTtjKq/PQRaoeNELC98b12Q3WS6kaNJZG84qbcFdETyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7X/RLIW; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSOI2+Nv6qUppSYy+hZQt/sXIYdZ4sP2ckelqPCKbjojTlzZ1BZb1IeupaUftG/zG8KUq9ToRsKpODlZzVEva/nXSdoiWDtx3wDDyCCI9H7jofnNE5AjFo2J8QwLIk5/ONjnirnQbxTU4N0D1HvxUfmdjPhDMoSVVRfNxFfRkqzoMCtJDHRw9LVNSzZfxYn5LQqmrk0Wxy42+SUgEup5XfTaILwEsoeHO035BK6M0l4C4EOvRmzrehLxIOaK6F2Nq+QbYdcOvy3xFVNiCULi0IB3NU6CVOTK4l1yc01rFX/IhqastwM2JDehVDLnjBoFe+R16HCGivfVzZpVE8hmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID12RCYxYO87RkYeyeFYrZ+AI7ZpnkekGKeRZJPufB8=;
 b=NKYSHThfsxBEr+psbGkSQBY49OSIgZyUDBRua220DbhtR+mrPkyBwDeimDPKMmQ9BJUrXUg5kRFQoEWSZmxmrmiB7Q5yNR75aQ+EJov9VcmbDpRpSA7pLLt+B6j4M6d7xtMCZ1yT9YWxacN3oRCBGG1WtLB9VLeqh/X8Lm0scvNXP+nkIR25xnmLCEEjFLwuTYakjdUCT3NOMc5Lz08ZrXSZBRATBrNvQHZbg2ZlUs2NYrUrazH2MRdoNJSHnMz/eJXDHVV0sh/yMyycYLbiNfNPoB9oW9oesYNJjAY8dke8u/P3yTIAh1lcpMoPM0ldHQ0632dtp6L04mAcFkT7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID12RCYxYO87RkYeyeFYrZ+AI7ZpnkekGKeRZJPufB8=;
 b=J7X/RLIWzu/ypO0SXf3SQbLHipNiW39RzQ301ahapXFZF3B3P0DFf6XAfw6OjzJl2yPA2q9xXmXk5hMp4zuxwA2MyWIgSJem1d5805Eg0d3hYX2G1/gSK+QVqInDhVbKQyUbdXqlrvGD63HNICmTh1bgRuaITkhbcir+Fw35Yw81vBgDBPICBzly2/eXulfBtsujVS7uK21/q4Sufa57IfyYo6Bmq9qZLSJ4cFO0ZaiKspRBNLyaOXs2tR3Wi62bMLG0bU4GoS8jDdY7WsoN8M02aNJIPvfj830u+AqFhv2huzISn5B8Za9TNk92NulOksrnZVHgtbqqbhbSFQsR/A==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10974.eurprd04.prod.outlook.com
 (2603:10a6:800:269::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 14:37:08 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:37:08 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 12/12] dpaa2-switch: add support for imprecise source port
Date: Wed,  3 Jun 2026 17:36:23 +0300
Message-Id: <20260603143623.3712024-13-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10974:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4b187c-af19-4c35-9198-08dec17d96d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vwGdBdAlsV1iHcnORklbHX+9u5GmgSx6ONI9tvADAqeezGD0BH/ti0SKZrxIDkIzJTfvu2UlTd9iRCAwzOf9r+dWDhpfwPsmwdZr5dbh5JCabz6dWFqi0gr4T4LAhcoe0M0eVbHbdoHZHMgym/nJzBoRaCNQFkwUulhZDM549NQiEFuQ2l73OMZjViQkJoyEcO7dorlBgFeKs8yAYBoX7N+IjiNKKN5qNKq44d2eoBGq97QI1WoxYphPZS94xs+2P9baARtlvoUmmQVwygS4JJaaY1v97i0wyLZCJY5NblOwAZTQXko9ELXXfbkq9v7eu8exFglhe6Lt2aHH7B03S074uw3syB4OOYprLLg6xaU7vBheDaDuvE9G9u/a2f3n8OtohYt870gI0dEfwivc1Bm92T4AC+26k6K+5orqUbZX0vVC2jW6mR1IZrCnxUArlDxSYTRYshhnndg3vpcdz1y5MVzNQmUoxD18XDyANH+hnr0X6GF9sn9WW80kowpror13O9cqGC0Q5pLm0k1Ht2rf/b1JZ9nY/IGZXXI22LXFVHPqnessCBhz6+dDF+R+EX0Xb/30jZblWpSWeN+f7E9XHnXOp4N3ggMClc95kNYHkjiGbWV3daGCTJ0IpkSxpqRfHhClwyQ8InE3bfid2ZnVw68reK9W5j0vUjiq45kuqw3KOBVY8oUUiHf5nXaZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1FVsJ/ZKs8jHncbjfLM+2W/y8MyCruvL1dy+n/VjigIQ9wcZhPgNDHn/rjkG?=
 =?us-ascii?Q?IwKT62KrxBqtYi/ukiZkEHMBdYPK+NpvLPc+1AkgNrh7nfs6Mk36O4GQjDqt?=
 =?us-ascii?Q?zxRVvCJjBfoyFs3RSlHUYuCijNpBjz1yBTdK7Jp5Bsu13ANSS6HHHakll5cK?=
 =?us-ascii?Q?UlYUZ8AD5q6SUAvKg+U6L51m8R5WXdXCPJxu/CwF4lavcFGbluCO3WiCVNun?=
 =?us-ascii?Q?ymwtHF1Od3i2uzFjZM3F14R0KhHguQKg6v4kc3Ev6Ryxd1LaOQiheQAl/EwI?=
 =?us-ascii?Q?6j3GVD9N1CKBhlS3eSOsX3vL8gG/krbQosndnS/nNi+RNR7qEsXByMWDpYNM?=
 =?us-ascii?Q?+bLyNxX8NuAH+w435Id1cCqrM847F3KZj1AK7pSlpjf5VUeG8ZGAFbXt1bWR?=
 =?us-ascii?Q?hZjVAk/fHfEU5NtDlH6MqG6KOmXAf33STbO5Xhfrs+gktQ6AEevV5bjID8S+?=
 =?us-ascii?Q?aPmcZ6YsU9GQA6hUcvXW4Irk9yiIMjVXwAnn4X79cpZPcfij4cIdmgUejkEs?=
 =?us-ascii?Q?nJaRMn7id686GJWHQC7ylMBn1FAecrM5Bf8pkzDm24GqV1fDZx9X2MW43gUJ?=
 =?us-ascii?Q?upwftTeWdOW7oMGu2yh+UmAn4c/YtThhDt1bhZqmUqy1KhxmKMBXYv256c13?=
 =?us-ascii?Q?JUSdTP2+HHO5D3U+y0tDzwXyRRfZDs0k5+lXM3q4LDD7rmskKEWg2xmRk+Wz?=
 =?us-ascii?Q?oMgLLdlUVAbbAOYSmcJmyH+LVNixlN/ZtvQkvfafyJBQ6Hc2McfwPt4+WRnU?=
 =?us-ascii?Q?hQSbGl+em+ux6QI5tQg6WszguSSiOhWGw3613QBqusH6/9WDsedW8x3G7Rq/?=
 =?us-ascii?Q?ADIlMQs1Kk6F3142FOjGQMZwLoljPrRgNeuPs/NbFSZDNyaq9DnZI+92GiPX?=
 =?us-ascii?Q?jOVAWMuafDPETgZl4DVSw31Q9ns5XVXCKwiKeYz3Lky9f9P5dqLl6iNuHQeq?=
 =?us-ascii?Q?YfKj19bEx3xExM1ZOR5cH2bEpdMpYlYazObtfWML35BeAdmHeBJ1JyYkSzqx?=
 =?us-ascii?Q?rM1uRTa8c7aWIfUMHE5upldI7qMnb2CmYAceVivJFclhyDKKF6QI58wtUPJL?=
 =?us-ascii?Q?7IL34K4bSz/Le7NETOO/52V61eQlwGebHmcsGUqvCLt1DK6zeNcJ0H0xf62O?=
 =?us-ascii?Q?fR7YxjZ4lQDGq4XsZJQPC1NkKMlLDpUnv80woZmg0hEXAXjQrOlsW0tnduNm?=
 =?us-ascii?Q?UuuP2oMi1gpPCkc37lTy5628gsmUZOlLOFVu0c4EBqIJ4AqAt36czmbAHovK?=
 =?us-ascii?Q?7y8083Cw75F8oWUaF2ulehCMyxVzMcxo0L25aIMxoVyi8P3XFTToYqJ+9Hw3?=
 =?us-ascii?Q?UmbqCE8dZiUpCqOCPoHm0YVXNQt1bG2cRG5Y4a/wvF0jnrgNTSvc3pRF1k37?=
 =?us-ascii?Q?sc7zIvRstMcjR+5grrmiEp56D/MB121h0qpki1moRQd2++GWkgA5UHYHgRTR?=
 =?us-ascii?Q?QzeDPhdk4xCZKIxsWstbt0lslURgWKFpy+7ZZpaFsOdd1xUYYn/vSK8nhTqX?=
 =?us-ascii?Q?87tCEUoMl9DTuN9UjLIYuii7eW0TSy3rn6K6/SpcLlsAKEIuQ1MhTS6BEVNu?=
 =?us-ascii?Q?sQHFrSaoaeeDHogtzorkp6atPAH25vqSmSLVpApfRTCyDGa0ha1WM0s1lqwH?=
 =?us-ascii?Q?aojvmDHgkNel+xqZqePnicc5xto3+Jnw1OSs2DE3RKSjYlI9GrSzNwEP7ybQ?=
 =?us-ascii?Q?RxWXF1N7hieqavEiUI3HX1rHUWMMb7kmwzCXaEIblk58vjdhtjwitu6lCY3x?=
 =?us-ascii?Q?QXTXXyiaVA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4b187c-af19-4c35-9198-08dec17d96d6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:37:08.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nJKU5IkoiNlxrrY6xCr7fFtQybP8V9JWwsLR4W4lfiOsgNRsPQRMdA2XDVRvNw7mv7Fs2YwSVLVyRdqpQFPvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10974
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294789-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01B41638C99

Switch ports configured as part of a LAG group are not able to provide
a precise source port for all packets which reach the control interface.

The only frames which will have a precise source port are those that are
explicitly trapped, for example STP and LCAP frames. For any other
frames (for example, those which are flooded) we can only know the
ingress LAG group.

Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
its value target the bond device or the specific source netdevice.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- None

Changes in v2:
- Fix 32bit build by using BIT_ULL
- Take a reference to port_priv->lag instead of reading it multiple
times.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 +++++++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 7aef34778e22..163f6c51c160 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3222,13 +3222,15 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	u16 vlan_tci, vid;
 	int if_id, err;
 	void *vaddr;
+	u64 flc;
 
 	vaddr = dpaa2_iova_to_virt(ethsw->iommu_domain, addr);
 	dma_unmap_page(ethsw->dev, addr, DPAA2_SWITCH_RX_BUF_SIZE,
 		       DMA_FROM_DEVICE);
 
 	/* get switch ingress interface ID */
-	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
+	flc = dpaa2_fd_get_flc(fd);
+	if_id = DPAA2_ETHSW_FLC_IF_ID(flc);
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(ethsw->dev, "Frame received from unknown interface!\n");
 		goto err_free_fd;
@@ -3270,8 +3272,10 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	rcu_read_lock();
 
 	lag = rcu_dereference(port_priv->lag);
-
-	skb->dev = netdev;
+	if (DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc) && lag)
+		skb->dev = lag->bond_dev;
+	else
+		skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
 	/* Setup the offload_fwd_mark only if the port is under a bridge
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 106cc9d7f0ec..8cbaea1449fa 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -87,6 +87,9 @@
 
 #define DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE	256
 
+#define DPAA2_ETHSW_FLC_IF_ID(flc)		(((flc) >> 32) & GENMASK(15, 0))
+#define DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc)	((flc) & BIT_ULL(63))
+
 extern const struct ethtool_ops dpaa2_switch_port_ethtool_ops;
 
 struct ethsw_core;
-- 
2.25.1


