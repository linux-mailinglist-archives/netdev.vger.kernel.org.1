Return-Path: <netdev+bounces-267653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMvlL86qtGn+rgAAu9opvQ
	(envelope-from <netdev+bounces-267653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:24:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D528AEC7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 537D0300008B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0A257459;
	Sat, 14 Mar 2026 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I4xtLASO"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7A1E1DFC;
	Sat, 14 Mar 2026 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447862; cv=fail; b=uEFw4NoJ2Dg3/NLHCVddyq5HbwSX8RmEyDlJZmBtfd5kRNvdCWW2c3Pb2OLdAzXLcSK7B6lL/hpZLCNnVs1/PlJSZwnk6U4Ol69fXLtNT9/mRGGQfezZCukO5ArEDiSlXFIW0YNKwMQs3t0gxhBkYOpMRpU+Ot6FzKavZfA5TDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447862; c=relaxed/simple;
	bh=M6ngw5cIB/XFrioc8TH85B6fFmQU7R0a72ZjR/BjVJQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PIzJm1RRwXgYS5dv+jRqtMQaAMf+JC3PMPwBDVI2Fuo30be6HyPqvIkLDEV/MZNaZDvZWVi/E+FDz54+H4vDHTforBx1TId9Icpl/aomQL9nI9xoEvkKGmvUTvmGXqwjQ22X49AqDb5RDM8Y4yKSl3m41oMASWrOhN3b3G5NIxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I4xtLASO; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llP/8YhIcJ6TkcrNihWgKchZv8k6jc9pjJB8ZcVpZ9xSe8uDXYguQaJiUOqVW5XkeiNGyLHN6xXUBH9dr45TEqRYO5FWzf1c4e/P49hxdtTWu5c6Z3QgkX7tfPjgXRyRIq9KvSIKdWnKjdeOA0iUP1ILXtyYFI58Ayv2m8kc7Wqv/dHRH7xf1VYsdW1KQgYmC1LnErU8A1y0B4EiCeNfIgkb49RRAy2eMu9BObrNcr/3PpfXJMkFl6drfyFqbl3njQUmQOfJdyBx6CtgDcUpr8bFx4q+D6xtRk2KVtwoKf4hhFpvqpzsoTZSHDlzRyj3kIvyR4IkBCfvmwynBLCn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA9rEL1LFRQR1hrCZ3RZuGY+BRn5tbSmP+h6VmlFn/0=;
 b=ofv5tvheZXwhigf2MsEMusipHnISf2NYY0kKSDS4F0Lqkt/BvAJqz2028naXBfvrPVaYqGxyYLD1nu5VUAfSi9E2wFttwwnw+rGfvdIFfDMjdx0ggZcLH9mzVcYyFyeUG2ENn9/FxOTxWey/hzLqDApIPB5PLLLNdfaOrrvrDnBDVr0xnfjoiu0JV5iQgfktpZ4hy73ZuHoFBBlsAMGVAH8yUTbcMIJW1oFIHz1xt/n08NXHHzUgNLv+lmR7R+50qNP2f8o5wTXQYceBnrEZiTeZivMGUv9cXZXp5/+kl7cakxTsALVlEyrs/MadD4dPppC+uoAY0B+xfHxjnM5VCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA9rEL1LFRQR1hrCZ3RZuGY+BRn5tbSmP+h6VmlFn/0=;
 b=I4xtLASOfAKZuGUU0pYBen4x3mZUK/GPqlWXJOtAL3MTr+MMX7Gx3kKyPyt0VdBh+eCbPwgPuns6USxB2/WBFVHnV8uAG25TAqlcfrhbb46tB+65HMLpP0bAeryZFtCO29JO4EHW8Fi0dexbhpj8WLJ6S81jXQ/L4QCdorY/SlbN66ympXBO7i++RZwjygBJsjI25mXwC29zhXHDXYf/frmfzMnqOG5VJOuvVslPVf4FXkk/4nZtNxvrzCVIuvPi2a5OdWhFMPkos16ROiNyMIuhsLzqeAdne2wiIYAP2ZwmfgCeTxoJGxwdqaBPMnOj8/EtVZfVMhTkih6IgJ4nZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sat, 14 Mar
 2026 00:24:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.010; Sat, 14 Mar 2026
 00:24:00 +0000
Date: Sat, 14 Mar 2026 02:24:13 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Joe Damato <joe@dama.to>, Wei Fang <wei.fang@nxp.com>,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: enetc: remove stray semicolon
Message-ID: <20260314002413.i36jrsuih6j2lmtc@skbuf>
References: <20260313112454.427191-1-wei.fang@nxp.com>
 <abSnSjp7cIj/qWGG@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abSnSjp7cIj/qWGG@devvm20253.cco0.facebook.com>
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7cccf5-4a37-4593-51d5-08de815ffcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|10070799003|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	56eyVjrZsLzmpbFoFYq3RrVmw4kqmp6oKGjx7p4B7GAj/YwDDW3rl/miIL3PN8RM2WIQtXkk/U9ha21vGxeJZfJL2uHKsNDkz2IOzrApDxbl9yIvjuBFIKqnxZA486iy/yt6UFz0wE0MK9xK1yczicwDz3PZROmGAzXqp+VshtGQlCrDfmYw72bcKpGuae3J3xfocGyczXLOLqZBLvOqN5cZccf4ENjrxu2AAPcYcHrj0hArEj1oZrHf3FQuH9i1fcBDfLR7TyML8G2Jc8dKXGMJnnI0UWBPBbebfIEJJ9F1xxH1ouVkMTQIrfdT2f/enQwUYUuTZHvHfr9zSAl7K4IprONwN/ErUMzodSGlu8xJ0C/WlBUP+rAhHcvE/Vf6192DqOfoPgNE3euOwQ1EZPWQe69F+RwEe2fW9gEu8gLnZGCAkKHeXMx04Iw4kaXVpGMaqGanJHsizsZis44jL4KDPoUUKt023CQ9zUXvxuP8aiCR3eQRaS/MbywngqHljW2GSjU1Rm1d278y+LSdOIs+aO3Zr8JXZwJ1xojVvnAFHhsMv55ehXWK9Q2BMEa1BJD5T7izt9/3AI032wbr5bB0nFfCmIHvhP2DtGH4k5e0tJDJ3L9EIXEhTNOAzBq65xO5SxgNQIWfeabTk7ZOQu5AERpv4gHAXGeDS9JFwr0pVyQMmk1bXlaZFkhwPO2TSRsspxIbK79AfMwFsiA74fqJxiC78T681S0TcPCgS1rfScJPpOCI3K45lH01HGeOblBIF+sCs8OJ3I1bHAx9PquXVuYnbf0DXj5pM5/+MXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(10070799003)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQHAPvm2gMqwXJCd7Wr6MBZ+w6o3aX/kEFSBVovX8LKVdRshGr9E+xN6sCkk?=
 =?us-ascii?Q?dD1hyKjV/11j9VVzTQS6Zx/m6D8dHYNn4t72D7xcDvSBkZjHmMdy9oRZfT5z?=
 =?us-ascii?Q?UFjJu1xC8lTJZ38JqeED7fON7L6AjVwZR9Wxi9JxXPbJ+rGJ+3x12v2+rLv6?=
 =?us-ascii?Q?jMNAhpOcJRKQi+j7hY73HaIb12w2BW1kHpbiU0V0PdiFS0T7nFcSwVBvG9WV?=
 =?us-ascii?Q?LXllqFRWuchLe8+8n2oylggUN6tjz9Q7IovlUzx2kHWtu5zL5tOqB+X0/lRx?=
 =?us-ascii?Q?t4EacnsFSw0CFhRBzTA5VRX5b/2bbRDo5231Z6XULvlCxYboxJ791Do2U3a5?=
 =?us-ascii?Q?lcBvZ6NhK901IcPfZwKUWOz2LnWt/NZaDQD1MDUlPiHT+tOY/iCEJnFq8TWc?=
 =?us-ascii?Q?TZWqOyWkr3DoXkT5yhq0MNBvJwKnnYk+pwLxkIOJSvcoD1VchfAeskY/c1RN?=
 =?us-ascii?Q?nmcoZZEZ5SxjPHTsXMnK8sXc8lV6oDFdqzslY5xY3K6zXquWk5ou1QDg+HDv?=
 =?us-ascii?Q?3HpU0JOW6UUP7yeoaMrLWINwJcBlakuTuScgQPur84DFheP3EFLS9qP3raAG?=
 =?us-ascii?Q?T6GKcjpVdX/9Kht9ksU0BfYXeUZiJVIxkGpTuMyIyRfGx86/k13l1ckF9dBQ?=
 =?us-ascii?Q?2FT50mKq0B1CgSFd0nU9Oah6m8kHnFgLz2fH2nY849AxqtkBpwGW4IGckxn5?=
 =?us-ascii?Q?sHcOywsC+rFmPksfTVsV6ZBMlcWRz3fTic0anh7ov7O+btm09RrcQGgB7o4I?=
 =?us-ascii?Q?QvylG6bhh+6rxaLc7Db2JtAbnepbYTWuU8FpyLLQKmLf47ssLhEfGKBWdFmH?=
 =?us-ascii?Q?eXyV1uRkkkU3Wx3vEtMym6WELh1JUHPO5zYDayZQ52mMhn4/gCtt+3idfWuI?=
 =?us-ascii?Q?klIrvXgbAwkoB+xAmVdeuOuooaF2vAcMUKpNPQhjcmJ77cDNEhH+649sYe2/?=
 =?us-ascii?Q?v3CjHhGJ3eTU8thrld8wIuddh2alWEeh3dvlwN4OGnn38HLnQQKHAjqKRDYk?=
 =?us-ascii?Q?hNjrQjoiOx0paaQ+IEcL8DDeULr32yiNjpPVd9vwSdpLMGmd9RMKgu4x7jeS?=
 =?us-ascii?Q?dBHEbm8Zn226+3JtdZctF7KlCXtyquezGIOPZvz7ebqd/9e+FVjVMt9SETju?=
 =?us-ascii?Q?DRkn0+Rtwyc/EnBKmcUmFBQJcByoLLPejxB8OuTVDfd35/WOk/dbasrVbbL3?=
 =?us-ascii?Q?jQbAue75myP4CTMnS9pkpSI0sr1Ds4gw9DArPKl9dd3XWXUcc4IW4nXqbMpZ?=
 =?us-ascii?Q?fkIt1UZAIxblT+7ipUHNGb3mb2HAwo/jgdFN2KNlQvQHFVJun2X5Cu58d6uu?=
 =?us-ascii?Q?v907+9PBGJYzS7tdBST+2DjyO+RR84DTitbAJLir4RRzvJCgU7pTcvFE/YG3?=
 =?us-ascii?Q?9t1387jOHy7i7Gx6ly9Mq+cOTka85XDCsuRVwgYvbYO++lCuOnrqaThPLBWE?=
 =?us-ascii?Q?SZbN7QzdClfP2mweErxIuAxzoYex1bQgkkV1cJI8o/2wyGWVL+JQvpaDw2TJ?=
 =?us-ascii?Q?V6oEnHWIBCHTAccBztGyIOtCLBgwfhRM9zjcq8l1e1Uh2mHJeYor5omFf6U6?=
 =?us-ascii?Q?RlibzdjwUUorRrLeTR4LZ7OE43TEAJ2cutBEvA2MCKPuCm8kbFWJlgps6Fps?=
 =?us-ascii?Q?CQFeUTNWjQc2qLS+1UN+TWgvF2yRpzF9HgvsnbG1SOBrCveKu1iK+EY5nvtd?=
 =?us-ascii?Q?SRSRoXm1HQXI1fEcza2XnWl4SfGWm/JKEuNL1gwMvj/rrP4+qysbXbRtaHdM?=
 =?us-ascii?Q?Z8PXvf/PSnbKnB/IqDFr1c58dC7Dsx+XPMuNsZcD2kI35dg6nf5Yx+7adHHG?=
X-MS-Exchange-AntiSpam-MessageData-1: 9sGB4p0iJi0U7Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7cccf5-4a37-4593-51d5-08de815ffcf3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 00:24:00.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iDrxT40Qvwc++O5Q+SC42yCJXhvNhnVT6OFr1xfHn0hHDpcU4yi8JGoUpO9QycGivA/QfD7s7ly+p2Nex9r6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267653-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD5D528AEC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 05:09:46PM -0700, Joe Damato wrote:
> On Fri, Mar 13, 2026 at 07:24:54PM +0800, Wei Fang wrote:
> > Remove stray semicolon from ntmp_table_name().
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/ntmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Hm, I'm not sure, but I suspect this might be rejected due to the note about
> cleanup in the docs, which generally seems to discourage this sort of thing:
> 
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

"simple clean-ups, which are not in the context of other work"

The ENETC NTMP code is under active development, and Wei is developing it.
The semicolon was added in May last year and was found as part of other
review touching that area.

