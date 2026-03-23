Return-Path: <netdev+bounces-270718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA9DONufwWmFUAQAu9opvQ
	(envelope-from <netdev+bounces-270718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:17:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B632FD17C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25E33053BBD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE43DCD89;
	Mon, 23 Mar 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baAHzyU0"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D583DD51E;
	Mon, 23 Mar 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296705; cv=fail; b=NrpJvsrdRRXDg3MX2tHWqOCq3UpnGBSVyQgI3wxFxDQnyxG34ZzAKR9siSmaCf7qajccczduSmHB9ilBu+8NUfKmdUTdzbicU7zQuIaRUVx4DnDW0IAP86kgh3YlUoOPI49lXGH1l0DtBn1QkmVLgxKoerFfOpW8+rSNGGGAeF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296705; c=relaxed/simple;
	bh=0L+fCgDIxky0hKlzTP26N2sz3r06gIB1gjsSC30LEOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5aZ9OxqCKt/n5BrBmsGjpSQAuNv9mL1iNPjhv2qmsfugCTpxQRsnvRIJ3gwSISamaI/EIBiT3yvDWZgSFE6MUzG1pxMrQEA5NF04dWwA/FDDhXU48l4yCIO2fJYsPa5t3FzJFAB/l04JovHLlUCSY6xaink+HnS3kRe9zN9ACQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baAHzyU0; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2Xw3Rj/bXTlIsB1XhXFq7eYl+k0tFs/SG8TqLQzrt0OVwx0R37ZG3+4rU/K9pi589GaB5hD5t8+H6dAVv8yaplnNPy0GmSitOzdtv/5+oVxNPSBuk8Dn1jg3j/hcri9MwK8OZ1zgW52VKccAluGYS5s+p+PGeYP+b/TXoMt6iE2duB+QnVxQfE+mhA7QLGL0R/oqBdV1Ku/oR34hgszK+NLVbKyJcV5Jg9sG26BVuf7loAYCGsyz4D6PhGjtr1AnLjejKHyEfc1YpD2rCi0eqe7O/q5RH2PgcxuZiUcv2vSIPT3uYr/6NQCZUqgc3cIidDspOO8HVfYWGCwADUGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny9vha+WQDDIYUv3UdZhXg6X0n2f7BGf6Kp3ieXVlfM=;
 b=g5qjeDalJP7sD6WK1RbV9dbF0dhz99PyZIdBEvWT+6sp8VZ5JklcFRdLk7sTRZch1jw1/MTXM14NNSliKbyMr8F4xcX7OFA/f9p0h3Afbqw9lxYmibcZKAHeT+tXLHQ0MUiu0Hes03wBZmFBkCsEsCy7wQ7+o6s9hq7x2YNdHH4aV5lzmqHJIwW6ODEIKuH7pvmbOvqyRgM3hIIjOkRHEcUuv7LjNTxtFDccKjHdfwbsUCbGzvQdf0g2PfvcMs2g/b314VUEkd/OkMMT7TlvtCCePiPfSHzgVDmxjzwK+aicp9SyW1TlvYZuugV48Q07MABtPQdK0aoxJknDf8bzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny9vha+WQDDIYUv3UdZhXg6X0n2f7BGf6Kp3ieXVlfM=;
 b=baAHzyU0rAYoWbAWFaVERKu1E5vhgxHkmsWNfBieENZuZPW7YSTCQCk7TSL9r9N2yzBOeUOr5dM0rmiI8KHIADIKyZEWpLpuPCroPyoaoPETWcNtmSqcvOgXD1Bk2+Yf/wARya8JDmRMUgYWvKq1YKjVPIZH7FrIguOb79s2FOeCzeEyf3U6jiNdgMi0wu9pLDezKeinlk9er0zOJ3LYWaTwjuOeDv2reiT5pF9rUZJNBXq8icYvPXg5EafV/Djx2kzRLBhgLiKns+gtpIK7eTkx1Q54sqEVsMYaCfr7COQMtLOkGBh3KRR5Bx2IX1mg64Qan37db/mJF8qmCjbW2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 23 Mar
 2026 20:11:37 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 20:11:34 +0000
Date: Mon, 23 Mar 2026 22:11:25 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org,
	Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/11 net-next v4] ipv6: replace IS_BUILTIN(CONFIG_IPV6)
 with IS_ENABLED(CONFIG_IPV6)
Message-ID: <20260323201125.GA335123@shredder>
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260320185649.5411-4-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320185649.5411-4-fmancera@suse.de>
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c817134-c3dc-4445-ebeb-08de891861c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	H73Qx+kJhoVYHnM2HrpMMGwvorzua7XcD7EM/LWOsgMq/1ppThEH5NTV7h0jGDQtW19Nm8prCSAiFQP8p+kq75O6ptz1MxwhHtQ1Y0t1tCTDg1UWpfHlaLyUwXJhzaWYBa0O3SZQQMRa8FleDzL4m2CcR3wO9YUYnA990JbS3wRmuX53il0U8ZApOb8bjgyomHAxJyziTzMnNAcX5NUPmK9kbwiZCrF1n+wuB5dxLjsxqoEgoc7eEpYRyo/QM/BB/hA0K7FOqgSMwf3VZh19X8lP+L/c1d/FMxFL30xbday00cTA4iK02RQAxsQuadMruRMiELW/sDSnFceANAvB9FfBrBzlKxEiwZRcuCv87niipiJHrW/gzXUVD7eoSZsiCnxX9hGWmvW+9q0txdyvr5meyStrN68aHUKLuKI9QdwejjVyNva/pZTrwD58PgdqNW6SiJc4eFC+pUxEnA2pNxslUnwLIGQkvz0SdVjGfQTllcEkxq85AtIxIrg4LF7oEvIp7SxvwQxWTfH3qNfK1pIZy/t3Zb6mdjmkMNSzBH/dyha1LpYUe6zs4ZH1OF8lT3Jnx6NpAcjrFWvbGiTx5yvYrdx49JDVtppLxA+kFD1M60I8JsCxDy7jrv/rYt/fje88f4NhlHLFExqKZfLuINGw1ggRgSdqjxQ0exEqTACXG77KFTSDo5d6dEtN/RW+bmXaI2rmY+Tq7JQ+HIECnLzIEh3nh88nSLKOk1G3o7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crp84cbe5Pe/Ru2Wrq3h1KEG7jX820v0xTf+7a9Rtl3jxkT5GA3DSSP0z7/x?=
 =?us-ascii?Q?8chqMowWrmmS84o0UgzaXsEUL7f7+SLExFk2ynalAABkaR1+DqmZcaAhwFZB?=
 =?us-ascii?Q?4GObpbA6+NcypwJIgC39zffG/qzqVYzR9V4RDJfwPTcy+2nbIkhRS6xnLP+r?=
 =?us-ascii?Q?kM04Ocy+H5je1+UZWhU3fPULEz2YMuTnOEqFtFYwTNzvbU5jAIwYCE30eyfQ?=
 =?us-ascii?Q?2qcMG6cOYV/HG6XC+zqvfzxVX6Kn5I844mZmokYteeEOk7GafTb7+58QKEA5?=
 =?us-ascii?Q?DUYxriQ7AQFYw3udPH+T3dLjSITwZDycxtmPO0nBiR6ucr1tWrRQYYyBA7pq?=
 =?us-ascii?Q?7tGUROZXxH7vktX3DJ/vqBIKE1ixDIsgnqqqphJlMZNdPPPH00GoLwoQCq+z?=
 =?us-ascii?Q?JvpNzUuAKcAFBo4LMaFWIRgiADQmmHW9FhXndDQx8VJMfn4LV12uLcvSF/Sy?=
 =?us-ascii?Q?v7/XTYVv0hvGYLN+P3Zp+107Aw6fTPKcDU2hIraeCuvMv6ViT4FVyACqd+0h?=
 =?us-ascii?Q?ZYBjqbYycsTiBcnrdcDdBi6L8i/SZxCL5eZJa9aJN2fSPr/0LQYgqkfq2mrL?=
 =?us-ascii?Q?wxF4wR2Pz1o3hnlbu714PvhCbpmi8n1SaFinDo9fSkFSXbvLeCSMsbHh1R14?=
 =?us-ascii?Q?pOQeWWtVhIfMFEcwTOwSC8sUa6/Qghe7+qHRNv17jcMclOEIM0061oM9+A/Q?=
 =?us-ascii?Q?6QDMSNIfIXZxLh1tb6kiihoEf0xtLa8wac0aUCYfGc5yRo07c9bcklRcU2RP?=
 =?us-ascii?Q?k28BYTZ16juxt6sQdkhAb+7A5gNVrBte7QSDL7XPS329bVkF1mLN2l1uvbOj?=
 =?us-ascii?Q?idp0jdmK5k+M9HZTrsfMjcaY25K3jKySfexdqDGEqN3snxCVgSi9/zsSlg8r?=
 =?us-ascii?Q?dRbXa6H+XAyrSq2qTe37cjJ53Y5utqTCL5zG8k4rTT7RMfh1YgCvyXu/fQsd?=
 =?us-ascii?Q?jjY/M9jSvhchwXHOqi6D3TW6FQdbjX0Meu6o68jcfhKjGtKFBgKLKnRJ6aoA?=
 =?us-ascii?Q?kGdBMr1K7vixJ6HbTdcC6Zdvky3tiQbm4hLjDxJZnuBqoJOn1OSCE0J+z/VY?=
 =?us-ascii?Q?WNUo8ldsSgRNttUcTcuu1//1Me8kh49fwPTOrkzlrfhzVbt3tU3bX0yS7WTC?=
 =?us-ascii?Q?2P0WPP5PxBOEAy9azEUOCTXDwkoC1Jx7HG1ILqEOBgFz46ytWflIAt+ooCV0?=
 =?us-ascii?Q?tlVhFH4Rt73lfL015pup5zves1p4+JpTK8ogXEdw+45eSwtnIfi570YZ2o8q?=
 =?us-ascii?Q?qW3dcTtcQSFRhtZyKzUXLQEpuML+v8eReoHXcnkyL72cJqTTJ3dxzYdJ9hw/?=
 =?us-ascii?Q?4jKY4zbMoplqcL2nxI3svKzi59InCwJxa+5xFc6/XTK+J1yyzmtCrIWubZk1?=
 =?us-ascii?Q?xrTxreGxUfvvtm3fFRlxzyjlx5fZj4wJ+uEM5sM6QpHFL/WkGSchISDWWISK?=
 =?us-ascii?Q?n5OTbW/cNsk43pc9K1DBkvqMaIlCSkzx9JloxvRenOujAessOhkSgbtBXMvV?=
 =?us-ascii?Q?PbzaZEwGOnQ25iEmZlxJ26rHgSUV1+0hFWtjLQLgVwXIUPOCkuN4b15jkNWq?=
 =?us-ascii?Q?t5X7tlOBRdUkFPTlNCoNO/ELSslHrML8Ubg7nKa11759qHFRyz1kYlqxlG0d?=
 =?us-ascii?Q?nGcaJvDBS2cuUG2cjvPbpD5IkF1lar/sgRpbUW0YqbxCXVb2w0AhVvQwTOZa?=
 =?us-ascii?Q?w5RwzRrK082SgzXLveo2wYycUvRy9xbpT8r+thRsbbYN3ZD3vmDZNn2Wk6qs?=
 =?us-ascii?Q?DK9IzrNV0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c817134-c3dc-4445-ebeb-08de891861c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:11:34.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCXUE4FSiCQ/zfNPT8AvDg4GQzcCrGPCnhxs7sFVmSV531J6J1BLCXCi/3lotzSD6Ixfbspc/FkIj6L6h1W8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270718-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 50B632FD17C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:55:55PM +0100, Fernando Fernandez Mancera wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 08cd86f49bf9..c442ac275f58 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6826,7 +6826,7 @@ void __init ip6_route_init_special_entries(void)
>    #endif
>  }
>  
> -#if IS_BUILTIN(CONFIG_IPV6)
> +#if IS_ENABLED(CONFIG_IPV6)

Can't this be removed?

>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
>  DEFINE_BPF_ITER_FUNC(ipv6_route, struct bpf_iter_meta *meta, struct fib6_info *rt)
>  
> @@ -6921,7 +6921,7 @@ int __init ip6_route_init(void)
>  	if (ret)
>  		goto out_register_late_subsys;
>  
> -#if IS_BUILTIN(CONFIG_IPV6)
> +#if IS_ENABLED(CONFIG_IPV6)

Same question.

I will try to go over the rest of the patches tomorrow morning.

>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
>  	ret = bpf_iter_register();
>  	if (ret)
> @@ -6961,10 +6961,8 @@ int __init ip6_route_init(void)
>  
>  void ip6_route_cleanup(void)
>  {
> -#if IS_BUILTIN(CONFIG_IPV6)
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
>  	bpf_iter_unregister();
> -#endif
>  #endif
>  	unregister_netdevice_notifier(&ip6_route_dev_notifier);
>  	unregister_pernet_subsys(&ip6_route_net_late_ops);
> -- 
> 2.53.0
> 

