Return-Path: <netdev+bounces-173533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F6A594A3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E816516837F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A42206AB;
	Mon, 10 Mar 2025 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2vhd+pr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7AEEAA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610203; cv=fail; b=Jzn5q4mGWIF/zJPPHMpaY2O3XzUUoYZhDxscV2PZ5nfg+l8ibCNZHVsjH8k2eLEL9hE7W6btzTG5mWu0gZabYH0IWTKrWYp0GL++E9NoShZpRFR41S07F1BcGDzX1eH8wiRVRRSOyJJomxQxQQNWORJ8u+kB1VduioS3vGSFU2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610203; c=relaxed/simple;
	bh=kc4P8b9Or8ir9YWCWXV3k3JXpaIkdbkySnIulLTu7vs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KMJCMy/sWY3zJqrtxSc7S0XBJOUyqjFubJfOCo+gGkyEZXWSbU2+ur42by2AHNF6JxRieKepvW40l83fTk8UzihHQjnyZuObXCVQudiEQb19k2J+4rZ8w6lWVSrG4AUncK2FCbzLjyAYfU3acvlxBvPkJLhUmDYFOw1FqPOFmKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2vhd+pr; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741610201; x=1773146201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kc4P8b9Or8ir9YWCWXV3k3JXpaIkdbkySnIulLTu7vs=;
  b=c2vhd+prAWpvZInz/aHNSFqEgPDNEYhvHTt8sw0+NCp9QjR5lC54Jb6P
   0KeWojLTRMTY1BBVPKZTlQErEI9fBzSGZF32oz+zL12yXls9vzvMgo4OM
   F4jrDVb/cuCvAxT0g9wUchHVlrzc6cRDfy+T5pyQ7a1pOhH/2yR/Cppiw
   wOE8KCXgQtmKS0o+ghIB3v7CE3FSpLYNjc4ts+1gh96CY5FcP26l9bJu0
   5OpdFSCOw+wOlN4FZLxrQARgOMKrv1xRS+3f1H+7sQG++H8K04RPns6Ye
   P9xR9iJUQ8gIznacNPHArS/J3DMTrYXCF/7M8RZdpP9m3q/3ijOjLZue2
   Q==;
X-CSE-ConnectionGUID: crfPyokiQjSae0yfGGMzVQ==
X-CSE-MsgGUID: PUEPnKUITs6ujjpSyE8T4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46388780"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46388780"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:36:40 -0700
X-CSE-ConnectionGUID: M4I3YmIXQHewhXyv6Jcu3w==
X-CSE-MsgGUID: snWTtROqRZWnLX6vNFDthw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125036336"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:36:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 10 Mar 2025 05:36:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 05:36:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 05:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZAEpyqFdDlTRG1Z/4yhtedSft0p+0nf+F69bgTKitt9LcHUMIT0WUb8ozzpcJmg1HDxF3to68V+m1ed89YtjXfGpAD7hR6HWJyKvEw/P7Ir3GkZASpPvM7jRTik+LVE/xu5F4EWjUs5qzeSeerJH/MAbzFSSDbR9SUVLn10sjbJHbrt3g6w+clohR3tHYP9lMDtrRRPGCbHjghdhoUVcWTWxBBqqpU3FCS5nRo7w49dPk03xzc+BCci5zWo1IxbXqpldZdAZaHyBKJ8NJzKGsoxvgMAcT3gKKp9BVaOZ1mUqpu7uhSzOUAaq5xZ41M+frQ2afVAiiX+y85wIPWIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc4P8b9Or8ir9YWCWXV3k3JXpaIkdbkySnIulLTu7vs=;
 b=ygKoJmLHeA6dl1sTpTWUBGctjM9K/9ZypyCPPyvM1t1yik5rJmS3L0vdxSjuznz5BNMkQfgoBiSe49p2aG7foOzWSRYirvY0a0ntjjNg5/ynTyD1vSfL2Ax7Bs1aU8yWi8OfGCwaGGHLUmn5KWahvBWrK4Vs/h5mopGEuqI3D7oshXzDzxMj/K+dhldnbouWoobfoYVdao5GHAYBgo81k751Pj98geRKIyRA+6C//Wx0btMJVoCltqEjE10aY8g5/HM29icoWaimB0JLdw3pkgsIXIt11B3uQ15O+t9p43kxwELmf1whOgIPCnAIdWuQjvIuwu1yP9haRLldIZmp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 12:36:31 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::f302:c534:2d71:822b]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::f302:c534:2d71:822b%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 12:36:31 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, "Kolacinski, Karol" <karol.kolacinski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: remove SW side
 band access workaround for E825
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: remove SW side
 band access workaround for E825
Thread-Index: AQHbhF0N81pA2MzIGU26U8+PCU3Ip7NSQuyAgBC733CACWmcwA==
Date: Mon, 10 Mar 2025 12:36:31 +0000
Message-ID: <IA1PR11MB62190A2A70EF90C94589A6F092D62@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
 <20250221123123.2833395-2-grzegorz.nitka@intel.com>
 <aecd919b-fbb8-4790-af1f-69b50cc78438@molgen.mpg.de>
 <IA1PR11MB6219197D989E2DD57307AE8D92C82@IA1PR11MB6219.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6219197D989E2DD57307AE8D92C82@IA1PR11MB6219.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 7c92386d-6aad-4b46-342a-08dd5fd02f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YlFqbmlFbThGZGw3d0VGQjJvRDcxVkNwQUdkc2tzdCtKNkFTS3lDNnZYcVhQ?=
 =?utf-8?B?bVlqamZiMGpJczU1T1VkRFdDMUhNM25WL1RKQnArVHd6eWFTWHhyMy9PeXdw?=
 =?utf-8?B?dlA4ZlEvMzVRbWpicGhabThaY1BDaTRzeFJDR2hsWG1Rc0FvcnBGKzdyREp5?=
 =?utf-8?B?ZS9ScVA1ZXRWVlN2M1QrL0p1NnNUSGxwejdzZVVvMWo0N3lvSEYvWXdzTGxJ?=
 =?utf-8?B?RkNYUnVhZjRIRkd5WjlidDdVNUVBSzBVR3J3U2RmWkkrWWxSVWNUK1U0OExZ?=
 =?utf-8?B?ZDhsTXNzL005Y2t1bHhKU2tGa05DZWZSeDYxTGxCbFZobVlhSGhmS013MnU0?=
 =?utf-8?B?eklWWC9OOVJ4MDVoZUN1bmx4RWZpNTFEb3RKNFQ5c3J4dzByUjRnQXhSclZC?=
 =?utf-8?B?TE9MalJSaFJNUWpsZVl4azA0MVlNTDNuWVZ2QzVUMnVETnRXaVNqK3hDMGMw?=
 =?utf-8?B?WGZqMGlJOTZPV0pycitxNFAwRWdOblZWZ3QxYm9HaHVtK1hDWUpUUzRDck0x?=
 =?utf-8?B?WEZJU0JoSlJuU1g5VEo2NU9FancyY1JVRTBITlo4eVZOQ0dXcXpBRml3eG5r?=
 =?utf-8?B?YkUzYjhCV0lBdVhoTmxub0U4c1VmdTQzVFBhTjNvaW5ZcVJuS0lzbTZ1UUh6?=
 =?utf-8?B?cjk5alBTTyt1azh1WnRlVGoxcEhGZjRUbUtkWm1LZCtJcVZPSmEwT25NUTRF?=
 =?utf-8?B?T0dkbThnKzZPK1ptUVpnSmFjM2hYZVQ0eGNSVFRYdytQZzBpbEYwYkUyUkZp?=
 =?utf-8?B?cDZaVTRsMzE5ZHNBQ0dDdzdwWExpOXpFNmc0L2E3Um92N3hNdHg0TmZZTGpT?=
 =?utf-8?B?Q2R6U3o3NHppMTRaSmU3c0VuaXgydlJaSnFrY1FyVWhPSGdhUHBnczRaS1Jk?=
 =?utf-8?B?MjlLQThYSlc4NDBTODNNMDVqcG8rUnNBbi9ZdTRzNTgrMGllSWEvZjBreWFF?=
 =?utf-8?B?ZnBLZHZoOGxCTFdBOWZXeFJzNVJlTi9JN0hXKzErem5mWkQ5WHVFK1dVMWFw?=
 =?utf-8?B?akdQYkN0dlc5T1FCa1hWa2tlTDUwb29qcHVrZnZaK1F2aDJRWkRNMGVJYXB1?=
 =?utf-8?B?ajg1VFFhbVVQV0JrbUN4a2pvV0tpOXRGazVDTUdlUVNJQzF2Qi9UOVJBNXZk?=
 =?utf-8?B?dDBkeklhS0pVU0JGWVpqUkJrZHFYTmVLM3ZsYVhHRTUwUUp6U1R0T1JqdXBW?=
 =?utf-8?B?NUZnN3hiNTZYWVBaL2Z0UjcraHVyTjlMSWlJYnkyeWQ0Y3RDUlZFKzBBcEJN?=
 =?utf-8?B?QVVYUWt5dDVOa2I4MUNvZlVXRDBTemI4ays1RmNpOUhQckxRUjRzRTBGMThP?=
 =?utf-8?B?QVZsUzdxcUFzVlNTRWpoZUxxTDJ0QkdGSnQxcmwzMkdpcThTZEw1dmlycUlo?=
 =?utf-8?B?NTJwa2h6QmtQYWRHZ1d1RTRkWFZ2Q3kxQkFwcDgvNk5DMTBnVWoyQm5SZVFG?=
 =?utf-8?B?dHJpN0o3Z3JndTIvV2dFTkIwRE8wNTlFTWs5aW00Ykk2bUYrRlpBYzVVU2hk?=
 =?utf-8?B?TExES0twZS9Wd3BwRnVseS8vcGJhWjhGTVF3ZnB0eEFZV3FIR1Q4S0RXMFM1?=
 =?utf-8?B?OUMwV1htejc3SFUzdWpxS25KaDU2Z0hlK2pGUjdxRTBlK21BRTlrSk0vZVNx?=
 =?utf-8?B?ekJVSzFJZTFYNWZQTC9YRUNjWHJiYlVJK0Z5bzV4UHdTYlM0TE1pN1NmQVgw?=
 =?utf-8?B?ZDFvUlVxbEJxMWlBbDREVVFqSEYrZ1VIS3MvcHdKUSs0MG5KRTIzUDdRL2xw?=
 =?utf-8?B?TDRZa2gxQ1ZuS0F0TmpEY0lSZmgyV2l0WXhVLzlPLzhyelc1b0lsaFFIWThr?=
 =?utf-8?B?dGpRRHVsakR0YUxzbWNsZVRNNnFqZU1aSFF5MG9tRTEzSWErNjB0RWp1WHU5?=
 =?utf-8?B?NW9vUm9nT3VQMlU1bHlSQUl6aXNjUVgwY294T21tbUtZa2JzNG50T0U0ZWZq?=
 =?utf-8?Q?XqYt5k/PipnDvMiq4qggwOz+u19byvks?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9Hc1kyMDlYcXFhU0ZBMnFKMjd6WThiWWdNQmdZK1JhNGNYNnAxQ0ZxRDV6?=
 =?utf-8?B?eFNobTRuU3hXWkpqbXZQa1FxOFU5YnZVQjVMZ05FektQbm1pb0hIYTZHYVg3?=
 =?utf-8?B?bVA4K2l6Z01UM0pHcjFEUEJJRXhES25WNTZSSFBmNVFMbHYyUXQwTmFObmw4?=
 =?utf-8?B?Yk00dVRzd25wN0ZuRUtGZGZLSUhaeHMwY1NGNGIraDJoQ3NqZHl4bDB0T2Fm?=
 =?utf-8?B?REJVckwwMk9lNVZyc1krSEtYZm1GbjRYbUltL3FkaU5IUnFHSDV5RFE2RUpW?=
 =?utf-8?B?UnZDdkJPS29MOHBRdVN5MjJQZ0tDUTFIbFRHNXNWL0hBVnFyYUhjMzlPTkI5?=
 =?utf-8?B?NTBTQS80OUg0Y0hKb3VXUzZaVmpid1NYRHRwdGVYazlKenFZZGVZOGRzYlk5?=
 =?utf-8?B?UG41dWFqLzJJK3l6WURBYXJUb2tUaU5yNXU5b3ArcHFvVVRDeTltYmpMaC9N?=
 =?utf-8?B?KzRhUTFTVlNraXpzLzgwUnlnNlBkc0JhcDZKTUkzSHladWg1Z3o2NFczcndC?=
 =?utf-8?B?cHhncC8yaytQN0I0RWJkMDZsZ0ZVOVp4SlQ3K1c0b2ltcTR6em9WVVR4OG1l?=
 =?utf-8?B?eGxtejcrRGRGaXphVjB0K1RoS2lGVUZMelFVZ3pKWkxUMnZEMEdKdVhxT2tN?=
 =?utf-8?B?YS9XVVNwOGJ2RjJzN2lNZ2UrcUZwSCtzSGxsdWdIeDJlTzJjOG1DbVpsV1lW?=
 =?utf-8?B?aSttVURzRlgzajdadS9Ga0IveENwdkJrZE0yNWNJbnF3MUJPUEpLd3ZyYXNm?=
 =?utf-8?B?OTFwZlNIem5tVlY4S2NRVkh6U1NFM0dPL1R2ekJWTFpMd0V0WTk1SW9yaFpq?=
 =?utf-8?B?ZTZQQnJ1WEdPaUgyRE1VM3UvamI1SHNTbjE1WURHRndoQUh2NkNyeHJKazU2?=
 =?utf-8?B?MGFFYUthYU5lTFR4WUNnYjZHZTkySjQyUWZ6SjBTbVZrSUZrODMycUNCUDNh?=
 =?utf-8?B?RGxWSXp5NWFMT1lPRUEyL0h2R1FYYVpxZzNYWmJyNTNqUHVvRE05ZlJuYm81?=
 =?utf-8?B?THFNVnVhUVRZUm1pMU5oQXRoU0tpK3BLUUprU3haZU4wR1dBdU1YR01WODFl?=
 =?utf-8?B?dzR3VlBoVHV6dlpJUlc1YldDRmp1UGloWm1CM01CRmJ3UEVieGdmc2xQVXYw?=
 =?utf-8?B?M3JMYkJYUy8wdFFxV2FIMFFzNXlhcW5hbFZsdEV5eGREaUliS05lVEVUcHpu?=
 =?utf-8?B?WWZocDhRM2VDQ2I2NFIvcGxBeHEwdHo5U0kvSHlsZnFSaUQyWVdzM2VwMlVI?=
 =?utf-8?B?ekxUQmpVTm9uSzFXOXh5SStINCswM1EzbkNVSXNWeU54VkxJRWZKMHlhb0FK?=
 =?utf-8?B?RkdFSExqNkx3RXZXYkpqVS9DOEl3MzNCK2RmYVhLa0F4RWRpNld0dnd1alds?=
 =?utf-8?B?KzBiRkVwRVRpeGsyc3l4enIwaTlXUFpiMlJQSWZKejVzODlkOWs0UFBpTkVX?=
 =?utf-8?B?cmZkaXNlM1RqYStpalR3UWQrUk1Va1hVc0FsMlZsZ2g2MUpuclNLaDZFVmJ1?=
 =?utf-8?B?Z0hCTW0rVVV5QkFTWStScVpBQ0tvUmRGZEI1QStsakY0SnkzU3VpNmdRaFdv?=
 =?utf-8?B?RGJ6OVBWQi92ZGhuQXcrWEkvU3VENWY0Zkhna2dGbks0dE02QmJZK3ZqcERj?=
 =?utf-8?B?MWVLamRnWkFSZ3lwVy9DSnEyV0J2ZzM5c1U1SmJLZC9kMjNIbVk4eitzWnhC?=
 =?utf-8?B?ejhUZm44K1V3bHV0MlBBNnpmSVEvSHh1Zzk0VUFLZEZlUjA4azVjS1RjR3Zr?=
 =?utf-8?B?SVA4VjdQS3VDQTk4RDNDMHlJck5JeUI2TDBGdFFWdFN3TEhFM3pndmhtdVBX?=
 =?utf-8?B?RXc4OGkvdE5YbEVlc3RTb0k2MWpBdzRsano4Qm83eHJXTmM1bVYvalJOR0xm?=
 =?utf-8?B?ZVJoZE1xdHpnbFUrTW54ZXRHUWVSbTNjV2Y3ZzE0eUs3ZE1DcHphb042L3BJ?=
 =?utf-8?B?QktJOUdxeXgvUlFSdUU2cFY4Q0Zsck85Nmt4L0ZBMGd0RlpxVWJGcmdZZWxo?=
 =?utf-8?B?MTFuenZqU0tmRVA0bXVtOWovRVVKQ01QTDJZMlEvRzNxMWpsWTdiODJMd3Ax?=
 =?utf-8?B?VS9ua1Z0UnlGSmdMN29qN1lSeDdNVU9jY1FIUWp0QTNsN2RIdTg2REo5Qmpq?=
 =?utf-8?Q?X5FEaKCq1YFvywHyq4r6NzMvz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c92386d-6aad-4b46-342a-08dd5fd02f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 12:36:31.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/FGXVdhtoa31MkRSzCC2rKdFpvGb+k9KiWNbc029ptjDgSXCRf1apmLzHdy3tKU5q/10sIpluNfybcZWMNBdwlWtz3FYNGwrz9F5myk2f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBOaXRrYSwg
R3J6ZWdvcnoNCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNCwgMjAyNSAyOjA0IFBNDQo+IFRvOiBQ
YXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPjsgS29sYWNpbnNraSwgS2Fyb2wNCj4g
PGthcm9sLmtvbGFjaW5za2lAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3Rz
Lm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtpdHN6ZWwsDQo+IFByemVteXNs
YXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBNaWNoYWwgU3dpYXRrb3dza2kNCj4g
PG1pY2hhbC5zd2lhdGtvd3NraUBsaW51eC5pbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbSW50
ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjEgMS8zXSBpY2U6IHJlbW92ZSBTVyBzaWRl
DQo+IGJhbmQgYWNjZXNzIHdvcmthcm91bmQgZm9yIEU4MjUNCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBn
LmRlPg0KPiA+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjEsIDIwMjUgMTA6MTYgUE0NCj4gPiBU
bzogTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBLb2xhY2luc2tp
LCBLYXJvbA0KPiA+IDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT4NCj4gPiBDYzogaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtpdHN6
ZWwsDQo+ID4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IE1pY2hh
bCBTd2lhdGtvd3NraQ0KPiA+IDxtaWNoYWwuc3dpYXRrb3dza2lAbGludXguaW50ZWwuY29tPg0K
PiA+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjEgMS8z
XSBpY2U6IHJlbW92ZSBTVyBzaWRlDQo+ID4gYmFuZCBhY2Nlc3Mgd29ya2Fyb3VuZCBmb3IgRTgy
NQ0KPiA+DQo+ID4gRGVhciBHcnplZ29yeiwgZGVhciBLYXJvbCwNCj4gPg0KPiA+DQo+ID4gVGhh
bmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPiA+DQo+ID4gQW0gMjEuMDIuMjUgdW0gMTM6MzEgc2No
cmllYiBHcnplZ29yeiBOaXRrYToNCj4gPiA+IEZyb206IEthcm9sIEtvbGFjaW5za2kgPGthcm9s
LmtvbGFjaW5za2lAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IER1ZSB0byB0aGUgYnVnIGluIEZX
L05WTSBhdXRvbG9hZCBtZWNoYW5pc20gKHdyb25nIGRlZmF1bHQNCj4gPiA+IFNCX1JFTV9ERVZf
Q1RMIHJlZ2lzdGVyIHNldHRpbmdzKSwgdGhlIGFjY2VzcyB0byBwZWVyIFBIWSBhbmQgQ0dVDQo+
ID4gPiBjbGllbnRzIHdhcyBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiA+DQo+ID4gSeKAmWQgYWRk
IGEgYmxhbmsgbGluZSBiZXR3ZWVuIHRoZSBwYXJhZ3JhcGhzLg0KPiA+DQo+ID4gPiBBcyB0aGUg
d29ya2Fyb3VuZCBzb2x1dGlvbiwgdGhlIHJlZ2lzdGVyIHZhbHVlIHdhcyBvdmVyd3JpdHRlbiBi
eSB0aGUNCj4gPiA+IGRyaXZlciBhdCB0aGUgcHJvYmUgb3IgcmVzZXQgaGFuZGxpbmcuDQo+ID4g
PiBSZW1vdmUgd29ya2Fyb3VuZCBhcyBpdCdzIG5vdCBuZWVkZWQgYW55bW9yZS4gVGhlIGZpeCBp
biBhdXRvbG9hZA0KPiA+ID4gcHJvY2VkdXJlIGhhcyBiZWVuIHByb3ZpZGVkIHdpdGggTlZNIDMu
ODAgdmVyc2lvbi4NCj4gPg0KPiA+IElzIHRoaXMgY29tcGF0aWJsZSB3aXRoIExpbnV44oCZIG5v
IHJlZ3Jlc3Npb24gcG9saWN5PyBQZW9wbGUgbWlnaHQgb25seQ0KPiA+IHVwZGF0ZSB0aGUgTGlu
dXgga2VybmVsIGFuZCBub3QgdGhlIGZpcm13YXJlLg0KPiA+DQo+ID4gSG93IGRpZCB5b3UgdGVz
dCB0aGlzLCBhbmQgaG93IGNhbiBvdGhlcnMgdGVzdCB0aGlzPw0KPiA+DQo+ID4gPiBSZXZpZXdl
ZC1ieTogTWljaGFsIFN3aWF0a293c2tpIDxtaWNoYWwuc3dpYXRrb3dza2lAbGludXguaW50ZWwu
Y29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IFByemVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRz
emVsQGludGVsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEthcm9sIEtvbGFjaW5za2kgPGth
cm9sLmtvbGFjaW5za2lAaW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogR3J6ZWdvcnog
Tml0a2EgPGdyemVnb3J6Lm5pdGthQGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jIHwgMjMgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+DQo+ID4gS2luZCByZWdhcmRzLA0KPiA+DQo+ID4gUGF1bA0KPiA+DQo+ID4NCj4gDQo+IERl
YXIgUGF1bCwgZmlyc3Qgb2YgYWxsIHRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcgYW5kIGFwb2xv
Z2l6ZSBmb3IgbGF0ZQ0KPiByZXNwb25zZSAoc2ltcGx5LCBJIHdhcyBvdXQgcHJldmlvdXMgd2Vl
aykuDQo+IA0KPiBSZW1vdmluZyB0aGF0IHdvcmthcm91bmQgd2FzIGEgY29uc2Npb3VzIGRlY2lz
aW9uLg0KPiBSYXRpb25hbGUgZm9yIHRoYXQgaXMsIHRoYXQgdGhlICdwcm9ibGVtYXRpYycgd29y
a2Fyb3VuZCB3YXMgcHJvdmlkZWQNCj4gaW4gdmVyeSBlYXJseSBwcm9kdWN0IGRldmVsb3BtZW50
IHN0YWdlICh+IHllYXIgYWdvKS4gIE5vdywgZXNwZWNpYWxseQ0KPiB3aGVuIEU4MjUtQyBwcm9k
dWN0IHdhcyBqdXN0IG9mZmljaWFsbHkgYW5ub3VuY2VkLCB0aGUgY3VzdG9tZXIgc2hhbGwNCj4g
dXNlIG9mZmljaWFsLCBhcHByb3ZlZCBTVyBpbmdyZWRpZW50cy4NCj4gDQo+IEhlcmUgYXJlIG1v
cmUgZGV0YWlscyBvbiB0aGlzOg0KPiAtIGludHJvZHVjdGlvbiB0byBFODI1LUMgZGV2aWNlcyB3
YXMgcHJvdmlkZWQgaW4ga2VybmVsIDYuNiwgdG8gYWxsb3cNCj4gICBzZWxlY3RlZCBjdXN0b21l
cnMgZm9yIGVhcmx5IEU4MjUtQyBlbmFibGVtZW50LiBBdCB0aGF0IHRpbWUgRTgyNS1DDQo+ICAg
cHJvZHVjdCBmYW1pbHkgd2FzIGluIGVhcmx5IHBoYXNlIChraW5kIG9mIEFscGhhKSwgYW5kIG9u
ZSBvZiB0aGUNCj4gICBjb25zZXF1ZW5jZXMsIGZyb20gdG9kYXkncyBwZXJzcGVjdGl2ZSwgIGlz
IHRoYXQgaXQgaW5jbHVkZWQgJ3Vud2FudGVkJw0KPiAgIHdvcmthcm91bmRzIGxpa2UgdGhpcy4N
Cj4gDQo+IC0gdGhpcyBjaGFuZ2UgYXBwbGllcyB0byBFODI1LUMgcHJvZHVjdHMgb25seSwgd2hp
Y2ggaXMgU29DIHByb2R1Y3QsIG5vdA0KPiAgIGEgcmVndWxhciBOSUMgY2FyZC4gIFdoYXQgSSdk
IGxpa2UgdG8gZW1waGFzaXplIGhlcmUsIGl0IHJlcXVpcmVzIGV2ZW4gbW9yZQ0KPiAgIGN1c3Rv
bWVyIHN1cHBvcnQgZnJvbSBJbnRlbCBjb21wYW55IGluIHRlcm1zIG9mIHByb3ZpZGluZyBtYXRj
aGluZw0KPiAgIFNXIHN0YWNrIChsaWtlIEJJT1MsIGZpcm13YXJlLCBkcml2ZXJzIGV0Yy4pLg0K
PiANCj4gSSBzZWUgdHdvIHBvc3NpYmlsaXRpZXMgbm93Og0KPiAxKSBpZiB0aGUgcmVncmVzc2lv
biBwb2xpY3kgeW91IG1lbnRpb25lZCBpcyBpbnZpb2xhYmxlLCBrZWVwIHRoZSB3b3JrYXJvdW5k
DQo+ICAgIGluIHRoZSBrZXJuZWwgY29kZSBsaWtlIGl0IGlzIHRvZGF5LiBNYXliZSB3ZSBjb3Vs
ZCBhZGQgTlZNIHZlcnNpb24NCj4gY2hlY2tlcg0KPiAgICBhbmQgYXBwbHkgcmVnaXN0ZXIgdXBk
YXRlcyBmb3Igb2xkZXIgTlZNcyBvbmx5Lg0KPiAgICBCdXQsIGluIG15IG9waW5pb24sIGl0IHdv
dWxkIGxlYWQgdG8ga2VlcGluZyBhIGRlYWQgY29kZS4gVGhlcmUgc2hvdWxkbid0DQo+IGJlDQo+
ICAgIG9mZmljaWFsIEZXIChJIGhvcGUgSSB3b24ndCByZWdyZXQgdGhlc2Ugd29yZHMpIG9uIHRo
ZSBtYXJrZXQgd2hpY2gNCj4gcmVxdWlyZXMNCj4gICAgdGhpcyB3b3JrYXJvdW5kLg0KPiANCj4g
MikgcmVtb3ZlIHRoZSB3b3JrYXJvdW5kIGxpa2UgaXQncyBpbXBsZW1lbnRlZCBpbiB0aGlzIHBh
dGNoIGFuZCBpbXByb3ZlDQo+ICAgIGNvbW1pdCBtZXNzYWdlIHRvIGNsYXJpZnkgYWxsIHBvdGVu
dGlhbCBkb3VidHMvcXVlc3Rpb25zIGZyb20gdGhlIHVzZXINCj4gICAgcGVyc3BlY3RpdmUuDQo+
IA0KPiBXaGF0J3MgeW91ciB0aG91Z2h0cz8NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiANCj4gR3J6
ZWdvcnoNCj4gDQoNCkkndmUganVzdCBzdWJtaXR0ZWQgdjIgb2YgdGhpcyBzZXJpZXMsIGJ1dCBu
byBjaGFuZ2VzIGluIHRoaXMgYXJlYSB5ZXQgKGV4Y2VwdCBhZGRpbmcNCmJsYW5rIGxpbmUgc3Vn
Z2VzdGlvbikNCkknbSB3YWl0aW5nIGZvciBmZWVkYmFjayBvciBjb25maXJtYXRpb24gaWYgYWJv
dmUganVzdGlmaWNhdGlvbiBpcyBzdWZmaWNpZW50Lg0KSSdsbCBzdWJtaXQgb25lIG1vcmUgaWYg
bmVlZGVkLg0KDQpSZWdhcmRzDQoNCkdyemVnb3J6DQo=

