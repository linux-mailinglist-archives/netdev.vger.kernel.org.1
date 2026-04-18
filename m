Return-Path: <netdev+bounces-279512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DLbrNWCj42m4JQEAu9opvQ
	(envelope-from <netdev+bounces-279512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:29:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75215421756
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7660E3008996
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9B2D9EED;
	Sat, 18 Apr 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i75N+bX6"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BA2D7DCF;
	Sat, 18 Apr 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776526171; cv=fail; b=ajKCjwyOc9sHSU+0HfH5vvVQZdeQxZnBQF7DtOaqT2dSZit1KS61vZvpjOq4u3DKqU/4ULIohQjFYIwNCcKqsqdy89PFDL62pcY3x0Xy7MxY+cj0r/Uf8ukFbp139B+CM+TanUz5L3enNAHIq5ZU1QkuB+Q+yS+8FPbS1cR6qVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776526171; c=relaxed/simple;
	bh=H9jtSc4lDLyHmHORC+qAITkg0IWyTlmx1sX4kJO8VzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y42mRm1vnfIFsaAcqXAXi2QsM7Z6o9qB4Nn9aLIS09patpkBQQxDYGTeD23IKK8o1FyoFV91jotZSEc7Uxlm9gp2kiE/8sAtqbA+B4f/VW4puv0b/FSNTU5TDgeHfIO8wL2or6UpO+pYZESb0gSTPZBc3MC0cUKVvn3w/vDtieI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i75N+bX6; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNdWuvEmQ9m2NyZDNlQoIlLvaMJYjo2d0QLuZT96cNeryzsZZtgBee9Z5kSdQsZzAZXTRNPhFwBm1DQuo9RcOJWG7w0EEFAHDHlp+31FjWq4nY+xUSi79KqcVoSfG55XK3JC/6dnE6DnuJa5I100YuB7uuzZzvTKzA1Vw1G93j2dEIuO0KqVbQB4YUMCsBnhQie3FTeWWWXdeLt228WlOUFp6GLtBTlLm8cEVxdr2K2/bKP032IgIrOPtYAac1Dp3McEdFmURkragDiWbSqnVPER8f6T+mLZNJfKjDWs2/n6v8ywfshfSqAOPnDLhhDlzTw0NIO8gc1lVScMEaIf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyw/qnAhxjSzBF9ngLpbrgrj6TcE3ujRjNuzcGv0IRk=;
 b=F+KrylOYngJELrXuWdDjao8tMS8u93HkDyRhxX231ctdAdzxLv5Y/RMt/z55zOixFm5LTDR9VoCHoDE2OZC+mDpYecnLfDY7ROfegel4MzIHshF5xjamyJGRytOG+4XEaUFIFkgzxMG48C2X4pxx57b3dEMwEDpck7ENSF0J6NjSWygfEHZQZfW/ry8jayhqrzr3m61N1DMR8y/cYqV2ghUuijnQ51YkQr95OTWN6gzMHXjol7QU0CMgt3EYtXmV2YDOFQRNb9bpq3S0pOZZcpZ4wi2pdF/6/8lHACBpB4fyuS8S1At1e0Pe6Tv5hZ8LWvZxp+9wxqx7kv52xbAR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyw/qnAhxjSzBF9ngLpbrgrj6TcE3ujRjNuzcGv0IRk=;
 b=i75N+bX6kCfOetVStW0x6+7oL8h5ba6/DDbeWRFkSy5nteJYi+b4dW++RHVz2+7YGNn5kjmAUct3lr4mr8uzWU6vAww5WDvtzotFzAv2Wkb+Nd74ASzFErhxFdBsi7xWe1giOqGjeCYxSMKsB1yhCOyw+LSk8ZHG7rdjibz2HYbyNleUzKF2GeU3nCL6Mok1jlEnxuln8e3ApdjFtbiGKDAOLpjonbS8tKGV1RbPFgFFDYCqDF35Zkrq6RzhneYISV6flNEUp0re1Hs1ib368RTNkLWfi8Yieuxqi2h59oX0xx475eK148esLDO0XBjBXpF6+YcMb0jCP/xWVTNDMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.48; Sat, 18 Apr
 2026 15:29:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.007; Sat, 18 Apr 2026
 15:29:26 +0000
Date: Sat, 18 Apr 2026 18:29:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: igmp: add sysctl option to ignore inbound
 llm_reports
Message-ID: <20260418152916.GA800898@shredder>
References: <20260415-v7-0-topic-igmp-llm-drop-v1-1-1367bfbb898e@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-v7-0-topic-igmp-llm-drop-v1-1-1367bfbb898e@pengutronix.de>
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c355e48-b685-4451-f08f-08de9d5f4672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	klznJ4MIqrHFCuxjHcgUa+orpd9pWussytnGC7IPEsUeRy/1yKoE3v3cyUj8hapc3B1UCjwK6h3tOAqjQznzLSfCAd1dGCwqIKGiVLDUcaIoLL8A647qHrremu8K4cQzsTHQGJZEh2BKj8jCLOQbeBt8tWVlukmNSDDCIA/9ZeLwnAGdpHXmxgkJcZ+t1c4kKISLjbUMb+NyGkPWRzgm/yHAIQp5kIuGqn8e/LDQ92I6BLchej5fXHQOiO+eie0Nejr8lzlNxHDR+kFiCP0w86+BYY9uRUh9KJSKGftwhwHMMkLWjVAUOaW3cThZnMfBRdVkzAawtJ2bgJKA4oee5YL5kriOpJZ072CAD2eawvDn38VYPR67dRXC1gXAAi9b/HafzyKq+gDXDYNgZxG6Ghw2EowHIdPIUunSnKBzAB8D/CzDftAll8UaoKEmg890nsPK6Fc7A+MHkfpdHRbVogVYQ/oSJMslgohPPjluUabnNTLk6mEQdwfAngHUA4sUPED4Fcc4yH2OPb+oUeBKJIa2JLp4j1ATxlkozS4DFc+9Xh5Nu9xeJSvEltcdp6R67l2uvIPhxB2xmakQ0VIBs4fU3Eo6+Dsj4JcA4zoiSdP1V/QeUX/GZrMb7s3V9q6Ll3nRxj/KVrTuQe/6ac+/QtHjZDTIM6zjVffI579jg1J+8ru3XsPCvmVCn4ypDF30iWDbwa8H58husj8Fsj2P3/AMVltXYmORBIR1nMiojRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzRDlPJcv3k+xeVOuNeq6kZtCBicF3SOs85SXqAxeXSCD6Ch6rh+I55w32e9?=
 =?us-ascii?Q?rbuauY+NOkZLodnA5nzjCWyWxx5T50Cdi9r04JZKQfjqJf6CJAAH4gWsUUrK?=
 =?us-ascii?Q?2K6stdUG1oC5LTur8HcaPn0ZTVTgrFCNpLeJQd9/TzySQx3HRajZJe7wZO+A?=
 =?us-ascii?Q?D2iKvC7eMRIstR9IX/lO/Ash8B3b+1pBklZ1yhc2xizloI9ljfF74lG1eaWQ?=
 =?us-ascii?Q?hSI8pKrO2LZj4nuA6cGWgl26cF79Sl99BfFMTJP9TvRnqCwnbv6GcvOpPXL/?=
 =?us-ascii?Q?gDaoxU4GzVs0D45reCg2PJwHNiHCPoaVhziLc8z9d5TCApAB2nxU7XriIPxp?=
 =?us-ascii?Q?5274jbnGaYD+o/qrFu7UeIZnHF/DcHnY0/2u6TmsUeuAeUqp2O1+8/hCLCgZ?=
 =?us-ascii?Q?m8CsEZ0CwcqIbtBosABWEU7PrKZlKtSyEu02w5Gb91hBxTYBzsExNbH+Y8/R?=
 =?us-ascii?Q?q4X5LLA6SXjwLufeZdrVKtcYsi1Jj5TrRRq0KezQI9f4BjB1R4yS+URhP0a6?=
 =?us-ascii?Q?WumJNZlm1LNrJ1FRK1czclDM2ECYfZWidfjZ6JvsnRPVfg37gUNf6DSt2n08?=
 =?us-ascii?Q?MX/9SdlZvEx8YrkMkeHsnI4xu7M9xhG8x37oJ9dHdYqclCrBeO3h9e+jmmIu?=
 =?us-ascii?Q?t9edCfQq4HpH9AYn/QmXaoRfCc0u0e2K1zXbCuLaATIiHlIzmv1cafLIN3Vj?=
 =?us-ascii?Q?86Fh0Fw6qqTJyJo06oKinWGrcwa3G1ETvJVxamE9qG7VJ+AMAbpYybU8KKhB?=
 =?us-ascii?Q?G54jEh51ra6p/ml6XvKLwWv2RyTp1NFPK4LQpBlM4YOj5sDT5UbhDPBe02Dj?=
 =?us-ascii?Q?Fm2/kMJMgnriTD1/28iGC0RrZHcMXxLFefwMQfR4hyjr2YDlW3ELtNF9PsTn?=
 =?us-ascii?Q?vKveHvFbBT4Hq97oDnkbCSMuu0Wps2DnDgkbjunyYF54KJ86dI8Dnf/Gv6uq?=
 =?us-ascii?Q?EGtWQEnf5IWBEqpCMNRVc/AK/h9G6/OvSSG13UYAO1CxicBJVWYqJpUvhb7M?=
 =?us-ascii?Q?9/4zR+EscZxQdKczno0MWEW07YlpgVDuJqKnEDgEtHjhc+oO/a/A5sp3CtKI?=
 =?us-ascii?Q?dE6fRNZ0rgD9oYMahON/CN36onGd6mJ59rld4dfyw1bn+XNhvoXISd8Q77XE?=
 =?us-ascii?Q?WNmH+gsKBiXauqTmxkCqqNvU91Q5zsTU0kOTq7SGcBWEyVjc5rBIrCeeWJgX?=
 =?us-ascii?Q?x0mAPjaZzqNZ0VOATc42OTgr+PIElI3KqVJssEc4iNaWJgaQ/f8FAYljIXRT?=
 =?us-ascii?Q?pBGcfLRkH9Pmdx5UkL0V0K0oznjH+fZWm76Le/N6oYcqOFG25TIrNA/41eEk?=
 =?us-ascii?Q?yqqAruAAREKKOcgksaEnn1ZsJjCvn4OkMfXnAXvGzGDEzjhUFMYWNW3UDx2Y?=
 =?us-ascii?Q?9B5nCHisQluiRV+yIbypPXKaqk2bRrroneHzaZnwWZHgEU0EuNGnFjLWVfH3?=
 =?us-ascii?Q?Kd6q1GD5fdxd6nzisgumKZHq3tluw/G8BIb6HdNmW8iWlBJuepP7Uc5wy/7G?=
 =?us-ascii?Q?poFY5T+De78bgAWCwu8PnwCDq12BZrqMpCyCLoRUgLo9XthpmcT2hr9jRTiz?=
 =?us-ascii?Q?hVemzdjc0dbOl1L945gfsRv6gLV6v/cxPJ3IcaWPH53G7QGu0sC5azQhtX0k?=
 =?us-ascii?Q?axBVEP3Au1hLNtbaqUTlkXwOOdxHi5phHiD9h0qX874/MLPdSMOSRHUfmlKk?=
 =?us-ascii?Q?sfojEtcgmuv3P/d4mj/kWbvAe/O2oBF45bT2VcykUsJbHJmpTWQJUD+8xKwn?=
 =?us-ascii?Q?wDEFlVZ9iw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c355e48-b685-4451-f08f-08de9d5f4672
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 15:29:26.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxUgSn0jQ6s4B1e9PTTYYcwZ7OPSp9TvuBP2ZnwyB4T1HDJhb9+X8Jd3OdkjNsh9nE/RTd9J0A8Ol1wELroZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279512-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 75215421756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:26:13PM +0200, Steffen Trumtrar wrote:
> Add a new sysctl option 'igmp_link_local_mcast_reports_drop' that allows
> dropping inbound IGMP reports for link-local multicast groups in the
> 224.0.0.X range. This can be used to prevent the local system from
> processing IGMP reports for link local multicast groups and therefore
> let the kernel still send the own outbound IGMP reports.

OK, but what is the motivation to keep sending IGMP reports for
link-local multicast groups when the host already received such reports
from other hosts on the network? Why link-local groups are special in
this case?

AFAICT, igmp_heard_report() implements report suppression according to
RFC 2236 and it doesn't mention special behavior for link-local groups:
"If the host receives another host's Report (version 1 or 2) while it
has a timer running, it stops its timer for the specified group and does
not send a Report, in order to suppress duplicate Reports."

Also, I'm not convinced we need a new sysctl (that we will need to keep
forever) for this. It should be possible to drop such packets using tc
(tc-32 / tc-bpf) or netfilter.

[...]

> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 6921d8594b849..2da4cd6ac7202 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2306,6 +2306,18 @@ igmp_link_local_mcast_reports - BOOLEAN
>  
>  	Default TRUE
>  
> +igmp_link_local_mcast_reports_drop - BOOLEAN
> +	Drop inbound IGMP reports for link local multicast groups in
> +	the 224.0.0.X range. When enabled, IGMP membership reports for
> +	link local multicast addresses are silently dropped without
> +	processing.
> +	When the kernel gets inbound IGMP reports it stops sending own
> +	IGMP reports. With allowing to drop and process the inbound reports,
> +	the kernel will not stop sending the own reports, even when IGMP
> +	reports from other hosts are seen on the network.
> +
> +	Default FALSE

[...]

> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index a674fb44ec25b..3a4932e4108bd 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -931,6 +931,8 @@ static bool igmp_heard_report(struct in_device *in_dev, __be32 group)
>  	if (ipv4_is_local_multicast(group) &&
>  	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
>  		return false;
> +	if (READ_ONCE(net->ipv4.sysctl_igmp_llm_reports_drop))
> +		return true;
>  
>  	rcu_read_lock();
>  	for_each_pmc_rcu(in_dev, im) {

The documentation says that this sysctl is specifically about link-local
groups, but it drops reports from all groups...

