Return-Path: <netdev+bounces-292319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LOjI3D9FmoJ0QcAu9opvQ
	(envelope-from <netdev+bounces-292319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBFC5E5C35
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1E33008D23
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E099E31E838;
	Wed, 27 May 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPuHRyV9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F731B830
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891184; cv=fail; b=I4cP5JISIcq47bT9ikHTfoe5/QHewGHRTTS7FQDu6dhOk5l/FPFpeGqu7xpFIu1KPi9nHwBsJIKoESl2EzW5HEK16xq7VA2rRZelZRcE2Sp/WiPvL1m/UWPnB7V2CX1XYBX9j4UNPXyC2uEPGMDdt4YPm5hbppBdqGkw8CMmVZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891184; c=relaxed/simple;
	bh=Jm+QY7f55WE2JHHD8Og/49wUZ+DL3NXDgzdymLMMKvU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHR7Pv6m8ziTuALGxK55wuDmqw1jtOTcwB/fNNyDYWnrcUa3Q5A8tVdSpA8QWZJaAApC3I3gFtOQPpX7MjWSo+yYi0VV2l7KoiqcEd6ambBxQjl8REHTAvM3jcLHSv6QvD9z3m3pJPyEalR6F3bWKEfC8J31WhKt9SsVFC8fS+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPuHRyV9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779891182; x=1811427182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jm+QY7f55WE2JHHD8Og/49wUZ+DL3NXDgzdymLMMKvU=;
  b=MPuHRyV9dzibEWOhxXwEL3NpFkG8l5CBQd0q32tVFfUzreW/khHy+ccI
   zDGVZhV0DVnL7apGxrWRFThzNcypU2M5MlJE9Dj2/cjZBjzFLiJhQRt06
   0ZeEEGACHXEnWh6Tq+9uj8a/8rhE9lOPk9wBXXKB2vBKPmqRKDjqrAX7B
   eGXCbMH8B9lDUTwLNMjzC3fxZnk8H7BmGCVyjeBUM309XTqitzND8Gq9Y
   d2KLPzQ5V9ptDLwhjbQ7AHil8sH0aR+BSGYEsV+y/Ypl1QP1+LIwvaeYP
   i+rOXG4hidBJepuGq455efkV45D7wB5ZR+/Srww5v0zjf/o5yIbX8h9Rn
   g==;
X-CSE-ConnectionGUID: 2PazmA1pTiyi1HLp+l2gcg==
X-CSE-MsgGUID: zk2g0nOfQkyceFqFGtx7xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103395624"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="103395624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:13:01 -0700
X-CSE-ConnectionGUID: vzOIZhQTTnioogRfIL8nIg==
X-CSE-MsgGUID: u6x2GJCaSIGBPqcUCIZL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="246280099"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:13:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 07:12:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 07:12:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 07:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBYLj2/487QtSdNvbQduKH2twMjQM9cZ/4gLi4q9C9fw0p5F6o4h0nE+pS4sm9i9ub9qeoqtdmCJQPuVgvTtU96hLeuBnhTQF6iZ7VRXYfBcvBvqgjpC7FRh4DHc0QSidFHH4vR+hBjL03dqpce2Peo9EjdcNnkE6pmI2vFrcmUj+pWuzxAaOxQbnEfAL2NjkZCyKoZUBFzpmh3tENO3c9Lgqwn4nmbzejg36HhLrREHUOR7lIhKAiUZrOIeXXhWvcAGmM/wibUwwiSX7uXdW58DVoZVMZnlsl90Nwvqq9gb0SGN7Q2xxOIDNm1sPeQ6x8N45N3sdysAoU5m7PltGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MtzeVQiG96x03Ta7Oa/mWcAqGRj2qovx/I8haJMDKk=;
 b=fYgrwnqGUrD8Q/gfuOgLyv8w1vYrukEMGMnGPREd+vFKkqycXYteZjkUtXAAGcaJSDzrp7+wiw5keS8lmuX5mftepi0G9tAg4Vi3/xZGjW0iFNcPNr9zUqZOjdiecO5xdL0tAH94n+R9LYIwI6Yib5FJLoX25pCiV9bDZy54Jowys/eRVMm3p9VijhXVhpQDMBrD07uqURY8AwZp0cXDeNgGsLMH2pSaUpYDi4OWZ+OVz8G1gXhLDgQ9hoWLNTJqhIxf/Vk2DquKGH8yiXSPGT0B1wR2rsZj3I/0JJXjU/GqL3bSAjpjfqfPqBO7rLReig6Dx+CfAe0P0fx78fw2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 14:12:53 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 14:12:53 +0000
Message-ID: <ddeb02d4-27f4-4c81-85b5-928f2b5cc95e@intel.com>
Date: Wed, 27 May 2026 16:12:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2] net: airoha: Add TCP LRO support
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260526-airoha-eth-lro-v2-1-24e2a9e7a397@kernel.org>
 <7473204e-2ccd-44d8-b703-5a5dbcb29b61@intel.com> <ahYLvlIYH60cvkWB@lore-desk>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ahYLvlIYH60cvkWB@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:803:50::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cefa8f-fc05-4e4b-db1b-08debbfa0acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: gI+gXpnCZnMidlNaZdiCvh+WQyQihSxLoxfKB3Y93KHak0FqEazw55BWB1KC8UWk0ZamJE2XS3zgc/GUhaT9vrS3OSiC6PqqNtdWFesz0wB7ze2Ed1iOXZBegiR26CG4sTEkJg5H+hMnRfrLR3w3GRp0rpCzCy1nr5KVgYmKd6xabQqdzcrYgXiIt4+QOVomSWYTxh+hVQIHNczm2yhlhoyzq9aGeZ4WB1KWSGLggqAHnCuDmmJb4bbVTDv5kA+mMGIMXTWPBS1Ed+YJtvbAj1zkM+tPgGONB7yCDCmxtuylDJ/EFFoG6161dFEu0MvrcnQhxf2MC4qux7X8VaPQiixvleuEjKLEN/6zRR8Q0DEi2BwpM91JHwVV/oALc9MHUm+owXkyPftyPs9gGjMZrGmqw3izre5hh5wjyeGWufkEolH1zwT+2QJtTkhpoXXdpz+3jAMX3vkHDrj7R+B6HgvC1Q21/s89dDIs25iQ1XfFEZJj0IGDqurG7Fi4DgCcN+mXfUHl4mg9j2ofMCo0fXb1hbuPeQTxNRNac4M0//C+ULtqZ/Bxsd443/EwuiCGxgF7BYt0Hgo5ghV22m9mTZgMqC+R1kzCRfKGvlKbfz/RiGCYX1BEPsA+1vkWO9FXO1kYrRAUi9q2kBUstdLDtGzm32cisIVZOr4EZNJ5kpgYeDzI8vvI2j3mwhbQmSWcmF//YZM4VSzoh0+//QmSaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjgwOU1zSW56SldwbE81dTZrL2JianB4UzdaYmlzMXhnVS9YRkZDUGs5UlVV?=
 =?utf-8?B?QjlFcWNueSsrZ3JzbC9RRk9LT1RRTHA2NjdnOS9mZUFDckFHVEEzcmp6YjU0?=
 =?utf-8?B?M1g0aUYvbTJ0b1pvMFdsdzNiYTJHME5SditnUFVNTjU2cnpYQzJ3MWtkVTdh?=
 =?utf-8?B?VjV1V0grZ0FWazlkOVpzekEzK2NmbmgvazR0dy9tRlNFSG9qY1BwcUVuankz?=
 =?utf-8?B?dUVMaUl0ZDJYczVEUFFpY2h1Zk9sV3RkUXJrOENNRHZ6eXFVQ29uOWFTYVRB?=
 =?utf-8?B?cmY4RmxGQzhnN1lTYVlvdUtPZ1hPamk0LzVhM21QTHY0ZVFTUUtrWDgrZll4?=
 =?utf-8?B?SktTL0V5V3NNeDZVQVR3YklWNk5EQzdNc3I3dUhISHdWZHlEVkFRS0VvdTY4?=
 =?utf-8?B?NXJuSi9FWjJTRlBNbGZBWlMzaThzaGszY0ZPMCtreEJHcTgxekZnd1ZzTU5y?=
 =?utf-8?B?V3Q2Q3VsTnBYSEpBcEFjS2dRN0JpZUpxeEd3SlB1cUdKNlZxdndsaWhNRm1j?=
 =?utf-8?B?dDdZVXg3N3kwS3BBZHFkZnJVemc5bDNUcEVUTXJCaC84eEZSdkZVYmlYMXpi?=
 =?utf-8?B?bHc5RitHYWpmb1BrcFlmSnQrY01xL09lWHZxczY3dUI4enFKdm92ODJQdWd6?=
 =?utf-8?B?OGYrdS9nSDZrNmV4M0NheHZsZmNxb09pWXh1NlArdnVCMXFoTnVwbGd4NUdz?=
 =?utf-8?B?S3FXMDdSL254QXk2VE1OVTNsWnR6ZUk4YmJJc2VodW12Lyt6Nm1jaUhFcnBv?=
 =?utf-8?B?RmoxVzVzd2tscFdNZzBtWS8yT2dJdzhlRjNjZzVaMnk5L3p1WUxPeXdxejI0?=
 =?utf-8?B?NXZUOEM0QlpLR1U1eEs1UWM4NUhaSHhNR21hUjl4eTdVWGt4RDF2eFhxSTJ0?=
 =?utf-8?B?RXlWcXRtSzFRUHpGUkxiOXpoczg3VmRDQlluajIyS1hpbHVVcFhqenA0bFFV?=
 =?utf-8?B?aGU1d1JnMkFVQ25pUFRMaFNtUjAyeElQYzYyejlxcjZ5ZUgzUm1CaVVnQ3JI?=
 =?utf-8?B?RzNOUzNqQU5CajFtVm1JTjRjbnZPVFhiNkpPTnF3ZFZROXhQSEt6SjVWNFVP?=
 =?utf-8?B?WEdJbC95TjNvd0RLMWdPNFI5YWxybTZqTWtQd2tyOFQ0M3paT3BncTAxRkxY?=
 =?utf-8?B?WGo5OEhPcWVnWXc0VURyQUowZEhsaTlZTEdQTzZVREtxQXhRbTBVZktsSzh6?=
 =?utf-8?B?Y2xSSmM3NGVtcVBKOUNveXZkVHVMTSs4R2NyTmFOMnA1RUJpbDBtZ1BqL0lm?=
 =?utf-8?B?MEpBMlY2NXRtdWlPTXo1c2M0dGFkV1NPMGxqdTNBRWlDZXUyQllWb1F5MEwy?=
 =?utf-8?B?d0pMb3VVRVplWGJOOFBMcS91cC9uV1MzbndQSFhmWHdzRlV1dmc4bWxTdEdn?=
 =?utf-8?B?UVptYXJOdENUTkYvY0dCOU1LWmlkUHVLS0V2ZGV5QmR1Z0wra0I1UElNSm05?=
 =?utf-8?B?WnQwMnUrdVpaNldZUHp6S2xSamp1dmx4NnRucmpYL01UcDBySXg3M2VIdHpw?=
 =?utf-8?B?WENVVlRoSkZxSHdTOVVsWXU0bnlNUHBIMGdDdDIxV0tSNmhyN0M3U2kvUWFH?=
 =?utf-8?B?TWFDcVFVYWRrTVRZWFNmSTl0NnpuK0tyUnNxZWhPM2d2dnBtTHhOZFlVeE1s?=
 =?utf-8?B?OVRpS1BhNjJKVGNjRGFWaEFTRFhKKzIzMlp4RUFoUUZGbGZWVmlCMHRoak5M?=
 =?utf-8?B?THdjTTBRTWVOYVFOTDRrMElpcXVGQnVwck43MWg4WTg1L3FHbXZUeWd5cExj?=
 =?utf-8?B?TGE2NUdnblFWWVE0enF6eVh5ZnpWekdESWxrcDA4cVA0L21iMkFDSkNhSE81?=
 =?utf-8?B?L3hUM1k5RmhGVW1iM1FmYS9qdGgyWC9RVU5peVg3WmtZVnljNzA0RTYzRFU2?=
 =?utf-8?B?THptc2U1NEdRWWJxblJrSm4wUFYwa3Q5dUFMQXRXcUNUTEVXT0g0WXVLamRw?=
 =?utf-8?B?bzA0Um1GbDkrZjZPYVU0T1FoT0hQMi9IT2tiRGVFa3dPVVc4aFFaUlR1c3NG?=
 =?utf-8?B?NG5pdlp1cXc3cWNST0UyenFoMFFHbVY1SDRIamJQWkp5ZHhZK3hxL1UydjFU?=
 =?utf-8?B?a0FkUm9RREhjTk1tYzdTK2kwYUlDUk8yWUxKdG1TVXpvaEthcWpSU0pVamZy?=
 =?utf-8?B?K245S1FZdTFmd1YwM29odFlOOXJQdFVCbHlRcTJMeVhUTitHaVI3d29icS8w?=
 =?utf-8?B?YjluT3NYaGFCRW9kRXhWRFVwZCtkcVZyUzlWd25XQWEvVkMrSmZMaEJENjBD?=
 =?utf-8?B?cWNkVzVKSEFiWDZPVHRXRnFpcnd2QzMvTVlraUFIaVZ2Y3RVYjlTM3RlbnZr?=
 =?utf-8?B?OERIZ0YzK3g3SVdNTDFaK3hScm1URlptd3hveVBQVGNQR1FJUHpHMVNrUkFw?=
 =?utf-8?Q?hhp/r+BI+seaUeCE=3D?=
X-Exchange-RoutingPolicyChecked: FkH2c90xqT5JmdJmkk1cxIFmz+2ZRMQQnBfFPmxmyh3YxcYI7riNnyEcq8tjSTet8VfveYDh656b7xV2p5QxQGsv8zYKkFa8bpRX6vYJcAXZ2OokHrJFaTBWDhOr9omPtq3ybPvz+quHUkoc1jiCcjsY/QGARLhwKmTPpNazJFcCCKTyaXeY+ALqWkf7NPInmSVOy3BoxMqJ0PI50HkykhBi1J99L6nHAjB1IGvCdf1WC6/3Rf6PjQvcchjS0LXqmsBdTz2dcPBvskXpnkw3icF7Oo6FqFBdDHKPx7+oRz89lIbxLsfKWT+snSo7qYqqvdTOdi0icPvJpzwjJyFCNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cefa8f-fc05-4e4b-db1b-08debbfa0acf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:12:53.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaDpmulW/349Ex+mSRIwVQmlfR2XluqkJ7ro1598IzXd9z+DbG1/erD/vseae5OhKRbJmTXdcUPFK4qqfvG/mSvzoZ1KIGkAAhfsRtxvKh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292319-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DDBFC5E5C35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 26 May 2026 23:08:14 +0200

>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>> Date: Tue, 26 May 2026 08:58:05 +0200

[...]

>>> @@ -587,6 +630,85 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
>>>  	return port >= ARRAY_SIZE(eth->ports) ? -EINVAL : port;
>>>  }
>>>  
>>> +static int airoha_qdma_lro_rx_process(struct airoha_queue *q,
>>> +				      struct airoha_qdma_desc *desc)
>>> +{
>>> +	u32 desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
>>> +	u32 msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
>>> +	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
>>> +	u32 msg3 = le32_to_cpu(READ_ONCE(desc->msg3));
>>
>> Why are these READ_ONCE()s needed? Does desc come from the HW (sorry I
>> didn't follow the whole code flow) or...?
> 
> Correct, ctrl, msg1, msg2 and msg3 are subfields of the DMA descriptor read by
> airoha_qdma_rx_process() from the NIC. I guess here we have a similar issue as
> the one fixed in [0]
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=4ae0604a0673e11e2075b178387151fcad5111b5

Hmm, I never believed that we need READ_ONCE()s when reading HW
descriptors, I always thought dma_alloc_coherent() is enough.
But maybe I've been mistaking...

[...]
>>> +
>>> +		if (*topt == cpu_to_be32((TCPOPT_NOP << 24) |
>>
>> Shouldn't this be `((u32)TCPOPT_NOP) << 24` to avoid sign issues?
> 
> I guess this is same approach used in [1]. Am I missing something?
> 
> [1] https://github.com/torvalds/linux/blob/master/net/ipv4/tcp_ipv4.c#L823

Yeah I also notice this in one more patch when scrolling netdev
yesterday. I guess it's okay here since TCPOPT_NOP is small and
constant and doesn't reach bit 31.

> 
> Regards,
> Lorenzo

Thanks,
Olek

