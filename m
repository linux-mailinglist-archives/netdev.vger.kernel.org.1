Return-Path: <netdev+bounces-218002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F7B3ACD2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763D8583C0B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8528C84C;
	Thu, 28 Aug 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxH4TJ5J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B99279DD6
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417144; cv=fail; b=BWMKe8xanyIE/IIT6jHesSSTgViD+UlHwN5PzYGxYoV8KnHr8UEZT568ouODPo6U5BXA6drIgBgcfxPcE9anKlGDbTfYlHnvJXpk36+IEZkBKNMcna4Yf3Yk/qeJWRH2dsoAoLCS5yoIzqcKhzwWq10j3B5ct6uSrYEeTkBniAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417144; c=relaxed/simple;
	bh=5G3CU0WTuEcsUughRnYLvplznz7GDL8evmJNctVHgq0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bOa1hy9ofXlTj3KyC2LpMAh7NggM08ncxfW6Z2rsJZ8JqDPAineJjbgTyUZmPZdlksAjJ9KjR7mlEQXk6n/dHQ/VbNNT0n0H6HcbEXwtrAIrYU0fZwZFO6N4PCnKbhXaEpjYk8oGXgj8aNAuSzCZVC0a0FcCO7L1r5AQiTV2Bpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxH4TJ5J; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417143; x=1787953143;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version;
  bh=5G3CU0WTuEcsUughRnYLvplznz7GDL8evmJNctVHgq0=;
  b=MxH4TJ5JfPSXqM67ogr54sfRYVDrLYP4HTuGZj8t0XMyK9ecyH7zTd5t
   IbI2+cnG0b3YgZfUd+UYcNSTbW1Roc2dA5nPpirpB+/OlSYCTTWvI2Uxt
   GQTGcjnd0c2fOD1t+N2X+2J/gMDZMasbhTNE1osDwSyHsUiiAvOo+f5ZK
   Nd4W8Kv94Ib1vQRAQCeNq0iguMJZzkS88kQt6Nsx7+HOWNYSdd7Tj0CEM
   2lXGrAgi3Q+t4q9ey68N0J70JzvcoUHdIgvIM2YSVthiOwpymxpsZB0+2
   zcF+kfbmPhwZuPz/18y3KplxSfOf2b/LUbdTS5qQZ0V9h5tQBQEzRvrSA
   g==;
X-CSE-ConnectionGUID: 8HcWeHxlQNiJk+kJUZShwA==
X-CSE-MsgGUID: uq9l8TSRRDijtHbPQbL6Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="46273460"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="46273460"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:39:00 -0700
X-CSE-ConnectionGUID: KRGpeE/LRPmu+JHI697zCg==
X-CSE-MsgGUID: OfBH0aqTTxezfltCi5orQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="193884259"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:39:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:38:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:38:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.74)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVAug+pAgYZ3ji5u4iS2jEYggoyOqVkOIaHsfcTdUPss7D2svPeAqbS3GXbfxEaVy6r1qzP/9f0G/KsoEDuvAwJIZYfh+7lf+ZB0RVnhMlwWAoOkuON9jRMzh1gmIqATFlUkSKvvJKdX15SprDwHdl+XJi+y/CbenxjRO8Cw6tC96DhCTtub+fINmMdbDnEmB4ODdB8dL7zh8CvfGlKhDj6gozuYc0HJCtxrhdEGS83pHtyAUg77QHo9PqgXvduoTiTFlDvyMs5DLFk8tvHh+9N7CWRlCvm60JwHszp8eQkuAO+1pRD52YTX1mGinSXrgzT1lC0CIDbqwLykh6kAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8Sgw5EbA3jjhFDKfemnCstDXYBfatYuk4kX0XjYQGs=;
 b=abPNfif6ndFDTUK+Uo0CJDMb/Mm+JVN/DGsHt2+gQv3Sna7uP/ShZarJgPjWG05CRiyBDNOj/3yl8J24QM0mz5vfXs4hzyzbIb4ZfTcdMB870s2GXH2vDq1pBKb8//5H62ld3j9vVIgOH+vzs08QP/vhfOuuzTTs8XcNNTOWQUrw6dZAjOsu7kqAuje+QsgYpoQhk+KdryooZcu0bYXzKl20EIZQlQaWePTM1l9+olzowCLbquhtS7dESGTTa5X8M9nyaC3vzX8CVKZxfpaqtGOytsqO+rr/QNiyuzM9OahOQ/XPmkU8noaz5WUf689LMWp7rqHWpPdwd1VU9ch5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 21:38:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 21:38:40 +0000
Message-ID: <f16a9977-b047-4841-8a31-5a39778a6655@intel.com>
Date: Thu, 28 Aug 2025 14:38:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnxt_en: fix incorrect page count in RX aggr
 ring log
To: Alok Tiwari <alok.a.tiwari@oracle.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>
References: <20250828194856.720112-1-alok.a.tiwari@oracle.com>
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
In-Reply-To: <20250828194856.720112-1-alok.a.tiwari@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------lV5SHmfXvXIRuBCLP8X2SJIL"
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: d711a6c1-609c-4cd1-b27e-08dde67b40e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dm05VzE0V0RFT24vN1oyS0lxS2FMKysvTzZZK0dFSlZDcFdqY04rd29NWnVP?=
 =?utf-8?B?dmZyMzlZSk1Qd0c3a0UxZ3NWdFR0ZGpjb0hLT0NhRlh0WUhQMXZmMGkySlVM?=
 =?utf-8?B?VFM3cDJqOXBxaGo4NFhvTE02WW84K2YyNzgwR3AwQVFma0RVdlVSTWJJS1F3?=
 =?utf-8?B?aEpMMHkxdmlhNGFhRENGOHJuNStlamJrbldjb1l5RmdWVW1CNS9tT2JUbVEw?=
 =?utf-8?B?RDJBaWNmV2JQWjJGNUtVdUdadEM3ZDNseUFJTGc1WXJTcEc3aVJpcjA2YjdH?=
 =?utf-8?B?eG9ncWc2Yitsd0RsT1BYZ2owaUtoSXhVM09pY0xhYnhBQ0pQZ2ZMVUNZNUt2?=
 =?utf-8?B?c0tkckh3bUZFQm1wSlAycktnVlJOT0FOMStPRUdTVTNyY2R3TklhM3JVVk0v?=
 =?utf-8?B?N0MzTTVpd01JWnZ3ME9NUzVKb2x0V3Zxa0xzSWdGT2F1T3cyQmJrY3NLT2sr?=
 =?utf-8?B?Q3p4Rk9ZZTdQSDBSZnNydFp4aHlaU2NsKzZ4L2NoejZqczYyNVZOTW54THdE?=
 =?utf-8?B?R216c1VINGJadVc5NTBTanMvWVkzSHJGQWRtckp3YnZCTGZrWVVPamdPRGlx?=
 =?utf-8?B?NVpiWldzaEZnYkRtbDRpaDgrNFZnZnozZ0VVYlNaZ1U3N2ZxM3J6WGpPN2hX?=
 =?utf-8?B?cnlIYzJJMEwyUVVYRU5vc01FZU4zZnllaHZkb3VzVEZjUjhiOEtoVGxISjRz?=
 =?utf-8?B?S08xWkt5dEFJS01EVzZxVEc1b1dhWmtUVWNMcTExdE16WEJsMVFUalVETkxB?=
 =?utf-8?B?eUZRc2JoZHNrMFRnQlJpUVJ5NmM5eG9QM05GYnl0bUN3MnloR3ppUzFuU2k4?=
 =?utf-8?B?S1paeERsamlqUlFVM0JKN3hQRzNSRDl2b09qZkpHNkw2M043UG9OdnhFU1FM?=
 =?utf-8?B?VkkwNHdjSHdSVGJGZDkxTTJLbW0zTlhnbmdXZWRnY1YrNk1TS0FYNmJFMlRo?=
 =?utf-8?B?aVZ0TmRhQkV4ZThJYnpJN3B5R0RtUjh3SGk4UUNrL3NieDB4V1pSNU0zbzNB?=
 =?utf-8?B?ZlErL1h5YU1BcDlva2pybTFSVDR6djBSOGFJQXRHMlptQVV4dXdYeFJRNWZ6?=
 =?utf-8?B?YlVzSHBJY2w1NTlBaUw4QlVwZ0pNYVUvdFllT2s0eGsvTWZIRzgvZ1ZsR0R2?=
 =?utf-8?B?aUZFWFcxVVdzN3NrM3hlSXZXcEZnbThEbjNSMkpaL2F2NlM2TmJqWVg1WHZj?=
 =?utf-8?B?b1lva2s1c1B0eTZmMGduVGdwVjV5ZE1yZUNRVEczN2VJWjdmUS9sREZSeVlY?=
 =?utf-8?B?YytSVTRPTHdsaXl6QXBvcDI3SnhzM3U0NllrblZsRCswY21nb05FM09yK0N0?=
 =?utf-8?B?QWFtSGJ3STVvUVFuakxQTGZqcU80SDBKelgwcXZZVXdndk1TbjBuM01hTHQx?=
 =?utf-8?B?RmF5TDYzZHgrNndXYlB4S0FIRFQxdjV4Rk85emxGb3Z2NkQvZXdyQUNXQXN5?=
 =?utf-8?B?eTBPU2NLSmZiVURTNXZiMGtFM285aTBCM2Z6NGN5U3FQVWdDMk9PWU54bkpz?=
 =?utf-8?B?QnhHK3RkdWtUdHFoZjdtUTg3VE9uOVZ5bjNHRGZmL3dOSUt6b1Z0bG00aWJQ?=
 =?utf-8?B?a3BRZSs2QVZMM1IyakoxSHhQZmpOZ3JpbER0b0hGOERvdkNEME8xdzlpeUNQ?=
 =?utf-8?B?dm1BTVlwQWU5RFM1UEdwb3JjTy9Ua3JVemtoKzFCTnBndGJSSFJUOEVxU3hZ?=
 =?utf-8?B?NHRMR3ZtU3EvN2FFL1hmR2x4QWE1RkwxS21QZzJlNGJ5V0grNktKMXNXcllB?=
 =?utf-8?B?QkZQTFpWWC9la2RRU0NhbFlSYVIxbGZUTTNGejZGV1dGU1JrT0FlRytYZmhy?=
 =?utf-8?B?WjdoOUFjaDFzV1lnQnFzYmlVVElPWHpWYS9EUHRHNEdPU2NvTzRaaVFhNE9Q?=
 =?utf-8?B?bm9hUjBpWHAzbHovTVVQNG0yWlU5RHJwYUdKQWNOR0hSOG8vRUtTVk5uNUlt?=
 =?utf-8?B?aW9ZRkxYYTBjRFJ1Q2xuWVdVOEF0cDBPZ0t6cGtCekttL2pGZEw4WXQzOVJv?=
 =?utf-8?B?b1g5ZWlpbDlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZCclhXaGdnSUQyRW5JNlRHK3pzd0Z2bkpEQlU5QlhTcDRZTVpSTHdMMS9l?=
 =?utf-8?B?bmd4WW01R0piTnNhT2MvZ09WUTI1ZnFHV056b0RuVGpNNHlVeEIvRTNOMEdC?=
 =?utf-8?B?OFJNWlFCUUJlWlVVNnZYb2oxT1NMOWd4OG1MVTlsOVJtR3FxNUo1TVFyR3Fw?=
 =?utf-8?B?b3RRbTVDTTQ4SmkwUjRlVEpVeHV2bnlIL0JidDAzVmFjVE5yRDl3L05IYVhy?=
 =?utf-8?B?TzJRYkdjR3MvcnVSMjQwbWVXYXhKa0pHQXBidlNUUG91MmxPcE9Iejc4WE9F?=
 =?utf-8?B?RDYySDNxdGVCK3BTcGtzblJtZlBsbW1ONGJvZk8rK01scHVETmQ3YWN6eWhY?=
 =?utf-8?B?bWZ0cTZ6UTVDdDhpcmZVOEd3bFpBUDVWK3hrSXQ4Yy95TU9DN2xydmNnUlJj?=
 =?utf-8?B?NjJValJQZzFTSGw1TDA3WlFDNnh2QzYwQ1RzNnB4U3JmWE9nTGhseE40blJr?=
 =?utf-8?B?aEFXZTJOcENTOTZBK3ZyVUdDaldrckYyS1I5eGwzYnZONWhORmdhTnJQTGsw?=
 =?utf-8?B?cUo0RjlRYVd0VFhRN3Y2c1NsZjRHUmR1SVNaZVdtZjdEMmozcGowS3JHTDFI?=
 =?utf-8?B?OVlPSXpZbXNZZ0JIQk0yU0tyaEVUblZEbW1VeWtwU3dQMitWK082bTRtbFZY?=
 =?utf-8?B?S3Q5bCt3eG5WeFN6RWp5akt6ZTJaZU1jRUpDSEhkZGhrd2JKMThyeXhGQitM?=
 =?utf-8?B?MVZ5V1hhOHdUbFhCOTllU0pEYnlCTjN2NzgwemxUWmJ2a29tLzhROEtWMVYr?=
 =?utf-8?B?RmpmaDkyY1JBcFp5ck5WZ0JjbHp2VUloMG9yajBDcFBNdFRvNjNMNjl3RWtn?=
 =?utf-8?B?aHdtdm81L2VtUk9ENUxkSS9Vb2JkTmZoZlVCeWJRL3lJSytWaFpiOWNvZ0Nu?=
 =?utf-8?B?YUhVL2kyNS95K2dGL3dQSktPRlNuQzZIbjJYSDdxU2pQb2Y2eVV3R3J0SXo3?=
 =?utf-8?B?eVNjNzRFdlFFaEhWOWZhcElZQ3BuTk1IbFpsc1ZYbForVGRDMkJQeUVYTVNJ?=
 =?utf-8?B?ajI4RHNkUERpZm55bDgrSHNQckJBRFNZdDlmU0pVYnNBblhVcUgzUXMrMEpr?=
 =?utf-8?B?R3J3NUd6d2ljRlJhbGo5MFpGK2wwVWNtaWozR1BDZUVSUFRCWldMMnpMZTBn?=
 =?utf-8?B?Y2RDSWdSRk1seDJoTHhVamo3Zm5DWjlSbnYzVUlueU5jNEx0Nm1Ja2FneEhY?=
 =?utf-8?B?TmdGalhsaVBPeWlVa3ZLQS9mN3FFWjJqa0JUUitaY1UrY3VqNzNteWM1Uk03?=
 =?utf-8?B?VHgwdnBBdUFZMmRUMlppOUxoc1VmUHdFaHVHaGxFWGVaNklzc2NOaXpQdHlk?=
 =?utf-8?B?RUpCWXd6VjRJQ2pHMElkQzhKR0xLZm5XaFo4elVtbVdPaUlwTTkza1VCdnA2?=
 =?utf-8?B?UjJCV0RlZXI4VnVKekhnY0NnUWlTRHJiN2x2NHUyaUJKQjhLR1ZCS0w3Zlpq?=
 =?utf-8?B?eEtUWU4vWkpPTDJTVWxkOHJxZFYyeHhVZ3A0a1YzTUtCWEhuZXNEb3E3UUFv?=
 =?utf-8?B?Mng4Vms2Z09zSDhuYytsZmxIS1NQSnQ4UVcwM1RpR25HZ0ZnVmZQSUhvT2hU?=
 =?utf-8?B?MFBaekZ5V1QydUFKOC9yNGtoOHBRemFoKzhUMlJ6TEFmV0ovdWNCeDg1OHlS?=
 =?utf-8?B?STY5WVREaUtIVXE3Z0N5VVovY3M0R1lsbzMwWCtEUnRKSUlCdU92dDY2TWpY?=
 =?utf-8?B?ZUR3QkEydlp5UnlkeGlsK1Q4QWVxRW9TVTRsWC84NmdlWTlKQTkxQ1krN2hi?=
 =?utf-8?B?UkduVVNKcGJRdk11NnArQm5EaVRTWDFCVEVaN1BzRVFlMVhaWTBPZUdYbjln?=
 =?utf-8?B?clFKY0pPUmw0TnlDNHBFc2hjVHNCNnFTK3VpSnVQSTRMeStPMys5SU42anV5?=
 =?utf-8?B?VytreW84RnFBS1h3RGNjMU95UE16UXJycmcrYWxlTW1zY0c1QVNHTlc5T2xZ?=
 =?utf-8?B?QWgwbXFURVpKaElWVHJJYloyU1pkOUxRZ1M0aEdHaGlvKzNKYWhTaFkxMDZp?=
 =?utf-8?B?RWEvWTRXWTd4eUhCWGFGWnltcnFFb3U4QXo1Z2tLZUxaOVVWKytuS1RuRUk0?=
 =?utf-8?B?bFBrYVlXclpOdnMrUUdGUGNIUmV4NkwwejE3OVU2alBKa1RiRnkyNXRPcW9q?=
 =?utf-8?B?bHhpOStKMjRJbDlwcXU5SE5iTmlRZjhVYXNFazBlWTdvUHJyVDE0dUFJVnEr?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d711a6c1-609c-4cd1-b27e-08dde67b40e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:38:40.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSILg1+wh7iNPqlY3RJdSBaHuG5zLUylq6De7H8B+nOoJW0QHKnvC9RF4iXkkRMf9SG+boBKRk2w8Hz0vsJpzZTVOZgLXJiB4elv31RRAHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

--------------lV5SHmfXvXIRuBCLP8X2SJIL
Content-Type: multipart/mixed; boundary="------------3D5yKvJN0zBnd6iZk7IuftBr";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Message-ID: <f16a9977-b047-4841-8a31-5a39778a6655@intel.com>
Subject: Re: [PATCH net-next] bnxt_en: fix incorrect page count in RX aggr
 ring log
References: <20250828194856.720112-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250828194856.720112-1-alok.a.tiwari@oracle.com>

--------------3D5yKvJN0zBnd6iZk7IuftBr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/28/2025 12:48 PM, Alok Tiwari wrote:
> The warning in bnxt_alloc_one_rx_ring_netmem() reports the number
> of pages allocated for the RX aggregation ring. However, it
> mistakenly used bp->rx_ring_size instead of bp->rx_agg_ring_size,
> leading to confusing or misleading log output.
>=20
> Use the correct bp->rx_agg_ring_size value to fix this.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> index 207a8bb36ae5..0d30abadf06c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4397,7 +4397,7 @@ static void bnxt_alloc_one_rx_ring_netmem(struct =
bnxt *bp,
>  	for (i =3D 0; i < bp->rx_agg_ring_size; i++) {
>  		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
>  			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
> -				    ring_nr, i, bp->rx_ring_size);
> +				    ring_nr, i, bp->rx_agg_ring_size);
>  			break;
>  		}
>  		prod =3D NEXT_RX_AGG(prod);


--------------3D5yKvJN0zBnd6iZk7IuftBr--

--------------lV5SHmfXvXIRuBCLP8X2SJIL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLDMVgUDAAAAAAAKCRBqll0+bw8o6P5Q
AQCuBklS52+piRTP/HOF0bZ4EGv4MJ/4MffPY3yfOGt5dwD/auxEcdzy2GYyFHxppGVKJeH+W5ds
hqtj5KCmo/rWIgI=
=Fwis
-----END PGP SIGNATURE-----

--------------lV5SHmfXvXIRuBCLP8X2SJIL--

