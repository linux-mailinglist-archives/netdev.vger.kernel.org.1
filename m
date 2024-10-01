Return-Path: <netdev+bounces-130972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5889698C4D2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4935DB2225C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43151CB528;
	Tue,  1 Oct 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azzV+i62"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942515E97;
	Tue,  1 Oct 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805175; cv=fail; b=NGztnsbprGZPxgX5uHt5IJ02sGJszf4G5qSSTRQ76dRFLojViYouHdTPeF8JQr5hT1Sjk+otJyMOOXeWQ+NNuCt20e9rQkWMhEdrq+6yTSEUnL7U4TCo18UGdGY4+1jdYV1rYMx6u1VTS9429E/DfZYf/YAo0dhaArIqMJlwMp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805175; c=relaxed/simple;
	bh=mBhYpO4zuDblhPRUsf4L3yA1bi4b5CUy+SwYenrE1bo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZRdhfk3SeNqKUTjHGjCXhScHZl+DKugAvq31czcCdy9FnInlTvIHO+v0TM8ZRi6zxpypuuUmCXlx0c/Mlzlr1AA08RkLC4HDrB4J2vHrCBa2Rkj1wXupsBJFEIcMWoLAGfSIFxPW66mvaucdPQ4xVNnoOgojbXPYvriNxv4yU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azzV+i62; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805173; x=1759341173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mBhYpO4zuDblhPRUsf4L3yA1bi4b5CUy+SwYenrE1bo=;
  b=azzV+i625ekMYWFvdXmba2HIGgm54VmOAzG1TU1n205sLC0fCWdKo2yL
   XwLAEAqrdO2Jv9e/TuDPQ2VV1zPgrGOICDbdktU3XChbuxx5TByXhHQpz
   Gz8Mm4jB5KzqpRN8UTeMXKDxaJMKgVkKPs9RlPQiOcCjiECWch+HHAMl7
   T7CXWu5L1reC7FZ8sBkwOrA9Qs7zzDuocOUffjyUgq3uTLTsnxerQlV7Y
   bUm00VpJ9+HpW5VFI10J3hHTNKmctMqW58Ifn95CGazaDHp29uVSW40Cq
   yPZgoHTmnHNpaxkR86h4sv1ukGnCf9Z9C64kjNBaW6Wge5bfYyfXi7Yn0
   A==;
X-CSE-ConnectionGUID: vF57IPlwQ4OJF52E1RD3NQ==
X-CSE-MsgGUID: WA1S7PiHR1O8zmGP0OadcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44416937"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="44416937"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:52:53 -0700
X-CSE-ConnectionGUID: iBgtCYiSQPiUmgh7wCT33Q==
X-CSE-MsgGUID: HqYMFOkhRMW4mZjbyFQASg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="74168878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:52:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:52:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:52:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Otfbg4CIAydxAdg54GmnVG/Vk7h8V/HUQ1m6/WVK0Fe7OCnXupLEP4ZF+ssOlpUnf2b7HBc5OX4v7SYKiK6P+cv8DCy/zMNpi47V6yFJkqHSP3R6hmkpEK+G6HvdYDzGu713ez+tXKMYaTVZBwlkCOX9WtpDrVYuPGUI03+Xol7TzK+D+hTwo83BlUVokAbf9YyWlIA/pBMvWZ5/ilp3EoEXce1cM8hbTFJ/XuhLoSmzFAH7fHuWKVpwLvvkv6YWKGjYSL/p0trY1mesFhNJNWhe1ieQ6TlwzNW8P2glQIjatgm9E5QoqfpxzkPQVO+p8XxcKG94QWxnjOlFvacSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpGzGCy13KKwBzLeA+PgPI1UGfXCabzRFinrpb82HbM=;
 b=Wf9qHS+2ZJClLtYweRkrQ6yBZIwQ/VWQIGT+V+Hzsxi7wcj21Z1Pd+lorpIfJJPXBWNy4M087ZGMNLg5NqkuHssGIqLnY/QQPT0UQjTIuHyByS8MAHmRpdYdkV7r2fYkYf0+Z8/SR4XjOMs4phkjDdCYka1QQnaDRfIM78nwKgnngdFIqMqdNvNRcWr7EFXRk6hfbg9alKr2/uQmSbPJGBRSgGb1YbRv82jp8wA8nkZpu5tLJ/5TsAyCgr+aJnCwuf9/4umuDe3P8md0cWriLBzmvKxQNbe93DHyqKPxV662x9B+tYT4v4jfgHh+2/9gzbSLLh3wV1X8mCiZ9mTSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 17:52:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:52:46 +0000
Message-ID: <61470f4b-2cc6-49ea-a94e-35df1642922d@intel.com>
Date: Tue, 1 Oct 2024 10:52:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/15] net: sparx5: add indirection layer to
 register macros
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
 <20241001-b4-sparx5-lan969x-switch-driver-v1-2-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-2-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5994f15a-f2a8-4812-9a31-08dce241db7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1pza3NFVEIyMStORWxWckxmWkRuMWtvYk1pVDlseEo5eHIvd0dZbFZiUkVn?=
 =?utf-8?B?YWxpVDh6cG1pV25oMFRmSTFLcXlvdEJhbkJSMUI2Wkg5MDlmWUFlWC90dENR?=
 =?utf-8?B?S3BFTXJkTm9PWTZwS1pmdUljR2lqRGhxYmF2R0d6WitQaG5BUHpSZ3VySVFO?=
 =?utf-8?B?bDhJRjFyemlPR1lyeUk0Z1VKR3NCVitHK3BrTEVyV1lGQndTNmtONDBadERk?=
 =?utf-8?B?Slg5cXRMeXo0U1A4czBLTEZ0cUE4VWVDNnp5Z093TkNkNTFXVU9hd1V1K1FX?=
 =?utf-8?B?OGFRMDEwcXRIck5ZaVVYRnREQnB3SVY0RldmU2pLUzdDOURIbHVVaU1LMlYv?=
 =?utf-8?B?SjgwZTZHZUNGQ1J0YVh5SnF0ZjNpM2RCRVcyN2lOMU1tOVl3Q2RsdUI4bzRM?=
 =?utf-8?B?cVZBTXg5MGg1eWtiQW9mM2IwRFdJYUNUUnB5UWs0eFJpK2VQejBHNUpNcm5v?=
 =?utf-8?B?bjNNSjZ6OGVsbmYxSWh6S2sxRnR3dlBSZWxFRnhCMjFDVWdxUFovNHUxUWFB?=
 =?utf-8?B?OW5XRExvVWlhTlhSK2dVQVVjcUo5V0FTckdLQ1RjOHVWV3VobEl2anJ2Y2Na?=
 =?utf-8?B?amdzSVZDYVlIdE14cHZmYUlIY3E5aUNhRENTSnRzNG9zSkk5Rlg0SFNvbTRX?=
 =?utf-8?B?SnlpcGxnVm1meW54ckVVRGo3N2tzZVhycTVkemY3UDZHUjcrbXhMMmQ2cGxo?=
 =?utf-8?B?a21DVWJLa3AxQjQzUXBSSlE4VnBLTUVmeFphaGowTnAvQUhpSnBsZXFYY0hq?=
 =?utf-8?B?MXZ5c0lBZ1RSamIrZTlQU3pTa291ZzB5M04wWWlFTUVrbXExT20ySG9qMnBy?=
 =?utf-8?B?b1ZBZ1NRcDdHVXRVSmk0clo2OXUzUVBrNG5uOTBabGJCZnhCaHduQjQrTWhj?=
 =?utf-8?B?aE5OWnVsYWFaS2NmTUpCeWtvd1RDQVNDODgxZVhFT2l4U3Q3a2FnSElwZ2ZS?=
 =?utf-8?B?NXE4R1UzY2pBYVpVRGpBYVBKMHNBQWNhMGg5TVUwV2ZMaDFQWW41T2hWYUJu?=
 =?utf-8?B?OXA1MVVUNUwrUnRXV01VZEVBWmJPVmIvS3BRdEwzYXRZLzdKd3VhZlduVHA0?=
 =?utf-8?B?em56OWdTK2dBa2tGd1djeDVUczVLYUtVby9LWUExbnZyWmF0L2hXekszYzgx?=
 =?utf-8?B?ZWxkM1Z0cVVtUm85NUh0T3Q5MmJMNEFQODh0aG1UaWRoYkRkWk41aFdrb1dl?=
 =?utf-8?B?QWkzU2NIRFU4b1JaaVlHUnBuRm9sdWhJUGFDL2NoRXFDaU9nbVBHd0FUUy9Q?=
 =?utf-8?B?bFdiaGI1L0pMWUt1L2h1d3ZheG9kblFPNENQNjJndHh2bE9tTENxVXU5Ym5a?=
 =?utf-8?B?UG9uUzJ2TlkwUFlGOVVickd1MXkvdWlhdXppalNxM0l5a2J1b3FYU2tRamM0?=
 =?utf-8?B?RXZjSlZXcWhHZmRCcHRDVWJPc2kyOUJJODJOaDNoY3hrYWU0aG1lSk15cUlT?=
 =?utf-8?B?Q0E3cDRkamlaNitZV1djbVRudlNaREFxWThwMVdFNWFaby9RVk5Salhwcm1o?=
 =?utf-8?B?NDdDM1dqZWhMcU83N2NxdStUTUZQcWsxTEJabXU0NjViWXhoSTFoaXN1dldL?=
 =?utf-8?B?MzNOVFVKVEUyWjFRRFJZeU5yaU9WekJ3cHh6V1o5ZjhNbm5pVkx1NXFTODJl?=
 =?utf-8?B?OEdTM0dseUhaSDlBcDdEWjI0NTBwOS9uZGFUc1dBZVd1M2U2VGhIREFsaUJO?=
 =?utf-8?B?UmgvbkR1Z3MxSkdUelZHVkwvWDY1VUFvTU1yUjEwYjNmZk95ZFpkRXZEQzNr?=
 =?utf-8?Q?MWoFHqLALNbJoG13OUWYchX0A807cCVNMoUPzDU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y08zeW5DcnBLOWZwN3NHUm8waXlUN0N3dTNGZXpPaFJ4RTZ6bTZoNTlCekh2?=
 =?utf-8?B?OVM4dkJUU1JId2N2bWNJOWhqMEdGQ3BydGVFSFhaTXVTMk5PM2JYZUI3N0o3?=
 =?utf-8?B?OUJFbnl6NDdRT2ZhNWRNYWY2SFFXNlRYZjVjZWFESHdDaU5iNmZBZzJVTUpW?=
 =?utf-8?B?SUJtb0JNR05PSFlicHhMeC9JemhYUkU0d0tWVUMrWWxMYkpjQUx6U0dneEh5?=
 =?utf-8?B?bk9NODcrRXhRaWxGT0J0di9vQnQxVVZqaGVhZkw0RFJPblJyYncxN2h5NWsy?=
 =?utf-8?B?RHBGVEZydlE0OWNROUIvT1pUanB2UjVtdGhRc21lK2VKWTR1QnZsMjFUd3hQ?=
 =?utf-8?B?ZTR4anNuU3k4cjJ2T2haTk5CYTR5OG1RMjZjemMzVHg3bk5CejExc3UyRHg2?=
 =?utf-8?B?bVRSRU8yUXpXQnBzOXNPSE8yaDE1c0IrVUhJK3BLd1ZpWVRTOW9ya0FvZzlU?=
 =?utf-8?B?ZHdkRklNQ0ZQZDlDVHpZMGd3RHNiK0tOQk1kT0phWTRHNW1IL1pSSnUvRXVl?=
 =?utf-8?B?QUtGK1F5Y0NpWHYzbVhLeFF3eXVkR1BiNVRSelBFYUx0c3UwNVVsN1h0ZUdQ?=
 =?utf-8?B?RUNqeThiS0E5T1hSU0ZnbERnMk1TUkpYZ3R3ZC9PU2FRMnY0TTBzdnp3MUdD?=
 =?utf-8?B?ZUNuU1F1TTlpYUVaMGdnQWpIMGtVMHZ3WGRxcUp1YXI4YlI1THF5TjJHMkhO?=
 =?utf-8?B?YmVBUnZ2akFJdjZsT3RSRDZyOVJPLytZSHdiWG5FTklqSjZ1bGMwQWlHWHNU?=
 =?utf-8?B?SnZKK052NCtSTGNJdlAvNWI3aVFDc0xoOHdwR2RjNnRBTC8wM0hRRElwQUpy?=
 =?utf-8?B?alhmLzhRTWhHcVVNZG5oYjM5bWwxeG9tOGZ1UFhuSU96THhEYkxnN2Y5dllj?=
 =?utf-8?B?R25EUFgxejhyWjQ0TGNRbDFySmRBR3RGZlBZcGpXV2NFQUFtbG5oNmRkNTBH?=
 =?utf-8?B?QzNLVkFDRVI4aUhqbEthUEtOSU9OUm5XaFE3ZzQ2VHJJUXV5Ymx4Tkc4NmxE?=
 =?utf-8?B?d2NVb25KU1I5RFdIUzNOV2ljQ3NhazdMMHlGTzdCeC9pRVNGUlJvNmZKOTBD?=
 =?utf-8?B?eXRzdncyZTErRzdoMWNPQ3k2RzN1NXdCNSt4eEo3anRzTGNzS1Q3YXBBY3Y4?=
 =?utf-8?B?OENvNjQrVHNQVTZ3VThZRkFCRUhyZEZkMVRNMGg5VHByaUFVSHJ6djc0L2pC?=
 =?utf-8?B?WFFqd2tNLytYdHNKSnZPSiszakdZcUFEN3UyZlk0b3FnY3pIN0Q1Tm1UZE5s?=
 =?utf-8?B?aDNXbFlVZldlczViWVV1dk1HdEtYNWN1R2pLNitXR1ZKWS9pVDVCZ2dXbTZI?=
 =?utf-8?B?eGtveVBQTi9tb2pVcXY2Y3ZqOWlOTHc5WVZxSkJBUHJoTGEyQ1dQTTgvNzVB?=
 =?utf-8?B?RFp1ZVE4dzhBOXFUTHJXQXhLdDhWZ2lwT3VDL0Y4R28xYklFandIYVIwc3pY?=
 =?utf-8?B?REZMc210NnExcmllMVJJbkd5MTZOcWlvS2FZMHhCdEp1NEhlUitkUTdpOVdB?=
 =?utf-8?B?N2hVZ0VmRSswcWhEVTRlSUZ1UmVqTTAyejF1T3hTeXhOMkxsQTJJVWtEU015?=
 =?utf-8?B?cDdYSDdJeGo5eWJMVjBUV3J5NVBxRlR1NnVQeGlhbXFxdzZEU3lBL2JLR041?=
 =?utf-8?B?WWJ5VTY2NVgwQjVEb3puRVdkclVETkY1RUpFdEVBZ25YSFpqUHJlY1h2eW1p?=
 =?utf-8?B?M3NxbUkxN245OC9OdUJtVEJqUVJobnJGUTJlbEY2cEx5VTBkOEVvd1JzMElV?=
 =?utf-8?B?NFFPTzVZYXJFZW5RaHlEOUszdC9MS1orZGNrUjQwc1RlWlpRdWNxb0ZGQU92?=
 =?utf-8?B?QytPeXN2eGRLZzM5ZC8xYnB2YmhuQWplUjczd2toakwzS1VtZ3A4QVc4SU5z?=
 =?utf-8?B?dWNwNlN2Q0k1YStid3QwN1gybFM4VVFXWHRCL05OOXE3bFBQbWJyZGF2STBz?=
 =?utf-8?B?NUVHdExScmdrakRTSmZNVHRPSGRRVW40TjkzM3BoVFJOaGk3NVpGL3VUNE9t?=
 =?utf-8?B?dmRlZUFRcXdnNGk2akw1RngvVW11aDdrYlgxVERZbk1TMGhzWlc5M1dhVUhv?=
 =?utf-8?B?ZE9KbWlGeU56M1EvcDZ0TTU1Y1hMMEtNWTZxbTVGMkRnYndDVDNpRkVtMjVZ?=
 =?utf-8?B?TjBVZEVsTksvZm9uVSsvc2UwUnh6VDZZTUxCUHhxZXc4cFZBRW11ZDFrbXRQ?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5994f15a-f2a8-4812-9a31-08dce241db7d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:52:46.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl3pjJN8OqSEapxfjldi1/dvLwXS4HUaU6FkyCafXGJMN0ejEeFScOz/qx9ciMO+BntMPPtZRzDhEbZxMgM+A6ASUWTLoqwibja+y+dgMJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> The register macros are used to read and write to the switch registers.
> The registers are largely the same on Sparx5 and lan969x, however in some
> cases they differ. The differences can be one or more of the following:
> target size, register address, register count, group address, group
> count, group size, field position, field size.
> 
> In order to handle these differences, we introduce a new indirection
> layer, that defines and maps them to corresponding values, based on the
> platform. As the register macro arguments can now be non-constants, we
> also add non-constant variants of FIELD_GET and FIELD_PREP.
> 
> Since the indirection layer contributes to longer macros, we have
> changed the formatting of them slightly, to adhere to a 80 character
> limit, and added a comment if a macro is platform-specific.
> 
> With these additions, we can reuse all the existing macros for
> lan969x.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    |   17 +
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   15 +
>  .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 4128 +++++++++++---------
>  .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  219 ++
>  .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  244 ++
>  6 files changed, 2755 insertions(+), 1870 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
> index 288de95add18..3435ca86dd70 100644
> --- a/drivers/net/ethernet/microchip/sparx5/Makefile
> +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
> @@ -11,7 +11,7 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
>   sparx5_ptp.o sparx5_pgid.o sparx5_tc.o sparx5_qos.o \
>   sparx5_vcap_impl.o sparx5_vcap_ag_api.o sparx5_tc_flower.o \
>   sparx5_tc_matchall.o sparx5_pool.o sparx5_sdlb.o sparx5_police.o \
> - sparx5_psfp.o sparx5_mirror.o
> + sparx5_psfp.o sparx5_mirror.o sparx5_regs.o
>  
>  sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
>  sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index 179a1dc0d8f6..9a8d2e8c02a5 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -29,6 +29,8 @@
>  #include "sparx5_port.h"
>  #include "sparx5_qos.h"
>  
> +const struct sparx5_regs *regs;
> +
>  #define QLIM_WM(fraction) \
>  	((SPX5_BUFFER_MEMORY / SPX5_BUFFER_CELL_SZ - 100) * (fraction) / 100)
>  #define IO_RANGES 3
> @@ -759,6 +761,9 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
>  	sparx5->data = device_get_match_data(sparx5->dev);
>  	if (!sparx5->data)
>  		return -EINVAL;
> +
> +	regs = sparx5->data->regs;
> +
>  	/* Do switch core reset if available */
>  	reset = devm_reset_control_get_optional_shared(&pdev->dev, "switch");
>  	if (IS_ERR(reset))
> @@ -937,10 +942,22 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
>  	destroy_workqueue(sparx5->mact_queue);
>  }
>  
> +static const struct sparx5_regs sparx5_regs = {
> +	.tsize = sparx5_tsize,
> +	.gaddr = sparx5_gaddr,
> +	.gcnt = sparx5_gcnt,
> +	.gsize = sparx5_gsize,
> +	.raddr = sparx5_raddr,
> +	.rcnt = sparx5_rcnt,
> +	.fpos = sparx5_fpos,
> +	.fsize = sparx5_fsize,
> +};
> +
>  static const struct sparx5_match_data sparx5_desc = {
>  	.iomap = sparx5_main_iomap,
>  	.iomap_size = ARRAY_SIZE(sparx5_main_iomap),
>  	.ioranges = 3,
> +	.regs = &sparx5_regs,
>  };
>  
>  static const struct of_device_id mchp_sparx5_match[] = {
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> index 845f918aaf5e..e3f22b730d80 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> @@ -226,6 +226,17 @@ struct sparx5_mall_entry {
>  #define SPARX5_SKB_CB(skb) \
>  	((struct sparx5_skb_cb *)((skb)->cb))
>  
> +struct sparx5_regs {
> +	const unsigned int *tsize;
> +	const unsigned int *gaddr;
> +	const unsigned int *gcnt;
> +	const unsigned int *gsize;
> +	const unsigned int *raddr;
> +	const unsigned int *rcnt;
> +	const unsigned int *fpos;
> +	const unsigned int *fsize;
> +};
> +
>  struct sparx5_main_io_resource {
>  	enum sparx5_target id;
>  	phys_addr_t offset;
> @@ -233,6 +244,7 @@ struct sparx5_main_io_resource {
>  };
>  
>  struct sparx5_match_data {
> +	const struct sparx5_regs *regs;
>  	const struct sparx5_main_io_resource *iomap;
>  	int ioranges;
>  	int iomap_size;
> @@ -308,6 +320,9 @@ struct sparx5 {
>  	const struct sparx5_match_data *data;
>  };
>  
> +/* sparx5_main.c */
> +extern const struct sparx5_regs *regs;
> +
>  /* sparx5_switchdev.c */
>  int sparx5_register_notifier_blocks(struct sparx5 *sparx5);
>  void sparx5_unregister_notifier_blocks(struct sparx5 *sparx5);
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
> index 22acc1f3380c..3783cfd1d855 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
> @@ -1,11 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0+
>   * Microchip Sparx5 Switch driver
>   *
> - * Copyright (c) 2021 Microchip Technology Inc.
> + * Copyright (c) 2024 Microchip Technology Inc.
>   */
>  
> -/* This file is autogenerated by cml-utils 2023-02-10 11:18:53 +0100.
> - * Commit ID: c30fb4bf0281cd4a7133bdab6682f9e43c872ada
> +/* This file is autogenerated by cml-utils 2024-09-24 14:13:28 +0200.
> + * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
>   */
>  
>  #ifndef _SPARX5_MAIN_REGS_H_
> @@ -15,6 +15,8 @@
>  #include <linux/types.h>
>  #include <linux/bug.h>
>  
> +#include "sparx5_regs.h"
> +
>  enum sparx5_target {
>  	TARGET_ANA_AC = 1,
>  	TARGET_ANA_ACL = 2,
> @@ -52,14 +54,28 @@ enum sparx5_target {
>  	TARGET_VCAP_SUPER = 326,
>  	TARGET_VOP = 327,
>  	TARGET_XQS = 331,
> -	NUM_TARGETS = 332
> +	NUM_TARGETS = 517
>  };
>  
> +/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#define spx5_field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#define spx5_field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> +

FIELD_GET and FIELD_SET have restrictions in place to enforce constant
mask, which enables strict checks to ensure things fit and determine the
bit shifts at compile time without ffs.

Would it make sense for these to exist in <linux/bitfields.h>? I'm not
sure how common it is to have non-const masks..

> +#define GADDR(o)  regs->gaddr[o]
> +#define GCNT(o)   regs->gcnt[o]
> +#define GSIZE(o)  regs->gsize[o]
> +#define RADDR(o)  regs->raddr[o]
> +#define RCNT(o)   regs->rcnt[o]
> +#define FPOS(o)   regs->fpos[o]
> +#define FSIZE(o)  regs->fsize[o]
> +#define TSIZE(o)  regs->tsize[o]

This implementation requires 'regs' to be in scope without being passed
as a parameter. I guess thats just assumed here?

