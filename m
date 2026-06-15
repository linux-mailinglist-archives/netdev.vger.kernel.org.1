Return-Path: <netdev+bounces-299520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hn3yDq8iMGqoOgUAu9opvQ
	(envelope-from <netdev+bounces-299520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:05:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA2688150
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:05:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DOpcaKt2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299520-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299520-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24E0A300B185
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E007407CD3;
	Mon, 15 Jun 2026 16:05:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E73C5DBF
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:04:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539500; cv=fail; b=s0Bz5+OHGvRSTz8tWp5FbbkUyvV0cU9Tc8lzJ7RwGko8nL1T7XEJVw/uqcpidWvTLLBpAmOeoi/ZQZ+Jer03WVL8/sxOXAzoIsaPHl/JDKocbfFjREbmQP7/WVuSkzuTMX/7pMsWK7VEUPURSGYScLdoIzCRVka1N0uOHkxnikQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539500; c=relaxed/simple;
	bh=CaIDOxDqsWP6u8QupRt5NArQqF6utw8y7mZHCscViHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jB2aaY6NIjRx/tXEK6Gu1sEh6z96J3gqQWRVg6hTA16c16KCJTfQW1IYf7DjfDvJe/r1nApAqd5C6PsQOLBeJVYjlAiRo6KMqt+0fNk6djCz8Vpzm5CCCdMlBiLMY47IW7iCZ1hDDN9JlS2qwleNoRqpDar51djH6/bF1cgX8pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOpcaKt2; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781539499; x=1813075499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CaIDOxDqsWP6u8QupRt5NArQqF6utw8y7mZHCscViHw=;
  b=DOpcaKt2pO5Kh/p9IptNcfc4KPOqSiW9DTEs6vYNYmt2EZB951/9a1/t
   uOx+aeFyt6PIIxUt7M459BGf/RgkQ+6T4x+l1fwf2v3AppZSNwJiwDxgy
   ojIl59m3q3Uf7U23yNEUCEder0pSGbls+7MCjfgvfzbCsXwdMgDPOqaGD
   kHg/jlca2iNf7MjMRN9uZxGGQFT6iiAndx9vgWk+h9lr9VB/dfoFGeH9A
   DEowzHAPZGx5Q6+yVuuxfNrPENBxhUH8FQCzO839779BjGZfzYsjHIY6Y
   JPCmHBCz7IbbrWroqG+s4e6LaCGybEVkzMOXSg7MMvsrnpwSWy5BjYn03
   Q==;
X-CSE-ConnectionGUID: hvbvvTQgS/WY0Eq8t/MAGw==
X-CSE-MsgGUID: EXlPPV6uR/K7Jy3CdfNdvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92955281"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="92955281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 09:04:58 -0700
X-CSE-ConnectionGUID: sGp79sO4TiOVOjTA9xIgOw==
X-CSE-MsgGUID: oqWLAOY1R52aA3zpTrXw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="246606735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 09:04:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 09:04:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 09:04:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 09:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgMka91Yn4qFaqqrecunSMh+SIApFHgMmo/+S/4ocu2bkUIsA2AKFwOtGjof9cat0bjKELhiAcPFsgBdrUcZSHYqvDi9oEhYXvgNjDap5QVGF6g+2iw/y7BlTSKMubZpfh3OEd0geMhuOz7P0oGhF8WebG9DJC4SBPTBpB4HYvgl9pDmX0AWd0b6m8YW8LNZFmW/353PaqkM85r1pngF9v74OCwY7C8sDiGjj4g5306eNZj5Shl+qNepkdNLyKXAsmpcNJ59BhkQXeBgP51KwWHaFdLTwjsp99Wy6lOSx9lYYwNrOJ3Ndi3SlnpL6uawrUSbB8cRkCaqGp9PYQ8LuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaIDOxDqsWP6u8QupRt5NArQqF6utw8y7mZHCscViHw=;
 b=DNQPFRBPGXTLcunpslFPYjN7pNr5rAH3lnvJWMCtl5jxRvvWVZku4a9xbT9T1fSib/zLReqsYktMhZAxKRJn6/88vmj84nM8uhJnSaqo5pPjJpYH2eNT/jXWinNfnwErEfuy3aiH5TFvDH7xaaAjs4yhmKNn6iDbdxSwd+Plbonq7/pKf4U8bqBMx7LDhTNy3Qs/crPB23+W1+Om3oEjLq4RN/hcinVCUvybO8wP0FcH9FXDF6HMrqhHa4na/11WFVHReRVKw81frYcJz+s/u3mA7vi5rScRy2VSJOg+xuE8s5ti5RIXe/mCFc68+sCakrIQ6fq8THLTSTdUDIdmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 16:04:55 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 16:04:55 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 6/6] ice: refactor
 ice_sched_cfg_agg to take agg_info pointer
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 6/6] ice: refactor
 ice_sched_cfg_agg to take agg_info pointer
Thread-Index: AQHc8iT9/zRgUs82iE2mZRSfFh6FubY/10vA
Date: Mon, 15 Jun 2026 16:04:54 +0000
Message-ID: <IA1PR11MB62415FA4F6DFFE79C0E707A68BE62@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
 <20260601-jk-cleanup-vsi-aggregator-nodes-v1-6-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-6-36d6ecbe5ede@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: a4a0d176-06d1-4336-a96c-08decaf7d74b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: lrH/S1t6xOcmMAIKSprnUv59B2ytGX2bLf0flI9KG1p+IAgziuaD2mEOjZTjThWbQfoIopvmuHyzsuhTJf/b3Uk/9iYy0iX3AwkOm+HQMNHlTlkvgPK9g33e02bpyJregax5xv/5KJ0KFNQuay0kcd69hcbu560D1aWzjf5JtqFawZoDFFN2/w+f50WkWdcVmhhCUcUNX0LoVkeSfin9sCwpMfl0mq4TrjxwigBE93YduycvIru6RNY7GHRQkpxTLX7pJDdZVmzPgVFIJ0IUom+nxWE/vcMbeU0Yfu68qUW4AMBV4ybU5YOPrxGQdmWI7f66lUUolZCgHqymo2iEX2s9dwjTTmHHdgLBpGHHoPurzPCDU2n5bk5iC53emk+HixfgQv9X7KqC7OJWeAHsQxk3LFm6AfU12Iq3gf5N/5abda9lwatv4RO7J5I7Wt5zZbOs62I7qnVLkM2XO7s0rHnWY3qI2Lo7qu6K73T9EqsGgDLyL/ygdY2vKviDdH4iymTmZo/u4LYnPuqoM9rQH/EcMx8XxaBKN8VovHDoLWhMEWm+01q3w0xFwSjY4zhK0cYWvI6fOhUMAwo6/kOeLaM7yowRoFcG3FWI6E2YV24e71Be1mpHWerb1gJ+1D/joxnI709eq05SJqTkyF4sl0L3VREqT4egLSJrkmPAVf/uvotk03xfzdFB3Pv3ChunvdowhY4G3PGvrzMsg0yiqqRBWSfVkdlh8l3tSc4s/s7Ixwoa3+P8bTK1IIkU2L15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmlnaXRrUG4yMDRRVFdGMjE2ZS9JeCthMC9WZVZzRnMzSHVRaGM1WUk0cHZj?=
 =?utf-8?B?RUUvZXZkT2dKN2pwKy9tQW5KUER6OVFSS3g0S0lYQWdWTStnMnMxSG9kMUww?=
 =?utf-8?B?VHZYNzhWWG9hbW81THI1Sk12TFBHL0ZQWGRuK04yN3I4WllEblFRMFZRaXNt?=
 =?utf-8?B?THoza2pzbG9wWGVNVlNNZ0RLYVZUbDBaUFNPUFFpUXFrZTMwTlgwQnY0Q3Jr?=
 =?utf-8?B?OVFSOEZsNUU4bU9UUGt3SkRtQnpmcWJNK29kODlkNy8rN3pXb3gzSHZqa25U?=
 =?utf-8?B?OHc2UEM5Wm5LT3N6bGNMdVlJenBRNGE2WWY3NGhPR2R0dnRkdGFDcmk3eDYr?=
 =?utf-8?B?b1ZhZm1EamViOURGUFkxY1ZFdnlHKzdxY0dJTzhUUmwzU1pUa05aSzVuK1Rv?=
 =?utf-8?B?Wlc0dnJKM2JnTDhTZXpOdXZDTElyYzhJSFVkVW5ISUM0Z2tLVEpYMkpvMGph?=
 =?utf-8?B?WDFqRVJNd1c5TERkV2dWT0FMU09SbkZWUlhJZHM3OHlGak83MDA4TGExQkpT?=
 =?utf-8?B?VHRtR1RxNmFHYkNqaDY3NDN4M3pTbmtDMHFCa240a2s5eUd2ZTRIbStHY08w?=
 =?utf-8?B?ZUl6Q3cvOTlnR3hoRWtRNXdBMldSVW14YTZoWWhCcWFvVVlBQ1d1dk5KWnZB?=
 =?utf-8?B?WnJRTXlGc0JaQS9FV0lJaWZrUkl2REJUcDZvVlp5aEtLc2tMcERnMWhBLzhD?=
 =?utf-8?B?WUFsaVBvdzMyZStjaGpST0NNVG0vTlZqVWwzSE5mU0kwSUdnMnVMQjVOOG1S?=
 =?utf-8?B?Wkg4eWptcTNBWDlLMHZnc1VldXUyQTZFdFdjYStpdWNOQ0ZDYUs5QWRmcmU5?=
 =?utf-8?B?bkFmdm5PM3dKUGFBanRBdndXSktvMjkza2VCcTRGeUcyeVRYVmNhalR1Zy9q?=
 =?utf-8?B?bTdLbDZMNTlrc1VCcm5lMDhkaU1TODR4NWprZm12TnhBUTMwT1lmbEhsSjdx?=
 =?utf-8?B?bllQVTl4L3lJaHhmcklraWE1Y3RVdkVKemljNU9UNlhWNjdSM0g1U2dIWW5q?=
 =?utf-8?B?TmVrc0UxQ2FVY1ZuWUhNWGJsVWtyenQ1NHlPRUVBZ0xJdG9TUUVUL24zNm52?=
 =?utf-8?B?elNhYlFPaFlvTEJiOXdjekpPTWMxZElueFJwZDJnTGZ2Q2NJa0RSK3ZweGxs?=
 =?utf-8?B?ci9XN1BHUEx2L2NURzVRSWljZVpKRnl0cHo1Nko0YmxhRWlPVVk3cVV4d01B?=
 =?utf-8?B?T0tlZk03Q0xlM01IVXRMYjNyUzd1R0ZlQm9EclRPdlppanZRM0tIZENZYlRu?=
 =?utf-8?B?WDIyT0U3SkNRRlRXSkVXWXNKeUJvbXVHeDFWd3hrQ2xaT2w5eGtkMVh6dStU?=
 =?utf-8?B?VEwwZTdmVmR0SE9HZU5iU09vVmVyT3dIQnhrdWs0M01xVFZrU3hDTTY5cDZj?=
 =?utf-8?B?WGFZc1lnU2J5cHJCR2pDMWRyQXgzSldna3ZEMzU0YTJsOVBZVGxRVXFCWnVB?=
 =?utf-8?B?SW9LS3hrY1kxbUNGTHc3UXY2VFFRNnhBd2MxcWdVTGxSRmw3d2hObHNFMmg4?=
 =?utf-8?B?eFBHVkU5WjZuc0RpQUlEUTg1UVJtMUgwb2RZVit2OUJRT1h2OTIreitQUWox?=
 =?utf-8?B?WHo2ZnY2eVgvZE81TklOdW5DWW45b21kSkRwbkZKb05ZMVRkM1VaOElQQUJm?=
 =?utf-8?B?UUxKNEVyZEpxaTZwdlZVRE1YdFlpWWpYOUhlYzFUNmp1cjhBREFTS3JoU2lY?=
 =?utf-8?B?U3lnc2MxZUVjSEV0RmxLKzY1VkpPKzh6MFA0REN4RnVZY0FuMGR3eTcxaUpQ?=
 =?utf-8?B?SnZpV0huYkRVeUtmV2lTQ0E3QndIV0JzK0lwcUJxQUZ0dGpaYll3N1QrN3RN?=
 =?utf-8?B?MXp2cEtycXd6YnhRVUhxTjBSV2QzK0pUemRqRWxQUjNiVjFtcjA1K0VCaktx?=
 =?utf-8?B?ZnpYRVFnaitlKzkybmx1dDd2Z1p2Mm03cktzVExJaHkrQVNwVmZxWGlGRGkz?=
 =?utf-8?B?amhJNlA1c3ZCd2Q4ZUczT3hNazl5dTNHK2hSWEZOZWpOT1JBQ3ZneWdSdG4z?=
 =?utf-8?B?QWxlaGJaZXhGMEdNK1lNcExnN1BoeFhMUzVKMTBYd2xFMmpncWxQZjg1bk9N?=
 =?utf-8?B?OWY2WEJrcEFBTTBEQUt5c2phUm9qQjdrNWh5ZGl1WElXQ0VtZnhjd1JqQmMy?=
 =?utf-8?B?SXBuaXFDc2VHektOVmtRYjVLOE9PTjRoU2tRRmhmUVllM0hZcVlpd1d3cGxq?=
 =?utf-8?B?alpGZjJmQzAxVzMrRk1WdjZjRHA0MmNKVUlBZ3dMcW85b0d1czZBckZ3MFRT?=
 =?utf-8?B?b0xjOUtaTk1mMkxKNlpCbTZhU3R6dUpHYU9Lb0R5MXZINEhyMmdUZ1NORkZH?=
 =?utf-8?B?ZHY5QnI2UWNKRUJwSy9uZEM5VFg1T0xwREFSVVQzQ3JIMlAzZ3Z2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NgpYVQPJD/NVw6J/zfwgEBA8WZIyh192+0mrYGHtpAiwHJRoMLPw6l3N2knY/zf7uDByAXz55D8UjJzhQFxcGkJD+IK/pCrSBL18q3DCdwb0exATZ/qJXdMmDRyhX9lFpdrVL1D5Pdrr58w5Co4DkDE85NU0PvOW+M3rem6XMnLotZ5OCEYni3nZ2bKUATOp6SL5y9iISywkWQeWC4MeZaNqaL3cLCGTrtx7iXY/tYOlQRzf6UrbmC/X47thHwyE1RuW90KfZcKLXgr7Lye4C9ewoTV6ZiXmvV0st+ioow2+Pk6u7v+Zl6lOPtFo9KkyWQWFzDpYFQkN9vC26avtGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a0d176-06d1-4336-a96c-08decaf7d74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 16:04:55.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BJxbCvL+geo9KlUCepid2t6bPootLn4XqL7HXxFyvbggdtgIwXloC6OntY4guLPP1ysUuZLyi5lTk9nzCCTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9FA2688150

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDIgSnVuZSAyMDI2IDA1OjQ0DQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGlu
dGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
Tmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBDYzogS2l0
c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IExva3Rpb25v
diwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtlbGxlciwgSmFj
b2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFs
ZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFu
XSBbUEFUQ0ggaXdsLW5leHQgNi82XSBpY2U6IHJlZmFjdG9yIGljZV9zY2hlZF9jZmdfYWdnIHRv
IHRha2UgYWdnX2luZm8gcG9pbnRlcg0KPg0KPiBUaGUgaWNlX3NjaGVkX2NmZ19hZ2coKSBmdW5j
dGlvbiBpcyBjYWxsZWQgd2l0aCBhbiBhZ2dyZWdhdG9yIElEIGFuZCB0eXBlLg0KPiBJdCBwZXJm
b3JtcyBhIGxvb2t1cCBvZiB0aGUgYWdncmVnYXRvciBpbmZvIHN0cnVjdHVyZSBieSBJRC4gSWYg
dGhlIGxvb2t1cCBmYWlscywgaXQgY2FsbHMgaWNlX2FsbG9jX2FnZ19pbmZvIHRvIGFsbG9jYXRl
IGEgbmV3IGFnZ3JlZ2F0b3Igc3RydWN0dXJlIGZvciB0aGF0IElELg0KPg0KPiBUaGlzIGJlaGF2
aW9yIHVzZWQgdG8gbWFrZSBzZW5zZSB3aGVuIGljZV9jZmdfYWdnKCkgd2FzIGV4cG9ydGVkIGFu
ZCBpbnRlbmRlZCB0byBjcmVhdGUgYSBuZXcgYWdncmVnYXRvciBub2RlIGZvciBhIHNwZWNpZmlj
IElELiBUaGlzIGlzIG5vIGxvbmdlciB0cnVlLCBhbmQgYWxsIHRocmVlIGNhbGxlcnMgb2YgaWNl
X3NjaGVkX2NmZ19hZ2coKSBhbHJlYWR5IGhhdmUgYSB2YWxpZCBhZ2dfaW5mbyBzdHJ1Y3R1cmUu
DQo+DQo+IFJlZmFjdG9yIHRoZSBmdW5jdGlvbiB0byB0YWtlIHRoZSBhZ2dfaW5mbyBwb2ludGVy
IGRpcmVjdGx5LCBkcm9wcGluZyB0aGUgdW5uZWNlc3NhcnkgbG9va3VwIGFuZCBhbGxvY2F0aW9u
IGZhbGxiYWNrLiBUaGlzIHNpbXBsaWZpZXMgdGhlIGZ1bmN0aW9uLCBhbmQga2VlcHMgaXRzIHNj
b3BlIHRhcmdldGVkIGF0IHRyYWZmaWMgY2xhc3MgY29uZmlndXJhdGlvbi4NCj4NCj4gVGhpcyBy
ZW1vdmVzIGVzc2VudGlhbGx5IGRlYWQgY29kZSwgYW5kIHByZXZlbnRzIHRoZSBuZWVkIGZvciBh
ZGRpbmcgYWRkaXRpb25hbCBlcnJvciBjbGVhbnVwIGZvciBmYWlsdXJlcyB0aGF0IGFyZSBpbXBv
c3NpYmxlLg0KPg0KPiBTdWdnZXN0ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5k
ci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9u
b3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9zY2hlZC5jIHwgNDkgKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlv
bnMoLSkNCj4NCg0KVGVzdGVkLWJ5OiBSaW5pdGhhIFMgPHN4LnJpbml0aGFAaW50ZWwuY29tPiAo
QSBDb250aW5nZW50IHdvcmtlciBhdCBJbnRlbCkNCg==

