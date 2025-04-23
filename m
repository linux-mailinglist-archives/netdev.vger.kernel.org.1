Return-Path: <netdev+bounces-185217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8FA99529
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216901B83A34
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9B280CE0;
	Wed, 23 Apr 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsmOcHGH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97F25C83E;
	Wed, 23 Apr 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425711; cv=fail; b=exi2AVG89CBDULaOeC1SUZOu9fUmIvpq1bzXhj/kivQxRJDVY+iKn/gnV/PdLkiFp+Lybfq7WovdeZCRI1TNj7x29q1NgA2cQ86WJ5kP0gbZowguTGAYeTTpRHzcRuf6HrJ+c10zGfJA0JbbkwGyDMMX2VPh2fmDOUVtalYrV4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425711; c=relaxed/simple;
	bh=WPewt3KuwNV/qG8MUL0yOC8FxpLrNFZC9k0jA4A2cVc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Af5Owsz9PhRyrce8sjipvCb9gICDnfd/V0//otPxAdL+1qlAf5ncrjpeO5cN9HuujnEMjA0ag/TWYezMVCUACb18AlewfaK0Ei2mulRdJRhwcwWDRYlXCS4cn/yPGMNEFSjGkkecfVTNf54V1C0g22Sw+F9Nwr0XLqZgJ16cXvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsmOcHGH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745425710; x=1776961710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WPewt3KuwNV/qG8MUL0yOC8FxpLrNFZC9k0jA4A2cVc=;
  b=fsmOcHGHUrKO6/1IvFDpMspU3+VJPNgsaZDT6nwq6gE28brIfx9HEn85
   1SBvjnuWGBoigOjHPacMFWOhvUP6ibBoeRfsOtyjqE7Fqf2JCc6Jh5VhS
   Qy1sRgQmVeCJoFJu/yVlIEnFU+YDpcABB6fy9t8ck4NXm+4CAbSLhGGrg
   ty3Ase3v80ktrj9JIuBO/UO/lNoz/TC5JFydf4LU+wFxYDPN33quVSrTy
   ZzLQdwCo32J8pH2AaVcauRY0kEigoNY2JACiC70l/t2MkE/B4fY5lJ5Zm
   4cF9nEmypyaZt/ZjhfPm+eN87cwU67tDf0pvIXuhTi6+IH1fkWK7DZGac
   Q==;
X-CSE-ConnectionGUID: NroFrA7cQ8K2qKbkyqy9iA==
X-CSE-MsgGUID: 3+oNOw3GTCacCii2ETn3AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58022016"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58022016"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:28:29 -0700
X-CSE-ConnectionGUID: a0ciN6kfReyK2Y5FBPTPZA==
X-CSE-MsgGUID: RUzRJf9XT/mVHiLjZR0/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="136439056"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:28:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:28:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:28:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhTTLgKzqs8Vf5sCn//Fv33E41sUsZmm+VyZndFgmYAYe4JmS0H4ElHMUtSPBAMSzizkhcoae9ynEMsoGGZHtfvlCNg9WYK7LoLkgBmd8jsjRQXHj5amm+w5J7LNA8JFPAv8JU8BYjT59l+eOcRY5RXdcFxjh8/Q0zpBBOUj+SaBchuSC1jP6i/PTNhtNObn47p52QHHu7gNCtBMvN3sU50AMKTrazk5f3LU9hHpY+iKLwaKIjwV0DsDRLf7dggZ8DPLeFY3VmVZqd+oOKrDmtsM4IXIw9ARkoq3Ytk0RM7FNBV934G7/KPaJO2OuqRJ+QqfKsYl/mwqzth3JKZJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Rhf8mpx1rn+2yhLA0lxaXUmd+sZ5iIghVuTMX7EQQ=;
 b=S36CBuMYB7nMJYyuG819M1ofK57gaR/UpoOMuMe9gLv2+qzsztHqhcZukMhLh4kkWHCBAXRN83vmadEbzJMe29+aFpOzDS6cPW84cLhUS1KfWikxswYBrXRSiRJ1FdvzkOoMIE/KI8oeHNH8gS/z7QAxAFtU/55GbufbHDZLbP9YZlQKx0UFqbFcMh0xygdZjA8m6KWsOK/J2QD8KLsTmQzgTiJlXOa9hoaXwjSELazolOW0zw+bXnxUqavBemSjfgNBEkQgDjcaNrGCP6OdvQ/EGEO+kcO6iae+vD13dIsm86TPhba/Bsx43RxUDIbHpiQvMzQpd9G96J9rluA/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 16:28:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Wed, 23 Apr 2025
 16:28:23 +0000
Message-ID: <9bab3ca4-e643-46ea-bb71-90bfeb6fb751@intel.com>
Date: Wed, 23 Apr 2025 09:28:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dlink: add synchronization for stats update
To: Moon Yeounsu <yyyynoom@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250421191645.43526-2-yyyynoom@gmail.com>
 <a942be9e-2799-478d-b8c2-7a85f3a58f6c@intel.com>
 <CAAjsZQwys95_bvKQDAd6aFeoL_LXfTKn2Pkwq=-F03uAuhVVXg@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAAjsZQwys95_bvKQDAd6aFeoL_LXfTKn2Pkwq=-F03uAuhVVXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: e1858677-7df7-4171-bb1c-08dd8283de3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU42QVAvOGp0SWl4QnNFUmtpVXN5VkxNTnRLTkF3aHhqYTRMcDlTalRDYnRz?=
 =?utf-8?B?bHpjenFaVXU1c0ErdUFoSnBYRVk2cURKc3BJMDZGSlVKUXAvZEEvczRIQkQx?=
 =?utf-8?B?SVF1bUhteTZZNXk0dFhoTTRoTnlCNHkyT3BVeDNDcnV6RUdLQ2h1RGJLVE9l?=
 =?utf-8?B?anFpeExXMlN0dUhwUU5CODR1SmhlUmd6UXVtNlJUcDk3NTZjb3dUaUc5aXNO?=
 =?utf-8?B?bGZnd2I4SWNsWnFFZWJJUUxWVVB4QTZaaGlCYkNUYklQYTFtd21kdmEzeTIy?=
 =?utf-8?B?NlRTeU9vWVVOMG1WTE1ZTHF4YVNmbWZENEMzeUllK3lsY3FMUjZUbDZZT1c1?=
 =?utf-8?B?QUo0Y2xwK0ZOT213Ry80WXdWYUZOZzJ3NDhacXVIZnB0aEVWNWtvL1M3cGh1?=
 =?utf-8?B?eEJ6alJ0RllHTXo1UnFlV1M0VjRCcmFtY3NaQkx1eTh3U0pVNk43SEp6VU5i?=
 =?utf-8?B?eFMxRnJybzJwNkJQcGtSU0FBakFQQXVsQlRLYXNwNUhuazRpR1Bma214NkhW?=
 =?utf-8?B?SjFEMzRmNVl2OEQ0ZzR1NjN1MDVqbysyaWZTOXlGY080QW9oME9sdklwMjBh?=
 =?utf-8?B?NjZtWml2QkVrbWpZMzJOaUdySW04aUdOdmlkWlk2U1RiWHNqWnYxZ1BLRk1F?=
 =?utf-8?B?blZaeG1LUXlOdlE0YkV6YnRXZ3hlY25MN2xsZ0xPekcxMXRjSUdDMGdjTzFN?=
 =?utf-8?B?eGhyY2U1a2wzNVJFNlBLSWJyc1Z3cG1HY25SNy9Md1VWVndUK0tZRnpWL21U?=
 =?utf-8?B?cER3dHJpZ0twejVpQjdHZXdkamQ0b0JNRTZjTnpySGwycUUwbHQzTTNzOHIz?=
 =?utf-8?B?OUJOV0diTUdVNVpFU0tLZXFuOGowOUlmSE01YmUyN3c2eTJpRjJZdWVSRjhy?=
 =?utf-8?B?VWllL2FlSjVZSlA1NmMxaldZZ1JIaVk4SkxpSDdZTnVXNjQ2UkxKYnZycjNz?=
 =?utf-8?B?TVBHSDRHQWptNXZ4WjB3NmphaVgrWURseEU2bUVISjBpdkNzQTZKMWdqc0JK?=
 =?utf-8?B?eHNhb1pWRFhQdlBpdlphSjZqbGJueVFybzQ1Vk9KamxYenBKQ2h0NEZlcTJT?=
 =?utf-8?B?N29jb2JyRktob3pTM3NVd3JtUXA3T0lqZ0V6R2YwdjBTbHNqNVFJWFBlNjlF?=
 =?utf-8?B?clFXSFUxWWd4NjVYU2pGV2d2cVkxSmVKOWUvQmlTc0dvTjhON0hpZUdkcDhr?=
 =?utf-8?B?REFlM3ZhK0FiNkZzaFBYaWZKZVNYSWp1WnIybURaMUVYbGhYTEFiU3oycHZP?=
 =?utf-8?B?NGxCQ29HN2V1MmZreTgwSjB3M2hEMDR5R3FIM0dVZVFacThMOGJoMTlPcTJk?=
 =?utf-8?B?ZnpzeDZFWFVNV2hZMm9JOVJSY2Z1NHZmSHhmM0NKR3VnZjExbjhyWWRBTzlU?=
 =?utf-8?B?QmpuS3Z5NHhielduaW95aTMvY09HZzNiaVB5bHgvZXlEaTdJOTVDdmdITUls?=
 =?utf-8?B?OE9NZXBqUXFDamY0VGJjbUplT1hlSUxhNDFqOVRhSEs3Y2s1M3o4K2d2bFEx?=
 =?utf-8?B?cUdGZnd5eDBWMXRnL2JVeFRzYXo1VmpyR3JvRWYyWjVqR2krL09BRTNSQkhI?=
 =?utf-8?B?d1lCMm5ITHJkalE5U002U2NrdjM5T2R2eksrNDdvNFpES2NZUUFkUHdwOGR4?=
 =?utf-8?B?NXVYbWhSb2tYV3N2bXB6bm1GYVg2VmF2TlM3SDgxZFNvZ1YxWDJZaUFGTk5s?=
 =?utf-8?B?Zy9OUEtoRHE1YmZwT2J3d3BWMTRFbnRRNElVZDFRQ0VSSlUzck9KcGhsNlc2?=
 =?utf-8?B?SDMvWC94aEdSQjRPSDlGTWZlcW9HcnJjMUZLdVFLV01GN2s2b0N4OXRtdllY?=
 =?utf-8?B?NGNkZC82d0J6bXZjb1VoU010cHBWSUR4eS9KV1M2NFRBZjd1Yjh2ZDI1VGRq?=
 =?utf-8?B?UFRDTnN0TmVjVXM1dnVmYnR2S3M5cU9XeXhLaUo4cWJKbWVzWVI0NFF1elJF?=
 =?utf-8?Q?33OVjbFoyH4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJrKzF0Y3d4Mm1HaWI5S2xZaWo4SElyWmp3R0xvSWt3TG01SXNnWmxieVEw?=
 =?utf-8?B?anowbWpRTmVJTXAvZCtjSDNJa1YvRTU2cVVCeHlodGFZSHJaTTdoU3NjSEds?=
 =?utf-8?B?a2N0QVhmc1U1K3V1NjBSM3piVXg5ekNDdWhJTEd6S25tajlwMUVHSWx6Y25y?=
 =?utf-8?B?aWZhOVZOdGZSZGVFSVZlQnRubnpXNDZ2Q1FyL3RpYVVWOG5QTngvUExFM3pv?=
 =?utf-8?B?VnB1UVJJUG5DUzVsOHd4b1o1SzRIQjU5a1JvT3hSM2EvS3dFdGhFWEl4aXdx?=
 =?utf-8?B?cUlJcER5ZU9rOHk1LzZHNlhoN3dTR1lVbm1UdjNhb1NSMTIyalBYNmlGNkJ2?=
 =?utf-8?B?TEFkWXVycStCV3g1NjBkdVF5NTBEclZldFZkNGp5dTBZSWNuNkN4Y2M1Uyti?=
 =?utf-8?B?MnpqRDd2dW5ibTB1TUpxOWs4Mys0bFBxeXlzdFpaWGE1WlBCUXNtNkduN2Yw?=
 =?utf-8?B?VUxydHRBWXZEckZRckpNdU5jbDJGY0ZyalFwR05ZY0d3VWNYUENyS2RjNWxN?=
 =?utf-8?B?NGREUTl2RllGVzNSeFRLU0ptVzY2V1VCL2QwMmkxQkwvci94RGxrcGZKd1JO?=
 =?utf-8?B?VStiRlpsckdEL2k5WlZOM0ZmN0NjUG5mSEZnaCttaitaREdjUENZVEtmZXlO?=
 =?utf-8?B?TVA0eU5TNlpwREx5U0orOVJpYTFKczlhUVl5RlFPWGNOcGhlTzh1UFdYMG1y?=
 =?utf-8?B?ZFZLTzdUbngrN1NoeDZVY2tsRXpqamJDRnJqdUYwZ0JHMTRVWHB1ZENEMVdY?=
 =?utf-8?B?MGpBSFE4UE9ZMVFQUW8xc2p1TnpFZlNnSDVkbXVjKzU4QURrdFQyNGx4d3Jy?=
 =?utf-8?B?eTNNbmxrb2VWYVV0TzV4anhGK3FnbmE0eCsvc2dOQTBiU09NcFdybTN1RkVW?=
 =?utf-8?B?MFpFTDFEak9ickxuWVl1VlU5cWY1WWs1UkRSclRIMnlaYldzZ3Y0SHExSXNN?=
 =?utf-8?B?UkxtWVZhM2dwbFcwVzd4V28wZXBJRXVLMURsNjQxZDBXdTRZd284TXpKT1M0?=
 =?utf-8?B?Qk9VSnhDU1VqRnI2V0d5QVc4NmVTYWhqcXBJb0xvQnY3Nk0wS1g2aWdJVUxX?=
 =?utf-8?B?U29vcjc3a2xNdFQxUzAzcGlTM0FvYjlRb2NjZjJrbW52MTlyWThWQlFTT3kx?=
 =?utf-8?B?dXQ1cXhYaEUxQktpcC9VSGNpWmhBcnhQMFFKd040RnpEMzJUNjF5bjN4bFVD?=
 =?utf-8?B?TlM5UzlZZGptRW5hZzNLZkxpZVdJZXBmNTZqckE2dGZrYnl1TUhUUGVmUWpS?=
 =?utf-8?B?UzFiZkZZZlh4QTQ2bUFEZjIvL3BFdW8ybmNhSXJUZGJjMDZsMjl6K2s3SDMr?=
 =?utf-8?B?TExPYUZHanFlcy92Mnd4RWwveFRmSXdZNFF2aGtjR0twbHhMUzZDbGxVRnhk?=
 =?utf-8?B?Q1RFc1BJSU5vRkNrbzhPTGpNaEcyZGNiQnJFMGpGbStyS045ZzRxM3hSc1VC?=
 =?utf-8?B?Z1IrdnBnN1RxRUF3THhjakM1bEx6MWNOVUFtUlJ0WjhwNU1PV3N1bEtFcjIw?=
 =?utf-8?B?QmRVRzRwT2pSdU03ai9ENVFFMWpXeDNhTzRjMzgwdVFTMHVaRE4vVkthczgw?=
 =?utf-8?B?eEFERjFpTHVFNGF0QVI2T2ljcmNoQUZCM1NHNlorVmRmczRFVzJpWFQ4SXYy?=
 =?utf-8?B?UEJYZEtXVjYvT0dleWI2eGVENkI4Qk9kNWpHR1V6eVhVUnVSOFcvZWFLTjBG?=
 =?utf-8?B?QWxMU1duK1pGSkVjNWdZZ0tuMWgzcERQOStSSlVudmdzTmprb3NnYnJGYjhi?=
 =?utf-8?B?UWFWUkFHajIzVmwyOURLUW5uSHhDa0tKZ2NraXRoTTBkZ2JYM1p3R0Uza09H?=
 =?utf-8?B?NXhGb1JOajFJWkFtNlNoNC8vMHRmODVManRjbVFPdS9zMVhrWEdKZHhjNDhC?=
 =?utf-8?B?LzFwdTZBaW9ITHNidkFmU0dka3F3cE8yeU5ITWJkUkYvclNnb2VTN0dxS21H?=
 =?utf-8?B?dTY2OWx5dC9GTERjaGV6SzJUb25ZUWVsUVIxdzMzVnc3TUlTZnl5WHRMR1p1?=
 =?utf-8?B?bmRpcFpzZkpNRGdzaS9Gb2ROcU9YMklZUkZkNXRqSU1Zbk9JWU9ZVUJ5OFJV?=
 =?utf-8?B?ZDIzNmZBNVpGNTRyTVNQRjRMTVBwTnJIUEtuWnY2Q3RzNWxMRE9aWkppZjFs?=
 =?utf-8?B?bE1SV2Q1ZGJ4aHE0RmMvanVUS2VQVlU3aHlwWmJQMzZnNzVKQUFFZHI0dGk3?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1858677-7df7-4171-bb1c-08dd8283de3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:28:23.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjlTv8uohZ+k+MGtAD7qoMneZ1Yl20pdBD11cppSKyYbDZRMwxTSuxl8hs6pk2nInRyUAPbC8ZO0fIv8nIgFnpcQSsAsy+J/H0sqWaA2BqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
X-OriginatorOrg: intel.com



On 4/22/2025 3:53 PM, Moon Yeounsu wrote:
> On Tue, Apr 22, 2025 at 8:24 AM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> Thanks,
>> Jake
> 
> Thank you for replying to the patch!
> I think this patch needs a bit more refinement.
> Would it be okay if I submit a v2 patch?

I would probably switch to request_ops_lock as a separate change than
this synchronization fix/improvement.

