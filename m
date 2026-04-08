Return-Path: <netdev+bounces-276308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E1rH7P+1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:07:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542B3B7E49
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 596B0304023F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6150370D73;
	Wed,  8 Apr 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kl+d9im2"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEC36494E;
	Wed,  8 Apr 2026 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631865; cv=fail; b=F0dWrHGhj7G4GdC6mKgWQy0KPFq7lXc++EB7MaDg4hrfTm0EKQET7HKtC7JZGhyOrjSn+MsO5NO6M8/7GpTN2j5WxT31pWVh/WmF4iGv8OQss3fWgnBqphal8kM5tNIQt8mgrUgwN1Iz+1GlGWKw4QtO7HcMKN3mR/ngcbEflwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631865; c=relaxed/simple;
	bh=2xsTCjUCJA3LHq4GviEXhcSQ9rb5DewUKmwArK745Yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Laow7s7AChDhlGq57FeyZO8hrNwlUjolVsQ2F+bu7wWJcwj6icfV64fIDTmvWWMJ4vK+sbhIpXs96TvB4wC1H9amzXMCdR+4Q4iT5cO5DUhCkkpBLpG3yGZp/grDIjQIZa6Yy0OZ14uIFPl38kJQCD0SUfv7Fa87TLR9kyebuiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kl+d9im2; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbk5nOJ7sgRd5U4bfrcz3WQs2D6i8wFJc+i6Zc409chZXXfqO5EFrqb4+ICmEJbOA0iue+xdcbEHkZXuDJ2fKfduMhG3TSCQYvj1IKxGvASduInzCanxLRsbcg8N0zVO1sjyJQPdb8nAmMWRdhUhDkax8YE5Nu8xPp8N6TbVXZ0vDHBwCcZJN/0Y82aR5vG5SLgwA1K/7Yv8+y8oGWFQK7ViZAk1o/We6J7Ijf7dtekO9TB/0i3Khdk2nM9avpzSQ8EBJ1nlHfcdFwLkpvo9a/N1Rym9UbagSpxOqluV4wpVTG2a0COF6ujSicaKHQBuSPlQC+B9YG8k2MVvwr6GhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thl/VlRtRCAG8/l486DdbwYWOadfiLXeSMDKznREDG8=;
 b=IZrI5loG3mvRvP7WblP9gP+6KTP5iBQC6/jcnnoXL6WDuoNsX0N2jMWSLOfPtCHIhjBsdkj+ImnKmFlMNcdsMnUUudy30EdG+Wor9xGCjuRIKA5lMUgFbq9JfRx5sebVcQdFZM8Ip0L310Ojzzmcv/Mh9iqb9x23Zw2Jljhx42yBncggIQUOh/vRY7ma5/KFFJjHTHS4GbIn6EnJbxDJwIcpQ2qE4bSIUudbaV8N1h4Qqb7QNsjQ8x/irUczz02GPdDk14VHIFI2i+L254hCa9KqRAEym3r80jcZnJnJszkAJWd5uoZPHX2b4ZvpRtr9+I9/gHU5snZMySB2QXwB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thl/VlRtRCAG8/l486DdbwYWOadfiLXeSMDKznREDG8=;
 b=Kl+d9im2Nh0PsFFqg6Quxdld5y89XMqmqyHtNU9OdGh6iiND8edEWL+npGHlHUwCJRpls0FMcA4xa/F5MPdp46icVR5A81jOLuIAQBmcP9h7g1ThIOH4YC7eW+5maCRU57k2ihfRXh2lNhK+DV0lvaybRIXf+2DZnHNrrUfxKmUCKZ1vOxnEfhZdSkNOFSjmi+BzKRInS+FUb06ewUT6Pnm18BZtmVLjPeKJavjyze1kHZPGwnVGm+UVG4MiQEclcyJ/7QfJC1JypSxMSYkcnPcJyoSdzAw0G1nal4bzQYkHTCvqGkVfWT+Y5IHCX0CaFuM6OeIFLou7subSn1Nu0g==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by GVXPR04MB10611.eurprd04.prod.outlook.com (2603:10a6:150:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 07:04:20 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 07:04:19 +0000
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
Subject: RE: [PATCH v4 net-next 04/14] net: enetc: add basic operations to the
 FDB table
Thread-Topic: [PATCH v4 net-next 04/14] net: enetc: add basic operations to
 the FDB table
Thread-Index: AQHcwQGRdpZmLUMUwkGdnLHx3d+rArXMjUAAgAg7X0A=
Date: Wed, 8 Apr 2026 07:04:19 +0000
Message-ID:
 <AM8PR04MB728494A137BF1BF72B39070A885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-5-wei.fang@nxp.com>
 <20260403011727.1795379-1-kuba@kernel.org>
In-Reply-To: <20260403011727.1795379-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|GVXPR04MB10611:EE_
x-ms-office365-filtering-correlation-id: f7a9daf8-c38a-4715-41e4-08de953d0e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 ueXBzHzvQ1mR2ouX/KAFfKi51ph0waxXll0UWJi0hhMcbTGK7aSSa+QnfXFQO2TH5pG/dthDsy7AzrA+U+iwnTROQEI5HTdKd5zU0CQOVeB48BImoNWiYs3bcfseivNrJU3P2TmbF867Z5scTZxzVmAGSeJCA/7bw8YfadBR9BpXfxlCdwfk+a2qE0vjE5biIE1ITh4KXQB6ayvVrcA3Z+f6DkBzpYg1349Zu626jrv46ILbEShkI/4dHedrRSc/xJ0io28+n7JZmRFANZltCm/gMXg8mY6MD1/4Ch7uPBMul/w3MH4ZY20Sz+B3tGaUZIOANKRFB5Pyur+PDNe+96but8b0hjSCBk93aUkvyTmbVUr1bZ1ep4CUnfq3RdS+1TK1Gw7z6vFyw3+AjR6n2+z0H8KZzlj//+Sq0bfVlMEcw16nj8arH6sjscdL/Rm+YEQpEopukpXEyt3lkyUrLKHBrKaNEgoi03MyPWJl4zVsGrMxjpbd4J5M8DET+b7uPjP2uwjWAMSzn04IvzorQ4boHiWvPmdVVOY08i2Yji75+yevepiQX4QhwPl3FGqiR8hJXAcHbVfx1ot++R90kMhDr8jIRJFgWOHPXI2Rr9rICTZP1jE7kkH6DJ2vetXQtzcd5DAyPP6F8RuhxGx38bTaaFbMS0tJoyn58MkE/9S13u63j4VD3J3N+RCqq4LL1HFiQoPCBcVzff0CjKCAV/Aiw0bAnvqWzwYq5geEdwr1yZxnTDUejD86h5khru1QZ/NvO2xGZEuRrZ4VWa3fVe0kUZyXGjabBsfRP7THAoo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o+107Qtb5q5DJ1Uyry6l66oz+Bg9jEBckt3KHfIN09FZqINPR+q3BfhNhNhf?=
 =?us-ascii?Q?sVbbiV7GBa1zLpA+QZv2SydLzxkW/znru74uZ02kaCQ2mbnnQaYHQDjNmzPh?=
 =?us-ascii?Q?Mv9L2DW9ujkNqvkgC8/lQsX+2RT76er3SomJvyodCFzbt8+FvpDf+zSXziYp?=
 =?us-ascii?Q?esI/D0lHn0SR8DgNyBAjmORgFR2SoCN/hW+6qYief/euZfevoVG5s3plQ969?=
 =?us-ascii?Q?z2Tt2ngbJIE78KczkSDShVqSzWBlTaVx8X1a0jZwT5LzFZWmgeqWIA1zwol2?=
 =?us-ascii?Q?ZAW1QISNVkxLkSV7I/oUKYoalnhGWD0T9EglU+vHe/HgndZZb24kaLkD+oYg?=
 =?us-ascii?Q?rRfAfg4Rqxm3Wccwux2ZFdog6agWBqq1pyREQsoy6WeZcegx2jDeZQv8SN6W?=
 =?us-ascii?Q?/onhmKG83qge/+Qn7gkq+1fEqn4V+FDuj924EmfXoITqANghjNDcPe2GcIF1?=
 =?us-ascii?Q?A4mWQXkRbTzAQjWa2VQwNGUh3RpNpwtY91AH0VKBwDHVxOHAeIe4W6Tc80NB?=
 =?us-ascii?Q?Ur/Z3ARcDSywZqIuYMvuz4J3T8fo6IOLqrbTM437LIvAGeZwW0QDRT0e2rGL?=
 =?us-ascii?Q?B5dV2ZFgwEBx2OOL80CquiWb3LIh9UtScEsVfhjVyzh9i0032osJeG9NDHya?=
 =?us-ascii?Q?75t8Y3dk057Q15fIqjLC4xrfcsEVMEKR9dk0gHLma7ky42ufC0Yy5m5a90m7?=
 =?us-ascii?Q?p9JqDP7wFjuO+0nLkdFKmbmroNHK428jA8dC/qkqPxI1r5le5yoHGRqpPVve?=
 =?us-ascii?Q?hNYxza8LTQpEPEpUs+BkgfDfVCPbkKI8/MNyO4deu9RZr2idBAOJUcYTsZ2f?=
 =?us-ascii?Q?Ci6BX+SyOS9n66Bsx2BRfe1JR2jIyHTfNr25s6pA+iPsiHEGckH2LAztjp20?=
 =?us-ascii?Q?vlTfavXhyZ6khPY28ih8W9UFTBZ8deDy1/BsMcuO5PGtdQzm690UWffV9Buh?=
 =?us-ascii?Q?TUDsH+86h3FkxE0BOM9Py4Eam+YCgkPPZvrN1yS6EXd8EG/IscNPfzp6tfcu?=
 =?us-ascii?Q?WLfII7c2geF1GTYXAjkz4r5WR/CqZzHmodEdmpsAEH+tdXl9gr2atuEIWW5y?=
 =?us-ascii?Q?psGKcf3+rJUn/3Lb8uoSd6w7NckoBuQ/FaA3fUt1zPEu5fR/qZasC3C0nOXp?=
 =?us-ascii?Q?LbdTrnhvk4vBTcMk1rBsD04lo4hapCZyer2vAvgpTzKx8iOwKSBKBtD3yfcb?=
 =?us-ascii?Q?YjQa2WzVYTNIhkssPNwFt/nIqCQ0iIvfNgpEZ7y0cObXN/9hKTipbKo/N+Oi?=
 =?us-ascii?Q?BF9rmisHphai/tNobqRz8Nfiufqn03vBVO6/Wz/LSFFz/7JAnffaA4bLKLFD?=
 =?us-ascii?Q?65q2i9c1cr+mlEIUtvwhKOS7I4WTy9JyvpVeuVJEa6lCLkJEtVB2ZwUyPjHY?=
 =?us-ascii?Q?fMlprXdSZEjfi/iMYDcVJ/HWMrPGYyQ4ymRzOpxBIpjE5ueshXLA/4/K8Llo?=
 =?us-ascii?Q?Mi4IUWpxNpMJdFz26qckUgq8rYEuNzmA5N2NX7lrqUGznqPgbFkZvcZc5LFw?=
 =?us-ascii?Q?FI/qBimjU9AKxvDfiwj6YgAVS70Aa+LHna/nOl7kIlZ4f+lHjFWdWNFz/23H?=
 =?us-ascii?Q?BTT/arnAuqjjRMGzLh+6Txz+VFrU0jINw9F3R3/ouo9iKIMNyTgfGFz/PcpV?=
 =?us-ascii?Q?YuYjEuRl+HrNb6YQJtz8mi4pHgM8TqpBZFnA8Mg+zIOWwo7HbR8sGhWfSknS?=
 =?us-ascii?Q?z8U8f+hLX2A2hk6RpzEHRiYKS4hepDHHbFlsM8/TIOWMp2HW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a9daf8-c38a-4715-41e4-08de953d0e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 07:04:19.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFX7Zy9+OoCQHNj7cPKTIDf0UPQ6V5GTDlQGX334hGrUjpkC5At9DFPsVFBnX4/NX5UwAEpNgHoLdsys+/dTkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10611
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
	TAGGED_FROM(0.00)[bounces-276308-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,AM8PR04MB7284.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1542B3B7E49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > @@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct
> ntmp_user *user,
> >  	return 0;
> >  }
> >
> > +static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *ent=
ry_id,
> > +				      const struct fdbt_keye_data *keye,
> > +				      const struct fdbt_cfge_data *data)
> > +{
> > +	return 0;
> > +}
>=20
> If CONFIG_NXP_NETC_LIB is disabled, will returning 0 here cause callers t=
o
> falsely assume the operation succeeded and proceed to use an uninitialize=
d
> entry_id pointer? Would it be safer to return an error code such as
> -EOPNOTSUPP for stubs that have output parameters?
>=20

The ntmp_fdbt_add_entry() is only called by the netc switch driver,
and the driver will select CONFIG_NXP_NETC_LIB option, so actually
this inline function is not used by any drivers. I suppose such inline
functions could be removed. Thanks.


