Return-Path: <netdev+bounces-110631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695092D9EA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2892B1C21253
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49018FA17;
	Wed, 10 Jul 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnisRtVn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C826198A24
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642508; cv=fail; b=dWobKzEt9SZhFCCHlcGKj9VAxMNTu9178A9AOXHUgff3+NPgJXyAhJYE7DbuNTr4YPbLfYwVlTkHjFWAsHkRkIqTLmsDKtEnvp0D1aKuCP8Evf8rrL4NDINSJNtCW8T0W3Lam/ohQGa8Zd5hIPvjZIiHKqdjlG5WuVdtS4e2LzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642508; c=relaxed/simple;
	bh=jYTmwbGj3DCc074WWfUp0HN3khtSyJiLjXKmyB8A5r8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ELnAB0tZ8Hwy9/mP0t9s/s4U7iOEEpx5dQt+ZvlRrobnFcASsydurvU09yG/wl54XyRmwkDPj9S9O3lTTVhG2uobTeDtLSP3YbX62d+6vcbodCPMReKfSAaimkLCnrlRo34eaXVvR/IuET+VZacsf3vie+Q4/0F4NqSSt2gW440=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnisRtVn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720642507; x=1752178507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jYTmwbGj3DCc074WWfUp0HN3khtSyJiLjXKmyB8A5r8=;
  b=AnisRtVnHnXf3so0vPK2CVZEQ1o9p1ETJWQUcqyHkrMDeqiiRlI5mpH9
   xZ0Jh1ml2e+K206HMw21owEbAvpxE/ixflDPWnaltJy1OfldpAPpak0lb
   GF6A5RREYSIuItaSPZ1fSoatV0jMFjGEqTExNcWHYOfogsVwiO8u0kN/k
   Mt/jwSo5sgGSLvJF61gYMB4MiuK5gKHlwpIDa37wVl6hhLwkhAMwjUIOE
   LdkkmeRwL94FyWqoZc+GlZafaem0kpoq+E8JwyDom8XE69V8hiAl0GWBN
   oBMaYT95IOdqLvv+MFKh7W+pilDmINNzFTOUeFJxLZ+74ACgjhLzVJ2SK
   w==;
X-CSE-ConnectionGUID: nZMGYj8QTzGg3J6TledJ9A==
X-CSE-MsgGUID: ApReL+DzSDaDJuzmh+PoOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35425261"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35425261"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:15:06 -0700
X-CSE-ConnectionGUID: ao8pzNgbSQeBuJkJ6FDdTA==
X-CSE-MsgGUID: K/qdvSkvT4iGxT5CPL2RsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53274208"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 13:15:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 13:15:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 13:15:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 13:15:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 13:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EODZMryprlh6G2XB5UI4ZJBNR0PW8jjYZG93NEE6qQe45uedMJByZHrrSb1zFgVOWXkMHszViLXuY4LHa7QVkNb/otj4/GFtFb7GKTQB6Db+YWsNrWy6P2AH2VdSDpqS95xMsFbvs6dTnsLzWMrFqoOh7jJklZi2hOAJevVLTPtSFKvv1zb7DRuuF8A2RCSu0fyJro9w0vCq9ZS3dKUyOEULlv22YJcFd1oh682MqlMzFG8PRrUu1olww5gNKuTqlqpK9Puq0XFMpNJT11HPm6Crw7xVTHkcD+OjqdyFo9n8Xblhgb/T9vRFtMQpG2bWwInVhdQvQa4q7GxXitMNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqcvaXFmYGqBBhqHIkWB6gW1mjlg5RYNWirkYaGTtAU=;
 b=d2COS04sh5zyFsTgfVKX0cLyQ+xYli733HSF2OjyGSK8cln0TdVldpXnRknzYoLyMLPQmgnL7poCMlE/tXDRGi8MmXCi63hPvQKU+EmLuSF7FZH8Lsbni6HZ6qVysR24k3DhflZH5sAFZlOMpiySLLe5+znE4IPeeSCMam1/eYzN9kWMk0pZADfj6UAdrMq+U8yyN70nBB96TOkaz3IAcLVHf1ZM8D2eDQVQNudaA/BJ4bWDc2gmpIW4LG12fpKTBgOYXBACmL1a1e0fMDjKV3l6XUiQnd73p61s1iwzSg0/BDNL5PW8oy8FFwTJpSIW2XRO/ekoH936wxakPwZVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 20:14:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 20:14:58 +0000
Message-ID: <f1673a26-6379-49ff-81de-0b703a6fa3e5@intel.com>
Date: Wed, 10 Jul 2024 13:14:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ethtool: use the rss context XArray in ring
 deactivation safety-check
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <ecree.xilinx@gmail.com>
References: <20240710174043.754664-1-kuba@kernel.org>
 <20240710174043.754664-3-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240710174043.754664-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ea5250-b3ff-41aa-7e40-08dca11cf86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW5ySWhMeWQxOVFTWjNjQVoya2JBSGs3WFV3dUpoRm55cit5eCtjbXdSd2ow?=
 =?utf-8?B?SXdhZE9sUTZwWU1zOUU0Z1grQ2hKd0ZhWDVEWFMzSXo1RDVYcTAzMTdaaHEw?=
 =?utf-8?B?Nlc3YjN2cVZJc0M4bHJHaURyWDVLMDBPaXFCR2F6SU13dWpSam9QeWRaQ2hP?=
 =?utf-8?B?S3B1MjZ6TSt6UFZvdnNaN2I0ZzQ5MVhyS1dHYisyUFV5c2tIWGxRbTdzMWhW?=
 =?utf-8?B?VlF0K3M1L0ZzekoxcXVncklTbzkxOTZMZHNtVGhyUzg5WEhKS2FibElCWWxu?=
 =?utf-8?B?R0wrOCs5QmpIbUkzUHpMOFcvZ0FOeVBiQmNJd3hLQm9TK2ExWGJ0YVIrVjFO?=
 =?utf-8?B?VEZuT0VoYnl0MFN6RjhxSzhoNDNGR3pxMGl2UDZ0YlJ3Znc2RVhnMzZ0Vkha?=
 =?utf-8?B?UzhQZnZPejQzdDNpYWJ1allhY21pNy9ObGtkOXdvM2wxOVl0aXkzbWJqMC9M?=
 =?utf-8?B?d1lFa3ZKQ1RrWnRBRnIwbjFmQ3JpWW95VmtQSkhaUE1OTGEyU3M2dDJNMmli?=
 =?utf-8?B?b0hCZXNvV0oxUHFFQllxOS9TTVptUVBZRE9HQU9yOUhxVDdEOC9mY0NsYlJ5?=
 =?utf-8?B?UGk2V0Rwa0U2VEkxRWtpa001SG9lZHJ4NWU3WGNEY0dJNHJPeGZoYklWd3ow?=
 =?utf-8?B?TkNrSUJmcTJqcU5UL0REUlJXTjVxdmxTSHhLUXdGNHphd2NIbFFxZzRsZlAr?=
 =?utf-8?B?VExlYkZ4WVFjUFFVZVJmS1hwam5SV2trd0dVbklZNUdXSDBsdHl5bEdpK0Ir?=
 =?utf-8?B?ckhscW5ZNXN2QXhETUx5cjZlWDhpUnZMUUVGQ3k5YU0xTzRJaGdseXFIN2wy?=
 =?utf-8?B?TjJtNkt5UXJlQmZFRUhidDZlRUs0cC9YRnhYRndSZ3ZRNHlieFpHWExNRTk1?=
 =?utf-8?B?Zncrd3ZYODdXTlJyYTBPMnhrRVRGVVV0d0Q0aXpzaVZJbURoNUFVOVZBaXAw?=
 =?utf-8?B?V3NqMzVQZmVFMUY2TWZMLy92VldUZDRSdnd3azVlWGMvb3p5ZWFFOVVSYXZR?=
 =?utf-8?B?Y3pUU3hKVG52LzFxWnByaVdzVTNwTFlid1hVRUdPb1hNNkt3UTBzeFo5WklZ?=
 =?utf-8?B?ZGx5WTljZitIYzhPNG5NaW4yRVgvVXBzRTd5ZXpPZk9XSG1ySHdDd3BCSVpY?=
 =?utf-8?B?VERyQ29oMUtYMVk5aS9ROTIrZ2hHa1AzbnloTk5aS3RSaC9HYWxabjJScHAr?=
 =?utf-8?B?eWxESnBoM2sxd1VmZENSS3BSOExXajB4ZXY1VVdZb2MyYWszdEJDYytRTU9i?=
 =?utf-8?B?cnRJRWw4Y3VlWFA2TDFrSlZqemROZlhkN1l2MzZwbFBtSGZKb0lQRm5MQVhT?=
 =?utf-8?B?NmNqMm43cjBhMThjanNvdGVhTUUrY3ZCMnFDdmRnclBzSVIwTUZkTTEwVWtp?=
 =?utf-8?B?WkpuS0xUVDJjNENINXpjcUxtNUhXWXNac0pvMk5QeWRDQjRBbjJSY2d4WURY?=
 =?utf-8?B?R1B5NUgzOWpDRDdodFhDL1JvTUJTRlc4TytIWnRKM3VhM01ERGVWbUp3OWdM?=
 =?utf-8?B?VVJncWowVHRPRUwxT3VhSDZuSk13S05lOG5QN1VvZ3d1d3dJQzJhN0dUZThy?=
 =?utf-8?B?enVtZXl4ZTF6dTVlSEw3MUt6NzZTaHFKeEEvNzVhaVFBdGJHdXlMVDJYRFNw?=
 =?utf-8?B?ZXR3NmRSRklrN0FDa3ZUdE83K1FnSFBaSWJMNThTQTN4OW9Hb254OFZrMG1O?=
 =?utf-8?B?SUhtbDFmODEyZkZib1A0a28zQ0FNd0x1TUxNRGhvNG9mUVI4RHJ2Q2RvZTM2?=
 =?utf-8?B?S2tnaVNVM2FyTFQ4M0hGZHBtWVNHbFZwMmFvKzVETXVrL01ldDlGTUNBdEpN?=
 =?utf-8?B?QUxJTkdKTmR4ZENDYjVhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEg0NUxudW5YUlAvV3Q4QlRtam8xRGltL0R2L0VoUFY2V1N2ajFzN1JTN0pB?=
 =?utf-8?B?OU9CbkxvOC95RGVHckVURlYrQUdOZWE0RWtGcHFXZWQ3S09vaFNsUG1TZHNC?=
 =?utf-8?B?YW9iNVdwdFk2UUNhUVIrdy9OV0JZZjczc0JoU0d0V3NwRTlFTFZZMEJKOVov?=
 =?utf-8?B?bDJiNm9BeWUrQnBNS3FCNXlsYW5FZlpuN1VpMVRKd0hiSDJmN2UwZ3hOeExI?=
 =?utf-8?B?WEVqdWt4SlJSaXR1QUE3NEZ3aHQzUk9SOEJkUHBiN2V4V1d5V2hHODdTNmlx?=
 =?utf-8?B?cnRLQk9rcUFLSURmT1Z0QlJCZGptNFRqWTY0Ry9PcWNoODNHMHBrNk51d2ZE?=
 =?utf-8?B?M1J4dTN1MFZ4M2Qwb1V4cURoUi84MndTNXJIa2FNWlViL2VWcGs2b3BNLzl0?=
 =?utf-8?B?dXFEVEZkRVV2b1ZPcmJOU1lVdis4SklGNmJMejh4SlNkSmF5YjlBOUhHSUJ1?=
 =?utf-8?B?YWVBWXpNWlpFMGE4TitxUE5mV2VneVBUSS9WQUFrU3hNWTV1ZUdOM01BaEt0?=
 =?utf-8?B?ODVHVzEzZEZpbTdTcFk5cmNUMDh2SlFyNnRKUyt6MGJJS3g1TkpFU0RsbTRS?=
 =?utf-8?B?aFhNS1hyRE9lNFJVR1VLN3ZXSDlkYXVseTRYVzhUWWdOaExYa1U5OGxjSzVu?=
 =?utf-8?B?OGpaWWVjdCs1WjlUTlc0VlJZNFFIUFEyakxPT3FaTU00SUxWcy9CMkFWRlpy?=
 =?utf-8?B?Zi9UYmRDekx0RmxHNHJ6WnhrRExMdXZUU3NnMFN5U3RDdE5nQ1h0T3g5dzZJ?=
 =?utf-8?B?eThBSTFycVJLZ1NHY0dOTVE3MWUzZU1aSU50MFhXcVVUVnAvaEc4dElNcG5m?=
 =?utf-8?B?SVA4RHZNVDNrSWNnSWhlN3RycmxyQWhuVzhPVnJEY0xYL2Y5azgvMy9lK0RK?=
 =?utf-8?B?TTNWekVzWjM3QjJaV1hheEFMUUI3cWc2RWIvMUozbkkwcklYRXUzYjlQNGhY?=
 =?utf-8?B?RklxMk5PVGkwUk1MZG5VazYxbnFxcnRLNXlySnk0WVoyR3UxczlXa1RIdGFX?=
 =?utf-8?B?NjZaSmVyVU1BdHpGc3piWmJJRlVGUWxOcDRxbHdhYXFvckxYdFNxNm05MGhm?=
 =?utf-8?B?VnBOcTFJbjcvRWxwcHhDd0R3Mlg0T2tDZ2RmTEtHYXhBSVFVT0FCTlZmblFN?=
 =?utf-8?B?Q0gzcXYxbkh3bmNqUDlyenZyNXIzdW1oM0s5SmlVZENBTmx6cy84dzVEeTcx?=
 =?utf-8?B?OG1XNUhvcFhWL1IrVlExRWZpSXlldm5udVlhdkRZUTU5WStQRGswb3A4VUtu?=
 =?utf-8?B?V0FHMmh1M2IvWHBDL2hGTFl4WmtPc1poeUpZUTdvNHVjZXlFMk1DMWQwSDQy?=
 =?utf-8?B?bDhueUlhM1AvMmdhU2p1NkI5dy9lM25CSC9uclMvUFlkUGUrWjlFSzB0WGx1?=
 =?utf-8?B?alNCaHZuR2ovbXM0cW4zRS9tWG9oMUQrRHFNRnd1N1ErU3duUWRPbE1aaGhw?=
 =?utf-8?B?SzVXbTl6NlRuaXQxbHU4WDZhU1dseUp0NS9sMFFnSjZVd3J2N3pNdjMwdFgw?=
 =?utf-8?B?Tm01RWNONUxBVjBTZmdEeUx1SGxHYnNoMVR1eVlLdVdvU1dtcm96Vzd5MlI0?=
 =?utf-8?B?U1pqdDh6cEZNWEtBY1RVUUlTRmtNL003TVdpcG1zSnR3amM4SUpwcjVxNHVQ?=
 =?utf-8?B?OXlPK2RHZXRMZ1c5b09TaEV5OHlEWDkyako3V0pHSHFmQUh3dW1Ja00xYmsx?=
 =?utf-8?B?SENYZldDVCtDcUxhUzNmSnNpNEliZW41YXJmSmdyYTFtbDBNY0RSOEh1eXQx?=
 =?utf-8?B?a0VaNWZqUmd2OEpJQzM2QlJOSFJNTXBkRkJtYUU2amlOcjlJcEg0Tk9rZWFw?=
 =?utf-8?B?enNXMmMzRTlXT0FFNFc3ZUVVZHJMbGpmZFJXWWV5SEdSSnM0UFVtaW9QUXdE?=
 =?utf-8?B?R1pMdTB4OFBLSjNjdXRVa005cXlxS0I4d2VUTVd1WEoxVHBvSWd6YllSeGpa?=
 =?utf-8?B?M2VrcVBTWVpHT2pCemVUM3czdWdRZlczcGVldnpJajRISG1oSTk4R3lkWHJW?=
 =?utf-8?B?bEdpUzlWcWNEY3pZbERwdTBFaWJEZFJvLzZvOVpnbXFXcUF1TWdibzlMNEtF?=
 =?utf-8?B?YS9aUWZtci9zbnNJbDNyYlhGNzNBNXBGSVFWWWFlaUZDRGpEUjNxT2swL0JM?=
 =?utf-8?B?eDhnQzhOYnBzeXhOQ1NKWWpXWnF0Sjg1NHgzdHcvMzFWbHhJOXUxLzdDZU1y?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ea5250-b3ff-41aa-7e40-08dca11cf86f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:14:57.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDaikHeqqvlOf/+S+HY0YouHdpBd4NbXgLCiYSb/FgMUWh8MKJhqKw5pfvbdwgGWXIKagAdd7uYeZs4l2JBj9CyB8mfvE2X/ryBFq3wlMDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com



On 7/10/2024 10:40 AM, Jakub Kicinski wrote:
> ethtool_get_max_rxfh_channel() gets called when user requests
> deactivating Rx channels. Check the additional RSS contexts, too.
> 
> While we do track whether RSS context has an indirection
> table explicitly set by the user, no driver looks at that bit.
> Assume drivers won't auto-regenerate the additional tables,
> to be safe.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

