Return-Path: <netdev+bounces-306329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMqgAaLgT2p8pgIAu9opvQ
	(envelope-from <netdev+bounces-306329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299837340B4
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:55:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=N63A90fT;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306329-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306329-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB9B3034651
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118E4DA53A;
	Thu,  9 Jul 2026 17:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95694195A1
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 17:52:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619534; cv=fail; b=OKwR5wkeeQartAo9t+m8+6c947w3TqM8iEM5R4V6NXbANQD44aZb3NxrsjZYty6D4MMy/irMYqL+kuUG4XImwnddm23yZyzRTigzLMJHBML8XLwAVQ3SD4QSzczWDSoEjA1mgUS3yhZyfTkrqRjJIS1OW6xeoy5fYlTnQFOhuGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619534; c=relaxed/simple;
	bh=LxonyaLMQoTjQa73Qbvo6sejF6128HXXOWP4Iy5bMoI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oOXYz8N2Zy3R9pfkWNhoFFYwkxSjeBESw1n0RUxl6FD332My+fFeuaI6khHAQ1tH60AhkZf1nUTX+CNAhD4tudoNKTKKaTZS8tVE4wyqBuwfyS8rtAuIaSnHkEdps6yEcuLHdvKk3n6k7Rda5SWZAcCVMo/upTy1yMY8elt81qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N63A90fT; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783619532; x=1815155532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LxonyaLMQoTjQa73Qbvo6sejF6128HXXOWP4Iy5bMoI=;
  b=N63A90fTwu/q6VRTzk24oLQk3bwgLrKz7eDbLmPeiCEXLk8py50YDWmB
   bgIbxOqF/NwXOXyfdExAGmTNkEp7+oNUWkA6sWMnXrLSQnLIqUZww9HOc
   LM29EyIl8RXve/8LlKzE3vT3hrIlC3UmHwB7Wocq4vCSkYxr2cvyz91cy
   9pxFKC3BdagBjXL4wv4GrpGTf9Ijd1SEfOyuXcMGLslXHj2xJ7pYmDXzC
   wCXDRNjPqSSp+o7+kDyr5ZtqCcywL6+k6jT1DsZfzqk3lu9fcw/B0TfxP
   TtMH3c3ZNUY1r8dr3Chy55MRmQaV8rEurugLlT5df2nfGYWT2nxW1mhWj
   g==;
X-CSE-ConnectionGUID: DH6NpNnpQ9yu8OUS2ezeQw==
X-CSE-MsgGUID: qciseygvRJGS8yYs7+EL/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88139010"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88139010"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:52:11 -0700
X-CSE-ConnectionGUID: SmrPrf80QrCvnqqbbJurAg==
X-CSE-MsgGUID: UNF54dU9Qkag8D6v7ECk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252919354"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:52:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:52:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 10:52:10 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFpjXsqb3NJElFvp2rEr06kfKB1gw4nX2gZLpaCqirmWkFA00UBT23ccyWuuBQi979O+oBGxqhFxiRhg7XdgVfuMnBDWaxGxWfyp4nYw8iHYBAfnX6HlTHZrZSMb8UDEzGUB2D2mrCAPePZTmB5noVoJhxQbtRFhxdz9x9WUiKcsAq20d56zUrTs4rYy+3deCuIf2GW6wrkCllpSCUbPGXWwUwXkjy0BZDqHogsG2FZwSHiPzrH8JNEy89Ul7AFCxFq2W4V0eRYEMyhuU2yEUn9Mg6us1kulD6m4/iUBNP3AbM06w3YHgq+vWeMJVpehkMHlRvbX9fbK21XXM3CoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEpDTGQoxcGwIlCSHu+y+OfRMAgyowscBJq8en7MXC0=;
 b=C4K1GL4PYk3whK7YmtNMFPGzWKScPwwD71JVwozqJkO163tt7etcetSVRz+lWBJiOA1a83l0vlVrNdCepFJ0JxrQ3KT1VNKWQ9lnwSF47vY4VKJ16D0VTfHck68VQgWCXi7x1RwIpEWIBaTSYLN9yX3CKL3lCaMs2mAdwQ0J//oKt7n+V3dfMIOTolUvMOeUOYhRtqOR22vPJhySDV+YQB+Q+deF9F/K5y82Cj24STK+e7/tdZvvHzDbEk8ZPLUSB7u1OKhGuz2dVV4tQRWLtP3qOaiW8DaVA8KEU3obS8HeGlrF8b3SKamSbQ9wJdEQ/mW8xs5hMfV2h/vP2D++OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 17:52:07 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 17:52:06 +0000
Message-ID: <70999e07-114e-47af-a8b1-912a30eccb8a@intel.com>
Date: Thu, 9 Jul 2026 10:52:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/11] igb: prepare for RSS key get/set support
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Takashi Kozu <takkozu@amazon.com>, <horms@kernel.org>, <enjuk@amazon.com>,
	<kohei.enju@gmail.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Rinitha S
	<sx.rinitha@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
 <20260701210303.1745310-5-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260701210303.1745310-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MW4PR11MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: a628cbd4-e179-4782-7da3-08dedde2ca53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|6133799003|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: y4Fdzo3lFQRsouLPuXtqCzq3J2t5biz7dJPRB97i+ZQi3MwFvtNIU7QmBLZ6Ba9kWOJmbxAyb4t31gRkvC0eqGtW9maFAMqgbA2PORksttfUfRAWc0sHuQPnqkbMStDixrHFdaHiuDriFqVQGXI2eOAjtfuaYEAy+BmYvcfVY2sBL4c4/AR+ZQXi4vC61bcoBy1PjYNoqmwKkn4Z02orhWwdjAyS6kr+xTC7JLMQL13ftlSmH8OB5Uf13SxN1exVUrNsUP8u3OWi5ZWbZ4U52LEYl44pLizwUgWil5U3sSbUKVY/lTY2tPVNPuEWoI0Osnjb9Z92Og1OAUcbXZs2EggpLTCZXkYlSwrPvEcmAytDZo4544ZcFgi/RDAcvv5gJYYZL1aVQV5Ie5plF20Yb5YsRzbWsPakbz4cyxny9SvRHZoBXDmMPt3RqmBgLNiDKECU4bA1Q6iZIw3bETRgDaBA0vexyriJAskeo93iyYZH4np1oEDqpKTfG1Jd77bP6PcuSXh3ZDhCzDRTPTxnGeiW/U7XBHdklTJWFAZGWVnQy++ZYxG654jp0DmlxQJ3u9YBixJ7TBWcEXqG96tX9nIpem+3DUGvY8Syzyn9sUAjQiWf2utGOfvZZFjDwnQUd6jtbWQLzHIznSe3aAdEsyf2edCJlj4RYUhfp7BK7Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFxN2Z0VTl5ZkVzMld3TFlYVERNNlNJVWdlMWdMa0pNZ3E3SEZpeS9jZ1U3?=
 =?utf-8?B?NjRwYUdIdW9DZ29yTjZpVDBGUkZJT3lxSWxsWEpXem9zRStmNzRRQ0FFenpJ?=
 =?utf-8?B?TUVoQ0FVQVZtOS9PNisrTHowcjJ5VlFkTkhHQ0s5d1RSL0JyeTNxRHQ5SlFL?=
 =?utf-8?B?b1hLbC9ZWnFlS2t5Q1pEZlNvRjZza0JBOUFtUy9MR05paGNxRUtxTDBwUFFK?=
 =?utf-8?B?bmpOQjhlL0tTMGJHSkJjSkNCQXhhTnpIcXpzaEFkcUgwNS94czBKd3ZKNW5C?=
 =?utf-8?B?SDVVYlo4L1dCSnpEVUJueDJ6dzNOaC9XNzJpWWtqUUN5dGlDVjBNb3FOdTVn?=
 =?utf-8?B?K3FVUmRpaXNIMGluay82d0FmY2MwZjl1b1ZkR21zZUdlQ0ViQ3M1aE1FeUR5?=
 =?utf-8?B?MWVVSzhJNmFMQU81UG5LSzdOc2huUkhBL1ZHbDlBWWJ6TzJpSG54dmYvRFFh?=
 =?utf-8?B?bVNpWk1sUTYzbzd2MmlmcmxUdGNPWlVIOEIyMHNuRXJQOHFyemZSOE0vQkI1?=
 =?utf-8?B?dTdEZVBJb1RjN3lkeFk5WVVPaW9QZGpQRXV2ejQ4MHlLcXBuNUkza1E1a0Fs?=
 =?utf-8?B?WHVUb04wRXd2Sm5UWGkvMndBYi8rYzlHVDJ3M0YrY0lzWGlTNkFORG05c1Vx?=
 =?utf-8?B?WS91YjhNZUZETVdyMnNVdXpMcVJqRFpPWXlsUnFKV0dRWVJLYWZVWkxUTEtq?=
 =?utf-8?B?by9lVFJzazU4WE1TTUltZXYyL29BR3k2cElRR1ZTNjgxZlRoNEx5SWt5N1kv?=
 =?utf-8?B?WTg1eHBLeGNmTUNzYkE0TEhVRXJ6b1lZK1pmRXR2SE04VDBTRWgwcEV2d0Qy?=
 =?utf-8?B?MHkwZTB1RU4xYTAyVDIwWUFGL29kWURUYUVFTE5YaDJLbTd2M2NuUU1sTm5n?=
 =?utf-8?B?ZXQyZ1VzVVF1VkdRWk02RFZZRHpoeXZpK2FIU0JxZWlRMWlVamprWUdHSGdB?=
 =?utf-8?B?VXZDc0tCVDVxSXFZWGYwcXBkejhmRGZac2trWGpoUHBJT0k0T3RtYk9rNjRZ?=
 =?utf-8?B?dXFyZzl2aDJsRTJvdnFtODJoMWpRRVlZc1NJWW81YUlLVnhqWUNNZW9ybWpM?=
 =?utf-8?B?V2RxOVBoeGYrY2ZrZkNOYytwWjhIK1hJRUpTQS9kNEFlc01EZVdWZjJGSkow?=
 =?utf-8?B?Z0pJQTQ2cDZmbzlrNXdqZlVJYXdPL0RYT1YxdVRRTG1haVlUaGVzdjkxbS9Q?=
 =?utf-8?B?SExRTFBHb2VEWnJiOUI5TTRiVDIxY3h6dTlaN0c5QytzZjF1YXhMY0hrcWJK?=
 =?utf-8?B?clh1b01PRFR4b1lDSEtFLzUxS280TUxzQlcxWEE4WXVsbmFId2V6YXVNaHdr?=
 =?utf-8?B?M21uVnJTOG5HYm95U1UzQXFaVzZFUDJYd3I5dG1SS1pqbyt2QWJZbzFJR2FS?=
 =?utf-8?B?S2NheW42dG5HVks0VE5pc0RqQ2RoM0h4V1lZem1RUjVFOGduRjZoRVVOck9I?=
 =?utf-8?B?VTVUU0FWMVFlNzBoZUZlejNSbC9kODhjWUxNSjkvaFpnTXJ3Q1piNmU4eGNa?=
 =?utf-8?B?Ym12dS9jVi9ubSszM2RCZlhnVXVWR1pWR092NUNxK0JyNkxpL3hhZlNlcEh3?=
 =?utf-8?B?Wi8yT3kwME9LYVY5U1BnL0ZBQUplRXQyK2QwMWF4dGlwcnh4L3pqNkE5RTB1?=
 =?utf-8?B?VmNsc050bTN1d0xFTVZaT3NFWU9OTHBaeVNmT0xsei9xdkIyMldHOFdKbmxr?=
 =?utf-8?B?ZnAzU1NIbldvaVpTcjE0QmlMNjVlV1RsMmhaOGIwVWxpb0NiazVkQy91dVgy?=
 =?utf-8?B?Qnc4OHpKODcvbGxaKzhBVHFJU3QveGRhSWMzTEQ3RXNCTGhCQU1CUTdzWmU5?=
 =?utf-8?B?V1VKVlVSTjJCK3I1TEZBOXhvcVQ4Q2pac1hyellxdUsySzUyY3JLQ29iOW1Z?=
 =?utf-8?B?aG1GdDNnQ3kwWDBTTGhUYWkzQ080N2FBOFBFTVJJcU5sWCt5ZlRoYzZialZZ?=
 =?utf-8?B?WUJVVi9CU0t4K2R6VjBPejVZc1NwU25EUTI1UHJLTkVmRTZ4c3dJT0hmWFZa?=
 =?utf-8?B?NWhTOFNlVWoxQUhUZGhreUFCK3J0REhyZnFFUTZRZENuNXJwVFVnaUFjeXpp?=
 =?utf-8?B?bVRIYTg2cys2ajhkTmdza3dPeWZkeXJEMFdRN1J5NVFYMTBsVkVCQ1N0TkRV?=
 =?utf-8?B?Wk9HaHpyd21IQVAyZ2ExNURaSDZNTEV0MXpaRmVJZnVkZm9iWEJ3VHRHbDFn?=
 =?utf-8?B?Vk9WeWVGY0JtSlk3aU9HVHI5RXRGYnhaS1lWS3E5NkpReEJzTlp3Qzd5bFVh?=
 =?utf-8?B?TkU3dW1sV21FUXlyU0wybFN3OWN4K0orM3RndDJhRjVlVklHeG9OUEVkT0o4?=
 =?utf-8?B?bjl4bnJRUE9ZZ0w0V1NmMG05WUgxVXdGc1duVXpLS0ovTlR0dHA2MkhkUVdX?=
 =?utf-8?Q?G1UeAco5qIIvD44w=3D?=
X-Exchange-RoutingPolicyChecked: iE824kCBUflubXH07jVpa+oGgEcH54G97OZo+pscf2B6dEL4wt8RHMZqjhYWTcuml3c9FEVXsKc8ew9ycgK8jKQymbMMibjfs963LWI3L+YlqCEAB1TUI1i1ZoQ4Xm0FBOYtBl98PN+FCyri3Zme5PPIzijp05X3jV0qVcRkaMlyhVnJmBOMVdPUTLP42aUCd2ze+Mpm9Ep0LiFWgfRQMMIIGhkb8olmOe9woiPxp/jDl2WTUctPeslNRZBi0Vrw+bKEF0C5QCSt8PhycOI1s+HvpNM3UNR4FZGsEGHsfgeORdT7mo5ogeoCx54H4ZcF1JLh1qqLMXOgk84QXZtHgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a628cbd4-e179-4782-7da3-08dedde2ca53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:52:06.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTjwBmXUzxKwtDiGIExXVRsqRfPBaaZ0wlEJI8/yF+4AqGGFZWs904QK2XZRaDrzPk6xCOMnE0NL/kKHtE6D5Mbad37py08+MeJk6qeLb4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306329-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:takkozu@amazon.com,m:horms@kernel.org,m:enjuk@amazon.com,m:kohei.enju@gmail.com,m:piotr.kwapulinski@intel.com,m:aleksandr.loktionov@intel.com,m:sx.rinitha@intel.com,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,kernel.org,gmail.com,intel.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 299837340B4

On 7/1/2026 2:02 PM, Tony Nguyen wrote:
> From: Takashi Kozu <takkozu@amazon.com>
...

> +/**
> + * igb_write_rss_key - Program the RSS key into device registers
> + * @adapter: board private structure
> + *
> + * Write the RSS key stored in adapter->rss_key to the E1000 hardware registers.
> + * Each 32-bit chunk of the key is read using get_unaligned_le32() and written
> + * to the appropriate register.
> + */
> +void igb_write_rss_key(struct igb_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	ASSERT_RTNL();

Hi Takashi-san,

Sashiko flags this for the power management path.

"
Will the new ASSERT_RTNL() in igb_write_rss_key() trigger a false-positive
kernel warning during runtime power management resume?
When the device undergoes runtime PM suspend and then wakes up,
igb_runtime_resume() is called. This passes rpm=true to __igb_resume(), 
which
explicitly skips acquiring the rtnl_lock() to avoid deadlocks.
__igb_resume() then calls __igb_open(), which cascades to igb_configure(),
igb_setup_mrqc(), and finally igb_write_rss_key(). Because the lock is
intentionally not held on this path, the ASSERT_RTNL() will fail and 
trigger a
WARN_ONCE.
Is it possible to remove this assertion or adjust it to account for the
runtime PM resume path?
"

Kohei-san's version in igc did not have this and it does share similar 
flows with igc. I'm not sure if you added this for a specific reason but 
would you be able to send a follow up patch to adjust or remove this?

Thanks,
Tony

> +
> +	for (int i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
> +		u32 val = get_unaligned_le32(&adapter->rss_key[i * 4]);
> +
> +		wr32(E1000_RSSRK(i), val);
> +	}
> +}
> +


