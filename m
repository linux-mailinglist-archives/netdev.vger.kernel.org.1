Return-Path: <netdev+bounces-181814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD592A8683B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE318C358F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AC28F95F;
	Fri, 11 Apr 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqyqjylK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97928FFE2
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406807; cv=fail; b=t5x0ZHIn0loiNCqxHl0m0uMWH0vPc6bGMcCCeOtiwsJbnzKKF0Uo6ygkCX89YyJsILGMtG4cf8V/j93iqaFSggDWYr9GXdOqWpyrOoKyWCYmGS+/rsZWqXA8t6OOUBGiG9ZBSSU9FZetM+cYQD1kuw5HdTV5NCNzHfg8kzwjSw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406807; c=relaxed/simple;
	bh=Kfd0VX+JePNLSa+S/LDldkkoLG3EgkuelAGQwU23D0c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aNs4KnWqfJ42fiXzzLVWfXTr4TJrS+78OLMybN3DGqGMksfz1FGlEaFr7aY0ycqqQBAticLTu2+RAyH8PuEv00fa23f1YkKryx2fzJxwKCXKEVONITC9tNcnQKmEkgiUfuFPcOqBhnIlPQZmYc7AMqhPLsF4vL8bFAvbKB2qX1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqyqjylK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744406806; x=1775942806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kfd0VX+JePNLSa+S/LDldkkoLG3EgkuelAGQwU23D0c=;
  b=RqyqjylKOkILmqnnIaKxnZVK/bwJlqZ5shHSSpsqXUAgkd2WUN/zXXDC
   kJs+95qWJgmAEU9/4YCuJZKU3pI2XvEb8pie10XXIUuNY3QMjwqy+Ukq3
   tzNMlswbPfY0yxkNLjH7JQcmWD/zBEKaUzmwDCGJIPwaAXH98WR+Eplf6
   J/ChZj5oiHqz6KZzO9iHYSdChpmEqHZgXk5OOVcexWnlF/vphasPWgO/C
   cTQHYq5/jDDLBNkvJzF9Od/hTm2vZu/s6Jb4HOuiRbJyMgTpJQinsZllP
   kEhO8y0cevq5qVTjp0V//MTyPzXErZ7tx49LYK/8ciytdC1H8AQTWV0LM
   g==;
X-CSE-ConnectionGUID: 7+DgS9E1T1ONFNgxhJsSHA==
X-CSE-MsgGUID: 83Hc80Q6T36hY6Udc9u9Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="46106128"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="46106128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:26:44 -0700
X-CSE-ConnectionGUID: YuaKCWCRRKSOQ2EWV356mw==
X-CSE-MsgGUID: aBnOTKrfRPak4pVzN7VscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="133398967"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:26:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 14:26:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 14:26:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 14:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFzypPGB+dr/CLM7j7o/HTqaPehznhYV1EBmCe2i0A04NU8fbLbV3025OOCgk2Fx1CUtAx4//wcZReOVCVHcDvr4oIEgmLYzK8IWt5YYthGF/M3CeAuGR2d11r0Mww+kha9BJ023Fp219HJYNovonKTiRJcVSJkIfKJzL18WUCkMyamR7D4G1yLd0x0kjb77AzXMDPFx2hU12UTmRclg4swhxo3gCWz5LjqYQufSkE4fdcge2dqOcBQshZ+EC6terIU4TOWQ8lHnnMfcv3yz+qogjb5UAvAzFwPXVHcMGM2lY4Vz4eQb3bN5y7hy76LwOrouQSNfUoELwOOSTiqQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqDBTHcJV3Sfvnz4ghBntK5re2WkMjq1RTR4X6RGwWE=;
 b=sq9zUp2TuWH/Hm1fhfN/R4Kh0QW7iF4VgFEBvu2uKGfITR30GtUxa3P5ovbL5TD6WDfND9EweCzofE8C4nuMzXGbxgqXGzIQShzsWXZN0XLv4SbGlQfP7xxgnX7ebPnYqf5/7tAkobblYEwFwjGRr4wa1zZ2EMPdvUIcrx4HDPMwweXM3xxSs2/2H6eJVEP9un4fGpWuv/jU4Cg74MP+hruI5B47bKTTW9mzqUUuc2+5/k4aNeltf7WxQuYqQ4HB0mJOb+BG53Xu/1tXRDfETnhHRT4WG9ExEggjSGYV6yFCc+70By7YBBG0tcio7dt0h3sZdVjyfnqkiFgZbtyDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9038.namprd11.prod.outlook.com (2603:10b6:208:57a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 21:26:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 21:26:25 +0000
Message-ID: <53429226-6058-4aae-baf1-666ba7f8cf0a@intel.com>
Date: Fri, 11 Apr 2025 14:26:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "hramamurthy@google.com"
	<hramamurthy@google.com>, "kuniyu@amazon.com" <kuniyu@amazon.com>, "Damato,
 Joe" <jdamato@fastly.com>
References: <20250408195956.412733-1-kuba@kernel.org>
 <20250408195956.412733-8-kuba@kernel.org>
 <119bf05d-17c6-4327-a79b-31e3e2838abe@intel.com>
 <20250410090802.37207b61@kernel.org>
 <CO1PR11MB508998C288EEE2BFD2D45F44D6B72@CO1PR11MB5089.namprd11.prod.outlook.com>
 <20250410163908.07975fa9@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250410163908.07975fa9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a0abba-9048-4c82-4937-08dd793f8346
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0psSGN2T1VCNjRoZEIwanlGVysrS0F1dHcwN0hsOG5NTnFpOWVEam9Ta0RE?=
 =?utf-8?B?elV2L0N4cEk3UE9rNHNoOSs0a2JibmIyY2kzeUg4Ly9YQ1J2QkR2clI2dVZu?=
 =?utf-8?B?Q2YvMlNTVTMwVFNCTW5LYVhHaU5qVWpFMUcwQ2dmREwxQllrcU1qOG5vL3Q3?=
 =?utf-8?B?NktJMC9VLy9UWkZoR1ZFOEhxeTZ2T3ZHOTZQaURLQjYyTnhuRkdRUk9sS1ox?=
 =?utf-8?B?aW5pMTY4cnAwTlgxTVJObzg5emYvSEVJRDY2cUY1OXNSbHlmSHQzRldnSWpT?=
 =?utf-8?B?Z1M2VWt1UXBpaVplWElBWVhvRWN4RHdzSjRRRjhRYVJKcW1UUVpERGFhWmRr?=
 =?utf-8?B?b1NLNVBwRWQ1TW1qbzRpbVlyZnFpL2kreWVOQmszbnhZUnpleE5vNHFITnNQ?=
 =?utf-8?B?cU91b1Zyc25PQ0xOZGZZdHdWdGlxeDR5U2RicmRjYlhrb29TN2FWR0FLa2U5?=
 =?utf-8?B?YkZlSEpmT1lmbjJ6V0pING5aU1lFNTZzSlVETUFpRnFoc1ZvL0pndTJjcE9m?=
 =?utf-8?B?U2FYcUlFUFJVR2kzNlBFSkVhdlAvbnNuQnJRVGQzWFJ1UW9MZW5YczRLTU9o?=
 =?utf-8?B?MFlqN2dWZXlCczh3YkVmTHNPSzk4TWp2TUVqak1wUm43RkdNZGZ1c2dhWk9p?=
 =?utf-8?B?WTBJNFdhR20vU2FuMnFlQnNKaWxpWUEzR0ZuOXB0bDVvWCs5OHFpV2lvSXBT?=
 =?utf-8?B?WCtVRjNHME84c1ZzRzBFTmhWZTUweGJLbDB5dkc0WSsvdUd0a2FzSmQweGlQ?=
 =?utf-8?B?eVQrSFA0cjhuQUQvTmsvSytWVkhzbXNKVHdOWnMzaEdMSDAwSFFLRUxLM1Z5?=
 =?utf-8?B?UVE2SERRcEs1dlJFR2hNNkc1WVFLOCtZZnlxRWsvYngrS1I2OEh0cTdKZXN6?=
 =?utf-8?B?Myt5WVc0c2JFbzhwQW0xTUQ4ZS9xOFlEYldyYUZSVFk2LzZsY0c1S1ZhdExY?=
 =?utf-8?B?RGloREM3Yjk1R1pGalU5WXVmek4xdFZzdHQvS29oell2MEZCY1BjNnh2SkZo?=
 =?utf-8?B?bE1KaDlLaXlGTUtGaFhYbDJ6ekJ1eWRxK08zN1hLTENnZDRCTUZwbzU4aGVB?=
 =?utf-8?B?M1MzM1d3b1g5Z2JTSER5c3RRaWhjQ1BJMlpWY3hJem1CYVI3M1lwcmQvOEc5?=
 =?utf-8?B?Qi9xcFF0MjFnNlZJeldmanhPM0NvOERRYW85aFQ2b1hHbi9RL0swQUhuT1Z6?=
 =?utf-8?B?ekRKdks2MlR0V2NyL1VHeE4vM1ByeUlTc1doaGd1K0s1ZUc3bERYQXZLNTdL?=
 =?utf-8?B?RXdYOVMyWWozWTZYU1NWK2dSUlB2WHJZWVhZdjN5MUsySjJpRmNNb2Q0Nm1G?=
 =?utf-8?B?NjFGWU80cGxDcEFGcEJadnpBWFg2ZkdTS3VIUlR5eC9MbnFjL1JEUUFjaDFC?=
 =?utf-8?B?d0VGRDY5eHBSeXlLSW9NdDRUa1JuRWdWaThDUlp1QkVaNkxVSTlXWTIybVBs?=
 =?utf-8?B?Z044eGd0NkoyRUVuUExxcDdXSUExVGpUM2pXL1oxcUpLUnBNZnYxRC9lbkwv?=
 =?utf-8?B?dUZzWld6TFNEZ0J2N1pKUzhXVTRRZFFINEE3d28vLzF1S0V3UXg2OVRVSWNm?=
 =?utf-8?B?S01VVDh3akNxWm93TmxqZlNGVlZTcGduUktPcXFZcFBKbkgyMGJWYlhiM0Iw?=
 =?utf-8?B?enJhRVlNRXc2VVBYQitaUysrZnJMVStzeVdqR1dXRFRWNHFpK3U5MVM1TEVj?=
 =?utf-8?B?REFINXp3UmpCNFhIY3htYmNndTJxbmFQYzNHSnR3dk94TXNhWVRBVE5qMWJD?=
 =?utf-8?B?cWJjNnpmaDludVQ3dkpzNzNsSy9Uc3g5RmYweXQzLzdhM0ZKajZZKzMydGtk?=
 =?utf-8?B?OTVxR1MvaWVIb1dTNGttMXBQdVdFYlVVUUtJVXQ2V1lTYlZ1dHJTazhJZE9Z?=
 =?utf-8?B?MWZ6bk95QVJOVE5WNytleVZDcTJUd1hTR21FcGpuQUV4NllHam14bWExWDhr?=
 =?utf-8?Q?b1D96yjzb1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFOQThYdGpzVGJnOG1LVEpBeEVwZm9pYjRXY2s4QWhpN3FNeFVJMGNFZzJF?=
 =?utf-8?B?S0wvdDJSb09zcy8wNjduZ01VNjJKZlZVT05BU01KRVZ0aWlaUlYyZTFQNWR1?=
 =?utf-8?B?SFlBTTYzQU9DakRLcXRJZnM1aU9FSmRWNDFNZ1NrK0d0YStZSG1uSllnNGNx?=
 =?utf-8?B?dHAyQmQ5dmxnVWFTMWZHUm1BWHkzUDZCdVpvUDBhSGxja2hzd2phT2UrY0VH?=
 =?utf-8?B?RXhOdG5ENXBBTUxHZUw1ZWcvM01ERnhKN1RnMjJ1ZTlmL2FQRkE1WWx0c2Y5?=
 =?utf-8?B?VFdPcXlYMnFRRTkvd2tQNVcrTmJ0NXIxQmJTVFFnbEJWWjN3U25VQXNsS3pK?=
 =?utf-8?B?UVBETnQxaTdQb2FTZ29aM2RHRndGTjlEVTdHaXB6cEhFVjVGeTV0byt1WlFp?=
 =?utf-8?B?blhVYmkzS1poMGRGVkkydjFIbGhQTUNEMENFNE5xTkRJd2ZXWHhrWVhZZkpE?=
 =?utf-8?B?WHNaSFFPdXJOK3lJVzNWQXRCSStUY1kxNkpzQjJVOFFaTm92eFFIanljeVpZ?=
 =?utf-8?B?SVRVUlVVK2NsRUs0MHpZNnB1eXpETDR4dGpTNjRNRjY2UXpZRytmWVhOQ3Iy?=
 =?utf-8?B?NHBxZHYrZ0ZXTnYvOGxPL3BpZzd6MGtIaWxVckdIYjJFYmxUUmpRL3JkYlBs?=
 =?utf-8?B?MlhZMlE5NDkvSnZRMW9CM1NjQmlLOW85WERwRkRENW5rTEVnaW9xWHBtd25q?=
 =?utf-8?B?K1p6OXgweHhTMEdVSTBJcWRFRDNQc05XTjhNdSs3aGRWa0I5ZllYSG14WHlD?=
 =?utf-8?B?Mk5CdkJNSXRUNVNWVGFLOXlkanhML2RCR2JlV1ZHODFCWHlrcXZvdGNGL3VQ?=
 =?utf-8?B?QzdHT1RTZ040WVNaTmw2cG5yLzZsVUNON01XOE1iOVBiSzkzL0U2Qk9RZmpO?=
 =?utf-8?B?MlIvWDNMY0MvUUVuVkxBd2lwWCtsTUswazNaMjJSTlZLaXJjR2x2eTZzWll3?=
 =?utf-8?B?M3AybC9sWEhDZnNjL3BpdW1pdXpmOUFtWVV3NUJ0dGNNb0Y5ZTFJTFQ4ZUhC?=
 =?utf-8?B?MW5NOENWZ0FhRWYwVXp3MGRlNkV2bkp4TFd1ZnRFc1cvZUtQQ3ZaQTZOd00v?=
 =?utf-8?B?cXNBbzl3QkRyV1VaQzZjTDI1eG9BOE9IdU5UTFBZNHF0dTFhRjFYOVA0S1Uw?=
 =?utf-8?B?WXhtWHJ4MkxLbDJwS3ZidU5ObUN4b3lFT3RQVVhXTGRXTnFFcmx3L0lFVjly?=
 =?utf-8?B?NE1tbmQybjNDaGY3UUFMdmIyQXpzaEE1SC9XaEFYeEE1SVU2dFVSOHF4UzNI?=
 =?utf-8?B?dWtWTVlHRmplMktuQWFleis5aGtwRWRzRkRjdjdsQm4vNUdOZ3dSb1Q5T200?=
 =?utf-8?B?YmtZc0ZBeWpuUisxSE44ZU0vNDlweE9OTWNmeUhtWkRkQzFUMlpJZjJ6WEFD?=
 =?utf-8?B?d21ObmhkNngxWVZQV3NJV2ZQQWpmdEQxWUxDUHI3bGpPa0hqWEtNcXQxTXpw?=
 =?utf-8?B?bHFXTGtFdkx6clg1OVJBd3ZqTlgvcU5xV2tPR1lETlNKdVNOVml1b3JBUmVp?=
 =?utf-8?B?VlA4S0ViR3dWWVVYNEFqYzg2TE5BV0g1ZW5TODNvSnAwRHA4cmdZRmZWeG5O?=
 =?utf-8?B?THJ4UVpJcGtkTXBQSHJHR1FiT0svMHYwNzV6cTlUemJsNm1hMWdyTEREQkZI?=
 =?utf-8?B?VXRYTi95dnNNSjRRNzRmczBoRlBkRkZsK2lWcTB5RHkwaFNFeUc3Ukc0NGNn?=
 =?utf-8?B?RVBTUEoyam5XUXdFeHp4bWxNZ01aYWx1SDBSUzdaVlZ4WldVek5aeEhJYTI3?=
 =?utf-8?B?NmpPNkw4d21DdW5VOUNuTDFjTzhZdHduNExtREhSd3phVEVBV24vK0MySTZL?=
 =?utf-8?B?YWVvc2d2Q2lpQS84aXBqeHNmcWhUeUFyKzliRTdGZFN0TVl3a29kTHVxT0k2?=
 =?utf-8?B?MHA1aFYvYVE3bXhqRkx6VnhMNDhEUVlFbGNrN2NHY3FUeXRnRk4vT0lxZHRh?=
 =?utf-8?B?MnkyYkdia1k0MDZ0MlJINEloelJKdER0eTZOajZZYnpxc0ROd01hQi9xUW9v?=
 =?utf-8?B?RzVQa3NtZ2JzR0VWSElnY1IzOHVXUDZGWkJmUmtka2ZlMzF1WUFnTTBOMkl0?=
 =?utf-8?B?ZGVMNkN4QklFc0tOTmM2UTRINEdOSjBJVE1SWlFTZ05qQURndEloaVVuVmUr?=
 =?utf-8?B?UXZLcW1SRFVidnNxcmp3QVBnOUozdzlsZlRJR0xyNUVkYnRUTlg4MjZqVmR1?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a0abba-9048-4c82-4937-08dd793f8346
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 21:26:25.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GCs7QiJo6Zd6lpoYVdzwmxy8qTGjAtQ9Q7LDgjiBX8rZciYpG0AIncbEO9N4ZJVVrAElcujgZRI6pT+9W63z8d/X2suq9vW9+aZXGyx9rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9038
X-OriginatorOrg: intel.com



On 4/10/2025 4:39 PM, Jakub Kicinski wrote:
> On Thu, 10 Apr 2025 22:35:43 +0000 Keller, Jacob E wrote:
>>>> Does this mean we don't allow drivers which support
>>>> netdev_queue_mgmt_ops but don't set request_ops_lock? Or does it mean
>>>> that supporting netdev_queue_mgmt_ops and/or netdev shapers
>>>> automatically implies request_ops_lock? Or is there some other
>>>> behavioral difference?
>>>>
>>>> From the wording this sounds like its enforced via code, and it seems
>>>> reasonable to me that we wouldn't allow these without setting
>>>> request_ops_lock to true...  
>>>
>>> "request" is for drivers to optionally request.
>>> If the driver supports queue or shaper APIs it doesn't have a say.  
>>
>> Which is to say: if you support either of the new APIs, or you
>> automatically get ops locking regardless of what request_ops_lock is,
>> so that if you do support one of those interfaces, there is no
>> behavioral difference between setting or not setting request_ops_lock.
>>
>> Ok, I think that's reasonable.
> 
> Right, and FWIW we may one day actually make the request_ops_lock 
> bit be _the_ decider and auto-set it based on op presence when netdev
> is registered. Purely to simplify the condition in netdev_need_ops_lock().
> For now it isn't that. I was worried if I go into too much detail here
> we'll then forget to update it and stale docs are worse than no docs :(

Yea. I don't think the doc itself needs more comment. My questions are
also for my own education as to whats going on, and to make sure I
understood what the code and docs are saying now.

Thanks,
Jake

