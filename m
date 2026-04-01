Return-Path: <netdev+bounces-273945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKUUN93IzGkeWwYAu9opvQ
	(envelope-from <netdev+bounces-273945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F269375DCE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02B52304E363
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934A37D111;
	Wed,  1 Apr 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVQT8R4k"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476285B1EB;
	Wed,  1 Apr 2026 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028388; cv=fail; b=nb9MVerfCcuVwlsF2tAjYZhdIw1bvvIFhYClx02CHhRUDoazl7FO7uTGhSXrIqbDVw3kxjyHcEpJlsx/Tm2Pbqij7l9jcR2+o98GIxqTy6/zyT+7syspdWyBy+ByS/nl6tqYqnLyrZd0ee2/P21F9jSG909Wa52jHd+dRJehgpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028388; c=relaxed/simple;
	bh=1LiY9JcliR/upYCvpkItqJo+q9E82nIR8NRD5cyDUfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6IgZ+PBnVoNE0R9OjFWxy8Lp3NTyNpb91QdJ6LJvCkZDOVtPz76/jC3krkAhsbQBFDdBV/a1Qig3ZLjlydI1/cajcw18brd1a+B+tePYhOi4Gyy/EYv8BxOQWoKlhxw+lHJUBiSZSH7hTleGVaWPvXMxLFRVlGU3YGricmZrXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVQT8R4k; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/TqbM8/oljv9J55pkHHqLhKVJV+FuC0Eu0LrPcyE2I9FzFEaf4vfhiPozUacX8rnTP+ychxbSVRpOF7p2Iy0KCUvfntFpEGlPvcelT69DWTfJgnL8j7oHTyZKpxyQnbFDqwmtlPw+7wZlHPwCmNgvzGfo5ElP8n4HkMMNqtAjdXTSOCfE+wJqnft6h+4fTWsY9zSQsvVNnERXxGrM1VU09Dt+9aXegnQN4xWACDkRqZMtN0ss4ewUdCBaYUeWOOgeNAUYLBNUeWqKZCX6B9f5Qb9QOfKkqEjGNnfJHuewR/0ZuPXzLAtQCx6er2LLJhkwY3kSr8i4hB0Q0PVFRe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a25/0falvkt3qgcbhj45KGsP/0U76yV+6xlmefRWosE=;
 b=P1u6lPM5I9h4LF5fe9jIPX45YqZZR1G+r2Iunb0P46aQhlChwMsEvKiPO0/+oG/Ml8ovkzxMPZurIuYvvjSUgJT7efWUK/7/9MA6uRFev3KCyairG/FzhXDGYI5SqhITlUMHctFTo9QlRSIjXMWZxha6wdaEMPyPE6eHl6rL4LS8iZ1E5mk+coy6WPYS8bF8mzbxlHbsRwZNQjcZoJHtpiy6pgzZttRaqKGgaFIKUO+xABMTdNdX2TPiUmF6x+z8ECnh2aO2QHli9MANhaJZ2W57G3VAUaERQViXDgJE7MLvhwSKb06JGlysPrWCO4MgHXyWuFtyUkiTICLK/vydAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a25/0falvkt3qgcbhj45KGsP/0U76yV+6xlmefRWosE=;
 b=RVQT8R4kn3zl8WAx7xdvs8XSB0C6QHzLFHotfnezpeXc4m3VagzqVhyUXF4Vak40zJ6XvEiBFT8/m6gc7dSJFJAUPeanqnm3oXSliI+GmnHgc4+H8/KdM5JYu2dkoQ6tJQx5sj01lwnILSd9EUWwHx9MguX8JBODZX+UBHKQXhl5RxosOtC46Mc5Og19vhf1/sa1mgu+kjAoD6M/ck6hEtasp/yH3ukpB6f3nDMupJbaDufB2EDiKOn+K6tJ9mbHcEnTlpeGq4dxCQ+mJotsW7N7enGxtXfy/2K55fxxphoMvpx4ioIJCr8isYuCNJgtZN8lU4zRz0gZGhkWJmFp3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 07:26:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:26:24 +0000
Date: Wed, 1 Apr 2026 10:26:14 +0300
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
Subject: Re: [PATCH net-next v2 2/5] ipv6: mld: rename mldv2_mrc() and add
 mldv2_qqi()
Message-ID: <20260401072614.GB1725933@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
 <20260330191611.16929-3-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330191611.16929-3-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 2405d9b2-ae39-444d-94c0-08de8fbffa81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1w8se+ItZ4+gEHegNh6cHZYx9NFuMEXjOOYEwZJUDq6BnlhwNYOpsy9sKFjnMe2ZHrJF80PvMqa1ua9X0RUaeZmfmwsQ5SrRfOwSmdCJjdC8fs8I7dbryTg31tw/AIq+KtAPflGWhbTy10+zW7PqiYYS3GQSNjN6tUR5qRM0TU/ptG1ejPXh0xbIlE8oj46KLevGL6Ds70YuAon7K68K6yQsvaR5o1LiIgdSFrKg1HJe5hpQy68wvi9lAjyLU1UvAqYK2QyElgIOCW9w+kZgRSX+MROLnvKC+HhyRXlW7DJhoSpDlYSGwu0xE4XpmaF27HvJX5OMAyJA2ojYy/ZRvcuaRSgh+1BTUMKEClimBiT005rWPA/n4oUtSWBpGvoohx98f002/WAsrddj8PMFUr4Lh4IAGsNIC5t5XU2Fw4E8GMHQgPvc4H/qChCXgvnNHPM3WUlokVYL/stVnUU5v24qtfpYu90rrQJYlsCD0qyWEwsPeYE7swCYHxDrTWUB+pZrpb4429cyk3/njsvQRlZogdctVsQmpcq/SL/1PDgxbkialDi54Arm8DODyGPCJXkqaHyCpMu9EscDDdotzALtw5q8mF/iRvCzqLBvAQ5LsoRmq9DNnq3xS7DFhMX8KqHhrTL0yrmV6srXYAY3U+UpPu3ceqEXwIk2fwaCANsaTPX0CleF8oAJuLpHv3ahyGQC6+ltMfzaTzPfwQBaBPfFroOL38K9hib0q00dQzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?brQnSbVKWSsSpxb5ceWBRBTqNqAHT8Ky5JiVEFS6BseilzCcawonGnwl9J/p?=
 =?us-ascii?Q?RY0Tq3bFarxbuqReaSEngntSvlqwSOD1qQU2a6uXri855q8UDXsqHl/4mJ1D?=
 =?us-ascii?Q?61AJZJOIgh+bC4JpGWGo2ZlOhbcVOonby5VPjjGqb9iOV2su5u00NGxLIDy3?=
 =?us-ascii?Q?w4lYykcgnlApIHCveHBijPBOaksa1ZHLLSpWWB9qAM+MfArp1BfIKGEG06ZY?=
 =?us-ascii?Q?GIKq4WKJNGJMZjn6N2CI6AKsG9SNkH7+CmUFojePtoMkmAG/Ci3dMR1sl5ga?=
 =?us-ascii?Q?egkKX6Vn/W4HWaO0eZpzHWlSH8Owyfe1GpgM9xWiB+rpvpoCTKbf9kYZwcQ5?=
 =?us-ascii?Q?Uxz6Y2khGZ+3WU21rSjWfo8sxlLNpcxmSb3h8ZErWvPuk6QbwG74Ir/oHZSW?=
 =?us-ascii?Q?Pu8XwAho4WBSpGe4PLGIJdtp5aePrAM3TxN9TK6tvW0veR5+6rEWho0KhmXK?=
 =?us-ascii?Q?8QL+1SP/3hoRko9rKPyp50SUE+cgIGsDIR17bnbjxzK3zEGu/ciDLjGZPJSE?=
 =?us-ascii?Q?BdA48qGJMFmkrkQFme8Q6dZeqrnS86xrAB17yLbvLHgEWsCdGuXBq0Cjc+UR?=
 =?us-ascii?Q?4xb31NbefVSpgqz+ErzfcJ5uCUum5iLXvmxS4awrL7g5Z2AZZiA0Otqrdf+J?=
 =?us-ascii?Q?dh++8ssr66/1LkS777UPg+uhMIiE/YXn/Lba2nlzoLuWzWmAeA1e1RQe+n4w?=
 =?us-ascii?Q?+sMY/5gY3GCRWUzaZPkcNT6EVQ3StSYwr/eUUaGLhcpI8CbU/ygsdINtT9hP?=
 =?us-ascii?Q?sfQwTL/LM+jusfEAk1FiTQPkeA5pS4QCrUChhzfw0N/8YrOlgU1vCXXWeYcd?=
 =?us-ascii?Q?vxqVrKwGFhkfk22wzCRi4ots+lCPyxZO5EwgeIbfIUF3VbQoZH29uSbY4lSc?=
 =?us-ascii?Q?lWcryB3xsKkiOuXWUjFLbgzBrdEf2sjfKzqg46nqZpW2lG+WK/eA786kHSUg?=
 =?us-ascii?Q?4PtpxrZLReQr8Go4R2u89uX/DBe8BwQQaRYrviEJxUpvssfeLKoAPbBvdkPm?=
 =?us-ascii?Q?vZ8SVVsnidLwsIz8NLTIfuVMuIguZoo/ss+8zO60kamu1mxkAnW46EigBkZI?=
 =?us-ascii?Q?E35U7a5kIEPXHYh2nlKS7MYFlJ9yAabc1YO2d3t2k4bg+vafvoRGFzQTryPb?=
 =?us-ascii?Q?34IjSGspVFwLFKY9Pn7IJp5K7+tuyTijvAqvz0cNxle5ZQdAUOky0fLEDcwC?=
 =?us-ascii?Q?O8nxukvh+sU43UgLHuetJJO6h5tVSFj2zEF17RV3WxF/c9fTlnPJrPxTRH9Z?=
 =?us-ascii?Q?hn7COiCDY8IC9dwPfTCeZc12HaYxAalJ2LzHIE22andoAdMFPbhspBvfTB26?=
 =?us-ascii?Q?6YXhwXUlbYwEXXgdotpJmWTpLT6m7dCjpoSUKC/NW93patpavOSLznNoFt96?=
 =?us-ascii?Q?3WT7YcJFJGh+ex+wgI3m5tQxueNi9v/lx4cdaoiz/8vL0LLp40a9Nj7zjt9o?=
 =?us-ascii?Q?CrGS7dFVcDJNF43DGLRND3hUUnvu+btjSTv33KVU8ldaftADHODo3Sz/4Bm3?=
 =?us-ascii?Q?IJzPULyHI1Yyoz9ATLPfN8zTsSrD8MW6zWjhdKsyMSaxV5Tms9AgAhqAafLZ?=
 =?us-ascii?Q?m3IHRfgPvOGszDHcxu6zysrRG95Ng5LJRy1fnHJngHUg/AOqlfSCeQoen9wa?=
 =?us-ascii?Q?cZbH2bPAcd2Mvw+DlRXuMNJCJGKKO7bgHhJm/a4Aqzjc8d+8e6iAGeBrK3ia?=
 =?us-ascii?Q?in9OftaXIaoEX1ufk6uQ9RrAF+Yzi4dEYpzPVidhzJDR4n5dyW8Vnb/NHQrR?=
 =?us-ascii?Q?DVtlUH8J4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2405d9b2-ae39-444d-94c0-08de8fbffa81
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:26:23.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RTW2UIdUnBgxc2BGwcijX+o5khIkmURigOa9bv0S6vrlWdxqvMt+3aXS0Md3RCmD22NH4qBmZrdPK3p032o+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273945-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 8F269375DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:16:08PM +0000, Ujjal Roy wrote:
> Rename mldv2_mrc() to mldv2_mrd() as it used to calculate

s/as it used/as it is used/

> the Maximum Response Delay from the Maximum Response Code.
> 
> Introduce a new API mldv2_qqi() to define the existing
> calculation logic of QQI from QQIC. This also organizes
> the existing mld_update_qi() API.
> 
> Added by e3f5b1704 ("net: ipv6: mld: get rid of MLDV2_MRC and simplify calculation").

I don't see a point in mentioning this.

> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>  include/net/mld.h         | 64 +++++++++++++++++++++++++++++++++------
>  net/bridge/br_multicast.c |  2 +-
>  net/ipv6/mcast.c          | 19 ++----------
>  3 files changed, 58 insertions(+), 27 deletions(-)

This is mostly similar to the previous patch, so the same comments apply
here.

