Return-Path: <netdev+bounces-286779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI5cD/kdAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:20:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F173651444D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A8A3078354
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2547CC91;
	Mon, 11 May 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Gvk6dyLI"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D247B437
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523572; cv=none; b=eopmVAYO7Qn7XvUQvbb/qkg+K7zhyoWWf/saYTnep5ftgk+3NTYIoMGApOAuqNj4egEfNreWOBwEw7seg4J9WBh5gMd5ywzakg8gDETpgpaPROFDVO5LQ0DdwbK+qhLwD8t8uH4xg2lLtdHWzxn7b4pvlzv7WVXi/4m5ojWN7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523572; c=relaxed/simple;
	bh=K90XDiluyHmjYahvaK0Npk+SidhMlYDq+TfKag4Y9Ww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aq+pD52UDDF2dFOmZucX0XRitRPnjTpOdB2QIeuVINsCScz0hxxTJdUurw0Lqj9OiIDmQWCtEP/ISOsN8JSlhpSsrWklLukf+X0n+r+NyypPtxl/ui0YTHPSGhOBN2IMAVe2mydVhni+9K+f3Hcan8gzUyi5/DCoUNyTEo6fOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Gvk6dyLI; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MCvpeIJUPPrF0pXh5XMWspXFfJzbKziiabwk3Tbj6S8=;
	b=Gvk6dyLI1JXpDOBqZv2+B9nBjg0Se/U+vB69YLlXSMb1tmLkU1s7Kw0rnnRIP/18CLAEG7
	cAW1H0CKnXaLMDY0RUZujnMaTOZJQ9MU5DjtfdavD3PWaPyqevJ3+FKZ1OT1974MTFXwff
	Rw47EOzVjS6QiybS8ebUiAf6+9YLQEkJpnjidOzg79lpRRUayQscD6Vau17jL3gUV68Z/1
	7wMAvJZ9Ugx7ttbDMVht7VXG0POAz4NoNtId/0+FEKtKbCc+3FXbDca0zhA5Muw0M/cWHA
	gBmv1bkPZCfW2QPty+NkLuebHm7vW+QIH6AXUzEVNTWbqrjexOzWYfTki06DQA==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-19-GXPNqwzuMpWlGCcxeBPPzg-3; Mon,
 11 May 2026 11:19:27 -0700
X-MC-Unique: GXPNqwzuMpWlGCcxeBPPzg-3
X-Mimecast-MFC-AGG-ID: GXPNqwzuMpWlGCcxeBPPzg_1778523562
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:18 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:18 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal phy
 for S2500
Thread-Topic: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Thread-Index: AdzhcNrMIlF1yVpURhiYlSATodqMaQ==
Date: Mon, 11 May 2026 18:19:18 +0000
Message-ID: <CY8PR02MB9249195FE5BD6D7FA31F4D1B83382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: ed154a58-82a5-49be-cc42-08deaf89d0ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|921020|38070700021|11063799003
x-microsoft-antispam-message-info: 5lNU/gnBdqcA7gSKphUXo4A2VBwJqSs33AUPwLWhdPQ16Wjgj13wUKgGxl3E1jZHHomin0qnC6STVQMGFQFjbOwKGHsbrSHRkB8HOHlBiZ5KRTkTitY0wJhda7wMnI4smCmEHCrlWgjSgQj3WkFR7L4qfx5+DPYlv1ByCQo+VP2eZqesr4NUPHQ643VLtlzLBkCLmmHr5JxVlFf5VMB1Ygxg66Ob9CYDDK45KxWmrbmzTQI3Ej10bdQlAmoAo8j/4LugstpOsFMyR4EKiR1xyQ+85LBlD2Wml0bA78gvP/t7wySi7RlmX4eUPdHzSjwcUW7vQFExjs+yepb2LeK0EUSTWF9FqtnHQ7G8h40KWZNAjTTQYCNGmz6aYu9V3HLu1WLYt8my+0q8rrtjrHUBunYvrGfNoQG4qd4Wojxi8umXqzdu9pv1ncIGJ8LLuY/2Pa4YC60FU7ntKPP3ngBApPhswP9674M0zZ9jGuOMG6MruvpT018s/lS76mbRBNJUydFY0N6kksrXZ4Q4ZBqYC0kM4YWCuxFd7XIkZ4N1EcHnDtWI1YHVypWfsgUjE6OwBLhfmlkkaYx+DrJpwR2c8JQU6BtUumJFNNWOBEHX9XoiNXqRRXZz8TRF6iDSafdcITVtPcgSA9oZOY0atAPuYLDCSpSqtfKyYP5cX2jBFr7+pUHDiobXWNkt6ppCX4S+DzVGougXHoA+DdTftEtEzkohb86XNjhcQzGfW0sfBtv9pdh1fXyQdTRmk7HLBV8Sb69u7kTvQBichgCMzdGaRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(921020)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LIurC7jURQL6yTkg2o3lRNmhPMYJzZGhsA6VjgOy9zTqo5AfbNy8SsEL+N2w?=
 =?us-ascii?Q?tc9HKj+s4CPrnmOtyV1GBEKFhtGAspG58HDhaTlsJ371sYdys5XgHVwTZ7T/?=
 =?us-ascii?Q?RKjYkcValT2HbUl6Ob6qJNgqfozZPOktAIf8VhWgzW9ZJangVT/LVLDdWFFT?=
 =?us-ascii?Q?5WXNapmtMFCGxAGtScAdoEWOUQnFTl8oxFSW2pyr6FHXiHlWO1D+7fh1+aw2?=
 =?us-ascii?Q?FnQh2hz3X6TfAB8bYm1CxYW+/oZW+HP0gBzQc9i2nO3SGHlq/5acomL3wWBg?=
 =?us-ascii?Q?NepwKvCWB42XLbcsLP75KAf8iV9qOSclDeX4vksog+m5vVnx2bDw9Rqc5Juq?=
 =?us-ascii?Q?NNIV+JCuGsC649QCY5UFlN1ctuYZ5H0qurjYybhSaryotRDenJ8RQBU06mB4?=
 =?us-ascii?Q?5pm/v1vYX7p0SoRgKhO6zApWNIcBTOqatjOTHS4oNHRBP3V48aLWzw/8Iera?=
 =?us-ascii?Q?NEeqotpaRMp/1rI1PZcv2erI9UyR/VeceSyEtAqTFHSFVdEFxDdXfRT6ncsX?=
 =?us-ascii?Q?2eP+Z9kNqPGBdfOyTvOLaDA4CVC+AsFswdjW8Qi/apFMejmcmRtOb7p/eI0e?=
 =?us-ascii?Q?G0vez2tFTh+yG91cTK9JZz1WYydxMi9FRfJjSu1knjigmyNtuGao9BM5e5Bi?=
 =?us-ascii?Q?g21+rvRGFhRaCSFlSDTq3bigGPL2hEkPf+4F6WF6NYYGT2u8qcaSjgo1LwKB?=
 =?us-ascii?Q?C+5wFFodBBJw0TCH285qudKpkhS+HfHwUxHGWB4ots2oPcrOTcTlVnv4bx7n?=
 =?us-ascii?Q?8hxUVK1cB3knu+RIeNNxmE6/+9A4xIRmRrzYKSDMS15lOBEAOiKgW0l/oPop?=
 =?us-ascii?Q?Z14HDMMSTAYRe/ZcjGEDaHsmU6DjWuR9VX7WqgJOGvl9Fxy6xunc+TH2cQqx?=
 =?us-ascii?Q?Z6rnR1UUP0+C/nPahDLsZMVRSV4oRqEBffvDovjrzWzbR2U1IvHpArKxb+Un?=
 =?us-ascii?Q?06rT0rswhxRzsHo1eC/jeajIaDLyo92hBxT4l3fcfTXuIb1al1p7DA2X8XcU?=
 =?us-ascii?Q?COVMdkLhd2zWLpfGD3M8+D17JJ0F8t+ArvYxTMA7bWRb6m9CFoPnTsDr1QC9?=
 =?us-ascii?Q?4g0BBArLX6NMhidH6ampq/NR/HT1y47v/+SsHk9uRtLBeMmWyKPROa9L0qo/?=
 =?us-ascii?Q?49VA6JiXn2WrsVdfZ3hAzMuf9ICoz5UZOnaKUi/XuoRQz1wqGAmr8WRNBH+W?=
 =?us-ascii?Q?KUgUFEU4EYfFU3M26FJZmd4J8sebP/72XXEb+AZwHnxSiOX5OsJB3xikAu4M?=
 =?us-ascii?Q?RFkj2e/Pu0j3Ijo+oh/UpK+COpJV1oq+rSAy0b48oovwzJ/0SMeRr6rvNrcG?=
 =?us-ascii?Q?xow4OH/m3dRmKUd6yCGxLg8ip+pS9+qaZEh9qsxgfPJapeH+ZLwF1ESr7oJk?=
 =?us-ascii?Q?zxA8KCDIGTzwqPptfvZ5RSP41GJJEVhOswBDOJTZrp0undqbOzrmkDo+b/ZD?=
 =?us-ascii?Q?CRgHEcEwKTkpNkM1He3joPxWOZytkGmo/cRRDqzGsJEs+rF/qwwkPpkO5C6u?=
 =?us-ascii?Q?czflcVPUDGuHza709C9QZhO2ZAq3zz2MJD9Zw8yoTvXgRpklY5ye9yW7lCze?=
 =?us-ascii?Q?YC4W3nsxv4IRopEnVgWqOeof3cw1JwnxLo6aNQY1TVPO9bJiKWPykMHP7qTD?=
 =?us-ascii?Q?BixmO5M0rhR2OL7ie0TzW5AgM9+CEL4Jyn8pLqxGk+CCLXQrXmeENtQk3s/F?=
 =?us-ascii?Q?Y5dpd4rn9PTOEv5QsEl/KWqbFJLLfJRTpb9dh68Q2vNB6uivgY+l1wLPD4X2?=
 =?us-ascii?Q?ychdg2IKl8lH8ZHYXZnjVK/F/7aDBDQ=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UB7PlTNKZOZzofLSHUUCQlYbA2NcNcUJd+7Qt8vjmcs8DLImhGfUCqjWptqxetdB6Csks1zv/3tEDgKYOrfuEG59KfmMNbG8FFu/+qtZcsKMBI5WnoxzVNde4Fh0LThx3jTTvAUtE+8V54/AAaLvtCfbTJDEuccj+rmveb7JdeB3vp5fgExIpshOk+VaqVst7HXL+cUDujF+BaV4wcDiy6SacHe3ZEH293lFfK7R4uIysAjiz39laLTLNzOCTmPtxyS5Bkhz0mnziHsAtMbDdpc27IbgE7dZh7rKr5/DZ/lzDHqMFUAWvj/XVrs9tpzgpEmqhVw33BD9IArsGbQIHw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed154a58-82a5-49be-cc42-08deaf89d0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:18.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6IMjYdigDIZYu09OG4j8Qxb3V+9iwt2hR37dkdfJUeU8sWkqcPScQ6Wi8FsQB6vUS2mkMpuJ0DR8qAjsNv/Q3/mYfD2StTOYtisZfDekGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pVNAA8GVccg-qhQIumYOkTgbGJETm76YP2eH9sq0XDA_1778523562
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F173651444D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286779-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

Adding support for internal PHY of the integrated
media access controller S2500

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/phy/ncn26000.c | 41 ++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index d302e04c8..1961d7ff3 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -14,6 +14,7 @@
=20
 #include "mdio-open-alliance.h"
=20
+#define PHY_ID_S2500=09=09=090x180FF411
 #define PHY_ID_NCN26000=09=09=090x180FF5A1
=20
 #define NCN26000_REG_IRQ_CTL            16
@@ -41,13 +42,15 @@
=20
 static int ncn26000_config_init(struct phy_device *phydev)
 {
-=09/* HW bug workaround: the default value of the PLCA TO_TIMER should be
-=09 * 32, where the current version of NCN26000 reports 24. This will be
-=09 * fixed in future PHY versions. For the time being, we force the
-=09 * correct default here.
-=09 */
-=09return phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR,
-=09=09=09     TO_TMR_DEFAULT);
+=09const struct phy_driver *pdrv =3D phydev->drv;
+=09int ret =3D 0;
+
+  /* NCN26000 PHY didn't have the default value */
+=09if (pdrv->phy_id =3D=3D PHY_ID_NCN26000)
+=09=09ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+=09=09=09=09     MDIO_OATC14_PLCA_TOTMR,
+=09=09=09=09     0xFFFF, TO_TMR_DEFAULT);
+=09return ret;
 }
=20
 static int ncn26000_config_aneg(struct phy_device *phydev)
@@ -163,7 +166,7 @@ static int ncn26000_config_intr(struct phy_device *phyd=
ev)
 }
=20
 /* Directly accessing via Clause 45 read avoids the extra
- * SPI accesses required by indirect access.
+ * SPI transactions required by indirect access.
  */
 static int ncn26000_read_mmd(struct phy_device *phydev, int dev, u16 reg)
 {
@@ -196,6 +199,27 @@ static int ncn26000_loopback(struct phy_device *phydev=
, bool enable, int speed)
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
+=09=09.set_loopback          =3D ncn26000_loopback,
+=09=09.set_plca_cfg          =3D ncn26000_plca_set_cfg,
+=09=09.get_plca_cfg          =3D genphy_c45_plca_get_cfg,
+=09=09.get_plca_status       =3D genphy_c45_plca_get_status,
+=09=09.soft_reset            =3D genphy_soft_reset,
+=09=09.get_sqi               =3D genphy_c45_oatc14_get_sqi,
+=09=09.get_sqi_max           =3D genphy_c45_oatc14_get_sqi_max,
+=09=09.read_mmd              =3D ncn26000_read_mmd,
+=09=09.write_mmd             =3D ncn26000_write_mmd,
+=09=09.cable_test_get_status =3D genphy_c45_oatc14_cable_test_get_status,
+=09=09.cable_test_start      =3D genphy_c45_oatc14_cable_test_start,
+=09},
 =09{
 =09=09PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
 =09=09.name                  =3D "NCN26000",
@@ -219,6 +243,7 @@ module_phy_driver(ncn26000_driver);
=20
 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] =3D {
 =09{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+=09{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
 =09{ }
 };
=20
--=20
2.43.0


