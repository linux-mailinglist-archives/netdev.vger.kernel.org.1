Return-Path: <netdev+bounces-283277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DrdNbb89GnFGwIAu9opvQ
	(envelope-from <netdev+bounces-283277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:19:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEFE4AF1BB
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81D730465F7
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CBE421EF8;
	Fri,  1 May 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="MFpECDsf"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C730E82D
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662964; cv=none; b=ZgN0vfXq0MMpubkxN6PkIbtE/YyCfUn+J9jH55c1xs9WmijP7Nz2uAVOWZvLQUZsKbqYlnYkgIeVg4g0wY30N1y07QcXE7ot9EVJZKllUtjbk//qvYDQTRBgCHTYyb+bRbSsVPgl1/mX4kKGVwFEST2eg/fo1VKaMOI9ij10+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662964; c=relaxed/simple;
	bh=Gmjt1BGRhjFeP6a3gdd/YdggZg3NZpeIei0xQLjyKFk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iyO9Vkw5wENxWS7kTQhgjP1RILDOlZ1UnGQtUcNRyJdKOqAWgu3L49ycgsjvkmOsb2+K6wQtltIoXdt/tBviXaYGFJd3xRzNIjlDDKK6hgUcU0gJW8HIq7HIsyngqS4Av938xkGf3iEp8OQRTf3RbqWK4GwTxc4//89wvGp9ufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=MFpECDsf; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777662960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2bD7NbPrcwk6Xv6WnHcwL264iU5JTqc27TMjU+gaAl0=;
	b=MFpECDsf8gQxXbrxalubEw9hKkoM3ZuGFkd9E06CEOxiuEZIf0EXPp3lG+hblzPhes/XzH
	k/V0odjZuxiRGQP/b8wH1wUx8ehIvPqJJ3PiqeLmv+YLqbLayuvD1y1rOUKbCQnJlLYPTS
	rtbLqFiZ1hIQboXhMNcmCKSZR3GsHPlxLM5s41pw8GFCAvlz8ogWh09dkDA/dR+mbIWm5V
	qwhEZuE8wOPWPGk3aBNRa1HyN3+y9O/6Oa0dS9NdJcuWKMrmCzAOwehTJ98HXNnpjzWPjp
	nN3PWRTic7OyVgZqUNbk36Av9f98f9VFw6GQFV4GLRsRNUNzguHxKFUbCg1wDA==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-68-FkKZIPaaN5iCNrkB0oKv3A-1; Fri,
 01 May 2026 12:15:56 -0700
X-MC-Unique: FkKZIPaaN5iCNrkB0oKv3A-1
X-Mimecast-MFC-AGG-ID: FkKZIPaaN5iCNrkB0oKv3A_1777662954
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DM6PR02MB6969.namprd02.prod.outlook.com (2603:10b6:5:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 19:15:51 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 19:15:50 +0000
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
Subject: [PATCH net-next 5/5] Documentation: networking: add OPEN Alliance
 10BASE-T1x MAC-PHY serial interface
Thread-Topic: [PATCH net-next 5/5] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Index: AdzZljj7hmPCdracRnKuezGGQJPLXw==
Date: Fri, 1 May 2026 19:15:50 +0000
Message-ID: <CY8PR02MB9249A37FB92D4380DA3809F683322@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Enabled=True;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SiteId=04e1674b-7af5-4d13-a082-64fc6e42384c;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SetDate=2026-05-01T18:44:43.0000000Z;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Name=Public
 Information;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_ContentBits=3;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DM6PR02MB6969:EE_
x-ms-office365-filtering-correlation-id: 5455bbe2-3c3b-4478-6295-08dea7b60ee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021|56012099003|18002099003
x-microsoft-antispam-message-info: 1a6loK1NBFB5Wk23KMGs2zx4nNKPIf7xvqsaK9wYxuT/BujAKFNSVN/s0xUSIFyLoXfWgYzXm/9OlvKoHqZLJMsIchlv7NrXy4H7MvzWigZa4CQNEpTIH13WCOUWkPzys83b3h/JxNaFwiMmRKgwkYNmBJMQ0r24tVOP8k1c2maSiukVh2K7TuxYewZlVP25ZVfVbPVpx4hxNZi4Y65S7z42a0eDa7YBaopRq+ypNqJcHyBjIf+LvYq1//qIcc0PJ5E6TLmnQlf/+jzbx4eVQ04n+OYzs8Qw7t5DYexlJNlfvMrx8zFWsX78t6meddzqhURxyje8WvgLzsZWlXQfQCjaDTD19QZhPSUG6wn4mBreUXtyyeU3ZicEOv+r7K7G7W5DMlyI931s/Zh0WVCBz7YFAheFqwB8tn1MOfxCQNDCr8KvTNT8K+qVay6/3HLChyEpRrfQadjh7aadqoO0vYhy5QMGBDkfw9urLJ3x4Hos6LAYZvgRdhbHDs3dYXxEWS7S10W504sql5O8TjNTDc/8evSU/RC5Il+ARgIYKDW0UwYLTfxuGCjoc3PI3Z3K3ws4hMcg6kMjvxRTThO/oMy6+NoanFlL2ytZg5XkTfYuFOGKEE5h5xnG3Qf/j3UnRC+XJtMW72YBQAjToa/veYCCWY6CSm/EvV6ab3Y5ZCp9huFcgjCGQUN5MTQ6XlG/Lb9XLnlEvsdT36ZhAgbxViqfTDaDS5NzlWHNkOp0tvXILnGzr8TVHCcfpMCF4tbk0IRK71jLm4hujTORB9eyBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1zEPurLX2DFbGc2BENcwYFiIIy57rovV7ODH8AwaH05WnWDABwZDEYSfS3Eo?=
 =?us-ascii?Q?ZPRWvAEBvpIjbJQBSVwOHCojADkygMshKSwrKe6wiK2wiVp6xRPo/9ASWJgK?=
 =?us-ascii?Q?XdHK5SpzFyilD8AS3DyRHwhD0A/BZH1PhlxYEu1DC4Siv1TaPKBFVGykwewY?=
 =?us-ascii?Q?8HReJw3ckmG140pTkI2fVHqPEMsk2gmLpLXZfu1LpXawmmWweg1rMn4sznko?=
 =?us-ascii?Q?WwGBxcXz0BTSREMoanIoYCLbj2Wp65EuKBxkuC9FlFDoNh6t3bn3tBGrxw7H?=
 =?us-ascii?Q?bPFjBoGcsTPNFSmx42ujzBbcH0s/kZ7A93xGD5rTrQ0jPL4mDOY+764BCXUI?=
 =?us-ascii?Q?APjSH6GLc2Ule+/cgRL758elFTkVlU1MNrEsLfbUiwg6Hw1nY+hGf32oyCPD?=
 =?us-ascii?Q?CVhX6BbaeFM7gZo2dybqaIl/WO/nY52BEsuj/CvQIGwEXUHjNpVYaYr2Pe2T?=
 =?us-ascii?Q?w8rpsHKIKC/sUa5Ev9SfStRnLs9WHZtnd7Grlfl9KgxGbDBVYnIuK0bitUUl?=
 =?us-ascii?Q?7ImdxhR0jOrdtteUbQAccjEgTQ0urPZZwAwM0a2lIFlJSacXbd1qbnZbCuzw?=
 =?us-ascii?Q?DQdC6Q/iJOUIiE2l1ulwhB7fk+r4imcMPnuNwZQBiE+V2Sbs5AIYiaQmf4mG?=
 =?us-ascii?Q?nZDv7xv/gSU5IldV9VDyLeSM9rQ5VaqfwY2fIl5m2l6Xy96bI03Hli2ozc1a?=
 =?us-ascii?Q?xr+26UMq78Fb6ttVuka+WFfuC2gziFYY3Z5/WIwLMpzPjacEO0MgcB4hzBn8?=
 =?us-ascii?Q?UHynMOqS31UaR/xnKlpR1AJqUqpn0vqzbEOnQwuPYWIc2SSVL9G+J/nd++CV?=
 =?us-ascii?Q?N2ZoReBlGepWl4moqDK5J3nNnLLL33h0DCZL/rp9F+YdId2qG7rw7ORthBu1?=
 =?us-ascii?Q?XvmG6lJMGKlapltyqwp/sFrXlCFFIgpKHkNcE0BaonQ9PTFmEmNWWCfoFR93?=
 =?us-ascii?Q?zCF4HXkZ4lMAlcSX37BTXVf/o4uKqiaIxe4vGP/i9sLJf/2jhbKe7S4j94LC?=
 =?us-ascii?Q?tIk030Qoa/ATVZyESvy4xPVfUxJyf/EwxqtI563z/UAIRbl1TQe/O6vycWNf?=
 =?us-ascii?Q?Q0dtzOEsHLMaNEYOkZMbyktYAv7e82jICs3XsQq4qz6GwqXnLOy5YnmS/ItD?=
 =?us-ascii?Q?ZJ1Gp6vwhTb5akC8BvyHqiSYthXpVXajhCy24FNm0YT3zYRJmzq7DLvwZVcR?=
 =?us-ascii?Q?E8G0Il3Z6YfodDmBmekp6A2enNhdL73brdkzdzdV/x003QlJ5Ns/AwINii10?=
 =?us-ascii?Q?zPf+3VKasfyyORji2PDvKQlX803gSpSxr39sxQClk9+C7FmZ8o4wODrFWo6d?=
 =?us-ascii?Q?AO3QK/BJc7JVWwpveSlxlGV+xmkWIuy8yAf4Z05uzt5OIXThHuQHkgdcm5NU?=
 =?us-ascii?Q?HNNIZz8MpVZyQ+RUg60j1C0TOobtMF8a+665BcpntMaCneJcB/RySMfv2gUm?=
 =?us-ascii?Q?QxE6CvRoRRvGwXtz197JSyL3SeEHpUzsaSrghSWgCekxKr57DXxw7bjjJf9p?=
 =?us-ascii?Q?IgAb0QSOb0pTVyJSgp7ea6R0DcJncN6/vCCCtTP8JMVAPMkVpEm/WoM0IExw?=
 =?us-ascii?Q?C/qRU8yJfv/823uygQnkp6CKFLsQblvgeC7u37Zuu+we1dgqSiPJE+WPSWee?=
 =?us-ascii?Q?FQuIcNwRuQwemiihXaz1kFVryltDxr9IYv8unroOaAhNXJdjBuRh/ha0QiqJ?=
 =?us-ascii?Q?WG2HEl87Oy3GobGPu/gVGl3i15YO8NyMLBxLNihkl17OFFa/vHfWnt72Mhg0?=
 =?us-ascii?Q?zXANFzAVupqfm/7QSx/rR8BXBqqi/BM=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WFWprs68ZNWhyD4AIwL4oZFdazPowHY9IZZuf1ncGtFz1OOIcTi0es0C/QEC7xMrp5BtxAy+CiNqYd6NRcqM8sAQ2uuLxeTmd8jcEYF55fXvrYUnQvsYywYsiM0xqvl9DKBnQqktAdYAxWfSoJF5yBg3/N/dnINZrY2DH9KWfE7Plt3+GZlwhQRg42W5vHSpDSQFNz9y8UIYvuYsY4ePp2dRBTnrrj/xSrJH5zJEcOzxd3oB2wQh8wsJJmAxtfEx9PQpQJRRvk4kkI0LQ7oB0E8bYTqnIuAoAK8+HBA/vsPPNUk7xGoK1SUDyPDEKXkptmK9rGEOX4tBkhi1dwqeiA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5455bbe2-3c3b-4478-6295-08dea7b60ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 19:15:50.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eD7H9+J6St0V6bkNSPFiSZ1LOCAdlIH0F7SXn9vZMPH+ZNmqXkgO7JqNmCjoH4P2i58Feln0egqvHfV0MeYT6+AandHyeRaUKWbHT4nO984=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6969
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Z49Jj_9XBFZc8xklSBIzTVIG_cgL_pRCwj2N0zYgws_1777662954
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3CEFE4AF1BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid]

Added the changes to API to support onsemi devices and
new APIs introduced to support hardware timestamp.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 Documentation/networking/oa-tc6-framework.rst | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/=
networking/oa-tc6-framework.rst
index fe2aabde9..cae16e4bf 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -453,8 +453,9 @@ Device drivers API

 The include/linux/oa_tc6.h defines the following functions:

-.. c:function:: struct oa_tc6 *oa_tc6_init(struct spi_device *spi, \
-                                           struct net_device *netdev)
+.. c:function:: struct oa_tc6 *oa_tc6_init(void *priv, struct spi_device *=
spi, \
+                                           struct net_device *netdev, \
+                                           struct mii_bus *bus)

 Initialize OA TC6 lib.

@@ -485,13 +486,36 @@ Reading multiple consecutive registers starting from =
@address in the MAC-PHY.
 Maximum of 128 consecutive registers can be read starting at @address.

 .. c:function:: netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, \
-                                              struct sk_buff *skb);
+                                              struct sk_buff *skb)

 The transmit Ethernet frame in the skb is or going to be transmitted throu=
gh
 the MAC-PHY.

-.. c:function:: int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *=
tc6);
+.. c:function:: int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *=
tc6)

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
+.. c:function:: void *oa_tc6_priv(struct oa_tc6 *tc6)
+Interface to get vendor's private data structure from oa_tc6 structure. Th=
is
+is needed for vendor implemented mii_bus APIs, as mii_bus APIs priv
+pointer carries oa_tc6 structure.
+
--
2.43.0


Public Information


