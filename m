Return-Path: <netdev+bounces-164609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03275A2E79F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482103A671C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037CC1B6D15;
	Mon, 10 Feb 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKwXTKm7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2E14A639
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179556; cv=fail; b=tU06hM6kiYtWr5KGgVQVcCRzz6vMQRYvbcWbBcX8GH8Uz+7rWlVmazGf/xeBj+PoBMTXuvItKc249iKM96TkxWUIq+ZLR7oKAdhrNBPJ3XhRQNaZivp8UzrOTROa3asXbNEFNAOnN/VzhfcpOYnO6ZHnUC1FLMdYsaUGtV9Jymo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179556; c=relaxed/simple;
	bh=uXFIQE5NegSR0LdHJmvWBuqGgdj3kbQb8TJqZ5+4x3E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oe07vcvrekov/co8Fm7eZ/DTTbS2ghTk0IVayRwaZb7/nUD84vBw8Cn0N+airNPhBdg+abF8fEHaCbVI/aVp5yDxmTOubNS6O9Z6EFCrYuYOZGYogO7yJ68Hu437xBvJGctB1OSGcOABGutEo5nOE+GRte13rF39A9yUmp3a4s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKwXTKm7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739179556; x=1770715556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uXFIQE5NegSR0LdHJmvWBuqGgdj3kbQb8TJqZ5+4x3E=;
  b=nKwXTKm7KVFQjQxQ9q767PsnsjWDvvSxBIkjLI//vabae4EyVOCR2dTP
   xDHooDopgtlAscEj/Krm3hFJetJeFInUgLBE+kspBZqBPq1D7BuWs3Ikh
   a+O4eNF8uHms/6VQzBuTKxnUvIz1Kgulq82bpepF8lK0VJE9ZIhXWcTls
   CcB5FnvvcGCiU4bUZ+8gl0iyRJcMJ0ayT30P/RO4yEX+5cHb1sxv57hGM
   ogUmbYHXG3OZs3gbrqtc6/GRWiOGNeQ1RtDbWPwhu8ShG/cren9Zhm5Sl
   Bvl+S8OKhGedyhF/UXqaihAcHOot7hgG02YUcQQf68GYnfQI2UqfhjJL3
   A==;
X-CSE-ConnectionGUID: lA8PAY3kT2GO4pdV9itoNw==
X-CSE-MsgGUID: KcNfjkdbRLyFIyBrEAzQzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="57166401"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57166401"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:25:55 -0800
X-CSE-ConnectionGUID: fZKc+ZpcTw+6hRwsxgLwkg==
X-CSE-MsgGUID: Ljyc2PxnTqSmQAz9xvg3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="117199579"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 01:25:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 01:25:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 01:25:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 01:25:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trQwYW9/m/vZOY+lqz3v+75VaB491QIi6+bmE8voFAuzcHBi2YxJ2F0UqCftzi+Ty2xfmuvGisIzwZ3cCKAsDiSLAJ+BEilvvFL/YlM7JfDCLY3xg0ciRxixwr5phNev4WvmE/wW/3nABWv0BvzQFkk1mPz7KFDAU2MzUiv8lh6/eRA03rtnqxIhPSwdE65Z/t4J430hNf+0cNO85lbMoSvmxQSOG1TSn2t+oQ7ULb8nZQlzehQsCSttrp46t7PgQns69xPIH2o95fBy6MM0cKkIZVku4Lf/uU0Am6fIbr5Z76N/QOVAvHDrFdCh4FqCfQunMa0Ax4p2OUyUMnvTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCF5etBIq4bmmejXEv1zKcI2TCDay+s0RSK+CYOaVzU=;
 b=nuA4YtDM8Uk94ixxq5kXgwGUeZkZXovNJZhM0p2aqRRUYLrwUcKFo19OKEIwj9Xo1DF16Tmy5oOSJnd3st7gICflyNBdMx8mA29bNYXz86CirmW2JVYHTQTtOFBrQo0wmQe4Xu8+DKqAdwQoihYImrV0XDONyhgnWpwwsaQ2mf6nfFgJkNn30M52VsU5E+zhH95ySScXyRH7pHvdYXhwDseNMyxoTCsIuKScHn5OOllF/gWqO9FkAkU6UY4mUwNyL14TvgPafjKhALGC5e9leIRumlzNlo7NT1j+wGD+MOWSw5NSeprwMLyCN+7f2a68OWC/T+AN+51k1Eo19cxmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:25:46 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 09:25:46 +0000
Message-ID: <448eaa31-97f5-43cb-837f-b55e3b80ec53@intel.com>
Date: Mon, 10 Feb 2025 10:25:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: add EXPORT_IPV6_MOD()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, "Simon
 Horman" <horms@kernel.org>, <eric.dumazet@gmail.com>
References: <20250210082805.465241-1-edumazet@google.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250210082805.465241-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::32) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH7PR11MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cc8e4e-f8a7-4079-1608-08dd49b4e5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGozYkdGRFhuSUQ2SVQ0OEkwSWtjMnJ0a1NtclV4RUs0T0VJZ24xcnMvS0I0?=
 =?utf-8?B?NkFLQlpmczZWQWVqRng0aVZacVRXTVpuZ2N0QnlsVUxPYmZRUU1vcktLWm1v?=
 =?utf-8?B?UGFIOXNRZzRHNFM4RFIvUE4xVmxlUUZZS2xhVE4wWHNGVStxRlJlWFROQXpF?=
 =?utf-8?B?TW9rWFJReGxzWFBOclM5c0J2b2Y4aEFrbmNIQ2dTMFdtT3NZOVpvZW5lQm9H?=
 =?utf-8?B?UmJHemhFL2x4WkxjRitIN2xSc0pmQnovcUxFN1l3MG5ad0lvZVJzNnA0Mnhw?=
 =?utf-8?B?aFo4VHR5RnUxVExmSlhXeGRkVm42bmxPb2I4U3h6elpGL3JXOUlsTEZ2bno2?=
 =?utf-8?B?VkNxUXp1em1rYnNZcFZJclVmc05GWmVLeUo2S0FtQTQvTHJWTjlzcWUvaGNF?=
 =?utf-8?B?dlZaMkUrOE1hSGd2K1pZWWVHY3ZFSXYxRXU4cEh1UTYwbmhrNnFaTGxmSHlF?=
 =?utf-8?B?VzUvdlJjZkcrRkk3SGY1R3U0eVZmTSt1QlM3d3YrNzZpTHNwbUJ1RWJtaDJx?=
 =?utf-8?B?RWxXblRySDlkaDNva3lYOXpkeWwwSTU3T1dIUERrcXFzZ0N1VFNaMFhGelB5?=
 =?utf-8?B?Y050czlha3ZEUC9oNld6Kzg1TjJ0VjA0aENuTERObi9YN09HbTg5S1J0WHFm?=
 =?utf-8?B?SUM5ODA1bUdSOGVvRU5zSnVHc3RZbTZPbWFpbVMzS1RMNU9pVllXTGJOS2xE?=
 =?utf-8?B?K040WHQvMzVnL3VnTzhLbE1tTVJjUUtDcFFGWkRWNit2VUNEQmxvRU1iajh1?=
 =?utf-8?B?bHhpQXNiT3hZcUgyMzljd3oxa2ZXOGxOaTZHVjNha1lUdHZNTnllSXoxemwv?=
 =?utf-8?B?WnNWbkt5Ym9qTjFpUXV3OGpQbVQwSFpzNjFzQ0gvY0d0T21tZ2hYbVdTZHZz?=
 =?utf-8?B?S0RRenEwTXlad2lualFhZ1pLbUFBQ0F2UWhEQndFV2c0VFpZYzNMMHBva0k3?=
 =?utf-8?B?Q1JoaUh4aWpXVG0zWDFMN2ZuQTh3aktoODhIUTU0NEk1NzhaR3NlNjZjVVFU?=
 =?utf-8?B?NW05NEtGMWJLV28rcmVTZ1dPVU91VEszS3dLVXFpNnNzZ1ZTakpSVDdGK1hk?=
 =?utf-8?B?T2ZWdGRldXlCWHBpMFlvbTArSHdXdjNTOGhObnRzS2pSSFJDRkV3YXdHS29W?=
 =?utf-8?B?N05hSG9qeFNuOEJqL3dyeUJOSGxkaCttRGFHNUhiK0pad2xYcGc3TmNpdHFo?=
 =?utf-8?B?YjJBZit5a0tjN2ltYStzRjUrbGlQbGZyRzd4TGFQbzArdGVlVVMxRnRzcW9P?=
 =?utf-8?B?N0NzdG11a3o2c3B1MTB0dFhwcUdRTmYzaXNndWYydWRQek04KzR4K1VrZlIr?=
 =?utf-8?B?Qmg1YzdEbEZtTWVteTRwMzN1eUs0UzJqY3c1TTRRVVdVZmMxOHRkZmpoekxu?=
 =?utf-8?B?TmJ6YngrQ2plMytkNUF3WjN4ayt1Y0x3YXhmenZSS2RtZzdTSnZkTHg3NTBV?=
 =?utf-8?B?UUhDSDJhckVmUXk0R2VYUjZzclhwQTlESjdIM0N0WWl5dEovNEsyVHVCcUJT?=
 =?utf-8?B?QWN5OWhiWThMNkVZa28zRTVFUGtkdjkyd3owaXFIN3RBRTNoN2dGL0J3cHFF?=
 =?utf-8?B?UlRnZXdGMm1DN3ZKZ3VIZEt5UlRxT1ZqRDVVYVFuUWhFWFM5QW5vb3U1YjBl?=
 =?utf-8?B?YytSWnp2Nlg2UlZHbHZySktkUkUxamdWUUY1RFl5M24yVzk4NXdJOEkwajZs?=
 =?utf-8?B?T2pBWVFoTkp3YzlWTERlcGZpWnZqMkw3N05aM2F4SERzaGhJenpCQXpYL0pP?=
 =?utf-8?B?ZVoya2NJckNjdTExRFV0SWlCWTBqMEtJTUFDaHpmcHdxaFdhTUc5dDVyemsy?=
 =?utf-8?B?SzhFVDB6UytBY1JHR0ZrWlBSbkE3dGs3bHliU3hoUTAvT3Mxb0RqRzVkWXN3?=
 =?utf-8?Q?lBIHm/i1KC5kx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NBcFhNaFUyVU1OZGpwdDNqaDcvVHhkMHRrVXgrY1RoU3lsOUZ5YlJreEV0?=
 =?utf-8?B?aXJwMi9xa3h0QTVER3NQN3pOQjROWU1Ga3ZuczAxajZiOFhJcFRncFN0R0tq?=
 =?utf-8?B?RG0vMUZ4Zy9jOFVLQlR0QlFwUGMwaEo5K0l1bnJ4RDEzNjRkLzZLNWRXNWI1?=
 =?utf-8?B?RjlXS3hycklYVlI1ZmdSSGlXVzRnaytTeXhIcWFUeE02d0EvYkRHcFpqNXI4?=
 =?utf-8?B?c3ptRjlQTDJhRzFyaWNlZ2R1czlJaXZiYWdWREdGZFNCbE0wL00zVks0N1dq?=
 =?utf-8?B?c2xkMmxCREZiWndPWXdSSGxlc3NJSEZuODNPL0ExVCtYdEczamFWaDd0UjB3?=
 =?utf-8?B?emdvOHhNS014Q29CcDZZSGJQd2RiNXVleHNydDNhVzQ0UU9HOC83YUwvd0Vi?=
 =?utf-8?B?WU5GZk0rczZNSUxYMVNHRFRNVDZIWkQxckg5RlNXc2lBem5ITzd0MWk1SEgy?=
 =?utf-8?B?QzhMTU5uZDNjVTg3cW9SZitLWVhPZzhmMkFlanMxRFBJSHlCNGs4OHJOVG54?=
 =?utf-8?B?NUo4S0w0NzBHZmN6aVhHYWFaV0R1SlJ4WlVsTkxKeit5Q0N5ekdSMUNaMUti?=
 =?utf-8?B?T05IcHZhd2N5aXFlT2lGaHoyNEpMM2JlOXZoVUxldGFuelJyNUtqTjRCRUtt?=
 =?utf-8?B?Yzl2VWxPaEcvM1FVaGkyYk9qQnBDWklnRDRKck9MNUdoRURhZGF4dkExSXBQ?=
 =?utf-8?B?VTRyQ2syWjA0NmlNa0VNeFRsTHFwVlc4N3ZWLzg2OE56K1g0Z2ppNzdId2ZL?=
 =?utf-8?B?ZXpjYndGUjBSQXV3eDgzYnRRaXFxd0RTeW8yY2FMRTRCWlBvK0x1RXpHQjRG?=
 =?utf-8?B?cGh1OXBxeFA1TjhuTW91dWh4MmFqTk5QbGFjUlUxQ1JwSWJUTkFpY0E3SkhJ?=
 =?utf-8?B?SGpuTFJtN3lxWkZidlhieWgrS29GRTlZVGhQUkJmTWd3d0tXMnBaQUFoWVRo?=
 =?utf-8?B?ZU5GSUkrVnYrZ3h4d1J0NXB6L0NtMWlpNUlSUmVtdEJYWVY5NzhkZ2FpRWk1?=
 =?utf-8?B?dlFJdnVUTWwrU2ZZUWtlOWF0bHlMcExzUGxVWGZhZHJDdlFZQ0ozVTVqbkRI?=
 =?utf-8?B?SkRPSjB5VlhpYlQxSExWK2J2OWk3Ukl6S0hQT2J3MCt5K1kxSUJ5OWJ4VVRD?=
 =?utf-8?B?TjAxUlBLSDMrNVJJVkRId3NUOTFSK05BbW52WEJJV3orelkzU2laMmpKdzlk?=
 =?utf-8?B?T2RXcFE5UVZzZXhPYU95VG9rU2xsSWp6QWsrTGhJTXJJaGd0VVdRV1g3T3BG?=
 =?utf-8?B?akxjZFY4RTVjamEwaXB5Y2xnSnQ0K3JQM01VZGc2c1N5WHlkazgzcnZ0YVdE?=
 =?utf-8?B?MHpzamZXbkJvWWdBRHY2QmxnNTN5a1hSd1VVUUErQ1lZUzdMcWxHaTBPNk9S?=
 =?utf-8?B?Yk1LREhnQkwzQXNVakw5UmJObDJKSUxMQVllL1E3aHI3STdUN3UvY1F4Q1VS?=
 =?utf-8?B?em9yTysvZG5EVFRacnUzVklPY1cyQ2oyNXpXa0VGWU14VTFiQ2U0ODdyNzRL?=
 =?utf-8?B?c1FOdmVGSFZyWGhXOHNRVWVyN2g3RVA5UW9UQnA3anNCN25UaWQ4ZE5OS0RZ?=
 =?utf-8?B?RExGbVFIUUROWHFRc0RFRzhkSmRkR2lHNjFHYUtVbjN3Z3J4VURnWmpwck0y?=
 =?utf-8?B?MFJTbGlONEx6aXVac3hHSFRjaDJUMEk4QUNqRzVVdWFsMzFYbEtVUWQrK21x?=
 =?utf-8?B?ZVRGbUNKSmYrMVQxeUVqTEMyN2xpU1VUei9SSml1VW1FTFJWVVprdkkwbXVV?=
 =?utf-8?B?d3F2ekp3R3VJWEwwazJYaFhwaWNrMzBTbVRMVWlmZEZhM3RicE5ZbHhWdnhD?=
 =?utf-8?B?eFdhWGV3SXdPdXBCY283aENnUDRFL3ZvVXBnQzZIaUlYemtpQk9GVzVKS3BH?=
 =?utf-8?B?bHMzOUM0Rk9RMGJ1aDMrK0FNQkRncEFPN24zRTNlMXBSU1pOQjZDT1ZSa1B5?=
 =?utf-8?B?K2lRMkJBNGVKdEFaSjZjY2lIS3A2YzJJQ1l3WDdMT2lDRlIxR0kvNUZFOFh4?=
 =?utf-8?B?SDM5SGVMd3ZHVExrU2VpSnp4ZnhlNW0rRDBhRGM0eFVNcDhSRkZWWTBvS21i?=
 =?utf-8?B?ZVUxVmZjL2ZLN21TTjZHeFl0cUxuOXc4ajJzV3ltQlYzaEJWVCtjZUhEeWpm?=
 =?utf-8?B?ZUt6Y2d5VGVoQi9LdmhaazNnNk9mOE1VVFFHS3U0WUxReXRIKzdpcityNHJC?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc8e4e-f8a7-4079-1608-08dd49b4e5f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:25:45.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C87+VOIKdknH8/4nsiDniQLhIT973dNLMa5z+9ooYKCPfuaRK0vSg+TB6a8bvfqIXa5L3qofR6bEbmH0EC6tt1p1pnxZjcivatrN+gfeBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
X-OriginatorOrg: intel.com



On 2/10/2025 9:28 AM, Eric Dumazet wrote:
> In this series I am adding EXPORT_IPV6_MOD and EXPORT_IPV6_MOD_GPL()
> so that we can replace some EXPORT_SYMBOL() when IPV6 is
> not modular.
> 
> This is making all the selected symbols internal to core
> linux networking.
> 
> Eric Dumazet (4):
>    net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
>    inetpeer: use EXPORT_IPV6_MOD[_GPL]()
>    tcp: use EXPORT_IPV6_MOD[_GPL]()
>    udp: use EXPORT_IPV6_MOD[_GPL]()
> 
>   include/net/ip.h         |  8 ++++++
>   net/core/secure_seq.c    |  4 +--
>   net/ipv4/inetpeer.c      |  8 +++---
>   net/ipv4/syncookies.c    |  8 +++---
>   net/ipv4/tcp.c           | 48 ++++++++++++++++-----------------
>   net/ipv4/tcp_fastopen.c  |  2 +-
>   net/ipv4/tcp_input.c     | 14 +++++-----
>   net/ipv4/tcp_ipv4.c      | 47 ++++++++++++++++-----------------
>   net/ipv4/tcp_minisocks.c | 11 ++++----
>   net/ipv4/tcp_output.c    | 12 ++++-----
>   net/ipv4/tcp_timer.c     |  4 +--
>   net/ipv4/udp.c           | 57 ++++++++++++++++++++--------------------
>   12 files changed, 114 insertions(+), 109 deletions(-)
> 

The overall looks fine for me, the question from patch3 was a small
nitpick but not important.

For the series please add my RB tag.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

