Return-Path: <netdev+bounces-270884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGzmICsswml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:16:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEF0302B44
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F551303E43D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA83AE6E2;
	Tue, 24 Mar 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nISF4iZA"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A983AD513;
	Tue, 24 Mar 2026 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332916; cv=fail; b=qEQT4qjU9PzrZn1WLjHn5F2815DsSxd8rjd9PcjBrsq5RiEshAjDug1m3OLIgV4g3awqB+yH1oNdBXpe5425G1eWT/8IQWHIuXZhA+g0qanUI1JC8wAxzpPf5Tz7a6SHHpK2AO05WIJjGPc4852JkPD4LoM56dNiiQwBA9HX0g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332916; c=relaxed/simple;
	bh=NUKdsFh7uzqVYbK6cKjR4xZWIgjxY+brJt96PGjmXeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLR8c9pFLN02mmXcYPem6j+CjYLoCMx8xcPwe55axJzTvM5WL/nd6rVHRgrYkrjmsyF2b0KtFs8JbxQ76gxoT1pcuDXH+V6FiT/IVcZ2cjHN9Pwk/k5cFFjKHz7yzYZfaS3/yUDQlJKjewyxxzqEydfJmbnw8iAi4lqFsf6id34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nISF4iZA; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEFSsdObvL4VAUNjmzjrApXL36IrZpICO22tnKkYeNYhiGICvHAmEoY4ypNilvPl1vNvi/+V/c0V0rQFqCVGRd8QWeZwWis6jIViFQwJcFMvyP8zZ6dmryZgN+L6SaOQwvk3tpaw0YhAtCjlZHBCLJwSTsqDgowDj8VOKPVEKkipukG70F9/La+7XbhszST949aXteHiFvVXsH1IZOUKzr7sVPTy6T6Le621Y7B57iyKCprG6h8LDX5vltbAlkhrvmuXh6sE2vxgnu9NXv6CQIcvbyQwp3v2OQ3AOZ7CcpUNAzPx174SC0i//KEZxPE1V545Oof1U3XLSmXkiPRPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUKdsFh7uzqVYbK6cKjR4xZWIgjxY+brJt96PGjmXeE=;
 b=vVdmVxETSzOzBGnYA34TPPCPOTynt6HSCLHj57H8gpaRnTJk9/i9bEFT8YcCHZqkr91BzS1g20sEDETJVC3SAR+mUJ+wCCZHRiWi1TB2I+5n4XlwosgtqbK6teQRcU7714uQJQu7D+QPYIsKjTIDiVqvk80dI22PyM7eC0VlK87dgMSKSqBFgeO4KKEkG9TwgPsLMZEY6AZpIXcaHaszZYyUyDqPX4i9hj9Ja0YZHIEoeVWhYCExY95bLI8pmDfuIt/7Kx9xWNvuBR0kYfwEirYk53UoNIpgQefwmtYG2sEtKPd5EKhY4DKFjTITyop0uMjLpzVZ5j4PSm8eV+zOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUKdsFh7uzqVYbK6cKjR4xZWIgjxY+brJt96PGjmXeE=;
 b=nISF4iZAvLzN/UxSVCaRmy17CcdmvfAQjR62CIyz2wx95VQXncU8ggtHJt6pk4vccjHD4OEDLxBArAnZ5xFqfC155HAzsxgs99ttXrQhqPXttxWDG5WkW4ykhNznZ7kvb74GGmy/0RihsF8/XEyMpeOSD/wWG/rNFK0cglxs2Cf8wJHpQ2I/7yR3txFzNtyS4NbjuuPJNraC8CVEJuqGMH63ML7pHsGPAneW3Y8Zjk519h3+pcLUti3Wuc2cBeYG95qHCKz97zhb1qGdmySkSSt3KKAe82FF+DFpHaT5Ke3Leqhp3+LeexPwvYA8i4W0f6zJU+/uawUUvhWxNein8Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 06:15:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 06:15:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Buday Csaba <buday.csaba@prolan.hu>
CC: Richard Cochran <richardcochran@gmail.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Bence_Cs=F3k=E1s?=
	<bence98@sch.bme.hu>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Topic: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Index: AQHct7lhfXWJmdf5eEKPBwB60hlOFrW8GKlQgADCOQCAABuQgIAAFf2AgAAki0A=
Date: Tue, 24 Mar 2026 06:15:06 +0000
Message-ID:
 <PAXPR04MB85102EBE72888699094C42EF8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
	<PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<20260323172842.7a62979d@kernel.org>
	<PAXPR04MB85106975EB34F6B1652953FC8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20260323202603.2897abf4@kernel.org>
In-Reply-To: <20260323202603.2897abf4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU0PR04MB9694:EE_
x-ms-office365-filtering-correlation-id: 246e1bf3-511a-48ce-cc67-08de896cb19a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 /Bld9/oz1rKbfMQYiDvIoYMk9QOGw6O480JwnrObFsmphGrvja4t80EvbWGp+1rVUwpUPKn4CCWKSZTgVcjxURKZUJvyeOhf3fs9Dl2leOSk+MZHK+4Wu0kX8WmLFqfRORiWFNaDhc2mBH9zG8vecYeznjBdOM0wnfaB6BNG4GvlFpgQLrC9Kmo1AhLng/h0lZPomxsC3OGKt9eEaZzlbj0FcycofuBl4kJ2Sz1Qv9wz7njsgSgPMrwAF03K4RGCzbz1AuajQ2NLOy2VBhI9PipId+f9KLH2+8JbzpLe2lNG+J/rAVEDEq36V2nuQpzXpTo7Ql9tIVPpI+384uyKa7alDWnUBv9X5zuBttNvJcU0u2OCZdBf+N1nmTwEhe6wrPzR+Fy32tKDDZDG0NYDEfGDJvYmdgQWzIqWadlw8/LVhf7jwqHHzLcF834TerZEgb0xXKJ+Qrx56P7hvDwQMWmskToXGXX4fykgsNJdDJ6wWbeiLre9KhNaIcxw75YZVUw8Sf4uZBQSh6uWpHrDxlBOfLqvGZfZNBNcplMN7oFpBlE+ZnL38klswOo16+WBn0HBYiQkyQQbBFbpolLF2JEnb5AfpwjP/uHio9TPqZrY9zMJnekaNek9U6oHgzLBwftKD/vCvqIHRNjtZwj5EaERlNf0z+yik1V74MfQ7/T3uv0n9KLOYAqVX07MBikW0pgbEA8/UDDUp1MUyxRi6hqTBZ67XYDUyJ1Xi+1Qy3Zl86m03r76ATD+jBLgTAarBGiVHLCNITg5gh0EANBZaL9zKgv1M15mO35CBlsq26Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?H0KB5HrNW2/a0ZccO+RMKGId8RL5Dp7KhqIMBihi7jWCI85kSSAmnfYSxs?=
 =?iso-8859-1?Q?RK9KE6KtjLC+DIL3zdaIkAi5zPO1THeEH1mf/ueJsQ9rDIGAe6ILzlg+ym?=
 =?iso-8859-1?Q?rXWcirJlN/V4QAUNJ4rLG1YiQJYNcIYLZnX2qLpynMFuNkQDN4ybqADaKN?=
 =?iso-8859-1?Q?C3d9OWku1wMQKDiAb+FQ+hjuYKSvJWkoch8THbrUf+qjUvkxNiBt6cPuK+?=
 =?iso-8859-1?Q?RhhitTVO4iRX3/TL9wniwC2hmHUfpXplV5PDgU+zMDSw5BtgtbrgtNH5Kl?=
 =?iso-8859-1?Q?FAmLuE3sO0YNOqO7Hi6Ozk+hblbKRHa70GhQuSeziEb/278xLLanz0e3CB?=
 =?iso-8859-1?Q?7x4umm2OhHxaTcrttyvQMVNMHyf7iz0UhFS2N8HjMHuyUM30xyZyPPp9Ja?=
 =?iso-8859-1?Q?965Gn1vB6oFvQwnFYRbpOfosE8NcCGDRFgCm/DkoVHfmFkxubrYBWSyA2b?=
 =?iso-8859-1?Q?TkQefLRiWKW1RGUwwkJ+rw340b7VVQib7RiSZlEDE2meAxDttjuWe0PRjn?=
 =?iso-8859-1?Q?dlPawriLm4tEt5xbjIX9D52jh++MdBaP3Wa4DvzWIA4b0BVJezkGnFK1HL?=
 =?iso-8859-1?Q?2ds4lxcNw02WHF5Thjzrun8UfEX08kvjoh0ZyWwfNkrdQsK6aA00k/P4AG?=
 =?iso-8859-1?Q?D8JQKl+fHrOq+YaolYgU9ABJaN/NyoV/CMFs+15Mue9QMKMXttZvsqIfwC?=
 =?iso-8859-1?Q?iEXOzK6Z0q1tpLHTF4CaBNA2QFymhhQ0lTE0y42oirtBcN1lLswPtdF/99?=
 =?iso-8859-1?Q?KE8sOWcUupZNGB0gpS5wtBreIj5yvul+hFtuPPyN4AWhphJJ88JQExElLz?=
 =?iso-8859-1?Q?l9rOdPlHPkTMQZESWs1BjObD6GQ0OwOKC5/HhL1SbPGrC7Xr6KV5JCXDt6?=
 =?iso-8859-1?Q?nvnu4nWvfCaKe+xA5tNH3WF2ALLgTDUEfdgNhGKP4m2+IqHwkKpmAK1fY+?=
 =?iso-8859-1?Q?P/8MRqJ4lJgGvrl63oVuGhKuFn1RcLvIvwlQY4inxR4w0+DNiRF6LRoKdv?=
 =?iso-8859-1?Q?NDmSkxVQ6pgCy1l7UQGyWsEGeLQKtnJSI5y9MzO92K4V+k9p9hOodPlnoV?=
 =?iso-8859-1?Q?S5vtI94YpXzCcWxrfRX3giU7BG458ItID8KVrL+vsGgMbQanR4+l7S+pKM?=
 =?iso-8859-1?Q?4LrBDlOJr98fyEeVsnz4nQOYErZIYon2gmm+/EU70SmmAKenAVu7oR+Hum?=
 =?iso-8859-1?Q?oVfo8ldbzZyehJcDba3FVWoDG9oY3bDFBLGBW5+YdPqn8S6CvaaI6UexfI?=
 =?iso-8859-1?Q?JMadkH5czw1AnfSdGvDjElKkXNuQvbCkskMw13PBKRk4079MJs1vSdU0bA?=
 =?iso-8859-1?Q?x5TmZwN57Qmd2Y9jp1v1iI4EjsHOPK1gUBCsJJJMhopdjBnKtZbfs/W/6k?=
 =?iso-8859-1?Q?rXqeMH2SVtNH5UOtf5Bb29MfD7HVtdkx784LN7s+PO4pDkXPGM3eBRrwxb?=
 =?iso-8859-1?Q?tRpAFlNTsTLeGPY2R36Pcs23POr7gm8RhT8Ae7wKxwdxeSqqtKNXnMpDCz?=
 =?iso-8859-1?Q?hDNLuMcgkhA/gZ8Vz/JNvZrg4kxBn14pYACDhwnUXFhJ9vXULsdUfwe+JP?=
 =?iso-8859-1?Q?qFcemDSDi2bbfcCSq8wcA0ODcoKz8v1GxVUoubgH+qanjLrhxvOVspRUhA?=
 =?iso-8859-1?Q?8EHE36ygHd45pm6u7pzK51oPGJ/NUR8O37EVuwe9MzdtBZUmfOe/7YXvTc?=
 =?iso-8859-1?Q?btBbtbmDfFffSNbtUprxmK7weex7Yf4NQ4ZiIPguYRRXXBSlDnhSmK2Q18?=
 =?iso-8859-1?Q?9Opm13p3/oNjObqIBMFipJ0ykXMAmJF7wf5TPKC3o03iwX?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 246e1bf3-511a-48ce-cc67-08de896cb19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 06:15:06.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYDcke7+jmLgumP8ar19LJNRGM3bzj6izgz+WKlpP7aBccjgorJygXa7SToNq+osGlVBuhOo8auwwJvvfQ3h+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270884-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,sch.bme.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 2FEF0302B44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > > I don't understand why you think that we should be exposing 4 channel=
s
> > > to the user when they can only use one. And have the user guess which
> > > one should be programmed. Please explain (and Buday will have to upda=
te
> > > the commit message), to me v1 looked like a much better fix.
> >
> > As I explained in v1, I think the "channel index" parameter of
> > "/sys/class/ptp/ptp<N>/period" refers to the hardware channel number,
> > rather than the software mapping to the hardware channel.
>=20
> Can you cite any documentation or examples?

There is no documentation that explicitly specifies whether it must be
the hardware channel or the software-defined channel. So this leads
to different people having different understandings of it.

> What would be the benefit of exposing the ID within the MAC IP (not
> even the board) to the user?

From my perspective, I expect the "channel index" to be consistent with
"fsl,pps-channel" property, otherwise this may confuse some users.

Hi Buday,

If you want to revert to the first version, I suggest removing the check.
Because the check in period_store() already guarantees that
req.perout.index must be 0.


