Return-Path: <netdev+bounces-221366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E4B50531
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841B31BC8575
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B719340D80;
	Tue,  9 Sep 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jb/bPIhS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751B352FF1;
	Tue,  9 Sep 2025 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442402; cv=fail; b=eIn124B0BjlGQVm9rOoFiJ6mfuTrbxpPzifj5a/DqwwvIeFU2qH2FjY03uLrS9RSDhlG5v0Xtm1IguWiT1ZIK+HA3/25XAH6Zxp3Wa1oIUZ+O9XVPJfx1SaXSZpyTOF4oQHg2yrocBZFmvGuI5z9tWwyiDxoYzuhyVlDWBkOAgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442402; c=relaxed/simple;
	bh=m4JcVEKjPSTR4S8CqMXcrj57r01NvFFFPDwd3ZYCba0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRAI1EzxlQuL4PyGj9Zsl1xy534xgpRFAFrbIlrh4tM5FpM6tACtvFzDyVY4i0LwjK+x0ZJIu/b3JMv3foEpF7uMa2jJXr82ZaE6OL3n7VIVr07YOSQg13Pk11ajAxYUOBeIIuZhSrDhJsDNOOA9kpeCTB+zXVMD5xSMZYnKIkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jb/bPIhS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757442400; x=1788978400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4JcVEKjPSTR4S8CqMXcrj57r01NvFFFPDwd3ZYCba0=;
  b=Jb/bPIhSDKbceuVQm/bGYs/ciRIx2FZ9v2f5QVVLnru2oqlgXPL4QzJ3
   H9raxl8nKp8KkYa8aLYnGijQ0QERuDGSpxOZE1+DUB0WJHNywGmsn2pQr
   uNo8u2BCKCrh8RRGnGmXvxAnEOsQKrYvmPnDyrvmJVTH+eLYsjhN3eYgT
   fo1v+bGn4r1gvqZFtzTDEcaqpqT5ZSv2EoTG1BShVss2Mhn9d7HG2VT9E
   P7m6+TkUlk47m+HORhIry0nnH1CXlyc088zucHZjVzWjg5lEiNUfOvmLV
   /YOmppQaRYYy7hGe9Y/cMc8FlJOCPNP57qi7HwsShaR8mtR+JnsN0Vg2D
   g==;
X-CSE-ConnectionGUID: Rinz6OozQ8iihsqUGPSHog==
X-CSE-MsgGUID: DIP1xCmeTfKyH0HEimKBAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58954359"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="58954359"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 11:26:40 -0700
X-CSE-ConnectionGUID: lYIZ2rpCScSVWb3FmLRXeQ==
X-CSE-MsgGUID: Vn7W9b8sTUi6aVCMhEVDXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173023810"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 11:26:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:26:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 11:26:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:26:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkloZ9yxS+9bEhjYfv6Z8yYj/cQvtgMoYPgwratWNvAoeeOCgGGM0XWgk1VCoxxQun+Gt70TEi13azF1p1nT4MNGSbSqXKuOYb3GjdjmiUap+6nu0J8rFQaSB5dUkUIsWwKWoqeffle7a85gpMYgESgSHbvWBlw95cR7ISb0TD80hty5raAwvxlu1eoaQ/XZSmvt+5zQL77JP372xPF/8B7YRqKagyMISoP8htl9GQ69PZt2x9ZgtcMI7mbZhsAJIa0iz7ZfErHLrVIdhv0UQA26O34SUSkLmERIvBV0Eaygu4d5fqC+L/iXpWMCYZeCmNSceGLt7MnRhpezGr4KMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPocS1x30vRFIK4VRe+ABMw8BgTUh9jJKoHEU+0EYec=;
 b=tg2R+fwI3ik3r9HSWQ9wRdfS0PQyRlJo7rLAZydCGLkAhPUFIU7+V5vWeFfnCW8GXiPamdz8Y4tayFKbVNg6M7x3o3PRFvd6ww2a9cRJQSI+cwxOigMF9q6nNG+qHo0wfU6rSh4cODxOKJN8FxsJFoG/KIyGielKqQygbD61NNdohe1t881y35P/Fgux7dWdFVUPiwfbwo8aD8bTatW8ObPjsgh+NZWttIfnR4dYtpUQk5dxh3k9C1kRmh3VnBtU121sSJMoR0hggwvNakDELIMw3XpzoR01sFzb02jbwxPFLHzRx34Whd18q94wGNlHiJCSC8Gsuinpq6AM6JfTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59) by DM4PR11MB6213.namprd11.prod.outlook.com
 (2603:10b6:8:ae::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:26:35 +0000
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e]) by DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 18:26:35 +0000
Message-ID: <63959a5f-a0fd-4e75-8318-4755fcf6e9a7@intel.com>
Date: Tue, 9 Sep 2025 20:26:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
To: Joseph Steel <recv.jo@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
Content-Language: en-US
From: Sebastian Basierski <sebastian.basierski@intel.com>
In-Reply-To: <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0298.eurprd07.prod.outlook.com
 (2603:10a6:800:130::26) To DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFE396822D5:EE_|DM4PR11MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8875cf-3168-4249-3fb9-08ddefce6874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWw1K293QWlERC81Q21XZ2lpQThvMjB3b3I0cFJhYW50TU5DNDVuT0xxV2d5?=
 =?utf-8?B?NCtvcFRHYnZacHpjeTVQbFpaOVFYU3FBNElralpmb2l0YUIzNEdZTXord1gv?=
 =?utf-8?B?NXl5ZWd0NlJHWndlamhMZDh4RERoTUZMSjFCTTFJMVZ6SEJ6UHdjbGlZZ1RQ?=
 =?utf-8?B?YS84Q3hadC9lT1ZPTTVLTExuVXNOODRaRkowOTdkZ2IyUFJqSXMvYjdScU5t?=
 =?utf-8?B?MTlpc3o1VmJON05RUno2ajhzcDNlYU1ETXIwYnk4c05ZbThaOXBDUk5DZzEy?=
 =?utf-8?B?Vk0zTFdYVWJ3QmxXV2Z4NFFqemM3WlNXN1hPNEpQT0VWV0g0QkJoZlFHa0gv?=
 =?utf-8?B?ZVlEeHJQeU5oS0hkZHJwSHVFYlo4ZDlHYW9JNFY0eEk2Wlp5TnBFZFNlZUFu?=
 =?utf-8?B?QnlZc0VzNzF0QUZuOUs1b2JjbmExWUltaVltKzRHMVRLTzZwSFliSTEzWlZo?=
 =?utf-8?B?eVFYQUdZc0pRTTduUVYxaEo0WXBNQmJ5SzhNMFRzVkpTQSs2bXo2ODJ4R0xW?=
 =?utf-8?B?eWFud0NFSk82bjZlOHFxUGI4VWtjWE9XeTFPYTZ3K3FmaWJoR1RldTV4N1Q3?=
 =?utf-8?B?U096SUdnMUdmMWIyRkc4SUVJY1JpamZiUjlBcFZrWVZCZXBOZTJheVZ5THA5?=
 =?utf-8?B?UEwxYjdmT0N6MHFSRzVES0JLUFZ0RXFXSldkaDJtYzdMMGlvaGlobmM2bml5?=
 =?utf-8?B?ZnFCSlk1UXNrdStPbEFxRFJhdGw3WnVRd3c4Y3IyZE1WS0t6U3FpT2lGQldo?=
 =?utf-8?B?OXdSd2dNZHp4M0RWS3RjeFJpVFljUWVYaXc3NXg0d2V1VE1YMGV3ZFpqT3RX?=
 =?utf-8?B?RVl3Si85dVBSck1MakcwS2FjR2pMeFE4S0xxUzBZMDJFdFFQa0dwa0poa3Bm?=
 =?utf-8?B?VXZGZUU2US9nZ0kwOVNBNDNLTlJhUkZtWEo2eGxMTXZVWUR2akNGMk1XM0Nj?=
 =?utf-8?B?SXFZdEtUT28xcVhCSzhIK2ZCcGNkK1ZvOTV4RVhsUVFoWWhLV3J1WlFSMld4?=
 =?utf-8?B?Rm5ZWXhsZUVWQ01UUFdmdU4rdzY2K2M4RG8vK096bGcyWTVxUHlEamNwZTJR?=
 =?utf-8?B?dGVyS0ZnUHR0OFB2Q1RuVjE1UTd0TUF3VC9CbnpjTW5JRVJVQzVxeDA1blRm?=
 =?utf-8?B?Y2RsNjJSOFNoZEtqa0FPbGxKaS91Vm1jbVoyVWlCSm9wNDJWdllIa1B5d0Yx?=
 =?utf-8?B?ZkU2T1VrQWc1bzJIL0NRaUFmcUVEZ0l4Zlo2NzdVUmEybVFNTE5aYmNWeTRU?=
 =?utf-8?B?MDlpN3pDbEF3TlZmS2JCb05qY2xyRHFjZVVOWm1jRG9pSkNYb0dDN2p3Vndt?=
 =?utf-8?B?Nzc4a2lyUUJhRmwwVFRYdklBSHdraU56SmFWV1dJT1ZHSjI5Y045UGRaVXhl?=
 =?utf-8?B?d3FnQW1BcllnKythMEQ4dnBUUFRnd1VWK2k5NjI3bERMbW5Ydm84TTJxQ2s3?=
 =?utf-8?B?aGRhTGxKMENsT0ZzNFdYRUU1ZnVzaElKQUd5Y1pLdW56Vmp3cVROZHNzRTZE?=
 =?utf-8?B?NWVTOC9PellITlZUWWZlbUpBTjVPbW1XS3FRRWlmb2hrd0I5WmpyUG4zWFVm?=
 =?utf-8?B?TlBUMWNxaDk1bDVxZWFpSXR6cWcxSGRrdFkzeG8vWEtNY21lU1QrMVQ4L1NW?=
 =?utf-8?B?SWhRdVB1Y3hZenhZOVdyVnh4em5BVW5UYi9wZWFBYnZ6TC80UVMwMEswZzNn?=
 =?utf-8?B?NlVaK2hzSDBYVlhiVnJjYVZqR0JaWUJBWXNncms3MmVmRERHQnkyeXFyTkMz?=
 =?utf-8?B?R2NQdHZvVmRkQVV0MWszYU96aHd5dmp3VzFYZ2FBcnJ4VEZFL1FLdG9xdGt2?=
 =?utf-8?B?bi8vbUFkS3p1VFo5T1VhNWttRlcxMzEweVIxT3RrcnpEc29CbGFJZVRSOUtO?=
 =?utf-8?B?Y2hsSUFoVWdrOEJVQjhUNFRzVUlnNjMxbllDWFVwdkVlVE14cUhZVWhRVmJJ?=
 =?utf-8?Q?NKDwrkS12Yw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE396822D5.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am12NUVpcWlPVDlqZWJjV1RRblhBT1Rxd3lSNytXVHMreHBjTHFvcC9wejFu?=
 =?utf-8?B?VkJnUkE4U0hra1J5SnlWQkg4NGtFWExZT0pxRUc5ZGFhMzB3ZG1QYllvZnYr?=
 =?utf-8?B?WmhYcEZZd0ZhTk8xck9URFFzdVJ5TndVdFVlK1lUS1M1bWVxNDMrQmNQNmRk?=
 =?utf-8?B?M2FFTzJKUW92aVBhU0NSalJkeXo1YXA1cEdHWmVXUVdmcmxvaFJSUUl4cFlX?=
 =?utf-8?B?b0lJTUtvN2ZsNnlIeFFaQS8yV2pDamVBRGpXUk03a0xwZ1d4TVpRTTZ1eEc2?=
 =?utf-8?B?T1hoVXBxQkxlZE1NSlJwcGdJWHptMUplSmhKclNuR3VRa1dvdTRSZ2dwYU5V?=
 =?utf-8?B?cGM4bFoxVmtzUGYwQXZRcitsVWd1eXhMU3RsM3l1dWNvbXpXeGhEUWZjSTc0?=
 =?utf-8?B?c2lNOFFQWFBJdTA2TUNVWWRBWFp6cDcwM1VibVYrbVhCcHNQdGFYUGJwS3Vi?=
 =?utf-8?B?aXpaNm81ZHVGNEdtdm5sdjhuZUlrSS9kQWd3Yk1YWnRnYnJMOVVPd3NvZWZM?=
 =?utf-8?B?dXAxY2kwYTZIRUVwcnF1ZnNWSmxjVGRXaXlYelQ3YnNaY1VWdEJycTIwZEgx?=
 =?utf-8?B?cnozWTR1TGhqOFVwMWphYzJoTFE1aGlFeHlnZGx3aTNjWDB5eFhiQmdzTXY0?=
 =?utf-8?B?eHg1L0s3ZjJ5WGNvRTZETVE1M3ZLY08wdThIT2NHcG1SeGZac2dOQkJ1cEpJ?=
 =?utf-8?B?WGVZV0JsNGNseTR5azFpMlp5YXR6MFI0WkhyZStYaTc0ckxMQkplN2E4cEpJ?=
 =?utf-8?B?aFV2K1QxL0d6MGhOczljeXZXR0lQeTN4TEVLYkVsck03cTI4YmVYYkthdDNa?=
 =?utf-8?B?ZWtDN01iK0lMeWYyTWFwU1U0Wmx2OEhrdzNyMy9BZHlZcWJZU2FPVmpmTmwx?=
 =?utf-8?B?dFFtU1R3MlROK1hEeEFJbWVJcjFTalNlT1JYcmY4WXp3YkJvTWMxRkJwaERK?=
 =?utf-8?B?L3JCdEh5ZE5tMXc1Z1JWWU5OM1dNUkV6S3loQnR5V2V6SXpadUEwMGRoeVZ2?=
 =?utf-8?B?dktLblczZ1VzYmpxUTlRbEtXSjAvamxpVVJ5WUZpM0Nmd0xKUm0xaFdlQ2FB?=
 =?utf-8?B?M2tvalM0a0lHUHVuazl6dXdNUlR5WVloMWhyWDJtUjZjSDhaaU1FOXFRY0E5?=
 =?utf-8?B?Y0tCckFNQnNObUdTa2hrSGUxalpCanBWaVFFZ2N4RzRIT1RjM3hZbjJIU3Zj?=
 =?utf-8?B?bUw1bXZRMEFEWG5lNTNxV0VyM1pTV1VGUmlteHRPR1kzcENuZnFqWE1lN1Az?=
 =?utf-8?B?ZS9Va3Zab1hnZmtVZ1lNUFRRc3RuZkNKbWNnNHh1VmhadVg1ZUFaUDZUUitQ?=
 =?utf-8?B?Q1l2T1N6akZMWDFTRks2VzFibVVjYUN2cDlhUWw3dHExVDMyYVdPWngrTU5s?=
 =?utf-8?B?Uy9NaHdLc0E4R1J1TDJaYVhqVzZ1eHhJVkxPZmdKbXBNMGFCejI5NU4vY2VU?=
 =?utf-8?B?emxXN0NIaHJkdUVCSnVOWVJHRzg3ZXR6M21SaDVoRG44dUxwTThDaDVvMlFE?=
 =?utf-8?B?WGh5Nk5QdnRKaXdZRzNXanRXMTlmWDRMcW1WMkwvTE13Vm1PelVHQUtBb3JZ?=
 =?utf-8?B?dVM3OVg4YlZLSkIzZHhzMXlXVHNJd1BmU0tacktzWXduWDFuMldta2VCbFFG?=
 =?utf-8?B?Q1VHUzJoREU0TDJTREVwVHZsNkJieWR1RGRKSEoySlgvREZVSUZRd1pxY0VG?=
 =?utf-8?B?Wkg1cGY4UURwemZMc3RtVjB0K3lOakcwdWtiRzREczV3NTdGbkNybWZPVkcy?=
 =?utf-8?B?UFlNSTYrVnJvdS9hUzJrYVRLcmhvQ3JtRXdJUm84ZVI2NXRoZTVqaGRZd1RU?=
 =?utf-8?B?M0x0Y29sVXI3THlzVDRTYVJ0WW5YUmg4YzBJRkgvc3k0dm5ycE8yWUZlYmVY?=
 =?utf-8?B?bDJaQk5INTFVZ1RQUTFiOHZCVEkzT3Q4bTlvYlZrbXR1WVA3bU1oYUpVNXRM?=
 =?utf-8?B?QWp1MlVRWUFtbk1BbGRlN3piZFJUcHBac0NpTjFHSlJMZzQxWXBZeHF0Vk5j?=
 =?utf-8?B?S1pGdHZFNjRLUVNMQWdxTTJ3Y1NXV3FwRFptSG1NNmJOUWI2ZVNvb25zNkky?=
 =?utf-8?B?MGQzczczRmJNSVZISWRtMnNGZWx3NDR1M21LWS9lQkdKUGtqR0o4TFgwcTky?=
 =?utf-8?B?ZWVydlh0UEtkbHlQV3FSMWhnM3U2V1dpbXB2QmRxdTAxbW53UUJNZVczbE41?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8875cf-3168-4249-3fb9-08ddefce6874
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE396822D5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:26:35.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH7c2wvux4WJikUaUWCx1TMkbdH4Th13tAUS+pwY3axbiUKdX2yMsqVNR5WtzZEmVBq056UY5ANo6/JEhyCzFTvXXZ7KkVGKWmGL1lxmr58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com

On 8/30/2025 4:46 AM, Joseph Steel wrote:
> On Fri, Aug 29, 2025 at 02:23:24PM -0700, Jacob Keller wrote:
>>
>> On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
>>> This series adds four new patches which introduce features such as ARP
>>> Offload support, VLAN protocol detection and TC flower filter support.
>>>
>>> Patchset has been created as a result of discussion at [1].
>>>
>>> [1] 
>>> https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/ 
>>>
>>>
>>> v1 -> v2:
>>> - add missing SoB lines
>>> - place ifa_list under RCU protection
>>>
>>> Karol Jurczenia (3):
>>>    net: stmmac: enable ARP Offload on mac_link_up()
>>>    net: stmmac: set TE/RE bits for ARP Offload when interface down
>>>    net: stmmac: add TC flower filter support for IP EtherType
>>>
>>> Piotr Warpechowski (1):
>>>    net: stmmac: enhance VLAN protocol detection for GRO
>>>
>>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 
>>> ++++++++++++++++---
>>>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
>>>   include/linux/stmmac.h                        |  1 +
>>>   4 files changed, 50 insertions(+), 6 deletions(-)
>>>
>> The series looks good to me.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Not a single comment? Really? Three Rb and three Sb tags from Intel
> staff and nobody found even a tiny problem? Sigh...
Hi Joseph,
Thank you for your time and valuable review
>
> Let's start with an easiest one. What about introducing an unused
> platform flag for ARP-offload?
Right, this patch should not be here. Will be removed in next revision.
> Next is more serious one. What about considering a case that
> IP-address can be changed or removed while MAC link is being up?
>
> Why does Intel want to have ARP requests being silently handled even
> when a link is completely set down by the host, when PHY-link is
> stopped and PHY is disconnected, after net_device::ndo_stop() is
> called?

While trying to enable ARP offload,
we found out that when interface was set down and up,
MAC_ARP_Address and ARP offload enable bit were reset to default values,
the address was set to 0xFFFFFFFF and ARP offload was disabled.
There was two possible solutions out of this:
a) caching address and ARP offload bit state
b) enabling ARP while interface is down.
We choose to go with second solution.
But given that fact this code depends on unused STMMAC_ARP_OFFLOAD_EN flag,
i guess whether it is fine or not, should not be placed in patchset.

> Finally did anyone test out the functionality of the patches 1 and
> 2? What does arping show for instance for just three ARP requests?
> Nothing strange?
Yes, we have a validation team that verified proposed solution.
> So to speak at this stage I'd give NAK at least for the patches 1 and
> 2.
>
> BTW I've been working with the driver for quite some time and AFAICS
> Intel contributed if not half but at least quarter of it' mess.
>
> Joseph

BR,
Sebastian


