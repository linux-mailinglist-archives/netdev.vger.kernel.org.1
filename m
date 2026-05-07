Return-Path: <netdev+bounces-285115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id crBvFRf0+2n+JAAAu9opvQ
	(envelope-from <netdev+bounces-285115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:08:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06294E22E3
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 155C93008A7A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077D2820C6;
	Thu,  7 May 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N2jcTQmp"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070282505B2;
	Thu,  7 May 2026 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119700; cv=fail; b=jQF1NphBzXSVv0+TDOEuxFoMXl7Q8uB9HGSzR4eZ/O/pq/OGFxbWWwtW9NSEuXi7sRiU40vVlWLy4HQv878TotoKoLpI/ofmmTz4CdJx8okXxO2g4pIS1L7KhAOK1aj60xEv8LFftrICe40GgTxKIHkHqtqSpnjhspi/KKWyVmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119700; c=relaxed/simple;
	bh=85Kw6n8zDv6oa3n4e/Pgq34SPvK9f0KHOk/YjG8J56k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ee/JWmuwhXnJrQkqHgMYKDpwKFzYN4u1OHN5FYCZB4ypoGnhFayq6uc4pUDIYNLtRDXCwM5zXAMNS9YqopbDXEdSSD2pbkfYFnhJXQ2RDG579iC+qzjB4CZJLLJndYk5YIKJHtr1CCWVlPglcVfQX9u1EtPAFEGpm3DElnFf+Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N2jcTQmp; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8Diog+4X+TkiIkOn78aAxSftT8eDZmN2meUWF1w5HuDrPROcEki5lCxRMPQ/Hq+uUKmwwBktc6gZnJVHpiFtT8FF/JUX7A0VYmauvuUvExltzY+ArqgcPfYHIafy8G3R3TczQk12Wp4gJi1XhQmAubxJwrbN6Y282WNKv5Scj2XbcysUlupPq5AlzsKBNMbmsb9MYNy8tOk1dLRLjr1mlvWlQtcghRj+/1iVTvyqMmQoO7xoc+71RqF6EKUYJDaZ1dobsmr2asXPfwxNgzivtbG6eeks1VeRKEMRwb4yMRbLw+7NcY43yyywfzYV5q9Q6E1VswlJqwxfBLfDh5+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouxuxkb2XL/1BdZHuL17sgoRhDhsBbMfXFLBNuX0ULw=;
 b=kbS5MoloCpO8CRnYHS8knPB+aIFXrnqlEm7U/y7EIIR8GyyVXItxOAZBaQF7zJlMCrM3d/20EA2Adaw1ZzGTMgwAHWw4+cUd++v/P6JFAIhRCLdEVBwsrlY3MYiel2jCNjuoqSf6PaippwRWxffV2pFH8w9fg1ad7UDG9N3aywWW+NznioQNoIy7ud8q4mC2poCTdrCGGu2WVnvR9CFcg77ktnnWCWw7Y3zkKxwrMsFzniiRY3UcoL9+p1aRjmn1m6B3uW7tU7scTcHwW6cp8dkZBeccad7YuiyEu9EfLDFWsEM/UU6pKVAMxTgiokArwT+CV2I4NPr7FUN+bMq9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouxuxkb2XL/1BdZHuL17sgoRhDhsBbMfXFLBNuX0ULw=;
 b=N2jcTQmp8xDxkmOniWSuzxKwhFTyZ2016l40sqmCi9dxC+FjKnDvv5amUPzE6rM0Ma53M8CMG89FHVFnoYGixM0NKQAx1RN9JPBA9Uqm0hdzqSO1zNKUwBnUPuuFiyurhISWaZqer8ekbb9qZDWjoR1+sxUvA8QZsBlQgumClURjV106bHihMB1v3P5/+uDiDohldexFmG4Dp5BmHOWD+Jhnl3vgVJUPzRSEr0JSlUDCy9iRa2pX08fzTT3aVXFSCKH29SuUgSZJ6sjTmuPCnaarEehNwcV614DeSI8CgN4DttQu91jjhxU8mYB2yYzN/BJbpVsZ03FOAVg540EcYQ==
Received: from AM9PR04MB7491.eurprd04.prod.outlook.com (2603:10a6:20b:283::7)
 by PA1PR04MB10700.eurprd04.prod.outlook.com (2603:10a6:102:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 02:08:15 +0000
Received: from AM9PR04MB7491.eurprd04.prod.outlook.com
 ([fe80::3203:e51d:557b:a195]) by AM9PR04MB7491.eurprd04.prod.outlook.com
 ([fe80::3203:e51d:557b:a195%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 02:08:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v5 net-next 12/15] net: dsa: netc: add FDB, STP, MTU, port
 setup and host flooding support
Thread-Topic: [PATCH v5 net-next 12/15] net: dsa: netc: add FDB, STP, MTU,
 port setup and host flooding support
Thread-Index: AQHc2EvhWB5l3RgFg0WQ0IZZ22fm2rYB2AYA
Date: Thu, 7 May 2026 02:08:15 +0000
Message-ID:
 <AM9PR04MB749190BBD0C9389F17242090883C2@AM9PR04MB7491.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-13-wei.fang@nxp.com>
In-Reply-To: <20260430024945.3413973-13-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7491:EE_|PA1PR04MB10700:EE_
x-ms-office365-filtering-correlation-id: 7174be37-a000-4bec-ddd8-08deabdd7ff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020|38070700021|3023799003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 bk4EPG9VXr5y42c5XZ/NZ4C90H1g2TPRFpJhR8xFleUkfD2rBcmcuTAAAu7pLqGaYeeUsf0si/i7NGSzyEhOW3NMP31gkdiOC/P8ByMhsVOXC2H8oGNY0R7aHhdmjwK/zcgXtMH5+ArC6bIOmuLMHuVtcwYaKMGWtE3m+zCJV+ip6TscVOGzRLCAxDX+RIsoy1+83ld50s8GX50tlxTskfR5qgUoaq5eHgGJo6nfIVltzfLvzy/siO+KeTt0GXs2C32Dk5CQLq2jaaiG+SXtkfpRU8mIN1w1uMKPTGFKKCtrRJCnFeZppIkkoa6BekHXjIcnmhY59yTjINNPY6QdSWUkh5AjpsqfacUuhHYzjSA7ZDEbyqDRuGD+u+YnZLCD7j3IjfJbdBEiLcDCoWk/pKDGEhT4LO/aD6jyGxk5u2FPpN5RbEtyZlu51bj1LvXI3uyUplXiET4Pr24l9QyAdEGrrXqAALfIijA8FKyhWu+nKlbwitOPkI+NoscQloPVi0/Bq2aN8ud5ojSETI2wxayWZ9gVCvp4hAWVD68v5xNxgYuCZncXSDapSpF6TkNm4refq5w6dLTpsCI8e5N3h79nDagrOUW0JAJnKMKy7CRzUzR7DmCBGAx112oudE361topKtGIozg20scC+ox0mZN40eC7S2T6M2yZEqjulh81ekHnsfVOccrIcySLGbHs/+/M96/9jYtVBI/ytWSXkq6aKjYbw7Suwip6OFlkFXTBCdgAWoupE5XKvjkM/54kDfNsSKEuXy18A+LK4z8UNA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7491.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020)(38070700021)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?VryC8cbo/QoT6AflwiStQBsAmsxj4s4gSwTaZ3Ztf+3EHpWOWZBvv4i8N4SI9X?=
 =?koi8-r?Q?G9rPSS+QdAdmTQwoSJ84wLQPBJnvpRMT1oZHWYlm1sO8XpnKe5BZOwNaNOnMw2?=
 =?koi8-r?Q?9n1oVPxml7aLiT2L8vxrnaYSFGvVTl5/DzXfHOmCCSEYGIvZhg4yAQ0+7vjf2B?=
 =?koi8-r?Q?nEl3juh9TxyiTjAh1LX4NL0kq+3GHUoHUqx874ZeVW4UzChtz95Sb93UgF/Z8R?=
 =?koi8-r?Q?Cx5s0dcfmQlbaIx8X4p2KqRg557dkRPeRT12+UxT8XlDm7H5zWE/XNni0ayf0u?=
 =?koi8-r?Q?1X98fRGE1DwyLeXf8OzZMpsABZn0oSbUB9iYtsxdjvXExaxB9nhhlZZrZHsq8I?=
 =?koi8-r?Q?Rh1Xa6PxSF1Hnez01Kq/itMU4M4pfuB0Zj+6dSh5PVx7RbTBhBDfvcmnl8dVXH?=
 =?koi8-r?Q?VWg1YSaMFNeksY2zujwdlEMw9gKGMudtcXlB0GNs5iYZAExXxCsQJNNHcq69B/?=
 =?koi8-r?Q?ATurhET1BkYRaP79cTpydvxguMzxcKzErfaF7bdQuG3j95Qb7GwXFUsDwWtcS8?=
 =?koi8-r?Q?VtVSO+DFaoPFy2ttcy4KgMol/SPVQCQID8D0DDHdzSn19VWvWu39fpTrVzHuU+?=
 =?koi8-r?Q?VUq8PSWBsEZYPffRbDCdCQoAYCUIn+Kf7GUq0yvy9IIHe+XOrnrPW6N8/mT5wK?=
 =?koi8-r?Q?nOO6tuiIEOAMUXchJA+dzUKZZ725pVVqspYarjbhZYW2kbYpXtyXqpe0ADT6k8?=
 =?koi8-r?Q?oIv0QbS1YUy14tSI28jEa8+QT6qbZA8E2bxXDrxaenaCehZK83sKPeb9gFoHfC?=
 =?koi8-r?Q?YTdPmqKaRngH2A8kD8C5wagV+MU6ZQ58MM+9tML2zxhNyCYtpwR5/kRuIQe4G6?=
 =?koi8-r?Q?JU4L90UUWsBvFM2KgOjinTK+AFcE+Zf1LC7aOgNXBYE4HkjhXx6ZTestsslnZS?=
 =?koi8-r?Q?tlkkxkdgAw7KOoK023pk/R6wlY/u0KDAlGQCT95DtcQEArS8CMXctAiM9nlLKf?=
 =?koi8-r?Q?0PT8pg9yVVwhFTQDbojrxLYLdqCSyTV//VqPulRy/A2clComxQBJKFstWtpTNz?=
 =?koi8-r?Q?u2cXCZdw+0CUxu31fgsfLnLJK+nGvX8QCs7n6wI4iZCcgUajbt92PPXBv8ZsoF?=
 =?koi8-r?Q?TiZguflyuu/NjKl2DCteJctjMqrhylDcbMcnCCIN/iOY3ZL44O79WmbakWF9zu?=
 =?koi8-r?Q?4FCYk8/rra8jNUpJo2E1iCplRWaTogV8mwV26e+POKgj/d8Powgx86hWdx5ISW?=
 =?koi8-r?Q?vBAQrN/ZLrRBnWscr0wCWXOoNvS0Z+fWRUzsvd+ERQgvtiIsDs03wEcC3wIMan?=
 =?koi8-r?Q?OzPQKWcw5rrBOQWj/vigy0690pX97Hdpona2dXoQGI8H+NVs0P1yWcgDkI/8Wr?=
 =?koi8-r?Q?e58sYvq6P1Ogh7z9Vr0UrCIvVynuz7LTNIoEKIPMItikpVkzKKJbdYK4i29LxA?=
 =?koi8-r?Q?Kpt0ug28MIP/Qg7Dehwn823k30Uoo602v60d4w1k/tcufL8vkEh4RH0cqF6ztu?=
 =?koi8-r?Q?By7iMevmw068gAMneU6MZ1mCoqR20o55pj+xCRfACRPOZeKZcPXKQlAkZXvQLH?=
 =?koi8-r?Q?ePythZoIT0O4a5txAXKHL35OHyEQfxODAxp0UnBfIBnnKk24TIsCdlEcptcDOd?=
 =?koi8-r?Q?jRIjajeAm3uuPmIfoA9UPiZWHFXCYLEt+4qxF+pBEJG3Wc2ZnifYlZDBdKikRS?=
 =?koi8-r?Q?Oal4bril08KOzYDdEnBUB7U/t8yeT0KoB5WkXXOI8ar0JXClpzvPm3?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7491.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7174be37-a000-4bec-ddd8-08deabdd7ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 02:08:15.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Zad/03NodU12suX0ldKfctPcAopAte54QXPQJKKone5Y8EkH405KgrSusMXs3+0LyQo8apzul3kYkFtvyu6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10700
X-Rspamd-Queue-Id: A06294E22E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285115-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

There are some false positives reported by Sashiko, see the comments
from Sashiko and my response inline. Other comments are useful and
I will add improvements in v6.

>  static int netc_setup(struct dsa_switch *ds)
>  {
>  	struct netc_switch *priv =3D ds->priv;
> @@ -393,6 +627,8 @@ static int netc_setup(struct dsa_switch *ds)
>  	if (err)
>  		return err;
>=20
> +	netc_get_switch_capabilities(priv);
> +
>  	err =3D netc_init_all_ports(priv);

Sashiko says:
Since the DSA subsystem can call setup() and teardown() multiple times
(for example, if the CPU master interface is unbound and rebound), does
calling netc_init_all_ports() here leak memory?

Looking at netc_init_all_ports(), it uses devm_kcalloc() and devm_kzalloc()
for the priv->ports array and port structures. Because devm_ allocations
are tied to the PCI device lifetime, they won't be freed during teardown(),
which could lead to a memory leak on each rebind.

Response: Analysis of the DSA core driver reveals the following call stack
for setup():

netc_switch_probe()
	=84=80=80dsa_register_switch()
		 =84=80=80 dsa_switch_probe()
			   =84=80=80 dsa_tree_setup()
				     =84=80=80 dsa_tree_setup_switches()
						   =84=80=80 dsa_switch_setup()

netc_setup() is only called when the switch driver probes, so it will not
be called multiple times during the lifetime of the DSA switch device.

[...]


> +static int netc_port_fdb_add(struct dsa_switch *ds, int port,
> +			     const unsigned char *addr, u16 vid,
> +			     struct dsa_db db)
> +{
> +	struct netc_port *np =3D NETC_PORT(ds, port);
> +
> +	/* Currently, only support standalone port mode, so only
> +	 * NETC_STANDALONE_PVID (=3D 0) is supported here.
> +	 */
> +	if (vid !=3D NETC_STANDALONE_PVID)
> +		return -EOPNOTSUPP;
> +
> +	return netc_port_set_fdb_entry(np, addr, vid);
> +}

Sashiko says:
Does this implementation break network isolation between standalone ports?

The driver sets ds->fdb_isolation =3D true in netc_switch_probe(), which
means it must isolate FDB entries per standalone port or bridge. However,
the isolation context (struct dsa_db db) is ignored here and all entries
are placed in NETC_STANDALONE_PVID (0).

If the same MAC address is added to multiple standalone ports, such as an
IPv6 multicast group, the single FDB entry in VID 0 is updated to include
all these ports in its port_bitmap. A frame matching this MAC arriving on
one standalone port will then be switched in hardware to the other
standalone ports, instead of keeping the traffic properly isolated.

Response: Currently, the NETC switch only supports single port mode, so
all the FDB entries are only added to the CPU port, they will not be added
to the user ports. So this is a false positive.


