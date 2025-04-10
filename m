Return-Path: <netdev+bounces-181068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72637A838D2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5600D17D0AD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBD12AE84;
	Thu, 10 Apr 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Thdm/Cb2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D795E1FC8
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264906; cv=fail; b=WJF5XKz2CO+XTxSn6/DfZ4V5hpXZMj061NxGDmxhFvhlE3EBcwJMyieSrAkKIy0u0IFrjoh3TgtroNg1/dbsYSzC2JU7UL1pu6jyx/0xcPCzFVhRiSEbduVDUUZSW4eldvbpWEhsaubDxIi5THvAo11OWmCoLOr44kA5LlRU6jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264906; c=relaxed/simple;
	bh=0hyh6qX6EBDUgSbsOShRtPV5Y3lw/Uy2PMdAc7KVFoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7g8kxfPR5Nta5XCm17YBYCqf5N8UuR6pE+xoAAbXYkM2yWXSykUkyxO0rkHARnCs3ji35wcioY4jJxFEf6xVPbkh9vT1X8dZ5R1dnV/eKKTmEaSDOt0iKL+Fshs2h64ihpjM9Npvu5Q63NDUJ1JH+CBmo9Ov+MHjc5h7iytYcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Thdm/Cb2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744264904; x=1775800904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hyh6qX6EBDUgSbsOShRtPV5Y3lw/Uy2PMdAc7KVFoc=;
  b=Thdm/Cb2ItSWNgV/aC0tgCLHVOj3mOBUpXUuG72fhXiGgdn2Sxeh6Dzt
   MS3eNEq8zIhQxRFkTcwVNhW12O0NMiBs+N6wfCDqgVoikIhGcDsjZpEI1
   /fSY4v3QeAnb8P/xQ02TYDFIW3pLYEdQguCU/jq0Zcmicg4ZwzJ1F1PvQ
   reRpSJJIYNx4xnwM77MzyU7YIWlFM3Oz23LC1c+JsBpwFgh/iU4ip+BWb
   xq36/0toLbbzDU644f/pLYTbGNylAuOl2gP4bm1FY6EQbJhLBUUzMaPPp
   zwfTpw9seA1+u7o+R8pp1wi71etUDzDYukfWlDmHXt6cf+a5dR9MwrKe4
   Q==;
X-CSE-ConnectionGUID: hCsI35+YTzutEgLa+XbVZg==
X-CSE-MsgGUID: PhrAK9rVTDGzjCsaaH0MkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45933005"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45933005"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 23:01:28 -0700
X-CSE-ConnectionGUID: LCIekEyZThCyLwS7ndWZvw==
X-CSE-MsgGUID: o7Sw/51GTS6zy0WgNTKWbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="132934444"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 23:01:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 23:01:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 23:01:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 23:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTs8yQs2wQUThBl4BpKnhWPn3Vi/HJb/k3TshExpCO3R5J4OIgE+n7t13kQxwedrChhi8D1lZgAjycvRKz9/RM36tEJ+/JsyGMvJH88ufdX85G6L8tr+YzIYXkYStDTOXgx5qGELeBM5J3mTdaSVCm9nbfmUJsgF91uxqB5rnd4cSuZxWZGU0ZcT1kVjobwBug9FzOUUHzVJWNVMLCsMi0vvUOm41EETaEmioWXzsPKfi7sv3eGkL05VSFHsLbiIuLaZ01a6QsicP+KF2r675z+CQaD6Af1XSb8wdAyeoRLoFJQgU41MN1nBbGzIDYmNNq5qqraWhdC90RlZsxtcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ7cMatzG94uUfE7t2nAywUcODxGsdLtHQf2/Dl/v6U=;
 b=o3RlM98EGm5kHxUkoQilmToC1MPSiR9HI1GH3zXk+fLPDN9agAoU1By1gdKeZL3tzzT/o6lo15+uYAsBno/9dsu/EpIhwADFFayqX7hGpN/U3C84+r2+swPR0Z1FCNNvJHHnbiAZFQH0/7e3mBfH5gWWKAZjCWec9EpcfRrQZdlukIoIpaMZmPiMTWzQiPMdS9rKGCclDrqTPV653dA0opQ6kehWEuDxCu63FlY2O6IYz9hBaPH/ZzhGhk8TWOKuKoH9WqXRleahSAiCi9LmOM2+Zlm019ZSDHbiCH1O2pjhb514FvBLgMK+ujZYqD+0Ply9VFjJ/PFX8JEFQEVWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 06:01:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 06:01:20 +0000
Message-ID: <119bf05d-17c6-4327-a79b-31e3e2838abe@intel.com>
Date: Wed, 9 Apr 2025 23:01:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <sdf@fomichev.me>,
	<hramamurthy@google.com>, <kuniyu@amazon.com>, <jdamato@fastly.com>
References: <20250408195956.412733-1-kuba@kernel.org>
 <20250408195956.412733-8-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250408195956.412733-8-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a3d1df-0e39-49fa-28bd-08dd77f51d88
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXMwanJKb3pKQ1AzUDJyMEZKRHJkaXY2UjFieEliU2ZjWHkvNkphdTZPcFZh?=
 =?utf-8?B?aGFxQUxkQkFzb2Z3RVRrWHYyRjIvL0Z1VEwwdXVUMkk1UEVUWnkyMy80eXdZ?=
 =?utf-8?B?Sm1HUW9rZGYvNzJQTktqeStKcDk3azFuN0tmdURUcE1RalBQQjJZWHkzb2dv?=
 =?utf-8?B?OWUwc25jY056cFN0eFdZeDEwWS9lSWUrSUROdlpsSVp1TWtMenh3L3lMYnZo?=
 =?utf-8?B?VXFLcGx5V3ppekl2dmR0TVM4MEFRZzNCVEgzenJpa1huQWxYY1hyWmEvTklX?=
 =?utf-8?B?NHlRbVhGdDQ0V0k5QUVYR0F5ZEFCN1NkTUVtcEJlU1dCZG5ZeU0yWk5tdGhy?=
 =?utf-8?B?cDVldmIyeHZSNnFrM0tBRzFKT2kwZFMyQXcxeFBFaWJXNk01SHZiR0ZaREcy?=
 =?utf-8?B?UzJ4eTBrTFlHQlNVN0labzJ4RHd5MkVIdk1PMjd3SHVqRndPeGhiaXRxVTlW?=
 =?utf-8?B?NnRyK3dRdTZXUWpoVGtGcU0ybnZpU1NFQlZYbXg2alBiTklJZERqN25iSDBQ?=
 =?utf-8?B?T1NjOVJURmgvSjM4L1R3OHl5eWQ4VUYwaDF1V2YwOElUU2R0bEprRCtMREpM?=
 =?utf-8?B?eEVka1FCOEJWUG5UTEpPTzZLa2dHSDlKc1BPUlQzY3JaREY2NjNoWmllQTIy?=
 =?utf-8?B?QUZDemZ5RllkMlFRcGlsK2dUU0hmaWQ3VDhKWjZsQTV2eUVJMWhZaUZHbTlo?=
 =?utf-8?B?cW5Gd3kwVVJDQWlQQ0ErR2ZmRzFpUk1PRU9oa0dBVk5BN002dndEWlZqNEpi?=
 =?utf-8?B?bnNxTGdrWDg4MzhlN0M2aEpKbWRrUUswdnhxbTdpMytXWXNuTEhsTUZuMmdl?=
 =?utf-8?B?bS9zd1EyQ2kwNWxFSmZCbVJxNEZsS2dDSEhBNE8xMXZmTFhYN0lHRjVWdXN6?=
 =?utf-8?B?TCtUOVVmeGNhaFZWVkEzemNxNXB5aVZtZ21FbERIZGRBL09VYVJNK1RBc0dm?=
 =?utf-8?B?LzNibmtnTFg4U1R0WHMvQ0VJY2puYnM0dzl3Q3NhSzNRQnpIR05GK0tFS0x3?=
 =?utf-8?B?YTVFK0xubTZxaUxvVTZtdzBTVWN1UU5SNnhQcVFWRjJIMmtsN2cyNzJKTHRD?=
 =?utf-8?B?RDFwQzF2ZXFReWl0NHFwa0VXaXhMSm5yM2w3OE1xUmFyRGVROEFhTFpFRmo0?=
 =?utf-8?B?VTRWZW0zU3hzTGUxTWJGMm5TVEp4clNJdHR5K282MFpISVRnZnhEbWI2c3RK?=
 =?utf-8?B?TEJFcDBGZFJVVTZmRXBkcFArTUFGbUFYTzExNHZ0RjNrL2NFd1o3WlJiY3dP?=
 =?utf-8?B?SDFKcVJVei9QZlZkTFJ5aVBsdVVtSldqVHh1SGJtREQvTHFwb0JZQWdFZnls?=
 =?utf-8?B?NzA3SUlBM3Z1YWtpNk1PTCtwcVBIbU05ZTFxNEdicEE0Ni9BUjBWOXVrdmpN?=
 =?utf-8?B?aU1jK1F3KzlueXFhODhuRytTRFhSUHBvOXBLSVVCTEV6cEhuM3NhTXZMVC9R?=
 =?utf-8?B?UG80TitVblcyTDF0aWVZL2h6YzZDZy9HYWlUQUJwSzlpSGsxMFZ4blBwRW9O?=
 =?utf-8?B?UHVOeU9TeXhEL09jS0Q3NEhma1hBWm9wQ3hNemdNMjhrcDJVN0ZsRUV0b05t?=
 =?utf-8?B?WE04SVg0NFA4NzF6M1E2RmRPZ1ZlckQ3SDNDZnQzS2RQZ2NjcDdTZlNlVXoz?=
 =?utf-8?B?cGdrWks2bG5YREpyK2lpV3ZHSjY2SW96SFVsZS9QTTMxTXByK2VFVTNjK3lt?=
 =?utf-8?B?OGZ5M29GWTJzU1F2dU9IT3QybzFHUngvc1N2Ri9mWElMc2tYUExTTFRtSE4r?=
 =?utf-8?B?b3NVK0hQTit3TENidVRmb2JGb2RyTGl3Y3c4OHZRcUpRMFJ6K2UxcWEvcWNp?=
 =?utf-8?B?eS9hYnZMcG93M1JBcVd2VGVZcFYyQXNlQUxyS0RFS1Joa3VVamgxdW9uNE9X?=
 =?utf-8?B?NldOUW1yWDExcmtLQWx5cXFWaHhhS0FjckV4U3BxVTEzMjd4eWNTUVdacjdF?=
 =?utf-8?Q?MT+Nk/lxQyw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBtVnNIVDgreCtzVGNoaFdyd1BqdWl1WThkTEVZdzBMRzRZeGloRnA5ckZS?=
 =?utf-8?B?MDl4Nm4zVW5VQWN6a2ZjSW9vdFpwaWFBZ1RFVE16NEFKU05HSmd4UmpDUHRw?=
 =?utf-8?B?c3RHM1B3UjJITFRabzFIcjE0bnNzKzlnRzNGY0dyZnEwSXV4MXgyRm9nWTVT?=
 =?utf-8?B?UFVWN1VqQ3dHeG5peHo2NEdsT1l3L0xWRE91dTFLTVVsaStZWHByMHQ2dDlN?=
 =?utf-8?B?NE1ad1ZvcnhaekVxYTN1UDZPdG4xbkh1MktZalM4QmhEL2IyVkw1V0RBbGZk?=
 =?utf-8?B?NHh6aFNZc2dtdmtoVGtJOTM1UkErSm9UbE94Ny9vN2ZGazAwZEVLTThCWVJS?=
 =?utf-8?B?VWF0a1U0RW5rRVN5OUphNWxVNGFCV2tZNVNVaFZmTFhyUkJFUmUzekhQUmc5?=
 =?utf-8?B?YVpVYlZabWtDS1JwZlk4QW8wLzdwR0c3VUdvNjRNZFJIcTdITW5MU2MxSFpk?=
 =?utf-8?B?LytjekdOTXM0YmovRDhiWTcrRVBPV09VVk1NSi9FbjAxZlYrSDljdDlMUG5l?=
 =?utf-8?B?bVZLbTlyZmdvTVNGQjhwd21lczN4VHJ4RDlhMlBzampjSzJpZUJsOTFEZTZi?=
 =?utf-8?B?QzEwTlE5QnYrUTU0SjREQm9WeEtLL1VzVHdwMHpJNDlMbnR5V2RGd1F6YjRS?=
 =?utf-8?B?Z2dUeFRzVHNITXlvR1lKdGlLdlpwNUFUbFgxeVF6b2hyS3VKU0xwVktFQnJK?=
 =?utf-8?B?V0NreUpPOFFsbERMUWlzUkNacExVMlZPbDh5WTFsQUJYVkM0RXNkZkhnc1Zp?=
 =?utf-8?B?bTFCTU5DS2tDOURXVFY5UGM0NE9IeUJHZ1N3NnRxVTU3TFBpS0hIRmRVR0RD?=
 =?utf-8?B?NGhWTU1rSEl6QlI4c1YvSWsxalZJL1VhMXBLd2xXM2pLZWt4RzNhSFBKN1gz?=
 =?utf-8?B?YUd1WlJlcm94Y3NSV2dpMjhTVi9Cd0c2eFB2TGc0SnRRSHduRmYvYnJ2Wjhr?=
 =?utf-8?B?Unc2bC9KdGJXY0NPUzlSMDJrTEhFTHVselFRYWJBTnVSbVlCcUlsbldTQnFw?=
 =?utf-8?B?aUl6YUJlV002dDVvUFgyakZaamNzMmI2NkdSOG1UYVJ1UW0ydTRVQkVnQ1g3?=
 =?utf-8?B?SnJkRlFJekVHaWNzQUluMUk2UXMwcEV6RTRZY3VXVDgrRmZDNEZ2dDlZNG95?=
 =?utf-8?B?Mmk4ZVk5c3M3K1BJWW1nUUcwOEcwR3g2dGJmaGRTWGdQZ3k3czNCbzRkVDZP?=
 =?utf-8?B?MVp6bHNuM0RNNWdQa0J0dk1XejB5eXJheUZtYmVieUV0eXV2bWZYUWFtL2Qw?=
 =?utf-8?B?aStndWFCU2dZMGRsMElGNEFwb1NWeHVwUFlmNDYyc0wvL0J2T2Z2ZndTa2hY?=
 =?utf-8?B?dTBIdzFxSGNJM3FKVGxzeUZkdWVYSUx1Y0ZaRUhvZTdKRWN6aTRkQjlwQkxU?=
 =?utf-8?B?L0dsQVYvT0NzYStoZ0hHMS94aXE1SHpZTmMrOWE1UFArTVArdjJDQmxqNlF5?=
 =?utf-8?B?OEpTaFlEbUpwT2s1K2VSa1FkVDE3bHNESkQ5MTlUQXFUcWtwanh3RWVEeFpH?=
 =?utf-8?B?eEdYK2E3WU5GczBEMU1EZ21iOHlYRlU1K0lYcUhMYXlPSmJ2bXFndTNRY1Vm?=
 =?utf-8?B?NjcxZUJ3aVhmM0NLblU4S1YvbTYxU0tuUDV4dGMyd2RGbTNjUnh5Z0VCOHBP?=
 =?utf-8?B?YnRXT0FtVUVMNkVwcWFPaGp2cEs0TkpYNlV3STlTeVVpZlVNUC9DTjVJQnJC?=
 =?utf-8?B?RXZvRC9kSllNN2pyVnp4YVpOT2t3L2hvb0hNK2NvSGJYYVZ2T2tBR0lmWkNs?=
 =?utf-8?B?R1VOMXR0dmlxZTU4LzMzY2hwdE0yNmNPaDIvL3gwN1RKRUNjRnBtSE5GNFJL?=
 =?utf-8?B?Y1NQbUFWY3ErK2svK0gvQldKQm9UTXFFVmNrUTVxZXgzYlNWWmR1cmdVeld3?=
 =?utf-8?B?aUlseDB6N1hGUUN4Z21Rc1NhNGxXcHAwY20zeG1mc0lRWktBdW5zWkU5aEg1?=
 =?utf-8?B?QmFTWnY5K1E0M3Fsc1FPa0FwS0RaU0dRYWpOSWdCWHhCUnVaVWEvc2xkUlJs?=
 =?utf-8?B?SHc1a3N4aUVRNzRSZndhaTNyN3N4cWYzN1hMdGRDZU13a1VSMTdBT2VZKytT?=
 =?utf-8?B?M25peGZTUStFam5CYk04QnFkSUU0dUZLUHRxZGcxZnluYTBKYnNySnZnZ3dk?=
 =?utf-8?B?S04xV3AyUzZ5NDhRTmlOcUh6VG1pcG51NDdhNWl5bnZqemxDVG50RmRmSDYw?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a3d1df-0e39-49fa-28bd-08dd77f51d88
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:01:20.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKe44zNCweDMGqTni85vY1c3DANPfCwlJ7stcWn6cTb5WTqnj1Up4lRfgP69P8g0cmUeCWcTXeDc7SIfSBuVmvPVLp93F7zsGnY55EmMcMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com



On 4/8/2025 12:59 PM, Jakub Kicinski wrote:
> Explicitly list all the ops structs and what locking they provide.
> Use "ops locked" as a term for drivers which have ops called under
> the instance lock.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - an exception -> exceptions
> v1: https://lore.kernel.org/20250407190117.16528-8-kuba@kernel.org
> ---
>  Documentation/networking/netdevices.rst | 54 +++++++++++++++++++------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index d6357472d3f1..7ae28c5fb835 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -314,13 +314,8 @@ struct napi_struct synchronization rules
>  		 softirq
>  		 will be called with interrupts disabled by netconsole.
>  
> -struct netdev_queue_mgmt_ops synchronization rules
> -==================================================
> -
> -All queue management ndo callbacks are holding netdev instance lock.
> -
> -RTNL and netdev instance lock
> -=============================
> +netdev instance lock
> +====================
>  
>  Historically, all networking control operations were protected by a single
>  global lock known as ``rtnl_lock``. There is an ongoing effort to replace this
> @@ -328,10 +323,13 @@ global lock with separate locks for each network namespace. Additionally,
>  properties of individual netdev are increasingly protected by per-netdev locks.
>  
>  For device drivers that implement shaping or queue management APIs, all control
> -operations will be performed under the netdev instance lock. Currently, this
> -instance lock is acquired within the context of ``rtnl_lock``. The drivers
> -can also explicitly request instance lock to be acquired via
> -``request_ops_lock``. In the future, there will be an option for individual
> +operations will be performed under the netdev instance lock.
> +Drivers can also explicitly request instance lock to be held during ops
> +by setting ``request_ops_lock`` to true. Code comments and docs refer
> +to drivers which have ops called under the instance lock as "ops locked".
> +See also the documentation of the ``lock`` member of struct net_device.
> +
> +In the future, there will be an option for individual
>  drivers to opt out of using ``rtnl_lock`` and instead perform their control
>  operations directly under the netdev instance lock.
>  
> @@ -343,8 +341,40 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
>  acquiring the instance lock themselves, while the ``netif_xxx`` functions
>  assume that the driver has already acquired the instance lock.
>  
> +struct net_device_ops
> +---------------------
> +
> +``ndos`` are called without holding the instance lock for most drivers.
> +
> +"Ops locked" drivers will have most of the ``ndos`` invoked under
> +the instance lock.
> +
> +struct ethtool_ops
> +------------------
> +
> +Similarly to ``ndos`` the instance lock is only held for select drivers.
> +For "ops locked" drivers all ethtool ops without exceptions should
> +be called under the instance lock.
> +
> +struct net_shaper_ops
> +---------------------
> +
> +All net shaper callbacks are invoked while holding the netdev instance
> +lock. ``rtnl_lock`` may or may not be held.
> +
> +Note that supporting net shapers automatically enables "ops locking".
> +
> +struct netdev_queue_mgmt_ops
> +----------------------------
> +
> +All queue management callbacks are invoked while holding the netdev instance
> +lock. ``rtnl_lock`` may or may not be held.
> +
> +Note that supporting struct netdev_queue_mgmt_ops automatically enables
> +"ops locking".
> +

Does this mean we don't allow drivers which support
netdev_queue_mgmt_ops but don't set request_ops_lock? Or does it mean
that supporting netdev_queue_mgmt_ops and/or netdev shapers
automatically implies request_ops_lock? Or is there some other
behavioral difference?

From the wording this sounds like its enforced via code, and it seems
reasonable to me that we wouldn't allow these without setting
request_ops_lock to true...

