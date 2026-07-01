Return-Path: <netdev+bounces-303533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lcNxMMzLRGo51AoAu9opvQ
	(envelope-from <netdev+bounces-303533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:11:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A996EAFA0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:11:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=K2MtqGJE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303533-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303533-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E03302F6A2
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5127B35F;
	Wed,  1 Jul 2026 08:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B13D410D;
	Wed,  1 Jul 2026 08:11:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893486; cv=fail; b=WYg2Kv/yQZqnMJ7iHmTMNHldmeYky+VpKk4ZrQzOcibu8G9hqzDRBpsr4oD+eFwHTTofMDh0aFdp59vwiscqdTrMSLhwjCliioAndSbQ0/WrbewpzSRCafOrwb2pxNZGkkVPafhYqyCwQw4mYS3A0zvfMeunnVHUt8Nil9zTYk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893486; c=relaxed/simple;
	bh=orSdZX3uYmmPDnmhbDJD0SJCxZsU7s90BVyj475F7Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FELN8uZeTiZRPdx7ggAP9qF+VnSYlwHXTdTsPayb4FsJiXBoDbsHv/CVrpIphsXNC7fj0OYFLp3Jl5gdzvhvn8AwczWFnjq2BxWz4epPVAQdCRyZfe3bs9vcML/08JuaNfZ3dbsIybsFlyEOmX8/g/6GMMBRGeAcH+F16k9xm+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K2MtqGJE; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C24RGil4kuijbojsWBHaJdOOM8gECDHc24ecxZwS8A4ixnzRhq/pDyLB0L+Do2DkLDsUyaA3n39vwEDuhOHEMyKVHDZhXy9wJmbNsUwE1b2wcjX4Xo5dnAQGemjuhO68HtYEwu7hgur57Xha1eCXYSXABivIwgw5+VwVYkoTxzgnbu9F9swGZ80/95gg4oKTHuE62PfvVItJMniz1Fs8zXt6ZRCkra4Fe0mQmBUy3A8RtVXGlxPrBenn2McxJYayuQZ51LML1Ks54RgSzOLhOfdl+feclqSSdO1Rd0po8d+q1ZOmDKcUf2vi/cRASlyTsuNDqtV7jpP9xdj6WL4sDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqXWxLWfyJgyljoXutyulpjX7Yh3Vmhc2IAaL/yrLSA=;
 b=k0vMnImg5mD4V3jp9b9jIJFs5g8W2Bwt+x55T8IEXFDULgxBfNv+tv6GtEWpN6iR3xW9xCdQ//TXBN/8UpkH2+r0LSrhH90sfTvvx/XVhL9ogCO5hL7DNoQHtZAQBUnj4Yao9vOaYSGxUM1H+c0EolEc9JdDzca2g1LQTR7mfQU3nUa/7OVL7IqqvKkp/wd6Kky9/4PJe+KbwHB9xmNYGJ4L7efH+4ycnXKGp+jEO1XUwBlMZN/7IxLfNKrsOY4p7m5TWdHAm9SbC68Kgo7aI5h0iSKT1/6wENs3eF+uGSgjhH2pb0R20DTERmQMoNakXnyK80GtIP9ai+w7+PmyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqXWxLWfyJgyljoXutyulpjX7Yh3Vmhc2IAaL/yrLSA=;
 b=K2MtqGJEG2y5Zi6E9cPlzYJlja14AZQHC2RwWO2NtQog0Je7wT+R7jXdhFL/lNNUtDQFiBl/qN/rQK/FcmwY1ATe4tX9M7LZhmtqXic2R0Qp1MTakRHFypMz9KiRGurO9IAh2n7S76LOem5SUXtA5NMiGlcErr58J273fnix03yuPjgJfy3mxdFvIJwW/ukzO9fKdbMLS35pdhyL5aBtDPHW/XG8xHURgX3Sqpy6k0E1jHeMxCoVfa22wHsyvupyuzGO+mbl/8i6DxVfNHuII0Lf70+RjXA6vWKVbjMEftHf91I0vqU9LQdwsEnc3NYS+L0e8tGG7+BOZnJVA/YPDQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 08:11:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 08:11:14 +0000
Date: Wed, 1 Jul 2026 11:11:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, jedrzej.jagielski@intel.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, xiyou.wangcong@gmail.com, yuyanghuang@google.com
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
Message-ID: <20260701081105.GA1289614@shredder>
References: <20260630165934.GA1227354@shredder>
 <20260630211527.3365952-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630211527.3365952-1-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7bfb19-c8c8-4df3-5a51-08ded74851b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+WVSsESdjXlUd+V2Y4LxsALweTt0wSa/VM9XtSdjUoIuuAG827cZ0MRcdGrcIOHBiqrUT6mh+Ltdu6WmB2AYpncGb63iyZ7p8FKIiiZGsWJQ2M29MOt+TbdVnzBsLugY+QfELQMvRrHnb/flqQWnVP8tXu54kE+jUruII8vXFKTzKuTP1H4KF3SHYzOhZVaqcc+o3iJltd4N8ILgm0IVymNLXPgDqlv5dU5EGxw/AxnVX/eOy2BrWRMz1deMVK+z3w21GWCKF8VsiYoNUYLsQFogur3P8Q6inyqyeyi9p+S8QtRbumlCcGjBJOmlXyZsRizQStSDuaLeoyks+ceTajcTNjYeTgUWebTIQqPU79wVaKg/0yCZnUzG6ZsaeWPORR1mIimRjYwdVd6EveG3ptHJHIBcgm1sWFhTSVK73O1gBoxmBY+toJQ3+lsdbcBYslyy1XSS2VEvxSu3n4mR6ZM7KZgToOC73D6VKRjh6p8PEutdNRfieUHRKooBw1PDCNUGUtTMd4O48oq/6EshGNTNfi8g8SEbY2QGUW6tC76lKb32WOUeE3AyjpwroxyJLGuVh7xrgx4DLQvsfr3NdaxehilRFQJ0f2cm0PK6AkcpVY+XkbVXiXLJaUXtrNN+1NJTt2QRq42G/yRPOS/OBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZ4Hlm16ajx7O23s+Rvzm8lfUQllShwxz5C/dbB3JfwAH669l/R6dxHc27xF?=
 =?us-ascii?Q?5Rx8IsbpDYDF1Fotuunv7vg3TKCHueRemOwihDPHf+3pDz3IhDAU968BkHRN?=
 =?us-ascii?Q?nwEDGY4lVC25pILJJqn35nSItCl+0/MOWW9D6pgDuCTeU2CWeEY6U193Dt5p?=
 =?us-ascii?Q?wRioq5npqkQXkKmIu5c7Bzdc65QNfkz111ZASiOJDulX/gXnnw5FEt3PFnne?=
 =?us-ascii?Q?7+N6jP/fJlvYQKPys4iPlpElr1O0/YQ9D4EYXSP/7HUfZ+omuaYCSk5EwFaV?=
 =?us-ascii?Q?hyBuFEXBWbDZOJYcVDoZtquofbfhbMY5WCzz8xAx8JCty+z78vueWeOQdrWy?=
 =?us-ascii?Q?+Hm82Ynf001lfmgNgqFOwQJTVtDOwC+9m4gYuC4XfaYY+N3mq3akFPC7lfRN?=
 =?us-ascii?Q?3adyGXwXuMtSDPdqZnzkikUPdY3oVuC0ek3sxulU7I+shgdM9veKR0ar5Gjg?=
 =?us-ascii?Q?oZM1mPvg3++FGKDxmYt62Nd0kKmJFPRSCGRwzznmej6S7nrwGZ3W0+rMCbNs?=
 =?us-ascii?Q?7Xy0+9TuSaajm2naS19WZRlJ6skxUVIGoJgpBICoFlkd8ZUUnPnkQ4kqnUPG?=
 =?us-ascii?Q?IAoDvv1PoUB6N4oThtKNqffiZyiUrBEMWmC95qhl+k2+tlyOfO3IPbRmlZlX?=
 =?us-ascii?Q?4qHFFQykSZuB+7FWYTBmHO6I8DEeVRHyrPvoI2J6KVnIr8kD7W1OPKngAfMN?=
 =?us-ascii?Q?tGmFfVcOJot0/pacM4Ivso49ZPS/aY/CAWgaaBnLXpSctkwpMVeSQqjIgJBo?=
 =?us-ascii?Q?kOXVizkyeRLcyKkLeXpkgf3TvAddhGltF+FqD4ZuPFbwlkGATpIgcyN6dshh?=
 =?us-ascii?Q?NLDBp9SQ9qicNk0w7kC27xwk+Z0Jx2r3SriOA4iXuZ087E/jFkt9COV/vmu4?=
 =?us-ascii?Q?w3COAk4z3rj5kQe9p6MzN+qgJVQZ/jkgpuV5XGZIHHSupPNILnaZ1VN9Czeo?=
 =?us-ascii?Q?ryngMl54ghiaoZPjA7QPY6uLZ/pI8Nf6VSyv29OurvHWXwbSo21S3eTX7QRj?=
 =?us-ascii?Q?M3C1/U36c9FLc8GgGOhPyctUppZVIjroCyWnOc706VvWCxu6vhhue8kpxJtB?=
 =?us-ascii?Q?93CNUpG5GBKZ56KgYmFcrh2lJvTiS6svcG/7zKnd5uVTNlx/9Jt3kX0hIKTW?=
 =?us-ascii?Q?u435HYZqMI5Tpq31ufZEnky7C1CefOC347tzp92zoPV5gIGyxpuqqBaFvzHd?=
 =?us-ascii?Q?evaNJIuyn2qtJMOFxg4CMY3kBrZiwnoAzvvQAN8ePwBezJC3DgJfeFZ/L+4j?=
 =?us-ascii?Q?hlvQwmCE3zdABmpYRg48RZyzYEDv55JOBl0O4Uu2ikcdvKJmj4IsinQN28LA?=
 =?us-ascii?Q?orSpvQqYJfyW5Va3hCx48fch9l4aT9zSimX37ZsB+rVBanUMi25GWIWIPrZv?=
 =?us-ascii?Q?/jDkjEEvzXLePbjINfcbyNVYhinS/1TJ42BPBX4Xq5A4h55MSkeFEcdK/U6o?=
 =?us-ascii?Q?8oMkD3uM3lO0ha2jEyVEvzKMqkpLySC+ymNBfp73rpE3TxebjoSft6bnFwLO?=
 =?us-ascii?Q?n2ubjDgwR3uOWEwIvJj6mTOa53sAaz9H9n7YRT0bQFh5MiY0OLsYcCw56fqo?=
 =?us-ascii?Q?aDRJNMnUWCwr63HzVGqaFNG2sN0/R+9qumZLxQ2dFAxLo39azQnFG8Es0OCB?=
 =?us-ascii?Q?DO8Vd7q8jxFmgHg04suiIVqsE85vIhP3uJ85UdtGjQCBg+J8+sl+6hUKLaAV?=
 =?us-ascii?Q?bhDDZxskkixYbHfpYBslkSoPDIN0Urexb0S/6HjMsrf459mR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7bfb19-c8c8-4df3-5a51-08ded74851b6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:11:14.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVcio8p98E4bfgNY10tqQ/1Am2ODSGImIBI2L0M5mHRadraxwVVwAQcJ5JcA9nva9MakDS7N/vm5Oc9VHUunOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303533-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:jedrzej.jagielski@intel.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:xiyou.wangcong@gmail.com,m:yuyanghuang@google.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,intel.com,vger.kernel.org,redhat.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38A996EAFA0

On Tue, Jun 30, 2026 at 09:13:11PM +0000, Kuniyuki Iwashima wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> Date: Tue, 30 Jun 2026 19:59:34 +0300
> > On Tue, Jun 30, 2026 at 04:55:22PM +0900, Yuyang Huang wrote:
> > > > Hi,
> > > >
> > > > why sending this to net-next not to net if that's a bug fix?
> > > >
> > > > In the v1 thread it was said
> > > > >This is a long-standing bug, not a recent regression.
> > > >
> > > > so why do not cc stable kernel to get rid of this bug from
> > > > stable kernels in such case?
> > > 
> > > Thanks for the advise, will send this patch to stable kernel.
> > 
> > Please target v3 at net and add a trace given you're claiming for a
> > use-after-free. That way we know that the problem is real and not a
> > false-positive from some tool. You can reproduce it by adding enough
> > delay in inetdev_destroy():
> 
> I guess delay was added between ip_mc_destroy_dev() and
> RCU_INIT_POINTER(dev->ip_ptr, NULL) ?

Yes, to increase the race window.

> I feel like we should clear it first and destroy everything
> as done in IPv6 addrconf_ifdown().

I agree, but let's do it as a separate change in net-next. The current
one line fix is correct and fixes the root cause. Clearing the pointer
happens to fix the problem because it relies on mc_hash only being
accessible via dev->in_dev (vs reaching in_dev via a different path).

