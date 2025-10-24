Return-Path: <netdev+bounces-232672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5659C0805F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B41C23C27
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA22EFDB4;
	Fri, 24 Oct 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LM3s5IaF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB882EF64C;
	Fri, 24 Oct 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337240; cv=fail; b=VOyRhOaMFXK0tVi0krsQ+3edP86LvTCvwOYZ/gja3WiYPTm+oFYWburxK+qoF+//pnnrSsm9OyOUwthaO6fQJiz00Oku7YCdYhEN6nvnAsiG5PjnJB98WL4eBa2m0TPc/N2uZw4VyeLugi7lRFedr+vyUrNiYEF+RMQ42QuiigA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337240; c=relaxed/simple;
	bh=Oi1xeIbUWJmkdlPTt1/3FDQvDcyhHInFg0Dx23iYTLY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pycdf+Rdkuvr73iuLjA7O5JyW1Fi+4gZmR3Efb3XU37C5NLTLOXdrxtpvLAtmbA207FJ26JDToAW6OFmJlmFgf5kQS89mNLpytxY6kJpJ8Q4EgZu4sMpkHllKbt1BaPyEbYWYveNK2GOOSFSZ501GxknA/J/3gIJFy3APaV+HWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LM3s5IaF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761337239; x=1792873239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Oi1xeIbUWJmkdlPTt1/3FDQvDcyhHInFg0Dx23iYTLY=;
  b=LM3s5IaFCPx7NMW3X0nbOWZuMyf/Uoamr9dIcW9GSFGAfcekE9vonZxG
   DcZur1DpzIUlmza/5vRcco/lPKtssaYzcMCnjx5+J/KjdlOmnkcorKww1
   piVZskZCbtIHsQSnqqrTtZSHp1fbhqVB5wheWFOqw0AKLBUgmSiXzMO09
   sg82OvA+z1nqx2IFm77r8F7F6S9SD+k2f8gTcbprngq5YE5A1jYNcOaOH
   9eQu747QVoYWO2lvyCSmLKRUv6FPIL5Bks4nQX+9k8ODytvDSuarX735H
   vlYlqsFPE3NFG2KJoxexJorp2471Ge4+moq3Lb7cPpHxyVWSiCO90dcL1
   A==;
X-CSE-ConnectionGUID: DNW0EKZST+qLyVSZvUyHtg==
X-CSE-MsgGUID: b3JT+dppTH2u6N1dl6RqxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74126767"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="74126767"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:20:39 -0700
X-CSE-ConnectionGUID: gudp0HFuQJiJeQWdMzibMA==
X-CSE-MsgGUID: 3G9vI7weTiGaXe1Kt+CmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="184425470"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:20:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:20:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 13:20:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:20:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFopiLUFGxQqUccvs935iTevVHopm+ABemWB5PA8qtmy/74ThKG+57ksNMCsQzqp32AJcKNZN0ts1xhRsf0as2yjIT7ypxjtTZasoFibLZe5Ythz+WTko4IWV5tgBkAym+lxW7ZiQXAIiEOGQGRyk9rkSq+uj9ZG4ptoqVrph+KMFpsV2oefKOLmXpOO1TGhPuu86fsV0tELfbDqj8VMWI3Nd09+LbScjm1FEu6us+ykKhVdvB5v0sVydWHOqXKVfIVEbRAKhI+kr80VZ0hWdpfj7wnGGSRd0Gg43vHnheUg4Yrvc3RJt8441V+V+GC6K51uQ9VbPa3WPENLWciBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi1xeIbUWJmkdlPTt1/3FDQvDcyhHInFg0Dx23iYTLY=;
 b=ERSq8Qw8XuiFEoLjC58DpJgrhA/wW6DZjwrx0U8Uq4h5INJr6Vn4e/H7zMTRpVt9xy+d+VSJ5XcKyYRP/p3php91iDBwJd/4kyiydAHzOUlHf/wMo2S/6VvdWAU0f6hL3fUe9SmgfcgaLpaIAPdxpb5czeddoNReahuc1bEzSficI2T60jZAEQUWMAvmjFkZ6A7AOFWJOAxcZC+8NYy/5YrTA/RxJzYeTkYYXIwUt1PQ7y8T+HdrZ3bLKRWefqJBK/6nNnELBQDPTKkhBTDGzTTQXJm+qeguLkEwypmz9+Ws7Hvek5W5a/+XxR/wW0qG9aTwgOrVo4sZ6im/DafUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 20:20:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:20:36 +0000
Message-ID: <1349a6d1-f2fb-480f-8879-78ad29dea206@intel.com>
Date: Fri, 24 Oct 2025 13:20:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: I Viswanath <viswanathiyyappan@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <sdf@fomichev.me>,
	<kuniyu@google.com>, <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>, <david.hunter.linux@gmail.com>,
	<khalid@kernel.org>
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
 <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
 <CAPrAcgOimjOR9T5K07qR4A8Caozq5zimD23Nz4G2R9H_agPgWQ@mail.gmail.com>
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
In-Reply-To: <CAPrAcgOimjOR9T5K07qR4A8Caozq5zimD23Nz4G2R9H_agPgWQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------SKfpL8oll1fyrwsh30sQri8r"
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d204d3-9865-44ce-9c1b-08de133aca7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmlaL0I0UEZMWDFQbGRvVVk3M3JUelUzV0psZUVqeGg5MU95OVp1ZUg4aklk?=
 =?utf-8?B?WkJTY1dJaFVneFJ5UVk1RDl6aTl3NVRKMUpWRVVDOGVmOU8vSlhzMzl6RVBk?=
 =?utf-8?B?RklzQTJkQmFCblVUY0tGZW9IK3BTTnFhN1JZcFUzekJFMUVxejlRNDd1SS85?=
 =?utf-8?B?UndqUmJVQm5LNVpUZElWdFZxM3Ntempqdkl1d0QyOWFGNWRObHFyYzk4OUJs?=
 =?utf-8?B?YmV6aGc1bXBqOGVnQ3ZXell2TUJRNnFGV2FKazBmUmJZdHNOTmlObko5bkd1?=
 =?utf-8?B?cFRFVEtwejFTM2VibjRCQm5xa2FXa0V6UjFYcFhHMTErRG5YSXhBc1lpTWlj?=
 =?utf-8?B?Y3FZak1jMHB2cmtML0dzdXQyVlUzVUs5ck8zWXhVMkdCRDRHR2ZFQUNnVTVU?=
 =?utf-8?B?T0t4S0cyNzZnQVhPVzh5WFFoN3pMcFRNbmxtWFB5SFVNTzE0MGJmMUE5c1VS?=
 =?utf-8?B?UHVwenVIa2RaVis4SGVaMXRyaHpIUUFmT2FRbkxESTJDQjZkQ0FjMFhuSzdx?=
 =?utf-8?B?Sy9nNml5d1RkMWpPYWF6eFBUcmNFODlLTjBaMTZlb3pqaHZkZ3dkY0JuYU1K?=
 =?utf-8?B?ZEIwZDYzTkFqdTVzdGVLTXpuMzdNQ0hJOUxGMnA3allQVDhUWTNIdnhjZGdq?=
 =?utf-8?B?MUNQRVlXblVzYTkzZFQ1QnR0c2tKaGtaK2pGVDI5ZkovQXVsa3Y0ZTlaVVBF?=
 =?utf-8?B?dnlnMXhWZ2czTzFSVXZkUDFkVWhGQ1hPNXVUMmpYU2huZ0hGejZDOEc0aHRG?=
 =?utf-8?B?TXpvREN3V1NsWjUzNDJBaUtiUDBiYkxjNXY3SmRnUFhmdWZobW9ubTlTdHZY?=
 =?utf-8?B?YkNYaXhISFV1clVUVXJWcVhoQU9YVWhMUFhENUdZWVJmV2JxdytyT0lhNGhD?=
 =?utf-8?B?RVIxWlVrR2UweU9VNERrb1JRVi8xdTBmdXk2U1lHOGJ4VzRhOEkvckNDWU1O?=
 =?utf-8?B?L3ZwSGxEZ0xWUkEzSUJiYXp1bGtyRHRpWTlZYkFvREUxMHFscm5uUHdyeCtU?=
 =?utf-8?B?eHArQnloNGEycmNZRDJpM2ZEa3hLK3N0bWpLWm55eVNVTUQ4Q003YVVnRmxK?=
 =?utf-8?B?OVNERy91NVdsQTJQL0hac1BHbmNRZi90QkUzL2gwRTltWEFkMGZTQ2EyNU1p?=
 =?utf-8?B?MVg2eFdoeldzMGRRNFNPalpZZVNleWxoOXpiMCtzUHdnaTk3ZG13NkFmRHdx?=
 =?utf-8?B?OGJpV3FwZ3AvS0lNaS9McFlKdWlFRFVHWDk3ZHdLNTdOMmRxV0hvNGJ6TFdr?=
 =?utf-8?B?SklHZjJoL3RiMmdmenlvWi92ZkNyWWZ5M2tYUWJEekx5djNYRVpyZnRpeW1W?=
 =?utf-8?B?Qm8vWUZHaVVGTzFoL1ZrRFVvblNpc0t2MmlPZVB4bFg1Sy9rV2VCWTRsLzgy?=
 =?utf-8?B?NGRrZ05RTHhsZmNMOVkwRlIxUUlmblZyd01yVW1QWkhxWmluWTJncFE4Tzhs?=
 =?utf-8?B?MklRclJ4bjArbW8yTU9kMHJQM2U2WkJWQUJTSm51ekN3WnNIdEpiVDdEcEVH?=
 =?utf-8?B?ZXZ5dW80dzdzc1ZITjFuT2thaTllM3ZFdFpabnZ1TFBlMGRPcm5jT2ppcE8z?=
 =?utf-8?B?RWxzNm1BbyswcXpMQWxCVm5OTmlDdm85WnkxdEpxSEp4ekxHMG0ybXdVRUlN?=
 =?utf-8?B?YTVlSlJybzdTS3A3cWU4aXNZRFdCMWQraEpPWTVLRG50WWdMYkp6VE9IZ2Zw?=
 =?utf-8?B?dk9SSWZYWDR5L09zaWJsOFBabEVKLzZ1MU1EN0N2bFVFQVBYYlg5WCtBbFow?=
 =?utf-8?B?WHUyS3hjUDVoenc3c1pwNGF0TVpKQ1FVamE4TFJlN1ZWWHp6NTRITitGb2s0?=
 =?utf-8?B?R0dkdmN4Y1FIeUxINkM4VW1mWE85V3FqdHExTlZieDJ5TUZSb3JEdG5OTjVh?=
 =?utf-8?B?K2l1ZHR1dWhlRERKK09BK2ZrZyswYW9oam9JSUVMVW5ZbmJNdlVtWXYzM1hz?=
 =?utf-8?Q?G6G0uICeS8cdzNsFn94rL0r9Uux9zOja?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGJrS0hDajllb2I0RG9ZTEhWZTl4T0tWUEtTckdyZEptUFhrc0o5MG5xK3Rr?=
 =?utf-8?B?a0N4TXVFdjdxZUVrdWg4UEJFdlVBOC9rZm1qVXcxZVdtTkRnNjRvU1JaKzVH?=
 =?utf-8?B?N1RQMTJzS1dyOXJoV1Q1SGc1eEJMelZJUHVMd3k1RnJhOUJaQURpV3R6QUpt?=
 =?utf-8?B?R0p1UThVTXVwTTlMWWFPQ1hSOUhVVXpUNmFKL0dxT3o1WkN4aEhOUUhWelVD?=
 =?utf-8?B?eGQ5ZTcyWThYTExsOHJILzhsY3RMQXhkR3Q3QmthVWdBTVJoekM0ZUpyU0JH?=
 =?utf-8?B?UTBZMkk1NHVhMFR2RTZSV3BpcVM5WTNmSlh5STJROUJ5alRtVFJLazFXQmZs?=
 =?utf-8?B?YWpsZy9QVXNlc0tHVzZNVi9TZzlRclBFTTNhdHpkc0pDT1hhZVlZNEJJUWl4?=
 =?utf-8?B?U1hQMVVBTkQvNitjK2sxdktlSjdyWHZJZDUzcGtIY0REcUQ2QXIxblllNklC?=
 =?utf-8?B?RUxyU0JONS9sRlEwcGtLSmpmMlZaYXlOTnZlNlBCWEhGSndyS2hxSG9sZ25U?=
 =?utf-8?B?RnZ6eVc4bWpUL0RtT0FCQzF2MkZ4Q3JpMEdFS1FDdXJtcEVLd3BPTTJKbUJz?=
 =?utf-8?B?cXhhdUp4UUo1b3V2QXRMRk9TN3M2Z3ZLSnFVbEdQRDJvU0NyaFJiNlJkR3A4?=
 =?utf-8?B?cGVneEgvQnNrRnppN1liQUY3ZGdYZlE3bkJZMGx6RDgyUE1aaGh2QWh0RjZn?=
 =?utf-8?B?cUFudjljWTVMYkt5cEJYczh3ZTlHQUdwWHEzd1daOVZyNlloR24xb1gwbmJT?=
 =?utf-8?B?MVZJL0txVkhMTExTQ0pQbkJWOVF1MUVxcGRxSmV0ZlBQeUNCMGVEdDl3SVVM?=
 =?utf-8?B?elBIc1g3Kzd3QjBzK29lNGgvcjM2aFBDNDRaUmNRY3kwbGJPVWNMaFpXZi9w?=
 =?utf-8?B?VlJXNFh1VXg2YmgwK3BmRWplM2JsQU1jKy9zQ0J0UEFGMDQvUUZHUVVGNnVM?=
 =?utf-8?B?cHpXRmRTSHUra3NIY2VTblpIUmpOMXlRbmNRcEZwbHdadVlkVUhLdHc2YVI3?=
 =?utf-8?B?UFlINzlvRjZiZDRBbnpqL051QUtCcXZyeWpIK1NxOERHZ0cwMXdDbld2a2xq?=
 =?utf-8?B?L2FlTG44MWs4ZnZhYUtMTzRmQWZZNS85ZTJ5NG1DZDFJV2NHTjZOY0tDSHJi?=
 =?utf-8?B?cnh0RzRmZGhsczJMeXkyd2hUTlZXQ3NEMUVHcE5IR3JVZUhMMGVUNzZpSTVl?=
 =?utf-8?B?dk1pSG1qcmtJckxFdzE5SjVlRDNYUk1jeXFwSTNmNWphbjJydExQMnpLdklX?=
 =?utf-8?B?YzBDZDhGcVY0Sy81blZwMmNoZ1VNcWpGQzd2akVFcjNPM21OWm9MU2lodFBI?=
 =?utf-8?B?TU94eElTOW5PYVhDVEtJajRMQnprYzMwaHJNUWt6aFMxYmN5NDNFQ2tudC9n?=
 =?utf-8?B?VGd2cDg5YWptMkZ2SGZBMkxsTjMwaGZ3L0trOUlJZVpYWk1LUTdYTi8wUFZC?=
 =?utf-8?B?bUVkSVlOeCtJbWpWVlh0bnhiT2NrV2NvWXNaTURWbVZFVFlRYnVndldjcWMr?=
 =?utf-8?B?TzF0ZERIRmRvUW9lSE8rTDAyN0hCc1U5M1JmUTg0R0huUDViYnBoWHFzM2Rn?=
 =?utf-8?B?Mllmc3QwUmFScFBVQUNYbElaTGJuNG05T1RndGdVc1djaTU3SHlITk1jMmNF?=
 =?utf-8?B?ejlCN0YzMzVnbXVtaEtUeVlNTEdMWXlKSGhUYmRmKzNMc1Jvd3N1VWdhODFp?=
 =?utf-8?B?dlhqblRnbEUxRkxWbG9hMHkxM1hjMG83MnBIMlBheWFmNmJXMHI0cGRCblVN?=
 =?utf-8?B?dXhHV2w4WUVLejg2QXdMYlhIZGp2ZFBTdTkvUHZvcy9QYVh4WWs3azMrdVAy?=
 =?utf-8?B?dU5wbS9ySHdEVzhzckducWJpVFhvWmcvcjZPanQ0UUVFUHJldTJPTlRpK0g1?=
 =?utf-8?B?UlNUK2pYekprNDFaZEZ2VkVUZURBTGFsM2RNV2pvMkJWbHg0amw2U1haM05Q?=
 =?utf-8?B?b1BDUWxlek42Rk5GS0JtT3NYUGM1cEZ5b2x5OVVqeUZmbjRwaU51OXRSSXJx?=
 =?utf-8?B?SEQ1VHpSZEVObUtRM3BIeC9uZ2dEMnFCRE8vdzBiR2dKUitFbjBKSkdLUjE2?=
 =?utf-8?B?U3ErWmtoNmZZblBuL3Bra0dWSGxNK1Z4OFJHNWNaeUpoMFAvQjZ3ak5PbENL?=
 =?utf-8?B?eS9EK2NBRWNCdHRqTFdKNnp4MTJxbWNpL3lRcHVIZGU5eFBDeU9QbFpFTXc3?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d204d3-9865-44ce-9c1b-08de133aca7a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:20:36.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUrxKWk9qxrIULqP6viPejU6E/67LfTtxjSBfPw2ciTpboAmEYvllrQbrlme4fmMaURBQdUFPkTpA7NF3ZTqb6ZtQH8GdF8R5O2yQ2uX9JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com

--------------SKfpL8oll1fyrwsh30sQri8r
Content-Type: multipart/mixed; boundary="------------aQ7Jpie0gZvvsLyT3wfaGML0";
 protected-headers="v1"
Message-ID: <1349a6d1-f2fb-480f-8879-78ad29dea206@intel.com>
Date: Fri, 24 Oct 2025 13:20:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, khalid@kernel.org
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
 <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
 <CAPrAcgOimjOR9T5K07qR4A8Caozq5zimD23Nz4G2R9H_agPgWQ@mail.gmail.com>
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
In-Reply-To: <CAPrAcgOimjOR9T5K07qR4A8Caozq5zimD23Nz4G2R9H_agPgWQ@mail.gmail.com>

--------------aQ7Jpie0gZvvsLyT3wfaGML0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/23/2025 10:31 PM, I Viswanath wrote:
> On Thu, 23 Oct 2025 at 05:16, Jacob Keller <jacob.e.keller@intel.com> w=
rote:
>>
>> Is there any mechanism to make this guarantee either implemented or at=

>> least verified by the core? If not that, what about some sort of way t=
o
>> lint driver code and make sure its correct?
>=20
> From my observations, The sane drivers modify rx_config related
> registers either through the set_rx_mode function or the unlocked
> version (prefixed with __)
> I am not sure how to convert this to a validation of that kind.
>=20

Right.

> Basically the end result should be that warnings are generated when
> those functions are called
> normally but not when they are called through ops->set_rx_mode.
> Coccinelle might be able to do
> something like this.
>=20
> Related to this, I don't think a sed would be sufficient as there
> might be (in theory) cases where
> the function has to do a "synchronous" rx write (flush the work queue)
> for correctness
> but it should be good enough for most cases.
>=20
> I am also not sure what is to be done if the scheduled function just
> never executes.

I'm not sure what the best mechanism is for helping make sure drivers
get it right. I just know that past experience shows that without some
sort of check, we end up burdening reviewers with another thing they
have to double check, and inevitably some drivers will screw it up and
we'll end up with a long tail of fixes.

If we can't come up with something, I don't think it would prevent
moving this forward. I just want to spend a little thought to make sure
nothing obvious was missed.

Thanks,
Jake

--------------aQ7Jpie0gZvvsLyT3wfaGML0--

--------------SKfpL8oll1fyrwsh30sQri8r
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPvfkQUDAAAAAAAKCRBqll0+bw8o6If2
AP4ikeFpA36GTl0PFa2X6K+90/Ir2oQZa5wD2YtaWkQo8wEA6eqrZMMinHRwqIrpcjR8vxRIec/r
QI8tYpK77OnJoAY=
=Dn+R
-----END PGP SIGNATURE-----

--------------SKfpL8oll1fyrwsh30sQri8r--

