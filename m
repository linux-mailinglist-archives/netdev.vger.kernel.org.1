Return-Path: <netdev+bounces-299440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ASC1BY/0L2qUJwUAu9opvQ
	(envelope-from <netdev+bounces-299440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF768661F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=X7lOisYi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299440-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D0D3162B47
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010B3EDE4B;
	Mon, 15 Jun 2026 12:39:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0F32ED27
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:39:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527151; cv=fail; b=AUvXEzUWCK/14+C99S8IphpTpywv8JBLk5N/QfFeIW+aiIltkSuwP4aAm6jKisY7BRUoF4nOHS2IAc3jsMteXxcaN1Mrcs2/ZVimOyihKkgDefxJnh+s/ifs1k4UTFdzRt0eVnRSfiZl7Qtr89TLq5KOS3TYkc74UOjELGutT2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527151; c=relaxed/simple;
	bh=ogIIvT/PWD6E+MIWwlwxoE0soEtnD5tIC/8S/Cl6mxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eiTuvipAtwHUUS6MU9nz7bfTEuVyoeGIJLz/425NezUlvXzEeDEj6cEAUDMcmA2dViUgpDFe4yZ6W8SzrDTwF04yZ5KBGUiFRVxmFL9eJrCPgOMBMmwpPDh88MO93+kUUypPatkPisjo1DJo9qfqg5fWtVqYnJLFDuYWNflTK9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X7lOisYi; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6A+4Hx/oW74NS5+jluScG+jDcxyz22IDZIDfCWO9yLdLHtitWYAJDGe2GFybCG3QW7ng1tUfQxdLZmKYPrOI0ePr4mXCxdN7WuzjnnXF69CeOLfyQwvBf3PjTEJRE+yBrLEE1jFfFYZ99z5/w9iOT59/JYOJyJr/awZQoE4i38IWkXYFqHrvYRNsIscEhVPbaZQtJ+uQ02oR3y0cHGzlavek8yw/NrRcSseUByKKZr5CdZhpPWznobxKNbXodPz/XQ1tFgJAi+ewHXD6vfcxOdRz7yxoK3WRJL8Ug/fC1SYQTtW8/8cPH4Vm3yu9CVzDv6d6XBZ4ypadZaIFdxXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opc19KduVtv3l+05zV7NbBHtyWLBDsnRdRijZYtfTCY=;
 b=GBZxHY783PIfMtLJY3tQDO9WFFLBofYp8mCjkiXyxLEcwLHvaYnuOrkd+yAISXzuJc6Sthd5o3jDArdU0UkCjcBvG6G9p8Y45fg2ae7+hKGKrbYvxXkJJcCHDuk186UbKehqEBlykSVbHuLwzSPyD/ek9KwGQdZDdM9wWBG3Bo884jK1QYd7wBr05Pe7aWSdgyiXCSsx3beipdY3c59ynLH+BpnB3lWE6M1nDI0vuhxsE0uaL8HS0Iqfort/CRuj5x79zeQpC8IAyR5YZp389cJ+Ew5gArRddZWF9gEcmI8/muQdrtRQDg6Tmdn1qOOyZs4ONAjX2wTAbvEvhavyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opc19KduVtv3l+05zV7NbBHtyWLBDsnRdRijZYtfTCY=;
 b=X7lOisYiEZVFNwbDEWldGwO4WOSTVi6hRg0Q40mFZLtICUdfNtB1fXW8HB7y4L6WolQdOiP3mpCykIJgGGsNgkmDqKLs7Pmk0LQjIoYqzEZ2RxwK1Crkh52lExZjpTDPjy8yqCvBRfgj5Chp0ajO4w8cQ9Ml6wMmV14gPbPBUhyxrWVHWDKRzCwxUO2LX3DbkyDlDnAdB7/WKH4jVQjW6Rvjbr5g5vOBRyxpCxVCxCfggUEX2wUSH6riOJV+mAZ2iTABsknshWIVAbTrvdRh7cdSC/la8rHQctf3PUTsfEqVx+V4dZXMNQmA97j6Nyrd2sD95oEMUZBmDHCfa2WLEA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:39:06 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 12:39:06 +0000
Date: Mon, 15 Jun 2026 15:38:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 3/5] ipv4: fib: Free
 net->ipv4.{fib_table_hash,notifier_ops} without RTNL.
Message-ID: <20260615123856.GC485439@shredder>
References: <20260612063225.455191-1-kuniyu@google.com>
 <20260612063225.455191-4-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612063225.455191-4-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 23007794-50b9-4d47-92bc-08decadb16da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yj2yAr5HZTOSSsZSPIU8XvjZyEujZM3K/ts7/U7wYQiUwL6kWhPNtS+ffbmhS3wIUqdD3Dl3EmXHTRdarHxgEr8P66VoLONPsJQakJKTFo3e0GFKJptv3+Le/y4xYzD/k9T3w4MKSeXkj5P+tliTt5/ormMVT8fPYX0ACjcv/tiZ6IOMzKhoKkU0jvgzOxu87+6t4Wv0VkTN5f6v4GgwX+DLOUfAk0bk/G78x5/GYbc5Qz811+5k41nWexLbMutWEdQREuRaxzwffkxSMM8z2ucNQ13qAhRfvrc7pK4KVr14ojw4cuPxW2fqcARx7mvz+iqiNejO/NUzGTfFqHz+uqGxweEhjx3w1AgxSDLpeFcryqFQgXFOt4XNDOO5KSMj6EKzFM/vXqONmDDSqs8eGvqrdkCzzZfFSL7vmwhd6FTRebwWYf+4qciW2VhjepXGZVw7JS3IOteUxAGO5dsSLkSxpXffFcQLH66mlnz1jifHrEFaD4Z2pXSefm+cheLoOOodQdBOjSO4twGWcsfGIgaOU49HUiNXeeJ33o3ooxGM2mjW3uM4DZzPu0iKRTtu+P4IDugBUDE0m+n7ro0uSeGDg/Xm56sfy2mlnhdk0GYBi3JiS6f+j4SNqGyNmQbv01+iZy9V0JDKKDEct9jjR5VVwvglb5UBt2IdQiIHOexrxvTJEv2mvZHkEXTGjUSP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcaJs5IaypoQG5Lhut6AhaaIJIZaic3F54S6M9xOKn/03D/9WAmwqV4ne+Oz?=
 =?us-ascii?Q?ZApc5Ei7oQFqjj2yLrZsOEU6n38mZeubbPVqaX+HacXbLOU3YrvT/Dug71sB?=
 =?us-ascii?Q?H2PvaFBoMy+XZl5hm3lOSvoDHWnVTL44toUs5Q+XfJ7LhywMzu8iJVOAu/d2?=
 =?us-ascii?Q?uzaFNYQqTX7xCyePzMmU0rkhRBIJc2fX8gXYzaVV7MiZWSks3qCYuDnXmJE6?=
 =?us-ascii?Q?hP89HohXbpVC4u/663do7v2OKZUsemY2N2s8hKk+u6pDDIUBAX85eCzF3HKl?=
 =?us-ascii?Q?c2FeVrUUxmJNswovDCNUsp5bo4UCMcAL9DyFvUo9o9m1aUjjtSHLFf320PAv?=
 =?us-ascii?Q?G4rerZVVZvcAjJCj0IF1BkOEwaFR7G9vbqrb4qKst4oqd6CI6BJPYHo39jUe?=
 =?us-ascii?Q?f9zWh3tUQvukzwn88HBPh+i8DLHwriqmZnPXbh4erwDGj25TWWRmuaDtKndX?=
 =?us-ascii?Q?FmgsUf/327WhtDXwJt1zGSZVBfwPkT7RSDtIiXqaF4ntmTwxUQoCJ0yWNdEe?=
 =?us-ascii?Q?yPQRyStCOWXC6BEghwcuxy2vDn/n8WDYP4EZzlJrtAiyVZKaBaGRyOPw5YoS?=
 =?us-ascii?Q?pFJGfMuH2S791MdyEx8pGM80zr+d6dafnOgDOSlcznxisN6lBZ+NKWgfMb2P?=
 =?us-ascii?Q?Orp8dygV3mpQBEF6aoLXTkP98WLRd0AmXDXGfvqrLkZfPD33cfjawBt0ueez?=
 =?us-ascii?Q?O7zMmwZEPNrSBdbl4UxzYqXQmFsRioH9mtNfUlX/U9AW41SaVABOitNbM7PH?=
 =?us-ascii?Q?Hr6QSe5zXwCGCZ//Nh49bkgcFSWFKIODvUGG9nL1Quisguvp4iIW2dLVW6NM?=
 =?us-ascii?Q?xie6ih7JBSXjSiM9RvGxEQ4Aq4EhK7qBS223Wtl8tF1GAjtMWe9lHJ5ANZL7?=
 =?us-ascii?Q?+PVv9+JlFD+7nSo3goMFonxjhMqPMxWvw9xRPiDfJTXvrrgBQwItTlx7ay5R?=
 =?us-ascii?Q?wSS0zen4xZzRxXcNK0MPAbx4hLLUUPCHcP4207v5ORUqEr/E1LIXXD4fwC2g?=
 =?us-ascii?Q?+NDtw/X4wA8GxyhUF63a3FRa5+tzDpuBtMXP4R40zfJKdHVQA9f5dKSZQJlc?=
 =?us-ascii?Q?0iyfU1LSlrvsuG5IdGfNEP+UKPH2m4tmkI7B3eTJC/Mrz0I7SfuZEYrykJIw?=
 =?us-ascii?Q?LnT9JKr393KKUg+l2TabQ2zfFnMVwX0eXjLz+WJpNN2Y5FiV2a6qRzhcpBmB?=
 =?us-ascii?Q?vJmPg2QVMl5w2tspa2T38vkEWyUVhZHxN9eKk2pgRGQ0r/vOhg/My7R9oiVJ?=
 =?us-ascii?Q?KCx7hH2XaT/dmgobZNQ5JbFKRzkjfiR+vmcOEGxEJGv/BX8nzAZ/ms3S9h7p?=
 =?us-ascii?Q?yVRDDjOJR4ElKPdvSC3lvzYhro4iLOFHCY8u1rfFL21ZdWqi3OtPYNzoKhP+?=
 =?us-ascii?Q?3AsnW2QEBVev2WAdmxwO3sznw1dMZIxUXufQv11+r9yQAvPD5MohPT0gdXIZ?=
 =?us-ascii?Q?zVJFLihkgCT6LyA1XLN67QkfrsPY7mqNgzYVq96wEHvb0gfY0GvztkoKFI44?=
 =?us-ascii?Q?zlMHCm0Y22Wr/7rLQ1/hSXbHuB+yNOAzjgBBXv0cNctUyGIOJOn97ikP7+np?=
 =?us-ascii?Q?4i0sgzJ2LMr59ZxQmzqCXb81aB/Pvj/evUmHWXO9MxilCPI9/473/cjJv3is?=
 =?us-ascii?Q?UDCFREHJ2lusSElvHjNOx9Jx3Mter7EYijScsUh2nYK6HjaBLQCLSZ3rW8DY?=
 =?us-ascii?Q?UAVyZpAOCoLVYvJ/WJUHdXkh/xZ1FCAsUe2JU3Nv7j2eFrG2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23007794-50b9-4d47-92bc-08decadb16da
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:39:06.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/IJxRBWuKbV0m+NyDlHNHnlRbpL7cm7/0/PqghDDtCUtnK4VsaNmi9MRdT/1/4KXCNyj+wgX12dVVPTVLfBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299440-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,shredder:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BEF768661F

On Fri, Jun 12, 2026 at 06:32:06AM +0000, Kuniyuki Iwashima wrote:
> We will call ip_fib_net_exit() from ->exit_rtnl().
> 
> However, some paths will still access net->ipv4.fib_table_hash
> after ->exit_rtnl().
> 
> For example, fib_flush() is called from fib_disable_ip() for
> NETDEV_UNREGISTER.
> 
> Let's move kfree(net->ipv4.fib_table_hash) and fib4_notifier_exit()
> from ip_fib_net_exit() to its caller.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

