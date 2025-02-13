Return-Path: <netdev+bounces-165856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB2A338CD
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B704188C002
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2B20A5DA;
	Thu, 13 Feb 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6UBErL0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FB20A5CE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431626; cv=fail; b=awGrrR9+bOvJ90SHJtSNng1r0kwnXa30jK9bH4VTkDQWC4pRNZoPCVguhCU2q7WPB5A3f1Uxz6XUhTM7/lZYsWqG1xP+z2Kh7Zw2BMh9hZYWA33T58qXJMm5fmVMqGXvtA98ssWmDYtVPZhF9tItxWt/WIuKVMJgJzgRVeuF9yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431626; c=relaxed/simple;
	bh=TEh4LbRu6Nfi4c1e9KiUedfoTBrY9nug87EPAAmsJjM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Doy/01a6A+E3I3quqBG0+cE7Vf36WVrdH3cl58iNBcmP7HtzKWnPOMc1DSmDyRDv5wyRCgsPUIQjItIkADNd+ECbeYWWpOm2froJ6XJZ/+xl+pCa/dYNcqspRHzm/HTCy2v93TWJqpVH+KVqoR3MXV8luDPCcXIeTIE2IePXSm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6UBErL0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739431624; x=1770967624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TEh4LbRu6Nfi4c1e9KiUedfoTBrY9nug87EPAAmsJjM=;
  b=f6UBErL0JdyIYrFQ21+1tojfq2Bup2hPx/oib7hAktu8KbCY68NqJLI1
   dAz0PZXpx5EQd/bdXcjIb0z/EhZeYc4T3nwQbSaCir5RnvlzLRRJ18EwX
   6qGenfcyxJUyZkp89gl2QKD0BJ2oeJo3ZX2KEb2CzqX9xp9+MR+bThRF3
   yl/kU8H3MO1lt1BUUhehR3awVMdalW6QTO+eVA3A5HYN6OIDXFa5mwiq8
   XkcabtdYoKLwthOMv+4tvyOOebVy1KDkvykGYuXFTCo05EE90zkg/Fvez
   3IxmJ1031asQLOUUtRposPj+e2t/K/eAC3IGMoWeNGTuQN7oBqKLNeueM
   w==;
X-CSE-ConnectionGUID: vxOf51zXQaWsVnXZdb7hrQ==
X-CSE-MsgGUID: uPj0+PUwS/OntZoerIfUcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62586672"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="62586672"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:27:03 -0800
X-CSE-ConnectionGUID: UtnRInqDQoe10Z1+MAI3iQ==
X-CSE-MsgGUID: kaI9aXp4QeKR4x0LHLTqGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117172098"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 23:27:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 23:27:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 23:27:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 23:27:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djlqFMj0NfqcFoK3orAE4S2es50QPGK40VFE8dD0Xgs5ymotp6PdNC1Uu08sPIIrrX9OWv/7ov5pWMKdnlnA8ajyZMtCYh2dBp+W2NB3rnjR1mp56LGejqwRN7PDo8cZWp79JwrsRjQIeDauAR5ZGt8D4Jo5fpPNHoz4y+l0ySEh3ZWpK5ousaY5xTLIwR33e1xKHaazf5G4vA9Sl8vGnOmIk1MVFmsZVhZ5tFZJJebivtf+uabfmFgs4RdXw74bxTskx8/raYk+p34Idr34o1oa8w6IOTC2jeaAkHLOUofpAEN2Ag0QcxSXY4tuHC8V/61Be2RETNo6WZGLga9KFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWVPlxv52Kgz7aHau7/5bGwZO0cmKeURuJmoypTQ6hI=;
 b=AseXsMRazKmeQ2SebuT28Y2saFTOLIhHO08m2LRcdijz6sWxwyNWMEpYTLPfPMRkx6vPujAsMtWdXPbEKAJNm4Yt9RuRrOI4qcZVIal5m3pxa4mjwTrwA1JaHP/zsWl5YthIAWzslFiOU4zkgySCgWzNM4E0r4WGZQFqFEG9IULgmGTNFXj1itEtANNGt76AweM21NFqxTd3knePo/vRunkjnBJcTxyvyMvQPuS3MDshVDHmNrwLuuPcDpA5oNW4ddMIYs6XhsOSVHNzFRZdgbCHPsHfGZT87lAf8NA0G+dDBgbdYqIXgADXRz8kwTXOYc5zO/0CG8Vn4JkE0uEGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 07:26:47 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:26:47 +0000
Message-ID: <c074083a-f03e-47a5-9854-dfff0e0db682@intel.com>
Date: Thu, 13 Feb 2025 08:26:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/4] inetpeer: use EXPORT_IPV6_MOD[_GPL]()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, "Neal
 Cardwell" <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<eric.dumazet@gmail.com>
References: <20250212132418.1524422-1-edumazet@google.com>
 <20250212132418.1524422-3-edumazet@google.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250212132418.1524422-3-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c23a4b8-8d68-4c1e-1a1b-08dd4bffc642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEY2L01KN1VvYjhpS1VuSVBleGVycm5hZDAyaWJma0FIT1A3NHoxWDFOdm4v?=
 =?utf-8?B?VTRSWWswY1pPdXJNcWs2MXp5MUJ3WDVxTWpHVDZQQ2phZTNybDZUK0R2L2xt?=
 =?utf-8?B?bVBwSko4ZU9qTEhxend1QWc0UitDeHRoMDNPMTlKcDl3TEZkd2RkaWxIMlhN?=
 =?utf-8?B?ODZ0L094b2RyV0QrckgxZ1VSOVc0YktseGNITis0RXVoVjMxT0p1Y1EzUU13?=
 =?utf-8?B?V0NVTTdPdnNPZ2JuVTJlSkU0ZkNzRTdHSnppdTlFalliV0syWnA0bnFrNW5l?=
 =?utf-8?B?VW9wRDZjY3dOZTM2UFJvMmhnWTNBSnRpQWFYVERVYSt0bFhXcHJQVjJJQlNo?=
 =?utf-8?B?UFAyQkNkcHdQOHgxdEVIWmtKNkZzcnIwM2xRRDRJWEU2NENLbGIzV3BuVGs4?=
 =?utf-8?B?QXpmblppbkJzZmJoakR5NkdTOXdpN0ZkM0ladTZ6VThlTXpIU3JzajYyZ3JX?=
 =?utf-8?B?S0V5YUtZT3dad2dudDhsZ1RDNU11VkdoYytXRVl6MDBTOGViSEZKZUdGT3hv?=
 =?utf-8?B?OW01RzhkRGU4bFVqWG5DU0JPN1N5V1E4RURXMHB5OTZUYmhmRlVBM0poWjk2?=
 =?utf-8?B?YlVoSGxJejNpdG9oMW1KU2MwRnhwU3Z5WTZXMkNrdHpjVURVdEFjaXlKS3NV?=
 =?utf-8?B?RzMwajhYTmdPOWZKaDY1d2V1MVlVeXpkL0U4MTNtd1UwNXQyMWFuek1oYnNR?=
 =?utf-8?B?a2NBZXR2RklxanQ1Z29YTlpzdDh2K2g1OStremo5RVVQWTR2bjlHd1NoTTFq?=
 =?utf-8?B?dWR2MldGNSs4b283dm5jSjJycmdrSVlWOTgya3B4RW1CUmNrLytabVp0cy9Q?=
 =?utf-8?B?WENrTEVBcDEydmk0RGZ3YlBrV1JlS1JUREU1VzlXQjR4SFBSUDhuR0cyVzRP?=
 =?utf-8?B?Z25UV1ZVRmY0UmR0Nk5hcjVocFZyb0VLQzQvWDY4aEp3a2JyY0pjVGxvSkxa?=
 =?utf-8?B?dzhyeTZ4Tkd4ejVKSTJRK0M4cjV2dENpaGFPTDJTd1FwaGgzTVJHWW80Lzhk?=
 =?utf-8?B?NGRvK2wwYjE4eDBrd0RtVVNaV1NwZWRrRktBMUJBL1dJTXZkWGQzU1NzZ1Fj?=
 =?utf-8?B?VHVFODFES1VLaDViYjM0UnZSa09ETlBLQ1g5REQ2RTI0ZXdTa1hJTWI3M1RD?=
 =?utf-8?B?djVWWTEyclZMTEM2NWl4Q09tNTdvdVZRendGakhQRTZIT1lSR1NsQkdOblVt?=
 =?utf-8?B?NWViT1ZCTFZKR2hmaDFGTEE3dFJFeWx0cktLSFlpaGJiUXRsZkJNRjlCZXlv?=
 =?utf-8?B?RERXb0FJWjhNNnRDRFhMQWVBRmZ0bjNSSXNwVEZ1L3N5M3E2NXFQYTJQb2NU?=
 =?utf-8?B?ekFwSDdLMGJ3M21HTjgyWnRPYTJzR3Ird09IdGM4SlZrZ1IzMTRVd1pWZHdF?=
 =?utf-8?B?dkMzOGh6dkhCMlBtQ1Z3VEJKWS8wcXJMeXRIS1hodzgrS3RTcWdZYmY3aUdp?=
 =?utf-8?B?bzBpRndQTGlwdVJ1aDJrOXp2MVB0alNnOFhhN0dpNkswR2R2VVlubm5YSnNU?=
 =?utf-8?B?ZFA2Y0pDZngvU0lOaW9DZHI4aFRkZW1VV2g5ZWxnWGFlL3pwU1htd0tleVZF?=
 =?utf-8?B?bnE2VVZjREQ5d2JCM3c5Zys4SFdBejRPd2UxK1ZVZjZxMzhzelJjY21EM09O?=
 =?utf-8?B?Tnc4czViajZQUk5QWUJWQzRpSi9TOVpra3BMWVRIR0cvNmJhaXNKMDhaZ2tv?=
 =?utf-8?B?eCtacWxnWW1uODIzbkVzOWFNWjc5azdVd2dLMFFvZy9qNERVSFZTb2Z2K0VO?=
 =?utf-8?B?OWFDc21sTkRSR1NxbFJpUVBTVCtscnQ0ZkJ2M0N5Nm5rK2lZeWJObVFEMEIy?=
 =?utf-8?B?RWdkZmdwZHpoazR3RVFMUjd0T01QYW9xYjNEV3pWNXJSek1BWHJBdThDK005?=
 =?utf-8?Q?h0gpmi7ifui2I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JvK1NtaWhWVDBNQ25VMTVPQlNKUk1jQnZwdURMb2VjNTFjejNVOFR1TlB1?=
 =?utf-8?B?K0xrdERZVVk0VnhucUdYdVZHK0dkSkgrNWNwdnJUZjVkWkpjOEpPUmpUTUhn?=
 =?utf-8?B?eVRIR1pFRk9CdEFLbHZoRnQyUkFDTnNzcU9JRlNjSEpwc3FzVUUybTRuMk9V?=
 =?utf-8?B?Rjk4NUNpaVFMdlJSTU1xQTc3OU9ULzRoTmlPeVIrWG9uREllb3p0YTFMTnl1?=
 =?utf-8?B?RVNhQzBzaWxKcU9iazlMYlhhUGdCQSszblplWGNVdmFuVVB3TEUwdyt0MHJo?=
 =?utf-8?B?TXk0VTUxekM5cEljQjRKK3VBTURlQ0NoSTVyQkZMdHNwVnU0cm50ZHl1VFMy?=
 =?utf-8?B?REpoejdJa1Z5cm91YzZ6MmtaNGtWeUd0OURrQzBlWkU2MzRuVHJwOGlnMVdC?=
 =?utf-8?B?TDNMcHZ3TTNvUHp2aHBQL0VUZDB5Nlo1ZUN0QytVS2lQYW1WRmR5ek1ZbEE5?=
 =?utf-8?B?R3prMm5qZG9RRjdHY1JHTWEwcEJhZm8wakNqK0h3elFWNU56OEZjbWg3bUl3?=
 =?utf-8?B?KzBHemlFTEt6QnF1U3hpQzRjUFJFb1hpNEJSOFc4bHNTaWZLMHVrdHRFWElN?=
 =?utf-8?B?ZmQ3b0lzcmNWb08wRzdUdXJCUUFuYURNREhYa1MrbG5UcU0rNUlvaUhhRWNJ?=
 =?utf-8?B?TGt5UC9HcDNLdHdVeTRSRU8vMzZVVStUM1JqaVdpTlVmMHFhUmUwZFV3NkVX?=
 =?utf-8?B?Yk5QM0YrejFNeG03ekkvWWhoRndHNjM2TE5KSXlHOVFSVm9JdEk4UGF2ajZE?=
 =?utf-8?B?aGtidzkzN2RiMklzMjRuRmdwS1lpcTRCR00yb3NtbTZ4OERLaFR1S3ZudnJO?=
 =?utf-8?B?dDNrQlAyakVranZuWFdRSTNKNWVJcE5vMitRcFE0Rzc2Q1JFOW9GcjBZSUJz?=
 =?utf-8?B?TXIxVmhjY1d6ZWJlTzhyTWN0NmxoWnZHdnZ3SVpHTWFvZ21LSDhhN0tQTS9X?=
 =?utf-8?B?VmQwV2taQW9WeC9OVlRHTXBsYTVmcVRzYnVHclBVYU5DUjNPUDJlU2hvczNY?=
 =?utf-8?B?NEp4YWJQK0MwUEFFWjYxTEpyczhyZ3VyMFI4OWoyMk1wQXJST0IrdFM0VnZM?=
 =?utf-8?B?S241MjhxaFZiZW9Ea1ZROW00RTRvNGhRSldpZGZUMjdycUtZUzFzcE5jQTVE?=
 =?utf-8?B?OUtLL1V3Q2wxeEQ3WGZyWHlDczZIQTZJU00raUFOU1BnNWZ1QzRjYWZ6L2px?=
 =?utf-8?B?L0RiSWdKcm5wUkZxZkkwZjJnZHlvc2ZONlNBVGp5TkU4WnBzZWZUenlGNDFr?=
 =?utf-8?B?QjRmeVRkTmxMZ0IzOWRJOXlxZS9qL053dGNaUXg5czBSeWVOTUF2MkJGYTRD?=
 =?utf-8?B?bTYyUlFKVXhBTUpyZ1AwTjdVM2l4dEVQL1BMZlV1QnJOeU12dFZ1M2xPZlVB?=
 =?utf-8?B?dlMzb21WOGkvdUZuQzdVNnUvSHpYc1NmcGlTZ1RUbk1CVzlubGNUZTZmTGxT?=
 =?utf-8?B?K1QwSFYrQkNRUVBYcWthTDRZOEJDcUczN25RLzhWdGNJZVVIcFpVczZyc0o2?=
 =?utf-8?B?dTJGUVNnRDlmQXNFVnI5VjQ5SUxRR2ZLWWd2OW1FWHB3K2dENlVKcm1aQVJl?=
 =?utf-8?B?UzA2RytzQXNpYWZMT09VQk5Ub0Q5dUQ5WGdKN3NydE1KdHZzQ3ZvK0lWaWls?=
 =?utf-8?B?Y0MwNlZla2NXVlVGYlZjMFBMV0JqSGNCanhBQVB3NDQydU43dFd1SlZGU2Q2?=
 =?utf-8?B?QWZGTGhEMzVLR0hrc2Nscnc3MDdRN1dPbnRTM2RTaWkzUVUzMFdWZ1dsSnFE?=
 =?utf-8?B?b3c1WXhHVnFlN3BYYXA4bVdwYndmakdGSWdXSGtsTE54Yktyd1NIelAvUURI?=
 =?utf-8?B?L1RBejMrTEN5bFg4SVVGZmxIZlZhbkpkVDBFQ3VqOXBqR3A4enN0NVI5WnhB?=
 =?utf-8?B?U3pXT1JNRG4wYWg1VHFtZjNid1BBaCtPYzdZR2RzWVliak9KcXprTDR3Vk1m?=
 =?utf-8?B?VmE5cTVEUkdQM3ROZ2FqWWx6TDFhZFdOTjZhTVE2eWtpMlJoanNhNlZwZEgv?=
 =?utf-8?B?b2RVVEdlTW5hSWk0QWdmLzFCMTlTdWxPVzdDSnNRSG1uR29uTmc0MnBNbnFn?=
 =?utf-8?B?c25SQ1hqU2RDY2VsMndGNktjOU5KOTFicGZVN2Z3QVBVd09sR2hVWDZ4cTE0?=
 =?utf-8?B?bUM0ajZzSjZsT21aTjFjMjhHdnk1eVE5OFc2MmFCUDlUMS94ZlRvd21wQVgv?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c23a4b8-8d68-4c1e-1a1b-08dd4bffc642
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:26:47.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8u9YAyZU+9zcrTT2hZdqN8VFku6chwcRfeJ7/IQabXobh+J0V1c1mnxsGARadC6Zv/2mpqG3gVrg9wgIC8WPwSnnSPvcqYfyQIECxMisL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com



On 2/12/2025 2:24 PM, Eric Dumazet wrote:
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that do not need to
> to be exported unless CONFIG_IPV6=m
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/ipv4/inetpeer.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
> index b8b23a77ceb4f0f1a3d3adaacea2a7c59a7da3c9..7b1e0a2d6906673316ec4bef777e359ac175dbf8 100644
> --- a/net/ipv4/inetpeer.c
> +++ b/net/ipv4/inetpeer.c
> @@ -60,7 +60,7 @@ void inet_peer_base_init(struct inet_peer_base *bp)
>   	seqlock_init(&bp->lock);
>   	bp->total = 0;
>   }
> -EXPORT_SYMBOL_GPL(inet_peer_base_init);
> +EXPORT_IPV6_MOD_GPL(inet_peer_base_init);
>   
>   #define PEER_MAX_GC 32
>   
> @@ -218,7 +218,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
>   
>   	return p;
>   }
> -EXPORT_SYMBOL_GPL(inet_getpeer);
> +EXPORT_IPV6_MOD_GPL(inet_getpeer);
>   
>   void inet_putpeer(struct inet_peer *p)
>   {
> @@ -269,7 +269,7 @@ bool inet_peer_xrlim_allow(struct inet_peer *peer, int timeout)
>   		WRITE_ONCE(peer->rate_tokens, token);
>   	return rc;
>   }
> -EXPORT_SYMBOL(inet_peer_xrlim_allow);
> +EXPORT_IPV6_MOD(inet_peer_xrlim_allow);
>   
>   void inetpeer_invalidate_tree(struct inet_peer_base *base)
>   {
> @@ -286,4 +286,4 @@ void inetpeer_invalidate_tree(struct inet_peer_base *base)
>   
>   	base->total = 0;
>   }
> -EXPORT_SYMBOL(inetpeer_invalidate_tree);
> +EXPORT_IPV6_MOD(inetpeer_invalidate_tree);

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


