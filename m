Return-Path: <netdev+bounces-299317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oOBTMMmDL2oGBwUAu9opvQ
	(envelope-from <netdev+bounces-299317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:47:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 372CB68353E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:47:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=q9jCHFOT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299317-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B1C3005AFB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0527A462;
	Mon, 15 Jun 2026 04:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17291E9B37
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 04:47:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498823; cv=fail; b=ZZroCtzTESN+PkpVdfvJ7nCLPv8Bxlno3qvTgfb2MVdpyMdCU44BMSe6TiPKAKb2Zckhog1+Ll5aWpQa8dmfiMdNpyPvurEgZq/MWYFPaid9QV4vuuVnEaoDUwROYnYk070cGYnoG8m6hrxOFsdXLMnqm9Q8zKv4T3ZcHPEyzGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498823; c=relaxed/simple;
	bh=zMeE52Mtz6XqsJ8QXwNSFrgRQJR3wvv4cbQ8KinseVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTwuuWp7RMsNFfq0ui3+KLUiTYukNLZMpIIMkGEP8xxLKQw/pKunPcQ8YB98tTvVCmFh57JnzCrH7E0fS3sDWapg4RmodbQ1IXzZ7QeFP1paifjJAhF8wXb00TYtmrF5AiNd+PVbvQmJcGNP5z373sNOc9vl8Qicv1YZKrIjFPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=q9jCHFOT; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoXj9HGAgoaa1AmI0ItQcHkFwfinhkRN4UwlRMIycV7K+v9D1wl3jY95s8lVtGa+ddgWvp1GaUKwq8/rJcKPiWtA0bQFNtL39jW0JWH4agWrvk+jgu7dINQhzTc9E0jZxP/oYNvdCsrf/anpz/waJfUycQjq1smtQvkXeAlA2Pw6bEEJ4jXTO16Ja/HXYkxCgwfFfVe5OG+otd5botyRvR2CxZShLfX6Abs1bOm3+P7GHjxuDBBjnxf0n230yIh4zkdVT9hbkEYisWur1OZrkx4o/PSyeAhk5MyNVI0SFESFif+dLMLA9qp1puAb5SDAEGW3/kv4SRGflPNvRePOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMeE52Mtz6XqsJ8QXwNSFrgRQJR3wvv4cbQ8KinseVI=;
 b=jrcOHi6THECp+glw4O7VmlFnlSMpnG/ikKbjZbnEO8x7ax4yIvyHQdZZR+BIk9ybZJXPoQtvsgrG/ewE2LURpLKuEZ4dWatPO8UYGc5IxPDtvBKPpA58xEj+9HyU4M2CO56a+aQPQ9ham0ylTzVJ3Lt6bMrvKf8cgm1MCA0PTxKw3BGaUhoz4B7z03c6RJAji2CPT/VWhw+3NSOwiYYs9z/OjaaRsOEH4C27OQS0YD3UOgzkQ5OxFKZXFBgEwkFDxXr9xzyOtki7Qi3IS3zwAQNzvWuYOA9HVUdHHHffv3ZMI/LpqVRVpbIkvNsv+jkn4dL93yZ/xagMUiKj5pVsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMeE52Mtz6XqsJ8QXwNSFrgRQJR3wvv4cbQ8KinseVI=;
 b=q9jCHFOTCeGjokgMhm0lDNMNLrA4TOTJlwfDI+xAuR3JIZje96is1PCqsXFLL355ql8e+dclvWleB7nrcS6cUiVfSJSbHxNUub7rbcVqZhSGmK45stSvn2TmXLIgqOe9Xy6q3aLZVUmaWaQ97SaD85S7pjj8X1tNlVPUHabclQZWHiDgM9o1rFM2QOjpAJU40u90Vp5TYfIR8iq8HrnQ9v1yBER0NcVWnTcZuYXpJn64VMaMIef1F8nUMDrS4foqcyraxQN2gm9mb/aY0dCIT1U/fUXs0WQ0IQTt7hkIkppo85+UL/DFf5Rgm0WJHyEun21t1TnohrJTkoOJtGz5Bw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7P189MB0808.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:11d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 04:46:58 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 04:46:58 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Eric Dumazet <edumazet@google.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	"syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com"
	<syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
Thread-Topic: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
Thread-Index: AQHc+nPDQx+MvdTJDEy+XThdr3soDrY/DtoA
Date: Mon, 15 Jun 2026 04:46:58 +0000
Message-ID:
 <GV1P189MB1988D04323C9A618B95A2ED4C6E62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260612135949.4010482-1-edumazet@google.com>
In-Reply-To: <20260612135949.4010482-1-edumazet@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7P189MB0808:EE_
x-ms-office365-filtering-correlation-id: 44eff51d-319b-4f77-bc0a-08deca9921e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|5023799004|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 CBWkCtxdn0JywGvI7OygdFvllWr07XfSNyHYfMdJrUIFn/30AbnTktXEfdpjzC+ahrkgQAZ6dk9Cu1Aom8mwOcx5yHmfTXO59SPHtKR1OWxUol6DwCO1CGzGkh7DjC1qmqqPzbqNMTkrltGq6KdbBUbBqnmXtoAv3tEvSh6aH+gkGBqDJQmbCe28+b6X+ZSIXvLyNiKFl5YoYz98RStf622IA05gjjg4qLT3fZnPOpfZ/3+UdojTeV8VDxxoGiCTRI/XjuccBi9zRcSuD4j7l+CHbwklOvxsW/teZ5tMb1m4Le7MO4SpfzUszcC5OGjWtQvyZLd/OSiPZWO42ZVlbhn7euP0CDJc0fwjusFeVzOqUHgZDoAhxhePs3z5nlCreroEerbyqxwc8NATImRxNvpLIrdSHswoJl8JEz8+EOIA5q8KlwWb0V/VIAF/R6Nye/yMfBTftJnEdTvxN7KNm12fduwuxKea76oOc3jCyVWdI5tpxxMNdtT3MUdjjYGHy2bjEo0gLOaPe+GxNMArInWwrD+2P8u3qpInf/WuLtVj/xssnFeBxtF3r6Mw71jbSP6E9l6QCQxLmGd1pa/v1AtmgBBbETtCKxtM0X5hUpls25gOqRc3ts1u2jfhs5k1yxhnULqg1wRd2o5lmr6J4rBLMdtS454dTEdXs8E7zIxxVP70UDLe/sbybhio/xlIbZ5ePYkWRIaXdI3n7YRJi76hmz3h/tKaPoeOZoBSnhtdWycCrxvnwo92y7NzFBGw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2dseFpCUHhzMkd5UXhBZlFoOGc1RHFEb2dIait2NmdnQ3NMMlNaV2VIRHRj?=
 =?utf-8?B?ZXUrR0JKTlNjWlpTdkgwVnhyTVpQZkVrM1ZnOForR0VrRDlsRzRJemxvVndP?=
 =?utf-8?B?RkNrMWtPQlZZTmJIQTlZdHZ4RGh0blpmczNSMVkyTEJJdHRtZWZUOTdTTlZz?=
 =?utf-8?B?cC8wUnlqa09QajJMcHlNM05nRzlJWWt3akVtcjhxNm9NaDBrMkdvdCs3RjRa?=
 =?utf-8?B?dGRVcmlNb2hBQml4QzQ0VkhyY3V4bnFvUENmamtHMXVUNFVVMmZvTWQyU2V1?=
 =?utf-8?B?Y1hNbThzU3pwb0Y2Sjh0S2lHMWV5OS9XK0dmWFZRY3pWZ2gwSFVyci9GSHps?=
 =?utf-8?B?RmNtbUh1MlB5M1dHRmk5ZnNCOXhOM21Mem5hKzVlWHUyaWNUeko1QUo2eXNC?=
 =?utf-8?B?UVdhbjcwTHA4WlpLbXQ0SFJYYk0wSS80bkdmcE9udFgza1NxUGtBOVZXMlFn?=
 =?utf-8?B?R0lUMDlRT3hzZ0V3SUlVRGpsZDgrZGlCblF1VlBjYVNvOWx2cFNreTJHSThq?=
 =?utf-8?B?RVM2Tkkyd2Zybmo5NDJ5Q0NCTlZHb09OTXlIMkN6dDVmd0ZycUNhS3F3TzRu?=
 =?utf-8?B?c2YrVThRaDFzd1lKaDc0TVpXNmkzbTJsZkJLRldkQ0QyVE9aYXNUaVV4S1FJ?=
 =?utf-8?B?TTNGQkw0K1QyS3p5SWE2UW1DYm03MXVVVHd6Qld3eHNzUEw5NGtaMnl6UWF2?=
 =?utf-8?B?N0tiM2FSUnU3c1JsbENXWXN6aGY1TzRiSzZwYkpVU01PVHYyd0Y2L1lIaDlk?=
 =?utf-8?B?MGg5VjVyZU5nOGtWTlVuaXN2d3RCWVlFZUl4Uno3aFRVQVVReklYc3k4Znho?=
 =?utf-8?B?K2tQMGRIVG5GY2ZBLzliSzQ3cnI4VVI4SnJjMjZ5eFdRY3M0SlVPaW53U3B4?=
 =?utf-8?B?ZGJCckxXYVYydDZvMTl1YzJVNElBMEtkZjNhYS95TmY0aHNtVUdvRE5meWk3?=
 =?utf-8?B?Tlh5MTM3RllBOWdXN1orbldieHZNcWRFV3BxeEhCSWdqR00rSjZvUTBmMThk?=
 =?utf-8?B?Tlo3SW5HWklMWkszZDhuT0h0eG1zRGROZ2NKTUZUV3J2Uys3THdEQzVnSWZO?=
 =?utf-8?B?SkhSaHBPa21jU0lLa2ZmamdUWWhTM0dlNUkrbDBVUWRQV0srTEQvcEFpL3lt?=
 =?utf-8?B?VDFhV1c5S1phOHcramNkNkExMlJiT0NvcHNSMktib1RGbVJ1QTZ5ZCtJcUpI?=
 =?utf-8?B?V0t3WWZ3OHpBL3RwYXpZNHFEZWo0bklqTUJGSmVGZzR1M2draENXNUtDYkNX?=
 =?utf-8?B?Z2ZUcE5TTHZmSUNuODZIRDcycFFkNkdmNHF4UnVqQkJ5ZHgvZWlEaU5MTnRF?=
 =?utf-8?B?bFUzeVgwb1NzZkpqejFXbmgrckhyWGpsZDdYYlEzL2x3RE9yMjM1Q3F1ODdy?=
 =?utf-8?B?ZXoxaEE0MUI5Sk52b3FLMmhLeXFUMXZnM3Z3OStmNDVXbkN5N0dYRExDSmFV?=
 =?utf-8?B?WTJtSThKTWtPeHJVQkpJTmlEWFBXVC9GRlJrNjVWWUs0OWNUVUJhRkdXLzlH?=
 =?utf-8?B?T1Btdys2MEZxa3MwSnh4NmZ2RUt2U2NiODZwNEh2Q1hEVEE1ZU44N2h3c1Rt?=
 =?utf-8?B?VkpJeG9wM2RiZ0tzVWNJVTlzWTVVeGZLNlU5eUhjRjB0aFpKVmIrZEJ1b3J2?=
 =?utf-8?B?b0xGZjBhWHlRK1pyRTRLUERNeHplV0lTeDc0RXlxdFQvQzlQd1JMTWVGTW8r?=
 =?utf-8?B?OUQ3RnIyc0thQVltRyt1SU5vcjJ1NWFieDd3bnppYm1QR1dTNjRyN2xvNjFB?=
 =?utf-8?B?RTJaUDNadC9kYWxjblVhUmVMN0swQjVDb01pWU4rYzlLZCtXNGdNRkozM243?=
 =?utf-8?B?WldabjBVbm1yNDZCWEhnWXMzY2tuZjhrMnhIVDFYdWlQTERsQTBNNmJjSkli?=
 =?utf-8?B?djNMS2RCSUZUVjBXWThDeTdtb05vRnJZcjByWlNDWDducDR6RjMrazJQbjl4?=
 =?utf-8?B?UE1KenI1Vi8vYUtzU2tBSngrZEFUNmVvbnpjS25MS08xNEpodm52OVc2TTU0?=
 =?utf-8?B?RUhSQ2ZoVHFjaVVxbTJKUXhCZENONmZyTGx2SS9hVHVtbHJHSzNmaWpTdkFy?=
 =?utf-8?B?TWxlT21vVnVpR0lOQ2FDdGo0dXpKR1VtanRGZ01KQnZWSlBXUUJWY3hJNjJX?=
 =?utf-8?B?Yysvc0JMRVJqa3ZFcUNuUEJpTGdQalNpSDlmbnhOSXpnMW5PRTJYbFRlV0JB?=
 =?utf-8?B?bzMwQzBhQ09SREJydFgzbXVpdHpzK1ljTW8rOXpCUkd1SzBGQ3lVWkZCempL?=
 =?utf-8?B?Zk9SSUdaVzFQWDR0b25aYWVCVGFPWVk5d2RvVnE0SEpBOHhMZkVLNWk2N2wx?=
 =?utf-8?B?dW9abFp6L0NZdVhuWS9mVU90RUV3M2JldmVTSWQ5NXI5N2pRS05MQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eff51d-319b-4f77-bc0a-08deca9921e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 04:46:58.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9Wc7dafawR+tulMUSZt7uUMKU0bNE4ZOPNPGkNo6SuVliJ2xLv7Qeltd3WJq8Bj69N/z7Q7yFpJR1fVUFTHJf8UTwUbFmn3cfYCWjgJozY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0808
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,redhat.com,davemloft.net];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,64ec81389cbad56a8c35];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 372CB68353E

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIHRpcGM6IGZpeCBVQUYgaW4gdGlwY19sMl9zZW5kX21zZygp
DQo+DQo+U3l6Ym90IHJlcG9ydGVkIGEgc2xhYi11c2UtYWZ0ZXItZnJlZSBpbiBpcHZsYW5faGFy
ZF9oZWFkZXIoKSB3aGVuIGNhbGxlZA0KPmZyb20gdGlwY19sMl9zZW5kX21zZygpLg0KPg0KPlRo
ZSByb290IGNhdXNlIGlzIHRoYXQgdGlwY19kaXNhYmxlX2wyX21lZGlhKCkgY2FsbHMgc3luY2hy
b25pemVfbmV0KCkgd2hpbGUgYi0NCj4+bWVkaWFfcHRyIGlzIHN0aWxsIHZhbGlkLiBUaGlzIGFs
bG93cyBjb25jdXJyZW50IFJDVSByZWFkZXJzIHRvIG9idGFpbiB0aGUNCj5kZXZpY2UgcG9pbnRl
ciBhZnRlciBzeW5jaHJvbml6ZV9uZXQoKSBoYXMgZmluaXNoZWQuDQo+VGhlIHBvaW50ZXIgaXMg
Y2xlYXJlZCBsYXRlciBpbiBiZWFyZXJfZGlzYWJsZSgpLCBidXQgd2l0aG91dCBhbnkgc3Vic2Vx
dWVudA0KPnN5bmNocm9uaXphdGlvbiwgYWxsb3dpbmcgdGhlIGRldmljZSB0byBiZSBmcmVlZCB3
aGlsZSBzdGlsbCBpbiB1c2UgYnkgcmVhZGVycy4NCj4NCj5GaXggdGhpcyBieSBjbGVhcmluZyBi
LT5tZWRpYV9wdHIgaW4gdGlwY19kaXNhYmxlX2wyX21lZGlhKCkgYmVmb3JlIGNhbGxpbmcNCj5z
eW5jaHJvbml6ZV9uZXQoKS4NCj4NCj5UaGlzIGlzIHNhZmUgdG8gZG8gbm93IGJlY2F1c2UgdGhl
IGNhbGwgb3JkZXIgaW4gYmVhcmVyX2Rpc2FibGUoKSB3YXMgcmV2ZXJzZWQNCj5pbiAwZDA1MWJm
OTNjMDYgKCJ0aXBjOiBtYWtlIGJlYXJlciBwYWNrZXQgZmlsdGVyaW5nIGdlbmVyaWMiKSB0byBj
YWxsDQo+dGlwY19ub2RlX2RlbGV0ZV9saW5rcygpICh3aGljaCBuZWVkcyB0aGUgcG9pbnRlcikg
YmVmb3JlIGRpc2FibGVfbWVkaWEoKS4NCj4NCj5GaXhlczogMjgyYjNhMDU2MjI1ICgidGlwYzog
c2VuZCBvdXQgUkVTRVQgaW1tZWRpYXRlbHkgd2hlbiBsaW5rIGdvZXMNCj5kb3duIikNCj5odHRw
czovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvNmEyYzEwMDcuNDI4ZmZlMjYuMjU4YjI3LjAxNWQu
R0FFQGdvb2dsZS5jDQo+b20vVC8jdQ0KPlJlcG9ydGVkLWJ5OiBzeXpib3QrNjRlYzgxMzg5Y2Jh
ZDU2YThjMzVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPlNpZ25lZC1vZmYtYnk6IEVyaWMg
RHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj5DYzogSm9uIE1hbG95IDxqbWFsb3lAcmVk
aGF0LmNvbT4NCj4tLS0NCj4gbmV0L3RpcGMvYmVhcmVyLmMgfCAxICsNCj4gMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+ZGlmZiAtLWdpdCBhL25ldC90aXBjL2JlYXJlci5jIGIv
bmV0L3RpcGMvYmVhcmVyLmMgaW5kZXgNCj5hM2JkMWVmMTc1NThhMzc3ODdiYjkyZjJjMzgwNWMw
ZmRhODc0ZDhhLi4wNWRjZDJmOWU4ODdhNmU1Y2E2NjY1YWI0DQo+MWU0ZDViNTEwN2YxNThjIDEw
MDY0NA0KPi0tLSBhL25ldC90aXBjL2JlYXJlci5jDQo+KysrIGIvbmV0L3RpcGMvYmVhcmVyLmMN
Cj5AQCAtNDgyLDYgKzQ4Miw3IEBAIHZvaWQgdGlwY19kaXNhYmxlX2wyX21lZGlhKHN0cnVjdCB0
aXBjX2JlYXJlciAqYikNCj4gCWRldiA9IChzdHJ1Y3QgbmV0X2RldmljZSAqKXJ0bmxfZGVyZWZl
cmVuY2UoYi0+bWVkaWFfcHRyKTsNCj4gCWRldl9yZW1vdmVfcGFjaygmYi0+cHQpOw0KPiAJUkNV
X0lOSVRfUE9JTlRFUihkZXYtPnRpcGNfcHRyLCBOVUxMKTsNCj4rCVJDVV9JTklUX1BPSU5URVIo
Yi0+bWVkaWFfcHRyLCBOVUxMKTsNCj4gCXN5bmNocm9uaXplX25ldCgpOw0KPiAJZGV2X3B1dChk
ZXYpOw0KPiB9DQo+LS0NCj4yLjU0LjAuMTEzNi5nZGIyY2ExNjRjNC1nb29nDQo+DQpSZXZpZXdl
ZC1ieTogVHVuZyBOZ3V5ZW4gPHR1bmcucXVhbmcubmd1eWVuQGVzdC50ZWNoPg0K

