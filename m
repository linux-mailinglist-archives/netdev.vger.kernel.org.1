Return-Path: <netdev+bounces-304323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CV9TEiEpR2prTwAAu9opvQ
	(envelope-from <netdev+bounces-304323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 05:14:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E066FE221
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 05:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=gZCNRmKY;
	dmarc=pass (policy=none) header.from=nxp.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304323-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304323-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7C0331A93D8
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487C2F3C3D;
	Fri,  3 Jul 2026 03:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BE2F25F0;
	Fri,  3 Jul 2026 03:03:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047797; cv=fail; b=iXgM7lDuKHsxc2usHxeAySXxXD7WgzK5uIzXSv+XG2HO0x96jgUTNyLtGBbZsmrTflWo0GRGkg3uIOn3+Mz2mmrejcv/gEBs5PbDgvla+NGx6BiPD+FB3LQ1ROppQDXFKRaUDXgC6CMd8pANMjwbkpEEOkyaH6Lz5G9qXiDdMLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047797; c=relaxed/simple;
	bh=uH0YhEH5TPYpbuMlMwgKQRQrvzDxSPI0EDNrjI5L1No=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGcDIiiNGQh7uIC5O5R8eBKm7kewUZYJXAsSCQ+BuH9J3gHRx5LhNPOWiWYUGOwYzgtj2O1ZOMlS80269J9MgC3NX8ngVYkZynxnRl22AiaklqLvjmg/fKZaCNHZV1r7kZWe3BlTScA5zvYyvAqGOM9Dy5Pd7fQrZH3DTN85YDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gZCNRmKY; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjcz+jdwGOM5nglXv/X7QEDUmdoXai3L9MVqRYPUcEAGKS4JNF4HAJWp9Z23rnFAlLadN/GfroPuoHjz4vQdmuTqQzumnieHofez76dIiynZefp32IroECaOWKxQNa8OQaQSw3zgxZ7sXDOQ5rzkhkOytVX6++eGXuI2hUQOkyrnnWs11n1C/juEYTNPgXGjFx9JkEYwk7I2V0gHuloh+d7qHnRhChMWqxtxzHdvayyZWLC3kOJ1BZTQ9MCehWynf+MiI7989qrD4BZ0IRMG45mtISUA43Gui0KKTcGzsSYl6K/YTkgyi9l6E0aYTp4eHIDcSpPjRakLGkpASgLPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ6DIqeoaRU7Hxv9fhJp4sR24eQofwp34G+2ExJx/qk=;
 b=aP9FClduVXYTuQM2YWDU+9Pe3Ft4oXZPBIVUB/UJn/4kJoPlV7z9Xe8FC9nq64WLxjfnK+w/X7SGUf4M+Ip7nmsomqHi6Ptlx+2fMy8DqTZiLmVAc8sk9vng+SqDBV8Aa1e+aAVuC//annYzJDyxhdlnkljCCi/65YsiqeJW5xRTXRcVjUjMNNkjSUANZ349md1FpB08JsxfYWbNn9S6V/wMWRtfh8z1gxy54FK8rH2G6lUY2wbbXcezk6dKR/WkBx8grvywcKshL/zFs9zcOSVr3jzmpL2EcaWEWO44KReY0jY2SwbGQM9f7qc2YTdWhsirWMWnlE4F7PmqzWRaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ6DIqeoaRU7Hxv9fhJp4sR24eQofwp34G+2ExJx/qk=;
 b=gZCNRmKYbXrvGNqWBCcn50ReQ79Z5nep0vavFNALz9cYogWCSG0LgMZp11AqXWCSJPMgHdWN2gP/JIMBz4WrwhEGCUu/SYqjtyIbkAIH3tMopHKf0/GRmZ0cCE3x+qFMFOrNCLb5P+aVYi3mmUESopXM5ML4p0rc7r+n4HjIWBeo5Sf9GpxPp/ZVhVnqN2mKXs94sA4Wk7yT/q8jhIwEfEnn3ixb9ZtDvRTyEWhDWxV+1rFaYuIXXgbRAR60YVhb6fW1sC5oW7lV7i0LNKBg2JmE3Igh0RBOOfqqLFsfHZCzAV3eqOEXcJbAqvaLMR2mEaH7UAnSjVvuts1YEqrOLw==
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 (2603:10a6:150:336::11) by PAXPR04MB8206.eurprd04.prod.outlook.com
 (2603:10a6:102:1cb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 03:03:10 +0000
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494]) by GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494%4]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 03:03:10 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Breno Leitao <leitao@debian.org>
CC: "Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>, "Frank.Sae@motor-comm.com"
	<Frank.Sae@motor-comm.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Topic: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Index: AQHdCS9Kh6EXypCdTUSz62mUjSw8ybZYUCuAgAAAPRCAAGorgIACXYLA
Date: Fri, 3 Jul 2026 03:03:10 +0000
Message-ID:
 <GV2PR04MB12213049BA728917B95133052F3F42@GV2PR04MB12213.eurprd04.prod.outlook.com>
References: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
 <akTLmyF0r70Jyn9m@gmail.com>
 <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
 <677882ca-16cb-4fd7-86d9-b00d62147bf9@lunn.ch>
In-Reply-To: <677882ca-16cb-4fd7-86d9-b00d62147bf9@lunn.ch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12213:EE_|PAXPR04MB8206:EE_
x-ms-office365-filtering-correlation-id: d3e16a68-71b7-46b7-d38f-08ded8af9d4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|19092799006|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 P77Zg2L0gegkyT+Och/rqt74myf9ITlcDcJH6vFyPulmxbJKPB9Bpb+f/qz9sHUddJUONAE5lrcU5W6rGBeZWJL3RxDtIX/ZikogOojUuGGgmlXI2e1dqyBdBIVS8fLtTsjkyuilyyc4EmX2OjxedGgNIhqUZOmT5hV/b/4ZJD66jbyaIQvFXp3u+BnXFr62bccFbdxiCxQTE/t0kMP01IhfsU/FSGGii3N8qO38RxCPzenjQLuOKGzBS8cbFm68ID4h1Z752diWZ0EEPELgo/PnCwjU14GI/54PqN21ggPqbgQx+Wo8NiEqz/FDnJS8ICNSTaxy7IV7/LkYxoMFYS9rDe2Ge5p0oOcFL9KqjaaqdaNILV+6Vti3M9eLXJ/BK1AhvEEiv0EqEmUE+B7W28wt9zaxedPmylt5UeXRN1LCgJJZARK8H5aVTAiDoKHTyyi+zXkF7wS9UjKDhtEncZXpFNzV6Fn+xZO1gt7tQR8roauVBdvDGo3fhU+rAtie63atJwe/RqzX2v96VBcbAWRGA/YRP1qrjMiUPelJoQ7ned2zilHG5fycgXeUBUrB8E93NMxHP/C6k6+k/y1OWX8K0Gb5nMlFR1e7JX8RM324G/2S0CQuggHZhVOG8EPvDCYGx6b9HTHldUW7mBlRmEraqkzruQ2Xwm+zKj5VYDU4+ztHmQ7hNx9GP1EVvlN7JD152SmfIJSU4Iq/QCJBs435x2JUDUqE+3xWt7fx2dY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(19092799006)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vXtVRPxXrId+Lf70VKagTRduXeZsDeP0Oilt2zLf4o92NawK9NaS6MiZbjtA?=
 =?us-ascii?Q?D7RcRAOSRZ8R+OztotW/0i9XnZvwFANmq5c/F37JQ0XpuI/UzvxNCuqwBq0/?=
 =?us-ascii?Q?UurQowkt07brbo4sCnGILTPoTOTUHC4sby1e1avkbyBS0a4npNvyDx3JxUQp?=
 =?us-ascii?Q?7KsanTsaOKqCwL7UJfHVoLuO+zLyUEjslDeMF9juXkHfkHc7W4WDPiJjd7Md?=
 =?us-ascii?Q?5PDGRZAunwEHoWz29CsDXXuwt9qvjQT3RM1Z1SnBNbJESnG2A8nosWMieVzT?=
 =?us-ascii?Q?lHriUlI+8N+0QpZrzPChXMTOEBt7ZAPbu94cegRVoilpAMcMDP0wg8zoDMQX?=
 =?us-ascii?Q?RSpdXxOZIN4LMaa/QVS2YenXj03sA2cUG8j62foKgAiBIbxNXbVgpS7uWfy7?=
 =?us-ascii?Q?9f+WdvjqO1eVnkTGGOqcgBg1/FsrlngVQLK1ocDqXipDe2LdOhfWG0Yi3sxr?=
 =?us-ascii?Q?Y+gwGGUDkiE/dhJiqxPbqNNQa446mO3h/rvpBKZkherRHH3icn12LHa5m0ro?=
 =?us-ascii?Q?l8z7Fg6Ts2NgVwznvGIwaTrr1qRZSRSQYtFVM+gDy+qk9DhLokEF6GclMdGQ?=
 =?us-ascii?Q?xTMAY7GEke1vswShGxT64bReWZG68CNHTDAaAsnBftSCzWGq1dHeequqcPTq?=
 =?us-ascii?Q?0k56oPhC6kMVJ+0li+GAT/hwDwBmMk6/SOD4CDUcR3wCnr9/YRaa9So2NuZj?=
 =?us-ascii?Q?Gx93I6utaD1hpOXBtdj/umDgPan9AD1qBAmZAFDmDmidTXcl+4ygyNIhyFn4?=
 =?us-ascii?Q?6vYfPz43UwXTDFv+fCbEzhjWHtWXdDZOTpuNiOOuqOKQ4clzn0lPC3J/X7/9?=
 =?us-ascii?Q?89/xy+nrBk3KbxqxIUPpliSiO7TUtmFkPlSp6He/5ZhT8iaL15IF+slS+yno?=
 =?us-ascii?Q?Zo90kS0F4goT3E/4CfiiTFZOWR/KiL1BK+bQ6uGHNV5gj6dUBCckXWzqTAHq?=
 =?us-ascii?Q?x8Fj83Nb060emdfve0B9CYBtRyUsNd2Fctpa7IBVWoymGV0lMMOAbqx+6Zwq?=
 =?us-ascii?Q?QLK+ckHL2faX9Zs/kXv/zexHY0rq/3ets+TbTtHefwWiZPBFrZ8+Aoqf4JoE?=
 =?us-ascii?Q?LStD52hc9tdS1Z1VUO39ciKD8i34fFd9079kG/gE8oD6i8QsPbLQg1Hfz2jU?=
 =?us-ascii?Q?/Nu77AsaUQdRvMIbOfTwEEOnf8O7MZHu7kDUzsYZJQmW9SaTp4oqrSVbNPl1?=
 =?us-ascii?Q?V3QbTvCI4+V+FORnbB8dDRWf9/StaMuaC8O0A702x8lvcaVzewAbeh5nbaCU?=
 =?us-ascii?Q?FUsdU4afWUkpwHlCbm/+uXmyq+Hya0pssUpAOyQJLoP72OVFXfhtNPN9+CAL?=
 =?us-ascii?Q?XgazEgbRDKonKLovCr1xHd5NLA5BMvZm1wfQuznAgYkHcE6g49y2EqyoBVPi?=
 =?us-ascii?Q?o+r0jxZn6Ad0gBHx6rIej7FPeLGyZf38PBDpSVa0FOLUqS7GqEyW3NunQ5P8?=
 =?us-ascii?Q?rm/ragaiPowrwu1ft7+ovbI04t6r/v66Ym1qMvXbT4xSh9qW2g7EiZnuHAEc?=
 =?us-ascii?Q?p/5r+xM3KCmBWOqKp6fTYQlCDTVsYH2VakNdaLDrC4vl1zNUB+95VHQ7aeqI?=
 =?us-ascii?Q?0B527tpwuSxyqrgBZo2bBc+vy+c5ee0/Nu4kL4vsA1B/Tcl67dK0nh5TRe/S?=
 =?us-ascii?Q?x7M9mbDDE5v1+jTPAMs+kovCWtM70jFth0iXeihG2o0GGt82heZjJyLWe6T5?=
 =?us-ascii?Q?Ea6gRnts3LXdyo1UcQBdpmgzNIcOMBimtW/IxkcfU9R37cgrxSISWzLbNSfz?=
 =?us-ascii?Q?Q9M9uWSP7g=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e16a68-71b7-46b7-d38f-08ded8af9d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 03:03:10.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhVc3PZ/elOWEo0kGfQTdNH+Aa/b00TDPhNO0TtkgNCsFG3S7rTe1dpMBVTh7/zBTlP7/nc8pOls9LqIppfD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304323-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:leitao@debian.org,m:xiaoning.wang@oss.nxp.com,m:Frank.Sae@motor-comm.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[oss.nxp.com,motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:from_mime,nxp.com:email,nxp.com:dkim,GV2PR04MB12213.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90E066FE221

> > > > In phy_probe(), genphy_c45_read_eee_abilities() is only called
> > > > when a driver uses phydrv->features. Drivers that implement
> > > > .get_features are responsible for reading the EEE abilities themsel=
ves.
> > > >
> > > > yt8521_get_features() does not do this, so phydev->supported_eee
> > > > stays empty for YT8521/YT8531S and "ethtool --show-eee" reports
> "EEE status:
> > > > not supported", even though the PHY has the standard EEE
> > > > capability registers.
> > > >
> > > > Call genphy_c45_read_eee_abilities() at the end of
> > > > yt8521_get_features() to populate supported_eee.
> > > >
> > > > Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521
> > > > gigabit ethernet phy")
> > > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > > ---
> > > >  drivers/net/phy/motorcomm.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/phy/motorcomm.c
> > > b/drivers/net/phy/motorcomm.c
> > > > index b49897500a59..46efa3406841 100644
> > > > --- a/drivers/net/phy/motorcomm.c
> > > > +++ b/drivers/net/phy/motorcomm.c
> > > > @@ -2439,6 +2439,9 @@ static int yt8521_get_features(struct
> > > > phy_device
> > > *phydev)
> > > >  		/* add fiber's features to phydev->supported */
> > > >  		yt8521_prepare_fiber_features(phydev, phydev->supported);
> > > >  	}
> > > > +
> > > > +	genphy_c45_read_eee_abilities(phydev);
> > >
> > > Don't you want to return error if genphy_c45_read_eee_abilities() fai=
ls?
> >
> > EEE is an optional functionality, and the call in genphy_read_abilities=
() has
> the following comment. Therefore, I do not return its error here either.
> > "
> > 	/* This is optional functionality. If not supported, we may get an err=
or
> > 	 * which should be ignored.
> > 	 */
> > "
>=20
> This conversation then raises the question, should this be a void functio=
n?
>=20

Hi Andrew and Breno,

On second thought, I think it should stay int. The "ignore errors" rational=
e
in phy_device.c applies to the generic path where the PHY may not have EEE
registers at all. But if this function is called within a specific PHY driv=
er which
we have already confirmed its support for EEE, need to handle the potential
MDIO bus errors.

If there's no problem. I'll send a v2 that changes the call to:

	return ret ? : genphy_c45_read_eee_abilities(phydev);

Thanks!
Clark

