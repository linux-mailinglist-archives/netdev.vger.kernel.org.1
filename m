Return-Path: <netdev+bounces-220069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B22B445D9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7288A00EE6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207F343217;
	Thu,  4 Sep 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QObDj0xA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BC259C98;
	Thu,  4 Sep 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012066; cv=fail; b=InZYpH4MiQzgWwNzZgK2zegPCFAF3uRTLEngNE2V++G5hABu+JRaUT/iTiPPhgz+n8tyoz3HnsV+a4IM5bSPN456rb4sL8xbCPih/BaRBCZ6z1ugFA6kUFb6r+rl133niTrnKAnbvq2AK5dMx9odU597H2kf0etWlg6wtQfZReM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012066; c=relaxed/simple;
	bh=MPCyUj5z+qLt3l/fjJhXj0fgnjhjHn/79+taGo0l5Gc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LaN3ys0YkvVt7ItZ7gmHhqrTzeLRc3OPmrhrK2sWAt6xeqUiJrqyv7kix48Od+n01KAKd+HU7/zQMP4c11xzYOvmNY8nl1RZBgmyC1zqMfNSB40a73xuOrM3p1cHal3hA47F0UYhpLPusFombwdYuNhqf9n2v+HLMYhlEuWz4rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QObDj0xA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757012065; x=1788548065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MPCyUj5z+qLt3l/fjJhXj0fgnjhjHn/79+taGo0l5Gc=;
  b=QObDj0xAHYtxyiGD9nMfBodgFfuPxxHgc1OuJj4GGR9imGNpN0Mj66gB
   k8YYfnQdMVavDY/raFkvTixVIby30AerEEwzGULf4E2xL4i+eDCmnnY8L
   6tKQ5E6agi68tDH451Mj7Q07w95C+ojl82CItUTiPTQ2lFQgHjGB+2PmN
   DoVxWrp5mmin9QtewBjVmBe1/rSB1HyXOSDGW5bcYTwX8LaSDfbsJR66/
   zjmoaXJTkTBE37D94YdA7f5Y+MM3caLFL0CCCyA2E4KCRw/ZAw7h4GkHC
   ppXAV+apVKPDQklGm23qHyHuzcucNFAbxsAzp7wgMipHvLYPYZo2ojPEi
   g==;
X-CSE-ConnectionGUID: 4zhhcYW5Qie8F5X8dpVpPQ==
X-CSE-MsgGUID: P/NdQiWeSwa5G2BAu7kMzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70740882"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="70740882"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:54:24 -0700
X-CSE-ConnectionGUID: OyEEVQ9dSkivdpAhfkgK7A==
X-CSE-MsgGUID: W54i/OeXTVO+rPU8lwOC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="172782349"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:54:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 11:54:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 11:54:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 11:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXBcj4/vPjOvrUrzsveDucLD5DLPsY837yy1aMszqcBxWysJY34WGgkzMg8NjL5dRFt30dLtlqyWXj8/0EjArACRi++nIGxmDTuBSga7zYX8re43AWwN8nPruL1/KFJRfLvjNYWROOQgzN8fHrB1wvleHeKvK3QVheCSLa4Gsaw2A1gCNPnJR05hLwTOJZmHvZayueX0Wb0EhYii7uTcJ9blKMBFChInzqMafFUrpeYqgg/wRUA6iLAiAtmpxFGP3O0cdK3sSRq86kgCXQo1AzYzPo6eBPMtFmZRd3vtepWvFtyBp6npjKwT5MzNqOeNnf/rW7JINDPeeQsITMR1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPCyUj5z+qLt3l/fjJhXj0fgnjhjHn/79+taGo0l5Gc=;
 b=q6n87WAuHHyG5HArkpBOF50ehk7zU3FG4i7FMMFo+UrKFgOAc7JPQuZonLAWAH+emfj+xUvoL76SDem0OcUlbb7n0vw8mty3VFpo05BQAa/bachAKZe9ti0KntTShmzPzSPXUCBz35R/v7TPEskJMdrQwLWLCr1ws7KYXggTbwxqs+lwBVsrsklQbhXRfE82C1uQOPgSnCOVcsa9tY4JidbytwGLtgvm4XjNWQe95sSoFoWG2LIBKFlWKO7jTaZ7Fe0sl6ReEvPD1APipzKAjvGfM1XvoR3qWjCKSYKdFtdqddthTj/AVxPAi5CtQQBjVessLwvy456/S6HcEpYx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59) by IA1PR11MB7388.namprd11.prod.outlook.com
 (2603:10b6:208:420::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 18:54:20 +0000
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e]) by DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 18:54:19 +0000
Message-ID: <40c931b2-f565-478b-8900-1a6aad6d9e0c@intel.com>
Date: Thu, 4 Sep 2025 20:54:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs
 prints
To: Jakub Kicinski <kuba@kernel.org>, Konrad Leszczynski
	<konrad.leszczynski@intel.com>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>, "Piotr
 Warpechowski" <piotr.warpechowski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-3-konrad.leszczynski@intel.com>
 <20250901130100.174a00f6@kernel.org>
Content-Language: en-US
From: Sebastian Basierski <sebastian.basierski@intel.com>
In-Reply-To: <20250901130100.174a00f6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0025.eurprd05.prod.outlook.com
 (2603:10a6:803:1::38) To DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFE396822D5:EE_|IA1PR11MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: e70bf815-93d4-413c-270a-08ddebe47450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzhueHM5WVJNV2NHWE1mbEN5a2t5OWZOT3hoVTlCNWhjMGxGZS9jQ3FMRGR0?=
 =?utf-8?B?QjU2NCtFd1paV3JsRUVYVlpJMFcxUlZsSU0yTUI2dWsvTFYwNnBPNTFFbXVC?=
 =?utf-8?B?Mk03bGpXV3dVQnQ0bThjTlVUaG12NDNLL1pJRGVqSDdJWDI0RWpHRHJGaGs1?=
 =?utf-8?B?ZkI2NzdxSnQ2THBNV0R0dDVmQXVjY09ISzR1TzdDOTJFQlFvckdodnNtTlBh?=
 =?utf-8?B?MHJtUmVPcngvUGVYdmFHZTdRTFIrVkpOTVVXNVhlU2N4Q3JyaFpacFQ1KzNr?=
 =?utf-8?B?ZTZXVVNxaWFLNFY2SG1ib2g2eHhDdkZZNjVuWEJTUFNvaHhpelhKdXRyOG1V?=
 =?utf-8?B?UG90WVpHNXhOTU9GZ09vdDBsVFlwWnNXK3JBdXlNUERzSmxqNUVKVG9UOW16?=
 =?utf-8?B?a05iMHNYUVZXZ0FTdnhrUWE1Ri9YUEdZdjBvaU83YjFrOWN2YVBiZFVXZDVi?=
 =?utf-8?B?WUZyVDBTaFFrcTdpakdvZXlqaU9BcjdhYUJ5MTNDMjIzMHNZcWhVWUhXMlFR?=
 =?utf-8?B?MVZuMTIvRm96WlFCZXVUeGJLYmNCYWxRZjB4aExCZDFSd2NzYmZVNnR3RjhH?=
 =?utf-8?B?MVZoK2tXSUNuOHdSRDhLRDIwaDQzVFFkUkpodGVNMkRhbkJhSVB6b1FnS2cr?=
 =?utf-8?B?WS9xNUNQaDZ0SVY5NWhvU3g4ZHRjZGZDZk9xb3AraXZYYmZwS1NiOEg4NUJX?=
 =?utf-8?B?cWlrZ251bGtjYS9IRkRsM2lUdnhyYmh0R29ha1VSOXhYVElhZ1M5bThoTHBD?=
 =?utf-8?B?c2F3UmFFdDRjdUFZWDRrYjkvMDhZYlJ1bWhWWXg1Vkx6Njhpd2VpN1RWV3VQ?=
 =?utf-8?B?VVQ3VW5kVXA2LzV2djRrMWFocjN0azFsYnVzNUFnN2UxMFhZQ1R1QUdBVk5P?=
 =?utf-8?B?QlgvbkhwemtCNWxCenEvRm8ya3RWS0lUTFFUN3oyMVdmellaWmtCaWFmSzlt?=
 =?utf-8?B?MGJlTTZQSkhSMlB3TU4vU2JjVzU4QU5tam9FWUFXb0FmT2J6NkNSTDd1eU1R?=
 =?utf-8?B?c2FaejJSRDRJUUtrZDNKdFBpSUNDK0pnQVJ4MkFxSy9iZUorREc0QVE5cWE1?=
 =?utf-8?B?QmFKQ3RVRzdhZnBQWnNGK0k5UDNLM21oUGRXMjRUSEpGaTVuYnFqQVp6RGVO?=
 =?utf-8?B?L2YrSzNiSERxKzhIZ0lEQ09aZ20rcnQxbmVUMHFOc2xSWU5xa1p2dzhQdEhQ?=
 =?utf-8?B?TzlUZ25DRlJRdlBtcEVsdkU4UTBYYmprT2RSUlVrVGkvNFZLSXhFYUZFb2ly?=
 =?utf-8?B?VnJhRGxUWWVNdUY2LzBHd0VwNWV4Mlk2UTB3Z2VSck9nVjZkZXV6MkdPUGV1?=
 =?utf-8?B?d05kZVVpZHNjaUFwMkNSeCsyWVlGNGxtYm11RmFZVUt5MHNVR0o3NHg2QTBj?=
 =?utf-8?B?NElSdXluVWRnWWkvMjZBMytheWtQa0ZXS1c3TWVHU01sa1lEa3FhUm1sQ2Vn?=
 =?utf-8?B?dE5aT1RaZ0VrZHdORjg2R3pWTFh3bkVNcWRkOWdWU3ZxSTBvQVh6aUVCQ2dC?=
 =?utf-8?B?Vkwrd3R1cmNvalYvWms0Z1NVd2gyb2FxeExmTStiVU1kZ1FCUkZka2V6amE1?=
 =?utf-8?B?ZENPQVBjVXo3RS9TcGxuSGhBSFJJS25DOUd6eVI4UmtHQzdVbTZDYkoyQ2hF?=
 =?utf-8?B?NEcvK3J5cGF2eDc4bGpsUW9Dd3FBRGVLUHJjSW1YM0hnUitJZmZXU0tkZ285?=
 =?utf-8?B?YmVKUGttTkZCWUg1NWxPYmZDNS9nbjdpY1ZyNUhDV3FVeVhGeFVNcWMzWDBV?=
 =?utf-8?B?N1EzU3FyQWc4Y0xHTmZZVWVNYjB0TWFKRXBjdVlTcEtYM2NJY1g1am1nRFgw?=
 =?utf-8?B?all6ajMzK0pnMFh0OFY3TnlJTVpSZndDTFZLNjRCKy9Xd2JZejBkVFNlSXA1?=
 =?utf-8?B?eXlGWC9HRzFZTnF6MVlsUk9oOERHT3g4N1FaYWFEdUVONldtQzJ6ZmN1TzlB?=
 =?utf-8?Q?KOergmoiOpI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE396822D5.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXRYUUdHbjhDTGVHdFBxYXF2TkVPcWJXM0NxcGU0S3JLUjVkMFROdGVBN25L?=
 =?utf-8?B?VDBwd1l2NC9TMzJ2L25ad3VISnRjQ2dSbjN6T3E0Wi9ianZwVklZZk9EQ1Nw?=
 =?utf-8?B?b3VTNXpvVGlhNk5IZGxCR1RGRnZicXRFMS9uUGFqa2RZRXpURmVsSTB4K0VO?=
 =?utf-8?B?SmtsWTdCUFpENWtmWVpoRXFpUzkvcmRKTjhMUUdTYmpVVXN0T0VsZlJRRWp6?=
 =?utf-8?B?UTRWMUdWNnFqUWdIQ2xnZzcyOFNOSVZvcW1CekxSVXBXb2o0SHptWGZtakIr?=
 =?utf-8?B?SlF2bkRWbUxJNXgwN2NxVVpvQ2FnakN6eUUxWFBXNiticnRtRVgrWGVKZnBY?=
 =?utf-8?B?V0dIZmRRSGF4T3FtSDhFUkhvSHM4TnZZYXhxMkVDY0RiRnAvQ2d1RUJwb1lV?=
 =?utf-8?B?N0pJdU1aMkdOTXdpS0NGVmxHdHNJb3JvN0UyVmc2R3FNRFNXQ2VCWjAwTzBt?=
 =?utf-8?B?QzV5d0FxaGhtNGFxWk1TNmwyM0VCc0pWcmtRbkh6MEhCMWozYjFtWXIxeDR1?=
 =?utf-8?B?RnQxcTdNcE8yOXNVZFU1ZkVFaGZzZGhDMU9Vc2NMbkFVdkh3MTl2MGVPQkxi?=
 =?utf-8?B?SkZQRGMweThqcWMvQWh1Uzlyc3FJdGpDdXJVVC94aitlaGpweXpDUkcwejln?=
 =?utf-8?B?V0V3OWtsUkdBTkFZMWZML1RteEtiRTAybkJkQWZ5RmdjNUhybHhHRXVFY1I1?=
 =?utf-8?B?cUpFeVpNZVEyMExLMzVOUElIZ2dmOGZjWFFIRFh3MVFoTnNJMXRVSU5IalM3?=
 =?utf-8?B?TThJUThNVythMUUxQ3RxUTVPVG40Rk9lZ0gvYko1aTlwcklmbThzRWRGTWVI?=
 =?utf-8?B?ZGlJZm9sZ1NyWTlWcFQzVzcrYUk3K2J4eC9DZFhYUFA3WnhCdXRlSERvMUFp?=
 =?utf-8?B?MU5tQ0JEbkpqOE1jRll4ZGNITWxTT24rQU05US9FeDJqS2tkb2hPVm4vM2xl?=
 =?utf-8?B?aE9Sc0pwVUlNTTlDUHVrUmJVVWZROGJLd2NiR2xkOEZhOUJTK0o2UEU0MGxP?=
 =?utf-8?B?QnlYOEZ5aFBmMEJZb1JVTEM2dG9ycGRVRGQ3SWo3VktWZk83MS8wSHJrcm1U?=
 =?utf-8?B?TW9wMmJ0VThhNFBzYml2SXBIWDZtdlpyenE4Nm0wUGVtZXBmNHBMUmNFQWF3?=
 =?utf-8?B?WFpIUy95QlR2K3d5bCtHWDBSa1J0cGg1VGtaNGJhNDZja0Vrb0RhUTZ2dXYx?=
 =?utf-8?B?cFJVUEtHVDRXWU01ZkdkZnZwMjF6eElFSkRZbEVDQXpZVmw0ZEVtWkFhNVlF?=
 =?utf-8?B?MzNFdGVLRFV5OHIxYXNwcXEvWnByVGE2YmhGS3NSS2pvT2U3SEkrZkZaQTdr?=
 =?utf-8?B?MkVnNXBCQzR4TFo4VU5IOHNIb1hwL3NVL2tCOUFtSHNwSm9ScmJqOGNRYzRk?=
 =?utf-8?B?NjdDcXQ1dFBLcStpNi9kKzEwSG16aFBmcDhMMDE4WEFQVisxL2NxN2JKVzg0?=
 =?utf-8?B?d3RCZ2U0ZTRmbHJFUjI2R01lbjVQdU56VHplcjJqeSt5Yy9LZDZBeFBsS3BD?=
 =?utf-8?B?VTZsMURNSlJWays3Y1VCRUc2NzJDNS96dk5tY1Q3d3FEUnJyYTZ0cWFyUkR6?=
 =?utf-8?B?RVFjeUZaTlR1bEdRdDcrZE1tUm5EM1BnbWtqazhNWnBqYzVkaFFnNytxVnhC?=
 =?utf-8?B?aHlhSFZDRGFMN0FyUjRFRGd1WEdCK1NQRVlVNlYyWDVvcnRJcXFId09ySHV2?=
 =?utf-8?B?dUV5RCs0aks5eWVtRW10UHkxeko3L2lid2J4UDZsRmE0UEtyL2szR1I4ZW1L?=
 =?utf-8?B?RG9KeldaK3p6d2d0cE1pNE5sNkVtQlh3VnFMRGU4SHBaUitwVXlMaG5iVVlD?=
 =?utf-8?B?WXZEdFBzQTBHVkZtMjZYSjEyZDhBeWVZTk1pMmREcnZxRlorWVRqWDVnUGlC?=
 =?utf-8?B?WjRUM0YxSjNJVGt2RDZhQVdKTmdRQ1FIWGNRRFFhcUR5OVM3SGdiUENneGJG?=
 =?utf-8?B?WjNBTVBHcHZvVlcyY1pyYjdUL3JadWFIdG5uSndveW1BU1ZScFNyaHRPVUdL?=
 =?utf-8?B?R3RIVmUxaW40Zm1ycWkrbkx6UFlmQTlCeVhPYXdyNkU2LzN3YU1rL01rNFJL?=
 =?utf-8?B?a1orbm1pMTZackRnVzNwY2ZJenY1aGVvU2prOU9MdU1TQlVVejYvbXBRUnBC?=
 =?utf-8?B?MHl4SUZaWnhzMGhUK1VjK0xCR0R0bmQ5cHZnaUFLQkpTOXJicCtWdGtRa0FR?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e70bf815-93d4-413c-270a-08ddebe47450
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE396822D5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:54:19.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYQO3FvZMtKqFGvK6zxxERqEjgXF2+uJGw2+WcYjCEjmr99UqvXj8dWS7IGPVxyRiIUpJfgb/E6Ye1pqNQt7JHP5xbx3+F8fQtkSH2YKlTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7388
X-OriginatorOrg: intel.com


On 9/1/2025 10:01 PM, Jakub Kicinski wrote:
> On Thu, 28 Aug 2025 12:02:36 +0200 Konrad Leszczynski wrote:
>> It was observed that extended descriptors are not printed out fully and
>> enhanced descriptors are completely omitted in stmmac_rings_status_show().
>>
>> Correct printing according to documentation and other existing prints in
>> the driver.
>>
>> Fixes: 79a4f4dfa69a8379 ("net: stmmac: reduce dma ring display code duplication")
> Sounds like an extension to me, so net-next and no Fixes
Sure, i will drop this patch from this patchset in next revision.

