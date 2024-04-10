Return-Path: <netdev+bounces-86781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE758A03F8
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF971C21AAD
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE92E40E;
	Wed, 10 Apr 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjdhFay0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5FF9F8
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791360; cv=fail; b=hab1AZO+xCmJHla8prY4k/mu/3cC8STG0Q3aeuxUBN1niej+pC0xYPpPTalFMDhtgBNZLJerB+9L7WAgZI49HKfKo4IFOTBXjyyoqdIgi91ZXqjNoKnBOfBCyHITcDl60WvMVMHrwc9KDtxkvnMJe/Dth2cQf45m4KDTqJSo2kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791360; c=relaxed/simple;
	bh=zX9Ks/s8FwKAZy2Bdh9WxNJsWiEj89f60k/a2cqpUJA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FkLMgaK/LrEURDTluk8q+vmVLGhZxHDEeYf4hjci741RtCbfGLxZGzEYNLdDjwr69eWyudICu6l7OxwBbxbUGeV/SMEOS3ApClQhIFyvEdSLFMFHBqAZO49l5mzjNmmEtDl381g6V+IrnvmhTdnDj3k54RzKYweaP6dfi2x02SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjdhFay0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712791359; x=1744327359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zX9Ks/s8FwKAZy2Bdh9WxNJsWiEj89f60k/a2cqpUJA=;
  b=VjdhFay0a3lB1CCRHww4laVL3ixEAIfYoBliEdVqGg7KH3wh+Q5Yg2PA
   lsJYEnc7HQ83MrqrPa2PiQwWn/xRo0aQ2/xVygUsuuH5sqo51rnTPq2Ip
   D5GMd1n63GyuCnr3qqYP+nBbxFTa1OHdbUFIHhwE7I/yRCXRSjI9iAe/0
   gfhCl/rn5Z5sh7wgHBgvXQn3muXIVChTo508wy3QBRJEdHaXQERBxtuBn
   4hbsgLrf2zOVuKYvJt7v6U1r6dFxjSt7pGiiHZsRXRucLZRxNifQfEcuJ
   /+xWvTdqU6I8NzX82Iv54wp3t78BTXsPlU9xwLwjVLvFdtGWOLNgezSTX
   Q==;
X-CSE-ConnectionGUID: d5jUGt3XR4mAmeeZns9MKQ==
X-CSE-MsgGUID: YKLWn7YQTnKxUQPKPHwMSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18894475"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18894475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:22:38 -0700
X-CSE-ConnectionGUID: hyKZXGXcQkGApNxQfQc72A==
X-CSE-MsgGUID: M1Qn7g6PRnS+TtqxkWppiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20672856"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 16:22:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 16:22:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 16:22:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 16:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuN8e8kNnnm5S8farfsa8MzqZtmY5FnhieSpk/zYfjHONhCxZB8diXntpAuE583AkxGCp6t3Gff6d4PomKduZp1TeieiilpYhOzEk61EOs6kDDDfe3RIG81Wo/EdYJdS9nsx65kK6Meh5YT0u1/hVejsPN1BGpTC6Ib6ueNCwTTDHKRHXYc96Ou+t1ADlgh2nB7BMHkpD4AX1865/cD3Ya605L0zhTIeoCwcWAzv+SZq7PttICkzKTTQj/+HuRBzwmY+zJhApW9IXrR8vFu9Gt6xT6gKTssQSubS3evMHxdOAQr+knR61Hk1J0HKrHi+MmugvskDlxkCEnqxwt+g1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkeLMaZJ/b90UvUt/hg5P3LzL8888/7c5Kua+kNk1pE=;
 b=af9kLWiB7LPTntYMXUq7PoLBvb/CluV+4fU/+I/4fUfX553KiCHFNiE6phVdz5Dws9RjCZ0GEF6lMRAvYuCX6qo5JWYFUhZBcFGI7KnvVlaZzwTB99+b0APZN44vfHbsu5cJzgj+itV2AXd0oC2Xn0A12rpP8bPqL0KqTKTC8WoRjflnHhpWpiKRER0Nz/TW26gWSpqMDy2Ezouqbzrsjk4n2dVAtpWxjFZFX4NKVNnNDzklJ2BWd7tY+kFrLn8tO6H66Mmc5sX6Voxkrw6orshFqS2xRufNGUKpVyhcjvIMq6PTyxPrCQyuMB3LadKkm2marUegey474XEIaNvBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 23:22:34 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 23:22:34 +0000
Message-ID: <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
Date: Wed, 10 Apr 2024 18:22:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] devlink: Support setting max_io_eqs
To: Parav Pandit <parav@nvidia.com>, <netdev@vger.kernel.org>,
	<dsahern@kernel.org>, <stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>
References: <20240410115808.12896-1-parav@nvidia.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240410115808.12896-1-parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|DS7PR11MB6062:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV/UiY8DF4ltMJ6CUEBA/HAr9raX9dM6KoHDDjefwtzYg4QgsHHrtKIUzhR3tSF/PkezFTn3rmjNn2B6njjUDA2OHNz+oFY8NU5EwI4A5tbbT7z3eIsaAYbMkXX6BWw1suvqnKSLoISVSaycko9o2UDD7DyaVFPZe1K1misBYTVwxzysmzPwJKkar8o8JHxrUZkR2sx7d99RpjtR6ZNcbgTXSGO13jZ2Yv7yA00fp5Jb3S1dCD9umnRF3czsJfvnuXWC9UcWjZBqbeRpqRnEh+XHdFKMEOGSaKXGVOX+XDoG0TK0ienARlY7CcFHLK4+1E9r+Hy5Gvc/Y+SHNY7yk2pFrNHzCgmIFRzGMfNcfHCfbCkXY96AXp/Sg2rc1dfhrjDgVW3GpT8H9iW444NAQr2wjLMpU7U25QKDfMDPNr7cpIobLb6f0G64MwM2ygZ8EiQl9DXrHbUmX3TzteFHRfePf74zTPuKPPD9KP4K2g9CxglNxzAVuqzskCC3O0anIvZtIboLUbL+HTIDF1r8FZnv8BKIJ2c1eqZDS3LIDhP7yyvGFc8Sk85hK9LU0YVyUKTpEqEUDxlRJb+lGAYOqfSmeUcPpoPoDJ0NohfxjojY2q2ksW3LNiuETNACiNHiev152X3ESA8WCG9CWlBcS1lIl5T6Y/VEYLxr+4CJVe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEU0OFRpb0h0NUR2dnRoRGNvOEdMUy9jTEtsaklXKzQxVHZ4NlRNbTdENlJj?=
 =?utf-8?B?dGZCUXBDRjhEcEtTOGNVR2M4blZTaDAwZDR5RzN0OW5JeHprSEF4cHpKclFs?=
 =?utf-8?B?Zzl6ZjZtV0JDbjRzd2Uza3MzZndjdDhuckFMSC8yeDB3TnQyZzVmTXg3ZEJ3?=
 =?utf-8?B?K0JvRlUzYVNpMUx4QVZKUHp5ME0rK3lWYkJHQWJyc05LbDZSSkxaM1pvQ0s1?=
 =?utf-8?B?RHVmZm16YnFTZktKZ2ExemoxZGxBQ2Jlem1COW1DZVN0OWdrVlQ5SXg4dldR?=
 =?utf-8?B?U2pjYTN5a0VxVk9sOE9jSGQ1UzFwa1NReVNubTRaU2dkUVJpME41azlJL1M3?=
 =?utf-8?B?dG9uQllDTk90a05LNm92MG94K3RpaW0wSml3MjJiNUwvZGhPWXdoK2F3K0Jp?=
 =?utf-8?B?WEJRK1h0NHFLdWhTOUhzK01LL0gzbzhnYnJDYTNmNU1naVlSODJTS3FjSThr?=
 =?utf-8?B?UXZYUm1ISEhxUXhqRUZjZW9KeFNTbGx5V3UzQUdkejlvUEw3V01Ua0Q2WmVC?=
 =?utf-8?B?a2Jocjk1bWlicERyQ1RCZ2VHaEw1V1FHK3FMcGQ4VUJTMFNGT09pd3dPNGZl?=
 =?utf-8?B?azQ0THlGRmJHc0hCaGtrT3h5NDArWGgzTS9GK01FcEEvNCtGR1AvU2xUT2tw?=
 =?utf-8?B?SkcwNGZNV2s0M1dlSnN2NUU2YS83SFZ4RldTSlFuL1VyMHNOa1NJR3RVbUVo?=
 =?utf-8?B?dUovcjE4THFUc3VnM3l1L3Z1aGhlQXhDRHNNbkR3TzB1TnNtdEptREpURHNs?=
 =?utf-8?B?VWlvcGxSYnVsSlh3UkdFNGI1TVpxMXNJUlg5MkkvS2hBQUNqTmRwYk13RTZZ?=
 =?utf-8?B?WnFaL2gzbDlYOVRucTF3b2duUmJmWjJqUjhyVVkrdU1UUlp3K3g3R2pwU2dK?=
 =?utf-8?B?RTQ4VS82Y3VmdUlMNmc1WE13VEdtc1QrU2lnMHhWTUpFUW5YVHZVbmxBaFVB?=
 =?utf-8?B?a3BGN1pGUHk4ejJPU3pZcHpMUnZucVRxcEVuK2pUcXVWM3NtaUNLZlgwMnln?=
 =?utf-8?B?bm5DZFZyTTgvNGthbkt0YjVCSHozaUkrWVB4RjAzUVpVUmx2Qmg3VlNWYU5s?=
 =?utf-8?B?L1NSQUR0bFBMUHlkT0xSL3VaK2tUckxtU2k0UkhOVW0wbzkxb0cweTNmY1Jw?=
 =?utf-8?B?Q205YlJLaGVsQmxtRW5zWFo0aUpzUWZ5YmtWdUF1K3Y3azlmbUhKZ0p6UjNq?=
 =?utf-8?B?WHNTSVhzYnRmbVhlODdaUHoxSnlzdmxYT3pyWThsaEtPSFF3ZjVORFB6TmRI?=
 =?utf-8?B?TWNwcVdtQXFtQWtpVENnNlpwekpNWk1YS2ZQMmZZMTZhT0lVcTlYOGdjalNl?=
 =?utf-8?B?OWJwVTN4MFFETUJhS3djbVpZa1JKOGo2d0dneHFjSU5TQmZFOUErNG5NYlZ2?=
 =?utf-8?B?ZUVYQnBSQmVPNDFjS1g3anlPS2VkejNCbm43RzVaelR1VHVkZlRNT3p0QXVQ?=
 =?utf-8?B?QlhZdUxkT3hzaXNOQXlLMlQxNFd0WUsxSFZmaTNHYytQT2NpT3hRVnpaZThh?=
 =?utf-8?B?Rk1OcWRPL2lNOVdId1dWQTZNLzZnUEI3Y2JJQmpNdUllY252OVo4aExjTzZt?=
 =?utf-8?B?V2ZKS2JVUHVUWlQ3OGZWMmZ1bWlxc2ZrR1R4R0x1Qjd0d25hb0c0cHI3eFhl?=
 =?utf-8?B?cEU3RkRieGw5dWZzUUlETUhwcTQ5NVBTM2V3QWFEMnRnWmNtL0pMOFpjUXN4?=
 =?utf-8?B?N2VUczBkTGVoYUlNNGFCRDh3ckNkb0NsT0hpUmtKTUVLdFBONjNVNVZxcmF2?=
 =?utf-8?B?UXErdFQvb1VPNndzOG5zNHQ5MGZZMExpb0U2VzV1d3prdjV2c3RNbHhOVTRB?=
 =?utf-8?B?b2d1Vy9NLytCQWd3SXZxdloxaGVQK2ZiQVFVcTBsaDNuVUI3Tng2WThteUM5?=
 =?utf-8?B?R2ZtS3FPKzZQTndPclpmWW1GN2hjaGhEZllPQ1JibDNPaStxSUh5azFvVVJZ?=
 =?utf-8?B?Z3NjekZxbjVxZExhYjJkQ1krWTZXRU9zTEdDZXp6OUFHQnE5bFE2aXorTWd0?=
 =?utf-8?B?YndZbTNPdGVFc1BIL2NyL21IMTVzaThLaFBablNSOHVyMUZyN244NEE2NzFm?=
 =?utf-8?B?a1lITGJpWWlMWjlJWTRSVldPRk1WWVZmV2E1QWtlSTBXbU5Ja2U5Nkw4V1hK?=
 =?utf-8?B?UTNJZ2pveXgrOU1sWkZVWmxBR1pKUm1ob0lvWklhVjl0VHBvbERoZ1RYRkZw?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 643db26f-8054-4fa6-ff6c-08dc59b519dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 23:22:33.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGO0CrNhcING4/KoHGPNUScwKrRbPdvye7IcGUZcsJVW46Iy2pGUzS9kwuIfNrC6RDsvn/B6LGJ71VrHwOnABjJY2pYL4qTwcMQNrSVX+Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com



On 4/10/2024 6:58 AM, Parav Pandit wrote:
> Devices send event notifications for the IO queues,
> such as tx and rx queues, through event queues.
> 
> Enable a privileged owner, such as a hypervisor PF, to set the number
> of IO event queues for the VF and SF during the provisioning stage.

How do you provision tx/rx queues for VFs & SFs?
Don't you need similar mechanism to setup max tx/rx queues too?


> 
> example:
> Get maximum IO event queues of the VF device::
> 
>    $ devlink port show pci/0000:06:00.0/2
>    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
>        function:
>            hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10
> 
> Set maximum IO event queues of the VF device::
> 
>    $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
> 
>    $ devlink port show pci/0000:06:00.0/2
>    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
>        function:
>            hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32
> 
> patch summary:
> patch-1 updates devlink uapi
> patch-2 adds print, get and set routines for max_io_eqs field
> 
> changelog:
> v1->v2:
> - addressed comments from Jiri
> - updated man page for the new parameter
> - corrected print to not have EQs value as optional
> - replaced 'value' with 'EQs'
> 
> Parav Pandit (2):
>    uapi: Update devlink kernel headers
>    devlink: Support setting max_io_eqs
> 
>   devlink/devlink.c            | 29 ++++++++++++++++++++++++++++-
>   include/uapi/linux/devlink.h |  1 +
>   man/man8/devlink-port.8      | 12 ++++++++++++
>   3 files changed, 41 insertions(+), 1 deletion(-)
> 

