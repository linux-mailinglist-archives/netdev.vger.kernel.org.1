Return-Path: <netdev+bounces-254408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHmTHOhSemnk5AEAu9opvQ
	(envelope-from <netdev+bounces-254408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:18:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E9A7A7F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C9E30A92F3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03937107A;
	Wed, 28 Jan 2026 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSJ04H/8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AF371078;
	Wed, 28 Jan 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623766; cv=fail; b=MZyfDPDsm2zMp00yK4BAEe7KuUa2xEyo+PL2uIq6z9I9jKDalPwH34cyALDa22iVwd3BuRs72UZ+JpqwS5Chz7Q4j8XYS18f40G4N0PE3x93xG9/y3xYQoecrBY9LcW8PDE2ETC6cTd6l692iNvlWyQIUytADzbOcXVgPXJ4KLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623766; c=relaxed/simple;
	bh=mKSix3Bj1TpfC0CYg0LTD2eRs4bKPQMxTj7UNg/qnz8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oD2X5u9DPC37dTKP1gETo5V+GT5R2EhjS7BfJZigttVryxyJ9KQ6JQMOYLJMBjhOYcFM/Wg3G6X42ivv3Rmal43TvK8nfHTwpnH+RmGgubu9RoigE3RnA8KQRdcMoHC6B4mAZJK5Pl809otabEaQQk+Um3kJ6hO7rJnsbs0CUuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSJ04H/8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769623765; x=1801159765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mKSix3Bj1TpfC0CYg0LTD2eRs4bKPQMxTj7UNg/qnz8=;
  b=JSJ04H/8qq+ULnnri15JC879tBMXJDw4QQyiFMge/RJ8DkpA0wNAYWCV
   XFuz4RRO1ba/kNKpVWfVtQfZOnHU41I6iP4CAewT2dFI7H3kEq+NEJias
   CDq+BUYTlVMbnDCZdcDHIphYssRNK7g78IhthcTxhg1RagYFFQy1vzTxU
   9NTwFfJ4T1D3OhkBOODJTRCCTr34N8faFEvvg946ilwS4Cpqj8KbmZ5K0
   Ks26QHiIjY8kPgfHmTvLFcmC5+7m6Bu4G3emm9xZ+t4wwZZb3JI6Cw9+f
   vjutlAo5dG6V9MD0mrnSKnERfRIME7nIBwN/OIAyNoyazA5zo5b98ySGR
   w==;
X-CSE-ConnectionGUID: BnzMRMj1QrmQx0HBlUWIlg==
X-CSE-MsgGUID: l95sn8AASr+DSjuwYvCyjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81162877"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81162877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 10:09:24 -0800
X-CSE-ConnectionGUID: MoUxQXlYSjOLqfpODMwcjA==
X-CSE-MsgGUID: l9M9oyErRV2GFyojhOTXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207572821"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 10:09:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 10:09:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 10:09:22 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 10:09:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTzCCObcreVhqf1OApRRBF1rNlaeRoZyfiqN96jKZK/0uXZv5dUPwf4qmQWf7hTXc7lLlnVGDsWO4aGM10lIJQm/JXOEg6MA1qHYvX0Cs1MxOXSp6mU+JPVPqGEeeB8cC0j5rFeimmomisp/4FabCvc5auBmHVsE0SbIuLnGTg+EHBRsa0Q7ufXlbcIG7jvbiMKuH2QGmzMV+oGETPV++sNRA9GmOTcigNrUF8TejPuHTa8+eGlUZTSViX0IbHz8SOQL5uWxbVLJzp0z2+HThkATFOWVILL3BdFCZhZNURr/ZtClATfRjQtY+psEKGSwlACVin2mQ3lbQ7OwGNdYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLZDvvcwFss5V2bscl19XTCtTLpDWusabvu8+KhXidg=;
 b=b6FvERCv3ueu5crMX9whcaOSdPjZzkRCE2+J1/kFj2/Bw4+AbhbE0/kNFYFLpyCoXvQB60r1D1xW0k1tU8vIx7wXnUsMpojTNa0QfmoEaVKUqNMpNJ7fUN33jDISMjVU3/MAhBPsyXsz+fDm2URsRcRpDOwXEYME4uEY0E0vbLhy2HF5HWDJ2pHjy247pSJo506cY3X2UyPxFHKor15p3AjGinEPeaEYwK14dyxfT6Jtv9Wl+JOgRzg8g0cJGsSZWa6GgYhVuE9uD8SlCmH4FT+hYs+R4j5Nh2q5L5+ZG5fbPaQzmd6FPZbYdBQQvQRKtSI9l9Zv2+e74wFZyYsshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 28 Jan
 2026 18:09:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 18:09:19 +0000
Message-ID: <5b8fe4ae-25a2-4967-bb83-a52dd5907951@intel.com>
Date: Wed, 28 Jan 2026 10:09:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 23/25]
 tools/lib/python/unittest_helper.py
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
CC: <bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2a4396-37f1-4b63-3265-08de5e985b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1pEWnFZZTdtWC9WZDJwRVNib0dibmhqdlk1OWUzaUQ0SnBuZmpQNW02a0pD?=
 =?utf-8?B?OUZld3A0ckl1Z2lONUFybUtmK3Z0QnNHUEZaMFFpU2hvNUVzR3N1MXA3OFlz?=
 =?utf-8?B?WWtJcTBDUVZZOHA4UlJWT3ZqMkNsZ0x6dzMwRDFsUklJOUVaS0lzbWtLdXd4?=
 =?utf-8?B?Nkx6RGlVNE1kWTJTM0U5eEljOG5zaUM2VEsyZXRTTHBvMm0xeHIyRlZhNmNW?=
 =?utf-8?B?S291RndFcVRaMnJDR3lwNUFzV3Y1bnlZaS8zMzZ0aHh4YzVUSDlQUzNWanZT?=
 =?utf-8?B?alZmZ2NPZHBCODV4bW1yTjIyR1R2WjhSc3lvdzA4YmZpSk9ibUhtenZmamZW?=
 =?utf-8?B?N3FrcHl3Rzd5UmlwaTQ3V2ppbkh0Q2pDTWNBbTNpQXpib1AyWXYwNjBzWGlx?=
 =?utf-8?B?VTVKblB1dU9GV09ORnluTC9ZMkJOWWtCUkpxL210UDZQK2lvNy9ubERQaGR5?=
 =?utf-8?B?bVdPSEpaVkhaWkR2bTZmSjlPQVR0eHZ5cmdxTEVtYlNtYlM1c01vSy8zYzdk?=
 =?utf-8?B?Z3NaT3FPWk15RVZxRURHS0IxaFh2bXFSTGxONk9ZQkJpM3VGZ3dtM3RMeEhP?=
 =?utf-8?B?QnVNazRYWFk2R01OQkF3amlpNnRxU3B3SiszQUh4WGQ2WENWZE1ud0hrTnox?=
 =?utf-8?B?NjBzZnArOXFTQjNwSmFKU0RSZ2ErZldRU29iYmRKQmt5MEQvOXZTVGFQdll0?=
 =?utf-8?B?UWM1U3FyNTZJUXl4SjNtWW1LYnFBQjd6Ly9YVEVjemNOYUozK0VyZWwwZlRh?=
 =?utf-8?B?K1dnT01sTVBOM21GRlJoSzFaMzdFbG5qK21saEEybERUQzNkN01jRE9uN3JY?=
 =?utf-8?B?SkplWDFrS2FVYnhMS1JXOFRFbEtUb3BNZkFrd09OYjVNRWpZbHQ5QUp6SW9h?=
 =?utf-8?B?b0VFUmZ3V0pZWXJnT2N1TTF3cWZIZTNERXRic21iWVRSN3Q5OXZmQTIzcys0?=
 =?utf-8?B?bDN2dmtKSllKYlZDWmVnTlNKMTJCNlp5VU9OMTBzcXhYOTdWZ05iNGNLTXBm?=
 =?utf-8?B?dWhjbVdpekdEVVdrVDREenU4QkxIYW5HczRidG9jT3hsS3N1WWRkUmRKeGVK?=
 =?utf-8?B?TnFrejVidUZnajlsaldlRVk3ZEFBb3VQZGxvTHRDYm9HdVpMV1h6MzB6UXEx?=
 =?utf-8?B?NFR6VkEwOHVndDNMVzE5MWJTY2djTGNDdk5pQ1JTZnRrZWxWS0V1ekxsUko4?=
 =?utf-8?B?NGFJcVlRU3VsMDFNTklPbXlGNFhuNlo1ZFJ6K3NRVEU3RUFPR2dXZjVFRG04?=
 =?utf-8?B?TmV1LzJFdVFKMlU2Q3RhcHZ2dHRaUGFHcmVvamEwZEJYQnJ6RUZJNG9ISFlB?=
 =?utf-8?B?bFk4MzVOOFl0UmRIR2QzVjN3ZXMwY1BlZjBrc2Jaa0xQY1I5Rk1TSUdscWhV?=
 =?utf-8?B?VHZ1NEpqcEtWbHhRS0x0U1lqTG5pc0swUHc1V1VMNjlzblNKZWRXZTVqWkR1?=
 =?utf-8?B?R0xFSHFOZzRhL2RDenhtRXB2UEZkdzUrRWdFcHAwVVd3ZWJVVVd1T1kzMEpi?=
 =?utf-8?B?MkRVNHhVMS9leldaTDdyZGh6UG1XendVZHRGdFo1c29kU2xHd1dzMTh3cEps?=
 =?utf-8?B?YkdTUGFycHMxd0g0NzFmbUZzMkgyenBYMVBiaGFMZExaQ2Z4NDQvdmkrblJp?=
 =?utf-8?B?UmZzM1VmUTFrUUVlcFA0Y0VKbzRVZ3JnaGk4MVgxcnRRZ2Vvd0ZnaWJBeGhV?=
 =?utf-8?B?YUJPbUJxWjhWSVdkNnVvb2xGWm42UEdDMUdFeEY1MVYxdjVsWnlnWGR2cVVU?=
 =?utf-8?B?VE51bC9VVnRORlJFSUY1K3VDaUdJcEJxY05ZV0lZT2hsWlFwVWdsUWRIdC9J?=
 =?utf-8?B?OTBKQzJodGU3K1h6ajF6QXlScjNiczc3NjY2a3RDbUZ3R2lVM05ZOHdGYURm?=
 =?utf-8?B?ZFZHZHNhb3dOcHI2eVl0RVZjSjRaRlFPNzFGbGNqUUhqSVNwcUtiaU9GcmYw?=
 =?utf-8?B?WGgwOFFwZGJsdUNHZEUrb1pJS1MrVmRaYWNmS0pjYTlCaWJ1RWVhUGREUFI3?=
 =?utf-8?B?dEowSGIrTytOV2FFRXBrVGEyR2JIK21yME9MaWEydXRNeEE0cFJ4Y3B1K20v?=
 =?utf-8?B?Y0VGYzFvSlo5S0Rxdnhld0pyaHZZYlpxK3lXNU5XWmpUWGxWNkhUZjQ2MVNh?=
 =?utf-8?Q?K6ZY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnY1OW9Wam1nYXduSitZeVQrd3pXSzhSSDRBS2c4WFRlR0RoNE1WVWdMdkky?=
 =?utf-8?B?aTVaM05MWkZkMTBKR3habmZaeTNJeHZYa2ZmVjN4VWh4eDh5eTJ3TlZaNGt2?=
 =?utf-8?B?SnYxYkdDVmtZL0sxY0hFWkZNcm90RU9sbmF2djBwWFBvZFkvbmdIUUZjSkxN?=
 =?utf-8?B?RUJTcXJxVkszR3VsWVRqV2dCb2JFb1NMNUp4aWFBUlJxMDJ1dDN3M2pzWEFj?=
 =?utf-8?B?Nm5HbERLUTMyT1hraVY1TTRGT2V6UnVBNDJLeENGeEtuaml4MTkxVk1TSmdo?=
 =?utf-8?B?T2FaelFkK05QbmwxQzlhVCtLUXl2VjF3NXNPa3ZLdmJ4YUNGU0tJdEhkVjZn?=
 =?utf-8?B?M0FMT0Z2c2F3TjlYRHMweHV6TFh3SUhsK21RR2pnQzBwM3ZiR1BLUFVEMnMx?=
 =?utf-8?B?V2h3ZnRmSEVJNWhUY2w0dmdkMndlNW5PR0RMYlQxeFJNMFR5TExmb0pXeU4y?=
 =?utf-8?B?MnN2Z01RWDR3NExpNWJ4QmsyajBDNzQvZjlMclVZbGZscm5TczcvKzdwcy9y?=
 =?utf-8?B?c1hHZktnYWlCdlZCc3g0Yi9rVUV5U1cza1pyRUxhcjFOTVhoMExuVmxiNmFS?=
 =?utf-8?B?OE9Kcm1nZUhZTUVUU3FJOSswU1UweUExdHhOWTBiblptakdQYk9BTkVxdkky?=
 =?utf-8?B?MS94VnZHSUJxQU5zSDIwdlI1cUZJRExRMUlEYmxKZ1l6WGJuYmNyVmFNRWFz?=
 =?utf-8?B?VFZZNHZJNGkveXY3bEQxR3gvMjg2azJpU0FoRUlaL3ZRNEhQR1JIM3NJa3ov?=
 =?utf-8?B?eEgrM3p4TUJVb1lmLzdTcVBlL29BazNOWW9xeVFEUjZlelBKN0JaWnRyQmt5?=
 =?utf-8?B?QzJoVjRMd0tWUW14bnFSRmxPU0krQ0EvZmp2REtJUzVPeDRyV3A0SXd0bytO?=
 =?utf-8?B?QWVVUmg3SE44a3JPcWFNRnpHUTQrYnRyVW5XK29WZHpOVm04RnlIMkoxZytX?=
 =?utf-8?B?U0w5QmlIN3pMUDN5TEJkLy9kVmNVdWw2WjdTU3hodFlrRGw1d01QbDBVNGFZ?=
 =?utf-8?B?cjlFQnpTWkNSeURoREFzYTJHUEJtSGpxbWd5b1djUXcvSlNqMnFvVzB6VFdT?=
 =?utf-8?B?bHFmcHJzWjRQcWNVVEpTMjRIM3BPZFBtVUhPMkg2UTBqemtzYXcva1I1T1ZY?=
 =?utf-8?B?MnhSRHBMbHVEeXRwZUdHZWppQXlKYm9vcnZiNlF1cXh4ZkZyczhVVGlqellx?=
 =?utf-8?B?bkZhbmw3a1JWYXhuUktmMDhVUXFMa3ZnWEtjUXZ4ZHlHY0ZtYzNyMDdORGJ6?=
 =?utf-8?B?d01GaDA3bi85SC9jSVpDU2JQY0pHeGpTeW1wb3MrYXRwQ25JVUJsb1BlZXo3?=
 =?utf-8?B?V0NzTkV0UmpWdHhnaHVVYWF4aXFFN2pYeDA2K2V3WmRiWUVJVXhOWWFwakN1?=
 =?utf-8?B?TjdlYTVOc0drZ2hFSGlVQkZqdUtWVUhLdXpVaFdTRUJDVlI1dVpvM0ZucnIw?=
 =?utf-8?B?dWZ2U0xmQnBhTHdxdWFBK2xzOXJaZmE2QVUvcFkxRjRoWVlMU1RmaHowWDl1?=
 =?utf-8?B?K0tCdGxveU11MVdva0tzQmRTa28zWmYxdzVROUlmU1QyZFZxZ2ZEbnpMcGd1?=
 =?utf-8?B?R2RFWVVlV1A4VzJBMktsdmJ5eEJNQm9LRHk2VlhNNVlmWk4xaSs4ekUvdjFr?=
 =?utf-8?B?NDBEZUU2TE4vQzZpY1FkWnVzbTB2UG5VRTErKzgzNkFHakkwa3dHU1RjTnZM?=
 =?utf-8?B?Y0ZhYmMzNDhqaUoxQXNBaDM4cjU4Vzh6VkpHa2JpcGtnS0llUWxKMXZXRG93?=
 =?utf-8?B?c1V2aXBRcWVFWnVIYXZJU1k1Y3JaeFRRQnI4QWxSb1hlejdFUXRzMFhYd0c5?=
 =?utf-8?B?NTltcFBmamM1M2pQS3B3Nm1oTk1YV3FuUmFXTjNYKzdWUUlOVVYxU1Nzazlp?=
 =?utf-8?B?cS9yWXdpa1p2eHEyS2tJQ2VaRFVNM3JKWGVzTVdJSUxJL2Q2cW5EMGdhdUxG?=
 =?utf-8?B?MTFwbVpjMnR2a1VQYnRXcGJjbk9HaGIrK08rY1pzN1JGdWw3NEY4N2hVZ3Zs?=
 =?utf-8?B?QllKRXgzTmZHaEpmUTRVMzd1b2VyR0NTL05PKzJrMzFheS9VZ0tNZVcwZDV6?=
 =?utf-8?B?c0QvdjdPZ0JZU3MyUmhPdDVZWi90Sk5GbXFHc2dwLzlzeTZHM1NlbFRmbjdk?=
 =?utf-8?B?c2dnRWVzdVhIdFByU2t3Sk1NdVc2ZjNOZjdrR1h0T01PKzZzSnBxekpjN2l4?=
 =?utf-8?B?aG9CanBoY3kyN2M1TUFYYlp4V1dMNkROZW1hT215M1BlUHB2bHdhZlowakRZ?=
 =?utf-8?B?dkI1ZUtNKzZndHZpY1Zsei9tR1B3TzVtaW5NTWhEL01USWtEbHFCNTZBaGhE?=
 =?utf-8?B?cTlJVUhucTNIU0lnOEFxaWlKdjNFQmtMMTdKYjgrOWo3SkttZDlINFdYYlE3?=
 =?utf-8?Q?kqZthGa1ee9qlFH8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2a4396-37f1-4b63-3265-08de5e985b6f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:09:19.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtlYfe9ehkxWqWnIl4Fe84Uus7w/3qDUBs1FRrspL0cL0/HK25Wg8Wa9hVbgTYMsEMiMRNBBbLTLUt9+MmoOCdQAF9fREqMNm9ANE6GQM14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254408-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E90E9A7A7F
X-Rspamd-Action: no action



On 1/28/2026 8:50 AM, Mauro Carvalho Chehab wrote:
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

What is this patch trying to do? the title is not descriptive, and its 
contents don't make sense.

>   tools/lib/python/unittest_helper.py | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
> index e438472fa704..3cf1075b1de4 100755
> --- a/tools/lib/python/unittest_helper.py
> +++ b/tools/lib/python/unittest_helper.py
> @@ -8,21 +8,7 @@
>   Helper class to better display unittest results.
>   
>   Those help functions provide a nice colored output summary of each
> -executed test and, when a test fails, it shows the different in diff
> -format when running in verbose mode, like::
> -
> -    $ tools/unittests/nested_match.py -v
> -    ...
> -    Traceback (most recent call last):
> -    File "/new_devel/docs/tools/unittests/nested_match.py", line 69, in test_count_limit
> -        self.assertEqual(replaced, "bar(a); bar(b); foo(c)")
> -        ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -    AssertionError: 'bar(a) foo(b); foo(c)' != 'bar(a); bar(b); foo(c)'
> -    - bar(a) foo(b); foo(c)
> -    ?       ^^^^
> -    + bar(a); bar(b); foo(c)
> -    ?       ^^^^^
> -    ...
> +executed test.
>   

You delete a bunch of the output here, but don't explain why. If this 
part of the doc is no longer valid this should be squashed into whatever 
patch made it invalid. I suspect this is the result of the new wrapper 
you added?

Thanks,
Jake

>   It also allows filtering what tests will be executed via ``-k`` parameter.
>   


