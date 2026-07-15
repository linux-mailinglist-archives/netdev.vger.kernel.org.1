Return-Path: <netdev+bounces-307696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4YSKNb5AV2qkIAEAu9opvQ
	(envelope-from <netdev+bounces-307696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF975BC18
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:11:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=technica-engineering.de header.s=selector1 header.b=lsZ+IpJu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307696-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=technica-engineering.de;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 772D43038F6E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212733CA4B3;
	Wed, 15 Jul 2026 08:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023109.outbound.protection.outlook.com [40.107.159.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B2239E7E
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:10:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103003; cv=fail; b=VWafG1j63Xyq0808HO746aaPI4A3lpfUd9P8/PexZXbsrkubmbn4h9Mr0SFVdkslbBCG+KU8GQgq8opNZa7Tk6+L0YlPveCM8iV4/mNj0mQGFppukWbuXVn44VWMvmZ8UAaBDv/bI2kP74ZfBtaV7xgXw1Jzp4gsWRWnZKBd/qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103003; c=relaxed/simple;
	bh=aU6YpptLMM6dhmyk/Se9QfDeUlH4ZfId1Bl7djZ6Sn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mi2oxS0D8cn+sfLdWj3kLhv0mFTfo9KybHrCjYKo2pJFGFvMcTiDnbvspyBJ6SUTnDUJAoib8W6R/47uJMTUvNVq8T66kWif20yoEq7Gk5bd8g2V+qICqCesvN0q4Ae2biBSyLUJ5b4FLQx+QWI8HQ0lWdBeAo2DBBep9z/ntbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=lsZ+IpJu; arc=fail smtp.client-ip=40.107.159.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO8QEVtuZZrZ8D30VlrrgvKUQ9bDuwrUJdc4D033jZpJdc7ok+QlWK2i0Nzk1an7bCJq+hZ0gNQPwOKF4avKDuZgI/yKyeNdWheGlVPmF7lct88OFcszQRdS78KDVKkWRIhKeThRdiuolPv5oGyNyj1zWhDuZyxSJDhXqeS8vZ/cj35NJ9kJRFsMOcPsUrRMcA1Bb/pWzn/46GiiPc4qoBiSxKz4js6nHtYpHmFpJTJJhBXfk4IGUhDG+noQWIBe4XHWSmQTEEoMDO8PxUDBqKnLhvY4g85c/eBFYJrAyA/nvVKKEGbgJFr58RwBSCX3zIMWn4V81K7gxUy9lyPAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU6YpptLMM6dhmyk/Se9QfDeUlH4ZfId1Bl7djZ6Sn8=;
 b=BsmOzbMUcKnIVozb+f5vd8Ll1Rn7RsN3CGw1drvR5iXSj9Kk7xBAyEfxtcEnr1orgO50m8f97AaCPd9RWMDQVsdtJVwgUy8ObBJS/z9asSool99rnXUl6eaKkUGnY3i9eb6nppOvt4/+VpfgB7pSfB7718RUA5Ie1Hg+BlcuSMxaPof/qTDdGI+OYpXiN+rcQ6LpW8NKj1a415TSrLwQ1x4YHnl+hbITw48FcEwaVEyg/ITKzVdPnE32vf4qhiLoagBMqPs1mja8wg3SKM7+efDG2Zn7mBYO8wK7LDgpRWq9NBsiMwyfkm14FSLzJI38k9UQmctbFcXp2FYx78eLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU6YpptLMM6dhmyk/Se9QfDeUlH4ZfId1Bl7djZ6Sn8=;
 b=lsZ+IpJuelJKP4WA9LKaPV6E3DH7SVIZom82abgzYKgb7nysHNlz4t4KzPYM78CaDSjaz1E8Ut/84vwIoLtYwGzA5jnTRtWKtk4NqPYqc6Uii9URFyBWMtu++tVvHxYcGmSq77Sgg+xoGGNS76aBLm8DOGmb02riaV9ponSU2vY=
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com (2603:10a6:20b:584::15)
 by DBBPR08MB5947.eurprd08.prod.outlook.com (2603:10a6:10:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 08:09:56 +0000
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9]) by AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9%4]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 08:09:56 +0000
From: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Topic: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Index: AQHdEqUvQ2S5XVAteEurgYKiixGWIrZtcDEAgAC2Gco=
Date: Wed, 15 Jul 2026 08:09:56 +0000
Message-ID:
 <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
References:
 <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
In-Reply-To: <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Enabled=True;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SiteId=1f04372a-6892-44e3-8f58-03845e1a70c1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SetDate=2026-07-15T08:09:56.251Z;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Name=Internal;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_ContentBits=1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR08MB8021:EE_|DBBPR08MB5947:EE_
x-ms-office365-filtering-correlation-id: e404cc29-5aa0-4414-ab80-08dee248750b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|18002099003|55112099003|22082099003|6133799003|3023799007|4143699003|56012099006;
x-microsoft-antispam-message-info:
 N3jiYGc+0cT+XIxBAdmdRnMtXKTwjsPwl3OKGeQBPnAED65+LGWyXwSvnxaQGQE3uDO6fWiZU8u0OJbINcNFT0WEVxHHz4+flI09WQQEGjQRJnZZdyqosn8dvKkCFXCKhE8LO3gxCo/61QXU9CuXSr/yDOI0/nbSYPvC+EIYO2P6JR2GKSHma0W7QjK8QdAxNk28g2eIxB/IJv9OWP5yR1F8XkUOvZsHJBqez16kmWRDL96Yl3wASkBlkx3A2F5WcVTg4XU/dd9g1sEkbyvArPB+QWSAzYJSXgrNf5s+bpEXmSpoWcQ9po5pKKpbWOyrqMICRxey1heNCmvJxHM5LgKZfdQBuU/QR+JEnfhFgU90e7TTztsm3VNmJI0OJHcuCg0I00l354N+Uo7KHsrp7rKZSMInSfLNIiiiTHQ1Qw25/OSLutqUjazccyAlR9bxjDCuMx4v+La2SHlmmUcMD9WA6ugZJOH6E4QYaTsrahM/x4uHRoIHr/hT9Ngd9waNAg4eiKgXrlkcu+2aVvmwvPhEnR9sJmf3nyf636wBIUu5TFT7k5wJes+P1t3EUVuHMXnDlUv/n19T3vYwITPEcRK+4E4jv8ApTawyq0ZR42QtHxAYTdbtOBaK/zWT3h9ccNNiSAIy8axe2lxMyOSgK3hvGfa3dNfyr5UZz9TOkiTgT6cTDOOLXAt4RN8ZFpzLG/RUYpjLcLUMKNY5vw0aM50rEa0/4D/qKKDHS9R1+Qg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB8021.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(18002099003)(55112099003)(22082099003)(6133799003)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FtQkhAF3y389AmV2bbU0jZtd3AXpSeZFzVSaRtrY9qI4KMLrcsB4w+rhCQ?=
 =?iso-8859-1?Q?jcA5r4NB8O7xKmHxhBAUwhgB0PzirMW8cxhYDxI5XS9l9FIAZ57vXUVluC?=
 =?iso-8859-1?Q?DXfZMAJh+r0cGUaZ7X1CIYpT1pjiZeNo10/GWjXLK2z4LHX+0C9ne1C06w?=
 =?iso-8859-1?Q?XZ7wBYstVoylBGlnLwvI5c067EoXIO/LhEFVXnTLxFltzgo8NemZUaU1R2?=
 =?iso-8859-1?Q?EvWwdL7iGWfnU2vdAXSTaKmFot96pyyCXja9XAnQdAad94BWmhqDg0IxCz?=
 =?iso-8859-1?Q?NFQXU3ZroKoxWbVJ/N2bGgN22yknV47+WnDa5IhptSExbzFnHBkU5Znfhl?=
 =?iso-8859-1?Q?go2DBhWsz925nE4H5EhxqFhWCqPtmqy3okFUmsm+0clBG/YOenduZsw/HI?=
 =?iso-8859-1?Q?z3AOjgEFfEBWT/+9Q5ZDvTMcT5eqayX26hOEj0tlJ4wjT73wJC2G84K5Ec?=
 =?iso-8859-1?Q?HNaVCK/Wyi80cC2khFHCVfgChqbtrI33nBvJPKvMkobrrxd2Vx3yiGeTU5?=
 =?iso-8859-1?Q?miSEWqYAwEh9ddxQQlqFhnLK7Or43HRuZQli1ZMJKxL4Qh/lEy0U+5bwJd?=
 =?iso-8859-1?Q?atLraFU5Y6bx+iUnzZMeVz5O5Jhaq/I6ZMbJJtjz634okLH+Un+4BJNE2n?=
 =?iso-8859-1?Q?qYkZN3lhXURonH6UqJ9FYBYlETpVToieU3FUPvuuhTW0EvbArmREHM17KD?=
 =?iso-8859-1?Q?sMp6/RVsxLDkLp5zW4tIvw/zaHWHNKtI4r1dP8/t9cQAAylF2BuJIYS4TA?=
 =?iso-8859-1?Q?E6C/luaG9l/OEad/WSzMph0v+Pq+hVxjOxNA4ZUZ62ZUoTeArS6+KWCls7?=
 =?iso-8859-1?Q?YGPe2E3EiRlCYuO/J9Nq/A8Na3CnjmryseTwaVy4TDE9JjOwdqqbHUQuS+?=
 =?iso-8859-1?Q?ub28KEpFdBuFofCdfLMlYEaKn3P1FSMTeGicFqGfma19Zpm1vmVqt97m0B?=
 =?iso-8859-1?Q?9kcmSS9z3i/L3o9MBnGV5nYDa/8ioezbsDeD9DPsJCMfqWfItrwrQIdkhH?=
 =?iso-8859-1?Q?QCHJSglSOEQJPhHuX5RnLvPuGWPMekUgcCa8cP/9T78+OXEocxSQKD9UBi?=
 =?iso-8859-1?Q?g0J0aJANhCV34pqAVeJNf8t3wIkfZ1ES6ZEW6QTqurcGQOYBxGfJjkslfc?=
 =?iso-8859-1?Q?34MYHibfYq9dPe5N1D4YwZ3VPM9CBOxT86s0HDoM4bJdzzlQHK/hpyDCxF?=
 =?iso-8859-1?Q?5UuJTSCV55tVSD176qEqH2qxgLVLilbcDsS4KTbQi9zBZwqcGMqdttbFVG?=
 =?iso-8859-1?Q?1nQZB9GHhi+3f81qndJe6VY/eaAwTjgLukEaw6ZtndtSiwvmNgObmVX6qs?=
 =?iso-8859-1?Q?GmG0z/vsZlW1x3LNJSW5hsf4MlwQp2HJ0RjswYvkFKeO8HeSRzMT2ufswg?=
 =?iso-8859-1?Q?rjIzMZOU8pkNkMskEGKrLR/MkbIrQkAensyRdgu3obEXoR3wZopEzhz3Ib?=
 =?iso-8859-1?Q?NziFfPS9v8RS956AugPyCs9hx1h0MoadSYxStXlbxgI48x0q7B27pXY5an?=
 =?iso-8859-1?Q?/GJYmEHlVPA5Dk+tLUwjdcOfKfXQt+pRwqzSboNNlfooq72syytCQqCeCp?=
 =?iso-8859-1?Q?fcBhrGl+s/iCwRsIq2w2uDbPM2ZOxPekqeQ2B5RCel8Zf7kNFLs+SRGfY4?=
 =?iso-8859-1?Q?MqlBIUlmeVUaoWGRuskvO1wbnGlRnms9rUl0YDcrtEYjrHePQlIQZNQFSs?=
 =?iso-8859-1?Q?vYv9m+FYRjld9Va4TXoscdkmIFVwYYFlBz+X56QIRU5EO47Bp3estsHBP/?=
 =?iso-8859-1?Q?s4nKVa38KFSufb0Jt9+uX53VCKX/Y6pYeNcvwQy7xrk+vHDuAlCexuvQQy?=
 =?iso-8859-1?Q?m/LvjRu/XBrDQjyg+ZYDX2dTyJ4iVko=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e404cc29-5aa0-4414-ab80-08dee248750b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 08:09:56.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIQ1190UafnJ8sZuLsTtKoLDkqvvtwFQk0oW3CwKdwqjGWY39cY1T8CxtMfQIbXMknkb9jc/3WXMX637jow+2Wof89m7Wec9duzS3wtekDUu+tc8VV9GdfeNqZbrx/zS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5947
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[technica-engineering.de,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[technica-engineering.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307696-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FAF975BC18

Hi,=0A=
=0A=
> In general, we are trying to block user space drivers, by only allowing r=
ead.=0A=
=0A=
So in principle, a write from a third party driver (not the NIC own driver)=
 is allowed?=0A=
=0A=
=0A=
> What protocol does it use? Have you seen drivers/net/mdio/mdio-i2c.c.=0A=
> That currently implements two different C22 or C45 over I2C.=0A=
=0A=
Our current addressing schema does not fit C22, C45 or ROLLBALL.=0A=
=0A=
Even if we were to change it (not sure of possible) or add another addressi=
ng schema to mdio-i2c.c, there is still one fundamental issue:=0A=
=0A=
Our issue is that the NIC drivers (especially the netlink based drivers), h=
ave no standard way to expose the I2C bus of the SFP module to other driver=
s.=0A=
phylink based drivers don't have this issue.=0A=
=0A=
The current hierarchy is=0A=
=0A=
net_device =3D> sfp_bus (missing in many drivers) =3D> sfp (internal) =3D> =
i2c_adapter=0A=
=0A=
For example: ice driver does not create an i2c_adapter or sfp_bus, even tho=
ugh many of the NICs using that driver have SFP28 or QSFP28 pluggable cages=
.=0A=
=0A=
This means no i2c_adapter and no sfp_bus are available to build the mii_bus=
 on when using ice driver.=0A=
=0A=
Best Regards.=0A=
=0A=
=0A=
Ayoub Kaanich=0A=
Principal Software Engineer=0A=
Engineering Department=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Andrew Lunn <andrew@lunn.ch>=0A=
Sent: Tuesday, July 14, 2026 09:55 PM=0A=
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>=0A=
Cc: Russell King <linux@armlinux.org.uk>; netdev@vger.kernel.org <netdev@vg=
er.kernel.org>=0A=
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for =
non-SFF pages=0A=
=0A=
=0A=
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.=0A=
=0A=
=0A=
=0A=
> There is no equivalent SET. ethtool --set-module-eeprom (both=0A=
=0A=
> netlink and the legacy ioctl fallback)=0A=
=0A=
=0A=
=0A=
In general, we are trying to block user space drivers, by only=0A=
=0A=
allowing read.=0A=
=0A=
=0A=
=0A=
> Concrete use case:=0A=
=0A=
>=0A=
=0A=
> We (Technica Engineering) manufacture automotive SFP/SFP+ modules for 100=
/1000BASE-T1 and multi-gig automotive Ethernet (TE-1441, PT-1445). Alongsid=
e the standard SFF-8472 EEPROM at 0x50, these modules expose an I2C-to-MDIO=
 gateway at I2C address 0x40 (0x80/0x81 as 8-bit read/write):=0A=
=0A=
>=0A=
=0A=
> Writes to that address are relayed by the module's own logic as MDIO Clau=
se 22/45 transactions to the embedded automotive PHY, giving access to link=
 speed, master/slave mode, and other PHY configuration without needing regi=
ster-level documentation of the PHY itself.=0A=
=0A=
=0A=
=0A=
What protocol does it use? Have you seen drivers/net/mdio/mdio-i2c.c.=0A=
=0A=
That currently implements two different C22 or C45 over I2C.=0A=
=0A=
=0A=
=0A=
You should add your protocol here, and then Linux can just drive the=0A=
=0A=
PHY, like it does for any other PHY.=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Andrew=0A=
=0A=

