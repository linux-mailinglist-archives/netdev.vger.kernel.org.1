Return-Path: <netdev+bounces-174100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA5A5D7BC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA2E18971E2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976722E40A;
	Wed, 12 Mar 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDJiH6yH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80E22611;
	Wed, 12 Mar 2025 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766588; cv=fail; b=aQeu6aLRFHjZ7H28MI44TGcd2Z3izXzZ672M7x7gO0Dw2+9RtCEubyqiZt/+uHJpos0v6I+tEjfLOJ8YoDyGHcpGKFE+nLHwge9IHPJtl4D8nVQGMh960d7Y8q8seEFMZI0V5WiZd7Ef+eheWAgl9FpdALc4yyuo7cjfBv6yfKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766588; c=relaxed/simple;
	bh=LYV6M80De7O7+dIwmc/3Y51jKKcOJciOO9ddVNx8vAE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gK6LnJl/KHFWQWDctYBPhIic0szPFtcjG5MhNUz0MS8rkZubFN9uXCXNMNz2+LnIMmIKDCeNo5bHt6lHHIJqwVmVfTCn+Adejj6btPAlSnDATQWwrWOTbcS7jNAIx99JgqdLP6T9u9cgajdi7n0ZUxF4h4dELtPDhUgjxu0Xye8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDJiH6yH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741766588; x=1773302588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LYV6M80De7O7+dIwmc/3Y51jKKcOJciOO9ddVNx8vAE=;
  b=LDJiH6yHssEuK3+2U+wvKQKgVJnIYKyL2ZbXco83USq1VlrRJoVYWWom
   KNfJLBQdun+WCPoIRRWFJLyqxXvWVNbj5bMO7sZS+Mmtv+vLvnjswIlEo
   +Dj3PMDxpGl/kSj1ikwLN4rFTNRFIgJn8rsCVZDxvOE1yTW0RiCI0K4ow
   SidshKpASnZbsOxg+ZRJBF7YOm0A0U+Xhe12+upP03lmBTDSedt/+KnKF
   uTqZPURp0q+9GSx65/OX6xVKUhtrSt7QY0iSTeAONI/SDaXs5xZ/X1l58
   TuUkdlfW2xXlmWFaAtBcZ72JZQJ+J2EvxHNuSVFHmH+kpQYKotuuPkl80
   A==;
X-CSE-ConnectionGUID: lKsLL3GnSymnRpjR3fH0rA==
X-CSE-MsgGUID: aR3HCNqOSCOJ2iziytSP6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42688517"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42688517"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 01:03:07 -0700
X-CSE-ConnectionGUID: 5Jc5ySYYRR+5q0HEYpydbQ==
X-CSE-MsgGUID: AOTyP3+4Qi6zHEuDCOTYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121048072"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 01:03:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 01:03:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 01:03:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 01:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAXOIjLeSIzTWJKI/Ln8WK483Nm3OHhyJknAQP3StvFZ29yoD/v2rY5xH0G50Fg6dQq6dA+E3vRp+FMUgppsYnnCPvbbpKzwoBoKmspgh0nmNrtoRWQbejoMcGI+z7L73gtBZuXr6c3jErvR68SfpUg1v6GtKIA0NCLwxqnypykkReJmjS+2p8rMVr2WxShfd7GX3cMF3cjKiRjVGcG5UxSDMRrDZjiJQ8GClwsTP3fsVPpYokHmZ+2uqE3kfi0ZIKL9MirDbj/aPA8lFyv9HbzNwaGXalhiuKrb0ZnABBEEfaSRPyzZbxNkzxpjjvtLhWHoNSZUoBGLDaymhg6f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flEA7j1Qq1OdTQ5eOTPmpdaVSovR0MBjnOr9vc/YHg4=;
 b=UTuakyWTX4DJbc3DsycQ3qrqj5d0znBSK946daCusVNrTiMuMH1lXnA2zV8nrekHy457S6PIRCjFN2olpNTQ4mRXAeGdnG5I2u4uRal9mf6yJ3jGBlsRhq8buhJBeTV3GRJPbgNzG6CAxqUsZ/IUbD4lWkyXwIDx+fu5MJgpoT9I7tfGIjLcX4COqM2hpIPA9zYjJkbgaZWyANJ9kK7AighGop55ew/bnkzuyyBONf1mDT32tKRK7xnF61r9dql4ksZUVLBZk7Sm1ydzOjIQyk2TfIMUWVfkCqloj5IpzE1jKnWd5mzYnGqe00UtFpuehYIzLgWfCK+UHtK5kEbA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:02:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:02:44 +0000
Message-ID: <2b9d0a66-5e8b-4c28-b2d0-0e6e03a075b7@intel.com>
Date: Wed, 12 Mar 2025 09:02:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: intel: Remove unnecessary static variable
 initialization
To: Joao Bonifacio <joaoboni017@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20250311221604.92767-1-joaoboni017@gmail.com>
 <20250311221604.92767-2-joaoboni017@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250311221604.92767-2-joaoboni017@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BY1PR11MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e076540-2cc4-4ceb-afdd-08dd613c4524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2J1azRoWGFjbml1R2hVUEZ6aUI2cm9xQ0V6ODdHd25PNndLWlU1OStFUWpk?=
 =?utf-8?B?NTV2OWVYWkZxWkdOT0VLdFFCL2xKNkpzeDA2RjFzZjNta1c0WWtudTRVMnAz?=
 =?utf-8?B?V3FjdWJ0UUlQcjRPQUFrTkN1V1p5WTlkUzgvTytsYXVlTnc3R3prdFNBMlJE?=
 =?utf-8?B?cFJtd1N5bUNwYURNT1NDRjlrOElqNDA4eW9YK2RIUTlBbndkb1Q5V0hmcnp6?=
 =?utf-8?B?a0FJVVIvZEJ5d3FSWjFWc05JQm5QRXhmR0V6cDNDYzg1cEVlVFV6QzlDZTJX?=
 =?utf-8?B?bDRWTC9QcmxoVXRxcWFGTllwM0tzczhBUTBpVDZmRm8ydEF4SXczYldNYW1O?=
 =?utf-8?B?aWpUMFZRbGFWemM0S0RnNUJYM2dacXNLVkZLRExOR0xqRFFrVUtyaWpCU2Jj?=
 =?utf-8?B?dkZtTzhJZGlVV0tRVXFrOFpNa25lK25RVWl3b09DRGlXbURSeHJMV1RGUXk4?=
 =?utf-8?B?WjI4cjhBNzQyNTBBWmNMRkZJSG1rR2Z4c1F0OTliNG9keG41MVppSXk3MnRx?=
 =?utf-8?B?KzlKczFZSEhrRUlPOXptTldNdDBqMm9KUmhvbitXclpISUNOcEFHekF0TlQ3?=
 =?utf-8?B?cHRUa1AvM05JMlJmV1c3YlIrV0d6Sit2S2xib041QUh3MFV4THdVZzVBb2ZY?=
 =?utf-8?B?OFVTdFpHd050Q2UyTkNDc3pYVFpzZXFnOXBaZEpvY29VSWJ3cnhVOHlxRENM?=
 =?utf-8?B?QjA5R09sdFZVdHBrYlZpNlBhaWI0d25MOE1uWjUvbUYwZjdPUXR0cUpSS1VR?=
 =?utf-8?B?TVRmVmp3NEUyMVdIOVJxSFhmK0Zjc3N5TWErd1YxOXpQUkRTV2l6bERUQlpU?=
 =?utf-8?B?NElmMUUxUW9wZ0tsVFZHUG9UNEx1MWo5enhWNzN1dGJlM29TaitUT3pkSEpz?=
 =?utf-8?B?L0xWby90SktqdHNWTHU2VUVhQlRmbENyQ1c4TkoyZVAyMW1aVWpDeFoyMGtZ?=
 =?utf-8?B?cXFzeS9ZSmFPT3R5K2YwUmJlbjZpZWZiaVJVOVVCcUV6LzQ1eGg5NGN3U2pl?=
 =?utf-8?B?MVJZNlFKNXN0SGxEZUNvMkxWVVVJN3hxbUVqWTY1Q3ZBb25EdVRmenplWTBx?=
 =?utf-8?B?ODBFUyt4RDdTQXdDQUxXTGhJdHFBUDlpYy85V1Vydi9KMTgxcG00NTU4dklQ?=
 =?utf-8?B?ZGFQTURsamtDUEoxS3pzZTgvV3JVdlhDandQUThmd0xhdnZrUTVhajNmbmJh?=
 =?utf-8?B?MEs1eW5XUlM0RjF6N2pYc2d0eWNQL3lWQlNEMy9RWmpwRW9KbzAzV2xSVzFI?=
 =?utf-8?B?S0c0UC9FTTZtR3JlODZTaWs0RXJpNlZadDFVQ09pd3lsNEg3d2xGOUI4VmhB?=
 =?utf-8?B?UUllOFBJcVlSNGdXNTJkMlUxQllMa2tsN2RNVFA1TEtIVkdHZGRUUitnOGhm?=
 =?utf-8?B?Y042UDJSbGtNalFvelZPd1JRWi9nbG1iN3pYdlQ5TElENjV3MzV1bjFBOW5t?=
 =?utf-8?B?dkszOXpjWUs5SHh6QXNVczdWMWRHblVEYUlkSCtHOGcza3ZRNzFEZGhDR3Zy?=
 =?utf-8?B?OFZOenEvcjB4RUk0TXdPR1o3VlVDajdOOG44UlVYTGpMTVVxUHEvR3lZYTFp?=
 =?utf-8?B?Qmo3MGV5eHY3aXZ6S1haUk5ET0lnSTMyaWFmZlZsLzRQZlBvY200T3FDanpW?=
 =?utf-8?B?dFJ5MnJ6cjVmcUF4b2ZZaGdaMDRscTMzU3pJUWk4Q1FCWWhsN1JvK1FUMmQ4?=
 =?utf-8?B?YlNEYzZaazRSK0xpb2hUSmErZ3FNNDRRc08xeUZ2OXd0b3NzWDFjWG4rRldN?=
 =?utf-8?B?VFI0WEUvS0RhQ1NHZzJhbVBseHgra0luNEdNNDUzUjhtRFBPNEl1OURVUE5n?=
 =?utf-8?B?TDAzb1NDbkNxVWhLdWRadz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJYTDVYY1R2SkdlN2l6Q3U5R1UvUzVuUFhudlIwQ0FSYnBmT1N1eHJqalpJ?=
 =?utf-8?B?VFlnT1pQWDRSYmU2VGx2QlQ0dkdxcWFLMTBFSzRIV0hicU5RbUY2bGpVZ0Yv?=
 =?utf-8?B?eng4WlhhSHh5VHBGdTh1aEd6R1hCbm1sSjkrOHFSMUpwVWlzdjhPKzJ0Y1ZW?=
 =?utf-8?B?aE5LRTcxdmcybGtodm1DTzIxY1ZWNkxnVmEyN1dEb2JQZHNoWXR6bzIxNXJ1?=
 =?utf-8?B?bE1WM3FMTEJvb3lsd29TVVV3ci9VdmloUGthVWJQckM1dDZpS3VvcjQyQnIz?=
 =?utf-8?B?K1lIVkc1a2htTk5JZ2Y5U0hGTjJuRWpRbi9TSGNKbGlTaHZLZnRzckl5THBS?=
 =?utf-8?B?bVBVaUVMTkZYeWdSKzRxWkpuUUREaytMbisrY1ZsRnNLSXhZdjkyRk9YTkxF?=
 =?utf-8?B?RVFReG9aTUVrRW9ReVdYWlR5VDFrUDBlVmNCUlgwWEFEL1BLbHJQem1uUmlk?=
 =?utf-8?B?TFNBLzB2L1N0VFdDWW5YRXZvZ0J5a3lOUGNxT2RZZ2RCSmVvTW0zOGtIWnRw?=
 =?utf-8?B?ZlV5eWpUdGM4YWRmQXF3S0I0YkhhajNGTHloTnBMdjI4ekN5dEl3dW1DMzZD?=
 =?utf-8?B?UU5BbzFnU0s1dVprSVM1YlcrY2JVN0I5V0d1ZWlFOThlVVp6Y1RDMHdaQ0JB?=
 =?utf-8?B?UlVQUmhoNWRZZkx5Qm1MZjFXSnBtYVdndENFVTJKbXJIZWtNNC8vRjFsNzZX?=
 =?utf-8?B?K2E3R1hNMElNTzY3Z0lvdTdlcEZ3bVRxTlExVDBNeGV5M01MV25RUlBTSzNC?=
 =?utf-8?B?cFVWYWhZOG5SK3cwdkJqakFXVkNRYkpTUFBRODJwL2lEWFhQbVJGRlZPalZF?=
 =?utf-8?B?c0JUa2ticHZDdHROMXJEakYyc1JGN3Q1d3VZMEFPNWtyOElZNEd6UUtsaStv?=
 =?utf-8?B?UG9yM1lUWmY1K3Nhemp4Skx5TmdKaDRJTExrajBOdldDTzMvNE5mYkh4bkxU?=
 =?utf-8?B?Yi85VTdXNjl1YmlzTHliMFNiT1ZDSzVmSFBCS1RoVEI5Mkpqb0RSWUV1Rkpj?=
 =?utf-8?B?ZmpsYnNycDdRaEkyVWRUeTFBRlhBRHBURHNWYW9jbVZZbC9qV3RLY3V3ZkpI?=
 =?utf-8?B?UmllQVVtSlp4L1BDNHNJeTBmeHVoZk15UzRod1RGeW9EeWc2ZjNnU1NXbGVj?=
 =?utf-8?B?RlpwbjBzQitHQXlCc0NqUTQvUGMvY054d0JIeUxSZ21FNE1PRExsMDJRRnZ5?=
 =?utf-8?B?UWpHb0p6dTFtamthR1NZWmFSOFcwT2VXcU1JMVRuWFBGN2JtVFRsQW11cmdh?=
 =?utf-8?B?dzdrcTdXQzNkQ3EvZ0NBZzcwRkdqMkpmc2ZEdGZ3RXFRbVZRWG5SUzlDU2NV?=
 =?utf-8?B?RWF6bmZCNEMzeEpsVnFyd3o2cWs1cWl6SDBIaDhmdzRCTE1kYXVRazJQd2Rz?=
 =?utf-8?B?V1ZEMGN4NldzOHVOYUtoNVFwdlhvNVIyYVIyem9ibTdtNnZiTDhDU0IwcEli?=
 =?utf-8?B?V0Era3phdDRBR1ozTC9KOGtkckxuOGpuNnZwb2hmT3k2RHhOdUhmUTFwNFQ0?=
 =?utf-8?B?OFgydW1GM1N4SE5waGFuNE1wcUhRVWx3NGNTVjFoZTFNcmxFbnc0b2p4SExw?=
 =?utf-8?B?ZFRNQXJxbXZxbDY3by9tZTIrQXM0SC9UTWZEYzNmTXNqSUVXSmFFOTM4WGdE?=
 =?utf-8?B?Tkh6K0ViUXpoa2JhNU9MaVBDQWZvaW95NFJDVndENi8wTWplSGpMd3gwRTZl?=
 =?utf-8?B?Q2tEeFBWTjZHRTJMUUVaY2ticE1Ib1l6NjZUM2E5cXdkT2VhZTdtL2FCU1ps?=
 =?utf-8?B?ZTJQOXNESHdYZVorRE5xdTRwOTFsRHpSbUNnT2dGaU81SU1RSEtFU3N5UjN2?=
 =?utf-8?B?eWJGNEltZWZuNUE2RzVlWis4SjJjZ20zQSs0TSt0N243MldybGxGSGxRejRr?=
 =?utf-8?B?MXR1M0tRaUlWd3pvOUtrTkVjTTJUK3NmaldFTS82WG9kS3QvemswNmdHRjhP?=
 =?utf-8?B?WHlCN3FJdW9KZXowMVl1K0NPdkNSMllNK3d5c0h4QXFGQ2YrV3luWW1lR3lP?=
 =?utf-8?B?WUtvUk5MR0dKN1p3SklzaEZpZ1NCMkVoM1liQ2hxMTRUaWJxS2d4Mkd2cE5a?=
 =?utf-8?B?eTEzT2FZSFdiYms1anJWdk1oL05pcVVkNEp1cDcvTlJlYldwMG9KbkcrQjlQ?=
 =?utf-8?B?UjNiVlJ2SXUzSVE0Rit4cStYTTJVWUwxMzRBS1k5bTRiclk0VGZEOGpNVE1E?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e076540-2cc4-4ceb-afdd-08dd613c4524
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:02:44.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiGc6OPOklWChA0p6tTtR12jbPSPBow5c8obvHyB43qtH1Mja10vVo/P8r/WKoVPwWWVv3JwZuXTcv2iMlniSTfYDAEm3pPao17cqgXhFHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

On 3/11/25 23:15, Joao Bonifacio wrote:
> Static variables in C are implicitly initialized to zero,
> so there is no need to explicitly set
> and  to 0. This change removes the redundant initialization

Thank you for reaching out, and sorry, but this change by itself is too
trivial, see:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

some feedback anyway:
the Subject line of this patch is too generic
whitespace formatting of the next paragraph of commit message is off

for networking we tag patches as "net" (fixes) and "next-net" (the rest)
and in particular for series that are mostly Intel eth we tag instead as
"iwl-net" and "iwl-next"

> 
> Signed-off-by: Joao Bonifacio <joaoboni017@gmail.com>
> ---
>   drivers/net/ethernet/intel/e100.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 3a5bbda235cb..f5d32663a89a 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -167,8 +167,8 @@ MODULE_FIRMWARE(FIRMWARE_D101S);
>   MODULE_FIRMWARE(FIRMWARE_D102E);
>   
>   static int debug = 3;
> -static int eeprom_bad_csum_allow = 0;
> -static int use_io = 0;
> +static int eeprom_bad_csum_allow;
> +static int use_io;
>   module_param(debug, int, 0);
>   module_param(eeprom_bad_csum_allow, int, 0444);
>   module_param(use_io, int, 0444);


