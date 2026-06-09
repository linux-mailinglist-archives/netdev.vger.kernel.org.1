Return-Path: <netdev+bounces-296940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9F7tHpjFJ2qE1wIAu9opvQ
	(envelope-from <netdev+bounces-296940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E542B65D5EC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:49:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DZPm3vWI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296940-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296940-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90FE7301E3EC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0263D8101;
	Tue,  9 Jun 2026 07:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAB34404F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:46:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991181; cv=fail; b=BxsS1nmuG27GEAZc6HXLeP096p2T6k/PVJjdPaNiojgBJ8ts7XDe58KIU7ZKOzhp8nU3YNH2Apzhn2TLp9kd1G/1z/dLHJR8jJwFBv8HExiLlkXhGuvydE948NHtmurpWr+3Ntvfj4RejdYhvZ6YbznZuEk80Zu5/zSn8M+rVRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991181; c=relaxed/simple;
	bh=n1A8U6RBVc3lk5bOiTMQVJ4EYd3RbGJkCmFo5q8HbWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tsflJYbfgKCH3L1GWMox3TngSUpo7HmSH3hzMPEh1eQ5RHxPf0vv5xTLcXmkqbuXVNICZ2mmV/LjmImAAQQCEns25JHBnji1bLYlDpWecBs1bU6aEqUtMh3r+1ebok1n1M6Z94RAcixIbvMc1npA445zjdmuslbCyBhmtorK/2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZPm3vWI; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lomsZht2upI1ctIgMSRDL6t6eAGE9yrSgy3hpBEhnuMgw0SjI5UhsYrWu6hmsZK16qMjeQN6ar7raR8iFo33N+aA5wetn8/PLcsOWR8UWg2oDWqqtS9+IbqLHFeZ4UUYMHuVIWZ1EHOrFQPjY6RrviYWLKQK4IQuwd3cHQmx87dinqvlM2Kwmq6zV2W1ZNnswVy7YhUs0EPpl9U1mGdPiUkqfbsH55nE/DjXKjonqQvtJoX0u4ub1j0CBy5VX6ZUj+NTREet57wzo9DibO7a0jdTCxSk5geQ9qfboi4J4HXrUwxRQH4l7dvVPvA7Ng9QA/1/jHw7/QsgSw8f3S/fJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c44j5lM8cDDTGoMspIWV2SYQ35NUsExS0URpe52S5ok=;
 b=xDQ0TO3XRFTSW1zRrSJGuk5pNnuPw/1E0ZwouTjBjOpdE6hzOfi9nw3tUnFugFm5q1BgAKb347XFy7ZPR7atwiMrbnGOlNWorER0NmhxK5Tc643EstNb0xgr+fzf/DK12DjapG/FkVNnX1Cw0lKrMwUJed8RTOvVebc/35D4YK89fbYiGr4qQ4cvH3cxDOUL60y7zaWc4ROHZhJBS0DM9A951Gcx8J5775gIvHam6oaQYtJH+YXhz7VjCrcv/BofwDS4N6EThhbN3HqRM6mJJ+oubeg+TDBRViGyAo1Y0vbldDAHNlXpBlr4+2eu0lapRjE5S64S4/tyFvzo2KxZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c44j5lM8cDDTGoMspIWV2SYQ35NUsExS0URpe52S5ok=;
 b=DZPm3vWIeXE+9YyPuxNgg0QMcSehagYxCXQU3wpzSLpmrJpIkqcldQt5UYFVdNc6iypTWYL+hlmKHhFXRsCUM69ENOfX7fjudAmvEWOng3Oy/LcweJQKV3m/0JI2KyLDbZnRFCpehAghtvIVc77rLLYL7wlHrDYQepCUurW1TDEnBwQlxOKtwfnz9vEuDr3tRw7Ki5WhLywQcWlKkvrcGg+2TEZT9lHfOe3OVEnHT8UrA9Fa7Dl//lBm7Gd+dzmOa5YLfmmKejf2TM0IcdoHg1HdG8MBGyzkFfkt/LFn4rAYcyg+ZK00X9kyWapIxL3UzKJ58hG3moZrLmylVdQP+A==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:46:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:46:16 +0000
Date: Tue, 9 Jun 2026 10:46:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev,
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net v4] bridge: cfm: reject invalid CCM interval at
 configuration time
Message-ID: <20260609074606.GC663407@shredder>
References: <20260609065116.2818837-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609065116.2818837-1-xmei5@asu.edu>
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b8028f-a12e-4d22-a283-08dec5fb2fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	K/NcIPhSqdA5kxA12A2LFCuQn+uLavVjEGM/odyoG38DXefkWmwMeT8VzxFdw6VWIFffraUG3ped155BxxPBShcgau0slOAyHjUWViN0Ziqrzvdt4xRJQS/jxJRyNxWZ61/EXzJ7YBoTuecKNu+eqwMa6spBvEM6IQKVnGXEf5sgSnUzQi4bKiBgk8dHZObqAhqkYL0htzd4yIpyMF+yxD8CzifVl2pgnMoNp9X8JpIjryOj/IqilPhRzIfve/mNuVvEkXu2WuJpnkLc0m0ezygDg6zNSeUrfkuzW45+K3Dei9dBfizVzFQKLQMaI8ggTJY97z5bi6zzm2hZ4PYXJQZJNDpKL2Q5JES2QbHzKbgopI162J74V7QQzN4OXyrDi7fTo9yK/4WSMbmoGexdUlUd6mWGG/OrvzmDZUbj5OSPWCNWS350RGHnjfCCmjshYjriVC3rIkDBOwbgKOng2yhhn0Ryg+5sek2mG8QKC4vAwAYU4A9qQM70HOzcd16+VA2s6Ye+vgWMyhUUAMpEvkgqVNX7C/FyytrrJZibwV7QI2NT1SLTgbZxPRhvhXPJu19yTONegso8n87iw1pFo4GR+OTywkC2dWDFSw0qY7qQZCywRhwaXFfwu6YEbjReZc47hFTFRcBx2IM52sxFkfJHjPj23us/pPrq+ywQV8uz5oBFX7EXxlLdBr07fmca
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0j1zyiLdoF8loHSJ+LmP7sCDkg6Mq9OvNdpLI4cpvB+f57UgmXz99tklB/7f?=
 =?us-ascii?Q?URaXV7pzylXjUDU9s1zkID7SImR4Gh8j4lLfKRHxbGIipYJw+ByT9sIJMo9x?=
 =?us-ascii?Q?1sLzHiElSxhKqonEAONzYeGb29APFrUdP/lSHCOH9duMDgSmBjaMSPy4r5w2?=
 =?us-ascii?Q?L7rfdtluGz0rMv37iPBoiEcSqpq7HgxxUTXy3Drv6/F3y4Ma7Gw2RM54NHvU?=
 =?us-ascii?Q?lOFT0/o3Ep5TkImMXBM6b9K+vJuFGdZspqX8AG61YTlZsJ546zvPXW6kHYe7?=
 =?us-ascii?Q?hOL8os6dvKDkvdMKbWPpIUBhF2zEPMeNukhckDl6ZeijNy069wYPv+fLT/TL?=
 =?us-ascii?Q?hiGsvlSaCV6/E7xsnaoC2bJk4GuPMlvHky57BS4rycWdXYMtSwGjl132g3P3?=
 =?us-ascii?Q?MyaxvtXV6Dlhf8NdLllPAsSo9kFLeTDcvVtq3aE0zE1OndsYd8onmLPAGmmU?=
 =?us-ascii?Q?xMt0zOd68k4Ayltzg5RVA5MbukSYOj23HxWPOYlBISYAwCF0UOeHox2k09pK?=
 =?us-ascii?Q?t2ZmyQUyD5bsnHCOB5lqlE+aLQpMzGKm/jZOKVhPYSSs9Ba3TFu6lJ6fR/vv?=
 =?us-ascii?Q?c5tJyxnDBQw8RMgGFXRwZ4Ni8gHCMkagrqCkE8FNJzJ6DnGbFtbHbPhouDtl?=
 =?us-ascii?Q?JENATYEFfe1WClgNXQpunmZ99g9SxtiJnwerGY+asQq+owtYNxaxP5FUMMCJ?=
 =?us-ascii?Q?7W6+jvPsxaaZ+hBrZO5+JBkf1SA6YwS1BDfDfAEco9ix+7WKfsYKGY92QuQm?=
 =?us-ascii?Q?HczQYKxDpezd8tFciyCEU51dqH1Y0Upx3RtgOUnFCNF0Egk4FivfFPRoini5?=
 =?us-ascii?Q?wBsJxK6y7gqnaxYj7hFRlPAPL3uWxt+QafYCRSXa7J8WPYuqRY7IDs/xJN1v?=
 =?us-ascii?Q?vj/iSZNEI8pyvHn4oMArSx6l3XgXLr9qAJgdnru2FeuHMsT8NPNeIVPSSPdN?=
 =?us-ascii?Q?38PJV3kv/YNVFz+a35JaO+EgyKeTCJMvFUgscQN2G+m06beMFhre1Nrue3/T?=
 =?us-ascii?Q?YMR6YBWbuD0J0Fp6pPzZTRS83TuZE5gGUklFmR2VcMMY6uc/0haSecUE3lq9?=
 =?us-ascii?Q?m2DG091QDQkJpr0W9P55B6SxMVtTkmrApiJJ1075Xv+MVXJPYIHqDJJPE1+g?=
 =?us-ascii?Q?DiMYAC2MpxI6mp14MGKfgym5Z2AvKTPq8f3p0Apt+TBNufPj5U/OHkSfzD2B?=
 =?us-ascii?Q?LifrD30DoAiQL0lfcfqW8K9Hdam7t7KEgCbBiqaui1GeAQrXM/msLzXLvJgK?=
 =?us-ascii?Q?mIFFiXdvGgaLiAOisItoRzU4TmJc11OqWc+QCIEe9+cDtiEs1mBJ9+IdaKTH?=
 =?us-ascii?Q?QyemRZ6Fp9B3GRGVVoLoctQKnY+uF28tAyrcxHIVFyGQWAjWhFTiwiW9ukZt?=
 =?us-ascii?Q?1DWAiJXo/6QzaW56GITxhgSG0yoaXj3ZYx6LZkxAXifTIbNdo76z2qygIzeS?=
 =?us-ascii?Q?S0MDTOxjgEC4a/gqEjyIkUCWpjRtMftqupcsI1YD2GPnw3TOhgQ+su3dU3P4?=
 =?us-ascii?Q?K+dePvLtDiLCBacZjbLg1nl5lJmKWxek3cxHgM68yg4HFipalB475JnnVy2X?=
 =?us-ascii?Q?61LPJCVxfCVeP54qjHcgRuH5RSVfGwVqnKf+/E6C4OVkSUwMREjMMgsO/a0Q?=
 =?us-ascii?Q?1a8N2jpRMSSK7OV6eB7hulV3d0KwfZohu6MxXdAN3tJ7wILfzrtQ/ak1HUgW?=
 =?us-ascii?Q?Gj9XCjlqPjWd96YABZqJWzJBVIDVzX/pPzlqhVLpq1h/5dRl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b8028f-a12e-4d22-a283-08dec5fb2fd8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:46:16.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT2eyBqPD66tuGRaiiA/kQxWk72LhXEevE55oZCOGSJVjD5N0vy5l3SUqv6exev49UIvBRXH7a2qbRKaCKrvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-296940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E542B65D5EC

On Mon, Jun 08, 2026 at 11:51:16PM -0700, Xiang Mei wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
>  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
>    [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
>    netlink policy so userspace cannot set an invalid value.
> 
>  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>    not yet been configured (defaults to 0 from kzalloc).
> 
> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
> v4: remove the Suggested-by tag

Should have kept my R-b tag...

