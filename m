Return-Path: <netdev+bounces-302107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wS+YHOggPmq/AAkAu9opvQ
	(envelope-from <netdev+bounces-302107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A3A6CAC0C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TnVPn4Ae;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302107-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302107-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D07D83015161
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE83D34A2;
	Fri, 26 Jun 2026 06:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1D3D25A2
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 06:46:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456369; cv=fail; b=P0S0kTD4boDC6RP0QDg1PIBxzx2N1/AzP/EEf6206xwTqo3eHF9M0SuFfJVRHbd+bKmjczodmoSxbrdR66IVstEdFlE4n4uRhFnpa7uzazmFxJtQ8kVXIlNaEgDOyLiK3/iZxfAUmzWNFO/AneZfhWYKJdSJkr8asP8wipYoHSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456369; c=relaxed/simple;
	bh=9NwwKZ5+iQ0rdYkmMxtYzLRCHjhGdPUSHvMYX/lyK8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WWpsClYE+3EXi1eeoAewRiP2pmFKDFl18LFiC3/RWn2qpNAd14F98mz9m/7Lu8FF7OYs0OxeaEYb8QNBSk6+6XmXazS1ze3H/BimzMIy5qIZCPrp6kLaiWbBvq0MIz0tSpc49gRjeeLV6t1rk11uWSN4hvAqVBar9k2V8hYzykY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnVPn4Ae; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456368; x=1813992368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9NwwKZ5+iQ0rdYkmMxtYzLRCHjhGdPUSHvMYX/lyK8o=;
  b=TnVPn4AeeNqRvJEKDncE5KGpKeFSlvid7nx9csE0pjBaGYh+9ttg2AWh
   NO9X1uYjKmt3ztiJ83qsI98AL/YFcq3T+QcEhCw0i0PEUyEaJHp+DfG2v
   TitDqwyoP7TerqAufGmLQ81UURm6SBZGbG4bbvfxinYPLKwI1a3QX6SEI
   ffTY66kRIi2zkqvS4dzO0EVezGrMyCROUCKKuwFOKrVjWLR9SKSISOHVM
   K9VxlyF9IAD2Mq6kjPc2z/LESHfm4jT4TNj9pMIW24jQwB1uYta4eWHNQ
   nJbxEUXb5abWbUVVe9WjwsAO0r/EaMUBveFCR4xWviw6Hda239QmFZNGQ
   g==;
X-CSE-ConnectionGUID: pqqu98wbTBW2VJjI5ML2eA==
X-CSE-MsgGUID: gzlqQnUwQSyMaeHd/Op5Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83018754"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83018754"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:46:08 -0700
X-CSE-ConnectionGUID: Rpwj19Q5Q4qlhzEqpS0lOA==
X-CSE-MsgGUID: YbToC8bEQJWFPYEeruYxOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="281342972"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:46:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 23:46:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 23:46:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 23:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5WhJuJHoiKDCi/BQiDe9B01AMb6D1jygWAFWIinhwLqrJoX909SpeLmiRBtEb1Y6zOstNeJ43WZNGMaUUFReGiXiEMt+bGuZQdjTN+ip+wrw/bV5HMW6KKYsYX6snyySphM1XXYZS2llol5nFqZzo8b7Wog1XDg+FX+aP4VodYYWdplcQL2KKEwWfSIsfTfxyIYjhvXs0FPkfKVsDarjYOUREBbufR/B9BjsnQeD/biINxN8dMQTYtmvtb/qRDeowFzSL53JfKJuKcHOh8FzSzsjIlaSuaVrJ9uibYiVBkJoSDbWEXxlR1cWLzIHm1F3jFYMwp83r+inrvXULIhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvWSMmmtAwbAjkQ/i+aM7JnuuhKKi38tsCCzTrr4wq0=;
 b=cXMr0uH+SdDUq7fo5dNuqye/RuB7o6Pc4OA/tO7mqtPG1ajqRBDGSDBaGLRWVI07kjY5k/XIdAUJzjoUZLmdijBaXBAtL1ZKjdLj88rrd+rNfIfk6OWnHNWK8wOnLMAuOcJX/OSE3A84O+xk8ntrezJammBYgUBACVB/6ZaBOWJcaDobBh4TVP3M4OCQHpH4xjoEn5ZgJuNffmgTj0yldIZYN1daiPGhnrO6PobJY/cPW/5TRKJO5POnhOXy6ApEpas+NRg1Jm6CwebyniBZMVix8KoBgVoT38e6z5kDupHWVoyc8Uk6EkLdrbDuEkBkVK6RR03CCy61L6U6jrFo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 06:45:59 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:45:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 net 2/3] i40e: fix potential UAF in
 i40e_vsi_setup()'s error path
Thread-Topic: [Intel-wired-lan] [PATCH v4 net 2/3] i40e: fix potential UAF in
 i40e_vsi_setup()'s error path
Thread-Index: AQHdBLVvoqkt70p7X0unbsbLTiAE87ZQZXLQ
Date: Fri, 26 Jun 2026 06:45:59 +0000
Message-ID: <IA3PR11MB8986AF520E64558CB3F25A3DE5EB2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
 <20260625151431.1102838-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20260625151431.1102838-3-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8484:EE_
x-ms-office365-filtering-correlation-id: dc066ed7-c762-40b1-4471-08ded34e94d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: KCbFJ3k5X5Ty7THVzf/G7sNEa9F4levn+61yFoNqsG1fr5aDKsXkwwInD3nN490XvMQ1dgufFy9iryRtEPgLErtGKk35ieuizbisxZ8y+KLvRIS3v/FO4linMnbJ80tMyMeH9wU8YChyhAcy1k8DUJJ0R+y/Clx3+vCj7fks83+q5HDx4hauBFzrhRuV0vKCtPjKnir2CqRlpwr86zpH3PdTxWCc25WFY4PQB5s/r/36VInJTCSrHbZnCsSg6IjzU92e2eu6nG3zADmPr8Kc+KfXcgLarD3aj4KLWKHg9H1Q1qwmBZA9fJmimjuEspnpa3HScqqPkvXkphKJCLeTxR7oSqMI9cN3PwYJTVJACDZ5NLcp/uzumrcpfC1HdnGOz6wjCLh6pGEWeUugfE3xBiZ8pErWpA+HYUOCEVgcokv1W9yuG0dcBiqmuqvwePsfAO8eZelTgxEpII6zEQ3GivCS7IEKOZovtH/KSNzz01Z9Y/vCJj1TwAxMnbQDwZYiJIWsAy7bAVjFgBllgRngDZHruBVBj6hN7XhOz+5YwelTMkYjObjtHPi/xbkOVYPXumXldeQ6pxmTLe/n5dd7UtuROPFPHvrni+/FQfGCs2/lrUg20R+uuQX+Y/TTp4UqpA/aD7LsoCgMK8iyUgq6zUCQwdv3X/RX9YX+A8LlPknX902+boMiIbIJSO6r0s2vLtFy1p1h941y+o0jg4X30TRajIhO0PlgvA0A244Kzgw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zu9Udm9aWbUo6gQSZ5uHq6riQ6rHdIqhgS2q4y6WbbOYWLWOxKzK2T6sDfCV?=
 =?us-ascii?Q?I6ngEd0OHoJz+dLwvYWIU2QN19blCPKOJbYcQFknqrxY+nGumH0evfPdrgbQ?=
 =?us-ascii?Q?tIQTIu78uiVr6c6+5sYs7+oT++wSyph6n9Oukct4e1lBrEBfuEteLABvgPKU?=
 =?us-ascii?Q?Q/zTV6QypyKw1iS/NQrsCGoixUelXD2SMpuxz08OMvHROPBhuDa0VZeo/KBo?=
 =?us-ascii?Q?necwx7UTFNYs33oxwEqkSCSrzGc4lleXQ9GvzkkBW7itJCLaRvDJesE5mTyE?=
 =?us-ascii?Q?qB7gpO8hi63zzWDozG8/rjaHGr5fX1ODMW7kaYRfJAB1gfqk1Q/0kXxXZJYy?=
 =?us-ascii?Q?N1HRKuR++KuDOOzxMADDMAS02i5eDNccCDPXdAKXT5L5q7cYR5naFlfdUemi?=
 =?us-ascii?Q?ysuRGN3fjRNm9GCQOrbB6OZHPbLbI4E9Pn5KqPP/oo5eyI11JQIcGftw1M45?=
 =?us-ascii?Q?KfJjoH5MtB5HAarU8eUR7LPuhOISXWPOcv4HllUPCCKnbXYwrQKCHSxCZdfb?=
 =?us-ascii?Q?/CP//wckjA1+Uh2RsY+FmTMgLDXrjqOkT8hQ168CbTFfS92qLXThei6CRNDL?=
 =?us-ascii?Q?vIBsBTm9oh55xa/hmRimVucB1KGy/ykJvZmIcSR3P0Pm6KeMOn8RA/kNu0Bp?=
 =?us-ascii?Q?35cQjH7arcvW1wEQz/HNuM+MgSQ2SBmFVR+CTA56u2QqUBPNyrOudknx5okj?=
 =?us-ascii?Q?/lJygKGpFpjclIQzB9uiHHY1hzPGcy6AaifMlUms0ezKDk8pUXzsUlSgm5eH?=
 =?us-ascii?Q?sldnNik6OC3NUilXJsbcDkRWoh4unEliPyPxL+be8ulCwgKDFnDcrTlllf3Q?=
 =?us-ascii?Q?k6yWGXy1a6ekgD/I5SZey3z/shx7r8t5AYQjVICZF4kaYr5GHEfduX/svPLQ?=
 =?us-ascii?Q?qVm5x/QCQQn1cZ+uZLc2/eD5vrHUVzBxYPTPsUyxLZSf+haaDKuhxLSQ1N5E?=
 =?us-ascii?Q?SHc/Zjd06aOKrbXplQhBt624Wl/+1CBi9ahmkw4+f7VDq51vMixuz6hC19j4?=
 =?us-ascii?Q?nypJJxlQLGqH1a6ZjxFUC54gnPSPmfPN4h0CTGlaDn5loUIIRXdtufGSzNwm?=
 =?us-ascii?Q?pjag3v04RSuMnPT9tRxaJW15zAK+nzKcAzSdnN6JEZkXJJ9fhkW0fXTcY6cO?=
 =?us-ascii?Q?4i+xAOoVYcTEGqdU4xLksZRdZGcBdNT6KX/XZocVl0UJpvNAaCTr4x2U4WS7?=
 =?us-ascii?Q?5eNnOb8vrIAjWMSJCDsmcsAmc9y52AKzFCoUxmME3ESqmkg2OopSedmAzdQH?=
 =?us-ascii?Q?uczGP6x+O69y7iNQe4wk9WtcSeduJSst/a+LftsTfCaLyF1QNyh751CCwwH3?=
 =?us-ascii?Q?Zkmpq1uGpvFw2lKHHo6qFkJngXq6UFJ8Gg9Ayotk70qMrgDXPD0m8iZfX1T9?=
 =?us-ascii?Q?5Kuk3lwpt7AVZ5meYCGlHpkpDVPVwBN5QJCVcBx8oQBBKS9UA2V7EduwN8hq?=
 =?us-ascii?Q?ne27H7eJgolV1rUZj/w1qICnjy6j7R76Q3P7eEJgna2QURHpaykcU7pfEeJQ?=
 =?us-ascii?Q?z/8akPMuM873o6JAxkG+wTa8KVxiTNeEmjESpf6T+ULBX7C/OHwhb2PnYz/6?=
 =?us-ascii?Q?2uD/IPq60KHUz9BjoEbRwysWSxeWdwh5hKT5PD+XBwhjdHvMtHXCJpADR8Xs?=
 =?us-ascii?Q?3pEhLjZ581+YsbtoxQaIe1OC6VfRZTODb502Tl4/a+U61+kXw9jRP84wmIXE?=
 =?us-ascii?Q?iscXsxodq3jetadI7ukEqHygnxpKAySvKQLO74OJGGHIs805GpI0M8LwChli?=
 =?us-ascii?Q?94kIrCYnsM0QC+2Jc9D1+lWxJAfr6WE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NzWUYcARnncfENYT7pdrWX0Q0Ph9b9wdIpKGV4h4gIdOb2lJdaIXmM6oQbvikzB1xVk1sX4udF9p/AyU3u6YDMHbkmpkHV1iG264MlQP3YzPpvqTyKF10bsrBvUgH+JbW/VW3Zx4xLqo8eb0te1z0gr0ogw4fU32qGVb2lcl4GK3u7iTDs6EI/zZ1G7qV5yGV1SLft7w3HGVJD46gsLlfyqJvwWJ5fS/YVPEOmfj2rP6liK90dtnMEKx5MZnGfuQ5npPRaECH2YJKImw5//X4US/I2c09c9C08WMYTAdeHiaZlVYhep/g8Xz5MiimPVTjXA3I4CA2L1mhZyshDhprQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc066ed7-c762-40b1-4471-08ded34e94d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:45:59.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HFhrdwyRgPmgQUOdrneKvWB5mPNu9GSqvG3zP4c9UXdQzLfis3Jf7uYrpjze1A0IghlfpUTXI1iLiD3O/k3exaqdEGCr0hAyQdDSnyFOiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-302107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,intel.com:from_mime,osuosl.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69A3A6CAC0C



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Maciej Fijalkowski
> Sent: Thursday, June 25, 2026 5:15 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 net 2/3] i40e: fix potential UAF
> in i40e_vsi_setup()'s error path
>=20
> Sashiko pointed out an issue where error path in
> i40e_vsi_reinit_setup() released ring memory but then when freeing
> q_vectors, the rings mapped to q_vectors where touched which implies a
> regular use-after-free bug.
>=20
> Apparently i40e_vsi_setup() has the same problem, so swap the
> allocation and freeing order and fix the 13 year old bug.
>=20
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 471fa7f7b643..4adc7b0fb2f4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14460,14 +14460,14 @@ struct i40e_vsi *i40e_vsi_setup(struct
> i40e_pf *pf, u8 type,
>  		fallthrough;
>  	case I40E_VSI_FDIR:
>  		/* set up vectors and rings if needed */
> -		ret =3D i40e_vsi_setup_vectors(vsi);
> -		if (ret)
> -			goto err_msix;
> -
>  		ret =3D i40e_alloc_rings(vsi);
>  		if (ret)
>  			goto err_rings;
>=20
> +		ret =3D i40e_vsi_setup_vectors(vsi);
> +		if (ret)
> +			goto err_qvec;
> +
>  		/* map all of the rings to the q_vectors */
>  		i40e_vsi_map_rings_to_vectors(vsi);
>=20
> @@ -14487,10 +14487,10 @@ struct i40e_vsi *i40e_vsi_setup(struct
> i40e_pf *pf, u8 type,
>  	return vsi;
>=20
>  err_config:
> +	i40e_vsi_free_q_vectors(vsi);
> +err_qvec:
>  	i40e_vsi_clear_rings(vsi);
>  err_rings:
> -	i40e_vsi_free_q_vectors(vsi);
> -err_msix:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered =3D false;
>  		unregister_netdev(vsi->netdev);
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


