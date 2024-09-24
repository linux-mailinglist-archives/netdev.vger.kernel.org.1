Return-Path: <netdev+bounces-129470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDB9840FD
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A73B1F2205E
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E516E860;
	Tue, 24 Sep 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjShlFla"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047C16F0D0;
	Tue, 24 Sep 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167599; cv=fail; b=do+Vp5uWu1QMcS1IODUkX0SxMpeuNQD/o3HzgYpwpmlxMu49TXohy6YkPNpKUBVhlWOUIkr+Q5E9tBq09ZczFOIJJ0l4QNrMz8wYsVTUSs4UaC/bewbI2oMtjeeVqlEBwXc6eKAmmh8XxqQ8/JvWh3ZL99OLXtt182i23RDFTYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167599; c=relaxed/simple;
	bh=J1hAsbCXf5HbeuPt8kOwUZM9kVO1QdyP8vyeFFnieC4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fOxSh0zYdqQ5Xay4ggB1O/GSBjqN/6zktJWEBq/zcYiptMKF7is6UiGG5UaIa8D62T5tq/hCKM+nhGZ7naYqEQsF9qhv4RNpqkwBxb2gFJ+pu6Xa27ntNpWOZUXVpxd8CevYrHwRo/j9vVqnrLHhCtuj1NkRlE6OZAiKjjyq0OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjShlFla; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727167598; x=1758703598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J1hAsbCXf5HbeuPt8kOwUZM9kVO1QdyP8vyeFFnieC4=;
  b=HjShlFlaPfYxX/BhOLt3s940WY2pZyFONgPmzthXT4nR/oZFvYxITQjc
   NkKaQ63IE0nurN351BUq/KTFIHg0w/NGWwXKmRI0x5TlDe21lmVCisQwC
   fAwAWOt7IZXr6FL3E946McZN4i6uVSUbItnRj7VRrhyCIBgLQmsxkFFBY
   wPqVyTxgtv366ZdV188WPxN1tG0SP3uJKYhs2RlLMW+w+kM78AYSqDTgl
   aCDUxRRC9+q1p9LT+EQgzWjSAR7QxT8bdl7sB923go6GqVfHWv5ymgBlR
   82zasEO+3WMTDoRO7a8tKB74H+XJXHmlgv6JFFeHymNcsxRgAwb557E/N
   A==;
X-CSE-ConnectionGUID: zBnyxiZ0RDanex3Oan/GVg==
X-CSE-MsgGUID: Og+RuQ8VTiijR5XQ1vmplg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26100739"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="26100739"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:46:28 -0700
X-CSE-ConnectionGUID: bEar9a2qRu+RXHNHYkIVIw==
X-CSE-MsgGUID: ZsV/mxlHQeyfd9mrFA0XXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71488664"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 01:46:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:46:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 01:46:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 01:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeTYhTaekFrrqoZaI6lykqoNjFjncjDXgu0gifvVjcT/r6vG9bRyJY+mx+pojtTOwZNskXEUTb5bI92JALb5rBvevQuCDJwXrDErpIqGYtqufucypjhJNR3laevqlb4zLJ5hpUC0qI5MHyiwMO6ZXV9gIsFm5TUuR1VYFt0IGeQHeR5osr5ZL5hh2G+dgS4KeNSBWKGRZKbJtRdWX4WtvLFimm+C5HQudcbI4kytD0SvmwFPCtjpkW7UM+oW3Ucj+ZhDLFirfFB7IAKt/8793ErVBkwlbMjxyX5tftwdFlUx4A3E7dKCM8Cv1/oqw6N77MA9IgJaEjtc99yrgSaagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/qaYW6mTVnZKmSkP9M/dFm95R5yvTcWfMOwGKaeMio=;
 b=vf9yV/F+j5SAEbWhfOTzUd0NCKGDJUedfWi0Yc+aWD434wjGKKstTfxgWjJQvUlxvbrSI32OU5pVWzp6NlfVPL5/zfeA/KIAA9KktYOP2IK9/cQ4XIvaAwAJPm/dTK4BMqANgEwaoUUt8uDXBcsjzDnVIRgUzqM7XDu19UMOSu3wbBkROrBVS0H93vuGqYTK/MfutY2UzovwCYu42Ar5JBWw7XoxUaNoYr083Icwvjq2fgAJyA/2o02w9KjC7W4KVzNBSDCcSQR2mDavnWAoO0ELAq51AolvcnyIdxa/ZMHRPjgKfZPVPA50qFISvoCxYy4LOFdn/v5+iI2yDUziDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 08:46:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 08:46:20 +0000
Message-ID: <5b4110c2-ebd2-4beb-bd52-f2e15c5bb88b@intel.com>
Date: Tue, 24 Sep 2024 10:46:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
CC: <kernel@quicinc.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: fc541612-95cf-4876-8bee-08dcdc755cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWplbkxnbWZpOU5BcERrc1o5MFA5TmJaQnowMFh2enNBMUE0WFowL2xlV0RE?=
 =?utf-8?B?Yi9uVHowendER2tUNVhDLzF4cnZ5ZlBrUkNjakgxdGZOdlZEeWJ6TE1oNFhG?=
 =?utf-8?B?QzdQYlRHc3V3MkRtaGgrTlJGZTJ6cjI0UG9oT1o0ZFRNa3dOWlpaMDlwTUl6?=
 =?utf-8?B?QUVzWFBvMlQ0a2Q1M3lpTDZPanhBMjlVbkdpNGdUTG5OcWdnMGlnMHl4ZlNx?=
 =?utf-8?B?MTVwbzhXQW01SFRCYjBvWnlpWTBBamhFbHhJRWllTWJzZzRMNFpadDAvRHQz?=
 =?utf-8?B?bWU4Uk1oRUJ2NXhrMTMrWFptSVdzcjhBeWJ6dTlPMU9tSXpEdm14NDMrUzJI?=
 =?utf-8?B?U3R4a1R0cEEwRUVpTFQ5V0x6MU9RY2ZvTUx6LzFzTUdZV0c0K0lkQjhkc2dr?=
 =?utf-8?B?alVqM2tacnVrZXl0THdJSmtqNTVFZzQ3N1BaQm9SZjJmYityTTRTenFLZzdz?=
 =?utf-8?B?WEZ0RnBpWFpMOVZ1ejNPSTlBUEpUZzhlWmw0WXFnTFdXRlY0YlpuOWtheGd0?=
 =?utf-8?B?ZzBaUUdpV1NoYk1qcWMvV0JjNG8yeTJFa2hNWXUzTFlVUzlrdVhWWXpVKy9G?=
 =?utf-8?B?V3VpWTNkMU9LTDRNcFRFVitoMHZBM0YvTDJQb0Zlck5VWDdSdE9mYjlSVERB?=
 =?utf-8?B?U0pyOWl1cTRWZ3hMRzNsRGU4Z1U5ZnlrQ215K1R4bFhleWM4OXc4Z3MwMmha?=
 =?utf-8?B?L3FYT3kyaDR0SEd5a3BQWlM4MjRIKzlxRlY2SG1lV1dGUTI4ZlFyeWdzRTVS?=
 =?utf-8?B?aXdZYUV4SEZkU2JNOFI0YkdPMDdQM21YeEhCdjlxSk5yTkpFUjU1Y2dKN2pQ?=
 =?utf-8?B?eE8xVVZpbkZ2aUNXU1A4ditzdWlwN1BSYWljWThBWGE4a05RYUQrU213WXFn?=
 =?utf-8?B?dkNPb2t3NlM0L3dkVnJmZ1lVb2o2ZjFSVE5HZ040aDAzQTl2MHlVYWtqMmxt?=
 =?utf-8?B?ZnpDc3RhTjZrWTdSV3h0RU9wcjN0L1pLSlJnOFluVE5kazVnU1QvVFA4S3BC?=
 =?utf-8?B?b0wydDJUak9ZaktuTHNtTEhYUW9oV211c2ZIdkxWL1BUNFBzQ05KeWhsbnNE?=
 =?utf-8?B?a3F3dDd0b20vWFRTbkZ5dEF0d2JkTEZ0NGlyMkdyOCt2YzduL25XSXQ2SFFn?=
 =?utf-8?B?R1dCRE9vQzEyY3lhQnFqc2p5KzRDMjI4K1ZVeUl1VE9PMzc3NVFvL2dFMEQw?=
 =?utf-8?B?bUFFRVk2emJuZE9zcGg0RXg3OVJDOWIzZVkwUUgwZXpQRTcxVitHV2hIdTZO?=
 =?utf-8?B?MldRRjhrbTFkd3FQMG5CWjUzbDZBTmdBVHRSdzl3KzVWM3UzbG9kK1FqN003?=
 =?utf-8?B?SGJMb09NcnJXdnJSWDdFL3NveGY3NXhBeEVoYnlaZnZ0L0N5K2xpZ0dna0FM?=
 =?utf-8?B?S2tDdnBISzJvMnNzUXJsY3BDZDhpN0xxUXpTZm1yQXlDbU45blc2aXZGa1Q5?=
 =?utf-8?B?aGdMbklma3c0Q2xMZzkvc1V0RlBlWGdDakkwZnA1WlhORnlYWnR0aDRnOW1m?=
 =?utf-8?B?Q3BpODZjeDFVajc1VVB0a0ZVdkpRU2o0Sk8xZTFFYmVyNmVsY3JtVjlSU2U5?=
 =?utf-8?B?cG4zbWd3WlpmcEh6SjlBM2VkNVZlVDJHS3drNXFzbS83Mm5GOWxWTWtCUStq?=
 =?utf-8?B?WmFEdi9JbzNHS2VJTEdQNW1ZV2pocXk3Y0JlUzlrL0V5NjRGT2dzMmpHQ3RT?=
 =?utf-8?B?VmtrM0JvN2xTaXdMTm9OdGM2YWwxVDVNNW80aHR2Njg5YTYyRHZEc2thT2J2?=
 =?utf-8?Q?Sf7uUb9iGmFNsiFsBc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEh6aW1uWm9VVVh6MUpzbVltOEhweW1sTEYwakF5aTcyVmtIV3l4THMzKzg1?=
 =?utf-8?B?MGp1NHVLaDhMOUNsWnFkOVlvL1p2YkVxNURqT1hnQVJobDNtbVRObVVXMnVi?=
 =?utf-8?B?NVhoRldKdmV5VlpFb0duMDd4S0ZOT2RpYWk4UjVSbEVzOTlFRDhhMnpCek1i?=
 =?utf-8?B?Rm1rVmlDbmtWYmtMSnA4WDNhN1FNVDJaY3RvN0U5QWNrVGZtRFJlZzV4cUov?=
 =?utf-8?B?MVVRN0cxSmJJdkxRNS9lcFQ3dEdPZjcwSTRRSnREd0Q0d3V6OE1kU0dCN0VG?=
 =?utf-8?B?Rit5d3Z4Lzk1TTR6RWFWTHFMTkVFcjNxTmJJbEFMSU9Rc2pyV2dMczNZNDdE?=
 =?utf-8?B?dG1EemIxbWxDZjJ5Ym9hWVJvSncvVUtheU5DQitRSHA5M0FLb0g1WmhId2t0?=
 =?utf-8?B?a01mWGE1NUZDRCsra2U1NG1Nd050NWhQVHZ6SENSZmp0eHN6dWtPUWhJWnRS?=
 =?utf-8?B?VEpHcnI4MG04Q2N3Ri83N3lZZEtDbTViVW1tTnpLOU1vU3VIK2dIM2s2WGVZ?=
 =?utf-8?B?SjdhaEMycUF6cFFuMm9rcW9iaWtacUZDQzIzLzJCcHhxNGxoYWJ2NWk5dTIx?=
 =?utf-8?B?ei95Qnd6ZW5hRkFrelpjWjRmaEhoUFhyd2RoYndXWmlZeDNad0tocG1DdzVm?=
 =?utf-8?B?THc0RTBEQ2JkOUNSaVk5RnF3Mms5L1doeTFNbURRUE9uZ1RmL2plQ0NkZmpH?=
 =?utf-8?B?T0w5V2JZNUl5YXRWcVdNM2RsbEtGR1I0aHJ2dlAwV3FWTjk0SHdHTms4WmYw?=
 =?utf-8?B?Vzlzalg0M2hsU1BIcEdqcDdLMXdXb1poYTdCQVo1SWVLbHlIUDU3SzY5QzRO?=
 =?utf-8?B?blowMXNSa29zck1HTUhrMUJ5MUJUdkZBY014eUp0NEJUUzFyenV6ckk0VkFp?=
 =?utf-8?B?NVo5NTJFbWtIWDhWYUtQanJkNERtYTZCN2FMM0FTangwQ2R0cHNYaXVyd2dE?=
 =?utf-8?B?c2l4b1RpNk8wTmVhSEFPV3JNbXloOFVRbjFOTTRkaCt0ZW9JMG9TNCtNV0cy?=
 =?utf-8?B?ZUZ4OWVsUVdJeEgyVmpqVTdhQUg2K2NvMzVCZm5RS1BCNlo3MHRILzdXVzhx?=
 =?utf-8?B?R3l5emM3Q3BUVWVVNGNISlBPZ28vTzdHZnBXazZFSTFrQlNZazllVXhuTzEv?=
 =?utf-8?B?ZmxWam82NmdkczQvUXZRNUhWaEY5V0xjSmM1V2dlQ3FORUJpSTdiMXR2NFJN?=
 =?utf-8?B?WlFxckMxRm5kYVdldkVLaUNacm1WQ2ZzcUpUMStDOU5pOGZhR09vdmlHNDVM?=
 =?utf-8?B?dkpBclNrRElkUXF3K0RFZzJmanBsUHdOT2ZyNTRHNnAybysrMnptaGtsUmtK?=
 =?utf-8?B?U0NlTW1la1NZd3Vadm4xVTV6L0VDeDY0S0djYzI3aUVkbDFHY3dyTEhmS2d6?=
 =?utf-8?B?cEVFbENWSzNpc2tOV1FWdWp3TFZxeVBwUnZ2SnA4WE9GSlhOVDU1ampnOVZt?=
 =?utf-8?B?NSsxekkzQ05xTzJNM2FLdTl1NHliZE5lMHh2TmJlU3NPNXJxUVhWMXhDakxH?=
 =?utf-8?B?czJULzU2MmNWc3RzMEcwM285NzlWRUNyNDg3QThCbVJza3VOSnZLVGlaZVU1?=
 =?utf-8?B?dlBKN2FFWld5S01aSnFCV2w1aEppVWZENVQrVTBmNkgraVhaRURDelJUMERV?=
 =?utf-8?B?SXRMZnBZcjhTcGdOd0d1QS94ZmF4ME1ZdnMrTUlEVDQvaU1uWFNFUDJJL3RZ?=
 =?utf-8?B?aXBYcGxZM0hDWWdIaTN1UlBHUkE2WThOaTFXQ0VUVG5GaGFUQWhCZzN0U25P?=
 =?utf-8?B?elJ0NE0vR0RMZlY2VWFiQ2padEUxbklkMDB5cG95TFNkM3JuNmhrZlYxZXFy?=
 =?utf-8?B?ckVON2JTVCsvNkxwdGJHb012YjBNcWZadUdCcHdUMVprNS9vS0lXWEFqZWVr?=
 =?utf-8?B?N2RIeU5DbjFMSVNNa2JMYkxjVlJnYzFrNDFCK3V5MVljaVNaT3pCRE43TjBY?=
 =?utf-8?B?Vk9MVTAyQVhraDE5MjZpMVlmQmpiNWZRbWQrKzBaWE1GYis4aUc3L1ZZYUJI?=
 =?utf-8?B?UjNnbFlGaWNzWlBDTC9lcjNjUzgwdThwUnc1ZU9EbUhvSm9RdmVpOEdGSmJX?=
 =?utf-8?B?U2dGalVKelh5d1pMWXN2cDNlbWZHcWd2R3MybzBXMU44SmhEZ2dYZ0pJOHVj?=
 =?utf-8?B?SkdWcmJIRDlvQ0RNQmo1R0RRYWFjRnh4aE1tREpTU2VPQU9FOUhCd3VLWGkr?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc541612-95cf-4876-8bee-08dcdc755cdd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 08:46:20.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3WTEKJbKwiB2Y84kKObxpEhJokwi/17nCcdmbyH01pc+MO4/9Qd5D5zkxQdUC4iryA72KXrI7amr6ujiEShvN4QYGR43/KfGhaudpGsobY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

On 9/24/24 07:52, Abhishek Chauhan wrote:
> Remove the use of phy_set_max_speed in phy driver as the
> function is mainly used in MAC driver to set the max
> speed.
> 
> Introduce custom get_features for AQR family of chipsets
> 
> 1. such as AQR111/B0/114c which supports speeds up to 5Gbps
> 2. such as AQR115c/AQCS109 which supports speeds up to 2.5Gbps
> 
> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

I'm not sure if this patch is -net material

> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
> +
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
> +
> +	if (max_speed == SPEED_2500) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +	} else if (max_speed == SPEED_5000) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> +	}

instead of duplicating, just make the lists incremental:

	if (max_speed >= SPEED_2500) {
		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
	}
	if (max_speed >= SPEED_5000)
		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);

> +
> +	linkmode_copy(phydev->supported, supported);
> +}

