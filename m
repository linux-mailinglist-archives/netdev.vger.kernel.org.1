Return-Path: <netdev+bounces-274973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKoRK4yMz2mmxAYAu9opvQ
	(envelope-from <netdev+bounces-274973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:46:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814B392F5F
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E97305E147
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCE38AC68;
	Fri,  3 Apr 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kehNcGF3"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EB38C2D0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209300; cv=fail; b=KWB2mdIsivI8FQwxp4phQzXZI275oXjz/dmIgOLR/owYbj3t/ouMgBKPcIXH2ps54GNYD2wSbQWBPaZvnENiHMW0+XG9SUNU8uP09JHN0ojn3JrKpfJ0bVHtc03DT/sJTBPXU6vk4E3HZuY43tfNWj0OQZ/LvRRucwcVqOsn7Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209300; c=relaxed/simple;
	bh=6tbnfWN46wbERoJcdB/anAq9wur9dooG4WcRvtWRpGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jXdmR9s6UhsXbL9zwEOt89HLSq90KteebIhaFmxlink0oCWtdGJ2ZBIoa3tfJyTGZoXjQbiozrutmpd17SYgVnIhOUZ9Qxy9IIIHyV4IxIy+2zXyvbS+nEwcbfrpp8mi36kv1ZsT7VL6m9vGGwk+XnGfikYz3s2CYX1oNi1kefo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kehNcGF3; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9ASUS6TFAuKqcwaoGUIXCbOSt3Ef2N/+E3jTel2P4jpfwgzF8DdmZcm2yo+ADrhikyVWUAo9VYTnjMVNzzQcbsGxhKcIyI3fgQY2cCrrDZmeEBMRqLlvxSFEWrBr0i44UN4HPL6S7eH3IRXVDJoriSh6PWBfCpuseBiOZOGALjGDPtbJFhUcZqOoooxmQ0D+p3PULTdj9494pdhW8Cpecmz+WiHOjqX8ddACmAafOW9yPvA4wmcMgDYeb3K/PEFPMJNQL3o2doa7jXanlfrADUhRrKnWRrZDPmmAkYbp7Aa7gEbN4CXgW13I0TuWJ+ELU2fQJuoikKUwZT69pdzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBCfojazMFQZLd9L434ULDYCTnyeqb7IrYXC7V7906s=;
 b=KcxYIakonIZETNNb8CrEBaOGqKda3IskqlwywvCJkb2e49aiRKqyXalllI4sVs4jwOYBlXUVhoSAS3kVyw04MLGb1nd6myoK82jzacCsyu2J2YDBLBZThrlO0f2/EoBvvZ7poLKTwtkPyyD1axH60VpXC2U8WEzV8LBTgY+0eew1BsE2D2sDFVFFzBYRTI2XVmDojQndsxv25U1S8K22uMTR3s2gUbszdajYjQQTm6/Nj1Ux2O/h9uYWNNXGi6zfywlOxu3SpuNmX1dUOp/kBiH8GUhVD/c1aj7IuD5pZfTHn74plPvKjv0Vpg+MwQVPpxEIxgw5pHYQUn57H+SVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBCfojazMFQZLd9L434ULDYCTnyeqb7IrYXC7V7906s=;
 b=kehNcGF3swjsVcMNEOBL1nwk/l9/Wa8StAObiRMbE6M7wcq3iKQQxP0TJ/+FulwJTPDrJ0T/BViLWoNXM3GHZKpC793q7T3KTL8jLUiSskMogIIIvflt85AiVunToKmeWPNVp4JFRss84HUMoxMKmHblHekfIIkGSyIl7en3mEzmDCbtoZRJC6EXQJZiYUtb8hU60MzF2Zrwl8/U+dK+U6wBrBcQwkQerty+EI7+nzfjcuxS04Ei3cOfIF/uMsm+A3mfEmF8b9GbCi3fDzdLtFykBpCazHg7PF/thuhavauVQ4VaqlRpIjABzsrf5Yw8RxYxKiToxLe8tu2gH0/kKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:41:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 09:41:33 +0000
Date: Fri, 3 Apr 2026 12:41:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org, kees@kernel.org,
	Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH 2/2 net v3] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
Message-ID: <20260403094122.GA57918@shredder>
References: <20260402072613.25262-1-fmancera@suse.de>
 <20260402072613.25262-2-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402072613.25262-2-fmancera@suse.de>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db8aee0-a45c-4e74-7379-08de91653096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rAV5USKqODIC3lMSb+KgVhaPadzi7Gq7tJNrnZv/LT2lQh6SSp85uTxIZNvDRMauYs3L5n8TkKRQNVwSilrisQ9FpznsXG43V9qJb2v0WxYZv23rQEWnnXFqt6PsRVB41Ye/MMDK5NY3fuYMjfYTpeKSgIW1SkPglQ4ahSJBLfuwZPpbJSdFhFSyZ1gEHOjgQqFtn+QXmK7DVryvxOMuhwMS60T23D08BRWNBU/LGFNRc/4RxpBTsdcDEaM39OGi7hdPms779mrmzzzIK5LZr/CazrCBkBRAwgJ6ksixFRv4QZraP+nlEzICustFGjuGf0G0KAZHbpd05E2Oms7INdCib9sghhYn4/mf57Zt2CyZjtjMejFBB99g9ExpGJg+l2xqW3UhqXSsx+2CRAai8sVEvH9xD7/l0HEv9UZyD14U2RYV7hEqfo7EMOfCfoEj+XcTy0h6l9s8PlVrYKGmaCy2jybiXQVbXGiS2FiLuKaWFNBVtts/d9/6ALtAC0dbXjaZC9424QoOlUVo5N2EUsKGQP/BAxLzgkknnvEuLa0EUC03SascJ92JSw/LSlVI/PLKKQO/uzjv4jIVxpWRZD+CpfjqS1VZHckHCHdB9cDYWVMj/OZxJsSjPeiRhMQaDad4YQ2JjDh50SQs6aM6KqfSNYN/jTdDn0+44NB65atnmjand1U79y830KPt6qlm3e+TWSzfzxr0mDiJNnEn7vPQJAy1beBDbbInvalPwLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixVYq77dEEvKxMTdKCqDftH2gY2KY5jz/6SZ4ng65t/hWI+jEtSloD+qx2m5?=
 =?us-ascii?Q?GsBBPRSZvj5wCfGeYeg66LB3nnQTe1qQkr0raQdJMzVZiNJdh4E4pYfRXI//?=
 =?us-ascii?Q?vpE0GbU7FiDZAkZwWb9Q6018OtaCyiDj4do5GGdfpbvOd8S05vY+H1cXCUhs?=
 =?us-ascii?Q?p02CwoW2aBRM2yCN/hSBKG7/rNbx3pTuuXnuPcmc9OMHKrCHySfBjqwPctci?=
 =?us-ascii?Q?UbtRs/0BwhPJDWfBZEZu2P/gp8GMXYn9V2ld5irNOVjNwS3NQAdyAEbD7HYD?=
 =?us-ascii?Q?zAPyUlWI1A+6hGpqjN6XgaN5Wp5j5GYB9PetFFTGzfSBovengyb7lREiWlgl?=
 =?us-ascii?Q?AlXiGVpu6hO+Q1Pv3/6nRBTtdxoTvPilmB03zenPKevyuf1z25sFsoH6F8Rv?=
 =?us-ascii?Q?hixtLEWXjiD5U5mO4NVrEqY37vofaelpMbL1CnvA0B65dydb5W58BORqRB/z?=
 =?us-ascii?Q?7WPR5KagaaGXTdQkrxnlNJnMKROSj4jpC1PBK0EgyecqI4XKWHCMOdvCy50W?=
 =?us-ascii?Q?BeAMbUBWQ6VGsRIFZ3WpHyyViSiPvoXWeriSILDj7OB5AVFk77Vz/WOmarvI?=
 =?us-ascii?Q?eN9cX8AHafkOc3S4hga3dCCRQpU2KBH9gRgkbhWpVgd4xOJfr/anJ7PFv1qe?=
 =?us-ascii?Q?hJYk5ha+DXKZ2KZNtUJEHn/E006xQqDMKF5BDVAinVm/4PFUyS0CI51rBlQB?=
 =?us-ascii?Q?Him4FJmTy+1IQ9NLIeB10ermLL4lkMfS+MSDklmIM4Y6rxN2oqi8z/QBxPtt?=
 =?us-ascii?Q?eXSaiLUSubrjV3UKdQEF8dkEO8RRtB+GNea96wDzt6NipcHKYBeNcIw1mJtx?=
 =?us-ascii?Q?iVC6oS+j0WX+5nuiK7RhAk6ZCMPfpnF0JTJPrU4qCTn9pk0vfHYuj27aWJGv?=
 =?us-ascii?Q?KrlHLW8/la+1Lb1XBSxGiE1d7p88nhLQfIRaIn2UWPYuTgAttSdotflszarp?=
 =?us-ascii?Q?rqqA0kauLzdY1X8K6TxbLwFEJAfFFaleyfRXjefkO12EA78zbSl6+UsvvDSo?=
 =?us-ascii?Q?w3VjnuTsGXYRV46dMEO+QgGFBn5rKmlD0Hk2PGD+NgVPPtn++4sEoovsHchv?=
 =?us-ascii?Q?O3tYherRAGkofD6OU5z7wHV1A6usOC74+Qwn6lL8RHxyCV5LKTzN4FI5XASl?=
 =?us-ascii?Q?Wd2xBJARKv3hXrMT4Ffh5XWtuGiYVzEnlg23oqnsNwDb+84jQ6tNa4ZqrSa2?=
 =?us-ascii?Q?5/E6uOawmC3Da6JbNUgJr2EUT3YQ3X+EPMGgdVrtyG6oMrzH+VATMoB6L6br?=
 =?us-ascii?Q?Fl4YH14PfRgad15VgladjcP/VTqtQZicN7PVKrEvLbB5ljdiQVe4y7H5y1AZ?=
 =?us-ascii?Q?l1YBTweq2nwb9VJ2YtPgyRR1ne4Q5zvdCO5vADVY36Yk031cq8u7gZMW9kXf?=
 =?us-ascii?Q?A8bmZ4/D9MUhK5/+MngOFVVMn2tyrUGjd4rpQECjArOtslOfrGKrk6fDoKib?=
 =?us-ascii?Q?+9AD6K0El8g4yNQw6YtZ0HCAslfxeVTYX7OZUkMDvydREvsAvtGKOw0kvZxw?=
 =?us-ascii?Q?XQIic/UgfCkw1fKVzbfmUQ2/ELiFzo4raRxhUUBOzt/4mnzF1xU4pcn8MxiO?=
 =?us-ascii?Q?NDK8kgWhvE8vs5XytPJKQ78uE40pbB6CgZviXaedUpK4MPd/d45M2gtLWfJu?=
 =?us-ascii?Q?mQcA0wFRnt7jDkKcH57q+nw6AQoZmB786JpVS2pgESjTb29doMoIeIMHlg84?=
 =?us-ascii?Q?O5Qwo2soVYl0sjN3emGpcjJZodohhIES+hqBmvu7SnpRP+AudkDMOhaTCEEP?=
 =?us-ascii?Q?Tt2d0jNGwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db8aee0-a45c-4e74-7379-08de91653096
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:41:32.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O9Wyz7xweFY6IPrqSgzXmw+im+VyiC7gvxrWxFBTcnlcKIhJowoiFvTN80nHr2Q5Soa0NAYsMN0rf4XmGESbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-274973-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 0814B392F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:26:13AM +0200, Fernando Fernandez Mancera wrote:
> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
> single nexthops and small Equal-Cost Multi-Path groups, this fixed
> allocation fails for large nexthop groups like 512 nexthops.
> 
> This results in the following warning splat:
> 
>  WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#20: rep/4608
>  [...]
>  RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395)
>  [...]
>  Call Trace:
>   <TASK>
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
>   netlink_sendmsg (net/netlink/af_netlink.c:1894)
>   ____sys_sendmsg (net/socket.c:721 net/socket.c:736 net/socket.c:2585)
>   ___sys_sendmsg (net/socket.c:2641)
>   __sys_sendmsg (net/socket.c:2671)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
> 
> Fix this by allocating the size dynamically using nh_nlmsg_size() and
> using nlmsg_new(), this is consistent with nexthop_notify() behavior. In
> addition, adjust nh_nlmsg_size_grp() so it calculates the size needed
> based on flags passed. While at it, also add the size of NHA_FDB for
> nexthop group size calculation as it was missing too.
> 
> This cannot be reproduced via iproute2 as the group size is currently
> limited and the command fails as follows:
> 
> addattr_l ERROR: message exceeded bound of 1048
> 
> Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

