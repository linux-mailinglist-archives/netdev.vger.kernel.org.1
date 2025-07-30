Return-Path: <netdev+bounces-211087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29EB168EE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D83B9B39
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CD22B590;
	Wed, 30 Jul 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn0s5a0w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C8226D04
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913554; cv=fail; b=UPM/6xJdj4e2QJlc7q3vgt+9Hjj/o2irjep9NM2L/o/FweIxoIMmnVWfVkWnBk9VpBSqbaB0Ffyz5m7HwxmIawSAGp7KIlAUjjI0Sai6ytDT1rKU29Z/Br9jHpBOcXJnoofhC4cLhO4TSgVxuI8w89GsIGhCt+mxtbgGD7nvZUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913554; c=relaxed/simple;
	bh=TWqEf01hpj0TAyVwUdfXUY5PA4ZUy6GdiFJxP03SFlU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfgJFUHUjv0CySbd4Iv66XTwKUYjjnCGgCMh0Xv09UzvVdz6YR12WoAsZJ5+ltopgRMrAIqvxyK2vaZnZDCEVN1LCBosMZmCjWVhStRhV2jY/JtEODDijSHbWKSNXnuoOl8KIZO6DzYhLV3RnrkCt8xJFhw385M+KFq4HmxfbTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn0s5a0w; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753913553; x=1785449553;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=TWqEf01hpj0TAyVwUdfXUY5PA4ZUy6GdiFJxP03SFlU=;
  b=Xn0s5a0wlDaZfFXaAkcHwKezEfDiUp3v3zeDFNP8VCeXJ1kyKqxwGljW
   tptj8FbLHOMe1E2rKNLk6rJaQKfxjthWFEgDNWOWAU7bEBgyEXP6NkRPC
   Yj9XiHq3jCGxPiWZ/NxQkt+0QQ2JO1YWxhOFwv/oKoJno9dzmQPRVQoBh
   MoWdZ0YwIwcFqipw2FlNHrR2WBeDxlvijfj2VwY+m6GZvmZ0ijxYzHDib
   BkfiVko8TbbQ0JxDb0yoIqrkjTPgcBCwQgN52nLa/GMYlYymQVRg51NC1
   kXlLlBmiqN/m+BV1CbfchPH2R/2SvPOYZGWWQDhdrcG/hIbChJIyVRXxg
   g==;
X-CSE-ConnectionGUID: C4U629pWRWO3XXxfokVdCg==
X-CSE-MsgGUID: yqzqKVwiTLepi8eX9JmtJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="43834518"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="asc'?scan'208";a="43834518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 15:11:17 -0700
X-CSE-ConnectionGUID: ROMvHuhKQr2asl/T8rqB5w==
X-CSE-MsgGUID: Jq5c18EkRWGvI9q25w0/wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="asc'?scan'208";a="167584620"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 15:11:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 15:11:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 15:11:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 15:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Tyi2vSOmeX89xdxWlKh2/rrCNbTPD/Y7EC0f4F2hMAERg5jcHU8tDVnZiqhFP316eSRrK6YhM+CnG4YSNm/ipJF7y4kusJRg2OjVCuXqr726NdY63+itLHqj5f0e0MtgswWPqEfuoxFStNL9ByWHrCANBK6dl3JGwn9kz0DGxJFBVsU6KmOGKZSohcJZ+scoXu415BEKL075p7aRVS2pP/SvPOPtNeSzIZGxyydERB454a9phYeou1Z3WdLpOj10TMPuMpqaF+IYRcYmwoUlXdJkJlo5hK7OHmPDVNx9+JhHKtQzyImk3rfm372LaTh11FFbJil+vZj8x5H2ipjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWqEf01hpj0TAyVwUdfXUY5PA4ZUy6GdiFJxP03SFlU=;
 b=xDT4VZEcTHz0I1QxYpxJf+z68DdnY+L08jH3fzHfjjU0dA8OrXTxbt48G1sT/sL1kkHxGgKisZpo0kAHZfmbbj3rNpPwKh+y9xFZKDtzpvYA1MXrbLcuDNW6D7RMvIV+0MUut3cFsKIF8VK0Udd1u/2a5RBY+wqenFg9QPFl7GVD/hmEHvuC301HbIqMLuOgb7wXCHmt7FdaFtx1+HrfKiV51yFuWf85TYrOMoDBgV1Q4/rVyXFofBLTJyi9brz6MT3d7JCa0ufe7ufM4cUFfnqm1+UxF+hyIaP+piSzfbJvn8B8/Q5YYbT/bDtor8k7sAHim0GdPW4lpxgxHsDywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 22:10:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 22:10:46 +0000
Message-ID: <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
Date: Wed, 30 Jul 2025 15:10:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: Jakub Kicinski <kuba@kernel.org>, "Lifshits, Vitaly"
	<vitaly.lifshits@intel.com>
CC: Simon Horman <horms@kernel.org>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org>
 <20250730134213.36f1f625@kernel.org>
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
In-Reply-To: <20250730134213.36f1f625@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------D6hI6tdxclgcalhYAaPWYsfH"
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: ad368cab-ff2f-4c44-3108-08ddcfb5ef28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjFOcStaV0xEY2Q0T3VHQnNKbG12RHZuVVZGakpxOHdoMDVNNmdKRmt5b2Vu?=
 =?utf-8?B?V1pQdG4rS2xYQ25KcjVDbTJGSi9IWWUvb0VnMHo2bFZkdHVTK29MTENxM1NS?=
 =?utf-8?B?NEgvdzRuL2RncWtZK0VJNGcwVThwQ3lVZnNZa0lUb1pvZVZGUGVpVkZ6MGhy?=
 =?utf-8?B?M2N6dWhBR3YrSmg1YXoxYlNFM0dvZ294RDBPYlZyRFpTNUFQR3QxMzVIZWNt?=
 =?utf-8?B?SDd4Q3dILzBYTjlYZTBJRGEyODlmWWNmZFRackhNeThwVFdKeGd2YWVEenda?=
 =?utf-8?B?NTMzMlVwL1N3aXlvOTg3YXBUMU1lMWxpR1JDODRRV1pkWGZabXBxOU9CMTE4?=
 =?utf-8?B?aHZHeFR3N2ttRzNaOS9LK1oyUHMvZ042a2xLZ1hBL2hFUjdxbWNhcWZuRzFj?=
 =?utf-8?B?Rk5VNlUxSUljQUpQNVhpTy9QaGl5T2NhUXBtL01YNWpjODdpZXhRckNPYmdE?=
 =?utf-8?B?KzQyUG9xcUdBbjVZSC9NdWxwdm1ZaTB6TCtYOGNkZmUweHJRZnlzTHJWSFJF?=
 =?utf-8?B?bGxwT0l5Ri82WGNENTFjcmNHQWQ4MDlFeS81NHJiRjV6bXlVNUR2anh2UDRZ?=
 =?utf-8?B?bTVjMjAzOWd0eWJSbDA1ZzZFYkRHWGNvdVRyR2lKMHlVSTVIZHpJdFJSSGNa?=
 =?utf-8?B?cE1ydG13MjBrRXU3d1R3dm5GSy9henhaV2lTaHZUWlZEdkRxRmlYa1ZNWFla?=
 =?utf-8?B?RHBtZHNvS2FoQ0JUcC95ODljUFhRR0l4QjZIeW9Obi9PQXRLbjNBYVYxVkdZ?=
 =?utf-8?B?Skh0Z2hrQ0pQYzB2NXN4WFRBQ0g4RGpmY3M1N2hnMUw1bmpOa01XdmZ6cDg0?=
 =?utf-8?B?V3NtZFM1eFV4cFR0S2MrSGFiRWhYT0poK0NkOEdnMmFhMVI1ajhJYTMva0F6?=
 =?utf-8?B?RjNwdnRxMENwZ3BXaG9TZlRzeDdrMGZiZEQ2RHhoampBbjFuRk1JNGdoTG5D?=
 =?utf-8?B?TDQ2ZVdZQ1oxcGxKN04weXlNMmNXdmgwTzlsQTAySCszMG5iY201aWVnZ3J4?=
 =?utf-8?B?L00zd0puanNIeVlPWHVobkN2UElRRDhDdFAvSEJBM2czazdhMHRZcHFhaFdr?=
 =?utf-8?B?eVA0R2Z6b3YyQVpPNVI0RnBPb0ZUeXdzUzhJdGpRWU9zYWl0VncxT1BMQW1W?=
 =?utf-8?B?YlFLaDZjTWJhSm90d01VQjFXSEZkWmFyNkF6RlZDM0FMSXRwbC9MdFNYVFdC?=
 =?utf-8?B?STZ0UHgrV0tnZjZIWUd6ajhSblN2SkwrV0pPb09SWmFrVFU5UytJamZnL0E4?=
 =?utf-8?B?bFEvbHd3bnRsbXFHRDE2azVGS0VUNlJZcm1CcS9vUDR0V0xwRW43b2JLR3c0?=
 =?utf-8?B?ZitmUTNVMHc3SkJ1bkgzZmJ2WUJkd2F4NUNWc0RxSTJXS1pPUFF3ZzExQ2Y5?=
 =?utf-8?B?eVM4MVBMN2N1VDl6KzVwekNkWUt2dnJBYnBSeVlFMWxaZkd5cTZjZ3ZMdUdI?=
 =?utf-8?B?aGRQSjY5VUxlZ2d0R0Y2MmlmdThWQkJjcExFVTJWemUzM3luMGxYRGlpRDcy?=
 =?utf-8?B?WnVhbDBuTVpzNHp3dTVucjdGdFZCeWQvS1BDWU5Gd3V1TWNsQWtPZWRHcEU5?=
 =?utf-8?B?QndrZVhWQ3UzZHllWWpySUtSdzBBL0dSK1FLbTU5WUhvRTZYajdTWloxSk1P?=
 =?utf-8?B?SUVoZnFFdEVwc2VlMHNGbjFQOStjK1AweXJveUZNekpFZGtZOHYxOWdHRjJz?=
 =?utf-8?B?bitYeXc1TERUQXhINzdhQmI4UVRyY2o3ZTZuYW5MeWVKbVNQTVNRSGhraGtl?=
 =?utf-8?B?TU1GMnhBcEhNWU9nNDllSTJpN3MvdGdNL0VhZDBlWVVVYStLVUpaalZHc2JR?=
 =?utf-8?B?dTdHbUYydEtCVklCME53dVJVM2FzbjdJc3ROc3paR0R5dDk0ZFNFSkdCaTEz?=
 =?utf-8?B?NjcvQVF6b2ZNbW0yaTNVenZSOTdKUm9xMkpCVFRsUWtUdGJJa1crY1d5Q0ZF?=
 =?utf-8?Q?HjsMCZ7cfDY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNDc0QvNUhIanhqNlJ2Z0xiK3dNNWh5QnZSR0Q2d1dpaFFJSlJyVHI3aFZX?=
 =?utf-8?B?dzhIMmNlMW1pMU1TRFRuZ1NFTlZqOFhlNVFFeWtzMWFuZEwyRTFrSEpmT3Bm?=
 =?utf-8?B?ZEQzTWh4VG1UaTNRS1FBT1hiamNjZXVzVXJJSW16YkREUmhabEtsRmYrZVF6?=
 =?utf-8?B?OWtpbE5ESFV3ODIzZHRrTXlpQ1J4MlhkcG1hWCtUTGpLanM4emNKNkFaT05H?=
 =?utf-8?B?ZGt2Y1c5ZXlUbkg4SkxiR3Nub0djWlZLV2dqNVFuQUFWYkJObjl3TkFheUJk?=
 =?utf-8?B?SHNOeWdhM1FMampnUGpuU3RqdmVKT29WOE1YL1krRFNSZW9jVFk2K1hMZDR2?=
 =?utf-8?B?MTJJcVZpSXJXUmZickZpOS84SGpZcmR0TU9BNjQwMHlVa3NUd1ZlN29Kd1NM?=
 =?utf-8?B?cENKM1ZVZEkvY1I5clVSdDJtSXlIUURjRXhWTG5acXZWalpSdXhpNVdob28y?=
 =?utf-8?B?czlFZnZPc0o3cTAvMmhtVUs3ODNUT2NXQjRLRWRLZTRoclhiOE9Fb0RDQ0NI?=
 =?utf-8?B?aDNBQkUwUzZqeFZ4TW0zbzB3NlUyVjZBcThBQ1luSEIzYXpNeVpnTXJ3ZTJi?=
 =?utf-8?B?YUFlWlZFUitiYlY2RExCMllURXpLZ3lpNkZZeHIrTXJ6bHlEbnRKSEVQYmsy?=
 =?utf-8?B?bFRxUUV0Mys2UzQ5WUhFOWg0elBUOXpqR0NzOVRHLzNKek8zbkVUeFdMbVdW?=
 =?utf-8?B?RUJXRi94REEvY0VmYm1SaGxaSjlNWm5meFRwY29iQVMvRHZVZmZ5bFIySXVR?=
 =?utf-8?B?YnduTnJ0K1VZOElubDlpMXFQMHBCUi82QmlFOW4yblo5SVNZK29GbXhlSWc5?=
 =?utf-8?B?UHRsQ3drUXl1OUZ3UDJvTDl5Q3dzcUlWWFBneWFzMUcxUDFsVDQ2MHRlZW12?=
 =?utf-8?B?bmMrT3hWWHlmUVAyUkw2Rm1IY3A1Rzg0MUUxalR2YVRpTVBvYlJDVTI0SjJv?=
 =?utf-8?B?bnB6YW92M2pyT1lJamNITzhsbm5yazFyZ1hGTXJPOXJqc3VDNmxKdU5lNFUw?=
 =?utf-8?B?Zi90Ti9DcnVNVWFnQjZQdVF4VkNxako3VTVhTnorSTh1UVpvVVBnTUdlczhz?=
 =?utf-8?B?S0FFUzNZYUNBOFN0VXY2TkpYRk1ScWhwVHB5emN6SWQ3a0lIUU9PaHlyQkQw?=
 =?utf-8?B?NjY5b3RLa011bEpaOEVndUtrM2xXejVNSDFabkR3OXVwVWpLbk1NNm54OFUy?=
 =?utf-8?B?V3BGK280LzlZWEV5cU9sdk5UdFV2cVl3SGY0U01VWnMrcEhyMmd4M2FyT2RC?=
 =?utf-8?B?YkpyODdnaStvejVObjRZbThJWDJ2d0g5Ym5DZXlyVE5qeC9RUDZZVytYbnJB?=
 =?utf-8?B?MEpiZkc4OFdUdnA3ZEFKK3BiQlVyWTgyZ1hlSGV1cE82MFIrKzNLaVZZYVNI?=
 =?utf-8?B?dFBnOWtWZEZ5Q1BLK3QxQW1QQ3RqTFdaTGJ6bEZzSGtJK0pwZTVmaW4xTTlu?=
 =?utf-8?B?ZlBqNmIxVWRzQ0Q3LzB0ZkJPSHIzaVJBdWVPcUdZSTkxQjBoTHpZNURHM2ly?=
 =?utf-8?B?MXlySG02NXVjdjMrSmpMdmIvdVFGY0pPT3JrTmpndUptakZvZytTVXM1TCtJ?=
 =?utf-8?B?TlhPdVdLaktkY0FaRFV4VkowQWVzMkdKQVorWXdKbG83U0grYS9XSHRnRTF3?=
 =?utf-8?B?Y2ZVNUxzVHZta1JqN0lSd0Q0ckVPaEg5ei83aW53NForVmlwOU5GVnkxWldK?=
 =?utf-8?B?S1FrQU5yNmV6anFZNHNYQmg0ekg1dERya1FMY2JWcU1xNEROdFhSN0x0Yk5u?=
 =?utf-8?B?NmFIVURSZ2o1S0dzeGZZUlAzb24vOStMLzBrc0JEYVNQVjlKWndPNmVqVTZV?=
 =?utf-8?B?U1YzNXlwaGpnTVFjdkZBWWpTdGxxRzg3dVh1eDZPV3R6dzR6TlE4OVBCTFFJ?=
 =?utf-8?B?MlRyTytFOVNOYm5uWS9mUFg1QTJvUWVWeis5anM2djIwNUZURWVIbEhKNDBP?=
 =?utf-8?B?MWVRMTdKc0NJVFQ0T2w3eFVqNHU2L0Z6ZEtHSEltS2VwZlhuZjVzbG4xdi9B?=
 =?utf-8?B?M2xuMDFGMUJKTjFPTmEyV0JUZUlWZWtqeHYxZWhkQzRSQlErT2J3cXV2VlpN?=
 =?utf-8?B?MmZkOFQ5encycHUzVFJERGFFSmFaSSt6ckFzb2FkTVpLc2pxN1hucWNRdHNJ?=
 =?utf-8?B?T0VtRGpxdS9iYUhHQnBOWW9pTEl0N3R0WnlLeHgvMVpoZXJlL3pWTUdMLzV5?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad368cab-ff2f-4c44-3108-08ddcfb5ef28
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 22:10:46.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuHVeHDZkl21XRhvjG5TtPHelOkseJ3hzuTTlGo6jx/d4MdnjRoqFpDn45cuwlBeAdaFWngy26iFAUXxS+OrY+QuMvBiS58guIBKA3oqGZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com

--------------D6hI6tdxclgcalhYAaPWYsfH
Content-Type: multipart/mixed; boundary="------------yiK4Eq4AooxLfB7rO50v91FO";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>,
 "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Simon Horman <horms@kernel.org>, "Ruinskiy, Dima"
 <dima.ruinskiy@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Message-ID: <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org>
 <20250730134213.36f1f625@kernel.org>
In-Reply-To: <20250730134213.36f1f625@kernel.org>

--------------yiK4Eq4AooxLfB7rO50v91FO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/30/2025 1:42 PM, Jakub Kicinski wrote:
> On Wed, 30 Jul 2025 16:28:48 +0100 Simon Horman wrote:
>> My opinion is that devlink is the correct way to solve this problem.
>> However, I do understand from the responses above (3) that this is som=
ewhat
>> non-trivial to implement and thus comes with some risks. And I do acce=
pt
>> your argument that for old drivers, which already use module parameter=
s,
>> some pragmatism seems appropriate.
>>
>> IOW, I drop my objection to using a module parameter in this case.
>>
>> What I would suggest is that some consideration is given to adding dev=
link
>> support to this driver. And thus modernising it in that respect. Doing=
 so
>> may provide better options for users in future.
>=20
> FWIW I will still object. The ethtool priv flag is fine, personally=20
> I don't have a strong preference on devlink vs ethtool priv flags.
> But if you a module param you'd need a very strong justification..

I think just the ethtool private flag is sufficient. The primary
downside appears to be the "inability" to easily set the flag at boot,
but...

At a minimum you can create a systemd service file set as a one shot
script which executes at boot, and issues the command. Alternatively it
may be possible to get NetworkManager or systemd-networkd to issue the
command automatically.

Being targeted at the device is a lot better semantics than being
targeted at every device owned by e1000e.

I also have no objection to setting it as a devlink parameter. If the
device had permanent NVM storage for the setting, that would be even
better.

I understand the motivation for not wanting to enable devlink due to the
extra development cost to integrate it into the e1000e driver. I'll
leave that decision up to Vitaly and team.

Thanks,
Jake

--------------yiK4Eq4AooxLfB7rO50v91FO--

--------------D6hI6tdxclgcalhYAaPWYsfH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIqYZQUDAAAAAAAKCRBqll0+bw8o6LtH
AQCUmr3889YLDhm32ekuFojK86lJcYLqh9rYX4MXhFAz8gD/fGte12cC+tNoWyA6tzWgslx8MXFq
CvipwKr9JqdIdgg=
=cmHU
-----END PGP SIGNATURE-----

--------------D6hI6tdxclgcalhYAaPWYsfH--

