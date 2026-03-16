Return-Path: <netdev+bounces-268174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPrVLfsPuGmIYgEAu9opvQ
	(envelope-from <netdev+bounces-268174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:13:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A40329B205
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E7D3001BF8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5D39B976;
	Mon, 16 Mar 2026 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jQMhoE5R"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3E280A5B;
	Mon, 16 Mar 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670381; cv=fail; b=gRSxqGtKl/KVWQ7no4n8e67dbEgV6VqaPUMQWJEZ2w23VSiD0dPDTM7zj+YceGzY3qKuUevRw5yBBUOF6mru2mVYMb8xYLYBWKR76Dw59/SpJRRWoyaA/0T+EKgzM9HVuAFe2alLmqgf1yJgPqlrvdd9e3d9Xwm0F4MT2f2SMUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670381; c=relaxed/simple;
	bh=lnmEJaNTA8HhDrItQ06pSL9F9KAuBpAV61XIIuUeUjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LzCKSNv1HecLjdsith6WHKelC2Oci796pSjXODBiQ7OdUTSfDVcswhs14mhw1fSrNdgQcZqFJ2We5KelZ3v6nVi1EoIHKJvN92tFasevymreDMBU8KZTOUy/f7zGf0elXY7tFl+rHFx1MyMx8gWQJakLo1dYrXjZPlp1qeIVzDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jQMhoE5R; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyYwJEGHdecdMOisNgM3AbWMeR24LPtC1GPsa9ssxxqhM1fsyRCKJhkJADbgggxW8ZYanTQvsXB30ZKOvSdGbV5KW57qAPp+rmn5yn4yOcN57XvdnGyljqT4UuRTRKy9O1hsZY5TnbJtjdq0Nu+T793njrv73pGt3oopq/mQLhwVfbG4ir07qLTMGuE8sPumnyODc3v8aFjT3pxnGUqmLZxicqBw97dKUJAXEyB+GHBeq52DDbtlPYWSkhemUdDC2MFPe0dJhsm6fe7vtAbdeqZAqN2TfRKy5m9NZKZfOSatYeo00wG9jSeqJH4ijmz1Z/iLu7npebYrPv6MTSdVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnmEJaNTA8HhDrItQ06pSL9F9KAuBpAV61XIIuUeUjQ=;
 b=X6lM/lXIi8BSQn6+tG2qoGg+8jAPHyfBofaraPABuisDFNjT5/wrznD/ESQ96yiDNpGWw8UAKFFOWDoi2sT6UJEpQzyW8u+yQLpr9zmADYGXqXeZOLW4yx33UQkC78NNFSlXpLxnEFDZhDo8tv1qtBKskSVnu/O2N6+4a9B04w+ULxg1o4fI8XwrJi1KQUA2T2L5qNFr/mjpLD+N2y9ANzrBf/8b5dlbS3zF22voQWPcaMPeMcdM/rPUdB+gSP8HdKAH7EuhjCogCCHr1k7QnjPbDLR+iA4/JQx5SzhCG39OQIViypJRlsu42oCnJ/0ndV3qFqFqPrtd6KXembPadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnmEJaNTA8HhDrItQ06pSL9F9KAuBpAV61XIIuUeUjQ=;
 b=jQMhoE5Rh48eN63vo9eHm7hRzbZm5Esj8W0LGK+0KrklToBM0Ut2yPaO65Vh+Z4YfVeRS59QWV4Ued6kT2+dIVVnt1N93xkQpfhw1oq0NTpNWQkewzKWB0IG+ti5bLqTlcXwf04C3zQ+HC82huxZTPrMhp4HEAddQRfSUsz/gOpyqhdccUIo3m4MdjuabcLNdkRfuDGvYxbCtKeb5xU447q/wdZezai5J71j8MtrsSeg1exe3vE/ebal885q13vhu1j0ZzhU9AIRU7BzHo071wtG/RB5rNLbI5Ros4phqMCNFiD6voiwJpgf97GzHjf+8kWOnNf8n/1YzB1f9xXmmQ==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by PAXPR04MB8670.eurprd04.prod.outlook.com
 (2603:10a6:102:21d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 14:12:55 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 14:12:31 +0000
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
Subject: RE: [PATCH v5 net 1/3] net: enetc: reset PIR and CIR if they are not
 equal when initializing TX ring
Thread-Topic: [PATCH v5 net 1/3] net: enetc: reset PIR and CIR if they are not
 equal when initializing TX ring
Thread-Index: AQHcss4IP29WaTU2QkqHZ0UO741VlbWxLk+A
Date: Mon, 16 Mar 2026 14:12:30 +0000
Message-ID:
 <GV2PR04MB117404818E6A14DF662AA1CF89640A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
 <20260313094644.1132411-2-wei.fang@nxp.com>
In-Reply-To: <20260313094644.1132411-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|PAXPR04MB8670:EE_
x-ms-office365-filtering-correlation-id: c376138c-d4cd-4168-4323-08de83660fdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|921020|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 TV4jNN29CVBODrUoPaYOaYmfDPnLZP3tsQTjXSzFjLljxaxe7LEUug8rJkXwSDjze7d49dlK+k1oypnD/dbNW7G4Pd2g4jdDVd77zpD/7VSurYTQgFCdIWXZtpBCJxwhEozuk+TtChK+qxWtDoy90EvYO/De67KS9pgIqdHt6DMK8n8tIto1UnVOD+FNBMvtL/S+6dJthE0mPMsaFpkOdP3j3mIuHUoTsX6YNJr1Y8r1ZoewewDJYZMAET1VInrXM+W/b2ISTf1eSrn+LRMHNyzGJOxIdhNAHw9JcR6nZA+Kta6KYBStbhvB+K4ZQsIuX+/ICCBLArcrfMnXVi4fyrVHEicj3SFw4t44BcrOzmCiYER++SzaLdR2LB/jJnYE4lS7Y6+nhTYzVyuUv2XHkdsdbm1SicPlSvEb3+5rgCxR0znGTGoOTLQ5/UZRwBIJm7bmZskPrtDBFrQiKiepsAmgXix2NCIiUrYGM8IPSqdw97wxUrBvZTYzrD7xu5grL3y7PuRwF6WlB/M/FGQaAYQSz5n5QJm51HAQoCSHIscDfJlbM96xUO/d6bRefC/ku2QXHTYgFel84M66SXFPPlRenWRBpF4FFanOow9oB5b6NqDR2gCeP8tzrcXOFbrh2xspJnMDpGMCz0mABMoCCxK+3kwT87dRIW/XITfEoQjGUyhko81FKJ1bUA+uS/WY8kv9XXStMh07JssUSiwKGc4/633afro3tnMVCzBs2RMPVaXWvZ3pE2l8LfYMCjnwpsW2zLNciQm3aQX2zlNNZW29Uh0rfsOXxvVVQGHTy7ZecMj8s+Qc7B6XTC4cqQcj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(921020)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RHmpvSBexsiz5jT6iyCLXm2OggeoeJz3XHR75tsDRmNIOD7b2yfBfBPOxteB?=
 =?us-ascii?Q?u42Bks1CdZ3rDhNtYPmRu5TuRT6ItLTZEOkJcAfNWDrH3uQpdn1nxQfS0c/j?=
 =?us-ascii?Q?byAohS2Cyg8wvFZH3Rcb5HmmHwqPWKKFKDIAazSgpi7g7jyc7nwpmeK042Wm?=
 =?us-ascii?Q?BAAyfqj0ArzvMqIKxZ+z533JRxP8QWCJ3GuvNvPfmE4ZP2KYP+4el+g21xOd?=
 =?us-ascii?Q?u2jfxlOtR8f4/q/Zns81I9OSO9K8UXiQByiB4XYhWQ2AryiIrUmphDrPGYZa?=
 =?us-ascii?Q?Lm/d+lCb1q/kqQBE3S5ipdJJwBL7xlfbQcQ6s7u14yPqXUGZwg378gKS6Pdc?=
 =?us-ascii?Q?W2SC8IA/tE6HQvjQnfKzeuKTri/CMcFaTLB21AkRKaPvIffABFMIDR2KAX4/?=
 =?us-ascii?Q?Bc30TvWkrKaOiXGstcqixcTbVduj5oc2Re1BeWz+ZilopFoIh+9dqYL+Elzf?=
 =?us-ascii?Q?cFMa1PYGEfdjQutv1RLg9HlwEQrhH6gshRxsYBD0NXGCP3ctNouu9H8rPoZu?=
 =?us-ascii?Q?2n07aVTRyqCSCuiOHaXlguR8Hge2JatOW22gKSssiwFeOwXJx1+/A9B33lYD?=
 =?us-ascii?Q?LZhvlCVBHhssWXV2GD1RfidQ2k2GHoqm/OST2o21dt65qsgBCHup4IUXn/JU?=
 =?us-ascii?Q?K4VtgMyltkpxCmvr7pfudsyG1A5WTR3m2PJZGpa3K6SFr6oyo6hPrjVcR0nE?=
 =?us-ascii?Q?QIq4wUVnkTbsi8UyGCdW6lSs9krw2zY24dGlLweKboX2MOqt7GW3UYvXdbRj?=
 =?us-ascii?Q?05HJQRCzk9PZGI7rNpOLDkYY8N269dZDwBIhcALmtivAHhxcX1tdE9FckAfs?=
 =?us-ascii?Q?T4G4TureP15ldSSb5zgqkl1KvhF/CbZ7CpJxfC90yN/DGZWydSBzIMN+U3Yo?=
 =?us-ascii?Q?WHWooIzMn4yuUdrx0JFsoVZCZdELO71sbtOQRAKIorMUzya4uylHbOo8pbhF?=
 =?us-ascii?Q?+FJ8I7d9eysQkDjHP5/aBZTEz2jDHfFS6JlHNyzKH1QXbUawMlXkAZffF2/O?=
 =?us-ascii?Q?ZieWgFqVRfcNn1RYOJD4bWaeApUQef/A01mWOwN2VnRdqOOFlOdxofQ7ySgJ?=
 =?us-ascii?Q?DReZ1uOAp0E401cGTWtx/yFF7OpN7M84uBFCXCrG2qT+TYLerYNaB1QZmUE3?=
 =?us-ascii?Q?1/6RCmVc4JKwBPul5O7yjUaNw/N3zF+h4V1DyQOL/HZfju3+aadSu5xDr7QN?=
 =?us-ascii?Q?sv62RxYTQEVDjxUB0kJ/MZS3+kA6kZdTB/7/j88DTZenjZEUtR384YasQEA8?=
 =?us-ascii?Q?whMky41hidn0KwYozd6QTbNedeLlWf4cm3XSe2bE+bLtkdgomfW3gHuxFU2y?=
 =?us-ascii?Q?5LPRI2VOYQTA0atqBv0Z9snJEH8fhCHQa1KOLvd9LWZMAMOdX1G4Cqxl0+8j?=
 =?us-ascii?Q?CWbWTm+s+v+U3Y4AN/IgBQXKku/bzv0aQ+gQyLS9fU6n2vVrd7m0KVnE0RbH?=
 =?us-ascii?Q?xySc8NHMTWoJLIPWX6BZfjJfA5lKjNLYjFZNUJlP0aRUUzzlFg/EUJA27dE8?=
 =?us-ascii?Q?5wCeq9S25aj0QZ8a3JN19CmGFYUv8BTL1mWdu2o1NGvVNIwhzkILaFoqVJq6?=
 =?us-ascii?Q?cYoD3OapqvE6pBpNsWoKsO44q5y8uzu2zIGlauOIlPqcO1/oQIj3CmLzTHd5?=
 =?us-ascii?Q?PMS5FmMAy9dBtOkPR+Li79CQB27SNaS7ZJoAlct0UU2LVS0rbBuMszICSvMw?=
 =?us-ascii?Q?EPiF5Tfz8wgi7DN4nQWEVMCr3CLpdDOi79FdB64iXRFOdMzOBEAYZc09LiyH?=
 =?us-ascii?Q?pbXFR4ltzw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c376138c-d4cd-4168-4323-08de83660fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 14:12:30.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dpb8n3CV8XlBQ2MSEB/kvxaAxeiK3Z6yvJYtAKwv+/w0Jpxoxi8BQ8CxWaCKQ1VWg20pM5GGNN/JJsN44fawMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268174-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 1A40329B205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, March 13, 2026 11:47 AM
[...]
> Subject: [PATCH v5 net 1/3] net: enetc: reset PIR and CIR if they are not=
 equal
> when initializing TX ring
>=20
> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work properly.
>=20
> For ENETC v4, it supports software to set the PIR and CIR, so the driver
> can reset these two registers if they are not equal when reinitializing
> the TX BD ring. Therefore, add this solution for ENETC v4. Note that this
> patch does not work for ENETC v1 because it does not support software to
> set the PIR and CIR.
>=20
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENET=
C
> PF")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

