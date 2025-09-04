Return-Path: <netdev+bounces-220079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D50B4460D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C009581644
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB1237707;
	Thu,  4 Sep 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGl7vYTF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58CB1F2C34;
	Thu,  4 Sep 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012534; cv=fail; b=bXej3Vo93JeJwNHLHOYkqBv0MXqlphiOkN2qDgjiXYu2P7RozQQ4ccY+f41Og++B0crxr8mENLA7fA27tjyWh9KhluRdofS6GQ4NaXtVjCGF3/Q6/FRe+Bif3CtSYtKKfBq7PBbxTFZOls+P0S267K5mTLv4k0GgvwEvclzoApc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012534; c=relaxed/simple;
	bh=Tl9XH5IA10Zk047abxMIPfOYtfs4gxt+cTA0pptnaOM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ra9/aYRCpNeM78NCZxRB61PX8J4ay0bU8fY2z7sjjfC4gHh+Z//AXsHcCyp9C1jqLYFdQRCxKJHSYZqtlbh3JkNA+D7UibeQ9lVGANER1wW+aVZhAu0shQEsHeIfefIvQ1rkPxdX2ncoIb01DSdbP/DkZSFmxLBiHpbRJYb+9pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGl7vYTF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757012533; x=1788548533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tl9XH5IA10Zk047abxMIPfOYtfs4gxt+cTA0pptnaOM=;
  b=lGl7vYTFv6edlJgFmMqylqHekJijxH5i97hdUqV3WdDSkU7CiOjhO3Q/
   fKPgBk0rDEleIvJLpqoBu+EP0ccMrczV+J5J4iKxcTydhaHr9ATOKfAD9
   ICxwnlpZ4PJz9IxNUciFBOnLzCqssiFJVdpX1OPDGbCj53V5Mhuy6kuGc
   FCiJgZQqAvJoeGJ3e/Ph+T4E+K2vA6qhlzzDu2II7mzELMuq5IIJACw1n
   dJUek4vaaxi+okU4JLbEdgUfNtE9DGA9AyXClmoCpgcrvev07cxGITBlG
   WFPKsYGMwtBC047elvtgVVQ0YXeEso+4RExp+pNMtxcKqA17BJPvlj6+I
   Q==;
X-CSE-ConnectionGUID: 9yiCPJ83RQeYVGcse+AHpQ==
X-CSE-MsgGUID: rfOT/YvhQGmyJBXenFLgcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59433321"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59433321"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:02:04 -0700
X-CSE-ConnectionGUID: bqpy5GcSRrmBZ34jieYK/Q==
X-CSE-MsgGUID: WVm9sqpnSTOTbUCOg0mtMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176316397"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:02:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 12:02:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 12:02:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 12:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLx4twGwh8Tq4lAKXsgH+MO/xQEDLjQthQbYvayFnEhW5zKBeEjsHEmAZdCAy6tWaccSe9hzIf1CvIA2+KGYo1WdFBrDfD5QjcwM1TcbWM/I44LstrcgjWZ6r3XggJlxmKCuUNvd9wQlTlXSp71Vxbmu4Q4ybibLjrqWwsm/ss8GVg77KCiSltWQUC7S31IsBIP0ter+t6P7Yvug0PCTE3vgsqaPXGfMs6KMpzDCLkefUYsWbbtfeFgomOkfpYB4N2AlzgnSXbRxzG3rmUXlYefnjsKjRWMr8kiugbWd/hxwWk50sB07pGmWayzmV3yCHRXXnl35juxOpN0WxFTFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl9XH5IA10Zk047abxMIPfOYtfs4gxt+cTA0pptnaOM=;
 b=SM4bJ7r95nQhTfUIgfV1Zp6Y+XC63wz0SAld97XFWzmtxazAA57uZe2qWmKMr29PjnEzm/zgxn2fivKOGejj0QBMtoV+fDbkelVLq2h68ItyELSKCtwrCDpdY7FH1+tk8024lLixtm1FeyULUPFa7GbhlB60QevOAAy6yt2YOBwDBVKVnuKm7KDkKVS7cKdFpPdH7Bf8n9UrAWVUOhcheu8tmnEQtWTvkVaaUIXEnex4v0XIUWO2SaMAvukpaloy/WYvhlcXKv9fq71mxd+JuzCBwOpKVcGHRaEbcfGBAnZKKwffNAfhP3U83nXf6IBwzpko9O6t33IABClUSjlecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59) by SA0PR11MB4701.namprd11.prod.outlook.com
 (2603:10b6:806:9a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 19:01:54 +0000
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e]) by DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 19:01:54 +0000
Message-ID: <e1e9c67e-04c7-4db4-9719-25e5d0609490@intel.com>
Date: Thu, 4 Sep 2025 21:01:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: stmmac: check if interface is running before
 TC block setup
To: Jakub Kicinski <kuba@kernel.org>, Konrad Leszczynski
	<konrad.leszczynski@intel.com>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>, Karol Jurczenia
	<karol.jurczenia@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-4-konrad.leszczynski@intel.com>
 <20250901130311.4b764fea@kernel.org>
Content-Language: en-US
From: Sebastian Basierski <sebastian.basierski@intel.com>
In-Reply-To: <20250901130311.4b764fea@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFE396822D5:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dec92a7-034d-44f9-27cc-08ddebe5832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2dlYi84WTA0RGRXWTJ2enoycnpQUmZJRGpWYWZHOTZ4T1NJc0MzSE1kRks4?=
 =?utf-8?B?V3lKTGgwRGZSQWFXbmNiYWt2RmtqQ1dqcjdHZkRrSUNIU1Rtb1FpOUdLZllr?=
 =?utf-8?B?RUZ4dUNPTHh6aXUvUXBFaTdtS0ErUkVpRnFmOVk5Wm1LODdNNDhOZWdzY2Vn?=
 =?utf-8?B?T0R0bFhudDZEUFJjby9YRklONGFpdktyZ09TeVNhRDBWWDVEc05mUlI3bXRS?=
 =?utf-8?B?TG0ybW1Gd1gzcWVDQVovc1dWaW5mR0IvRVE0ZVJxbkZBQTc4b3hYQXdzbGhp?=
 =?utf-8?B?R1RxMnhUeC8ra2RKM1UvVFJ5RGF4RzVSVlNrSlZFWFRvdG5vaUdjUUllVHor?=
 =?utf-8?B?UEdETGRqd0dYQW1xbUFndVc3ckNySTBrYUFWN3I2cm1MQkNzaGIyWitsRWV3?=
 =?utf-8?B?SGtKeEczdTY0dmJkTE1nYlFad1JLL3hjK2ROQlBNaEx2YWxPcGNHb245UTAv?=
 =?utf-8?B?ZDNmUzh3Ykd5bVNDd2xiaGU5bmx3WmM2cHBXK21saVlyRVBhd2JTYmg3Wkxs?=
 =?utf-8?B?MktiU3RmeHh2Wm50T3NuV2FZOFNuQlVPelBLZHBwcFNLTVNETDJFUW9ibW93?=
 =?utf-8?B?SU5VK2hKai90YTZNV0dGdkpRYkQrcEFBNDVpNzZuMkNxOXVwMjVwN3BnOW9Y?=
 =?utf-8?B?UDZwd1lyYXZCRjFNeG9oeXNPeURKNmMrZ1BlRnBVckpYWUZBalp3TXZHYndq?=
 =?utf-8?B?RStmN3lKd3FJdWMyQzI2OGIwTUJMSFAyM1N4OE80QlFEbTZaY2RSdHM2WGkr?=
 =?utf-8?B?S2g4SE1SNlRUMUF0eEJpYWlpKzNoL0t0dngzYmFjYnNNbEp2OUltdHArMVRn?=
 =?utf-8?B?dFI2R24wdU92U0VEZnJsZGpUcEQvOVRDWkhPTmRXbS9EMGV3eUllM1R1ZzRQ?=
 =?utf-8?B?Tk42WDcrMkVKY2Y5MEJGenNYZDh4UFZpbDkyNm5hdHFhcDJHL3hTYjA1NjFX?=
 =?utf-8?B?RDIzanVNK0oxMng4eGhQbjBsUERrSWpVbzZic0ZRd0hHVGJtUFZzbmNDaGtE?=
 =?utf-8?B?WjFMd3FGMDRQb085Z1NHNWdENjVhZ2MrUWgwR3QrSU9KV2hZMmV3V2F4ekJ2?=
 =?utf-8?B?bXArdzYyUUxFanRYSHowOVJQQjM1ZHlNV0lEc0VhSUZQelFuRHhXNTN2aFdI?=
 =?utf-8?B?b1B5eFFpK0ZBMVpjQUJaanZWaGJSdGdrdVp4VEZTK3IraGdzSzV0d3hnbTFr?=
 =?utf-8?B?S1A2Qm5acEhrdXR2RHkvRllSUEtrMlBkRmNId3RsbXlNQU9JeloybmVrUUV1?=
 =?utf-8?B?ci9icGo5cTRGNnRXczZUMW52ZEJpaXJPOUNJNU1pSVN1ZXdnOExVSXNFeks4?=
 =?utf-8?B?Ulptd0RMZzE4dmY1TWZJbDc3M0pVb3hCRVFDQW13KzFBZ09wdTcydWtZZCsy?=
 =?utf-8?B?b0tCaCtXL2dWSkl1M1lkNEtNRjlhd0ZMWWR5ZEc5aXA0N2NXaU5lNWxNRXZx?=
 =?utf-8?B?em05aktCVjUvN0ZTdzNwLzZvQlJPWHNPblQvSm95RUJBbHB1dC90cjd6dXFE?=
 =?utf-8?B?VDJXbFFKNFJLTm9sVVp0T0RVckM5bEFlMldxd2hFZXZja29TQjA3QUtMY3I1?=
 =?utf-8?B?elVFTGpyZEZQVlN4dEpISUZIbVhYTjJTVEwzbHVZYWRvek0yaHBlOHdOdDFn?=
 =?utf-8?B?RWlaQXpMUlpXNjJieFFXNC9mcnFKa3pCZ1Y5ekRhbFI2WDdTT2tvdU5sYjE0?=
 =?utf-8?B?MnJmYW9ubVBsM2pvcVlVSStUN0haRExLWG5GS01HN3NQK0RLZTZlckVtMTdG?=
 =?utf-8?B?em1kMzlBeVk2TlRZZXdoc2QybjhTeHgrcCtqOWFLaUF0T3R1RVEvbHdvRFUr?=
 =?utf-8?B?V0lUeDFER0w2Wm5TS0FibkpJbEJKRHVGcUtnSEFwMXh0dmJGVktBOXhmTFZT?=
 =?utf-8?B?dmd4UThITktRWHFReGdqQ1dVaWR0TVdSUXdEU1ZQQnJKckk5RjlhOHEvWVcz?=
 =?utf-8?Q?KnOS0fn5iHo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE396822D5.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZaTFYyam4xbjlvaHd3OGU4SDMzbTZyR3lzSmdWNVI3ajgwdWtPSG11SlNF?=
 =?utf-8?B?Y2hxSmZqSkJKNGZoS2YwWFR0VU42Z1g4NERMNTFpK0MxMFM1RUFCTGFPVEFC?=
 =?utf-8?B?eUI0dkRRZWN4Sjd4Q01jZDdnb3VtbU9xYzlWdW1UT0lqbGNMYlp0Y3JEanlu?=
 =?utf-8?B?VGpla1hnT25xZ0lBRlNwc3hBYklLTW5UTEVocHIyemRFc3ZGRVBlOUY1UmVm?=
 =?utf-8?B?VFdZcUFEdmZ6MEo1M21YWkc1bWl4SEtFejQybjNPaXZsd3c3UjhxenkwdzhV?=
 =?utf-8?B?RTZkY0lQMVpCVUpXbGpPVUtGUjAzRFJ2cW1WOGhYZE1hL0Rwc204d3VEWnZw?=
 =?utf-8?B?Ykh6TG8xYldYSExaYnk4cFRacThNYis1Rndqd1ZqVjYzZFdQcU5LTDlJdzVn?=
 =?utf-8?B?K1QyYUY3SnNFaHhzeDQ5L0VCZWxPMkVLb1BFazV5bDg2VEdBcEM5cCt4YjJB?=
 =?utf-8?B?TzhYZ1Y0US94dk1DbFZKUStESmRISStMaXhOTmw2VHJNZi9QYUV4V3RDV0oy?=
 =?utf-8?B?aE4vUHlqZHYrTjlieG9JTFJnQ240K3ZpbU55REpDbis1SFVaWTYwS2s1eXRk?=
 =?utf-8?B?SHM1NU4rSWpUTWVHd1dGTnYxU1BSbGtiMkkyUzg3b3k1L3lrMUhlVStTWnJa?=
 =?utf-8?B?MVdxMkdweDZWQ1RxN05JQzVHT284OVhaM1pwd09JL0c0aXUzUUdrUGJTVzhN?=
 =?utf-8?B?ck5MMzRzN2FzMW44UUx6czBwL2dxS25rUVdjdVN6OXEyVlZXMkxMeWtCRGs5?=
 =?utf-8?B?dVplZlp1djNZVy9DYnVoYjc3Wng2R1VGY1pSYlo1RVBGZjRjd3FIUndCYko4?=
 =?utf-8?B?K0lQTHNUdllVZU15MlVKcFZNUlRQdU1LM051aGlJVVBJb2VhTWhib1Y5aFR1?=
 =?utf-8?B?bkd0UmVRRkpBK0hhVW1aT3VFbVluVlp0ejJZS0pZUytiaGo4SUtCRDJ5WFBV?=
 =?utf-8?B?OVRuWkhrVVB2WHUzRzUwYW9zc2tJZzU1Q2VTK1M5K1o5Qk1CTnNNeFJ3MHlw?=
 =?utf-8?B?UUFBOHUrRW9Db3lMRTN2T0JtR0ZiUGRNci8ydjhrZS9GNzRhYnd2UzFQb3Nt?=
 =?utf-8?B?WEFBK3luZVQ4UlBoUGhOMzBqcTJOR0pOUFFZUkFLNExVL0lFR0hxVWFtZWZX?=
 =?utf-8?B?QWFQRlhueFo1ZmV6cDNVTFAySGtndkJjVkNHa3RVSzhXK2FTQ2VIVVlSMDBX?=
 =?utf-8?B?Uk5QbmhadlNUNkEvUHdXaWJ0MkMveXdMTHFsNE0wQ0UrdWkyQ0wxMEc0MTJa?=
 =?utf-8?B?aTVYaHdUZVdHejlad3BvZmFsa0RvK1RueGhoK1hFSjNRZHlySDBPcnFhN0hN?=
 =?utf-8?B?bmdvQmIwSi9QeHBkaFpBZEdIN1d2N1BFcVo0T1lmb1N1VHEvZndrMStxYXF2?=
 =?utf-8?B?Z0NOQXlWd01JbVdBemVaeTNXbHhqQlhTWGZ5R2l4aVNuVk1mSnZDY0xwT3Fy?=
 =?utf-8?B?U1lNLzN3Uks2aU8xaWNORTlUS1MxZDVMdGw3dnpzTzhoK1NkNzhVNGtNdko4?=
 =?utf-8?B?WW5STmtKYUpQRzNnRWxhNStocUVRWTFiZ0xTK3Q5MlJyS0tWOVQ1aHZ6a2t1?=
 =?utf-8?B?eWxGNVRDckloUHA0OTB1dGlFbFFuV0ZZUTBDM3NoVzFRRG1YVkxhTndzajB6?=
 =?utf-8?B?b0c4OHl0cVc1b3I5eTF5YlJoR2RlckIyYUVUa0EvZHFOU1RJTEo0UVdGZll3?=
 =?utf-8?B?T2I0b2tnOXNjcG1UVTlzUUlxckJ0QjVWVXRkOXNFSXlZbElJOXl3UDVCNks3?=
 =?utf-8?B?cnh4SGVOR0VJNkhQZi9jL1UzVHRITHdJS0NCbWtITHlzdW9MODNlb0QvOEJC?=
 =?utf-8?B?eFJyZUM4bXQwU0N6S21UTEpkcnVFaE5uUFFqd1p6cHZUMnArSENjVHhGbjNs?=
 =?utf-8?B?MkQxUGxFMzZ1c285MzhHUE9vZEFqK1lYWDRNMld6Q3RheFZlbE9hRytDd1E0?=
 =?utf-8?B?T2pTdmMrV0x1SGNtNU5VbVFNeVdOQ09RS1FJSDVmdFQyM0svZmVWMm1RS1dG?=
 =?utf-8?B?cEV1VG5odDBFNUlXTzJZQldjWGcxSEI1NStBUVJJa3BQWE12cHpZcHhrd3hF?=
 =?utf-8?B?WEN0MnlvRTFEUWIvQXV1N0p3RGNrNnNONnBTMkVsaVdQMGdQNGlKSGhXb2pM?=
 =?utf-8?B?TnRvVnVHVnFISHM5VU8va05oTkZNSG9KZ1hqeERVMm9CcXk0SlA5VGs4TFdE?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dec92a7-034d-44f9-27cc-08ddebe5832b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE396822D5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:01:54.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: invPwNFnVS4CweaaPm0lRlO0ZTDu7QhaQ+feT/f0+Vw/Sc/bX4q5HfWtbUiap+xrQicPTVQBgXgBzPJP3gwjPlusvSpXJG1SHuGSjsaOMsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com


On 9/1/2025 10:03 PM, Jakub Kicinski wrote:
> More context would be useful. What's the user-visible behavior before
> and after? Can the device handle installing the filters while down?
> Is it just an issue of us restarting the queues when we shouldn't?

Before this patch driver couldn't be unloaded with tc filter applied.

Running those commands is enough to reproduce the issue:
   tc qdisc add dev enp0s29f2 ingress
   tc filter add dev enp0s29f2 ingress protocol all prio 1 u32
   rmmod dwmac_intel

in effect module would not unload.


