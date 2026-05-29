Return-Path: <netdev+bounces-293203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIuMARPiGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:59:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AA60798E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41BA430C7B05
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EC407CCB;
	Fri, 29 May 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="DTZP5aVU"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC8426D0A
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080072; cv=none; b=t9cjHkPlnHuv0waEh5X1+5IUgoChYXtz7AIrYi7YiJyqaaD61mEjX6sLDm78kjcAwI7zN8C2oZHRlAfV8w65mtQBKXkGzkWImS4IShpOeCQW2mTzEg7nQrkWqeWgyLtfZ4dxzr2j0S77TwH39KQEVu8O6Py/RCxYnqzEZFsspFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080072; c=relaxed/simple;
	bh=HSSvSRGbVXVtvRve1O8/hxCcicsVnN039O8dcOE+Fwk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ea0oN2drv5wBGSyowHmirsQzIc5WI/KlqZ56xxYzlOIS2E/EbrtBsIrVK7qSozdE5uJRpfHj5FI0bE7yZ4NdTWDpXAyRwkkPYKTCvxgUcPlx9rQDLebOICWSfKO8aEMMLdbpv7W+UNEZsoyAGzX/rO0pdNq6kmtA5XNSkpx5vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=DTZP5aVU; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HSSvSRGbVXVtvRve1O8/hxCcicsVnN039O8dcOE+Fwk=;
	b=DTZP5aVUj4dkqsknt2oX0TptiJ7+G3yuKXCAUo9TqqRNAKkbzOXJusgeCpopVciE24I5OP
	K8NaPKmKLSS2c/W8hAQdQArmj1+rGDMLLMyimTFwnJQVbR6FHY9JVVXkslAOw+QKId0oft
	0wWcPzv65qk5Ogd3ilRw/8SYZeElneOKf/ZX0goofJG9M5/YbkqXDzfSD7Qt/oqA8m4lsL
	+ImlPU3x1+XnQK2/npbnFV4IPvfes9eRBC0ZVsMdeOFFyS+qZnwVw/SRGRyVwToHqK5X8L
	G1mPhS1/bwbPWr5ASmksFdo1ZwwMzJpRiU7xpBu4Ip0guOjMTqamEuDvJsydqg==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-64-MdP9mVTsOOy5MvNuo3iEKw-1; Fri,
 29 May 2026 11:41:06 -0700
X-MC-Unique: MdP9mVTsOOy5MvNuo3iEKw-1
X-Mimecast-MFC-AGG-ID: MdP9mVTsOOy5MvNuo3iEKw_1780080062
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:00 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:00 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size in
 RX frame
Thread-Topic: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Index: AdzvmRIV9Yc6XZqaQq2ja4j42ca11A==
Date: Fri, 29 May 2026 18:41:00 +0000
Message-ID: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: 253321f2-ce5d-406d-cd40-08debdb1d4ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: ibHh7N723V0yEQ+FeE9S7NZLDpjILZLLMdQQ5ftYJFINL4SdS3OpSoMRcYb9oZtYoKMsZRplln8YVcrUTwOPimRkaMdyT8m5dOAXvE20JKmFyXfYI8DIr4gz3XJUl8t7EYAtiZ3KNozCg93v2+HgToINEG99Zq37X7olXaOvY0zJQEms0fY5OQpOXinPCY5nELFbit9Sw5ijAI2L49YEYzf2DG3r6VMHz81vfPvuqEP2exEhV2zLBdxmdfnyTvEe9lQZf7OCd9FxeX4ASkEtztURkNQ+t+m6umo5WikwHFMAjuc9UawlGwrLf/oINW2QDRRhkKSNUQ9oCAoXgQaPgpbnaB2eV9Zb7hQhb3xDLc1NxXtA+m3mepwtIKXsA35m9VphPANPiWXW7xE65EjVWkZ9aJdXg92wqEqoiHIn2kBTLaoVhGlaCxmEwUdf3zD/4wl7moKvPHD6FIwZikbMblJyEbaSgS+kHTg7i8OGe2JbfILFc+8bNdvnpQ8KZM5Z+3GN+a/p1dQbIx5IRkEoS4X0WOLRGgD+zFcaMCVDkt3CDd2bbJjfrxi6yV+hXh/o3Bx0uMrg4EZ5xDL7CMkFU9HUkzjieNTqkhWkDdcqYHN+5aH+Aqu4VE8xtMGz7bniOMS0+XKoSTHgiBuvZGasLArbUiTPBLcoMkH9am7nuChnTih6NqWOdNJltY+uxBFB6yBcJQUw2E7fRgs4aBSOqOzEgQGVUWXVIllyz4Jsqz37kRgDlBCjjcXsiWROGLiD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?87Qr8HIr0AFAUbcXp47L7hupW89CIfsV+X+oyCpJPE/a95vdh/vGVOsgJ5s6?=
 =?us-ascii?Q?JK6Wj2+UNKbd7T2Bs/PLjVs6rGgNW0XSfe6FTZC07QO2XfnFpHbGhYz9r73v?=
 =?us-ascii?Q?vCvbKhWLOlU/nrzWPKo7B8M0gm50MGO2L/TLx6pMvZGYCLXkpQql2Gw9n0K+?=
 =?us-ascii?Q?Ef3k70qtU5aty4KTTuzRAWCR6vqEvw67K3D1LAnvQPeRfgWcb6PsoIQz1dWc?=
 =?us-ascii?Q?NRBkc4mrBIvZ6aa5dYphSQZgjGsdKtjj7gq/EDVCbns5KEpuBZPtMqeQ0JJJ?=
 =?us-ascii?Q?HvLFl8DNT4FANVnWIH4atluzwR/jzoQmmsTGIAvYoLaep1b4irP4UnMv46sq?=
 =?us-ascii?Q?emblJCVsOgcJBppXZy6J8QACg3KymGpHaTCCRD31UPZF8ETHRgsa+V84VVW0?=
 =?us-ascii?Q?AoUbo8bw/ffJy2zDZlxHJiuoY5SIloM7uR8UL8kxdsFcFWk26HPRrt0Q1aQ7?=
 =?us-ascii?Q?v3Ic2M+lCPs0E002jo4Q7lJVzmMdBRSGXrc8QRYC/t6E6+YI026gUxYEg/fl?=
 =?us-ascii?Q?DMU/zPtncaocvb2mzpEwKqpNZ71/urx7WlAjT3ah9tYWlp3WhjZLTtgQQvu2?=
 =?us-ascii?Q?QsOVJS2Tm2iDXN2DPaULfah1vRAECozHrgWmc6cvlwvoGGJi67Hrdb79mlo3?=
 =?us-ascii?Q?eT+qaPOIrHiS0bVMqtSf4vfO0bHFggfr5Z25P3kbKE0f6D6Q3ODWjuWMi2eN?=
 =?us-ascii?Q?uwiB0rKlbgph9xBtENfbNHadlrwuseYfVig8zK6lEDc3mfCb+b3tckHvQYfQ?=
 =?us-ascii?Q?JaMRCUcPcNdIhDqgsNx9lvSbqBs8uqJvY0HovcM3ezI77iyxDmN/O8p7AYgE?=
 =?us-ascii?Q?iz3bIt88+3dPYb403RNNYvmfKc0Sn84/bp33CYwU4bA5W9OhAQENOILJT7Dh?=
 =?us-ascii?Q?iL3vzBnmRYa7wSp6gzIgOINRV6RHO/SuvFFk7smJ6SjrOo35afZ2bl0iGRtN?=
 =?us-ascii?Q?C2i8sLdC2eCx4nJfMs1PnnK+JSokZrXx5R7nlhlfAEvLXODiuvrR42cfg1tE?=
 =?us-ascii?Q?Tq7+mev5yQbMAad3MDAiS6oVSWduV1AgJVz9opLWAfPjkvJUKry8lPu89uhb?=
 =?us-ascii?Q?VAQWZYlryuWOseKjfPcTJDD4f+OEovaKH56AAb9lJVhol2C3+HPC5AP08oF/?=
 =?us-ascii?Q?6WzPkhA8LYcB1KCWFGGAeTH1wxYQUHA+H8jHHIzeXG3tlFy+BYuZuChIyBwf?=
 =?us-ascii?Q?QSkZ6bYnlqbPSYoFOCvwaKP8QdrsqO2ypTE6uNsfgQgBcqGIvi5Lbpvx6Wp6?=
 =?us-ascii?Q?+rampkZBzql9BYKmxs/u4QKptRNcdwl6Nr3o3EtgWAXfr7G1bMpwb+Sc8cXj?=
 =?us-ascii?Q?p5E6YKgMCBAqJUmwM+9mNDMVSSn6BB974Av5oz5cwWwH5TkiJD12WqaJnjHX?=
 =?us-ascii?Q?UuQjy4BBqtYxYJuDUifiVG1pnr5JMekk13jxhzDOROw2R6ga2sJmuyRv+TdH?=
 =?us-ascii?Q?qlCarzAejaxpyhBQDczTT+iz9aeaW+BHPZWoRD5PMqUVVMskRVx5RAjt7eVn?=
 =?us-ascii?Q?c+qU9R1Mkf3ZQBwwpXXJuPWFLmoynHa5F5vMCOGySDaemBTcuVWVb1KiWrZe?=
 =?us-ascii?Q?KM7FV9Du/ENhG68SS+6dM/2FjeLpaw8ED67S3uTDqRPw5I4RXeAyPQN2iY+h?=
 =?us-ascii?Q?z86vcEboWYDxam3tgMdvSeVTLnjvxkGk5djQCinNHNzGOHPEgucdJHDoi0C5?=
 =?us-ascii?Q?u1LG473nwX/XRwIl//GI3RnUc50m51q/MhhS0wa5ryL4kJauoArcmv4AKGgY?=
 =?us-ascii?Q?PHrNy2HTjQ=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: opxdAyNLb2Tociz2wXEcLL/vIgX64VSFDr1cvLkLi9eG7e1tv2gzw9jb9BpcN1td0kPOnfxpkYZ2dmhR8aRAoFw1PwTP7mBXSLIajxY+URb9eXMG/7qx7mcLYA0CqQMpKcXV055cfL/JUiv7slZKApIDwtsuw8BupfpNo3RlMVAFNIyeLfbCoP0gX0NflpvJJVp7VBi1o5LNSsTUQhAW4zaZ38KD/SMLccl1e1uW6y42SjS0mCR5HW9bFtb7vU3te47eDRQjryxbWDn7BDRFoiYo6XcGVg1zpXAutwgfc4HDptdkxM2pT92gD8QHsp3vK5odFYEZFF1mPChmSyiPGQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253321f2-ce5d-406d-cd40-08debdb1d4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:00.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnN75tPjubJgb8Vd/1kJ8X640ctpGj6Xc5jZIoUhS/Y+NyrMdSrXsSTbVv7+tFqtVBUo1X4Lk4PalH+t6QUUtptC7GWDRxtz91zr+mhb6hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pYvaJDd9m4iAAR_FPzcxJ7Kvm4DsehiNi2_lABzeHzc_1780080062
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
	TAGGED_FROM(0.00)[bounces-293203-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9D3AA60798E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When MAC-PHY appends FCS to the incoming frame, FCS,
it is removed from the frame before passing it to the stack.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa=
_tc6/oa_tc6.c
index d2b05f98765b..de5f1548139f 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -786,6 +786,9 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 =09tc6->netdev->stats.rx_packets++;
 =09tc6->netdev->stats.rx_bytes +=3D tc6->rx_skb->len;
=20
+=09if ((tc6->netdev->hw_features & NETIF_F_RXFCS) !=3D 0)
+=09=09skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
 =09netif_rx(tc6->rx_skb);
=20
 =09tc6->rx_skb =3D NULL;
--=20
2.43.0


