Return-Path: <netdev+bounces-231394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31DBF8BD9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528894274F0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F327FB26;
	Tue, 21 Oct 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4pSQYLA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC418528E;
	Tue, 21 Oct 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079174; cv=fail; b=ik2Qnk6tgyDBV3TlwKzJlRRxxG/ZqB1K0cmMmflbeyNz3RLN+lgS3YKIAaaR1pfiPgaUqyojhH4UUE0qn+mK1NHBPQMepB06xOeglF067f0VHMXMaKh/cvcr4p61vv144Xw6mI9ccT2PMAhU8J0OzlldcMXjTDqdpx8ewxPCD5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079174; c=relaxed/simple;
	bh=NH1/yuYE4b5JjQ99rwVHQni9D2/ropWYqMLuKWCyZWs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AfHuI3e8NPyF+rn403m7feg4KcPBDtMdTJYvHIGYrJCp/VfisVJfNyFsaS8InnJ9I3Je596wbCkgazRbHKd0MKwmOxr/wsHAtXBwm7NCIyYXCPZ/5kyRor7BHiVzCLMtTfedvvHlWmMwAxRjXnm918oUlrfDGlRpTWQ4zwVuJuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4pSQYLA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761079172; x=1792615172;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=NH1/yuYE4b5JjQ99rwVHQni9D2/ropWYqMLuKWCyZWs=;
  b=M4pSQYLAP7MQeg+EZMU3s49/b64rk5hrGTxiENTrkt+oESboC3zH1FWs
   VHNpjiHahfLbtCVd6VrkVMQUuoHufQF0qqb4R+zXFCbQzLFJGpUF5TC32
   tZSkEY4LNhwuxYHaJKKwgZ4hWD/MHI5xJ0cKZg+PmFUymwycMX+iuFYvG
   51Qe5Gbd3F0ah/XKq4tnU8F4D4e7E8f1Md0QiSV33d4wCflTSfQQspDb1
   AMCsRY3ZTH40/unIw/+07YHaEjUvBqym7csyLEXLl9ITMWGhFG75AS4dZ
   AsPN6grL/Ltio3+NeJODF2aCeRzPMyfWnBYIopHtLQDhl0mbfOQZdlhPL
   g==;
X-CSE-ConnectionGUID: /ytnGjKxSoetpYBryaQehw==
X-CSE-MsgGUID: SVeM6pwpQBCZbUdvVw2zVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63256888"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="asc'?scan'208";a="63256888"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:39:31 -0700
X-CSE-ConnectionGUID: iswWJ//eQJivU/R5rKYZ9Q==
X-CSE-MsgGUID: sQqJh5cJQRKydcyuYmCqiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="asc'?scan'208";a="183621613"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:39:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:39:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 13:39:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmoRZsfhR7GiuuDK9Cr1QnB6HvbCFDEQd+rFsZH7V9fXKaGVM872zlMUofSnFwlOEh0p35MvdWtP3mBvXfUMB7s3Q+s3CM3V/u2juhlbp54LhNFXb3IDbsOBdm6v80gOyeQJW7vqHIx8f5DVjBD9E16C26C/ilvMxPcVODAgsG/PnexzTY2XUXEQDxukaH9v+47WS5oP3xHJ+OHZkvQ+gAE1Xeq9YNPubA/fejER7xlJds8+wowKidwUWdY0Zomiiz5XIag2ddzMKTLVB4zTgHSZboaMtofUdIdMSOVJoSUnzT8MiVrtNMFkS/kHfQG4MSnyw9mqjhljS61ncIZ6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZZn7FLuf3tjSTp/Ar/7AujF3+/2Z4dT/M8EbFii0NM=;
 b=tPDUrZDl9yo+tdzo+cxoaTefPeWVDwWoUGJGHriAcSkVbGPIMwXrc5dirvvl9dPOTnJWTWvRdEALYJJU+37EImxdVUgBP4Gb3SRp/FRYutPFchqbJIUZz/DUtYHjAdn6xuZI6Tzo1LBUGN5MGiC5RZ4M+Xbcg8Ev1hLocaWDgjNnoXaetOoek0q/E2eiBkChS3vJnki1uuTF8wh5ke4qNWwNw0JWS7GtSJ7hfpFWSGI4NLdFPW53sffepzMFgTqj1uH8APERh9cGvZ0/PbJbPmKF9HkuZ8hjLhLjniA9qfNK6V74Nz5AJ5zic8MvrleWuVRVWAbtSv4zL6jDsTrJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 20:39:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 20:39:28 +0000
Message-ID: <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
Date: Tue, 21 Oct 2025 13:39:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohammad Heib
	<mheib@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
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
In-Reply-To: <20251020182515.457ad11c@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0PW0oFiXLl076AJpfxnUbN0D"
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 672d38ba-27a7-4fec-87c6-08de10e1ee58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTNGUFdLNm54SkRNdXlyMWszNzZaUUNVU1NyNWZaTkRvVVBLU2pHS0tFOUNx?=
 =?utf-8?B?cFc3c3VYTlN1QWRhYjBLZXZ2a2wzY285d1pONTJ5Sm9mM2M3VzZhYU9wdXQ4?=
 =?utf-8?B?VXltTlcva0lhazJjOFpmUm9ab1ZZVVlnbkx4SFFPTVhKalVhWjZCdzh2MEdh?=
 =?utf-8?B?KzQvRkpJM3pRcXhoWHBBMEdFRGRKTXphUWxjdjVNQ1RPVFNrN2Rod3VOV0Yv?=
 =?utf-8?B?Uk80RjFrUm9SNzBSMncxdzdZdjByZTNxNFVMNkJuWnJSbkZGK040TmxjMEJ0?=
 =?utf-8?B?MllHZDAxMmwweHdiTUhLTzJuNVJ4eEZURDdBSmZ2V1FzbVY3akROTWVEcUFk?=
 =?utf-8?B?amNpaGNGMUQ0TTh6ejJrRHAycVMxQmdjOU93S3JzN1ROdVlVaWtrem1xTmhs?=
 =?utf-8?B?em92ZGZ0Nkl5ekU2TnVqdlgrdm9rQkN3L2ZsZlRrTy85cmNoQklGTlVxZEo1?=
 =?utf-8?B?bVk0ajVxWUg0TlRMK1Y3dHFiMkJ3dDlKbDFzQStKUmo4TmlEYkZkN0hqTWhW?=
 =?utf-8?B?TDNJRGJTN2xWQi81c0c5M1JmTWV2b25EWE9MMlBjWDM3TnpZRXdsRXd4c0dK?=
 =?utf-8?B?aytKbEUxMmRPcnZCZWNWVWJhYXNzSWtjOU1adHN1Kzl5cVAzT2t0aEFIQnVH?=
 =?utf-8?B?cVQwQzRlWmJIRklPa2lKK0M4MGVYcC9zSSsxQm12NWRaelFCNFJORnpTYXor?=
 =?utf-8?B?U3VnTk12MUhlaGJpNzBJMFV2ODJhWlNGM0FwTlRKMEp4OUpEUDBEK3hZZEY2?=
 =?utf-8?B?VDJoL1RyYlVwcm05bDFCYTBDVW5RcUpxbGpFdm9jcW9sd3laUXczc1RaYllq?=
 =?utf-8?B?NTVoMXpxN0FMT1RsVkEvZDhzS2lDckVDS0lXdjM1dXNCM1RFYXovenljTHpv?=
 =?utf-8?B?dzZIL1MybVpUSUN0Qnk4cEE5ZmgwZnRFdFd3b3A1UTF0UE1MbVRQbFBGQUZE?=
 =?utf-8?B?YWhUUDNVZkJBcXRYbXdXYVZ1SXFoRVhwWGsyaHpubmJoNVcyV1ZXSlVnY1dq?=
 =?utf-8?B?YU9zcWFYckplOXBsbGZvOXlWU1k5SFl5bWd1Z1h3WU81OE11VGcwVFVIcXNZ?=
 =?utf-8?B?WUthVjRSUUJpT1B3TzFUS3c0MCtVa1VidGt3dGFqUkJVY2x6SzF4MzFKdE9a?=
 =?utf-8?B?SnYrWUpMZzZIU1JTNjFwb0tBSkdLb3ZmQ2wreXNKbThXWEtWUXdkamRpc3dW?=
 =?utf-8?B?bjBkc1VyeitkNTV0KzVOMlQ3Wm9jWWxlZDFzTU1qTDgrZlZsSThLeVYxeE9h?=
 =?utf-8?B?NFdVZFo1UGdxdmZTYU8zenVaVFc3b1ZEQUhDUThuWTh5VUxPTFZwaUtyL0Jj?=
 =?utf-8?B?TE5EUnFGNXdadi8zbW5taDZ0VmVrRGNmcG1QZVpnSEhRTlpQMFAwd3dRWk45?=
 =?utf-8?B?a0RkRmdzRXV0R3RrNHFlM01DWnhxRWFMWWpPSnFnU2Y1WkhhSVl4MjBMQWgx?=
 =?utf-8?B?blo4TjR1SzVGdkZraEtLY0k4VjNrZk1XdGFwSmNsUTNkMkk5VC9LZG5qUytm?=
 =?utf-8?B?TklwRjJBaGxJMVRjQWhFbkptRGtoK0Iya2xyTGhrYTlPck9TZUlLR3JHSjFZ?=
 =?utf-8?B?TXdMUHB2VU9GSTdsRU9YUEJzZ3B1OWFJMmVsY3dnWnhVUG9xUllMU2xHQmtJ?=
 =?utf-8?B?Z3dqbnl2djEySEM5UytjUS84MHJqSWhKTmI0eTNpOFVwUkt3dmJYSC83QmVQ?=
 =?utf-8?B?Z3dLVFYyOGxNbEtueE01R1dITGdTeXZIUmdCNVBURlBBWDhNMTdrTkMxNis4?=
 =?utf-8?B?UHBmZ3hLelh5TWlka1pqZWRpRnNOUFVxck1DS2xyVHpobEdqZVpsbnBISVVK?=
 =?utf-8?B?Zk51aitrMTNzQW1qTHRuOUIrYzJzNllaK0lKak5hTVpWdEthNEYzaEcvY1hH?=
 =?utf-8?B?RU5yc1gzRGc4QWtNUllxN0s2UDI3YTlUNjVBaG9zR3JyZDNscEZROXJPTi85?=
 =?utf-8?Q?mET0VsA4PMwEqoUBdvuQQ8Vr6sM0qXNn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDIxR0djT1kzelFISk9LNHdIS1NDcERlWjN2UnNzRU5BR0UxNUFZWjZadGFX?=
 =?utf-8?B?cCs5Y0J6Um12UHlRSStMZ3FFRW5WWjlZcDJiQmFiak9PaFJMU2I0Y0FLS3E0?=
 =?utf-8?B?T1lhNGN5dGVRS1dmMzlvQTg3UzB0OUhxQ2hDOGE4Z1lJQzZ6Zzk0ZWNRT00z?=
 =?utf-8?B?MzFBWk9DdmZ5TFF3dEJrRFJKRGVPYUtCdlpHZzI0YTBjWkZaRW5hT2RyYnFk?=
 =?utf-8?B?alljZzBuZUN3bUdyanZTaVBSYmJzTzZvTWVIaWdSTkptR20xN0x1UVJBeUZv?=
 =?utf-8?B?Tm9XdXF2UGVhM3JWbVZ0N0ViT0N2Zjd0WnZ1eFRnUkpsWGtBdmw0RlNhbTdE?=
 =?utf-8?B?NExNVzdkK0dOZXhKR0JhQjgyR2gvT3U2Qk9zdUxjSFZoM0lkL2EzWSsvMTBQ?=
 =?utf-8?B?RkRCQVFZNytKVmlGeW1CT0tGQkhhNXR0Yll4TlJkTkxoZy9mWVlBOWhhWHRr?=
 =?utf-8?B?dVJWNWFjSHpYUE81cmRzM0lrMWUveVNvaWVhakRlenNQckU0VzZRZUF2Yk5i?=
 =?utf-8?B?OWpyam5sSWFaU1JKU01seis4TFR6VnJlQ3diOERHZDNOcUpqdG5pZkc3TGZF?=
 =?utf-8?B?NE94NjY0ZC9LMm1nUXpMUjZOMWJ4TUM5SDFMZlBiMDU0VWhjMUNjQzJZdkVD?=
 =?utf-8?B?cXRvWkVVeDhaRkJYeVVqUWFoaDVzS0E3alBBc0NGaDhnaG5ZdUpBV2RHREh0?=
 =?utf-8?B?Zk9WU0ljYjZlVHdkWFB3Tng3bW92VGZmcHBpVWtQKzNidjQ2U2llS082WFFi?=
 =?utf-8?B?Z3hoNXFCYkJUN1JwY3Y0dURNc0tRSCtpZ2tCQUpZUXdqSnNabllMZFo2VXRx?=
 =?utf-8?B?YVFBTEFzTlhkcGJDSk5QdUdTWGtyczNVZzZFVXJrOUpNVGRiZzI5R2VXOEJv?=
 =?utf-8?B?bUNkMlBWdWhDK3lYK1pkR2NQbmhCOGVVS2IzYmhSSzhmU2xxTWU4emRFNllq?=
 =?utf-8?B?aElXWHY3RTZERHYxQVlBQkdOWW91MzdDNGlibzdua0ZNa2UxbnAzc1NMTHpU?=
 =?utf-8?B?em9KaGozUVdZeXpKbWlBSmYwSzFoUWZYeWg3UHR6aE5GWHd4b0x3Z0ZVZHY0?=
 =?utf-8?B?NE1HSjdlU1NKVEVjRER0U1hvOXF2RTJYblpCdlNzOGVDc1NSQVA2U2V0NTV0?=
 =?utf-8?B?aEV2WEU4bHNKSnIraWFiRGlIYWlPMFBFRkt5aEdWb1pqTTJQK0NmTC9sL3Np?=
 =?utf-8?B?VGNUNmM0UXc4bHFxUCtHZzhYd3Vmd1o5a0tUVGJVK24vODJsQ2Ivbk9IMzhz?=
 =?utf-8?B?NHRUWm4wQ3Nxcy9lM3RPRzFaWmFUbDAzbUdFT2UwUU5HYnZrRGZOYVRMTmtT?=
 =?utf-8?B?Zy8xQ3VHM2sxSm5kR29NaGJkK3JpNVJydmNjSnp6OWw0U29SS3pyamxCekUz?=
 =?utf-8?B?UllFdkFySnR3UTZURUc2ZHpyWCtObTRiVWR6Yy9Gb2RUMHN4ZUhsMGNRQVJn?=
 =?utf-8?B?VkxUamEvTXpTYjNxU3VaVDJ5M21ZUGE3aitiSTBPNk1iTExWaXV5NW8xcUlw?=
 =?utf-8?B?UmpIV0phUTFxOWZMci9QbDZ3ZjVTckMxMXFyejExNS8vNTZNdENuQnZxdmpO?=
 =?utf-8?B?aStzazJ3Uk9yNzVqUFg0dW9NM01TYUFhWVorTU45cW12cEFUVFVSVDd5RkNr?=
 =?utf-8?B?R0U1c2p4akdiNGdCVWpKQndkWG1vbS9tL2ZTMlZWdjd0Qy92dW1rbS9MdVdN?=
 =?utf-8?B?aDJOOWV2QlVHaUVRbmwyKzAxY2poSGhRdkhKaS9SYW9UNWQvalFMeEVyeXg5?=
 =?utf-8?B?cE5ZcElEK1ZmbFArZ0VxRUdhTVFoVGpSKzFFVzRzOS9YWEk3dEpnME5TUkJH?=
 =?utf-8?B?NmV1YU1MZWJHVGtLOW82OEdtSmM4VTByaE1wTXlZSFRXZm5Od242MjNUZUdY?=
 =?utf-8?B?SU9FZ2FYK3MxZ3BUbGw0eHJCaUpJZE5HSFR5VXR1YjVJQ3VFeDBZZU85YnNL?=
 =?utf-8?B?TFJmNzU4NklOdlBDeVZLUlE5YmIrTWYrckZ2SUFVUzVTdEhySHBjZDlWVko0?=
 =?utf-8?B?cWM3SXV4MjdWTkVNL0NucW9VZFJqTHM1QUdEcytSYktOMHI2WTVUMkZBYXUw?=
 =?utf-8?B?TnpOeVlDanVGcERka3NFdTFLOW1hdzNxUm1jVkYxOXhZdFJLcTlCWm1MeVMx?=
 =?utf-8?B?cU8vOFRoazNaQmp0dUxBbHdlT1c4V3JhbXIxNFJDZXY4UWNTMUw3UUMvUGNn?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 672d38ba-27a7-4fec-87c6-08de10e1ee58
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:39:28.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDQkA+nSvSDYwmVjy3tpkPsfFX2TUDzC4TqqR4yjmvX+ihnLLar5oShUCyIQa8hpqTkGBtgoLIucUcypK43+zUJPz5qwn1Yah57mo/KZW6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-OriginatorOrg: intel.com

--------------0PW0oFiXLl076AJpfxnUbN0D
Content-Type: multipart/mixed; boundary="------------Kmw0bZdio7L0W7o2zXVm5vzt";
 protected-headers="v1"
Message-ID: <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
Date: Tue, 21 Oct 2025 13:39:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mohammad Heib <mheib@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
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
In-Reply-To: <20251020182515.457ad11c@kernel.org>

--------------Kmw0bZdio7L0W7o2zXVm5vzt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/20/2025 6:25 PM, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote:
>> - The configured value is a theoretical maximum. Hardware limits may
>>   still prevent additional MAC addresses from being added, even if the=

>>   parameter allows it.
>=20
> Is "administrative policy" better than "theoretical max" ?
>=20

That could be a bit more accurate.

> Also -- should we be scanning the existing state to check if some VM
> hasn't violated the new setting and error or at least return a extack
> to the user to warn that the policy is not currently adhered to?

My understanding here is that this enforces the VF to never go *above*
this value, but its possible some other hardware restriction (i.e. out
of filters) could prevent a VF from adding more filters even if the
value is set higher.

Basically, this sets the maximum allowed number of filters, but doesn't
guarantee that many filters are actually available, at least on X710
where filters are a shared resource and we do not have a good mechanism
to coordinate across PFs to confirm how many have been made available or
reserved already. (Until firmware rejects adding a filter because
resources are capped)

Thus, I don't think we need to scan to check anything here. VFs should
be unable to exceed this limit, and thats checked on filter add.

--------------Kmw0bZdio7L0W7o2zXVm5vzt--

--------------0PW0oFiXLl076AJpfxnUbN0D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPfvfwUDAAAAAAAKCRBqll0+bw8o6MF2
AP9d4s3FXCfVCbsCX+JhfUE3+OMwD72kWTFkDpWdAVp/0gEAtatMTlyirNOyerfKFDwiYAaAlvPY
hJPQj2Gq4FApCwQ=
=qPvB
-----END PGP SIGNATURE-----

--------------0PW0oFiXLl076AJpfxnUbN0D--

