Return-Path: <netdev+bounces-132281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DF5991278
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78274282F91
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9D1B4F19;
	Fri,  4 Oct 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks3a6fKR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8611474B9
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081825; cv=fail; b=ZZZ9wYPrG1yrEisewZI9aj0zMhjcVELv34vsOvGCNxO0ePDPMaMm30vlyeRsK/OoiWeAd+XYlLGm1GLA9AnnKOCWNBmELvEX1k132mrjAKqT2Ca688p/0aekzVaeER0a0r+jA2dGrmN6zjjpIvuxMDGEfz6pBqFx4ra/kxL0SJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081825; c=relaxed/simple;
	bh=4lIrcHLUxoKZvRzoBVsKsP/z+LpDs24de2kS+2rTLUM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGGqLx30UnQg240OuISSHANZzSTC43khjBnbPI1F736ddDmClnAAw9EXrT89rPAj4HAHpF38Mgz2DY0z1q60/r08GHCyNgKMTIspcVfgxDX0ZnRRUnmJPaNWMSYqzGjUEpzgzQAK1KZsP9Yif0b6c2z6OqHfrVbqZeXpBDhPVc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks3a6fKR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728081824; x=1759617824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4lIrcHLUxoKZvRzoBVsKsP/z+LpDs24de2kS+2rTLUM=;
  b=ks3a6fKRSRJ2p5CMdItmgyaPh1dxT20cE+vzyN1ud8QkxHEAVL9gOnzJ
   lWMY/oRG5t0ttwvvZxvQ9gXxYqpIGZyNfQmmoZ96gZysUoQvwAIl0Kuxd
   /W7J+WkFIYjVHkbjeQAkdS0HKNQua9kIUnaB/nNgBjt5PyjcouNsA+AXn
   Qofa3o+fw4AG5xi7bhFx9069SmpmWIlcboE8gtCMVoqEUMD2IOQulzeRc
   yXc88JB52AxKVx95bbDOKCosx8yoC3MEu28SaouIIRdEQyxuuYppxJtsJ
   fc6EabUURJaNaUjRiIKEc1pJ47E9yxu9MMkuusd+BYunmPrYPGk5w061I
   A==;
X-CSE-ConnectionGUID: eE4yQ0YiR4OPwYR21VC2pg==
X-CSE-MsgGUID: YIG2dN3xRk+FWNJI+3kigg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27126897"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27126897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:43:43 -0700
X-CSE-ConnectionGUID: OuWSC3BUROO85VwWpha9sg==
X-CSE-MsgGUID: LQNDCx52TzyRBs6VqI/jUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="79413001"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:43:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:43:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:43:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rO/92cFQ8qCcF+CjHBGYQ7Z10Jrfq0Ipz8C160nfGY6DDnXWHAt8zmmgHZu3UGxmnUtsqZf38j2kHTYGaNLlpLZEuqn84worS6Z88EkvEuN1dhPTum0Mk+gazdlfzIWvxp0vXegTwMaQF/lrjgsmur+Y4iTT5vKlf7PMqJbfHcaF87RVZJQJUQ1IUqwttF5baG9P6ciFmTu9NNfP6/rxyn3wwSnCNXpY4u+KZUAQqySnYwA8wJzsdvnqHL8bPVoGsGuF8twRx8QonGYiQMpDxYEORLFkgcSzhR3dqMcb1GjRTjNo7j/ojMcGXwJiOpqA/qRq3MxBFoNZr93tyRRIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a2A/QKewnk9Q+0ugYGPKhRjkQj2kfXVqJiwdRyL3sI=;
 b=eH4UHQ4UtrMQylqyB/K0r1NRvOEuLF7yZ826+Cfz4cCmfLew/ol7FYXDrurjJUH5UsAzkzMu9L0SDY/0glX7fF2f20F+7dDb5MCjS71FB+C0f+t4f8jicnBgyQXPZFDrKkiJCHjsNXUxl5JXL430v7G1X6vN3I1ERLJK4DHC1lN7Iy6dd2qwM2L4x9F+0KGZ7INkh2azJbd0cg6spsGrsYRYYGDb2QGDrBAKPdrV6XfzNaXV8cnrWBjwn5yAHkxWLcZIa5B7nG9eDzWaM8w4wZXHZMCG7PAOvOv5K1G3F6ankMvOHTj/hb9kb2omjzWf25tSXoa57LRKkbvEcoeLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:43:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:43:34 +0000
Message-ID: <e1f3aed7-8012-49e3-8250-dc1454294a9c@intel.com>
Date: Fri, 4 Oct 2024 15:43:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] gve: adopt page pool for DQ RDA mode
To: Praveen Kaligineedi <pkaligineedi@google.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <jeroendb@google.com>,
	<shailend@google.com>, <hramamurthy@google.com>, <ziweixiao@google.com>,
	<shannon.nelson@amd.com>
References: <20241003163042.194168-1-pkaligineedi@google.com>
 <20241003163042.194168-3-pkaligineedi@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241003163042.194168-3-pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: a4de5dc9-5ada-45c6-d014-08dce4c5fa56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlVIVW1zajNUeXR3cDBsMTN3MUxlRWlHc1FDd2Z3WEoxTGh3YzM3RHNKWDE2?=
 =?utf-8?B?TXpveFNPMTVod3pQelQwUjBaUEc1LzlHc05GMDB3ZklyTUxkaksxOUhMdFcx?=
 =?utf-8?B?aHpMOXluWlVESi85K0RlaWFCYVJVNkl4Y0Evak9RQTE1dnRheXM2QTY5V1FR?=
 =?utf-8?B?STVaMlp3R2Era3dFRVlRVUFDZmxUUm13Vkk5RHQrbFhGUXpaVnByUy95RUVS?=
 =?utf-8?B?K0hWTWZ5eENVcEsxaUFjQ2VOamg5Q1psdm83amhLdVozdjNPdzFSSTJhMG9o?=
 =?utf-8?B?U251a2YvQnNPb1UwU3ljWnVBWG5vd1JMNExmbHNHdVIrRWlKdHNmY3QzQlJS?=
 =?utf-8?B?OVFyMnZhaXVDQlBRUjE0MzE3YVV2WHYyNm9qejRKRUJESW9pMGhNNXlBbkYx?=
 =?utf-8?B?bFlxNW9ZcHpnRm5GWkVpTlFMaTVWcXl6WWZpOTZIaWJCY2hLL1JoNEhaeWd3?=
 =?utf-8?B?QXVrdEhMbWZQUjFiOVRLOWxoUVVjb05xOHlPTTQzZy9hM1dyQzNRWEdCdEF0?=
 =?utf-8?B?UFZpZ0x4cW04VTA0VVdOVUR0ejlRSm9wU3oydHREYVdCNE9LYkYxRXU0ZkhM?=
 =?utf-8?B?OTd3Y014NDdGaXRGaUVwblg1N25MeHZsNnhucG5JQlV2SjZWS2ZkVlV6ejVt?=
 =?utf-8?B?Z0g0ajl6MVVhc2t5TEpoa09wVXhlRzc0SUwxM0dxRHNTVTVSSENKWGVDTTk1?=
 =?utf-8?B?V1NuZEYrTlhHaXZNc01ScldkZ3JEQ3BoV3graVhHeWFVa0ZjNUgwOXFSUGgw?=
 =?utf-8?B?aEpLUC9mSEZvaUJMWjJOTTd1ajRTSmNqNTFTVHQ4SkRTUU54K0tzaVBvMmFn?=
 =?utf-8?B?d256ZVZmTTVTWFFqc3BMRTNmTTNWZ2VoSnpvSVVtOGNFaFY5aXVrVzFEMXp0?=
 =?utf-8?B?dzNVQkN6NzA4UlQrblNvM0EremcxbHpubDNLV0NQeElka2pXMjB0SHFybHhB?=
 =?utf-8?B?WDl1UTBWc013cnVWTFpXd3pHWjU1Y29XNitrdyt0aUdNbEt6WnFqR0V0NHhw?=
 =?utf-8?B?K3lNWjM3V3N2dU1Qak5oUWMvQjFockxoZnR5U3hlVWNtOHhON1psTndvMWNR?=
 =?utf-8?B?ZjIwby9lVGFmTDQzQlNhdEtwZlpzVUdmZFB1aE9hci9LUXF4a1ZMd3J3ZTdm?=
 =?utf-8?B?U2VnUHpBdHVmUlowOVc3dlMxd2dmUFR4VTJpbWtQeHFoUUlLTEE1cEYvRkNq?=
 =?utf-8?B?L1Q4STZDQkQ5MkdIbkpzdVdBL1JiMEhPdWtORExCL3ZCYlRtSDREYzRjWWty?=
 =?utf-8?B?MkU1U000Yzc3Y0hZN0UwTk5DOEVpZ003Tk5yZ3ZkeTRlVzE4VzNrKzRMV3o2?=
 =?utf-8?B?b3VXMzJtRmYzODVHYThUL25yS2NlZ1JRSFhubHJ0Y01RR3Y1eEY3dzI3YjVu?=
 =?utf-8?B?MmhtbW14eTRvMjFzb3hUazU4U2tueURmOWdtSDQ5TEc4bHg0UGlZODlsbEZs?=
 =?utf-8?B?L0lsWnAzN3hNRkN3NmFuNmF4Tk1QYUc3SytPMHJGY21LbDVTVnlCRUZWVmRi?=
 =?utf-8?B?K3JzblZTemhlemNyZkdWMnBsN3RzSG9RZVpKY2duMDJwZGFHT2pxdDlvcmFs?=
 =?utf-8?B?cmx0Mko0QzZHaVFCRXlmM3BzaXFSK1J5YjhBcVlCVTBSWFpBSTd3dEVLU2Rr?=
 =?utf-8?B?dHRGWXFqaDgyYmZZU3JyeG1Xd0loaGFsMmhUd21iNG02TXczUVZqSCtSell1?=
 =?utf-8?B?cHcwa2YwR0RyYW5QaGRodEhDM3VEaFhvaURHTjEwUGY4Wmx5UzY1RE5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVQT3RoaGN5NVhTYUt2OW1zdTdOalFGVWQwS1VnNWVUbzEwMVphMzlBdEtB?=
 =?utf-8?B?T09ZMElhNVA3V2dnRDNNbzQ0Y1FtNUpoUm0vb0J6VlNVQkYxcFNObzIxYWhI?=
 =?utf-8?B?WVNJcWU3S1VIQ0pmRkZiaHVBQ3dyS2NDbHlnZzBUM2JxWUtvSlJTbUhQNnEr?=
 =?utf-8?B?RGIyTnhaNDRrMUFuWklScXlFck95dnVXWHRwUnVySHFrQzVBS1ZINnp5aVg2?=
 =?utf-8?B?R1pnK3VmRE1rdjJiaGE2RkorWDhiMTBjRmhJOUJnS2tXKzcxWXoxSW1zOTRI?=
 =?utf-8?B?Qy95cDRjZmZMSDhUNzFnb3U1ay9OS3ZDYXlBb3pSV1BWZnZjVFBZa0xaVGhZ?=
 =?utf-8?B?QS9jK2RhQlA2M05IM3hRdXlwUkcvWjc0QWJRRTFQR1lQK3ArRlVRbnIxWHJ4?=
 =?utf-8?B?eSswaW9YMUM1cVBVK2VaMFR4NEVOQWJhL1A3dkpuUTQ5d1BOZVl0M0gvL3hB?=
 =?utf-8?B?U0J4aENMZ2FKSTFoTHdjR0hCN2liYzZIVWE1Y0hoNjgwRndzbUpBUXhRWnNE?=
 =?utf-8?B?Nm1XTm5vVzd4L3JsZ2MzdUxZRHVGeEwyYm5qRmx5dHV3Zlh2b3ZpbU1FRGdh?=
 =?utf-8?B?Sm9WeXU4WFo3QkYwK3VVc0dLWlJ6ZU5lKzFXdWkxNFNyTDY0TVp5K0FSMWlP?=
 =?utf-8?B?Zi9ZUVJKZ1VSSWNZRWY1aXZWd2R0R28wOUpVUUcxMk1YK2htNnZmMlhwR0NZ?=
 =?utf-8?B?TEZhRHVWQWZiZTkycW5tR3N5UHlxTHNlZ003UlhKeGZRSjJoakt0bFc4dUFZ?=
 =?utf-8?B?c0p3UGY3WHdreFRaNmxsSWFLU01MUXg2dnV2QWh5QjE4RUJXLzZMNUs4TDNh?=
 =?utf-8?B?MWxvMDZZL0tTSDY3dnpEa1VVUXJhQkk5Y2puQTNHazBOYzhYRjFGV3B6WTBi?=
 =?utf-8?B?eWVMb1JBZUtsRUY4WHh3b1kzbTJKUnZyRHZXVFVEaVREdXdaakxDMlY4b2cr?=
 =?utf-8?B?cFBaMklIWHBLcmxJRi9WN0tsNDZ3WFZQb1NvY2JIU0ZuYWUyVmt5by9nNHk5?=
 =?utf-8?B?aElzWUdsOWl0eWhNK0hJRGdqTUlZQkpEdFZPK1BaL1pBalgzR09KK0lRMkpZ?=
 =?utf-8?B?azhZYW1FSVpCdGRNWStabjJsdVJ5dmxKVVNJWkloTDFsc0tzTlh3Q3hldE8x?=
 =?utf-8?B?U1ZTUVBsVVZNN2hRUFBUb3ZQaXY2TElhQmQ2anJSNDY1NjNxVDI3d0xkZitI?=
 =?utf-8?B?R2lHaUV4R1Evb1prU3MvWDQrd29tZVNidlpoUUM2K3psdDl0bU5TU3ZiZjcr?=
 =?utf-8?B?Rnp5bFNrLytBNS9DTnhlaGpMQ3ZhL2wwRTFwYVd6RUU4aHBtTDh3aEYvUUxr?=
 =?utf-8?B?eWpCTkc1ZzlwNmpkd3dpclYyV04vWlRrV0xxUzJqVHU2VGxPdVdaRzNDL3NY?=
 =?utf-8?B?ejcwQ3RiaHdQSlZsWlBVVnM2SldOOHlZV1JKNXFpMG9LSDFaYlUxd0kyMEpV?=
 =?utf-8?B?SFFjUlJjaXR6VUN3MzdMaSt0V3lnT0R3WVBKL0FhaVVQU1pGM3hubVEyMjRj?=
 =?utf-8?B?VHI1S2llNmFodHNBcnlrc3ZGL0ViR0xxZE5BWG94Z0NUV2JVS3pwdW9HNEVx?=
 =?utf-8?B?L2huSDRvZ29pSENqS0pNdVc2c1Y0OUhhbzZLOThkRTJxZjZhUzFlQWdQeUg2?=
 =?utf-8?B?UHdqeGcyeDliNDJwR2pVckc1NFNJOThJYmx4R3Z0UVJqNm9VdmxaMi9hWHQ1?=
 =?utf-8?B?U3Nvd1FEK285NDBVSTltd0JrZHZRY056QzBPVzRkKzU5K2dIdk9QQUtjNk1Q?=
 =?utf-8?B?UkNWZUZHNm1Hd25NeDV3R2g2U294bm1zUzJPZm90U3VDRXFDaTdCemdMRnlo?=
 =?utf-8?B?bEVyVkRVSTdFSmFQLzlva1JSR3QzL3dQaVRvb28xbUNobHdUU1J4Rmd1UUI4?=
 =?utf-8?B?NksvVlZSMnFNSmZpVjV4cXk2bHBXSTFta2RLYWVBaVFad2Y0QUkwNU9XUVk3?=
 =?utf-8?B?cGxLNzFRaGJNTkZ4bDdlRkZtd2RINDVIb1Q0bVkyakF4RklqellGRjBSbnJj?=
 =?utf-8?B?Y2xHcXNpNmc1V1ZXYU8xQkJaZjUyUTVMd3BQTlUvNGdPN2RGQW1qdWgzcGlY?=
 =?utf-8?B?Uk9Gd29FV2g0UlBicHREQ3U3VVhvZTVvczNGTFI4NTVQNEJpcUpJMnU0L2dr?=
 =?utf-8?Q?J9p2SkqWlAvvxRyxcxZrae+vx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de5dc9-5ada-45c6-d014-08dce4c5fa56
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:43:34.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5iPVAufASSNbeUGUTRLttyNbHlGkUtW7xHxZyw4UojFHdc3eQd+PWlYFs7dbCCUf1/Aykywzl86JCO1cKlSGD15SOFe8yXDfAFY1HJXnzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
X-OriginatorOrg: intel.com



On 10/3/2024 9:30 AM, Praveen Kaligineedi wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> For DQ queue format in raw DMA addressing(RDA) mode,
> implement page pool recycling of buffers by leveraging
> a few helper functions. Also add a stat per ring to track
> page pool allocation failures.
> 
> DQ QPL mode will continue to use the exisiting recycling
> logic. This is because in QPL mode, the pages come from a
> constant set of pages that the driver pre-allocates and
> registers with the device.
> 
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

