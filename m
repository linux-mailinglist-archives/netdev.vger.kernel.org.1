Return-Path: <netdev+bounces-217091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A23B3758B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C6C1891C3B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D223009F6;
	Tue, 26 Aug 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svm3YDFU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0A3093D7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251081; cv=fail; b=rhgDFMPfhyLQ5nn5rCfK6ajhQ1OCgZmoEnGGUeXBNIs3Q8+4Abi7idGuGup2YIcsujqnxD2q20kDafUbXH7+Iz3tiEi8eGTLhu30yE7bWWTFnIfEedu3TqhJW1v2PoznjbCjtXHn8NIu3RUWVnL4LqS609SjEp7HNCnGd6eWf5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251081; c=relaxed/simple;
	bh=pnQOZer11KuC7/yOuyC1AY1hQIviF2h0cBIB3cgdxoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CgJUGgj5JE2NziBn9vbJtLel+s/Kr3pwSy37b+JeRkjbnqUxuXyiJjGUCmh72KjRbnTBfLJjT6B1UD7xsFLmxlAvjiheSi2jBQMZNaZQJrPZJsQ8Kl213W+NmneoGCDdPSqqCau/AQep9tIMeXc7fh7fWV/Dr5jFV3272G+mtE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svm3YDFU; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756251073; x=1787787073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=pnQOZer11KuC7/yOuyC1AY1hQIviF2h0cBIB3cgdxoc=;
  b=Svm3YDFUG9fUdjiqh2XI+4vNcGPcsjbz3M6XO9s1N/+kSg4Yp8dod3AK
   h6E3koapZ0T7ev1VAObrUNk+3jAW1Od75iKbEP0bO5pLWz5c9UIpoQnDL
   ZeKCLc6H7ExmN1f4gpxOgMOBtpkSLPGO8sCdYIwA1+GkrFifz3wnDf0VP
   0Im44Mku+br21Pm0jckoJSyLxa77d1m53+6uO7P2WrgXc6qRsj8wpFp5o
   EXe8AbI7IrbCqJB4A+MNObCQrv6B1e5smLPZSdwbI+Za9ew66ob5vZuq9
   amXZ8MxCl5bsWyb4L4cussrCMwXxWTLvyDJrcDazzxFFL1VdYyGVfyi8j
   w==;
X-CSE-ConnectionGUID: NIfBh+0/Quu6eLWqHkB4iQ==
X-CSE-MsgGUID: GxVhwAasSJmUzzzZnaBieA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58210860"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="58210860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:31:11 -0700
X-CSE-ConnectionGUID: exxXTRLTT4y9IbPeN254cA==
X-CSE-MsgGUID: CZk2xhbeSSeYr6ieCi5Dtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="206863516"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:31:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:31:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:31:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.89) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTLmddBWN7b+mTmkkPIXFl+D56MUXo5032XC92gsGDQZKjDMo1cBGTKXS5kV+tzlyjJ71tG79v+tEE+wXHqetOLkGP4YowHLRxkRckzOC1SG3eLAXOBDRB6d6Mk/nxcfEPaN/fEU9GbUDQE97zxS3cCbDmKyMfPyI5frJe5t51BxHY+h/5UVSmpAWKWRHOHmVzuOaD4AYTHcI4GmEW5EHtx0pluWFtoSTrc26H299auzRD4pvC6xF/nFdduQAarSTzMhckbJBcKh9SUeodxnGHAD7RyUm9wnzC72wpleq97J4HjqUicoR0DaSNj8YNZcyi87Y5xXpeV81h1hOFW5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnQOZer11KuC7/yOuyC1AY1hQIviF2h0cBIB3cgdxoc=;
 b=hNqIUeVjUSWf3J3bVXM+T1EaG9D5c2bnmgyA6RmyCojzRUp5Ko8Q82e0ogFsaKLruApJ62G8UhbDtmSpXajmaY8qUCRrhaONU3Zp8Hxef2v5Kjap34LFMluOBtrgvyEtEYYlw7yJCQPLOfrrVfvM9Ckp2Rf5WpgPoScbVNlQM4kkUU7H8slEmYASfUG+1HHQ2NryPlOXvc7vMhCTdYtHusHvhy6Xogw0PwUasNiigRErjpff7ZaZ9N49WMJ5r7qBcriMQsgV9pNmSPpgDDqA/S19yPwNdHVxlMpHnYb1epUROpOuQNIwzEGnmlbWKx9LVEWpuusaTyfvK3QhmZRznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:31:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:31:08 +0000
Message-ID: <72f6da73-fb71-4e6e-9c3a-d4fd846abb8a@intel.com>
Date: Tue, 26 Aug 2025 16:31:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/6] eth: fbnic: Move hw_stats_lock out of
 fbnic_dev
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-2-kuba@kernel.org>
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
In-Reply-To: <20250825200206.2357713-2-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Dw9rjDWUupciivrwXEjmQhsy"
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd3475e-f936-41d4-5194-08dde4f8a22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aSsraW1Tc2pkY1VuM25hR0RBdGEvRDZVamZpbzdBSnZRb2crekFGdW0zV05J?=
 =?utf-8?B?ZEpBeHRyMzlwTW5mZWdKQVZFdVorSnBjZ0U0MXhWOGV0Y2dIdjU4dVo5YS9q?=
 =?utf-8?B?MU5pQXQ1TmdLRC83TmNYKzBtLzNVbmtmVGtiN2k3dCtRNDNHWkJhZFhrTWJt?=
 =?utf-8?B?eW5jVHl5OXVxVENnUE1tNVFlaituRHVXQjFraDk5TzhlekRNV1MzMkc5SGE3?=
 =?utf-8?B?RlppVHM5YjFYaXYvM1A5OTBDMGxJbmlRT2pSTFVmR3dlSU9qdmVKcnY1VFVr?=
 =?utf-8?B?cVFuakkyR0RkN1NrLzJla1Mwc0VxV00wUzFkS2pGZG1QUWxNaWJLQjZVTkVk?=
 =?utf-8?B?bXVHdkhmT05nQVdMOEhjL3ZkTnlQRVozMjBDSUVicVhxcDMrZjUvQTRPTTRQ?=
 =?utf-8?B?cDhQdm12bUkrUCtadWFmUXRlaFJURlJSS0YrejlMOERQRWtEQ2FSZFFvbWVx?=
 =?utf-8?B?Vmg4S3h2a1NIVXJieDZacUVUQm9CMzQzakVsN21jcCttS3hVMTdGMkZMOFFr?=
 =?utf-8?B?TEh4OWJLQTVJZHRHSXB3bDdaSURYLzlUT0VSK1ZoSlpqRE1FWk9TazJxVmYw?=
 =?utf-8?B?TEFUQUliemU4V0xkZGlBbTQxOCtVbG9ndU82c0xmelZiWVhWdFIraCtxaXY4?=
 =?utf-8?B?NFdiOTlUZ29qM3NaNW4ybnVqYU5renFub2RGTnVReUM1S2RCSzVjUGt5T0FH?=
 =?utf-8?B?MDcxNSthREcybllud1V3QktaWmhob0RxblNmZWdqcEhiamdWVCtFR2g5Q0tJ?=
 =?utf-8?B?aWFiM1lrTDRUcThQais4RHN0bUlhVkRHeE1RVlJzdFMvWEZaV0lMQmxlc3Z2?=
 =?utf-8?B?TzNZL25EVXNka1N6WnpHVWJTMnhCam92YnkwcXk4a2x4VSt6QmFhSThjTHlh?=
 =?utf-8?B?V3NqTHBiYUdXc3J6Nkt3eHVDNS9XRGx0SjZNYTF5Snc4ZWFQcER5MTJFTmZv?=
 =?utf-8?B?S2VDMTZQczc4Wld4RXhCT2xKbFpyOU5QbjVqUEh5bXVjTnRJbUNsWVFoN1FT?=
 =?utf-8?B?WjBvUXVGcFJmNExSZyswQzB4clEreHBTU28rV0lnQmpiMDFGdW4zNTgwRkdO?=
 =?utf-8?B?ZGlzV2F4empPRDVYcmx2NE0zOEcxUDZubWlVQzV5K0pnVUJVQzJvRzYwakEv?=
 =?utf-8?B?cTk4Z3FGVUlLeVh4bUdQcnhCdEVWUHE4VlVHSDZQRWY5bEQ0WWR6V0dpdmpo?=
 =?utf-8?B?YlB0eWtVc1Q2RklMUlQ4dDNTdnpXSWNIRWRZZG5uMTVQNzhxNzV2bmNvUzBp?=
 =?utf-8?B?WEZSczBmeDlUUDk0SlVXNXBodGJXOXVkbTZUV210Y1plNERBMEMydDlKZWFt?=
 =?utf-8?B?R25BRDNXdngzSWNrcVBuNURNUWsyVG9CNE9ERnVnUndIWHFjNU5xSnc3M3Fh?=
 =?utf-8?B?RWpydjNWeEVaWkcrZ2g5Rnp2MTgrZHNjZEN0RU1OQzZsdDZDdEk5TXgxeVhM?=
 =?utf-8?B?b2lBU3NXQkRyWkNsRlE5dU1OYURUQ3B0WHlKRkRIRkdwUlNHQk92UEpPSm8z?=
 =?utf-8?B?M3QvWGpkcHNFaUc2dVhRcHEzRERXeERJdmJuKzJUQ1pLUDljSW9razBPQmlu?=
 =?utf-8?B?Yi83M0hhdVRUVDM5MUp2aC9za29uM3VvOFZhYlptYU5DbXFnUGtvZFdIdHZG?=
 =?utf-8?B?TnBYYWN3Wk96L2NSMnJiZ29QbU54dG51cmQ3dHBtOVZNRWhVZHpjVW9pS0Jk?=
 =?utf-8?B?MElDblZLNEt4OW45Wm5adHJhdXg2Q1BlVkdmU1pKeWMvS2UvOFNXT0lmS1V3?=
 =?utf-8?B?dGNoQnhBZWx2Wi8rdjB4UnV0R3Zycy9tZWM3K2Q0bWVIbTAwM2IxdmNzNTB5?=
 =?utf-8?B?UnNUL3h1aUNiTTJ3OUQrcXp1czdjeERZWWUxcEJJeWUwUWNTQXhPR0xvNFhh?=
 =?utf-8?B?OU1WZnQzSXV0S2Rkb2JuSS9aUUJWaTY5ZGFvRHBuZ21rdUEybTJDd3VwSUU2?=
 =?utf-8?Q?PrVFrdhddpc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmF0anhhUmlLd2c4ZkRJOGw0MXgySGNPOCtsZkxGanNvMlhKQVBCdDlnd3pi?=
 =?utf-8?B?VDh0dWRad2VEWnN2N29tK3FNbi8rd0NvenFtYzk5clhxTlcwUFFhazY5d3lR?=
 =?utf-8?B?bTFSRXhmeWp1cVlpdlU0TmI2L0tjR2NMZWhNdk1MTkVTNUc5cUw0dGZIRDlP?=
 =?utf-8?B?MDYzbTEyNC9CNmlSVEZ0VkZqWHNIZTNLaC96c1k4MUl4bUFjUGxxb2NDc2V2?=
 =?utf-8?B?WlRaK1kwSmh2Snp1UFBkSVlYSUE3SWFCRkJZbE9PZjJhYWZxV05wZW03T2Mz?=
 =?utf-8?B?RjdGc0VVeEhMd3dvQkVSODZreHFHOVBoRG9mUnZpZ2lzWlh1UGsrY09XazMz?=
 =?utf-8?B?TnhBSWpacFJRcnFQUnZvUDVzSGE0NjFsOUh6enN5d0pCdHpySjRiZ1pDWFhp?=
 =?utf-8?B?MVdid2dFR2Q5N1M3Y2JmdTh6S3MyL3FKRUFyT3NVeEJNZnZ2MERsbjIwWjh0?=
 =?utf-8?B?UU1hbXEvVDlkT0hnWjJBRWNsaVhaKzlQWGRGQmhmRHpNbjdzNVNzOHJpOWRG?=
 =?utf-8?B?SE40ZVIxZElLekk0Zlo3YWR1M1QzZ2FUYW1ubXpENFJ4bS9rcVEzalFLYytG?=
 =?utf-8?B?VVlHbWdCUXMwRFR4eXFRR2dKNUo1TmdXck4zSlpCbENLZlUwTk9hUUV3TnNS?=
 =?utf-8?B?cDZSdUNiRXc3Y1VnbndaUVp3RTMwUDdwT002V2tlaVdNVEIxeEwzdUV0R3Jj?=
 =?utf-8?B?Ymo3dGJUNHRIZ2lZdGwxUkJKMXlPNlpmTmpMKy9ZbE1CVXQyY2RVVlVxb3Zq?=
 =?utf-8?B?d1M3SjJqMXgwWEpydWx0ekVxSkZwSDFWV0V3RGp3ZTlnYTIwcG1JZFRucll3?=
 =?utf-8?B?RWlSQzluRmp0cUFZRHlwNUJHTGw1T2d6U1h3V29pTVI4ZFBBUjZSbmZISVdF?=
 =?utf-8?B?UHVCOEtncjM2YWFqUG56ellsNDB1UFBOY21pMVVoUEpVUTFsSko4NGs2Y0hx?=
 =?utf-8?B?eDZRRE02V2cvODB3QlR3a09Wc0RUYVlxdFRKWGRrSnJvWStWSUZMYm5ncW1n?=
 =?utf-8?B?MW1JMU9KRktaUmt0UXhWbW1kVXkwQVMrOUl0TEZIZUV0ZjVxYWlJVHc5OHli?=
 =?utf-8?B?VFR0dW5IMmFvcUpJQVV3K3o1ZjRLbVFRcUJNSFVTVHVnV1RMU21HVW02OERI?=
 =?utf-8?B?N2EzUVFVeHMwNlM1UGhraTRMcTRtQ0RSSTNwZ2plSXVRdWg5ZEpNQ3pZdlhh?=
 =?utf-8?B?eW9ML0wvNFVRTFd5bVhpS1kxdGRSUERrM0xuZG5qZ25JQWRjWXgySDNZa3lX?=
 =?utf-8?B?NUVlS1NVYnlxRmNsMzdMdVBWVEZlOHRCSW5Lc2YvVGNsUk9RdHB2WjBLTXJK?=
 =?utf-8?B?Y2hPQ1pFTEhzcmtISDVtSDBUZ29yaVB0QjQ5UlFqVU9adHBDYmpkRG12cHVN?=
 =?utf-8?B?NHdjUlI0OWFuemFJNmcvaGZ4ZlBHdjUvZVBBR05rZnppQnZmMVB2ZFBFTFUr?=
 =?utf-8?B?VGNhbFkxMVJyV1JLMExzbVFDMEJsNC90V1hGdGZUWGI2VzF5UGNOY3J1Unln?=
 =?utf-8?B?c3FDd0p4RXBSQTNES2t0SzA1NDczOXlROWV2eWluVWN6U2lkT2tMaVUwQi9m?=
 =?utf-8?B?NmRIQ1hhWHQyajZ3aDl2azRSMmx1aTlvK2dadUp0ZEtFcm90SkRNV3ZsYlVK?=
 =?utf-8?B?MkVyblhHalkydnJSQTdkVjNuOHVVQ3JTK0pXaElhVHVyN1J2TVRyNWNmSjRW?=
 =?utf-8?B?eUsybkh6cUppTDFYdDB1T0ZaWVFjTjg5d0lOUEgvb1c5Q1JwVm9WUTRjWGFC?=
 =?utf-8?B?OEZsekE2aWJtclNVTGxzTDl4SXdnTjhhN24ySG9KNW5rUlFpTUx4R282ZVhX?=
 =?utf-8?B?M0x4WU5sem9lMXdocXZUdlFhVm1nL2F0NjMrd0Q4aFY1c1lYd08vNk9MWlNz?=
 =?utf-8?B?K3dSWmJkN2xsaXdsZkJqVkhteXhaaWxQdWNFT1cvbTkxMFhQTmszdWQ3ZnVQ?=
 =?utf-8?B?MEFiWnRqM3lEMzFpYXlvakg1MktZQjJOTmw3eTVQTXZHcU1maDBMSldoTVp4?=
 =?utf-8?B?TzZnRmlsRDAybHVVcHJicEg5RFVQdHF6NWg2T2RCbXRhK1NxVXpnZEF1dks2?=
 =?utf-8?B?cisyMnBCUXhQVTFMUTNWOTZvSHY0cXBEQWFFVitDRWcrM3RIMEt2OGU4N0NQ?=
 =?utf-8?B?dzljUHFHaFNvWDNZdHZEb3Z0TTJGdldBdCtNS0tTMTk2dEhIMDFSeDAxVkxr?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd3475e-f936-41d4-5194-08dde4f8a22e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:31:08.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P/v9Ss5U5xZMSTEWCB2dUCsxSj3btPoA/7xezX8X0YUWnnK1mmRfAjwdoGUwS+7i0nK3jlLDgjoQgJqdt2OgIljx1KuXwp/12DISzOi5OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
X-OriginatorOrg: intel.com

--------------Dw9rjDWUupciivrwXEjmQhsy
Content-Type: multipart/mixed; boundary="------------SnivpiJTL6NKVaLomcbbmust";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mohsin.bashr@gmail.com,
 vadim.fedorenko@linux.dev
Message-ID: <72f6da73-fb71-4e6e-9c3a-d4fd846abb8a@intel.com>
Subject: Re: [PATCH net-next v2 1/6] eth: fbnic: Move hw_stats_lock out of
 fbnic_dev
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-2-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-2-kuba@kernel.org>

--------------SnivpiJTL6NKVaLomcbbmust
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 1:02 PM, Jakub Kicinski wrote:
> From: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Move hw_stats_lock out of fbnic_dev to a more appropriate struct
> fbnic_hw_stats since the only use of this lock is to protect access to
> the hardware stats. While at it, enclose the lock and stats
> initialization in a single init call.
>=20
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------SnivpiJTL6NKVaLomcbbmust--

--------------Dw9rjDWUupciivrwXEjmQhsy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK5DugUDAAAAAAAKCRBqll0+bw8o6PYm
AP0aQof+AIZ5K2K14/DtPwazrJ/9PTyDJb5mFsvboEYvDAD9Hwdn6MkewLNjXoKwgwQl2zP8UHpl
WgfPv9E/Eq+dGAk=
=/w4D
-----END PGP SIGNATURE-----

--------------Dw9rjDWUupciivrwXEjmQhsy--

