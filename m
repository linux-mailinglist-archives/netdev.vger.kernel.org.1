Return-Path: <netdev+bounces-282845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDmuF95O82lnzQEAu9opvQ
	(envelope-from <netdev+bounces-282845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7384A2DD1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656533006788
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2D40628E;
	Thu, 30 Apr 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBYoAxgC"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB13D6465
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552846; cv=fail; b=bPaO3wAY+lGwspzohR+L434lT8xLVSyzHCUoIqX3fgFOnPk+39Nuke/WoMB7H3rUL6JcqY5dC5dIkqrkeAa83GMJo5rNpCT1yJ54d0l/pPlkN7otnpKLztaztKvFM4Dl0vw5j4ibzoM3Oj4G4WX8n7LDmih9WoXAA99yxl4n+SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552846; c=relaxed/simple;
	bh=uNPb+7vchJXX5JC9D0vHG3/AITNEGHGBRoIDUVc6uKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0k8NImt0NuSR5OnGvRzqL+aevDvkhmo866r3ADlP5nG3WweSPMZrsfIC/4JUg6FCIbihQ3wxdqil29f0EeJG6G3FkFpVNCC0fX4KK1zcacGeAEGOXmuONPpxc541H1hx1g5qbegJChzsbA8U5odE2CmdqDlABNtzzkz5ZBbVbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBYoAxgC; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTOUyi0hr2TRaz+1eyMr7YtBYA1ZOqck9pk+7HRzafbg2nZzSwbVHQZZey6FJ0uxWs1whfEmx7flr10lchsbkbDzIKYTfRNniYG5uXGcakG11A0kVjC1Okz5CeRL0+oWl80Ew/z4PEzoQLrPMTf6Iae+7KYv8wM0eq/5RQ9ryc2jVk3zhNZKpB6R+le54z48GM3/gYbMOOe+YgEpfq7aVTcavDHutIT6IuJihZbKvYzI+RSPEMJ/DBgmWHl1PQZ35SflCFcNZfSmDgFRQnPonEqEVgP3YLqFvepYhCRlXiXBtZxAcXco5FZ6n42xCKrQOECZX+Bkzm52UYIWcp0DKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NjaGumnVINVypa13ehsMedFnSUpRyxM1T6u4FrlHYU=;
 b=elu2SU3LVEQZQMUEwe80kWUF5uDMObaoGQAibBJfjBP46qsjEcCCtizZTuK0M75BcCm9g0io9UEum1sw+ComQU81eOCqjr2JwaVBmPhAgm/8kgu97AnU/HGVs76TmtZCoM6+YqWr5w/Azw/jUFigLnujhpYPuQgNYeU7j1z6z1tyKDWS0Iw249roHyxcv0GzYuPYHYkxsL2AVnWFfoLXoO42wv4PDx9lBLUihKnLBG54xCl0XwcoD1FZ7lMLRw6vKt0EeMbDISSBBtylLcp1+FrbH9j2EMmzx1Wl9ljcdEzGfdO2LXmUk6i6CNlJAMWdOjNtoStrEJX7V2L/YNBPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NjaGumnVINVypa13ehsMedFnSUpRyxM1T6u4FrlHYU=;
 b=SBYoAxgCrv6gC9qGNxM0x5Q4QBYsXce+D0/dBtOvVQk3qlzWueqHAARO7Vsbf2ELp3ekxnjk/APDoqeexOWek1DEp+3k7Zka3mvxmu8BBtytEtpDL7DLLpZVJukQ/kmeuY1+hbjXn24qphIdJ1CpRGMbOQTTwCXto1tbObECjnT4AbtJKc86LFVndVypwogXBK/kxhNZZV24zvHWg5Mf0u6+B4v0x1Tdd+d0Y33vB2E+DEavGAREmathyK2bdbMqcp23YzivI7yg/5eE8pa+RRJ7XUadW3KHEuI93dWY9v/eN0sYDX3XPtwClY9CAJJrx3RdkMCD88A/qBRbhJ7UYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:40:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 12:40:39 +0000
Date: Thu, 30 Apr 2026 15:40:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
	tom@herbertland.com, willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com, justin.iurman@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] ipv6: Implement limits on extension header parsing
Message-ID: <20260430124025.GA971154@shredder>
References: <20260429154648.809751-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429154648.809751-1-daniel@iogearbox.net>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 80eb9019-40f3-4477-a9ea-08dea6b5af51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P2DRySv0xm2AMRMgDcylkuXsRA0tCQ0ThqFXNbDUjbBPfea6Hd07JD6Ji+F+8KCNRgdZeGiytBnqLRwBDHZ441mcDQ6FHRb9ctSibLfj9vTvu53nLqvR/7YQdXGxSlZIukCAZeSWUHDqsh2h9p+ahWaP0DE424IQmvahn4yibyMxbtZYLzf+kwYPLIosBx1hE0zWrP/njzeIPU3b3iy0Vu9ofCoAT3iVx8EN3IjSXO2gyBgfdhcL5CNX/zsRt7uK5nO57+v4YLXwfL6rb/f2HsSNZBD0hd4cqB1vkaRsT8OObKJbY1mkmDnPkGWnVY98tbsnPaAJqTBOCCXJtVXvIpt+0U2mfkslQlX5/XbGCJz1yd2QCIUIgklktndrBla9D90TBkIC3E6ZwflcKbZBJzbFZDptC5G4t1e2s1vYUaRyBeqLz+uDLnEUpoxwHyxTO9ZAgVmIKUbYLr+BHGlWR2W2m2iHI1fEPh/1/lbKXnBRQ1mvDaGNeSoMuM4xnqLVP0KAmtn04nQfqzCtiKx/ED+wsBMhlz1pBwlMt2tRR6/sUlqRNMx5ptLVj/2TGjJK+sgEBTNrGNHdKYpku+O5VRzOXMNZbdB78hfDN0KBSnBTURpjnJiApvh1UdN57Q9ou39tqm/4MPM+Z7+jHjlVeioVvumKmlGDd2wxPRTR8rPExagRic2Md0qDUxBk1K2CsgSOwnm6ZR74JPypAnir/5ruEhpsJcXkySrbDbkGIg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxrxLxxUPLcWKZD3ZqM4pmPqIkTtU1muaSZa7b0Z25oYeGMnDPjZTkk65Rvk?=
 =?us-ascii?Q?Jq9xsevAMbuBSVpoA0MNH3YuG4Y776ZKaayQEM0bnXq8RrxZ3zkiaf2q0xlp?=
 =?us-ascii?Q?NN7+zZ2rWq4KVlOP+hikk+ixMOMevwwiR1UpO8v6DeY6qmpSJQLexrMoHF4X?=
 =?us-ascii?Q?BIqElijKhR06LTMDaHldL7r6UBLe9Iq7xo0M7yCKzbbsa803HQBwdVzrO34J?=
 =?us-ascii?Q?frAAzYSUxWV6SGdj1cN9z9Wk2vnvN4scsILZIEYHN3a5uwfxNxZjrGLT2Gwz?=
 =?us-ascii?Q?S50z5oqVU40nQGDzCT/ZJ0LPdr6J5FguXQzaovybxjWmRlZbKFW3ki2h0kXf?=
 =?us-ascii?Q?g+2Nq223siY8Jy12FxaZaNsxQEP3bRgpVMQ9sE6oC9YDxs6qsDgOGhWN081y?=
 =?us-ascii?Q?HD9N1VSLL7fQ8lL5i9ceVK+DIzmV+hoU+sNJ0A0fCgFBEqcjtB4XeEmqsECo?=
 =?us-ascii?Q?ifcJFD6iaU0yFpYKNzy1fPlyjRbjWifLEZYxoOiRi7pAUgFehiR4cs9CO82g?=
 =?us-ascii?Q?gLNWYhTiZLXuEvkv3oM7x0KZ+4fgd7hUbC4RQl4egtQsGQoJS8c7ZcSKDSkl?=
 =?us-ascii?Q?ztZehxuDg+f7pI09R2xE8gtBbbCIKs+bU3tlhtOqBWDaNg+FTbADohuEtS5G?=
 =?us-ascii?Q?UVSzwkMfG1ueBo0AXviA0WlkaHbszG9tc/dE9xrE/5Q5mYZOjjrp5jG9g70t?=
 =?us-ascii?Q?ghXCOeXKJYPPw7ISc2Np/VT3+IO/TOzWW6ndk4pfgYRzDTK+eLryIVISc8kL?=
 =?us-ascii?Q?C1ck8vdpohvXcaW6yhQf34C8Fo8lrTrGeD/G5/5X7KfFLvd2rn5vu0SB88dl?=
 =?us-ascii?Q?sJOQ4QBjwi/maSKQ7yOPNCFmDfwRoKwQORLGjKfSyoEnD4znBjqGPMU3S7eG?=
 =?us-ascii?Q?9GH5beqdTC+6o6Ca9RZSlXn0QSKv12jMDc0Q5gnFab7FPQe6kM4rfJSE+vc7?=
 =?us-ascii?Q?8taH5jEVDYm8MMyAgAr5CAPzYOIoSnkodqqkXK1ezDtQWCKCqAidZ1PENkvS?=
 =?us-ascii?Q?E3HKQE0K+/LqSASiQN4IkAyl7qFkMsX8eniwcieCSIDQy5e5P2WRro4Pylz0?=
 =?us-ascii?Q?NxlZrZPF5FHckyCY6H2drNSLLRvV4dfMXnJGIeuQ2SHfLuT/DrRiz8G3NoVB?=
 =?us-ascii?Q?kFHrpsobIcb/BtHSLpEDDsj0+rXqzbp3aD+rT1FIR92BdhRAgt0T5iUcax1l?=
 =?us-ascii?Q?ApDJBByZszbBWq3bEo04Ub2KmlM1oiZPx8q2bMdGMOIni10bdJSw2n4jHf3P?=
 =?us-ascii?Q?n9v/NT9fIFdOJSpIptC4nQcaN8x07sCVXIIeuXa/hMs+/RHWCQoqtCwEQXqr?=
 =?us-ascii?Q?vaYLn2i7EXeFZKC5jXXEhzLxpy0wDYj0PPwfOAsbO3pA91K/+NfzX6W69rqL?=
 =?us-ascii?Q?M2q3EsfYH71ATKNVCNA8BD/MPKvB9QloOUppdgiyh0N9WwMd/37irs6+miQ1?=
 =?us-ascii?Q?7TqWmzV1lRCUBlTWQWx6tKA/UcpuJBu7v7ReGmombbzmH9M1+/P2tgUJJ29I?=
 =?us-ascii?Q?HvHHMqx2995CPsV0P4WZHc/ObrcMbhamjEUnrfbU5RCqBFAzUATYnisQ6K5Y?=
 =?us-ascii?Q?uK5tK4eugOw/OT0wapwetcokF5DTbsx+HuLsBon3igMKs/SbN4qoWPLVD3Xm?=
 =?us-ascii?Q?RmTa75E+uUJDzrlh6f/ShHQyRjv/YVQjhOOj3ICR0ZeiBjQEM3VgUq+MMVBu?=
 =?us-ascii?Q?yPB0WtkUsRtrXq8tLj2UtizNouljXhegEFgfSh3ipsalLdgM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eb9019-40f3-4477-a9ea-08dea6b5af51
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:40:39.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pRuDQSeXuGKXPjxNDL5KoCV4tuWf/2YzkX0aNu31KUF5r7XzDHk1wxoWVvTuwUkSPYeXB8WLl0uBD2bBw5Eow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
X-Rspamd-Queue-Id: CB7384A2DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282845-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,herbertland.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]

On Wed, Apr 29, 2026 at 05:46:48PM +0200, Daniel Borkmann wrote:
> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> find a non-extension-header protocol or run out of packet data. The
> loops have no iteration counter, relying solely on the packet length
> to bound them. For a crafted packet with 8-byte extension headers
> filling a 64KB jumbogram, this means a worst case of up to ~8k
> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> for example, is used where it parses the inner quoted packet inside
> an incoming ICMPv6 error:
> 
>   - icmpv6_rcv
>     - checksum validation
>     - case ICMPV6_DEST_UNREACH
>       - icmpv6_notify
>         - pskb_may_pull()       <- pull inner IPv6 header
>         - ipv6_skip_exthdr()    <- iterates here
>         - pskb_may_pull()
>         - ipprot->err_handler() <- sk lookup
> 
> The per-iteration cost of ipv6_skip_exthdr itself is generally
> light, but skb_header_pointer becomes more costly on reassembled
> packets: the first ~1232 bytes of the inner packet are in the skb's
> linear area, but the remaining ~63KB are in the frag_list where
> skb_copy_bits is needed to read data.
> 
> Initially, the idea was to add a configurable limit via a new
> sysctl knob with default 8, in line with knobs from commit
> 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
> options"), but two reasons eventually argued against it:
> 
> - It adds to UAPI that needs to be maintained forever, and
>   upcoming work is restricting extension header ordering anyway,
>   leaving little reason for another sysctl knob
> - exthdrs_core.c is always built-in even when CONFIG_IPV6=n,
>   where struct net has no .ipv6 member, so the read site would
>   need an ifdef'd fallback to a constant anyway
> 
> Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
> extension header walking functions are now bound by this limit.
> 
> Note that the check in ip6_protocol_deliver_rcu() happens right
> before the goto resubmit, such that we don't have to have a test
> for ipv6_ext_hdr() in the fast-path.
> 
> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> IPv6 extension headers ordering and occurrence. The latter also
> discusses security implications. As per RFC8200 section 4.1, the
> occurrence rules for extension headers provide a practical upper
> bound which is 8. In order to be conservative, let's define
> IP6_MAX_EXT_HDRS_CNT as 12 to leave enough room for quirky setups.
> In the unlikely event that this is still not enough, then we might
> need to reconsider a sysctl.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

