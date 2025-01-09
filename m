Return-Path: <netdev+bounces-156753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A35CA07CA2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADAF3A61F2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635521D598;
	Thu,  9 Jan 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPU96QZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC92185B3
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438268; cv=fail; b=Ab+Fgtb0vWW6Euolk63HDxNfQ3QF955nmpnOrR4buEsHLLFKVapaFhlpQCUWa7HCkmenFyjOtGFAefFHG0KunKiUrMG54ZO753lD0HvuiLSAxbOvASpWKau1cNW/BoiuBMKJqYzEgjIsgjLctX6I3yTq/X/LKFJq/0u4t/1Vqj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438268; c=relaxed/simple;
	bh=ZgV89lOaKuu8wv7v5XIAevDtuPc/U9sM2gtBB0QRpKI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5r3vrzjdfwG4y7c18rlCcjMAIKEczMguy7nZBMVlYx2PWaKp0Hi/OA+l+w/6oO+VpvP4GNSZpy27SCnfPuXygu/mf3g4AjgeMllfB+oV3hMDc0OKuaGb98s13U07pZS+s3VjNMIpuSmOYkM0Wn98ZCrVzROZLyPoWS9db/muLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPU96QZJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736438266; x=1767974266;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZgV89lOaKuu8wv7v5XIAevDtuPc/U9sM2gtBB0QRpKI=;
  b=kPU96QZJEqpbAQk1HZOhfTeW42bBhaJpCIky1scFIMJXlRycQIMnU/X8
   8OQnHrRpOK2y9abOOdd2Q8dGb/PL9nsX2n1kGK/DMTE4d2HmzUPpd4l/f
   8rZN0yjxZ7eEMhJQaejfD0bRLVnDuiyq52kkWd68/aa4RDbX1Ldzri7Bk
   Rz3S1aY13jwNA2KYt5JfuBEl/jOS1Az1SXbEwKV61OZISIS4Q/NvvunyV
   uJKQFuOtDbICxLvbU/xldj2Tc3N0GWAk52i8p6lgOiSP2Z7bzJvu+gJVt
   GokPjnpc0o5okVXfsByp6c10KkqKdcxMg9RC+lbFy0PPKQgwIqGnfnXDS
   Q==;
X-CSE-ConnectionGUID: SKKBtkBzQt+9AWiR6PgtOQ==
X-CSE-MsgGUID: M6dTo5H4S6OrKHAqZdUz+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="35933117"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="35933117"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 07:57:46 -0800
X-CSE-ConnectionGUID: 7ovxZUgAQhaA6YgTbOn0aw==
X-CSE-MsgGUID: bD8JEbIfTvy/c+70IQvwnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134344697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 07:57:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 07:57:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 07:57:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 07:57:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+6w905z6Q789h6CfvAK8q3Fd5RXOzY2qGmXkGuxJrveFln/4EJYGaYh92CW/fuASthi2oCx9rFGQccoeYocQQXA7WZR7qxH2rv63NVNlRgbexBnj99anz8FEdyvMIkL7r4jThemSUakACqpn590nbxrPWOtSnexfQ+uiWwfg/bhdeSlCVSc724PAXC65pJGuIQOz68PFrZ8TsgWKlblSymQlhtU4ZiTuvDL/FEkDHx983Nw5KeVXUkEoNR3P3+ee/026wfGIHi0t/JapiMb7DFvswZIhN3tqeZszPEgUWTQqluwENKgLFXxx3kBtSmsPHElYhJr3BVfYE2lO0eQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOcIjE+Iyw9AFOIUgiJOiMZ5xIijtnbnojaZxAcO9Og=;
 b=DcYtjAImW8vNh8b16t+9oz5n6Sk/PY7sXdO3xTZq0m00qzeJwHvdWyKB9RKJQnASzkCf3fhCKcrJPGqWprP+9yxGPjupNmgunrUBc6wOytks/lWpXzSH9ludsJXHVQl3j3PHkEpTLPkp+RQDh3ketuGtux0NgwOrW1YrqRkI9tPzsdV1CqO1b//5hMNPzK9RBpcpNFemMKKfPqu+l7/ckrBcKlDM1ONjiO9bcyqt8xmf9EOGWJS2yfZuDIk8wsW7naN07CJgAlKGWi3zz/YUN2ap2ORlguHSbYE4nkf9ElFwfUDxQJmoSIGmf+plCP/pNWF208e8fxQiewWrbzupzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 15:57:23 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 15:57:22 +0000
Message-ID: <8431dc3b-fdfa-4b4d-91cc-ab64c8e93f6c@intel.com>
Date: Thu, 9 Jan 2025 16:56:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix unaligned access in ice_create_lag_recipe
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Hongchen Zhang <zhanghongchen@loongson.cn>, Michal Schmidt
	<mschmidt@redhat.com>, Dave Ertman <david.m.ertman@intel.com>,
	<netdev@vger.kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"Tony Nguyen" <anthony.l.nguyen@intel.com>, Daniel Machon
	<daniel.machon@microchip.com>, <intel-wired-lan@lists.osuosl.org>
References: <20240131115823.541317-1-mschmidt@redhat.com>
 <e6f59bda-9de8-3d30-3f37-3ab1ec047715@loongson.cn>
 <54c34e2c-82f9-4513-8429-9ea19215551a@intel.com>
 <f3f4f561-8402-d030-2ee9-38a80662168d@loongson.cn>
 <3785f913-cffe-4b12-8bed-0586fac16393@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <3785f913-cffe-4b12-8bed-0586fac16393@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::39) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f85546-ed7f-4436-edbe-08dd30c64dd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHlwUVYyT1Z4cUY5RXJGaVBWMzY5UTdodGtDWkJZWUdpZWJYUUhGVFh3ZzNU?=
 =?utf-8?B?eHRDRGxFNGJENlA4UFdXaGJQRXkvS1c0WEk0SENuVm9hNjZvOExCRjJGdVVE?=
 =?utf-8?B?aFEycytBekZzeDdxQ3RLOFMyV2VVd0RiMXlZMlVlRDdGMDVKazd3dTM5RFk4?=
 =?utf-8?B?UkFpbzk4UEw2R2thWjU5dzcvV3lnYTg1UjlaVGxnalNlcllvVkpBRXFkUWpD?=
 =?utf-8?B?TElSYnRPL3ppVzhSSFhuQ00rQm5Ib2lKK3FnQmxWQU15QW1MU09sYkFKeWxJ?=
 =?utf-8?B?N3dJb09nOG0wNVZvME1xcVZXSnF0WDlEYUNlVlhSVEVoY0F0eHBqQkRTQisz?=
 =?utf-8?B?dVVEWUxTUmxTQkV1N2lsRWFBMjZQa0JQQjh5ZGtaSEdhNjNYdmVwWU05Y2N6?=
 =?utf-8?B?NUk2OXRtbEM1YkNtSmpEUGJEdmFQdzIyejhabXlUQTUyc01hSkR5dzVzSVVa?=
 =?utf-8?B?amdwK1MrdUtBMzBQMGhXNkt4Ly9uOGREUUNDSTFHT3UvejBEeDdpaE02Wnpu?=
 =?utf-8?B?UHRLem1ZWHBXamdWdENzNUdpaElWMXhaMVlHS2Z5Y1M4VHFTTVkxRHhuSlBX?=
 =?utf-8?B?RnpqSFN0elgxano2TXBmdk1kK0VlV0M2dnlhN0hxOUZYN0FEWHFZZmhaYXc1?=
 =?utf-8?B?eEcyc3lvTWNiOHVwNnhvUEM2QmZ2S2xNMEZEbnZLOHBxMFQ2Zmdsem96L1hL?=
 =?utf-8?B?QWVLUmFyMjA2bTFFQnl6YTJIWCsxZWFITkFnRHV5RDA4MUowaGdPTHUzaUor?=
 =?utf-8?B?aFMwS2lJYjUrMEQwK0luRHhMQy9tKzVFSFJJUlBYNVJQcHh4WkIrU0UxcURN?=
 =?utf-8?B?d2ljRTdVMUtGM2ZEU1RJZUwvM1BUM3ZzK3ZZYXlNVHZWRWxnVWt5ZFZTVS9j?=
 =?utf-8?B?c2toN0x2MitGWDltS1U2ekUxWm1PTlcrZXhnQWxTdEdGY0Z3QUhYQzNrNzkz?=
 =?utf-8?B?eTk1N3BNdktnMGlOQ2pyOWFCV2tvcU9zQy9zRm1UenlWN1YrOEUxd2xxZFFp?=
 =?utf-8?B?UTNjOVlCNzVLRVpGQ3ExR01QNTZKWUQwbE5SSGcxbUtXbnNoQlFzMjl6M2ts?=
 =?utf-8?B?Q1QyYzdWYXNrQ0V6a1NKd1JxcWcrOUF4bmU5WVh2REQ5TXhPS0w5Y3VlN2Q5?=
 =?utf-8?B?YkNRcHNiSnMydFVldXVLQkhFaVA1bHl6OFR1VUtMLzNsTCs1cGV1bTd4cEFY?=
 =?utf-8?B?a0xmQ1l5cDVSU1VhQXgwWm9QU2ZmSlkrR20zdVJSYnMvWUM3Rm43bkJxcUly?=
 =?utf-8?B?cWNicGliSU41R3dNN2pWVElHQjZaY2ZRM2U2SWFJSnB5ejhrTzFEbFcrdHJx?=
 =?utf-8?B?Y0pOSGNYNGZHVkpHWEIwclV6SG1PU3o0OXIrbzhSVVkzeG5yc2JRbmgzWTBR?=
 =?utf-8?B?MGs1d3YzZUVGWUVBd1QwUmF5U2U1NGQvUDFCanNUc1Z4emoyQUtFTU1pMHkr?=
 =?utf-8?B?ZEI0eUFWQkg0bkVFMjNZU1ZickhIRmptNEYvemYrbVBhTUhlRmRyUzNSTnhN?=
 =?utf-8?B?T2k3cUdrRE4rWjV5UzBJTUczU09GYXRkd1J5TkpLam5qR3o3NkF0UUFpWDYr?=
 =?utf-8?B?alJTdUNodlZWTGtCaEQ5cmRaZ0FRMTQwa0lSQlZ3MExrVk1oRkFyd21ocThJ?=
 =?utf-8?B?VTRDQXFwc21JVy9tclRBUE9UcG1aUS9YQ0VPWW80ZWlpb3BtU3lHZmM3bDZR?=
 =?utf-8?B?RFc1MTNnSmdGcEU2clc2Q0kyYTNyQzVBRFVpRzIyOVN0enQvRWhTbFg3RVdt?=
 =?utf-8?B?L2svNVQ2RmM1VVFyUGRDRzUwRzZXdmdLK1JWbWswc1MzUCtCT0JsWjFJRSth?=
 =?utf-8?B?YmVaTE9sNGpRTW8rS25DQ1paUk1KaEhBd2JzWDBjVEZkNzU3YVRUY0RGTzVK?=
 =?utf-8?Q?7cjUsWMhd7dL7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekpOZklaQWQ1M1djOExDV1VBUk8vZkRQOU1OYmFsc09MMHV6YlFra0Mvamtm?=
 =?utf-8?B?STlQM00rRzVMNDVpSTJzRm41TmplbmVEUE5leFlUaFIyUTgwd1ZpZWpmeE1Z?=
 =?utf-8?B?cWhsYkdxZW9NUk9KemoxTlFlVFF0UVdZZWNmckJ5aXppQmN5dTI0VUF6Q24v?=
 =?utf-8?B?NXBtcmtjN0lSRllBaWpELzMzeUVZNTNDeXU0eTh0dHpQS0dpMHcwQU9YeHlo?=
 =?utf-8?B?N0pIeENQdXh4bXp6eWMzbFBGL0NPZkxMWC9hMkoyNzYyZVFLR21Tckl4VkR2?=
 =?utf-8?B?eWNJSVBBeUp0RW9ZVWEvVm9TMFEzUk0yN1RoZEo3WUVtRGFqTWJVOEFsY21s?=
 =?utf-8?B?anVNcUZqYytVbnBuSDJjNHJiVlFUQVF4YzFXRy84YzZ3aGVoYlNQRkdzdk8r?=
 =?utf-8?B?eEl0UzZqdU5FYlNmZUFwakY1aWxsNlFJMENCRGFtQXRFNkJvRTFGbUJSZ2RK?=
 =?utf-8?B?T3dwc1l0RFFvOWpqei9Wci9kcnNEUXdCck56akNiMldkYTJBVmhJelNYY3J4?=
 =?utf-8?B?bHVGTmVqTXRSeXVJb3ZhMWNLaWFpSmlsTGVNbkNJNFdZUGFUUnltQ2NMVU82?=
 =?utf-8?B?cU5mMEtRcGo2ZUw2WFJueVVrdGJld0tFZ2V4TGlPL1FxckJqK0NwYmxkM0Vk?=
 =?utf-8?B?Wmp5bHViWGVBMVUwZlJqVmo4aWtBdXlVUDhndm5Qcmx6WHRhZytrdFJFaHdh?=
 =?utf-8?B?aDFEU0tEOE5pSlp0d3R5TzRUQnFEb0o0bjRBMTg4TDhrUTA3R2krNzBlUUti?=
 =?utf-8?B?eCtldlo4SFRJT0xIVTBMRlZhRklIWm8yMFB0M2dVNG1FUlo5UVhWdTZmWUpm?=
 =?utf-8?B?OU9McE5DVXFYSE1JcTRvdzlYRGU5U09uV1FvWlQ5bHA0d1ZKbHg3WUhpSkov?=
 =?utf-8?B?RmFGbGowTmI2Y0lKNnJ5Tk01QnlZQUJNUlRMWW95cVB3T2xDdjAwSTJyNEdC?=
 =?utf-8?B?S3JvV01PMDNvKy9vT3pZS3ZEb0tDWkRveVJtWWdHSHlQTjdqdC83a3ozQ2F6?=
 =?utf-8?B?UlF6ckJZVHBuV2g4OGZUUTByaDRnbzJvNXY3MVFENlVoMEhRMktPVWVFZ1Rk?=
 =?utf-8?B?NFRkbXFXTTNWZE9CWVltUldyck51WE1wY2h5cWJYcHVrWGJTREF0bUdzV2Uw?=
 =?utf-8?B?WjJJNHd3eXh1anNEbS9IUTNpY21ydXJhRkg0VmQwT3kySktmbEVNQ3lQaUtl?=
 =?utf-8?B?dzVFSXBZWTA2ZVMrRE9tQ3ZTc0RFWW5IRE5XL01aSEVQUUNPUlphR2dMUUxu?=
 =?utf-8?B?NVlEZ1k5K1p4RWM0bFVFTktSNGNWdTRRcUxFbC9GVW9seUdmbWR3SCtWK0t3?=
 =?utf-8?B?UFM2bVl4am1MSnk0dWdJdExjSzV3aG8vcG1PQkRhS2tXcjZ4OFc5d3cwbFlF?=
 =?utf-8?B?Z3N4K0ZVVVJYOVdZck41UzRtTEdwZEZZNHRkQ3NKTDFQa0NQbWNJazNYVVdy?=
 =?utf-8?B?Q1pEZDB0RVhEWWgrVkk5bUJaZjZ0MTdmQ2dFZFY3N2ovTktsajZ4NzVkMlVz?=
 =?utf-8?B?RWRwejQvNy9HMHhpalZycUVNeGM0L2RNT3VzYlZnYkp6dTFWbC93Sm5icWNU?=
 =?utf-8?B?Mk9paldsckJpYTNXMEd2ekdDUFU4OUF0YXgvbEVNNFE3VHJ3N0NWSjV3Y0Z2?=
 =?utf-8?B?MFIzN2dMUXdhOGwxWFhqSG4rL2EzQlozcnVOdGV2YWhkdkR3T2UwL2l5cG5T?=
 =?utf-8?B?anR5UlgvOXN1UmxUd2pOMEVWLzdBeTQ2bUtpelBwOFVaTVBPY1piYWdqR0o5?=
 =?utf-8?B?blV0R0RVVmFta3RDaXlDUnVLRmJ4cGVCdk1DekpoaWF1RldXaXhZRnB4a1V4?=
 =?utf-8?B?S1pwM1VOanY1ZCtGTmlRM1p4OFpCd1hlNjM2d1lHaTF6NStsZzg2S1JFb21u?=
 =?utf-8?B?ejBlMTZZVkdUYmlkcjRaMnZHTGhnZUUvQnlBdFk0dnhTa3BiWmxtSzhBTy83?=
 =?utf-8?B?OEhCeEYwM3RoaEFubVcrSG5tTGRFbXI1T2x6bVhkN2JhT0dIekVuQVlhRCtW?=
 =?utf-8?B?dG9PMGNrUWVwakJ0MGRwQXh6KzlxTHAxWGlyd014cExZK1M2QzVoUktTTEoy?=
 =?utf-8?B?MHBiekJUMlJEMk1pb3Fwejdjb2xmbEQzbXpJeklGRlhEWVJDbVBUVDJKOEVW?=
 =?utf-8?B?RDFvVkV4YVMrQ3pnS2JiclYxNlNXRW54bzJwVEZiRDgwWEx2OGxka1ZTUm5C?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f85546-ed7f-4436-edbe-08dd30c64dd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:57:22.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GQqUQkU86pbbAAP+OvYaACxWTfEnrceyOY4K/WyHIOgIV++rW0jH8Qf+uFKKqcJ/RzFmyVf8fw62iBEaK0rPdWKb7jmW4zlwQ0+qRH2mKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Thu, 9 Jan 2025 10:31:35 +0100

> On 1/9/25 02:54, Hongchen Zhang wrote:
>> Hi Przemek,
>> On 2025/1/8 下午4:59, Przemek Kitszel wrote:
>>> On 1/8/25 04:09, Hongchen Zhang wrote:
>>
>>>> Hi Michal,
>>>> On 2024/1/31 pm 7:58, Michal Schmidt wrote:
>>>>> new_rcp->recipe_bitmap was written to as if it were an aligned bitmap.
>>>>> It is an 8-byte array, but aligned only to 4.
>>>>> Use put_unaligned to set its value.
>>>>>
>>>>> Additionally, values in ice commands are typically in little-endian.
>>>>> I assume the recipe bitmap should be too, so use the *_le64
>>>>> conversion.
>>>>> I don't have a big-endian system with ice to test this.
>>>>>
>>>>> I tested that the driver does not crash when probing on aarch64
>>>>> anymore,
>>>>> which is good enough for me. I don't know if the LAG feature actually
>>>>> works.
>>>>>
>>>>> This is what the crash looked like without the fix:
>>>
>>>>> [   17.599142] Call trace:
>>>>> [   17.599143]  ice_create_lag_recipe.constprop.0+0xbc/0x11c [ice]
>>>>> [   17.599172]  ice_init_lag+0xcc/0x22c [ice]
>>>>> [   17.599201]  ice_init_features+0x160/0x2b4 [ice]
>>>>> [   17.599230]  ice_probe+0x2d0/0x30c [ice]
>>>>> [   17.599258]  local_pci_probe+0x58/0xb0
>>>>> [   17.599262]  work_for_cpu_fn+0x20/0x30
>>>
>>>> I encountered the same problem on a LoongArch LS3C6000 machine. Can
>>>> this patch be merged now?
>>>
>>> What kernel base do you use?, we have merged the Steven Patches long ago
>> My test is based on 6.6.61 which contains Steven's patch:
>>   8ec08ba97fab 2024-05-07  ice: Refactor FW data type and fix bitmap
>> casting issue [Steven Zou]
>>
>> It seems that Steven's patch can not solve the unaligned access
>> problem caused by new_rcp->recipe_bitmap, So is Michal's patch (may
>> need some change in ice_add_sw_recipe()) still needed?
>>
> 
> thank you, I see now
> 
> I agree that ice_aqc_recipe_data_elem::recipe_bitmap[8] should be
> changed to __le64, together with updated accesses. Best way to do so

Too bad I didn't notice that in ice_create_lag_recipe(), the cast is
still here. It's not valid to cast 1-byte array to a naturally aligned
one (of unsigned longs).

You can't simply change it to __le64 as 8-byte vars are
naturally-aligned, while here its offset is 4 bytes.

The best solution would be to change it to two __le32s and avoid using
bitmap helpers like set_bit() at all -- just manually assign bits there.
Alternatively, if you want -- you can use __le64, but then pack the
structure by 4 bytes, but I don't think it would give any benefit
comparing to the former.

> will be as in Steven's patch.
> 
> @Michal, will you be OK with us reimplementing this, or you want to
> follow up?

Thanks,
Olek

