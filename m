Return-Path: <netdev+bounces-180594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B332CA81BFC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5AC1B67044
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945BE1D54CF;
	Wed,  9 Apr 2025 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/xIJS0T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50F171A1
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174872; cv=fail; b=auJlFviJctJV+ptsxvwAJESeInr82pw6l6s15MxFGNvQ+i1Hnl0AF+lBZiOb4TTIf11Oq5UsqpaEOfoiFXaD/w9E0/CtsqRsMi4UVZ7sUp738nMru/RYTKGkmUDaflFcN65RznyaaIFmxe/G9JNx/UVVGXPL0e9uCcoXukpOKSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174872; c=relaxed/simple;
	bh=gzKVoqfB34T/qvSvk+GFxNeYg6Ii9gqEdNOnY94WfRM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SsXuoX7s6pbzUGJDiVmNQla4L5wOYUy+yIUvWVIrrxblgKiKD7pVWHdT9Y+KwOmClDZGmVcJ9qQSgDEsivMcCFZH5CSiNi0sZm53Evpfzw7/IpyfqnYMfbhq0KirRe5x/yDkK+ev1XvjOWbOVmYHNNhH3gfUnDLU7GCEeC4C/PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/xIJS0T; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174871; x=1775710871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gzKVoqfB34T/qvSvk+GFxNeYg6Ii9gqEdNOnY94WfRM=;
  b=B/xIJS0TaAlizJ6zfLCjyi/42oKz5QgH2psoQ6n2kAkkTwHmNPstdvMT
   AiegvaL5Ws7GdV0iFWhJWp2U7NS/V7CbEoH2FA8f3eqUZXlaon6bMEsTh
   PGABFpUBBcF4/Zu8u6pMH9ZqFxu+Ef/VtexFqeAFIfPunn7pvsullPGpv
   MiHsczhqumsJAr6RsYod/gUrg1n/5mRvRFZYYILKmme3gCsYcIbdoApp4
   jYpmwfwMzYQgGgdXuOsqDkzxLbcBl7/UQn3nyu4di+pN0wotK82U/5MlI
   0IEhroJRTGb1fKx746GQzstinry3qQm4QuVWBcuuVD5AR9jwGx9abUIHm
   w==;
X-CSE-ConnectionGUID: hJsllIdITNe/BVpihapBJA==
X-CSE-MsgGUID: crkK+KzvSRW0HYvzmOCoRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45752763"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45752763"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:01:10 -0700
X-CSE-ConnectionGUID: jWAL+B6ETj6x6hIHiaiKPA==
X-CSE-MsgGUID: 1gaPX1RiTg6RwctW+KO3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133452685"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:01:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 22:01:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 22:01:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHdWWl+VJ6FUMpk4IaZ19lpvbT0hhDmV1uEwECoeq06kdR70/ermSKK/yc1mkLP7u4UdiQVNxm9TposPvzprWKgV4cKPl3hsqande4dAQj9/syQMrR1TpUBqyc0dl5fu6l34+ONMRB1Af2MxcIlm9Z0TUFy1LD+JZ6Nctdb7sx8TgIlFlotlquAdH6Uj9N2PqGGBG2//RM0RFu/RGhf06JY+W2Kq1EVnba7enqyegwHbQy6yoTccx8CH/Cm1qndzZRhjp68GdWDxK7zsZhU+Ma16voPeiYRahI4tAvuKf6hVY/Ibig0bxVrPujo74i9PiC0/TGKx1aOCWhHqjRVXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3u89MR/WX5pPhfRdEUbbV03Tc5dBp7gS7004I2P5vI=;
 b=fMhQNo6XtKkE6CQ4+ogvjtx/LmnC6XFdAWj6xM7iAs6F+0un7eI0sw9LuCS4El5OFWvBcpLwDE/WMnI0aFYhOqGR6fYX2ZXjmMQd8fhPprj6vdm35SstxrzO3A0FzcsgEDdtFtEju60RCAjWfYVkHtDhNZS9v7HEnOfcxe2fjx54ApPDpfJ9ZRVabTnbVjkVJZt26IufWzgBP90OgEvyAZGDeBHtwhUAFGLXg90nPTXwcmPqqzy1lIF+RH69fzMNU3HSIxzgWnjfPm+15m9sfRA5ScKDvp0d6NM6NGfUzSNS2DHJPtX8M3CSbjKarjnozGqUxN2kNy5dThrJMR8aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 05:01:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 05:01:05 +0000
Message-ID: <3dcaa591-6450-411c-9fe2-2ceb106260c6@intel.com>
Date: Tue, 8 Apr 2025 22:01:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/13] tools: ynl-gen: consider dump ops without
 a do "type-consistent"
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-11-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-11-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d90c0b-e2e0-406b-f420-08dd77238860
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEgyU3dkQ0NOU25WMWlnUXQxdEJjV3JSQlZMamFiVVZ6ajRCYytaY3BkQkY1?=
 =?utf-8?B?djlMeFpkWG1mSnVzNm40aWFDbGNIMC8xdDVBQVRKbnlkQkpsSzZZU2JUVkRD?=
 =?utf-8?B?U1Bwa0grYmNaWU1oNzNYaHh4aFVLS2FqeW1iMlVMa0xVR05PN2Q2Y09FUEgx?=
 =?utf-8?B?emFLZUpwRmxZSm5LUnNpRm5Wc0JDTTRBRExtVWZLdWtUS29WTXRnMis2bTg5?=
 =?utf-8?B?cURvWGwwLzhyQXdMZVc3em5RR1dERURiNncxY1BnQUlMeEV5eUcxSVBZTEY5?=
 =?utf-8?B?QmR3ZkErRzFYVDcrc0RLMEEwV3JPRm42Yncwb3o4bmgvbFdWRkN6MXFGTlVP?=
 =?utf-8?B?c1NSV2JkdkVvWTg2YnNlc0FmL3FtYXNuRjBsQ280RGltRFQ3ZTRMMjRRY0RI?=
 =?utf-8?B?bGtkM0d3dTNDNzVsc0JoUm5zNW9nWFYwK3FFNXM3RFJwbXR2c1BqcHQ4cDd1?=
 =?utf-8?B?b2owZXAxT1c5NzFHcTYvbllLbDdwYy92WjdPOWp0WWZhQTg3UldBWHpCcEQ3?=
 =?utf-8?B?clRmLzlwVG8zRXZHRjJsQ1VzSjlqcCtYSDFUZXRzSS9WVnZhR2djQlFuMWpw?=
 =?utf-8?B?UG9XQXNnL0VoUVpZbUdqeEllRDdlcm1NYWlJQVVxelRWUXR5NVowYUhMRDY4?=
 =?utf-8?B?TjlUVFd5bmgwdlNPQVdOVUJ2QmZxSWdOYnMxUmUxL0VYYmFGS3RWZWhsZERh?=
 =?utf-8?B?RGI2djFFdXhiWjkrNWZhWEw0ZkxleVVHdTNTUW9LbHV2VlljV3BBUVl0UGxB?=
 =?utf-8?B?ZkpmZmRjaVQ2RzNTOTNJeHBiWnhnOVpVMTUycDJ2TWlIa2R3dzhNVld0dWtZ?=
 =?utf-8?B?NzV3eXNBT2d2MHhuTi9vWnZYYnQ3UjRDZEFiWlc0QVNxNC9CcXZWSVMrOTV6?=
 =?utf-8?B?OVRLSmNZamhHUkNXYUtCR1lTNTBYWWYvSVVZcWthckxzeHNEcGkzVHR0RU00?=
 =?utf-8?B?MExhSXZlZWZ1YmpLbytDZGNBekdXR1RxaGxBcHpCNDJHbExqZHBTdldpNUR2?=
 =?utf-8?B?RTQvc0w2dUsyYk9aUG0vcEZQUVc5c01YWVFQQmM5aTFaNldWZTcweUhUM3Qw?=
 =?utf-8?B?eWxhZmhQR1YrT1gzTWhzOVVTSGYySnJocVp0TkZkSUx3VmIrQWJoelpDZ2Jl?=
 =?utf-8?B?amV6VXZrdzJPUGY2TGdOMklEZGVUbUJqZG9SdU5FQXpnOUMvcjRGeTVzd0dN?=
 =?utf-8?B?cnVTdU1jZ2ZmaktmNWRVWUtsOGlCdFlLY3hHWlVnODZPOXdvSWZoemlGK21o?=
 =?utf-8?B?K0loN1dzSWExaTNvVnQxQnR6ZitJWldsZmNPQTlaMWxCT3lrNEE3MitqUkFK?=
 =?utf-8?B?OXZVVW1oayt5YnRLR1ZUQzQvMzFpWjdLQ0ZTRGhuc1dENSs4ZzVSN2pYOGlt?=
 =?utf-8?B?TCtTRk5wUVZNSHZaK0hCVUNzeWhiejI5YzRZaWo0RmQzTU5aY2I3QTFYWVhE?=
 =?utf-8?B?aldzajVrZmdMQkNrMTJhblFPTXo4czVVYzVmb3hEQ2dzOTBCbzREZk4rSk5L?=
 =?utf-8?B?WVJmSVBKcCs2Q2FxOGJMaTRNTFpTWnVVNElDK3lmUTNkb3drZ0g5RWE2YUJr?=
 =?utf-8?B?N0VDcnA4bkF0NDZpL0UyYTVjTU1lb1Vud3l6UVd6QzZ1WEVNSjJQRStVWDJG?=
 =?utf-8?B?SDZxMi9EUzZBQm41L0NCL1BHa2kvL3ZET2U4aFdEbXppR3JVbUQwOGZoMzlJ?=
 =?utf-8?B?Y2N3cWVOVWVwRUtSQ2gxalJxbHljK3lORzE0enV5S0pWZE1wRHpKNEp4QzV0?=
 =?utf-8?B?cjY5aldWcGUwOGpWSW4wdTBHdFJ1M2xVT3pSYjFEOW5OSTZYNU9aWmF4RXp5?=
 =?utf-8?B?RHNmbHFvazBRSHlhRFk1ZmJ0aWtlOUhoU2RocHRyYlFNS1BUY0oya28rb09p?=
 =?utf-8?Q?hhug40VtnBlze?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNucDJmVlRNTE9nOHJyL2JkWDJLcXdpUlZiMkM3a2czZ3Fyc2xqbVZFUi9j?=
 =?utf-8?B?a3BCSklYNHFyWjJJZzBxZXBqMkRCdkxOSEJSQTVuQUpmY0RiY0ZGbjVMY2o5?=
 =?utf-8?B?eHI5clF5ZkhBU1lxWC9FRHB5cjZyWGZ5YlZIUVQwdzVQWHdwSkRqMFZqMG5J?=
 =?utf-8?B?ZFFTdUlTcWpxVXB6YlVkM0ZsL2VSeFY5UllFOGhKMWt5ZjVqckFDNkxqbWhu?=
 =?utf-8?B?OWJwSmxyWVUyS2dSUG0weVlaTm5UajZ4cnF6dFMzWnBWdTVLNU1IWGM5R01F?=
 =?utf-8?B?OWNBUU4rWDdkVk13UDF3TEdFdnl5VDF2ZEVDU08rT3RrV09vZ2Q3U2JUZExm?=
 =?utf-8?B?QUZ3bjFRcm1iVkRyM0lXckZJSEdSekIrbm5ZTmR4N2JwUlIrQkJ1UkxDZitp?=
 =?utf-8?B?VURVOEZuTEpnQVZGRlJKeGdNcDFCeXRoYXluaG1QMzZrcHVxdlJmT0RrU2Mr?=
 =?utf-8?B?Y1ZNYTErSVF5WmhKSzUwU2FWMkZ4emVlUVZ0Y0kzTVlnNDMvQnJoeHB1eUI1?=
 =?utf-8?B?WnhYaCs5N1V5d0VGTkpWQ2NaM3gzbEpKUmdhd1lDbTJtYS9yYjFJNGYxVCt3?=
 =?utf-8?B?RmdxM3FIZ0ExY2FvQkJqSk4xSEtLU29EOU0wWndwamhLSE1LUm1TaG1CQTkv?=
 =?utf-8?B?aEhzR3FiY1I4SFYvdTdiMFgyVysyMnk1QngvV3dySHlIK1JFYUFjTTl3YmRD?=
 =?utf-8?B?cWtlS2FlaXh6L01wcUJPekVmaFRRYnU5T1JhRkdXMm1kejQwVmU2NENlQUtP?=
 =?utf-8?B?Sk9samFEUDhxV2FFcG9aVzVzVzhIbjkwWHY3TUZ2YmxLZGo0WnVVYWZRdDhS?=
 =?utf-8?B?Mi9oYVQxbU1qc0RwTGpjcmNpVEphcWZrNTRpSTMwdDZadHV0eXlDOFptdzha?=
 =?utf-8?B?Zkt3b0plVng2cmhVcG9iOEpsSkhMeGpGazdpc0NYTkVsb002OXZiNHhwOWE3?=
 =?utf-8?B?VURBVzNvQ01rSlBUc1N3N1FHdHBxQUwydDRpZGJqMDNtVndsaTBZZTh4dk9D?=
 =?utf-8?B?UjVUeVZBdHBxYnNLUC9NeTlFLzBMeWo5MFVIczRRQ0hTcTlFemRHZk84OEI0?=
 =?utf-8?B?aVZVRExCY1Z6L3BqVTczMmxELzc4RWY0QWVsQVp2MjNvSnZMT1FTdk9ta0FG?=
 =?utf-8?B?eUJrVkR6eW10U2RRS0JxWWl4MjJBUkVTeTRBbmFmeDdkZjRJWHhjc1VvdEg1?=
 =?utf-8?B?TkFMdWpQaVJWNllOMjJGNk1oWVZlODYzMFdBckl5UElRcHgyNWtib1FtTlp4?=
 =?utf-8?B?RUh3bEltQWdWdXVHcWlOZFQrM3BQaGFYaGpWV1docmZodnMxRFRZcnRMS2Qz?=
 =?utf-8?B?cHpvdFZidVR6bmJrR0VFUmhZN2ZiU1ViZFRwSjBKdVdCQktqamk5ZEtMRWFh?=
 =?utf-8?B?dHFEWU5QUldpanFZTjJ1QWgvbFpZSlJ3UTQzUkh2NEdyTkNaZlNub09HTStV?=
 =?utf-8?B?SkQ3ZjBlaGVEemVOLy9jRGZBMkFZS1hmN01HRGwyZnNVMTZCZGdIbDE0OElR?=
 =?utf-8?B?b0JlckFEN1FKVHc0MHg3U29OWFBYVVBPUUhtNmJaN01IWmpScVlHM1dYNmg5?=
 =?utf-8?B?RHFyZkgyakhUUE9IVDZGTGRwTGJuOUN4Y0hoUGF1UkhmSmYxcUY0cVRqNWNx?=
 =?utf-8?B?TWFuelpINkFIRkR4WTlxLzlVcmE0Z1ZOMGJTSW93ZUVzOW0xcjJEdlNsaTk0?=
 =?utf-8?B?MCtKTWtCK0MzdDMyN3U2Z3AxNFdxdDBJT3FvL2JBZENONUpkc0dJYkI2R1FI?=
 =?utf-8?B?cUM5RlpKWFJnVlM0Q203eU5OeVZqR25KRGJ1dHdqZFpSQWZRVTZDMG5VS08v?=
 =?utf-8?B?S21FRW1tNlNUc2lVakFMbU5LSWlndnozaEFqMHpOUzVkNU8veFlrNk1uSkdX?=
 =?utf-8?B?UGFyVjMvczF6dkVHU0hvRzRqaDEzSGxBMEx6ZFR5amhGeWhscmFJUjIzMWZC?=
 =?utf-8?B?ZDlmU1VxNDc0TFpCZ3dvWjhiSmNZbGNOL25sN0p0T1pmdG01YTk2V1drQTJJ?=
 =?utf-8?B?L1didG9hamNib2JlZlBNVEpKajQyOTNYT0Q1VTBiaVM0dXpUb3c0OU5FQWRs?=
 =?utf-8?B?aVkvcWFHeWlTTFR6U21nUzBSbWpCTWUvc3kwc2dVM2E3aGx6cWFjeDFVYnY0?=
 =?utf-8?B?blhlbWhrNVdEWUJlTVZIZEtFZElQd0IyZ2xzYjJ2VW9LOThENkUvSVAzN0dm?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d90c0b-e2e0-406b-f420-08dd77238860
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:01:05.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6XEGJPSpSGg3+K+kuG6Heby7Zr3/1hRwqEeQ5xn5eSpl1qDEqbn6FpbtoVGG7wU0VuFEBICO7zTwJohaMGx3qYermH/IAKy65kvP1HkrXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> If the type for the response to do and dump are the same we don't
> generate it twice. This is called "type_consistent" in the generator.
> Consider operations which only have dump to also be consistent.
> This removes unnecessary "_dump" from the names. There's a number
> of GET ops in classic Netlink which only have dump handlers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

