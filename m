Return-Path: <netdev+bounces-256121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM8lEyyEgWmHGwMAu9opvQ
	(envelope-from <netdev+bounces-256121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED6D4963
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09686301FCBF
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9823570CC;
	Tue,  3 Feb 2026 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hH50oMxv"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE6335555;
	Tue,  3 Feb 2026 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095655; cv=fail; b=ZbwjXI5hRdHdrFkjRZ0V2l+/0/V40T7ve4Z91wTCYThFCUNFzaZTVZPe4WIV7eLF+vvie0uwHoTO9P7WAj37fbMRJNIlnCbjILhr34sQYD9y/sRpdyUvWL6djEPA9TuxxPCGQeOLhw9rTLhqkDRDM3wMYgdIktQckcULTuHLX3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095655; c=relaxed/simple;
	bh=LCVXIY6LyQu2IvGCDgywPwp7TRMj8UM19+0ibZLKf7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufuwfSydS8C+ropdneuWKiTIU9frM06rjQdP4yoweZUWEIkexZ3H+cbOcYkzu7rVuSPH3oHwEvmu760tk5Ey/h0rGoRTxk2Ymxa5Bn5pgA/nzRIcqXECTdySnTyzHx1YFt5O9wD6rTAzmIEd7E1BLgcOdSvvAnthAvnQApNoUMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hH50oMxv; arc=fail smtp.client-ip=52.101.70.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oslxRpkJ5oB6mWM4fpG5c3mEIZZs1o9a88zccAzePUx1CpqQ9tWneMV74UHSUQF6u3W03kAFRkaPm1hRFc5yQTtK8joVIjgQt5Y9VlbOeyfdGFRd5+6F15qWScmxuIq9KRBCycHsuUu6HR3jbJ5zQmmyQA6KoHnchMk3z02tsDNUYuf/2A3ybBj7RoStTO7ZzK7fx1trJjkO+NHBctZOUtyAL31H7/SRwuhBhNtdgES8UH08eYxx5eSGaELyfdIOTCJ0b91rTyDprfy+ggdKnj6wwU9UeGism/CbtvbjvjkUGDLxsykhDNzl2VtUtyp5UK2zqTgPeNCI7gDLI0Vl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrUANSG8duJTailFsfsaoeN4hz4wRRNRHZC5OD/v770=;
 b=Dax+lDN6XJjLiCaVBD/WDbSTwPMTYUfaUBPx4hafJMc65VNNkXFDsVwq4TA63rpejCKaZxum3BHJKgKTR+5784LsQ4n8RtpTjz76Oi/sjYffFEO2gunv7bnYIsHjBSvgcBcy4pQgSLVyWDDF60TkAd+CSGv6WJmDlHkBppJT3+WV2ZjJYknS6HlId8Ar0ddVl2HwVlaV4WrqubAFRuryJEMBqcsGGScVA0KMYzC0EjcJeGv9ZWuNg7ftFYBX0339bJGyKydmCL7sYHMGZ+15zSnWaJjlCgvGVh6qGByvRJx0DWzvX9in+59MCITBnkNetaCt+AdXQaSGWGG6ZBdO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrUANSG8duJTailFsfsaoeN4hz4wRRNRHZC5OD/v770=;
 b=hH50oMxvqd59nZLHUwCTk17OBmJzOvMaVPzg2+Yi8LweHT3syie2uMG95sGeCPs/rxs6aR8WBs0Qkkey0aFJDt050lKgJrUAX/d2uIIlLOV/vGvFNSrwuqUoCEfhmDh851+v+kM4KNPCv/Z+jCJP0i9WKhp1NRymNKtxs0OEk09s+L9cRGJhOmnhQLBpWqBLZMLLjqpeVdcFS+xLPzfqIHOL3Rl2jXUvJs5J6udfmgRlOI20TejXlisipaMJNcQxw8RGbcqexOc7qEGMm0nTbJlY90vI9AY4KM2d5kJ6xKX+FHRhAp0SoPQ3Gx/5Y0L0uX1UT6DdbRa5FFE8nzcC5g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB12292.eurprd04.prod.outlook.com (2603:10a6:150:2c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Tue, 3 Feb
 2026 05:14:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:14:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>, xiaolei.wang
	<xiaolei.wang@windriver.com>, "quic_abchauha@quicinc.com"
	<quic_abchauha@quicinc.com>, "quic_sarohasa@quicinc.com"
	<quic_sarohasa@quicinc.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: phy: change devlink flag to
 AUTOREMOVE_SUPPLIER for non-SFP PHYs
Thread-Topic: [PATCH v2 net] net: phy: change devlink flag to
 AUTOREMOVE_SUPPLIER for non-SFP PHYs
Thread-Index:
 AQHclAb3Uf0SquSmoUu8bgtfEahNs7VvQRSAgAA2VYCAADYbAIAABg+AgAAKZgCAALGB0A==
Date: Tue, 3 Feb 2026 05:14:08 +0000
Message-ID:
 <PAXPR04MB8510CB77C95D4D044FE62C64889BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260202054533.539883-1-wei.fang@nxp.com>
 <267c78c1-4ad2-4f06-be63-0fb506c5134d@bootlin.com>
 <aYCzxVTTZvok9_d1@shell.armlinux.org.uk>
 <0689a2ab-352a-4275-9662-0c45daf8a0b2@bootlin.com>
 <aYDmPUN5Z-eRWW2K@shell.armlinux.org.uk>
 <5527e953-2225-46e7-9619-5f346c1af9c0@bootlin.com>
In-Reply-To: <5527e953-2225-46e7-9619-5f346c1af9c0@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB12292:EE_
x-ms-office365-filtering-correlation-id: 3c97dab0-873b-4b39-c19e-08de62e30f03
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XB2OjaQr/zDA/hh/D+9Cq54aw8+AX5p6jKsgHBe+oewnzEmAXfx0dwmvqdoo?=
 =?us-ascii?Q?tNXKpj9UD+QUacOurWnIHk0Lyr6icIEZ73HI6j/ND1l7Ff5q8PfHdNJldZfZ?=
 =?us-ascii?Q?Ez0vpZ4hdgamcxNdlYRgHlymKCjULhGWImtG2NY87GnIFtZR8LrHVCT6e323?=
 =?us-ascii?Q?YnQQwLvAbHNuoW1W0uZM4oP2S1rBeczBkBgsOhO1hBqqoXQykMeBC2qN6Ddz?=
 =?us-ascii?Q?lTQ5UKq/1GowF3Q2yPJ7o7KxRf3zSlO6brJp9gZIoEJmnepmuriYi135nMnh?=
 =?us-ascii?Q?DNWaerYQUx1XJwWRRuQjn4IZB+dGNhugFz8PNxRx5OutdOvKmF/0MD40Dxdg?=
 =?us-ascii?Q?vFxmtIUDsezwLi7uypuKn2XXmmeVe8MikbrePAc40L/9PPlmg5qGl1ilwfWL?=
 =?us-ascii?Q?YhHHn2q63UER62NqyPLx2RR3tKKmiKdZ9i7Cl0sYKiSf5AgARqg/5CBq6GAV?=
 =?us-ascii?Q?yfDfLf2Rcpeo4Dg4TAZzYaon83j0LlRH8GMUiWd+8C6EkXy2vI6yVSSk9/lR?=
 =?us-ascii?Q?+kSTLgXGI5kED6ZBytGNLcr1We7a64zycxbKyFfPcw9rSHrzaxCzgBgV3Jid?=
 =?us-ascii?Q?+VqgNhEvYgMIRs5mnfB+rHRYV2mt/wksYaJbnBfSJEMFZSQzNYIstooTtKCR?=
 =?us-ascii?Q?l1DcAw8klK1HkX4Ld/KehDMdI8HnH88kgWMNjGstWgC5reRay6ylskkKGy+H?=
 =?us-ascii?Q?Er7JNcT8af/qm1qYXnMOoBHbH4JxaY6sQrVtf3Ejk2iLPu6x1EcHJOZJYOJ0?=
 =?us-ascii?Q?AiunuS954+0MUIj5nQmsAb9xsnmXxeioKBYVIuo1RX6hGOhcGrR6JnVK770/?=
 =?us-ascii?Q?qt0d+I0vbIaD3zxSTZTj1+7TVzi5Ip8vFyb2N+UseL4RdFJf8pzrXtm9YPLu?=
 =?us-ascii?Q?fykpkBIDKItIMjNQJYY0APIKC40D+5sAEeU7r5HOiKFcWe6GTwFR14/PMs/Y?=
 =?us-ascii?Q?NC460JXFnhAvvUGlzu4ENYmzzK2MuLdgOGxI2ciNmDzSbGLYjAUpEM5FNS4Q?=
 =?us-ascii?Q?xYZQVEcl5J6nDC0wfxxyb+o2b2dqfijGNciXJOnjQnhnFx7SM5Zbo6I6iTVF?=
 =?us-ascii?Q?lXHCB8D8qNyDSDuIvuH0Jc+VXFos044Td8FPCQ9NSJAIMiftr4Cx25svc7IM?=
 =?us-ascii?Q?vr3JngHf6AxS+nZlaJZAKPYNYwOU176kdWb4HiOS+01PT6Ak+6l7XWZ3IZWS?=
 =?us-ascii?Q?G6gkzPXpd9fOOhz3A+4W0RwDuX5I9XFuYBfNIo824YNLXAWL4SK0MxmT2R2f?=
 =?us-ascii?Q?D7R9uG56TmlU0hxuVpP5VFMn7oBoyxwZWEstZJaOy7XPHyLBrT7KFBvskown?=
 =?us-ascii?Q?S0i/+DOF+itR6QWcuVxbe6O0nyEWaJyJPNTt4W51zYmdx4GlL38B7bL0Xr3r?=
 =?us-ascii?Q?n98Qtj4fqegVNlsgGF2aU4LjjGKLcmkXM0OwbdKfLrpGokA4/gb6MoAP7DXl?=
 =?us-ascii?Q?nqd3MQCNcvTFwEBfWPOkseLInYu95kGjwK0pNb+vluCmFJMXwSYfu4cuKNMq?=
 =?us-ascii?Q?cPN1RIuWKhpdpOuGr73TwwMn/EM7IPCyBHJ3uwKo7QOStO3fco9Rdc/7I1Qu?=
 =?us-ascii?Q?Xi45OTDAC12ZZMHk+Zs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VTMm9nr9NGDlfJBGliEbSudYUqjUk3FVawXR1fcL4eTJbJHK1ITVxqdOJjGk?=
 =?us-ascii?Q?SuaUXzoPRT1+RR7926hEP6VCv3z01HDUjKhjS1a4ODCQ2lXfQLWrO+1yzgeF?=
 =?us-ascii?Q?d3Y658uTIa6lpAuPRQtqudBCqvVThHybfNFr0RGSLIM12Oi0b6xZK3/q1Qa/?=
 =?us-ascii?Q?8fB06W67dhNsS1tBeVEFT67/LYL34qEUlVeQPi0Q5Xlo9h8vfP1KcHQJHUFH?=
 =?us-ascii?Q?pDP4x86YYE33LD4U6iYK8y/2xC6cOf5D3UEtEL2r2zbMoULZSE5lZSui7FaX?=
 =?us-ascii?Q?Kf6SPPh/soB0NLkzysm/V9pel/HnYDQfuP4HCjV3tieveWA74MqJ9eXhaOWh?=
 =?us-ascii?Q?WBSaIlsa2N4lP9rDnRpNRFwZ3yk2dfizf4DvgfkUcG7BjkJ5q3bIkliGq3xo?=
 =?us-ascii?Q?BwVviKtmPE72GpV8Pgx7hZcYQ9iBBD9UGwlkVMCm2VBhAdxEvbHiTP2ebcF6?=
 =?us-ascii?Q?gMFH+NS1JaM/ktaqSXGOZhw2/BKmCZ/e7jetA0fiIm3A1lXtxiQAmnu9KXK1?=
 =?us-ascii?Q?CKVG49cgpYC4U+HN0ZmgCXFeCTL4V7GZf07WubMs3T+our8tNq+lsY0f0VCR?=
 =?us-ascii?Q?3OviFzxz/wxTIddedLoMbd/JtnV/kHebUN8/UV8FmZ8mDnvz9IdqF2Bcpu+n?=
 =?us-ascii?Q?R32dSfqg2jmrov7cqKtgQxeYPXrw0950nZvMTYTJaxSr/SJSTv6PmUyqQNT+?=
 =?us-ascii?Q?vCNPD3coqVPQlaW7uJJrcdRsEXau8Q+FY1dC8G3GunE6S0Abj6IBytApR6G+?=
 =?us-ascii?Q?oGEFD9hQcYO6jStDrduIFTT2/kDmlaXze+jrg/1/dLzRUecEis1KBvW7P01Q?=
 =?us-ascii?Q?JTAOgIL7ItPT9EGEeH8XcXMnsD/3vtdjfWG8gsz+XCHtlQIWkaWEFPmIF9bv?=
 =?us-ascii?Q?+qTx79SssUN67uUfERAvEdXKByipr2NmJBWs+hxIt/V+lDS1wI43QcAjwMJB?=
 =?us-ascii?Q?c3JOEL9dGLbtb6ZEQQCa12LrF6LkR5LBP776gqOuuhplFmC8H7VchgzHB0cb?=
 =?us-ascii?Q?fxsfWcfAtARv89t/fHh7GJgtfHVDRRPjr1e/EGRb1Ur/5d71sYDrwtRMP2uz?=
 =?us-ascii?Q?tBG4bpy3j94hLAGWYGt5nOq6JUbrCLD4NyGoxXAa6MgVKMTt3ff7IS3tkCmv?=
 =?us-ascii?Q?8Hq4oV+VWZ7CGA+53LPhWqZBiNepCGIt+lp1IFd0ksmDk00EhCz5ho3kM72f?=
 =?us-ascii?Q?EgSD49zF/t1xiuS92AMG9dRZe3Yyj4FRGVhn1xWek4mGbcT23EXbygksTQIw?=
 =?us-ascii?Q?zSkrHgrxqvtGe9hlO3xmLExrVNpjr5s1/y8uiZfn/Pq9A5NH72GG9x5OGlGL?=
 =?us-ascii?Q?ZGJnrwbWRSxbe7+7NE+q3eynRqMjQ0v0OKJ15uR3a1HybBxuXBUz8sANw610?=
 =?us-ascii?Q?/vUMyu6o/FZaDYtoDWHWCO6mKJEUEQWup5AFadU8T/nTURBRKyj8u+ENkL2I?=
 =?us-ascii?Q?ZOTAuBnZAQDCXqsabA2sU7SEUiVmwQ/R70pRkzZ+N2SLzBdeXtabJD6wAd9w?=
 =?us-ascii?Q?fm6QENhHJ1Lb4nMPRVUOLCBAVv/fgVV+ubCS52hJA4JMWie0op0A74eMQ8Hz?=
 =?us-ascii?Q?8uvO+1gtN0OzlMZrOrHuPDtCa5PSedW2KhzSjDs/ln750VCP/kfjTx9AuiUu?=
 =?us-ascii?Q?/EQtboMoFnk9jYi2GLp1Op2gNjGuSJH9VOncemqg1Etj1o2PoRk0KD67Bqn0?=
 =?us-ascii?Q?Nz+IHhyPpiBK/T0amXjyeFYxtL/q6AuoTzL9a+/yqqusjcNr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c97dab0-873b-4b39-c19e-08de62e30f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 05:14:08.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37pJZsFzxW1FGE+cGbGwFfi65SQFBzn3+jg7QZuhFgFhWDxBXYzRIoNG7csqn3Oi8r2uOeMz1NajSrICeWaynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12292
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256121-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: B6ED6D4963
X-Rspamd-Action: no action

> >>>>> For the shared MDIO bus use case, multiple MACs will share the same
> MDIO
> >>>>> bus. Therefore, these MACs all depend on this MDIO bus. If this sha=
red
> >>>>> MDIO bus is removed, all the PHY devices attached to this MDIO bus =
will
> >>>>> also be removed. Consequently, the MAC driver should not access the
> PHY
> >>>>> device, otherwise, it will lead to some potential crashes. Because =
the
> >>>>> corresponding phydev and the mii_bus have been freed, some pointers
> have
> >>>>> become invalid.
> >>>>>
> >>>>> For example. Abhishek reported a crash issue that occurred if the M=
DIO
> >>>>> bus driver was removed first, followed by the MAC driver. The crash=
 log
> >>>>> is as below.
> >>>>>
> >>>>> Call trace:
> >>>>>  __list_del_entry_valid_or_report+0xa8/0xe0
> >>>>>  __device_link_del+0x40/0xf0
> >>>>>  device_link_put_kref+0xb4/0xc8
> >>>>>  device_link_del+0x38/0x58
> >>>>>  phy_detach+0x2c/0x170
> >>>>>  phy_disconnect+0x4c/0x70
> >>>>>  phylink_disconnect_phy+0x6c/0xc0 [phylink]
> >>>>>  stmmac_release+0x60/0x358 [stmmac]
> >>>>>
> >>>>> Another example is the i.MX95-15x15 platform which has two ENETC
> ports.
> >>>>> When all the external PHYs are managed the EMDIO (the MDIO
> controller),
> >>>>> if the enetc driver is removed after the EMDIO driver. Users will s=
ee
> >>>>> the below crash log and the console is hanged.
> >>>>>
> >>>>> Call trace:
> >>>>>  _phy_state_machine+0x230/0x36c (P)
> >>>>>  phy_stop+0x74/0x190
> >>>>>  phylink_stop+0x28/0xb8
> >>>>>  enetc_close+0x28/0x8c
> >>>>>  __dev_close_many+0xb4/0x1d8
> >>>>>  netif_close_many+0x8c/0x13c
> >>>>>  enetc4_pf_remove+0x2c/0x84
> >>>>>  pci_device_remove+0x44/0xe8
> >>>>>
> >>>>> To address this issue, Sarosh Hasan tried to change the devlink fla=
g to
> >>>>> DL_FLAG_AUTOREMOVE_SUPPLIER [1], so that the MAC driver will be
> removed
> >>>>> along with the PHY driver. However, the solution does not take into
> >>>>> account the hot-swappable PHY devices (SFP PHYs), so when the PHY
> device
> >>>>> is unplugged, the MAC driver will automatically be removed, which i=
s not
> >>>>> the expected behavior. This issue should not exist for SFP PHYs, so=
 based
> >>>>> on the Sarosh's patch, the flag is changed to
> DL_FLAG_AUTOREMOVE_SUPPLIER
> >>>>> for non-SFP PHYs.
> >>>>>
> >>>>> Reported-by: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
> >>>>> Closes:
> https://lore.kern/
> el.org%2Fall%2Fd696a426-40bb-4c1a-b42d-990fb690de5e%40quicinc.com%2F
> &data=3D05%7C02%7Cwei.fang%40nxp.com%7C676fc8b469714ff8085608de628a
> 2c93%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6390565427624
> 56857%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C&sdata=3DK1MW48la2uCeS%2BfO1H9joRudm9VwdBYL5pb1DqmFio4%3D
> &reserved=3D0
> >>>>> Link:
> https://lore.kern/
> el.org%2Fimx%2F20250703090041.23137-1-quic_sarohasa%40quicinc.com%2F
> &data=3D05%7C02%7Cwei.fang%40nxp.com%7C676fc8b469714ff8085608de628a
> 2c93%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6390565427624
> 82009%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C&sdata=3D692k06Lm44azC%2BgosFwRwn6QPXHC56iuodxYhg%2FZNgM%3
> D&reserved=3D0 # [1]
> >>>>> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac de=
v")
> >>>>> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >>>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >>>>
> >>>> I gave that patch a test, with the following cases :
> >>>>
> >>>>  - On Macchiatobin (we have PHYs that share an mdiobus).
> >>>> When unbinding a PHY, the MAC dissapears as well :
> >>>
> >>> Correct, this is why these band-aids are harmful. One "device" can
> >>> correspond with *multiple* network interfaces, and the loss of one
> >>> PHY can have a *very* detrimental effect.
> >>>
> >>> Consider the case where root-NFS is being used, and removing a PHY
> >>> on another interface takes out the interface that root-NFS is
> >>> using. Your machine is now dead in the water.
> >>
> >> That's what I've been seeing. I unbound one PHY, it took out 3 netdevs
> >> and I don't have log regarding "why". I guess there's devlink debug
> >> knobs for that, but not enabled by default it seems.
> >
> > See what I said above. "One "device" can correspond with *multiple*
> > network interfaces".
> >
> > On Armada 8040, one network "device" has multiple ports - they all
> > share the same packet infrastructure. Each port is a separate
> > interface in the kernel.
> >
> > Consequently, the "struct device" is common across all ports on one
> > of the CP110 dies (there are two dies.) If one triggers an unbind
> > of that struct device, then you lose *all* ports on that CP110 die
> > whether or not the others _could_ remain functional.
> >
> > Consider a DSA switch, which has external PHYs connected. Should
> > unbinding one port's PHYs take out the entire switch - and in the
> > case of multiple switches, cause the entire switch tree to be taken
> > out?
>
> Don't get me wrong, I completely agree with you on that, it's pretty bad
> to lose all these interfaces in one go, and the debugging experience to
> figure this out on an unknown system doesn't sound great.
>
> > This is why devlinks is a bad idea. It's too heavy handed for cases
> > beyond the simple "one network device per struct device" model that
> > doesn't exist everywhere. For simple cases, yes, maybe, but not
> > where it means that taking out one minor part of the system destroys
> > the entire system because it chose to unbind a multi-interface device.
> >
> Fair, fair.
>
> I think you gave enough pointers on a way forward then.
>
Thanks all for your comments, it seems that this issue cannot be resolved
in a short time. I will think carefully about how to better solve this issu=
e,
and if anyone proposes a new patch before then, I would be happy to help
verify it.


