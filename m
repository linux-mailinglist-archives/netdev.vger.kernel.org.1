Return-Path: <netdev+bounces-146549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C29D42C8
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F39280C63
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B21C4605;
	Wed, 20 Nov 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuNpeeeb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090A1BCA04;
	Wed, 20 Nov 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132490; cv=fail; b=JkzYPW+bgGrRIfl8a6xbaMIBENZn4SjefeHe9aZlVFK8vWjAb0MXgnRIOPPFxnf9AJ0sNnszexodaT+qCKGukofW5wpemd3usCMYLZAdUnwnm9PEi98yObXaMRL4GGU+jEdTxbycm3sXKWyZqBNRYbecfwdVJTYI0AEinOEP3FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132490; c=relaxed/simple;
	bh=mi4cALduOE0DLIiyOL6qLFsqq22U+0toxNctldwqIA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNoTR44WjerQ3QDWwyJcjAVPSIuTDqyloDZBUXtf0jvoLa1REr6ySkVguBERZEA2jc6J1Q+7Oh1dtQr31bocOsMUgb2uJs4MDdFI+8BjWflbcUuDAlJuEmYHYyvGHorRrcFTtxjtxgT7/IyccupkEC3kICTLXi3wB/r05N+/nRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuNpeeeb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132488; x=1763668488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mi4cALduOE0DLIiyOL6qLFsqq22U+0toxNctldwqIA0=;
  b=HuNpeeebICnR4tOH0ve8Do8yFql/waGFHEAKUWBFT7g0qZrINJkRKdJs
   a6cAz6mbMbcjaTe4dGH0x8QVT+Sh3X7lbW8I/LXakVBAUmtaxO0td/p0I
   djR1eyj7+Zq64f3nvAjSWCFNwqWePQv8q8qwvlPysN4f75mU8xSv1AKz8
   G0nzP02Wp75Ue+7Io6C32r7hd0Rf27aaTMHF4mTVYi/BmNObsbYZqwXGi
   CnchaKCc/haVmZmuVmT7PyyTKZWZuHd4iPA2kuGUXW5seRMVGoiOI3Okb
   yP6JmG1KI2ZCZKiabjgn0jXHXI2fumuYG0gab7HL1tpnJkpaQRzCHkEoF
   Q==;
X-CSE-ConnectionGUID: HfCT+9ZuQ5+G3WCJ70Wg0w==
X-CSE-MsgGUID: 7x/InqzfQ0yysswlerzIFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="43284079"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="43284079"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:54:48 -0800
X-CSE-ConnectionGUID: lzg5BQL0SNGJxVDg7JZasQ==
X-CSE-MsgGUID: mJv9/NFuSXS2fvjKoA8QLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="113293395"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 11:54:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 11:54:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 11:54:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIbIi4c+2yAnA6R7AnaoFd2ZYViLaw1ZLUIvf8kDRqCDHB0Oto7pJ+cShEQc1fQNq+tkK5n2ZeJgYxQXdOy9fFZTsWoIXABfpMNUnxblV8HLdi26+bsm+EGjzEJzKHOd1HLGSkQ9TBef5n4aEdClPnwQ0tx1y8YlCOOqdDD6vO7EpBI18CAHeBvjHJokDFBPSMYCXZS2St0Fqb9IPLTf1/KaPPY4D2KAwyXHS5tD5Fjuzj1S4EV/KNxMRDQaWMSBlvmlLFKkMMjpA3ybUoYgZGdT8QivhP803mg0j6dVUXmr0bYutyadKfkqDG3ausJ4NdLE3xE7JkNUOk8vGxEu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgSbHWhbjfggge+Oqc4nMd8verIroHgbm0ZQsxBVH8M=;
 b=p2AzHCFqq/PB5sr+4lYXuzwBQ7D94ikke0UZU0I41W6yk+FOpLWwxV6y5jKO7b0vKYCnJT1VgNw2Tc++9yiuNyiRSY2LHfBcgaJGR1R7/U6nLt3BGxmcbtMZqYSgo3YnP/fOGIoTievVWl4EeQHZZIJEdcdb2UnTMWb9E99KVrxMFve/REZ/4yTToztBAvQ6OirkbRopyEogUwur7vuko47pfsMMx6I5ZtSEbw3qT4tb/Ga95KyYvyd4FmfqVaBo1o6awYU672EnaFKJnaQhziiusPrwhmORVctgWi2foQ6gXYeBW7MmCNkIdOgNIzcYmnmZOxgL0LZ8QpDlu+lo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 19:54:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:54:43 +0000
Message-ID: <b20ed55e-cb77-4821-9b5f-37cdf3d01df5@intel.com>
Date: Wed, 20 Nov 2024 11:54:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <masahiroy@kernel.org>, <alexanderduyck@fb.com>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <rdunlap@infradead.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <linux@bigler.io>,
	<markku.vorne@kempower.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
 <20241120135142.586845-2-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241120135142.586845-2-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0ff541-d7d6-4d25-0908-08dd099d2d8c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm9JaHdLaVJhTTdHQlZXak1UdzBXcW1HU2VINnVteDVaS21zVk1CMlFsMnFR?=
 =?utf-8?B?dVE4Q2tybUI4WDhEdXd2SDlBK3hWQTN2NzNtd1F0eDFqSE13TmtPK3Y3Q0po?=
 =?utf-8?B?bDc5RFc4TTg5aVpObkUwLzNVRFlidzlCRHVuZlMrK1FTSVBvNlJINTVhQ0k4?=
 =?utf-8?B?YTJLNTFVdFV3RGV0UG9CZmRwMHpsemRQdGJHS3RhS3JzSE52eWJFK1pJVWpa?=
 =?utf-8?B?RkcxRnd2R1ZrTC9qNC9GOHpSbVFpbGwwa2o5ZlZGSk9YU1pHQVZWcTB1bnpM?=
 =?utf-8?B?OWlmcGZkci8vL0U2SWEySFpxMzdRVmZRczJiSnFBNGJIakNVaEdTM2hMRi9E?=
 =?utf-8?B?eSsxRUhDV0ZnYm45TDkyaHBBTmxVM29la3NTYXR5bk1DaU5LaFpTdWpzQTFt?=
 =?utf-8?B?MEIvTjdRdHViakVGek16VDdlcEpSU3YvZ29qTHF4dmpSQU9EL3d6U2cvbUMy?=
 =?utf-8?B?QytZL1NFZHA0aEVad1ZrWkEwRTEwM0VtNmpVd09sMGxzbVFNUVAyUlBuMitt?=
 =?utf-8?B?KzJQTy9uM09vV2F4bUE1aTlVbmxUVUtFbjFhT2J1L3NGeFdIdlN3MG5QWDMv?=
 =?utf-8?B?Y0VaVS80Z3g2ZUlKTWtrT0dxTXovOUljVnlGYTZjc0RuQkJMRm1qVGkxNDI4?=
 =?utf-8?B?eEUrWnhGTTA3U3hLWWQ1NGR2TG80RlI5djJacUR4a0FRNG1WZVR1MTQxTXds?=
 =?utf-8?B?clgxS3F3WWwvUFJzbzFaTVVXRDg4d0tBWW13Tmw4RlN3RW9VV211RHh1REhx?=
 =?utf-8?B?VGpQem1NNVFKbnNUTTUyQUV1Q2J0MWZZNFE2YWFRYUtManFRQmpxRkthUlZQ?=
 =?utf-8?B?SVA2NzBSczZ1QUFtL3JRSnlOem0wekJNM0dXZjNXVUZFcGYwMG81Y2RUZFI2?=
 =?utf-8?B?Q2xiQnBKTndHbG1sNnpwS0Nnb2hWZlkvOFNoQllHYXhKTlBMdDh3b0lnbExH?=
 =?utf-8?B?K0FUNStvc3E0bXhzMzdhdExUakgvZ2kyVUc4cGY4UVY1WXF0aVdGK1h1REw1?=
 =?utf-8?B?QWNEVFpyVTVzRERvY1dCR0c1YjN0ZnlHZUZxNk42d29nOFEraWhTT3JmWkZL?=
 =?utf-8?B?QUNsNzJyeVdRQ3JUOG53enRXR3laS2lTWUlRbDRZd3RhL01Tak1HRUhPaCtw?=
 =?utf-8?B?cUdTL0VreStqVUdaNU1RSWRYV0ZKOVB5cjQzc3pxeVlSK1V0TWRUY1l2WGha?=
 =?utf-8?B?ei9TMksyMzU4amcvbGVxejYxdkwxMnMyZGZUT1pvdjA5aDRNNk0zeDRNYzVD?=
 =?utf-8?B?WVJ2alhHSTZCd2FZVFcrYXhBVjloZ3lSVzVZdjBtUXdHYjVmdVh5Z3FGTVR1?=
 =?utf-8?B?OGNkdW5TczIvbWFkNmtoRXhWWExxWk5VblZ3NVdKbEVNT0JlWFp2Um0wcjhS?=
 =?utf-8?B?b0dmQWxDT1ljcDF2S0lBeTdIZHhTRHZsSTQ1MyttS0Q2Zm9vMHYrdzM4ZURJ?=
 =?utf-8?B?OTdFZnA5Ky90aWtVYWgzYWZyQ0h2aEoxV2xoTDFZNGszeGdWNE0yS0M4UUtI?=
 =?utf-8?B?K0REN1B6VHJUa3RFNFNuaVB0NzdxUzVaN2RSR2dZMmJMb0pjcTNEZTlZa01q?=
 =?utf-8?B?TWFTOC9HN2xTWi9XMDYrdE9XQnVQYVd0Zkl2SUFndGtjUXZLM1EwenVZK2xH?=
 =?utf-8?B?bVJUK1doOUpyMVdGUldFTHd1bndKSlB2SkNYYlBQVVU0d2hyMjU5dzJpaEk5?=
 =?utf-8?B?NVdSMTVQcUtGbjNyNWNLUmhQSEVZeG9IMHFLeWJxaEpsOWlMeXlCS2hKbGlk?=
 =?utf-8?B?dUtCNnRrODZrVFhVbDVmWStBQ0t1dW10a1FOK0hDeE9NSkJhbFd5dzFHSUlH?=
 =?utf-8?Q?VWRPZTVzu/ADDDcQfMcJYwhJ4PV70d8PmCg7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGlsTmtmVWJ6MVl2ZFRkSlpSOUp3bHVmVlJpa09TWnhPbk9XMDNidlNYdFRW?=
 =?utf-8?B?cVVCQjhzSGhtb20rSERrbXErTHRSMGRYVk5rL3VWWitqWXptM3NEZVlyM0hU?=
 =?utf-8?B?SFFhVlA0RU5DaXZPNjFTbWtGcW5pMmZvdTl4YjVFS1BwajdHTU5Wa3ZaNmJv?=
 =?utf-8?B?VmJrWjNiSWh3cFplQWRPNEZGaWx4ODFyZGF1YWRqeDFUa3ZyQ0FGWG9hUk9U?=
 =?utf-8?B?ai9NL0RvM3NObGhUaC9XZjIveU1BMjhWa3J1bi9QNWFkL09rY1F4OU8wLzhP?=
 =?utf-8?B?RXExbndYeDh2Sm8wMEVOL3dPMDlmd1AyaVhOQ2tIRXI2d2c5T3A4WTVDTWVU?=
 =?utf-8?B?blJ3Ky92Y1dYSGVqWGZVTExxNHV5Sjl5SmpmTGp0ZXlJZlIvakxWeHFqR3Vt?=
 =?utf-8?B?MHp3MUhEdXduQ3JnekVxaW9HUUMvSzc5czZ0OVZCZXdlNlQzMkhRWmJGaTZ4?=
 =?utf-8?B?bG9tWTR6MUxDZkE0eXN6RDVMemlSWm9OYXVRbGlwbFJreTV5aUl2QlBvalNV?=
 =?utf-8?B?djh4NlZwaEtjRERzdTRLRXkwWUdLcUJjQm5TSjJNZjhUTnBRWFlFQU9SODJv?=
 =?utf-8?B?d2dHS2gzUE96eTR1dzFvZFpNbEMzODQ4YktNTWEzZ1pnYzFESUNKaWUrTzZF?=
 =?utf-8?B?UGJjMDZpaFZVRDYvRWQ2N3NtayswTmVsQ2dDWDNYbUUwdGNrbFVEZ0I5enhB?=
 =?utf-8?B?NHd4SUlQYjIyZm8rK1BySDVvRHQvZ2dRZTIwcTdDYzZnY2MrWEdoUGNpc1hW?=
 =?utf-8?B?U0s0SWV1NDlFeGtnMG9DTkdPbnMrODRWbVl5cFpjbVBZdGVHRVJvOGxuUytR?=
 =?utf-8?B?WmtXU0syWk45Z1VTVFJEWTZTZmZUY05LeG9pT1Y0QWFSc3N3NDc2aG9BVWla?=
 =?utf-8?B?VldoSE9xemFickZRYXp0YmV5bm1YSnNOWWNmR2pkS1UvRzN5dXFQN0U2bUdp?=
 =?utf-8?B?enc4MUdhdTlDNmQzMVdUTXA5RlJ3WER4bjE1N25rZ0pCcGZhQ3ZWNENkT1hr?=
 =?utf-8?B?ZFdyMkpwYWdXMnh2WmlDenlUeVhoK01sd3ZuOU1xR1lhUHBtSDFKL1Q1S09v?=
 =?utf-8?B?OUZQNVZobzBKUG8rR0FQSmRYUlVKUjcyZnJWcTJYRGVkSHdpc2t2M0V6a25U?=
 =?utf-8?B?Qk5rYytBT0JlNDVlYVJQa2N0SEZOT0VkUHg1aFczZW9icnhDcW9kV2JBMFV4?=
 =?utf-8?B?Y0hsRzRCRWF6bEFzc1dDNnZrZnZmU0tnQnoyYnJiZGdUM0tFTWpLb0JQUUEy?=
 =?utf-8?B?bEtJYVVSanBUR25JamhxVnNkZVpGdVFQOVV2NWxVL0JPZWtETWk5cWxKU240?=
 =?utf-8?B?dkw0YmVSU3gwRHZyZ3VVbUhIVHJ4VWdpTkhTeEpIcFhCRnBoR2tnSzNRSElj?=
 =?utf-8?B?eDlSK3diOEtQMmhsMUxZclAvUEhCclNCTVJMNE1zeUlrNUwzcU8vMGgzaHhy?=
 =?utf-8?B?aUU5NlhNYmxseU9XODF5Nk4vQk5aa29DT2lFcmtDd0hidUVDZ3BIYjk1cHJy?=
 =?utf-8?B?RmtPQTF1NzFXVUp1MXFDZDhKanRWS3R6NHJnUTZzZlBlWFRpTHIxRDRMcEo3?=
 =?utf-8?B?TFZBWHdwYjdsKzFPSWpROXErd2Q0Wm4rRy9VbVNCUm44TkJiOXV2Wmk5TTZ4?=
 =?utf-8?B?dXBUWUF6Skx2UGd4UDM4bFNiTFBZRnR2bnhXTjR6RXlkY0VKeDJKdHNlYWla?=
 =?utf-8?B?Uy93LzBrOUoxSVM3WWErVkMwaDJJRXdHUXZTa01rTkszaTMzSzkralVTcFZu?=
 =?utf-8?B?U1pSbmhjYTNsQ0dCaE1lMWdaSzFQU3U3UEtHOFRKQTNQTWFmbVFwd0VnS2xi?=
 =?utf-8?B?Zk5tY2VsYWF1VTM2eDlMc0Q4S0dON3VsRXZGSlU4WDhVMnMrMHgyRFVnK0Nz?=
 =?utf-8?B?TzRwdDFYek1GQ3FCVm5ENEx5NStYbjVBS0l4aDdCYTBEUFFQZkR5L1BKZ05t?=
 =?utf-8?B?NEV0K25mWHpvcnpwUEREY1hkbFlQT1hFZisvZ0gwVXpUL1hhQW9vMmdvQ1hp?=
 =?utf-8?B?L1FpWi9pSjd5K1NwM2VhT0QxYXZiVkgzbnFjVU5yWHRKeEltRUdYd3VEOWNQ?=
 =?utf-8?B?aG45NElhQXY4MGFKWkJ6dDZWcStLNVp6WUh3TjNzcXVhYVpFaU9TcDc0a2VN?=
 =?utf-8?B?RXpoajR5MjBMYVI3dEJ0NEpKSVlGR3U1djFJU0dLdFVGMHZQQ0llZ3dTVVUr?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0ff541-d7d6-4d25-0908-08dd099d2d8c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:54:43.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWHO38z/vcbv7T4MkT8Lsp89Bq/nAVeU5o0vxc7WKyHxoQ6bMKh4MrRnXHD0WiCUaLQamTLF/DwPUHIQfPqR01qzSkpGuoPl8sgXhMek7EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com



On 11/20/2024 5:51 AM, Parthiban Veerasooran wrote:
> SPI thread wakes up to perform SPI transfer whenever there is an TX skb
> from n/w stack or interrupt from MAC-PHY. Ethernet frame from TX skb is
> transferred based on the availability tx credits in the MAC-PHY which is
> reported from the previous SPI transfer. Sometimes there is a possibility
> that TX skb is available to transmit but there is no tx credits from
> MAC-PHY. In this case, there will not be any SPI transfer but the thread
> will be running in an endless loop until tx credits available again.
> 
> So checking the availability of tx credits along with TX skb will prevent
> the above infinite loop. When the tx credits available again that will be
> notified through interrupt which will trigger the SPI transfer to get the
> available tx credits.
> 
> Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> ---
>  drivers/net/ethernet/oa_tc6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index f9c0dcd965c2..4c8b0ca922b7 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -1111,8 +1111,9 @@ static int oa_tc6_spi_thread_handler(void *data)
>  		/* This kthread will be waken up if there is a tx skb or mac-phy
>  		 * interrupt to perform spi transfer with tx chunks.
>  		 */
> -		wait_event_interruptible(tc6->spi_wq, tc6->waiting_tx_skb ||
> -					 tc6->int_flag ||
> +		wait_event_interruptible(tc6->spi_wq, tc6->int_flag ||
> +					 (tc6->waiting_tx_skb &&
> +					 tc6->tx_credits) ||
>  					 kthread_should_stop());
>  

Ok, so previously we check:

waiting_tx_skb || int_flag

Now we check:

int_flag || (waiting_tx_skb && tx_credits) || kthread_should_stop.

We didn't check kthread_should_stop before and this isn't mentioned in
the commit message, (or at least its not clear to me).

Whats the purpose behind that? I guess you want to wake up immediately
when kthread_should_stop() so that we can shutdown the kthread ASAP? Is
the condition "waiting_tx_skb && tx_credits" such that we might
otherwise not wake up, but with just "waiting_tx_skb" we definitely wake
up and stop earlier?

I think that change makes sense but I don't like that it was not called
out in the commit message.

The code seems correct to me otherwise.

>  		if (kthread_should_stop())


