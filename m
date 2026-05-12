Return-Path: <netdev+bounces-286958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GClsDO7CAmp7wQEAu9opvQ
	(envelope-from <netdev+bounces-286958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A67A51AA39
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C88A73049293
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77587426691;
	Tue, 12 May 2026 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="US6NRwxR"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA3541324F;
	Tue, 12 May 2026 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565642; cv=fail; b=gvfWV3C1sx3X1UYXvbqCc7S0JfEPRo6xUNj7CITAgQ3iOhfmSkmVhB79bVX3yWdXZNR7++8zFS5dHigpoYptA+7A055m+pvItL+UvL91ZGSzgyqvQyoy1u6Rg9zvWdC9Mooqu+c5SsL+cRelofQbbTSbIffUg2s1eyJUSOmDfI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565642; c=relaxed/simple;
	bh=usdDkMJlXBZim87XDthzA4K7De1+GZty6dtBr4eNzSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DbK5gTDUddgfROSQfXMaxUpp2cB4JNB34858NEyzoa+7wxBr1xtYZVz/FOZEq+ekJNGrmqQ2sL3lMd14qa6Xkc3Re1VV5K3E3VjX1dbsiPFz6yd4pP/nwK1PcFZ4gYDKuDXCJ/qvhzWHUeQnpFgr4Ll+BqYzfSFcflZMm6BZi7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=US6NRwxR; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6OvHnpSEVvdWVUf03oAg3BcDWDp05cGvjcleuz18TZmXlno0Fq1vrADe27XjyCnnIVt1k5RThlP5wcfYJO8Ogi86uRbx8EkGF8nByvKa2ryYkpZxoB2qnxQXM8Nt+yDhbsPQ/8NJJxxjPEaYQf6uZzMGMtip2jqLuScWLlN3h5oDWKOCDzXla6AvInTLb4f3yoaKBKaI6bOImSHpcVGEK7AQJWWOCzgaePHhaEuu5sXi5Y+AX8z00plAct87vwKocdXnoCRMyQV1hz+bA0zN/xC7kvyFyNaAzhRHMpa2wd4Q9WkFogLkft9/2S7nR76xPHz8Cd6yHj0PRdO+VEjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw0xowMNR4swZOBo4JPbgW37vC/3fB8GbaVWXp4+IT8=;
 b=uLxuW5hclrhQDW14tzcTUm58YuD66LmzNkp5M99ZWw5Aj+tZ9MUsKeAeVzA4lits7vUPCbblJH8TrkHDyao4xMDBRQUtolhidihKujXHx7TTF7DIaJdDF36hMIRVi22+YasrLWeJYaUkf4JudwKQRwmSOjKwBQVT68ohIxn4oj0OhFtAGf8fGl+oYtuSdBgVnnz11qQR7LGh1ggY7pCU/gR5Rjky3iQ+Wxv/Zsd2Y2U+e64zsYsWJSv4GPLuaZCtlOfO7xUW5gc7tDM6ug4d5leawPvIaEv9/5M9ylYJLbxBGh+JfwfxpycufVFLAvSNNkvtbzssEgwpBavml7PDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw0xowMNR4swZOBo4JPbgW37vC/3fB8GbaVWXp4+IT8=;
 b=US6NRwxRtlbknfTmZW53N+IhLIpPH675Suqy4idAs0Pr9X8Ze/FLQ9B27mnmYZkuCMjY1dmYaUr8dVKSDvbU86V3KNsuhOHPiDPY+m9T/8zNAiICNBXRxNdBJhGUhyRRkwlibDFrkcfXGm2MiWcuIO0ubGB83MmoT06kD4kFK1ov/GJ92v0S7MJd/bIeqedTfLJfbSaLPIRmmCEy7nCoX0wGHhtZJbJ7vBuSO3kzMe+BbeIVcoCbzQsGJCA/iSRG5Ei5vtTwxSiMh95l5yRUCl/QIsZAiF8bmRrBo2H/34nOjsxFdImHaARffOWi9cmv9xocJshxQgsaPT4F6locFA==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GVXPR04MB12014.eurprd04.prod.outlook.com (2603:10a6:150:2be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:00:17 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:00:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Networking <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>
Subject: RE: [PATCH v6 net-next 15/15] net: dsa: netc: add support for ethtool
 private statistics
Thread-Topic: [PATCH v6 net-next 15/15] net: dsa: netc: add support for
 ethtool private statistics
Thread-Index: AQHc3560uEq/mPxEPkyFK/hht0XX6bYJt11w
Date: Tue, 12 May 2026 06:00:16 +0000
Message-ID:
 <DBBPR04MB7500B5FA0EF5BD3B13DEA0B488392@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
 <20260509102954.4116624-16-wei.fang@nxp.com>
In-Reply-To: <20260509102954.4116624-16-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|GVXPR04MB12014:EE_
x-ms-office365-filtering-correlation-id: 5d04b4a3-80f2-479b-fbce-08deafebbe02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|22082099003|18002099003|38070700021|56012099003|11063799003;
x-microsoft-antispam-message-info:
 E94Zkeuf3rZOj+uAY8WSn6t34sUy+UDGUgaN5THHwNAhWLvLBI/OdsjorJxxgZ+j5HHFB5zRc9psSbbHxcg7he1HPaJU1W717L1eLaZxdrVY512CtP2OOFYj6hW+bSmDm2rxIeF9/4Kk8Wo8q3p4vdrjYmniyUZd1+lOejqY3CvjIiNZhxZQOsqaALkYPo8Y6SGbw3hL1Dwh8qhn+Az5tf+jJB7SCqCw7agFWqUqj97WyyM/OolmdY6+/1luRTIwjtrDmjc1mUSRLloi5NN0lnLLB2vxF7cjNfjymKWnMzL6nqZOvTcwWynJ9qhbynGi2w5xkkyFt5XYFBbO+AoYhH22m5KxFUBu0oSdn3kItRhX+uGb0+Y/DwDoUGvx7sZS1vv22sn67tynYHtTNbHlURTKhnAYNPyZnq6zDFi5ZNQzqHUZSfk8JPdgxbiaGNpbhhh2dYr/F69C4frNf0xWYFJppKSGeOgJNtynDIPyWAFxBLnsndoMo87A+KSLt7Gd4bUaS4WQn7JdenUCOBQ5t1mWz47YiAkJK/CKgyx9b2CmRHWNN1e2tVbLdLfCSMZttynVlsNrGT0naj2nQxgRLN1wj2uPv3XNA84adzcuXOXGhVSEC2PKe4T/3YFyb5zzBWoRiqHieeb4JaLiIruSV6n2h1F/9cfwt6I9+7ZgNnHIbjSC2nvH/EFNR0Vk00PFY7iWnPCrCev0k9U12H52ZA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PUZMXy0lVbRn48FtboHnPGCV9JvL2ae5dUGv/k2kDNXTO/Jz2xw5iImYD3Pz?=
 =?us-ascii?Q?ggD2tGVVtp7FjgSOXGfKqkvYpts+dG6Xjvzcbx+Q8Xd5OgYzjq/oLjyMSsxs?=
 =?us-ascii?Q?0r0NiFSt/tFFwdUgyVE4xDALlO1K8W1ac2dv3P0XSQBQBhjY2e1De3XDHpDM?=
 =?us-ascii?Q?02IP9xkXcBKoOS4WKEavlB5rKm3FLsRhG9p8A5FuWZaMFBtmjYyUYmKWa7BV?=
 =?us-ascii?Q?g8M/1npv8KxC9kXrKQNw6NBJh6cnwWCsAzjfXKz7Jm7lPsAOPk7riGTbKgtl?=
 =?us-ascii?Q?9z8y7scXnLTZFHUSFvblAUy6aCAukGn+O4r4BHlYtT9OBuHV5aChCnGONtRC?=
 =?us-ascii?Q?6Z7AZPBBZjVZ6ppRy074mvlMETN1RUSoKd5IcnAnUU9A5vBDHybijP563z72?=
 =?us-ascii?Q?tWSKNzhe95tAVqF6hI2bDXCIvEje0f1POUrYH5gbzhZM12/kF1IaB37bi1Lp?=
 =?us-ascii?Q?1pVbh86CNF/RoqZW2c59bdtwzbWVUuxgI/l2akPvJI4qDC/5e+z/ELroS2zF?=
 =?us-ascii?Q?kDm3zbmVhJu1eNKE0ELCkHgwvAeqbJAgruEg5DYMH6nOBu4iSu5imy5KCJcy?=
 =?us-ascii?Q?7lTFROWoHxSN938DNRD0xJQsXY7+eYVdtuOMKfL8FuL17CzW6cYbCuCXhPli?=
 =?us-ascii?Q?qejzNZaNU/dWOEkKZeOmrjrKbr5yWzWbi5XsMJOC0a09fSYsRc4tOG/95+sy?=
 =?us-ascii?Q?OZ+TYF8gS+Qv2uR7hzx7+GbUxiVnvdeMl/U1znVnUYC7HX0TT8mpul0aTgv0?=
 =?us-ascii?Q?fdI5wniwAvPji+dpApA3nL9Cnt8aGIcTgI2Qzz2tEmAjzziEgBwBxAK3Nc8B?=
 =?us-ascii?Q?m125TudOv8wH50tZPjzYaS+QII9Hu91o7Gp9OHH/MsCrQJhoPXuQB+f1gUyx?=
 =?us-ascii?Q?/eV7TcU/nQiHEPtChn3elanaGMTkJS0BV95fsC9t3I/iOgFaXOxVyelByVOO?=
 =?us-ascii?Q?TvKVm4SoN1FpTrkYEuqpIEwQU9l1CP8FZWBpows/DbGGPN8SgPA/uWFoY4ZT?=
 =?us-ascii?Q?wL8OlN2vpBiT88pZpwLKSG14Qx1MC25hPMg0+UR05ZzKTmbR1Ambs4ySpYnB?=
 =?us-ascii?Q?N7T/dfegekIUputtK1W3dnoElfK6nbBdmmkLYNCbM2w7srU2eIwub6o9HuE7?=
 =?us-ascii?Q?w1QEcHAYtrtqr8XTZQDxbl23Kv0fEw18DxeG7V5yp/VrIUM/Iw2Zq4tvEnxy?=
 =?us-ascii?Q?dof6c43ZfOlLEnHOs953BJotAlicoxcz+dLriJ8oJbu1bI07uydcO5MjIJa8?=
 =?us-ascii?Q?FrZVeFNDNIrYZgaFsoQq7BJMBHXQEXEZFsTf0m80U/R50XSggnNYE7sy+FMF?=
 =?us-ascii?Q?cOHIPTWxHU7qREJ0oNFlwoyAOylOInWY0ENIsbZqXGClVvqEn7Q/mkSulhae?=
 =?us-ascii?Q?59AgvgAmZagwrvU2+ao+98sng+EZCdTxDhnDPgK20iapL6r7/W2od5zmS2Qh?=
 =?us-ascii?Q?3kDCnYkQOk3TjmPlz9q71jR0iQB9npglM0cWYwxZ/6O/oGEvw4KQtrQwurwE?=
 =?us-ascii?Q?IGZQvzVDlKKeoikpOMR+ftZFTOKzHlRVJpQRO2yHGeXOYxRY+2AZ4EMfRmdt?=
 =?us-ascii?Q?il3AdmaYeyQ0CLpotJtAarZ+3lz5X9fvWk1hB+Wx0QBnmcT0kIpVRZBvRBhl?=
 =?us-ascii?Q?3AdgAs87GbEee2PH7/aj7AMgJvGmZo1fILxYQvajzQFOTUNmrLZ863h+gSRm?=
 =?us-ascii?Q?4ZIykXHZakEY1lhM4yKQ4qLgigagHvd9q1zwNVHgbgDFw/RH?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d04b4a3-80f2-479b-fbce-08deafebbe02
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:00:17.2953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQMA6Hy3g0Jw4MvtFh6INWmPdsaXMuDk1JQH6KSB7eMj3xrfsRheFfpABA75YVmeg4sj0KNECisoFgQWw7hA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12014
X-Rspamd-Queue-Id: 1A67A51AA39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286958-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,bootlin.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DBBPR04MB7500.eurprd04.prod.outlook.com:mid,nxp.com:dkim,linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I noticed that sashiko-nipa aslo reported some warnings, most of them
are minor issues or false positives. I will fix/improve them in the next
version. Only this patch reported a high warning, but I don't think it's
a problem. See sashiko's comment and my reply below.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260509102954.41=
16624-1-wei.fang%40nxp.com

> +static const struct netc_port_stat netc_port_counters[] =3D {
> +	{ NETC_PTGSLACR,	"port gate late arrival frames" },
> +	{ NETC_PSDFTCR,	"port SDF transmit frames" },
> +	{ NETC_PSDFDDCR,	"port SDF drop duplicate frames" },
> +	{ NETC_PRXDCR,		"port rx discard frames" },
> +	{ NETC_PRXDCRRR,	"port rx discard read-reset" },
> +	{ NETC_PRXDCRR0,	"port rx discard reason 0" },
> +	{ NETC_PRXDCRR1,	"port rx discard reason 1" },
> +	{ NETC_PTXDCR,		"port tx discard frames" },
> +	{ NETC_PTXDCRRR,	"port tx discard read-reset" },
> +	{ NETC_PTXDCRR0,	"port tx discard reason 0" },
> +	{ NETC_PTXDCRR1,	"port tx discard reason 1" },
> +	{ NETC_BPDCR,		"bridge port discard frames" },
> +	{ NETC_BPDCRRR,	"bridge port discard read-reset" },
> +	{ NETC_BPDCRR0,	"bridge port discard reason 0" },
> +	{ NETC_BPDCRR1,	"bridge port discard reason 1" },
> +};

Should the port rx/tx discard frame counts and the bridge port discard
frame count be exposed through ethtool -S at all?  These look like values
that map onto the standard rtnl_link_stats64 fields (rx_dropped /
tx_dropped) reported via ndo_get_stats64 and visible through "ip -s link
show" on the DSA user netdev.

[Wei Fang] The port rx/tx discard frame counts and the bridge port discard
frame count are used to count the number of packets lost due to certain
reasons including buffer exhaustion. By querying the packet loss reason
register, users can clearly understand why the frames are dropped. These
counters are not the same concept as rx_dropped/tx_dropped in
rtnl_link_stats64. For example, rx_dropped should not includes packets
dropped by the device due to buffer exhaustion, but PRXDCR includes them.

Documentation/networking/statistics.rst calls out that ethtool -S is for
driver-private counters only, and the networking review guidance asks
that stats which already have a standard uAPI not be duplicated under
ethtool -S even when the driver is not currently feeding the standard
interface.  Could the discard frame totals be routed through
ndo_get_stats64 instead, leaving only the truly private parts (the
per-reason RR0/RR1 codes, the SDF counters, the gate late-arrival
counter) under ethtool -S?

[Wei Fang] As I explained above, I would like to keep them in the
driver-private counters.

Is including NETC_PRXDCRRR / NETC_PTXDCRRR / NETC_BPDCRRR in the routine
ethtool -S read path intentional?  The "RR" suffix on these registers

[Wei Fang] Yes, for example, NETC_PRXDCR represents the total statistics,
while NETC_PRXDCRRR represents the statistics between the last read and
the current read. During user debugging, this register, along with the pack=
et
drop reason register, can be used to determine the cause of packet drop
during this period.

appears to denote read-reset semantics; the sibling ENETC4 driver
documents the same naming convention, e.g. in
drivers/net/ethernet/freescale/enetc/enetc4_hw.h:

    /* Port Rx discard count read-reset register */
    ... ENETC4_PRXDCRRR ...

netc_port_get_ethtool_stats() reads them on every invocation:
    for (i =3D 0; i < ARRAY_SIZE(netc_port_counters); i++)
        *data++ =3D netc_port_rd(np, netc_port_counters[i].reg);

If reading PRXDCRRR/PTXDCRRR/BPDCRRR clears the underlying counter as a
side effect, then "watch ethtool -S" or any periodic poll will see a
delta-since-last-read value rather than a cumulative total, and two
concurrent observers will perturb each other's view.  Would it be safer
to expose only the non-reset variants (PRXDCR/PTXDCR/BPDCR, which are
already in this list as "port rx/tx discard frames" and "bridge port
discard frames") here, and move the read-reset aliases to a one-shot
debug interface such as devlink or debugfs?

[Wei Fang] Currently, we do not support devlink and debugfs, which
makes debugging packet drop issues quite cumbersome for users.
This current approach can serve as a transitional solution; we can
remove it from ethtool -S when debugfs or devlink are supported.

> +
> +static const struct netc_port_stat netc_emac_counters[] =3D {
> +	{ NETC_PM_ROCT(0),	"eMAC rx octets" },
> +	{ NETC_PM_RVLAN(0),	"eMAC rx VLAN frames" },
> +	{ NETC_PM_RERR(0),	"eMAC rx frame errors" },
> +	{ NETC_PM_RUCA(0),	"eMAC rx unicast frames" },
> +	{ NETC_PM_RDRP(0),	"eMAC rx dropped packets" },
> +	{ NETC_PM_RPKT(0),	"eMAC rx packets" },
> +	{ NETC_PM_TOCT(0),	"eMAC tx octets" },
> +	{ NETC_PM_TVLAN(0),	"eMAC tx VLAN frames" },
> +	{ NETC_PM_TFCS(0),	"eMAC tx FCS errors" },
> +	{ NETC_PM_TUCA(0),	"eMAC tx unicast frames" },
> +	{ NETC_PM_TPKT(0),	"eMAC tx packets" },
> +	{ NETC_PM_TUND(0),	"eMAC tx undersized packets" },
> +	{ NETC_PM_TIOCT(0),	"eMAC tx invalid octets" },
> +};
> +
> +static const struct netc_port_stat netc_pmac_counters[] =3D {
> +	{ NETC_PM_ROCT(1),	"pMAC rx octets" },
> +	{ NETC_PM_RVLAN(1),	"pMAC rx VLAN frames" },
> +	{ NETC_PM_RERR(1),	"pMAC rx frame errors" },
> +	{ NETC_PM_RUCA(1),	"pMAC rx unicast frames" },
> +	{ NETC_PM_RDRP(1),	"pMAC rx dropped packets" },
> +	{ NETC_PM_RPKT(1),	"pMAC rx packets" },
> +	{ NETC_PM_TOCT(1),	"pMAC tx octets" },
> +	{ NETC_PM_TVLAN(1),	"pMAC tx VLAN frames" },
> +	{ NETC_PM_TFCS(1),	"pMAC tx FCS errors" },
> +	{ NETC_PM_TUCA(1),	"pMAC tx unicast frames" },
> +	{ NETC_PM_TPKT(1),	"pMAC tx packets" },
> +	{ NETC_PM_TUND(1),	"pMAC tx undersized packets" },
> +	{ NETC_PM_TIOCT(1),	"pMAC tx invalid octets" },
> +};

Do most of these eMAC and pMAC strings duplicate counters that already
have a standard uAPI?

[Wei Fang] No, the standard uAPI is implemented in patch 14. This part of
the statistics is not supported by the standard API.

Several look like direct overlaps with struct ethtool_eth_mac_stats,
which this driver already populates via .get_eth_mac_stats:

    eMAC/pMAC rx octets (NETC_PM_ROCT)   vs OctetsReceivedOK
                                            (already exposed via NETC_PM_RE=
OCT)
    eMAC/pMAC tx octets (NETC_PM_TOCT)   vs OctetsTransmittedOK
                                            (already exposed via NETC_PM_TE=
OCT)
    eMAC/pMAC rx packets (NETC_PM_RPKT)  vs FramesReceivedOK    (NETC_PM_RF=
RM)
    eMAC/pMAC tx packets (NETC_PM_TPKT)  vs FramesTransmittedOK (NETC_PM_TF=
RM)
    eMAC/pMAC tx FCS errors / rx frame errors
                                         vs FrameCheckSequenceErrors and th=
e
                                            FramesLostDueToIntMAC*Error fie=
lds

[Wei Fang] They are different registers and the statistical data they
produce is different. In addition, FrameCheckSequenceErrors is used
for RX not TX.

Others overlap rtnl_link_stats64 (visible via "ip -s link show"):
    rx octets / tx octets       -> rx_bytes / tx_bytes
    rx packets / tx packets     -> rx_packets / tx_packets
    rx dropped packets (RDRP)   -> rx_dropped
    rx/tx unicast frames        -> derivable from rtnl_link_stats64's
                                   total/multicast/broadcast triplet

[Wei Fang] As I explained in v5, rtnl_link_stats64 is used to collect total
statistics for the network device. For NETC switch, its ports support
preemption, so each port has two MACs, the netc_p/emac_counters is
used to collect statistics for each MAC. Their usage are different.

And tx undersized packets (NETC_PM_TUND) overlaps the rmon undersize
buckets that .get_rmon_stats already reports.

[Wei Fang] The undersize_pkts of struct ethtool_rmon_stats is used for RX
not TX.


