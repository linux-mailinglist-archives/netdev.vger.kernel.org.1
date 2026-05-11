Return-Path: <netdev+bounces-286419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMGPN0Y8AWqZSQEAu9opvQ
	(envelope-from <netdev+bounces-286419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:17:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B6507230
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91EF53009FAD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 02:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1377228CB0;
	Mon, 11 May 2026 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahLpzmP5"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335B79CD;
	Mon, 11 May 2026 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778465858; cv=fail; b=nLzSSS+dqHTkyFvBlB1BLVn2ioWXBMh9XSupklHvah1PDlSG4lNSd2ln6KVNunEhCc8+6ckmFLvn4Lcy82WLFs7VSQfxZ/9pbOD4yY0ZeCp9jifVtHxjAGSDuUWZf4+ZGfUMDiX3maLRYyIug/j3RuzF8L78W+mAfedrBgpj6jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778465858; c=relaxed/simple;
	bh=JZ1R4Npdu9ZJ+b2Hqf8RsTakouj0ns1y0lFx04uEGrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gTvKUZWY9qkvGMk8d6WwUvBxYyLKFLlr/VFHejdDug7nOTzwClSh8GvJ5hFOo2nQoF0SP7Akx+hm7VHxz40goi1MiqDi7HVIUxTkeSjvSv3VjVbPoJacDnXAuTBCbYPkWwOmBu1QzZ+iU1LnW9FYFlr3euGJy9IAv17y4wmITR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahLpzmP5; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiNJe9p8oXl54vLy7LspaB0/lkXAuvnsQx5FzpbcX1k52pSRwuoZq5JJ5+EwKG8KF3HzdrNrdcnCUE4gQqEDbcb97NXAT275NVHyH/yL+SRI70ayL+q66HDEbBvpBggW3eJzVMgw7//lfpdenBNc6+pbwmifLSAMmEIa03KbPxVRR3A28aHOhCrZZ6k+oEJWifvPH0oq0YWS6aqkCxW4Yt4CsrvTFzwXDr3bmnxldTmqTR5YNrlBFSdVHyN7sawgPhS4ufi1ZBJCnz7yj1XEjQOJT/j/jYNnHGSshWDIl/gk1QlWRGANC0gbSUBJS8OMQVXS41BQFdZ2V2tQdFCzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5M7usYKHCVuqBxlMmqTE6mvrsTPXVsYBVzaRFKK7PQ=;
 b=mJ5H/s6cXsDAjnWQvHgL6dZAxN/i4opfpMWeQO4SzrUDblKkVN2CTHLCD8TOSCDQLc6NU9z83yj4m5WF3j7EOOHGvy7FuExEDBKTP5lgMmkO+3HgCIM38E9AJySVI34SvBAqfyK7B9LsCBJ47wYRdjjL4wjJKa9n/GaDUyM4Y7sPgxtHM5Hj6V/wjCIm88Rrtof6VdlbnfF9nSWdiGDrahdzBDr4mwXahN/QIx4I0GA6ytkEqtGfoVJB59Y57O3vWq9Asg64C0NYmpIbOW7m+LTSmLx8jPBq5mXeTBbcPFjarzYGlK7eHhPHPYaefIgeONXDFUhXLs70yYMaIHgNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5M7usYKHCVuqBxlMmqTE6mvrsTPXVsYBVzaRFKK7PQ=;
 b=ahLpzmP5IxtI/CCDAyITey3HzBdDO6k2i/95haV0RIgVbe5HHi4wUFUPzcUe446PNj9RKUDeGDn66DsMN/jLbhiobB3f2JvtsR/pFr849Q8308UGBW65J0nwRI9/9nd7iJR7OQKNJF7t9foG8t0vuMDP2/OCTYYskEWBTmPDvyM9ekgUzBGgY9gF94ZqPHHNTD4SOI6h2uxd06+Ngg0LlIi3P2nkctUPbKYt/6MylLa1XmGk1XaJOffHk8Z/J1G7xF1NK63m6Gt9j9ja+FpTXsZ4heZwpQCkKdqYtfZ9bOR6gFD8PUoB5IQUxsZjaBiptHS4062O2jkMyFsVP6RkPQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 02:17:31 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 02:17:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 11/15] net: dsa: netc: add phylink MAC
 operations
Thread-Topic: [PATCH v6 net-next 11/15] net: dsa: netc: add phylink MAC
 operations
Thread-Index: AQHc356kmyBDyXkpDUqmoSgIwRaYWbYHFd6AgAECb8A=
Date: Mon, 11 May 2026 02:17:31 +0000
Message-ID:
 <DBBPR04MB7500EF9CA386165AC36ED11B88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-12-wei.fang@nxp.com>
 <20260510104837.B72D6C2BCB8@smtp.kernel.org>
In-Reply-To: <20260510104837.B72D6C2BCB8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS4PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: 83a73d68-91c1-45e6-1b6c-08deaf0374ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 0YOc+Sz5Bhy7cwDyH3TJEmct1fls9/sDaMjdymSp4CiCFepl4R1YhExHDhe0Xc/VkNYeu1IIeB6x/PNb1ijqPiBlDek2Z04reaDUt+Oc2zmDfQVZGQpjZmYqGi0JSSg1eJ1JjcyxDHvLpPFIR5gqpNRW8DCX38cMmwOWHJajOCf/Nyeb+DTh6VPLhrJAOPw7MYuihxtRLiN6Rc1a5c5eu4XeL872WDp+MEZk2lXEFaBhdqmwxsufLER7YrSP/YchV/Y79pQDtAj7Y+uGVOStG9bjjqFwwwsnGjLos3ctsHWEaJLrpwT28fofW5TUkmCv6x0YO7W9zFfXUiFUSfGOT8+JLkjmrojAQA+rEoe65IIujQ3wQ3p9l99rkjyhGvzZ+qHIXD+gKoq8IDxjZOmRwk5//GvQcfRT3ZpMy/EzIPdjB+q4dXs2dxvhcwAoDH411Sqgr41lMra5tVDqeqZN08GzrrXa58oYHEUrQ4qTjVP2971Mf6B0m9VXpRKq5nou7SZnpe8I7l4F+69BZr36BSKdiUNw2kr45m85Zy3pB28PFo5DKTQ+6Q8uVoNy5/TWZSOLm7WqLJuxGRO+RlQCXcA7mJr0YAQnAXjeW6Zu51tp6Jfr9A4HCiwiNEpetcvvnpKuMpHScN+hUVyn7GIaW3PpYK/i1ymZ/6U7fAJWkt/WZom9v14YP6S1C2JuCeQRVEB69UVoIVYbH9sLVHRA/0ZpzBuTBzIUNHV7dgleOO/b6eu55/rrDmYV056UR7Zk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ATZG5gCQW80vJ3fjyBBo5sEWN78ElcjZ9WSX7r33EkuFmynlK/MMFdFDIOn6?=
 =?us-ascii?Q?8TTfXC1D2gwUr7hQAW/42wGHLfN02dELxokVoQJZl/Onq2hvfF50ynpzAm6k?=
 =?us-ascii?Q?CPQL6AbT8aWd2pNmg8oaPT2Q6FP3dHCw6d1CA28HSlk7gRzJmRcFEyiSowTj?=
 =?us-ascii?Q?DZV5gGGjewvaMFzeGYzhFyF4vYXHs99MyP8o+ki62KeI8bSoxXyoizrNMKQl?=
 =?us-ascii?Q?GZrH0Jsic/d1IaXSqbIBl56ddZNerj4b4tXcNcVkDYfA5yj49MyelQbRQ8AT?=
 =?us-ascii?Q?A2FMqYBVfRdONaSJrdL/RAnEbcImQlxoJSrXAsIBaww9ioR6bDlUHqo9JGUJ?=
 =?us-ascii?Q?0EN+fDTnIdUyohJz3d7vWcL01oCuMv+WuQWRPrrN/LVx9S0RFBgBQ21+RodV?=
 =?us-ascii?Q?yE5sLvKYn2QHX/sPkyhIq4qa/S+3q3wx4L3Tlk6VyGXJZ1b9nN2UuCYO2+4/?=
 =?us-ascii?Q?eSEwXX104LCvYRjGatR7yNLwAZ5fEcCF3WxI09PQ4RveTfY2zd7jsPEe6wKz?=
 =?us-ascii?Q?VTtr7tu3xOmnrreWWzAj7+RqckkEsKjAKdelmkgv4vUeF6lxOqJ8q0XI6HAT?=
 =?us-ascii?Q?Y5TiW9wkyK4dMjmsD5K/bKFxbmvvPPG1EUC/mu08CDqhyRbo3l3aOG1b6ZkP?=
 =?us-ascii?Q?u1lm1f4HPliq2nviM1dJcZZOeo30FqYajlwwVWoglDT/N2ZJF159PgNXsbaW?=
 =?us-ascii?Q?4FXBO6FyExrUM0mpY4rnabrw+NN4xufF84g4Iw47UMd6y+SnP7sB+Cwt010T?=
 =?us-ascii?Q?nCijH6FVUoT47NAroqFdusJveR686lDVJPNoLrDNCuVrmprBSn+ZoB9EQiGq?=
 =?us-ascii?Q?Yg4GBWcIFcOBkybPuMMN81MVS8Qi3ugjnDcvXeNNxKQfx3EukH7CqqeTvmo9?=
 =?us-ascii?Q?KqN4nvvbI+RR6zFnkpIpPD0eZ6Va+mHKX2tfIWVSKl4beqgaQLGblpMmuOLu?=
 =?us-ascii?Q?pRHtkjr+9BP1zAkHZUxGiSU/zd6Pv4iI0vV6OuPE1da3jBpD1Tf+pRQYXnd6?=
 =?us-ascii?Q?qCcqduK/ZZeVIOPheK7VkJjqdR4qZAI1xCY813Vm1bZTUnRrkHUUXPy6sssr?=
 =?us-ascii?Q?btaV5FIOcbWUDMqvrmJ7gVyVlj46CyoQmA2isKYgSvw8Ddc1QhOimWRUV2m7?=
 =?us-ascii?Q?aDf8f0tzmlhEjfjENpurvo8Rj6qzg58HY73oA9gH6fL4pSlRlKDKK3k4sncl?=
 =?us-ascii?Q?PfDSO38taGEEGi4V7BwSpbxyrQBfO4NfZ2gvUPmriPSJtPs0AmnPYsm3tKNU?=
 =?us-ascii?Q?kQmKGThiGkYeIPdNuSUltCLCkiGkUDdRNGbPvd3t5T80Qr7n3HedNb2FBAda?=
 =?us-ascii?Q?izcJOG7UbKkxd0bVxT+W1Q+UoentZ0yTvVYQN3wNx4ANL1JkfzWEpiqI8Yko?=
 =?us-ascii?Q?cneGQuS+tIcaj92CDGb8d83ZCgKSmFddpmqjhjgQ4T/OgNbRI/C4myZLhIS8?=
 =?us-ascii?Q?1q3IGgD0mUlPXFXdXuFxv4DS9BgK0ME7IYwPhK3ZXwKWMtlmPsArqp9JfSUk?=
 =?us-ascii?Q?vqJQ3lqSPui2xLBvfMjW7IlRJc9UoujAmhc7H3mj0L6Ov1IHyZuZZdMi0mpn?=
 =?us-ascii?Q?kfVqmqXXjAi74mbDSgbT0ISlkJVJq1v+FWy9Z7RPnGknuWQZo7fFGBhKJDeM?=
 =?us-ascii?Q?Cb2mdCda2GXj8Cldw/b2USx3XGY8z7eX1vxzmgWyXQdRL334HexPwKDgmnC7?=
 =?us-ascii?Q?JAzuA9MJBg4fRGuY7gNiRuDQjnadMbom6i3SBigqb0s5hepv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a73d68-91c1-45e6-1b6c-08deaf0374ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 02:17:31.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJEvGjK3cSuNsrPm3xHX9Ue34kjERZE0yvubC/6IzZk3UqmNoEqOzNBl/lvCbFG6uE/mytymsX1b8wMbBwixGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
X-Rspamd-Queue-Id: 3C1B6507230
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286419-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to
> consider:
> - [High] Flawed read-modify-write logic in `netc_mac_port_rmw()` causes s=
tate
> desynchronization and clobbers PMAC registers.
> --
>=20
> commit e2073763516dc99734e9f1436d4b8e960d8ce680
> Author: Wei Fang <wei.fang@nxp.com>
>=20
>     net: dsa: netc: add phylink MAC operations
>=20
> This commit implements phylink MAC operations for NETC switch ports,
> including
> capabilities retrieval and link configuration callbacks.
>=20
> > diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> > index 8e3a3230226c3..8c1317b72a81d 100644
> > --- a/drivers/net/dsa/netc/netc_main.c
> > +++ b/drivers/net/dsa/netc/netc_main.c
> [ ... ]
> > @@ -43,6 +43,26 @@ static void netc_mac_port_wr(struct netc_port *np,
> u32 reg, u32 val)
> >  		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
> >  }
> >
> > +static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
> > +			      u32 mask, u32 val)
> > +{
> > +	u32 old, new;
> > +
> > +	if (is_netc_pseudo_port(np))
> > +		return;
> > +
> > +	WARN_ON((mask | val) !=3D mask);
> > +
> > +	old =3D netc_port_rd(np, reg);
> > +	new =3D (old & ~mask) | val;
> > +	if (new =3D=3D old)
> > +		return;
> > +
> > +	netc_port_wr(np, reg, new);
> > +	if (np->caps.pmac)
> > +		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
>=20
> Does this code lead to desynchronized state and clobbered PMAC registers?
>=20
> Because old is read exclusively from the MAC 0 register, if new =3D=3D ol=
d, the
> function returns immediately. If the preemptable MAC 1 register had a
> different state (e.g. from the bootloader), it would not be updated and c=
ould
> remain permanently out of sync.
>=20
> Additionally, if new !=3D old, this writes the modified MAC 0 state to MA=
C 1.
> Could this clobber any independent state in the MAC 1 register by overwri=
ting
> unmasked bits with MAC 0's values?
>=20
> Would it be safer to perform independent read-modify-write cycles for eac=
h
> MAC's register to preserve their respective unmasked bits?
>=20

The purpose of netc_mac_port_rmw() is to make pMAC and eMAC configurations
the same. This function will not be used if differentiated settings are req=
uired. So
please ignore this false positive.


