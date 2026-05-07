Return-Path: <netdev+bounces-285280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNoxEnN6/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84F4E79E4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84914300C5B3
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3EF3E8662;
	Thu,  7 May 2026 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bo/kp9VO"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4063D6662
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154071; cv=fail; b=p6c9I7YnxvqIh8yMzia5mpRinA9QM+LDqZmMqnZVVU2fWZmfKNrW3i4hP1Wmy7oX9QTBoy5wLV87CUKf2U3w3cCyT1Mf99GkoYC6Yoavc8I6oRxnud7EW82TXOy1sZE0ne4PLk1EBrXRHKgYyXY6cmcX7OXSVjbxsUr07N2cw/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154071; c=relaxed/simple;
	bh=XsvfmY9+d5U1MNWMys23GJJHFeXaEgQ6moonwvWBeMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cfTsxMEH4wMfxd3yGw4IXkG3EeEZeaTDaO+w1DMv5vcXq+YFx5EklyWBTpizF4OCpprPPf7szL2aZLyiear2jN0mdkaG6Jyz47NpRnEi2AJe6IcCgU0+UonRtFzxlm3mDlaTG/Oc0DlyAKve7loh8/CGN+03rGsf+FN6NzVx11U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bo/kp9VO; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoV7DL+ljoX7CU97J6DMQSqJklwLCl5quQuo6chfUJOHUZNDYl4C5vfRQKvmuHM8qCS0tKIYUIfkfUd93nSbQYozKLxu+ltnWubbrX4HNcC5r8AFcBmJcpBB4i1hLCjXseIvXVOXqvLpGZmutj0tEMWJE39Y7Ah6qz979a1mSmRKDEQrhkp05po8dWEIuuUJHqgDRXPfM78aT6Ei2EcdVHymDbckhmOG1P3/uFMpaAn9wQmsblkokeuL5UvPqfnVfAAOm4a3cuSDP8Ph1csrE6Sj/iJg+TpKt+p1J8bh+wwoXsWyEbpxJElra1wS92n8tHv3PJdfFIDu2O1ixQ50SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+7iEX2nSuj2RBt7lZL3hwjxcq1mZi3ZVYjN6PfyVhs=;
 b=X7t5mb0VU+wTpOvuzPZavUdfDUxd1xTWgCfTR0B6S1zm7r1vjE2ky4nz79LZsKCDiJQx3U2YSXR+9+f/tr5OcvM8czv+YJkzjzXoxvR71+kqXsTBuT4J/NVsraS5O1KxHUImVicvfPM5x4FwW4NLpadoUXlGCwMyXNOMpDwXltFycjG6NyuiCZ+00FdCBhOoYflewRn4fxQuMIGzFFIDvb8G/yUiwU7/He/KXCN0P2c+hVn1G7bc6au5sqpok0spVNcrH+hhzZNq/kh43PXELXjLpGbK0wu3vJFi7UkI6UTQHIi5RuLF3TAl4qnY7SiDKZRsA1dExI6YCpVAjwITmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+7iEX2nSuj2RBt7lZL3hwjxcq1mZi3ZVYjN6PfyVhs=;
 b=Bo/kp9VOp6fAFaFomSBMIVLywmDCaIDzulAerKWzfS++/IFqar2/uiEU3i1gwQmFg7110Buv45nfvv1O/yce/bbL8UcBDvgpubx7b4dlOeYH+jefg9t5LED6ehbL1oBlFE8/R+U9mpzBd8GmEstRwKupkW4FseBd77Ky+kmA927LHxTmM01gsJOJK0ZusnCmFZVRUrE29boJ/WhFzfyr+0AZ393YExZTquknr0fFuEy2H3Uai5JMeTG890sN+FzkJNWvMZkgEd28qjQxJeGGau1fk+9N6+hP4FugEDX42hW7Ev1aEle8EdAFSooH10mTnW75HwQP3KnveHQ7pM4yzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 11:41:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:41:03 +0000
Date: Thu, 7 May 2026 14:40:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 2/3] ipv4: Flush the FIB once on multiple
 nexthop removal
Message-ID: <20260507114053.GB908463@shredder>
References: <20260507075606.322405-1-cratiu@nvidia.com>
 <20260507075606.322405-3-cratiu@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507075606.322405-3-cratiu@nvidia.com>
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a24be09-3898-4f1b-e157-08deac2d84e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	xUVN73Y02UaQ7UN0gi0fk6zxHZwizAiLtBI8nCn7hSgrDNGvSyqiIjkRunxUm9dt4WIaxrhPBdYhENYEyrlwtSHtXMl9nvqvATMxfz/GyCSXh9M2VApjGkD6f2Mn3lBpY6gBMHxplYmG/j8wFuQ6944K1IRXs7WfDOwtB1Gi3HrMLoTmZiBOnDMuFFlSpjb4s6uNL0fdZb7XcjUmAlTH8M/nJVQ+Kf2dTMXrbK4DwlKw59365B5itTFcek2psX9EYXaXYYvyG6w0BHyUoXD6a0bB8fka5QbGs0AKVxaFuDX0lNpxu/1Yxz6mgoaKb5jbvUmPt0s3TvwfIoZ5qeDaeN+xiYkK3R6IriT83VosuSzgDSfhFN58dpGtCSeIg1fwuBXEW9vAIYWvX+fSrSjx60S5QdJTdeIX+PLaZG7t3yJYV+O8a5xIYNCpmCATMHTruiqrNVxUCs6pH/7Mf8QOn9o3IdJ9nNBr5gdjrJ65+EmAaYnSG8R7YRXkf/KQHO77Mz/CDNfCnGFXblvGWPyX6ChfM6TNkuTwmTDIHl+Dl+HwwCF6ysxENPXn43mQto38ayDxdJcwhJvLfqKNTgFtGbrCXH3P4CvyLV5VqoG6s6IdtmaeowzZKvBUcwCT6C7QanKL6FQwmCLdLYpUkVVg6PEUE/QD5uoYf7bAYZNPmkZNrdp3/N2wcRQoVTw8LjRR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LTQ3Yu4sobq7WQ530aKeR55MA8lkYnD0G4Dq0Xk6rJAcucByHh/iCOIBpi0e?=
 =?us-ascii?Q?E652Ri/BgxqNFRMeQ0hM0hz7KEJ2EVbrfCxsfYcLJuqL6Gx5IsAL3hpMxkfN?=
 =?us-ascii?Q?ueTzRFVH1HlXL/KEjS6IuOIBfDTe6lPzH+VgQ25h/ibpcfZt+j4p0xzMYSZa?=
 =?us-ascii?Q?hDk/6aPZI29uZR/aaEs3r8pMdC+hWA05do5iFa0iPur/FSbNOjTM2L9HuU41?=
 =?us-ascii?Q?5Nl5mSeaL+mMJtTeROy21XqA0H90JGTQPhRZh9nqHeKaM+EkjM8/gtkauCXY?=
 =?us-ascii?Q?2ObDPd1WYD04bOqXUmdf1ee2TBcmpIcTC4hup03ddZhIAdasf8FkqbS4KbVX?=
 =?us-ascii?Q?FxRzFSs3SuWZZbEmcsTW7JAFvBKh7pbbELxWBZbM/SxrBotVZvl0tbTbV7H5?=
 =?us-ascii?Q?ZKvBNrVITbrYU2HYq0ARv27wecSdqFXFyCapzRgRajYVD90mvKxGoPdTTyom?=
 =?us-ascii?Q?nnTv82WvkSgNpnYnlozcWddRkiLwxHkqq/IHQpll10NNJ0/iBLoB+o080jb7?=
 =?us-ascii?Q?te8i1FZfzTgKo4yJtzY8qHnQBkz0RgbfLq6KLDvqnBi+TiD2C/Q8nUPHeROn?=
 =?us-ascii?Q?f/XhqcOXdvJw/KGX4uK2PCSrQH6twFyBb4iclla/WOFuKTUqGxke4A7UhGQq?=
 =?us-ascii?Q?X2NyQIGPdxDlyHFIjvqFGWAJM6r2cBR6UqPSdIha+SEebJhzrtBynNzEbh9e?=
 =?us-ascii?Q?i5aMi3pqfBopXsh8d7J2u3pPxkdiQaVQ0utb8i13hGjpbq5OadOx+hWn5Nx6?=
 =?us-ascii?Q?kwTL8PjLYl4JmRWtceIgmlkrVvIU07dAUnD+zH4gDUMVqFUrHIAb5dcER6R8?=
 =?us-ascii?Q?YB5vJLfA+YTdYT4bwc2zylayBJrU2Trtf93cjxzdKJ3VIU4/84HWnlW/Z6Dz?=
 =?us-ascii?Q?Jyqup+PHMqsStHs9coKEdmj6xLi6kc4FXt8qJNAG8X9P0tI3qpzVYR1YhJ5P?=
 =?us-ascii?Q?f3zXxSWJ6Mmy9PHAGt5yZJLOKHqJCG72dq44VeZpnD67u1gX91S5JHgYHfUV?=
 =?us-ascii?Q?pJk9kvwEP/suE7cugZDxIIKqvsvZNYT7p8cl7PDHcUcVh8jrfSy0lhqzclGR?=
 =?us-ascii?Q?0LTmEKsfk4gHNf5GY+wy58JRP8Oj5qtNtx8yNItIN0OwCL1Wu9F66G8luEEv?=
 =?us-ascii?Q?5n0qIfhiWpDzCyO2uO0EqaRnsLC1bl64Aa2PIbqJfNKiLNar7lbVPxnStSbF?=
 =?us-ascii?Q?ji6bUm5id0ZKeTR9m3OLVMTOqHOzL5995KHQn1Xvxf/NmMJaGaqSxqa7yLLC?=
 =?us-ascii?Q?iezYH/YogF/AT+adS7iCybgXKQkLolZFPJ81ZNNgbcrLpzJzf17W1fPGpmPs?=
 =?us-ascii?Q?PiQH+W/OCbT1ZqiJwyuVF1BeCPmo7mENEoD406QE6gUj4ylwlvGrHI5xFq3d?=
 =?us-ascii?Q?xI6a8yY4TQsYsu23QjH+19FUPZvK9a/Dh4TFfAed8I2a0ieovyfx3iPfDexA?=
 =?us-ascii?Q?w63WdRq5wPlsLtUxmMTKrNYa1eJ3OqoEXZHvGBR9LbMPFyYbCPt5ITCloadM?=
 =?us-ascii?Q?zD3qNaFGB7i+nmuH49wWSMROxonh2xLpnAYjTVxZEjmtlG70xE6qz97ls3vV?=
 =?us-ascii?Q?VLtO7PqX2d6xj/YiTKmahhoKyGpjW3t7kfqIOpT4YjhylTN6KPYrvOw9+9WP?=
 =?us-ascii?Q?7e0defcgIBU/fo+iQ5/8xjLuuiNWtvFGA79RgfKxx9b3r7zB8pLdPzlUXO3T?=
 =?us-ascii?Q?Geh1jAr22uUHDckYrsh3qZHk0faRi7Aa0Wx6x9xKFdTL7Hf8x59InYmJ1Xqh?=
 =?us-ascii?Q?vB6gWRz3sQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a24be09-3898-4f1b-e157-08deac2d84e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:41:03.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hesJ6HRSPsLIUZEEmt61guBtJpfaT6ZEddacI0iGAwgZR/8v5b5FzaggN0ZimfUeFhhaVgJErUmq4WF8AWD0Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Rspamd-Queue-Id: 7B84F4E79E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285280-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:56:05AM +0300, Cosmin Ratiu wrote:
> When a device is going down or when a net namespace is deleted, all
> nexthops on it are removed, and for each nexthop being removed the FIB
> table is flushed, which does a full trie traversal looking for entries
> marked RTNH_F_DEAD and removing them. This is O(N x R), with N being
> number of dev nexthops and R being number of IPv4 routes.
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
> This patch makes use of the previously added FIB flushing signal to only
> do a single FIB flush after all nexthops to be removed are marked as
> RTNH_F_DEAD:
> - __remove_nexthop_fib() no longer flushes the FIB.
> - nexthop_flush_dev() and flush_all_nexthops() now keep track whether
>   any nexthop was removed and trigger a FIB flush at the end.
> - a new wrapper is defined, remove_one_nexthop() which calls
>   remove_nexthop() and flushes if necessary. This is intended for places
>   which must remove a single nexthop and shouldn't worry about the need
>   to trigger a FIB flush. For now, the only caller is rtm_del_nexthop().
> - The two direct callers of __remove_nexthop() get a WARN_ON_ONCE, since
>   the nh about to be removed should not have any FIB entries referencing
>   it when replacing or inserting a new one.
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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

