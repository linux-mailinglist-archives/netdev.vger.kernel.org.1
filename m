Return-Path: <netdev+bounces-270844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI2PDzzvwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:56:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1175300C38
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14407303B958
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3E37C93D;
	Tue, 24 Mar 2026 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UdlJyImW"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C737BE65;
	Tue, 24 Mar 2026 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317357; cv=fail; b=WU6Jp8iTDs0hrPltTtT7kaucxvKg1rWabvXC3DpfcFeSJiQTmI7nLFs2DfE7UzCU+f5k0xDPWTqSkWTXjpTshFGOCEqE64WMNgdqT0wpYZ2iwUYB3hTjfjfuuilnW9UaRAP9UfDtUlZhZLWSDKcVQEwGWt1ygnll8tEHaO9x2YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317357; c=relaxed/simple;
	bh=AwAvuL7zUpd08gjHKZXwOJEU5RuSpNOgI4iq2sUkVI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gkkV620YywVEFdDbFOYblbzAWJ/OM9mwt8ydeLc5hqAMGl4c3HDyR2Taons/Yrhn6fXnHjjhoozUHq1D4CtmYuGmy1P7OsDYLzjzaTHmmBPBPVALptYi3SG1X3Ab1Ltpm4wZqpMdaHzfqiWzDRvmlBv3zxig261kqgv/L//9m2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UdlJyImW; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxznJqOdD4GiXueZ/PbKSyi+3d3tYjGx+Xpasy8ZqRTx0QFnS+AxYXkjNsNZA4QfRCj8cUK/E7oL/CfFnC+ycsZQGUKhPuevLi+uiG7mwzhniQm/TCeFhY/ro4wmZXZW3570csFOAvYIw7gE3jvMHm07iKhCtbpqo9CtbPdU3Rk5dAAKbcL4KAmsNpV8Q9+V1hedd8aCaQvbLcUL/IIIwDptkO6tgAiwCDY/Mz1QoFAu7ivAlpzP1tXLYyvmwmDajYseu2oiTZSHwLGwYU6dibrZO7NQLAhUhcfJqqnvihr+i0lk6qSKp/W5ozWLg4vIw0oKIIAwZIzA8wT9mTszuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwAvuL7zUpd08gjHKZXwOJEU5RuSpNOgI4iq2sUkVI4=;
 b=EX7Iu636BPsAHUMOXDuSA45u4wu7ECC34naxpbmo49nFua7tXVrEfforKqrkYx09L+WPn0hVfOp1r2Ey3qg6JwShMxiW1wQTb2TE5cUeziKM/FHaPiF8+2/UeqexTRGIFBLxXIxq8aIJBEFVYofohWwMBhQ0zsbnsQAb97UorDDBUVIp1lEvIu2mZEdNMFmlOr4Vlz1nEwc6DW/JqDIo6LYF3Lx74rPEs/BNzul5p60bcbY7NLG4DbdkV7YiX4CO9VOGK0dtkAn3ZYeTYOrTiQUw0FVVvnKmWbVYQV+ok8QzeJT7Z4gvyS6N0UmF8hJ9RCMXLJoYrWQ07fD231JbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwAvuL7zUpd08gjHKZXwOJEU5RuSpNOgI4iq2sUkVI4=;
 b=UdlJyImWundHT+kziQqS+mOiKYToELHnI+2xFpDUAkTryD5kDZ8RsNrBEPZx+XAlhhmZRmw739f1WPvAEfK1m85iLR/xkP+B200wFL9bIoIXgqlkurZIqMh4q+/dhUhbZ9SpN1Jr5IaGs2jcLHDlLkn9ysCjJMaerTUFisW5f8j9FvQs5mM8oAK0OMHP7X/jxeBvy14vTE8blMIW1kqlMmanoCVGU/L+W+gJ3dPx6S2pLZGiMexsfEk5JOL5VxTwf8q3tdb75wvpCfxtpC2N8AfmlUocHooQjnrkgyuwKBtusSnky0Gr0yIOgxgpL5bbYZaMe02AQFZdyBQKT4fIZQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8984.eurprd04.prod.outlook.com (2603:10a6:10:2e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 01:55:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 01:55:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Thread-Topic: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Thread-Index: AQHcss4KuCbBqII4UEKPje859/m9cLW7+6pAgAC5I4CAAEX8oA==
Date: Tue, 24 Mar 2026 01:55:50 +0000
Message-ID:
 <PAXPR04MB8510FD5C6A9E0BDBB1CD3B198848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
	<PAXPR04MB8510310D3FEC15E163A2FCF7884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20260323143711.2775bfa7@kernel.org>
In-Reply-To: <20260323143711.2775bfa7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8984:EE_
x-ms-office365-filtering-correlation-id: 8db8e794-6ce1-4ede-907a-08de894879bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 l+Qu/c+NTrUXk1PkwlQecxnCNf1Hqo0AdLGfWIbR7hLdOm2sL4T43pCTIo5rir6xUuMFwtgu8MNbeCteBJgGLppyzeMwhH3uLd4zt5jngnFYigqf1Fuf3h8nFi9GHPCla551EEmAbav5I/4RTqJmVbTFOARoVYzNeXqI8Y8hMq5q4A3PzwThps2WNA/H/wVL1NZ++QxpYkoA86k4cE6rfvMQelrDjKRBSiTMH/UtNai5JZQWeCsuWRfrpX9PEwF4ljg5CjiKFe7pSUAY760HzyEMstWliyT4Ij2L8V1kEwZghIFAGOkl5UKt8xED8NxTnJMKDfKnGPfSKxWLaeqCCXCHwT0nCkPCpHStWh7Xh1NM05XIK5vm/4wsqYO5Omdyb4x7ZpxG83skfaoWRcWu4APsGRXBxKB8idwuvuBa0D79ExU2ok5pv9rJ+tWjzGn234OJ6ZhXq2IzEI99zYdpZrGSoAmhAQWhS7hZz6h4fDakh9IbNgazl5vKn6LPsqrja2/PkOWwmmiP1JAydVqZzdQLqHnV0CCO2FSxWMadQUdYwEmQky4590joudG+X8J0B4hhXboS9vqMmfplwdE7UGdwZjJtPRhFTIVUt5Ncxnhe/+F+4xVbU0OzrcDBc73h4Nw2UfYUdKSsgK9yXihSOu4TF0Esy1Z5X7wEpcO2OOjUOUrkU+1NCRC7/8faxiTV913zqb3LxGDXZ8yr8zn62FlpwQ0bDA4frVTh4tB7SPuInczjVuvbGpP1BDpnvKAzMlMntzQYMWX5JiVu+qk0VQXwKPB6P0pEE1+hJgt6E8A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fe/l9w7y1o5R0wIH2U3/znhHSi8UfVyJAr6otf37PGVW4DXY1UKW5+A7uKDb?=
 =?us-ascii?Q?vZ0TIr14Og23l6mkn1SijMnZAXkYGNyPZMF/FcUQKKvQuq8H2ZFHCIxnPG+x?=
 =?us-ascii?Q?s8ReCLLcVMh5v8HnWL/Xva7AvWivP/2ai2ozKl2Mxd6GvnSnOx6PT76W1ACa?=
 =?us-ascii?Q?5QPvUuhfHkCIel4CSwgIJTrBouXBnDleyyaYgMRKhpPyu400RTHuMctX+e95?=
 =?us-ascii?Q?XYFP14PtJHB+tTstl3Eo+pEtKJz0OhaxkwPB5rsYNpadggJ/+s3Dj3q/y681?=
 =?us-ascii?Q?fukxA3ZcLf/zDEtoyzpN5gtACr0JaRFIQErp2grJaDjrWXGqV1FiIsEvG+/S?=
 =?us-ascii?Q?Iua0txbdfHsiT0Tew+5UMP332ZWvWjFkOJckk7A9wg75VWglHKYhVqUZi9J4?=
 =?us-ascii?Q?ZeD9uSK/IvosRjo22ulANp2x2MjGq/dcMHhsYZlSAZkTTEloELeRH+KbWXLj?=
 =?us-ascii?Q?kWtzksYRLgyDi/qUsoH8czWheaZ9NqQWT5zWbJo/s4kW4/FpKc6o4kym0/7i?=
 =?us-ascii?Q?dO8MVAoDkTC0eNa5A33yszpyAOo4OiTRHdlbdFbz8avaANYVSahsSuyECW76?=
 =?us-ascii?Q?Z58Mnc0aTRnMwqKrpzPGwuIEaZgZUwkrHGF1SrqQNU7uGBkaZW9cniK8JyCq?=
 =?us-ascii?Q?auKSqXeHcbZ5ay09Iz+IcORkU8dge/MutjLkci7URanFmaOAdjClEVzarHuj?=
 =?us-ascii?Q?nKy318karlN3SgWSJkVu8d+F4/MwG4FykJX7zOu+zYtA2fhWWcs83XJZjPyH?=
 =?us-ascii?Q?UkMNG/jvE00BQc07c0pYGfBasLxTw+PVz1UfxDensuC008xrHfLGPblBkP3b?=
 =?us-ascii?Q?K3nUMYVdrr1NMyTaf5C5I85E96hJg54ceP1c3U/C0FAPdvsR/LUXjp3/S7w/?=
 =?us-ascii?Q?jcanaAvWyTM1vmsRc3kTCB8lBRCfFbP+yeRxK9D0Vw0EvPOcfzTiUcP5vHxd?=
 =?us-ascii?Q?CgQRGeGRDEwWeG3VysF1UCXNzUkAaZ0gEuExeU37Tx8+hiGPLVpJojooHpZ8?=
 =?us-ascii?Q?I8uNwTVNkrJKo8AfVyd40j23/3Zo9mnYEbPBgPXdd5opyS6ePzdzGQoM0xO5?=
 =?us-ascii?Q?Pdafybu+mUVQGke3uYHbbPpmJu5MnPSqo2orK0ey2942cvWaVWMV6lbGae5L?=
 =?us-ascii?Q?GniLsbkDf2Duv9334WaawkDS87DPalhDrqzgQZiHV4weEWtWlqKq1PoYiI3X?=
 =?us-ascii?Q?pNzVorZXeBvwUFL2hI5+W/3JqPvuJmcdM93z7o6EmEewVjeroMkscJyfetJF?=
 =?us-ascii?Q?oKN9qGaIXQGstRGc/XJ3ZoU6c+IBZBxxUJeSRMEXFZcE9ZRMC4+NffPAXAZI?=
 =?us-ascii?Q?ICAV5arkDLnuRryeSXSWfIq5PIsVNrmJNMGrWfOfBvpQO41g9bg1QpFP5NWg?=
 =?us-ascii?Q?JLFmIAh67nc7NeEYhOpcs4/QoDWuLxeQP6etqUN2E4/YwFgCBE1+bqnVgZU1?=
 =?us-ascii?Q?I+upgf9DyAUrUBQp2Hyp52ks59IolnpOekFrzBydtwReRMilGKIi06vJv895?=
 =?us-ascii?Q?7ehZfyyiI9MRDD7HYi4jbDDM3o6Kdor5GJYcb9vuD2Qbjt/eikMIyP6D/aZk?=
 =?us-ascii?Q?edqI1DR0DAidIoRIzeGfrDaoqeAivogIzoIuedxxzd8cY37IIholbSy6lYWB?=
 =?us-ascii?Q?vHNasVXPWdMB4N0ziePPfUZDsWk8g4IOLnuDpyxO9abNQ63xjA60MP8oGAgZ?=
 =?us-ascii?Q?1C1XFT32stro6aDX4TeNx+TrYA/Yfxsb5lj17lkXdS7/cD0g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db8e794-6ce1-4ede-907a-08de894879bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 01:55:50.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aow2uuB0QhcKiXt71RWcaloqgGc9CcS416MCMbRnfVAYcQHjt0aSkLVJl/l/xQYnMwVaDi8NZQSaZZThc3KhSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8984
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270844-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,marvell.com:email]
X-Rspamd-Queue-Id: A1175300C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Cc: pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg;
> imx@lists.linux.dev; linux@armlinux.org.uk; Frank Li <frank.li@nxp.com>;
> horms@kernel.org; saikrishnag@marvell.com; Claudiu Manoil
> <claudiu.manoil@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>; Clar=
k
> Wang <xiaoning.wang@nxp.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com
> Subject: Re: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD rin=
g when it
> has unsent frames
>=20
> On Mon, 23 Mar 2026 10:40:03 +0000 Wei Fang wrote:
> > Can this series be applied? Or is further improvement needed?
>=20
> It's too old now, please repost and reflect the discussion in
> the commit messages.

Okay, I will resend this patch set.

Regarding the discussion in patch 3, I have actually already explained it i=
n
the commit message, Claudiu misread the manual. So no need to update
the commit message.

