Return-Path: <netdev+bounces-293206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO84O9/hGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:58:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE4F60796E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E0F31036AF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07F46AEC2;
	Fri, 29 May 2026 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="dlZwe7+W"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A83466B53
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080088; cv=none; b=KOaYFCI9bcbRuC41UG/3QK2RH279DF9NC/5ogOChzM7qmPHEniCr2Ql9KJgTOTY4a+cYNKfP2F0vXnsaA905oGkeDk+gYzyGUEgw0tP/OgOhok97sOwpSCrUkhVXOfjIqIFthj2S57v/OE5EuaLQ9c7k1aSb42Tb2YufDPL/d2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080088; c=relaxed/simple;
	bh=DtUJLjTS54Gf5RhA3g78+mtiVlcNMTU88aHVLfUYPOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lNVuksupdsOB4KyHly2mGvWZgQCCFwAv9XZe+sIoYBt+x4snndV4czLgt9+SnA/IgXkBl7zBJQDbSDbkZrjBxcmwYRyVC+M3YBR7QDXpMg+Q3ilfqh3v0NNAysVdJ5R6Cmf1lxRnxMkrM1CLUX9rzC2OuEXb5/mojWInwCADF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=dlZwe7+W; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KPDsTr+rpNEzIbuZ19Dy5utSJYfa1FQhsgrfilNlSno=;
	b=dlZwe7+WxwdAhUi/mRvMkO2UYJE021dQaVCxBMRvyH0Yz0V5X9vJS91o7sUQtybCSOUF9r
	9xgEd/ijDfuzwKNO47qjs05n3QL+lxjLqTC6z1Ek4dh1A6WwBgPU4yaYoNErHVczNtMTZC
	M20vGEpar0PbsZMeiyTN+RTk4UgIQmOLUphp0kp3fxePyIGqne4rZNdMUzzHH6yA8Q2c2T
	HOLkoknPV5Aom0n3yw4rhduL/uJmZn17iVHeqB9qC6KDG6IFNSKJyyUPIBjYo3H52IZf7y
	s1cgiJhePC4icLvFn+HdqDREIKk5joC9KV06CdwcHhH0J3QoL7lLwY6ZOrKJXA==
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-32-YoJoxsJ3OuaeMGDXiEGtfw-1; Fri, 29 May 2026 11:41:22 -0700
X-MC-Unique: YoJoxsJ3OuaeMGDXiEGtfw-1
X-Mimecast-MFC-AGG-ID: YoJoxsJ3OuaeMGDXiEGtfw_1780080080
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:15 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 11/14] net: phy: ncn26000: Support for loopback
 support
Thread-Topic: [PATCH net-next v3 11/14] net: phy: ncn26000: Support for
 loopback support
Thread-Index: AdzvmWh3z2fZMkfqSqmvJbjWwU2cFQ==
Date: Fri, 29 May 2026 18:41:15 +0000
Message-ID: <CY8PR02MB9249BCB1ABC4D1923CE3CAAE83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: bfc3310a-2c26-45f5-ca7c-08debdb1dd9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|921020|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: EfYYIPAVQE4mb+JOLxdg5+PlrLPpqrOn9/Dgt04tKaqX69leY30bEwc+RA6YAEyBwfZme+psdn3qUJPo7JW3fHaU6xaBiz3IeHuicuOCqocF3hPDfuZ7u+8Yc9YgsRIrNEOk2PxemzzrXkkfIr4v8fSJ7sCL0vNRtyXvvE1IulTQKyvihnx2Pbpo2l99rGNAk4dheWmeSKfW0J+sunpYDUDe5+YiARPIm5qyIK7TbwnuV3waACo8ySVlvNaIqOZOi7+KDFhpfZSxj9eazLJ8+FNtE5H7d3iGGae3CKrvSx2WzAZjj5/2wGwpEcGCRWe0kAyb0GPkreg5ey2Cvn2vytJUocQ5rgG8Mu1Y7QHsOd8hMpm2zu8JvDxtEruF0Z/i6rHFHnMMrDJ3+uy3feGVsCF5ToF2R5vnK4qd3+VSlXAKsvWbIA0sqzkYqHdMxH7NZeuLt1d6RUQvgJNnzhDWi7nBsZPrlncx8WjADNtT66QeZAjC5rETZz3WwvIUwkV+kOJ+OvB0a+fZbaTJxCj77JThO8C7TlC5sgV2KQ4NAGDNTY3D4MCFySka/Y7IsMOFn1aHop258MBXVJb7SY95zUkZuAgYV1Co8j1srSCjT8kI1lD32FUDY+1cOZvY5fG5dsUEkWTY1D+lfMZbUgyYU7tcT2dJfvEnbHNMINoMtCnycCcnqQmnn8CG2JwHqBnQN7odzJehGAOfljzyOLM8Qc5Vr4bN3Pe6CKMySvo0QBnRbdqVxBlgPLHAj/d7L/M0wT+sxuTTNGaNZf6dDWpB3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VASijWwgetKDeNE4Rmw0UKd7IggrnHl8MHCsVNcJmtXrN9/h49GVb2YZnVEA?=
 =?us-ascii?Q?VO9AXXW3+/yqc03tehf5LU0L3l4nHogg7B3OtKtEc3/+hRQGHI/IhJlR3QPT?=
 =?us-ascii?Q?V92v4QsgTX1gUSiAmdS6YH/m9nqy08NfZzC/Usj5fHvHZsHBCGRzmLQeKSJE?=
 =?us-ascii?Q?xVGLKbsXraJ3ZqIlodirJLln2lqzK2iyy7zaWv/2WvKuJ5HKVmd7cPizg+MY?=
 =?us-ascii?Q?XFE41b4Cmwx4UzQBTkWqanql2kpLYhmZ8nSkzjQRCiQNie7yvQfpn1Wq9Jdj?=
 =?us-ascii?Q?6rxz1r8e/WcstMYsJcB7wqAFs5rehW09YQVbBksDkYiedg1X5hJyMRpZtEsN?=
 =?us-ascii?Q?V+ha2aVZwFOKUko4l4v1XQQ+FXId4Z5tF3+0K1rTTmcQYMtnsOnIBadaxyYV?=
 =?us-ascii?Q?uXt0vUc8A8FluEHCYDfhwCrvsQkE84kJX8Gbr3ftoGbeGRusJ16gyrj8MbyY?=
 =?us-ascii?Q?gghF1Hu76CUsiY9by++5BsNBN/0VSVeXzJnRKL7exU+7/WObZ8Y1ejfL2rPz?=
 =?us-ascii?Q?ShF0c1b3Sq5mtKmm8WrZdSsEojOEazkEVUBOjMPcBcIqYmBclvHX+6LbwvVc?=
 =?us-ascii?Q?z8VZ4INXWu1xOD8rLQlz0DrHbyYv1zn/ADALpgZvwoBFNr8ZUo6I0lfUQE8V?=
 =?us-ascii?Q?QNYgNpIVKtA/4JJaC8Zr7AqwnuwvPxvS2fntLwuMiLpFrJnrXtDjrIZRtkH1?=
 =?us-ascii?Q?rQNnLEXcpQf0geH5e6n0l20ijnqORGG9hlrdKFV9D3dFEdsug05u4Lmosni9?=
 =?us-ascii?Q?W0SKtwNalG9iDPySa1TZdge/LGBHX3+aOZIqvAkZ1i/W1yu4LXUYFqs/2p0b?=
 =?us-ascii?Q?TA3AWh5kcB4PBhCUKlogT5ov2rFA75yJwcUWRNxNuyNXCL52ylervJd9mqZg?=
 =?us-ascii?Q?4txv0SxbeLegZw7zytj8v/JRGe/2dsa7+GlIvqMZPP5EcfzmZp8RBRGugODu?=
 =?us-ascii?Q?aw3WwEJKiDeuNmiQDaXThPBwFsJpquB4hr/6XtgnkpIkvTeeXwvaJTdOe/A8?=
 =?us-ascii?Q?5NrtFbtqYzKDKzGn0loMzbIoA6B2gcC8BnUxXBICjdw6ckFEijgRI1mmk3QB?=
 =?us-ascii?Q?CHgnN05xbL0NP4b43dxIWDIs+ZZk48mafQ/nVojrDlNDcVun9KSZPIfCtwTz?=
 =?us-ascii?Q?4wMxTUBwyvnhleFvyDbEbCxFmErphKQ/CWi9M+Xi8e67/amOFzOn1yjuI8yT?=
 =?us-ascii?Q?g7+69rT/xyeJ6XZ30vDinDeX4kBdQw5x4mnBc/QFYniXI9Osp+JsG958t4gR?=
 =?us-ascii?Q?YWv7q+Sf5XHgOHXbBFi8+5L2GdPVd5/S0qItBgJBcoUD2AwBZO8Cm8RTWY5V?=
 =?us-ascii?Q?1PnR6hcUxba9D+pjWJLlAy4Q/7m604ntjul5+MfkFEq7v0cFb6s+LF8Wi8iH?=
 =?us-ascii?Q?CEYBy9XHjlcvVaez9KODyzKU38hOI0lGWC0Aawa6Snn15rhwHLCliWDs/KxT?=
 =?us-ascii?Q?nH+9Ej184AwQBqR6hhley4pUJ+a/E1CaaHDrbmBFIY9MJla1q7GICARq3xfV?=
 =?us-ascii?Q?7+aL4JMka4FesNaun8da4VAEOTC9A4oAgzfo4jE2Nuln8SknXNgpGIr06j4J?=
 =?us-ascii?Q?JcS3ZCUZsrDd2pbZoIcuQ6Z68qmmBBjAhhLgFgWlzwYyPfKgFmno687bhuxv?=
 =?us-ascii?Q?C7oy4PlKQ2ouDkdWHXGclWfOJJort+lXc4SBXpxx3u3rmePbOMHwooBF6BJ4?=
 =?us-ascii?Q?az7/d4auhctv/IPASrWH8wXOcnE39HnIesRiClQJQ+YJOSfA+4+QwmgOCG8+?=
 =?us-ascii?Q?OkLL7HBLctlLA+PTJOqDZuSbg4vSpig=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B6pZ/ZybAiz0bqP8wd12kZZOeUGEnn1rOnCM26fS3gyu0Ysx1sG/5Az2aRwQlLd5pPOVV8nOlWC5oP3scCnYPqH5bhl4LJwAGfTDJfcn1BH7KVuXCj4pXjsif3mqehNEcMMBoo9G9l0S1VvsWQyAP0G6Zxybi/Lq4m2ACs6AM2PkAMTqqZAWvlpdcXbnjCfnICbrS9EPdn1dsv2lSCKhZRg841f8k9OEdanRmdPa6O0tdMHx7keaR7KIxW9VDup6cmyaBlYVzlV+yc5pA3i+RvIqjoYBnMpMUUw+MgeUv3EbbqfyI+aQSl60JKUZI5KgV0cocs74GdD1JHfqApq9Fw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc3310a-2c26-45f5-ca7c-08debdb1dd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:15.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 282tINpoOymxrHHK0CIUtpIDLV2dBTyKqzldhGEbDVBPHljzGco8DZQFPjTCj0aT7XzOd6moJvEpgJEqgfHnp6wbirzdhdz3zrOhWl8C60E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MawIkzTchFV9PnQitH4Ht6dx5GbhespCHTNIE8icVpo_1780080080
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim]
X-Rspamd-Queue-Id: 6BE4F60796E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding loopback support for S2500 internal PHY to help running
loopback test through ethtool

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/phy/ncn26000.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index c3a34b2c524d..f7ece92a8fab 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -168,6 +168,17 @@ static int ncn26000_config_intr(struct phy_device *phy=
dev)
 =09return 0;
 }
=20
+static int ncn26000_loopback(struct phy_device *phydev, bool enable,
+=09=09=09     int speed)
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
 =09=09PHY_ID_MATCH_MODEL(PHY_ID_S2500),
@@ -178,6 +189,7 @@ static struct phy_driver ncn26000_driver[] =3D {
 =09=09.config_aneg           =3D ncn26000_config_aneg,
 =09=09.read_status           =3D ncn26000_read_status,
 =09=09.handle_interrupt      =3D ncn26000_handle_interrupt,
+=09=09.set_loopback          =3D ncn26000_loopback,
 =09=09.set_plca_cfg          =3D ncn26000_c45_plca_set_cfg,
 =09=09.get_plca_cfg          =3D genphy_c45_plca_get_cfg,
 =09=09.get_plca_status       =3D genphy_c45_plca_get_status,
--=20
2.43.0


