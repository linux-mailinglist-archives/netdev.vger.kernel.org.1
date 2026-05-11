Return-Path: <netdev+bounces-286782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEt4ImMeAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:22:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE55144DC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0F3D30A4D6C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573B947B439;
	Mon, 11 May 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="XhDpwET2"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2C47CC94
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523593; cv=none; b=JoZCmC24xl+yxHfUQCjqAU0J/R19zTHIqOVzR0LPV7SKjhN/sEWPBoit6zQ43XyTb6kDSPeO4i7I9Jlh9a+Ta4kNXrTaHgh0iYQ/NTLudkQ55Wqzh7tI9RQuCubcw/pPLMvsQIG+eAnETPPmPvjiRXqfMIKFpOk5UBoVouf2npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523593; c=relaxed/simple;
	bh=LRTpwuMIztOJc0zzaX0iIiUzgwbPsqFXIhY2C+VJ84c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sIbYwWT/8QiUGry5dbH4PtkU2UrkOdEpqPCuioo+/y6oYqWvq/45Yi2N83WoWwY23fjODQKr/sUImhF7aTSYc4MEM5BhTdmPeX/s2HZJraYcmZsWU2p3EOmms0AcrYvuFbnvETCZhTo/RydlJW/25JRVtunIf6H30TCWedKHp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=XhDpwET2; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dzh2SfY7ae0Crmu7yDQik20QgYCmegwNv8H9K6BW+fU=;
	b=XhDpwET2np0mi9SQC4vAES537PBAwTEVRZYuGvgT8MXhMKtrWUbVAwQiKd2QwOVrS1mVA/
	ljmr/pLR2Y7Zr4XZyqzomoXeEe99Vqbm/GdxgbM1kJdZEaxMXlnHaHjenhwaT4hLpDif4Q
	YOhnmi3uebFyD/vzCLOOa684JD7+c/AE1lPEHqioUdlYO6N8VJfGhQWt44ZuY49yfoh9yY
	igGlbOkQR+SUn1r8E5l3OGWfBkPcC6rWjleD8Q/iggVkEp+jDLYTvuwVd30PaGimaBPbQ2
	TL2RA+ssO5BuWDFOfrOMXRLRAoMHa8HDzpeHe6L4BRKvU9LhglNoY7+BVYhI+A==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-9-EggqAbNaMsiX6ZIE3q70yg-1; Mon,
 11 May 2026 11:19:45 -0700
X-MC-Unique: EggqAbNaMsiX6ZIE3q70yg-1
X-Mimecast-MFC-AGG-ID: EggqAbNaMsiX6ZIE3q70yg_1778523581
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:37 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:37 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 7/9] net: ethernet: oa_tc6: fix for minor issues
Thread-Topic: [PATCH net-next v2 7/9] net: ethernet: oa_tc6: fix for minor
 issues
Thread-Index: AdzhcVkjhMIIn/64QeGxeW0+vr8RlA==
Date: Mon, 11 May 2026 18:19:37 +0000
Message-ID: <CY8PR02MB92494EEBB98152678D3CCEF183382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: d0c97d17-33e6-4fe9-3205-08deaf89dc61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021|11063799003
x-microsoft-antispam-message-info: p+iOhw/gSBZmo+b5BJSkLC440E4VOaXJ/ReysuYlfFWQ3ip9ss1QXHYm6M3q5fOwQjd6XkWLTPqYTTQ7gHbJljguXCovsiTzvQmJCYdDu5/X0A7HH/LyncCySd+tPd+AAccQ89ufXBCLflgZzri8qngrprZ+NAzjUI89qjKLq14JJ9TOCvtL8+SxDkcoAmONZJ1KrylgHoyNW3YUV4USXongJt9kehldj62A4144SItoKeKLJ5FpZM1lYcoc90dDKBzkdd+380JHA1KMfzVFq59ybOrZ9WMWKLRLl9pHBbMAwEk7TvHJHT+NG8P/80gQUh5I505UJ+IqKLGLQGLMO5pKdC6j/Il/iCLVbP0RfOkcz4n7zA1Bd0u3ihWIe/dg/NPma9OE5yh4s53nUYhTQiore5gru2HgvaUHDcDutntLtyamuqBYi3PESDBH7ae4hYHytPPC6JI65QbQx0+BMlBxBrqs1YSGgNY79RggDVrPRND2+rb50ZQN+BDNzZ/Jwp9voQIDYsUAKNreg2sXS4LZNyO4NAdYPsXWNCmcwcGOdaIcT600e3at/6NYlZ+4EvdKlngLdQOBp8SYhS5GCOraUUqJV5/Yhg8SbSKGjDAQp4FB5KjqWS6GZpr6mEIl11fHTu9I66wlVyrfjbde12S7Qwhi5zCyvdnUjvWEStLwlbvdDA98qYc++yO8JrPlSyKz/Bp7I9MUaBSWCBpPcv/YgLZNK4r/9u0MV5P2mEwLHny501CghpFwqhGW2Xe7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?svYQWj8qU2/DrFFSk9H2sFWiz+a5a2CyL9EKdp7nEnC0V2Rj0vLKYRdPFjui?=
 =?us-ascii?Q?zaXAalGdcEKeX8Do2l2FsDg/fRBdfF/+tFjgNwOlqKD6iy1GvzrZ8yIXDke+?=
 =?us-ascii?Q?S4yCfBu3ZF4vZ8FLROWVkSzjx3+DM4qrQYkvtcBek5negZa0GRnf5kMhQS0n?=
 =?us-ascii?Q?NvjUZt8VlM6Cwm77Z5K86G4eNC3rcjY2eo6S6cUmEHuhZUjqYfbFmkeIkV7j?=
 =?us-ascii?Q?a9lnJ6DIAp+N3Bcd7Rf/DKPssIFgbHQOn6BNvGCtDNnXH5hSzBFqu7QIc0EJ?=
 =?us-ascii?Q?WGcq/Rp0yFQtWw91fIC9MkvcFBiH0kj7ummqTjrKEtipIn52teNpl2VN5XMa?=
 =?us-ascii?Q?Iik7jc0tFaoTKguSt6uQA3Je4bDCGiKrvaBmZ1UYrChN1MLMcKvH2hfA2eSd?=
 =?us-ascii?Q?7M9xCjRp0/YDDfKKLdVeak+k5UW379oVH2qKDV1MFwm6C5eFn+yW4RmTo6vl?=
 =?us-ascii?Q?a4hosckoCILWF8GGh1oU9ikUyHZEsExLBCgbdCyBztfp4lG3yLDFHXJa5rLt?=
 =?us-ascii?Q?WlfHJKEBMCSfAfCwKEi5RWeqdiG92f4tORNOKKdFul1W60rzMC9V0bWDEOmP?=
 =?us-ascii?Q?2cWyAAIBLaGCo420lFnLnp4fF3Mt10xUE9740Dng/I6fGTLPesjzlUUpWFHN?=
 =?us-ascii?Q?C8w0qWXpgf+FuQqwtmoLkn9aHylmMg5QVnpxPJ6dPJ/sYEjIiiBedTD9cJ5b?=
 =?us-ascii?Q?a9BFGCf17t3DYM473KLklycxoDCmOzNvLznFFDIwKcr6U54E046W22WU+Xep?=
 =?us-ascii?Q?ZCdtFk//vVwiiVE+bnJUNfWqffH5Ekpb6EVEMkG2NoPI1bCAxG09qRRfn5mz?=
 =?us-ascii?Q?UXiVQz3vYYWDUw50tFc/8cfBZ1fjvvPvzd2HG7eViK8/YEJj6k9XQm0tNurL?=
 =?us-ascii?Q?WUYu6aigqN1WySDIRf8LJ55e5v2JVnldXVTfa4LtFtMuHKRiK4acxdloH3oZ?=
 =?us-ascii?Q?RyXNUyI/UTjfEMrjQfiBZKhpsLBIs88IJXQFm0BMKGzfOhZ6B5TQbIqf6LIX?=
 =?us-ascii?Q?bByahf0d2A+rTG9Hh/MSmOb5MjIIi9vy8XnDlOgrJUaxXhnqQeBH1O8S37gT?=
 =?us-ascii?Q?43sqsurvOB57SXF1Af4hgKlxgjXo16apTi/zAVCaDXAVnabRFYd8GbZsN7x5?=
 =?us-ascii?Q?MzGFcuRglD7d9N84LHEuM/fI39uCwb+2EDdOr8KVMmWLQF6/pMkBqe40hDHw?=
 =?us-ascii?Q?Xp14Yu/AAWQmam0/PdJLTYV8N+uiodtpi22SmKf27RIjvBWvehlebxkgEXeV?=
 =?us-ascii?Q?7D3fwgftBqWv35ajriQhv6sipYGmajOh3AyMCGVHIBa4jOyzEsYtNFomkJI1?=
 =?us-ascii?Q?UUMUUCJGlNHWSkevjcjEZtEMW3cnNdA0TVP5UkfEWHSxhvTNPJcJj6RZubFN?=
 =?us-ascii?Q?jQvDSrkKiRmOj17jimxKEvaoBa7hE5cfzCzpS9Jo+3wkb2feC7BsRJ+MiI2i?=
 =?us-ascii?Q?jyTWnMhemedHix0eksdyuOTIoUNidGX9aZEQB/8Yyxbd3acIIExTXblGiQXr?=
 =?us-ascii?Q?Tt9fuhtq+5JdqMEeJKxUDlumUw155c/Eqv8gROjXR8sNTXuXhm9yoFnEyOVx?=
 =?us-ascii?Q?OcM/oZHkLWi22RIhBhYg1u3yQa793HQR2yVasLqjnil+B3Hf8qaAXFCne9nI?=
 =?us-ascii?Q?cO0FtN0S+aoCJbvPbRqhcD8qirxdGlesobXyv/m2ntHyyBQvPWYop9S7tciY?=
 =?us-ascii?Q?TMEECJtqoxxNfAGZMnqMEwok6Wi3qgS/fQfdvi/3Sv0H2dYCofWsISfbpuRM?=
 =?us-ascii?Q?q4DrzwqvWnL5o0huPLDbm6Vqb44psJw=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NhVHEf88BIznH+4x8k+jMGgYqe+avDQWwO/n1sya03ydlSo2f+vdaIi+3htyIvyHRETXyrYMCBnFJopLoEzpfgM+rwtaTr5Xkv5M9wG0QMwSXMkcV4agGQVieDLiwUMkFs8lLPJqZkLKJ0JP/kUCtTM/j0sIdq+HSUZlcccRGUosaLNeYU6AocZ6iGFYKAwRS+7MqA/2aSnvqWHY5PXZ3G74HCU6A3JLnj1c/YVNPUg0xgb0n+wN+KVDZMJ57OTm3ZjFcwgF4A1Q4XHqVLCtQE+RO6a5Tn+MA8mqrvTokqVmLPtP/lMO2GAlFjNcddVCJvRI+58X1F2S+hGXuHGFmA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c97d17-33e6-4fe9-3205-08deaf89dc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:37.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFaCC8sddxnFEQzmDbHqDl3PPuM4StquDo0XYPw3oB5/z5YWXP833M6Uq5IE+e4v7eESKmfeP7N2Iw6YoAcP9AdDegVL5GO5mj2AfI+qy1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -hCzCOqLKwetiiBI9_Cv-uFU9hJAOFdoGgFQlwdz_Hs_1778523581
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F2AE55144DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

- Replaced int with appropriate u32
 - Replaced bool with appropriate int
 - Added check for netif running. Without the check,
   issue was seen, particularly when system is coming up.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 48bd75f42..195abdfb0 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -211,7 +211,7 @@ static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
 =09return spi_sync(tc6->spi, &msg);
 }
=20
-static int oa_tc6_get_parity(u32 p)
+static u32 oa_tc6_get_parity(u32 p)
 {
 =09/* Public domain code snippet, lifted from
 =09 * http://www-graphics.stanford.edu/~seander/bithacks.html
@@ -459,9 +459,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_ioctl);
 /**
  * Add vendor specific MDIO_MMD to OA TC6 MMS mapper value.
  * @tc6: oa_tc6 struct.
- * @mms: vendor defined MMS value.
- *
- * Return: 0 on success otherwise failed.
+ * @mms: vendor defined MMS value for VEND1 mdio device.
  */
 void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
 {
@@ -701,7 +699,7 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int=
 addr, int regnum)
 {
 =09struct oa_tc6 *tc6 =3D bus->priv;
 =09u32 regval;
-=09bool ret;
+=09int ret;
=20
 =09ret =3D oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 =09=09=09=09   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
@@ -864,7 +862,7 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 =09oa_tc6_mdiobus_unregister(tc6);
 }
=20
-static int oa_tc6_read_status0(struct oa_tc6 *tc6)
+static u32 oa_tc6_read_status0(struct oa_tc6 *tc6)
 {
 =09u32 regval;
 =09int ret;
@@ -1377,7 +1375,11 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc=
6)
=20
 =09=09if (tc6->int_flag) {
 =09=09=09tc6->int_flag =3D false;
-=09=09=09if (spi_len =3D=3D 0) {
+
+=09=09=09/* If nothing to transmit and interface isn't up,
+=09=09=09 * avoid sending empty chunks.
+=09=09=09 */
+=09=09=09if (spi_len =3D=3D 0 && netif_running(tc6->netdev)) {
 =09=09=09=09oa_tc6_add_empty_chunks_to_spi_buf(tc6, 1);
 =09=09=09=09spi_len =3D OA_TC6_CHUNK_SIZE;
 =09=09=09}
--=20
2.43.0


