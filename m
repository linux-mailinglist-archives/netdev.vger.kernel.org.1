Return-Path: <netdev+bounces-262583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q+qGIyhYpWnj9wUAu9opvQ
	(envelope-from <netdev+bounces-262583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:28:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B51D58A1
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A37300820A
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE438CFE8;
	Mon,  2 Mar 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DnVivYae"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01114400;
	Mon,  2 Mar 2026 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443460; cv=fail; b=b2Giz53b8tAuTDNz/p7zc2LRX73RaxJ3vVnBQtZeuwDs7cqfuFXnEvPCIuw5G5bJXBcEbWT2nWl7Cus99oGzhiQFIP9Ys02Q4WWvGxXJUBC/IxBrOCB76jtQgk6++WzpoGWvMNGwPI9j1i8NxCmiwTkoSOg9rIpoGqqwJn2O1nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443460; c=relaxed/simple;
	bh=p45iudCLXRMwWrXrjv/MW11YScakdji8kGybWiURdGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIAEtbaIQS8+GKVGajpIr85O3m0H5Qyo7HfxK+5YZQaXCE9FvSWXH2cGur4xUqyZhLsVGFopl/P9fPuHq2sZ3oK1VZIY6yBQSw7dlEuIH3+984lSPw8vlZPtcFUHz+BwfLgs5VOeDyJ2+rSkHp91kTlMf5IvbxrKTmHgFvwRZy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DnVivYae; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAxhvx59VBSIxtbu8Q/5Fis3deoy6yaG5dVqVvwSEIel/fyI8eZk+pb3yWnD5qf5/tMV6VM8WAkaeI6pZMHTxqzwaYCQ7/Kvc9W7Tp23rrhHp49b6C2FjvwcDuegl2JfdHc+upXCooupLx1e7/ewVqmmHiLCgbIgEhq4s4pJyp09DdU/Hbb4pL2XMq2rs29e78mKnsPHrqdjuFEKoxEaRn5cIsXqit7cQ5P1IwK8nuD5uxZCdEkJ6jqTIBgBa9YxhtPeRve0lZm2QIFr9TFi9lUd8DdvpQuYFzpfgSxtuXeodMXoGgwUQndIaMxucQLD4f5qwTJ7Sp17y9SrzglZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mns39rtrC754GmD2B7F9l0L/fz2PubbSCQ294xnwL5s=;
 b=c5RQIxnpPMT3iNsn6VB9cdRPWo7p7nyTVthMut4Ugf82rawrIPQegDe3Z1iMposBi5J1JftpcjpkfRKqSWu4ypZUfJzzmtE4uiktRBmwEkiR4rN2u+fhCqUK2E3Z4sfYTqBjj36N/U1PzfAixp+6vKvXCKUnHVLruM1mndXjm+950N1zyRH4agOW9gPuQMZGdrGSA3s6XlmsJTSDvwSVCOZTDpk/w2uBDUGOAwhYx6t5xuotT2jwSgMc4pkBUWUBf1Md8Lu8OfFM4892jFAaL6l+tfrqJT4/UT7tmJ96dpWJhQ463mdfyn+rKdFi1VfawxuT4WKx21BrMYbSHn+TgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mns39rtrC754GmD2B7F9l0L/fz2PubbSCQ294xnwL5s=;
 b=DnVivYaeNj1SDcBXhT7GTAyI0X0HBGle+98CKF8qE06PJ5gJ7Adz43EcCxPAHT83CTFlvs8vBG6RCwaju5KXKMMKYQNAd/BiLBBpa6VgeF158rqWTvM3hrkVFkbVWbWWyD5M+uFnz3Z/C5X7TGEUQXdQ3diKXc+EEDntzzkCLbQr0Z2XYP9uhxlSnRNP3fXJ2U8Ad4qQ8pkJUiAAV7gUO6Bc3qERxjS560pv2RGWaeFdQ7/BF+whyb9yAAcpG3Ltds3yGU7vtOiKwm3V2RUOLW8gjz3w96M9t+8SmLX5FB5PzLvOcwMXCbiWb6zKZkEYUic4hnuWpOYg/kF3POxUfw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11455.eurprd04.prod.outlook.com (2603:10a6:102:4f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:24:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:24:14 +0000
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
Thread-Index: AQHcWUIZubUzIGCEW0O6wKhHNvVaErWXKxYAgADhsyCAA4l3AIAAAaTA
Date: Mon, 2 Mar 2026 09:24:14 +0000
Message-ID:
 <PAXPR04MB85104CDE52FE824736E44ACB887EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <7825188.GXAFRqVoOG@steina-w>
 <PAXPR04MB8510765552BAC289BD5466DB8870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <5972322.DvuYhMxLoT@steina-w>
In-Reply-To: <5972322.DvuYhMxLoT@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB11455:EE_
x-ms-office365-filtering-correlation-id: de042238-524e-462b-55b7-08de783d78ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 oNBcQCZ4hwxdoJICLVMGCizL1u2BSQ9EiACwRsg2E164ReVdKTpAtrFKzkDkM3NPg1ai+eYqdFJIl9x9QzBON1csjniWTWr2XQQJHwfWfhTkLiLxOW62qsG5M+2OKl9EGKDHO+yEdSuvqPBsr/l0LP9aheAROUUMmfzEu0gYs+NBdq4n+B+vu3JITiGye7a2+dc7u58Q2FV6+KPnniJaZ1dg46n63hURwtBGUnrA50FO5cJmpyCFzLjz43q72S5c3Afk+b7sB7Gr2J7PNDql1+oJxV1q2pTgEzFtSXa0Vp3IRKoM4WCm87tWDX/RGRz6XZddpNGIlUeAHoWIiwDjeI61Orlp10Nzt7oDwqUaY/9/Ht++2SeQ3EH1LxFOb8VWnY353NNQ9T/P60F3BLzaDhT7Ugmia3yjJNo7fj4F7a3b4XO9Mww4/GudvdtbeHt2lntxMLXqKR2UCbTwvQAUfO0K0IGT9JtCxTqwHYMOIKKIAoY9L/5Jc/U75j2WHitEVzmg43S2tYIkfIHfY9oZzuQIqy9YjVLrUDzd9B935ZT3BxQoBtbU3aM3hn97UaOaQF4jhal1rJJE6ZJNVScCsCYbxwF5OqH6gLZk4Ic4UWCC//cqbUhMSIeckz2f6nvbRU/M2HKn0BbfMXPUASa5YYXmqfGUEn0fdDNbHKM7Fz9aXyqjm0wbrGPbpbaqdwBxH1g2aLi5jzdgcnlfWL90QEpLsXlG/HmeWbYs+nZnoL5Du8PfSymhvkgl5ruHpYz/n1rPu1Se7ua5bqnUGmXkGK0Y8I2pvonyGLKxCMt02kQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t5/E1jMV3I5JUd9tncW4EkaZ6qAsRzxJf8UvVqNNXKm+qAfQpEF0sQTaDuB9?=
 =?us-ascii?Q?2Za8h7JGCsCctyn+m1s0A5tL82z9YT2RnUdx/X8aT9j0nAmtl1XH1+wKWiUF?=
 =?us-ascii?Q?uTiLGLZIiKKv1EOWhKYXqTamSYtT0ixCfr/8qQEJuiWBjJTUDeLjoyHnnjaQ?=
 =?us-ascii?Q?YlDVVB4WkGsSA47hgV/XncJZv9jnhfSlqGKfGsQ6HvFCaZZinGQEikumyUCI?=
 =?us-ascii?Q?ocTu65c5VLSrdSLajst5lMAjjaAzYAaHz9usXIYwQKEpO3k6dZLjKNP0Low/?=
 =?us-ascii?Q?zGPts+7TdoooytExizSxe2LKWrzsjJYn1lBBQNTw8foHDiWEIX+KL5xhm3Gz?=
 =?us-ascii?Q?VzMmBwTA4Qf69NeyXz34vkm9w2djTYTJASoNdU90thxP0W/pi1T1XuInx0ty?=
 =?us-ascii?Q?RRJQn0OQSc2PrU9/IHN7C6qJeRu8DXVkFGA0lMed3Rzwe+8YY1591mn7u7RN?=
 =?us-ascii?Q?V+4D8SUZMYuGbtmCd1JDl20/BnPhk83go8x0Uqp/GJ5wvP2faCnv4m9zR0sa?=
 =?us-ascii?Q?ZtCDibmCgcVW7Hv8sUBzVqCySoOcQRMJKkkU1LOrG3qQ2haofBx2O7o8CWxn?=
 =?us-ascii?Q?lOEm8tg7tOGf/aUDOMTdUDs0AVjSoEiv7R6avkLHm/MnQH6wnvl7FfYKJCtH?=
 =?us-ascii?Q?jFGLoNuO5PfnPZ+Ki/QmhZywpHulE/2gofMvBsG/dd1xRxhUscVsj8Fci/UF?=
 =?us-ascii?Q?kUxak2kbx6OVOCxn6v34lYJ2qgkBovlOjzExNnooDm5m+4kFtN1CP/O7YsK3?=
 =?us-ascii?Q?vHgcjzxdwB+GhSF0SoF7PV3K+MLjyI5OOW1MTDh7xE3unKbKP21pQCJUHKMK?=
 =?us-ascii?Q?kXFpmaKxETp+HYM43Wo4hkS4KC4hxgJPedtT6aYctVSnG/0MciJFigUbd5uH?=
 =?us-ascii?Q?mEzIonQ6LU/dRyxFJ58r6T++gPEK/WPyII54C5rFtsKgf1igzgR3VJlUGAVG?=
 =?us-ascii?Q?Z3vUFPW3ROae0t+ITECPuL6bbO6ddwxGmMUAVhyBKgFSZZka2B4C7/bRAbXV?=
 =?us-ascii?Q?9qO+/g+rjQD8naYFPMDoG6hYRcPMsLZ/6GTximhXmiX1JkDTeBctIwfzojYT?=
 =?us-ascii?Q?19MinhDY1IcWxh2Msu9zGOXYdQ+FVyEeyZP4IU7l0E0FrUZlyfuueOD/iC/O?=
 =?us-ascii?Q?Ph1BrgWFjcUTSkrRpmbRaAvirNDheE790RR9IaQ46lRIfLDMjropzs/Vmwhh?=
 =?us-ascii?Q?ZBmL3dfM7H3/h1G9EAG4el8LEE0AryI1oYZVWmY77/YClGLKrnakKMgTnB0d?=
 =?us-ascii?Q?JpQqEtt0qvrkuHMNMw9Q6IlvXmbQf4tPEvoqxmxHoVD/kFfO5fIzGuCFe1Iv?=
 =?us-ascii?Q?tOEqVcGMXM6hqeZmslE9Dn02ysvjDDYYh8NeeOLxqESLkn0e3gB4w4wcgnyC?=
 =?us-ascii?Q?RMswEu3d+6Q5tWMRphWkH1r61n5pDE9g0pvwjCnHc2XwTq4R8SIsemue/M4r?=
 =?us-ascii?Q?giqmF0eyXshuzQjXrAiYTDBHHagUVQG4mPS6ejdb7I5WlB0MNJR+dyEJ2592?=
 =?us-ascii?Q?xphG6FL1Uy9wmQA3mZs3Kz9BopfHLWg2jodvqtbhc8MIWO13mzUoAxM6B4pg?=
 =?us-ascii?Q?IuuBB637EeGgrFZBIlnxzxW/Mmy/00hv+j3GxBjzCUF+2UgJOyw/1ghV5nEc?=
 =?us-ascii?Q?viuTy2qgFpRdSGuJAswSIbUHC5swjZn2o7CxWsuwMi2EMxA8Rpo+bpg34JSU?=
 =?us-ascii?Q?mXtlymN08U36aJveYpvWxvPAjqrzmjBZu+RX08VgdCbpJEZj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de042238-524e-462b-55b7-08de783d78ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:24:14.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fswltiB2lSMNz57yrMN9PErwEU+Yg7+x70sNdE3W2WydZ4cOolC2Zx+iUqZj6v6vdp+VkLYphYejNZ49he+biQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11455
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262583-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE2B51D58A1
X-Rspamd-Action: no action

> Am Samstag, 28. Februar 2026, 04:52:01 CET schrieb Wei Fang:
> > > > +static int imx95_enetc_mdio_phyaddr_config(struct platform_device
> > > > +*pdev) {
> > > > +	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> > > > +	struct device_node *np =3D pdev->dev.of_node;
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	int bus_devfn, addr, err;
> > > > +	u32 phy_mask =3D 0;
> > > > +
> > > > +	err =3D netc_get_emdio_phy_mask(np, &phy_mask);
> > > > +	if (err) {
> > > > +		dev_err(dev, "Failed to get PHY address mask\n");
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	/* Update the port EMDIO PHY address through parsing phy
> properties.
> > > > +	 * This is needed when using the port EMDIO but it's harmless whe=
n
> > > > +	 * using the central EMDIO. So apply it on all cases.
> > > > +	 */
> > > > +	for_each_child_of_node_scoped(np, child) {
> > > > +		for_each_child_of_node_scoped(child, gchild) {
> > > > +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> > > > +				continue;
> > > > +
> > > > +			bus_devfn =3D netc_of_pci_get_bus_devfn(gchild);
> > > > +			if (bus_devfn < 0) {
> > > > +				dev_err(dev, "Failed to get BDF number\n");
> > > > +				return bus_devfn;
> > > > +			}
> > > > +
> > > > +			addr =3D netc_get_phy_addr(gchild);
> > > > +			if (addr < 0) {
> > > > +				dev_err(dev, "Failed to get PHY address\n");
> > > > +				return addr;
> > > > +			}
> > > > +
> > > > +			if (phy_mask & BIT(addr)) {
> > >
> > > ... which will break here if there is an Ethernet PHY using address 0=
 in
> > > 'netc_emdio' node.
> > > See arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi node
> > > ethernet-phy@0.
> >
> > AFAIU, the PHY address 0 is a special address, below is the description=
 of
> > PHYAD from IEEE 802.3 Clause 22.
> >
> > A PHY that is connected to the station management entity via the
> > mechanical interface defined in 22.6 shall always respond to transactio=
ns
> > addressed to PHY Address zero <00000>. A station management entity
> > that is attached to multiple PHYs must have prior knowledge of the
> > appropriate PHY Address for each PHY.
> >
> > Therefore, for most PHYs, PHY address 0 is typically used as the broadc=
ast
> > address or default response address. In designs that control multiple P=
HYs
> > via EMDIO, it is recommended to avoid setting a specific PHY to address=
 0
> > to prevent bus conflicts.
>=20
> I know about this special meaning, but there are hardware design which do=
 not
> take this into account.

This might cause potential issues, as all PHYs attached to the same MDIO bu=
s will
respond to the accesses to PHY address 0. Is this problem unfixable?

>=20
> > If the PHY on your board does not use PHY address 0 as the broadcast ad=
dress
> > or the default response address, then we should check the PHY address f=
irst
> and
> > then check the phy_mask in imx95_enetc_mdio_phyaddr_config(), just the
> same
> > as imx94_enetc_mdio_phyaddr_config().
>=20
> I'm not sure if this is the right fix. What about the case where phy_mask=
 is
> supposed to be 0, because there are no PHY subnodes of netc_emdio. Instea=
d
> the PHY with address is a subnode of the enet_portX is supposed to have
> netc_get_phy_addr() return 0 because that's the actual address. But with
> the current flow from imx94_enetc_mdio_phyaddr_config() and your suggesti=
on
> for i.MX95 case we erroneously skip that node.
>=20

The hardware default value is 0, so no need to configure it. I can send a
fix patch this week.


