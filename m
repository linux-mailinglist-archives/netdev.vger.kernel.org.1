Return-Path: <netdev+bounces-178250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33594A75E7B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 07:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C51889DB7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489C158218;
	Mon, 31 Mar 2025 05:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjyymXQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613B610C;
	Mon, 31 Mar 2025 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743397820; cv=fail; b=hJKpQ7QfR0ehET5X2tIPW9FO25N5WZmsZ0XzSBU2YAL3j22uDmOr+/zRf1qdpyDVa5GpaRTCbi2x9Ji53+PHCwW9R2V5zLRkyzlYqJGE/2BVoUvlTsK+78pR/6VIdYY+Dsorjb64GuEnJCG2iQwiSc3pkA+IkPvsr9CjnHLPv6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743397820; c=relaxed/simple;
	bh=0czzwKbYDuMADhZkt8iXNUrTbs36b5tt7BgFR0r9pNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/Pnxz9VwdJyR2lagPcRNWPV0mA0f8spAg9JRfQRMMtZuVaP4VeEaeFQN41iogDqHLfgekdsq0V9chYh+j7gYvD+aTa0CgdekOaYyVRlz5I3jTigIJMVny0SiDbojsunc/2S4Q80KenVupBBQmJJImQ0nK0U5f7LKZSy7gBG3/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjyymXQ/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743397819; x=1774933819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0czzwKbYDuMADhZkt8iXNUrTbs36b5tt7BgFR0r9pNQ=;
  b=CjyymXQ/ckSbukPCzxQBjaZxLpypMKlD+oRSUSVAoemtA0+3kxBL+3Fx
   oZQLmBintBR4ZttwT84w8GUb2De+qMNg0qmroMjCc2VIzdSlu3kacUjPg
   1aYW4T68XQ09pWSo/4mZ2RB9jCVFk722bRZbjvQ70mdUxYEICxYR22qQc
   0F9hLcTBE+sDoaSjq+FwpqZ0wMKnQoOhuqmRso0k05qEpSWPWB068ai4h
   e9YMK4BxwDnd7zjvK1cytgTV5cyW6qfN9AKjsUAS3xBaXxsv9Mrp6o8u6
   tGHBkWgWVdBmeFxoyzsZvC7LqNoLbkEV2f9FSW2059tm1L1HSiuWmVvhQ
   w==;
X-CSE-ConnectionGUID: epmZZBnpRAOwM5EwFQAhOw==
X-CSE-MsgGUID: PdqQ2hEKS5iROexE51aK7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="54873377"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="54873377"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 22:10:15 -0700
X-CSE-ConnectionGUID: PISPVgeYSlS+ziUlnZZtkA==
X-CSE-MsgGUID: t63MyUJtQgutw27JfhWY5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="131205455"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 22:10:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 30 Mar 2025 22:10:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 30 Mar 2025 22:10:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 30 Mar 2025 22:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXCHbEPEYnD7Ok6/BRCSFy+anF9bR4FTbtA39dK343wH2Aj52tMvPZopuPA/mX6akES3dVgmcIASUuALNjFhbGiM9/x/MR4ZW1nu+Ix8eVCIk9c1+U87ZiI4z/qFZTm2Ml4vGwv7hkbEENk/ez/7RiSLoMn8mz1+7mA9JGELfoQKXX806dcHUBGS5B1b1fzB8W6i/SFGLCabGz1KR65x8TEHqUBN4T387StBHOuFMtVh9AsI7UC1B9jB689iDP98OiOueg09HYA4RexmiF//WnSnXa0xZ6VwJcVYqr6htzXjNfKBig1SPGOsmiCsk6UK5zYZBcWRf2j/8H1Z2loUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0czzwKbYDuMADhZkt8iXNUrTbs36b5tt7BgFR0r9pNQ=;
 b=ihiVNnct1+lEmEpcYb110obuvdOnKYONsOjazyeSTiHODMGkI63Si3InkFPpr21X0sWD6woTvkGj12mlxK3ryzOEjvmD0l4Z5+ThaRO/nW357XBCIYLw2AD1jPhOaWJBa26yu5Z3DkFhA+lRa8enVODAYxgvIyjvuyDGy2otEGNpgr6LRDU2iBNp0xJMCT2PtwGVVp3CC62A0g9p12E5A3ndG1see8tFqUkjfn5S5/PFw7fz01StnOqbnufVpHOTaeQAPYGXlDiFukUmSj3uEM6xh3Y2/jXN0uSsI2zvMQeNMW0M4aYn5Ue48JpBvx26j4shpYBOuGcrlD4JW/bUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 05:10:11 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%7]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 05:10:11 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH][next][V2] ice: make const read-only
 array dflt_rules static
Thread-Topic: [Intel-wired-lan] [PATCH][next][V2] ice: make const read-only
 array dflt_rules static
Thread-Index: AQHbl2EO0Ijmc6m6PkS2VvUtUrb7t7OMxp2Q
Date: Mon, 31 Mar 2025 05:10:11 +0000
Message-ID: <IA1PR11MB624195A5595ED5D17773F66C8BAD2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250317172024.526534-1-colin.i.king@gmail.com>
In-Reply-To: <20250317172024.526534-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 46553b39-1420-450e-c9fa-08dd70125026
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?bTBKR1ZyYUZUcElCbEx6MkJhRHdvNTdtVm11b0ZUaUZJVGN4bk9aWjIxWjB4?=
 =?utf-8?B?S3lmWEJtQjhFWEhxREZRdVJNR28rVnEvV3Y5SlRwV2duVVdMZTNEMzZGL1Y5?=
 =?utf-8?B?NTRXZmd3QWlSVHhJY2gwV3c1T1dyYnBWY1lYcHlBTUZxWnlFWTRiVnNHdkRT?=
 =?utf-8?B?aHhGNWEydEFrbndHb3pNSmhTZ1RxZmhPS2JnL2s4Wk5HR2toOHJVWElJdVMw?=
 =?utf-8?B?TGNNbTFWQ25nOTFFZW5Gc1VPaWVIbHpzcDZRd00rRHlxNFR1M3BWVFhCR1JT?=
 =?utf-8?B?b0Z1bWUwNFhqK3BHOTl2dmJXY3FHeS9saDIvUGFWRWtGZkhuYUhJY3RHdXdR?=
 =?utf-8?B?VzQ5NTFrQUl3Q2JKQ1hXR0U1bUdVbzVLSXFkVGJERkF2QkY4V0hCYjJOL0s0?=
 =?utf-8?B?dGt2U20wOTJpbERWY3JPb3FxV0UxTFJGa1B5bUxkUVhVNnU5WHVXUFN3bmVQ?=
 =?utf-8?B?bW54VTRUbzl3S1R4NkNiSURuU3I2cEU1RThEQlV0dnVBOXRIM0JDTWgvenNU?=
 =?utf-8?B?b2Rodjd6ZGlJeFRSWEFFczZOWUNKWXpJMzY0QjVxUHRmZDhoZ2RPMUZGcDJK?=
 =?utf-8?B?VWJmRk5LRzBOVXc1M3pUQVo5QTU1OFNsRTVjeTQzQ2JqNmllOFBxZFZiNnpM?=
 =?utf-8?B?TE5hTEZzWDNJbjFWR1NEMXJ6UUFyVzk1bzgwcU1CamNxVy9CU0pmZlFQcUdu?=
 =?utf-8?B?S3plcnZKY3lKZEo2NGZjU00rdnErSkJOOGJQejBtaGhxRkxJcWpyOTRObTcw?=
 =?utf-8?B?VU1zR3FKcHZndndtN0RqV0hudGtWMHh6TEt4b3JaZzcwOVovMzhnYUMrdkto?=
 =?utf-8?B?cHNORTlibWR6NmFXWXRlSUYzdjV6ZjZBbzdWMW5SUWdGQndxMHZhYUdLZ3dz?=
 =?utf-8?B?dTJHaGIyVnQzRU9Tb3A5LzZ0enRoQnRSSDFGdzM5VVE1ZkhwTllCa2g5UzVp?=
 =?utf-8?B?QmRvY1QrTjQ5V2c1K1YrRDdPRXhuN2xTWXJBNm4rT1VOOVVJcXpFMkl5ZG03?=
 =?utf-8?B?Y01nWE9FTUpHTWp5Wk41ZGg0anYrY21pdytvRmJkcXRpWnlabDg5NkVsMWFn?=
 =?utf-8?B?NnlLdTVZUDQ5aW5POXpVaUJhTlBZZldMd2E1MG00UndiMmNZYml5QlNTMzRD?=
 =?utf-8?B?M1p4ck5vV0pVZHhZWEtDL05DU3JFQXBvZDY0M2dONFV6SFFGMVI2dzROMElQ?=
 =?utf-8?B?QU1HL2k3bkQvQlowTWNHdmNQNm9MRjYvS2Zyd1A0T0Y5eXRDL2l6Qm53Unk5?=
 =?utf-8?B?ZlVISDVnY2w2UXQvcFdTM05qVCs1Rkt4eVNocmpiQ0FITytMOVgwV3dYYVdw?=
 =?utf-8?B?ZTBvWERoWnZVT3N1cXUrdDVoS0ZaRG83M0k0Z1lQMllGeFQrMXNHRmxZSVlP?=
 =?utf-8?B?OG0vQ0d0THNRUUkyUC9yalRuT1JGTlNYZnBSa3BhSzQwV0RuTVovdjBLZGdS?=
 =?utf-8?B?QUdGRm9VeTQ1VEpSNVJPSkxlY0ZQUzBXMWN2SVRjVFYrR1hNcGllYTVoTlUz?=
 =?utf-8?B?Qys4bCtRN0F0cjZNb0sxaW9xQWl5LzhqNFA3eFNPcGlULy9LN3BETmZ5VmZp?=
 =?utf-8?B?WGw2V3RQeHYyeGVKMWlhd0o0U2toUHJ6QjBpYm14MWMwbEdwS1hZZVNOcHhy?=
 =?utf-8?B?TXdjVXlFTWpoaXV4RzNaZ0dQWmxzU1hMaHI0TUcyTFFidjZiUFN0bEhQM1cr?=
 =?utf-8?B?R2pCSVp4ZS9QRlNEMWhzd2UzNmxQSDN6OUMyTS9TeXlUYjhRVWlnTEFQVjdW?=
 =?utf-8?B?WmtkQVJFaWJmODZpSGFHbndldDFjNWJ5L2tYT3Z1bS95UGUzN2p1VDRIMy94?=
 =?utf-8?B?bURWb3Z2NFp0dU5LODZRa2QwK20yRVdBUUpSY0gwcms1U2VGQWFyclUxNFNt?=
 =?utf-8?B?OEczV0xTbm1zTy9uMVJEV2pPYUxReW15b2ZMTytmYVhwanovSlJKN2hodG54?=
 =?utf-8?Q?XyEctNTr5ZBI/P5n3MfSgiEmfKP+DcyQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNxL045bkhPbjZuL0JCaWdabDlqK1V2SHpqaUxiaFN6ZG5Xemp2Qi9vVjBF?=
 =?utf-8?B?Z0dXaHVaN0lhN2pqVDV3cnFJd21xcVora1loTzdsQk0zQzl3SWNBSjgxRFdR?=
 =?utf-8?B?TzI3bUFSMjV2SHFlTHRXd2J1bjNmUUNoTERkTFkxb3MwQjdJZVZ1N1F4elNu?=
 =?utf-8?B?Nk1Mcld0UHF4NE1SNm90ZjRieVNsaE5qanlGYmZDY0RLNytvV0QvTHIySVlU?=
 =?utf-8?B?RjU4Vit5a09UYTA3a2RtNmdGVUtORE9pTFBhaURZQ0w0RlJ5TUFOVnRaS0M4?=
 =?utf-8?B?ZnhMek9zd0dneEpRRkRRUkRlOEE3cnJSMUNtanZxMHRXdVdJRVAxNmxuR2NQ?=
 =?utf-8?B?Z1kybGkzbXB6Wmh2OHVmNDRheTAzUjV6ekhBNXFqNVR5L3RQbmxtSDRLSW9h?=
 =?utf-8?B?TUZENWwvRm1yNDhHOENwenV3NWEyMUFBVmMyeUNiNmt4SlU2ZWtLaHhBaUk3?=
 =?utf-8?B?Q1NpckNGK3lndTFrV2RkRDd2NzVsbzhQY0M2NlAraDNUeUwwNDNDNEMyek8y?=
 =?utf-8?B?eE95b2dJbWtQM3BrSW9EV0g4Wjc0bWFnc0pQb29WQ2R3SS9tem1LdmpNZHRh?=
 =?utf-8?B?OVp6TEFCTzYrYUE0TTlyeHR6TTF4d0F6MzlaUXo3OCtvT1lVbjh2LzIxOVR2?=
 =?utf-8?B?eUtKMHNXdHkxeU44SXVFYXNCd2JQSW56MDR5bm5wVFU5c3hLQ0RBQ2h1NDlr?=
 =?utf-8?B?K1cwam1kN0wwU09wWDRBUTJzTXBsRWE5UzIyV25MWWh5dy9zZVR1b3JuaG1V?=
 =?utf-8?B?OGlucHU0UFZSdndlYTBjdkdWVmlZMks3VlkzekJHZE04VEI5aHRGalIxSTZq?=
 =?utf-8?B?VEYyVTZmaVBmZWUxS1BoSUNHRnBzaGttaUFFMjY5S3cyZTlPZlJ1N2R0Q2Iw?=
 =?utf-8?B?alEwTUhOajArY0kzOWVuSisyaWpSV04yMDRwWmUydVRMYXNMOForcWh6K0xy?=
 =?utf-8?B?a1JiakJWTUlwaHJCTDlCblcwZ1hqdXRteXd4VzJpR1dIVGd5cy9kWXZTTFlY?=
 =?utf-8?B?Vjl4ZzVPZEdrVXIraEt0a2xnQlNFM1E5NzBMU1hNblVkNUp0T05FWnZucGZT?=
 =?utf-8?B?dVlPWWVaQjY0RDlKalRTUG05K25xZFA4cG9yd0lsV05FNmlxaGlYYjlVOXlh?=
 =?utf-8?B?WU42QjM4L3ExRHh1OVEwNzJ2UHBLcjdjcktrenY5YUpJVzVXWDcwRERManpk?=
 =?utf-8?B?OWxzNDdLR3UxazhuaGZvMHpibVpSRWlXNHVJRkxzd21MZFcyejNHK3RhQnBx?=
 =?utf-8?B?Q0hPc2ZEc3RpYVBFT1hsSjRrZFQ1QjJVZW42U1Q4bDlpdi9DRVJTT3Y1WXpP?=
 =?utf-8?B?K0R6cXkweUhrQzR3SnNTYUlxVGVlajlJWEx2OVByTFAxMXJzWnlGREJ5dTd1?=
 =?utf-8?B?RlAyRWJJMmlyazJWNUtQamZwMkRkeGk0ZXZ6MEZYUmxDY09JcnNoR1VDQ28x?=
 =?utf-8?B?SlR6OHJsVVV0Zk9MZU5uSDFPT2s0ZVA5WkVsbmdYNktmb2RBTlptVXZVcG0v?=
 =?utf-8?B?dXRydnJucmF1VkV6RC9pU0luVXo1aFVBYmcwWkZxSjdOdnBlOWQ5THRHOEFZ?=
 =?utf-8?B?YTRPcDluMTFOeVNrVi9nS1NtVFA3R2VPME5CeHRKRGxMaUpncU8vdGEvWVdv?=
 =?utf-8?B?Y0h4OHk1MVZzanl2dkttVTAzNVF4OTJ2VGYrOURjaDlqQ0pyVmxZd0pkNTZ1?=
 =?utf-8?B?MmVxUGlRSERQVkJhK3h2MWlwVFZoMWJFL0dtVHl5SERjMDl1dWc3OVc0OHk2?=
 =?utf-8?B?d2NsMHorcllFQ1Z6WVVSSnlzK0NucHVoMERwSytBSmUrSUZMVUxjRDU1SDZy?=
 =?utf-8?B?VEtUSVB5bTVIdlVwZVBHdG15bU1tTnFoRm5pUlN2eVhpSDJHV0VVcW9BZ1FX?=
 =?utf-8?B?VFhRd3FFUU5zWWs4ZVVhTGF1aHVqaEJORzFOSE80bytkMDc3bHZCWmtMTlR6?=
 =?utf-8?B?bXc5YUxnNHZNdHllUFAyQXMrNE5VMllyUEdLMFJpZFZzeXdlK05IbFE3KzJa?=
 =?utf-8?B?VDg1WkV6QWNCTll6MVFiWERWV1JOU3psYmZyVjJPOEFleHFXWktScitWQjNK?=
 =?utf-8?B?YUpBS2NXYXJUZ0U5VWNpL3VrT1FORjBBLzdxN2RmdVBDYmhnNmZnNnQ5Mk94?=
 =?utf-8?Q?PghRvzBY3mVXJ7u9Fca/O+cWb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46553b39-1420-450e-c9fa-08dd70125026
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 05:10:11.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmFUQPk7qog8MVHxae8jQfNm2VgGH2IhvHlcsPyHnJDZTTgCblJ+5BgaW+cf+sy1xQexdUjfErddhAmrdrrUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBDb2xpbiBJYW4g
S2luZw0KPiBTZW50OiAxNyBNYXJjaCAyMDI1IDIyOjUwDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkg
TCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnpl
bXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVu
bi5jaD47IERhdmlkIFMgLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBEdW1hemV0LCBF
cmljIDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0
cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBrZXJuZWwtamFuaXRv
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSF1bbmV4dF1bVjJdIGljZTogbWFrZSBjb25zdCBy
ZWFkLW9ubHkgYXJyYXkgZGZsdF9ydWxlcyBzdGF0aWMNCj4NCj4gRG9uJ3QgcG9wdWxhdGUgdGhl
IGNvbnN0IHJlYWQtb25seSBhcnJheSBkZmx0X3J1bGVzIG9uIHRoZSBzdGFjayBhdCBydW4gdGlt
ZSwgaW5zdGVhZCBtYWtlIGl0IHN0YXRpYy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFu
IEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+DQo+IC0tLQ0KPiBWMjogUmVtb3ZlIGFk
ZGl0aW9uYWwgY2hhbmdlcyBub3QgcmVsYXRlZCB0byB0aGlzIGNvbW1pdC4NCj4gLS0tDQo+IGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbF9mZGlyLmMgfCAyICstDQo+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KDQpUZXN0
ZWQtYnk6IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29y
a2VyIGF0IEludGVsKQ0K

