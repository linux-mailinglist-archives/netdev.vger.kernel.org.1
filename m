Return-Path: <netdev+bounces-291768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEGsCtTKFWqQbgcAu9opvQ
	(envelope-from <netdev+bounces-291768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:31:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803745D9BA5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93AD431C090B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE18377EA5;
	Tue, 26 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkTYc6DN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033637757F;
	Tue, 26 May 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810039; cv=fail; b=P/kjI4M3PHw6QgH3w92kDrZQ7GP3Ydlj7BW2EMeYQu5PCIGSTP5cAJlp1I/S/HVT/40CXR6aXhAbTWXuRNCdqE1EjDUWIOkYgY073X9xVriIYCiSqssEW8knLmvkunkT4kBh2yf6v1jDXWeP+gZh0+yBGHCP61wBQbCaB2vlErw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810039; c=relaxed/simple;
	bh=0Ph+5tYYCIxrjQYqbunNE9qSYd8yRuQ/zzOq5EGYxLw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ucEhWSx2RQ8GtoEWhfaskpTet9fSdiobqaqDHPu+JXcD1zeLVaLGLI1uhr7vyWtTbN9FlXhSxIxDQj/2h5QOOjqQu5kerJXiXCvCxydjF23HBpQardM+xqIWSziiqUV3hfGOvewPozXWFa3TxssPxYRYNOXGkpje46o4kdQG2RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkTYc6DN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779810039; x=1811346039;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Ph+5tYYCIxrjQYqbunNE9qSYd8yRuQ/zzOq5EGYxLw=;
  b=AkTYc6DNNK6VwfoeoYPc4OOyRnmxXO3Kw3oq4f2KmfxfgCE2L5tFglVo
   uRTTSno1hJtCG+9IhAUjLueiDKPM/yOaAR0qJ/18pnNhJvyrAuyp6IxAu
   eHL9/Y1IfkNqqH/d2TFJIb9Pm/QmwDLbdqHFOarB8Uf11V0q3yNvQhpUi
   6n6bJehh/KKlktW0FzCsW86ZDbtIbIwFxDJq2yqVstW3lellBftMkLJhl
   MuV6/IElLgC6zpAZduXj5zz6DTg7yzmG3vKwIAYAYELsG8hmem3fNd22N
   Lsv2C8wlx0QIskKdC9e/tqWj9lsGJIs1Hsk4nj8jO3ST+DiXqYap2pdvg
   Q==;
X-CSE-ConnectionGUID: KufFatrYRCSOqfzWDdMnXA==
X-CSE-MsgGUID: keouW0O9QimKLTIeES7FKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="92099540"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="92099540"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:40:38 -0700
X-CSE-ConnectionGUID: 0UvmZHY2QJWCIpxsQmTInw==
X-CSE-MsgGUID: twpQgLq3SR6XecCKFLYscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="265565885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:40:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 08:40:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 08:40:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 08:40:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EP2eJLakVJHArHu7yPq3lGPQlfaxNiLjYTQDCZQ61Z/GeVFKuNWGVP+tpzPsycnf0xpB4MpkrGon5ogaQjF9VO/lyP4g4GgnoNh33itpFmU2eISoh8erQkZ5CGyVyTNPprnBvxmwih7U5dxjAr/KIvcs8OeimxsJxSUNVcZEvvsxwX/bpSua2dZRsVeYQQJNknz1jIdlztwIWuIpIDpgY1/obyATkMJhpJ4pmTcCDL5XxQnCjagVVNM+8sLOkvFwfvDjRK4Acrn+rgywp+EKep3laezwDp+oXi546IKb/9rfsBUv/vz4S7DMsxDjYeHEvSiKPAE6XvYIUMkkF1RLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nptmqvQkJifwSGXJSo87xDxCzEjDL0mGd1JgxH/qDl0=;
 b=T87Fhwq5dNwORxG2C9Cc1EQ7bWUiUfM+pbMurTxCX/uAj28N9QDwC4qWMDfk4x35vwo2gct7pYMFjbX92VE66XnHS+NZmf/GFF1EUJBLyp/t0+IPHyhU3/dYBjQAe9SXAZcS016Px+gxbEaTivchY5+ht899aQ3M8985Tjm11fxk5lPkCOIKjxuQloqePLp2uQVg9wAmhtL0qgxRoAp23HbG4gKmeNWSeJr5OUCecDGCCERb/vhjLLo+hisBD4IMC/+GEWJbOqbTI7yK5/nOgomwt/An6QZybuEdnAoCmXrj83429+i2sNYU1pWqxubKt59Jdlly1BiFA5uURF87MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 15:40:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 15:40:32 +0000
Message-ID: <53216152-cfec-49de-856b-0378c9cb37ee@intel.com>
Date: Tue, 26 May 2026 17:40:27 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH] net/ipv6: icmp: fix is_ineligible() to block errors for
 Redirect packets
To: Sayooj K Karun <sayooj@aerlync.com>
CC: <netdev@vger.kernel.org>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260526101622.38536-1-sayooj@aerlync.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260526101622.38536-1-sayooj@aerlync.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0244.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 9166795c-dea9-4b8d-b222-08debb3d1f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /TkqD1ZNQQm3S5LIWqB0JjdpTzpGhpMRo5AGzveW7/Gt/fdI6ky3rscdb6z2pV/n9F6opA51ZdiheA02MYxLqsbH0zmwBp6mWqs0y1pHns/YPWSSjPBcQKn4eNP2P4Lo7ubFNTOv70vNYDJw0uJ2Y/Ey6Bg8boP+6wiZ4lnLZTBjZe18I0NINM2F98U6mnNd31r2eyJG0Y7B/EU63aXRrMiMY5orL25mZUvcuPoccu3BgHAv60HqV/Zbtodcn73LACeV5DW+tBsCZj7Hf3GXAvGvwYFLI+qhp5Ka1TNOf3bgxiRAsV61brk6tPWiMVwwlvHzs3nemmV1Qs8KEAXnJ2fsJUEJnKkgDakSkQZFFjD7/UXpgXVrGCpiEWytplNQ5VVsTa0H5uFxxImXnc/BcxebN5gk72ORF8Zi2aNyY1DL0aUzYHDoLkoe4xtwyqmP62+ZecUATcdiGCBtLdAV3My/2cTmnv7iJuzIhTM8kdxbwDbX6YAAUXYZTm3Inehfrvwm5B30RJc+P78p/WkuTBBMxW+ST1VsPT0e9oEsulhp2I7yd+IyeLfzgKLIXCjvXWaH/UuRzaA5qlgnH301Ivyg1nj8eiskuiYPGSPjMyGzff5K/fCwCnqdLgwRkpdUcynx9bhNSZMdNU78kda2Zt9cM6hwopVD9tSV8rEaVHPrkIVGH7jge5VaPbRPzBvE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpXTmhGT0FnenF4TlJJUFd1L1FDL3hOMkhqbEl0MDJYODQzL2RpKzMxZ2Jn?=
 =?utf-8?B?MXRYbExIenE1ZlFGK21mTllMVTJFYk42TTZFbE90RVc0azhDVWJRL1JJNklM?=
 =?utf-8?B?dmFlR05peXlvMGxSZE13dWxEM2NhMXR5U3BDNzhmRVJ4Tm9CL3pYaXpIc043?=
 =?utf-8?B?d0NNRGhQdE5QWHk0ZFVIV1o0L01Idm9TNE5yYmN4aDR2bVROOWRrbUplN0RC?=
 =?utf-8?B?Wmp0WXJlcmFlUTNndHJsMmphamF6a1o5dUFHRzg3K1R6dDc0M2lZaHhwN1BL?=
 =?utf-8?B?cG1ncE9tWU53MmtCKzl0NkJMOVZjdFRzUGF1S2hVbzhNWTNEclZuOGVUV2gy?=
 =?utf-8?B?aGtOQVg3RVNaTGxFNXpHalR1em1iaXpYQlJxREJIYVEwcVZScmpaU0VTVVlq?=
 =?utf-8?B?Um53UmZaamJxU0hqQzNCNVROLzRqWFdLMGhhQXoraTYvUFBmNEhackVtd3hS?=
 =?utf-8?B?aFpBczlMeEhQaUxLYUdnSVJQMTZ3U1A4NHB1M0Jhd0UxVEM5Z2VRbkxJaDZC?=
 =?utf-8?B?Z0g2ZTdoMGFLNFRNU01VeXRGVjRTOTI2YjNOU3JjY3pkMmI5M1Z4ajRJUjhS?=
 =?utf-8?B?aGxwaFBEcUQwRXArY21RV2FRRHBtYzV6U2N1cU9uSDFoK04rU0hqVk9ZaVMz?=
 =?utf-8?B?VGxERStVSms2ZjlYWmpUWUJROURmVE1CbVBMY3VjKzhsR3NJZThmR1h0NFJm?=
 =?utf-8?B?WWRGUFdGTm5TQ0hUZW05Z09kbi9uTlBITnB1N1ljSEJXNEtVdDBsc3FxZzRw?=
 =?utf-8?B?TDZoa0hVY2VFaEJkQWQzMHRWQnVtaitHUHZNQlptSWpMdUh6QmdTTVNTenBx?=
 =?utf-8?B?bnYrUTYrY1JDay9EWDk1QUd3b2xZekttdjZMckgvQWJJWWtVQldCaDA5bk44?=
 =?utf-8?B?WDcxbDhuRmJsalF5eG01YnJMR28rdCtUbVlRN2NKSkRjcmU0Z3ovMlByazNH?=
 =?utf-8?B?TFlmWHF0UU5hVkNNU1J5OEtHOUszTHprUEdSV29SZWRPS09JS0w1aHpMQlNq?=
 =?utf-8?B?Q2d6MHNRbXBDcnBlQktmZjJ5WStieW1rQWs2YW1CUUUrUmw4aFhPVFZibkt2?=
 =?utf-8?B?VUF6QjBaOU90WnRtUVZRS0E2c09EemdqR2FoR0EyM2k4SjBUMm9RU3d2bWkx?=
 =?utf-8?B?b2QrOWlub0pGZENsM3NDVWVLa081SElGZDZ0WEhaeXgwUDVzSFVrTnBUM3k0?=
 =?utf-8?B?SEF1ei8yUWh4dWQ2ancyMjNlVUNvRDdoaWU1bkVsWEdjUDVMK3RlZTVvK0hj?=
 =?utf-8?B?YU5GWTVwTVVYV0NhYUphVlFVUFdWTFZFWlpkNkJiakRBQjg0bDZqMnZDakVv?=
 =?utf-8?B?aW9oUUY5NEZVNkd4MnVEdDV3b3VzeVlKTUo2SnZMOUFRMkQ1YWhYRUZGOSs2?=
 =?utf-8?B?TjRXUGxLVXoxK2dBNmFnM2lMZWkzVCtGbFY3UWtpNGhKMFQzY0I3SjdDRS9o?=
 =?utf-8?B?aUlQMzNWYjluSXJlY25BYW9sZDY3eDA3RTdZbFRSSGlDY1g4MGo1b1BJaTJ5?=
 =?utf-8?B?cGdWNEdRam1BcXg1R3ZrdXRGY1Vselh4SEU2ZEVUZ0syOUJOR2hTbUNHRkcy?=
 =?utf-8?B?N0Vmak5GbUZBbXRMYS95ZlZSL0RZQ0N1aUlaY3ByQjVqWHd5QlgrWmF0VTFD?=
 =?utf-8?B?VllGWE1ZRFpqRWlJSnA5NEE2LzdrYS9XM3k0REhJUnRabzNVN3FJaHl6YTZX?=
 =?utf-8?B?cG9oR3hHZENFek5LbmRFSGNmelhtZVIyYkZobXV6VjU0OTlUT1ZPOVZ0WnE5?=
 =?utf-8?B?bDZSRlR6YmVNQy9Jc1ZVM3VSa3l6R3ZLSXhDOE5SdHEyRTlPSWNTeHRCb3NY?=
 =?utf-8?B?TzJobExjb1huUkVlMUVFTFFqLy9uZGVmZVhIUUxjeFNyc3RpZytoemlFeXI2?=
 =?utf-8?B?bXdhWFllUkdpVEc4UlJmSFU4V1NZUGlGcCtUbFQwaXhKMy8wNG1DMWlFUVIv?=
 =?utf-8?B?aHVSY2FpMG9NSi8rRk45Z2dXWUN0VUMwdFlkZnYyRVdYQnlWWVp0elJRZHI5?=
 =?utf-8?B?bVpqM0pHd2hWQUdKWm5KaW9uMDIwc0NXRG1ObkhhbWg0djhaMFVaNzJaVUd3?=
 =?utf-8?B?WVd2Qk14SmlWMk9jWjZGaXFLSVZOVzFVSDVVZGh6R3MvZXNjdWFjb3FMOXpC?=
 =?utf-8?B?SHk0bmo5MWwweHZwSUhxMW05MTJ5RWVYYVNucnA0Q1VPUWxrNmVFbTZ5WjU2?=
 =?utf-8?B?M3hxZW5sd1FTcWVZSVN2dnNDNnZaVDBZbXFSaU9TQmMxay9ZcitJd2ZWRmR5?=
 =?utf-8?B?VDNrSVV5Q0VvRXZSUnFadHJXUDNaUE9JRmUxSm5VMk14ZEVqMU0xZy9RTWFn?=
 =?utf-8?B?VjIvNlB3QWpZN0V3NGpoSDBnd1VaRFQrR2tzQUZ4UER0Nmc3eVFoRUdXc2pV?=
 =?utf-8?Q?b3Eg6q9fGlLYq3UI=3D?=
X-Exchange-RoutingPolicyChecked: DH9geS2++KTPUMrnDwRLvDGYY9TxZ8b2huuHrYhWyeR0EKscCvEjdjZCxiPKruhkTCNxlR/LrFzcjUt6jcsT2sIGUcHVcUGp/FVeaSPvgDvW6rYcxLSQy8qOUcACM1BMAuVXuVgZ33AqyX5LoyZWS/MfRfXE/KYULKypEz6SKo8weMydxQylLsDo9C242Ea3z1hVRrUB5Wl3q4PXOV9A9Uy4WJqbwcw2OK4DmxUIzejWARqy/lreKJXop4EujVvC9DyXp5/UiXfTefszfQDzVzZdNUA0Ko+aQVbezz73+ADn6VoM+dw07ynK1rnEFpTisw4kckXPRlH4ucUtFLXNog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9166795c-dea9-4b8d-b222-08debb3d1f40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:40:32.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq5FXk8SJVMCVa7t8sdCknDaa2qVLyZnrQ7IGFktGWtPQo9SgAwk4eR5ELEYTQlKRNrWWfT+QeQ6Dkuep7ixpFrg9VlBeXghNP0dJgbOS1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291768-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 803745D9BA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sayooj K Karun <sayooj@aerlync.com>
Date: Tue, 26 May 2026 15:46:22 +0530

> [PATCH] net/ipv6: icmp: fix is_ineligible() to block errors for Redirect packets

Is this a fix or a feature? The subject prefix must contain either
"net-next" (if targeting the feature tree) or "net" (if targeting the
fixes tree)

> RFC 4443 section 2.4(e.2) mandates that an ICMPv6 error message MUST NOT
> be originated in response to an ICMPv6 Redirect message (type 137).
> 
> Add check for NDISC_REDIRECT (137) so that redirect packets become
> ineligible and error packets are not generated for Redirect messages.

...for I didn't understand from the commit message which tree this
should be taken to and whether this should be considered for backporting.

I'd also like to hear about real life scenarios where this misbehaves
and what gets affected by this.

IOW very poor description to be reviewable.

> 
> Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
> ---
>  net/ipv6/icmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index efb23807a026..3fdb3a97dd8e 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -157,7 +157,8 @@ static bool is_ineligible(const struct sk_buff *skb)
>  		 */
>  		if (!tp && frag_off != 0)
>  			return false;
> -		else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK))
> +		else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK) ||
> +			 *tp == NDISC_REDIRECT)
>  			return true;
>  	}
>  	return false;

Thanks,
Olek

