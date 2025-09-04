Return-Path: <netdev+bounces-220101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87420B44764
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618E27BAE02
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3880284B33;
	Thu,  4 Sep 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lf4RxyDf"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA2284695;
	Thu,  4 Sep 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018145; cv=fail; b=Tnb7B53SPFT4GoXvh3rWwS/smr5tqXv6EjjiBasShKyMEQFwwwjZ5oa/r8OeAfcGEN4oTbfdGv6dccP9lgpIWSKMfEgFJ92mmrjKT2v0gL0XPddONv5iMN5baFcV50HOJ4e335p5N9vFkSiP2gBQth+k7ErlwOjMFpf7pCdt/z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018145; c=relaxed/simple;
	bh=/6mLLs3w/FLYANdtTBiH+D6YykQhfnZAdrtoo45+Qfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZZZuY/6ixVKdjP3CbXVf8ny+GwPmlhaLdUcpJqHep2waI6jAguAX7m/yr478nRzpehx5Y0/1A/s2/nzhTTwTWnIWMgUuPkDgHmz/81kjrOePpy+Z6bpf1oSwDWDnasx0maTMuwAj2585HeJD1P1dXyYdRb7nie9p3E9iGgPWeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lf4RxyDf; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/HdzA3dHWCGnQipwLwgY2yfLqvTg3Q1Tca7YTiBCIal7qFyIY0Sh38rqqt0Rc+NrsZ6i+R8d+pQQR8Xm96E8Z143cOaOJWV91W15Uf9aB0a1N0T+LaLml4z8gAyifJuf658ZCdibT/fXSXCbFxxt4b3Eb8yiMGvxJdoK5ndW41Sbfc4T8S/VN96UvQiUlVXXB37OzsfpPxmzwpSpBJWdBo/cG2JIGhIWTzFMc4897es1phvacybVzut6lw7AzdFi6zDOMZuUcOMYkUlirw6KPvCamMFgV5II25EIiD+8TdUo91K4LgLqJ5aEzGhwgUKvOF+xsakjzEh7UX2unDKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jzS86fC1OCZFx0txiQ+pSdGiys9VvhEBPdUNrtqDIE=;
 b=GD/GEbB25y2FAmjfV6W8FtSoW/SXjqDbAJS5c8WNJSaY/mH/EBCsuXmPZRggKc3WTvX60KZjTXj29qi/c8Hekc42uZeB5eXyA0M0KtkfWQsWEkr/YskO8ln18uZz2p2ex8jnkLh3RiMMT6jQ0lBm60dqwNoKRVRq3mpenSALIdo1MUg9o7i/Fywp9LRE91Ofg4HCS2TLutrg45Y12SRYEtbwyrmaPWZeD+ky0/O08mVLhVKf5316CufuO1KiI9tL1aboqRAPaFevP5f8ypnSrFUA2JgqE9zBJVTv7KvkfcYjOWHqUS5BjZC29Oaz8UaACXWQvPOeEyzXGqw5BbbSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jzS86fC1OCZFx0txiQ+pSdGiys9VvhEBPdUNrtqDIE=;
 b=lf4RxyDfPBwMRwY7TtUVHVsPhcBSkV+Opjc+IVumsavKoFjMm2tlLIscpHYYc5C4eSrxfNZGQJzbFNlL92jOTi6yVj3kc+EVkL2ZXHk1x5DkOd8X/XdIOiuFBy2J5aDvh+OnABHG8TNgL+GuDQT/E8rbQjybZ2/I6SqZLl/s/F44jLTPVZZ/GH+kIb0Fobv7aTs9up4spxMccjXH79g+2/kULNyVntZAojjPys3sxiozQck9UTNstbxSehBMvTynNQf2IOsxddqd85N/tG0gIJi0b3ZcTzB2AAvtu52Qpqy/FZSH9BPoMk7ou12Pr+HKrdIVM1qaLCnhq1T07PfSBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 20:35:41 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 20:35:40 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5 net-next 1/5] net: fec: use a member variable for maximum buffer size
Date: Thu,  4 Sep 2025 15:34:58 -0500
Message-ID: <20250904203502.403058-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904203502.403058-1-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba49d16-a46e-455c-ca25-08ddebf29d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECLKBjLX1eXR6E+H+B+R12ZpZrBtXVg90D4dP4T3MAIRRheGMo4G8GaMK1sy?=
 =?us-ascii?Q?1w0ykgXETGropztermjEpiTd8TJS1hdi4ZELECJcFXza+aSWmmn9l/fi0UTM?=
 =?us-ascii?Q?zUVJCT6b3bvQRCn5h63d9sAgxtjwnpmjRl1L9be+GbySMaWsWishG/9Q6Pu3?=
 =?us-ascii?Q?by373qIhiysMd7kUvKO2kDL7x1czBWw8uQ8m3lAPQNPJj4rU1q8tHG3+r2x+?=
 =?us-ascii?Q?NtGGxsrKy6bZbi8zUGSzkP4tIjIve7MU6wAw/Jlh45y2gQLDGonSMHVrBv8k?=
 =?us-ascii?Q?v6EASdU7VmxhZAeXOd+nuB2y8g/mY0ZOCBmOcrlqQoM2BXZ3OsQu9X4QfGrS?=
 =?us-ascii?Q?7jvdTcgq8gKFs+89gs/zYLPuWsO04IDDGlmAPrkIAJHKWkHIuSQw8caTQOwo?=
 =?us-ascii?Q?7mwz1nZs+ZSU7s3VGu1WZG9WCmm+ojjnXyIkl1r1rA0sWanyQq3a0KNz0yYa?=
 =?us-ascii?Q?fgjRoUgpU/hkM6kJ128QAqLFokQsBW+7ZOtN9xCLK78k5PvgDFnL2Zck1BQt?=
 =?us-ascii?Q?E//+ae2FsTp/mNyUbaIhfjs+TyUc45VIx5Regc2OqQMthQGEMH9N+FeNwVTP?=
 =?us-ascii?Q?U/N3pZIHOWQ9N7vHa9rKbaq2wAwmi+jjmciVEwaA+/DowMHC9DyYFnneGJ9D?=
 =?us-ascii?Q?he1aPjdJK+JRa8jJfsQRZcPy1EKA88idWifUCZfyUPhbtgeM/nNK9BlcWAxl?=
 =?us-ascii?Q?8F2S/Eu9JSqzfmHHezRPlYbN6mu64/v6K8wpTKCWBjNDF+Um05+hmqR3zEC8?=
 =?us-ascii?Q?gNWmZ7DrI6KF9TTeYR/Tf2uyeouu9oGp3cye5skIS+TyKT109v+8kW0Ienbg?=
 =?us-ascii?Q?PZr4xRZPIQHIbUYuaBGoaASN0r89HCP9t5zxWwVz0W29kaSEMredR2/Cwthl?=
 =?us-ascii?Q?2cvyzEPVcPmhSrO3iBnTvGhMxEtshTiuvz1g6nE5bGo3AhKBFCfzva+JR6dx?=
 =?us-ascii?Q?djAHuUfU8lv/mTFUoZLvvtEYpYHasoMGKX8Kv+1jXHxYehXW4rnZeamEbD+d?=
 =?us-ascii?Q?hpcJQaEkiak+SSO0cpFXu+lrq/BGngvikfb/OuMtYwp7yJKDNqTlFVoc8Bgh?=
 =?us-ascii?Q?kZq6vJCl1zKvDFNGrNDg0dZdvLUb2z/JIQup76R2UenSTDQbfWfQPwVVYuks?=
 =?us-ascii?Q?VFzjohh2KEJo8GIzHg1jDASPyhfDoMFw9zQFlT/MJ+8+ZYmtAFsuqFYEz/0P?=
 =?us-ascii?Q?iUtGh87xqnkAlzH/r/8eAWnXf0RKYbpg3j4qJAEANBo0nSj/qRggHvnZstpO?=
 =?us-ascii?Q?FaEOa0ZoPMKfNMVnNZ/owTvR7q/qEIEy32bAFICTBbzWxnFjy/ZilpVqvMQg?=
 =?us-ascii?Q?nh5thwTUb44RgWIHsS42OHEw46HGBrGPTkv6y/sRPnlTNvidOlQbHeaQFzmH?=
 =?us-ascii?Q?HRuesYVLVoZtHu88UsZSoEMLPdanb0sLQBTAgBrWYUCj0UapUxrx9dtDUiRk?=
 =?us-ascii?Q?LfckTOzpQGbJqjlYZlChBfkdaI0fNATg6ptVrvqjaG/RwhGxFre+M2v93Z+z?=
 =?us-ascii?Q?tBhCDc/vyK+WfZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPp3WdxQyQeF3yqzK72xUoJR1ZRiIba6v20XcUmJHjm9U/SBBYPb4efUVFcV?=
 =?us-ascii?Q?bQSj8kI++0QmfkrS3DyHnjWT4RtGGJDsI2dWs42fOIboP3RRECRXm/a3HFsx?=
 =?us-ascii?Q?SFLgRM1tFVMemsl+AT3G+bGhGRkYlN07pKKcHsH74SwcdaqVEVM0oQRSeDXL?=
 =?us-ascii?Q?y0MysUlHo4n4jPi/CsYijynjfgRnN9yGwSn1WIJptOvkux4gaVJgt4e0PMeY?=
 =?us-ascii?Q?+29QyqTJI0PMYVaBRyRrD8PXbEuK/JhKzmENo44fEAFdMw7fnnhf1LW54ic7?=
 =?us-ascii?Q?8ae8NDUXu64wHPOpcdnI0BmHPaIrE09gIgzIEnOUwgwq2sUQ0F/BZnbEMcSD?=
 =?us-ascii?Q?6M0UP3+zH+7WimjZL1LtljuOQB8OVGnld1cR7+1Iu0Egr8LucFnZ4kpqZ0QH?=
 =?us-ascii?Q?K+Fug0eFt7wkxwUHoqvLx2D3LtVe0ddhzZLAZ5sXqJAmABAIjdMN7LhrfCa1?=
 =?us-ascii?Q?zuROymE5kydoH5tjoJR9ctV/3WQkxwr/O0nEiEvGXge4sjvG1QMo65CtEkql?=
 =?us-ascii?Q?oUI9x6C435z0maGj4xlRspKr2dcUrcG/DUy0bMJE9xzZEOs9GFqCtdAC9yer?=
 =?us-ascii?Q?fGjaRoyrL1SGQ39kiZeF3p9dgZwacfrz72moHl3oRd1m8K0lL0fQjJ4oXsdZ?=
 =?us-ascii?Q?tbA3FS90LRPmnQpQqquPzLXN+kfYfxWkA+hltXIKs7ZthCijLnISsTSMjgaC?=
 =?us-ascii?Q?OtPU/CgLOlQ8LhAxvYN95H6mAW5vPtiPiOGhW0SqaD9fonZJw8olnmhzdhvu?=
 =?us-ascii?Q?sg4k9kBGxSYmdu71zJi8pu1wvTIJJ+wapwkn3vwCWP/n68UeN2XEthnoszvD?=
 =?us-ascii?Q?aHc9wneqoBKDH1L7nrXCA3oejbLQSqvniSbOuZjDUHo+E6DQ3i1xoEtu8th3?=
 =?us-ascii?Q?dY1K9MrHaYWTse0KQ5QKh18QaTCFD3VUQydIhxzGvXX2SciNwmxXPN8vkhvX?=
 =?us-ascii?Q?9kS29inLJbTfdstbzXoXKm8g+BSBfy4xnY/8fP0bFyLPydQZxJ31YAsSxv6M?=
 =?us-ascii?Q?nwMj+RpwSppKmEZtuMnO+FXeMP7U54g5oLF3u1rLWF8p6n4pOBQHZPqd63pY?=
 =?us-ascii?Q?acSamVEZwhAd67zjaNA+Od4ex7gpP92zOsBRZ7MjCzz5Oxt+8KzVjgAgjtHC?=
 =?us-ascii?Q?35MiYOaxkZW3NY9cv/6AX+ARBI5JctbOD10/t3fTd68Pln5V8uN2393ichzl?=
 =?us-ascii?Q?JJE9Pn9oLahNKSZwZaSQAMF91lA2DeKuUc7Ii+6OAph7qVhQHXGPMdODrM92?=
 =?us-ascii?Q?E1NkO6Bri31dig0j1vJX0o18NH8llDYSauc6GpROchdc9vKhLedVAco2f0Ii?=
 =?us-ascii?Q?3EC3zs9U86wnOqBJ1KzOF6z4ArvoesCpFCuYUOwrLO4Gyg8biNXx5Oy31rKd?=
 =?us-ascii?Q?dHVLmOmWesnnJ4/mRC2lhoPTdMALziOBaQVYN53IpmTdvHlxYDqpIhOSirHs?=
 =?us-ascii?Q?U5s14WrPFY3MAbsCPsBjmiuTKAUwcF7EoQWu1YZWtD/bAPQiL3LDiKlOo3RL?=
 =?us-ascii?Q?KwiSp0LD07GCYJJCT18DFqITL0vFWraYEDEPOwi6GUJTs4QcW+xm2rnXuw0a?=
 =?us-ascii?Q?dEYLniqoPd15MpMvAIXC4hSRhWaGkh7CBbPIijqe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba49d16-a46e-455c-ca25-08ddebf29d20
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 20:35:40.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAJYvzG63rdJoLQ5frSakxAHyDu6uxCj3MkMb16rWgvt+Pf5qeNatAPJG8YLLo/dVxWQam6OBR49zuzHH/9tHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

Refactor code to support Jumbo frame functionality by adding a member
variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..2969088dda09 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -619,6 +619,7 @@ struct fec_enet_private {
 
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
+	unsigned int max_buf_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1383918f8a3f..5a21000aca59 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
+#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
 #else
 #define	OPT_FRAME_SIZE	0
 #endif
@@ -1083,7 +1083,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
 
 		/* enable DMA1/2 */
 		if (i)
@@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4559,7 +4559,8 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
 	if (ret)
-- 
2.43.0


