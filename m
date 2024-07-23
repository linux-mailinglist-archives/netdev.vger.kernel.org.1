Return-Path: <netdev+bounces-112526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689B939C24
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498DCB21F1F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B814A4DF;
	Tue, 23 Jul 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B48P9Wy7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACF10979
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721695; cv=fail; b=J0gILsC9StqRvY3WtFImwszTe3sQKfDG1gWdtLO1gSaz1MnE2wPSSbKmOF4DWcbB8VH663nFuGwRJsEBMZaB7XRg0vQ8j3VmBMsm8yManI6PN94dHUx1UKC6MbDmxqutFhtYetOgLAVwB0YbLoucOwFNlXIIxJaUBrbvaUAiSKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721695; c=relaxed/simple;
	bh=2NGqxrf2S1L5SY3mGHgE9lQs5r3AKDUilAsl318090o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XNhEs9QkY2kCBOaCX44KH0B5Ggkiuagi/mLg4zPzNTTCXyPixJwutOzpImsIMRVOClJtywrSEXU3bUVBGS/JgCPUnRAxbWmCnQ89PnL+QjB1whYStLde78ZlIswr/kBNxkvNxjvKrJFni6EpQZIxsbbRr5nE7mknWCp/AF8meDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B48P9Wy7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721721694; x=1753257694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2NGqxrf2S1L5SY3mGHgE9lQs5r3AKDUilAsl318090o=;
  b=B48P9Wy7zQgudYE6DeuiF3D+dwaeLw2mAqcvhKLfXir1+k8joRVPfQbA
   I3Cx+eUStPwwhD8fAJmVDrp4Y0GIqjOAPBSUHIOeZLbfDU6RKhoIVB57l
   SbIGuKC3GEvexdXiFivm0t6tC3W8Q4DiJoloFT+1jK3CnDvt3MylkRdQY
   Hdgd2x6gJAb2MGagJJsQeIYphKAepouhWM7tQO484VQl4NXbOnzwccoM3
   pVKuUMcsnsfOMjHIOZcy0WIw7+vku2z3RW+LfkA0wi8MzJ+5j+jRe4jEW
   9COZGfMO+gB/XSLArwOmyv0lO9vyMRlsa+IOIEzvX1j+Wc9/Fcfq0uznt
   A==;
X-CSE-ConnectionGUID: //NyS14zT8+47y0aBSHhEQ==
X-CSE-MsgGUID: RGA51icnQ+Ssfdjw0pwRXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29919658"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="29919658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 01:01:33 -0700
X-CSE-ConnectionGUID: Mc/YJqfORVidViA17+CVEw==
X-CSE-MsgGUID: iz1JCccaQZmdM0PX/EK+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="51817123"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 01:01:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:01:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:01:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:01:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha2/p2cvBPPkctjhKSpWtR9KUcnCYQBZbGmM1OHepII65zy27gPbyxcIoYNUKzuA7o1pIbfsslR5rg7K6JE31+UaoIlll/jXEsZ12Rhtut5hoAXDPGRE/YmrnRE4ClG8hAu0hVSxdc1WB+E4Hgtme/sxbFSHfZue5vLSocFgfJnyEyoyjFHHJtLRTKMgE/c+ogZe/HrugA47QvWx2RE4jh6iCfs4b5KGRO33ukTF1A2GMfxHLFm6IzbLx2q0almghWEjO8D77SlxpoTkxnLXju6wBEOF3jjP3JqYjIrJfmdd1EZDxjfHRuirQMV7eSJnyFhI54Vpa67LO3Xy3tL8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiPFFX5yMGLwC/YkC9A3eozExD6YPjUpmNkF+dMxQdw=;
 b=Qeto8C3/zfAeGTiXb5deGkmu5XZDcwSvX/zgOdlUjtTVXfPKuQxgutYWozCCYV24rxVWjUpegGRGaD+bCCNEJWR9MDTDWunGBKZTJxNfGLIxWnDf7ItBqa1jIf0reaiXfylB/Zr0lPsiZgM3ExIj4Y9s+CfqHxgc6xzHSk2X+7N7rCbURrzGVakosjm8w0sWa8mwsfSAHybOIt8+McnY7oym1L+GIPQZf1kHRpDWNbCElO/I741qvms7S2WRgGGbgtH6OShwG2YOL8j/5e5m3uZiuOm//NB4TVHSw7y0DUex7CyZ4Jxx0w+HFjKG0RvJtxytVqHfrTXr3ib/2fg6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 08:01:29 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 08:01:29 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Guo, Junfeng" <junfeng.guo@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 07/13] ice: add UDP tunnels
 support to the parser
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 07/13] ice: add UDP tunnels
 support to the parser
Thread-Index: AQHasGgDZQEeik6vc0CKEB7bRauSwbIETCjA
Date: Tue, 23 Jul 2024 08:01:29 +0000
Message-ID: <SJ0PR11MB58651C53E9D31731FF3E6AAE8FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-8-ahmed.zaki@intel.com>
In-Reply-To: <20240527185810.3077299-8-ahmed.zaki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: dccc66bd-80c6-4064-17a3-08dcaaeda87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nmrbn6cpV4GNjchYFuDHlDazxr1VFX3Xej8Hi88GH+hbdq2Eo/Q2PoJLbihN?=
 =?us-ascii?Q?esI+8QC0zQDDPbFoa9xKNsTDKjwbU24Jb3t0boWdhORLXNbAFvHdPy5eJbob?=
 =?us-ascii?Q?ihkyDbSF7uMb0fLxgapqdKN6+hG0YD+oMrTRsYNz1GHgLTWGEgSMffu1n0/h?=
 =?us-ascii?Q?M7iCrBJAdiSu49lBQ6y4sBLijP5UTXAi8g+YbtY3bQQoRHeCyYWCCiv/b4d3?=
 =?us-ascii?Q?zqmcGuGMxCo+yjPeSutss0S293YgyibEKylChR28Vh/jcckDbBi7ck2Iza7V?=
 =?us-ascii?Q?Za6mXVzSPV0F9A5WdzTbJBmt4IFByvDTyFDq+sMO60fMjudvVZLp0qASt4at?=
 =?us-ascii?Q?VXjQttL9KSuxE8vAg6Y7xPHWuR9hCWCl4xtqM1a9EKspVXMpAz1FB7BVxhR8?=
 =?us-ascii?Q?CKTWOlw6rZ7x5UZFPEBlPHSOfL9MeHnZ7D3Y3L9SQPy4+0EDb/TEubwzfPd/?=
 =?us-ascii?Q?QmL9Q8jEzXbCOMUiUluEfdUoUeYiVYG9aMb1pgKZ96Cicc4yxXzhZFPL1SMg?=
 =?us-ascii?Q?vo42g21RBM5Zbq6MF/aV2XrulL0t92H/YwgHs1UjHZp2ha47wJUzuKFFUfmI?=
 =?us-ascii?Q?6xscqmHeo/GQQgCtqNdfLWL/gDQrc7R2TlIlEJY5fHOmYp0dNfcYPY63kH02?=
 =?us-ascii?Q?LirdBw7PY5Uhny9hrZaJQB11wanYDwp3LVwyLC20PYdYHKmlIbJhFXvKVbod?=
 =?us-ascii?Q?5w8aUbtu3+aJUKv5Y4SaltupWIh4/RKcgCGX+O6eWspVflZzFHOHxlI0zLHV?=
 =?us-ascii?Q?e5RhB+gDXQ2sBrTuDrNiWGa4WvEt6HJhYbiya0cmCt7qwwEF5gfsrivqNuLQ?=
 =?us-ascii?Q?/JigYuX9sJ/YsEANTvBfpPMT1t6DvWtTJXf4oOtT2+qKjFuzwxyOOXJF1aps?=
 =?us-ascii?Q?yEDGKjyuy3ahDcFH38mk9sx9GTX/tLqwKklO5KgUAhB2ff3XCKoSDavXpx3C?=
 =?us-ascii?Q?AwtAQN8Txw9SuEF+os1rnSMJBf7C91QPJVaQsVAHxFexb/XOfb+zIGBsMeWt?=
 =?us-ascii?Q?eSgaQfSiBeYEIcf73w8Pe95iLzj7CIvxUa0DClpnKyQAkK24etFWzHxD5+jn?=
 =?us-ascii?Q?TcsvH3Uyh3Avym2MO7Vrsl8ghV4VThvgcu2mheA+SELUvdK5KqkKeMQj6ayr?=
 =?us-ascii?Q?ve8hcclITxPnR6/dCbDEFmYOlLoSMhMrrVmBBWGdkRgujGFZX8b093ayNE2v?=
 =?us-ascii?Q?SQdTtD76FbmCDXMeKeJBsp8ozFxDNElb/kymqGKkFfoxY24zFdVDbYFba2gV?=
 =?us-ascii?Q?Umdkfmm4YfOSIw7UmxlbpJUHIwIVcRhBHj3OzWVnaVuyPPqgbZD7nrv+tX+M?=
 =?us-ascii?Q?llygaeP/twSBsqjdX9DsrFmIcJauaOgc0LP8gFx+gUcQf3qyI90/lID3u+mD?=
 =?us-ascii?Q?vPUsiLlMTlkFbqKmwGhtSCe4Cb6pO4LPlhvVngKiqq5ySIlhcw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ySRe7A5GkhesDP8al5DswYy201C3AOe3XNE6KbEn4Zb8L7UdA2l2YI4fZt6G?=
 =?us-ascii?Q?hUdLGldebjNI3dbgt39BUJrem3h+4RI7NskMECw/eEvOK1krNQ/5uYlaWa+Q?=
 =?us-ascii?Q?UPEou7lw7JBQmQ8+r7psmMSj+zgv94BoxNgZcJnjRkTuYz02zKd6Qp3fK/DX?=
 =?us-ascii?Q?YaUge+Xoh1MpoAbCnEUZZeu4lRuVk8hcKuDRgZ/kdOeszeMYmGZWKhEi+wIk?=
 =?us-ascii?Q?JKKddZtZDiMAwEu6Y6GJb2Pk+MpNWavIFfYjv6pYY4ksUPrlu0/r3EQWqjPb?=
 =?us-ascii?Q?QjETYecN4ttrNshqSM8DFB4YLus3Z+pSee2ou0+JsKWhnq67BAoxnqym1EBn?=
 =?us-ascii?Q?4n5/y/CAmXNpxIceCHDP8e9LdprJTRUvwgPVRgkulIdtNdv/vp5NzqC19EG5?=
 =?us-ascii?Q?ZIAFhN3UD7bB0IfCDRPwum05jJgrZPaDAJlwLGqoxZzAplT+NM2XNB7cXHjU?=
 =?us-ascii?Q?j0+9o36CD5c57+QgTMKdqujfz65wWVDYGHslOCvxxiBBf2ZameUU0GMLkOwH?=
 =?us-ascii?Q?oAcJI8Xjv7femHpU+wh0JzcXErBx2bnm/6YKbdYvMmaONM4CdjSeMXZf4+rz?=
 =?us-ascii?Q?E9kiONXLT8L6n6RSOIms6ohN2Xf1YNfMpVGgBhIMs4scSaqe3HujcfalPt4V?=
 =?us-ascii?Q?zQV6PZY+at7ah2awyM+PQOx02h0TSXktcb6GUiMhbTMCtQw4xRhg1HZNMYyh?=
 =?us-ascii?Q?LHGRsp3DwWg8Qh3CQG9aQA3DZ/qnGR8WXlJo+3c3Vx+777LNgXIgK+4FUzy3?=
 =?us-ascii?Q?POaxrU5R39OT/4MI19bNlPrb6A6ODyuwrS5quaafd+dDgA/Mz63HrMFxqRMp?=
 =?us-ascii?Q?n/pT6OM4Pc+yqGOpwd7+YBzgnGT9Nhmw8UJBxnsfF8WRvywvcVOIk37eDzkl?=
 =?us-ascii?Q?32QoKDiHGhgyEPCEwE+yfVW7MYwyHAC2mta2ezK3lrVHV68DUMtZatsBMMzH?=
 =?us-ascii?Q?Z8awAeuS7oEn6T4vP3qu5vmL8b3uMrUhlBjBovFXvitBzALPu9YRkPbgzxYe?=
 =?us-ascii?Q?HTSkOjUb/DwhQVUf9qRKADfj19IiZJC/gJon8UYugWS8w5MNbueDlfFtcoMB?=
 =?us-ascii?Q?4AQ8kHCdSoz5PQtlMB+wzEUVFLu7PrPeDiHsjxHKLgIC7dNNed7uzV4mbSun?=
 =?us-ascii?Q?WOoxHwVwpRWJ3uDUAOT7XXDasCd52mRyABp26U1vhfkDBxJ4xrhGZIiuaiaU?=
 =?us-ascii?Q?DOzrqwEio2VV+DxT44GNhloy2gWFNA3VQtnkzh22jtXnoxTlzkqROmXwjwXT?=
 =?us-ascii?Q?WQiYuHtfJ7snT3fcQ3ZR1xIc32hBD+v2SVfDHNuivRwvHHqg7rewL43UGxk/?=
 =?us-ascii?Q?gSzF7mUE5yGE74w+l1nGKzqVuwZyUjMxAFI7ARAxDKzaLVXfiHCW+50DN3ZK?=
 =?us-ascii?Q?p9Bzbs8PxpnmXZZqYDkry4f03zMu3lXj5+ijeWd6ut/HcMrROuG9kTkrHvmM?=
 =?us-ascii?Q?EqFOsYdRzrhlt/CE3ZY9bs58nl/OcrE53pFMaZSyzGIjUURZ4xTHqLsLJZZn?=
 =?us-ascii?Q?2DgQLUT8kqrZFDG3Tp4o34tpJWJ+FQxmByP3eSSszEuyEP7/PK4LkL7cYlYy?=
 =?us-ascii?Q?0nzdz/ClaojN5UtNuLVIgHe167d4mz/YiMmQHePS9BGPAvut7gR9DIj57Io5?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccc66bd-80c6-4064-17a3-08dcaaeda87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 08:01:29.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OvqIvyfiqBAqiPInPgZQE6wgjLejv1P5oLE0ukSYnSIt9Rx4Jm4CC5KDPeEi6MC6774//OmdJrIw1wd5GIbJqgwR2gFn/uQcyX6tH9MTuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ahmed Zaki
> Sent: Monday, May 27, 2024 8:58 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Marcin
> Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Guo,
> Junfeng <junfeng.guo@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 07/13] ice: add UDP tunnels=
 support
> to the parser
>=20
> From: Junfeng Guo <junfeng.guo@intel.com>
>=20
> Add support for the vxlan, geneve, ecpri UDP tunnels through the followin=
g APIs:
> - ice_parser_vxlan_tunnel_set()
> - ice_parser_geneve_tunnel_set()
> - ice_parser_ecpri_tunnel_set()
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser.c | 92 +++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_parser.h | 13 +++
>  2 files changed, 105 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c
> b/drivers/net/ethernet/intel/ice/ice_parser.c
> index c490bff94355..6a0d5f720af0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -1373,6 +1373,12 @@ static void ice_parse_lbl_item(struct ice_hw *hw, =
u16
> idx, void *item,
>  		lbl_item->type =3D ICE_LBL_BST_TYPE_DVM;
>  	else if (strstarts(lbl_item->label, ICE_LBL_BST_SVM))
>  		lbl_item->type =3D ICE_LBL_BST_TYPE_SVM;
> +	else if (strstarts(lbl_item->label, ICE_LBL_TNL_VXLAN))
> +		lbl_item->type =3D ICE_LBL_BST_TYPE_VXLAN;
> +	else if (strstarts(lbl_item->label, ICE_LBL_TNL_GENEVE))
> +		lbl_item->type =3D ICE_LBL_BST_TYPE_GENEVE;
> +	else if (strstarts(lbl_item->label, ICE_LBL_TNL_UDP_ECPRI))
> +		lbl_item->type =3D ICE_LBL_BST_TYPE_UDP_ECPRI;
>=20
>  	if (hw->debug_mask & ICE_DBG_PARSER)
>  		ice_lbl_dump(hw, lbl_item);
> @@ -2174,3 +2180,89 @@ void ice_parser_dvm_set(struct ice_parser *psr, bo=
ol
> on)


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



