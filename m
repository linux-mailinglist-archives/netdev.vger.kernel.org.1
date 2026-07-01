Return-Path: <netdev+bounces-303473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QpF3AaOpRGqBygoAu9opvQ
	(envelope-from <netdev+bounces-303473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398826E9E96
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=Iclxm5mY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303473-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 244503017BD9
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21B376A19;
	Wed,  1 Jul 2026 05:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C31A9F97;
	Wed,  1 Jul 2026 05:46:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884767; cv=fail; b=YpO5R0oHxP9vlbqp1eLgWqmix0QuAduxy2TmIqwm5TwU0PVeeOtRknSFgHDYuUcHG7jpPZUwlZZF9Se7YYKZh6zkRXyOYOxA+HTL1e27BdNgf5HQaqB/+I4GxlCOmmo5GqIxWVR3JgxQwdHdZgFFKif5CEk/Nr9RwNQxZ8q+PEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884767; c=relaxed/simple;
	bh=j4nUejUrUZKqWQ/WxKEpRn+UfVOtLWHXNL5FZmlD9PY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fk+AfohV5bN7NHck5GxHI/Oxixd/3QR0ng2lrqGiA8MGZN6ZtOAS5oNbym38oZmy92qkgajxTs3BBWa16x7bRX+lsvo9LreEi+anVD5sw5GdZ53OOsDfNritNaYEEpZK+LZ5Di77ahq35hbDXRg7KQEVOjHb5/u0AxkaUDsgiUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Iclxm5mY; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt4Pij5fIrfVydZ8dXtz+4omotCeHLUHQue4o9azMxtUohkMO9rE8zbYM3yBUGsy76/U4e+IZmNdiAnO39mZ3YFS5mZUts5KfqNGdLBDcSR5aON0viYpSuCB9LkqCmZ7nR4EHXTasjj7thSyiZ0RcM3EhOVxbXfshwC6xJcydt8sJVSs15ghdTM4oNxLoL43sFMIJR0QFfHG4Z1nMpZIYssiqHbBfAf1HpFY366ycC9Bo9lVaM8WEMRISGER4H4kA6h9ymU8hQqR2TL6hbvq1p6gkHkxTGjBlU51rSgoZlIcOPP2X1Fnj1vSnmiduuWQO6+RGhA4oBJ+Qm16fRPEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoJzqE/keSn+bUia2BnHnCa0up2FHg9AvXApLYorgLA=;
 b=kPFnuNE4SyvrSud3o3gDfUknMd43r9u9iE3/Ky/E2BPyMIFJcgVWk2ochaG6EWTtW6j4PiAkO35AL9gngnh/ohwil/L2ArgNoX/Yt2AREmHE4rX8pNxR9EScnjAZxBiDjQBMm7YtkEiuvwswcj4JV+M+TggNAEU71dOcB4H7ZGnHFRpH91cyCirGgwXyBkJ3N14vzpkx7jUXFSJE5sZ5xgv+AU+L3hIxAsJAFXbPYYNaugs9LgSEjiAfQNx78VYnI9ew3loa1rK/coX9u/8IeO88An/iabyB6Ew7/3hbMmdPolVeFj9CemuazX3yhZV39/gsRlFGtIbPsQVEwobrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoJzqE/keSn+bUia2BnHnCa0up2FHg9AvXApLYorgLA=;
 b=Iclxm5mYXUW5j0adkIU/AFNGDMcYHzHIA7zV7fXfd6ybve5Q04jB11J9+BCCoxTFqdwobsXOnJB/m6bIg04g6twjZSKpoYdfOuICmnCzjSegyp9PAPsWVLnDt5YJ61KZSdRVCUkmOepUbAJhuNpG2ING6Z2QDvdo5XimNYpPbcQXJsttDeeJip9mpnXi2odnmZ6/TxaBMTWb45VyFLORHmnU0OkFYrGdWt0sfr/OcBnTc722E/Xns4hmjZiB06XRnH6v16Rnd9/RCVIKOpVZ8GNqsxb75c8DBCIf+fiLkelg9s0YlFyGZH6EvduYI9J5B/2PPt1K6fbk/Sijc+0zSA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU0PR07MB9196.eurprd07.prod.outlook.com (2603:10a6:10:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 05:46:01 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%7]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 05:46:01 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "memxor@gmail.com" <memxor@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuniyu@google.com"
	<kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Thread-Topic: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Thread-Index: AQHdCIg87j/hTMue6UG+Foq9E1ysYrZXvRwAgABpS5A=
Date: Wed, 1 Jul 2026 05:46:01 +0000
Message-ID:
 <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
 <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
In-Reply-To: <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU0PR07MB9196:EE_
x-ms-office365-filtering-correlation-id: c01a876b-aab8-4321-cdab-08ded73408a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|11063799006|4143699003|22082099003|18002099003|56012099006|3023799007|921020|38070700021;
x-microsoft-antispam-message-info:
 87OHgRmW+gvcXlb81VPFKN/V5uhAre7pC/w1vAn2DvgWsMUa/IZ7VLMGsw0UnzNujHMOhoNsiDObttgKKqnvT6taX7AFRKLmG/fJreD4YMaafcYZC2eQUYXxj/WCwnsQiL36TnXCcY/yYU3wtv2ing8slbH5lioRqYfpgCJrr0/nGgDF2H70Q8a/8HKcV1pimvkRqtZNmuTXMOpAv5x87JihMV/XYhjFADDPUwDIGAM3RU1Cg9T1FC8eRhj+DyoJCusNHe1R0C5z64kGdvRPsQojcNbs2nbrQpVAflNFSUz3iYAe3EdS6UWxtE0H7xWms95AXrtZgFTWHF2g0y/OV997gAIjPJnsJKvKhAIFiV7BFyJs2REc9FnG9YGfJuMgs0TqcQGnDlbcgJeW2Q0xkgUu9DI3yhHFNe0WNUIKDQdfR3/lETSW/0FMK5PigRpICNYWGxFOqn1uLkcKX4cWzG2PgwUUlfXH+CwDs8pz04oHUfGReeFgSRY5IOFGppQfHWPxImBriqJFTi2RM0SjOfQTeZlhydPqO4236AZha3Q3Ym1yB20VvPdSWse1TZPjO7qeXdyGHp4L8apAThUGLDOFQf+ed/97sM09g8xhS/+ubafI3VmZ8kxLflI3FBA7twp2n1dCNFCLYl93PUyxSDZstolzIbSsl44lrys8ADLrCZJIDtHQYs5qQxqhYyqvG8npMdgqd7LEZcKCsq0pDM/4wPuguuvEuLcCBeNt+1FgL+qBrbPH4smWZs+sLz5i
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006)(3023799007)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kCxsndoZJuii6bp+aVDZiY5R/6IUXscKL1lQTQbAX+6fswPKuILMLvjlno?=
 =?iso-8859-1?Q?m6L5QuOIw4QZQkrXnksAgVhI7IL5efLDGFchFLkgpSBqrILfOKyj6QAs7p?=
 =?iso-8859-1?Q?r3FYPlFaWn+ZBOwUIf8XkgmzNY5LSONv5LH6RwOgpkZYT/9/ShCL4K9k3D?=
 =?iso-8859-1?Q?vYCjIZaTyuYUEiTvrVIeroiLZLwhs2VeVBXT8TRA1QI65CEXJA0tzfVEFk?=
 =?iso-8859-1?Q?Rhq6/ur6IkrnCpVDUrNeWdjGs3pHHBJ1lDd/QL9yUByCivFlET3tx/dS/P?=
 =?iso-8859-1?Q?6M1flTXQkT6XZvVhmPe1/Pv5X+sWfLgROxmHZ63IUcBz58ahqhjIAEyqQ9?=
 =?iso-8859-1?Q?EJI+vAkiRe99SVSM6ivu/CISQZ2SyO5fnadd+hSOHj7UsuMjvHz55m5HaS?=
 =?iso-8859-1?Q?SG8sfaZ3Jb39Vac7SBR+fLTSgjL0TZnx9GXGykaymKG0mjIEq6RAocbO+P?=
 =?iso-8859-1?Q?HdsxfFH7YAk790WilvJi6LLiJjYtGKCovbi0t5FD14YdE43Dr9Q2RZjDdw?=
 =?iso-8859-1?Q?S63o8rqb5myTCG+Es3yN8u68a+7sG2JniMYwe3fx+91T/S0fT4fMHp4wbW?=
 =?iso-8859-1?Q?HczyuTV74txW0vHDQ9kXie2QxqElrPg/zNH2ENkKDex80KlBK1ZmQSWDJp?=
 =?iso-8859-1?Q?wnRJv+sYLH7mzg+gBuEZrRGksZIzDappCaw9BTQ2RPgxAGfwlDvbsX360D?=
 =?iso-8859-1?Q?6WpvK5F00r+N8EQRjuU905eeIH5kUsXkkC2dYoNeoli0sV+789u0y9fOaG?=
 =?iso-8859-1?Q?vK22qI0GFO6ATikuV94sUgOY6VJfyLARRSJctejlYCsvmQEM3DWZ19qPeo?=
 =?iso-8859-1?Q?PrQ6XZmI58kGgo1ETVfI3uUYExy9TqXifNdUVKTNkR86QcGCVWeF0pwS4J?=
 =?iso-8859-1?Q?BZQNZe++9UdMWnjYTwl2E04cYGDDHkKVo3P6DtYLjmUxm/kvwuNdINKN/x?=
 =?iso-8859-1?Q?Mn9/18gr/C/Ou5wSuyf4B4pjbH85i/fh3IX8Ib4xOc/zL8DBwiCRDskGlV?=
 =?iso-8859-1?Q?96a9HNH0IXpGkyF797xYz4kdIPT8EijXNK5S45cGPTbSZ06qlr+IPggJvv?=
 =?iso-8859-1?Q?8GZh38PRcMe4VMCKA5LRFx2yF9y2cGiS6Kzz+uyASdi+PgJWEpTyntv1MW?=
 =?iso-8859-1?Q?uj2xt9I72Sfl2YsBMN79j/zNKUQ2R9hgy9RlgWmFs+EET1W0lBc0v+JOom?=
 =?iso-8859-1?Q?V4bp9eJ2snFi/VdBynW4WaHn9FQP99StvZiEpL6jJAamLFF72+Y/fCPq68?=
 =?iso-8859-1?Q?o7hrGblg5jajm4MC2cMNVVP0zN23rLkt91/Iyrmk5dQ0U2RoMojrMOqrSs?=
 =?iso-8859-1?Q?x9o6YQkxBPWu80J9C+Kr5aZS3enNucz8M3t8GFAgAFaZjJIXqG89LctJzT?=
 =?iso-8859-1?Q?PMDnRa8n9CNRO/rC2gjPc30ZW+1ZtSVS+svL/eRhF/baJpTEUGB6mMQJYu?=
 =?iso-8859-1?Q?MZSaxJ5VIW6vHw+kBeked1J+vpK15ppgo/leCdp2LH3maBXaN1acnro8rD?=
 =?iso-8859-1?Q?r28vK9y+N3VfvgQ7l6zu4YW+yPMYgvyhbmQJwFe3OAtLamJdtA536egMvN?=
 =?iso-8859-1?Q?Vmn3OpfMiIzNAQp5Z1rXB4trz+5+Hm49lY5fvQatPcVCVOiHjpFd02koCU?=
 =?iso-8859-1?Q?eu7FEDrVezRaGcyvXLApdfBTDMuSBL6vwkhZhfAWRLqKE5ZfP+T5KMkSDt?=
 =?iso-8859-1?Q?wX07mXwVIvVm1ugY/EVjS1CbzvFQ+u65yxZN57Y5410JiDqkBLKxkrM7P8?=
 =?iso-8859-1?Q?Fplm0YaiKUA4tj6iqS1nBfzBUvADBMG+PBL09a10WzyvTlhQFU15gh+z1J?=
 =?iso-8859-1?Q?fU+oeZb8H95/tdr1DDsBSnTPyg72HZI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c01a876b-aab8-4321-cdab-08ded73408a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 05:46:01.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRbiqbVq/LVg5boSZYHM5Wxo+syH/P3rpJFdvGcX0/CsDu/w9DTxH5mJnag1rvSOEDlaye/GLtM7/LGf9wqofoiEM4m0rQuR1zvKKjgmovzDuK2lUoJtOa0A9HN+XVXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9196
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303473-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:alexeistarovoitov@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux.dev,vger.kernel.org,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 398826E9E96

> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>=20
> Sent: Wednesday, July 1, 2026 1:21 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; jolsa@kern=
el.org; yonghong.song@linux.dev; song@kernel.org; linux-kselftest@vger.kern=
el.org; memxor@gmail.com; shuah@kernel.org; martin.lau@linux.dev; ast@kerne=
l.org; daniel@iogearbox.net; andrii@kernel.org; eddyz87@gmail.com; horms@ke=
rnel.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vger.kernel.org; =
pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumbe=
r.org; davem@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; don=
ald.hunter@gmail.com; kuniyu@google.com; ij@kernel.org; ncardwell@google.co=
m; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white=
@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson=
.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidh=
i_goel@apple.com
> Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with tso=
_segs() CC callback
>=20
> [You don't often get email from alexei.starovoitov@gmail.com. Learn why t=
his is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Tue Jun 30, 2026 at 5:01 AM PDT, chia-yu.chang wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > This patch replaces existing min_tso_segs() with tso_segs() CC callbak=
=20
> > for CC algorithm to provides explicit tso segment number of each data=20
> > burst and overrides tcp_tso_autosize().
> >
> > This change provides below impacts on BPF struct_ops users:
> > - The callback is renamed from min_tso_segs to tso_segs
> > - The signature gains an extra u32 mss_now argument
> > - The return value semantics is changed from "floor value passed into
> >   tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing
> >
> > As a result, BPF programs shall be updated, beccause retuning a small=20
> > constans will now directly limit tso_segs instead of the minimum.
> >
> > Signed-off-by: Ilpo J=E4rvinen <ij@kernel.org>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  include/net/tcp.h                                | 13 +++++++++++--
> >  net/ipv4/bpf_tcp_ca.c                            |  8 +++++---
> >  net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
> >  net/ipv4/tcp_output.c                            | 13 +++++++------
> >  tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
> >  5 files changed, 37 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h index=20
> > 6d376ea4d1c0..7fb42a0ce7da 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32=20
> > pmtu);  unsigned int tcp_current_mss(struct sock *sk);
> >  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32=20
> > when);
> >
> > +u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> > +                  int min_tso_segs);
> > +
> >  /* Bound MSS / TSO packet size with the half of the window */  static=
=20
> > inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)  {=20
> > @@ -1361,8 +1364,14 @@ struct tcp_congestion_ops {
> >       /* hook for packet ack accounting (optional) */
> >       void (*pkts_acked)(struct sock *sk, const struct ack_sample=20
> > *sample);
> >
> > -     /* override sysctl_tcp_min_tso_segs (optional) */
> > -     u32 (*min_tso_segs)(struct sock *sk);
> > +     /*
> > +      * Override tcp_tso_autosize (optional)
> > +      *
> > +      * If provided, this callback returns the final TSO segment numbe=
r
> > +      * and will bypass tcp_tso_autosize() entirely. The implementatio=
n
> > +      * must derive an appropriate value and ensure the result is vali=
d.
> > +      */
> > +     u32 (*tso_segs)(struct sock *sk, u32 mss_now);
>=20
> I don't like this interface change.
> It introduces churn for no good reason.
> At least I don't see why you cannot live with the existing api.

Hi Alexei,

This patch was part of TCP Prague preparation series: https://lore.kernel.o=
rg/all/20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com/
Our original patch is to add an extra tso_segs, and after discussion it's r=
ecommended to replace exisiting min_tso_segs.

This is needed because TCP Prague would set the exact TSO size rather than =
using autosizing from TCP.
The TCP Prague itself is planned to be submitted after all preparation comm=
its are accepted.
You can find its current stauts: https://github.com/L4STeam/linux-net-next/=
blob/upstream_l4steam/net/ipv4/tcp_prague.c

Thanks.
Chia-Yu

