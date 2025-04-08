Return-Path: <netdev+bounces-180178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ABDA7FE15
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759FB189330B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957526981F;
	Tue,  8 Apr 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+DCHVwP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4F2690FB;
	Tue,  8 Apr 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110074; cv=fail; b=dSHTnyOaeeArVybzMHT7l9Lit7GjEpDMsDqtv19LM6e4BkV/Bs3DEVJbrzmh4yDJEeB7kg9i3km7IzBDrBfbDZWg3ZDJYXsMrwaZLZIe+REkW/yedkBlV02FHpoO+rS13yxCEM+cZVkPv1YWzjYk8UMFF2Xm4EGQctNHTwUWxKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110074; c=relaxed/simple;
	bh=CsHrZB38HqvGx0B2sfW1GNB1L9eiYEoYoRnczUuwl9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rzwZhm78NwfsWI9dfpiqOYNUX6J+c7HGuqROVbK9TDbe0fJCk3tVgupC4wWR3Q6m3sU054wgyIZuCZnFipIlHXiG6kfHfdwIgrb4Tb2XnLcNanc8L5nRLcyWD16uwYkdmjA9uSciaP2iFlCNefTfS+27YSumwBt+clFjfCVrXAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+DCHVwP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744110073; x=1775646073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CsHrZB38HqvGx0B2sfW1GNB1L9eiYEoYoRnczUuwl9g=;
  b=i+DCHVwPs4Qtx0rA+fQMbxojquQLXiSo0sCL6KVz0xxRIj/vkZvNiW8g
   CqSpCw4KZTobMSO5sjq9VgYh9tN9PuqH55eqh8LOhHR+5SaEdnptRHhSZ
   W24WQdFCkyyo2cPJUbFyPI6PxZb0LgfiXUCDgDNPIDAcX/lyBh1azyPEf
   36+YtCi6lhVdketdCfIOKY5ZgQK08UlSYdh9i4P5t+V9xc/jGYpuT3kGy
   EBOgGxE7yYZPZwg8luvGMbjyVeMfV5eJoLUpG7yBCObMdOe3i4AGEv178
   msh0GKWlkmRZFO2i0QprMZtuDJxZD3LtpZ2/27rioC2aax2azDLdHwkcz
   w==;
X-CSE-ConnectionGUID: H6FwU0uOTLaP7xVRpeHdfw==
X-CSE-MsgGUID: QNx47HgFTSq2WzYcVrJrMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45250538"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="45250538"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 04:01:03 -0700
X-CSE-ConnectionGUID: gxRpNO43RLyDqVADf4z13w==
X-CSE-MsgGUID: MKXXCUfnT2a1WL6lXdFVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="129098899"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 04:01:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 04:00:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 04:00:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 04:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ9fY8yk47LeN2Ztt8rjQh066EO2r4vnIOlkJpt+gA7GNgW2Q9zXJX1r8dcRy7ul2+lPrI7s2ao9z5g633AfwVBNpliCNYfyJ6fRowQf2kfEc1WPmhMDlBiUP93k7iPBlJZY9BcgSizXrvJaViDePaQWuINZ7vug6+zTK3PHQP6JS5yIz+SzsppoIfKN+4EkvqcpZM3ZK+8LOni1yrtj5JI+cIOgBKjbJMmz7awSeFit82ZGGL0RDTfQ7449WNP+Xu6wP3TEx51pfW5d8MpN0aUl0ba3Ws7bskerhvGFmgkk8t3JIUCtFr780NOiB3w9jLfkt4bBaLxOh3S9iAFMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsHrZB38HqvGx0B2sfW1GNB1L9eiYEoYoRnczUuwl9g=;
 b=BMnwLJYhjFpL7raJiIdYyWfFJiIvlYv+Mf0F5W9ZMGRrsggAb/SuzI5RLugnyyV+3BW5M7oPTVRk/CucHB1RVmovQSIShLThhjlVPA16q1TT+Je+TD5UPM3wEzonEkX+/RLHTKSpVUtfJTaztQ7uMqJO4vDY/v6zqk12FmeqIhSqj8wS1m0WzJkkrr+K7KpLkg23A+p46m9u+jWPLwVqHvNe37i/F1i+HS0Oy4GcKuQxQjoJxbZ0o3edTMMt5wNNlPPKu9I82jOn/4tpIkRfV4RG1t5lw4NapzHkfdl5ULhCjzJ+SdKB7vM8mI0csBEEQTgxhDGQqn/Kud9/iLDEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.31; Tue, 8 Apr 2025 11:00:55 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%5]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 11:00:55 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Dumazet, Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, "R, Bharath"
	<bharath.r@intel.com>
Subject: RE: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
Thread-Topic: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
Thread-Index: AQHbqAc+IOPKqVTF60C3pQTjerY+GrOY6wcAgACuWmA=
Date: Tue, 8 Apr 2025 11:00:55 +0000
Message-ID: <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
In-Reply-To: <d9638476-1778-4e34-96ac-448d12877702@amd.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|PH8PR11MB6681:EE_
x-ms-office365-filtering-correlation-id: 0655d074-b8b7-4885-3942-08dd768ca2bc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WXlzanlDWWZTY1cyZEY1d0ZBQTdpYUs0VUM5bXZhbU9FZ2tEWWxrZ3FDanI0?=
 =?utf-8?B?Qm9aMCtsMVFHOGRTTFFqRS92cnhjSWNTS0xucUNJT05sR2hqbmlSRkhIeEJL?=
 =?utf-8?B?MXZsbFBQbjR4U2FFcCsyWVBMcjUvVm43cUZCVHNpRTlXSm5tRHc4TVVSRjBz?=
 =?utf-8?B?NjZUTHEzcHU5Z1p2YzFUaW1Mc0YvK2VZcEZUVUtkVjMzSHc5NlR2eXA3cHZH?=
 =?utf-8?B?YWhSRFgwenJOOUhDN21UMmJSR1QvYUZqRmozSi9JbEtPbFVJMkl5cHRaekZW?=
 =?utf-8?B?bjlmNUg1dGFadWFid2MyK2xGY0sxL0Rra1dPd2o4dVR3amRWbXZyZ1gzOTky?=
 =?utf-8?B?NGxDQXBlUy8xT2FpaHFYb2pITWV2bmhpNWdROWo2cTZCQmVBVDJQR0tKUzJ5?=
 =?utf-8?B?Y3JZbUhSQVZpcnIwRE9sNWE2VUVkS0RmbkVreVNySkVHQldIWDZOMys4Wkl5?=
 =?utf-8?B?NFZvZGtOUUE3QzhqYXdMQ2M5akZmVHpXaFJJc2E1Wld6ZWQxbmtQM1NzcFNG?=
 =?utf-8?B?c0pTSlh3MFdpK0diOGtGR2ZlU3VBWXB5YlluTUVWOXppUGNGMGxXcGpDaUtC?=
 =?utf-8?B?MjU2ZVZnN2lHWkFjUlpGczVpUThoWVRWYTgwZjdERWNIOUtqbUFEY0JUckxm?=
 =?utf-8?B?bkt3cCtWV2JieGhQK0t6VE55QTJBQXM5U3NwNnNvZUNZWllldDR2ZVJnWm5N?=
 =?utf-8?B?UjNqekoxNlhMeWNrcWxCSm9pYnVVSGNFV3BMemQ5dnZFUi9VWS9EUldhR1J0?=
 =?utf-8?B?b0tsMlRXME9BaHVoSnRjbDF0akpNKzRWRGJLd3hVdFMwbFcrRWFaN3BSSHpi?=
 =?utf-8?B?WFJqRHgyeXA2MFN5Zk1sQVNIY1o5RzF3M00wVml1N0d4Y2g5UUI5WWszSWI3?=
 =?utf-8?B?VWNFaVMrMFRsY3RKZG53SVJCTHhSSkNIRGtDMkpDcTh5N0ErTlJ4QTZ1UHN6?=
 =?utf-8?B?TVBPVVMzOXhFZ1NKOTlsc3ZSckJNZ0Ezb0I4NFJ5Z2FaQkZKSkVzUVdwYzF3?=
 =?utf-8?B?cjcvWjB4NHptaVJHYXgxU2pCUlVHWUY0UzJXSUNrUXBVbWkyVkxxM29IRlY3?=
 =?utf-8?B?azZzd3liM3ZVdDJUaXdlTFAzaFc3RjJ5YnA2WTZnTVBXWFR3dnZhMkFTckI0?=
 =?utf-8?B?MEVVaU83d1Y2SnZCcWQvS2JxZ2k0MVdTMlBwZDZXZy9Za2tjcVRuQ2NKNVVv?=
 =?utf-8?B?T2lKbHhmcVNyNUtJK3B1RzJjS2lBT1daTHo3Sk9wZU1sWWJHNTJSdjFlRHJx?=
 =?utf-8?B?YUpHdkMzK0dJbzdKblVGL0lDRXAvYkpNN1VKb1kzUy8vaHlGcm8vckJsUXFs?=
 =?utf-8?B?VjQ0amJiM1N5OWl1eDExNXlLcnhpdjI5N2hzdTE2bzFoVnV4eDlGaU5uN0Nk?=
 =?utf-8?B?cWNqb2QxSVg3ekx1VncvNEtvUEtiY0hqMXpOLzNMTlIrRys2eDVWUXJQSHpi?=
 =?utf-8?B?V3pNWngzWlVwdUFhYmZrSEZiZ2F1ek93dmtHekRpMVpKNUhUMllFY1B5a0p6?=
 =?utf-8?B?dWZWenYyS0FQNFhjSXIxTGZHRGFFUE1zaDBtdnBkd1REcU1OaEpEY3hFekJa?=
 =?utf-8?B?b1FuYnhvZms1WkN1cUNKWEliNXk5ZkgzTUdaMjMyVUUvS0pkb3VCV1YwcTdL?=
 =?utf-8?B?Q3ErWnNheUlMZGY4cFlNVUI2V1RVOXhERStiN1ZaZi9lcUFiNmZ1ZGJQWml5?=
 =?utf-8?B?TWNDemJWN1BMT2dpNUg4SHVUZGhqejAyRzRndC9CKzNPN01oN3VMRnRCaE1B?=
 =?utf-8?B?aTA2Ymc0bzJFQ0ovN1ZCQkhWV0s5VDFkdXJpcGZncVIwMzhqWVZBWU1tZmhO?=
 =?utf-8?B?bGZ2cko3bWNCb2lKMVAxT1NXZkJoLzExMU1jb1FrTWFNdjRZRlNCS1B2YmR2?=
 =?utf-8?B?czBXU3ZtdXBYRnFuRThvcVh5UVNUTXp5aFB5eHlzakdXYnQzU1BURU4zLzFZ?=
 =?utf-8?B?TEs3bTRsbjFYL0Rla0x1ZU5qVGdtamYxR3BrNXQ2Nk5XZ3M5a2VybDhlZkpG?=
 =?utf-8?B?TkQ0bm9mWDFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnVWem9tUUZqMm8ydzRqSmc5YkdXMzBhdm1xNC8xOTBlMWtJWlNVSnRVUjBs?=
 =?utf-8?B?YlNyMy9QWmNMK2dDaUh5dmlTUDlLQkRRVldjWnVXZDFuRC82KzFxcG5wMEJR?=
 =?utf-8?B?TjVNK09wM2R2TE95clNrdG1EUENRcitNbXZHMTNLMmtWTVpiYnU1MzBxQXhE?=
 =?utf-8?B?WE9YeXVnOFFlaWNzUEcveDg5SnZDN0cwM2VJdFUwWk1WcDQ1dDVnZjNJaDc0?=
 =?utf-8?B?Yndpc1FuTjNXbmF1VmUvTjZJaFg3UEhmVElLZDl6N2liaXVxcDJheFJxdUlu?=
 =?utf-8?B?cW4vUExZaHpRcENNVmlSanJaOHZkR3lHN0NIVzZ0SDRTL2dhR25peFRqeDlX?=
 =?utf-8?B?UTVHUzZ3QzNTaUFZTlI5bDdYMjhtdmhVMEZiK29RMTFTY1JVMkJSaGJKTWtz?=
 =?utf-8?B?MDZCTWhObUgxV01mOW1SSTZHa3FLWVEyblMzVGZBQVY3dGErTmFoNmNnRVlt?=
 =?utf-8?B?ZklxZ1dTaWMyaU5LdEw1a1l0WXV5MVgzSEhzQnpxUUNrSjRseTVZT2NmQUlQ?=
 =?utf-8?B?VFNjL29VQXNRUi9oQi90QUQ1UUZZazlGU1JwVXFLaEdCdGQ0ZUNaVXZ3VWt0?=
 =?utf-8?B?Rjc5akZ0NzduUk0xZ3ZjNWtqblcrbW1ONDV3RDFUL2lxN1hpbFRtZmpLRG1M?=
 =?utf-8?B?RVhwNG9hYWl0bndnQXRvQ0RiV3VjOG5uVGlSbE1PZmU3Y1RnZGUyYlR2eXh6?=
 =?utf-8?B?SEhrV3NTNnpuU3BlbzRJVHFONUV4b1d1ZTlwZTlpT3hKZnlFM3A5STVFeURZ?=
 =?utf-8?B?SDdwNWduTzgzYnY3WVNNclBpendqK0QwMkJXaVFESVFxaHd6MGxMZGVrL2pH?=
 =?utf-8?B?L3JjQkVOUnN6di9XTmZwek4vbHFwN2FBSWZLNE1JaDlaUERobHFYSCszNTEz?=
 =?utf-8?B?T2s0MlEzV2NLRkpHUmlhNzE3NDBUTXN1bml3dDhsbDJ1KzNnTnBnazJUdUFG?=
 =?utf-8?B?TmZlWVJpcUJtVWRuVksyMmlPRmpPb1ZYcUxidzJaSDhpbHk4RzJROGd1L3NI?=
 =?utf-8?B?M29oaFNYRWQzdjkyMzBVMmpJdTlKNjE2TjRMNHVUMWZFdXpyTmdxSEg3Y3k1?=
 =?utf-8?B?citobVE4MGNNVTU1L2VBMUFQK0ExUWVYZllXNm0wRXBOZTZxeVA1c0tmZWFx?=
 =?utf-8?B?R2ZHNDI1ZTRTWXJObVlPdC9TZDBCbFNzS01sTmVZbzhUN3o5c3Jkd0Zmd0tJ?=
 =?utf-8?B?cXVlN25TZml4QVlNZ3hRc3dJV0c3THV4bjhEbDM0VHJvZGc0RGpXRU90MVEz?=
 =?utf-8?B?TzlYZ1ZHWVBtekVuU1BhT3E2L1JQaTkvRUxLWjN1dUFPUEVqenpjclBjU1JX?=
 =?utf-8?B?K3pkUWw4bXM1d1ZFZXNiVyt4YlpPbFA0WkRoUjdGL3g2eVNBbzdIK1ZqaXZv?=
 =?utf-8?B?M01SNFdmRGlMbXdhQ25NTTRLUUp2TExXT3N3S0xWdG53Mzh0S2dIVXNPazV2?=
 =?utf-8?B?R2ZQMTVDYm1ZNjVEN3BhREMveHJaSXpzaEw5SGRiNWRFT0tVUVRoVFJ5dE42?=
 =?utf-8?B?aU9LZDVoVThBazBLa3FVcGpadjFKL0dUY0FVRGVhTDkzQkorUXBidmZFU0Jo?=
 =?utf-8?B?RGVMWTFtV1JhN2pzYXRYYWZJbVZvVTJXREsrT3BFeVBHRFNaSkI1MTZYVUkx?=
 =?utf-8?B?K2JLTmFXTHdvcDhyWng1amJCTTljNVBBZlh3ZUxNc0hkTnlCbldUMjFXZldy?=
 =?utf-8?B?cUQxQzVGS3FjekFYOUpvUkRPeHFWQWdySGJkQzhkbjAzTWltT21JZXlENWE1?=
 =?utf-8?B?Qmd1SVVMK0UvQkkwQy9kdmEzQVlMc0Vmdi96YS9mVTZRalpDajV2WGE3Mk1Z?=
 =?utf-8?B?OFJrZWpnUThLTnAyTXRLOTA4NDh1RW55SFpLa1FHRDViQVFQem13M0dRYUZt?=
 =?utf-8?B?N0k1dkRpSG5KcWZZaWR4YUhCeHF3OENkYVN5NXZzcjVBb09SQjdObExQcHVy?=
 =?utf-8?B?QmlPaDl2RFVqeWdwTFlSaTNqS0R6WW1PTjBTWUowV1dZNXo2MDdDcS9hWGEw?=
 =?utf-8?B?OTdXWUFHKzdycHg0TjJ5S2VicVhSd29NRy84ZmJuczU5RUNjcDYxcm9EbVBh?=
 =?utf-8?B?WEdSNzZrVDJlUHRZd1B1Mm9mWFNrSXlkYzNkLy9JekQ4MElqczc1c0FkVnNs?=
 =?utf-8?Q?fDTiBSuSW9pRccH97kAfa2POB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0655d074-b8b7-4885-3942-08dd768ca2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 11:00:55.3924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooilF23zZBt8Q3mh3PQEBy80fviY0eiKyZYScebyxeaB52d8dPO9XjWQdw8v87M7vMQqJs9cCl1FytmgNpoTwpOjUpE65lIEgNr7hL/uz9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com

RnJvbTogTmVsc29uLCBTaGFubm9uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPiANClNlbnQ6IFR1
ZXNkYXksIEFwcmlsIDgsIDIwMjUgMjozMSBBTQ0KDQo+T24gNC83LzIwMjUgMjo1MSBQTSwgVG9u
eSBOZ3V5ZW4gd3JvdGU6DQo+PiBGcm9tOiBKZWRyemVqIEphZ2llbHNraSA8amVkcnplai5qYWdp
ZWxza2lAaW50ZWwuY29tPg0KPj4gDQo+PiBQcmV2ZW50IGZyb20gcHJvY2VlZGluZyBpZiB0aGVy
ZSdzIG5vdGhpbmcgdG8gcHJpbnQuDQo+PiANCj4+IFN1Z2dlc3RlZC1ieTogUHJ6ZW1layBLaXRz
emVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEppcmkg
UGlya28gPGppcmlAbnZpZGlhLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBLYWxlc2ggQVAgPGthbGVz
aC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tPg0KPj4gVGVzdGVkLWJ5OiBCaGFyYXRoIFIg
PGJoYXJhdGguckBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKZWRyemVqIEphZ2llbHNr
aSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVG9ueSBO
Z3V5ZW4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIG5ldC9kZXZs
aW5rL2Rldi5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL25ldC9kZXZsaW5rL2Rldi5jIGIvbmV0
L2RldmxpbmsvZGV2LmMNCj4+IGluZGV4IGQ2ZTNkYjMwMGFjYi4uMDI2MDI3MDRiZGVhIDEwMDY0
NA0KPj4gLS0tIGEvbmV0L2RldmxpbmsvZGV2LmMNCj4+ICsrKyBiL25ldC9kZXZsaW5rL2Rldi5j
DQo+PiBAQCAtNzc1LDcgKzc3NSw3IEBAIHN0YXRpYyBpbnQgZGV2bGlua19pbmZvX3ZlcnNpb25f
cHV0KHN0cnVjdCBkZXZsaW5rX2luZm9fcmVxICpyZXEsIGludCBhdHRyLA0KPj4gICAgICAgICAg
ICAgICAgICByZXEtPnZlcnNpb25fY2IodmVyc2lvbl9uYW1lLCB2ZXJzaW9uX3R5cGUsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXEtPnZlcnNpb25fY2JfcHJpdik7DQo+
PiANCj4+IC0gICAgICAgaWYgKCFyZXEtPm1zZykNCj4+ICsgICAgICAgaWYgKCFyZXEtPm1zZyB8
fCAhKnZlcnNpb25fdmFsdWUpDQo+DQo+UGVyc29uYWxseSwgSSdkIGxpa2UgdG8ga25vdyB0aGF0
IHRoZSB2YWx1ZSB3YXMgYmxhbmsgaWYgdGhlcmUgd2FzIA0KPm5vcm1hbGx5IGEgdmFsdWUgdG8g
YmUgcHJpbnRlZC4gIFRoaXMgaXMgcmVtb3ZpbmcgYSB1c2VmdWwgaW5kaWNhdG9yIG9mIA0KPnNv
bWV0aGluZyB0aGF0IG1pZ2h0IGJlIHdyb25nLg0KPg0KPnNsbg0KDQoNCkFjdHVhbGx5IHRoaXMg
c3RpbGwgd29ya3MgdGhlIHNhbWUgLSB3aGVuIHRoZXJlIGlzIG5vIGVudHJ5IHRoYXQgbWVhbnMN
CnRoYXQgdGhlIGlucHV0IHdhcyBibGFuaywgc28gaXQgc3RpbGwgZ2l2ZXMgeW91IHNvbWUgbWVz
c2FnZS4NCkZyb20gbXkgc3RhbmRwb2ludCB0aGF0J3Mgc29tZSBzb3J0IG9mIG5pY2UtdG8taGF2
ZSBwcmV2ZW50aW5nIGZyb20gcHJpbnRpbmcNCnRoZSBkYXRhIHdoaWNoIGhhcyBub3QgYmVlbiBp
bml0ZWQgd2hpY2ggbW9zdCBsaWtlbHkgaXMgbm90IGludGVudGlvbmFsIGFuZA0KZG9lc24ndCBs
b29rIGdvb2QgaW1oby4NCg0KPg0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+IA0K
Pj4gICAgICAgICAgbmVzdCA9IG5sYV9uZXN0X3N0YXJ0X25vZmxhZyhyZXEtPm1zZywgYXR0cik7
DQo+PiAtLQ0KPj4gMi40Ny4xDQo+PiANCj4+IA0KDQo=

