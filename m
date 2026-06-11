Return-Path: <netdev+bounces-298089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /LF+C+aZKmpqtQMAu9opvQ
	(envelope-from <netdev+bounces-298089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B5671414
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:20:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etas.com header.s=selector2 header.b=eMr08qPg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298089-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298089-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=etas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2930F304C06D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843793DA5B3;
	Thu, 11 Jun 2026 11:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FB388E66
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:15:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176527; cv=fail; b=BjWXo2urQbZCcHUogQp0H0DuacpnTgVGtL0JxdRrh7pOvRuRYs703Y5jggNqVeuzVy2dKALK1OoEcFGSpD9GaCKp1RZ/zLQV1lGOFOK3M6kjpl7kNqGZ3yA1LJYXw5/7mP7YNPKLkCMco4RLWpKI4hOKGRYVyhULQUJAlJ4mzGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176527; c=relaxed/simple;
	bh=3FqkrOp8KY4U/A9iaGttTUfR7N8MPjjMKQcgclBe7E4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+j6dQ3MkOMYGXWvya3LFyC5WZYSvedAnPiJt8di8QVQ6ruBEE3UGRw5yZKwUdeSzpNO5Fd77HiljsFRQOjDKxLi68TYN1jWKdtw7w3GD2yVNxjwl791YGpKZG7btcB0c2POH03JF0Wh2g05aw59Obf2MM9FeP9fVlk6aowdZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etas.com; spf=pass smtp.mailfrom=etas.com; dkim=pass (2048-bit key) header.d=etas.com header.i=@etas.com header.b=eMr08qPg; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFkIKcLona2jy6yauc3eUrkPjlRdgRB/eMHayu9CJyuCkdfraog9KUEcIMx0aZyA1Y1bhZZx+KCKRQeX6+RhdyX+mn0b9srqqP23k0uol8e92DbqSZZBx3WHH72122qIusuRN0XiwS43MQ5yw8ntUoH+dsm8kRho/TUgsXgekiAEcNgaprKneWAIllc2LWA5VCJsLY9j3qVn3pmwEvuk2FWxuHdHr27nhjLOMpYFMmKDUCl9Xukf6vN0WFT/KhGEu6Sxy09uK6YPSaGxQE2JuoAN9HJaCaBj2nc9hX9CoihmhZvYsmVXuzQUrJ43zeCaV9/a/9s9/JBXHt2kXZsqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FqkrOp8KY4U/A9iaGttTUfR7N8MPjjMKQcgclBe7E4=;
 b=O9POzzy5MBDDqwvopddmp7yhRjEDwWervrt9fkVTSRHjXc7gAbvn+6KM4Jk5FbB2BATBgmd2VNkUcOOE9JDqtjExaibJTfE0BZwrX1Gle2nGBNkzElKiKQS+VIHEfaTDG1xh2d9j4ieChxj4KlYEpcD8Mrj9vr/H3Uw/pyfrGwLj/hsbDE4w1w1yjyndMBsJmIVrGlqFl7tjGmkP4NRh2JcbbHBNxIguzZzuKFpnqFlQeyrfI4PV+jm5BsNqGJ7N27ig9v2I+a+jmtJCgsfbFZ14evEzJevF5hjm3k675hNK5rvZOTrzjgp6QTU9kAVuFgCWPTIAkuEhufyBfeQkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=etas.com; dmarc=pass action=none header.from=etas.com;
 dkim=pass header.d=etas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etas.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FqkrOp8KY4U/A9iaGttTUfR7N8MPjjMKQcgclBe7E4=;
 b=eMr08qPg6WC3HcZPUTrinR/2fNgvzh2R8nmy45qimgXwbR6CuMnASmHJ0OaXEMF7cYQ+EjaE+/uU9tBDeZjPH6v3aTyp0SaXOfxYUyaZvVnRQo/8eY0eEJAksyVWOYAT21TEBgU7KoYak6CjMwbC0VnFFf5+oz7Syq3Kn1iWq4ggzbh+j5+kyjalDc2DYWy/VLqfXElhgziumEZmRlcW5cr9iRFjidEN5cbBb8kgYm0vHuF4gdTLZGzTR9ubU+m9uE2/jsG/sLmxiZgY4qwhsvTLOTcP11YeaszUIHSrPTH2+FujB6ME9DfbbovYIoNyTlIW1gojSAD55FgJ8ODllQ==
Received: from GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e9::20)
 by VI1PR10MB3471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 11:15:19 +0000
Received: from GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::142d:3d0d:e935:bf09]) by GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::142d:3d0d:e935:bf09%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 11:15:19 +0000
From: "Koehrer Mathias (ETAS-ICA/XPC-Fe1)" <mathias.koehrer@etas.com>
To: Paolo Valerio <pvalerio@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, =?iso-8859-1?Q?Th=E9o_Lebrun?=
	<theo.lebrun@bootlin.com>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: AW: [PATCH net-next v6 7/7] net: macb: introduce ndo_xdp_xmit support
Thread-Topic: [PATCH net-next v6 7/7] net: macb: introduce ndo_xdp_xmit
 support
Thread-Index: AQHc+ZG/hL4YmyignEqKKbVs2X18wLY5MgHP
Date: Thu, 11 Jun 2026 11:15:19 +0000
Message-ID:
 <GVXPR10MB8360DB5D2F374574CE33C5779F1B2@GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
 <20260323221047.2749577-8-pvalerio@redhat.com>
In-Reply-To: <20260323221047.2749577-8-pvalerio@redhat.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB8360:EE_|VI1PR10MB3471:EE_
x-ms-office365-filtering-correlation-id: a8cd65b9-9c10-4ab5-a02a-08dec7aab927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 2nqB86nQqHD0GN1ZHMkxMPB/2vq1hMFPkspoUZzgoUqEes3ApJJEpuvm23/zcd0uFQGlCNGeO6yqI4zT7AiJn3ycmVwD/9aW+zE085D/gMG5oSK3gVe80FNXdrIzOxDiK6O02QOhA4tRpXTPtpxn2vm3q+uBgzEvvgY8JACh0g3FbJMzzkx+tP8clpAaYdMK1r6g49z8az2c6DO/AVEb16AegWzbyJf21Jss0euMihDLUN7fYiN0+XZo96ccL+JTG7RQOoS+Sa4NRm0iCLxz54Sclxky+4StiQMVSUJrjXmSmiHZm+bZACxtqyFepEIkqoqBVX046vmzPUTpY029K1AxKoI04TR4t1uBlhRiWslSJThEkVi03HKHEstAuo1LmLbcI6rawixqUVOPi+46IWPnuN1g5W+nXe2A1mFKdZwGw1z6FVgThhWrku1WH7m08xzjLmTN/1O9DnmuTg+oJPVCcXO06dqMM5sG/KVkVzmVLIfF6pnLLw6X1tT/Rva5sf38KJnkyJeUjpkHbC06R2jNp+y6tUBmfFDBYlYaY0/PV4KKoJ0ojdJ5hYt2HLRgnxqLKmuz375qFGkr2QKX6Qt+zN1Gb47sC2WmASv/kWMyjoVuDJeTluJse2IEU4PmDcdv2FF67U4JGndFWM1HIaib+VGoWtngUlN6Odx7tWd8JpRfw4YsgdjnQZ4ns1MkM8u8eLAXZu1e5cfmFs2fMfPV5W1hVOE76gRQxMM/jMa9Ijdx/i1+g0RDbMycTs4K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?datDmxnpvRSGNXdepuMMbQcKhQSwkDVdLlLThFQ0xNoVHayQ4g/GMKk9e9?=
 =?iso-8859-1?Q?xZ79UPyQ5cgcNXq3fz1oqkH6PAC02mjwfzXilvm/tsFrWa2PgqDknclxEl?=
 =?iso-8859-1?Q?arzNNOac9dtNPMAmtQ1vJ6605dMAWAperkxNEf7mlFBHwlNDAsWW8ax6Ga?=
 =?iso-8859-1?Q?tqZm8CHpC3EMK+eH8EOoTdwi7+1PQzjyoj0eA/ldPMjApVMspX+GowCcHa?=
 =?iso-8859-1?Q?JIfj9yg/xV7ICbjkVDf/Q16w7suj8WzKFXe/2AnSGM7/XljmwUtiI6q7O0?=
 =?iso-8859-1?Q?6fuyc7vu8sw1A5k3Ukk64cbk2Igkravcr4lzhbzhnoYsu/s53Ots3LbbI1?=
 =?iso-8859-1?Q?6qD8TaeZqUYFETGpq1WouJjW8QgMaK7LcJwDHYeO7prf1+YCojjF46QGG4?=
 =?iso-8859-1?Q?230SoEaw80n1yd5FWAuQ9Ms9w4V1POod8uTStd5jhbkuKrSQC4hBovCN5s?=
 =?iso-8859-1?Q?cOafM6KdDs6jvBItOe2URqgdtgBfvnRXVAaQ+aHr6UUyKHJfZDNxJsoqRE?=
 =?iso-8859-1?Q?WHSCq5dvBFAJn3/H+lXZr7xCFU90DInF51nXpvZqfck//jngxBv7KaSB1C?=
 =?iso-8859-1?Q?fPta1J9jSEiNOk84cM0EvAoHMFzLfQSx5cOHU2ygEE1Ut6HIdfSzIZosm3?=
 =?iso-8859-1?Q?JGyarxsDrYdU4N+PbfU/QFDV5S4+fbN8aiqqWl9ekT7Tz5sxkkFIcmXLOr?=
 =?iso-8859-1?Q?ChPss3C6LEs/5MPNHvkkPF3Szo2EmG5qscEOJW5p7G/djz+1i4/bawjQSu?=
 =?iso-8859-1?Q?4iimsrKlszSBQ+VBc4wKsxpoRrdWQlJ658k0sTmBo4n0KTF7KfmoUq7mfz?=
 =?iso-8859-1?Q?qbm8MQ1A0voXWmym89GjloJu6aQ9PzVghRMAlHSYS83E6u4IONRiYRwDYD?=
 =?iso-8859-1?Q?IOaahEEROCHG1gRdrgoRAZmrF0G/Y0O3gScyZVfT/f6S5TKY4r/jifw9fL?=
 =?iso-8859-1?Q?ItJtvoK8VQM3CwBMjLuxkXgiXj569TAXXeB2vohV7pVkAP4xR2vwxpFeHY?=
 =?iso-8859-1?Q?e7vueeuPAMhk3ikf5lI0u9ZOpS4FBTfzd2yFzCileJOr65FGINjBYZN4Yc?=
 =?iso-8859-1?Q?D6FTph18bJuS3bT2gSL5dgcQDpTncmPwyW7JlQvWby637Lc6YPx416GTKz?=
 =?iso-8859-1?Q?zshg/PR1ZW2ZU6LzqljJdInUoMSmPggnX90xL2nV1O0d1D7m3mMyNAXvt8?=
 =?iso-8859-1?Q?HEqY4GZi7LuU5i1LNV7UCUFUyPDP5qG232B7uH8Qt/GktP5PGyJGy+2drD?=
 =?iso-8859-1?Q?EEUBOa5HjOd1wMW2HBAqwfmTYLjgRvLyKimUeEbqha3UzfdvqB/qYHTz9k?=
 =?iso-8859-1?Q?6SU7iF8zEe9Vg3sjD73+YV+WhS+qCjJZkoxw6JH5i4MCzaq8bWXg/BceoC?=
 =?iso-8859-1?Q?KaaXaa0SYM4RWm7zJm1Gmdo4zTQ6LBqNvWfdL6TB9ZRBX1nkHXu7rCOSE9?=
 =?iso-8859-1?Q?Fg99q51+poQYYn649qxShuduIb59NpkgyXn7MYljeeXREHtyjhpNsqcMrA?=
 =?iso-8859-1?Q?1WJ620eQXE0CXeNBaFdgAl0ij7cQ9MbvSXHDrFm1aJ0x6DoV3HUv8tMv3P?=
 =?iso-8859-1?Q?F1TymY5q7EKSQZtgyVISl5PQfaqKMaRYyhWWbyqyjAim/JhCdkVznWXDS6?=
 =?iso-8859-1?Q?JrsErcdDJgLlqQFp1+8itPQt1lZJHVscINd73XGcvT2QC5IxyLfYSbmswV?=
 =?iso-8859-1?Q?JekAnIYz3Xhh6YTz++C40WRUdrUakkzftw+0V6cwFukllFATx9ReJSlKaN?=
 =?iso-8859-1?Q?eg5nwlAjBga5I+eIOSWFwU/VpLx34Ax/Wj/VlIDKQnyPVo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: etas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cd65b9-9c10-4ab5-a02a-08dec7aab927
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 11:15:19.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RmMBp0mBgbWvwlMaKMj6z4PE7aigyWU6doIGIjaf9p3cGvutaLkjTyLlK5m404Mq0iuUacKJxjWVteY0rlgAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[etas.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[etas.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pvalerio@redhat.com,m:netdev@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:theo.lebrun@bootlin.com,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[mathias.koehrer@etas.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.koehrer@etas.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[etas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,GVXPR10MB8360.EURPRD10.PROD.OUTLOOK.COM:mid,etas.com:dkim,etas.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C2B5671414

Hi,=0A=
=0A=
within the function gem_xdp_xmit, there should be a call to "xdp_return_fra=
me" for each successful processing in=0A=
"macb_xdp_submit_frame".=0A=
Otherwise, this driver does not work properly with Ethernet drivers that XD=
P_REDIRECT to this driver and use =0A=
page_pools. In this case, the pages from the pools are not returned to the =
pool.=0A=
=0A=
Best regards=0A=
=0A=
Mathias=0A=
=0A=
>+static int gem_xdp_xmit(struct net_device *dev, int num_frame,=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct=
 xdp_frame **frames, u32 flags)=0A=
>+{=0A=
>+=A0=A0=A0=A0=A0=A0 struct macb *bp =3D netdev_priv(dev);=0A=
>+=A0=A0=A0=A0=A0=A0 u32 xmitted =3D 0;=0A=
>+=A0=A0=A0=A0=A0=A0 int i;=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0 if (!macb_is_gem(bp))=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0 if (unlikely(!netif_carrier_ok(dev)))=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENETDOWN;=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0 if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < num_frame; i++) {=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (macb_xdp_submit_frame(bp, =
frames[i], dev, true, 0))=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=
=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xmitted++;=0A=
>+=A0=A0=A0=A0=A0=A0 }=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0 return xmitted;=0A=
>+}=0A=
>+=0A=
=0A=
=0A=

