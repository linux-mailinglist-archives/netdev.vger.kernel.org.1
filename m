Return-Path: <netdev+bounces-300968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wo6EK+7eOGrCjQcAu9opvQ
	(envelope-from <netdev+bounces-300968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:06:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA36AD221
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:06:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="t9n0/w+F";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300968-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300968-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F8BD30293C3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F23603C3;
	Mon, 22 Jun 2026 07:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD32352029
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:06:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111963; cv=fail; b=F4aC206Ic0D+6b558DddB31LAocv4JPq3dvIlNBOy9PxgyVbd8Z5E0KmYscKGqta9ADk+3jRi4Ur5aKHTnezcfAlr8hb7jhMvmK5gcC4Gw1fX28l2mWBDLWf1vN0SDoxRJ4y2rcxyrT9XO3WcQ+7KQ58DxOeIbg17seGKnDDn90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111963; c=relaxed/simple;
	bh=2v2GkYcLSkT9zpm6RxES7Xcjob8kZIJQOPR2Gp41P+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IecUlGnsXDICa6W4wVCB3dnXbNycmUemNaM8qdcqyvC57+MkaNu8rvvl30+w//NShmup8tb3ZjbHWRWHsXqHina0IZiR9tNjC+yVrBdDGjB6cEnr1e6vK+1/MotmRDug0A+Sir7meDFifvSnJ3qgl1ciCiX/bVFoKVLHoTCTqCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9n0/w+F; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtOJ4h0qDcFW4UDH4K6hqeTYhfuHtrwiXHuMzM7SoTVCxh4j+UCBMIivx4gG/T/vUalEto/v10oEXqNTlRv+/5tVg3G5gha5uQK0RnsVk6/PIGvI+ziYDXvt4S239uMrLCMMcnDWPCww3Lw5ru/M0nGGD8eap15xv7ErKAOkWZeiaXo11s++fayjxE8qvQrKPhLseJTfXViYVgEqOMblUMB5LFltzac1SaMrjgSVjU6ZTAjIp6BiXNtKeZ2DuIPtCAGSbzMjA17G6vjyHGDEnWnp+nktacq+s049tGi8QyhSFzMnXPKilaMRGO6+VWmY6omDmzMQ2OgzMqTwozTcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxVW08nln7ixDBOHZomlkj9k3X7O7a6Sr8yGxsVZW8A=;
 b=tJ7xJdz8Jc6AjPQBfs4NUorON757tscCBUlN4i1rrSIIjXOvwd3fg0PbQmkf//MZ8ysk4rpRg5Ms3qAiIRx4M78l7rZvyMFRxwlRTa5UgGLLUajjKnb6xJlWWln8F9h3RHBUVzgkXXmLKXHy85sn//4bH4ba/vjf/wdvbQLhplwkPTb2R6XHM2E9PGks3q+dcq3NEPjmvM2fojT/gbImS0nnZHECxZCjI/2hyb+02NJZoUz2KcdmJhBzcL4G22+ppOTSKq63Iuc2A4/pk1BD6HAIyxNGTEMdwQS+ntbGq3sSEzoDKPTBZs0p3UUFZ3jHRjDFkRZpX/qRa6BtktsDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxVW08nln7ixDBOHZomlkj9k3X7O7a6Sr8yGxsVZW8A=;
 b=t9n0/w+FjWiM7wvvCxkKckcvEamEJ88V2/XLFoAAl6uB7CIiCoNWREhg0kxwLDLz4MascM6m0217vMVCfTAOI5bjhloUca78o4kBFFA2Tu1i4Nz9rCJPnrHYVJPcIghnphMvJVM1EeNL1PSgCDtsC+milwfuVvMrn2wcf76nMFzFR0+pRC8+KJg6zL/aDf0K8vjOhXqA4Zy7lstgZsgI4kL2qddTx1x4TXDfYhlOVRUyKKLpBVmT+CZBZ50MbqlpS5CVrYerZiaubzn7pOV3KnfucWt6rTl7Lw8ckPIPJiVmzz1cBti/WecFSQ87374clnXyI0npAkWDl6RFkaGqYA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 07:05:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:05:59 +0000
Date: Mon, 22 Jun 2026 10:05:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] ipv4: fib: Don't ignore error route in local/main
 tables.
Message-ID: <20260622070549.GA89414@shredder>
References: <20260619212753.3367244-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619212753.3367244-1-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b83c8fa-6322-4177-1583-08ded02cb66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hUPwKU4PN5WzqzPMKzPa72GDu1kDMFRdpF5KeWItvEqt/qW5Kdx+KATldlw2qNlilkhZCkTurqDSp/bzUJdY+v0dORvLzIWCGSYy2E/arGtRhRPeiHolnTL5Qvl3Em3tSQdR36fZt8XgPYTnI3wqFWjsOyd49FhtGn78wYaa7j7Mp1pzloQ6ztLoLJSpiMpoM7rMyX0DKg8MmlB7UWTqcX689sOvGclnX7iuaYl6rc1RL1LXE+CuGHowfc+9yuAbKBs/kcTtG163ML8MLDMkQv1SZsn0p36EDNdJIuet4F5FO15WM9Nah9KyXxFyM0UZNW8e3HksgTIPGKR1vNO8oJujA2UcPDcrlmkRb82vcuMqOsS0mDACoIkYMuDUmBZUBKccst/To11a/ZrCTi27P54v8MbqMTciMEDdbrZxWj7oNXW7S3urhX48q6YNi1XdlCnfBm4u5Hjm26MUkJmjny32tCghLc6JP9t3kd15a2MSj5atApMkhbhXY8BvAfTQPJLGmwBECilBbP+NEuXOaOaue4h9OUit4K/gwUobb/dqXZ8pug6Yc+LkMxbrYpuEywkJuo0sAIzjvwm2VRs4N7RQ+idSsmKbEjDrUTBAJZOoFaioSYjM7/CSAOW8kp3/bpUzb881QObFrcnunFERua0fTkoPv9BKWL8+2/NXqos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ynxotcVq8eN6MX908Cbj5EfWFT/3bGNCg81CKyLpIB7zr/CPbLlAHmFJblZQ?=
 =?us-ascii?Q?MSxN0bPnMwMvCerMKOXQpGVtqryhSLv15ZgqrHU2f+to40hrDFmShxDVvZ75?=
 =?us-ascii?Q?oYTzF8n7+kCJW/gNIYjVT5bH8sVOS420hfatHQuR7nfdmJXD5FOj4lbIHzeF?=
 =?us-ascii?Q?WsrRvMA0Vc0+n8KvmUl3YqWaZANA9dwTt0fmGq0bkyET/wz7ic+vL+3qX6Xw?=
 =?us-ascii?Q?9NWQ//0iMxDUtyEpLmnu2qfbGBah7c7aT9ufkhvhrq+v4x0K9nVgN61og2Bh?=
 =?us-ascii?Q?HDSWK899DV55IGHgHrZGTugCz0D1fl9vKxNPiwvuHu9alvWaZbh0VJLW5kHk?=
 =?us-ascii?Q?4G11D+33xsY0AchSuPLapU07BviNZsyqg3ragQJa5AK60rTFihdSgxakHXv9?=
 =?us-ascii?Q?86sU5ius6Zg4qdbH8Wo1gNs3lJLfuuqWyT41qRNtDQ8wUp73omF0G8DV+50Y?=
 =?us-ascii?Q?DxOlkn2CJf1cb9z9W5jcEqkZx5pQw9/IRzgHklkqthRbCnDbV8c31D0b7OEw?=
 =?us-ascii?Q?7l1wOeghpIzvqOBMnDKaMLgOsfQx6oNs6tLTM/0gkeR6jDdTCkMjwhyEUe9A?=
 =?us-ascii?Q?jNTaOMQw2aG+lZ9KaauXDOADOqkvwXRLDfN+9iphsJL+B+SZt4R1TdjMUmz1?=
 =?us-ascii?Q?817s0AbWydf+B1rC43J6i3NHXyJ4Icug6Ie176fZelT6IYm/W+hmefDCI9eG?=
 =?us-ascii?Q?S03U+GUebAbSV8zdpsG+f+EF2PIyyu/TYhuUGRJwdQHRacWxkk6Vc6n/b384?=
 =?us-ascii?Q?79TbbjWFAIQmbw5rX8xc1dMXqyVykzEsLCIpVmWU5VD8d4LjmZ5ViJcW4Uj3?=
 =?us-ascii?Q?fjMAEUXsK9eyUdWYKu6xtGtui+v08YzaLKlrmrd+fQ8gAW+BVdeioCLd1iQe?=
 =?us-ascii?Q?F4GhHGGfYR9S+6QsPxWXhtKtCUH+USXHOEzGFQMnbXhZifNPatQBKkGaUDal?=
 =?us-ascii?Q?xM2KisQXy0JiYMrWuWpxppRHH8i7nj971b2LEUQEAwp+49MOCIWlMkei+lkY?=
 =?us-ascii?Q?TdqoBGfprq7J7GH9EtQ9sIn4hS9fCxm7RpMzKqrTjGScU0NC+qmjK7VAvYlG?=
 =?us-ascii?Q?o2GWje4l53KUZAlEiYyL6K9LoziqJngBOFIwxzlja1yNCpr8zuEZ9JupIjgn?=
 =?us-ascii?Q?j3PHusLv44ujivEAt/setr1PjS7suPuOAYFbaccgrTdGEHpNPI4TK/XfQg1h?=
 =?us-ascii?Q?5MdzzvXEdI264M0pPRnITTYcw4zZVcMZo0/3x4qFgDe7r16cTBB3Dq2uAqEr?=
 =?us-ascii?Q?18lAjpjz+ktHXq+HdWVrf/FwQ/5jNrk5jHXU5KMZHh99bx7t33v/nMgV8Utv?=
 =?us-ascii?Q?jazqj+RMqn/pK6jE6gfGQVtrvs+Bpvzf3+PqZ8+MhJjKs1gNlHsDP/8z5K/B?=
 =?us-ascii?Q?6jUxo6HkWEUPFTFW3mBKUMRykfNhCA8oq/2n8Z/PrQHam5FbSaD2uPfnNKSv?=
 =?us-ascii?Q?Gxb8hM37D9mNxSEFiFQwD18NYKSKiejKQL14WuoH03jtseCCdR4lFxDZrq2i?=
 =?us-ascii?Q?0307CIc+0gsm4BQmHpxT44EVoIE9+nzT9ryjKHgQ9q7AWlRa0kEshezWdZj7?=
 =?us-ascii?Q?+Zn1O5nMwxliUl4rvJuXDeN3oKv2sZMlWj2qDjWcDQ6UaPCouIKt71/FhSHq?=
 =?us-ascii?Q?lpEtrRWaC9V7Ble7wiytfCYKySL0r91aTI+Chp2v2EH7Xa+MDfZLKfFN2ySB?=
 =?us-ascii?Q?WsTq0cFyrufFjKu4imqSwUNvixEG8Jsbvcx5RrCjs+adCaeO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83c8fa-6322-4177-1583-08ded02cb66b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:05:59.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhTNHWJ91GH9UNNF/Loab/6OJIgg26AKWeOCgYGpJnf59SF4kaU2F+EWG8ijv76hxknHTrEJ9uCuZsLiEfa7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
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
	TAGGED_FROM(0.00)[bounces-300968-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FEA36AD221

On Fri, Jun 19, 2026 at 09:27:20PM +0000, Kuniyuki Iwashima wrote:
> When CONFIG_IP_MULTIPLE_TABLES is enabled but no rule is added,
> fib_lookup() performs route lookup directly on two tables.
> 
> Since the first lookup does not properly bail out, the result
> of an error route in the merged local/main table could be
> overwritten by another route in the default table:
> 
>   # unshare -n
>   # ip link set lo up
>   # ip route add 192.168.0.0/24 dev lo table 253
>   # ip route add unreachable 192.168.0.0/24
>   # ip route get 192.168.0.1
>   192.168.0.1 dev lo table default uid 0
>       cache <local>
> 
> Once a random rule is added, the error route is respected:
> 
>   # ip rule add table 0
>   # ip rule del table 0
>   # ip route get 192.168.0.1
>   RTNETLINK answers: No route to host
> 
> Let's fix the inconsistent behaviour.
> 
> Fixes: f4530fa574df ("ipv4: Avoid overhead when no custom FIB rules are installed.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

