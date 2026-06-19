Return-Path: <netdev+bounces-300718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VfS+CrBENWrEqgYAu9opvQ
	(envelope-from <netdev+bounces-300718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:31:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEA6A6145
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schleissheimer.onmicrosoft.com header.s=selector1-schleissheimer-onmicrosoft-com header.b="kfeq5Vu/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=schleissheimer.de (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49527302BDFC
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ECF42050;
	Fri, 19 Jun 2026 13:31:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022116.outbound.protection.outlook.com [40.107.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71202AD03;
	Fri, 19 Jun 2026 13:31:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875885; cv=fail; b=AXel5QsK9bqOLmUyLzQROSe4WvgLW/qU6mzwEWHC5b3hgQzz7aTnWKXfnpUeT5tMavTmkorqZHQ7X6IlFIg/zKSmG4ygsG2pKVAyZ1B50qzhti1ZJ7Yj7KLWynMBSoqSJO9mGqWBDIbtI6ZmfXxBAeNQ3aGwy2ZaFC4bD2CP+pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875885; c=relaxed/simple;
	bh=rmyV1fyh0NrHeiVGeGB3t9RIJwb3QkFx/K6XTLCmN1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BQHSm6Q7S+Dm6faUyBbaNBbPD/Ogj6J81NBGcYsduebG98PIIKDgffr7PZ26LGJjZ5W0gWTxsBgwL75IQJMbw9mSd+/prShptnfxB1U6oaALxRIjJjepY7THUUHyMCa0g1zIVsSNLEHeEL+z5STFZNDoARolxbel/ojW/Z7kmHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=kfeq5Vu/; arc=fail smtp.client-ip=40.107.149.116
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGEZk4nJ+ILC2ZTlb5Pj2yt0Qr1TUGiS1GJQs68+O3HNsNB4wikv+a7DdoIk008ACY6uZuPXGjOozrWNzrbdVjgiwiEJEAvyGyjuMzL3c6ip5uAyA/aYSFV3qH3L557KhiFhKA0Uwe22HpDEFuPrFRdwRI69riSwsmG4MnkjFFI4c/fCU5/0iQrjazWzaUrSWl81TimG8grjvM6gTz9p9I+M/0YvHU2Cf+RPtiv8Qi0QyY7cs79XPaP0DLSx4hSNlKqJviD1WhG14fOptKKbKsAp/CKFOEsz/O3QMoB1giP6Ra7rUlkPthFJvb2kSu3zHY2toAFyZv6CYAFfAIo1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QChXyCW9BdrBGve57zrValF5/ffVUYgKSopRVyW1JZs=;
 b=pzNWwfJxbM44kHGn8v+d75UnCoyAmPpyEDfYpa4ZPE1QnkKz6+BTp7/VnO9JmYaaSGPZGxlCHnEOrNzBjZf7apucG9hHKERG+IwnaYZmOgt3aZsZaBau424hSQuZemRqg7dK/wR2Tkpr1YsMVypIvBtlWkJWVGTd+E1SlShaQzLee9n1/89/VM56EfVVDybDcep6PqaC2Ho5JfYVSTGGzKvmPa9moW9ROnX1qAseKoukULgj/vXfOW8OZWxr6PhHo63AVRonvPGC5lrxAaQDc+c4fghh1GkNthHs3hLPAkcB1PAiPmV3VVjm09lRrByRAJqzb2LKXFeogl/u6dgt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QChXyCW9BdrBGve57zrValF5/ffVUYgKSopRVyW1JZs=;
 b=kfeq5Vu/0xinC1d+T6K3vZ7qjy+P8MqKFPEp1jhOJGFcYfDJwrr2ogq4Huqne2wBYQRXUG3nv9XJWKdBDK+/uqfVPkvIfSufo8Q+Axfs9667xYpS7C6NatbTq+sxro/FxZvivW/pEcvBclCPlyWTl8031LlpO1KoiBrHdhqSNcc=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by BEYP281MB5537.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 13:31:19 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 13:31:19 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
	<Rengarajan.S@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "Woojung.Huh@microchip.com"
	<Woojung.Huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table
 after device reset
Thread-Topic: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table
 after device reset
Thread-Index: AQHc/1ZL+dYj4wyIHkavMkZrzwxM9bZFg8XYgAAJTICAAAseOIAADC2AgAA5uBQ=
Date: Fri, 19 Jun 2026 13:31:19 +0000
Message-ID:
 <BEZP281MB224523ADACDB48D8E3974D4AD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
In-Reply-To: <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|BEYP281MB5537:EE_
x-ms-office365-filtering-correlation-id: f5a16b3d-e3b7-47d8-b4ed-08dece070bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|38070700021|56012099006|4143699003|5023799004;
x-microsoft-antispam-message-info:
 DQdzLDLcimZ+2LiXMCWq5oR2r/kS+NKCeA6jAvTskJqSiCDKaAlJC1gAHpJA6IgGIE1smzAuz05ZNfc+VG5GtWIG56JyfNtUY2Tq0iOdW8Ak7JpDdl8jOIJ5EoqqydOjp0dW6vTwQ3bBzfwS4VT9tMy02ynmWEr0Pj0JbecVFeElIDjFINZdBmM/IQANP5MZmRO4qD4ozOvie469Nz4FC0krS1NNJfCsEgBEhnubCak3j4+O8L0O0AbNMSo1sJ+KKNhasrjtemxBtJdpmRQEBpE+skJFFhvmvsf/L/FxiQkOQNWiX3BbyQfdwqu/WtspM5sLdemywABsB8BUsmNddmcgVcVl7D79mKzPuCqmolRQij5345i+GgqtePBq6YWEWUL4u2Kwz0GRGdTfWETYPWXVpO9DIx3wy0RT45xhUPL2edTYmpWZgQhR/7rdkYvRXwb/Abc3NXuMPZTMjMljAJ/C6Q4CzlYHrrL0PZqvc5JztARrImR95h+teeSeH35vOmasf8ENLC60RwbqTtJP5sv4042EurH1QqJ8qhhL5BOyJdLQKBcmAaJZh5sTVtn/TgcgmOmeBXykebt+AWxbn+yHfGjQySlr4nbe3oqy6b1ABU20f7hJbabAlYE/fPJgMeUYIanixEO5uqflXKUOd/K/yzDd8uWuARZ20My9yrmcyRffFvWcP/Xvl6uVKTBS4CCggTsxgI6IDwMNpcGQHkEDLqHLGAwNzyaeC8USka4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vweIxcRm5Ro4e5iuCEsvsr3R2MpnnZOVVDw5epKryIzgUWm0/lk6rtLdJt?=
 =?iso-8859-1?Q?ji+sph7sI9pwyejpefIFh/oyXtONuga33IFHU9keIv/1zek+grCKHxXLXr?=
 =?iso-8859-1?Q?cFSQGAie11PARk47IUkezKWa6BuJebv6wRhPS0z4r/grmgR0ypkCJTUHmy?=
 =?iso-8859-1?Q?l8nCkv4mSdeXQiuH0bpK7QMiGDB8OwXmeMWZGvwVQvvLJFEHJBUfj+i8e8?=
 =?iso-8859-1?Q?Q8P7+9Of+IiOSP4m4Cig69Fr7Ge8qmX93KPNCuReInqXQDTNUPbqC+h73Y?=
 =?iso-8859-1?Q?2fxArFTRdoZga9bwSJLX60xIUeUNy6VuP5gNorNK0vE0EckWGieyfhI8tS?=
 =?iso-8859-1?Q?ZLW6BKZvQYIEA7dsNN/mw9xWY4sdpP8kI/Tmuto6NikbiX4nRzAewjFysF?=
 =?iso-8859-1?Q?TVBleQg/ccv59J1xTf/ijhRgL4rv5MS7kiChtmI/7UOHgx0XyL7SLOo9gs?=
 =?iso-8859-1?Q?EQAJl5N96w5XD5e+RRSBDhfsapgJOt4z2TfmFabqfi0OnRjg9+QphKIX+c?=
 =?iso-8859-1?Q?dYiah6Coiic/Sbyx0HBcsJWkVmuJXTyjcpCboFl12YJecpFMzEZlctVYoz?=
 =?iso-8859-1?Q?2DQwLX0/Ebkr5jHDItinIlyHgFysDqXOV5sj/Y2bLEVPtdpILIm3q9TrNu?=
 =?iso-8859-1?Q?iFtQerOlKgneCIpCgMl738g0ehz1JT+6Wzz1pi9QtOO1aBl2FKYqYRYrLv?=
 =?iso-8859-1?Q?OB/xggyR30cPJZPjx8gRcCFbZpHtblBooCcCUNwKyGSEjfzmUkbeBrwRkj?=
 =?iso-8859-1?Q?9g2cem8DSLgodUyKt0Gvik3pFcU65qaWq16k1sqgGVTpsWYkr4CwrtgeLg?=
 =?iso-8859-1?Q?mnq4gtXU7leNyR294J7HhPNzfHHsMdNDw7dUUuRhXvIwX6wB/PCsoWmvao?=
 =?iso-8859-1?Q?oiLaXhBcstp8Dbe1GxE+MGLtvJdNDeQoolhYEZGcef04qJ4uTW5IWyZEAf?=
 =?iso-8859-1?Q?CM960piju5rW5kEWPv0asYHVFXfpr9MqdNLFa2SwfrvMWkH2nYTOMdHA9T?=
 =?iso-8859-1?Q?cEJuPKfGliaTSg+HUk3s6S87k/f1MWqaIFJnLxHUmlDbAqEFqvC31eawsk?=
 =?iso-8859-1?Q?fxceQ0pMW0zCXDLoDg1noomeSyGeYH98I4V39U21ZPFNu+aWpMsjlUVss/?=
 =?iso-8859-1?Q?NQmKu8QZYofYKs6gjfM97HvXkRPVh6i3JHeexAKnMLSI2HTSPtDTjpdwcE?=
 =?iso-8859-1?Q?J0/O8YD70JbNuC/R4MVkywZmu8woeTuEWWNE2NLnWcMjEjRgwPwZHUEAek?=
 =?iso-8859-1?Q?zErhu+6LYrn9nKCEkTycCJT0hSX+uxnzubaaIkY+PtQixPtkVOGGE85BFr?=
 =?iso-8859-1?Q?eW5WQBhEVjNhBJpb54SHH9X58EkrPPB9RCwUaPWC8a2QB+TjvdAoBggfC5?=
 =?iso-8859-1?Q?vfYZicAehhabOkaFf/q6JgpXkLZIV1npIfwknaXWrW0rK6DUMX7nDVIuMt?=
 =?iso-8859-1?Q?WGRxyTB1parmxmWIXuMKjP6LbtR33G/aBCsh2QsCHeuRaz3mgT3U+4J9g/?=
 =?iso-8859-1?Q?v7Eeu0tZX1fXCHe1npmVg7FVGJP9pPZ0i56PoSBBFOQD5MrqJor/r/4y3v?=
 =?iso-8859-1?Q?wulx64P6p8+hy4CjHbjBmDbqfAYPQIkOnnWq2bW2Uk6faZEt6v73x5gECM?=
 =?iso-8859-1?Q?pp9vQLzWLwnNcVg8cw1sHxBSOtMf6/TtCxVn7/SQGv/Pph9yrGLTMAayUN?=
 =?iso-8859-1?Q?AR1dRMV5XsRR2fZkd288oI2irTywsEt59PraTyARLlkAxC1TzSHtKhbp9k?=
 =?iso-8859-1?Q?1DcBBs8n9aj043JfkbaJZmwvSdMAAweEcA3R9rDDsD1TSTFgfDYkpM3f01?=
 =?iso-8859-1?Q?pxhCL/0pOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a16b3d-e3b7-47d8-b4ed-08dece070bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 13:31:19.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzArrZtFzGlaw71ETCgaTBtmBYbhlbIXaVJaB7+QdnRqaQunK3cL/V84sTHxzAter3o1THzOw6sDOfZ6Xo8/MugtCUhuuNAwhMN+VBgMQ1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB5537
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300718-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,schleissheimer.de:from_mime,schleissheimer.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76CEA6A6145

Hello Nicolai,=0A=
=0A=
looks good from my point of view=0A=
(Calling the lan78xx_write_vlan_table() from =0A=
lan78xx_mac_link_up() and from lan78xx_reset()).=0A=
=0A=
But I investigated a little more and it seems the hash table=0A=
(which is right behind the vlan table in the controllers memory)=0A=
also gets cleared. I wrote some random data into this table and have=0A=
seen that it gets also cleared. I think this needs to be fixed too.=0A=
=0A=
In the Datasheet from the LAN7801 I can read:=0A=
"After a reset event, the RFE will automatically initialize the contents of=
 the VHF to 0h."=0A=
Where VHF also refers to the hash table.=0A=
But I still do not understand what reset is happening when I just unplug th=
e network cable....=0A=
=0A=
Regards,=0A=
   Sven=0A=
=0A=
=0A=
On 19.6.2026 11:53, Nicolai Buchwitz wrote:=0A=
> Hi Sven=0A=
> =0A=
> On 19.6.2026 11:18, Sven Schuchmann wrote:=0A=
> > Hello Nicolai,=0A=
> >=0A=
> > my first opservation is that calling lan78xx_write_vlan_table()=0A=
> > at the end lan78xx_start_rx_path() fixes the problem. I was able=0A=
> > to do over 200 connect/disconnects without any problem.=0A=
> =0A=
> Thanks, that's the right direction. For the final patch I'd move it=0A=
> to lan78xx_mac_link_up(), which is IMHO a bit "cleaner":=0A=
> =0A=
> [...]=0A=
>   static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);=0A=
> +static int lan78xx_write_vlan_table(struct lan78xx_net *dev);=0A=
> [...]=0A=
> static void lan78xx_mac_link_up(struct phylink_config *config,=0A=
> [...]=0A=
>          if (ret < 0)=0A=
>                  goto link_up_fail;=0A=
> =0A=
> +       ret =3D lan78xx_write_vlan_table(dev);=0A=
> +       if (ret < 0)=0A=
> +               goto link_up_fail;=0A=
> +=0A=
>          netif_start_queue(net);=0A=
> [...]=0A=
> =0A=
> Could you give this version a quick test and confirm? Then I'll add=0A=
> your Tested-by.=0A=
> =0A=
> > [...]=0A=
> =0A=
> Thanks=0A=
> Nicolai=

