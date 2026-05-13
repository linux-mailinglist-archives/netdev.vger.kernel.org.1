Return-Path: <netdev+bounces-287368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHTGITfSA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:21:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94552BD4C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C57383028404
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221DA3672B2;
	Wed, 13 May 2026 01:21:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2105.outbound.protection.partner.outlook.cn [139.219.17.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B8357CFE;
	Wed, 13 May 2026 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635306; cv=fail; b=k2V/jGzmI2fE3VVvf+PYmch+PF0ZgmKOwt43wZs6nif29ON6uspzRLxLHUKVZNc5N5uvr7g2K7UYB/wcvjLiLiS+7WAmsFWWsDilsatIwquLE+F4ME6C/IEi/AMTsE1U6ozMybz7g8eetBDw0nI1rBz329RLVZcjDNDTzsD+hCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635306; c=relaxed/simple;
	bh=BboqmxO3Eo/VOFaDkT+QnP5MYrRwVQdxAhdD3Agz0c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ti/08gk23UBbMKs4/lfinf3am+vaC0VveaheKBSs9ijqB9NaJ7kYWP/+dmLg6BxRPQeSo8NLUsJfd/bdjgH1CE+T9fcjREXkWKgOiXh2WB1sRz3KxP18SY8FMb+8BpQC6zZKidxzHomZWjWm/vw+vYOynWw8jYm2fVl1x5HydMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmrSvlqCs2+o3S4vTgctDqclqhmez4FjWs6vSvhzRkoSLVNMHJ8f4JT3h+oZIBAJVYLLk6wbGzMVeV7cR/o7+2vIMgnG231Kma2NTIwKcYooODEOSRNHLP0aLZV+iIM/nwLt24pjJKmPsEZfz9zJzHaOWIvxVv+ase9LtvU8t/LgTfc6o9xr6kYH+gr/T8rCjezHV9O5pz5vZALPsCJM01OemrU6JMoGbQBq5L0h/aI0WlY+9a5IDWSnDDlPqTuTeuLMVizKUaeVmNe/VSbHDJ/cReinvYA5lDK6SRnuPljJlAqCQ9VJkSX1GyxZn3AI67cqg8t0MWD6+vRQdo+TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BboqmxO3Eo/VOFaDkT+QnP5MYrRwVQdxAhdD3Agz0c0=;
 b=QSD7OmKBegmFrtu0ol+B0kXgcXram3UXlYDyvTgxW2DKjyQxaCfqRVfPN3bA1d81oyufy0teCUxt/T8t7EfQESnfWO2x7GsaN6dNk31uxqid6+bDgFpMtNTugS1Z90PieSoMorkbI+u/mw910n4uamRQjOKMlqFxyLoJ4pVzeycJY+rDr3TJL/hIUhDMV3VF3oxvRTLNguju41z/XCl8JDO1R6R3nzTHDyY6kykukxry7yDKts17mNnE6JOMuosfx1DtkopC3avaEUXg1X9Hak9zKk9wYgqloC9iGqMVLCFlfCY5DbXwgOrLYnOFU9bQxXVwLJ1MK7xTsleCmB+wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0583.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.24; Wed, 13 May
 2026 01:21:26 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Wed, 13 May 2026 01:21:26 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Frank
	<Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net-next v3 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
Thread-Topic: [net-next v3 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
Thread-Index: AQHc3s9pNbgb+D71q0io2JFk0y5F17YKadsAgADGJ2A=
Date: Wed, 13 May 2026 01:21:26 +0000
Message-ID:
 <BJXPR01MB08552262471B03B1C53EADDFE6062@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
 <20260508094522.3952-3-minda.chen@starfivetech.com>
 <91f86e6c-6013-42cc-8a4b-2b32093b9eae@bootlin.com>
In-Reply-To: <91f86e6c-6013-42cc-8a4b-2b32093b9eae@bootlin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0583:EE_
x-ms-office365-filtering-correlation-id: 2de75234-6e39-4cec-4316-08deb08df416
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|18092099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 8a8RhNdRjjq2sTvjxKg+jEvm9vbP4cETx+4IhS9yy8og6zlmAaaXEBzJnJq1NQCNd6g3NW8CSBDYpZnDVHEzF0heK4zZYfvyTl0x4L4HHYWQVZSW1DAtEjvrv3KGfNqj22hwEuYZPK68okaec/Et69YWmcrHX75cx5ABqT3ehFSqGy4z3nQEZejLnbgmu0TGXp8GoE8sGm+ZLl4Ylrjow2H1FmLoPzcGXsdx2DHjr4n/iA0hD3JnytUsL7b1n97gQFfHUnSac0rCoOEX+V+UzC2dMirSpqjqqOV5P9zYDgztuiEFKBtRFQt8tVUyieD8ohyenutCIX7sL6RpAzSVtc778SFBEs2BL+jxhjABAT82y+mF/2augGfQfM6Va71GXouD25TdNfdU2lYvJU8DHpkl7exJXFN0P2UpA45+pACzNT9f4DYv4p7627Pc69qzE0LqVppEsA5nNALniPulX+vr2qkJoIWYTKAl1yDyCoL5+hlOx1+jhnepoqqkOaHZA/sxtEGWqfVztNXZkFIixCfdCoa6RDTE0qt9rvftGa2YdaxOtvDhYDcUuQUwBThl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(18092099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmltcmxORGhqYW5NekxxdENNcjIwVmwzdVZCbW5vSWpOaW9PcS9RaFU2ZVdu?=
 =?utf-8?B?WVRFYjRqRFVTQUdIekhJOG52VUNiTS9aeE5vUWdDWTlXemt5cFZweU5YMHZV?=
 =?utf-8?B?WGJMNWpPZmQ1RzRmNVI2eEFKQlRIVU1WZGxSZ0RhVDE2aWE1THdIR0g4akZ5?=
 =?utf-8?B?Q1g1ckhkZStSR0kwRUV0WHk1b3EzVWs3NzBYcC84WG9ucGd0Y290MmhiTEFL?=
 =?utf-8?B?MUNyWXZBOEtxNDltdEhaVWd0dzZORjFpaTltRWRpNGp6S25HSjJVeWdpRVQy?=
 =?utf-8?B?aHpraWdRL093eVczdU5tYk5Ud3lHb0lOdE1qMy9zL01hWHpuUlhKZnRTdE9F?=
 =?utf-8?B?KzJEelNrUFpyR2l6OWJBeFBHRGpmVGljWTlLZFRIQkdQUnZSMG5jWXB1OWVP?=
 =?utf-8?B?U3h0bS9HaFl4WCtnalQxdG1XLzVhTlZRVGR4L1VtUTdzeG1JeW16OHVKVlhN?=
 =?utf-8?B?d05EQ2tnVEZucXphYjRGR0hQTm1VT1lFTHRVYUZVZlc1MDRTVU0yVC9ISXdo?=
 =?utf-8?B?enp0bndNS0RrTnF1ZzhyTkJVZTZBL0N3UlVhN1JuL051emx0VG92V0srY2c5?=
 =?utf-8?B?UUx0aEJiV3N3dVhlTE1KRnV1TDEzMDFab2Mxb3UrREpTS2s3MHFHaHo3b0dn?=
 =?utf-8?B?Ymh3OWhLMmR0QWgrb0tybnJ2ckIybkRlUHR1dnNCWjVVblhCRUFTYURSYTNN?=
 =?utf-8?B?ODNOYlBsNWFQQ0E4NllIemlySkR6eGlyQXQrc3pYTFlyOVZYVjlkQ1FNanZs?=
 =?utf-8?B?MXJPOE5rZk9JS0xqbTM2TVBoRWZGYVhBWDI2QTVxQktFNFl6Y1dTK21CMlp0?=
 =?utf-8?B?TEhLNnhFQm5TMGkrNEZDUXBadU5ldFBBWEFlWjlVT1Q4ZmZzU0hsczNnLzBT?=
 =?utf-8?B?bE0wdXcxQWhkY1dHY2tlT1lFN2ZwRkJvK0E4WGhoTHJyZ1BmejdQS25saTJn?=
 =?utf-8?B?enNGc2pTZk9RazEwbllOVFFjL3V1WTFPSExueU1QYkRPbXVod1pKSlVqdXJC?=
 =?utf-8?B?aVNVWVpZaEJ3MmxHUDVFdURVK1BDZkhIeUlzdS9BT0JIVGFmemNuaDdGRG0r?=
 =?utf-8?B?UnUrR0JFWkJ4eGFPc0dFT01aTmYrWDFyMkR1ZkxyakYrZVd3cDdhZElxTmdw?=
 =?utf-8?B?cDZxeTd2R3VyUUN1QW5VSWNqZVA2ZVB5aTdmNnFKSHA2UTZvOTVuQkhSMExw?=
 =?utf-8?B?aVlsQjlxWkdDWk9WdGg3dzNYMmE1Q0xld1JGT3F3bm1xSlg3WklleGdleEs2?=
 =?utf-8?B?NkxCZVZKL2toNFVxT0t6K0ltdkN2SGc3U2JkR1MzVlFnTkdrMlpHSEMxQXJ0?=
 =?utf-8?B?QkJESnBDRTU5U0pnS01ZbDFualFkOUZqNGxqN1Z1cE1Nek81VGpJYWd3KzRo?=
 =?utf-8?B?TGdrcnRrSjdUR3Q3eEZSQWt2YlkzbFdhQTdpbzZFakFYNzZEcEdCUWtXVmdZ?=
 =?utf-8?B?VDNETzBIaU5EUGlkY3lBeStFN3I5OWxsZnlHTlhhTDVWOHJ5aXJ5S2RVYmh3?=
 =?utf-8?B?Mk9qcWkvd3MzdmVXVWJkVDZ5aTBpbEpyMGJRbXYwSHpVdU1EaXB0dmE5NjJO?=
 =?utf-8?B?YlBHMkIyOHIvWnhzUnU0aWluRU5hdHFRMmkybXowT2FMRWt3WEFlYTZ0dnFo?=
 =?utf-8?B?U29qSmNGNkIySUFTZElOU3dpYVBuT21vOHlaSXV1OXhPTDhSZXBjNG1rcGpC?=
 =?utf-8?B?MTNqZmg2QjlMN2R3T2czUDdUR2E2NDhtOTJ3SjViZ1hEcG5RRzVEeGhGNzJx?=
 =?utf-8?B?emlZV2hXenBQbmdIQUg1UUZRWHVqcitHNmVlWFNXMHpvcjJjWkpCL01tcGRo?=
 =?utf-8?B?S1F4S2FnNEsrSFk3Q1JSWVc4d2wrak5nV1JxMmNpZHRwS25ySzJsNjRFeW5E?=
 =?utf-8?B?MGpkbFc4TUc5eTZQcUl5elpyWU5rdEVQSlNwc1BSb09jWDBaclZQN0FPMjhz?=
 =?utf-8?B?cmZtMnk0UzFqL2RIMTc3czhiQWJ4S0tLbkFkRnA3SzEvQXEzUy9LbDh6bmQ4?=
 =?utf-8?B?QTdHM0l0MElBTDZoUXk3cE5uQnNsRjl4akN6ZGo4NnZ1eDBGZmlXZ09GWHdK?=
 =?utf-8?B?RlJVbWZmRzhaanQ3Y0VsNUVRc0NBZ2JZZDE2d0FJVlRnNGp1NVpYUm9lbytj?=
 =?utf-8?B?L0o4bTZXM0ZIZ3phR2FrZzNhQVVGTmtYbWIyUmpzNEphb0JScnFXWVQ5OHNl?=
 =?utf-8?B?aklyYjVrWUFWVkZJZnR0L0pKb2dhZjlMUHA5UitGMGw4UWlVOE5hRTNCaGpS?=
 =?utf-8?B?Q0ZEMGtKbnNxcVp4eStWbmMzNGtlekh3UFZNV1B4UXBVYXZxcGJQNlVTcFpZ?=
 =?utf-8?B?ZTdDQWxOSTByeHUwQXczRXNpUC9KK1FySVBHdmtDbVJwTks2bzdqTWwzaVlE?=
 =?utf-8?Q?kWDaziVGlt9KS8QM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de75234-6e39-4cec-4316-08deb08df416
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 01:21:26.4598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xxq3H2veqwf4+IKEU+n7UuHS/K27ihIaSYqGxXZKTgLaggc8DMeJrWcF0p0CpZNyvT+jxd/lCnUVeljm+Re5GEORG9VDitaz6wd61BiEvJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0583
X-Rspamd-Queue-Id: 4C94552BD4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287368-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

DQo+IA0KPiANCj4gDQo+IE9uIDUvOC8yNiAxMTo0NSwgTWluZGEgQ2hlbiB3cm90ZToNCj4gPiBT
ZXQgUlhEIGFuZCBSWCBDTEsgcGluIGRyaXZlIHN0cmVuZ3RoIHdoaWxlIGluIFlUODUzMXMgY29u
bmVjdCB3aXRoDQo+ID4gUkdNSUkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5kYSBDaGVu
IDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25l
dC9waHkvbW90b3Jjb21tLmMgfCA1ICsrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L21vdG9yY29t
bS5jIGIvZHJpdmVycy9uZXQvcGh5L21vdG9yY29tbS5jDQo+ID4gaW5kZXggYzY2ODA0NTM3YWEy
Li5lYmMyNGY1MWU2MjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21vdG9yY29t
bS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5L21vdG9yY29tbS5jDQo+ID4gQEAgLTE2OTgs
NiArMTY5OCwxMSBAQCBzdGF0aWMgaW50IHl0ODUyMV9jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2Rl
dmljZQ0KPiAqcGh5ZGV2KQ0KPiA+ICAgCQlpZiAocmV0IDwgMCkNCj4gPiAgIAkJCWdvdG8gZXJy
X3Jlc3RvcmVfcGFnZTsNCj4gPiAgIAl9DQo+ID4gKw0KPiA+ICsJaWYgKHBoeWRldi0+ZHJ2LT5w
aHlfaWQgPT0gUEhZX0lEX1lUODUzMVMgJiYNCj4gPiArCSAgICBwaHlfaW50ZXJmYWNlX2lzX3Jn
bWlpKHBoeWRldikpDQo+ID4gKwkJcmV0ID0geXQ4NTMxX3NldF9kcyhwaHlkZXYpOw0KPiANCj4g
TWlub3IgZGV0YWlsIGlmIHlvdSByZS1zcGluLCB0aGVyZSdzIGFscmVhZHkgYSBjaGVjayBmb3Ig
dGhlIGludGVyZmFjZSBiZWluZyBSR01JSQ0KPiBhIGJpdCBhYm92ZSBpbiB0aGUgc2FtZSBmdW5j
dGlvbiwgYnV0IGl0J3Mgd3JpdHRlbiBhcyA6DQo+IA0KPiANCj4gCS8qIHNldCByZ21paSBkZWxh
eSBtb2RlICovDQo+IAlpZiAocGh5ZGV2LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RF
X1NHTUlJKQ0KPiAgICAgICAgICAgICAuLi4NCj4gDQo+IGNvdWxkIGJlIGEgZ29vZCBpZGVhIHRv
IGNoYW5nZSB0aGF0IGNoZWNrIHRvIGEgbW9yZSBleHBsaWNpdA0KPiBjYWxsIHRvIHBoeV9pbnRl
cmZhY2VfaXNfcmdtaWkoKSwgb3IgZXZlbiBhZGQgdGhlIGRyaXZlLXN0cmVuZ3RoDQo+IGNvbmZp
Z3VyYXRpb24gdW5kZXIgdGhlIHNhbWUgYmxvY2ssIHByb3ZpZGVkIHRoZSBvcmRlciBvZiBvcGVy
YXRpb24NCj4gZG9lc24ndCBtYXR0ZXIgdy5yLnQgdGhlIHBsbC9hdXRvLXNsZWVwIGNvbmZpZ3Vy
YXRpb24uDQo+IA0KPiBNYXhpbWUNCj4gDQorCWlmIChwaHlkZXYtPmRydi0+cGh5X2lkID09IFBI
WV9JRF9ZVDg1MzFTICYmDQogICAgKHBoeWRldi0+aW50ZXJmYWNlICE9IFBIWV9JTlRFUkZBQ0Vf
TU9ERV9TR01JSSkNCg0KIEkganVzdCBzZXQgaXQgdjEgbGlrZSB0aGlzLiAgVGhpcyBmdW5jdGlv
biBpcyB1c2VkIGJ5IFlUODUyMSBhbmQgWVQ4NTMxc++8jEkgZG9u4oCZdCBrbm93IHdoZXRoZXIg
WVQ4NTIxIGNvbnRhaW5zDQpSR01JSSBwaW4gZHJpdmUgc3RyZW5ndGggc2V0dGluZyAuIE1heWJl
IG5lZWQgRnJhbmsgY29uZmlybSBpdC4gIA0KIEFuZCBBbmRyZXcncyByZXZpZXcgY29tbWVudCBp
cyB1c2luZyAgcGh5X2ludGVyZmFjZV9pc19yZ21paShwaHlkZXYpLiANCj4gPiArDQo+ID4gICBl
cnJfcmVzdG9yZV9wYWdlOg0KPiA+ICAgCXJldHVybiBwaHlfcmVzdG9yZV9wYWdlKHBoeWRldiwg
b2xkX3BhZ2UsIHJldCk7DQo+ID4gICB9DQoNCg==

