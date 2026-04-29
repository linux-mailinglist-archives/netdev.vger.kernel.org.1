Return-Path: <netdev+bounces-282374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAThFL3+8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:51:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E4494475
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABBCB3006B58
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1FE3F7860;
	Wed, 29 Apr 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWimlHCi"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B233A6E2;
	Wed, 29 Apr 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466644; cv=fail; b=ur5VAvG6MrviAJEhKLsX5RBEc4wjyJI9UWhdI744qsVajVzLwnwn84pZXVHbOl9r7UedNt9ae7So04SI8NeFEnqVc/Mzj5aDtc8ztVhDjkZX8ytIvpAeyTjrFu8YopHSAGp00sTeNsI7jv7o0FWrhRK+9mZWuNlGMh2PTfsD53w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466644; c=relaxed/simple;
	bh=nueObGqFVua40WvnFL/Mh2rPCfhXIF1JJze28AWinUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c4ngTG0/K9PMr049voRo4y1YJCANXSdGpe3A3FQCSVpjLmTJaqIG1xQnBRExEHcDoDlJmR5kdKuTXhCxzcvTbRE1OrLIx9MwodclJ/icBuf4sQu/fdbkyXIP4e15BPxHeCuv7gbjf8207/KPGO6RBDtY/OlqousbacuRH29di+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWimlHCi reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnyUklO38W/w1WxKAKXAxo+5Xm8X3zE4ug6Sf9Lju7KfuX0luKHiszz7T8ZSQcKpq1mj4nI1CZD6nr3sL64I4KxbrbRTdeYxdIy4mRoWFjFcj3t9RSNoGmFl2szhN8iTiMpJM+K5snSn7QgZaSSULp93/l8Rxrrb7y16g2UHALkn20cdlEcZvE2MZO+w5kVK4WrJPKQJOiRLSzOumhjQ3AtAnY2Gs4ybfwX4TKY8bZabkT8TCrnr4gubhBpFGMwvvC5HlR6n8jUbTy2+0PuaLtPwlWq7Zcs7i+RMVZ6v4MJsoBhXMi2L+648rt6dTmRnDF3xT3xvLyNzcH+TyBFkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK4cflFr5syMt/B7jRo3lmnh+4kKrJ1h0hrurYQAS2Q=;
 b=UkrenZvYcvlp2Vru3GD3ohmuqMuxBMs+l/MaWsYfw/Aoilewh6KH6gVx+jrxlN3dmIzZv83OdYzYfOJtaRmrEm+n//i52iJP+nWM2bb+EyCkGBLWoAWtlpy/KUkSa+M4Ms0ZY/i+GDzrqBRK59OBiH0a/sUUjv+nXHYZKnt702eJFXjNP/KdmGEgUSIAoR1YGzcBLpxeX1R6F68/EcfZXZezryuXauQ5a8zIrWqPnU2Cgqac7mkmiHQ6Wdp/9RcA1ApS66lawC2TRh+183+Dn7mLWENfs0hV6exex+5bXi/IIPxombWneJeKM24oZgzIzmxGHnJHF9+aX5xEXssPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK4cflFr5syMt/B7jRo3lmnh+4kKrJ1h0hrurYQAS2Q=;
 b=mWimlHCixPZ0A7i0v7I7kmhJIaxhauIegTZpOGupfYmVreRLmsL97cVqVYDFxcEKmWsoTfLdrmylBeckcb3Ta46V8qvECSbZa66ak53T7IIq8rDGIw/hVBCtEP3Jwj2/QmO/4qGOl1Y17ZdQwuolTE/sR59cNjotbq1Rywgg6apvO8WfwAS9oLVCeIxY6n+Z7hzqUsKEuh1rK4mkQ+3Q2dET7Pib+SnmWdaYIFXitUNTS0vHX+7I+EKlFZf8hVnr+uOuobm20PM4cni8X1Ol7O3zfeMiJX0GROCrGHek3xE0Qdpg4Mc9fESuOaaFCUp5iXI0QemDJQamIIPr3ZAOIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 12:43:58 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 12:43:58 +0000
Date: Wed, 29 Apr 2026 12:43:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, 
	Frederik Deweerdt <fdeweerdt@fastly.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <bq662gcnuk3yltgzg4q5w672xsbsdf3abqrej2mrg6rl74ts2v@5uv5a35jrlp7>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-3-dtatulea@nvidia.com>
 <20260428173844.1354aabe@kernel.org>
 <36csl4lgsy3psknzdpssq4zc2zsy36negybhhvfhozthhnmfl4@c6y75w6udaiv>
 <87o6j2hslk.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6j2hslk.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: e356629a-8e56-4b01-1c19-08dea5ecfb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sBfB6w3p8Jmcb40PYl0w7nY9kaZHmf7GxQOsgOq7dW7MDXfRoSa6L/dQFqkq2APrjs4YMXDs1YXr6mG79ifxIIRCAuxmocfIUFjYw7Tbdmbe8JX0S/ERUUyIUGZP+3P2t4EmW+3vORFQpWeBYwlIJn/MYU7+TLfWwP4TJ4mDFmlDFbwePkyrSuhEGspC/42WdsMT+EsAAZ/ic8Tyc1MIwnMcalGMXdO6YwCFDAsjtB2UJxFFslLBpfeVi6jPL/a8wJvLp0RZCGbxUhnsia9QU2XqHzr5Kkrl3RWV/Qs+Mfyx36F89j76txzwzHNQsagmhLyd3Dtnj4BIqpPAMXGOyyjYQBn/r/x7GZiXgj0BJq8qbnTV0UvzPVUN7B/R40sOzyrKh1Z+epYILJAEwfTSUKwt+vv2T6uShcvlgMBzXJudJtyvQ6lGKx+QNxPK3OktCs3RvEl/i3Uab1Pc/OGOfl7sj/RIEO0JJHpAylwzT94PxqAcrO1XNCO86Gj8xkMfzKVDmIqyIACfK8Dj5aqnJJ2LOyo3qh/JCSsZ4iEnW4zmBJKOw+HDA1BYIGHZdmgRuT2V/Iiw+qcbDsMeVQRE+a7ulGnQpigWMkxXTkYfMo0MGmIuy7OyXfQYJc6Ay2zt83bcbVqX5H+y3HkVFnrwBb16LMnGqj9LGg2lzPKK7RdRZiQiA1NYQr4rFEC7H6kH47dC1d4AQQiLXvQzkOoQOg5P6/S/SJgNfFH3rsVOvsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?JQnL62HtBIHJ6gE70AwWX1JO6h7bHDKoAlRbOgPDN7eqKmTjPV7+N/s2UV?=
 =?iso-8859-1?Q?ndlcAENe+IW1zlEsfJz1D4AkGYFKtd95qcLMml6sOqAEU1urLgo5WsyAG1?=
 =?iso-8859-1?Q?OLZIj0gAi7uAVUFyv9X3Q9UwuFOflMuA+nv50y2w8IDi0kn9bSDCehFyNo?=
 =?iso-8859-1?Q?pPQ6uPehQ5Pa4b24sfLGlneZhJ5MmrwdKgxjmOWVs9S7mCZLZxPw83l2eR?=
 =?iso-8859-1?Q?bPODPNJpRA6xMP7skU6AokC6yd3C2YY0G5+VC8hM40MpxPiwUnAH8Ol/7o?=
 =?iso-8859-1?Q?qxMoLVLTDfPjMpAeZIKB2xDY8jKwqZLj3eAcrG38lu9Y7SIArBEGcOdTiH?=
 =?iso-8859-1?Q?QdX1bDdb6kCBapHkJfkFS/f0+x48+vgHB9vw9kjflmC6pMi/lUfFmto7u7?=
 =?iso-8859-1?Q?wfh4ZE/D7J3ThkQWkZiMFuEc7knjoGB+aOqSANdK7h65wAiec3AipjRPEg?=
 =?iso-8859-1?Q?O9GTZafKb/ih9757KgGG4l0ZEUmaoqeF3QdwZ9yELOz8Svt/DkSg5NZjRY?=
 =?iso-8859-1?Q?ohFYSO+YERz4Vh9VZt7n9IukUjn593JmcUdHjjzMJbelxBNqYnM0AXzxpJ?=
 =?iso-8859-1?Q?zBBSAVdFSnDVm/zSV4W14lkYvHjAgvOCjD62Sg6rKd4eCcm3hCLvwd1cQT?=
 =?iso-8859-1?Q?130YJxpJZ7/T9UFaAIhjSvyBf20i0rBZ8azNqqHDl6NtNcUaRlMY2QDUn0?=
 =?iso-8859-1?Q?wRpIY1TAH+rdi7OZvUj10QX59jRGwExI+VDi2+1nWDX2VOn8VIus565mRm?=
 =?iso-8859-1?Q?bDsRa20TIHCM2pehxAj5fzGCj28MJlkf52sd185W4Pt2oNbuPi9PFo/qOq?=
 =?iso-8859-1?Q?IcoM3wBZl/EL6Jsnu82K6x2Ae2zVrESP9g92nzzbwy/jzo2Otzzo7l/hIh?=
 =?iso-8859-1?Q?XSyF5Xsoe/Lvf2wCbV5ZDffntGNzPgf63xxbzuyUJLvgfhI83dwxQibZpY?=
 =?iso-8859-1?Q?uazznsM5iw1yBk9gUvMQDrRS702bIBu/vM6lbWeMItYxCA9db2vpjj+tWf?=
 =?iso-8859-1?Q?zSAWlh9AC62zwahEzz3EBjP07kvCNmYpd78glg9gry4s02ILbJdmOPVZtE?=
 =?iso-8859-1?Q?QAsYfuxwkTWWPDS4omh+I9CBR1WExvrAOGcwYdz6cjb5LqPeerZOPdOE3M?=
 =?iso-8859-1?Q?9pBLFRDsFH2bpvLG3D1bfHk+8WO3EKdS+0Y/Sels7YA774OXPeS1smlNK0?=
 =?iso-8859-1?Q?2cQhz+ZhYubQ496I9Q5Eap4921a1Ei2yGUtDC0R1JQ/HO5+IOqV8HZ9OVg?=
 =?iso-8859-1?Q?fajbRHn+NqGmNCI5otg0s7Xy6aeUwnLY31Tn8Cwsh+mj4DYB6fmbxG1DkV?=
 =?iso-8859-1?Q?zlD6XkIq14r+V5OsiE7dbXFOnblAzOCBKWiaLTFhSWjOTFvmuWJvFeNE07?=
 =?iso-8859-1?Q?mlZICJ8itCc6KaW+3K3T9YJNukTCIKiXcfuLmTfnVxkdVLoFSCLsHfZkrZ?=
 =?iso-8859-1?Q?UOpar9UrvYwJBv7sIMbLf06RU//vFdBTkdlzL7cLUI/wNZ9yltOKjmHxhZ?=
 =?iso-8859-1?Q?9ks+cpUf8KdzxUzKKcmVzfWKOXXCy9g/4+CnYTl5EZB75UEXL+LxMKX3m+?=
 =?iso-8859-1?Q?NcgZ9Z2FSSav2lAWoi7ICX7ektGtZHFPwYcy6c6XBCANsIrQUfKlKy9ARK?=
 =?iso-8859-1?Q?Grw02VZE5M/LNmgiSjTYjNFNV2VNv7g4PYQRKg64sD7cOvGDskrked3IUh?=
 =?iso-8859-1?Q?nqt9JFrsKiSCnad7u0IXHUhvpCYzGXj1KVVFI6L1XwMmvrA1haM5JSBWwN?=
 =?iso-8859-1?Q?bHGXeklfKjRB+flh5KTiREo/HspYp8OTxsaaWq7USi9OdFYQ+NZkK5PimF?=
 =?iso-8859-1?Q?Vri3AF88wA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e356629a-8e56-4b01-1c19-08dea5ecfb88
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:43:58.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnCzz1rvh6jxj8x44JqQg4rV//mWckhCtGx9CTU5aRaGHKRQh9ZbfxT4ZTbhaDArBsI/Cp1cAf4b+fA9WzSU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
X-Rspamd-Queue-Id: 195E4494475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282374-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 02:13:43PM +0200, Björn Töpel wrote:
> Dragos Tatulea <dtatulea@nvidia.com> writes:
> 
> > On Tue, Apr 28, 2026 at 05:38:44PM -0700, Jakub Kicinski wrote:
> >> On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
> >> > +	local_irq_save(flags);
> >> > +	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> >> > +		      HRTIMER_MODE_REL_PINNED);
> >> >  	clear_bit(NAPI_STATE_SCHED, &napi->state);
> >> > +	local_irq_restore(flags);
> >> 
> >> I don't think disabling IRQ is necessary?
> >> Isn't it legal to clear the bit first then schedule the timer?
> >> The timer does not own the napi instance.
> >
> > Isn't the following scenario possible (but extremely unlikely)?
> >
> > 1. busy_poll_stop(): napi timer is schedueled.
> > 2. Hard irq pre-empts busy_poll_stop() and takes an unusually long time.
> > 4. napi timer triggers (also hard irq), napi_watchdog() skips schedule
> >    because NAPI_STATE_SCHED is set.
> > 5. busy_poll_stop(): NAPI_STATE_SCHED gets cleared.
> 
> (Nice work finding the bug! I had to jog my memory to understand the
> gnarly busy-poll details again!)
>
> You're right that you need the save/restore if you do arm timer/clear,
> but not if you do what Jakub suggests.
> 
>   clear_bit(...);
>   hrtimer_start();
>
Ah sorry, I didn't read it right the first time because I was too fixed
on the order.

> That would also follow the scheme in napi_schedule_done(). (Note that
> swapping arm/clear does mean that we can get a wasted-timer outcome.)
>
If it is wasted is fine. I figured that this could end up with a timer
scheduled after the napi deletion:

1. busy_poll_stop(): clears SCHED bit.
2. napi_disable() runs past SCHED wait, cancels timer and caller
   deletes napi mem.
3. busy_poll_stop(): napi->timer is armed but napi is freed memory
   by now.

What am I missing here?

Thanks,
Dragos

