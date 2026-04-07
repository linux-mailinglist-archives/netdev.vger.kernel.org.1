Return-Path: <netdev+bounces-275877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJmmJLqt1GnNwQcAu9opvQ
	(envelope-from <netdev+bounces-275877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:09:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43953AAAC3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EB9D30097C9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4138E5EF;
	Tue,  7 Apr 2026 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FMdKLWRe"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D53921C7
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545654; cv=fail; b=uLgjT+ggEFTC9q9nH8kYd5RgODnG8v8Lh50anZYoEpuyLkk8/P6ibrLnKsVmI0Jo9uKWISDIZvvgkdFPDGB0n5BxLv+YSYfD3hNw6bvCVB3MvKP6QDz663RsTI61A+6C+an4fGqmgRBs2LYWv3ZVjjkJygP7H+srEx5YMTEoqyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545654; c=relaxed/simple;
	bh=Y239i+sT4ZVV+RR+d8PPesfeBu2uXYXHhDS/7hjym7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QkF1wfLjeb0WRJ0mybjXq8hPOb3r+B5DZkwYat/jqsCUe2yn7phk4XzTFdegynxemlRjYGf0c5WSYQ3+NK9bckncDknRgXdDfaGdxFtC9NTnhHvcs7eJmgBcyZ6ZvA9dmwOyN0woAWlVYevn62P6BQ4dkjRyfZlQqtmMInAN5Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FMdKLWRe; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuhjP7o2RVXS9qNFyHPRE56SX90LbsTbr7lQFmrpDoT5bJVsBdumSZBY1rpNihbeDA4k9bVVVzZ4daLBbsVsy4sGAj4yrwUfp34fUFb9aEEKCBuaFs+rfK8mZxq7evpxBmDa6RoVYxi3KaRUGK4BaZZ56v+d85IJajXDGqRGvxQP6ywWnp/fiJgc9LW7TJmbIEAUiMNG3OVJ1LxQohdJLF0OhoT/EM0n0yNttZXKrTjJ6c7PU5LzHuupnMauJdXIfrb6VJk1WEbRnoj+6ldejnT7ZN1es8pLzcf9lLbQzbMICPTL6Xabx0UOdRUMjM2XoxqpsXqh4mnposBXDvykng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aKhJxxbORXsQSG6+YSWLdncIHbAYUBDXBhTJfFziQo=;
 b=xcraq88dRDF1o0kgelwYkt38KO0v9HyHgXuOX9IPV90M2ejU/PnX5GYk5hbII7XyBjasM1GpkR9PpHO/xrqRoc2K2TvkVzAuC6goZtaSU1Ts7rWo32+Mz1b1ULrggIGRmVmrUrngXr1m4kH0TmI641EL1UlnfvmBAhJznR3H65mlx+njJvCn1GHF2RyAsax+R1pag9CePkmsZXjRqi0Kdhu5Y7OUVaEvXI1nY3IJWQFe+kh4MUhMIV/FLHtt7Tdxh+QY01z30Y7od9GTt3pS7fShD6d+OIhXqy7RGjykcUQe56Q7dFL5uy0i6/OxSidTY/R/3brCHcQEGUdRQysv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aKhJxxbORXsQSG6+YSWLdncIHbAYUBDXBhTJfFziQo=;
 b=FMdKLWReCWwFsYY0pbU1AYsFC3M43LHi56a7HXNefnWktR616reZpwltTkcr8xmkbNq/RTLHb0BIoebbTxfv/ohMd0/mRdHEwWqwYQaq47sLSKVDbAehKbLsgyzO0YKOC8GPiBevejkFUrRtfuuyix0Ewn3/ftViDfh2W7dBcZPHHAdcZmc7V1Pov8/cvLvFSXS9Hw0NucXU3ZZPJDf8I10z5RLO3FFu3fFo72u9O6bkAZdU2wz0lv6RIw4UVvR3vD2Fzjkmtmxh/nkGKZlqbvRJm0yWOPBfut9G0XP+w0zQM/9tZaGUQviuQW+u71iIxK8b+D9GfBXHMXlY6N9fig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:07:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:07:28 +0000
Date: Tue, 7 Apr 2026 10:07:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev,
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net v2] bridge: cfm: reject invalid CCM interval at
 configuration time
Message-ID: <20260407070716.GA752875@shredder>
References: <20260405000324.548623-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405000324.548623-1-xmei5@asu.edu>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: a20ac907-ba8e-4a5e-0fa6-08de94745436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EjiLeffQfo7HrujZFIIhY4kvqqMzSGAJighytlvStOlZ3Uh/Drt6OkvPhLGg3nj9rAQ0yEXd7CzxBPz5pa9MSxFe3whpQJxUw3CS08IX2CYdVLBc7voypfFGJvE7dXBct6OD/BlV91iDFxEQ3xZppdKcwgig6DHCnLIlFxomI/mjBXjnLQzfrpUOXhO4TKRKVua2lgHMPoTSBmGMJWPZvVI55/J8twD6KpkSs74s+Js2SlHAiIfBA5FJv/4nRSOxAjhSLyrCKvb4EPUw1dBXsU1E5CS7ms5t7fUgpmqCkALSncMSraklnjiRtINrrrVy72nEV129CE8CF4M6oncwQHJV5ty4+1mZgQe2ZNqy1H6djGyE2pUEu5AlQmFx5XlUhSpLh5NjQ13CATLRQg7Fj+vcF7zebLuOA9hHlJXzVChcLcP9rdruXpIK3RbzcpRQIm7X4849tXRYVYfuQYc7p1zgsiWVjc79Gc+7ZCKKLfPqidZ8fQ8261zE5zcZ/As8dzZD1Hp/C8mxPjJsrNDc+OkXXNo51bMonduhQ4AYmMNfy/tWaXAbRjmmvrd3Nz0W5ZGUoHeZEYpLnnayRVSRBGtePiBtItIcBI/r4kbx3BTv9tGHGrw81MDu5RthK723GQq4VOr10M93N+hpYDwL8y8DrwLH12D1cxS8ExzHgqu/dnd2AYkPwYNQVPJ61wHWb861KIK93auvcnbiPLfXmWmjSC2vOa8JlRe3fG5JLIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oRvYlp5ka/soOvBMsjojmAVtEPNUjZECk9BXJLF3lotQTtx2tO0TMHjo0xDx?=
 =?us-ascii?Q?IrBl11gFT1u0HHU2KBUoXZoM+auxluBpIKVQHKT75xijxJ0GomjftQKQzlIo?=
 =?us-ascii?Q?uPy5HRt9IstBoQvMOYIxUw86OIAzjvLvASHZAsg2bRlrruqOKRVmwzj4xvjN?=
 =?us-ascii?Q?E0r2xk79z6qW52jsh5x51Vvdvjj5YmC/ndSXKY7L/+jYZYdHavg1CK//Qc2w?=
 =?us-ascii?Q?wSuv67qURDBUVDBFUQ+4m1hxnsxQFWYOlV0ompqrdPVAB6dpTEzSd8CQirEC?=
 =?us-ascii?Q?DPhqd5E19CMfw5PZhQU4qJ5U+qkFccnCXp6Lah0QMk2McHpntXcYdSHYZKpp?=
 =?us-ascii?Q?n9MXWY9DCl0KGhCwKOnDiO+vT6aDugs6bSfenEHpJ34ZMeq6BM/8C/UrKq7f?=
 =?us-ascii?Q?jzwSb01R0B+NreTxlhgliXrx0iRk6uqR8pdz8wStCVBAEAehojyo/42+dw39?=
 =?us-ascii?Q?7xjFE9emQbpZRCQVgyKrjSyuUpU6BeBAFC14bHyu9cryhsuyWUZbZBma5ye0?=
 =?us-ascii?Q?wsb5Afm4wvat4XzPoVwuvJHi0C0V0PwU2hC1rS49oEQOidrh3tnIOapD6I8x?=
 =?us-ascii?Q?hLZnQ42sm1l+OXW5S1PAdHP6IKZLkmMM5HzOeUIKqXhyqx5GsQvPbuu+5hmA?=
 =?us-ascii?Q?lNTQQww6nn8v2Wu1EJrSdgLvzFquEStjlLbUThxwypRVtLAXy/UXXH9YxgWA?=
 =?us-ascii?Q?nG5zsPDC0um+5/mYiIkVdjwuFWuEPyjkS1kT8e7+pzFEfnHx1FhN2Z6lETJo?=
 =?us-ascii?Q?M2EZbemFuCrudaqIGAiHe2DRo69CYmO2c5gxeEKAfEk0wAMbooxAG2dXSWhF?=
 =?us-ascii?Q?KB5OeFReQRSukfs1fZAJ4+5v+VIach3U54NLBXge1Bi/pu5EiPx5I+DJpYdR?=
 =?us-ascii?Q?o16881LosLEg31R7nxKMfzplDl8sKrfY1x/L0dU0e08s8KLIfhX0HQPAXtEL?=
 =?us-ascii?Q?89jUJO/Vvv8SJXLdkadVZsBKG97wEv7mxz7gEckmhW5FVgZjbQVCXRQ6uWJT?=
 =?us-ascii?Q?k/PMQwKQ+pWrJYiC1LPn5cdfx7r4PseB5Oaf9cduUExf18HalR5NgUaOEjoa?=
 =?us-ascii?Q?GgZ0hnxD+f7+QBIo+RY9zWhxrdsZYQlHeisyRiMqxEHcYypMw3Sgl4ygSBhU?=
 =?us-ascii?Q?VDDn1OQC/3uM6ofE2knViM8HRbuDBnARVyIWx03nLf0Kgl1b62J33L02erRB?=
 =?us-ascii?Q?bAgUBUzzKlxsrpSg+jhaEsFFM0+X+ayCyKj1/L0GoqV7qitRv2JDJm0X5lx/?=
 =?us-ascii?Q?dHqKmDLwzP+N+Rvi31xW1yF57orYncUrmJMz5VLJZAUBgFWNjRM4lxZx+Na0?=
 =?us-ascii?Q?TkYhwstUVYbluH9jcKlAPskZY9VUfxyKy69zc/flvmv8M7skr/L/hA1Ad+tn?=
 =?us-ascii?Q?sxhiNRrpFl+3WUE/oZRfbRe4D5CCb4D61Ohyu9yrjqvqm9C56Qh3VAt88mOA?=
 =?us-ascii?Q?ElKXe8C+VlFTzsb5NicDjiYHUZjD/azc8H9y2sZEVB/QlbfJbxaLYsGPc6b3?=
 =?us-ascii?Q?qrDHaWG1KuHPzERiwiT6PYYclTit715hYM5kauJJ6H1VLOeAvDkdDbZO0Pk0?=
 =?us-ascii?Q?NIAXmJKp5gfz6VvQtpknzRvmqBzTMhS9q2icImTacS5LoFPG2BYQUe892Ptj?=
 =?us-ascii?Q?RqZitNr+p3R9URqMKnyaAkHnog0olGO4wfryQ/6+MOKNiDBTdTC+DdgxXKlf?=
 =?us-ascii?Q?PGZGdId5gAvY9wZv9zn+rcNJxzHi6dpIJgo6cvU0WYY73YyQJskwD1jIcfff?=
 =?us-ascii?Q?Oj7FofLo+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20ac907-ba8e-4a5e-0fa6-08de94745436
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:07:28.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2MHNuiZzjMuHcP3HgUMbmtw/kqnghjcE8r/Pe73PU+J909WbFZsW7JhUHwG/6tRFDPIOxXnC8Lzmk7jA04elQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-275877-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: E43953AAAC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 05:03:24PM -0700, Xiang Mei wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
>  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to [1, 7] in the
>    netlink policy so userspace cannot set an invalid value.
> 
>  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>    not yet been configured (defaults to 0 from kzalloc).
> 
> Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")

Nit: Doesn't matter in practice, but let's blame commit 2be665c3940d
("bridge: cfm: Netlink SET configuration Interface.") instead as I don't
think this bug could be triggered before exposing the netlink API.

> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: Move validation out of the datapath and into configuration
> 
>  net/bridge/br_cfm.c         | 6 ++++++
>  net/bridge/br_cfm_netlink.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 118c7ea48c35..dea56fffa1c1 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
>  		goto save;
>  	}
>  
> +	if (!interval_to_us(mep->cc_config.exp_interval)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid CCM interval");
> +		return -EINVAL;
> +	}
> +
>  	/* Start delayed work to transmit CCM frames. It is done with zero delay
>  	 * to send first frame immediately
>  	 */
> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 2faab44652e7..1bb33c8f587b 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c
> @@ -34,7 +34,7 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
>  	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
>  	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
>  	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
> -	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
> +	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = NLA_POLICY_RANGE(NLA_U32, 1, 7),

Use BR_CFM_CCM_INTERVAL_3_3_MS and BR_CFM_CCM_INTERVAL_10_MIN instead of
the magic numbers?

The Sashiko review points out that blocking BR_CFM_CCM_INTERVAL_NONE
might break user space, but it seems weird to allow passing a value that
is interpreted the same as an invalid one. Worst case, if someone
complains, we can revert and go back to v1.

>  	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
>  	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
>  };
> -- 
> 2.43.0
> 

