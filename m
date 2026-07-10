Return-Path: <netdev+bounces-306549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QyNMJfvtUGqZ8gIAu9opvQ
	(envelope-from <netdev+bounces-306549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:04:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27173B0BB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:04:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=UwdJj5Lp;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306549-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306549-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981A430612E1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E942980E;
	Fri, 10 Jul 2026 12:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0F41736F;
	Fri, 10 Jul 2026 12:57:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688271; cv=fail; b=lQtuwbbmbuGIEStm42dCdIPvTxO8dWvnbMjwUpPBljOxRB8ryT+b0Hx1ac+dG8wj2AmIA3B/3XclRqweAuo7LiT1XSI+/kt5c6UePqO+jBJnh7DXe4tuJ8t67fuzypLrwePne8Ba1qgwMOFGlOPjAnahHMa3ibP9U4wbipIlhV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688271; c=relaxed/simple;
	bh=t+aLWLHcSxfgViHDPRb8LZOv6v794vcNErAAJGFUVNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCmtqc95sEgLvQqXbaeod/+/i65WeDXwy5PUFbc74r8aGPNaq5Qu3cqg2BcEnRCVYpWwKQdI3wEfPBkMoMmr/7aTLjJp1bCAee4h3nwlPTI9qzRTtA5wnBdpOiIXaPemDcgYsf3/vjBrUKyr5pvleu/XIYZ0hEx2Va8JeZCoV7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=UwdJj5Lp; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZiYOtIxP19XCd6d8CVicu9yM6Ww/IGVcrIpzsTNaJl4La/+grmLHv/ZxqEbhjQ3PuHMQse0fo5zsThnsTLevgyDpk2D8Uod3JB1Wp4rX2afOVNRdQQTdgO+EG79jKhsOa2cldVbp4kqxlTO4UAjtiQgSPB0z7+3NSvCX2/Oq9Hxz0qNxSYNY+DKoEXHkKDfYEJEXv11VSHbmj+sDOLHL8JFLZa/8LMBvLuEUvMVj+tJtKw9oZkBm6vBqP2vxF7B0BZczwVeZfr0TrFFtYlYiTjdE7t39Tm6WfyXjOibn1oKLjLfHRce/wWd/H3b/1pfA4zmoxyozX4L1Aomggt6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMr9BLt4ahCecrX6ZqWFbl5Vmv45tjw8bqXAYM17FPE=;
 b=a1mBQOUXGdhOeaOCuWmfuoLY7O03l1t+5MZG0+ZaBuK7BrA+kgbSBvcKFYodfaBl+/ZLDL92a0Rmp4LHIapq7W1MRmx+mUtmtH27v3lCxud/TbTDKXqNOqjCrNXvBulca33CvJ5+VRsnEecsbZkG/5Np0VNfjLPpqgr2NyedtaUVw7YitJN4Q6OOjuE/2r7q0chzSEQeV2skm/9FKUWnPV2AX1vgoJjKKYU696zrPw3NU0PnIk7r5PhYPH7XkTbuZfxNjM3kPjXx+ZkXf9EJd8/2frBz4laAaT8tEoeKba9W8pCUUWQv2jsHdS7JeczaFQr18d9U5aHqzCf+MN+6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMr9BLt4ahCecrX6ZqWFbl5Vmv45tjw8bqXAYM17FPE=;
 b=UwdJj5LpHPWPDALpXwOBofFkPG6tcoKGlbR1KnqTewUHFYkC0h8ERXqVRFF8J7G3JPxFnv1iXXmZOoBZF4YbuWfQFmMp9b3pdyQOyQ07LZtQ/7KmzHJ9DFOhBsIQTf+8l4ZviowAqdWjrKD0o41gL47POER3b00XBq5a3ULPRN7ixTd/fH6gCtPtoM4OMGPyi8KGGK55ZFD2i3q1u9eLI1/mmQ8h8RVsnNzYTupoiAW65Ym0JzMHEhaBfZ2Q5ErFxl5wWMhH0aK2p4k2NHtHPZ4fZbuMC+GJDa/vIYZLHus4ry7uCjokEhNQ6/shuR0879r81ZhrzPkqH4+Zh6HqRw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DBBP189MB1196.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Fri, 10 Jul 2026 12:57:43 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Fri, 10 Jul 2026
 12:57:43 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "AutonomousCodeSecurity@microsoft.com"
	<AutonomousCodeSecurity@microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
Thread-Topic: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
Thread-Index: AQHdD+hHh2DWAInb/ECCJxp8DbA8n7ZmtBDA
Date: Fri, 10 Jul 2026 12:57:43 +0000
Message-ID:
 <GV1P189MB1988A52C474B5F7D7A9EC00CC6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260709211649.15623-1-blbllhy@gmail.com>
In-Reply-To: <20260709211649.15623-1-blbllhy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DBBP189MB1196:EE_
x-ms-office365-filtering-correlation-id: 386d0978-54f0-4ce7-a842-08dede82d509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021|13003099007;
x-microsoft-antispam-message-info:
 sG3IzedTuVmAvPHzoYDkWlpwY34S1KcJMdk9Pu5n0GXiszNweKdE+59tLeLz+7vithqMB53THV/BO0khf47AynRM0tiZ974HPabFD+2aQojw3oLYgBD4V2DYoNHpEklYhMGAzTG2ZGUFqi8u1+jLEOeGZODZZQRhwaacL+knhZSGaic7wqY0UoXJv5l6wPX4rj9mdehy7m9WOm6dswvDwzWwNr3c1MpsBn0MSYDXSB4JPyAvRWZrSA3x39sJJHq9KtHURbL2osfzgrPujG2UBHmsfGgWRbGNgGvygyC8bWEczBPyR7LjwNNuz9RcV8xdvdaFsBVBcKYr9B08VLb/UoeqYGpP4o2YdDLyEo3uYv5oHPx6+5fBbYSgFlJFxxFGp+l+cBsLV6Zz3PE98eDk9ZnOyGtr/iYloAArrWgHOHw7X9fmlYEn3LcQvx+Sq29B1/jTtWkPR2iyueR/S29/YDCqPCFVqETRJy5dI59+DcH4sN+5Kb+waawPC/+U7LlIxSn7F8TEFAMgCyxkKI12KIgvs9zVtlT0dys9oLXAAi2B3WVjdoFVWfVNAgs5xMffJhDDyOOEYNqfwv+gYHLvCKVryLonPpSv4Ri+LQAmvT4YQ52LeNMk5YrMisH4GIIxC5PijK1MYffxSOFtc4ns0DGC50GAB8UvPtUVJQccD1pofQXx7W2TkehBihY2C4/31KAU272fvySnbPf9FiXV6FArI/dtQTXMzNqBKfglTmo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?raNcuYHZXyx2JSzB7A7EoSoB1ztQAkY+DUrWfc494wFoV9+5rtSrEb2XO9SG?=
 =?us-ascii?Q?Xw2VUPvulNbyp44gd/LWn9tdzjz9lmKRx6nARkNHIfw5+Pp+pgdYGIALumVD?=
 =?us-ascii?Q?qDGhW0tVJyB6Lhp//3U0OTnlDlL2cTTrjaZPJ9zALjFCh62mom5YK2Y8lij0?=
 =?us-ascii?Q?TXxcDs89P97VLstWUqtvz7rpWh+DphysDM9zHIVZU3XMzxS7+LUQmaY8dtmZ?=
 =?us-ascii?Q?U0JiXIAZ+M4mEGYiubsTvXvlLy9EFcEH0x/rdShOGMQuyj9UlATudSAt6Fah?=
 =?us-ascii?Q?FRKY6ZwbiLM742YcHLnJsOpk6M8uVgNEVUbNn+96Mnr41/nSOLJ1AjEBoVZ/?=
 =?us-ascii?Q?0NLJH6DYbgXyP+0aay11kYofHx+1vJmwAgt5t3t/ilP9dNWherv6n9+yWeUs?=
 =?us-ascii?Q?d03xNfdkNKPDY3AVCZnpHGqzTbO08IRivvROUcjiARgztaNljNGJ2UAh6GoH?=
 =?us-ascii?Q?yU1887ijofEkYrUoE/5MfuQVXN+xT0og/V+34hHLXGIoPOH9GNJCaCt9DzkD?=
 =?us-ascii?Q?WkLbYhF+c//SaH4i4DtCjRQX5NUviYxOdya8i2UnDKjDKtsnut6dcqadExCM?=
 =?us-ascii?Q?Wc0E6MasCMK3azUz8Ss+VD4nTZ0kAA9vL68JtP3/ZTpjVjk9UUVWKeYL0pTO?=
 =?us-ascii?Q?KZYQfr1lHO2bZr7q1l2RTIHGdIrnrouxmr3XMUp81gukk483nXHMk2ybTrVM?=
 =?us-ascii?Q?FHPr23Y67ZLqxiHl2uz3V66cGpNitqJhlqa8R9XV7g4aGlOjFrb2dYVoky6A?=
 =?us-ascii?Q?neVKMvpx6liACMQ6upjn73FaJWI6PmJUZAAHHaJE3XqlxxCrkhvRjRuavopr?=
 =?us-ascii?Q?fvmpuFvh92IS1EvwCuzWOXhtLJQnLcHhw/U6y2P83cKWNK74VuQIKp2F9tZr?=
 =?us-ascii?Q?t+xKSSgtSpyO31pFYhTPQ7h5dB4PKvORShsDC53Yv/PsjwdqCKSf/uW4ah8p?=
 =?us-ascii?Q?/JwiWflwNV0yNlcR+Ip+9Mi/U6gls4O81E5Dy6atpYRFx4VOMwfCYKUXJJ5Q?=
 =?us-ascii?Q?eRKKK3S67mRBVM1yWUiiMFkqJcJ1ApGRh1Uyd74Pfe2vd+aZuJvazrseqicG?=
 =?us-ascii?Q?IDViogcutdskkytc8mX4JS84JBwRAVqKteGaKnAiDRfGk2NngzAiaiT1GMiX?=
 =?us-ascii?Q?NrubNeGZgeX9c/9/gcHHqDfaA32GNVY9dulWMpM8LkFHx3bZ+D8T8YzC/mps?=
 =?us-ascii?Q?nujMQg/oP8C8p03w/86rRs34wN+wh61CxZKCGIpdIxVQiTquFqpU0BEpy9Gs?=
 =?us-ascii?Q?/uNKKaYfWLqHWoTbHtWB55rAPJlX45dFnybD9RRNr3laRbBAmc0c03OFlzRA?=
 =?us-ascii?Q?Iq4k9axsODK2rZZ1Z0G4zsqR+cBZUAj+gMeA0g4bFKRduWNKmxwcOaU9AZmf?=
 =?us-ascii?Q?NPxoXwHgD+VXhAGMekbsOOdUS1LX96szVVib5UYEAi+7CNH605Gt2NUV0Enp?=
 =?us-ascii?Q?1F3m+mkJKfJrRYbq6apzGiPZEtm4r+CZ1TJ1sYM3GG26o7frUihmYkQtxUzA?=
 =?us-ascii?Q?qasXhF+qqA3gBhbxuTD0FLXtNWssNAOaejSdD1q/R/+IDZNxiK9RJbLSN9sd?=
 =?us-ascii?Q?LcGcP7mj6N0OppuH/tcR4SOFckaXZbkpVhzSxYO79LE7C2xCQLHmL2cnwZsw?=
 =?us-ascii?Q?9S1DZxv6V5BBRDy/+uhP3PgIsVNV/ZebpU7/4BtMz2KBjEi6TjQ8S1YlcHM/?=
 =?us-ascii?Q?YmNDbwG5nL9yDKqD5uwQH1m0/LLqBVVxmuwIgd13ntkeIiuTYbabM10RC0NR?=
 =?us-ascii?Q?BkDPiWnWeA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 386d0978-54f0-4ce7-a842-08dede82d509
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 12:57:43.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sZHfBcgm2+K3HOn0QO10TbNBZXjPJ7FAdqvp0UVAh5y+bJR389k4HVbK//VV82wpD8EbjxknCQZYJNw/dUTG+34GC6pdY3Yp33O7EAzqpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1196
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-306549-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB27173B0BB

>Subject: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer M=
TU
>validation
>
>Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
>MTU values but only enforce a minimum bound, not a maximum. When a user
>sets the MTU to a value exceeding U16_MAX (65535), it passes validation bu=
t is
>silently truncated when assigned to u16 fields l->mtu and
>l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
>truncate to 0, causing a division by zero in tipc_link_set_queue_limits() =
which
>computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing values
>(e.g. 65537-131071) produce small incorrect MTU values, resulting in link
>malfunction behaviors.

Yes, this is a bug. I can reproduce the same div-by-zero.

>
>Crash stack (triggered as unprivileged user via user namespace):
>
>  tipc_link_set_queue_limits  net/tipc/link.c:2531
>  tipc_link_create            net/tipc/link.c:520
>  tipc_node_check_dest        net/tipc/node.c:1279
>  tipc_disc_rcv               net/tipc/discover.c:252
>  tipc_rcv                    net/tipc/node.c:2129
>  tipc_udp_recv               net/tipc/udp_media.c:392
>
>Two independent paths lack the upper bound check:
>1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET) 2.
>inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)
>
>Fix both by rejecting MTU values above U16_MAX.
>
>Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Closes: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=3DF-
>CKjGXsK6_WDv0=3DkbYRcC8-noo+amnA@mail.gmail.com
>Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
>---
>v4: Add .min check value
>v3: Use nla_policy check to limit MTU max value as suggested by Vadim
>v2: Solved format issue
>Link: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=3DF-
>CKjGXsK6_WDv0=3DkbYRcC8-noo+amnA@mail.gmail.com
>
> net/tipc/netlink.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c index
>8336a9664703..811438c44542 100644
>--- a/net/tipc/netlink.c
>+++ b/net/tipc/netlink.c
>@@ -113,12 +113,17 @@ const struct nla_policy
>tipc_nl_node_policy[TIPC_NLA_NODE_MAX + 1] =3D {  };
>
> /* Properties valid for media, bearer and link */
>+static const struct netlink_range_validation tipc_nl_mtu_range =3D {
>+	.min =3D TIPC_MIN_BEARER_MTU,

Adding lower threshold checking introduces two issues:
1. Existing function tipc_udp_mtu_bad() can never return "true".
2. Breaking user-space applications looking for error message " Error: MTU =
value is out-of-range". Look at the error messages before and after your pa=
tch:
[Before patch]
node1 ~ # tipc bearer set mtu 15 media udp name UDP0
Error: MTU value is out-of-range.
kernel answers: Invalid argument

[After  patch]
node1 ~ # tipc bearer set mtu 15 media udp name UDP0
kernel answers: Numerical result out of range

>+	.max =3D U16_MAX,
>+};
>+
> const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] =3D {
> 	[TIPC_NLA_PROP_UNSPEC]		=3D { .type =3D NLA_UNSPEC },
> 	[TIPC_NLA_PROP_PRIO]		=3D { .type =3D NLA_U32 },
> 	[TIPC_NLA_PROP_TOL]		=3D { .type =3D NLA_U32 },
> 	[TIPC_NLA_PROP_WIN]		=3D { .type =3D NLA_U32 },
>-	[TIPC_NLA_PROP_MTU]		=3D { .type =3D NLA_U32 },
>+	[TIPC_NLA_PROP_MTU]		=3D
>NLA_POLICY_FULL_RANGE(NLA_U32, &tipc_nl_mtu_range),
> 	[TIPC_NLA_PROP_BROADCAST]	=3D { .type =3D NLA_U32 },
> 	[TIPC_NLA_PROP_BROADCAST_RATIO]	=3D { .type =3D NLA_U32 }
> };
>--
>2.53.0


