Return-Path: <netdev+bounces-100612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0C8FB524
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFCA1C221BA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09512C528;
	Tue,  4 Jun 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDL8JYkm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B928F68;
	Tue,  4 Jun 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511016; cv=fail; b=swqyqmCC/Hbug4RpK5Ff9oRB+vZhiuyQJhOdFOo1CEDKRJt6Do7r5+F46H1dELwQ8/pPFlCXQiHHJ9HfCqA+jeoMKSKZgO0r1OSkMFqTafKeU+oJYR3G03F5lL1i4yiH+zjw7892eGdiheneXG/jtIa+bitLefrS8zpJbaZWGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511016; c=relaxed/simple;
	bh=LGem4DUlO+0GnI3gazh5bZUKdXGwLWY82k0pI74UDkU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CYalbiJ4CUZ5IM+dDgfyaTwJiA/LD4+h/8XXayG4I16rm/kn35JS0KHfLo1SYqMHF36/3hk0grN+SEA8WQVsRzZrcXoPn94ovF1gDQ3p3g5rxRjWSzVSqbKhP55TSKHlQE5w4s2Gqf0Td4OIRSKRJt05Lw2flmDZohEkh/K0vHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDL8JYkm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717511015; x=1749047015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LGem4DUlO+0GnI3gazh5bZUKdXGwLWY82k0pI74UDkU=;
  b=VDL8JYkmqHcU667c1tIgWQmcdLNE8qwp/xylAwBgyjI+YyshEDLD+QEU
   ORwe4AmS/gj7mS32JAGdnCCl2ZJm/CuxAjdQDRISV33/H1OqWw/YjJAgy
   hyfyirKaO70/IG8z0eiMeJrcNumCUbNc2pckkLSacMQmwJ1xoqDNQGvNx
   lF7tXkfBRS2Iw0/zMx3H8IHd1vPxdG95utulm2VMf439kTeyRklD4ORLS
   GsIdM2XM0RfBuTvlD+d3yS4sgHJAnxy0KOQzlSL2BH4rj9HjBPO1f36lq
   PFRRJTs3h3nMbAsfh2uu/g1Ye8YpFcDLxQuhFbSykloMFfv4QUKgTeJOS
   Q==;
X-CSE-ConnectionGUID: 3NL6N6sVQBKXnhJNzwRcjA==
X-CSE-MsgGUID: JdcFEuM7TmSBgIVOeglZtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25172323"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="25172323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:23:34 -0700
X-CSE-ConnectionGUID: ofkFhARGRFu49MPgHo/DBw==
X-CSE-MsgGUID: rHK32TmnQb+MQGnKxHggXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="41694961"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 07:23:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 07:23:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 07:23:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 07:23:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 07:23:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV05fm05GKaEd0CcPzjaUeU8C95Qn+E/KI8ZerfelkgCdBCM2yLIZLllggzZZN+VA+lOsLKcEnZWSs6/UAvPAneIJPDYQbRJunxFMxH2jLGd6RT5nuWoOjh5W9OokYd9SK4kGAAHbFov1kNakTHVa1oZ9NDGYK9mgw5G4uY9gEnw6hIX4LQIpNNRP19kH1xgwcLiIyQZsPen4m6goW1v4FiE4W8t6CVQomd3KYVTCbMegG+WQp7kwIszvBN0ygJKCxSJ/a1AULXD55fYlyc+MaVug1l8ukC8UVxiV7GSPf6++KIS07jkjd4Q8jgJ5Cx3aOVQXperNfPG+6BALGSv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeT7nOMwddahN206Ui7CfD0zr0RaY1PPfkZAG/5TNp8=;
 b=CLQ8BBXS7M6/65SnLvOkbA19uG92IZzc8bAMchiV2Zz5t3fnKZARX6CcBURlxMfaiG6iD16qer/4eeArDxpx5I8IUPQWhB4AA3D5DFRtn3DOKRgCLxqLKd3pdOaV0YqqIottLSyphG/yA6QSAWBMfAb8Sj2OnqJHJI7CWikFSrIhFH5sNSSYdlVZpKCQvd4j8yKY48DJlOlNhU07U6BYaCr8frkIyuDnALm1eucomO5WwW+YVFG/gXMT0+Fp47RHAM9IN/TP9aDYMz9my7yIel5IYnVNbXOBYgIS01UHeh7Cdq/i2KlhYaHsYXo33QBjAsYl3WqugnJfOb2smfrOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 14:23:28 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:23:28 +0000
Message-ID: <00dab591-0521-4165-a5a5-216dc9aa8d08@intel.com>
Date: Tue, 4 Jun 2024 16:23:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: ti: icss-iep: Enable compare events
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
 <20240604-iep-v2-2-ea8e1c0a5686@siemens.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240604-iep-v2-2-ea8e1c0a5686@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: b98ba8a4-2d8a-4951-8cb1-08dc84a1e71b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXA1NTNCZndaTWY4aVJ0ZjlEcEZxVTZyN1FIU2Jkb1NuVi82S241emJ1WS8r?=
 =?utf-8?B?VU40dk85NGd6NCtyMEpBWSsvL2ZPNkZzem9oRlhtS2Juc292QVZZSWpCaVlR?=
 =?utf-8?B?dDFsSm9MT250RWtqUnV6NHdLU2lwMHhGL1NUTStEZ1dDeFh1Y05DRVg5WFFy?=
 =?utf-8?B?NWhzUVlwUFJXc0M3ZThpaEJvR3k5YlZzVVdFL1ZQbVB0K25vOWpGQVlia1pW?=
 =?utf-8?B?U1dDUDZXMUt1d3dmWXFWNHhDRWFnSkxkUnRxaDVEQlpBVERHRlM3dmZBdnJV?=
 =?utf-8?B?RWVxaFNmVjd6cloxVFFNaFR1U0VWcC9qci9sd2hMbGowTDBzOGtLcmdBWGdm?=
 =?utf-8?B?UlIxRU4venVWbHNHWU1KNkMzUy9CekEwd3BjVGJIZFBaUEVhenlTell1YUU0?=
 =?utf-8?B?TUdtbnd6T2U3dnhqNVMydk9wem90YlRSM2ZqTlhiRzlKM1NybkFOME5acUx2?=
 =?utf-8?B?ZElhRG12NFdjNkZ0Z3Fuc1V6eTZIQjc5Q2VNeFdiUVJtbkR2YmZydUNMT2VK?=
 =?utf-8?B?NTQyclJIM3F4ckNOZ1d4TnU2V1VLOWhmK2xtQVdzNzZJYUhqMnQ1WSsvNWF0?=
 =?utf-8?B?dk9rbFQ3bDUrS3NDMTZZcnV1R050aXJHRGFTanhIU1J3anJhTm5iNFIxMDRp?=
 =?utf-8?B?cWQyWitEendCR20vRDNuMWx4S1poRlV3OHRxODFyTlJsTEVISkZqQjFVeVNS?=
 =?utf-8?B?T2pPQjNxTDVXWkYyZC94UktVUlh5aFcySDZmR01vZlpjd0N3dkZ0SUJWWTR2?=
 =?utf-8?B?RUJ0czIxL1Q1S3lYUk1kY2xiM2V5NEcvMkVJcG9Jbm5XZGdETnFlUGl5b3Ju?=
 =?utf-8?B?eCtIQlJTMU92aDRQYnZsZFhEZGYya01DdVVZS3FYM0FCRG9Sek01SGZydWg5?=
 =?utf-8?B?NGtaMzBZNWNkcmxyU3V6WE94cThlU2JIYmd4Nk90R1Mzai9nYWJTN08wWWRt?=
 =?utf-8?B?bU90b2Y1VTZkVGE5SHJsRGw1Ylp2THQ1V1lGUWUrUkt1T3hsN0UzemdMUWxr?=
 =?utf-8?B?ak1xM1ZwMEdKSlBreWJqK0Y0YnRlNXVRYXMzNDZqbzVMTW5UUitqRldnekNN?=
 =?utf-8?B?b1BFRm9MdVhJMVhCQUlYZEcvSkhRa0RKVTFoQVFtNE1IM0pwYmhobzdlbzQy?=
 =?utf-8?B?eGZ2TnRaR3FoOFpFVGlMRTRGZ25GYVo0TWpMQlJqRFBqWmc3SVpSWVBXOFFW?=
 =?utf-8?B?ZnVwQ1M5VEpiY1VtbkxVSytYQ0wwc3NyS0JFRkxvM0YzME9RM1dXSG9vNVpL?=
 =?utf-8?B?ZzJ0VzNWdVJiRTJKMTNTT01VNTN5U1FzSWFIb0lCUlg4RUZPdmNkOG9tbmlU?=
 =?utf-8?B?MDMxM3BxeEtsNGJhVGdaeFNiTEFVdGhMemlWbmJKVXNGSFYzKzhzYnBycDg0?=
 =?utf-8?B?eFVQRExRM0t2NllWTTZ5cnB0QkRYUTkyZG9mNVJMcDZtc3ZjNEk2MEJQOVN3?=
 =?utf-8?B?TDRxdWtLb29XMGsvUWJJaXhvWVhUK1VPZlIxSVAxR1l3SkUrQno3WlhkSm04?=
 =?utf-8?B?WUVLZmJ4TzFEak9hSW1LQlY0YVZnV0ZldUIrcUVUNktoUitXQVk0MmR6Vjgz?=
 =?utf-8?B?NGNUTkNPa2xCbGlNQlp5dFlFejhrWWtpUHlRYkwzR0FDSUNkUXAvQko2cVBS?=
 =?utf-8?B?bmQvZDF3ZHNFdHNxb09ZYXloNUhUY2JRb1B0YmxzemJHbmNvUDd1NWk2aXZl?=
 =?utf-8?B?VjU5c3Y5MHI1YWNoMFFHdGVMcXl5UUszdWZNNnhTU05xTy9lMldIdlVYcTY4?=
 =?utf-8?Q?M+V/gOoQqaKWmhNnkdFZSeFlVRDlKALAKxhFB4u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZEc1dQd0lEVjlhSjdxNXNnYjFIcTdNY3ZvOWdtV1pDYjA0MHBBTlRSTjN0?=
 =?utf-8?B?Mnd4YWNFWVowNHZOU2NFUzNiNytkVzZ0cEFXVW4wMWZjSmlkMzRQUzlVQ0hC?=
 =?utf-8?B?bTJpdEhTYUlpWWxQODNVUHg0dmR4R1doL0xubmcvTUJ3WDc2OStLUitaYXhO?=
 =?utf-8?B?ZDlFT3M2YjdTbXJvMlF5SFBJeDlOWG5BUkNybHFpS1ZhdWtBRWpyY1VDcEtv?=
 =?utf-8?B?RURPUzVhWXQyRndnS1hvZ0ZJVFVldjRHWDNxelF6ZmswN1ZKUG40V09vNUpn?=
 =?utf-8?B?WWpKNWJENEdHK2Z0OE9HOXd6SnlBUjdvTm8rU0dVZkJoT3AxRlkzQmhvd3Qy?=
 =?utf-8?B?OGlsei9jMzF1VnVhQktWZ08wRmpHSlE2YnhTRzF1S2RMQWFyOXpVSng0VG92?=
 =?utf-8?B?cWVxTUVFTENkcWRXVlZseXM0WGt1ZTVGQlM3cDJGRGZzSkNhbWNpZkZSSS8x?=
 =?utf-8?B?djFGMzhzOUEvZE1ZN3RBUytFdFZRN2Q2SGRZRVl0QkhIR0RMWktCNm9sSzVw?=
 =?utf-8?B?SFVtRWI0UVZrdlk0aDhQVWx0Y0RZZm9wMnlWNGxMZk0vd29pQW9Oa3psWG1u?=
 =?utf-8?B?WjNDdVRUZXZqUXFvejRUSXRWWFN3TnBWRzRaOEhoVHJpcGs1OTVReThoOFZh?=
 =?utf-8?B?WmpCOGdMOGNMcjkzbSttVW16OEtVbWdHTkVLZjYxVlVmT3dTWnVwcHJ3V09l?=
 =?utf-8?B?MUMxcmpYTUpkdmdJSG5CQkVVejRlZ0NMeWp3Tkp3S0w1Mk1pQXlSd0VBUFgv?=
 =?utf-8?B?dFFhM21zM2ZOdmFmUWh5cEtlbStrd2IwamREUW4rUmhQRzlORERMZGZSWHpP?=
 =?utf-8?B?RjZBL3NDRzYvMEVwTGlyclZnbjFVWjBmNWhubjh1ZXZEeEZ0K2FJWVIwaFAw?=
 =?utf-8?B?YlVjNEh0Y0RsbXBZdXhBS1BodWVmYmk5NkF6bDhJQWRRVm9oMkxRcHhJUTFW?=
 =?utf-8?B?bkhoV3BZS2tFZjVMcktrWVUwQ0dlUUJYWjArWU5ZTFNTSTF0NTJrQWlKUE5h?=
 =?utf-8?B?NlU0OENPM1ZHUHZZbXpVQlp5SVVtN29pQjc0VSt6Y0xDdjRDcVpVSzZWZUJS?=
 =?utf-8?B?OFRXNnJLeGQ2M3NSeHRNNVM4VVFJM21TSGpyOFNnc1FsUkdCVnBhNHZ1REgy?=
 =?utf-8?B?QU1IUXVDOUZHRi9PZ3MzVDRFelFIQ3lsdFA3bm1HckZyVWkvMUhpazlIcUlm?=
 =?utf-8?B?RHpUdm02RkZGR2s0bHhQT2VTVGU3ZWJQcmdEMzQvaTJOcTFTWkZFMlVvWFA1?=
 =?utf-8?B?OU5JMHd3VlFTZC9zSUx1MmYwZEhYNXlCRjRNNmJ2RkxpMEtCdUt4OGFWcGw4?=
 =?utf-8?B?WFU1anVWRWFmTURWZTlRTmEyUWtTcE4wSHBkRFRaOGlyZkFHMXh5aHZJSTZK?=
 =?utf-8?B?T3NBcGlacGNRbHB6QW5KNHBmYUhGQUxpQzlnRk0zaStoSGdHQVBuLzc0TU9y?=
 =?utf-8?B?V3Fqb05GZUp2OWxYdkRPZU95azU5YjQ1ZjlzN3dhMlg4UlMyVUU0ZzcrSms1?=
 =?utf-8?B?NmpTZGk5dFBJSnBEUHFyT05mODF0bHNLdERqY2tsSVQ4c2VhRGlJbjRicWJM?=
 =?utf-8?B?cko4dityTnc0QXBGekVIOHBaYUlVZjhWQ1BpamZXWUI0Uld0V0I3N21UQldU?=
 =?utf-8?B?cnVibXZZVFV0cGFwUHo1cXIxY21uMFptbHBBaGJOR3dOMmYzZDlLQURhMG0y?=
 =?utf-8?B?N0o3ZFV1YzBWTE9UMHgvSWM1bkl5eFZkdmRHWkM5cVp3RlRyUW9ZZVRtR3ll?=
 =?utf-8?B?dkJ6emZabXFzdlFRbUdxTGZtYjZvL0VhazQvM2FralZoYlRsb0NCU3R1QUQw?=
 =?utf-8?B?QVJyamhpU3pGNlFUd0lwTFBNZlpVTnZMaWJVcUJCQVNrL2tqQlA4U25KR0d5?=
 =?utf-8?B?RzBlb29iR2ttUFhLVzhQOUNRa3FOc3ArbFhlNGtCN2QwTUp1NEM3Zy9zYmZC?=
 =?utf-8?B?UGQ3bmJCSG5xWGE4eXBhR3o5Z09OQXpiMHpVS0VyWEV3M2VkT1NoZ0c1eEMy?=
 =?utf-8?B?UU8yQ09EbmRMa0t4V3pGa2pybFAzbVZUTUk3MXBmeXF0VWJlaEpKeHpCTjMw?=
 =?utf-8?B?bU51aGJtdWxwU2dYMnczUFh0WUJ6c09aTXN6OXVLdGtMaVY4d3EvaTNIcW9w?=
 =?utf-8?Q?rkl2PNUEwbNKNjLD+paKN+gXN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b98ba8a4-2d8a-4951-8cb1-08dc84a1e71b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:23:28.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9pgeQJq3moXixZ8sB0XkiwzKKCIO9uilL9vH/7M0xLOQKeK3OlGitF2piEwmLBg364AUxB/snziJ6s4S9WevxqbTSnFdLjyto0G+Lj4wjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com



On 04.06.2024 15:15, Diogo Ivo wrote:
> The IEP module supports compare events, in which a value is written to a
> hardware register and when the IEP counter reaches the written value an
> interrupt is generated. Add handling for this interrupt in order to
> support PPS events.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/ti/icssg/icss_iep.c | 74 ++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index 3025e9c18970..b076be9c527c 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -17,6 +17,7 @@
>  #include <linux/timekeeping.h>
>  #include <linux/interrupt.h>
>  #include <linux/of_irq.h>
> +#include <linux/workqueue.h>
>  
>  #include "icss_iep.h"
>  
> @@ -122,6 +123,7 @@ struct icss_iep {
>  	int cap_cmp_irq;
>  	u64 period;
>  	u32 latch_enable;
> +	struct work_struct work;
>  };
>  
>  /**
> @@ -571,6 +573,57 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
>  	return ret;
>  }
>  
> +static void icss_iep_cap_cmp_work(struct work_struct *work)
> +{
> +	struct icss_iep *iep = container_of(work, struct icss_iep, work);
> +	const u32 *reg_offs = iep->plat_data->reg_offs;
> +	struct ptp_clock_event pevent;
> +	unsigned int val;
> +	u64 ns, ns_next;
> +
> +	spin_lock(&iep->irq_lock);
> +
> +	ns = readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
> +	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT) {
> +		val = readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG1]);
> +		ns |= (u64)val << 32;
> +	}
> +	/* set next event */
> +	ns_next = ns + iep->period;
> +	writel(lower_32_bits(ns_next),
> +	       iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
> +	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> +		writel(upper_32_bits(ns_next),
> +		       iep->base + reg_offs[ICSS_IEP_CMP1_REG1]);
> +
> +	pevent.pps_times.ts_real = ns_to_timespec64(ns);
> +	pevent.type = PTP_CLOCK_PPSUSR;
> +	pevent.index = 0;
> +	ptp_clock_event(iep->ptp_clock, &pevent);
> +	dev_dbg(iep->dev, "IEP:pps ts: %llu next:%llu:\n", ns, ns_next);
> +
> +	spin_unlock(&iep->irq_lock);
> +}
> +
> +static irqreturn_t icss_iep_cap_cmp_irq(int irq, void *dev_id)
> +{
> +	struct icss_iep *iep = (struct icss_iep *)dev_id;
> +	const u32 *reg_offs = iep->plat_data->reg_offs;
> +	unsigned int val;
> +
> +	val = readl(iep->base + reg_offs[ICSS_IEP_CMP_STAT_REG]);
> +	/* The driver only enables CMP1 */
> +	if (val & BIT(1)) {
> +		/* Clear the event */
> +		writel(BIT(1), iep->base + reg_offs[ICSS_IEP_CMP_STAT_REG]);
> +		if (iep->pps_enabled || iep->perout_enabled)
> +			schedule_work(&iep->work);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
>  static int icss_iep_pps_enable(struct icss_iep *iep, int on)
>  {
>  	struct ptp_clock_request rq;
> @@ -602,6 +655,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
>  		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
>  	} else {
>  		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
> +		if (iep->cap_cmp_irq)
> +			cancel_work_sync(&iep->work);
>  	}
>  
>  	if (!ret)
> @@ -777,6 +832,8 @@ int icss_iep_init(struct icss_iep *iep, const struct icss_iep_clockops *clkops,
>  	if (iep->ops && iep->ops->perout_enable) {
>  		iep->ptp_info.n_per_out = 1;
>  		iep->ptp_info.pps = 1;
> +	} else if (iep->cap_cmp_irq) {
> +		iep->ptp_info.pps = 1;
>  	}
>  
>  	if (iep->ops && iep->ops->extts_enable)
> @@ -817,6 +874,7 @@ static int icss_iep_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct icss_iep *iep;
>  	struct clk *iep_clk;
> +	int ret, irq;
>  
>  	iep = devm_kzalloc(dev, sizeof(*iep), GFP_KERNEL);
>  	if (!iep)
> @@ -827,6 +885,22 @@ static int icss_iep_probe(struct platform_device *pdev)
>  	if (IS_ERR(iep->base))
>  		return -ENODEV;
>  
> +	irq = platform_get_irq_byname_optional(pdev, "iep_cap_cmp");
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +
> +	if (irq > 0) {
> +		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
> +				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
> +		if (ret) {
> +			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
> +				 ret);
> +		} else {
> +			iep->cap_cmp_irq = irq;
> +			INIT_WORK(&iep->work, icss_iep_cap_cmp_work);
> +		}
> +	}
> +
>  	iep_clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(iep_clk))
>  		return PTR_ERR(iep_clk);
> 

