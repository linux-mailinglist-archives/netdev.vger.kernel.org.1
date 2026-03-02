Return-Path: <netdev+bounces-262642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPjkK5uJpWmWDQYAu9opvQ
	(envelope-from <netdev+bounces-262642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151551D9505
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445B430CE847
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE33AE6E9;
	Mon,  2 Mar 2026 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CNlCeKv4"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3729E114;
	Mon,  2 Mar 2026 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455886; cv=fail; b=Pw7l+2+j4wLmT3e9yVyR+9dxvVXGV1fmrwu6xtmN+ueSJoysmpHU6+uGlm9+WifqJEEEuk6AWkNSr6CbL4czi+hdp839walBElcetTVt8Vp1S+jd7kdXjgiIAP9l9LwavZK4IqegApSYALpovV9X2WOenvny5RZNN81FfIbydQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455886; c=relaxed/simple;
	bh=n3F4ahQCuOa3MHK8a7KC0DKKLcSPzYgQ7uyQ1MX2mWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECFiWI19zOno0eGfe3fEFk/8qbghSr5UkUFEs8fc8b/VyJjCwcCsDNEg2EKwN/oac5hkICr7HxV7m8v5X7gSiy2JxbdaM2m5Wn3CbNt4LL/vJii8FReCfx7rjZ8B2mKGEyGzS55XBBaYsXUzguIO5RpKS9AYs30d2BD/5Iz2l28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CNlCeKv4; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPRC9YLFgxawIvFfwrONX5tCUudlrHrEyVafjYApNtrdX9VoXZ/xfg5+j+mbROV1aeTlszUSnHEnSqAEgJJGhCYI6vo4ZlZzXbmUoMaDVtTwSVKhGvi9kYkLsVMb57G9HhZsy6DMNdklwpPu2Q+vCDnEcUflUE2hScqHl0uB5giV8jN8b3gXmiZIvG2LH/xoOPgsbTD8EkJ2sYd7ncqa9sExB0KMiklrGyi+1O8yFtC1zQrvCH+TmW0S/ZeGBQJKyLO3IqbDJbIyvZ3bIfQ8Gax4xW9o4dMyvs/VdjZiTzy1ts2ftQMypzi/LtnQGvD5Uc7W660YyRa0T9U6BMsXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU657/auD/wOwSFVxHx7lV8Cyin1uEqH+BUuEcnSK4w=;
 b=BcsV3OO4uW40VIYc0YXUP0snAOh2H8utJmFXGZ9YBirjr21hvxTkx7ndqJDNzeLrUxnY8L8J+UcB3aFYgXZ4/tzSQGiVlHZwbCxqg8hleAtYGo9aeyWw2i0/HRwrtBQRQkuXLYnOp5Efsqhpid01i/v9xKXJVEp9/a6vF7CqGKTRLivO3yT6gpydPoYaM4jfxuRAEqNWixwfR2745y6eiLCqGiOtTl6QM0/Hovf7Cf9UkNqbxRKj1ucyeWGJQt5PYwWtJcQHXi9GdsHHOEOMH8lPfcIuFgvRa846gc3etzNBfM2SdwciKiIYHZqa7I3fNP6bjo1WhgXid4mSW/jr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU657/auD/wOwSFVxHx7lV8Cyin1uEqH+BUuEcnSK4w=;
 b=CNlCeKv4hLpM+sKflRicICCJ9KmAiymjvSCle2lXHyhAWvgANz0AsgTYwBqty1pj+ZhkVaAw0hG30gLh/RbH3yuaxSsK8gzD0dhmLiaLqhuFDctu0ymZGULHzNnM6FrqETZJGowqkG8ky50PS8ci6WV51vnlGWm9XbtKSLw9MXoq1N6JHyMQzti2uVYhbmUnceAvbKQEQQrhgeCICEBZos5zWAkF3JSGmBnn18OGJ/NmJIGldYw11prL/qnKiwIFqhyzttKgt0rb+omG9Nd/D0hO6tRrxqeJs6QsBLduHxCJnpx7qEq24ILRQ1ZSUKpa2yYri1vjIYt7ZK70nRWBsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PA1PR04MB10625.eurprd04.prod.outlook.com (2603:10a6:102:48a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 12:51:22 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 12:51:21 +0000
Date: Mon, 2 Mar 2026 14:51:17 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: dpaa2-mac: retrieve MAC statistics in
 one firmware command
Message-ID: <zjs7bsdqnapyd7hbuzqop57mhtxlv4r47rks7atmujxuffozdo@c5hvi6cgpzs5>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-3-ioana.ciornei@nxp.com>
 <aaRktVdeVUubxBLc@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaRktVdeVUubxBLc@horms.kernel.org>
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PA1PR04MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: 045479c5-7fd6-4624-2f84-08de785a675b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	l9XkzBy7SBMhagYW5e/2dP0Ed0cKw20Ea4dMxDNOoYUXHuxXU09OyetrK8XHzZwFJF65Q6fzp0+O/rUWuc4UFbg1/jfloxLnEXSAeVqg3W6va5yFc5nbZFM830jLDQFNUzFtAZpxKruwB/ryySNpTYxP27KecU8+Ot9XZ0v+TaQiO4SRpWxSQvRIAeQ0Da1gnkTE45ibTdJownPgpy3RBSNwLsbFwrXf6IiptbuB9sRrCwXnhBNlteQoIL7tQZJClKadcstV/euVs9bsmY8XTUd4NjKov+2ijYnornQZShpOv+faW+vuBuo7VzYlH9x0sTpPblfyxQm5DpNXBm0R59CtKDdi655VegZ5/RIe2Nd1ETabELEiSanoMpWy8uJF1MFQC62jzlhwdqXD5R90pGQmsexECTJPyFAa18hvGgZPPHxOasUVknTyqlEBHaTjNHpTdQgDjZkDG77t5jvWRPe6gHEOPBZ91/v6j8GwX5/DWbRrWKvSQ6/VGPYwzsRCVLc4W5sc7MXP3YqCa7F6r7Ey+UprpXLQUbkvZsDtPY4HxlrUtz65o1pPTpXomAPC5IT2esk7wA4VhR+gSn/yLSTAuuGH7YWlNvHxisXsc460wi/XZdx/Fl8bv0hEsMMagHVvFDYIcz/GtHsfco5yditxOlwagxqWLrh/ovmJirv3FuK7ldXMhsZ+byWovMv5/v/pZglXh4XRvpRnaL40LhaHUiNSPAKAWbhFsit25wc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BaGhmxatfJC3/0tYFc85fLawehhiUd8FSSAvLg5VmTldse79e+pTEinJi8Hu?=
 =?us-ascii?Q?dTpdljZo1nvDU2nUtqMmSH5xLRPpKwVDZFHWqsCH335BEGIWzPLH4MFbeJrl?=
 =?us-ascii?Q?dEFPGNN2Jqugn7lXBimHBex9Ktz0dgL7ipp47kq4uRmTeexxKcoJfHYwW3Sh?=
 =?us-ascii?Q?3ujR4cRV/9jvYGBXKxpPP2Nb11m0nXmsLYHj+sizW9OOgsxI0DghzvL0YmkZ?=
 =?us-ascii?Q?gH1qcUfdaswzGF1wcI2BkG9q801B28HqO12FzDTSChSnQ5OYyUFFNn7B/ISB?=
 =?us-ascii?Q?IbkNWHPX0yWw4CrpEiff+7Z/8O+h8DaB5M4o7qbHy/liG1tq7DoIx9E9ui/i?=
 =?us-ascii?Q?4P5xsEDZwbhuizthyK2bim3i1HpX36fBnwQROYHXUvYekfKwExw0z0dEM728?=
 =?us-ascii?Q?GuXX5AKQ5jues+KhOhiErp95Ug2JBhH/gSQupgSwf6fXd/ukjj5hqnckPCxq?=
 =?us-ascii?Q?PoFFFMUo8YkhG9lgWKhrl5/6/8ldD/I4clGORsHQqaWyFT3V/gRFam34XHmO?=
 =?us-ascii?Q?dtR/SuzNAKQOujJP5GGcekM++CUJnKnGbCLUCAGcFvUXIBpCgZUfIZQn6Ubz?=
 =?us-ascii?Q?U5IsojmTJunzYP8bablZILjvN7P00hLIfmYFYpEFfFwqlLk4zucxuK1RtT9R?=
 =?us-ascii?Q?gH9Srr0JozPtzLK72zVT+2dHWOCElCgLZoPgvjFav5+J8+DdQAtH1BIXGLwO?=
 =?us-ascii?Q?w6zepI1CFIYlvxNxC7rxChgbStcwtTRJBwwr2YW2P1Z7Fv8eDY951r8UnB0W?=
 =?us-ascii?Q?IGqmzF13E5tKHG0d42/wQfhFITIZUIa1A/qOx/Cs4VeLdBRxmZE4P3HW/Ant?=
 =?us-ascii?Q?K8MuVjVAjFvNFe1PGN52zKrn5DFVFr6KDuWxEgYGLgHADUCwLl3ZAoDfyWDr?=
 =?us-ascii?Q?g/ARUHpa76SY0ln43xdsiZfWpu+n3iwUItEaD7rbkqtslhPojDIvaYqpGq6L?=
 =?us-ascii?Q?LvPUcf1CAaevO2FNwZha1mkL3Ddt11MY8HgsiWrB4Bf9pFVLpvV00jVwMq7+?=
 =?us-ascii?Q?T/1ey/lVf/hspIj6lBs6h91lS/KmN41q9ZoxDFh2vTqC/6XYS1UbPFB/25HH?=
 =?us-ascii?Q?rZqKaA7ZUNnljgLRLvJrXMF3o2xsgDlgpjV+2eJDPKJW0iRqfJcsM6osqCrZ?=
 =?us-ascii?Q?rP8sqSHo85zQ5m9wTS5i9/yGOzzoUqp7P36Cgid78npWXugRb7r7T1ioPPDf?=
 =?us-ascii?Q?j7KP4ceH/Oiz4qXVG6db/qME4oKZ3pYMeq+tfMY/36tzJq+Fzeiu9brb9lTW?=
 =?us-ascii?Q?vgWQ3XGhKs9+lKs8Dqa2jDr/7mIq2sqNojQpckWRrzUAdDynhDxu7IOp1n8o?=
 =?us-ascii?Q?y2U554zrd0RGTCJV1UYTAOZpi3ofFvKC/HCeCvayriE8kiKNwfu/4ZdCnpeE?=
 =?us-ascii?Q?xQ9cT5W/UT2jx3/aU0pev85JhTD2IV2Tpu5x1jjTho3ULQUgewyp8e3b3l4O?=
 =?us-ascii?Q?r4MpjsHStPaJMr7ztCOo4UraAif8s5jJY0cud5BoU3dak/L6Toq4P9YL1CLl?=
 =?us-ascii?Q?agrvMclwY3pJBiPlyEz+LH/PJ5Qt5csp2W3RzL67JRQ2YOouXMWzc8t/lDq7?=
 =?us-ascii?Q?ZkfktaTrgHnHrXlKCfAS6K6goxQejaL10VaMGh9Y1r6/Xkt57HKXnGEAJItE?=
 =?us-ascii?Q?3JImrQusb/pCNB32g816wtqSrRqJHd/k7EIJtZR9cBLwlJeB2GispFJ2jAiY?=
 =?us-ascii?Q?u3NG318eHD2W9dMopnL6XnD537piZs/gu2ORPUvxFEK70QM9bUY54J5p4HF4?=
 =?us-ascii?Q?9xMQsw473A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045479c5-7fd6-4624-2f84-08de785a675b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:51:21.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/RlzpyMLaJ8hmn545LIAN7YZkXW1AZqxL9ZYhCiXrdccm9qr8QcqttbYyu/lB2ZVQ2WiMeabX4KMXWTAKCMaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10625
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262642-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 151551D9505
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 04:09:25PM +0000, Simon Horman wrote:
> On Wed, Feb 25, 2026 at 05:06:45PM +0200, Ioana Ciornei wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> 
> ...
> 
> > +static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
> > +				  size_t num_stats, const struct dpmac_counter *counters)
> > +{
> > +	struct device *dev = mac->net_dev->dev.parent;
> > +	u32 *cnt_idx;
> 
> Hi Ioana,
> 
> The type of cnt_idx is u32.
> 
> > +
> > +	stats->idx_dma_mem = kcalloc(num_stats, sizeof(u32), GFP_KERNEL);
> > +	if (!stats->idx_dma_mem)
> > +		goto out;
> > +
> > +	stats->values_dma_mem = kcalloc(num_stats, sizeof(u64), GFP_KERNEL);
> > +	if (!stats->values_dma_mem)
> > +		goto err_alloc_values;
> > +
> > +	cnt_idx = stats->idx_dma_mem;
> 
> As is that of idx_dma_mem. So the types match here.
> 
> > +	for (size_t i = 0; i < num_stats; i++)
> > +		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
> 
> But here __le32 values are assigned to elements of cnt_idx.
> 
> I think that the type of both cnt_idx and stats->idx_dma_mem
> should probably be __le32 * rather than u32 *.
> 
> Flagged by Sparse v0.6.5-rc1.

Yes, I missed this. Thanks for catching it!
> 
> 
> ...
> 
> >  void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
> >  {
> > +	struct device *dev = mac->net_dev->dev.parent;
> >  	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
> > +	u64 *cnt_values;
> >  	int i, err;
> >  	u64 value;
> 
> ...
> 
> > +	cnt_values = mac->ethtool_stats.values_dma_mem;
> > +	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
> > +		*(data + i) = le64_to_cpu(*cnt_values++);
> 
> Likewise, I think the type of both cnt_values and
> mac->ethtool_stats.values_dma_mem should be __le64 8 rather than u64 *.
> 
> And there is a similar problem in patch 3/5 centering on the use of
> le64_to_cpu() in dpaa2_mac_transfer_stats().
> 
> Also flagged by Sparse.
> 

Yes, this is valid too. Will fix.

Ioana

