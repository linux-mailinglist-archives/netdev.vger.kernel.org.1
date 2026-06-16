Return-Path: <netdev+bounces-299827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bfNkMDpAMWrAfQUAu9opvQ
	(envelope-from <netdev+bounces-299827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CCA68F456
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:23:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=RYEwiFOc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299827-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299827-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D95F03013ECD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7A345757;
	Tue, 16 Jun 2026 12:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8C317161;
	Tue, 16 Jun 2026 12:23:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612597; cv=fail; b=eC5nCWppP3PsKABKF+wSfp+Ht2aTmFvk+OyPAb164OheS10Ulq0La75Rr0egXbF/Fv1q/lHq+5Oz12br6tXE/QpvV+skXBjtfxc7lN0VH0lT7G7cuPDXo7m6nEtdkd0xFNcbWUNwdljhojdyMW8Is4JpZIAaW7qA+AMuU9gGdwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612597; c=relaxed/simple;
	bh=IQpHO5ax+8oOywQFnYPIhZNfiZIh+EAAUy8qWkHQwbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqJQcqFTwIdr/LYeYKGOSh+XvldU8LXgOwTswJyN70h+vmS5cRhP6dPvghHJ/rWbqcp2QTGUrHdyLXpD6qTQ/88by3tPR4zkP8RyXMAKU3WklKbL5if8aHh4VDZmBypJf+5hhfPwE5TbSyB6OzsB2wrnnWR7zSS8tJTY1e7/X1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RYEwiFOc; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHZJoo8hRQygt868Ec7wzcUihnJ3Kc7V0U0HbLJTQHLZjP/ZY9wsNibA+5MGiZNSsYLIGObHpesIDUMC7HMXe5A13Zs6kxTXSxtU0gZSF5Tsr42lCGWwXudggAmnv391pKula0H6f3uGsobQYDczQZG+nxcihiFb6d8UuqD10wjF9WuEtXq/m6kL8D6UPWLs6G5sXVjyBcXBGW4esOWsj3TtmNI5zKZQEOtmqDs176SxCuMfC94oL1Rk1UuONRBtTXwuCZmsMXM1jphB0wtmGUKFtLsWnRFrsmLOvkwAmFoZxVrt2dAvcSV2ODX4fKsaHlyMZVABwBNamkEaHafn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQpHO5ax+8oOywQFnYPIhZNfiZIh+EAAUy8qWkHQwbc=;
 b=myFKiFCR6WBYhaTz4uWeShv0odyw9INbHMBt8wAGAnOwPSFDewaXrJc2qk7ZyA7E2L8QQqHolvhc/AJCyHJvO9Lm/4bfqVo3YupDq28NG9DpXgtkVJc2wAQbYUCf1Y6PrDqBFgc4UEuQiDNmTYUeNeReaGgyLZa6YxHJ/JrTTekOZZc2mpHxb210VXyqXt/H7cZaAHE5U9VS4TMDGpxs0w3AXSHfVPsXV5k/yKBB1PO5pl55YjM6gLCSIhwCz5peuX4TCnmGC8l+V/6A/OZHGgSpEZ2IjLZW5cpBP1isiEq1vhEfO4+9AIdNKElUzlOwx/14zbb382rtqFGiPSzLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQpHO5ax+8oOywQFnYPIhZNfiZIh+EAAUy8qWkHQwbc=;
 b=RYEwiFOcddwTL+et/kh97oeIcYc/xi3+n0FyTN5MYpx0l6UzDht5Gvh81SRyYMC/oUmgIhP1pnnPUGJStq+HLb3SzEZ0oR1cQN8i3KbaN57VIBKT3fcjvU6nrHF5LSN0yOvIj/PdwAc1Uq02nTlB8GmPM6STMUWr06iOXLKDjTlcXXjeZeOKgskSYRLJy/11c/KuUcHRd9JiGgdXtsXAJKZXJjx+XAWgVWLF9kRNxRaE4zL0osr5tx9suYitsS/q9DLYK4oQA7M4ffMV07gWyYlVG3QvkABzQG7iPdjlTLRJEaoxfOUPaff2hq6Xit4jADwEho+/QGuk5hOqcORHgg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by OSKPR07MB10469.eurprd07.prod.outlook.com (2603:10a6:e10:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:23:11 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:23:11 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "ncardwell@google.com" <ncardwell@google.com>
CC: "jolsa@kernel.org" <jolsa@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "song@kernel.org" <song@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"memxor@gmail.com" <memxor@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Thread-Topic: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Thread-Index: AQHc+84N6RcutbkfqUyYk6P3JjhYGrZAbY8AgAAHRgCAAKg9wA==
Date: Tue, 16 Jun 2026 12:23:11 +0000
Message-ID:
 <PAXPR07MB7984585F9348BB3F000EB330A3E52@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
	<20260615185102.5e8de52d@kernel.org> <20260615191704.31be22da@kernel.org>
In-Reply-To: <20260615191704.31be22da@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|OSKPR07MB10469:EE_
x-ms-office365-filtering-correlation-id: d81d2116-b6de-4f44-4f74-08decba207ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|3023799007|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 PgMOD0iS2IqLl01CXw/Xk+haHmpvgOypPWK3nKpnL1y6XehLG2ounJdidoPtpYL1eQ0WWB6dFexgZE548Zp1nJ6KIzRbr5VEgXNLr3zwfvPbVKfW2hnYMeOgCBsiXugM6OToC4TlgUFXcwyH2zlsOrHdlfkkfITIKnq7zb6Sz9+p1WK9Eh8MDEmevzUrc1wcj9FqnILZLOT6+LYRuSi9d7wP51XzYC1eyYuyGgTxInxiVuCXSu/ceGU6YalbQWdebqkuDiCvRnptzZUZ9MZyx952/+gebpzHTmKIsa5IuvZM0yz912WDgAAqW3DC0g2zI6Arn4Z17nQv36SDUgi0/RD7rs7gXAklYVd0zm5D3HproJFNB+3CCkHW5S+iz3I5zr7iObV64D8OR5G+qoEFwJq8cecsnCGnLoDV4ElrBkrPOhG9P5ix/4NTIgwO4h/y4y2eGk5KLVinTrYX0qb74FHaAhD/gcDB2HhhUi2cf8SFlgkzJr9s81meH0X6LcREj0UZERZ1jc0F0i98kGbEMx0OAhHXRKVk1Lim46Or4csv9UVNWOHZg0Sc+qb1OOURuj+dFNSetdIUNrPp+wy7Uim6FIe9cVJ7Dt1Rze9Y9aNRFVjnlGFTqyQPtwBEUF8B0PN1TABwmW3PgHvtX0I8OepnxloBjvEXY4PhMOqItw/HPojlr2NWtcqM/Z+Ek/BKy4wLQWbbWqN9NIoQTxKtI7rEB3mjV41iToNbekQ/3LD4aLGdIKiIv7/UKlEypBYx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(3023799007)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z3Ajbw8TWwPFcQjMpwkVfC+/PmV76hLslRobNso7aqhC3wM2Lk8E/lTK1j98?=
 =?us-ascii?Q?1Tuv0ChvlBxwJ+xuW2RJ57VqQbhdf2lZ4LEEd1jtLP4KBRKX4tk0cxFAGs+T?=
 =?us-ascii?Q?j7yVndnDCTtSIxflTKKrrLjCQB61t6MALrkHA3sQ04/SLuJw62+PvYUo448i?=
 =?us-ascii?Q?DM7o+EwQxge1v/WgNsnqJWcVLG5QfU8Xyj2VBEIglofCMXcR4cNLxuGTiFLW?=
 =?us-ascii?Q?w4OZDf9gEkwdOQIhne8F5UesvIDKiCBEluZFhQnALYxmYjL2fLSNv9Jdv/31?=
 =?us-ascii?Q?moTmk6Z1Hdm9v+Vqmbn+XnF9PapbAU490ezrYNH/mcvpU23yXKgCf8bN3QEV?=
 =?us-ascii?Q?HKybauI6M75xI2FX9j70CBHl30+EbrNLzvVvr0cm+b2qjZ6P4V4sglYCDPyu?=
 =?us-ascii?Q?45vhV/z03IeEdSBfud0frGpw9P0IcBGJr/RYoi78WcMyGhO2Svj8ioLkNEz/?=
 =?us-ascii?Q?UuQO40jptGAKqBnbnJPOkdsDBubrcl2WfrdvnUKelH7eJIgRdBS80s2+CoPB?=
 =?us-ascii?Q?Qkvx9HbekVMLZXg+F6zH4CnyyF6zAUyONqSDX9xA9rfb3/nJ4IFKeB1xkSFu?=
 =?us-ascii?Q?DN7V0hXE9D1mZNE/mOp+0jckxkzuRz8LtnnNorSiNABwC0dW7HuJDt4CV8uE?=
 =?us-ascii?Q?gMflSEkgTENetQG3sODrQuS43mHnB4c70qj/ltFe50Yo+Tp0D3GYqneu/jWY?=
 =?us-ascii?Q?EWGt5E3OKm0x6hVsrMK5SJcDCO4YBaWauJWo3dMGWuqctFQm2QiaKm6+RrX0?=
 =?us-ascii?Q?0uC72yOwjMGdzcJwx79wpni78W4eLnMTaeGmLCdFpoNbg7i1Alp7jjc7Sy4t?=
 =?us-ascii?Q?rsRFdykGa812WZv935w1rIDKqRrnGeYe+v7DQYYmG54LQY6Kjayrv2cOdjnc?=
 =?us-ascii?Q?qX8VznTL2Ep+166TNlsDH0wElAa20Jno8lL5lqx3hv0U1KpU/PF6qSHvYAna?=
 =?us-ascii?Q?sA6dNmin6cK7fzf4Clnf8rzB5sR+mPRhtp2gK+GrqNsxQmmFmajJOJhGX2tz?=
 =?us-ascii?Q?F9OIl7s2VgWGu4uaYB1xpuglCISf5FJ/xlMTvhqAq8dc3c9bBmzvaMFZksEH?=
 =?us-ascii?Q?/K8YiZGjZmD9ey1Tbf5lCry9uSQR8svpCH/vpyk6lbssBpwUY2XbX4GbNusC?=
 =?us-ascii?Q?SLLT+PQzR5iwRoOlATnTc3XbsahinWzW7iTHC7pLQbA0OprH30AI0ggqqY3z?=
 =?us-ascii?Q?ExE2ywRGHZPiNrvl8XDbZuz8rvanCHZS7W2SXHiWSyn8YXDVvzARZJ6li7fa?=
 =?us-ascii?Q?QD7Nee6eYEJxWeIL0RUJx+T4NQIFxqCiPUeFrQunCzUQS5IEI9+7CIL0KdHn?=
 =?us-ascii?Q?Rts44KXblpJF8Wj4I+TOeBfA/h/Azy6khvzMSOeIxITLKHsZBR730DqXnBt3?=
 =?us-ascii?Q?zKjKVenWqE1f319Sx9NvyEEfybdIVIFqhcStCxZH/mqAbukNWWz0w/in20wI?=
 =?us-ascii?Q?Xt0R3bXOyrZj3cdJF5ZsbeO0b1EitnyxtRD0f/zAg3mGPiPVTSnfy6WbFCov?=
 =?us-ascii?Q?T0YwOxAGy+KptYJ3VWAOvexeT8uHaRqaa41w0iMEAfO/0TBJWcxA0Y4Jp66B?=
 =?us-ascii?Q?2w4KrksZE2sZr/kGJSDGvn+B7Mz875BkleP+nm4pcy0unoRNZgEmWCWj0V6x?=
 =?us-ascii?Q?SkzyXx9+cV/TOkb87OVQvVzu1SUtCVcwKbM0zBGialh41y0t/pynRRJre2r8?=
 =?us-ascii?Q?sl+WmYRfWWcWI95JlQe8LqJ1labJChOX0wdFNS3jz3jsTLJz4gJnICNKfKzu?=
 =?us-ascii?Q?nDR59E1hbz2vPHP1a1E9j/Y6DHyZ/Hc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d81d2116-b6de-4f44-4f74-08decba207ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 12:23:11.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYUWn/9w515Nr51eZXSxbbbciO+v6BaDRCB30R83SFC4PYmJVBS5Dv45PJuVipYjK9COfMij/WrmYJHhN4FpzespZ5JvhIpevykSPJlwdLn/rQ+YnDer2BbcxsYRHUrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10469
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,google.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34CCA68F456

git send-email --to=3D'jolsa@kernel.org' --to=3D'yonghong.song@linux.dev' -=
-to=3D'song@kernel.org' --to=3D'linux-kselftest@vger.kernel.org' --to=3D'me=
mxor@gmail.com' --to=3D'shuah@kernel.org' --to=3D'martin.lau@linux.dev' --t=
o=3D'ast@kernel.org' --to=3D'daniel@iogearbox.net' --to=3D'andrii@kernel.or=
g' --to=3D'eddyz87@gmail.com' --to=3D'horms@kernel.org' --to=3D'dsahern@ker=
nel.org' --to=3D'bpf@vger.kernel.org' --to=3D'netdev@vger.kernel.org' --to=
=3D'pabeni@redhat.com' --to=3D'jhs@mojatatu.com' --to=3D'kuba@kernel.org' -=
-to=3D'stephen@networkplumber.org' --to=3D'davem@davemloft.net' --to=3D'edu=
mazet@google.com' --to=3D'andrew+netdev@lunn.ch' --to=3D'donald.hunter@gmai=
l.com' --to=3D'kuniyu@google.com' --to=3D'ij@kernel.org' --to=3D'ncardwell@=
google.com' --to=3D'koen.de_schepper@nokia-bell-labs.com' --to=3D'g.white@c=
ablelabs.com' --to=3D'ingemar.s.johansson@ericsson.com' --to=3D'mirja.kuehl=
ewind@ericsson.com' --to=3D'cheshire@apple.com' --to=3D'rs.ietf@gmx.at' --t=
o=3D'Jason_Livingood@comcast.com' --to=3D'vidhi_goel@apple.com' ~/L4S_patch=
es_20260613/linux_net_next_prague_series0/*.patch --from=3D'chia-yu.chang@n=
okia-bell-labs.com' --smtp-server=3D'mailrelay.int.nokia.com' --smtp-server=
-port=3D25


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Tuesday, June 16, 2026 4:17 AM
> To: edumazet@google.com; ncardwell@google.com
> Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; jolsa@kern=
el.org; yonghong.song@linux.dev; song@kernel.org; linux-kselftest@vger.kern=
el.org; memxor@gmail.com; shuah@kernel.org; martin.lau@linux.dev; ast@kerne=
l.org; daniel@iogearbox.net; andrii@kernel.org; eddyz87@gmail.com; horms@ke=
rnel.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vger.kernel.org; =
pabeni@redhat.com; jhs@mojatatu.com; stephen@networkplumber.org; davem@dave=
mloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; kuniyu@google.co=
m; ij@kernel.org; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-lab=
s.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kueh=
lewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@co=
mcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with tso=
_segs() CC callback for TCP Prague
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Mon, 15 Jun 2026 18:51:02 -0700 Jakub Kicinski wrote:
> > On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.com
> > wrote:
> > > This patch replaces existing min_tso_segs() with tso_segs() CC=20
> > > callbak for CC algorithm to provides explicit tso segment number of=20
> > > each data burst and overrides tcp_tso_autosize().
> > >
> > > No functional change.
> >
> > Eric, Neal, looks good?
> >
> > The min rtt thing in tcp_tso_autosize() helps a bit but if the sender=20
> > gets congested for a longer stretch min_rtts on new connections are=20
> > high and we're back to sending small TSO, keeping the sender overloaded=
.
> > Which is to say - I _hope_ this also solves some of Meta's problems :)
>=20
> Ugh, I didn't see the Sashiko report, it's only CCed to the author and bp=
f@, not to netdev :/
>=20
> The zero-check sounds legit. Let's revisit this after the merge window.

Thanks for the comment, I will take action after the merge window.

And, please correct me if I am wrong, the next eligible submission is expec=
ted from 30-June, right?
Thanks!

Chia-Yu

