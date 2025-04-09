Return-Path: <netdev+bounces-180700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C01A822B6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B83BEF94
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCD25D8FC;
	Wed,  9 Apr 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZfWA41R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7C25D8F6;
	Wed,  9 Apr 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195847; cv=fail; b=Yv2DUyxbxJy5ePtor5thlih5DtVehkoCJLRkenR5sr/zHSNEKV+zTTsXM79SGus54GEx+Np8KnzIo7Sol1wlK7zNxLsgDHcDS5vqL1FBx38YceutO5qMdIMKg9nN1D/OWWw6Yl+6bww3eaAA+v3oogp55HVMZV/7ycJSPGaEk+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195847; c=relaxed/simple;
	bh=MYY3+gdCOog9m+19wsPdXKh4hhVlxa3IqzgAecCnM0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMhqza8IRZovN4zhzUbc38pyoUBYMyOb3tjrJuezmeDpUjh/bu6iejfnHhx1xWtEQBQsPzdZIthg1SqGXPZamEPuFnudzJDeBqmv1wZfyHWdFqGvgU6lTMINm5ottIuyB7ia7Ilf2RIXqlrcFmJBYTRFOnrjDpoC5vBMjL1GJUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZfWA41R; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744195845; x=1775731845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MYY3+gdCOog9m+19wsPdXKh4hhVlxa3IqzgAecCnM0A=;
  b=lZfWA41RbmtVcdjK437D+KRS+Om1mXreqYbzqHJHUWc/zHhX87apPgUr
   g9+0Xc+t2n1FlBaVSEc1ElQRu+5Fit6fzJ7zvTFITENeTnFUSD42ZC2oh
   uBw0K7vBREBQGagPU+FOlvD319SjGh9eHFz2mwAoZuao9HGIgn5vsC1TY
   4Qd5dBEt+5a8/BcWtB3F9T69/7xDe8qEF3txFzWOw4L1aDZv336T9j5CE
   ZbyMvky59AbW9WY6aW/3usRDcO7lovJs9YAlIMy4TnTvbcwUwSPQSm9Q1
   5ZoHCMzoMbDd+8KJ6MJNQXJKT5Ariohvr9tGAyKlTrbeN5paauElYJ8li
   g==;
X-CSE-ConnectionGUID: nisAwcSjRaK3coQO0fIiiw==
X-CSE-MsgGUID: KRR2MTPeS5qXd6yJ80WoXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="71039641"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71039641"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 03:50:43 -0700
X-CSE-ConnectionGUID: BPtglXucTaSshS9kLierJA==
X-CSE-MsgGUID: 2WtGKTgpR6mIylGcXN6BcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129065145"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 03:50:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 03:50:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 03:50:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 03:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppQF+Bz58OEMtYQjP1ItWog9xHl2u0otXMdFIzpX6ETFej1tXpnMZMVCBu0gznJHNInNxg4gi/THARoYZn1NeALS/c5q4+qe/lRXMj97bDEYnKvHUQzKtBMvpzY9vSIukr52sZtno5nWlcbyodzKnB5yl+wgjMkqxdBEzy7F+4oDGDpPWIA263MyiM+NvOOcvfXf6/3BnzeqNZrLHm/KEw/gUlSs2xgkuhF2bAdqUBw2NqVMNbl47OKXJpzIJRxq1amzrsyWkWaad2sF7c3An2jRDjvIQFlT6OChE1fBi+PFuLuVLBhfzXT0xscDU8Mc5R2tHS5F1URH7pIJ/dD7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap6r7DXAAR/W0OpC656vDW9Tqj69ci2J1oEpicMPV1o=;
 b=xsgone0U+p53mUc2hICRiNaqyS6na6tO18UPJQZIIgqJv/xfLun9mTxHXJOucjeUPJmhtREqVEbrE5n6MXeN1qNoBCVP5kYVD50+VWpiIEPbSTF6+Xe3CQZTyVODx5sAGmZ1XPUQwVrznqjawYpzCRZP2OldqCHFC7Gv2kVIMHROxhFpSwfytRPSHlX/mzbCVPafTXtcroJqDmq6EcvqNGm7GxzHUaBsXRjkOSefUcWoRmYcqC3Ppuo5e3riADUmxTv0HgoQlK6/DAwUiw/0rdLLfjkEnBH+GatPEF9G3HxvusMArxff5fmowlrYdK3QXaO8SfYh0PaeFakNl5zojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 9 Apr
 2025 10:50:34 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%5]) with mapi id 15.20.8583.045; Wed, 9 Apr 2025
 10:50:34 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Dumazet, Eric" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Polchlopek,
 Mateusz" <mateusz.polchlopek@intel.com>, "R, Bharath" <bharath.r@intel.com>,
	"Mrozowicz, SlawomirX" <slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored
 versions
Thread-Topic: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored
 versions
Thread-Index: AQHbqAc/BanwLnYClUWuIGn9d5U5PLOanuoAgACH+OA=
Date: Wed, 9 Apr 2025 10:50:34 +0000
Message-ID: <DS0PR11MB778531031053B86BC5301CBBF0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-11-anthony.l.nguyen@intel.com>
 <20250408193124.37f37f7c@kernel.org>
In-Reply-To: <20250408193124.37f37f7c@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|SN7PR11MB6826:EE_
x-ms-office365-filtering-correlation-id: 3ebc04bc-1f0d-4f20-ddf1-08dd77545ada
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5Pe236yIcUQKpoMKej8ja6Rb8hkBmUxZw7YbIFb8c0MXmxyY2/vST9DCmch+?=
 =?us-ascii?Q?R7WkE5mmpCk8hqLTuL4nlzH337j3wsyO61AgWBMko/WeVG1NgDOCtmAhT52F?=
 =?us-ascii?Q?0qsS03A4vQqYoMLNKWa4MmR0OhBqPt40Duh8ksTeknfwcpECc/wBAIxfTgz3?=
 =?us-ascii?Q?6F1vZxV4kjolKMOrSag22XHbrQX8ZmsPeVAYuxQHzIKN5tqaWONs9PA/Rcc3?=
 =?us-ascii?Q?KdrccSXe9eLRbSEjExWTBO9II8CpQkUGblJ2cVi3wNoH9kwNeKt+vnl3Pgeb?=
 =?us-ascii?Q?s5x4TN/YcpJqBhs1CYIA8MB9M7qR7Ax2TXBO9jvUsxdXypfo7d0CTfQY/kFP?=
 =?us-ascii?Q?IGnOK824+zF+dpH9jRtAHD1vdDPVr5vaf/BwnUo7GAYAxoer1A7SOGsO2G7r?=
 =?us-ascii?Q?pd5Hbf6GWtIivoZKSERLkiaiOHsqIq546J5Eub4xaW3I0XaNfZc9Vfzxaeac?=
 =?us-ascii?Q?qLYRkxqDxEQFQldspRISDWdlPvLihLYaDTTLK0ulsUbLNdeNe7Od24Cvc1w+?=
 =?us-ascii?Q?MeW2tdu2ZU4J30N30cyiAW4srPR4hGRCAXFoBTndr7QMwYUfd7FqF0tOuKsi?=
 =?us-ascii?Q?ohK7JswWwGFEsilzCMqssGRG3LjBCXqrMcLeJgoUJh6W82EVLtFYckfkRUim?=
 =?us-ascii?Q?EZQMW8Rl0MrEtmhRRmpue9SrGfo2qxhx9GbwrSQXr4IG/o2bcyy2oYE1SAyQ?=
 =?us-ascii?Q?/1LkQiQxgz2fCUhcOJ4495MNY86wVUzReBj3bTD8fBH9X/fG1vN0IqcFq5v/?=
 =?us-ascii?Q?KmxflimuMpAQ8BwOqqP1Z5AgULYHyjJCwFwyvEVyp/ajmgAfmhg2jw92KSfo?=
 =?us-ascii?Q?SFSZkWnqJ/4X85J8edU/3SBGdTQcbPrEjskB7VtguAG7J0WTx7YmBWXiBThA?=
 =?us-ascii?Q?YxRF5yJYG+BgNNPAjMRTEyANG7zmeFuF1biHgynAeAQTEdDvdbQCOw+fuSXw?=
 =?us-ascii?Q?1iG+Q+SgrPPpChvIvvyuwzRr5tZfWWZN97BrH6EV46WsqmQfk+ZUYGbd1Vdf?=
 =?us-ascii?Q?nkg3UfU3S6qYVQSoGnLeFumGKNXRH9P4T2LNL1Yto2wW/fHoo16hVhWwDLQu?=
 =?us-ascii?Q?iSaMCC068o7AUstpn3AZP5EmjFaj+9WLWNWl+MqVD35duFypbIZcl0b3w1Aq?=
 =?us-ascii?Q?GLizkhoFTUnFCmL5NzZ1dN/zuP/ZigPrKBsjcj9SgagjKVmF/zWI3ZrNhKKD?=
 =?us-ascii?Q?d0VrGIZZMRumWC0M8Qy+4AnkwjjqPNINILOlWWLZ8TwEke9Q0S2jhWF6zFj3?=
 =?us-ascii?Q?a5eNbTpjPfrAy++sH3r/emRBcCHT5YujTUQVncOl8sWmsPK8Kha1J44J9bE8?=
 =?us-ascii?Q?SD80DhBSXSMJmPe/AcrypCqWHG5hdBuXCOeYTnkKLw4rIANXiEl2LVnV012I?=
 =?us-ascii?Q?hYzsgdQFIC7wBpzBm8+BGB0LoEzjj6Cg+OSbCA00tsuH9lPlBswv4MocT7pX?=
 =?us-ascii?Q?kpEnVUvrw+tk4Dv6ydsOdc8falaGVduI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qQe4vOfq6cOOGj2/ew1A9szd+KYbEDtTLRc0E0wb+cY/wwbN95UpiWpMwHDj?=
 =?us-ascii?Q?itb3RHAOLJ3dYGCCX9kqGXEKXFUcIfDP6FJKDvWSIjdnbE72dP4sl57rfS2/?=
 =?us-ascii?Q?eCuoEH21oLywPlFoQ/ksSO8mTECi7EjpYt6aM4i/XBuAlJHqmI++qpAhb80s?=
 =?us-ascii?Q?jsNewiMiIMEA3QfPvfjg6aHTHhSHMzGWrsJurd1gPnz3GrB0M3FypH1fkapu?=
 =?us-ascii?Q?HCEP0JSKHCkDEVhlolSZgqZrMM15A9qs6w2gGxUqmM9u0p3tl6ed8eWu0GS8?=
 =?us-ascii?Q?0WzDt/wWba+ynVFejSZMH3WFIeh9FN0xFdGfwYh2LLGKCesTP6+PQr8cFCUB?=
 =?us-ascii?Q?ZBAw8YCqBGoIhESGhWvySvhmR5edwFNk3xT0hHuavnweTTOId0vRkAbmBS5i?=
 =?us-ascii?Q?oSmQ546BoXyLtfWGsLvyz4u5iSRAGHl3J2sgkLgBoUXQNw9703jxlO3hCvCA?=
 =?us-ascii?Q?ze6JKGCiUxaNRrJ+z/zHB2Ryd7KmCdFCw6bvJk318so4g1is6ZUGKC1s0/lQ?=
 =?us-ascii?Q?VgqY6EF15EMYd1B2BJYXvv8xk2uo1v5xA/8JvA4H/+6hq0VbGdjn8Rb4TJTV?=
 =?us-ascii?Q?L9aMCZU/Dio33jQZn69lsdAdEeNHrie8FRSy0evENxEZO36+y+GBZANZDMLS?=
 =?us-ascii?Q?XLDyMtwHB9A0u4gUX1A11Og9pkoQjOYSEaSgP6OE9OUS0eCMbuv0X4P4R5fP?=
 =?us-ascii?Q?Kkcru5j+Ang7lpzU2cE5HNXSdI0mZ0DpRFjRuQTNtnssrTk3mbnMtg6TE/eR?=
 =?us-ascii?Q?Y5IMMJ8L7W8f00MQDscXTjR0uV5fwGW5UKxWFeFGMDnRQasKnnuynHPsdJs+?=
 =?us-ascii?Q?wSVIRMErss+zydQ9H8ydQbl9AeaiDSMsh7xgbCYiIv/2h2pfqxuAmLTP8Yyi?=
 =?us-ascii?Q?ahXrWSH9aUDwlytfwcaxvw9RFXCAQmufrFSWfPixHOyUW9iKFYLckzdpB/b1?=
 =?us-ascii?Q?nGR7kVM51KCuDBRpA7ErzzMA8lNPpCGfoeChpkf1tHeDhAd7wkd6Fs+YaSBc?=
 =?us-ascii?Q?dzo83j9t8MWQSKNw1pglg2VZIif0aCVihnI2lrc95Qrk90nTq8AFYed/FdjA?=
 =?us-ascii?Q?0K2BjJJSIGn+LTPnM36Mdr8kXkD1uUlAQpb1XMat7RYFxQjUkF3U+xLzIU6g?=
 =?us-ascii?Q?WSMQG28cntlA6GSJiQyR7YwQD+OjAgIyCKwndiOHIsHOYF/6N8yg6cl/xlZQ?=
 =?us-ascii?Q?EfH2JJaumVs3LQMH6QBAURknGY5pZ9wImrMquaZnjSKNvGFT0ZJoP82sA7eo?=
 =?us-ascii?Q?lPUgDbiH1IEy/uqaDrta/dPyBTFZlGRmmf6lAB+EYDNwOBojbz/WLNocVddr?=
 =?us-ascii?Q?MJ6h/6HbvO4g30Z6siFv+OB06RytpeZljtYRGjVX6LxqWxF22opLXf9q7jvV?=
 =?us-ascii?Q?t7GpZOfySMhKEwyWPiiXg3Mrzkybn8yg0KwXyBehmQoVyA0VM3aYgddSwM4B?=
 =?us-ascii?Q?c70NFAi4QjFJ9D0phwGLt3r2gQ6loLjr4E7V/DMTEzWgwypAb/vH1u5NWY0y?=
 =?us-ascii?Q?KLwhuALp/+olSdpl+UaJyaFmKmea88w8lX3dFDc+iCFMAZU7AxufgVjyrWr/?=
 =?us-ascii?Q?8nV+eDoZrHY/xv8o/nZOB2kr3LwPNETKoG9L86ba?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebc04bc-1f0d-4f20-ddf1-08dd77545ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 10:50:34.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS87pzNxI7WPyS/Sf992TNbGs77zgLtpHL2zV1lh0XO3lAjbcn1nagwh7L39RQ/MfLFLfJNwdFvAfMzAHyQz175AKlhtDr1270qvTBxtQdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Wednesday, April 9, 2025 4:31 AM

>On Mon,  7 Apr 2025 14:51:14 -0700 Tony Nguyen wrote:
>> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>=20
>> Add functions reading inactive versions from the inactive flash
>> bank.
>
>Just to be crystal clear -- could you share the outputs for dev info:
> - before update
> - after update, before reboot/reload
> - after update, after activation (/reboot/reload)
>?

OK so this looks this way:

[osdadmin@os-delivery ~]$ devlink dev info pci/0000:63:00.0
pci/0000:63:00.0:
  driver ixgbe
  serial_number 00-00-00-ff-ff-00-01-00
  versions:
      fixed:
        board.id N43235-000
      running:
        fw.undi 0.12552.1
        fw.bundle_id 0x8000c459
        fw.mgmt.api 1.7.11
        fw.mgmt.build 0x3a458c89
        fw.mgmt.srev 1
        fw.undi.srev 1
        fw.psid.api 1.00
        fw.netlist 0.0.0-0.22.0
        fw.netlist.build 0xe1aaca1d
[osdadmin@os-delivery ~]$
[root@os-delivery lanconf]# devlink dev flash pci/0000:63:00.0 file nvm/fil=
e.bin
Preparing to flash

[...]

[root@os-delivery lanconf]# devlink dev info pci/0000:63:00.0
pci/0000:63:00.0:
  driver ixgbe
  serial_number 00-00-00-ff-ff-00-01-00
  versions:
      fixed:
        board.id N43235-000
      running:
        fw.undi 0.12552.1
        fw.bundle_id 0x8000c459
        fw.mgmt.api 1.7.11
        fw.mgmt.build 0x3a458c89
        fw.mgmt.srev 1
        fw.undi.srev 1
        fw.psid.api 1.00
        fw.netlist 0.0.0-0.22.0
        fw.netlist.build 0xe1aaca1d
      stored:
        fw.mgmt.srev 1
        fw.bundle_id 0x8000d993
        fw.psid.api 1.01
        fw.undi 0.12552.1
        fw.undi.srev 1
[root@os-delivery lanconf]#
[root@os-delivery lanconf]# devlink dev reload pci/0000:63:00.0 action fw_a=
ctivate
reload_actions_performed:
    fw_activate
[root@os-delivery lanconf]# devlink dev info pci/0000:63:00.0
pci/0000:63:00.0:
  driver ixgbe
  serial_number 00-00-00-ff-ff-00-01-00
  versions:
      fixed:
        board.id N43235-000
      running:
        fw.undi 0.12552.1
        fw.bundle_id 0x8000d993
        fw.mgmt.api 1.7.11
        fw.mgmt.build 0xbc86d939
        fw.mgmt.srev 1
        fw.undi.srev 1
        fw.psid.api 1.01
        fw.netlist 0.0.0-0.22.0
        fw.netlist.build 0xe1aaca1d
[root@os-delivery lanconf]#

>
>AFAICT the code is fine but talking about the "inactive versions"
>is not exactly in line with the uAPI expectations.=20
>
>> +static int ixgbe_set_ctx_dev_caps(struct ixgbe_hw *hw,
>> +				  struct ixgbe_info_ctx *ctx,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	int err =3D ixgbe_discover_dev_caps(hw, &ctx->dev_caps);
>> +
>> +	if (err) {
>
>Don't call functions which need error checking as part of variable init.
>
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Unable to discover device capabilities");
>> +		return err;
>> +	}
>> +
>> +	if (ctx->dev_caps.common_cap.nvm_update_pending_orom) {
>> +		err =3D ixgbe_get_inactive_orom_ver(hw, &ctx->pending_orom);
>> +		if (err)
>> +			ctx->dev_caps.common_cap.nvm_update_pending_orom =3D
>> +				false;
>
>This function would benefit from having ctx->dev_caps.common_cap
>stored to a local variable with a shorter name :S

yeah, agree

>
>> +	}
>> +
>> +	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm) {
>> +		err =3D ixgbe_get_inactive_nvm_ver(hw, &ctx->pending_nvm);
>> +		if (err)
>> +			ctx->dev_caps.common_cap.nvm_update_pending_nvm =3D false;
>> +	}
>> +
>> +	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist) {
>> +		err =3D ixgbe_get_inactive_netlist_ver(hw, &ctx->pending_netlist);
>> +		if (err)
>> +			ctx->dev_caps.common_cap.nvm_update_pending_netlist =3D
>> +				false;
>> +	}
>--=20
>pw-bot: cr

