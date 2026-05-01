Return-Path: <netdev+bounces-283275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kErQJ3X89GnFGwIAu9opvQ
	(envelope-from <netdev+bounces-283275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024D64AF1A4
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD49A303C601
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6F35C180;
	Fri,  1 May 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="W3rAlhxJ"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109D41C315
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662951; cv=none; b=TYmT3qgWEqyqbn2OkVj/Mx5ma0e+5vPTbWp63JOsS9jdJoAn1hI6njp8AHL2a+HA4mDegV1m8QFcRz+n/9qaYlOQYIrVQv+0FXUC/nH3tTSk5PBfaqrg5XhVOsFCHw67D0xR5eDqou2SfL9m1YsaYbQMeZ8dAQ7cPb1tNRY8dUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662951; c=relaxed/simple;
	bh=+f5EnlOZzsgMXB3W2HqKn5Zajn0zBijaKQ7httcMkAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bna8ZWBbzz9KJtFZoCpK5MWmGoIohDkbjzMJjR04C5TaxKdoESm0Nu2plCL9/fh5nOrGBDvof9BVzTD8xkR6F+t+4pftsE8sggbfwiV4Fpnv+fVmSD2hH+k3ANnuvJZaR5TqGSkII/X5VbEDT8zxAvhANl2RxCX79rpvs6dAxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=W3rAlhxJ; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777662943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aZTnlY5rMUFLFpKCnynYscYfLDvISS8pawK9mtIdKuo=;
	b=W3rAlhxJx2U7XYnoZ9aldOsrBOHcDFGOkko0MXn/2550DE7rU5OKAmtRNoygcICxIn+Q0g
	bPmnywJmTI05gGHoFdQs82i5M7BBF8twyKItUTHyHu/AYaGKSieT0N+uWVuofXb0py1rSL
	LRakrPWOhwiVIAwveH6qcPh38dZ5Nl4c0WhD0SUWhBdU56Fe697aG2+reFb7fwGzrq/Odc
	cnloiWpf92d5LKShJCpreC8xgYxNOQx7sTJD1Xt0cQcqjnEf3mcBbC2ZMep6Uq2FSj7kFk
	uvaOdN0qZPinBUjWrMNctfEBbH90WjsOsoBWevXW6nrV9BjIUb5jeoYfr+s3CA==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-70-3FsRycHWPcGKTFxAG_ILHA-2; Fri, 01 May 2026 12:15:39 -0700
X-MC-Unique: 3FsRycHWPcGKTFxAG_ILHA-2
X-Mimecast-MFC-AGG-ID: 3FsRycHWPcGKTFxAG_ILHA_1777662938
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB8595.namprd02.prod.outlook.com (2603:10b6:a03:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 19:15:35 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 19:15:35 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/5] net: ethernet: oa_tc6: hardware timestamp
 support added
Thread-Topic: [PATCH net-next 3/5] net: ethernet: oa_tc6: hardware timestamp
 support added
Thread-Index: AdzZlabyiWw8fhBTRtamGuGOU3Hwew==
Date: Fri, 1 May 2026 19:15:35 +0000
Message-ID: <CY8PR02MB924976A9160ED3FB0883911583322@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Enabled=True;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SiteId=04e1674b-7af5-4d13-a082-64fc6e42384c;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SetDate=2026-05-01T18:44:36.0000000Z;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Name=Public
 Information;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_ContentBits=3;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB8595:EE_
x-ms-office365-filtering-correlation-id: 8aac31f8-0dc4-4926-c6f1-08dea7b605ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003
x-microsoft-antispam-message-info: hqb82B/SLmziWT0bFxKQ7cxudL37w6g1XnBdsjxhzQpSiOe2oif68iJHMnYO7BpRki4j2q8KPldKcLBzHa4bc24YCUjvMWV5xfdiTNJNW1aWQgSdNm57KAeJC6lbLK1KB0Hftpxq66x8rvWk4RAMLZ84CdXbdoVV1dUWiILDSfaf77m8feCyFqX8YKNohrKIBpuyK3R1mH655cL5negTii3wCj3BwysyjKOGzRwywxlhQ8D0E3EA9a9fkb5P7PD8zSj51MVT/XHVYVDz9FtEJTrWmHb98HBxegqdx2JHJtDFJtio8NV2Lnt9xqpGXqnUJnCWLdtOXZNi5I3qqadf6aQ1A2nCUx9XtlbINjQss6wm+oNhKPTI70OgD2ktZdCOlkL6jdN03rigJrIrcRkeTy3KrMoyBgCIyBsNnWiN8TLwOyiv2ECpU29TQb9sZQ64BW+s+NJ2LgMZsH993/3eYtb4a9hEz6m5p9sduAHSlbWgujFlrHro0UVg/vVLUAy1EnkK6a1INXVIKsEaGn9R1n3LxxCE8I0KGuRIkNldrWl+IEspecbzeWk2QQ8TG1nW6wE3Rikp2QA86rkUOFKprcsqH6jgwMG8EkuVCdcrYKPUjpLpysEevKhE3xdljrayhlynE+GEzT6dQ+oEIfPyFZyBgnLREK8nnr5LFEkHA+5eOyU45xn91STBnnekCU0CTrt7Sa4ONU0W0kn6v8cOJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?16R3gd9FTZwpCkMqTxlA4lziMs7TxJA40PC0Jdrb+MFbo2cDzMaIZ2tTcGFk?=
 =?us-ascii?Q?vSUUBl099tsiNcMLW8RyAXlDrT8jsuivnVXBFWp9pD0Qzm3F7+YpScQpUHG6?=
 =?us-ascii?Q?AdUTQKY6dz2XnWxuDzZFRd3x+mFhjcDxepsHJ1c1Bdds4wHF17TgBwcgzcmW?=
 =?us-ascii?Q?KGcqCb7/WpHvlA4mXMuuoqZVBZ97WW5pbb+Ihubb+oRHHhJI/zhAqKYqZLeC?=
 =?us-ascii?Q?d7Jf4asLol6pYOhbjwqAXaH4xCi9CrIYzCPcS55eurS5mO01lMDs6tbIG0cn?=
 =?us-ascii?Q?RtMHjzU/3jhm4zGdj+RYKMwhwqG1rt9ODgHZinfUlTV8G5DpwJYRnn1rhaBW?=
 =?us-ascii?Q?abJuDKpgxZogC262Ppx1aXSVIH5zejMaYRNUPtWOc+Bwtr0u1/228DW5C4cf?=
 =?us-ascii?Q?+CtEG4yrN+2OOUot443rXU7rb6bOyEVPUoTEZeddhuqWqPmAZF5zIJfi4URg?=
 =?us-ascii?Q?Qy2xMI1ocTCUkivlaKmESl37uKEM/VJR0Q5QOWP9fiYytPe/6JllMswJV8tm?=
 =?us-ascii?Q?o0VyT19l6qr5hkKrbDBbMRXSwASRAj1+JPlQopjwmohn8J3LQGGscvDAa196?=
 =?us-ascii?Q?pPs3BLPEI159Lx13Lthxsuh7ialKfhETrDA4oIDT1ANxn87ZBUQ9IzicGLoC?=
 =?us-ascii?Q?AdW8CSFatPi/QbpaykSWs8plkCsTfsE/c0qqY3iOlhNfwW1uiGupg+RtK7Qr?=
 =?us-ascii?Q?Q0s5o9YLsg3O0J0pWw9nR5nDouawQImqwtTwlxE4caQ1lBa2Tr/cw2BsajYc?=
 =?us-ascii?Q?WCrAasX8ebIb/PZW1M2fH3Qk0TsGFDqV2iaixPFByGnliMVgoLYHWB1ltP7N?=
 =?us-ascii?Q?cCfQclD00YpdNQ+ZoivbaBZzAn1WuDeJrUIqsHum+yXaIOlsNRCCY+P5FUda?=
 =?us-ascii?Q?P0t+ehgZ0yiflCi2k6pZZNyyESZ3KH1Wgy4ajoPXGk5O1y9bcdyDmfoMvmC1?=
 =?us-ascii?Q?7MSvKkdlTEUVbsUZV8K1dukMdAt3aj/PiKF24ZFYkhkuAD0+VSNbCRGTvuI+?=
 =?us-ascii?Q?4JZsc9jfSBJHOjlaicfI7yvZeyG/2LrkXCMUDBkKvCbhzvpXvkfuDsw9Sqsa?=
 =?us-ascii?Q?s861+nceXl26BN0LfalePC06h69POiGknoMXotKnaAP3xS2m5uSt2geKxiuB?=
 =?us-ascii?Q?6HZoQRP0PmCemOPHODF4GGiz7chDNDzGaym7q6PH5hF0hrrbIZDrLYtYDUXe?=
 =?us-ascii?Q?f5udGYEiF4XGW2j/5N8eZlHqw5MaJh2Y9cO6G1pcJPmFSRT4gA0gcd+ldGYl?=
 =?us-ascii?Q?kaMytGz5vvgDoP7QSAII77x9o/lDeOALJcz1mXuRg/MtLg9jQhSt8x2p2fo7?=
 =?us-ascii?Q?5NqIYAX+6UCwfLzpxcviRookIOwwUMHx59D9/54utrX5sC130xBAO3exRMdW?=
 =?us-ascii?Q?kntv/g1yWNZd2uCX+dFrwx4hg/wSwU00EHzo5bJhn38H8ZTI5qd+h5u0oX/i?=
 =?us-ascii?Q?/h9y3BwEEqnyIR4Yw4TmyZMFaCiqqsbZrO5w2/tizFfMzx07+KRFLmF/s9E9?=
 =?us-ascii?Q?j2sr0Yfg1M3nIhqxBZYzroQ3gW6bmH6EudLtMfavjIOyjdciISLa18vm3uAX?=
 =?us-ascii?Q?oI9XNVV7a6ZPTeS66vJyg17B5cizFwmh2mXVfmlWsXQW+pfqX8oN5TyFOSl2?=
 =?us-ascii?Q?mCsX74E2szr1gALdpUVebUpPw3q8VkkRkhWrHgiF5YA4eEB4pFPhJtgRL7Dc?=
 =?us-ascii?Q?d/DKU316EtWLNU6zYRw35GwDii/scxcXwOEppoqyZ221YngeSTP5r9HmrO+e?=
 =?us-ascii?Q?PzrGXMWcPQ=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iowJCMn54TbLBYRe7Zsp3d1w25A1joznjX1mAr/AZ0omk4IoJ/IcebVk9vYTEWgRemh2zWrDtGJW7EbvbP3xt+7yVBRNStU+AiG56QuxFBUe/UFi21jL2SW1fgzV6liLudRNqn0stfem7axfuna0Fs3VBgtcmsNvsgQazzwhj8HHqnNl/LQ3zqlyDi2dbQgiTo4b4tl7fYaME5Klj30xBea/OyIuh5uMGtviosmIACuBnYVQhnUznWEehW+Snb/hhcmZZ3qTxdEDz2HsuSjm45oR7BQUZJLAe75Y4kLkILAIMdUFplfbSJVtn+uTkD9DWfjjEojjSDMF+bBAwn+jMQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aac31f8-0dc4-4926-c6f1-08dea7b605ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 19:15:35.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQUqffx+qpt3XK+PxR8u5TBs/ntcpK2FFKE+yv0MFxJdUc6JHlhfM9O2gIL9izTL8d/O09EKF/egmrskh2+StZfGZQFpDXRAb9QeIq1XKBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8595
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aCs8qrfDH4wgWkT3Q6ixWiUL3RuPCYVkIArLIK_URUk_1777662938
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 024D64AF1A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283275-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,onsemi.com:dkim,onsemi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,stanford.edu:url]

mii_bus structure can be allocated/populated from vendor's code
to accommodate vendor side customization.

Timestamp support implemented following OPEN Alliance 10BASE-T1x
MACPHY Serial Interface specification.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

removed doc from OA TC6 sources

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 385 ++++++++++++++++++++++++++++++----
 include/linux/oa_tc6.h        |  26 ++-
 2 files changed, 371 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a79..092b41cb5 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -24,9 +24,16 @@
 #define OA_TC6_REG_CONFIG0                     0x0004
 #define CONFIG0_SYNC                           BIT(15)
 #define CONFIG0_ZARFE_ENABLE                   BIT(12)
+#define CONFIG0_FTSE_ENABLE                    BIT(7)
+#define CONFIG0_FTSS_ENABLE                    BIT(6)
+#define CONFIG0_FTS_ENABLE_MASK                        GENMASK(7, 6)

 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0                     0x0008
+#define STATUS0_TTSCAC                         BIT(10)
+#define STATUS0_TTSCAB                         BIT(9)
+#define STATUS0_TTSCAA                         BIT(8)
+#define STATUS0_TTSCA_MASK             GENMASK(10, 8)
 #define STATUS0_RESETC                         BIT(6)  /* Reset Complete *=
/
 #define STATUS0_HEADER_ERROR                   BIT(5)
 #define STATUS0_LOSS_OF_FRAME_ERROR            BIT(4)
@@ -40,10 +47,14 @@

 /* Interrupt Mask Register #0 */
 #define OA_TC6_REG_INT_MASK0                   0x000C
+#define INT_MASK0_TTSCACM                      BIT(10)
+#define INT_MASK0_TTSCABM                      BIT(9)
+#define INT_MASK0_TTSCAAM                      BIT(8)
 #define INT_MASK0_HEADER_ERR_MASK              BIT(5)
 #define INT_MASK0_LOSS_OF_FRAME_ERR_MASK       BIT(4)
 #define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK  BIT(3)
 #define INT_MASK0_TX_PROTOCOL_ERR_MASK         BIT(0)
+#define INT_MASK0_TTSCA_MASK                   GENMASK(10, 8)

 /* PHY Clause 22 registers base address and mask */
 #define OA_TC6_PHY_STD_REG_ADDR_BASE           0xFF00
@@ -64,6 +75,7 @@
 #define OA_TC6_DATA_HEADER_START_WORD_OFFSET   GENMASK(19, 16)
 #define OA_TC6_DATA_HEADER_END_VALID           BIT(14)
 #define OA_TC6_DATA_HEADER_END_BYTE_OFFSET     GENMASK(13, 8)
+#define OA_TC6_DATA_HEADER_TSC_OFFSET          GENMASK(7, 6)
 #define OA_TC6_DATA_HEADER_PARITY              BIT(0)

 /* Data footer */
@@ -75,18 +87,11 @@
 #define OA_TC6_DATA_FOOTER_START_VALID         BIT(20)
 #define OA_TC6_DATA_FOOTER_START_WORD_OFFSET   GENMASK(19, 16)
 #define OA_TC6_DATA_FOOTER_END_VALID           BIT(14)
+#define OA_TC6_DATA_FOOTER_RTSA_VALID          BIT(7)
+#define OA_TC6_DATA_FOOTER_RTSP_VALID          BIT(6)
 #define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET     GENMASK(13, 8)
 #define OA_TC6_DATA_FOOTER_TX_CREDITS          GENMASK(5, 1)

-/* PHY - Clause 45 registers memory map selector (MMS) as per table 6 in t=
he
- * OPEN Alliance specification.
- */
-#define OA_TC6_PHY_C45_PCS_MMS2                        2       /* MMD 3 */
-#define OA_TC6_PHY_C45_PMA_PMD_MMS3            3       /* MMD 1 */
-#define OA_TC6_PHY_C45_VS_PLCA_MMS4            4       /* MMD 31 */
-#define OA_TC6_PHY_C45_AUTO_NEG_MMS5           5       /* MMD 7 */
-#define OA_TC6_PHY_C45_POWER_UNIT_MMS6         6       /* MMD 13 */
-
 #define OA_TC6_CTRL_HEADER_SIZE                        4
 #define OA_TC6_CTRL_REG_VALUE_SIZE             4
 #define OA_TC6_CTRL_IGNORED_SIZE               4
@@ -105,9 +110,25 @@
 #define STATUS0_RESETC_POLL_DELAY              1000
 #define STATUS0_RESETC_POLL_TIMEOUT            1000000

+#define OA_TC6_REG_TTSCA_HIGH                  (0x1010)
+#define OA_TC6_TSTAMP_SZ                       8
+
+#define OA_TC6_TTSCA_REG_ID                    1
+#define OA_TC6_TTSCB_REG_ID                    2
+#define OA_TC6_TTSCC_REG_ID                    3
+
+struct oa_tc6_ts_info_rx {
+       bool rtsa;
+       bool rtsp;
+};
+
+struct oa_tc6_ts_info_tx {
+       u8 tsc;
+};
+
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
-       struct device *dev;
+       void *priv;  /* Vendor's private driver data structure */
        struct net_device *netdev;
        struct phy_device *phydev;
        struct mii_bus *mdiobus;
@@ -129,6 +150,9 @@ struct oa_tc6 {
        u8 rx_chunks_available;
        bool rx_buf_overflow;
        bool int_flag;
+       u8 tx_ts_idx;
+       struct hwtstamp_config ts_config;
+       struct list_head tx_ts_skb_q;
 };

 enum oa_tc6_header_type {
@@ -156,6 +180,210 @@ enum oa_tc6_data_end_valid_info {
        OA_TC6_DATA_END_VALID,
 };

+static inline struct oa_tc6_ts_info_tx *oa_tc6_tsinfo_tx(struct sk_buff *s=
kb)
+{
+       return (struct oa_tc6_ts_info_tx *)((skb)->cb);
+}
+
+static inline struct oa_tc6_ts_info_rx *oa_tc6_tsinfo_rx(struct sk_buff *s=
kb)
+{
+       return (struct oa_tc6_ts_info_rx *)((skb)->cb);
+}
+
+static void oa_tc6_defer_for_hwtstamp(struct oa_tc6 *tc6, struct sk_buff *=
skb)
+{
+       if (tc6->ts_config.tx_type !=3D HWTSTAMP_TX_ON || !skb ||
+           (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) =3D=3D 0)
+               return;
+
+       skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
+       u8 ret =3D tc6->tx_ts_idx++;
+
+       if (ret =3D=3D OA_TC6_TTSCC_REG_ID)
+               tc6->tx_ts_idx =3D OA_TC6_TTSCA_REG_ID;
+       oa_tc6_tsinfo_tx(skb)->tsc =3D ret;
+
+       list_add_tail(&skb->list, &tc6->tx_ts_skb_q);
+}
+
+static int oa_tc6_process_deferred_skb(struct oa_tc6 *tc6, u8 tsc)
+{
+       struct skb_shared_hwtstamps tstamp;
+       struct oa_tc6_ts_info_tx *ski;
+       struct sk_buff *skb, *tmp;
+       bool found =3D false;
+       int ret =3D 0;
+
+       /* Size of data must match OA_TC6_TSTAMP_SZ */
+       u32 data[2];
+
+       list_for_each_entry_safe(skb, tmp, &tc6->tx_ts_skb_q, list) {
+               ski =3D oa_tc6_tsinfo_tx(skb);
+               if (ski->tsc !=3D tsc)
+                       continue;
+               if (found)
+                       dev_warn(&tc6->spi->dev, "Multiple skb with tsc =3D=
 %d\n", tsc);
+               found =3D true;
+               list_del(&skb->list);
+
+               // Retrieve the timestamping info
+               ret =3D oa_tc6_read_registers(tc6,
+                                           OA_TC6_REG_TTSCA_HIGH +
+                                           2 * (tsc - 1), &data[0], 2);
+
+               if (!ret) {
+                       tstamp.hwtstamp =3D ktime_set(data[0], data[1]);
+                       skb_tstamp_tx(skb, &tstamp);
+               }
+
+               dev_kfree_skb(skb);
+       }
+       return ret;
+}
+
+static int oa_tc6_set_hwtstamp_settings(struct oa_tc6 *tc6)
+{
+       u32 cfg0, irqm, status0;
+       int ret;
+
+       ret =3D oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &cfg0);
+       if (ret) {
+               dev_err(&tc6->spi->dev, "Failed to read CFG0 register\n");
+               goto out;
+       }
+
+       ret =3D oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &irqm);
+       if (ret) {
+               dev_err(&tc6->spi->dev, "failed to read IRQM register\n");
+               goto out;
+       }
+
+       if (tc6->ts_config.tx_type =3D=3D HWTSTAMP_TX_ON ||
+           tc6->ts_config.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
+               cfg0 |=3D CONFIG0_FTS_ENABLE_MASK;
+       else
+               cfg0 &=3D ~CONFIG0_FTS_ENABLE_MASK;
+
+       if (tc6->ts_config.tx_type =3D=3D HWTSTAMP_TX_ON)
+               irqm &=3D ~INT_MASK0_TTSCA_MASK;
+       else
+               irqm |=3D INT_MASK0_TTSCA_MASK;
+
+       /* Clear timestamp related IRQs */
+       status0 =3D STATUS0_TTSCA_MASK;
+       ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, status0);
+       if (ret) {
+               dev_err(&tc6->spi->dev, "failed to write STATUS0 register\n=
");
+               goto out;
+       }
+
+       // apply configuration
+       ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, irqm);
+       if (ret) {
+               dev_err(&tc6->spi->dev, "failed to write IRQM register\n");
+               goto out;
+       }
+
+       ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, cfg0);
+       if (ret) {
+               dev_err(&tc6->spi->dev, "failed to write CFG0 register\n");
+               goto out;
+       }
+out:
+       return ret;
+}
+
+/**
+ * oa_tc6_hwtstamp_get - gets hardware timestamp config
+ * @tc6: oa_tc6 struct.
+ * @cfg: kernel copy of hardware timestamp config
+ */
+void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, struct kernel_hwtstamp_config=
 *cfg)
+{
+       cfg->tx_type =3D tc6->ts_config.tx_type;
+       cfg->rx_filter =3D tc6->ts_config.rx_filter;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_get);
+
+/**
+ * oa_tc6_hwtstamp_set - sets hardware timestamp config
+ * @tc6: oa_tc6 struct.
+ * @cfg: kernel copy of hardware timestamp config
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, struct kernel_hwtstamp_config =
*cfg)
+{
+       switch (cfg->tx_type) {
+       case HWTSTAMP_TX_OFF:
+       case HWTSTAMP_TX_ON:
+               break;
+       default:
+               return -ERANGE;
+       }
+       tc6->ts_config.tx_type =3D cfg->tx_type;
+       if (cfg->rx_filter =3D=3D HWTSTAMP_FILTER_NONE)
+               tc6->ts_config.rx_filter =3D cfg->rx_filter;
+       else
+               tc6->ts_config.rx_filter =3D HWTSTAMP_FILTER_ALL;
+       return oa_tc6_set_hwtstamp_settings(tc6);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_set);
+
+/**
+ * oa_tc6_hwtstamp_ioctl - ioctl interface for hardware timestamp
+ * @tc6: oa_tc6 struct.
+ * @rq: request from socket interface
+ * @cmd: value to set/get timestamp configuration
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_hwtstamp_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd)
+{
+       struct kernel_hwtstamp_config kcfg;
+       struct hwtstamp_config tscfg;
+       int ret =3D 0;
+
+       switch (cmd) {
+       case SIOCSHWTSTAMP:
+               if (copy_from_user(&tscfg, rq->ifr_data, sizeof(tscfg)))
+                       return -EFAULT;
+
+               if (tscfg.flags)
+                       return -EINVAL;
+               memset(&kcfg, 0, sizeof(kcfg));
+               kcfg.tx_type =3D tscfg.tx_type;
+               kcfg.rx_filter =3D tscfg.rx_filter;
+
+               ret =3D oa_tc6_hwtstamp_set(tc6, &kcfg);
+               break;
+
+       case SIOCGHWTSTAMP:
+               break;
+       default:
+               return -EOPNOTSUPP;
+       }
+       if (copy_to_user(rq->ifr_data, &tc6->ts_config,
+                        sizeof(tc6->ts_config)))
+               ret =3D -EFAULT;
+
+       return ret;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_ioctl);
+
+static void oa_tc6_events_handle(struct oa_tc6 *tc6, u32 val)
+{
+       /* check TX timestamping */
+       if (val & STATUS0_TTSCAA)
+               oa_tc6_process_deferred_skb(tc6, OA_TC6_TTSCA_REG_ID);
+
+       if (val & STATUS0_TTSCAB)
+               oa_tc6_process_deferred_skb(tc6, OA_TC6_TTSCB_REG_ID);
+
+       if (val & STATUS0_TTSCAC)
+               oa_tc6_process_deferred_skb(tc6, OA_TC6_TTSCC_REG_ID);
+}
+
 static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
                               enum oa_tc6_header_type header_type, u16 len=
gth)
 {
@@ -177,7 +405,7 @@ static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
        return spi_sync(tc6->spi, &msg);
 }

-static int oa_tc6_get_parity(u32 p)
+static u32 oa_tc6_get_parity(u32 p)
 {
        /* Public domain code snippet, lifted from
         * http://www-graphics.stanford.edu/~seander/bithacks.html
@@ -422,7 +650,7 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int=
 addr, int regnum)
 {
        struct oa_tc6 *tc6 =3D bus->priv;
        u32 regval;
-       bool ret;
+       int ret;

        ret =3D oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
                                   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
@@ -496,15 +724,20 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6=
)
 {
        int ret;

-       tc6->mdiobus =3D mdiobus_alloc();
+       /* If vendor didn't provide mdiobus APIs, generic APIs are used */
        if (!tc6->mdiobus) {
-               netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
-               return -ENOMEM;
+               tc6->mdiobus =3D mdiobus_alloc();
+               if (!tc6->mdiobus) {
+                       netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
+                       return -ENOMEM;
+               }
+               tc6->mdiobus->read =3D oa_tc6_mdiobus_read;
+               tc6->mdiobus->write =3D oa_tc6_mdiobus_write;
+               tc6->mdiobus->read_c45 =3D oa_tc6_mdiobus_read_c45;
+               tc6->mdiobus->write_c45 =3D oa_tc6_mdiobus_write_c45;
+               tc6->mdiobus->name =3D "oa-tc6-mdiobus";
        }

-       tc6->mdiobus->priv =3D tc6;
-       tc6->mdiobus->read =3D oa_tc6_mdiobus_read;
-       tc6->mdiobus->write =3D oa_tc6_mdiobus_write;
        /* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 =
and
         * C45 registers space. If the PHY is discovered via C22 bus protoc=
ol it
         * assumes it uses C22 protocol and always uses C22 registers indir=
ect
@@ -515,10 +748,8 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
         * drivers can set .read_mmd/.write_mmd in the PHY driver to call
         * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
         */
-       tc6->mdiobus->read_c45 =3D oa_tc6_mdiobus_read_c45;
-       tc6->mdiobus->write_c45 =3D oa_tc6_mdiobus_write_c45;
-       tc6->mdiobus->name =3D "oa-tc6-mdiobus";
-       tc6->mdiobus->parent =3D tc6->dev;
+       tc6->mdiobus->priv =3D tc6;
+       tc6->mdiobus->parent =3D &tc6->spi->dev;

        snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
                 dev_name(&tc6->spi->dev));
@@ -583,7 +814,7 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
        oa_tc6_mdiobus_unregister(tc6);
 }

-static int oa_tc6_read_status0(struct oa_tc6 *tc6)
+static u32 oa_tc6_read_status0(struct oa_tc6 *tc6)
 {
        u32 regval;
        int ret;
@@ -681,6 +912,9 @@ static int oa_tc6_process_extended_status(struct oa_tc6=
 *tc6)
                return ret;
        }

+       if ((value & STATUS0_TTSCA_MASK) !=3D 0)
+               oa_tc6_events_handle(tc6, value & STATUS0_TTSCA_MASK);
+
        /* Clear the error interrupts status */
        ret =3D oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, value);
        if (ret) {
@@ -750,12 +984,42 @@ static int oa_tc6_process_rx_chunk_footer(struct oa_t=
c6 *tc6, u32 footer)
        return 0;
 }

+static void oa_tc6_update_ts_in_rx_skb(struct oa_tc6 *tc6)
+{
+       struct sk_buff *skb =3D tc6->rx_skb;
+       struct oa_tc6_ts_info_rx *ski;
+       u32 ts[2];
+
+       ski =3D oa_tc6_tsinfo_rx(skb);
+       if (!ski->rtsa)
+               return;
+
+       ts[0] =3D be32_to_cpu(*((u32 *)(skb->data)));
+       ts[1] =3D be32_to_cpu(*((u32 *)(skb->data) + 1));
+
+       /* Check parity */
+       if ((oa_tc6_get_parity(ts[0]) ^ oa_tc6_get_parity(ts[1])) =3D=3D
+           !ski->rtsp) {
+               struct skb_shared_hwtstamps *hw_ts;
+               /* Report timestamp to the upper layers */
+               hw_ts =3D skb_hwtstamps(skb);
+               memset(hw_ts, 0, sizeof(*hw_ts));
+               hw_ts->hwtstamp =3D ktime_set(ts[0], ts[1]);
+       }
+       skb_pull(skb, sizeof(ts));
+}
+
 static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 {
+       oa_tc6_update_ts_in_rx_skb(tc6);
+
        tc6->rx_skb->protocol =3D eth_type_trans(tc6->rx_skb, tc6->netdev);
        tc6->netdev->stats.rx_packets++;
        tc6->netdev->stats.rx_bytes +=3D tc6->rx_skb->len;

+       if ((tc6->netdev->hw_features & NETIF_F_RXFCS) !=3D 0)
+               skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
        netif_rx(tc6->rx_skb);

        tc6->rx_skb =3D NULL;
@@ -766,24 +1030,29 @@ static void oa_tc6_update_rx_skb(struct oa_tc6 *tc6,=
 u8 *payload, u8 length)
        memcpy(skb_put(tc6->rx_skb, length), payload, length);
 }

-static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
+static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6, u32 footer)
 {
+       struct oa_tc6_ts_info_rx *ski;
+
        tc6->rx_skb =3D netdev_alloc_skb_ip_align(tc6->netdev, tc6->netdev-=
>mtu +
-                                               ETH_HLEN + ETH_FCS_LEN);
+                                               ETH_HLEN + ETH_FCS_LEN + OA=
_TC6_TSTAMP_SZ);
        if (!tc6->rx_skb) {
                tc6->netdev->stats.rx_dropped++;
                return -ENOMEM;
        }

+       ski =3D oa_tc6_tsinfo_rx(tc6->rx_skb);
+       ski->rtsa =3D FIELD_GET(OA_TC6_DATA_FOOTER_RTSA_VALID, footer);
+       ski->rtsp =3D FIELD_GET(OA_TC6_DATA_FOOTER_RTSP_VALID, footer);
        return 0;
 }

 static int oa_tc6_prcs_complete_rx_frame(struct oa_tc6 *tc6, u8 *payload,
-                                        u16 size)
+                                        u16 size, u32 footer)
 {
        int ret;

-       ret =3D oa_tc6_allocate_rx_skb(tc6);
+       ret =3D oa_tc6_allocate_rx_skb(tc6, footer);
        if (ret)
                return ret;

@@ -794,11 +1063,11 @@ static int oa_tc6_prcs_complete_rx_frame(struct oa_t=
c6 *tc6, u8 *payload,
        return 0;
 }

-static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16=
 size)
+static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16=
 size, u32 footer)
 {
        int ret;

-       ret =3D oa_tc6_allocate_rx_skb(tc6);
+       ret =3D oa_tc6_allocate_rx_skb(tc6, footer);
        if (ret)
                return ret;

@@ -843,7 +1112,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 =
*tc6, u8 *data,
                size =3D end_byte_offset + 1 - start_byte_offset;
                return oa_tc6_prcs_complete_rx_frame(tc6,
                                                     &data[start_byte_offse=
t],
-                                                    size);
+                                                    size, footer);
        }

        /* Process the chunk with only rx frame start */
@@ -851,7 +1120,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 =
*tc6, u8 *data,
                size =3D OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
                return oa_tc6_prcs_rx_frame_start(tc6,
                                                  &data[start_byte_offset],
-                                                 size);
+                                                 size, footer);
        }

        /* Process the chunk with only rx frame end */
@@ -876,7 +1145,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 =
*tc6, u8 *data,
                size =3D OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
                return oa_tc6_prcs_rx_frame_start(tc6,
                                                  &data[start_byte_offset],
-                                                 size);
+                                                 size, footer);
        }

        /* Process the chunk with ongoing rx frame data */
@@ -930,13 +1199,15 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_=
tc6 *tc6, u16 length)
 }

 static __be32 oa_tc6_prepare_data_header(bool data_valid, bool start_valid=
,
-                                        bool end_valid, u8 end_byte_offset=
)
+                                        bool end_valid, u8 end_byte_offset=
,
+                                        u8 tsc)
 {
        u32 header =3D FIELD_PREP(OA_TC6_DATA_HEADER_DATA_NOT_CTRL,
                                OA_TC6_DATA_HEADER) |
                     FIELD_PREP(OA_TC6_DATA_HEADER_DATA_VALID, data_valid) =
|
                     FIELD_PREP(OA_TC6_DATA_HEADER_START_VALID, start_valid=
) |
                     FIELD_PREP(OA_TC6_DATA_HEADER_END_VALID, end_valid) |
+                    FIELD_PREP(OA_TC6_DATA_HEADER_TSC_OFFSET, tsc) |
                     FIELD_PREP(OA_TC6_DATA_HEADER_END_BYTE_OFFSET,
                                end_byte_offset);

@@ -955,6 +1226,7 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc6=
 *tc6)
        enum oa_tc6_data_start_valid_info start_valid;
        u8 end_byte_offset =3D 0;
        u16 length_to_copy;
+       u8 tsc =3D 0;

        /* Initial value is assigned here to avoid more than 80 characters =
in
         * the declaration place.
@@ -964,8 +1236,10 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc=
6 *tc6)
        /* Set start valid if the current tx chunk contains the start of th=
e tx
         * ethernet frame.
         */
-       if (!tc6->tx_skb_offset)
+       if (!tc6->tx_skb_offset) {
                start_valid =3D OA_TC6_DATA_START_VALID;
+               tsc =3D oa_tc6_tsinfo_tx(tc6->ongoing_tx_skb)->tsc;
+       }

        /* If the remaining tx skb length is more than the chunk payload si=
ze of
         * 64 bytes then copy only 64 bytes and leave the ongoing tx skb fo=
r
@@ -986,12 +1260,17 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_t=
c6 *tc6)
                tc6->tx_skb_offset =3D 0;
                tc6->netdev->stats.tx_bytes +=3D tc6->ongoing_tx_skb->len;
                tc6->netdev->stats.tx_packets++;
-               kfree_skb(tc6->ongoing_tx_skb);
+
+               /* Free the ones that are not saved for later processing,
+                * like timestamping.
+                */
+               if (!(skb_shinfo(tc6->ongoing_tx_skb)->tx_flags & SKBTX_IN_=
PROGRESS))
+                       kfree_skb(tc6->ongoing_tx_skb);
                tc6->ongoing_tx_skb =3D NULL;
        }

        *tx_buf =3D oa_tc6_prepare_data_header(OA_TC6_DATA_VALID, start_val=
id,
-                                            end_valid, end_byte_offset);
+                                            end_valid, end_byte_offset, ts=
c);
        tc6->spi_data_tx_buf_offset +=3D OA_TC6_CHUNK_SIZE;
 }

@@ -1009,6 +1288,8 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(stru=
ct oa_tc6 *tc6)
                        tc6->ongoing_tx_skb =3D tc6->waiting_tx_skb;
                        tc6->waiting_tx_skb =3D NULL;
                        spin_unlock_bh(&tc6->tx_skb_lock);
+                       oa_tc6_defer_for_hwtstamp(tc6,
+                                                 tc6->ongoing_tx_skb);
                }
                if (!tc6->ongoing_tx_skb)
                        break;
@@ -1025,7 +1306,7 @@ static void oa_tc6_add_empty_chunks_to_spi_buf(struct=
 oa_tc6 *tc6,

        header =3D oa_tc6_prepare_data_header(OA_TC6_DATA_INVALID,
                                            OA_TC6_DATA_START_INVALID,
-                                           OA_TC6_DATA_END_INVALID, 0);
+                                           OA_TC6_DATA_END_INVALID, 0, fal=
se);

        while (needed_empty_chunks--) {
                __be32 *tx_buf =3D tc6->spi_data_tx_buf +
@@ -1071,7 +1352,11 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc=
6)

                if (tc6->int_flag) {
                        tc6->int_flag =3D false;
-                       if (spi_len =3D=3D 0) {
+
+                       /* If nothing to transmit and interface isn't up,
+                        * avoid sending empty chunks.
+                        */
+                       if (spi_len =3D=3D 0 && netif_running(tc6->netdev))=
 {
                                oa_tc6_add_empty_chunks_to_spi_buf(tc6, 1);
                                spi_len =3D OA_TC6_CHUNK_SIZE;
                        }
@@ -1216,6 +1501,7 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, str=
uct sk_buff *skb)
        spin_lock_bh(&tc6->tx_skb_lock);
        tc6->waiting_tx_skb =3D skb;
        spin_unlock_bh(&tc6->tx_skb_lock);
+       oa_tc6_tsinfo_tx(skb)->tsc =3D 0;

        /* Wake spi kthread to perform spi transfer */
        wake_up_interruptible(&tc6->spi_wq);
@@ -1226,13 +1512,17 @@ EXPORT_SYMBOL_GPL(oa_tc6_start_xmit);

 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
+ * @priv: vendor driver's private structure
  * @spi: device with which data will be exchanged.
  * @netdev: network device interface structure.
+ * @bus: vendor allocated mii_bus structure. Can be NULL.
  *
  * Return: pointer reference to the oa_tc6 structure if the MAC-PHY
  * initialization is successful otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netd=
ev)
+struct oa_tc6 *oa_tc6_init(void *priv, struct spi_device *spi,
+                          struct net_device *netdev,
+                          struct mii_bus *bus)
 {
        struct oa_tc6 *tc6;
        int ret;
@@ -1241,11 +1531,15 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, =
struct net_device *netdev)
        if (!tc6)
                return NULL;

+       tc6->priv =3D priv;
+       tc6->mdiobus =3D bus;
+       tc6->tx_ts_idx =3D OA_TC6_TTSCA_REG_ID;
        tc6->spi =3D spi;
        tc6->netdev =3D netdev;
        SET_NETDEV_DEV(netdev, &spi->dev);
        mutex_init(&tc6->spi_ctrl_lock);
        spin_lock_init(&tc6->tx_skb_lock);
+       INIT_LIST_HEAD(&tc6->tx_ts_skb_q);

        /* Set the SPI controller to pump at realtime priority */
        tc6->spi->rt =3D true;
@@ -1350,6 +1644,19 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, s=
truct net_device *netdev)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);

+/**
+ * oa_tc6_priv - get vendor private structure
+ * @tc6: oa_tc6 struct
+ *
+ * Return: pointer reference to the vendor's private structure.
+ *         Must be called after successful call to oa_tc6_init.
+ */
+void *oa_tc6_priv(struct oa_tc6 *tc6)
+{
+       return tc6->priv;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_priv);
+
 /**
  * oa_tc6_exit - exit function.
  * @tc6: oa_tc6 struct.
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 15f58e3c5..5f5822282 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -7,12 +7,27 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */

+#ifndef _LINUX_OA_TC6_H
+#define _LINUX_OA_TC6_H
+
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
+#include <linux/phy.h>
+
+/* PHY - Clause 45 registers memory map selector (MMS) as per table 6 in t=
he
+ * OPEN Alliance specification.
+ */
+#define OA_TC6_PHY_C45_PCS_MMS2                 2       /* MMD 3 */
+#define OA_TC6_PHY_C45_PMA_PMD_MMS3             3       /* MMD 1 */
+#define OA_TC6_PHY_C45_VS_PLCA_MMS4             4       /* MMD 31 */
+#define OA_TC6_PHY_C45_AUTO_NEG_MMS5            5       /* MMD 7 */
+#define OA_TC6_PHY_C45_POWER_UNIT_MMS6          6       /* MMD 13 */

 struct oa_tc6;

-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netd=
ev);
+struct oa_tc6 *oa_tc6_init(void *priv, struct spi_device *spi,
+                          struct net_device *netdev,
+                          struct mii_bus *bus);
 void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
@@ -22,3 +37,12 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 addres=
s, u32 value[],
                          u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+int oa_tc6_hwtstamp_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd);
+int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
+                       struct kernel_hwtstamp_config *cfg);
+void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6,
+                        struct kernel_hwtstamp_config *cfg);
+void *oa_tc6_priv(struct oa_tc6 *tc6);
+
+#endif /* _LINUX_OA_TC6_H */
+
--
2.43.0


Public Information


