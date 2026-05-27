Return-Path: <netdev+bounces-292127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNaIOYKYFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:08:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2E5E03B5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D500C3006B45
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5B3B7B8B;
	Wed, 27 May 2026 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pi5nt2xc"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA628D8DB;
	Wed, 27 May 2026 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865728; cv=fail; b=B5vBPpYBRvMit/9myFJeNKMu6ATUai6UvF9w7sDf2zA7f9kJfs1odwNb2uB0q7rILId9ohdtdT7V7EVsudv3ubh+OJL1SnesyLNn0WadZgvQWj/NOqAOCK22zSQfCeZb/15cuglfbk+7N/Q9a5IiiZC9JAyMD76KAOXBSXai92s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865728; c=relaxed/simple;
	bh=GNATgAfeX8NikAkeDrb5x+NSOjRH0Gv4MNbpG6RZpqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z483J9BpXa5iAFxnWeWYbTDlFuDWJUV4Pj2ejc5pI0H0dn3ZIibo5z5xe+sepjVoRZNCgAxHBkMKcs2CcVXsVaUiUdE6xvgLD7WdY8ZvXiECnnJd6Y1KvPMrxNTFlNXvulPKBOj4sI0Uxgu44liIndsLpogPLgjScs5A9WU5x3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pi5nt2xc; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3AOsAUiUrIKe5LVQsjGmaQecufifyYiwQjZtadv7+68+FUNNDQ/WLYf0PjOVDS8ncA6+wiDhGBB/qsBMwS+G/onOdxPMEiZKl152W77t0+yObk3Lq7Cp4JxRyZtwWhIv7cSThMFjhQDC/OKlUgATgjTM/2LQT6XDNd5IpaHydy/jY/oGKZNPj+CGEzmsGTDLCoQNz+WmJ+xQPAUYN7lvbeurECN1C1vI6yLvn61ajLovUuSqYl8LlsoPVA4E3UXQtqwK1B4eXnHibKyAOAVnwA6eclxmQdeuKHBd3y7q542E4791xB1z0ewnQ44uKl3D9OHNnjb9NACEKnkMieC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c34rw1NvsjRVQkOxQTLJRZQKzXDpKaxjrLTLoUfaXQw=;
 b=LFKEdYqYmsxKMB2c9qJ5U7ST+I3yPnMatvtIaAjzJhcuUYtgrFzPtndul3XLUN3RRFEJwlHBRJs2AEXUcUYVmn9W/A1fo1gt99vBbj1ff+TgYCcrhCC82uLhCKNXNLPITyqZZTop8ZvdFUG4XOjJAVFSi0Hy+Axc0iJJZ1zcfwKbQEOlQST3QK3artYJYnW7nhn4+LT6TDMlGz4obANKwg9ubdUqge1WxfLlsOYoDrt1+CqMP4+OuaWYKCbsSIc3xIVs322d33KX8hOML1T6s53tjl2/qPxDnPxA4EE3xkxL8MJC8KueNkpgqHNr9vypk7oHbCnBmgel+Ev6btmMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c34rw1NvsjRVQkOxQTLJRZQKzXDpKaxjrLTLoUfaXQw=;
 b=Pi5nt2xcO9wDuUIzgRE1nuakzFnYHHefHKzTOpNk5bLaBD8gw6fOgC/57OdNAgnDtjTMapMrFCRy4G8b1w2xrhOAnEEwaKprrphJU3HG84npI/LJpfCenDRBdUT9HDKfcKavtktI7F4uMw0ZFNqfvTiAqUDu0+lTWs9ve96lQ0+xpjxnPwvMcsWqt3Lm28dNc9GKd2e3CBR8n6uNfL+jaGRKAuHT5zLY+h4ZQbs0eQ7NSrfnylAIkoBm7kDEY2H83Ge5/kNKHAmgDnXZt6ggsk9Ck3uIfjLmv2Jib4XlWMFtUMbbLMDo23mALvJ3r1Ufpt532SgZvjV5bQFcVcE0og==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:08:44 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 07:08:44 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Thread-Topic: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x
 device
Thread-Index: AQHc44+RlfikKcFZCUmHVVUY4T4x8rYNeG6AgBQCtKA=
Date: Wed, 27 May 2026 07:08:44 +0000
Message-ID:
 <DSWPR11MB971561B42BB157F7C8C436C2EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-3-thangaraj.s@microchip.com>
 <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
In-Reply-To: <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|PH8PR11MB6731:EE_
x-ms-office365-filtering-correlation-id: fab3cb5f-c2b7-403f-ba7f-08debbbeca07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|6133799003|56012099006|5023799004|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 ZeJNuCdIf+S+abmSwJHNCpqMTcNs0zgzFu5HrMQSUemal/eNFksnHBlVg7R0yemZ0H52pRmZtgMFKUAcRUGRdy2RrBqrxsmxshHV76M0YHAxp1IhPXgFZDuBTYNe41+AaEInteu4+TLCOfd2/ohoh/Fwn3tyu1O6HL5v9KSr0x4VXjiy9R7LQADLEgnae/JitPKTw/cxlDbT3t9o//VcF/RqxSv8SI/r1+I3gaTOqu+OvRJ2tytpowFR9SCJMC6PUgVzuXKXLmG6SqYjBHnDai7dO1bg99XEUvnJ+MbEUYkVUcCZ0eNg98Y+km3I64FxOtpbZMaKVru9+8U+Hkhxra07ZmcDDJz4ZXKIMNEsXTfjBgH9w0dvrdp8Fg1j+6xncnoBtBH2aiI1urkQ1qsOFzUr9k1fKKhyNx0Hb6KQvgONhkMyH/s1n0x0ig8mxhijsx5j67pCwAXBr+BuvL8psKNxbLQtyhAf7Om/lfCY8WWE2kyZFcU2RGJ1IGcZm3JUxv/haNhk1KqJcCME+hBH4VAoFh3KiQ7qCDQbQNh7TgmRpYcEpL0/s0pNgX3dF7qpTMV9BT4KykJGZyCs6iBhoyHioYCz3G4cAvD8o74ntUtIbb4MVhP30SACqjZiIHldgtscMUNyG4cU7iDfV3CdryxzXDLFyswBk8AupCwZAf1naymsAqiGu9VRdozMiyb58qewq7Q/vmOgEzljaH29CL2mPvsYH6ijlfZNkYpSZXgEMVqTLgj9NCge6Y49bQ/J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6yIYvocJrfvVh3qXctt+OrFotKScZjQgBUMaB07xKUkXEUHl71/sSiq/5btZ?=
 =?us-ascii?Q?M2gIWXb5g3mRgekJATARL9IuiSKJDnDCj2nk4p9f02p4oJshvcg5GLZrTbNJ?=
 =?us-ascii?Q?x4RjjUPEoUETb34s8pObgaw6/MIrufSwFqqZS7jlYFY+3IpCgPhu5S0RazRi?=
 =?us-ascii?Q?X3c0wIy7LtB7Q2h2Nhy4hy/V1kua90zKFfoqO+InrDemggAKPCykOa8YJwsF?=
 =?us-ascii?Q?GN7C4k2Zb3YYZ//8aPHodnQ4fmL0OAXnX2KYb5jvA4ZlwNoqjB1v00TyC8dq?=
 =?us-ascii?Q?tR8dm9aWT7PW2xwr/XzRmpdWHB08QreI9JLVSNZ/zRfN1GXSWxmHxEiWSwD0?=
 =?us-ascii?Q?WNvOwrgQits5/e8gpifM+yZOyIU8oIB+OlA00e01mAUAZFzCQNu5f7ywF81f?=
 =?us-ascii?Q?exask5dXhlkWh3CZqb5vL/1ESlxxLHuq3wwxTX9nm8IghFq+ANfi+hquLz3L?=
 =?us-ascii?Q?mhfloCPOHsuNp4u7Zy6BcrG4UcrP5Hl1Vao0ctigpIxvQugI1PSQOa4vaT9Y?=
 =?us-ascii?Q?z+sQpA0ccy0neAz8f78q49bckW9WeBO8DfeLsay4kB4oUhtVqdzzngpnyGDI?=
 =?us-ascii?Q?WuG1stnZeDfF9HvKAwUCd0w07lMIopAYH9PafhujOCDkBpXLtq9RJnOuVCg4?=
 =?us-ascii?Q?9FEN1oHLCBrU0sOSVzpkVLWXgsBNOBbSAnhLBgA6Le9WOCAiMLCc95KBoxgp?=
 =?us-ascii?Q?rqRwEmqPgqI8OewZPfrjR146DV7Ysb7tBeMXGUmmyuusG+GM/mWTqhSiUHEh?=
 =?us-ascii?Q?5EsGt8dbBtFBBQAHQQnsYmM3DD4Wis1WiNkpefZWtJJMa49G+/Sh9nPkuYlo?=
 =?us-ascii?Q?YYKN5n0X0Ak2XQ7S8z61hfi/YcW3UUvyTAzgojQTn/WIEBqYUoM4fC3i2vIG?=
 =?us-ascii?Q?IVi1FgcT/zy9u235WQLuJlkxMriR4q4Rj5SwEnzdZYSYdLGNSgqCJgPMWsuJ?=
 =?us-ascii?Q?Lp4pO7YUnpBHK1Y83y5PvP7/suHSQSL/WcSDdW4DWvy1c4C2Ih1wJ0/p8fR7?=
 =?us-ascii?Q?A3F1OWHMhJiouVPDr7j7dCh+bpJmxcep8UTBpN4AFrQmAu64gLfcfpmqxIRT?=
 =?us-ascii?Q?Qzo0tbRo774w3RVDatnI36eU/pm6rRpDOElGNrop+xKCCVhrf9OnArQUFfJY?=
 =?us-ascii?Q?feWSADhJESdyCNGFouLoclN5ZWTrZW59BgWsBPejwPfI/mNP3DeN/n1ROJMT?=
 =?us-ascii?Q?vgvUWYaHVHn4Q/ls2dx2F43KO981LbXtvEi8GbzUt3JNzz8poDZwjfSSx63R?=
 =?us-ascii?Q?q/ZP3hgCd23aQwpfWZGZe7XzpsCHf+wIcv5r70U09epTYb4AmOq30snNMsGd?=
 =?us-ascii?Q?GMqfPgqpQsJgqPGXvX2IKDri+08gSQIzqabWhHfW8px5l20XIAw74WbfP12H?=
 =?us-ascii?Q?1fPvbY767aJDvtL25qrVKaAyn1jmHD7yUcyKZ14NFCRaKWQgOSyTO9h/Il+Y?=
 =?us-ascii?Q?rvXhpIuhxleabB9eO426Q6D8kOXqoMl65LYHt2aehVI7UH/X/lklYtg7Gusd?=
 =?us-ascii?Q?17Wqy5h57P79ape4ZqhpMInlxPW+8rmQ7uKtU/z5Gqf+XVxkyvdoDVYRtypJ?=
 =?us-ascii?Q?ZigRPeAZcn5w8ypmR8rQ6g5I42Q5d1slgqTjbCo+/ls4lURQbPq857OkFJ/9?=
 =?us-ascii?Q?Qb2ydWAcBZHqdE6sMkRp1hAX2Ds88HGurlcEc+T2t3p15OizlqFrSsJzDrlz?=
 =?us-ascii?Q?kEKagWmkKu4qjdTypHGSRdv0zVURzfZ8vHKJWst2nL0G5BcsD7b8oq8xKe1c?=
 =?us-ascii?Q?0G4EXOIdPQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab3cb5f-c2b7-403f-ba7f-08debbbeca07
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:08:44.0560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwvCqpFOHkvVSTdy0+kzCxrHHF+6e9Rydqp8sOByxtOA18XNsuy2p/PcfVAOH5veLm0BmMxyn+vS6wcTvU/TBOLfcbP5D7hZtT8lO2BM2lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-292127-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,davemloft.net:email,lunn.ch:email]
X-Rspamd-Queue-Id: 85D2E5E03B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,
Thanks for the comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, May 14, 2026 6:17 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x
> device
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, May 14, 2026 at 04:20:25PM +0530, Thangaraj Samynathan wrote:
> > Reads the SFP enable bits from the strap registers to determine if the
> > hardware is configured for SFP usage.
>=20
> What exactly does this strapping mean? Is there a definition in the
> documentation?
[Thangaraj Samynathan] PCI11x1x has a strap register, which is configured v=
ia
OTP/EEPROM. The driver read this strap registers to determine the interface
configurations.
>=20
> > Introduce CONFIG_LAN743X_SFP to guard SFP-specific code
>=20
> Why? Does this add a lot of code? Most MAC drivers don't have such a Kcon=
fig
> configuration, so i think this needs some justification.
[Thangaraj Samynathan]  CONFIG_LAN743X_SFP was introduced based on
  Jakub's v3 review feedback. There are devices on this LAN743x family
  of devices (LAN7430, LAN7431, PCI11x1x) that do not support SFP at
  all. So while the amount of code in the common LAN743x driver itself
  may not be that much, the dependencies could force an intended
  minimalistic build of the kernel that wanted to use the lan7430 device
  (which is rgmii only capable device) to have to include tons of kernel
  code (sfp, i2c, gpio) it does not need otherwise.
>=20
> > +#ifdef CONFIG_LAN743X_SFP
> > +     if (adapter->is_pci11x1x && !adapter->is_pcs_en &&
> > +         adapter->is_sfp_support_en) {
> > +             netif_err(adapter, drv, adapter->netdev,
> > +                       "Invalid EEPROM configuration: SFP_EN strap spe=
cified
> without SGMII_EN strap\n");
> > +             adapter->is_sfp_support_en =3D false;
>=20
> Shouldn't that be fatal? You have no way to drive the hardware, so is the=
re any
> point going further?
[Thangaraj Samynathan] Agreed. Will be fixed in next revision.=20
>=20
> What also seems to be missing here is the case where the strapping is set=
 to
> indicate SFP, but CONFIG_LAN743X_SFP is not enabled. That should also be =
a
> fatal error.
[Thangaraj Samynathan] Agreed. The SFP strap read will be moved
  outside the #ifdef so is_sfp_support_en is always set from hardware.
  A #ifndef CONFIG_LAN743X_SFP block will then check the flag and
  return -EINVAL if the hardware is SFP-strapped but support is not
  compiled in.=20
>=20
>         Andrew

