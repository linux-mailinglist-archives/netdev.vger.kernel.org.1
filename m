Return-Path: <netdev+bounces-132908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6728993B6D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0586D1C22110
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3CA18EFC6;
	Mon,  7 Oct 2024 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naL5y3WG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975D18C90A
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344996; cv=fail; b=uT+j5eOxF7uDCaDtJHyHIRrtb9Aoyf0q129sLBnR5saRLbPucywIZ1+B9LUOifwsEcH8eOdrECBc2t9zVyqzjnmW8VPJIHBjcFTUwzwC0JyJgyMGQq4cD62aQb4gCHXMpll9uu1e/ifQExoOjQkWJnsnLIG/P/47j8uo8hDbvP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344996; c=relaxed/simple;
	bh=MqdSHegVGuwV7Vw1v5+pDBGKHL8NywHmuZ6pfb2fWeE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTP0whU07VVcxPrJExZFXwuZlBa9dzWlQXj4dT1XMaeGuQY2HQ5t3xe5Fhz/wvbPFGuZdBPYi8h97QzgycNZYSgs9DfkBiiskI+yENPUChxFah734xx2BszMNrhGtgvvYm2fVK1eGY+YerjXPLCNsfD1P//O6+wkSsTV1SDIN/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naL5y3WG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728344995; x=1759880995;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MqdSHegVGuwV7Vw1v5+pDBGKHL8NywHmuZ6pfb2fWeE=;
  b=naL5y3WGbbqFjSicioxCj+ztTCkWiurSJLV+bYptP/ZlzLFqRWxibPi7
   B3bBvdPLAEGioF8Gc46fcW44OAF3ozIRxkiJMnSuDyhzUNtPv6IcxhbXL
   /wPSy77kCoABlH9AgAHGoEhoBp5cENh4prRfH9qdD75rL9af4kvuQ2cLo
   /axHseDsx0B7h790IDPmcT9zQCsEy6A9x4IB3PY4cHDhhemPD+C8AAyML
   jo+oaCUaSYPG8NYg7pGYzOmIcG9zkKv96uIQYne0LGiD0nlcSLaGtc6vc
   TotIzB7kuGZer14RgXo5glMKvhjJwoFMdUZ2+TyDSj7TyoOmpu3QCrVgu
   A==;
X-CSE-ConnectionGUID: yQ6GGBFFSHOeVKy9sKWQ+g==
X-CSE-MsgGUID: U1N2WwDwTyOqZ7glH3cV0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27648572"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27648572"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:49:51 -0700
X-CSE-ConnectionGUID: 6JJKAhF7SG2oxhcmnW8iZw==
X-CSE-MsgGUID: QSb6lyZYS6a6ViHhPP6URg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75891102"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 16:49:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 16:49:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 16:49:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 16:49:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVvr1dpVSt0BxE4HgpQdi81zeg2feaj45VqlxkiLaEANHTfsc6CKWGw1JVms+x6t62Y6kFD7ynpHJ4aqezw6qUvwWqPdXI33dg4AAIqbNc78Rn8VD4BQWGc1koNwfZ1TO6hUlxjbDunD/83ycJFG/Dt89cUiI946fr7mDZDaeLvfH9Jkd3VBBREeS9OYivodGlOHmYAOe+Lu0fBPtWUtuTPBtfWNB8Se4rv/8EJjXDoQ++p3o0pZjr+LTQOAr0q5+WufPLCie6Z+MEzZubtC3l9ZsKb7ZuEeLKXRTv5QIWnfdrbhrsGZPyc6wh5flDoy+T3wAer6oJYZuhDLK+ZOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6I26rA8uMOWQppnOCZ9SreYEI/nqtEE+uP5PUAZanc=;
 b=cEe+5KaZ3qArs+lbgsukfMYHT6DjmiS+/yctKMnOoCGXYagVv7yXdeOv0VnbO0VCjySoQGpCKHtKMK66eEZKS3jj36GMdRdk8cuWPrPCy07fqb9nbg0igFD7Y4tZM2I/eCueec7kXda3hnQC7wehLGqXNFPcAzFJdstuEy7Xif5/E4o2v40dE6fV3zwbO6Qy12EZisXJMkSJycyslno705FLzhajaXM/YvOcX+sTQUo3XQYATRzHUXQqTcwp7COaVBk4xIPqJGA/QAALeXpe+l8HKLF2AhFILmMvPTAzfcnyV8ArdF9bInv8Or7iJN3/36Nw35yGjA844ghpSBniHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 23:49:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:49:46 +0000
Message-ID: <a836c401-d071-42b2-9d2f-45d821941286@intel.com>
Date: Mon, 7 Oct 2024 16:49:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] eth: fbnic: add initial PHC support
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: Vadim Fedorenko <vadfed@meta.com>, David Ahern <dsahern@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"Alexander Duyck" <alexanderduyck@fb.com>, <netdev@vger.kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-3-vadfed@meta.com>
 <9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
 <e6f541f8-ac28-4180-989a-84ee4587e21c@linux.dev>
 <20241007160917.591c2d5d@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241007160917.591c2d5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf21f6c-35a7-4c97-35d0-08dce72ab987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEpralJDcWJYdHhtNkREazZDTk4wa3hiRlVTMDlVSlI2NC82ZHdMT0pETllD?=
 =?utf-8?B?V3AwaERzSmxOUHhjalM1THA3am96Y1FUYVFEWWppZ0xLay9WRTF5Ukx2V2J0?=
 =?utf-8?B?MDBiQnpYcWNzQVNGVC91THFEdUhuV0xlVE1RV3owOEdxbmQ5S3V0VVNWQkdD?=
 =?utf-8?B?eWlYVXdjT2tJNDNrcXJOQ3AzOGNxTjlZbGIrbGdYS0tZbEQzTnVJVjN5aFhI?=
 =?utf-8?B?Y1NHWC8yaU9uQ2NKOHdWd0RjOU82VWpacTdheUd6UW11b21RM1QzT2pXY014?=
 =?utf-8?B?NHdqaEF2ZHBsd1Z4SmFBZFAzSnZWTUw2WVpJNlU2dXpObWptSE4wOEVMNFE2?=
 =?utf-8?B?V0NqVS9jMWlkSXJzVWlBWnBzYmpPTWx1SHFpZXdpbmJhZlJGQjVTaHdmcUF3?=
 =?utf-8?B?WVdFS3lnRkhidU42Y2lua2UzZEpFZ3JyTHROb2x3L0hSaWx5YUVrZkpuT3c4?=
 =?utf-8?B?M01LNWFvNVV6UkR1NWxZTlRwUGluczU1QmVERkNnZ3lpV2ExZDRJbHNHaktW?=
 =?utf-8?B?UjlLQ1laa3grVWxXeVlhK3MzQ0prV0FxM2QyYUp4MzExQXowTE80ZFQ5RFF2?=
 =?utf-8?B?dTRxY3ZZcHhyVWVaZkFFd3I5bDJNd2RoR3d3N0xwQ053MzVLL3IrWGQrUDV4?=
 =?utf-8?B?QSszaUxPSlh3c0NRVE5xVzliUlNoUGZsNkxtM0hhZWtaVHNRS2F1eGtZb2ZT?=
 =?utf-8?B?VVVHUnBoT00yRlZQaDdWU25NQ2FodDhEV2d4bVZoUXEyS3lCcnJlQjlyRUpD?=
 =?utf-8?B?OU03NU1TK3gwdjU3SEFLYm1HYW5XWGoySmlMUW8yNXRDUnNDZmNKMXJmbito?=
 =?utf-8?B?OExYWnlSQWFTV2lnNWswMVljeGQvSVlqQ1REKzhVRllPS3BTTjRUSjNGUDJm?=
 =?utf-8?B?T1dCMnkrMnJqUFZiRFN2M09zOW9OY1E0aHRJV0V3Y21QS0c0RmYxUFYzSCti?=
 =?utf-8?B?d0UvcS9ndm56QVBWaDZ2bm9ZWk5NcWdObmtUbWxjZHhtYlBRSnFjdDJLaG1Y?=
 =?utf-8?B?aDlLNGE5bmQrckhTcmtzLzUzZTV5WUxNMEcwNG16ZXhpR0JaV1Nnb2lnN2d2?=
 =?utf-8?B?T245Kzh1N1JuT0d0NTRpbE82YWkwbk5BS0IySDlGR0lJWDZMSUlVNGh3UFNL?=
 =?utf-8?B?dVhsMlJOTm13bGkyNmhmeVlZSi8yZ3VnNGs4S2o0cEJKYzFUM2R4c0oyZXNQ?=
 =?utf-8?B?MWFMOGpUYnJrQ2NKTS8veGZsUTdqMjJUYk9WZWZSaU5qS0JXdE8wd1ZwSTdL?=
 =?utf-8?B?Qlk0ZWxlZ2xTYm1haWtmOHVLQkZaMmdCVHR3clFOcUFLRjQxWDJEQTNaOFkz?=
 =?utf-8?B?WWFKaEVtbS9oNVRzNm92TEMxYWNYMnpGSmFGRXpXRGllV1Y5Smk5UVk5Q1lC?=
 =?utf-8?B?T3V5U2QrOTk5cVI0QVlhZ2RYaHkrNkRZWTlLWVBIcmhJUjk2eWtMUFdna3dW?=
 =?utf-8?B?RDJvOXR6NXBKUFkvcUtvaFZQYU9FaFpnT09Id2N3azBVZjVIVzd2MHBvZDVB?=
 =?utf-8?B?M1FVL1BoNWtSMFJ1MWFVVDJKZlhQRE9pMGhXb2l5U3VwQ2U4T3ZueER3YitT?=
 =?utf-8?B?QjFYR1NlVW4wOTJUR2hWV3hSTjR4YjhIOGlFUHQva2duUDYvcUpPTlRveklv?=
 =?utf-8?B?VEdIZjZwVVJYT0MramZBd1hvSFRQOHRSOUEzY1hzUTJCOWJnQzB4UG9MWCsr?=
 =?utf-8?B?ZkEyWVV5emRTOG1NdkJHTVNCbTF6eWwxbFdpZDVMMUVIeWtzSklleDF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJoQ1FFWEJYWDdlR1NibjRBSkhvanlNcFM0RmZ0US9oaHRzQ2VZUEd5R1Q2?=
 =?utf-8?B?VVprWUhFUWgra2lGTDRickw2UzlYWUhmSUdMU2FKVE0xcGgvdnF4bWNjb0Y1?=
 =?utf-8?B?RFRjTHZZQlREeTczK3BkNDdmMWY3QzRBVSswWURzRzIzamdWalNNZFlJVG8w?=
 =?utf-8?B?TWxFWUorZytRMWwvVHJsaTRTRDBZenBWbHVlUHRPb2lYTDNsekJraE42a1Qr?=
 =?utf-8?B?NjVaMFJHODlBdHczelB3TXVLclBYTFZ3U09JWkFiZ05nM2xPUkpaSzgwekVz?=
 =?utf-8?B?ZTRIUWxjNmFRYStCMEtRMGw2SUhJc2JIY3RVK3pwaURlZnR3dmRuZlo0bmxD?=
 =?utf-8?B?Z3BwWklrcUZMM2RzdXJ6WnF2MDRpL01zKzgvd3BtcDR5cWx2N0FQUTZRY3Zi?=
 =?utf-8?B?ZDF4dXM5OGRZVkN6aitYTi9UTEVaUVoxWjNZaDR0Um1CdEhCV1dub0VlRUpE?=
 =?utf-8?B?cHQrdnlrZjlQV1ROZXJKMnhTWGE2TXRxbnBuWlV0QU5leURYeTZKYjk1RFVt?=
 =?utf-8?B?dmNodEZmV0gyLy9PK050TWR6b0NUWFBmYjBrZHE5N1gyRkc2WUorTUwrK1A1?=
 =?utf-8?B?THphSUlYMGUvTzRibmIvTVZ0dWJXUmJ5OVNLMVR1TzNjSzlpRzNaU1VTNWxV?=
 =?utf-8?B?b3pwd1Y3OTlUbndqU3RmVllEdzIyYWx1RGh1WW5RR2pWZHQvYnBlbUVlZFcx?=
 =?utf-8?B?Um9rUThRaXF0VjNHMlhQZnd2WWRHek5rcVJUd2wvT3FwSkZVajF1dzE2TUxk?=
 =?utf-8?B?L0pwZFRZbXROVFNnVjhGdjFteVg3bERHT2lyUEZ2YllaSlp0dHRiemZjRzRD?=
 =?utf-8?B?dEwyeHM4N1lTQjhLZFV1SEF5aTY2N0tGMGVST1NlUGtEZnUrV1hwWWNTd003?=
 =?utf-8?B?dnlvSWwyeDBwUUVLWEtVejNiTENON2pUZ3Q2dGdLY1hDUEZ5YnVOZW9NYWpU?=
 =?utf-8?B?czgvczltSG9ZZG4rMGVIVnBZLzdRRDZrNnd3Q3ZQaVR6bmF2R29qVSszZUFH?=
 =?utf-8?B?T3c2OThTK2RiV3F5bnd3N3N5aFRsM2duMUZZZGVYYTVERURZb1FyMzVxNmU1?=
 =?utf-8?B?RWVVMTJpWjNFN1ZCUkN2VkxNbW5kNGpOeDJmU25RYXp5QWpTYi9hK1NDbzYw?=
 =?utf-8?B?OXRRcytpd1FjTS9VQXVSWmdnbWovRm9zM3d0WmpUbXp4Zy8wQllSMmZ0bDZF?=
 =?utf-8?B?K0NGS0RYNEFtcHcvaHVSeVRGeFZRcVI5NWRPQ1gyODJKWnVzMlZXK2luSlgx?=
 =?utf-8?B?c0UvNU5qRjhpVnRVcHVGNjcvYjBVR3VHT2ZxUjgvSWJTamZUV3ViNzlHRGxx?=
 =?utf-8?B?bzNJSUhSeUVUd3ZTRS9ySXQ3UHpUZnl6eE1xZCtBdklzVnNva2Npb2d3d3Ft?=
 =?utf-8?B?UnZEeDBibTUzMVEybmxEY243eTFjOWJJMnU1STZYNGUyTVo0OHBrelh4MEw1?=
 =?utf-8?B?ZHIzdDVEQzVQSHZtUmRSVHRhc0FIZS9vbUtZcXFvV2hLY2thUWs1SWJJZG5D?=
 =?utf-8?B?bzBWbVNHckw2Qyt3U05Icm9wUlpiUEdiNGpKbVRNYjNjdXBNOGxURW1oSnVh?=
 =?utf-8?B?cEJYcllRK21OSk5Mdi9ESXoxdzdWVGlsOFNtcG1DVForRHlUMzNOWEd0VVda?=
 =?utf-8?B?dGI5SGFxNUJIR0JBUFAzMFlxWFBrZWRqS0FHZGZSYk10bHlhb1VXVThHVGlY?=
 =?utf-8?B?UDVOblZyYmEraDgxQ0dhTWJqTnhuRUFqTVdmN1EyYStyMndqV3NOa1JubThP?=
 =?utf-8?B?QXgwUjJRcjdlaEdGYmNNRTV6Q3NISDArY1BiVnBNMmg4aDhVdmIwUHVXcHJX?=
 =?utf-8?B?Q2cvc2xNSEx6MVZuanp5c2F6RkpSN3NRTk45cGpoUW8wZUlncHp3RFlFKzE2?=
 =?utf-8?B?TFFaRkJZR2JTVnN0U3E0MGk5WWFMR1hQUkxmclhuRFNDaUlodlh0ejlNZ3I0?=
 =?utf-8?B?ZzB5VEMrQTdGNEdnZ043YWVzT3htZ1AzMXVyNGRsMXZuZXA5b1ZsWXFkUEZh?=
 =?utf-8?B?Z3Q4bjNkaE8yYjdjbEpzUHFYUWpXdXBsYVgxWHQySm1GUGJDUzZSK3AzaVNT?=
 =?utf-8?B?U1N5ODgrdU9TczJ0Y01NLzk2WXFWczFFQVFmMjBUMnRta0JqTVduY012Wk51?=
 =?utf-8?B?RjJ5eXpmcXd6QXZ5eEU5ZUNzc0VUOHcrTzZOaGZPREZQV1MvWnh0VUd6V09Y?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf21f6c-35a7-4c97-35d0-08dce72ab987
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:49:46.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUm9HGTLI3ftJSECWz0qTVev+m4ntOFWvz02lEmP0kB0xAWBWWpGuF5+4tBbJBJIX2A8vwKu1P0DPepjdlM07bh2DpdivZ6s2Y4l7RohQVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com



On 10/7/2024 4:09 PM, Jakub Kicinski wrote:
> On Mon, 7 Oct 2024 14:07:17 +0100 Vadim Fedorenko wrote:
>> On 05/10/2024 00:05, Jacob Keller wrote:
>>> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:  
>>>> +/* FBNIC timing & PTP implementation
>>>> + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
>>>> + * We need to promote those to full 64b, hence we periodically cache the top
>>>> + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
>>>> + * we leave the HW clock free running and adjust time offsets in SW as needed.
>>>> + * Time offset is 64bit - we need a seq counter for 32bit machines.
>>>> + * Time offset and the cache of top bits are independent so we don't need
>>>> + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
>>>> + * are enough.
>>>> + */
>>>> +  
>>>
>>> If you're going to implement adjustments only in software anyways, can
>>> you use a timecounter+cyclecounter instead of re-implementing?  
>>
>> Thanks for pointing this out, I'll make it with timecounter/cyclecounter
> 
> Please don't, the clock is synthonized, we only do simple offsetting.
> 
I still think it makes sense to re-use the logic for converting cycles
to full 64bit time values if possible.

If you're already doing offset adjustment, you still have to apply the
same logic to every timestamp, which is exactly what a timecounter does
for you.

You can even use a timecounter and cyclecounter without using its
ability to do syntonizing, by just setting the cyclecounter values
appropriately, and leaving the syntonizing to the hardware mechanism.

I think the result is much easier to understand and follow than
re-implementing a different mechanism for offset correction with bespoke
code.

