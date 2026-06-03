Return-Path: <netdev+bounces-294543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ur3IMselH2quoQAAu9opvQ
	(envelope-from <netdev+bounces-294543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:55:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C847D6340DC
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:55:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=rVCk07sb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294543-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9D96300B539
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B253ED3DC;
	Wed,  3 Jun 2026 03:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533D26ED3E;
	Wed,  3 Jun 2026 03:55:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458945; cv=fail; b=FknrPgkpSjD+ctQRDPiRuetoGVh6opp/wDRZbMmX69/2HoZLdfUQYQHpm6BjWMI/q3pMZXvP6ilyMMyfT1OyKqFPaGh6nEcWHhoZpPCEnbLTZR+LPF+H3GnN3kv8+yeGzbRR82k8FLwdakJuwL6KM9FnIpWiSqhRMM9+7qeN3cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458945; c=relaxed/simple;
	bh=GoeOYgN7u4807eHgZeaTN2/08xdOpLPQfL3+qwLY6N0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pS4gk/OygZeaF+CLGOoVPmFJHMTPzlcGSCw+oPjAcaDSe8t1gvx1erWKu+m5iA1zo/8yJU1qvfGTgMlCDSMQR6p6dTJxphaKnsoNQEIMozSq4fsnXVcmO1Qd/RfY+HAvSIPz69oaC6lq7f1PwA3XsxKPzQ9OE/kiZxv3L6WpD0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=rVCk07sb; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNCr6mprTsughSmrhcv8/lDIW1DuOaSeROfiJoH/oZwCR/khWFgMS5FqDEXRuKPSd5HpU5mLKBwcYO/QaoPTR/HMqOO5eHA9sbD+VI4feQWhzwLwlKoIToFswGH4X+pC3+OH4zvY8BnGdXXBpN+vA9ClBDFGS+9vjrGKowF7h57ngTTRknH+HIKv2xqdFKLQTHvPgohNI4o/1hAtp335NSmlt+NPraCyYC3danwk4OZFdV4ViRaSgoc6llXc/x2knpkqKTVzZPfSEJc43laZG3eRyDoXvIFvLpHc4fA9WPPwl4UuhSxZcHJQZKsABikbR+BBTAfaZEbeZ4i/Qnzqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHr+sTXAJlHHGeWsm9pV+rn0sc3zppnF73yLbOVXM2o=;
 b=VEClfpSc0JJj3snQ3nfq0bPClOHUWGjpe4yUElDOzyFyTk7txTc439xmR9/SO/UCU8RbD8DtgdIrQm+8wzwEwYMNv3bkCwGW83ckcH+xiYRctgA8e7mL2d3OQBEOSbA5duFTqKxfHkfBYCvEqKfyugNFaLMvYCRkVUJiVM50odqdZzHSHmwrlJyXph35MXofSFIRa9/Zfxg43EOjlPON18VfbQt3sGh+NiV/7jdzvPT5txOCOSURJMVd+jfYLJBvC5WFTMaB3/HhPyhWaUrRhYBu0AntVl/u+7mY5QD09AcqzKZZMHuUNmwSE09ydD01bGznkH8v2yDrZ1syHEJIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHr+sTXAJlHHGeWsm9pV+rn0sc3zppnF73yLbOVXM2o=;
 b=rVCk07sbqZ7yy+mq9gd0/NzkTXjtJz0HDbyS91Nb06WogdgQ52l8ztiuEEAYuNewb0oeFTLr6GJNBLwxYLtwxkj4KNL6I2oPYqOmMUQkevx9pzvOXtJwx6pOnytTFeNF9pDwPlw+HJ5paAGKFGn6PueEPtM3+yWJf44IJPQjY9P+ybKY4eXwUkNxNo0cRO4nW9MPMTpG+1BY6FP4gMyHvo5eyNs8P5mwf/UUb7jeLsCnswIDzL0/yoDlKKW3NZh0R5/6zi3f88doapkFsoL8Iung7lt/zaLo2M+MjK5oRSvCE8aBDjw7QVXr9OMBwedtxxV/pcssldKYiQtIHPqmtg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB2651.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:24c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 03:55:40 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 03:55:40 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net 3/4] tipc: prevent snt_unacked underflow on CONN_ACK
Thread-Topic: [PATCH net 3/4] tipc: prevent snt_unacked underflow on CONN_ACK
Thread-Index: AQHc8pb6gRCtzzWnXU2elhpDNm4xDLYsMcqg
Date: Wed, 3 Jun 2026 03:55:39 +0000
Message-ID:
 <GV1P189MB1988C1960B8A41A7AE0311ABC6132@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260602133555.769727-1-michael.bommarito@gmail.com>
 <20260602133555.769727-4-michael.bommarito@gmail.com>
In-Reply-To: <20260602133555.769727-4-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB2651:EE_
x-ms-office365-filtering-correlation-id: fba5a152-6563-4061-3511-08dec123fa3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 AuoiOrZ8yGFJ31GPRbkGFvk9CiKlsWMVo2gsu5YQWoKbE7zAJ3fhMpvx1U3S6fyNkl43tbP3+bwwQJZV2IyXKbS3JdOX2H7aX+qWLtHkSzZadzyExYkHcnaJ+Y/SBKcABU9PluWn/6Qtk862ulWOOyRkFpfZ+lPwtCj4nOWvHEqk2zXTby3yAjkhKtGfA3XRTZrmygzQGq7gc1GJ/Tc2yNsQOWQMsigKH4i5B3J31yRCuJGTzfnhOnYuiEJs4LP1Ar1nAoffqA7TK5uXyaVgfhLRfNiR/nu4iOayIhzvkhEanMme6ruuu8o76ZQrx4awSp/O6juy8Cg1ZAqyqYQ7DpSihEOwqoWWTpP/iMPy1uQlUMH4++m8dvm8hAWvKeWBvKLMtDlYKjgMy+ZP17XEQSqZ1uYAyho1aoYHl0ualmfDpJfABND2V+OIhK9RIaWtzPaT5fqqBMZXt5HE/Lx3ziC1xenCt199cx4yJ/D7Dtmzj5JVZUhwYnElvQe1QBUEERH8Hp99wzzcp+JNiYHbOFLY6UQThk1PnFLBza9p+rONuX2Vg7msrH1xDFcSFzIRyn9yJy7Anbv4jSOj6LNJQWxAGOLwcoHYv6yWHx8YHgHpEKxDHgmotfmi30dLGHa9KPyUzBLegc3QBeeulY7N/1M6K32k5q+U5cDtR+HjBsKvxF0zzvaS6YqDvaNQpRD10ogpnsEwmLLwTetTPGeLBgSEOKEBIeWiw1Ibiua90FH6u+U/POOwo4f5wbeR76vh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZPn1kuTWdo5jMwEtqaM9roxxJr4e0rJ1RmvFn8+pH+1JJ1zy42ahGrnSbskb?=
 =?us-ascii?Q?F4VYEMBs0+PB2NdfU+ky5JbZhvYjGfV3c4rudPbZwSmsG4M1dSEVwVoWHPvC?=
 =?us-ascii?Q?cU3vLlgLZwe/JO5jjHpspa5j6Xh2TFelXiYQk8V5y9perUEQ6V6q1zYPyRCD?=
 =?us-ascii?Q?yFZKe8MzpxumIACbiodV6Rma0HL41KujqRZ4sKPaoM2sT5/ECHhkRpGjE8ro?=
 =?us-ascii?Q?Y83yq9boeAw92hiUFpUOe+zZnrmZrUsD77ShGsuE4i2Rvy7V+wkwvDpRfNFy?=
 =?us-ascii?Q?ii16ftvCsdezXgXUqH+cr1SQIpbPi9Lef4nkaZyRLAH+1klFiJztv2I8xlGZ?=
 =?us-ascii?Q?Ei82Ya/Y9uXaY0jv+ZrOGpSjMXKEqxnvIYYKFMf+KEcs8hB1IUORqi3D3viO?=
 =?us-ascii?Q?yir2p2N3Hbfi9c7LZmWFyQv42UN08EemhRb2YT+V1s7tai7rrs5cqQSUy6rM?=
 =?us-ascii?Q?2uvRPpy1smZUAYMdUiSQarOcYM3RG7+conNUV/QQ/0fhZC3xGFt6BcxKDBBS?=
 =?us-ascii?Q?Uaif1+hOG6mT6ObzgbNP+K6GcwO+gY9kpfAJTNaG+aEcZDbDPhc9/Q2uA+UP?=
 =?us-ascii?Q?qPxoazxd6cJZS7+RyOi/vv+XVnMh5HV+26URRSIK2FsqNelXx/+wwVnBtkkf?=
 =?us-ascii?Q?6iDCepg1kR8ITf6MHLI2vxDs8EUQ4f83O+0WN2bpw6Acf4tsgMh2cX5vD0gz?=
 =?us-ascii?Q?UNdwWcEOnEHS66+PA4Yed+9OPdconDcT5JOoSNC2LJjLn/9xh0eqie4w5iCl?=
 =?us-ascii?Q?ZJrL9EsuexbfCApOXlgDYX4QRVp799cLFfmk6lCNsgL0LpKzL/X8Lp5kEURb?=
 =?us-ascii?Q?39VKKYRETgucRJfYkv3Of7DcC5ojkRdKY0Ru4VfPyEmkq172Zt4RvBQKkizr?=
 =?us-ascii?Q?lDTX2qgEDnzqiM34sQGxOVehN3K2KXuUlNWmqISnlSmL6SrCnbgTmJb95isL?=
 =?us-ascii?Q?Iq0oYQEzxoA48iCOPF6WMcm4c0LNLfFuhTmSMFRtAEIBoK4a3j3ZSR3KjIwy?=
 =?us-ascii?Q?LKNePTBxsES3i0Os/qjxa4H6uEJxghzLImoaG+yA0PCRTFY/38Xk7XaXMcO7?=
 =?us-ascii?Q?PuWRsHzncKmXDBs3+JqZYpnMuxoMNJxQqjKlo47Xj6Ewd+H88/5evpNVHe1q?=
 =?us-ascii?Q?wcJdOBXh+9fmUIM64qyzcQ/pd8GpjDB+H0pv4o9xEtpAQrQRwfykb1neCuLI?=
 =?us-ascii?Q?J3RFz4m5h1Fnk1Zja1vtG3hbrrw99BGLIQHLANMAALchn2yS7LL7IjD4tHBy?=
 =?us-ascii?Q?oSktsSB+5ASLtfOtbgT16oUri87B3g579OAAnsHS2ND82v1lBqaXNolp60Eo?=
 =?us-ascii?Q?eLV+PvZXntDwFOJc0rNUOWanvcUrUkqaS10cDhbNhKFSm+171YKo6y0LnvKL?=
 =?us-ascii?Q?Z3pD2nB20it/jMnNH5nWeF7BmzqgPeJOPUgyGknKJM5qewsL1kJnZCQO4Tb6?=
 =?us-ascii?Q?c4sSywRoHDgGqcgyWBOhmXPYS6KTtK1YcKkjC6pF8vLW/LI39CMXPoCEjKbK?=
 =?us-ascii?Q?rqAQLZwWPCG7w29fpLTi1YCCJ0l8+p6uqcEvlpl/R2kHHsMnp2NQRNqEujoH?=
 =?us-ascii?Q?Br8G5LQUdFIKi8+wiLNK5DAeTiavbYaeWUAe5vxrfmbdKFtAB6+0twbgJ3M7?=
 =?us-ascii?Q?kyhiRcqfPLkJdZ1tPG+GsREPvqVFRpOJmfUrYRyEHbfCGoFMUgFK2OZAHIF3?=
 =?us-ascii?Q?mXQbGiE4t2QxRDl0+L2xEG7WD1hwHBEAWhAzGQlFuy/Hp55aiP5zm1aiAZSB?=
 =?us-ascii?Q?d7Z3Nlx3oA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fba5a152-6563-4061-3511-08dec123fa3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 03:55:39.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bdR3fQ2ufBkI+qECOAhDpUL8Ywdkkus61k+6xDsDAiJMDcL7+l9G9O7Aq7TIochO6bbBQGd5JEq5D0O+8rNjGfd08FBVMhhXowaU8DsDaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2651
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294543-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:from_mime,est.tech:dkim,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C847D6340DC

>Subject: [PATCH net 3/4] tipc: prevent snt_unacked underflow on CONN_ACK
>
>tipc_sk_conn_proto_rcv() subtracts the peer-supplied connection ack count
>from the unsigned 16-bit send counter snt_unacked without checking that it
>does not exceed the number of messages actually
>outstanding:
>
>	tsk->snt_unacked -=3D msg_conn_ack(hdr);
>
>msg_conn_ack() is read straight from a received CONN_MANAGER/CONN_ACK
>message. If the ack count is larger than snt_unacked the subtraction wraps=
 to a
>near-maximum value, leaving tsk_conn_cong() permanently true and starving
>the connection of further transmits.
>
>Cap the ack to the outstanding count before subtracting. A peer (or, for a=
 local
>connection, the connected peer socket) can otherwise wedge a TIPC
>connection's send side by sending an oversized connection ack.
>
>Fixes: 10724cc7bb78 ("tipc: redesign connection-level flow control")
>Assisted-by: Claude:claude-opus-4-7
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>---
> net/tipc/socket.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>9329919fb07f0..9c739a3cea126 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -1362,9 +1362,16 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock
>*tsk, struct sk_buff *skb,
> 			__skb_queue_tail(xmitq, skb);
> 		return;
> 	} else if (mtyp =3D=3D CONN_ACK) {
>+		u16 conn_ack =3D msg_conn_ack(hdr);
>+
> 		was_cong =3D tsk_conn_cong(tsk);
> 		tipc_sk_push_backlog(tsk, msg_nagle_ack(hdr));
>-		tsk->snt_unacked -=3D msg_conn_ack(hdr);
>+		/* Cap a peer-supplied ack so a forged value cannot underflow
>+		 * the unsigned counter and wedge connection flow control.
>+		 */
>+		if (conn_ack > tsk->snt_unacked)

This handling of an invalid field in the message header is not correct.
Please validate this field at the beginning of the body block and drop the =
message if it is invalid.
=20
>+			conn_ack =3D tsk->snt_unacked;
>+		tsk->snt_unacked -=3D conn_ack;
> 		if (tsk->peer_caps & TIPC_BLOCK_FLOWCTL)
> 			tsk->snd_win =3D msg_adv_win(hdr);
> 		if (was_cong && !tsk_conn_cong(tsk))
>--
>2.53.0
>


