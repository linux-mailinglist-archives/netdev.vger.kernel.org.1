Return-Path: <netdev+bounces-243467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE8CA1CC6
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 23:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76CA300C2A9
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D732DEA77;
	Wed,  3 Dec 2025 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKJp0KHS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEB29B8EF
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800084; cv=fail; b=txpfN9QAzCr38kg0KhX9Y7VFWyDoJOgGW+KX2pqiBRGnes1nxK3NjxIx3LNpsPvgTmgTSCbjvnBp4RdBAo+fK6L61A8/r54itXReDo+YbHu1kBYzTByz0OEGTKIoG96t2aFxeNckNIG0sk3I5BeUdNAZc74wqCdbjgUAAEcyKdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800084; c=relaxed/simple;
	bh=2YjAR7UHEVO3wTPHWOGI2GAuQeaLHJ22fM+y29rE6h0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kbXoqhc3xJ7iKswkmbMSmZ3QItu3lHDWE5IsANcUEoexRgcfVlshbSXmG2CZ4MCiHwILATx1EU1JUAiJ1x04qw/5NxjJirIn9oY8Tv4iYW4club3MJ7Mi0/yHPswMT9j0vSE252NBxJetMunmgfRj1w6hbHP5eWucRFeelxMyAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKJp0KHS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764800082; x=1796336082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=2YjAR7UHEVO3wTPHWOGI2GAuQeaLHJ22fM+y29rE6h0=;
  b=LKJp0KHSw7VooNzdEJfU3v+kSI9oQtjqBWwRhAWOCRiu5ggb7i7Nu5Zx
   oHTbT5nNGPwGiIfxVj8RGwfqEau2xtvqGkQCAjTJHH3PV9mKcPp7PXJ6K
   m9Yh4Ff4MfJr5lwj7OrIWv/lFjiDg4Tjwjd+Wruw7F3a02T4YyLDxKybb
   6U0Ujb0VzsGwzl8/qymTzhrj/+uFVQl5pi4UHiRSVMQGCjl49Hf/FqYdZ
   Wr4eyGDDVHWdyYPr96WWxdBF+k41/HOxwbjE8W+e1+jItV+bK7vLwx93O
   s/Tek6X74AsEMe1n9ngceR1GsyrusqtexXzSFBLRzhWBbc4u6fqRW6eld
   Q==;
X-CSE-ConnectionGUID: VQoT3b9kRMSTUfmaKLAd2Q==
X-CSE-MsgGUID: HVZs8o5uRAuWsDO5OMIZbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66000089"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="66000089"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:14:42 -0800
X-CSE-ConnectionGUID: 7K9Dpn24Rzyo7eb7t6uFJw==
X-CSE-MsgGUID: 8R76FcatQNegO52iMg9BBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="193880046"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:14:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:14:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 14:14:41 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:14:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYWMFHpx37vm3Q7g49Y1hJxdER+vJ3bqoEIX4hXEzaBtmIcqQ/yQl9nFyngJp8UCjPQfFEsI1qcPxqIroNiqG7Hh8B3L9gOAemY1hZCzuby++YlDrOSa+5Sp51881ahaglnC5DsEeQAs3Pi3MvVexRNgphjqgbmZv1nPs8PAzmbUNihAFNfRu/YNkG0vurOLV4V/Q/6UnGATlE4JWa23tW2UHuMl0YhLfv7MVIU4cO/Eer1GUiEMadCLG4XKQqHBbOQ+UIBKF1wcxc6+2qsDLbzUccaNNnq22sbAmbUTu6gOpBRNhi1iWeGRoqbt+ISv6XNimfKcCUvIcFHEA8OwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YjAR7UHEVO3wTPHWOGI2GAuQeaLHJ22fM+y29rE6h0=;
 b=DynX3nOgycksqc1APufNxTEnWWGAOiaHOu3IIYdAniYdc2wyE3BO4uRp+nN1Ff3CBoJH0FGVmCAyNEIberFN83J88mHlXV5zmfpKzoGX/lus4hbMRhDDM42Vxwwp3dTAvKAFc8yYJFns7ulNzX5EKzj1jwTvx9J2+BgTFdEbFm6fMFxeZMq+H5OWZ2IBjy6u1fE7sF+LRf0Z3TB0Apgw8YlEq80gC7xmlIBv780IlsIGJrTpPmV58SH0X1Kt/07X/ZjzrRj0VGVtSuaoq9JT0kUuArG187eM5gCShblfrL7KUYeGuoK2jjkRajjqzAOXXOFyBvYz1gToZ6dxE6zavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 22:14:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 22:14:38 +0000
Message-ID: <8311f3ef-7ead-47ce-9a41-4280a0c9fdda@intel.com>
Date: Wed, 3 Dec 2025 14:14:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 3/6] ice: remove ice_q_stats struct and use
 struct_group
To: Simon Horman <horms@kernel.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-3-6e8b0cea75cc@intel.com>
 <aSWB_yLwW-DKvuc_@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aSWB_yLwW-DKvuc_@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7yQhgNLQ2Eeige10roRGzLKS"
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e68f0-44f3-48bf-21a5-08de32b95947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmdzWkVLeFAwdXJlNkZ0VkZXMmFVQ3ZZMDNsajArZDZ1eHkzYjI4bXZEV3VN?=
 =?utf-8?B?K2lOejJLT0l3VmcvZVhDUUprK1hGYWJYanVPcE8yYzhtNUVHNS9pRFZmczNv?=
 =?utf-8?B?UHJEdkFKNGdPQmkwOWhkS2ExZ2UxclY1M1RpdjFXVWNvNUpLZXhIUmpnTGI2?=
 =?utf-8?B?T1hiNEhTNVl4S0MzcEdJRXdiSUNCVkRjOTNYTjFLNmpQNEx0VGo5NUtqTXV0?=
 =?utf-8?B?T1N3bUtPNVNUMUJjZENLOVNvd2ZQYk94Yi90UWdGRko0RlRPQXFYdWNnTFpx?=
 =?utf-8?B?RlZ2ZHJ3WjNBTjJiakFvWUY2bWsycDNwU1RHSVhtcHkxZXFuaGI3T3ExTGFN?=
 =?utf-8?B?aGR2T05TVW5zRklmMGZwZ2N1Kzg1RW82OWtaU1NGUlZ6cjNZWG05cXdVTHJp?=
 =?utf-8?B?MUxjR2JvZ1pBb3ppWXYrK2o0MXJzVXZiUllVLzJaeVJNemNReTlieU5jRGZI?=
 =?utf-8?B?V3lNRnErVEtIKzNlaFhCQTlTb3ljalBqT2daSWNvTldKdCtEdnJ0RXFHN1ls?=
 =?utf-8?B?K01xM0NUSFZLYlA3bFFHVzRGS1dGV0FVQlo0bmp0bGg0SFBRVkFUelQwU0Vs?=
 =?utf-8?B?eXl6TXJ3RWFkUVltWlM2THdNYXB3L1dKeHdza1NSbzhsZ2N3V2NEcTFpcFJZ?=
 =?utf-8?B?OU5ySXBhaVVkY3R4WlhTYmRaSjgvQ05ZUFZtMVZETkNHa1Z0TzBidlJ0OG1w?=
 =?utf-8?B?TWFzS2s4MmoyYXdSSXVFTlMwMml5NGdaeGE5L01nNUZIQmJRekUxdlpYazd6?=
 =?utf-8?B?SnFjMTFpL01DQmw0c0l1N3dhSDNOalhGOXo2SDY4K09uUkZaNWNUMk1lT0l3?=
 =?utf-8?B?NTBObFdSajJLcXd6cWhTUTlhSjFkdEdhdTQ3M3hlL2gwWktpcUdCVG1hZGRP?=
 =?utf-8?B?VGJLaHVSOTZ4VnllVE02QU9hVy9vZUdjT1N5WHdKNkllMUM4QkRHTkl6c0xY?=
 =?utf-8?B?cGR6NGUwVEZZN3BaN3dlSGQwcGo1cHF2dmlPV3RlbHE3aFRHVVlSTlpielV6?=
 =?utf-8?B?NXphcDVhak0yRTdIUFY0VFNLK0NBZFYzVitkcCtVTFU5MW9Ud0ozR1R0WnJO?=
 =?utf-8?B?ODhJYU9DdXVZd0VWaE1yZ1NibUppTlk3RFBHVTlNRkFKbzVzb2MzK3NKdFFS?=
 =?utf-8?B?SEhsUDhMSnZlOHoyL3NlY2FCUDBNcnVacWY4MnJnQ25UN1kzMEViaHFCZmx1?=
 =?utf-8?B?c2l2OWwyNUVmVHlVTTZzNTdOUkJKR1h5c2NLR0pobkZ3L0FYMmNhYVUxOGJs?=
 =?utf-8?B?YTR2TGg4MjUvUjNJM2FNV3pvNjlJVFFpU1JxRWdmckQ3SVVaOWlvR2wxUEdZ?=
 =?utf-8?B?Sm5pdUlRaU5vUnp2TnJwY2NEMWxXRnFMRXVDdm5Qc0g0d2huelcwZUR6RktQ?=
 =?utf-8?B?Uzd0b0xXakJ5RDh6VkhFQzFVaHNLUkNJRzA1RVV1MWwwNWdxRGE3Y2F3cStS?=
 =?utf-8?B?MXFobTQ4V3Bna0lZLytkd0Z0T29mWDdBMG85RXFRa1JUQTN3MFRSR2RyRk9y?=
 =?utf-8?B?KzRMTk9jN3lSeDlCTDdTc2RiTjFrWTRqUGpLb1UxYjBMM2Rzay96eFV1L20x?=
 =?utf-8?B?d0xYUDdZR1Vub0JyYUJpc1VIMm1jUnVMcktkeWFzRVlpUTcyYjBCb2dFR1FX?=
 =?utf-8?B?a1M1M0VibFhkWFlYUzltb051NkErYTlmaEhrRUFnbjVBL0VValg0SkdZaCs3?=
 =?utf-8?B?ekZ6NVBNZmtuMTdGaU5wMGdhNitMQWFlam5rMldUV0h2SDEvdHpFUzJrSUZM?=
 =?utf-8?B?VnNlQW16eHBQazFuYmo1SFRpWWsySVNYS1U3dVBiY3dVYlR0cnprZlQ4V0Rh?=
 =?utf-8?B?VEpLWnVSY2FneEt2RjZ0aUJkYTVjN3I5NklTdU9mL0I0a1IvdHE5K24rb21j?=
 =?utf-8?B?cDRjeFA3cC9zanVnS2tCTktsN3FDQThRU3BCbkd6NVg1eTM1ejIzM1FacGpO?=
 =?utf-8?Q?spUn49GO/8rm8FUPDyYRDfbpLxavLbXe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxFSXhiMHc1dHBVcDhrckZ5MHpmZ0RGTUZCWWc1d1BncisvdjRMZk9Zb3FY?=
 =?utf-8?B?UVhudlJlc1NxTy9yZE1NOVUyOXRwTlYzYndMU3RlbjNsU01UYXJ6djRYQ2t1?=
 =?utf-8?B?T09SckFmQTNzdFNDMGtCKytMZ2ttZzU0WS9zejlPUlA0SFNqREc2Z2JEcEVG?=
 =?utf-8?B?Tm5aNzY4QkFVL0k2TkdlWWZ3d1JCYVBqL3ZFdXcyZnZHMEtSMlZyWUlZZlYx?=
 =?utf-8?B?UEVMb0VudWsxSUlvcVM2eVduTXpSUitGVzRHbUM3d0dOODBOL1hvRW5CdUpk?=
 =?utf-8?B?UkJ6RjlOU1BsMnJZaEFxdFF1U0prQVFOSXd4WE5udlF3cUlydWVmSS9CTGFH?=
 =?utf-8?B?QVNJY081ZXp1NU9taGJUSFRPaHVQV2puak1hd0QxWUx4YTBtS2VHSm5sRFU3?=
 =?utf-8?B?VkFUM2hwdTQ4Qy9mWitNR2gyOURDZm5uUXFpMWQ5L05ndFN3aEpGTHYvQUdi?=
 =?utf-8?B?ZUtsWFdqb3RXTlZIMk01eTVXT3Z4dERoaHlESitvR1ZwOURZVkxkOHVVYnZw?=
 =?utf-8?B?d0JidmFHOEQvbUdjaUFtZkhwZHJNbnovckN4QVZ3L2tRQjhlZmoydTU0YmND?=
 =?utf-8?B?dFZzbW1NQmNqUFhRNGxrcEtXOFdBZ3UrZjhxaDJmcHlrM1QwZ0QwQVN0MkZP?=
 =?utf-8?B?dmhhRUgzbGdxWHVUeDJ2bEM5cnJ3MWFQNkVzMWt6b013K2Z1Um5BemROMFlz?=
 =?utf-8?B?VC9EcnI3MEl2RzdmTFA1TUJjOVdGUmllWk9VQTlOWDc0WkUrbENpN2x6UHFY?=
 =?utf-8?B?QlZyNW5IbGRBeHdiUFptT2NQbHRkVE9Ldyswck5zU3FHMENyY3ZzR3pSTXVJ?=
 =?utf-8?B?YU1PbjQwK0xoemtWcTBUZ0pIQVZjbkZ4aVJaYk9iTjFlRHd2dTd2eGFLRE9B?=
 =?utf-8?B?ZUVnVEdLaTFBb0FIbG16M3BLcWU2bitIUGlXZ1hDa3J2azFNM2JjalNyL1RH?=
 =?utf-8?B?OUxpMEtzRWx1TFhCZDVzTjEvMVZDNGh5R0RDM2pDSWR3V3Zyd3lvakJnUVVS?=
 =?utf-8?B?YUdLeUFGTTZ0WGlBcktyeW5XWDdnM3o2MGpnMXdBQ1ppM2srN0FkUGhMS2Jk?=
 =?utf-8?B?YURkY2Z4cFVkWnVUSDhSZGxFbC9YMEhWanN1eE9mWTVtbWVCdFdXQkd5UWgy?=
 =?utf-8?B?VnFTbkxEZDVkVTErSDFkYzBZeVhhdWpFSFM0a0pPOEphQlorNXhxN1BoTVl2?=
 =?utf-8?B?d25aK1pzNWl5b01IZmtlY1dZS2lnZ2lGc01XenU2UzZleVhBQk5LOUg2enJY?=
 =?utf-8?B?V28yenRXcWNBcEhBWUIra0p5RTNDVnRIRlBDcUdPWis1S0RMeUVXcGgxOWRr?=
 =?utf-8?B?ZVBuRjQ5cUJZU1FIajZZNE9pVWk1OEFMVFdlb2NnVEFSNnk2OHJaSzg5eENi?=
 =?utf-8?B?ZnVIL0xib0lBV0VoQlozZXVzZ1hSdVFRMVg3cFdGWlZiQjZLV1o5c3pnYlMr?=
 =?utf-8?B?VGNjdGRKQm1MRmpzVnVDVk5xcFY4QUcyV0p0ZFR0ejVqS1EyNnpiYUVKTWRF?=
 =?utf-8?B?WFkrbGNOWStod1JWbFlDeVpJcTFBRXNDNHNPL1I0MW1kRVFpQWVyR2JWMzFQ?=
 =?utf-8?B?MnNKRGV1bGRnRWVXRlJja2dXRXMya2ZQRXBVU3dBa255U3dmeUJCbUlaWXAy?=
 =?utf-8?B?cGw0akpaY2VBSXFhaS9BSkl3RnVoMW9jLzc3U3lGTTZITjFFQ1hQMXhFeHNj?=
 =?utf-8?B?aWovWUVvdXFrbVlwU0FVNVpiZDVPT0lDbzhWK2V4VG4rK1YxQXBXRFNCd00r?=
 =?utf-8?B?SmtYd0NUdE02UnFZdU1UdDM2QkZiVUE3YmtWUGlUd2ZCMWFNbkFDQVlOdEg0?=
 =?utf-8?B?UHFVekRSUjZvaHNxZEFvK053TVo1ZkorNEpTNWRVVU4xTjIybUNwd1lLZHpz?=
 =?utf-8?B?YXNBTkNOdDZha1hFUW9TTEd4d2hyUTlqanAxOTNDOU1VSXl2UDEzK0YwWW12?=
 =?utf-8?B?ek5TcnZ5OEhhMlovSW52S0hiSVFvcVFLL3VmYWdobVpyVWlCN2xhY1hsQitp?=
 =?utf-8?B?NDQ2eEFlVkp3SW0xa1NOTUE0WEQ3NzNjNWNaMEVVT1MyZ1NIM0tNZzh3Y1Bv?=
 =?utf-8?B?OSttWGxiNlpVckt0Tms5OTZFUUhlNHZkNS9Ud2grOUYveXdpQjZyYjFMMHpx?=
 =?utf-8?B?MVZSV1lDSmFUN3RKUDJFSVRnc1N1V1JQS0I0WVVZbzJXSG9qM256dU9VcnlV?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e68f0-44f3-48bf-21a5-08de32b95947
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 22:14:38.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ICVueE8hzGosoUAx7PLqGyTPYonuyvBOR72qLdfWc32c0s3RiYPNfxWbztcwALhV+mYrRPjYptM6FI7ocOcqdGjanwxXXGLFGe19vkAuxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8589
X-OriginatorOrg: intel.com

--------------7yQhgNLQ2Eeige10roRGzLKS
Content-Type: multipart/mixed; boundary="------------uBAccQIA4nqvgFdrUUUSaS8v";
 protected-headers="v1"
Message-ID: <8311f3ef-7ead-47ce-9a41-4280a0c9fdda@intel.com>
Date: Wed, 3 Dec 2025 14:14:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 3/6] ice: remove ice_q_stats struct and use
 struct_group
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-3-6e8b0cea75cc@intel.com>
 <aSWB_yLwW-DKvuc_@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aSWB_yLwW-DKvuc_@horms.kernel.org>

--------------uBAccQIA4nqvgFdrUUUSaS8v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/25/2025 2:16 AM, Simon Horman wrote:
> On Thu, Nov 20, 2025 at 12:20:43PM -0800, Jacob Keller wrote:
>> The ice_qp_reset_stats function resets the stats for all rings on a VS=
I. It
>> currently behaves differently for Tx and Rx rings. For Rx rings, it on=
ly
>> clears the rx_stats which do not include the pkt and byte counts. For =
Tx
>> rings and XDP rings, it clears only the pkt and byte counts.
>>
>> We could add extra memset calls to cover both the stats and relevant
>> tx/rx stats fields. Instead, lets convert stats into a struct_group wh=
ich
>> contains both the pkts and bytes fields as well as the Tx or Rx stats,=
 and
>> remove the ice_q_stats structure entirely.
>>
>> The only remaining user of ice_q_stats is the ice_q_stats_len function=
 in
>> ice_ethtool.c, which just counts the number of fields. Replace this wi=
th a
>> simple multiplication by 2. I find this to be simpler to reason about =
than
>> relying on knowing the layout of the ice_q_stats structure.
>>
>> Now that the stats field of the ice_ring_stats covers all of the stati=
stic
>> values, the ice_qp_reset_stats function will properly zero out all of =
the
>> fields.
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> I agree this is both more consistent and cleaner.
>=20
> I do feel there might be a yet cleaner way to handle things
> in place of multiplication by 2. But I can't think of such
> a way at this time.
>=20

I agree as well. Potentially some structure layouts would allow us to
get the total amount of stats, or we could count the number of Tx and Rx
queues separately.. The driver has some effort to allow varying number
of Tx/Rx queues in some places, but then lacks proper support for that
in others. In particular, the maximum number of both is always the same,
hence the multiply by 2 here.

> Reviewed-by: Simon Horman <horms@kernel.org>


--------------uBAccQIA4nqvgFdrUUUSaS8v--

--------------7yQhgNLQ2Eeige10roRGzLKS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTC2TQUDAAAAAAAKCRBqll0+bw8o6Aqd
AP9Q8TwrPHzSEGWiuLWOZc9vI05lLN98R6H8Yo3fijRMAQEAlSrdVVfcCtxqrFy5nkX/vtioklI9
S1pWPlvx6vFPBAg=
=HNlz
-----END PGP SIGNATURE-----

--------------7yQhgNLQ2Eeige10roRGzLKS--

