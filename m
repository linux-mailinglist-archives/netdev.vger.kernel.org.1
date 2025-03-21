Return-Path: <netdev+bounces-176669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6740A6B3D0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475523ADAEF
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F31DFD95;
	Fri, 21 Mar 2025 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5WwILl+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136D2AD0C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532418; cv=fail; b=hHwFwARHvuECbWajkXEKUWLZW6I/OoJVwfZdWjkstRvq3kI1XXuv5CFrSV3NV6IdYktuMXUlqnQiGSKaCLZns+D5z9l+Hv43Ixc+CRD7U2OOzGGQq3VDEvWjpcs+kIhFnOpjXtX51iG6s66SLxizkrEDS4vCKAyrrgDB5VNGK9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532418; c=relaxed/simple;
	bh=r+aq1h6zd3Dopt5g9SunL03xMVmimeCxq1IOH6L0G58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lhJBbUVd/+lteHYpYyO2MRaesVPi4EAjomroXdRWbkqp6w8YjnVgTImJpzOu8eGBTTkD5t8yGH2Bd5M1GzCPkWUkmjpuIL9a3WMA5cC8DvMJuuc6CNMfdCPjhXoFnE0FhaLQ8hkqypc1kV9/NARbYZu+lLFtflyXoNzfFTR2cJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5WwILl+; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742532417; x=1774068417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r+aq1h6zd3Dopt5g9SunL03xMVmimeCxq1IOH6L0G58=;
  b=l5WwILl+DHMroVlmri1zvMxfIPqmG1z4SooQWVDEdotcv5RZqkdZLnUF
   hRgxstgwPaoCm80tL3d43yKrQl3y0V414Xrv3bxcPQBP/P1Ldxz61Txq0
   X1ZquO6uNZmCQthPga9rUOvw7Yn2/lGJmMKnJeLGe4gQ/4f++LbSqdmAg
   pEDFEvI3h2clUQ3Zbmkx9yOpRL/LNO9h+bRu8ctQlqcp7dXca3eyVjklV
   V1qHFNrnYvlwB6oyC3cvgHmS3OmJnJVC80ELBBtSnUCGkEs5eSQHMdcsg
   0al6juMYETjQXZc62B9syMV4mzuSqTsvdqahsdL6CuBnwCIWQdDg/tCGf
   Q==;
X-CSE-ConnectionGUID: 6I4aWeQPQw2u4uLTrUtGyg==
X-CSE-MsgGUID: Wt4zXwqqTbKgEjgnqSGaGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43675212"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43675212"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:46:56 -0700
X-CSE-ConnectionGUID: 6h/kC9yrT2a2U2FJX9+yGQ==
X-CSE-MsgGUID: YI67tbibQQ6Mf94uKvPVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128360435"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:46:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 21:46:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 21:46:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 21:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+ZyO78e20JK3XnRGmMMUinEGAOLiT5m2Fz0uaflLIIA0CKpgE+lu0IyRmFEnuGxMm9zD+Y7doi2XZeasVxV2a0/YAZyE+rq39OvStwbNY5wYao3Gkfi03ZCgqaB545PrqDUZ0AtdIw7E6hS/UCcB1eLvV3u9uj/6nKE614wqloIG+W5y94Vgi8FKhnWYPL+fcwEMt+wLxI8GsGD/Z3VgDTxLsSbI0aG7NZkVli11yaN7SHVKCjI5Wu1afHIOzjO8L2tgAlFPvJV2cr5IVMfqntFMaMxPYryAYUKhx8qI0CkS8qX6gWYxEnthciShfTR2ARaaOeFm04RNRe5On4Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+aq1h6zd3Dopt5g9SunL03xMVmimeCxq1IOH6L0G58=;
 b=tfoR5aXKdvFIk+n6BuAZra+reBzrmEcR445bvSOb8iLjL9zx2nTz4md+Dp/9NXyDOa+AWpoQcLtmQcrFEilah1p67nsSkfRWvVf+iETQRSokJxlPm7RlkZcuh336NOuvpDGu7e4oQKF1cSfPkadmK+q36CL/GRyjTWG03jsMWOCO11D/qNjrSiJxFey1eaQEOZtPgywnGdf8J9QbbLqfpsnGfbJA1XB5ZAHAnI5JMSUpxVZrH1GLR9pkeIvoALNZN0VNujEzi4kID69EQ2O9TYX3ai+1zTqByuRmzL9GrmR5Rv8+MFwItyr/zwQ7ZquZjTas4MOeDb86QkuWU3oDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 04:46:47 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 04:46:47 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kyungwook Boo <bookyungwook@gmail.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] i40e: fix MMIO write access
 to an invalid page in i40e_clear_hw
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] i40e: fix MMIO write
 access to an invalid page in i40e_clear_hw
Thread-Index: AQHbkkS+XWofLfa1gEOleRR9tFMO7rN9AGrQ
Date: Fri, 21 Mar 2025 04:46:47 +0000
Message-ID: <IA1PR11MB62410B57640BF14F65A190958BDB2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>
In-Reply-To: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CY8PR11MB7083:EE_
x-ms-office365-filtering-correlation-id: 38c3d384-f46f-4fbf-e20f-08dd68336334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWc4MkdSNmgyTUU1WElHVHF3R0pCbmNyQ0kwRWltVGsrZERCV3FVd3k5Nktr?=
 =?utf-8?B?bzJNZUJCK0wvdXREckFuU0t3aW1qSC9sVjA2RS9xL2RxOTJteGJ1bW82VUIx?=
 =?utf-8?B?OHBDRFZMeHhTcTdqTysrWHVpd1dKeU9zNitSdlFwSTdnampQaVU0TVdLT2gw?=
 =?utf-8?B?ZklTZm82RUdMRUVMSU5BVm12QXgzc3dPaW5VeGR0YlZCZGcrUnFVYy9aVnJv?=
 =?utf-8?B?MXcrQnI3Wnp2cW82RWRGdmNXdmpuYjVOOVd3Zy93VHo3QzB6QVY5MnEraHM3?=
 =?utf-8?B?c2wwWEV4MFI5aUtNZE5MQXFPWlRmY0hPVnJWaERXWFREWEt5OXhIZHpkVWhh?=
 =?utf-8?B?WTVvbURwNTNRd2xLMDI5d1VnQ1YwWm5qOGY0bHV2RWFWbWVibGVhQ01Lb29y?=
 =?utf-8?B?TVZ3K2dCcDI3cmM5SnJEWTZJNkFZdnZ0VkE4UjV4TlFKeTE5TFkzNXVxSTJh?=
 =?utf-8?B?azFJM3VrZGF2K2QxLy85ek5EWjJPcVBGRzRRRWs5K2NJL0dSKzEza2tzTUZF?=
 =?utf-8?B?L2dITk9zdEhQcUlLT1pISHByblp6WStYdXZXZjVKc3dqOExlZG44S01nSE1j?=
 =?utf-8?B?RmZkTzkrM3ZmUmNGNGtQdmQ0S2NUd2xoNHhDdDNVOTF3aU9qZFJxbHpMVW4y?=
 =?utf-8?B?Qys4REh2b056c2NKRC93QzFodUpZWlBjVEo3MkpkMUplOWl4YTRQcVdpbTlk?=
 =?utf-8?B?YmF2NVFnaVRXa2swYVpZRDlJMDhrVkp1VFZrRFFScVhJVlVJVzVWa2REUk5B?=
 =?utf-8?B?ZGdJTldiV2M0aTVvSys1OUMwYzNTb0gxeEVwaCtmTkt1Y3lCTWNTN0R2UWN0?=
 =?utf-8?B?bWpCbkhZWHk1QUYzS20rYUVEeGJyT0dqY0RBS3U1dFhzTk8xWHEyQkd0Q2hN?=
 =?utf-8?B?SmpLWkxNWSthUll1RTIwa3lLeVNlWHd3dHZvSnZUTHc4ZzFvMW9GY3I5a29D?=
 =?utf-8?B?RkJtR0cveEk2WDQ5VW5WUnNqWlVGK1pmMnFYdnpuNEEyRkl1TU1jTCtNQUdu?=
 =?utf-8?B?Wm5CbHFqUnB2Qm1RY0Z4SS9kVUZLYk1hT0Q1L1cxUFRocS9uRktJbnUyUzRI?=
 =?utf-8?B?amZORnE3T0g1amhKQWllSDVSTjBzZFR0N3hOUnUxVndzaFlKSnFwdEZnMll5?=
 =?utf-8?B?NHZNV3k1TkZqT0dlcUN6VWNPSThaMHVEenZRa1dIeklqNk1WUVY1Qk13TTBX?=
 =?utf-8?B?YjZtOS91bnh2cmhQT2tiY2R6NWI5WlpjZ2RVZkdPandOdzIycGhwMGhLWWFk?=
 =?utf-8?B?Y1NEQ0VUOU5ubldLYnMyOXdSU012TWNzdVMvVXR3b1J4Y2RzR2tSZTZmM1Qx?=
 =?utf-8?B?Qll5ZjZWZGJoa0RHREdYNFk2ZzJsbXNKNjBqOVh6MjBRNHRiRW1STWZhaVVS?=
 =?utf-8?B?N05ydXV5aVNGUjdjWkQ0NzJCb2FBWjFMVkN2VEI5Q2JrQUpDcEhwRnVTbytj?=
 =?utf-8?B?QXprbWxURGVtUUlBSjJIY2dVYW4rb1QvWUZTTnRUcXlLb3I0WDl4aG9hcU83?=
 =?utf-8?B?UWhUTWh2S012ZkxqeW8yaTY4T0MybU11NUoyM2hINmEyRzV2czFMUDdXb3Nw?=
 =?utf-8?B?b2NuYzBXM2tDM2ExQ2EvME9JL2tkZmdlVXBQMnN5cHlqWXNTbXViV1ZTcXJx?=
 =?utf-8?B?OTRXajc3cjBkTWVBbWVicnRWOUEzbjFnd3FQc1FqTFREYjVZbjB6TS9obk5B?=
 =?utf-8?B?WTRnQlFKYWtQL0xzeHFIOVVCbFQ5S1N3MVgvUjJmRXJzK1BwbmplbmIveWRI?=
 =?utf-8?B?ZHNQcW5SRVluSjIxdWJWeVM0RU9aeXZXb2J3ekQ0UjdvUllaeGp1b1BmMmlh?=
 =?utf-8?B?cDJkbjgvY0NlajdLM001QzhuRkl1aG53MVB0RmVlWThTM3RVS05FV3lPWlJi?=
 =?utf-8?B?VVI4cjgxRWI3amFFMzVLZy9GQ05sZVZlVWdUVFVRTHY5K2dRYVYyWlRRSG1l?=
 =?utf-8?Q?MAz6zV4JbQcqJnwyQ9Pl4hrLMBuEda3T?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUFOaS9CTzJPSTdTclg5a2JXdHA5R3ROVGNoRnlFZ0ZBMkQvaTNTNkpOKzB4?=
 =?utf-8?B?bEI3a29BZW5KOXduRVBkdFI0dEl3TGg0SlFGYm9JNWxFUER4dHpCRlB5L2M3?=
 =?utf-8?B?aTJvRXh3U3pUc2dFWEVMNnBuWWs5Qnk5S3hMTVU4N0dSangvbzhKMkpGYW5l?=
 =?utf-8?B?aFlNYU9iajZyWTA2VXozVXRaZWhkNkQ2T0pwL3cxOVd6QitBWjBMZk9jT0ZO?=
 =?utf-8?B?U256SFNNQ0RsTDRITHVCT0FsNTB3aFNNajdqY01YcVR5cTdJNG9Oa0F3MGZ3?=
 =?utf-8?B?QlpybVM2RmlaSTRKbVRNZ1FPU01SSGVwS3phMDFkRkxMTEFpUUpLbkZXY1ZN?=
 =?utf-8?B?SExaRmIzeUxYcXR6azE5bHRvMUx1S0lYbUhXemhpVERqcEttdlh1dm9scDNw?=
 =?utf-8?B?eVBqVU4zdGRSMEVwR0hSOWZkUDY5WXNyQ0JOc1hQRjFXcFFBanVGOE5vUlcy?=
 =?utf-8?B?TTBPbHgzc0FROEI0bGJMOVBKSS80Q3dmamRjck91QUtRZVpGQjFzZzdoWXJp?=
 =?utf-8?B?cUd5VEN2OWpaV1ZJanVybDZ1RzNjOHY1VXRxZ3l4MUVGWjYvN25vR1F3RDVW?=
 =?utf-8?B?OStDVlJLMHdYaDF6dTNBVCtVVFZxWm9rRGVpVmFrbEV3M2xsUGl3eEN0L2R1?=
 =?utf-8?B?b0pUTy96QUNuT2s2aS9xYUJtQXBTamYzTFhYOGxPcXVEWHpWRit6c1JiTUtH?=
 =?utf-8?B?U1pZL2JHZXZkSnk0ZW9TWDVGSFRpd0RPN2ZyUWZWRTdmOXo0aHozRDh4VWdh?=
 =?utf-8?B?Mmg3REpMV1lRK1NwNTJRU2d3ZjFHeld4S1VNTzZOaVdVNXQ0S25Ha0Q5OVlE?=
 =?utf-8?B?VDZlRWgyWjRzRS9pa21jOW5rZTFYK3hkTDd6SUl3SHlZVy9Gb0NwNlVvc29H?=
 =?utf-8?B?c0pYNDBTNE1MaG1PL0pKc1ZoMUo0TTBLNDJOdVgvZ3BQeURXWjJiUDdXUUpP?=
 =?utf-8?B?QUhYY2dWUVl6eGdIb3lCOG5xQUdwajNzQ0lxeTJncUxJaHlPQzVjRGdvdDNF?=
 =?utf-8?B?R3BkYkcwL2xtYkY3QWlrTjJsMVAvZnl6bGs2ODFvUEVzK0VnQ0ZIVjY1SXA5?=
 =?utf-8?B?N3VwK2dTSzVOK0RjQXRXMy9nQ2d6czlOSy83bkNKQ0Z4bXhxMWRRNzV2Yi9I?=
 =?utf-8?B?SGpnMVRTa2h0YzBJRUZEM2tBVjhlOUlyZEg0R08xVEtHWk9YRk9TMVBCcXRY?=
 =?utf-8?B?VTNNRFZQR0ZlU0tYOVNiWmorWGtIaGNiZjZlZkxXOHBBZExWcm02UHovenhS?=
 =?utf-8?B?dWVodDFaVVhMVytISEJiN0FkbUtsK3h2QXdRV3IxMUpxYXUxRUdTK1luR0dJ?=
 =?utf-8?B?ejNYNllnaFBVV0U2aW04V3FzcFR2WkUrdExHUmhCZlRWakoxMkZleWZycGVv?=
 =?utf-8?B?cDdCdEYwZ2pzcjBjZ2pNWGZEU3FFbjVNaVdPZjYySnF2Z21NTmVUUk9qczVq?=
 =?utf-8?B?c3A3QTFlZndpditicXdycHBubk5PMHkyTU9lSnFobGF2aTBOdVRXUXpzU0Vm?=
 =?utf-8?B?aU5vUkdzZDU2bEFhSHkzbTNsK2FiSThMUFplb0JmZnpVWE5Rdk1uSVozM25T?=
 =?utf-8?B?a1AzWVpNOWQ3MURnNXBtcGU4dlV3K2Q5SHRsYlNTeHJDWGJDNmJhdVlpRWs5?=
 =?utf-8?B?SUhOclRvZnhWZWFsMU1SNmZkTHNHeDc0aG1QdjdpU1ZZeVNBYUgrRzVpKzRP?=
 =?utf-8?B?L2dlbmY2Y0lVQ2VxOHZmTFgrY0NiMzhkWklPcFRVN0lGenQ3Um1GcnM2Y09P?=
 =?utf-8?B?Y1krOW95ckFZZEpNbFJCYW93YnhiMUI4eWlTVncvYlgxRFFLSk9qYzZEdzlo?=
 =?utf-8?B?Yzh5cmRZWTNuMUxMNzhkZUtUcTlJM3NYMk81QlFzZWFDSDl4S0FHdm1iRzRx?=
 =?utf-8?B?QmNxTmY2dXFuTWNYanRYTUx3OHNhbVFRcGV6bzlDS1hzWEt6V1h6WlVhNHNC?=
 =?utf-8?B?U1BPWVI4NGRjdHVxTldFT1h4VzBGMTlJZUY1S1Q5Y0h2bEg4UDAxaVhMVm1m?=
 =?utf-8?B?ZlFoSXVvK0o2Uk4xQzF0UDNzcCs1Y3BRRmYxMDVrRmVObHViUnhsZm1kNjhv?=
 =?utf-8?B?alNldVp5RkhZZmd2Q2dheWZ2ZHEwYkpvdEtaaDk4cEhYNmlKelpWMzFHRklK?=
 =?utf-8?Q?uj1enKD3LeG4gz/MBa61xPidU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c3d384-f46f-4fbf-e20f-08dd68336334
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 04:46:47.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKvEeZzcLg7zADohKGC9bIQ5uZ0Tcu571OCIcJcLOX24p6pYGVkTq6QkkajkZ/7+TMbp7bIsqfuio0mj5Z5PqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBLeXVuZ3dvb2sg
Qm9vDQo+IFNlbnQ6IDExIE1hcmNoIDIwMjUgMTA6NDYNCj4gVG86IExva3Rpb25vdiwgQWxla3Nh
bmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcg
PHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+DQpDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5v
cmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIIGl3bC1uZXh0IHYyXSBpNDBlOiBmaXggTU1JTyB3cml0ZSBhY2Nlc3MgdG8gYW4gaW52
YWxpZCBwYWdlIGluIGk0MGVfY2xlYXJfaHcNCj4NCj4gV2hlbiB0aGUgZGV2aWNlIHNlbmRzIGEg
c3BlY2lmaWMgaW5wdXQsIGFuIGludGVnZXIgdW5kZXJmbG93IGNhbiBvY2N1ciwgbGVhZGluZyB0
byBNTUlPIHdyaXRlIGFjY2VzcyB0byBhbiBpbnZhbGlkIHBhZ2UuDQo+DQo+IFByZXZlbnQgdGhl
IGludGVnZXIgdW5kZXJmbG93IGJ5IGNoYW5naW5nIHRoZSB0eXBlIG9mIHJlbGF0ZWQgdmFyaWFi
bGVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLeXVuZ3dvb2sgQm9vIDxib29reXVuZ3dvb2tAZ21h
aWwuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2ZmYzkxNzY0LTEx
NDItNGJhMi05MWI2LThjNzczZjZmNzA5NUBnbWFpbC5jb20vVC8NCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjI6DQo+IC0gRm9ybWF0dGluZyBwcm9wZXJseQ0KPiAtIEZpeCB2YXJpYWJsZSBzaGFkb3dp
bmcNCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvNTVhY2M1
ZGMtOGQ1YS00NWJjLWE1OWMtOTMwNDA3MWU0NTc5QGdtYWlsLmNvbS8NCj4gLS0tDQo+IGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9jb21tb24uYyB8IDcgKysrKy0tLQ0KPiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0
ZWQtYnk6IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29y
a2VyIGF0IEludGVsKQ0K

