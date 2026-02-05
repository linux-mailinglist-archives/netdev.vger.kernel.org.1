Return-Path: <netdev+bounces-257365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KbWDKEohWkk9QMAu9opvQ
	(envelope-from <netdev+bounces-257365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:32:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 801CEF85B6
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D86300A8EC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83032D0EE;
	Thu,  5 Feb 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsMMzsgl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C91482E8
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334365; cv=fail; b=nkJqMefl/CO7TMgzuIgeB+TGZSeRaoS4PyJHRp0UzpK86dQsEAPzH3YW+76OaOOt5fQTOoT3uDGPRgVfXhMl1McUVTOPrDRHTvGzcxuyHL0eO/1UHZd6XCt1xQ79316UM9qA8fDL1/Np1Uo4VRqQcbmBQ6wPlNV2CuLaKzYoWQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334365; c=relaxed/simple;
	bh=evKiRMZ4A7ob53z9IS+dILTMJ5Xg9Ms4ci2dhbmduh4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i39Y5xClmBZcmK8+NFiPX1jYScqkr+4kQkqjA6m9Wy09sv2F++8n0rSqR5ueW6UM7kSSS7x6mPEaIJN0fNIkVGWH8m35DOv+tdqqe0rN2qdTbS6uL/QBYhLc1YdXBfHLQMiiWa2FQIwoooIAyjx0/zUqaBeVperUws2llQBB8ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsMMzsgl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770334365; x=1801870365;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=evKiRMZ4A7ob53z9IS+dILTMJ5Xg9Ms4ci2dhbmduh4=;
  b=OsMMzsgl+A3URSUzn+u/wWb7k4OB7eb9eKpmM87RJO5EhSnSd9Q3/jiC
   ylUvCckk89BjHz6xVjF51MHpycNStHh23WSYyCEqv5//ddo1oOuDJJPYJ
   fQrUDjEXXKbN5qvAz0XyWew9bIOQ3utO4Z9HSgyYCWJ8XDvFdObplfmFL
   qDvAJt62QGUDp1iNSSzXECK7alzfArDnRzZwWT1XJla4BYuAgunvf8vVH
   yhN0wW9kLOrgF5Ln+bfvm/Xt3yYqobwn0SfwI8LBK8b+MPV1fUws2fNdI
   fuCuzWRpFypGTebRgPSDEON1j37Q4yYA1sca8eVfh7q58JfGaWtEdop1X
   A==;
X-CSE-ConnectionGUID: l0H5ANsWRJqeqQZ761BkLA==
X-CSE-MsgGUID: jbhzM2PrRTulhSv6pRP+Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="96998502"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="96998502"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 15:32:44 -0800
X-CSE-ConnectionGUID: YsYSkmDpQgKGFdY1qMgPdg==
X-CSE-MsgGUID: 2ai2whrbT3STPBuTW1abSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215230641"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 15:32:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 15:32:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 15:32:43 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 15:32:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NozPDpxNFyvk5OgMZCc0DWHAjn1EnB58j7pYiNHLuzy0C9iRmnca805BWI/UbYduZ61tjaJx+WqPXQLR7bxhCahgEcZpFKYuljhQjYWg5m77ZwgIPBRpdY03oKsGGyAOFTxTkZW7stlemXZeayocSvtOlmIVHXr/a/edXSdtU7sgirgqRajRygCWNiN2HS7H9Mf6tLCumJ0m8qCeZ3yBILBCPNLDHoEgAJTI4h5U+Zojx8eHeX/a1/cwFrHRhVa+s83wDe3bCcuePo/ubyF+y+xjhkkRYJodbC/0QPCo8DdPH31rm3Ul4fyPcPVu502UVUeZHj5xUOyCkkZ1p+Ao0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkSbbxXNguA/+zNcbDoN5VhbIQrEFejVRAp5kqJ3Od0=;
 b=Nt/SEDGAmCu2JiIP8ksw8X423BfzvjnNKZtvzBHPyVl+sc84tOfEe+I7Jd/eflJziULI/zbvxu0/IA9/qBdZBc4ikc5uOh5GrOh/8sh+LVPY71T6MIuL6MYjyZa2uhgVzfwFxuSahq8i5j5Xbt+cHxkXn0XiUkUVqJJ1/BHWEIc1MI769c8wVd2b4ikqVp1gCBmFOSPa3DgWuRJO3ikYD5gpyzLVyKFdS/d/3lsYlKwaT4srwoKlzBG7jmopi25JfHsQD8Ohjyn3WHDTwl6ZXeI1v4NCyUkjFdOq9AAurr8KayNtKmKj5WN779285H41+CMtlEVMmsi3degjYMCQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 23:32:39 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 23:32:39 +0000
Message-ID: <eae106f6-f1b3-4a84-8831-6be0bd573990@intel.com>
Date: Thu, 5 Feb 2026 15:32:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: e610: remove redundant
 assignment
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "horms@kernel.org" <horms@kernel.org>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
References: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
 <60e6bfa6-4267-4d33-9987-24b87c0d0091@lunn.ch>
 <8b146fee-a63e-4e22-a1c1-eae052786e66@intel.com>
 <PH7PR11MB59833D1AE8A3EC0AB6F87901F399A@PH7PR11MB5983.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <PH7PR11MB59833D1AE8A3EC0AB6F87901F399A@PH7PR11MB5983.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dc8750-14ad-424c-df02-08de650ed99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2taOHF4ck5SdG9yb2NBaElXZzdZbUZXRGR4azhTS3c2VjVxR25pK0ZXcEJN?=
 =?utf-8?B?Tzd2WmE4bzd2eG5DNnpFSEhXY1hNY2JORUp3bTZxMFRoKys4YzVXdmJVWldX?=
 =?utf-8?B?SGNBOXZKeStTQVJTSFZvcmFGTlZSbFl3ejBsQzg4cWt5ZzAwM1FiM1pjVmow?=
 =?utf-8?B?U005MmpKLy9Zd0FNUnR1VEpmRWRLUUxGUG1YWnBBeUVNSWlTS2pWR1FDdTJn?=
 =?utf-8?B?L0NnbHU3WjNaNXY3bnJ3RERSakdVanRGL2dpUE95ZHN5UWVrZitZUzNUS2o0?=
 =?utf-8?B?Z2g4UkZ1R056dDF0dFhENUtVKzNLUk52MXF1K05NdWlGNkQyLytmWlN0SFkw?=
 =?utf-8?B?SE5WVHd1OEpZSzRUYm54am1KVnhFaGRqOC9Rc1ZPWll0OStVa29zN1ZPcGdw?=
 =?utf-8?B?b3JBNERoM053dTIxUW84K084OFF4UE9GRGNRUFV0NXJLT2JDK2JTeW11akZt?=
 =?utf-8?B?RjFkcXV3cmpldTV5M2pyVSt4aWN4eDUrdXNNQVN6LzZsbGwvR1h0SVNsZlp5?=
 =?utf-8?B?Mi95UnRPQnJ0VXc2Y0xNVlo1OGFTS29tZFdveDg4Uk9zL2xjK0VCU2t6aHZy?=
 =?utf-8?B?bVdRU2ozeTBzbmFLVDVteDRwQXRiZ1FSdEhhU2hXNmZhSFRZR0xMV2IxalFy?=
 =?utf-8?B?eHpQalVWMEh5RkhzZ3F5K2w4d0QzejZOR3pjOWJMRjgwa3A0b1hFcEtVd2FI?=
 =?utf-8?B?WFl4aW11enoxU2htb3o1RHV6ZEUwRUVLQXZyT2w1V3JRb3ZPdDJnM1c4M1Rz?=
 =?utf-8?B?WVMrdzBxdTVmalhBT0N2dExGT3lZYzdZNDRZY3JBSDFWNk5zbGtpT3UzNFRG?=
 =?utf-8?B?RTBnVnAwaWU1ZnptYnh6YUpxVHBYalZ6bkd1M0VGMVZjWDFMSzFwSVd2WU9F?=
 =?utf-8?B?b2haa1J5YXhLQzZ6L0o0OXdFYkhZc21uZnlzWktldWFQWFBGMkxTTEY4bE1k?=
 =?utf-8?B?c3BoeUpDSFpYbnIybVlsUHhxYTlxMStqTFNMTlhvbXRieHpqd2xnTmV5dUN2?=
 =?utf-8?B?M2tMd0dvQmxtUHhkYU9zNmlwM2J6WVdoaE1CYUxKenRuQ0FoMklKYW1XVXhW?=
 =?utf-8?B?Vm9uc3Baem9xNVpJWnQ4UGRVZDRSVm1tNm8wMVRYUFVLdlNRWEpWTDI3enE5?=
 =?utf-8?B?RWVPYlFUKzVCWTFGbi9SWTUzYTdGSzFFSmVhVktPdHlZaXROK0JBTWdPc1o5?=
 =?utf-8?B?WXN0M1JYaFBHSWZEV3VEaWF4OFNIZVZCOEFLTjVUVnoyaSs0aEhCU0wxak5q?=
 =?utf-8?B?Rkd5bXBwcXdxZEErZjVmdjRZWDIyWEdTNjVUMm9RcTV0MEduRmZabXhaS1Vr?=
 =?utf-8?B?ZkxUejE4cWU0R1lWeTBsQjdpMDNMekU1WUNUUEJxa2wrVFN1OElxSy95WXJI?=
 =?utf-8?B?aCtyT2d5TXRvUUJnZVgyejNaSlBCTHNDN2R6VHBwYkZsN21rTTRIN3JJQitG?=
 =?utf-8?B?Wkx0Q1MwZ2NyS3AzaUpTMEZNMi9jbmRLZWNDcnJLcW1heG9KaUdOOGE0TVdV?=
 =?utf-8?B?enllSGJaWWh3V3B2V21KdWxjNlI4cjFOU042d3RiUnV4ZFEyTTQyRDM0ZUJz?=
 =?utf-8?B?RE41KzVMSXRWbmJQVHlVM01DNTNmTElSMDVFTVVtbEFFVG4zL0pXQzZyaXJh?=
 =?utf-8?B?TFRnUjJaSFcvRVphSXZ5WGdPV2IzOVdDQ0tYLzlPWUd2VXVyTmdqMUxCUG1J?=
 =?utf-8?B?VDFmVjJ5SzhtdWpjejRtb0J6Q3NrODJEUGpuamxRSHE4cjQ2ekVSelNEMmZF?=
 =?utf-8?B?NWFTekhoNll1bUFybDZSVmdvdk15aTJ5VEFxaEpnZ3dXbXJTa25kY3pkV1VJ?=
 =?utf-8?B?NFJOR3d6c0E3NmdnQlI0VWZjQUl3eHVIQjl0WTU3MjRtMVlCMUZDakdibi9I?=
 =?utf-8?B?T3lpZzNNWjBvQXVpUjNjTFhLRGVvSGhIbUZ6eXZJbmZpWWdKWk0yaXpVd203?=
 =?utf-8?B?MW9RaSsxS004aEJLUDV3a3BmQkJTMGZpT3FKODRHUjJuWmFUVTYzclNLcmpO?=
 =?utf-8?B?c1hJbXBpNTYwaWhiYzRGaGRndEZpQXp4YkxGZEpoeFFvWjJwT2d3Kzh2N1J2?=
 =?utf-8?B?bmxnWDVqOUlzMHMya1YrRzZSTHJtS1V0MHJzeSszaGxieUtwZUZtNkk5ak05?=
 =?utf-8?Q?sr+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektlc2tjSFdEVk5IRDYrcDVwejJkd1ErbTdIRU93WFFZZTdyaE5wQ254TjBM?=
 =?utf-8?B?NTVKYmRVYjVmWlltcU11bVlFLzJ5NHJteXgrMmYrNW81NUJVOHhDbFkycm9r?=
 =?utf-8?B?MjZHVVhVQ0VBem41WTFyd1VmRVBtUHBjUkpORy9LZ3J4WE1EUXNaM1BMOUEz?=
 =?utf-8?B?MlVVRkl2WDBxYWxFK1g0ZWdHUC9vcmlHVDI0d05YZUJVQmFNN3Bla2RtdWtH?=
 =?utf-8?B?SGpET2lmRmE5U3BXTG93MFNhd2xhdHZhUjQ2Mkk5bVpsaE1SNldvZUVtV1Rm?=
 =?utf-8?B?WUIwaGR6dUxoaEliZWR5M3RvZkQzczFVZWFPTEtaa3dQRWFnSTBGeU8yNGtl?=
 =?utf-8?B?ZFNkWWN2YUhtdlpPK1JlMjJhd24rR2NVdXlvVG16Si9XSmZvalVjYlRPaVRt?=
 =?utf-8?B?Vk5Fcm1LQ0VvN0ViZE1sOExMV2RiYVU4Q1o4cTZOQ3JuMUFmbGthakZDNHQy?=
 =?utf-8?B?NkNUSHZLMDFxWnNydXNzWDZ2emlRY1pEN3ZidDAyT0RoTjI4RXRRODFqYVVQ?=
 =?utf-8?B?MWdYV3lFcGY5blNsNGg2eG1lTnhpYWMzNkluai83c29IZCtHanAvMXZQQTVm?=
 =?utf-8?B?TzUrbVBINlE5R2I4SnY2MUsxbzFlR2hoVEU0dXdGN1haOHNNWEhsd09lSFJO?=
 =?utf-8?B?TUVzbFZsRkMrVkovQzV1M2J4OW12bnU2TEtlY251RWNRaGtONjhtOFp3N3lu?=
 =?utf-8?B?eEk5RGtrc3l6Tmo5eWFpeXJmZnRIeFd6RFZjRmFPcE5PNk9xcXJ2UjM5R05B?=
 =?utf-8?B?a2F2Z01JZkNPYmJlQmNxY2doSko2U1VFVmVkTHc0YzlBUEtVV0dYZjlPNkZI?=
 =?utf-8?B?cFZLV3RoVXNMRzU2UUpOMWJGcGluY0ZDYk5KZ0w2UE9BSWc3cE1QMGtnWXFu?=
 =?utf-8?B?d2xmZkcvYVlCYmxrbVFoSW5PWFZEWlYxTnE0VTFTRnJCRDJJWWorZUtxOHlm?=
 =?utf-8?B?L1hER1gzZGh1RWlVb2lZWGlwaW1SY0NwdUZxUEdhL09GZThZb3BaQmkxUjRR?=
 =?utf-8?B?VVo5NHU2ZzlwV2pqbUlKeUNiZ0dZQmc1UEpGOVhnTUlpM3E5WFdsNCt3K0FD?=
 =?utf-8?B?dVZ4czZYRHRwRDdwdm5QL2c4RXp1b09oT0RxWGwvMTR3SUVYbk96VEZwMks1?=
 =?utf-8?B?RHFmY1Y4N3JKdEQ1Qk1JYzdVd1JFNm1lb09BU0xMOUdZTXFPdm5VbWN1VHlS?=
 =?utf-8?B?cHRKVjdpNFZVSGQvQ0thb0l1OTJ1L3N0Rm9WSjhkOXlubjl6TkR0UTE3S1Rw?=
 =?utf-8?B?ZC9mOEZ1M211U2N2QjNXRlFMRjQzSzJFVGsvMlR0c05DaWxGNldqcTZyYWl3?=
 =?utf-8?B?dU0zQmljYWUrWnJGQkZHL3FBdVZYWk9YcWkvTU02SGFwS2Jick44TTMvZ2pO?=
 =?utf-8?B?RFlQZXpsZExTdFIvTmJUcVdIY01sSXdlVks1RW50dm5SWTg0azhOWFlJd0xo?=
 =?utf-8?B?RC9JRGRzOGEveFZLUDIyNk0wRW5SbXdBRFFhOGdvTmtGMk16Nk1xQTRyd0lU?=
 =?utf-8?B?Z0UvMGhEQS9SdEtXZjRSZG40YWNOaUwvQUVYVWRwS1J5RlVXdVYrMksreHlJ?=
 =?utf-8?B?NllsRG5xTmdNTzdXZk9PandvUFZqRDZFdVdNWnkxNG0wSlJHcXRaWlhzc25G?=
 =?utf-8?B?YVhSTEYxS0pUNzc4bmRKWVE3VzRtK0g3endKQ1RTeTBZdUxSRTJuZVh6RnF5?=
 =?utf-8?B?TjlxUkZuV3I3aGd0RWRzL1JRVm82c0czZmRtbEVxYjU5ZG95MmkzVjYrYjZN?=
 =?utf-8?B?RHZMWGdXR0wrbmRFM1orRENGQTczR3BtQkl3SHBpWmJXREdDbmdFY0lEbk02?=
 =?utf-8?B?MEs3anNrcUQ1cjd0bnlXNmFiWnBVMzE1bkZzQ1pCbWlHYi85OTFEWk42MkdM?=
 =?utf-8?B?Yyt2czRaVHEyR1Q2cTJqeVNnc0lOSTFWUFhreHoxbWRZc242MS83WXVXSFJX?=
 =?utf-8?B?aXQ1dzNDQ2E3VUJsYWc4czRxT1BFVEp4amk5Y1RISEh0dkx5L1ppZGdzVDJY?=
 =?utf-8?B?VlFJK0g5eTlsTUw2cjdXTFNvTElORG9CSGJmUHA0ZHpLNUtOQnhxdXR2SXI4?=
 =?utf-8?B?ajFJWVFPWVpVa3BTdHR2VUpjUWptTk9zeFZKTlgrSjc2T2ZtN3NXV2oyNUt5?=
 =?utf-8?B?NTdSbVJ6TmljeXhkQWdMNFEydVR3QnhiS1c0aTgzaXoyUXBoTjBTQ1Z6UTVV?=
 =?utf-8?B?THRLWi9FdnFRb2FCbUpWUmt5Wnh0UkVNMTZKV0RUWFQ2NnlqbVV1MUVjbnZV?=
 =?utf-8?B?MDdzcTJ2dURMenFlaDN4T1duYXBOWFhXZXVKMEYwTFkrcndTdGhEQzBXU0N2?=
 =?utf-8?B?dVNUTWdWTlpaM2tEQVFiM2crZmpoR3U2Zk1KVFFnZm5iYjhUVWRidz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dc8750-14ad-424c-df02-08de650ed99e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 23:32:39.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQLZvMyrfIV5Lbu+vQnUmTUyvRxhs/wVM1AjXFoeEqzktiJxaqWG3GAHRP0GwRw9Po4qALLhM6R+BIQtfK1Yf7LJKN04CEEjKYzW2CoCNH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257365-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 801CEF85B6
X-Rspamd-Action: no action



On 2/5/2026 12:35 AM, Kwapulinski, Piotr wrote:
>> -----Original Message-----
>> From: Keller, Jacob E <jacob.e.keller@intel.com>
>> Sent: Thursday, January 29, 2026 7:11 PM
>> To: Andrew Lunn <andrew@lunn.ch>; Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; dan.carpenter@linaro.org; horms@kernel.org; pmenzel@molgen.mpg.de
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: e610: remove redundant assignment
>>
>> I actually don't know which is "correct", as I don't really understand what the register interface expects, and how it will get interpreted by the firmware...
>>
>> Maybe the byteswap of each 4-byte block is right? but I'm really uncertain now...
>>
>> Presumably it expects flags first and then opcode? we're writing it that way now on a LE system.. But on a BE system thats going to be byteswapped before going into the register.. so our 4byte chunk would end up potentially reversing the flags and opcode w.r.t what the firmware sees??
>>
>> Hmm.....
> I'll work out the solution. Meanwhile, possibly it's good idea to take this patch since this code is unnecessary regardless of the final outcome.
> Thanks,
> Piotr
> 

Makes sense to me.

Thanks,
Jake

> [...]


