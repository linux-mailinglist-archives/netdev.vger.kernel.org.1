Return-Path: <netdev+bounces-126806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A645A97294E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2255C1F23002
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C0170A15;
	Tue, 10 Sep 2024 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XU4JkUCT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42B1CD1F;
	Tue, 10 Sep 2024 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948777; cv=fail; b=uQj62dpetUk11SALltFi55KmY1WRZTWJGUFVSVVHL6G4S5kGu1n8OKgfaNySL395pzZg/mFXR21eJ0ztafot/uBMCULi75Vv68Cr9rQiaV/8q+zME+7Fmh/0jymNxpVuLK7MCHLfpszXeGvx7ynudQgW2edP7DYkUX30tA7ENqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948777; c=relaxed/simple;
	bh=MKYcJmnV4hEt+NE8Ou/BuBY6+ruD+b7fiweT3o1Ofj8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KSKlGF2juMaI8A4LUlZttnT2VHzIwV0TanLyokhOQzDbxkNX6qiEuhqaYiqevyXvHGSZth6oMCOlTH7bzo8ej67aGU9wpwJoylgoTxnYqnggOmiE58/ziULwOQvsLy5u2+CfFSJjXffpOYGqohgH/4JQIk6/kjR3rGGd9D+ivCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XU4JkUCT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725948776; x=1757484776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MKYcJmnV4hEt+NE8Ou/BuBY6+ruD+b7fiweT3o1Ofj8=;
  b=XU4JkUCTKw//8YLhuaMqaOOSnxG7J3pVWRmchFehElAWeWyDfH+gxcHQ
   NhRS2VUDyIcbCB9c3LWfc3MmxkbxFhJbHhNijlNlJz8YxBY5ImUjabNXk
   uyQxXDNikXZZGwS148CsiS7qdus9U3DjgBPHuG75L15i6jSaGQk2LnsV7
   ul4s0el8ObhgJa9KkuOS1lnk6Um1YbHsAb5KadOo98GdSlucgqWTEVlOi
   mocYNpZbTsm1diBpl2d+vwh5cgBp06ob0lJ7ukcotW4CVs5lbJY76qY2Q
   k5zDGOZchc9bqU88osjat+B7ODU5dlAjU54AJPXQfq3+xLe6U0fVZLRfX
   A==;
X-CSE-ConnectionGUID: 3kHQEJwpRhqgJHUDUeiHeQ==
X-CSE-MsgGUID: pe/H3AXJTdiZqE4+lKRIsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35815329"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35815329"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:12:55 -0700
X-CSE-ConnectionGUID: j6Foc7H5Q26GWxQhLH7wzA==
X-CSE-MsgGUID: RFxBotWFQ7KvV8XZEE8Uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66935301"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 23:12:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:12:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 23:12:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 23:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkjIdjWpIxQg19T1xAhWaoPAzqGHRlVOxqH/10B453WAA0cJ63WN/ujrWill0Wj/aoWjJGYIr2s4qtr7o6ppbtTJ2Wvr/RD2KGEuCgcqYmimZCE9X3DyMUi1CUEJwTnUrJYmu54wpXFqBQsA3euYS2QzAizoXeExh9F5S+T2R9IPHbAErxkkWf1+MM8ydWuTx0SVEMJdflXAZSlm4CF1FD2SJ3+t2rBnDs4bzwDTUSA4rQEp/8fOjF0yqmFvvtIcC6Kxn/oTax6ocTKWg5ZWQX69hmqm0payMO2mOhKe2TomZe54V1emk/qZXvq2Bfj9ri68G3VoWRjvpi+k//oSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXEFBekYk1kdHWWgZVG/bW2HmjC0ixHDOJDPn9OFKcE=;
 b=ceeQVAtOpqaKiE9iTqB1LlAASsOSVgin/TIHKQnWrySI0YfY10k4JpASm1RvKaRvPHn9sbSn/UNYYuHwCVlkWCaEhDQ3S2kdPEOQrpJYBVcYjsdjMgvXmUwE4vGozkiAE1KDg5DC60ND9n9kgpfL7B3fdUrMmdsHLZHXKsSUckUFdu5pj0t4ZFnA2NyPox4mKS1SYaMnG5L1jGNOY+e09mrHkvu71dQC2/cMF8C5Wx3f9VKYYX7fRfYiFyNNXevZB8B9327jvn7DSap9xGmpnXgd7QW0CDUKQ4aQO8iWmhgheo9IjbC2HzpK+hjfG/Bx60+YpqKQQ7lhyurC/E1a5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:12:46 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 06:12:46 +0000
Message-ID: <1041a5dc-8037-45f0-92a2-7ab1ad9a62aa@intel.com>
Date: Tue, 10 Sep 2024 14:12:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 249ef496-9988-44fd-b126-08dcd15f96ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b242VW5NY3lHVWtkK2syV3J0dVlDWGQ5WDZGdytyZzY3MGJvdzZGeWFGWDlW?=
 =?utf-8?B?MzlOczJSTFM3MU81SHNObzJwandCNG5DWCtJQjl2d3BDYXhmZU5Ub1g5aE5X?=
 =?utf-8?B?VmxwWDRkaVNDbWdVSGIwQzJZcnpWVlF4eXRGSlFMUTJ2Z2JZU0dzbnMzRlE1?=
 =?utf-8?B?T1p3MXlwNWlNajJYZVhkTTFVZHZGN3RHVVRaRDMrTk9ualh4UWhZTnQraUla?=
 =?utf-8?B?QzhmUEtoUkJMK1lwRC82SUtyMCs1dk9aNzdJOTdTSzdYVUx1VUFwMjMrK0VR?=
 =?utf-8?B?M1NoZ2hVN2x2ZUVoVjJRK2hjclpKUXM4NmhpRDA1MmZUL0ZrL2dnSGovMS9K?=
 =?utf-8?B?S3BBZGxFMVpTR3l0UzNhS0R3TDkvSzJZZzlsdWRRMFN1NlAzWlZ6UVVOWXdZ?=
 =?utf-8?B?WkZHUHFpTm05SUF6WjNpUmFxVTBIbXEzYVlMN3JmcXZsclo5RDVXNFluaW8w?=
 =?utf-8?B?NEJJZjRlMnpWNUgyWUpNOXc0NlRjRjErN2IwRkcvOFhUajJtRG0rNU90OHdZ?=
 =?utf-8?B?NUw2K0ZONUFKZ0xzME5qTjFJbTFOMDV5enlxT2lQLzc2SHN1RU5UZEFvalhJ?=
 =?utf-8?B?eklKeENVaFNmNkUxcWtpZm9DTXA3M0MrenR3MmtuTEpEMkRrQnhpazRuQ0FI?=
 =?utf-8?B?ajRsUElnKys5aTFKbnpsc1NlSE9laDZaSk1EWURxV2JNSTVDajE3MWtFSlFz?=
 =?utf-8?B?ekVzMFVHOUdYZkFkUlA1di9ueStxTldqZ3dKeHpSY2kzRjQ1MWtnYVgvWDFE?=
 =?utf-8?B?anJyNDJUb2hKZUhDTXE5WWxyVDhHaWs5QlBqVENUQ2NRclpvOWFaODJRQjYv?=
 =?utf-8?B?dTNKNWhCeWw2RHlOWlVWWGtYVGJGUHRHSm40RTJBYkNtYjNvTmxwNW10NVps?=
 =?utf-8?B?Rzg2ZHBPd3I1WG1vUWF5bVV2dHlBblAwZCswWVg1S2xIcE1vZzVVTVg4bjBW?=
 =?utf-8?B?U0FhSHBTM1gxVng3RHlMZGJKWVRNSjMwSlpGcm1FU1lsTEZ6U0EvYkt5cGFE?=
 =?utf-8?B?S3JZSHBkZUszRGh2VXp5VGZjSkh6cjFZVWVZR1BHd2UxaCsyS21CN1JCak5I?=
 =?utf-8?B?QWczQUthYjl6Q3NTVVNTR2VMbTlZWTBTUk0xeXBoeThGQ0FJVklMTkhyMjAx?=
 =?utf-8?B?WW96ZHEyYTcvTXY2YTBuKzZFQ3JiRisvL2RmVXozM3F3ZlRSVTQ4Qnp1eFF3?=
 =?utf-8?B?aElCSWRyMkc4WlkzTEJrMC9UT2lVMjIwSTl2WkpkNEUvK2REMjdxMFhzaVhw?=
 =?utf-8?B?VUpFdnBacEVxSjhBclVKSWxkbGFLS09JY1NROWJtWHE0Y1d6dWF3YTdWREJr?=
 =?utf-8?B?RW1sdEwvWXp1Wk00MDByODA0WDVsbHVGZHYrYTFCYVFIaEkxbGJkR296c0pS?=
 =?utf-8?B?THVkSG94aVRPSVc3WGNXeHVIQXNGRTZkVHhlL2ZPcFFwZHQwUUFzbS9aOG90?=
 =?utf-8?B?VXEyeGluYTVUVVhmdTE3MWJ3ZUJKb0M0NzZscW1oTkxEVG8zOGllVXZxdUN1?=
 =?utf-8?B?bkNsQ1I3dDM1VmUwWjg0VHFNaUE4Z3JsV2lKNVhOVTcwUFUyOTN4Y3krV3k4?=
 =?utf-8?B?b2NBS1MzZ09QQ3owRkp6aTN4dVYwb250RVdnRGx1Y0lmNXFqZGU4aXVlVVUv?=
 =?utf-8?B?VHdBTm9xK2JLaC9sZzRxWFBmRG9XZ3JMNERQTFQ3VDNJZ3FSelF3Snk3Nndj?=
 =?utf-8?B?OE1pR0thOE91dGpmMU9EK3VIS1RqM05xQlprcmxlaEMvMmhMQ1ZTRmlsVHpJ?=
 =?utf-8?B?cDBlSXhOWHVOK0hIeGJRRW5aYjE5MzFoazdCaHhKRU5vTmUwTVo2TGFRSlJF?=
 =?utf-8?B?eHVybG10ZmNpL2tsRXVPTjNOT2lHUTRCZ2h4Rktob0djU04ySEJ1TWdkelBr?=
 =?utf-8?B?RmZxeXJOckcrbkNKSE5Db1FTam1wUWxHeW1CSnVpYkhObEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZMK2NzSjhONE1iZHg3eXY0UmRuSDZsbk5XNEtWWmlLRFMveFZvUWdWNHF4?=
 =?utf-8?B?QVVKcG4zdFFCQkF0Q2F5VlY0eStwUi9EK3pYUnBQTmZiMXdhZE9hY2R3cWR3?=
 =?utf-8?B?aWEwd1FCSTRvbFc3SC9IM1BNUEZmNXNsdDhIU1J5ejFydklHMk5wUGhCWHVP?=
 =?utf-8?B?SlFxTDNFaTlPRnBaNlg5VU11QUdhT3ZTb2Y0R1NxcDBlTjdBZ2l4TzRDaWJm?=
 =?utf-8?B?dU1mZG00NHZJZFJOcHdLZnlzWUI2ajVlVTVBMEdOM1BQd0FVT2Z0d3RZeDVS?=
 =?utf-8?B?aUhoU00rVjIvNWJaK2VHRldQUGhZVE9FKzQxOVFsMktwemY1R3JGb2NvdVE1?=
 =?utf-8?B?cU1SZVE0aDFSR2hYanVROThiMytsdEhqeExsYmE5K1pES25WT3JzQVdlS25k?=
 =?utf-8?B?azVGYnNLS0tabFZ0WVlIS1FZQXhkNFFndGFLSnNTbHEraitMZjlPZlM5R3ZB?=
 =?utf-8?B?enVsYXQzWm9NR05IOTl5c2VnMmhUSkZLRnlMWHpxRzlPdkQ4SjhuZGxUTG93?=
 =?utf-8?B?Ymw0UkdjL2NqMmJHMjBDRWtPa0MyRU9TaUFpTThraDRIYmhlUGhtTFMvYisv?=
 =?utf-8?B?aW1Db0U0WHpESEc4RG9BVjNTQmlvbzlVS0huUVdRL1V0em9pUlp3bVdrdzVh?=
 =?utf-8?B?U1FZblVEZ3BzV0N2Z2VaTjJMcC85aWFDR3daTFVISi9rSWVhSm9oaktsckl6?=
 =?utf-8?B?cXhucXExZTdOclVqMXFuQmtlZzQ1THRLbXVMczFKNTRpSkpjN08ybng3UEVQ?=
 =?utf-8?B?bVhkbWRXMmtWWWtPZjhtc0RwRkxzWldOOExIOHhZLzY4Sm9EWTluVnJVbXUr?=
 =?utf-8?B?WGRENTM3S0l0WHBXSzF5VC80T1lONkdsL29LamVUWFRYTWc0NUlFb2srRXdu?=
 =?utf-8?B?WDVQMjBPVFRrUjZwNlRxYUVOTG1tZEN0U1UwUXJyRkJaZzJtM3ZmaXU4MDcx?=
 =?utf-8?B?amZFMHo4ZVRGOGJxR2RZWkc2c1hVdS93UUhNcDE3b1QxUHgwT3hkcVBtbGlE?=
 =?utf-8?B?V2hGeENRZVlTemVmQ0o4WFhhWkR4eTJXN1I2ZVNmK1RwVGZoSE00N3VSNjNS?=
 =?utf-8?B?MmRKLy9IYUIwK3N6NHVkN2M0b0FrVXVHRXJMRjhXcno1NnB0bzhzVXVVMjM3?=
 =?utf-8?B?VnhEdjNjK1BieFUzU29FZUhtRXJIMUNvemsrZk1rb3V2OHR0VC9MUHQ3ZVdZ?=
 =?utf-8?B?UWpDV20xNEdFTXlMTmZxUlU0Y01sdzVOcDlBaThLY2JHenkrcnNkL3ZtSW9D?=
 =?utf-8?B?NEFFVmRVYWFoZTlNMFFEc0pVdXdoRHg4aUhWT1hqZUZ2VFhkN2pGaEVReFBG?=
 =?utf-8?B?RVZIbTdEUG5NaSt4QlZDdHYzUVZrTVR3d0FzdEVOK1RzVnJOb2lEK200WXVS?=
 =?utf-8?B?eUQvY1JlZ3F1RmZHamppUFZSR1E2QUw2NCt1VExYaTZ4NlNxVnh0dW5sOGNw?=
 =?utf-8?B?Mm13amNjK2VFSmtOWS9KOE5zbmdQd0VTMEc4R3hPbjdpK29JTXNsMXZnS3o0?=
 =?utf-8?B?RGllVXk5dHhOSlpPdjhzWEprRTZSRFZZbzcvRmlLMVdPNFBLWVZmNmpLanV6?=
 =?utf-8?B?YnRjZVR1QTJISEE5elRna0R4N0RsTHpKN0h6NlFYSHJJOWJCZ1NPbTdJb0Uw?=
 =?utf-8?B?S05MUFBzdG9YMDl5ZmhsbXkxVTJQNUFjUk43SnF5UnZTUDRSa1hLNDAvS2lu?=
 =?utf-8?B?NGdRSWlOak9IUWNYOVhFVmkwU2MrejlnL3ZiekZQd2xNWjV2djZVdTgyN0Rs?=
 =?utf-8?B?aFZjcU9GYUhlUEJSOVU3OW5tN1lmV2JWRkFHZTlIOHp0ZkVGSGV5RytUQzRN?=
 =?utf-8?B?cTZSZU1pcjQveVNyYVhrTUppbU5wSkQzcDk3amxsNjRPN2VUTDUxOFhXbGJp?=
 =?utf-8?B?alBhOE1mcFhEM0hQaTRIdnoyOVVnZjd3RXNZVGpDaG44U3ZoME1LVWMyQ2Rm?=
 =?utf-8?B?dEtCaUlxeCtEQVBmNlRpQk5RK3N2c2JmYm1sRmtqQnBtUHNvL0tXUTkwcmEy?=
 =?utf-8?B?ekt5TkRjSi9OQXVER2duZEhwYjNlM0llUHZ3TjMzSDRFSnFtS2tIRlA2UmRT?=
 =?utf-8?B?SUZEUWRWY0IydWNVL1ZYaStnWXFQamE3UGt6OTlqQzI1MFB2cXM2SkRjZm4z?=
 =?utf-8?Q?MAGCwfYHTBw2qILiYLn7TWubo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ef496-9988-44fd-b126-08dcd15f96ff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:12:46.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTVDlVtmd9jncHFzJxG2xER4/SDNZ6Pu3ZNm3t+H4Lckk3V8DvjXRbtR+qqswuZ3YtnGZ/ONKWlZXVVabkDY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com

On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Differientiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
>
> Create accessors to cxl_dev_state to be used by accel drivers.
>
> Add SFC ethernet network driver as the client.
>
> Based on https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c             | 52 ++++++++++++++++
>  drivers/cxl/core/pci.c                |  1 +
>  drivers/cxl/cxlpci.h                  | 16 -----
>  drivers/cxl/pci.c                     | 13 ++--
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        | 13 ++++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 86 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  6 ++
>  include/linux/cxl/cxl.h               | 21 +++++++
>  include/linux/cxl/pci.h               | 23 +++++++
>  11 files changed, 241 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/linux/cxl/cxl.h
>  create mode 100644 include/linux/cxl/pci.h
>
[...]

>  
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> new file mode 100644
> index 000000000000..e78eefa82123
> --- /dev/null
> +++ b/include/linux/cxl/cxl.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/device.h>
> +
> +enum cxl_resource {
> +	CXL_ACCEL_RES_DPA,
> +	CXL_ACCEL_RES_RAM,
> +	CXL_ACCEL_RES_PMEM,
> +};

Can remove 'ACCEL' from the resource name? they can be used for both type-2 and type-3 devices.


> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource);
> +#endif
> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
> new file mode 100644
> index 000000000000..c337ae8797e6
> --- /dev/null
> +++ b/include/linux/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif



