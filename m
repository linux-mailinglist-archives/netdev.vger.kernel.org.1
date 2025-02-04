Return-Path: <netdev+bounces-162428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF8A26DBA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61031885A69
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E5C207640;
	Tue,  4 Feb 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PISbRPSu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B829206F18
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659131; cv=fail; b=DgRCs44Dba7uD+rea1yKsKvZzw50ufkFIQBSiy6/cZZebqR4EPRdzfojQf/FhpK4ZvWfpiPf7O7VmwsF+0QLsBsh/f/8Bt0R9H2a7wIvUtMuOqXUyGv0M8wAkeo/K+pyu7XJqnkLglFdL+iqxTzRuPrYYK/NcphokjqumGdrDWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659131; c=relaxed/simple;
	bh=JMIPudo7gxmZ1r1DDdv3MKfF2hnjykubSse7AVI1MFg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mRL6arlW/yusgeziNcOXspDHJALepIQzT/JaDP8F1N424+/Fi7fMCnEGhV3QcMVVyTS0gJX2dwPSrMNmzB1fD2kCHf7k8xodDrgCmkr6j1qPLBhX59KU/mR6sMTGtNWeZNRcDr6vEAjENwjG1AmeSRPTH1wTIM3WwEsOLCcZbZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PISbRPSu; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738659129; x=1770195129;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JMIPudo7gxmZ1r1DDdv3MKfF2hnjykubSse7AVI1MFg=;
  b=PISbRPSuXFnPuApg1Fmx53x3+gPDwU4BjJCLdPROdZ6hKOFcuZgPKYtJ
   RlQ1NaTjnHUD1wjDmPe1JCMIpf9sOuqXRSwvD8VgnbEz8545xPZvRoUSE
   dFCROYBPgq0ABJjVJzpQey/ir5vzeWEwzykk+cZ/olOA6EDgCz7AiaQB1
   9HAup1a398rqSPMBc0V2/fShIXeu9d7YO6Y0KVuh9llraYjJSvTMjIg8h
   cEhLpvtot5PYt0kWy2iaspLEYEftC8V3rea+FuNMsXDI2Jve9MGC40TSr
   cpvRlcZh9u0nqgM+eHJDzd4bB8meqoCuKJNUnEM+7rskrPPKOHmYAn0cz
   g==;
X-CSE-ConnectionGUID: Ivm7NeKgTpqAG3Tva8BUxg==
X-CSE-MsgGUID: erhlAoujTqWBwZs9voKVJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39276349"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39276349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 00:52:09 -0800
X-CSE-ConnectionGUID: PDy7bIHPQRuvf7e/1qyrOA==
X-CSE-MsgGUID: avmdHbuwT1e+yxJM7GcAKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115535186"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 00:52:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 00:52:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 00:52:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 00:52:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckyOc8G+dGCXAlnaj0Cp088T0sRTHmtIMPVpPFv0fCH+qglf3ITH0Szihw4SC9AJDAxzxdx3Ov8TnqQyzR6+d15UNyxdXLmN57efYzAWs5hY1G729ex5LivK38NUDegRtTlxH94eeTWdOuQM8MwWb9f75wKvWsYH7ZbsKos5P28s+2lBoNdnTEQP82prAvi43aH5Y2HQ+m58evGVydBsBIVwaMgqklM3LmOJkt1W7zIqnfdoeXkqOdHp89rAubro7E2401jLVjYxF7/rP9tUGQEHTck7cPNeFVan2XETtmDGGgj4N66ph+DdTneR9WM+RxKsiJmBgWNkCTPqjGLzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MqwAXqhw4qHCBHOInCfrg7tQpZaVBu2RIybhxcgcOY=;
 b=rx8JuBwIOPRt2c1PNjPQRwzXJ8SY9QhgLIbyngPNHaQjHGBBUGqZNKiO1FY0LbqVWJSrz8zJ8+SWJUWkrivX0sv+D37hngPf8xTXcolNzOdVaTWnFAAnR8KK2JXYLiSXVLKTIm3rlnYznw+pZPbPHZhBeXqcg7WyivyVx7osaDrcxgHns4B79F8kWIE+hRpucv5N10gBJ7nqZhf81hPEz8U0S3E7/RqCwRvs6sqtS0LHWFEV03eUzmegbOGJOVmjpk/Bzi3a4+2Ulf+tL16BZuBhDdP7L1QIapT/tHciVvfTCIbsivNllwWSMO0tKo4R43Jaa+ti3yZgYkDqowIZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 08:52:01 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 08:52:01 +0000
Message-ID: <fcac69dd-d579-4f8b-bd0d-30cb6c2455eb@intel.com>
Date: Tue, 4 Feb 2025 09:51:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/15] net/mlx5: Change parameters for PTP
 internal functions
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
 <20250203213516.227902-3-tariqt@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250203213516.227902-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0178.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::22) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|MN2PR11MB4662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c080a83-dbd0-47ad-f558-08dd44f93076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGdxcEVPUTBZREIzMzUxNXQrUkdJNGxEOWVBSmRLbkZLR0pyblVvNWdlc3RJ?=
 =?utf-8?B?Tzk3TEF4cnd1MngwR1loU2ZtSGJKR29tNnZGSGNidThNbGJHTGtYUVJpOUdB?=
 =?utf-8?B?OWZ6RGVsTk9ydzBRN3czMFprakxpaTZZVlo4eXpVOUhObEk3NVVhRFdEaFd1?=
 =?utf-8?B?N2NNSG43SjJ4TmFoaURTRlplRHM4VlFTdUpQRVYwNlF4R3IzQ1ZycThjemNR?=
 =?utf-8?B?SmZtbUhrdGRpc2QvWkVXQVZOT28wZUZGaGpiazZHQ1dlSU5SN1htR1c3dE5B?=
 =?utf-8?B?ZjJ3YzZjYzFnYkNsYVhxaDFtbzMzaXdrdy9Seit4eWFaZTdsaktRSnkzeGNN?=
 =?utf-8?B?K1MwZjAyNEV4TzBVWFhlYjlIOG13ekZ4MkFIR2dBR1Bsd2NKQ3A4MlJIbytk?=
 =?utf-8?B?NHZKWGNkL2JRM1MvWi9zOVltMmo3MGNLemtpK3haaUYyWWllOHJoMWNaOEFr?=
 =?utf-8?B?L21aZmRvejliS3A0ZFlpSmlIYUNmcjNTb213U25SdlNVRUNKRDZRbFFxVXM3?=
 =?utf-8?B?Q1VialRTZ1FGeVRoOHJLMGE2UEFYVjllNVlQYWpIM3crem5xWFRYdjFyQ0I4?=
 =?utf-8?B?cDNDTWxPejN2V1F3aVo5ZjRITjFxWXc2ME1MSkVtSnBLMzR4NXFWNm16Q0JG?=
 =?utf-8?B?OGR1TmIycEJDOHdkSkpYNlR3WXB6dXMwR2xvT3ZkYitmcHp6OUhhdmcxR240?=
 =?utf-8?B?RVppOEJteU11U3pmT0lmalJ1cllyaENwbm1sRW1zWGt5VjQzOHV6QjhZUlN0?=
 =?utf-8?B?RWFkbnorRTBnRW0yeHFiZ1ppQ3ZjYXV6WTh6cXhxeVlKYnhmWCs5UEdhbVBh?=
 =?utf-8?B?Z2o0OEI4S0htcy9hMkZ3ZGs3TW8yZmhCRzNNQnlLOUVORG9CbGUrR2RwRnVx?=
 =?utf-8?B?Y0twcUpJcUc4ZUpCQzZvYTd2SkNWT2k4YnNLaE1qV0ozdUdySi9MNDZkbEVq?=
 =?utf-8?B?N2FZVnhWME1iOEF6bWVHNVdSZU13K1R6eW10NnpNQVMvZ3R2MUo0QTNGK3N4?=
 =?utf-8?B?elhmT3JmMHdCRlhrcy9ReXNsbU9VMWJwVlV4b3RMd0JmY3M1Z3RQdGZCYmpJ?=
 =?utf-8?B?U252N2pvUm1oL3pqSXdlR2hidmNxNS84MFIwa1ZOS1h1dXFzMFNMeEh4QXRG?=
 =?utf-8?B?TkwwYllHQ3VycG0vdkpaMUQ1N1lETTJ6LzBSK2Q1ODdmR2pCZU84QkNsTGs5?=
 =?utf-8?B?SDNCVXVqUGdHYXlORkVnYm4zdnBxTUt1NWJ1TzBhOWVSL1M3ajNDNGFYUElB?=
 =?utf-8?B?eHdqakxnTXEzMlNPN1JhZ2ZoTGd4VWRodFIrTkh6WmdFSVlJWW9ILy93NWtG?=
 =?utf-8?B?MjNMNTNmc3NZd2FrdUV4Rkp2eUNTWGU2QVF5Yi9DLzkzTjQyYnJ1eG9WRHli?=
 =?utf-8?B?WTR3amNVakRuRTBJS2xtdnFlYUxUaCs3RVRCaW5YMDRKTnFMQWFtYVBiYUpP?=
 =?utf-8?B?V0crMzlEV1d4YmpqNnIxaU1ocURUV3Q2bW5zRXl5bk05WjUvK2dpeXdjZm5o?=
 =?utf-8?B?b1d5V0xRRE9qWVVpYTZkNWtCcExFMkFmOVlSQktibW9BMzBYeTRpcGlZNG5O?=
 =?utf-8?B?Ry9YQUsxM1ovYThjOGo3NkdZRGNQNnB2ZHk4RGQwb2xwdmYrZUxQbThYbG02?=
 =?utf-8?B?bFU3Uzc1SWRTZVdOc0RFeVM3dGdrYlRCRjlPT3JGMysvVUtCZ29OREtCNkJi?=
 =?utf-8?B?V0gwRDE2aisvK3hYSjlMWkZBNm0zOGFYc0VrL2s1NGMyeitZT3FRNCs3SU9a?=
 =?utf-8?B?Z1lNV01hSGs5ZWZ2TUxwOHJHTTZMN3F0VG8rTjFuTTFqdjJ4Zzgva3FoN2xm?=
 =?utf-8?B?R1lpVWMyNzZCNjk2cFdQTUVnazYwNTdmUVBMQS9pdTdMcm1UY0F6OE11dXhl?=
 =?utf-8?Q?PUgVUjatgZeo1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtadlBYUHZhOVkxb1k4U2NiTDJ3VjRzcTZXUDk0RWExOEh5cGk2ajlja0ZU?=
 =?utf-8?B?cFhtcHc2SjdNTGMzY1ltUWhRdUw0Q3JwNk9FcVc0MU82VUdBZ2dsdEtUKzdQ?=
 =?utf-8?B?b1lUTFg5eGtOeElkMmpuWVZUYjZGM2RJenZGYThFN1FKbnFaMVVrQTBRVkJE?=
 =?utf-8?B?dkJpazBuU3p4Zkg4bzFLNTJDa05lZXFhODNrQWZWbW5uRG82R00yWnRUT1kw?=
 =?utf-8?B?SkxRUFdaVVBkOFEyUVRuTmFxY2RPd3RGUVJmZFFaK3VZRFR5Nng3VVRhTlQ0?=
 =?utf-8?B?eSsxQU1rM2FrRUpMaHFzclRQelBISC9KRjNZUGxObFpoUFlxc0h3QTBSU2Y1?=
 =?utf-8?B?YXhnZ1N4UHg3YnYxU21FbStEL1pwUUFmN2J1elF4U0NqenhYT1UrK0VEVnNS?=
 =?utf-8?B?YW1FSVRzRVlkL0psZnpXbWtoalhQWStmNjR2K1h3UmpKNzBlc3JaeDJza3Fr?=
 =?utf-8?B?ZnpIZU8yRFAySHQyS0VFNmRScjM3VGFHWDdsbWwxbTRGUlhyakRDQXFuTEZu?=
 =?utf-8?B?MEUrWnZEN3pTRXZxUUxUOUlORG1LVjlRT3FRdWgrS2plaHVveENSNkZidFh4?=
 =?utf-8?B?dHlHRUxUNEdpQXBNS0ZYdW1jRlpEK0JodEt0dEoxak9iUlZRZzliTDdpY1po?=
 =?utf-8?B?MGRXdU00VXNRNVAzK2gva2FhNkR1UTNEZzg2T1VsK3R5VHNQZWdBSFZmQXpY?=
 =?utf-8?B?U2Q5K0hZdHJuVWw2SzdCV2lxRUJ6QlY5MW0vdW5UY1NJMGkrcExLMndKaG9u?=
 =?utf-8?B?RGpHaTYwYW9lK0ZXcnpqSGgwcjExVXJqMG84U2IwWHlab0lFUE9SUkU0Znk1?=
 =?utf-8?B?Z1IwUVJvc2ZKYjVrUTgyWG5vQWk3Y3VvbTAwOGl1aldyWVNSc3Q5aWpYSldt?=
 =?utf-8?B?VlJqcFJHRk84VFB6cndsdG5Ndk1mdHk3ajJVUllPRjdRVFNTWWFxNVA4d3Zm?=
 =?utf-8?B?V0VSWFRuZWRVcXBnZXRLQ1cwcGUvSEVuNmg5NVEzS2I0TmIxaTRVNFJYSlNI?=
 =?utf-8?B?MWhXQUJEYmEzWEwra0NlRGdjRHp0OHU5MEQ0RkVzR3h2TlI5VXEyMk5mRGRa?=
 =?utf-8?B?UXpycWR3MUxUNGNHdEtGSjJZWGV5Y0lsMThHRmJpU1dGZ20zL2ZDYUVwaVR1?=
 =?utf-8?B?Rm1KRmsyS29wSUVUdER1MjNUcEgvTmMzUVFhQ1hUMzJtQzNsY0E5aTFmNmdV?=
 =?utf-8?B?NVBMTTVrRnl0UEhERk9zYnlPV1VaclhBdzdvR2szSDJYdkFLcFlsOUkwekJ2?=
 =?utf-8?B?MGVvLzZuR1NnWHlwKzFqK3h4OHRDWlhveEdCbE9XMXlrT2syYW0zOHo1b2tm?=
 =?utf-8?B?OFdzZmhqb1dRYkRmZmU2dE13Si95Y2lialZuWlR4RTNISWg4endEZHdoZDdL?=
 =?utf-8?B?akQwSTNaUTdBV09DRmllcGpQQVlydTNhNVN5SjFTNkRXR0U1MUJYTVN0S3E4?=
 =?utf-8?B?ZW14U21QdUIycjcwbHZOZ0tSZGsrQTE3WlJPSHhkYXRLUkFVZVNXeGtSQ20w?=
 =?utf-8?B?akc2dWhpbkViTUkxTTc1Sk5yYzRyOFd5S2lJL1Zlb3VRK1VsL1dIZzBmV3Nz?=
 =?utf-8?B?T0ZwWDZyaUl2L0h4cjc4SWZENnh0RzVGa3FPVGRBc2QzNE9Cc1ppZFdpZWN6?=
 =?utf-8?B?QjE3NEVoZ2JsaXl0OUNmNExpWjYzT21VRG9FMDY1TXRDRVZtclU0ejQ1YzBw?=
 =?utf-8?B?a0tlQmtTUU1HVHNHcHQ1eEhIbkRYRHQrWlYzSkhnK1dseFpSTGxJTzJKRVR2?=
 =?utf-8?B?K2R0K1FPNWY3NzFyVnFOVk5nL2E4eEk5Mm8rMDJNa1U2VWFXMmNWQVNDS3g0?=
 =?utf-8?B?MTVvV3RYbCs5VDk3WG9udE55ZlkwcVZHNmVMTEE0d2FkVUo5N3pTVkVEUkJY?=
 =?utf-8?B?WVVhRURuU1F0T0lLOGtlUFZpSE1mM2JNeHg1aGRNZE9CMWovT0lDbUJiN1pZ?=
 =?utf-8?B?bVEvbmxxcE10M2d2MDlzQXRFKzRaMStUMmNrVHREckhaSFo3TUwyclRNUUpQ?=
 =?utf-8?B?YWpia3dBVHplTUR4SERkZjBCbEU5QnRyLzYwSHZVdC8xY2FUZG9lUW9rNjlU?=
 =?utf-8?B?Mmt5M0ZaQWhCNysxVTdCWjc4dUJpTHRZNFcyZXhZcnN4U3JhMXBBSmowbm45?=
 =?utf-8?B?VG9rZ1pKQmRIanRnajZwaEFXc3duRFVvVENiNFE2OFdOaXhpWnlweU9WenVJ?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c080a83-dbd0-47ad-f558-08dd44f93076
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:52:00.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+ZOIIbDzYnaNUp4dpRYu7QB7WmzbFHHt863J4ErcK2OG79uFrU9UxSrrmrW9OUklxu4TwsZFHYfy0nygizaJM6CZJYEeehg1s53nENyJOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com



On 2/3/2025 10:35 PM, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> In later patch, the mlx5_clock will be allocated dynamically, its
> address can be obtained from mlx5_core_dev struct, but mdev can't be
> obtained from mlx5_clock because it can be shared by multiple
> interfaces. So change the parameter for such internal functions, only
> mdev is passed down from the callers.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index eaf343756026..e7e4bdba02a3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -878,10 +878,8 @@ static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
>   				    mtpps_size, MLX5_REG_MTPPS, 0, 0);
>   }
>   
> -static int mlx5_get_pps_pin_mode(struct mlx5_clock *clock, u8 pin)
> +static int mlx5_get_pps_pin_mode(struct mlx5_core_dev *mdev, u8 pin)
>   {
> -	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev, clock);
> -
>   	u32 out[MLX5_ST_SZ_DW(mtpps_reg)] = {};
>   	u8 mode;
>   	int err;
> @@ -900,8 +898,9 @@ static int mlx5_get_pps_pin_mode(struct mlx5_clock *clock, u8 pin)
>   	return PTP_PF_NONE;
>   }
>   
> -static void mlx5_init_pin_config(struct mlx5_clock *clock)
> +static void mlx5_init_pin_config(struct mlx5_core_dev *mdev)
>   {
> +	struct mlx5_clock *clock = &mdev->clock;
>   	int i;
>   
>   	if (!clock->ptp_info.n_pins)
> @@ -922,7 +921,7 @@ static void mlx5_init_pin_config(struct mlx5_clock *clock)
>   			 sizeof(clock->ptp_info.pin_config[i].name),
>   			 "mlx5_pps%d", i);
>   		clock->ptp_info.pin_config[i].index = i;
> -		clock->ptp_info.pin_config[i].func = mlx5_get_pps_pin_mode(clock, i);
> +		clock->ptp_info.pin_config[i].func = mlx5_get_pps_pin_mode(mdev, i);
>   		clock->ptp_info.pin_config[i].chan = 0;
>   	}
>   }
> @@ -1041,10 +1040,10 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
>   			 ktime_to_ns(ktime_get_real()));
>   }
>   
> -static void mlx5_init_overflow_period(struct mlx5_clock *clock)
> +static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
>   {
> -	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev, clock);
>   	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
> +	struct mlx5_clock *clock = &mdev->clock;
>   	struct mlx5_timer *timer = &clock->timer;

It seems that because of the refactor the RCT rule has been violated.
I think you have to split *timer into two lines.

>   	u64 overflow_cycles;
>   	u64 frac = 0;
> @@ -1135,7 +1134,7 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
>   
>   	mlx5_timecounter_init(mdev);
>   	mlx5_init_clock_info(mdev);
> -	mlx5_init_overflow_period(clock);
> +	mlx5_init_overflow_period(mdev);
>   
>   	if (mlx5_real_time_mode(mdev)) {
>   		struct timespec64 ts;
> @@ -1147,13 +1146,11 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
>   
>   static void mlx5_init_pps(struct mlx5_core_dev *mdev)
>   {
> -	struct mlx5_clock *clock = &mdev->clock;
> -
>   	if (!MLX5_PPS_CAP(mdev))
>   		return;
>   
>   	mlx5_get_pps_caps(mdev);
> -	mlx5_init_pin_config(clock);
> +	mlx5_init_pin_config(mdev);
>   }
>   
>   void mlx5_init_clock(struct mlx5_core_dev *mdev)

Overall if you fix that RCT issue then feel free to add my RB tag,
thanks.


