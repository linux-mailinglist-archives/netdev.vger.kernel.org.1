Return-Path: <netdev+bounces-277946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IW1COJd3Gn0PwkAu9opvQ
	(envelope-from <netdev+bounces-277946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:07:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729313E6E04
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CD633007C99
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FA1AE877;
	Mon, 13 Apr 2026 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="HuGOwBuF"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D140DFAC
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776049617; cv=fail; b=Y1JORNC2XbqzpNi4mSQb3gVy8JKTjpi+6LQjSy7nmnAEAVoFJYeV8bGMIS3Utc6dwDiQ7RTDndn9NdcfTHJY9ihhhyQUHON9Ex5Hp5lhL/dtyhePJkbAMZAetMXviTDjsDbXXeLdFktHAg6M8MauF/eq994NIDzsBr8izj5bHoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776049617; c=relaxed/simple;
	bh=pNU3SzB4b/hKwHAckjIRW4Qe5OqYDCQNtyr3lkdGpEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2dVu4+ou/gzq/tzdsZMINDBjWuBjht15WeTbtQAr4itOk+KZ/++6ErHo2K/dxdJZ6BjT5feexsnb2l1NWYAg3/La+F7CLSG1hm8sJ8i03JJZBjhmGkWghg77uU5CqiTO9rIMArR95OvHa1zHBAmDyB6pwKDr/cmZh3+/Srr96A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=HuGOwBuF; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzNzPb/5lEfF1UZI2kFDM7tZVCfm2iWZqyPxGTDoH3DuSSd2c2mkQxzVuxUfeH6rX7QL6STGGR/uPOp0hHSd2Uk/tqrjBb0OrXYchb613+OwNABfq8fYfkL+daRUUd8/Dn+04S9H0cLdtfHLLfP1wlZk8M02ffq28fNGk5c+CU5iCDENaSjjHvGJ7h1A/qmckbzzPG5NmT3vp3396l1V5LgwL3LdGavRGkd2K3Mcg3JhaxB4vwJ9wtfHKYkwamTpcDyDDvmMzji2aTp/NBAkV9VXkxdKmYOrifpry0mbzVzWl1XoeQtIaI/YtbatBpgq0HSlHCbGhmWjqo0mcyb0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSlv9UZjNPorjJlbf7n9iv9BQ2X+JvW9lzioOksF62k=;
 b=EHFmAmUupoyPcbD07EqomfMGeneXVW7/mAWy2aujOBB/82hK1ISsxRIX/Jz42soGH15TwGYD61C3hPxlNosx0Qv1Kp/g4+x06eeAPWwD9Sup9j4d+Kw2y8NXP4O5+VgGJlZNglKkUbP2e1e+pB6dqXsGG7Kf/slkAYTHJ1eG6YyBDlioX0r33PVKJPSNtLLfe0yqYhBH2GbWXYBYIyDIYiThbPSq8vdYjkqkpXHXE1xoLniCSDLbFGAwCARbDhgY/YtAP40SDfL8AJJWkIktMPFPR7KTxX//R4crRuTPWjtdRd5qhBbXmhCGd40QMKOiEsWMwmh14Ln87WSAxeVWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSlv9UZjNPorjJlbf7n9iv9BQ2X+JvW9lzioOksF62k=;
 b=HuGOwBuFMqiClNHboqe2xsmo0vZUALUqVpdJMldAjDEQFGP9M1QubysUS+x5QiPBlGXSto9W3f0wLNZSnxRVYiZ2xs2LVnzDZDWYzSDntZrpEn8CAgQkxjFjAHchXPbd2iQB739UuNWl9bj4o9YHNdXlqpNtO8anaJ0qNDRg0XatDuHcNv8+ai7sRWjgAO97D58y+A0Hi7p3mFI3CLYeua2vArgvru8iDCq4Z4FdEYGwrmQYQCzBXMU7QmDk5RLSEAq1W0LllqCWBybCUCmDIrC16MAWaP6EMOmrIeTuBvtAZQZcW3HPvo32S+oyMM0Qx52vP0GOWMGtMsb7L4rj/Q==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7P189MB0614.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:119::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Mon, 13 Apr 2026 03:06:51 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 03:06:51 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ren Wei <n05ec@lzu.edu.cn>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "yifanwucs@gmail.com"
	<yifanwucs@gmail.com>, "tomapufckgml@gmail.com" <tomapufckgml@gmail.com>,
	"yuantan098@gmail.com" <yuantan098@gmail.com>, "bird@lzu.edu.cn"
	<bird@lzu.edu.cn>, "enjou1224z@gmail.com" <enjou1224z@gmail.com>,
	"caoruide123@gmail.com" <caoruide123@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Thread-Topic: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Thread-Index: AQHcyQU+q1pLJ6SEb0eVRh2lUE3uj7XcUDgw
Date: Mon, 13 Apr 2026 03:06:51 +0000
Message-ID:
 <GV1P189MB1988963A155568005A37BF7FC6242@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1775809726.git.caoruide123@gmail.com>
 <1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com>
In-Reply-To:
 <1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7P189MB0614:EE_
x-ms-office365-filtering-correlation-id: b6531cd7-3a59-4984-7446-08de9909b593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 +0G06Idl63APTNdZdm/YXhjI26dMnJlL2PIY2RqFKTA6aPpF2ES6MSqm7LP7ZBcx8fvl1TLcRhpc6NnzJdmuv2JyoXgLjjzDl41MRM1g8QGxuQvjqz0Oci2R6oY/59al7qfVrxqezGXXg356lM0RopaiaRRivwX4wxhVzi0NrdcaYL/kNmdPyY6pMAynH55c6aktS6fGkwvGJ+UpYkw1BphUB31FzoOJZcaY0LUfApYtSGxGPcFRfDkFc9EtUoE7e25+vV12xtKGgHHg/m+bT48xA9xx77ltIR//yV2bP6xap8fJJq+tQ6CzrqZsP25OtRVZ7WtsbRmUphM3VpdqhrJFiM0CJQrGlsulze0YwGHMfA5WIdYwRNFzeqGoilo9O5TWTpm94rE7Q7GJZFW2FFNLhwyY2PrkvPlOnb5rL5EZXahJdShbAgCXsL7P7juiQOxjNCV76VGwLOPi0mc5wC1vMQECJQJItTtF1lL7akv/e0tLM5QLJDYpK/h187tSBDBrm7yfSEMR1pFuaJyZJDkVpyUttYesxya6KGf6zHdpWKW9Nkkk6LT2JOlvja6ivWUI64sAANeqisqwBqsuwCPTxDkJ8GMH1KoGQw01lQLwQ+WvaTOsYc1tjgCmOAenCm0fMuttLewNrS5vLAwvG7B4uAra00sA5xcJbzAB5SMwwUsoyevvXDOketL7zR6+GrRQBxMCLH4yfIKWZ89XqCIKiikYuokda7lKyiWgOP+2lMZRWjcXVH5VOBxV1fgjOaiYFkcSzzhGixPbwMUnXLWiO1/jURwhY5ze4Bv97Fg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bcG7Cpm8boPA/QpLdvBDbAYNKrAwT7xoQL9VsJy57bUalJ290yhYeym9VYR5?=
 =?us-ascii?Q?pxzzu+eo07i3BwvPtXGxcQbWWccK+r1vvf+NOXURIVll8thm4eSZvVpDeB1v?=
 =?us-ascii?Q?aFByypgKloZJNt5cEg8GiPoWP+lY2/nsR/7bts1z57iosOV2zc1txUIbmllb?=
 =?us-ascii?Q?kZ5JcNJFOnVvIQcy8Zy0A58flBCQIAdAg8rh1NfVuYlKnaiNFLSm8iO05AQg?=
 =?us-ascii?Q?Bsu5n8HPXJh+MB0l1XCy84jvEhAtYGB64iMBsGKZxgHAW43aT6ljP0PiF+YO?=
 =?us-ascii?Q?TBDdyox24Q5FMCd2hzOsdD0RNFEYueh74s92PiAK0WowWKgX1p8XhnK4XnWL?=
 =?us-ascii?Q?sTe9i3+lCwxmoJa0lHIKoR3vPWxJy/4lnsMkajdd/Us/ShfRrh/4z81nk8x9?=
 =?us-ascii?Q?PL7aKoTwiJE/YHwFpsyaaDdmeZTpDpeCL5R7bcfkCNDLfo5rwCYOp7x8ZPQh?=
 =?us-ascii?Q?huAqH2jb+EuBBOHNZ2iudHKQIGtJElTHwNDLtB7YtXc6wWXlQZZfIVLQAj3+?=
 =?us-ascii?Q?tRsGJjtTvB7spOUGQGlUrZoS1XCpO+ib34nzbyhWaHW6V6HHwcQi0b5i5Y6U?=
 =?us-ascii?Q?ASkPywqCJ4fgArjiuCuxPdRQYp+wSmrcWeMbjScom463kEnINB7NE5cm/6F9?=
 =?us-ascii?Q?8IM4rB+dt7sbUoHoRHfGp2yyJFfKAqI7pWLMKAcuHxRuNHGCRqyvupizXCIY?=
 =?us-ascii?Q?psZGJIndapU7lIbqR08+GV78LUuDYtk//qZiCtNseVlu72BNfDX+v2A0o23k?=
 =?us-ascii?Q?0tZAGF3nyAp6TXUoLFn889u56Se+gXlchAOQyK50RKguNDAv/OoIFMLy63q5?=
 =?us-ascii?Q?XZEa1l3AYMZHDs72i+m/u0vLQtKXDU79VKRYz3fjthqYQVppFFfOf5qEu+Vq?=
 =?us-ascii?Q?ZQKPSeImrBNzkl8ybY5upXhwGrbmUv8OlrXbCFnqZELyZk0ZDPdmh29/K9nt?=
 =?us-ascii?Q?jcPcilTpoHs0oPjdLXvLURYPHoINbDtHn5J2MftZm3KUpZ65dDo9T7zwCwnC?=
 =?us-ascii?Q?Wjz9TobGfBEq+8UT+LTw2Xz+A1FNWQtJTRK373LBv70fx1DDmOWbbM357BpR?=
 =?us-ascii?Q?f4oHIJFg+t+P/QHanKGKmXRmy/WTJSgrmHolplYuKFd57rwhnM1MALoTlA9P?=
 =?us-ascii?Q?TCQ8sJQI4lqywtZXaD+y7OxyCbv92T/l5oRc2nvA7OeKsZOFfQHhee4sA8H0?=
 =?us-ascii?Q?0mF52BKs04DzeWppQVmXEUTTbq+Csn1Qg0PYLErDEXRzhNOcdaBdl5LpDbnk?=
 =?us-ascii?Q?mRDkqoMSl92ZQHPrfGMI2avT+1+GF5T5aPcXSoskxnRfwHmkJ2248WkgSC/H?=
 =?us-ascii?Q?kqPEZj8CbQJPAgqnNy/Ibjv8aQbyeaa95zG4N7Zup+WmzgdZM4bS6pMCH3/V?=
 =?us-ascii?Q?rGcXXGs0XQ4FP3mi2WLYfIz3ZNDO5rApD2wA4QBxHf8YX8duwGBGMCx5eE62?=
 =?us-ascii?Q?q2WMBTBMqRYR0erl4J/K/F+B2fGJ5Ix4UoAoXKh5PQUefdw7XxHp1CXH1VEI?=
 =?us-ascii?Q?8pAcUUCw3zhkLYdBb6u5Dt6NL0U/cRfJ2LIKOIxixQeKZMABx7had29tn2SX?=
 =?us-ascii?Q?C8/+gUf5sFRcxFtzl0F74rHWjukzuUzXMsvChKJgSezuZRIJtMBZXCrTGJLy?=
 =?us-ascii?Q?WBsVMeK1wUMZMDiZvAengttPntctfEqFTc4C8ISiuAt2O6eOzljDUYxKGWNR?=
 =?us-ascii?Q?kxee2VT0Z/azKBX/lwGsI4CNY7f6s/bwZiiDVm/cpf/4+vR+aKJ8LTCoqTZ9?=
 =?us-ascii?Q?QekVBQnxxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b6531cd7-3a59-4984-7446-08de9909b593
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 03:06:51.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmrXFyOqIGuXCqJfWCdrGnC/X1DuoSkfVaMNluXLhVl6VaicNdm2izEaShGL99k3em3zifzs/FYTgi2KpVt+hxRJQ+wR98FAcNniOFEPPxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0614
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277946-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com,lzu.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:dkim]
X-Rspamd-Queue-Id: 729313E6E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Subject: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
>
>From: Ruide Cao <caoruide123@gmail.com>
>
>tipc_get_gap_ack_blks() reads len, ugack_cnt and bgack_cnt directly from
>msg_data(hdr) before verifying that a STATE message actually contains the
>fixed Gap ACK block header in its logical data area.
>
>A peer that negotiates TIPC_GAP_ACK_BLOCK can send a short STATE message
>with a declared TIPC payload shorter than struct tipc_gap_ack_blks and sti=
ll
>append a few physical bytes after the header. The helper then trusts those
>bytes as Gap ACK metadata, and the forged bgack_cnt/len values can drive t=
he
>broadcast receive path into kmemdup() beyond the skb boundary.
Can you explain how that peer can alter the STATE message ? If it can, what=
 concrete values are used  and on what fields of the STATE messages ?
>
>Fix this by rejecting Gap ACK parsing unless the logical STATE payload is =
large
>enough to cover the fixed header, and by rejecting declared Gap ACK length=
s
>that are smaller than the fixed header or larger than the logical payload.
>Return 0 for invalid lengths so malformed Gap ACK data is not treated as a
>valid payload offset, and drop unicast STATE messages that advertise Gap A=
CK
>support but still yield an invalid Gap ACK length. This keeps malformed Ga=
p
>ACK data ignored without misaligning monitor payload parsing.
>
>Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>Cc: stable@kernel.org
>Reported-by: Yifan Wu <yifanwucs@gmail.com>
>Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>Suggested-by: Xin Liu <bird@lzu.edu.cn>
>Tested-by: Ren Wei <enjou1224z@gmail.com>
>Signed-off-by: Ruide Cao <caoruide123@gmail.com>
>Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>---
> net/tipc/link.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..44678d9=
8939a
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -1415,12 +1415,22 @@ u16 tipc_get_gap_ack_blks(struct
>tipc_gap_ack_blks **ga, struct tipc_link *l,
> 			  struct tipc_msg *hdr, bool uc)
> {
> 	struct tipc_gap_ack_blks *p;
>-	u16 sz =3D 0;
>+	u16 sz =3D 0, dlen =3D msg_data_sz(hdr);
>
> 	/* Does peer support the Gap ACK blocks feature? */
> 	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
>+		u16 min_sz =3D struct_size(p, gacks, 0);
>+
>+		if (dlen < min_sz)
>+			goto ignore;
This checking is redundant because with existing sanity checking, the inval=
id gap ACK blocks will not be used to release acked messages in transmit qu=
eue.
>+
> 		p =3D (struct tipc_gap_ack_blks *)msg_data(hdr);
> 		sz =3D ntohs(p->len);
>+		if (sz < min_sz || sz > dlen) {
>+			sz =3D 0;
>+			goto ignore;
>+		}
This checking is redundant. Existing sanity checking is good enough.
>+
> 		/* Sanity check */
> 		if (sz =3D=3D struct_size(p, gacks, size_add(p->ugack_cnt, p-
>>bgack_cnt))) {
> 			/* Good, check if the desired type exists */ @@ -
>1434,6 +1444,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga,
>struct tipc_link *l,
> 			}
> 		}
> 	}
>+
>+ignore:
> 	/* Other cases: ignore! */
> 	p =3D NULL;
>
>@@ -2270,7 +2282,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, =
struct
>sk_buff *skb,
> 	case STATE_MSG:
> 		/* Validate Gap ACK blocks, drop if invalid */
> 		glen =3D tipc_get_gap_ack_blks(&ga, l, hdr, true);
>-		if (glen > dlen)
>+		if (glen > dlen || ((l->peer_caps & TIPC_GAP_ACK_BLOCK) &&
>!glen))
This checking is redundant. Existing sanity checking is good enough.
> 			break;
>
> 		l->rcv_nxt_state =3D msg_seqno(hdr) + 1;
>--
>2.34.1
>


