Return-Path: <netdev+bounces-296426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9brGLbuFJmofYAIAu9opvQ
	(envelope-from <netdev+bounces-296426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:04:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF286545C0
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:04:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=Mzji8OjD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296426-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296426-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99CD30E3E12
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B63AFCFF;
	Mon,  8 Jun 2026 08:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FF3AF677;
	Mon,  8 Jun 2026 08:48:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908539; cv=fail; b=hsgy6o4ouL3sE6m2BxQTvQjsv+fwM0bcjIMYDJRJUGScKgA4P1f1Tj8JhBaPoFimllUiYXcn7o71T3J0y8UgFoaF+2/Oogb92XfgrEasiUEnrpucOB5GWSGqjc4NcjWWC5OWAUTdcn/jyKr78/BWIEnh35AlmcoftOpmbkTlec4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908539; c=relaxed/simple;
	bh=cScuS+qAsp8YrIs+j7eET+CnpveucwF6Kva04/YVElI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFaH+tbyNmzr0Ro5HXFJ7wHE6KFXE16XWGQFRFVU9uCZrWdlTUuKysHVSHjAugpMoLYQjHmRge3MWUjQI9lbKIxEGOEap/00Nl2Ks/33UdSPOXFW0XZ+WdjDX3Nxm8QXUeZL6nMq8M7yl4LcDsy1K0j/zZWautKMu0uiP12jkqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Mzji8OjD; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N515VW7XdQd+P9IWDEA7R2iQa56Kc+j2OsaBwExUGKqChyA6fjbKegz6pxtSoiFDS1nO5gooHcx9wTjPWfAT1d2/pEPyl+CsSKj/JQMCNvjifAOr1c8m+etDfX4OEiULsY4X2DhNMh+zi8JBzNQk+APZbXJEBmDFzFHHx3LrklxWa9ENY5E02KDCakcvrkPC17kGtDgHODcl9zRdxynswclb58reUDzd4QgulbohzF5cQYBbZzmb57w5m58twRe29JnJdqlQU0rkgjO2w6SikoscFXm6oWMuMo4nid/GjchUIOG1/hfDPzKfHvfW8mJYz3TSV+RLVQSaRZ/f9M6Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSA/lOYuSB00OJOYpv/QV/m1l/E+ywalQFhHXaHfiHI=;
 b=vawGhNAx+n65LSWU3mnXgrySd0acJ1/MFxOarfSoCnpl9e5cgeYvu0zsDctdF+p6xjidN4Qp02fqMMxovDYSZtzo1olSQrVmBqll7HAaVgZI6m9hcuW3zHMSG5nwSrha1g2WwjRaXqhErn4HTeiglEnsC6/+PGi3v0WPD6mFDHN2Y/ZXqitIHnek5SVKa3Jf48n+01uqTrhNR2mY2q92K1f5p0lJrMr9KapVNc8zs1knZ1GJ+UwHYd2x5RiNMD0Zf7RvEJDzccrS95LLbRBzTzMwxP9B3PzUgUNZwZs9k/BuklbznxY12BnQ4GrmyyYAF+nJMoMbOuxJBmTTYnGoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSA/lOYuSB00OJOYpv/QV/m1l/E+ywalQFhHXaHfiHI=;
 b=Mzji8OjDLt6e0oKWjhkeF/8WSvJ1tuaBjHu5489OWc+eSbVoWC6Y7+HyrOy+CQQAW1SLEcbsuv5FETgYht80yXFsMvqisFawKkuFsw5L5tCbK/hUXndmgo5NrifX9Wu98q03xQirmHH6AlP5Tkt3i716eaWxjruP9CNbXWKHL4G6KYGvDrI35gyLaHB0ucuqxl/3Pkkp4QZKPMH/hd0rBFo3A/zkPWTtM7vPAau6/ToOXHJFNUa0ZKWQE714k2mc4Fws1TQuIZpMlKweW1Foi0tJZGQ7dO9hqbl8/4oU4z5bMyxb/mY+wwZn7Pe7LX4DwIKMnJhbU7rb4VKF1pz2fA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PAVP189MB2412.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:30a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Mon, 8 Jun 2026 08:48:53 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:48:52 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v2 2/4] tipc: validate discovery message length before
 reading media address
Thread-Topic: [PATCH net v2 2/4] tipc: validate discovery message length
 before reading media address
Thread-Index: AQHc9ekIMyVloni420GqqIhy8Gt63LY0VgEg
Date: Mon, 8 Jun 2026 08:48:52 +0000
Message-ID:
 <GV1P189MB1988B9DF3DCB9E4062204166C61C2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
 <357fb271180356b1ab2355da9702927f4785f805.1780766454.git.michael.bommarito@gmail.com>
In-Reply-To:
 <357fb271180356b1ab2355da9702927f4785f805.1780766454.git.michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PAVP189MB2412:EE_
x-ms-office365-filtering-correlation-id: bb039549-e27b-4c04-9339-08dec53ac46d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ROKwIp0hanGGfMJ/WL8BfepTFYVR4bZ3mR4aDbxL6FrlUtosqOb0+DAFwL8w+aphpKJatsLkh5iGgWnVJL6QY2PzeTNY4N9xt8z7mbcVVGzBkb+/z5DjfzoMqhS/spZRFnzIokWd+7w54HKvZWupI//W4yBt1xb9pOf18zN0lRX4GeVmfw0tG+gh9AqMkuMeRT5lz57Yg18rW/f7YlY7YrQio7lugOfRE475+CGWpPQM1Lhwd4UhqmpuswQ28+RCeYwIU3rYAuYjcRkiNb2YywruBh+hfqsQRJ9r+Vpg45ke8Mv0AY1q4ZUVuQ8UQvnd5wjxktytQsIP4nN9vOoDd3LDdz6jf2TVDZ3UAs9XuTLXB14UyNK+qSREc1rEk1UTda+Qtttc9maNP3ajxj63Fddgvcy+umQFjYMCUxy9nWwZtVztvppANl1R1+rb9lgY0yQjAOTcqqFS1601IeymO98YYDrsENB2Xe6Wtvmio7DGk5WE/5Cb08CItfB46NVFOALtb8VY+fkIJAs7dYAtmovUEXMca5InjVOdF5Mepk1cHDY7nMBiL+IcI5nGk5uv/O1lHhh8UaHHG4PlnzcMjw0MRv7Ht03tl3nolHJ9dA+khI5LpPZ7edzp7EeBff9iySecdSTnY312R/Gy8bDyyYzOjjjXEfzMGahLcufTQnO0WapVYFgWzpKTZDdSsHwBEQxjxTMk0TFJ4fgEGDQ0VGDX8+FVTdpybGa1pai73fTTIHCQ5fYB9/2oByWB+omp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z3ltz78zWR8sjA/XbOzLg6gVLRGnGEOTs00nk6rjaPU3W23tYlLAe9k2b3Oc?=
 =?us-ascii?Q?lZe+rYOtMO4K9V/0wV5patYo6SxfrFm+ikJYUtrBETyy5r4U4Bb2Ocp8uei6?=
 =?us-ascii?Q?fnL0IiZBim5YMQHm0KlRfDtO7xFt4yad2/ZiFX4snv0rTwCfY1YPMz/KDzLG?=
 =?us-ascii?Q?Z8SwdMgQ/zp1epUw1Td6Fs2D77oFHfy2Tr4KijTO66xJzMm4KiLRQxUtnDU7?=
 =?us-ascii?Q?MbQvWk3JaGedk8OwkvuPBUcOabWH8ddsUPgaW7YvLiMSBIVhAKXM/Bc/Fkth?=
 =?us-ascii?Q?BGBhr47FkGYx8fqCqMfXoYyABsOrKGWefVeZtx76QDe0PM6JrcmjFJy+CyR6?=
 =?us-ascii?Q?uGYnb+jnZ70STQroH9dD3wEqRGN7f5dvvsPa12fPfa/QZTZmy8cxMrpSNP1c?=
 =?us-ascii?Q?HTu2/RuabkAKGZFonfuOUi013wy8RQBUzJH1vKLCKQcGcIRb+YXEq1MhL3Pa?=
 =?us-ascii?Q?r2FrTYYC4zhlW+iiYAKpduoJETB3oe08+T1Xuimq9P+r+LHr1NANoAHpvlr8?=
 =?us-ascii?Q?6JugEoWjbPdJGgpwtZRrTfVtmEUTNHvf4yA8cE1mFdOQKEu/nSKchYUCP0tg?=
 =?us-ascii?Q?OU2ORx2lXZiam9xzdxWPyQ2eKWBvphCDumcuwYwdhsIna0BGAfxiLq/9Agmm?=
 =?us-ascii?Q?aY2JZPQNVfcy4KITlvjTHBWpL8vrRdQTyeVq0CS25/iPGXWMtdHlGXFg0pcv?=
 =?us-ascii?Q?PCiUP0a7MTtI5SeyrFweXumOqQR+KKtTy9umrKUa8tV9UhsgaprTdO2l4Icd?=
 =?us-ascii?Q?Pf0xjoUCWHHBJxZu9fbn3KAcyxAlTgLITbgD3ysA0B7jAayJF9l7MCd+89wJ?=
 =?us-ascii?Q?DnA02z1uZabfnAV4+xwDoAtg9upwyqiZOkxd7qcoXzB8Ixt03+P1ugao9Ak2?=
 =?us-ascii?Q?wtD6noKySxfwd8IhHfRsRooab8NoCL1SN1O/AoqUwx+K3eoZdKjEE+W5ke2J?=
 =?us-ascii?Q?AJQG/Nbfhl98hPHuaqLt/lX/eJIsrDwzAXqoez5QMDeikKYsR5dcS6Cnee4r?=
 =?us-ascii?Q?Za+xp5hQ8tFmgctiG3qyZ6HCYmPFOxBL+Tp67X/ZjtG0ZxG8xnwybwDB16F4?=
 =?us-ascii?Q?UJPKasqmVP0HwaRj7kC15d+QiY6NG7ursEHjw3qYvfmQ66QNuJGiu7sYjSob?=
 =?us-ascii?Q?cqifEW72h/zrp4GZI0cjL046yQkVLQ+XHr1BRoSjgoMQNEIGKzNzYNddxfH3?=
 =?us-ascii?Q?dxp4m+ZPDC6ORhBrrQzxv4tDmyOlfkjXKKRjRVBL4+gQpO0ms8jbd/c7wWMc?=
 =?us-ascii?Q?jKJEJZ4Hjdw/hiSYtAKqvbwlzKRIpJunsEBbgKTmx1e0/AOQ5eIhiQsh0RJf?=
 =?us-ascii?Q?Qn/72QPUEj1Ec6n1zsX8A7+2RgxQEZhKgatxHhlqzpSEBsEWxmwj7o0xhErx?=
 =?us-ascii?Q?djaLLVjQ6TlFxvp5pf+mrVcc403sYJZQEzPfoTe9ILrTojz/ySQKTMqKI3Yq?=
 =?us-ascii?Q?jOszzA03BPAiheVl+2goP4/9ZDjrU7A9b3zZzw5PVwllTo/lRiaaafVej5h3?=
 =?us-ascii?Q?JVWgl+Tou0IrBxNxWrwNSMTN5uuDiUqeFk6OBdwnMO92NJGHd4S0rsvs4KG3?=
 =?us-ascii?Q?q0rueYVuGJp5mvG5XkzOyFqHtQqNaouV+dgwTxYXwlpp6Q7GTJm7v92hp6zn?=
 =?us-ascii?Q?grSu6RXpZHHCkpwTtDEdm6l7/aszZ8gKNy9lN2B1aZEjRHhzpZrfxxCwDBCQ?=
 =?us-ascii?Q?y2tbnOyXWhEWNXKYMtzAOya3iQ4B+uEU7uBiMuaR0K/WenIgcCL7v/2cEXip?=
 =?us-ascii?Q?qw6bzxu6sw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb039549-e27b-4c04-9339-08dec53ac46d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 08:48:52.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZU3jBYfzK1yP6OHsJfsdwDyMA7x3UqTGn2VjdU7d+SuZzTl5wVJcS5zaH6dYdUBX7AOj9T3JBdVY76l7R6Vjmm6BD/8g8bL6WhU9Rzkf67A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2412
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296426-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CF286545C0

>Subject: [PATCH net v2 2/4] tipc: validate discovery message length before
>reading media address
>
>tipc_disc_rcv() reads the sender's media address from the fixed media-info
>area of the header (msg_media_addr(), offset
>TIPC_MEDIA_INFO_OFFSET) and, when the peer advertises 128-bit node ids,
>copies a NODE_ID_LEN node id appended after the header. Neither read is
>bounded against the actual received length: tipc_msg_validate() only enfor=
ces
>a header size in the range [MIN_H_SIZE, MAX_H_SIZE], so a LINK_CONFIG
>message as short as MIN_H_SIZE (24 bytes) passes validation while the medi=
a-
>address read reaches up to MAX_H_SIZE and the node-id read reaches
>MAX_H_SIZE + NODE_ID_LEN.
>
>A node always builds discovery messages at MAX_H_SIZE + NODE_ID_LEN
>(tipc_disc_init_msg()), so a shorter LINK_CONFIG message is malformed.
>Drop such messages before the reads so the media address and node id are
>taken from received data rather than from uninitialised tail room or memor=
y
>beyond the buffer.
>
>A crafted short LINK_CONFIG datagram otherwise makes tipc_disc_rcv() read
>past the received message data when a bearer is enabled.
>
>Fixes: 3d749a6a26b0 ("tipc: Hide media-specific addressing details from
>generic bearer code")
>Assisted-by: Claude:claude-opus-4-7
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>---
> net/tipc/discover.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>3e54d2df5683a..daf5f11fc82b4 100644
>--- a/net/tipc/discover.c
>+++ b/net/tipc/discover.c
>@@ -217,6 +217,20 @@ void tipc_disc_rcv(struct net *net, struct sk_buff *s=
kb,
> 	}
> 	hdr =3D buf_msg(skb);
>
>+	/* A discovery message carries the sender's media address within the
>+	 * fixed-size header and, when 128-bit ids are advertised, a node id
>+	 * appended after it.  A node always builds these messages at
>+	 * MAX_H_SIZE + NODE_ID_LEN, so drop anything too short to hold
>what
>+	 * is read below and keep msg2addr() and the node-id copy within the
>+	 * received data.
>+	 */
>+	if (skb->len < MAX_H_SIZE ||
>+	    ((caps & TIPC_NODE_ID128) && skb->len < MAX_H_SIZE +
>NODE_ID_LEN)) {
>+		pr_warn_ratelimited("Rcv corrupt discovery message\n");
>+		kfree_skb(skb);
>+		return;
>+	}
>+

This patch has 2 problems:
1. It is wrong because 'skb->len' is validated too late. The message has be=
en accessed earlier in variable declarations.
2. It is redundant and never hit because tipc_msg_validate() has already va=
lidated it:
tipc_msg_validate()
{
...
if (unlikely(skb->len < msz))
        return false;
...
}

> 	if (caps & TIPC_NODE_ID128)
> 		memcpy(peer_id, msg_node_id(hdr), NODE_ID_LEN);
> 	else
>--
>2.53.0
>


