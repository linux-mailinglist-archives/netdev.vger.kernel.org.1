Return-Path: <netdev+bounces-276305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGrWAFj81Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F643B7CCB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231D0301A920
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BB366063;
	Wed,  8 Apr 2026 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hiU9ciWn"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FC36492F;
	Wed,  8 Apr 2026 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631321; cv=fail; b=ugxmz270oSEcmr8FdpBQbldHLZ3L+7AeoU8uwyF+YUnO1srlKwSWs2VpUxUDA8YkIa6WmqVquflxM1Tyk/fYkWn8xnxT/lVgrVhX1qgTsOlgHzVCDCcS5t289qpcVxREdE8sf/ZXoXLz2bfpU07SKLPYVqsDjXU6yU5+f89cCCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631321; c=relaxed/simple;
	bh=GtrQHaO4wHKUeB14V0JufD1ape+enVmjt6YZpeWRBrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPwN8NmKWeOqv2lkgncwxBoRR7PWx6Oj5MfH4p6bPY2g7/lmrmhi+Kua6HcRkeaBefwn5O4oz58hNpDEprWcfkgvdbFbh9ozcyos/MFSo6X3b5CQif5+b6awfFP5AhQEhfVTytHr/Q0xNDKAH+k4K4IDSwROq3X62uGAELcMJ90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hiU9ciWn; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNcjxUy3fY+3LcbV9x6V6+H/yt/h2ibqz/SZ2Zyk0TVhWhcQrTmmWp3vW83WpVH3v7itETAF1Cj4e+rMhKv0QvlfxXKURbqKD+SAvS3W1jy6Q4DkvOZnvx4B9fOgciu96Y2pSWhodtgTOxB4yp30gfQHmLxrj9GVzgLTiXBjKXE8NGvnOHw9HmZIWn8DJovE6W20ofxc8tJNWouoHaZ78z+zSaZ74gBH+WyIEUHaHa8jsNRDVZ43LfxsUtXzRloDB11vONQngC242E8+zzvO3pFIVME1elHQd4NMuybLMGd4nqvK39SSjk50wnqBA3EI+nhL8lCOKUp8AbupDdXxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prKs6zXE/1YVtziqB2gXhnSO7GBXCNSDaOxu58gMTJg=;
 b=MHA5H3ygp/ziqR1C6MMSLaHqShLSSLzFHqqz7R+gu5HiW2ymDDsyyu1zEWLKfSwuntsXFVZpfKdkFq6UkGWStkt+229h8yehS2GqvWVYIvnoG0nfDyx3NjKx9q6vMjduQH1BvUKSLBcfTaRhnQwWG38CirjPEvEFQUWtFkXFqSsneq225O2SUN8s2F8Wru/WWm3dpywu+VsyO4fN2oi/Het0ZdUp3Ym9oyT52g0wzd4x6KHJ5d/Pp+j/yvBLSAhG0IsGX99RBt7sAjd7Mr+Sjlxm2YvPb3M1hNm8E/1yzK59fvDZLjCh8V4fnInSormm8nT6Bu0GmfdqzTYk4yGDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prKs6zXE/1YVtziqB2gXhnSO7GBXCNSDaOxu58gMTJg=;
 b=hiU9ciWnRQXRlh+mNj3irR66Uh2frBbtd1TbEURiPbXaQMyTW/1zxRP7647V8DL6LCh5UVYaAE5R/rHkwHJtNust0lJTJgsPRw2KvRXlL4FAzZsiGAzdAexcKszW6V0fNsF97dHFIbBcVSHohrIK20RJyr5x8qQOl1kr3PMhjjNCBRkxg4U1HnnMVYslSfcUqMc3oIYgLmopwyQftZxZ3SenhwrX1v/P9mjvSzIapApXHsdg/2buzUMdmcHaZbc8Quo39VQR+PfMK+4R9g4CVHEFPwNJSBs+w//r1HNb2TeMTlLxkpsK4LYYv6PvTY+Udm7se9aPLHEmMoG0arwYSw==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 06:55:16 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:55:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 03/14] net: enetc: add pre-boot initialization
 for i.MX94 switch
Thread-Topic: [PATCH v4 net-next 03/14] net: enetc: add pre-boot
 initialization for i.MX94 switch
Thread-Index: AQHcwQGMQcs+8KC2C0iNkzmoN2Ujn7XMjTyAgAg2L3A=
Date: Wed, 8 Apr 2026 06:55:14 +0000
Message-ID:
 <AM8PR04MB7284598F9EA0FC8760F23229885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-4-wei.fang@nxp.com>
 <20260403011723.1795349-1-kuba@kernel.org>
In-Reply-To: <20260403011723.1795349-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|PAXPR04MB8910:EE_
x-ms-office365-filtering-correlation-id: 5be1a1ff-1155-42a5-c6e9-08de953bc933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 VQDfYYlPNYpER5ybAmB9TV6kukfXxCFDQouPcD3BiHILzbzOzze+uUjQEIWKh5okai2l1+M2J4n0Dbql+BehWRgeRazq9P+MALhcxFLSdPY47akBit9RcJSQMMi90a0Bd9DVxk4S2O+cXT21MdZx/51MdDrE/ceQzjHbOUKksbI2fFeRZUuV1rETELjHEuDAEXavjYayw20eVgNOgt5to2q0YA6nYsgjfv2PZEjszSI1llklccoOOvc1vR4Ty15QVo5Ig2zwSBBc/05NTugIY3VK+Bdz8Bk5CMoNPA71zkhJkp9ui62zXh/LgeiG6ebrt8gxptzZqQi5ouKoJGFifrq6HRm3fl5Q8jbFAH30fCCFONePznK+OkQEyXp0pYHrgsTcngXxjPI1WQdaTZvR2YBmbQCmlddDG0tduobBPlokqYNCAZtV3yHf0fOUt2j2TUs/U0wPYCK7eT6Ar1MYd8fb/zKkD4ZgJE1a87deE5Pkv4gk3J63m9EbBEzYAtTay0RoCQbyJg5YPHoI9YjW+JTwTB1IYQ/OufKeRjgzNMiuBsCk3oc8z4TzTFaI+P63ucLQDqhSBUYKZlz1IxIn4HiqI8FZWErc1effoUrXe9QLZ+aQksSWmD+Wlvz52mfMfiBvOwqyZZmqDLXb1NZbgi3EkGWOPLT/vkemMj3u0pjwedrKESNc8FvnRj9aWkOm/EGeTAewIMAMvlPzO5Gh8JtASF+6GyA0BWBfgYbvhTXKDp18/SMims3uXBY4WP+7n7TsPU6GfsEtawbcEm2ilmJ/DywqXnlNrzv+RFmpLEs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YbwdbwEQM26bSaWa4cQ14UCD7IQk90+SdzudDtdaBLCp/bEsPdgR3/0RlN0h?=
 =?us-ascii?Q?b3GlbFNRjxfw0Vn+eTmJVY5r9sB3d1qaMH8q1oFP8Kq8hHMwydSv80wVB393?=
 =?us-ascii?Q?2i8pc4mYAVUAgSpioTgoF7wZJafMXE762Eop2fvLud1PGIZ39SnWcHn1t4gY?=
 =?us-ascii?Q?XqMOSAcVnEfKz559XP6ttmgbaAJC3vHGJW8/MQ9X0xcWcbFTbKp8EZv3By/y?=
 =?us-ascii?Q?yfFHcnYE1cNMzWYIb1zsrOm8xw37IGPiJ6xcJiNDwX4Yvw/QfLsUg7v/INvK?=
 =?us-ascii?Q?56TjifWiMSrrnAPaL9+4NGvnJ40kTswIyuXaAmrT9BOdrhOFnKmZLdnpVD//?=
 =?us-ascii?Q?sMo7lEs2jXoF7zHcbcFt7NXUTeT61c5HWk8IC7d0fgZ3cW8LVjvrlMxilCoE?=
 =?us-ascii?Q?tVqERRMoHX2uaZb6ET+6p+Stjg54r1h+NAMJ8d+o+Bc3751uRgLU2lhrG3B4?=
 =?us-ascii?Q?gWWH30XmlsiHsRuKnDCfbynRLmD5QGgXfGm7upjAlpbYTj9mGDNqeqsZdWZ+?=
 =?us-ascii?Q?rntdJ8Rg5qMKP5inF6SpAgH34SB4xG3+HR73841zKSYkgSWjVFPpSdCEK/2h?=
 =?us-ascii?Q?Eg80nisKFIXr2shE4VEpnoXxmXo2zXkLcTMsNAEAO/2749IGBFfuJhwS3/BL?=
 =?us-ascii?Q?xdYEWRHztyM9cOWNVUVvp0R3JZMOIIQnEo08Mh0vEbyAMiD+BiHqq2fYFWre?=
 =?us-ascii?Q?0EmRXi0Fk7kYNKedeM65rPTYWoPyD7hARctcZfJklEmHXKnOvH48Qjlz+2Ob?=
 =?us-ascii?Q?NNPaj2IGoVyULWbCWGkoyBT/tKq8nocFc8Y2B3Qhw1CZ2MpLIGuzs/t+y/Dm?=
 =?us-ascii?Q?WNxkJw5TtgXj4f8VffGz/fFfZDRKEoNHXKjPjFRQ3RptjIADIWdFYobhX463?=
 =?us-ascii?Q?jCn8OcxLUbkAQuMGfA2eZDD4e+JVU7TpBNb5Kmp/objPXLaJQvnCRfCK19/u?=
 =?us-ascii?Q?YISQkR1YYQ15V4sqc0fMOx7OEOD5TISCpJakVdg3Zer2TeK/9R+SaaMw+N+8?=
 =?us-ascii?Q?/kH2TlzQzEd7bDriOfhvhEZ/ksL7bzgO7wWNf+CzCnA6GWK4FxUPCTDt6XPq?=
 =?us-ascii?Q?IrKQUnLwjH6y80tvrbOddnGKFJiTE7WYpMlSLWWFcvUy7Q4PmDsMlPhsk7Z7?=
 =?us-ascii?Q?/bRs6DoRpGJxrmo3Ilq8BXku4/Abv6cyxRYAuovODRwL5xAkcRZVesNWMIv9?=
 =?us-ascii?Q?qwUn6Hgz2Sfg0CZAbEooO+hOJ8RLZtTHVVKwq0czy7WoxTcqfnBxBCqsFSds?=
 =?us-ascii?Q?tOxSq01gwRUYWSt3joc7UKE+6v2hSIHahvUsgiCxtve94oF6WlV58zlJIL3l?=
 =?us-ascii?Q?WHDyYBQEOd8QHuUO3j0HHaAhKYw2Vw5pLg8yQfewxLaeH3Fpa12xO9GM4akp?=
 =?us-ascii?Q?iYI/iNBsr5yqESIirlE5KpDaTtOKLUmpzjOO5NZc+PlTbnP2nVq6YP2MKxA3?=
 =?us-ascii?Q?n4uO7H+028mE3GP7ipQMEq6CWFr1DnOAdBmVhwLKizJ9N1oVyPA5aGnJwgqz?=
 =?us-ascii?Q?0GcqlYo+lH9V9yG6xSGX6jmNym5nnaXRGW3tQ5T5CsaiHYoXuFcXXw8BeAWJ?=
 =?us-ascii?Q?cbnl/ex7NMLt2OP4m5aNKpDJWzGruQyzbGWIKvKxKaXG1lv/QCmhWdAt6okN?=
 =?us-ascii?Q?l9hZ+zBVs1BBA5B4tlnjFntK7AM2hw6V67HM7zpXFtHSRl6PUDGJq6NiiwXM?=
 =?us-ascii?Q?3yDZZABF8m28i7u4DaS8HCw1DFvM/apqoG/fOmEwRweHOQZ7?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be1a1ff-1155-42a5-c6e9-08de953bc933
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 06:55:14.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfXZy8tTcfm2uJNSP/v4asMZOdrd7vwrfGL2eDD39b517DfmEPu8RSaWwAUy5i3w6YbUoe8rIR9r3kGg53XqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276305-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AM8PR04MB7284.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 52F643B7CCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
> > +				    struct device_node *np,
> > +				    bool *swp2_en)
> > +{
> > +	struct device_node *ports;
> > +	int port_id, err =3D 0;
>=20
> Since of_property_read_u32() expects a u32 pointer, does passing a
> signed int pointer here trigger an incompatible pointer types warning
> during compilation?
>=20

Okay, I will change port_id to u32 type.

> > +
> > +	ports =3D netc_get_switch_ports(np);
> > +	if (!ports)
> > +		return -ENODEV;
> > +
> > +	for_each_available_child_of_node_scoped(ports, child) {
> > +		if (of_property_read_u32(child, "reg", &port_id) < 0) {
>=20
> If the device tree provides a reg value with the MSB set, port_id
> would be evaluated as a negative number.
>=20
> [ ... ]
> >  static int imx94_netcmix_init(struct platform_device *pdev)
> >  {
> >  	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> >  	struct device_node *np =3D pdev->dev.of_node;
> > +	bool enetc0_en =3D false, swp2_en =3D false;
> >  	u32 val;
> >  	int err;
> >
> >  	for_each_child_of_node_scoped(np, child) {
> >  		for_each_child_of_node_scoped(child, gchild) {
> > -			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> > -				continue;
> > -
> > -			err =3D imx94_enetc_link_config(priv, gchild);
> > -			if (err)
> > -				return err;
> > +			if (of_device_is_compatible(gchild, "pci1131,e101")) {
> > +				err =3D imx94_enetc_link_config(priv, gchild,
> > +							      &enetc0_en);
> > +				if (err)
> > +					return err;
> > +			} else if (of_device_is_compatible(gchild,
> > +							   "pci1131,eef2")) {
>=20
> Is it possible for the switch node to be disabled in the device tree?
>=20
> If so, should we check of_device_is_available() for gchild before proceed=
ing,
> similar to how it is checked for enetc0_en?

The switch may be owned by a guest OS, in this case, the switch node of the
host OS will be disabled, but we still hope that the host OS could do some
configurations for the switch, as the netc_blk_ctrl is owned by host OS, so
we cannot check of_device_is_available() for the switch node.

>=20
> Without checking availability, if the disabled switch lacks a ports subno=
de,
> imx94_switch_link_config() might return -ENODEV and abort the entire prob=
e.

This is the expected behavior, only one of swp2 and enetc0 can be enabled,
as they share the same parallel interface. If all of them are enabled, the =
driver
will detect this incorrect DTS configuration and return a failure.

> Alternatively, if the disabled switch node has a ports subnode with an
> available port 2, it could spuriously set swp2_en =3D true and cause a fa=
lse
> conflict with ENETC 0.
>=20
> > +				err =3D imx94_switch_link_config(priv, gchild,
> > +							       &swp2_en);
> > +				if (err)
> > +					return err;
> > +			}
> >  		}
> >  	}

