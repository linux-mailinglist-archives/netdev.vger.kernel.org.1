Return-Path: <netdev+bounces-277992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ7nH7mt3GkBVQkAu9opvQ
	(envelope-from <netdev+bounces-277992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6C3E94F5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10C9130080AD
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796963ACF0F;
	Mon, 13 Apr 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjiRrljV"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D343ACA65;
	Mon, 13 Apr 2026 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070029; cv=fail; b=gRlYIEIAKnr5yahASVrBgxancLyXerjCsLCrDTf11J4d0HanL99gSTbqHHMnPxaP8yJHMZcmXsqSgwhqKJzwbRWEozCmwzI4/sT9P2AOGiFglfbHdIR7wijxFMAEjRsOhN3t2hwdrLAdugZIVa2Xa0IfufWiH7QWFKxewwpcqIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070029; c=relaxed/simple;
	bh=morY2/Q1XEtiPU6WnZNCGdRzwby/sj08lS/2o37Y8xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gexJEbU8qwniOBC1pooa+FDr+yHH3Xfh3qK1ZOXa5yBFfZbpPiXuGuyGwrmEsdZZroJ34FdUFGG/P+PyZoIgYEqadpwse+gjLmYHBbpgWwrGFrNpU37WuS5PS6isN8w+p/Z7w/YkaLmieo+Z/Z/4TvMXnaf1j1LGDxw/CmoL7Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjiRrljV; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWBs73P8zhyR1TL0jwybUuYM/Vz8KxcaALEqECawMdirx83ahfLWnMBHoOTjUgQ52dz15xHMtAYHtbIqG2dwpo3vjeXGC4Ko7n5hPFMpCuTtrg11jIJl0QCkyVn41D/mfMo3BcKvWmNVcZlxb00uNw+jdP/hM55ZO6iZuJuoj2yuAzgTqoQZfUh6OlVSfaHAuHLmkN+g2hqoRvXiZM6aBjR71MkpFGPXUCrDBJpqP+X/m3gnE5QJ2HzRFSQFWioZB/8RYzRZyworWvf3ej9xAIOVFKynKtppGSHVKfG0szJlkiKQIBCTFV6J4sWvJze5RoaOluCzLaUsVxTCkNCRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSZfR54puKzreinxOgT6Vc4451xTwXWvvGsrKqXEsxQ=;
 b=dZHNLf3U/OVBk06sXf1TJheseOAMC+/xi5CaI/e0Wch/gI5kXAU4lhYiQJzrgzWJBy2blfB5ftzfb8laT04B90nVq3DY5iYAFa/VILu7G8X2ZatI30KO5OAm25FxStB5nM5px4/I8CnLH/xCRhhaZB9uUzA7HApfOjNJN0YmXV6HV77rDUZ/8eweG0Cp6p150E795D5F30LHvXo1MaitV9t0Vk7jZUly9USS2KqMdjEPbtv3AFeFprmy5+Ib/JuV7RzHxw/rPw92jRri1m2hvrNiMd5i2p78xBB31jvbak/XDg6W1MMF0U9ZZznWoRbl1iCGQ49I2Ei5vOvKr89fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSZfR54puKzreinxOgT6Vc4451xTwXWvvGsrKqXEsxQ=;
 b=WjiRrljVzvCwpvtAArDCp4nw9sdh++8w5NqMl6zwn/5WBdq+abVM9SzZMjWceNzVTzQAcKc+hHsgunxory3mQVqA8q8MqcZo00D2D6JRbheLtw7ndCZbKwZIIH5+OWRGZjTbghnSuR16lM9Bm5S1LbaBt0qpJW8F4dhM6ik3CKUynqQEvojGdysKwibDdoA4+R9r2ZKAiBcQOZVoWT1O+2Zbc+7Gj8PNlWWMyEtiogpiVIBQJ+TDAPamFYxWcn6zrNSFiPopOemuFrUN170ZwaH7tzSVcTQDppgZ4ozrB5LP5DR3ejSitDqvby5VFpG+ZnBJi3BSFdhtjQUKVErSDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:47:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:47:04 +0000
Date: Mon, 13 Apr 2026 11:46:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/5] ipv6: mld: rename mldv2_mrc() and add
 mldv2_qqi()
Message-ID: <20260413084653.GB209364@shredder>
References: <20260412111047.1326-1-royujjal@gmail.com>
 <20260412111047.1326-3-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412111047.1326-3-royujjal@gmail.com>
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5932a8ca-c8f0-4aab-6637-08de99393c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y0hUDCBrJlqDXPNH+QggSEvIL4Jbf9fDmhQvFlMaYyvYj1d/xh9d/YMo9eREAU8QwqoIrduG3RVmhkuLUsVrPBu1GBDUTZ/lbFsi0tXI99XM5aCYFwUtmflyKkeXB958G2ySUF1JWT3AKT+XRcRqEapZ4mgbe2wzJnjHPJMKFhXWSvqC8e+t58zGiqsi6Wd1xFK8zbbz0BJFIypuvAjwvVe41iSIQNF4DCSrYaQTpH8wFSBVkdCpoWfYkschJiuE0a3CJGZ7zprTne1aeoSTJeGa8zeEXMFflPWljpI6LokQHVI6R5nqk6RVuSuhZEUo64oUUToXpshtCoe61gLU3bSRBnA2x1TVMEP3uzvvV+BZT6dLqvtQIC+mFAD3AHCPZpxzlygDo47h6YFPRkTUNeyKZazNzX8U6V69P8fPcv3G2/29BmxNJnWnwOTuyipeUvcoKbMNzgJOaICVgCpgeP3SlzBCxm/mnpU9Gq60DsGrvUHUm4agto1u2ke6H0T2NmnhWFcTMSBHPWuhHvh+VgIb6I9Be98SkdBrIdueFOk4azIF38Ucja63PTPmvb9ItspfTR9QYpfJtYx4m7ELLZZ3hYGDjaZpFHRnNFjzxw+uFHgHtOApXrecQJRAp7YK7/ysWvkN/POqBAZyOX55vxkVP5AsWRmzSZdLBSbcQo012jimHIfJ0Dnswd98Hvv3CBoXpY28SyKqWPzhOlxfgIqqmzgIZw12PtvxlWLn2wk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMEqixzLLInztQz8dqt1rbdm2AIu68jGO+tJwgz5suL1mY9tg2WT2hpIomu/?=
 =?us-ascii?Q?NKJLg1rkdIKSra5CfvcHjc6Zlc5vkrNv6vuWNcCF7Wa4kKWjwkySXhbxLg9G?=
 =?us-ascii?Q?MW/btIBzZq4Nt5MPwj2RRDRisgsm29RCq9La2l4LbIeVWJwWOy5gggWdg8/t?=
 =?us-ascii?Q?WOJW19pP+u+fX0mSKD7njRON0J2y7JyWJGHvwfUgS8Uh3/vYyu4z7a2JHdyU?=
 =?us-ascii?Q?UkDAhwoxqro+pr5W4W3Yxz41xIdtPfaMTetoEoWvYtoWmfnDX/qkYpIC5Rbs?=
 =?us-ascii?Q?uMgUXUY3tg59syevPR5n/00aPVcHTU2NWHiGFfR4kzKsoVNEAZFugGOsv5Ku?=
 =?us-ascii?Q?SdhaYM3QMjaAAVBk67hSe214nMwAYvPc0ozIJcmLowJ0vYzkhqZufBL1arDi?=
 =?us-ascii?Q?iFZxtZmkyb35NEO6TjyOtU5BgbUh1ptBx9jCLkGPtxam3XVcq7H+RzKrdroC?=
 =?us-ascii?Q?/kPQkEvmz0dBS61Pf4Udgyz6xNmtuIekDfBZ+5L0HcLMkAmoopjtIrTot0Z6?=
 =?us-ascii?Q?e9tnNzYr5a2A2qST57tp1MMjQOS6WL0OwD2cu++x7GqesPlJ9ZCfu3vC0r4Q?=
 =?us-ascii?Q?yRwYTNH0ZTBckE7J9BRwB3bprQKGyMQtA83hGgWtkd8gCluAAJlsNhQKRLiv?=
 =?us-ascii?Q?RLucFSvakcVIyGprpsz/7ddhfASjc/6KgM5Tij47B7MODmv+cef4hva+K1u/?=
 =?us-ascii?Q?+DRwM/a4WuZmwyASz1+uP450EWVxHGvNG6Lf18mAZhhaLKMQkBIGiA/N3i3X?=
 =?us-ascii?Q?xGJ9DC8G1Ct+iYDo1Pd0xJlqGJBVkvUoZO7oqIdJuass7LJ8OMDaaJv6DT0D?=
 =?us-ascii?Q?XnSbR5i3NlXTyesWA+NeKICePfq3neCZtSaD9uW5oQENBL9XQoLL9D2LmgmH?=
 =?us-ascii?Q?0SFEwsVmo+S4aSfN5z1MHChbnrvOFWIhUqT3ZZMsKlVhKUGCEFk5TTZOMPTy?=
 =?us-ascii?Q?z1aBznn/a69IUQLr0qgt4+pwHf6FrvqtLB+bIRCo9LzaC1mS2kr+H46ze/wU?=
 =?us-ascii?Q?6QC59WM0FwGocS9rCOBKOz5yQb+wfamdxeHEX9uOGXuuxe9C56/x//pKoCC5?=
 =?us-ascii?Q?ZBKlUNGjb1UY+MxhuG/8r1Nuct4QztU9ogUXZ1UoF5gpaDQTgmBYLoMXIbNH?=
 =?us-ascii?Q?b7DUuqA6EazO0u0EkBHgLxU0RgV0kKWlua2TjttkpCj73PJsKfTCiNUxsR/R?=
 =?us-ascii?Q?qVyYjJOT+bDnskyI4MtUQgBa3/0y4HiUa7IdrQI49K1P7eV6b7E4YBbcrwi3?=
 =?us-ascii?Q?dOseu6ge0MONJWc/5YqIYPAuKK9vPpHAtSk4dx6E+oma3YWHQyElr6L3Es6s?=
 =?us-ascii?Q?D8bGVWkDY3lHO1+PIzCby77tk1cB6Eygw+Ev6ppNWa6XBDvN9gDobWt6/tMx?=
 =?us-ascii?Q?gpdlDU2fEv1PBb5Lmf8RjmLtHVcDQSdEW3A0/Mja3Gf46wK2Sb2xSaGNsUOt?=
 =?us-ascii?Q?tvTHv94E2ox8Qkc48cK9RNra22Pxp5uydZosx6KMcH8ScXKCcgdqEErQflkg?=
 =?us-ascii?Q?eAgjrw2aIy/WvwJEkx/GpjrLX1pdp/utuvIkwf2TdTINL9JLL7jvaoq9LUGF?=
 =?us-ascii?Q?AsOLh7QVSccqr/fe2Jf5VdSYboKiiWlkcynmzi47ol4rkoDc8arHr689/8xm?=
 =?us-ascii?Q?WsuAqaXKCy5NCfmMfXxuLG54w2jL+S6wmehKUjSEL+hfMZ40539qdjt4Kbs9?=
 =?us-ascii?Q?4RJMbm1AFkpCe3U+dOc9urU0xjpTeMyiG9814wV2VLCyypGE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5932a8ca-c8f0-4aab-6637-08de99393c9f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:47:04.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUXl0tJhFHJGC3bruvsQim8LQ0KdQT3sdTDEa0iA9Rz8nTmM0eaHzAWIZ6soiCWRjGgXUXquCuqk+5U3ByzJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277992-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 85A6C3E94F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 11:10:44AM +0000, Ujjal Roy wrote:
> Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
> the Maximum Response Delay from the Maximum Response Code.
> 
> Introduce a new API mldv2_qqi() to define the existing
> calculation logic of QQI from QQIC. This also organizes
> the existing mld_update_qi() API.
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

