Return-Path: <netdev+bounces-304920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y4HfLcKTS2paVwEAu9opvQ
	(envelope-from <netdev+bounces-304920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:38:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878970FF4D
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:38:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=Y7Fphhm8;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304920-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304920-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528C1375B64E
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F941DEC8;
	Mon,  6 Jul 2026 09:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA74F798B;
	Mon,  6 Jul 2026 09:21:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329693; cv=fail; b=WPdq0FJqhsGCMAV85Rsw6MvzbWJ+2DmDsxKpOogS6J3k7nk9GTzpz7fr5YJIvtsa9JX3WiHRqei6m7GWycI7P5uCUgr6oTxmDnVX1nZlgIt4o+8s+khBMffqtB5OR5SBQewpyE+wrn+xUWe3P5IRaJxcVfIi98uERHYPwR54nyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329693; c=relaxed/simple;
	bh=/zdARgYzfff19CCCW3zjhVgJUofnqWn0yNTwAGZ3fvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQb9+ODWL9nUotfFVtPgvsPUFIEBE4pD5ociUR+JCruiDEeXGs/Pcm8e2ZoddiwWRNOjQbcdEp0u+5HYH9L6glIuTVfFqoYnmvgZnxVLRWqwq6YhG0Barz6nkdikN6uVghlaFKmTN9my1Pj7aveQdksGSsySdCFTvJhN/i/rh0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Y7Fphhm8; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnYqo3Nh87iP91tmEI5sFirRopYRKKJqhX1X5xZLCfYkMPshHVn66l3AvxBUMol3/CCi92E2UBHwSt64gS5wxGVm7u8c55d6OZbIfkz97lF+XgA5f0PZGlJimSGE6vpFF25/WHMtDzRLOTzZB/tMhj8n3Ns6obYW0yuyBym6lLSDOF//0zVAToM45DOqyXd5XYxVRQYKT3VDi80Z2I9bGG8wVEvGxzKI6IdQMEODKjOUSepAiWOWOlh2o3qOaWjPm2qfoseppzKpQUrb2xvTRrdJJnzHcmWLgp8QpcoHHPoJ+Y4C2AYWry0X2SUXrtuuuBU/gMDJ8Tp8jawj6+YoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/BMb6K9Du2Gx4KJybYCtpndt20veqsYmzOpCrT1mx8=;
 b=WkP3u+VjPCweYv42KQKe4u8NxyyYahZZoI8hnbO5C6bAbJkdv3Wyx1CKWAW4uOhzrJaD1qk5zCXB4wTLiR46WMYPIAlyBUc2tBzUioy5Y44NI6PhVp7fWfFaJoIP94hPUWTSfciUBN3uuyPFYx5gYafBc3gsn0gTnBpIrpupQLkZ6RBS13NfiOcHGZdMNmXChmxFxIkLzBwfflZtQe0rbkw7xcNILltLpgQVBVCPAo5djVf5TDyrnNfuFTGIN8BwSO+Df2CBJ3N8srRu5O6HYaW1NAVCsuLd22LFmBocplbHZ6Pv9JEEmH6YFttXOo9RxNC+3bcAYYRWS2zsjO1JrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/BMb6K9Du2Gx4KJybYCtpndt20veqsYmzOpCrT1mx8=;
 b=Y7Fphhm8a5rR8P2Yl8R9pu7fKUs1y5JUgv0j2TrIQTuejBwu5odCkS6H2+yMptTlxaqj69td19m597QKYkiRIRTLNEcqL1K5XYeVXNQWlyP6G9nV4j+tmZOAoj73twnWTerfKoS0QNg9+muaHmtmdUQaTQ3simPZdJpjbkivogObHYb6O+gw5F+cWhrDJcOQVCcEfGUkMM41b2O/TyKVGbsBHfv4c5euqyOkkNH/VHVr8/C3OB6h0I0xkrgEM72/KsvZ6PiPwr33EtHn4JoBH+nqJ+UIk1wRCvtHyD8l4tcMkt0YLruI5azczZYg3Fr7aUHh5LGlF0xSTwfenvGMDA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS4P189MB2304.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:588::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Mon, 6 Jul 2026 09:21:22 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 09:21:22 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Xiang Mei
	<xmei5@asu.edu>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net] tipc: fix NULL deref in tipc_named_node_up() on empty
 publication list
Thread-Topic: [PATCH net] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Index: AQHdDHXsDiyTiIwoZ0u13RwJoNZzgbZgN05Q
Date: Mon, 6 Jul 2026 09:21:22 +0000
Message-ID:
 <GV1P189MB198844ED09B014636A8EB7C8C6F12@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260705115958.1066751-1-bestswngs@gmail.com>
In-Reply-To: <20260705115958.1066751-1-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS4P189MB2304:EE_
x-ms-office365-filtering-correlation-id: e8290b80-8a75-4432-27ad-08dedb3ff1e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|11063799006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 yFIHQTJIM9lAJJBU5bvQRWl7cgDLCniObSl6M1Uw+aqTRKwHxEu0ARPLODdDyi0xaRmd2nVVh4yO8XiZjERfURjU/bUqhuOgGD0emnNeSNdfxDdMVrNfMbVkIGsAo1iOPDU7LlJTgITSqrOZMjwKQrl7reONTrX1ePiq3yfq5oa0qh8BRFF7CKOV8VCAnmwK4oPvIEhCqxQJgkhAL2Ty/lYf5n2nhNAR3HnpaIUzdf2t5kK0rYD5d22BecUvXKr/fPFhgK+A7/luVfPuUdZteUQFoHrxesOzHZ82ilKIoIB8AH/+uj6XtsdlGH3pEvT170NFVQNl6nXkAG8VSWmx9sb4PZyyjT7f+jSrbAPcqDFm+2LCbxrCSeDcOfqtE4R4m/M4NQFpBqKwHqOmY/TnYBYRJ5NpcBVahf9JhEgjr/f2pCJxLTWNoqD9Ucc/jry/RT0lq4MSmYi6ff4HH6LYIBeM/7icXMA6IYqXPl1MeFrRqJ9qTDwZc8OCSaNLXETmEfmzAqkbYXhtTbzOUxMGXDg3ZrKBcr9kVWIlH/fei5ziLl4SVkLeMHgb7MFXNdpbPqdCT8BHlk302Vkz+NRzjwcZLwTyGLxcSx20OUuw1LF8V/8/LN3uS9FwMJ1ZuJ76rYhlSGri3eTWD8Ib1yks8ckgcFqT90vHu0Dci19uP+Sl0P2GV2Yu19BrIFadf3RKEIv7GqP5cP10WhgDZgq9Q/M7/1FekJcJKAift6QZLrk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hInkhAGEe/zj+IGfMCbEhLwvntpNbicY4gKuXfNxIqylOO/Izdu3lD7RYzbZ?=
 =?us-ascii?Q?ywy+j23amKTczHlHQbMLttdtU+TtLPDv4GfdMdL9msRKXqnBUtrBk2bzSfFg?=
 =?us-ascii?Q?DLSM9PvKqClqB1prmgOV6i4iiqH+VQ0Vcg083bDEIpeJEP3gXcb/LIbrVhNq?=
 =?us-ascii?Q?pguYJH7rbA5x6QX634LBAZVoWKQ2mLw3Rz3unQzBx2GNK2UXZCfUwpmE2RuW?=
 =?us-ascii?Q?jJGTJ8ZitTUcCwoKzPcVV6wrT1GbcL15cGIZZCX/Qd/bvSpLUDmRDWSTVUiz?=
 =?us-ascii?Q?DUXOx9LQ1xXKFsJochb97Bx25M4l1LmtKdfIeLzL5T7Eojt88c/SUkQ4Xh0V?=
 =?us-ascii?Q?TG/jxQdxVQez1K1U7phRYV6H+BtgDsX/v/NpYY3Z+qwg8kahxWeMWlBqa225?=
 =?us-ascii?Q?bppdIZQNi1pYv+mrSyTIi37ufzvuyH4BuUM2MEZfhZ3NBUNR8vDDraNyT/2R?=
 =?us-ascii?Q?AsjKSoE8uYYFAGnlUR1QBbPZzQOXRdBV6fi7fiVC+Rvr3uIyU7sJKR/DT2hI?=
 =?us-ascii?Q?80QrwRPE4zB9hvWBdiqlJuJ4EE68jf+NrsJcpYd4+d8UmAPdHD3nqa9efSTT?=
 =?us-ascii?Q?eCc6f+d8ePLuyQk2it4joIlkf6M08A6+t2qPYOL7qyr8wD6Ny3KeV9/4Dd9T?=
 =?us-ascii?Q?+2ThLiFx2rBbYenjbm5i3axagZixp0GYhmo6htydaZIhWcfzrMNr+Hhhwbo7?=
 =?us-ascii?Q?8cAvAQmNeM+GkISMFZD9z/JCyo1bpJNlJ2A+OeCGb2a/hqNG2oGhIV8vz+DM?=
 =?us-ascii?Q?TZzmbnByCVaRhnU6i1Kp0Arivrek34UF5maM8EIB9eHNrpQmWwGzcKaMnV6M?=
 =?us-ascii?Q?Ygr5LA1xArA7NrWX3dFMZABxkB6Jtb91ZDtZpNsc/XWkXKt95b3HKRqJedwB?=
 =?us-ascii?Q?s+u4FtDVhnqxz+ZeVL39Qi0VTu7avo31fkMISq3idqu936wA8WtMCU5jgk4z?=
 =?us-ascii?Q?q6rNN/4KCD4IXlDObaryf6nM7J40HNhaLVJK20H9I/M+oI4a5aWxsonpK74v?=
 =?us-ascii?Q?VXcWpUSKoiHuhqm+s5XdeDJYax3te1KGD4JAYxBmVpq2LTsU1dqIro3vjrJg?=
 =?us-ascii?Q?oarRL12JhJ4sNUaftO1TS8DvCHbj3Kbtgn3FCejea4ntnjUJDZBxnyY5XFCg?=
 =?us-ascii?Q?sf45IyZ0ZqNU9S6NBo5+8HC2iKNIrarfQkFzdbFgMRlZNV0w/w/3M9N2EFuW?=
 =?us-ascii?Q?DrShZAOz+ovo7hvdpFuaU7dYvzjWYjN1R6gL0xauy98Lh3IuPnBHZb/EoQ9E?=
 =?us-ascii?Q?QZqd6Kz+as8qTZDdJZ4cNRjpDzeHlg6Ed83gTqim8xNlHwWHeO1tQWp+nqJR?=
 =?us-ascii?Q?O19aXrDNkwb4w9g6qQ25uyVf71Kd5NBCIn46PH0EyPlJ4RCONSNAUDI3t6yc?=
 =?us-ascii?Q?zH3rz68ZDcnDX7KZOJHKFREYZUjXuowZe72RGqO0J2ldouvq7nCcn9NyJu0Y?=
 =?us-ascii?Q?XSXhsyuiIz2q/npvSb8JFqOEOYXT8/ZF0HI9BUbrejCeBCSBpjDi/OMSGDzv?=
 =?us-ascii?Q?c4ZSL2XeCsoiOL7qgdWdjdjlX++GC9BWWJzVAnuCij/vtMVwvYSZJn8jrGM0?=
 =?us-ascii?Q?zB0YgROK198Jn+6NAh5X5mPrha8NuOAGOw7UqsCq8FcT5vp7aEKQDEWmBACf?=
 =?us-ascii?Q?jdcuXw6FaJiS+94HgDbRILfg6GQUjMF/r+5CxSCMIT79WazStG+pfBCOw3ZA?=
 =?us-ascii?Q?uTtAmJl3Mh12XT15I5FetfE46XgDtfJ9UrmztmEbLP9AmN9BBXB2tHtSNmXf?=
 =?us-ascii?Q?mH9G0zKFYQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8290b80-8a75-4432-27ad-08dedb3ff1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 09:21:22.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKSZB9JT/xFplpVD89Mddd/p5e0upcs1Rfvck+FbU1sbUq6ZnOORDld0h3LN5mTJKbaKj2E6eK9CumyXa0oPcdcJihnYc8oxVgjsr9XSRmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2304
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-304920-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0878970FF4D

>Subject: [PATCH net] tipc: fix NULL deref in tipc_named_node_up() on empty
>publication list
>
>named_distribute() builds the bulk messages for @pls into @list and then
>dereferences the tail skb:
>
>	hdr =3D buf_msg(skb_peek_tail(list));
>	msg_set_last_bulk(hdr);
>
>If @pls is empty no skb is enqueued, skb_peek_tail() returns NULL, and
>msg_set_last_bulk() writes through buf_msg(NULL).
>
>tipc_named_node_up() passes &nt->cluster_scope. With a node-id
>configuration the TIPC_NODE_STATE name is published by tipc_net_finalize()
>from a work item, which sets the node address before publishing the name.
>The node accepts links once the address is set, so a link that comes up be=
fore
>the publish runs named_distribute() on an empty cluster_scope:
>
> KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
>  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
>  tipc_node_write_unlock (net/tipc/node.c:428)
>  tipc_rcv (net/tipc/node.c:2185)
>  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing: Fa=
tal
>exception in interrupt
>
>TIPC genl ops use GENL_UNS_ADMIN_PERM, so an unprivileged user can reach
>this from a user+net namespace.
>
>Return early from named_distribute() when the list is empty, and skip
>tipc_node_xmit() for an empty chain. The empty chain would otherwise hit
>tipc_lxc_xmit() -> buf_msg(skb_peek(list)), the same zero-skb case fixed f=
or
>tipc_link_xmit() in commit b77413446408 ("tipc: fix NULL deref in
>tipc_link_xmit()").

It needs to return earlier in tipc_named_node_up() like this:

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..60ccaa862162 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -218,6 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, u1=
6 capabilities)
        spin_unlock_bh(&tn->nametbl_lock);

        read_lock_bh(&nt->cluster_scope_lock);
+       if (list_empty(&nt->cluster_scope)) {
+               read_unlock_bh(&nt->cluster_scope_lock);
+               return;
+       }
        named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
        tipc_node_xmit(net, &head, dnode, 0);
        read_unlock_bh(&nt->cluster_scope_lock);

>
>Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/tipc/name_distr.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..c04fea4650a5 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -192,7 +192,10 @@ static void named_distribute(struct net *net, struct
>sk_buff_head *list,
> 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> 		__skb_queue_tail(list, skb);
> 	}
>-	hdr =3D buf_msg(skb_peek_tail(list));
>+	skb =3D skb_peek_tail(list);
>+	if (!skb)
>+		return;
>+	hdr =3D buf_msg(skb);
> 	msg_set_last_bulk(hdr);
> 	msg_set_named_seqno(hdr, seqno);
> }
>@@ -219,7 +222,8 @@ void tipc_named_node_up(struct net *net, u32 dnode,
>u16 capabilities)
>
> 	read_lock_bh(&nt->cluster_scope_lock);
> 	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
>-	tipc_node_xmit(net, &head, dnode, 0);
>+	if (!skb_queue_empty(&head))
>+		tipc_node_xmit(net, &head, dnode, 0);
> 	read_unlock_bh(&nt->cluster_scope_lock);
> }
>
>--
>2.43.0
>


