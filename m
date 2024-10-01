Return-Path: <netdev+bounces-130973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668EC98C4E7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2397628450E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B81CC15D;
	Tue,  1 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emf+QEld"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFA1C463D;
	Tue,  1 Oct 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805251; cv=fail; b=e+w151VLTK6UNfCZr59zSV01IetrHK/wOjoPBpa/9/AY8XaMhXCNpuGzFBHvg0IeY7jsxaPwKVFK+2m9tfatS0oFfddWilHtl5RvOlLoNJKYa4wURYrRvW0uYgUGLbN/iapA8szjxVntcHcKDhLyOvrjVSFbwALr8BTIJOtatac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805251; c=relaxed/simple;
	bh=IW4DN5Jk1k0TcYOrM5XwfNEYnAPxh28Xok2NH6ee9a8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6HXuVNenQQXLaaAicY2F0TMsmDme/E68tn/jHl1uGWrK38BB/hY7WeVwHMjl6sgC1Nke1zvpg1JjT3gKDLRLRtuyYwIXc61lDmDQnbOY17TKNw7gFhbIGpgQA+iODJoOx2c6EfTrRz+o3IyNF2vTQfWFzhZfOpQLV6jXu8qZHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emf+QEld; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805250; x=1759341250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IW4DN5Jk1k0TcYOrM5XwfNEYnAPxh28Xok2NH6ee9a8=;
  b=emf+QEldSlsl0yFysA2lTh6XeirpUG8/95RqI45uYZz5Zy0HdWRdPKyZ
   0vgNN5rPYrtAqoHFZSUl3blzI6P8Kdu2xv3Lgj9QqHL8+pVOm0BH5qjYr
   KLhl9v159/30+cA7zqls932h6lAbBTorOOwUFzSYi6hPSh6f18uxoK5Tz
   QJi2aqp3NaEy/blKzequ+FWhUeV5We2Ej7uo5U7j+PRcQySkF1rIHZn0+
   bFO0bWnqNk0fi2YSNSx/DbQmZFTIX/4o2yXiOhPHh9bc8MGYAI56JyTQI
   oKfGZBOCyhbkow58IRisZ5PIqXtkJ94U1z/HbFdoRaokJAw4vPfAf25mi
   A==;
X-CSE-ConnectionGUID: 07eAsThrQX6cI9DNOln3Bg==
X-CSE-MsgGUID: CsQOoA++TMGcFgr9TkV5uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26839007"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26839007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:54:09 -0700
X-CSE-ConnectionGUID: hBegrxRFR+WXqlmThqLiNw==
X-CSE-MsgGUID: 90x5j5RGQlWf2vx2aGldSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73354703"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:54:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:54:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:54:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:54:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuayj281mhew7ZJQZ83U4MO1houPNLubp+YRmnIEVdeq0QF4se83ftMyJhEvSaTUl9V7nnFUhHM7Mrl8buMqjuQSGWs8TEjcvcmYFTYMtqosX8Ae5nJ4knH21BhknYUIHxWbDcEHZmwrwZSj3MUCj6f7qOu7IfmgOBGhbOmwsAq7UGWwVP4vF4t2S53Zw+xyst8RQs29xbOzY9Rfz9poco84n/6SIsikkFIFrWBtGB68VoRCpJaeCbDV4qrx9wKsKbTewPumceXxIapdpQYFu87jbJdMyuX2SIINSlVyCfOKuXlDdUS9V2cJt3ZzKONM5NPkgaW4QvkonuHFKeJxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW4DN5Jk1k0TcYOrM5XwfNEYnAPxh28Xok2NH6ee9a8=;
 b=stsv8GhwzVg9m4Q+esnkFrHhtwAGb4j/55jUB5vKoNjoq282KZYZsT0137qov4ce0+44286zlda71qDgejQZOniVfcGetmoJ4t2gpXIdHFZ5AlIRdieAKA6fCal0noPoEZl2TdnVfdbCjD9cnz8Zc70T6NkSlEUkSG7tihZPOjt/NfJTdWq+Ydpmsb4hcWVSqetyMHkaN9dWhoUuOSv6bliKmLqW+zpPyGPPRv3156iPTZIZWGarnKJOGBgvKLxjIBkxOV0RHvKwSXjco7s5VCI2DppMfbcCrWk+T0ipvRrh/zajrWYZZxn/148mgKt9BpQTKU27MNemPyVy5VDU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:54:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:54:05 +0000
Message-ID: <0fc3df5c-6160-4eb6-b2fe-5efa99337e6f@intel.com>
Date: Tue, 1 Oct 2024 10:54:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/15] net: sparx5: rename *spx5 to *sparx5 in a
 few places
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-3-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-3-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a848930-0e5c-4ed1-792b-08dce2420a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXV5V0YxUUNBQURaK2JENWxNVFNCYlJ2S2hNTjNEK2E4UU13TzYyQkV6eVpX?=
 =?utf-8?B?THNzRXRtV3R2ZCtpeHVyc0hyeWllV01BZ2Y3eHhJUm5JZnh1K0FzY2lWNlZt?=
 =?utf-8?B?K0V3RUtkRHRXR2k0Tkp0cEVJRFBqZlRWVWh1QU1GczltcU85bDA5eHdKZHhr?=
 =?utf-8?B?SkVoM29YTGdBOEJyK1pSV0dFUVBTcytra2V0UEZJL2s2OXpGVXJ5MXBHMlpK?=
 =?utf-8?B?SkNvTncwbVdRUDd2bi94L2pzbHF2MkNyZWIvb24yTS9YZHl0OFp4b29tWGtY?=
 =?utf-8?B?K3pkNi9rK2xjb1RzdUZKK0Z6WWxuZTBYcFQ5SHcrdXg4dGNaWnFjcXluWnNC?=
 =?utf-8?B?RHFFektlN2FOaHN1NkZSYmpNYjlmK1JXT1FsSEpPSjZrRUhaZ2dlbXRzVFRX?=
 =?utf-8?B?cjNweEo5TnlsV1lBYThXeEpVVGcxTi9FVndIdFpaSnpEWHlFeHRpTUtlUXNv?=
 =?utf-8?B?Yzh5RSsvZlIvb3hhcTNsRkprYnorbzMwQ3N5R0pOelFMdFhTamt0M0l5eExV?=
 =?utf-8?B?aXM0ZFQyVCt5YUFNdDBiVlZtQURCL01aN0VDYlU5QmxsU2x5Q05GV1lvem9X?=
 =?utf-8?B?Zm9uSGRTTDkxRDlrWkpUWTdnLy9GVHlvT3BNRWVxNlFBUlVFRkJ0elMyMnho?=
 =?utf-8?B?eVlENHZqbzhQTnZWR0RZcEQxZVFtVTY2TCtqblp0QS9ZSjNpQkRKaXZlQzNp?=
 =?utf-8?B?RHlWcEZwWVRrY0Y4VGpZSmdvQW44ZXdDVkxneDIwbWNNOWI5T0JUdk1VSmp5?=
 =?utf-8?B?Y1Q3UDBPdlhQb0NaSVpoWHk3aVJDakJJRXBlQ3JmbU4xaVhrWTRjQUlmQWRv?=
 =?utf-8?B?M1BoKzljWjY3MjU5WnJUR0pjL0s3cWx0eS9ZSmdPcEhYK0FuNkpPN09zUmR2?=
 =?utf-8?B?TjUwUERHQTVmV1RwS1ZMMkdxakpzaDFhMUU5VkZVV3MxY3VSUkFuLzFmS29Z?=
 =?utf-8?B?VjJNdERoUitMaUlGRmhCM2FiYVFwSktSNE1Pa2YxZi9jT0FnV0ZoQ3JYUEJ2?=
 =?utf-8?B?ZHBJUEZWMXF3M0NIb2dLcnU0RlE2dDY0ZmhjU0JxMkVLbFMvYUVPeXp0d2JS?=
 =?utf-8?B?TU00aHV0NTFOYlZBNGo4YWNZR1FNZEJ2Q3FzS1ZPeUhqbFcyOVNwNHZVQmVL?=
 =?utf-8?B?czMybFBHRkVUTjh1Y3ZlNVBMc0NrVG1aTkprOWdFYmlUOStNVEhNTUZiT2NK?=
 =?utf-8?B?Q0lPbFFDQTdSUW54cVJJN3BSQTVGbUIrMHZQcitSMHhuZXlvREFRSVJXNDNV?=
 =?utf-8?B?Wm9GMWlRd3IrR0w1N2NKNFM4UGxrWnVndWJwWGpWSXRMeFkwSkJWam5UQ0Vu?=
 =?utf-8?B?eTI5MTVmQkdpQXh3ZllGdnNHV2V3VzBhOGVhaUtEZnJIZXAzVlBxckpkYmYy?=
 =?utf-8?B?Z0xRYUhyU3I3RjlEOUpyb1hMdlh3YXB5cUp3bWY0d0ZIYnpsVDk5bXNCL3kv?=
 =?utf-8?B?Zy9PRkR6NUkxcU9xSno2V1NPd2h5NXVoQ3NEMlFDTUhIZnJublFPczAyV0Mw?=
 =?utf-8?B?eUNRYk1jbTI2SWRheUNKR1BxVXZBT0pRRHRaTUNLTW96eTVxcVQrYmJud2NH?=
 =?utf-8?B?VUMvOStHaXc1WTM4Q3EwbFZ1SGpFWDhldzBuaVJTUTZmTXI2bDVKNkIrMTFi?=
 =?utf-8?B?QjM1MmdRMm9mc1Zjd2U5ckhOdktrbXpNV2lCWGRVV01yV1k4aDNicHdmWER2?=
 =?utf-8?B?bkUra25jZEtXVWY5MXdPMTNRZDhUQkhjV2RKTXpPTHFEazVlaitQQ2VmbU9W?=
 =?utf-8?Q?K4yE5otyk2/IP+/0JBaK2lLYKPMvIGdfcAbGGA1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3h6Q2IydVJRejlibTBZMzZKQ1FwVWpBb0h0MDBaT0FjbzQvTkJmamViVmhl?=
 =?utf-8?B?Zm1pWGd3RjRqa0xDQU5wRStQcmw5bmFxVjNyOEVWRm1xVjhjQUZJK3d4VWQz?=
 =?utf-8?B?N0VwZnB5RmhlakU1M2ptaURtTG1DYktzVU1wSkRLT0hiN0tFcnNrRi9sOWlX?=
 =?utf-8?B?ckNEdFBqR0ZCV2s2cVhKYTNFQWloRUdBTWJseDI3ek0relJQdFVmYjVtREQ3?=
 =?utf-8?B?RDluYSs2QmVqY29IMGZmSTh3L1JtSUNWcnBPVHI3SVZZZ0gzdjhOQXVub3RS?=
 =?utf-8?B?cjhSdFlINFlyUHZqZDNBOGh0OG0rMjNFTmJBQUkxMk9QM1NmUlZpeTFuNEUw?=
 =?utf-8?B?VUtGa2paZUx4UGtGMUMzMkVXcFB1aExNOW91V1NPbWlsc2xwMlgrYUJaZ21U?=
 =?utf-8?B?RFgrK1l4dFE0V0loMXNrTkd4YTRvQVZpL0NOa1VHRDY5OTFJQjhYUUhTSVZ1?=
 =?utf-8?B?NHNyUWJYKzYrWVI4RzhpMWp6Vy92UURPdFZ2MWltNjhJNmxGSW55REh5Mm4y?=
 =?utf-8?B?TkFSVWRreWJZTk1XMnJ4RCtTMCtxQjdmWHlPbTFYQlllQVNKWTVrUURac3d4?=
 =?utf-8?B?ZzB0cGlzMVFCWklNRjFQVlI2eTgyZmtWOHpxaU9sUVJsOFNXbG5nVCtIVjk4?=
 =?utf-8?B?VmViODlkMXo4bTRVWlppYkJuT1E2bjJEY1VtVjA1TkVUYURVQ210TEZoS3Vu?=
 =?utf-8?B?c0tIS2dMbE5TNk9wREhvUU9lUUUrVzJYbzdpS1Zyblh6SUVNVnhkL0Q2K2tt?=
 =?utf-8?B?Qys0b0ZHLzd0c1FVVWZhc1d2NDBkZDRMbFhMZEsraEV2NlVkb1pVc0xlY2FU?=
 =?utf-8?B?N3FlbS9VdERLUXZSVmtNRnVTeGI4SEJzcExHWEtVOWQ4czNkWUpPTEFsaWxE?=
 =?utf-8?B?OTlmd25ueXN3a3ZGaU9OdjNnYlRCRityK2xXNlpGc3ltN3JyTy9va0o3SkdH?=
 =?utf-8?B?c2JrY25zdVl0SE9wNHlQdktoaHM3ZVZPbDljVGRSZFFFTnNaNHd6NC9odWc2?=
 =?utf-8?B?OWprY09FZUI4aWhyL0ZCTzZCc1FyelkrMzJOMG1ZcGFPOUFSbkloTDI2MUEr?=
 =?utf-8?B?SkMyaFZVeHFBZFl2bk1wN0dBVWtWTVJ6TjdOclJnekJ4aTV1dXBVZWh0NFdq?=
 =?utf-8?B?NkppVTA1aW9lZHp6bTdQVUtLNmpXMnRNREZLeUJkeU9SaVVGTDlmTEFEeW9D?=
 =?utf-8?B?TEk2dUoycVExdWd5YVVoKy8wODNTb0krcmcrTGJxcTJqaU9seDd4VDZHQ1JX?=
 =?utf-8?B?OUl3Skk1cXpTZHFLUTdxSEthQ3VCRUV5R3AzRUFQM2MvNGxXbzM5N1V2alZa?=
 =?utf-8?B?MDJDalR0aFY4c25MM0hnM2xtRE9IVFFjamNBTUhCS2tlZlNEL0p2YjZaQUI4?=
 =?utf-8?B?ZUFVUmtxeFhucTJEaWhLYXN1OHZ4Z053cXFOL3BkdUM4Qm13NFZpL296bTQz?=
 =?utf-8?B?N3NCbHdDTSsvalpxamlDWk9sTlM4WWI5cmVsWXJLVytSUDc4cDNEYjlRKzBD?=
 =?utf-8?B?WXhlZkpOR0l1aUp4MDVETE9QVmFWODFuZW5rNTlQay81L2ZFa1VGMFAzTy9D?=
 =?utf-8?B?MjNjWHpjRExzam1KQStmNjhnbkk3SzEvci9uRWlMdmVTakRVMkVsdy92azhT?=
 =?utf-8?B?bUFRWU9kSitsUGJrQ0NNRUwxSjh6SjFPTlRYM1BwREd2ZlFBT3lVTnkrcHJT?=
 =?utf-8?B?R1krdnZ4TENLYTVpQnhCYmFaOW4wbVNqbFkyNGNkUVBGVXloRW1QRmVKcjV1?=
 =?utf-8?B?ckZzZTJBLzQ1QnBOZHRLTlZHMmxoUkRvTzQreVZPVXArTkdlQ3lqMUVsRlFv?=
 =?utf-8?B?U0U4WjhmdGJrY2VkeEVNTzYvSzJjZVFSV1RTbDRrMVdueGpjUzFPSGxtMGU4?=
 =?utf-8?B?ZTRYZHVlQlZ5VDNJR3ZSWVF3TUpaMlYreVBKZmtxTEtGd29MazVJZEhqcjZZ?=
 =?utf-8?B?eit2R0k3THRSb0xqeGUwS20xVE9HemxXR21CWlkzQ2d2Z2tEYXBCdC8veE1S?=
 =?utf-8?B?QS9PQWpUT2RhdnJDMURCbjd5c2c1Z0J1emhEMzNhSFVpSlBHVlEvYXdLYThW?=
 =?utf-8?B?QjRKcDQwcVdqenJzdlh3T3ZrdTdMRHhYL0RydExUaGJ5WEJoR1FrTExtZ0M3?=
 =?utf-8?B?RUF2NWM0ZUx2M005c1hxSzIxNG1kY0xEcWMrZExNdWgyempNZzhpUVc5TUVE?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a848930-0e5c-4ed1-792b-08dce2420a63
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:54:05.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGuZEVhRD0xutSgviltNYcGKlo7h9ydE3RVcOKPFQe7JR4lEr+uY0OpwPdhziwW6Qv9Ca5d1y6vVqsUpvVTvwL2vSl7XSMYUEKUkPU81zHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> In preparation for lan969x, we need to handle platform specific
> constants (which will be added in a subsequent patch). These constants
> will be accessed through a macro that requires the *sparx5 context
> pointer to be called exactly that.

Another place where macros implicitly assume some local variable? Not a
big fan of that, though I suppose it does leave shorter code.

No issue with the renames though.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

