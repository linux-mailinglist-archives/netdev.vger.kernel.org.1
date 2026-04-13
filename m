Return-Path: <netdev+bounces-277991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIqGDbmt3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09953E94F6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D3D5301C95E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F13ACF07;
	Mon, 13 Apr 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8mfi8ds"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695F3AE184;
	Mon, 13 Apr 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070007; cv=fail; b=Tbj+WFqy+gyv/q+t0LwTfrF59ft8/CJYO2XGgacQwIH+uUZEQZAZLauqIqw6VECpjVoBtMX2N2cg/bZK4Irff9i/Iwx93zCD1TZAjbXPNTKLQ6uvfZlM+8dSK9hFwI95ZiivjDamVwthn0KhrPfKIItfLSxnHEr+UW6W0EDYLRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070007; c=relaxed/simple;
	bh=AlQr1YhX4MvZekeFT/ME/8X3IQj2t8JXFvUg1HKPjFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JXcau4o3jHZOjUKabRQzxHXUEgnxjjMPl5bfJWoQOxGqrcDxEqIKri4xoXzfYxkXuDM6a1GuZWgGGYmr4uGCZDPycw6B8GeDE9ZaYdshGX5ZX2/uSmN9l7rtFNi6sPrsyc8iGUTST/CEqfXsigV8sMZoe7HySYJLJ+CpSGFc79U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8mfi8ds; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/y+PjYaOfyPyZJLLYr53VNnwYT74SREaTN/U8W5rM4uLgIHRC1YakPrXeEBwEXCr0fhIEhcOrZEzkHFdv8fZZC1tMp+M5Gpyy7xmNBQA/YsA3C4olA1DOpWu33eKYbdoH9G9yHo9qK6ltD4k+VMs0G+4tFZDq8vWkitenpthNWBSxsnWUOINkNIYvfzu4n/NdBU14Wc6dEnNvhSQOV2OOyrV2Lj9paJP3HmzAvQY0QK016te2HNZpNbKi1V271XBKZFfodu98DMzDk2OeTQWMd6Sh++hCepj5kZjqMHUwJlxcz9sSGOQIK/ZgYjWQHhVEzu8Uc1kUG1ZeK1GeEctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E+642XtTKMvi9u8XNWVBTKUXDu+PE+Y97INDO4r3PM=;
 b=YXG6YwjvuUgdMjjxyl5AXQjtKCLLg6T6zZOLFSsQbhMufGL9Toscw9SI6XyhLW7a8poGIBds+/Grv6gBfUkVOhpLM7N9HQzdaMI6mG00Ek5Ea3XsBAHEGRnrsdcabpf/Gz+85e5AkKxe2xJEOwA2jHwFIodWFNqON1Ls7moBLbUORcHHr5bIaT8h8SAZ59TzmlgEgE8nDHpWcBKRS5Sxlmk24N/UiAbe+mLPCGIBLFyPHpwsqIe/G7q05rmhx/E25BC8Tl9po7RMWJdtpFyDdnwPNMINFM41BXpCJ50tqDjZpJ5kn2a5i0dSx/F5SU5YsncAX2iEZNUr/HABbEJ/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E+642XtTKMvi9u8XNWVBTKUXDu+PE+Y97INDO4r3PM=;
 b=T8mfi8dsA3S09bLyHepitH0Q89v9EeOWl/HGxpE77yb34yozQfXrzVCpQdhghebYL9hjH2UQp/u7aQzXbiETaNWSIVi2uGq5o3ccwFJLywPv8Gpr9/S09qCxTeRoFJeBrAXYtWAafvH1DLdo0DizZGGRAMpO4G1ppy5hbkmOY/cjAw4THDGBjbTNS1VGcnUQPllKN0Q63N2UM7GTjg806HTDd24Vg1yT/CKRqV+xWLAyw5i1EXVNHHAHZJ+z8Zi9LrqFcdg33SmofxjTPjE8YaIwu2jCHODm7T7yly20GPEuIupw5tWxrF6Ag2IZGNSjViRgzJMDORgx6ioFoNP5gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:46:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:46:41 +0000
Date: Mon, 13 Apr 2026 11:46:32 +0300
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
Subject: Re: [PATCH net-next v4 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC}
 and simplify calculation
Message-ID: <20260413084632.GA209364@shredder>
References: <20260412111047.1326-1-royujjal@gmail.com>
 <20260412111047.1326-2-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412111047.1326-2-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fabd394-b802-4977-4eef-08de99392e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DpEAOJTs2YUzs4G505WVQ3EnmJqjuH28GdJ/36mu8nQj8HLy0ITGeWLpJJRMl2btuK0TtmF/3Sz0FQKEgaxETQSx1XlN3k42SZPETJDYTpvCpI6yNCpWEhV6vUd0m1nrK9XRDfHYGBV2sYu8uc1/pbGvB0mAx+REEs0y/EHL9tek2eWEeoh7J3G/lnhvBEIhdQ7dX6mxIIl2TXjBxfbJl7dIJ8bwJBIzK9Tp+cBzyAHO57kFbLhitDVolYhN2Vd0YSziVR7JNSqQSMevpI4pJdUK1JMnW/5xVsqkPFcZDMb1gCNSV5O9lAkWw4EzKp0+u2ubkN7aedkp4+8TwCDUlaheTtK035vPXakTiP4EMYr9zM7KcQH11Zu2IpOyaDs926KN0sM6hCe/uscl4e4wJgizMjqtv2BKacR2oCwmnOvRFcJNjDmZ03RoKc3qqzjxSmoqirut8YK67FO0zaxnEdI+ursWwYAxPhGJMCxdjZDAbFf+orrsFm9X/m3r5XVS4m4BjQmTH7GcGhWBHzFTmDOKgA/aJWbgu8yoVcQIBGoGiIzJPqxdPM+guLxoHb/ldAnRs/+ljWiKtaeZ/DgNePRbqukgYDo/lTywEbH2GXZcuOdxV1AWrkZDf8ApLwj2jp6AXeGYmhqjkL0RD96RHD0qUHK4pD09P3ToEK2zIP3YBr0yTBDXlgazg2VafNS3kUuym28Y4da7L4v5SaKgxGgbQ12qu4AEAgoyOEQTFBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4UQP7ZegB0yKoDOYJeYNe0Do81Lboq3XHDohogKuhfWKLuXLAInsl3Um7PL?=
 =?us-ascii?Q?YxxaShTUiDME0MJzVksHyEqQAqo4j6WG8ylbVcE5xPT8RWSJBxcML9BpwoGL?=
 =?us-ascii?Q?Id5e8+KRca9Pzx7bfkrBRI/OKvQa0poPmIdK+34U4Lt+7ZTBbw93BOoKiubo?=
 =?us-ascii?Q?HukY2VS42hgWZNA+GQoNoWgLqrzHs+sEuFSsxtSSrg13NzV5M0F3Yg0RcaEF?=
 =?us-ascii?Q?kDTLPp+7W0NNhX14JtNpq98jshYZ9eLER23h7PzN7jPMrzB+/iP2Q/Fo9adz?=
 =?us-ascii?Q?rXJWZ+njrlJr5EM5luCV+H0m+/+kYcVJfhsyA82Z81ySuk7Px/9x5BagLcfV?=
 =?us-ascii?Q?ZqdFMyBVVtuRnokLSrGJwFrQLK8RL4svTEVbuX1cgjSOW6w43fT6UcJelqOU?=
 =?us-ascii?Q?XygnmB2sxmYtraQH1RTamrcypDbhQHvcFwC6BGohkoq3lvKdBjHTBQG6jb0D?=
 =?us-ascii?Q?02ymwtA5O6htuTHeKYBrQkNdjzm7C6xRiilypZ34M4SZSZ5wEu1D4/AKOB7C?=
 =?us-ascii?Q?2lfPzbLruud1fPEfnREZNk4EiQM57SNh4063+h41S3kar3ZSYwNBiCfF/Rx5?=
 =?us-ascii?Q?F21dSD2n3jMemUhQb1zwbmoNoZzdW37H5oabnFkSOFkOYwy822QKQoVp+NFf?=
 =?us-ascii?Q?26VVYEvHsRWrsoYPTO+uEn9LyoTKyWuN4w1g5iU1yK4YRcDvXQFwkWY8EspT?=
 =?us-ascii?Q?Y7vSngkE8B91rAQYrR0JO50THv1s/09szm8C6yJlv9eY9yqiUGiZGOWWRoIE?=
 =?us-ascii?Q?KHtiTYdt2pknarucJPDdqHypr0aGSjCDVoSEHTw8agciq97zJ93jH8qIsSVj?=
 =?us-ascii?Q?8drk60xOBMUFywh3uMM0koMJghSDya44CmcsP/SqT4lhgkiWpCHxUx5iQrtX?=
 =?us-ascii?Q?wm6dhdkOEaufUo8dJXSNNO/tqGbsz1/cmYdkmh82QRJ3MIKc3GQTRL43wlA1?=
 =?us-ascii?Q?FC0N8oJhCAMIrRuP3nWyL8ph4M9P5hu4yxTlMfHs9kELSoUFYAaCrjjCk0JG?=
 =?us-ascii?Q?JobnejTmFbCaV92/BbW/1PUwFZ0a5RtKSf68rWIeetoeM1X1bMmY6xoOa4kl?=
 =?us-ascii?Q?MUkdiFgiNkqD+qDw0NLE9xflxEVOVc5Hc87NPYyJg76fIxTH2ZokERnHg6Db?=
 =?us-ascii?Q?j6b5RC+1E0vKJoedcLwYl3gMhJG2PnSZlK8Zj4hlMG6MP2GBFrOMbZ5fy21I?=
 =?us-ascii?Q?QSoB+6MAwYZm6z9eiATkaagLRU08+8IhNO5GP/w5iT+gD4bXOCOAWZJ6lqIY?=
 =?us-ascii?Q?gT2mgOxYfXUlewmnTmQJE/dWaELo76HBxndCMqMWt/YSiF4/DduIcxSI9Aoo?=
 =?us-ascii?Q?AD0Nq6QNfJ/JAkFXDKy3x1l35Jx7RPqYUKHD2wikBbqj0bDdAKGAUwoqPWHn?=
 =?us-ascii?Q?AUeamkTHrrktitprk402mntgYQkTthzNvzG4gkdE33Cra6Nh7khPLePRmvk0?=
 =?us-ascii?Q?faCDRacmZrBuVwqaUBD7SIbdB9aX0EmT2zAC6QWmG26IKHDokI49Vm6k39Cx?=
 =?us-ascii?Q?sHfrb68q/i2iESRW4vqr0s5aTiZ3a8n4d1oV2gFoTTXYjGDih8yDdnjwsXpc?=
 =?us-ascii?Q?QdCEUShT3sujtqSSzGJOl5fjkeQOEYOPuYgHdzLVJ+6wJ2iS3uGVKT5+Ej/y?=
 =?us-ascii?Q?tV02LIIiFWhA3a0timFwXIAISfCVcciovdUbB1q234EDtEgyUQYo5Ke5MCn0?=
 =?us-ascii?Q?2cAq89yDEzL76JrocfUCriV9NAjpagt5YGldwKoe3CWwUooq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fabd394-b802-4977-4eef-08de99392e83
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:46:41.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwXaDHWxn8MRTWKq/wfD/GW69P5ik/T7pmDxRlFiwWT9CkxtbEFmkrDWZN66vzHoRJcLyMchsqS/ONYya1x6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277991-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: A09953E94F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 11:10:43AM +0000, Ujjal Roy wrote:
> Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
> calculate the Max Resp Time from the Maximum Response Code.
> 
> Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
> the Querier's Query Interval from the QQIC field.
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

