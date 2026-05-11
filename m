Return-Path: <netdev+bounces-286422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD2GBzI9AWqcSQEAu9opvQ
	(envelope-from <netdev+bounces-286422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A0507274
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 800533001D6E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 02:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37946248891;
	Mon, 11 May 2026 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNNsixkw"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD514503B;
	Mon, 11 May 2026 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466094; cv=fail; b=mfmAOharmlenKj12MAeVYqnNNRSM2M+NIJ8l5jW07bGBcGNaoamvvA7aaSZgMymUp0Vb8qPNeFds9TOUvEZ07SqNJOGth4yqJGMprbxCDn3PYXb8HEQuN11A4Gd47CtAuLpJG+CfDgrxq8dDuvHeL1TF247T0jzQlwUfISplx4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466094; c=relaxed/simple;
	bh=fOhRL2VD6RUP1QOspt0mBIqEtfKgT2LeK0v7H0cwmMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SCdunAC6Rf/hL3CEpwVpT+7rKVDTECCFzmL+BQnM3x7AhZq8yBPA9g0Rwb8LirLoSWkyFLXHOcJSKnKlIRoa9mtVT5ds5D1A94WoZgWgEwXpOerPzwpgJOAHBkepu7kSPKKjY6tijMNfj9WnSow5owmKPMY5fefivtO/WJ+hh0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PNNsixkw; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIbIXYxyzysNAlBqSqCaHwYrZpuFAcsMgw6SIaHUrhqgWtOC1rvmSW3l7Td8TJ5CeHomKgLBD16QlvjYvP6vaRl5+X+CeKaDhYOVcPrR9dORL80fUI8tA0iDTkE3UNBGLA6NhMVOOJ1KDXxcOx4XjG9tLue+Sfuq6u/FRUVboaUxah35TE3Jt566ijr/kcGKKTd7LP7KoudC86zXs4ycOf7Xmrr75yiYZwCUkKAykwebgPOqIdmjjtUHgey6Zyfs/dmlSi2YUvjgYoOZBRWR9m/lDZDnKn/CRFw1IaBjpGlVboGtfxM+ZvpR2aJLdIo+qaEg4nBNxXD2WReX9QwpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtZDPGq4Q2yxZUJywQq+IyVnC1Fp7q6+JlI21mQbry4=;
 b=pNq37QRlhi6S4Zi0APznET9//6PpG6QdvmqUyv2IedSpY/E8kLVSUjAxYs9bEi3w15rP29XcTPQzypmd2M3pfkSM3lafgSddJ6eLsUncPE/6bOcPe9PtZrwXMq+1MYzjV/DHuBj78z3Q5eS72HDmHTqNEp2WUvGM6sLI6MFcjGpFAdv4qPigmkMvpLK6FuF+nxGmlS4hB5z28jOMWzOrkvhksdKirl8wAR+6dr3RsGySrzLr5Hlg2nWkrekgDMm0+mh1W+ZJywRJeMOyZa9uXbCBcbRaj86faCEGGCtDjqNXsJzE/qCcG5llnhc8wmvylK/RDsaXMYWzARj8KZIp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtZDPGq4Q2yxZUJywQq+IyVnC1Fp7q6+JlI21mQbry4=;
 b=PNNsixkwlQAfVin4ioift/MrSkloFAkbY0awWXuJU4JSVaGjsFbasNTch/J3O4StEqzC087mmj76XYUwgX+YmGQy9DsSHquKsw4SBj0C5JGcZZMstqNZBeSfBEJAPDKBCvQ9J0y9wRWKk09gkfZYLNVKfvtuDE1W0Buy54Ck8obbCCsCePk8qXZazWdfVzFOut5IEjVXSTJ1OHTo8L9TWLNHeh7H/XwP84V52NL9TaztlSLBQHgJgEgOpoN4voLy/+izuMagTo7up1zYU+7j+ekaLVD/RODFedJ/Z2iOoIwk3bPWcSXNL8qxtSzUYRV9xPRnUbMFMJ5pyLmkEixdAA==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 02:21:29 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 02:21:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "robh@kernel.org" <robh@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 07/15] net: enetc: add support for "Add" and
 "Delete" operations to IPFT
Thread-Topic: [PATCH v6 net-next 07/15] net: enetc: add support for "Add" and
 "Delete" operations to IPFT
Thread-Index: AQHc356UrAB9xPqHnEmu9ZrKOgX5kLYHFdsAgAEAnDCAAAO6wA==
Date: Mon, 11 May 2026 02:21:29 +0000
Message-ID:
 <DBBPR04MB75004CD726DC484ECF49167988382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-8-wei.fang@nxp.com>
 <20260510104835.0F27DC2BCB8@smtp.kernel.org>
 <DBBPR04MB75000ABB26EFC96C65F98C1C88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
In-Reply-To:
 <DBBPR04MB75000ABB26EFC96C65F98C1C88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS4PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: 11452dc3-45d7-42ed-5bf6-08deaf04028b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 B1PQZuyXz2SySg8JW0My+kLCpherGRLTULLcnLwyqyKzNaA41x42+1JlIE85eCfi4xD5+dxTZRyzRPjOszV7+gF2+qJ08FBS2ZeifBU8ZmQbMekgH1qRZtXhINYC7/u4DK/hKEYSGFWkdYFGsyYhEAThr5wh/tH7moysjG/bhLj0fR9SA4JUuQa4MhqxuQYYtyPuTtm8bn+EzRQqDNphcO+3BQTVuWPqUsZoZY7PH7RK1jS9OafzdeJR0eCMAO0lNq4jIujvmx0hXqNp6qRL9fNmHkAxeQsEOUG6PIFd1tEMdpGVBm1Vx7aGDT09cGXMOAMHaFuYd8rNhEk7wPe3l9MOhmbTqd980l5NPe+u6MaWgPkHcbejIvBScPeVQUf6PhHuky6o28lhIzFCVpIs1kCJ1Md2k7hvXJTvm3uIMoKipf3z/529XN9aL6i4+sMJAhcfAqT6umXmZjTzwb0cGRHP0X1W3BzXY3Z/3KkPhX+3TlW827Gvopo8030IllhiLyh280PW4yXxv4eJF5XifcyYyKtC5xdz0JZJV8yQYOa/LuakJTlP892LSgXrggPyWg0i6GYo19kA+FvaVcTTdJrCFQFfwBOuFwq0TUIjlwByZ3mHfIJmroKTBaVoFkySzudRI5eDMCr9G32XMTugROue+Kwq3QmLo8NmNYRe+wXx9Q7AlaHrIu/qWfQzdX5P32YUNb2UKvHZ5UFj+Hp8WCrCE96x8af1/q4e9sNwWhFKI1EvVGPuafZiSBryrO3F
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VG+6YYF8skuAzu7CAjWMMAZiitv+2bEJdzgwacmTONJ8yiHnyGJB8nPmmKyx?=
 =?us-ascii?Q?8JBMKTI52pQVwWVBthJY99NPR6bnYh9M9M5qoDyOOwiprpIqJxLigEPUmksl?=
 =?us-ascii?Q?Gpe/TBsGFNDE/arfBxFexYPVYHG/7goeZVdE5iHasbPKusAyPRnb/VwOP9cK?=
 =?us-ascii?Q?zOQrNoiYtYBU81aTwZ2sQyQYphYLM7PxhD0unnCImHfyWNOWgvxE4ZJxziyD?=
 =?us-ascii?Q?penW7/bVEToJqe1+qNBmdD3Ulm7fcgeJukASQV7iNMkSfJ18w12eYHfRZ7J6?=
 =?us-ascii?Q?BYmgfyZi9r5c8eepQRfDjOV1Ulb64L4p31jGmxYD9JgGybKNWIGSO4P+MpHH?=
 =?us-ascii?Q?CcfeJ5+irYo4VCXtkId3sM689jFiSqHpoWn/DqgZB2hYGVPCzf/S0JzcKPnC?=
 =?us-ascii?Q?HTJvo2kGqrI1mYhQaaLQ9Ji2+dLyzGcPPB8A2CUC+LoXoHD3Gq5zSNQ3j+Yq?=
 =?us-ascii?Q?GXWeAWVfbEZB1GvD06plRPBWFrOxMuyT+eYRRMG1+lOFFrV7S1to8CM2wHLl?=
 =?us-ascii?Q?4d9W29PCb/shnfEgBz41jSwEFPK3MflxJjWOTr3edfyPQNayU76mK/roUxPS?=
 =?us-ascii?Q?UlkQjJwZJ4wr6DkX/He7e3JfHYraxV+KngxB4XuslL/fSGbqpezrTcjObutJ?=
 =?us-ascii?Q?Md5bcRkJzxsD4CILBXuI8zeT2zKZCbPXH9dITo+D73vEI2beYQSkc8WIyoxt?=
 =?us-ascii?Q?w3rO6tXKCF3z4/MYYkEUtv/azWOBHvLlBDh1nojJIcwXruDIe5vguJOj1wvd?=
 =?us-ascii?Q?r48uU+U9MeL9o5s28mHUCpKpwFdByM4dBnd14c0wkfKjCoXgicOgXWdTI4S+?=
 =?us-ascii?Q?rnRAPwpoBGcMN4/FIFwt9oVrY1j277uVgL4lye6fnbbli2DC88JkrIOUpQj7?=
 =?us-ascii?Q?53hVpJ5swKTsxUDAmcICGb4tFSFC+t2E7UYcRnVT1Ktu8XqDNpZoj2eg4Bgg?=
 =?us-ascii?Q?TD+rio4nmVkbfGM/TlxnVVVjk0yYSeZUF79zuaWzC4UkKlTwciSm3+rS9ChW?=
 =?us-ascii?Q?LAuf5rqR47t1ywrllu4MSKebBlVPIqmk9fGez0BRp2iXOIanxu0ZDToJVLL7?=
 =?us-ascii?Q?EOZLSJrYuj0D+kR9d5px8Jp6yETPpvd6bM8FVvyhHPw+dxDOzZUiCj6qmx/Q?=
 =?us-ascii?Q?axMBCt+ZASbRV8+rauwLwn6Cgr+OWwZWfVGv3d0uOlD0vcae6flAS3VhynVd?=
 =?us-ascii?Q?6phDd/dPGJSE3ySOGa8ac1LLiKY07Sao+x66rMKZAaERitLdWHUld3JrQOji?=
 =?us-ascii?Q?KO0qGWRClw4G38TH2qhRa38CEFX8+TkfCpiygsBaTS065AnOoj+6xiI683wt?=
 =?us-ascii?Q?b069y+fSGHX6X4LupfGxXeof9xx5Qz3GnunOglJMsPwSr6mUiXV5ErKLAkt0?=
 =?us-ascii?Q?gZtw/I3y89POvzLNP/CMEj6EFJmZiAcslM/0fovlLf0n9o23zgPBl2VhnHn3?=
 =?us-ascii?Q?Q/IAZlCtn24DPgpf/uzcpQn7tVaHvDDYISW+SbUaodejYm0uoVMqR/cGFscP?=
 =?us-ascii?Q?Yf2u7k/Ln9iyJLzfkeU80jnGTdCcQYY3VqFUjqbxIU4q1cPCPviVu1vGVPcI?=
 =?us-ascii?Q?ijVjSo0dIvGN5zAyX2UWn4VMK1lkhtPcXtPQkt3Wo5iOn3ouRjcksUcQqbFF?=
 =?us-ascii?Q?IAfBY1NQEGEtxqgUBGFsU5iN+9umiZTpvbMlJAGEqrR+2LF1bGrUAD/HZd5o?=
 =?us-ascii?Q?GMI+qU/TqFSrngDYVOLxJKiL7AF7n/anuXkcuUyqZFcjuuXV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11452dc3-45d7-42ed-5bf6-08deaf04028b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 02:21:29.0410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcRlj49nveIaJ5Xjyr5XVpWtdOxcwrRsC6yVLGiGuS4zATt94c75cGZ0vafAog4g/yMjD/sQX3sTlJ0/v94tsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
X-Rspamd-Queue-Id: A54A0507274
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

CC netdev to avoid the same comments

> > net: enetc: add support for "Add" and "Delete" operations to IPFT
> >
> > This patch adds "Add" and "Delete" operations to the ingress port filte=
r
> > table (IPFT) for the ENETC driver. These interfaces allow the driver an=
d
> > switch to classify incoming traffic and apply specific actions based on
> > a precedence value.
> >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > > --- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > [ ... ]
> > > +/* Ingress Port Filter Table Request Data Buffer Format of Update an=
d
> > > + * Add actions
> > > + */
> > > +struct ipft_req_ua {
> > > +	struct ntmp_cmn_req_data crd;
> > > +	union ipft_access_key ak;
> > > +	struct ipft_cfge_data cfge;
> > > +};
> > [ ... ]
> > > diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c
> > b/drivers/net/ethernet/freescale/enetc/ntmp.c
> > > --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
> > [ ... ]
> > > +int ntmp_ipft_add_entry(struct ntmp_user *user,
> > > +			struct ipft_entry_data *entry)
> > > +{
> > [ ... ]
> > > +	swcbd.size =3D sizeof(*resp);
> > > +	err =3D ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
> > > +		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
> >
> > Does setting the NTMP_GEN_UA_STSEU flag here cause the hardware to
> > expect
> > STSE data in the request buffer?
> >
> > Looking at ipft_resp_query, the STSE data (__le64 match_count) sits
> > strictly between KEYE and CFGE:
> >
> > struct ipft_resp_query {
> > 	__le32 status;
> > 	__le32 entry_id;
> > 	struct ipft_keye_data keye;
> > 	__le64 match_count; /* STSE_DATA */
> > 	struct ipft_cfge_data cfge;
> > } __packed;
> >
> > However, ipft_req_ua lacks this STSE data field, placing cfge immediate=
ly
> > after ak.
> >
> > Since the hardware parses the buffer sequentially, could this cause it =
to
> > misinterpret the req->cfge field as STSE data, and subsequently read pa=
st
> > the valid data into the zero-initialized tail to populate the actual CF=
GE
> > data?
> >
> > If the STSE update is intended, should an STSE field be added to
> > struct ipft_req_ua? Alternatively, should NTMP_GEN_UA_STSEU be removed
> > from the update action flags?
> >
> > > +	req->ak.keye =3D entry->keye;
> > > +	req->cfge =3D entry->cfge;
> >
>=20
> According to the NETC reference manual, there is no STSE data field in th=
e
> request data (ipft_req_ua). The STSE data is the statistics element data,=
 which
> is maintained by the hardware's internal buffer. NTMP_GEN_UA_STSEU is use=
d
> to indicate the hardware to the hardware to reset the statistics of the e=
ntry.
>=20
> This is a false positive, please ignore it.


