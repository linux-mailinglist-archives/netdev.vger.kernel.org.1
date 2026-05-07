Return-Path: <netdev+bounces-285278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGtzLix6/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782374E79A4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B00D301586C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE733E6DE8;
	Thu,  7 May 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QURX5oTA"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1F3CBE7F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154024; cv=fail; b=rJTrj2i9JfgSdGT0xC3H1QYTNAhiGkeLRE8eCoO1N5gLtiNghxVAbHN8mh+GHcW1SxzqfjWcQxbMACAsU5qT+XGgv7AfWE6bXsCDwvy8R9mmV5PEdakLGkgiDCUXxuNAC1oMbIZMBYknbzom8y+xTZAe+GqM5EiPkNtEmsuw3m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154024; c=relaxed/simple;
	bh=gglf3kh5BW6qyiHhS+Af8XTNWgEftZyBzktESnW4ZXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJYX1vReWrHkaUomHQRHiZlrvCsUF17ec8MHFVirOJSzS91mrhTApvITkV478vXjOkkidjxWmJJ9uzxK/jiHTT6RGaBnd5jwxdwPfIo0UnqusYCDoQfEviqlL65/du63FWSDCJZoMzA1ifwWPjV0tVI2yjpxBAjnzTKobNnNK70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QURX5oTA; arc=fail smtp.client-ip=52.101.193.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm19ZFo0wVUnaZZBtIgZ8AOpVUwzYBMXPYSuYQwfQ8yng6dkGZmCYYa7TA0g4S9AT2RPq9BHrHrPyItlRn92XC/wjw3QGuTRqa/qP4Wtt8jqQjb+90L98MoMX/2tNWQOZiNKArfstwYlWjtVQElzanvJTG4BKfzg5pBvJICXtbgVbD4Qux1DMd8hkyr7RgVErYiFOxaYGFR0xKp6oizONsiuGxsCLGSUwH4TItGmwkYxv7uWXyIJLFW3rldAc+Z2CcSCGpXy/uAmF/4zc+DMJijZIsVYshaUuwcw/2IR5vA/y4aICiQ1EdPdh0EYKr5V3SShhC3wqz5PK5TRdsS0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOv+rVwYBZFYYXRcAqCBrg7bEZoHC9RpUM3GAVnQUUE=;
 b=Esb+HkszfccPdSVk+Wd6vh37lFrvbVBBEgGkipOPVrcU7uAvRXu55tIcHNJ3VPJWaa0/qNOsoFUiJxWU5jTB09rhC9OvtVABNJGDxZ6yVUO9R0nSBZv0qkXusjtleHA6UC9uBTZ5pl2HZ42aFzzu7m5X7mr2OaqRJpulndsuNBcpVdyT5V3n0T/47VpArsEzisqjAfhsaKkJNt5lOamsKoCI6ayh85gBWykevJZPnz2hYFtJHOpUCMgRLI5KUE8PBpmbnJno4eXDoNr2Ejr6ZpIChpOqp3JmqGmxfyA30atnyPsODqqIDMi/XGZhegoS/3zIMZ4E4jh3wljaHgg09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOv+rVwYBZFYYXRcAqCBrg7bEZoHC9RpUM3GAVnQUUE=;
 b=QURX5oTA27fRytWD26Tvtk1wMqOwWa8B+u5wX+RwTwoT9uHwZfHmDXeCmeHFSdT/7X/2lsznFIv3t7Kob026AVTc66JDbxSDoBBS7Zhs9DXGhnoflDNegtNbHvyGr2kC2FjC6G0jdP21MYMEM3Dng9NYW5STbxAVcw9cAC2YMvpJsXq8EMbkK58cQ6mFkYQS672Z8cv45UaIeb+qh1WWU1gkrAhM1bB9mhRBeYSN31YNnp7hXVq1pkpXZgxGfEXl2GrNcd+2PPBUJN4oTO8giNrXLmaRvUEf4y2XS2eKlFWxNHHzqGQGZK8jAS3QfTCJl8nL+kPtCWy+5ZVYeq/hPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 11:40:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:40:16 +0000
Date: Thu, 7 May 2026 14:40:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv4: Provide a FIB flushing signal from
 nexthop removal functions
Message-ID: <20260507114006.GA908463@shredder>
References: <20260507075606.322405-1-cratiu@nvidia.com>
 <20260507075606.322405-2-cratiu@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507075606.322405-2-cratiu@nvidia.com>
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: b23d6be7-b208-4c79-69ce-08deac2d68b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y5slDtw7MHjkPUlkJaImeOO8jIzYay8ItQegF3kDPXvgy4BnamKoJFZPuFXy0zkOIWBmmrMF8uVwP8ZQ7DIgVRGHz2IJPD8djp3BJ432ExnajcMR2LvQB5z7zuA8ufPrpvNahPpnCUc9D4uWUNRbyhkKQyun8oNq7ROEgtjFEmThNQKOW9w4z1EZUOYGF7dVW36iT2GFT2d8hQgmDTCxjQ4KzA8Kb1ZOfJB8r+Xe397P3YGn1GTCh0ENaR0KDDEOcq5b0o4Hse4RrOVpo58OFjUll/pyn/uaTNA4RRBzO3hqSc6YSS0WSXL16lSoH467kUT50ty00jlR+JtMiE8Jc0SfL1P2SWLN9MxOV1OgQZmhXbViIkFl/sXvlAAhqLLWGp8FdiKktB+7cMqMSTPwwhTF1Aolrr6tQ5dIk6EBaXdQfzxUhJBZrrNBtIFh8v6alLQZF9Vg0gtQKW5R14tPE+vk0u378v7WfHdrN7CkiK+5OXOEEmeUz4x+7IkiPUzGMB1WqgJLxghYLn4EyCqil5LD2qWpokDgPZn4T9LNaCagI1fcf2RoUmBMUpZkuY8LssH/dMQ+3Ty+AKC/yfz6hHD9l6D+0Q6k7/JoALNM6ycJwm0JSBlvqh8G7zxVrf44MLC02FY490YO9nrUd++WREN3kBvEFyEwEv0ym7f4CMPjHhHh04gy/sN60fiOON23
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?clH2PSJFQpSXHMKQ+M0lvoViZ0/dX2vRWTlItAfAZ86N3PQL7QqvNVBt/muK?=
 =?us-ascii?Q?xrhtQ9r6vbmt5S2fN7cYQbrXE4TwORPJkHc3f2iQVgpyYk5duXmHkrKve6Z+?=
 =?us-ascii?Q?Ia8A1ZUUnvfabdGhs9RFmqsuiqBb2UsGu9jE2i8JkPmC89qV3QGxwOwGn7mP?=
 =?us-ascii?Q?YfvNkmI5M8gwi9OyzvNzKAA/1m+3/FOVfF+ltkJA71CCKEDsnhUPmYo51o3s?=
 =?us-ascii?Q?mQMVI5ind16MJL/wSN+EevZx3wzmeC20pvDqphz7YwNNBdCX9YnNi029ZyWk?=
 =?us-ascii?Q?vvvTMMmk8oYHbBJe72Q0YE/yt0FFqyIFXC2/NEORjAL35aHVbgq9qUfsv8eu?=
 =?us-ascii?Q?GHPJRqH2xZX5qUIrrjPheS4+Jzm1HNFq8Wq/xbJoJa9xFlGNQaTkHO1PLAjJ?=
 =?us-ascii?Q?rFvzx1BqMd8fasRyzQbL0U+GH3o9QjqP+CXM5TRUpP0OaDuOw105B2cfSw9n?=
 =?us-ascii?Q?pBLyIbxvb5nLbvmyg8CDkuTZyUYJw5L4hu+d33I8WzvAsrxqJ348yClmur31?=
 =?us-ascii?Q?sm7WvmJsZgF6FiiS285P/EPjqOmusP3UrSc4HHsSJ09cSTqQIUucWNQSTDtf?=
 =?us-ascii?Q?YIKg9ckmHpbijcOBWYmzx9CsBhFJBLDz1iyLJe3BNniLWJJq2A7o+106vCln?=
 =?us-ascii?Q?UfNpj5S2IDlaZ265EVASju7TdPfC7G0Sa5xtvSBf0lX0ua1CmCXfvL/eeoIL?=
 =?us-ascii?Q?fTjM0HzIB1QTRf1My8VNIpKbaScCpXBjYke3sUYrQYQZ2W3EfX7FVKuBtw+L?=
 =?us-ascii?Q?OhZtYHbFhq9nUbuuMcYGKHGvtZ5wfRB8OzWj6l/gOOUyBHQuuE4vhX97VzT5?=
 =?us-ascii?Q?2V8SaaU86FFt9yZzfGMUvjPnhOj0YIlKawWY3iuYB9N7a4n6TShCrVhp2h0p?=
 =?us-ascii?Q?UmAAY1jbdfjRxHQVh7VeDe0l1fsI6j+Gni5TOK9CdDPcuOyasn8Did181zBZ?=
 =?us-ascii?Q?xCcKIQJU2oow+2VuO/W/w6SXdiWLNHvzexxPIfldAzF/QMoW5Op5lYfRVmAw?=
 =?us-ascii?Q?axyZtk4dODNuIy/9AGtCq3waCk+d1XAiL1P4/cf4gRSJgKDenB4ZDBtvp0Yp?=
 =?us-ascii?Q?EDPBDacVPf99KLTmz+8IXDTqefUuP0zqDYrOo09tuommGM+ahyYqEOu785wX?=
 =?us-ascii?Q?C4Kzk1zDaXd2USfAElw9KgMcQUMJKjn1/wrG/Q/q8bEtV2DslwcSEgrsY0BD?=
 =?us-ascii?Q?nppVhayxxJpWocc8oavyoH8PZo+Ttmm5niDWswDlG38qNxhDttN4Z5Ht3VPR?=
 =?us-ascii?Q?OiBXYtQumt1N6qbkFWzPkn+s5YttKMOvU13aNnr8zbepF8OJTduIGL/bhSHo?=
 =?us-ascii?Q?Ms7j4kkdJrQhcOxTQzUSja9ScTate9iid2BA8REtaNoC5uBrfoyb7YWipern?=
 =?us-ascii?Q?M6eablxIviyPfS0CtMnRjpUbJTPzjyXxEKuYI2DsJqWZkL5QQYOOOYboGAY0?=
 =?us-ascii?Q?sVnihG2GYo4dUTr1SGHhOhJoDwV9Q0UPJZOWVR9BZSfUbhZl66CVgB6whWEH?=
 =?us-ascii?Q?5qThOagFV/pM1nvOWTqkOqDrqSuo9wwpMFQFxZSaI0Ejk+UNoU+eDj1yXhIA?=
 =?us-ascii?Q?8orfsQS946qcqOIgzAUC7FfahDVbTMXSZmIvkE4lq2DLZwNe9FHTWp3ERSCv?=
 =?us-ascii?Q?qjsRDl2ttyeUCVqA8gObD14W8jcLC5nh1eSk82FKxr8il0EhE3U5Eaok1jLZ?=
 =?us-ascii?Q?9hUl6GC9jkFWU5TRl6rYjFvMkeQutpAjNvdV4r2ebKNNPzn9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23d6be7-b208-4c79-69ce-08deac2d68b2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:40:16.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6OTj1jdN8JGZCb7P0/7QY/8G09oTgbT4KezvaNrH+fveShcOqUcOrnm1PPLsWQAQMjEw6EJTPh4nUBV8GVM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Rspamd-Queue-Id: 782374E79A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285278-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:56:04AM +0300, Cosmin Ratiu wrote:
> Plumb a bool value throughout the various nexthop removal functions,
> determined in the innermost __remove_nexthop_fib() (which still does the
> FIB flushing) and propagated up all callers.
> 
> The next patch will make use of this signal to optimize the removal of
> multiple nexthops by moving the FIB flushing up the call hierarchy.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

