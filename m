Return-Path: <netdev+bounces-85902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14189CC9A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AA9B26091
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B661448D9;
	Mon,  8 Apr 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYVSkBL9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8953368
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605565; cv=fail; b=B92zjZLhPv7CsDnEkx+CSSob9iMWtcbSn6dehTl1wq+L6vwftke0KrAZPBwtTuha4ktWeYyUl71fPpMQce2j9yEO0Ncnt8MROAwQ6dPHw/i6XvpNwYyRCeEZWgVSYBo+WDdZ0d/IbGV0FPlPTnKC5QtJr30YTU4Y3ow6wSH+cqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605565; c=relaxed/simple;
	bh=Ig3tK7t++vMc41+dFX7acmKhmTOduhkZSpEHSciMwYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pWEvAlzW6Lqh20WAFRXxPjCj0iM1SBdKHwWttBCfVd332bGM9a8qYxpl3O88Itj/E0IIC2Y86UYle+BlJk80ojLjnovlJ8k+O04sHTOG+ldExAw3j9L42yts+IrXrx9KCNwy7bYbuNCdIZ+nH324Ja+Fj5Xo8jOYuNYl2FQuskI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYVSkBL9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712605564; x=1744141564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ig3tK7t++vMc41+dFX7acmKhmTOduhkZSpEHSciMwYw=;
  b=BYVSkBL9+OccGd1WLoxm9Vaw5A5KL3BrqzXT8Rvunx8PbPjn0c3ljWQQ
   q/xB+dMEa3p/2KF9d1F8GEc4JQNDCEuxu588eV+imyItVpNK33sLaRdiW
   9FD9XNvFuLwiuKBp95/pnDqwEoGmUZmH1uenfwnAlTaj0+pKew+dWdyNW
   e3ZHKVZyqlaTV2GyQP9taQO0AZnUS8ZKvDSHNEogqa5RsBHTm05/+qS2g
   icYk/GYkYDipj7/n3sWiCTCCJVtlFKsW/rJV6r50jiy/Hadt8Xr+/DR0w
   GOjHX+kyHBcazV1yeTSOa69Hc6Na7UQfhhLsjt61hNczDVdmN/r8WRHWk
   A==;
X-CSE-ConnectionGUID: lMUShI7ATouup0Idakc4nw==
X-CSE-MsgGUID: EoQXKbo9TbGVEfWTAigkCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8131035"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8131035"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 12:46:01 -0700
X-CSE-ConnectionGUID: Ym+H6mTvRIe9izjHXZWeqA==
X-CSE-MsgGUID: YWMTTwxJRYuRIz4vFPG/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20015532"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 12:45:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 12:45:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 12:45:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 12:45:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 12:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgOhky39jxMKVKhbzorJIkVrrEFAbb2mmX/E5NRKpYwRSfrQxgN5CwVLjJw0IkjJHGDif/RpVvn3pHHArJvHbH13pc9TagQsK53NZlh3ROPq7JsjpQ7z1qYlnnqVj6ZXbHxn3RitluL8sOnWKSN6QqNiqnJw9BXN1ul33/muwOehV/aT1cMPj2ahwGXLsEr2GdnolvYx11n+0t7JtGbOBx7qE2C1VszwuFVP1OVxbDkczsVd64zg5IUYUVKNXsEA3tpqPv8CWnJB8g7nl4TJE3jyfW+9N+Ob/zUyM9BqyWMBvmSvohflz8Zai2KDX8FOJc2H0wWMvxIFMe1A0m05Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BntF+zZkm/JKOSEN6Q4sRIPZc5SGh+/k8eq8nyHUEw=;
 b=ArwgD46xgP2k9nvPxCeG8pEfKvemKEoaXTy4jOELEb6ThmdFJ43JEJRVe6sekdTfoWYjEZ15bB+U7FsCbMApNLSLpdJfDDIb0jj3BMO0m5DYyAnlTIvdzXQ3wP6Z6m4DiaKhxhfgsla8gVYQxMtmB01cxwfJksCevz81sVipjirqhY83IB4hBj2636PXHMzHNHZ3UwBWgMe1y96k0MSA0qKAT+0RjEaeyL8S7wj7qNLDi1eD5iIKnr6ti/AJCarsN4cSuqIbBWPOFUPu7PEbcM9xSPJBR5Dmjp2CNcaSl6VH2X5LgYweM2Fb86jJFn/YSqixVLhsejwX52sSJ4bXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 19:45:53 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 19:45:53 +0000
Message-ID: <dd842cbd-5282-423c-85cd-a8969da6e814@intel.com>
Date: Mon, 8 Apr 2024 12:45:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, RFC PATCH 2/5] netdev-genl: Add netlink framework
 functions for queue-set NAPI
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
	<davem@davemloft.net>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <ast@kernel.org>,
	<sdf@google.com>, <lorenzo@kernel.org>, <tariqt@nvidia.com>,
	<daniel@iogearbox.net>, <anthony.l.nguyen@intel.com>, <lucien.xin@gmail.com>,
	<hawk@kernel.org>, <sridhar.samudrala@intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
 <171234777883.5075.17163018772262453896.stgit@anambiarhost.jf.intel.com>
 <c6597621-dbb5-4891-8aba-f0596b08e667@davidwei.uk>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <c6597621-dbb5-4891-8aba-f0596b08e667@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA0PR11MB7354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dVEoGwAIYsrMIDX0RyAA1MQxiXW9QzhFjC5IOA8Oc0IJYS/FLAgKIimCMWl3qroVI9hYGpkKrCVIHTppeJuErGX97xE0WUPGBIuhomJQJsFqy3jvcie7D1zw1qcdR9OIe/0Dcj8IsckDRxZucggnNTkZ6dDgYw2gPezKMOf/jyaMsSZQZz6UF7UzB9gyQa5JQAS9H6PywWEJuq1KnGdR7qxXXjO2HA92+WI8Cc99es79JGGNdoav8pwv4NHWchHLdsJs3APWatnNBvKCOXZ+Zfm96xmXmzcvmWvPM5a0hmeje5vkv/f8vt6QrJPK8x8hJgXlCPweKfyvM/RTbf3PACnUQ8jGp8CmGga21dcjvL5Cr6uIoFRKCk6Q8hh4pG/iymv+HmXajybqpd0Ekx0L53aDUMBMr4/UZ7ThLUNJP0s83PKFAyEqcw8exi9QTQtmKriziQK1Nncc6t0R+V2PPkz9/tJZeNYN/9d3744g6EYl0iVA+Vn9KpT9pJ0KcvQpWwuZAEEjk3pNJ7TQh8lPC0a5Dc1ywEoVoSzMV/lQCwPZVmJVYaAc+p3SOTs9HN0SeIKv7nXGp93VYMzObtCZ5WaE9gan2GdDS28+7g7LOQQfeQSqW5mqLHYlVZVcRdQuNjl746q2TcS/HCOyFoo38OxYeOL1AwPON7c2PMw8QE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHNTcW9OWFdtRktVN1o4K3EzYWliMk8waEFxdjNVQVdRck45TG9GNFF0b0l5?=
 =?utf-8?B?d08rdlVuZDg2NVVkYjF6RUNybjZCZ0hHNG13b0xhdDRSbnRlaURaUXJBSVl1?=
 =?utf-8?B?N0lyTy9VSXNUYlkxd1hYVm50WEdHR3Job3ZNcmo2djJab0lDUFJKQTNhN1BM?=
 =?utf-8?B?Q25aSDhhOEI3bEppdWl1MGk0SjhuTGRRZ3p2eUc5ODkyMkJmS2phbEF4b2pN?=
 =?utf-8?B?TjFhbmdsaFltd0J4ODdLOFhRV0tVOTh3YVVsL280Q0xtZEVuU1RqbGxHL010?=
 =?utf-8?B?TzFVbVdZL0c2M2k3T0xFUFhXWmZoYm5rSzB5USsrU3lpOUR3b3dlYmNUbEQv?=
 =?utf-8?B?Um44KzlYcGZkRjNpRENOSVJtejZmM296UEl3WXRnTUc5MGM2UWljRU5nY3Ay?=
 =?utf-8?B?MFVnZkVPM2drcXNqQ001ZkNZMXZRc0lIREpwUGlkV0xXM1NydXhkUGdwZWxt?=
 =?utf-8?B?S3NiYThSVHJIUHVsVWxtNEVNZGswNHZMRzlaaHN3ckZXK2JOc3IxbUl4TWRq?=
 =?utf-8?B?b1dtQ0NZODd2L0RrUGtWemc3dWxxL2tZZFNzSkFjWkw4YVV2aGtvMnpGYkR3?=
 =?utf-8?B?bHN2bXBCWU1ZWXVzL3A4ZFJ2b3AwaGlPSjcrZGlCUTRCbElCdWZzaFlQQSs0?=
 =?utf-8?B?d0FvUEh5RFB3Q0NldzRPc1ZVY0xFZWFnUUczbHlSb2hmdFJZOWpDbDBtUkpy?=
 =?utf-8?B?aWtwOW9ZZlFJSXg1dVhiaHJZY1ZBdDFsT2c1b1lrNkw0Q2x2NGxUYVRZOXNa?=
 =?utf-8?B?MlhrTkp3WmlSTVZMT1oweGt6Z2lxZ0hlMzFyeFIxLzlsdEdWMnRKcTlBeWlU?=
 =?utf-8?B?M3NQL2tWa2RUVDBNNlVOSlBjM0F4RmQ4MGVWZXVuckRVRHBsOHpqcmVRVzBH?=
 =?utf-8?B?MkJBTUJ4Nm1xS2djSmYwTEhyUGhzMm8rdW4reWp2aFZTdW1rdzJMcXAxbmI2?=
 =?utf-8?B?TFlmbHR2RGMxd3dZZUV3K2daTk5ldWVobk4yRjJYbXQyZ1YzOUVOZHN0UG5S?=
 =?utf-8?B?VEFiZ0t4OUt0MW12TzZqTXFhZ3dpUWU5WDlYck5XRWxKOUtpOCtxNDRYbWl0?=
 =?utf-8?B?MzJ2OWsvT1Fha2FFQ01TQ2R2M0tjYk5SOVBxMWdEajUwV0xmQlk2bHh3MnJN?=
 =?utf-8?B?VVlzRGtvV251Yk9nM2VYTEVubWZVQ3p5dC9keG45U2ZXZnlaUldKTkRFVWNM?=
 =?utf-8?B?ZU16M0pERERkWVpVZUlPRHAvcnVYSTRhWUlFc0VuNjByM0xocnNuRWl1THN1?=
 =?utf-8?B?YXdta2ZkTkFiVFBGRm8xeDlya0VCdTNxQ3ZVQ29na1NNSVNsL2Zmbk1KSjZl?=
 =?utf-8?B?aTlkRXBESEZHY1RRdjUwc1JaaUpmR3UrL28xcng0RkhKVy93Zmxqc2M2VkJU?=
 =?utf-8?B?UXFVRkdia3loVlB4WFhTUkpiRDBQbDJHVDExTEh1NkhMdzRkR0ExQmd6S2Ra?=
 =?utf-8?B?VnllL3NBdEdjd0xRTVJaSElRL3NQc0ErWnkyQldCdzAyN2pvZ0FtaUZjamVM?=
 =?utf-8?B?UXJoeWFFQTg0MEZkaWNQRFFXakhEWE5DTm9ITUN2YzdlNlZkV3dBWWhtZU11?=
 =?utf-8?B?b0VQVW00QjRqQ3ZGb1AvUTB2QlBnSzJxa3pRL2hVVEJ3bXExUUplSTNLb2Va?=
 =?utf-8?B?QmV2Z0JkR2pnaXpKMG1ZVWhvVEpnOVpYNHkrU3NHVlh3cytVZU03MWZKNC9v?=
 =?utf-8?B?SFFsRkpjVlY2UHdPVitFVHJrM2pTRWgxc3Aya2hlVHl3VWVaajNrUUJ2WFpO?=
 =?utf-8?B?VjkwV29zbERKek1TbFpldlY4a3VCTlc5YjJSSzB0aWJkVlBVblMwNURnQ1lI?=
 =?utf-8?B?bVljdnpGc2dacnI0bURPNVZwRzRIdDIrVlRFMWw4LzlwRHQzMFhudmw1bXRl?=
 =?utf-8?B?c01OaTNraVM0WWNYZXhEYlVSS0JlV1pNWGNVOGVpM3V1bkdORk5Qa0NBK25O?=
 =?utf-8?B?YlpMYzdxVnk3SGMzTXYxNUxrNEt3clh0WTFGbUVyNXNrVGd6VEdlWmVrNGtL?=
 =?utf-8?B?YXhXaWtiYjFRZHRYbjkwajNGdEVILy93dWZEYllsSnZkS2d1bkF1dEJtK004?=
 =?utf-8?B?SkZQNWd0OXhMK2ExT0NRU0ZlMStKNVJzRE9OWVFYMzlMZVJCWktKMmEvemwy?=
 =?utf-8?B?eFQ3cTY1UzFibDBHd1BUdk1id0srRlQyU3pXS2E1ZWdnZUhmZXNKbDUyQ0du?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 789dab69-a917-4ea7-b02d-08dc5804803d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 19:45:53.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BoJASWG61Vtn/853zBnj0bibkkMVbXaMYsJZ0C4oJ7bjgiyWoMt730cCa4UL+BkjRn3TFumOGKvFqzTpjqB/8ofwVLKj1aZiiBPOkP9NM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com

On 4/5/2024 5:20 PM, David Wei wrote:
> On 2024-04-05 13:09, Amritha Nambiar wrote:
>> Implement the netdev netlink framework functions for associating
>> a queue with NAPI ID.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   include/linux/netdevice.h |    7 +++
>>   net/core/netdev-genl.c    |  117 +++++++++++++++++++++++++++++++++++++++------
>>   2 files changed, 108 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 0c198620ac93..70df1cec4a60 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1351,6 +1351,10 @@ struct netdev_net_notifier {
>>    *			   struct kernel_hwtstamp_config *kernel_config,
>>    *			   struct netlink_ext_ack *extack);
>>    *	Change the hardware timestamping parameters for NIC device.
>> + *
>> + * int (*ndo_queue_set_napi)(struct net_device *dev, u32 q_idx, u32 q_type,
>> + *			     struct napi_struct *napi);
>> + *	Change the NAPI instance associated with the queue.
>>    */
>>   struct net_device_ops {
>>   	int			(*ndo_init)(struct net_device *dev);
>> @@ -1596,6 +1600,9 @@ struct net_device_ops {
>>   	int			(*ndo_hwtstamp_set)(struct net_device *dev,
>>   						    struct kernel_hwtstamp_config *kernel_config,
>>   						    struct netlink_ext_ack *extack);
>> +	int			(*ndo_queue_set_napi)(struct net_device *dev,
>> +						      u32 q_idx, u32 q_type,
>> +						      struct napi_struct *napi);
>>   };
>>   
>>   /**
>> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>> index d5b2e90e5709..6b3d3165d76e 100644
>> --- a/net/core/netdev-genl.c
>> +++ b/net/core/netdev-genl.c
>> @@ -288,12 +288,29 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   	return err;
>>   }
>>   
>> +/* must be called under rtnl_lock() */
>> +static struct napi_struct *
>> +napi_get_by_queue(struct net_device *netdev, u32 q_idx, u32 q_type)
>> +{
>> +	struct netdev_rx_queue *rxq;
>> +	struct netdev_queue *txq;
>> +
>> +	switch (q_type) {
>> +	case NETDEV_QUEUE_TYPE_RX:
>> +		rxq = __netif_get_rx_queue(netdev, q_idx);
>> +		return rxq->napi;
>> +	case NETDEV_QUEUE_TYPE_TX:
>> +		txq = netdev_get_tx_queue(netdev, q_idx);
>> +		return txq->napi;
>> +	}
>> +	return NULL;
>> +}
>> +
>>   static int
>>   netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>>   			 u32 q_idx, u32 q_type, const struct genl_info *info)
>>   {
>> -	struct netdev_rx_queue *rxq;
>> -	struct netdev_queue *txq;
>> +	struct napi_struct *napi;
>>   	void *hdr;
>>   
>>   	hdr = genlmsg_iput(rsp, info);
>> @@ -305,19 +322,9 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>>   	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
>>   		goto nla_put_failure;
>>   
>> -	switch (q_type) {
>> -	case NETDEV_QUEUE_TYPE_RX:
>> -		rxq = __netif_get_rx_queue(netdev, q_idx);
>> -		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
>> -					     rxq->napi->napi_id))
>> -			goto nla_put_failure;
>> -		break;
>> -	case NETDEV_QUEUE_TYPE_TX:
>> -		txq = netdev_get_tx_queue(netdev, q_idx);
>> -		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
>> -					     txq->napi->napi_id))
>> -			goto nla_put_failure;
>> -	}
>> +	napi = napi_get_by_queue(netdev, q_idx, q_type);
>> +	if (napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID, napi->napi_id))
>> +		goto nla_put_failure;
>>   
>>   	genlmsg_end(rsp, hdr);
>>   
>> @@ -674,9 +681,87 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>>   	return err;
>>   }
>>   
>> +static int
>> +netdev_nl_queue_set_napi(struct sk_buff *rsp, struct net_device *netdev,
>> +			 u32 q_idx, u32 q_type, u32 napi_id,
>> +			 const struct genl_info *info)
>> +{
>> +	struct napi_struct *napi, *old_napi;
>> +	int err;
>> +
>> +	if (!(netdev->flags & IFF_UP))
>> +		return 0;
> 
> Should this be an error code?

Thought I can return 0 like the _get_ functions as this is a noop and 
not really an error.

> 
>> +
>> +	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
>> +	if (err)
>> +		return err;
>> +
>> +	old_napi = napi_get_by_queue(netdev, q_idx, q_type);
>> +	if (old_napi && old_napi->napi_id == napi_id)
>> +		return 0;
> 
> Same as above, I think this should be an error.

I was thinking I can follow the ethtool semantics here, when there's no 
update/parameter values are not modified, it is a noop and proceed to 
display the current values instead of throwing error.

> 
>> +
>> +	napi = napi_by_id(napi_id);
>> +	if (!napi)
>> +		return -EINVAL;
>> +
>> +	err = netdev->netdev_ops->ndo_queue_set_napi(netdev, q_idx, q_type, napi);
>> +
>> +	return err;
> 
> nit: return ndo_queue_set_napi() would save two lines.

Sure, will fix in the next version.

> 
>> +}
>> +
>>   int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	u32 q_id, q_type, ifindex;
> 
> nit: q_idx for consistency?

Sure, will fix.

> 
>> +	struct net_device *netdev;
>> +	struct sk_buff *rsp;
>> +	u32 napi_id = 0;
>> +	int err = 0;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
>> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
>> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
>> +		return -EINVAL;
>> +
>> +	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
>> +	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
>> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
>> +
>> +	if (info->attrs[NETDEV_A_QUEUE_NAPI_ID]) {
>> +		napi_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_NAPI_ID]);
>> +		if (napi_id < MIN_NAPI_ID)
>> +			return -EINVAL;
>> +	}
>> +
>> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!rsp)
>> +		return -ENOMEM;
>> +
>> +	rtnl_lock();
>> +
>> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
>> +	if (netdev) {
>> +		if (!napi_id)
>> +			GENL_SET_ERR_MSG(info, "No queue parameters changed\n");
> 
> Could this be checked earlier outside of rtnl_lock? I feel like not
> setting a napi_id here is EINVAL.
> 

I agree this part is a little ambiguous as I was trying to handle a few 
things here that I was not really sure of. The idea was that 
netdev_nl_queue_set_doit() could be the one function to handle all set 
params for the queue object. Today, only napi-id is supported. In 
future, there may be additional configurable attributes for the queue 
object beyond napi-id. So, it should be possible to set those params as 
well from netdev_nl_queue_set_doit(), which implies that, not setting 
napi-id is not EINVAL, as some other param could be set. If none of the 
configurable params are set, display the message and the current 
settings for the queue.
So the code today handles this; if the user has given a napi-id and it 
is valid, then proceed to the ndo callback. If the user has not 
specified a napi-id to update, it is not an error case, display the 
current settings, same as ethtool-set params does (although it's done in 
the userspace in case of ethtool). Ideally, this should be handled in 
the userspace for netdev-genl, maybe some tricks in the YAML can achieve 
this for the set command to check for the presence of atleast one 
configurable attribute in netdev-user.c.
I think, the following in YAML would make napi-id mandatory:
name: napi-id
checks:
   min: 1

But, that's not exactly what we want for set any params, what I was 
aiming for was to have any one attribute required from among a group of 
attributes.

>> +		else
>> +			err = netdev_nl_queue_set_napi(rsp, netdev, q_id,
>> +						       q_type, napi_id, info);
>> +		if (!err)
>> +			err = netdev_nl_queue_fill_one(rsp, netdev, q_id,
>> +						       q_type, info);
>> +	} else {
>> +		err = -ENODEV;
> 
> Could be less nesty (completely untested):
> 

Sure, thanks. I'll make this less nesty.

> 	if (!netdev) {
> 		err = -ENODEV;
> 		goto err_rtnl_unlock;
> 	}
> 
> 	if (!napi_id) {
> 		GENL_SET_ERR_MSG(info, "No queue parameters changed\n");
> 		goto err_nonapi;
> 	}
> 
> 	err = netdev_nl_queue_set_napi(rsp, netdev, q_id,
> 				       q_type, napi_id, info);
> 	if (err)
> 		goto err_rtnl_unlock;
> 
> err_nonapi:
> 	err = netdev_nl_queue_fill_one(rsp, netdev, q_id,
> 				       q_type, info);
> 
> err_rtnl_unlock:
> 	rtnl_unlock();
> 
> 	if (!err)
> 		return genlmsg_reply(rsp, info);
> 
> err_free_msg:
> 	nlmsg_free(rsp);
> 	return err;
> 
>> +	}
>> +
>> +	rtnl_unlock();
>> +
>> +	if (err)
>> +		goto err_free_msg;
>> +
>> +	return genlmsg_reply(rsp, info);
>> +
>> +err_free_msg:
>> +	nlmsg_free(rsp);
>> +	return err;
>>   }
>>   
>>   static int netdev_genl_netdevice_event(struct notifier_block *nb,
>>

