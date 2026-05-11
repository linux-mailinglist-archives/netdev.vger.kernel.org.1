Return-Path: <netdev+bounces-286780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNH2HiUeAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:21:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1A514491
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DF98308E815
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DBB44D03E;
	Mon, 11 May 2026 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="S6eCLgUA"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A308947B429
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523578; cv=none; b=OzHqQWOgvYikBSf3nOtkOSyKZV23I80rt05FRbNsHjImeHOgnPEVFI64BzFz8IPhnwp7+hKiYFIBf8A2EWIxK2OG7UqFX4dtrGRcFBZXZx1nShLUHJ6xlf5/fjXbSI+Xbj0YCJmhjr1BGN89xOkxN4bh0TcAjzDI+xvdxyf3B4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523578; c=relaxed/simple;
	bh=FasjAAKx4j6u847RHXcw4mW5TChNihUz173cPVVGoY4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bsi0jIkvIPxeY8GT79acq6u6CYvWtJNeTYJkkd2Sm2eHXVJbaVYX7mdE/wx1Vydn+voT/7ZEruMRoLaVRNSPoi4WkmNDDb2eamVgofvdhea8mAl2rYpEw5pLcQZoyDc2UqCkHTnoaV7D2Af4RIE2j8Mi8NNRm7uyOEKIKetR4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=S6eCLgUA; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w4FFmSZEyOfThna4kmnUH5xUJ7M5dzZq2ZCDqQF/25A=;
	b=S6eCLgUAEnPqIZKMlm3dBn9r+iCCFKIEvTKKDB8VzEYblFRhLr4sfolPuydPv8a520GPEd
	/qR3dbx73sZRf2+wX+iRIh92HV2JjeXi3kpTa8iAcRRYfO34PG5aSGuAr/sDyANmHl8OxO
	tsnWk9Nc8R+w/6YttlII/EbydPpBEynmWQ1iYKW77CMUC7/7l3zbj8C5RVkS6nuwGbn9KO
	kuO0dbPVzZHQkwuLU7SVRBonXS+fA0f5sG8SqaQJ5cHADe+ihrZezwjsMAM/F86dIPrib2
	pqNW7fBbI/8Saxr9Ni5XUh0Efu+jTpITDyWKg+9UUKxJJgJfNGtpLWRDT7oxqw==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-19-bNAA07DjOra8RRWOH53zNA-4; Mon,
 11 May 2026 11:19:32 -0700
X-MC-Unique: bNAA07DjOra8RRWOH53zNA-4
X-Mimecast-MFC-AGG-ID: bNAA07DjOra8RRWOH53zNA_1778523568
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:26 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:24 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: Adding vendor specific
 MMS
Thread-Topic: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: Adding vendor
 specific MMS
Thread-Index: AdzhcQEsu1akVKsfT+6eMGz6knnw5g==
Date: Mon, 11 May 2026 18:19:24 +0000
Message-ID: <CY8PR02MB924967FCDC5FE1A541D4DDC683382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: 37318918-f2b6-4b4b-d5ab-08deaf89d4ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021|11063799003
x-microsoft-antispam-message-info: ZH9XlkHG8tP0HpLHtlCLhRXWbCpfb29ldPmY0PhsJ3cMkzLwuXBJo3MoEXS6yl2gSxvx2QcJVtoptRhvBuGVlTkHCvkV3thFulemHe+yE2+YFOvREwt0JoSODikMAiFqXnhxl4qlf90eJo37PIfu8g/jSUlgO2aihC6EsW9wtYavLmKiXScmfdy8/ytc37eHZ++jzH+Z4lk3SZcU8V0MWL5rooeLvCwSIeiuHuPgAl+zUevvyhTq+G82XOPwx3BA3aBeKOLtUbPCiFkaLWMfhR0+EpfOT2npK4BdnxIRHzBBcr6MwF6+RJktsxKtQ6r8yJT1h1pZkdq1qtLTviDkuY4ykBofQsfwqtP0VbIsJpiuZ9fOR6+FVss9McewoXIMmwyC2a/JJ8MA5oIPoXayqFVz9tl9PGNOmoZoDsAiUcgRqznFDsVqEoDjO5kudszm5VRfesKlsNa82bf8bWmsGg6nLjIBTV4uyMcx/LOlMpiL18UIx2NmvHu99eVTBAsonvObkgblOVA0EjZt8PmPVZdSWaUCRvrshD95/7t9wf5uHha4uZILbegsAiFUR4DdFVC6rKrIQi5AO44ADjQp2dkF9tjKiCnPdw6+nDaD7RUkZs2/7URvausPukX7kgWWSQfPup2jGcZC6FkkPji8BsiCkhVpSKCCKa5hojmm6y6WqQ45Qr189kGwCPfqXC36TOvYqzIOtoYjGQrKynVKXRtph+IadU65TED58dCHOPjmgXxhSuD4QpyBDxsZpa1+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XlNlJ/9k/prRpt7yj4aHI+UcZJ9MFfSkxuJXuZFLy1C40URDkV7ra6cG7Ooc?=
 =?us-ascii?Q?oCvK5kOFxB6HzeW2YMvmhNI7MZLsWLqNddytg+DGWeYwXqZI+dYrgTTn3olr?=
 =?us-ascii?Q?St+y+EDs3/R42VaeERZ1PKcHyXEZUDScrjmYEuUw2wvTARq/2XzR+qbGDAZi?=
 =?us-ascii?Q?3lZUGdOIjpCF2nDsLlyC7eGvbz9G5gHAvFFrde6/lWRYBYxBt2w2g5dUd+FO?=
 =?us-ascii?Q?1WNKqoAHiLC5HoXqg7vGrjq6oO5hYa0kts3OeW5u2T63U57elkhisyQcDf3Z?=
 =?us-ascii?Q?Dn/GS+ZOwz0ii0XaWOhL85B28+kRro1U/SqqIpyZHmRiboIO/stH6aoqhhGl?=
 =?us-ascii?Q?rtitIaZhwKttqAL98exN3CeJKx0hZwaMfJSPT+8Zs8x0X8orN33nCziCqfqi?=
 =?us-ascii?Q?Kyo5y0YrfImZywPu2mgJXrJz9/8cDZ9GObVdgV3qfSBdVbplnXTPZTLllcBB?=
 =?us-ascii?Q?2qZlZCMiFG4PshldLXKlIr8uUkEIcA0TUBuTD9UChR8OmHA8/ZxuXwYObG4L?=
 =?us-ascii?Q?nA1VI4eDON/3UIP3YuEpjm3ygIZKG8KMoSDyECsBycIsUr8wxpSAOLatPMnr?=
 =?us-ascii?Q?t+9+xlhB6WvjMV6s7WVjgWhJB3MpxLlMPS3/5QS9E9azCt5y+fWjieZlymFB?=
 =?us-ascii?Q?w3bqLzcpWyT+Klvk0FZq+PzunR+3eQSdFKqZS62k/VpwO71lvwR1HnWxdByL?=
 =?us-ascii?Q?Q1WTLspMAGCshdQUxL7sAy6d21XkmwrK9jvfxjkycf26AzVa0L2alcvNeLJW?=
 =?us-ascii?Q?UTnhysQ3anNr27QrnrS0VFHlbMM84RPw59xIBTg4WJTskvtr+0gtH2zzqQH+?=
 =?us-ascii?Q?wdSKbpCyC0VGqBq32OzkZ5DIUevH2Ap/9yyLZL9/E8gjTaIwbhAZ8EtO5AAA?=
 =?us-ascii?Q?XTU5Ntg2k0u9eyo3d0i2MpuaadmCFOwQlRc5L6sCSSCjTTSf7XfSpC2lBcgD?=
 =?us-ascii?Q?CpjwivTMUkVqDWbqS9YrkWvlqaHP1i2pVFpVHsQQV/kR9cmB8oxv3hp9JiUQ?=
 =?us-ascii?Q?SljTcMLCoNwrhhSvuG1HX+dbqdQxyHQxHSf4TjvXZTuSC77SRqj8dz/dXeMG?=
 =?us-ascii?Q?UbsuqLSbvekKJnuzLHr1ysAIKXNR0RQbM7bhbvXyuiq4kMWDj65ab0bcGGIN?=
 =?us-ascii?Q?K/aKGzh5L24cb6e0UfmhIi4AadFhDLw+UmtqpHLVgi9deImRS82MlwbqOAoQ?=
 =?us-ascii?Q?wxEz44c8z5F8IduwtBC6+lSpZURxWucIOTOcfEQuM/3R0Ne9ICIUVCw8GCxx?=
 =?us-ascii?Q?82IQbAYT42YHKcV20XKYAs2LWa8lcxABjoVywFacXR6dvCiv2wtXZCzOBuHb?=
 =?us-ascii?Q?KyCiSH3OAzX2ArgbZJnnR++GmfD4Bhy0ixbcRy8OA+lsW9/XLYhbHNote36Q?=
 =?us-ascii?Q?TNvcCq91sWK3ofjVzabWyLhuMw9wEcfZrmRJHn67cOc2CFwZCiwx/e92AxQt?=
 =?us-ascii?Q?qbzY8nz4CxA/wj3XIbP6TaR2HLy3yI/epHERXhMCquAd3UjoenzeT020XQis?=
 =?us-ascii?Q?XcZd0kGW3vnPupudodVy9DbLo1a+5dlxy4bCiIGgFA97KvopIlnCuwN9VMi0?=
 =?us-ascii?Q?dmOMklwqgK6q2aRC/7vuKXzH0OQNIoYCG12DPOlwr7HBpC/XR2TiFpj6kfV4?=
 =?us-ascii?Q?ZA7TlAiypbVTscTTRFYPjOI4q+2bpvEnnXd5JQsWt7MJzmt+aGk5KQFEdBUa?=
 =?us-ascii?Q?cgswGu4sAuHSUyK3Y6Z2U4tE57gecPZDRscBeyImiLakYjqEjCwG7LxMevoV?=
 =?us-ascii?Q?zAOmvKeXICYu1GAvnO4xFGv4Ab7Uelo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VanLuskDzPnQWYtfBtMFZJgG4UvK1A5Dtw4TweGeb9tc4dzcplLgOYOEjQ9B4J/PEL5niV6QbyccMw2e7uXt6VR6lBdIV/pRKjUkPO49ZCEjgnUMQKXYrHMI58aq0QNpi4F7GcjP361w3/SvzHMZ0ZauJtIePEbN4mcMn7FICdByQa6mhpaLbA5/2JCxAThwDy1wmNP4wHmYJqC15zRASGREIruoSqz+YcTdmd3lMhAXb828RLQZS5yoTkwPQWMEq+fEexaZNaoB/tVneazKv8A94IZBBPC3Q49zX/z5PC9DYNzfRqBdTZVJhQboZtDaeD/OhlhYIYU8rwSmEAAOew==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37318918-f2b6-4b4b-d5ab-08deaf89d4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:24.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vV9mB1Ejnt07pAFrzbmo94NrzGU06MLkuiPclVSj+Ur2xAZny6IdF65FY5y0v2iNIBQF+Y0iVKFVOlfUv2rSRe9yM3g8K1CCbLTsBUWCpQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ei8OVVACQeYcGnG9H_-iCEcSTHiHk_GjqxG6qnpQQfI_1778523568
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E5D1A514491
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286780-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,microchip.com:email]
X-Rspamd-Action: no action

Vendor1 MMD value is mapped to vendor specific memory map
selector fom table 6 of Open Alliance 10BASET1x MACPHY
Serial Interface specification.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 23 ++++++++++++++++++++---
 include/linux/oa_tc6.h        |  5 +++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a79..beeac008f 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -129,6 +129,7 @@ struct oa_tc6 {
 =09u8 rx_chunks_available;
 =09bool rx_buf_overflow;
 =09bool int_flag;
+=09int vend1_mms;
 };
=20
 enum oa_tc6_header_type {
@@ -190,6 +191,19 @@ static int oa_tc6_get_parity(u32 p)
 =09return !((p >> 28) & 1);
 }
=20
+/**
+ * Add vendor specific MDIO_MMD to OA TC6 MMS mapper value.
+ * @tc6: oa_tc6 struct.
+ * @mms: vendor defined MMS value.
+ *
+ * Return: 0 on success otherwise failed.
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
@@ -443,7 +457,7 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, in=
t addr, int regnum,
 =09=09=09=09     val);
 }
=20
-static int oa_tc6_get_phy_c45_mms(int devnum)
+static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
 {
 =09switch (devnum) {
 =09case MDIO_MMD_PCS:
@@ -456,6 +470,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 =09=09return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
 =09case MDIO_MMD_POWER_UNIT:
 =09=09return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+=09case MDIO_MMD_VEND1:
+=09=09return tc6->vend1_mms;
 =09default:
 =09=09return -EOPNOTSUPP;
 =09}
@@ -468,7 +484,7 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus,=
 int addr, int devnum,
 =09u32 regval;
 =09int ret;
=20
-=09ret =3D oa_tc6_get_phy_c45_mms(devnum);
+=09ret =3D oa_tc6_get_phy_c45_mms(tc6, devnum);
 =09if (ret < 0)
 =09=09return ret;
=20
@@ -485,7 +501,7 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus=
, int addr, int devnum,
 =09struct oa_tc6 *tc6 =3D bus->priv;
 =09int ret;
=20
-=09ret =3D oa_tc6_get_phy_c45_mms(devnum);
+=09ret =3D oa_tc6_get_phy_c45_mms(tc6, devnum);
 =09if (ret < 0)
 =09=09return ret;
=20
@@ -1246,6 +1262,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, st=
ruct net_device *netdev)
 =09SET_NETDEV_DEV(netdev, &spi->dev);
 =09mutex_init(&tc6->spi_ctrl_lock);
 =09spin_lock_init(&tc6->tx_skb_lock);
+=09tc6->vend1_mms =3D -EOPNOTSUPP;
=20
 =09/* Set the SPI controller to pump at realtime priority */
 =09tc6->spi->rt =3D true;
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 15f58e3c5..d3c74555f 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -7,6 +7,9 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */
=20
+#ifndef _LINUX_OA_TC6_H
+#define _LINUX_OA_TC6_H
+
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
=20
@@ -22,3 +25,5 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address=
, u32 value[],
 =09=09=09  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
+#endif /* _LINUX_OA_TC6_H */
--=20
2.43.0


