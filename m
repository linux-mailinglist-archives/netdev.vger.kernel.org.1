Return-Path: <netdev+bounces-283274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCvaBen79GnFGwIAu9opvQ
	(envelope-from <netdev+bounces-283274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F8D4AF16E
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E187C3007ACF
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753B4218A6;
	Fri,  1 May 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="DDBknHiv"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE23019A9
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662940; cv=none; b=MsdyxRIc6ES7zNOg8H60N23xze4rJzHmeRnu/hLVjxnRlLVP2g9c+4SQvh2kFNMmr4lWak6YSNj1wjcLzFe2PR90E1iwVaOrvS1FK10Yzeb0p/+4Ti+Q1XnSR8nKXviCB6G5c4NrewIsEfHaZj374v2KE/unz/ljPQbzb/bWxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662940; c=relaxed/simple;
	bh=UfK5msXccGuPPkTH0STK3T1T8QdGXytYs3gUrSgiPDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiZcFqelzOcdJNWrLFw5i4iKOaq70Ejh21+MW8ev/WQE1+ercXJZ6Z4J5kY1tPKd2hN17o5J9cOT3jJlz/atn10S7GM7D5auKIhE3cTGDV74sXtxJEknDaNOvOoaGvSyhYjKtZ6D+Brh+vX0H1PvopiGb9wckEqlMaMk+VYZSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=DDBknHiv; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777662937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5rJyb4QbUWbqUCKO7924AFEEg8JVSImtO8ou8DVDX/I=;
	b=DDBknHiv2loxmM/re3Cm/nYkX6Zhnns7NYZRxV8q005/BeMg9yb+5K+IR4GMdaX/32na1P
	cUjHpxBUXE7ZtjLJe0kUQjEx+bsbIjSaAmclore38ntkPyWuKaNIlZI9xwFewqEVp+z8ZX
	szajBZSP1VHSJEQGUq8m62Vv2Yr1bOuHJ/sW2lwBk/gyRAxkdl0vU9Dq4Nm+YKXXmbrk42
	vWRtLJUh+R2ddpwzAHJTshDxIrRkM2jpEQA8tscZtvKt1yP+vu33asdBRF+dq8mJ5+IATO
	hxQlNhI75fPqCYe9NflPKSg9s2ieoVG9+oNXVWwA4HO6h58bTkTH2yM7bvtTeg==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-20-xUPSIRRKMVayZSQN_RaP5Q-1; Fri, 01 May 2026 12:15:28 -0700
X-MC-Unique: xUPSIRRKMVayZSQN_RaP5Q-1
X-Mimecast-MFC-AGG-ID: xUPSIRRKMVayZSQN_RaP5Q_1777662927
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB8595.namprd02.prod.outlook.com (2603:10b6:a03:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 19:15:25 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 19:15:25 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/5] net: phy: ncn26000: add support for TS2500
 internal PHY
Thread-Topic: [PATCH net-next 2/5] net: phy: ncn26000: add support for TS2500
 internal PHY
Thread-Index: AdzZlYUfyizcr/htRFmk61PXzoS0bg==
Date: Fri, 1 May 2026 19:15:25 +0000
Message-ID: <CY8PR02MB924929303200D28EDEB66F4783322@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Enabled=True;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SiteId=04e1674b-7af5-4d13-a082-64fc6e42384c;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SetDate=2026-05-01T18:44:31.0000000Z;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Name=Public
 Information;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_ContentBits=3;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB8595:EE_
x-ms-office365-filtering-correlation-id: 5d4d05e8-0e1a-4592-09e3-08dea7b5ff7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020|56012099003|18002099003
x-microsoft-antispam-message-info: ejw4VPZHoBAZsf+o6vc4zNejedaCWlvrz6sPcbD+MXrodMOXGcennSgFqKB/DkFMrI7pmDJIrKu6GLdq5/ugU/fUWY16N/skfQDjLzif1+aVr9sziGBFMYczwOVMkR1euwHO31ySw92APKMoRyo5rmMAvaB8dts9hO1xWC95H3cCL7iuMjXI8IbaWkwAqy/1bmQwB1MOu7M5QlHnH9tLAbMekOZuOgGUJX060MuJ2q34tNNG/60SSrizZmOcIdopLuOdmTq1m1fgcs6DWajjOmwW9A3WGgQ2Jxhv/pUv9pxui4xo4B69AldoVfm++gA72zuLRrDYShveYpypsYwHLkL7QEpdE5FyOUKjnZGdHIJ5//0nk+uI1dbrAwAIoEl+qbY4tnQCKnjoj4/owLHopPyaefZrwfkSfGQdZSo23UzAEP7dH85cHSbD/g+gT04kY766Ml2Q3ORBprRB04C1rjMHy9GPaB9WDyadNXBaS52hGAYKipEfhCjnNcFkcZhW2ibIhvFYuLQA5rN9AXjPxM4+v7U6aAoUgMHSPK5tV1vjZhFEkZumMRbUvF2Ne7Na1MFBdtHeINf5kwXds1fP0skl6sU281MgcC7s1AqhyIN5hr/AR9OhHx8vGa9+uWBS5jbxGNJUxJa2AowxTE3XtMrUnGrv3lCbNKRgRTNECKpDyRRJ8iidw6x8UeXeubC/AeQQz2mEISKZzWP2FpcVOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xW1aj1kgOIkew6HwPPF2m+1KLwAxenjKo5YZI5XU9vZaRl0B8TEA1KS0r2OX?=
 =?us-ascii?Q?TPrjl31BXijXjVO0TyYJTE/x17DKQ2wtkPz+bPGQ27ST3IbWhH9TFZWlTWOo?=
 =?us-ascii?Q?eRoid3Y8kQ2Jv25YdGUsuitOqj+S4R8pGeDINcJxnXdZWRyrlW2OkT9cmkHX?=
 =?us-ascii?Q?x2OY79qlFG4wxyffM8QlaHJuJ2Slfg0oIxBbTcqmyWmLaFEmsWR6DfA6exZ+?=
 =?us-ascii?Q?vA2sJ7Rx8oK1/15aFB0PcHe/KRpIb4TY7Ib5t0LoJroRvKCUzudZORR6DJFP?=
 =?us-ascii?Q?H6oFm3E52dJaHggk/vpTdmp1Xy5m8R+vWZS5gNBVsCiu4GrFiEz0Y9OZbzeY?=
 =?us-ascii?Q?tBMqnAh46rGeNklUZfIy9Ybl0ARuu+Ni5SF9lLoOHn5N3j4vy+UldMtNhVBU?=
 =?us-ascii?Q?77ZcDCoOZ9XPhR6EZuB0gm1ysU/DgJUPJEg1hBT2yPxS0+JC1+yLfm03AVau?=
 =?us-ascii?Q?qH4lo7TwnSXQTLgEiZWB0koAP1fSJ5730K7TElbDRF4TffvMFmsNAg83bFkP?=
 =?us-ascii?Q?NM5SUKHSKagq4CGjUewiNTbZXr1v+34ybLUjsez6kLtAbceh5jWjI1uxFXIo?=
 =?us-ascii?Q?V0yB/Mlkw9AoYXMgoW0uWq4EpcT4y38R4IdebQm9BR1nE/DYucavGvxvMepa?=
 =?us-ascii?Q?WCSa6N0iVEaB+tv0pFv4HKY0ezs/CXScvZJOLb6k30vHHemRNA2NUGgqUkV6?=
 =?us-ascii?Q?DhTyK+1IBbsN1KzW1/BWgW5pNzj3R82vrU5cTWm/6Ep2GUL1MVf9X8tXLurK?=
 =?us-ascii?Q?eODl+AxxKtwvKyVcd+zRbYwSEuvi7glT5e4ZJ0MIwbOt7OvnBaK2Qls0Zf6q?=
 =?us-ascii?Q?gcKnpXu5+c6oRZ63ydkaZeGJHd5Ix4G2kNlXgYmAJxgVn+9DsPIXjuHa7bx2?=
 =?us-ascii?Q?2PY3VhkVIxb9YwBb7i8AvI2+E+bpQ6T5/BsN63MIuxHfy8/c5eVMb3zi/5+F?=
 =?us-ascii?Q?Va5/yqmzYlLBpwuYYEoE0DenpjrHDoGF+NdrH4kDI+7YOqEYxnGiuxLbsVrR?=
 =?us-ascii?Q?kFk7NSw993OitXMYKiFkSkJ5xWbiMk09ptmy9cVemcwvKm7/EAZP7pF/PXcA?=
 =?us-ascii?Q?LmudrEuwK+HYVCkbHLvuAXwJRYraUBCM3vg5Ykxzj6tX/QiVhKKEZD+OY06b?=
 =?us-ascii?Q?jVVSdKK290wyebQX0M1iaFzmxaYTwXXDN5emRRDDdg/r3ZIGMu9VkSvMIMj8?=
 =?us-ascii?Q?rYLr59gmdXyX2Y14EXMdSLdRhS9a0sit2UHvZSqZLX9Ca89K0RIw5eMcM3aX?=
 =?us-ascii?Q?QroR70qWJFgsjT1BPquz9x2PcvJO4PqFrKMPWadR6hedAhHuE/rpQQSgYw0n?=
 =?us-ascii?Q?sd7+aq/puOXVqvlS4j5IyHAo9F38qndSy3P+qa0Brby0Ao//yQhjVSewsd3U?=
 =?us-ascii?Q?ML5FT2ACfrnI4Y73/mbjSej7nCmg3UCggbbtZwXB/1ox12cgaGGwqZxQYj7x?=
 =?us-ascii?Q?LZQCPl93AcRqxZolyQ92/j7rizqVPPIDZdDvIuOsmBttqzm0kOUuQDCnUACa?=
 =?us-ascii?Q?GsJBoWOUdaRF9fl4IJ8EEvmbDubKO1/Sf/sgoDbZ8PDHb5bpiFxSaYasSE6D?=
 =?us-ascii?Q?H+mOiM3wVh5+KNQ9DQ6H4ZYTrUwUdts6tr/AFX4U1u3a3EQiVrwcWkaB3dte?=
 =?us-ascii?Q?SRh+8NK1fz+qJWkOpZCeGlT0neBO7oIy5y1p3peBLMTriZRxZV4S88Swchgo?=
 =?us-ascii?Q?JhYRCmL8a1t+aMDj2QVwA9yezxMuCaoTUmcpuF7qtpQKuytVK+tC0NojbnYV?=
 =?us-ascii?Q?3lK70x5Xew=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zk+1yZ+ZjTuhmIkMrXOvuDL2WfpZlSi04RH12YFCTbx7TT3eyUwn3jD3dXO00G/3B0jXyh41MFnb3VheOyc8U4IBJ6EJrh3jnqn7jiEPvxg+QN9zun+JJNdqdxWPi94kGLy5IO4P9wDKoRpENih3P81zwH/0scvfv7JcjG5/s8X+PjFunbfT0ml7AisZKfsGsQk/stxD/+3IE2hsCeGzMlGjOHKxC3qD2qU5wO0g2JSKL4tN6SaSW3SVfdC7N/JfE18w1BZFGMIcq8K0ojceB19uZyG8t0plMHfBCYQWfqJlKwC0HGO27tLF18+wGGZwOgvqpCKayfsbQUxy2VONLg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4d05e8-0e1a-4592-09e3-08dea7b5ff7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 19:15:25.0454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIM9ZgkN44DnOA5kNZxbGJEgK8Ke126sp9PqBBQ6nwDN63UdDJo9zahWQ6cR0tmVtmF5I3xtmtIy7fmv9pscyP/NHXitg5WzE0SAQ0+AQok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8595
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tiBeDhn1BD0E3EzED1hkfkXi8WvZ188lQLcGmd_jzqQ_1777662927
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 15F8D4AF16E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283274-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,onsemi.com:email,onsemi.com:dkim,onsemi.com:url,linaro.org:email,CY8PR02MB9249.namprd02.prod.outlook.com:mid]

Support for onsemi's IEEE 802.3cg compliant Ethernet Transceiver
with integrated Media Access Controller (MACPHY). NCN26010 and
TS2500 are supported.

Updated MAINTAINERS file

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                |  11 ++-
 drivers/net/phy/ncn26000.c | 193 +++++++++++++++++++++++++------------
 2 files changed, 144 insertions(+), 60 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27a073f53..36c1b2f02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19934,12 +19934,21 @@ S:    Maintained
 F:     arch/mips/boot/dts/ralink/omega2p.dts

 ONSEMI ETHERNET PHY DRIVERS
-M:     Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
+M:     Piergiorgio Beruto <pier.beruto@onsemi.com>
+M:     Selva Rajagopal <selvamani.rajagopal@onsemi.com>
 L:     netdev@vger.kernel.org
 S:     Supported
 W:     http://www.onsemi.com
 F:     drivers/net/phy/ncn*

+ONSEMI NCN260xx/TS2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:     Piergiorgio Beruto <pier.beruto@onsemi.com>
+M:     Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+L:     netdev@vger.kernel.org
+S:     Maintained
+F:     Documentation/devicetree/bindings/net/onnn,ncn260xx.yaml
+F:     drivers/net/ethernet/onsemi/ncn260xx/ncn*
+
 OP-TEE DRIVER
 M:     Jens Wiklander <jens.wiklander@linaro.org>
 L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index cabdd83c6..d4bb4b230 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -2,7 +2,7 @@
 /*
  *  Driver for the onsemi 10BASE-T1S NCN26000 PHYs family.
  *
- * Copyright 2022 onsemi
+ * Copyright 2026 onsemi
  */
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
@@ -11,39 +11,43 @@
 #include <linux/module.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/slab.h>
+#include <linux/delay.h>

 #include "mdio-open-alliance.h"

 #define PHY_ID_NCN26000                        0x180FF5A1
+#define PHY_ID_TS2500                  0x180FF411

-#define NCN26000_REG_IRQ_CTL            16
-#define NCN26000_REG_IRQ_STATUS         17
+#define TO_TMR_DEFAULT                 32

-// the NCN26000 maps link_ctrl to BMCR_ANENABLE
-#define NCN26000_BCMR_LINK_CTRL_BIT    BMCR_ANENABLE
+#define NCN26000_REG_IRQ_CTL           16
+#define NCN26000_REG_IRQ_STATUS                17

-// the NCN26000 maps link_status to BMSR_ANEGCOMPLETE
-#define NCN26000_BMSR_LINK_STATUS_BIT  BMSR_ANEGCOMPLETE
+/* clause 45 vendor specific registers */
+#define NCN26000_REG_PHYCFG1_MMD       MDIO_MMD_VEND2
+#define NCN26000_REG_PHYCFG1           0x8001

 #define NCN26000_IRQ_LINKST_BIT                BIT(0)
-#define NCN26000_IRQ_PLCAST_BIT                BIT(1)
-#define NCN26000_IRQ_LJABBER_BIT       BIT(2)
-#define NCN26000_IRQ_RJABBER_BIT       BIT(3)
-#define NCN26000_IRQ_PLCAREC_BIT       BIT(4)
-#define NCN26000_IRQ_PHYSCOL_BIT       BIT(5)
-#define NCN26000_IRQ_RESET_BIT         BIT(15)

-#define TO_TMR_DEFAULT                 32
+#define NCN26000_PHYCFG1_ENI           BIT(7)
+#define NCN26000_PHYCFG1_ENI_MASK      BIT(7)

+/* Default value of the PLCA TO_TIMER should be 32. NCN26000 reports
+ * as 24. This is fixed in next version, in TS2500.
+ */
 static int ncn26000_config_init(struct phy_device *phydev)
 {
-       /* HW bug workaround: the default value of the PLCA TO_TIMER should=
 be
-        * 32, where the current version of NCN26000 reports 24. This will =
be
-        * fixed in future PHY versions. For the time being, we force the
-        * correct default here.
-        */
-       return phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR=
,
-                            TO_TMR_DEFAULT);
+       const struct phy_driver *pdrv =3D phydev->drv;
+       int ret =3D 0;
+
+       if (pdrv && pdrv->phy_id =3D=3D PHY_ID_NCN26000)
+               ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+                                    MDIO_OATC14_PLCA_TOTMR,
+                                    0xFFFF, TO_TMR_DEFAULT);
+       return ret;
 }

 static int ncn26000_config_aneg(struct phy_device *phydev)
@@ -55,17 +59,20 @@ static int ncn26000_config_aneg(struct phy_device *phyd=
ev)
        phydev->mdix_ctrl =3D ETH_TP_MDI_AUTO;
        phydev->mdix =3D ETH_TP_MDI;

-       // bring up the link
-       return phy_write(phydev, MII_BMCR, NCN26000_BCMR_LINK_CTRL_BIT);
+       /* NCN2600x maps link_ctrl to BMCR_ANENABLE */
+       return phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
 }

+/* Link status mapped to BMSR_ANEGCOMPLETE. */
 static int ncn26000_read_status(struct phy_device *phydev)
 {
-       /* The NCN26000 reports NCN26000_LINK_STATUS_BIT if the link status=
 of
-        * the PHY is up. It further reports the logical AND of the link st=
atus
-        * and the PLCA status in the BMSR_LSTATUS bit.
-        */
-       int ret;
+       u16 status_check =3D BMSR_ANEGCOMPLETE;
+       int ret =3D 0;
+
+       phydev->duplex =3D DUPLEX_HALF;
+       phydev->speed =3D SPEED_10;
+       phydev->autoneg =3D AUTONEG_DISABLE;
+       phydev->pause =3D 0;

        /* The link state is latched low so that momentary link
         * drops can be detected. Do not double-read the status
@@ -76,7 +83,7 @@ static int ncn26000_read_status(struct phy_device *phydev=
)
                ret =3D phy_read(phydev, MII_BMSR);
                if (ret < 0)
                        return ret;
-               else if (ret & NCN26000_BMSR_LINK_STATUS_BIT)
+               if (ret & status_check)
                        goto upd_link;
        }

@@ -85,30 +92,54 @@ static int ncn26000_read_status(struct phy_device *phyd=
ev)
                return ret;

 upd_link:
-       // update link status
-       if (ret & NCN26000_BMSR_LINK_STATUS_BIT) {
+       /* Update link status */
+       if (ret & status_check)
                phydev->link =3D 1;
-               phydev->pause =3D 0;
-               phydev->duplex =3D DUPLEX_HALF;
-               phydev->speed =3D SPEED_10;
-       } else {
+       else
                phydev->link =3D 0;
-               phydev->duplex =3D DUPLEX_UNKNOWN;
-               phydev->speed =3D SPEED_UNKNOWN;
-       }

        return 0;
 }

+/* We capture calls to PLCA set config to intercept PLCA enable/disable
+ * requests and set the proprietary ENI mode accordingly
+ */
+static int ncn26000_plca_set_cfg(struct phy_device *phydev,
+                                const struct phy_plca_cfg *plca_cfg)
+{
+       int ret =3D genphy_c45_plca_set_cfg(phydev, plca_cfg);
+       u16 cfg_enabled =3D 0;
+       int ctl0 =3D 0;
+
+       if (ret || plca_cfg->enabled < 0)
+               return ret;
+
+       ret =3D phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_CTRL1=
);
+       if (ret >=3D 0) {
+               ctl0 =3D phy_read_mmd(phydev, MDIO_MMD_VEND2,
+                                   MDIO_OATC14_PLCA_CTRL0);
+               if (ctl0 >=3D 0)
+                       dev_info(&phydev->mdio.dev, "PLCA %s: node id=3D%d,=
 count=3D%d",
+                                (ctl0 & MDIO_OATC14_PLCA_EN) ? "ON" : "OFF=
",
+                                ret & MDIO_OATC14_PLCA_ID,
+                                (ret & MDIO_OATC14_PLCA_NCNT) >> 8);
+       }
+
+       cfg_enabled =3D (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
+       return phy_modify_mmd(phydev, NCN26000_REG_PHYCFG1_MMD,
+                             NCN26000_REG_PHYCFG1,
+                             NCN26000_PHYCFG1_ENI_MASK, cfg_enabled);
+}
+
 static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 {
        int ret;

-       // read and aknowledge the IRQ status register
+       /* Read and acknowledge the IRQ status register */
        ret =3D phy_read(phydev, NCN26000_REG_IRQ_STATUS);

-       // check only link status changes
-       if (ret < 0 || (ret & NCN26000_REG_IRQ_STATUS) =3D=3D 0)
+       /* Check only link status changes */
+       if (ret < 0 || ((ret & NCN26000_IRQ_LINKST_BIT) =3D=3D 0))
                return IRQ_NONE;

        phy_trigger_machine(phydev);
@@ -117,20 +148,17 @@ static irqreturn_t ncn26000_handle_interrupt(struct p=
hy_device *phydev)

 static int ncn26000_config_intr(struct phy_device *phydev)
 {
+       u16 irqe =3D 0;
        int ret;
-       u16 irqe;

        if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
-               // acknowledge IRQs
+               /* Acknowledge IRQs */
                ret =3D phy_read(phydev, NCN26000_REG_IRQ_STATUS);
                if (ret < 0)
                        return ret;

-               // get link status notifications
+               /* Get link status notifications */
                irqe =3D NCN26000_IRQ_LINKST_BIT;
-       } else {
-               // disable all IRQs
-               irqe =3D 0;
        }

        ret =3D phy_write(phydev, NCN26000_REG_IRQ_CTL, irqe);
@@ -140,20 +168,66 @@ static int ncn26000_config_intr(struct phy_device *ph=
ydev)
        return 0;
 }

+static void ncn26000_remove(struct phy_device *phydev)
+{
+       phydev->priv =3D NULL;
+}
+
+static int ncn26000_read_mmd(struct phy_device *phydev, int dev, u16 reg)
+{
+       struct mii_bus *bus =3D phydev->mdio.bus;
+       int addr =3D phydev->mdio.addr;
+
+       return __mdiobus_c45_read(bus, addr, dev, reg);
+}
+
+static int ncn26000_write_mmd(struct phy_device *phydev, int dev,
+                             u16 reg, u16 val)
+{
+       struct mii_bus *bus =3D phydev->mdio.bus;
+       int addr =3D phydev->mdio.addr;
+
+       return __mdiobus_c45_write(bus, addr, dev, reg, val);
+}
+
 static struct phy_driver ncn26000_driver[] =3D {
+       {
+               PHY_ID_MATCH_MODEL(PHY_ID_TS2500),
+               .name                  =3D "TS2500",
+               .features              =3D PHY_BASIC_T1S_P2MP_FEATURES,
+               .remove                =3D ncn26000_remove,
+               .config_init           =3D ncn26000_config_init,
+               .config_intr           =3D ncn26000_config_intr,
+               .config_aneg           =3D ncn26000_config_aneg,
+               .read_status           =3D ncn26000_read_status,
+               .handle_interrupt      =3D ncn26000_handle_interrupt,
+               .set_plca_cfg          =3D ncn26000_plca_set_cfg,
+               .get_plca_cfg          =3D genphy_c45_plca_get_cfg,
+               .get_plca_status       =3D genphy_c45_plca_get_status,
+               .soft_reset            =3D genphy_soft_reset,
+               .get_sqi               =3D genphy_c45_oatc14_get_sqi,
+               .get_sqi_max           =3D genphy_c45_oatc14_get_sqi_max,
+               .read_mmd              =3D ncn26000_read_mmd,
+               .write_mmd             =3D ncn26000_write_mmd,
+               .cable_test_get_status =3D genphy_c45_oatc14_cable_test_get=
_status,
+               .cable_test_start      =3D genphy_c45_oatc14_cable_test_sta=
rt,
+       },
        {
                PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
-               .name                   =3D "NCN26000",
-               .features               =3D PHY_BASIC_T1S_P2MP_FEATURES,
-               .config_init            =3D ncn26000_config_init,
-               .config_intr            =3D ncn26000_config_intr,
-               .config_aneg            =3D ncn26000_config_aneg,
-               .read_status            =3D ncn26000_read_status,
-               .handle_interrupt       =3D ncn26000_handle_interrupt,
-               .get_plca_cfg           =3D genphy_c45_plca_get_cfg,
-               .set_plca_cfg           =3D genphy_c45_plca_set_cfg,
-               .get_plca_status        =3D genphy_c45_plca_get_status,
-               .soft_reset             =3D genphy_soft_reset,
+               .name                  =3D "NCN26000",
+               .features              =3D PHY_BASIC_T1S_P2MP_FEATURES,
+               .remove                =3D ncn26000_remove,
+               .config_init           =3D ncn26000_config_init,
+               .config_intr           =3D ncn26000_config_intr,
+               .config_aneg           =3D ncn26000_config_aneg,
+               .read_status           =3D ncn26000_read_status,
+               .handle_interrupt      =3D ncn26000_handle_interrupt,
+               .set_plca_cfg          =3D ncn26000_plca_set_cfg,
+               .get_plca_cfg          =3D genphy_c45_plca_get_cfg,
+               .get_plca_status       =3D genphy_c45_plca_get_status,
+               .soft_reset            =3D genphy_soft_reset,
+               .read_mmd              =3D ncn26000_read_mmd,
+               .write_mmd             =3D ncn26000_write_mmd,
        },
 };

@@ -161,11 +235,12 @@ module_phy_driver(ncn26000_driver);

 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] =3D {
        { PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+       { PHY_ID_MATCH_MODEL(PHY_ID_TS2500) },
        { }
 };

 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);

-MODULE_AUTHOR("Piergiorgio Beruto");
+MODULE_AUTHOR("Piergiorgio Beruto <Pier.Beruto@onsemi.com>");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");
--
2.43.0


Public Information


