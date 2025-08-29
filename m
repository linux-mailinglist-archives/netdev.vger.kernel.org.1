Return-Path: <netdev+bounces-218134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB7DB3B3C7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EFD1C825B5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD42586E8;
	Fri, 29 Aug 2025 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvmWjwCe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6F221FC4;
	Fri, 29 Aug 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451119; cv=fail; b=M1CBiL9eFlK/KnUEwaI02lPl/6fw0nRdryrp41h7MJ5AJy5WcQSiTVmLzK3063Jvvrm1S7Ur3YAkMzoknk2NFxrjHHYof+tUMHdYKWY+M7LRHzlGadL7UeaEv5f3vxwx6iHQjUpAYmmA+NkeKbnx3UkAI2AU/pR4lkf8in+HO+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451119; c=relaxed/simple;
	bh=AbsRi0CgVLBdebxqfLnaFiPI4+uWDLwhdsMoWMp+ZsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tDiJJHw94vsie2S6yv+yE4syeQBQC2Ku02deCOAE5p1vFnHscpHWzwjbkZbWLjpkazQS7xwWwuCM87ztNvJx7nLtj8oamBWxAa9ml26tk6hKpFaBlVKVmDhxAYeMih2oG6evWWv1PTb8+mYNSzxUIg/ZiwW5gE/3pIJ3cp0uU/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvmWjwCe; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756451118; x=1787987118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbsRi0CgVLBdebxqfLnaFiPI4+uWDLwhdsMoWMp+ZsY=;
  b=KvmWjwCe027CPxO1LRE1BZTAuWe8GeHVOCOMMOFh5woansY9pc1tYwK/
   m7I0T/El7y16Yd7uTDAstd73JAkY52T6tpKMsk0dkkyzbW5rNickCjBlu
   3qZDehWrDq+rRj0ZIVt9BYZmuldL3UR3B3F6XBpAFNJcxaC7L0jozin1z
   UKOjLVe1BvEFHvKZaVnMF/kte8oGFGSC3lqYkRmOKk2kxOKD7sc7lMcX7
   YVp9g0BFEX9MlTUAA6Zr8bMmPuL7oK7Hai3cc4oT6sYtgMsLWThESBuBF
   TCduOIBb4gkLjOBT1uT19L0PTiYMaPnv9iWvpQjG4LgfM2oEX0JnxIWLr
   w==;
X-CSE-ConnectionGUID: oGQfigDeSD21VIxdbDqOqQ==
X-CSE-MsgGUID: KhOK8FVoTA+LUWuCLhMshw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="61367444"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="61367444"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:05:16 -0700
X-CSE-ConnectionGUID: BZA4J2t3R0uXffJUjqwjDQ==
X-CSE-MsgGUID: J3jrBEE3Q2SnMhnnqM8Yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201256761"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:05:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:05:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 00:05:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEPeYu8kdWKp7znwAt9g3RmiIZGIN3d2fyjhRKkyQqsg4kXtSpRRdXiDbrfpTd990CT1AQMgjhFhA+I2M+B0818JmOjN0JMwFt1wQtkLVmpSiciGZ0MVT321vDCTbm9UIc/R8a3yVnf9uD84t2Q/5fsU2+2I4GrdZnsmW0WW6lfuMTmp9JC7hkFCHEs+jFK9YtHV1jySiB4VefFoyJsyRFr4iKQ8+x3I49Uk8oNDbtixtJrcdHDUt07kK3t2xYzzC1v6nkOqc5IO37KUqddCFu9Uk/JOd6dIBYeFLIgknfa18pOVhOmD35TV2h8UEY7liBondkmIf88F1bzzq/hnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbsRi0CgVLBdebxqfLnaFiPI4+uWDLwhdsMoWMp+ZsY=;
 b=swJJMweXy6dh2imI3S8YlWc1qpQmKEzUf4/lqzalIlBdCVWO7aZGg9+4Y4bk6FGIAHHqtNzuIecjaOJqk7tUkS1uj41dTLze1TDcT+g135ImwoSwgPYWHv58uGXFwMSM69RlZ27SIsKRDRrhC+8w4xGWtNHu69LnRnN9bZnRn1Y1sRDjwa2peRMgLkGc0p3j89l4Hn8L87SatHTh0UWWRUZeOZjvCG9ym5cz1iXyYs8gN+VeIqQfOVdHXUX0HrByd8wNBbJK+W6z+HZ+tZebPEnSJAvUVjqiVDwBgfkCwCn4fmbJjnC6kK9VM4v8fh+EVFGZVyD+hty4kzl0hqvdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 07:05:02 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%4]) with mapi id 15.20.9073.016; Fri, 29 Aug 2025
 07:05:02 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Mina Almasry <almasrymina@google.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>, "leitao@debian.org"
	<leitao@debian.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Thread-Topic: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Thread-Index: AQHcGDvl/LMwp05JjkKtLLSsBfpR/LR4ST6AgADsK+A=
Date: Fri, 29 Aug 2025 07:05:02 +0000
Message-ID: <SJ2PR11MB8452C5DFFFDDF084EE1C066B9B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
 <CAHS8izPU7beTCQ+nKAU=P=i1nF--DcYMcH0wM1OygpvAYi5MiA@mail.gmail.com>
In-Reply-To: <CAHS8izPU7beTCQ+nKAU=P=i1nF--DcYMcH0wM1OygpvAYi5MiA@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|PH7PR11MB8477:EE_
x-ms-office365-filtering-correlation-id: ad9405a9-5e6d-442e-34eb-08dde6ca5fc6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ymx2QnpxY044a1NsSFB5RnFjRlZoZG4vdEd5N2VwV1RQVy9LMlRScFhxNWlR?=
 =?utf-8?B?UndLT1VBK2dKQkhYU1c0OVNZWjlQV0dpOFZWTFJXVTVJZ2tiWHIvVVVpc0tp?=
 =?utf-8?B?aFVDRUVReTAvNUJCbUg0VTlDbmZZTWFhbUlYUjJYY25sSUxUM1ZhU3ZFWXh1?=
 =?utf-8?B?QkFCVEF5OFVvNUdyNzJYZlFVcHVwMDN4cDdRQkM4Wm5VQXdBTmEwMUJuU29K?=
 =?utf-8?B?ZE1VNHlVYkYyRzZsdDMySkwvbi9aU3JVQ3RZWlYyZHppVzZBQzNRR1lyN0Jk?=
 =?utf-8?B?WktuZ3FDdmVQUFZoWkVUNklTVzA3ZFZ5WGZEOE1uaDlFRGdBUU5BU1hkT0Jn?=
 =?utf-8?B?Y2xwRzZIbGUyVmJYTXRiMXdUNDhsSzk4bWJ6Z0h1OVMyeFh2OVJrVnVlSTRO?=
 =?utf-8?B?dGpseXZ0Q2UzSjQwaGwxdDg1Njhzdlo5cGFtbUYyem1yeXR4UlpZL1Z2amNM?=
 =?utf-8?B?b2liTDRJMlJrY0NxWFF6OGpVb1ZBeENHNm42M2RTenFXRWRENUlGbUtXOEpu?=
 =?utf-8?B?VWhIR1RZNTFNZ2x1U3lPSXpFdlE0cStuWSt3NllxRk14QXFMalMvTjFLejh1?=
 =?utf-8?B?Yzc4UzM0NFN3dmhxamovaHBLd2l5M2xVeFVFVWZzN3hicXhBUndxWjhVQmgv?=
 =?utf-8?B?U2RGWU1PcFQrZDkyT05YeENHNjJCQlZYMVQ0Q0d3eEw2ZWJoS0l2cXpoS0R4?=
 =?utf-8?B?bEozbi9vSlNoWDRwOWJMTXMrLzVKcTBKZTlaZXExaWVpdDYrdzFFTGtzS001?=
 =?utf-8?B?ZTJPakhLaVpySkk1bTFUQUdMRjJEbFkvcnRxbjZwK3ZXVktoRXVrYnZyN3M5?=
 =?utf-8?B?eG84Z2dKK3UzZzJYdlB3a1kyREZlUGdmbGJRbkp3L0ZYbE9rendWM1JDUlE4?=
 =?utf-8?B?ZzhvenQyZW1IVG9oVVRvTmdtcGZYWC9YL0FsV2dQQ0hiZDZJWmZiZVFLdHgy?=
 =?utf-8?B?bmoxS2FMc0RwZGxBVEpTQ2g4K0NJcGhEYVRsTnJsS0tNWmpUOU1uRVRXMU45?=
 =?utf-8?B?aEtZNk1vMWV5ZVhleXZ3YXFzdmZja01rQU8zajJVbkc4NUR0RWZWTnZyN0sz?=
 =?utf-8?B?NVcyelVGYUh5U1lGZnRLUVR4Zmk0cjRCZzZnMzlCQUtXNDBadnEwWnpNWTNh?=
 =?utf-8?B?cWlaVEI3WlIyRGdBNE5obmJYdmg0TFFyTjdNMjVvRStUZzA0dU1aUXRhZ1E1?=
 =?utf-8?B?YTJ1dG5aNXpaL2VDd1ZoMkw1SzNTOC9yOVNxV3haKzJFaWFsblhlTW9NaTVS?=
 =?utf-8?B?bmNSb0YzQmE2eUdrVXBydlEvWEg2ZTJNYmdBSFZ1RDllUVdWbC85c0VuVmJV?=
 =?utf-8?B?L1k1VkNyU2QxWUNuaFhTT1oyd2haZ3hYSFIzU0lYUmRLSVVKU2g5QThtUjdo?=
 =?utf-8?B?bm10d1BjSmtWQTlPbTNFL2I5ZU5kNUpvUnNKSmlRczE0bTBnN3hNdHlrS081?=
 =?utf-8?B?cklvMFJUM05QQjZXNDBtMEpqWnZpTlJKS2I0NHJScUhqUksrL2xiM1ZSWUVR?=
 =?utf-8?B?dnFndE1JUjY4cXZUTHVJTmNGR1IvR3pYQjFHYmxZa3dTdks3WTNuMzZpWndJ?=
 =?utf-8?B?Nmk2bGRYOGRyQ0YvTSs0eHpGbXJGVkJzMFFHZmFjaHBLWVFKZU9uV1NQc1Bx?=
 =?utf-8?B?a3Rkcjd3Q2x0MGFhOXh0My8yNTBsYnNpajlBRSt6Wld3T0F4OWVtdnk0TkhY?=
 =?utf-8?B?S3haNkdITkQycE0yOXgzNm94NUhvRzFBTUhzSjd5OU5Zd0VsaDFWbGhCVGcv?=
 =?utf-8?B?NHhIcHBZbWtZbGxqZW5BM0VOL1E1d2doSFo3TjlTWTJHdkRXRW5WQnRlaUdL?=
 =?utf-8?B?d2RNd2xVd3VxYmp6aDQ2SjdVWGNqMWZONzliVDFhU2Z0eGhudzUxTjl2Znlq?=
 =?utf-8?B?NURvSVI4d0NWVnFhRGUzbTFWeExvZVlnaU1WaC9jSnpXYzE1NkxORm5oMXFz?=
 =?utf-8?B?bkpwbnF2TzZaV1ZYV0c4Y2JWZUNXQmJrN0lySHJwSDl3Qzh6Wm9ZbkNZTVVT?=
 =?utf-8?B?dkhmajRzayt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVFRVlJ0QzAyTXBQQ2IyRE9GWkxWNklhNVNiUHNscjdFellWbmdCQndlQjda?=
 =?utf-8?B?Rk8zZE5UYnZvM1pwamVIMytKODdkc0dvYzhHOU9PTHZUSlBjcDM3NkNIdFI4?=
 =?utf-8?B?MnozeXVSQWEveG9weEhuM0NqTmN2a3JkMStQdWYvUzI4di9tSTJnMFA4ejRK?=
 =?utf-8?B?Qm92OEZwYjhqL2VuNmpiamc3d3cvZzVFSC9wOXFpN1ZzKzR3cHJjazlMMVdi?=
 =?utf-8?B?VDZGVllhQTE2MUd6TzB5bktFSzJnRGJITCt2aythVk9kRGxaYTNpMmI2RFlJ?=
 =?utf-8?B?L25ZMmtjRXBWYUVtaFF3YTdLKzNxYW1kVTdJZXFCRnExdnpRNG1Ec1hoSWxJ?=
 =?utf-8?B?ZVNZRVFUOWs1SW5zQVN4OGVyeGE5dnU5WDJ6TGI5WGl5S2Z0N3F3UU9rMith?=
 =?utf-8?B?VElVdnd0MmxIRmw1QnlNUW44YXI5ai9DYVVyK08zYkpJTTdVTTBiREo2RW9B?=
 =?utf-8?B?eFJNM2theERobEtFMFNDdXlsTi9WbU1mbit0RG5zek9jY0hTcExvOXluYWtw?=
 =?utf-8?B?NmhldUs1bVM0Y2FzL0JEais0RVZhR0hpUTV4NU53TTB4UmhQWkhBSVVWQVJE?=
 =?utf-8?B?Ukh6WTc3THhWcWljL255andyVUhiSWsrS0lsUDRHNkY2SnBvVWNTWDZqUldU?=
 =?utf-8?B?UVZOdHZyK2MrN0MzR04zbmpENnFDVkRNck9WSlhrbTZuMHc2SHBvYnZRUFZy?=
 =?utf-8?B?dlV4Y1QwOHlTMTVnTk5CTmxacEF6TXI5MW1CYU9ldHNNeFdEUkRNNUd2Z215?=
 =?utf-8?B?S1ROd3FNL0lEbjdLbzM1ZWZHYzRzNjBwbWl4bVBldGJScS91OWtaakpuYlF6?=
 =?utf-8?B?cUdoTUU2Q2ZGMEJGZE1Zd0laRW9rcEgvcmVUYXgvbkxGT3ZHMW9FUDhOTVFO?=
 =?utf-8?B?QXY0QjMvZWdhR2tvZ3FIQytLY09OU0JxbldabTh5Y1B6RjQ4L1IrYWE5aTVu?=
 =?utf-8?B?Mk9UT1UyaXlWbHFmd1dweU1JeERFcElDbU8ySEtvaDd5dEN4RDJTTDZyZkFz?=
 =?utf-8?B?WjhxVDdVQUoxdXFEMWM4ancyZGk1QjRkU09iSjc0ZE9uN01WMlEzbTNoWE5E?=
 =?utf-8?B?Q1VHMEsycnZvRnNQZWZ2ajlhOXZwQnhWUHVZc2lXMUxCQ01FQmtIc0R1MXRV?=
 =?utf-8?B?RUhjSDRENFNzcG5DSkh0dWRZcFFyeVE1YUVLeGppanBYMjY1Z3dMb1cvd2tB?=
 =?utf-8?B?L0lmMzNnbWdSMHlSYkFjdTZlT2Q5bVBhcmpWby9SdE50YTlMSm41NEx3Y285?=
 =?utf-8?B?amJYV1Q1V2lXVU5YOHlZL1FTRFIvUVR4R1N6UFlZRFNaQ3RTU1U1OUg2Qnln?=
 =?utf-8?B?NjRvQWhqRmRxb29DNDJqRE03Sy83eUM2VldscGNSS1dpSE9rNkFNenFIZ3dO?=
 =?utf-8?B?T0swbEwzUE1GNVNScSt4MEpPS1dncHh4WEl2OWNjMTN1Z3JXTUladUg5M0d5?=
 =?utf-8?B?VGwwc2FNQW10SkNjS0pKZUZtWndNSWl2blVEVlR2ZlRZTUFZdDZmSFlFL25S?=
 =?utf-8?B?MkQxWHcyZVR5c3JENG5WT3JSc1NBaHRSSElycW53Z0FYSFl0d08zT0JoREtr?=
 =?utf-8?B?V3doUGJlMlkzdXprb0Zxd3MvT2ZOQzJScVZVNWlrNWdub2NqS0NqQkJackRn?=
 =?utf-8?B?VVhVc1A4ZnBmcHZmdTRwMWRMQWJDUzR2cEQ4dzBBMzZ0NUVoU2ZBYkZTZFRX?=
 =?utf-8?B?SFBkMnJVRzRMZUUyL2dYYm1ZZm5RNHBDYjFkdjZwdjVuV2FxREtweHowUkla?=
 =?utf-8?B?dFd0QnR5UzZuWndtbmVBWS8zb21FWE9xUmlrSTVHd2pkUTlVS3B4Q0lwbFRO?=
 =?utf-8?B?eUd4RkN1T0NlWUUvb01EeTdjVTQrNEFlazRQaktNR2g0MC9SRE1oWHpHY3pI?=
 =?utf-8?B?aW1HYnYzcFc3TG5QVHhxa0IrcDQzbit1ak9XbzZWUHEzYVJIbzNXcTdOemMy?=
 =?utf-8?B?RjExTllwbXB0ZTYwSnNxdmQxZ3p4OXI5aUt2TTBFbzNqYnNKdXZOdGUwa0tw?=
 =?utf-8?B?RWFqei9RNkwzSXkxZDJNTHE2cFhwVW1KQi9tRjQ0VFJCWElrcmwydWsreDFa?=
 =?utf-8?B?OW0xcUJWMjBYR0RqWVBXL1UzUm1RNjVUVTBFZUtPckhuek5WVCtXTzRmTE9l?=
 =?utf-8?B?bHBnZEczQ0RIMmsxSUFTYzZMWkNTOGJyenMyQ1gxby9saVFLU2ZtZHB1K0gw?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9405a9-5e6d-442e-34eb-08dde6ca5fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 07:05:02.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHC9JvvZQFc9vOnmzAet4RfVDALlF6j9XKFFcNjo3Oz0PGToc9iTWr4SbhGlhvMLO0EZVYs4j2C6sd3zU2JBUNbla0i4qzId6Lf1NnNVaEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com

PkZyb206IE1pbmEgQWxtYXNyeSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4NCj5TZW50OiBUaHVy
c2RheSwgQXVndXN0IDI4LCAyMDI1IDY6NTggUE0NCj4NCj5PbiBUaHUsIEF1ZyAyOCwgMjAyNSBh
dCA5OjUw4oCvQU0gQXJrYWRpdXN6IEt1YmFsZXdza2kNCj48YXJrYWRpdXN6Lmt1YmFsZXdza2lA
aW50ZWwuY29tPiB3cm90ZToNCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRpb24vbmV0bGluay9zcGVj
cy9uZXRkZXYueWFtbCAgICAgfCAgNjEgKysrKysNCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvTWFrZWZpbGUgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlLmggICAgICAgIHwgICA1ICsNCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2xpYi5jICAgIHwgICA2ICsNCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX21haW4uYyAgIHwgICA2ICsNCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3R4X2Nsay5jIHwgMTAwICsrKysrKysNCj4+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2ljZS9pY2VfdHhfY2xrLmggfCAgMTcgKysNCj4+ICBpbmNsdWRlL2xpbnV4L25l
dGRldl90eF9jbGsuaCAgICAgICAgICAgICAgIHwgIDkyICsrKysrKysNCj4+ICBpbmNsdWRlL2xp
bnV4L25ldGRldmljZS5oICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4+ICBpbmNsdWRlL3Vh
cGkvbGludXgvbmV0ZGV2LmggICAgICAgICAgICAgICAgIHwgIDE4ICsrDQo+PiAgbmV0L0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMSArKw0KPj4gIG5ldC9jb3Jl
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPj4gIG5ldC9jb3Jl
L25ldGRldi1nZW5sLWdlbi5jICAgICAgICAgICAgICAgICAgfCAgMzcgKysrDQo+PiAgbmV0L2Nv
cmUvbmV0ZGV2LWdlbmwtZ2VuLmggICAgICAgICAgICAgICAgICB8ICAgNCArDQo+PiAgbmV0L2Nv
cmUvbmV0ZGV2LWdlbmwuYyAgICAgICAgICAgICAgICAgICAgICB8IDI4NyArKysrKysrKysrKysr
KysrKysrKw0KPj4gIG5ldC9jb3JlL3R4X2Nsay5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAyMTggKysrKysrKysrKysrKysrDQo+PiAgbmV0L2NvcmUvdHhfY2xrLmggICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzNiArKysNCj4+ICB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvbmV0
ZGV2LmggICAgICAgICAgIHwgIDE4ICsrDQo+PiAgMTggZmlsZXMgY2hhbmdlZCwgOTMyIGluc2Vy
dGlvbnMoKykNCj4NCj5Db25zaWRlciBicmVha2luZyB1cCBhIGNoYW5nZSBvZiB0aGlzIHNpemUg
aW4gYSBwYXRjaCBzZXJpZXMgdG8gbWFrZSBpdCBhDQo+Yml0IGVhc2llciBmb3IgcmV2aWV3ZXJz
LCBpZiBpdCBtYWtlcyBzZW5zZSB0byB5b3UuDQo+DQo+LS0NCj5UaGFua3MsDQo+TWluYQ0KDQpZ
ZXMsIHdpbGwgc3VyZWx5IGRvIGZvciBub24tUkZDIHN1Ym1pc3Npb24uDQoNClRoYW5rIHlvdSEN
CkFya2FkaXVzeg0K

