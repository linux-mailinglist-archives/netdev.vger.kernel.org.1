Return-Path: <netdev+bounces-284830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AVwEAM8+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:02:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D154DAABF
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D88CC300B9C8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A73FB061;
	Wed,  6 May 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlHGDDLl"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A744E041
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072510; cv=fail; b=A0N9L0yiTdRdSX/U7HpFj4hkp0iZU4vtnsT7gMiKtfWh+6GGovWJvmhn4yPw0zSDF3DKBdsqYEFooAQDNdEKIvkW3aOKwIgZLGP85qMzYXWuaWLLjcwjGfyjy7Koud6LUrdO/XJbaEpAOn+FF/1kCz7eW1ksIWAeoPOLBKYQXeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072510; c=relaxed/simple;
	bh=PpCHSYs+hocJ9bJxYUYCMCADtgUX+fspBMhRXUbDUO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ih27XtKD+2JFZeMYY4V/5r/4UyGZVbBCnFIfiXCBk7GejKJsLJ9DyietnA+0dr9WK3JBJG2KDtyfxl6M2NaC21mGksoi5d2scrvzzd4nj6/d6EtFpRZ1lEsVcUbqig4BNc7bCBi6PZUA0KTs/Lxi/AZNdHBOMxR6CZ4E+W+btMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlHGDDLl; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPjcl50SHOCUqh/lWR68C0xhlaLim4ywXrkWI9K+TbREcKSb4RRyoLpHpsLFvi3xVcKnEkH73saLlZZjD/q7FgeMMYTTsQX43Su8V4as2ZNj8gdNmKt+PBh3WFrLhen/DMzT2l1JjQi/Aga2eWj5urt03BhaXpsEEXLbsWwzZEBbXlTMTidkH/xmCjJ1HVtDNiRwQ7fvI0JmqUSOH4sdnJA52EOka++daExG3NiDbfLNxM1+U5yB7uuppziooK8os1XJ9+B3yg6XlDO10Ot0BI3tq4tNW3uqJD/etkE/+CAI/JkpWK7bZAa2uN5c0X9DSGP1rr5lJohYz3RxUzLSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHgIf9q4vg97dzdj5caPGYeihlpDi1hGHO5G9JSmFkc=;
 b=af+1e9j0y9apfKxnDdSy85SrGx40ZO8fat8GcgMiG/l/vJHLUK8e/Z0c9x1r3KJzenWUGVHBxXYyXF7HOe+ZJfpt1Nob8RT/6bcLN7xG3bj8U3316S3yY860h1BS6k/S5Ehql0pmhWamYZwTK+G6TXIkUXCkFfb+vkRrVWTCi2ExwiEQUx0Zrz3wgKBa108ZIVRQ2qqyJ77RHKhFiAVqNvhFkyXasA7Tv2ByDjeqIIuObHVcCvZ7gvZ+kjtVHyDrJ0UszBtC7z/3XhMpkCAc3Q21x4lMoU6hJvjCRlRJ3uPMwMOTqktk1wiffxUJdAwZeYs6WzstumCtPrgfFVqN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHgIf9q4vg97dzdj5caPGYeihlpDi1hGHO5G9JSmFkc=;
 b=NlHGDDLltqc3PTeHpoLOYDyC2kaRx10y1k8G37TQjiQb/6o9xrVYsKuj/J9aowEin1SawMLGLEstANWjHjlJ/3vD0OlBLT2dRD6vQvyHaGM9VqVVrpZyFvD9TV22QiVUplwDLVTuMCjRK5VoJou1JD4vCmPl6dA50t4kefLeJfBkBU5gd2e0oq3spZsysf6Yy/sbGjoFgesDGaMnefsz4UYj3ldckRTv/NuJW653YxmGMJ0P8VlGZKUebmpDfg1b7Xj6RKppeL1LJ57Y8MV3ljB6MQVwdHondyzaLn3PgyBWsRmqRtssTffF0EH3hLICMMd9oehW+kwYEol+2Qs1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:01:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:01:38 +0000
Date: Wed, 6 May 2026 16:01:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] ipv4: Flush the FIB once per dev nexthop
 removal
Message-ID: <20260506130129.GA665477@shredder>
References: <20260506092704.150349-1-cratiu@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506092704.150349-1-cratiu@nvidia.com>
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: d35efa78-e509-4447-2c7a-08deab6f9c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	P6/I3J36cQCl6KSi+iHOd+cxF5pm5g/zJeO8SKwzUpX6svWeAebJ4HetIziXXGk9Rn7IHOf66iwxkbSOxRLccr7qCrpDt/xB1Y15EcEN6mldaYQJfUswh3t8jvra4GLa+Z2g4UdWZM+rvOG//v5oBRASfGvKVhOPtE6wiy1mUxN3r5J94/hfbXJdZFy5oYYvFJ4jbaGJc6llT3x3s7StGBA1Q8N/Pzwdjr3ayTwnnC/cNdA1aJEUHJreyBpP3pHE5zW9pgSiQdawGb0Yi2tIrdsQ03NFyLPjYBbWKpX3cHDIcPij9FJWFsiLcjtY1udLdiP5yiAT1gpt8vHhEKR9rI+42L43T1yAb1iESXNL0Z/I+yIo6agt/VqwikRETOnJW4qSOsFTa4zy7t1u6aSHNyDv+Q/5589vBxfnz8GFJrLnN+YyS+Si4rsqPsDJLZ5qv3F7huBKhvBUM7SmIhp5eLbBUcnzo0uOWPJXGyXmRKxDgf4fIQbVer3+5BbZy96k2+WPv4w5wr8C+oEy4KvgM/gFm1Os0Kf9SZ8jkzpHrk5C+BzlWGnQ9NyCnvZx8ckULL7MEee7zZMIqt0d3zi6MRoEiV0N8j99pOQSHTiAf2FGhflwDiC2qURLFHWPcJz3lZmarctZtTtH//feBGGkdf1cpEcH4p1gniOkWIfdci3Ks14SrA2iCy+N4RcCOk/j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S+2c/WDHk1MWn4GYKBFYYlE4gBgrNaYqrlwk/qd3Jjr25mzhTtjIcVG3cgzY?=
 =?us-ascii?Q?3/WQLCuMDdMmx643npOFoUmqusLvmaT/5Wzctf8GuLLDtrD1y+TP1iu0hxga?=
 =?us-ascii?Q?kor1ZJ3yNbcYTrBVlQ0PcgM2ELX8EZ5fabsJy3jRso+FNSMdZCG//Lnha3Gh?=
 =?us-ascii?Q?bxVRxRo8SzO+OPkj4jYVqXOiBEDLN2oP4nTWxclNCoPovX1ydQ6QkWp7KjGW?=
 =?us-ascii?Q?ajwkGxJjSLfGEp4YY35L8EndvFEUT+pbBqodVdKifQPQWS0I0aglqAp3d7Wh?=
 =?us-ascii?Q?6vT3nBDO2FZUKuKsS2hIUhv7rwH27SYyG3Yt5jwdFf30xIr0vHKudUsEsysx?=
 =?us-ascii?Q?Zcj+d6sQAyDE4rAYAXSMob61OGknKZF4osB622/9Tn/7vFrYojPc96npNPzM?=
 =?us-ascii?Q?Hvus13LDrD3IEIKJ9QHAXPIepgb/c7WQSuYex/HKFgXzbTy8uaA8oloEsjv5?=
 =?us-ascii?Q?rz4xvVJLyr5dvKP0bBGAM5SNEqPMY1RPV7MnbdseMudiFIwkCjAZfs5TwxCm?=
 =?us-ascii?Q?pKy1mOVvEUt2q/xe1fel9M4z/S+0PSEEuiblNXMV3oko8QPSOFqRdAQ5i8cU?=
 =?us-ascii?Q?/qhcPGqgl5VDafgrqqePPzmFWAQX/ahppSVnLKsNe2E/B3R+f7hUUnsGi3rS?=
 =?us-ascii?Q?JPXwa0cHvm/y6cZtXDOA2HI29WlSVum12itO8pDJK6ky+abxaA1aTWlF3Oer?=
 =?us-ascii?Q?iBXRg9A4czaAeEpTC/zJYpVcB4NSbUVwj4gpRoVONj6Pmv27Ws3WWyxE4CXt?=
 =?us-ascii?Q?4eeNjP7fpnHtn3zZsu6rkfY5w9/LmkdFKQITIKCEaCTmbQSKaaMbRzTWXVWB?=
 =?us-ascii?Q?dp45nKruYbJiWUSscOBc9cHThxDqFFzgb+ts6CSy1Sw5X5DgauS7EOehLFt3?=
 =?us-ascii?Q?foeKjM0ynpUPSBIWztr0mr6vbllgbZ8n+PfjKev/zABSvQSnerbr9E9OxupT?=
 =?us-ascii?Q?DCBF946Xntk0Www+Ohc1pYNCThKJ1GwfD38Kje+pIIOkMVbtHcUCrIelS60J?=
 =?us-ascii?Q?ZlScCgtdLoHlYyX9DiD8Vi/AnqJlXhcWjdu/ekg9u5VFUU9KQ1JarWkgYVTV?=
 =?us-ascii?Q?DZG2Yvz3eMr7qt0J0CLdcDuhlmHZeAKEH48lW85i3AC96sqDfvSylQxMowAF?=
 =?us-ascii?Q?NJPaLKzN3jf+7zgWKRdxuw/OrFScZCBoV0Xfr3h8ju8dqA1vEv3wiCJiNgXG?=
 =?us-ascii?Q?K58smaFtbsffCWAAH3Zf8HbTEGXBZWHDeQ1IMmkCRsOkm3duE72od3ha3x16?=
 =?us-ascii?Q?oc724V8v416oE4Tb+J0oc4DL+bMYNG6vkWw4Wh6WoJ+W47tbTyq3rfiHAJM5?=
 =?us-ascii?Q?FZmcTEAnKgaIKfcQ19sTXf9vwdWdRCBElSZnpXXc6bz1BKCEtBchltTGk8Zs?=
 =?us-ascii?Q?srySuwcwnOXHZxe1lwBagQQGA4U8ukHIdrMuRC56e1GozIbNjJigyJBqUg8q?=
 =?us-ascii?Q?zD5EOlFX4LYGMOsiBe7NIQuhtUmBNPpdBygg+mkvqE4QrsTiM5qW6JY0KSL9?=
 =?us-ascii?Q?XQ2WX/DbootpjjfuL6i7FPwaKhzO1K2JmCIJCsEw7VxjgPq9+Hm/Kg8oHl75?=
 =?us-ascii?Q?vJAXDGysfKZ6CfVn5UVBC83uWd1NJB5v3SGb/eGka3yGlKhb9W2oQasWImBP?=
 =?us-ascii?Q?xzzLzgG9nSQYtOKfzx9mGcOTS/slaA9+3wD6EsuqK1U8m3JyfMk9Q75entYG?=
 =?us-ascii?Q?A/WVBgjM1avx73KTwgwOrodxYzrUawps3kWEPOYhp3A4pMGs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35efa78-e509-4447-2c7a-08deab6f9c3a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:01:38.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHDb+ZO3VGRP2/eQkgO+l7k85OqMFF5XITXKFCxWxVQ3ulp315GlJ0kxOHW8ia6D1rFMar1vWF8ShAQnZLPzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Rspamd-Queue-Id: 40D154DAABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284830-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 12:27:04PM +0300, Cosmin Ratiu wrote:
> When a device is going down, all nexthops on it are removed, and for
> each nexthop being removed the FIB table is flushed, which does a full
> trie traversal looking for entries marked RTNH_F_DEAD and removing them.
> The performance of this is O(N x R), with N being number of dev nexthops
> and R being number of IPv4 routes.
> 
> The RTNL is held the entire time.
> 
> When there are many nexthops to be removed and many routing entries,
> this can result in the RTNL being held for multiple minutes, which
> causes unhappiness in other processes trying to acquire the RTNL (e.g.
> systemd-networkd for DHCP renewals).
> 
> In a complicated deployment with multiple vxlan devices, each having
> 16K nexthops and a total of 128K ipv4 routes, this is exactly what
> happens:
> 
> nexthop_flush_dev()                # loops over 16K nexthops
>   -> remove_nexthop()
>     -> __remove_nexthop()
>       -> __remove_nexthop_fib()    # marks fi->fib_flags |= RTNH_F_DEAD
>         -> fib_flush()             # for EACH nexthop!
> 	  -> fib_table_flush()     # walks the ENTIRE FIB, 128K entries
> 
> Change that so that a nexthop_flush_dev() does a single fib_flush()
> after all nexthops are removed. This is done with:
> - __remove_nexthop_fib() no longer flushes the FIB, instead returns
>   whether a flush is needed and is marked with __must_check.
> - __remove_nexthop() and remove_nexthop() propagate this return value up
>   with __must_check, which was also added to remove_nexthop_from_groups.
> - A new wrapper is defined, remove_one_nexthop() which calls
>   remove_nexthop() and flushes if necessary.
> - The two direct callers of __remove_nexthop() get a WARN_ON, since the
>   nh about to be removed should not have any FIB entries referencing it
>   when replacing or inserting a new one.
> - Callers which need to remove a single nexthop were migrated to
>   remove_one_nexthop().
> - Callers which need to remove multiple nexthops keep track in a local
>   bool whether a flush is needed and call flush once at the end.
> - This is plumbed through group removal as well, so when removing a leaf
>   nh causes a parent group to lose its last member, the group's flush is
>   also deferred, accumulated via remove_nexthop_from_groups() ->
>   remove_nh_grp_entry() -> remove_nexthop(). remove_nh_grp_entry() gets
>   a __must_check as well.
> 
> This dramatically improves performance from O(N x R) to O(N + R).
> 
> Releasing a nexthop reference in remove_nexthop() now no longer frees
> it. Instead, it is deleted when the last fib_info pointing to it gets
> freed via free_fib_info_rcu(). All routing code is already careful not
> to take into consideration routes marked with RTNH_F_DEAD.
> 
> Tested with:
> DEV=eth2
> ip link set up dev $DEV
> ip link add testnh0 link $DEV type macvlan mode bridge
> ip addr add 198.51.100.1/24 dev testnh0
> ip link set testnh0 up
> 
> seq 1 65536 | \
> sed 's/.*/nexthop add id & via 198.51.100.2 dev testnh0/' | \
> ip -batch -
> 
> i=1
> for a in $(seq 0 255); do
>   for b in $(seq 0 255); do
>     echo "route add 10.${a}.${b}.0/32 nhid $i"
>     i=$((i + 1))
>   done
> done | ip -batch -
> 
> time ip link set testnh0 down
> ip link del testnh0
> 
> Without this patch:
> real	0m32.601s
> user	0m0.000s
> sys	0m32.511s
> 
> With this patch:
> real	0m0.209s
> user	0m0.000s
> sys	0m0.153s
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 88 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 56 insertions(+), 32 deletions(-)

Patch LGTM, but it would have been easier to review if split into
multiple patches (not saying you should do it). Something like:

1. Change the various nexthop remove functions to return an indication if
flushing is required, but keep doing the flushing in
__remove_nexthop_fib(). Referring to these functions:

remove_nexthop()
__remove_nexthop()
__remove_nexthop_fib()
remove_nexthop_from_groups()
remove_nh_grp_entry()

2. Act upon the flushing indication in the various callers of
remove_nexthop() and remove the flushing from __remove_nexthop_fib().

3. Add __must_check annotations.

See one comment below

> @@ -2592,7 +2609,7 @@ static int replace_nexthop(struct net *net, struct nexthop *old,
>  	if (!err) {
>  		nh_rt_cache_flush(net, old, new);
>  
> -		__remove_nexthop(net, new, NULL);
> +		WARN_ON(__remove_nexthop(net, new, NULL));
>  		nexthop_put(new);
>  	}

[...]

>  static struct nexthop *nexthop_create_group(struct net *net,
> @@ -2994,7 +3018,7 @@ static struct nexthop *nexthop_add(struct net *net, struct nh_config *cfg,
>  
>  	err = insert_nexthop(net, nh, cfg, extack);
>  	if (err) {
> -		__remove_nexthop(net, nh, NULL);
> +		WARN_ON(__remove_nexthop(net, nh, NULL));
>  		nexthop_put(nh);
>  		nh = ERR_PTR(err);
>  	}

Please change both to WARN_ON_ONCE(). See
Documentation/process/coding-style.rst ("Use WARN_ON_ONCE() rather than
WARN() or WARN_ON()"). I do realize we already have WARN_ON() in the
file, but let's avoid adding more.

