Return-Path: <netdev+bounces-217878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E1B3A43F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9E71B26D1E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4282253A0;
	Thu, 28 Aug 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3JEcglo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA86224B12;
	Thu, 28 Aug 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394659; cv=fail; b=pnb6Evaz+Tg/AOit12hFrAYKZI9yvNjRoFP4g9EG141dZONNbe1ZsAnYECYWpYt8kxXmely4HmI9oIPNE6NuPx1LibMQRlpj8oOUkMvkoBi7DckUZDd/D6CfNIQ7thl64+IbJdcfA6IkxYTsHcCEQjWN8WJQenV1lp3T/EELNag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394659; c=relaxed/simple;
	bh=uWcy21Unuitl9tmEesaVmgtK3h/KbqayyphHfe9Utc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PucmQ76jOKXcBzJHeM8z87jshXHPkZaTs4xViXKSIimFHoIvST+fbvffnjHHMkn5d8M3ysFveYwgBQgQMojr9qN31p9BT0Jyj9figJN/sr/9MYPi3x+Ppav5LASRRk+6snBCeFlIyz7VISwcAkd20LVlwSM5IYCaYP2QMKlN5dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3JEcglo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756394658; x=1787930658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWcy21Unuitl9tmEesaVmgtK3h/KbqayyphHfe9Utc0=;
  b=n3JEcgloGA63e9Z4g0xT78XEdzo//Fnbvp1xEXvhHCzcDBYs+wqTSI3Q
   TJTwucUyeRbnbILoIz0v050HgF6HabzqR8jdSVRLvAkWpTPYbLzPgl5PN
   uJmOEvJS+5Z9YCq+JSfHL+AsW0UO/EHG1UJPL6+B+V14HNCeAVNezOCdY
   gqs/afhP31AxVtprXWPaaoz0dyPLLMUcmjiUxO+ROzXegF8oc4Lid3oIB
   ZZjP1YEXB+zMedZssrmW/YzR4wCqFwogd8pTjUCjSbk6JVyl4/V+MISER
   T61fd8KpUiM/riLnjQw8sIYD65DP9Hf7I/jY+TmbpTJ2fvt+IgRw0syFE
   w==;
X-CSE-ConnectionGUID: LnBfef3gTBCQUpIkzvNN3g==
X-CSE-MsgGUID: T4boIWVIQheFDc1MB7jh9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58593114"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58593114"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:24:13 -0700
X-CSE-ConnectionGUID: ZZcXkgonSL6lmupU3Xypnw==
X-CSE-MsgGUID: 68EjXpknTGGg7Tu3BdjO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174476737"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:24:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:24:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 08:24:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.75)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU5DaSjlRXC4G57ySuilz3ZQPPfIWk39bQSe4iF98fEMYyDMySUMQ5VTwAPsjORRD5L2dcbirU6HgRcn2cq6MUiMwj1lr1TU6WP8GLrSLI+VhXpK+9Pic4OUJXbLayGkDJJOtvqVKA+mpO9B6RSDfTU8qBdBvaxyMFZXaF8QlSOvcrP33He3hrHtV50LtUwU1kCxRI8EiQy6MnyLBym+/Bf26QjCqxHl4X/SJMCw6g9B3rzVRBkfL2YELRpzjG5htLRCYOj9kRWfYq+/bbL1djnhJrhbz8QjCv85T3rZVjWiRcmIWS5zk1f3Gs6GAAOGXa0/D7xp5hqlh9vF+FzSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+1rml45irFkvX9eAyfexLqlXLTtgtRcrk6f9v2zmN0=;
 b=mqwkabM/JPLGnr5S7tL6UeyiCSZG5bP9R7cnSoo8hpjGODlG/WxhyaHVOO4Xh3PsywI9xr1DuRcCC/6NxxMqA+2BX3v8fKUY1LhGY6F2s8UpRB4qTacjbDwL++37TQxzfI5Yn4P+2OQBqs/1yRwk7LK0tXcx3I953dYgT+b2MyN0+1UFh2w+RWiGw1sVsDqnoB16zmUwmEyn84eWUgXyZUUW4QhW5V8VWdZzyzg3Uy1t7of/gumkBzWl4DHftSnsJbFWTchlEYAQfPjaGIvk4UfNoD1eaMAsPv08Wk4ktrLFRMRuRK/anJGN3opJ8cd0+btWmFEr2Mq3h4WC0rCZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 15:24:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 15:24:03 +0000
Message-ID: <7b8de23e-67c3-46ee-ad02-b80e74f8bea4@intel.com>
Date: Thu, 28 Aug 2025 17:23:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/core: Replace offensive comment in skbuff.c
To: Andrew Lunn <andrew@lunn.ch>
CC: mysteryli <m13940358460@163.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Mina Almasry
	<almasrymina@google.com>, Jason Xing <kerneljasonxing@gmail.com>, "Michal
 Luczaj" <mhal@rbox.co>, Eric Biggers <ebiggers@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?4oCcbXlzdGVyeeKAnQ==?= <929916200@qq.com>
References: <20250828084253.1719646-1-m13940358460@163.com>
 <39356464-0b83-46f5-bf13-4f38c3ba2b53@lunn.ch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <39356464-0b83-46f5-bf13-4f38c3ba2b53@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: fba5e87b-9b36-4a90-3763-08dde646ebdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3JaL05MSXBBL2FHMCtObzZ3dDgxWk9IN01xTGxzZWJ6R2V4U3Q5cFY0V05C?=
 =?utf-8?B?UmZMdkRCZVBvNXFvL3FSUExvYkZiUU9ITmlUU3R1V0YwU0FQUzlNWGY0dVRn?=
 =?utf-8?B?K2t2QjFLTDZWQXRCaVdmMWR1N1oyR2xDdUZMR1FOL3FKUi8zT1JUNWhrS3Js?=
 =?utf-8?B?U3lqVTVKSkxRSnlMbnlSc1JyM2MyalVWOXJvdzkwV0dDeXA0eFVyViswTnNm?=
 =?utf-8?B?TWNvNHBVbjh3V0F3UHA0SHBJbHMvRjBtc3l5dmNzWFdIVCtOa0hYSDYwdlRH?=
 =?utf-8?B?NHE5YVBDbU5xOG9wZHQ5ZExSWEVBZi8yR1hFczVTUFN2ZTl1TklEMnBMUlNr?=
 =?utf-8?B?Y3BsWEY5Q280R1p3UzRYU2d2YVRRSzhmMVRuZC9jQ1hsR3Q0Sm5rSitKdEt0?=
 =?utf-8?B?aE9xelRxM0ZlSVkrZEF5WVk4c1RneXlYM1IyRXpGS1hDR3ZkOHRxdTA2VW5p?=
 =?utf-8?B?MDRhWWtNcU9ZRTJoVVJ2SkJiVEVzNGVZbmYwcysrYmQrQy9ackxiK280c3lm?=
 =?utf-8?B?am1hZGtEWHFBN2JYUWFtSDl5ZXArOWpDV0pzRGhxR2FIa0FnbXFLcys4S2dt?=
 =?utf-8?B?NjFWQlJsYnZDZ01TMXF4dCtaWGNOMTBYb3hHZC8rdjlBdno1SHM2ekNrYXdl?=
 =?utf-8?B?bDVhVXpGRlpFTm1RTVZIN05YSWpVMGUxWU9sU1N4RlBLRjNCNDc1bGlNS2xC?=
 =?utf-8?B?NTlLZzJ2a0trQ1E5QlZjTG1oTjdnZGRzU1JvRFBSV01aTStZSENjNkUyTGF2?=
 =?utf-8?B?TkxjQmJ5bFpiN1h3Q3Z6TVdvcDgwWGRHQkE4K1hnVTg4NlpxRW9sNEdQR3Z2?=
 =?utf-8?B?ZjFpSGowY3BvUjlLdnIrV3l3c3lkcEFqNjF1bDJDd1RaRHY5QTBjMVVoMEM0?=
 =?utf-8?B?UnhoeFFlZ2FXN3NFODZUTVAxTExHc1N5YTI5QUc0eEhKRW9lQ3diUldlYXly?=
 =?utf-8?B?OTlQbkUxSXBrWVl6SnU2VU1CVWxVaVBNOWVrTnNtdGc3OTIxazkxempIanRT?=
 =?utf-8?B?NlhlNXZaK1Z2K0ZibVVKclNaMk1KdVcwTXVwbU5RZFNwK3Z1TzRmYldsTTd5?=
 =?utf-8?B?citIa3pWbUhycGN4eDhNdmI2dXRYZ0RyWGdsN09ia040akV1SGkwNWJmekpM?=
 =?utf-8?B?d3NCTjFKSThXSmVTVis5ZTFpYldmQWpzR09TOHNyRVNzaHJoMTVJc1pqN1pw?=
 =?utf-8?B?UGNEaENvSUo0aXN5V0JxSTVtcFRaaWJ0N21Id1VEa0t4M1l5MFZjN1pIUElH?=
 =?utf-8?B?MVl5b05HVTNxVnpUTE9zWVRZTjFpN2dhTU1OZVVDK0xCWi8ralJXTmc2Tzha?=
 =?utf-8?B?Wi9qVU4xdnRnZmRXbkQ5eE0vQ0JMbThWWHBDNU9uby83WXQ5WVNvb0Zsajhy?=
 =?utf-8?B?b3prdDVqbGsyb1Z4WllKbklEQzF5USswYnEvbzB1UnpWeTJGOXNqRHZuK3hr?=
 =?utf-8?B?RjRQQ3Rwc2FYRFRCRnUramhQZm9zUkhjcXY5ZlQ0VncraC94SUpvN3paNlFG?=
 =?utf-8?B?U3Q1OC9Uck1hRmQyRzc0L3V3cVVLci9aZUJxQVNKWjRtYklXN2FNMDdNNDRm?=
 =?utf-8?B?Qmp2ZXdKVTNvMTVhMWpMdi9iTHExdkVNeUd6bFR1d0JNZDV3RkhOcEtoUGNt?=
 =?utf-8?B?Q29nYnR4SXI5VHRHUzhVVHVjOTlJb3h2R3l6TFVJOUpqcXo3T01NOXNDZ1Fi?=
 =?utf-8?B?eUZaemVyWHA0dHFsUFNaYnVSeVJTaWFRODJtbnU4dkd2UTB4L0srd2lUUno5?=
 =?utf-8?B?ZDlUOFE4ajhIaEFVMzJGdG9iWGQ1dDd0UngzS2NBNVk3Uk1mNWlTQlNtWE1h?=
 =?utf-8?B?Ym8wT0tXRVBrRWFlRW9GOWlYanBhQjJrb3JiWHJSNjZEODVOYi93c281MUo5?=
 =?utf-8?B?Mkl0MWRDcTk0K1hmRUNta0trUThGU1I5dS9GMzQ2RDRzeTBZZTdYVG1QektI?=
 =?utf-8?Q?Jhlr5zRT7HQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEhwNGtuS1hxcEpXc3JENlVMWkoxY3hqc1ptbHJHb2l4SytReFM3Z2lSSUQz?=
 =?utf-8?B?cytRa2dwTGNBRWtiQlJ2eXJ5Z2tEUjZESkxZU29tZkNlZ1laQkl3MTliK2FF?=
 =?utf-8?B?RTNMTHN0VkNvaVU3VFFURXlDaDJlOHFBM3U0R0p3d1dxdVZScEE1a25YdVZQ?=
 =?utf-8?B?M2ZKV1lNcDVmbVR5YlVNaGxqSHBkM2N5QjVmTTNwMm9GMEx3bjVLc2lYUE56?=
 =?utf-8?B?LzNJSFhINWszNFpOalBCM1RjdUNqV2dNcHJYZllocFpvREJKUnM4RTVYK1Z3?=
 =?utf-8?B?cU5PamZMU1BKazdhcVdWR1BiSHBFd01wRnhPZzZKWmtTMGwvWXF5V2tFQXBi?=
 =?utf-8?B?eno4bHpEa01ITXRlelpiZVJUb2ltdFJDN1g5aWF5NlcyRU1meitmb3gzUG1D?=
 =?utf-8?B?QXcvUlpZNm1MaE5ManJVdjNzdkNCTzBnaC9DMXBQZjhVVzB2aStPWXZrM3Zv?=
 =?utf-8?B?MDZQanREU2Fwdm9yeUVwdzNiNTg5ZWVINGZjeVdsNTNrNVFaSldqRXlmL2ta?=
 =?utf-8?B?KzdrbmsxaWwxbkxRWGRxM1lCeWxTUFRhOE1PKzRWT3F3aUZOcUFScEFQRXJ4?=
 =?utf-8?B?bVh2WEZnb3lRdG9zM2RuNitFWm90M2tPeFpreVFKWW8vV3U0SkZ6azhkRXBO?=
 =?utf-8?B?bm4vbGtqSUl5d3dRZWZ5OTFEeERkbWRxZHVPci9xclpheFZGbVBWeitMSkxp?=
 =?utf-8?B?RUpoalRKVFpUWXY5L0R5VjRTb1JlRXM5bWF2RVJyeHhYZGxBdmFIUGU3djU5?=
 =?utf-8?B?dlBGR1N6UHYvVVJHNEhDRW9NZUd6NXFpWnQrdCtnRU9MeXNLZ3NzcGNHaFh0?=
 =?utf-8?B?NzFYRnFFNDBLQkYvTGloeDhZOFFPdVRvN3NTblhXQnl0YWJCWjUzeVVOWjB3?=
 =?utf-8?B?STdzb3NodUQvK0hCZFlxdmNtbHBBQUFzbnpZdG4xT0hsV2MwS2laQ0JPeTJU?=
 =?utf-8?B?OVMwckVaNTh0WWpPRWkzYVpUWllDUFMyUFJrajNHK3JMMnRvL1VRVlpHMzgy?=
 =?utf-8?B?TUNmVEJQVW5iVFIxWHNmYkpUS0pBRU84THBMcCt2NTJ6dFFXZTMrMGY2RHNT?=
 =?utf-8?B?V0VidjZ1UmJSRDlXcXVTYXI1R2JoWGhvT1FENW9BelRRdWZhRVFnTzAyb3h3?=
 =?utf-8?B?eDE5VE5XWm5OM3JOSEt3UXVhb0o3d3Z3ZS9tMEtBaTRSQmlYRjQ1OVd4eXBy?=
 =?utf-8?B?NDVaaExTRnhwT0dVU2J5eU93dVo4NGQ4L1NpN0RWZGVUMyt6cUJlRkRNQkFB?=
 =?utf-8?B?TUF0L2ZGK2c3K1EvbkhhNXBOcjJvRVFEaW11NEZiL2x0TElEYy9FQlJTdnA5?=
 =?utf-8?B?b1gyRHM0V1NjU25EQjhJellqZ3pGbmlnRUU4d1MzQkVOYkdNZURYRkpkKzB0?=
 =?utf-8?B?dytPaEVyMmFCaENQb2hESSsvYUpMSFN4ckJDbUhKWWRuY2NoeVp3aVlnanhk?=
 =?utf-8?B?WXpkKzNMMU1SNTZyRGdKQUlsSjVmdU9jRXJKeGVLT3FzTjd6eUZDeHpQWDM5?=
 =?utf-8?B?UUlHSGtGOWhKSVFIanZ0SFdrZ1NhbUE1U3duQy9ZREJYTDdORzJ4UzFIbm1N?=
 =?utf-8?B?SnRZLzdCRmpGQU5CdE9CbmQ2THJXSWFDTmpPRXJqWTFBRVg3VGw5bjE4Y1Zk?=
 =?utf-8?B?dnd0UU1qRGtjSS9nRVFsdUpBSHkxTGRJRm9xZnpGMzFOWTdBVS91OUZKcnFk?=
 =?utf-8?B?aEtlUk1ZWk56ZGRUZ29VNjVNL2s5bWhlQjg5bXdkellhczdXWnJ5NXMvQk5E?=
 =?utf-8?B?a0lUZWlXOVZ3UWdTT2RlZGVLUzdGTjUwYjdBT3YzZVBtUUxySVFrZytDejgv?=
 =?utf-8?B?V0Fxb2pxNlhZZWNXdkZrZVA4VFdoMTAweDQzc3A5YlhWcFBqZEt3OTJWQnFH?=
 =?utf-8?B?ZFF5ZytkTnJsczNIaG14SnI0SlN0M2tTN3pBVlZqak1KQm1xY0gxTWw0Yms3?=
 =?utf-8?B?eFBFS3hjQUpISVVjTldWcmZMd1p5YnMrdUljUWNYM211allVbzVJWnZYSGhZ?=
 =?utf-8?B?bmxINUJHT25aUnVzSDF5WlhobktjUmFqWXZxNnBsc2pudmFKdUJsL3BFbjRF?=
 =?utf-8?B?ZTl0QU11anRmS0VnZng3eDNEREFNd1FlRnc1U2w0UlBsNitGSm5aTTFBM1Y3?=
 =?utf-8?B?U1o0Ui92SzFGV0FBNXBUbnFQOTE2dkJ6d1VXK2NDV3pvS2RUeTM3NjRHMnY1?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fba5e87b-9b36-4a90-3763-08dde646ebdc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:24:03.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QRm/Ti9wEQZAfpJagL2IswAF3xFlRnwgsJtEh8YEXILGEImDI520/6TQGtdQVbxcrqfNOJqkdAngWZCLSQCpcm3CWPpH81BeXdUWv/w/Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Aug 2025 14:36:40 +0200

> On Thu, Aug 28, 2025 at 04:42:53PM +0800, mysteryli wrote:
>> From: “mystery” <929916200@qq.com>
>>
>> The original comment contained profanity to express the frustration of
>> dealing with a complex and resource-constrained code path. While the
>> sentiment is understandable, the language is unprofessional and
>> unnecessary.
>> Replace it with a more neutral and descriptive comment that maintains
>> the original technical context and conveys the difficulty of the
>> situation without the use of offensive language.
>>
>> Signed-off-by: “mystery” <929916200@qq.com>
> 
> Sorry, but this signed-off is not valid:
> 
> https://docs.kernel.org/process/submitting-patches.html
> 
> says:
> 
> Signed-off-by: Random J Developer <random@developer.example.org>
> 
> using a known identity (sorry, no anonymous contributions.)
> 
> Please resubmit using a real identity. Please also take a read of:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Should we consider applying such patches at all? There are tons of such
comments, mostly in old code, while I highly doubt it may "offense" anyone.

> 
> 
>     Andrew

Thanks,
Olek

