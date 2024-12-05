Return-Path: <netdev+bounces-149276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5F9E5009
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B48B2813F9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F31D4600;
	Thu,  5 Dec 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlV7wl8i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367F1D433C;
	Thu,  5 Dec 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388226; cv=fail; b=Oll+bRI4nJE1xRX02Ea5v3PgtSAqF8ebmRODMX76gsQntKEzXjk+WoKAmD0Jqgj50UjyKSN5BVse45erYeGH4+a2zGISs226hpxIqPusxlc7zIV++zJFcdzOVA+XTXBUIjRlMnTRUOn5pymcaeY4GpRrTu5WJEqXe3GJmh0Q4XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388226; c=relaxed/simple;
	bh=8oLwwWrcThKSNe08+iPSOolvQKbxNFV5SblfbYmxzf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7amlxzR5/z8lUewHDbSYHqpcryV1yvmZu/qAJ0J6UrkzYcSjBo4QTLP70dzQgN+sba03VOJPbOlQ+5XPnSO78Cofq4XROXzLDgU51cUoBnWpZ3OxNdV4TTwjksH0uZKCVllQEQiACZ0k6Sm5FnGBJNaoDlteN8vIrubZvS0TgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlV7wl8i; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733388224; x=1764924224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8oLwwWrcThKSNe08+iPSOolvQKbxNFV5SblfbYmxzf4=;
  b=hlV7wl8itz4z4oAMpv0JQoriF0josHaDhaYV7ZzbfIQ+vner28nPD/ed
   xjnxQnumifgsepU1JjmQ4dZxf3AxsPwRvSx3QEnfiQG+GIjxG0Ui/CWXO
   ZzClebIjANGXLTHLY23yPW+4FPrp9Vdnb8Ih4PLmeqkBAoWXH5kj9k7IW
   CIJj6HKvLYowKfGGwkJ+UipN6esgNgWfchx5I7xRit8XdboKjjDOQuV1K
   lBcHys6cyeu2ZpHWpXTPaR5y6xBL9r45W74ej7ow9qSCCuWVolkRljD5N
   FzjS7iUt0uFPnUxo42d+zm5N2WFSBrW0lEZWDy8CFSDO7YrwjnGSFenvY
   w==;
X-CSE-ConnectionGUID: 0VoVbv7MSOqkrb2LzfDeeA==
X-CSE-MsgGUID: aMcq5PtYRfSh4Z7MM94BjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37350739"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37350739"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:43:43 -0800
X-CSE-ConnectionGUID: ON3HH3YpT02ZKw6DouNvaw==
X-CSE-MsgGUID: A/bWqb3IQpy4nx8ag0w3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="124949427"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 00:43:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 00:43:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 00:43:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 00:43:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSa+nL++GlDkommovGs/w5eYFzKkZYd9CVIFWdegdW+oeCBBa1BsCn9T6mdI7v9KYM54pjtFAcQZc4e+rF98G5Ep7fQac3fuaBL3wX00raDjm/fViDgKheAet+90kwuqwB5bTLGZZgxMw/+WAeJkynUau+zTiAgmtmk3CX/ccHY6GCs3J90dmStnKiYr5aBW9K9U7jTWZcV/WxlqMteN659q+wR9x4xVH+SOYAqsCBrZOUNPT4uybL54/e3NnaZUgWCuH7Q1jz74vSODJmqm1hIUOjcII+vWmWbIQCR9bKk+FZBCVmJU/VHG9ZZYvQPG4AGZteTK1/LFR1f7+DABZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ar9wMEIbg92CKhD/OphMihlFrq6dBiOVWbLLwpPlrU=;
 b=P0bkbO3alww00GZBEx4w8oBZpIuW6p4bbFIi6qQyz3pRT1FhDPfs/e7lpHkK/VOyxmRzI8NUYoOG71r1CzsBegvi1RXf4BrSWTkNu8XZE9Oug1MIHBq9NRkuhWKne3/orVD2MWTFWPzPNG90gnfdV+bCmnncETO+6yIYTRGmAY6heOKmPli8d4Yu4FjffklSykwLbHRiWxJUxshI0j5KHzkXB6rmYb7WGo0SRMnV1167eTSgQr0bWSjNZY9L0EX2sHo07yMFvulB6RpDcv0zv5uH1OSBt485lMwnYF7eOw3mYvTwHzxz11/4mtlP6oTrd3RxSAnAIJgVlMFrLaFHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 08:43:39 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 08:43:39 +0000
Message-ID: <57a7b3bf-02fa-4b18-bb4b-b11245d3ebfb@intel.com>
Date: Thu, 5 Dec 2024 09:43:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 6/7] phy: dp83td510: add statistics support
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	<linux-doc@vger.kernel.org>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-7-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241203075622.2452169-7-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA1PR11MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: b1276998-5e1a-43d8-7ca0-08dd1508ea56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzVjakpRK2dUVXJvU0Nwczk3RTZIY3RsUWtwSWd4NXoyNWVPRTF4S2c1TlBB?=
 =?utf-8?B?S1ZsOVAzaTFidkxJTFNIVkVGYk5zZzJFRXlYODdKWk1UNWxwMUpub01oSFdl?=
 =?utf-8?B?dzZZUDJiVWRWRllIWkN1MjFjK3JTVG9EMm5rckF5RlExUzFqZ2pEeVVxdDFt?=
 =?utf-8?B?LytYWFo0aXI3bDdvMi8wTkRUSnluNWhrdHZZK3E5RHI5ZlcyTDVaM3FqejNW?=
 =?utf-8?B?TmFZRisyc1BzVnNNc0ZRNHErMStTK1Jac2RoUVdKalVHVjhqT2RJbTJzNE9P?=
 =?utf-8?B?QkgxU09yUEczdDhKM1BzQTdYNGpNWExIU2ZPUTdXczliRldIcUlBYzlqM01L?=
 =?utf-8?B?aVZOY3huS08xMjFuOXJFeS9pQVhLTitlY1Qvbk1FRXU4dXhIVm0wSUsrMjlL?=
 =?utf-8?B?b1JPL0xEZFFlL2t5UVRZbTNvV3MwZlFpVEZXeS9UendHem5KeEs5bWlqYTll?=
 =?utf-8?B?eThoL1VFV1FJci9DWVFEVHZMMFZBOVJtSnN6TnJqazhFTVJndXpaRTJlWUl0?=
 =?utf-8?B?bWFiMy9HUFJxd3ByZ3JGVnZ0b29uWkx0aU1MSlIrdFArVzJTVmFlUllFODh1?=
 =?utf-8?B?cGVIU2pzTzMyODU3d2MyZ3grRVFRdDFpVnIzek9CU0VUWnZYQ254akYzcFBN?=
 =?utf-8?B?M2EzbWp2UWtJM0hPdnNlcklldUZVSFR4MU9tYzE3bzNZc284Y1hWSjcrZWQw?=
 =?utf-8?B?QWUrOTFmY3JxRmpMa1B6SWVUV0pLdE5WR09JS1dyckxPdUFZM3dQemdmeTZw?=
 =?utf-8?B?aEhvcS84QWNCNU1pZ05rbjdsUzZXTEFHanZKS3lnVjd6K3FZUDNtdjVKNC83?=
 =?utf-8?B?M004aWNTMXpBaHZjc3pweEhRZHhubXhkU0YxYTRJc21FRnB1bmVnRUFtVVpu?=
 =?utf-8?B?bXBGQXh2cmZvdW5NVVA3Y2tKM2ZUc1REbUsvOUphUTl6SE9VWE5ORG1tZUMx?=
 =?utf-8?B?NjdYNUNubVlYVzVqRTdUYVlJeWZPVGNnZXM5TmZwdEJuWUs5eEhmanpVN2d0?=
 =?utf-8?B?dDB1VjMyLzlWam95LzYyai9hbFFCbEtQK3VsNkJyWHV6d2l4N2tDSFBzK1RE?=
 =?utf-8?B?SWhray9ZS3k1aVRKRWJ6RU9URmRoMTh6UjVMQ1AxTmwzRmRTY0xZWXcyVVQ5?=
 =?utf-8?B?V3NvSDhyVVZvVE9YSzZ5YU41STF5OUorSlZ0cTAxVXVKOHI2dzQ2TjNabnEr?=
 =?utf-8?B?eVFhK0Z1OGFLM0lOVnVNUzdXbDFUK0dJckhMc1N0Z3d4SWFEblF2ZDRoT2k2?=
 =?utf-8?B?WW80L21OU2l6VHRVWDBjdWNjNnYrQTFxRExlZmtPZGdOUGUxNmZSLzluMWcw?=
 =?utf-8?B?Zzd6ai9GekpKSzNKUEZOeGhWMW1ycDEra0J0UTdpZ2JaaFRRMGdkVGJLVXlh?=
 =?utf-8?B?V3NybnlGOXlPNHRNS3g2c3FQOU5WYURJazFScHFpRUZvUExwSEJZL2YrZTQ2?=
 =?utf-8?B?SHNoZFBQTHVjNG8xVTZOcU9uZ0ZlMVBwL2haaGFMNXFBSkg3dWpyWTY0cktV?=
 =?utf-8?B?OGk4aWdMS3BBUkQwenJndXY5eE8rQVdBdEdrbUllN056cE44TVF2QzQzNGRv?=
 =?utf-8?B?YzdzcnNIRFVmcldIN2ZTVSswSnpPY2c0dDJoenRtWVlpVlNjZzZxMkMvN256?=
 =?utf-8?B?K1AyK2tjazNSVGh4MWl1Y2xMbWEzbFFmKys1dlhudXI2R1ljanVCUDE4a0hO?=
 =?utf-8?B?SUZ0cFVsdS93S0JsVUdqZExFR1V4RUVYL2h1SmhsN09XVnNpMTZKUXRLejdl?=
 =?utf-8?B?VXFUQzVMTlFpYnk4RW4rODJwclpKYkZtdkdnSlVvNWV5cnVuWmZlTlJ1U242?=
 =?utf-8?B?OHFGdS9DdzA3Y1JDRS9FUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJtSitSWHdaOVI2SXRDRGxwSDNzYkR6NVAvbzEyZk5HckozN1BJYWsrM2pu?=
 =?utf-8?B?d3pIMS9Pa1F6L1JmZkxtSWRmN005bERDTEpBNkZPcE9jbjZSdU9MQitmbGNu?=
 =?utf-8?B?S3FQMkVqejRMZGtUWUJZN2JGeG5FbVpVRjZremJjWWp1S1lpV3hrZmhNYnZi?=
 =?utf-8?B?TGlremRjYzRIYVdIMTZFc2VrSXUxN2FpRDQ0UnJLOXNBdUpGUHdPS0dSUkpM?=
 =?utf-8?B?eHJFa0lEQXFxejlMR20rT2RFZVRIYzdiSjB3TTE1QkFWSVJPV0I2blFSWVEy?=
 =?utf-8?B?R0xYMVZuMTE0MXhuOTRqMXRxYmNwTTNVa09aVXQ5WURXejdvUXgyWjlXK3Bp?=
 =?utf-8?B?VEVjY0NVZENDcG1CUitEOWROcGZuQVJLckNKaXJSd015d09DdWFITU1PRlY3?=
 =?utf-8?B?Zk55NlcvZDh4Rjh1WmREOWV6Wmp1cU1seFlXRTZZWWpEWEpxMU1lVVp3M2lq?=
 =?utf-8?B?RnRxVlprUmthTlpBc20xSUNYTmxQTkV4akRxOGxNb2kyVUpHRHZtS2FIR0sr?=
 =?utf-8?B?TCtXakNpaTMweVZyZ01yVVlNMXhWZDZTM25xT1d3L3hVb3hTSzhGeDFXV241?=
 =?utf-8?B?TGlNVVFaL3hVQmVFL29LN0J1UWJPZHNibURYa3JCREVRYVZjRmREdmJVSCtU?=
 =?utf-8?B?aEc0elJBVWhIY2JoWTNEN08wakFYU0J0dk1jSVgyeHFXS1lLVnEwMTI5dkhw?=
 =?utf-8?B?SGdpVGlhZFd3Q000YUM0WXhPWDliUVkwMmp4dml5UWxLek10cmoycTVSS3g0?=
 =?utf-8?B?dS9tblQraG1YQjlkdGpRQmdIZ3M3dE1HS0gxTHRibmV6dTlYNVpFbEV6QjBJ?=
 =?utf-8?B?THBxUDMvMDRPQk5DYUpvYndHdW1na3dxaThoWVAzWFBvZFppeFdOcEZLSXdT?=
 =?utf-8?B?cTZOZXFmb0JnZjM3eitsQUg4TXQ1cEp6RndEOTI3ZVZNanhoOXdYRzlEaEo0?=
 =?utf-8?B?VGc3d2E2dGlQREFOWkFQY04xay9RdGExMlp3S3MyRGJCYXFhSHh4L1VGQm94?=
 =?utf-8?B?UEdZcWJYbkdLY0ZZNXJUZzFRbGoxUitqN1p0T2N4T2VCSlZlZGEvV1BQaE5M?=
 =?utf-8?B?YlBGMEFwZWgwemxtZ0E2WkN1ZHVLeEVuQ0pDd0VxWkF3MmVKVkRwRWwyZzlY?=
 =?utf-8?B?WG94WUVLQWI3OGNrN2QzYlh5c043VTlEMXQvcWpLbWRoSm1nbHVJdUVRRGlK?=
 =?utf-8?B?WkRzNDNjeXlGQURsdzc1bzJtclZsNTgrZGtlRTRyVjcxYWlvV2xici9nMkhu?=
 =?utf-8?B?ZytELzJIL0hoR3VkVnFEMG5XU3JsSUVHcll5K0loWVNNOE1NNXB5VHhkR2xs?=
 =?utf-8?B?eHBqLzF6LytjZDFjbFlIZlNOQ1VvcDg3VnVkMlh6Sm1xbmQwNnYvNHE1a3FD?=
 =?utf-8?B?TndrVVFqa28vTEtHVXQ3bjkwYk9IUURLdG1kTVFITVFubzhueW1jdE1PaUFx?=
 =?utf-8?B?d09jdGZQSklZbnI5Y2RiRHJoc0NZRU1tZmdTSW9nRlFhZkt4d2QrcXBySXdL?=
 =?utf-8?B?ZW1VNUZlOERYRk5MMTZiOXUzd25pUnROay9xRFkvdzAxb0F3R3lFc1RRQ0kr?=
 =?utf-8?B?QmhEb1Y0cHdjaUYzTjAzbldCR2tiWFFTd2I1ZG9Rb2lPVGNtM09pMkZ4MlEy?=
 =?utf-8?B?dFRmY2w3YWxrR2JXeU5FalpUZEEwRTBLNGZoNDBWNXA5Nmp3cWRlSCtHVW1F?=
 =?utf-8?B?d2xwZ3lZNk10TklZZm5ENXJ0T1JPWFl6ZlNkMUFNbGloV0VQQ0d6Lzg0SmRU?=
 =?utf-8?B?RVM4VndUNGU1OXhZbmJYemVlWE0zTWtwZjBjRFJ0ZWgvT2hGaVlBVXlyeVN1?=
 =?utf-8?B?dVlIcW8zMWhlNEZ5MWN3aEN6N2VGL0dLaTRWU1F3U2NCbWJnTkpCamFmTTFW?=
 =?utf-8?B?eEFTOExjejZ2OU40TWVDTXk2M0tXeWhKMzhRdy9SbXFaM0dvamdVSTRSNm5q?=
 =?utf-8?B?MnQwR3JpeFJucWRsc0tKKzIvSlV3UENLZ1VFbm5rYTdzVkdYaU9sZXc4UnFZ?=
 =?utf-8?B?NUdNRWlXYWY0UG8velZTQWZJZThIeFp1d0VsQ0lHdWY3djVWTEtnKzBUUmxk?=
 =?utf-8?B?VW1VV3MvZzE3WWIxMUF3YzVBRGVDcHgxTGlXZk9vUDdUZUliYnZDMmhXYWRo?=
 =?utf-8?B?RExyL0lOVG92T0tTRThWTHR4Um5OaUdyRW5IN1RLWVlpQ0h6QzBkMTNmem03?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1276998-5e1a-43d8-7ca0-08dd1508ea56
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:43:39.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfRgHh5OS5I1FjjCC1Z5xWSdqO+M0Z4iP9Wk7t2RwcySLb+1J5w5LVoL+3QFwEj0YRYaYAwMA9MAR4yEXRSUwQm9KfV2HzCYd2aT0oYJblI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
X-OriginatorOrg: intel.com



On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
> Add support for reporting PHY statistics in the DP83TD510 driver. This
> includes cumulative tracking of transmit/receive packet counts, and
> error counts. Implemented functions to update and provide statistics via
> ethtool, with optional polling support enabled through `PHY_POLL_STATS`.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/phy/dp83td510.c | 98 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> index 92aa3a2b9744..08d61a6a8c61 100644
> --- a/drivers/net/phy/dp83td510.c
> +++ b/drivers/net/phy/dp83td510.c
> @@ -34,6 +34,24 @@
>   #define DP83TD510E_CTRL_HW_RESET		BIT(15)
>   #define DP83TD510E_CTRL_SW_RESET		BIT(14)
>   
> +#define DP83TD510E_PKT_STAT_1			0x12b
> +#define DP83TD510E_TX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_2			0x12c
> +#define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(15, 0)

Shouldn't it be GENMASK(31, 16) ? If not then I think that macro
name is a little bit misleading

> +
> +#define DP83TD510E_PKT_STAT_3			0x12d
> +#define DP83TD510E_TX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_4			0x12e
> +#define DP83TD510E_RX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
> +
> +#define DP83TD510E_PKT_STAT_5			0x12f
> +#define DP83TD510E_RX_PKT_CNT_31_16_MASK	GENMASK(15, 0)

Same as above

> +
> +#define DP83TD510E_PKT_STAT_6			0x130
> +#define DP83TD510E_RX_ERR_PKT_CNT_MASK		GENMASK(15, 0)
> +
>   #define DP83TD510E_AN_STAT_1			0x60c
>   #define DP83TD510E_MASTER_SLAVE_RESOL_FAIL	BIT(15)
>   
> @@ -58,8 +76,16 @@ static const u16 dp83td510_mse_sqi_map[] = {
>   	0x0000  /* 24dB =< SNR */
>   };
>   
> +struct dp83td510_stats {
> +	u64 tx_pkt_cnt;
> +	u64 tx_err_pkt_cnt;
> +	u64 rx_pkt_cnt;
> +	u64 rx_err_pkt_cnt;
> +};
> +
>   struct dp83td510_priv {
>   	bool alcd_test_active;
> +	struct dp83td510_stats stats;
>   };
>   
>   /* Time Domain Reflectometry (TDR) Functionality of DP83TD510 PHY
> @@ -177,6 +203,74 @@ struct dp83td510_priv {
>   #define DP83TD510E_ALCD_COMPLETE			BIT(15)
>   #define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
>   
> +/**
> + * dp83td510_update_stats - Update the PHY statistics for the DP83TD510 PHY.
> + * @phydev: Pointer to the phy_device structure.
> + *
> + * The function reads the PHY statistics registers and updates the statistics
> + * structure.
> + *
> + * Returns: 0 on success or a negative error code on failure.

Typo, it should be 'Return:' not 'Returns:'

> + */
> +static int dp83td510_update_stats(struct phy_device *phydev)
> +{
> +	struct dp83td510_priv *priv = phydev->priv;
> +	u64 count;
> +	int ret;
> +
> +	/* DP83TD510E_PKT_STAT_1 to DP83TD510E_PKT_STAT_6 registers are cleared
> +	 * after reading them in a sequence. A reading of this register not in
> +	 * sequence will prevent them from being cleared.
> +	 */
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_1);
> +	if (ret < 0)
> +		return ret;
> +	count = FIELD_GET(DP83TD510E_TX_PKT_CNT_15_0_MASK, ret);
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_2);
> +	if (ret < 0)
> +		return ret;
> +	count |= (u64)FIELD_GET(DP83TD510E_TX_PKT_CNT_31_16_MASK, ret) << 16;

Ah... here you do shift. I think it would be better to just define

#define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(31, 16)

instead of shifting, what do you think ?

> +	ethtool_stat_add(&priv->stats.tx_pkt_cnt, count);
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_3);
> +	if (ret < 0)
> +		return ret;
> +	count = FIELD_GET(DP83TD510E_TX_ERR_PKT_CNT_MASK, ret);
> +	ethtool_stat_add(&priv->stats.tx_err_pkt_cnt, count);
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_4);
> +	if (ret < 0)
> +		return ret;
> +	count = FIELD_GET(DP83TD510E_RX_PKT_CNT_15_0_MASK, ret);
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_5);
> +	if (ret < 0)
> +		return ret;
> +	count |= (u64)FIELD_GET(DP83TD510E_RX_PKT_CNT_31_16_MASK, ret) << 16;
> +	ethtool_stat_add(&priv->stats.rx_pkt_cnt, count);
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_6);
> +	if (ret < 0)
> +		return ret;
> +	count = FIELD_GET(DP83TD510E_RX_ERR_PKT_CNT_MASK, ret);
> +	ethtool_stat_add(&priv->stats.rx_err_pkt_cnt, count);
> +
> +	return 0;
> +}
> +
> +static void dp83td510_get_phy_stats(struct phy_device *phydev,
> +				    struct ethtool_eth_phy_stats *eth_stats,
> +				    struct ethtool_phy_stats *stats)
> +{
> +	struct dp83td510_priv *priv = phydev->priv;
> +
> +	stats->tx_packets = priv->stats.tx_pkt_cnt;
> +	stats->tx_errors = priv->stats.tx_err_pkt_cnt;
> +	stats->rx_packets = priv->stats.rx_pkt_cnt;
> +	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
> +}
> +
>   static int dp83td510_config_intr(struct phy_device *phydev)
>   {
>   	int ret;
> @@ -588,7 +682,7 @@ static struct phy_driver dp83td510_driver[] = {
>   	PHY_ID_MATCH_MODEL(DP83TD510E_PHY_ID),
>   	.name		= "TI DP83TD510E",
>   
> -	.flags          = PHY_POLL_CABLE_TEST,
> +	.flags          = PHY_POLL_CABLE_TEST | PHY_POLL_STATS,
>   	.probe		= dp83td510_probe,
>   	.config_aneg	= dp83td510_config_aneg,
>   	.read_status	= dp83td510_read_status,
> @@ -599,6 +693,8 @@ static struct phy_driver dp83td510_driver[] = {
>   	.get_sqi_max	= dp83td510_get_sqi_max,
>   	.cable_test_start = dp83td510_cable_test_start,
>   	.cable_test_get_status = dp83td510_cable_test_get_status,
> +	.get_phy_stats	= dp83td510_get_phy_stats,
> +	.update_stats	= dp83td510_update_stats,
>   
>   	.suspend	= genphy_suspend,
>   	.resume		= genphy_resume,


