Return-Path: <netdev+bounces-306621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XmL6ML8TUWpb/AIAu9opvQ
	(envelope-from <netdev+bounces-306621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:46:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA773C5EB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:46:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=UWe9E0Tn;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306621-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306621-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9D0302BA51
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE64430CF6;
	Fri, 10 Jul 2026 15:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8371431E4A;
	Fri, 10 Jul 2026 15:39:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697964; cv=fail; b=BDVJo6bIGgy40/2CUvbJROPIuIjhsEbA9k29bMNZh0oS7utrpFvRJ5uBz4ZifSLF02HX8zFC1SV+SVHxmLrxOTkFamm0yeWm28u5crh6JU9/NHYceSCkp5BqhgcsyC+5IHtydV8jKwC2Ngjy5jJ1Yi2gZRs+qEQMBO7LdKlS1vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697964; c=relaxed/simple;
	bh=Zk2BEP2usGlVBwyzqqxpJlki3+QSNDSMhXY6lExup6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G55Xdbk+HAiqwypwSkvIOGS/lrrDUoSYIFsCC4r4/z+W2Zn7GyTJwQumMdQM6G8bjKgzpCG4YZEhZcUpLiLN3JT6YxHIYTYoGvnLwqbzsSTQyM2BXXQLkDNjlVFcO2qaZYXVNJsYkH7qKl3LHGtpcEUY9xjfi5bVAimhID3Gzfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=UWe9E0Tn; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb37T/i7hO4o7RYEs49ILSAGXhrvfk6/f4JECW/gnCBRtQrNVxBaZYyBWyyOBjghr34GKGGCLOLzMg+IDuEbKZlfzdaso9ytvoSi8wZyw8QO9Emn0FG1o+OUBnMQarsifpN42WL9yfK4BZSQcVFf/Fc8gL4VAGkwuAJJPAduQsrXcaVxAsHbOVbRWj70GJ8tOGaQtPdW3+rQi63DNMq1Df/29CuA79E7hDc80s+OZr7/pLew2CaNM8kTGnCPRjDmR1kECfOpABdNsKJ+lklQSN3D4k1yZBx2nYjb8qRpZlr88OI1m9VK0Ro/xNPgnRFG0izupsRKR/ngqEVn9HqMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qmewtVhkQ9cO9zFeylS7vhTqcSPW8PEKIXpETojuFk=;
 b=fHp9ShmK6EgL9lxt1VslrqTLde9GVC9Kg7O96KMl/P4GQIV0LBbF8kRzDzD8yp7aKzCafy3HyejpCyC0zUUDqRCdR0lg/dOwJ0fPpg3mA1vJ5Q70qt8ktfhxZqiVWRMx/sj0v/LrH1NkVUr8HdilTcjogEIg3dhkhLgO6eWSJbiqTVF08iZ+3W1w1Pq4stR3KvWp+c8MWIfY1xGuYg5t8VfTUsHoxxO7CdDURDm8fisOHriJxTSlysnBdS3X8Az110oB+xgUvWP8D9QNuZIJuT2Z70tdKOL7xj90C5GSAZ+WZJ+s88QH5/RovNkbg7MfKm5OuU9ijL+WQdfMhL9u4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qmewtVhkQ9cO9zFeylS7vhTqcSPW8PEKIXpETojuFk=;
 b=UWe9E0Tn3ie6Xzr1yMa/M0uzhkqzNZ/jqsaj6627UzB7l3ZKaPEsNSapOrBtbB7TgwN4gN4HufJUbD055oB/SZbagg4rHld7M/iFsECvLvFGvGP7z2FQ4q2z1Y88c8Qbm2UdzlOtVlJrPvIF7806BNkdv/QalH9grAgvb/OTiU6se4pcga/ikA7Mml1qPGoexqDfOF1D+UloRLu+3lgt7D66SBWX37GDbXcmnqDFvVwmDju8SE3V32yqp2dgZek0R+9yUS44FOP2ho5KbP6HEenaPxH7MGk0v2RyuJXfuJ0Hkkqa7gxxCb4FoKienT7sCvEg09bOfjMBppiP1fcWfQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7PPF4745BC5FB.EURP189.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::690) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.9; Fri, 10 Jul
 2026 15:39:16 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Fri, 10 Jul 2026
 15:39:16 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xmei5@asu.edu" <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v3] tipc: serialize udp bearer replicast list updates
Thread-Topic: [PATCH net v3] tipc: serialize udp bearer replicast list updates
Thread-Index: AQHdEBxTJhuGJP7qP0qIdHAxFDo1A7Zm3+3Q
Date: Fri, 10 Jul 2026 15:39:16 +0000
Message-ID:
 <GV1P189MB1988C5D39A47A8CC235D01EEC6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260710032901.4099197-2-bestswngs@gmail.com>
In-Reply-To: <20260710032901.4099197-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7PPF4745BC5FB:EE_
x-ms-office365-filtering-correlation-id: b21757be-6e4e-4fc9-056f-08dede9966c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|22082099003|18002099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 +f21SmDCXY1QkUnCEtAZcbhl8fJOqdykTcPYcZS3Rw7WE09jsOWOsYJXNu2R893Un7Hb9aozI5YPJGw0E3UrbCPPhS2HOiqhTyV3M4Hx5cNDboqISE24hGUitExKamNULnXfIjI+s4dD7hbjthVtKWW7BH1xmO/MUiGF8LoKE7lSP/a/1021a15US+g/AiudsBt7tmy82MCYiE5tBK6mH4Bo3yfK7/hZoK7XW8PaOqEDPj/jmJ90/7xhxrxZ4FBrgw42H6c8vSsPt8HRvvVNgKEp5vw3FkLiit91aX0gtbzLQEKSGcoD6Hk/qrJi7XkLz+9b/H7nvP1QeLtjOTWVdt09fp1a6gNUTf6DO4swbtAkgxAYLnarM33Pq6VyrCrwqYiLI7BU0bg7ZTHKqluUfd4GQ+aIZPLesIEx1lMxJCAF9UUujJhCPU/CXGefA5nbFaLISZnrn6/2+oHP0sy58JjAl/gS1CVIAerg5rEdI0UI1i3P46LEGVaXZVHane5NriExtfgxV1FXYE6ei2SBW/VDJo0u/QcvGTFVXIO04747vG0kKxSwMZi8kCbc+Snw01L01tiuUixxl10USYQZ9vCXR27/ad6hRuIuuFU0xKo5ZY2Y8n8ThcEh8pXI5CUIta7O9Sg4Cmt2nX6JD+NXeQV1jydChU+qqe7Yoz+xY/ACapy+xSVzi7fGKsPYJdJ52q7Pj4fiEcUr8ai2SWomj5X8SrM1uol+M6yUsSEBTsQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HANDx+1E8ejJRhC5LPfWopTkqpt7jLG9Vwo3r3L8jlYbMItBHgwDVRPs4yBm?=
 =?us-ascii?Q?ELVP0lnBQxuvD6ix3zkcUDipEfH825drg1m9sFGN7ifS2/tMbE1eRIRrE8uY?=
 =?us-ascii?Q?NKvMybLoJa0gL3VOJR9vaNBVI0I+5pt9kD7+qSyAq9uBXkDQvoFZej/mpN1l?=
 =?us-ascii?Q?1GDnBqLeGOb6VD3JDM4gcxWllJMd3yD0u9KVakg0OBQsNzdGSM26laJYx6kZ?=
 =?us-ascii?Q?5xDc5ZCPCjyyf56+/BUr4nAuaTSPU5RsKwzsPQsc3KLxmrrN5ZoXTBCO6p3a?=
 =?us-ascii?Q?js0kpAZXCqy4zeqbZjOmut9DH6rukmy5gXH8wdehCaWfHOWfLuxfACrACBk2?=
 =?us-ascii?Q?SZ0sKywkO7wHF1vAvXz1pTaNseeSyd/VCdl/yKyeNguf8kXUPIZU7khzN2Fu?=
 =?us-ascii?Q?7oUZvFNHpJAKDc7XFh8lXhueWu930lfDe7iIwZBRQ8nP8MItAX4TNehi82US?=
 =?us-ascii?Q?aw9u8dnE0IS2sPFHAlNXZjs3Cg8QIYp+jLaVQMCunpqcnABO0SeZG0JSM6lG?=
 =?us-ascii?Q?/gaaFr0fxl8/V0fULugnzwUPVWQjNVguQStgd2ZhW6DliDL3Ryx6hLhTBfdo?=
 =?us-ascii?Q?h0MzSqqwiDa/nhKkW/nJ4Zu4tYoE7/JoNfv35bzqSugXszDFfj3SvUyIWei6?=
 =?us-ascii?Q?75GZQb4VY6WgrOPtAQm82aDQjuXbs44Um3XaM9o15wAS2BYNFt2GwUGmqkIE?=
 =?us-ascii?Q?VFD5SbVY/MwcvT+70TQqSBVpVZUD25N4e56zTOMD23t9GmeOYxSIXDOM3Hlq?=
 =?us-ascii?Q?1bwY755nXJsGtBeRkkkHyDJMC31BKbAn4Oji4UggloZMXPVuk33itYIzCE8S?=
 =?us-ascii?Q?7BgBdoi0tTjTF1zIDWtIq2m1uLul1ki0H2lwAa8jrYdVQEdba8M125+vPnKO?=
 =?us-ascii?Q?SvXuGoiBfjJcN+mQ9uKbgF6JGMQLu+kB9eNe8brqYNfdqYfY1tRG+dZAU6Yb?=
 =?us-ascii?Q?j5KDHnP6DfIlKHWu4/bOa+Qh8HeE+NyRf695E0rii2NOAkOLwe0ryOsc4GBY?=
 =?us-ascii?Q?ufHP0yNWEm6I1H9f7FYIX6hMJkki3GjgejJmRICxynu/xU9QVvuNkb9HbVUS?=
 =?us-ascii?Q?gUeeVLWPefAeLS5SKiHxQFGrPn4lLVnmrawaZz79jE8NM5jWjlvixi0R3H2I?=
 =?us-ascii?Q?PiCJa8JdzKYSmgb4LhSPyReg2yj/T+KmINith8XHSEXdQ9dAqetzPPZGR9XD?=
 =?us-ascii?Q?HtkXlPqvldLeHsBJP64dP4ay6Xgo5scXSblOxQPy7oYrksKmMshL7RohwlA0?=
 =?us-ascii?Q?EM+Hepl9Zler3vvFRAipxG87H3l4KubMEj3bUI00AOObW1je3qMCDYvWHIS2?=
 =?us-ascii?Q?YgpufOrZi8iIO8UTRyVluQMFZSVU0iNR9t3Caz0L/pni7xQYLjW8ShXZEXJP?=
 =?us-ascii?Q?Af5vePqGmHmA7h3gKZeUiWsbDozMk6AhKlKDsMTnM7uJVsrxgLck6hZ3DHeE?=
 =?us-ascii?Q?mxe+qGQLlm+cuWjepL1Y8QCQVDDHl9+MoCw9ICG/ovMsWXtzdvM/qVXLyj9C?=
 =?us-ascii?Q?4PeoRpayr5tKr/eHOKEABYtac9TOuzeCPqUnPSH4o4g5M7h/aU6lFKDRSUxU?=
 =?us-ascii?Q?Fm7G6h4oqgv8oDBkHsldRBkkOCMzjNrnOTDmbtrooPyqMidmiK1431j2eVc5?=
 =?us-ascii?Q?OZKs0LMEdiFS/VS1rqD2hOG4DrRilMKwftjsWYcekW9WIHquscprN7otuC4Q?=
 =?us-ascii?Q?Ot4TzX0QdMZ0rrZ0lXo9QMlUGnZJncFwZCTXIPPpKxIJzCYaXynt93RuqQIv?=
 =?us-ascii?Q?VH8CFXzgVA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b21757be-6e4e-4fc9-056f-08dede9966c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 15:39:16.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzhusFXbxtHeuLRtzHLgQ9SQJfZeNkK8/jVnaOQopBfhQ8soKFcKYEAs5nRcc1n59ywIo/D5Qciu+uqntTFCYVy7ka8ga/XtO2D9jYihzkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF4745BC5FB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306621-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22EA773C5EB

>Subject: [PATCH net v3] tipc: serialize udp bearer replicast list updates
>
>tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
>list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs=
 from
>the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(),=
 so it
>can race the cleanup delete and corrupt the list:
>
>  list_del corruption. prev->next should be ffff8880298d7ab8,
>    but was ffff88802449ad38. (prev=3Dffff888027e3ec98)
>  kernel BUG at lib/list_debug.c:62!
>  RIP: __list_del_entry_valid_or_report+0x17a/0x200
>  Workqueue: events cleanup_bearer
>  Call Trace:
>   cleanup_bearer (net/tipc/udp_media.c:811)
>   process_one_work (kernel/workqueue.c:3302)
>   worker_thread (kernel/workqueue.c:3466)
>
>The bearer can be enabled from an unprivileged user namespace, as the
>TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
>
>Add a spinlock to struct udp_bearer and take it around the list_add_rcu() =
in
>tipc_udp_rcast_add() and the list_del_rcu() loop in cleanup_bearer() so th=
e
>two writers can no longer corrupt the list.
>
>Check for a duplicate peer under the same lock before adding, and remove
>tipc_udp_is_known_peer(). The old lockless pre-check in
>tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer cou=
ld
>both find it absent and add it twice. Doing the check under rcast_lock in
>tipc_udp_rcast_add() makes it the single point of truth for both the disco=
very
>and the netlink add paths.
>
>Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>Assisted-by: Claude:claude-opus-4-8
>---
>v3: (per Tung's review)
> - Check for a duplicate peer in tipc_udp_rcast_add() under rcast_lock
>   before adding, and remove tipc_udp_is_known_peer().
> - This also drops the list_for_each_entry_rcu() change to
>   tipc_udp_is_known_peer() from v2, since the helper is gone.
>v2:
> - Narrow the lock to the list mutation.
>
> net/tipc/udp_media.c | 45 ++++++++++++++++++--------------------------
> 1 file changed, 18 insertions(+), 27 deletions(-)
>
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
>62ae7f5b5..3a7d9b15c 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -94,6 +94,7 @@ struct udp_replicast {
>  * @ifindex:	local address scope
>  * @work:	used to schedule deferred work on a bearer
>  * @rcast:	associated udp_replicast container
>+ * @rcast_lock:	serialize updates to @rcast.list against concurrent
>updaters
>  */
> struct udp_bearer {
> 	struct tipc_bearer __rcu *bearer;
>@@ -101,6 +102,7 @@ struct udp_bearer {
> 	u32 ifindex;
> 	struct work_struct work;
> 	struct udp_replicast rcast;
>+	spinlock_t rcast_lock; /* protects rcast.list */
> };
>
> static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -278,30
>+280,10 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *s=
kb,
> 	return err;
> }
>
>-static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
>-				   struct udp_media_addr *addr)
>-{
>-	struct udp_replicast *rcast, *tmp;
>-	struct udp_bearer *ub;
>-
>-	ub =3D rcu_dereference_rtnl(b->media_ptr);
>-	if (!ub) {
>-		pr_err_ratelimited("UDP bearer instance not found\n");
>-		return false;
>-	}
>-
>-	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
>-		if (!memcmp(&rcast->addr, addr, sizeof(struct
>udp_media_addr)))
>-			return true;
>-	}
>-
>-	return false;
>-}
>-
> static int tipc_udp_rcast_add(struct tipc_bearer *b,
> 			      struct udp_media_addr *addr)
> {
>-	struct udp_replicast *rcast;
>+	struct udp_replicast *rcast, *tmp;
> 	struct udp_bearer *ub;
>
> 	ub =3D rcu_dereference_rtnl(b->media_ptr);
>@@ -326,7 +308,19 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
> 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
>#endif
> 	b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
>+
>+	/* serialize with other updaters and drop duplicates under the lock */
>+	spin_lock_bh(&ub->rcast_lock);
>+	list_for_each_entry(tmp, &ub->rcast.list, list) {
>+		if (!memcmp(&tmp->addr, addr, sizeof(*addr))) {
>+			spin_unlock_bh(&ub->rcast_lock);
>+			dst_cache_destroy(&rcast->dst_cache);
>+			kfree(rcast);
>+			return 0;
>+		}
>+	}
> 	list_add_rcu(&rcast->list, &ub->rcast.list);
>+	spin_unlock_bh(&ub->rcast_lock);

To avoid freeing allocated duplicate 'rcast' and avoid storm of malicious d=
uplicate address attacks that could lead to running out of memory when allo=
cating 'rcast', we should change like this:
@@ -308,16 +308,28 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
        if (!ub)
                return -ENODEV;
=20
+       spin_lock_bh(&ub->rcast_lock);
+       list_for_each_entry(rcast, &ub->rcast.list, list) {
+               if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
+                       spin_unlock_bh(&ub->rcast_lock);
+                       return 0;
+               }
+       }
        rcast =3D kmalloc_obj(*rcast, GFP_ATOMIC);
-       if (!rcast)
+       if (!rcast) {
+               spin_unlock_bh(&ub->rcast_lock);
                return -ENOMEM;
+       }
=20
        if (dst_cache_init(&rcast->dst_cache, GFP_ATOMIC)) {
                kfree(rcast);
+               spin_unlock_bh(&ub->rcast_lock);
                return -ENOMEM;
        }
=20
        memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
+       list_add_rcu(&rcast->list, &ub->rcast.list);
+       spin_unlock_bh(&ub->rcast_lock);
=20
        if (ntohs(addr->proto) =3D=3D ETH_P_IP)
                pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);
 @@ -326,7 +338,6 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
                pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);  =
#endif
        b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
-       list_add_rcu(&rcast->list, &ub->rcast.list);
        return 0;
 }
=20
> 	return 0;
> }
>
>@@ -361,9 +355,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b,
>struct sk_buff *skb)
> 		return 0;
> 	}
>
>-	if (likely(tipc_udp_is_known_peer(b, &src)))
>-		return 0;
>-
> 	return tipc_udp_rcast_add(b, &src);
> }
>
>@@ -644,9 +635,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b,
>struct nlattr *attr)
> 		return -EINVAL;
> 	}
>
>-	if (tipc_udp_is_known_peer(b, &addr))
>-		return 0;
>-
> 	return tipc_udp_rcast_add(b, &addr);
> }
>
>@@ -679,6 +667,7 @@ static int tipc_udp_enable(struct net *net, struct
>tipc_bearer *b,
> 		return -ENOMEM;
>
> 	INIT_LIST_HEAD(&ub->rcast.list);
>+	spin_lock_init(&ub->rcast_lock);
>
> 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> 		goto err;
>@@ -819,10 +808,12 @@ static void cleanup_bearer(struct work_struct
>*work)
> 	struct udp_replicast *rcast, *tmp;
> 	struct tipc_net *tn;
>
>+	spin_lock_bh(&ub->rcast_lock);
> 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> 		list_del_rcu(&rcast->list);
> 		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
> 	}
>+	spin_unlock_bh(&ub->rcast_lock);
>
> 	tn =3D tipc_net(sock_net(ub->sk));
>
>--
>2.43.0


