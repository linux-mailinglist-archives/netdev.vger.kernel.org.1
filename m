Return-Path: <netdev+bounces-293254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GrIEA/1GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:20:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF386086E2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFDC931A37B9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69744A71D;
	Fri, 29 May 2026 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="iqL7hUhW"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14B449EB0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085101; cv=none; b=uB1McMsjzdKF7g8sR5CxwrduJE97IvIgI+Ibz0hDcX6KBmVx8qY6qz1inccXuewckJVGgq5hoXXeYCMUTelO86Zeavje4i4V5crgtBGhSjpOAUwXU20sRVz6oF0y/VVlt/Bxffr4p6NkCZ8wr3XVldavesxamL3Apo9VeW32sY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085101; c=relaxed/simple;
	bh=cboX3d8XkVXIEKowAOjoe4Fu6Sq0Dq4+kvLQFmjQATQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z9xnuh1fbXIGI2EUJOsw5LROdcstm7I19BgjAm/otET+PL0+sMt0jHvIJZSe9ia/TeH+zTxtdY/c4MvZsdp31BAQVcoqUCDhGWRd+XtWUJWkIJakTz7PlAi8tIjJTo34qSyIeizjJNQf5GQ1OuFuVFXwASNqG8ZoEbu0NAbGHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=iqL7hUhW; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780085100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6z1jfvzQfiPZQlmfQKAx/3yNkDe+kLUmEifZ3V+qmwQ=;
	b=iqL7hUhWGx3fPoIf4Yyam6eZIfIQD0rdMXDExZqFtZF/ZnjyRas5HifNnSCh/8h5E5GPbP
	KubRZtoaMt4rAkT1fbbErHsgVlyA0x7YN4aJnOzfUftlLPkEOy+DhBnGeQe5a1AN0tDd2a
	UdJFhBoDJ35rxa4pS1++pC6s+Ni09kb2GckW17rL1Ja5DHzSUwjm24f9+u83cCLWIo3Hip
	UvBCOUA+veUtpXTC8qY1CL+RU0lB6CVb0AR0Y28TF1F2u4SCJHg3UYOlv5N9sclx8wWxQI
	qmKqLgdfVMredDF2OliZc9xVxX/alO9tN49vu8KRTVtDxdvGjO1feRgCqP8+Wg==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-13-EZSTXzn9ObWJE2oS3EUZTg-1; Fri,
 29 May 2026 13:04:57 -0700
X-MC-Unique: EZSTXzn9ObWJE2oS3EUZTg-1
X-Mimecast-MFC-AGG-ID: EZSTXzn9ObWJE2oS3EUZTg_1780085097
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB7746.namprd02.prod.outlook.com (2603:10b6:303:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 20:04:55 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 20:04:55 +0000
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
Subject: [PATCH net v2 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v2 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: Adzvphv6ynOJ7tFNRMGEE6zUoRwGYA==
Date: Fri, 29 May 2026 20:04:55 +0000
Message-ID: <CY8PR02MB92497E67D5AB4C72E7A4C12683162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB7746:EE_
x-ms-office365-filtering-correlation-id: 09127b92-27e6-44ec-30ec-08debdbd8db3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|56012099006|6133799003|11063799006|18002099003
x-microsoft-antispam-message-info: rt4Yu3r4ynDuvxUZUa3bl+hbOGtZHsku+22j8CdqFqwbx6rDLnXktw4i6MBRk1CElQrTsAJwq5mu2mf7QpgHafNnKjYyeb/ZDgmIvU5sKWq/vBeKh/Ml6uGeYn0fI1JiWvNN4I02DQR7FiH6BRmWVC0DqWuaz7ZGamq/JkafhZ+UaV27EYG56xoI71s0Ne2bJrvQjBB/M7j3zGlGMGHu2cGvE+5M7cD/3yuKT6VieM6ueWCFYUu5Yax7IBT0+nfcPDH6L1SbtMWed6wqizlEf1gCz0GqOzrYDfJQGTQh/ct9ndZ56oYTMbiaIt6eQ4O4SNfggJfie+jwFWDmeR5hNJUJkUuNgwJ8zHJau54f+xD1wcVYxdG6d78RdRx6opQmZn3c5mkwbbTCBJrlUHucDM5OQqZVKb8qvbVZvp/QM9QgegDA0VR4cLpFtC2kfCc2Jmy2XpkQlq7bKPg8FlACzE2jOjqnm4956PgkcuyStaGWWeA8LrJvshszmPwMMnd9dB5bQ9Zfvhw/2gZeK3v6sNqJrJhDYhhzJniK4nph/9MjXrQL4CJRZS6M7xi5Zkg4zxlQjts1fJxfg+VrMqH4qZVRUyeSi8oaTVXfWMS7Duy1jQ4Ow+BIBvmgcloR58BcOSf31z6828nv6rp8ZklIOFXIFMoTlpLbojZWL9mxhAc+b9nd1r/9j957CWCOyXetWE+dNEKg8O49UWICulA2ANhv8r5HUVrWq8wrPyuGuP/FJIp3WnWpR8PYtV1BqTOlZO6gSVfze/vUENoDHVKpfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EuABdMjcT59jfQElv2uOQBzhB6I0PydCkgkfIFIy94G1UHq3vG6CTD+p1+u2?=
 =?us-ascii?Q?zhHXj2gNah6I0ZQ19IRBmPy1Bq4Shg3m8uXBgrtxUcElhKDeFPCHeYVS8XRM?=
 =?us-ascii?Q?bm/NQvvwARt6ja+iPTGw6VYsC1l4nc8unxE2QBaSdTjSlhI45+lq3iPAYuVf?=
 =?us-ascii?Q?gK1gDZAR2gBPKbcNOX815EjjB9c0SKRGhzQYQO2KHHHd/JHc7T/ygx9ijftV?=
 =?us-ascii?Q?B/W82yw5fuRAisbDdG1AkHCsYbn1HCo36VgOIWbpuHKXJ2cGkSnaU/q72+mB?=
 =?us-ascii?Q?6LcwThlBz3sBvJChVo/z6Z8Zpucb1eriKMz8bgWxSxM8d/O+XsQKeE/hv6QT?=
 =?us-ascii?Q?NZpwzXO7lhUyIaCdCmsAJmoqFEAJbBbNbxUtC6rVJ+jy4+gwIRRhFD3KOJmh?=
 =?us-ascii?Q?M00eBKnJBMhDpRtQwRethb0+Q2f9FpbQIN+pI2gBzGTvE5xpyBCU0DbFGadW?=
 =?us-ascii?Q?C6gAan5InmXsKrpBX/srJ7Yh6gVeEvGzDZlSEHS7JzakN38mMmyYuJ/sEVOx?=
 =?us-ascii?Q?Ywz5zNfJst73smRXBi4Ktzjo4tPyoYvBaW4TeP8oZCRg7Dr9ahP+2hhf1+7I?=
 =?us-ascii?Q?2LsxeeqYy+vR9TOasA/WpqJmDSGT8Sbp4rOYXSG2m4rEUG/M/uQz/nWludiE?=
 =?us-ascii?Q?9szsQ8xylX2qph65K+2YOyU/QJ4eWGEBoIRH//iP57qV1746RiJsLjk7/lIi?=
 =?us-ascii?Q?85XFXu3OXJBkVW/TvcNtjd9Cd8Lu6VPwx/S5ciMTE0JADbB+qjLWyo7mfOfU?=
 =?us-ascii?Q?LqsyrVYmMfdGIopZ8RMwOZLHge6ENelX5l3mhCNT8DYmDXOvn0lQBvmiT/g0?=
 =?us-ascii?Q?we5tSbVYb0g+tQHng9rtI145Y/IrDL0Xgdf3un81TcqbuHxMKvaYLGkcYxZU?=
 =?us-ascii?Q?RYVXMh7UT/v/vRJXdLG7oXGZyK75sGMRMNYoi1kfOgloiMbvI4UhpRFO8fUk?=
 =?us-ascii?Q?sl+jk1jZAgOUqd3dEljNU3OFdVfuqPVUIzNLdhZVCTNN0wOxUusfbtzg4gTc?=
 =?us-ascii?Q?UeVKfC/qwCtlkB78VKdw2noLFhDw3wOIdxDHH15PrOV4f5Lmx6AUX80iMgyu?=
 =?us-ascii?Q?qgSOLETlOOK0BWHKYw98cI0t8VFjzDYuzZg3efypHvEJbqJU1qG008lWldCK?=
 =?us-ascii?Q?AFmJ/K6a82RXUQC0aK0bCsu98CfJkT60ZyD2VrqWpRfcNeErItSi14Y2Bmuu?=
 =?us-ascii?Q?dmOrhb/ejWVFAJRvbBlMc7WOcqVYegkvRGqAAWDb0YsigpEL0iqW+9h39pVd?=
 =?us-ascii?Q?3KpvmSB9XkL0Cs0gj1tm+5+MKg+58a6ZceTw0hHmJFvAcffedW5o/gRs+1cs?=
 =?us-ascii?Q?04+EHpPjQAutfrsC0dJsZvOBVe7vvoyUAp9xUV+a073Ftr47YnqSXL8IgNyT?=
 =?us-ascii?Q?LuwqgLsq3a16bo5M2BriwHnRAoy8KHY8PX+4TcdUx2aYfXOPUicrKp80NghW?=
 =?us-ascii?Q?nVyCrgJ7kJmjkxEYigERwvoUCrPGEOgZRKJVLKLqs0+QX486yGOFrShreHGH?=
 =?us-ascii?Q?UeAEv6ouE3SnOm8Lw98W1LZijcl7MxhWW4PwndCwLs+Pn/wZdwXAGh5zr1iA?=
 =?us-ascii?Q?smE+6xEY7Un9Q6iI7YtHSpmt+t16K7NWKMFHmegpyd9xM5c+PgXDvcxEBylX?=
 =?us-ascii?Q?S0WXGLIpmTCpciYIKpZw/f3EyAdt7xgBgi6k+v9/MpACivFhFCCxtN7uBX53?=
 =?us-ascii?Q?tUx6yQrqSY1isWkAX28XMQSyipbUOTeYJzuCAkRtLXXe7lkkCTIbG0AYHuwG?=
 =?us-ascii?Q?ukQHX0NcFdkKule+DLXw02IVntn6i9c=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QeF2c8dXhhqtt7r5PQxETuR8QLHfNGnlN4jCXPISsO20f/XL+IpxQDz5aTTxjxPONVtHJuMpSIuqOu6plVUX9ImrZ5xjid6f6kyK34tdyYjMjgZUas9AsHBdbadf1eWMNVdupE6MwddtfDsaweRc8R27vcqjaMOQWOqVrw4UWy6xt2PjuEkBWaVIMnWhrK+SWQh3nzwk1No/VBKW6gmmagZkozfONeDftdYslzPIdurgkPbYqqazs79w8L5GtHyk6Q+J0dhjCn09WBKXRjErNcNOG+zPLuO+Eses7JW2lm72Pgj1jNp13vTlS+fII1eLhyAGfMG+cLPYR64gFVOb3Q==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09127b92-27e6-44ec-30ec-08debdbd8db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 20:04:55.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+bxWNQq3aBQLKXqXhPJSqUY5fpW0u8BXfo2JKcyE+lPe9OoRNHUb8Nxhh3W9d8xv9cruzVkmWiq9k3UHbwZdUPXUFzLxpSdhhPBh2JrOUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7746
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ul0UaBOOy__cSvjn4pjbYL2GHAzedreFp5Pngbh8ms_1780085097
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293254-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CBF386086E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


