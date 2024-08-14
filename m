Return-Path: <netdev+bounces-118653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6579525B8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDCF1F25D81
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8C14A098;
	Wed, 14 Aug 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Erzk+muf";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GbS1L05F"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CE1448C1;
	Wed, 14 Aug 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674650; cv=fail; b=a5b9jMofJZ6FCg2F/EY8KgWe14P+pEs2LGtDrurEBTq7YyKh59qLp44VJb8Vwy6/U2kyjAMHwRZQufkEj0L3CxRx17gscrIR6s00RHVB4ip0pWHg83dv8e7K30jx/xKiHG1tr4VGbzykDEh0BVPrkj1KC1wKxyVsVK6eyPKTFRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674650; c=relaxed/simple;
	bh=83N10ni3HFLesMoWPtBhXtBkT2ZiwLL3xxH110DW+rI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDGnH0rtKWRoDd5LtKDwkiOzqqhhZP/9sOb4bAzfb3ZAmWgwMjIG2BB2iGcd/cgE7ros3ntB1gbScc67eHEuxGwsqGA2CHgWvmSSWWQk8TiQMUzEfhITwm80sZQwV4u+h38Fl4ijupMvYr94jhH9G78RDX0eCbRgqH2POJjOhb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Erzk+muf; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GbS1L05F; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723674647; x=1755210647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=83N10ni3HFLesMoWPtBhXtBkT2ZiwLL3xxH110DW+rI=;
  b=Erzk+mufsDMhmhCtZODbbufD6xCx/bIDd9nRFJEUmIAPPThTq1r0gxrp
   26zRjeu9BoEDBwWrMpRcgqO0o8geeLZrflCrZMSSub2k8MaziFADWJd/V
   bbMDcsw1yzQpBLxd9k7QQyuyN896wN8QQ9Ps6Js6TixVdbJr5GSVctWt5
   CPmshkajTxIA3aWEAJqfu/FYDcqj8OFGfbwW2v3sX2XKiEoBedl3n6a+N
   n+z2btmxfTBX6NoIhCc1malzSNWcTlO1lovBkoaK7RvhiHfbpitcFOZLv
   wqGGDBzTO+On25Cik1zA1aMGFdPgXjC/Zwy6TK92z7xp7UoiZzkns8P4b
   Q==;
X-CSE-ConnectionGUID: 07pdjR4USAirhmcApoy4aQ==
X-CSE-MsgGUID: Kb+wFCIPTgudIYAfcIa7ww==
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="261420789"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 15:30:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 15:30:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 15:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulSlh5Cu73/jCiD45p2WxpP0+kK792cDOLI9MyLnXiUihxMF0Lqmt5rcPPpAhnWH8uw3DubFxA7UMd3Knvyyi5WGiNcMINAxskBY9BbyVxR/j/Z9hs5lVT9uuhtGG4CuKozQid/ksOH27rlhvaURUxOMR5TArvd+dEbW7LIFKMN2Ih/dmCejTetE+Gnfj97qKIuoWvOTnJqDpTUKU5/tJlxt7acYlj78Bo/DfJFbcYoYwNDRUnjakjXEOPUeOMEPojr55VNurWnu3zeZR+pLCkej8UuGSfhKVsIKG0+Qo/phx8quYcMFeYgIU43Cx9gxN/sAIKFz8cC5Mz34opVOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8i27dd7GguOhB9ZNXX+5prO0DwrSeV6NIjv/5OQoTM=;
 b=HIDZolRxWNPx4A1U3qHXyYqgWIv7FHlsfJ1VoCZc/sXXsRWGolr8vzF12s6rKgu+IJ3KkXbthspDM3fHiPjgPAaicgu1tCIZo7jOS8or3U1zgDJjnZ9U73rNxptEe+l2ebOOh0uAo4zM9XslOWxf2z74gbj1QlnXd6uD5OU/PlVgqIMpr27briThETcYs3a5qeQZcEF05Ln0/pTP5tZKeCRLudwu/8TYSwgYJIN3V1HH2s9ZBZ846pwJDhHZ3EkNC7jSopX+Pgtn2l1zSKZWt1iej1B2t/tTK+GcpaLQRoLmYCBdmuZ475vEu1jyHI4b8rhofdbtyXvok6Lw65tc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8i27dd7GguOhB9ZNXX+5prO0DwrSeV6NIjv/5OQoTM=;
 b=GbS1L05FxWpeODCT3lQO2Ax7dmHHab/vP2ThOMfV6UimiIkZ3X9Y7kMjjUTxQAdA69zlKXzaV4mIXrqE8oByCDaSUPz5UiHXH0DdwGGw8YHcpgZGf18VY0Xy+1KKQ+4LupqlFmzj9jBuRb28rAGnrphnd85WRvqEDpaUi0Zv2d0ujBD3YloH6rXjfJx4O4KjdMo6jCOD7QgCrxpUGPv4EIUxXAUbC0A3yQdojEPs6MaZIR5RVQibbfLyb7NYap/Pop+geKFs8phxXv+XubXzwFaha0uYCk/H8IAW8KAWN+KIdEP5eF1YEOWcBZ1Vhg8D2MUN594MU8YyFZjrj+sJAg==
Received: from MN2PR11MB3566.namprd11.prod.outlook.com (2603:10b6:208:ec::12)
 by CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 22:30:07 +0000
Received: from MN2PR11MB3566.namprd11.prod.outlook.com
 ([fe80::6454:7701:796e:a050]) by MN2PR11MB3566.namprd11.prod.outlook.com
 ([fe80::6454:7701:796e:a050%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 22:30:07 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Topic: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Index: AQHa6rVb6R5b4khOr0216lt4AbdkW7Igv2QAgAT0oCCAAAcxgIAACFyQgAEI1ACAAJA2MA==
Date: Wed, 14 Aug 2024 22:30:07 +0000
Message-ID: <MN2PR11MB3566A463C897A7967F4FCB09EC872@MN2PR11MB3566.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
 <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <9b960383-6f6c-4a8c-85bb-5ccba96abb01@lunn.ch>
In-Reply-To: <9b960383-6f6c-4a8c-85bb-5ccba96abb01@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3566:EE_|CY8PR11MB6865:EE_
x-ms-office365-filtering-correlation-id: 18ccd054-3fe4-4990-b3bf-08dcbcb0a68c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2vuoRQieF+ruxYMFFDHudT9OFsDBB1QxauIM0XfeC87vZl2nmbZGBYktDvHt?=
 =?us-ascii?Q?3mIBsNHDg/q9DF5/Xz1FexwkiDg7T0RXjKUqf5SBC+gQ19GIigQ8Xcx+mNxn?=
 =?us-ascii?Q?JixPNtCyECSwJsywrR66tCNSDJ3AtSOsOnZIEm646Q/RhjiAGNZM9IQRubm4?=
 =?us-ascii?Q?uwNGg5a873TFnN1e3yRxzmQwke2WuHqMcVYiZdRu0sra8vSpnrelk0rpCFcm?=
 =?us-ascii?Q?yijNFrSVKpAt8uHbpprcJYgwW8TL4gmdEX+gM4NRABhWWuvHnwqZUA5vibhN?=
 =?us-ascii?Q?CXR42ZYwHuLNTOMzj3FCCHvKrTjfzdy1NpnusUjQt3Bj4BQBHu0UEv9+1e3I?=
 =?us-ascii?Q?Ow47a4an0MppMeNEsQyYkoIRqCXxloH0zBR7O/5La0a3+/IPOQoqzAZGt2CL?=
 =?us-ascii?Q?BJ7MwEkvUVcAZBCeQ2QzMWGBh2nfTx1MqMSJvSJh9uRUElMQks9xhDDgq74A?=
 =?us-ascii?Q?o6Py8kjk0Fnx07yKw3afmrzxTfcTgUJh1VJCgcji2lNro0S9BWGgYacsbxfO?=
 =?us-ascii?Q?3Xo1QsZfnL7GMeudbN7SCviVEV9MCF4iZY8mCStjB1DpougBb7fyxTk8hKwp?=
 =?us-ascii?Q?Mx7pO7DiFvBycou4NnoJZZIwq/hJ6Ey+FhKc4kY2CbnHaPUwCOqqShSWsx91?=
 =?us-ascii?Q?tgdvjkwZ/dyb9J9UFofFN3ZWrK1hr+d1szlrPh+vZwuZ9TU7QOhoM1cNh6hh?=
 =?us-ascii?Q?xuW07uGwSK3BhhwcdHZTco1FHhM9NHghlFJYdf6sflcOPZ7/itCu4ZvhMfBd?=
 =?us-ascii?Q?dOtZUxECx6xNYUH7gcI5O4b9m5JGBNrBbqxHPXwWGzWnPVBWdQZdCK9aL3CT?=
 =?us-ascii?Q?SLWGmBnaZxvUqkWfFFYioI5ll5fn6P7xX8TAa2kgF7b4MNGJdQ6DIJLFi/dz?=
 =?us-ascii?Q?+mqSgWXo3iCOxOtR2vtK3JblM5AFmU4vtN0QiwKtoM9MRs4w0cLxyYuN+Xlm?=
 =?us-ascii?Q?q11ev0BON51mRx/Qwf9woPJZp19leBexurVM6fH4HDZXqjFnU/SjGyAXdMTD?=
 =?us-ascii?Q?Epqt9W1m3h/wJ88w4hDqq0WcaFGmv/8qi0yEQEYe0HARefo5OR/eNHjgr+6i?=
 =?us-ascii?Q?Zj2fMpg9obr4pwlS6QLr5PkTpwSWT/DCgKZgg09EPGR4XEEVNFeCGE1LHq2z?=
 =?us-ascii?Q?D2pmHLptSJ/d6uVJNIKSi8CYjpxMMj9/bKG8CIrqAUukSOlIGuSO69krixtY?=
 =?us-ascii?Q?Ey1bQ0wkxqW4xijjl0IM80qlpYJuhE5pGQjLp4eVqiNAcydC0shvK1gToa9/?=
 =?us-ascii?Q?OghSHmvWhL+mKmNQf4P/5OVYXA4rFOO/kyjk9Ywm+XCqxDqJtnPo3aAFc9Bo?=
 =?us-ascii?Q?tQBZRbxNxrFoayKgyOYpVmifmgoDAMsfEcYCKrZesgW0s72s+c7VkQdSvT24?=
 =?us-ascii?Q?B4NQxMqndzTfJ34mQRx5h/JeryUQCSaxt/Vy9gw5AtfZogMRKA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9QlxOXIYneIz1mzX8r6/QeEWmVGvQZ3lCvObSPSoP8mlVzAkT2ypVhxUhZ9y?=
 =?us-ascii?Q?ZRNco88EnGOS8PzAsx+wwrjDpDkzC+x0Xwj7yo83TOveQUJtfRquuc77SPMR?=
 =?us-ascii?Q?l99sNuAQ7oR+aU04LEWxyV8tMaQLdoDRRgf/RzLCL0hJfLxA69GWdoSfSInw?=
 =?us-ascii?Q?2K28U6V7axpNiAPHlDU2tra3vtT/qqAGmVLwkRKBcigFk8sn2LWIdsw/szr0?=
 =?us-ascii?Q?nQCjYV4Aumv+dGkTXpmYsEyATKGD7zwqIF5M9mf5800MgMU3DSDe0zzDwYz1?=
 =?us-ascii?Q?oM7UQ3BwsXQWVxjb8W/x4SshKDI54VUbRwqM4tmhWV4Lh399TnyygvVUl/bI?=
 =?us-ascii?Q?j8wVGN+SeYlWWJbE/8BzjxK7rQzJWhn9RRZoLP9xwRjQUfMQmiaw7PPCcCVX?=
 =?us-ascii?Q?VN9OCc5sXfweurW3v232JUdxccs5k3cUAO0Uv4QuV1+3zakedA7Kd80VcXU4?=
 =?us-ascii?Q?/29WUEvHbC8QyC+TIHeS3qPEDuaf4sFay4E0zfByshzZai3MtMonnOf+UmPN?=
 =?us-ascii?Q?cLak4sGR7LiFNDp2wOqIHgsB5Fs81PQjY5MsuxeQ13KoQyTMdElsEs1Ff0+F?=
 =?us-ascii?Q?yuJVfBnEwftGwv8IlktQXnp7ExZvwkvldf7cWmeOVWwOb0e/ZRt8psPjgmbx?=
 =?us-ascii?Q?r+dHUxCtr1Hh+aln4zc8AnWeMid1Y+ePrP4uYsjZym4d+dqVK1AgBor0lFy6?=
 =?us-ascii?Q?3UaWtFq0e0GKvkNNf4NaXKoLG4oDrXPZ8CLs8hGzCN820qq9fvthwHVDXScR?=
 =?us-ascii?Q?Z5Egbwi0TBqcz7zU6yPd7gSFq0iozuy3X7C9Rq1XOZMFjLbf2tbrV8wYDGqk?=
 =?us-ascii?Q?ba/jjF7YvvwPTOBgb7XO0NhE2FamZGt44sV8KcSD1F+S6p+BYNSet8fJbx3x?=
 =?us-ascii?Q?G+evxV7NFCzDcNgp3tBCzQH1ciFTpfxC5R/7lFMlIfuAoXAGsEUnDb0BFDcB?=
 =?us-ascii?Q?sOo6dgAx+NLGVwprCtW04RvdZJnLUHT6v6BK5v7O0kuI9GefCfv91Z+Ke5Bb?=
 =?us-ascii?Q?8mFPo//Zm8Sb6EVUK1IWNomYK+yvwZdJJnA58h+Twfqvkki38k+O1wJzRjbJ?=
 =?us-ascii?Q?AZQXUpfy0ac5YGrJ1xUktic4MvAUmlkci9myO9dOFdRKDxQHpXwcrIsw95A4?=
 =?us-ascii?Q?ZF375/+LfhNpyTN3kZu2/yMJpiqCqSN/1GPlkgXdbLsdGbrt2JK0NXcV3y9U?=
 =?us-ascii?Q?fqjCxFelp5KdNoaytJl20xoMulGyPUyMK60W46xhtPAIaVnTHgeS+PDrlxTY?=
 =?us-ascii?Q?QYT2jxno65Ds+chPxtLihcdTFHaMq3iltpKumOTUOJXDzl2PXpMmfyB4pbdu?=
 =?us-ascii?Q?O8O4CBqzzvIek543TY2XphdKn2Mz3bi4I7tfcf/cE89edAxEcO69fyy1vqZj?=
 =?us-ascii?Q?kMzsd9SRPgUhxUicuWa/rIhEova5bznqbYC0yBhQ8DfUB5XNFa1QxW6o0jj5?=
 =?us-ascii?Q?xnpjCwHw51zvk2GTspaKsT9fuhk7Rzf3cyluZOaxk0pWwMBgBhmq3KDpL+99?=
 =?us-ascii?Q?7sLO5diVmpC3KcGSeILIE9+2i6A4W0VA4D2g70EZJpA2oubBR0c8OxaJQVgF?=
 =?us-ascii?Q?FWqCZtVTNfjJx4+CKBvGgjlfqawrmKfziZ7ZeC1S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ccd054-3fe4-4990-b3bf-08dcbcb0a68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 22:30:07.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D34mOJryNpPDdNGDSrfm6nPwR4WdXmOkaMJ8RxCzNraAGR4h5qlKxrdvhx/e5Dr1klQ7aIbgAyB5lyLW1B53TlLGMZdjSx8Hl9oO84JTP5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865

> On Tue, Aug 13, 2024 at 10:17:03PM +0000, Tristram.Ha@microchip.com wrote=
:
> > > > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > > > >
> > > > > > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 fo=
r direct
> > > > > > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> > > > > >
> > > > > > SFP is typically used so the default is 1.  The driver can dete=
ct
> > > > > > 10/100/1000 SFP and change the mode to 2.  For direct connect t=
his mode
> > > > > > has to be explicitly set to 0 as driver cannot detect that
> > > > > > configuration.
> > > > >
> > > > > Could you explain this in more detail. Other SGMII blocks don't n=
eed
> > > > > this. Why is this block special?
> > > > >
> > > > > Has this anything to do with in-band signalling?
> > > >
> > > > There are 2 ways to program the hardware registers so that the SGMI=
I
> > > > module can communicate with either 1000Base-T/LX/SX SFP or
> > > > 10/100/1000Base-T SFP.  When a SFP is plugged in the driver can try=
 to
> > > > detect which type and if it thinks 10/100/1000Base-T SFP is used it
> > > > changes the mode to 2 and program appropriately.
> > >
> > > What should happen here is that phylink will read the SFP EEPROM and
> > > determine what mode should be used. It will then tell the MAC or PCS
> > > how to configure itself, 1000BaseX, or SGMII. Look at the
> > > mac_link_up() callback, parameter interface.
> >
> > I am not sure the module can retrieve SFP EEPROM information.
>=20
> The board should be designed such that the I2C bus pins of the SFP
> cage are connected to an I2C controller. There are also a few pins
> which ideally should be connected to GPIOs, LOS, Tx disable etc. You
> can then put a node in DT describing the SFP cage:
>=20
> Documentation/devicetree/bindings/net/sff,sfp.yaml
>=20
>     sfp2: sfp {
>       compatible =3D "sff,sfp";
>       i2c-bus =3D <&sfp_i2c>;
>       los-gpios =3D <&cps_gpio1 28 GPIO_ACTIVE_HIGH>;
>       mod-def0-gpios =3D <&cps_gpio1 27 GPIO_ACTIVE_LOW>;
>       pinctrl-names =3D "default";
>       pinctrl-0 =3D <&cps_sfpp0_pins>;
>       tx-disable-gpios =3D <&cps_gpio1 29 GPIO_ACTIVE_HIGH>;
>       tx-fault-gpios =3D <&cps_gpio1 26 GPIO_ACTIVE_HIGH>;
>     };
>=20
> and then the ethernet node has a link to it:
>=20
>     ethernet {
>       phy-names =3D "comphy";
>       phys =3D <&cps_comphy5 0>;
>       sfp =3D <&sfp1>;
>     };
>=20
> Phylink will then driver the SFP and tell the MAC what to do.

I do not think the KSZ9477 switch design allows I2C access to the SFP
EEPROM.  The SGMII module provides only 2 registers that work like PHY's
MMD operation to access vendor-specific registers.  One of such
registers controls how the module communicates with the SFP so that it
works with either 1000Base-T/SX/LX fiber-like SFP or 10/100/1000Base-T
copper SFP.

Actually the default setting works with 10/100/1000Base-T copper SFP
without any programming.  That register needs to be changed when
1000Base-T/SX/LX fiber SFP is used.

I will see if those vendor-specific registers contain the SFP EEPROM,
but I do not know how the sfp_bus structure allows mapping the register
access to probe for those information.


