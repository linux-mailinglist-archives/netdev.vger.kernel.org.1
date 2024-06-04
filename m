Return-Path: <netdev+bounces-100456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63628FAB45
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE491F233CF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896713DDC2;
	Tue,  4 Jun 2024 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvrDpKkD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563141EB27
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483774; cv=fail; b=aFS7WRgbS0IViZ4Xst75/YFDbnQXzDECE1RJ9rRG2Ek+SGt/4l2VZze6eirDbv0XoslyLFCUAvIo0qb+zfGhb50f6/oie+O0erhk7SraJcbUZTwmGxrhHfotzUI4yZlOo1GmI+2649icOnTSVIVp83th3o7NuBUYGd3DcnzZ7M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483774; c=relaxed/simple;
	bh=8KmEEHu+g0gEh2c5E9IWq9D0njTRY16FSM6gEZG3akU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CuSB4ITMlQJymaNnMF4BpLDZhz9ZxayCKxU2OohKdD2QIG1SFvs32JlIgJrbWpIT0QFQ0ErSZLI+jAmv3LSxpi9hKOnjSE6wz7oD+RSb2PzUGt0qvL90xVdn0rDPqZ/b6eSTvl33UAawcw1qvizrfkP1dfvZtiC1RlEQHjwS/9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvrDpKkD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717483772; x=1749019772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8KmEEHu+g0gEh2c5E9IWq9D0njTRY16FSM6gEZG3akU=;
  b=cvrDpKkDcxuRU1E1lVjhP4pFnVhBa2/sAz4uubEkUzXQMsagvQQAWcMr
   WC4jgiR2TYLqx91kCcy1fDhr7uDWWoRojk6/tR5LGHEPVzGHtZU/w8Riv
   GblczKNAmOTRDM2HglBgUL5w5D3wRTKHkN5VJH17Raa55gP4XnUUl9Xw+
   tbZM3Z1Q+FobgHKYi0Uwh6KZaPvIxftLgW+L+d7UjerzL9xMaY/4O2qHs
   Y+bvYJ5wxdZZktsgD3asnXkAzvKhv2vqVHJZD6TYjac4eNODKO5hYCzuv
   i+mB1L44B/1ZNRdyOONhS3P4s8BH3GjPVxMkSDjjhkn8wh+5zfFa6XN2q
   Q==;
X-CSE-ConnectionGUID: a8v/QtegRkGNq6l6iSBlMA==
X-CSE-MsgGUID: SGunevBNSqOdWvj8Dr167g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13813649"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13813649"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 23:49:31 -0700
X-CSE-ConnectionGUID: Y1ZoKwYIRK2teHvuxP7ksg==
X-CSE-MsgGUID: f/u6T2JRQL6DwQig8t4bJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37725693"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 23:49:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 23:49:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 23:49:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 23:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUru8JXVT/5md9DhNBuG8HrHpVlvznKB0Wm/uhDjcoSWIuRRx7bUM0NMOyq6B/X+cd3fSKhRHxbFmx4dJghr5Zd2LZz6oUfANQ0LvgMBmFWcL8UwhWfGLbrq1RCGTXTSEzx2FEEUnJeX2c/fzD1KIqZ1uxzg534nsOeQUl6o4Snn6Hbw6eVLAsoWKmhMDwGvZFuT7yNINcSdawHnLqzkyag0ysWPYL5tnV0xqxkN1eoDOUutMXQEj2CbOH5aqJq43g4VQCYW0FKdISovPuAkJMmv6GsRJ/7Vx+Rb4MlW5hEMMs5t4P+YfooN23N545jmVtKV8V5fomPfwDxqzW7AvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KmEEHu+g0gEh2c5E9IWq9D0njTRY16FSM6gEZG3akU=;
 b=JnBfsLfMR9SQL1uVKZKterknfRLC0/OU6ynkssEka6QOm7ooUvP8wBPP3HjKtNJgy2Iag54A6UrAzDUWHUUXRHIS6maeRQ4V5A/NNjJRRdMMkz9C5rhK6B8/DNk365x1ZnmGB1oubSzZA0rp8dsfJ8UMPuWQzZhyOdBuW1N2voOF9nL9xVZ606tzKH8pfiiM/7Hb5zP02LKvsSIIF+vbHG9i2jJ+8+lKJFwE6xfjOONP27J06s0np77whUAbn/pEOXyXe/n7Zb9gl/2k0Sh0Jv1xys4Km7Sq0WFPa8XT1cuzdIXnNXNbis12QIuyBM6oGSjDwJH3hjQiyoVrul5JoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8297.namprd11.prod.outlook.com (2603:10b6:a03:539::8)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 06:49:07 +0000
Received: from SJ2PR11MB8297.namprd11.prod.outlook.com
 ([fe80::f3af:9f9e:33fd:8b22]) by SJ2PR11MB8297.namprd11.prod.outlook.com
 ([fe80::f3af:9f9e:33fd:8b22%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 06:49:07 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>, "Nagaraju, Shwetha"
	<shwetha.nagaraju@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-net 3/8] ice: replace
 synchronize_rcu with synchronize_net
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-net 3/8] ice: replace
 synchronize_rcu with synchronize_net
Thread-Index: AQHasbrCIh4iIi+1RUeVFj7sWcoqvbG3MubA
Date: Tue, 4 Jun 2024 06:49:07 +0000
Message-ID: <SJ2PR11MB829724229AC4118D388E3F63EAF82@SJ2PR11MB8297.namprd11.prod.outlook.com>
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
 <20240529112337.3639084-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20240529112337.3639084-4-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8297:EE_|IA1PR11MB6244:EE_
x-ms-office365-filtering-correlation-id: c18c5214-11d4-4bf1-b1c6-08dc84626e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?K0F0+9nubC7fhU1r6grD+WxgZ8U4Y+3N1OutEBADvRBZzTTufO31bU/Ku6eM?=
 =?us-ascii?Q?iwyUG2XhIuaeM1bdvDXU3DLyfqNE/thfv3J2UAlkF38pIJQu26HWS2mFtHPM?=
 =?us-ascii?Q?QKD0kDVys7MrtzoxvVMgDx13raet86y1wjQN0yDYZp0+0UiN4/S+Ek1sUvgG?=
 =?us-ascii?Q?AXZyNuE8qStU4Isd008mSjvOt6MIGhdxNoGFP084KlxWTMCmCB3nxqKbNwns?=
 =?us-ascii?Q?zxxGu2NTtdi6WIVWodsruZDhtoNHcao3nRTNI/jKRE2hxizS6oXduJBeSd7C?=
 =?us-ascii?Q?gjfsPipsTU2txr6BXBwyG5SEcB0WvuYcsPdWI6ZEjKj19n+LZ4aNqPLmUsxU?=
 =?us-ascii?Q?oYlCGUswibfVOf+1Orqf3vQhJ0SdLPV6XC9t3bJlz6Z9G5DH8UmGqFh2gld5?=
 =?us-ascii?Q?7vDQIkF3Myd8uvObfPC5HaRh+iPL5itjlibhlDGjw+SHgBXMZSy2T6lcD/Np?=
 =?us-ascii?Q?hPWE7N/g7xOZst3uxNMVRm/ez9pMJfWawZoLnNQJ9mXerHDeiJCmq+Lfyvfa?=
 =?us-ascii?Q?uBf2/hfIbUwdWUfYGoHBRb957hAVBEAUrTaVrPHsTsSXAJATzv/1s/6WTQDh?=
 =?us-ascii?Q?Yrf0P0UkaFyJmaAs41fVxlU0RPDr0dwFllLg/+dH0FHzEYQAcRhAennRFG1m?=
 =?us-ascii?Q?vdu/W+KHGHABkS8OXBKJ4VtGk8OJukL5BuVPPfzm/UXM/+PwjCXE4tAV/wf8?=
 =?us-ascii?Q?Gv9eCpZkQz6nW9yTy1UFu12oanEHUmtwL46ORCiuiA/V10YHQyGWHvPfcz1n?=
 =?us-ascii?Q?4zDXTKx8JGa/kxwgqqiVeuuiA8AfwOFM37vhMdwW/KKwg2uKbM0yJyNYJzLe?=
 =?us-ascii?Q?SiLxy9yFKrPRu/dGagO50zl72rTWwcCmP8zzcMpqT4S+7hKb/LwwNSs36Fpp?=
 =?us-ascii?Q?NN8NrTfxvO3nUs2tvj1SMM5LWG2XQTAwBNSbml/QMF/ws84KyZb39p9P9K19?=
 =?us-ascii?Q?RfnYh5ncUmeJ7nyYwTem8e7C5wpagaQypUDgXdJ512PubxLQ1j4fnKoD0ghk?=
 =?us-ascii?Q?ziQee2SVDtYV3TaqI1UfoqcWxKP8IDjN9mAZR+B9QLKpXcAUfPvoNeST9tP6?=
 =?us-ascii?Q?L/fn3SRjt76DyH7da4j3YKcMuYF8bTzyZRecqUYLhAfHgDCZqFLwG6Y06Vw2?=
 =?us-ascii?Q?48/kXKZGk/QeW7rKxc+q88LhNKIhsJ3DYbkbl7t5ST3DcIzbgPR9PhK7Auaj?=
 =?us-ascii?Q?VIwPJYYGhGx0Uig+mjUXFGzSAVVMQrEsBbgG/H9+aUjACcTeMQEv8eeFEQqx?=
 =?us-ascii?Q?x+77HTLPEX9bWujaoz5BtQOfmeX1lROeYQ96vHWXKOsleOcqVGC8PrZIFa05?=
 =?us-ascii?Q?mALbP4Byus0AYtr1JuAnjgI73QsNIOQNXo2MHpOqQUv1Yw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pHac8/65H/6ypj9C13moj8VCqEEit3C/jEPaZN6mg9U/LPoSHeyLPmSsIL/F?=
 =?us-ascii?Q?cT2/w2IwVKV5aSUIhK609qBIC1Wlqo+ygTW7mrCW60RAm6XSYU/lyC5o2qih?=
 =?us-ascii?Q?iioEA0fXFHj3/tzrgL/9w40yFY1jTDJBA80rXCobshzGC00sGQ/opEezrxKV?=
 =?us-ascii?Q?tObuEUsm/4gkjmbYyMus1rFZDIsuewgQfxcTAFcb3EIZA4OpxTZNSRT69399?=
 =?us-ascii?Q?suDGUx03ZSNUSl1gTD//aH8ljLo4eENH0UP5+RUbHzBkdO3D9+40GLaOzH/k?=
 =?us-ascii?Q?n2WGiiTBa16GAJ+G3I6NKX0Xo+rdsANocXRt4pzzF1RnFab4vK7g4kA/b9Ph?=
 =?us-ascii?Q?ZRPfh1Hem01YDWC9ZKkcZph+xLHD3/mlgYiFWkZASncJZYKHONXs9qJ0BN2V?=
 =?us-ascii?Q?44m8GcPVNk0Egj5dGaGkBIYfj3Ib2AJ5sx8CVNLdBsbM+nOm2tRhYL/DLcFm?=
 =?us-ascii?Q?yoIIOSdKeFFaTVwH5f6ZFw0MUSAxwixYx6SgxSGcNvHt42/ooIz9s1w1Nnd4?=
 =?us-ascii?Q?eLGNWYzBVSSbD4QkUYnWENG5BukUW+VAN2URKQUxxSXraLVGFHfh16KgiNKe?=
 =?us-ascii?Q?UqkiIRI0rP3yL7g6/Q/8YNnzAYTfpvHLp/wDBfankHx3dCl870iaFr4P0VU9?=
 =?us-ascii?Q?XN/DR76grRZdUtNKrEaa1ORNvdafvoDT5yJfMru4YxxPGdi0rcIlKaXXYzhX?=
 =?us-ascii?Q?sVR+ZbXL8jT0bnAC3QUVmKpLCPdkAc5AijQJSDZROIggd6WrTOxZfzk4H3dK?=
 =?us-ascii?Q?tGPLRbeCP8d6EKlOzeTbOvG+quzIMHt00SzkyhqAxuN2QvHabAOT7Tr3P/tY?=
 =?us-ascii?Q?/Q5a0lRTFpI2j3oUNJt4larYOp3ev/TbrmGjtGOufvWRNFkP3WLx2nPXvFIE?=
 =?us-ascii?Q?9EH/sXH6iPQ3DtW2kiMtrTaPy8YaKaxa7G514G+FSDF26UQdrTvVVE1OePlC?=
 =?us-ascii?Q?h5cFDJBH2SLWshOArv/LsLvII1z3RdSjn4To/cdBApRpO2JKWyzBh78k7fFW?=
 =?us-ascii?Q?dvizB/4iZJTPnS2Ha+19S8QrNMLDId6LuBFK7PbGUoeNStV9+61Xd3M8sdZ6?=
 =?us-ascii?Q?Xyp4SUT9+XBB1kiPLYDoVJXT25/nveYrG7PSmCfNJnTK+Fhi+6GOIsL8X/Gv?=
 =?us-ascii?Q?T1+FqJAZO9XTSMzweC/TdM8ed6p2W1x3l6chiedt8+6nBh4+XlCCzjcntH59?=
 =?us-ascii?Q?AqRYOzIu3PPEgXYv54YsXvPrEOBp+2Iwrhz7atOMXzqWyRc4DBfFBelTpL9U?=
 =?us-ascii?Q?6yPtNDNU1Uq9Xz1vMkxw9SFGQRpJsw22KlsjeL0prHZ/c7Vifkxwo0BR16Im?=
 =?us-ascii?Q?D7xOegld1w9GHUnpLaT4AqQTX2tmmrzlX+wCWmOzAwITObb53Kj6wuZCg7U+?=
 =?us-ascii?Q?4Cu8LRzYrultc7bEf/ypn3pXRQhZu8OdNwaLe4esb1eHiV8RqCjvonJgh5W/?=
 =?us-ascii?Q?5BW6pNZEIkGGjBLmq/RmyTeI1ZHNmFp2vbxlZM2iy4Jznm+gry+GctMVuuTe?=
 =?us-ascii?Q?Jmmw/Ot0IpWaetRjW2v6J64M6uiEl3W0CHt581zaDfyH5wy7IfrN2PgAuEBD?=
 =?us-ascii?Q?agiYcxDKUT6Rqe4xqkhQcKv//3ZsJqmZ3MOoeYrT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c5214-11d4-4bf1-b1c6-08dc84626e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 06:49:07.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VV0VZBo9Y4gxHYK27L9a6ImmPIoyxa6altQ0dmlvKWMQuKtXOlfGPpyxLQ0a308J1Amduq+1JM9Z85WBsXHMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Wednesday, May 29, 2024 4:54 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Zaremba, Larysa
><larysa.zaremba@intel.com>; netdev@vger.kernel.org; Kubiak, Michal
><michal.kubiak@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Karlsson, Magnus
><magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH v2 iwl-net 3/8] ice: replace synchronize=
_rcu
>with synchronize_net
>
>Given that ice_qp_dis() is called under rtnl_lock, synchronize_net() can b=
e called
>instead of synchronize_rcu() so that XDP rings can finish its job in a fas=
ter way.
>Also let us do this as earlier in XSK queue disable flow.
>
>Additionally, turn off regular Tx queue before disabling irqs and NAPI.
>
>Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


