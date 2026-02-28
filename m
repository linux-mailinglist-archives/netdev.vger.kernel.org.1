Return-Path: <netdev+bounces-262072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g946D2tmomkV2wQAu9opvQ
	(envelope-from <netdev+bounces-262072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:52:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244E1C036B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6203042267
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA433F384;
	Sat, 28 Feb 2026 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CticU/vS"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9B33F8A8;
	Sat, 28 Feb 2026 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250726; cv=fail; b=s/HJBTbLMRN68zaBsd6fdvzGJcrOJpoahZNHsp2V7f4d+gGRZpDBRk8j+OOelfOKpou+nDfmS7Mg9/I7IpoE/vOCTCsTTJw9n9z2e2t9x0E5ss5hHBxX4RK0txROXvoCBRxWbI540aSJ8viyPdX2ZemX7gUrBan+oBGf7VtY+GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250726; c=relaxed/simple;
	bh=L/tFPzCNq49lRmvUPeevmbcaImBSjM82GRz3crY4qz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKa6X9AGYB/PMoBhg6SLQqtVMktqXphipkp9I0ZFce9WMHEU0eAA6KwOqZN+VIHZK3TrnxgbL2mf2wF5YhZGOwRdbzMLPahcXnslKzmXCWNJrpo6G3ODhlVJbJWNYRpp7rEbg4sL1LP4dx6ZRgOqrRh1bXcPd8O9SRr6YcOLy4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CticU/vS; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6Bqa9M8LZ9mPVKyw9lTlMAwllaufEFPmRvM9OzmEFpXbUm/TRP6gRjuz0FRmiWeDmCDBVr60q63RTkzzNXL9FBJesraqLBYrt2ihf1xLfWFLNGSUTtO34hWgWVcK2x4EPlKCsDYZ8TjIHPbj7mo6t1IW9OrBVvero3d/JQ5jjJ8uwNaEutL5vs6uhgEpzM7m1vc3Uym2Wsg4YePVOylCVimezbOLTzOo3UH30Csnpul/JufboyL2hNqFkfdYjucT1Y3C8Q3DFUfvF642p3R5mvUhXHcLR8URIB8QJd8pDHucy0/qieOTLurOK5ZZ20HTMKscBEQy43tEvYk1s8/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbHntvXD4eawRpVDUjFAiKIi4h+CdqKLTs57XHBepiM=;
 b=JqoXaf9GKbiHDwlMf5z4zCV7eKkAZWO6XjhAIhzkvJt+TAOhPWYS7DIG/QtI7tjq11EMVVny4UCO/Q6d16TzViirZ7CfTXcVGe4C+qxr/YWBCrtH5JoWPAfCbsirsdqXm+nffOTw71mr0JXK8fNj5nYTZpm7Bo5yKPk4YYOlnJ4Cr9TZoTh6go8BntwmJXJpNo4TdXUDKGYIG8FOsoblYXLyQUDwfBf9df4NU/Bdx/6i6V8YcqwEqijYuMRcR/f0fYGJUFasXZaNFxpWNOO+ClvQkftK1Ie5Hr1eiKSH7U1vPoqtPpG+lKZqWeyr1bIKllMvEDpwisGDZGkPjlJy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbHntvXD4eawRpVDUjFAiKIi4h+CdqKLTs57XHBepiM=;
 b=CticU/vSA/P6IfywUjANfPE2OUuVfqBgFWTeGQJsoXn+JhhNqHbS9YV18sO7AZg46/OFceM3Ro/cO5XTe4dy7cKnPXuOCEAayTB8kSBReSDti7GETVlodmrXGO5J9kB5zQ3FfLhlBCfufk1oe8PcCD1Tugg+GlTR6iAiNwH9qQojsN/XhGkgZr4jwGzaKVavwYcIbNWSYBiYGY3ivFbFtNrKqAA4W3HQKD8vTIkxQK/sDBGsw4ifW7lD2E4aUjCusigZ+IY51JA9Yb82c4w1nOA6K8ir3V+OBfY6rCtF+1O9eESatVPSWPqotHuXITUP+4OFtGDz3JoKh6paXda3Hg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7978.eurprd04.prod.outlook.com (2603:10a6:10:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 03:52:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 03:52:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address
 in IERB for port MDIO usage
Thread-Topic: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address
 in IERB for port MDIO usage
Thread-Index: AQHcWUIZubUzIGCEW0O6wKhHNvVaErWXKxYAgADhsyA=
Date: Sat, 28 Feb 2026 03:52:01 +0000
Message-ID:
 <PAXPR04MB8510765552BAC289BD5466DB8870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-2-wei.fang@nxp.com> <7825188.GXAFRqVoOG@steina-w>
In-Reply-To: <7825188.GXAFRqVoOG@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7978:EE_
x-ms-office365-filtering-correlation-id: 3a1685ca-ff74-456e-e449-08de767cbaa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 s5j4sf9dmkR9tLAkNWsAQmUsHIMwRXaBYT+koi/Wvy/anqDG0HQMm4s1/eDQfmtJhQSX0yX8V+7NHDYBAQKc1IoZ213mLwQbebPnPac2oQef0GOOF6+1dCFIeJPHaV94xA0J7QdRM/Vs7R8lGcZMlYYRvuKaVutbzycmUcm3gxA5r1b6QxKFUClWNqBQv6jneHzv0ATBr2a9SBkj8T+PAYZZzhYOxo2h/2F+5b79weFmGxi+dNi7Rv3y1ZbAVdjrImEbenuqdmX5kbjijvgMbnuGJyYPdSVIa2ydC87AvqkHPvHmTB7JrTlqzaCp1/iyXyu4E2G8sPba0yPm+O8mYVdS1OM4Ah8UYf8yAg65gps0OoedAgeeDQ4MU8XajDkrBn3iQ072NpjHR3UiEW3caVXOVh0JtwK/FuS7hW0RlqVnSvcVhauAy1/67GniUtaYvlllE+f/9gq72V3ZL3W3gsuRPDyM6I9ic/trHA/Vys56n0od66PnfESBetVGxnULoD3uSBFeLJAWm5bsxRY3OKt1ftayc+qPpdBJREG4mbD46vigBzGd9kM8j/fuu+UMJwjXEmU3zf1yS9SFqs/TGPORzYr2u/wB971mKxHK5WoIiIts67a206A6m5Ve9G3WRmMrSuHrQGYDEDlGMQxtNhHwKHNUPd2tLw5501fMrtbrfJURqiCHTNyg1eNV8T/EVt1UPX046Cj54+YNfZKwz2K/vXGYMz60vHZ8d6Ziu5nmct5qMokwqotU3uH+3wfPrmLWXgMl3Qs/1aZyQVV/Trn7gZN6gbpIMhzKKvqSXWU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BAVBuTuO52uPc+lyN5Xjz7qF7KhfQVqTu/cpZvL9kHBU3kKtsDuDVQCBW42D?=
 =?us-ascii?Q?LIaZ8061PAV0rjZrPRWIzYG61zG/CSO/vZ7w/xrAFnujLHd62it4ZabPip2U?=
 =?us-ascii?Q?oeyc654SR89wngeT82Wf3mt74mn3CXbw2hBXA7dNrVKkF0kAVYXeu02VucHz?=
 =?us-ascii?Q?K66lri1f4mCHzJGQO847FpaFPbhDYAfC9rESat7ZFLCQR9N3mhMV0Lmq1iQz?=
 =?us-ascii?Q?i1Yz+eelkhNUaUUem/ODePRL25tXeGGyl/Fm95V6n9jBQNrlDEGmt9QTYD7x?=
 =?us-ascii?Q?QoB2Y+4u3R+iDXcThyx8F3+6L8SlPGjQWPJCJ4oofZp+E279RjhFuDoIgJtD?=
 =?us-ascii?Q?/oeRCq1hEMM0ZhmKa1Rp6pv6twWw8xYN1+O9wVHFRsqPLcJnhNJnDWlvfEQ4?=
 =?us-ascii?Q?nHH9JXGPv7vUG+puSsb2df8FiMjtLidEZokymkrrYOY0UNxQeUquQS9aavj6?=
 =?us-ascii?Q?tT40vtkmbAUFDRnXyqSMJLgzbLCYhD1R6juWE43tuOW4W84KjCM2NkkN5+xw?=
 =?us-ascii?Q?xPi01b4NKo6jNRttkoV4LuEv8oEd0sv/yjqCv5scK/b6kZShWnigCIEODmDG?=
 =?us-ascii?Q?yeIxbhLwW7RHRS6yOxYhpJtvng5YzCKrLGg/cR3zIMNVtd2L+vrZqZsRLeyK?=
 =?us-ascii?Q?L7siDFh+UUa+FmIMtfc8QSh1bk78zqsbFrZSYwD2WbfjjUvuKu4LnMsA0dCg?=
 =?us-ascii?Q?GOu4fmOMMGOzypXqJj/wo4M/7TC7BaCAMb0kCT57h108QR2xf5r78gsSm8cN?=
 =?us-ascii?Q?p3bE+pk7HUJZeRKNesSD3Kqd+Tkt12b7d2tcVaEREfD5/C+njkkaThVnRuj8?=
 =?us-ascii?Q?L8u0FgDE+Mg6eYRxsbXtyA57sQNFRXN42pYJPCR4poDNHs1LE83ZKas9yVTn?=
 =?us-ascii?Q?HRY5CXAnCFsRRNv5jTEvQvfV+qiqNeJweUfjdGLVVNtedOv2ElI/W0VIEFEj?=
 =?us-ascii?Q?6XDIaq0B0Vj1r3OaqRMKOVlRkBXbaO+L7RceHbwcVtWe1YQVLKoxvRXQcAQJ?=
 =?us-ascii?Q?bzXqy6WZBBYCwtFhNCTRoAmCN5geypqRZm2pwYRkCpFPV/mVAQ5V2TYJ7Zx/?=
 =?us-ascii?Q?khP+zpA3DizCD9cO+mImVJraNCZktAencpYWVTGr8plvh+hRjQver23j7NNM?=
 =?us-ascii?Q?QvW6OOtIyfA6+oeSF8ak+H7c8boZKzd7J/ExXWrrtM1NVy3ArtqgfGOihOu8?=
 =?us-ascii?Q?Hctf97E9DwLiGbaB2zF8llX6CCyb5xJQzgoQQn26nohW8jN0wiZMdlK8z20p?=
 =?us-ascii?Q?3yvM68kvV+7S22GZ4vHg6nzirPPoA/mjJmkyGF4nXPpo/E7j1PfXT9i0RyN9?=
 =?us-ascii?Q?s3cwxnBxQswb47paXbGLX26hdpMjolZgttxECGP9JiJ60llUQayzwBIfJmpY?=
 =?us-ascii?Q?t1bjWmtdWW/FGoE4het0iVoRzRrtsx5KPrva55D6BpZNCHvEceLhMtRGFzZr?=
 =?us-ascii?Q?DPGCCEoQLAI+N1Moc167+Ht5TkQt2nqszokSjnJhGFRvWURBFNRJUF5VI8je?=
 =?us-ascii?Q?J1Px9sc0FhwTIBbqI0Jrq4w8FgaYzBAQLZr6iCRIWdiPOa6lPUDU6cH35+jJ?=
 =?us-ascii?Q?RiUpQkSS/nX9kj7pLjRPQ82DkZIGxau4ToumZVQOrj+PbWExqi3w0jw7Z1Mq?=
 =?us-ascii?Q?F6Jqk2dqJuArI6PfGA6Xap3OSTgyBPb0HL4vO/bv7uKMOhfBd/zUIFcW1vk9?=
 =?us-ascii?Q?6b3FNHRJECJ93JK/cQo3KU7uZP3UN78diFEU2cGAQleKIuYK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1685ca-ff74-456e-e449-08de767cbaa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 03:52:01.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ib5OWSzy1u4KRhFJx85LSApo2AHSqnbRK2ONivm0l1hqlN0tqepis+ZNVX4/P7CX9oiUia3tHhqo0nVtEQUujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7978
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262072-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8244E1C036B
X-Rspamd-Action: no action

> > +static int imx95_enetc_mdio_phyaddr_config(struct platform_device
> > +*pdev) {
> > +	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct device *dev =3D &pdev->dev;
> > +	int bus_devfn, addr, err;
> > +	u32 phy_mask =3D 0;
> > +
> > +	err =3D netc_get_emdio_phy_mask(np, &phy_mask);
> > +	if (err) {
> > +		dev_err(dev, "Failed to get PHY address mask\n");
> > +		return err;
> > +	}
> > +
> > +	/* Update the port EMDIO PHY address through parsing phy properties.
> > +	 * This is needed when using the port EMDIO but it's harmless when
> > +	 * using the central EMDIO. So apply it on all cases.
> > +	 */
> > +	for_each_child_of_node_scoped(np, child) {
> > +		for_each_child_of_node_scoped(child, gchild) {
> > +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> > +				continue;
> > +
> > +			bus_devfn =3D netc_of_pci_get_bus_devfn(gchild);
> > +			if (bus_devfn < 0) {
> > +				dev_err(dev, "Failed to get BDF number\n");
> > +				return bus_devfn;
> > +			}
> > +
> > +			addr =3D netc_get_phy_addr(gchild);
> > +			if (addr < 0) {
> > +				dev_err(dev, "Failed to get PHY address\n");
> > +				return addr;
> > +			}
> > +
> > +			if (phy_mask & BIT(addr)) {
>=20
> ... which will break here if there is an Ethernet PHY using address 0 in
> 'netc_emdio' node.
> See arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi node
> ethernet-phy@0.

AFAIU, the PHY address 0 is a special address, below is the description of
PHYAD from IEEE 802.3 Clause 22.

A PHY that is connected to the station management entity via the
mechanical interface defined in 22.6 shall always respond to transactions
addressed to PHY Address zero <00000>. A station management entity
that is attached to multiple PHYs must have prior knowledge of the=20
appropriate PHY Address for each PHY.

Therefore, for most PHYs, PHY address 0 is typically used as the broadcast
address or default response address. In designs that control multiple PHYs
via EMDIO, it is recommended to avoid setting a specific PHY to address 0
to prevent bus conflicts.

If the PHY on your board does not use PHY address 0 as the broadcast addres=
s
or the default response address, then we should check the PHY address first=
 and
then check the phy_mask in imx95_enetc_mdio_phyaddr_config(), just the same
as imx94_enetc_mdio_phyaddr_config().


