Return-Path: <netdev+bounces-251470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDWrCJBqcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:56:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11D51C56
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 123B366337E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730841C30C;
	Tue, 20 Jan 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="l423c05d"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35550345CC7;
	Tue, 20 Jan 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910731; cv=fail; b=Bpp86lgM2Qzwcpnj4Pbzvzk2lRvdnzq5rNtud9c89DDWHOSdQrIafbMQFaE6AzLEoXjh6HeFpLh7u8uTwzvZUSZEzi80dUbAyYv4proA8iCmDtQQO/4xveIzy+906/68TCO3hKS4/TX/EdTui3Ru54HEBfKa5VgPff7NMaUAoV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910731; c=relaxed/simple;
	bh=iWtkzKvaMVSoN6V75njry5hCJGqDsbfqtYk0vKOb23Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDL1E6X4kW5S9FBvQRZ4D/cK04q5oSiNhkEAnCaiw6tN4Bl/ghvQc0diwFvOPOmINprwCwEh8E2atQ1j5FYIc/ySJrX3sw2QBuUhNzShVgKIQCZjhHAkREXfrktkKszr6+YOhxR/RmF48MYTXG3tEp3jXJHnnP/pOaW9rOcSD6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=l423c05d; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqAII+YhOo6ioRq6FGo+RBWIP07UXxJlsYfmS/9doKlfi8+E/tksYftHYBaACYPdEcho7Zpo4Q7Np1bua28XwZos6XyrQrdozFeLKDm4CXaaWzLeHF8/ijrNP5L878r35YOoOXlZlEsxwTrRqsrAWEIhaRiKFC/pNnLWHmwuE5TN0hnxF/85mSzMeJAMUDu40JZrhwIF3Wt9rT93w6D5jEYNBaOIXPFsY9vug56s1oPsuC/5qKa9uiiqfU0EzuORWuYK0Mz8qZ9FVdKIMQMJIkAf7gVwSuJXsdZWkFEhHeTPJCd9i7joh0Wowu4Z8dXJfMNEtPYT6xZ/K6ylmHJn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWtkzKvaMVSoN6V75njry5hCJGqDsbfqtYk0vKOb23Y=;
 b=o7qXdM2fo4n49Bj+2POriOPV+cxfb+UrE8qIV+MydFNzuAcWUZafgoBKPDMKAogm4Mc+YOlFXo8XU0A6/LG+0cmAmpitUdryyX3BQsovhfI0N8JH8HgrAkan6LEtLy8KH/DLHno7vHwo3AkFj0OzcKGKCReEyjnelMgkyl4RWi0fB+IwIw85W5RWF1c8xhY8cucso0glHdowQ1BsIwPbpHBJnwCmL2TWZroLXKkpqDy6FxFKvYZjWYeSbHNhsyHrxJ/MJX5jaclzSRFq3mUZcooC5RtWJCK1kEt3fKS1bIyAT7ZhRzq6DB/46QiF4vMtSB+ihrclu0z/dJ2nStTP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWtkzKvaMVSoN6V75njry5hCJGqDsbfqtYk0vKOb23Y=;
 b=l423c05dMmAyZ/u34lBX9iW/Inm5MtCg1THl766C9Mld+qhvXyZlYk3Qa5yAMsth43htUxf/Svjud8d7eSUAUHuG4jcuYZvc/qHeAhi6XlW8iqi/aHay44aTI28VzmBsV1tu1zqsQlhKTgvp5jzbLJEXfig4zoVcPrFLabIgcqrdS9Yp8yqgHTROLQWOZEDvmeV2WYEPf9KTkH7etL8B6Rwta59XxddkJHgT1BWEPtC66ZN04OaxwwHVG/VHr+NMndUO/cV8xGGdjpFPorRlDUdDIIqRZy31+LgX2Hiqxw4t4+wFYn1yHtbwZ7p35h74qWWX6uh2pOMaSyz1tmMsIg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB7838.eurprd07.prod.outlook.com (2603:10a6:102:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 12:05:23 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 12:05:23 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com"
	<parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
	<kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
Thread-Topic: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
Thread-Index: AQHciXW+EzR6VjUDV0Gw6kc/N9piqLVa6fUAgAAFJOCAAAXUcA==
Date: Tue, 20 Jan 2026 12:05:23 +0000
Message-ID:
 <PAXPR07MB798488DE2DD7C67F7DFDF550A389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKhAs3rMWFdmM-rma1wS-Xd7mf9PBUQKL8YMKhB81Jkkw@mail.gmail.com>
 <PAXPR07MB7984BA30924000787013DD26A389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To:
 <PAXPR07MB7984BA30924000787013DD26A389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB7838:EE_
x-ms-office365-filtering-correlation-id: 02f38243-c891-41ed-b133-08de581c3104
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGdlN3pRVDlEV1hNZGtqZ1Q2ZWhZZzhDS1JtQmdhNk1PSVYyd1ZrR3ArYldl?=
 =?utf-8?B?VmEzZmZwUlFsMVdOdmkyWXNKMnF4ZnA0OTAzeEZGcVJ4QkM4Ymw5bWhJNm5Z?=
 =?utf-8?B?TU5zb0VSSXE3dXB1aitNRzZZNkNsWGlaU2N3NkFKZVIvL0hQbDR3anYrVUt2?=
 =?utf-8?B?R3BLQTd6aEt0U3VjbVBjN3d6RHArdWxkMzBoTXQ4NzlvYlgxRWRJQVBSUlFp?=
 =?utf-8?B?eVNWMGRtYlVoN2JGWm9NaXhrbTJIUTJiZjRiUjVzZGdNRHJOdXFweGl3V29y?=
 =?utf-8?B?azlkaEZRR2V5S041ODlqNmZkL2wyRTM1cUltbGpMNnlNczBYc0hRRWFYQjB5?=
 =?utf-8?B?akxvMmVlazhMS0xXcDFTZGYwc2pZN0VJNmJnbFBCUEt5ams1bDFPeVEvS3M1?=
 =?utf-8?B?azdGMG1YUTVDNkEwTVJ0dlNCRWR1N2NLdGorR1dkenV1b0F5R2NXWTFTRFFX?=
 =?utf-8?B?VUthYk5DZHVjckc5Z2dqOGRKTjArUnI0TmRvVlo5S0c0aDJxSnBDbDlmTnZs?=
 =?utf-8?B?OFNsclJhdklSdzBIMTBNbVBzcTh4TzlObzFKTGx0OHJ2ZHpGdHhBbFpSLzYx?=
 =?utf-8?B?Q3h2RDhoVkZaMk05eEtSREthZHRDYzY5NkJ5NmQ0dFJJZnU3NTg5UnMwL0dz?=
 =?utf-8?B?d1Rkb2FmTkZkVDdYTHZVTjhJVmN2aFBQY2NQME5GUW85UUZMSUpYVzlRbjJO?=
 =?utf-8?B?L1dDZXIxWXZ3N1JNTjBHWEJ4dWFtSUNBYmVZc2Z5VWNUVFYwN2hSd3JwRWxz?=
 =?utf-8?B?cm92M3RxMkpPL1djYlZkTXdwbUNIV0o1SWR2ZDEydXNMRzVQSXR1aXZZWFRE?=
 =?utf-8?B?N1E3Y1AzUU51V1hCWU90TTQrNWNYcEp3RUEyR1VwK0x5REMrSUU0SmxVTmJR?=
 =?utf-8?B?cCtabFZSaG43aTRiMnp1TkxNenorb01nZVNGOWFNVTV4blBVUkg1eDdXQnRy?=
 =?utf-8?B?V1FBUmkrM0hNYlFPSDB6cDJZOFM5dU9lS3dCSzU2Z2lkbHQyRFB4bDMrOGRC?=
 =?utf-8?B?Ymlwb3ZPUGYwZDE4eE1HaStOVXVvVUVTNENRQXJ3aGh2MWZKb0IrM0tmbXFZ?=
 =?utf-8?B?T0ZRQTFpNHVWYVpYbXZ6Z2xQUml1WHdEZzJRZ0p0MURYNU9sRWIzNS9xTXlk?=
 =?utf-8?B?RXB6UmhVOGxhR0RaYmNYcy9yTVZtSkdEZUhQMm81N0FkdFl5SWwxT2FQdkZx?=
 =?utf-8?B?bFJCSFM3bnBhbG0wY1c4cXg3ZnNZQ3dJOFBud2dvV0N3ckpXaGV4ck1FMkI4?=
 =?utf-8?B?cTBXbDNLeFg4cmdDS0Z3c3RvbWptMmRCYmdwYzdPaVNLUWRjS0JBazd3a0FX?=
 =?utf-8?B?b3ZZUmpTcURQelNrWit2Lzd6YkkwU3pMbWdNRkFwK2xGR1Q2U1NZdjZsTmFK?=
 =?utf-8?B?blVFQTNKdGpKTlc3OXRjQ3JvdGlDZlBiVVlGdlViR0VFUlR5WDdNV1lUWnR4?=
 =?utf-8?B?NG5jcUlubTRBYXJhVW9meGlKbWd5U0ZFQmREb3ZUOFRMbk5jSXpvTGQyY21k?=
 =?utf-8?B?VWh3ZzYwQmFUS0xYUzVlTWw2ekFVTnpadnR0dHlQVlZMUVd1dnZIS09Ic3VC?=
 =?utf-8?B?SlN4ZnZhMjZUekdDb0VRK01kM09ZT3J4OFJsd1ZDTVpOb1hLQ1lLSWJmc3dH?=
 =?utf-8?B?QS9MYmlNQmVOQzRuNTFzZHlCV2xmYVBtMXdHV1RxaDU1U01sajZmalB1WHdr?=
 =?utf-8?B?NmIydE4xbFZyOXlVQ09LT1Fsc3h1eXBwWmx4QnpEUzZyUnU4NnZhSTVuVGRm?=
 =?utf-8?B?bmtKQUErYkUxM0RJRUhtYTE4dHRxQTFORjdJckQyRk5nZnJFM0tad25KMDVt?=
 =?utf-8?B?dTd0NjJEN3JnSGswSFUyajlLVlZUYjJDZDhXTmU1REJnS2lnb0pJaSszYlJp?=
 =?utf-8?B?L2JyUzdKVjFRS0F4dkdTUXVxbS9UTHdqU05teEVWZS9DU2x3ZFFEeXhJQUlK?=
 =?utf-8?B?TDdBQTlwdEsxYitCS3JsdmFUMmpWbmcrS0xMOTVJdGVGVnl3MUZDSFhrWjQ1?=
 =?utf-8?B?SDJsL3p5QWlzbUwzM0dqdHI3cXlaOFJDcU4wZmZyNytOVW5nNE9pSFRmc3Bu?=
 =?utf-8?B?UEdPZVVEdzhlaEhUWlAzRGkyQjk1NEtFUWpBcGNXR25Ba0FSbldHYW05NDZ1?=
 =?utf-8?B?MHBWRU1INHl5SER2dmhtZ01MM0xOWnJFakd4d2NOdDB5bTJ5cjRNdUdFeklM?=
 =?utf-8?Q?/IbT0rskXgKvYZifLgnDTIM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFdoTVptYXdRRUV2YlNhZHVEUWZnMEE0Mi9UMVNyZktSYUU4OEhzejErandX?=
 =?utf-8?B?WUpITDkrV0Z2aDBzMG95S2F5UHNYMUM5RmNiUllVcHRYOExjS1pjRUR1USs0?=
 =?utf-8?B?aVFMdzR1Q042VVgwejFQT2thYmtFYitMaTFPSWkwZExmV3cwUTZHb1ptZDF5?=
 =?utf-8?B?YVYwWFhxeEdwVVplSFRhdUxrbFBMRmtSV2dGOGZtNUh4bC9Cam9jV3J6T0Jq?=
 =?utf-8?B?QWZmaUhmcEM4dkduSm1jdVdKdXQ2RGloMTBTNjV0RnFORlJlcXpWNDVvQW55?=
 =?utf-8?B?UjlKUUY4Q2gra1lGVXBiTVk1a0xPYkh3bmVVaFJuZTZ0SlIrNDZmczBKUzdi?=
 =?utf-8?B?NnNUanNXTXZkR0ttTXZXSWpCdUJIZHhOOFZRRG81elEydlorVVNWRElJeW1p?=
 =?utf-8?B?ZkpBTGJTV2hUUE5IQnpVZHY1WURZNFJzYUV3RUNXYTFXeXNsdHVNd0xjTjkr?=
 =?utf-8?B?M1ZBSHNQV0lNNFZiRHJuUVVuaVphaTR5R0ppakVSakt6YjByeThLVlVoTjR3?=
 =?utf-8?B?eXJnRU41ZXJsc1ZvOWtPZllDd0RUeCtreFd2dDZwNXJWSE80RnF6ZXBUZ3dS?=
 =?utf-8?B?dlhSNWZFNWt0cTdxaTA0eDBQa1VRd0tDQnJ5WjBDMTcrQlpzMjd1WlcxOHFq?=
 =?utf-8?B?Nk1OQjFUK1JJKy9EczM0QzdvQXc3UGh0S0JRbWd0d2tUU1FlcWEvOTVXNmw1?=
 =?utf-8?B?VEFBay9jSXhLQkZ6aWJZckNxMFI1eWJTTUN1akgrTEVBV25IZVhTb3ZsSVBI?=
 =?utf-8?B?cE9XYUxzUGZudjAwZVpwN1pac1ZKbFlLRkx6TDBBS2xFZXI5U2hoZG02aUk1?=
 =?utf-8?B?b2QzOXgwUW5WWlFreWhFb0xTMjVjVWlvUUR6VS9GU2I4a1lQTEpFcVp5ZXFZ?=
 =?utf-8?B?VyttNU5BL21DbEM1UkdpcEpZVDhNaHVCZDhkOTkycmtlN2t1Q0UyVFgxOGFF?=
 =?utf-8?B?M1hQYzd4TExWaEhBSHlocFBVb0toWkFZYitMQS9OSkZmTWRnQnhsZStsbFJG?=
 =?utf-8?B?WmNHMTZNV2xHVVhQMTRiYWZ3TjloZC9adS81YkZIajNnSDhKc2I0ci93SjIz?=
 =?utf-8?B?ZlhxZGkxVmpFSG4xQmVCOGs4R3ZzeEtsMkw4QzlJSU5OYWFRV3NURUJ6TkNF?=
 =?utf-8?B?TlgwaWxkRGg1b00xZWIxb213UEdRUy9NczVuRUVFOUtPZVBPWWxad1grdm1U?=
 =?utf-8?B?Q0pKdnFhMldtdDBjTkxQYkFWSFY2dkdDdUo0QmdSU3kwUTN1dWxQRVo5MTh6?=
 =?utf-8?B?dS9QZTVlNHFibmlNRTAyTjluNkFpc3ZtUzl5QW5OVmw4WGlrUEI4YkFFNmJ6?=
 =?utf-8?B?TXdZQWVyc2pQOTNnUnJjQ2JvUE05aEdUQkU5K2RnUzZsdWFrWFFnUXNFR0tw?=
 =?utf-8?B?OEtyR01DaVNReFBpSFdZMDJQV3htQ0pUOHF4SmJBWEQ5RTlBakM4SFdDUkpD?=
 =?utf-8?B?MnlhVkdXZlJDZE9vNFphQ2NnUmNtblBSNkF0Z3NWdTlkMTFWNnVlNHNFRWYr?=
 =?utf-8?B?VmpiWTQzQTNjU0U5OEQzc1hMNHk0Y0RHc2x0MlQwY2t1R01kQndKcTFZVnRi?=
 =?utf-8?B?V2UrRzFyUFM1QzJsb3JleFZ3TmE2N05ZQlI5d2M2cHRkLzdEczV5OTkwMWZQ?=
 =?utf-8?B?WmdEaFJDOVB5QU0zU0J6bU5OTWdBdUg4KytTOWRaS1NiekxacWIzV1doQ3p2?=
 =?utf-8?B?Ty8yK1RpUWsxS2x3dDFFNFJ4eXBTWlc5TXVRaWFTdERKcWtRdDdydHNETE9z?=
 =?utf-8?B?T1E1RWNVZkM5K2VXcmtsblp2VytjUzZTb3hsenFqQVZaaU9Qb0RNSkU5NTgx?=
 =?utf-8?B?cnZGQVExblVySU4yOS9sRk43M0t3cUJPWC9nMWU1ODMvL0lOcS96RmFaM2c5?=
 =?utf-8?B?WGNxTnRza1NuOERwL0J3dVNtMTlxQ01pU2NrS3JPSEZaeWY0Rm5vSkdaVTBM?=
 =?utf-8?B?R2prdG5qd0ErVHNWZ1NraDdzQTRLNjE2Nk5mRE5PR0tMdmczaEk2TzY2U05a?=
 =?utf-8?B?YkE2N3ZTeFhnekVqZEVjTnpSUktkVzkzTDBvSHpSK0VuYkt3WVFrblA1N3Na?=
 =?utf-8?B?UlFzVUxqcU9CamN5NXI4ZjE5ekloZlZLakNqMHZkVzNIY1lvalBPMTN5NkNy?=
 =?utf-8?B?eUEzVnlRUDdLYUtCZU5TSS9JVCtZVHRLQ01jMHRKRWtZaHl3Z2sybk1QdTNZ?=
 =?utf-8?B?V2VXWFJ3N0Z3V0JaVmF1V1NldWdvdWYrQlcxNnJncXJ5dHBieTkvRVVYd0FF?=
 =?utf-8?B?NzUzYmNOSlpsZ0gvL2JGd1creUdrSnEyMFJuT1pTSzJZRmJkVzZRb1ZQckVX?=
 =?utf-8?B?OXJHcVY3eUYxNjZDT0pPUDl2TG4xenVOWk5waUwxWXVTbFI1Q1NVaUR5aG5S?=
 =?utf-8?Q?eMXWZzBlLYRdIEbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f38243-c891-41ed-b133-08de581c3104
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 12:05:23.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 068C1USHM8xcqsINNVyxHqBofnqZpvPZuxK/ciUT5uec/0X35lfi+K88ME+1Zwr26XMK62HmYlvGIdfyTwaa261CaT7/CVoVoulJnnEVDVP0PPDLxTh1NvFqRSxKnL6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7838
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251470-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CA11D51C56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGlhLVl1IENoYW5nIChOb2tp
YSkgDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgMTI6MzggUE0NCj4gVG86ICdF
cmljIER1bWF6ZXQnIDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBDYzogcGFiZW5pQHJlZGhhdC5j
b207IHBhcmF2QG52aWRpYS5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBs
d24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBnb29n
bGUuY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZl
LnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBo
ZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVz
bnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9u
YWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5j
b207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlq
QGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tp
YSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVs
YWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdp
bmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZSA8Y2hlc2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBn
bXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29l
bEBhcHBsZS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjkgbmV0LW5leHQgMTMvMTVdIHRj
cDogYWNjZWNuOiBhZGQgdGNwaV9lY25fbW9kZSBhbmQgdGNwaV9vcHRpb24yIGluIHRjcF9pbmZv
DQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRXJpYyBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAs
IDIwMjYgMTI6MTggUE0NCj4gPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNo
YW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4gQ2M6IHBhYmVuaUByZWRoYXQuY29tOyBwYXJh
dkBudmlkaWEuY29tOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyANCj4gPiBjb3JiZXRAbHdu
Lm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyANCj4gPiBrdW5peXVA
Z29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
DQo+ID4gZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJuZWwu
b3JnOyANCj4gPiBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdAZ21h
aWwuY29tOyANCj4gPiBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRy
ZXcrbmV0ZGV2QGx1bm4uY2g7IA0KPiA+IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmli
ZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyANCj4gPiBzaHVhaEBrZXJuZWwub3JnOyBs
aW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyANCj4gPiBuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIA0KPiA+IDxrb2VuLmRl
X3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IA0K
PiA+IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVy
aWNzc29uLmNvbTsgDQo+ID4gY2hlc2hpcmUgPGNoZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZA
Z214LmF0OyANCj4gPiBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IFZpZGhpIEdvZWwgPHZp
ZGhpX2dvZWxAYXBwbGUuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgbmV0LW5leHQg
MTMvMTVdIHRjcDogYWNjZWNuOiBhZGQgdGNwaV9lY25fbW9kZSANCj4gPiBhbmQgdGNwaV9vcHRp
b24yIGluIHRjcF9pbmZvDQo+ID4gDQo+ID4gDQo+ID4gQ0FVVElPTjogVGhpcyBpcyBhbiBleHRl
cm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9y
IG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9u
YWwgaW5mb3JtYXRpb24uDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gT24gTW9uLCBKYW4gMTksIDIw
MjYgYXQgNzo1OeKAr1BNIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IEZyb206IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEt
YmVsbC1sYWJzLmNvbT4NCj4gPiA+DQo+ID4gPiBBZGQgMi1iaXQgdGNwaV9lY25fbW9kZSBmZWls
ZCB3aXRoaW4gdGNwX2luZm8gdG8gaW5kaWNhdGUgd2hpY2ggRUNOIA0KPiA+ID4gbW9kZSBpcyBu
ZWdvdGlhdGVkOiBFQ05fTU9ERV9ESVNBQkxFRCwgRUNOX01PREVfUkZDMzE2OCwgDQo+ID4gPiBF
Q05fTU9ERV9BQ0NFQ04sIG9yIEVDTl9NT0RFX1BFTkRJTkcuIFRoaXMgaXMgZG9uZSBieSB1dGls
aXppbmcgDQo+ID4gPiBhdmFpbGFibGUgYml0cyBmcm9tIHRjcGlfYWNjZWNuX29wdF9zZWVuIChy
ZWR1Y2VkIGZyb20gMTYgYml0cyB0byAyDQo+ID4gPiBiaXRzKSBhbmQgdGNwaV9hY2NlY25fZmFp
bF9tb2RlIChyZWR1Y2VkIGZyb20gMTYgYml0cyB0byA0IGJpdHMpLg0KPiA+ID4NCj4gPiA+IEFs
c28sIGFuIGV4dHJhIDI0LWJpdCB0Y3BpX29wdGlvbnMyIGZpZWxkIGlzIGlkZW50aWZpZWQgdG8g
cmVwcmVzZW50IA0KPiA+ID4gbmV3ZXIgb3B0aW9ucyBhbmQgY29ubmVjdGlvbiBmZWF0dXJlcywg
YXMgYWxsIDggYml0cyBvZiB0Y3BpX29wdGlvbnMgDQo+ID4gPiBmaWVsZCBoYXZlIGJlZW4gdXNl
ZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNo
YW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4gPiBDby1kZXZlbG9wZWQtYnk6IE5lYWwgQ2Fy
ZHdlbGwgPG5jYXJkd2VsbEBnb29nbGUuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTmVhbCBD
YXJkd2VsbCA8bmNhcmR3ZWxsQGdvb2dsZS5jb20+DQo+ID4gDQo+ID4gQXJlIHlvdSBzdXJlIE5l
YWwgQ2FyZHdlbGwgcmVhbGx5IGlzIG9rIHdpdGggdGhpcyBwYXRjaCwgc2F3IGl0IGFuZCBnYXZl
IGhpcyBTT0IgPw0KDQpUaGlzIHdhcyBkaXNjdXNzZWQgaW4gYW5vdGhlciB0aHJlYWQgd2l0aCBO
ZWFsOiAiW1BBVENIIG5ldC1uZXh0IDEvMV0gc2VsZnRlc3RzL25ldDogQWRkIHBhY2tldGRyaWxs
IHBhY2tldGRyaWxsIGNhc2VzIi4gQW5kIE5lYWwvbWUgZGlzY3Vzc2VkIHRoaXMgY2hhbmdlLg0K
QnV0IGl0IHdhcyBteSBtaXNzIHRoYXQgbm90IHN5bmNpbmcgbGl2ZSB1cGRhdGUgb2YgdGNwX2lu
Zm8gaW4gcGFja2V0ZHJpbGwuDQpTbywgSSB3aWxsIGZpeCBpbiB0aGUgbmV4dCBuZXQtbmV4dCwg
dGhhbmtzLg0KDQpDaGlhLVl1DQo=

