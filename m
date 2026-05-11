Return-Path: <netdev+bounces-286784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBrKDp4eAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB551451F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9717030B3D8E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF847CC92;
	Mon, 11 May 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="c6Z/9nOi"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624E747CC94
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523604; cv=none; b=f6ndw4QczpBFWcPAg6TS3aHD+XT+yzTjA5jrwCf4liPlBV7cxffwd+Vv24R25z0sN485TncDXRK8y0bi7OFc7dGGjJyzEmlxW+nv7jrDJBiYyaULOF71wTwFpYvy1QEzGMdv1LsT5AdOJLla0VYUV6zCJZa1vtr6VFiL4uGKg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523604; c=relaxed/simple;
	bh=4Jlh0q6dhDwc8J/hrXz/mwM4Ej/QFg4A/p/vSVf054U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BC1yECj81dCJwNfKG/sucijBHOpuPzRNEsnJajM1wsdz3heLxtQDvwcISzEssD0brqEYDuU6L8Sz1jGySDjPZh2KJqpBhrLGA5x8FDp8NWEPCzODVG9xJLuxWNp262A6bmHVN8uGpRI3QhkkwpTKcrBheJpasBPoT4D762bwNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=c6Z/9nOi; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IIgViTn4VQzK1uotweearTFzgXkK6LA+cxx2nfd4ogE=;
	b=c6Z/9nOilAGOKjS8hNVLn1q/9F0A/Mn7vJDsaJTY1/57YdcCqNTc5eMoFQHXEG0s3EONzA
	2HmxPvO+i1kDXKlbDcxyIK2DUTeiI2+Zjj1jzUtRcaojI52FjWNQF5A7Hlaup9nucKOuTs
	tyf5C5SKixmA53DvwMz3dU0YgPcITE4m29usVUcPTOwfyz9QAP0gsRkTgOASoRFVU8H7kM
	pAGOn6OCJ89KHdQSpDArg1j0cyhbt+x1BePUEIyBtElddwaPmQU9ZpDW5YPb+KWIYeUKaF
	LYEtXH8pQxPMyK2HbiM1foog4EUeXw2a3PyBeYACIEIRGh7HeUBn4pntMRdg4Q==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-23-Zav4VZQXOM-r6nfXP4XzUg-2; Mon,
 11 May 2026 11:19:57 -0700
X-MC-Unique: Zav4VZQXOM-r6nfXP4XzUg-2
X-Mimecast-MFC-AGG-ID: Zav4VZQXOM-r6nfXP4XzUg_1778523593
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:49 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:49 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 9/9] Documentation: networking: add OPEN Alliance
 10BASE-T1x MAC-PHY serial interface
Thread-Topic: [PATCH net-next v2 9/9] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Index: Adzhcd9OIUVog21RSwSOjZ/4phJ/6g==
Date: Mon, 11 May 2026 18:19:49 +0000
Message-ID: <CY8PR02MB92499FC3FF6D1CA5A0DC2E4183382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: c476ad2a-1025-4d86-af52-08deaf89e36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|921020|38070700021|11063799003
x-microsoft-antispam-message-info: 0sU8E3KgnUfYOyUd6/Lu6akhQN75i7ergGbNexHph8BEDKtWaWB1MNQqkrB9+JgWuwcYKs5l/AR3GVup8i9dkW/szv+9emsKgki64net1xuYOcxLOExDp9spqnjEyIfWBjxUP1YxpFqUnieNC7LUZOn9Qcdwv8/q8lU3F+L6AvYAmGI+00i1u5YfIwBZCqqSbkxfLXlyQU5mz98tK64pSjwuzknjhfHfPNPvq2dBAImWWx+QlLKuVeLl8RdTuycYGXJZeznla+sXZkEi/IZUzOSJGvqoIz614k7OGZ/eMpRfqWgH7L4pSSApX9j1uh1lvw26yFSGBjuFmH+8pxOS1tzciOM+WUmBaOKPanmlUzMcC+6RAORqNUlrJP4elkiVx/AIesvIXN1tRWXOjRohJ7F0v+E+3nZAj9/pmS/exEGzoGVVgovWqItd/DslIC4J71TA3srtfTXF1QjQCnJFxpViw8VyCwaMnnC+HZyH1SpampK+91PKr4pYLYlERkt8iANo3HscUucDD2swQxIYrPn9YR0fBiXfSMvRO3y09y7lGZrJibL+E9SEvm4EWzuPq/4D5IX0tiSReg8sFvbeYoCRa5RtuC/J6QF+I5rCc3sAnOBjxfHuMoBunlXw11TKei4hwFOflon/4OCoh4fdezmtSsvG6ZqPzREFJZk2QIF5cvrNsPVVxNHc029dt3z0H1ynT6WQycrLi5boc4hJGmQH6Sd/yxp1UXLyppnpJm3Q1rQATx8qsl3ngfnqt1YcdY8fUv/MhCValqsNHxKLRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(921020)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZdTGEcDXkMgkO1D6RYQIhiQCk2KzDqbVx4c0I9VqH/If8TEU0wRD0JKDWck?=
 =?us-ascii?Q?efzZNEXWu+A4XDDMTN9qqqoRJuK6OBAM5EdE1iRNaZZx62sXQNfnR/yHMY6Z?=
 =?us-ascii?Q?mBMCSIzvKeEIS8lqAiwLBg1thkyLii+DBINpqsRfnmYKFiQxCyiurzKISPRC?=
 =?us-ascii?Q?xZCluI7cFR+tMhF9sHQ0sKCy4xT9OHBJooH2TwQWDjGA5SLcIYth478L8Vfy?=
 =?us-ascii?Q?XY3owyQu1JgQ8RT8U79DH2bj+RXNXpdMhyviTZic0gv2K87TSrZ1egt2NmGk?=
 =?us-ascii?Q?JAqtUSQxqJZGtYlD3Fo0HVVXr/DjLyM1AsaZs5zDgCKCyFYg4Q44LixG0ePZ?=
 =?us-ascii?Q?FhSQOZoRD7KG4K7fUIkqJrF4mSwDnB7tmt/PNNT46Et5IkGJaOlPnZR8bW9v?=
 =?us-ascii?Q?UK6p2Ur7DKYib8OvBogcb8nZTjQvMb+eG+B5Z4pAGDrqbJ71ww3u48uMx9uo?=
 =?us-ascii?Q?7VSvx7MFDYS0oE7r9/hGvJOXgEE+P5gE4OBdf+dN8tJR5ZEn7fhTN5wlXeYt?=
 =?us-ascii?Q?pbmUVAspyQyqtF6JPVtLTtwJn95L9Li1ttskZBqRjCeDhMJa5dAKCYrbKTBf?=
 =?us-ascii?Q?c8kIdi+fZNn5P9giz5YPP05c+CQ2lxmw1niuC3JlFBUtNekjrTY9GPSDIqbY?=
 =?us-ascii?Q?wzA71gxCWKtpypRmf69Mi0vQ0bSsCv3f6ORStGLmSWR+VIDSpE1WnRIorfRW?=
 =?us-ascii?Q?ETuGWKaOD83x12e6A8uuXDl0Xsa04p3FhojjsExCDJskCDxDS6luaU07tH6I?=
 =?us-ascii?Q?gH/+qBN4nvx27SkVOWWEsJSfhqnHLPijA6FZenG0i4dZfFUfddfdWpvh6yaO?=
 =?us-ascii?Q?P2jvVPgnNl0SC51YHbvx9AIFVrBI6hnDCFY/qupu2NkMSOt0xsQYqd0vOy9o?=
 =?us-ascii?Q?DKrZeT8UXB3dBTt/a/jh/HdrMjA2qfy9TSM96DQqnXyeG0zOTWcN0dpeEP9a?=
 =?us-ascii?Q?xb8uZghW4eKRbQwhlmlCu7EhxFQnaeTLgTSs97WL5rBAe28uIk2kuv+5mFSH?=
 =?us-ascii?Q?rFQUhFl0D5P2snUheDof5By2do5/jux5dP30l7+a+c6/KmBh3zb2bKhYazt4?=
 =?us-ascii?Q?DEjhwPi2buzRVkk2BOF6nsdZxYOydK/92rRtCjiYq45Jag9zkjwzuXQYow98?=
 =?us-ascii?Q?gII0YW90LESdo/SaDX9+gCCcOhkCTBO6r2ukMbp5e6AxF0EBZypOlV1ns/B9?=
 =?us-ascii?Q?8E0WWFfpNDXQpd+8Co7hU8FIE8319e0xm5QrYWKy58bjo+4Q7Ayg6yHZxb/S?=
 =?us-ascii?Q?zZNeSRgTeuv7Gk7UPsiecfRLtYG6Gacr1ymR3TE6ACHR0WXTQYTVoXXPSVSr?=
 =?us-ascii?Q?8UXIkhQiQaqK2ekwwB9lsBmyBTB1Y7GKlwkhKjcMUM21YDvs6P9xMnbwEPij?=
 =?us-ascii?Q?jFg3Ac1QhUINfQEambiLgKacsASR8EbcLxAcr64jRZJW43qXYhA7dmfBwsPX?=
 =?us-ascii?Q?pcuFNwRwam4Pn96bVuDpd3pJNu8ZnmswUlZycwempCg4su1o7BTTQfb9FKmc?=
 =?us-ascii?Q?eh6jgMbIDQ8I4JRmnThnMRiwLULYloQKz2OCuIVxIbxcv/AopcRZBpPRVSyM?=
 =?us-ascii?Q?0kRNvBPgfFdGq5GbFPEtZ6m3ofAKqy3G4opjJbuabdW/s97BZSIY7B0ay6oE?=
 =?us-ascii?Q?xA/OFPvkbwQvf/ou3l9Ty1tkOn0iEhJa2kCk8XqCpJ5vkKM2B/KZsIGUsRjw?=
 =?us-ascii?Q?oPDSDkexewXJj69ukHeAiMuzNns78HvihOD797DlCPW8UmI/pr8/hCJFDycQ?=
 =?us-ascii?Q?t85+0COMN9ioAU6rhI+gF6APgNTFCYg=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MTL2GjNVoH+u2R2hd2/QL8VuqVZ6mJPdBf0GZU+PMnm/3BHwRUbIJoZzj6FQes1nPuadyDdjcl5soongUYp5FV5mjTSxyIEf+HVhWVLnBahhzy3iwPCD0BhUbtqSqGDJzN/sSp4MVKuY8k46VkY7+9UmSS37FtlX+OX6rx+zWUMCPHm7LWXmsul1eVGGAGMBEJUDMGH5fp2ChUG+t4evBjUM8+ij2aQK8lOk19Ob8ZCmLTK+3Hpznc2lfKsf/g4jzCc1YPzc66QtcpxMJ513HhhT/zLzMv8ApNhjDDlYDEd4w4JHHbopPy88TDUYHHOOKGj6MRRwSRdAWx8BapsOPA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c476ad2a-1025-4d86-af52-08deaf89e36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:49.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eb+wt8BIleQlkdzB00rvPB1XZGTu0nj2LJNYzEl411zWEsZVBHajpPK9Rs2Yy9993ye+ydd6TN2YWRgAkfqszy+YxkMhzk9FArRabqyfIKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8tANEOs5ZMFgeF541529MzQ0YMMG1brmePUZsudo52Q_1778523593
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94CB551451F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Added an API to support setting vendor specific MMS and
new APIs introduced to support hardware timestamp.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 Documentation/networking/oa-tc6-framework.rst | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/=
networking/oa-tc6-framework.rst
index fe2aabde9..b0c220a54 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -153,6 +153,9 @@ OPEN Alliance TC6 Framework
 - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
   subsystem.
=20
+- Update hardware timestamp in skb, when indicated by one of the three
+  timestamp capture registers through TSC fields of the header.
+
 Data Transaction
 ~~~~~~~~~~~~~~~~
=20
@@ -495,3 +498,26 @@ the MAC-PHY.
 Zero align receive frame feature can be enabled to align all receive ether=
net
 frames data to start at the beginning of any receive data chunk payload wi=
th a
 start word offset (SWO) of zero.
+
+.. c:function:: int oa_tc6_hwtstamp_ioctl(struct oa_tc6 *tc6, \
+                                          struct ifreq *rq, int cmd)
+Legacy ioctl interface for supporting hardware timestmp.
+
+frames data to start at the beginning of any receive data chunk payload wi=
th a
+
+.. c:function:: int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, \
+                                        struct kernel_hwtstamp_config *cfg=
)
+
+Interface to set hardware timestmp configuration through ndo_hwtstamp_set.
+This API is used by legacy ioctl interface as well.
+
+.. c:function:: void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, \
+                                         struct kernel_hwtstamp_config *cf=
g)
+
+Interface to get the hardware timestmp configuration through ndo_hwtstamp_=
get.
+This API is used by legacy ioctl interface as well.
+
+.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
+
+Interfaces that gives a vendor, an ability to map VEND1 MDIO device number=
 to
+vendor specific MMS (Memory Map Selector)
--=20
2.43.0


