Return-Path: <netdev+bounces-261400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIzVLgBnoGkejQQAu9opvQ
	(envelope-from <netdev+bounces-261400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:30:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B71A8BDD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C14E830367D3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AB3ED139;
	Thu, 26 Feb 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgUdWwd+"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5F3ED11F;
	Thu, 26 Feb 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119806; cv=fail; b=ugOAzIXqRufqMPVSQF2baIy+oiM6OhC/tN+dqg+6tam8NxWgeJ5+THWKxItSwhzXk4NpkZ/HWoqS9lyQ/ZVYnA5cw9OtKp9e7i0k4egbKkdBYXKr28008oXHXVdHCbJY9wUwhcYwJAIXW0XrJLxMdAyCnGnmRkSKtnK9vHjVZGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119806; c=relaxed/simple;
	bh=f6ro96/n74qFbXl5Y1IPIAyLWC2x2+DXOFDDPqTspwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OwvMjqdSroOZEIE0tM3b7s5pZZwis4kL6/LIOSekV7NR5146y2xWjlsAeNTw8s4gnW6ThdTnqD/INHZQIUmYhkqnkEqCMPftFu4vbJB+kVEH39U5k2wAMpAUBcaSbbA92F04BNCasR/q9cpxlDpGf0hJOzZ7BgGfjd4sIdiY9LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgUdWwd+; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGHF9BI8H3I2gmrsQCGi5Cih9S3DdLLvdvHUJ+UnTVNlJ5R7wK7nzyeAJCB1gvEgzHuoRSHsOw04lrDwbJIy1LNaZPNiDGICj6MoR9WNFwy/Tt/kqpl8fpojbGtPZE49ydyMgQX+o81bo4fssFU9qho7fecxaBDqzVLaC6zm11MhSNy4NfsVL+aitGdvfJjMTg3L7L6N9DhJCkYzWYN5eBRRVZhHtXLMZndu3F2RsqdxLQrHtEt4gcvC6Rt06Fj3U8KlkjpNDMh8ZHgcUf0+uTRnrALHhBaKuTHZKGXaOKNbXY5S5hr1V5jwlmXob2kFUT5p4TzIuXFznJCjqMz70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPrNSj0UD0xRVMIm7JnLDqDE5zSkB0IhKJFyEuvVKPw=;
 b=U0mdECMvD3jQ5vFNt+DtP3o70bttMKu1JyPwRaMh28TCFOQf7NLAB4vm+PsYylejb4FBVjv9dsUwKtVyCiAzmnwh9cM+3Q/6N5nTBIYQCtAOUOscS70iHnbxb9RX3gtJljin9zQwcooYFJA8xxhVZ8xgg6vVMMJcXGhkC7Mwim2ucnaBNyud+lBSMAQOlcpNnWARlwZoOppQYUenRvfZLvtNYwAVoR3R3TX5gampLcBtU584WMYiups/qOc+I3MIDevPdDzK97ivM2XUko2Wt90DbmDYMD11tdyW87ZJ6LWlUso84mdNlTpKKJjuUv1QNM9+vclP8GA5BGn0/jLRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPrNSj0UD0xRVMIm7JnLDqDE5zSkB0IhKJFyEuvVKPw=;
 b=lgUdWwd+ojlQ/2NC9HlVA6blpSBfzt6IBnFG6z+Ygkvea3bXcqul/N/zjoQVIGwChGyE5QzvVZpewcrSwVB+4QH46ZPqKpZupt+kRgao/0bQbvWj3GucR0X6YrsrnlBKA9EI9awTUMhDXtKQusOUGOIAep2F94DJjQJce/kv8cysIzwkbVJBJUOYQP4z/2qtXMoRtsaZaDXFJBpibck9cyKBfTVprCXd2JMUa185GMSbjX90+4/tcTp3Te1Yn/TRBiVjtLxPnw6Chik/Z8EzxErUmqUpIXBI5p0wQ7SFvPH1/NTXDdCEGza9C2GN5HHGb/GRRv5QH34rzGJq+/RA7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:30:01 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.20.9632.015; Thu, 26 Feb 2026
 15:30:01 +0000
Message-ID: <03b14f08-bb37-4130-b81c-6993ff406df0@nvidia.com>
Date: Thu, 26 Feb 2026 17:28:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] net: page_pool: cap alloc cache size and refill by
 pool ring size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20260223092410.2149014-1-noren@nvidia.com>
 <20260224153959.377a8e32@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260224153959.377a8e32@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 056872af-83b2-44be-25a6-08de754be785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	ocgLYgFPDxPbebWb45VtD9T1b4ZlAyONp5cihSYwEBAjOEw881j7rMfTqzAJTSV7B4ihN6fxO+LH8kVjUweJZ4edINUCFhP2ABVY7iRAF8MeQ0Xj6+0lBTS2BuiBR8QHvhkwIrNO4TZLtKZllBj2l9lpeLsVVeJdz2XtjXVfChqBaYeRzaEjvrZMiOLF9OXT/1bFqZnCZj4My0mO1ecIfhIZ8tJ2zkZrUx+5ASRISTon060WZQYaZQ2Fp+k+fKLOHLmNc/n4G1X5uurfYMgyQ8xOZMi35lbd5QZZqOnQCrkOo0B98OsElsPMBah9dQlUnKK6EgZwKM4ILMJ9xPRk9gkMvyUQOZkPpLLozu53gg/UbcfgsRpDDWyTpoe1etl/mFpa6zOGZxpkcQrH8y7AOmHe92slAd9TSMDLwEMnzLgNLT8s+sFK9qDg3hXlZZ5Ba7fF2iT30FIdkGkAccaGOOh7ws2MwwGmiNsDZGhKRMkFbh7przEzblz5xp6V8ebsg9G+TqSv29QWbioylIbsi0rHU+qBeQ61JTwyiP7mvvvZG4RLQ1aIAvA1Y08N2VmabKvwMlhfJ/xoKAply6JcqNWzKLVL2RNH/NzHhNEPw4nIrXdjDvcNJTRmL02VgmfnHOVDYT8OVcTmOhJTvIFqyStQO0e6HZKgzuFo9RuZSYFWI1M0nAy0zFcV5CJwJeFUU9SPv+plAojL0f+G9EQvoL6bcDfJcxEsq38+O1ceVGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXhXaWh6SkpwYlMrQTdqbzhlbXZSdG5DNlZtb091T2djRVIyL21rVTVLWmdD?=
 =?utf-8?B?eGhVVmdna2xRSzZJbGpxK0JiMjdrSkpPeC9sanFJSzhmaU5kNlJWeFNSY09L?=
 =?utf-8?B?ajhQY1VzSldQU1Q1aThlOUd4M2xZYXk1aERsc2gvMWZJZzRVUkl4UkV2NnNP?=
 =?utf-8?B?eWpKeVAvUmJTcU8yejFVM1lwMkFwMVRpVUQwUGZSR2JpYTF4cWdnRkE0eHpk?=
 =?utf-8?B?R1lLOGRxc051ZjRqUlNSK0htazdJZUNBZTcwM3EzSDh6RjhRSlg2WVEwdlFN?=
 =?utf-8?B?RTJpVDlEK3VieTdZWmt2ZGFiYTBUQ2Q1K3FQbmIxd1ZLY3NxdUlvYy84WTNE?=
 =?utf-8?B?d2NWY3RqZ0VXSGQ5NGZvWDlmQ2RjZWZ4S2xYT1FTSHFheHlmTjh0cFMxMDc0?=
 =?utf-8?B?aXpHN2MyS3hlTXg1dG5kbmkya1BiOFFGSjloQWxhMUhsN0xDQk5yWmpnejk3?=
 =?utf-8?B?c3crVWVNVlowSExqTjRyQjRaa3hkb1gxMkNPNHVUME1LSWNDbXV5S3JiRFQz?=
 =?utf-8?B?NUxuVjg1RnVTNk9CYlJ5eDFCN3BTak1FeHNxVElLRkVhd2lGT2JWR3BRWWJj?=
 =?utf-8?B?WjV2ZDI3NDUyaXQvUDFXclFHVjJQeEVoaTJqQzRKSFFnM2pCdjJqTFVPQjZq?=
 =?utf-8?B?Z3FUbzNRVnlDaXl4U1l1eFJyYjNMNmRsY2MwU1JabmYvQmovcWRWamdPUTh5?=
 =?utf-8?B?RUY3Ums0Z1crTHJqYjkrTTl0RWYxbjVmUkFsTjUyZXBZcEtkOGo4ZGNSbFd3?=
 =?utf-8?B?eWdWSzNvSFVMOC9iL1F2WmpqK1A3ZW1La2J1ZmNadnBqeThHcDlHdm8zSml1?=
 =?utf-8?B?TmJLMUNyaDM3L3VPWGJYdEdiSWxjZzA4YmE5MEN2M1YwL28zelVqcEhUL0VS?=
 =?utf-8?B?RVVIbFBycW9JTWlEZ1VFcE1NSzRnamo3SjZ2L2FkbWNoZVZpMGMrcVZJNVo1?=
 =?utf-8?B?dEIvQStDcUUyUVI1M1ZCVCtEVmVwUUdZMndLQ3FXRmo2T0p4OS9naE80N3RH?=
 =?utf-8?B?NmRGMkxPZldnUm44S3MwSGZDa3JFSEgrMVVVVVV1VTQ3ZFBaazM5VUZwZW9N?=
 =?utf-8?B?ajBaTC9xYzV6b0FvL0ppZUZzd1lQUDVXNGZZYVYxZDJTWm1pQTFDVUNiTDhk?=
 =?utf-8?B?OCt1a2Nlb29xa2d1c3psa3ZQaU9YT2JHTDFGZUhYK1dEa09lTmtGUUFEUU1t?=
 =?utf-8?B?eHVBUjNzVEJHQWRRRzZDZFNCdGRyVFhnbk8vZEkyZGpZTUpTdU5PNGJGenFJ?=
 =?utf-8?B?T0pYYjFMZlR0M1FUZ0VPWThjOFdwbytEY0M3QXhKRHZpQkI2RUQ3b3NxVXZj?=
 =?utf-8?B?KzRaWUIrSjhQajJLcVFocWFPOW1PWTdWR0trT2FTMHhQd2ZGNFR5VExjVEFZ?=
 =?utf-8?B?K3R1SnUzYkRYZjIybGpCNDBydlNTT0x4R1pnUVhaM3JLRnpBbDIxWFlCdWx6?=
 =?utf-8?B?VFFyRnMvSnlwVy9odzBMZTZZdnhsVUhFYWI4alVmdVRZcWxHQVZ4azBtdWMr?=
 =?utf-8?B?NXZSRXdjS1duK0hKMzRYRTBidjZoQ2J4eTlTYkszYnRESHV0RnR2ZWFkb2o1?=
 =?utf-8?B?Wjc2WmNBTjNFQTZFVkJ1bzJZclc0aS9oWDgxN05JbW9aM25nMkZTenlmRVEw?=
 =?utf-8?B?c3JSb1U4VHBEMEhJc1QvUzg5UGhzVXR5VThtS0RtYXFVZk5tUmRyU0dST3RG?=
 =?utf-8?B?Y09ZanR2VUU5MmxvRkJwMjVNa1hLT0hoTUxjVWFwQ21Yb3o2TUVWTzcvK1FK?=
 =?utf-8?B?R1ZTdGtENXRML0hjVlVPeC9qbUpiQTNsTmJ3S0dJRHErSzdTTFB5TVFxMEor?=
 =?utf-8?B?OFhveThxWkVHU2R6TnQrUEVlOUMwZ0NEZ0N5ZkpLaXdMWkRNNVJacXZoZmVo?=
 =?utf-8?B?aEM1VmJwTkNCN0c5dXRmdDAzQ0F2bWMzSFY3YlBpb1dWd0tHWnBnTGlEK1Yr?=
 =?utf-8?B?WHAzU1Fkc3NPNkp3aDgrWHIyVmFhS3JFNnpjOEZya3Q3cENUSVFvd00vaFBP?=
 =?utf-8?B?SXY4SXE4Vzl5c2N3Sis4SnFHR0cyWlR3ZnVLbGJrVGRydnd0Q3JlaXJrYUF0?=
 =?utf-8?B?Y0x0T2EvSHNWeldiL2ZNZnJ5Wis0MHdyaE9rUEl1a0pwd2xjZHpMVjFDZHdH?=
 =?utf-8?B?ZzJja3A3Z2pGNlIvQTJheWZaZ2xpREY4MmpKeUpyQWY3RzZQUkkyZWFUN05w?=
 =?utf-8?B?cC9jQVFONXlybHhaQys3c1M2K2RwUjF0dlBJekQzQ0FpZnZzaWlpMVE2MVhV?=
 =?utf-8?B?S20vbmpIZEUxMWEwZy95ZXAzWjlwRTVTVHF1OWZUTmJUelp5OXRFbmJ4NXRy?=
 =?utf-8?Q?HLknhGEB7Pl+OQKY91?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056872af-83b2-44be-25a6-08de754be785
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:30:00.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsrLxXa7gebBYuMarj99yDvvmtmRcX4PhWfJpL0X9C6uckiVMDR+a6oB9zgURfZPqBAAkJX5U7wXcisniAyQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 5E6B71A8BDD
X-Rspamd-Action: no action

On 25/02/2026 1:39, Jakub Kicinski wrote:
> I'd simply change the defines based on PAGE_SIZE. The allocation batch
> size has nothing to do with the ring size, it's just amortizing
> allocations within a single NAPI cycle.

Thanks, that sounds good to me.
Do you think a formula like this would work?

#define PP_ALLOC_CACHE_REFILL ((64 * SZ_4K) / PAGE_SIZE)
#define PP_ALLOC_CACHE_SIZE   (PP_ALLOC_CACHE_REFILL * 2)

It keeps both values constant in bytes across page sizes, ensuring a
consistent memory footprint for pool alloc-caches regardless of a
system's page size.

