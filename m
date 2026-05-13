Return-Path: <netdev+bounces-287439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANIuMeMXBGpLDgIAu9opvQ
	(envelope-from <netdev+bounces-287439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:19:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5152E06A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C32F302E38A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC23D1A86;
	Wed, 13 May 2026 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZEfBsHgm"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7483D3492;
	Wed, 13 May 2026 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653153; cv=fail; b=HmSVWW8tYA9hOUZOM03x9wx2+moPm+3l4qyvs2pYz3XSKUi45IXHUJe+4k4+MwwWcXWYRyAYhxOaPlbGAeBE9nFxJcJxw7jglgZbm19+BXmbUuRwMX1jsjjiWRYPDUFZ4qW9W0gIi9kOSpBzD5O4t+1UstmWKoaKXtXMJ+kOf00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653153; c=relaxed/simple;
	bh=LimqCC4SVkrruuYi9ZUBNZ4whDXJ8eID3uxaCWMZ81w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IcN1Wz/GfU6wflQua6uiW/i8Bxhf+PU0AeEW3sQQBmp1zg4EjFc7TklmU/x0HZ4aom5QF2PYJDXPnGp/iVkLwzorIq5nKDEfGxYfawTbJ59B8+hqztl/qyndv1JEHXpgIaxKpYI4X719tOKeXLqi/SLSkhzsKyzIia4AfYUmK6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZEfBsHgm; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6a53EcQ1HTJJnL5y59yukrJkCih5x+YbYOiRQWRBKHVNcEd8FhCqZGSbK6/xz4ktVYdeYORsFbp2Ve688E786OCJmapj2PgMk7piTf+l+tdSiDNXsMl2mhv+PA5/W5cDno0jaVyWVc8dZa9/ziz/LW3Z+7dvV9j0Z938baRviWuZarCnbQIwvEDQqnyZox2yYKz82xUz8CVfHdvSKZGTEEVcCbC4aE3+AO/nowbsjSTnYxV12Aie7LHxjV0jlaJ3QnmlFhQE4SYZyVoUW+pZZ5pXXj5vwOlCZWwQfDMvY9wBYEYKaXQs58TPPA0e7/2lN7lguPgCjVlc2V5Li+h+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iaxRwtdvkWyY4ReKnNp0vuNJGyS74UvTfLwWLqYmX4=;
 b=dlrkYvb4yl5FLfuQLFmxq49WKDuxNid5LslbAvqQW6YTYQ2vhMpACP6cm2MGgaLdTwJ2HfueaYkwyp4n9kz47PqrsDiDH9KE2t+wvRMtbcIbgFCMbl9qD7VtSd2lXw6jKPefo2QeB/Hz8m+6H96tB6nG/rbOzSCs7GbAY3R8AYJMxf+aAWQDAb74H14OHxBZTVnem8u/hiBujIOtmEySvn+kHdGm5VFzXBvVL1XL5vCRgyPzA+9et9BGjHHAFU4yX+hvUxxrl0W6+kaPZiZ16mkvcMad9wfUrEGrGdR+OGjLeqzTQ5/rmArcNRT5RcypkrgKooCvT8kmBM1OdouPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iaxRwtdvkWyY4ReKnNp0vuNJGyS74UvTfLwWLqYmX4=;
 b=ZEfBsHgmdHTpTx2bnv4GNE9NdEIkXRWQQHaNWB24s9mWCRBpnpqwHLl2CxKFC/LY1a9+ZwglhrPD1kTuWGiWEyQddOLYNt9r7NTaFdte03PLRCN5XXUnRpiXU126gbQlzA0P/J/Z+vDBC5ae6O+OWHKPaNTxmRSLo8jyg9lBk0PJagj2+YsxfL4/UC1krMJPPJwYUoJxCPO6oyU2CYWA0POgHxPXFoOhqbldnjMOxJSGvElEv2Lmt0FgoEL+Asv7g1UqZX4s3MB7eOm5S0JBxOv7398mZBBsrZxXosTzKhSX58rVj2oNwYKRPzp7QAbuAbEvgC5Af0ly5FIhf59KsA==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:19:07 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:19:07 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 4/5] net: lan743x: Register SFP platform
 device for PCI11x1x
Thread-Topic: [PATCH net-next v3 4/5] net: lan743x: Register SFP platform
 device for PCI11x1x
Thread-Index: AQHc3qq/rGHXO6wrbkyFrNwN580h6LYJqzWAgAHFBXA=
Date: Wed, 13 May 2026 06:19:07 +0000
Message-ID:
 <DSWPR11MB9715B60CCCCB60C8C26DEA73EC062@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260508052150.11852-5-thangaraj.s@microchip.com>
 <20260512020849.839044-1-kuba@kernel.org>
In-Reply-To: <20260512020849.839044-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|IA1PR11MB7810:EE_
x-ms-office365-filtering-correlation-id: 2f91f857-cb6c-4353-501d-08deb0b789f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|11063799003|22082099003;
x-microsoft-antispam-message-info:
 fVsM0f+bzoCsBN19mvylvH4p8DznPMUvzYN0KxHESDVbcRUyx2ggXl8VzqY2mZTwng3R9rtNwojJgmVL4+81km877F2L1F/YI2jIig9zSKJxJPHrNVc1auYge6+bDheVMTjHgZn6XIm3DjNpowEMZ3hxX4J+ujMUhsWLG1+sctYNRMDJpyr45AD3RUGxehecHIAxK7eNbiVKFIu67nen6XyIsfn/hw+mm3CTMprCt7vAubNPWeIZG3NHD1JweB2PoSTwY3cTdSHzqJYhXd3LdF6WR3VGj+qPHoq0HfQXYzbWTm2xqEAM+9G1TKfdQ70zlYNbS+TL0OAtmycGsFI4LCUsq8hsHsYHiIWzRwMFbt3hL5JoxlF3Lq8J1D6wWCmXgKuedgo19Cu6iRryeJSLLujVthl+4lwl3/2vuGKLY9GxStkE2wD4LD0Nz1yaYGDMNpBIle8jQN3iOmIhWWoYnviXLYPxu0HGLQr2s8aRY7Vhg9aSeEon7t4uR8y76KAVWtPsXlJK/mduERbplIJ7frXFePgHAfyLBFDNLFjjO1Ql4mlEJwOmhJP8KSSrhfynFWt18baugdFB84cP3ZAudDFDRe69qsIcY2nFt2fHHvMmySahCRq6YHvmNhfIUAaJep/75KK/NO7Jy+gklv8B1Nx/fC4FcGdMeCzXjEOeEGkj44eF97mgIFjs8h/E/jdleFyyLnGsSruoV3RJi3QiHOkbG024v8KH/GCj/eKWaERvGtbIyGB8ShtZvAsXs/Ei
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(11063799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kC+RdTFRkA33lpAlH9fQn3sxKdFA9V4SGg9cypcPLiLHpE9DJX9EcOl/AY4J?=
 =?us-ascii?Q?l1WyfJhDRwIN3xHIyzHNt61+EQuD29lDXMx4i1eCoKwHR+AUIQki4/vdY1HX?=
 =?us-ascii?Q?twbRdbNB9L44QTHdbtMq3+xRvAD7wsbZE5hTfja5eryrk0NFJ7PccH+Mx0gR?=
 =?us-ascii?Q?uzUsg2UmUhp8vbtOlvEmSfFhXIxd2g7JlyBX8+6sd7cu5LsfL6nWKbmYiEbA?=
 =?us-ascii?Q?nyKQA8a/mVKEnE8g8msgVWb1qnw00GtmIcVNXY2Z17wemoEu9wz356ViX4Oc?=
 =?us-ascii?Q?r+2yJ/xBgdwAZGgakQLYpFcrf3jzqZz9K4n9WzhC4HAexA8Os7zzJdz3O0f9?=
 =?us-ascii?Q?cMBh+IkLJrA2VL2U1vh8bTiomv3Kpid2Sw6Aaq00OTF9tDpMqZAiATJSdATm?=
 =?us-ascii?Q?rQZFwShT1p3PiEBNAA6QhTgQ9cfz3ZkQIb3Sz+QtdEUJSoiRltkuJ3aJhI56?=
 =?us-ascii?Q?6Up+h3nRWywpIs7fkjHSMUb8v1xBwAsA/oHGogQDz0wbswKOilEl3NJ1osIu?=
 =?us-ascii?Q?W4RuzXQBkjsRFI04xeXGsiYt1rw0zHE18z27L70V6vZRTVML3qewrlmn6JCj?=
 =?us-ascii?Q?4VG0MAHKHIqGC8ivcundcsiZ8Oa+fax55EQH8BsEWwxlDacG6WTjabwEj87J?=
 =?us-ascii?Q?f9NKr6HagbXjBYQX/QrIYMTyVxVKrIMR6VLUazmsKdNiqjTGcmgIwMA2blqv?=
 =?us-ascii?Q?/eE3WFjIwTGvALVREM/wCnbYuQVlNTtgJJaAGmcrk6mLnvt06Ca0rrE4HA08?=
 =?us-ascii?Q?cEKbQd1m10Fj1/xPTYa/iyjJYt+z0dO5Fo3lrG8WkXB7bCv+nkqKTS85/fM6?=
 =?us-ascii?Q?njJLDhkIJPF9kITSyF53oDI9lkZva2/6bFsEO3bGP1ddsyZrGuDobXycRwLZ?=
 =?us-ascii?Q?Ay6RLu9lzaMHYkXnRUH50BJX82ycWBVzLxxn8rQ91Gew4dCDmprLyxIds0Yb?=
 =?us-ascii?Q?3952m+B1V0nB+I0rfs5AxA5BHXy8SBE/xXc15XriTHruQo42BcPuwagAQuPS?=
 =?us-ascii?Q?7AbRS2dgySwQsd3LBE32dqkM3+kFpV/WQNK6B31RJqSfVhQO8YOnpaamTE6y?=
 =?us-ascii?Q?Ka+sF9fq74QUgssCwG9BtjkRy9VOEwrY7eqAmxDi8gtPHblwiAgfO5sk0v3x?=
 =?us-ascii?Q?/oS0RGzdbEev3QatY1p310A+XNTSRCGt+iTsY6JucXn45Ar58bYrg9QBSSnj?=
 =?us-ascii?Q?ZvenoNiE4xud2Ke9j7TXDVo8x5Mp3fogS1PRLGPwpLRHrkcGg1f92Fo/jG5/?=
 =?us-ascii?Q?hey/XkXnvAaeU3pxLDlWI1LRJnOhdNd8bdoxegfQ7CE3+MlRWdHTXExZAjXH?=
 =?us-ascii?Q?DzisDIF6smJeTqUp1bx9XKvRXX+TmwPMlllgdcOLqfNguG4u74A5WfSV4iRG?=
 =?us-ascii?Q?FDNpfNtqkxm16N8NmgSloXInwuc3STMTh/Ktwhv/6A3YZ4kE1wopRRYpxCF+?=
 =?us-ascii?Q?nto3UwSMVyH0M2BRNbiuKjGMO1GzsJsfR26rfbiW8Qh/yoWPaqUK84fJibMv?=
 =?us-ascii?Q?d4xKrdlmNPfthtI2X06YrHvXlmhLwSr12330xWyhcZrJSzA8Z0cKahR9eJSR?=
 =?us-ascii?Q?sOU4dVo1AvmzSxSZsnYSRdqT7UBSl6aSgvVGbrxJCJ8VyFPVb2LWQVLasfA8?=
 =?us-ascii?Q?fLUI3HnekXoQ39s8fNv1Z5nGMMVAUZ24YLq0LgbiwApufQPCwaS+1VTWh/iD?=
 =?us-ascii?Q?hcC66+TonrohtHWlHzyjmE6EgaFLf9AgprVtTNK2XbSYLxyFT6U8sHxWtS9Q?=
 =?us-ascii?Q?x8kB1/npvw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f91f857-cb6c-4353-501d-08deb0b789f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 06:19:07.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BJ4EqnDr0Hjjq57Zj6UUCSoMVQw7jASfY9JYQkrTYXZaDh87OO8QrL9ECa75YlpkLxCpWNq+sznFqcdp80zCndd30ozQQe5QFS3L2DT2x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-Rspamd-Queue-Id: 53C5152E06A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-287439-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,DSWPR11MB9715.namprd11.prod.outlook.com:mid,lunn.ch:email,davemloft.net:email,sfp_info.id:url]
X-Rspamd-Action: no action

Hi Jakub,
Thanks for the comments.

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
> Subject: Re: [PATCH net-next v3 4/5] net: lan743x: Register SFP platform
> device for PCI11x1x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> ---
> net: lan743x: Register SFP platform device for PCI11x1x
>=20
> This commit registers an SFP platform device for PCI11x1x when SFP suppor=
t is
> enabled, using the SFP software node as its firmware node and associating=
 the
> I2C adapter with its own software node for module management.
>=20
> > diff --git a/drivers/net/ethernet/microchip/Kconfig
> > b/drivers/net/ethernet/microchip/Kconfig
> > index a83db3c7404f..9857053dabf8 100644
> > --- a/drivers/net/ethernet/microchip/Kconfig
> > +++ b/drivers/net/ethernet/microchip/Kconfig
> > @@ -52,6 +52,7 @@ config LAN743X
> >       select PHYLINK
> >       select I2C_PCI1XXXX
> >       select GP_PCI1XXXX
> > +     select SFP
>=20
> [Medium]
> Does this select need to inherit SFP's own dependencies?  In drivers/net/=
pse-
> pd/Kconfig the SFP symbol is declared as:
>=20
>     config SFP
>         tristate "SFP cage support"
>         depends on NETDEVICES && PHYLIB
>         depends on HWMON || HWMON=3Dn
>         ...
>=20
> With HWMON=3Dm and LAN743X=3Dy, select SFP forces SFP=3Dy, which violates=
 the
> HWMON || HWMON=3Dn constraint and produces an unmet direct
> dependencies warning.
>=20
> For comparison, drivers/net/ethernet/wangxun/Kconfig uses:
>=20
>     select HWMON if TXGBE=3Dy
>     select SFP
>=20
> Would adding either depends on HWMON || HWMON=3Dn to LAN743X, or a
> conditional HWMON select, be preferable here?

[Thangaraj Samynathan]  Agreed. Will Fix in next revision.

>=20
> >       help
> >         Support for the Microchip LAN743x and PCI11x1x families of PCI
> >         Express Ethernet devices
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index b90b35cef2e6..88a2d11552f8 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -3066,6 +3066,31 @@ static int lan743x_swnodes_register(struct
> lan743x_adapter *adapter)
> >       return software_node_register_node_group(nodes->group);
> >  }
> >
> > +static int lan743x_sfp_register(struct lan743x_adapter *adapter) {
> > +     struct pci_dev *pdev =3D adapter->pdev;
> > +     struct platform_device_info sfp_info;
> > +     struct platform_device *sfp_dev;
> > +
> > +     memset(&sfp_info, 0, sizeof(sfp_info));
> > +     sfp_info.parent =3D &adapter->pdev->dev;
> > +     sfp_info.fwnode =3D software_node_fwnode(adapter->nodes-
> >group[SWNODE_SFP]);
> > +     sfp_info.name =3D "sfp";
> > +     sfp_info.id =3D (pdev->bus->number << 8) | pdev->devfn;
>=20
> [Medium]
> Should the platform device id incorporate pci_domain_nr(pdev->bus)?
> PCI bus numbers are only unique within a PCI domain, so on a multi-domain
> system two PCI11x1x devices in different domains that happen to share the
> same bus/devfn would both try to register as sfp.<same_id>.
>=20
> The second platform_device_add() would then fail with -EEXIST from
> device_add() and SFP would not come up on that device.  Something
> like:
>=20
>     sfp_info.id =3D (pci_domain_nr(pdev->bus) << 16) |
>                   (pdev->bus->number << 8) | pdev->devfn;
>=20
> would avoid that collision.

[Thangaraj Samynathan] Agreed. Will be fixed in next revision.

>=20
> > +     sfp_dev =3D platform_device_register_full(&sfp_info);
> > +     if (IS_ERR(sfp_dev)) {
> > +             netif_err(adapter, drv, adapter->netdev,
> > +                       "Failed to register SFP device\n");
> > +             return PTR_ERR(sfp_dev);
> > +     }
> > +
> > +     adapter->sfp_dev =3D sfp_dev;
> > +     netif_dbg(adapter, drv, adapter->netdev,
> > +               "SFP platform device registered");
> > +
> > +     return 0;
> > +}
> > +
>=20
> [ ... ]
>=20
> > @@ -3682,6 +3707,12 @@ static void lan743x_destroy_phylink(struct
> > lan743x_adapter *adapter)  static void lan743x_full_cleanup(struct
> > lan743x_adapter *adapter)  {
> >       unregister_netdev(adapter->netdev);
> > +     if (adapter->sfp_dev) {
> > +             platform_device_unregister(adapter->sfp_dev);
> > +             adapter->sfp_dev =3D NULL;
> > +     }
> > +     if (adapter->i2c_adap)
> > +             adapter->i2c_adap =3D NULL;
>=20
> [High]
> Can this leave a dangling fwnode on the i2c_adap device?  The i2c_adap is
> fetched from a different PCI function (the pci1xxxx_i2c driver via
> pci1xxxx_i2c_adapter_get()) and outlives the lan743x instance.
>=20
> In lan743x_pcidev_probe() the code does:
>=20
>     adapter->i2c_adap->dev.fwnode =3D
>         software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
>=20
> But on teardown only the local pointer is cleared:
>=20
>     if (adapter->i2c_adap)
>         adapter->i2c_adap =3D NULL;
>=20
> Meanwhile lan743x_destroy_phylink() calls
> lan743x_swnodes_unregister() which invokes
> software_node_unregister_node_group() and frees adapter->nodes.
> After that, i2c_adap->dev.fwnode still references the released swnode-
> backed fwnode.
>=20
> Any subsequent access to i2c_adap->dev.fwnode (driver unload/rebind of
> pci1xxxx_i2c, sysfs reads, fwnode iteration, or fwnode ops
> dispatch) would then dereference freed memory.
>=20
> Should the teardown also restore i2c_adap->dev.fwnode to what it was
> before the probe-side assignment, symmetric to the mutation done in
> lan743x_pcidev_probe()?
>=20

[Thangaraj Samynathan] Agreed. Will be fixed in next revision.=20

> >
> >       lan743x_destroy_phylink(adapter);
> >       lan743x_mdiobus_cleanup(adapter); @@ -3909,11 +3940,29 @@ static
> > int lan743x_pcidev_probe(struct pci_dev *pdev,
> >               goto cleanup_mdiobus;
> >       }
> >
> > +     if (adapter->is_sfp_support_en) {
> > +             adapter->i2c_adap->dev.fwnode =3D
> > +
> > + software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
> > +
> > +             ret =3D lan743x_sfp_register(adapter);
> > +             if (ret < 0) {
> > +                     netif_err(adapter, probe, netdev,
> > +                               "failed to sfp register (%d)\n", ret);
> > +                     goto cleanup_phylink;
> > +             }
> > +     }
> > +
> >       ret =3D register_netdev(adapter->netdev);
> >       if (ret < 0)
> > -             goto cleanup_phylink;
> > +             goto cleanup_sfp;
> >       return 0;
> >
> > +cleanup_sfp:
> > +     if (adapter->sfp_dev) {
> > +             platform_device_unregister(adapter->sfp_dev);
> > +             adapter->sfp_dev =3D NULL;
> > +     }
> > +
> >  cleanup_phylink:
> >       lan743x_destroy_phylink(adapter);
> >
Regards,
Thangaraj Samynathan

