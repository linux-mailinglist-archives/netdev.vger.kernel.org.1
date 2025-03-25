Return-Path: <netdev+bounces-177612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F5A70BE7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F69C3B9561
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C39263F32;
	Tue, 25 Mar 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjfJB5Bp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8922B8B2
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936764; cv=fail; b=MMdeUuyIA+xm7I/s2SBQgZ/ihOJiCPcsM9mQLMI3JJR79Pc9lHxZsDOIIzX6/uct3N+S6Zw/P9cVloJ98+7+ZDWSdD2ngU9UZQJedL0JOEbNTQ5xUzV+3C4HKOzhJOwDwVklLa3xuTuDSTlCUenAuPyH3Q9kmakUM24RQJ3o5q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936764; c=relaxed/simple;
	bh=TtbhTHHLKREUyk37qwSff+Yayaw3HaXsHHjtMigeSy8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rAnWnaWpn7rQEOh8oMsPC9hKPos8zg50uB5tZ90n17HHR5Uu3HK/danjBDldkNx7AbO579FvD5dM2G98A/pmGjj/sm1/KcJXW4SUzeCB99hR0qUr+kDDRKLXIvdV0CqQ2tiJ0pVnbWqOvoUw/xnNlueu6sJA3C2z7vc+zBkWf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjfJB5Bp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742936762; x=1774472762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TtbhTHHLKREUyk37qwSff+Yayaw3HaXsHHjtMigeSy8=;
  b=AjfJB5Bpf7XF45sUqyC7dZFNkTIa2Ib4S7gND+uI66nsFZSfMMDC4l28
   ebg7UdDnNFW+6gPv2uEwUsYzKxEDLOEH3nf8jqNOU0ZP22Ej8reEDtWBC
   HxDZZfPcSZlkUU5wlL7m4hq1ExZvS6NBfqEFFAVqKp7GmYJFrIQ+KTgYw
   15jSJeKy3VvCfitFB62YcfLxuWHBWN+q508RyxUM3iuH4sB8tUETVR42C
   hEc7n8HYIo4MwN2dJ2FiH0It7ZLvmrrWom7kdUnXMTYr2ye9nSbuSk5hr
   plbxrHoBu+A0SFN/+KXIM2xOdQBFLU0XUdt66spqSLNRvR6jVoIEUKRsC
   w==;
X-CSE-ConnectionGUID: Uvx4OvAlSXq3BmuSkd2Kjw==
X-CSE-MsgGUID: +NQf1frKR2mtZdi8VIx8GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44362455"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="44362455"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:06:02 -0700
X-CSE-ConnectionGUID: iF3hzo5GQqqs6bmyT3Jjcg==
X-CSE-MsgGUID: cE4OGuiORzG+JssjR9tFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="147679670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 14:06:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 14:06:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 14:06:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 14:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1nF+u1neYRhvcvsDksh2LfuPqy3Oklvdz3uzvgjGlF8IB/aAaJgXZ/6w8soAx1BDAGyXKH8pcv/XXrxWrc30dQ+Z5eS6k/DAf56u9+fx4UQNFYWV3cvNsj9kB3kdBkwxMWFr8qdYoPlW0thFgRcfydj85MEtJgGqnPtGbD8m5yzKYNKzgGAh6Liu7FtPfFYbsKAHOsRD5s1jX/2/zV2vC5jwHdE9SyQ26T0TqnJlVIWQAEZcCPmmBqo3WVv/FEH7jao2undDwvrt6zkghn2ZvHWBNrIBrEzIjC/zzCph3IdcyLcaMTArTJ+BFyBZl3YTYLsF25E0PUH3xwJbeCxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2lv718bPc5n53+xyM9n2iAhT3HK5wcP5j4Uqq0Vzmw=;
 b=AD4B6EcLXPuPQaHdiuLvdAhpKvXUamrYn3ba19HpIN/Ac3Cg0OjMOW8qr3rbRFV1U/piDY19UxAIEdNlYY0HG59fujkGhLFdQFXSZj9O+kyg6NdiJ7KiCRBPRrfFzBeFOTm36Oq52KJKVmCS4LPi+abVPYlgPJd4fYWMvq71+gwZaVm/36kaDMMhNK6jyewomcvF4o3Y1f61JH6SVtNe2vUmyGVuJ1yJBn3NN99zPJe++1jT6MXp0rrNGVHJtJvO0j6CjP9MzeNwWEkrH7gf4KGqNolC2udw0TdOLo78bv3vmq5HXjDlExc4RnN2fblrBa4ESghiv/R2CnA5GYSwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 21:05:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 21:05:41 +0000
Message-ID: <08a7931e-3374-44e7-971a-e8e2a876eb9e@intel.com>
Date: Tue, 25 Mar 2025 14:05:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] idpf: add initial PTP support
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <przemyslaw.kitszel@intel.com>,
	<karol.kolacinski@intel.com>, <richardcochran@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-2-anthony.l.nguyen@intel.com>
 <20250325054421.7e60e5ad@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250325054421.7e60e5ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: beb2d81c-8df7-4a9d-8f57-08dd6be0ccd4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1AzbkE3bXVoMWdoalRBaUMwMHNHOVcyb0NUYXpSWWgzRFBxT0ZxcGh5ZG5z?=
 =?utf-8?B?TkZlTWJCUVdReEtSRk1JMGpSbjFXRE5QdzEzTW1jcTNGaW5CVkx4SHdWaldP?=
 =?utf-8?B?Vjk0YjlxZ0xKdHJMUTlqazJCQTRrUldldk5pUm9GY1VqL2NPQytVUWw2L3VE?=
 =?utf-8?B?eWl3ZUFxd0d6R3JXTmhYc2ppbUdMV2EraEpqWFFMTUs1V3BFd0doOEEvMUoz?=
 =?utf-8?B?RmExcW44c1FuZnFHaThCVGdoWGZHUUlPTnFVOUdmTkdtWkhzY2hoWm9tVlNL?=
 =?utf-8?B?R1oxcE8yakJCTVE1Y2s1WjQ4dSs1YkN6Mk9tREpFanJTZzVuTEwvd053TEhy?=
 =?utf-8?B?VUxuZFVGeG41ZTdFWVBsUDlFZ2FsQ3lQcEJEZjhrSDJFOFhyT2pSSmwrVG0z?=
 =?utf-8?B?OGxnUlZ0M0V4RUNVaHltN3EvU1lBU2ZBMWtnQjlYMzd5M01CRlREdStWMFZa?=
 =?utf-8?B?SXppUjlDNEk3dDZBdFdpMUNvMHE1N3FNVmc0eWpwWmtIemlNSVMwYXdOUlhh?=
 =?utf-8?B?cytCZm1ZSDB5Mmgrb0g1Y0JmQnp2WitsZW9xRWVFSU9QWlpQQjBDUW95VXlI?=
 =?utf-8?B?b1BZZTRiTlpzdjlhZEREaE5CNHVSTWdEZnRjcnlhVkdFWkRXdW05Z1F2L0JN?=
 =?utf-8?B?bTQ5YXZzbnMxUTIwNXA3RFdBWVJmT0ZtNVhScGVXQkl2b2RURE16MmdyenVv?=
 =?utf-8?B?N08xRExicHJ3K21mU2VrQmxsVnJpMnF3dnZqalVXOEFsY3RuL1VkSXRNMDFu?=
 =?utf-8?B?NVYrdjJlU1NMc05vS0pBeUU2VldacUU0MVZWMG9Ta2ltb25xb3A0QTkrUy9v?=
 =?utf-8?B?SEs0QWo2dytqUkkwMmV4b1pJa0JuZ2tncUFNNXAwb09XZFFzQ1VwY1d3TnVo?=
 =?utf-8?B?NVorR1VyR3NnSXA3U0pGb29wU3hEeGZKUmlKRHVUdDhFcXVQRkhiLzMwSy90?=
 =?utf-8?B?bkE1VWc0Wm0yYzlDWFVJVWZsQ01NcUFoSWlwRlNoYmdSOXJ2WGlYZmYrNERp?=
 =?utf-8?B?TjNwREUwUExZc0VvM1NBVFhaVi9FSnN0NDRVZWMxR2pEazNuTVYrN2c5cjZm?=
 =?utf-8?B?L3V1cTN0YWVGbkNCWGlzRjNsZGRBTkxEcTJLOEtNaHJNZDNtN3lYTkZ0cHRq?=
 =?utf-8?B?ZlVqTmo5N1B3U1R3UDZwMzNCekVrMm84aWFBVTNnY3ZDdXQ0SXpkYWFTZkJn?=
 =?utf-8?B?UW8za0FyUmdIOExDb3Q3L1ZDSVhlWmprYUczSEZCbzVXN0JGNEpuUzNnVG9h?=
 =?utf-8?B?QkhIYlJIbnBsaUk2a1poTDZjaHRrZEtOQ0ZpTm9GUkQ0b2pIdStvZ2xDeVAy?=
 =?utf-8?B?RGFHdjNUT0YvVFFsSTIxY0YzSWR1Q2Uzc0w4SVRiakdRbE1OcGg4UVUvVDhz?=
 =?utf-8?B?Ty9mYkc0QTllQWsrKzBzQld4WjRta2JwVDNyeFhKdkNYRk52a3hZK3pXbXNB?=
 =?utf-8?B?VURsOC9jNGZrQTBsUS8xWGpocjNGMFhXZTFLUEIvN3BGTHFRcDFiK3NtenZv?=
 =?utf-8?B?VSt4emNlL0R4aU1pQUc3VGthcHVpNlV2YzBxM0tPQmZ1TUhqdENGYkNoeklD?=
 =?utf-8?B?R0x2b2preEpDb1RMekE3SVlrUm96UTV6cWxrYURCNXloRFNCZmJBTEpkU2J0?=
 =?utf-8?B?b0lCWC9PZ1RKSVBEdVg0V3JoN2Y2dnY3cTBmNUVZWWVDUG9ud1V1VUR3alZj?=
 =?utf-8?B?MHJUSlh0S2lZT09hTnBUZlRFT3BwREE5ajk3RERSRk8wYktiT09zWkNNQytM?=
 =?utf-8?B?NFp4bStLL0tyazJQZ2ZnUDJJZ1RlR3NEQWlleTJlVll2TVh3ckczREtUWWZW?=
 =?utf-8?B?YUdBclVNRm5nZkRkZkg1VTRXYWFBNVBxSk9MNnl3Z3U4WEFPd2VjS3ZNdm84?=
 =?utf-8?Q?DCdRedxcjYNAt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVKY2I0L0tmbEY3VjBDWnNjck5MNnhka25iWTZkQmlTSTc4N3dVRWhCTUxB?=
 =?utf-8?B?WlF0Q1paWDI0WVJlSjk2R3p3citLbjNwRU04aDNyTG9xdDhUc3JsRnF3Vzha?=
 =?utf-8?B?TVY4MHJ3UU1vMUdLelNzTzlJQzdsdDcyKzRFL0lxSHVjeVNrUkZBbkIweG94?=
 =?utf-8?B?YWFwRHVjcUVYeE1uMCtNaDBNeUF5djdKeVZMOW8vTWtZd1licWJFRW95RkNN?=
 =?utf-8?B?Rnk0a09GSnhzVi9iakx2UkYvTVQzN2gycEZ6MVhycys4bWZJWUF2NVF6ejli?=
 =?utf-8?B?dm1pZVFMV1pyL2w3WFI5MHE3cFRiWFIwQTBxTlF2ZHBxQi9hNDcrc29JcHJQ?=
 =?utf-8?B?c3pMUWNaNlFJVTk2dkpzRXZvVGR0UjdNeWNlVFRkZ1V3M0h2OVNXRElUS3lM?=
 =?utf-8?B?WW1RbklwQktma2ZPUEgwTUZtZEF3RXlydVZ1UlhsbkpGMzRlMFUvK3o4WUFn?=
 =?utf-8?B?SStLdmRkVGMvWDd5WVJSVDYyUzIxK3hpSUpQWFJ5bklCRjZkTzRNODZWNk5w?=
 =?utf-8?B?dnljdmNWYlZRbkJpNk1qdXlvenE5OFVmK0paQUNXQzZMRlg1THpua3pmdlRx?=
 =?utf-8?B?ejQ1eEFwaEc0dmxUY0x4M3B3RXRXd0NaNTU5b0tiMVMzMnRCelF4cWx4QVBS?=
 =?utf-8?B?eXh4ajFxS3c1bDlMMXlWUkI3VlpVYTBBV0paTTJhL21lRHVPc1FFMGFkbXFi?=
 =?utf-8?B?WG1EazFoVWR2bG95Uit0dlpPMHc1ajluZGViaGpVZFMzOGpkTkhZMFllZzJw?=
 =?utf-8?B?SHdMR0I1Rko5dWdFYnBobkhzaklFMnBHeUgrYkpVNWlNSVdGcmRIenZscWVX?=
 =?utf-8?B?b3ZnSE1iclZwNW9VSmpLN3AvRVVWWVFOVUFDQzI5MFo0OFJ4WHR4V3BIZ1Z4?=
 =?utf-8?B?QzcyV3JRemVhYXFGRy9JTjVaVHgzbzNvKytNY0hsa2VtRnF6SHV3QXNXbWNm?=
 =?utf-8?B?OCs0ajlwamRNTlNJdkF5alBOREVEaFJXckRQMFg2Sk1tanUyakw0NnFRM1BR?=
 =?utf-8?B?cjhFMktaVlVkL2Q3ZjAwT1ZLcW9oV2JaUmlyZjVMRnpPMkVVL0N4TXBIa0NW?=
 =?utf-8?B?TlJxQUFOaWF4WmNrUTRLd1hMUXJiT0lLclhKRGQreGRXNDR5cmo5VVhlbzR3?=
 =?utf-8?B?YzFUdFpoRWZIS2ZmakE3R29Tb0hxMU9lNzF1UG00aUY0aDBWc0hEdHVnVGlL?=
 =?utf-8?B?eVYxS1BucHl1M2xzNloza1gzY1dOQ01lbGk3SEV6cTk3Vm9JeHphMGY0OVJW?=
 =?utf-8?B?TDBiVnhNMlp6V2c5YlhkemMwL1drNmI3ekZtRUJsRHk3TjF2aXlDVnZyVTd6?=
 =?utf-8?B?dGRSaVpQVTJYNjczVHhpVnNzUkNHMEdNQUxkdk5tZVBYUFJidm16TFk3dmoz?=
 =?utf-8?B?UDNmSjlZcjE2SFlnNzFYelJUVXhnWjQray9LeEU1elFOU1JXTzJjQkNwMnFV?=
 =?utf-8?B?d0kvUTkzeXRrREZNREdxc0VZd0dYOFl3ajBlQmNXR290Rmc0ZlJjRWMxQk1M?=
 =?utf-8?B?ZTkzQllxNm9NTWUwdW5kUGdSY2FPd3lkQmR2UzUvNkg2UTdyeGRMVVZNeXBO?=
 =?utf-8?B?c0lIRkZNM1BhS2NENWJmS0hiK1QzN3ZHZEdjaFNxUmdLVmNyRk8vZDNwWHFz?=
 =?utf-8?B?MjN1RzNJdjF0c1BsUUxmcVVNZFN4Y0J0ajNEczA1RWFlbmlldmFZWlJIS0Zk?=
 =?utf-8?B?c0dOSlhJUWdSTmtCQWdlVTZKdzg0QWlGSS9lTFdycjl3d2N3cjV6QzV6M2ZX?=
 =?utf-8?B?V3p0azlGZUhWLzBPV2s5OFlNQnVZMGRzV1dWTkg3N1pEbmVtL0hPRXdZMDRm?=
 =?utf-8?B?dFlnVnoyUDBnWmg4THdUU00xcWFqU1VhZENUOWh5b1c1Qit3UDY2cEliTC8z?=
 =?utf-8?B?SEdETVQ4Mmt0T3hJUkttRUp1ektBNTZ0eWUxL2p2T2J5TE9pcCtBc25BZ0l1?=
 =?utf-8?B?TlRWa2pjT2wrNm1rbmV5M1NiemxWNnNaMjA1UytMeHBrTUN0ZjI2OFNnSW0w?=
 =?utf-8?B?MmlhYUNnRzVMMDhQSFQ5QUhKVHkrSXUwRDNOUU1YMkh0UUQwNHp2TVRwLys1?=
 =?utf-8?B?TmliWG41bXc5bHlVR2tDWnFDMlltRmNJSlhBT2ZBVkp2SGVQdjhvd2lhbDNi?=
 =?utf-8?B?TG1neUhpVXpWQWxydDRHSXM2TTMrZm5Rakp6aGFueUJscGJxZzkwdzdzeTNE?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: beb2d81c-8df7-4a9d-8f57-08dd6be0ccd4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 21:05:41.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCncTLxSmP5j91yOVaxt5nTWE+xo9YM1/nc2FJscKlLF/R5uhrg36itoHL5XAxx7MaZs8N1rAkA8SCScNiiwL5rl0W7siEeAlVCLQou36fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com



On 3/25/2025 5:44 AM, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 09:13:16 -0700 Tony Nguyen wrote:
>> From: Milena Olech <milena.olech@intel.com>
>>
>> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
>> capabilities recognition. Initial PTP support includes PTP initialization
>> and registration of the clock.
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> Tested-by: Mina Almasry <almasrymina@google.com>
>> Signed-off-by: Milena Olech <milena.olech@intel.com>
>> Tested-by: Samuel Salin <Samuel.salin@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Would be great to see a review tag from Jake on these :(
> 

I saw these go by on IWL, and did give some comments. However, I didn't
have the time to do a proper review so I didn't tag them.

I'm happy to look these over and review them before the submission next
cycle :)

>> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
>> +int idpf_ptp_init(struct idpf_adapter *adapter);
>> +void idpf_ptp_release(struct idpf_adapter *adapter);
>> +#else /* CONFIG_PTP_1588_CLOCK */
>> +static inline int idpf_ptp_init(struct idpf_adapter *adapter)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
>> +#endif /* CONFIG_PTP_1588_CLOCK */
>> +#endif /* _IDPF_PTP_H */
> 
> You add an unusual number of ifdefs for CONFIG_PTP_1588_CLOCK.
> Is this really necessary? What breaks if 1588 is not enabled?
> 

This style of converting the init and release to no-op is fairly common
in Intel drivers. I don't know about other places, but I think the
init/release is good since it just makes us disable the PTP
functionality when not supported.

We should make sure to try and limit these checks to the idpf_ptp.h
header file in one place, and make everything transparently disable if
the kernel lacks the PTP support :)

