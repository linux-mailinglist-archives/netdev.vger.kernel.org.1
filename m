Return-Path: <netdev+bounces-292104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APFKKHuMFmpknQcAu9opvQ
	(envelope-from <netdev+bounces-292104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:17:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6A5DFB1F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C88300615F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549E1F63D9;
	Wed, 27 May 2026 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyqUTOcC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A354739
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862648; cv=fail; b=CW/SFfMAWXK3dhlKMSKd+sbrVN5v++FdjPl9UB/CSL6QyxLf6ZJqeyZ3KxsF6ZUwhbBwpQsHhp2JDEkG486yZ+hZkdu3cxbuWnFdPlZ2feBy3gHy2t4N34N4KnF4A/ScP8lOPJyLaZsqs1fhPMtijKy49GDdQEBchbq5aVXQo6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862648; c=relaxed/simple;
	bh=WxooyZ/HakldisYlQnozlNSaGltEYUftd+t0Z23ph6Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qGrLHOc6t/8VxvYv3gnxPHFSCnserd1GHM/JCk0xwzAUjk3YIP4A7w2qKXM4AH1xS7rWtiZ4HtbzysDo5J2Dksx7RHbjpiEuaEefBGQqTmEyMFZS9sVUpH7f1e+MECEV6snYIZDo+16GKS6EaDpDkya5kGnQoljEnNUvhvSGCMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyqUTOcC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779862646; x=1811398646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WxooyZ/HakldisYlQnozlNSaGltEYUftd+t0Z23ph6Q=;
  b=OyqUTOcChCSGwsxQMNHSjs7tpzIS5PQBsxzM0zarbL/NWmzSTxoEtO58
   wiwoiouZp7lDZI0ch82+IrVtqaJgL5AMfHFyRb2sNvHCVHcIwi9ybcVAd
   pjlFI7b7kFxFgdC7FvKM+8Ew+p0rnum4F9UrtPiJnJdADz/FqFMnvsA8X
   M+iDSnn81rGsNtsta9+gQyQZmZASMjJ5uIxehWidtPVHdjdnWo2uJhuyh
   tmQFmVtS6I5j9225eMLOtf3jLPmC0aC5S3u7/MSWT6+rTre9BLG3RBRT2
   e37dbvr/VblVT+Ftty4I/bwsAn9b67Fz3pszxHD4st8SnOBDglMT41QhR
   w==;
X-CSE-ConnectionGUID: hoJ0VQ2cSo2QuWZDUgqqrQ==
X-CSE-MsgGUID: OiVpXoz5Sr+gWnGkZ87CaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="83263639"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="83263639"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:17:25 -0700
X-CSE-ConnectionGUID: +dAyiPsWRWeMYIIrYoIkLA==
X-CSE-MsgGUID: crxOAGfnTEOYFuoMaPM1ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="265743639"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:17:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:17:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 23:17:25 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsCd60sPj3CrsizUnI93w6zjvSMbSmjGvPDBP56oSlSnT+BD5on5agx2crZM8nsojIorseWfi6SRrs69DC7JrOG9RiZoH52IvWbKh55qGvbGIz+oX4szBhfeaBk/AU1cdViGuyOqcE8UMhw7gmENqlV+NC9HuY0ajLfIvNv33RGBE6EXhz6Nv5SaQkZMd7FsB0vTifxiRM/t/MCTEt1IGVXghoOQxVGAn+E8ccv6tNm7/PsTjPO47b0kDQhICN5qm/S6BvrG1Hgckvvz6VCh+2u7e7u9mwTvVB+6U9AdIeTreKCCvXrTBhFKSuOUASbZurHIy1ttTWU0VStgaPTTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNKEN9Whg/PgKxF5dy5zzKKTt+ODBDuhByMuatSBFWQ=;
 b=y9+Euv1GVcrkxxsEUBhQdII7egAs++7RqoOtjeTeXIVDHavdJf2thKmqo4pZrUjPad3R9hSCqMMod5zfYl0DvkZpcwFH/OCgbNEXgEZy5+nF6u5gff7E3vWY8GbaKuHAVnDbvtjgrlXf7yil4g4uLqsfkMooaN+x9gRH95GFD0B0OcySbQVcML5eQahwnXLAnH9bcXBWRmrRlHZWa+8y9KWyIVuJSbVJzgRKh8ld5ggKheVGwkhqF1vmE03N5LCFsmGHcH29ngbmUc3viL5g7IlxwqBsEweGV2ywBhy7uNsNQikyfukbLsxOmEOhRCsjX8zoqsEorESLranNgPkECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Wed, 27 May 2026 06:17:15 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 06:17:15 +0000
Message-ID: <42ec6066-868d-400a-8b06-1e34684346ec@intel.com>
Date: Wed, 27 May 2026 11:47:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] drm/ras: Introduce get-error-threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<anoop.c.vijay@intel.com>, <aravind.iddamsetty@linux.intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
 <20260512191610.1817578-3-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260512191610.1817578-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0056.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ed238c-4a04-4ec2-8318-08debbb79889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|5023799004|4143699003|3023799007|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SWzzKjE85MWoEL7RXDBkNaqG9DowHrHxPzECZl8rBroUa65Cd/amcmSyid3bKC3EIssxSk8SANAh60hHEW+MKkSQAMqAUyXE+eSsPFNyxDgmNX2pUgwkZUsISrFO4abHJijBjRVEFOIYJq7orJOkvlEBzL8C8TN1wJ1Sl+58W1Ah0EpoIlnDvJ0wK6TMMO/9KTEmSGdaOHpCKJH3767GiVP082TICHpdJK6hXjDQeLtjasTE+3MwuIgQwzDEUurcNjLoodWMrmW6kSwIArbLiTJAxsqD33D1JsGHpkhtkMatGp3faXwm939Yem8tUv1mrDSgVIGOvvZKJtxyAqRIrExfXb9xK8+lNKXhgnjT7ZVVD3Jy2X5DmLtph9bhVnH1130jOra/OPVa4laMwe1ItzDeZZGVdpl4fI2YaYnAprWHJd9y6+HT4ucUwNsKbb4ejbZc78c27btjxhtumOYdxk1EF/CKVv8ItVJBOyg398tuAvo1ub6KwgSfmf410FrZg5MzO9amTz1p5B110vd/vgZENVY1JPYBemcIG8Lbl3YTEStnNIcdGM8ZJPgASH91cabH/7zlYN1/SzjHoUnsJ3jic0TnzgQDvx4tjLCj7ozFXIZfI3tgeXfCfFVM57cqxcxHCEgAqYnlRt/RV4GVFZ6BcxXfxD+8reJBRW2ViKMSsX/sZQgqkrnRzO/8Og6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(5023799004)(4143699003)(3023799007)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRpejY4eTVTRWM2by80eUpvbU1qckgyNm9SOUhwZjVuV1Z1VUdvSUdiWko5?=
 =?utf-8?B?VWVodUJvSWJ0b1RkL0xYdFpLbEVJeWlWa2x5UURBcVRyNG05ZG1IdlRwWGV4?=
 =?utf-8?B?dkdmaEw2M3FWb0Z0QndiV3RhYUlSWlA0WmlOR2Q0dmt0aDV1UW55ak1jWEJB?=
 =?utf-8?B?OGNNMFNISkZMTHlQN0wrN3JYYkFBT2lLNXNoVGVvWm9nTlBJdXRHeVM2L3ZJ?=
 =?utf-8?B?TjZ5NlA2elF2UmlCZDBxbDZZQkxJSDJhN1l0anJJOFZZMVFmUFZwSDNXcFR5?=
 =?utf-8?B?SDlxbGNyVXZuV1c1TFBHdEFmMkJ1ZS9PYjMxOEl5eEtCMUt6TENxYU9lMjQw?=
 =?utf-8?B?UmlLRDhiNDdEVmwwTnI3TVVuUVhsTmZGNTZJbG4wTHlLK0xDYlpoYXBUU3NI?=
 =?utf-8?B?d0dTdTJmR0lyY1RkY3p1MDJ4Q01qV3ZqR2Yxa29xOW5BeTBtMTYzQ0U5Q3gy?=
 =?utf-8?B?M09KdTdYaE45WGt6ZXkraUJKZEMwT3p0UnQ4VVZGR1dHdlFGZlFyN3IyUEVn?=
 =?utf-8?B?aHJWbmlDcDg5S01FRFBiWWd6MDRFaVdzNzhzVDhrdTRzc0FnQnExK0xURVgz?=
 =?utf-8?B?ZDRobXJCWUFjQ3UzUE0xUkRiMExXajdMR0wvZWM5MkJxeWtLdFg4K0IvQ3Fy?=
 =?utf-8?B?VHlIV09kRkFlTElUdlpMYXJGZ3VCQVVNTU45bGdLdkI4VlYwdll1cVV1L3Zq?=
 =?utf-8?B?NHV2ZGJuNkZOeENpYVlLNkorak5uUU12L08wWEFPSWV2Q0J4bkxmcHBpOGN3?=
 =?utf-8?B?cXc4VXhuTzdoMEVIRlFkMW02ZUNZdGI2bVdSS3AyRWlXUXpVTXgvczQ5NGF2?=
 =?utf-8?B?NnRIRmpwTHo2SElZaVRJc0hjaEdvNXBXOUlZUGtoaXpTS0g2QnFwS0lkVjFP?=
 =?utf-8?B?QzBQdUdSdzZ4VGpDNFRXZGVhUjhrbUYycFByWXpVSnA3TnBkT0VqcjA1NXpG?=
 =?utf-8?B?ZnBRNVNOaGFoNSswdzhCaS9DRmhuUjJPUER4RTV2RmlHUXdlY2hJc1paUTVt?=
 =?utf-8?B?dFlzZ2FRNlRCNDhWYy92VGVBait3Wkphb2xEUVM4QUpBT1BmUkRkeTRDTnJO?=
 =?utf-8?B?ZHd6L2dzOVNpSHFhMUljZktFZkV1Rkwwa2tCcHNHaFNxMzZacEFBYVdYZWht?=
 =?utf-8?B?RjgxVC9tYmluR1RCTElBRjVEeW5KdThpRWxodEdYOFFxb2Y5ZUlxUVprOGY1?=
 =?utf-8?B?b2IyZW5PS0ZWRzFuYlVndndnTkJBWEdQMEhHVHE0WnMrb3g5OHpCa1pobU53?=
 =?utf-8?B?b05SU3E5OXMwdGNGYmxlWkFJYVJ6QWxjbmtnR3lGRTkxdGNQOEtGS3E4L3c0?=
 =?utf-8?B?UllqYjhPRUdGWmlFY0dIMWV6TStqRERPejF5K1QzV2NqVy9Da1lYU0NDNU05?=
 =?utf-8?B?VzNDVUU1Z21DTWxwRkh0SkxTMjMwUlpUV29MMnA2MFgvbCsvV1ZUdUVCM0Vv?=
 =?utf-8?B?b2FNdTBKTHJjbG9zTGZCTHY5enhzQTJFOE5xc1JNOHpCV1VwaXl6MHpLUDJI?=
 =?utf-8?B?RFFrenBObjRnUEgvS2VTOUM2OGVNMUlWdFFMSmxReWpJazBvUS9LRDY4dk8w?=
 =?utf-8?B?VnpWQzROZE15d3dXdnZpUFJneGJPN2pPZUNxRGlPTUtVNHR4N3RJOXVTQXVv?=
 =?utf-8?B?eG5aMFF3SmdqVHpsdHZ3SzNVNUtIYjZWNFlpMk5URGwvNDZiang4VUc1UVdW?=
 =?utf-8?B?SDY2THg1amdUSjlRbm9jWmZvaGRYMDB5a2pyTmpwMDgzeWhtVW1zUGdVZnZ3?=
 =?utf-8?B?Smw4MW9jclNiWWl2RHByWFZYTlZHNjhaYWNhb2ZrbEdmMWpxZUM0eTNIbWww?=
 =?utf-8?B?VS9MS0pvV2ZvU1A0UEdaTVZpdFN2a1kvd2dpTW5tYjZobUdkOHdoakdiYWVF?=
 =?utf-8?B?Mmc3VGdteDlBVEJlS3VXS091UzMvNmF2MDdNMWVEK2lNc3BPOVJDMzUwQ1hi?=
 =?utf-8?B?ck1oa2huZmh2T040NCtSejliVGt0UkVza0VocDVTYzBFcmpWYmN6QjBsWE1F?=
 =?utf-8?B?cEwvTVkxRUZtdkxycUJpdjRhQUxjSTdvak9TNm5ZL0VvVkZ4V3FadGZsL24y?=
 =?utf-8?B?YTFlb1BxTWpjeGpxZG1STWhGRXR5VDgyZU9XTEVSKzhCMFVxRHlibDgxUHBK?=
 =?utf-8?B?YUhmRUlRZ3crQW0yaWhTaTJlVVhtWmdSMHhDNHE4NFlmdTgzbWdPMVFvQU9m?=
 =?utf-8?B?WFRhTHV0dG5YV0lCR3BXbjJ3ZTZheHpiZGNiZ2I5UzRMSGFFT012QmEwZlQ2?=
 =?utf-8?B?R1UxZU50WHhzN2lBMUxrQUtNYnZER1Z1dG5zc2hldkRoNE1IU0hVWnZqd284?=
 =?utf-8?B?SllWWFBLRnBPVWRIM1pYc2NOd3UzejdwY0xVWm8vdGRDR2pjNzNQQT09?=
X-Exchange-RoutingPolicyChecked: RschVJgokqMCrLAxu7PCr5sTbScj1/OnV02doLekQ2hMDxxil0E6H9V43y0zSZ1k06kOT9z17v1n3C/GZZQT4Dnn+bY9fw4KQ8mCjmpErvY/9Px7iY0KjFtJUdj4GBl+qmvYuuC5VQEHXRqKv5S+w+9KHRBMxCfouGTZQPHRQZ11GsaUZy9bwzZcfuKjLQSvqV8jU0H18cMKshxSdRIq79z4qCrE6a5LDCkWns0s5XryxroXrvXBKeR4w7PevyQCGuCrGcl9+W+I7Xw2onsy71Y1k4TXUQyVgsAFYTSflWPfRUtyB2VEHsbThKR9W/gkfchCkIqOIaBt6mogiGEpMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ed238c-4a04-4ec2-8318-08debbb79889
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:17:14.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSdZ+OaKruqVo2TEdUbEgXdvBPzzhr/EjL2EXAy3qOGKWYO4cCGXxSBAK6N78hzGXsAKEc9jdPOjxbcKPbFx0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-292104-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EFF6A5DFB1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/13/2026 12:46 AM, Raag Jadav wrote:
> Add get-error-threshold command support which allows querying threshold
> value of an error. Threshold in RAS context means the number of errors
> the hardware is expected to accumulate before it raises them to software.
> This is to have a fine grained control over error notifications that are
> raised by the hardware.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Document threshold definition (Riana)
>      Return -EOPNOTSUPP on threshold callbacks absence (Riana)
>      Cancel and free genlmsg on failure (Riana)
> ---
>   Documentation/gpu/drm-ras.rst            |   9 ++
>   Documentation/netlink/specs/drm_ras.yaml |  28 +++++-
>   drivers/gpu/drm/drm_ras.c                | 109 +++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             |  13 +++
>   drivers/gpu/drm/drm_ras_nl.h             |   2 +
>   include/drm/drm_ras.h                    |  15 ++++
>   include/uapi/drm/drm_ras.h               |   2 +
>   7 files changed, 176 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 4636e68f5678..dfa72e8becda 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst

Can you add the threshold definition in this document. This will be 
published.

> @@ -54,6 +54,8 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Query specific error threshold value with the ``get-error-threshold`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
>   
>   YAML-based Interface
>   --------------------
> @@ -109,3 +111,10 @@ Example: Clear an error counter for a given node
>   
>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>       None
> +
> +Example: Query threshold value of a given error
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..016d713069bb 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -8,8 +8,10 @@ doc: >-
>     DRM RAS (Reliability, Availability, Serviceability) over Generic Netlink.
>     Provides a standardized mechanism for DRM drivers to register "nodes"
>     representing hardware/software components capable of reporting error counters.
> -  Userspace tools can query the list of nodes or individual error counters
> -  via the Generic Netlink interface.
> +  Userspace tools can query the list of nodes or individual error counters or
> +  their thresholds via the Generic Netlink interface. Threshold in RAS context
> +  means the number of errors the hardware is expected to accumulate before it
> +  raises them to software.
>   
>   definitions:
>     -
> @@ -69,6 +71,10 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the requested error counter.
> +      -
> +        name: error-threshold
> +        type: u32
> +        doc: Threshold value of the error counter.
>   
>   operations:
>     list:
> @@ -124,3 +130,21 @@ operations:
>         do:
>           request:
>             attributes: *id-attrs
> +    -
> +      name: get-error-threshold
> +      doc: >-
> +           Retrieve threshold value of an error.
> +           The response includes the id, the name, and current threshold
> +           value of the error.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
use *id-attrs
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 03db53d03329..87e57bd1e8ad 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,10 @@
>    *    Userspace must provide Node ID, Error ID.
>    *    Clears specific error counter of a node if supported.
>    *
> + * 4. GET_ERROR_THRESHOLD: Query threshold value of an error.
> + *    Userspace must provide Node ID and Error ID.
> + *    Returns the threshold value of a specific error.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -72,6 +76,8 @@
>    *   operation, fetching a counter value from a specific node.
>    * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
>    *   operation, clearing a counter value from a specific node.
> + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> + *   operation, fetching the threshold value of a specific error.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -168,6 +174,25 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>   	return node->query_error_counter(node, error_id, name, value);
>   }
>   
> +static int get_node_error_threshold(u32 node_id, u32 error_id,
> +				    const char **name, u32 *value)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, value);
> +}
> +
>   static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
>   				   const char *error_name, u32 value)
>   {
> @@ -186,6 +211,24 @@ static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
>   			   value);
>   }
>   
> +static int msg_reply_threshold_value(struct sk_buff *msg, u32 error_id,
> +				     const char *error_name, u32 value)
threshold?
> +{
> +	int ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
> +			     error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +			   value);
> +}
> +
>   static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
>   				    u32 error_id)
>   {
> @@ -222,6 +265,45 @@ static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
>   	return genlmsg_reply(msg, info);
>   }
>   
> +static int doit_reply_threshold_value(struct genl_info *info, u32 node_id,
> +				      u32 error_id)
> +{
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	const char *error_name;
> +	u32 value;
Threshold?
> +	int ret;
Nit: follow inverted xmas tree
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
use goto

Thanks
Riana

> +		return -EMSGSIZE;
> +	}
> +
> +	ret = get_node_error_threshold(node_id, error_id,
> +				       &error_name, &value);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret = msg_reply_threshold_value(msg, error_id, error_name, value);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +}
> +
>   /**
>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>    * @skb: Netlink message buffer
> @@ -355,6 +437,33 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   	return node->clear_error_counter(node, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_get_error_threshold_doit() - Query threshold value of an error
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID and Error ID from the netlink attributes and
> + * retrieves the threshold value of the corresponding error. Sends the
> + * result back to the requesting user via the standard Genl reply.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info)
> +{
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +
> +	return doit_reply_threshold_value(info, node_id, error_id);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..ecec2041c758 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,12 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -56,6 +62,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_get_error_threshold_doit,
> +		.policy		= drm_ras_get_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..399280c2c6e1 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   					struct netlink_callback *cb);
>   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   					struct genl_info *info);
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index f2a787bc4f64..7bb429d85f57 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -69,6 +69,21 @@ struct drm_ras_node {
>   	 */
>   	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>   
> +	/**
> +	 * @query_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to query threshold value of a
> +	 * specific error.
> +	 *
> +	 * Driver should expect query_error_threshold() to be called with
> +	 * error_id from `error_counter_range.first` to
> +	 * `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
> +				     const char **name, u32 *val);
> +
>   	/** @priv: Driver private data */
>   	void *priv;
>   };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..59530f987ba2 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -33,6 +33,7 @@ enum {
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> @@ -42,6 +43,7 @@ enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

