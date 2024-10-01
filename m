Return-Path: <netdev+bounces-130974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0225598C4EA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA7B1F21B3E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC541CCB4B;
	Tue,  1 Oct 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvi/WtIb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CB1CC884;
	Tue,  1 Oct 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805292; cv=fail; b=Tt+EDs+v+0l8YIVgbKyy3/VcwIIcyaLA3Mabd4XFTp6Riwnsul+FpeljoOC2bi5F6A8RJ8RT405lC0N2ot4mrrJ98aLtD8+YOXBhZOtk07nk8Ztm9FBMPjBOwaThKqawBWgafItIaNcj7NwDBS+eCAb/BDUaBjwyzD1HTo9w5WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805292; c=relaxed/simple;
	bh=8D/I+AwqXtNST94aniXAWEoXqPY44sqv0/90jh3gNk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYJzwAA4Wn913cROmVIIuwoyOyrsFuLQm1cVz52aJFraxCPAGjn+7bcJwT+EhwnWFyhNbLJErWf58UOxC7zt8BL7Dr3enURR2eeqq1X3YVdDyL1vpEQsH8O5q9mAqYyL4h1igoBqGc1Z0fVXXgYC3LxgAV0aMYB9sc3Hr3/cRbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvi/WtIb; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805291; x=1759341291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8D/I+AwqXtNST94aniXAWEoXqPY44sqv0/90jh3gNk8=;
  b=gvi/WtIbwxahe8mhQ/9bR/e8OSr7U/Tu/NItKFiq+U+P8OurJJvUR1T/
   OJYs0QNtufJEH0MSFmsKjjU498tECx18aQJMk+PxPCGMooYk+KrORetih
   Fhr/D0tMHVVrKRFH5LFUa0eiIyc7Kps8mezrd5x8jMev0EeSBtSq/9/Bi
   DQT//zo11CF7oNXl31LTvcJEna3HJoBo1jMrLrLGpJAvhco+I0SB6DauU
   AxarWMIlxQ6LyM2DL+CDX2ncgRG2kYeCISWad/lOcXpHs6HQQbF51m/xn
   FMZu62ONhoa3vP/kIO4ORb4Erp5M4YLlVb6alWvherMzOQPoCdN0Rdcx7
   A==;
X-CSE-ConnectionGUID: ocpO0UlvS6Gcr0dZjpJ9VA==
X-CSE-MsgGUID: a70mZFvIS++DubS7BbUluw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26839070"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26839070"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:54:50 -0700
X-CSE-ConnectionGUID: Idu/NVxLRPqQv5IFdPWvGQ==
X-CSE-MsgGUID: QPNJlK4ASzSVmGxlTDqRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73355000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:54:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:54:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:54:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:54:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJDrMIrI88eEXPX+xtqQ2VBpt9G9lblR2NDZueAbFswC+4qZ3NilCpN2L/ShMoIV5KHuQ1kiY+4DaU8hzv9njny+ljbLqPEXBMTKX6K6gGqIbv8VJ4Dn+R0p6xZrCvmkMnKRQS6tKAzE0tHyzuKlhe3JtACNsr2CvMnil55G+RiznQE3/UfYOVs9JPLcdfxRG7GAGDxlFWCpjp0ZVXQnZkLfw3Opllx8sUaBYhEtsXwormC+Gw2mZA5yC2ndc6SSwQBIda4yeAxL/GFkfRnp6eS5EIEAqzHY5kmCu1sQEipfAVISb+bs7pDV9v2QriIfIsUAPj3eMcAYpM9bH3eAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D/I+AwqXtNST94aniXAWEoXqPY44sqv0/90jh3gNk8=;
 b=jFrf2hDEpk1XyLIwsLzwKQG8a10oEyYXxn6v3nS5vnp/Vevx+5lgel9y/noY2FzK6L4tlfVbYUDoWW5sQgUTBhswkT3vTa6uO4jBzZ7Ou6Rkw2QoOF123SWUTD5fpiTirM0zfhP+bmMOP32R1kZMv4QqZpWvu6r/Of478KgU34m5CkEuuFD5aVp+mAOUmAH8HgiTn0pHZQrYnINybXQVt3Thf0gWV/tufS293D64ab5g08xGqwVuhrPx06Ot/XXutR+t0sJaEp43azIZsrNqvdech2eEWx4YA1qZ1E6PgqiVjbZ3Jpw/ddMz0jui5+s42988lErcBube8kAi5V752g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:54:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:54:44 +0000
Message-ID: <a8aa9a72-0d18-4549-ba92-79d720005e75@intel.com>
Date: Tue, 1 Oct 2024 10:54:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/15] net: sparx5: modify SPX5_PORTS_ALL macro
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
 <20241001-b4-sparx5-lan969x-switch-driver-v1-4-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-4-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: c361d233-3ce8-4301-b4aa-08dce24221a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXUvME0vYWh6d0hwdGpLTTdqS2wwNGpQUUM0bmlVTUpwNXVVcjRuOTBmQ1ZJ?=
 =?utf-8?B?RFY5TCs5VFZOeWl2N0dxSWVoZUdUUFBVeE1WaDV6eEtyeEtZdWVqWWllTGhk?=
 =?utf-8?B?SGRseE5pdUhiREpsRGRDeUh5Mm1nQjNXMzhNYVVyN2YyV2Z2b2tRbXpkTmVz?=
 =?utf-8?B?RFBEQWVnQmQ1RmMwbXliNUQ2NW00ZTRSWlZxZFc5SDF2Qzhzc0R5Ri90UHNa?=
 =?utf-8?B?SUJZL3lXY0Z2UFRwTkJFUUZsVExqWXNXZDdUWUgzOWYvSTF0YVFyMy9FV1BN?=
 =?utf-8?B?WTBWR21jSFMrRGZIdzZXeWFqZHBBMUZMNnNXb0VJaGYzeTBjTktGeldWTzhC?=
 =?utf-8?B?TWNLYUE5ODQrUURMOVdKbnR1Smh5TDUrQVFqbEpVMEVRbS94RWZ3MnZtS29S?=
 =?utf-8?B?OHRMSVZvdlBrbW9QOHFjMmp6d0RxUHVYc0pKdG5JUjVSc1VlWHJQMjM3VGdM?=
 =?utf-8?B?RVZmNXduVmQvUk9Uclh5SHA0VHVhTHhqNjZkNWlFcWE1a3FFOXJFcVQ4UU1U?=
 =?utf-8?B?MDUzMWcyeG9aaEZ2OXVyZitkU1ZJOFlKbk5WK29tbmlOTWl4WWkrMDJ2Z3hJ?=
 =?utf-8?B?Zkh1VE9UUFduVGsxMDdQejFhQTBuREliUndJc1EzVHM4QkFuV2VDZmZuN1M1?=
 =?utf-8?B?UEZ6S1VuZUVMcktaRnM5TC9sOGc5YWNnMVNxY3I0cDhXOUNvWi9XNkVKdkNO?=
 =?utf-8?B?RXVlUk9JQW5hUzRGQ1hLa0xoWjFzQmJ2OFhZWVN5WVE2ZFNWWTNCRFVZNjA2?=
 =?utf-8?B?cnNOeXI1V0kwNnlST1gwclpCNXp1OXJnQjgwUXhGSVcvTzQ1YktObjN5WW5o?=
 =?utf-8?B?VlFuS1crQWlTOGwvMy91eWR6eFZoZGNmZ0h5SFBzUVpWWXBYUkNUd3JqUXlv?=
 =?utf-8?B?STJPZU9EOXVVYVZINDVYRkdCK1RJd2JVRk04ZU1EbTZBVGx0UWlJcE1kMkVC?=
 =?utf-8?B?dmIwcDJoZDNvU3pnWGhOSmF4WThxYUpmSWhlRmRJWHplUW1PT2U3TTZQVUx0?=
 =?utf-8?B?OGgzb2RrSmFabUhIbkRvKzVOM1kyNXZVS1Y3blZ1Sm9VSG0wTGxwWkM4TmpQ?=
 =?utf-8?B?cDVJcWwwMGlFd0ZXSkpBVE51SlNCbFlTUnpPMG9kYWxSanF1YXYrcTlsdmV1?=
 =?utf-8?B?VWdpRnV2bm5SYjJESW1Xbmc3cUNXTUVxZmZqbWZMYkZ0MGM4NFFCYXl2b3pT?=
 =?utf-8?B?WGFRcG9TVExYWW9pQUtLbjRJcUtZN1VBNUM5VGUxc0svSVNFdHlwSGcwNWt5?=
 =?utf-8?B?THRCRlVmd2tVK01Rc1pNNUx3a0x6S3B1NmxKR2doamVqMVZ0UENudUtxZk8z?=
 =?utf-8?B?bVFRMEtDSzBmbTFWREhvR3I0R3NIbDJlRTl4Vk4yaWVpem1wQ3Q3ZDVwQm9E?=
 =?utf-8?B?eThFTm1oVUVsSzZCVzAvQWNrV0t0VG1Xb2x1T1NwYkZYcTlPRHVnTndJOTJm?=
 =?utf-8?B?eVVRbGtPakNJOEw2OXVhdVFBcE4yV01HU3M3Uy93Uk40RjQ4VGxYUCtaNTFE?=
 =?utf-8?B?V0lTQU94Vm9GbGUxV3d4ZGVaM3BBNlNDQ3JVNWdpdjhzMEpKc1RkV1R5b2xP?=
 =?utf-8?B?bmMwSGQ3aDQ4dDNZMEFRZkRQNkVWRlowSGU2bUpLNGhmMk1tZnptL3A4bTBp?=
 =?utf-8?B?WjJGTFpzMkplenVHOHM3WFJrSlEwaG1hWG81NTZDRzBIRXYxUVlUcmNnT0RS?=
 =?utf-8?B?K2lOajhzMDRPTVVVQnV2R1JPQjd4TFdNcFkxdWVzdTc2OTdvdmhnbTRVNE1m?=
 =?utf-8?Q?4rBhhddAxwdBYVCqZE3sYcMwGJZUF5W86TZHuK/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZ2QS9hZFM4TDV5OEEvcndRcnQyTWc1aDhYU01hZFFTZk5mUTZKWXFhZGwv?=
 =?utf-8?B?Slg0TmozUVJ2RDRPMGkzcWo5VTg3WGhLYUlZRWJBV09BdVRjODBESWxYN0ZG?=
 =?utf-8?B?VDFsU2NHMHpuZnlERGR1ZXlTNHpEMSt0TWpnYlYxeUZrQkthcEtCbjZ3ZXY1?=
 =?utf-8?B?Wm1lT1hiaE11WlI3K2ZOM0tCVjVGRWozaXFYeW9wNitVNWhsSk5DWWh5N1hV?=
 =?utf-8?B?dUpobEJZMmVEUEZwNEdKQ1ZtUVphQzBlUTM0M2FYUlluU1VOY3dZSklpL3Mr?=
 =?utf-8?B?eFEvYkdDVWNxWUwxS01FV1pRdFNZYlpaZjRJRE45cDVRWmxLdFZMWGdjSlVk?=
 =?utf-8?B?S0NiVmhURUY5Rm4xdXc1U0Fia1ZsL2l1UzVDUzFWYXhoMkdjK2h3bHhNVnVx?=
 =?utf-8?B?NmE2bFFBZFJXUEl3endQcC9lYXAxbWZkckk4KzhuYTNLOEtLSWUyeHZPWU15?=
 =?utf-8?B?SjVKT3JJZEZ5VnZsWE1KdFR2WnlHOHhQcEQvdGlvZ203cnJOcG5mdTBJUVdE?=
 =?utf-8?B?T2ltNEY0S2ROb1R0YnZuSldtMS83QTgyWHJZNUN4STNvQmZndEhIMTNqVWdp?=
 =?utf-8?B?dnJTeUtXNlRMc3FQTDhLL1lVZEhDUkZhV0x2d0xmUm90eTNTYzQ0ZjdxemxC?=
 =?utf-8?B?dlZScytmYzRWN0k2RUVHTjRaT0lzUjFLcWkzVnhJUGFzelhaS0tTK0o1MFhj?=
 =?utf-8?B?OE1VNVFCRklXZVljNnk2bENXdGRvdkQ5bVJIKzJpOHdnemhaeUYvaGZ3R25P?=
 =?utf-8?B?L3kwNHVodGM1eVYvZ3gvRmhQWU1wRTAzaHdFam05dXlidTZiUTFTbEdNWElx?=
 =?utf-8?B?SThvZ3FYS1ZOTXJnTit5U0lVMDR4ZUduVmcyZFE1OVo2Y2lvOUlTeDJveEkw?=
 =?utf-8?B?cFR4blBwMmZEek55TGh0bXhDSjVXNkdvL0dIYWY4TENsalBMbEJ4ZksyUVhS?=
 =?utf-8?B?T3NvYldpaTJlU2JjWkdOR0xHMU1WTlRnSkVqNTQxUGViTnlsUG5KWFpnRTRU?=
 =?utf-8?B?Y3pUZDJIQzdBalJaZjcyZ0pIK0JEM2pNUWVmMnBmeUx0VFE4YkRKWmJtL3Uv?=
 =?utf-8?B?UGZlQUU5TUoydDBHTStDUU1aSWRmRldCcXIvREtDbkZneXo4dU1uSjEyYVJj?=
 =?utf-8?B?NEF6aDlwYjJUZzJaMVB4eHRMUktDWWRueWNQRExEOVR0cG5ycWZ4c0hSYzRh?=
 =?utf-8?B?cjJUQzVaN2NFamZINHk3TlMyTGt6NmtrQzl1enh2QXNjYi9Oa0xJS3krKzVr?=
 =?utf-8?B?S1lzYUcxMXJXSTJ4eGd3QWpiZm9KK05xby9qSG9yMzB2a01Kbk04bWtQSzRj?=
 =?utf-8?B?VGpGcmpuZjV2WjU5VEwraXBDS04wZG1tK2l6U3plVnFQdXAyaHNxUVYzVWZJ?=
 =?utf-8?B?Z1M4NnBMaVFDTnV5MFgrZVlVYnd5YWFDdmRsVG9mS1YyQktjakxNTHVXWk9i?=
 =?utf-8?B?WG9JY21jVndxamRLanNrQ2w2V0JKYWpFNitjMUhPRm5iQnN1d2tDZjZ3bnFU?=
 =?utf-8?B?QVFYUW5vY2VudkFES1BCSjl1K2RQT3hMUHU0bEdQaEpvcytZVGNVbFBsWVFu?=
 =?utf-8?B?MWJIWTVhTEtyOHEvSCtPUTgxUnpTZ0lEbjFoSkFjUXV0NWRVdXl3TlQwSjBS?=
 =?utf-8?B?RUVEVkNjTFhWTmJXekdnSjN5d3FWbGg2RjRrN0g4U1Nlb1dXd2VESzRJcysw?=
 =?utf-8?B?cVBQdGtqblc3ZExCUEt2UVRCWG1ob25vR1JMblNjMDFIUFluM250blFDSnVV?=
 =?utf-8?B?OHcxaGhvUG9pZk1EbXJISHcwSGxrakdFSEd0b2d3TmRlZEN0d0NkZGVxUGhD?=
 =?utf-8?B?Nllma1c3TGVkTjBlZE5kSXljMVpncjBiU1FCSzBPZ0loRWpVQ2p6QXp3STRi?=
 =?utf-8?B?Ymo0MWpWN2pUUzAwTjVOV1g5NEpiZUI5M2NTRkxxYzU2a2xXc2FFSGhwaDN5?=
 =?utf-8?B?cThzRDVnZnhrT1JmdHFUczBSTHM2UlNrYzA4YUg2YjNEblRHc0xvZDNCcjBT?=
 =?utf-8?B?bEhLejRma1BMOFNmbUdmaitLN014TWRjaEQ0Tis5eXJwVW1qakltRmtjUXlh?=
 =?utf-8?B?ZEZ3VmJhQ1lDamErVk9Ia05SVEYrYm1WN3FOdWlnSlJjY2t6OE14N2wrVm8z?=
 =?utf-8?B?bXBEejFVbTNXWnpWRVl6ekJYS3JuZlkvQnZVTUFJRDRmMUMxUmhJN1lTeEth?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c361d233-3ce8-4301-b4aa-08dce24221a4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:54:44.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElmjQVlFCl74GAy0WIciyi1zbmpA/208TSFNPDE8WKJ+g5hVjoPnOUfI2hofizYdUwhTFnnWDn7avF6NIfVFa5iXkEY74zEM/DDy0WZ715o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> In preparation for lan969x, we need to define the SPX5_PORTS_ALL macro
> as 70 (65 front ports + 5 internal ports). This is required as the
> SPX5_PORT_CPU will be redefined as a non-constant in a subsequent patch.
> And as SPX5_PORTS_ALL is used as an array size troughout the code, we
> have to make sure that it stays a constant.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

