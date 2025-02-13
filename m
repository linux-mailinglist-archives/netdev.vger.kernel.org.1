Return-Path: <netdev+bounces-166106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06424A34870
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447651881890
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC318A6A7;
	Thu, 13 Feb 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O99Sx1t7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDED6F073
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461543; cv=fail; b=tDwQ1n1IeW63TBLTZbnhvCPf+aRq+ym+w6ZNukzOPh3It1UFjR2p9491E4/mNfd7gVjT2QXJZBQqfhMK3mfYPAlenyfDQ8o5MQY/AqgPj085JaMB2DOHIpj5KxjxdxDzkw0qUScrfM/ng+YbTupxFrimHNAqes3SwhD3K0kq5Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461543; c=relaxed/simple;
	bh=PrlFI/cuTSCyBLQF0PQGZThO24SPmEXCJzBIdmRoTYA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G6iOj1OfozyO/Gka8HpV9yq/KVYfnX0a0H6TCtEDZ75dqs2QujAZUIA2xSOSCqOx68rPdBXEkuMYw0/o3MGGqtkrACxYYi2iRu5Wppwltk382HSwbVKFFv637zVpfSm4/+oknWC/kgBf2F80BrX+SojuJvDnB85hJlDV+nQ6isk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O99Sx1t7; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739461542; x=1770997542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PrlFI/cuTSCyBLQF0PQGZThO24SPmEXCJzBIdmRoTYA=;
  b=O99Sx1t7dkxHFNSlvYVzREfm9pFbV8Nr4FW95YOr2v+r8ODBvoYxUMeq
   Hr1TQjNq2+WrzwfTh/zLAnuAASjJX5oPJQTqYX1mPyc1XokQBKODBM/Gc
   JljIPn8w/PBR6wn9JT+jKqZvaOc3s3EeG2udWu206bhpKDXepWP8/9s/R
   Acrs1s2hK7XnsXwqCF2t4GDwNeNt/fgKHUGbhWAhBaC437RlL4aylrcun
   DLGcBiRWKoD7e2DC8dLw1YeY5620i+sQ4VJMbDoiBCN/2JGMDgTJkpfz7
   Y8SAnF8HJBjBursptM9qPMUaPp8zMAmIwx/b4+YPelNLvaSH7hUU4zV+m
   Q==;
X-CSE-ConnectionGUID: iJphHFeXTs25jKDCbj5jjA==
X-CSE-MsgGUID: xrOD4NUzTRq4VLojgPIrmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40320828"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40320828"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:45:41 -0800
X-CSE-ConnectionGUID: kTgZgiTKRtmpmTKsWP2OwA==
X-CSE-MsgGUID: GDmpDHyNSQqO6JQuViqCzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113702997"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 07:45:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 07:45:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 07:45:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 07:45:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5RjsuBQ07VFUcKv9w1ldC7jqFKEnJfIXl5rq06/D00ToDGt2Br0EiJhlSgER1TbnU1N/OOrm10LtOLqFHH6xNRIYIwN2wdjdSYs7efTEt+azbyc1OLIxCxhfXNSUhJFq4tQXyLvBmbN0uZbrfW09LPDtL5+tG/EVmqUb6f7MOH1QX2Zx4j0QJa4swIGvyLlRksTj66VRXkdrZHcseY3AoOWi4ZAzad6eMqiCruYLMD9EFltrRYLzpzZF7BV2DnIo66eecmia40QjwquRhacUxJzJK5Dp7r8TKdJmU2fEe+dv9EjWNUyfC2gLzQ2ZxOpYaqdDW1aLlFFQwb3yIENmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+pjpR4cHZiphx7SLMcF1rWly6u+5WI7EitRre5sVc8=;
 b=VTu0Jtgk1W3VZkb5C5a8uTvX1dKimrpWt2gVhRzAPMFX9gjDQ50VCMxuOAj0OS0Dq5mLIlEL++zZ1JN9RVmFQZWXIKdNG4ZS9xMe+36T7+vqzhkEL1z1zNf0bqq6zqP46rSiVSod69xekwimt7/f49Kcthn4jFnsnOEGR7wmx9qcrgqurljHVEwU0svXSTKban5CbB2j2o2e/31KWBq8e6pG0JrkSuRsETK92kXklyFrPnc8e+9iFILgk9GZP1mqh3zpP5SZX+hBw3lENoG5zgczn4MlTwgOve545VHUYSZnCYje08krFJSlekPKgGHmfKjAUsnRXAykifrpud7OHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 15:45:35 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:45:35 +0000
Message-ID: <7dd230fb-ca58-4407-98df-03ddb2ac68a9@intel.com>
Date: Thu, 13 Feb 2025 08:45:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/6] net: napi: add CPU affinity to
 napi_config
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <andrew+netdev@lunn.ch>,
	<edumazet@google.com>, <kuba@kernel.org>, <horms@kernel.org>,
	<davem@davemloft.net>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<jdamato@fastly.com>, <shayd@nvidia.com>, <akpm@linux-foundation.org>,
	<shayagr@amazon.com>, <kalesh-anakkur.purayil@broadcom.com>,
	<pavan.chebbi@broadcom.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
 <20250211210657.428439-4-ahmed.zaki@intel.com>
 <738fed19-378f-4aa9-8d42-5c18b8ea321d@redhat.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <738fed19-378f-4aa9-8d42-5c18b8ea321d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|CYYPR11MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 176df74b-5825-4d4e-2c0a-08dd4c4574c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2VyYzhvYlBPQUxKSEpFNHRKSmg4OHlHNW1oejNWQUJwM1NHb043ZitTQU5S?=
 =?utf-8?B?QUJKeU84dDd2MzlzNVBZZzd5UGk2R21lWVFxeng0N0FKVDkzczY2YTZZa2s1?=
 =?utf-8?B?UVNkZmdZRW5kRnkyYlZDbUhSQS9aMjcrNzFTN2FJRXRBN1dGWGFXL3JLemU0?=
 =?utf-8?B?RWQ1aUF3SFRVSEREeEZ3UHluYkxhSWJFcm5ZaDYraFlsWm1PSXYyYTZGUmdY?=
 =?utf-8?B?QlhCbWMrenQ5UVZLaGtRRW5KVzliTXFsV0ZPT3FUb3MzczFKUEJDQ0MxZU4w?=
 =?utf-8?B?MG9rUnBRUFpReHUzVXNOMzlKUEJ2U3dOT2hDTFdlY3BjY20zbjZTRnFmMUZ3?=
 =?utf-8?B?RUZFK0dQckc1MEpkUVdoL1F0c0FkRFZrQ1p3SU9GTnJKU2RWZmN2bnl4MjJt?=
 =?utf-8?B?WkxEeFZieis2VWkwRjVnWGE3enkxQlJEakFtNzFwak14Q1QveUtHcHNLZVJ2?=
 =?utf-8?B?NkJxMXVXR2ZJSkFTU2NEbjBWS1U4RDJncUF2ODl1anJsUDZhbzYyUHFwaGFS?=
 =?utf-8?B?WENZM3R1KzhEeG5lVHl2Q3VPTUJIRzF0WXlDQ2p0Z3hLVVQ4TXk4bFhXOGNu?=
 =?utf-8?B?ZnZkUms3ZlNhc0VwMkdWWVFTamdjU0RzenhpWjZHU3ovR0g5NEhtNGFIdDlh?=
 =?utf-8?B?UGNGSmZzL2ZoWktSTk1BSklFNXZITnlOS1NMc0pwY0RCMFc0d09tTDV1MFN3?=
 =?utf-8?B?V2FEOUhZeC9qeWk1ZFFVcXlBaUlPWmlvWlFtSTQ1TXBCWTRjQnBzL2tsVW1n?=
 =?utf-8?B?aFROd0libDdGdVY1NStiM3NnR2hVbXFFYnhYZkhheGFTMXVSUk45VHBZTVBZ?=
 =?utf-8?B?UlN6QjNyT2FlN1lUUnhLMUI0WHMyVE5OUm5nN3Q4SXZQbDloNkZUM25hd1Mr?=
 =?utf-8?B?TW5wNEdndHR1NGtHS2FFdXFoZDIrSVpJM2Y3SXAzY1VjN1ByVUJ6V1VPSkd1?=
 =?utf-8?B?d2RKTkc0R3IvME5oVm5Ec1VqSGUwcmpZRC9DQVA4ZW1GWitiYzFJTUJacVdp?=
 =?utf-8?B?eitvYnQ4aFh0c2VKRmF0RmpsajY5aW92ZDNrNFF0VzBlTm9qcDR5STZ3NlI1?=
 =?utf-8?B?T3VoQnBOWHYyWGQ1SWF4QXlSNFltRzl0bS9XM1JtQytGWmY0WFlVM1V2SzZD?=
 =?utf-8?B?ZFh6RUJyWTlnMTlXUGUydGNQOS9nejhpNnpTbjhGWGtMTm9ncnhTUDQzclIz?=
 =?utf-8?B?RWd3RjdPeTVXb0Z4TXVMUDRjVFRMTkp2ZU1pV0dRcndOMzR0VjhnQkVYbGgr?=
 =?utf-8?B?c3IyajNpOXlIZ0pLdjNHYm93R3VTY3hRVFZqNGlzdmR2S3Znc1hPRElYTS81?=
 =?utf-8?B?cmd5UFAyRHQ3ZC9DT21iZldleXNWc2ZjY0lYaU8xbk1SMnk4aFNQeXhVUk9h?=
 =?utf-8?B?RDgrMURabkJ6ampwOTlmTEhoMFE5cHQva05VY3dhNkc2djJVZkZGZVNqNG80?=
 =?utf-8?B?T3dxN294Y1BDS2tUcUpRNGsvODI2TG5HcXlPMlRRd2pSeXVrTDRLdmdTOGw4?=
 =?utf-8?B?QVV2dUhMdFUrbW5lTFJidGpWOU9IR0hPcC84NEF3L3VVRVd3TzJHSEowS1dZ?=
 =?utf-8?B?N0ZkcEIwaHF0dEZjTjc4cnVna3lVVGRvSGFOS3RDZk9OTXBTVFd6NS9UbGxk?=
 =?utf-8?B?TUhkaHVoRW5KdmZYdFBXd0hoVTQ3NjhZUEsrWUZ4TlVPbHI5ekNEdlROTjBI?=
 =?utf-8?B?WGFZMzBWeENTZDQyT0REdDJBRDZyVXRGWkVGcThNMDRmZ3FEdzlwY2tQNGpE?=
 =?utf-8?B?d1J2WnNLdG9jUHNkRndUd2JmUlZuWjBlcjF3VXVGVnl2WG5iMWRIYzl5MTVC?=
 =?utf-8?B?SmpKRUYzWmpCVHRoM3o5bjBQTjZHQXVmQmVPcStRbC8wK3h4cEppanRKWDNv?=
 =?utf-8?Q?PFFErgi8YFxtg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJCWlUybVNJbUNzVXVteVNMcHJSUWMzZkhqSHF5dDdGV0tNNmsxOVkwaWl5?=
 =?utf-8?B?V2Q1WUJDcFdxbEJzaXZQbHpINDdCbXAzektnZGlnbVlXQUtVTXN0eUJFU2ZC?=
 =?utf-8?B?WlYzeGYzQ2dJSmc3UHNHWEZTdjYxdU9xQ29xWGQzU2plUk5NQnlDeGQvVFBV?=
 =?utf-8?B?aXI1Y21teTJBbDZsUnRsaVJzcDl5ZzRKay9zeDdLUUVGNlBVT0hHUmIyZHNG?=
 =?utf-8?B?YjlZVUROK04rZ0dyL3kvazhGcStLNWdjOER3V01EaDd4RVI1NTdZMS96VG5a?=
 =?utf-8?B?TDg4bUVQbXkyVm03alhHZVpCYU1TNnIwTUo3RFQrYlNrcC9zTzZib2haRWZa?=
 =?utf-8?B?bUdxNU9OV0pwZ1VHUlFCT1ZpODcvc05TMW5ha0tIeHVGTWgxcjVGWmFMY2l1?=
 =?utf-8?B?cnVaOStXZ1dFWlRYdDhzblpXK0pxU0p5RG5iQ2NaV3p1WlBVdjJzTUVTUU1w?=
 =?utf-8?B?RVdhbDNkKzFsZGdidjBOc2xnajhSL05MMUZySklYaFF5MTY0YVB1N3UvTklX?=
 =?utf-8?B?OFNaVVAvME1BWVdiZFNIK1d5aXk1cmhOMVI3TThhYWpLYW1qdkQzTUUya2xY?=
 =?utf-8?B?czFkd2I1aWZnVGtLalIvOTIwYVM0VnRjK3kweldxQ3lLQ1BnQ3F2Y0NBVlZW?=
 =?utf-8?B?bmRYeS9MWGMzRnR5Rm5GVXpRY2NoVTFQWkNVUWtGcW9aVjVSVGpJaXk5aXly?=
 =?utf-8?B?Sk83cXJ5RUhwQ0xzRm0wNG96aVdYUC9Zckc1bXcwU1VKbDFRWVhrYmR6VEJx?=
 =?utf-8?B?TWJnZWwzVXg5RkRRSEJIdnFIR21KNURWeHZYNklzL05EMEhFeldEVmNQaWtE?=
 =?utf-8?B?L0hzL2pXUGtISXNOTGpBeVNGYUNTblgzQ0hFRzhmL3BUdWMwTGRCaWh2SDQr?=
 =?utf-8?B?eW1nQm5RNDFMb2VQQkdKRmd1VHBqZlZYYUNuVDY4UHdkMHVLLzVyRllJNng4?=
 =?utf-8?B?TWxxelNrRHloWTZ2ME52K0ZGNllkWE0zOU80dDZmZkFIbEd6TlBSK1E3dC83?=
 =?utf-8?B?S251S0JidTJvZGZjZlR4dmU3a3d0RThJdEcwNGVNZ2JCcXRRbVhhR0RYTUxL?=
 =?utf-8?B?UDl6MXBHTkxpTFdKWi9rN1UvZGZuTG9Wcm1nZ3lEV0VoUDdQTHdLY1Bnc2FU?=
 =?utf-8?B?N1BVSHlRaTM0bTNpd3RnVXVNZ3NlaUFhMmE4cG1BQ2QwRUQycGVOZmRtWVps?=
 =?utf-8?B?TUJkc3IxQU9UTGQwWk5SeHZXYm1RZGVRbTFUbGNvQ005Tk1LT1lXcnZTZlQr?=
 =?utf-8?B?eUFMa2s2N0F0Z2hQZHVFZGxja0NaT2dNSXR0NDRlY1dYQmcrQm8xeERRZEZw?=
 =?utf-8?B?aVc0UlBBTjQ4OERPbnE5SlJwRGxJdUo3a2dBZGhsQTdUcUJuWXVwZ3BPNlBZ?=
 =?utf-8?B?TWM1YTViVHpZYjFYYjR6ak9SU2h5YmQ0MGo5UXFhRURwM2JGcWh4VnUyMFdS?=
 =?utf-8?B?RHdWK0dhenI2bi94cS9aRmxlSE11cCtoaWZUZ0JvUC9vWkFYRms5T1FCTjBV?=
 =?utf-8?B?UnRoTjJ3eFJMRlpub2N3WHF0aTV3QTFRbGM5U250RVZoaWZrc3l3RVAzY1Uw?=
 =?utf-8?B?NmRTN01TZHV0UnZvU2d1VFVoaDZlWVVwYU9KclNpbkhqUGppSjBYeVJaZ3VN?=
 =?utf-8?B?OTdqZXVFZEdRZCtsaE5rT2ZvMytIT2lXT2hRWm9oK2FCV2UvZTRsYm1DOFhu?=
 =?utf-8?B?dy9Qa2MxRFVYN3VjbGVUM2Z4VVR0cy84MmsyU0NsSlZaRmdiNHhJSnRqWUxi?=
 =?utf-8?B?ME5ZUWVCZHZRT3lEbTdNU2ErTkhHYjMzdE9sRmc3RERQY0FMSUpYd3dxY3RZ?=
 =?utf-8?B?YVZobXhYcVpqQ1lmQTFEMGFWR0ZCK3h0SDFoZmxTdTdXM1dkNjk0b05DZEVJ?=
 =?utf-8?B?eGNrNkF1UVBWVE4yUjViVFJNS2pTT1puSWhmUmtCVXloaG9YeURvUHlGNkZm?=
 =?utf-8?B?NG15UlpaTnJNb1Q2WVUweTNVd1F2ZTZCOHNnSkEvWGQwb0FoNzhmL25NZ1Qr?=
 =?utf-8?B?OVZQRWNub0hmQXFxTU5JeE9aVW9ZQzVVWk56bi95OUc2ZGVJNHdCeHdNUk1C?=
 =?utf-8?B?OENaZGUrYjBFMHk0RFcyR2h5WTMvc1kyTFNRc3U5N2Y4LzhETUVwSnduaitj?=
 =?utf-8?Q?J1gXlYzWBHkv0HaE1E72bQPSE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 176df74b-5825-4d4e-2c0a-08dd4c4574c9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:45:35.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1IUnAyndUswevGwWxgxadRtbncKhk9d2RzGG0Q/Q+f6fIH9Y/JgLDy6DGxVFeg7KHBxiEYj++ehnvDY1xhTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com



On 2025-02-13 5:26 a.m., Paolo Abeni wrote:
> On 2/11/25 10:06 PM, Ahmed Zaki wrote:
>> @@ -394,10 +395,8 @@ struct napi_struct {
>>   	struct list_head	dev_list;
>>   	struct hlist_node	napi_hash_node;
>>   	int			irq;
>> -#ifdef CONFIG_RFS_ACCEL
>>   	struct irq_affinity_notify notify;
>>   	int			napi_rmap_idx;
>> -#endif
> 
> I'm sorry for the late doubt, but it's not clear to me why you need to
> add the #ifdef in the previous patch ?!?

It was there to make the code consistent, since the rmap and the 
notifier were only needed for ARFS.

It can be removed, although I am not sure if there would be any warnings 
since on !CONFIG_ARFS_ACCEL the fields would never be used.

> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 209296cef3cd..d2c942bbd5e6 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6871,28 +6871,39 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
>>   }
>>   EXPORT_SYMBOL(netif_queue_set_napi);
>>   
>> -#ifdef CONFIG_RFS_ACCEL
>>   static void
>> -netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
>> -			  const cpumask_t *mask)
>> +netif_napi_irq_notify(struct irq_affinity_notify *notify,
>> +		      const cpumask_t *mask)
>>   {
>>   	struct napi_struct *napi =
>>   		container_of(notify, struct napi_struct, notify);
>> +#ifdef CONFIG_RFS_ACCEL
>>   	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
>>   	int err;
>> +#endif
>>   
>> -	err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
>> -	if (err)
>> -		netdev_warn(napi->dev, "RMAP update failed (%d)\n",
>> -			    err);
>> +	if (napi->config && napi->dev->irq_affinity_auto)
>> +		cpumask_copy(&napi->config->affinity_mask, mask);
>> +
>> +#ifdef CONFIG_RFS_ACCEL
>> +	if (napi->dev->rx_cpu_rmap_auto) {
>> +		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
>> +		if (err)
>> +			netdev_warn(napi->dev, "RMAP update failed (%d)\n",
>> +				    err);
>> +	}
>> +#endif
> 
> Minor nit: if you provide a netif_rx_cpu_rmap() helper returning
> dev->rx_cpu_rmap or NULL for !CONFIG_RFS_ACCEL build, you can avoid the
> above 2 ifdefs and possibly more below.
> 

Thanks, I will add this if there is a new version.


>> @@ -6915,7 +6926,6 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
>>   	if (rc)
>>   		goto err_set;
>>   
>> -	set_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state);
> 
> Minor nit: I think it would be better if the previous patch would add
> directly this line in netif_napi_set_irq_locked() (avoding the removal
> here).
> 

yes, it just made more sense for that patch.


