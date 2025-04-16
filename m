Return-Path: <netdev+bounces-183541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA51A90FA7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E951703AB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209CA2309AF;
	Wed, 16 Apr 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uu+jTyKd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A314A4DB;
	Wed, 16 Apr 2025 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846510; cv=fail; b=VNxDZP7QgsRLUk2gdAjmLeRfHFYT8tEumIJ0f404q7ItSAFd0sIj3nLRD2vrDaf/QtzUrfvktcr0YgX+9SxaCegbMlK5Ncq8W802cQNEXejLFVH1JtqcPsO1PejsZU4TLB7rzv+PxfRtfQteqPSXab7N+vlQtUZ6HM6tjDPLNPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846510; c=relaxed/simple;
	bh=uP9u+r5INS6zDb3fSIt9wsPgX1WEn8yyULfm/3Hb3e8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxfZbgaFwZWS3h3ggE7oMcW6qNYKnaP/CF5c3LHeMbL5Nf6IefC3liQR2AkbpsxRCQD0tilJd5ufMp1WV590qwffFlcRvCdUCqutZGh6PlkwWkVPfYdVFe8bYV/Z94QcZi9egG0CFCpL+/GtyEERrDoedxhmQZwmG4ZfR5EPffI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uu+jTyKd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744846508; x=1776382508;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uP9u+r5INS6zDb3fSIt9wsPgX1WEn8yyULfm/3Hb3e8=;
  b=Uu+jTyKdai02gIZyvFJ43Q11awz86suTtfe+HA6tc0hC66WrR7WPw6qT
   VvOuuJWOdnf5wQrVnpxsTWM85hDuUFi21v9+ulGWXrWQxWy1ExIJMui2X
   IOOcbJoRGBNbfggSW5NDhhhAWC0xToUwVggab9mrQ/aBrzHZ9/YDhgXln
   2/bCc8msHPRleeqgiTXQjREXtbl6j7TAI3Xr7VLNQQ0WFCLL4zgAeKaBy
   Tn2K6hSQPtWhcdSEyj8k8ZDKanQzvL8hAklN6b9vWpqpS5ddIMJ5qTYhV
   VTgaXLUaRfwEc7/eHbGhBZDHMZNoToDGC9tzYiGvCdKOukJoGxkidBeoM
   A==;
X-CSE-ConnectionGUID: noxpszueReat6p6sM+pf0Q==
X-CSE-MsgGUID: GFIAiE4QSDugJf/IGjkRVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46584803"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46584803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 16:35:08 -0700
X-CSE-ConnectionGUID: GrWJWYUFTzmDBIulvWSYuQ==
X-CSE-MsgGUID: SZdF1a4nRYSCPrrKdlibhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130389955"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 16:35:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 16:35:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 16:35:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 16:35:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfUw1NxeyIjyH/ilaXMlBDACw7nZSUJhAON9OdQKwiy+aQVgrpSHG+YMS12s3uPyYKSlB04E2W4Wzl6FsFposc8XAcOADsUinwqJi0+20bW9X+BRhMvR7s05uBDzwWgGjKsi8yVnWTK+VkxFX0ykOgGMKnyWb6PKhbIebamBGfzhxZ3ZESWMqX4zhQ0RyEfZCKMGx2J1DvEwDvNDZgF4cB2U9+H3iwgFvyfDMQH3mGegOuJvWOU8oln69D7WKN0vJjGR3R3LbEuIyHWi7VAiGz/XJ5zvBKHgi4p+/wWhEYqEJM4KPHAdFkXF4muRHD2+I20IzK2tFg5CU5VVf5ITyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecN24dCUlqsSrkckkeeB3V9N1jCNVeYBeOo+lvDUHBA=;
 b=cCI6bOnkokuyuq6IMvh1vMfoJ6TVsRdQur4Vmgm6pbBqtCZmc+oBK/q6mtlIIUICW8PiOqgMFGVuUEm2voNnMXznfOIl/Q8H6TCZiH5Co6eTOq0bvNjCuDwbeBzk8C3bZRoyjAbCicSC8waYVo4uGnNw2e6d1oillekH8DVI3gexwEujuFrUVNSzXAQh7kUGf6qnTGK4qiV36IYwJIBN85FnK2UpZiVBS7kCD2peugc+JysvIAwaDHiwKZbJ/SC8qOm1AP6MoXFxK20Fa13eT+91ZuOj1/i35+KIl7eqtEnpZA89GjM8gbrBPv9BFVw9GbdAAr6pvV89tZPeMvapvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Wed, 16 Apr
 2025 23:34:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 23:34:29 +0000
Message-ID: <00b3b95c-7108-4fa8-9de8-ae19c94fe94e@intel.com>
Date: Wed, 16 Apr 2025 16:34:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 1/4] pds_core: Prevent possible adminq
 overflow/stuck condition
To: "Nelson, Shannon" <shannon.nelson@amd.com>, <andrew+netdev@lunn.ch>,
	<brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.swiatkowski@linux.intel.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-2-shannon.nelson@amd.com>
 <61b952ee-d4e4-4e1a-bee6-4bde45ec1025@intel.com>
 <ac965836-ee8f-4b0f-8a69-8a76aec7835f@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ac965836-ee8f-4b0f-8a69-8a76aec7835f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c064ef-c3c5-4265-3058-08dd7d3f3bda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGpFQTdiNlJGQ0IyaXVrSG1oTjQ3c2hiUHd4UklBSElFTWNJdEZ3bVFPTDB4?=
 =?utf-8?B?UFdHTjhZZ3dKcTNTSTMxVlczMCtVUjB2b2ZKYjZrdjcwU2FOdzVWWWtMNXdD?=
 =?utf-8?B?MTVIeEdxV2cxUWcwVW16amhpTTQrUkFVUnRvMG45cGVUNklNbnUybmZiUzVr?=
 =?utf-8?B?a1kzVXVoZ0F1U3FIRW1wUVlqVzRjdTFyWUx0Y1Z3MXJoTkdVMEpNRTZiejlo?=
 =?utf-8?B?dmxXTWJpeHNaM01tZUt4WFMrWUhSRGt6ajc1TWJ3MzRNSEdzWXpaakFjd1BF?=
 =?utf-8?B?Q3RTbUFqZVRMb1hmczMxUE9UT0NVbzlLc3FFcWVQRWVaMVZrTHJHWmRXRmVR?=
 =?utf-8?B?cjFEMFQwVnlNemlZQklVUzFEeWVseFdGeU5iNjNSZzFRc2tqUGdIS20zQXBZ?=
 =?utf-8?B?Vk94S01MWVNsZW5aMEpZcjhYQzUyKzFzbDRlbjYwb2lHY21uZURBSFRYWjV5?=
 =?utf-8?B?cFRIK09jT2dwUWtNRE95ZkRDSXpFMjRuQ3Z2Q1A5TVdZYzNuV3FyeXhucEFv?=
 =?utf-8?B?TkI4SmNVeURpZlJyUE9YMmVpTmdYdkRFKzFMVGswV3dVSGFEYU05Yk5GTHIz?=
 =?utf-8?B?M01WSm5IOHVUdklOOUh6QmlhaDdERkF2Y2ltQUgvVTU1VS9NbGNwWS92WVZY?=
 =?utf-8?B?a0VRbkNTVDVyMEpzdVVQdWpFdHBwWjFXL2s1UHVvRE8yVHpVNHl6MTBheTdH?=
 =?utf-8?B?VzV1YThJeEcvQTFQeDNSNnJDRFNLQ2FmUldGOGNaK1ZTYUtKaGhQejIreU9j?=
 =?utf-8?B?TGFyWXRReThDQ2Y3cXkyd2VQbXkwVkt2NXpJZnM3RmEvSWdRUU5UbFRzQW4z?=
 =?utf-8?B?VC95TEw3VngvL21SV3lTV0VEQ3d2WmIvTU00V01TOHgwcDNEWERPd1NQVHYw?=
 =?utf-8?B?aW5GNnJmSTZIR2VmYjhHRkFnTzN5VkxBdVdQVldOSFZVV05tUGRLTHNxWDI4?=
 =?utf-8?B?NlVmMitnL3U0Tko4Qm1ScTJZOTEyS2ZwNStsT1NqYTlOU3lndHZZVDhZYXZt?=
 =?utf-8?B?dE11TUR6MjJFUW5OTE8vN01qWjhqcGtmeEFXeERWOWtFWUt0Z3NiT29PYm10?=
 =?utf-8?B?eUVaQUlWZDUrTUxKMUdhUjBUUitWcGlkTENPNUJCOVpUM3VpS2VOZ0JQOUt1?=
 =?utf-8?B?eTdnWlhJNCt6eUEyeStmN2hFU1ptQ0ZIbEhURWlnN1pRbGNod2t0dVBqV21Q?=
 =?utf-8?B?SXEwWCtqK1NzM3F4WDdkeXRsTlhvV3lHOUNpbTF4OHhZN3ZsR3VuQ2xGRC9S?=
 =?utf-8?B?OHBiM0ZMVWE3VEpJT2hMVU41MEVRYXYzN3l1LzduNlVZWHFHZkxyKzVtdisy?=
 =?utf-8?B?d294aWdFb2ZOU1Z6dlJ0SXV3UDMrU3VDem02VSthb0VCOVNLOHd6eHR5Qmdt?=
 =?utf-8?B?b252K05jRC9pb2VCaHBNdUdzbkx4bEcyeGYvMWJ6WU5BZDB5dnk2bU1GYXBB?=
 =?utf-8?B?ME5NTlZCcGt5VWpEL2JKSFNqVFJhWFd2YjdKb1lETEJ5dmlEeVNnazVtdndj?=
 =?utf-8?B?bCtZWjNFUXJqVncwbm1vY2hQb1pwTVhNby9nV056VUIzOE9WVlYyV2tCdDlI?=
 =?utf-8?B?YWh6UnF4RktVdkYwSGpCWVloczczZTlWSFlPcDVxTGNVM2NMVDdnMldzaTJK?=
 =?utf-8?B?NHN3RnF1QnprM2tvMWxSQUNWN1EyK3lUdlJKcXNTQU1TTS85UEx6MXR2ZG51?=
 =?utf-8?B?dkxKdGNncE41VSt0dlZPUUhkK2cyTXNZNmJDMTdPSXBPSitIVm0vbWhqcnZL?=
 =?utf-8?B?Rk42ODhKVURKcWh2Z3BiWmpJOCtDSjQ2ZjEzMXl0YlZmVlAxY0ZWRGM1YURH?=
 =?utf-8?B?algrSThoOVhjcmVrd09CV2VHVkxsRHU0RzVENUlaL2liWGg3T0hmWmRwT2cr?=
 =?utf-8?B?MmJDcGpGZXpGNng1K0s4TWYrMXRWcDcraWtVRTltdlQxL2oyeXBLNmVtZERq?=
 =?utf-8?B?OXBsNjlLSkcvTWxOVFU1RjlCUktCV1dyL3U2VDRKT0Z5ckZ1ME5jOHd2KzRZ?=
 =?utf-8?B?SG9TT1RQQmNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVZHMmxkQVI5TG9KV0NSWEJDeHlwdm5DUG85Q09sYWZJRjlwS2JtOU5Vc0F4?=
 =?utf-8?B?NXk4UmhTbU51WWRkRW1sYkJDaDBqSDVKS01LNUF1emhtbWxZODBGUENkbGZ2?=
 =?utf-8?B?OTVHUFFncm0rZnZjbXFKNHM1ZGcraGI3Q1dadFhZa1p3Mjd5dTV4M24wS2N2?=
 =?utf-8?B?NThQTkVmcnhMczk4QUlIQjF1T0ZKenRJNVZHaUpFNXZ5OS9mWjZrVWlCWlM2?=
 =?utf-8?B?TnhidXRld0ZlQTd6VXdvLzZLclhJOFg3a2llaWlGb1l4TDNkNDNtN2dqbSsr?=
 =?utf-8?B?MXhkdlh4clZRY3hERE11Z0Z4S0JJQk1JUDVpY240MFNuZVRmSjdHaStJaHhn?=
 =?utf-8?B?b0lMb3NTZHVvVnVFdUNHRGE3TTlWWm1rT0hwTitXdUdYSVVnbTVLd3UrWVEz?=
 =?utf-8?B?aHNMUTA5Vm5LQ0ZBczFnTGgxcGdud05GeUcwV202UmQrSWEzc2o1emlnTC83?=
 =?utf-8?B?cUIwSXh3SE1uUWtyT21kZkZZelVRWXZaUVVUNlFadW5sd2RZQWRYcXd4RWRT?=
 =?utf-8?B?TjE5NUhqbm5EaE1EYTFiR0lIUVFkQUlKUDkvVUJPUVlaT01YTWJJRUVuUUFJ?=
 =?utf-8?B?NzdJdGhpWEl5blpJb2RVYy9ZN2F0ckZJbC9HQ3QxejB0UXIrYVMvdkZUUFda?=
 =?utf-8?B?TFZrVmtDTXBXUTJ1MDlXVFB4N0FBL2YyeCtSQUFib3J1c3lkakFrZkh1akll?=
 =?utf-8?B?ekJJWmwySm9Vek1wOG5SRXZoa3pmSldDbmtZNDR4cXBpVjc0VXFJZWJXcDFW?=
 =?utf-8?B?bU1sdEpCc0dBMHlrWEpuelU1TmJPZCtaYXhZVHNWVlNMTERDQi84cUJHUDln?=
 =?utf-8?B?U2xiOVdzWmxtVmRyQU5WYmt0bVdUOTkra0RMdDRUWUF1bE9UbzIyWkl4STgv?=
 =?utf-8?B?a1luazVHRE5CVnhmTzg5aFNCcXErK0tYQVVld0RWb3NCTzJuUDh3V09ZN0ZR?=
 =?utf-8?B?TWxKNUhiWkYwY3pKeWp5K0F2L0FrTldDK0Y3VkJpNUdRcXhvVjUrNmsxdjA5?=
 =?utf-8?B?YlpId2txa3hnamRRcXlFMEVXMFc1TFFVTmxVZklBd05MSGtqVnRsVUlrU1Np?=
 =?utf-8?B?L1hHcW1XTllaMy9qdURpR2pTNitvTmZ1T3JGQjhuTEI3R2FuZHJSK1hHb0JI?=
 =?utf-8?B?Wkk0T3VkbGNoR0sxYVNpdTU2SnJZc0w2SjZmZDdKZ0hLQjJYdVExOS9FNW9M?=
 =?utf-8?B?RFVqVGV0K3JxbDFNQUhBeEFpVmsvZjJJNUF5bEl4UHlVemVrWWw1NkYrZ3Z0?=
 =?utf-8?B?SXBLTUhPUExnaE01ZU5tQ0QzcmRHWmU1L25TSzRRL1pyd3hwMDFFTFRlQU56?=
 =?utf-8?B?Vmg2eVZsNEFxR1REWDNtbzZnQXhRWkdEbjlpMFhiL3ZhbkJETWpTKzk2K0NU?=
 =?utf-8?B?LzJUY0lpb09IR3oxcXVYU1NEUkUzVVVIYUpnamR3Z21XTmxaM1hBbjlPaTR5?=
 =?utf-8?B?MHo0KzIzdXVGZWs0TU1oMGpxYzJoUHpxa083QXZrdTBUaGhxMkt0ZmxkeVZw?=
 =?utf-8?B?TWtvb0xMT1VGY1lzb28yWVpvcUVlV0F0djhlT2RhTlNheERNU29iNEwwaUJh?=
 =?utf-8?B?V3hZWWxkanNpVHVGdmJNeVM1aWNkM1pMc2NKQXZTRmRTZk1rc1M3RlNNT0Zj?=
 =?utf-8?B?VEJ4bWZiYlNoTlU5NFRPenFLdUpydGhIV0dYUVozZDRZVUtaMUwrcHpPMEZo?=
 =?utf-8?B?RythS3poU3cxc3c3RjNpT1pJcWx4MWVacUFFVERMbnZnMlJEYTR1c3g0K3Nk?=
 =?utf-8?B?Tk9LUTFkaGxDaGJuanBHSnd1WG5ML3o2TDFxQVF4M2NHbmpaQi9mT3g4RzJI?=
 =?utf-8?B?RU9uTWNkMlpDNStqZHZGejhiR0N5UjJsd0FSWE5Dcld0SXYyMjdxSjY5eFBV?=
 =?utf-8?B?OFVNOTR4U1luSjdHalM2NzN3eWZnejh5RVRDc09HZHFjWUNVUDM5bGJFbTRL?=
 =?utf-8?B?UWI1MU1yeTVXUS84ZW5pMTN0ZklKOHM5d2wzLzV2SGV5VGRWV2FxVUFUVUt3?=
 =?utf-8?B?NGp6L3hobUMyQVRMWE8wSXY2c21JZ0NSSXJuWjJ3R1l5SzgwNXd6SE9QM1lG?=
 =?utf-8?B?U0RqdlRqb3o1VEdnMDVON2RDSHlRaGdHNFJlL1FuVWNUWksyUURnRlhHTElz?=
 =?utf-8?B?VHFLS0JrN1hBK041UnowS0lmaWttWDNZdzM5SXNyaXExNmNnMC9PUnZySnd1?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c064ef-c3c5-4265-3058-08dd7d3f3bda
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 23:34:29.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERdvnWsI+upPaWNW0Rc+1+R566/okng8eV8xPgueoLwxAVg74ev1vDr0sP0m3XwEN99ui2lx65Zcj4QbmTz/JIAGh9jaY5VTGH2kdnsr4cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com



On 4/16/2025 1:49 PM, Nelson, Shannon wrote:
> On 4/16/2025 1:13 PM, Jacob Keller wrote:
>>
>> On 4/15/2025 4:29 PM, Shannon Nelson wrote:
>>> From: Brett Creeley <brett.creeley@amd.com>
>>>
>>> The pds_core's adminq is protected by the adminq_lock, which prevents
>>> more than 1 command to be posted onto it at any one time. This makes it
>>> so the client drivers cannot simultaneously post adminq commands.
>>> However, the completions happen in a different context, which means
>>> multiple adminq commands can be posted sequentially and all waiting
>>> on completion.
>>>
>>> On the FW side, the backing adminq request queue is only 16 entries
>>> long and the retry mechanism and/or overflow/stuck prevention is
>>> lacking. This can cause the adminq to get stuck, so commands are no
>>> longer processed and completions are no longer sent by the FW.
>>>
>>> As an initial fix, prevent more than 16 outstanding adminq commands so
>>> there's no way to cause the adminq from getting stuck. This works
>>> because the backing adminq request queue will never have more than 16
>>> pending adminq commands, so it will never overflow. This is done by
>>> reducing the adminq depth to 16.
>>>
>>
>> What happens if a client driver tries to enqueue a request when the
>> adminq is full? Does it just block until there is space, presumably
>> holding the adminq_lock the entire time to prevent someone else from
>> inserting?
> 
> Right now we will return -ENOSPC and it is up to the client to decide 
> whether or not it wants to do a retry.
> 
> We have another patch that has pdsc_adminq_post() doing a limited retry 
> loop which was part of the original posting [1], but Kuba suggested 
> using a semaphore instead.  That sent us down a redesign branch that we 
> haven't been able to spend time on.  We'd like to have kept the retry 
> loop patch until then to at least mitigate the situation, but the 
> discussion got dropped.

Sure. This fix makes sense in that context.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> sln
> 
> [1] 
> https://lore.kernel.org/netdev/20250129004337.36898-3-shannon.nelson@amd.com/


