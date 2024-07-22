Return-Path: <netdev+bounces-112381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76849938BF7
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EA2B2109D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A42B169AD0;
	Mon, 22 Jul 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjN8aP1j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6351607B4;
	Mon, 22 Jul 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640209; cv=fail; b=SvgUZxIBxb6OPYTXK/wil67c1w3Hrqj3FxM+Cwj4kLSzNWEAZ/vtbjlVRbhYTgqQm3A2GOuoJ1xPQb+KyngGhlwLLP+NgQoMz2JIfNBydYNvihh5CqOLi6YIjdOohODSHDwm5Z8+Mi6IMSVS5bLo8DVsBCnyrrgKSjC93uKPsWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640209; c=relaxed/simple;
	bh=BsbUWCIxPM3bJlbA7PBxw49YSvNI2NxDMz3JUM3kgHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWXLCEM0PDS/plrOjEugGRmVnC8NASQY9vftHG3x/3jPOtmNZjrHwUm07ZVItVGO97CbYAIy9zSQ7/mRQxjHtk62Wx4fhO0X0Sy+WRpKy5aJO4E7KjPVoyJGBkqoeGfNa1mNLlHL4Na8ZEMOlGI4MGmEoC3yRxryxoolSNDfQvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjN8aP1j; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721640207; x=1753176207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BsbUWCIxPM3bJlbA7PBxw49YSvNI2NxDMz3JUM3kgHA=;
  b=SjN8aP1jux4bl3Fh+dnbGc2NkqWIVCnV21h14iIAmuccfxl2msy7jigR
   0fqWEZ/24MOJvxhhjEtwfiZDFoLbTWGCurFBXsic8vSyqtXyUA2cMl7bd
   EvCBhbxOUA7r+FdvAbiv1UYrY9LvXiuMC4uoch2uuCj1SLwzDMMQMcnJe
   z+oyFnNLf6SrcsWJopiIvXPEu/gQccnjyRZol2xHx6LauM+6rjEWI7QTg
   VdjUnomx+yTScoS2Y4DWN5UoBBGOPe6rF/ooGIb69RHLxfF3TXazUmszS
   d0pwpz4cOlaLqoNy0T+xeZ4Fv9epIcW+Q8+vn49lFaTU3KNAB9snoPXR2
   g==;
X-CSE-ConnectionGUID: slcszuSERxWBKICdBlpu8Q==
X-CSE-MsgGUID: 857iPdn0SKWff7Q2dt+neg==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19384125"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="19384125"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 02:23:26 -0700
X-CSE-ConnectionGUID: u2IaAogTR06144e+VJpl8A==
X-CSE-MsgGUID: 1dcNzkW9RrGzeQ6a3+hiqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="51835421"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 02:23:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 02:23:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 02:23:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 02:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl6LRFnWFuRRer7WHmHapk/hXrjIf0SWo3JxSRhB20mfq7Rbzs41ZvBYHRG08jTr0XGnTBAyOPNUF95Rorvko1nTKQ4ph4fCtMTtoez4cOG3Q5NCHeLCEHib8/cJ6HN9EIeh/EZW7tPCHDymSM2LV4XfSeSDuNzqdpqUQIP9HF6kEnxRq28KI2UHP0LjSI7FAV/9zYlNHu+l6P3XaVusTtaSRAPjgMCi5816P44QSui+WEmQs5PHwXViH1K5uPhAal7xqG65Jwf/Aib1ikhKoXIr2Gm98t2tCgvQyhNDaoAtgO/ie8wwBXjvXjETBw09XVrGqrrhhSTq0nseSyIEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILuqfVIBv43s3hZ+BMmeNgWXMugWAZuSuDftukT2wvA=;
 b=wEU8lr4zbbSmMf7z6Nhgr9wCEQYu38UcW7iAPDzaK7rSblqUID7ZuKscRsF0xGxm6BAlOGY4ahY610a471SzrnO0EXhS8aYEti2uLmrZp5yDS3qr0TwdymbOXnEeFpvdMTuJiJnoX8RK7DB5xhw3GjY70wS9f9mCz+xuXsW+FMuRktP4+AmiYbMG0d1Ot4LRmwE4O7CgcNPNI2/sZ6HWpiG7xUIzEFhvo/004mAtoOI3GZp1PVjH35HHkcF4jlG/1WpvfQAmg6x8u77unS2GwLSFKR+VJ8UwmhC+AxF05UviwYO7JFgwl6nBisS74n29LOftXSC1ERF2VEJCnwkMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 22 Jul
 2024 09:23:22 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 09:23:20 +0000
Message-ID: <f1eb7226-0af7-4475-a57d-e3293dbc1071@intel.com>
Date: Mon, 22 Jul 2024 11:23:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/6] ice: add Tx hang
 devlink health reporter
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <apw@canonical.com>,
	<joe@perches.com>, <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
	<akpm@linux-foundation.org>, <willemb@google.com>, <edumazet@google.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
 <20240712093251.18683-4-mateusz.polchlopek@intel.com>
 <20240714072333.2fff045c@kernel.org>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20240714072333.2fff045c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: ebde8ee9-bc0a-4dc8-8f53-08dcaa2fed86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTdla2V0NE9lQ0gyOWlHN2c3T0RvQXgzNjFMNFY3T0pIU3g3T2hMdzJwb2tI?=
 =?utf-8?B?NVErOGRZdXorVmhVUmdSeFk3MWkyNVdocy82dnYxL0dsdEF4ZStiT2VBSHlj?=
 =?utf-8?B?UzE1cmtocVdJcE92N1VTa2xsaWduaEhsakRHcXhoTndnbmMwUE90MERaVWc2?=
 =?utf-8?B?bnB6WHVrWnhCR01tRjFRWGEwaHlQaEh2ZFB0SklxcHZocDRvWGJacFlCck9s?=
 =?utf-8?B?SWJKQ0puOGdDblBBOG9wdDRGYW16QVJvN3pXRHUzZnVrcWZycWtBR24rSS81?=
 =?utf-8?B?VWxpa3p0dkRJZlNwbzZDclcweisydWgyTDlyakE4ZjdMMy9JeGYxL3lYYmdW?=
 =?utf-8?B?Z0Roa2RSdk90WVlYRXJ1V0x4NC95YkkycWhNUmR0dmZIbFRDVFVIemZhcG1p?=
 =?utf-8?B?Z1NSRWl6bXIwY3ZoVThlUTZSSVBzRy9CcFNQcUZNaW1leGVETDkraWtDb2Jj?=
 =?utf-8?B?S1daZXJaN242VXovZVR1QTU1eUhWM2F3aEhUVGJMOXMrTjhnWlppSGtPaW5j?=
 =?utf-8?B?b3E3WHFRaGpMdUgvZTJ3TFVkcUFEYXI1Q1ZVcTlYU2VGYkM0YmIxUElLdDVU?=
 =?utf-8?B?Sk9PWDZrbEZDbjdHQytzTml0RTkzYUVWbDJpRGI2UGRMVE9pZlY4L3BqSW9y?=
 =?utf-8?B?MUZGdnRpZ2lSNnd3OStQeWJ1OWNoREY0dzR2QW1YWGNtSU1EdTNEUWc3cy80?=
 =?utf-8?B?aHoyQ3VEOWZGbFNyWmRlRURZQSswM2U2QVBIWGZ3TXAzUEhmNWZJMjVqZTUr?=
 =?utf-8?B?aWhaZitTOXZxSGJGVThXUUp4VWdMbmFQdEJJd0hNcDBTb2dWdEl4Z1dDUktE?=
 =?utf-8?B?dWNpdDFjKzRXNitSS09NTERIbHVXc2l3dTFHMmFFMzJEVStwM0F0UDgxcWho?=
 =?utf-8?B?Ni9Jbk5saFhrV245TnQ2a2tEMFhsSGNYOFdhejRoNCtjejNqb2RiMk9ZcFY1?=
 =?utf-8?B?VjQ2VjdQMjgxUi9NZVNmdHVndzJDZkx3ODlINHE5bDl6UWpOanBWY0ZPQ2Ev?=
 =?utf-8?B?ZVc4UFNrYUVWTDVwUERmWkI0aWhwWTNOYnhyMGUrbDNBOGpnRFlnTzR0dkt3?=
 =?utf-8?B?TjNtbk5sR0NTYjNSQWo0dlNXT0t6WGNGYWtRYzJkU0lvMWFqVTNqT01kcFlx?=
 =?utf-8?B?a0N3YW1KTEJLYXdrbTNlUjVWaENkaFk0cUlJZXphV0xWNjZmVGkrV0hpQUhy?=
 =?utf-8?B?N3g5SWFRNUljQXk3Y1d1QlJFdzJkV2IwVklFTTc2ck5Hak1DVml0MmRIaXV3?=
 =?utf-8?B?REs1WDdKK0YyRGdwZS95UFpVSGxXMTFIL0FxVmU5MVZxQ2UvZEd6SGYySjBN?=
 =?utf-8?B?VUN1cWR0TE9udU5FNWhOTmN3Z1g1RGVUZEV0WHoyYmYwT1hKMzNwVnlFUHIx?=
 =?utf-8?B?YW1WVjB0bXdzSXkxdVVNZ0pITVFpR2NmRWYycjQzSDlKdEtxVzBMRVJGNXY1?=
 =?utf-8?B?aFkzL3VjRkk3QmRXNGF2UnQ4UUxUU1g0Rnh5alE1VlhaeEY4VVVQT1ZmMHkx?=
 =?utf-8?B?ejNPVHhFdHc1US9CRExERVBUb3ZaaHZHV09wM01SOW8rYm15ZUhnSCsybUFS?=
 =?utf-8?B?QTlYYzB2YWF5K0UvNVZObUZlUzg4cmJMQzhyamFjQmpYUTU4OUg1b0ZxNG9G?=
 =?utf-8?B?UmRoYnc4MDZEUDlMKzMvMTY3VkNqOTBkK3BpS1JVcnJVM0ZlcC9OejEvTUdl?=
 =?utf-8?B?RHB4d2dPN05ZeWVBdkdHV21zZ2FHRVF1K3k2ZkpXZm02U0Fyb1dFQkh4MmIy?=
 =?utf-8?B?RkdXbDBUMkE3ZlRzMytHM2YxV2NMdFVIdlRTRWZuamhXajQrbHZsaGJwSm1v?=
 =?utf-8?B?aElhMGVaNnMzSWhwOTY5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZENXNzczRFdEJXSXI3OUlvZDBEYTJsTTFLUFhsU3Mwek5ycXdUNHljQ0lW?=
 =?utf-8?B?V1F4UU5Nb0RuU2ZPdHZnTGNZeUhRUTBJL2hCV09qeGRITVc4T2ZscURpam4z?=
 =?utf-8?B?N1ZVRDFVby84MXZvdlE5eFkvdStJclNuOUlLRUtHdmtTQnVDQitIQXErZWlU?=
 =?utf-8?B?ZXRRaGRReGhlb1FBaXJWWUF5QnhaSHYvWWZhd0IzOU1JbHFYL0dEZy82cFhY?=
 =?utf-8?B?TDdkK01JMDRNS1JBaytTcXBOUnBldUxMSUxwRDU4ZE8zd2JZUExidHV1TWdl?=
 =?utf-8?B?aExuS3k3aVhkNTdsM2pMS1hydnI5dGxjWWpZcXpIcjF5aFZiSVdndFNhRjJB?=
 =?utf-8?B?Mm5NZFNNN3hLNWVleGN0RG4zRDdJN1gzTWRhZDZnN2YyYjl5K3JBV2QrUndX?=
 =?utf-8?B?UlRxeVkyQjZmUTVaZ1JwRm9YVnhWVy9WNk9mdm8rS011VzNDUzNValZjVEZW?=
 =?utf-8?B?WGt0TmtOM3ZPZzhHdlhXaEdteU9FVmFiSXhFQjFlTmdNQVlQN290TENSRFRI?=
 =?utf-8?B?ZnB1NkNMNm1Hb0RyTXdhQXovM3BJUXVRS0x2aktoQThqYzY1WHZRYmEzTmYv?=
 =?utf-8?B?L3ZiNkdHalBnc2FNUkdhdFl1ZWNUb2lMNk9Qd2pQb0JuTW5EWnA2Ri9LMjBS?=
 =?utf-8?B?L3E2R3A5MWFGT25RU3paekwzdmxYcVlocHNUVWJ4bVBmRThZeTNnVVQ1bjJ5?=
 =?utf-8?B?QUYybmphaVhGTm1EeUNYQUpxV1psNjRnWFBBYUlTWHVhcXVXUXZrUjhTOFVW?=
 =?utf-8?B?UWFYaFBlY2gvaUNaZ3pCUU9DZmNHVlVzM2VWYmN1azlYUlZEbFpRSElGZHNk?=
 =?utf-8?B?R2dCSXdFVmRseS9kbW5WZzVySStjRm9hdW9GY1V0ZDNReGFaV2J5TzNPYXRE?=
 =?utf-8?B?aXZMT21lTHViSThnRDJnREt4L1FhYnB6a2FqR0tVbjRuYi9IeGV4Y0N2WVJV?=
 =?utf-8?B?NjlaOUR2TmRjaVcrdmt4RzkwM0tzR0hVcFUzY2F0dnV0cm1tYy92WCtxWGo2?=
 =?utf-8?B?bnB4R3NyTXA1N1JQMWRGMVluZG9kU1NqL1N6QmEySER1N2VRK25PQjZQR01R?=
 =?utf-8?B?QStZTlVFNW9YOU1VSDEwQmM5OWxEWm5XK0kzbytNVTkwSlNFY2RYQVVFTk5R?=
 =?utf-8?B?V1dXdHVvVFd1aUVMM3FOcG80cmhIajdqcXl2NVdVbWdQSEhsUEtLSFJUVEd1?=
 =?utf-8?B?MkRpY2JTRnEyR1ZGRnhDTk1KTzQ0RFVua3Q2SUxjcGNjWUJYSmxyMFhkbnlr?=
 =?utf-8?B?Qy9GS3NnS0RuR3ZuR2xIU2hHOFNpRldGODNhSVVBYTh5UXVOem91a0JkeGUv?=
 =?utf-8?B?T1l0Q0Z5dmhCWmdFYUNON0RmL3pHM09WMDdncFIreUpCR0xjSk11NE5OM2JW?=
 =?utf-8?B?dHlsTjRaRjk1RS85ZFZzSFBJd1hnamlUelM5QWx3bXVkdFNrYVFqelBGOWpk?=
 =?utf-8?B?SWYvbFQ4aVpkQk9XOG1Bd3FyVUlEVDFCNzUzM2poazJXYy9UcGVWYzF1UExB?=
 =?utf-8?B?SFRCNUhSc3NOZ2hKWERRNkNmM0JrMTMzbEZFUlpqL1BqV2wxaW13SGFyOG9L?=
 =?utf-8?B?Tk5nTFUvNGVmM3VHOE5iQ1pITlBOVWJjOXJRUmVjazVhaitDVjE3eVFiOW5l?=
 =?utf-8?B?eEUzbEh1Qk9hOVdaZjI2NHlLRTlQWmx2R2xmQ0tVUCtpa2VtZFhiNHBKb2sv?=
 =?utf-8?B?YUFDdFI2WFRBb0NjdWxsNWlmd05lbnBrZ3RxTEZtZzBGMG5FcU81SWFBbFBz?=
 =?utf-8?B?THI2bHl1SWgwUWlSZ3lhOE1GYVRVU0FCaW1mNTJTQ0hKQm9hWE5tWkljZGNC?=
 =?utf-8?B?SFlJcUVXdmR1T2hDODBKdzVaWS9VclhtK2ttVVJwT2x1TVBVaVJCWG9yQ0w2?=
 =?utf-8?B?SmZzc1cvc2RGOEw5Qm1GY0FPYU94UHNHT2xsVVhDZ21XT1hibm42QmQrYnQz?=
 =?utf-8?B?L1BuYSszU1JjNkxnNUc0NHFUczRZYThVWWhPU29PazRKY1l1Tm0yaXhnYlFx?=
 =?utf-8?B?MFcvdUIxWU5FbzRrY2RxT1J5K1BLRFRJbDdDV2NWeW9jV2dLaUxvOGtPeFhs?=
 =?utf-8?B?S1lnTWxKcU82ZlBtdW9Xek5PM0pZYVR2WEF4NEdDcFRKSjh5YTdqcnNoYzZw?=
 =?utf-8?B?VklnL3J2Zm54Z1BCOHNYdU1BQnREK3ZUMWQxd25lV1d6WHQwUFpzaXdDSkRs?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebde8ee9-bc0a-4dc8-8f53-08dcaa2fed86
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:23:20.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hotm2J6PQ7TwTm74/DzFwC8dDE0N9ihDdkUR2pWseatK2mYUHR0j+kJRg1QZxTpM0Az54Enp1Nv/0ADh63N4i1MQFEvqzblrEZ6vzgMLD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com



On 7/14/2024 4:23 PM, Jakub Kicinski wrote:
> On Fri, 12 Jul 2024 05:32:48 -0400 Mateusz Polchlopek wrote:
>> +	err = devlink_health_report(reporter, msg, priv_ctx);
>> +	if (err) {
>> +		struct ice_pf *pf = devlink_health_reporter_priv(reporter);
>> +
>> +		dev_err(ice_pf_to_dev(pf),
>> +			"failed to report %s via devlink health, err %d\n",
>> +			msg, err);
> 
> My knee-jerk reaction is - why not put it in devlink_health_report()?
> Also, I'd rate limit the message.

Hmmm... That's good point. I will talk to the author about that but
seems to be good point Jakub.

