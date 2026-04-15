Return-Path: <netdev+bounces-278761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBsoI6aG32nSUgAAu9opvQ
	(envelope-from <netdev+bounces-278761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:37:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1B404543
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24D2B3006B7E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30C2D9EC4;
	Wed, 15 Apr 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Pok1rJ0K"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE112D1303;
	Wed, 15 Apr 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256675; cv=fail; b=lqys4WJYkmWGUjLj/g5ZjQQh1wVyAr50mueHGklcTs7EEqhsoIpP/mW92rYpcZtBSO7EAFXDgCiruvM5XCOLMC0LYTUdJKyEXFDih4m2SQ4hEChKzrSdBJVW0gN2hJj4lcsXBiyyVFaOwzQ4rxkdWClz+X8L4jEt8i3cS8HaDMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256675; c=relaxed/simple;
	bh=t28ZcNIO0CGOeRbJy8Fne+VoY8WGxHGvgco87s9KiEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZbEUyJtxg6jRI4y8wXy/81ntvAsLHV1CMWQAl6ukImPiSGUx4/GQ8ps1KoqwbuKfDl6NoYCf6Kl0BmIpu9APCDhcNGy585s1w3qwMPC49Bds/gOmna50uLEI3/2wIIGLq12S90Ye1YveladgivcpF0NjC5N0b69PVU1Z839MDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Pok1rJ0K; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke2pTGhpt+e+uDyR0exR/eiQT+zk5O+pDLY09aB/bb6vzwQlYlOR73yXSrTstm+P1jOMhz+TikNvSG2P3B7eTDnuTlRMqtkRINH7DAP2KkPYu9hYu9omoSPsPHWNS+N1nJwussrN4xC5m0E3E3JRqbTvXHX8/vjBGK0Qi3a+Gow3SDgnPLiMCC0pIGsp3cpopht8VJbO4b6/g8iQOhU2ftnCPUoc2lUNwFajmZ4BXkT3OqXYNx9hBoAHzDMWGkvUoi2yBwHxtFoqrBPym/aLB+fvOUEKylVyop1Uva5/AGZIG6MK9FfomlpGbaEkSQIefPWMerOriHqeU6PeNXAHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFlYz9W9jk4jpGKSI3o191mw4J1KiR4ZZVlBcv5Ii3w=;
 b=KWSh+wxUiE8G1La4Wn1sOw2E++hUhL6EUvRVl6gkNekrdgglkZrZ0RiqGAZpRNzb2tmV3VAV2W6IVnEy19TE9mvgPCpi4RAnAQSBIQZp9ZIUrcFL+Yg/IoxEtrZKQQnkNhrwckbIz9aIQgub0Jojoy+vUGqfGIhay2ayOfUZZdeIZReb8r13hYHg5K7xJ1BTmCegBD7TuV9xrwBZMEwkT7VcbjyzI7Bcj+/hPnIxEkimEC0i9M3siD8PO63kfqt7GFxjeRg9owzYHFB9FRt2Lo/CUKccpK1kUb/MhtbwlQQcrfh8LzbWYPQer3rJTVBZ2yODsCEhGGxpyjdNi22Urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFlYz9W9jk4jpGKSI3o191mw4J1KiR4ZZVlBcv5Ii3w=;
 b=Pok1rJ0KNuEjiOf4+qbt0TY5npaZKdnWLg/L4owOpfSwQPa5+81KDxLGRFq6sAS2FRBYuDR+d74DZ7h0blx1443kYlJ24FPR5+MoJdcJrTykDAnI6GcXJBhvHuc3ww+3omt/QWTvClAIj7z1masbr1bc2DYx6kY3HsS3He9f7lvZPjnkOCvqV1Y7ySp+zOxog+WynKbJkboKetE93ZY2zrnlHkhsR7lxVEAGgHWlcbgGGuuv2qGokosMCTzQlvUSXMbhgmmUO77IZqrJ4mxEcGm83oBYKvH/QhDQV5m/YDiN1rQnLB+5FSDcWXuUzzYmeEauXda/t918qIvV1qrn7g==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GVUPR07MB11994.eurprd07.prod.outlook.com (2603:10a6:150:35f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 12:37:50 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 12:37:50 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Simon Horman <horms@kernel.org>, veritas501 <hxzene@gmail.com>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference in
 dualpi2_change()
Thread-Topic: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference in
 dualpi2_change()
Thread-Index: AQHcyxs9DuVxvCpLRUaObHOYR4Fiq7Xe454AgAABQYCAAIT6AIAAqDmAgAAASoA=
Date: Wed, 15 Apr 2026 12:37:50 +0000
Message-ID:
 <PAXPR07MB7984EA07ED50B3FC0D30A82CA3222@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260413075740.1@hxzene.gmail.com>
 <20260414183132.GC772670@horms.kernel.org>
 <20260414183601.GD772670@horms.kernel.org>
 <20260414160000.1@hxzene.gmail.com>
 <20260415123403.GF772670@horms.kernel.org>
In-Reply-To: <20260415123403.GF772670@horms.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GVUPR07MB11994:EE_
x-ms-office365-filtering-correlation-id: 305bf241-70e6-4a9b-8a05-08de9aebce6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 GBTJqCheU7xwAFQ2cBVlrzrgGpRInAeQyvTLrA4biTqAxBYT/NSNzxav1zd2T9QC0KqL4RFikYrpMe/0k72wNNKI2jmNS5uOqleZD4l4DbGqxufQdYcq+mHROuZiuU/k0+hh+wPth5Kjck0Yi8DWCaOBJtO/h3VfPmHo9aAnvLAU9oH1ia0KrGP+MGO56RSMQRm3y5FyW8gm4xaJnJRt7tVD2sE3hKVfGMd0E+vM6bSq/JDComwuQoAkVfuTKGuA3HGAc9ZILjRA+xXSIEL4vAlSv0LC+5u0PwBm8baS0EMQ2dWViRnXjtsUi5zvpIuovX/c3DWQ4JfeUJ9VIkI7A3yK1xzKXBOvg0fdUHDAqivReGWeAdRj4DWaCY6USGARc4SvPdld5LrkBli0obkr9V64vPouDeGkLAm4nj/bhdAcHI0Vwd0UyPvSJPfYwZOioLh4Ztu61L46kaBroPEBTAfoRr/Rb9oxUNgfygSSlTv3UezsbPZbXVz/lGNYOonWWWA2L+X7e72+ZC74wMacKAgdLFMw6+PgZv4A4AlumruJ2Ashn6ORpDbKRY60DG4RRA0AQ+Lj2myvfRApAQJGLkRgk7LqmdthsmjNwPD5eA7gKZbWYirygiZG+H7loui/Jy4Q25xbx89NOt79nb+EDhG/ZtvaPYfbj1E2FAwGdRerftDTHoa7CH+l+BOZUdhYE58ZVTAoMJ/At6G27Y0+8Ll5BpL3vr8fScwzJg0u1BWbbI3j5+DyRJHcHj97s5VxHtqkXd7MZe77Y42otT3q3A2RZncEvDKfinuWZ7PkI7Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FH6xpFTaWDv1nDIfNGS2jzrbQkgP+RJPigPczWzKGSqRxu2rvA2oihRZfVZk?=
 =?us-ascii?Q?gv5LFvEp4v6FjQ+FirRGfS84ZPdnX3v2KFC68RLbMkNEHe9lCD6g1gEi0HU6?=
 =?us-ascii?Q?CpXpn2yDf5WQzlzg/1HnaQF7ov10H4uAGCZik+OwH9Eh+v8VSkHJxETxmy5a?=
 =?us-ascii?Q?QSx88wZ7Vl/5FmYpUGtsOXY4cy3LRB6wxQXAoyOfgL/QHu5Bmi8bvxWknYhH?=
 =?us-ascii?Q?X9IawH0YcI5xWJclpchdtZ9caB41RgO7UOrw5wZiLu//6oZNYHrGIQOX6Hk5?=
 =?us-ascii?Q?9Y1mEKViy3fKcyXWA+AlV8vzCCABb9K3pgLjYFBQ40oegKQQDSWNgHq4r3/o?=
 =?us-ascii?Q?jINldpsl/opr4YZIWK24XOLn4gCz3aZPnxXQbkhnsA0I63NVFRTlhJwVG2TQ?=
 =?us-ascii?Q?cXRL4CNfNmr0OQGfIQwD9AwRcu1MBmk2L6vqMIyp6Vsr9VQKRjB8HnRkvtm6?=
 =?us-ascii?Q?cr9Cj6YnTmakhu6F2nN+hOcoxRbh5E7hsGXVjG9oXmBho8QPd0b1r7Hzbzuu?=
 =?us-ascii?Q?hwwSMuBAQuIi0AmjCNtLIhgiN6TjbVJuwjA4r66G0UQaWkfaoCrnD5ZNRAyY?=
 =?us-ascii?Q?rA6AtnMAsuwJRthq4q8XQ2xeK/mj1jZeTGZhqceRAEoPpHXJzUVSbFszfWqo?=
 =?us-ascii?Q?YjT3VB2v6XF3xKs3GP6eP/bK1cS3HX5F1ECDloEF2HEC3/5gUBk/bFE2jyrZ?=
 =?us-ascii?Q?EHRKXhB4j3rB/sjcCnrf1+PoqGDfq1lGgdBuFOaYETQN3CehE/iB+JVfQNgV?=
 =?us-ascii?Q?i5KvjWckolhb/bSPYQLlk4Zp95+2I21sHIYJe4h1orUMQGGs2BPW26x+QQCD?=
 =?us-ascii?Q?/9EHPXslWYEeWAqmc5FHdn3dKNbxD8xI6tDDDNPFDgMBAUx6LSRkRZngzPs4?=
 =?us-ascii?Q?pmxEvwn2ZfvKX/6Xh6dNSWBDcW34Xr5JXTF50ixYjY79bEVLnBwlcssvdOzn?=
 =?us-ascii?Q?J9353Rn5W9cUz4T7mqACWX3irCpepEc69jgc2RQSoWE2tJQv0jhGLDmxcayK?=
 =?us-ascii?Q?pGWClYhReuVY3mKqCiJcHzE0RlKTNmYSW7sN3LPP1PVp5v96D+iND9ASUYTC?=
 =?us-ascii?Q?xrWxt1kMfKJxOGBwnj73JftuXlZgQFK99Z4dshD2uW1NDVTWW0j7Ki1Ob2A8?=
 =?us-ascii?Q?F9MBqZJ+20yzsqZyWqglUhqY18e+dm/mzBBug/q2AJbh7NbPfRYRZztnGved?=
 =?us-ascii?Q?SurgMRXN2ofWIzg+RPanWXCpQ51doRpLpUxLE3kayOFL2LsgSpDwfEAWx+dz?=
 =?us-ascii?Q?Kn/X666vpiG8ar65yx0bdsR+UeSR/a59NvthT+jgaGqe1UOw4+BhISIfGG1v?=
 =?us-ascii?Q?mFJxPocjFUzjgK81SUPcGp8DqIn+w4Mn460kreTjDyvtLk67GIMEaOO8qYkm?=
 =?us-ascii?Q?UM/XV5aS3IWQ23NVvGvY84dZLUTvNS7lX3VDst/YTUcwTGrU2sEq0EIwGP3S?=
 =?us-ascii?Q?bkU3SDVEdrg5Arh37nXoPAWVSKkr/1cYy32z/uzNi/YavAApxFQyWR2zSQcI?=
 =?us-ascii?Q?BJT8tQVmXqkvuR/4J7ryriJl23/U7VQL8CSd6US6LLFuT5GFteD26bGE94za?=
 =?us-ascii?Q?A8+3ymx6/tmEh4Gzg6hpZ4k8gI9id3vh0ObICvFXQaG80QmIhpzz1VU6sKfu?=
 =?us-ascii?Q?S8ztwI1d4vSJvh6DHK1S4Q3FQr5elIVYE/n337b5PrwJLcmKkhOMZuFqBeI8?=
 =?us-ascii?Q?ecveQgAFMMq9IKfv2q/XokJ65Jxfck68IreLqSISUOy1gKKXuw8cs5cIY/2U?=
 =?us-ascii?Q?IjAIkcP0r6SJdJAFw4EfdiQN/QrkP+0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305bf241-70e6-4a9b-8a05-08de9aebce6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 12:37:50.4338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYS+U5vzul97g3Ag47Ymmnj/VfMjQYiM3uBjH3zdH18EJL4KCJEQaruASuqfiOFrezL1I1uz/nCCKZKMBoeycBgPEM2VgjYKI0gqPun+DgXC2LN69FWZwxcrn/+1AumI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR07MB11994
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278761-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BE1B404543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>=20
> Sent: Wednesday, April 15, 2026 2:34 PM
> To: veritas501 <hxzene@gmail.com>
> Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; jhs@mojata=
tu.com; jiri@resnulli.us; davem@davemloft.net; edumazet@google.com; kuba@ke=
rnel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; pabeni@redh=
at.com
> Subject: Re: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference=
 in dualpi2_change()
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Wed, Apr 15, 2026 at 10:31:58AM +0800, veritas501 wrote:
> > From: "Kito Xu (veritas501)" <hxzene@gmail.com>
> >
> > Hi Simon,
> >
> > Thanks for the review and for pointing out the alternative patch from=20
> > Chia-Yu. I agree that the more comprehensive fix is the better choice=20
> > for this code path.
> >
> > Since I independently discovered and reported this issue, would it be=20
> > possible to add a Reported-by tag to Chia-Yu's patch?
> >
> >     Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
>=20
> That sounds reasonable to me.
> But it might be best to bring up in a response to Chia-Yu's patch.
> (I can't make it happen myself.)
>=20
> >
> > Either way, thanks for handling this!
> >
> > Best regards,
> > Kito

Hi Kito and Simon,

Sure, I will add in the other patch with the proposed tag in v2 (let's wait=
 for more feedback before submitting v2).
Thanks!

Chia-Yu

