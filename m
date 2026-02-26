Return-Path: <netdev+bounces-261191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFseJ1Dwn2kyfAQAu9opvQ
	(envelope-from <netdev+bounces-261191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:03:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 497311A190D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 914B03055C73
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D186C38BF9C;
	Thu, 26 Feb 2026 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hfUrcUcs"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EE2BE641;
	Thu, 26 Feb 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089420; cv=fail; b=WP5zFyCTljrkpWSGDCknWDnKBeO/Tf71sjJyL2beljU/1OH5unD/QiYIt3Wv5/qtEQ0uuCG7pz6GREyWpmXgT5PzCRKWv3BZtrVMnhN+T15KueKuOHqzHBVWDgB+kAZhmQa3I1XXfYrHjWWPh+ZnnnZfBcfuh3L8qKqlUuHDJ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089420; c=relaxed/simple;
	bh=xvqV6ZZZ2/YuT1qj+ajPfjjjYMSBCa917hyGOodPUQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+xCpspWSb1USIcBT7ykxX2i7O83JrGdtj6/OIC69JtNuT5Ukl/jM6uQGDPtp9ZRc8Gfw+ZDc04r8tXrGAASPuKze5M5m2M1gHVe9hjAFdaDh0v2DSWAd4sWbNuHqZtgcBLNAtZvNm2n5FEoKe1i8qC1IzjSKpBROVM7QcMIBPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hfUrcUcs; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFSCG6Xxy+F/FmEZfGipskEovExmd+Zc78zzrLWXVuTUMeRRynXsfjlDuMU0BkPFPQND3RY4mSUwqAo2dwuuB8NCMZ7fSn6srUf0YN3r3qPwDnKjl6+iuhN2ZqPCiZG/O6pBDMY+OVD7PR8we1D07HKjmj84/IjrViUWH3kH3Zf0g1uedZJcGgFjoOukY3npHvk9roExq/2+mb1ay4jkx1efhPs4nm+pY3he2RA5bGYq3FqOmO6971bP2QotMr5LOCIOLlEOoIKKTWCMPK1zlyjo+g5pCiT+tgrz9swS2Ust3hN3G0amSqn14p+Y41tlbCgIwpVDTEiGB1u9XQct8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmVw9K2YDvOvWL/s3+OM+5bLdH1K4sfvsPsgSxbOweU=;
 b=q5see/qkuj3/FN88ofL/EXuKRnpj8O3ujkd9K5TRjHJmCsr5CHQL8hhYjs3Vk+al8ZWpLGYerHaCdByOjWtKF9gq4b35+TOJ/eJ/j5IHFZPbOHrI/c9WXw3a3oE7glqn8adQY76nqMkbxCDkRvUfbp10HypFFYlz8x9X1axlq0ozIzzja5czV48Np0xaBcdBcozY5SNuSQPwiDSnkyOqyrCwCQ71vRV6zOd3siqXjhOzOdIGdrV52YvLPmcUIrOPrBZHkoRPXMg9AAtbOgEX54/kDopj0WmYijAY3B8IzWRqpm1EOEr/DIilPw7/o1ZPprjrdgrYZzjKeJ2VkO3YFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmVw9K2YDvOvWL/s3+OM+5bLdH1K4sfvsPsgSxbOweU=;
 b=hfUrcUcsuO5ViwKxoFhhMPD5RvrZ1B2qD2W8gSToZ28QfPZj4grv8ToNvKmw3wWxLk5z7OBNUEBtsh7S0uzNDpF8ptknOtxrFp/FPPgDhAkmzL1JmK+Ibft1hr/CM4RAr19Xoca5eREjl5HUvqP8AouHao9pq9kSM1Ww+Rr8XZP3PS0vCJKbTMWi4Gd8LH1EQPuQICUvxcaX4zpcSwm2PVSGX4L+I/TeobfuuLyx55HnMMCacxT097B+KGDsfs93sxH5NiUb/ssLMOGHfT/FKzRoU5CQp+at+7wgqlAQ3HL9Wcat5DSEtsoCEIaQl1gzOOkgf5DiLwydU+2Yn+79dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 07:03:36 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 07:03:36 +0000
Date: Thu, 26 Feb 2026 09:03:32 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
X-ClientProxiedBy: FR4P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::7) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS8PR04MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 792f60b7-9530-4773-631c-08de7505296e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	X0wmb6W/JvPXFBq36zY1lUrQbvkcfmC+y0JQ0Cjo9BpOLrEEa2Php9ynVlxH+F0OUZ7sraReel7bQZ22DLD5Z03dKl5Oqz/ASwUiVo/SFcT21Uk5cmJmhRHmvd0kj5sTX20FVEWZQQ1s9dbqQH7OYkCyPB3shWI6FYphDePak29TKEJOLA66q1/w1gx9vM5NSc/sf5U95RaNiVc5GmTgS9mfNyBW42USsGz3v+q8byjNT0yMkYNaMTvWxTdbIE8h22nItOXLXL4YjTVpCtTPWreioWIdZWsjYpWn3ZqDNSbKj3VXvlCOJ8fM8r4kvClAYZRVLTm+JS2V/JuTL8h6sdjOt359U7mOuQoUWIMMTkQOqVgrHOF1uLTQWxS/jSFFfeUG5kVyw7Z2TH9vWR/gCvLzCRfQh8BnYdzVtD/y3IJOoiwAWARKKuI7yzTf6xg+6TTdj1Ktk4HAT+URL+6T5TNkIs/fB1E/U+iF4nDG/r5XX5AfjPshhn4Kfc57qbdrNVspN1xitN9HmTrM3pOK4zxN82I+aKPw8rKKBredTvW3w4LNvmamU1zTlHvvAdSgLqxdDVmf6qdC9AdTpV9gSwEz/OwPSRSefRgMXQRqQU3Zwas51nPdxTdCT7axcbfcFe5aeLOdcUJESR6J1JbGSxomWi/1dAilahqgbLhfIkjVrgwmmi6KdBroAhnvr14csXthYkJgFJUyyxRkO2y4nfccZvqBVynkQKr6K131vwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRVlGi6aUFg4fWa+zPLawKEcEY0ULwH+cq8ecZK/htacmNYCMY+T/EPz92p7?=
 =?us-ascii?Q?jF1VFQEyiydl41IvWgEEoUQRtKcD/JzUmYAFCbYazaHwKQpstRClYqoFtVs0?=
 =?us-ascii?Q?GyWLRPz1/M4475TFe/ibWuGC4OEWxq3k3rB/aB5weamDyVBGPvMKizjkPxsr?=
 =?us-ascii?Q?QpsiP/mw1CZ0KxzP4T2z+euH3FMyk6+mIIT2Yhbk5eIzQMVTZPW3u3a8e2lA?=
 =?us-ascii?Q?/krh1Zzk6o+rqkzfyVB+QnOZAxFeDt0iZn5lNCvHgdprbf7mqgPBc1ab72CU?=
 =?us-ascii?Q?H4TIAAH/wL1OTkSguCkMhEphNCnTSRVYrsKwlAHWU+/f+xqiA9SvTqnTQVRV?=
 =?us-ascii?Q?HLhN+rLbmn4++kaZjSXug3t0pxpcfBh31XscZ9uR2PEPe2K+3F6pEkF86AWk?=
 =?us-ascii?Q?QYrAHuJ4BntVA7bgNu7Gwdhj1wOWi28CXKrIsl4NK+IUduokBdTPTg67dEK8?=
 =?us-ascii?Q?xPZ4PeCZCy5EysVRgFsU3tP+HskXd9wohQREhJsJTIjD7AaW2r4kFd7yy8yO?=
 =?us-ascii?Q?4YyOtUT1SY/8Qh9An/KhfdrK0F4pfoDRLiQvaIvkqYWg8pvrhKBMPOgYVKhS?=
 =?us-ascii?Q?vd3oB1ylRrnIVoUCfo1g6h6iAO4kS6C7VGhL8GdhxeviARzF5gEzJJ5sQtt8?=
 =?us-ascii?Q?e3V71P+YM4Qh5CQBy5eoLHvtZPTbbb1z8WBgO0YN3ONJFiy//pasBSSjAR/X?=
 =?us-ascii?Q?XnHS4wqfjLuEVkDuSKEVmxbOyXzp+t+g5886xvaJJlYo9qEL5UxSVIFSi6O9?=
 =?us-ascii?Q?vO4mcn8QIfZNErbCK3Z5AsdEHtIvJ+bpG6MncyOVbCLt16YG1RX8DJ62Syrm?=
 =?us-ascii?Q?Q0sFknNw6RQkyvvStRJ+BH84/gl+4K1n6VTM/qGXnyopqw9OumfEIts2UHG0?=
 =?us-ascii?Q?iVlvpbeWo0D77Gcf5N8/XvzuZmAe4tJ/Y9qTqmAGDS9f1wjqOEEYUWnp5VwI?=
 =?us-ascii?Q?usB+yPttGx94GHFDYk1fmE+RXU4QLYYhhcd+m/Vx9x3sgDcuTrM9RY3aousA?=
 =?us-ascii?Q?DCVBBGhHTw7cot4VpAoxYh2L53K2n0oDD04e+vgEUzoh8zyFQ/SzeFhdGuk3?=
 =?us-ascii?Q?RO6rBEhT7hx2Yerc6Ar1pR+KrTFsHdSzBtbJjsUDtyfL84hAsHRuxBsW4aqd?=
 =?us-ascii?Q?uX0hb4eAKfzLfE1dfPxy84RWRr6MVHUBl4uvXKDAnZW2EQW1KCrpCBO1HNkU?=
 =?us-ascii?Q?aX2z10OejFMyuuBKrfs5ReKCcGCl9en1gloT0eQwLawAWWzwPrRzjNzlB/x/?=
 =?us-ascii?Q?hlTVGDtvkjTGyGzpZvLpoKYP5RwH5VDWcqslv8WVIIqXQ5SkJp4Ma6JiI+la?=
 =?us-ascii?Q?01njJrM22WwPr8r/RthZAer/XszRyXSbmCBTqVupzsOmY12aPiFXbydsqGOi?=
 =?us-ascii?Q?vlrdUdoS/YUZzO6O84cZAOFzEnLQwY0N/yhxEwJsvHyKhm+7/ibOhcncF3uR?=
 =?us-ascii?Q?2PxZrPMLzOUADhhrUV0/aq9fpvwHUmR7pVZPWkWWzA0zvC1B+rZa/mh+eRTc?=
 =?us-ascii?Q?oi1Pno+WmcSuT8wHhL1hDlV8YLE8HFjKIaRn0ierm+zxJvEPhHBHEtTwMmzp?=
 =?us-ascii?Q?uYWvD62fCPlpwb4tYkMMLxNAkrngmX+RLlQ4XoA2xByvx/up8x70D47jyS0w?=
 =?us-ascii?Q?0F0J6O793JeMr+vuYGMhacm89qU57mv3gDac2Dr43IzOPHUb4dnIT/tMuCNU?=
 =?us-ascii?Q?BoWMCC+KOY/sb1fby/eDZxoGa7JRw5xIQaQWmxwycbuirjdJ4nTtWAQietHd?=
 =?us-ascii?Q?cQIC/ow+Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f60b7-9530-4773-631c-08de7505296e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 07:03:36.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nof5ZzDF/Aoz5YRVoIFqPXVLSyFqJ4PemgG9U01J6Q4l0JKfAuiMzbeNsd+Y2dadsYxxO3b/Uup0f//DR5+jHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261191-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_std_stats.sh:url,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 497311A190D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:38:58AM +0100, Andrew Lunn wrote:
> On Wed, Feb 25, 2026 at 05:06:48PM +0200, Ioana Ciornei wrote:
> > Add a new selftest - ethtool_std_stats.sh - which validates the
> > eth-ctrl, eth-mac and pause standard statistics exported by an
> > interface. Not all counters can be validated in software, especially
> > those that are keeping track of errors. Counters such as
> > SingleCollisionFrames, FrameCheckSequenceErrors etc are not tested nor
> > included in this new selftest.
> 
> Hi Ioana
> 
> Thanks for the test!
> 
> Do we actually expect errors when running such a test? How many times
> have you run this test and seen any of the error counters be anything
> other than 0?

No, we don't expect any errors with this test and I didn't see any error
counters incremenent in the tens of times that I ran the selftest. But,
to be fair, I was not looking for them thoroughly through testing.

> 
> Which do you think is more likely:
> 
> 1) A real error happens
> 
> 2) Bug in the driver so that it reports a value in the wrong place?
> 

I would say that having a driver bug is much likely than, for example,
having an FCS error.

> Maybe we should check the error counters are zero? 

Ok, I will extend the test to check the errors against zero and see how it behaves.

Thanks!

