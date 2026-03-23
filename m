Return-Path: <netdev+bounces-270549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFFRMgpDwWnPRwQAu9opvQ
	(envelope-from <netdev+bounces-270549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:41:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E95B2F3244
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC6030048D2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057B3AA4F5;
	Mon, 23 Mar 2026 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qx5bItmL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDE39D6F8;
	Mon, 23 Mar 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272780; cv=fail; b=n/cHht1Yz50vmf58qb1tDmkxj0EsBWgaKTYDkhtiBU4krlaOavppnTgAyLeLn8BcosPP3DW1wUcq0DJT2iwQt7RoLWx+4AI2vlWD8VmrQDUNeDdRjPHzjYF6Qg/zzgy5W/ed0gcCbVHUL4K/YQ5bjBG2mwWm71BOv1LVXe8qZGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272780; c=relaxed/simple;
	bh=SUPRetTu9nWhqHvzjvlMtVLb+EyBXFMViEkDWXwnO6c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aM2MFyUXh8NyrSCwkypSo2kXn03hxNcszbeySpFMZ+oRu6gTpiymgLMxjYgCqOk/MeIz1GE3JaW/tE+YHekV6izCC2vTwTDWQUr9LwyyslJV/vhnTlbyeJ1OLNsDbi9cTp0dhsweCFB0McCrvYmV6+V0/RqhddMvn0YV4zo/qTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qx5bItmL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774272780; x=1805808780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SUPRetTu9nWhqHvzjvlMtVLb+EyBXFMViEkDWXwnO6c=;
  b=Qx5bItmLEYDZA6/zxCUe8e4rtM+R5L/bba8eKP64gc9WKJzelXo+RnqX
   Fp3GnZnZlH23UxL+WRRfTiWS7U+Egb82fiP3FVYHcvkQyG7ijDu6pgySD
   deHcboL/+nEZZuj0ayOedtWrbClej9waZWSX3jknDgWIAStdMNg57tnzz
   EjZfcGzNU4JYMdk6E5uvTrmLK+gfkrwAeil9hmnG/f43cQO9F8w2elidp
   a8dwCc1osmDxwwZ5IZIQ8I8qMeJaXi9DKx9sUNig7nH/vEfR3m/3PoVBn
   qIZKg4s8bPH+upADtV2bXln2i/UCrXli6xMjgRvRNPH+nyP53AvjwHwgX
   A==;
X-CSE-ConnectionGUID: 1LlklqbXQ0W/AK3PoBM6vA==
X-CSE-MsgGUID: dlhYCqQnQKilnOrGCuSvZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75151255"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75151255"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:32:59 -0700
X-CSE-ConnectionGUID: RLx8AZ4cRE64TPUmycprfg==
X-CSE-MsgGUID: l5d8N8LyTLyAxaY6BW4pUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228102784"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:32:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 06:32:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 06:32:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 06:32:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq//eTrgJG2rlf/IHQXw6s+rzx/3ELaZfB9g9ZT24Iso/XeUPCxnQZjjozXtlOV+f6NlpXop49QlCauwaCUHUGnBDlPfVVUNH83ppovx/EN3n7s7VuDLibn7DT31G1qr1YldxC2d3hQoJVIp5E9hymTVPTsDyVz0EYLaw14fk+Vl/jRk+efVrrk+dkxLCzj2F0ccAWlREnrfRbqapG7xX6jYfk3QsZoBpi0Gdld9sIlh6GMkpz/2D9PUqetTiG3mcsPZ2botwD9s6LdUqHW66Nth66KlL3icKVbj/OSv+1NPhzmgAfo6DNX7K8TKqYKV8XHDa8sVC4w0sNe4njShWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+zoFIq+i2AyY4980t8IlRKX4/8U9BoR8s6l75pKSkE=;
 b=akihzqysA2e+g1PfVtIe+vr4kT/J07/3n6IZbJiDwDGWrctQCYEcYkyNdB/Ig3zMqQDeldkRNXLRByeJHLUcT+hxhxuA3FABHGeuNjXlk+NG5ecqtyJvy7aFjl5rpdr/dFj1mPNnF42ETK6kiU4jrslgGoBC6+03c2jZRPhYlMcCJgrYNK38fFn7MqD0CD8JHbaiBGoBXjNtDuTjp+0v0p+IN2t6p/fNXVFBk6HB+BzrrJwJxbzox6RLIj7GTrLj80R3CH6nqsO451aYLWqGWZLtEEG/fiij+hQCyDnc6+P0dd5PekbFZKCwg2MshQOLtpEcZETN7Rfj1vpOxB6bXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:32:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:32:55 +0000
Message-ID: <42850fe3-b153-4b98-a58e-c5c78eb05f08@intel.com>
Date: Mon, 23 Mar 2026 14:31:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB
 enabled
To: Steve Rutherford <srutherford@google.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, "Anjali
 Singhai" <anjali.singhai@intel.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, Li Li
	<boolli@google.com>, <emil.s.tantilov@intel.com>
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com>
 <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
 <8b43d234-867a-481f-90e6-e155132100a5@intel.com>
 <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
 <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com>
 <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
 <20260312163025.3765321-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260312163025.3765321-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: e51d306a-9178-41de-ea6d-08de88e0b062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: WN4j46+52jHV3zuAElMhPBMLBrsmtGWGFxqV2wuZExeH5NB2prtWhpYkjyQ0eF5EA3FQWqAMPHUYeshNU+cm+zHZcrftgs8SvDkKxueD4QVToxk/Ab95V5/9xFPQtXrhI8l6Xoz9NOYeUs9m6O4w++dgKfeTn8RVI7LTe8cx2yg9sRbPHzO2yaf8ls0XJsujqr6l/QWvnS4YpTwueMYBfhYFdx73oP3z4hseKwTNaDUh+nStHgr8q07EobeaWj8qmPL6Rkfw90Eyt7LdQIPBgH7m/c9QCcqsrVvLl7wQYrWyL9vdGats+A6f899+wWDhSSwCajnqk7Bf8aUFoyrCYCMObo0pcRPMRV7pe5wmo0ukthT4F1ZeiYFYUDJfPWRxN5AKARIJBw+OzyGgUvyt+/Al6h/GMHblT4f1IfqDUab/W7UyQOsmNIac/csDNLz9vjL79N3a42tEmtCDXvM3q7CD5oFdvD0OTEW9D03ixJJleTgV970Jzvwig8wfO6wkw5mXpVZlPYujNBx/FK5TzfgchRe7uwddQKmUch74jGPnPOROjUgK++M3wN7DTdP/J6w/nwKUwMaGcASnJhsckf3rvWDSVe+SiMCTa8zxsMxZ4GNChlWYo4bgkUbRRhqm8rc50KePZvOUXNjjr46nUdQ9+PIMjuBO613riAZwh1XWmYAEwZc7YsfH5ho7saCrjr+B3GMUTZAlHcfh5790X7dbCUj4Mtq3cQIqCPHcqqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(7053199007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdsSmxORDFmRDV3djdHNmtEMG1LdVJFenhkamVwT1lyZkdaSXdnSU1ZRk1P?=
 =?utf-8?B?Z0JCM21jTkdEell3dXVkUUtvS01kUHBZaERIRWt4L0NpQklqdi92Wm1kdFhs?=
 =?utf-8?B?L0tCaHBYNjhUTU9BYmVyaGwwbG56UDVyMWd6MElOay9WTVJ1RHdQRjJyTHU0?=
 =?utf-8?B?aVUrTkpFaFRTZ1ZwbGFDcmpvdlRnWmdZQUVLTVo0SmpYVEhNT1ZsYUplcW1M?=
 =?utf-8?B?SWI0SnkxQTJuQW1yVDFtZnNKNjhJMlVzd293cUF5eXZCbmV0bmNxT0xWV20v?=
 =?utf-8?B?U0ptdWpwdldicUxNSDA0cGNJMXRrREpaaEV1aHVSM1hhN3Jjbys5RWRlRWlP?=
 =?utf-8?B?a0haQUVteW12Ris2b1dhRW1KdDBDYXZjdnBsd0dvNG8yanQ3Nm94SHZELzFm?=
 =?utf-8?B?STlyNHRTalBmSEw0TGtGSXhyL1ZBb2lGMHM5SW5JaUR4bFRwT2JaTTM4aitG?=
 =?utf-8?B?Y1ptaW8vSnQ1WVRmUDVoaEJqVC9wQjF2UEladHFGRXQ3TWN6UVl2VWhpVXVv?=
 =?utf-8?B?ZWN4RXZRbXVNVkk2SUVNNURML0FKU09PMytTSjIyTzdGM1RhZDE4Sy9qd0No?=
 =?utf-8?B?WnBFUkM3R2ovK0R2MkhFdFd3VTVVVW5Oek11ZFJqQ2xDYkZwVzRjRmFoRERs?=
 =?utf-8?B?aERsVzU1aFIrZzVDZXhWc3NzQTdoYnFyQkwxSlhDeitaaEg0UE92cHJxcWhi?=
 =?utf-8?B?RUhQMmRMa0trMWNWTFJuYUNndFNwYW56bmtpMmtlcDNOT3krNVFWcUVnUE1Z?=
 =?utf-8?B?UGhwWDFUSmU3M09QNHd6cHdQSnltdjRMM0dCaGhYbXpLZkFxYmo1bnFZUXl2?=
 =?utf-8?B?KzBhcmlqZjlzd1pGUVZkMnpKTXdLdk9KbnBEUGNqeTBDbFpnLzdVZHZ2Q2VK?=
 =?utf-8?B?RGNveEFEZU5XTVcvRFBaRjNCQVc0ZkMxN2xieSthUXR4cmlreHhlS1d5djRM?=
 =?utf-8?B?dHNIL3h4VzUxS0NjU0xZTTJ0cnVKY0I5TmQ1ZVpxMlI2YnRpL1ozL3ltd25Z?=
 =?utf-8?B?OHhPSCtzSHBmbktBYzZMZy81YVZZRnpMeXZlcGNGU2s2cFBsNERJMkdyNWJP?=
 =?utf-8?B?c1cxRTZJWW9sV3N6ZGd0RnNJWmJLM0tWaG41d0tIekkvTm1zTHlDUHdjQUVI?=
 =?utf-8?B?MlQ1RGNTVEJOejA1RnBYNTFlWXB2VEpQbHNIZS9LeHJQU3FUTWRXTjZ1RzV4?=
 =?utf-8?B?RlB4bzlOUGdiam40S3pwT2habnZ6YlZWZ1lremJSb1pHaW1uNWgySklSMnhM?=
 =?utf-8?B?bnZGOWJUamY1THRseXc5ZUFORUduZnY5Yy9ranVvTTBFRStXU0lzd0k2Uk03?=
 =?utf-8?B?NlBUTHErNkdwekUzYkd0VjdBay9WMExuS1hoUlRybDdoSHNDdHZ3MVNpQkV5?=
 =?utf-8?B?c0Vqa0pucnE5aEs2OThLakMvdmpYMThWaTJxZGlPTktJN0s2OGNVYS9zZDUx?=
 =?utf-8?B?a3Z0aDI5QUxxZVB5b1pKaERpM1NQek1mTDkvL1h1aVAxblFFdGdQbUgwSzF4?=
 =?utf-8?B?Mlc1L2ZKUVM5cFJVTXdNOE1sRTFTVGJnR3M2Ym5BeTE1emdSclkybWxQWnVw?=
 =?utf-8?B?dG1GQThZVWoxcVUwTTcrWlBMbW1SQStXMlFMV2xrY0lNMDliQkJLUUtKL05R?=
 =?utf-8?B?eEFXODVyY3k1R054WG9zSFBTZFY0RE83RUtRNmczZXY5eHFqTFFxT3JXY01Y?=
 =?utf-8?B?bDB0V2g1MnFYMEQyTzc5bjRPTFprellXU2tDUzRpMFdWeXQ3S1NaMFA5cWVZ?=
 =?utf-8?B?WHVaWjRvdEoybThMQ3piZXFNaDJvVk1HdU5ZWUJmRTRtV1lNK2JEeFM4ai9C?=
 =?utf-8?B?Z0JrLzB6aTdJaWlUK1FWM1I0V1dBMTFmZjFEc3FocXJsdmpab0xlT3VHQzVl?=
 =?utf-8?B?YnExalhZMzNELzUyMHBVNUpaZkhTZHlraGFZTDQ3bjBuZmM1RE80aHMzYm94?=
 =?utf-8?B?U2R4OGlFcXdKaEtTK2FUTDh1d29PUjVSNiswUUJWZVN2bmNpVUZ3Q3pWZVAy?=
 =?utf-8?B?ZTYyNStGUUhEczRZck5yUnpOaHVRQk9oanZJZnZJODY3dW0xbCt5NEtZZlhk?=
 =?utf-8?B?ek5MbGV1QzNrdVBOWUMvOGtsYWMvOFAzU2pNQmhoWkgxQ3RPTnlMcTcvWjI2?=
 =?utf-8?B?ZThnT3l5NWl4NzFFWkE1eFZVeU1RVitsSFI3eGFSWXdZMC9LMUNoMWNWaE9j?=
 =?utf-8?B?Kzl1QUZDaHp5My93QTlXbUl2a0RVNlZEMyt1cTllYnI1WkxqenpBTmtCVkZF?=
 =?utf-8?B?SS9OK2FqYU11bmMrZ1poQ3dCbE9GRmlzelc2UVRwekhlUmdOTG9mbGpUMFZP?=
 =?utf-8?B?Q01ic2Jnb0RwbzZwdit6bWFLRmIrVXhaWnhNZ1BGZUhFNHY2ZFNFUFAyeWJt?=
 =?utf-8?Q?ILrTPW9hAnfsDHLw=3D?=
X-Exchange-RoutingPolicyChecked: Fy0uPxi/67sKeRVdfT4yvhxQd02gTRODpU+hwASw7HuG2lfkqfS7GBCkY0unU/v+Qs9QVXU3SdEV1bBeWkyL+w0meboirYF+9irCLPoZ18Gl70Vdwy+tiOygjtmSIPhhGj3fSfmcyA/OuGLxip6kCTJzwL/fBEupm8Ahfa24PqlnRk0GV+q65OEAL1tAIYXxs069/QSrEFZGxyL6IT3YkSbsfWqAe6/DXyKIjSrQZc0cCKjtS33un28x6QMm1aNEHIp/Wq/sn8p2EEjyx+zu7XibnI6zj5I8TgVDkyUrUKMhYJpzZel/CzhJ3j8CroBNWRaW2aPCor8SqXgzWbhhag==
X-MS-Exchange-CrossTenant-Network-Message-Id: e51d306a-9178-41de-ea6d-08de88e0b062
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:32:54.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr27zXE/zcx/ktUUGsbg6nAaD+H6QvZM34IgV7Sa+S8QGC1t753qgDgn76xGwvhCt60+F1gh9mgfgYXybLAF7fUkp/kpJ59WE4u4R3cs740=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2E95B2F3244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 12 Mar 2026 17:30:24 +0100

> Hey,
> 
> From: Steve Rutherford via Intel-wired-lan <intel-wired-lan@osuosl.org>
> Date: Fri, 6 Mar 2026 11:35:27 -0800
> 
>> On Fri, Mar 6, 2026 at 6:52=E2=80=AFAM Alexander Lobakin
>> <aleksander.lobakin@intel.com> wrote:
>>>
>>> From: Steve Rutherford <srutherford@google.com>
>>> Date: Wed, 4 Mar 2026 14:01:46 -0800
>>>
>>>> I believe syncing twice isn't inherently wrong - it's more that you
>>>> can't synthesize the header via the workaround and then sync, since it
>>>> will pull the uninitialized header buffer from the SWIOTLB. Outside of
>>>> SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) they
>>>> are copies from/to the bounce buffers.
>>>
>>> Ah I see.
>>>
>>> What if I add sync_for_device after copying the header? This should
>>> synchronize the bounce buffer with the copied data I guess? A bit of
>>> overhead, but this W/A triggers mostly on stuff like ARP/ICMP, "hotpath"
>>> L4 protos are fortunately not affected.
>>
>> That should work fine as well. I'm not certain I have strong
>> preferences on the right answer here, other than "does it work and,
>> ideally, is it less confusing?" The patch I posted is a bit
>> unintuitive. I think what you are describing might make the workaround
>> self-contained.
> 
> Could you please test this patch with SWIOTLB? If it doesn't fix
> the issue, you can try changing `page_pool_get_dma_dir(hdr_pp)`
> to `DMA_TO_DEVICE` and/or `DMA_BIDIRECTIONAL`.
> Currently, I don't have any machines with SWIOTLB unfortunately =\
> Let me know if any of these works. I'll submit it properly when we
> have a solution.

Any updates? I need your Tested-by in order to send this.

> 
> (the patch applies cleanly to the latest net-next and should apply
>  to a couple older kernel releases as well)
> 
>>
>> thanks,
>> Steve
>>  [And sorry for my gmail-driven top posting crimes D: ]
> 
> Thanks,
> Olek
> ---
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 45ee5b80479a..42111d56d66f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3475,7 +3475,8 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>  			     struct libeth_fqe *buf, u32 data_len)
>  {
>  	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
> -	struct page *hdr_page, *buf_page;
> +	const struct page_pool *hdr_pp;
> +	dma_addr_t hdr_addr;
>  	const void *src;
>  	void *dst;
>  
> @@ -3483,16 +3484,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>  	    !libeth_rx_sync_for_cpu(buf, copy))
>  		return 0;
>  
> -	hdr_page = __netmem_to_page(hdr->netmem);
> -	buf_page = __netmem_to_page(buf->netmem);
> -	dst = page_address(hdr_page) + hdr->offset +
> -		pp_page_to_nmdesc(hdr_page)->pp->p.offset;
> -	src = page_address(buf_page) + buf->offset +
> -		pp_page_to_nmdesc(buf_page)->pp->p.offset;
> +	hdr_pp = __netmem_get_pp(hdr->netmem);
> +	dst = __netmem_address(hdr->netmem) + hdr->offset + hdr_pp->p.offset;
> +	src = __netmem_address(buf->netmem) + buf->offset +
> +	      __netmem_get_pp(buf->netmem)->p.offset;
>  
>  	memcpy(dst, src, LARGEST_ALIGN(copy));
>  	buf->offset += copy;
>  
> +	/* Make sure SWIOTLB is synced */
> +	hdr_addr = page_pool_get_dma_addr_netmem(hdr->netmem);
> +	dma_sync_single_range_for_device(hdr_pp->p.dev, hdr_addr,
> +					 hdr->offset + hdr_pp->p.offset,
> +					 copy, page_pool_get_dma_dir(hdr_pp));
> +
>  	return copy;
>  }

Thanks,
Olek

