Return-Path: <netdev+bounces-292082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rFsjKTdjFmpamAcAu9opvQ
	(envelope-from <netdev+bounces-292082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:21:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F133F5DED6E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A9E530151D2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE6C33C18E;
	Wed, 27 May 2026 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="doMvR+1C"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C926F289;
	Wed, 27 May 2026 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852083; cv=fail; b=fuMkIJVb/eqEmLSVkrrQA2S+De8ksIguIP7kgui0Oh4jfV9Yv25mEI2aSCHKEqgcOeSZuT7D+zeZUGaaoT7TGt1bcEJ5qvM5TIhs27OZH4szSQKfnqPTr2GGHvGiiWxms+nlcgwFnWZnKROO+hfczr6y6vlm4VUJXUNpBMhi3VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852083; c=relaxed/simple;
	bh=vFJgcE95mstru9G21fbdkA08587Vq9b+9SgDa+m5zFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UoMjmFjF8wHl9B62tPOD2LOI3Yp4zSU43WaTEq+VwNTr85ZribrurmToT3zW8e5W30Y67+y9bhyzOx2UsPvYrec8oBGLZWryOGELUPqNzjs3dfcxdimnFJJ3N+YVJmD8BVR+84IhdqGHrlM8D4sgl984AUlkp7/h2nVaq4ySg+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=doMvR+1C; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9v1StVaVi4hZB9A1nmDnUDsX/punbVNp17xJMNdZ7JsT+HWGHMW9Qdzd5NSH+DLxQmNNt+sXmZXu9+2WznyTkNRnVOvQJ2UDnIJ2/EHqX0+XjhCRrBh6ROQdbudwIiOeFQ/TDjZbEGeDLWxuHToXiv8oYfbkdIfV4Airq+bgSUyijsUhGEC+rHMuB5R6xm9mOZH9qNIo8f9kJDcDmJUEpXqqZn5FDVW2s5Ekm4Cj+NXT5O1MWBzN2k9G9gE6BJM97CKqVBPlfQGA4hvNHm1A8f6755vq05oBDD/Ls9UFXMi2eVV+jF9LY382i1Vvlk6ZkMwke/gX6DLDV7hvPcxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWMGdK6k/S6K4ai38+GSvJvE8619fYEv0WfHQWDxWw8=;
 b=Xxm9T48h6aBYxMEdw0v1zflENwL/KegT+DwmgAzEjp3gOhQe2QuuI1MVg5sgcfdVg/NauzTA/2KDWRXdCkxgYFZtwRtO+Z0ek0FIRGJsvDI433iRrympzMCiDSg7SdG9EbtQk3sno0yZ+BfXu5Z/lfyZ0zYu7ehJ6j4IlfzLV2Evgb0EVF3oNXyQRTqvxqn7rdqxokYNT8sZZy9zcAip0anRLiqpmXNzQyQmVfCPZOStVcJVlpjke5FZ4T6hVN3k7sjBgMu1Squ4wBmonD3/jBskkxV+pVE7Hr/3jK/WEjj+DF0oTU+Px2h4EYaesJ+8YaAuFgW0fAve+QnixFB4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWMGdK6k/S6K4ai38+GSvJvE8619fYEv0WfHQWDxWw8=;
 b=doMvR+1Cs+SSHLH3Ur4FcfPBXNOgzQ4B4N5LbrFuhIIK2IrKOC1VZ32/OyJj9xD1NciwBxkidTWsg0GKc6Sgtn16S4any7x4vYZlgSq2+0NaWi52j2IrxQpxa0dBtUBvwWKASgFy6Z9hmBaNUUS81odesEwhABUCE8QC1NFTzDVBeu9747zEjN4ObLqdR1AP5hugNUYxbhyJ9YvHPKMezuf3wINVh2tcl8iLjmqSp1EgIbaoAtHG8yreOa1eraMoxCOChC/LGz526JEjOtadZmADi9Gj1pzC2a5tFcTVEwHxeZc7wHxZ3W7uQTID0xeBwf+nD0DX66Q5PNhHt13Hsg==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 03:21:17 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 03:21:17 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] net: lan743x: add RMII strap status
 detection for PCI11x1x
Thread-Topic: [PATCH net-next v2 1/2] net: lan743x: add RMII strap status
 detection for PCI11x1x
Thread-Index: AQHc7SYifN/xJzconEuvqJDI+dCjubYgglKAgACwpcA=
Date: Wed, 27 May 2026 03:21:17 +0000
Message-ID:
 <DSWPR11MB97158A7DDD0C53EA9E221AE4EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-2-thangaraj.s@microchip.com>
 <8eb1d177-b176-40bf-a77d-434aa2b9189e@lunn.ch>
In-Reply-To: <8eb1d177-b176-40bf-a77d-434aa2b9189e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 14963cd2-9c5d-4461-49a7-08debb9f03f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 zjlu3VONhyG5EcN95kLFHoi5BRtxfovQX5f4F3OGbd81K02bcYcljaZUh6yTB2n7PK05wm0JO16C5E99vQcpDed4Kk9Gg/L0Lwj/dcJNL9u6KukN+QDSEknExEPqP7I2qrjv3oIpg4UFfsXPJRno9nto3PPQRwCoLv/8pwS60Vv1lKyZSP/xsBJfwZ+b8Zp9nx9gekyayax/sQEG3UXK0EY0MxKL7AcbdHfQSSagiksFmlPUec1ceLq8opOsPz/2fHo/MlgOGjtePU/RKZ3iHsbYBbchSETe5vmcmJEblsgCg2+kPcR7SOctl3kh2i2gdvubecUG0tcESu0honVIoVNHhp5y1UucO/2tWf8gRI9jM4UF4TiB8ItB7o3MtFygbMyaneCAUoMzOWzEn1e9Xadi6prrNOROuXZJYoOlwI1mBnaHhJilkxEqmZMxjZ7OnFEWq1AU81X3b/w738pJbzt7DlurjBzDxNvrNdtWWFMCDZqNIOKvMpugY00SSuIAKSnpeDtvdHtiuGTlZoYGbeVbfZnzFiRwy8c0e326cEDGpN43ytiXplPi4vho4PNMHvR8pGrHVm3XomPivv3QcgYWzVFxSedN/V/rrMG0HJhLjoX08kFTi8tIYd5lsewXe+YL/k45ktZtJQ9vXJii9XY6UuG18skwliTyvQl1GsTAGlpxYHtUrzMAA5t04olKTk75BLduEMg5rqDY9SXJ4UlBz3UZX//gFQh55xdDgOlUKbpKw1fazdERov8zKI15
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9+QHQE4xix1KoR+2O1tOwYkKTGjgkKCBM1ZpHC13vXFb1yLcUPjncb2I6TNV?=
 =?us-ascii?Q?cNRNJa5CKCkKu/CKo6qf+uMkw+xETiiRpHFLlLydv4w1y49X4t2kgTyOjjC/?=
 =?us-ascii?Q?s+UfZ7wzZOn0Huyz3gubwu/jdnqmOwqYMMv4UhOHgJXGrN2HoqIq2kkf584D?=
 =?us-ascii?Q?R4fKvO9NVqYmDbMvk+r3zGf/P4ZPPKFTGPIj7UprJHWa+1ZgCFf+I32xH++z?=
 =?us-ascii?Q?VdGVc5NJC+tCbeQVEnhiRdxD/NfgzTMAhr/Ttfk2ip3KxGuWseCVRwMxT9Jf?=
 =?us-ascii?Q?8SwyxoowQVS4MZ44SGkPFaWdZJK9ZSHuFleQzJBOgXcwcmAtbJV9Hh0QsJ6r?=
 =?us-ascii?Q?hvomFBwpjJgAZ0pHdB3V/Xz+TglhHcW3DbGGAA3XNWMNVGyn20KZuIf+vIFi?=
 =?us-ascii?Q?IEGP/d8lYPBmOar//MsktIebE7AU5BpWV0BS3SgeMTBs3hPmEOQeNlBfde2z?=
 =?us-ascii?Q?7SDD9IUfw4GMvKnqXFeT7rcCjnUalbhOK1RZOdAMWZSxB3As9QF/gZKxqE54?=
 =?us-ascii?Q?0b6Z2U/fwCE1BEhp/prg9ksg2XWMaJM1vyCUL94FXcnUnxClsRo4AmdxwRK+?=
 =?us-ascii?Q?M0na2eS0IIcQwCbw72NrGZlOxFial/nKXatMeiFQxHJeA3zZLKVelpFeQ0sr?=
 =?us-ascii?Q?xlMPfd/YyGMJTPFVuiYQPuu6yWbeumNveDuVLVbXurSaURxueUc0GxloY6QK?=
 =?us-ascii?Q?ZYaJHinIaSQvYR2B8UfJ+K8JoGWVQlBcDLEdfIqsj+8a6FpvXuIm4RAp94v+?=
 =?us-ascii?Q?ZleaqE049HDI10dUNuEJZh2Pqhhyhe23Fc+lQQgodo/AWJhsQtr44rLU4dxW?=
 =?us-ascii?Q?etuPXHI7juP7nPzxDO6p0AXJ/v0BIv+pRfpqJlLQNoWZ1pmyBwr72Ffs1B1V?=
 =?us-ascii?Q?Oc2HrOUJiws9khN5Z1g7rpvbkVT6wLB12qCocbuEtcEjgRdKEWKwPlqJx+Gg?=
 =?us-ascii?Q?Lzz1AF4vggb/ymGyQzNwcj0v3TC4OIeTKLunbqQ3wNT8nzdQQlketO+H1+AP?=
 =?us-ascii?Q?SKRrSNFlvi3YRBzvOTovPFLx40g3dvsVVYvcEYHAvFpDf1JxczX2AGtnD82j?=
 =?us-ascii?Q?Vo2zCw9sMlrrixUmUSnwobETAEnwDLTfEz7t8cEXnW4gPUg9WtQGtMWNUEZs?=
 =?us-ascii?Q?mwd8UVgz53jKdPWmRF89xdm+teO4t9FkjPWlPXBtN0vr48jJJc54435LbFxA?=
 =?us-ascii?Q?knKZnX8KVwPvzO7NV/dNGNRR9cdVlKn2jOaE+fz3kPx5mCkE4ARRxb43Bb5R?=
 =?us-ascii?Q?HzRFhoxMA1brmLAWUt98/TgVvCc0tgplyq+igxNkyw5fDDHJNZ4j2SoUXudq?=
 =?us-ascii?Q?wEOjhX57mU+bivYrqV5shDorarR/9bA9OlFQCdXcQNMjJ0mDiR1AZw5P2oRH?=
 =?us-ascii?Q?vqFXrSuuWOFdALFYDomEESIvYj+9RdDrLXoM4gPHfywHY3trzNFccZURnlNg?=
 =?us-ascii?Q?Lt4PuhNnniYeY5oa3TL0gNEpISyfLyIHR7MBOV91gDdiqijAoPQ+wHLltuCS?=
 =?us-ascii?Q?1wo3pKpI0WPSMNHvxG0IG94IXymDiqCxuixsmvf0UNXRqxe/zZdhh3qrfn5w?=
 =?us-ascii?Q?6tKqwkWA3oQoNPM3CzEp1d41/jYYt5M+c0bs5KtWGsZjUhqatoHCphLSaHZz?=
 =?us-ascii?Q?BlMIS7Ov2i0S+gbxyxG/UxFBxFZW40oCDzfWKomxRfT6KdKnmFihIbINXlKv?=
 =?us-ascii?Q?K2Yp+x6ncP04Gp3a5hMPMC+wZJrGOyVZI30Lcr8TqkIJ2rI46gLwNyxZ701M?=
 =?us-ascii?Q?1aimAW6J5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14963cd2-9c5d-4461-49a7-08debb9f03f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 03:21:17.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nfe7oASJuC7hDBL/9+lwxABIT6irbqgF1puL21MRKnt7YtIVO9vhmMfPgUhRWJqKV6KagjoRJBhuow2ny3sORIn+LP+wziydJlF2fBGYtCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-292082-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,microchip.com:email,microchip.com:dkim,davemloft.net:email]
X-Rspamd-Queue-Id: F133F5DED6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,
Thanks for the comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, May 26, 2026 10:10 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v2 1/2] net: lan743x: add RMII strap status
> detection for PCI11x1x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> > +     if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
> > +             if (strap & STRAP_READ_RMII_EN_)
> > +                     adapter->is_rmii_en =3D true;
> > +     }
>=20
> What does it mean when both SGMII and RMII is strapped? What if neither
> is strapped?
[Thangaraj Samynathan] When both are enabled, Interface will SGMII. When
Both are disabled interface will be RGMII.
>=20
> > +
> >       netif_dbg(adapter, drv, adapter->netdev,
> >                 "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" :
> > "Dis");
>=20
> Since there is a netif_dbg() for sgmii, maybe add one for rmii, so the co=
de is
> somewhat symmetrical?
[Thangaraj Samynathan] Sure. Will add it in the next revision.=20
>=20
> >       struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
> >       bool                    is_pci11x1x;
> >       bool                    is_sgmii_en;
> > +     bool                    is_rmii_en;
>=20
> Are there other strapping bits? Are we going to get is_gmii_en, and
> is_rgmii_en?
>=20
> Does a collection of bools make sense, when the interface modes are
> typically mutually exclusive at the hardware level? Would an enum be
> better? Or why not phy_interface_t ?
[Thangaraj Samynathan] No, we have only three strap bits for SGMII and RMII=
 interfaces.=20
>=20
>         Andrew

