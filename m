Return-Path: <netdev+bounces-115330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F0945E1B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E661C20996
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77A1E289F;
	Fri,  2 Aug 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYUAQePG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DD1E2889
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602961; cv=fail; b=kY1/tgzxoRfnCSFy/F8gSf5mAeJbmjnu830la2o0IQzBmLjoJAvr7BePzRJ1xuAZugN4o4c9epqOcoc5jl3rA5Gm2dcYTk7PJRWL+WqNYoN5Bc5Le/hbPnLBLKom90bchKVRAXTSUmRIuvs0bVFzdZEBY6PSKWldnLE49cZqPuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602961; c=relaxed/simple;
	bh=79C8wQyrdc+XLSayf3Fxs93nQEwAYOI2qLvXkUWOzNc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VDH5EOpXM/cgJCfp3FYZol0whVtphcb0Oq6H+zaMMqrjkBRvHEB1ObrlMA5QJAFm7HB/UuKSryxIQtLUf5gyujAhMqOFowphuwOpHOMl9hY16Onj0n7wPM1oeRfw7lRrWLVXIZvVu/hGyKPFDfpSCpkgssatuqU6O4cPBqUoaVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYUAQePG; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602959; x=1754138959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=79C8wQyrdc+XLSayf3Fxs93nQEwAYOI2qLvXkUWOzNc=;
  b=lYUAQePG/564GoQ3pNaUiNVgKAiB9PfzVW4ZLAGLYKjvwgL97nsWSmkl
   tSwvQVfuvdi7TLBFR84qeKUV0VDNjHkQ6z6Oc6Z+Jvg3UiHbJLy26Dd2d
   qrQpPV2wUEYWbMVFdIXPo9W4Wpa07rO9IrrUsuV0l2UbjiwmNaqhfmchp
   6DkQWX+8/wJEPgK+dxsgswseXIliXmwbG5TCRaXZi2b7pMabakBo23knG
   rLf9DnL0IW89MpjAFpCp4e7UTQyCcxb9x2kEWa6ZtKL9Qk5SHg8EKHNwx
   yFWHtRW+nMhA0GqRfuN0IJtoNQ9Gd5xOhMtYzxkSXhT3wWyOcoWv6fe2I
   Q==;
X-CSE-ConnectionGUID: 5XXIT5ORT/Gu/996UA0lUg==
X-CSE-MsgGUID: Nueb/rgNT5e77O4ItVI9rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="38082253"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38082253"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:49:18 -0700
X-CSE-ConnectionGUID: ergtcOUyTUuFRAZDt371vA==
X-CSE-MsgGUID: 0Mp3QiFXS5m89G2lUF5hGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="56151629"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 05:49:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 05:49:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 05:49:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 05:49:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 05:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCIPHbraJYdLWqec4OQEoTIODLeUxW5adts6WyocqC5WNkFJ+G66SJ5nhNzUmEEEKC8SkMABvv6EYKMBxLqPYXgaxiypX/I9vtIZ9UmZM/FFjZiTMoqaroLygO9WZtqGS+SHsTfUDm7DPTaQiLllexH3GuZdQ65hhPmAmdsfQ6UOEOYGm3YWdnKnbrHMvPT5xCpw/l1EPLIHEhRm9HRHZGf9y5sdOMumrgZsPBecsvmb7jNc4FKF2DqLkDJ2H86phevEj+yf+84dBnlRuA1YwIaC5438XVuSJ9UoRHvxnslj0hnQYcWAYmKWXrujujcrv1msv4QmdT+f9FloY3BoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/36OHSegXTbFhDfBM37gCkgeJbqNArjsMpGlH5B6lbM=;
 b=coDYhwgPcfiOurzm2RdfVNoeHpdhw7VI2asYTB7/8yxQGeUfj/gMnT+clCwnS2084wZlXmyunoAOlP+FuPm6pgJRqNKQjxIlkERFGnJc2hsCtgh5LafQCEgXnP7SWdGU7z7BvfmP8TrG6vNBv5F1nvStFIKoRkp8+esAP3T60qaucbIkj61PyOapS0Suoqj6kIzIcU2qSBcD+lQQ+6MOm9dHCyQ3410rY2tp2k1uwBhK0Mis1J7Ha2PEssJbLu7nX7EmBszLBhuI9ssdzyg/rQ8xMlr9R4P2zjXn9d72jkDS0VmHS7QVIl7GjlNauYlH0M7koifEIt5qq6mywqiuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 12:49:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 12:49:15 +0000
Message-ID: <a39489ca-9784-427e-ae05-a3f632d4a2b3@intel.com>
Date: Fri, 2 Aug 2024 14:49:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next v2 4/7] ice, irdma: move interrupts code to irdma
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <netdev@vger.kernel.org>, <pawel.chmielewski@intel.com>,
	<sridhar.samudrala@intel.com>, <jacob.e.keller@intel.com>,
	<pio.raczynski@gmail.com>, <konrad.knitter@intel.com>,
	<marcin.szycik@intel.com>, <wojciech.drewek@intel.com>,
	<nex.sw.ncis.nat.hpm.dev@intel.com>, <jiri@resnulli.us>,
	<intel-wired-lan@lists.osuosl.org>
References: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
 <20240801093115.8553-5-michal.swiatkowski@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240801093115.8553-5-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d3b2ee-9dcb-44b9-4231-08dcb2f183fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWNVUWtTSXJpSVNCellGcXBPdGVWM3NGYlllcDhadWlZMVJsaTRadWsyVzlB?=
 =?utf-8?B?anBZN1RONndZTW5oVUlwRmk1Rm1hTnFWbDdPRStpYTRXOWQ4aFdEa1ZYK1VV?=
 =?utf-8?B?V2l2aGFGYlcyV3N3RHUxNXJlUi91cG11U0FxeUVxMDVKakRhUm9tVTFTYjRz?=
 =?utf-8?B?eVhFWm1PVEhIOU9DRFErNlB1SktJT1VlQzZYWTl1NnluRVM0Nk1ad3RYRnZ0?=
 =?utf-8?B?QVFFcDBhNHZVVWFEMFdwZ0NDSC9kM2l3U2RVeml0eWJub3BrTSt0QThBbVgw?=
 =?utf-8?B?WDFNYkxIMytJb3BZUWN4UE5xNnNRdDJXUmZ0NUtTb280cllJVUNkbEZUZEZC?=
 =?utf-8?B?K1lwS2RuOXJsOS9MZi9SdzJEU1RlYndIQk5BSWIzMzQzdlVLVDk5NzFod3d5?=
 =?utf-8?B?dVVFZzJFb2hESHBjcy9vWlIvRHVzZHg0bGdHRkNsRW9KYUNxaEhIUEFZOFRq?=
 =?utf-8?B?c3d1Y2FEbDJ2c1RPQzZyeE8xb0t5RXNrWDNSOW1ab1RIOHdyRDk3L252dmF6?=
 =?utf-8?B?QWtCeXVBTGpNbDRsazlSeEJiVTVndWh0dXlQTURadFlDcDBXZVl4MHc2UU5L?=
 =?utf-8?B?M2ZxcEs0RHdKT3ZmZDdHOUZ3dDNoU1p0azNGUmpBZUE0ejZXOGViSWd4MTNw?=
 =?utf-8?B?ejZWMENIWjVSSmNDd0pxaitpZyt3Z3ZEbitldnhSVDI5Tnc2RWtScnBXS3Bw?=
 =?utf-8?B?QUpzL09rdWl2KzI4cWhKalJpcVF6cklQcUw4dStMUHZOaGxOZjd6T0ZhZUdj?=
 =?utf-8?B?eXgwQ2xUdStvZHNWSXlwQmRoWFkxdExzR2V4YXBnWHJqeCtaUHRuNStPYS91?=
 =?utf-8?B?NmdnNnY2SkJpOU5ibEJzN00yMS9SdG05aXpOYWpEZlovL0tkRnhmOGxWWGVo?=
 =?utf-8?B?TGdKTHNBZ3VWdHBRdTFqb05XU0NqdmlsNVJQVkticFYyeGYyWDJIOHNRZGpw?=
 =?utf-8?B?aExuUmVpOXJ3anhYZHZ2Y3dCMWxTRGljNWJ2dFhtbzUwRjZwbnZDQVFTcGxW?=
 =?utf-8?B?MktNVUV0eHNEemh3TkFyamFGYXdUSTRNQXhibzgzak90OWFMTTI5Y3NjWHMv?=
 =?utf-8?B?K3I1dy9hODNkOUxlSlMvenZzMUxPZ1ZHM1Z2RUpxZ0wxTjJ0RHBHNi9TZ2Nt?=
 =?utf-8?B?dnlvUDhYRnNSWnYzQVJsbmF5eGwxWThUZ2lJUzRVa0FSQm5WVm5UdjJBekdC?=
 =?utf-8?B?QlBpL0pTQzVpUFJEakZwRWRtNlM3RHRldWRnQWNiZWt4aTVNaU85cGxLWXZ0?=
 =?utf-8?B?QTIydWZQcExEdFRNVGpteFJnYi90cXhLU2NaOGd2RlZVQ3ZITnBEQk5LOE1w?=
 =?utf-8?B?cWVuT2JaOWtjWTdPZElURWQ2emVUQmpjZlNLY1o5L1dBQ1lvWHVHSkszK2tu?=
 =?utf-8?B?SlJpaFVBUXZIU3dXUHZaRDdWRU9YU2grMmVwMUFCRzRNZDdwWGNCRjVzLytw?=
 =?utf-8?B?VzlVQTZYRG5YdXk0bUMwckxscThQWkJoUUY2N1JEaGRNaktVVDRmT2RFLzB5?=
 =?utf-8?B?MmZQdjQ0NmxqZGYxeUVQSlhMaTBXNjhsNEtsZVM1MUFDTStrRmVOdk53dCto?=
 =?utf-8?B?UHMyZzVMVE1nbG85T3NVbk9RUVY1ZllsQjB0TndKVm9KQnMxOXdVdGhsMG1C?=
 =?utf-8?B?RGI4ZkQwdXFSd2poVmxaeGR0TVJNSE5pV2dzbW1JTC8wZFRFRzZTUU15TDVt?=
 =?utf-8?B?TXZPNEZEb0lMSk1qS3A2dTdSQ1QwZFN2clBueCttMC9JZzV1WUpSNzZpbUpD?=
 =?utf-8?B?bjVtb1AvbTZlQmNGUHg2SnJCSG4wc0tFdWJOcEQwUVJtU3FHUFpsK0R3Z01N?=
 =?utf-8?B?K1VhUmJVaTI3MmJtdU1Hdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3k3UkQvNGN2WGRvandtMU11NmhlTGpnRnRjYXpBaCtRSmlLWHB6Zk9wODYv?=
 =?utf-8?B?UjZJakFHMFNKOXVtWEh4SXJkMG9IcTI0RW1XU2N0Vy9JVlZSbUtEa3dYYTNO?=
 =?utf-8?B?WGJHcXE3U2NOTS9Xd2J2ZlZBVG14VmVIa3JVSHRhUGtDb3FHTFd5b041UnRY?=
 =?utf-8?B?NnZkUzNVVW9ERGZYR3BneVh0Qmd0cVhHWTc4YlZRQzY3WldBTGVISDVQVkVH?=
 =?utf-8?B?cm5GZk5ONkxxL0IxS0xuMHlldENpcy8zcEJsMnh2T2RwWnN3dnREWXBuSXZj?=
 =?utf-8?B?R0Q2MVZVVGRHOUNFZm1iTVp2KzRIYTBCYWRJb2gxN1NhTGl4dGVwZjZNelhJ?=
 =?utf-8?B?QjJ0UkNrc1VlZExtaUNUMU5XdXByWFFEc2tWZmxNUWY4Y1lVTW1VMFA2cXZm?=
 =?utf-8?B?cHJNZDB2SFBCSmF5RHo4ZHFCS2ViVitWS01pbmQvT2Z6bUhvQkFMZ2thVHpi?=
 =?utf-8?B?UU1kQm8zS1ZZMEFxZU5BR1lMUG93WXMxL0RWNzFzVEhidUs4cW40UUJqOW80?=
 =?utf-8?B?azJSVm5GRGxNZUhEaUV6amhudzZPM2w4TmtRTkFpRUd4ZG16RGlyVERUT3Qy?=
 =?utf-8?B?NThJWnlpaWduaTNpSTBPWE9NYUJQWldGYzFlUngxcENQR2J3UWVWM3hIcjlq?=
 =?utf-8?B?OXQxditFVERQeDNORk83TXNRcUZ4a29RMnhpQUxJWUZxUHpKS2RkbDlBODRL?=
 =?utf-8?B?L3hhRE8zUnZwT1daY3luWW04d2hJSkxDcTVNclNkRCtWOU1BVE9Cd2tQWUFZ?=
 =?utf-8?B?cUlMZEJJOHJEVUp3YUlBdVhRdmZiOFcrb01tRGRGYWdrK3RTVHJWbkl2M1Q5?=
 =?utf-8?B?ZXpWc2k4bnd5NVlqQk9EZ28rSkh0U2hvaVdURmV6dkNsamJScVFYajdjdTlp?=
 =?utf-8?B?QlRXREtjYXZJTS9SUWkyZ1dPWHVVQi80T0FKYWdDYXZDbmV4K3FzUWN5RjVS?=
 =?utf-8?B?Nmhud3JlQWdUR0xJMENGb3pGb1Z6MHFXVmJZcHJOWHFydHJmak1aeFRnMmw2?=
 =?utf-8?B?b2JKMmE5SkpVdnlIY21KTWl4WXhhUThOelFpdDJMaTVycGhEc2JRdTJEd3Qr?=
 =?utf-8?B?VGRnU3lqSlRGTG5ZQXpLNk1kTXFJLzBLbTcrOFduYUpoRUV4QnlqaFdQd2N0?=
 =?utf-8?B?ckQ0blVzMkdWSlkvaUZFS2ozMXVYeEd0NHFJWHhyeVJXenVuN3Q2eVY0NzNN?=
 =?utf-8?B?V2JkZnVnMmNYd1JmT1BrOXlWejNMUkF6UWFKQzQvT2tVbE1CV084ZUxxY0VN?=
 =?utf-8?B?U1J3bE1nQlFNY0R0SUVmTjNzRmJ2V3FXRHcwT3JuSVZBWEVLbGFyRWVlZERE?=
 =?utf-8?B?R3E2UE03ZXNQRXdkejlQM3BUQnYvejEwMXBlMTVqaFVsVTJHN3g1NDJXQ2ox?=
 =?utf-8?B?cnMxZGpCRDVPRk54RGRGTmk1aWF0dW9NNEVxU2E2Tlp5SE1OVFlsNVJOd0RB?=
 =?utf-8?B?NzEwY2g3RzVPZHFITzYxZEFGZytKaUUvVnV2OGd1NFVHWHFTMnlndWtBS05k?=
 =?utf-8?B?dFF4N2Ivc3FrS2ZsU0FzT043NU5MdzBRWUdhSUd5cDhJcmhQc1ZRd1h2eFRG?=
 =?utf-8?B?S1BFTSs4VG5pVm81RTRiSk1Kc1ZtRktBNVhXdmhHWEFmeG1xc2ZrclQ0bFUr?=
 =?utf-8?B?R0ZVWmkxaFFXNVZwT1ZXa0w2b21HTUlIMjNRSFBRaCtyeWIvK0t4Zk9Sd2dp?=
 =?utf-8?B?QUkwbWM3UWtITUpnK1JIQitDRmtwSXE0aGRudVk2ditwNldGa3BNd1hlMHc2?=
 =?utf-8?B?OGJiRGlTTm1BOWpkMHI4SmFFYTZIdzdDTDQwYnB4ZTlhU2I5VnhYWHdtNlJ5?=
 =?utf-8?B?ZzRWZGx4SHpVWGtaOHhiQ01ZdTg2RTFEMUhvMkN4Mjc1R1MybTA5VmhyK0hy?=
 =?utf-8?B?bGxIZVRuZTUxR05KMENtK2FLbEM0Q1ZIQkpxQkJmQ2JUTGZxMlRERlZTbEoz?=
 =?utf-8?B?QTZ4MkU2SmpFZDNmSHZxNWpLdmt3bjFQWmw1MmVLNlBTUlg5aE1OTHhGNjZn?=
 =?utf-8?B?Q0RtUk9zVUovTlpYQmVKbnZXeS9DRFlZNDd0SkIrZXVnUWxGRktYSWFQR1gy?=
 =?utf-8?B?SmdCRVF6UU1hbEZydjUwRTUrWkFKT0Q4QjRXZWtoa2JrYkFFTG81UFhVVHFH?=
 =?utf-8?B?VU9kay93c25FVlYzYWNuM0lRUEF4U1JoYnZIbk1IRXE2MlN2VUkyUFVwZVRV?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d3b2ee-9dcb-44b9-4231-08dcb2f183fa
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 12:49:15.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WG+DLAEg3hGbe03uzN408K1uf6m5T7CiWF3k0wtQ0Pn8p/S0BZMGu1IZ663G0NHolNn9sXDJS8kTIvp5Tz/SeG3onXhtIxGQH+7/84NOtR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com

On 8/1/24 11:31, Michal Swiatkowski wrote:
> Move responsibility of MSI-X requesting for RDMA feature from ice driver
> to irdma driver. It is done to allow simple fallback when there is not
> enough MSI-X available.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/infiniband/hw/irdma/hw.c         |  2 -
>   drivers/infiniband/hw/irdma/main.c       | 46 ++++++++++++++++-
>   drivers/infiniband/hw/irdma/main.h       |  3 ++
>   drivers/net/ethernet/intel/ice/ice.h     |  2 -
>   drivers/net/ethernet/intel/ice/ice_idc.c | 64 ++++++------------------
>   include/linux/net/intel/iidc.h           |  2 +
>   6 files changed, 63 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index ad50b77282f8..69ce1862eabe 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -498,8 +498,6 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
>   	iw_qvlist->num_vectors = rf->msix_count;
>   	if (rf->msix_count <= num_online_cpus())
>   		rf->msix_shared = true;
> -	else if (rf->msix_count > num_online_cpus() + 1)
> -		rf->msix_count = num_online_cpus() + 1;
>   
>   	pmsix = rf->msix_entries;
>   	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
> diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
> index 3f13200ff71b..69ad137be7aa 100644
> --- a/drivers/infiniband/hw/irdma/main.c
> +++ b/drivers/infiniband/hw/irdma/main.c
> @@ -206,6 +206,43 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
>   		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
>   }
>   
> +static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
> +{
> +	int i;
> +
> +	rf->msix_count = num_online_cpus() + IRDMA_NUM_AEQ_MSIX;
> +	rf->msix_entries = kcalloc(rf->msix_count, sizeof(*rf->msix_entries),
> +				   GFP_KERNEL);
> +	if (!rf->msix_entries)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < rf->msix_count; i++)
> +		if (ice_alloc_rdma_qvector(pf, &rf->msix_entries[i]))
> +			break;
> +
> +	if (i < IRDMA_MIN_MSIX) {
> +		for (; i >= 0; i--)
> +			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);

you call ice_free_rdma_qvector() for i=0 even if the very first alloc
attempt has failed

> +
> +		kfree(rf->msix_entries);
> +		return -ENOMEM;
> +	}
> +
> +	rf->msix_count = i;
> +
> +	return 0;
> +}

[...]

> --- a/drivers/infiniband/hw/irdma/main.h
> +++ b/drivers/infiniband/hw/irdma/main.h
> @@ -117,6 +117,9 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
>   
>   #define IRDMA_IRQ_NAME_STR_LEN (64)
>   
> +#define IRDMA_NUM_AEQ_MSIX	1
> +#define IRDMA_MIN_MSIX		2
> +
>   enum init_completion_state {
>   	INVALID_STATE = 0,
>   	INITIAL_STATE,
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 8247d27541b0..1311be1d2c30 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -97,8 +97,6 @@
>   #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
>   #define ICE_MAX_MSIX		256
>   #define ICE_FDIR_MSIX		2
> -#define ICE_RDMA_NUM_AEQ_MSIX	4

you have to extend commit message to tell why there is a 4 -> 1 change

> -#define ICE_MIN_RDMA_MSIX	2
>   #define ICE_ESWITCH_MSIX	1
>   #define ICE_NO_VSI		0xffff
>   #define ICE_VSI_MAP_CONTIG	0



