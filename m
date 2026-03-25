Return-Path: <netdev+bounces-271347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDe1BNlAw2kFpgQAu9opvQ
	(envelope-from <netdev+bounces-271347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:56:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86231E839
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39387301C974
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAD2773DE;
	Wed, 25 Mar 2026 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EiZEzkyX"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060327281D;
	Wed, 25 Mar 2026 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403795; cv=fail; b=nLsMtrz6JOpeL4+fE2X5fW0Adw3I+GMNJyu/En2rH0JOmKKyntNwDIZBesqbOtC7DJjcptC1qvff33xScCtbx3yPkx5FvcSPReC56AD/tgAPenZvYMM5t1/PgoOeoRvnwFsBeip26XTbe1UvNKiovgYi5xBI+t090/hGVCvddh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403795; c=relaxed/simple;
	bh=YQqN1GinGe471bc6JXBxOY1D3d5/UHNBJb1XlqcRf6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E9sGyMol3vDUnl0gBfeWysz2/HSav9ba7qodBPTKJptKfMQQILwkCjWj5saclnzNm6r1QAuBKDM/WsrMf9jF9XyqZ5lsUsa07OrJeKUiZ2SXMPIJjshFs0sbSBxcY+Z1tuLMW8IIHcC3Z+Rz3exiDACBsNbo5myOnJl6Eq964M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EiZEzkyX; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR0J9tXUuEFcUSGMcBu5afd0zYXIVTLV3IqxjxlUgAP7flMl1l/f1LDmOwF5Z02lfigGLo1mO/xc8RUXl0LztmkwzKAq4AwQwi5kQ4HtPTf8dxawFo3qBdCRcPO0dNCSvh+VaT+0dX7xDDY3lyDxW3dbEBAGk80E7fJcjqDdKGJ7lmd1Rjig4BdRoea6cKMDvr4JNHRQS+2QOXXh2Ouw6Iy59pkVnmyvAGOkuKK6Myq1N8dw790eWaww7CGN71z35LFIm7Ow5sAKhqSCklqI1ob6al8no/pYZiC+/1wptMqnBhVp5y9zg/NffR/hiM/UVcNPZR1bXKwN3mXuiSayuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LipyGb1uaKFgVErsUBU6k7iGPDKWaO01Rw4TAi07lm0=;
 b=FO1os2AhvCewQnkRKmV1yXmWpuZ94GGjtGKaQC/5z+854GsPN47wsZnvsf4XdvzTAO+FYNHm1tYw0qwaqYuMXVSjA1zYs/k8/u2bEmHi4I8iVdJt0J5xKOrc+JFYLU6kX5mRksctbD4rlgFRwiCJeu3R5N0Sb8Coz8y8l+IPszNn7XTSqjD4EuWavpzcdLp47MYenH4VOIdGyMy2pvyC+/UjYY9uNqn2AZZSrqcTCtNTT98unDFuHIyhYNAFEfWVa+axt5cOuFcjdRlWO7HeoHOZofYkNm/yZ4OP4Eagt3QWs/q0chyrvKdIdJh8zf2bLQ7SjGfNxcMGWHfVBLhOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LipyGb1uaKFgVErsUBU6k7iGPDKWaO01Rw4TAi07lm0=;
 b=EiZEzkyXc0LGOWmrHBlJrQZl+0zNSMa47NOgggmUjuEJbYdhjwcHYtCYiJlwXvjDBL/gPnAesi1zA1ex7AAg0DH9RniD/nvK6KlbaME9sF0hKgRS3ZAW419gaG/9pyYzbkl9onz4jliDzqjX9hz0JjLiemjHu0L8JVN/zTBnZ0QU/h3nVMOztdVDPh5sO1knCDsW/e0l9DyqzXp74XVmw0PapTjVzYDQLPamxHXa6SZzuRVjw6v8e6+H4FKxvIzWy5+sUElt2bsY89A5FGlwd8IS6Cvx23zG3IXwDmbdikJbRzCkDO0CaPTgeltn69fWUmYi5D1WRtWcSBDL21PCbQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:56:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:56:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Clark Wang
	<xiaoning.wang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v2 net-next 08/14] net: enetc: add multiple command BD
 rings support
Thread-Topic: [PATCH v2 net-next 08/14] net: enetc: add multiple command BD
 rings support
Thread-Index: AQHcuotFNlR1yxQ4VUK/tt2odlv6rrW96awAgACV4qA=
Date: Wed, 25 Mar 2026 01:56:30 +0000
Message-ID:
 <PAXPR04MB8510F3131FA262918E4329678849A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260323060752.1157031-9-wei.fang@nxp.com>
 <20260324165804.245011-1-horms@kernel.org>
In-Reply-To: <20260324165804.245011-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7202:EE_
x-ms-office365-filtering-correlation-id: ec803d3f-2b6e-47f5-916f-08de8a11bc21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|20052099010|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rq74nPPxcL72SY/BORtZhJEAOzrtNX8jxioK35ew8VPh4ssiD0vQ0A/1C01P2v00Jjeefn54a1fLVe4eUIduB9MbKKjo0UifvdjIZSgP9Ho+FVk6MT0/NeajFVNtfJUPfuqbUJlLbaCKgonrDB8xP7xUXw35NJE1q1dWqOSL8I6Lua9nZBoaHnmz//zdIAe/gARsVO3Coow2JvTC/zXtF+FQU8uK9XcQPeB1uaN+iX3IF0dthexvthZfH3rMA+KXYxSjYh8fGbjn1cQMswpD9HqlEbJ4pJORBQuEm8NyAoLIn8TNi/UdLaGAd8bGOg9oBnAOpPSJq8B7o5lO3mDLtmHAFF6mCEbmDOKxbaHQlNdcxevNh8Ji2NAil8jRoUC8uva50F6zWI7YH8ivhUZO35dtfoy/G7inIzw6pMpQPazqulYH7P/fjEauVBk4R0bDDwGb7s+lnq7QWRVpEAA448t4v+ZNfA/x9XdEOZh3SMr9cB7n7wOb7BGJemUxKdn4ZwEG6Qo0cj9csBrZp7vqFGQ5qTdVb15JUdoReiGxtfHocsz30ZC8+LS/XKmnp0ZNZvOCDw0kl8wsLc5AjkTPqREDCl9nCuC169WcWnP84s0RRsKaw9DC7G/yKL/fvMxbr4Qv4W++RXTgSInZFX28/f67DEuKxqHh+oMeAp5U4PQ24Wr5CSBFmljEirLN6akMnp+sadj8WiEwtnwvigcSCO9C8puhh358eh/S0ex2IhTrQKpiyrLVFMvApw9rOJWNbfkpNpjo2R2PF4sKLf53KcMOVBxoDW5ofiw+o0DsJlk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(20052099010)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aYbVLvqhI9cVsuWd9nUtz5dAJg7kBNE98tlw/w3ZHbKwtPvV1Lt4ywA5hQtK?=
 =?us-ascii?Q?Q8awA5rQVDc42nicurZ4b8S+xxbKc6k0EPtW+HMx/IxWLjnEUhY9YmQ/eCL9?=
 =?us-ascii?Q?AJBvh6lYMSSD+/9VoIYt41Q4/bedZ77IUoV5J8Iy9N5Ze6bSHE429HYIK/8I?=
 =?us-ascii?Q?nviPXu27VckHMz7mLxub739JJEoOdo2zbisVEz3IBC8wvfgHoCdMv759uY5R?=
 =?us-ascii?Q?+auiHY6ENFler92M1KmW5XIU3H6o3z1b3r1l8HodGDm+FVBu9S/KHAG23RAD?=
 =?us-ascii?Q?J8rl8EP1NCK4xGXmnYdxPH+GVSR9SABzA7qj50lA+7fAKYMynZI2q0pYwgDf?=
 =?us-ascii?Q?7Xr2adiNt9kLw0y+HPPRAERu70pDLQjKjIIeSWDrcmVqVlF5VIjgmvww7rf6?=
 =?us-ascii?Q?nW64S6AWZmSYoLB4KQYDmKeiyeiSa0oI9Yy97CtgSW9Kzn8w5pboRptStoAV?=
 =?us-ascii?Q?K25R+zlho0qmfd22rah3ebKV8/XKNZ+1jlocCLsA8yL7bfaRHIJ14E0OP57R?=
 =?us-ascii?Q?+rjEWDaengHMTPIu5Ui1XlVOmA33tUFK9HDCqRZdLWBtnxrJkvNGmpqLXoFV?=
 =?us-ascii?Q?m1kGYIudyv3VES5xTFvrsDGNLOt4f8vL1Mruk7LaLGkPOxBMBxYDRX+YEuaa?=
 =?us-ascii?Q?CffQNRU9d3PVSx11traz4fNCtwARZjXsXhJ9OV8glzpR4yl73S/dG+tRg7Uy?=
 =?us-ascii?Q?/dnACE3FtmE/zkqaIc+4i3XtSgPWnQDySqRrBbdp7gEqbHnZLP3iSukOmtFQ?=
 =?us-ascii?Q?u2sYO4SgVb2owTP05wv57thVdc7WwHsv3yflGYbw2YC9FpyOIJHXbT94oZm6?=
 =?us-ascii?Q?SpyU4E2ekex/JLfyG4fYaG0CbPOBtValghUwZ0Wl38AL3EtwRnvJUaYRlzMs?=
 =?us-ascii?Q?JYmvv07kEWLNaD5JmpxcEX50xq/KRBajbllUZhnsn6tDPCX74FCt+eTJ3O3a?=
 =?us-ascii?Q?9+LNZ3009rX1/FfJN8W1XV3+VgccXNwM+06xtobsbxsp6n6TJVxKbURiiLRe?=
 =?us-ascii?Q?wuePg18zlYIzq6/8Qz9mTYqMBAWRxjoWNBE6VeDHdbEF/2Mndnb3Mxn+ung1?=
 =?us-ascii?Q?+qCgxX0Avplnk5GizZ8+asLsUCAwDwduiiln49G2J4gdTlzOgqC9VwDxm8oa?=
 =?us-ascii?Q?CxFX6fgZ8FFfOmvZIY4P7pF9V6w8AzGxRhOn3t/9ZksshQCkP63sdXlSDu7+?=
 =?us-ascii?Q?42cmof6pSdRj3osromJm+jsOi+lNdMDw/twDK0KSG04ZfgSnpSPYJckq1pIo?=
 =?us-ascii?Q?eYdklt/xd48g7OsRyFjzT4WztIojnFVBndvTKgdqs2JjO836OJnhUBkEyWBn?=
 =?us-ascii?Q?bbs5bHMcXV8EVljS0eWsR7LbfrEg77y6Fzvokn0hj9KrBTVKez0YGfXUTY2n?=
 =?us-ascii?Q?dlNQgMNYBwUA+li71XlrW107pKZsy0LqshvjA48AstdDNKG0H6ZBfgDL8lAC?=
 =?us-ascii?Q?vCrdlY8gtRHf8PFr2R9yDOT18yXrjLF7UklE2e06RgRY6CmNuavT9VAsSFM/?=
 =?us-ascii?Q?NBSN9SUyBEIYaxeTN1ItC7LpLeakEZ9/ldivMVqrDyeuLw53yBP7H8v1iChc?=
 =?us-ascii?Q?HszY6UCGbMwHlPFZeCbDNlVSoRXpEjW1yrgp/OZ9wyfNDnE7FEjRGOz8WvFH?=
 =?us-ascii?Q?4X1aMSqSv4QAulpvw7r3lgx4TTfTqqjJb+PKhyCKoc1qIDTP1O6Z227/+43s?=
 =?us-ascii?Q?r4u8+sVn9wnhRF6XQ3f/A3O242ecWWFZRmRW7hZDy/ujt5qZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec803d3f-2b6e-47f5-916f-08de8a11bc21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 01:56:30.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQExwxvJGqqUn1/UscOZ/PItk2Exd4dS7nAGCTCqzHdobTchxaU7Aa1YcKED795Kl7CR7tzNh4nqFk/ejM2dcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271347-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,vger.kernel.org,lunn.ch,kernel.org,lists.infradead.org,armlinux.org.uk,google.com,redhat.com,gmail.com,lists.linux.dev,lists.ozlabs.org,davemloft.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1B86231E839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
> > +{
> > +	int cpu, i;
> > +
> > +	for (i =3D 0; i < user->cbdr_num; i++) {
> > +		if (spin_is_locked(&user->ring[i].ring_lock))
> > +			continue;
> > +
> > +		return &user->ring[i];
> > +	}
>=20
> Frank Li raised a concern about the use of spin_is_locked() here. Is this
> lockless check reliable across all architectures? spin_is_locked() behavi=
or
> varies across configurations - it can return false negatives on UP builds=
 and
> may not provide the ordering guarantees needed for lockless checks.
>=20
> Would spin_trylock() be more appropriate here? Or if this racy check is
> intentional and acceptable, should it be documented why the potential rac=
e is
> safe in this context?

I missed this comment in v1 for some reasons, I will improve this, thanks


