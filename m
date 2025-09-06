Return-Path: <netdev+bounces-220521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73916B46788
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335625C449E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92A0145B16;
	Sat,  6 Sep 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIFdgq++"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B117E4;
	Sat,  6 Sep 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118481; cv=fail; b=NQ1iafg8wfg2wCsZckp+j0ls3BNT3Qzo1fkJXWF2clR+wzFvN80NssUaHN1kinOpr1ASs4gqLYGC9v51sDu7acBqokRGV/NV8BCKrNQ6Ca+xwrRNeu9K6WB6Hv7U7jMeQ2hBTwJyUzRWqwCdlg/D8g1H2NJBCtVKd35bZfQYPx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118481; c=relaxed/simple;
	bh=2l+CBscNhtdUaHZLWxdh1rqP9yGfybXPw8XTaeKrjXQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPInHRX++6ccN9hBVdptH4Z/zs51oOpS+uZmzNFE4nS0mMxLAip25GBZslwLJScJE/kAsWzb6yhL2mN/2PjBc0tO96Oa9yrK32Gj8o8tH2X3IhryBHZEVw+ozqRlqt0y+8SDXjyF+1Szh28gQ7NyTf46XnuC4Nky4ZOJzSyZybQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIFdgq++; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757118480; x=1788654480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=2l+CBscNhtdUaHZLWxdh1rqP9yGfybXPw8XTaeKrjXQ=;
  b=UIFdgq++Crcbg1/a0rWRSg0kzio/okf5vfKnZAE3TPxeJINbZkIkXgpV
   IhLbO0LglgcwhIVFvHszBvLsa+QQ+usrBEk80WPwGVauxrIh61YkMnlii
   w4+K8tt2htEvm7o+kl4H8lZNXn1tefUcNR6h2EkMC/+FstFr4bFWx7OrI
   1h5pqhUmMao7zLhErmg1yqOjZ4UpDQFuLq8Sln3GAJUrPFeZGH1YYl9Ns
   Z1fIaRZ02TzUWaFbB3PyzSDKMPmfWHK+gsBNMgsMQ0bu3VIHSBPFznbBd
   IIkzohFqAL3SmALwQhA6BI48m/nk/r4AnbKKHYHokvYWsaDlc4t5022zD
   Q==;
X-CSE-ConnectionGUID: 3qfsOee9RX6aE2OSs5Z+ng==
X-CSE-MsgGUID: CwPnXpQgS2WUlPY4GEhlSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59169682"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="59169682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:27:59 -0700
X-CSE-ConnectionGUID: 64vcsKAjTWKgcOBBxmFwSA==
X-CSE-MsgGUID: sluusf8mRvmMvuAm4wZfcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="172196008"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:27:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:27:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 17:27:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.76)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:27:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eypCwYSKLWZHF9OsxHfZ/829md+09Zeu1p/hByYrzNscE9AFt1sDLLIFmb6S/3HTkpSdPbGaBz5TJ0YZEgCw0V94SRw2wQY77KBlJqhQhrwR6S8RCJzN2x50o3M08j7EvAAAbk5GNwCzgAO0ium19+C3ImeDvu2+Q1ZR++81L6zNm24xXHoUkKqDCdbxbnpFI9C0wY6GvhvnRaZGsW6Mva0WkmbFqwpOi60oF74bt9aHxobfhqzo3ZxLcPnyX2bBbDHUh2vJn1jQwhdiWb+QMboaF8xRELPS3UoVNSQr6azxRPo25AbNy0UdyUe25QsE/PyeU4nL3w6jMT4lMksCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VBY8nG06nqhQfbrzshzdZ2thnSn8cA2Cp4vekoGjZE=;
 b=DgoCrui0v6ak9z5/bR+wylQFLs8s7IYoKXlkdQj1J5Gf6FLi7NbUXYjV3RTAp6Z+Esqdl6nT3a/1qiCffwIVr5lOEOdN5rYZIaxQ32QPKo+k3Kb59Ci7jpChTjKXfKda7O0uQxbEilVsjNF35kwGxRIy7uNXqxomU73RJifmJ6Sl3/O9s97rS5uD9hF7F9Z37rjymU1OhRGfLWhZuAqdnVfJAjcs+hKeremZKWOQXib3gnDb7RCzGL2MuSb5PizDes65phImM1MHZrHZgr0iiIXtUH0AOWZHvxFFKI1fEyeFCzJqw1xOC/HDzZJT/4uP2D8vje7s5Qxvwlzfjom9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 00:27:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 00:27:49 +0000
Message-ID: <410d69e5-d1f8-40e0-84b1-b5d56e0d9366@intel.com>
Date: Fri, 5 Sep 2025 17:27:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
To: Donald Hunter <donald.hunter@gmail.com>,
	=?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<wireguard@lists.zx2c4.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-10-ast@fiberby.net> <m2h5xhxjd5.fsf@gmail.com>
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
In-Reply-To: <m2h5xhxjd5.fsf@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------n8uGMrTWfv0xFR6Or2xhxXG8"
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a2e933-5107-4b0f-331a-08ddecdc350d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHVRSktxSTdYSkpuenUySFNlOUZiMHJFd0lGN1BrODNSOHJOckFDN1M5VjNS?=
 =?utf-8?B?WmZVMENJazViNmhqdTNtNUJVTGZMRUJtNmdMb1k1UEJSVHM3Z09uV1lDakJ3?=
 =?utf-8?B?WlMzc0VhSVhraG53ZkZ6cS9lT3VuRlNQRUMrMHp3YUJMZ2tzMHMwWWdLUVRi?=
 =?utf-8?B?UUJmbVpOUTBFRnZXN2pGbHlnckRhRkNQbkVoRS9ISndLaHhaaEw3cDNybzgz?=
 =?utf-8?B?QU1RWUtzczM5YVlhUjNXY0g0SU16ZXhhU0JEcTBJNjZpYnMrMEMrWHZ5Rk5H?=
 =?utf-8?B?NXRMWWJmbXVEYmRYbmRneHRia29HOXpCMWkyVXpmZmR5MVUwL1hDZlJDbzYy?=
 =?utf-8?B?clZMRURCSW9ubStzSTZSVlFFTmxBRm5IRUxUNmM4V2pmMzYrQTNzVmtSak9K?=
 =?utf-8?B?eExTUWFKN2I1ZmE3TXNGbkx4MFNNdlBHbUxTZ09xNDd2Ny8wZHpQWDgwR3VN?=
 =?utf-8?B?Q0Z5MnduRDA0aUNlYzV5QjFaN0FKQjBGaVlHSkE2dENXL1E1MWxXNFpoamRM?=
 =?utf-8?B?RnJyUWJYTmRZVGdsVFFZbjBsejl1K1E5SHlvWEI1em5UdG9paEl6aVVoMWla?=
 =?utf-8?B?TDJScS9nREJEQXZuYW5KTk5Cd2RxK2FFRnUvNStxSWNmK3U1WVl0b1pDaFY4?=
 =?utf-8?B?WkNlRktueTZJOUxRTjFhbEQyUTlOT1pHVmlCSkRCUlFsbTh5aFoxdVVCWnp3?=
 =?utf-8?B?QUVVQkpWY0tOeDNJTnJoNzhWVHAvaTcvZDIvK3ZXbWpSYmI3NTZycVJCNFpJ?=
 =?utf-8?B?OFB5bjF1alBCeXNiSUpQS3Q0b1k0MmlqNERYWk5LOFg0ZDV3UWd2dTJZL3I3?=
 =?utf-8?B?eEVvbVhwZDJnUjdZcUd5d2xPQzRQbjdYNDRmcjcwdWlYZ0xRRG5seXRXZGF5?=
 =?utf-8?B?c01BSXI1Mm00QzBjNFIzMTBhRGovRm40ODdQcFJPRXZuZUdTL1paZmFyeDdY?=
 =?utf-8?B?NmhOaEdvYVZvR3ExeDlQVmtZNFc0TVV4Y3Vyak94bWlYQ1ZMRFg4M0pQai92?=
 =?utf-8?B?NTRnNGZyTFBGVGhoK0ZvcUh0bzFHL08rT2xzRHZCaEtRZ216Tlg2YUV4SHVO?=
 =?utf-8?B?dis3V0dDSGdWQ1JkLzdydGtvY1dyQ1lJMlcydjh6blc1YlNua3paQkFkVTlp?=
 =?utf-8?B?SmxiUEo2WGFWT0g2cWMwejhKdkcxZ3FHZSt4QitQSXgraWgySTlMNTlic3Yy?=
 =?utf-8?B?ZTVtZ3ZvRjdrRGlxSTFKSUVxbDVHcFZMdVRNbHBIN3A0bFFudytoU0ZvcFg1?=
 =?utf-8?B?UlQ2SHRGUHYwa0V4SW9YdDloTVNqaU84bnZUTlhjZ3hmSjRQRFhFVXl4VURO?=
 =?utf-8?B?WDcrWllwMGkzM0tFUzd2VEEwRkx4R3BRcTZpK0ZQb0lkYWhoMkQwV0tWazVn?=
 =?utf-8?B?UWNPNGZaV0hYNTdPMXhKWnNnVG44OER0SVc0N0k0d295RHZoWWJkcEk3bVNT?=
 =?utf-8?B?OG1NRkNnRldPREdVNUZZeXNVQnBEbEViejNlTDZhNFpUbE95dm5ENWVEZ1Yx?=
 =?utf-8?B?WC9wemRWT05oRmtJQ1hyb2diWTdPVGZvYW9peEh2S0dnYUJJckNrRnJhUEk3?=
 =?utf-8?B?cHlPK0tOazNLODNNYnE4Szh0eUdsdjRJaU5kQXo3cDFpWlFyWHc0VGFOWFow?=
 =?utf-8?B?OFFDcGdPU2ZKV0UrTDFVWFNPN3ZxdWVxRTkwZlNzV0RMRnRiQURPV3hHb0FV?=
 =?utf-8?B?d1J0aTh0dmNuVDlOY1hsb1dEMHRQTzVsTjBtaGwxMHErck95cUl1V3N3ZElP?=
 =?utf-8?B?cFRaTEppY3BnY3o2VisxQWYyNmppRU9UYTF3UU8vRTRXelYyQVVEU3BvYjht?=
 =?utf-8?B?VEw5UHhYTXY2SjAybnZvVkJNSHl1b3RHYlVydmU1T0ZFYkJ0YjFpNWpDNTBr?=
 =?utf-8?B?ZXlCdnRnbHNSbXFaUDRVeFpmRXdJUFBFN1pCRG9HYzRQZkNCbHd1ank4MDZF?=
 =?utf-8?Q?ZVXaBW6SzxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVrZldqT1BtcTcwL0ZscFkvck9kS3J6cjRpN2xBMzRjSmdaSUpabzQrdTVt?=
 =?utf-8?B?N05iVHcvb3d1eVY3cTFsUWdBbEh6YXJZMWVhdlJuTk9JcU9sTFFXVHBzRG9i?=
 =?utf-8?B?U242T2xRM2pSSlg0T3phWmhNM1lqdFgvNVFlRmNyL3Y5SWM4N3FFSW5GbVRa?=
 =?utf-8?B?YnUxUGVReEFiUjlLOURCYUNXUDg5M3d2NFNjMWRaZ2RmcFFDSnF3NlNuTndu?=
 =?utf-8?B?SW40M2F3Tk5TYlF4QVVOWU5CVHhqMVorVzJEQldEdk9YSUc2b0ZhSHpwbTNL?=
 =?utf-8?B?UGUzNUIwTmlVRE5DUW1tbS8zUkR3WHg0ZDNDM29mR3E2RU5aOS9vTE5tcGtW?=
 =?utf-8?B?b1pqeCtWaWNDYzZqOE5ESWIyYmd6b05SWFhMNmFzcno5OVNxU1luMjdDK1JK?=
 =?utf-8?B?ZUg5ZnplOWxWRDd2RzJmYlpuc0pVdFBNazlTZ2pIajBzRXJwOUhydjNXeFpV?=
 =?utf-8?B?YmovZVdnUmp6dklOczVlc0l4MEg2QXBZWW4ybkxGeDVodXpGT2wwREZ4SVBl?=
 =?utf-8?B?dVYrMSsxR2tzRjVvMkZzTmZqbWlMS0pCSXh1cko5c0NJZytRUDNMQU51cHF5?=
 =?utf-8?B?UUdlUkVpSHhVR0V0TkRJM3ByZTlIKzlhUkVLdUVxK2JRL1dQNVM4ajVnUVp3?=
 =?utf-8?B?Y2FqMEZVOGtiSHNRYkp6K0drSEFxVVFyS3hDYWZmRlFkRnRqYVlLUUxVY2tr?=
 =?utf-8?B?VG0xK0IxNit5dnJTMGMxejBRNTV5TmxLbDhmM1BkRFhYWlVDMFlnTnlGQW1L?=
 =?utf-8?B?NzczbjdvMDA2aVZya0xLbHFWaGJSbVBtUk1TYUlDQWpJWU1SUC8zVnhFYUJn?=
 =?utf-8?B?SHBreWJnemhvNlRraHpWVzRuRjNWcmpLZURBUXpXTUlIL2l2d2ZDYWE2VlY4?=
 =?utf-8?B?UzRIYXhsa3ZWWUMwbitlYVJrQlNCRXVwUmFIU3NHVVFqa21ON1Y3TW9BSnFZ?=
 =?utf-8?B?M0RaNC9UUlVONFNOeDZtemZrUTQwT2NKamlCcVdlUms0KzYydWk1YUVqcFZw?=
 =?utf-8?B?S2E2YnB0UTBaV0Z4Um45OHVXNTFsK2xKNENQMlYrQXk4Z2dwN21DNzJBdnhi?=
 =?utf-8?B?SkhEYzdnQXN5UnRUYVRXRkJWdWorT2JsRk5ZZ1hlRFlnWnozL2p2alBhZFlU?=
 =?utf-8?B?UHIrZ3M1cnppTjBOalU0enN6WENjOEMvS0dwOERWbkhtMm1XZTFhcXBONm9x?=
 =?utf-8?B?MDBpMGRaMUZTREo5MkhlRWNwNEI2cnlkZTNxRWFSUmdNazc4Wm10TzZhTUFZ?=
 =?utf-8?B?TzRWSTR3UUNrUVhVdU9ZR2VObDlzekU0REp2VWtwaFFFbXk3RXhScGFiN3RP?=
 =?utf-8?B?ekR2ZE9Ob3ZhZ0JJbkh4SVFOZXpuZ3d3NlFpb2lLRG1zL2dNUCtKMWFvZXpi?=
 =?utf-8?B?ODhxaXFiS1pueVlTVVFoZ05IZWtrKzd1ZE5aR0Z6U1VSNlpKV0hyMCs3THF4?=
 =?utf-8?B?eEs1ZXpSWnFBQUlCcTlNOU9TTmRmeEVxVWJKelFkejhXOENEWDhjaWxQRUFm?=
 =?utf-8?B?M0hMTGVVNlRacjcxdmRrK2lVUFBqYWdpd0VzOHIzWE1uRTA4dEFaMTc0YmJK?=
 =?utf-8?B?NERmN1ExSll2RmxDK2dGdm4rQldkMitKNzBDNFVkRERhendoL0dXN2dyRWFl?=
 =?utf-8?B?NzRCVlBBTmxxWFBMV0IxZExhUHVNVHhFS1JJSS9VMElhTmU2ckpPWThJS3hv?=
 =?utf-8?B?Rm5oVWxyaktENDhrUGYrNjdXTUF5Z1dEZ0dSa0dubXlsVlR4MkxjQjhZMlVq?=
 =?utf-8?B?cXZzMWdpUUMzVnJuVjk4OEtTMFMwRGdsQmp3QTZSRTJ0bEVuZ01sckFnNUVB?=
 =?utf-8?B?UklORnVFbUVwR3FlckFyUG5tTjZ1VjRkOUl3eEhxVkgvd08rcWtsazNXZThN?=
 =?utf-8?B?TjZWVkh4MjFXSEozeUo0QW1tR0JjTjVINW16NkVWNWF2VC9ZQzd2eW55YlY0?=
 =?utf-8?B?bnVjcFlVempYRk16NWxRZkpiYzZyN2taeXpZYUlqUDVIWStZNWR2Z1MxSk1T?=
 =?utf-8?B?TVg5UXpaMkczQjZ3TEdUVzdNekFibEVEc0M0YmZUTkVhZzNyNGxKQVYraDhs?=
 =?utf-8?B?cVlWdXlpM1ptZnQ4ODREVkllNkFtaFhMaCsxajZnSkIxUk11eEplckRCRGJr?=
 =?utf-8?B?eXhNbnNBTlV2TkhoYWlWYm1jMzdNaHNJWlQ1SnZLdE9RbFJrRVNYRzhIMHpv?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a2e933-5107-4b0f-331a-08ddecdc350d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 00:27:49.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgC+Ns89bjar1ZlD4G2V9EkEGM0oKkaCyUzLh3xLGVazeYp94pX+AYsjSpkA1Zgyb+/EKpONVhORGYrKP3szCzYaZz88hlNULrvq7BHHQ+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7857
X-OriginatorOrg: intel.com

--------------n8uGMrTWfv0xFR6Or2xhxXG8
Content-Type: multipart/mixed; boundary="------------pcaGaxQBYsUkPC54SpjtEuzK";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Donald Hunter <donald.hunter@gmail.com>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <410d69e5-d1f8-40e0-84b1-b5d56e0d9366@intel.com>
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-10-ast@fiberby.net> <m2h5xhxjd5.fsf@gmail.com>
In-Reply-To: <m2h5xhxjd5.fsf@gmail.com>

--------------pcaGaxQBYsUkPC54SpjtEuzK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/5/2025 3:51 AM, Donald Hunter wrote:
> Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:
>=20
>> This patch add support for decoding hex input, so
>> that binary attributes can be read through --json.
>>
>> Example (using future wireguard.yaml):
>>  $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>>    --do set-device --json '{"ifindex":3,
>>      "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>>
>> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
>=20
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
>=20
> FWIW, the hex can include spaces or not when using bytes.fromhex(). Whe=
n
> formatting hex for output, I chose to include spaces, but I don't reall=
y
> know if that was a good choice or not.

I also prefer the spaces for readability.

--------------pcaGaxQBYsUkPC54SpjtEuzK--

--------------n8uGMrTWfv0xFR6Or2xhxXG8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLuAAwUDAAAAAAAKCRBqll0+bw8o6FUB
AP4+TG3BZpjRxgVGJgY3+/i7Y1XHG84uqwuGW+hkX+k1BAEAyrdfKsXXXDKVHEqrU+0kbeEwJasZ
OTTAah2NZ2brMww=
=8zw/
-----END PGP SIGNATURE-----

--------------n8uGMrTWfv0xFR6Or2xhxXG8--

