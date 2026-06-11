Return-Path: <netdev+bounces-298164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iNfoETvKKmo8xAMAu9opvQ
	(envelope-from <netdev+bounces-298164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CB672D12
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=eCM0kxg7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298164-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 532EA300F254
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7292C032C;
	Thu, 11 Jun 2026 14:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D935674D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:46:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189172; cv=fail; b=nC0h2IRJSS+ls4lLHkCTBklR4/cHe2aDzp3ESb9F8amcVhksLd1Ly4bAWI3T8+vGc4c81mG7L3pn6NjS4ngfxRu2nn8/jiv+JuQKfNk8qABp+HUsFpB/IoCd+KO+syF8D1FGp885DXzionXo/PExCD6u/v/c3gJUny/JjZKv8qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189172; c=relaxed/simple;
	bh=ULZqcc8UEIwKW6/xVSDq82wxFhL6sgXHRPq3U4yiK/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3pFdf5D4KvKRLOSbQckkPVGFC/LVeXMej0HeDRE2vfmD+v9G0rnspw6wCeZI6rVqsLTDorEBWnHnu8q0qPnUAOpEUnsbNMjGvKhGVNZFtAwFHAuaQ9BJKftecXftdDCtAhJe6cT5up4Ae3t9BgEkKiks/ne+6F4ga+BT58zP24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eCM0kxg7; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWeIp/v4JEu7iC9L/YvwOQLfZ8Fmtv20ZwypbzDtjPsdfheB+dqdVPqnAFezrd3mpNG22ilggNbpK5SBjyBPtqYZllirZpI1yQ3IKqFYTd2RnfdrG5A/lyOEdaaOgjgWTe32BreRS/WC8b0XZbcDsdrHSQNGs7wwmMRKZ4ttek4N1DMSbv+CCz7Sk/5rKnwQv9D8XRFoj5BIhOvXPq74M2Y+R4YCDUqAynivDggQreFU+gBifHuY3EoZWAk+70H7PJ2Hab1LNll7WdZd0nFjEi1rm/ANrMpZ6d02Ecv7v+b/tM5rzYUGA/YgVQbzF4kmmmdZP/QCLiWNh4sXhmEHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1yX3us7hZzBDkM8HSInKDZBSR4+cCXS7vbsD3Icpqk=;
 b=crvcnEyjunDgd8W+hA9+W7/mKoB4bVhHlDceMS/Uj7S2gB6EDiuKsomoLIvtPYLGFz/g6WrJTawxMwhpsW++gt3IgC4YKU++r8SUo3nPvu6u7S952zEzgXd9WlxS2ZmnNKorFMnU45EG/rAyfH357dLyxd3pX8AozI+TEavU8/cTiyJrINBTZOfzPoyL0tRqBGRfDZ8jelobOOJI9RTLVZh5aLtn7+KpOLir9VrW/b2pGFJIiPZ37kYmwC1wASReINi3pcWKQOnta1RTl3WQDe8uyOowAw0AviA+nyqPxIGpf8BfVmN1MyQIrf7B6Pr0Sxh0pP5x0zKgH3JjchvK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1yX3us7hZzBDkM8HSInKDZBSR4+cCXS7vbsD3Icpqk=;
 b=eCM0kxg7dU6q6BAHMWCaw9f+1TcppgRcNhs9tllxN0iNC0YSiav2iyCw5drt24+6qhivEbMrqIyjxn/gYG2PVkZOMXcl4vZFttPU3f/WWn8eaHHi3lSG0Hg/TvJoAolJ3W6HS2aT/XwxkIBK0irhf2OhKTPrnpM+tcU5uuSaiWsoqtUM48+5ELUvyEugpTLzqeviw1lgpSVMJ5VbGo9eoBtrZU9rVGrkwtU8OojVzKkuHySxjlZh9FDvkgs/H9ovIZjbJ8WmCM7SNAFB3Ww0UcllvIjb6zZ/CCVBDUUwChzTl/3FAOu6lbvgrW+ukyRVDZz5bDsZVITYjwJCol+aKw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 14:46:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 14:46:03 +0000
Date: Thu, 11 Jun 2026 17:45:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] ip6_tunnel: annotate data-races around
 t->err_count and t->err_time
Message-ID: <20260611144551.GA972279@shredder>
References: <20260610171458.1359630-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610171458.1359630-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eab513-dfa2-47fb-d5f4-08dec7c82868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XMSAKP3lRHhi3j/fzGCU52/pG+7w9J0pL/sUyI4BJqwrrl7dO52/954D3zpfKJdBlEMJgWVj7C2QQpt0iU8ZCjjxZttamwhhiO7OF8Q2TyR50Rwbu8v0QfXYg+7bGRT+pV9c469cy251WwXChlXWLn8pJijUV4FcKLmDI3C1x4oqesqz2pa1ep5nQ4KYQcH5IEmTHnVvfJkM1ninNjJXg+hJojg07DaeYlFv5TUzGmHLnfLtCoEBSNeIuvK1iEr/phTlIvyOoTa37ZlgDA9eA/f8JFKpp8fMmh1t+TwCCIX56sqcyKazXpZBYx7ALEKbdS6x++vbsXmrG5zE8I2OxaxW198ZUnP5TuMMhU6Q/m/zGS+gL/DwlRf0l+heWoxooTTR0JeabDH3oNWu+sCe+VpSlioyv192VJVblBd71PezT3JvBdg/m552pVaOaLrjWgMNNxuh3by53wwS0Ni7ltlrxYSIg0KPz6ZsTvh8npKF85XpKOCvYwUH0RC8qfpqxMaNyFKz9fUKe6i+W6egFy+lVKnkPw6bLU+5TzI+eRQEmELXnMSh/DZWikMBCMnOwbkPfj9IVmfM9kjdNGU0qPB4Wq9DVahDoxfRTqDaf5RclU/4xhf3smeW2Wp/NiunS0NeJyEJY+Tx+vdeCj3svy1xhCrExxi1THysHObyzZrCD2L/L/ga6XAeWdiPnnJ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPSkIEfpbTeydFIUt7E5ACTgUyWR3SlzA3U290yeRh03HxBCJnI4FnFeI2VV?=
 =?us-ascii?Q?I9US+YkbkYPlrePHEmuM+78zolgdRbVkMuLRklzIov8FSjRp1LPfIRFOM/lR?=
 =?us-ascii?Q?uAxf5XdGkL0Kirf2RjRWnKgG9+12rzT6iWyquc0iQlS2IE3tmAUiKpLd8UR2?=
 =?us-ascii?Q?PdnbLvOYqmZY/wAZjiO/4goPLlxwoyXwpqRMuXpzpoXNChGrbfNOOqC3L+TT?=
 =?us-ascii?Q?Iw5zV9x0yNBMnZfIkBSuseGpxjsNsu8cnGIN3Hb7awPkQuzViTSrcP83QMRw?=
 =?us-ascii?Q?64MLpmntLSQn37PFeDK8pAEPTTuSF3v16WwmlKxJboBhVfcJgup6dbltW/tU?=
 =?us-ascii?Q?21icvcW6Jp6Hd41Tb/SaMEYaIbB6VimuZkoUhITIwDq0f9lHRi82hRQcsTQ+?=
 =?us-ascii?Q?b/S12dv23Da7A7zP1o/fquRlcYbUGGeKzBRPVqzL1CSBLioEZ3SS5BMq+W4O?=
 =?us-ascii?Q?W5zvzg+1TYNQAH3kIo59tqjI3cn8Z9m57+4hUjUkiyz3cJ0JHNstzDpLevpJ?=
 =?us-ascii?Q?rRRlG0TGC+U1V5d0xoONbb/DPbmkRCPpAUaSAzaTFG0f1C9pd4ay6NBY2reV?=
 =?us-ascii?Q?mx3TxoK/0+df7hifqmABXZnpyQtwUMeFYU2XdZfnLyRBX7IjBKM2Rhw3ODDb?=
 =?us-ascii?Q?Lunt6Nx7oxoxrfdwY+ny/zMT66qphDhuSz4C+NH16Ts0DUJ3bIdLNg6NyWBR?=
 =?us-ascii?Q?A/tViI6nV4kXN5Oq0XLGpHtEQtQSWfB7j+t1PD7luN5GKE+wLDgIyWOtietl?=
 =?us-ascii?Q?7Q4uu/Kgt1b3G7KCv5+Uesjc71pFk02k/odrC2D9WWf9SGCyUo7TyV9Psk5Q?=
 =?us-ascii?Q?KY/JzBXo/92skNQcD8tHQVYKxDl0eGcVNH9aQ/2HSG/RZkg2L7VaI6yyiSVj?=
 =?us-ascii?Q?dKg4em70XPVy7HNvL1j9WnqtHYABJEGF8orc83b6XXmS9mtFTEEZXqITK40/?=
 =?us-ascii?Q?dHZwRnyYsPF7phaHvSHPb7vh8bpxQczbUPe6xKC8JOZQbfSledsQ0LcfnhlG?=
 =?us-ascii?Q?TxCxpYYwAVlysWfiCgTWaGgQ7jskvhiePyUylleNGo6jisANsuzL1zgMmAPr?=
 =?us-ascii?Q?mM1lZ1uHrxZydXc9jT6FGKcxIltIif5eotewy9T7qoNhYi5nE4tOVI1vjCKp?=
 =?us-ascii?Q?aj6u8FxF3eb8IMcuugieJive6lRNkPoIxy6Qk515s0tQCww5JS0of8Kg8jg+?=
 =?us-ascii?Q?GdDIScssUbMDiaeUX2D6plAkuT7IdRiwiE3fpWVnMAjx2K7mg4V7gpdsWsNd?=
 =?us-ascii?Q?//6tjjcFDBB4fnyNYjtV1kPVzzqTISELz5EWjbxG4QzKEj+C11sJn3q5FkGh?=
 =?us-ascii?Q?Pi/LuCPIeW1YkOG66I06vO3fC8boN+xUZHENm3ltTSspTB/LDzaIarO/Fv6H?=
 =?us-ascii?Q?VhtkB2NkAfiE6tEOMHEZMREwYHDUU4I1e61gQXT4outBVWx8GE3SSJSIEcsA?=
 =?us-ascii?Q?OlkYAVaPfzFaLRbfpIISc861tRX5yv4vOiJGNaCrPZetil8FQKik40mNE5lc?=
 =?us-ascii?Q?5FOj6TMAWlGLFTWE58tAT8j+HSymCgS3cEMVCgJWS8XhDQSVOk7q8UDJ+SnR?=
 =?us-ascii?Q?Hm8Zo40qjFhF4slPHK36g9D7b0ex7QMMP2DAXDZ2M63UKC0CA4edSNZu3fyO?=
 =?us-ascii?Q?IzXBYa9KnkKvuxfGlvSWVyDBMSG6WtJ0564PAp1hqmw5h1b4QjI3U7QeG6SU?=
 =?us-ascii?Q?3FNqJFYx2oBgeD+zpdm67V2DGmiUFqxJ3mlWJ6oLI90UHV4F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eab513-dfa2-47fb-d5f4-08dec7c82868
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:46:03.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/Rcefb7QoswZJCbN0HqZtLLiinez+EvCmZeXHHHlBKwHuAtI/NzImFO/9iDJIRIoARsj42Wd87qKmeczPZstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298164-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 433CB672D12

On Wed, Jun 10, 2026 at 05:14:58PM +0000, Eric Dumazet wrote:
> ip6_tnl_xmit() and ipip6_tunnel_xmit() run locklessly (dev->lltx == true).
> 
> ip6gre_err() and ipip6_err() also run locklessly.
> 
> We need to add READ_ONCE() and WRITE_ONCE() annotations
> around t->err_count and t->err_time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks for the patch, Eric. Are you planning to send a separate one for
IPv4?

