Return-Path: <netdev+bounces-111628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE3931DAE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D29B222AB
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30013D24C;
	Mon, 15 Jul 2024 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AggwyFDl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5FD208A9;
	Mon, 15 Jul 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086673; cv=fail; b=iEfK2FETU0b+ghfURpoTsUwJtkog0MCVl+TS3X0w2tz0l0XtuEAerJJzf03W2JP0ED+fDOEWZ3PcOPzYWnjtZOTPqiYf6AI9FUMcs9xbCFJLnrEX/zITlwzJ3lg/kgZaEYCqZUFYuIhJQ2oXmAlavsNHHBZJ/HYk+pXTYrIwf28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086673; c=relaxed/simple;
	bh=WfulsWBd0BW44ywgXxFxEAtJZ2geUR4nDofrA/SKdJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXLQzgUtvLTjae+R8bxw3p+vQP57hauo48TWKYJCr5fyjMkvL00utk3/Dqlc7G2iyZlBCGRr6AWSlz4Go0L2iMD4Fxskk+gJXqHjKLANYOLut0r2lWbh/La6kzdwmv+jT/TtHKHlKEeTdOW6MU7wOOHwtq9ZNfVk/CIROMqxPIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AggwyFDl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086672; x=1752622672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfulsWBd0BW44ywgXxFxEAtJZ2geUR4nDofrA/SKdJg=;
  b=AggwyFDlQstscS8vNfBVF2VeSIj0KO7y6DmjqicBy4J721rvcke1C61E
   LP06XxIxqF4m3Ng4j0zDtisYZdyhlCMr+8QU+MolIc345aPZAF3g5fFmt
   LnHgOcTKXOebj4ssKMINNrmdbDdHimN0VLu5JQt9incmY9KEmL8Zz4ZKj
   MErA0mchNc/q8F1ItuiMAZGrWFBIXzz+qKKPM2nJbIG2TQxgOClZrESqF
   Uwr3P6kzYfcXxbViIFSwm0/E2r11FahOFfzIlCu/gOEPXNjbipcMNR022
   zIMboe4DvDyFepAmVcZ9sMzD4sn/dfWqGW2ZOrrAO+IS6KXKXr3lt+9w5
   Q==;
X-CSE-ConnectionGUID: ZG6YxHqlQkylfdCUWaFRrQ==
X-CSE-MsgGUID: VBNNVjIzRX227hKNqiz40A==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="22307349"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="22307349"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:37:51 -0700
X-CSE-ConnectionGUID: IZNeS5mESFy2Dt4fdMnZLw==
X-CSE-MsgGUID: XPrKXuEXQgm3y52BoslZzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49747659"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:37:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:37:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8jKJ3guFxPmesk8JeDEBNlJOovsqxnZ0kF2EC27ArwfTU5QkF/5paLBJo9CgtPKYTdAM+RGhCiAS9JCx6G+tK10A3Wq6/rkMgMc0j+FUOIFT2bVNXMiDaPmsHiNbqj9tw4OgsooNuGbrS4fWCY32l74WRZo+2PTYXid/XlyqIUCtjRTdGbYmWXWCG5mY2SGJbSlS7fxoSd7z5wORNkpNUlGGQCQhucY8sLqR3Lx8JpRSRgaDjPWpSUD3CzyE9GZdOozNIda9ADIIsE1Fp6qkxu1It89u7n6zwIRNrKPlqPg0fPNwSH2vg/NrS++9KQVgqX9GEWyrRS27y0g65CZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXMiDDQoZDtE5XPkETpdn/0Yglr+NgVa1M9D3718QW4=;
 b=GS1ju7Tbr8fAU5eMAtZ6HHmMRyB0oKtCh7VBruWIGtYFa9r0rGl6JgUOyrVwUXX/s5k4trF/zXIoHzCQMY1Leyqyu/HVfSjNQvIxNKOGub/BAjRM0+io8lMtCzNPeIy1EebG/M6/YcqV9nieD/+HUO1kIzgQojgxiTXH8/C2EWB6PVUWvSmKzO1cbVQ4SCa0s4ceXdfpZNILvbJddavAummnNgsJwGbw3xvRDQ643982baepx8Zg1f8bR1HC2f+sYb3Ku0WolG2FSHRIMu9aQq9PELju7Ti+8Vbzih6UOVBM0eRbjZrFejAfXvy0FyVq2CLDwkYs0kDfogmIgBXoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:37:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:37:44 +0000
Message-ID: <d8468522-23a9-4614-a246-d5a9fa2d0374@intel.com>
Date: Mon, 15 Jul 2024 16:37:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 05/14] net: net_tstamp: Add unspec field to
 hwtstamp_source enumeration
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Radu Pirea"
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon
 Horman <horms@kernel.org>, "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	<donald.hunter@gmail.com>, <danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-5-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-5-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 29464529-9eb0-4d02-23fd-08dca527200c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2MyWFFxcWloQ1E2MUZhQ0lyR2ZLaWtFUEZqQWF2Z0h4ZkpQclRPT3ozT3I1?=
 =?utf-8?B?MEE4U1ppb1VmRlBpSFBxOG5sZHk1VVB2eGJaUXZzc0tTamVyKy8wbGMyLzd6?=
 =?utf-8?B?bDZuRDQwZVRTenk1V2JIQzlFaHJ4SkhPTUVDUHJINWtKQW52ZUZrNDVFZURp?=
 =?utf-8?B?U1F1SVBrS2JvN01lMUN4NUw4aW9kaGRyS2M2TCtmaHVwQ2JtdGtHclc5eDBJ?=
 =?utf-8?B?eDgvRzFtdDRhTmFLZVAzcExGTVh0Njk0L3NPOEVNOHhHK2krMVBhWnIxMkla?=
 =?utf-8?B?d0dINUN6TGVEbldJUVlJLy9Sc1M5Mzk5Ni93dVlabS82Q0diNmVEeXc1NVhS?=
 =?utf-8?B?aHRMUXR1NEJGK25KRnIxSXZHMy80T1M0RGxrSUJ1V3RJTzNObmVOS1NYWlFB?=
 =?utf-8?B?SVowS04xKzVPQTRJYkNkUUV0NDBaSTlqQ1IzdHpzaEhSTnAvd0FpdU14UkRO?=
 =?utf-8?B?ZDlDNmtGKy8xUlRsNGZHckZ0Ylo2cEdqUWhCTFNWWWt2WEVzTW11bGJncWNG?=
 =?utf-8?B?Ym5Pa1h3cXZybUVZWkt5YytFM2ZLQWI0ekpmWGJXTC9wOUpEVi9xZVZKWm5j?=
 =?utf-8?B?NW1jc2dCVkYzSmhmYlgxN01CWGRiOE53MW5Rd0FoSnlCSmRPY2dIOVJsVzEy?=
 =?utf-8?B?REVzZ3VSVzBpclJuNWFNanczWUJrOEY3bGVHSVlwdllydkhWUjRLclo3K0x1?=
 =?utf-8?B?c3haMEF6eENyS2lGZitFdFo4djF2RVYvQ0VZUlZYb29iY2dTTlhGWElmYlJh?=
 =?utf-8?B?cndqcGxGdXl1Zms0eFNpNWlEYlVvQVFpVmFHQys4RDhnbTB4OWdoRXVnSzRU?=
 =?utf-8?B?N3NSdzh1cnkrK0JudVJEaU01WHFCcndBVjlveHozQWIxQjM5QTJtNDV1NGZa?=
 =?utf-8?B?R3BnVC9lMDlEdVlHcXVGam1xV1puT3VOK1V2OVNpM0diVHA1MVgyYnNURU1v?=
 =?utf-8?B?ZE1wNDZpcG40YlRsQ01wZUplMHc1UmljSC9IWTMyYlpEU3UwaFZaSUZWRURG?=
 =?utf-8?B?NUNyZGQ4cmp1M3JOVG5sY0NNRzVhWFJOakVlK0VtZHVLKy9rd2xQU1BjZFZz?=
 =?utf-8?B?Z3FnZUhEUDdqOE4raWNFMExiNm91Wm1rc1Q3akEzYjB5b1l2MVM4Mm9FMi9S?=
 =?utf-8?B?ZFZhVjMvZE1CWDVER3lZQ1FmdFdZbjRVb2U3Ky9YYWtCbkRYWEpNMCsvVXhN?=
 =?utf-8?B?U2dNbU8vSHNqbU56MnZOL3BzU3M5UXFOSzQ2QW5GS3VWSEYwV2NaMTZoWEhh?=
 =?utf-8?B?Y21iMFdHRkQrMFBDbGRrcitVUlFrRnNkNlNxOU5BUHhJbXZteHVZRG5IM1lk?=
 =?utf-8?B?c3o2Q1NSOXpkWVQyUm1IRUJDeGNLZmthSnhicHBTTXVFNjNkWlkrVWJxWXVG?=
 =?utf-8?B?eDltU2pMM2Mxdms5ZDBabXluNlpKcVJ5cFZ5Y0licGZLV2xoOFQ0VVZZQWpr?=
 =?utf-8?B?eUlUVWI5Mnl4eWlHa2hlcUYweTNFaFdKdDlESUpVRHFIQjRqMitpWVpTNCtR?=
 =?utf-8?B?enAxMzVrM0Y2dktuWVViRDBKS0JnZkNEWkpUSTgyNFN5Vm0rN2s1UGNzZjJp?=
 =?utf-8?B?YTVLMzh2NEtiVHVsZGRueHcxekNvZ2FPT1kyNHBGOFNGdTk0VjN3NG1pQ1hz?=
 =?utf-8?B?ekw1cWpYUDM3MHk4RlNjWVl1K0h3ZDg5ZkdTUVdHTEVPRWNCZGN4YUpQbkJT?=
 =?utf-8?B?ZG5teDh1NkMxVlA2QUt2K2x1OGRhQ1VSenMyaDM3UGhnQkgvaExNZE9oN3Ri?=
 =?utf-8?B?T1lJellnemFpQWVUOVkxSCsvbmswL3lISVNCblZMUmVuSDBHbnBwSTdDZ1Vj?=
 =?utf-8?B?QXpzV1lMckhvQjNMZ2VJRENVZzdnTnUzcXhESGlsSTNOM2JjbWllOHFpTHJH?=
 =?utf-8?Q?TePS5t32zPczl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZQNk8wcWpUWUdLa2x5cUJKMktFbjJvMUd2eEx4ODJLWk5XZ3RKUUpqcVR6?=
 =?utf-8?B?Z1hkWGxYYzRobVMvaHpjRzRHeXJIckNINXNvQkxIM0VjZ3ZtcWVNeGk0dFhs?=
 =?utf-8?B?UjVBYUlZUksyTFJYeFg0cVF5TjNFc05BSFBlR0NJSkJtUTgwOVJPaWUrRzZD?=
 =?utf-8?B?NFh3TXV2czgycFRNeGR0QkpMUXBhS1h3VW4zRWpid3V1SlhuZDZHbStzTjZx?=
 =?utf-8?B?WjFhSnJqMUN4VjU0N3pZSTJURnBSb3BjdCthRDBUT2lPMW1rako2Nm4vcFpt?=
 =?utf-8?B?dUNMTTlXMUJpc0MxYXExUmRHUWpNcmRXaEZVM2hXaStZV0xvM2UrNDZmUmM3?=
 =?utf-8?B?Y2grZWQxTDU3ZlRlSWx5K2k0UUVXbFNONUs4UDRQQ1ppTWZXS0RUcUh5Mk9l?=
 =?utf-8?B?QkJKR0VvSklDUDI4blJnMSs0aWNzLzFJallzK2dieTcrblRUOSthSTZscjBj?=
 =?utf-8?B?Y2FSbGV4R1lBSHF4UDQzRUduZGNkdk5pWm1XVUptbGE5Z2szcDBxU0tsV1Jo?=
 =?utf-8?B?RnpTdUs3Ty9zTzVVTGM5SjlWeWMzK2ptNVY3NWlFWUlKUkFhQlZxWVN6QXd0?=
 =?utf-8?B?em1lUnNJRWs5aG9YREhZMXRmL0tnUDA2Y2cxWUpKaXpXSTZRQVNiN3E5OHQ2?=
 =?utf-8?B?ZEE0Z1FVMVpyVEQxZ2Q5SmF4OHlacEdEZ2t2MDUrdDRlMjRjcGQ3dzAyVEhy?=
 =?utf-8?B?Wlgxb25sRk84ZzFEbVF2VkErSHk5SnF1WS9kbDRwRGVrOVFQNkxhb2ZhOEV0?=
 =?utf-8?B?RlBjYUErK2prZ1FUTXN0T2dLd3lGby8zQWVHZ0VnbTYwUzF0by9NTGpFcFlZ?=
 =?utf-8?B?bjRHaHRoOGFhQWZ2OGJzakJGK0RUY3F2VEtGQ3cvalZHL0V3dWtMdGtNWHBu?=
 =?utf-8?B?TDBtZVhmd0xZczM4cVVtVlV6WUpYTWVsd3NIZ0crd0N6NDZMUFA1enNPNDNa?=
 =?utf-8?B?d3J3QVdVZTBqRVV0VEU2eUVwZDhTcHZ5OHZZYzR6bHBxaXcyVU5ZeVg0WDUx?=
 =?utf-8?B?VUhVMDRJbXNxb0t4VkRsYzNHalM2Zi9jRnlFc0hkNU5wNW40T0xNaDJYalgy?=
 =?utf-8?B?emRUMHd6OEZIT1ZCdVFneWRIZVVOOWwydTJUbU95WjlsMmt1OVN0QW5EWWFL?=
 =?utf-8?B?VllVYnRRbS9lL0Yyc0hRUXM5RnBVdTR4WTV4TkxQRWM4VERjT0NnTGd0SXNQ?=
 =?utf-8?B?Y2M1ejVsTlczU1F3c2FFVXo5czlDMGlLZGtTa1VPUkg2NXZSUXNZY0lteUEx?=
 =?utf-8?B?T1JkRGliOFpjcjE5NTZWaTVJVHRWTHROdWtsMnI3K2VmSE5nN2Jza3N0L2hy?=
 =?utf-8?B?dWFHQ3JUN2xXZDhyR0laUWJXejVMcVlrR2t0WFNwSXRkZDR2ZTZRYkgrcElL?=
 =?utf-8?B?Rk14aDh3WERSRDI3ek1MU1hOSWlySUJIdW1ycEVmVXprakhvYUQxNjE5UDRt?=
 =?utf-8?B?aG1KL3lBbGNlV293S1JPVnRKZEVDaVpJYU8wK042VXhIWVBIbzJQVytBZ3dC?=
 =?utf-8?B?eXdzR09pZjZtMEQ5dUN1eUova2liT2NhS1p5dHpxcXRYR0JnY3B0L2sxR2h0?=
 =?utf-8?B?NUJmV29qdktuMGprYysxYnhLd2FwTEt0UGdjZnhhWGNMZzhxZThEZG5uMm4y?=
 =?utf-8?B?WkpFRXBjaUZ0TE8zVWJBbTJCcTF5MkF6MHdOU2xiK0NBZHNqa1BRcll3Rktt?=
 =?utf-8?B?enJtTnFsaWtiTjlLRmYxZVkzbTNYa1N6ckNtTVN2UHNyQXlFT2lLVERuejgz?=
 =?utf-8?B?Q0VseXp3MUdvenhLRlRPeW1mbG42eEJTNjA3YS9ub2JuWTcwMGdpaUE0QVAy?=
 =?utf-8?B?QUtLYkxtWGx4TEd2Uk5ST1EzMnpYQ2FPd0dLMDI5YTdUVW9ETkF6V3RRNWlh?=
 =?utf-8?B?VERHWDBON0ZPQzRvQzNrVFRLaWxvNUFVanlVOXBXUDNPbFRMU0EvTko2TGY5?=
 =?utf-8?B?c3g1Ly9vS3ptN09zT2owL2xCVSttOW9MNWlsYWF2YmRDdFNTN2IrQ2h1N3pU?=
 =?utf-8?B?dFgrREpnRFErZSt0UXd6d1JGZ3dRN1R1aWFqL21uNHBxQWsyT1ZXZlo4Qndk?=
 =?utf-8?B?Um9ZeklVOGRYdTdiVWNuUEthOGJSN29WZnVaR1BITk9ROW5pSUc1TTN2OEdS?=
 =?utf-8?B?Q2Q4NGJoNUI5UmRTZzcrK2VCL0ZHSytMTTdLOXRJSDFpd0JOSCt0aUZPMWVK?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29464529-9eb0-4d02-23fd-08dca527200c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:37:44.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjgXLRL8iuzUTI6Xr6yLlSNlOgD2+wIZt7j7uT4r3MKEPYHSbCW7xRv3iq4s9OXZcWsBkNbjSUL0bBcZggktpDBnyl6pc4x+ZL2tPfP2JiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Prepare for future support of saving hwtstamp source in PTP xarray by
> introducing HWTSTAMP_SOURCE_UNSPEC to hwtstamp_source enum, setting it
> to 0 to match old behavior of no source defined.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Change in v8:
> - New patch
> ---
>  include/linux/net_tstamp.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
> index 3799c79b6c83..662074b08c94 100644
> --- a/include/linux/net_tstamp.h
> +++ b/include/linux/net_tstamp.h
> @@ -14,6 +14,7 @@
>  					 SOF_TIMESTAMPING_RAW_HARDWARE)
>  
>  enum hwtstamp_source {
> +	HWTSTAMP_SOURCE_UNSPEC,
>  	HWTSTAMP_SOURCE_NETDEV,
>  	HWTSTAMP_SOURCE_PHYLIB,
>  };
> 

