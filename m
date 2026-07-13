Return-Path: <netdev+bounces-307119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GTkJFIK+VGoQqgMAu9opvQ
	(envelope-from <netdev+bounces-307119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:31:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE1749DA0
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:31:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=technica-engineering.de header.s=selector1 header.b=IBjwiUYB;
	dmarc=pass (policy=reject) header.from=technica-engineering.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307119-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307119-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3020304E419
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77F3E95B2;
	Mon, 13 Jul 2026 10:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023125.outbound.protection.outlook.com [40.107.162.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855513E9F8E
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 10:29:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938562; cv=fail; b=usIxHKbkNkC4SX1Uv2IK+ZNHdNO8eHqYFbyaC93KqdaGIeAjTxWamix30l/CALLrPt6QpsIAUc1navBPL49pgwBOd6GlDUK4CecCl3Ta3aId8ZeBqqS9G8GvDqoNp8Er+1R8XumZPjQCtih+M6LDmSfK/9iCt+F5zjQgNaqbF70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938562; c=relaxed/simple;
	bh=4JJ2IgtBVflifz5mnuPOy6BZP08WBOCWUoJ2aOQudLE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vFw5JrnZGNDWqc1j4aZpmLhCkhjXQ7axMZT+3MWShXiUmwGxRBd2+Ct1T2f/tgqsPBrsHmJiG7qQaFyj99LRX91P8fltYhuv3KTlrE7GR6lG/LFU+gB1qxXYf/tnmBV3Ss/NFbS/BjrFvny+mfglgKxSQaWZHDgWu7lYCdo+eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=IBjwiUYB; arc=fail smtp.client-ip=40.107.162.125
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOkMBIdvRA67KAWY85+oZreCxDrZAJNWvLZfvMMV1cibVq2lETv4iGmWKsXzmsh1yPUk11nMye0CVjzWUZ0K6BJt8J+ZH6uofggNo/qqAVyCqaUimM/B3eGRVV/mq97MW492rKwQwEh2ozqgrMCkMVrAN4LctM2a/+ouh85qzE0MyaCCBp7DBLgGbVBVmK/qWy/bm0nHC3ssVGnc3KemsxDQmqaeIKFfoxk0PhzLdOKse5Lm7v307mh0L71UKBJLnuHR+S1Mmd+ceyQHYrzqhwfoBWq0WPFopPz1tH1MRN/nDs/nNm8Qbm0BcuF3WVLfo4RGP4kNdiyrzwWj0W+7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JJ2IgtBVflifz5mnuPOy6BZP08WBOCWUoJ2aOQudLE=;
 b=khNCdPbMMRal5YnFkxuee2cCnVAKdfj1REOJZtymuFu5zF979+IXORbXNEJfdb1uFpYFMjDxnRbFK+1a2gnIxZs/rJC8iPdCJOWWL6a5llFoPa2100GIRgAvX8E20Pxp46vQwPim7oGJf9jy3/cp131BNybfcKi2u8VoyEwTSUyIJd2vEBf/zrEKIHBlWK1Ad0k/QY4oK11X5oogUEQU/iHF1e0grQXVUYVYpE+Ohou2PlIjl4K9JenBVaO26+S3ipfjsrDteae3PsjXpTR+TpyPXyLVS18uOzyBbnruRvl7KxKXyyhGut9ir6AJucYhpsANSx8VJaKoG4fsagmlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JJ2IgtBVflifz5mnuPOy6BZP08WBOCWUoJ2aOQudLE=;
 b=IBjwiUYBYFKoEtb9tKJ+CFl9P277Cikz93iHzRcApe/SYBW+WKjNXMVGTNbptsg6GReqKzvk3s+5ZKSzF3Y1Hdxq/4b6dj8L6Da0TgnhWCFezP2S/aOpWrwo4WY2Iw958lhcRyPQZWD86GkSea01e5ta6thibQDp2prddmTWMYs=
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com (2603:10a6:20b:584::15)
 by PAWPR08MB9068.eurprd08.prod.outlook.com (2603:10a6:102:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:29:16 +0000
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9]) by AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:29:16 +0000
From: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for non-SFF
 pages
Thread-Topic: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Index: AQHdEqUvQ2S5XVAteEurgYKiixGWIg==
Date: Mon, 13 Jul 2026 10:29:16 +0000
Message-ID:
 <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Enabled=True;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SiteId=1f04372a-6892-44e3-8f58-03845e1a70c1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SetDate=2026-07-13T10:29:16.133Z;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Name=Internal;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_ContentBits=1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR08MB8021:EE_|PAWPR08MB9068:EE_
x-ms-office365-filtering-correlation-id: bd3d6264-dfa8-48a0-ebb3-08dee0c99740
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|56012099006|6133799003|18002099003|55112099003|3023799007;
x-microsoft-antispam-message-info:
 yIe5ywSE0V+gq611YOL0p+RrUqCgTf5pBo42XU3MdM81pVQnuYRWeMeR2PYA9oZmhOaSHAyFDQ/HEVvhWKNv1tfSmD9TTIWGDfhDjKt/TiUp+QH+w8Nv6ok6tMjz6/oKMY5EZ+bPL99BYxEivXSnxUDUMjmn7F7Q1I67hoSHkx/UvgLDN/BpFC9tl126FAmQ2i567XWU10Tew4887mVPFJWTng6cJHDDgDCdLBQnp72TPxqPCSg50Q6fu86Hw2eNt+vvPKXt31d4NkyDHlSrYmT7phxGni1fuRiQbUKd0TSYlFD7i82VcOcwBRp2q9aymk5M1dcWus+GM8+wLFfrf76eYi5omQLNsZq5SoEn5YN5ZBVb2CB7Zo8YM44vpfXHkDSOZsgUcxGg6wcXsuWBhXh+02dpFRN3zUTWaZwfNx5x0xYvDhOOM7eYzxz5wL9jY1RFJkBDnhnEwfYwGhZIDbpJBWZIfN9UHHr03YxlGQvC9y2usLocQN8BNJ+g8BqUVzcfyAwrg0XupxdzP+DjiMc6S02250m78rUQ//xsqco8SU/N/RM2FSZ7rL2NEdJiaiT20YXOnWEBl8lTly4fZWu7r7iv8h8lFKlMbYj/8kzpy1L3q1Wzb4nSSerhbSEIG9GTDcntlO5fR3aVGgld5DbbOzrK8ukK1N3QAGMk9BE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB8021.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(56012099006)(6133799003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aEggMtz6ybo1Ub/Om+xG7DYI4HMxu0DNKns6IEwPb3pdwuYIuhHGbuOsl4?=
 =?iso-8859-1?Q?QtHtDleInrU/f5ELNB36BdoV1YaYPNQNCKGbgILb+s5/w5l+jIqcTKac47?=
 =?iso-8859-1?Q?1onZ/jqZkq8B/zBaZe4gezwJzjebN5JbfwsnXWaVKcG8UeaiKJa6Xkw53Q?=
 =?iso-8859-1?Q?yniG39OIiKweCzNkyPG4P/UoojPmo7El+Zq2UVwmUtNHXRz744YxA0la1c?=
 =?iso-8859-1?Q?mj3u06MsFNgjOgcYTKObFTE/OKxvE1t+s889+F4KZTibDEqaSezlxReG5o?=
 =?iso-8859-1?Q?dluWyrqPyq5yO5BSmLDOC6BSxFhRzqLTlWTIGEl7CsYn+rP3D8H6w19wj1?=
 =?iso-8859-1?Q?19CS2Vp9oDk5nXJNqZiYhKSaRgmR7dw2Ioix4KAV3WGTYfhZNijWXPShKn?=
 =?iso-8859-1?Q?UsQK5nqgkBHNdDA7Nr0OENfHV3T+FkakJWn+YtPUognqkHN33TPAAFj6W7?=
 =?iso-8859-1?Q?Vg1BOnbI9PsL3NYcAyM5ajRo9xWq+bMykl1NVP/jKWevM/mT7WZYGCkL2c?=
 =?iso-8859-1?Q?3GFgvKT4sSUxPvnL3WDXyEJmPzGJZ5eNrqQdI5wwxetXlho1gOfyq0KwcI?=
 =?iso-8859-1?Q?gWf9jOkh0zIUEdPC2pkbsq2hd3GQcjDbbX/0Ide3YtBZX4Nmti3+qUMI4T?=
 =?iso-8859-1?Q?mSZJy/h5nHfR3wutuDGjgXFVhNfRdHyqEvm+FrDTXJdAO30RUI5yojtjpd?=
 =?iso-8859-1?Q?dhB//FHCNLtXSlkFG66+XQ2J5F+3krYKEksPG9Efo437Tg7sSvt/ze6tNW?=
 =?iso-8859-1?Q?a+4mPLH4O6m7wr+HyGtyvgYEz1jMkeKPdEHA8X6lCNQWU7gRzTQwh7NMRl?=
 =?iso-8859-1?Q?Qq+geDmtQuADOITKbAcAeCTs+L53/HIvL9NAfoffqR6BNnhBDljVx+n7hH?=
 =?iso-8859-1?Q?Jbcq3GwAqz1b9uIo7OVvG/UV3LAXAKZzb2z1OYdogGwVqiuc5rsSfd52tC?=
 =?iso-8859-1?Q?3wne/udV+PwXFZSg4vRu/ySEZQVy+ybmARIAMRupEtUBcKZFrucS4d6NuX?=
 =?iso-8859-1?Q?UucPwDPx7dzo6ZpQiusXBAJvalAWtZAPmCWLat0AtiP8OKtAbcTmMSp3yJ?=
 =?iso-8859-1?Q?/A59Ig4a9jBzweC23LzorKsXnsLM4I8vHtEEYG4ftU4putMrWiFqAby5My?=
 =?iso-8859-1?Q?oII7tencU6iErESB7AM0d2kWMCzrGDA9jo4xUllcyV2WUyTY9QsGF/qdma?=
 =?iso-8859-1?Q?380tiKVt6Nig2O4sOQDXnQ71qKWJeg++Mf4iaAnYz5onaaEzMb9819wndM?=
 =?iso-8859-1?Q?nsedUYq1e0ST9TSuGdOUfFIkZJz0nbH1XpgWhbpMQyWzXKDUDoZZ65qVsf?=
 =?iso-8859-1?Q?cM0VyODIoQzXgKxZDAjwzWxfLdFmvkPzDcH0idvglHmBotVg7UrTyNY0MA?=
 =?iso-8859-1?Q?gyW4OBbU5x1kw2Ae/Qv2ncok6sJgD3eAxOLYGCvz+7rBN7x9S/9uX8mkBw?=
 =?iso-8859-1?Q?UBlRUDoOJ31ZJV+CUBOvGJ9dfRWso+khRJEV3fwZBBVX32ZVZQfneGD4nM?=
 =?iso-8859-1?Q?LqxXUqDD2kSI22S8+H078Ue76BeaLKQ08UJK9e2yS24XWgBQtqGfxHDXr3?=
 =?iso-8859-1?Q?D61qd/FiWZ6nVdYOhmSIoeLnPETJv0mosgy/OzgBVtPzuBDk3HjMHGkSJH?=
 =?iso-8859-1?Q?POSlm02cJyueQe4GIKkOK+wBiBh880o1SZBL1by8YAl2K7MvSgWF5/OmqJ?=
 =?iso-8859-1?Q?crhAgz++9hk/iWA+a028vkIYE5HIEj/JcsUGk+LeroALyX20NB+tbXrXVe?=
 =?iso-8859-1?Q?YeB2u0FQ0cvCNqWC1CSGVlAZhXwT6J/eD+Csl2RRtGcWB0psDyDh8bu2u0?=
 =?iso-8859-1?Q?9cn83LthhUS32ZykkTi3XEVLaKdG/UM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB8021.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3d6264-dfa8-48a0-ebb3-08dee0c99740
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 10:29:16.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYchNEyJHxT2+hNcpHuefg76rRdHgElqmK3OGq2ktNo9NsUKxG84k76iyOop+q3RPsSSaFuxcyrmxd73xobCSQLZpV39m2kGXz9wV/ghm5cUIIiL0yDf3x/RRZ4T8x6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9068
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[technica-engineering.de,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[technica-engineering.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307119-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ayoub.kaanich@technica-engineering.de,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ayoub.kaanich@technica-engineering.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[technica-engineering.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intrepidcs.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84BE1749DA0

Hi,=0A=
=0A=
Raising a gap in the ethtool netlink module-EEPROM API and asking whether a=
 symmetric write-side command would be considered upstream.=0A=
=0A=
Background:=0A=
ETHTOOL_MSG_MODULE_EEPROM_GET (net/ethtool/eeprom.c) already accepts an exp=
licit i2c_address attribute alongside page/bank/offset/length, not just the=
 SFF-8472 0x50/0x51 pair.=0A=
=0A=
For SFP cages backed by phy/sfp.c + phylink with a real i2c_adapter, this l=
ets userspace read arbitrary vendor-specific I2C addresses on the module th=
rough a standard interface, which is useful well beyond SFF-8472.=0A=
=0A=
There is no equivalent SET. ethtool --set-module-eeprom (both netlink and t=
he legacy ioctl fallback)=0A=
=0A=
Concrete use case:=0A=
=0A=
We (Technica Engineering) manufacture automotive SFP/SFP+ modules for 100/1=
000BASE-T1 and multi-gig automotive Ethernet (TE-1441, PT-1445). Alongside =
the standard SFF-8472 EEPROM at 0x50, these modules expose an I2C-to-MDIO g=
ateway at I2C address 0x40 (0x80/0x81 as 8-bit read/write):=0A=
=0A=
Writes to that address are relayed by the module's own logic as MDIO Clause=
 22/45 transactions to the embedded automotive PHY, giving access to link s=
peed, master/slave mode, and other PHY configuration without needing regist=
er-level documentation of the PHY itself.=0A=
=0A=
=0A=
This isn't a one-off design choice -- at least two other automotive SFP ven=
dor use similar patterns=0A=
=A0 =A0 * Intrepid Control Systems: https://guide.intrepidcs.com/docs/1000B=
ASE-T1-SFP/A-Tour-of-1G-SFP-Hardware.html#i2c-communication=0A=
=A0 =A0 * FL3X: https://flex-product.com/assets/produkte/fl3x_sfp_1000base-=
t1/instruction_for_use_fl3x_sfp_1000base-t1.pdf=0A=
=0A=
This suggests this is a de facto convention among automotive Ethernet SFP v=
endors rather than something specific to us. The framing on top of the raw =
MDIO transaction is vendor-specific, but the kernel doesn't need to underst=
and that -- we just need raw byte-level write access to a non-default I2C a=
ddress on the module, symmetric to what MODULE_EEPROM_GET already provides =
for reads.=0A=
=0A=
Today there's no standard kernel path for this write from userspace on phyl=
ink/sfp.c-backed ports. Where the SFP's I2C bus happens to be a directly ex=
posed i2c_adapter (board-dependent), i2c-tools works, but that's not guaran=
teed, and on the phylink-managed path the bus is typically owned/locked by =
the sfp driver rather than freely available via /dev/i2c-N.=0A=
=0A=
Ask:=0A=
Would a SET_MODULE_EEPROM_BY_PAGE netlink command, mirroring the existing G=
ET (same page/bank/offset/length/i2c_address attributes, same 128-byte half=
-page constraint), be something you'd consider taking?=0A=
Wanted to check direction first given Andrew's existing work on the generic=
 SFP GET path before spending time on an RFC series that goes against the i=
ntended design.=0A=
=0A=
Thanks.=0A=
=0A=
=0A=
=A0=0A=
Ayoub Kaanich=0A=
Principal Software Engineer=0A=
Engineering Department=0A=
=A0=0A=
Technica Engineering GmbH=0A=
Leopoldstr. 236=0A=
D - 80807 M=FCnchen/Munich=0A=
=A0=0A=
Telefon:=0A=
+49 89 200 07 24-XX=0A=
=0A=
Fax: +49 89 200=A007 24-30=0A=
E-Mail:=0A=
ayoub.kaanich@technica-engineering.de=0A=
Website:=A0www.technica-engineering.de=0A=
=0A=
________________________________________=0A=
Technica Engineering GmbH is based in Munich | Managing Directors:=A0Pankaj=
 Sathe, Anup Sable, Thomas K=F6nigseder=A0| Register Court: Munich Local Co=
urt, HRB 172=0A=
 759 | Ust-ID.: DE-260220745=0A=
=A0=0A=
The information contained in this e-mail is intended solely for the use of =
the individual or entity to whom it is addressed, and others authorized to =
receive=0A=
 it. It may contain confidential or privileged information. If you are not =
the intended recipient you are notified that any disclosure, copying, distr=
ibution or taking any action in reliance on the content of this email is st=
rictly prohibited and may be unlawful.=0A=
 If you have received this communication in error, please notify us immedia=
tely by responding to this email and then delete it. Technica Engineering G=
mbH is neither liable for the proper and complete transmission of the infor=
mation obtained or for any delay=0A=
 in this receipt.=0A=
=A0=0A=
=A0=0A=
=0A=
=0A=

