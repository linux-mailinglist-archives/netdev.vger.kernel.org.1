Return-Path: <netdev+bounces-261816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAwlOEB0oWkPtQQAu9opvQ
	(envelope-from <netdev+bounces-261816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:38:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA81B6133
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EEB0304DEBE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE5399013;
	Fri, 27 Feb 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iTgj597f"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B74304BDC;
	Fri, 27 Feb 2026 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188684; cv=fail; b=dht/iFO94VZuH6kK37c7rp/ypfCT5Ezjy/PfKNHUc+QsRhlucjcwS/i8KnMsv8MuPYXkjC7j8WC8t4iAGt6dcYwDxoc7DU/OpfWIq6dcj4x9FlwOChZw7R2vPMipNurLlTpbfyrRmNMNwzBF3gOc8vVDNNUhyLHEHq9A9FF8tPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188684; c=relaxed/simple;
	bh=xd4aDxTWeG+1kFV0ghcIAY5p/9K3pojFecyemLVNns8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fiMJggF390r/a3FHszAN2uBP2TQzgw7X9y2Z+wf32RQomS/E0Lk0eLR5WEZzlx0sOA69uaq8fXCFs18W4ge+0uOOCmDZA7M2fqmltUd2yMaMMtI7hNA3Sk0fbnHHAb3vjpIhGhdXwSqwVo8sqLSbV9676yJNxyUGZ7HVgubIgM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iTgj597f; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK0/CauzWtic6qW4903sXkKcWfKp2pZVHOtoJxmlrMWBsSOpUs9ow4TqSlRDlBaJGGGqjzeiOG6cUz+swQ5N24l6oEFmDjbcik/f/hoAlWkSokA4A6PKIMx7mo2MRf1FASOv4LfU7lfkJPlkt7/nj4yVSQB7+R4Y709q9S04df8U7FFs5gaXpJPZisLWjA4Q8o+3hB2ed50k5+tzQpdPQFAhLKSDjbCK/8X615mwGeK6ojjQ+8PkQbYO+xK4JmN+H563/IjuK5jMAqdyy2H2x5F04+f8VOcWhAWj50yqKKRep+V6hqqUjteS3hvH78hvSqcwjhV9+5zMu+eKq2zlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9HDwUqO1R8PzvfhBN9PdxSux/QCTQdTczx4+YCPhMs=;
 b=F2kKHlXLS2CYCmAvXEftwLeQU+J7X6bBZd0ipGN1SFT6eemZymfazUB3hzM7KvpWylCYHtdgm8znuL+P9z79dGZXNh9kYB9/xwNKmmgut5fE1yz5qiV493QMM39HWdoqbQeo4LqgM9bCpgIG3Q7Lz+VE760VJaUDtATujK23BuCUIOXInyw5ycwo6jYv4bmJKPY4QKtN+DunCLyEWWLEqoPtvJta5iekDkz+2U3Kwy+1YbcDHHeUO33gTD4CodHd2BBL/ZXQhocqtzPkehuGKbVtO6MGA4DkeD4uQnP9TWOZlzcIfswG5JMOVjtSxXBpAtGKsHIcXS2IcXoPFCSAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9HDwUqO1R8PzvfhBN9PdxSux/QCTQdTczx4+YCPhMs=;
 b=iTgj597fBlTffaG1u3pXYFO/3frIFwgMgNdvuptM64ulUoB57NS505/Veg11jBlAedt3aXxpbuaKe4ck9vy1ug1p+/89fveGaGMySNetQQHrsm1hiGW5nOm8+CkOGZDRBRcKzvPhq9DpZnrAg4ZnIlBoaUqZAfUKRpaqEg78hj8O7f4DaH7ASLmsiIPnSUwmzedtbj6bvJv0naNyFL3UplTb5+xaAjBsUGbCdbnxjqCYG+KJ8fEHXPAFT5EAw4Z+u+F5q1Vs14aqq5MIrfTrLtadcEJ51Vh+nyjdXsQp3GdvNblkbMmipxEvWa2pB984hHWQ1Kve+rIhsDugspgaaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 10:38:00 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 10:38:00 +0000
Date: Fri, 27 Feb 2026 12:37:56 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, horms@kernel.org, 
	edumazet@google.com, davem@davemloft.net, linux-kselftest@vger.kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [net-next,2/5] net: dpaa2-mac: retrieve MAC statistics in one
 firmware command
Message-ID: <zvplmxo52xj7j64njbrwqdge3mcgswa4w5aym4zuapxgxslaun@nk3kvb5cx5bf>
References: <20260225150648.1542206-3-ioana.ciornei@nxp.com>
 <20260227022613.2519224-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227022613.2519224-1-kuba@kernel.org>
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PA1PR04MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e580a19-946a-4672-3516-08de75ec4775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	fSnKRqA09qzrmQPz3cCjSTfpDdnJIYpgejxA+F391tbPHr0LFg/2oHWMK1xW7sNVbQnc5/s85Y+351+epGBy+zBLbq1W3lYtOKCC2ooFoHHeSbo5OHaXh5hs9L51MQwrtbgMPR0FLYGh4KBQoXrIvsqLuftt11MdeL+lbtd9JsQvb0+vKLxRgpAgBBSUdsbR9y4CZF9oQURjpfiYvr7/u1jA5MmqsuanqNH0Ih9i2P97U8j72m/G29rjPwhyBNuo0pM90ybM9YNc/I4HOU+He5XhcanHobzmVXBju/yb8xCOakxfd9BB0v3/+uweFQ4ulqPtngPcTbyqNJB9dk2FlNXj4xTM8JW++LO9Wn4oRDT3Te1uchOvOSWk/Aqn68kp3kKDhpd+ltDAXN+k2Oj4b4IdD01L/YkzfxQJWtqqcZBMjvJvzDT1OIcnv7AqBo/jG6KwcChBkAVysHs1P1u+RSpJccOdxg2w0fDMMEqAzv9kz2SqfgMg5a02FWnsjxIoHOMUlaDtfo4s4pAavNMmlSntquGlKX9kj8zrWJr5U58FgpsSfXGZh7bsFWYP0qpOGnOQkCUfSGeRcHb5b8NQKDHEIXvlPGkc313FbSUsqXSbIR+sXWmm9vdlJFNAVAlZqrymVnpvzrkDoGYXFRwVQmgKdIWJM0iDtcbD7lSLf1CfJd/HC0BzQiOSa5najr8o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?33JJuN+ZUWsk+upemujInqsJrmlIET50eKZVGdVzWvx6GqIRIWNl0XBfjCBR?=
 =?us-ascii?Q?FjfneWditT0U/9hDSmI4xZGNCtYg3f0TWZqZKtV90CBOuP9kQbsc+xgNvuif?=
 =?us-ascii?Q?QcV1ZpgxxK7XEbW5CrhbHKifqA2B06Ubfqg7OzY07N8RKhz55jRnI9aErjyk?=
 =?us-ascii?Q?PMFj4H/NBgrzHYXvqP5D9YKTvGb1nCTym6Pz6Hcy0qw5ql56l2QYE8/Q++Hd?=
 =?us-ascii?Q?QcXkdP8HO9Jl0I1/0Vk/0f5nQayOe2dJKf4IBDs0o64oobId/nQnpI8luDtH?=
 =?us-ascii?Q?g5Mmmvg6gFy+Z+GhA8mI2iBBZiENG6MrW38TaulUQKsbWPQBwT4vWYxPjEvw?=
 =?us-ascii?Q?fT+nDdka92ODkOaOvcNiWhMOtg+BSZGFNLxf9MEoMjcYt4lIJTlGa3JpOSne?=
 =?us-ascii?Q?LpAHyt/aUEKalHx+Ei3801c9VqVvdx27KmZs9KLqkdt7c4t67nmxL+KulTzk?=
 =?us-ascii?Q?WcQ+QltlysPq9vD81GKQhFeyEzpBFIUyjOolbnfNC3vNfbueM+pES2oFv4JM?=
 =?us-ascii?Q?0ldtSijrL1yU6+QaSb9659H8bdhfONt6hz0xnStZlXBIP2h8GqJRnUOR/krl?=
 =?us-ascii?Q?j3yXepOk5xILztk9HTe8zy+kkAzM8CzZ4En9Hh0yQVf9Bf2CousdBIQKfkMa?=
 =?us-ascii?Q?VbbguprfVQ8ctFjKHwU2RmXD3QdDPO1+dFEJHGQi2I6xY6PWZltwkIqazfgi?=
 =?us-ascii?Q?sxcZrrp7OiiGWw23OBP9XdpEBe7+HwktGmsMl3aOXuRolZTCS6ko+HS0LqSg?=
 =?us-ascii?Q?Ya332pWzdO5uEyfXLxM05UNfVR4uI5zUGFkcoZEJWyfc3b6sn9XqaMQba3gc?=
 =?us-ascii?Q?SG4jj13+baZhiw6efwmn8gqYdbKTUHNBrOxkE0dTfCbhsk125VTCZGim5yC0?=
 =?us-ascii?Q?FZ2VBTJpbO9HRaGiRXlKwNW/mmE/j2Y/je5L30S6d5CbumlSAUlWpgQn7hkS?=
 =?us-ascii?Q?kISxopcDOAJQinoXDEqyZRdGXuUz1jbpPpfsJqb7aiTdBpCaqYpeNqBd7+GP?=
 =?us-ascii?Q?kCyPvl/uSQTAq0IAEMAj5O+YDkoCNUltSjDNUC4sH2o/g2n5q2CLp6FFNnPf?=
 =?us-ascii?Q?CObspcdD0xbquUm+QXoqAF+Sir9XQnq1aWEp3+KMvMRdSIzwXANfKo9FtJZu?=
 =?us-ascii?Q?fgBLxel1/a5egGZCVde0+O+vQVscvXbXcQGbfugAIvGgy1eYQsx0m4xtipKf?=
 =?us-ascii?Q?P9q1DwzHfNOj3Z8Sq+qgJE3kETVoLW5aWLNuYnSbnPsMLogrMrNOddV+SJ8N?=
 =?us-ascii?Q?FsJRpDQV2iYPrHmNpO3WLqOnSIfzrKVcygNNBoFLzP8an2Wm/4jTX3k4ieF1?=
 =?us-ascii?Q?E3ItBYS8mFAvAKbkTj0BvfbdH1Eifb4FGzVaI+PqOImktt50/eKAK9WejvLe?=
 =?us-ascii?Q?R5lJ989Iu65i/VuIa+eL2L7BiiTsHnhdb1TjyFsBouX2LxxHc46jLjnJ3T/h?=
 =?us-ascii?Q?L8Ld/Hz73J8vii5cadLWu9iWNd6URIDNPtW34YMa/TfV5ZSj6s7CdNZ4O8D0?=
 =?us-ascii?Q?RuIHRjZK12Y3ZHeYn9GkpWP9Bi9RCT/XX//DK9o4beze1mu+nnJPUl7olade?=
 =?us-ascii?Q?RHA1jG6ejM2k3pY0kllfog7Iz3XsgfSF4M8D8t83n3cMHOPI5pDSFN+Rd1zx?=
 =?us-ascii?Q?R8ubIFl1EgvuyyrVyI5+WbXoMTd58ObdYaU7INKbXI6A/6iiVCpoFMYl4aOz?=
 =?us-ascii?Q?+jWF5Zk9zR1YQhWegn3vgOfBCvxBXzsfLO/yD8ebqfCagd6Rtfcyf66MBu2G?=
 =?us-ascii?Q?/3s9ACLINA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e580a19-946a-4672-3516-08de75ec4775
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:38:00.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EoGSzAFVnGOBcOrUIJHQWJ3Gqv+QZs3bT4LZ1cmB7jZv3zU3NRTL8BjvpROdzDAWqAaLm+FNSrgARnqm79fVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170
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
	TAGGED_FROM(0.00)[bounces-261816-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 46AA81B6133
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:26:13PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: dpaa2-mac: retrieve MAC statistics in one firmware command
> 
> The latest MC firmware version added a new command to retrieve all DPMAC
> counters in a single firmware call. Use this new command, when possible,
> in dpaa2-mac as well. In order to use the dpmac_get_statistics() API,
> two DMA memory areas are used: one to transmit what counters the driver
> is requesting and one to receive the values of those counters. These
> memory areas are allocated and DMA mapped at probe time so that we don't
> waste time at runtime.
> 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> > index 422ce13a7c94..63dc597dbd7c 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> 

(...)

> > +fallback:
> > +
> > +	/* Fallback and retrieve each counter one by one */
> > +	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++) {
> >  		err = dpmac_get_counter(mac->mc_io, 0, dpmac_dev->mc_handle,
> >  					i, &value);
>                                         ^
> 
> Does the fallback path need to pass dpaa2_mac_ethtool_stats[i].id instead
> of i here?
> 
> The old code used a sparse array indexed by enum dpmac_counter_id values:
> 
>     static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
>         [DPMAC_CNT_ING_ALL_FRAME] = "[mac] rx all frames",
>         ...
>     };
> 
> where the loop index i directly corresponded to the enum value passed to
> dpmac_get_counter(). The new code uses a compact array where array index 0
> contains DPMAC_CNT_ING_ALL_FRAME (enum value 18), but the fallback code
> still passes i (sequential 0, 1, 2...) instead of the stored enum value.
> 
> When i=0, the code requests counter 0 (DPMAC_CNT_ING_FRAME_64) but the
> name is "[mac] rx all frames" (DPMAC_CNT_ING_ALL_FRAME). This would cause
> all statistics to report wrong values for their labels.

Yes, that is indeed true. Thanks for catching it!

Ioana

