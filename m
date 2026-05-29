Return-Path: <netdev+bounces-293252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNBzDjH2GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:25:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA9608819
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F5BB31833CC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE243636D;
	Fri, 29 May 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="CFP/1z93"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D73403FF
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085095; cv=none; b=GasI67wi6bK9KWWR/zGcnJCXYzf3qdVB+Z32dceCzyTaBcLBQbq/EnDRJ5pSefKTg8hDNfaXH1hh6uQrahK4nCj5P0XPgcHpWkvvk1d5DMDHBnIGE3wKJ30U7GME5X3t7I8Oi6SQnU88/6RRz61+fMjDIjSAPjVvEABqFzagRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085095; c=relaxed/simple;
	bh=VfV0rbpSCEyI+/xS3T7SDQENG4Uj1X8YfTp9nlBW2rM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVOBhbdUNe0kdDSHmYAW+7icajr5EK7zNMd3ZdW7JizwE7+OmCR2PnGraNR89e/yFBs68Gf9arM60jEbJn/82lZLwaDU7Nvp9DzaOq2UY+XrUHpT1uflmC6CyU+kxqwTFcv17xfH68Jky/X5ygQpCABMuMkZHrvLbmRi53KGc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=CFP/1z93; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780085092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G+G45O02N/hvQoeUFdPyFxVUgYZcVDEOFTIgLsz4+xs=;
	b=CFP/1z93mBukRBKNNEvIHW0Rc6kVaLqJGsD9BRM2QcPInmzGW6eE2XQkbSC3UknSHEh9EP
	kH22k1WHg1w5Fzejw0Wfm2bJLvyatr46iBm8mNz9WzTr6I9dCmzLENAtQRTmveJfE4sDDK
	+RIVQ9yO1+56XC9orP6s3gyKl634RlIoRhFD7vvkF93b3Ayt03Y129Wno0KEWRyMFaBLIq
	rAGBFm0uMBE7sH3wlnM0zaa75eZSRy7QHE1GT1Hacsrh549LozMYykFz5wqO8OkxBc46NQ
	y2lCrAbIqO8rdoMGTLSL7+Gv8dmBCKH7CFnXjAASGoZYMrDzjK110SzE7RA3uw==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-58-ccCIABsyNnWq_jO6JtoA1w-1; Fri,
 29 May 2026 13:04:47 -0700
X-MC-Unique: ccCIABsyNnWq_jO6JtoA1w-1
X-Mimecast-MFC-AGG-ID: ccCIABsyNnWq_jO6JtoA1w_1780085084
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB7746.namprd02.prod.outlook.com (2603:10b6:303:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 20:04:41 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 20:04:41 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2 0/2] Resubmitting to fix apply error
Thread-Topic: [PATCH net v2 0/2] Resubmitting to fix apply error
Thread-Index: AdzvpY7j4Xmb28GBR5qyBpELCKRAkA==
Date: Fri, 29 May 2026 20:04:40 +0000
Message-ID: <CY8PR02MB924989007ABFFEDA5A39E50383162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB7746:EE_
x-ms-office365-filtering-correlation-id: e9c9b0c6-19c0-4d86-11bd-08debdbd84f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|56012099006|6133799003|11063799006|18002099003
x-microsoft-antispam-message-info: LVY5hu22uwBr3OM6nPyBuAlmQFFewHjAY2PJcl3xQ6SODBeHDBUTw/+YQfcLAvzVa5iFh1X5jPVpgzNrTVgjDuTVTeajqm0BDQXDuL98QHtWJElc+epmLsx5AGyqYBIYcwCBde6ZgwZoik6Ca9UPt7QN5N4/JbmXO0+cblGlo/A+nMKW2WaMs9asqHyVU2dgj3Lhc87n/hmuRAnXK8BYw+zSeavu4rDpSXHsSj0qDyX75TXRUXYrCoMT9zcHsIuLMzjtjvE/R7xO2gTJYISFyauOXfqoERIjYJCqj1/qH3D7eKxfSShrknqEdFM45jfr/2dCjV1KPLaiiBLNrvlvfLLoTJFX+fl+WJerGzyTaXTuu+mhqAxmQ0q77Ndnuo13rjsvW4a0bPm2IJlan/ftQ+EOY+RYeHqOn2ZDF36A7nznHjTSQwG3xtvWwLDd4Exej4NgI2bYBLV73xYZFwhUZY6tRbWmRmYfoI8QURKG88MzsDfynA5+7ZMcke1zYuDhNh6UotktfNEFO8sqD9EXiXiA48MzlUJLTgnh6a5/MPeUlFrJ0ogvNASY9eBY7ejvIFf9YJp+hqrfQ3iid5Si0ST/QrMtXUSMt99QwWeDCD2CT0LfyDBGdgFdgloqkLq9eWzP/EgtcGmiRQstaphjv6E54bG/DcUfubbco2lcRYtinKiMnBe3shju0s6k5p+Al24HTt0aolzzxG5PmeHJ0PBPY+ogDuj8/qk5YEcW1lC2xJVifo+AsnHjykOUd2NQfFt9dmcyb/zDlaWBEty1ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iA3Cww92PZ9dHX41kJepQPYqZYqXZYiWe9m/s0mLOghzxsZzLfAtUX/yR262?=
 =?us-ascii?Q?iNDXBWk5Dl2ppWwOmarJ/L9CYeqHKmlO92Badfojvxy84IwHIVPW4OrdvVz9?=
 =?us-ascii?Q?BpLduW+mHuMyl0RoHHZ1A9GFpZHz7nHLsbcLLIP0ah23tByxuilN6t3ui7VQ?=
 =?us-ascii?Q?KKZCqtLgDqrd0huHzIhScdTnxaxA9cCfaYWRiXQJa5hWylG4aRovTlqlBOZ/?=
 =?us-ascii?Q?MsMyTRYhFAHKXfz7BnHyBJsJyoM5riPgtT22IAllysjDfV/Ye4lI8R9qrSeL?=
 =?us-ascii?Q?qsiJ6fVJNvhVTN6zORYMDVhXZ1kuOs6Eaxw0wJUQ8rUsxMWXziQlnQoQNVzs?=
 =?us-ascii?Q?lEnFeHbz82Ny0hhprPxy8bRoFa6fXdbb4t8vr54tJDbnTbneWQvK8F4qPuc5?=
 =?us-ascii?Q?9blrfgzOgzPm+eNm9CZkPGN7NeeoXSS1DCaq6Y79Vstr4DTTPSBKD+jT1b4K?=
 =?us-ascii?Q?Cv/iimmIYZHSoc6MDBdxe1OdXgTrR2S4PKS961JlOt7mAARGpSglL53qw4Ql?=
 =?us-ascii?Q?vuinY3hhMCo+BcOQYe+c1Vb3yIoj1vpS9wXozfaS6i5mItsX78vIu20C8Wlv?=
 =?us-ascii?Q?UPUvYfh+B25tL94Zet5dA6RY94W/vqhOdKF4tKnm/v5NxJwSrGuTEJGwT8rr?=
 =?us-ascii?Q?C+/J+bla8HTVuDLOYNiUL9G36jLX5LeNdRR627EWdV4sg8a49NZspsfYrtrF?=
 =?us-ascii?Q?sF8hLWMyzh/AgTzGeNt2oLW+V2hNGbJVkyK+llAkR1zGqr9dvrXcF/26QoQn?=
 =?us-ascii?Q?qrX5DTEYqMWl5mIhWc6DEkekYFUEPT21BkQr2I3GSWae3alJweSRKWje42gS?=
 =?us-ascii?Q?eq4Vi6PoM6HquZK3nHusHGMweoD5GsaDSXGx3q9eqLOedcZqGW1KcOpt+2W9?=
 =?us-ascii?Q?/KzDjdh2mplm4xkdpqgfeKxiyVC7kQOk0FUlPZefauR7D6lYSzaQvvfZyYwX?=
 =?us-ascii?Q?BIwn3eLNNvFXdL/UMt6oGFnTWE82Sjxyvd4HynE5ghcZ7LldLpG41Kx+ebv9?=
 =?us-ascii?Q?yoYtzaPUDsBIzL1nbanubxEYqtaP7AwyNDBRxRIiU3xYoe0qg+qLBcBzxTaf?=
 =?us-ascii?Q?nIbMko+hPGoUAWldrjdlEykdKKq6NBguZMJeWXXDJU44ws1SHBcm46USbl9e?=
 =?us-ascii?Q?o0QoUKnh9EIoAChtT0BQE18ZtijJwNOhzUHRU4Czl08lmIUvBRzXcpozIedA?=
 =?us-ascii?Q?hECiTsJ4j9yYiHB+X5YSRFaS10ncRMabvmgpSKFEU0zDIroTmk3Sn6QGD6LU?=
 =?us-ascii?Q?Qy9e6QR+GzAnBbFcLNERWoNqUET7s3lZdoofnZtc0uRNYBte+/QUfiUI4doH?=
 =?us-ascii?Q?PggN2SdUlNp5f6gsttYaT6xxQaog2N9x+3Nv5sP04ZHFKWqElIdrS1r6tYF8?=
 =?us-ascii?Q?q8bJRIPOx2cRgopfPdTr1br08rWL18kHT4YOC0taKk0LSP0ICqUKpdmeDGEN?=
 =?us-ascii?Q?kIdL5nBTujklExNB+q7kzRkxgeBXoUIKG0kT7yCYBDQrRhWsJQQN50KgRYPX?=
 =?us-ascii?Q?5epHx3dDOJ8okeGvhRRtrbGRC+8zQqcftGNVbRD9HEKE1lyF7ecU7BT/JwSB?=
 =?us-ascii?Q?0yrANuKWrAJOBrO2ArvpxCBKg7lC1D6hb9lx0hqC0KLWY7UDkNKE2Z6nTn5C?=
 =?us-ascii?Q?iBOa1yKpmhm7J/W5c1fAkaJhEDCgXrDqvRYlVnzVsrC62h3qOyka+UwDF5AE?=
 =?us-ascii?Q?+87zR008FmBbeP0clNz+Y7SB9wYNywZP+dp8UjcHxU0Wy2p5r3myX+UlbKzd?=
 =?us-ascii?Q?2NlusfnALxLHf85dr6wHYSYsvT+vcEg=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cpvhrFCtgOc+iqy0TtANmyXi2/E4kX7IuSYaYcD2IpNWA5ZZbayNL32lOsDyTbc/DdqRlcen/XROFY+Gu6VntMvIGu2CHiowPDGamG2ViK4YuotIfCYRoG+tDo1EIveuY31kcQCOTSMlfFPmJkfbdxaDpoQ+bLLq86rMzsp6tLhy48ph7d0kH/cpzHwnEmjT7/SYVh2o+hcT/Gxvk0z9FRbf1wST07dScUfj7zAFLLFfxo+rDt1Hn1TKVhmm1lFD5TvNhPRu37W4GoyDiBXRTmLZeH+wWvFmMCN4LzSRqpVWiBPuL5JxUhdnTMDXin5qSaz1CDKG7tZwMBsJjV0XtQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c9b0c6-19c0-4d86-11bd-08debdbd84f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 20:04:40.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuT/W77Q4A5a2enNznssh1vNytLptzkDAErMcSQzAIuhsM2zystcnQSrrzJS7eyGVP13lsJsK0+ghfwjhOELBU1R04D5qCGxZToBfIGEvVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7746
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cnVGkfWEJdaW_Xj2-i2eb0T4LmPlPxUOVtbWbE0Xas4_1780085084
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293252-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 91DA9608819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Resubmitting as my previous submission shows apply error, probably=20
due to missing base-commit ID.

Selvamani Rajagopal (2):
  net: ethernet: oa_tc6: Interrupt is active low, level triggered.
  dt-bindings: net: updated interrupt type to be active low, level
    triggered

 Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
 drivers/net/ethernet/oa_tc6.c                                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 9c7da87c2dc860bb17ca1ece942495d28b1ce3b9
--=20
2.43.0


