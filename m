Return-Path: <netdev+bounces-293204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEDNHzXjGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:04:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E36607A8C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93B16315AEC0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB1451052;
	Fri, 29 May 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="TFWwStxz"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CF450903
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080080; cv=none; b=Q6Bp8FQMdTUW1QNlAE0hRuUOiIpkh7AfDJ1cOA8f6xXVtc94WmwDFacIEx4NCGrVM6R5Q6IXhd/yMO6njmbxqfs901vvgIbfu8JR8OrntwRSJp22VZsyHAkmBrGXKv4EA4sQRuUmw9sLlJkFyK6CFAvbYIjXIVXJT72COgAvM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080080; c=relaxed/simple;
	bh=s9O5B9RxfhL56tRM8y5A+KBVs0unmz/Pf6oKae8mpR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVI1k1inA3tU6OjZukgAJg/wHZQIF1cDurdFkSr9xaHwZ0oWX+nMLZRrZLJzf8iCft+Oa1jeqjHxx33tAAokPseu81JflGlLyeaEq4Dsdk5pUh8xF/Zz2PaVzwEZfrDUjLHfqX77674Xkpz58bPF1Fmasl5chPsSVd6w8lfTQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=TFWwStxz; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kMqDL6Nq35AAHOy+qFRtBcV6BBWkNOhiBuaZBKIth0k=;
	b=TFWwStxzjz8RgNEC35izzizHMMgx/5+3ynGwHiqyoDGG9RpRGhFL4oT39zxQ9P32ZdJxJP
	r3eM2rQGBEJZS5LvkfU/6Z7Mbobmc3hK9yaWe/PGYjyAlEb3GYxrwZ+C9WxL6xs068Rj7z
	n1r674D2D04+k3KPYVAulKe2eaX7L77Uw+AGbphKPO2SylUawSsxdJb3L1kuogMjugA/qp
	oyeAcJTRx4kZg4P69ysNOFMpyJZi09xEvPZPCgwq8xFNLBPctS3H2hZ3zqHbEElVWwBGPp
	x2EJWy41Mvvwk4+1TTX17tFfDTh4PFBIFO9lq4AbLIy0WO+KgDK3OY12s4raWA==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-70-yzsEOZGTOIGZZi4nciXO3Q-1; Fri,
 29 May 2026 11:41:11 -0700
X-MC-Unique: yzsEOZGTOIGZZi4nciXO3Q-1
X-Mimecast-MFC-AGG-ID: yzsEOZGTOIGZZi4nciXO3Q_1780080068
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:06 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:06 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 09/14] net: phy: ncn26000: Support for onsemi's
 S2500 internal phy
Thread-Topic: [PATCH net-next v3 09/14] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
Thread-Index: AdzvmTLeNxLBCslDTBWCev4jx2a2Mg==
Date: Fri, 29 May 2026 18:41:06 +0000
Message-ID: <CY8PR02MB92496757556AC350E712191883162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: e6fde0cb-dc7d-430e-4f20-08debdb1d804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|921020|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: nafJr7aQpn7WhxwcGQZMaaQoWYO30p5jPb3rNu/7mG+Qtew3qY6lezbVMDhPXGNskAWNqFPXDUrV46X/UugNUG3tyTLLtivMuNanAuY4fc/LYUUfwlYVZHIPzI76zFNMpxD3hS29dHsAJ1wQv64DOGmV977+U2midN3uU1NemRKPleWQ6Eb+VIvOv8kmurrwNoY6O+qD5R7pAZeGUBGnYQ+DaxQTyrZw+WHKo+aKyzPbM/oAwot4YzK88/KvAzpSpE6b8ZfI2weNPDgFWtkLRtrCv/AvvuXSvEZDZB3YXybDskJT0T1Un3bAel/oTwDvLw0mFEKdDkOa9/vQPuCZuga5NiV2smTw3E/0cWMkNjXkGZgKZLBBZCQzCptJjtEoG15U6tIHjYyYpBwN4vkHmar/Cprg7GXt8h1g/pB4k/I+hjV8Nr+y0+6Ct50o4YvVP7BaJIgUSSHRpOQa46avBT46djN1E31D5zycG+/8WtJMTqzFFYDjKfHwcELaS7ZZdi3c4UtGxyTPIyLfyxBkCsx2eWRuln9D0JiPeMRcEpthe218qqcp3WG4cM+ZjcnhUzTp1OxOvjGI3hPnSVu3Yd1dvWuuKSZII50Spja3ILeBMgIgDtCqzX8eNfLIqaMqIPNNil2VqU2uczNPFSjX1nASmYLGWloaWGvadZWjp8QStMN+KJtWuh480qqJsesLblPlss/xvIZo/w5WdEFZYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otoEeBAI9dqhN9D44FgkkTt49wvOzr4KJTBS/Tnyo3P5S2NqJxk0tNadXIWL?=
 =?us-ascii?Q?X5raMcXt4TsnN6N8m2oWg2OeMwJAPa28lGw+UIQbPaYWl+AUcpkpDRxCo4+V?=
 =?us-ascii?Q?PE8YYCo9K6/zpLvKNsQNma88wzE6QfikIQ5TEs/G1KOg7oHIjkQ1/JXgPAHF?=
 =?us-ascii?Q?pfhCO3uU2s3nBTvtply0RwZxJCKPOcH074a7lEuNZadlipDoSL0MYkjrwaiA?=
 =?us-ascii?Q?63llcmU8gOJ1DH6SeUMvG/bb/vaVNE5cRXVy8/xSt0gIxI6TRh4wJQfasQ5J?=
 =?us-ascii?Q?TLzLtO2PVwypwNpt1ARtK6Iuhx+LHDqiAH25tkCylE4/ujILgTNkdh++ONz2?=
 =?us-ascii?Q?04Of7y7ActP3obAsicqRS7cYOIWTS8WKiPxMOQqrWZ/a2INGdgDkxifY01d2?=
 =?us-ascii?Q?6E5MY0CmO5Hi1L0+Yvqq0xB3HZcF1+ELEKoELrxo5k+RN9UAi9WU+wUEaH5e?=
 =?us-ascii?Q?z2FztfRcJhAqXCzoTdB0Mu1LfXuz4goSwELUTtaq7YmPNxLzgJDG4GrMTVvn?=
 =?us-ascii?Q?mDUY3zKp8q0FT7h8YKa3IVrsJ3Twm1mk6iGq6C3jOsL21EGJmBxjEoj9+UUG?=
 =?us-ascii?Q?DpXuLwTQHV6seLS6n1855YHLOqlUuppH4aYsljlg2yL/EHgbIcuZbRSUu8g7?=
 =?us-ascii?Q?Jl3yU07d7CF9XtH7CGliZY5tu/khA1X5IY2Dkf8i9BdUjVgX6PhmMP0qUzc+?=
 =?us-ascii?Q?0WXOyZBZdubqdsgAtOFdS1UvANOGQBhLnNRwVbWXUR+viQlKk5Rxm9VewrBJ?=
 =?us-ascii?Q?UOTqJZJQv5tcp14qbmYQDCU49b35aLTPmUwDa3A1AjJA6Z5CEzOa3/pR5ct0?=
 =?us-ascii?Q?6YWaYHoYRIcIDa2Ilz8apOAtOEYmaNwtXIzLqbisSJhzU8gXtnGZRCIGAkuX?=
 =?us-ascii?Q?82NEjx4MfwWXpvM/IrxiZnEOp6ZXVUYH68xGBNwouGxNAbL0qsnNRTclFAHv?=
 =?us-ascii?Q?P+SLw19MNM16MpCB7Rh3+JF6n+oliMVxC3u/ruqr875d0caVvFVjzdbDLhVi?=
 =?us-ascii?Q?uDgMTMV5yZg2oQl5GxSKCyZaVd9HXTlI/8v262KJEyo5MFkiEFxDWHXTrTrR?=
 =?us-ascii?Q?7ACfUgy2FUO4ytF3X+PE6ImKEpbqGvoq4GnRqFB376R3+tXBtk7GHf5sBG74?=
 =?us-ascii?Q?fzXb5ksbI2K1bzxg3pNvZtzkpiiRzoNlj5tthRytAdbgLkKlojIxfoPtbrao?=
 =?us-ascii?Q?w6kUtGwOmtYEePqfZ9Jf+RYzOZ8ZvPevS/+vHfd7h5oChZMdAd5luH1tOKUZ?=
 =?us-ascii?Q?Xqohpx0PBWZAmRfqTNlgxh01eMM02ZoQbt89U4QHZvz1dmQ+3HRsL+WYOMTu?=
 =?us-ascii?Q?XV84nuqPatuWmQVAucSHAnMfopQrZ3D1No/qnIxjgF6bar7hcjfX5sjkcRrU?=
 =?us-ascii?Q?ttCz7Z5vGrV+pj3l/n7ltDJ0ZhxaKm8eIDTVbzpNjeI8tED9uplpcU1lKtGw?=
 =?us-ascii?Q?LmLMFQBupAqg5HdwlbGlhUFwu16KR0+Dj92ng43f5sQZeSL+Li+rl2bVAb8P?=
 =?us-ascii?Q?KX1C0F3x6foOND38H8pA2XT5sZ07jyzqaaK4b+atzVBiFeFr0Pr6GbokIsYb?=
 =?us-ascii?Q?/+tfZsD7LXagNIohscK37P4OU07mt7iUzQNyCwKXlxi78Vfqk92kOFWMg2b9?=
 =?us-ascii?Q?WzO/CnLQAHII7r3gKLpn7jlCigBNIZeExOcSgUuJxt2xjD5DraT2xNy7EKA9?=
 =?us-ascii?Q?rWEZavJY/AdQ+uIRexFSTGkqOfUCSPSF2Xx3QD/XWx0XCHAUeNXbArz0s3IV?=
 =?us-ascii?Q?DYF3IV1zmA=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bLiXIvDTfBkfAngpK9pxWrd7LUU931fAnn/FytVD9u2+9G3AETJYkuUgZcz3mUgUEwBCSIHml0L8X6Vh+rhMH9BAbgkPK7hYYPKZBxQiVx1brpAGqEyi5axqSkD2n54YJi0e/hKhCmkxIBNHXXHyrLHVjgBeo8L4hJ43qjqxgnlGRvGx3Fl50QApg8FCDXqFswaXHFS7k7Bn3W61G1NE3RvEC967YUnsIMolh10166PqdP7RQjYH+l58GnD3TDlria3deZ4eR2dXFepZ6oF2cN6vFNPdLzcUV+IGLXZs9jatIgjS6lIIseGcD1ZJsIz+qsThE9xl/RUThns28Xm6fQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fde0cb-dc7d-430e-4f20-08debdb1d804
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:06.3913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nn88mFqbFfhpWN8a0Rf0OT0D2QN7PXFLVdSG41zPr0RS3ftWGXX/tbzpYEBK9zxWUDDxeJvUMQy0bk3dxpvzvTWPsNGGhnQT8R03TnIIrsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NjXHU6SWpqt3wuFNoGLW8KvAstadFiMA_qar0Rmw-94_1780080068
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
	TAGGED_FROM(0.00)[bounces-293204-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:url,onsemi.com:email,onsemi.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 28E36607A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding support for internal PHY of the integrated
media access controller S2500. PLCA tx opportunity timer's
default value is correct in this device, compared to
NCN26000.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                |  3 ++-
 drivers/net/phy/ncn26000.c | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37a9e45e01f4..76c823860111 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19968,7 +19968,8 @@ S:=09Maintained
 F:=09arch/mips/boot/dts/ralink/omega2p.dts
=20
 ONSEMI ETHERNET PHY DRIVERS
-M:=09Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
+M:=09Piergiorgio Beruto <pier.beruto@onsemi.com>
+M:=09Selva Rajagopal <selvamani.rajagopal@onsemi.com>
 L:=09netdev@vger.kernel.org
 S:=09Supported
 W:=09http://www.onsemi.com
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index cabdd83c614f..2c8601c3f94a 100644
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
@@ -14,6 +14,7 @@
=20
 #include "mdio-open-alliance.h"
=20
+#define PHY_ID_S2500=09=09=090x180FF411
 #define PHY_ID_NCN26000=09=09=090x180FF5A1
=20
 #define NCN26000_REG_IRQ_CTL            16
@@ -37,13 +38,18 @@
=20
 static int ncn26000_config_init(struct phy_device *phydev)
 {
+=09int ret =3D 0;
+
 =09/* HW bug workaround: the default value of the PLCA TO_TIMER should be
 =09 * 32, where the current version of NCN26000 reports 24. This will be
 =09 * fixed in future PHY versions. For the time being, we force the
 =09 * correct default here.
 =09 */
-=09return phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR,
-=09=09=09     TO_TMR_DEFAULT);
+=09if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_NCN26000))
+=09=09ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND2,
+=09=09=09=09    MDIO_OATC14_PLCA_TOTMR,
+=09=09=09=09    TO_TMR_DEFAULT);
+=09return ret;
 }
=20
 static int ncn26000_config_aneg(struct phy_device *phydev)
@@ -117,8 +123,8 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy=
_device *phydev)
=20
 static int ncn26000_config_intr(struct phy_device *phydev)
 {
-=09int ret;
 =09u16 irqe;
+=09int ret;
=20
 =09if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
 =09=09// acknowledge IRQs
@@ -141,6 +147,26 @@ static int ncn26000_config_intr(struct phy_device *phy=
dev)
 }
=20
 static struct phy_driver ncn26000_driver[] =3D {
+=09{
+=09=09PHY_ID_MATCH_MODEL(PHY_ID_S2500),
+=09=09.name                  =3D "S2500",
+=09=09.features              =3D PHY_BASIC_T1S_P2MP_FEATURES,
+=09=09.config_init           =3D ncn26000_config_init,
+=09=09.config_intr           =3D ncn26000_config_intr,
+=09=09.config_aneg           =3D ncn26000_config_aneg,
+=09=09.read_status           =3D ncn26000_read_status,
+=09=09.handle_interrupt      =3D ncn26000_handle_interrupt,
+=09=09.set_plca_cfg          =3D genphy_c45_plca_set_cfg,
+=09=09.get_plca_cfg          =3D genphy_c45_plca_get_cfg,
+=09=09.get_plca_status       =3D genphy_c45_plca_get_status,
+=09=09.soft_reset            =3D genphy_soft_reset,
+=09=09.get_sqi               =3D genphy_c45_oatc14_get_sqi,
+=09=09.get_sqi_max           =3D genphy_c45_oatc14_get_sqi_max,
+=09=09.read_mmd              =3D genphy_phy_read_mmd,
+=09=09.write_mmd             =3D genphy_phy_write_mmd,
+=09=09.cable_test_get_status =3D genphy_c45_oatc14_cable_test_get_status,
+=09=09.cable_test_start      =3D genphy_c45_oatc14_cable_test_start,
+=09},
 =09{
 =09=09PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
 =09=09.name=09=09=09=3D "NCN26000",
@@ -161,11 +187,13 @@ module_phy_driver(ncn26000_driver);
=20
 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] =3D {
 =09{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+=09{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
 =09{ }
 };
=20
 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);
=20
-MODULE_AUTHOR("Piergiorgio Beruto");
+MODULE_AUTHOR("Piergiorgio Beruto <pier.beruto@onsemi.com>");
+MODULE_AUTHOR("Selva Rajagopal <selvamani.rajagopal@onsemi.com>");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");
--=20
2.43.0


