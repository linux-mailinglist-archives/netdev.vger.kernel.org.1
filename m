Return-Path: <netdev+bounces-276321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOnsKfwA1mk7AAgAu9opvQ
	(envelope-from <netdev+bounces-276321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ECC3B8010
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C33305115C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC5377006;
	Wed,  8 Apr 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f61GRhFS"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F0374731;
	Wed,  8 Apr 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632328; cv=fail; b=knkcjL+PA/T6+NcEepr3qY+cWudEOFZEG267Na3OYJlW4HtgIAjcTfnP9OdPxg+1UC0sJnudWjfRyFeLzgFRxnTcclHknjHtPvz/PQ97Ani9+K476ycpqxqhvH7TbKMZT+oiCUh6YWV2g+NTJS6kFMuUH57Sw77PBzHR0K+TDIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632328; c=relaxed/simple;
	bh=J8Ga6SxrCJ7WwDHjxqtSA+Q0yDTbEQ6OhkqO0yk1ujI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUcFovrl9EksxolYvlSp7ni4SWL8/VjyXVfFc7Ae28vSvTOOdTaxvy10FMUbBU8zEc7XxY0DZvaYJiyjfHNq6IJfR0bGZSHkpC44SCdXrHWVRGUli3De2J45NFrW/9IfIqVOvax1WpAP55NkgNoAJPSMeWCMpmPeFjGSCtv+ey4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f61GRhFS; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNJZDdWuh0BlojFMTbf2uG5mQ3T23OErfrTUFnGrKtOrzTmcJmNILFn/konlLRxratptDh8ho3MI35TxWsQseWIV9cq3a4Cj3ITmABKH6w2TTJaHfljuB2kSS2W6+t3geXILrVGm8zxtw07zzu9f8Y5nOSG6Rval/fbzx285U2AjylVVL4KMkXxz0wuoVw6i2ssteAYKGgxJJRZF99OXbKopq0dq5sAz89CZEQRm9vcAnacfLcpJbgqfqMz1RREfYf/e6SvXM2Fns6X5ORQ9259JZzusQ+akwCabP9jBFzramVXyTKfrzjCUcsngFkUEPBYatoFm5LhFHlaANtzAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da/32IaEoM4TiiSCumrfYT1ebOfnlPwOBwpeqy9LDIo=;
 b=WxQXLuF+5yBYflHVQSksKXbE2Et4MZcIOD8DGeW58y53Ar9RAJpp4yveWCIBMmS3qiKrpPRNMq41x9x0n8tGPOswCvg12U/0U9Z+7zpXw0iqo0Wge4Kwg69IvaImJBsDqdVdgEe+V1gYX0lT9k+O5SiyaA8i6SyXlAT8Nw+z6wUJfEy83zCOR0QMFJPJvEi0IKC0aE4pTKR7cbtwhaT7s4qRV0nbLzcLlEufxjmnOjw0hhJ8SwDHLqgGR0JW5ndq+8wGkGvw+3+vwT6oiEPlYUjamiv5Uo7tTOR1tBW9MaRuP8lszT4DA1hp99AwdP8blm5CgvVhQBL3hX4SKsKCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da/32IaEoM4TiiSCumrfYT1ebOfnlPwOBwpeqy9LDIo=;
 b=f61GRhFSTB3Jg9p0wWFVq7rTzJBvHB2XvquQxMph3ESZblotty9ddhsg4AneHWwbSPLYbnda2Y7IHtiZupOo0amaGYWpIzrD9EkIH21ZaM6GvfrcCftKGQVWmNbcnDfJMQ05FP+BSzSnH3+eEKWNDGno8o7RSOj8f230ceTF5/4KhsId03izcte7/x1GgJIbolLx8eBkSsqI3LZfYKQTa0TRqwJnzR7EOJq0aYR7ObUG3nZUD2UGGZXLuJ7ECSE2wNxIMMfRwcy+kRsZrZnaGZ8l+MgLhMHl09SKlWwyCJxRfo7aDAs40Hcuk1H651p+UK+AN8EDpccN/HDjyVrrsQ==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by VI0PR04MB10687.eurprd04.prod.outlook.com (2603:10a6:800:25e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 07:12:01 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 07:12:01 +0000
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
Subject: RE: [PATCH v4 net-next 05/14] net: enetc: add support for the "Add"
 operation to VLAN filter table
Thread-Topic: [PATCH v4 net-next 05/14] net: enetc: add support for the "Add"
 operation to VLAN filter table
Thread-Index: AQHcwQGVB5gP5f5Sv0uq7wL4qpxDrrXMjUOAgAg+N9A=
Date: Wed, 8 Apr 2026 07:12:01 +0000
Message-ID:
 <AM8PR04MB72849A33C55C28082809DA46885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-6-wei.fang@nxp.com>
 <20260403011729.1795413-1-kuba@kernel.org>
In-Reply-To: <20260403011729.1795413-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|VI0PR04MB10687:EE_
x-ms-office365-filtering-correlation-id: e0b3d5f7-81af-4c8d-a6e0-08de953e2188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 FIEHMrZW7J4KYGGMAwm3KJd8dGpj5lfcDqBNeahOaY2ajsxoLafudZZvSAofotEd692ycMZrkkDL39LGFdSyoxxm1/dp+x4PnF/deQKWUDwNaTnDazaWXoUcPA6aqDBZ1n2GIkltJbZduM1vNVbNncL2yy++Nv+DjjzRVbQ2WCA5+cYCOvjMqvjWTSENSfpV1M7zTOxupqSI/enHonb2kKLKfKL7LzRVuSI9I2vzuspQxfhCc2z9abfb6IHw6QHtM113vURgrvhSPOh2Hf+aH4pD3QB7AS+hlIwKDC8cqbEaAadP7igvXWJu/8soRfMSrCZBsYKdYyimMdg4wPU2rb0kCj3/xVdLFu8BLEgRHgYc3kl3mJtWDT9YWa7hrKM+MNx670J9Fc3RKrhPcFa68Mut0L1dhc2KD/fOqviCWdbmJ8uAtaNVh9Yq2kYuSkeO+WxiTILNzZbrmp54lqpa5SzvxsmNhB4EMlcXg9y9by4Gl9S7Ph/cFtyllhTjD5Ffrkr7tJctdsrGzQ0DWD4NfhxTzCuBSmPqWkzEPFRRuU3glo0zEI9Y6RHXvr4J7M66ntD53XfVfz82UcaLc3WSWgSVQ25ab1OoAPp121ViBNYgGatjcQ+bMDpfyES1HUWZ428MbsAPk3DuCAaJ0gB6fA0cXbWhUS3RCVr6VWrh73yVXlOpBfEFY4meWS2XTkGZUfsvXfm6HE9eHtN37+957axodMISAHTCIZDA1oErk5q1QiFQfoiAp0rnHEw56gPTvfuuB55U785XhbmJInk5lbJTq3ismJVLG+GUXi4XFtc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SzlqXSQWmqzPnXU/eMXKzC1BbujZVNySaD6fDrWSml95hh2TG3dEKNWQtgS9?=
 =?us-ascii?Q?8S/pPzyJzAVqFCN5ZCDAz7rW2y3885XyAIo34JGathEfaSMgyznfxUvrEBkS?=
 =?us-ascii?Q?bO//MVtr/5fTkMfXrYfKLdWCis83ZLuMuOyPOAy0N+k6nl5kWXfOQWJp3vbz?=
 =?us-ascii?Q?0x+sNU16+OL3m6U+7c71NX5got+ofQduHzOqxSGhGql6Msg7L6D7oQqKolc2?=
 =?us-ascii?Q?Zn4iAlpIwGXiyHEC8a3j2jHD6AZFT+jdwWhbQe3nbWFyXkNAsK0kEEKT1jR0?=
 =?us-ascii?Q?iz3zkJabrwEr4tmvUQxlT+k//HRQ+PIMGwxgYhXBimOexPXY/OmPhvyVUVrL?=
 =?us-ascii?Q?0cmU9a0MsEoN1H/UsTBlkne3niHrSLShPzb0XS4X5LgSF+jB39TpT8GtMae4?=
 =?us-ascii?Q?PrPA0ofokrZfkzk0sqRO7UnU4Gw+uge3Vzqpx0RbuuKyKC51LK3LEoiqpQF1?=
 =?us-ascii?Q?oTJMw8QV+cRgt2EpqgJUDSPufQtTmmi3pDLYDL/aqCrKZS9H8DyLQcpTYOHM?=
 =?us-ascii?Q?eTr9lAeWO1/v9IZY1Yb3Gg5QXfYiwOlYZniTWm1vVA5c5VuV1iCzRMsHK3lq?=
 =?us-ascii?Q?2kHFqa8BNI/oHOZPaXv9QSDDO7m5jNLC6VrBsH3ToPZr8d2iz1e5CFyoTSFJ?=
 =?us-ascii?Q?CtFqTtdA00M3kDkxENDLr7FMB7oezBESranCADQAH9e5x4x8Flu+rE3DqgJb?=
 =?us-ascii?Q?YZZWCDsSQqgDzBu3wpMwmgDN2dhCNRTxBVfx0X2hMsEVqdZQOHd1NPGBCdCw?=
 =?us-ascii?Q?j/Ne1QczhDkMCFfgPQYFWY3EyiL1bz9+HltEZh7S+DjI0SmlM5phOP7rmSYw?=
 =?us-ascii?Q?jplUXOjqIzAyBHKZSu4XNOX5vkQeJrnRHyNxpvMfv8KyRrimi7zdqC1kh8Yb?=
 =?us-ascii?Q?kh5dXEGsqn0zqGCHu2hMYImsQvJDWV33v95P1cE54faHtTHzcxdZ4TYIIgOr?=
 =?us-ascii?Q?JcdCC0C1nSbOIR8p4c/BCuaJ9dYabm1UZOA+dYtEELcFsAG3wDrWGZO1G2kH?=
 =?us-ascii?Q?ehdBXO5MGgEuSbtXMXs6yzSlauYbNf559tOgEVSlb+p8XU2RyomsNWdEO34b?=
 =?us-ascii?Q?1OWpSgNecq27dH4iPLqfCJnQuo44GPsnx3eKDTGcLdSXKBETxjIQI/11Rwha?=
 =?us-ascii?Q?Q6tt0OtTRRkd4uqjUkc6c3Tbd1SMkOVlfoKifLWOre4yjjF9FQue3B9N3SsK?=
 =?us-ascii?Q?CuAKyZcfdPi64xiM/PFowU9pvFiBBqo5nq2f1JSf5w+Y49HuLVrEDJDcooZu?=
 =?us-ascii?Q?4mBH65kHHa9iLg0ZIm2A61NazmoFUO1iGcQM3qCa+CZmpz1P/RRdJpyWG1Zj?=
 =?us-ascii?Q?aIAmQwNXPiNJba/L8euy3uc+xOldkQJ3yGkWGPMkFaceK4BLV7yDXRlkK1AC?=
 =?us-ascii?Q?gdARTth6klxBHZg2OgDcl0oD64RUMJQam0TeAgGmY/MdY4b5+STYMbn4G9eJ?=
 =?us-ascii?Q?lQQU4uhHvgkiQbkYR9fDglyMdxUOn6RJ5VSi2cKXn6zNrxzCmmMS508TfkxZ?=
 =?us-ascii?Q?QCmk4gyCVGzmjpbvgmmmyA9zYWwooiOJVELItcHUaqNX+eT503odXjUKLhkL?=
 =?us-ascii?Q?VDE8ia8sNVA/IPRnb5Uaz808xEWRyjCxSrKXlwaFaQHZTX4VWA0jYX7T961/?=
 =?us-ascii?Q?dAphX4gF/PkJf5b2TbkkC99RcqyZGUDyFS0UQ7Rn1yCOeAeslNIJDj2gusaY?=
 =?us-ascii?Q?V7Ts2gqt+8VCF9Sm5roFtB2AfG7E2+4WPST5XO79Pifoc2z+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b3d5f7-81af-4c8d-a6e0-08de953e2188
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 07:12:01.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGPTps1T9hMY3DL2XDR2lPyqyS2RVJ6B6/J4ejXTs7t2V3km2acbgtvNexKL+E33EOLol2nk7sj5KGdkxLhzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10687
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276321-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,AM8PR04MB7284.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 51ECC3B8010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c
> b/drivers/net/ethernet/freescale/enetc/ntmp.c
> > --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> > +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
>=20
> [ ... ]
>=20
> > @@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user
> *user, int port,
> > +int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
> > +		       const struct vft_cfge_data *cfge)
> > +{
> > +	struct ntmp_dma_buf data =3D {
> > +		.dev =3D user->dev,
> > +		.size =3D sizeof(struct vft_req_ua),
> > +	};
> > +	struct vft_req_ua *req;
> > +	union netc_cbd cbd;
> > +	u32 len;
> > +	int err;
> > +
> > +	err =3D ntmp_alloc_data_mem(&data, (void **)&req);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Request data */
> > +	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
> > +		      NTMP_GEN_UA_CFGEU);
> > +	req->ak.exact.vid =3D cpu_to_le16(vid);
> > +	req->cfge =3D *cfge;
> > +
> > +	/* Request header */
> > +	len =3D NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
> > +	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
> > +			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
> > +
> > +	err =3D netc_xmit_ntmp_cmd(user, &cbd);
> > +	if (err)
> > +		dev_err(user->dev,
> > +			"Failed to add %s entry, vid: %u, err: %pe\n",
> > +			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
> > +
> > +	ntmp_free_data_mem(&data);
>=20
> Does this code safely handle hardware timeouts?
>=20
> If netc_xmit_ntmp_cmd() times out and returns an error, the pending
> transaction is not explicitly aborted before ntmp_free_data_mem()
> unconditionally frees the DMA buffer.
>=20
> Could the hardware eventually process the pending command and perform a
> DMA write of the response to the physical address of the freed buffer?
>=20
> This might lead to silent memory corruption if that memory has already
> been reallocated to another subsystem. Would it be safer to explicitly
> abort the pending DMA transaction, reset the device on timeout, or
> intentionally delay freeing the buffer until it is proven safe?

This is indeed a potential issue, I will add a patch to fix it.


