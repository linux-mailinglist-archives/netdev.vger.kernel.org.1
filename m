Return-Path: <netdev+bounces-276813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K/0GAgW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7393C5D14
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34D83020A5F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0025A367F40;
	Thu,  9 Apr 2026 02:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3A2D0C97;
	Thu,  9 Apr 2026 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703337; cv=fail; b=Smfk/LKgvii0ZSvpg1/iGZRu9ONwdO9hJJja+5DPDV+v1usR1vR+kLMgpLMIOezLFrDAXKnlcalm6IqXr2Ou4yoS2kdqSjXAWZNZMi3dlHpyvZAbGlhIuQeUS2+iWGldUOHxbHHBisfGe2hiJ2L5f+W3K3NKpV23L6+Q0MOR9xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703337; c=relaxed/simple;
	bh=0eqG4575sA8tZqlAuoq5sw94wJWjszmurAhkqC/mTLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdMncp0UvpdD0A92CGs+bGhSKKDwbxaKSbd3kEXqkgYai2EvHS7yB2NJR4oiZQKY1vURjEnV68knQuGj+f8UjTVmIQdFb37Uq58SCiQbuF+aV6/bvE0YMbnQ+32Ej+yJ1ZLfRyD2VyqxngA9XuA9S4IP4iLOYZ3A2dSOImkwRBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4MTtHz2jb2mGv7yAj6z2CsSTSQu+R9a+bwsZEmsLk3mF9UlKprYnS4JT2ZqzepUrgZAn5tUZDlobV+XuoJlTbySYO5lKG5xRLQGdxuIs4cAjqiIS+AG0B7SyuuPmMqxR+LqAS/HkRlHn4v8HoRqDUq5Eyxl4iIv01jerAAzlnJU01PyLTHWGTkMOZDfApiGnAX4P+92S0aJjsjA59GFrtDxRLGpjKmL/9obEhgz0HrrKxwQZcfaSyjT/hbSVbamtfn6mlawiMrSWQluTMyddtQH+BKBon3h2hY4zPWLnHhwGM4xi1zxM72+gcQyLXesnFX8+nshqq3PMhwnzDaohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgwuI2Tx4/0Kz7DsiIk5d+EuVJrmuKO7tnJHXGQJ8jU=;
 b=MBeam2zGtedKYKtSYLaLfT5UjQH8ba40lnhJyIY9SI4q9p5Qy8RKArwG3vYsjMuuwdXy3JABYMfkIzPjCr9W0pnPLJv5NMatIFWp9aISUKxSO5Ph11gDv6N7xRdAMPdZrBmkocMLC4+1tdrnNO04m9Mv8Vw1yJP9spS32fxdfFLpBXdbBnj5iw98rs13kV+RZ0yr10N6bIdn7G/ujZ+9XHwOombNgrlOhyxOLuR/2wIKK+9VGpL2shCkBRbvMn1aM1v4PUCRL9KNC3Yb335z/oso2TmAihourTlrTPxhkVfChETFcfuwHXnhCr+PyD6ea0gz9huoQ8nz7EgCvSKVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 02:55:22 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Thu, 9 Apr 2026 02:55:22 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v1 v1 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Thread-Topic: [net-next v1 v1 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Thread-Index: AQHcxzPqQrOYYRYKOE2TlrW8gU1Ob7XVTJkAgAC9nMA=
Date: Thu, 9 Apr 2026 02:55:22 +0000
Message-ID:
 <SHXPR01MB0863079ED69731F5ABBEB6A4E6582@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
 <20260408084416.29753-5-minda.chen@starfivetech.com>
 <49407bd8-f20b-46f7-9b98-8c88fc45e0f0@lunn.ch>
In-Reply-To: <49407bd8-f20b-46f7-9b98-8c88fc45e0f0@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0735:EE_
x-ms-office365-filtering-correlation-id: b07cd339-f756-4bfa-b810-08de95e3718a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 CFBVPofAe8X/3KRKYkbE1qsBCeEwP3ykTYKlmrcI1mt5anb4mX+cTetTpl6WmkX+rwsmaL8KLAI7JdQt1kyPjv2A9EYchBTNlrrrIaj7ByY4gGrz4ccyEO+aD59hAcaGIBp6AmiXxXqjwsPAFXw4H0pI+O2xF+CiZhp9by+av9UvW/d6kp6aQQSP/U4/rbbViMlBJm8DaLkVzpwyQeRDoI4kI3F4PuPzkKBKvKRZxdN/nncPYScGEVPBucGeXGMw8wgO48koS6n346d52c2nU+r0bu/DrXUAogk7+14AJofqOnW6jkwsEPGyeLCLwkAal9dJEdJ3UTI0VC7Qh79YrMnGkKl15yrqVqeMx1dn/0rVRVCjLVsFoBGr5l5gBK3nvQlRc8hOK3IM1VxgqwlKXmymihcMGelk3/MxSF8l7TQRROt5lZsR6GvUD7xnZHqs5HKYz0/a4rHs22PHcKOxsHlyL5ODeweLtH+QpKVAFT4CaoGuCPNl1e2D1m6NxHgy8YkjnPpT642BpkGr/XcgG0sseoHQapBtd43lRYpWscqwudR5kMAMSVumq6QisxPA63ilz2o6bNjcur6w0HDoINEyfabU+glcSLtPNoGfJuU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RiUaw2Wlg4nIrnTHYeNl6sFRuTmDTxeaxHwaqBbgWEyxS4TCGv8ahgFJNpLv?=
 =?us-ascii?Q?/goux9M/uQcZWp3wsqZvnL5D0BkD0Q7rTfv5Up7S8Pb4Bk1OCEyKGrrM7q9g?=
 =?us-ascii?Q?oT7t1oAcCJvUkVp/HKwXLkLWYn/uHLKb+DI8UUdWHdGNmp1u2j2d5WQVejDk?=
 =?us-ascii?Q?4amll6YW2uDsqyCK7zBz2T0oBO5O6dNhEtHLjSx38ba4eLCkcEJ1yC8thuCx?=
 =?us-ascii?Q?B/Nggm0x40w/vmOyqW2DTCZs9JU1Zxyv53clpxvvidLkueB9GkG6KXpRK+Yt?=
 =?us-ascii?Q?4KoU+X8N6BmvGPd4JDOQBGlUM0ADVszhL7ilcLJlAGyfyj6zsQ06x3e9f1s2?=
 =?us-ascii?Q?3vLNre7bWiWABfWgStkZJsbKg/LwCEaa8lbiuEmfoT7TjZANZZVEALr6ytGV?=
 =?us-ascii?Q?E954gNT69cXXc3QPEie0F46BEuTITcDpnrH5iXZz8katWOcZ20+oKVamDscP?=
 =?us-ascii?Q?7Y2DusKkO7knkNYq8bovs0x+/iO1xpcj0krjfCO2yAmefOS8obteIUgsUV3C?=
 =?us-ascii?Q?4qNWPxPj5Hpp+6J/qi3Xgn2yjxPpOJEGfTkttrInQe01zXt/Ecg9E7sn6SJO?=
 =?us-ascii?Q?NDwFIUQVQuWBk+PrDqc1eictpVLUxCTndnrm8SxEHFL+xbPSkTD/b4E4b6wR?=
 =?us-ascii?Q?0Weolv1C8U2tnVw06WASZNEvRDsTAYwzjGPk80xXfYOJQamwQq89+mLWWT3I?=
 =?us-ascii?Q?D8cHcwuEpkNgLCGeFLpAoMfCyaA3UGLdzGpIJzYli2mZ4Y4Pz7E9aM7ydmCD?=
 =?us-ascii?Q?5uZSji5E1lkKPyw4/lFLKMbRnhJEiEhFfQfVhijFg1iQdQImO6665x2MWMD2?=
 =?us-ascii?Q?AuR01GCuPFpEQkddlzxcBKCfm9u33JRAK9ECksO1e6OQaent/1cLtla/fKBJ?=
 =?us-ascii?Q?t205tfamwdb4tYXLbp/XKFJl5ZG0wE1VLs1GAwZolkALhiRTjl5la67dSDl/?=
 =?us-ascii?Q?hlFDY1bhCsUHtaOIH8SmqQA0yNd5FOhKRUdARYK3BFL48Mx8gWI+zRPOBWED?=
 =?us-ascii?Q?zLGwHDUmpUhZ4xpbDicFsVbDTpXmrchPUql3luqn04zxnE5GQBA1wJLpsyf9?=
 =?us-ascii?Q?368X7x9AbqSqKVXu75e+UihZboEYA8Va8C9pKpSxjRB+H6RuFo5rX3m+0sDw?=
 =?us-ascii?Q?H54yN+OMbdwwmEtDK1aBLLS5NgprTC+HiXqT+QTaOEJjjNcXsomdAHu8UDbB?=
 =?us-ascii?Q?9W1DFjYZMi0P5HwEq4p7IY80YDwKXKBh2uSZImYAASqyrckSVfqJ7d+s1T+I?=
 =?us-ascii?Q?30JiLWrYy9zlPgg+XmpvrJ0rjTD2Th42AfL1hQF9ccTFHWLe3DNk4rT2Z901?=
 =?us-ascii?Q?0/53qn4jBEe0hnf6tajacsWcsGY1/PhfGG4oE9VyvXjbbygPcRQYWtVjCQ0l?=
 =?us-ascii?Q?K9Y69txQQmiAWlbL1Ix3np4yslIF8xiKaU85O/AHNtxL45w1t9WBOuqN4+zV?=
 =?us-ascii?Q?m0J5RGY4nQYiO0O/BylabX7EbwP2sMbj8DpI2iq7x131DOBk15MQQgvxtMg8?=
 =?us-ascii?Q?LtUlFps+HIoaVnT2ixaDG+kzBmnDk++PBPnOeSoghPcD+S/Acp9hxchXHM3N?=
 =?us-ascii?Q?k0Im4d3Kc2sHoDJXewcJ5Th+bUdN1MFyDOTqra0v6nlo4XyxogwZq3yr/I70?=
 =?us-ascii?Q?hWNAvHVhVmU3ObyAeQZVnTaeqZBEPG7uK1F1XuowtPxzJti+U73qst1FpHmO?=
 =?us-ascii?Q?aQ+bPFW1ODCAoz1UjPtXjmhzM2iuRccVmQ8osdRyYdlSYlNYQDHdAEZx3FYP?=
 =?us-ascii?Q?1PdJjg+9ST/ILOAawBborTMTen8eQa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b07cd339-f756-4bfa-b810-08de95e3718a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 02:55:22.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1l/rAuxcrFpp7PaGbbjy/np5l9C7gNFOjp4LFFnHa0b/7otPlGrGW3/diqRCyTE8stopfec4QH+cTTv4lz5z8HA/CDN3Er+dxN4SITKCoc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0735
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	TAGGED_FROM(0.00)[bounces-276813-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.069];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: 0D7393C5D14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>=20
> > +	dwmac->sgmii_rx =3D devm_clk_get_optional(&pdev->dev, "rx");
> > +	if (IS_ERR(dwmac->sgmii_rx))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->sgmii_rx),
> > +				     "error getting sgmii rx clock\n");
> > +
>=20
> The SGMII clock is optional...
>=20
Yes. RGMII do not have this clock.=20

> >  	/* Generally, the rgmii_tx clock is provided by the internal clock,
> >  	 * which needs to match the corresponding clock frequency according
> >  	 * to different speeds. If the rgmii_tx clock is provided by the
> >  	 * external rgmii_rxin, there is no need to configure the clock
> >  	 * internally, because rgmii_rxin will be adaptively adjusted.
> >  	 */
> > -	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk=
"))
> > -		plat_dat->set_clk_tx_rate =3D stmmac_set_clk_tx_rate;
> > +	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk=
")) {
> > +		if (plat_dat->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII)
> > +			plat_dat->set_clk_tx_rate =3D
> stmmac_starfive_sgmii_set_clk_rate;
>=20
> So you probably want to return an error here if it is missing.
>=20
No. RGMII still using stmmac_set_clk_tx_rate

> Or you might want to look at the compatible, and make the clock mandatory=
 for
> this device.
>=20
>    Andrew

Okay I will check the rx clock whether exist .

