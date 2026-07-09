Return-Path: <netdev+bounces-306208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jtMTADqRT2pQjwIAu9opvQ
	(envelope-from <netdev+bounces-306208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15358730E2E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:16:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=jwc2cyBd;
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306208-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306208-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 795F4302738F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551E3CC9EA;
	Thu,  9 Jul 2026 12:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22A2FFF8F;
	Thu,  9 Jul 2026 12:06:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598795; cv=fail; b=Pk7hsoqPhHI9aTKJqXZuwdNk+BhuEPoUxKMfkGCc52TlUqBQJzDkaD77kVn9hlMTsictZ/V8pbdZaqKNUQewTNnaOAJbveizlS8Zd8kzQ517Xl5gZZJy/qHA96Kg3rXv37iA7JOg5PQXA0AVJ1tcydSGz3PJmcGZB/Md8j0+ByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598795; c=relaxed/simple;
	bh=fNNNQYxsb90jlQmUEvBlw1nalB4w9zvvrT35tXiYe7w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=calHMUkRYbSn+VkKzihpUQFSTNCQjNSuvmeWPGknMHZV1e1r6vRLX5ENXTIr2HHGdn8qVfxKh+r4bWK4Xr62zOhDTCq4b5SBop/WIZupED0ws208k2VUf6L7wr/yFjKpfcM6pQr+Y9+ICOu1sK3QTcn0x8waqLEfn2fU0AV1waY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jwc2cyBd; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJI4EupTFGQoMjkk2tmsjbxFzjnOj7DtKzrqifo3YhHV4sy+wql0FzfaGas8eSK6gBnpsp6HXyix5XkhcWe4xW7b49yPixx4wBxRn/5f81FRjRuj39/iKa1OWaq+q797fKJOvk5KLTyupUXfL27oCMWr4tB5m0s3+CNPWFk5JoMp058evWgTZ8WHtibmr6ShumWFHXKaSCkq3X/7gL72v8LVxfgK1zTdN6GgxcqI0qeiRyi3JzPYu5Xkc//66UIXjA6Wz17jcaUZs5A+5KCvtVqiwR1EFjhNDCMWXLoXDmlFhiwjnjNfrWJJ0Sm/rq2bIKquRbEOQ+dNMmFa8uxZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGCDsIFadpQCcTk5HBCbu62Be2nbV9CVSMo3DG3OVG4=;
 b=GzlnNekat/rRYJKa6Z/iGKqlI9dlpSVcEFr/JxnERCremU7KeoLT46q1FhyxpoOQjBfUoiyw7FaoEJHoM+aqh/u7+cq/4QIxtKAyV0rXhNPqftK3N79FOUJRX1ztmJsxzQEm++JOK2W1OXDvYEvpuTDMSAV7wf3JMQVWuMdGc+qEtg5KU+HI7rk/APE+qBh+DT3Qq1rWvtrSvJ4HHl4WQhZipR3NV41RIKbMt6SoGUc9/HAFdRpoBaEs0BfZzsptS0d+uxSNYp5PC2imJ7yVNQEoswwdvktTXUSs/QkKv+u+ELBBhAHabYKncC4ws/eRzx1i0BjXqO7bFXgKNcFN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGCDsIFadpQCcTk5HBCbu62Be2nbV9CVSMo3DG3OVG4=;
 b=jwc2cyBd+wyQJf4nKwt75oTxg+yE9cFSHvbD7Z/mY/3d5l/+2Y6oZwrtfE3dJz75MSZEy6rBkPwy9ZEQ9cesIXQQcBcQnjEvEoiEMoSTccZuiVieTgfMMzlCEnFxGf4KqJFB11RdDJYaHiQkPoxLlYUvXVwUsaSGPRnR3fG9qxYPqWEyqAFZILmB+SKy33odUe33OLsk8YOzMBd4MoH5d9ItajM5m6vbtph+Gs+rhG8xF6xaQs5+GMlHQjtNosIr/Z1OH3TA/SnLxjXJua4Ml0qxutEHhI7ccaN6prZe8CvDOhEgqkaBjsInsrl6cuu2APgZfKGZoggJ+C5ErSTOtg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB8493.eurprd07.prod.outlook.com (2603:10a6:102:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 12:06:26 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%2]) with mapi id 15.21.0202.007; Thu, 9 Jul 2026
 12:06:25 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, "jolsa@kernel.org"
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
Thread-Index: AQHdCIg87j/hTMue6UG+Foq9E1ysYrZXvRwAgABpS5CAAAUrgIAArVuAgAxI2hA=
Date: Thu, 9 Jul 2026 12:06:25 +0000
Message-ID:
 <PAXPR07MB7984969F16F5C9E1611B6C01A3FE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
 <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
 <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <DJN048GYRBCZ.M83AO0MXTKSV@gmail.com>
 <DU0PR07MB844141FCBD1AD6F40FE08D2EB9F62@DU0PR07MB8441.eurprd07.prod.outlook.com>
In-Reply-To:
 <DU0PR07MB844141FCBD1AD6F40FE08D2EB9F62@DU0PR07MB8441.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB8493:EE_
x-ms-office365-filtering-correlation-id: d3c49177-da06-4654-79bd-08deddb28029
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|38070700021|921020|56012099006|4143699003|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 FeZyBErkIjMWuTpuyekkBiQbh6a9qC6cPHcoIx5Lf2VGnxzcPW3T5eTxwA2hHAWhynQZHhRFlKdKHfAwb6cX4w6bYbO2do2k8FUFee0RBzdb/J4XuJqp6tJkdGuhaMFo9K6588Sm8UwkA5jPDjCuFLKHQtIMjAJGgAzWy8DghDiMp+Hoh00vY+z8DVd5kO6zA5XDDf1LTNTzhJZ8hDV6XuIX7XLViQmBRi7K6UmcUOy2BM56phLmu1i9aqvUViMm7AgHmECxv8mvL+Y4v8Mt65DfoiOx30ikScn/uLEn8IKlsqCeN+hraTRFWhrakngiHG5MOUHj9dICmOJ2OttUkxh97inHtCSktJxEiH9GH4S8r3FkztRj5RXbyMEjMzPiDJhxICpJvOLTQVCjowoQqjxhRe4ZjJ0CorkjHhSOiyXYpfJcUD/UmqRdo0sew/fIvcX8PrNpFPhCcgPb4wYuZEB1nUeQS/ZyPTGfbtsoi6NdkOVfh0RFn6Oh0TJy/eClIVsxIXunKirJ7vylACsWHBcqkJKSTYa1V8r7j7PYbJ4mJK7bldikgWxUnEEoYpvqDNoBZQqYIocvllgYWL9aJZ3E0Ixlfk7smzF/TMlxjfhJC6gm/dxbR/F/szsjIZQ9Kh1bWB2PoByT94QczecwQbJQMyCofMjL0cnmMo0tNJn0N16Bizw87kejwmDZJyCr0zxlE92Bgb7O26R3u0DzYsN7V9nNzv3e/QIBGV4s+R84d5yJ9z45z+6VgFWwKvWD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(38070700021)(921020)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q57ubw6by7Q1Q8eEK3xmJi9oaV23qubkGiKkt7IVkH9QMm+ubPM72+JZ5irZ?=
 =?us-ascii?Q?nc7YgZ9tra9YQ24CkNsVATBysvR4Pxey9lhGP8YXI1Mraxe3DIQF5yWU+SAj?=
 =?us-ascii?Q?2fd1awV5LTuTPUFDS75c9MBSA/Ou26UK5ayik+BdANY9WK0JdHGo5lnN8x+/?=
 =?us-ascii?Q?EH7vlipf8sztTx72VmGoyHK94vxdVSxoEWmOh9VShuF6JNpwblcs+4G6XNr2?=
 =?us-ascii?Q?JnTCuLUiI0a5N7pOBRzGuGZcvLSx/CTbUf1D8YQxs+/SfL9f2NlvcbwCsx8B?=
 =?us-ascii?Q?kn3f4IcVZ9ZOT/baV2b3p2B+YKfdPGMdGJRqNAOzARxdJG/IYdtokM+BxD3y?=
 =?us-ascii?Q?fuqM1ST31WVX8QvqNfi6UZJP139Acg+4SxC3Px6neVxBhzXbVJwWPymX9eWZ?=
 =?us-ascii?Q?ZfNAObmmHFzsgWlKPLvZrpYVlnRcBV5yDUSIZMp0uzIHnRjJ+IfLh7qoUvEW?=
 =?us-ascii?Q?JuSWYfqGX6zQPw0FEBDLgsCHi5xhooaMJ+wEVxwUZ9jWtwQ/V0BSIea4eB82?=
 =?us-ascii?Q?AxQHFmOv7zt4qDR0C5i0Wbtuf6hbfaKQpvQ1JWjmOlRZiKUv8HeRedbfVsmk?=
 =?us-ascii?Q?a+Hrc6JPdapFzXT4awWhqHgQvYCsF0FQe+1QImCtQla6cXmpDvs0FCPly4ma?=
 =?us-ascii?Q?4kuKIZhfXbkvzYjZ+3nCrwDoJoi5pj3EcW/3CdvxQeshORg0dTbPAQ2BtdeX?=
 =?us-ascii?Q?AmCCaNIEdQ99MpSaxZdi/fpZL5750aozwHb3go1O4CjCLZuQsTUcDfz8K6LA?=
 =?us-ascii?Q?X8m3fuKdlAsuwF44FFP1EY+1byLuC5vDjtftFTGrVtyNn7dkEoMzehB/Sks9?=
 =?us-ascii?Q?M6CY0xE5pVjPXCc4ZsyaZ/GuIzC20H8Tz9IVMasTgKSerXxEja6PlQbSR2HY?=
 =?us-ascii?Q?nZpK/F167R/zdn5FnBleNzCbAnRybjNCA7LIWjzGuG3IwPUcTp7M2YF18GYE?=
 =?us-ascii?Q?Ia7fWFbEcCtPWHmFTzsxnMqBx94QK82WJEetNeRZGlZbjXesgL835jk6Shop?=
 =?us-ascii?Q?g8uCRbcdqO/tHdnKpH8GEDGFrQWXidajBmJwy8Ko3Q7Tm9P3rSW9iQt6EwLo?=
 =?us-ascii?Q?lmE6WXOLpiLLgz5dz9cwUtNeNdju8oYCwqI0Q8xuMmI0KgO/J/gvw2uRTyf3?=
 =?us-ascii?Q?KUsjNyEFtdynS2ox7MlUPaf5gO9wNky7cO1oUJrbnl2WheLqP0+bYD7/GT6L?=
 =?us-ascii?Q?J0OSjYIR0DnlI9jU7Zr0qRR59MySLii/kjnOYCg/bVJXT3n2H4sKN+roV5PR?=
 =?us-ascii?Q?HNQSzqhapLzKA3E3/sYGbWSaRz3+z+AhZsfgXYsRZxgs1u57vay58WHPYObU?=
 =?us-ascii?Q?2HbyiopcjlK/8Q6r5bMJTRIShrUtsmJkuIYaw47VO94qqghjFZhNcTKhFiUE?=
 =?us-ascii?Q?I4EzTNti0Kp9whNRrq777yHYq0Pxu8cV+6kVbzLBy/FFTGLNTeeWaOIbNn8D?=
 =?us-ascii?Q?6Toq2UDZDDdgg8aDxc9D0NB608eJZGYXK0nWpUArgN7Jn0lwEUKk9d1VWkMe?=
 =?us-ascii?Q?ZSS6aEwe8ppDr574ue+zp5Oj1zqKyhhmOkacpuE2herW066314fM6OB6kKrG?=
 =?us-ascii?Q?bKO2cJ4NoL2jjUlHwk1klfvC8Fcu/t+H/8CtdG8p9vU22/S2sxz63FkoFuf2?=
 =?us-ascii?Q?94qvR53xs9C6n700dTOLhsctQSFCRpxGtVjGRfjx/uXUSjp5XoN8PKrL2hDx?=
 =?us-ascii?Q?ySwSmQcMy7H+udqfw/zjY91VgqxGTkRffqj9dFf4z/wLMaEUX3pxghcbc2Al?=
 =?us-ascii?Q?fnTREXvS8zQPCtKV/DzC4Zh/HfYN4qs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c49177-da06-4654-79bd-08deddb28029
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 12:06:25.6898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyTYsl3E+YYkX9WHF956xfVz6zQFJS+HpGfc7HAZmMKBYEKQ58btXkRjYDxvGTiCm0/J1DTpNBYB9BUehDDcKbD92qov7vegmAcqjQiKvKW3Cih0WU01Z3KUjZsmLNHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8493
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306208-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:koen.de_schepper@nokia-bell-labs.com,m:alexei.starovoitov@gmail.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:alexeistarovoitov@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,gmail.com,kernel.org,linux.dev,vger.kernel.org,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15358730E2E

> -----Original Message-----
> From: Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>=20
> Sent: Wednesday, July 1, 2026 6:17 PM
> To: Alexei Starovoitov <alexei.starovoitov@gmail.com>; Chia-Yu Chang (Nok=
ia) <chia-yu.chang@nokia-bell-labs.com>; jolsa@kernel.org; yonghong.song@li=
nux.dev; song@kernel.org; linux-kselftest@vger.kernel.org; memxor@gmail.com=
; shuah@kernel.org; martin.lau@linux.dev; ast@kernel.org; daniel@iogearbox.=
net; andrii@kernel.org; eddyz87@gmail.com; horms@kernel.org; dsahern@kernel=
.org; bpf@vger.kernel.org; netdev@vger.kernel.org; pabeni@redhat.com; jhs@m=
ojatatu.com; kuba@kernel.org; stephen@networkplumber.org; davem@davemloft.n=
et; edumazet@google.com; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ku=
niyu@google.com; ij@kernel.org; ncardwell@google.com; g.white@cablelabs.com=
; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire=
@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.c=
om
> Subject: RE: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with tso=
_segs() CC callback
[...]
>=20
> > You have to explain why Prague CC cannot rely on autosizing.
> > To me it sounds like a red flag. autosizing logic was there for a decad=
e, if not more.
> > And now you're arguing that your CC logic is special and it deserves ne=
w API and breakage of existing convention.
> > Maybe you should step back and reconsider.
>
> Hi Alexei,
>=20
> >>You have to explain why Prague CC cannot rely on autosizing.
> >>To me it sounds like a red flag. autosizing logic was there for a decad=
e, if not more.
> >>And now you're arguing that your CC logic is special and it deserves ne=
w API and breakage of existing convention.
> >>Maybe you should step back and reconsider.
>=20
> The objective behind Prague auto-sizing is that the TSO burst should not =
create a queuing latency bigger than 250us, on a bottleneck link rate that =
is the pacing rate. The rationale is that the L4S AQMs are allowed to have =
a very small threshold (often somewhere between 0.5ms to 1ms). When the pac=
ing rate is 96Mbps we start allowing TSO size of 2, etc... Below 96Mbps the=
 TSO size is 1, and below 48Mbps the potential serialization time of a sing=
le packet is bigger than 250us. You will also see in other patches that we =
limit the serialization time of one MTU to 10ms when the rate goes lower th=
an 1Mbps by limiting the max MTU (going down to a minimum pacing rate of 10=
0kbps as the minimum sending rate).=20
> L4S AQMs are designed with these parameters in mind. As AQMs usually work=
 packet per packet and evaluate waiting time in the queue, definitely the m=
inimum inter-packet departure time needs to be bigger than the serializatio=
n time - 0.5ms or packets will get marked without necessarily using the ful=
l link capacity.
>=20
> The current autosizing algo has as objective to scale the TSO size depend=
ing on both pacing rate and RTT. It targets a 1ms queue delay burst when th=
e RTT is bigger than 3ms, but when the RTT is smaller it further increases =
the TSO-size. The rationale behind this is that a bigger TSO-size results i=
n a bigger chance of loss, and that loss is easier to retransmit if the RTT=
 is smaller.=20
>=20
> So, the current algorithm does not line up with the Prague expectations. =
Is allows bursts of 1ms instead of 250us and it allows even bigger bursts i=
f the minimum RTT is below 3ms (for instance 27ms burst at 10Mbps and 1ms R=
TT).
>=20
> I see following options how to include the Prague requirement of 250us bu=
rst instead of 1ms and not increasing TSO if the RTT is lower than 3ms:
> - Let Prague do the calculation and set the desired TSO size
>        - previously done with an extra hook to overwrite the autosize, bu=
t it was already commented to avoid the extra hook
>        - change the existing hook and add a fixed or max TSO size (curren=
t patch did the fixed TSO overruling, maybe a max could be more general as =
it would always be lower than the current calculated autosize)
> - Add a cc settable parameter max-TSO-burst-time to let the current autos=
ize do the extra calculation and take this extra check into account
> - we are open to any other suggestions...
>=20
> Koen.

Hi Alexei,

I see Koen had responded to your question in above email.

Would you please let us know what's the suggested to proceed?

Thanks!
Chia-Yu

