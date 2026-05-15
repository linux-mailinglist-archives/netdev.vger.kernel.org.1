Return-Path: <netdev+bounces-288358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCOSMZdWB2pVzQIAu9opvQ
	(envelope-from <netdev+bounces-288358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:23:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FC554F07
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A8A324431C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C73FD971;
	Fri, 15 May 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="T1ivEFAA"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797463FD961
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861646; cv=none; b=SYFvuBYN9gPq1wFRk2Ok9SwCubhWPE9mtqeJaDrJTDAHiUkb1h2Hfp19UqFAfgFsjoA0NxzIaa+h+MzwHIV+8D6skhA+lDM2kadlf6IlNCkPEnncXlyeJEHItGsdwZj0PMsdKMoGzGgdVIn8QjseGVRU4g7XxdoBrDQc3CTtzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861646; c=relaxed/simple;
	bh=cboX3d8XkVXIEKowAOjoe4Fu6Sq0Dq4+kvLQFmjQATQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndkulVVZ6Oeb4UyMlzOnaVIu5Ts63o932lKx7YLAiR/QE9sTR6eB81TeFHBupbzq6/FjIcNpxXfRLMMroKY+vPymgDbxvLa6uNsl72gSOP/b+4X+cZYBOI7Z1dDoClTVCvFs0TU3Hh3rl9VYUhHat5CGJv3aqmjNAKlKroldUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=T1ivEFAA; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778861639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6z1jfvzQfiPZQlmfQKAx/3yNkDe+kLUmEifZ3V+qmwQ=;
	b=T1ivEFAAITmYxtBHbJcADE6xifrgoYt2dgcKO+DQBMZcmBvEht0CtdnUjviVN7U1CP3PdI
	2swRJw/HNudfZy8XkvWyNJZXKZj7uOC42zwRBgp48q7f1YukAJc3pfcDkKy9QITtH3AyCY
	i7SchbEdIihat+N8ogOrqekxBpqtP+itCK5unDLB09RCRkl+kBdvg7RwIgW3uZ6gSso468
	IdVr4BWk9BdcIvDhMkDgd376df0lH6daXrdi2De+2UAfmkHBYEK+GMNiRa+c1BMKC2ZapA
	TzdwCgMAEOpfzioqg1yK0B+K6/qwOz//7Tq0PR8IIE/I005DYVkwK0HL2Mco0Q==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-34-fdhDgZ9mPuSvFawhfiCbkw-2; Fri, 15 May 2026 09:13:55 -0700
X-MC-Unique: fdhDgZ9mPuSvFawhfiCbkw-2
X-Mimecast-MFC-AGG-ID: fdhDgZ9mPuSvFawhfiCbkw_1778861633
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS1PR02MB10490.namprd02.prod.outlook.com (2603:10b6:8:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 16:13:51 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 16:13:51 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be active
 low, level triggered
Thread-Topic: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Index: AdzkhZbrD+M8KZwKQJ6/PvOKyavj8w==
Date: Fri, 15 May 2026 16:13:51 +0000
Message-ID: <CY8PR02MB924916514D414B698DEB9A1883042@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS1PR02MB10490:EE_
x-ms-office365-filtering-correlation-id: f00d2a4c-c1f2-4003-69eb-08deb29cf45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|921020|38070700021|11063799003
x-microsoft-antispam-message-info: aSM1CAitQIdHwoTrDvg4tm4t9tmcxfMtGF9DKajlJuyJc3U4FKCKV5RshS20yjfc9EByFW9g6hPbwOKK5IJTciCVwSoAgQiITMNMPAbhIbKNqQRPZ+6bWFgd9iwTsq2pNshe77rn9CqWbEZsHLF+lLahIya92J8WVP5KxFR1C1MjlW7EvgzP6nwiN5+SQIHKyy/sYjkGCid95w72g3jcHLEJhl2cwpOCc4/h8o5y1BMbBimOxbNeDMKk7GK/bSykmGKKyq/Fvb5KcCUQuH8t2eby7Ebl1qcXnoEZY39q48zrWJ1NLZVevnFcWOKhejFAk1i7qONzIgu8UVvsfacm8/greIsf6gLmFQ6nSWk33sRlHQMysHZY11Os7P4/RriCQxWX05RZYaKiKVJjK2r3hEYYmY+3H5U2M4tvy3KV6vDwae9LNh3eqpbPyW1NgRHI9MwH36TnXaCkc+L/Rr0bnNvw9e8Wycv4MVUnNfqMeX6LhFVYpZOTDmXkYw2gvRqaIxVaI3g0safMxj6T0409P1RVs0Qjndd2610GaUFKaybKbw4ZNOpNjvipv0L3fA4jbs0RRmW/Yelb1nei9Z6fckq8ZBx3zoenJ9SP1rDjUfRf5MtZzpJigldc8MiOdCDT2U7kP+CmuMQm07IcrxUheTmDW5aS0mhw1+Ij+UedqLTMZ1ps+duh6TQSiA1cqYV7zos3fMDA6GvMK1DA46UqPQWeUAjXpvZp0+NIsQAtOG6VobEQgGgHUvTaYFo5RWPIG/05QDT/ZVTJezoY5MHX6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(921020)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KT1vjFw1o6X7BvSgeEgAnIFkAcTu4mpKeTEzoBy2QIBPb95Dkt+iHjvLysud?=
 =?us-ascii?Q?b6v0HkQt9HrEROwoD/q4uSLe5UvqHJ4AHi0bAeggZ2yBpPPzMN+aq7HnMyf6?=
 =?us-ascii?Q?rydXbBSkYgL89GObgHvD4U5uow6qH6MpXtXRJZNUVm1mhaevypWGJTlLbzzC?=
 =?us-ascii?Q?kQQppTVlKUHK2WQ1j76Em3ZH5M+OBLUdassCGeDdDRInKCuOuQMS6dIPZvgh?=
 =?us-ascii?Q?uxiGNy0mKlN3KAYUZBlhZvuqcCDvgOILx51A/zn+kLhTFIq/BXhFGiMfFNDI?=
 =?us-ascii?Q?9SY/xVi/E35CTTfKEpFEdeAOUQlf1rGf4JngMt5pjzVhqdyyhkR7Dpz7tzq3?=
 =?us-ascii?Q?xP+xtm6d0Np0tcmQ3JbwlE6wj9uYTqc6nQyHYbUZB5dEJFSreGmkYb3ripVV?=
 =?us-ascii?Q?3KWTaaS4A5OiZ555FwWpqH8OuMo+CpbkLhl1EeWmbOOkLnkZez+6IlqOmtTi?=
 =?us-ascii?Q?U31FoXfg+KXxOgCvxlxVnFefuPUjo9Nmu1LolDVvcDE3RPWKkum2XHsWHrki?=
 =?us-ascii?Q?UJUXbgtu0Sz1sX06ARAGzejdOR94KA3KpthBwypP9PPm1dVljSbXr0NrashH?=
 =?us-ascii?Q?+ikPvh1noHEwQKXEvdeqNb3g1cta1Q/hBCXT/bq8sweIDkBhIuReMXEy4sC8?=
 =?us-ascii?Q?gM5yPFjmuWvEGCeUcnfkRPeOrRUcZOTV80aUvnOJBAFew+NICuSbNTMVPjo6?=
 =?us-ascii?Q?S/UGRYtcfXa1Zz3J8yM42IJwK2Jn3X9vGhVNpVo8/I3qAE43/4R5gBomxKFz?=
 =?us-ascii?Q?1sUtpO7Yu2mBd7tLex9CtnqwxwL5psWLVb/d7as167D/rDbG0qXhXXIAoXQq?=
 =?us-ascii?Q?zNuwJKbGJ8jXNH7V/aApOyogSOLOLiKqm1RKt/OjR+Ra8ifdWwJZfNmOFx9e?=
 =?us-ascii?Q?l19FokLmW0SvWhJWa5o61HjQQvyj8Tc0GaGG89HWy2nxHQzVKK4zCFKFoI6F?=
 =?us-ascii?Q?U8TVbjiHKZA9OZhATlNZlJxTfKyvYUqqt5OInPOUAbFdWalc8przHBU3ZwQb?=
 =?us-ascii?Q?ZotDRO3tGhwpWKsjHxasOrlRNcvL+1eYpIbB9To5QGYh6/4AFTit+DTVpRmR?=
 =?us-ascii?Q?Z7Jtp4H95iMeQLnNJWBFsLm4LGVgJR8uwPPtH7cHJq9tiXzINksr9X/Zmrmc?=
 =?us-ascii?Q?/e1Xp76tDM1NIpAoCd6MilxKqMfLHWcvuvIUIgFjmiSzkyQuHe/UZEiTlHRn?=
 =?us-ascii?Q?2V+CxP0oVT+qm7bVI10rwNartdvyaZZaAzO5oHMrqz5mxjToE+WtpNX/2hiD?=
 =?us-ascii?Q?ofQf63dqZwx8wMcwWL0SGnKJ5Np/9q9UWlSgHuz3YUxbj0vXfgZN2fUZJ5NX?=
 =?us-ascii?Q?yAyRQ8Fnpwy0hVv/7DoQi3JTjJgrXfjbyY1/dD+Hp3buG+ypS5Y98OAuTQAy?=
 =?us-ascii?Q?N5OOul5d9i8VnXc6iLAZcBjl1OSeiKCqHrW+pEixDe/cLB/8mWpoi3MUvKfc?=
 =?us-ascii?Q?nGDP58aqyvgRblsmzE7l0iRGVHDNBevtEzlzSib4TzUSvv1OWIRI9+L++hhM?=
 =?us-ascii?Q?h3pE+JKkKKusH8ekA/SHbxHeSTs5ohxa/9wIkQTqav/pCe5UrMdm2xVir/yG?=
 =?us-ascii?Q?ijwC6oJcmS0/wvjsM4BfIXOX59+Uv2sVAlWZMR6RkNt79CA72gMLLgSHovuo?=
 =?us-ascii?Q?tDqPM/vr4tXpMXDdkcaeTB6fD/exqHWNZTtrlX6bXLVonCy/zHWfxT3N+t7y?=
 =?us-ascii?Q?MPaMH8V7GcIN0UpHjx10tTLATd7D1gtRMF0ig0U5LG7Wwo5slOSi9RmRj7o3?=
 =?us-ascii?Q?y0VbOovl8HGELoVhDb7Vbacwqyz/iZM=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aSjgtflFvnc2IWLSkqsxI1O8lNPMI5Yhft41M3BpmMnbqp4OXdKVsmX6qIuXu9LaVyhpRERpXrh+WEnJuNoguZwKY/BcQcmOu4PV4FWO2aThvDuKTWEA/3aYYzYuaDMfXpEKd4GaEaLJYc3GzeswCnBSgjk6M5jK1IEhz+XqPNVye4fH8EE+tFoYvhZ5KrqDEFwduqkQ1OcrAgy/vS3UFBjjeOsmChbzR3zLnVP8bbTYZ05ONxeMqm3ALJG9OYLzVjggn1X/z66FpJCeZn9APkpp4J1Fks+mQHu53qZSFvvcVsulGUjBYOiKbihxWazUeLq5zMW3dz6Bs4VD8MCTWQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00d2a4c-c1f2-4003-69eb-08deb29cf45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 16:13:51.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8V0xqAgIsUaVlgXYEbRSZ90hFneKDEYi2w2WoQNKRz9iNlnBOqY7ChCO5dLg6+8i9nFnwQ/SpNsyFcB+YRu5GCKPzH9dG1vyGaRwAO7lO+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10490
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CWKA4zMJICkl5W55tTcn7FLUc6Wi3mhYvL4ShwB4E-E_1778861633
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 318FC554F07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288358-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
specification, interrupt type is active low, level triggered interrupt.

Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S =
MACPHY")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml b=
/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
index 61e11d4a07c4..766ff58147ae 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
@@ -67,7 +67,7 @@ examples:
         pinctrl-names =3D "default";
         pinctrl-0 =3D <&eth0_pins>;
         interrupt-parent =3D <&gpio>;
-        interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
+        interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
         local-mac-address =3D [04 05 06 01 02 03];
         spi-max-frequency =3D <15000000>;
       };
--=20
2.43.0


