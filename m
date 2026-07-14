Return-Path: <netdev+bounces-307541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xFt0B+Z1VmpM6AAAu9opvQ
	(envelope-from <netdev+bounces-307541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:46:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BE757974
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:46:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Q0rIFT3+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307541-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B620305B3CE
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB325417BFC;
	Tue, 14 Jul 2026 17:42:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F1417BE0;
	Tue, 14 Jul 2026 17:42:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050942; cv=fail; b=PZZE//AVLLIJvJS2zomtQtF76LVEIVx8o7uy+HkpzXBPTUQPC2lvrGO5J5gTJMMag+4+qyDHO5RHHKxBvwd731A8hhi9VRl4zq3kKr9YntixLV3mjcUo5yNRx3b0IoCE1O5K8iZ6fIF541KylCBvEP4J6kSIzPCdDnSJXpZWVxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050942; c=relaxed/simple;
	bh=4Bh7BcLJ+oQmF5luSyAGHlp8TN7VooEn6et/ExVzurg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u23Ya15Wgs44/njicsyqgSw8fsu5UxxljsskOzFZCY0BoeqHl6qY3B+zOPxg/5ole2YzHmrjopJkj4vAPCo7e00W55rhQa5R63f3wE+OV3ZP7LaGlUWgyl21It12RRPl25qn4siFyMQqNGQzF3E9qtnm7C+HDTtsCtTZY6wWsG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q0rIFT3+; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/bAXovoKu5Q4tLeOaWOW7GocLuRJSIOFsQvExxxkOhjIgdqamgK+zgBKdlsHDYVN1WBEQMXQ+/fN8BRTjlTLV/IxzpBkMpZP9fP4pTu1TsGXwoHG9m0wT5dNXuSy6pTxQDQYAs/EAUL/01k7QZcxOdv+8dqASFxcTMTwXoCVeTuz66jMQ9F1bjfSIdkh6WyGNoxYf4ffQXOFnMQjDtWbUofE4KDs8xZccZf6+XhbeFWbMuqNSNabVgLxe3zDjoZrQURchygTq+MJK5whpvcwfvc85z5gFxzCjC4vH7AHpwuQRkhFXxW5LG5oOmvvB3FRPywyzHYnAqy5RBJEyL+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU//E2QBIoHt2F1vpfnOFt/QPTqBm7OHtB0jz8WSOtc=;
 b=xGb9n5onOlC1Da1mVSI+9wrcc1l8tDLH7ySYab2npAKHrVM2bTrLYaglEvZY3+NBG9rsVZe6sCJmrl5SSnNAvSjaPNdmWSc2i0jTFfatpFbqAa3TVzEGtcv44nXqTVZ0qvjpKTKF14RJ49HzCqRnZ/IRjqeSvY4lq3VkDU/FTkDbdZDehDA8Kso0HzR++mb9paaX082SsKMoBiWeiYICRhCBcrUilQTAxF4DX5pq2PeoKenfQg76w1Ty1/ghXokLpj9/TMZBf3jsUhZ/378aiN3YYwkdJoXqdhx4f4rJkJG7O9KjEIOLqPFkIgINpFQlG/BIBYtOjdDDXH4oK+pqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU//E2QBIoHt2F1vpfnOFt/QPTqBm7OHtB0jz8WSOtc=;
 b=Q0rIFT3+EGSOOKkEYs5CDGE7/35ik2pRbucxlGbGwemY4hcXHCgTmpnqXc7xRfs55/n14+KToyHAJoh66uNHm/yCrQsfGfZOqWL2miaG1GaojmL7phFCCgcuTsPHcQ3SxbqE+UU4zW4EWmzRBzfmMDZnUA/x4xG0+8R+0q1BFAT2GqVq10+/EuCqwyabske+Jrs5lB6qXzK3g5J8KRgjVQ42GjlWLT0TORwKSlNb6IOLvPz0R/HrrgPJhcFZzGZh6a+gTsxYGYV8E4U2qF1p+2aYuaSzEXuA2Ar0GhlrRhTDJecOolJxwbusbwqDN42pCRUlBiA5doFQbcDV4baIhg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 17:42:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 17:42:12 +0000
Date: Tue, 14 Jul 2026 20:42:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jack Ma <jack4it@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: nexthop: per-nexthop UDP dst port for
 fdb (VXLAN) nexthops
Message-ID: <20260714174201.GA1037700@shredder>
References: <20260712191218.236-1-jack4it@gmail.com>
 <20260713122339.GA548566@shredder>
 <20260714034309.2226-1-jack4it@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714034309.2226-1-jack4it@gmail.com>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: a6af9c4b-62b9-4a7f-f428-08dee1cf3c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+KVWRFAN3B0Gtu7pv0sz9Bbv03FHjaw1Yun+VYmN8jDOjX/h5GqQMebkXM8fJgrG2M1DgD1MwLJ15gTDDOUwXTiVWbXyHWO0PP1OLKWUKCwuLV42c4MDXL37yPlkT9DOFgeyicWOrGM93mmRhRYWRCwIgxhnjzSz9DMw2rahcn12BAWoFD6c2sFlc3NeVMeT41OHxdtlWcSXVh966mY2dQr1Uzf97WRAt/AStOtVT3Y7+4EdcWc5b8U6mk70QazWAnUxe0jc2RsFl6DWofSF6YpXW1kLZuhsoAxzfDi4P/FKNcJzOoq8Xu4MVkT8py0OUBK5lmeNlile3V4DjbwandKWgGQr4to1+ErF9slHb55JKuAF9vMfkLQ4oeYPeL0PWJ46b+EFL1sCHnCIki0Zd6PEQSwmvMLP4yhKjrnsSj+fEHLyTvxocN2WrB1J0RQ8LDnjbBA9Rp6n3q5eNetIMD3G/3nWhp6rS5hWWrY333icq7OqJTQ279vTkgau2BydAq49so6uQBM58eyPx47nOc7ObxnYh/8SdsJkfmRO2gkCixFyLZxL+l/r10nsP1R4NOhoUo6IxIfg8TyC3kDZv/oZP/AdA/GMELK7fI5sdLGUnthloROau+Vb7TAyN+5l76MFA839ZvcYo4RcG9lknH/4ofW4/mC9F12KsSxXNlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8jhYwHSy3pLP/1PLduGhHurwILkeEYceyRjCxchH6G6RgUaDXztwEw+O3rt?=
 =?us-ascii?Q?e0HcXFjDWgoDvBvdHJ4jh7v5wZ34Kg7x5EV2mB1Nx9MfUL5L2dDHKAi0FVwX?=
 =?us-ascii?Q?p2xlq7Lho+wseox+OyueViiyg8jrgfOZxsUbb0FvlpjzNyvZw1l+TG5RKcPh?=
 =?us-ascii?Q?z6EeoLFGX2cifULFdJQd183HRLrbmOwPIGnwX/hJHtnO0NRdSgZt0ZZwQi7e?=
 =?us-ascii?Q?2+TVJoLUaPJTuTsYgFIC+luSQJtx6q515bG2YDkONe69k7zCCTStRx8xzemU?=
 =?us-ascii?Q?p0T0G0kQrk4bxcF2f3b3mGS3hS8JPYmtM6x8GblxYrD6g5wKfn6SGVMHXvwX?=
 =?us-ascii?Q?CWIUjDAN+ecu04r35S1dEdCBxjUDIDKKbR3O10W5wkNJvwHd1qAH8o97Kosc?=
 =?us-ascii?Q?ehArZUb+C72YuPLieuzLpqCHRJNOwK/Ecw3KX6q/uYWiyjiSnb++ZINC/qrT?=
 =?us-ascii?Q?UZ2JbunclG6NOQ5xfHPwevzNtWbPGyGFeqHPvt34weqlf2gs8Hti2nRxLm/0?=
 =?us-ascii?Q?q6N0l3q0CnaiG4sQHlUQkftuYGfjV9ZDtSl3AWNdfbAx8081C0nV90MilWEN?=
 =?us-ascii?Q?FRM7l7B2K5TM+bQrBE+0pT2EcLnl1TSSj+Pk9BmFG3nNxOdFBqazM6cuecZz?=
 =?us-ascii?Q?1ZTLt0oCUambGF9fo7yp9YaXqDYyEDj9B69v7SFfIa8CBhPy/9UEZLUm2gup?=
 =?us-ascii?Q?BauV0odO1P/L94CK5uGAdpAEb/sC4Yefq21Gr50eGb9fLW93f5E7+tMnyVZg?=
 =?us-ascii?Q?sW4pTqkBSVaaW43X0LVtfYZroYy+FRTm0a1AllABK2KrxCkiIHIlkzqMy6Oo?=
 =?us-ascii?Q?bR88R7eOvXT1tPn9KXYkGUICbRM57vnEEJ/8EptXRLrL9tSeKDLgePWJkFix?=
 =?us-ascii?Q?YydtlOaoebaBM/AilE7VikJtb0lnlor7eVcLn/r61Rxxc6Rre25DE7lDzERt?=
 =?us-ascii?Q?ghvTNqpKxyYEeu5yNZiGLU5osO6qJcqNp84/LDpLGiiOJUYcln82b6/wAY6V?=
 =?us-ascii?Q?ix+ewMcaaHtgGNOtSkJZRQWFU6GIODHDX215rzCdzJW6KIi88hCaqiisg/BX?=
 =?us-ascii?Q?vx67vnnnWid0eHgNCXPh4HBXgdG1vktteKipqXy743LPVyJWQhAI4H4U/iUb?=
 =?us-ascii?Q?n+Ve8EP+vhAdSlWmJkHM2rx/ebzckF2n6EczxRSduc8P49hnUTPAJaeWWNCB?=
 =?us-ascii?Q?UZOjS8mCryN4z/tCsx4jSU9+GSogHiZYQCO9c6o1aB1HIvBQNKoHJ9JFcbkc?=
 =?us-ascii?Q?wsq06WTyJUWFvdiuAXY99aIX5wDLJmoQiMlikRhj0PIiZwGoL7rJl7ooc7oY?=
 =?us-ascii?Q?hp31COKR6k6RI+tp+4Q+PrQj8IFTiM98PQYgP/10PPx37I+s11Gfsyf636Fq?=
 =?us-ascii?Q?7qd4yjSgZw4IKMe0IRR1cpeiO1awwaZsZOf+Qhi7aqsmVXhZq80A8xrT9oNp?=
 =?us-ascii?Q?BMm2qTUFj4PTYApfGKT02XYA2ZMyELk1NYZ93rVFG0pbdcthgdtvAz3JlXQj?=
 =?us-ascii?Q?j5VvQr1TKOKleXAXr/RfIdh/uQ9xQEeY2ODY6D5/m7HHDkzp+NIH39pQMLP6?=
 =?us-ascii?Q?DpKF0Ittx8KeiYVFBaaKjFIsTNwx5eneML5ohNmnwHsY6j2JAHG97NN+/eiT?=
 =?us-ascii?Q?/SMdzHtrgifQamA95ad2KzRGFZtv0v/TNs62W38RFSHy7ZBvaxR9mi2GUPQS?=
 =?us-ascii?Q?lkZRkzkJogFCt38e3syMyKHdmDs+hKZALMB2KN+hAPYN457AiBAkRzfdw8Do?=
 =?us-ascii?Q?Nex8V0n1ww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6af9c4b-62b9-4a7f-f428-08dee1cf3c95
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 17:42:12.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq81B0+eXFb1JlBg1DZZuYF6jGVRdh/Mv7S16/5FG+ijak8sncwoM9MkXFBgCyv21w0clr+saSJqgLFt0lq6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307541-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack4it@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shredder:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B38BE757974

On Tue, Jul 14, 2026 at 03:43:09AM +0000, Jack Ma wrote:
> On Mon, Jul 13, 2026 at 03:23:39PM +0300, Ido Schimmel wrote:
> > > Some deployments pack several receivers behind a single underlay IP and tell
> > > them apart by UDP destination port.  To spread flows across such receivers they
> >
> > I don't understand the "tell them apart" phrasing. Aren't all of these
> > receivers interchangeable given you are load balancing between them?
> 
> Sorry, that wording conflated two separate things. The load-balancing
> targets are interchangeable; the UDP port is not what makes them
> distinct services, it is how the underlay addresses each one:
> 
>   - Addressing: several VTEPs are packed behind one underlay IP, each
>     reachable at a distinct UDP destination port. The port is the
>     underlay demux that delivers an encapsulated packet to the right
>     VTEP -- it selects *where*, not *which service*.
>   - Load-balancing: when those VTEPs form an HA set (shared inner
>     MAC/IP), a sender spreads flows across them with an fdb nexthop
>     group. The legs are interchangeable, but each one lives at a
>     different (underlay IP, UDP port).
> 
> So the legs are interchangeable endpoints that happen to sit at
> different (IP, port) addresses. A group can already carry a distinct IP
> per leg but not a distinct port, which is the gap here. I'll reword the
> cover and patch 1 to say this explicitly.
> 
> > I think you will need to provide more details about the use case [...]
> > In your use case, why can't the load balancing happen at the target
> > host (e.g., using XDP / TC / SO_REUSEPORT / flow classification)?
> 
> I think the key difference is that there isn't really a shared
> host-side datapath to load-balance in, and the UDP port is doing demux
> rather than load-balancing. The shape is a bit unusual, so maybe a
> couple of pictures help.
> 
> First, how forwarders sit on a receiver node. A forwarder here is
> just the pod that terminates the overlay tunnel (it hosts the VXLAN
> VTEP) and relays traffic to and from one tenant's workload. Many such
> pods share one mesh-routable underlay IP, each demuxed by UDP port:
> 
>   receiver node -- one mesh-routable underlay IP (NodeIP_A)
>   +----------------------------------------------------+
>   |  host netns: stateless outer-UDP demux by dst port |
>   |              (host does NOT terminate the tunnel)  |
>   |                                                    |
>   |     dst :40000        dst :40001        dst :40002 |
>   |         |                 |                 |      |
>   |   +-----v----+      +-----v----+      +-----v----+ |
>   |   | pod0 ns  |      | pod1 ns  |      | pod2 ns  | |
>   |   | vxlan    |      | vxlan    |      | vxlan    | |
>   |   | VTEP     |      | VTEP     |      | VTEP     | |
>   |   | decap    |      | decap    |      | decap    | |
>   |   +----------+      +----------+      +----------+ |
>   +----------------------------------------------------+
>   (up to ~10 forwarder pods packed per node)
> 
>   These packed pods are unrelated -- different tenants on different
>   VNIs (below) -- so the per-pod UDP port is node-level demux, not an
>   HA construct. A single forwarder's HA replicas are the orthogonal
>   axis: anti-affinity spreads them across nodes (never co-resident),
>   so one member's nexthop group has its legs on distinct node IPs.
>   But each leg is still reachable only at (node IP, that pod's UDP
>   port), so within one group the legs differ in IP *and* port. A
>   group can already carry a distinct IP per leg, but it takes the UDP
>   port from the device (a single value), so it can't send each leg to
>   its own port. That last part is really the gap we keep running into.
> 
> The pods sharing a node need not be related: each one belongs to a
> separate tenant on its own VXLAN VNI, and a node can pack forwarders
> for many of them, each on its own UDP port. That per-pod port is what
> lets different tenants co-locate without colliding, and the host --
> which only demuxes outer UDP -- never has to reason about tenancy.

It's unclear to me why you need the UDP port based demux. On a single
node, do you have multiple pods that belong to the same tenant and
therefore share the same VNI? From the above, my understanding is that
the answer is "no".

Assuming the answer is "no", instead of having multiple VXLAN sockets in
the host netns (each bound to a different port), why not have a single
VXLAN socket bound to the standard port (4789) and let the VXLAN driver
perform the demux based on the VNI? You can achieve that by creating
multiple VXLAN devices in the host netns that only differ in their VNI
and then move each to the relevant pod netns.

Given the anti-affinity constraint, you will only need to load balance
between pods on different nodes that use the standard port and that is
already supported by the FDB nexthop groups.

