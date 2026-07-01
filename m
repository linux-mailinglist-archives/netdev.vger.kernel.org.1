Return-Path: <netdev+bounces-303538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ITvEIsjNRGqe1AoAu9opvQ
	(envelope-from <netdev+bounces-303538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:20:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A366EB07F
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:20:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=bw9ptL9O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303538-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303538-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1520C3097720
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54F3DB980;
	Wed,  1 Jul 2026 08:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558743D9030;
	Wed,  1 Jul 2026 08:16:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893783; cv=fail; b=ZFeltJKIHKCnNgE4jVDVyjckaQycHY4+7UKFaHsNYW8x9M95WnTNZD1H+EzVP4aqhgdQtZZY20VN3UupPlRJy4mh3oMnqnuMjrEl1TWPGbleFhWB4prJpk5AVQhmudkEWmbPDUSRxrwnOy+N56/vbhvnqYA9zww2eMRfLPXvAJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893783; c=relaxed/simple;
	bh=wRv9jvXbNr7xHcRboerJ1wYxzGSbfGSodZuxos9J7K8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxSOZV60XJnJaxGI7Skpbi9H+QLePZw4UE4RcpqwBW3OO3tczf4pQTE0CUp4GyeCIbf6sLnrJdPw37vZFjWFXcVIi3OxIpll7SLhBz7dEFeqhraeyPAmbkjD4tLFyWPCy0tmOXavcZvmIBr55NSKP9bk6wFqdhmC/SYtgWDGiLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bw9ptL9O; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MThs95ddQ+eQfdsP93hwSnJRKnXZjKEeTBfzv0/huSESrKWh/I+INyruO83iES+MSLxz1m8QZSn/aAPbYsPOPwgWiR8a1aXCs7mbV+ePKvTvb3F3iJ+7pI51KchzOatg0R7H2Yfx20VQkLCJo5yseQJr2Z+53Q8I+X8vhJ64XtCIiqcVTQ5FSo5oN45vCpmrl3mt48lODMh3mD0EgOUswuT/75Rf6m4p4z0qB2EDI87mSCkQbi3gKHE1YjravcCRnLFyXccbIphVZrSHIFvS3RNd3LOUrfy0ch7nMkGP4smnOhgbt7eq9c0AAoczgPXIWn2gROwZUtTUPmoshzskOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBnyzgt0WlnpLIpzR06eGr2OpORuf9+SqnRt01DjpSY=;
 b=m28PHk+8H1vGIfWn5h8VkhsNnjajd2hrPT2RC82mM3IyoafLgPdEJgbHUVw7JKVqwgjo1D8lrjZv73Rqt9qKZyqjZQMNGsVFuzg3S+ipov6AKWUtivV93Ao8juQnzLAxme8M8yYxv6XS3N6eD6x2uAGJvS/bM2wDYVYPU5simcNiMzDXlK/e1ao8s++v++cxaMkvyu/Nnr9mE+WBQhQkaHzL2AQ2C3EtqUqWJ6zkAfQMedaQOoi7Ncx8ghj2M4/Uq/vjQICqRiLo/wDXsnIIKDuXP2qGoDYxYWk9uobss1qZenJFrh21lMgrNT6h0c62rWiQK9wuHCNYcvs/T7j2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBnyzgt0WlnpLIpzR06eGr2OpORuf9+SqnRt01DjpSY=;
 b=bw9ptL9Op/W1eIxXgIR3UN9HjbcW0gD/oMave/tBcPDKmSStsOe4DdsOSRRL7fmsp9EOJFEV5eeR+tuiePM/btSYv+8PC5xnxmXyWBdj+6NngdW+LUjFmgM3lr2hbKPeXDjjB57qDk/EG0vXBqMy0b3HOPhBDEPX6BxCtYHj1/X70LQ+vhWw8gPPuDNC6Vpx4EGX7zJoQqcgPLNcOiGh2OFtKD4R7GjM2UD8UQj9LnWRPNMpsTtVjpGNyGyWIOXoNVOiU/cOs1Gl67oGrU1SaDWxesELUMrnMA2mqnz/sEdSVK+dydvW9sfxwvbB8l8+W15z+z+YLBxd8v1m3juxdg==
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 (2603:10a6:150:336::11) by GVXPR04MB10270.eurprd04.prod.outlook.com
 (2603:10a6:150:1c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 08:16:13 +0000
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494]) by GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 08:16:13 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: Breno Leitao <leitao@debian.org>, "Clark Wang (OSS)"
	<xiaoning.wang@oss.nxp.com>
CC: "Frank.Sae@motor-comm.com" <Frank.Sae@motor-comm.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Topic: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Index: AQHdCS9Kh6EXypCdTUSz62mUjSw8ybZYUCuAgAAAPRA=
Date: Wed, 1 Jul 2026 08:16:13 +0000
Message-ID:
 <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
References: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
 <akTLmyF0r70Jyn9m@gmail.com>
In-Reply-To: <akTLmyF0r70Jyn9m@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12213:EE_|GVXPR04MB10270:EE_
x-ms-office365-filtering-correlation-id: dfb731c8-bc4e-4012-65d7-08ded74903fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|7416014|366016|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 iTlVjZw0DBu+CIRTnCYMKCQxG6JFD9P1l2DvYzG3fy4mC47Xdx2p8NGZvP0q8cJ4fn8EEDL/sd1JfwWcHiqDwhxaDN5zFyi6JkLUs5n5OIFQnzLZyOPIExDFN1Wyt/nN9oaeZ8WbTwdPmWMI6a04yYQu2Lkem1vgTtRTHWF8kPyRhQw6sb0h0h/8YDBNkf4yRe55US/3P0y7O67ZPFmbxERVjbg0n9friNP/TgzrQuyweThdMHLg6JQKLwBOHbNlU8YXg+0+8Fs0GBUOE+UDXFZ0CCDGHPlndenMb0yrZuOHfmRCFHnXAp6GU+zWxgdHsON5sQipym0a4YZHm4QxKOdBcW9gEUbXgoSyXziVUn1oRMOf+yOk8OBfG25/B+78Hf7c5pJo73jJ/aYd75Ba1mQmfX3KU7FHWU8YNYrCAU8eHBHIbWBaw5pQAbhU7SiozhdTmsyXl94/QsUJP4BQD14RCq/1vEmHo1ZD8tCy5NHcLjBfMDOFDc4M2ULWu30FGKsotVpcS+iqNfEJfYwv0hKL7ktoBVrMkBxrwDFzgg+aWhAwc2IVsdNWrPQTi08MI/5npNJGPJkMtg6SIwe/CPI282lWP4vnbRjEUJCJV3PYNSxFolLJRV0/D5HRBtmLHHcfKx3s1kWRRHaThVD+fwgrMuqyqslNzlT8lllqwvwP3zLw0+mveCrN160Zqyfd16YXBhZnFRkqcX5Ek5tw2R0/8TVDzFXc+FdZiLjs3NQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tZt7RKrjrQFgjbNuSPCyo3Q4SNm47JH9HGPQ68WSpjQNIXtuD/h2YfTpgIhq?=
 =?us-ascii?Q?bSayqmzUVuIacFivcWRs3ostth2wCNH8N9TqfU/A+GWgFwZVVCr+jTppamYN?=
 =?us-ascii?Q?kTAQbfIJ5d71DhumbW4GEYubW3CKw8TTLX7DGxC1AIm9+/52tN264cwEQeP3?=
 =?us-ascii?Q?3FZFvKB6RrkHYl7Yg+GkEwPTf7sdwYXhAz8jt4JDrKaXJaZiJmtd/MuKnY5V?=
 =?us-ascii?Q?Mu5plF6b+zLZooON8JEaV4ZAgPN8899Z52xkKJm7KwvrRIdt7ozT/INYBwpP?=
 =?us-ascii?Q?YHWVf+kz18ZLG+ApO8Bv2jLVTHmwhBjRokabV30UagNp5EacnMS2LznLJyOB?=
 =?us-ascii?Q?PGZYgvsMUoil5715Fh2GPr3qmq4TkOy1FDVKP3hqwOYLD8StzYrhO5zVIzxF?=
 =?us-ascii?Q?3yi2ehSKI5qfi3ckRkAK/tmm07Ei+a4QZLNNiRX2RHAGmPIW3S1VERImNEXY?=
 =?us-ascii?Q?u4R1dPqqC6qS+ErHYdm1rWt46fPKxh/kXG2kdx3H2yP/l4r/qrnV+CsqvM8F?=
 =?us-ascii?Q?ybpIhkHGRLI27mDcB43Ou5UA2Rthn5MRE30Wi29/HnYbP0EDzmYvaQ8yR7N/?=
 =?us-ascii?Q?2P6R6UJjHdHJ+n1CFP9F/YJf4AEGEWsYiMYaCskTgdSZGqC9lw+4WlsielEY?=
 =?us-ascii?Q?fcSnVUnda22yIcDojuPt+8aW/tsNKaG/5ev7ySPdYUy2zw+cXYaPMHdu/19S?=
 =?us-ascii?Q?dNuNMLjtGXYqQIeBRXimdEBjV3oGt/zZoKACPzIJUTFM17Uheb4ZPspn18G0?=
 =?us-ascii?Q?5c6e3vPBxX0rHEcw5/uupCsCt0zueppsBmkzLzcSzHUAkZufsuyE/v6I9h1z?=
 =?us-ascii?Q?wTXR5D1qjmG8UQzKUzuuDvMSoSi4he8vI1bAnQsMt5MbQvKGaJDAgC33RhBg?=
 =?us-ascii?Q?wh630O4iC/Z0tMz0K+/dBTNRt9ybt/xCqEcieMXFnXXF2ugTufYrnSXfBmQe?=
 =?us-ascii?Q?ALLT5ZYsy+OL08wiW5gNJVhvbGqIKRUigK39HOgWLUDKii68vOlNgbHAGTTw?=
 =?us-ascii?Q?3h5cV+mZSin6+2Ho7yDm3OWc8i3GSWUZIraAN7/ezlAG3M88b7UDWm4lWAtY?=
 =?us-ascii?Q?FaSaxqhAj8+xuAVZap8WwG54okhMtaRsNusSs6WXnmcyeDpH4136JMXaLLhT?=
 =?us-ascii?Q?vK3PzfgCj45Uej9PDt70Zh3VWIxhekEeukJZ8TcYWyhRWcZigN0wFhW5/K9u?=
 =?us-ascii?Q?q/rzP049sFV4XWnGtZXIedFZ6SijiP3UlJEepPTIFrSowW8YqxwLlNs+WEu1?=
 =?us-ascii?Q?zVplAqcM6UyHm+xxiUsCfaVmiIA3uh8brCKuVUMdYzvtyOSAX/yUu7Yao2tE?=
 =?us-ascii?Q?t19gTGFkhMHtVKxsJqzunidW+sqVDyffz6pAMhARMkaSURwwUXc38KH6HaNP?=
 =?us-ascii?Q?TTbKsIZh5Km5XidAPaTBgK9Z9VodGCpPxtQdas9IZlQj2nlphXKz7prkssOq?=
 =?us-ascii?Q?5JGG5MQjPh4ggtUvYSux9nDm2lnJsYk/yN2z9eW1hP+ymcAwVrFLYikG/gwD?=
 =?us-ascii?Q?wFNA6iNLMEQIuDmoCweiGtvwnZK4cz7o8uJhMUjopkn3KckPf6r4n2M6F0SU?=
 =?us-ascii?Q?BginQ+bYGe/GxJuuIe+vklXp9mFS9P5h1vB8Uuxv2uA9nZWnmBlST/I7hqVU?=
 =?us-ascii?Q?Cdzn1khBhNuN/Oa/iTgRidJetYelpmFhxm4+7Y2CiIEPY3q4kkiQrD5jr2w7?=
 =?us-ascii?Q?8C/UGdpoJYd5XWOgxvZltbShva2V8jbBxODMOP/Uu9XjhH+zZascDuOILzM+?=
 =?us-ascii?Q?8o1+EpVoug=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb731c8-bc4e-4012-65d7-08ded74903fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 08:16:13.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOdO5ogWcqwHVN7854OXUhXe5O31gKRXTLmsbNwd+su+LnZuCgnlOw6LMVVdD2W9hgJEm7Z+vpfMtVTWjDSiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10270
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303538-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:xiaoning.wang@oss.nxp.com,m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:from_mime,vger.kernel.org:from_smtp,GV2PR04MB12213.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4A366EB07F

> > In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> > driver uses phydrv->features. Drivers that implement .get_features are
> > responsible for reading the EEE abilities themselves.
> >
> > yt8521_get_features() does not do this, so phydev->supported_eee stays
> > empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> > not supported", even though the PHY has the standard EEE capability
> > registers.
> >
> > Call genphy_c45_read_eee_abilities() at the end of
> > yt8521_get_features() to populate supported_eee.
> >
> > Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521
> > gigabit ethernet phy")
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> >  drivers/net/phy/motorcomm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/phy/motorcomm.c
> b/drivers/net/phy/motorcomm.c
> > index b49897500a59..46efa3406841 100644
> > --- a/drivers/net/phy/motorcomm.c
> > +++ b/drivers/net/phy/motorcomm.c
> > @@ -2439,6 +2439,9 @@ static int yt8521_get_features(struct phy_device
> *phydev)
> >  		/* add fiber's features to phydev->supported */
> >  		yt8521_prepare_fiber_features(phydev, phydev->supported);
> >  	}
> > +
> > +	genphy_c45_read_eee_abilities(phydev);
>=20
> Don't you want to return error if genphy_c45_read_eee_abilities() fails?

EEE is an optional functionality, and the call in genphy_read_abilities() h=
as the following comment. Therefore, I do not return its error here either.
"
	/* This is optional functionality. If not supported, we may get an error
	 * which should be ignored.
	 */
"


