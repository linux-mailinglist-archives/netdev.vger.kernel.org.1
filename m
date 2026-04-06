Return-Path: <netdev+bounces-275730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAP3Nv0a1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:43:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3F3A7496
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A07305D6D3
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315553126A9;
	Mon,  6 Apr 2026 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KcMBHLJb"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B68338597;
	Mon,  6 Apr 2026 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508102; cv=fail; b=lRd4B0cmEOrAGtZ0/H6UxlPUwlXfu+eg854bWyPKEl0zy0Lp5M/XPT2Imj31r/aRlUUkidT2HzaBITQoZwhJ5whznGmNEEjtF52GjGnYsOnECjHAj2FLNtM1TxEy2q3hqkhINbtd62RdE5NfrZAJHJcpyG10Nbbja4Hm82nNrWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508102; c=relaxed/simple;
	bh=g6CSRNP2cRv0gKEeSjEg0xT8sN8CRk+BBjTlw3GiKxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMdDTOHlDYkrWRDvke8D2CNm8R5YNs82cCqk7Zg2KBq+QH/bcKIY93qY4/iSEhJxwEw0ITUkTBaNcddCF2+Oed7MS43iljnowVkoE/m+xHCkasxUbtffWcswss4oXfbm5iH8e+7/xdSYqI+eUpcStfhSj1HULcBPgc075TJLUO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KcMBHLJb; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrxXKBjVF4fjjqRhPeFPzOAnuTuIQfi38n1WgWaXmcVjnGMHaMhh3fy2sHwdQkCJ/+clf/J68LjWS7oQ++eJkjxibS+fapy2buiJrwhrphsKVU4ySMD49p6Z9Za/A1SB8KWBZ0LMlAt5FEz3ReB5eVx1lQQVi74S+qq9BlKT3JyefxL/F5Wu99pEn5k/GK5wNkE5Xk4iR1MSAvG1jAfNDTlzp/zdlZlRvZbYt+7tjbw7C3plkGM6HtU4usmk0QOwMMvNUutYE9A0mBk/kxZmnOT0IdNtndqxG3+gnSyKFMadgyVnfvZFcj8bPkm9hsnXR7d2zYrTLpCaOqooyqflng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXBzzsoQNU6j7ofn0p4bUVGnCUQrVOJlAiEwyUk44oY=;
 b=Y7DUZpzWoC7sxueF4RrXQdtzVWLh6z7g2aTMAUslCsYcckmGMEFKRZynhyt4+Lnkj1lB1i5K7WHoHb7zfWBeLQEkateUSq6iWK9i6TY7FYcqfz30bOOqU3qHmyHANzIPr+FmYEnr53tSKknA0Dx42C0Z3wfZtfx+/aHEV++qQJ3FDM7mt/PgaxeHnfaB6zBF+Wy4z7LV8Wv9dcc+pzrBJH2UKHjFHzQt4akICqF83K5RB4iFbVLt7c4+quYLz4zqlDfUCEY03zSIrnVXXT5Iao5WNznZxR5fKFGYwvzxV3Wnes9lYAr5R5htTknj+SJHFEX4Kcii27ao4TE62BZOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXBzzsoQNU6j7ofn0p4bUVGnCUQrVOJlAiEwyUk44oY=;
 b=KcMBHLJb50MourlbQNCoqKT9dDVs/ZMThMnoIYGgiJPMnQ/vgcsfWAcPbjGJhaFmBtnJYV8XlBjIj2hAYM9VPdmV89wPrcuiDSnPqqdAAT67m/taOrVkeo5GmpBPfS8w4N3qLxQhNDCRvfcUUGQQGJcPjrFX1zRfdlI5FSIgK0BsW6fWe5igyz+mkciU2LLmQsgR6SiT13IRNeHa4RUMukPeghDZlFmGzyYDXWpiwW5E4nppf02Y98MI0tLx3bX4DKakEZsPKYEhaOnJJXlcRixD9Fth/C2D6k+3H9wh8dFe1M9ZSdwr86NyDP+lxYWuJIzT9T2MCfOLjtcKNFvF9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:37 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 3/6] net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
Date: Mon,  6 Apr 2026 23:41:19 +0300
Message-ID: <20260406204122.167237-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406204122.167237-1-vladimir.oltean@nxp.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: fed105e6-b2ad-4bc3-3f3e-08de941ce61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C9owig+ExcbCJF+ak/ZyhGpwUug2bP/O/FaS4BFLXDI1XzahWqDCzq7KSStm6Lr9oa+5w4n3Si+us9T6ihE2uaQNR7yPjYXW3o1P16noBco1O1kMDMetIpTQZzH6C17lnJbFO+M0sFw8Mdlym3RRHI3gFf+MXfBEFVGyxLS3aUSY2oKY58IhzBuZM+U7bMUYgr3XJrzprNqTsIva8He8a6ijUFIOgGfdRM1C98/mjjsb8rhNZCxHbYx9Hykd2bBvaKLu9MZ5FcsFPMmfoKiPJqBfe1xjoxewzwM5vHq1XVtxR14vriJ+lcM4zUu99wWshd7P5yzL2c1t5GHCgfuyQzeu2B2WEgVkniyf3C2TIQu43ZvsHs3mJtWiH+jhRxm6icQggIZXhnHjK/M+oqHbNSQ3VU0mJJ8jrU72zjZM/v5WlNhgZplBEJzndQkIp5PEgjjw6oyAPDCCOs5Ffu/ofPlNu53Obt37tMm/oU45L1olVWoemieqmh10HKko8QUe8Jtltx+ICI0hY5Tm9Yza/JpAuWc00qhQQe2RQStQXGsNisZYHmu22wQ5pPf3Y/rkQwi7tusIWFQe4kaS6bqasfb13qgxXj2LdjYtOEbvBqT5BVJ/OKvLthosF/tnQ8nHz0NuVwECrdGhk8RoSxTGZyO4lvd3pSOKHEnbAH4/pNkHv9xTA6YY38yyW1lHKQBxu6RUQdETKlq8yIuVz/RoR44Ng5BoHfnkaGHwUJRL7xw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTU3vjIkR6XIWg8oJdOunzUavahu4T1AbePQniO3novT9AwaehHO0xl52IF3?=
 =?us-ascii?Q?6uKaAHQpfw9PG6beykBAImle87wLrsJLAtSLky09P2B+54+gcSYQX9B8VGoP?=
 =?us-ascii?Q?15THVK/8h/kpSCFGT4EIrTkuJSw93dLH6Kyslz9GCwoyOmzZ5Mol/LHzfKkO?=
 =?us-ascii?Q?2BySHx6mndZD6PaQhqia08lZRiWrlEgbxhc9dAVmjlM+piG3k1fC9koStFfZ?=
 =?us-ascii?Q?50qMfZgiOQrAUSnay6Lu+o06fXmURArgZCwgqESUj4l6wdcN8Cm1aJXOwG4X?=
 =?us-ascii?Q?Whi1srW4crJZXkYpc7dgDvfhH+UuP0XofUVehMlWiZY1PQKpwafXJFqo5yxP?=
 =?us-ascii?Q?1SlNmtmFjimpSLDVA/+xFVTYiFnw3NWObZ+JraL18qioS5FQ7o2t7WDO76YD?=
 =?us-ascii?Q?CpXRudR2ogVO3LyqgMq3irJPr6frIs9MRsy67pJ7W+EfgMezAFUv+lb+6I8o?=
 =?us-ascii?Q?7Pp65qeFy6Cq4Y1+K6SBHycJ9L4i6ZBvp8NkD+MFUvl5ux+kZTB+TEVYOsMP?=
 =?us-ascii?Q?Lt9fFkDPfc9MvIXZ1+Cw3rr7nqvS/OzZjjh0OwoB5h8WGN9aUhm9YGTcfQSE?=
 =?us-ascii?Q?Mwwmtp6hQpc21aCjHXz8MGoGb2SwvRbX6rlR7s+voWGEXRAYeItwyFIJ4e26?=
 =?us-ascii?Q?9wCH5rYFaaspdcL1Dpyd1yt+RvHdyz5+bGjrn5y1F8lcvHC7RpIyuiHQJQrG?=
 =?us-ascii?Q?uNQeNmXIm69Dfkfwctw0/f7rbvgSRhkxnfk38J+uLuxJtufuu+emJG68ZvtA?=
 =?us-ascii?Q?m/QVJD5URyOFzZZvFpMhVEm3m4j+hlai4qMHbK3jBZPXfdDW46wLJw1l2LjQ?=
 =?us-ascii?Q?J0ssT6G6zob3BgA81FOnuuiDSjo49ntIRrNSeoFQT2FKw1yo1l/pG3hkPFP5?=
 =?us-ascii?Q?G2i747MKe+1YdRdhK1n715N8WNJpF2rAwAZV/yObqYvywvWUn0XaLdO8E0DR?=
 =?us-ascii?Q?o6/WxXK+73PDnoVg1jNjtrLgIP/e0GRuzzXx0bTPDbOoh8srQ7JfrtfNJG/r?=
 =?us-ascii?Q?GXm2qPKiN6SxNH+YDJquYI0tXfelcHciHq/2nV6/EdEzrUMVtOCGZkXYx64/?=
 =?us-ascii?Q?HwaG03AWaqXOGGHRTQ0m8ZDkK+4SXX1B/Vg+B2WjyfDILcyJseE5qFRMMNGt?=
 =?us-ascii?Q?CMel/6DLKLIahA9PJurIqVJKFqovpTGQMy/q9RzNkGffZWE4FEL97yWXmgEA?=
 =?us-ascii?Q?3IqmtG5b9DISlZmqZviQnswBxZJW76RM5STieDBTvNXqePJlZuIBH77qb+t/?=
 =?us-ascii?Q?lBAi82AX4de0d9Bywl1vphjFh2HTIvfWUQyk7dDbkudG/MNzr1lvFYKfyS2k?=
 =?us-ascii?Q?FxizeoyZUBkZ62BvA3xDLcG8XC34swAbIIIc+1nhp2B2VaSJzNBFLRnkYQ9B?=
 =?us-ascii?Q?JpTqMJo+vJXAttrr9iD9eU6xocw1fTSyIR5ALt1eWjzWCUYddUDGzROo/Rze?=
 =?us-ascii?Q?cban2PInn2KOVDWSfTPmrXD15C06gJ8U/wfofoLFqGG3dAIMDmG+rFt5jWcF?=
 =?us-ascii?Q?Gfd8WQr311UfYtvG7kfY2O8k0yQMwFT5vJXW2073LkhczRDFjL221+/LNfgZ?=
 =?us-ascii?Q?EWINNb/5fQL6mpVq3vZQRX6EZ8nO2E9ks8fhdOv31o9HiFj4wiX8MeC5Hm/0?=
 =?us-ascii?Q?OrrZlt2tFjl5fZWptjZiqH2+UHNDcP771S1AypsKcUJ4CZmrxK5hk9tJ72xG?=
 =?us-ascii?Q?AvRg1G/+maM7LKlby38PzwvPn/xD0IaDY5ff5i3ubAjltM1CRAat9rtrfB0z?=
 =?us-ascii?Q?V+lj8K/wbYy4ZH+MHNJIL6VpDkEXazEgXAMdl7PtS6wqTqSz8dNKGErOkU36?=
X-MS-Exchange-AntiSpam-MessageData-1: QB1oFOjUtk5/g8VScesE6C3uBzJJYx8+Dd4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed105e6-b2ad-4bc3-3f3e-08de941ce61e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:37.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j3CbW2nJAcZ5MRCMmOR8F+XAHUfY2WF6bjH9NW1jF5BnsiItXCty7eXibIDGkVb04wAL/WXlYHr8W6OyoCxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275730-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45B3F3A7496
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

enetc_xdp_xmit() keeps track of 3 numbers:
- num_frames: total length of passed struct xdp_frame **frames array
- xdp_tx_frm_cnt: number of frames successfully sent
- k: index of currently sent frame from array

With "k != xdp_tx_frm_cnt", the intention was to detect an early break
due to an inability to send a frame, and to trigger a TX doorbell
anyway.

However, that doesn't work because every time when the loop breaks,
k and xdp_tx_frm_cnt are mathematically equal.

The correct condition on which we should ring the doorbell is when at
least one frame was sent, and either the caller required us to flush, or
we couldn't enqueue the entire passed array.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ac6cad5605e4..5b97f9e668ba 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1823,7 +1823,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		xdp_tx_frm_cnt++;
 	}
 
-	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
+	if (unlikely(xdp_tx_frm_cnt && ((flags & XDP_XMIT_FLUSH) ||
+					xdp_tx_frm_cnt < num_frames)))
 		enetc_update_tx_ring_tail(tx_ring);
 
 	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
-- 
2.43.0


