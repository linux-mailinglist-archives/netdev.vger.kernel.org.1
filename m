Return-Path: <netdev+bounces-287455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePY9JskoBGrGEwIAu9opvQ
	(envelope-from <netdev+bounces-287455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B7152EA7C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09DBD305807E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771153D6CAE;
	Wed, 13 May 2026 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MbU/qzAQ"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3F3D1A94;
	Wed, 13 May 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657454; cv=fail; b=QUtrZ0AYdyNaWSVbnMNGFweaQbeYoZq6coapY35qmpIg6URBmSiTvqQb7VuQz1rJ0wMP5F6esAeFhqvCZ8sfatjv7S35gAGC73xSy0pMBkOqeDAUVsg4RVGN0LD7QLHiWp2ftjv2zSp50PVE+W4tvGd6I7ImhDkNNeONFZnF1C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657454; c=relaxed/simple;
	bh=9Sd1G0Tcb4QoFeoS2E1GA0dgpLssIv4jdmbk5kg7Nmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G5a55l/Xa5iBYxQTa2K9ZJPfNNuqGhd0ba6XqhE2+d535CLQmicrp34H56h85JstvhmfA5CTq5pRmT6kRip5g1BIbhe2D04FZ7de1dYg/XJlG++Fj6n6S3loMh/DmUYz6KnWNGXzqp5qyY6X4P+HtRVMagPFxahzB3UIEhyBvig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MbU/qzAQ; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPchApfNV3Pb30ZZPhToFJYV7UbkBVtmmu3b5bmHD25SlemAB08KrGYIholdpS5Rb0zFOblHGY4/mDQ4yaeKOK4/sxhaWrL+UZSLQ3wcV8p6enqJNMNqDONCOekCgvy4/mi2QNT3M7gx37LKjHyioBahi74tGH5gJ2nTy4z4XiN8hb1HdmqmuqVIF1RTVuuKtMzW/MNtwsI2Rs4v4qZU6CD+m/uzcS71fC/bVfrLNriOyNttSnsz8NZtSW4WNaalb1j6NnlIuR4KZYcjqdfADA1VApoZUdmygUkNT95mBMP/5A18m2TgRp/6chZNyxi4yPQ/wY6/T6ZXAp4hB2zKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Jvh7B4lTxA2QBJwSkA2iNJh2ayaRguK5+01ityXdz0=;
 b=PryuF9mq02kaH6ywCp8bQ9WFv4pD8a0P2iTItZg0nVGkVFZI1a1Po8TS4uEYpSOcg7AvejGBGMYwrj5uqn1Ydt0QHeK2/7KyPA1hbUV2j+LNVIKlWGtuGijo8UReX/uqnJ7fHIYNlEYJ2XuZQtFZSEEd0DzKLZxNxqkZWGYELG6nlt+2AwUgv55cwpUa4UA9nWgHNl+FPPagcqJWlFtOSF0DEgQa2eVEJQ2iATHd335yLm46PvsgaOuFUXq92eV5y+J+1PEfXCh5xPPoSniN2kv4hLxeQ+tBgWAX7FpX9uK5czJTUSJW0rt961qfgoQpfeVkaoyPZ+DlkiYj+3gKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jvh7B4lTxA2QBJwSkA2iNJh2ayaRguK5+01ityXdz0=;
 b=MbU/qzAQ18nzXuPy7TbgVwiphJFEaMQmTb0cDL1cEFASYU8oandwGHIgoS8Jf/Bs5hyUJSfsL68XvImi1a1x4wbQAaOA7QJLa4ZOGv3GE0f8ur1Uw9duEbmsNdYuVRRhhXPEIi55NRtFQkfPPae14gnd7Mw475+dlZNIbf9cqcBegvDNKgZm3lqs+rcig3XBDq/aWidQZWSLtkfwzAvHpjg0E1dmh7Ti6ozUZ+T2m+HoNZlcWqSe80HDRJzdIIuuJ4RLtKFBsZhXpv6+fupUKQJ8nED21RLcc+u3RByE2Fx+rTu7hnTsZUAorh+d6OzJTfdn3Xo4psMka09IQAnygg==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:30:38 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:30:38 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 5/5] net: lan743x: Add PCS/XPCS support for
 SFP on PCI11x1x
Thread-Topic: [PATCH net-next v3 5/5] net: lan743x: Add PCS/XPCS support for
 SFP on PCI11x1x
Thread-Index: AQHc3qrCmXxpoYxW6UqXguqDhfaWw7YJqzeAgAHaDNA=
Date: Wed, 13 May 2026 07:30:38 +0000
Message-ID:
 <DSWPR11MB9715B2C6C371C32C5C305C2DEC062@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260508052150.11852-6-thangaraj.s@microchip.com>
 <20260512020851.839084-1-kuba@kernel.org>
In-Reply-To: <20260512020851.839084-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|CO1PR11MB4785:EE_
x-ms-office365-filtering-correlation-id: 245e95f0-6c89-405a-67f4-08deb0c187e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003|11063799003;
x-microsoft-antispam-message-info:
 UsLsoaw+pj/V4Q1hSBw8dTpmsKjU1ySSUdSz0Hr5ob4TvoBPNqNcka5W3Q0sX6oKG1aqpkTKpp0WUz18wz9ADim4HxKrCAqzLrdBCi9ekq1Y9nyj86l1114VA/mtuZ97Vcs1HG0ocdSm2Jjjt+nkne61fqWXxn2q416rmA0+Ok+skJtul+H4cT/IRQZ2IIWFkSy6KDQiwzHjdY01e78xyfepA5hX9ev29bfBMB5F+A/Z2pcrqx+XxcO5IBujnXWLhJChtqITDTxpL34jjjSqylefJsRnBTQupgnQYadSbaLz4AtVJH9+qYa6rskFQffNLTYgKzaMVZOYrxKvIW7BXxU34HfuVR9r2AL/F07Saqx9M2+OC+cw02jz+dtR2wULKZoM4IcB2qpfCKUKspdJjvidl7WK0aRsO/uEboU6fhSDvruoZlYBJfAGGuTkXAcfG2bhf1GXEuw5dUeG5V4ceqt4nQj/s9jgC/np5qedb0ESeUjS7kMufb3QBo5K8LYnasL789OICB9f/c3KWUb3g8w52l9NoL5fIdvpRH4zmWlKwAyX6CMtrza78tJ9T7Ozibo5N9CfIShyHH9VQjR5XPK1aV03L6StbZAzrrwyzL3LvFIAYaPe8DGdZDQ8SHiAnCbrZjgIR+h2wblZVnVj4F3hftYn7uQ9W6z0h9NbR+P4lEY5lMfCr4L1dEEPK5E0G/CXEzBuYx4cw5Y0Fssdu1SqEshR5mEyNVyUeAJQAIvdIP4kclg4bu/cZRNp+LY4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JleV7Q1qzjIDXJZFmwVLmBXc4JrJH9bYDPYQEsU7gWK1WmrvRMP0Cxdh207m?=
 =?us-ascii?Q?7X8720P8PUefmHK2x/cn7s13Ld/W79Hg+meWACP+6HHbXUQYnJmetXLK/3WE?=
 =?us-ascii?Q?5MwQQV0ZVd3Jb3VOCwYCde/+rLYUIL/kLvi3mwCGoTwMm/4nuatxAr8VyECV?=
 =?us-ascii?Q?GTTb3stNLDIEAkSt/uLTzNkitWDUUL6/gvLTvote2cHIUmpPc7srOWFWPmi8?=
 =?us-ascii?Q?M/C8Da06Wq9ujiPS3K9Ochn75r1mNac9aN2moiVlO0NmO+G+OqEyFi+hF8Az?=
 =?us-ascii?Q?JTUSZK9l7ksqbZRAlP+J0pFu2pVd8pGxRxha8zGavd7xTDqJRQ/4xVzqRq4I?=
 =?us-ascii?Q?HHMS/tHmbpyYU8SIVdbRDl+f7uqZeyJnhpnqR9X5/KBiZLYmbc8WtsT+ghP/?=
 =?us-ascii?Q?Ou4ISL6e9en0o/eDSXyvYp8oQxqYInw+D4CdOs1dJoWW4gRLsx0C1c/axGTY?=
 =?us-ascii?Q?iu4ib5irzunrt0MP1UI7twi9ZoNvwXJkYNLjMaJrILlGgkqRcSEKLYewDhG7?=
 =?us-ascii?Q?7WC+3okkmmopnYw5JoSkDx7eXRg28hlxBxIVcdxqbN4iGtrx4YE4pUEd7d2o?=
 =?us-ascii?Q?aTiDgtgrocRRnC2AnMReXol7KE/FkUjxHy+Nzylir6z7iFht3h5dnkXmBxNI?=
 =?us-ascii?Q?duREGzQsTRXsTiZOvCfuJuB64yRaTVMu9OyFsXEgn6exyfZSaAWPIjQfhwNr?=
 =?us-ascii?Q?I6+lF+JgpYzqZvNWL040NkJBJ2p47SGxF1FR7NVrEgOhZw7dL3+PD+EK0Xqh?=
 =?us-ascii?Q?sA7ck0hDOZGUEIuvVLuin6jlmiyKkTVV9xR1wjioC5n5I4CUc8v6610A+rgh?=
 =?us-ascii?Q?QJ54V5IUfaiUQen6Kowf8/LdoEAPuWM/zyiTS8QWkxYDnk2FSL7QyhsNvikK?=
 =?us-ascii?Q?K9/J4dU5ZzYECk1q4GHwOvIRLQkbiSv6dKVnnWJWv7gv1Hpw9MeV+MA4XxI6?=
 =?us-ascii?Q?2bmtR66IT1k7ue1TtgeK3WAio8gpFDWG9pOoSZXIPmvgHMaAKP3oX6ww8AZ3?=
 =?us-ascii?Q?XrKqrf5ahcuDyab+YlnYDtq/P7+pEMBNETTcBvs+w4aB7xdehYtDSDdrrIjj?=
 =?us-ascii?Q?fjNrMilhbg5rfyBpws4xs/ULdidA4expwIeA+U4HSorKTD7htVTjpvmBkjoq?=
 =?us-ascii?Q?ESxWkGPkId1Z39O+hpNv5qYuoitq6dRTL3KQ6rBW/MSOYOtFycGk8xFhLBcC?=
 =?us-ascii?Q?/Nrb8WTR3GoOkcZ3u1Lm6gBMvLjr13f2k4n4AdL3qQbIcHwFuqwrH6/t9dMP?=
 =?us-ascii?Q?dhdWEQ3NHLSQw7WsBKkzhqmnzrZDnYjWTsW2bkVc3zeVMDI7olFuvKgsRcq5?=
 =?us-ascii?Q?SBTXj0v3kGAOvQ7On1FYbzvSdINjKu4zVlLwEvNJIvzmUsrw4ZZ3pMXgwhtx?=
 =?us-ascii?Q?onQsqNTiavuEdz/GOtU668szkV4CGE19vlJ3ZQGZmEwcbYU5NEGdq1/3lLX4?=
 =?us-ascii?Q?GhWk8Ndxufp4hsuCPICd+rfd7HFc31nJ35IKrnoOdHT1fClJ4n2kWHsme2rd?=
 =?us-ascii?Q?lEdNTZvmUIXuAE6fmg4UPMS2s17L/LerIig3e1yzdub3F7YRyJSIh1DuDvSf?=
 =?us-ascii?Q?30kFgoJYJyZ4q1w3ytu8EokVGdDRDxFjtv3Zl6dDCiuxT3Sw4R23tjMJ/B5b?=
 =?us-ascii?Q?vvVvnrBLb/o3nvcAZ7oAXrZIonnN1Sx7LkaDGdjUatxG2UXic10v+ubETo3Z?=
 =?us-ascii?Q?KtFDOy77a2sniFx5r0l/L5pWApKJXY70RL78gotbUfysQBxvy30xYpFJ6F7q?=
 =?us-ascii?Q?MMTx9cEhxQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e95f0-6c89-405a-67f4-08deb0c187e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 07:30:38.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiArfDtPsJgGuJ6k0TB8NbpD8R4euXz8Jcsg6/JqooFfgbiJ+dSmgVq4FdiJJNyALfHIBXa6P4abZ/s6Q5j66tVurgFl+/yndRHe4rp0yBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-Rspamd-Queue-Id: 53B7152EA7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-287455-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,davemloft.net:email,microchip.com:email,microchip.com:dkim]
X-Rspamd-Action: no action

Hi Jakub,
Thanks for reviewing the patch.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, May 12, 2026 7:39 AM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; netdev@vger.kernel.org;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v3 5/5] net: lan743x: Add PCS/XPCS support f=
or
> SFP on PCI11x1x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> ---
> net: lan743x: Add PCS/XPCS support for SFP on PCI11x1x
>=20
> Adds a dedicated PCS mdiobus and an XPCS instance driven through the
> existing SGMII register access helpers, integrates the xpcs with phylink =
via
> mac_select_pcs, and extends phylink support to cover SGMII and 2500BASE-X
> for SFP modules on PCI11x1x.
>=20
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index 88a2d11552f8..485fbc678481 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
>=20
> [ ... ]
>=20
> > @@ -3806,6 +3845,42 @@ static int lan743x_hardware_init(struct
> lan743x_adapter *adapter,
> >       return 0;
> >  }
> >
> > +static int lan743x_pcs_mdiobus_init(struct lan743x_adapter *adapter)
> > +{
> > +     struct phylink_pcs *pcs;
> > +     int ret;
> > +
> > +     adapter->pcs_mdiobus =3D devm_mdiobus_alloc(&adapter->pdev->dev);
> > +     if (!(adapter->pcs_mdiobus)) {
> > +             ret =3D -ENOMEM;
> > +             goto return_error;
> > +     }
> > +
> > +     adapter->pcs_mdiobus->priv =3D (void *)adapter;
> > +     adapter->pcs_mdiobus->read_c45 =3D pci11x1x_pcs_read;
> > +     adapter->pcs_mdiobus->write_c45 =3D pci11x1x_pcs_write;
> > +     adapter->pcs_mdiobus->name =3D "lan743x-pcs-mdiobus-c45";
> > +     netif_dbg(adapter, drv, adapter->netdev, "lan743x-pcs-mdiobus-
> c45\n");
> > +     sn printf(adapter->pcs_mdiobus->id, MII_BUS_ID_SIZE,
> > + "pci-pcs-%s", pci_name(adapter->pdev));
> > +
> > +     if (!adapter->phy_interface)
> > +             lan743x_phy_interface_select(adapter);
> > +
> > +     pcs =3D xpcs_create_pcs_mdiodev(adapter->pcs_mdiobus, 0);
>=20
> [Critical]
> Is this pcs_mdiobus ever registered?  The bus is obtained from
> devm_mdiobus_alloc() and then handed straight to
> xpcs_create_pcs_mdiodev() without a
> mdiobus_register()/devm_mdiobus_register() call in between, so it stays i=
n
> MDIOBUS_ALLOCATED state.
>=20
> bus->mdio_lock is only initialized by __mdiobus_register():
>=20
>     drivers/net/phy/mdio_bus_provider.c:__mdiobus_register() {
>         ...
>         mutex_init(&bus->mdio_lock);
>         ...
>     }
>=20
> mdiobus_alloc_size() does not initialize it. xpcs_create_pcs_mdiodev() fl=
ows
> into xpcs_create() -> xpcs_init_id() -> xpcs_identify() and each
> C45 read grabs bus->mdio_lock via mutex_lock().
>=20
> Can this end up locking an uninitialized mutex during probe on
> CONFIG_DEBUG_MUTEXES or lockdep kernels, and silently corrupting state
> otherwise?
>=20
> Similarly, mdio_device_create() sets mdiodev->dev.parent =3D &bus->dev on=
 a
> struct device that has never been through device_register(), which other =
xpcs
> consumers (txgbe_mdio_pcs_init, ksz9477_pcs_create,
> sja1105_mdiobus_pcs_register) avoid by registering the bus first.

[Thangaraj Samynathan - I53494] Agreed. Will be fixed in next revision..

>=20
> > +     if (IS_ERR(pcs)) {
> > +             netdev_err(adapter->netdev, "failed to create xpcs\n");
> > +             ret =3D PTR_ERR(pcs);
> > +             goto return_error;
> > +     }
> > +
> > +     adapter->xpcs =3D pcs;
> > +     return 0;
> > +
> > +return_error:
> > +     mdiobus_free(adapter->pcs_mdiobus);
> > +     return ret;
> > +}
>=20
> [Critical, Critical]
> Can this error path dereference a NULL pointer and also double-free the b=
us?
>=20
> When devm_mdiobus_alloc() returns NULL, adapter->pcs_mdiobus is NULL
> and the code still jumps to return_error, which calls mdiobus_free():
>=20
>     drivers/net/phy/mdio_bus_provider.c:mdiobus_free() {
>         if (bus->state =3D=3D MDIOBUS_ALLOCATED) {
>             kfree(bus);
>             return;
>         }
>         ...
>     }
>=20
> There is no NULL guard, so the OOM path dereferences NULL.
>=20
> On the xpcs-create failure path, the bus was allocated by
> devm_mdiobus_alloc(), which registers devm_mdiobus_free() as a devres
> destructor that calls mdiobus_free() at device teardown
> (drivers/net/phy/mdio_devres.c). Calling mdiobus_free() here manually fre=
es
> the bus (state =3D=3D MDIOBUS_ALLOCATED takes the kfree(bus) path), and t=
hen
> devres runs again on the same pointer.
>=20
> Would it be simpler to drop the return_error cleanup entirely and just re=
turn
> the error, letting devres free the bus?
>=20
[Thangaraj Samynathan] Agreed. Will be fixed in next revision.
=20
> > +
> >  static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)  {
> >       int ret;
> > @@ -3927,6 +4002,11 @@ static int lan743x_pcidev_probe(struct pci_dev
> *pdev,
> >       if (ret)
> >               goto cleanup_hardware;
> >
> > +     if (adapter->is_sfp_support_en) {
> > +             ret =3D lan743x_pcs_mdiobus_init(adapter);
> > +             if (ret)
> > +                     goto cleanup_hardware;
> > +     }
>=20
> [High]
> Is cleanup_hardware the right target here?
>=20
> lan743x_mdiobus_init() was just called above and has already invoked
> mdiobus_register(adapter->mdiobus), so adapter->mdiobus is in state
> MDIOBUS_REGISTERED. Jumping to cleanup_hardware skips
> cleanup_mdiobus
> -> lan743x_mdiobus_cleanup() -> mdiobus_unregister(adapter->mdiobus).
>=20
> The bus is then torn down only by the devm_mdiobus_free devres destructor=
,
> which reaches mdiobus_free() on a still-registered bus and
> trips:
>=20
>     drivers/net/phy/mdio_bus_provider.c:mdiobus_free() {
>         ...
>         WARN(bus->state !=3D MDIOBUS_UNREGISTERED,
>              "%s: not in UNREGISTERED state\n", bus->id);
>         ...
>     }
>=20
> device_del() on the bus device is never called. Should this instead goto
> cleanup_mdiobus?

[Thangaraj Samynathan] Agreed, Will be fixed in next revision.
=20
>=20
> [Medium]
> On PCI11x1x, pci11x1x_strap_get_status() can leave is_sfp_support_en true
> while is_pcs_en is false (SFP strap set, SGMII strap cleared) with only a
> netif_err().  In that case lan743x_hardware_init() takes the SGMII-disabl=
ed
> path and writes SGMII_CTL with SGMII_CTL_SGMII_POWER_DN_ set and
> SGMII_CTL_SGMII_ENABLE_ cleared.
>=20
> Then lan743x_pcidev_probe() still enters this branch because
> is_sfp_support_en is true, invoking lan743x_pcs_mdiobus_init() which driv=
es
> xpcs_create_pcs_mdiodev() -> xpcs_identify() -> multiple C45 reads throug=
h
> pci11x1x_pcs_read() -> lan743x_sgmii_read():
>=20
>     drivers/net/ethernet/microchip/lan743x_main.c:lan743x_sgmii_read() {
>         ...
>         lan743x_csr_write(adapter, SGMII_ACC, mmd_access);
>         ret =3D lan743x_sgmii_wait_till_not_busy(adapter);
>         ...
>     }
>=20
> With the SGMII block powered down, can the busy bit ever clear, or will e=
very
> read hit the 1-second readx_poll_timeout, producing an extremely slow pro=
be
> and a bogus xpcs identification?

[Thangaraj Samynathan - I53494] This will be fixed by the patch 2/5 fix tha=
t forces
is_sfp_support_en =3D false when the invalid combination (SFP strap set wit=
hout
SGMII strap) is detected, ensuring lan743x_pcs_mdiobus_init() is never ente=
red
when the SGMII block is powered down.

>=20
> >       adapter->netdev->netdev_ops =3D &lan743x_netdev_ops;
> >       adapter->netdev->ethtool_ops =3D &lan743x_ethtool_ops;
> >       adapter->netdev->features =3D NETIF_F_SG | NETIF_F_TSO |

Regards,
Thangaraj Samynathan

