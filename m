Return-Path: <netdev+bounces-173113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72AA57659
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EB5178BC8
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD66212FA9;
	Fri,  7 Mar 2025 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpwU6KD1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377001D9A66;
	Fri,  7 Mar 2025 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741391320; cv=fail; b=NIgoOXBFE6rarK3DcqC+7ZcwJW4gCmtNynutT6hdNOr992o7Ai9sqOgJNQ9z+GliZwmzj7e1uIPNbl7b8zcwStgeOpFUqG0CUsOZ7ms2oibthGytq+pio+MPxdua99wvIEPVhn2XRTqusVSPmko9wSI8Xho0zFTjDdowUOg+W78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741391320; c=relaxed/simple;
	bh=JaxAHetXyyDPYmJexlnuDYRXD+9dYM3z/5kfvmy8mek=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qo7RgnBBqVEl5beasL/hR7TtMPv764hs8hFedNUrdumO05xOW6trLSGXHWvN8YtOdmC669X65FEG74Rk5qX5/yLG4c9qHPp4FzWaEAxOxeCc2ZuWkJDV92p/IYZ1gJRVd4bveZenlPw3hH0w4/o1Kn3/P1wmDBFrmjs4KgMm+Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpwU6KD1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741391318; x=1772927318;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JaxAHetXyyDPYmJexlnuDYRXD+9dYM3z/5kfvmy8mek=;
  b=VpwU6KD1K1VIuCNCM+m/OPMSruBeH0f/PnQZW6h+3LqtdYBDBHEjIZJZ
   vvDDnFTk8DV/33xkt+SMP0H7I6bZwxZ1dWOpYRt3epmOYayESsonXHwyX
   3hV7BdtcVjeSrBjoN9Yt87Kmwo1WfgpQQqbKVqwJ7v/6WTerBsMydbJxI
   G/onPu4D4wAAWogWJ4MDn72ieNDnPT3BdO8/V+W9+YSHY2QSlijRKdQxh
   q9hO3gNGwURCB+ghxJeD+AAN1WFJ876KtcpaknD3zTu6YKjfKMAjDJbnm
   dncP/W93cjc9JJS3JcPIl6wxz+eYtOiyNYt+g++6IcPVstse2pzfUoHOe
   g==;
X-CSE-ConnectionGUID: D3zp/zq1RuuCFuY9dDnKXw==
X-CSE-MsgGUID: jO2Sd4bvSziDjgMSzZ1Wlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42333177"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42333177"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:48:38 -0800
X-CSE-ConnectionGUID: vLPMAUlLR7GpK32TPipRmg==
X-CSE-MsgGUID: yJCL8lp9RMCpzix+Cmq4dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119439944"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 15:48:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 15:48:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 15:48:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 15:48:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmSxIYkRmj+7gdnWmr6YHr4JO/f0Qn5BzORfAjUFfCEWWhoOCJNaYvu2cAvc96lo8aB3AlXAVspvVJ/IqEimhroi6IbGDK6kL5DY5v5cF+J2gIHNPqeGrrFKV0W1SjR5U99LtaTDtjPAEBV5irb7jIzUb0JUbDrkGxdsOwfIB92DP0haK/Wyq7gU+KeP6HMWJRJt4AkzA6puW9Z+UGMcaFaT4baXd2sHn6RfF+rzH3TzFFILi2RQkgZteTGv8IcGrVHer9d/LzQhIBWI21ysIUP5CXiCtRZfjizjLNjzgpw5C0NU0H4YQVqez6tw4/V4p+oMRYTYwPvp5jb60FtaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0gDjeVIrtCN4sLdzVcrcCWdrebD0U7tCDcbhq30tDI=;
 b=WfbUmNEv2pdKE5bcQrpkhGi4dC3vLIAHOVO3hSXVZLiwxVWqdGpKZPywDTxFVVjfF4q6Z0e75v0Iw0GOMIEYW1BkDmsk6gZm47BFfsCXM1MohrptC7Uf9kxJggQSwLBlj1dTEw/WmqHEagCninO+5YaXKHgqQqHIYRid5IrVA+LESWJktrbVgBxUTog5pJxeYqzQmSEadkk6LDmTSGIWp6wQXoTWrp8aEapMX7ohte+jC9aDPHUPcBCA2K/nwmy2Pnp3ZM/uqsC1f46kkNRnVLMSoIN4BuuEvPWYL6cKmJGcx25WR05bmjUitmv+YxfHls90T+Lg4BWgneOx75E61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4918.namprd11.prod.outlook.com (2603:10b6:510:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 23:48:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 23:48:28 +0000
Message-ID: <f7072ca6-47a7-4278-be5d-7cbd240fcd35@intel.com>
Date: Fri, 7 Mar 2025 15:48:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Plan to validate supported flags in PTP core (Was: Re: [PATCH net v2
 0/2] Fixes for perout configuration in IEP driver)
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Meghana Malladi <m-malladi@ti.com>,
	Richard Cochran <richardcochran@gmail.com>
CC: <lokeshvutla@ti.com>, <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
	<diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
 <415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
 <20250220172410.025b96d6@kernel.org>
 <a7e434a5-b5f6-4736-98e4-e671f88d1873@intel.com>
Content-Language: en-US
In-Reply-To: <a7e434a5-b5f6-4736-98e4-e671f88d1873@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:302:1::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa99f58-6790-4eb2-8efe-08dd5dd28f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk5YUmJKa0h0NDMzN0xGRmE0VVZCSi9uYzdhVGUvS0tlcGNEMTh3eE9qNGd6?=
 =?utf-8?B?Y2NWVW5uZXk3bzNIdHFUcVRkV0MreFNVNlVraW9ZaTZWTS82RktyWE9IeGZD?=
 =?utf-8?B?M3FEMS9EcFZGWW8rdTBRZFZXSTNFUEJLQm5lODByL25oWHFtZXhidmV1bzdk?=
 =?utf-8?B?SXp5aUFiZFdJSllwUzVDZzN4dnlNNGFxSzdjNFNZUWVnb3ZyWmttem9IWjdZ?=
 =?utf-8?B?VnRWSFM5NHZhSXI3V1FLQVJESmRXbWZ3a3BtTC9XQ1hDR2xpLzBobytSWGVI?=
 =?utf-8?B?enF3MGJ4TTJBT3NMRE85OWMxaHlWSmZSWk5yYUs2SURhVVJWK2huT282b21w?=
 =?utf-8?B?YmJodEJYdUdESWROWm8xV3Q4TUJRZ2JUYzdhU3VQT2dUdVg3T2k5VDh1SFcz?=
 =?utf-8?B?QWtSQ3poSi9FSlBieTJHRklnd0xVTE0wUkl4SDFMb3IvK1hlUXpEWHliRU56?=
 =?utf-8?B?YmxhU01PZlpzZDJmSWJyWjZKQis3Um5iRjlDRi9ORzNJelRyeWIxQk04UC9P?=
 =?utf-8?B?d1ZVcllhdGp3b01YcE9HTng2b0QvVW8yT2NRaDByTWdrUUNyMnMyUENFTGNk?=
 =?utf-8?B?Q1grVVdBVWZsNHo2SUxuamtLMDl6RzRFMy9lTmorNE8yTGhkZm1nakVjTUEw?=
 =?utf-8?B?MThwQzAwd2k1ejhMcmhhMXc1eXhpOUcxSXJUNWVFM0FXVEpKTHdJdm9pUXYv?=
 =?utf-8?B?NlBxN2VLREhFa3JHTFgxMEdra0d0WFdKVmZLZ0V4anVoUXYwYlBFSGxTQWZD?=
 =?utf-8?B?L1NTZFpNL3o2UmJpNUtINUtLZUVtWnd3YjNvaStMb1pqT0pRQUVFeExMWHg4?=
 =?utf-8?B?YVlGMmhnREE4R2tQZzh2U01kK1MvTjJrUm11YVh4QUxUb1RpbWZqNUwxU1FJ?=
 =?utf-8?B?SERCQ2FUdThPcFlWTXNPaWs5OGt6UVdtWGpJWWNhVkJwMHB5TG9kT0EvcEw4?=
 =?utf-8?B?SmY2QXB5QlVsU0tHcnFVcU9MUEl5RUVtZjg4SklHV3dzZjZmM0J3TVQ0ejR3?=
 =?utf-8?B?U0lMMGZaZVlTV2pWQkcxOS96a1NDL24xR3daTjVtN2NycTBSV005NzZaamNl?=
 =?utf-8?B?SXlXYUVlSllGT1c3NTZsL0s3L2RKbDdZV1FqdE9nNG1RMmJGZHBzUUlLV0p4?=
 =?utf-8?B?UHlwUm9qUWZRRW1Ja3VWL3pJZEdYd2xHbkxoRXorZ1VFUnZ3Q3dJVFhwMzlF?=
 =?utf-8?B?NzRGcmpwTEhRbW1mNkltRHdqTHRUeVhhY01pclFpMXk1TTA0dlliSWtIenQx?=
 =?utf-8?B?Rm5rYWNob2dPN1B4eGxRNndEZ3ZHU3Q0V3ZNOExoSFQ2OE8xOHZZaUNMRnJM?=
 =?utf-8?B?SG1LZ1Vsd0Z4SGRycm00dDJ5Qy91OXpwajI5ZytQVlFNaWUybFRJeEl4TWpv?=
 =?utf-8?B?MkhZNm1oS3JKcHRtdFQvcmVlNE1qZDRGMllKeldJOXhtT1oyV3NUd0daQytS?=
 =?utf-8?B?UFJsNE1Oc1BTTXhOdWo3QisvenFUYlZpSVVEMlFkUmpTWGR0ZEc5WmJpaVQz?=
 =?utf-8?B?bWluRlB2dkJTaUFrQ0tQY01uczVmNzh3aEJzRDJhTi9HOGtrWEF6U3YvZlJj?=
 =?utf-8?B?MndMMWhsbE5RZEFpclJTaTFFby9ubWJRRGVzaWN0OEd4TzNBQjZGZXBINU1N?=
 =?utf-8?B?YWhqR01YUmpSS3hLY2JlL2lpbG10YzNhQnFMRTNOVW9pS2NJQmMwR0JGeGdt?=
 =?utf-8?B?azdYK3RsdDJEWUNrUjR3bHpRQVk2Ni9PQ1FmMmxHbGJBQ3ZpL3pxT0pSeVM1?=
 =?utf-8?B?UzFrVlYrbmhDcVJmNVhtUnAxaHI1Sjh1VC9SRFdWcnNReWpYYzY3aTZPNVAv?=
 =?utf-8?B?TERzY3U4WVp3V0Uya01IbFhEQktXdnljK3ZXVkY5M2tuV3FNakRrZFhMeWNm?=
 =?utf-8?Q?H2QDlgLTkRM/z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFwY3hEMWZHR0VDZkRXMmtCdHJkTWVtR01kYjczM2hob0V0UHQrbERHaHNM?=
 =?utf-8?B?TXB4ckVVcEVLbXF5M3ZBV3lQWnM4eXpwMlVIRzUvTHBlVkNPL040Y0p4WlRa?=
 =?utf-8?B?QzdYUkRsNEhKeGR5eUh3aDBWbmc2eU95RGc0eTlyRnRGU2ZmYlJPd090UkN0?=
 =?utf-8?B?enJkOTNlbEJibEFMRFJTRU02RGRabUVrV0ZNaTE2L2U0R2poaDZJQVpDckpH?=
 =?utf-8?B?bWdBN1BiVEVIQjZRaFhxRVRaZWl0VWJIT0sreGxDdTJiOHB4YjNEZFFUc0Vl?=
 =?utf-8?B?eUdwVDB3Si94Yml6WTVaTDZGNUxoZTM2b3pzR1gvVTJaMVRMc3RzcVR4Y21Q?=
 =?utf-8?B?QUs3bEpUN3FLdGhRdjhTdUoxVURwRUJESk9obzZ3NUpUazRGanMzaEdIdFhi?=
 =?utf-8?B?bXVBWGlndFdCdWVzRlhhQWJ3dlFsV0kyek1VajZKUlhkaUxaQWFUWUdSd0dq?=
 =?utf-8?B?czlqdzJoTmsrRU1aZ2krT3orZS9uZzVsVzl5djBjNWdrWDBxbExVckIwcC9E?=
 =?utf-8?B?UWlKT1dETmxWeXRHcm13Ym1ZSE1HeStYQ3Y5MDBUbmYxNjJqaFFZQkwrZ2hB?=
 =?utf-8?B?QlZFMnorSnAxZHhTL2tOSFVKN28yQnpKZTc4ckpkOUd4N1B3RkFmemZLRktu?=
 =?utf-8?B?VmR4NFNTejQ0Y1ZTeDA3eGtxdVh6cmhTOHh3eGI5WnZGVHJOa3lxOG9MSHJt?=
 =?utf-8?B?THdQSE1lb3NmQkZBN2FKYnowLzBDdjJ6VlZhWWJmRXB5anZPUStwSXVwckQ2?=
 =?utf-8?B?SkVnNjNIUlNoNW5JclZSd1FBMWcreU1nQUNRU3lhaTR4MXFmTGxLT0VZeWdW?=
 =?utf-8?B?cWZMWGJ6VFJBcFlCTUtVanJDTU15RTl1cHVCejUydFF0U2lHUEVEY3Bka1FO?=
 =?utf-8?B?ZHJMMlhCZnBMNDFIUk1lajBsZ3NXQjNobFRyc2pOTW1WM0c3UndweDlQVDJ3?=
 =?utf-8?B?NVMxVHVsR2hzcTZXa1Vqd05JelBndlR0RS9Tb2daZUdDT1FleVlYc1NHMXBD?=
 =?utf-8?B?d1krNFp0Nml3U1RmV1FMa3BPdFFtKy9QMk5nQTJ6S3lod3h5dkxEbXZVRkVs?=
 =?utf-8?B?T3ZhWU92TnVXM2VRdjJzbzRFVGo1bmhnM2wwSTRoUDlEZ0I4Um9pd3V5UWtJ?=
 =?utf-8?B?RFJFNXdPbDh1NXhDdUZNTHc3QUFXOSthdElvVXE0S0lVRFBLMC9TTDFGL3ho?=
 =?utf-8?B?b0s1Q0hsV21QK2pBcXBUWTNadVlQNXhmQkNHeXhYem1wVzlYZy92TXJVREla?=
 =?utf-8?B?VTBrREszNStSTlp0TGQ5bEFaL3RNem1PazN6L0E0ak1BMExpRFpZbGwwSTRU?=
 =?utf-8?B?eW1icVh0NWN6eTFHVWdBcDVxZEhuUjVQR0p0Y21IYVdCQ2RmK1VBblVyV25s?=
 =?utf-8?B?MUd3M3JydVRWbUhRUU04WWxSN0FXWHloNXNVT0FlVDh0VFJGVDhvWjV0N1Yz?=
 =?utf-8?B?SGxyaDltVXU4UldXM0lJN09jWmRNSUtRSUpSTGpVWXRlZHh3VDQwUFdRMEQw?=
 =?utf-8?B?b1hMZzE2SFRQSFN6ZTlTT2xXb2J5K00vV3pldCtmY0Y4aW91aVI2T0hpWEIx?=
 =?utf-8?B?dnYrNndxcjRGK05yMWhDejdsdjVNNDJCekdaTFFuVzZqQ2twMG0rNUFGZ1Bw?=
 =?utf-8?B?eENrNmNLT2xuUlBWOFgyZ1hTcWh1VVBZV3hyZlJGVjViWlAyQm1FQmthSi9U?=
 =?utf-8?B?WFFldjkvN1BYazAwZlViQ0k5MnNkOEZHVjJpT2l2V2k2bDY0d2lqMDFmRUFl?=
 =?utf-8?B?M3FvNmZ2bmQwWHNNYlJ3a1F4dE1kdFJTMmxNS2RsNU5Nb3gxc0lKbmZiZUJp?=
 =?utf-8?B?bG1oVUNuckx6Zi93RWRqQUNkVkpzbklLbEVCck9aZGhQU21SUjRzb1JOM1Rm?=
 =?utf-8?B?ekdvNzczZGc1a2Y0V05TTG1ReUVVQ1RqQk5Wb21MK241SmhPMWkxWFhUQjZ0?=
 =?utf-8?B?clcrUkFXUGRKckp1bjZpWDVBM3E1aWNuWWVxaXMvZFZzYTIweWp6VGs2WDdL?=
 =?utf-8?B?MlRsWTU4UkV0VlpqcWRzNU95OE9pbTYrdDIyRTFlRzlUNHdwQ3p3NE9VQzFF?=
 =?utf-8?B?TUFHQ0lKUTQ4NDJVM0Y1OERMY2hCUWhYZG9jVDA3R3EzT2tMcGEzN2ZGVUNH?=
 =?utf-8?B?WkRZRFdHNUgyYllUNXB2THdEVWl6MGJHWTAxWFgwUERHbk1WcXBIdzZ0L3pO?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa99f58-6790-4eb2-8efe-08dd5dd28f63
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:48:28.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZxiD6CrhgyhQmIzon22ozJ0pPDz++XQqifEn9ROj2Bn2D6LsLAy/Cq2s5crSEjKis7lfyqd6gV/VHKAn9Nagis1SI0mQxaMyk+P3preKqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4918
X-OriginatorOrg: intel.com



On 2/21/2025 2:22 PM, Jacob Keller wrote:
> 
> 
> On 2/20/2025 5:24 PM, Jakub Kicinski wrote:
>> On Wed, 19 Feb 2025 15:37:16 -0800 Jacob Keller wrote:
>>> On 2/18/2025 10:26 PM, Meghana Malladi wrote:
>>>> IEP driver supports both pps and perout signal generation using testptp
>>>> application. Currently the driver is missing to incorporate the perout
>>>> signal configuration. This series introduces fixes in the driver to
>>>> configure perout signal based on the arguments passed by the perout
>>>> request.
>>>>   
>>>
>>> This could be interpreted as a feature implementation rather than a fix.
>>>
>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> Agreed, ideally we should get a patch for net which rejects
>> all currently (as in - in Linus's tree) unsupported settings.
>> That would be a fix.
>>
>> Then once that's merged add support for the new settings in net-next.
>>
>> Hope that makes sense?
> 
> +1 on this direction, its important that the driver does not accept
> configuration which is incorrect.
> 
> Reminds me of my backlog to refactor this whole mess into a
> supported_flags field in the PTP ops structure. Maybe it is again time
> to revive that.
> 
I've been looking into this the last week or so and I have what i think
is a workable plan, but I'd like to get some feedback before continuing.

I believe we ought to add .supported_extts_flags and
.supported_perout_flags to the ptp_info struct. These will get checked
by the core, to reject commands which set flags not specified here.

For PTP_EXTTS_REQUEST, the PTP_ENABLE_FEATURE flag is always accepted.

The behavior of PTP_RISING_EDGE and PTP_FALLING_EDGE is somewhat
complicated. I think the best way to handle it is to check the
PTP_STRICT_FLAGS. If the driver sets this, then assume they will
validate the flags properly and only enable strict matching modes. In
that case, check against all flags as.

If the driver does not set PTP_STRICT_FLAGS, (For example, drivers which
don't set anything because they forgot), we only allow ENABLE,
RISING_EDGE, and FALLING_EDGE, but not STRICT. This essentially disables
the v2 ioctl, and prevents users from getting strict behavior, (since
the driver did not say it would handle strict behavior!)

For periodic output, its easy, since all the flags are present only with
the v2 ioctl, so we can do a simple & ~supported_flags check.

The bigger question I have is.. what should we do about the existing
drivers which do not bother to check flags at all?

In my search I found these driver files set the n_ext_ts field to a
non-zero value but do not have any flag checks:

>      • drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
>      • drivers/net/ethernet/freescale/enetc/enetc_ptp.c
>      • drivers/net/ethernet/intel/i40e/i40e_ptp.c
>      • drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
>      • drivers/net/ethernet/renesas/rtsn.c
>      • drivers/net/ethernet/renesas/rtsn.h
>      • drivers/net/ethernet/ti/am65-cpts.c
>      • drivers/net/ethernet/ti/cpts.h
>      • drivers/net/ethernet/ti/icssg/icss_iep.c
>      • drivers/net/ethernet/xscale/ptp_ixp46x.c
>      • drivers/net/phy/bcm-phy-ptp.c
>      • drivers/ptp/ptp_ocp.c
>      • drivers/ptp/ptp_pch.c
>      • drivers/ptp/ptp_qoriq.c

If a user sends the V2 ioctl, they'll happily ignore strict checks and
do who knows what.

With my changes applied, the core would now automatically reject the v2
ioctl.

I believe this is an improvement, but I'm not sure whether we should
just make this change with a net-next feature improvement.

Should I prepare a patch for net which updates the drivers to manually
check and reject requests with flags other than PTP_EXT_TS_V1_FLAGS
first, before sending my changes to the core?

Worse, there are a couple of drivers including one hardware in igb, the
renesas driver, and the lan743x driver which do some checks but which
ultimately don't properly honor the PTP_STRICT_FLAGS.

If I send these all together as separate patches, I end up with more
than 15 patches total, and thats before I've finished investigating the
PTP_PEROUT_REQUEST, which I believe is likely to have a similar number
of issues.

Would a series with individual patches for the 3 special cases + one
patch to handle all the drivers that have no explicit flag check be
acceptable? Or should I do individual patches for each driver and just
break the series up? Or are we ok with just fixing this in next with the
.supported_extts_flags change?

Thanks,
Jake

