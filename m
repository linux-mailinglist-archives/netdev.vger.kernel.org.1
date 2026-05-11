Return-Path: <netdev+bounces-286777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCbGDsodAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:19:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6935143D5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0A1830347DF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA54747B423;
	Mon, 11 May 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="C8dAO+ra"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAC41C2FD
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523566; cv=none; b=hsJnZcb3bAi9cKDDJKwgGuF4aFVu1CLsJJGGHJ5iaUCed4t2wl0ryDSmoeAspoqqQJw/0ZUtZIqnDJ2GI/fsHA6OQ5ER+H/HwlJGihQ//IYzdbGrN6hgXso/RQqxQh40On0WoDmfzznWmwYYL2VjUNWCH9VTSMbK9tNROU8hWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523566; c=relaxed/simple;
	bh=dvhpRANogguecGC0zddPEV5dUBtV4wKP1h0eT0uyYa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pxl+KmdTGTFfpQsh03csctG0DyTJqGI91x1zuI1t9Isw3/BDfn8MNbNAFNUZ2bVSE36RBJ7IvZjetPQl9XL6pgZvVLPbJwydY6zw7PhsNfBH7+e5kbTEIHksTJ/nG3e+y9BhgvjeBATuGJ4kxujOd9Aqr/BuAT1srXbAQy5cRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=C8dAO+ra; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B/NB0uDeC2aPhACRdEWE3/XH55yZ4G1u2gLHuQuuXK8=;
	b=C8dAO+rauuMmQFAvYpSsYb37YJRyyFCnj3j2ni2gXL1WsYp31n2N11ZI6BRr25x9RNGLK3
	Ek3dG+HLWouf3236lIVjDI1iM8tBR9GwjLm828wz5IisxvGwTq42xuQdhwI30xq2CHbFRI
	h9Mb69+6htE/M+m44IcbrSMHzAgztQWqJHOOFm7ULDToaBtZjIwzBOaDjRID/0/KfYLmG8
	IcZrBJzgp/VMSHplwn8rsqmrxH+XTF2KgJGqHVsgVIE6qdaVMO4800PDheEtOYq9YwZbgK
	B10Ec6TsDRF90kjZcGbSlc9T92wpt2girXC1DN0yoKv8utaDKxMjq8v0OO5DpA==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-19--uBgRZeoOb-rKBZKB_KvdQ-2; Mon,
 11 May 2026 11:19:20 -0700
X-MC-Unique: -uBgRZeoOb-rKBZKB_KvdQ-2
X-Mimecast-MFC-AGG-ID: -uBgRZeoOb-rKBZKB_KvdQ_1778523555
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:11 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:11 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback and
 read/write MMD callbacks
Thread-Topic: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Thread-Index: AdzhcLiQPfhdO8TWRI6R6+3XYqpw1w==
Date: Mon, 11 May 2026 18:19:11 +0000
Message-ID: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: 723043ad-b690-49a4-94fe-08deaf89cd09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|921020|38070700021|11063799003
x-microsoft-antispam-message-info: u8oMvA9Hic0E+rr8UYrZ+BjKYQktTeYOzhU9G/yBtqF3gyyeNb3ymlCnkjbaGiYsOrUG4gZ4hBGHHFat3hjD7vwHdJVnru8OFrpdXrwG+glwHmTwNoCfid0IXqFkjaWyzBcZ4wajfRPLN07cQaDRKaUsLTjbtdELSDNZlZgya09QvbEp+AOHPbnO0fpQrWbDwpkoSHnwKvUauVjw/a/PthbZ3KbJJ8/KOVYKcm7gp5PBGsyUlQoKaL16w1TNGwjiULuvrmZrEOjchJKdKrAN58TN5Qr2M3aHdK6m4aPiW+4VVJnSTMdSPwWMlTPRRGw6jn2bBtX7JLWxEAQoF/cODkKVSAGPnOekp3kN+jjpM8sF/AzZ3DDz85/CaCXRLepTPfxn4wnriNAJfz7JrL7ZfYRC+bYItC8rOKhlBHESSLYK8NT2sCVaaCPzRXhnx225o4RYsdl3G/HIclsffMP24nYFBJzcEvcXmxuApWvG6G1ik2Bb4aEds5YQOpVzel3KfPICtxJPUzOfQM1eAd1leEt06hdugH4uadTED4/mBB0rZfknFEIRrfd3DNHO4PHxbpHiKfoYHMcP+2FlVw4OJU9wIuI+1PEhh6ik9jp2BQjdFEtjLn2otjnZT3L3wMl7bIj9hRX0zb4Pvz2cdZVcHden+4hOTo7yhuiBNjIy8oKrNyENnWhdlM/ZuBSjCzfmthsXL24mPY7eH/sPiePi3qJPdDB6DkykF4AA7kgySDz7r1zKeyR8zXNa0zoF6E3X8vSoRxY4RpMNvhNAl0ltGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(921020)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sWq1olhKyYCY371Wvui4M/1uMUqbSmbnl1Dcvw/NxCdq9Al8rtXjcXDVwS7N?=
 =?us-ascii?Q?/U5hLMh7/IGUKD3j7ld188855iNnWQpNDBhXX/nDpYbWhJyEmH4GK5a+n5lX?=
 =?us-ascii?Q?T40IapZC9Rq+rKN8LkCuuroOWo7qnh/DbK9+QkoXTL1Xv6JUZ6ol9tf0GbSD?=
 =?us-ascii?Q?VFxPS7DjGpl+8Q7VTXo0p68oegc2hxRWXYUzXJiIHCDBHwYude2uoRxRGHE+?=
 =?us-ascii?Q?MHmhfINsyc0iklPXVik8zTW5Rks30b84FuCvLwFysG+rRLyYRDry1Uu20MyQ?=
 =?us-ascii?Q?lRrb9dj6hcupUrbKfgO6MlR89qVVxez0UbWV6Yd4rFrUzeQRKnjeaWqofbI8?=
 =?us-ascii?Q?6jn1o2Lok63ProZk8MyX+I6oO8hGUCWBhU0TH8qt3IvZJHt5cq+NMp4j4wcN?=
 =?us-ascii?Q?FqSQRlZYn5OMJsNK9O3Oq8EabSUodvmRRiPF95eHxpivN40U/GQBnBvKagyS?=
 =?us-ascii?Q?47Lsdh8StFHn4csim5RyJOU8+cIXtuQoAAcgWhAeiwTtz5m/Z9tEcbhTrwU1?=
 =?us-ascii?Q?YZVxG567GuoCLFigH04+qj5XBbb6ij0nJ2ptTZAQ6/acYwzJNzMjU2A/4Nke?=
 =?us-ascii?Q?28Ck6OSQMCSjwbk0cBu/FX4qrFyMcPRC9gCVg+c/+qkYrHWIbE8G9z3NOpX+?=
 =?us-ascii?Q?bCgIDHq+5pA+siWzQKlcZ0jUXiVRIPrCxwQkqx7CD/j/XMwjv46WdtEXWKZJ?=
 =?us-ascii?Q?MlXcSlCXFchoaj/clF1WedA3hiWTzPauIMiyScMjWZbGrId8oENz6leEhJQD?=
 =?us-ascii?Q?sxhXIdBby2ABcBU5FhW5z4H2j5QMx5Xnt6i3mxjbWaCOnGT87wDqr0xEr0JP?=
 =?us-ascii?Q?dJclbCVazdcUJ6dZZ4bQ4K4SFch/tKyv/xxv6nnbbykYmvHis80lv/dcs1YI?=
 =?us-ascii?Q?qHSzArVLGV2AZqM0cMK8EeZzJD8HY70NjQZAm/PZ2lnSwMNhuc7jGT55LKHZ?=
 =?us-ascii?Q?GNcezE6ZCUWBvVp7VOUg/uHzRTBNHehlPLikRma8+rI91neO4KRfTPvbs5cQ?=
 =?us-ascii?Q?9ezuojBLAoC01Qru9RrNYtYem1E+IVfp+wPyGeDpj1N0yuubG1IoK+uwBaUI?=
 =?us-ascii?Q?npNISISLPQYOLKGNrarwpRWJz1GJX+fu0cxHdsnNpUsXfqImPCuGrMLrFn00?=
 =?us-ascii?Q?S5Q5r9gBKiCgl0be3pfg/QlEwzAbvxi1+S2YzDYD0XFQfXlqjVFhuzHqLvaX?=
 =?us-ascii?Q?1zGtcNfqoCaXa3Kc1wA6JqZSkkWf9xv+YGJ831Vif1g8mgYWYRFz4HDSShBy?=
 =?us-ascii?Q?/QtBaseHD3GlBZR0jaVHFpHDyf/sMd7sbDZ3Ef2WZUiPnJOCEVZ4wDRvxWjx?=
 =?us-ascii?Q?1f6KE56Usp8Ov07qMriWFjjUUMMGXi27ThHFRnbo9adna02xvVnnna16VUyO?=
 =?us-ascii?Q?zKf0rWek6GqPnLyhDrwoXygWAqEmA14psZkJua7fLHWVaLdY5xP9+nk2OMdl?=
 =?us-ascii?Q?3I1Qlsy+HpaAUikBN8NMw/27Et2+GlK8pT31NBooVuhmKylUnLy/2AwGpC1P?=
 =?us-ascii?Q?OR+z5cIsn1/O930RoM2aHMco47EDjsbWZsSqXaRtHoHIHKCmCzFb9vQa9ojh?=
 =?us-ascii?Q?uDQ/l9rAsCu0mzoyMPLwY/AbaHw+nvgrmInPNdEd3sJP6x6SphGVzPtA8dzA?=
 =?us-ascii?Q?O8Weyt1s6FcI8S45xsKSJkXRtcAjq3oUT8romfIh1K4QCJ4vyCBobi17mXk8?=
 =?us-ascii?Q?8L/AoxbkXxg3ONB+409SfgtOWRbLOKZKCDbddx5yA2zwF4uUEXM/wT/KHejU?=
 =?us-ascii?Q?7Y5G839QjlXURkXN1Lsm6AZLgrfj+a0=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sCpfwKMMCrEZJN7zKMbpRDn6nNEXY9kQQ3z0X1awoRjKaSEtC2075jDcCRiUuQ5pLxWFNQiCZXhyjB5KTqy0yVV5twDzHCir2s68tqDbT29ztYQqDskE4L/nOFNfblClBUxrxzRc1Ep8dlUV12rnuxyrKj9IKnT7ID6jo7+jQ5RPRp7TRd6s/olF6+zYpioisA5Qhrt1HKykTccdDvb8xZbJX92kVwdZIh56wn+QNesg4FyZJwZ4t/wRa0kmfy5QOfevgIbrXxJFkVULh+C85SyAWk7kB7JerZ6Db51m7OFKKSoeKSMbN1DEC2b8YCbtaVnmbYf9dKZI6rzWbETS9w==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723043ad-b690-49a4-94fe-08deaf89cd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:11.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZ2r6J3YO5a4bhp1c/uMMCRTf/S08+eG5Dw5vySoiFl/zqRMKQHwAzKUzFjcQCuxQkxvMdl2G3UUutfjiQd3dH0DCgcPQf8UGaNscZpg72I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YQNxzfxVGMFphPho6ID5dtDD6pdhqAV8A8EKGCbKDmg_1778523555
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AA6935143D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

- PHY loopback has to set only BMCR_LOOPBACK bit. As a result, we can't
  use generic, genphy_loopback.
- Direct MMD calls via Clause 45 read/write avoids indirect calls.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/phy/ncn26000.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index 68b0e4647..d302e04c8 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -162,6 +162,39 @@ static int ncn26000_config_intr(struct phy_device *phy=
dev)
 =09return 0;
 }
=20
+/* Directly accessing via Clause 45 read avoids the extra
+ * SPI accesses required by indirect access.
+ */
+static int ncn26000_read_mmd(struct phy_device *phydev, int dev, u16 reg)
+{
+=09struct mii_bus *bus =3D phydev->mdio.bus;
+=09int addr =3D phydev->mdio.addr;
+
+=09return __mdiobus_c45_read(bus, addr, dev, reg);
+}
+
+/* Directly accessing via Clause 45 write avoids the extra
+ * SPI accesses required by indirect access.
+ */
+static int ncn26000_write_mmd(struct phy_device *phydev, int dev,
+=09=09=09      u16 reg, u16 val)
+{
+=09struct mii_bus *bus =3D phydev->mdio.bus;
+=09int addr =3D phydev->mdio.addr;
+
+=09return __mdiobus_c45_write(bus, addr, dev, reg, val);
+}
+
+static int ncn26000_loopback(struct phy_device *phydev, bool enable, int s=
peed)
+{
+=09u16 mask =3D BMCR_LOOPBACK;
+=09u16 ctl =3D 0;
+
+=09if (enable)
+=09=09ctl =3D BMCR_LOOPBACK;
+=09return phy_modify(phydev, MII_BMCR, mask, ctl);
+}
+
 static struct phy_driver ncn26000_driver[] =3D {
 =09{
 =09=09PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
@@ -176,6 +209,9 @@ static struct phy_driver ncn26000_driver[] =3D {
 =09=09.set_plca_cfg          =3D ncn26000_plca_set_cfg,
 =09=09.get_plca_status       =3D genphy_c45_plca_get_status,
 =09=09.soft_reset            =3D genphy_soft_reset,
+=09=09.set_loopback          =3D ncn26000_loopback,
+=09=09.read_mmd              =3D ncn26000_read_mmd,
+=09=09.write_mmd             =3D ncn26000_write_mmd,
 =09},
 };
=20
--=20
2.43.0


