Return-Path: <netdev+bounces-279514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCicHLWn42l4JgEAu9opvQ
	(envelope-from <netdev+bounces-279514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:48:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8F4217E9
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC523023E07
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A242D8382;
	Sat, 18 Apr 2026 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMsYa9Jm"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9C26AA91
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776527283; cv=fail; b=cNKXF00y1MwFprQns/6SpTqJNMwBYy/J05Xf3Lhq14U2c4NDYtvNDC0ukjQthOCW00c26ib09EX3BvsIAvLzzxalM1d3p3/to0KvwLsVmhMXshMkqAo/XKbU4fNcd/p+ZeCnFlJn/mbMgGTs+zIONj7dzLgRoOdu9kyrHLVo554=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776527283; c=relaxed/simple;
	bh=982W3Bd+kG4qnJbrIzQndbhiXviVoF3se9tGlSZ62ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rUG3lW2Quy5XqnD5EiSD18QkUSs9cEL2oNbxLO+rZv1CkJWU1w00EDCsHgVV9rUUgNs1ygU6WaCrlG+IBZawFH7x2lG1jlGXOcSka4+rEyU5aEPWBiqsmmhFeBVXC7nmPSNlRlfujlaooniLn6VkLfnI90J4aYMSA+x4UICx6O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMsYa9Jm; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7+V/XzVr2NzfMUoX0to8CXK7yckpHGREsmGUZ9ltB0x458BgZvGwouksReUTCF4h5mDT5I/NtMIKHjq0bU9WOZyucfmDICB6Zxf1miLlUon/rw8PsdczipiEWdXZuYYhgdAgYam4v5d7sXR/MnHd68woDt1JKaUjYNDk9nnRNIaCPVSytkv6xa6vVNRIpHqyuN3f/OfVJiNWlN+dQY0mDwJB3EI3VzIYnsVAhF8OgAt/1104UZhNYP5GponjtJ91VvbpHdRdyvd7p300+U4/G6uw5NMXGH+keASugHJo3UHiRmYiPmgetJa7PO5W7b7eOlxTWd6LO2kSygssleJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIcL+9QxUa3T4d7AVHJbzxCcUWXg6ygT+5X2b3EoiQM=;
 b=bi+UJDOKVRI3GZxF9Tu5ffPps66QVAJ5c2mJp40WLQIqd0gd8ROljx3FdA9AcJcws/2TWtNZW901LQ0FUAgpwRK04U/XAdIXn2KCpSNdDHSlPw40kxYyNX/wv5nYw1uJpCnhd0i0hIqQMXTG9UkeqGtc6rEzKA8vkndjwhPrlVuNeZROhgc4W64G+LOaRJdpkGTvKDPAFcktkSQ8gewUO1moM3vyO7eAiNiQdiHs98BN4TcOcz6zrA67lcKl8BYa+jcgVOxktHOS1j1LWbSrgdihZx5zz6e43NaWnQ5jK4E5EEFgtKmssrpB9yjhCQKnfjQaydGPna1+P52KKwIufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIcL+9QxUa3T4d7AVHJbzxCcUWXg6ygT+5X2b3EoiQM=;
 b=mMsYa9JmcfW2TUEQWxfTksmt2Dh5dI8RDLpwOXJZyojPikoycAzpJ7CUoXx7Yosiq0n4+DsRUzI2GuRW+wR58lZZUnFY6v0D1SutC9WoNAnVxqPrYxw2tddpbtzIOyl1lb7Fny8mB3K7tYowTFRrtpcYp6BBV6TzyLZg15Qt5FjWjsRFCdgTKUbvVrzgBkezMpJvTK3r9n1GoPKdJezWOKbU1ewbrvBiZl6lCs06O5pYWEI2AX6KrxdjiiG5bbcUpet9oRAkGElwawV+9ABRYBBqjIxgSbkj3sE5l5rzkluvj7p/xIPNbYvLkzDjg8frCKEkMWQeNa+BS3ztwO4wsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sat, 18 Apr
 2026 15:47:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.007; Sat, 18 Apr 2026
 15:47:58 +0000
Date: Sat, 18 Apr 2026 18:47:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ipv6: fix possible UAF in icmpv6_rcv()
Message-ID: <20260418154747.GA804500@shredder>
References: <20260416103505.2380753-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416103505.2380753-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b227aa-2192-4fbf-51cf-08de9d61dd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6d6WsdtjrzxmFpIvm7O0lS2Fjf2oToL5LdaABg2H2ZhhPgIWwvqdGvPEOwHNCSkU1bOIfNIlIQus3VCVFGlOSOba2BStzNLg13jXkVY8Li+kMcAI0liCC4V9MaoohYJhLHT7wQrTvdROyo9JJOkrpDzLJimocCluUhkiDIiBgOhvaaYB9jJ5uFTcaBmE1fTHqIuN7TwvzP6/yS6w112fZOqw0Dqzl3Gvt3uEfLU79PqGFJLQmqOQe8Jnm3GqcU0FPc2babqwnsUqeS3J7TQOaGjHksstuA3WFDwnHmNw9ARthurdW/JUCU+xUEXuBSMUxPdglU1DbSefqrK6zeBvR61NVlc1XGhtYJia0xtSN4Tr6CaVFVeINOWtoE+pkjKF+K6KfG5FTGugDXftbs8MRZRFKbU0NqBerNbWCH5DRG0NGlkv8wYIDzYY1OvQUOYZzDbgyB+mGfreYjbZFRAlcqq+nuZPbfvBj/G+tziJszE8tuT45IuZCnqq0bOoxhEr/ai3N2OTxQCh43V61VxXIplnJD8LD4DlbtesrI8sRZPApCcdi17T5ut8nUfm8mzerIXHhzqflZt4JRpPV4lY8a8CMhUFiXskRD2PyH+fnmGy+VoD79GJHjpa/RSmTMI66Xn/yN2IxV/gc0WpkBC7Zg8eqaPJdeNQgLbH0AmkWLuwVHG5y4S2Y0lNPrmlXI5hctQW1Z3MbHB354WlyaThbyTGA7Igdal6E0VjVW+v9kE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uu7UdaogW0JNrw9KEqNUWSxGyK6cKKEOH+QUmdFjsMPok7Y/Z6oM4G/AFuNi?=
 =?us-ascii?Q?1bP1d5a6uIEmSXveR50YkYsRXxhvtM9RNKpDYOh9VOxz2ZnzQbcNLzrGXLYv?=
 =?us-ascii?Q?4BAqSV8VVxAEWQTwLjf2/l0DHaFpECEylAXXSlK7gXwbsjQZpCnyFdj/b0+p?=
 =?us-ascii?Q?AwjFeeluKOEXrtJ4bXoCyO4uS/CSaBBsvumGGH1NOsXeYnSPfLjrZq3oXhXz?=
 =?us-ascii?Q?T4+3aoBjhVF4FcjX28x/y1bh4wLo+8FeQMPBNU5JexiHUqTbu10//mmxbrbp?=
 =?us-ascii?Q?y5wvnXmeMQ8xukC7hhVXEIna0McdviiYveVHiGZMTpiKG+6xq75qRZQVg7Yl?=
 =?us-ascii?Q?OZNwqlAtKiXgjRAYQk0Z0Pb1NrCm4MaNj1NNwoXBni9NXPatffsQzzF0CxR5?=
 =?us-ascii?Q?L2cpklkgWJDo5pXnoY/Aydsrv9MR5TaNL5FtBVa5DsD8dXVquDy3ovZo9+0n?=
 =?us-ascii?Q?9XRLZ//QT+IxlolZU1EB9DRuusctgNgo/df4lRPWbW0XAQv2AHD5OzCZGGk2?=
 =?us-ascii?Q?lsjANXY4wkwLWtt0B7Qxg4ylXMGcn7X20QgOtSB+e30biZrkhN0JhzVjk6D5?=
 =?us-ascii?Q?46l+vucDmfy0RJtJKotwMRTCJPZTOEs39VX/p85bE2Tp1KsK7d4+m8UPSl1M?=
 =?us-ascii?Q?7/6Hf3+bqd98BsEuTdas4WG1ES1mqUEzu8tck9Z2V/jaiiu5TV0iNbxRu0ET?=
 =?us-ascii?Q?sh/ZBxzPXtEDNI2FZDs1CU4gAA5IqxC27PJ4wtmv6ApoDC5iqfHKjqK0jfRf?=
 =?us-ascii?Q?Wle+WVH1ZxzZqourw2jxci8RPrSMuVq5255jx+XXnZ6ZJtIcVVfY3hj7rzve?=
 =?us-ascii?Q?yfScXxozitO9oC2A7ZFxyAgyBRErv1IlmoqyNFqm1c1YrCskgFbp88pRK7Z0?=
 =?us-ascii?Q?HU+mxiwuvuZUA74qUavr7Y+DyP3D3yWmnvKCPSoZ1E9rDoVYuPGSv07+fHK+?=
 =?us-ascii?Q?Wswde3EXTXp9x/ByzUXnDRHsrnHtmhmxEd+HEZ3FjEQ04evuH2JgqRAbBF80?=
 =?us-ascii?Q?qqHTLqw75gGFOBy0oPtyapKcYPGiw4wCyDd0tDUx5QGNaBOC65FO6jtLAnLv?=
 =?us-ascii?Q?KyYiUkj4HoEoqQg+AIIIwKAjzNQ3fJJK2e1Lss2e/C3r1NSolE3L21Nv455p?=
 =?us-ascii?Q?8HA1Wl+mtnas+LCheodgisAX/pEonuM8D1/LcYyg8ggwCFdgeBAZw6u8ZVPB?=
 =?us-ascii?Q?KXW3wR8FkZO/URQxGwyFrrtpcr/+O70ECNyKSPZvAbm7nBHuMDNY8NMStVhz?=
 =?us-ascii?Q?cmg3lNVizWysEPqXl2eFCpqZgpWOX50Fj1XG/BugVFzsY2nvk8l+Kq54XEK/?=
 =?us-ascii?Q?qNoWuoueCocXARc6TeQSW8wP3t8iPmveYQzaeujw1SO8tJHgdh3RrrMdamFY?=
 =?us-ascii?Q?VCvOyGGf7J7W1efOtfy5il6PtAOOale2BK+k4Mv7KxBez0dqxiFZQEdElkuc?=
 =?us-ascii?Q?RPfugGqrvN0d6YleZzPQIfIcyn4Jpf1EM6paoIy4kBU9NHFqmTwjGlwdx4CS?=
 =?us-ascii?Q?iddhXnj//0A4z1Oec7DEt2wQZQoroPtqV8e+H5rUOeQbbMsm9TesPDfz0G7f?=
 =?us-ascii?Q?rk6JKxF69I8Qo8rdR9gPS8XqUG2YfbHVRZULpfOjDSYmW+qqPfWq3QaW+wrR?=
 =?us-ascii?Q?1IeVGq37OTiG/BeKO+RPJWh7tUoBs0DPTMleIrBAAxGzV1r/2QS695otwvV6?=
 =?us-ascii?Q?F+1xkDuDhlyZ5HBS2lle4ctIuzLUnE+97Jg4p/rCrH2n5vb+6HV5SnBFhU2c?=
 =?us-ascii?Q?v02LCcSaeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b227aa-2192-4fbf-51cf-08de9d61dd14
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 15:47:58.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPs4GWs0QqQtQyP3dsSq4inHQ/ieVTXYMqmVIJMUHKmz3g7Q/lYhkvKL3dG9RERDioDLeyKDJRHQT7uvRPNMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279514-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E0B8F4217E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:35:05AM +0000, Eric Dumazet wrote:
> Caching saddr and daddr before pskb_pull() is problematic
> since skb->head can change.
> 
> Remove these temporary variables:
> 
> - We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
>   when net_dbg_ratelimited() is called in the slow path.
> 
> - Avoid potential future misuse after pskb_pull() call.
> 
> Fixes: 4b3418fba0fe ("ipv6: icmp: include addresses in debug messages")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

