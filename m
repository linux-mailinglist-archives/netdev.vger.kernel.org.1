Return-Path: <netdev+bounces-268176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CG/Lm8RuGmIYgEAu9opvQ
	(envelope-from <netdev+bounces-268176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:19:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9929B355
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20FF830A3D22
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D639B976;
	Mon, 16 Mar 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lg09K+cZ"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743D39B95B;
	Mon, 16 Mar 2026 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670427; cv=fail; b=OW/qZ+FDivaBMXcu1Bxg4PhPSD9hCoSKqd0KJABrDZnB3161LrxkA7NvFpsWeq1OD83Pga2ghoz8oD/t9bCZg+NqQJpx7ZGD6uuqR3/vg1/5BsIldYEBSAFrErbZvvsSqbUvWEEcXmNLx4t6l2OpjOMJsEafajvGYFBj4px4FNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670427; c=relaxed/simple;
	bh=DGb0lrYZcVVTZFMTZMkNXcUfauTex2xCa+b8XToSbL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Glmw9xRYhvPTmvK15WTmu69n8myIFZb5YtE2VmRkVKoWNszbsMZK9RfWg0MgXlMysqKxSWblX6e4KMHBoA1Ute9skJ08cgl2uhcCv97QKETFKAI/b1D9SXqVLtsB2Sxwxj3+Zmx4SuQoPOPAsU9nOmTghDb2MXvijTauIXiRf6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lg09K+cZ; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb4hHpm9nCQYJsywxah8Xh59H4x5gwajd0DXcyYh3FW0IN1GYSvI4Hn6HNMl5pXiSTVR1ZongI1y8WCxW+mt/ms/V/7Fdx1WapD9V48O6Mr426lSSXdaT9qc9QjDAOVd4L27Gfm/CGI1DUufz5q9dyMW94p6FEi2NN3KkzU5bORK3lzHYNLYbMQedzUW4Siio1cPpWR9mRPsf/tQ+5wGZ3rDZo8TT5dMpNG1fNUB39zIMAHA03y1hvuD4EIpycVrtcGKrqR0Vdo/DYURm9N8ejKMdtYDfW0t7pb2Ox5riJcxqp7/l0ByUQD7gEssaApOpRCarFwnQkfBH6HA/Scsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFA846SAUZMwa8TVLi0PW98PtjFQUXTCVU4Y6Hppa/4=;
 b=vvQ2CXijMC+3LMdChQ3T1XAUCp9iVVGbJqDv+rmutd+huFJLWT+MtkD3rsg+SSkAj2gzM1hC1WOcxdnWBvT9AJV5aYtWn9DIjdpEv0yJ8mVym6ai5D3HFJ69cMxCBmd9guR7+ncYz2sMvB9ikcKm62X7W3E5cej/ThxBp6iD73jKDxwbb7dZK6yaJOjomhmPJxO083lp4PuYgLuFPHMikD+1B7O1sNixoe94e68nJWiM6iVlh2MEYgqRnAeBKAzKL1uPMLSED10frkIU3yoOJx1ZNSR6UB72r/kGNcJXkuhvOWK30dUDiIMLealmsX/C48zXd/0TfxZegy5lMwWX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFA846SAUZMwa8TVLi0PW98PtjFQUXTCVU4Y6Hppa/4=;
 b=Lg09K+cZpONr/2vtmdRxjMR3b2ghuadZtxn/SETRS5dw/hbFSjHUit5ISumT6+UK2yoi4AZflymXEuVgHY3MLu49Y+WnlKzarehLVMGnbJNn/W+v1Me0sBTnbGv2xTCzaPhdkvLCxz7W4r5dwPIuk+UH7Q6UOIFj7NQoiKUXy4rnpHWmxxm/E9txcWgwVAMmePZrSXEHUog13wnZqHjWWNKnQ2CpdKxaQZhmdBmQv+HT/5dgLLyelsA4A3kMDXsnwBmn87ZnGsXL/t6OwHG/4rIw5O/JWfcZVykKHHZe/KO6gDeJBjRC6Rcqnb9MoKZnCR1agmG44s7RU4X8Qy3mgg==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by PAXPR04MB8670.eurprd04.prod.outlook.com
 (2603:10a6:102:21d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 14:13:41 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 14:13:17 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 net 2/3] net: enetc: add graceful stop to safely
 reinitialize the TX Ring
Thread-Topic: [PATCH v5 net 2/3] net: enetc: add graceful stop to safely
 reinitialize the TX Ring
Thread-Index: AQHcss4LMEnG+MLCbUm5xkUTYhocJbWxMEkg
Date: Mon, 16 Mar 2026 14:13:17 +0000
Message-ID:
 <GV2PR04MB11740C1131EDF3BEB7DC3F5A19640A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
 <20260313094644.1132411-3-wei.fang@nxp.com>
In-Reply-To: <20260313094644.1132411-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|PAXPR04MB8670:EE_
x-ms-office365-filtering-correlation-id: 8aa56b5b-dd91-430b-cdc6-08de83662bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|921020|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 4LaK2KI8JR7V4YbqBCO09c4kmc8s9DnoNZZvdo00RI7Fl8tmduicH3c4fvXhKIImITUFmcdrtEFrpEVxeeMmLCntgw6sseuGgPUCZPNwfzDJ/q1nltTvLVGBoGArpWaulGraHqeDzeD5aM9g5lO4GxctKTje88GoUNIWTu7T4fTgwicC+PeNkvhZ4O5Wpn7LnuKZOlaxh7LsDJxYNB52Q/dBBO9hsxU5HxrvY8iq5g5YfwTBhRKjBl02HBp1wRhOL+r/FZ/HkhHGOnDrXxniYp8P2Mu79yDfVeIjwnjyq2ja472tlerntVLOeHwxgtOdXZyzR6emJeDeSfmFuJmXZXpeyR3/+t/BKpL1HMGRziKLiVY+Jb7ykHkmrvyd5DX+LzQFhLixmmaGndpINg+TtLE7IeYtKYTPlFmjYS0pAKQl+lS1lTkCAbn6g1uofUjjn1lFUM17sEuxMqooY4EArdCv8HQn7omzSxnPU2mf2s+Y8lc0f+u7j0QrqJhOy+rjgLTjwBQZ/rG5bJMgIVY3EkkkjyB+PF5VLrUiRBBp0PfIbhMI3g1msa6p/tKGma8HMbtsAzpbbG9LOB77upBcPewrc+xCOQN6DoZuPMN5OKYjObpygvea3C4cSQhBr+J+rxwo9gzAmmHwQ5UJ+wfJx+qEGcRTFGat2Czt0u1/maCp3pqzUoQIsdlWHqpfvVGqaP+zEhkg7ff8+UX/dO+VVqzNKGryyCyFPCgoEFTJu65c3goM7VamLq/RAjmQ98J6Blffv48jZjvSIffyLIg4ywfz674KLmPNujJibI6jAoJtjXDtUzyUxNHyNbpiHrUE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(921020)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tgAi+3g0YAzMkLcL0SNko4iu6GIZXmmn8ADSGtzVrldrVZbNMOUZyeUUpXVY?=
 =?us-ascii?Q?bot8cJyyVGlLw+a6I0hoOld76nwx+fYZgz5MX4WFB25sAWUkZU4mtKYZQmTl?=
 =?us-ascii?Q?oemmMUd335qAKbQ8IN2nKGERw8BkUi2vXisC2tDalGy9vvDotcFUNbb5AeOo?=
 =?us-ascii?Q?4IeoZsoIMrtROmUGQOUYND4AndiK2uVwNhXhnRrygpoY5/BxQoeHvfHrhU4z?=
 =?us-ascii?Q?jzHKH2Wyr7mAsBLQvcaYLoYFVSyuGUbP/ROArNZuwpu99OA/9XqNoDXEA6Sw?=
 =?us-ascii?Q?fQTY0XNioILs1WnA8cSGMXkWTQTr5gpVcM2185l2RuJg8cqLLwVBJaGHpO8A?=
 =?us-ascii?Q?c7gqgHrjzKNWOMVY/VTMBAL0ibvGYbiYCD3grqj0CCdju61YvznACDWIyyv2?=
 =?us-ascii?Q?bhhssQcJIK7gzJaPBEsRQ0JJd0+pZZJzeRJFYlnCneB+hM0m5ULh4oOaFXN2?=
 =?us-ascii?Q?HteswuUqxbh6A8/pRPGiMUFk3/cn5BVKHZ/I7ZG7NXhkC9U5/VFGU0wUJh/R?=
 =?us-ascii?Q?4vJrEbpmHnaUp5d20DC9eQKZMYTZb2b0QFoC7OTd17B2b7cwpcNz5jCXghjT?=
 =?us-ascii?Q?uY+83CAADjMotyPy+Woy8F16qToLsQqfhEY7Y3EVnBGfMMZryL6FthJ71A+2?=
 =?us-ascii?Q?HmAoDJEnPqsI6XSh3AXfEcxz8tPvB0aaz0xtGpRX0H94P/pzLXED2AZHUYUL?=
 =?us-ascii?Q?bUCNQ8x2SDsunfIZxyJSED+U+WahqIrTXpEuMmXS4uqczWymTtDpsAwZxk5O?=
 =?us-ascii?Q?AYIpeDQLyJPcdw/RPO95xNtyXd1aKweIt4E1killVetcljhrFq050gmw+wLK?=
 =?us-ascii?Q?axLsNO3sAykdZr900WYPEgbpeRnZWs+iXW86XYoYWAZQTf6jhWScK2bBcwsD?=
 =?us-ascii?Q?bDL4Oar7YObDlx7y8k5eZvyv6FfuHgr8S318F+hL0sJ7XHzFSQ0RE7uYPVK0?=
 =?us-ascii?Q?/RDWvMgs6cfS9Ir2wIPK/nUdq0nuFudED5tfAU2PqMj6Nxmx1qga2DMdzOlT?=
 =?us-ascii?Q?sIY/y3D/DxIAv7g7gpfaj4DwkxsuXuz9wEYlwv8SFMAVOkICxAqJSq3naxTi?=
 =?us-ascii?Q?8h08FYXt+8it13QeCN0FwO7RAc5pt7k5jrQ6RDkS9/w80wfjORgRriduItTv?=
 =?us-ascii?Q?f5Imo55XkSpT5zQ3olxxn2A3r/zuEHiIDZY1RCN/Xp2Xka5h7JbZRnE8XNj0?=
 =?us-ascii?Q?lEp2zAN7/ZkG5CIGPx4dxZYz4wxJRF85dSjIvKUHrkjZjbZSqDUflm/ygkqK?=
 =?us-ascii?Q?ajrS14fo+48G6fXVCVCSmh16z9ZrJHVUYhWoUypAr+SF1IeUxbpWfFG1Zv3P?=
 =?us-ascii?Q?wf32lBgDVoJf46RMH/K0NIHjooA0O1zHS8v2xobUyqfds+iHcDc8X5Occz6d?=
 =?us-ascii?Q?9ax+mpcc67f+i12A0W0Rwyu72uY9zyC7nL1Se0X8PkMoJ6wEUgsdR+r+rpsd?=
 =?us-ascii?Q?9iE7+B0jM4YkkNqRCoz6PWivdt/6J/DlNsimT5oVkMf5dlLqzi4WWb0i4izr?=
 =?us-ascii?Q?XS7mJujN0vGF/EStRcR+zkf7xJ/YKGsh8DyIqOmgt7cQWdmaWFkFI8cH7wHp?=
 =?us-ascii?Q?4RWiuET4n7Rto1VAWdhqhu++lOrHcnKdq7EvlZK/RyGmcHtHeeKZ6a9Gjmcf?=
 =?us-ascii?Q?Nw/SigNIGwiqJo7jQ7QQWisozR22HwV8xFZSHM/IHDxNRRmGiWhJ4MYcT2Ky?=
 =?us-ascii?Q?6ClRCEBKMDv0BlgzoHFGowvW5Kga1N7/3P/mMBSYQ8DR0lJGFZ76pcJhq4K3?=
 =?us-ascii?Q?gqZSxv3paA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa56b5b-dd91-430b-cdc6-08de83662bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 14:13:17.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6yPxJ+BgGtWXT+Si9w375VjwujvIplAYrU6K5pg21BAMYboKCA2TgfxhiC7f5kAdaYcnDZeFgVLfvWj0U8ziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268176-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.manoil@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,GV2PR04MB11740.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 21B9929B355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, March 13, 2026 11:47 AM
[...]
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux=
.dev
> Subject: [PATCH v5 net 2/3] net: enetc: add graceful stop to safely reini=
tialize
> the TX Ring
>=20
> For ENETC v4, the PIR and CIR will be reset if they are not equal when
> reinitializing the TX BD ring. However, resetting the PIR and CIR alone
> is insufficient. When a link-down event occurs while the TX BD ring is
> transmitting frames, subsequent reinitialization of the TX BD ring may
> cause it to malfunction. For example, the below steps can reproduce the
> problem.
>=20
> 1. Unplug the cable when the TX BD ring is busy transmitting frames.
> 2. Disable the network interface (ifconfig eth0 down).
> 3. Re-enable the network interface (ifconfig eth0 up).
> 4. Plug in the cable, the TX BD ring may fail to transmit packets.
>=20
> When the link-down event occurs, enetc4_pl_mac_link_down() only clears
> PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
> doesn't
> set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
> the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
> ring after a link-down event, we checked with the NETC IP team, a proper
> Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
> graceful stop to the link-down event handler enetc4_pl_mac_link_down().
>=20
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENET=
C
> PF")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
>  2 files changed, 108 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index 3ed0f7a02767..719c88ceb801 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -134,6 +134,12 @@
>=20
>  /* Port operational register */
>  #define ENETC4_POR			0x4100
> +#define  POR_TXDIS			BIT(0)
> +#define  POR_RXDIS			BIT(1)
> +
> +/* Port status register */
> +#define ENETC4_PSR			0x4104
> +#define  PSR_RX_BUSY			BIT(1)
>=20
>  /* Port traffic class a transmit maximum SDU register */
>  #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
> @@ -173,6 +179,11 @@
>  /* Port internal MDIO base address, use to access PCS */
>  #define ENETC4_PM_IMDIO_BASE		0x5030
>=20
> +/* Port MAC 0/1 Interrupt Event Register */
> +#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
> +#define  PM_IEVENT_TX_EMPTY		BIT(5)
> +#define  PM_IEVENT_RX_EMPTY		BIT(6)
> +
>  /* Port MAC 0/1 Pause Quanta Register */
>  #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 689b9f13c5eb..53cecbb23a97 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct
> enetc_pf *pf)
>  	enetc4_pf_reset_tc_msdu(&si->hw);
>  }
>=20
> -static void enetc4_enable_trx(struct enetc_pf *pf)
> -{
> -	struct enetc_hw *hw =3D &pf->si->hw;
> -
> -	/* Enable port transmit/receive */
> -	enetc_port_wr(hw, ENETC4_POR, 0);
> -}
> -
>  static void enetc4_configure_port(struct enetc_pf *pf)
>  {
>  	enetc4_configure_port_si(pf);
>  	enetc4_set_trx_frame_size(pf);
>  	enetc_set_default_rss_key(pf);
> -	enetc4_enable_trx(pf);
>  }
>=20
>  static int enetc4_init_ntmp_user(struct enetc_si *si)
> @@ -801,15 +792,105 @@ static void enetc4_set_tx_pause(struct enetc_pf
> *pf, int num_rxbdr, bool tx_paus
>  	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
>  }
>=20
> -static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
> +static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
> +{
> +	u32 val;
> +
> +	if (read_poll_timeout(enetc_port_rd, val,
> +			      val & PM_IEVENT_TX_EMPTY,
> +			      100, 10000, false, &si->hw,
> +			      ENETC4_PM_IEVENT(mac)))
> +		dev_warn(&si->pdev->dev,
> +			 "MAC %d TX is not empty\n", mac);
> +}
> +
> +static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
> +{
> +	struct enetc_hw *hw =3D &pf->si->hw;
> +	struct enetc_si *si =3D pf->si;
> +	u32 val;
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val |=3D POR_TXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
> +
> +	enetc4_mac_wait_tx_empty(si, 0);
> +	if (si->hw_features & ENETC_SI_F_QBU)
> +		enetc4_mac_wait_tx_empty(si, 1);
> +
> +	val =3D enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
> +	val &=3D ~PM_CMD_CFG_TX_EN;
> +	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
> +}
> +
> +static void enetc4_mac_tx_enable(struct enetc_pf *pf)
>  {
> +	struct enetc_hw *hw =3D &pf->si->hw;
>  	struct enetc_si *si =3D pf->si;
>  	u32 val;
>=20
>  	val =3D enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
> -	val &=3D ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
> -	val |=3D en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
> +	val |=3D PM_CMD_CFG_TX_EN;
> +	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val &=3D ~POR_TXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);

Nice, taking care that the MAC->Port enabling order on Tx is opposite to th=
e order
on Rx (Port->MAC).

> +}
> +
> +static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
> +{
> +	u32 val;
> +
> +	if (read_poll_timeout(enetc_port_rd, val,
> +			      val & PM_IEVENT_RX_EMPTY,
> +			      100, 10000, false, &si->hw,
> +			      ENETC4_PM_IEVENT(mac)))
> +		dev_warn(&si->pdev->dev,
> +			 "MAC %d RX is not empty\n", mac);
> +}
> +
> +static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
> +{
> +	struct enetc_hw *hw =3D &pf->si->hw;
> +	struct enetc_si *si =3D pf->si;
> +	u32 val;
> +
> +	if (si->hw_features & ENETC_SI_F_QBU) {
> +		val =3D enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
> +		val &=3D ~PM_CMD_CFG_RX_EN;
> +		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
> +		enetc4_mac_wait_rx_empty(si, 1);
> +	}
> +
> +	val =3D enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
> +	val &=3D ~PM_CMD_CFG_RX_EN;
> +	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
> +	enetc4_mac_wait_rx_empty(si, 0);
> +
> +	if (read_poll_timeout(enetc_port_rd, val,
> +			      !(val & PSR_RX_BUSY),
> +			      100, 10000, false, hw,
> +			      ENETC4_PSR))
> +		dev_warn(&si->pdev->dev, "Port RX busy\n");
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val |=3D POR_RXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
> +}
> +
> +static void enetc4_mac_rx_enable(struct enetc_pf *pf)
> +{
> +	struct enetc_hw *hw =3D &pf->si->hw;
> +	struct enetc_si *si =3D pf->si;
> +	u32 val;
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val &=3D ~POR_RXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
>=20
> +	val =3D enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
> +	val |=3D PM_CMD_CFG_RX_EN;
>  	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
>  }
>=20
> @@ -853,7 +934,8 @@ static void enetc4_pl_mac_link_up(struct
> phylink_config *config,
>  	enetc4_set_hd_flow_control(pf, hd_fc);
>  	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
>  	enetc4_set_rx_pause(pf, rx_pause);
> -	enetc4_enable_mac(pf, true);
> +	enetc4_mac_tx_enable(pf);
> +	enetc4_mac_rx_enable(pf);
>  }
>=20

Nothing for me to object on so far in this patch.

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

