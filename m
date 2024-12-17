Return-Path: <netdev+bounces-152652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F599F50B5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68A87A37A1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D11F867A;
	Tue, 17 Dec 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUOddVsb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA001F759C;
	Tue, 17 Dec 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451534; cv=fail; b=G6J8B5ik3ncbOrk8zvXdQZBpl0+w6zA6FgT83jN6NUE95DIecpfU3FU6eEr25enSfX95jbDTMg0GGS8U5S9x7nsWHllTB0AWC9ADXcFixuTRAd7f+EEMZ/0fwZTjUuqeBjClESjv2am1B1wJQMvxf4+t3R+5B/CYOvjBlXK78Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451534; c=relaxed/simple;
	bh=adgRuyGurkN8XC7kVVUGLAsbbVGYfvguXlRuWT21pfI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HazxNu9Cf21XQiEyI7m4XcwPbmMZS67NpKxk39W1lcR+t4zzDSnHqgvaZW6B6lKxigj5TkZHGeoSO7tiNKHMRoQ0RVpbQHeIn2q7dlOUhdV88QOmdmUHsvKpQvKS/xZc2gkb8rxTqPGSNUewnSIXdzECQHUnPHGbP78t1qGmGCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUOddVsb; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734451533; x=1765987533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=adgRuyGurkN8XC7kVVUGLAsbbVGYfvguXlRuWT21pfI=;
  b=PUOddVsbDP/AZZaUFY0YC4vRLGDTmwnPFgJ6oCjZEhHQRHkLtWLDlARo
   9A0b5jq0Ym/l9Wi9wDvCucjlkgoXalAwno9d6g/Nj6A7jtHR9wxx2uKaf
   FOyExqjIiBXbWR/mvHhc8DjQ8FBD9H0GAKBWbAGp/vTN+2crqSDJDjcLG
   7pXB2yxL0lVUcQssB6OBOpsaPFeLr5xoStrNtWJE26+yOxfBuX9ESUyHN
   ZDeHp97oqHWDAqapNgwGbR8xErzMsf5aLpzSEzJGHw0u/rtnqv6SmHyxY
   XrrEy+R/v4OijoBX0f3QU/INZrVbya3V4A5PCwLsRToATRA9l2xcHqkxE
   A==;
X-CSE-ConnectionGUID: J/XEh+0zStSFWFjMULK64Q==
X-CSE-MsgGUID: C1uMjO+fQmyDXwWNfxpuDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34763648"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34763648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 08:05:18 -0800
X-CSE-ConnectionGUID: cvqLm+oSQXmDd7T+9r3kbA==
X-CSE-MsgGUID: 2jetbKyRQbmIrMEhOK/LVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98383745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 08:05:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 08:05:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 08:05:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 08:05:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWyjlMZUs0/99Im7ucVy5dQk+iEt6wHExJ7NEJNjV21Z1yaxJE4JWOi2s3exh/vRCo873PaWUGJ7KGxncYtK3wsvrp+SwHQNnDeOqmNid/NGEDeBQVjy817eEFfZMbkooAzE4vevjFv2J2DboaC0xVFdE9sY1vaeqJWuEIs9vQ/5BgBiI3Od3dNGHoZstU2b+k72yc54ZM8yCbCqhiAvSYk38NThAg9AZDnqLL8JwrfCkERNqItKkqofMjcvpwH7TjvKEscYEgGUvGOxuUUR5TkaoVuWjgFu2QFRxWQs8RsN4Zg1tfRID2JF+orYJ7ePjVpN6tPEyrFVa0riWojFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzdZzE1o2JaYBQbiuyOW0JetBT/Sy+DWUCD6k9JcTV8=;
 b=B60kHBnVSaCP+3GOdGd7SBSwZmjHmHa89Do4J1BKQ1OpislKf+INSAiBS0Rlgua+NNfIi9ES1pP51UcDDyLcG9ttu0PBRJUyFqgu0UTe2AJYBQ32Fg60A+h0Hq/urd6HAOMGthZcgHp2Ej5oZb+HbCN7UyljdULawJa8Q8XRoQxUdm1Pcs80EFWfmqNgptmBRCpLpIEHY+mpsgFEMeLW2AgUYdtoYuA8VkE9wXpSYD89690LtAlfrufWFoeqgr16LtFitPASudJL4sqyVAArqZZnakk9XLs8UqbdW162pGVNInF4rosJMAKCVRwnje/HWCTdchUsoo/jmVmoX+QsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 16:05:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 16:05:10 +0000
Message-ID: <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
Date: Tue, 17 Dec 2024 17:04:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	<cferris@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
 <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9566a3-dfbf-4c19-c3fd-08dd1eb4956a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFhIdWNjSGxQei9UZHZwbDNqMXNMeGNNN2NCY0t3N0dWbGR2TzdRN1VYRW9Y?=
 =?utf-8?B?ZzRma29pd2UrWi81R3dPbE04Wm96YVpnSWhxMlZwa2RNdFhnNktjb1hiZGho?=
 =?utf-8?B?ODV3WGJBQXJHSVhlc0pHSXBlMlhTS0J5TnNUM25rd1NGNGV1cXA3eE5mTmlp?=
 =?utf-8?B?OThCRDJneFhISGJxVUdVYTZaSG0rV2YwS2I3M1RZNDlOcE1BOFpUd1ZOL2RU?=
 =?utf-8?B?TFl2TzZkS2puWmVreUtJakpydDJFek9lMUV2MTV2QmQ3dHZjaFNMNk1MSXVN?=
 =?utf-8?B?cUl4S1VvdXZSRlNlR00wTHBjTFpOWHNlLzMxck9WWVpvNUhjWUR0dXlVNlVO?=
 =?utf-8?B?dlFJbzhiL1BmanVhRUxGM3V3SFlyWjVpTGxsTXRWNXlRZTliYXlhR3FpRkJV?=
 =?utf-8?B?aVhKZDNueExWd2VxN1dPYUVqT0x6cXhscjFyYjlxWlpBNzBqN21YU1V0SXJM?=
 =?utf-8?B?cE1LMmZhWlkyZXJ5UGFBVkhrbmNnUjFlL24ycGRFaHY3MlUzQXV6L0JoMmdP?=
 =?utf-8?B?OURTZHdOSFlCRHhZZ0ZzMnNxLzgxT2w2cXBpd1hSOW5jdStlbXI4Ym0xeXJ5?=
 =?utf-8?B?dXYwVEdZVUtxVVJLaWsvSzgxZGl0a1pFU00rSFRVMUpjelFoVTc1U3EveDVY?=
 =?utf-8?B?SFBKVFFOOVk3SU1aeDBkWFVuNU5hYks5bktibWNCS09TZjl2SENvUVBJY0Vk?=
 =?utf-8?B?bFgzbEY2Y0VtK1Btalk2QTVLcTVja3dncHhJZnZEa2FNTWV4QWRXSWN0dzFx?=
 =?utf-8?B?clBwdSszMU9RSnlPNGJIV3VEcG1XRGtvUkgwOEhLUFpLTk1NbzhrbnNxWXN4?=
 =?utf-8?B?UjdXV0pqaHpRaTZyZW1yeHg0aGpuYmhVMXpkOWFZd2tWeDBnQmpXd0M5SW50?=
 =?utf-8?B?S25ydmV0WUpwb3NpOEVHanF4OHJFS3FpOUQrQ21nMWg5R2xtK25hVlFjbXRR?=
 =?utf-8?B?TjAzaTRtY0pUdk82U3lkT0xqTTZ5TlQ5RWlkYUJpMjRwNTB0bjlUbW13SWtx?=
 =?utf-8?B?RDlrUTBLK1ovb0hzcjVNS0RTQ0hBb2U0N2RKTDJ3YUZvTXJoOHJwZzVUUU9p?=
 =?utf-8?B?WTRqTGVJd1d5d1d4a0lqbWtBdHp0MDZVUG8yWmRCa282ckFyUmZwNG1NYWE0?=
 =?utf-8?B?S3E2OHhIT21hUTh1QjlLWnZZZk5rT1hQV21tUFhiZ3BMbG9Jamg2V1NCTW1K?=
 =?utf-8?B?NTJpbnpIMkU0TDRLM1U0QnV5a0w0TjV0SDBGSkxGWnF1VlBiQzRqUy9rbUxD?=
 =?utf-8?B?d0w4YnZPU3JOSlBRbzNFUGRHMUhrOHk1YTdKNUtjSUhkazlIU3dUeXlxcFlM?=
 =?utf-8?B?R052allUME1DaUcxcXRFQTdnZ2tEUXhVZS9QZmZkV2JXSUh4NTg0ZU5QNEk5?=
 =?utf-8?B?eEtya0gzQ2l2Ky94N2c3SUFZNUk2MlJ1Z2xxNHZmSlByQ2twMDNEemZXcXNF?=
 =?utf-8?B?bCtONFl4K0tQbGM1NkdxWWxLUzZFazEzRHgzL0UyQXBZckVpREVFNUJhZGR1?=
 =?utf-8?B?d3BGd3dQSEswcmxkRW10S3ZJRVB3cjJVaXJCSXdGQ2NIM0lGVDVhTWt2VEVF?=
 =?utf-8?B?NmNuNGkxQStybGdNNlRoYUo2VWNJck5tSTRVUmgwOCtjSnk4SjE3OW1reFl3?=
 =?utf-8?B?MVVOdnRJVmEvRlRXY0JoVmx6MllDaDZOeE42LzkyVjE2MGo2QzFtVElXMHlh?=
 =?utf-8?B?WHhyWjRYb2FnMWgyWTZWQ3pmczBKVG5lOVpUK2M4Z2xFT0owVE1tVEk5d0Z0?=
 =?utf-8?B?N20zMjQraUxhaFVTMFVObFVVSnIzekduekFnRXhzU2tHTFA2M09BYk5CVlBx?=
 =?utf-8?B?akVDSFk3dlV5dWFxOXFmaEViYS9wamw2bVR0bm95UDV6NFB2UlYzSDJxNmpN?=
 =?utf-8?Q?7Pyugr4dWa5+O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdXYlZRSXNYYzJYWFRrMDNGYXA1OUpaK20xbFJnMzJTNUxHelFRaWJBdEwz?=
 =?utf-8?B?M0gxLzNEYjF3eWVsRjhZbjErUG5IbTFqTFB5K2VESVVYallVQjdmblgzbEt2?=
 =?utf-8?B?V1VteFBxMm1pMFV5eU9NT0lYclUrdE9NY0orT3c5L2FNVWhsNWYxeXRpYi9D?=
 =?utf-8?B?cGh5ZEtDWGVJNnoreWtvaGpQSmtwUFJURzA2YXVYVnpjSlR1S3h1czBqcCsw?=
 =?utf-8?B?U095QUVyM2ViYk5RNzduTENmeTJBd1VkaFVQM3ZKVFFObW1mVkZQZlF3RkRH?=
 =?utf-8?B?YWFnN1BETUx2RndJZ09EYVJHTmtDQ2hwcUN0Sy92akRkZXdTUE94MnVCNEFU?=
 =?utf-8?B?anNaMTJ0ZFMxUS93NmRQM3VBNGx3V1JRZlB3QzNCcjVZQXJSMHZUT3FwZlNG?=
 =?utf-8?B?ZnlNNWhHaTFjLytQS2pQOFBVMENsUHFxdk51dlM2a1FsUU1ZRWRKdUFNUWI3?=
 =?utf-8?B?Y0ZuSWRJRUJnUkZaQ0lpNlR3eEZUVk1pdDlUTzdoTis4SUNCNGJXemJEUmNT?=
 =?utf-8?B?Y3MxWFVFZUdWaWFqSHV0ZlhweEVqazIvRzA4a2FJSndFc0NZSXJmbG9yNXNW?=
 =?utf-8?B?UUlRWnFKZ1VnalJxdmx2eWI2TUJWSzAwMEEyWkNNVnN4WnBuQWpZV0U2d1Ax?=
 =?utf-8?B?WUtYbll2TkNHVVVZRUg3L2ZZV25VaHFzR2l2aC9UM01wMzF1SG03ZGx1ekxE?=
 =?utf-8?B?RnkzeVlJV0J0U1NDNkwrbWtJeTFqYS8ydm1FeTd0UU84OUxJTnpYQ1EvVDYz?=
 =?utf-8?B?bzhVUm5qV2N3cHBidTEyYldNbVB0aFQvZERYOHZVOGlpSTFJYnVQVW81T2hn?=
 =?utf-8?B?eTVub1BvMmYweHFEQzZndmNCdTNNaVE1Tmprb3c1SkZLQTNIT2RWVFBuMTF4?=
 =?utf-8?B?K0diU0p5MVZIUHJyNGlzVFI3ajNRRUNBa3ZpK3Nsc3lBeGpwZHdzMTF5aGlO?=
 =?utf-8?B?RW5NRzlsTVgvWGhOZUVzWGZWMUhBSDF0NEMyU0ZITHVBZ1FkVzRtMG1vT01U?=
 =?utf-8?B?ZmRidjZTM1F2WVJOeXZPZ0ZOaXJIMGx0d2FCVXNZQnJIbm02T3dkZlRPMisx?=
 =?utf-8?B?a1pUb1NmM3I5ZzVRWktsb3cxQkZtcENzakhDUitJYW45MnFla3hPMmMyN0tG?=
 =?utf-8?B?RGlwZ3Rlb1FSUVpBYTNKT3g4ZjEwQk1Od211R2swdEhNLy9NTGlTSGtDcytB?=
 =?utf-8?B?SHNydHJocHc0Nk1kUmUvK0R2RElSaXBiV2Y5TzhqY3ZCQ3VqeVNwZ3NHTkRC?=
 =?utf-8?B?bUE2eGJsVXJRd1lJQk16ZFZFeng2YXRCU241MUVVWC83ZmdZWWFRRkN3a0Ix?=
 =?utf-8?B?aHkzVXpNU3c4VU90NDl2ZFFiOTlwbjZRenEvbllaNFBOMW9rUXhONFdCMlhk?=
 =?utf-8?B?OHNWOVg1eFVSSzN0MEMycGVQWTYzc1pFYzhoWUZ2SjVwa0dXcGlveFkrM3U5?=
 =?utf-8?B?bjV1dENQaW0ySldVdkI4Y0NJRytaa1cvMlJaaUZVdjFUTGg2a25MZ0NCTXBr?=
 =?utf-8?B?M2JLOWU1SlNtQmZQMktOQUh0elRiMUl3dEhvbzZodklsK3gxTXd5cHltOC91?=
 =?utf-8?B?Qk9abStyT3NxNlBDMG81QlZBcVVuRlVWSDAxbVVaUWs4ell2bmVJMWdFd3F1?=
 =?utf-8?B?d0liNzB4dlVhcSt0WVNCZlQ0djVodktGeUdJSUIyUlBjajJ4d1I1eFlRY3Ny?=
 =?utf-8?B?R3loQzh4YXk4cG1IQkpxdERlSDNselozd3ZCUkE2RTkrM3lpMENYUjZiaWw2?=
 =?utf-8?B?K0ZBMTQ5bjRwMnNDQU1lNFdrOWNDcGtidU90NS95ZjQwcTVNT3NLbmZmNTM5?=
 =?utf-8?B?aXg2UTZEcHlGcDBtNnBMaDNyMnU5M29sZVJidk9rQTJFMEVZL0NhRzlUViti?=
 =?utf-8?B?cHczWktob05aOFprUkdsNWs1dzdBcDhSRXhxdDJXMTJuM3RsanZKV1VOb2Jp?=
 =?utf-8?B?RktvLzljcXZZWXp6SDFmbDdTcy9FYnR0WUhzZHBKcXZPUzV2UEdJNld4dU5J?=
 =?utf-8?B?aUNvQTlmVzJ0djZpM21iSDhrSkhIbDFKSWZUWVd0N2x2MzZZSkl4OW1IdDVM?=
 =?utf-8?B?ZDBuNzNjZkFSNUhnbnV3OEF4RE5Jb3B5Wjc2TVVuUDlURmN4UzM3QTRwT0pR?=
 =?utf-8?B?SVY5cEJMR1V1Qnp2c0YxV3hzWnhxanQvTVhzYzdpM09LTjg3bFk0NkhzRFRq?=
 =?utf-8?Q?zTXSjoAHFTAqHr+5Ej4DAH8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9566a3-dfbf-4c19-c3fd-08dd1eb4956a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:05:10.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udkkEYUFsO1NdoMWIh3w+vZhf77PZYgl//HtqZtxMQn2FYfm91SmHbBl8gvV6bAeNHzQgnTnVtaW3SGbNO13toFCOqjMrUYZqHR0sGvXC0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com

From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 17 Dec 2024 09:58:28 -0600

> 
> 
> On 17/12/24 08:55, Alexander Lobakin wrote:
>> From: Kees Cook <kees@kernel.org>
>> Date: Mon, 16 Dec 2024 18:59:55 -0800
>>
>>> This switches to using a manually constructed form of struct tagging
>>> to avoid issues with C++ being unable to parse tagged structs within
>>> anonymous unions, even under 'extern "C"':
>>>
>>>    ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct
>>> tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous
>>> union may only have public non-static data members [-fpermissive]
>>
>> I worked around that like this in the past: [0]
>> As I'm not sure it would be fine to fix every such occurrence manually
>> by open-coding.
>> What do you think?
> 
> The thing is that, in this particular case, we need a struct tag to change
> the type of an object in another struct. See:

But the fix I mentioned still allows you to specify a tag in C code...
cxgb4 is for sure not C++.

> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
> index 9050568a034c..64663112cad8 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
> @@ -242,7 +242,7 @@ struct cxgb4_next_header {
>       * field's value to jump to next header such as IHL field
>       * in IPv4 header.
>       */
> -    struct tc_u32_sel sel;
> +    struct tc_u32_sel_hdr sel;
>      struct tc_u32_key key;
>      /* location of jump to make */
>      const struct cxgb4_match_field *jump;;
> 
> You can also take a look at the original series:
> 
> https://lore.kernel.org/linux-hardening/
> cover.1723586870.git.gustavoars@kernel.org/
> 
> Thanks
> -- 
> Gustavo

Thanks,
Olek

