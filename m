Return-Path: <netdev+bounces-293815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN2VHjSoHWpbcwkAu9opvQ
	(envelope-from <netdev+bounces-293815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11573621ED4
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F19AE30D1426
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D83DC4D7;
	Mon,  1 Jun 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k3ubLuw5"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC93DBD5B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328059; cv=fail; b=ME0sJmM+V6JTgxvDAA1U7VamOUv5wZKffez+rMwS3a9XW8m3CC2ZBr6QNZMODWW/4quj+QsJiSh8fjFlQUPxRIpRJeYot3s23b1t/juSjjnVLWQG5oTfVRs4s2IeGPEQk+YxNDC7JrNWSGrG2HbJ5kal6/muLDCn+E/YAV/gpOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328059; c=relaxed/simple;
	bh=Di3q57ahYJdO+0e0E6C/KCB4PoyqxbK9XNPbN/eEuAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rFcgJBrq4PjEEoeRGTWws+3gDZ1ZZBdDkz9KCzK+2vYh5/4Vp9H2NgiT3jotzUxY+Z3NOvJI5j93ikQ1/LvWN9WVEpuJZXXGuaCex6D6BnX8gUF0jXziW4tKsXM5BNRaFzDQiQT4y58hI3tMRH1/6YFjytYz1nnejCvsQEa1Owo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k3ubLuw5; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjmTdhWmu4edXy0nZgiB1gFEOmQA4xvcliGiAkEgP7K9AsFIY8MC6UmPBONIOJmiSJs+X0BRrwwBIHnOBIa0ZSo2x+5A5dE4+xPxV+PWXEdDWjXHHwZFafyMUiH8IFq54j/wECvdSgEz5TKn09YGJlGb2IzbVyy6SbiEl8sgeZWFAXt4XHLqri0FoZgsezHM/82xIF1n8UIWZFaaUr81GrYo8keoGUYnkgDONSNN54szwAH/6gc1tWTQeI/x8KubzIpZhmcwcV2mnP2NpocVoptLN9CD6Zt5oWy/OJgj9uUxQjnEaPsARhPN9Kw5MDLGPVVxy7y+IoUNGRe/nE/EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvnp/ZGFO4ZVcJqb9YDhbmDQ83AE7PHAnus8cdTe7e8=;
 b=AK+/gknEQ0Hq3CwgFxB0OILN2sc0vZ8ou9nUp9jcxUWUKjHE6fuEJO2Nu+1lkzX0VTfKhDNlfUJUAA+dmXoNE25xjvqN/fqYIkMQFHqs/2ZVyengc4SKMhWh3P/7IZVtM9m8FpdaPK5dk1PTDFCxPRC8eGCa4nDujmGlUXPHMShdG6YcIcXcfXxIHHhifdIY8SaZDOICq5ycdsAFUplG6XyKiIIRCSqowL6JRmH8eg7GhaCYo/iq/57HuVlRxIWUrVMqvxF9fgqVAxWCox3L0SAb4Lj6tEH7GXOCzYTf9rjMpT3VDvTQ/djcQAqhDL8x2IPzXkAl+ip5J35zli5cMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvnp/ZGFO4ZVcJqb9YDhbmDQ83AE7PHAnus8cdTe7e8=;
 b=k3ubLuw5es42xgju6RGKIiIgyXZm0sZGcqsRw40FjQgRI5HzX4DzyUCtn13otpjV+Ibin0JlrtDK+iPj62pHXhCIornHHEISU1X0ERd07ev8yxlUO02rn0I6F50Gjkj4MBnPiRfFuO1c+GY/0A1g4UZGbXGouEOUn3iN5mGUEjEVNWNM/5wrLHbD+4u6mFNHMa2JuWYTQPJ1j20vMmIHZ3PzbcoAn4/0IW6oSnvEK1/iJrAGkQ3yYL1taHbTXH7gwrkzmdsLCQO3iNEuutwCug5+13CMtN+qtWFpuqM3eSaWZlcCrm5lV5tDAEl+sV3o5l3cTub1oPpUcaOfspQLeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 15:34:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 15:34:11 +0000
Date: Mon, 1 Jun 2026 18:34:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Tamir Shahar <tamirthesis@gmail.com>,
	Amit Klein <aksecurity@gmail.com>
Subject: Re: [PATCH net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
Message-ID: <20260601153401.GA391068@shredder>
References: <20260601124157.699463-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601124157.699463-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a236ab4-b204-484e-d3b2-08debff33a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|3023799007|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	MMbiUrwS1E400+a4lYWYapZBX/i5P8Od2oq6MgvWIbC6LPRmg8Zvpmnq5Zc+tgXHTFmd7TuMYCKY2RIs0xksDfF9AnGu2xkjfu9H6L+BePa5AuNUPrKPS/+sB7WCJ8tpXTCeh5paeHM4VRwbQqhfx56Szf12hrP0wWdpwv+b9pfceqHkh1jdFGklL7J6ooh7C5AxJtFVGOIydn99gQBo8LaF74kQbuGXxwf1Lvf8lkfiNcoFEGTVR+xskhNHr3HgaOJ5i1RtD2gy0cq9DGykl7NZXKAiBFHh3OfKYWfUDqgJg9+ctA/CghAuHJ0AROK+mOrultxJB3IujT7khux3fFR2ariLcKQmZ6442P/wysC2+Yeh4cD8HuwZTmCdE9j62H0twg+Sbqz5NRqQ9QWm7twi9doEZEjy6+iskSc6DOZImG60uayv86jk9pFFUOFqzqdrMvyTQnKVXUNDF6pqPkI5tVbffQVo/yfl6Do3vEUT/7qlM97YKH8lV+4J/siAdZak0r06Gp8tcqjpy12NfdaL4V8pi9yzh0wf3FtnkpukZGcaWo4T3hEWOvB7Bt4nQzMSeruQYlRT+yASkmxjfSgwey72z58nYu6mK1JywSVUHOR1JOK7pr4hOGYQEMqJAolGVZE23whnVM/Cgdt5sIZsGnU722hdv9cAIegsA7IOn2JktPv1QAQZma5qGy2aPiek23QVMlNQGpItn+sMDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIoKgQC2bq0kaZzZAo4Wg/h4lZhrFbAcbXZchNa9TFvwGO+/wZ/cnthiRUoA?=
 =?us-ascii?Q?uFixeaentpxq4aBcJoMScJtOjw7F6gGfcsIGz2kO0x9oFUG9dPFFvvYWbWqT?=
 =?us-ascii?Q?7zdom/MIbBSFrmu3wzaXwCOeqEgbh/yhsOMqwD5ZcexsLPySx/iBIO+Kd9m7?=
 =?us-ascii?Q?DJjXJBZMZCkjSjJkfYwI8+bKa5G2cgFKRhV4R43hi3E3RKtaaFBqZnquJSzw?=
 =?us-ascii?Q?Ox5BtJA+cCSJrlDnOE9OJxe07p0tab6UFCD2vparMYCCmI6f04AjKmFGWmZH?=
 =?us-ascii?Q?W2OSdU17O29sv7DApf+xYybgzMUVqxRTZVioVtc6nyL1qeo5p8FuGUUmAwYF?=
 =?us-ascii?Q?yq8u77kmZeZXY/uXSguKeraB3WlsN5SfgP4bZZxtFh5EzMwdjBRFYHwJmHce?=
 =?us-ascii?Q?iK7lQcZsmjftvDmo6+hum7oL7O1hWApqKiY/XfRo6BroawlTUB9cWcIe+3QP?=
 =?us-ascii?Q?jQ10nNhElmeGVeM3+vDaxWWzHCQPOHN+EpI6Ti0gimBEq6XzRwdoNn+P0K7V?=
 =?us-ascii?Q?lv2pRZ+z+NqoiytCb78QbIWEK7TgfqHFO9xf11Vgtdtjwt7B81WQsQWhsTyr?=
 =?us-ascii?Q?XS8xLf0BEKP96n4ts44aNeskdXuD0PWzHCKlcOBQJ1zEFn9RN8eMrQPKm4wh?=
 =?us-ascii?Q?zGDoQC4B3n4hwwKSYm9Kg4XqzsTyWiLP22Jbt9PUhKx6MO/Dc/r1wZ0w5SYo?=
 =?us-ascii?Q?eBJE7OmEtuAvyGvzWYTsgp5YmfhXHaUdf08w9E3z5OvPR535RC3HHyzpWLSh?=
 =?us-ascii?Q?KZciXCQmJ3uQj1yP5a30tSPRl6Uy/6mFDe+qRYbVQlIAIPspqrYUsuFBOmwp?=
 =?us-ascii?Q?C2++AOmQPtnvIJMZarxQjk67vSqE19MyPtPjuV9hoGnfdXH/hYMqZZe1eV7C?=
 =?us-ascii?Q?owcjyDZ3LAoOszHNg8fd/Ajb96COJoUpWhY6zIQNCDP3nyv9SwN2Ohkq+ik1?=
 =?us-ascii?Q?QRjOpmHsfE3rY6acPKH6PoqJiECkJxlvHHYDuWQNrb/Hmg0uy9c+hcVD+iN5?=
 =?us-ascii?Q?ZmlzVWebjgmd7YcVWn9NoDuN+A7HnooFMLSY/C4YppO1SJ4OzINbeTOs7Hhr?=
 =?us-ascii?Q?iY8X+x3Ffn+kBVX5f2ng8cl8OX8Y+T9heDNs5gyAwzzNTL2yDyaiuB6CSKW3?=
 =?us-ascii?Q?oStAm1y5b1tpUOzdfJs4M3HScBPw97UbcbP/ak/DAzzLxaRMypN/IdegCMaK?=
 =?us-ascii?Q?jiNdNMr6xGExsvXKUa2JtE6OJkJoSkAyZUaC6K7+fUOXTvOP+MI2Neo3Ihg1?=
 =?us-ascii?Q?ntIci1PcpjkKyDiI2R1jItIbJjY5xQNc0qT1e8W6LPf4WiLhSEwzklStr5qu?=
 =?us-ascii?Q?blyntqW5qawhNOisMW6rpVxsN351MsC0lp9hKnaeN7nvrC94X202SjcVOkao?=
 =?us-ascii?Q?p8idbi8vamSpvdPpFCsC2siPD6OSEbCgW//h7VyaDHzLidCwqq+FrM4186CS?=
 =?us-ascii?Q?ghz38IlAzmkc43+k4WMslvhpovDUSZ44qo9zpAnoSCsbPZw/C9Yu5Hbn0xrC?=
 =?us-ascii?Q?/COEMD+FSVpFNSnaImXn4oOt+j+IYTG19rvs8SLnSL4ynu14hPcMAoO9nQXL?=
 =?us-ascii?Q?G9l2PFRcZ4Qt20opQWhdUs/HQD1UzanhHCnwnzNpjjXpXulp/pL0JmoJBzSk?=
 =?us-ascii?Q?km0NBWu+nLbi/N1tB2IfVWUkGEOuKbfBmgvLSxanYEum2r2BCwK8wV/Z21EM?=
 =?us-ascii?Q?glJ1Bf/hUk7dfKUkbYAQUsOecbwtuEgTpBMnTpLBRUUNFu2b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a236ab4-b204-484e-d3b2-08debff33a5d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 15:34:11.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruRg/wIprZA0WPjVoZ14BPHCBP5isBsgtvQANy9VnU9pnAyT656QP+T8AgTd8bTPa0teyfpPY+6j2w/TFm042A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293815-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 11573621ED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 12:41:57PM +0000, Eric Dumazet wrote:
> This patch restricts setting Loose Source and Record Route (LSRR)
> and Strict Source and Record Route (SSRR) IP options to users
> with CAP_NET_RAW capability.
> 
> This prevents unprivileged applications from forcing packets to route
> through attacker-controlled nodes to leak TCP ISN and possibly other
> protocol information.
> 
> While LSRR and SSRR are commonly filtered in many network environments,
> they may still be supported and forwarded along some network paths.
> 
> RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
> IPv4 Options) recommend to drop these options in 4.3 and 4.4.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tamir Shahar <tamirthesis@gmail.com>
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ip_options.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> index be8815ce3ac242372eeae4a97091cda26d40ceb0..ac0d147c4b8cc347839a044adc43897faffd95c8 100644
> --- a/net/ipv4/ip_options.c
> +++ b/net/ipv4/ip_options.c
> @@ -283,6 +283,10 @@ int __ip_options_compile(struct net *net,
>  		switch (*optptr) {
>  		case IPOPT_SSRR:
>  		case IPOPT_LSRR:
> +			if (!skb && !ns_capable(net->user_ns, CAP_NET_RAW)) {
> +				pp_ptr = optptr;
> +				goto error;
> +			}

This might be a problem for netfilter which calls __ip_options_compile()
without an skb from ipv4_find_option().

AFAICT, user space can include IP options either using the IP_OPTIONS
socket options or using the IP_RETOPTS cmsg, but the latter is not
applicable to TCP.

If we put the check in do_ip_setsockopt(), we create a weird situation
for non-TCP sockets: They can't set these IP options using IP_OPTIONS,
but can set them via the IP_RETOPTS cmsg.

So maybe we should just put the check in ip_options_get() which is
called from both paths? Something like:

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac2..09d745112c15 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -530,6 +530,10 @@ int ip_options_get(struct net *net, struct ip_options_rcu **optp,
                kfree(opt);
                return -EINVAL;
        }
+       if (opt->opt.srr && !ns_capable(net->user_ns, CAP_NET_RAW)) {
+               kfree(opt);
+               return -EPERM;
+       }
        kfree(*optp);
        *optp = opt;
        return 0;

