Return-Path: <netdev+bounces-265669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGPVGV8Pr2kYNQIAu9opvQ
	(envelope-from <netdev+bounces-265669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:20:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED423E852
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39471301F492
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB652D46C0;
	Mon,  9 Mar 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hn/FD5N/"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C817A2F6;
	Mon,  9 Mar 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078512; cv=fail; b=fkX2Svw+213hDzGG4Yh8lEahHrgJC7AGyRPTRJqumbXqp5Xxq/rWS+9WP8NcQay1ki6PmDLV8FN5phFnSBQfJNRw+3SAbx+5/6ZGVYHzVeatnTAEb/mcw3l3rghCOt9faWmZ5scd3ouRyykXz6PV/yDHXQzBrFPiZhvxZBy9r04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078512; c=relaxed/simple;
	bh=EXePvEF9wvwVymxznzcuRN6GxklalSk5wUWESj/xkwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TwXAG36EsXxptbSS8+7AXL3kiWdsBK/RqFOgkKHczZX/ebGDKNdJDLbQw99VPot2ETZX2KdKTcBGToXtllZCkEF8fIU8rvfVcUX/qinLSjyTis1iDvVVlZEQYMtBPDgN5UkNhbUyn/UeUNKXewtlO5iP1v52w8fYUbsyh/Iqfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hn/FD5N/ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5ryl1YGl68/2vyAf64Wg68MjRijPKEFy5a93/72RGfAE5oaokR3BcOie/Sngu4aJKMXjyO/h6aahj4x/wGLn8HX9pg340ywwPnZtxwY+kXmme2wwLDXxuAKM/13L6HYrA1ZQsgVdVD/lU8HvTS1BvNCIqpK83QtuNR0Pm8cG76gPsNC+VmZcbBYHY5lOe4GRmA1BX0viyfpFnMbuyoboiW56M/NK6Q02Wdmd/j6NarO3cLcfvF3yDHRopPfTl9NkrrXPvHiEwlG0r6vdaWUrR2p+5pJrbKcPFzcjZ1HU+YFAPPXD5gRGBNteeBnf2Lq8K3Bcfx9pXOBGGZb2dQuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgaCeqN3MU/kgyc3XWahy8n1idsYdrlGHT68BQa3nrk=;
 b=Rf2c1IXfrrJMbuJfFfikWFS7PHNP5EiyPpGDhEYBom6yUH496Qh5LCOBqqfPh2add1YT602O0nkQeC9YQe24B9YrBnraZOzsS70UeWUKBcArrPGHCOL2BxLwNixXjJOwXxibGZcCNcR2GhNEQ4N443MqCLMcU2Kc7wC8Ay+LqkadM1NNZQurSJ+anO1OgnEGvxBT6AlXIho6IQeq5rYnLNqxRLqv8+KhB32/H3YuBi/Aa7Y3cNwYeZfoHg98b2tPWTL1Z0iWOEJumuQDjvkc0b5BZuxX/1kQ0bGB5D2ibHonud239gJF7KnGoxlI8HrtcxxDyYQ4fSAPpd5jw4q5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgaCeqN3MU/kgyc3XWahy8n1idsYdrlGHT68BQa3nrk=;
 b=hn/FD5N/76j7tjKYyAOYm3LMlUaxm3fXOJgjwaRdQKCKnW8hXvJnloSyCOKYTcDHIYORIrVoxQ2+QWeAixjRAuVLH/F0AhkpK45UmJ7D6NXZHkVQ+wHmuzpHHHmp+v2QGTv6U2ahTfWsOru3wzF75CItabItEO/6QM29vi73JZU+0Fs6q5zAPXRi7MiZIddNL4cGDB+t0aQIh8ah4REhrTXcOrqdp/9kkhNA4Ocl1bBgWwGaFZcBV389ugEIqyduxfl0XLGK8kMJHWTkjMEpuAr0u7P3/pBOwK7MzZPNTU1CMDLrAWyAfoIku8aB3TrCyO6sSzeM0qKyqNmIZdWe+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 17:48:28 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 17:48:28 +0000
Date: Mon, 9 Mar 2026 19:48:19 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v4 14/14] net: bridge: mcast: add inactive state
 assertions
Message-ID: <20260309174819.GA2044263@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-15-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-15-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da0cbe4-a055-4219-d122-08de7e0411e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	nm/nuSikqhlQah13e7JufJQhLxn3X2RvmHTVFwNeArSddQdT2+bEY8n7+zMJKWD5YZhASHU1/H1oHnyp+s4ya30G5k+iR8bOQc9LE7kInkTgF1sJsdl4LxARwvDwnK0IX30axE5Kz+BPenkBSr/g3JwptRnhOk+iJP/tu4VHzkJmCp/TBkgeCUM5M07B8Non+xrorQnDiWBg5KRC1HopQLiKfsqLep9fN01dBTYgQRTfCb73eKvJMiaoKWBRHCZHpspr5FZ13bazBA4Q+YlVNh0vDb63pifJchz9ghlG5jXjtwIqoSNkYWby+WLNhX3nooL3/3nMTqLpkMBN5Ks7xqqFBUIcGLKP8+Ip70bUeJow4kzEjGXHYgsbcSANVmySWjockfmgzMILkSiEc+nz/SBv8eDPngEBZTJElA6XQ7guilaTrGP+th+xAfkf0np4D9ZkzWHLizBZTBEcDSVGs2Q6x399ZWtm+Ofr9nFG7Lz3jVYi3hcjksQLMGVddaInhfl5TgIpOp9m0d8tN9FgWSiTeMPMxlkb7eCt4IQMZB2yZ0gG1a0foVIELxN9kJiuqhr/fjnn61nlM4LW3oUz9eQ6fjwyEznwZGTWo1qx8UxmwHsHJkslqE3bQu2cHoqHYZnPu9EV7tFTh2CECgdNBQwIf2PpmP9VeMHkI2gHqAydkVPgaDJphgz5pInHKMY7bAhz6ntFTpC43OlFJ9q4fzGwoIs5s0EsRUqLEA90lu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7FcJ2Aw0RzqvJ50mUBbRCtnCIoHaE/Pd2mTUdJF2adhzp3PruLMiGHVyQ5?=
 =?iso-8859-1?Q?2FbZMr7uGZtQg64nkCM5KZSSGix5jne46AyGyTtfQLp2+D1jlc8rww9e9E?=
 =?iso-8859-1?Q?Y7PygfOASbr1fcGYAdhtrejqAfkfHWisc63Wc2yDBkcxsDO/3ORYuu+YYk?=
 =?iso-8859-1?Q?3gcg+QzgFG0iWOpwc7nNTmPjyc3B98/EGjTlEM6G8VJig7T2QyIv6yB7zQ?=
 =?iso-8859-1?Q?khXi+Fecuj1/1kMJZsjh1GDqc8rxR6b8IikObVzeNHY5Ixhl/ZNRyQozs0?=
 =?iso-8859-1?Q?Uh6rTdb0MmmiIt3hhKKRpybOE28DGjOID00IR3knJ6URYIlWZylDVYxKB7?=
 =?iso-8859-1?Q?XHyRtAFETXMR3nSJG/aAU5UpQzHp8+FJ9J6nNj9XUG7IqRa1zxWA8oBqeC?=
 =?iso-8859-1?Q?CdY3qiNY5OeXc6jPqNsRtVzjOm2ZwWBP4vwKr7qW1yywoG8aNvOLdXDrZr?=
 =?iso-8859-1?Q?ZptTV5LikSlURcmXBl2FsP13asfxU1+BQ9LVRCNo76uwVHQhx6/ZYN18oV?=
 =?iso-8859-1?Q?gxBD6+tc6Kc6ri/wVFIEllfwPVhgA2SHe3nLtfci0Al4f4mWQ4HfYz9hUG?=
 =?iso-8859-1?Q?wJSmJ2s1ULVITiPTheFPSlTAYgdhMZSvGYu9damDywhFdXs30Z1em94/FQ?=
 =?iso-8859-1?Q?vKOhNNSIw2jpdrL3+X66SO5BF/6fUrXMqoRlPuNcF+H8NZ2m75XF211Vt3?=
 =?iso-8859-1?Q?My/H2MfAw+la/UF8+mHYFQWXzZyaSc0UtEr+YYVhCngvdqqdquF70ZTcut?=
 =?iso-8859-1?Q?hfGfAX2LnyQcjVLReXtTG3Uigr+To2Mua9OjppG8Pmvd96GjF1A1FToXd4?=
 =?iso-8859-1?Q?sUEkXHQG/LUzkCKUpjlEhINBjMS837o3M3iupx+j3p7cqh9j59yvI13fJg?=
 =?iso-8859-1?Q?GX8y1xbyiI1xZ1aHd63Pqq+codONNSkqaENnQ7SqV0C3hRQNjyfE16bgG6?=
 =?iso-8859-1?Q?BcolJam9xWdCJxzLTlo5HCUoPo0ysJrXSsH9OPmuHKUMCe6vWzw0TwnUc3?=
 =?iso-8859-1?Q?kFfwzWqxdqoSU1WUWB35o60n2LGQ7EWsy65BS/ZO+ei3NSoTSsvn0UKFFg?=
 =?iso-8859-1?Q?4Xe3pPFduyUI0ZvJ3nY0Iwiqgzmcmr8qgtaWLxT0FxC22ez6rpN488d8tx?=
 =?iso-8859-1?Q?ZGmswYVemRnD2Qfe7radR1DgIiX0s7w41UjxaBx+Mm5Mtvt/kaUp0DF+pl?=
 =?iso-8859-1?Q?JeDzySfa2CT1dD+Tw0PGI51nHVWviyXuGc+/VEJAlAuyc4n3VFBWkTcfPc?=
 =?iso-8859-1?Q?7b18TjLA1OJgxGzwBGRhyvxW7UQQ1uLTBUxMmM920pw4C3DC1ke4CHhcAW?=
 =?iso-8859-1?Q?qD/N2v/v8V1kuFtidJT549a651xq6a/P/INgabZcjBe+5X0pbuylhQlzud?=
 =?iso-8859-1?Q?2TUdWHbzmJJyEmoJKPhjSkq9QIykaD/iAA1gTM+iyvn2KsOZbIZjkyhFXb?=
 =?iso-8859-1?Q?Krr1mXSfzf49o9wY211TYdD3AVFFla9BJE/rtOqy9luPn1D+ixflaXIIa4?=
 =?iso-8859-1?Q?HX9DivvRv5BkoIMoiiPoo0FXEyyV4FrldVk//u7aEy3IavNGG3hplECiDW?=
 =?iso-8859-1?Q?40MNHHL347+QpnXGtZy26VlOWXE1H27MH9x2r1AzUYPfXMDwKne0WXWsMN?=
 =?iso-8859-1?Q?Hg0VNCbr61teGYiYEGl6JOfpOz3bd+zu7Edu9nrcH/5OE7kLs46nC9f2dG?=
 =?iso-8859-1?Q?lszJX4mk99v3y1NOmPRAH5IMKybrzWhAPO6J5CXeX4RLa93JNbU1pyCubC?=
 =?iso-8859-1?Q?HM7i3ZjJ64cQdKVZ4Qz1p4r8xrouRqwLyPQ12D+yow3a5NjrqaR0/FFj+O?=
 =?iso-8859-1?Q?CXz6VgH/IQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da0cbe4-a055-4219-d122-08de7e0411e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:48:28.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtOHDUBZQrT7Blr75ejHJRcRqB+4xTVPHAr61CN5Wrsg+OPnLvILv/3gFb7iAbU/NEuKO2zQ4JqS4yMnKtgWDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
X-Rspamd-Queue-Id: D4ED423E852
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.946];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:48AM +0100, Linus Lüssing wrote:
> To avoid packetloss and as it is very hard from a user's perspective to
> debug multicast snooping related issues it is even more crucial to properly
> switch from an active to an inactive multicast snooping state than the
> other way around.
> 
> Therefore adding a few kernel warnings if any of our assertions to be in
> an inactive state would fail.

More assertions will be needed to cover the following cases:

1. Per-VLAN multicast snooping is turned off.
2. Multicast snooping is disabled on a specific VLAN.

__br_multicast_stop() is not called in these cases with the per-VLAN
context when the VLAN is not configured on the bridge interface.

