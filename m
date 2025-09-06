Return-Path: <netdev+bounces-220517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00814B4677C
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50B25C1634
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816542E63C;
	Sat,  6 Sep 2025 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5GQBHAF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4D3FC2;
	Sat,  6 Sep 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118066; cv=fail; b=sFlfVqriGHxDbaGT8Dz8G4+PCZfHoj+jr8NtRPOJcYbRiKOf5K1JxbsHQ14hao0tNlcodik1X0YqP/RaWuFZFiV9tbpFscHvMCTH6lQtltOhGfO7Io25UTp9S3Vy3cn0Xyr0pJDO137GCw8fpXp6sLCF2hHQy1lkrbFkQoj6GQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118066; c=relaxed/simple;
	bh=1ZzvA5et5oMPuPzL0QEG+GaZZYfAWZj1X79EFb59r0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rz9Hr3CSNwNv/T9mbablNm4zPgP3dyno/AQp+hRTdByaKPGJf0NmxXlKTHzAiFE22lNfJQXBfhMkXiB3UwR8zZFdsEIHJ/wQ/AmIPmFzOzClTX+r9kWgTl1Qy3mpLoJ6WUNkDYbhriObNiHMKNbmFrMnq8gm2C7Bb9AI3Oc+Htg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5GQBHAF; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757118065; x=1788654065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=1ZzvA5et5oMPuPzL0QEG+GaZZYfAWZj1X79EFb59r0M=;
  b=N5GQBHAFj/gt+4E/Q2LNZUSQwGdIwh+fKhPvW4YsEHjXSfYEGtr3ThJV
   FVcTt8YqbF/Xt+BeLArIEqxCWsNFA4eoakqUZ1Irkc6gGNEdBm2kv4FSZ
   uwQ64YW5/KO3HPIdosCsG3tsP4UBK6SSYEDrFABVGkXgrqFKkl5OtRk9Y
   abiyxWTrIoHKkAdj/C9tMdtU+zDV+zxS0jdAE6WPtpVirRdd3LZkmu9oQ
   AU4BhvKrqb1GEPSYhI2Y9dZeWDUDjrj1UDLOkS7q6YIREoMH3SKChxquj
   yh11rRZ1wUOdxRJLq2tBYcR1QUEeqFKLuT3X6V5ekyxD+oE9H8gSdwgyA
   A==;
X-CSE-ConnectionGUID: YU83jlH+SBmMB56oVl0Kqg==
X-CSE-MsgGUID: Iogd71ojQPuUDA7bR4UXKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63112820"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="63112820"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:21:05 -0700
X-CSE-ConnectionGUID: KLmdWMPOS7+Ksz2LYVfOtg==
X-CSE-MsgGUID: 2bXu3i2FQXySn13c93qSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="195949529"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:21:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:21:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 17:21:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.85)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:21:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwGKXhlMW1rUMRtjsQfI/7hOkUkQCWR5Gq5UV6XApPr52jfJ605MiKCBpYm5nQUQ2RAVwJ2QFGpOIDpfZ7yeVkNcsPxgtMJMYjHQKU41BuEH+NuUwaPItPNfv4X9A4mzpPk9zuXd5+VB8cdW3md1eaCjAVYQs/vBLID8FoToXzHJmXCSDkO6Y9bTNseYTmrebT2eB8tE5fjt89gsGKmfWXurW0V2SXvPCR2Gvn8lG1C5To3VcgwFBKcPauy2IT8+x+5BO9Z4Y+9zMV2UfnywOib6VSutpbVCONoZYapxwMequsv3cJPlhsyUZ/mkG+bwL+J0O+oqU8IrcUG2BvV8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3zvHa/jf5rU0mnPy7ttf+fpprDYfKVikMRBtO9bYk4=;
 b=Ye4n8skkBIrFPP9Lwnrovctye2QiSG9GGYm4eXKNhqyXx0zLWlOLXG+/cpZBwj/OCaLquszMrYLmzF5AmjKDK1OxO81bRaxYXkBsf0FIoabyERsRzyc3mEaaxo+H6J2whNjajokqSFlD72x2gSjUllFO7HjfRvDbsUcrxlJnESqjNe48atKl7itZXiAAgUR8pG5b3AKq6aY/Nvo8glezl++5RyRMwSiejRbAkFr6eoIBMRykDVkdqc3pB+SDu56/o0PvbVzE47ZRWkCiT7xVIYILTzrNWHMlG8PPVeJj/500i/CVD30eXqmpTY2UwColKa366OJH0+uaj1s0NCrgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6372.namprd11.prod.outlook.com (2603:10b6:208:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 00:21:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 00:21:00 +0000
Message-ID: <1aaf9978-5bac-451e-8670-905809e7d1bf@intel.com>
Date: Fri, 5 Sep 2025 17:20:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/11] tools: ynl-gen: define count iterator in
 print_dump()
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-4-ast@fiberby.net>
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
In-Reply-To: <20250904220156.1006541-4-ast@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------SH7bzu1eJwKzoWK0xDREJ10G"
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: c6340986-1ad2-4eeb-74da-08ddecdb41a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzFxSkRFQkYzSE1rWm5XcjJBN2xSVEt4Szd3TGp4YjZvaHdFNDRMblB3NTZi?=
 =?utf-8?B?WWhzY1RCTldOdWZRWktySTJaNjVobW1Gd2t2Wkg1anlOdHhKVU1GS0IvZkdK?=
 =?utf-8?B?YzlKazVlUHBHQk1QZlZ0NmZJZE5ldFRFTDVhVGtZNGhTaUJGQUVFakxBSnd5?=
 =?utf-8?B?eGtmbU9PTFhrRFhxdzRqWFZRdlZrRXFRSHhHZkEzMHc1dG1ScG0vYytIZjd2?=
 =?utf-8?B?cW56QnlNczU1dm5aQWNkaHJ3TGlicTZnRGh0TFZidzQ1TGhQY3JnVVh3c29I?=
 =?utf-8?B?ejA5WW81UFpUS0NreGE5WWc2d2VaYUpTV1RBUXRBN0JpRkNIQjIzaUF5RE1o?=
 =?utf-8?B?eVhPRy9YZGJMeFg1NXpjYWNFOGlPUHF4UU1LbHgrWkc5cHorYTBUcTl2eGpv?=
 =?utf-8?B?S3lTcmR6NmRPcW9WTFJKVkhUVkY2YVpCWDJhNWd4b3pNYUF6MjdlTFIxSjIx?=
 =?utf-8?B?WWtabHZNVTBsSFhTQWR4T05mUGZZWFp2emRSVGxRMmZLUnFpdXEwV0RFbTEw?=
 =?utf-8?B?dFpNdjdsTmNFeXVIdXUxMFR5ZU5DeEQvbk1RNnIzWFptZi82SldZbVFsckVx?=
 =?utf-8?B?OUNwQjV3MmlyMHRHZWFua25pY256bFZkQjJ6cUc0bytwa1Z2QkN2TEN1WmQ0?=
 =?utf-8?B?NkJJZmJEa3c4ekV6OEE4UzBFb0V3NHNUdGU5Qjl1TDIyR2pHdEJmWSs4dHYv?=
 =?utf-8?B?bGYzWjFHa1J6TUpGSkR1Q2ZWWjAzL0p6YTRjdUcvdS80Zng0dUJpNzJZTU40?=
 =?utf-8?B?NVRDbGVsaEZBeWhHZXJ6cjUzSDdMUldYeDZmbTZ4Q1daSUcyaXpPcmFiLzVD?=
 =?utf-8?B?N2dsNCtRUjU2cHNZNVRSMlVGZE1FNGZadE1NbTdsRWNuRk5Cb01BOU02Uytt?=
 =?utf-8?B?YjdMcGl6ZGlMc0N0NERYTS90alczNXplNkV4M1puU0FtejduRUJ6OHFSZ285?=
 =?utf-8?B?cFQ4blVaWWpOcFhwK0p6WWVEREF3aGJZVUxrUkFNUVV3QmcyYVpKaGswbDNz?=
 =?utf-8?B?S1lpWWdGZjU4MVpQVkFxVkZad1UzZU1WdHFRbWZUWnVhZUxPTDJzenp5SUNh?=
 =?utf-8?B?aVhTNXJTSjBIOEozVXp6VDhNUHU1YkFLRHA4WnFoZGp1U3hlUVFMczZXeW5W?=
 =?utf-8?B?VWxNdXJFYVlKV0J0ZTRwYWc0TFFwZDF0WkxGKzZ4S0VHSnRaK1FNQklxZW1p?=
 =?utf-8?B?YmJBNmFONC9KVmFUeDlBK0lWVkdWL0hJdEdGeGtPd3NacmJlSGZOWHp0RmU1?=
 =?utf-8?B?aUZCRWtjOVZBM2pITWlnV2hlUFdldmdhY2tRai9kTnhtelhocTVWcWpwZDF1?=
 =?utf-8?B?MVZMN2NhVDN4UUl2TFNPb3luT2tTWkxWK3RHeDgyTGFGdWxBU0ZCWFVaR082?=
 =?utf-8?B?eHNNaUxPNlYxOWR2UHIzSlBydkxFYmhFWmgyemlCd1FwVjZUdThobUZUNjZV?=
 =?utf-8?B?WnR1MlhZQllNcnk0aXdqaXhzcTlrZXFFd3l4M0xkdGNnRzEzL3JyVG12TmxX?=
 =?utf-8?B?ZU5lWS9hSUdvQU1tWXNLUksvTmN5MHFUck9XWWdDRWVZdk8zZGhvYnk3ZU8v?=
 =?utf-8?B?WGVYV2NpNHQvWXp1NUxLVHhXTklaVHc2ZjRmOXdDY2llVDQ5WmlkeEdRZlQv?=
 =?utf-8?B?cDhCa29KU09naEZuV0tXcS9RcGZNMTl2Z2hJdENBYm9SNkZCM0I5Q0RVc0dQ?=
 =?utf-8?B?dHUrV2F6VG85NUdrUytPbTFMdndWU0dSS3J1b3VzbUxUVzdxWStXcUZLRFZi?=
 =?utf-8?B?bkZYMmhic2xwV25MdzA5T2M0cm9vUXBoYXBpb2h6a0RBYytYMGJKTlZnZ1gz?=
 =?utf-8?B?d200WUlmT3VTMUdQdFMrZ3dzWGRUemE1dnljWHAwc1ZWMGVhVFQvQjlBSEs4?=
 =?utf-8?B?WURDNWZ4QkdpTTRMcmRBeHVQZ3dQSzRtWE9JNEVudzJWNGNucVJaaGxjemNx?=
 =?utf-8?Q?xcUg80SHHFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xuaDJIZXJuV2JyK2NDU1JwY0VKLzF2WFhUVE83MnFJUWlVVXVNY2pHVTFj?=
 =?utf-8?B?Q3VRL2R3NWh2T205VE5HZ1BBRUgwZGJRc2VReUk2UVdwY01mc0EydDVTcnhH?=
 =?utf-8?B?YndtQi9nR2VKUjFpZ0owTTN3UmcxdzF1NlVZcHBwNWRRK3h6cEtsU2J2TFU4?=
 =?utf-8?B?emdPSWs5RTVaSGFXUEtmcE80d0E1ZFQxbXByREY3Q0wycUFoakFxV3hPOW85?=
 =?utf-8?B?RElUems4eVh1Z01HT0N5NGVCa0xKSW1OOTgxZDBXYm9xSHpHZHlyL2lEblFj?=
 =?utf-8?B?dmp2STdQUUQ4bnB6R0ZBbXZMcmk4YU50L0lRaEN1WUdpdVFMTEFlOG5lZWJY?=
 =?utf-8?B?WG1OYVVYNGFmYmxTVU9McFJkMHk5MHNPVE9MN2pldGpISFZnaVh3MjF2akpG?=
 =?utf-8?B?OG5VMGJ1RXNncW5zRm82RnplOW9CQ0hrNEVaTzVnTENCSnFIV0xTZW1iWEU4?=
 =?utf-8?B?QVVsMEUvZVI1d1hiWnluMC9XZFlXMnhLczEvZndRUE01UzhQeXNKMTcxblRI?=
 =?utf-8?B?azkrczZ1NHgwUzA2bmlhazVGWFErZmlaSWJxSy9aVC9waEdPakR6T1ppNmtp?=
 =?utf-8?B?RjRUZHFmVE4rb1dZZDIzOHcxY3ljOHQ1SW5HdnhPc1lNMldMQ0lMbHA3Wk1B?=
 =?utf-8?B?Z1hrRWZCUUM3S1dlSUFjUlprTXVoTnlHSTF3c25JUDZZVWFGNU5tWEZEYzdZ?=
 =?utf-8?B?bXJ5R2hWWjdtVURSRjhGMGN0alFxcFBkVFpSVmtVSmlIcHRwUkV1V3FHUmIz?=
 =?utf-8?B?TG9KeG1FK1M4TXZ3cDF0WFdOSm1pOVZlWEV1QnZtNFdlMXJmV1I2RVFLM093?=
 =?utf-8?B?blNCZ0hsUm43dXM4UllzZUhEUGQrUnd4cjlWV2dNbzVKR0lDM0k1dFNsOElm?=
 =?utf-8?B?MU9PT3NJdU53TitFQ2locThROGNmdW9YZm12L09CMmlPNklqVGJUS0lMaU9R?=
 =?utf-8?B?bTlhY1pXdWtGRnZ6QjZudGFoU002ejcrNWpYdk5LdDZaZU5pM1hIQkVuV2pR?=
 =?utf-8?B?M0pOU2duckhMeUlQMkdoa2F4aFd4all0OC9JU3JHUzRnV1dNNitFMG5GUTRR?=
 =?utf-8?B?bEQzQkNoazh4TDNQbGRiVFVFbXpVTHkyL2Vicy9hb3NLZG84REY2MEVDZkJM?=
 =?utf-8?B?aExZNWV2SjJwbjJtbjlpTkZNc2kyMmxVRlh5dm1aVkhzbDBjNnpuZEV0dmU5?=
 =?utf-8?B?eW5MMzFKaG9uT0JwNW56TVZMaWtldTBKVFRJMzVCaVdpRE5SZG4wUnVmOWZR?=
 =?utf-8?B?NHlWTHAwcENSZlorWEZrT0NZU09vMStsU0tDK3lzUkUwajNlYVB4ZUMrcVBi?=
 =?utf-8?B?eGZhekpnM0dlajdEN2M1RURtT3Y2UDdZMytCbFRzd1YxUHRmUXVjQkVaNEV0?=
 =?utf-8?B?RWdwQ0hnc1V3L3dJTS9jY0VMbzRXK0hpanZVakJXYnMrU0Z3b2xIc2tRZCtv?=
 =?utf-8?B?WlMzZURTTjRPREFpNkNoNERrL29LdWFWaGl3TTZDTHVvOUkrSWJOZ0wzV3BY?=
 =?utf-8?B?SU1sbXlnWjZySWNOYm1wVXdHcHM2L1kzWnRBWHBXdjM0YUlaNUxRblppeGda?=
 =?utf-8?B?UGUyNjZZK3JOVlFxdGwwT1hIalVSdUtBN1dPcE44MzBBbUZzZFZMTi9uVS85?=
 =?utf-8?B?dTNMckxXZlhmYUNic0JZZGt5cVRhTE5memkvY1JCdEprVFlnQ0Y3NzEySVp1?=
 =?utf-8?B?c1VJVklOK21GelFzK2dqOUZZUDkrY2V4a3pvU1ZaZFM4TUZMWU03ellkNmxp?=
 =?utf-8?B?dWtLRHk5bHVpZW1xdzRjKzExV3ZRdjVzWVRjL0JtRW1VeXQ4UEpCZGtYNy92?=
 =?utf-8?B?RnNFQXgrSytZNithR3lTeDIzcHEyWEdMUzlHU01kSTVqWlM3VnRjQUNMSUM4?=
 =?utf-8?B?NDZZVkx4T1VHdWd4YUUzVjVraTdPVVVvclVTZ3VvZk5uTU56Zi9RNjFjZGtz?=
 =?utf-8?B?eDYxRFNNYTVtV2YxY05MMWVKV1ZlWUFnYlJYcXBwUnVSd05YS3J5aHF6QnZQ?=
 =?utf-8?B?WUlZOG9GeWJFK0hCWmVYMEJ6Ujc0TW94YzFiNUJSblZSb2VTR3ZsekkvSk03?=
 =?utf-8?B?QkN4dm1EYkhnUDc4aU1EZVo0MzhzamFSRXF6Njh4TVIwMDFGM2FCazZRK2w3?=
 =?utf-8?B?ODZqeXJabGtDYzJ6R1p6UnhVYWFTOXhPQ0QrdzNONjIwd1hWTEY5TE8wdmts?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6340986-1ad2-4eeb-74da-08ddecdb41a8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 00:21:00.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJWYf+XrLJCXAxge0TMkuAef5MHLss1rR+BgsGzhMY26GQSAB8jQ+SDP7kkJUKF5gf/cP79J5DYKJlb9StokjOxLpaFopqfZzoptfu/oEqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6372
X-OriginatorOrg: intel.com

--------------SH7bzu1eJwKzoWK0xDREJ10G
Content-Type: multipart/mixed; boundary="------------MPAGxPaRV04uMgjVWucvDlU9";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1aaf9978-5bac-451e-8670-905809e7d1bf@intel.com>
Subject: Re: [PATCH net-next 04/11] tools: ynl-gen: define count iterator in
 print_dump()
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-4-ast@fiberby.net>
In-Reply-To: <20250904220156.1006541-4-ast@fiberby.net>

--------------MPAGxPaRV04uMgjVWucvDlU9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/4/2025 3:01 PM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> In wireguard_get_device_dump(), as generated by print_dump(),
> it didn't generate a declaration of `unsigned int i`:
>=20
> $ make -C tools/net/ynl/generated wireguard-user.o
> -e      CC wireguard-user.o
> wireguard-user.c: In function =E2=80=98wireguard_get_device_dump=E2=80=99=
:
> wireguard-user.c:502:22: error: =E2=80=98i=E2=80=99 undeclared (first u=
se in this fn)
>   502 |                 for (i =3D 0; i < req->_count.peers; i++)
>       |                      ^
>=20
> Copy the logic from print_req() as it correctly generated the
> iterator in wireguard_set_device().
>=20
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  tools/net/ynl/pyynl/ynl_gen_c.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl=
_gen_c.py
> index 04c26ed92ca3..b0eeedfca2f2 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -2425,6 +2425,11 @@ def print_dump(ri):
>          local_vars +=3D ['size_t hdr_len;',
>                         'void *hdr;']
> =20
> +    for _, attr in ri.struct['request'].member_list():
> +        if attr.presence_type() =3D=3D 'count':
> +            local_vars +=3D ['unsigned int i;']
> +            break
> +
>      ri.cw.write_func_lvar(local_vars)
> =20
>      ri.cw.p('yds.yarg.ys =3D ys;')


--------------MPAGxPaRV04uMgjVWucvDlU9--

--------------SH7bzu1eJwKzoWK0xDREJ10G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLt+agUDAAAAAAAKCRBqll0+bw8o6B+n
AP4gWchHRGG9E0hn5WRiAT14gew9/yElqGTRNSMaWkVmKQD+J5HaF7FJ2BnPKurqLf41dkxVI0MI
iQlFQ+ASUPRW9gA=
=TA1h
-----END PGP SIGNATURE-----

--------------SH7bzu1eJwKzoWK0xDREJ10G--

