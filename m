Return-Path: <netdev+bounces-294161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PLHzCBLEHmp/UwAAu9opvQ
	(envelope-from <netdev+bounces-294161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4562DBA0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:52:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=k1d16+LB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294161-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A788B302D5F1
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4D3D7D60;
	Tue,  2 Jun 2026 11:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2313D7D8F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:22:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399351; cv=fail; b=cZ89NfH1OmcYMhzVMJZpn+pqcKRghAbc94SPhibhsCPDVa3foTbh835fSPmPr0rneaLQybo5xJe+pkjg7qHxizsT6vV83wG9trkiNBXiOK0PcSrY5R1eT+Jluq0QMWEuhlM7/8i2S7MM7Jg5MDxpeq0CtyIC2oEICbTMOZH10qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399351; c=relaxed/simple;
	bh=SexDRdMyqxmv5+3OuFXdfkxU+opjHPQejBYFIvx5yoQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqIaTeYKK7mplwY7ES3hqf0iKR1Lu4W8wOHN3tpiwnwlFO/bx5jfjPGs6ZSRRAQE04waEqQhIMZXL42rzRh3N+2iy/7fuKIPM5fHdsJ44qtg34klD5cVTE0Z6tGZifpGADG8X19yxzxVEi0WKfTeI7E2UP8+31Qx0w79S8fUNyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1d16+LB; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780399349; x=1811935349;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SexDRdMyqxmv5+3OuFXdfkxU+opjHPQejBYFIvx5yoQ=;
  b=k1d16+LBhxw6GqmxglILLAUFTLIcSfzZ6OCu16c//X7YZfWQbzfGhvPk
   ehC167YQlpirhRjGvVbp2QO7ZmHDfkCuh/aYnCoAULZPuHJYr2bgPqcXZ
   pM/u+yhxo009TsjxSnazau9OXLOlZ7k7NJaLTmitqpWQOk9YdAqQ6Zkh9
   gmpTJyFvDpUq0jJcSe+Tb7NNy4wZS4weRdeNihA4TD6QOLmTURD6+Jl2I
   H77/wLh134K3OzRH36fvq5llFuwp1qDifT1L/viJWAPhHaID7oUMWkFHo
   tRIyeK7Y6EBHIe8gLL6PLrV3ahGwc8gpzLXNgvPMGPAMeFmyR/iRdNtfA
   w==;
X-CSE-ConnectionGUID: e/IdVKzfQgO9KDl0nHV23g==
X-CSE-MsgGUID: A3V4w1zuQYOGcppKefYymw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="92292473"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="92292473"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:22:28 -0700
X-CSE-ConnectionGUID: RuRTxPplTMOIK0CxggpC+g==
X-CSE-MsgGUID: za5SbgMiTSiyLNUiydq9Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241383062"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:22:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:22:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 04:22:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R87TXgOea+8ojRAqjoRwb3aFFC6v8eRq0oszvacBkufWvcDqlhMs0mHDZj2WovxmGHJS8LwKj2YTXwFG78gNW6mk11gH6sT4NVI8PH/dN9LFY6ul9+9FCuI9GYE0+ar4dxNJAqwVZ6bERBHzGiVVaO4VqRU6//XWY7gZ0iLobYHrJ8r4YAwRKW0Aw1x9+45+6dT1k2NEf+9FUD6obDwILa1AERzyxu6DE4Y/sFdvyqWbSVAI3bKLjHYOp8A5Sc2VMsylAQOPLJW/1xS6OfuVwiC1FQ8Geq1SfDRQF2zE4a0eMr+9fl9hybrn3aGRuJRHsaqRF+B7/0f90fS1OkFEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SexDRdMyqxmv5+3OuFXdfkxU+opjHPQejBYFIvx5yoQ=;
 b=FQMGwo3sSVjZz1WYGWPhbWUCbX7htCNkwmfpmooKRhGmmj88RFagJVFHreNbbp4wV8ITAMe/4wXe7jV751500qKzt55+qzu4niYTTh8XbKUli3N+Jt4yHsyit75JEZUg2PfM+VBm+4gwDJEYqTauxDWGbfcUtVDcx6eF3rkU9aSTtY3nyJdjG83rmml+xkZEQeeBuxB1G6D97VFzPVCGrCYQ39RUBkNqMW+5EoX7JBlBUdlSvlRCWztux1wfhaNOQcSNNHG04SU6HiqqE6A9JHOJe/nVy0e4DtsWIEUqC5CU4nX6AoMv1Z6yePm+MNbv3HW2haHSf9kvV6X/Gz0Jpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DM3PPFE8B1F622C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 11:22:21 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 11:22:21 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "mensi@mensi.ch"
	<mensi@mensi.ch>
Subject: RE: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly handle
 ethernet-phy-package
Thread-Topic: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly
 handle ethernet-phy-package
Thread-Index: AQHc8lEO93uKzUJnU0Sx9zGd9jsgNLYrAGowgAAOp4CAAA74QA==
Date: Tue, 2 Jun 2026 11:22:21 +0000
Message-ID: <PH0PR11MB5902F0AF66BDC5DD80DA1E59F0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-3-markus.stockhausen@gmx.de>
 <PH0PR11MB59021E62692FC52557016A9DF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
 <012f01dcf279$db256d60$91704820$@gmx.de>
In-Reply-To: <012f01dcf279$db256d60$91704820$@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DM3PPFE8B1F622C:EE_
x-ms-office365-filtering-correlation-id: d0d0bfd9-d088-403b-282b-08dec09936a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: OW2kHiNUmnl0Zur3UT3nDTZqHHt7xme/77ZEzqBMU0cqmkhdPXhuIa5su2hOrz9W6OUmqX1an6nJ9RevQSVHE7RPdoZ1gLFlrZn2MJuwd4HZdnFc3z7Oq+zeUnxUpY0Pvi8HRT4sry7/7MqmjXWxLoaXAfGNqnzSU5yKylvaQAcxDF/IPrbt6CKacVJ+NzIRfI1TkTPlwDqbX93X8AO6UK5Tp+bDPzK+bHpBS4unyZ1A/Wy5eSeZ/15kN9mEnAomyblgqaKJEmtBiWBk3cGzXG+SO1J5xdzyDZkcM/Sg5ciSvKOfUfjd8FM+WMfh7s5fEHgQtk2L3Nh5jOfBo/n5cmBFxBTDxObbNyP+JyhhZatNngyaguOh3Hxje2oWW+2Y2P9/0s4x1dPYAyuWBGwOQqCUocPLPh/oSZXxrQ79akCywAC1wkUlR8PdDK/ynF/2bnrF2/VJCHodkcmlYVGXC3nbuJ6EDLKVePttJI9aE4G2ii2rwNml5hQ2lsuWB0k4MXAvuGwIGjCvjhnzARIpUP9+OO4zIs4lTxfFKT8xCuueAOOLfr6iIlX9XtgLhKEd1Wfk93BI9NRErIu2/8E6JGMA1+57fX49WnYEaAio79G5w6TAMMuaAzMoP7Vgk+IRNI9/i/WsdW1W/Z8UXhZtTnRG7MmfdO1+nFtQpmfGH17fQfFVqWgEfZgb8OV4qw+UUVEThrc2peE6P9Y9P6RZ+Vonk3LN4Q6dBNDmoxTNpogxoMQbQmQjfyGd2nU5n1soXVgiP3oC6yGU/x7Vdrz5Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?97kS7rKfBJ+LXz4bxtcqZGXswOEyvoJ17Y3evbLtnT3qweVXUjDFMq00dHWN?=
 =?us-ascii?Q?Fqtu5Bm0BxWBWXXJVZVonbAAtPgkHStWe7I3J5ZgGDfcy5n+rt1bWrLG6y+O?=
 =?us-ascii?Q?Qkbr4PaGi5wG76S9RUwN6IHG+EcsC3GuziR7zQehy/hajUdv4ioOrAiDjz6U?=
 =?us-ascii?Q?K1F6DxcaRhw9cRNYJiP6m07ndsFkYYrrk35A+LVwxidAWzp9w0Tkb3n2qbHJ?=
 =?us-ascii?Q?bj2MswZEx1SfKkPWF6q/ox5U5qZwP889en5/tPWj1sViO9Fh+AUyAAftZ21O?=
 =?us-ascii?Q?8BSeSvPoGZvz5/XjZSeF1bpf524GdyjfYEJKSLRuV7qdTveOnGSSiYF3bhSJ?=
 =?us-ascii?Q?R9gU2Y4ru/Xn2w3O9d90szlppZHiFD7/PrgQknD3K28U+MwhC5PjZ9DGiFBo?=
 =?us-ascii?Q?IzX/t4uF2KOUwnDFxPXZJnz8AzgHgwFImC5jZ2DeQuqAwagt2YETS2Nb3fhL?=
 =?us-ascii?Q?8jdOUrvbZZRNfQ29XdqrvSVBGBAMmhgCF+UORrSFGhllMLucSoJZW+rwnEh8?=
 =?us-ascii?Q?TRLVZXNxjRWpzgxO2RQbFyI9w3B4WXlQmB62lbsW9h6GAFx3DX+Ql//fBA7/?=
 =?us-ascii?Q?dezMm+1vMsTgv+ONZnkgPflEirayDCZR8zn4sqhmyPGVdLp7O61ok+/R9NPh?=
 =?us-ascii?Q?ru57TU9fs7d/bEAcM5pJEqZSCSjc+0dVFb2ovzlbbs1R5DFuH0RX1D5XZADh?=
 =?us-ascii?Q?GQ4UQ0y5N3TqD/GhMbthR6c8YLDk3kktvoHMLCkgWQRTQCM3HzyFityOkkfl?=
 =?us-ascii?Q?W1b/2WcQfnvtl4K0Fh9IvK7o4njEzRJtZo71b9VcVkouxcNPX5mWTNnv1zCJ?=
 =?us-ascii?Q?cb64AK2reZ/BpFYSeRcTitlORNfIRR3Jc2NmPZUhWVMD4V6QLMJXTuMsDey+?=
 =?us-ascii?Q?v3/KqTd9jvZ1ORW0Febq0NKI0W+QZeEG9zClwRnHzzoBzsMSngoa2UMkVBbd?=
 =?us-ascii?Q?B/v9/VfxvvhRxn5cPIn+ciAvmEStsuCVAmSJcR0dZnc1BqHpJ/c+w2WGNyn+?=
 =?us-ascii?Q?WSwuk9vZcfWat9O92ZH4kFS5ERe+Qm+NXS49SEP88Z9L4DMShWlZHpmr2REO?=
 =?us-ascii?Q?b5D/JsF5s/d9s9R+smJ1m4ZzHPDBjmWnjPHjndn+oYnEf1T+NmnV0AJV7NRX?=
 =?us-ascii?Q?tGD4FJPwqODssTqqMfyTBd+6xsq2tSS+lyCmSm6VbuaNbJK6tZB0XDxKcTQq?=
 =?us-ascii?Q?XT7ErNGzQtFSVuCy2PdLoTZaj/Sri0AkebYEU3a2mQ5TqcS6USzAs+PXhtYb?=
 =?us-ascii?Q?Ni2/fmm4jrA/aZz8y7Nq6oD82OiBWlEiYn5ncZdRdpLAuNH96mucO/zw+oYV?=
 =?us-ascii?Q?9SR61ExrP4TRg1xd3AMr9r5+UAjKg/brp54va9CaM//8clW70joURL9qCmPM?=
 =?us-ascii?Q?2aXYrE7/MXiOP13xIm6nna0YFvLjyEqb1UF6+di6Di000YY4jZPHvwT5G6Bs?=
 =?us-ascii?Q?hD5j4WBbuMNOUGGZeJwJbPXolXldJ2ZbS+nHPv46OamrMlOVDnvITpjcXWUc?=
 =?us-ascii?Q?f/JIfdJkMAnXoHw5/yAZljyleEUqUdNc4L7i8Bnqbi2qqGG1lAK+KArN+dAD?=
 =?us-ascii?Q?RD1CgvhTfIB8jrGSIij/Bzm8b2KpyHsMV6SoYeb/tJF9kxnQhcRUygK7NONS?=
 =?us-ascii?Q?5KsJuMCS0huEaExbTFShJA20wOJ9OjuVFD2OzJZSn296cUWQlGoCaS113Db1?=
 =?us-ascii?Q?p1oWdUk21W5iAbylOG4L9Kxq0dXdAslvzbh+q5b74LwRgsu4Sj/NjS71yCgv?=
 =?us-ascii?Q?HJ8PB9ZCRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DMjFrq6B4JqJo08GE03gyhvb7V/khK77jKX/OZ7Mr5WCHJqbgKqniPLansp4x2YGfqtb6HyPISoJ4wK2Kad155tmMmyMbV4MOFpd0hHnf1mG+iBaawZCHAdvj4w680FjESRDAeK5PlQhY5j2BPgPoUUfqjSEeBnThI2RNlHTcm19h5uCth6H5JTrYCB5kygtLfv+wfYJAmIsF4GHXQxBfnjhhEe1GSue4xblzlRnUvvrgdRJhgwgaRyJFewn/PSHrlybfwOiBaL/aHzOJP5KSDA4c+mYNZpO5M14ZvRqX8FOdZRnwJowB5gTaQf6HqW0yVpa5OX4ZvIjSQJcv2iotA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d0bfd9-d088-403b-282b-08dec09936a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:22:21.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fcW/TxqiSJDIIczIw9O9UO1TsKELetFmBVjVvfHIF1LdLzgT2ZEGwtC7ysyH/sa9Vf2Rbm13hc0H3Odc8Tzr2YZeXlSzq80e81ZefNaxNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE8B1F622C
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294161-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,intel.com:email,gmx.de:email,PH0PR11MB5902.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mensi.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72E4562DBA0

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 12:23 PM

>> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>=20
>> Gesendet: Dienstag, 2. Juni 2026 11:32
>> Betreff: RE: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly
>handle ethernet-phy-package
>> ...
>> >Signed-off-by: Manuel Stocker <mensi@mensi.ch>
>> >Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>>=20
>> Hi Markus
>> quite unclear (at least for me) what's Manuel's role on that patch.
>> If he's a co-author please add proper tag, if you are sending Manuel's
>patch on his behalf please change authorship.=20
>
>Unsure about this but situation as follows:
>
>- Manuel identified the issue downstream and sent a patch [1]
>- I advised to make that a separate function.
>- Manuel sent a new version that I merged
>- Now I'm sending the same upstream
>
>Please advise how I need to reflect this here.
>
>Markus
>
>[1] https://github.com/openwrt/openwrt/pull/23591

So it looks like you are upstreaming Manuel's patch right?
In that case using --author option of git commit would be the
most appropriate way i believe.

There is also Suggested-by tag which can be used in situation
when you advised to Manuel.

