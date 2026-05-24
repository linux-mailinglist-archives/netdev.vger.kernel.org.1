Return-Path: <netdev+bounces-291173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L7sKGXzEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:47:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE65C2679
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B447930071EF
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8781392811;
	Sun, 24 May 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p3940l4l"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2233C182
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626850; cv=fail; b=hD6yxyeNKiQ0M7y96X5J1fJxAqu6sp+3T06sPk8nBYCfYh2jJFjIqvakkX135mUvlJPIOSCvzIGkVs/5AVGODDftXq3M90lowbfkLNi71KwPLrflxKq1oeIN5ALBIfWpHZaPP/407fSPHpumMqhdIzjyyFR4pPIubqd22Vn2s90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626850; c=relaxed/simple;
	bh=QBLx8MWBSKq52BPFtjNyQGGfaTiSh6wzJ5B65AdUAg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W8JzkckayjEe+PEG9DtwLNJrEd4USsswFMLWnRmTr4HJLD8TUowk9ICQ5tVvIWdFlpM5UVTU1M1dXrRNa7PC2MdVLLt5HhY1yOvtHjyzu/iIQnoRTN+z/jgcyZRkRClV3PJ5+lz9bkYnwNiOYrh0r+d9dm77Rjwfk6T4qK22WLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p3940l4l; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu6nManVmC34sTVfvnXsB4goM5aH5iq4J6V8P/br6mLpR7S6TsXzhc/XVZZZ288Op46HmxLwfzfQI2VH6UmWYoRMYZSopV5V2TxJvS6PnPRbQg+pwLguD7bgPVeb5XH9h8BSmbUFjj/Cu8r40PVj+X7YDZRcLXh20HDYtvimLLrOB+nNjcv5EGy79r4nW/3UMNmZEwMjOnqm/IWw9CxhrRNFeIR45cc7JkhaG0eJHVDHeXSaDA6YlT/a9s0V4A/tFDEiksXqNsFil/xxmqrc7eSeYET9t3Ag465mcOzO7FptrmjE2UFU+DfxXWe8Y8Xg40hMMhgDRE5v0pTBQbo9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EImV9uB4nhq5DGIv/yrV3xYNtH9TnlyJqp6BT2BpKHE=;
 b=V/1AyBkKXeqjC7zFLNbXMoYvJoHwWToLd91kX+/H5zxU7bWiSo3vqNJmuxurV7DLAeSlWnhx7A4xe6TXXoJhNBsIxTAx1Z+RgCSrlqu58EA5nJ3xDJ3U3fCTY5Fv5Zvv3MMxNTAt0AVYoBo6ek3EuTnb0yI2lPHnFo3+cByGD0MQLtM9d3rpLiZjefiBrsezVNb0w+OZauJA/C0Dd8OM2bf5bpSwfNUDPOVO8CBkMjpFyhDySVf3zd3fOcmEAKGnSpWFq6ZVOxmg+la9UhHd+85Tj6tn2DH8strWYFS5MLjbXDxsXs9PNKs1+YeKcyDbkREX58Lgadliyev4/SOGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EImV9uB4nhq5DGIv/yrV3xYNtH9TnlyJqp6BT2BpKHE=;
 b=p3940l4lhieRUW7jRI77chpTlawWYKsV3Uiaec0zj+RRZqRZb6c5cO0hs4Bmn4iDGaXUmdlrk6UKtdWVu893i7VbBOre+r1DP+Bq4P8VXnuF1V1iEkPbGxQAoqdz6zIYIrPVn7uY830ez4twMkIKJacBCl+GRajoT7YIoAl0s89a3kBpu6urYcapNYpQcqP9o5QDpcF9LF9R8XAwX/2IoMgku8vNVKvt5aUryCs12VRZnKyPYc8o0PvhKKWTddAE0udvIr75POL+lGf1MfsVO6XCLNCIPvyYgRwSVAXz/gaxKg1yMG5ktnuNXvV5X8qfFjw0rdYL17Kfj/fRPgSYTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:47:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:47:25 +0000
Date: Sun, 24 May 2026 15:47:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 03/11] bridge: use BR_PROMISC_BIT
Message-ID: <20260524124715.GC74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-4-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-4-edumazet@google.com>
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: f0aa0560-cdfa-446a-aa85-08deb9929b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	d089T++3KpcHNDQUTKJSrv3Xm9tnW5BBV+RDTDd0Ug6iEArlnvAxfciMpZ9NLIE1nuli6JkmIWKOElr7guUDCeHqqFWEAcnDjQOjBbxnrM2r8oE9fBesEeMgSE1U4IgMBMMOKvkGjL1n6wgXiB8dmXOYvvDpV9xMo7OlMI/Ut43bAOE/meXBNVGHeG3vMDUXul4O1bW8xqkYxuS+WE4CVNmiUUkMyobO3mhS0BL0VgS13Y7bzOzmHNMeRZF0qARTGmQzLLHP5kwhKcnaCLvCZb7edh/tP/VWBkY4InD1/sGRHj2ZB+fokSnZnjc4ungDoYZ1yYpd2RMehwUwFGlWDTatb+ynRQFlE/s3atmLQM7GfEDdVve7FkYgzlkWb1eacQ6nbrOBeAlkaVdvuuUYIPoR45C/kBMEXogTnHd2QygzVTKUS84BsimCCs2Ppzyd6oSd4xfzPRIQphv5S+pi78BY8Tc6GZCqmSUmIlMyfCNTpGMbg1DG8aYRQXmFwLbhIiNlwe5VVh0/TEm2YqH7LH8S4OMsZMwfUvnJwuHoTIIYAHGg1c+rSQeM7lwNRLsrudG78h11Q8Fh7l9q+GSDvzTpxPOGhGZ3nU6ImslnATWHXZETxC0tg4rqO3a1ntOmxV4rPP1YOw4TGyKBrJbj8c+Vcp24YytYoJaWBENTZDox1+81+SWrmMt3ElRb0oEG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lbA2gz2DNFD8VIEobU5qXe93kZH+SxNv6YgY8NjYbtuhDYm10LrXnIC6XPQW?=
 =?us-ascii?Q?Zpo8pzJ8Z8qQsY6rxC20qTDPq2OOxuQSutDwAutPjMrkirQOc/8nTYLC7jPm?=
 =?us-ascii?Q?9raRqhy7o8dNwhhD2r1JrCBaXCIcP2cq3JNs3f40LIB5jmSg0gMyWpKMvDjo?=
 =?us-ascii?Q?EgcIzAujf2cn/YR2GgkzJrif4Ct+7BICyG3FafipwDCouhVYjPl2ANwKugst?=
 =?us-ascii?Q?KnutslgXXoKWxFHzuzTCfjWe8Q7iezSx5jPLtdPlpXfJzQ2YWse/UlJOPE3v?=
 =?us-ascii?Q?g39t61JAdseDRG+exBCZrTUyi/3/yXs+CMlW+EZgg98/k8eeWcjGFTOJ+MD+?=
 =?us-ascii?Q?Z3EYwPfElG63m/g/yi+J4zDr9gsO7IvVm44FO0ZKQT2wjwYY8J7b2QdhsGXk?=
 =?us-ascii?Q?r5NzKjA2EA/VEEC6Pvoh0UROdiiXs2nFumSew7lNY+vsCC3+ydujuedepcbC?=
 =?us-ascii?Q?5PrJc4XSb+hlSMCjo3eKuCsC7v2Cj5979iRYC9sRmxxJQEarsZHdChMs7i3s?=
 =?us-ascii?Q?f8aEd+1NpoH3P1Mih7GrGGnjqnCKZi14WFHAWoyINzt7UDTOGtS2bynGW+j4?=
 =?us-ascii?Q?Te7cp1cj4eutJZbYhw3aty8Twj40g/6tkYKmLN+pZeaPn9vE90OJY6vD2g2D?=
 =?us-ascii?Q?C3xE5wfT7b2LmjPoebBLabcDfa0O2ZaVKyG5B5nqPzcyo+FiLOlKI6l8KknY?=
 =?us-ascii?Q?5OqxxexJooPuUo89OvJXPz7trZvDHGVMF5mCgGAH3hhfo8ulmfw+FuCFkFYi?=
 =?us-ascii?Q?TwIDyGxysl+31UCN4cBjr+DQVTuzE3ki9Ozy9cTXDfjV7B4qySQ9pQMUzMxR?=
 =?us-ascii?Q?IPRlarMmHR7KYfvXVfq3gcPLDTpoj/xlilHcw+Gjpf4ZVYpCc62JVTA5Fu+j?=
 =?us-ascii?Q?7gtM7LKZJkZ6ciT0VArtDAfoMV87LasgIx0KeL502ZneVp6yHfSCbbJ+bqEE?=
 =?us-ascii?Q?Lu6blUE2jAMbH2H2UOvzMpj9RlIdYOjNbJ6KluYvZgHJtG9YI+JU1Mhi+Vj+?=
 =?us-ascii?Q?JheRM9XugyuJrzh6c4/7YSN8W7jgr+Kom2WcZysVweZmq7G0NJCGxq+DuBNP?=
 =?us-ascii?Q?bf0u3RwrH4FQzyF3yfkJENorj1PXWoRDENaisxi8OECRDZ1DiYcwXuSvI/3C?=
 =?us-ascii?Q?A9rx8PN3XEGkQ9DYFa0NMF9PdWPcPRZNPfLBKHFgBbAusiCJYQKINB80cWtl?=
 =?us-ascii?Q?62kQj0GszeGStIGVzeUhUKdF6YIaG4+RNapcahCynClR1BuqgPJcljaMVfM6?=
 =?us-ascii?Q?twbBL2+iTktuJmB7E+WwuxsXFtvqogtf/wduQhXQP358Lq92JqJMwG7SLJFt?=
 =?us-ascii?Q?eF0bLKtns3LsVF9CzN/3264B73GPl7BGQ+30U88f23qFeRRoLMOLsvkvbkv0?=
 =?us-ascii?Q?xGPeQ8PS7hJnLtTBTo+FabYSKfbh37s1dT3chTNRd5ra4U0n+IHLaivgzYw6?=
 =?us-ascii?Q?IxTt1fU5Z78ttVK3MnXzp3o5Gf9oqjaFO6nz7L++COs5qgFPCeMYu5tf+ewJ?=
 =?us-ascii?Q?xy3Xy1+u3zX+G31CuGQm3d7dBYgXDxgmpHmnBT27tjMkelacpDZ4gDKPdRx5?=
 =?us-ascii?Q?Ii1Tb+yMkm4X2SWGNEkNzYjPQVc9h3f9b88er+3IsuyK3mekRk1lQMSfxWrt?=
 =?us-ascii?Q?Bjl0nmw/GQxHKP8p9sDMllutKgVzoRSezND5tdd84+Q3OSbb5Y0TcLBEO6ih?=
 =?us-ascii?Q?W5REKNJ3bHVPYzPBAHQBx3KA2P2V9FUDfGCtnrSTWE9J7MJg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0aa0560-cdfa-446a-aa85-08deb9929b41
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:47:25.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HYG9Hgu4ecODY3S9HNbIE+qipOOKMI0Lc/jZ9AiZ3SUCZEEoYXZJ+/CENYdT14FZNhD7ORtxFPuzMUhaKCPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
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
	TAGGED_FROM(0.00)[bounces-291173-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0BBE65C2679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:08PM +0000, Eric Dumazet wrote:
> Use BR_PROMISC_BIT and set_bit(), clear_bit() and test_bit() lockless
> functions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

