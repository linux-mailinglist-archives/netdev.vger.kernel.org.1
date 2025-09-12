Return-Path: <netdev+bounces-222509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D10B54A68
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622B24659B0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66E2FD7BB;
	Fri, 12 Sep 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGZJdOPO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB722FD7AD;
	Fri, 12 Sep 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674336; cv=fail; b=BRyfMnqw7P44INQ9H7NnPQjsv+MByTCP2lP+z6r5cay+ise2VYfsSq8qeU2TBKMo+WuFOpENSlueSOQa/0PpQq1sLFLdrC+8J3Vro33y17/SwnXMzaU+5qTjyuL6r/a819PoATZ7yy60Kko495gUkIoqh3OJUcrJqp7HUUY2PQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674336; c=relaxed/simple;
	bh=MplcPQDVs/1TGeBSe9PL2oiLg07Tw/JJI5RIiO3DtQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gr+q+ubPBn7cbvXLoCcBZXWXNDqQ+5ij5tuT/XkDoZI9tx4cbi/+ZFf0+iImh/bkdoC5vd2b8+1UdxhLyC9vjCYKI0xcPMrY0ud5xfUead5uiaj98sDl/1zDqVsxI283pmw2o43TGXkBbJrDNi6hqBqtP/PukfkQQVySsePNEAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGZJdOPO; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757674335; x=1789210335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MplcPQDVs/1TGeBSe9PL2oiLg07Tw/JJI5RIiO3DtQA=;
  b=OGZJdOPOpcOZf6oMYyVWmhm4a3NC4ivc5p5U0GqZVCYLpn9FTe8i+4SF
   Q6U7wC+E0ZQbBWyvvDm7y1U4/GdtqMP0UJL3mwM+o6RiTS6o7rWUCuS2x
   +OSgzSjqieG4vOvWUphx7E9/moHWSSi6Alr30xgc+hooMV/kQfg8ElFaO
   /hijFBV2O21oLiTTw463tYnBt6it1ghm/fE3hiUvhEbDilKsVz29uyFNK
   Fq+xZAWHDKZ6Vu1cUM0s66lNg0FX1z0ugCl4z11JqLI7Uvn1jCtjYC/S6
   bM3Kfm3xTFOeiGjtx/vQ/jEVaQI6Kkk5HqwNZaCC+Ptx47qwpyj80TAca
   A==;
X-CSE-ConnectionGUID: aHj01XmdS0yPTzl19xxpew==
X-CSE-MsgGUID: hdgbphEvQqm3inGWJfPlCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82605561"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82605561"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 03:52:14 -0700
X-CSE-ConnectionGUID: y1Yu1k/VTcKJ27CxqbQPnA==
X-CSE-MsgGUID: AsARh3JWSQSCT9jtC/2BiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="177974637"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 03:52:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 03:52:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 03:52:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 03:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goqPPDvp5kfr/exQQEPP8Ugz6hroyHJnkcTwHO36J4s3bFk2wEvCr0nipxVLEDbgmvKijAVTaKu83c9qSnRuViAptgVCMQMlsSLdAzITvUpiWoMrN1FjvjbhtPfAou1szY/cXrWMbXErWlJWhm1pe3/lQnY2NuXwyEUYAj+WHKaRSLyi2+7dqUYUJSNOz9i8bO0kOmtSrWgfAF4CJqZkSl1VpBRMFtBKtXIhjruLKjO8gNbivtPa0lcBu91yLmV7bzMhS+eU4ush/kpoxcv0nT5u+l2rDrSWzIn0X4qRbV6HHKbg4+zxJbt/ekxu0Oimar2z1E414qbhIakjW4kchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yleKgN/YVIKR2QtGWii8rFUzD39AJXFYNSWQrYzUU50=;
 b=Hc4YmNxwEu1zFH/hVf6fxuG069naG/PvMM4APrXkebjk0WZH3KFZx8orkdu9Tz+VyLy+H3nWTLX9VKXCPr2hUkhcHPPVNOBDgrL11grELVcjCdcHxsWjDhZKDuWQVzD9F+7GXwpgHOVBjet4R/dW3hBq8PBYurjT5v3wwPS6Sk8DP64uf5Ei3uNin7IF0Y+mGBUiltlEoRZyiAQUd2sJOsQsY8J3MFfFQEpEmzp9ds3hETiEEsEmPnl388HnB5EWgGn10z6BIMDxBqH5yXyMmLN/9z8rHCAORZKELKmAMyV10o1D13tE8HNU4lrhyQnNk7fvJzPiE412zSIh8koLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by LV8PR11MB8697.namprd11.prod.outlook.com (2603:10b6:408:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:52:01 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:51:58 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko
	<jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] dpll: fix clock quality level reporting
Thread-Topic: [PATCH net] dpll: fix clock quality level reporting
Thread-Index: AQHcI8hXluzPttQOwEySpAsBeK4FD7SPXlUA
Date: Fri, 12 Sep 2025 10:51:58 +0000
Message-ID: <SJ2PR11MB8452F78722D682E12C2F4C239B08A@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250912093331.862333-1-ivecera@redhat.com>
In-Reply-To: <20250912093331.862333-1-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|LV8PR11MB8697:EE_
x-ms-office365-filtering-correlation-id: 7cf7edb4-4fa1-469e-bfea-08ddf1ea659e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?heUoFgDpFOQ4OpLQcCqiiV43gPKQaqN2/bmjcSIeaSay3HZGcgXFLcks1pR8?=
 =?us-ascii?Q?F+t88VTEyC9BHqG21xYcDvgpc002LeXMQ6Rzd14QTwrA5UJZezNKrS24TS3A?=
 =?us-ascii?Q?+D/OX+LH9o+iCZUSDWRlDbwDgAGh0WiNx3lUbjNU42OwhC6SedZtLQiRqsfK?=
 =?us-ascii?Q?R2I3TDttjrhobhHcb/hBFTAcfBPxtEmZl1ou6q7h4VXA6Zb0cVarSFe9KzZ2?=
 =?us-ascii?Q?eDec2dKNgwsZdFMrC6kQ9+LPF3RujMfSkAjbiTyw7WVCj7QdZXmUtPgAyqBA?=
 =?us-ascii?Q?BZ/Se9/bFFsgRR+XL0I5iByFKvz6tfiLtQJDFI+QpM3olONnFCtMqBsD6Ftg?=
 =?us-ascii?Q?2EEo1ukLLms7XLJRCYdiow7KVTiZNxu3jJ4bFBIBMWgQ5RV8/MSTdg9F/Uu/?=
 =?us-ascii?Q?xE6xGdzjOY/y/ZDmmIVUJ3b8uTontfJXX8G/PVG8n0WizHH3qFVHvZZNZ/Lx?=
 =?us-ascii?Q?Fb5VUAwzkUHEsJh8wo9/mfukmBsY/zNDcCM7F3KtiwDUG5ZxUyZRKsJanf6o?=
 =?us-ascii?Q?3JuCI3aypGMRl7xBXLzskywwLZ88mixIo8EDOTMRK8r+862i9O7pq+X80j8+?=
 =?us-ascii?Q?goTbrqS1Sc6QmlA3XWG5FoYXQuZX4YGMKDol2n182Fu5aAAbS4zbDkDlUjTd?=
 =?us-ascii?Q?8jMgeJc109692P9mg4FexIE+2uualaTPfhLUlua1OxOoul7hu8tKFTmalsS9?=
 =?us-ascii?Q?pwKPvDaBe18yqoqmBjBWZfhv3xLcmuEZmSMXVcmqYeySBSFM7Kpp37OjoDXh?=
 =?us-ascii?Q?ud4c2mJDIvfNGx+nwlXoxRc71i6pMdzlrccImuvq1W8XmkhZCYU3AFWUDX8n?=
 =?us-ascii?Q?fDykotnFZrVdqEjR55TqGDu5Ihj8VwZiXdB6Ne7SelGEYxmqWnIY1EhqwwzD?=
 =?us-ascii?Q?gR9+HofHJ4fyPITkYaUlE02H5rGpqVJVZOBYY6qWtBETpmVKyi/gsQ0znzVb?=
 =?us-ascii?Q?OrjzvihnkqnnOMVngWGDi3wll7UKokUFceoHiPGj/YZo6kjo3DKUFH0l60+/?=
 =?us-ascii?Q?7kN1EqGpaMUVrEz9VPbbgq15uobd/UGoy8cTk0KvZ7TxwJZt7AhZLuOcE0yq?=
 =?us-ascii?Q?INhjlqGh71azBFGoIYussWZZcUkE9pRNPzTSniwc2dCYgY4sbVihBiRmk+M7?=
 =?us-ascii?Q?jmHCcPsNjJavURnNibfFTvR1TDDwQSJ9yr42xf9cS94qsboR29XTKKlZCzha?=
 =?us-ascii?Q?u17H9iDHEUBODbQ3br+ZYnqjD8un7RNHLaAgima4+P9wu3JR+lYXPeQ3JbRb?=
 =?us-ascii?Q?ybBLoaQ98mELVzBAaC9sjAX6uIbOlOkd1QrJL4bsdylaoxgjthOKLHNB9xbz?=
 =?us-ascii?Q?9/zyjByyXvY6LDGIJp6Cg9DkNuHn5gk6+FC5VVQHxEdZJ4XzILw+7o36qa3e?=
 =?us-ascii?Q?vnqNkDrUsUrW4LYVLFADkPbKTGHwVrSiCOT9bAG13GZH6eYO+ZMcT0nIB/o5?=
 =?us-ascii?Q?Xnmo8lcGbk5rdkRyZ7lq2Gc75yXyFnWj69eg9/W8723C41Z8r1MRjln+wc2L?=
 =?us-ascii?Q?vybLD3ckEu5qP7c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XO/Pu0facErLRydjeEABSoprmXIM7Tu/8pQroRppDBSRqGXUeqAj0tgmxGYb?=
 =?us-ascii?Q?IESavRHcRbB66sMnE1g0vtnNCKoXDQsbfdLSr9/3fIB1OjVtmX/+vJATcpbj?=
 =?us-ascii?Q?hc8R8lqS9x0ci4shjaUUmh1CjYHNTr1T38zRgu7NAGbFA8hso9ZhN+K7+3Jq?=
 =?us-ascii?Q?sckpdvzGEMQX66Yy6jq85Fl1ko/iOO6y5FphrwxqFCOH8svvoogLwuhU3KN+?=
 =?us-ascii?Q?Dx5uLrV+KS3GziTlO/GXRqo13zhYAFnpPsQXvvcuWXM8oMIIUAp91FPgGaHm?=
 =?us-ascii?Q?+wrF4XMsynCQviArHI4Jyactos6B+HzbnIRNQ6/8xyB1z612vl/yN/gHk3U6?=
 =?us-ascii?Q?5m74JSEfQyP+ZCVl4Y6c7opCtn/qpqGpIdU5p3I0TkKFqbRM2Ky6fv9cUNXv?=
 =?us-ascii?Q?sjCbCH1O/j7rMOM666VT3yJ7mcDjMelrQLZMv7rbDRjiiHXINHxQfN+4f71c?=
 =?us-ascii?Q?sqbIauT9RXHpi9mIlez3SgU2dPZo8f1hSAgPppBGpvd746kxff5ZkeI4YThR?=
 =?us-ascii?Q?qbXZCdeFffsnUY7OqGeienjP7FbUD+qYyOQnmbYU3wkF/OPZRgpUcwJ6NC47?=
 =?us-ascii?Q?1ZrrCfEAW3ECS96cOHSzms1wBkBKc5PaftKuUkrOfdvBapuN+ktaN3thzRRT?=
 =?us-ascii?Q?aoqpGsyrM9MYC2qYG4O4+/dpIKP8Qo77JFL6CJFBgxCk8ZKipwaYyTiwJvF7?=
 =?us-ascii?Q?CGsoGszaGW/bbiqi/wAGXmezMJszEgpDnxXJQQqE5F9WYcfQWAN68OUMHM6B?=
 =?us-ascii?Q?dmimTcyCoNGKc+r4Jz52P6rB4kOJSIetFpCcbfhcTUerXAUiHHs85l9xcaUJ?=
 =?us-ascii?Q?waRCZU2kBUvblOdM1wxuznKetuLnN3sNKnQ4VdDTzQZq0R7X0w4LxQTx/HaI?=
 =?us-ascii?Q?pzTc//TU1QQLi+68tX/+xVJrNzRvN4kuVpeMKWv1tuSWg1AA9mGWQWvXSKuz?=
 =?us-ascii?Q?QQwtRqkPGA8I7JecHWZTWTh6uU042L6cu1yiJXIp5Jsr08DuOQ8UEvoYpYwF?=
 =?us-ascii?Q?uQQ7TqzWx+8gJS4Qm2nK7fj3B4Ai1e7RbCx4NCuts8JpXbFu5I7emD7EYMIA?=
 =?us-ascii?Q?ctE+MQsoHVm6PMFgeMunV3rL/xytpVY3ykzQR4rfwLe5tcZNK4QKHwWh/KsB?=
 =?us-ascii?Q?jcf2rckk2+L3qCqNCyHn3kgnf6GPX3KFHJbypug2ROacBvlPkWzKxdOF7GRh?=
 =?us-ascii?Q?zMMwWSRi86dBljuWh8fBPnAywRezp4T6/yYgP5WQqudBflSPpAtPu2eM/V4H?=
 =?us-ascii?Q?XYJdX/rmBDrkps4IlvpBxJop+ux7UEWNUi4h89BLEK/8LMudMTnbLYleJ2Xz?=
 =?us-ascii?Q?ESORUw0PszFiM3eA811aNlG3TBEdoefEvdltxv7ZDxl8t6p+6K4eemK8D3A8?=
 =?us-ascii?Q?EWt3Bma0V8aknUuQtXQzlQvM3IORc+DDgMqMzESo9L+th1ZBw2Gr/DjvDGA1?=
 =?us-ascii?Q?//40urA9RIH11mrfLSc9xYrdy24Jto5CxO6AENtUkHzhep5yUed4ol0EdNv+?=
 =?us-ascii?Q?s6VGqaF7b0WMB9tUZEsNNzV2gHwUfmgiLrlVjAbuBLgpe+6bbnABOd2UojfS?=
 =?us-ascii?Q?31H4STrREuVpBTcMZzSNwAXnidoia4Tz5FVrp9gnggqWwFvqH1YDVOGEIF86?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf7edb4-4fa1-469e-bfea-08ddf1ea659e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 10:51:58.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6dkvEyydjxeHE7XNfp01rumYeyciMkpuCY64vFy/FgmbeUG7BRhmgEpgGsCKH6GCkeg5F3cy6uKh/kSOtWdYnoK08IjNzSxxHYdoGWgPzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8697
X-OriginatorOrg: intel.com

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Friday, September 12, 2025 11:34 AM
>To: netdev@vger.kernel.org
>Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>; Kubalewski, Arkadiusz
><arkadiusz.kubalewski@intel.com>; Jiri Pirko <jiri@resnulli.us>; Jakub
>Kicinski <kuba@kernel.org>; open list <linux-kernel@vger.kernel.org>
>Subject: [PATCH net] dpll: fix clock quality level reporting
>
>The DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC is not reported via netlink due
>to bug in dpll_msg_add_clock_quality_level(). The usage of
>DPLL_CLOCK_QUALITY_LEVEL_MAX for both DECLARE_BITMAP() and
>for_each_set_bit() is not correct because these macros requires bitmap siz=
e
>and not the highest valid bit in the bitmap.
>
>Use correct bitmap size to fix this issue.
>
>Fixes: a1afb959add1 ("dpll: add clock quality level attribute and op")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

LGTM,
Thanks!

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>---
> drivers/dpll/dpll_netlink.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 036f21cac0a9..0a852011653c 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -211,8 +211,8 @@ static int
> dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device
>*dpll,
> 				 struct netlink_ext_ack *extack)
> {
>+	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1) =3D { 0 };
> 	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>-	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) =3D { 0 };
> 	enum dpll_clock_quality_level ql;
> 	int ret;
>
>@@ -221,7 +221,7 @@ dpll_msg_add_clock_quality_level(struct sk_buff *msg,
>struct dpll_device *dpll,
> 	ret =3D ops->clock_quality_level_get(dpll, dpll_priv(dpll), qls,
>extack);
> 	if (ret)
> 		return ret;
>-	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX)
>+	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1)
> 		if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
> 			return -EMSGSIZE;
>
>--
>2.49.1


