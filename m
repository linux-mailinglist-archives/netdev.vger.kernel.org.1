Return-Path: <netdev+bounces-258100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JG0CldFi2mfRwAAu9opvQ
	(envelope-from <netdev+bounces-258100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:48:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965F11C0DD
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1668D300E5D9
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F5366DB4;
	Tue, 10 Feb 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fpJ7ET+H"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6B30C371
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734920; cv=fail; b=gVeAIHMD2ThGJD1deDyJloUINzIv7vFPH+3jYllyZyBoEhboVLxZ56qqYNSUowCDN7W+8n2Dd+Cx3DdtWHIHsI/pRGhkv8IEzKVoTzzag3LZRM9YaBhgAJWDo0Cs264zopDqEfkb9yic/t2X+ONpFn/1azr2vXP8mu8LkJEkFQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734920; c=relaxed/simple;
	bh=heNUzPrBUPx1nUyR+/A42xsi+jxkwsSBoDcKeJDycnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnP6uSFEQcLfkfJAsKKVJpXenY3xUVRR35eWMY+Zj4rpiSK/zELEDcFSu2Q1r/MxxZMPy0GkHhhSyeaIMkNRUfoCVZ1Y24f4yjQlRdRoqmgaMmQw14280aOFrupI8D0/FZhzuL+3zMZQSzSreSKOSHOFc4BycbuuZm2fGDPX4kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fpJ7ET+H; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyaoieKan6sC3Gsa0S3WJwfpHZPr2zbt7caVhhWYh/Rw8DPqM2tpgS1uqWtKS77GJdYTDmgu9yN1pGpHuzEuvstc/mi7Lamr1ffk9LShG+4zMM3onwj3AKwkFGQzZKg4yK1hy0kSkZcesniSw0e6TdU86+IOstSHyiNh0IzLJGkqbERmUX5jP3CXPHaal7C4rVq9o7d7SxYtE/6hMwc8LVtk4SZbXPWDoBFa4VjGwIE5xZat4eOr0AxZ8PcINzPzuadQK62pc4GKRiRCaqZ4YD+RBEtECliR2exebOzAbc4JUwKm5EKjcENCm+pfjIgiSPiiOK6PuIVV6dO7DzRl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGzcicZZKjU4Vqk7f4+tdUa+My0JdS3rRusKGRVRdM8=;
 b=o9t6zc3/KypKEnBNjN9WM6HqfIU5DNoqOZ4oWhzDunx7dZEFDJRbHfDEiVym15YrEB9/vcMoMFjvKxtOAGRM9mB+acL4RgcNCCJwjPvadENiZ80YC7XPOu0i7Gte3Nb1acMZ+Y25JaUj+IogN2fSzFXWkHXEhzL3sqwZpqd6srHCeSe22DqwFihgDvfgtPfGC/Dbho7ptTwRdSJJjDF8Z9oXcrO3sK58zuNXbkDYaWDaiJe+0pvz2F1QcX+cGkokryYKgTv0h63PHCQBOZb52UtRgSFbjDkHqLvWf1hM3c+fXrt/D+GDB/RntDPO0yzhmoc95+8+J1EXWmGxT7n0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGzcicZZKjU4Vqk7f4+tdUa+My0JdS3rRusKGRVRdM8=;
 b=fpJ7ET+Hbf0tbA8HjGX2O+0zTJGD75B/+UaDS7TjJTawxQrVlLnaR+VAWsLytkMXSCaEBb1yj/f+JEeopRJc0/T+jfTwhYk9NdMwXKkH8kMNdMicu4/2ki1xwgR0qlAfaC2RIwPDmMZtzeTtptKcohi0truX42QKQUNgDW6moCeIOpIBdHei7AzLqTNtyDulY4sVmUSe5qiJjcvVjddjEEeU4AH3j2UBBiEqpjIDDAkjfc3R+TSNyswyrqDaTJo6S5r/SQkkkE+dApcrzQUP2OoDkZenNMAl23G5/eaXQIqlRjhlvf2Pp6drdE7em1rvzgliRKmXZN+FrncfVljcVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:48:34 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 14:48:34 +0000
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <nikolay@nvidia.com>,
	syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: bridge: mcast: always update mdb_n_entries for vlan contexts
Date: Tue, 10 Feb 2026 16:48:11 +0200
Message-ID: <20260210144812.1056554-2-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210144812.1056554-1-nikolay@nvidia.com>
References: <20260210144812.1056554-1-nikolay@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4000453f-f6cb-4ada-9314-08de68b37718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqv3mETtaqmK53hicL0tmkVYOfE5k9KxiSdon/s2etVruD17HrevTae2dR/l?=
 =?us-ascii?Q?GfRo7djgYRMJdtyqDiEVQwtY5r7Pf7wvfkzWvoP6C07oETg2ys6xi5HFgP7p?=
 =?us-ascii?Q?PD2TT3MLPpTL9Pl7/9fjlY0tiWL4aAg4yWCCuCnBlBC3PDhD+7XCg/pzHU4C?=
 =?us-ascii?Q?4XYY3R1iK4ciD0gXFw28poBS/pD67AQ6lv1lY7+fzY35xWe88boteYh8kTn6?=
 =?us-ascii?Q?/FEjcseqjEpGlvR9O+sycUKiAbV1REAip9wNXMZkLI5jMG+wHDlegSsS4Zxs?=
 =?us-ascii?Q?IRNVoOUnxQQwGGILlCMEEe3O7ROIQor+xP0uy3ZYaTYVvlBc8Y46jPKEEp7H?=
 =?us-ascii?Q?kVPq6hGjM3IkZHV9kUZI6Aqy705CRh5jr0Aa39egh1pSMr4SPpNn0gjijmOV?=
 =?us-ascii?Q?NK2eFY0HG+Zz4Hc1HTGqxuS0NrYu66+o/U5P25QpQ3DygZrDUkcX2qij1GeK?=
 =?us-ascii?Q?Jhq1//0SC5fU09kKu77EWX4gCeIVsHakkGFTqX5Q6hO9vmWR7WS2a8+eo+Ix?=
 =?us-ascii?Q?j4+KGQ+WUMviSfQu3oZBX2RR0rMnU2a6fqtGceio39mNVYiKetY7HkR394T9?=
 =?us-ascii?Q?q+5D9wIxdib4Oh/reruucByRoKiHHmqrVfI0Jpmk+o0WNCm38A0J0jri6MFO?=
 =?us-ascii?Q?brTJ9SRGEdPdvnIl8D6HK35JvFly4XYJPYHNQKZq1SZ95PuWLR0Lq+WAN323?=
 =?us-ascii?Q?knrKZtozHIYx9VNTRqgIjGBHgiqnvBJHxRtYZWNM+xGiLNOMeBLmm1B20kfr?=
 =?us-ascii?Q?NKJ9lFEXWk9MHYV4kbaI2g+n3kejpjiJ3EdQTsjHqZX5U/61oVk0Bx4FFdMD?=
 =?us-ascii?Q?QmNJqyBrj1ojS7e4BIPqvdXoFrDYwtgVEVzN/D2q0MdUQEj3j0rieks6OKej?=
 =?us-ascii?Q?sz75f5n9BdlNNvKwm2J0cmrx+t2Pd0AwRUpdbOjDv0gs4GNv88B534xjpO8M?=
 =?us-ascii?Q?ZANCSJIvbCtT/cYYaWftvRyBtR6HtlvUjrgJ2NwjfTK4iv+GbEhzrVRjdhd9?=
 =?us-ascii?Q?jr4RQCGGTVDdfauAIkOpvorhUepkOumABuDUZ/0egjrbeze1ruRxtNk1jNrH?=
 =?us-ascii?Q?wov/I7q+hka79SR4anNKsorAqwK5vaUkm0/1iU/nT6Jt1lZuY1sJY2WdQ0Cu?=
 =?us-ascii?Q?5jaVjH/p5TDW+Wa/wL68SUay1YY92QbM6EhBn3IQgX690lzfDPJ8mOfseys7?=
 =?us-ascii?Q?YWnh5+ckv12sGrAa2TWlK6g51hQFtuoiyycSbMVmFb5Xv/e6dbYTpX/NQ2yA?=
 =?us-ascii?Q?1zIPAMHGtCqbAHnVzya1mX4uNAcN2bqUOMQilF3RHT73abNWKmxyQ9X6c+7H?=
 =?us-ascii?Q?LnR5tSirlncU1tOd4IlSKZ00fl0AH076X34xsUhmXhj9NLcNpG5W4jJpsgi7?=
 =?us-ascii?Q?CyHx1CD1Txd4K1pVnJMvJ+CgrG86EOCcdOjR1YTJLtgL2I5l5wAG7/3Fmj51?=
 =?us-ascii?Q?93dXl0QlvQ/45huspz0ArT2EiIqo0jFBwnAU3+irh1yAiC7ZDbKcikagKiKA?=
 =?us-ascii?Q?FoCRjFpzjQL655sDFnIIFo9D1gqFmHH3qb9/zKd10Pf/ipcZNVcCiw/huCGu?=
 =?us-ascii?Q?yJP60M86x5h4vRKb6kI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PBt2rLvHd7RsRuoRScL5zzF+nG5USN7U2Cun0vYQJOyHjvRk1gFzJyydRFI?=
 =?us-ascii?Q?EdVxyvdMretEE/BVkyp2bx1/OrH0UkFUaJHNmPwQghFFz3fy4axS7rOdURCT?=
 =?us-ascii?Q?LNijBnt7zg+t/m+q2XFcTvV7Fti5NsCwYN+ePrjsvfXXZXd1DqLLB8n8CH4C?=
 =?us-ascii?Q?jCB7lGUSGSYbe0A4t7gqqWAuAa1xgMA+l3MHI5/aRkiqTT4ZmGqvV/ouSMK4?=
 =?us-ascii?Q?2YORj8MH6k0k9Ps4fZw+bhMVrCxlyew0gYXQwhBap6deb68ttd1VTs4+GMsy?=
 =?us-ascii?Q?ni2ldFjYF1niO12HhDxj4fYRtKEJgsmkMxEI2M2jETXgTOPBDp5PVNMM4TMR?=
 =?us-ascii?Q?h2nVR3IWY/w+RNDB/H17LvUd8aKnK8P+v9fDKnvV8B7fYpbUEuxS+y0wY9Zq?=
 =?us-ascii?Q?FmcGIVonyeRHxyTCCKTNqbxg1i1je4NaipCwepvwTIhmSOrf3RoYXDpYhV9R?=
 =?us-ascii?Q?BLluRc0EV0ZlQpEXNd2IuPKf4iaxfOvQhvX1MZXpOJ2zMNKl3O/acJpiKWPH?=
 =?us-ascii?Q?W5Y/kwTjFyireytpJ1m59yilzJcs8f/qM7RDZFWynUBn8sxpLUlegHjPtB/U?=
 =?us-ascii?Q?xlkgK4b4ioUKuq7QSFkX/gLuAcGZOgeVKEKnYUXIYqCg8qO1aVGphkcUV8GD?=
 =?us-ascii?Q?PF013RXqoKMPnDiTYSNjl00H9ov3OYk2tMA1QDgQf6/4bmMk7QxLb1LFyrHp?=
 =?us-ascii?Q?CDjdblUtLmcc4IHawFNnyQHE7p00FlCdY+TyGyfg5eBOEqWVu3nyYFbz2h7v?=
 =?us-ascii?Q?osiBAge7KqCJDaIHJuGEvy0iAap3xbBP6cv3VnVfqc3Ay7SFKtgcQXJRYrhv?=
 =?us-ascii?Q?duYm9fcF4HGdljM8/HBfMrjr/kqjGQNIBf6GO5+LOTnOye+qyVGxHzXezTov?=
 =?us-ascii?Q?dzSlJ2YouH9jFGmbnOyBDJ95Ay07Y+x17YnUpp8a7pI6C9kSl8SQermqXX3t?=
 =?us-ascii?Q?icpunzXXPtzXnvGoMEaNGiP5N7frAwBY1t5m8OKuZfcAYAdJ9AMwqMnW/gaY?=
 =?us-ascii?Q?9H1eqtQVVBAUtIqz5gqA5KUP68O/Lddka3n7XN/BWq97O5ODojcT6X8djslI?=
 =?us-ascii?Q?6qCDqWxiRTszA0yruQbvHemVxGpRliO+gbYnEQ0lHQckLWERfxJr6aTGXafk?=
 =?us-ascii?Q?oxxlFUMWr/Se8R/pSimNmrk54TTctsgxfvadZttkKSrEJkyk822HLWjFxI+P?=
 =?us-ascii?Q?M/C6q3R6uBqchzpQg9eQCgu/wI3Dc9cIZ12dJsfqLRTzEJGf/FzGiwcSzzzj?=
 =?us-ascii?Q?HF+22T3hZfiL2QX14Yto/IIypJj+y9aFJdGtcJrQkLXis2+7RHW2zrLPUHWE?=
 =?us-ascii?Q?nEV+IaFyGmqTFHnYM1jl6rXGT8hxUd3ytcvaWLyg8SfMtq9BSvogZxbp2VT5?=
 =?us-ascii?Q?te9lmHB1nQcdRP758tz+xXU2ytYIyPE3DqpGcyAieyd7jHAKrMdywtrHCbQ1?=
 =?us-ascii?Q?Rvpp/xd2FTGY0GLmDUqWL+0qrG1d5yShGTIK6XVOXQZolJHM8Kik/ncoOfKX?=
 =?us-ascii?Q?jzI/VKGZpc1ekT31D9w/vZtLXVncyzLm/CWLu8WG0OD18tShnqSwgvvK0Bdy?=
 =?us-ascii?Q?SCuf81g7JAIvlyr5kQSscmcBu+VvOvX+/EotHxy66XXosSJAiMLN9+p5Zcva?=
 =?us-ascii?Q?yiZE/C5obQJfuvAprHA7u3cf8AWrACTor3SnAQatYaxQYVtZcI7QsDjGev9d?=
 =?us-ascii?Q?jbKYZ8qQSDJWcpudYr8UnExbOBHZGlH4U6rNwRO6+/hGpf/d+aVKc3j2jdQM?=
 =?us-ascii?Q?ezfiwOxjGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4000453f-f6cb-4ada-9314-08de68b37718
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:48:34.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ/V6g1PxkDsZFngX1DHNEZxeYiN1HPHE42u6FNQlFGgFI4x5eY3OB82+ahLg4Prar0BLsLcSd7crYFPmHajyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,d5d1b7343531d17bd3c5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 3965F11C0DD
X-Rspamd-Action: no action

syzbot triggered a warning[1] about the number of mdb entries in a context.
It turned out that there are multiple ways to trigger that warning today
(some got added during the years), the root cause of the problem is that
the increase is done conditionally, and over the years these different
conditions increased so there were new ways to trigger the warning, that is
to do a decrease which wasn't paired with a previous increase.

For example one way to trigger it is with flush:
 $ ip l add br0 up type bridge vlan_filtering 1 mcast_snooping 1
 $ ip l add dumdum up master br0 type dummy
 $ bridge mdb add dev br0 port dumdum grp 239.0.0.1 permanent vid 1
 $ ip link set dev br0 down
 $ ip link set dev br0 type bridge mcast_vlan_snooping 1
   ^^^^ this will enable snooping, but will not update mdb_n_entries
        because in __br_multicast_enable_port_ctx() we check !netif_running
 $ bridge mdb flush dev br0
   ^^^ this will trigger the warning because it will delete the pg which
       we added above, which will try to decrease mdb_n_entries

Fix the problem by removing the conditional increase and always keep the
count up-to-date while the vlan exists. In order to do that we have to
first initialize it on port-vlan context creation, and then always increase
or decrease the value regardless of mcast options. To keep the current
behaviour we have to enforce the mdb limit only if the context is port's or
if the port-vlan's mcast snooping is enabled.

[1]
 ------------[ cut here ]------------
 n == 0
 WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline], CPU#0: syz.4.4607/22043
 WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline], CPU#0: syz.4.4607/22043
 WARNING: net/bridge/br_multicast.c:718 at br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825, CPU#0: syz.4.4607/22043
 Modules linked in:
 CPU: 0 UID: 0 PID: 22043 Comm: syz.4.4607 Not tainted syzkaller #0 PREEMPT(full)
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
 RIP: 0010:br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline]
 RIP: 0010:br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline]
 RIP: 0010:br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825
 Code: 41 5f 5d e9 04 7a 48 f7 e8 3f 73 5c f7 90 0f 0b 90 e9 cf fd ff ff e8 31 73 5c f7 90 0f 0b 90 e9 16 fd ff ff e8 23 73 5c f7 90 <0f> 0b 90 e9 60 fd ff ff e8 15 73 5c f7 eb 05 e8 0e 73 5c f7 48 8b
 RSP: 0018:ffffc9000c207220 EFLAGS: 00010293
 RAX: ffffffff8a68042d RBX: ffff88807c6f1800 RCX: ffff888066e90000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff888066e90000 R09: 000000000000000c
 R10: 000000000000000c R11: 0000000000000000 R12: ffff8880303ef800
 R13: dffffc0000000000 R14: ffff888050eb11c4 R15: 1ffff1100a1d6238
 FS:  00007fa45921b6c0(0000) GS:ffff8881256f5000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa4591f9ff8 CR3: 0000000081df2000 CR4: 00000000003526f0
 Call Trace:
  <TASK>
  br_mdb_flush_pgs net/bridge/br_mdb.c:1525 [inline]
  br_mdb_flush net/bridge/br_mdb.c:1544 [inline]
  br_mdb_del_bulk+0x5e2/0xb20 net/bridge/br_mdb.c:1561
  rtnl_mdb_del+0x48a/0x640 net/core/rtnetlink.c:-1
  rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:6967
  netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
  netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg net/socket.c:742 [inline]
  ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
  __sys_sendmsg net/socket.c:2678 [inline]
  __do_sys_sendmsg net/socket.c:2683 [inline]
  __se_sys_sendmsg net/socket.c:2681 [inline]
  __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7fa45839aeb9
 Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
 RSP: 002b:00007fa45921b028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fa458615fa0 RCX: 00007fa45839aeb9
 RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000000000000004
 RBP: 00007fa458408c1f R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007fa458616038 R14: 00007fa458615fa0 R15: 00007fff0b59fae8
 </TASK>

Fixes: b57e8d870d52 ("net: bridge: Maintain number of MDB entries in net_bridge_mcast_port")
Reported-by: syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/aYrWbRp83MQR1ife@debil/T/#t
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 45 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d55a4ab87837..e9a7e6530401 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -244,14 +244,11 @@ br_multicast_port_vid_to_port_ctx(struct net_bridge_port *port, u16 vid)
 
 	lockdep_assert_held_once(&port->br->multicast_lock);
 
-	if (!br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
-		return NULL;
-
 	/* Take RCU to access the vlan. */
 	rcu_read_lock();
 
 	vlan = br_vlan_find(nbp_vlan_group_rcu(port), vid);
-	if (vlan && !br_multicast_port_ctx_vlan_disabled(&vlan->port_mcast_ctx))
+	if (vlan)
 		pmctx = &vlan->port_mcast_ctx;
 
 	rcu_read_unlock();
@@ -701,7 +698,10 @@ br_multicast_port_ngroups_inc_one(struct net_bridge_mcast_port *pmctx,
 	u32 max = READ_ONCE(pmctx->mdb_max_entries);
 	u32 n = READ_ONCE(pmctx->mdb_n_entries);
 
-	if (max && n >= max) {
+	/* enforce the max limit when it's a port pmctx or a port-vlan pmctx
+	 * with snooping enabled
+	 */
+	if (!br_multicast_port_ctx_vlan_disabled(pmctx) && max && n >= max) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "%s is already in %u groups, and mcast_max_groups=%u",
 				       what, n, max);
 		return -E2BIG;
@@ -736,9 +736,7 @@ static int br_multicast_port_ngroups_inc(struct net_bridge_port *port,
 		return err;
 	}
 
-	/* Only count on the VLAN context if VID is given, and if snooping on
-	 * that VLAN is enabled.
-	 */
+	/* Only count on the VLAN context if VID is given */
 	if (!group->vid)
 		return 0;
 
@@ -2011,6 +2009,18 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 	timer_setup(&pmctx->ip6_own_query.timer,
 		    br_ip6_multicast_port_query_expired, 0);
 #endif
+	/* initialize mdb_n_entries if a new port vlan is being created */
+	if (vlan) {
+		struct net_bridge_port_group *pg;
+		u32 n = 0;
+
+		spin_lock_bh(&port->br->multicast_lock);
+		hlist_for_each_entry(pg, &port->mglist, mglist)
+			if (pg->key.addr.vid == vlan->vid)
+				n++;
+		WRITE_ONCE(pmctx->mdb_n_entries, n);
+		spin_unlock_bh(&port->br->multicast_lock);
+	}
 }
 
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
@@ -2094,25 +2104,6 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 		br_ip4_multicast_add_router(brmctx, pmctx);
 		br_ip6_multicast_add_router(brmctx, pmctx);
 	}
-
-	if (br_multicast_port_ctx_is_vlan(pmctx)) {
-		struct net_bridge_port_group *pg;
-		u32 n = 0;
-
-		/* The mcast_n_groups counter might be wrong. First,
-		 * BR_VLFLAG_MCAST_ENABLED is toggled before temporary entries
-		 * are flushed, thus mcast_n_groups after the toggle does not
-		 * reflect the true values. And second, permanent entries added
-		 * while BR_VLFLAG_MCAST_ENABLED was disabled, are not reflected
-		 * either. Thus we have to refresh the counter.
-		 */
-
-		hlist_for_each_entry(pg, &pmctx->port->mglist, mglist) {
-			if (pg->key.addr.vid == pmctx->vlan->vid)
-				n++;
-		}
-		WRITE_ONCE(pmctx->mdb_n_entries, n);
-	}
 }
 
 static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
-- 
2.47.3


