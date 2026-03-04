Return-Path: <netdev+bounces-263853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DRGeB9hNqGlbtAAAu9opvQ
	(envelope-from <netdev+bounces-263853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:20:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91B202824
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD0C7305BBD5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44A315D35;
	Wed,  4 Mar 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0Be7jip"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4127A133;
	Wed,  4 Mar 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637234; cv=fail; b=abkLopaUBmT4g63C97wc3QbysM1aJ+3FWgK8tmYBvdi2edHotooMj/LPxIKPTXBrTXuKELN+uFA+skAAC9Wt+WXk1JZh1Z3YINoIEibs2/NrwdFs81nDWgS3xx5fybJXtKXS1+74Jp0+vl/OJbc+xtqvgSMpU1dTL6A1OTtAQRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637234; c=relaxed/simple;
	bh=7Xli6SRLFPuO6eMGyMUNUeqMbdZKd9PcWvLBDPv9SYo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TO7ZrMKC5v2EQMkKVHNXsj+nXGqvk2y62T8u4+rN6HAQDEvmwiUWDBioFUtJsAkYNjiHk9dBjax1bkbqCEesmC30jGTX/IZ/VwiUp+Jje8pFEhiyQgpLBDwK4wuylCJhCaPzY5PqtVxAtGq5iekAagYh46LxV8+98z+JpsELtoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0Be7jip; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772637233; x=1804173233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Xli6SRLFPuO6eMGyMUNUeqMbdZKd9PcWvLBDPv9SYo=;
  b=V0Be7jipFhf3IoN/Yta/H+1D+zHU7e/YOfHWleU+XfRr7n4Nfz93DfeT
   1Tbw+UhFi4B/8yhKfUvmcIscpuCJCK46TX/eP+LjArW08F5LUaHIq9C6z
   /Kx7xLl/FNrcx3IKHC5i7+yR8vVWc7JJ0GACSex0pBs2Ak4lE86r4EVm0
   WWu+6ms+dZ+VZOesZ27e9YXpovCoaM44WXSJSnCgljb3WdnEy9+d1y6qH
   o/qQN4Ud/5Wjw2regbOkwqQyPyLr+jLMMhmZX5JfAuLW5dMIx9pgMo+RR
   HWBshyXmajsAqIeMYtbAIWH37C9O8l2RxRYu8wif2mJ/MMSdFLNeDWYrO
   g==;
X-CSE-ConnectionGUID: yFNGwrQbTCSVQ9qB77bVfA==
X-CSE-MsgGUID: Rei9GvIZTC+Zp3MxNw3TFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73748725"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73748725"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 07:13:53 -0800
X-CSE-ConnectionGUID: NS1kb28CRSeRWA5lIjPA7w==
X-CSE-MsgGUID: KTyBP5HzSsSMVh2zWDy2jg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 07:13:52 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 07:13:51 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 07:13:51 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 07:13:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TskD4j5GKuhmEBGaupyyQPiJAbmWS0LC1UDPwYwuQAtplUvc++fjDAuu4554Rx4HxBGxNVjtyP0INZG/dBMVglu6e6uslYCJlI6oayZFqZs52WHXfK+CaWgLKiFv6FyHi7/wWBiRZOCKx6QUMx3BFerg6h7coGEYbuzyBnkXYECcdQcE/Tibt9G0s88FmVwJglDHAFJDMt9Wh3yqzZsfA+w2dGkJ0+Q5mpa9CRp958B2/jNYzUOL0Fh2euLHWz+tJAW91rbLKbOs8Hij7ntPwhzUo3UzHiuu5IqsU/3fLVNKSZHhVQAJbs15963rEXUwf6G2gwU7q5/CjhSeeVuF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgIYDGNLyGRQTQu/63w8ilmuOh7Cjw2aqSUB5t3uj0U=;
 b=qgdDdYwQe3dx1ftUCj0t3UWuzW4xbijfwR7QfSiklaTDo9CHvpkSeSrmu7v+CBE/pbtpVvFs68ser6nwExC/ew7dd71BvzGG126BKM6zU6oEFbFU0zf0qFCNbpRuR5R8TeTQ7e/aSkAGhp+dkOKJh9YBoHaxyeZNO+TbC7d9hn3wH+OeiUBAKQ3FJX2cQsK6daiI1ighCQrMlmMmYyiYRqiUtlvzOEoCA5TThQh380kuPrTknR7nDBSpxqUxgyC5FpIeV90ZqadlgmUJeJco/3aqU1ASwrPyKAKKpEpRnPMtCjJnrUVRLwaP+aO1+ImFZE89Z5NiV+4t8QcBxIHDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:13:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:13:48 +0000
Message-ID: <8b43d234-867a-481f-90e6-e155132100a5@intel.com>
Date: Wed, 4 Mar 2026 16:11:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB
 enabled
To: Steve Rutherford <srutherford@google.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, "Anjali
 Singhai" <anjali.singhai@intel.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, Li Li
	<boolli@google.com>, <emil.s.tantilov@intel.com>
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com>
 <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b831a9-314f-47ea-ae47-08de7a00a2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: YvXde4hoVpNybmLa35uildeJldodY+omcS+zLGLMQL0CStzy0YnR1Uga6z9Fs/87yZ9HfyrJ0MVClt+2zpus/upFRS/8M+Y1m7PdD7iUWJZU48nPRqDYjzGb9v/RVWWsS++uGJ5BNY+HpYPeq7OZ+Zrqh+uLxubASnb2p9xr3xR8baw6tlb6W9+6F4G9HnGj10n1IdC3djWUaKLdY7uUQLhWYeb2xkqbVoJZzsEO72pg8Z60P72SL+RwBbV6vfdJL4jpvXH6DoO7R1o9Kb7LiBoIKSghvsOWoLwNERvKY/MMlxE99VqZao5PZhg0UksVII2tAOmQkZwrUL6RZBoIyWnmVwhCLVB41dpMhd+NnRyG77vZ7u9K3BdCx1RM+xb9lysAIwsLRyKMo56m6bRUsotboWI0wmslr/l4Iw3/FiPcc9Z8A/wTJTrL166GE0WGUshEADhZPTA5g5f6S5z9VvbBe3seE7VURuNfahcAfqFTfhf4GLAHUGR+HluDib/7GoigDLPQbn7dLP3S0UJJjrJViC/x3ZJwHnIfv+TWwrxdl76zUQugQmBTRYztnciadLTlOsmC/XViTiQBg51UljpFQs3Igc0JfeCzQ/C8JWkPaxqJGekzmIDuxceyDmaM6p0rC6twFFJT1s9l/IEWJm3vGSiW36af+4bCjzZZyp4OvqHXVeprEuflvDGcyuglVPCO8mmLOhPp7gdXwddyuzAD/nv3b2HVPdPaXbuRSQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNXWWtXc2tOanFualNjMk54KzIwN2F0enJ3cUc1cEQvTkJwampkd1RpSThB?=
 =?utf-8?B?VlhBdG55N01OZjc4RERVTmtKMUU0czhhWm9SQS9YUk5mbUxkRm9MTHFUVVFz?=
 =?utf-8?B?WDJBN1paYXdFYjJzU2FGZi93R3RkOWhDci9TeXVaQnhKOU5xR3pPQ3FydHl5?=
 =?utf-8?B?cmpjNWlJUUxZalEwNmhhVFIrN3ZKK0xpbVVnZ0prbnI1WlRXbDYxOW0yS2dB?=
 =?utf-8?B?L0RyVGhmV3BKMU0ydDBDM3NMRVpEU3dBaTJHNWNNaDdUVHc3YzhWQ3dwZ212?=
 =?utf-8?B?ZkFpZjl6VjRUUlRSQ3N4UTFvRlJvUjg1VXcrZEFoOHF2Zmhwb0tld1lVZFh4?=
 =?utf-8?B?dUEvVm4wYzIrZHBCeUhLWUM4NGE1OXlRelRKVk8wbXZ0T2pTWlIweEZNQU5C?=
 =?utf-8?B?bTl2VkRkOUVlWGZyOEdnenpUTTNEVVJWd0xvLyswMDRJZnhUQlFmeUZxNXBS?=
 =?utf-8?B?Y2VmWFdqeUt5R2hNN0lHK2hxUWZnOGo0eWpTUmxqSjhLdXJ5ajFJVlFFRkRv?=
 =?utf-8?B?ZFNqcHhYQkJRem9pSEZlUHE1Rk5mbFEwZFRJdnpaWHMyWlNFYUl6emxRTUt1?=
 =?utf-8?B?SDVJTFYreDBSNitPZm5USWRiZFl6OFFGMnkvbGdSaVZhY3ljaktkUGxUTllt?=
 =?utf-8?B?L3l1MHFvdnlvRFJFVGpITWhyL3MrOHdCSGdjMDNoREJMYVFEQ2pRVis4blY1?=
 =?utf-8?B?Rm5BWXVDRXFneFh4R0hMRUtvYnUvN0JMd1RVQTlnLzdubHN6M0FxZXhDbHpu?=
 =?utf-8?B?VkM2bFphRW95cms2UGtYK3duR0R2by9VTEVsNmFpeTVZRjJuWk5xUERJcW1h?=
 =?utf-8?B?dlhCVDdOZDYzNmNic1lOSVRRTVU2THFTckVnQUttWnVyV1lpSjN2Tm8xWWF2?=
 =?utf-8?B?aUF5UTFRYTRtMC9ySFRndlN6dG1UMWFEZ21YR0lubFAyYTFwNU5HWUhtaXVp?=
 =?utf-8?B?RmNkUGVuK1NZTU9Lc3UrOFBiWkIxbDdaZDJMY09xWjVDVlVib29FTHBVdkYx?=
 =?utf-8?B?Y3dFY29pcFVjZW5kVVlUMkhUYjcvUXVpamdxZEE0RVd4MGR3WVMvbXR2WVBV?=
 =?utf-8?B?dldIM3AwNDA1K2pKclFJUXhpaUMxaWhjY0czYlhQMEpmT1NvNW9JT2k5WmQ0?=
 =?utf-8?B?RzJ5WmRUNVArM3dHNzdISlFleldPL3pGRXRHWWhXSi8vVVZjN1JyVEt2aXA0?=
 =?utf-8?B?TmxFZ3RrUDJPb0ROUThqOWY5SlZaS1p6blRRV08xNFNod3Y2cVlCQnlJSWg0?=
 =?utf-8?B?dWVZL2p3c3diQ2xKUGhMZ05Ndkx4S29rV0FPN2pZZlRRRVpzVlV0Mis1bUZZ?=
 =?utf-8?B?SnhmM0RyckVZSzJwV2VaQnRkRzRLbllBa20zM1BEUzZJRGNRRzgwS2M2N2cw?=
 =?utf-8?B?M0dUUWFRem16WXVSSGV4aWo5NXlXQnFXTno3Vk1zODRhZERUWmphMEVLYkFj?=
 =?utf-8?B?b2t4YjlUbUdtNlRid29pSWVacHBSSEhvNlNMZktva1M1WWpVVmhGSjJ0TGh6?=
 =?utf-8?B?MzZwZzI3R3ZhR1AyaTA2QkdTb2N1SHRZc3dCbzhzcnVNUWkxK1k0bU4zTUdJ?=
 =?utf-8?B?Q1JuYUROK3cwQWg0ZWh2NnAwSUw2Nm9TOWZhenYwUDhlQzJNdWYvUzR6YzdP?=
 =?utf-8?B?QnhqeERuRkFDcWRRZmNUeDI2cjNHM2xwQ1Npc2xScU9IV1NpOHA0ZEp0QW1O?=
 =?utf-8?B?YndQZjIwK3JJUCtlc0NwRTZVbnMvL2NBQ3NEdmhMditkd1JKWWhjcGwzbzdp?=
 =?utf-8?B?UVhQUTVJNW00VzROUVNYQWhaQVg0aHpQN0R1QldERlNTRG9jTHI0dlJrVy8v?=
 =?utf-8?B?dnFtM1h3cVE1TXNPbkp4QmxITkhsQjEvWFlCQ0RzbUU2cXlPZU9lNEdHUUw2?=
 =?utf-8?B?SmhWdjFEa2NkbXp6N3pFZWNvRDRKUllQN0pGVHd2TFAvSS9iVzZCRk4xU2JH?=
 =?utf-8?B?UWRpVHQxRDYyVkROQXRDaW9mS1JOVXdvUzhpd0ZaV2dWQW1uTU9FVzUyRVZC?=
 =?utf-8?B?NnJDRzBBdklWNXd2RHdQVzgwZWpFRkxxMnpsTG1kVFY5a0t5bmdyNmhVb1cv?=
 =?utf-8?B?N3VzTzRaVzNmWEhjbmNmU3VTODdCazI4dkFVZmw3THdXT0FEdmpjbFh4VFlq?=
 =?utf-8?B?eHR3dlVRYWZ5K2M4bXFIWmVFL2Y1L0hVZGsxZEJKd2E4QkVsT1lvUlZtbURo?=
 =?utf-8?B?UW9NOHRFbk55Wit1d1ZYV0x4Uk1rc3JUaWhUcVMrdHBWa0NmSkR0TzJzQ0sy?=
 =?utf-8?B?SW9HYUM2SFhvUzZJQVhOUW9vUlNXbU81U2xHWDRscXFUR0dBQUJWa0lndmxP?=
 =?utf-8?B?WmhsYVhlNWZwRUdWU1hEMzU4blZBU1I0UFVaZ3RjQmNGKzMwQjc0cERhT2Rn?=
 =?utf-8?Q?4SmfgyiovhyXExcw=3D?=
X-Exchange-RoutingPolicyChecked: TsVhLoG4JHakEfm3ZdbqfZa1wto/M2sODcL+YTs3Ewr8qmO5gNY54kj8R9ZrrLxjXCHwaD2pVMzHGmzGJtSkpp+rR88isEWR36/rA8f+S3nD6PuXruknF9KIZqkOxUmJqRafpy8MmcbYVT+PAlmB90DnjAYzsolwy3zRHfz7bzpu6Ko0f+jEj+hEEbO6w9mSavY7vZzFKvJjdj6igut+dgPH6lcIfxPBFPwUtbSGpOaHPokmZ08gzPQBiz7Ae8O4tPi40U7mc4NW4W4ldbJxpO4qIV2DBuOEBOQ0WSUp/p5Ahl0e6lFmobzd09vNCIRXBxZyuGEp64mpZfUMpdf1AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b831a9-314f-47ea-ae47-08de7a00a2ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:13:48.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sy/Xv9B7fKdYxlFbWxb/F5ln50WxSsOPuFHJx13jB1yc0aGpNMvBIo64z3sGeF9PoV6K/gIQ56Ohs0tTyIBX7eXnn4nTLm6Ek1Sx5vJP9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9D91B202824
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Steve Rutherford <srutherford@google.com>
Date: Tue, 3 Mar 2026 11:44:19 -0800

> On Tue, Mar 3, 2026 at 7:34 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Steve Rutherford <srutherford@google.com>
>> Date: Fri, 27 Feb 2026 20:34:57 +0000
>>
>>> When SWIOTLB and header split are enabled, IDPF sees empty packets in the
>>> rx queue.
>>>
>>> This is caused by libeth_rx_sync_for_cpu clobbering the synthesized header
>>> in the workaround (i.e. overflow) path. After the header is synthesized by
>>> idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
>>> effectively zeroing out the buffer.
>>>
>>> This skips the extra sync in the workaround path in most cases. The one
>>> exception is that it calls sync to trigger a recycle the header buffer when
>>> it fails to find a header in the payload.
>>>
>>> Fixes: 90912f9f4f2d1 ("idpf: convert header split mode to libeth + napi_build_skb()")
>>> Signed-off-by: Steve Rutherford <srutherford@google.com>
>>> ---
>>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> index 3ddf7b1e85ef..946203a6bd86 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> @@ -3007,9 +3007,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>>>                       u64_stats_update_begin(&rxq->stats_sync);
>>>                       u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
>>>                       u64_stats_update_end(&rxq->stats_sync);
>>> -             }
>>>
>>> -             if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
>>> +                     /* Recycle the hdr buffer if unused.*/
>>> +                     if (!hdr_len)
>>> +                             libeth_rx_sync_for_cpu(hdr, 0);
>>> +             } else if (!libeth_rx_sync_for_cpu(hdr, hdr_len))
>>> +                     hdr_len = 0;
>>> +
>>> +             if (hdr_len) {
>>
>> This is for a very old tree I believe? We now have
>> libeth_xdp_process_buff() there for quite some time already.
> 
> It is, yeah. I thought I posted a cover letter with more of a description, but,
> frankly, I may have messed up the process of posting.
> 
> From the cover letter -
> Found an issue with the IDPF driver when SWIOTLB is enabled. The issue
> results in empty headers for packets that hit the split queue workaround
> path. It's caused by a spurious sync in that path. The header is synced
> from the SWIOTLB even when the header was shoved into the payload.
> 
> I cooked up a sample patch, but I'm not an expert in this driver, so I have
> no idea if it's the right solution. It did allow my QEMU VM to boot with a
> superficially functional passed-through IDPF NIC and SWIOTLB=force.
> 
> The patch was written against COS's 6.12, so I assume that it will not
> apply cleanly elsewhere, but I figured a wrong sample patch was better than
> a long paragraph describing the same thing. My read of more recent kernels
> is that this problem is still present, but could be mistaken.

Ooops, sorry, I haven't read the cover letter =\

Did I get it correctly that in case of SWIOTLB, we can't sync the same
buffer two times? But if the hsplit W/A was applied, then this double
sync corrupts the data?

I'll prepare a patch for the latest net (with you as Co-developed-by or
any other tag you prefer) once I find a way how to play this nicely with
libeth_xdp_process_buff(). It performs an unconditional sync and bails
out if it returned false.

> 
> Thanks,
> Steve

Thanks,
Olek

