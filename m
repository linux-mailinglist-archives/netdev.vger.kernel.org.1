Return-Path: <netdev+bounces-136338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2EF9A15EF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 00:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3640FB2125F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55C1D4161;
	Wed, 16 Oct 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPDCZ2GY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F19F9C1;
	Wed, 16 Oct 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119287; cv=fail; b=tK1HsxPekJLKg0q0mITDCbnCdWGGK6JzlIZ/orP9nv+HHe0PhUAcLoztnXvB+7JwcPZzucEKTChw6QIez1Q2i/gZ24ZMBiG+i/GU7QeLyf78PqfsrNn7sho6Sfcmky65TtgnIDE0oKS/x4Bl9Pdp71+LIV5wrBQU5nEL8qEy/n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119287; c=relaxed/simple;
	bh=I6ASolnuefcwRD3S4aitBNhuSPtDe22giE1LOyiHbRA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YeZ6mdo9RLVnY9TaA+j/6LcDwZTTGNIVrvrUQWcYfgnqMEG8J1Vigaam9r+dHA8gCs3hcqQJ2NcTGUDpJ34PHxI5XQCsiX3jSStoa6se4fVxtzBqifi2vy5Dsk3sVv3WzvzkhaFLJW10pGmhS8nxgZq4zTN3mFHV9ZRT1MELgEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPDCZ2GY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729119285; x=1760655285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6ASolnuefcwRD3S4aitBNhuSPtDe22giE1LOyiHbRA=;
  b=kPDCZ2GYh+9uyuEsQV5g3/ji2sp1q6s/G8rN1Dpi8/uym2KDSNaWacgr
   T9hv3U6WtTiHXBfwfzKCug74Ik2JKq18ZRVEM2h//ZaGdkqvpSntNfQGh
   XZRp4RWO5GNhxovu6gaVA8U8FVs2fwq9nT62UeS3a90Xf1Qd8glzmyIHW
   2UaJScOFgEe/jVKU2rmqJISLpO8hYDB/qm9UY4lAL9JVSjNV8I+9JHiI3
   iBQbVEQYOVR1XzGSCsXmHJ/XKEo6ghpNAGF6kQmkY4A6aNwb53mfYiJ6k
   Z9FPbQ1I+EyMxnPH04F6jphUreR8GW92B2FkEtYrbj6O+FVL5dP9JQtDD
   g==;
X-CSE-ConnectionGUID: RoA7BaqSS7ODcMyvt+BlEw==
X-CSE-MsgGUID: 8zoGCk5QR7mCosTvQgfhOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28477435"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28477435"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 15:54:45 -0700
X-CSE-ConnectionGUID: 0zJ3RkBoTUiQt2J54SHagg==
X-CSE-MsgGUID: ofY98bpoTXyb/Q9U+rSmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="78706379"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 15:54:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 15:54:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 15:54:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 15:54:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 15:54:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 15:54:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR2RDNLRoOZfj64xQss2FdHFsOCicBgwd+b/fyhRqAUyp9d3+3+Xw0OHGUYNCJQFrPzeAdNj1DJT9YrFcL3bll0l95eg6ljMghGWHYFHO7GEWzBz/FIIqs7SwOCrlY+HdA9raGXzBEHnoV2tPMlHgu8s8U3o7w2c+k7EGFo0XqdL1XqHxmmpv/NROeWFxN9NsbMOyWAI6wYFNmrIaTgDLXlfjerojZYmJxUmpnAy2m+/xSzDMoBAylcJNegK7t4WJXwYzZZgrrJ0Ryc5VV90r9Rcoq8zTFxrLiQ+Y/Q7Rk97S3xJ56n7kC63R0O7ENaIwwcT2WZKtJBS9QGK1tMGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbNwMC/Pkl4stIaKuEUTVFBeeF8wbibTK/6nXLsCVAg=;
 b=QTDok+agHvgnUQ2r8IkL1rw0lT+c/m+pJ/rjoUWCapFX3CTyIfBdeTTm/mEQa4rO6WTFDIUGBlWw21lCM+QOBINZ1ckmYirdAGdYA7Jx/7Ht7Yr2wr9tMv0wgVG65TCs+OHw2jWP+sfCwIf0VVGAYBx1iFgtUtKC5ViAHvv8YzlJmIB0fMbLB3VOe4Ynu5/zokNRCFgJesmflsptK/gY+RLSmk+a76MJC65vcl0GwbP0VvC9b7BVqgAIApYx107OLXkn86r2hxfnQUn8zY0kUybpZJvTDNU35rbUKIOvDgVxEcQjzLZq29yLuiVGR4QmMQ4kKad24hI5B0vbU6QPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5324.namprd11.prod.outlook.com (2603:10b6:408:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:54:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:54:40 +0000
Message-ID: <6611b169-e071-4b12-a7ab-337fa1cbe314@intel.com>
Date: Wed, 16 Oct 2024 15:54:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igb: Fix styling in enable/disable
 SR-IOV
To: Johnny Park <pjohnny0508@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
 <20241015174607.6c29bb8d@kernel.org> <Zw866aMO9sfBXRsm@Fantasy-Ubuntu>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Zw866aMO9sfBXRsm@Fantasy-Ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2a70c4-26ad-4aef-d858-08dcee35846c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUVRY0ltOWg3N3l5aUZvZDdpbnNpcVJqYm1iaFpiU1B0M2pMeDg3NXI0VjVv?=
 =?utf-8?B?alQxUDRIYTFiYXFmK0lIUGpyUDBwZ2cwQm1paUtaSTJUZUFCdkk3MUxvREk5?=
 =?utf-8?B?Q2RSLzlsQWk2UWFCbW9VMERSVHZXUWhlZC9zZk9mQTArb0tUbkdJNXVuRHh6?=
 =?utf-8?B?MGduMXJSQkhPQlEwNVMrVThIWnM2dHhzZVhkU0FXaTlLaXBvMFV3NldXN2N0?=
 =?utf-8?B?UXVHZEQ0Z3c4VktZNEIreEFOL2pJOHpneU1ra1pMdGdHbzlGY0JiM3BxR1Va?=
 =?utf-8?B?dWV2bnFCckFJdC9SbEl4Q3YxWjh6SHZLcXVvYWdRd3dEbTFUc1hWVUlHTFR2?=
 =?utf-8?B?TjRYTldKZ2poQ29UZmJYeEh4RlI1MVNMNWtiMzNsaitMLzBaQ3lId3piVHN4?=
 =?utf-8?B?R3l0UkNINTl3QjVyZ21xRjZ6UXVSYzBReUJSYTlXd2c4SUZheW1uNHB4ekQ4?=
 =?utf-8?B?WmlSUW4xR3ZJcklxdDkvb2JYYU5ZMkRuQVZSQktaUFpROXNqc2E1L3NpRE1J?=
 =?utf-8?B?N1RsM0JaU09hUVNoMkFDWitBR3FCa3pMY1UyT2JBZllCd2tXbElwOXovaEJv?=
 =?utf-8?B?MkNjL0ZNYWl0UThxTjhlZzg5Q00rc1pUWkRmY3pJRlQxMHY2UlRnN2V5SThP?=
 =?utf-8?B?YUtaMWQ1bXZLQmF0U0FyU1ErTkUyRWNITUVDM1IvY0VQUDhhZFNoNW1vN25B?=
 =?utf-8?B?NUhtZ3pGd2pMbHJrQUZudUJlR25nZ25USjlaQ25TZnRHMzR3U2FDYXJyaWdn?=
 =?utf-8?B?SVByUkdlRzJHWHdpam5jekpSUktsOTJZQVJpcEZtYy9QVlNxRVNSZFIxSit4?=
 =?utf-8?B?NXFKOWJGYURLK0svYjhEOGFtU3dDcU5hQzRSdHBQUGdXeFBTODRkZEd6UGxS?=
 =?utf-8?B?MUpuVFFxOEQ1dHRWUkd4dzVmL1JVTGU4TjRSMzBMbDFVUFQzMDMyU2lrRXVC?=
 =?utf-8?B?UjBNN250Q0ljL1JEa0oxZ01ZWGhWZHE4QXNObTNCakNVRnhOMnptck1ZTnJa?=
 =?utf-8?B?dDVzVUtpVkQ0UFErY0hJU2lhU0k0Wmwvb0puSDhSVHgycFRiRlJIdW1sbmI5?=
 =?utf-8?B?VUlXQzdSVkQ3VVhaVzlBY2hLbzVhRGlHdzF5SGRDV0oyQkJ4NkFMYzN6b2lz?=
 =?utf-8?B?RWYwak84ODFmaGs5UHVITllWb3lYeG9nc3FNYnYzR0U1eTk1aTVRNStvWVZv?=
 =?utf-8?B?UHJuNWIyckVqdVRQMHVjL3RrZm1HbDY0SzRMU3U1V0ovdlVRdDc0dUphYy9X?=
 =?utf-8?B?SmRGQnVvY0dydHNVT2E2aTI3ZzJOUFhhUXRFbGR6ZWV0NHZIV09iWURZVG1C?=
 =?utf-8?B?Z0hnWFdKcFA3TW1iNWdSVEpaWGZDa2xzODNaRnp6WitpNHFWNGV0dEMwZkd4?=
 =?utf-8?B?dGZiNFRMbFlvSllmWEtERitkZ1RoRHloa1ZSclFVRnp5SFJRekFVU2loSTBO?=
 =?utf-8?B?VUxWUFo0d21SWFd4NVpwSEhxMTAyS3lXYTIrUkphZWdqNUhXanVUOENjSk5H?=
 =?utf-8?B?NkVpQVZrby8vbzFLL01LUEtzbVRlOXVHY0RUU2pJWnBOZjVaRmNJWHlLOVZ2?=
 =?utf-8?B?aVVQbjFmcmhqaUZpQzh5d2hkYUZoSm9rVlQxRE5JOU8ySWhUbks4UTFoMDhS?=
 =?utf-8?B?R0VzVHhnOWNWNVQxcmJyd1VaMmtpb0JCZ1p2NGlqSmpFY29TRkkvQWowTGRJ?=
 =?utf-8?B?TUwrVXBkb1lFVnVJem9EaEVDOStUS3kyNDNlZlNPdi9CaEFXWXpTZEtlejBx?=
 =?utf-8?Q?CIcGt8JatjlUJDTe7lS7BzUEubQBErSna+4fqBT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVNDSDVIKzkvZC90ZWE5ckxXcTFvY2tXWFoxVU1EcDMvS2dCQ28rM3dkT2Rk?=
 =?utf-8?B?RmpwYU9zL0d6MzlpckJiTElSSzBXYzZna3ppb2dLVGVEeDU0QUZGL1dqVHVt?=
 =?utf-8?B?dG4wQnBzcnE0OWgvSDBkRVdlcWlETGx2eWZlSzVwYnM3WEVVNzVYaWowNjBn?=
 =?utf-8?B?bS9vcWdyMXhxMU9weFpFOGNDSGFJbEtGTE1CMUhORlUvbGZ5bG1qSVMwYWo2?=
 =?utf-8?B?ZVNrbDZwNkJ0VnRMVGlKd0ZLMjdEbmlTaGE5ek9zSlI3U2I5MkxjNmF3SW5z?=
 =?utf-8?B?dnlVNVhoVmRqYUEyQ05pd1lMNklzUVRyVVBFbk9FY1JZK0JIT3lXQUpqaUVy?=
 =?utf-8?B?dnQ1T3NzTTQyMnRJTStCNE50ZlkrYVJkV0RYcUlFemJGdUlQaUhDRVZPandV?=
 =?utf-8?B?eno4TWFTL3RaZ0dqQnQ0Y2Y0QU9hZkVaUXc0aEJ6VmdnYXlaR05DTlFzN2gx?=
 =?utf-8?B?eGRNQWlYOFNzWlduQmVvMlljU1hNdTkwd2h1Sk5WQlVyT1Z4R0lQZ3ZuSHYv?=
 =?utf-8?B?MSt2RTlWMTdIa0ZoYTBlb1daOEJ5dXFTNy9sUVNkbk9oTFdqUENTaERNSE1a?=
 =?utf-8?B?K1oyS2htMHVZRkd0VXZSYTN5cUhXcS9OUm96YndPUjduQ2s0aHBzQjFhaTBo?=
 =?utf-8?B?MmNka00yQnd6djVuRFBFNHMzRlEzbVU3Y0ZnanVKTjdVVHFVeUlsRXJpOFRK?=
 =?utf-8?B?WnZtL1VHZkswT3hxdTN5YVJCVGVJcVpqbC9jL1hoTmpGMVB6d3ZIMHViZW0v?=
 =?utf-8?B?OFZ4VS9vNkQxVlhYbG04K2dFZjJicHYzQTZIQ3VSR2o3eFZUSlJQK3o5SWU0?=
 =?utf-8?B?UTJPS0FnckpkcVhVbzdiZHNaS21DaHRkRHpPMzhKYUVwcUxmdEFFTUQrMWJC?=
 =?utf-8?B?eWZIRGtqMjQzdFNEcEFwSlJWajRLMXRqdFNPME13OFN4eS9RNkZNaVZIY2ly?=
 =?utf-8?B?RmZKOFdCcUZYdjFkQ2pKTlY0NmdIb0ErSGlSY09heHNOZkZjN2huV241dURW?=
 =?utf-8?B?aHl1QkJqZ1JhcE91T0ZRUzVaOERTaWg4M1ErVGpTNVhLc3lhekU1d2MxWW9H?=
 =?utf-8?B?aUZDMTdZaVk2WGdaSWNMZnVFS1ZwNGcxa3lCbUZOajZOSUtSZTVyMzROeEY4?=
 =?utf-8?B?bC9sbXBHTXZUWWtPb2RTaVl4bVBYS2o4bjEwVnVyVXRzS2hOaGlGd3hZY0lJ?=
 =?utf-8?B?TEtSOG5adGNXUGxOQnEwOFJyUytQSDRNL2tBOEJwK0ZtTjRwbk0zQjNZaE4z?=
 =?utf-8?B?elgwNVNLMTRCbGRuRmlZSTJIUDNheXFBZXJZbU5RTlVKQmhDczlPM1d4ZkVn?=
 =?utf-8?B?TkU3REZtNzdZdThFaDhYbTNmNktheTZnek5KcDlHSk01NktYVnVSQTdHbFRS?=
 =?utf-8?B?Kzh3OHAvN0laVXJ0OTJHOWNvbnVtWXlwSlQ1QmFiQ3JwY0gxcE5GMWtWd1gr?=
 =?utf-8?B?M1ZaY2ppYzJwRFo0SmlDb0ZXeDVvOHpZRElkVkhaOHlnNHl1akFhSUx3M1BL?=
 =?utf-8?B?OGpCQmVRc1FOUjhseFF4Uy9vYXgyOE05SXJ3UTlDcHNhSzZnZjFDZjI4NzJB?=
 =?utf-8?B?L1BJU1VxWnNsVkEya2QvQXd6QnRRbitOS1h6L0xUcERmTW4yWW9iaURsRVpQ?=
 =?utf-8?B?SWNoczM4d1ZySEljZmRYd1dTVWlnQmM5WmxEMi8rQVBJdVcxVjFMNzd0VlBm?=
 =?utf-8?B?bm1BTTNxdVV6ODlLZVI4RU1IcHdwRXIxVEYzNkQ1L0dVNzNYL3JmRjU0a0ZK?=
 =?utf-8?B?cWhWZTVzMDFCRExsN3VaMkNTZVZmTTZyZkMvc2JxUjJQbU14VVRoZjZwVm9R?=
 =?utf-8?B?ZXhETmQ5WDA2WW1FNFRKRmdGYzhlcmFGdllDVW4vMUdmRnJ3YVpJdjFhTThX?=
 =?utf-8?B?ME9HOUVRYWhvRmRlYmYxcTNybDJMS3ErMW9mZVY1Yk1JQllkZ25jNGlQUVdW?=
 =?utf-8?B?QXB3Z3BhcTBHWklZYU9IL1N1ak9NKzJsRytXbmMzcE51MWU1RG5odFRZcHVF?=
 =?utf-8?B?bExoNmkrS0kxWmR3QkxieWozU3lPazZVeDZwZEFTT0Z3Z0g3V2JnaTFoUzFD?=
 =?utf-8?B?ZDFqdDhmL1ZWWGF0d2xtcC9qVG5ORmk1bXRwK2pqL2pneVRLQ1FZUXJlL2Ru?=
 =?utf-8?B?U2pRQzBWRGcxWnM0Nlg2aXh2Y2oxME1EWVcvTkh0RTlYWVVQVVZXeFYyK3Yz?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2a70c4-26ad-4aef-d858-08dcee35846c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:54:40.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iYuNE4ouOnj5IGvWHtPDeEJzWdC6GFVlYTRJIKArvPEytrSiNgouPUfmhmHjpU510hTTjd7ljY+G525x+ZSC7e+14Hu/hEU/AAPzmKuVZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5324
X-OriginatorOrg: intel.com



On 10/15/2024 9:02 PM, Johnny Park wrote:
> On Tue, Oct 15, 2024 at 05:46:07PM -0700, Jakub Kicinski wrote:
>> On Mon, 14 Oct 2024 17:16:29 -0600 Johnny Park wrote:
>>> This patch fixes the checks and warnings for igb_enable_sriov and
>>> igb_disable_sriov function reported by checkpatch.pl
>>
>> Quoting documentation:
>>
>>   Clean-up patches
>>   ~~~~~~~~~~~~~~~~
>>   
>>   Netdev discourages patches which perform simple clean-ups, which are not in
>>   the context of other work. For example:
>>   
>>   * Addressing ``checkpatch.pl`` warnings
>>   * Addressing :ref:`Local variable ordering<rcs>` issues
>>   * Conversions to device-managed APIs (``devm_`` helpers)
>>   
>>   This is because it is felt that the churn that such changes produce comes
>>   at a greater cost than the value of such clean-ups.
>>   
>>   Conversely, spelling and grammar fixes are not discouraged.
>>   
>> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
> I see. Apologies for the inconvenience, I'm new to this area so I must have missed that portion of documentation.

You likely missed this because its a recent addition to the docs by
commit aeb218d900e3 ("docs: netdev: document guidance on cleanup
patches") from a week ago.

The policy itself is older than this, but we've had a recent surge in
similar changes on a few drivers.

