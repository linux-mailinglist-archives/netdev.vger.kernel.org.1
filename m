Return-Path: <netdev+bounces-183484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62841A90CDA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D99F443ADB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF27226CF5;
	Wed, 16 Apr 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqHLsxPM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03F22688C;
	Wed, 16 Apr 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834471; cv=fail; b=bxgJYLub45dKqLE0lJJ6zNZArDWenDvytBF5Eq8w5dVBbzdzdmBt7T7dJTZ1PR6rgJNiTRgR/eSSPtJKbIXCRX96ODS3SHsm+TO9GnRsMOBV0nxgdYnMWCNpNM1r31t7gUMBU0GuPTPOMrI4WaGnD/YWGCziFsIEZIektVCRUks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834471; c=relaxed/simple;
	bh=efkFp/LGVr6+tco1lCozx//RNNhGVCIHYLFUFKS1fgQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbSBn8dBTIqU8LhXs6uyflf7SPtvWCVEW6CT4DRwS0X/+NSAYYTypSLWbjdeCBSqIcksSLgtDXyjsxbcR1nFrcKX0KEmrxt55TFL+HsRsR7SRDcklJQW5T6tlw5ouJUCYQzWZoE5QG8P5TdYyxapCxisNyq3qGN6/zdwYqpyXzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqHLsxPM; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744834470; x=1776370470;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=efkFp/LGVr6+tco1lCozx//RNNhGVCIHYLFUFKS1fgQ=;
  b=ZqHLsxPMlGcUDYItDsIx0G7M8ZlCKOAVSlPPN4lNxgd4HgTxdzsFqVU7
   wWVg0L6enlZI2ky/fSRmylj/fJAP8Dkq2WPGACx1oDbJl3zUuVFIO6O7g
   NftpHpyk2B/HuhcTFnbaIrhkV974g2jOO1NW1WgDdrE+uPTgYVHv/o3uw
   Y/v1QXkHlGmp26TuLa+hgR4G8ySrghaehR9fYQTcnaqd9HUukE+a+bcLU
   Vld+3ulWfzQCg9NP2PZkyaPt5p9cwGmyzPDSf+R6I0LKzQy1Fm4WvXkNQ
   pKUcicDlzxy3GbLuxKU18XOBaQGBSkp6rDJ1daDZvUctJe/Spk5Vp3gjj
   w==;
X-CSE-ConnectionGUID: i+X4jYKuRg20CDIDy879Wg==
X-CSE-MsgGUID: g2ElIlQ0TL+FlT/OvlVcZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46118326"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46118326"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:14:30 -0700
X-CSE-ConnectionGUID: RCI29ijRSlKDdwV7fR8qXg==
X-CSE-MsgGUID: DJJudDhvRXi6wa3lENupMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="135447621"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:14:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:14:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:14:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBla2mqqB8Tq2wRbpsgbq+ioIrsG8VGsi6v/j1mTqwLcRJBSKiNgLQpv+Y5PxtQ4ld1qPBM/J9Nrwuothy4EyPglSkv/xiD1kRf+qGhhBzaR6FEJM9UoQ4CXk84nhW7xv7o0LVCbO5v3i21JA4PfNVBsGXg9A0keUrpl6Z95LPhyewZIAfYTmvdNx0sxT10cl+X64ImB4oPaJ0rXjEiBeAPNWE86zjSZtvMk0xlDgNIHAypZMmk0F7OfL5ChO7EMC5PfBT6M3MU08ylUVHMA5LDJMEcKuejVaRponjO36c4MEq6mMaedEbf39KrC+OgSdfhnlipS7ZTdoyagsKbNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acpwgGsJH1gD6iJhPqaxZ05J/89ZwTKSTca7u5AgwYc=;
 b=VFVQLmImZ0dTVjjuqY0/SzObrLxGRJUvpwSvt8qljiSe9OCZCeunRvM0JavsebV9Pd197QpWXmRRDa1WPLLCzOdi66fG4aTQjqxQu9v1ObbioCAkq5hE7HXjM5DT9u8uJ37UbruEKtLcPP3Ax+LaAO8tZutueXRkb1qkVQhBDFsXyYJTAL4XUJBZ2hGyy/AsR83nEKOrCW6DU04SMEHm7I6NThgscj3Aif5ws/z2reeD7xj0RFqlR8w37B9F0diKDRYQBFcsV+pX9evTsygDECinjxRy7/sDi1Fifls8B3E+k4nf0YyjClz7UpAac1XMn10W31Kc5yg6GN2dFO56bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA4PR11MB9251.namprd11.prod.outlook.com (2603:10b6:208:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 20:14:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:14:23 +0000
Message-ID: <ceeaf753-f6ab-4ea1-a955-c53409cddbe8@intel.com>
Date: Wed, 16 Apr 2025 13:14:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 2/4] pds_core: handle unsupported
 PDS_CORE_CMD_FW_CONTROL result
To: Shannon Nelson <shannon.nelson@amd.com>, <andrew+netdev@lunn.ch>,
	<brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.swiatkowski@linux.intel.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-3-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415232931.59693-3-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA4PR11MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: a18389c3-04b5-4387-8612-08dd7d234773
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3FPM1FQN2ZJQ20yTitVU28rVTM2cVFaWktGWjFvaDhONkkwVmRNSEF0VWhT?=
 =?utf-8?B?REsrOG9GdVZ0SjlKK2FHYm1oOS9hNVZrVC8yRWtTc20vVVVmYjhLNzlac2du?=
 =?utf-8?B?Nml6YUFmQ29PSTNjaTlaTmRldWpwejMwdUFZWTVacmlNa3FsNU1RZTRsWnFh?=
 =?utf-8?B?WlhVYm5GY0gydFZRMGtwS1FtNTVLMHQ1eXo5OGVxdktobnZrYmx2VGlGRzZ3?=
 =?utf-8?B?TFRPajNJa2VLMkRsMnVDR0tzVzNKSDQrZitHNzJsTExDSlg0UG5ld09nblM5?=
 =?utf-8?B?VlJCOW4zdE5tZEFqZG9WWnBHQ2lUR3RFMmFmZ0p0QUtZTnNxSXpDeXZJSytI?=
 =?utf-8?B?NUxGRkdjOEhHVWRPd1VOWkNxQ2NtT2ZZVGxDcXNwYVo1WjBQQVExcFdHTDJu?=
 =?utf-8?B?aFYra0I5c3ZtMUM3dyt5UWZNOVJhczdQbGRTVG5iREdwVXlscjRvY01BZlNT?=
 =?utf-8?B?OFFJSDBtMlVJY29Famd6R3ZkbXdMWXhyU1FwN1BYblVLcjZ1SDFvRzZNdXRz?=
 =?utf-8?B?eEFpajVxanR2QWwxVlIyejBLRmg4TitaWWRJcy81b3pjWFBLNHBScWtsc0Q3?=
 =?utf-8?B?ck4yQ28weThYS3JZSkluY05SS0tFUUM0WEFZQmxRbVlnZ0ZyZ2U1QmduSVZF?=
 =?utf-8?B?Y3dDeTNNeTBtT04ySlBvYnJicUJPK1JXVyt1VEEwN09ZWEhJbnp5cVZKcCs4?=
 =?utf-8?B?dkx5emNPWHoyT3VwK21ZWStpZTQ1eDJQcmNzVXYvcEEwSUZRNHFHckF0cjZt?=
 =?utf-8?B?YnVTdlVLbkZmOEJxREdsK2JaT0lWNTRzZ09LT1ZCWVZ2bHQ3UkVWQnpvZFIz?=
 =?utf-8?B?R3A5aEs2ajJtMEF2bS92N1lQVWtkWkNraGxLMnhCU0tJaWFjK0JZeDc0NlFC?=
 =?utf-8?B?OGNYblJwdWNMeTNTT2FEWVN6Q0hnOUtsOGJUek56VnNmYWF0T2NQWjNXbUlU?=
 =?utf-8?B?RGJlNkNSNXpJdUhEa3c4blJncUg3ZlBvVUp2TjIrTU95RmFMYXlDb0dFVjNO?=
 =?utf-8?B?MWNYbFhPdFFIWHQyLzJIdDVXdFdtaHBWZkZacFVHcWREc0ZyL05rTXVPWXJj?=
 =?utf-8?B?enY0Z05MU3NGa1dDcDdNNzdUOU9zV3FIT3NxMmlScHJKck1aYi9yWGtxaGMr?=
 =?utf-8?B?Y1Fudm5TQkdNZDk0N045MnVQK1BKVnFnbU16QzBDM3B2Nm5NZ3IxTTJiZ2VO?=
 =?utf-8?B?b1lCQmZBaVpoRlZXZXNNSEt0OWd6R3Baa0pEeVdYU1dNdTNTN09XTFdPU05Q?=
 =?utf-8?B?a3BIMHRYNTVCRG11bnZ3QWVyaWMwK0cxWWllc2ZDbmF6Z21MY3dZVnI3SmRZ?=
 =?utf-8?B?YjZMREpYcFhvcWsvTm5lK0ZPMU5HV3hCMUFuZCs0MGowNkVjM09UR3BQMWhQ?=
 =?utf-8?B?UDA5NFJEeU5tWkk4aEFyTGNMOUJLMkpFK2Jtd0ovRjJLcXBjajJ5ZlNqY1hH?=
 =?utf-8?B?UlBZOFVZcElienJITVpCci93VVZ1ZGJXOC96UDNQQ0VEaDRBWFJTbVFKNVRq?=
 =?utf-8?B?SE5QZlBoLzJXZTJscXY2ZHZvNFdIRlV1LzhkS3o3SGk2RTR6YkFJODZZYXJT?=
 =?utf-8?B?WHlYQVUwckJEaVA2VXkzQTN5RUtCbnM3cGswSVNvcExhclV4MUlySG1aVW84?=
 =?utf-8?B?M3doMXRiK3V4SXpNL3dEMkVxaDRMakdVeUl2RUxKT2ZTSWFXeThEWHVsRk96?=
 =?utf-8?B?UGQ0M3d2amgrZytxV1FjNVZxR0Q0elFkQk1UQlJjbmJJWUh6aExtbmU5M3dS?=
 =?utf-8?B?YmFPN1UxdGZ6OW1NN2E0NWRkdTcvWWVNL05PeUhwaEtyM3g1a1p0eWRNSnJX?=
 =?utf-8?B?ekRzcWc1bkFJemhYaHAzeHRPRFFGbE1lYzM0VWVYYWtObHJuSzV2OTd3UWJU?=
 =?utf-8?B?V1RZUk9QZmJzOUIyWjA0TlIwdFIzREI3dlR5SWw5Mk8vd2s3dlppNEFrNGx1?=
 =?utf-8?B?SFh4VUtPb0tXT0ZodkZnZFhqTGwxWTZiQi9sRDQwTU9jbXlTNzdVRXRwazdx?=
 =?utf-8?B?MVpMaktjbi9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG1GWUhvbDhrSkZ4R3ZNRkVDOUNtb1dnRlBJTERieUtpaWNseDhiejVMNnRz?=
 =?utf-8?B?Y29rbVBNT05hVTQzTXM4MnFzUVBKcG5IS1A3RHpQTGRDZlV5a3gwSlVIR0th?=
 =?utf-8?B?dzZDaU41NTlyYUpLRlMwVG1pcytVTk9FREdxc3VQZjlPdlNLRW5LNjI2ZW1u?=
 =?utf-8?B?elZyRUwyU1ZhSC9JT2hicS8rNGF6di8vUDhva3N0a2RSNEZqLzhRdTNVRXZn?=
 =?utf-8?B?VlNtRGx0ZGE2eHU4RWtWd3ZVN0w0MFMzajRwZmhWMjJQM3lEYmdCWXhsd0lB?=
 =?utf-8?B?OThibmdXQzFMUlhrbXE2WnpobWxZMEtiSHlTZTliRlJJdUkzeWxLaklPc3gr?=
 =?utf-8?B?R0R1dzFuMDdJSktPVFFmZDRVQ2VpVXdyU3ZmSHFjcHFaRDZaZU9JU3RBckcw?=
 =?utf-8?B?d0x3S09jb003dGVXZWw0WmxpZmF6T0JudlpJMkhQY0tPbVFTc2RsQlpoSGdn?=
 =?utf-8?B?alJtZXZlSWF6NEFuRjd0bzFyTWlZWVROVG42QkxJMUR0VG5acjQrOWFSV3NT?=
 =?utf-8?B?bXR6aUdleGJia3hMb21pQ0RwM0pHNWc4N09HWFRXY0V0dVZVN0JMM3BqMU41?=
 =?utf-8?B?TmVpU01wN3dVMG1tTkhQMERLcU5WNVlEcFdKcEF1UTg5TkM1UURQUXV0ay8z?=
 =?utf-8?B?NE0zVEoyZ1V3Qml3VGdNVUhLcFVLQkpEZzAwMGFDeEJDK2RoNlVnWjBDdDdU?=
 =?utf-8?B?NjBqQzUza1RkamRQdkZHK1l4dHhheWQrWXJKOE9ZK1FEV0ZTeGU4Q09ULzNQ?=
 =?utf-8?B?a20xWVBLWDFKMlg4RUNEYlNkMVZRRVNOclozQU5va3ZpNUxEcVNmZTZDcDdj?=
 =?utf-8?B?SjNKZlFaWlVESWQzTGxDZEx6TTR4L3NSa3IxV0dRWXVhY3VzWlZJUGZhbUpo?=
 =?utf-8?B?ck5FU2hwQ3BZbFJMdTI0TWRFV091K08rdS9XQjRTaSswdVI4blY1RTZxYmw1?=
 =?utf-8?B?V1AzR3d2VU5pbVlTTWMrdmRpTm5OU1ZJSU9mVlFhMFdxd2FCbUhWcnhmQTRB?=
 =?utf-8?B?ZXRXeTVJbzBMeUlna0d6UFZ5NitTQnZIRmhmN1hJYTFtYXo4TlR2T2JlZ2FN?=
 =?utf-8?B?OTRkcXZzUUx1eUp5R0tpaHZxdlBUNFVEZitwREwvNEh1VlNzeHFzejhraWhG?=
 =?utf-8?B?ZnUrRmIxemc1aFJQVWk1dUVDdTdZVC9ORXR3dit5U3FGeHdQN21xZ2RBV0VB?=
 =?utf-8?B?UDhIUjd6R29GRWJ6azEyTnBTeG94Z3JHOEFkV1loNWx1cnYraEJYYUFSd2Iy?=
 =?utf-8?B?cEZJK0FyRDJTOG1tYTVwcU9kVXZmelBveVBISmtMcDNaOXB1N21sWVV1aGZm?=
 =?utf-8?B?dW03OFdqY2ZTOEpEZ2JuV04ybGhpTDhKcm9EVWZQUU9MTVo3YWc5dHlVMEhL?=
 =?utf-8?B?YTNHWGd3bUs4d2h6TEJSVm5IeUduYjJOZ25VdElyZmJ6cXUzMWRMVlFJL0t4?=
 =?utf-8?B?ZWpIRjQ5N3oxZlF1L1NGdTBrWEtlb090MnpCaERZSXdFNU42bHg2ekFQeXls?=
 =?utf-8?B?UGllSFNDSXRoZWhrWHVlaHlRV2hpUU02OU9qaW9tK3ZBMEZXQW1ySjlVakla?=
 =?utf-8?B?WDZZdU43OFErK3FaV0xaQjhTaTNpQXNqOWhqWC9SNTFaME05MGJMUmpzSWJ2?=
 =?utf-8?B?STAxUnFiN3BNNUZRYTFiWnJDT2YyaVJjejRoblV5UlJZNDMvU3VCMUdENTZh?=
 =?utf-8?B?S3ltNkRkbUwwcXpIY0ZyN0xpMXVSTFBCNTBoMVBnVVJya2xmenk3ZitWbUIr?=
 =?utf-8?B?MnBZOG04eWJCQkg4YmRKOHViRFFFdWgvcWQycDhBYkpRYmJicnlEbEpacmE0?=
 =?utf-8?B?ZVM5Sy9LU3kxZDlVd1NhM0ZHTVhsM1ZRcUpoaSszYUhVbTk1ZnlqVzVVV3pq?=
 =?utf-8?B?NDRvSXlsQmRtVkg5dzdkK1hNd3NCY2p1WGI1dlNRaVM1UDFySUJyemZjYS82?=
 =?utf-8?B?aXBObmVhM3MwRjJOelV2TnlOWm5UREVGWWJMcGRnSXRIM0VGajgzaHJnNExH?=
 =?utf-8?B?d0w5RnNuVU5KV0loSmcwL2JhUzVQZU5MN0NZRCtmT3ZGTHpSSDJRSWdzNkkr?=
 =?utf-8?B?akhvRUdKdEZITmNHdWtUbytQakt0RXc5VUZqekR6U1VDWkJCYUYyUEoyZ3Zn?=
 =?utf-8?B?c09RczFCTHB2bkR3SGhiZGh0THlVM0hTbXJZY2h3R1p1Nmw4bGVZQnF3UTBF?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a18389c3-04b5-4387-8612-08dd7d234773
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:14:23.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WDqN1Ze2HlJYf1iYS92eXWAF6gevYdz9FaWtlDL2PDFndCOAckNF4aDIXtTeumjBo5MJQvEqSkNbBxQQlsMAO20soDkOIiqjxmiE8s0MRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9251
X-OriginatorOrg: intel.com



On 4/15/2025 4:29 PM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
> the driver might at the least print garbage and at the worst
> crash when the user runs the "devlink dev info" devlink command.
> 
> This happens because the stack variable fw_list is not 0
> initialized which results in fw_list.num_fw_slots being a
> garbage value from the stack.  Then the driver tries to access
> fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
> of the array.
> 
> Fix this by initializing the fw_list and by not failing
> completely if the devcmd fails because other useful information
> is printed via devlink dev info even if the devcmd fails.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

