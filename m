Return-Path: <netdev+bounces-303761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LKYhL6k9RWq/9AoAu9opvQ
	(envelope-from <netdev+bounces-303761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:17:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4659D6EFA84
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:17:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=d+T4nBui;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303761-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303761-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CA4F3061D5C
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B37367B7F;
	Wed,  1 Jul 2026 16:16:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904236657B;
	Wed,  1 Jul 2026 16:16:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922605; cv=fail; b=bEcUANQFwYxbA1D/PIojkg5YYQ56FCVKepU0mz2hSBjQ8Nj471aqqsdw3c+l2tbGdbhjiA5DDDkmy2e6u7aiTCpbMzHHOtYtsKTt3CvGe5zXV4MQ+AVk8f8AQgx3th4e8hkPNoTkZYsz+plRbnWC5sKZ8feiXWbZr6FBhhZdJWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922605; c=relaxed/simple;
	bh=AGyHlRPM3reAemhe219fJBgmmjNosg+YDWr1fhHJazI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nHdNQP32RGv2w/2zb+TyBB6btlAVAURmP7ej2s2xhFA3WrWOInrbsvrVhyGUzI7GdPm6WtEaz8K2FOSsur7JIEhBRLw0hktcOc2eILVEszW03m4j6k61TA51n5tc++yG8Z+vaBSOIvUq2ePRcIidY6kSGLZhNtw8JaLigATwoC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=d+T4nBui; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri59JHtL8/mHfK4UcGtTqNBDnpZmtf2+iW4vIGcKPUsut5BRi4uRFvGSMdednfqgFLRFUjkw5tc5cUYec/+5MBtEahkPOn/LOTYEhd2tFCpUJS0Gprk68JsOfPJwqsftc6SXu+z790HUlcnkGv9JK5qid3ONY/92k2P967NzzQFCsxhtVw+7bW8eJaxObCIPJYcwkn/zRTNuIOmM0QMbz5dUb0TZ7aXcsIA6vBCZYY/uwq6880Jsiq2RLeOzBFOA5Gr95smk8NhNKG7fZ9OTA8wFOfBv1W0qnGzszxx5d54c2FH6DvHFGPSyJ4Hgt/eDvWJoOwba21EHULh9WykFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5UhyJQ6Cla7OExs/24b9jnbfZFKNSu0G0LyDQXNqGQ=;
 b=iHCjTsf9T0YZ/93PjtmGIraIECu6D/1gvkFUsQKPGBvB2On+wXMOaQAmWl7PtmxMjYp7k7BNmeQKUi1FTMx+zKGjccbqn4TeREnw2oeWUUVkopVy8UmYVJ/neo7JGG+RzDY6nbaF0fPvwv+lMzORcHq7H+FnoM8z2qRoR6/pDXZ4fcdGv9PTzefhEIWLjyX/yHTBhghUYyHQk9nYdVEyvkC6K+1bbGBWJnPSifG+0FOqILa2jdOB0LqNFeqKDw5+YIwGQ5JHt2OfWuTHQCD5MGXKbvXdp9BT/6owt+cDMDrqfHEFWc29Kt0U1RiYI0HgcTHrKn2I4WVvAginFicKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5UhyJQ6Cla7OExs/24b9jnbfZFKNSu0G0LyDQXNqGQ=;
 b=d+T4nBui8bK1bDKewVntxxLjGp8zSfwV5eJpyq2BPopnDJkos9iTkweCDjOe0FTP37VNP/5FlC3GTXtOBftAXzqXVZzeDh790HWkVE54eJFcxRKfhy3qZKWbpgMwlSXvgAYCY1sty/g33KWG1WqzmfKnIaSzwaFy5Jrn8rNeoRmVBnyuTP5LfQnSnMc+4vXREl4V1Gswli7tnLUg3+XYcL/vequXRB/ollZx0Tno323LAVbzQQoWIfBlul2wtoAnN8+NPgK+WIwxnXJPKIl+5TwC+szwCh/EOFR39nf0/h3SRpj/d2pZObmkXQLLl2QbJxkaRZrkVGLmuo7fsno3sA==
Received: from DU0PR07MB8441.eurprd07.prod.outlook.com (2603:10a6:10:354::20)
 by AS8PR07MB7144.eurprd07.prod.outlook.com (2603:10a6:20b:25e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 16:16:40 +0000
Received: from DU0PR07MB8441.eurprd07.prod.outlook.com
 ([fe80::7aaf:2a26:5a13:ef74]) by DU0PR07MB8441.eurprd07.prod.outlook.com
 ([fe80::7aaf:2a26:5a13:ef74%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 16:16:39 +0000
From: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "Chia-Yu Chang (Nokia)"
	<chia-yu.chang@nokia-bell-labs.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "linux-kselftest@vger.kernel.org"
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
	<ncardwell@google.com>, "g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Thread-Topic: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Thread-Index: AQHdCIg8HgSKPBAq9k+bjLaznYoXgbZXvRwAgABrn4CAAALXgIAAnb8A
Date: Wed, 1 Jul 2026 16:16:39 +0000
Message-ID:
 <DU0PR07MB844141FCBD1AD6F40FE08D2EB9F62@DU0PR07MB8441.eurprd07.prod.outlook.com>
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
 <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
 <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <DJN048GYRBCZ.M83AO0MXTKSV@gmail.com>
In-Reply-To: <DJN048GYRBCZ.M83AO0MXTKSV@gmail.com>
Accept-Language: en-US, nl-BE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8441:EE_|AS8PR07MB7144:EE_
x-ms-office365-filtering-correlation-id: 3f0299c1-a07e-4cb5-aad0-08ded78c21bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|921020|22082099003|18002099003|38070700021|3023799007|4133799003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 8Z8/1Grb1wTdUerGYvgrYYbt+HD5ViK5xL5BrkJAs+VB/ctT8p/PNC8AuR+Bg57hIjwze5APdPoH/DLjt1O1uz5vXrX7eMeYaHNRQhYykvIvQX2wIiDaKOz7k6Y21v39IjqqB8Y9rEqOid759OwPDpwptRU42Llxt3bazZy63G+xItatBHUsJQgRdAtZAu5dLLa7Juxxlm4KXRzwUwWxs77FPIILoQxm3aprY5Pe2y3GHtwbXghA0i6FzF/u3Y9g6mmcvML2Fzgz3f4YI2kEJKie1fD1AIz0BXxcDq9N92Jna00VJg2VLLxP0kp39TwFW69jPP1PHVOa+qtDI+RwmWa4stnx5dHJkqsZ+zRVdbKLhZg4TShzQuOBc3MPXSXqbKxYaEb3oOWO5q1gHs/QE5YEDLK+/V4pYrkuOY98RUL02tcUBlTEPbn0MKZwkP81i2KhEpADshd5eFCVa/tq31CtzJ+VdUWoS1RNslxxsJ61uAsJNC+HpwxorB6nKjCDyUE7Ii7Arc8mEVxmOIWJlH7z4hwTglwTVCzXEBW5oIISjSJKoJWyZWSYUmscr8wPysIg1EKXWNPfJfDzjwqKCrEe/bs+OM5ojApC7DxxUAHlyAL5XvSP1KhlqwjhIrr8xSFMNWjWOeMaN4FvlcMeehc+GVO0L8tOPkvnx2UUxy9EGJ8FeAvwh4Eubq6QUINCDNgJ6hsoG9wVs34wreBNcLYUdIZmHGAdzbwBGYvZ5V1FG9OZOOrIaAuj/u/37er0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB8441.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(921020)(22082099003)(18002099003)(38070700021)(3023799007)(4133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gl7fYhrrXWtTZSimNudWz8ZSKjPdusL79YFPVoQeC53eK76P00bwsqMHobT6?=
 =?us-ascii?Q?MAvxUKgNFf0yVp+Lrh55ymR3Pin1uKgB/D1b66MnaQlngNgkjuD+GgdYRawS?=
 =?us-ascii?Q?pG8N6L4ziHaQsaWBfCnxTGqPCKxUHFqV7bEX9gyOCE5bd6V3d0iEglEdzhXg?=
 =?us-ascii?Q?v9zQ9wRyVCCAmvJHfEbfZoCrvmb3byVkzxuYkZ+hCHc/FOAgp8mKzreAxn8f?=
 =?us-ascii?Q?oMGnEqsz4EXG9n9qZc7vUUMAiGl5Y2wqvsWM951VZcYUP3Ghd7sqbIE60+5H?=
 =?us-ascii?Q?P3jMWw0KlnM2iLNWtRPt41jWi1wsd3NjG3BjoqpA5KnnFpOETY3xBvOk5bMI?=
 =?us-ascii?Q?KrNRFMjUDEXcjeRrMiw06THMtJMFwJnAudXnfOD2z4GXKm1vjLqXz7IJ7lM6?=
 =?us-ascii?Q?mCVh0+pqf6IABoPjtn/OxObiJda8JK+YesNVZSTS1Mvck+S9mMxl+zZEhuwy?=
 =?us-ascii?Q?jLxqnj62MdPQFCWisWBkmb/Mz9u9TN5qyWmOmsnBoLhfUnt6B/1qGXsH9rwO?=
 =?us-ascii?Q?wfDHq/o+Px5P09o37y/Fy5tDWVcNSCZ1zhV3Xwg2A3farKOt2D/n1pIdCyNQ?=
 =?us-ascii?Q?T0t0yzg8lqATuIZV6KU5dtlfoNQMVM/7e9ItFg29OW/guDgzrB/f9uUY4FQJ?=
 =?us-ascii?Q?f/BARlQArySoAkYoTM9CHAnHp0rM3vs3qeAF/g9NIxLGr/GMHfR8eAeiFdN+?=
 =?us-ascii?Q?8KpDSwV9+6BgsmG4j8LWRJAqnLKmw7qF/IniMSwrRbIfdtrl9SJSuKySOGPa?=
 =?us-ascii?Q?Xkfh+JYlSq/Yfe4HqbPeSwXcWeV8r9u6buxNiEO8ANz3myB7Oi4jh514XOMJ?=
 =?us-ascii?Q?Dg/MTlmq2hT6/0N9kxaBJYGUnkoTrUVHAyLPrsxFllJQTPb2phdFMTVmmo3n?=
 =?us-ascii?Q?VbC7Izf+t6cdxBMqbp2QY5/mnuw91w6/GGVfSwe6JDhWGCNhye0Kmm8KclWy?=
 =?us-ascii?Q?wCujmwUcCu0qaYKPUWEokQvabrdB3NWQvfCMpaM5gMxac4ETqyAELEjemk9z?=
 =?us-ascii?Q?6VMmG9i1Shkk+YY23zWZS7IzdlecxEiSe+4/iMA4FUNUp+l94JUffi/LIffn?=
 =?us-ascii?Q?jn5KGK7Soj5QwxeppFUJcQL+yeS+f+7q98Hugl1kaUPeWGLftR7uOZEWn30f?=
 =?us-ascii?Q?khFd28K+GTdLRVo0cX5y6qBp2PXZj5B2lLqOm4KyyYIJKuEC/E+0VCrcKWAj?=
 =?us-ascii?Q?cGt+boaE+1L19CojZThyGlyQrogx1fMT9gZq+r8HkevuBcdBp6FIuARRYp0y?=
 =?us-ascii?Q?DapaERiG4haQG1RsA0yWDwGyHA6yN3wiJg09c14s1jGF8RDkxSSw86Aw4x6e?=
 =?us-ascii?Q?owYnCqE1HI3KVpxpaP8oMUxepf2jIeiSITdl49Zny2jyevhGU+pFg07ecP76?=
 =?us-ascii?Q?CEE2TgIgH+MIHgg5EHtpKk5Kc8mVXoBT56T1lS7UP3QK/y+3YBtWm2FiM/0u?=
 =?us-ascii?Q?lgST+xodYIBWRpoSVVMVJjFH5h4kSQXpVvpVLEvitbNypcOaoyIm3kkbQc+2?=
 =?us-ascii?Q?cdNNHn8Yc3No9fwIjyzct/P01WzFHv0Clg9whnZ47iKPnnKMGVIU5Xw3W7oS?=
 =?us-ascii?Q?yZHcFAgySOsDjAAApD2zNDOhkHJRe0Rw8cw8lVSaJcnDoF+8QRZ7Sg5KT9PD?=
 =?us-ascii?Q?8IOggdKIdXYgn4koLOiOHcX8sklKX+p2vd7TYwGQjzBRwtOwvi4klEpvvbvN?=
 =?us-ascii?Q?pMrJr6ltJaEnW9WZ5Qszlan+n0sdMCp6FT65qwDgevNQOl7os3aaU/e7/zJ8?=
 =?us-ascii?Q?OPhq+VgT4xojZm5Ta2roKr4YC8OakOlB4cKdNGT6EC6sVSG+py8o?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8441.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0299c1-a07e-4cb5-aad0-08ded78c21bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 16:16:39.4262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75g5ysuNaLXytjEnXiBy5zSjjv5VrdJL4gHzhW5zweUwnB4YmkrYI0nBF/JWFUaj8YggSlyKbsAp75YSB+r8oDGhQ6rW0LbJuhftNpchZmYudyDEp4CR3JgyRexLTIkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303761-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:chia-yu.chang@nokia-bell-labs.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:alexeistarovoitov@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nokia-bell-labs.com,kernel.org,linux.dev,vger.kernel.org,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER(0.00)[koen.de_schepper@nokia-bell-labs.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[koen.de_schepper@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4659D6EFA84

Hi Alexei,

>>You have to explain why Prague CC cannot rely on autosizing.
>>To me it sounds like a red flag. autosizing logic was there for a decade,=
 if not more.
>>And now you're arguing that your CC logic is special and it deserves new =
API and breakage of existing convention.
>>Maybe you should step back and reconsider.

The objective behind Prague auto-sizing is that the TSO burst should not cr=
eate a queuing latency bigger than 250us, on a bottleneck link rate that is=
 the pacing rate. The rationale is that the L4S AQMs are allowed to have a =
very small threshold (often somewhere between 0.5ms to 1ms). When the pacin=
g rate is 96Mbps we start allowing TSO size of 2, etc... Below 96Mbps the T=
SO size is 1, and below 48Mbps the potential serialization time of a single=
 packet is bigger than 250us. You will also see in other patches that we li=
mit the serialization time of one MTU to 10ms when the rate goes lower than=
 1Mbps by limiting the max MTU (going down to a minimum pacing rate of 100k=
bps as the minimum sending rate).=20
L4S AQMs are designed with these parameters in mind. As AQMs usually work p=
acket per packet and evaluate waiting time in the queue, definitely the min=
imum inter-packet departure time needs to be bigger than the serialization =
time - 0.5ms or packets will get marked without necessarily using the full =
link capacity.

The current autosizing algo has as objective to scale the TSO size dependin=
g on both pacing rate and RTT. It targets a 1ms queue delay burst when the =
RTT is bigger than 3ms, but when the RTT is smaller it further increases th=
e TSO-size. The rationale behind this is that a bigger TSO-size results in =
a bigger chance of loss, and that loss is easier to retransmit if the RTT i=
s smaller.=20

So, the current algorithm does not line up with the Prague expectations. Is=
 allows bursts of 1ms instead of 250us and it allows even bigger bursts if =
the minimum RTT is below 3ms (for instance 27ms burst at 10Mbps and 1ms RTT=
).

I see following options how to include the Prague requirement of 250us burs=
t instead of 1ms and not increasing TSO if the RTT is lower than 3ms:
- Let Prague do the calculation and set the desired TSO size
       - previously done with an extra hook to overwrite the autosize, but =
it was already commented to avoid the extra hook
       - change the existing hook and add a fixed or max TSO size (current =
patch did the fixed TSO overruling, maybe a max could be more general as it=
 would always be lower than the current calculated autosize)
- Add a cc settable parameter max-TSO-burst-time to let the current autosiz=
e do the extra calculation and take this extra check into account
- we are open to any other suggestions...

Koen.




-----Original Message-----
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>=20
Sent: Wednesday, July 1, 2026 7:56 AM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; jolsa@kernel=
.org; yonghong.song@linux.dev; song@kernel.org; linux-kselftest@vger.kernel=
.org; memxor@gmail.com; shuah@kernel.org; martin.lau@linux.dev; ast@kernel.=
org; daniel@iogearbox.net; andrii@kernel.org; eddyz87@gmail.com; horms@kern=
el.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vger.kernel.org; pa=
beni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.=
org; davem@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; donal=
d.hunter@gmail.com; kuniyu@google.com; ij@kernel.org; ncardwell@google.com;=
 Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@c=
ablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.c=
om; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_=
goel@apple.com
Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with tso_s=
egs() CC callback


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Tue Jun 30, 2026 at 10:46 PM PDT, Chia-Yu Chang (Nokia) wrote:
>> > -     /* override sysctl_tcp_min_tso_segs (optional) */
>> > -     u32 (*min_tso_segs)(struct sock *sk);
>> > +     /*
>> > +      * Override tcp_tso_autosize (optional)
>> > +      *
>> > +      * If provided, this callback returns the final TSO segment numb=
er
>> > +      * and will bypass tcp_tso_autosize() entirely. The implementati=
on
>> > +      * must derive an appropriate value and ensure the result is val=
id.
>> > +      */
>> > +     u32 (*tso_segs)(struct sock *sk, u32 mss_now);
>>
>> I don't like this interface change.
>> It introduces churn for no good reason.
>> At least I don't see why you cannot live with the existing api.
>
> Hi Alexei,
>
> This patch was part of TCP Prague preparation series:=20
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> .kernel.org%2Fall%2F20260611161504.228319-4-chia-yu.chang%40nokia-bell
> -labs.com%2F&data=3D05%7C02%7Ckoen.de_schepper%40nokia-bell-labs.com%7C5
> a4af4e411b5485a2abb08ded735768f%7C5d4717519675428d917b70f44f9630b0%7C0
> %7C0%7C639184821777198173%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%
> 3D%7C0%7C%7C%7C&sdata=3DyBTs89k8g2CSHfi0preWag0X%2BR%2F5vJAmRw6ijEK4E1k%
> 3D&reserved=3D0 Our original patch is to add an extra tso_segs, and=20
> after discussion it's recommended to replace exisiting min_tso_segs.
>
> This is needed because TCP Prague would set the exact TSO size rather tha=
n using autosizing from TCP.
> The TCP Prague itself is planned to be submitted after all preparation co=
mmits are accepted.
> You can find its current stauts:=20
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2FL4STeam%2Flinux-net-next%2Fblob%2Fupstream_l4steam%2Fnet%2Fip
> v4%2Ftcp_prague.c&data=3D05%7C02%7Ckoen.de_schepper%40nokia-bell-labs.co
> m%7C5a4af4e411b5485a2abb08ded735768f%7C5d4717519675428d917b70f44f9630b
> 0%7C0%7C0%7C639184821777240736%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGk
> iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyf
> Q%3D%3D%7C0%7C%7C%7C&sdata=3D1tkkWXoSYqOyvr3FkmKpybDt2M6P7BOY240SEvkjfqY
> %3D&reserved=3D0

You have to explain why Prague CC cannot rely on autosizing.
To me it sounds like a red flag. autosizing logic was there for a decade, i=
f not more.
And now you're arguing that your CC logic is special and it deserves new AP=
I and breakage of existing convention.
Maybe you should step back and reconsider.


