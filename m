Return-Path: <netdev+bounces-291172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIFtLE3zEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E015C2672
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11BA83009F1B
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE893955C0;
	Sun, 24 May 2026 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FuY6Ojmt"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD1204F93
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626825; cv=fail; b=dX1Mk9w1tAHAXxYXcHZ0YYJDn5drWprNU8r2LNAy8rA0tFOeR2gLCdj9qTa6rsBLXGKfZI4eGjv6P33ZvMdRV6q2fTJeQD1QkxjW7wamPNpuHyIq0xJeKLxeeLReYx24dIErAWRC4VDIiAldmijctRdS0VUQXskaHI4GeWLP01w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626825; c=relaxed/simple;
	bh=AAbJv0EP+kX3l/V8shyIC4AqgLadpboBJeAaQlfmuP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q6AYsqpDj5sKZh2iSPdrwYgdvSpa0Ff9ofVlAixJ4JkcfW37F/VfTFNZa0fhCAYmsm7EprZMiAKUARyObtdHis01rdCWgwPC2QXgZLLXToVGWHtBsvA+FILT9/g3E5dO8/9vMjmE6dTzmiUWN8XPvbAXpIcVYU3NfaVz3bf2WIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FuY6Ojmt; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJXGgDVBE+nbWVViOVSROe3PmPXXngYi7RAeZOXZuIr0PuqTfy4epGuZjejrD04v/ncBwdjk71VmLqF3BW6miey0yk9NV+/kXWj5BaQlAK2GDxyBVdblRUJ1cP/Db4eL+rOFHEV40ogRdti7tZ+lGWbIVE1tDOiOZXXM6ph+dk9HoIqzSTBxGXNaMXVhU5XTcWZ35BTTud1v8bCV2gxviI4mOoR3G8L0SB9c38U01KYsqxM8ukqmJVUwzuWqTw602+RspXrYb9XegFjyc4BMFBnpYW4fPywkH1uzJCa2WefZHUH1+VYRuqTN3vu0ElG45Xo6VDentg4C0uJRlW+Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AGhtnp4M0FNs9aS6Ze9Rshx/kWPMC9ciTCwNIXlbKY=;
 b=TEFmjYGOJ73fMgDuAM9gQfIiPy5FaXYuLrKO6SZjGlV/dLdpW/Y4/GCKKid32dEBtBAwIiUw5Tl9xM/03bauSHZMmk+oHqyQru0KtTqnyyzttvpoG1VhuFtlFiXPJhH/SAOanh86ZtJ19GY/ueZz/9BRSKhAamfVYyBx0jUr9AOQwhRiyp8SloQk0miQC313JVO1aH6sdD52Gt5SkO1krAP2bnn906ejbRFzYiUJouOfVNOnJN8ScGfeoOK77jyZtRsn3ZgcWowYy8TQFFaTa9VaGg+vcsarPGkSqzl927TYSBojA7FNRwsG1z3ur8MVpN6KhqnCQxBvzjb6XXSKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AGhtnp4M0FNs9aS6Ze9Rshx/kWPMC9ciTCwNIXlbKY=;
 b=FuY6OjmtJ8948rRWLGDMo9fgrDmi7SiL5WOWibfB9gxj5bCQdx73paVCBcRoAQBkeb5w14/FH6V8P+eBQqJ9iKQUnJMLLcdv+yW3rD0jQ5WNrKHHRPiJbWDHNcsglI3UNqcHTx+RIu1hsiU4H/PCEj095ZBimszoLVsUZ8C7AX84tSqqz1v3knARBLoz664jVu9AqaaxdhkL/yCLmeMFViPBruBgL2+3yNA4BzEEj09Y5NILzr4OsTHVVRIQja+QprXMxIWA46pIIX1tRlEyf8o1vzAX9iH0VPYdFBJXMxcSlLoG22S9S3xr/f+TfC5CwpmvkYFMA4EfIJDV/Rf/EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:47:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:47:01 +0000
Date: Sun, 24 May 2026 15:46:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 02/11] bridge: add bridge_flags_bit enum
Message-ID: <20260524124652.GB74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-3-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-3-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c181519-00a6-4ea6-b87d-08deb9928cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	WJuiUM7kciiKG9cVQTi3KBJVfhSmu5O2jhtVC/a06CvjDPpnCAer6CuUgdyVkX0lqs04HEtmJyKmUasCHhNqPxukPAiI2lUVD1f4/vTVBRFFzvGResFDgOzppbXSavVyGsh1SS1GOS84zz46Wv2En8L0R6dsBOuXp3EYVvoCsWYCJ5txQfTu/+gyKNWookkZ2P970fcCpMUgJYzZF1+oXwxdY8kZ1QUiM2MB3Yvh44+cw46HWV7lAGFmtfPfdTzYyicz1AU6hzZgljtWdkVPFo19pqeGQu25uC2y4SaQzN+YEbygHyQjID9umNLAVP4fnwl8teiu+BXi2Z2QpXZ4EzzS0k/uA3U4FUVitXS/J/BNdsqFOqChxXBBP5XVk8bGm/oQgehPJAlrKI+tvAGAHYfMUIqbdVQzmm0dJqpyH7tSuMvCOU89bFemMX3QUSqwDcTl5VmPrl1saG9q//8/Qlnt3MPrZaBb3Ms166htD5JAabnTODvxOcpIq9pekMO19wgYBJzXzkumadmc0KCgZb7VWV7Oxkp1v9YdsoThOx+LzfHiaZ0x96reiagc9IcaBhR8p6cRjqh3/PP0XimfkUFt1prz8P4Ib74OMNXgGoKpxI9Zj6rNGHFZ97Nc6dd6jh0cxyclUF9t5NeW1s09KDQq7JJbgw3kRMzu9zory40vP2FQCQXI1MdMjrVMKeDv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q77x8CJJpSZ+a0iIyULRXTpuI5td66Qd9WqNXO7NqrzL3mE/sDfDESN3+z+a?=
 =?us-ascii?Q?TbmgyEd2pES4Na/dFaxnzahdKgV2Lqx7R2Xi4blp61g5ycthbpSVzGf9BAE6?=
 =?us-ascii?Q?kOUpfAODToVwpI6Wr6B1lCH2WQH/5G7Flpp4ZBx5NJeC/kNRb+2YV6mPEuwR?=
 =?us-ascii?Q?nxqZPh8c+NKhL5XbQkdGZ3zW2eFJrHNX00uLPbMIUjy3DYT8DSEkZWdpIvkB?=
 =?us-ascii?Q?5IC5oy8pyUR4Baluvkr9wr425BnYWMwtZEdCr+I5mg0mcRBTBrnbkxPimsgY?=
 =?us-ascii?Q?AY7zH5cHtQeDrXbO6mALrgTokXrKhRyMan2wodMFKI9E0ooVNWQe5/TQJPbx?=
 =?us-ascii?Q?z/K8nVwYuLW9cLN7i/hgmgUnX+RgilZ8/FuOZ8yx2la4IaXrAqZ4ur0Wm/Ni?=
 =?us-ascii?Q?JssQRC1t56DJmAD9nzEcVPzi20DeoCLO1bV3XtkH0TbWc/jsT5g39/76ZAcK?=
 =?us-ascii?Q?0aCsR9koH2BGhFsrtJ8T3rxPEUjY42oH5bU9641F4eh7j2O4LE8ihaDY3mTH?=
 =?us-ascii?Q?bgl2IlXQols+22LZ2kGfG3A8OviRN2gUPKWtYE0l+Pf3a87SSI5TtlR0/HoG?=
 =?us-ascii?Q?5eX2oUDZT/rKYwki/TFpoTBGFjl3IOsGS1mazJwhQX7Jo0SXhhp52IOI4mnO?=
 =?us-ascii?Q?dcXmpAUobrM63lSHVD0FfFZNk3M3rU0C+rmritHpB4roTQxKMswlgfE94zzZ?=
 =?us-ascii?Q?VDawOs7Ue6zuGln2EkefGiaIupUTEhj9+n4boFmK+YJwzE8S3h78CHZ6+40h?=
 =?us-ascii?Q?bdfqfaHWYCqWj+1OQxc9QdcAwJIzH942mSpmwdkIDoNoGkUIxQlvo+Gzcb6R?=
 =?us-ascii?Q?GchTZ1J9udpnRmvaWxDydbTVuVV+uF7ikZzmcgMXVilIGxxuYIHK/WfnBhls?=
 =?us-ascii?Q?Q75CYNICeos12T4zSBw3o4iLZe3iutFtbEAx4CB3vjE3Wvtiy/MbrbmdFkMZ?=
 =?us-ascii?Q?3e1Mc/S09GOOluE9LVQdUF3sAZ3mtK3+DNiI3CVFUEXFYAGccGLyYEwpBKJ4?=
 =?us-ascii?Q?83Dgurx1qHVng+BbD24zCoP0wU8p1qUXGd7CmeuhGNupnbOkyipkOX+fesuO?=
 =?us-ascii?Q?FiTfpPfhfnvcxNb7us2tEK3gtHO3eDlku27blEwcE7EPIcn/FuhJ9DuIyw8B?=
 =?us-ascii?Q?vTLCxY9uKH+HaVCBiGaNz520jgxhevIdo8SrHSpsdJyPn264OVtuzSJSeIXh?=
 =?us-ascii?Q?2dij12FTS6mwNdDzUeNQqupbvwHXw8eLrYCuag8Sd9U7GVtUEoLc4N5MK6eY?=
 =?us-ascii?Q?dh+tEThCc9iYzEJcIS0Wh7fuI9aNUn9YCLI8OeWscgNCHZsQy9XFMUEENZsK?=
 =?us-ascii?Q?H0M9B3oJvppNmfVWXRsASIlFUoZA3RHU8C92xlje3beOvMFuzBLXsl9y081Q?=
 =?us-ascii?Q?7uxq+KuKitYi72KFdta6fAT4aaSkzkOvNnhXEOTA70Ki4ite0nHKC1PdNdP9?=
 =?us-ascii?Q?16bRKD9vtklAOU0IEU4b6dglDKbUBapF8hjx9qHn659VvvgmwxH4YVfhAHrJ?=
 =?us-ascii?Q?UnnzSplUaKGjzMeauRg2IjkMjqisYHcL+Zn3PoEHfA86fJwbKu4dCrkAbBiS?=
 =?us-ascii?Q?WoCtwPaT/oPKKUse74vZDTR2XHMrCkZisysteedlgP4gn/Ij5h1H3ogaTVDW?=
 =?us-ascii?Q?7n1bHuBauf4iBsjA83yvZlpuPV0w6MegDBZrE5IgS0LXkq6g3f+wawPgg0dn?=
 =?us-ascii?Q?UrntO8WYOpnI77ipq4LNaclzDY9oTR/ZZAE09vBsOyffooBM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c181519-00a6-4ea6-b87d-08deb9928cfb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:47:01.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Olz/7MlQ9t0J/pEFrKxILi3QkXmC3I+Nd3RbyS/GeX1/0JAqZsOt/L7KLNI8GeRfqfduRNzyoTpRfdLRpFJtjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291172-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 23E015C2672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:07PM +0000, Eric Dumazet wrote:
> We want to use atomic operations for lockless p->flags changes
> and reads.
> 
> Add definitions for bits in addition of masks so that we can use
> test_bit(), clear_bit() and set_bit() in subsequent patches.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

