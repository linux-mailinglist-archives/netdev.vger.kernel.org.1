Return-Path: <netdev+bounces-297057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y7PxGKAbKGpR+AIAu9opvQ
	(envelope-from <netdev+bounces-297057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:56:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14C660C78
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=ouO1L5NW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297057-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297057-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E1C300C58E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE5429818;
	Tue,  9 Jun 2026 13:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86211425CCE;
	Tue,  9 Jun 2026 13:50:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013042; cv=fail; b=OeNI0GTbpP8V4EYimoxsk8KuiOpCA/q9FB6JqvuBBorRuyFANrS/7aStI6+OsMmqmEBosOw6rfCIZVatEs+wDp6te78kAsVAseIXv86KB2e55E9DgDjSeZLNgrqD2ynNd+PWTUyS56D8IxS/4u/ji+5KnwvisbGwRg6R2VMIzC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013042; c=relaxed/simple;
	bh=g+cx8l52FY9CEAbJAYm7tRSw1MOjLqmBfFo7NnSjK7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJ2BPSSo+VfYEPKBGkBrt6jNHpB5nSmDSz5tRD7096NTI8XSePJb+KSHaSo0DDcPoH47zDusfmhBXFJE9O+CzTYx34GYYHlXKQ3UilN4fmSAotrCq/0Shh+Q9jkm6g5ToCr6O+PP5NS+/I8XydmtQ9r+5cpj9/W7BUOjU4RGCLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ouO1L5NW; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0js/LxjkCeAVJ47bC9Bp2qa2PAVdyDqEcjCGhJL125UsFJZssX7f07k0dzzGDx+f/cYxb+RCCjr1WCg90TxthGqQmaRTS0qPzGIg6WCdtyKg0rwd8ICmGh2MREOkoriGstwCB8u50Tf3zSk+Fgf0opEesQ8JJnLXb7c3hJyzAhQ+h9/V1DhMiRlWBI1EUZIKSYV7/g1ay9oeF+v/Yv0CLrINpQZjrcyuaZYs9SqUC5LosYoPNahTiyN2PhahvfyybW/ydNFquk6Bf5eb/BOzYZLmu8BWDzfSCO3BfhVijJuUBHp3nll0Y+VuHr3J5bdDQwpIfnSQqmtnxAd+Ma5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6lCy2hKAeqp0RyiYy2O+yx7wFyRsw++G8mGLx7k4Ts=;
 b=nMK8gRdSQ/ZCdFbo55bakvU1swoOC6ENuxk8LTdPTNDyT9DrR/PwOcmC45p5Gz8QdxPzBzRk2xYr+mlIIMmGGTIxCtLFjrr7fDRAmTcoANg6zdwdDE4E9VQ/STPd4tdaG3S5hXFuK9hASelaAs0gLFKGnLs5l2LFj92Ry4yDKIDir3aSE/Nwqw2kOerHr1y/wdJ8SZA9muP3pJfXIELyBXW7Ept3PUrHDZNN3VrCqSmMHTMv7Sljvcg3cYAZFsp13aHmcdhb3gjw0oQu99RcN5IKNnMAr+jpQcYiMObQvUsBGRAePnRDOuNlyQ/xTbMHh7GV26CW8u5m1XpDEY9SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6lCy2hKAeqp0RyiYy2O+yx7wFyRsw++G8mGLx7k4Ts=;
 b=ouO1L5NWKddVjkGDpHQOoDPos5u04AqOtKv0cKKTiluQDEmWe1TN1OIAgE98NY816sZZ4JvVOpeiXFWD5HDhKvF9vhdp8Ppf/s+WcoAjYQ6ACGWzzStu7JX/xfwTUmInFrRM+Px9P6UB/X/m+9YgNCm5szhSDhZo8+JUCWCHdUwYvQATh9VAGXc7FglUmCYYcTAv/Ip2Ls/5JmCHLjJf+HfAOdzo5zwtTVvbGD58d/Z07fzCRXM2aC0YE4avv1MvkymbSa3ZjBJtn0vRxE/Zb/Jx1zDsZ1jrRkudDjtgls0CFgv57/cTe0cp5H0w+mwhhKw0BxhkLnC2mjkAmVKcTw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7P189MB0631.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:11f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Tue, 9 Jun 2026 13:50:36 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:50:36 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v3 1/3] tipc: require net admin for TIPCv2 netlink
 mutators
Thread-Topic: [PATCH net v3 1/3] tipc: require net admin for TIPCv2 netlink
 mutators
Thread-Index: AQHc90L4XR1c++tvWUeIiwA0df9p0rY2Pnyg
Date: Tue, 9 Jun 2026 13:50:36 +0000
Message-ID:
 <GV1P189MB1988CB3D8E819F03475C0608C61D2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260608122206.458290-1-michael.bommarito@gmail.com>
 <20260608122206.458290-2-michael.bommarito@gmail.com>
In-Reply-To: <20260608122206.458290-2-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7P189MB0631:EE_
x-ms-office365-filtering-correlation-id: dfd6e5fa-68a6-4246-a78e-08dec62e1562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|5023799004|3023799007;
x-microsoft-antispam-message-info:
 XmWrxefHC3a/HYZ3zhZDnhwtF8eDpP6z9y1KoCxaN3LFuav/Lwoxt4SqeCBMEzY6zIW4jYjdn5rT2N/AyZsIS95Ruo5DYex/mjRVue7RU8WRwVbKALz6NBPDaYucfbhC6J4TLvoZAO1uMzx9EM+4wmJySNGkZknL4BLiofoWlrP0rLLx8JjXg7GbhlgdDBCPIV0V9KA6lf123DpX1c/CO90kuUWhI4kK0Z6lnmWlzio7NTXbFi5Iaf9l5n44BRbiROsb29YvH4EECEdOOzSYN2eEyyiDhtuIYMqyrzHBX8Asia3N+mCYjhkHEiiIkiB/4JYcRtfpD/f0K2dbItUrZT+XFD65NkL0Ue49/X6gbt4mycaUe2oZ98rmxUG1+QjyqKXLFgBPxENbitXOMg15k9R1Y+IsVHwfgG5KPH+4u6T/5JNblf+VG0vkENUvAPJRauB7WdG1yTgZfOuRJ30dOmviU3yyD3yFrpflAkcFS4zMi//7AYDg+muHErwwRZRnmn8UHwJH9xtCAa50ZDrfJ0S5HeRRV03R9mzDERMGjK1ESYfQLuLMHDxaoeTPVPUxLwAIGJbfY7V+h5s5tOUb5/2Gm+7Duw1OVGlRatLmpIrJJkTpUq7ovFztgagxaCoZARh6F2Zg1y/KxIdW79FpsBtBEujHsWDwEcyUc9Va5n6SdMLOUfldnDW+XcJr+0+wwrGEG0dbcSqCK5Kv1HIPO/HH2KDMFjarudha0u/6NtrjeM7i3zcmY2fmuklEF2Ui
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(5023799004)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M6pExnAtH3eu4w2VNODRUZCWf5TmE28FYu+a701ISz8wBdb/iWWTtKDx6A2O?=
 =?us-ascii?Q?VwsUQgF1MzptrTVJeFeqwS1Mmjq7ZuVdzGpsdagp6YAzRq1pO4sodkd/24lb?=
 =?us-ascii?Q?NmZDAeCFwEFAsCIAJveqRuWUn3FFyUODBFG1/dyli7D5WYv25o384CwMM8pP?=
 =?us-ascii?Q?P7Yj8R2dDX/K3aBP9m7H6JoWZepVi7jyDi1Dg4E/KR14LyG12ifxZ+2vW/aO?=
 =?us-ascii?Q?ZM8eCZs5Bnb1Kf7wukqStLg4lXCxmxaAAo8lqshmhVPBfykuTq4BjiYBcIfG?=
 =?us-ascii?Q?B27ODWwgLiVC9AwlWJpyBimXbNQc8DLsJUMKMtbxNQUM5CYtMgYqt6n06cja?=
 =?us-ascii?Q?jfunpvKYwvkjBtXD1Y21Bj5O6M9Vx2Orco9vOZVq07m8Zd4oeqFt+eLzkiFp?=
 =?us-ascii?Q?365oQCP5shJeOmTWYoF57tRU5eV0L+KOGordfHgfWexUWInU2ScvEHvbNYpX?=
 =?us-ascii?Q?EDTp3BZTLZo8PzB4PLg9yUW6Ig3RkTloaN/+2u7TVKU3OR2UubCjGu469qC8?=
 =?us-ascii?Q?EwTKPHtzmbxKuFlUv8cEjOkhQI1vAurDlhh6YuNp58HH9Xnz6sNUHCDLxL6i?=
 =?us-ascii?Q?4ARAiknCERttJ5JgjAhwndl5YW2weU6Od0Ta7W63VAIBOvtTaFsHgYsI8p8P?=
 =?us-ascii?Q?vvX1Om9MOqDKhlDmT3QZ4/ygswo0v6MPpa1SKwVAE75kT4jmmzHUNdF2iPZo?=
 =?us-ascii?Q?AnToIYiW8vanqihABfwbaNtb8ZoYxEcWSRsOyi3BFcm/RoetCdtGRw2wS8Aj?=
 =?us-ascii?Q?0iEmRRoFORx4eg0GJ1w6tuuDMLhx4Pwlc6OwAU738PskQPeGmi6T9i9WYm7U?=
 =?us-ascii?Q?zCMvNzQlUPulfOsdZN9A7ml7JU92nhul79g2zXzcLD802fY/OLHYldXpT6gk?=
 =?us-ascii?Q?FZfWIAqG1berL78wfgxYDKlQKdBBvgkOdyUj/SQxDv4F+ZZdkpYUp+ZlBrBs?=
 =?us-ascii?Q?YG7u/eXbA+xgbesPV1R0Bq241GJ/vIe9ksEu8LypdTiz7pePIz2UGa7kDn3h?=
 =?us-ascii?Q?w2Px/luYjkoKKJS8xoiNtD2MjaipFf8CLKaokparWI7Q8aSsDLT050zOhGe2?=
 =?us-ascii?Q?EyYVDNe7ytnm/iQJvaAdTdOLRhQXJno5E85q4+56Fkx8V/oWdIMRWK4Vavey?=
 =?us-ascii?Q?PSSMbfWeBvO7BrdG9J0sL85V9KHNcK1NWjNJN+NreHg6D4g7aZMgF+S2BZra?=
 =?us-ascii?Q?g9lCYSmwODTvmSh0CQesgwAUL+1DkenTqkdIpsbKx9jkBsCAgvQDZcLp1gRV?=
 =?us-ascii?Q?7MsJqyBLnC4n2yQOp6h82jDhUykmYognKdiqTYxkCgx1yx7XOc0jQMsgq1tx?=
 =?us-ascii?Q?wRQ+Lg2BOjEtLY+kmGUDjPP1+9ChD9j0mUpMVBiapceUZqXxONgo0vDkfxaV?=
 =?us-ascii?Q?25fyGT/xK2YEfzUqR5hAtZHMggloh/MGNnb7lTlcJGcD5vAapbAGkZMvURaf?=
 =?us-ascii?Q?stjAs1zft3HrOs8jQTVYCwuco3jf8LZOsLUdMRmptmUH58w12Rp0sjE9GWGg?=
 =?us-ascii?Q?JweH3e9BV8LVfpbcy+Mer5UYGSnOmCbURney5gYnBOscbvcR2xqSFqPJXrqq?=
 =?us-ascii?Q?2ZdTS3lRxC3dBHw7zAn1rUTKmkyC/QNZTC42Y6WrMaGTGWKIMH46bHy+cUbE?=
 =?us-ascii?Q?Y6Ce157QlM87G4Ui7i3bfzAERA1Cn6UhcGXtDEqzwcKYRw33R28+OhX2za1g?=
 =?us-ascii?Q?Q4UQ6vlD3zsaCVbECHze/zEk8zSOpk2KLqDtHxxavXF/o/Jfm51h7QxMTaN1?=
 =?us-ascii?Q?pI1f/NlGQA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd6e5fa-68a6-4246-a78e-08dec62e1562
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 13:50:36.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4+rc5wBxRgEP7CFr5BigU9itG2zcHSo/8u+dewR0AG+JP0jwMxBWELGa9NAtTlyrCvRvIu2EdAC3DlW/S8d4d5SxMzRNBa3AvA8Eb5TIH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0631
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297057-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,est.tech:dkim,est.tech:from_mime,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF14C660C78

>Subject: [PATCH net v3 1/3] tipc: require net admin for TIPCv2 netlink mut=
ators
>
>TIPCv2 registers mutating generic-netlink operations without admin permiss=
ion
>flags. Generic netlink only checks CAP_NET_ADMIN when an operation sets
>GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so a local unprivileged
>process can currently change TIPC state through commands such as
>TIPC_NL_NET_SET, TIPC_NL_KEY_SET, TIPC_NL_KEY_FLUSH, and bearer
>enable/disable.
>
>The legacy TIPC netlink API already checks netlink_net_capable(...,
>CAP_NET_ADMIN) for administrative commands. Give the TIPCv2 mutators the
>equivalent generic-netlink gate. Use GENL_UNS_ADMIN_PERM for network-
>namespace scoped operations and GENL_ADMIN_PERM for
>TIPC_NL_MEDIA_SET, which updates the shared media defaults rather than
>state owned only by the target network namespace.

Given the legacy TIPC netlink uses netlink_net_capable(), we should keep th=
e same behavior
for TIPC netlink (i.e, not using GENL_ADMIN_PERM) to better support user na=
mespaces or containers.

>
>A QEMU/KASAN repro run as uid/gid 65534 with zero effective capabilities
>previously succeeded in changing the network id and node identity, setting=
 and
>flushing key material, and enabling/disabling a UDP bearer. With this patc=
h
>applied the same operations fail with -EPERM.
>
>Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
>Link: https://lore.kernel.org/all/20260604163102.2658553-1-
>dominik.czarnota@trailofbits.com/
>Assisted-by: Codex:gpt-5-5-xhigh
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>---
>v2:
>- Use GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET because it updates global
>  media defaults, while keeping GENL_UNS_ADMIN_PERM for netns-scoped
>  mutators.
>
> net/tipc/netlink.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c index
>1a9a5bdaccf4f..5bbe134284acc 100644
>--- a/net/tipc/netlink.c
>+++ b/net/tipc/netlink.c
>@@ -152,11 +152,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_DISABLE,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_disable,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_ENABLE,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_enable,
> 	},
> 	{
>@@ -168,11 +170,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_ADD,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_add,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_BEARER_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_bearer_set,
> 	},
> 	{
>@@ -197,11 +201,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_LINK_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_set_link,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_LINK_RESET_STATS,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit   =3D tipc_nl_node_reset_link_stats,
> 	},
> 	{
>@@ -213,6 +219,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_MEDIA_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_ADMIN_PERM,
> 		.doit	=3D tipc_nl_media_set,
> 	},
> 	{
>@@ -228,6 +235,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_NET_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_net_set,
> 	},
> 	{
>@@ -238,6 +246,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_MON_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_set_monitor,
> 	},
> 	{
>@@ -255,6 +264,7 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D {
> 	{
> 		.cmd	=3D TIPC_NL_PEER_REMOVE,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_peer_rm,
> 	},
> #ifdef CONFIG_TIPC_MEDIA_UDP
>@@ -269,11 +279,13 @@ static const struct genl_ops tipc_genl_v2_ops[] =3D =
{
> 	{
> 		.cmd	=3D TIPC_NL_KEY_SET,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_set_key,
> 	},
> 	{
> 		.cmd	=3D TIPC_NL_KEY_FLUSH,
> 		.validate =3D GENL_DONT_VALIDATE_STRICT |
>GENL_DONT_VALIDATE_DUMP,
>+		.flags	=3D GENL_UNS_ADMIN_PERM,
> 		.doit	=3D tipc_nl_node_flush_key,
> 	},
> #endif
>--
>2.53.0
>


