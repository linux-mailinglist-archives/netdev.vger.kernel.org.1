Return-Path: <netdev+bounces-300196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QtDiFEG5Mmoc4gUAu9opvQ
	(envelope-from <netdev+bounces-300196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:12:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A0569AD44
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:12:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="fg/xMfqy";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300196-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88AD030E6FD2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A344E045;
	Wed, 17 Jun 2026 15:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C243E48E;
	Wed, 17 Jun 2026 15:01:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708505; cv=fail; b=SkGeRvUoHth7MZFx8Gb93pB8Y7p31sRkuMsT2qS5ecmG96fAb8WMRYIlioSwrZLjkgB5vjfkSTB0FWfdvcnyQVazWiWGq99fU/BmfYF65C0StckjaWvFI98JL2xbBa70m9VYnb/xYLA130mvlPSfgGeiqfOPUbF+rNrFf97Gwgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708505; c=relaxed/simple;
	bh=EqTSy1xqG9eIIeFPbBJoqO4RRkqlyCppZ8DkCI2ezbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSCIEzmF3FBmdJzuJKQtVL/Fh1Y+FvZyP31HxPUL3cY1ahIzmMdT2fKP3J78fbOkx7oEb1ZoqlVcnofFgYUrB77Pmk2nC/FHzOPeq6fldqzqrcnClj0PXUi5AdAyGusYTmfHXPEGfa4kl1tBn7S4zNr6OVMLtVkgimydJNlgKgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fg/xMfqy; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiTz7/hY7a1RyaP9yHt0E5484tYbOooySM2colbtGWElPsk28mLTBaAAPfkwGiMhzA1cgWrrJyR3Mw7cjrjEydTcqHmN9ofONrlBbiPbH2DJaZL53cKPPAWftTuYe+fpaU3gxSlG8/1mGjqYWVVCrUP7sPfiPbLfJfvAM+TGZjUzSbqWM2HkQb4bywyjl+ISq6AYoNUnt22E1KuP+2hbwbbgv9aPRo4NB+4lxgpjZ/ck5kixhqNib/suiX1zGQHH2uL9voNfH+ix5yoVML6t3dWCeSSc+3W9f4WY2m4l8jcXkKmPb1i7SD5bvnGA+/Pjk5v67e1uV9Ez+N2sUPOmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29SczF+3NmGQ6ipYPCtMswUm8iiNmaN7pycOvF9bsuE=;
 b=Au2UgP6Ja4NN3RPBeU8rZq3mwNDP4sqdASAx1rjkISObQYAwjndZOPoYeWPg50lPqiISKOAlJZ5kndXMtfXKPlM9Xoy6qo8o8UdgC8lrbrbcDTBwBbjvSLURZpvquLX6khbCP3QiDQ9JxZmfe0MSC1snpZcauHtnaSo7MVDdtSv4eln/BvQvPyGHIn9i7H6prAuiDVfN9NfJZQgZ1AnKr8cqOl9fwqMaVLAoqqBWMnKpZnDPralIs3d3DHDyRjjywI3gVjStmprLZ6lAosKLyQbVtIf3fuqs27njMP3YZwOQkJEanXg0FPWMx9WJi3NZqrOjk2eLR/0mJisepUYXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29SczF+3NmGQ6ipYPCtMswUm8iiNmaN7pycOvF9bsuE=;
 b=fg/xMfqyeJupF45/lF55kEvDorInxRPlA4sxon7t77sQTseUQyoVEhJJVwzkUVKgISqxZRocDF+7GI2VlLBB3+xTnRZCHymjwHjpCNjb/56K3iTYOhcqdx7w1ZjFrHwAQIkscADoP3E18ITpw103fcpbq28qonbWiD5W7amT9N8gsQ3q6V21ytimImB5UJ1IOTooMktcZ5N+kbf6wDXg8Jk7Fyr9WhvbMbY1+/HhzxGyplDB47ROQdS3wlXnf6OH2a7dpN77IwKYiH3FH63nofMavuYsRIgjgZK6Fv/Mt52pjA1VL1JGdDsYV+DfK6cuTB9bnySzP0zbcu5fA+xXYA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PR3PR04MB7402.eurprd04.prod.outlook.com
 (2603:10a6:102:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 15:01:40 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 15:01:39 +0000
Date: Wed, 17 Jun 2026 18:01:35 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, f.fainelli@gmail.com, 
	vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: fix VLAN upper check not rejecting
 bridge join
Message-ID: <nafu2eyjctiqaljagc5in7mplqmnz4g2n4yhi2dyyd2qrf7bhp@r2x6uxlnxffd>
References: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
 <20260617114518.857486-1-horms@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617114518.857486-1-horms@kernel.org>
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5a0bc5-afcc-438a-535e-08decc8155d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zbvlenlQb3lZgWKjgTdxfHKNaoRuAxd8kBr//WRftueSUjeu9sEMUM1VD0sfAVrV3jrl0Q2GBfDPrQcETPyAUA1LPzKnljyAQGttFB8rfPnE92p8yghOOqEnc1/ipo31xVXnBHZ0ivCa7uttCkSmnKpWW7iOwaHG5eTebqHQBLDJbIh1jpfOxQzbWL0MTWAk77gW3QW2Hx8MSGteyoRp1zPkJc+iPmr1ciRBd4GxYMIllpd+u5SnnTeOwpsmEdUYsNY9W/G0FasoSWFlogfHoTK5xAlX6xT7lDNI98EdqdQ58dqA5zLPDyk5ONa7zr+50wNAmqXw9yBR5TcQ2KuFsCf5quEeQuC78qeBF+Tf/UmsnVGVJmDuv37Aijo2uP8lSz/O5jORUdhU1EpAGjHQNfWFh4lM81VUqlYYKy3m/JH+SvoB2hSJ7Kxg4cqHbTtWpiZbaiduU8XblikYJmWviQGd3Ycv/WyNj7vexITxuq1N38Q4rZpSU2uqbw1xt90ICrwQh+Hij4XMWxbD3G+CqGkvNRzgKEBxRICBVTJda7/mVw5UYNOaj3/SG5KzbhXmNQooWyIKPJPbfqfry0T6n/pIWRIuPswjClJG3qlAd58UIn+BljhaMLZNKnonrtgOAlEt856Ehk6/8WfkNMxnkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1E6JqRCUBuksOSi381Q7kifKYHOv22A91swWX3aqQ9fhVqlNRkDQH/RLG+Gs?=
 =?us-ascii?Q?kBX27+tkLNwsjniOqqOoPfCJKVS20egSRZn0FbdZhZiR59tiMU0h+uZd0PWw?=
 =?us-ascii?Q?1s3eQ9H1YslvDk1niXVtKKFPugjai6dD/VdgTXPgsmwlsy2jleouLU1RanBv?=
 =?us-ascii?Q?CB/WOnxhKbA6q5Ei6D1jW9M2EVxLm2P5qIEEQwTGIqNECRS8Gm2SpIQOgagY?=
 =?us-ascii?Q?fRtyGd1D+Gfa0fdrOXZj8y+6ToqUHNIeJmHlGGJnItlp6xgbZVOFEe2xYkRR?=
 =?us-ascii?Q?Uctc7uK663uLpSFIgMTMDXwodnlP71T9vMcilQQGPrzyC+DY88of5Bdu88YP?=
 =?us-ascii?Q?flqBPmMjZulJDPrjXvr/1Mk4Y82nRKZi+leDqARmNIfSifc/DDo4j6hbs3bw?=
 =?us-ascii?Q?Q0rRVTRrcCRadJIQURr/tApej5UBHmSwdk7zR+XzLeIrLEm1JM72nA9lW1VL?=
 =?us-ascii?Q?ZGLTokreBx8StL4JZkigv9FS0gSKso0aIJAFRDLueL09Kk33jOKY7ynHJHMy?=
 =?us-ascii?Q?AxzxHdBqL/lNPPR2H3ElfSk3iUnsKNYztTETKwG6hDnNp3O1zCULK5uFqAFw?=
 =?us-ascii?Q?bhFDxJtPkAD2ILBK74bwMap+q4PInBEzQ0/BFPQ82LlvnfD4OJYY3kfjBWJH?=
 =?us-ascii?Q?m1MA1i/1/JT4ha1uS4XtUJ8tzVnnrleYGH5m+HQNne+NeRSnf1RaoxIhxXFC?=
 =?us-ascii?Q?XLxYNUB0/eOXNK9Wm9CSkau02eQnPsyJcDT8sFLWUG+gZPEhpw6ciso9BkUd?=
 =?us-ascii?Q?Kh62VLeFtVMx/TC4jcD+ewYA9i/MmfO3k/mXBHXTqB+B8DKjq7cZ3/gq97Zl?=
 =?us-ascii?Q?dQ5Hr4Ww5drxuP6LczUUxKB804Cj8daA3PeR/CwmYHuOk9557buGFl6kYSqB?=
 =?us-ascii?Q?+Qr/urJloNEDFUVnKKdsTgTzLLYeoXCbHlT9bg3a2IyXVOCmDH9CuHfSlDTN?=
 =?us-ascii?Q?mCBYv1mVHQxhD32LfaMRBSjYbD31NeBWxT0JC3N6P6ouNFWonOLvGHCcy7SG?=
 =?us-ascii?Q?qYINjK27qv+1f1o4LaMh65B/Wy+mET6kyMFtniwMU3xm+LFzcS96y8212QN9?=
 =?us-ascii?Q?GsYkRwHK02Heg2O0u+Sd1nCvoSRmqDySExgfCKR9UNYY2G6g2sUPrCIgr2g+?=
 =?us-ascii?Q?RzP41IgZ38bnGht6vYH7bdaju+fq5xHjtiyqnoYxxVxaOo6LADEjJuJJ6vEZ?=
 =?us-ascii?Q?HFT0Tcvefgzq++mrZBWIQ30AdPjIa1xNnerdnnlhqIPxiEfsCGSGlpr4eL23?=
 =?us-ascii?Q?+l7iftSy/WUyVMCtJcNsdbHNPlD8NvTpmtYPa/ZnVE/1xCuoT5+8cfzwp48j?=
 =?us-ascii?Q?VkZSuP53LFTojbkyj770j+y4JZ9n04dN53lhuPe7L+SUwzs18UnQ8n/AfLJL?=
 =?us-ascii?Q?eGj3w306/5mHRm52ZIyiO2BxDMkIwjhemoUvO4+t9zWTUiQfQwpxEEsxpe8P?=
 =?us-ascii?Q?mtxH7ZjJkT4QoEiszI2J8G8jMrTkSHBILivapx79XBw8oN27iGQ5Y/znfklu?=
 =?us-ascii?Q?RrcQMJQLvkKdoZxyvrah5/wX42L7XV2drwKCuZWZn/SZL4a3ea4D/LJNQAXQ?=
 =?us-ascii?Q?2yt3LX22yH33+PQv8Ll6fEc1HCKrx0yYoxlzPZZIRqfggKL01bDhndt4wpjd?=
 =?us-ascii?Q?dPsc/g3v5Nv1zvZqeSqXg0l9tQoP4BjVghvcfGTCPp7Hc1nQMqulGQ7cq/Lq?=
 =?us-ascii?Q?z4MdX2o8nUpEZ3oT3lxZtLhdj9ZC1nAwXa0tTqcGORNGvPcpXWcVIvU0CPls?=
 =?us-ascii?Q?LvhljxydIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5a0bc5-afcc-438a-535e-08decc8155d6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 15:01:39.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmlNTcIny3hUJeJSt2fcB+a67cXBl/Mo52aNKAlHA8JpX84ay002+Knc13yqIs06/iKCTvcEKVQuRSiawx0ucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300196-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,nxp.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1A0569AD44

On Wed, Jun 17, 2026 at 12:45:18PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> dpaa2-switch: fix VLAN upper check not rejecting bridge join
> 
> The blamed commit refactored the prechangeupper event handling but
> failed to actually return an error in case
> dpaa2_switch_prevent_bridging_with_8021q_upper() detected a 802.1q upper
> on a port which tries to join a bridge. Fix this by returning err
> instead of 0.
> 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index 52c1cb9cb7e02..46ae81c2fa013 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -2177,7 +2177,7 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
> >  	if (err) {
> >  		NL_SET_ERR_MSG_MOD(extack,
> >  				   "Cannot join a bridge while VLAN uppers are present");
> > -		return 0;
> > +		return err;
> 
> [Severity: High]
> If a user adds an 802.1q VLAN upper device to a port after it has already
> successfully joined a bridge, won't this check trigger when the port leaves
> the bridge?
> 
> In drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c,
> dpaa2_switch_prechangeupper_sanity_checks() is called for both bridge joins
> and unlinks from dpaa2_switch_port_prechangeupper():
> 
>     err = dpaa2_switch_prechangeupper_sanity_checks(netdev, upper_dev, extack);
>     if (err)
>         return err;
> 
>     if (!info->linking)
>         dpaa2_switch_port_pre_bridge_leave(netdev);
> 
> Since returning an error aborts the notifier chain, an unlink notification
> would fail this check, preventing dpaa2_switch_port_pre_bridge_leave() from
> running. Does this lead to state inconsistency and skipped switchdev
> unoffloads?
> 
> Could this check be guarded so it only runs when info->linking is true?

Valid point but the fix should be to prevent adding VLAN uppers on
bridged dpaa2-switch ports since the driver does not support the usecase
altogether.


