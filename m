Return-Path: <netdev+bounces-269534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDGQE2YkvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:29:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F72CED24
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B48E328CD57
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F33EBF34;
	Thu, 19 Mar 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyDHfOQN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D83EB816;
	Thu, 19 Mar 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937045; cv=fail; b=T4Oh9jc6T3fpotHe79v/RG/CZicoq286IRwLYVTbmri3/I+nAV3o+fwJINHMOSD4MbuVM5xKCral9P/KDUubaqUj0wu43S7gyc01W8XnNSyNLBHw1guhoSJBzPACrVf6FX9BWZRredzIBRT7kGH6sU9s4rBOl0rrPzN+yUaGre8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937045; c=relaxed/simple;
	bh=dKcwOgCEe7/NYDRpym71+kSuEWeBIe1KLugsko89NLI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/FD29hdIPW3cs1kNL0paCtYctSNFIVYKlLzbAN3Gr7kfAVKYRWuajBpov/xMf/T8v9V7WQ47uRSM+TxzKCZDSEZt7Wh4zRz52Y74pwykXxGnV5px4Jl0D4rG431Aa/ygJm99XAROQJYzE9vb+RkEdibMnMKsFcQhiffAXrGxNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyDHfOQN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773937041; x=1805473041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dKcwOgCEe7/NYDRpym71+kSuEWeBIe1KLugsko89NLI=;
  b=HyDHfOQNdur2KbvEs0Sp4daOaZf0+4l/YudZZF369BxulOe+XBnCUyZy
   J45efoQFF9+SQOSb4vUCVhO3WZz9iO9nJY/L+qIl5LPoTIlT67TW8SZz0
   k3yUUql6vuDV2TOH3CXLhJPlDa5EgVwZ5aFRbW1QJmkVcum+L1nIqVIli
   nMe12mS8dx3sWgiHbWOH6+UtuTaD8O5P20xAOH2BCIevmYAO+yqSeH3Qw
   kdbuSNAIvKw3QYK22jiwhYpMXJrQFD07EyotZv12tWNRrIFnEYOu082w2
   r/HMyC0BnxIphYPJMK5JGfK06aaI4PPwIa7fShlK8/I7KJXCBuY+ehUv5
   w==;
X-CSE-ConnectionGUID: lVre0RWJSNOewifkZvZJpg==
X-CSE-MsgGUID: ADGk+gN9RxeKtiLmXwRZ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74716046"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74716046"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 09:17:20 -0700
X-CSE-ConnectionGUID: sX1J/G0bSjOp5wCdguQ5Gw==
X-CSE-MsgGUID: GGmSKWSGSIivz3TNTXYGdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="219966894"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 09:17:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 09:17:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 09:17:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 09:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+99/pN8xdd2PlOAT+cIusihKlklOkOvGJZEoVILICqDjhbjBizfcqMiPr0Z0aA5kpZhwa7ZWEsnu9vfURSKJGUEB/V05ESg9RywJvYMvCaJwEm2PpyQ77LlMUaGcuGwbY74M2EszbVIwi4CwHz94+chqTdKltHABTOR1xGjfBa4XyjYYIC27zjUEop94+L7oBPFHd/ppNunpXK5thr3s0kYhBJoA+237y6WcTVCCLfXtwv10Wohb4Akdpo4SLyMayvFCG8asvNB2qK2tlmEf8yZjEt4ah7xCjZPpI+cLL9TPWWpN5FXU46MthSU+YEle5AaEGJNV9wPWfPuDBN0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dd6MGJ37QtPfaghXKMvmfUQLB6osUIIxzOEkQl3UrQ=;
 b=jFI3yXfjJ3RNxpJ5FuBH5RSIipv0sQcBJRFOVzxdYJL68ywHTHu927cUlzG9VU/2kVqGqmFQ7CUOiAU7I67ouIRecM1+KxWsO2ZEAUbmDwMFPvR65L2Vugh9zs/ox4MyBncw0SisuRVGkRdLA3FSlSAumpuvVX6/dWnMYsUHj64zQlOHJG+kadvIgO5xtBXKl1uUrWHiJwwQ4xQgMtRcMsjjNFZMIDMCcxY7bNdzwZLHbAGUjYADHJvwudHckV9yOIj2ytUhtf+dHqKVqPg3VA/xuz921eAOia90tjVBoVeOPUYQQ93VBdtA9LGsch03zDGS0a0Z4B/ouni/5QlkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 16:17:16 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 16:17:16 +0000
Message-ID: <490b9113-2935-404f-8054-ac496e0e2f21@intel.com>
Date: Thu, 19 Mar 2026 09:17:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/15] libie: add bookkeeping support for control
 queue messages
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Phani R Burra
	<phani.r.burra@intel.com>, <larysa.zaremba@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <natalia.wochtman@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
 <20260317230905.847744-7-anthony.l.nguyen@intel.com>
 <20260318193447.2e7b1f4d@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260318193447.2e7b1f4d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:303:84::17) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|BL3PR11MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e457b53-464b-41d8-14ab-08de85d2fc61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|83080400003|56012099003;
X-Microsoft-Antispam-Message-Info: niw4aLfP2ZLhK2TAqNChWGcx84nSp/pAsSgbakGgZf/8T8w7TF/VDaD3JJ0F8JFJ5FxUEgYBmcFOwrTB2wAcsjgQbqfkGqdicVxzYeySZnG3BAlOwpvZ7jYvtCJ2euXCX6ciQ/bou55IfAA1jz6VmRn8ZOSeeFqwQ50AbzJmLgl02lpGPYddtn4x4txiqlIVWs+LMrEfEh6ATsp/de2uWiPpoMtgbrPYPYuVF/GLWfHhKJLu2MuBgCDJYuhaCdx3tinkVOKC15g4jorrFUzPqJi8JRIgrRXnVSXZO6uO2tuzOFcGAjAl4K+hQ9XWkRwfRjEfCB8vugkiXLgZfBu22SuZNm3w0d8NC/Dj31c4jX6hci6lZHtNJA4ysd05zxCYaErzCdjnDORs8pWTYYSCpOqMQ20xQLJ9Eg5Q2ChXnXN27LisCBjlSztQbqG5afAVQVxF0PlYqFGGfSqJoQEVEamwF5oftZdGTU8updKxKnb9Qs72qSa6jYVboQsxRCrvbVBBqRVqRvKvidrutXaYad09sKNpyb7A0vFCZFPnxNNBwy3loD88y9YkI9ajHFT/WPopWdHuZpXNRm6yyReTNU393asIwP3B/Ifk7zaayfaQGEL1/XXEntrBd2lTgC7Bsk3q7kjlNb0lw3NxboGYJNAbggL+Ixvimc+MIRmZhdCN2aEWxfxLW4lIPD6pt7bVMmWAsBKt80k/IAj2gfYqcb6VeYeFGK63g8WscZqPeU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(83080400003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdQZDllVHJ2WkRjMXhYZHI2YUNwU2E2NGNzMCtKYUZ4SzVCOTZNZmM5WElV?=
 =?utf-8?B?OS9CaWlYMzNreDRCd3VYZEtZQjROK2Y2Z1gzTGlSRGd4UWhlb2I3NklHTVo3?=
 =?utf-8?B?Qk94cnN2bjhYZUpoU2lJTjFpeEpsM0VmSWpYYVpuc3kvcENIOUVqNHlvTXlr?=
 =?utf-8?B?SmJQNGgzSE1ENUFiMUk1bGZRMFBhUWJRamQ5R1BzSXJBUkVYTnpSM254OHh3?=
 =?utf-8?B?MnQvbndTQm5OTUJXYnFiK2VmM0lsZjNkSUs4ZDBtRm1tNXEvYzlJMURBWllv?=
 =?utf-8?B?MmhVOGpHd0hYc0hzeFJyK29BUStJc3pabFFvMzRGSThVOUYvdUFzSk5CVWxz?=
 =?utf-8?B?U1JNdW5SZjNlbnVuYUlUS3FZdm52UFhYUTVNMHpmU2hrbE1FNXlsWUpiTy9Q?=
 =?utf-8?B?enk2Q1dXMllBTXRKZnA0Q0tIak1xTmhJWjJFUlR2ZHRWZVVCU0RsalFJZWJ6?=
 =?utf-8?B?dlVZeXRKck5nOXJENk1IcUNFZjRQWUZZNTRkbk14RlhmL1htWVkzNS96bHhX?=
 =?utf-8?B?bloyTklkOFgwOUNNeVNnaTFIWGJPR0ZOdldKSk5ta0E5Ky9tZUNmMG0yTCt2?=
 =?utf-8?B?QVhZZldKZ2Y2YzFDdWRhMDlOSm4yNmZZanRtVUc1Tis3SDhFSjVvUkhRT2ZX?=
 =?utf-8?B?a3pHV2VhY1dNdkppWlgySmF0bGFXbHZpdWVTaCt4U1JqRWl5bEF3UnRCRDk3?=
 =?utf-8?B?bzJXd0d6TkZnT1NIYXJOMnAxQk43OXZvS3RUaWR2c25NTlFCZ3ViY2VtREs4?=
 =?utf-8?B?MnhMNnphZUZOWjZGQWw3RU4xZ0preEdNVzBaemJhOGdITWJKT0V3TlpBVHdQ?=
 =?utf-8?B?a3ZDaGZkOUxUd1k5bUtFc0hpdjFiQnFtb3pHcmZDdjJDWGFoZ0gzdXlBaTF0?=
 =?utf-8?B?c0U0UVFhd2YvN3FTdDgzN3RWQXR6dFNIbVByOER5TE1kM1pnaEVaRW1TeVR0?=
 =?utf-8?B?djFKS1lKcS9KbGM3U2c3MVd2U2xwclZmMUM3VlpzVU84cEdDOGc1bkNNS05H?=
 =?utf-8?B?azFDRXl1UzUyRExLRWczVVR4ZC8yZGpWT3hpM1lTZUxSM0Vzc3VNOGx2THhk?=
 =?utf-8?B?aE00Tk90TjdXaGRnR2NlcG8rUGJld1NHUzQrb2YxUW9oN2tRWDhvR3lCQ0Vn?=
 =?utf-8?B?ZmJ2dFRjVk1xUS9vbkVaeXJXYnFEanZKYWZaTmJTcmJ0R2VlTlA5THJjTVZv?=
 =?utf-8?B?SjgxbENaN2hXdzBQNDY4Y0ZUNzZtb3kyMXc4SytsRDhzYXNXYWRLWCtvUFRZ?=
 =?utf-8?B?MjNRemlNZE9wVkhtNVB3TXlIOERYTC9pUnVaOTBTS29EZStkNlp0VTNXKzVj?=
 =?utf-8?B?UDRuNkFOTUFHOE9JYVk3U1BGNWtRQ0REVVFvclNKLzNoRG5hRVJrbmdEL2J1?=
 =?utf-8?B?MDdDbVhzYjY3UHBLbnhEY202Sk9QUEc3aHNYVUdHY3N2MjlvaktlMmxkTEha?=
 =?utf-8?B?S2RUaWkyNGZYNlZTbHZvVS81WHFYd2pWeWwydHlIN2hnL0YxVm1zSHJ4TnRq?=
 =?utf-8?B?ZkJ1dk5HQlphSnlBek9PNnpJVlBkSm9ra0NHcGlYQU5Ua1Zsd2tNRCtleURW?=
 =?utf-8?B?K1o0Q2MxN3A1UlRFalVOLzBVcTBZbHlYa2dickg4enY4S21Qd1RNd0dXc0Ni?=
 =?utf-8?B?MXdBVC9FTVJ0LysvN2NNTGNkMm9vbDRucEE5T3BhdERoQVA2VElHbkVXWm56?=
 =?utf-8?B?a09zbkFqaTBwbGxIK2sxdjIya0U1ZEEvOXVnY0FMcVFJSVB6N0t2VUVGZmND?=
 =?utf-8?B?Ykx3dnZxN0d3Z2R5VzRRc09mL0RVN1dxYmpLQmZObVVBV1pLZVZBS0xRY2M5?=
 =?utf-8?B?SERHck56NkhzZ09XUXVtaDRPMlRuSk1sY04wcXVGZEx2bjdZQnZ5MExCOTZ3?=
 =?utf-8?B?cDl0K3JaamdxWVp6aUZTc1h2dWRqK1JBdHlobEhJRnRVdDdGa0xWRElZMHZm?=
 =?utf-8?B?WWxyd1VrNm9GT3U1N1Irb1pIRUZSSmoweTdlY3k2TnpyNVJjb0dVN1RMWGtB?=
 =?utf-8?B?TGRUYTdZSEgvOWNTSmxTNktRYVcwdmVhVDdQakZDMTdQMUgwczJwTmxlbWdt?=
 =?utf-8?B?bC9XTWFFTWhRQnVOQmQzRUJUZVBLK2JhOWk1dW1FY1gzeXBSZjZWMVQwUHRs?=
 =?utf-8?B?czQycTZSZlNENEgwNEU4YnNmSWFJWVZhV3ZiWmZIR0dHdHB4QytYdHFlekpX?=
 =?utf-8?B?R0VoNXhGWWFVMllOOTVkaTRkSHhVM3FsL2l5ZDFGNUlQdFI0c1d1SXZETHFu?=
 =?utf-8?B?b3U3V2RVUjRESloreVNwUEFBbUh1NGFOZytrdFRERUJRbEdxbTZGQ2pVS0hu?=
 =?utf-8?B?bmF6bHN2OEJMN0c4Z2pvQ3hqLzNTeHVLeDRYb3pxa1ErZWxTcXJTUitCY0Ix?=
 =?utf-8?Q?TC7T6PvJpMiwlmmA=3D?=
X-Exchange-RoutingPolicyChecked: Ot9JOEIcJAgriyPlec2wDCs1ISxK2IEubHehd3jhMJ0AK6eiUdxc5SakHuJkzZjb+Qx2b+QkOrkpqCxx+WaIAMu92cSd0VKRBc+wSM+D/oiDY2NaUP/OsvWSLAR6qgKcBt1Keb77qw99gZfIiVrn3U8hrFfZ2bfdU43m0pMFRVL+jXaASIFRtSX3jv/jeIyZaLihG3cOPGbp1SNDfOAtZTOm1BsNYgf2jz47n83MDco1YTRdm4MqADtWpN2W7/YBI7odOf4lswzFnItoPERwVhHit0J9HGhG8/qY/Few5AIpezRFJ484FZCWhQoFz+rPvyKK6asoAivrlaVuRCgC6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e457b53-464b-41d8-14ab-08de85d2fc61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:17:15.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wIsnWfCxVOv9DesFTqs+5jtDk7riqPXBLHLiCSb3HQesWTxSOvMCdaGjrhUIiQc/Fu80vwHdYgbxbxEfLjbnOXHURZkMxGa3fzd0UrcHp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269534-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A34F72CED24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/2026 7:34 PM, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 16:08:54 -0700 Tony Nguyen wrote:
>> From: Phani R Burra <phani.r.burra@intel.com>
>>
>> All send control queue messages are allocated/freed in libie itself and
>> tracked with the unique transaction (Xn) ids until they receive response or
>> time out. Responses can be received out of order, therefore transactions
>> are stored in an array and tracked though a bitmap.
>>
>> Pre-allocated DMA memory is used where possible. It reduces the driver
>> overhead in handling memory allocation/free and message timeouts.
> 
> Warning: include/linux/intel/libie/controlq.h:397 struct member 'force' not described in 'libie_ctlq_xn_clean_params'

Will fix this

> Please also look thru the AI reviews before you repost:
> https://netdev-ai.bots.linux.dev/ai-review.html?id=2078570c-9d93-4076-ace9-f275d8637314
> and:
> https://sashiko.dev/#/patchset/20260317230905.847744-1-anthony.l.nguyen%40intel.com

and look these over and adjust as needed.

Thanks,
Tony


