Return-Path: <netdev+bounces-183007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD282A8A9EB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B645B7A8FD1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00862522B0;
	Tue, 15 Apr 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rxz4N4Zv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655F21D5A1
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751646; cv=fail; b=dSGSINsxpj5RQKIuryU64GkjNMmZhiemHddFKJXQw07YVHOled40SEAfJ1mt0kYEk/xKoy+aKvuBZNsF/5Qqnt+gcjU8UaGkFwoONMQG0LbrXK9ul2xLaKFPl2aw7Yifk1ru/wGAPk5g2phIatCYvHbn+e/EvvDzqDxmDQmotMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751646; c=relaxed/simple;
	bh=aRybb10PfqNLFSGQB9apiTedosMJVLXXSX+sD0mZIOM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFLQg3aMQ67z9J0/LLAXiV+5duMvDzn5Ik41g+ZluC13S3BvDsM7HhWfYBxiriLyD5L+pNdy2hWQNlwC+wwTBh/ZDyIkToCesklEb6gG+59vbUj//WCmThiPnaiyN6MXKQSpt975IMnC1206GZMQihY5k2dTLNNNUmVAFvoHH3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rxz4N4Zv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744751642; x=1776287642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aRybb10PfqNLFSGQB9apiTedosMJVLXXSX+sD0mZIOM=;
  b=Rxz4N4Zvh9b1VgdwK7/FqQ5E/yg8w5csg5LMsGwrUi7bWMkf8+rIhkqr
   FGGJMxvgMXnelblDC6JMBq7g0vp6qz8KqW2pSb+ecvdIEUulBSjmNq+O0
   g9bN9wopeWgDVMkpbcbA6tLehAOXUOpQb8L0UEG5jc2Jz1++UVjV4RlMp
   AZwfVsHIcMQz8of6KBOh59zFnpTqeq4uTeDdWJDL2KRxZrC6sTEsy1YKg
   qO0McC976ZWhr7gdCrknqtfv5bjMCGl7I0tVIhOymdXUG24nFbPu+pQEd
   uvzbOQg6jUJ1m0lJssR3f8ZPTLWmMUSeieQlG81J5+uIMQsQnCdmxLTnA
   g==;
X-CSE-ConnectionGUID: yc4I3mSUQRitosDL9FCN2w==
X-CSE-MsgGUID: 7qT+8eNGTl24z2FDQaosEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46409464"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46409464"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:14:01 -0700
X-CSE-ConnectionGUID: 4JVJQYUkTnqe0uju9SbaGw==
X-CSE-MsgGUID: 45Z9G5bySYaywSCW+lHvVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130777004"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:14:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:14:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:14:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b34J8hcVhya+8hkyPyNPm2M6JoVqJ86unOP37Z6ZTgO09lyI1J1oV6u1SCtVvZR0I+E8w1g4nYiFIGLUkxfJRoJGO0K+IHxTXONO0Icgi+c7AOYJ66DwniodvtgHLX5RKEViYzOSeicJoKEfndur4rrDeWkVPEgG7Tpgp6yBAuc5+ORJCAgHpxFC59t1EvdaEXd+4IJnP95Ad14rGPSTdpqPA4c/F19mHBHlip+IYBmABFj1KrinaJzvv8IpjTK0vFdoBN3YLbsPchxCqN8lrg4YXhe8xnJUxaOUwzwRJj5NW8oM9TrP46uIOkRwVuaFjt8uyDhsm3fvt5YhK+2vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFuPEkutp5GiaJYaGWx2BETOqDoWxBBzbpXbdaY+C6E=;
 b=bIQe9XOE9UxaIPk+FjsOx9hkoQj4HQWkPGytPhJbMjKaMi+eu+Vo9VEK32Zc1NG/Squ76BvYXRYedqtHLPZCcwPUmDPdmousru9b+aDcTOQnDs3mv37uM4r4vKP3iG1UrHuIkCmxnx2S04b8LbblZCt6HpRFUiTnbLLOLpPHF8NxD1wQtcqYTEiaKKlwqJsTT+Rejctj+ZDtHcZSzOevxWmpoJK/T/zZ8j4lUZsKoKAjQqOvdcYnUin+7WtY9S/vSbSebp6a4Dh0PdeaGTVn+hBJYZKRvHGm42nph+YjpWHdhnv7mOOVBBgVcM22eLfue0VGfmuthaos79jRDA0mRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:13:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 21:13:30 +0000
Message-ID: <9e2ce5d8-1ccf-4b3b-871d-4c4ed2d6ea46@intel.com>
Date: Tue, 15 Apr 2025 14:13:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v11 iwl-next 05/11] idpf: negotiate PTP
 capabilities and get PTP clock
To: Milena Olech <milena.olech@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, Willem de Bruijn <willemb@google.com>, "Mina
 Almasry" <almasrymina@google.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20250414104658.14706-1-milena.olech@intel.com>
 <20250414104658.14706-12-milena.olech@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250414104658.14706-12-milena.olech@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:303:8c::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 54db567e-f303-414f-fdcf-08dd7c625f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVFWWnR2bUthRlRxNnBmTDJYZnB4Qy9reVNWTUNWZjFSczlwaDBkK3Y0SkJr?=
 =?utf-8?B?Y1k2MlRCZWdpOWZDSURhcTUvRkVDSjBQNkxOaWFtSUNuZlhLV2xCS09CTmxC?=
 =?utf-8?B?QjhPU3hWRWtHSXFUTng0cVh1ZE1sSEVaZ1BNT2NONjJLZ3p3NTloZkg5allL?=
 =?utf-8?B?djRaL2lBRGsrdVRLWW9neHBlbXhQSGVYS0lXaXpqVHFnQmhyV05CVnlsMHJL?=
 =?utf-8?B?eWdnc2x6SGlGTlBhSFNKcVFMM3VrNUdsN2YxS2ZsemtoeVB0WUJmMk5ieGFR?=
 =?utf-8?B?Ni9qbGxLRmthYW93bXpuK3o0Mkg3RVlrL3EyaU1MYnd0R0RSSm56dmwrV21O?=
 =?utf-8?B?eEQ4UGJ4ellxRzM1MkNLa3VmZTlOOGJBaG5rMlVxZ3lnMW5iK3lJSCs2R3Jp?=
 =?utf-8?B?NXdqNDFzSjNWVDkvODFwZTFWUmMwcS83eTg2VjFXZWpUNW1iSzVoN3N1K21O?=
 =?utf-8?B?QWNMUjZIOUMwZFRrVkc0blE1aXBoOVdxZDVQY1J2Y2hHVWpSM21XRnRZOU1K?=
 =?utf-8?B?TXpGTzFUTm5sUG44azhteUYzWGlqWGwwQ0VsdXVINzY2ODVJQnZ4QlFqRDdI?=
 =?utf-8?B?ZGRtNVdWNGlFRURIa0pCN2llVmZGZnpRK1hYeVZvVG1BUitqY2FERStpL1Jz?=
 =?utf-8?B?VHBKN2xIVDQ4ZUVFc0VCWHV3aUNHVFBFc1hDRXplVUJoVEplTU9vQ3BIbUxD?=
 =?utf-8?B?enVqNkx5MHBZMzdEVERjMVlRRUxJVGhrTnFhbnB3dzlUMmxpYytFb3pSTmcw?=
 =?utf-8?B?VDZlMmV0bnRYSEl5aTlKM201SXUwOEZ5TzZ5VFkvR09CbU5zamNUUzNiT1NO?=
 =?utf-8?B?cS83ZHV4L0RNbjdMSjd6cFBSQ3c3T003bStzb2Z5LytaaWViYlZHVWxFWVNm?=
 =?utf-8?B?d2J6ekt3YXBjeStpWEdCTFlad2JjSlBwZElCUVdBdEZGTHhIaTFvNnhDSW5y?=
 =?utf-8?B?Rmw4a0FnY3hMdnlOV1paTlByVWZFLzl3OW5rdzAwVkpzK3lSZThDY2JJQm41?=
 =?utf-8?B?alVMVUdGdUtjZkRkdGVZcWwwclpKUVVBVElob2owTVE5YkZDSHJiMTJEN2tL?=
 =?utf-8?B?QWZYYXA3NFUxNklzN1UzWHViYW55NWRiZkNsWWlRZUF3MHFqalAxVE9iU2o1?=
 =?utf-8?B?bXh0TjFjVTVDcjJMMU10dnZsM3VtM3ZYbmdxUDgzZFF6Ni81N3VtL3B5Uitp?=
 =?utf-8?B?anNMbWNkWjVlaGdiSmtja0I0V0hmUGYzKzFIaDFjbUZYQ05tMGQ2M2VUSFo0?=
 =?utf-8?B?N3RHK1lZdEdLeXdhcEkzTlE3QjVKOTZld1crQ3VhdmVLMGtXemVHcCtNV2FM?=
 =?utf-8?B?eTJzWWt0ZlZjZDlWS05DOFR4U2Z5Q0pBSy9QRWJHUFBYZDczODdnZ3M0Ukdt?=
 =?utf-8?B?S2x0QTRjOWRMVk5tTmhyaGhrRjRyci9xZ1pVaTFoOHdvR0x0b1EwYTBRVGJW?=
 =?utf-8?B?TFdmUkdsWWZ5amRiMEtGMWVZeXFNdURHZE8rWS9Sanc4K3plaTZXcDFiZURt?=
 =?utf-8?B?QVgvbzhHbXM1dC91WmltSHhlLzNDdjdDVlNHdWZjYmFyZGdZblhQZEZEdDhq?=
 =?utf-8?B?QXFXSVRCSWZkMHBXV1E2b05rbm1uR3piQVBQLzJPbEhFdFVQNVc3Ukswb0RJ?=
 =?utf-8?B?dkVOZFZvajRRYkpLNzMzdXcva2x5VThWbzQxZ2xSQm51VFgzdjBYSENtdEhO?=
 =?utf-8?B?eCtNL1pVVDlrVTFNeTQwRHNrTlJ4YWJrd25NdERVQVhqMUtBSUhIRTRXTVNt?=
 =?utf-8?B?VTNHd2hIMTZnZE8yVStWVjJicFVYZ2RRRExHWUVmZC8vWlhWRUhGT0J0YUlV?=
 =?utf-8?B?c3NBMnk1R3Fwc05WNUkweEFtZnFWL3RXMHZWdFpTeDZaSDZuR1lZR2YyMzVj?=
 =?utf-8?B?SHJXUy9aaWUyZmtTNVRkZnVPa3dWMFBJWWtPQUlobDdwYkJlbnNBSEhDTGox?=
 =?utf-8?Q?JztFJZquoPw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhKVUNyWDJKSEJGTUFCRHpXbmRFZ0pBbjI4SzF6Ym0zUko1SlA5TVk3U3dU?=
 =?utf-8?B?aTkyUXpTd1dYclNWOXVSSnRqd1RITHNlc0oraldSMCszdDBpTlNLMHlGVnli?=
 =?utf-8?B?cXBoVkIxM3k1bmlyb2d5SVR2WDlMRnJaaHZ3Y3M5aEVyUDRsZUJpQnNoRGlm?=
 =?utf-8?B?NEM2blBFd2FGWThpK3UzOTIzd09Pa01CLy9SMTZmVXo0MXQ0ZndvS3ZCWThK?=
 =?utf-8?B?bTYvTll3b2tjSXFYNXRvaTRKYWFCUUw4MjFGM2o4aDJEc3YwUGpsVjJqcXA5?=
 =?utf-8?B?TlNGMHgzRDMyWTkyWUltVVhwNXR2Wnp3Sy9PKzl2MGNJQ01XZGx5MVRYcFI4?=
 =?utf-8?B?RmRJcTZlUWM5SUxCNUpJU1BsTWZLNmtUaUhIK0s4cDhmTzM2cEZoem1LRldV?=
 =?utf-8?B?M3drbXQ2YXJXMmtBY2VVMGpZWXNNK1h1WWJJeWpjS2dJQncydFQ0dzJKS09w?=
 =?utf-8?B?ZGNuUU1GaHBxUGc5V0h3ZGVjeUp4Sml2d28rbFZ3TlZRSEllSVc2VU56cWFK?=
 =?utf-8?B?RlJzS2FDMGxqYWRPTDZsZVBEQ3ZSTkFjdkJLWFNRRTBoWmtxTUE3ei9yTS9R?=
 =?utf-8?B?MmYvUUZSNGZubmlGVkhFZ3NEUUdjVjRVa3gzOFFtdDBxVkRCVnI5ZWtiL1d2?=
 =?utf-8?B?VjVIWHl0bWlUSzdHd0k4YzA3aGRiUk0yd1JDa2xZUWlvUW91YmtkbzQxYmFG?=
 =?utf-8?B?T0Fwcmx6QkYrTWg3RU9OL01CVEpSQ2pSSExuaWN3RHAyS051UnUvZjBCM3Ay?=
 =?utf-8?B?L2JMU3dxRmpkMFVGM0FQUXB4ekppYXNkVjVLc0M1VWJFMERvWFJpKzZ0QUlx?=
 =?utf-8?B?UWVhVTJtL21qQTdNeXJzR3BwUVpaZ09sMUw0bTI4OG1Ua1kvNFdyekx6VUJW?=
 =?utf-8?B?MjJaYytIR3RaSHplU1ptR1h6c3JUL0JWeHcrTy9rSUhqcVZuYlNZOHR1M2RU?=
 =?utf-8?B?UTdWNjQ3U0ZZcTRhc3RoeDV2aktSQ2IxVklkS1I2NGN0VEg2TFQ3NG9YZWVG?=
 =?utf-8?B?YnBIUWFIbk1OWFlPYk9WRVdtbWM5TUYwaHlrQ1krNllkVmg3TjVHd1AwUzI1?=
 =?utf-8?B?emZOQTBqSEdKT2xQNDd5SGgwUjZ0NkZoazRIdjgxTWdUcjF4QUVhczJEUXhJ?=
 =?utf-8?B?SDZ4RkgyUHMrR1E3TmhyTFJqenhBUGVJNVRQKzR1TTh1WlJobGgyREY4NDdO?=
 =?utf-8?B?OUJzWWpTKzZueTg1MVlTSGltSzVNL2VlWUJNcnJhOEFqOUxrRkpFV2paOGtB?=
 =?utf-8?B?VzJqSWFDYlRkTXZSVlZOS2VBcXgwVE5qaWZQdEZIUkJrSFRjVVZMOXVLWHhH?=
 =?utf-8?B?cTN0OUduTFo2bGx2RnJnK1FCQkZXYTFMZVlWMEZYTVpYT242cFBFSlhrU2d5?=
 =?utf-8?B?WEUyeTYzZkFZcWtkdzNTTWdyVFlzUlJLeEM2Q3V5U0RQdVVrVVdDVWN3RDV0?=
 =?utf-8?B?NzhSTmU0eHVIakg2QzVxc1ZYamJWNjRubzlDdDI2WjErQUJKYnUwNmljcmN5?=
 =?utf-8?B?cTQ4dlBTV1FVTDhMOU4yY3dYTG9TK3dyd0tSVkh4VTFvQUY0dzdocEQvVEQy?=
 =?utf-8?B?a2g2T1EvbmNzN29vRW1ScGlqUlRSTG1ITUJiSlFWZVpTV1ZGL1ZqMXlpR2hu?=
 =?utf-8?B?M09lUGpBK0lpcVl2R3Z1bFlnVDlTN1RreklXTkh3RitMT2FaT25LYzJYTUdh?=
 =?utf-8?B?dldwL0x3dWs3dCtGcnZqTXhMUHBCTEx3Zm5GS29uTWlhQTZqODBxbzJyOFNO?=
 =?utf-8?B?WVVhTkxQL1RscG9IQ0MyRUFQL0IvSXBXWFVFK0hqWS9rZmcvdFgrbXlmTXAz?=
 =?utf-8?B?SGVVUFgvNXVPQ3Z0alF5ZmFBUW5JVEpOMzNCUmpkRkl5Ui9NR0R2TjRydno3?=
 =?utf-8?B?R3NuZG5MM0ZqWTFJS2JmVm5XL3VtUVU3Tnp3THh3TkpnMzBJaHdLVEY5M2xz?=
 =?utf-8?B?RTdBTlRVaGtPSm9PeXFBOHAzVzVtUGllMnZqQ1hDUXhUbEVKQnc1OGVsZnBF?=
 =?utf-8?B?cjNCV3FWZlpJRXlFOWxxcVYxeWZ2clY2Yk0rcDF1aFRwS0FhMU1FV256YUha?=
 =?utf-8?B?eDFuOHZZai9PckVwVmVjTFp6bnNEaXZGYURGS3A2Q2l4SE03L0NLZ0EvSmZF?=
 =?utf-8?B?a1FwaXhsM0hCSytYd0txeld1ZmQrUDhUVU9UWnJIMXROU2RFRk84VGhWczBK?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54db567e-f303-414f-fdcf-08dd7c625f04
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:13:30.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXvcUq87Pfv5vQo3DYbxdYlIxYKTRncSi4jEfWZTUGeVeYnua3UM7IcIx/tGYY44Xh4i0EaPmdCF7kz+NyulTLOyI3bgM4WtjZs2Awy6d9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com



On 4/14/2025 3:45 AM, Milena Olech wrote:
> PTP capabilities are negotiated using virtchnl command. Add get
> capabilities function, direct access to read the PTP clock.
> Set initial PTP capabilities exposed to the stack.
> 
> Tested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> ---
> v9 -> v10: remove cross timestamping, add spinlock to protect device
> clock read operation, change device clock read latch mechanism
> v1 -> v2: change the size of access fields in ptp struct,
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

