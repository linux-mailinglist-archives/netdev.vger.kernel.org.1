Return-Path: <netdev+bounces-270931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL0XOCxLwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:28:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827EA3049C6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A4FA303E7D0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B63CBE79;
	Tue, 24 Mar 2026 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtPXEdwN"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008223CAE85;
	Tue, 24 Mar 2026 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340548; cv=fail; b=S2AM5BByvoh2Gk8qmDtRoN/lVWEf7SRI+BUtIih1M1fWOhDvaTVfgoJyV7ygr4zV0BlqEbIkch4liwkNEXIcKDLBdSiXdU8xmGoVzfPoaWQwTy7XrNLVZUq6OiyE3L3toQciEoHBteRiD74p3IRV2JpNtpPyzlaM7timlBqsFpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340548; c=relaxed/simple;
	bh=BnKPzI3XvI+AxHOyw8NASDRtUjQQkq/6yTwi+1WrUTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1PqzPQzGLg2X2WGMvtzoPLK5oUm0S1lbtlFFLzowGnIweuIzDc+bTzLeqHJmcGec8PgEz6rLMhs5Oqm0tXxc5PXV3vznP15Xd/aigpe4Cn9w1Em1lqqPG0AgwX4pAH5E3ayUuH57Yu4aik9OT/HKpOjb5gGQsfW6SdhogwZlvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtPXEdwN; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6xVgCHgtLNJjtclsuF9qI+fI8rdrFdZ1rnqc6D1SBEfMT5ZcMEkIRFbO7RdGyibTQN/Haja2KezqYK8+gUxulqNKre+sdhXyHKh8jgDn/MBgQSjLfevIAAt4sd3DsgHWGpXKwdMuP3iANsNIfZy1S3FuNOIT/pOloIQ2c509ojted2jU79o9xaE56mlLPrmS3lVwdoYaer9riufKTuPPCYVLUIQ1keDdEGF+Bv1qgT4tScpXtNdJGUy7idiwet8GeL94KSAw6jLokFkXvDBNMssc4UsQ9uRKEGv0XT7L5Rqn8uyn+FZshq9SakNOCCUWapYQSkfw8dxwZiqKmN0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZgO+Ho/ECe4afbkKxve4ETzkhrW1pQZb+Fg0dRsWwc=;
 b=FW4pIDbsMceGETqAhqdHc5DTOkwDb4GQSfszTMswEbrNj1JY6CV9MI7jkJoHbq5KGnWbBhPYeASF+PPcfTFfx5ThrkC9aY7e9jFE5rXCyFkv9O4Tc/U56P6p+ZyODcHmdOjVhS2xpTX0PhRqZX9p8VSYxbbpwMVTKIqfO7HK94NpgTPmMwrzE33SQn9FNsUt4R1YTp1zjEdBC+0jtj8x+eUbOy1s0DnH8xROY+578afjeyPBEzdxAUBStkwrV/vcWFMNfD7oqSbBbyyptGwyVAcdCiFcL/sabHiPtuIRPY622rofQbnMY6bVpnq2+q8bZsB8axHw4jaUy/bFQGCDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZgO+Ho/ECe4afbkKxve4ETzkhrW1pQZb+Fg0dRsWwc=;
 b=PtPXEdwNWGccIcJ+acxdxliUqy9o5SSCTElYxsbYGoJNiGwv3K1jXcfWx60RU9GL4AwrqBNmasNj88KFMNHgEHVwAjYfTloonqFkt9m56K+LNh26SGkmQMuAEw/r4ajdZLST3CdME/+FDuL1pVGoAwcYqLsgVTOw5Lapqv5lYnPRkXqpLnl/+FnADsWChT7jDfUZD6lxpNBPP9pew89pLaINwtDNvaxsr7xpoaGGcfKIwNSO6VCGXzxRYDucJ1CbOMaAfe5FGO20zOz5I9CK2o2HQt1uIVCRySH3wKln95okstpD75gL63sU4xJbHQae2B8wlxzOyeU5dF8wGDMhmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 08:22:19 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 08:22:18 +0000
Date: Tue, 24 Mar 2026 10:22:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org,
	Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11 net-next v4] ipv6: prepare headers for ipv6_stub
 removal
Message-ID: <20260324082209.GA365237@shredder>
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260320185649.5411-6-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320185649.5411-6-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 739f7f8d-df1a-4b29-fdf1-08de897e76a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	N5od/ejPCvjZu+ZJ3ehrpq51qY9X3NUzPXI8oWmjjfIKF60jHCmanmYNLXOIUkILuEicfjrErd/ZpAO9X1n063n/dsbkEAxyb5vqzXpOiJm5ClbKSjLmiZzAO79s2ulV/E4M9WdirgyLSiMNk40fsDwqHfkDTJKLGdj1XbHAhH6B8TU3vzoNUPvL99pEnNMGLXnJxW3N0444/7y6gpGkOFyg1F1VdzMrStyTl0qEqgL7GPce7pMyhqlQ0NcsnvNh2Fr8zOv65pp6tNbd5GbTWywtpFPRG3bgx4Psg7DcUDU8VyVa+YyAfg40Q4b3hNEGRcCoIgervOWV1poFQte+r/4ZBfu4rtubA3plauf6pGsdMkIQ9x+ns+VRN/RIuHCIv8pC6n7T2EJWZs25g6yp/PLvXRRXodot+YkFdIt6rJsO5W4GbO/eJ01NI5YFgymjh8jXQ36wOR7zTNDxkWm2iDF11IkCDsSPaUUErGdCs5MCiY/D1NfpMjlB95MHCiLuG8607acn7frcburfqHEeIyRwmsc+6rlP/RZgDQrvpV9xgwQx+vfJBkt3ziNng7UTi9t37c4TLw3qzx5UyYBUZIJcYRgYLQkWRo5ita+5IpaIJYkqLmq3mu9Ix2zenX1e92lTQoPiWH/xxfKe7zWfwsSVB3QxUH7B3JxLMc2PyUftG4WcuO9GnhgBFrr+1efCN2uzq4TMVAR3OixgPz/us/ITzGwBcPhDrLxdwsqAz4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZF0aeSex/cwPnhmzdlZjG4S13j3xTjeX99ko62G840TXozh5TRHYPVx54IT+?=
 =?us-ascii?Q?pbDSOHmzwYE+cuAFP4cKi5dePf34VeF5xeb+dkeDAYg6ooT3k3euwPdQmOiy?=
 =?us-ascii?Q?blfy3IX0SmbXAX7ol/tP4GPoigSf8htJKWZjpZ5dSfxJ8h3bUubQKehm0SGw?=
 =?us-ascii?Q?xuvT/gLio19EdMiO0LhyRzAj39cbh74kvGP7YtrCBCBjQ21xkCfdST62FCyN?=
 =?us-ascii?Q?C3ybJ06UQ4X+mzdChKtfQfPagwe+rmtXfxCzNW5bI+wYq29zDuchaIINacdA?=
 =?us-ascii?Q?9nsXFyqzfz6uFSb3O5ZUWuaQ9+Dzp5XlfbESNFQmi60lo39SWAgJhrgk4CMv?=
 =?us-ascii?Q?5z1klLn19IASwwWIYmj6BQ98FnLRJdClSQuLK0JF1l3+nDTIeTe5IouOSM/o?=
 =?us-ascii?Q?+yVVWQzfANBFOl2L84vDiwrfN+LSuEsueAGmz6SII4ba7gteAYLRlvtdAsAP?=
 =?us-ascii?Q?zceElvQEj9l1RHXVk69vBe6SFXU0WHF0JQ5X/O52UWBpfR27Psq1rYqXTkt3?=
 =?us-ascii?Q?+s2DG3/twCO+aBKRxAV3tlATflAxoIaqbarKrZQmEwrIdeWFyZJ32ZDUf7BI?=
 =?us-ascii?Q?d2Jjjb8hIYQeEIHBZEia+GbvLICEYRLf+2UDbvaAzbpFTgDieT3ZMWOPGEf4?=
 =?us-ascii?Q?N/kkpAHwIOL/yzjy7tSWoXk4Lx4aQiSIaL6ZwWmWkKs7+JqnAm1q4DtRnCVa?=
 =?us-ascii?Q?520mXbPz+/FUXFTc1ThpFnDCHF8TZEqMcyxu79Q/N8cbgQwCb70xDji9pjZv?=
 =?us-ascii?Q?jAjx1oV/N39uJ66xdd4SDM4PKwXOskTK5hVf0aLv9/hQrcIrINP5+eU6IXRX?=
 =?us-ascii?Q?Wubw4H/0l9AqEjwkd4ryh54RyGBjq1P2mT7O9+YYoMa46SZu2Q31qM32drud?=
 =?us-ascii?Q?G8Z2HbPEXk8dOor3kznkSYsOhuvdK6LiNYKIIvuya+rXXEnt/AN8cL18M+7c?=
 =?us-ascii?Q?vWXilLA8j+yrJwWadJG8i7T6MZkP1bpbvWu6FuYZ9FLcLL/o5B4cvgivOPzU?=
 =?us-ascii?Q?w/pz2ydfxwRiouCjm2swbHXJDgIdURwzwDPHhhp92aPvJE1dBwO/re3X2NTB?=
 =?us-ascii?Q?1fl4OQrnhNvi7VuBALrYpOSz46g8CbBdyCwsWGO7Ol0WX2JGn1uvyC8NCXUn?=
 =?us-ascii?Q?hIa3GMhwsJy8HYm74aNeyWQ1r/CnDFH+kXPKtH3PcBoJ0E1ry/WtrlDIR1I7?=
 =?us-ascii?Q?IYxnzNxEk3O2dHPj7+palbaXRKjZZnVKpTmJgwp8x1KVH46JxhBhhcMY08+Q?=
 =?us-ascii?Q?4qd2y8rFAioERfROrDtirvApjr24eGlxjun9BT+1vQMAnaEKh5HEbagwvJpY?=
 =?us-ascii?Q?Ui7O0RoCTI3mPVePhHcFsVc6yyOsQE0keISyG9BcUpkk/uIIiAkU3FUsQ2NG?=
 =?us-ascii?Q?pfbMXWFGcaBglKCHSoytpPkVfS6LiNDgaGcjbqhLZuBp1fRvXGrFjXj0vvXo?=
 =?us-ascii?Q?2dq7yacsg8z4pGCxmfKoqe5EbA1dXQAyoQErmrMJLhgxiUBeWAnbChMvLB+L?=
 =?us-ascii?Q?/PMwVUJ3mkAqbe5UoD9mewV3d2XNM3ui+4BaijS+IFuNi54f/sxA573Knsrj?=
 =?us-ascii?Q?/IEeAcn3uEni8epc/1PdcH4xMbDGv3nfp3WbdPxLXvL0PjIoUgx8vXIAMi3B?=
 =?us-ascii?Q?CY38GQGeohWLTHGTgYZ2Y+PMpFAwcUDEkdwc9ySvHsKb5DbionaWh2+Q/i0G?=
 =?us-ascii?Q?fjmXhD5gqKycUFlK6fmedbrepFnEtOwMv4ybhOuJNjJqi7lTkflEN1R8X6y/?=
 =?us-ascii?Q?0ID1bEiMCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f7f8d-df1a-4b29-fdf1-08de897e76a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:22:18.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOsQiwdR2fClLYR8AVYXsniRE7GDu6A+NF+HFY53chveCKcx0XPpnm8Nc/wuV80e0LbLHAlYjHR9U0h7c4C+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270931-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 827EA3049C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:55:57PM +0100, Fernando Fernandez Mancera wrote:
> +#if IS_ENABLED(CONFIG_IPV6)
>  int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  		 int (*output)(struct net *, struct sock *, struct sk_buff *));
> +#else
> +static inline int ip6_fragment(struct net *net, struct sock *sk,
> +			       struct sk_buff *skb,
> +			       int (*output)(struct net *, struct sock *,
> +					     struct sk_buff *))
> +{
> +	kfree_skb(skb);
> +	return -EAFNOSUPPORT;
> +}
> +#endif

[...]

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8e2a6b28cea7..79f7ee93ceff 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -873,6 +873,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	__be32 frag_id;
>  	u8 *prevhdr, nexthdr = 0;
>  
> +	if (!ipv6_mod_enabled())
> +		return -EAFNOSUPPORT;

Free the skb?

>  	err = ip6_find_1stfragopt(skb, &prevhdr);
>  	if (err < 0)
>  		goto fail;
> @@ -1045,6 +1047,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	kfree_skb(skb);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(ip6_fragment);

