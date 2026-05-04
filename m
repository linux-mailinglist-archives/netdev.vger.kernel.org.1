Return-Path: <netdev+bounces-283802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMIaGayE+Gn0wAIAu9opvQ
	(envelope-from <netdev+bounces-283802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0067A4BC731
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF82C300682F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346A36495E;
	Mon,  4 May 2026 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAhR9l55"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216A7081E;
	Mon,  4 May 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894256; cv=fail; b=hLtY5KDTbPqU/GnJNlAk9SIo6k8Kg2uY4ZpvDdSYWqCRI/cN6hZL9wBU2ZLRcWMZyzi075U6dP3w3dEtFb4N/SOsXdDU0g8oYKBaiydsOCm6D15GJrr0/qOhCHfu0JzuiH2ukeaPlyN7h2T/71enYJtcyBkBfLFiJxf3tSnzS5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894256; c=relaxed/simple;
	bh=oWzayq6LGhaJ2G8w0lYZr7UoX8BMvQ9hjR9X9aYQskA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqySuae3CHRI3t5CjR3DqewmwPrveDxfbqHQGLM4ggxtFOofwZ+P+K1hjrwYm8HxhAPfUIKhrm/DrajeUVPIn4uQXU5hH7oq+leljit2JwOaGacm+ZVANzbChoOzAGO/v/P6gC9PExzdh8vKiw5gH+v4pHHUWbCnryuaU8Pl5Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAhR9l55 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz5QaBBurC9Yr1pz6rH3FcSCEBXiTES140jAXJtu1IrUxgGPJWNgXGxmmFzfOLDq1o6OxAAAqCp644kvs2HgMLhZZ/6QjhDZ/S8SfvbDVrEpi47GfkpQo+mAo7T/9XIBUtzgFw8pqPEpL/XTFMU5lzL3Fm00pG+KFwy2uK/nm757+suXGjBsR9s0PBaMwp+3/wpwZXXdJ5T4TDJCZcK/fhZt05yEnUKRiGH4X5tdvWz20bzumNhS9mNpFrvRJgsEmNNA1x4wJkPCLzHV6t3iLaVmvpk10nE2nN6fuIBkLPyGCWmmvf6tRzNS5ppJLRPVgCArmQoYw8Jqmx5cxDHVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6BU+vNc3OH8GA4MsMBAWYVjmzokyff/8jmBrwBGNMM=;
 b=WS/Rf6xdabw1Fjv9RbN8I+kSVYcTrfGCywAO+5nDZGtZiFV5b6/6mH+W06hPQQKu9YZyb7EC5NbUrcJpqGZ6Z/bVqpyuzFqP9Y3/n09peG66hyeYmf+o9d9/S5EmXT+m3a3QMmZVEmYI4lxpjXNhW9iTbCBCPzPtrHideULHmyCLsvO3hSCtwsWYdE8RJeBbY5t+fIaCXko/9fGOc44Uu4ErNIOOreKopyo/JOkaKJPr7/MThF9IZTb3tJnFQZzC6XxqTf2ZbdReMMIcsDL1xVGGNvqRmwJM3YKmlw7zgM+NhdaW3E9z8PzwfaL/gvbOB2dwJNo6N06daAH1IzoS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6BU+vNc3OH8GA4MsMBAWYVjmzokyff/8jmBrwBGNMM=;
 b=AAhR9l55KA4oayurv29yWj9Id6E1lt4gY8FkqNr8ztdcKuxL4JNYPf3hmq3Zq/e9zsu7w/WvxOZYuKP59zQ65y3ZfmNIC+mdb4AjaO/yYd9RnjlnMlrva+64O4kYMm/Ppe6lVbxf6t7oIr08eaKUARs0tLW+aCUwOkgQGFMUoaTaNL7Xq+ObfFmuG3dCVr7UpUZBlSv1xwzTkZ5JSR2hZpaeOcsYiFg/kLLJ6qNKRZ9D56Ku5qMOEzXFtmGg8RlilO+dlItrj3WW3ijaHXwQW5adA636IW15dKEJ0IYBp+q1wU9CwWVo08VD+8iW8z52DWY8P5RA3a6YlFfeLRdVrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:30:51 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 11:30:51 +0000
Date: Mon, 4 May 2026 11:30:47 +0000
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
Message-ID: <4onzzvtgdyj5k4himhtv4dsga4dnunk4ppjyqgam6us44biear@7vvozjz2ywrr>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-3-dtatulea@nvidia.com>
 <20260428173844.1354aabe@kernel.org>
 <36csl4lgsy3psknzdpssq4zc2zsy36negybhhvfhozthhnmfl4@c6y75w6udaiv>
 <87o6j2hslk.fsf@all.your.base.are.belong.to.us>
 <bq662gcnuk3yltgzg4q5w672xsbsdf3abqrej2mrg6rl74ts2v@5uv5a35jrlp7>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bq662gcnuk3yltgzg4q5w672xsbsdf3abqrej2mrg6rl74ts2v@5uv5a35jrlp7>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb7112a-8e81-457a-cdda-08dea9d098a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1h7MBBfJR4mes+0x9QrRO/JUnCqcvKhKr+sIG3mdyX6VEZiUxEiZZpMeVfRxqxqy/ENvSmLUPA/7vpWGMMDXUF5+uwPbn0WHkjfdyGqRSN/0wzudmW1iGnIpUnfw8un0ELykyEkINnlBC1zQI8rFMfuUEWoHS6gAmJazhFygsiW5QZM3o2yJ91aTlovEAkxfjkrFK6aqXUpmKzdDQLGovScoPWSmeOUoUG4IQQ3TvHbKJ8WcoKE69dONm7iFQdrrdqPnT6n4TvC99zB7xqSeqm1l60beI+2npbbf7lcQpPrwKkqqf1bHFPqR9Oq53AAWzsNGbAdiflwg0YUxy8qfU0BmIfJgTfDSgoWDPa6VDqmjxo7ZvXca5Ev1duf8SWdcp+58zJQ2J1X9Pvu083/JCKZTX06nKvYPmJJBRmjDT+eQLGZKLlxO7rut1Wt4qmRUaLiErcQepUMsOJNQbHohd10N1VDqd6DqLU5Jv+LtXF7JYcVezpQMcqZsZOJ6x2kGgec6DDQutqzwDXL9Mvj1mat9n6aUdzgZFC9fCaXpCiFTRJY98UL0BAwTm6TreaIrY+2tjUw39P5L+jCCpc8G57JVhbpq8e/BxuV68/PrChMOWq1FPK4v7OdkhoNYbaG80vtUeca+rMPPp+IwXi8G3iytQ7UhAVYHaVmLI95mFEKIu/2ccZFqjdMgWBBsWv4s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zsPAoFUcqIFrvB/8kV5W/9LQ9f5sfcdRgL+FJqnfD68ITSCR/zih6k/UU8?=
 =?iso-8859-1?Q?9JBNfmfE485Pjq0GSXAwZJvzDl5RiGG0mWsArHLQcc/D7bfLeyKGBVh4i1?=
 =?iso-8859-1?Q?Uq6q8yxWSXHjeLV4Hor8fVrtIJ6cw98I1VeT7H//ad8wMIrb+oMuOlyPtG?=
 =?iso-8859-1?Q?mSqErabp7rRX+gP29H968ts+kHVORYptyb0DLkELDZmNU0T4pCsdE3bB1R?=
 =?iso-8859-1?Q?KvORsHg5oGufCpQUgDshwVQQE3i8obms/JBBTopRQUcp99KAqNJLiWa/Wt?=
 =?iso-8859-1?Q?/VYliK9uk3x13NSIhCpdm2jBAAk/EwNHUq1m56P5MNKflECgrto/t+ZLFy?=
 =?iso-8859-1?Q?VuXeG4ZpOti0xxhlq8Yrj6rczf1vcqRf3FG1Qa8SHZoVnd87LzO83geO8M?=
 =?iso-8859-1?Q?bI2cZBLq2Ejys/6GyIxQ8e2m0/2GypeIDu5LuPK42+jZEIuv8V2bH67f0M?=
 =?iso-8859-1?Q?+gnh8oOzt0jvtopReitZHPA7HuPp9EbCSFzTPmiss+9+pDpc6r9TxoBWN1?=
 =?iso-8859-1?Q?vSxGxjqsJrECSi49NZN0C7xYtPd4yL0ZrIHSFa1kDKvqIAnZt/B56/63+x?=
 =?iso-8859-1?Q?LokVM45LS1Wf0w4AZhsB9FkD8/S3AOqSt06L60BhfuVzrIYuoxqdIBRWQS?=
 =?iso-8859-1?Q?nQWZw9lcQate/Mm2tdxaTG8M1K01e+QlfACrs7uv3drI5LqU1vB2XzyJKG?=
 =?iso-8859-1?Q?V6xydPng69N6iubxXvOZoDLLL7oHk3nlGMB58h1zks2RIbI51bInoyRGAB?=
 =?iso-8859-1?Q?Yr5B/hDef3byWDfcxs8CahdNjPXgpdxAiKVHvUsr4MeEt11QZGvuM4E1Uk?=
 =?iso-8859-1?Q?nde5IMMlxtn6AA4sm+5PbdiJQ113qxCmH5Hke4ZR920vl6/SE1ldcqTl1r?=
 =?iso-8859-1?Q?vayluEde9qd97/Wg6kysVGv63XaIeUgCm3+mF4Y/+MJv6fYJaIhI5jpxHA?=
 =?iso-8859-1?Q?+V9ZAIy81VRxey0taeUQ1IP09W6gblHmYj5CXsU8e8J9jJRAinVemlACWu?=
 =?iso-8859-1?Q?dj2MvFMc/iIjjZy9CvYDE5ahdINofdOxe22n3QUU7f/wOKOH6Zd3tFC8+V?=
 =?iso-8859-1?Q?MkUhJrhp6cCPJnEF8stfljT9RWZtnERlpI6B4JK9yKL7Xt5vRX0npXPnRK?=
 =?iso-8859-1?Q?zMwHLZrdiTjJhqP7Sf7wXoHgcMdUWV/qZrWlqHLrmM7G70iZ/7sBdbaE3a?=
 =?iso-8859-1?Q?UvOr78MgewTqREEWBIDQCwjkHtJFa9c1wn0E3OIQfiJ1rewPb209IOSIta?=
 =?iso-8859-1?Q?MMZ8+o1USx7h4mKTQZY70W2pteAmxsWKx+gsjoiMePYy5TZr41E5aaA9+3?=
 =?iso-8859-1?Q?M5bpGhmBHuteb81lPVZHLQVV4glXNlVwOkYP0rgQSYYUm5J1OLjr8uhpCC?=
 =?iso-8859-1?Q?QRk2vqPRHXLhPT5HRTzhQWNIL88jOpU6U1LiR+xdiLMQtEoi4/tqWc3Bli?=
 =?iso-8859-1?Q?47skkiQzVEaJT5H15YQ4RpQslE18QIlFPrvGsahRQX/no+mN+Sa1JQ1GL5?=
 =?iso-8859-1?Q?fNRc1fOcumOuSDEJOt3yn7oJLRhAoyKlyttRfa01Vg8I3FFST2HRUv5D09?=
 =?iso-8859-1?Q?Kpd8e8NG+Z16omWrsEipXharucYGDpgVEaNtWj1NYCreyQyoHQdhiEhXh1?=
 =?iso-8859-1?Q?d1mR9zxVFzjC6GKd8fxocJ173zklfSVjrYFNV2hc+2dv44rWPyIkq0AIvT?=
 =?iso-8859-1?Q?WoGwZJMpmW0VVKk58uVxE47VcC/xdDj9f1DmUih5z+mnwPthSrh96scCOH?=
 =?iso-8859-1?Q?xt82JkQzPhC8XGk3h2u30/PnYQopOccNxwHhYn4c2/NDK524t5QXmOFkGt?=
 =?iso-8859-1?Q?wUB9ce2kJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb7112a-8e81-457a-cdda-08dea9d098a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:30:51.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +z6tCACo8FATzFDhpYBuHJKBOqY8iPAE1EhJ8IQ3gNGOqrswPG6JD48fpEczi/w4G8xbm/PpXVlU5aYcxpUHxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
X-Rspamd-Queue-Id: 0067A4BC731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283802-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.962];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 12:43:54PM +0000, Dragos Tatulea wrote:
> On Wed, Apr 29, 2026 at 02:13:43PM +0200, Björn Töpel wrote:
> > Dragos Tatulea <dtatulea@nvidia.com> writes:
> > 
> > > On Tue, Apr 28, 2026 at 05:38:44PM -0700, Jakub Kicinski wrote:
> > >> On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
> > >> > +	local_irq_save(flags);
> > >> > +	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> > >> > +		      HRTIMER_MODE_REL_PINNED);
> > >> >  	clear_bit(NAPI_STATE_SCHED, &napi->state);
> > >> > +	local_irq_restore(flags);
> > >> 
> > >> I don't think disabling IRQ is necessary?
> > >> Isn't it legal to clear the bit first then schedule the timer?
> > >> The timer does not own the napi instance.
> > >
> > > Isn't the following scenario possible (but extremely unlikely)?
> > >
> > > 1. busy_poll_stop(): napi timer is schedueled.
> > > 2. Hard irq pre-empts busy_poll_stop() and takes an unusually long time.
> > > 4. napi timer triggers (also hard irq), napi_watchdog() skips schedule
> > >    because NAPI_STATE_SCHED is set.
> > > 5. busy_poll_stop(): NAPI_STATE_SCHED gets cleared.
> > 
> > (Nice work finding the bug! I had to jog my memory to understand the
> > gnarly busy-poll details again!)
> >
> > You're right that you need the save/restore if you do arm timer/clear,
> > but not if you do what Jakub suggests.
> > 
> >   clear_bit(...);
> >   hrtimer_start();
> >
> Ah sorry, I didn't read it right the first time because I was too fixed
> on the order.
> 
> > That would also follow the scheme in napi_schedule_done(). (Note that
> > swapping arm/clear does mean that we can get a wasted-timer outcome.)
> >
> If it is wasted is fine. I figured that this could end up with a timer
> scheduled after the napi deletion:
> 
> 1. busy_poll_stop(): clears SCHED bit.
> 2. napi_disable() runs past SCHED wait, cancels timer and caller
>    deletes napi mem.
> 3. busy_poll_stop(): napi->timer is armed but napi is freed memory
>    by now.
> 
> What am I missing here?
>
Gentle ping. Once I understand how/why the above is incorrect I can
update the patch and send it.

Thanks,
Dragos
 

