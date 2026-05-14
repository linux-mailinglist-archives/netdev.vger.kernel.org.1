Return-Path: <netdev+bounces-288001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBryLL3gBWr4cwIAu9opvQ
	(envelope-from <netdev+bounces-288001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A7543733
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DD4A3035889
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB440DFC3;
	Thu, 14 May 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEEUpBCu"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56473DFC7F;
	Thu, 14 May 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769595; cv=fail; b=Gl1UHRHRQDA8LI501oYluw8jW5Y3SKPiSbTlw/uru/HYTxZKju9D1wwG6MKRgvepCOXGys9jkU8CJX5k9OXKZDlN2rU0XAUXN7LxOyUOnroX/jSgSkJ8Yyn7BGI/iJtp9YU6al926Z96g74BVHERnpXXOZi/38f8XkLtxcA5FiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769595; c=relaxed/simple;
	bh=U/jp79BiiO1mCx9SpySmxHw/wzmq763zACf5evEjTvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UuTfG1Z1P5QVhhq+U2etNLk7lrIRwqr02hCrV1xpUhnHn9PAITLgV2JoAP4Or39dj0pthYMn4zx38Zbp4f1Q6o80i6n9p1swQENXZ9Um3bZ3JqvUBEuNm/dptfFNQClL+lLhwUAX4LGEQ7cR33zcEy3TJ2MaPxbg7wlBCpa5Xew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aEEUpBCu; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8cRwx7QNXn0dLPR07g0DUHLA1a4nAduDiY6sTrwX7xfneQzuXcJdjOGIuyr7GozBecVauciKAipMBjuL9zS2s9FcWnnOr1K96QwMrHZych7guc2Q2uJV92/2uPmjXTBunCZe+9N5stTZ42N9Y95wLc1c4lxpz/ACVGrSX6vuKcVIeGS8kVrt+UApQuImqeCgPwzNnvZRAGDhfQKJLrDwTbO+/q+TCR8kESsSROB8qM0HJM2NbN97nJ9XYDwh/H1JR8e2euwnTfFw8dZpqW8+eGRWeqa02SaAZj6+K4QUPfjRkOKYdHnpEOh9pJd0AvuvQicuFnpm8j14LOyCj2gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V93wMlRPg60jLHpjQ4S06gJOmAj/36pnbcGVRl/8dKE=;
 b=MRTACmyG828iHF/d87CXdbAgxRKlXbyChyCbQQmXs+kE/pmDk56wLNc430YkCkXPotMchDKiPkGrV6s22Bt0ECA28Hb99qAHMxLtjzO1KLvHDpoLqbO/dLj2Hsh4U7z72bOA5kuKRD+bPY5ymFK2yQNCSAWBXz2EW5DBjoCyc8BNDrwy2Jd/xeOW9c3tViWm0nHeNkSIq8D7bYgPTX4jUXPkSAoEPp0KgIj4UhhvuKgcz+Z1JYi2XgnnXovv6/y6PwRNG7Tgn9UfbRIm2abIBbTV0JAlbscaJUNhNQSlbgGhPT5T+fQgCl6lNSO141WHcqKRi7+YJGJBWungfhECjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V93wMlRPg60jLHpjQ4S06gJOmAj/36pnbcGVRl/8dKE=;
 b=aEEUpBCuzjlTaTb//7ps3dodAUwJblx4PdfMKd0MZSshOhHyGy55Jb1oywBPL5W8p64EREYWwCDffWmhKZKt3DOCiQnCXGYUWcfFh8x/dbZSUY6/ULKuW4MBsO5xEnxx5cRylBzIoq7yfX7jl8lPufclJX4oLYClIPOQvNZaXbwjO8AcNONQpSJqlyTSDDomqCuTFsRgz9FB5kS2sEifGhZR0rb6KOA0cuTm5SQO3hKPHDBNNkCW01oS9INgdQiZzAx2JGs3DkpEJt+D3UAi5El501zqpzC5l3nnVg5b+Zs181S5NFLKJHAPO0gvbLcsvQ5TIESAAuOgXY6s66Tmvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16)
 by VI2PR04MB10620.eurprd04.prod.outlook.com (2603:10a6:800:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 14:39:46 +0000
Received: from PR3PR04MB7402.eurprd04.prod.outlook.com
 ([fe80::4129:7aed:b5cb:b13d]) by PR3PR04MB7402.eurprd04.prod.outlook.com
 ([fe80::4129:7aed:b5cb:b13d%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 14:39:46 +0000
Date: Thu, 14 May 2026 17:39:42 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Josua Mayer <josua@solid-run.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Rabeeh Khoury <rabeeh@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Message-ID: <xnsfxbjmvyxr2vbxcpktd5p5twyzfuklzapiyvwctuikvhcrvi@da4e5q2hto34>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
 <20260513133721.huu4j3wksxykizz4@skbuf>
 <5cc008f1-d2c4-4a56-a1b4-6fd9bd470049@solid-run.com>
 <20260513151018.sfyowih53zistli3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513151018.sfyowih53zistli3@skbuf>
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To PR3PR04MB7402.eurprd04.prod.outlook.com
 (2603:10a6:102:89::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7402:EE_|VI2PR04MB10620:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5f87ba-6e74-4305-6aa4-08deb1c6a4cf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|18002099003|22082099003|4143699003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
 /XI7oT3OdxsTbRYjEjbS8Hij5hRrUjCLYK1ttG1e/iUh1kfT+VOLFr+pz412IlrvoODYuTClUB4sQk07rsJZd0Q7MvFVx3nLfYgOmdEg2jDonJc/zSbawbpxK5Ez/FTIlpylzksBn//kFe4+oqMj3yH71csMDAvbMAZ6PprofjdHThoOqDAzqCbDcY5fW3Q3E12r046zHMWlTa+cpTHgL7Ok4dAvuZfCoIysDO35bCrRS9MRRpGmqvf+cfTvf8czVp+JcbYo3k3kNzS6J983zacPD1oGAPKVB5LNxTpQ3mxU+7kOsdn3lymE3TL0vqq6WnrHI0LzkTTUwP4rxCL3LqnJBQzbbqrpihRxNNNMvRN/EWamEahaFJFG3Q69gueQlhKv9TK+nP7EFFFAD9FDozBgxICNWIAglI8KgTvOWpOpMq9i+yRdC7UZ2lKuyjI2DD5V87UYFuxhHApvphtGhG7T9f7AqZHm1cmc4Rs9no/4Pjld41gML6t+PGd5CPZCxYZ+boxyreBJAtD2RAyH2vI+//R11F6Xce9vTEHDBu5AzhxYoX/TwCM5R1ipa5vg0gyQQUQjjxS8LMD2Q3SsQ527VWWIkWzfq9uMe6c4IdygFad4eJllBjWOhigxmB8skTivt8i61W3wEyxQZ8q7q4ZNAbxrHNJIvwqKUHeSSSFY26tFQCH21kQ8chy/t5om
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7402.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(18002099003)(22082099003)(4143699003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?tGcyqwMF/rqkmABMkcqzmfQkiQNDI9FKfIiXAfsn8ylCd5MGhwBr7I+i/4Gp?=
 =?us-ascii?Q?gog5NxVDrxDpWn9H4hSb7oT8SLXJFjn1xRuOF1VHK5KSo9l1mbKyFpBMaJoZ?=
 =?us-ascii?Q?/oWAWrY2jPrXXEM3s4/jdoEntJ1QdpCWEcaRGW5PEmu+/VyEo+7Lc4lHuWCW?=
 =?us-ascii?Q?bkOzNM587GJM4mvgHgiF8cJqnuHBwCCBqZv8OHObopgmUCMm/KruvXdbXFUe?=
 =?us-ascii?Q?ziw78UpDI9/TRK1NJCsTmUT54DPIO1L5MpbfLpFZZonqWQxUiCD11RyOCthe?=
 =?us-ascii?Q?Ch3nZTr74iryRiitvJuKJ+aiq9hXUurlwDkn3DmdwgM9ArlP5vCaTyLYjWaa?=
 =?us-ascii?Q?v34WjJsJr618/kJyV515Cx+2baTRdS0fyBUWkD9XmLVyhZ0ZdEJmPjTqC/Hy?=
 =?us-ascii?Q?pHBo+sSSuBPunR6AlZBDCxJ9SP93gong2AJn6FAY4cMQHEqyMks+lwMm+wu8?=
 =?us-ascii?Q?Y4IxyTlNwTTX4BYfS0ZCcaXYBSd9N5OfVDRDCBWvDYQ2TZLDCQMAzFw/kMGf?=
 =?us-ascii?Q?2ius6g3Pae5l0otdjkKxCDD418lWVduP84v3mBpnKHG16Ivu3rlKsz6FMd/t?=
 =?us-ascii?Q?OQnulq1a9n2vnqypT5oiU0dkLDM4QRBRdnclt2aMJWz75XfMGrEqKCqU1xRz?=
 =?us-ascii?Q?ipzmOfH98z+ih9S8JSU6l4+vsNCYtQO/2nn4VyMZElYVjsBWvrMS+5+b9jtk?=
 =?us-ascii?Q?ev5ajfkSsJX06h5XaZAAH49K2sByfVBeT+AW/3P/D0zGh+jURSACqs4m8GAS?=
 =?us-ascii?Q?BPoa0KmrtdJL+3c8jWN5CMvNNQ+k3IEirqxQQGyJrEy7F/FiR8VFkkIwk6j4?=
 =?us-ascii?Q?W6TPEfkS+Tg+3wzTIEmHuavPyZ6nZQGs/6VhHeisPqCGvSnisQ1k36DSM91z?=
 =?us-ascii?Q?9G7KHxVgKwnAiE7AMkh8k4M6hiIHptg8c8Tz+omI/Q619Eil3/6ZFxoduu4U?=
 =?us-ascii?Q?+WFTODRkhxiC9RC4H9C5JeZjjkYO3IdMyu75sY2Gcw/8oHXj7JYxVqiWkQ6t?=
 =?us-ascii?Q?da8gCeEfy5ie58+TmJV+6Ubln23jmYFKcjjBDhe5nGqQzxoQR32yRmZLGD9v?=
 =?us-ascii?Q?NPseZfRrw1prMDNa7A4FNcG9xEMKYl0g/vZ0minKuONypf+sg864uujTWUqL?=
 =?us-ascii?Q?NAKm+3sM6HHmd6Xq/H4QObKzCR4uamXj8T+81s0Ybgipl5QjPsQYXgC/b6zs?=
 =?us-ascii?Q?MNVlF3npvKq2YR9UHnfTugPM4s+Y9Cf/w0ALWxWvB55N46pRyWyS23iRwUcb?=
 =?us-ascii?Q?8Y9Fa//+Jou8xcXGKRbRwtM7SbFJH6mC5VdX1D1cuFJjXx02aXTKKqgRkzPC?=
 =?us-ascii?Q?0OlVnptQ45fiLQCXBYAeHEDpnXBwY7eGU+Q0kcjdoCr0tyDmUe3SKxQqCzN/?=
 =?us-ascii?Q?mI9pHk44RLhUT/Kq0wHJ7o/yLFCw2v23oXZF9CKwNYntrRVliWE7WGrJVJkf?=
 =?us-ascii?Q?ED/s5oiwe5htBk0JJHj/6fQ5QL41I8Wj4mLclIeT6a87JMWfanED21Sl5uGp?=
 =?us-ascii?Q?U0J2A1B05jqiFwF9Hfuk5aVfruNdUUTM5FNiRW/r1wqw78Rze/Rf5AsF2fi6?=
 =?us-ascii?Q?46iTSOAjUVgC8zkn7+E2u4XY9Wal9lB6zYtcYDe/8XbL2P+FEAA4Ghu9/Uf5?=
 =?us-ascii?Q?pRLCf6LEFS6mEFs7La4Sig1fOzXrXx99R8d4PKLguDTBqGIOQ2pCbokE0kJN?=
 =?us-ascii?Q?YctIeOTsmGc3+rkTCnopKqpAU/l9RO7V5mJvk3V7rqbAYlkatkSCSMPcxhkE?=
 =?us-ascii?Q?4/cLLtDuTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5f87ba-6e74-4305-6aa4-08deb1c6a4cf
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7402.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 14:39:46.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrT0p13NyuxJwMQd/0hUqGI0IxW0isaPcLvtTWSE/bc5FmO/B7yQs5x6crqK6SUzlync+DnQZD16j8OwLBA3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10620
X-Rspamd-Queue-Id: 339A7543733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288001-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 06:10:18PM +0300, Vladimir Oltean wrote:
> On Wed, May 13, 2026 at 02:50:38PM +0000, Josua Mayer wrote:
> > With updated compatible string it is working perfectly!
> > 
> > I'll send my tested-by on the series, thanks!
> 
> Thanks.
> 
> > >
> > > You can look at my branch
> > > https://github.com/vladimiroltean/linux/commits/net-phy-upstreaming
> > > specifically commit "arm64: dts: lx2160a: transition to device-specific
> > > SerDes compatible strings".
> > 
> > Thanks!
> > 
> > I will probably have retimer comments i.e. one phy object ehach for rx, and tx,
> > instead of combined - as we can not rely on hardware designers making clean choices.
> > E.g. imagine two retimer chips, one handling rx direction of 2 ports and one tx of 2 ports.
> > 
> > phys = <&serdes_1 0, &retimer_rx 0>, <&retimer_tx 0>;
> > 
> > Not relevant to this patch.
> 
> Correct. For the retimers we will upstream (Ioana is working on the TI
> DS125DF111), their channels will be split to separate Generic PHY
> objects, to cater specifically to that use case. Hoping that all other
> multi-channel retimer submissions where there is no meaningful
> distinction between RX and TX will do the same.

In case you didn't see, I send yesterday the series adding the TI
DS125DF111 retimer driver that Vladimir was mentioning above.
https://lore.kernel.org/all/20260513185103.1371809-1-ioana.ciornei@nxp.com/

