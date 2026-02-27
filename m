Return-Path: <netdev+bounces-261741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM/TBBNJoWkirwQAu9opvQ
	(envelope-from <netdev+bounces-261741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:34:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED81B3F5D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEA7303D11C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706A347FC0;
	Fri, 27 Feb 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PYLd7Oqs"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68499345CB2;
	Fri, 27 Feb 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177678; cv=fail; b=eGt16FBs57fJaq3lvVxbyeHb600pfIAADCa+rMpHCODs33XybwWc2VMAQsM/AG/T8PatyoZWG8z+W88i+KFbxi2aeYn/Evc5uBuLTZVV33iwsxhAoUxLlA8rwuQg+yBl8nCpirPshMkCXf2U8lwrkStzkVPhMCaFHZ+LLbfiqGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177678; c=relaxed/simple;
	bh=PP0KrTqW6uNg9y3PhqQshNX8oCb4k5l86f4zxp+465A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nFDZQBaN3SRgCryG1bhaq1vmQRkfhJYLk6Wz+T6LRRoN6+Ame4IqOG8e1N6Fq2NydmSYD8HyzMPDM0PkVhY5Mu29GPd93QDamnX2pEXQy2coeMSwfjeh6Lq+slt+nLvJtpKwqQkhO7tjByyumrxh46er6LFX1Vg7NN5q/ONzv3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PYLd7Oqs; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6xbMaiASQtl8EqAJJ5oNxz8LxeyJ93T2rD7PX4XPmaiFKCwbMQu0+rtP340DSjn8A2n1y0c7Ph8S928SZvV0ZH6YovK9tZgUpcSVqc5P3pA13VuIjj75AAoQknI5o3cTxlkN0HkKB4rEP00uOhkhiVgFl3vHgmYQIlZabvBO/3NHzyw0QqzTh2ywY6iDhUldzx5mKg8+ww2NPzKpnDsIWF4wSf6XXD2xLw305bQvK+4wwwmbyBFRD31dNpc+85/oq3oB/u9q/J3fI+MQxUdI6Ne3Nf8l7kAQaTV5D/YJwzZTRH8+NwoiYZVX6fmuAsJ/K/TMXqlE4o41aXdNT6Heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXZ2+wJ0USATHgjAG7bnGFP0loCZklD8AeUfRp9yqxk=;
 b=weGp0GrpfZ5tL4aTX8Aq+X7kz9s9kKxVWWdAi2J6k1pjDtWImcKVFEanu0fJ2+3uCfkxbBQt43qvK+I0gd9VNbHDCos2lp3jdYCv+m17Diqo/VGVXA3U4IglWUhhNqtrEIDeERAQmwAN0jK4kTgqDnjyg46GYYZBL2EaBcRjG9iyeAlhjPzCGULHoPQgQ3t4tNqyXeY54N+ryyoYIsxgMM7ogBNYvC4X0BKYRvEieAIZtTl/EaHIgGHqTRQljzh5vQDblIEdBURQmHtmAL2I/uAD5Hs77E8SjvRDXM0d0u75mwpiWaKC/F4+UK9tPtnLrlnDF6ZW3ERTyfsQVfPjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXZ2+wJ0USATHgjAG7bnGFP0loCZklD8AeUfRp9yqxk=;
 b=PYLd7OqsFJlX27BYkVmuCbpwhqIRuPNjX1BHliZxZnDDz2yNpLjZNS8t9oBqp8yvEJnFIV9JriMEvMLYJEe2yBVDQJEujZ0vJd/oJy7VVeX9hBw0HXNNDwF3DndYMUEu9I+JRsiiHHpNnXfgXrnkTHPX6GCX/0HqbM49WWyVc+ag6jgi3T9oQNR3IGAkNB5NSp59Xwwv/lWbdr2ML8niAW79UuT5QC011Mm0+vpC1HSPI8dZLQo5Mo5WgR/de7xZGmw4LhFOA3B6EkSmrrN1eY8KU0yVVYUBqxnA87vpbybxOlKVYq/hquPwoaF/BttMlrhq4UNVRXU0HGILWDHf9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV2PR04MB11957.eurprd04.prod.outlook.com (2603:10a6:150:2f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 07:34:33 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 07:34:32 +0000
Date: Fri, 27 Feb 2026 09:34:28 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <a6qhvs4vaxk33iryntrvybaesbr23v7hcrfn37p53viydd3zhs@6zquhlssfthz>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
 <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
 <ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
 <031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
 <vcphjyyj3jezenqfgieqac7ayxhslupgeu6kh2ywfukaat3rtf@tsqaz33v4o7c>
 <20260226182511.0d33f9d1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226182511.0d33f9d1@kernel.org>
X-ClientProxiedBy: AS4P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV2PR04MB11957:EE_
X-MS-Office365-Filtering-Correlation-Id: 3403cd5d-81db-4d6f-5c43-08de75d2a60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	k1proLt1Lgc8bTCMcz1W101IxxHeGSSfBstSLp5WD48I5bLCGelzNSv0QK9nnJhxqlrXdg4rm+PPpvQcyRT8gbU+71B3WDmumR0Dl0LEepPDWMdA6HpYQ5B3bf5VWUY0QuFgXvdxgWTUpbzJ5Lrwoe3BmNjMvoJSpQE11N0hzSB6rhvzfRS4BEJVchwErz1n5G9bejF3hUVs2SYsH2Y20cE4lCMM/h4ZW7DS9re9sxAzku68quYG2RpK3D6rvSsD3hjlFg/+lDFNoY08yDvobFqMhPmOYji/tugqtJZIuiUiFhl6yMTySR5m0j0FRS4DVNcG7vvH5nv0Bp5a04pLGr1+RTtgkP0V2VinqAITAU6nvDbs0TwkCeROr0JhRHqLRfWj9iiCWxYRhJGurOTq4isWagdDMc4U1UD9qUxOnPlzWlXuMhbXgXMyTL4YlfZ1o/gJU9UExojpOMqr8l39qg/CRgSdSmt6XAXmHxM9eiw9liT6slyqSbXnNgsVd6DYwzBgtc4jCzkEgQiZb3HiX99JDsepXqmte1/3RxSqwzJJnC2w0yXRucn0Qll4eAqzXEvOzcEPvOklFY86Y/wDuJ+YclayY3t7jamotSuucwGiCj9rT773DZkwjx6lNKrUO/HMjACaWoaf7YGeAuby/+8DWwh8Gx2aQYgFZ94MV3l/o1Sz/5U7PL1RRwyfx7cuvrYZAvnEtA3gPNs1z2LGHlzkktgRUoOHBQpJ1QPvI+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ajOjK8sJr8qSjKiRExUBZlGRB2phpKe7W+Y+HgydYg/Hka54qpBD9MFeszm?=
 =?us-ascii?Q?oLotvtDeXbyoGFu2dH7ZfAtcp95OdpHi1DwXn7s9XdUDywKqUiAOPldnB/XN?=
 =?us-ascii?Q?nrhxcK+HhARoGPfWwLutfdf8y+WGUPn3vI+C22wsD/3L2btiSFHUcAzqC7wG?=
 =?us-ascii?Q?RVf+8emxE8A5vqrK7luz9cGYQzm8oc8hoT414Ju+TWUAcT/LZbu0lAOovl2r?=
 =?us-ascii?Q?Fsjr1sw0RDE6ZR8J2XPMRI2M0iHQ01flzJwc8hbGB01PRave3mieO6MD+PTz?=
 =?us-ascii?Q?LsFWxMNf7viGoDRhs+TCNZvfB8bHYHcQCBdPl9rNRNuFmBe9imxJBeCZqeSs?=
 =?us-ascii?Q?B/D+9TDWXwYMJLV1gb6nkrKlH0Nh8zX4kzj6GVC35gaaI7EE1a1Xs4uneGbv?=
 =?us-ascii?Q?YPezBN+1qOrbP+W1/aeHijwEsaYkCS4HNGn8wN+fGyytMXVQwDcFwMtoG/3O?=
 =?us-ascii?Q?+VNyqedd2ADL77fK4ylXeXvYxw9QkpDNjFUU5pduh3LkNKysaG1NAHLOoc35?=
 =?us-ascii?Q?boT/MRIr5EcZZMXPi7OyuEynrC4kQlOCt7XjnHisPGyCr6ssNG2HJ1PSsnF+?=
 =?us-ascii?Q?T8vcvAGbxahgyPz0C84kfHuUY40b7bTh8qdYrFBzXYAbQF0yMmS1LfIK3soa?=
 =?us-ascii?Q?KIX3AIVqo4sfognQnMy8HI4Py6SFMHk9co/wH9dncQ3iSDswF9tzsfccY8rE?=
 =?us-ascii?Q?OMGymWg4ZoQIq+rinXPpr70ZKAY2iwtZh3gFoEkxE3zM99GqmwKZqGTltm75?=
 =?us-ascii?Q?HW334wjwfjBsHznHd04C0ntgvtsUqbJsw5nyfSW8P4V1aMNVDVDCCJCumVOc?=
 =?us-ascii?Q?3vqwe8eBVqTywnn7Y3C7Wh3A52s4N7TrdDGsslyw8PN1nUxMPFCa+Nu9Rypt?=
 =?us-ascii?Q?/5XIrJbpIvVm2ewjp4gfiN845C+Ldcyy8biwoSkLASd8UE7yFEFfj7g3dWDd?=
 =?us-ascii?Q?ogIcNTP1/FPjbUDlam+NIPKYR39e0NS4GK9ruyO4HRRQCX1uu8xmMvVTMJSQ?=
 =?us-ascii?Q?IdTNX1XdMsWrQgYvaCXlozI6ILRM7r28XEDZd8r8bjDPiYugR3GB9exVJlxv?=
 =?us-ascii?Q?FzK2ruoYCqTmBGHGHwexzAlTSolGJuyUhhvpvxoG6tbqPVvZYWi0cFohCMbB?=
 =?us-ascii?Q?nq3HxPp/jrCq3hyy3EfrKJKwYd+tQr4U5k1r9Z6mOGPRSZl/FCD06TI5huhR?=
 =?us-ascii?Q?sv+melPbdcyHzKWtXnSK2TAgXR9JGh/jrK95+1WE42HBppK+JW07Lg9bdRHQ?=
 =?us-ascii?Q?SzDMSDGTs03KIE5TX7NlXnmB8pcjcGVg2CUPHdmcAo/6lUpwHUijXRHqbBJh?=
 =?us-ascii?Q?PPX0ScIkgPnCtnXBLr28QmGYX3n+cHLsp5y2CztPBoKdUcHpnm9lQS2H05Fh?=
 =?us-ascii?Q?7L83tUnevBlV7SE0hPUw2CVIUgzL9QpWWt8zAHUwXSjRpftT8BLLMCeJSn+I?=
 =?us-ascii?Q?fyiODBNEJy9oh+A++RGoBZIUL/lOBMf0wRRGYomUZOAmAJ+BDAtnmNXsStw6?=
 =?us-ascii?Q?D0dnRmFdi4ihDWYckbFaf+1XBG++s1ERJJGvyrSS42BKOlfU8opu1Bm7xR1z?=
 =?us-ascii?Q?PEV1gG9U5NpvL9MztdpVgGtgpvXux4yv+ZE4eGuy6H04QZRKVVyzoD3Pfame?=
 =?us-ascii?Q?3ZpNdMzEa6fCY3ajE+YirNsCYGLPUbB4PwKmQHDAlJFDww5Y0JQGgF7yLL5r?=
 =?us-ascii?Q?yH4tmJ/Ap8VaI4ngCP6M8EZFD+sAyWYmglS53e2/2Ms4C2nzh2ud5m9p2+Kv?=
 =?us-ascii?Q?7ciroPWSng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3403cd5d-81db-4d6f-5c43-08de75d2a60d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:34:32.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P19TN0wea5gX7xWLJWibZldimmjPJG+PLeIj+kPyzq4XmNslaPQRyBsLm2T7/ChFZXXeIm8EnPNG4icwx+x1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11957
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261741-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABED81B3F5D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:25:11PM -0800, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 16:18:21 +0200 Ioana Ciornei wrote:
> > > How about, fail the test if any are greater than 1% of the number of
> > > packets transmitted/received? My _guess_ is, if you have 1% packet
> > > loss, networking is not going to be happy anyway. It probably means
> > > you have one end doing Half duplex and the other Full. That is a
> > > typical configuration error you see causing collisions. Not that i've
> > > actually seen this for maybe a decade!
> > > 
> > > Failing the test, with a comment about checking duplex configuration,
> > > seems sensible.  
> > 
> > Seems reasonable. Thanks for the help!
> 
> FWIW the expectation is that the test should be able to run even on
> systems / boards with a single interface. So the control traffic
> (communicating with the traffic generator) will run over the same
> interface as the test. 1% error is unachievable. I'd only check the
> lower bound, and use some sanity value for the upper bound (2^30 ?)
> if at all

Really? I didn't know of that expectation at all.

I did take ethtool_rmon.sh as an example and that selftest as well
takes NUM_NETIFS=2 and does check for both a lower bound and upper bound
that takes into account a 1% deviance from the target.

How would the test even work with only a single interface?

