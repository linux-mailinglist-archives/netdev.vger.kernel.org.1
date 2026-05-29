Return-Path: <netdev+bounces-293202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHKQGuThGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49344607976
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6767130A459D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B392426D03;
	Fri, 29 May 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="KYG1F00+"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271344A71B
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080022; cv=none; b=ZRIwHbWBySlfrprEOtQy+z+gWYjTEPm1leRWooJNmd9sldxY2434oBe8vOCnkqt1GS5gNOA88/khBKNbOkFg4lKdRDmC0V+jMic+s7N0K/KDw7yu/CmlMNndc8+IQyhUhth+IAcrRkkUW27ny6kryoHTkmWAQI/osZu1Mfi+mN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080022; c=relaxed/simple;
	bh=bvMPtqhR7cZVRmU7l4btK5R+eUlcDzKBv4gYItFmg5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3QaIEc7bGKFLinunCvhm3tWgSE5Vvx5/5Adb49gREfSw3nsn4ioJQffXkWJVin6kffMxdjR2F2Q4f0t/yjb/EuR/Ez5o2FJksa378FKa4t/obuVomzLaWQwEXfhJZx0JZME0xnPYhnaCovH8ukQMpeZUNKyS5bkmcktKZsrocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=KYG1F00+; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xKmhOOKewpjlwhHNSo4RVMQ+MvvnV74yC02sRqoRRss=;
	b=KYG1F00+U1o3a104/9W9FdkGQHG97Ldg/HOUOmCefc/oGIWDxwnfqOmJk0L3q1rlcUj3R3
	ZvryU8QyKQ73+33RSy0/eW4CNd1NRD0tOxVORb09O0UhbJLig9trhImY+TD1fMO/jcC6oK
	AXqIr0NCUpXz8yiMxkyqRqfZb4CDETikKxu1ygaLvwjTWrmyMRsR03oZYpdZoaha0AF13P
	omLAk3BJBDR1CloYCYRDp6o2yV5YiXI3+1bdvRNCOp+c6Yl8cp7UKgp8zB8bmUg9cdOFmt
	egtQsjcOIPt3JMcyqo3KbfN1GG7VoYPjZdUluvV2Ax0x5+guWgMu+EdCFxxBfA==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-61-3YeMvOMYN8-PHx_wShGUtQ-1; Fri,
 29 May 2026 11:40:15 -0700
X-MC-Unique: 3YeMvOMYN8-PHx_wShGUtQ-1
X-Mimecast-MFC-AGG-ID: 3YeMvOMYN8-PHx_wShGUtQ_1780080014
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:40:10 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:40:09 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 07/14] net: ethernet: oa_tc6: Support for vendor
 specific MMS
Thread-Topic: [PATCH net-next v3 07/14] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Thread-Index: AdzvmPeE1C2SWPKfQGiUdaQO3o8p1Q==
Date: Fri, 29 May 2026 18:40:09 +0000
Message-ID: <CY8PR02MB92492F5D3DB407A8392A36A783162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: 982409b3-0c4a-4916-e74a-08debdb1b656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: S5ea2dhdok1BjAIrUgMQvJ05NNFnebzaoTM0fKOmcRqjLyGXNFXKzHpKDJdlJz27z0dRWU5vZ2DJ6e0iCa/1dMIvSRSTc++93aM1h6RzTZRZ6D2GSAzYvJd4M/wko0t5pwhSUSMnkcSoEAsRmDeyDdPr3T82VsspxZRx/d/xjDsSXF4Kmfy+RpQm5LrEhJsLIB6yWQrwrGYYQHBQv1hg4bjxW3hud41y1BBEzPutMMMlEIVY9o7CN4+m89EZTuelEBiH17/NWNrpA7DfzzjxInU9jmH4/jJnLNkOth2nvx0k1BTKZdOL7REBvUVdqTX7ls5h7dq6UllfT/wGyBsyHzrX1vsLbzvYbhXDDNybzqqPeT0YuExl0qwL0QhATnnyoUm1YaQeuw+rDl2lhpvbG/wau5W/FvnfH7RaLRTI6P/DTx/DQ/aD7AIj4PmEvk0nTiafVTp/EDSeIEKCKz4/eJneXwUed5Yvnv7OKIXDaVGcMfGRsAQi9jVCyiinpQnGLyYFnyAUgJ5Du/0efN/lYRfUGcSRGcvj3faBYAcUdHef+zKs5+2LjVcShleU2rwjBto/LVyXXyPn65Fr7qXnE/gaQEC8xSjViMrjJuD3iDMl4bp7F/xwQuAc2EByq1hLh8HCpj6PzLBp19hXoJc+jt6/tpTUgkieB43684Q5Gfr7ENs3b7ZBtYLiZkDAx7t5nPBwSjDdJu93g3Q5htIWsfqR0zpOlblhIxevfhg/aBELKfBeHOCax5ARL5yLdG0C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rPnI4Dts3gMgAy0zpjd5H/MRevhOSm4btdOkyJUeoMo1RB3/pugB2zjgkKzK?=
 =?us-ascii?Q?Tw+lWcfHiO3Np174PF2g52/axid9bbmsuclCsAXoACN702H1klbEndauTkEg?=
 =?us-ascii?Q?UtKq1+3Yh2IcSgP0Cwa/OFD3KuZCyYRCYfiCq3a1u1Xje1Uu1BOdXh01Navh?=
 =?us-ascii?Q?tN3xSfF0UV8Oz/YPIy6vvfVetdTK62V35AbOjmZ9SQu33e/qzmIpIEzZFxJH?=
 =?us-ascii?Q?bvSs4Dm+ksfmXAeP682A9hDUpyAiUQBkyIBKtObPaMP1Q8/nNTiIguQr/cVG?=
 =?us-ascii?Q?wYcDVn1IYKDXf3Au0BMSzLQqgrf8Lie9ZEzzirUzPMPcuocZarbOE9hajYrh?=
 =?us-ascii?Q?3sD1K5XKYUHLTG52irSCu5rH9qyONypo57b7rhoJcA4+X2g76Y7u5648SJMh?=
 =?us-ascii?Q?FJJ226bpL5QfsEBvJrL/TporTMDiYXcNR318lNtPrLnw1dWIhXOg/fwZlmYn?=
 =?us-ascii?Q?c1mUD+DEqlNrgAIWxxfyDmqLTGYHOmUbpyJ7mWIMQ8NWHoP7aXRK54yoJMSw?=
 =?us-ascii?Q?BtxGlwqrnTGvg4d/BYJCrQfi1eikYyXHBQZKuQ6MyurNUEOKhDuZtgVQNzRx?=
 =?us-ascii?Q?z2bEQLcxDm4GgOszritXC8mVQzkyQr6wOslZUylyp1VWQynZKrxVSC5EIPNx?=
 =?us-ascii?Q?B5nmhAONk8XoWHOuGoRPiWhtbLHaES1+y0LOfCwlsG14onZH3HmC6lRGJ3vp?=
 =?us-ascii?Q?Bkfw/CvETiUgks/XELqTw36I5c5RwhNghtR+sPhlTOWAgDx9JSwKOyw0AR2y?=
 =?us-ascii?Q?wA10DpaRAwiWUyhI//XonFVYElZpzSuq7p/qUT9V3ucY6x01OaCKIq+lCfnf?=
 =?us-ascii?Q?A04Vm/w+P7pBMIFRDHh/8qk5pQX9VlX7xKF/4sBr7zvaUPY5yLBu2AQfuSNj?=
 =?us-ascii?Q?fTvcj2w87GaUxGvufLtpKG9ETi2Vg7WWDUlpFnFFBqOYD217+DCnXP7NuLdh?=
 =?us-ascii?Q?GCuf0yVxmivqszIQYE89g36qnwa8DvSCxyG/P25Dy8+w8Eq6F0oupAbv0kNi?=
 =?us-ascii?Q?35OJRm9yWii5szhy3/os4KyEcxQidilZxXFZ01lO7ugz0Ctggz/2IDQlyVY8?=
 =?us-ascii?Q?erkritBkfSd0q58opyedjcK8TdZR/erSDlWB+y1FkNBKnwQRM5F7igkxzwZT?=
 =?us-ascii?Q?bx/geUrpP1UvQtFVKALwxw7qtn6dAyAGDgLf7Zuk8Waz1AyJ7UGLRPK9ss4j?=
 =?us-ascii?Q?SaBGTfaOEkRID6mSv6Kp648zdT3Pta6Yyye0sDgl1Rlx+FXHOTibAxb525L4?=
 =?us-ascii?Q?0FK08jUsqHKDYMdyRTUFIwyejN0cXxfD2IAzVx3kVcFzifzrHI7LIAZzOOjG?=
 =?us-ascii?Q?SQZLn7pO1fOrb91Fz5OyIuV6xD91LXstNZ+4VXSuloSFVehoRFRDbPvEcCj2?=
 =?us-ascii?Q?UXx6eJdmKZXRwzPEU2X+lpIoP53IC3azSHEXFTQmRwGC0USBBmEM7CyQCPU+?=
 =?us-ascii?Q?xf/TLhwYHlTNwMfVK/rJ00ubkUxyqvsOSRo1B0JNseOeVfN1hoLF+mFhEfRZ?=
 =?us-ascii?Q?UXUANOfsCIJAMdPrvp5KeX/jRUe8zQFD2ErjA1VL1FMOKbjuVKDxNK9imrWU?=
 =?us-ascii?Q?l01LUEF0gxkFC+Lz4svpBPf3q8+MAVQUhhcqAoJHiCU6AVy7aq1q3RHOSZV0?=
 =?us-ascii?Q?hmys9sULxsTirclUl+/PwN8BXqO+xu6Y34IARwzeJEfE8DySHLifYvHFpQFW?=
 =?us-ascii?Q?IhNq/14dmttAxEmezK/92Y5MvYcudWOb4/iY4iu3Gc5P+tkslORttdX086Ui?=
 =?us-ascii?Q?x71rvha6hw=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IYKVAQz7Fpwh62tMX+ICpuWbFF4IKJOnurXc2bQEFeEEni+va7nSkhIFPqm5GOY++oqUZggStSacjsdhGMKr05rHhwdL0eetEdiCqAoTZqzyHl6CoyeLuEgu2Qq+TzmXxrGt8dz0iGW3aAjzp4fNaSm0yvnLjrhFa9Kg5nsfN8zo8AVKE4WEjIerFvN4JCDU0lKMDy/j8iVfpieOXe2LDU9ZY2YgjNHpjlGK3TsVitJNJhG+wjVc8jarumb49mOG45n6SxFTWfBkZkodJf05YNY3Lnm5d7NqDB17HQat9Lg0V81ij6J4l12UO4a+ObAPTgTsU+sf7yE0kjG7Qie0Aw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982409b3-0c4a-4916-e74a-08debdb1b656
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:40:09.8685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCKyhPCUhib0I0bLkUtjkIjDH0T3G9NKRhjToMPetXhNPJfQLLCpDQwQjEMkbCuCvtsOYtlp4yAD0lcsgWXI7maS7qulCfEmH3MxlSQOoTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mM5FLrqClKqzbz44kg-MTjWJRbPJMAxAMn3sXsG_cos_1780080014
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 49344607976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OPEN Alliance 10BASE-T1x Serial Interface specification, table 6
allows vendors to use any memory map select (MMS) value between
10 and 15. This new API interface enables vendor to map one of
thes MMS values to MDIO_MMD_VEND1.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c | 20 +++++++++++++++++---
 include/linux/oa_tc6.h               |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa=
_tc6/oa_tc6.c
index d49220b49852..d2b05f98765b 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -202,6 +202,17 @@ int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq,=
 int cmd)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_ioctl);
=20
+/**
+ * Add vendor specific MDIO_MMD to OA TC6 MMS mapper value.
+ * @tc6: oa_tc6 struct.
+ * @mms: vendor defined MMS value for VEND1 mdio device.
+ */
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
+{
+=09tc6->vend1_mms =3D mms;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_set_vend1_mms);
+
 static __be32 oa_tc6_prepare_ctrl_header(u32 addr, u8 length,
 =09=09=09=09=09 enum oa_tc6_register_op reg_op)
 {
@@ -455,7 +466,7 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, in=
t addr, int regnum,
 =09=09=09=09     val);
 }
=20
-static int oa_tc6_get_phy_c45_mms(int devnum)
+static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
 {
 =09switch (devnum) {
 =09case MDIO_MMD_PCS:
@@ -468,6 +479,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 =09=09return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
 =09case MDIO_MMD_POWER_UNIT:
 =09=09return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+=09case MDIO_MMD_VEND1:
+=09=09return tc6->vend1_mms;
 =09default:
 =09=09return -EOPNOTSUPP;
 =09}
@@ -480,7 +493,7 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus,=
 int addr, int devnum,
 =09u32 regval;
 =09int ret;
=20
-=09ret =3D oa_tc6_get_phy_c45_mms(devnum);
+=09ret =3D oa_tc6_get_phy_c45_mms(tc6, devnum);
 =09if (ret < 0)
 =09=09return ret;
=20
@@ -497,7 +510,7 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus=
, int addr, int devnum,
 =09struct oa_tc6 *tc6 =3D bus->priv;
 =09int ret;
=20
-=09ret =3D oa_tc6_get_phy_c45_mms(devnum);
+=09ret =3D oa_tc6_get_phy_c45_mms(tc6, devnum);
 =09if (ret < 0)
 =09=09return ret;
=20
@@ -1281,6 +1294,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, st=
ruct net_device *netdev)
 =09SET_NETDEV_DEV(netdev, &spi->dev);
 =09mutex_init(&tc6->spi_ctrl_lock);
 =09spin_lock_init(&tc6->tx_skb_lock);
+=09tc6->vend1_mms =3D -EOPNOTSUPP;
 =09tc6->tx_ts_idx =3D OA_TC6_TTSCA_REG_ID;
 =09INIT_LIST_HEAD(&tc6->tx_ts_skb_q);
=20
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index c1eb1350ff27..f33c9f8f24a0 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -45,5 +45,6 @@ void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
 =09=09=09 struct ethtool_ts_stats *ts_stats);
 int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
 =09=09=09struct kernel_hwtstamp_config *cfg);
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
 void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
 #endif /* _LINUX_OA_TC6_H */
--=20
2.43.0


