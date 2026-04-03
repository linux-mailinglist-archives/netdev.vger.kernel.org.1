Return-Path: <netdev+bounces-274835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMkCGV8Xz2lZswYAu9opvQ
	(envelope-from <netdev+bounces-274835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:26:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B777C390068
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E53D53011A50
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B1282F03;
	Fri,  3 Apr 2026 01:26:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67084282F1C;
	Fri,  3 Apr 2026 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179600; cv=fail; b=fe/sFbaqzkiPlObjBr6Oz2/yaYjKpciAIaC7o77v1iGa0+7XzRii5ezPz6xH7mt2NajO9R2ZySe2ej4622vnP5J4H6aV+VbqmmJegLg8yn+ly0u3NB60e3Dec2KiXlzt9K8kmLmD4J0vbDtzdeojZyYXo1SbTLFaifTcPluw3fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179600; c=relaxed/simple;
	bh=ISerYQBD8Gpxs5oT5bdCAtdZqS+Flic6BcA/EJd+lzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXeJUUxPchWKmbsZGYobI6kUE/3IFZadV4Zc85TDGaxsMafn73bG0nU2TkWYjxE95FNnha8g1kZY3fLv/nWwKe/mED3+nZY7nZtu1/iiXW5ytwGXU34N7JeQy6RyEa1F67M9RZVheFnh0tcTjpuzjHKMuIkwqXqpFjgucpdzfNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeZbQOpyT/kjLbEv8pAkCf0NIOTANgszSkVVjJDPaHQB/3um3+Az3syC0iMRyITcvUo9kJ5zOoE19Z2dG61UBGQ/RVT9wwpo0TQA/QVW6vhEuaJG3PZLP/iYBPEG4aa9pYpuq7N8feIpl0QG6z8e0keET6iYIMLxzbuwsNVM89q1GEdE2HPj5wuuXTSsyerobuqkaKHr/VClHfJEXjD+UncVxot/Kz0KxgFf00w1SVXH8Bd8pG+h/MNXCH2ifgKKdDtFfZab2FaqXL4vtdFXW5P1lDSnenpPh3uNlF/JHrhMqcozQrImHUHUKrDGOC3qXyQMWtUNkhvAyK6w3nQ9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISerYQBD8Gpxs5oT5bdCAtdZqS+Flic6BcA/EJd+lzw=;
 b=SXO82wYAQzf/OG4t9RjV/qqNlztKP3hNShrk1O+kHsKo+rhxMw7TiVaefEsJ2LWblamG45EnjXkyXIClN4iIjGdN+TFVTsTVPSOvFliHPITVdK+rDj7hYml/1DM4zv+JxcHibDbqlp8y76EKWR00mXE0B8puMY/GPXdcunvoe3xrP2AAxKDDw6zAO+j5ZmXWIl/QbduumhQlWa3x9ZJGe9cp1yat2x197hs5el20S4VLttaVOLypOasx1PqIGPOEW5T+s4v9/qSoYxRIZ082I1Az7gnAjjdBUwsLr+9AdyAmeDRzJHnyBa8bqyIevBQFY4T1X9HhAOaMNssQ0eXYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1233.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 00:53:27 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9769.020; Fri, 3 Apr 2026 00:53:27 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette
	<mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook
	<kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, JeeHeng Sia
	<jeeheng.sia@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, Leyfoon
 Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 05/22] dt-bindings: clock: Add StarFive JHB100 System-0
 clock and reset generator
Thread-Topic: [PATCH v1 05/22] dt-bindings: clock: Add StarFive JHB100
 System-0 clock and reset generator
Thread-Index: AQHcwo9G4StYs20kFU27Q3NVQ7blp7XLsaCAgADR0DA=
Date: Fri, 3 Apr 2026 00:53:27 +0000
Message-ID:
 <ZQ4PR01MB12020FC228283055668F7247F25E2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
	 <20260402105523.447523-6-changhuang.liang@starfivetech.com>
 <2d3ef7359f63fb364cb7bc13b721132894428874.camel@pengutronix.de>
In-Reply-To: <2d3ef7359f63fb364cb7bc13b721132894428874.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1233:EE_
x-ms-office365-filtering-correlation-id: 8e861a8c-9ad1-45b4-1048-08de911b6ae5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 mA5MyDvL6+Q7Opd9IZXo1kMGw9jUdovoZa7nxFXmZywZ8UeUKZvKKFUdXIRJpBwSvAGhKQYWSKraTq2btODd8m/z4YPji++IkVXujPfuJGiG24PszM2Km5ON2/Y4SsN0rgQK/4PbwSROtp49Z5Oo21rLeAK2SP81QsbAURGvbyTzMUFviMPtfxjg3s1meIA9p6tAh4fjsMOGQqveJyIrJRwDXLae177E+mw2GD4nFDpOx4Wim4/xBi3EGPRFyawazREmaLJZBs9Q11cR8w+szyacZggV+jYoFvfmpDwv78Zb+Gc53QH91GxEq7Zwnt3Qo9WXAwJ/t6k2i5rlhDlZJai/npcA/u8ak77OlMMFLpWBqGmrCyuEc/crF23XN9CVosIEytUssiv18GQ9zkxl/gF82HApX9Bga9TG/utCLZb/DQvqafo0QajTo6ZlczF8Igy8YAvEiDlDLOary5XzSUzOJT1lBAGO1es1gX7LiLuql/9RNchknhAJqBCJ0T7BgExOBX+pYhYh+lLABJxVHPFSoLHMfH7vztKzNpW/9UpLSikiwJhaZdso+a4PpnpBzsD+eBY1Yn77nIg9GuNB1Ua+TiSpjoijVeXAMC4FPO8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emU1cGhUQmhUWk02dEpqZFlIRWlhOWROTmRBS2QxaUlDelNZSzJSNEsxczdQ?=
 =?utf-8?B?T1ZsMDVqMVpnTVRWOGRFNk9zWXRLK2VScWJUSnNNLzY5a2NDai94OTZQS3pV?=
 =?utf-8?B?TnNBSExSWU1sZmdlMk1DTTZ4VzRkakMydDl2V0ppM2pPOHRVZWd0amd6QkZZ?=
 =?utf-8?B?dFMvTTZuNVhmY1pRNFpRZmNqdm95TWorbkNOcVZjdDFwekFHb2ljelRsR2Fa?=
 =?utf-8?B?ZmdUSVNnTGVVSHZNVTlzcjF3aXBneUNWaXdISTRmdVNQVXZSOXFTRmZybWNR?=
 =?utf-8?B?bWgyN2g3bEtxQlQ0VmpKOUlxS3FmVXg1VmlxTVZSOFZENS95Szd3VkJxUG5T?=
 =?utf-8?B?RStjRTAzSmYxSkZRWjN5dmdFZzJVNTNhTGRnN3lBQUxidGtKMUVudFVranFu?=
 =?utf-8?B?WkhKNUFaNmhsWThKRFRydHFDSkFmTVVEb21TOW5Gem81MkVodHdaNTlaM2oz?=
 =?utf-8?B?UFFlK3FGS2hCZUhNYkRnRVVGc1hqYzBJS0NpQ29LbE9yQzhqMXNoY1BWbXd1?=
 =?utf-8?B?UHNzQ01GUDU2RWF1M0FkVU4rYUlEQVpCTUxCODBuUmJ5cFdQb3l4a09MTzZR?=
 =?utf-8?B?eVlzdnJjMGpVYmVpUU5wY2lrRTA2TmhCbnQ2blN3Y1pCYWcxcC9kZ3I5NDh6?=
 =?utf-8?B?aEYrNElVN0RzTGhjcHpCOG1OTEFLelU1SlFmVjNCUXRPMXlYYVNQYTNuNzJn?=
 =?utf-8?B?a1Fuamh6M2ZUdExGeEJwK2FpRjVvc3huWjJPZFVDWjBDUjl1OERMQmNJeHhl?=
 =?utf-8?B?NGxsMWVLWkFwT05qdTBUT2tXR0dVejJlaUhmOVh4TWhEWlIwM3dtYTVoZGNt?=
 =?utf-8?B?dmdxUjJuTzlxQXorM0trdk1WOGNDZFgvMWNPYVorTmhvTElYQVZPLzZUd05r?=
 =?utf-8?B?Q0crbXhWdHVtMTgrMWhRSjZJTituaXcyUjVQY3dFVTBXTU4rdjlEYkVtbWo0?=
 =?utf-8?B?VmdYa3pPWlRwZFBFRC84SEFSTmxZakszblB0ZDV6S0EvcGpGMEQ4T2JoaVd6?=
 =?utf-8?B?WWxOcGc5eGJlR3E1OEJMZDVTSzFyRHc5MjNqVy81TGNocmVvV0NQYVJZQ0hZ?=
 =?utf-8?B?RFc5OC9icktodmNmM0xMbjFkc0ExOFZQZkFiNzNGbSt4SGdYZ25YUkRCNlUv?=
 =?utf-8?B?VG1NcVcyVnBiOE8zUzJmT2p0MWhBOHBrUHl2TGVLZ09PWUVRZDFIU0lPNGRP?=
 =?utf-8?B?MXY5R2NsM2FQeXNYaFhOZENtZW43cEgyMDdDS3U5d3FWQ1RHT0hUS0wrZnJW?=
 =?utf-8?B?SFNwQXBLSjltWjMybTNWOG4yTlJUTXM1QjBMTmZPZXRraTh2ZGUrUVdxc1FF?=
 =?utf-8?B?RkFwRXM0azRkL29IS2xMY0dvU3dTeFYzc0tkbGZ1bmo3Sm1MaUkrbnVHZlQr?=
 =?utf-8?B?WEVmMTIvelBlU1lNT3VpYk9Ea3E3YVZRRmhnTlJOUGNwTjhTazVaOU83aWM0?=
 =?utf-8?B?RUtCYUdjS0hZOVM3SUVmQVhpUTlkZENmdmdMVU1jU2FvZ3JGR0lxcmFKd2ZU?=
 =?utf-8?B?OW9mQ3NaTXQvVWF1WW1LMzZzZjk1MFR5NEZIYzEyTUdzVVFUYlFCZi9ITU9H?=
 =?utf-8?B?RW1PUU9xVXZvK2N3UjMzUXJZa1M1NXJ4UnZHYUhSd2FTV1UwQkVMdllKNE1T?=
 =?utf-8?B?dTB1OTlwbmlTYjd4aDlIbm0waVRxeUh0SVBTMWszSTJkNFhmRkh5b3plRFll?=
 =?utf-8?B?Z0RVbzNGMzBiWWM5MnVvT3gvQTFUNFdYM05rRkhqeHVPa2ZMS29GTWNQVG1h?=
 =?utf-8?B?RlYrSzNXa3JHTkp6TVFjRVFidnRVUFpXckRmT2ZJVnVZTDhvOVFsR3d4eWkx?=
 =?utf-8?B?REkxekcrblE0N3h4S016LzBFbDU0YThMc0xDQll5c3RQVDZKalBGeENaOHA4?=
 =?utf-8?B?VHdiVmlvVU1ZUmRqdXFWWVo5SysyMnppM3Jkbjl2UnZsbEVlYmIyM2pLZVF1?=
 =?utf-8?B?ZFFhSDdiY0o5aGxBUWdVS0txOGQ2ZnJtZDk2TDVBNERCWHZpZ2o2K3dldEth?=
 =?utf-8?B?bk9kalhpWjV3U1VVeXdHYWRXV09jSzd4QmVDRFJOdHhVQnp1TTQ2NThlWlhY?=
 =?utf-8?B?WVRrN0xia3hIVTc5OXJ0Sk9PRG1aOFpvNHVlaUM1TEpmSkRDVE45b3lDWmVM?=
 =?utf-8?B?Qk5aOTBZd2ltMndZMUsxbkNZUVhmenBjd1RrOXA0d0NraTF1dXNBUHJhRDVM?=
 =?utf-8?B?eUg4S1h4TUJvOGNUbHMySGdjVEZCVW5pcWpqcGJ3ME1HWDBnL2pucFNPdkJu?=
 =?utf-8?B?SGxVdElGT1NjQTRiQU1jTVFrZXk0NkRRUU1rejRSQXRTekpGVjVhMFVIUlNi?=
 =?utf-8?B?azVBZlB3T0xsQmRiRnZVR1dwQjZ6bDY0KzJUMnVVUGFNTVpaRXpReitjdUp4?=
 =?utf-8?Q?SfwNhpZ+AtWrdoHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e861a8c-9ad1-45b4-1048-08de911b6ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 00:53:27.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdSqEUePNmE1yaaOs0Cwwktkt3ymM7U/LZmdRFLhb/H301v9xCtelF68NWv17l4RGaHkMby7c4BVEr2gr6hoH3h7tGm/gvH/xJ0s+Jb661G1OKCTqa4xj/O0gsfSBIPI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1233
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274835-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,esmil.dk,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.923];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:email]
X-Rspamd-Queue-Id: B777C390068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBEbywgMjAyNi0wNC0wMiBhdCAwMzo1NSAtMDcwMCwgQ2hhbmdodWFuZyBMaWFuZyB3cm90
ZToNCj4gPiBBZGQgYmluZGluZ3MgZm9yIHRoZSBTeXN0ZW0tMCBjbG9ja3MgYW5kIHJlc2V0IGdl
bmVyYXRvciAoU1lTMENSRykgb24NCj4gPiBKSEIxMDAgU29DLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2hhbmdodWFuZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vY2xvY2svc3RhcmZpdmUsamhiMTAwLXN5czBjcmcueWFtbCAg
ICAgICAgfCA2Mw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kdC1iaW5kaW5ncy9j
bG9jay9zdGFyZml2ZSxqaGIxMDAtY3JnLmggICB8IDU2ICsrKysrKysrKysrKysrKysrDQo+ID4g
IC4uLi9kdC1iaW5kaW5ncy9yZXNldC9zdGFyZml2ZSxqaGIxMDAtY3JnLmggICB8IDMwICsrKysr
KysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE0OSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9zdGFyZml2ZSxqaGIxMDAtc3lzMGNyZy55YW1sDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoYjEwMC1jcmcuaA0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9zdGFyZml2ZSxqaGIxMDAt
Y3JnLmgNCj4gPg0KPiBbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdz
L3Jlc2V0L3N0YXJmaXZlLGpoYjEwMC1jcmcuaA0KPiA+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9y
ZXNldC9zdGFyZml2ZSxqaGIxMDAtY3JnLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uNzFhZmZkY2RmNzMzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvc3RhcmZpdmUsamhiMTAwLWNyZy5oDQo+
ID4gQEAgLTAsMCArMSwzMCBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMCBPUiBNSVQgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI0IFN0YXJG
aXZlIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqIEF1dGhvcjogQ2hhbmdodWFuZyBMaWFu
ZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ICsgKg0KPiA+ICsgKi8N
Cj4gPiArDQo+ID4gKyNpZm5kZWYgX19EVF9CSU5ESU5HU19SRVNFVF9TVEFSRklWRV9KSEIxMDBf
Q1JHX0hfXw0KPiA+ICsjZGVmaW5lIF9fRFRfQklORElOR1NfUkVTRVRfU1RBUkZJVkVfSkhCMTAw
X0NSR19IX18NCj4gPiArDQo+ID4gKy8qIFNZUzBDUkcgcmVzZXRzICovDQo+ID4gKyNkZWZpbmUg
SkhCMTAwX1NZUzBSU1RfUkVTT1VSQ0VfQVJCCQkJCQkwDQo+IA0KPiBXaGVyZSBhcmUgcmVzZXRz
IDEgYW5kIDIsIC4uLg0KPiANCj4gPiArI2RlZmluZSBKSEIxMDBfU1lTMFJTVF9TWVMwX0lPTVVY
X1BSRVNFVE4JCQkJMw0KPiA+ICsjZGVmaW5lIEpIQjEwMF9TWVMwUlNUX1NZUzBIX0lPTVVYX1BS
RVNFVE4JCQkJNA0KPiA+ICsjZGVmaW5lIEpIQjEwMF9TWVMwUlNUX1JTVF9BREFQVE9SX1RJTUVP
VVRfUlNUTg0KPiAJNQ0KPiANCj4gLi4uIHdoZXJlIGFyZSA2LTEzPw0KPiANCj4gPiArDQo+ID4g
KyNkZWZpbmUgSkhCMTAwX1NZUzBSU1RfQk1DUENJRVJQX1JTVE5fQlVTCQkJCTE0DQo+IFsuLi5d
DQo+IA0KPiBJZiB0aGVyZSBhcmUgbm9uLXJlc2V0IGJpdHMgaW4gdGhlc2UgcmVnaXN0ZXJzLCBw
bGVhc2UgZW51bWVyYXRlIHJlc2V0IGNvbnRyb2xzDQo+IGluIGEgY29udGlndW91cyByYW5nZSBm
b3IgdGhpcyBiaW5kaW5nIGFuZCBhZGQgYSBtYXBwaW5nIHRhYmxlIGluIHRoZSBkcml2ZXIuDQo+
IA0KDQpJIHdpbGwgZG8gdGhpcy4NCg0KQmVzdCBSZWdhcmRzLA0KQ2hhbmdodWFuZw0K

