Return-Path: <netdev+bounces-256134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB2YE0SIgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:31:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB923D4BBB
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6251A3075FA2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC0367F55;
	Tue,  3 Feb 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dfYz+ZcX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E0366052;
	Tue,  3 Feb 2026 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096174; cv=fail; b=GGcnzsdcUCcne4/ncPHS0kFJykd+Ai405mMtHEvlW1dpRYYDZeZLCBu14X4OMHrBBkwqyLsrbEJ/xxKoM6/7ErXW3jkIzMCHLS/v8gRwUefY4EeuONXw+t3sTQSB3WgN1px4WciB7IPyLwus8eY910QSMrFOMSJhuYyRSE8akxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096174; c=relaxed/simple;
	bh=QxGbeGE3uYdSkjSyf7NiV0lwRJf2wKyVWjiEgLXJ3H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZrfrg7ASUeQBiH/37e/r84Ptrsyw09O4hOu0VyrWIYYg00NZxPOuTXvoq+QgM3m2xrVwa7TrHgPlvwIljbHoazuuEoG0KpcBLL85WveKepqD0fmZAj2eLM0cpDyJl6LKcUhJQLEExPZ0OzZJ3OnAZ1TqgSC2eKTvL+k1BcYWU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dfYz+ZcX; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my5tx0Escn9AlIXy+HTq5EnEdJmZW+u9e1OPDMKJT+9NFn2TODaKaWKi3TKUd+SXMailtTdI7VDbb5OLiTRnIVjOhfCbQJJRZT8NZVtUXfExRbukt1LQd1rqJtuyhwE5KgOZAo1aXJlhi9ruoOFMrSCSaM41e1rqgQvOLcUxyzBd+57hR+BAqesp57BhYuj2sVSpmp0+Prm1WNay6MHfSRT/dUraYRRQ7+Adu2lgLsCJL1M3af4fl5j6WVejswsp05akKv582Ltb8dI95tkL31ZGfpsUqI36nxU3c7bcd5FjpIhQj3RVGAoTjO3VQSHgL8YDug3eOxb56NtTvt0snQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i06pN5Wd81tqBS4Cc7V+wH0VyHNNhcXXaL9k8LMWnDQ=;
 b=MzCRpbSAwETMxaLpY9YTxQNnKCTvSrxs0qnTsSVI5XxlL9svjj1dwmzGjSuW73R7EGYvRFipPt6FHfdai02kMv3qVUCd8ulQBBDgF5RV2YazaMETzWsIUUjvYfZdbnM3h3Xz5wQSwFCdeix+pI3fMZ2YjQr1Iw4MapgEOqucGjhGK61odPryvM15ILfuF5k4zuihrUxhnN/n8ai8GhWjnnXyZSQv0FeNOo1JtU/uftkwl3QTpnliMDPiHfKkSjxht75GKNHBjegIotByxteWBfkVjKc06/5go2nqDu3LXCvsh9pNkF8MfovfxZ7wpZzOxnX1A1cRTkxwPsZM98FWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i06pN5Wd81tqBS4Cc7V+wH0VyHNNhcXXaL9k8LMWnDQ=;
 b=dfYz+ZcXm0SJ/HMRiKGE1PuHZhFE2rDX7goKNQpZCu9eP6RHKlT85Cv0KBFvyUHeZIM1YMWM+hrf+7XfupGd7frNy93/kpan55tsq3T+YLcckR7hfH8K7KjUg4l4uzUUEo3GvTZIohtLPdWaevCxr/g9JWBFxCLqTLRNduP6I2AeqISfJk/rAanNl+FulvqaHJiOwGx24EVO5hxGBm8gYpzgsTosy6DVXMRTzayIuE6kYKepOqHihRAdXA+SfT/mSk93QCA0ZVxFycJamV3JHU8K15Y8u1ETKUkW3hgJRpP1QpKPAfFhXCLk+EbEqWFI/QCSm2mNrmFe4g2SHAgaCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 07/15] net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
Date: Tue,  3 Feb 2026 13:23:21 +0800
Message-Id: <20260203052329.1085444-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 538f5074-32de-4642-fab6-08de62e445fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iL0uc1U/1b1wbW1vEy7z4zD/zDX0xIDNzQxjJlV7ceQpq9rwB52ID1LzZ3vt?=
 =?us-ascii?Q?eSEbBcnz8O75QNyZcnpovDuL5SXe0F5h2aiiv/XVe43XYpGZ2uNohMtmkBCt?=
 =?us-ascii?Q?oXqDZQ2azVxvOb/7dBZ3x5ogmZcSN+Y0aCJXrDE8gEX77Be+m6NFGjpQdk3d?=
 =?us-ascii?Q?4CgOiNiFBU4V/t9lU5fmcqwaD+WzWiH1zKP4fcJzbXmENY+GJZ48msbl0IG4?=
 =?us-ascii?Q?wmjSDD71UIubg3w420EDtelwr3YH8cc7pEuFKUMMxbVD40UkvOTd4hUx1yfJ?=
 =?us-ascii?Q?SAy+7I1KkzxHW2pS1WNIWgLX4+gRk/siIVkKbxLahvpzHT3ciYZdmdBkyxUe?=
 =?us-ascii?Q?CNmrvDHgX/gbZ23wDKS5NZZ56w9n5xr0ZuHIUTmTQea0bV5LGReDC2fBqIiB?=
 =?us-ascii?Q?jfl9hkhnCN6tyn18aYXh+xkf61TBYPXMVc+bKmLlMNnLG83DSazMVLZ8l7eI?=
 =?us-ascii?Q?glzjCM1yc7mbYqoRG8UDi4G1d9acC43hOrF478Ya5uF9UlZuO9P9LEvZ0YdJ?=
 =?us-ascii?Q?DFmjoc7sD3DqpD0Crl7s9yCltyMojXGuz0EMDUKYlIm3U3yfQVrcMPlBGmxW?=
 =?us-ascii?Q?R2DMz/gTbQ8Rlnf/LgTgz5oEu4I+bQ0OKGYc0VCBAVo705Bqs+V+PUpJfMv9?=
 =?us-ascii?Q?azQeBuQNx72wWWTk22FdxsBuXLyPmx2fr3jMjDZgj8X4lXQZne/yqeiaxfuA?=
 =?us-ascii?Q?Ca01/jc/DB4+mBF/wIap2SmcyJRnSLOpTaR3ybPd8jD2lo/92XastoME26iV?=
 =?us-ascii?Q?UFOpKQsjBG2Y0P/IbHW7NITlT6g/2QqDD7JoMdFtw/VCxoCTGFmaau9rILg2?=
 =?us-ascii?Q?GEIqlRmRar6/3jD1FOJpnmtTaKkocOJfReZOmPrjotd32w33zbJLDo9NL5lw?=
 =?us-ascii?Q?Quu30W0p9vX0Tk30HpDgoCGiMhI3TnZDYUxn6eciQWVT9nRsnaTKFY5mgkTb?=
 =?us-ascii?Q?81/CDfQ9wlnLG0jGtrodrQx9PyVNK+gzyWHD1UpRqZDQsS/RaGWcme6AdR++?=
 =?us-ascii?Q?qq1OnnB1STnCWMxaq1I92E12sped2aSm7jrR/PIM7boiKp456pB3gg6LYiv4?=
 =?us-ascii?Q?wPjjSnCKeXRubM83xtvxmM4nfNXMllZDay7HcfzOD7WnpewjUbR5bYipPrO/?=
 =?us-ascii?Q?GMzzn1u0WvFpKz+I53NZJ79JzWl0EhF9Nx3l9ow75XnXSUTtAx43+BMhxVA4?=
 =?us-ascii?Q?qcpX2TZtwS/wKSIpz5IyaIuPiqBIAbhEutkfmPqtQjgRaGO9T6DVAgEkIlsk?=
 =?us-ascii?Q?PsyJWee8OjG+yBhhwDbAUxzz8wskoxF4Su6kuA0XlSf22oWkI7JQSFnnYJep?=
 =?us-ascii?Q?W2RDDDY/kU7sHo2SBkLv7i9iXmqaKeftIs/NKsuy/yoG+VRXXmQbeVG1Aj2n?=
 =?us-ascii?Q?nLvzxXofOa5nmpq6zdtS2z95neaRfESD3DZ6BQfoMP49WfsYHHgsvpeaqqYX?=
 =?us-ascii?Q?VFRFHtOg8WsgmkePt3CbVTX4S9x3vrjvKOUSJTdLLXvIQqNl2W+0tkiRpeIX?=
 =?us-ascii?Q?uznzlg816agpvif2szZQ5sPJUqvBn9iQXVlwaJBj3IcJZnLcb/aI/UmCUVvy?=
 =?us-ascii?Q?flogUQnhOdO5ohmbaC9xHjEPF+c0jXVvqVabRcJ2/U3B3j4vriSGESVFOlyP?=
 =?us-ascii?Q?SeYq6xtucjhLCn1pkQitNPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nXEs+Jpj+qPLu9jdqpSkIi7nY77v7/20z/BKH9c+sLb6NIUy4go1zGWHro7?=
 =?us-ascii?Q?ePBUswNgWww/yU9xMM0VJh2Xdt8snB3CH1eMMldYGXD/i45oryF/+2MKN9OG?=
 =?us-ascii?Q?cMC/yfKo8qZaXhser1q5gq+Faqc23qpLpJlcQiohzUjlY1nFWCNaf/5qXz05?=
 =?us-ascii?Q?g02XRki3o5PfcfppdKg8UBAg4JsWLIXL6MKYv4yGE8ymdNM6Pftf/zvVXt7y?=
 =?us-ascii?Q?YhrMXlSALbwSnIp1ltTkX8MLO3db7KYau3fX3u1Dh5WeZAzL6cwZoDfe94lS?=
 =?us-ascii?Q?FSjtk81WVXi4lu0Fgv6JLR5fOLeuRzOgaqUAeAFz2m0eIW2CXheAlTT+aAEW?=
 =?us-ascii?Q?OnpA2x4w2zqXWkacXYa9hyC19LxFcEBPyneLs5KTTcr3NwJToppPEkAPcEEX?=
 =?us-ascii?Q?URU+Ln31KAMIIOb1cj2Nntu++ycfUzDLYQnhe6E1PJZJ5YuPLLKAFle5Z6ZI?=
 =?us-ascii?Q?i9tIuopAiwfxAqz+ufVGgq2Yw3lH7aQEakojgXBaLHv9w0FAMGXPx3rVCLhs?=
 =?us-ascii?Q?C5FUzMwpIrnIKnfEWY+qY49BUHfaMXosGIUja2Z2s+JJ/7RpVC5fFm4I4hRe?=
 =?us-ascii?Q?4c1QHX5zDPd8c2ZSiBu+dvIsnT9WReGteGDeNA96QVrN6cjF9Vl/oSxOp6w0?=
 =?us-ascii?Q?nq9zve2a3Krv2WkshFffYRDf+edVN0uTOujBM5uC2LEDF4/OAgH9IYoPSYmU?=
 =?us-ascii?Q?yJ1NgsSm6+XRMYc25a7z9iSlwDGwhcqQzXxc3HSGyHzzjohO2Dxd7pUfNpim?=
 =?us-ascii?Q?PVw3JrltbFZ1l+Vsv+4sZmBBUTwq3FGdtzwcSz3mdlX9wqVRmOBjwXFMLqXN?=
 =?us-ascii?Q?VSNP4VBxb4IXhXgsMKIngU9wVhlrjnrH0YAK4ypTYHe/k6lratGn7Nw0P0TP?=
 =?us-ascii?Q?N+XWkTEtirfLqUheNEdq9XCs9aGkwX7DGXp4ipulVRXfSRwHBaVyBHzzZUkF?=
 =?us-ascii?Q?zuysGBsl8M8QcloiD7ZPgfDnoWmmPuQGKhOjWhA2gZskZbU5pCzmsusgPDsc?=
 =?us-ascii?Q?RF1RVxjKlArqSDYmyr6zqwo64eVxrhGITpNVVCydqBQg0BYMNrDr4wz0z+X/?=
 =?us-ascii?Q?Rrzq6sjFl/5odP1G5gWZPQ3l4GFF3foumEOIE3UkeZAPW8RyEXx0vCvnK4LA?=
 =?us-ascii?Q?NDeHt82vl3mnsR15dPZk3gGmc+38rI2AI0JJILE2lp9PkcCgw+dDmMfbNUmq?=
 =?us-ascii?Q?blQ/xzoV39Ro0TE2bxxNneAeNFpl6S7vVVW2gHCwuTSSY48H3dhwXoSItF+q?=
 =?us-ascii?Q?p5AbQMJ/nIJ0uT8h0jmg4qtJlc4ljnJ+J31kS0lP4Qd55eJk4P4p5kJ9qxHu?=
 =?us-ascii?Q?rMs2SSk0MaUBrYaTEh2V0rbRs7SrOMtlmflpIQrnbT3anZ5K3lGT8mZyA7e2?=
 =?us-ascii?Q?8tSEw56m5mNlbRGa09zjjcjoLg6BzMwdHCyeesrbHAY+Qo9tzMMhsNA9sX7f?=
 =?us-ascii?Q?lFsDtDTtgjgyhUxAXAXSmdYp8j14nY6yK/EyU/RhaGoMytucnVHAuSWk97is?=
 =?us-ascii?Q?B5jUFAY4UV6BTUGRpYw61kCBkQUhZLEXFjnlhadMJTwfSF3q9zYUEs29+X2Q?=
 =?us-ascii?Q?hRPwA07xl01JGOM5U//Zyc98MhpAtdfx/aDg3K3QogXJp0KnNqrCgUmp/fDP?=
 =?us-ascii?Q?DokRkvfMd50F0OQdAOg/7FyE2EoHRbXWgCbOub9sZIhZUrRKox0In7aRaeLz?=
 =?us-ascii?Q?At1xTNA+6TAo6Ygw/Do4vp+hM/txhqXDR1lPHlgd0A2hpAKX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538f5074-32de-4642-fab6-08de62e445fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:50.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L0C4B1pHQotmiPyzXrPhEYPj23yjlRmRXwx/lwrzLR2jkbwasKiMBsJxkBDwHS4A3nELZO1Kh7Qvdk4eOn75A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256134-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB923D4BBB
X-Rspamd-Action: no action

Remove fec_enet_xdp_get_tx_queue() from fec_enet_xdp_tx_xmit() and add
the tx_qid parameter to it. Then, calculate the TX queue ID for XDP_TX
frames in fec_enet_rx_queue_xdp(). This way, the TX queue ID only needs
to be calculated once for XDP_TX frames during each NAPI polling. And
since the number of RX queues and TX queues in FEC is generally equal,
the RX queue ID can be directly used as the TX queue ID. In exceptional
cases, fec_enet_xdp_get_tx_queue() is used to calculate the TX queue ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 38 +++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index aafde4378f65..0c1806a46fcd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1890,6 +1890,15 @@ static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
 	page_pool_put_page(rxq->page_pool, page, sync, true);
 }
 
+static int
+fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
+{
+	if (unlikely(index < 0))
+		return 0;
+
+	return (index % fep->num_tx_queues);
+}
+
 static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				 int budget, struct bpf_prog *prog)
 {
@@ -1903,6 +1912,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	struct sk_buff *skb;
 	u16 status, pkt_len;
 	struct xdp_buff xdp;
+	int tx_qid = queue;
 	struct page *page;
 	u32 xdp_res = 0;
 	dma_addr_t dma;
@@ -1917,6 +1927,9 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	flush_cache_all();
 #endif
 
+	if (unlikely(tx_qid >= fep->num_tx_queues))
+		tx_qid = fec_enet_xdp_get_tx_queue(fep, cpu);
+
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1988,7 +2001,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 			break;
 		case XDP_TX:
 			rxq->stats[RX_XDP_TX]++;
-			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
 			if (unlikely(err)) {
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
@@ -3938,15 +3951,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
-static int
-fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
-{
-	if (unlikely(index < 0))
-		return 0;
-
-	return (index % fep->num_tx_queues);
-}
-
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
 				   void *frame, u32 dma_sync_len,
@@ -4040,15 +4044,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len)
+				u32 dma_sync_len, int queue)
 {
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int queue, ret;
-
-	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
-	txq = fep->tx_queue[queue];
-	nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	int ret;
 
 	__netif_tx_lock(nq, cpu);
 
-- 
2.34.1


