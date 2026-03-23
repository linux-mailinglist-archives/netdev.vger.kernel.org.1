Return-Path: <netdev+bounces-270461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF5CFWEUwWnkQQQAu9opvQ
	(envelope-from <netdev+bounces-270461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBAC2EFF04
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C027E3012D18
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B138B7A1;
	Mon, 23 Mar 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bTS2dXIl"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119013090C4;
	Mon, 23 Mar 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261281; cv=fail; b=o0RRvrglSCkgq4Ra8TscPbKJkF8gVqNHQfUB6bIpV3JOKJrpN7a9VQ7qFbaEi3p8nmZmD3xmjlxMnSi+dRf24jN0Fc9ucUVkqWG3+1ijWz2nS5Xdx8f+um+JdIByucznHJLDQ6JYQ+hn5G8Pg1PK6XHzdkorm8R+drjfkphLAAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261281; c=relaxed/simple;
	bh=R1e3lvCknhVbHpjDp3BMffih1L/aPBdvuA9jeT9Olcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQsUV+RI5nSozrCMYmHsRfHPS6jOot3T6+sPkJhRKSIYEXK2+8IjsaOPTqAjE5GgWu2fYV9Qq3htlrAczzUBagIrWS4DF7DL9ed1hbMckSb6RAP/09mdNufWMG9vjc/hwV7kskkjsVDyPR/IaZtZx+ZRjDurvzM00r+DLPIsvVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bTS2dXIl; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJCpdBVZg9xav4E6pYxSfXypQriOp1M9QKQEpIx19635cwNU5X67g/wN6BDdYT1gW/ukAao5idusk7GJHaZLeWFMgfzTBG/CVvTEXTMNp7UADapWufqxvu4qhbMrJg0F9U8bIce1Oab1ORKfuBPDmYOOPWpO0eBni4y+OOpByFnTgo2mHJkjZGCqqftRRCTzOCH0STrdnPZYuBqW0jsirrUfPWj4OfgQrW7oavaCHRWiSGeXxbOIYH2wpUicy3Is+MC3/wGmnf3gtdEVAtCpHMHW66cFJtWPu2nNMttupLi+Vi1mHK3d5HCciDr/lHPMuxXYVjAyBrltsyzQi/sbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkeih7pufrw+pq0tKoeFUy3mK/ef0w38zDphdZtKitc=;
 b=ypRcfI0ipb9nhA+ouEC2xy9ZWidDQkNNvMRWYtFCQVXIt/sUg+81wBW3Vrtejb9oKxYdQjqY+yglBHx/FnSU0TAmkN83E4gyrOtLPYV+niNTYyAii63WikjZSb8YXMbwqXBHRyR//IYbk73W5oqC1HBdfoRQ0Cx4gY9oksj8HaILk2OS3u7uAKxifeRPnbRILsJ877ptkJ8LeuByCmx05QDDMSP64uPLfViusY3yXwNMdpsT7LxFwtJ/deyQssUjDj4Fl7+J4WeR1PCV1kNUZZAjEeKegqkD+5fiCI+ATCefDYx8Qmp/wUPyDwVC5yh8ryvsYzozJ06BUMxiW7QGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkeih7pufrw+pq0tKoeFUy3mK/ef0w38zDphdZtKitc=;
 b=bTS2dXIluikYWoaP2O4F7BNcr3L90CvKW2RueQHpwYbdv1KEk57h7PVd1k27K1hLECpDhfqNf2m2hM/6oTza4aihw3TylJEHPVbvVyNWLbrhaOF2sH+jRuF6Uuu8aDgM2bGEQcwD3/5DyH4TbVIgVeaTwMrobFKQM8IZ74GsY7kRMIkuFbULGube8EfhH79qv4vBDof9gT6uY+0C8ZVHzu7W2mHJ1j6hEYiqc35xmSyor/oxq1d3wqrDnVr2qoQF8msJ4og3SeB89sH/AdgZSy4uZTpE01EdIYWqWbn6TNohTSEsGf6ZwD2yrdFFmnk4JtDeNKTSJ4RTFZZbO7pY1w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10334.eurprd04.prod.outlook.com (2603:10a6:102:417::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 10:20:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:20:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Thread-Topic: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Thread-Index: AQHcuote84lxYz/saUypBRN66PVRZbW7110AgAARBaA=
Date: Mon, 23 Mar 2026 10:20:47 +0000
Message-ID:
 <PAXPR04MB85104288918BAA15CD739C0E884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
 <20260323060752.1157031-14-wei.fang@nxp.com>
 <acEFwqmAvWls_9Ef@shell.armlinux.org.uk>
In-Reply-To: <acEFwqmAvWls_9Ef@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA2PR04MB10334:EE_
x-ms-office365-filtering-correlation-id: 74755bbe-2e0a-4d92-a67d-08de88c5d97f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 j6ZeeywxksAczU+//iAepxaaPpgES8RpG9m8C8UwX3fm3OP+Q69JNDOGTTF91ZJrhRRV9yZCz+e4PEKjvvxlc5sh8FwHMuVNoo+i7ETA1Om8UnorKps1+Rb1xqfh5w9DkLMFoscsRae2KgC3/rJdzPESK85d3AHAsot55duOEUpj8+vXXahM/huScKBB8LEicfSL2XHmGR5LIJHJfeym/Gle3bajDIu2R3zEVnmN4O6LJVO8F+4/JUm9AQFN9SfY5B9eTnTYdIJREHJ0oIKD+btjk9j/p+KncuxZFsx03utfhpLDOjTDEupN7lJbApIzDzGFepedGc7rwMSjId/fCgFmxNtK83HbHCRv45fYhhi0ODd1RPlUlilm0tm0gav9i9KT/Hi1/A/2Bo+A9pmTkeWpwYiC1bcVccDQ4uL5Nl84kqc111MKpgRUHxQ/pFnpl3yVEAp3neap2wAuuUn7rvxKBdEc3Av2+Smazs3prQ9bZi0GSuzIpnwF2Rk7Rnvzl8obYq4Kk0jaGqFn4mnPvYBeLEAHcOGisP5zYecjq29M81fIbk9h/e+mX0TOyyMR/yTnnMXjPV+8cfadWMU4mTwdqnYjhYGX0qK3co6dE36ASxTc+qSdJkGkytrLminSs8xVNwhgFrXa+pxMhDBw2nd9xDvHUzhUEk9Pl4vmP4ZbPwS8mXA+0+ZFiXWEPOEQ2t7pgaXKOnbieEczNXizFWiDvm+UOCtgYZP3wjleT28OY/z+jakrKByse9EAunGBBnEq7KvB3YntlRGv5c4N8US6xHPOWsRIbnVPyNf0XpE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GveJNakoJK71/e4fErRtI1jcJ0vdSNEyMKN4iulKcsJcvkr/jIY8rG1Sw76Q?=
 =?us-ascii?Q?d2394VZYkfngV0SJrpCQcmcHHSuvHtfUSfdU+gRWpcdBoVxfcoECdRhSBW+J?=
 =?us-ascii?Q?JDOaoFrmKhDJiN5X55LwytNLHNZ6mcru4RdUfJvutx4FOarXlI5f1/kO4D23?=
 =?us-ascii?Q?ZfsU9S/eZWYWLdnXvL6JylyyM0fbzMwE4S14vxAc6cG5GEQHbsYpMXfhykt/?=
 =?us-ascii?Q?PaXsxteTcD6YbHjGGgmMjXpin3mAOOTbrW+a+IAKjMslLwsgLabqHUJ3QBK2?=
 =?us-ascii?Q?XHjfspKttVxeSyYBh/j+zYCFwECukWFQbwvX5iIc8VEPjMNX0XTpn6XaMlOv?=
 =?us-ascii?Q?ZFufuZkaN5xzMUQ4SrnNTz/0Bzap1nhTkArueJdSJtCARMmEnDE+37G2gGUP?=
 =?us-ascii?Q?AWpOOcQVBd9iNMsIj6VByVK/7bStpDT7r3g79rtizjY/E1XmvODbhkebaa8V?=
 =?us-ascii?Q?MY7nB46N6z+15O+a/EXuUsFw0d4Mq6caeOfGis2ZN8IIMbUuRjpYSoGN+s+T?=
 =?us-ascii?Q?6dSg36z3Q82UABsS3TB0pMqhOvTY20YQlVe+XaCwUl3LKA8DGegJApMfikbj?=
 =?us-ascii?Q?fhVLY8hAg4Oaw+fgeM9rF4UOCERr0ZMr69VH9Tixlgxmxh3dzLwz7v32rUqU?=
 =?us-ascii?Q?eiMBEm+Hi7PX45okllE1lTfF5vpC+GhWxN4NPK6xSTHiFB7Wdv+pYi1oswvG?=
 =?us-ascii?Q?9LRS9zwme6UsfbhzTa0lXWvPHmoD4oyH7jCaZ7REZK5FYjB2JX8J/uSSssui?=
 =?us-ascii?Q?pXQu3FxA5mJdlWUOpuu8n08ZTREyKi7VOD30G36I4iwegdCnOLcltTJvcw61?=
 =?us-ascii?Q?cEIIV8vrYqR98VO8tAgQ3YWkjDMWeRWDfzmGgomiXh0Y48nLhIigTLI1zOy1?=
 =?us-ascii?Q?YyQKIF5xpYflDFZbl1fhalx+HY26gtzSGpHtfulmciIaxCDK+TXB+IGE+Qm5?=
 =?us-ascii?Q?EAHJ21ZRy/MX48duRZsDKnNyGi4Qjx4LKbCa3JH5eIwp8W8jSYkZPDopeZSz?=
 =?us-ascii?Q?k8Cgb+R0LmaH5M4vN5oTRqx4D24KPGuYkVTETRv6C5yQSrhptiE1Bk25vAjG?=
 =?us-ascii?Q?abDKZ0vTNRHCuckeI8PD0J6EgPmYv9prkyYM3nnSK7rPpAf4wHQSQXO1tcTx?=
 =?us-ascii?Q?DHB8JneaNwpIM8ZCLwKHvVzVjl+JUfubeIaOz81ayUVMdvF1B2NKIYiiapl1?=
 =?us-ascii?Q?CadYkVmBT2bxNTJfHLf+PBFWdQ6yqhPM/vSuNp+dNVATlObjb0yyiczzucY9?=
 =?us-ascii?Q?YYituDMXtAamXpffV//JvG4ErX7FXvPZaVrYQS6rlWKPY8k06gZq4uJEOZAG?=
 =?us-ascii?Q?OCqgeE9hdz0i4umgTVXE9bnjcxdSH0pYw36l/OdHMKv3h5VaTx3usfbu+GKq?=
 =?us-ascii?Q?hvlhZ242VaimIVu7HIfKVkaekpqAwnNjyvEkspSw8dAFvVuSLh5/w/P98Qmn?=
 =?us-ascii?Q?W+/mjNcMh+8WfHmj77UhzVJH+mXopbsulNsk0KEx926h8A0HKXBTJUkYqkp3?=
 =?us-ascii?Q?9LvmmFQqLvqLi11KFHTPGSg5c00HFw1qMttEvdLgRDsJ4ijlwlPIxcnRjySk?=
 =?us-ascii?Q?iqKPvR8opqnUx8JMb4eULDfL0Jh46Z7OjtRkLNArItUE0Ea0hWegQeL6VdSp?=
 =?us-ascii?Q?7L5SqD2V8QEO2Y6iqFMZkis2bjWliX01rj5u6Bdz9UZuybe9pGswi1DDoHxH?=
 =?us-ascii?Q?d/1jkH+lQwqelMWFrpAaHb9RLL7ArjTrotZ5TaCuSc4Lwk0G?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74755bbe-2e0a-4d92-a67d-08de88c5d97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:20:47.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqphzsyvX0W24526C9yyE19rJz5zdnj80ZhTLrca1+ckO5G13ydeLeu29Izg40a0PBBuLqkBBBZGsPKyseMOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10334
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270461-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 0FBAC2EFF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Mar 23, 2026 at 02:07:51PM +0800, Wei Fang wrote:
> > @@ -1288,7 +1411,17 @@ static void netc_mac_link_up(struct
> phylink_config *config,
> >  		netc_port_set_rmii_mii_mac(np, speed, duplex);
> >  	}
> >
> > +	if (duplex =3D=3D DUPLEX_HALF) {
> > +		/* As per 802.3 annex 31B, PAUSE frames are only supported
> > +		 * when the link is configured for full duplex operation.
> > +		 */
> > +		tx_pause =3D false;
> > +		rx_pause =3D false;
> > +	}
>=20
> I keep seeing this totally unnecessary code in reviews of mac_link_up()
> methods. See phylink_resolve_an_pause().
>=20

I will remove it, thanks.


