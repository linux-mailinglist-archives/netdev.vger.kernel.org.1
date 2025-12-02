Return-Path: <netdev+bounces-243147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9092C9A0C5
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEF6B34417E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86D1B424F;
	Tue,  2 Dec 2025 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1AXPLeM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138515E5BB;
	Tue,  2 Dec 2025 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764651821; cv=fail; b=lIheDLX49fyWlZ30jXQ7R1KbMTDClW37WgtOS6PgvLr8ZHgkS7mVILn5sn59jqE4RbVsagDM1jkdPVvJlSbYN5v8/hoKJeEjk5RjJOewTba5bNTpT34yXL/J+A29wsDIaDyg+Lh97Vd6D0wMXZko9AC8TVS8cSBcsDObon4Wb8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764651821; c=relaxed/simple;
	bh=RGRwv7lq/GWu8zGbtxMpP9uvTrJGu2ApQtVvLy9CZls=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Wfsub25k6j6ig+Y+ObhRTRAlpbxC5ZFwOk58L4rdB8dptFK8NpciIeZWUz+BPb/dugarOUkrHueIqjohzHM1WUc3L20tgHRYby8xUb0UMXtHmfEyLzWo/zYIGe/wKmwIpkU6WeSKt6RXoqxpCbJuJ3cMuPZnnh4VnNTTxneC6nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1AXPLeM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764651820; x=1796187820;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=RGRwv7lq/GWu8zGbtxMpP9uvTrJGu2ApQtVvLy9CZls=;
  b=P1AXPLeMA4hzXFlNZ/UkvDSYndqCRrB54Dh0Go8PeM9Ma6rJYWnTZ2ac
   w+RqAyksI/rUpXkYNYCIyAafikMbpjqsLsS9ktdT5uo5E0H46t2AWCjfu
   RQJ9nM2qALE7PIvTTK4L/CU73sTlHyiOufeY7S2n44m1E/3W9BmJijEro
   Gp6btLXIy5fBJxKZeDazvFoJ+9tJxrZjAh1Jk1q2fTE0KiI+ySar60OHk
   zQOCs47yIJtM9qMIxSb6uk+Bd69AYnBPRBWYAhdTleh3x5h1/NMd8GkC+
   I1GiwoRvFEBLei8xsmWIojUxHwu3Tja+dCrQUX98nC4wEeoq2jlgVJFy0
   Q==;
X-CSE-ConnectionGUID: f/Ued9Z9RIiaUKvuq1Snpg==
X-CSE-MsgGUID: SvsaaE7PTeWyoG2L/TrW/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="78073517"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="78073517"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 21:03:40 -0800
X-CSE-ConnectionGUID: Gisi8+aMR8y8grP3EYs08w==
X-CSE-MsgGUID: 1Nwa/FJrR7SBARHRmoG3wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="217605148"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 21:03:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 21:03:38 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 21:03:38 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 21:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3ul/dgrDsT52NOWG3nioAHWhVr+9clRVYyo/sr+HVWU4JiVLKHsAdQIw9G1PafndceRG/3c3clmdULiRqT3/nGz3xamFKDgTZLwzdVvReeTrNxwGtXK+okRcgIa09Pwb/bz2DjDU4kzCe7vKtJCgmnaiN21rs33UdLn0KvzAnFk6gfSfkh9vhQmEPxxoOvBzK8fPnytzNi41j93rgelYSLbbcAisbioC87+9vg/X1w/I28Xln4ds6AifD7Tj38XQHGrYdgan3VnZ0i0bgI7GxLZfwrgEG+VmHp5u+gl5zwfNgZcCL/OxLvX1tXdzb6REcA5ckuWX9l8WOWGPop1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DBaP6XeLAqaeFzyrDt+mHYevgz1qK9q+9w9JjIWFBs=;
 b=MyLa6nPhbHp49pI+GA8UnprEsNBZ1KRgTMuWGDWPmDSVLAIgm1m24vQxe6g5zEMtJ9CoBmR2wh3H1YC+xcqyqMuBmuAT4FUnbefoToGiBMMzQmdI4uQHzL3dcRRFFEL/JuvDpmkfGmGaIofZeU2MQxM7d6Cl3nDjzLnsp2J1CDMl6xtxSV4G6fKJ9SwLYjTRSM3n4H4yDmvSCapuh6sDrq11ChPgsqtCh1n840uZUOJPObvL0IEQRbyQtfxjuoye/d4jkTwpWs80dEbQ2KVi5df8d/s1qQ5VCDvD4ctJsDQc8t87SRvTj0vN2US0mk8zuuItmmPu0ZW2iOr6ZNYL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:03:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:03:34 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 1 Dec 2025 21:03:32 -0800
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <692e7324a4ddc_261c1100d8@dwillia2-mobl4.notmuch>
In-Reply-To: <20251119192236.2527305-3-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-3-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v21 02/23] cxl/mem: Arrange for always-synchronous memdev
 attach
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: a19f8e1d-a2ca-4521-32ce-08de316024da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hkQ09uMHhjcUg0ZlRHbVRjRUwwWTA3RWRDK29GK0dEcEoxOHp2Z1oxMC81?=
 =?utf-8?B?NjlTYXZwV28rOXZJTW4zU1ZRWDNETG1ib05oRkJxZ3FLQXZobFFtQ1g3UitV?=
 =?utf-8?B?TnpQUUdGamlMMmJscGszSy8zelE1QzdPdTUrNW5nM1l3ZVpPU3lZQWtqWWF4?=
 =?utf-8?B?SDlML0pQWWhWN2I1TFI3d0dSVVJYczhLRVNOL3BWUHpHU3Zlb2hiNG44VXUw?=
 =?utf-8?B?ZDhPc2U3SjIrWUNLc2ErcForQmIrRi9RQjRMZStXUHQvSExYeXhaWmljUm9U?=
 =?utf-8?B?b1U1NCtNc2pRZno3a1prYWpuZVYrdkQrLzRRMjY4aTFsZVFjdFJPWGV3QzBX?=
 =?utf-8?B?RjMwNnFzVGMvcGRlSmd0elFrK1EraUhBejUxMmtlN1k5L0c0Q0l3WUZZN3Fl?=
 =?utf-8?B?eWs2V005bSt2M0k2U1RxcTF6cHk0VU9odmFkZEhTVDg1R0VWd012MEI5QWox?=
 =?utf-8?B?bDNES2pCVGxGNVp2VXg4M2pUQTRtTWEvTTVDRDkvM3pxYVB4OVoyQll2RDJa?=
 =?utf-8?B?M0NlMDFJR2FvbmdtMDY3MUxLMGpHeDhOR0VWMXFvR1d0ZmdVMThMNWgyaENB?=
 =?utf-8?B?ODczN2JwbXFiSWhyYWw2YnhIK2V6STlHaTNGV0MwK3lLT0I0Sy9OdURpL25F?=
 =?utf-8?B?aWw3SDdBU3FGL3IrNjZFS3hTT052eEh1bGVUMDhzNTdZeERJeldtSEFTTlVj?=
 =?utf-8?B?RmNaZ0xDQlFRQjhuTngzR0x1ZkhBNkpBdzB6V3VLWEE2b2UweDlLaElmSHhK?=
 =?utf-8?B?RElCNDdnNzE1Wjl5UU9telpJRFIwb0VJMWFBZnY4aW8vMWtaWlVpTjl2ZXRj?=
 =?utf-8?B?bEJua0xmSTdxdTNhQXY3eUQyc1hseGhqMWlTa21jMlM4WWpmenpZVUI1N29Y?=
 =?utf-8?B?MERjbWY3ZCswNFYvUi8ydi9Eb045NGNGeFVKWGFDNjNkSExYWU02MWFaWUV5?=
 =?utf-8?B?WHBhL21zUzZaRnpHOGNUNVdKQVBVZGVHNEx5TzlGR2wzOXdYYm1lZzBBUVFs?=
 =?utf-8?B?VU4vMzlLTmRndGg0L3VHTTFoVTRkWkYyVGpCZVlodmMwZXpHbWxSYTNlZDJD?=
 =?utf-8?B?bTd4K3MxOG5EZlpFTnNCbnJsNDc3YXdKTlFDOFpzU3ZyMmVmc1FPR2k3Rys5?=
 =?utf-8?B?TDNINlFmcGJ5QXYwenBqaThZa0lPVFpFQm1OdkNyOXFYTmZhMTdKRDBNb3hT?=
 =?utf-8?B?N3ZwNUp5dC8xNnV0NGVGZ1ZlbisreEU2dTNqTUpaVzFKOUhQMzhYUUNpRjVC?=
 =?utf-8?B?ekZmWWdoUzBoZkRhc1ZXWGdzMHRabGdjSmdYc0hlUzhKZ0FoVSs1Y1gvVkdk?=
 =?utf-8?B?TWlqdmMwMC9IY3g4eTZsTmt2ZTVhYzJqeXgzdWxQdWNpeUprUUNKZFhXVDFD?=
 =?utf-8?B?SzVyQ1BxOGpsSzJVWWNBd0tzTS9VSVl5OG8xU0lhajdYNy84MUZtcFNnajUy?=
 =?utf-8?B?TXZuNkVLdGp1aEVlNlRTTmJ6cEp0TnpKMUducysrQWU1WUhnYTlHV0JaRER1?=
 =?utf-8?B?d3V3Z0NsWXA2NjV4ejRUOVhCdXdjZlhOTmdwTXNnMkF2WmpnVGhDcjVwU0VY?=
 =?utf-8?B?Z1pqNGFPZDlWYUt3M3o1VmQ2YkZzeFZsaVE4SzJqSlUwdkxFSXVwTkpqck40?=
 =?utf-8?B?YVp2WDJJa0lKRW5uSzJnb1hRVWVwVlNuaEkrUU5WNXlRZ1grUFczM0RDR1pS?=
 =?utf-8?B?QmpzRk1raWNFQXB0cEVwSjRDOVYxUlF3ZVRLVHhtODVDRUtnRWlTbERiaDhY?=
 =?utf-8?B?YVpFbm9FbFpWeitFNWFHdTIvdmhqb1A0eU10SlNzVm5HbFBNdlY4RWlQNW1V?=
 =?utf-8?B?TUd1VjBQcWNENWg5RmRNNld2ZnJydURrRm8vcFFkRmxHLzZheHBEd01yczRa?=
 =?utf-8?B?L0VJMEozakhBR2pmdXR6Z000MStESnM4T2h0a0MzSDBDNWozTDJlRVlFMWQ1?=
 =?utf-8?B?NXJ0a29qd0V5aE80bHM5TStTblNjKzE2WlM2U01FTkNQL3crYUxPMGsyWVFJ?=
 =?utf-8?Q?wX4os8jysRtRUqlKF7vfWgNLsqF8Uc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFIeU1sRHhWVU5hMEM1bzBtZUxmbHd2MVRwcGlGSE1BYkhuNDh3aTZBR3Ir?=
 =?utf-8?B?MEI2enAvbVhYejNsajFVYVZCOGgzWEFHZXJOV2dwTFBmNFM0N3FYUUdoa2FH?=
 =?utf-8?B?U2JiN2xmKzh4VWlkVUF3WVZPYnJzcHFKeGlFZU45NnByRmkwN2lFaFoxazJ0?=
 =?utf-8?B?OUxPR3VFOVoyMzdKR3hIUzdTb1NMa1ZuMWxoc0dYZjFWVHo5Wk1qeUFycTF5?=
 =?utf-8?B?QWFISlVXS0M0dmxMVnpXTWVEZlFudk5YL3krNnVLYUZrblVieXVNYlRRUklT?=
 =?utf-8?B?NE5URVlsaGsrZ2VDL29zVlZoQTJGTWJUL3hKdVMrbS9mWGgwS3VSb0ZXN1ZY?=
 =?utf-8?B?Ui9USXNBWDJUYnFya0ovc0xtSWhXYjN6a0lYV0tzMEY1MUhTZUxkdS9Hd0Vy?=
 =?utf-8?B?RnJyYTJkZ0J3WGllN1VpbGwvUTIrLzdQL2c0bGdzeWtwOFl5UCt3OVptR3dl?=
 =?utf-8?B?UHZMY1E2TWI5RUNvOGdWZW5jQk1hZ0ttOWlGTmR5N0pOZlBFY3lyR29nZVhT?=
 =?utf-8?B?Rkg5bmt0TkwyVUV4THpiWEJiQ3V0Sm1NQllNRjgya05VM3Y1L01PYnFBaWpy?=
 =?utf-8?B?SDc0eVcwcTZYL3VFNWJONW5BMFVZZ0pYSlAyZHNROEFJdGg4Um53bWppQkhP?=
 =?utf-8?B?RjM2eWVGc0dpRGQ0QmdmL1JXYVVlUERsajkzU0tob0pPcEdQTDNKRWxDSmZ3?=
 =?utf-8?B?ayt0NWgvMGJ5WGo5ZFNMbkZEUm9sZDhLTGFtRmExNE5YV2NsSUZqbUJvcjhn?=
 =?utf-8?B?Ym1ad0RGOTVPTk54amJZanQyRkNKS1ljUXFlSHFJRk1ENy93MzdTUUtoNS9Z?=
 =?utf-8?B?UHhydmo1WWNodm5QNlN0bjR0L1I0UVZueWZKQXo3WXBOeWlEMUxOcUN1T2hx?=
 =?utf-8?B?aXdROFBLelE4SzErMWpEK0F1NWpib0lpclZTazlnWElVTUhQZmU3MHA2aFhR?=
 =?utf-8?B?SDRtZXQ0VTNqK21yOFVURHptKzQ5RmgxM3F3L2M1N0Z5TDNDUzdsM2lpUURk?=
 =?utf-8?B?MnZudUV3eWJmd3lkaEsrbzEyeVRVUkQ1THZYYWU5WkJrWEkxOTJDSzlPWUtK?=
 =?utf-8?B?WE8ybFN6WGx5VWQrOENtOWUxQzF3QzRVb1pzMk5Dci9zdU5BK0dVUmJFMHFD?=
 =?utf-8?B?Q0dsN01SU0pNNllScXJ4NDZia0hnQ09Rd1BFN0ZqRml3dUd0bGRZWG5WcmZE?=
 =?utf-8?B?eWdLRUxxZnpEcWNYQ3hyS2E0bTdva0xVMGRPNGY4RUROVlBRYmFJUGVQakFY?=
 =?utf-8?B?dDd2M0RGdXNGcm92R2wwQzAwZzRBbytaSjh2WkY2T09rV293ZmV5UmxmdkVr?=
 =?utf-8?B?WE0zY082QnpGWXZCVE5yWmtqMUtRR2VSRlF2N3MzTVMrZk4vY0tqY3NPK0pX?=
 =?utf-8?B?Y3pXL1FhTU84Z3VzdDAzeVVRQWJ0ZktYcEtrYTcyNWpLTUltQUZBZDFrRVFh?=
 =?utf-8?B?ZWREUGppc1p5MUdPYVNoMTM3dmsyekZFSDBObWovKzA0TFdyWnFjMXMxd1BC?=
 =?utf-8?B?bWlYWnhVVTNyZ1RhVnk3YUZwZmcvWjVmU1N1N0FSMXhjS2lWb0xET0xqUGp0?=
 =?utf-8?B?bVZRN1FMa0xVMDF4dFhhTmpWcmo5U3hFMGwvOFVQNVpEOTRDQWlBMkExSzlv?=
 =?utf-8?B?YlZGeVZtMG9YQVVvcXN5OTFOT2dZa0d2clU0d25EanlaY3pIeWdtbGswUkly?=
 =?utf-8?B?RzlpbXo1bW1FVlVNeWMzREFVc09KUkluYmJFWWtoZURsdDhrUlI1djdpd2FC?=
 =?utf-8?B?Y2MrZlBya1pxY3RqM0Q5TU1zU2ZxRnpubEd1aWZxbk11Ym9lUXhPY3JDY2FK?=
 =?utf-8?B?emF6bTZXOEdsSEEzQWxTNkNYYU9XTWZMeitmRjd5ZTRuYkxkTGVsbFpGUXFi?=
 =?utf-8?B?TUFqbnlqb1hWZGZsSHBMWGQxQUNUWHh2cFNXYTNWVHQyNVRscnBPWHc0ZG1n?=
 =?utf-8?B?L21aMG5sN080RzBUZS9ScnBERFowREYvSTA5MDZML2VZVTJ3VTI3MWUycG0x?=
 =?utf-8?B?RmY3MW4rY21PZ0d2azdKRUEyeXlleVZ1T3VaY2lHSXYxTWJvS3ZrN1lKT3FP?=
 =?utf-8?B?UlVpRDRnMGtqRUxPYlkxRUJtalpnZFZ4N0xOQ2tyNVUxUEx6a2krRXBHU1B5?=
 =?utf-8?B?dEhJYVdZRlZLSkhqVk1oNmdJS3RYd2xDR2tmTlN3UUhQd255VjVHTkdWR2o4?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a19f8e1d-a2ca-4521-32ce-08de316024da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:03:34.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxJ9fyC/7yDJ/42kIUzZHmV8Et/jihupXWWHQop6NijNrRohcpfaRscA7efECoK80TaVfR9rXOiV90P6KlRuyc+X6bk1i4634/2Un5ysPPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for CXL accelerator drivers that have a hard dependency on
> CXL capability initialization, arrange for the endpoint probe result to be
> conveyed to the caller of devm_cxl_add_memdev().
> 
> As it stands cxl_pci does not care about the attach state of the cxl_memdev
> because all generic memory expansion functionality can be handled by the
> cxl_core. For accelerators, that driver needs to know perform driver
> specific initialization if CXL is available, or exectute a fallback to PCIe
> only operation.
> 
> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
> loading as one reason that a memdev may not be attached upon return from
> devm_cxl_add_memdev().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

No, there, is no such thing as non-author sign-offs without
Co-developed-by. If you take authorship and take most of the changelog
text verbatim then either be clear about what additional changes you
made to take authorship, or leave the original authorship in tact.

For this patch we can just drop it because the simpler proposal I
replied to patch1 seems a better way to go.

