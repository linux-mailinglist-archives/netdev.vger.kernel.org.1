Return-Path: <netdev+bounces-255695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIwcOAAIgGkq1wIAu9opvQ
	(envelope-from <netdev+bounces-255695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:12:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45498C7D9E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0287A30048C5
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 02:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5D1531C8;
	Mon,  2 Feb 2026 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CGinSaW9"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66D26AC3
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998334; cv=fail; b=BlswRI6DePd9duRre27EcKbLh0VgzaVk4E3WLC4zGKgojMafQqQiCIV/yWFJ3fqD3Dg+fSP7jGXBFcqvk9NXkC+k9x3YAw8QPBF5WCdiB3mM3ScDzvyIEQELid+AQWTvCSHB52dFNOI0Xn8hge0arK3v5iTn8q4bqlmrdleOe/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998334; c=relaxed/simple;
	bh=xqifPxfJDK7BDvPBU/km0sN6yO4ciwcKu1Vu6LZQxbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJ1f3w1naldQTdzxix7mGoE+HcgrnD6+jihFWwf/UoIXIZFe3HfA7hF+Bx3Zz2AGsHOdlc2ToPnQdE7/BuJaXP8/ww/JYfqdDv2lHByHzFzG2ILj6JY1K/venb5yJeMi/MbgPBN9o2AS3skwYUtWuLvd1gpiDqGmCWwZ6WGtdsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CGinSaW9; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgnJ4QGMtyLF3mkANEUBmhViKMVhOFY+YWlDr0Kfcvq/6yjiBJaURKh/tP1yWXBbk9aWH8E0Bcmf9DPLgehqRO1eMYs5UrBoEhr/3GEc7cVH0YuzuxaxR8b+SNEG/6c4sNR6QpkMitJxXT5qizFt3UB/vpmgwuxPaSdj8OOS5zTJowaIChqM0lhZvDBUGmLoWQbt6IK6A9qTji/DUyslwZZz5NMDJnhKjcTdqRtPB09APpO49xnVkkxh56fZ5K/spXqYZ3HncesN4g2twhFWNfNsWe598r2tXfufK2Alf7v55gtKQ3Ohdo9lF93oei0GVAgpQSwatBF51a1m9ZETuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw62j6vQjz01cvMDGGs36mGAT6apO1YAgb1AS6Fb89c=;
 b=GBM6fnbaCFKzlTBLxfz8NPp8bpKBVeIN8zJ7zmCmV/N4S0gLHwkvjygKcbjrSCRQ4LQZ6+rCfCPd5sWvbRXudJwRJin/9CbeaVCxb0GcaRfakp6ttlfW7FVz2OUZoIQHn4NGnm15B9GQCk/AC1Vn+nZpL5Nu+esuySd6R9eV/sQO0dnxBjwLmCJOzY3/BpUTmfyW+3wcNYo0AAFGFkd1Qvb5d5fvBUCsbJh0kY0rhcSJagT4Wh9uNybKh/m2qXb6wZ5WrX4QbBeiNJrgVuAaQdECDNH/S1MwE1/x1jY8jObrJTC2w+o/Qrjhw72JaHyPhvB+0YlFyOHETUuYqSIhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw62j6vQjz01cvMDGGs36mGAT6apO1YAgb1AS6Fb89c=;
 b=CGinSaW97esTuWPs9sgg2Sy88RAVyimsRZ6ATCthOWTQKdehULanRCtLGdnBjiMRGvl/ExD92Gp7CXEf0vRSetbTBPSf/bV2hmuUbn5klKt5MbZzg1KmlfharDbAc2nyY5KxJI25gSP4QoMpPjS7M9wZ13dmOOIG1gOlC7ooFW2BJiNtUalQqOxN2Qbo6RHCgn8abnxvOB3fzHqffWKTmUsKkFszRQwodMQnw1056qatU6glcY2ajmMLepQWdrBfY6TrhhwvUCsSZpGTVwq8gdffJzylYWKBniydWE34Fmv3EzaSNmIO0n9qBZv2vYEEvg56kH+Rofc8ODmP2GUc0w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 02:12:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Mon, 2 Feb 2026
 02:12:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net 2/4] net: enetc: Remove CBDR cacheability AXI settings
 for ENETC v4
Thread-Topic: [PATCH net 2/4] net: enetc: Remove CBDR cacheability AXI
 settings for ENETC v4
Thread-Index: AQHckfI4LeSVGjhrzUmkgMyYKxxGC7VurryQ
Date: Mon, 2 Feb 2026 02:12:10 +0000
Message-ID:
 <PAXPR04MB851074D778103130668FA784889AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
 <20260130141035.272471-3-claudiu.manoil@nxp.com>
In-Reply-To: <20260130141035.272471-3-claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10601:EE_
x-ms-office365-filtering-correlation-id: 23070612-4516-418a-526d-08de620078f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ac4tWZ3u3QP4OkSPUuL/4SJ2mK9gtKaJWcJWM7nR7AtrtMxPJg0z2fgTqKuo?=
 =?us-ascii?Q?GOhL5Q8o7UoKP3th+oNBBvhCNW/GVev1zJxQJAMc02NvsLe66bGZ5vduLVWd?=
 =?us-ascii?Q?BumctlTbN15gEBuPoYIUpaRlqHOMvXohSzUN7rLfd6Cc8gfYcG5baOLSwgUm?=
 =?us-ascii?Q?VFsRvK/43tWARjH9bKTobUUAT6dwa4qnjmHuQCuFDiQM2Xy2Cjt6gSK7fM2I?=
 =?us-ascii?Q?If6j43bBs9djTxHLigzWime8MLB4MMuDYNdMkXbaplHyj9kRdaJ91CRcfbkE?=
 =?us-ascii?Q?iH/M27YLtEKcPv4t5FJXUW7O6AhL7e8h0JNkA0qa0EOiggG27bMDN50Oa15k?=
 =?us-ascii?Q?2AEum4KMmCmcyuZ2kCYtNShzPG9D58nRJe/lgaHswHW6lH5VBXLV3hKHUu4a?=
 =?us-ascii?Q?c3PRZQeB4MDjacQMPi/n05G483vp9RFS3q73CfsmjU9BcjBmWfX9B36XR2GX?=
 =?us-ascii?Q?VxKeRIm7UFdBMvf1RUy0LJRo8cUx/g0JXm/SsWEhnNIsyNbbLGpEfNCXMUI5?=
 =?us-ascii?Q?NnRQmT7Z2/b0NLTVDexdvjYdR5QPeJNpZd3WTVEFmM+1tmO1wXVCdSjVzI0i?=
 =?us-ascii?Q?xQmxdru/X0iZkCC56Zd+OrUdjPDZAgOGkbQO6SHST9WfdKgp/wgAlU0JcSDM?=
 =?us-ascii?Q?nA1g5eWtOXbgZHjGEZZP3rMYlnwGj5x6F83WnJuye4MH3WZjqWiXjVSlEbJP?=
 =?us-ascii?Q?4LrrMkrdjIIlD+1AD042GZREGtMqvG30+MQVg1+x+L8prkyBgX2ZEMiiOPVG?=
 =?us-ascii?Q?UWaZWQ9BsaMXP2caUO7uABh/B6rXUR5rn7u97e1Wtk5w0BxS0G6Jsh/AFJXH?=
 =?us-ascii?Q?qhlu1/curVMlPMsmQWKpRgX05xrx8fJqNbrwSJtBRAKaEIEECMTYgn5xkPv9?=
 =?us-ascii?Q?yDdqBSiTj/dNkhbv0OBmw6Zukh3QDcJN/Oy//NTzJcX9/wf20uebo+t/paR6?=
 =?us-ascii?Q?jheULhI3BtBRI0ULJpCzxzfu3j6UEs0SGa2xrqIUUcCauI+UNlXdP6mshbnm?=
 =?us-ascii?Q?NmoufOIt0AVMTF5tSi1sDG5QAP91DOg/H9Ac60bXxRj/o2DzngOjy6dgcEim?=
 =?us-ascii?Q?0gnCOjIcFWOIO/WUVZnawn5QPetT4IS2CYoP5QbdYBCgEetsplgWaJ2rcKVU?=
 =?us-ascii?Q?lYD5VEtXSK/oD4eie1kU5Xy0+c8alV9ULmn4DlPshWGHSAumNwQ/RytgoLjH?=
 =?us-ascii?Q?EqybVY+wq8flTuB1CHYWnvoor4giohQxFnNC6kZOlLkE35X+GW6f27rtL1XB?=
 =?us-ascii?Q?SL0UYAZruONAOd94m9/jybBNB+hh94s1pSgVtE3nk91KzEm0iEOeifqa8hvj?=
 =?us-ascii?Q?+WXnIof0XcFFFhqau0xzlcP+PH5ACXE5ZIlwg206cv86RPMeaolDwUS1txA/?=
 =?us-ascii?Q?xT/R/0AEZLbujYw2+nfGOvgqrfK9+/U2Kf6wErNcP/PR/W3FEsBOeo3CDZcg?=
 =?us-ascii?Q?0brtMWiOJQGeLcmdrLJqn5CoSj2uzdMbnp/CPrOrTACufcgg9SxaoTuhI59g?=
 =?us-ascii?Q?DF0oS0GsTau4L/9tQhbCsOTS3NbfNedTMM91LZm4T08S2B5okr3sfH5rElH+?=
 =?us-ascii?Q?pGYCNjpQxS0lxlSAPU7ror+fK8haJfjsgPGv3Ff4bNhFpet31SZXMCr/o5rr?=
 =?us-ascii?Q?wUtH58XV1HaZVxWYkEM2jhs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f06JjC+ryoeblQDwUxoPm6kBIbomN6scTLJyzbftabB2xE9BwsF16V+Bb7ir?=
 =?us-ascii?Q?bxFm6dfox49V0CNsxwqBoYaldfZ1NPuaqzzJEXgsjXpxSNq9JY+DEKdS+oIo?=
 =?us-ascii?Q?9ngPm7wYXNYAV7L8GmTGIor0VF8YMKrkKp1lTQg//5caxrZzJs8z9csgoF4e?=
 =?us-ascii?Q?FkMA/A5obgCmZPpVwAhWOnpm2es1NiLGnnK4FW8VPrTipgwe2TBMQvGZi2D3?=
 =?us-ascii?Q?rrRG1QFvtys9dYeSSvS8/c8uT6A6Au72nIeMQJDZi6WgLNT9dqryjrO+1mIm?=
 =?us-ascii?Q?WHVFgU9zOGjrdx5GqhQpUp4eTfOKtHrfb8DQimsStCzdv2B1l2BHhSiIZN86?=
 =?us-ascii?Q?3DaWEOZG6LahpmauTW/Ier0aSHYJfjixSKn0/QQINhy5/6SphbZDcoNwfB69?=
 =?us-ascii?Q?BXtGFQSWZ9UINSpSys96MVCJefiuAR2PVNOIz9t9ZsUcx/JRxPGDc9W0JEdG?=
 =?us-ascii?Q?mOfFxkK/Jsc3PGkMyY9MR51OU/0UeyRiuj3UaL+Zp/idRtQ/Q96YXOJ/cUfp?=
 =?us-ascii?Q?3SarkWSmX13f3gDwquoFOJx2NUAF9XBA/H+2El6G+QXHazqBCkX0T6JF8/Hp?=
 =?us-ascii?Q?OK6EMAT6dynfQH49ew3fLAbUFCLd+wWVMkTAR3Qu63pNWmJWjRLCRyr/x4ni?=
 =?us-ascii?Q?apI9shCM9cyAkk0kU9uRJqm62xM2YknBv5i6XY6aN+UyqoljY36szcPHV6Ew?=
 =?us-ascii?Q?56aQIXP06S+LiusmCPL06ItBc/2/sFY1fWvIEG6FivM2UelZWbKkYl4GpcuX?=
 =?us-ascii?Q?J2mOfknVbiX8mYmWgN0sQ/il6jW23U91U50RjyCZHY2kkbHfYJyRhUyot8YS?=
 =?us-ascii?Q?8O5prUPZqZDMIHz8S4ynv+eNqo9WC6D0wSL4jF9DjVTcuHRzx/JIYVj6mjcA?=
 =?us-ascii?Q?lKItoUoZe5+1Nh6uF4E08TK0SjGJHjArLD1R6e3AZD8poSmKgvWXVPCxboq+?=
 =?us-ascii?Q?HX/kLo3OHu3cTpPE45ZRo84Ic0zA0cSRWQnA+1aujpULYNzj4viVpQE1EoW5?=
 =?us-ascii?Q?fZM/HEN7/DeCyvtiHQrj1uYzqrZAdsTHwR8h2CL4HsJRg8UhSjc42yV4TvjY?=
 =?us-ascii?Q?gDcwldTKp4QSvYkm66dP2SSPL2VUU3N/CbEiK2HzCEH9sVg9XsmQrS2FhgbW?=
 =?us-ascii?Q?ww27vWVNrUF1blyPHzbGCWNDOtrUI4qkBi2yMfN51xcCoQHY4mrvm0d+xD68?=
 =?us-ascii?Q?kZ9pfU1FxMSptV+rqnY09ZonpIlROTfFYr7bdD9Aw26KLsOIMTfsz87femds?=
 =?us-ascii?Q?Rf0DxGMTcRxMzLqTnUHkMnpc/E8vwUC3s32TDlKx/mr/d29SBJnxiRqUzRzw?=
 =?us-ascii?Q?h/n00z0APHnmnPygQihSBwnxKcRgHOn9ASiUlVRcZheSP9COv9XtmFdqjltA?=
 =?us-ascii?Q?DxsK6hKZ7nSKVTKl/IfEDRNic0POKQQSK4lC/rKFmldR1Do7eEEbW6HD+FEV?=
 =?us-ascii?Q?z0Cej7h84ZZpwK/1z/8k/KJkMJUZDPIIQkJBNRR2LZPupSi2YMAgXf6BF3b7?=
 =?us-ascii?Q?0NiLSsz2LK9ha+l2p79hlsa7Yrg6g9YOx3UzDfEtbM6P40hN+8YIEWwqIsRO?=
 =?us-ascii?Q?9/7vZRD5uI1VFvUAXOzM1xAmDv9iwhg4ZiNtSPJltGZSBWQgT+6PXDyyl9HO?=
 =?us-ascii?Q?rps9e+N0Clo7j3scaIh2Gw+KWUwnPUhpVyveRyTT7FRnA405uCgfh/j2sWwq?=
 =?us-ascii?Q?Nkl4J+wZ//U8mfgH6f/WBA+3y0osxoU+wZnDcJ3Ulv2ReNP6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23070612-4516-418a-526d-08de620078f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:12:10.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWfMLhbJsB/+W6B8ikbijd3xdaL15/beCpuuzUFT+og/sOisB90T+vBFlVmFvrEGvWm6f4Rm9m37HzvkjIHWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255695-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,regs.mr:url]
X-Rspamd-Queue-Id: 45498C7D9E
X-Rspamd-Action: no action

> For ENETC v4 these settings are controlled by the global ENETC
> command cache attribute registers (EnCAR), from the IERB register
> block.
>=20
> The hardcoded CDBR cacheability settings were inherited from LS1028A,
> and should be removed from the ENETC v4 driver as they conflict
> with the global IERB settings.
>=20
> Fixes: e3f4a0a8ddb4 ("net: enetc: add command BD ring support for i.MX95
> ENETC")
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_cbdr.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> index 3d5f31879d5c..a635bfdc30af 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
> @@ -74,10 +74,6 @@ int enetc4_setup_cbdr(struct enetc_si *si)
>  	if (!user->ring)
>  		return -ENOMEM;
>=20
> -	/* set CBDR cache attributes */
> -	enetc_wr(hw, ENETC_SICAR2,
> -		 ENETC_SICAR_RD_COHERENT | ENETC_SICAR_WR_COHERENT);
> -
>  	regs.pir =3D hw->reg + ENETC_SICBDRPIR;
>  	regs.cir =3D hw->reg + ENETC_SICBDRCIR;
>  	regs.mr =3D hw->reg + ENETC_SICBDRMR;
> --
> 2.34.1

Reviewed-by: Wei Fang <wei.fang@nxp.com>


