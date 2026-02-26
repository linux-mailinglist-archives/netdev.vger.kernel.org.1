Return-Path: <netdev+bounces-261315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLmmI442oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:03:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF501A587C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5A75300E5CB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146E37BE61;
	Thu, 26 Feb 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hsvujV/N"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F0376BFD;
	Thu, 26 Feb 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107266; cv=fail; b=Ao8U62iB7iX8P/4iZzsPbcTM3LUdlDaMbbCeVJLPhtr8ob/aubBQzu1Bak/TnebKIOtjNpU1SjdKMVc38oHBsMO4dDszWFBsUc7P/SSy8CWzmKzBsCgk2MwhWIVu256TSgfpFXHif3wV8UFmLwrtqbvnlt9mppPl0M/YvW9XhWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107266; c=relaxed/simple;
	bh=uZGg5Vqw+GD7gLOYGugVX6uvLfxMXr7dC8H6hTTwK+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jqfe9uRIOqc3t3cVQMIOkQu0W5nsB0gI1fE5CvGKsppElklhALWJD/qscvVmgjysh2Gl6UhT50Etph96M5t7g8uxEefqjSpt2msHqHF9VOQDQM54KIsL1qnyjNAkUS7cH90+q/U8xu54FlXyp7XZCnXSu7Jp4OuoDIzw+ckvyQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hsvujV/N; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLfsjD8yxxiAYZFPp26Y+QqwzcH0+3g22PZkWazVaPnxni2r+Imc6PknY/MWJl06wyL8DbfD1R03doNVjpP967aLnN6sYB/uUUc+qVZ3LtJHtxjoCww3buVFCtoOQ5Ajn/GMsgM0kmoF3f4gyFcmZBDyYtT7fYdySDXXGqRiZS3Kkt2iTUQMHtcWgkS39SpAScJeWmkgmOCYZ8+O77lPwi+Cxe+ITsPGEDReAXQZZ8hfO0DGX7u8q7F22lQj5IJ56GnctJGSrEOhVNF2Y57GGE4Tff1epso4TAfXYeoPdpftpm00djBO0+t92XxyRet1t/XfqNUxF2S9Mf6P/sl3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZGg5Vqw+GD7gLOYGugVX6uvLfxMXr7dC8H6hTTwK+Q=;
 b=P3sAaz8D1/sG5ohSIbsrUCOx79nNmDXXc5UFqWLOgPgkFops/HN+vOrDvuw1VD4ThU+Hll5o7bpwKbwxpM0jl4EvNDWcXCF9CeGii6SnkLtTBze9wy342yzT7WRf9rGa+BA3q6JuksaalGGgJdUyA2+5ula0RWPPfuscy4SGhyMBntiml1/QDCWq+pymkBjfPgbF0v2w1EmLjR/IPwpEsOJBdyv0BFHv/KW8fg2Q5U7iNphKCoLWRN96znglP53UskvREylN6aKT996r1e7g+HWhNLiQdaXIGVgYZtUvrxvnfe0az337QqWXwBsn5rN/L/k0jNoRgULWFaR8jZCwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZGg5Vqw+GD7gLOYGugVX6uvLfxMXr7dC8H6hTTwK+Q=;
 b=hsvujV/NV9g9DJ8jwWaoddWQyXcjFZDwxWehMIdklIBA5pF7ohu/PjVE9PCxxf8lT4mI/yPFhnxaL/BgcUU8mcXCklfWIwp6GC/Vv0/etRgSwRMNYXpdvYLrLGunZf+X9SXjG2TDVdevU9+p+4tF/tksMENmn4D6guBH0cGWJOM05rVuMar7vVRRbMCFOPPGd09sNHAQIR3fOoGX5X66BQP2m5laepOEdW63cYxrjhQX1g0ud3a5/1d6BDU9vGBZyJIw4GgxSXhpXKbfhgzZ5wrjiTRsRRJjSO+joZqInS5t56aNL2srusthZjhj3XVOO2qwt17VtCPD8FIroGmhEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 12:01:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 12:01:01 +0000
Date: Thu, 26 Feb 2026 14:00:58 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
Message-ID: <20260226120058.asjmbucwwwfiqcuz@skbuf>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223163227.y3yzzpncyf5a7klq@skbuf>
X-ClientProxiedBy: BEXP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::27)
 To AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DUZPR04MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af2f594-39da-4627-3683-08de752eb5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	DMPmhksAbRLq7T1ndSQQqgFj7Ee6pqAr9H9Xa5kfTfjRzFl90dOJZ69JxUdibtwgBcKdREuhLj8rLXAl5g5l1UvdaG4W7yCI6Ln1g8/qb1zZiZYzaMM/RBiE0fv3eSAoL4UOaZu/RRK908Kt7aHDZ0DCNKZgOkl7BTVZfIoLkq4zTv1IfoxZwa3MUvRxsKUSoA5QExAFOShaRpfTvLOTOATH+eL5sbZwq5syVe2NnfY23gtMmwpecZrLIj+z2bMHYqusBQgLaRcrd/dzeincrSl523S0rqRSYf82UhavBE8NlK+OH4M1V5BSWEtNXlciYYfaZ/87XMrfZW22v2E/M8x8YATreVffdlhUoL/e7P4h1SO1VQZ6RbO/cC4q83+LQfzdiPRppG4TcEwcRADi2GxWak1SxVKifwlRzWlku08xlkRXmI9M0DvmCcvufBSmXVf0DGQIbeR8bUaj0a29dxPaClDRzJI8BZraASJmcmT8OlL6Anzc9Nd3Xf/5baQ2vjEP1z3C8LTcFdAIOpFn1WpwxOyhJkgqgXmy1RM9jw3DWF7NDFcKQOGNpT0ZLGqEUaZffw7q2GMzR3xTb11gkAdcdSEwj9hHWeD+JX65vGvsROmlqi9eQOgWY1WWl/IzyyuZtiW+/PipowSbfBcLvPJyosgY0jxO7QYWkCUpAByHE5+So2vlxQVUYW79xnYeo5oqxVFFRt0chsY0ABuK97kCrW7Oz/gkznMqwAGZgec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Zm/FuaMd7KMfXNTj8DWQdctwZiMjdWNedeS49cdpaH6HW1ZQxrKXcy7LX3R?=
 =?us-ascii?Q?oswJ8KGP3ACsuIsBVVSRbLfNehJ+PR9jQx73or7gARTV79G72UaAd2XG0ABA?=
 =?us-ascii?Q?sCLDc904u/GMe0zv0Zsgjkg0YLEj9Fp7g9bT8Y4t+qtdHYkl59z2uZZKcy98?=
 =?us-ascii?Q?2m31OajvSXpBMAqgH5e4Ma7ptfrGkJ51OXeqXPFT+Y9McJbAoXYCGFHeO/W2?=
 =?us-ascii?Q?5J/53ixuCDRz02GzLJH3o9O0OU3hpFLn9ewZ0yHPfe1UaWRNG8eeSPnNz5M5?=
 =?us-ascii?Q?FvIfouUVTHXQVHpHPbi85uHCp2HfEJkzqOhO7vsQNj8rYm1MdIYtAleJeWeM?=
 =?us-ascii?Q?PI/vFXFDLT/hwZl1oIfAbL6qPrNrgwylywxRepXg3pW9I5SY9blZdp5AdSVw?=
 =?us-ascii?Q?MNyAS0VDOG4prl42KWv5SSjQztSeQiNO5XJj9owJZEQLn1eMVcRLoCtOsKpR?=
 =?us-ascii?Q?8/SEYDxPAZSHxpceYn2d8Vt/3D11x+1EZEJdSm01Ux1jcf+BCyQ1DCDp7ntR?=
 =?us-ascii?Q?HRaoTu3dt+SOG2sPIWTgAVVyZVDsPlDuCWkA84RF12Bwq5s+GPxp9mBvcBe2?=
 =?us-ascii?Q?yYvmSSDTCOC4FPfh5qjAqGWrhcwO4R/FZ7b+oEUN6m/cEHqwZx5QN5IKFGqa?=
 =?us-ascii?Q?dwKUOYuKIBkxz5vblmy/nYQW3G0bp+Htadq9LFP0/EOjQew/H9lU76wEPlcs?=
 =?us-ascii?Q?zC5isiF77i++pjXfthivgbUJYNMG/LkrNzeEO3/yXwfbksTBsne6UafO5LLN?=
 =?us-ascii?Q?87KeufJo3bm6VE/X6kDfEK3KRWeE1XqJA00eqFl4xKBFY6oKT1KYEiGBQPyw?=
 =?us-ascii?Q?fsbaDDguYCcdYsB1W9jQVWiE2PM4U8+TOU1H/ksn3pEe3+kUm2eUaHxLd81p?=
 =?us-ascii?Q?pz0R+s+jFe2euvSIT6ZZhxLxTQruDt6Yip30N9dcuXO+dyvAb3gVG746t2Ye?=
 =?us-ascii?Q?acHKTyFI4hx9P30nDMsB+yYOEhe7l+T/0EF9zk6uvXXh2/Nggudnm3H8yKEG?=
 =?us-ascii?Q?/VaFPXWV5XnkYT5VQ/+jYiBg1O/HuwwEfjfDxhccOx0ZhfFZG85VQMMNjB+l?=
 =?us-ascii?Q?sNBEs2WL4I7y/BBdsChTr+YW9niicr1MFYdeHVzD39t+M2quYJ/3Yy7MNebG?=
 =?us-ascii?Q?wiMIuaOJ3D9NmftuJ0rXXk7lsQfFcz+Q0ZUb883yUMm5tqdME6JDl44xJHD0?=
 =?us-ascii?Q?cQNM0RBmABqYNJMLGzaXwNtZ1oX3hTSRvOOi/z16w8NpvBYP5lrDggUfJD+u?=
 =?us-ascii?Q?PwMCsdj/ChFeW1F3plEEH1Y5M4LDgCZnXIL9GZhRPX5u0BbbdiYoST5iRSS/?=
 =?us-ascii?Q?sUxxyigqvGDLkHQCmHu4fTSeMtizBAFiDXhuRppRgJnXZHt0l7YYaRoMxul8?=
 =?us-ascii?Q?jOA9T+G3khuAYCh4/QNmdaZ4H1TSwIhTtFK1ZT8t9OkzmxNxKlIYA8EZJPyo?=
 =?us-ascii?Q?5slSni3MTv67zoTPzlhPxA1ucruxwV61oDDMHAhUsPnraRaXkBt2O6d4ah14?=
 =?us-ascii?Q?LRCMFUwDHmllvf+3/yAL3eDEw6CDJzukrmIHYk2iyFowifsse/y4PeDeWYyz?=
 =?us-ascii?Q?QY2Kir7SZjU+Hv5C//gpXUPPbWD/zYTHelIS5G5RUfAkZP/oRIyrMPQsPUMz?=
 =?us-ascii?Q?4FOzVizsewo8B0WqJ0z9edXRSrWDeFvgmXJEdfscWL2pe0HbRCMMS4JgmQdd?=
 =?us-ascii?Q?DMDPLFMgpA6jhUJDzYL+T9U1WCGdQxbeX151JqQQ6oXKfzfSYo+HeeUGeHe0?=
 =?us-ascii?Q?OYw9mH8ymyrYHMMQqUO5zJmTFdf+ITUPENYFartPNs5aUEEvxi0h2GsVeSYf?=
X-MS-Exchange-AntiSpam-MessageData-1: ikIxSMws7iKbWnu8QjwEKCIjCPm7aYKi/cc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af2f594-39da-4627-3683-08de752eb5c7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:01:01.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBg1IoF39n3BaVgSVpti0BU3qTOXYQttADxisWdWgL7oSNzgRWAymqno8o2omO1NNzDVcUT8tnU1+SIktyDguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261315-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 0EF501A587C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:32:27PM +0200, Vladimir Oltean wrote:
> I am not sure whether your interpretation of the documentation is
> correct. I have asked a colleague familiar with the hardware design and
> will come back when I am 100% sure.

I got confirmation that clearing ring interrupts through the
SITXIDR/SIRXIDR registers is fine, which is contrary to the main claim
of this patch.

