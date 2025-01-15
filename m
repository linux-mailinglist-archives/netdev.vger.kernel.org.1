Return-Path: <netdev+bounces-158414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F399BA11C24
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D8316273E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618D1DB150;
	Wed, 15 Jan 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SllGt69Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00123F286
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930226; cv=fail; b=rmER5srenfV2DhmqPOtGTn0+bNWka4UlZoBCw2mgUEAnHnw0my8+AoWF4ABN/K8j6qrcQRMZ/NtFkDJs5d0+xHtfVjfi94JOX3kym+J80FQ/dfpqtmG4jzp/29VNLHS83NM8QHWu3B6mAO2JLo9S2MZEd/AMWKzqoxJujbEVe/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930226; c=relaxed/simple;
	bh=sta4sSxzy+z7bMDOxmlhVo0/qthX42C5fya3KKPOw14=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GM/BeaGcM3ibBqBIOoxLtjeo6JPPAPDUgJRDqZkuaUAT7swWk3Mc+tBsUE+per3DZmp9gsP3ArLqaklAGdCCKHC4Pgo4aRvtDMpsvfZNH2jBJKaLZLXh60+sMCKDITa63pUK6iSlvZ0lYA79uU7/Zj7n1l72xhvJT2Bh3hr2L+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SllGt69Y; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736930224; x=1768466224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sta4sSxzy+z7bMDOxmlhVo0/qthX42C5fya3KKPOw14=;
  b=SllGt69YaqUv9IQ3iRwfW5m9W6oCdA7AeEBQuzvxM9u2rpYpkgPrKnGq
   5C5seXanijVj5K69cKuvR2CAOUDp8Ydxh8pnXxGsLtFIHNGvQKP82NW2J
   n8NmXFrbOff9WYAadMFctmZP+Pf/WFsK4qRjtCLL7PdsCB+rt/nWomGQL
   bgi6qLTj6PXMQ7mKoWqdLBC6cA2NmjR7uxF6tlOS/a92m57jOQxTpC6hf
   sVQ9YSkCKZA3ZN8ShELgZz3SgpK3benlca4bnk5sFDuHyiQVJMJDYelmA
   o+Ga+TECFq+RZ7FNEWgtiVELsh5c9Jte2SlYmRTljL5KR69V6TPUcBJQ4
   w==;
X-CSE-ConnectionGUID: /CWiIZsrTX6uEoiInFLukA==
X-CSE-MsgGUID: AwWHLMCwRzKIipnSnlVB+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36534570"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36534570"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 00:37:03 -0800
X-CSE-ConnectionGUID: mHR3LSGrTJqWUHzsXpa6dA==
X-CSE-MsgGUID: lieY2IAAS6+zNXk8FXq5wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105252143"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 00:37:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 00:37:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 00:37:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 00:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwGwPXvOu/UsIUlQbOjC6BFIzIu0JkUlh8qMJCvnZYoBDbKkEoV+ocbVVPcX0SqaIj6qGTj9jBrFVF6/V6rU2JuxwaRKWjmVxjbMdsQ7w6CppklkHj0GedR9Nh7M0CYfV0Tk3LL1+7N48bUTg02cDYMmd+YJ9HRSgT/SrhtZJ0cLQ4hbeBGn4PdA+xsg/0O3QkolAIYXKybqZUV3wlNHqPfBcwgwLsETtOHw+sDQee0HPZLUMHa809MtGR9/YiouKULylJw4U/AVsRCBVUwB0vGYpba7l5Xb7LAqTfUDvWXXdPjkaGnu7m/bjA5vu0QlOylpXA8Jj5jLr6bIGFHuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8IfHVftyBF/GjfTC/9hSlDAdaIRtwpiIHsazqSnVPI=;
 b=zG+fxAU0lt5wgAyhK0nEH85j/v8jDJS4KPyxnWiE2IHDBfSZQIUn8z0eIvMUFuA5QLG1UcCKKMMVLyx8Stf3BKJX/dPGQdQwvhG5huZvVyl6D06pKcEuz5o98Ap3eaMHawDl6CGUG78gKiIthMc0zaIx6FKDGDJM1vYavgOKBku0+n/JJZjUySUfljpxCh7ItzxCzS81hpAZseB0+0s9zLcd+aefNQwpHlJgLyWEzQ+l4//4CWo5JkW3JTngqmSPdeJUGDeGcjVhN9B4XLdfEA8xexJ1cMOl0LSEDHTmzfQl3Hzzngvp3SgJpGgwlVpigxplbGSmsEPA9uicVVXGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 08:36:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 08:36:17 +0000
Message-ID: <e7479c79-525d-4796-b9ed-7ae2ddb5435b@intel.com>
Date: Wed, 15 Jan 2025 09:36:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] net: add netdev_lock() /
 netdev_unlock() helpers
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <jiri@resnulli.us>,
	<anthony.l.nguyen@intel.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <jdamato@fastly.com>,
	<davem@davemloft.net>
References: <20250115035319.559603-1-kuba@kernel.org>
 <20250115035319.559603-2-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250115035319.559603-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0016.eurprd05.prod.outlook.com
 (2603:10a6:803:1::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6a7d69-d698-4662-ee78-08dd353fae25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckdRNVJtTmhjcFRmNUU1V2dPRFN2dlRoM0hMdEd1bGNwdjNGdGtUMUJsN2Vh?=
 =?utf-8?B?Q1k0YkNvNElkVktMWU1HZmdMVytGbHo1bFNoMFp2UThydFZ1aUZRVTdPWXZW?=
 =?utf-8?B?MlNmcWloeG9jRmNWaENWcGVJWnlSSFRpZGNhdENjeU9BYWtNSld4SEREZThT?=
 =?utf-8?B?bUR6dGdiOEdmWnVtdnNLc09aeE5POTJ4UUJJMEtsM1lRTE9iSkhsdXFBdWhE?=
 =?utf-8?B?ZkxvNXZGWjhvcUZFOUNpVUZ6T21JbDViZGdIekVkcFZqdWFBMzRqelU2TktR?=
 =?utf-8?B?TzdCQ2pPeWNhNkxEdEFJaXBQU0M3VEJaQ2VqMGpxblBXa3lrY1F0dVR1TThy?=
 =?utf-8?B?ZGpiaWRxR1FiNmxkbEY1NStib3AxajRmRm1RRG13VGpGMDc2Q3VBUUxHSHB1?=
 =?utf-8?B?WG4ycm50WS9hblBzUVM2dHUvT0pTN1JnVElwQ3prNWwzS0V6LzFWY3ppTEtT?=
 =?utf-8?B?NWVuaDVoVklZaCtjRHpJdFM3Vm1hL2xmUWdnUUMydWdNQ3hIR05oQ2VCbXdq?=
 =?utf-8?B?RWlHUURNcENtWGhOOXc1bkF2djdodXFEWmZrcGh0R05uSFhJRWpxVk8xWXVy?=
 =?utf-8?B?bElwYTFXTlp5ajZGdElNSmludFdML01QOGdYZ3c1NnpMSzM4MUlVckpndExF?=
 =?utf-8?B?S1VraDdoM2hRNVI4UTk4VURVL1ZKMVBzbE95YTFUREtieWZYTmh3MEE4WG9L?=
 =?utf-8?B?Y2luYzNyaTJ3T2tOSi84NG5iOTFja3p6c3VWNkNEOC9tN0dGQnUrUTM3K01M?=
 =?utf-8?B?VDVBWUQyQ1lzMHpWMUZmZHd6MXl0K0wyU1hDZldndEJEbzhwSFl5SndIWVN5?=
 =?utf-8?B?V0hxSFBzekVjWFFNajVaMVNRUGNHc3E5cGs0YytrNWx5MUk2RUhJeEJJTXVK?=
 =?utf-8?B?MC9lYkUvUHJLQ21rQytTcGdCYjNlWnZMYWExWXI0WkJMT3ZvZGlmYzRlTXhI?=
 =?utf-8?B?NGEwQU1OOXpHLzdMdTV5NmVqYlNpZk9oQzkram9FQW8yd2EzNVdvSGFHbWIw?=
 =?utf-8?B?aWRieGdWNXVOT0Z1ZDV5Ty9wU3FGYVYweVBNaFlZQWRmdHVFNUk4N05aWnpU?=
 =?utf-8?B?WVc4Znp2Z05OYU0xaTU0K0Y2M2RVeWlvQUJONEpmWDB2NG9xNmFKeEdhM1Q3?=
 =?utf-8?B?cG1tc0hKNGp1a3pVeUJqY09vYnVvY1pheldraDZaL2RrNUxndytoSmJaeEho?=
 =?utf-8?B?RlFaMHo1OXVQU3N2SjFEV3FqSWhTaUdzZmh0d2lNR21zakVlNk9uOUVMTGJG?=
 =?utf-8?B?N3VZRjhpSk4zQlJMa2FyZWUvaEdPT1BRbDFKUnBJNzZIOVk4K0lwOEZBOUls?=
 =?utf-8?B?NU9xWVRIeTVvWjZiZWQ1N2xuNmdHb3JRenZzbzlHc2JsVFVrOWpWYTNPTFY3?=
 =?utf-8?B?aUdpaGgvSlFjSFQ1WWRpWVU0RUxCQTVKRTIxZktjODJYRlRrOXBHYnQxeG9h?=
 =?utf-8?B?ZGZsRCtadkdzN25mdVhYS1U4Sms2d3VSWklQb1FDaDZHUmFON1V2OFNnT2Qx?=
 =?utf-8?B?TmtUWmNaamFIMis1blRPNExINm40VXdobjl1SXU2d0N3U0JLNnNRKzVFek02?=
 =?utf-8?B?MUo4cjNhWmVCZjUzMXdaRms0eXgrWk5Wd3U3bWJnNE5heEtEU0xWTDNHOVJp?=
 =?utf-8?B?aXJrVHB1aHFTZjZRTEt5K3VUTmlhZy9xVEhBdWZraCtXTGxTTzBGaFYwMmZ1?=
 =?utf-8?B?REtMTkoyM1BsNzdvSG8zbzAvVUoyTlpDdG0vWWNxTmNEcHBkU1h6ek5RYk1C?=
 =?utf-8?B?RWhJUUNPRE54c1RUTVRwS2Ywc3V5RExRTWF5K3hvczZtc0FpNkkvVkltSmcr?=
 =?utf-8?B?K295amxkemtKQkhGNU9kdzkwQmxNZTB0UE11L1owTWl1V0FDSnlTV29SVWpL?=
 =?utf-8?Q?fYx+ITxHMJKv3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9WcHRwOE9VS0VzamRlM20vS1dab2Z6MUJJZFZEbmV5Y2tjZUpxbkU3NFJY?=
 =?utf-8?B?dUtNbzZlVVFyeE00V29PM0RtUE0vTnhxdG9rWmplZFc3dTZ0U1JXNlV5NlNM?=
 =?utf-8?B?OGkxZFFZZXVzMnZZQ3NtaE9wK0JySEQ2UGpBS1huSTUyQjFYNFR5UWlmdzdW?=
 =?utf-8?B?KzlraldlSzhnV0ZCMmVmZm9YQ0k0b2tDanV4SFhqd0lVcmJKMXU5QytiUnR5?=
 =?utf-8?B?U0wyaXIzQUV6U3AvYndIblFOZFpZdU9nRExjNEMwOWdQVlFVeXh5MUNGZVZs?=
 =?utf-8?B?dlFwU0pRTmI3UUM3M1puSTFsZEtCc2ZPN0xrZVRCRUlRODhXM0tnK0RmMm01?=
 =?utf-8?B?VWFHd1ZQSzZwMWVGV0NPKzhrZy9XN0tQOGZuNnhQL1h6SnBYT0VzZjJkN2dV?=
 =?utf-8?B?UytabVNINTBwMG43dkJjYzA5S0hzNW1QZWJtNDU5YXlrVmt5UEpHUEpMMHBj?=
 =?utf-8?B?NWZDcEpMVzZXVDlSVmp5c3FzWnVlNFFnblpMQXZ4bFROWUExZ2NHRHp2NXNv?=
 =?utf-8?B?NVVIeGNwUUpHcjF0enJXWFBlbWViNUlPeGtXMUxtVDVHZ2QyeHQ0a0o0bi9X?=
 =?utf-8?B?MVZFTWVuaFEwRzM2a2swa3BDR3FLQzhFN1J2c1Z1bkh3UmNKUEYxb3VNaSsr?=
 =?utf-8?B?aWo3Tjk4aWlYdXhVYTZXb21zaVJiWDNoTEZSNjdGNXpUdUZoZ2hVQWJHenVw?=
 =?utf-8?B?TzAxOVpaS2lHdnpHS3ZHQlQ0TzU0alFCUmxzRE5EbWVzanRWZnlxdGtVb2xj?=
 =?utf-8?B?cVUrcDBXbC9iS2xUN0RwTjluWFpuY3dTMEp0MCtVQWFzV3U3VS9ubDNHbUky?=
 =?utf-8?B?VVBkbDhFSThtOUpNY09YR3BESU93OXVHbDcwNGF2RjE3dUVEWE9ja0NhWTIw?=
 =?utf-8?B?cXc2Rjc1UmpjTUlqSDNwVWh2bm0rOEJKQkhCVXF4ZEFRb2J6K2hMWWdoUmI4?=
 =?utf-8?B?ZXQwaWlTY09yRllqUzlJbkhHTHdTenR6Z0czLzJCRk1ocTRYQThSL0txK0p4?=
 =?utf-8?B?UzVCOXlTOWRmRmZuaHZJa0VmeDVEZTNQV0JSTGYyUC9PUHE0d0QrTDh0bzc4?=
 =?utf-8?B?OWQ5RVAyRHdsak9KZlNIa1BLa2Jja2ZIWmlJZzRpODViM0crR0M3SWZhTTVz?=
 =?utf-8?B?Y3pWSGtFT295MGJJOE5RSDBCTXR5MUtNd3lqK2kyV1JkWlJpWVp4STZtSUlO?=
 =?utf-8?B?ZjJxdStCUUFGa2NueHlUUU1TTFE4UDk3SSs1Ym51aGNwYnZqMVk1MXlVbmtH?=
 =?utf-8?B?V3lTZ3RaMlE2L04vMjVUNEtNQUo3eFVUTTZ4YjNVR2M2eUQzSE80cVB1bGdY?=
 =?utf-8?B?WVJsWE93dmQvVTV0clAxRmloaS9GQVF4eEJOdzJiZUFEay9kdkJxMGxmcldz?=
 =?utf-8?B?aCtHcWVQWWZDZlRCNWRMUW5lZjdPeW5nS3lYNjFkeEplU045akE1aFFVUDY4?=
 =?utf-8?B?YldwYVUxZ2wwVllpR0xVLytidElRMDlWSVJqTnU2ajNENDhRbWx0M1psUEwv?=
 =?utf-8?B?SFlXdnd4OUhSRi9QRERyVFQ3cUZqWVRKRW5nQWhRNThIS1ZPRjhDSy9wZlA3?=
 =?utf-8?B?bzY3QmlGQXhzM0Y4ZHExYzdSbFo2cEZhblVHL1ZNR204NzFjOW96TTFXRXJ5?=
 =?utf-8?B?bFF5OWpUby9yTEdPSjRkb0I3a1RzQnRJbWlrNUZlWDZPMkJaTWl1eG5uWkNU?=
 =?utf-8?B?K2pESU9hdU5mb1pzbW5udjR5c1ozME5Ib3hSVUcrS3prVXlFdUMxNTJzeDlM?=
 =?utf-8?B?bTVYQkhXNDFtd0RDR2Z1UG5qWGt1RHB6OGhtbTdhNkFVWlhmeEhVOGYrRDVR?=
 =?utf-8?B?aDF6K2VoSHVEaFlFU2luYnp2Q2dtdXFTOXZtWVFxcjR6bUNIY1RJQ2dRNjdh?=
 =?utf-8?B?MzJEbURBdWNBdFJTNFc4eDlSZ1JtUjZsc3Bwd1ZVNDlWZU9lTEg0ZHRxMUlk?=
 =?utf-8?B?SU5LS1BuWmFGTlRuVXFzSE5LSFhCM2pOVkpwT3FhY3FtMFZNalp2VjladDNT?=
 =?utf-8?B?QXduL2cvbG0zTU5yQW9JYmFkaSt4SkdaeUpiUTg0YnJZQ0lDeklMSU9TUnhj?=
 =?utf-8?B?VTJaWHo0OWRNK1pMZkV6YUxEV1dRMXhIVDcwdEJBVlBUTitNYytCUXp5WWo5?=
 =?utf-8?B?M1ZmelZ1VE1qOWphM1NIeG1PRUlpUU5vN0cxREFDVFJqVDczWkExaHIrTFNZ?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6a7d69-d698-4662-ee78-08dd353fae25
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:36:17.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJyssMRAgmslT8l2hA5gABUdW5SIQOWaKGBmf+VLJwpRuuFJ17KNn8dBVk7dq62P1CEXsXthOsTPQv+zlIxO5hmGwhTrs2jW5HX1CB4d1s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com

On 1/15/25 04:53, Jakub Kicinski wrote:
> Add helpers for locking the netdev instance, use it in drivers
> and the shaper code. This will make grepping for the lock usage
> much easier, as we extend the lock to cover more fields.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: jiri@resnulli.us
> ---
>   include/linux/netdevice.h                   | 23 ++++++-
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 74 ++++++++++-----------
>   drivers/net/netdevsim/ethtool.c             |  4 +-
>   net/shaper/shaper.c                         |  6 +-
>   4 files changed, 63 insertions(+), 44 deletions(-)

Thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

and Ack for iavf too

> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index bced03fb349e..891c5bdb894c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2444,8 +2444,12 @@ struct net_device {
>   	u32			napi_defer_hard_irqs;
>   
>   	/**
> -	 * @lock: protects @net_shaper_hierarchy, feel free to use for other
> -	 * netdev-scope protection. Ordering: take after rtnl_lock.
> +	 * @lock: netdev-scope lock, protects a small selection of fields.
> +	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
> +	 * Drivers are free to use it for other protection.

As with devl_lock(), would be good to specify the ordering for those who
happen to take both. My guess is that devl_lock() is after netdev_lock()

> +	 *
> +	 * Protects: @net_shaper_hierarchy.
> +	 * Ordering: take after rtnl_lock.
>   	 */
>   	struct mutex		lock;
>   


