Return-Path: <netdev+bounces-271345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDO3FmpBw2kFpgQAu9opvQ
	(envelope-from <netdev+bounces-271345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:59:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AA31E8A2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A47B6305AC85
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009B2749E6;
	Wed, 25 Mar 2026 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hBJQU1Ox"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A6274B2A;
	Wed, 25 Mar 2026 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403668; cv=fail; b=qAMW8q3V0RzRNbNa4umoasQk1kYKZIqTcx5fqlAiJP7M6N7rUOZkkhDwgWWKUgLSnVeMWYSqjz9nn/H5yql4TfeA//tJ5LEIDgCBvIB/4paMn4bRunTt9+Nbjlio0dLGYgJlUDzB4oogVpkUc/oi4dVHyfrNAmpoQm7BMuBVzhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403668; c=relaxed/simple;
	bh=S93GF3ziq9Yl0tsBdU6JQapcY78CZI+8XwAaPjV2dDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1JXOe8+t4KJWvMfJw57Ew5Ow6f8VlnM3SlNwRvXWsIaxwP676XWIZ8EPZzTDm8fkSz4w2XsZe0GwWYvUboOvXrULHnF3kMFCDiCXzKsfxuHGXUwWh6aQvguL99Hj9aQtNrtvZjNTRNGqJSSzbUbwNjwBBRKj7+IYj7jKN/6/OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hBJQU1Ox; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiBURQb6CC3wkKlPJrtauIkSnNKAiND2wyunNK4nke0EYrjdEwZ3TUI4uYf+TRGvfg4cCXNCFmoILPsUZf+KcdW6JRxZuyv5QwanaTNXXyf7N/U7gaa5v/JhYTjsta6vt8vtt2HXvGASCfffjYuRRFe8GU8h+ded7DdnAcHsx60Pl4rdzuMAlbLbgB2sGtFFCC7EMQJA6YHicZTatsJz/Yxbah/U+HgBKQ7Qy/94EX5SxmMZ3G3cAQfaE8Xz/+dsM1Jc0G1jXQKOzkHHW6EkGqRFnrN6A9p1LR+k49F+jV3R91q0IbQHXRyM03kfPvLc13EnkZ4ABjPfc4PxY+xLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4gIhH2nadxHh5rgvl+VTgl1/OFbwVjNbqS5SD7xIts=;
 b=oXQeOSpNNLLOS6qxutZfO2SDNJOket7XLSthb4Io4nXDOoXLP7IbcP0wDr5cignaLAmg9+XuG75qIZYRUnxc+tXNuWU/43xMtWp0pVbsEK5W8XbtAAaosajhZMy0AaLR48z+olwS0j/gPi0mU4UDFz5M7LlGzLnK0KylG5M9Q8GEQflzTk2hGAZ8oL0soqhhj3f+WbzET6Yzh1OqaMmonbNdKE3nODmR4lLCw7u+PW2qtGFdFtz3RDe7Qqati3FEjcRNz1wfU3EG+85v/B8EtoRLcAC2X55oACNgkJLzeSrlE+c+nmarZEouIa0j9v7FxbzTlsbR0JbnRes/lVcidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4gIhH2nadxHh5rgvl+VTgl1/OFbwVjNbqS5SD7xIts=;
 b=hBJQU1OxgIO8Ij/1lSYsQnbwxzQbSStjBDb/lJiAjVInNyQvSoeiA5z23XHLPid1Si9bFbjdOFESArRKfgZB9uJapMWQsMuNUOasMphN3Fl7lzC4WvC09CQib9PEGc/e9tuR3PUKjD83uTTMoNGTc13CbgIzV5HVxxHK/HW4gov/YXNwSPCu07AMXpioOEdTZHYY/6ioQuWXjd0oKoplOLCkEfAa22jphrzz3sPnzEGml8Yl87mh+jYy6TlVxvb+N/qGcfDGR2xQgYUDBf+UQNFtsZjZLWRqRIjkTI7fZKf1q1CyZ7uCWuSK7Au+c2ZQVv9iYXuhCVNboWDDmMTjgQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:54:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:54:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Frank Li <frank.li@nxp.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 net-next 09/14] net: dsa: add NETC switch tag support
Thread-Topic: [PATCH v2 net-next 09/14] net: dsa: add NETC switch tag support
Thread-Index: AQHcuotJ4P8ZA5lCg06XJ2eb4HH/N7W96JqAgACWtzA=
Date: Wed, 25 Mar 2026 01:54:24 +0000
Message-ID:
 <PAXPR04MB851065E1B3B95BD1E77C8E358849A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260323060752.1157031-10-wei.fang@nxp.com>
 <20260324165415.243214-1-horms@kernel.org>
In-Reply-To: <20260324165415.243214-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7202:EE_
x-ms-office365-filtering-correlation-id: 33e40308-bea0-4ac9-fa97-08de8a11711d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ZVceOpStVUQrz5kQprp/s3DdKWn3pyGH6uBn8iY/0dUDnqAnsYCxwZieEV9/plNhbxspauTwjPnnptUUW/RxYq7G6KuAU8Tsru9LoKL1pMsETm6Qgs/IBpr2G55M15NOhW7GvymMzg/8gVjYAUFKugeDgBi/o5JmQk1tLmTnvy0JG4ymqIlD9mSD2Afq8KWFC5CwrwYtsS0QWIDGyf/cSwa4opl/pzpldOV+qdwH5dp3EfMxZMOGsodbZMS+RIYVXdl1WsQ0JK6xOBcBvi24+5cCqm+C/9DXodjUaM8FMtFSsRTz4T3yF+uv5zu35IjI+DCYwGL2POuNkRrEY/xtsAwuxoP2L1M9sdSUx7gYLBFN3OEexTU0Ww5VLOJJsD+/Y9BXNxdNvbSfu0xO4Vo6LE6dKM3oTb7RuUOokiTcUUqJT0zVNn6Fd//Y0WAU57y52yftqdmBcfW4O7Z29TGGuB1UUhbRfTqdISqJpBmNgo6DVdlCyzIUVM+NUFM7aOjS7W/89IsirHHqqfMuwy3dfuObXAJIxoVcjVHqdjSN9KEiz9fbrbQNMsBSvCv7S15Mr0vP0kHy7wrdDW8ofjV6uE6Q18cCWM18Ipt+JOrL+1bg/WFj8wDkRz4gsu1FyEJXrwbB5W4qQ5X7C9T3r2lPd4M1RChYX5AAPM7m3ONB6rfBGHdBAeWVOzuOS9n9DpNJ0lzc8sNOqbHEP782r5FnOEL4g2CvamrjH7LuD6AmLZgBIFC+MWNNYv1tfQgwKh/Txj6NUkqAqLNpU0FIHdszlN5Tab4k2bs82uBQpWYivDU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ANM+ZrPgK6Bc1Mg8escE+NLHgwM0E5bJz7BOH8Uk1aguwJjMg7CaeMmrqcos?=
 =?us-ascii?Q?THGPX52z8W4qMgBQayAA9WBO08uV9eAlx+BfILnY6H/c6F5+V2BfGmWfo89A?=
 =?us-ascii?Q?zZm5IQ75O3UBA543MMqi/VyCkgULYL4UljdmpqqQ7r3SHlKnA6clt1oe8CAh?=
 =?us-ascii?Q?XFLb5DuWJVVIOFncqZCGX0blanE0gfOTynr4XA/fPxrsbL9g13XjmpEte0xX?=
 =?us-ascii?Q?bV+XPWT7LIJFaHVEet7H/3duR/fupQe/QrkjzfNFnGXkRlXi+fxy1erzwRpf?=
 =?us-ascii?Q?uIP9JN9wsyrjTC3CA+AZzzrT78BIPJV+6CisM+wFjl4cfAMMs5I1JxkESQEL?=
 =?us-ascii?Q?HApXXIrslNmerHVOaVHZJWp7cLMyNJkzx9lM693+TJyNL37wYt+qWd9dTWqU?=
 =?us-ascii?Q?qO5rVVZ308VLEqW3EgSPWPe17g9VBYIrdQocJ3lSKlBwFZw2w8lvDCC3m2rE?=
 =?us-ascii?Q?6133MwT6XOI6dfnBOUUAXykFXNbGdWzhSa4mdh70ZIaGv9CJaS1vz0TB5HzZ?=
 =?us-ascii?Q?SQy2y7eXa/6GFbMi9oD1pj+rIViBMYsbJaRGs7xGc9kYmX7TAqBAwe7180Lh?=
 =?us-ascii?Q?1+OBs2d7cKzXJmJLexu+hEPA62XYe48usc8XUQbx3A13UKOu4mBOObgwT72Y?=
 =?us-ascii?Q?e5v2zFbfo71ZqkYzKav5QjZy04Y9Uhe9CGey7uNvC8hWV5SyN2VlDlFOY03z?=
 =?us-ascii?Q?H+lxFkrQePnt5imk4jYdgTo/JqXn+2rsFvWZxK3Lor8w+p8MoJ4/E46iGuqJ?=
 =?us-ascii?Q?zPEMBEIaoGcMHxPZmBBICjcekh5K0ChPAfIjMt/SHe0Byx/R//7/zP531Lky?=
 =?us-ascii?Q?HFAWwfe2tJubgfjaXI0KSD6CxM3AXbHu0i1hSnm3wx+aPXPa4HQA4XdFlXHC?=
 =?us-ascii?Q?nlA8ueWd4aJdb3IrGmGRm8K/ZZnobofeoQbeX01AmFLYn3MSdm3Pk2Jm71Gs?=
 =?us-ascii?Q?wHQD9g8+UactvTjTNLG/2t5ABBFJnNzOyZMuN/T+nhk6m3GrxfnygaVk0ShO?=
 =?us-ascii?Q?K1ibX7JlyfxKjX6fxhzZCni1YMc3pXcoxJiu0tc42FPoViQmM0w2WG+kAcRO?=
 =?us-ascii?Q?gHaRiWeF8WpagC2QEzNIJ0iBA7r0IsApguvD+xn16BfTkEEWn/yFeEoLT42f?=
 =?us-ascii?Q?C/3GECo5SJKcq0CRsNk09u4K2VWWeOdsgcY0k5m42uk4qft6T31A8q61Y7rB?=
 =?us-ascii?Q?d2IQRL3gNfXmNuQNH15+/4WqECGJDY/BdUsYnqXUdQruyoLB4IUSzrh2S7YP?=
 =?us-ascii?Q?txdBdfvt85nqvShoxdODK0oxij4EQVjQ+iNdxRL9ruND4ekUyKE/VO8JiL4d?=
 =?us-ascii?Q?t9Be5ccZrAu5BCA5o53tsAsuCMVFckGrYysCldDJ9kbhftBhxOWTqTfjGFYP?=
 =?us-ascii?Q?jxHbWJWKAYtev7d0RdMGIcSZ8N8T6Jux8THESA9pV+ToO/SPlqWlm3ikjzxs?=
 =?us-ascii?Q?CcdwuQ0YKCJDAjdb3WHE+USCiE1iIOeQh0Ok3ZBqEnXkHZHlwS5hu/Cuizci?=
 =?us-ascii?Q?ep8rtG1X3QQ+PavelFhjkhXQ0tZTbJlaKyEeepXfl2DqlmTJ7H2LbLxvsqTs?=
 =?us-ascii?Q?W3YP83BbJzuChCkS8YJCTzIPAKOToqW6UjaH2GJAsAqigKMsqUggyTfR7up1?=
 =?us-ascii?Q?GnyfVNQi12kysc0J4oIKiDF79wa1apjsOQe1rTs5GQLl9OHy+5rCFskNb8HU?=
 =?us-ascii?Q?97uqweTtakiLmyF3iVLwJ7HZwcy2NNjXdjI6P6NdGIei/iuQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e40308-bea0-4ac9-fa97-08de8a11711d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 01:54:24.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QJGIxS/K/OEnYuFPh9r8oIye9Wj6yEwUS0g1HgKGoxQ9EANnt8ZAB0pjIVKtelUekBYzfOY0pRzQIqDoCcIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202
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
	TAGGED_FROM(0.00)[bounces-271345-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lunn.ch,nxp.com,redhat.com,davemloft.net,lists.infradead.org,lists.linux.dev,google.com,armlinux.org.uk,gmail.com,lists.ozlabs.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC2AA31E8A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +static struct sk_buff *netc_rcv(struct sk_buff *skb,
> > +				struct net_device *ndev)
> > +{
> > +	struct netc_tag_cmn *tag_cmn =3D dsa_etype_header_pos_rx(skb);
> > +	int tag_len =3D netc_get_rx_tag_len(tag_cmn->type);
>                                              ^^^^^^^^^^^^
>=20
> Is the tag header guaranteed to be in the linear region of the skb?
> Looking at other EtherType-based DSA tag drivers (tag_ar9331, tag_lan9303=
,
> tag_dsa, tag_edsa, tag_a5psw, tag_brcm_legacy, tag_mxl-gsw1xx,
> tag_gswip, and tag_mtk), they all call pskb_may_pull() before accessing
> tag data to ensure the header is linearized.
>=20

I will add this check, thanks


