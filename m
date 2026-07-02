Return-Path: <netdev+bounces-304002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wt8tN94MRmpRIQsAu9opvQ
	(envelope-from <netdev+bounces-304002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:01:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08C6F3FCC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:01:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=aiGX8Scs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304002-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304002-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5C7302AE04
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73938E12B;
	Thu,  2 Jul 2026 06:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06638D6B8;
	Thu,  2 Jul 2026 06:55:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975322; cv=fail; b=gdYd2JGJahrytC/2vKufbg1Yo8y+162h9yyulCnAl6jUQNFRWI7k6Fjly4QJyoUlwlj7ZdOkdakE6mNo9BqEQSlxx5wmUzl5QyEBKP6YEwmbCg+kyikUdT2KKbV8fC9yeKRWLwfqP3chTZ1M7p5fwU3W8PMc6Y2DIsYLEOqW3k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975322; c=relaxed/simple;
	bh=F1WtjJT1Aab/kkbQRcWetVy9iSkSqa5AL8+HJxSU1XY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c436l4SHdB+/fM/jEOfAWSjYLL7OYplZWkJPzKlQWd58DmdmOqqVTqqXLnoFrfuHaAKgXxbkMbyVif+bsLnxUUgrxim9x2ALSFq6HZYlZRrjUc/WMGMVrAU89z5Ftc4hOIn/HEKz3CybuHFd5ZltZcXI817z+qmRa8pkrAHQUJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aiGX8Scs; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdNm7qVq2GNw64jzEQJzuMkFxOMBDP87QLzzPAnfXZyeOAlxtzJ0v8F8xXwfFhgU17YMOZ5bytebnOvdcHdxOb44FieSDYRM+a1UZ6ahnPXwqaz4q0JlIaahIdaxNOAizps+SAjyw4u9I5Svs0jsUlacrmvPDlrQSkoYrsg97Fsh7rCMhCbEg1SFmnBa0R2MPkN2l53uLY+35PEe/IfYGEkaZfaKsv+4C1hfbi2uKRP2KQR4IZLCa2nvnk+j5k2/v0uYlQT8mYZS0sjIn5vZjZ/0vFVwxtAP6GYlOd63Rui/gvRCtHrODTknNdvRd8mw8u22W0AVyVBckkLPu8+IiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1WtjJT1Aab/kkbQRcWetVy9iSkSqa5AL8+HJxSU1XY=;
 b=P5uDUSw29SJFZ4avI3//qtfccLaMEfG48iq9QpxGBkgG3dgD+qQvw8p5egjc4r5v3P7MuN7kwHbz41zWnaRXSMaemU10cfYU4yP8XIHCSMflgN8OCVuDsmabtBVMtQQmleTES4cBv0q3zmiIlkQ4wzbQsCTt4omrLtdcWADw8YWSpGdPkW11UQqqhwdbRZagrlJOK/Pc5Y5lOMhVVCgA2+bZDntwo950ZplURmz4qYA+2t9KxN9JmvH0SQMMnsHgQD1RCF4HnssUnwvHHwZleDMfN9zIV+Nld1G9QJiCF2+JNctU8gx4u7evkMqqY5tcrxbTI4D3qY0zDsOXfgsUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1WtjJT1Aab/kkbQRcWetVy9iSkSqa5AL8+HJxSU1XY=;
 b=aiGX8ScsLRGN5DNPEiWN0n4Cezbe7La7IHQIq87lYRBCyXnFO7ErzWARVbBnXopxQfuZ7y+TlDE02QOyk8KIsp1JggOyg1D4frQ4YzD3NMiKdCjNQSQ1gBkzGzYrtOdgvik1SYBAinH+BOcSROxbCtCFkWS2BRGKsIQNJy4XcadjghADPiSbIpE1s1E1NyyTDFKH6n7Y+1oBKnbGib0lh5na5TPhXkS8qqEzSZaH1aREXSia4bNf1hm+eUO1C9hi3/9vwsSEYbHfi1sq1siYz0b2OBeVs3uPBfJnXaQTJDw57xztJhP4oW658stzKg/aH7o5hjBpLn9fPKiS4CLvFQ==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by CH3PR11MB7297.namprd11.prod.outlook.com
 (2603:10b6:610:140::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:55:15 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d%6]) with mapi id 15.21.0139.018; Thu, 2 Jul 2026
 06:55:15 +0000
From: <Manikandan.M@microchip.com>
To: <krzk@kernel.org>
CC: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to
 be exposed via NVMEM
Thread-Topic: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Thread-Index: AQHdCHJO2Gcoz1g2RUeN8B826tcfiLZZw6SAgAAK74A=
Date: Thu, 2 Jul 2026 06:55:15 +0000
Message-ID: <860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <20260702-utopian-termite-of-perfection-f1f3ec@quoll>
In-Reply-To: <20260702-utopian-termite-of-perfection-f1f3ec@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|CH3PR11MB7297:EE_
x-ms-office365-filtering-correlation-id: eee063d6-db4d-4028-366b-08ded806df03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 d8KWq0q1tBJSS14KojuM5Oxpue8Tvql1WnCnUYp8xUNvqMt8EPHiuP7QrKAZAXBxsF8hXqFp/8jjozMN4G313jZrUQ9yXLtJOiUiTKmgG9xCm9sD9l2Fq8MiSite0EOhJLltBBNfiIEihiQlwoqI+Kjk0JstZ02NJiT4cqYqU4hSZFrB18XceNfcfn3SaTEmz8ekc9j1PD7/oKcxsrUDofPwAv266QMTB1pNB8XO+2ALL8/u8BNLdr9WB5u6WYuLvFAVB1iu/dlnbIiDW4QjlsZhCHALBLOwpG/JoSZpEWO8Bym9Ad8/EyXdathGQzOqZgALD6RzaKNY5i3bAp2uRfewiReA36pYvwAEC21Wux0d7AbcLPiSKQvUiWrzsqevHrELggA8GxUpoQfbq4yMV0qhhTvP37sS2ZLBgLy/zkEJlfKkhuwbEsTy4mgPu46DQOMgUAKLFy6/GfxZ0Vz3qJxMVDSvgzmVIkWQ8FuyEy+AWQ+vvuT/sMsXaxFNetHiqSEi1wxeOe8a93nX6rXHaxnA0glQGt/nz4ofAkPnMl5BRGRFLATF55fKecIUIme3Vo9rJVuH/QOTLEDv7ZjxuZ+jPEEy+Pe4kosmrbT8/VXu4MfiEol3qeTgxYraACARkJHbWh9dXRS8Ybd9LvCVtW+kXi2iMOd063dgFl2isE30Uf1wktPuzFFu4wPiEeZYncd1SdIyOy6dBPocs0j8THuc3AMNkawiwJagWZvx1GA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF9623118BD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWtuc0FwNnF2ZHJhMDc1S2d5NDZxeDRzUmorNEdjSFVkYzhta3pIa3VqQ251?=
 =?utf-8?B?cG5zYi9PRHhRcERPN2NoNDdCeFRRcDRBMUVZVUY2dTFqNlRWRVZwdStJNEZp?=
 =?utf-8?B?ZWdCcXpDVk00SHU1VEpRbmZQaUcxdS8xQjlkcDhVSUpUWXd4RlE4UDZ6d2Rn?=
 =?utf-8?B?SWFFQ1JsMWpGTTFnUWlMMC9nSk1UWXUyUk82SUVRRElJSWdtNmNyNU1KN3la?=
 =?utf-8?B?T2R5YVhRVWYxNE54dVZxZjdLOHBBL094ZGlUYlU4MGU3Q3VOZ2ZjUC92a0Zh?=
 =?utf-8?B?bk00SEZXZ0Z0cVJ5b0RtZXVXK21OdWVENDFKeDVEVG5BYm5aOVhMZW5MVmRi?=
 =?utf-8?B?SnZqRWFkdWdPSy9qekdmcG5URXhBb0JTZTZPVEhqWUJleUVXc3ZHeWN6YjJV?=
 =?utf-8?B?enJwbWxDM2pFQm5tMGpWbUl3OTEzUlNsQWRrYzlta1VXT1FXSzdrQk9iUDhO?=
 =?utf-8?B?aDN1VFBaM2xsdTBZL2dLSDBWMmtKWmw3R0ZPRGlsdWt3NmtDc2UwQkEveVpu?=
 =?utf-8?B?QmJNTnlzU0tVNmttYk1ibWozaysxSVZXckdNdmpnRXpQeTIyR1RjRitYRGRY?=
 =?utf-8?B?VkN4dDgvdTNjc3pmODV2TVdad1cyMU43NlQrK21mdTRGMUMwN0FUMk1HQ2tG?=
 =?utf-8?B?RjQ1K01DQkl1SDNoWTE2WnBUK1A1ZHh4Wk80eHliaHdYQlBuYkl2TENJdXZS?=
 =?utf-8?B?Q2RTQld5ZnFtbk5EU1MycDU4aEhJYTExQ0tJQ1RtUnY4TjhibUJBS3Y4OVhs?=
 =?utf-8?B?ZG40TnQzUXROQ1VXS2RIRTN5V015c1ZLQmxVZVcveFVLVFNnTmVRUjhtY3FB?=
 =?utf-8?B?aVpJOFNaaVB5dTBNSWxrYk8zakNJclAzZ3ZJRmpycGRHbEtkbzlJeDZDaG1Y?=
 =?utf-8?B?Rm5hanZqYjduWDhrWUtLVkRZYTNKa04zR0o5dVRXaXBUOWNaT0JNdktYZXEx?=
 =?utf-8?B?andxSHhYaXZwZnpNdDh5bW1PcndOd3hJamdNVlR5Wkw5bW5DeUdsOFpPZ09S?=
 =?utf-8?B?M1hrSEdvWVcwb0RzcXRUZWdEZ2VKdFJldm1ubGx0S21URmFEem9RTDRCVzEz?=
 =?utf-8?B?S2h0eUNta0Z5R1FuQitNY0lNQjczUnhVSzViR0xXSG1TdUtjSStOOXpBMGdi?=
 =?utf-8?B?WXJYL2Mvd0FveFROd094cXMxZjRrZGNJOU1nTVlTcU9zVVk1NVdwdXdGRUE0?=
 =?utf-8?B?ZGlTZ1A1STdXUlB6ZmVlNUJFYUZaVFNWY0owUG1JaitmdXB1dU5WRmhpWWdl?=
 =?utf-8?B?WEFJRHU1OVlVUDlhaVRCSGp2REFpenBERm9nZHV5bGlaT0tWaWJoem5hUDJQ?=
 =?utf-8?B?bmxjNmE3S1JKVjBkSGNkRFEyeDZUTVVxbTIyY0MvbVJyS0VyQVNrSGhkOWFO?=
 =?utf-8?B?VTNZSGpJU1p3d0twUXcweitZZ1NuWEY4akcwSVhvOE5TSnMwU1VEQUhscFlM?=
 =?utf-8?B?Nm5hdEd4ZFBIVHZLRXFITklzZ0d4R3d2dStFQ0RYOUxNQ21udWtxOTUrR044?=
 =?utf-8?B?b1hMdTUrVFpSL0VTMXlqQnRJMkpIK1JvSkRvUEZwWi9kK1dOczBUSHFvZFdB?=
 =?utf-8?B?ejI2SzcvNWdvVTg3aGhZOHBORWZkTTd1V3lSeFIzMDF4Y0tXN2s2SzNZYXd2?=
 =?utf-8?B?OXFobTdIM0dYY05QQ3BiSHZuUHRPblpnVWZzbzB5elo5TktyT2kwRGJMVnpu?=
 =?utf-8?B?MlhoL3BtVmdNWFNHYkFnUXB0YXducjdEY0V6TFljVjhnbWdtSElRZCtlTE1l?=
 =?utf-8?B?NUdhSTVTeDJYaUhyMUlnUEVRTEVQUUo3eDl4M1BVTXNGMVVQdUR4aEFzaXBY?=
 =?utf-8?B?V1c0UDUvSzFscmhJNWdoZEFEb0dEUHhLNWpRNGxsS0daL3ZoMlc0eUtlU2J0?=
 =?utf-8?B?SFpMbHNDdzhZcDR4RmZNa2ZzNmFEd3dIcG16bmdYb2lwTldOQzc2YXNZYlp2?=
 =?utf-8?B?RG1FdEMvQk5uOG9CM2hSWmZHN1B4cFIzRG5lU3UzaWpSblJmSDRsYldxbE15?=
 =?utf-8?B?NGVqQjQ1emRmRDlyRFg2Y28yZC9ac3BUejFPcW5lTjJhRlBEZzMwY0ljaExv?=
 =?utf-8?B?Z0RVSlJaOEpZNklWczEyS2ozV2pHZTNtUjZrOXZ6cGVQMlg2OHhZNys4bHBS?=
 =?utf-8?B?eEs5NEljZTVvMXQrT0F5N203OEo1STBKWmtGaTBQUkNHV3lQbTNIVGJZVDB0?=
 =?utf-8?B?bUVET0tXR2NhK3ZSbEZucnFkUzNmK1dwQmM2YytQTmJOMjRjK2s2dmJIOUYw?=
 =?utf-8?B?QUtlWk1WeEtVc3FxSll0ZzNSVjhhRko1YlNqZWFLM0h1U0RJNkdWMGI4ODdk?=
 =?utf-8?B?ZSsvcW5sK0lEcXFTTG0rSDFNSFh1eDJwWnJxaW1uaDVUeitPS2g4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E966EAD5E12804FAD9544DCC9D95867@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee063d6-db4d-4028-366b-08ded806df03
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 06:55:15.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4WZ/XCi+Gp0fg0hWTtSOLmRyrF31WHEP2bYPW/y7yG7YFyDSbCIPNxS9QAmhtPrqQlZHW415OZS5vlCwdUBAVPT+Danpi/o/gr5rWrNRkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304002-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:Nicolas.Ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:linusw@kernel.org,m:arnd@arndb.de,m:michael@walle.cc,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Manikandan.M@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infineon.com,bootlin.com,nod.at,ti.com,microchip.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,walle.cc,lists.infradead.org,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Manikandan.M@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F08C6F3FCC

SGkgS3J6eXN6dG9mLA0KDQpPbiA3LzIvMjYgMTE6NDYgQU0sIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVl
LCBKdW4gMzAsIDIwMjYgYXQgMDI6NTQ6MDBQTSArMDUzMCwgTWFuaWthbmRhbiBNdXJhbGlkaGFy
YW4gd3JvdGU6DQo+PiBBZGQgYW4gb3B0aW9uYWwgInNmZHAiIGNoaWxkIG5vZGUgKGNvbXBhdGli
bGUgImplZGVjLHNmZHAiKSB0aGF0DQo+PiBkZXNjcmliZXMgdGhlIFNGRFAgYXMgYSByZWFkLW9u
bHkgTlZNRU0gcHJvdmlkZXIgdmlhIG52bWVtLnlhbWwsIHNvIGl0cw0KPiANCj4gV2hhdCBpcyBT
RkRQPw0KPiANClNGRFAgaXMgdGhlIFNlcmlhbCBGbGFzaCBEaXNjb3ZlcmFibGUgUGFyYW1ldGVy
cyAtLSBhIEpFREVDLXN0YW5kYXJkaXNlZA0KKEpFU0QyMTYpIHJlYWQtb25seSBwYXJhbWV0ZXIg
dGFibGUgcHJlc2VudCBpbiBtb3N0IFNQSSBOT1IgZmxhc2hlcywgdGhlIA0KdGFibGUgY29udGVu
dHMgcHJvdmlkZSBiYXNpYyBpbmZvcm1hdGlvbiBhYm91dCB0aGUgZmxhc2guIFRoZXJlIGFyZSAN
CnN0YW5kYXJkIHRhYmxlcyB3aGljaCBhcmUgc3BlY2lmaWVkIGJ5IHRoZSBKRURFQyBzdGFuZGFy
ZCBhbmQgdGhlcmUgYXJlIA0KdmVuZG9yIHRhYmxlcy4NCj4+IGNvbnRlbnRzIChlLmcuIGEgdmVu
ZG9yIEVVSS00OC9FVUktNjQpIGNhbiBiZSByZWFkIHRocm91Z2ggTlZNRU0gY2VsbHMuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9q
ZWRlYyxzcGktbm9yLnlhbWwgfCAxOCArKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPj4gaW5kZXgg
NTg3YWY0OTY4MjU1Li45OGZkOTU0NTk4YWIgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwNCj4+
IEBAIC0xMDMsNiArMTAzLDIwIEBAIHByb3BlcnRpZXM6DQo+PiAgICAgc3BpLWNwb2w6IHRydWUN
Cj4+ICAgICBzcGktY3BoYTogdHJ1ZQ0KPj4NCj4+ICsgIHNmZHA6DQo+PiArICAgICRyZWY6IC9z
Y2hlbWFzL252bWVtL252bWVtLnlhbWwjDQo+PiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczog
ZmFsc2UNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgVGhlIFNlcmlhbCBGbGFzaCBE
aXNjb3ZlcmFibGUgUGFyYW1ldGVycyAoU0ZEUCkgdGFibGVzIGV4cG9zZWQgYXMgYQ0KPj4gKyAg
ICAgIHJlYWQtb25seSBOVk1FTSBkZXZpY2UuIFRoaXMgYWxsb3dzIHN0YW5kYXJkIG9yIHZlbmRv
ci1zcGVjaWZpYyBTRkRQDQo+PiArICAgICAgZGF0YSAoZm9yIGV4YW1wbGUgYSBmYWN0b3J5LXBy
b2dyYW1tZWQgRVVJLTQ4L0VVSS02NCBpZGVudGlmaWVyKSB0byBiZQ0KPj4gKyAgICAgIGNvbnN1
bWVkIHRocm91Z2ggTlZNRU0gY2VsbHMuDQo+PiArICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAg
Y29tcGF0aWJsZToNCj4+ICsgICAgICAgIGNvbnN0OiBqZWRlYyxzZmRwDQo+PiArICAgIHJlcXVp
cmVkOg0KPj4gKyAgICAgIC0gY29tcGF0aWJsZQ0KPiANCj4gV2hlcmUgYXJlIGFueSByZXNvdXJj
ZXM/IFdoYXQgc29ydCBvZiBzdWItZGV2aWNlIGlzIHJlcHJlc2VudGVkIGhlcmUgYnkNCj4gYW4g
ZW1wdHkgZGV2aWNlIG5vZGU/DQpUaGUgc3ViLWRldmljZSBkZXNjcmliZXMgdGhlIGZsYXNoJ3Mg
U0ZEUCByZWdpb24gZXhwb3NlZCBhcyBhIHJlYWQtb25seSANCk5WTUVNIHByb3ZpZGVyOnRoZSBT
UEkgTk9SIGNvcmUgcmVhZHMgdGhlIFNGRFAgYW5kIHJlZ2lzdGVycyBpdCBhcyBhbiANCk5WTUVN
IGRldmljZSByb290ZWQgYXQgdGhpcyBub2RlLkl0cyBjb250ZW50cyBhcmUgdGhlbiBjb25zdW1l
ZCB0aHJvdWdoIA0KTlZNRU0gY2VsbHMgLS0gYSAiZml4ZWQtbGF5b3V0IiBmb3IgZGF0YSBhdCBh
IGtub3duIG9mZnNldCwgb3IgYW4gDQoibnZtZW0tbGF5b3V0IiBwYXJzZXIgZm9yIGRhdGEgd2hv
c2UgbG9jYXRpb24gbXVzdCBiZSBkaXNjb3ZlcmVkIGF0IA0KcnVudGltZSAodGhlIE1pY3JvY2hp
cCBFVUkgbGF5b3V0IGRyaXZlciBpbiBwYXRjaCA0LzcgZG9lcyB0aGUgbGF0dGVyKS4NCkl0IGlz
IG5vdCBhIGJ1cy1hZGRyZXNzZWQgaGFyZHdhcmUgc3ViLWRldmljZSwgc28gaXQgaGFzIG5vIHJl
Zy4NCg0KVGhpcyBtb2RlbHMgdGhlIFNGRFAtYXMtTlZNRU0gYXBwcm9hY2ggc3VnZ2VzdGVkIGR1
cmluZyB0aGUgdjMgcmV2aWV3LCANCmluc3RlYWQgb2Ygc3BlY2lhbC1jYXNpbmcgdGhlIHZlbmRv
ciB0YWJsZSBpbiB0aGUgU1BJIE5PUiBjb3JlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1hcm0ta2VybmVsLzIwMjUwNTIxMDcwMzM2LjQwMjIwMi0xLW1hbmlrYW5kYW4ubUBtaWNy
b2NoaXAuY29tLw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg0KLS0g
DQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQo=

