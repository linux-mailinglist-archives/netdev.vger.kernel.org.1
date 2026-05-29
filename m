Return-Path: <netdev+bounces-293200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCAlF4zhGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:57:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B4607935
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0A8D318993B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8C441054;
	Fri, 29 May 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="OWAq7Aw1"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0543E4BE
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080010; cv=none; b=UQVljpB533n/IhJx6zZMGCfdFqgssTIl1iT/fI/1QVuAMohqkI3e/3rHZ73ltQ2qo3XZN5eOTJZ+rIk/oQS3vu3xn+0akkGOWMzE3FyTEISuwArbiCKhjB3hAdnOBOcGGFLiYPHPx8VRzpFdlU+Uf6DxMbuix8J2OuvHtuLtBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080010; c=relaxed/simple;
	bh=Mu6D7fXDjm/dJeofXjGkMAkeQ4qsyN+lhYsoTMOi26Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m7DOhsDl0s5r6UHM66Ul4aGVy4ZZc2uUxtt5PD6I3uL7Zb/TVPOV6SukLVU8tGT2bJt70H95NTvv+cEH+am7RXwcgPBN8aml/3t32xTE4Zv+H6Hfa1WRfOWI6G4SH5Q89nkrazUbwt1nvug2ioEC2a3hRlWfIY92uU6ik8u5c/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=OWAq7Aw1; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FCTBbcgUvbIkeGAAjJmhoBJSZhijaIDSAe0t+7k1/Rk=;
	b=OWAq7Aw1YN0Lp3lWy+BQs1Fs2hpvgxiBeEgwQ19GSyKbBTRWANXtFDJJAyzSgcVEdvEfjt
	JeLh2nP+RwOhc/S9d/mtS0h+eiFzPYTcfDTpOAbmDTEhh82ct7n+9zt41ltd0SHDgc0cRv
	EVp81jPInC0DWURiagEYGkHAU4o/jA1P9bD7oQwzaBEALhqhbx3CRJcdm//YAhc7Oi37K9
	PSLx7VGZjHeypgXpiKgrf5Kr9wo//MqA1VuoExw9UaNX2HziIve/wqeR+n2idg4zqgtV5Y
	pa8LvM3lBsINxzj/z/2htw0VxrscqgHnRibM4HFxkDkdkksj1oSlYpv7PAzoeQ==
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-20-j034GO_ZPOa42RqdOXKlrA-1; Fri,
 29 May 2026 11:39:58 -0700
X-MC-Unique: j034GO_ZPOa42RqdOXKlrA-1
X-Mimecast-MFC-AGG-ID: j034GO_ZPOa42RqdOXKlrA_1780079996
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB9046.namprd02.prod.outlook.com (2603:10b6:8:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 18:39:52 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:39:52 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 05/14] net: ethernet: oa_tc6: Move OA TC6 MMS
 definitions to header file
Thread-Topic: [PATCH net-next v3 05/14] net: ethernet: oa_tc6: Move OA TC6 MMS
 definitions to header file
Thread-Index: AdzvmMOODRZu/gHzR9WWpu6hXTz+Iw==
Date: Fri, 29 May 2026 18:39:52 +0000
Message-ID: <CY8PR02MB9249C29E61887561D50B243D83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB9046:EE_
x-ms-office365-filtering-correlation-id: 4bb5d3b6-c336-4107-45ea-08debdb1ac17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: NvM1LNmQ1zAG7N9OYIfJyRc04nMDX3wyRuRfW8m5XrDQ2m4WRxfrYJRizVRv3xv7Rp0A7Tx5vmGM0xIggoTOPf3vU2ytPYSdVWbH/4y6d25E0eW3ognvOb2oacWzhIFdF8K2w4F85tIfOrEbC0fMH348d6Eqcnt9fbHcW3qlcWj/fgn/fzghihVPTvhCT2r9W/H/CXlLDcfojvB5hp3UDkOVy3BBHfmOxdpNtNTcPw2116JrMdAiWOKEyggrCX0qYvxKWyLpVERa6FgQbicrWl5UVNDzdcNn3gxC2+UbtD305dfRvpYQOuUEU22TLKLqHGkOI+RjpYOL18U8icemwVgieM7PiOvHZoTz+0T3Mvf/Ic58juq7tG8ycHXA5AMNn4RPxEGiLeEPCrKIweZa14rw22O1J3f4SNuywYSsWMIKWdKTaRHRbPpWIvwzn1Wodc+e4RiGddVJbZxrlw1oS/mEj+AdPQ53iCPFAkkFrOAIXIT1W1vsThBONgGj0cXiUcd0SHZp7stTeQKMOo7vg5U82c6ZDXjdONFshbAsK6JKeyVIyDT9vyLSwinBk5UtUSqT4bjplBCaJ4jiqLqiV1a2kqLDlyAjhR1W0nXAPg87JyNTzNbzGv7cPWLsnWZaKRzyIOlDEI1vFsaIxRIdSuCHMFcB5i7kfYMsYswrY8cZMunaezdLT+rkin1a8aG2jAxxRjj+wawYOZAd/hLdeWnbIlL0+E7/MZHG65LA32RLnLFiqjopR19OjOQ+mXca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JtcaREQJ6a3Njt1l0fH0Te4bhl7Bh+1enUlyAMGhGPuzxrtzWRyX85Udw9nv?=
 =?us-ascii?Q?DM4cQy5OA3ltv3+vfFnu7xX4mclcrNB7oaltbdKijp6WGKddUB+l/a9z43bv?=
 =?us-ascii?Q?Hle+tX7TnfR8feSXnfDMQpDQkqw893BalB7RDMBlnTlNbDAamb0B6IgSbn4A?=
 =?us-ascii?Q?F4sToQNnHPlhDdDXOrnkAQU2VLcbVJZouU58IEn4Yg490+xIGbiIPBz6bqsG?=
 =?us-ascii?Q?/2SpSt2S+gWNKHNMSS4CWtIyR7XB4CLs61/N2JpbnlbnI1uWgv+c4UizzMsO?=
 =?us-ascii?Q?MFABsocFWdNUoeCe1O4kuy4NEb89X8V/t5s1jvGqhOmCXoQO+37WteKKPI1x?=
 =?us-ascii?Q?L3xULT+0GhGlTUkInbl2OSlYYEbIkvIcH1kNMAtojH9CTBT/bayikN3XIWXm?=
 =?us-ascii?Q?uF7TBix7C1w9s5aomFqZTi48l7eWtA3keedF3erbYqsntK5ZAJ/Tv0lBN47v?=
 =?us-ascii?Q?dskjE8IvXma/OSasc34DvHeQtkMZMWxS7p4am36tnNWmaDUk+btm0GqcqDr4?=
 =?us-ascii?Q?IjJHVDynzlC9hrgZBR67oyG+C7CYhJNR1wb8YL2utWE+D0CdweuXL32+1F8U?=
 =?us-ascii?Q?aPQFZByThtAqg3wnizpV2VujVJOpeyzqttoSQ/OzhyworZIF0PuOa4v6moGu?=
 =?us-ascii?Q?NHL5qLDPjBMvfIQz7rZzbdQM9y2mM/e9CpmcZvPbFP1o7PubeHfv8ZN5Rtrc?=
 =?us-ascii?Q?TjGRAgIaaL5ZqSrhKwUxr9O542Cl24cleCsFdPwKklypEdxp+KXvA8pFaq3c?=
 =?us-ascii?Q?heH0BFxMwwZKbjOi24WxWnDsvnql1E30G+/4QD14b8nVAdqt2R+Ni21k5gtK?=
 =?us-ascii?Q?Y3NNWArsg5uj9Eq5qFM4ou83uo0I4mUV/p7/V8+bj51Dz49iEBpsZ3NxDQf0?=
 =?us-ascii?Q?zjuWOPTxA/QMUcmh0eSRkBzaEDG+FJKKSRS+DRk66ez7HG4fwiG5gX6Rz9DQ?=
 =?us-ascii?Q?LfOWrrl/AIlM5O51bo4jjqBsY+gICb/ht24ZV0p8JqnFpBAvUD6TjEoZYllZ?=
 =?us-ascii?Q?42saWB4pMj4+6Z4It+A4w4fjEK1/6XpfMLJ2NFRNIzlij7HMXjqm2xl6ILil?=
 =?us-ascii?Q?ZFVOx4zaUofPGipLWN40GcKRbnXfKvQ8gIISy4fpi3UFkUChLsglPn+CJWQw?=
 =?us-ascii?Q?nXgnRv2fD0zPW9DGCdotFhibhSzPyvdw2LtZP1K447Z6BWk/UIZe6jCmcG+Z?=
 =?us-ascii?Q?u909mDeauSmCWW1M6iAiIh4G6kDZi+fZMbb7MWDUB2MlWEWcot2t1kDpgEGr?=
 =?us-ascii?Q?3o3S3/7Pt2y9bsG+sG/fILjiLzM43Ecmt9qjFUD1noftKfk0KSebAqAYFxK7?=
 =?us-ascii?Q?mxR1t5JByfEh0TeLT3OUhRPIpncSbRFHdF4BNElpY2h1XKBrnvvpIWVNJmR0?=
 =?us-ascii?Q?rleqT6LBMDHVzaV/zLrV0vP99teBgm4CvYZL3vW0R/IzxFyL/ej+91jX9OlX?=
 =?us-ascii?Q?bpw/W69imGFDJwqQLZvCnFByPA0zFQ0FcRN6H1Goao91GOCpzNevDrtKnAHl?=
 =?us-ascii?Q?+Ck46UjSb4cilCXT6nCzSnwt0tVYQK34BJI3m9jyxf/UqvmnoetNnIAJYMPK?=
 =?us-ascii?Q?pN4y09q1Wg1va7BLvv1BH3uEFdRKPCCUSnzyTywNnheFZ5fBkvSt4aiaTpfz?=
 =?us-ascii?Q?xlKFerX3HSfL1e180aKWwgH/AZXMARW021uSgCH1g4rrwkAxrvnv1XDvc562?=
 =?us-ascii?Q?+AGeZy+sCS+VhvLpYZFbhoSXpvf07seZTWUpcF+Np74cWdIukFNmoQFGozzB?=
 =?us-ascii?Q?xiLd1dGnKg=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SEKWk9ZUbeHeq5I7892yDMany2j4L385K6J8lXBMuIBqb95Xyk3yk24oc2Z505lpYsAEkJP9iu8aHBWMSO3yG5yL+0rmQDMY6Zi+15l4bd9T325tZeYnEkxZYqK0wWj6QghyZOI7AtssQBEHRdRDVZkPQlhifamCph41FmxfDpgd+06UouYNMGPhT6uYVimbifBTXhQha+lhyZ4gXV7c7ZOB3VX9l+yo28R4OvUDdJlWvoxiMoCoWOJao8dX9NHuwZ0Lr8X/ssMCriLu6m43hqVWNT2XxwK8ms85Z2GeJDTGYfngrbWbCFnGhhAMksBZoRwGX1b/LZSFjEwrvj+dTQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb5d3b6-c336-4107-45ea-08debdb1ac17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:39:52.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gApAe5UX4Yj/w9P1v3Aa8ruazMdkXF7oknCd4K+jp+26w/ko6EJnBBUeoYjLOa4bgHIlpKTnURAvXFmbLFmnR25dmA+dr49ZT71dnzgMilk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9046
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: udzYIn69lXzCyDc9qgmEsZZ0yW-9LIql5Fnk-T2FBpc_1780079996
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293200-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: E25B4607935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To prepare for other files to share the constant definitions for
clause 45 registers memory map selectors, moving to header file.
The values are from table 6 in OPEN Alliance specification.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h |  9 ---------
 include/linux/oa_tc6.h                       | 13 +++++++++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/eth=
ernet/oa_tc6/oa_tc6_std_def.h
index fdde9ba719bf..2d8e28fb46fc 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
@@ -85,15 +85,6 @@
 #define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET=09GENMASK(13, 8)
 #define OA_TC6_DATA_FOOTER_TX_CREDITS=09=09GENMASK(5, 1)
=20
-/* PHY - Clause 45 registers memory map selector (MMS) as per table 6 in t=
he
- * OPEN Alliance specification.
- */
-#define OA_TC6_PHY_C45_PCS_MMS2=09=09=092=09/* MMD 3 */
-#define OA_TC6_PHY_C45_PMA_PMD_MMS3=09=093=09/* MMD 1 */
-#define OA_TC6_PHY_C45_VS_PLCA_MMS4=09=094=09/* MMD 31 */
-#define OA_TC6_PHY_C45_AUTO_NEG_MMS5=09=095=09/* MMD 7 */
-#define OA_TC6_PHY_C45_POWER_UNIT_MMS6=09=096=09/* MMD 13 */
-
 #define OA_TC6_CTRL_HEADER_SIZE=09=09=094
 #define OA_TC6_CTRL_REG_VALUE_SIZE=09=094
 #define OA_TC6_CTRL_IGNORED_SIZE=09=094
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 15f58e3c56c7..0d5cae460850 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -7,9 +7,21 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */
=20
+#ifndef _LINUX_OA_TC6_H
+#define _LINUX_OA_TC6_H
+
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
=20
+/* PHY - Clause 45 registers memory map selector (MMS) as per table 6 in
+ * the OPEN Alliance specification.
+ */
+#define OA_TC6_PHY_C45_PCS_MMS2=09=09=092=09/* MMD 3 */
+#define OA_TC6_PHY_C45_PMA_PMD_MMS3=09=093=09/* MMD 1 */
+#define OA_TC6_PHY_C45_VS_PLCA_MMS4=09=094=09/* MMD 31 */
+#define OA_TC6_PHY_C45_AUTO_NEG_MMS5=09=095=09/* MMD 7 */
+#define OA_TC6_PHY_C45_POWER_UNIT_MMS6=09=096=09/* MMD 13 */
+
 struct oa_tc6;
=20
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netd=
ev);
@@ -22,3 +34,4 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address=
, u32 value[],
 =09=09=09  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+#endif /* _LINUX_OA_TC6_H */
--=20
2.43.0


