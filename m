Return-Path: <netdev+bounces-298100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RBZ6KImdKmq3tgMAu9opvQ
	(envelope-from <netdev+bounces-298100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45315671640
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CqGmlkqn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298100-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2897300A49D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D63DA5B6;
	Thu, 11 Jun 2026 11:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC03CAA31
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:35:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177734; cv=fail; b=Xxp4qwl7JmzyP0p5SWNA2TOxi4W5BjPsiSo/1KOyikvE88Xttw6ML9WV5lE9hxIuTN+QXrPXo5pXL2bp65AJvewkHarQ+zEbqDRXznexmovFEGRMNCK3vo+FmZ00Ywjmo9Ri6G7AY8V1Bz6v3FGcteHqi23mENh/GOfwCmvmv74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177734; c=relaxed/simple;
	bh=EeAv8wAmQRoH5CXJRR5gg5a2PLaW0CyddaGYneTRQto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2fzWspcNWqa796tywFjlkauypc5Z7sDg6IsU9vBJPzpwYAJM5UA6lyzhBHOIF+DZ8n2mngDg6ZY1IQq8EzANbqM8EhG8qWZ4HRhKj7qQxNoYYZGArF3uNLr5XacRma4Or6ws4XfrVwQjFACMozDyKdElUZvB5/4d0MqtOFp1Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CqGmlkqn; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZykgR1lgCc/gPXXzvn+qC9rq6zATM12q1Wun6M0pEnU5lD7q4pnYfE/1Lg9WZ/xSvYAXTRVKl/vXoKvPIKzsyE2yPTOSe4wALjJKGz+h1YCyEpbDSfJr7FFosr3diiuW8l/oFoc5QCrhKGN/or4BCS3ZYunF+/HVYbZ+cfLuBb9dalV7c412GK6yW863XYwtDuM2RUR+D6Sa7xd6/7d5/sMzLVDUTrQr/BTFcOJMu20Ix8HALonXkSXlJDGgaBNEcnWyl1hprmLTrQCXoT4EoZwFpuxZKXL6PhsYVtZVI3aUlZOH1rsYAfHaXSjIHUSGlrVYX9uwFYy9o20Fsc9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nPro6Gc73OWDjAihMrZy1zrTZUFvvxVvakjgc+P1g8=;
 b=WYcDuGjmtsMhuDg/B19s2dnlW6zC5n75thbwjtGDksX0Y3bz8yOagRKJIaeCZ6EBZfuATDJ+yIgtYTTMVGhzi9rX/3S5Xa3Ce1S1c6U30ezjlw8HsGijyHDkO4+nG+6bPqLk/klV8Zg+5CqcZB7Nbf/6XJpfGZ9TwmlPueW8fPjJhptTKHvcDz2iKrcYZJAFQcJ8KK0qcLzgCV+qmIdNBcaIF4zPOv8W/2fuoeeylTywc1Pl+P5Vqz4m8ZGDsYUg72IVJvSAUErchezGv0/z4Y4ZMbQ3RQJO6CU/N6uG00LZmGXI+4hWomwRB27gKR+FML4n0hA0Y0Aa8+FMDTNZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nPro6Gc73OWDjAihMrZy1zrTZUFvvxVvakjgc+P1g8=;
 b=CqGmlkqnYH82FLbwWM+5nFqUDBAj/wOcuIZfOltdkHRCmWmKeI7N2A3QiJEbvcqdzfp+sDUSmiOcJUxp4gA5uIdEBI7zYTvflZEuxc1GE4+TVe0PeN4gLOjEF0I+URjE30gGuWIsP5V2TdjDn2Sw0Ou+gpqWBoiU7AQLVHJsrzKDgfag6aG72fKxPHowpc8wXwqe/e2PYoaopv12rWWvkS/VG0JJLBTkLKcPreNiS35NAcpN73H+95SVYfP8EJ1lTM1y/55KpQis898fZizImsXHAHrSwImg01hNC7q0JTYQsEKQfusAtjlA9u2eWHeUSVdwmlafhcEgnSoDU4ISVg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 11:35:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 11:35:28 +0000
Date: Thu, 11 Jun 2026 14:35:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ipmr: Convert
 mr_table.cache_resolve_queue_len to u32.
Message-ID: <20260611113518.GA907595@shredder>
References: <20260609222013.1550355-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609222013.1550355-1-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e3775a-d8dc-4e5a-6700-08dec7ad8922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8Op2ydT4AZ3wqcrJxN2lgGgKNyEcidIxDKoVNbJjFDB+zzNkkDiNR+HqLMkU4zP6Q0AE2yrgzCVNyG96D8fldp8SLRJgu1WIVfDKct6yP6LBANuVv2Hzr1cFDDfFSxjpIyXayU0ZsSzeey/bsaRHM5p/WmnhJ0UF3jlhebw3SVN3SNrg2Ii/gvLJL4S7nVvThQYlhiF9KOt3+BU2XsInU2K6bzlX/nC/CxFM1pSbJiYPKZzD5JgJh/brfEBsI9GYLYbriGzyOi1UfC8oMKBDJNaVmfKL6MjctU68rHXinwT757aI+Th3KRx6QjsANCXPMqhJXdr3oLIrstG2/aTMLQHd53ahME6SIDT9oB13plyQY69H9u+bEbDLSvJ0Qj/6qooE3B1XAohRpOXELWjTQg5EvmysczxTE9U4yeJlpZNa1CUPksNbJiyuzV+BKWEY/mw4yhhsz3gxW1gG2CcvefRZskeejDzcVG0O50DazX2pBk40bz+coJl2KW55co5ZbHbscNXTLFp6QSNCM+2VKrUGvZjIoJ26U3ZLZthO3suPVVObYpK6+WJe2b2FbVDD8UZVjjDRnyMCNW0cq0X8cwVP2KZuTw2db1U1kGUVQCPAIwhS9rEdXUQ5oN5bIO4xpHX7vw51TG6n/+nUBjrCexjvm163cl99T22ShuLsKFKaWIYa6GlqtJa3SnCjoBCU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEpihoZCRKPiiTUQSx37zWVM6c4Ci4DIV0K9Kv+CNzOQ6lbgX4secpQI4qY7?=
 =?us-ascii?Q?U1WjyJrcQMM7O2Tdp9SOoZAd5jCOIcE1XKCIzBYz6Tjr08vCZaZNnYkT47uw?=
 =?us-ascii?Q?4V3SJb3oGBJZ/GW8p4hDmnS1sLG/YSbpSnQlBJQxW7xeM6Taxut1luqPvmzF?=
 =?us-ascii?Q?Q8oFZhF09CuTZpaUk/CScru59ATVibBTqKxUGh5CD8Ksabhu9pCSB7Pt7pN5?=
 =?us-ascii?Q?TvdKsV+aj4JbsTfmEmlcLRcS4RFLCluLHktnnmobXDNHvoH48nMX37NytDsa?=
 =?us-ascii?Q?E5eDtZIIoRq8IYuAOhm0qd9N039lXa7GzmjTk+dCJJ0jB/R1IAXA6ZmD3ifi?=
 =?us-ascii?Q?JoG1dxQ9MGv75++u3q4KKJ1mq/8KoMH//7Fp/F4XlgQlbL0Cu93Bc1Aw7Jfc?=
 =?us-ascii?Q?+8Wzy7Q8pnGfMcx9SznCxzRs+umpCherXvkRAh6Dn5NOTl35YvsMDKM2rFkl?=
 =?us-ascii?Q?x0u1m1RnmUqsbUu+x5j0/ReAmKrKUHjkx0MZ1dLR7uqr9JT4SbeWRZfoSrnr?=
 =?us-ascii?Q?xPsVRAeDx9WekP1HgDw8LVAC3XafK7pYDdJqnYFFTrK+XZb49KzDbBSdM5B7?=
 =?us-ascii?Q?lvRbb3EZHv8vpoZjoNZhNYSuR8c9NMVH5BGLxRQE/QhQJcFQ6vTt0FXXGFks?=
 =?us-ascii?Q?Y1fE05FK86rf5nAoiBV4/HIgiy1A9q3uJxwUYsHt5eEuhmfoGwUJ+wX18kmk?=
 =?us-ascii?Q?WvXylNCxnwcx1B6f1U1CzWpScX4OyBAqWQnrSWHp2z8cZQjWFforNlvxcZKN?=
 =?us-ascii?Q?jaw7oVForroGrDfcdCmFlYmmMSY2rQLMD/FmH7L5hUZlg9Ic+rFdSzCsSTSw?=
 =?us-ascii?Q?Z8rvHM12dvKlZqtd76vfoiTo/qlWJlLh4lrPDfLEhr7g6vOhg4LuMRkeX7zi?=
 =?us-ascii?Q?L2qnSR/cIqwuLtz8112uPe9pccAP7aKzzkJYtIvZCgzXYC25rpkH7Q9zzkRg?=
 =?us-ascii?Q?Q+7Vl8H2EWgLL9EKdhlQeIsIicKxFKesJvW569ih2QvX4x6MwdOLfU2HoG/x?=
 =?us-ascii?Q?MkiBkHHhvN7uwYhW4RwzgmqkmOKBe1dUUZwwRD7VthyHtqBFyuwUfCoxfEBu?=
 =?us-ascii?Q?DNxrIirbQf2gprItbeGz5diAzxMkpChQUt06UUkbD2CV5QNZIwlVVDlLEguQ?=
 =?us-ascii?Q?5Jz3OaAvfUFPgZZ8DIjZKxoBZNxvT+dGSS2PuQlL5w0FvWrgh0XNY2vTnTan?=
 =?us-ascii?Q?PSUqmONZLEA5daTgN6xx5hba0LYPsaeTrmpMUzCkzmlQqtFYNp1CDXuhLBXH?=
 =?us-ascii?Q?f9R6dCvkz05TmPEPksUJZFMu35WnkrSGMDqSE8Fq3REjuE8u6u5REMVpy/eC?=
 =?us-ascii?Q?2AWkrfYW+UBLqivmPxu2PGvA56ZXNJA8Mam1IhxUT0wvqFr1/CtSS8h0Ck1t?=
 =?us-ascii?Q?CoCbKwO45zZ/U2Tw3UjLdbhtlYIEv9NY0LfcWxwMYnc4UuLA4KpfBZDTU4zv?=
 =?us-ascii?Q?5olWtvyNmEuNIsPxcQKR5Rlc0ovgB4Ddoi0tNIXNaKThkPrzq49OXwKwRO9j?=
 =?us-ascii?Q?oHbz8fvU41ZQJEgVObuoQ3rV1CSlEMAAj6Q6sqoa2OfP7tC4vUy/XgI5M6VA?=
 =?us-ascii?Q?CpxEdUeOmsGgy9ztCJiS1u2eS6jEVdKcUFF8sGqkfKR8LQf4Tbhp5QMQo2Xp?=
 =?us-ascii?Q?5cChEOcjwzfc+jPrpoRgcX1/dJDtZBVtn+LtQ2RkvbPkskyA2At87VzDJdS9?=
 =?us-ascii?Q?tFu6MisynEYhfALIvqqHwMGp+Yug672tAWhQyI6cW50Exvg7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e3775a-d8dc-4e5a-6700-08dec7ad8922
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:35:28.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQVIDkG0blWd/Ccwn5vGLElNbme/NDsEbfTixOLVAiGrBKdC9hZwa01D2oldDRH1sRKJ9xWcWgfHJgJu/Tv/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298100-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45315671640

On Tue, Jun 09, 2026 at 10:20:04PM +0000, Kuniyuki Iwashima wrote:
> mr_table.cache_resolve_queue_len is always updated under
> spin_lock_bh(&mfc_unres_lock).
> 
> Let's convert it to u32.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

