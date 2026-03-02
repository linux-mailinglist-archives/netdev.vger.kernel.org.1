Return-Path: <netdev+bounces-262641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO/qBtaHpWkeDAYAu9opvQ
	(envelope-from <netdev+bounces-262641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:51:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B83731D92AE
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7DB6304EA47
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CCA375AB3;
	Mon,  2 Mar 2026 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZ6F05O0"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276C344D99;
	Mon,  2 Mar 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455436; cv=fail; b=UPJJdmgaAk706IfLngeZnFK5dZSXhKVzLaJ6ow8M2yq66qXcNl2sjbxj19CzWQ6a6ph3N7Ardvn0nm9LGalkr7F7b2meCjzPYLsOEtLZ685iZ4B67KG9w4Z7erTCJy0jMaaGAB151Bu9xLf0yT8TGmU/qAa7B79CQ+GhvwSEyEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455436; c=relaxed/simple;
	bh=bfkSkZ6HdeuPWWVNsLi6pwi1XFAULxz1+PqUvKuN+b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p2htuwXTI7I2DH0Ba9tjLdt1OE+l8f662/OuhhdDeYTU/QCk+NngDIp40qpuvCsoh1Ro6xO/Udq5pQVOSpCD7e5qLPuRcIKISRddtz70N5XMR77GqXDSlkLNfXN1dvtYaC0iMhctvBGj0yhsP/pHv5pMvP1v1nCtqSvjMrMa/RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QZ6F05O0; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6S98F/Uxs0nuckIdlHhiKPqS6ZR0SRrvtg2t+48vgmahfma205hnhKUIUE/I5yfl9XbOJGWf9yr8MVoHPfOudHhkRdD0dFg9wzGMaB07seQZzaIdCAxLVuOdsY263fCIOD74BYHrYTm1eNglpkUeNTqhAjbHEEy9r5qu3zJlBd5buclUl7o/dU4zQVw8QYkGcGm9v80z26twBf8DcjV4mMfsgf6hnS8Dc3vpB5lCWnwVopeg0w67yHSDmDGGNtc7k01cLMNT2wJqZWM8NQE7RWaLHJyeiD9Ff+Kk8qlxMGHJr30gNBHOTaG6no6bHhoTetFrIR/E8en/qx0avDSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfkSkZ6HdeuPWWVNsLi6pwi1XFAULxz1+PqUvKuN+b4=;
 b=NpuEBuF2Aw2GZ3dza8rz/GTligHZxl3Vdx6E4Mi4e9yTqJGdJkm+aBmJF4ibfzYan4mcGdfDKpMoCouHjmiwcivXYvlxC+mMirp7B9hNUWNC3sr7XDIUQKm+thL6iwh0NkoHuvkZ4mQAVKWAuvUgp7e7zQF/6i7tjes6N26tPqnPrOZbLVFRnWr7yUmUi/FZdhbr6LKBcYX1DiwtMYcu+/YsxqNa0jALzWmVGwERCVnxrnTjh7OOc5YKNf1jgVDUcItM9B4xwxrBgv4I5i7SeJvx1mFyU8m6w+az0pnK36wkxKJGjA5vACPIeOs+4T9XOVoggxXKE7prpGNUkv6qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfkSkZ6HdeuPWWVNsLi6pwi1XFAULxz1+PqUvKuN+b4=;
 b=QZ6F05O0BX1LQ2YCa91oBGnSuv0aeGro/n4BynpbAHLIzTC/4FPzPg5SxVI9KqDHKR/39pnWMMoOB7yPahsGCaDJIF9RJLSWiQG43bnh9x0jWmJbJ4MVGU3aEW5ZWOCvf0u8sDE4Sj7o5B1jp+0bOkp5COpqlm6jECj8bzyY3MDCC8JsJCEUh6HIEkDj5Of28KiWfVHrvUd3L77HAQpK0/p4lwANIGmkUYKitFRafnc9ma8iIDfJW76D+Bu+sQ5nPMFZdWz9xvJvQ0pxs+vvfQEYqQu0Qtuwls6zclvcBAy8oxx8hjB8CXNol2g57v7VB8nwkrq5xwTuD1Ybh/uw4g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 12:43:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 12:43:49 +0000
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
Thread-Index:
 AQHcWUIZubUzIGCEW0O6wKhHNvVaErWXKxYAgADhsyCAA4l3AIAAAaTAgAAdkICAABhqQA==
Date: Mon, 2 Mar 2026 12:43:49 +0000
Message-ID:
 <PAXPR04MB8510B2E527F0936558920F7C887EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <5972322.DvuYhMxLoT@steina-w>
 <PAXPR04MB85104CDE52FE824736E44ACB887EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <2256661.irdbgypaU6@steina-w>
In-Reply-To: <2256661.irdbgypaU6@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10297:EE_
x-ms-office365-filtering-correlation-id: 4c38e545-71ea-441a-1dd8-08de78595a23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 aREnsWiYK+IUDw/bblJTuw+ziMNGb9MnjBGVCDoUoHhQIV1dxeaZECMzvzXpyldlM9hKhP5jv2rydz2MbXFJevKQm4PMNMNFBFHpWhbR3+wA/yxNSKT7xcnVGaXJI0B526iprG/SbvSX2wJGA8LrakLcXlh7DFIbHwfofa6tq2dZ5RvgLBIVbZwsJ3n2FnS1yzOIRPfp8RSyfnWUE3S7yhm05SV66e4LN4b2MyI8uVsMqQtNBaxDZpPbpuNwbLfoKM7N7krfTltAxEX+D2+VNJ6CgKaS10nE5JV4m/kRv3/3JCah/jsGkE+KNUuIcTYuxVXuJ2cuGxmK6KvNmQuDUYK1DaR2mTZOX8kWDiFK7hWgChftvIw7WSmb2+008cXZcSVl5zY3w+hyg1o1uT7ALwLIJqSEtOfeHsptFrlrxUVmMxUGgoWrkV+VESFFgHB3fRBzahfHKy5vbk6RDkr9GOHACAZbp8pEycIsUzqfj3EvXmqMWnNgPhmYa25WKkVkSfOWDvSZc8mlwPi8IP8X98/e2g4TjJmGnQCFcEV6ffyAQS53df9FC8/Ta8eVMLcZHM3ue7GUh+M9QvEU0cTdDJpBhGgw1IRClB1ZPpCSGyLJ9G7DGobyu/EF9lMoYI2BZXaMNfTB3jnxY+wwjJ7h4LrXlaHK0pVrxQ2Rsa0rwh5tnZ35FHCymiPchP2cujkXNoxgAp/A0KuqRd9sMOMuRCjeDqVtUQ/RMGmYiP+3hRcWz4KMMdk+Ik4rJuNSYTp9CvuhXP1xSqEEaV+g8p53Pyd42SFYNLxnSHI5Bp/K+ao=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fHAVojkYL0Io3Ks3Tczt37UEPtmgHXwcC+PRPQNPqZCPAMMHrdt9QWjdwXnu?=
 =?us-ascii?Q?NzbIBIdbk9TH0wgppB/yg7mSwDqsGTfr/jNgzm7VYDsHm8VPFpfrDsKZrfmt?=
 =?us-ascii?Q?eWIWQejd7IB4iTjeB7IIvp+R/wZchIA/KkAnU8VFT2dAtC+OTMSTC6zSua8O?=
 =?us-ascii?Q?ga4rBSUu9qlIoOF4ZSaTZTiwA4gcXybTZ+VhnhAN7UG/jIeEFNDJwZxdDVaQ?=
 =?us-ascii?Q?qJZEPsGkElibC16L1kiziv4Fy/dXRMbAgfASHI2rIbD5kDzrinKfyloUaaiQ?=
 =?us-ascii?Q?6UXOgZshjXwnv368idUelriSzs+TlhT3y5LSxw7F1tiOpWTw0Q5SjwyB/cuK?=
 =?us-ascii?Q?yEW3aotlLW2y+4TgGVOmfSmZ7IQz3XmOdgsJet5r01btaJkElBszE7j6qU7W?=
 =?us-ascii?Q?WcVo0gK9Ns9HvHw2g4uTqlzxacr7FHm5ioAxbP9UmI4bY2XWGk8/FzTPm7qe?=
 =?us-ascii?Q?mR1m/8TeOSf1QZXqffSeyJrkBAc1rzPWeZZlPQMUIa7zng2SJMJLH14S93qz?=
 =?us-ascii?Q?BsceM3Ou7EK48S7O3VZ+g3umgPWmwT1Gk02Hru04dhOCDrGrvWwm87AhDh5y?=
 =?us-ascii?Q?sd00QyIEuifltDERIYkimGFvgIBxs05VFjlXsB/zU6CHW+iFj4lgPcmh7Jp6?=
 =?us-ascii?Q?vlk4kaOzN4vHYDitsRaIRE79025w7Td+Qlv3xWv7wJaapHKQ9xUJPck/Iplq?=
 =?us-ascii?Q?AdPFcsRqCM7FKw+ShpkfHX3Mq8KeRE9poBhiKnKSJXqz8MIzjpeAOTVlbI7p?=
 =?us-ascii?Q?0lSfnzm2/7o38K5H2QB4pJtrjHuQlFRU4iwRL5dAzZe+rk00Q/dN0w8+wKIc?=
 =?us-ascii?Q?N9VjwVx3Eu2TUZoEaCzXFQfy3hknR/ond79d4Je3tSWLk+hoqH7xeoNVerzL?=
 =?us-ascii?Q?Fcwq6obypXR/1mzsP43b6XXX0LLw/O3kh/Xv7a3ypz6CmM+tHW/nRYt4Bq+j?=
 =?us-ascii?Q?2WC+52eQ5A3dOcV6EUT44q1c7vw26Kg1lUkmJlPWOXc6Tsx5vsp3NYchCXne?=
 =?us-ascii?Q?88ahSanVQXvRkKCkap3bjXShDLwBiQpU4pkvFoIGXeJLnaR23JzNT7ITpaa2?=
 =?us-ascii?Q?H9TKRjGTsc4bZ3TPuvetV677IoElX9cP+s1qtiulPGLEJxhCMrMfXaV5SeC4?=
 =?us-ascii?Q?ytYjP76+LgSBKm7lOfA+XWUv9L/xRdBzaEO1TGbg6mMOxvh2mR+nDsv6jXbk?=
 =?us-ascii?Q?uJu1BP1MVRfGIS1iWexiaOEy/Me7axmOB/dIrJPJgGcZKmjJHF9yieYrv5TZ?=
 =?us-ascii?Q?FOtD761pba0BfaI0Du21qmxh52TMj/AUK8KXbSybXmfSWg/kNLr3W3c7+42U?=
 =?us-ascii?Q?FMw8MYDfJ7PnmRrzkjDtMBEd++gwA9lJR2RxlPv7Vuhl29Bk6wru3+7w/Jsa?=
 =?us-ascii?Q?8Y5ql97Rm05ncS5w1Ah7AHuDl50iVNptjI+6/I75P/vym+0u+PcYKIV/WPy5?=
 =?us-ascii?Q?z88pTTOOPQLHsRGoV7aGLlGq6uzK6k1IEzAAoODWPJczuITgwZqtnMZjW5hP?=
 =?us-ascii?Q?7MPEmIGVnS8iMO92KPgscDoQJ5eYIYVwyPL5BZ4N2jl/UdkCZtdLlF4R09Eo?=
 =?us-ascii?Q?79j5c33j8XzNBnhErFWAx58XbMWuK0Xvcg7GvAoq1OFxm657peN1nKblky24?=
 =?us-ascii?Q?JPozTDAUzrt29H6Iu/p9FTjxsHtIGceg+e1JmHVvaKrJAnnIFs9dgHvB0FGF?=
 =?us-ascii?Q?wJmdqkE/9DW1corjyRCNhqkId09l+Axwa2nWyXtNh3zttqgu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c38e545-71ea-441a-1dd8-08de78595a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 12:43:49.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Xb5SZgN4lvh+RVSuMACLosm0ShP7BbIWIYjIt6niAlxGjJeCzKJmczGHFnr/AjMcBAecJB/mdqYsi7LpxUsvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297
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
	TAGGED_FROM(0.00)[bounces-262641-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: B83731D92AE
X-Rspamd-Action: no action

> > > > AFAIU, the PHY address 0 is a special address, below is the descrip=
tion of
> > > > PHYAD from IEEE 802.3 Clause 22.
> > > >
> > > > A PHY that is connected to the station management entity via the
> > > > mechanical interface defined in 22.6 shall always respond to transa=
ctions
> > > > addressed to PHY Address zero <00000>. A station management entity
> > > > that is attached to multiple PHYs must have prior knowledge of the
> > > > appropriate PHY Address for each PHY.
> > > >
> > > > Therefore, for most PHYs, PHY address 0 is typically used as the br=
oadcast
> > > > address or default response address. In designs that control multip=
le PHYs
> > > > via EMDIO, it is recommended to avoid setting a specific PHY to add=
ress 0
> > > > to prevent bus conflicts.
> > >
> > > I know about this special meaning, but there are hardware design whic=
h do
> not
> > > take this into account.
> >
> > This might cause potential issues, as all PHYs attached to the same MDI=
O bus
> will
> > respond to the accesses to PHY address 0.
>=20
> Is that really the case? So far we didn't have any problems with
> PHYAD 0 and 3 on the same bus. I did a bit of research but couldn't find =
any
> information backing that PHYAD 0 is actually a broadcast address. All I c=
ould
> find is the case with just a single PHY on a MDIO bus, defaulting to 0.
>=20

There is no problem if there is only a single PHY on the bus. But if there =
are
multiple PHYs, as address 0 is the default response address, there PHYs wil=
l
respond to transactions addressed to PHY address 0.

The reason you didn't see the problem is because the two PHYs on your
boards are the same model, so their configurations are identical. However,
if you disable the PHY with address 0 via the MDIO bus, both PHYs might
be disabled.

> > Is this problem unfixable?
>=20
> Right now our problem is that the software doesn't work any more.
>=20

I'm sorry, but I still recommend against using address 0 when there are
multiple PHYs on the MDIO bus.


