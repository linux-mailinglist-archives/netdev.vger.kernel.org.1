Return-Path: <netdev+bounces-238728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64DC5E4E9
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4313A7B7C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A14335094;
	Fri, 14 Nov 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTSx29au"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E046314D2E
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138366; cv=fail; b=h9IjtM5fmP8Ft2HENb9AO71ftmoz27jLt8Ew8zkYnqSdNWwHr0oGpcA+vTgygJvIwyfSa2Wccbch2agwVMiBpI4MYj1EufovCgXNZqFqWuhrbS0zd19EbS9Qwv+lNNyO/bgloyf9lnf+9+Z4kNuGm/JbYVKXonVCGOKaWFzhegQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138366; c=relaxed/simple;
	bh=+w3T5bedXjHpj1s+1UfSKlnP6xlirqJuZyej+Khmadg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mr+ouFvQ/JeHeN1OJmWTx19c7L2TP9qRE2JqXo8xShMfQ/lMzwzkLJVo/yx93NmTZfEgFUhe9GkyAtCRQgDwGXmms9lXO2h6o2Z/i6tCaXYXanOcquezzonaAQLkk+0H4+6KyJhGkNOehn2uHifu78htx1YBUrqtWC0CMuT+zI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTSx29au; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763138366; x=1794674366;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+w3T5bedXjHpj1s+1UfSKlnP6xlirqJuZyej+Khmadg=;
  b=iTSx29au+S0ibyYhYeZE8VW+h7JJhEyi4NZ+zA9XUxcCZJByVwj7vSSs
   T7VUS3Y8sp1jNY4MTDJBoqz4f92o6p619wrrVwsdPprXsBb+vzX1SGABn
   9CwsVzs8cs5BaLhTJPHBbUhuFDqKxEW6DC5tdast7Ejb1Ap2uRb+W6W7Y
   li5HfqVEiG8DifEMOwU9ZVNKMeGdR4o3+pO1tRdDMqj5tihL6mV3DKiGz
   N+fGwohIMvEhQ+gyBuK3TCSU2qZxWYtlaGUfvifnpK9C0+7jZaYBu2nhu
   wwhs7sUuSqPEweSpOIs74NIV7ithxlBVjCeshwdwLQlKFzur3HOvYLOTb
   A==;
X-CSE-ConnectionGUID: HmxZyy7SQmqE1LrhETc4eg==
X-CSE-MsgGUID: bTc2gl7LToGu5AHRmDvmQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76697976"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="76697976"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:39:25 -0800
X-CSE-ConnectionGUID: c5jYW5eyR3GOCW6GA+pE+A==
X-CSE-MsgGUID: 2+E/EtiES8+TSUBCjk8JAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189827415"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:39:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:39:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 08:39:19 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:39:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TshKZAlnNmave/9qB6G8DpuntKnMt/0b95bLLmzSEedo3phOCvfE2AJO37V9Abh5OLDb+2q7JfC5sR15T1tRhAInDlEuwzMMeQTogfHeuEM7dcV5lTl8wuUZL7J7crjsecYPJKoZY+52qZSy0pZl3S2fU8i/iWjyHff8a5ccJz0KiFfxhkT7s/L1w91EnjnlK1RvFy9u8bvkUP/7A7UJyhxWSrYeB153xRuD9hFG5+vJbySToE7pdkhT9rfn1uqR/8nLuzJKKm6GppKiqkpqXtKnLmVmDJYjLnAxyKdGyskalt2K9nyV6L2isw/ZA2pfobadIw5Q3pTf7htu1lf0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDny53OLVww5HAYSX6UslXSSZxnqQZEj2f7Zqq+mAPQ=;
 b=waI42bCHvdL539dF9ibDA40oq4Sg5NF9wtrQn+FN1xHll3nhKrmgdL/m5qj5U9U7YeGM5WASZGilzPQyA/yXOaJzqBpai8Tmf1Hi+YS1PFJzhYsSxDHhir8plgnuj0cTx7ARKBPBK2yliBCce8UxCrUGUM4oUecsn7TKZBAyynEk11N5JJETQnx/0h959mrSl56bsjoqaiQxMrgy6Tsd8FGpxknlCKcAS2VWHW50z9RO3O6RR6CjAvIttRcnJ/trl0XMMGbqTUGVw/BNIGoYBOYoJhGqibbvfv/yvdtdgNBUdZGjeeNKrOMBP4QWYGJteG3XEUSlxjpN1j7bPL2h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 16:39:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:39:17 +0000
Message-ID: <a9d3ac94-e418-4e5f-a3f1-5cc05cb7c865@intel.com>
Date: Fri, 14 Nov 2025 17:37:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: gro: inline tcp_gro_pull_header()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251113140358.58242-1-edumazet@google.com>
 <7da3a15b-c1fc-4a65-bdfc-1cb25659c4db@intel.com>
 <CANn89iJejn+MEBqrXDKxgwPZydU7mMrk2HYZqN+CF9Npyjx7pA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iJejn+MEBqrXDKxgwPZydU7mMrk2HYZqN+CF9Npyjx7pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af7f5c0-7391-4444-b3e4-08de239c5a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hPczl0WDBpaWg1RHJnaVVnczhXenpNNitIVU1vWlpNN1VwNGkzWXJJVEtY?=
 =?utf-8?B?WDVHdVpRV2o3Z2FjMERUN1Y4NmdvYzB3dndhTUhEbGVYdnlIeXlDS3JXL1p4?=
 =?utf-8?B?alB6TkNHQ1FGVXN2VU5tNzR0SUhEaW1CbzBwUVRtcEZ3Y3dmSUhNNFgwYlNT?=
 =?utf-8?B?RXVtcWR2MWEyV1duRHpCNFRZaUQ0Q2QxWG9aTGZoQnlJNUFQYitxakJlV3Bp?=
 =?utf-8?B?VVhBV3VWakM5ZFJvV2JHNE95TThtUzdDSlNPQzgrWkNZclRXY0tFYTlpWjJy?=
 =?utf-8?B?andyMjNPTFNrYkVTQ1NyRGdDNS9ZaHFZaWxWT3ROeWplakZDNHlnN3MzbGlT?=
 =?utf-8?B?dDhBZllSWkFiajJnS1ZXZGFYUFZ2cy9kcjI5d1hBdU5oRGF5SHJCZW0xZ3g3?=
 =?utf-8?B?Q2NkVFNOd3JvV1lQVm5MdDkrbGRTOTFwMFlIZXkwQzh2RmJ0aHl2dFVBYkEy?=
 =?utf-8?B?R2tNeWtrWGxUWS9hZnU5eHdRTlB3UXk0Vy91Rlo1ankvZ3pHZS9vZjJqUUJ3?=
 =?utf-8?B?UW1ESlZ0V1oyNHVxemFPN2p1dVNYQ2w5RENOSkVySCtGRHBQc09xODFMdDRW?=
 =?utf-8?B?TWFVV1daeSs2UHB6N3k0clNHSHNKZWZCOUxFS1krZEc5ZCtWYys3bWtSYVRG?=
 =?utf-8?B?bkpIUi90RERRUHZCbWFtcEl3anJ3VGtwU0JiaWVldkt1d1lTbkprU05GcE9T?=
 =?utf-8?B?T2UzSkk0MEJtZWNpOTVDWW51OXh5WlRWTlZFOGFYL0tzb2VuUVNsSDROWGoz?=
 =?utf-8?B?ZUtXbVlRY3lKZlJTUjRBcW05WnRNd1pXZml6dUhmQ2l4bXdFYncyRFpKeWZT?=
 =?utf-8?B?anVXR1pxZ0xVMitFdWJRNDlISUljNGRKWGd5bEZSbStxWDhDZzdLOVo5TjM5?=
 =?utf-8?B?TE81RWhLemFHVnY5THJRQXFaZFNNaVBGck4yTmpYSWU0WkhKa2VUaGJoK1FP?=
 =?utf-8?B?OFhScXNTOEVCZm5PZ3VPa29vYzVzY01ZSWdWdW5kMS8xOEd5TVNlbHhGTTZ5?=
 =?utf-8?B?NlpoRVVSckJxMXRjRkNwcjhRV0VHNDBLenVoRjhGZ09aaFpEYmFtZFFxT3pr?=
 =?utf-8?B?ZHU1SzFDY1dON1JTTkVGdG11SWlWemRXck80Z2d6MEpOaGthTjlNYWk1em5s?=
 =?utf-8?B?VG54NzltNkZSWXpIbEhseGVIbjg0VmdqMGhPUzFiL0tnUU1LQmovOFcwbHQw?=
 =?utf-8?B?a1JjYlJqR0RjZ0o3TTZqS29HQ1JLOWRvR0x0ejdkdWVVMTM4QTFDUVJIaVdW?=
 =?utf-8?B?dXdsbGZWWmxBWlNUZmZWYm0rSmFBelNzQk1XM3ZWNzJxRFpRRWNWY2FJZ1hm?=
 =?utf-8?B?OEtRNHdPdGpCd1ovT3FEUEE5bVhUSEduMlVyU1VTczEwN01DcmlsTy9YTUlh?=
 =?utf-8?B?WHVoSzBrbjJnNVRBMVFNTmYyTDczWEkzODJnRUFUcWhKNjlSTjFGN2NTTjZj?=
 =?utf-8?B?cVozQTVHREdUeUVEU1RYQklNTEFsS2pGQ0tCSTk5VUcwVVRVWHZId3VoMjVu?=
 =?utf-8?B?OVNnRkVqNk5vS1dra2FxL1NKMUFYbldMZW5OSjBSNnJMZ0Y0ZjhDSndybUhY?=
 =?utf-8?B?MEJaZE9HUkc0MTI1cDI2NHQwS2pEd2dLSkxmd0NNUXlmNmV5bEFBQ2VkWFhX?=
 =?utf-8?B?WmR4WTEyMVFUbDdjaTdwZGtPT2U1OWsrVDY5S05Fd0NUYlltY2dWM2tRdnl1?=
 =?utf-8?B?QUwzZG9XTVhFaVRPL0RKeTY1V2VJb1paUmx6OHZFQ0dIV1JHOUtvWkhKdGVw?=
 =?utf-8?B?a0pQYnE5RGVzV3RqWHFuNkJ5c3grbWxWLzZHYUh3ckJRY25qUHlnYjFwVnly?=
 =?utf-8?B?eFlTSERkRXpQVmlZc1czTGM3ZTZOMmF5MDhXdUl4cjhtdVNNNzFQWmtjTG9G?=
 =?utf-8?B?Nk5EUmRjQkxYeFBpejhveDkwNExKYk9aZDJTd0JOcmpRZVFyeDZYUjlGbDhB?=
 =?utf-8?Q?DzKsCUaLMth9PP/gWY9yHfqNB01YnhO7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1Z3QkZMM1ZjR1hMWXJmK095dDlxMUVjRS9SOE5TNmhmZUxXd0I2NzJuMDAr?=
 =?utf-8?B?ZFNWdG9XUHU4ZDVwbFUrSmFjY3BhWWkxdXc5amE0cmFJNVJJcFBsR0krQSty?=
 =?utf-8?B?ZmtaWWNMNCtpRkcyQXFRMExQcEpQOXdQSVliMlBoRnhYeDJzQkF0TFNENERl?=
 =?utf-8?B?cDROL3ZQQVMvZTc2cEVZYytVQ2oxVkVNcW8vemx1MEQvQUN2TU9BWW9qMWIx?=
 =?utf-8?B?WDJYc1hiYmFsUlEvNC9GZk5pcVZNVFJ4eS9PVDAxUGRqMU9SM04vT2NlVDl2?=
 =?utf-8?B?N3dhNGh0SkxLaUhPbGhiSmhpNmJIc21FU21jbzZvMERFc3BVRks1OGtPNmJn?=
 =?utf-8?B?TEN3THpUZXhNakdzNVBKcVRVbGxuNmlxekVndG9pbVRSdmJ3S0JaZVZON0wr?=
 =?utf-8?B?REhtMXRKY0RPSVpFb254YUFLR0xLNDd1RExndmdoaDBYL25CNTlkNVFWbXhy?=
 =?utf-8?B?OXNROFJQREhtY1J4ODZXZnVwdElHZHd5WVFnczlwa1l6SFR3QWpIazJLd2ph?=
 =?utf-8?B?RWZnV2ttcFdOM1R6TWYrTUFHK3RNdHRwcDRVYzYyZVdWbTJTUHFDN0dLTTFU?=
 =?utf-8?B?bXhXZzhobmZnNHkrdWQzdmdVT0JOWGk2REQrQmpqV2pqc1BzdmNnbFQrY2NY?=
 =?utf-8?B?b3Bnd1M2ZE4wSWlyVk51Y0dWcllrcy9jL3NKbGRaNkhiUVNhVWJ6NmIxbTlu?=
 =?utf-8?B?SmxHYUZMengrMzJMT2Q3SmZkQlhDRURKUDMrd1ZjdmZMZkFpM2l1S3RQY2pC?=
 =?utf-8?B?WEluRGFDeldJakdmZEVKUkxqOHIrSkVwTkZTVEMrUlVXYXhDZDY2K1dBOXBF?=
 =?utf-8?B?eEFqczBRc1h3RzBwRGtEbGtKaklGL1ViZ1BKZWlKNVVSNis0WG0rUFFraFov?=
 =?utf-8?B?TlNJTU5xSnNubEhaR3BUNG1OVGZZZVU0OGMwb3NxY292VnUyR2w1R1BKcGF5?=
 =?utf-8?B?ZVhwdnJyUGRLWHdVcmRqd0syaHhFdW1ZbDdaWmxWNzZZWVN6OTU1SUVmcUlm?=
 =?utf-8?B?cGptb3NicnFhRDJTbmxxb2o0UzgvNzhsZHI3d1J5SStSY0dPQU1QL3R3RTVO?=
 =?utf-8?B?ZHQ1Q2xRQm0zdUlEYWdsY0o2SG9xNG4vTTBnNndqT0dVZWNuZmhaMit3ZFUz?=
 =?utf-8?B?NFVOOFkyMzBYQlR2UkFobFM0aTBaMVFXaUFKQUJranFnVVNPL0JYZ0xnWWF0?=
 =?utf-8?B?WDFwdFg0bW9YTkNjNUtBR2xFL3BLdjljdFVtUHpzS21lcHN6YXA4ZXJFWUR4?=
 =?utf-8?B?S1BFZGhXOVBsVWxWOFVpOEREbFZnZndKL1NyalhyRGVLSldrV242bGRzazUw?=
 =?utf-8?B?VzhTekZlR0hnWUZJTlpXNnZsNGtGL1paZVZuaU5Xdk03NjJQVDVVd3dSY1pk?=
 =?utf-8?B?SDBYb3ExQVFPV2wwSHpkUzd5NDZPMXVRODlUeUUyaXhaam5jVTAwMGdmcXRa?=
 =?utf-8?B?dWZ3U3FvSGZ0bGhodzcrNzdDenByQWRTSjI0WSt4R0k2VG1nU1oyZDZHVWQr?=
 =?utf-8?B?MG44RENMemQrRVpFYXZLWnI5b210TnhyZ0VPYTlCOUtWdVlNTWUxdjJrWlRT?=
 =?utf-8?B?c3RkQ2F3RmppaCtXRFFOaEMzZVAvNUd2LzcxY1ltaU5zRVluRGZrNGFOUzJQ?=
 =?utf-8?B?YTU4Q1NPOERHTHVPR042N3Vsd1ZIWWtsSmlIb09hZUxKbjZNOXZUeDg4Qjlv?=
 =?utf-8?B?VjZkc2hxcEI5N2pGSzQ5bHRlRzR4TkRxakZjejVvTU9wSC9oK2RhL3Arakh6?=
 =?utf-8?B?S3NvWDFaR1pwTExNRjVjY3pheGpQRHl3UzNrWFgzRWZSVk9OelowUkZnZGNw?=
 =?utf-8?B?NDVVVGYyTGo1UkdXdGEvbWF5Ymk2S2RSTGMrMGNOZEtWQ1JpeHVKbklnQ204?=
 =?utf-8?B?SFQxeDhsSldQNHpKc1REZm1XSWpVOFVMNVM0a3YzS3VSbTF3bUZlVmxEMkZh?=
 =?utf-8?B?dDBDMnNtanliUXJ3eHUxZ1NXQi9hSlZhNzJLQ2I5VFFBY3FmaFovZ2FodWd3?=
 =?utf-8?B?OU9pVXcvWFNNYkhaMkF6d2JablZ1TUxRbHRmUHVxTi90UlVIYTlqTFVBTWJC?=
 =?utf-8?B?VW5ETzZYN3dURmdTcTNFMEo0WlI3dVRXeGdqa3ZES2xjTTlHTlpuVFpROGda?=
 =?utf-8?B?OWhQcW0vUTE3M1Y3Rks3Z21WeEhqd0o0SThUMFI4M1RUUGRqcDFSUWRmT3hZ?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af7f5c0-7391-4444-b3e4-08de239c5a10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:39:16.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb6ehqZv76R256Srfd5TMC/QONDsnHahH4Qqx/2Xq1u+AMQtMRT4m1M5zHfx8vQ8RG2fym4iuRWX7bGKrAO/bXeBEvHJ3ZVBkrfTM6ywAeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 08:09:31 -0800

> On Fri, Nov 14, 2025 at 7:56 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Thu, 13 Nov 2025 14:03:57 +0000
>>
>>> tcp_gro_pull_header() is used in GRO fast path, inline it.
>>
>> Looks reasonable, but... any perf numbers? bloat-o-meter stats?
> 
> This is used two times, one from IPv4, one from IPv6.
> 
> FDO usually embeds this function in the two callers, this patch
> reduces the gap between FDO and non FDO kernels.
> Non FDO builds get a ~0.5 % performance increase with this patch, for
> a cost of less than 192 bytes on x86_64.

I asked for these as you usually provide detailed stats with `perf top`
output etc, but not this time.

(although you always require to provide perf stats when someone else
 sends an optimization patch)

> 
> It might sound small, but adding all these changes together is not small.

A couple weeks ago you wrote that 1% of perf improvement is "a noise".

I'm not against this patch (if you add everything from the above to the
commit message + maybe your usual detailed stats).
+0.5% for 192 bytes sounds good to me (I don't call it "a noise").

But from my PoV this just feels like "my 0.5% is bigger than your 1%"
and "you have to show me the numbers, and I don't".

The rules are the same for everyone.

Thanks,
Olek

