Return-Path: <netdev+bounces-286778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKf1G9odAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:20:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B15143F4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 059E2306411A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE047B43F;
	Mon, 11 May 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="iu/VtBv4"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D136215D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523567; cv=none; b=uijASGtAR3nV++gMitLM+asQJ6jgwgCy1IzHewml/hmNiEL1wMHciJpbQUPt30StdOLii13/Vmp80nF/yAM9lAYL4gCT/u8kYgLZJAlc9m2PGb0Bep6VzLAQVRw/iFet7HGxSyuRABSIeE9w5Wuc86SZXE2XKBW5zygi732TO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523567; c=relaxed/simple;
	bh=dGSQeMsp/yQlwvIkTNu7BhwpyxdpwRG9+obVoCf6aIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hsF9b+s10i+Rzs1mrVo3H7Oi3nq4O+nZTPEValawbd2Rejj83Czgx4VRs/TpEmz1GFnHgpEYEf20XHZYDrkP4FhHP4qTPn9/KZHcg9i6y9zbw0bpz9od4bOnFwvz5Pdv60YEyTAqv8MEeK8REPKyS6Ysy1hDw6oDr+DOkTEJlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=iu/VtBv4; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+8+2XKI137u9VaohWBl+Iw6mN5Ga8pyiH85ogw6ipy4=;
	b=iu/VtBv4d7Xi4LhpPjLttwG+vgklVcb00wk2advxaWw5rr0k0p0a+dvDKF1eYCZIDCe7XZ
	xcDEk/4HOeqXG3xzfi/BiCyFO0twZFuJlrdnLSI1L4Ebg1keiLwOTvNcux7Ytfpqx5nasm
	scaQ19K3muPu7j+Tpb1CEse3TXOUI9jBh7cLDn7SmM85M9dUT1fYWUt7IWXCKbkLf3vJaO
	1MENTBjgD1OeH1msAudiqL7PNJs8ar450C5tr+v9+blsmjngIolYHphmNskHGKHpC4WHet
	LmN8XVgTZtjBrIM7O4BWM6DxyhCFwSeFozcI9WVw0ihFgWkqtLb682RwITo9wg==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-19-NrfsL_VGPKKBtL_OHiXQmg-1; Mon,
 11 May 2026 11:19:14 -0700
X-MC-Unique: NrfsL_VGPKKBtL_OHiXQmg-1
X-Mimecast-MFC-AGG-ID: NrfsL_VGPKKBtL_OHiXQmg_1778523550
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:04 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:04 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 2/9] net: phy: ncn26000: bugfixes/improvements to
 NCN26000 PHY driver
Thread-Topic: [PATCH net-next v2 2/9] net: phy: ncn26000:
 bugfixes/improvements to NCN26000 PHY driver
Thread-Index: AdzhcIF3uX/h0mEjRnei8NRSGJo2EQ==
Date: Mon, 11 May 2026 18:19:04 +0000
Message-ID: <CY8PR02MB9249D9892B00F7B7C10EEF0883382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: e9dc4d19-63ae-4d16-a377-08deaf89c8cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|921020|38070700021|11063799003
x-microsoft-antispam-message-info: twSXb6FXCjnFxknd3Bi4XDyfHol8HTAu50amxQaJZ92+MazSy19ElgTKDmpyyfyIiCrNQd4qCaXi86RlEh+6FKe1LoGsbC40z/8YrXIaJJeqTDMo55O63EQknDKp2lK+dtFjiltX35yGRcNq87eU+FOnjmgbvIYX1Kkex8XokSOfVRDttPQ+PopIe8meSbY/t4a4mcaTHzd01kcPiA/DBJ1v+6n9jaPYk3TV06S8WiHxbBXJBBnBBJIzs6uFI6hCOTaxqebm33EQiVw99XT9vTKdmiytyRj3Z11M0XlBiCZdmucxo1vaKPFDJSwWIWD+sjTdvoV1c3RoR0PNmBX/jUrHfswf0zKoewjRFdR7edesc+t33V5laKEcjtEzVicW+4shGsGQ4et5x/gLvgGJEWEXX0xj7mLb4D0kISgn3xIGxNvDXbZTmuzOk4rtjl8wzPQF9O0+lxyeEnSflnl4Bkt9JmM9ugshIfswmkbxilcuA+ODsNPWaCiOhAD892ipZby0wYhVVpNvqz+JB69MULal3cL2NAeZHqBztzuYmvSo1js/i3YfzUN3vFWD8QB0UMN18ou8D4sdC2/aoOncPLiUBnxRirr06u4ADRxeRFhvuJkzyluKBSE/7TkJ5jL/isqvNc9R77tJ0P7/9ZdVHeTEAADwTIGGFeeqqqaOprWT9OP0feqgvPGvecSLldnu1GI6mlTibZuUA6V7pQCKtUjJDJPwgQdG51EDhYjpsmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(921020)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZ7Giz66fHLltAfW/aMbY66xjT7oPa4qL+mMcNxqtSgvXanNh6XbxgGg8YSc?=
 =?us-ascii?Q?hAqwpOrbRnSw+aLyj9227nAGAMMvbX6a+LUTt5DmJRVuI9gjb3aEfZaEQIHa?=
 =?us-ascii?Q?Mp7gFWrtHGXbZ2vjiRjhroAsuDPRb35oLvmStPV7b4uaOjPHYQHDbOqDZptH?=
 =?us-ascii?Q?7wY9gn7HnuwJufLcs2b/a7uYe6vJk+fMH4ltV1M4ISi10DvNA5gTIKFSMQQy?=
 =?us-ascii?Q?2jGeA4zDNHf5L+s8xKi12b3tZ8VGyDf4w2uKTUIw4P0XuwIiCGxcL02lAWnO?=
 =?us-ascii?Q?n/HY5dfcyPC/cFZ3630kv2uOrAkaNnSUD+n/nq3KpxgjqlF1R+oxgzbsL8B7?=
 =?us-ascii?Q?rmgPldYRKt3ryw5cdmu9HFSIw7LGS/gODcor5dt6jyUbLrs8O0WxpbJso/Ap?=
 =?us-ascii?Q?/Nle61OW+JK8U5YZXUUB5uxQjD/P6CBuPXx4CVHfaFFsXNmh3PaXWBb2/xQv?=
 =?us-ascii?Q?2oRUdb6sjRs5qH4reY1eRCMfjuKVe90TuXHR4IQH0QLZjJvPR5pV8TYsqnOy?=
 =?us-ascii?Q?CdV4bpSvjDAb5GzdCeK97dqYU4iF0i/uVYLRqZDLETJJC4uCVNhkCZhGOZHe?=
 =?us-ascii?Q?m/oLpL6Q+Rd3rVCblnrMNRL/vlgB2EFbUnaOsBJQVuhMZzINoTZ+JiB4YWNL?=
 =?us-ascii?Q?ron1tyeOoVEjhlhi8OQgyMYC/MML8QuxHb88dcwHQJTCra7pkqqgui8w8SqT?=
 =?us-ascii?Q?dRrI3J+/xf9fPgZq4NNmTBOzUSNrd84QwKqPVg1RDyCV9g/pHwrleT8rgio9?=
 =?us-ascii?Q?DNlUiV9i4DmkUTgVdlLLz6lK1/W0cjVRjESzYDAxNBzxBRR50Y0s8kfeqKZ0?=
 =?us-ascii?Q?8GmO4JDNSUGs5V/yHlYY8tNaO3pc8YuH3nresD3Dx+r+PFZKnNInU+pizTEi?=
 =?us-ascii?Q?+euQLTmbS9319kwuDZuc8iOib/jn/xoneKRR8/Pr0LrUH+xKhI3JHWOZVEp3?=
 =?us-ascii?Q?1+tqgETCI7GjdbkKqEJWIiFk0wnM8ntCbbncoOY1b5JsCAic/lABk0idWYEK?=
 =?us-ascii?Q?2qUWEXoM92+1EgpKTit3GX59i5F/Cl1r5JRc38CKSRRPNZn/AZRRzqM2XNEi?=
 =?us-ascii?Q?40tm9Xwc/vLoefEkliJh2Gi/fyZTjrlTlfi98m3RCuyZa1V0tjWu7GCilOnO?=
 =?us-ascii?Q?vYXUAOHjiOr48WXkClzT7jR5iS/HZKK3yTYiGqSo8MuEs1YqDWc6xq/MwbTj?=
 =?us-ascii?Q?cGh+a4syThI2lB7pbWP2oEyPAHL6kpMf9F3z40thb5XElZ6Lvtan9h5biYOh?=
 =?us-ascii?Q?TiwcTgjFPVcZqSuWp65q9FpyTFkNQmH45Q/deFt/jiXWvlOeL4hoMRk/DrF8?=
 =?us-ascii?Q?7A1ZYFNr77h/WR6B5pzaBYjSLuoEfVjr80a3KPmZuOlUnyCK7gAXBFFFFYnM?=
 =?us-ascii?Q?9vzi6MVkscVm4jPFLnLF8UciFTgbe9L6jwX2MJDy4FfsGc5DTslfdxnUUgLf?=
 =?us-ascii?Q?E3hFXoze4zmFF3OmX6t4jpZcHEyAOUozZdGZzpJskyQs7J1A+i5sh8ba2BkI?=
 =?us-ascii?Q?p6FioCEil+KwVJh9ZfP2tKgVKDjB6F83A73FOpiPdABlIRGT4p3FWJ8tle40?=
 =?us-ascii?Q?rkHIoYMf+OIzpC+oWLiilN1BwyyoGOLQBf8W4s/AeNqzv4CEgg2jZ4HVI78l?=
 =?us-ascii?Q?o3i9MZY7OapLupt06RHp0UgRlBzIJF0EeHOCNgfrZVSn6i0SozcJXDED91GS?=
 =?us-ascii?Q?nJjDC1OqvL9AhngMKr2P7i7qWwIc+gNOut1LtqpWKsh7bcoHMO0ko0YNg8kV?=
 =?us-ascii?Q?66jH3R4Rsh8X2bpvwl0ufOkhcDo9SIw=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vsfMvi3baHzMvfbq6CfnWxOh4Rp9TMRipJs4vXVRiYqPW2CRhRmc3AmxlVOahu2YmYdLaduqPoGjf9T/b47FgUmz6CThcNaBSj/1zD2Xgyj4vH30a63k/JJ9yBAl2f5Oo+DZ4p2LG6vni2VXGi6nn37k5XIp67HLLDUqjUXY+cG2hzgMJlAUJN/etjR8HdLDqd4+fAHNigpsNP5wRzLttjQscWduSZVPkirbaPWRLCFNnbbsw7PYdIy7hm2mw1CNTH2gDBBF2GGQ6TkMl4OZ9AB+n2Sp1YJQJdLVKQqVe3xZiK4YqzooFig+G7XyLpl1KOd1ByMO31VbHFZT3vALng==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc4d19-63ae-4d16-a377-08deaf89c8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:04.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+ly7GPMs3D5cvx4bjjcuJfBF7lZjLyJyLldUKU5wkm8bg4J4FrXgcO6YHouRj38LTW86POnM0LO6I8UHvEBUOXXDB1/HnWap8TgKvdu8dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: caYUAfat29Vk2XyyeoK1gJnDEUOKl2rEOnQVXsbI5D0_1778523550
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D82B15143F4
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
	TAGGED_FROM(0.00)[bounces-286778-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:email,onsemi.com:url,onsemi.com:dkim]
X-Rspamd-Action: no action

Proprietary, noise immunity bit is set when PLCA is enabled
Link status bit was wrong. Fixed now
MAINTAINER's new email ID updated

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                |  3 ++-
 drivers/net/phy/ncn26000.c | 52 +++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbbbde6b..6ed1e1e5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19940,7 +19940,8 @@ S:=09Maintained
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
index cabdd83c6..68b0e4647 100644
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
@@ -35,6 +35,10 @@
=20
 #define TO_TMR_DEFAULT=09=09=0932
=20
+#define NCN26000_REG_PHYCFG1=09=090x8001
+#define NCN26000_PHYCFG1_ENI=09=09BIT(7)
+#define NCN26000_PHYCFG1_ENI_MASK=09BIT(7)
+
 static int ncn26000_config_init(struct phy_device *phydev)
 {
 =09/* HW bug workaround: the default value of the PLCA TO_TIMER should be
@@ -100,6 +104,24 @@ static int ncn26000_read_status(struct phy_device *phy=
dev)
 =09return 0;
 }
=20
+/* Intercept PLCA enable/disable request to
+ * set the proprietary, ENI mode accordingly
+ */
+static int ncn26000_plca_set_cfg(struct phy_device *phydev,
+=09=09=09=09 const struct phy_plca_cfg *plca_cfg)
+{
+=09int ret =3D genphy_c45_plca_set_cfg(phydev, plca_cfg);
+=09u16 eni_cfg =3D 0;
+
+=09if (ret || plca_cfg->enabled < 0)
+=09=09return ret;
+
+=09eni_cfg =3D (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
+=09return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+=09=09=09      NCN26000_REG_PHYCFG1,
+=09=09=09      NCN26000_PHYCFG1_ENI_MASK, eni_cfg);
+}
+
 static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 {
 =09int ret;
@@ -108,7 +130,7 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy=
_device *phydev)
 =09ret =3D phy_read(phydev, NCN26000_REG_IRQ_STATUS);
=20
 =09// check only link status changes
-=09if (ret < 0 || (ret & NCN26000_REG_IRQ_STATUS) =3D=3D 0)
+=09if (ret < 0 || (ret & NCN26000_IRQ_LINKST_BIT) =3D=3D 0)
 =09=09return IRQ_NONE;
=20
 =09phy_trigger_machine(phydev);
@@ -117,8 +139,8 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy=
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
@@ -143,17 +165,17 @@ static int ncn26000_config_intr(struct phy_device *ph=
ydev)
 static struct phy_driver ncn26000_driver[] =3D {
 =09{
 =09=09PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
-=09=09.name=09=09=09=3D "NCN26000",
-=09=09.features=09=09=3D PHY_BASIC_T1S_P2MP_FEATURES,
-=09=09.config_init            =3D ncn26000_config_init,
-=09=09.config_intr            =3D ncn26000_config_intr,
-=09=09.config_aneg=09=09=3D ncn26000_config_aneg,
-=09=09.read_status=09=09=3D ncn26000_read_status,
-=09=09.handle_interrupt       =3D ncn26000_handle_interrupt,
-=09=09.get_plca_cfg=09=09=3D genphy_c45_plca_get_cfg,
-=09=09.set_plca_cfg=09=09=3D genphy_c45_plca_set_cfg,
-=09=09.get_plca_status=09=3D genphy_c45_plca_get_status,
-=09=09.soft_reset             =3D genphy_soft_reset,
+=09=09.name                  =3D "NCN26000",
+=09=09.features              =3D PHY_BASIC_T1S_P2MP_FEATURES,
+=09=09.config_init           =3D ncn26000_config_init,
+=09=09.config_intr           =3D ncn26000_config_intr,
+=09=09.config_aneg           =3D ncn26000_config_aneg,
+=09=09.read_status           =3D ncn26000_read_status,
+=09=09.handle_interrupt      =3D ncn26000_handle_interrupt,
+=09=09.get_plca_cfg          =3D genphy_c45_plca_get_cfg,
+=09=09.set_plca_cfg          =3D ncn26000_plca_set_cfg,
+=09=09.get_plca_status       =3D genphy_c45_plca_get_status,
+=09=09.soft_reset            =3D genphy_soft_reset,
 =09},
 };
=20
@@ -166,6 +188,6 @@ static const struct mdio_device_id __maybe_unused ncn26=
000_tbl[] =3D {
=20
 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);
=20
-MODULE_AUTHOR("Piergiorgio Beruto");
+MODULE_AUTHOR("Piergiorgio Beruto <Pier.Beruto@onsemi.com>");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");
--=20
2.43.0


