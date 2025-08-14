Return-Path: <netdev+bounces-213645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E250B2612F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8083AB11F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DD302CCA;
	Thu, 14 Aug 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6DU0Rm6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A9302779;
	Thu, 14 Aug 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163905; cv=fail; b=CjXOO/yw0RqHki/dKGMAQi9HNbL1fHW/OVcthcrT+7DDHDFw6B1c1FMyHYz8VpQI0vn+0uCoa+YhvINxNkpYsRaej3M/7L92csbfWlSJDl/aORc7eoY4MshPSH+wQJXS8TuE1dZGkLkSY5ttSKuxBQlSp/jgs9wZeYfh0BWj8sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163905; c=relaxed/simple;
	bh=tlsgo1N3qsGu4fjSQK+F/FFjfTeFUh1/GAlYAz+R39k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ax0f7p4kNjAd9WD4hX3magYP6TKgUhzlhngTieQK751BGXzexcijobUddpICgT4p2V7xtnOgJlVBEFVab35TD864+uL6jefDxTD46IZ48m/6eDsRERsKtfCgHyHKkJ6HU/aun5GD7VVPPlrri2BqeV5wsoHCQzgDexP5fj6+wAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6DU0Rm6; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755163904; x=1786699904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tlsgo1N3qsGu4fjSQK+F/FFjfTeFUh1/GAlYAz+R39k=;
  b=G6DU0Rm6wfFX3Y9ZqNkc8EBR/t0aPQnwUo7fVQcqpGJnXL8caEYAIoX7
   aYJPcadL1PzJ094qJelGIyYgVJFfKPa8ADULx0Rcy6pv9S3akgFdcVClu
   fhW3RV57wB+guRlNUni5hwRO4WlHYIO9GekDjNaJQ0Hs8PW9aY1XFafm5
   lqhX4rSoBkr8s6wsKva+fjFyWOfFjSgJD4oUOe19dy5vveUNL1Ni6kssE
   yKLcuT+hjUuzj292X0MC64z6pzIYd7L9433LhDnM/6JQvSkD/SX6NmcNs
   l4f6Z7nGFILx0avZ+0fzNDiXXOPCc8oQhvXZ4tNABHdiAFQEVRS4f8cLN
   Q==;
X-CSE-ConnectionGUID: xZwm3OEYQpaW844xibX6Ew==
X-CSE-MsgGUID: dSu71hWQSN2eDH/wtcn2jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74927045"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="74927045"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:31:43 -0700
X-CSE-ConnectionGUID: +xUlVaMgRB2vZtaibTs0hA==
X-CSE-MsgGUID: DZCd+yKTS9S/YR0RXJ1h1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166351960"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:31:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 02:31:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 02:31:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.79) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 02:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGpN5nCoatbSYQAqKLTCIo7Bousf8BpkvUy7KvLXOYZcZ6bf8uFORcUbqphprqrtckSf6fcPGKG4HMa7EsHfhhxZYdJd5XLbvGoacYl+a8yYpE6kCdziEcyH/wu5eCL2NUzVq1/WSVFBVFy85b52Cw0W0D7QZByPPa/Tk9RPmfOop7TKCd5UsUZeCDGg5Z6e16IQBmiiqWvOSjDLTzTcAiN+l1pnxMTxt/bB9+6KqBiw7do3b9iYZpcvxxSuztSWgup1IAxUImNiWzlqAFrLuGTMHuEs9ziPg2oYMni+MwdbZRXpEnJv/IbAmDfUbzWarfir14A2px4MTU3lhxQvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2B4hyzJHAsN2DI0/k1QMfJo4LGiAZ+yeddhNMwKSrQ=;
 b=ucvhZDe1nAp4hy2NMqqSRcwj0rztcfVAqNpRXqMGrtPkYAHImpY8F6ErbaKwS3ubPV7Ba3nBns8hZU691byMaZ0UIvEKKdiKKTOXpUBN6Y6pHBCuTNM+1kUI3o2TxD0lc07FtKgmI0ukHfOFCzu3xDSiTcILF4E5D2p5UOf2/6+e71ENW6MCpviLeZSP1rBfvLFlU43gOWQf2z0IrHGFmOJYiELg/by6EmYH2XRiwQgnAETMa5ot5lFEx/mDBwZIg+tX9lLZaTqV1wjVj9J1MZh7yQuLplqcKY7GvFgXrplOsFLGerZ3+w7zkhFpY3zxJvcnH+Deo8TYyQgONEBAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 09:30:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:30:26 +0000
Message-ID: <c1699314-bd3e-4dcb-adfe-be02a6f7cc7e@intel.com>
Date: Thu, 14 Aug 2025 11:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] dpll: zl3073x: Add support for devlink
 flash
To: Ivan Vecera <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Michal Schmidt
	<mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
References: <20250813174408.1146717-1-ivecera@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250813174408.1146717-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2db0da-e6bf-40bb-a26b-08dddb153349
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3dnUHhnaUZxY2ZWYWo4YTlFK0dFQkhmR2YzN1daMU5UWDFTdW9rYW1tZFdq?=
 =?utf-8?B?K29BM2t2ZXg3eFhmZElLMjhuVnFtMzdINzR1UVZzRVhyRms4VEhzRVRDT1Bx?=
 =?utf-8?B?YS91UmpicW5qa09pQTNmWHVwTjhRSmNvMVk5MHphWkM0NGJHQ3Uzd3BXeHMv?=
 =?utf-8?B?dmpRWEQxSkt2OVFORmp6bkhMdmhBNVRwRkkvK3J2R2V6OVhOeU9JTmg3Ulcv?=
 =?utf-8?B?Zk4yVUpjNXVoSHFuOVNCdkZZblVRM0FUMndPbm1sQWlCYm9EY2JlWkxwcUly?=
 =?utf-8?B?OGc5VkFkSy9zcWFDd2F2c0t1UmVQNnBOQVRBbmNGVWdjUFZkUmJZRUFFbytS?=
 =?utf-8?B?aDlRc2U0aWowS1lLVEludmFJb2pyUXhjTlc5aHBlOWRadTNVU1lZOENNQ1RN?=
 =?utf-8?B?eTcxdkNUOWpFNStXMUtYVjlDbFFMcEZVT29WTWZkb3RzR0xURk16YXFpNW1q?=
 =?utf-8?B?WFAxS3orVnJNTEI0akZESnRjN28rM1h2VXJrSFZkdWJ4Z2NYMWFxa0RMM3Yz?=
 =?utf-8?B?V0ppckNUVkxvWVZuck5oUThReDdrZXVWMHBnK1czcmNXbmZENk9zb05TUWhX?=
 =?utf-8?B?UVRmbCszUUo1NnZiMVozdVB3UTRXOC9MM2UwQnIvMCtrUGN2TDZQUXdUdmpw?=
 =?utf-8?B?SlpNeDA5VUU1d0Yvejg0TDJqZWFSMlpWdDZQcFREcURIQmFGTTJwN0Qya0Ra?=
 =?utf-8?B?dU45WllLR09Hei9ZZVBMTDhIUmFiYjFIcEZxcWZoMm1mN2RqbWIzYzBXQjlP?=
 =?utf-8?B?bk9mVnBHTi96TlpGODZ6ODhKbnhOY3JQV3NtZkdxMWxERjlMMTdIaVlqL05m?=
 =?utf-8?B?Yy93a0RldUVFQ0pZOFZ0Ni9aRWtsZjlzL3R4dFJVSUxtTy9qMWVMcy8vR0wx?=
 =?utf-8?B?YXZBNU81dUMxY3JITlhTSWlCaE5vTDVTY3d1RUlxUitzSTd4M0kxY2ZHOExl?=
 =?utf-8?B?WC9lOElibGovcnlVVWRWdUxaRlpVeWNYbDUxaEhSM2xRMFVGajMvVDVObnVY?=
 =?utf-8?B?MENxdzZpOHd0RWdXUkVCQnBta0lWZ3NmdzEyNnNrdFh1VHNLajR5MTB5VitN?=
 =?utf-8?B?UjJXQUwzVWFkSzg2MjJZdnVuaXFReXZsMXVEeFFGSkJPb3BkZTR3VFBNMkg4?=
 =?utf-8?B?aHp5OW4rMHJZWWcwajVqV2NGWEJ3dVRkbWw0TTZqR3Z4VUIzRGtITDhjdGgr?=
 =?utf-8?B?SytVOSswV3RCOXBsVTMwWk5Zay9WNmd4VUR5ZmYrTmpSRlZuNklzQTZ5OUx5?=
 =?utf-8?B?eHNScHhZV1ZpU2l2dzZTV2g5UW1BbkxGZ1NzNWV4bkVXcHdVT3QzSHZvZG95?=
 =?utf-8?B?OEE0T0VJd25UbllBV05jd0x1cGhGc0FzL1ZLdWRIMXQyTEh0eU9pV3IwTU9Z?=
 =?utf-8?B?M1RnMkFuNzdjaFMzZS80K0NQOTN6S3hGREYxMjZrSnZxdjNPMVZtMzJIcHNJ?=
 =?utf-8?B?cmdsWFFBdEVSbUhhYW9XaEFPelZCUGNOOVloaHR0Wk9mQnVJRzBDaVN1NWY0?=
 =?utf-8?B?dkZ4Tk80M0xwOE9LWEJmbGVKY2RuZG52ZEFubDZuWFNWQlo3RnUxaDg0Skhs?=
 =?utf-8?B?OVlpU3QzQ0haTmhkRDNlaHVKTEx1NXlXLzRpY3Z2WGVSSlhqSktkemtiSmVX?=
 =?utf-8?B?Vy9BckxDZEdyRmErKy9SelA3Q25CWEZBZERJYWJNNGpTVmZOdWRzNmdicEw5?=
 =?utf-8?B?SjJKY01yUk9CSG4wTFZ0czJtK1pPTzBOdmJqQUZURlZKTUpPS01ZcnhSc3Z4?=
 =?utf-8?B?R0JneGM1WDNrVVdZR0xLQUdSQ2szL2pBamxoU004WUQ0em15enRvMy93WTFC?=
 =?utf-8?B?eG1LWXZWdWhObGdJWEtDVXd6YjgyMnlvTXVuZkVYMitYTHJ5R3kzdnBFRFEr?=
 =?utf-8?B?eGYwNmhaRDBWRGdQTXpHbHp3U0t1VTB6WjRxMlE2TlZiTzV5T0F3SjBmd1FX?=
 =?utf-8?Q?jkYUxTDkaCU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHR4Vy8xUkhjbDVwcG5rQ0R2U3dDeFlxNXpJbXE0UTNORUNSREVPT0dnZGt6?=
 =?utf-8?B?K3dHNWk4RGp3djJ1VTNZQ2pTOEJ6ZUNtdUtBYnhEMVQxOHUzNTlRT0dydW1p?=
 =?utf-8?B?RnYvUjZwZUZ0R2FicTU4Tk8rcXlnUjhkeUJWWHNTSGlVK2pwYnF1OVk1R1JF?=
 =?utf-8?B?UXkzRXN5Qm1tTTZhNHJ3VXFmUFV1SW1EYnd0NndyU1o4V1RIdTc1SnQxdUww?=
 =?utf-8?B?Skp6RjNjT0hGa205Sy81Wm5zTkdqT2FLV3lDdXNOQ3JhZlFjaTZKTDhrTFhH?=
 =?utf-8?B?OU1Xb05XZzhyTEdiU0E1RCs3aVhxWWdTNS82UGFSK1I2V1lkMkJhQWVwWFhs?=
 =?utf-8?B?aW5PRE1wZ3BwZnFoOXErSjVRNVdWVG9qUWxPK21tcjVaZVhJQjlRWTJkUnI3?=
 =?utf-8?B?Tno0UXVTNjF0Z3EvQVNDZGk4bXZBM3M1NWtTeFJOTUdnamRyak1Hekt3TFpV?=
 =?utf-8?B?RUoxSVBjV3FPZk9JWDdGY0pIcHlOTnNFMk1pVHVqeExka3BJbG52emtvMThM?=
 =?utf-8?B?Y2VmTTREU0g0RWkwbnl2UUhFV2wvbDVTWEI5enFKY3JMU0J6RlVZdEVadFJz?=
 =?utf-8?B?WTVnLy9NTTN3N0xxMC9ZcFc1cmVBZ1pWM3UwSXZvNXlDb2d5OFRWdGhjNThr?=
 =?utf-8?B?MzlJbFhxWXZEWURZTzZBQWJSVjlNNDc2WFlyNWo5b0daMGhBU2VUaEhjb01W?=
 =?utf-8?B?QmVJcHlwQnRBaTFMWlI3cW9CL2FnRW1GcFQ1Y3dqOWM0WGtuNXlwVW5zMlhV?=
 =?utf-8?B?TVkzYjNHMVZCdGhtenN4bkpUUmNQaVFHUWdqU241a1BBb3dTTHNPS3hwS3Vu?=
 =?utf-8?B?Vm9aU2ErMDZKZkFxaWo4T09JL1VLUDN5VHQ4Y1JLMEcyWUIrMjFuSjhwUndz?=
 =?utf-8?B?QXFzc1lLSDRISHhoT2M5TXcwd2JuaEt3UkQ0QWgyTU5ZMHorQVBwYkZJTVlp?=
 =?utf-8?B?OTR4Vm9hMTBKekc4MjhvRExnVnZiTzUzZWFqenhQd2xDdS8zNDJHdDhTWXhR?=
 =?utf-8?B?Vzh4a2FtcUpIMWcwQlNSSXdCNlRESmlJbG5kQTRVWlNqQkV2VnpKQ2dNWGlx?=
 =?utf-8?B?cXJ5TUJ2RUhpcDFiSXlhL2txcXc4MTdid2IrQURObHErNFZlY2Z0Mk9ReGVK?=
 =?utf-8?B?aWcyM28rZ0J4YUxoM2tGQ3F5SEwyckN4VTNrZ2pGbjVha3hZZ0gwMW5mOTNi?=
 =?utf-8?B?Qkx5a3RkNWQvVW93VFovcU55N2JuYXJEaFloeDdhWUlyQ3JkenVROW1URVgr?=
 =?utf-8?B?K3k2aWV1NFF4RjVSMVQ1QXRObDA5WkErTzZyaUdIVmNiOGJMcUVMSFg5VWwz?=
 =?utf-8?B?SXYxNHVnODFYdkVsV0ZjZEp1cGNuaWdNTVBsOHh0VUE5Z1cwcGYxdWFKNWNx?=
 =?utf-8?B?Vmk3YXVlQXk1TERtVUR0S2ZUQ2xsZ0hXcGtVbksrenlIdjZBK1U3ZkdQNnd2?=
 =?utf-8?B?andHSktOREM4Z0l1VVArSDl5YUJha0gxMnI2Mlc4LzJBTU5WenJDN0hnS0RB?=
 =?utf-8?B?MVBNc2R3eHhick1hdFFNdjAyL0pqbWduS29mWG1nbGJjVG1YYjRwTjQ0a0dw?=
 =?utf-8?B?TDl1TjIzaG12aE1oOXBrRzE0MjVrbDFwNW93d1ZXbkxteThRemFLLzNjUWw4?=
 =?utf-8?B?Vy9aNStyKzEzemY3am01bDBYUHZPZ0xRdlZIdThhWWpNdkxkK2lHcDRRTE1Y?=
 =?utf-8?B?bVVNODRSdXdDM2J2blpXM3NYaDZ3S2tBd3E4eHEzb04yNGQ5dHZnakc2WVhz?=
 =?utf-8?B?RnVhb0dVMWgrRjBXMmo1ZWsvZnI4WnBrc2Z5WmZYZGxKUitweTZFNkZReHVP?=
 =?utf-8?B?MGJHQmdNa25EQTUwaWpkR0pxL203SXIyd0JBeUIwR2FFWmhFL1pYRGtoSDds?=
 =?utf-8?B?dW1zRkFXQVB0MFN3dW9NSFdGMnpYS1k4aHRNM1A1MUtVRkFud1JFM2l4UWdL?=
 =?utf-8?B?WmhvNGJMWWlTbWhieHoxb09uWTNOT1J2R0lZQURScUo2QWUyVTU2ekR0SEV1?=
 =?utf-8?B?eUkvZWJaN25hU0dXNnZkWGJzaEJ0bUNIUUlNeld0THFTRnpIRkNjb0ovN2sr?=
 =?utf-8?B?b3ZNaUo0elZWbE1IbytzR3pYNDJZaC9TRmdpM2hCRHFsWHM2SmdXYlk3TWZK?=
 =?utf-8?B?ajdEUTBEdDZxTTBTMWxQcTgyWk1ndVNEdFBJcERsT0pad2pqZ2MvaWlpNzh5?=
 =?utf-8?Q?t/gQVf/iiHUlfWZ7OI3GpbM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2db0da-e6bf-40bb-a26b-08dddb153349
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:30:25.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL1FN9Tc1m+G54UWj/EbtK8wK1HWU4Gb1aOumRJdbRIJv9f3utJMan7H0mPz63WaA9Naoxpd/7sIdkouPzXasChsHFUCkEt38TNOtQpuFxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com

On 8/13/25 19:44, Ivan Vecera wrote:
> Add functionality for accessing device hardware registers, loading
> firmware bundles, and accessing the device's internal flash memory,
> and use it to implement the devlink flash functionality.
> 
> Patch breakdown:
> Patch1: helpers to access hardware registers
> Patch2: low level functions to access flash memory
> Patch3: support to load firmware bundles
> Patch4: refactoring device initialization and helper functions
>          for stopping and resuming device normal operation
> Patch5: devlink .flash_update callback implementation
> 
> Changes:
> v3:
> * fixed issues reported by Przemek (see patches' changelogs)

thank you!
Now series looks good for me, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> v2:
> * fixed several warnings found by patchwork bot
> * added includes into new .c files
> * fixed typos
> * fixed uninitialized variable
> 
> Ivan Vecera (5):
>    dpll: zl3073x: Add functions to access hardware registers
>    dpll: zl3073x: Add low-level flash functions
>    dpll: zl3073x: Add firmware loading functionality
>    dpll: zl3073x: Refactor DPLL initialization
>    dpll: zl3073x: Implement devlink flash callback
> 
>   Documentation/networking/devlink/zl3073x.rst |  14 +
>   drivers/dpll/zl3073x/Makefile                |   2 +-
>   drivers/dpll/zl3073x/core.c                  | 362 +++++++---
>   drivers/dpll/zl3073x/core.h                  |  33 +
>   drivers/dpll/zl3073x/devlink.c               |  92 ++-
>   drivers/dpll/zl3073x/devlink.h               |   3 +
>   drivers/dpll/zl3073x/flash.c                 | 683 +++++++++++++++++++
>   drivers/dpll/zl3073x/flash.h                 |  29 +
>   drivers/dpll/zl3073x/fw.c                    | 427 ++++++++++++
>   drivers/dpll/zl3073x/fw.h                    |  52 ++
>   drivers/dpll/zl3073x/regs.h                  |  51 ++
>   11 files changed, 1657 insertions(+), 91 deletions(-)
>   create mode 100644 drivers/dpll/zl3073x/flash.c
>   create mode 100644 drivers/dpll/zl3073x/flash.h
>   create mode 100644 drivers/dpll/zl3073x/fw.c
>   create mode 100644 drivers/dpll/zl3073x/fw.h
> 


