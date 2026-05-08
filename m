Return-Path: <netdev+bounces-285740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LWOFMKx/WkShwAAu9opvQ
	(envelope-from <netdev+bounces-285740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393F4F4742
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FEF83002537
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670438F233;
	Fri,  8 May 2026 09:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE8351C1E;
	Fri,  8 May 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233788; cv=fail; b=lB+qQPSvkfgqpv+6eqIYVYFJHOY18AopGoEnkuA9Pm9D+o0YD50IdGJ2GSBkps7Mm9ivdYv8gnvq8zyPf/R04uDYwgEkADrjyw1HkXOOb78LZqqGMgyLjicfSRh2HFSMQN+Rqx9Fb/cct3T+G6tw/TJKezOnE2WFR80wiN6jGuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233788; c=relaxed/simple;
	bh=Go2BUr2prLJDXyTVAoe62KRemCPg6DWs8+2T9wsVYe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=udxCezfaoxiel3CdlGIpE9nsBnYW2AtnpNmad0pmSaxkZHtAufD04JF3xM90z1hRc6b9L7JLbjLzNIdYugcr5BH28locgx3PAFJr7fUPCNJSSkSCTpQv0n9NdSGMq+35lsIcApYrZM7ODWSy8LmIUeEt7KpzvHvZ9CeAUgDgll0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXmE/ocD4xKgqhmco6aybPe46BUSwQuPVgIdSI3QUx4wMnJioNr+3yBxexeqytAj0MW5+fmYfZjdTAt5xHDBUKMwxk9lmueZsAihuvkP8jWqsTPG/3ia+20ViwlO4Py6a1TUzQtYozYY8Q72v7wp9U9SwBnXR1svwmeEOkU9gQtb0hqM/drVHmV6IGC+lfRvlC17/fYxnb200Azpg4hwnGFqWpZpJy060iZxUhQAUvMeFH+7XS5H/1Vz4viHQ7fXs17jgADLjjWnSkXQDDGO1Kd0sdHN8wSHxtMHurDs3xC8uy9zbGNptHogcCnCWVd2kn+VVNiQSJNifv41qwaQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onzty2FD9HT4lFib4oqc8TooonV+p3zn1i+W43psc6E=;
 b=N1PV+PojYlClP2vU0JJdxU7+DandFnxz+tpaUYA/6Wch50jxFfIu+HjEIBCsSOdnXSecmHtUNJKTnN542CLUUjMCHz8rfE0J71olvxLYr/Akgwp9LefGX7JKS6bsuVPyy2cmF1/13oMxmcu2dXEiey+qP/0bEmqFF4/p0MeJPzz1MBh3tt+GEckRaBchimNzYFwKAMGgudr2+nA8F6/2SUSKCp1cYOXNCmI7PGfny6rMIskr10WK74u5I1yNDFVgtFmECjZubIqgrYK3vXTW72f6FzJfRrq+4Bwm6u2hugqnID7WZ7Uj11yPVRn1yXkKKRnppkMy6g9BdIToISblQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0598.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 09:35:18 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Fri, 8 May 2026 09:35:17 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v3 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Thread-Topic: [net-next v3 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Thread-Index: AQHc3gWu27xAIUUW2EqhzN2fefZh5rYC1kcAgAEJomA=
Date: Fri, 8 May 2026 09:35:17 +0000
Message-ID:
 <BJXPR01MB085559F6A258DC137A2F696DE63D2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-5-minda.chen@starfivetech.com>
 <20260507-reoccur-underfoot-bac75e8e454d@spud>
In-Reply-To: <20260507-reoccur-underfoot-bac75e8e454d@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0598:EE_
x-ms-office365-filtering-correlation-id: e01b4662-58c4-4791-6681-08deace51da7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 aUidpFbIYR8q1KiaWPl6BKZxhsC/aQLMBeZBoAMR44ZKKb2IrZ0KEMJPwNzPk0l5OxIsBRnGSw52C/dCUfPZWNPJ5b8ZVyWDq1lzMGCBEmP0e/CPdsw4kseA/Hlm5PvOqT9XhfF+8vQb9WhhiP7/3+WhWUmTQNE5q1NrjoIoH1KqQSbKypohmzuZliOtQHnyjqUClRkwTkS75d9qX8Ns2LpyeugucWDxD4cBaFeCdWy+ayYfsiC9Rq75sJMx6lv/jqpZqyjY5YH4ts0cCTi+oytC9C1Xpb/7pU9nL+F+Em51C/IBypTo6SIqQ5mteiaWa8PPZC28sOjaWdojwKllWS+Pmv33acWoHt2GPhAbtNvnbmjn9ccuy05FCDJgMQo9E/uDle5tQ/sYEcM5D57iGGr7J/kqCtfgoVYrQojNsJlbA+XWzECqiW3C1qiN5YScuQ5H3JAMAp03y4CDaoBmiIvg8ioaTcr+yaXdHqCO6ulLRjHrK3IIFzAAEq6/uONdHQJOkE2kty8Up+zmqBE3IZrq+MBnN/OSS++6biH3y2R+pPDGpKWVtTBvFgAxPAY9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?taVdGasxyqFSZyq+GM35ZNJ7phuf3kMHXSbPmar0QPHrSeKPmBw6UvXsiQvy?=
 =?us-ascii?Q?vhCiL9bfglI7vXNDJ5eeIGizYHBIeny8Yw3ZsMGWWJxX9tjZ2XGH78cZ/xC5?=
 =?us-ascii?Q?U/JwsTbTwus3+Ko7FiFwPoDrQXAit2WDAXzvsvoHAmTPTtQvfZvequTOPjOd?=
 =?us-ascii?Q?eUOmyU1ykA2phh7skO5eOd7bhiDtVNSjIX2ZebamGh4kWFZGoG3RfvvygKcF?=
 =?us-ascii?Q?Nokd3a2LJJKpmiIWZnpKDbA57gd8gZoRtIq2QaPEl+rsu2OMXHQz7GFPQvpp?=
 =?us-ascii?Q?LCo2iEFVYrEAv79/ofriN1wVlExZPNFwOr14+vkPQGPqjFhw2x317QlABbUy?=
 =?us-ascii?Q?1qk0Ay1FhE2oaQckD108O9Cgj/IjgeLOcLLROL6gzTqEP4nvUiFGveArNLSg?=
 =?us-ascii?Q?51e2+wOUILVB8sqTNdX/lmI5JKWEMPmJWoYj+Ge3kDV/6tsmmPm+JoRgf2EH?=
 =?us-ascii?Q?rn8hwfrnvlzd6siV2pxrksCDDgWFPHih0eEzK/CpLoZwgzHCwIDO4XoG/Mae?=
 =?us-ascii?Q?KfwUQ0Kzn8SJECFT5TpKqJUboAgbeqpZGgmHapBzVFQUKPs4j0bkBvhhwKNV?=
 =?us-ascii?Q?SuBsJ0n6Qd36mJ21YcxiLUqHjXS3Hcn/e6F7xn3ItFgx1kL/3RwoCUUJtuAv?=
 =?us-ascii?Q?BRcbo3nb6tzcQhQpfPAb8a71JAlmpR6+CWWliiGQ8VWNt0VWVdy/TCqfUn2v?=
 =?us-ascii?Q?P3xL6vsRpJ+Zl1hKpKeCCkp2+o6LwIXJbP42CC7AF/s/IT27tBxEqk9xwkoD?=
 =?us-ascii?Q?Z76Ngf5IujU0qq43CJjYT0AITvsZfU/mMkxpqmRQHt8b2YVwi38RMHiWLPO1?=
 =?us-ascii?Q?15pDXf+nCceKLs0zLrtaGZDey6azKur8BsX6C5WyRJ0LpFX6H5HiScDmlY1e?=
 =?us-ascii?Q?Bp33He475Uy1LQhAn4nlNKj8BbbpQJBzGukKEL91Luw3kPRkT2PtR+nelYyH?=
 =?us-ascii?Q?KuLghUYFdoe80Ywk2p4/1r+2d7cWyrQg4lonfebK3NspERlTZfm8U0mfJVJa?=
 =?us-ascii?Q?GZlACOGPEuC9AeOCwTXna6Q3ODEToAeeSg+6Zx6F7c4rW6BSRo/UVgD9ql4n?=
 =?us-ascii?Q?oqIfBzJl7txQ0B2mKZYrKwMLB5NVKEtJ81DjAjAk5OrBul8xZbv+GeaObC/g?=
 =?us-ascii?Q?RDOgKs/4INeCikxbe1bleKWvC2qSBgaTY9eLeyrP2OMf0a3IUwByoBu6yZDr?=
 =?us-ascii?Q?/tT2K+DilvI0a7ZPrujXQ41yFCd1wD2fSHSEFvg399NwdIDp5xtbn6Gw4LsN?=
 =?us-ascii?Q?Ph4rXRiZv7t16QiIJNXTok0t7oPgUGNrAhv62YHNSbJHBjVjeGhvNUKFQHFw?=
 =?us-ascii?Q?X8g3gcnbhSmhHTrHOqVzzBra0mHtziIldWdlNXvaXftv2BXzE54x+RgSAMHB?=
 =?us-ascii?Q?UPnjLPqYMPAfk+XL/h5ZLey+7ZQhYAaMRoIQxKTp9/Z1y9or2oXeOjMCl9zQ?=
 =?us-ascii?Q?HDeZICixJFX1H+Jlhet0MuWtxNHWgomTITD1tJMfLaYEBxBiDgvnvzFKp/Yn?=
 =?us-ascii?Q?imwfKueDQ3O4jiN/jwOh9BCx3gskwZGA/OsBodYowgD7keQ0WapGOVclUjSL?=
 =?us-ascii?Q?77vsJKXEMSVj443jgTz7xob8ln9hbVTa3CuDn0OsaBOBIiEktmTS/tXlu+8d?=
 =?us-ascii?Q?IQ2Xp9YKFbPLIcrTXYFgs/bRY1ADnuaGnIzz4+k9+lreLS0KyWGDPNT3DUdG?=
 =?us-ascii?Q?nLQoc+LpwEkF+QTzCObCNl1HBuHHl95+wjfRH/q5yZYqX9MyXBa8kB8aWeDq?=
 =?us-ascii?Q?Lbbtrgg9SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: e01b4662-58c4-4791-6681-08deace51da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:35:17.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0ZNasT218b9Yga7vhguh4/cDeNQhrUbLMqfxjncJ0f0s+2x1/TicbxE/MMDNLxSvCd8gTlCocl2pdCgI2IaU+/IzC17W8wvj3ADvym+TAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0598
X-Rspamd-Queue-Id: 2393F4F4742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-285740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.899];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid,starfivetech.com:email,marvell.com:email]
X-Rspamd-Action: no action


>=20
> On Thu, May 07, 2026 at 05:41:14PM +0800, Minda Chen wrote:
> > Add jhb100 compatible and SGMII support. jhb100 soc contains
> > 2 SGMII interfaces and integrated with serdes PHY. SGMII with split
> > TX/RX MAC clock and need to set 2.5M/25M/125M TX/RX clock rate in
> > 10M/100M/1000M speed mode.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Reviewed-by: Sai Krishna <saikrishnag@marvell.com> @@ -130,6 +160,7 @@
> > static const struct starfive_dwmac_data jh7100_data =3D {  static const
> > struct of_device_id starfive_dwmac_match[] =3D {
> >  	{ .compatible =3D "starfive,jh7100-dwmac", .data =3D &jh7100_data },
> >  	{ .compatible =3D "starfive,jh7110-dwmac" },
> > +	{ .compatible =3D "starfive,jhb100-dwmac" },
>=20
> You've declared compatibility with the jh7110, why do you also need to ad=
d the
> new comaptible?
>=20

I am sorry, I forget to remove this.=20

> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
> > --
> > 2.17.1
> >

