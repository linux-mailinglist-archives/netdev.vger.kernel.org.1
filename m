Return-Path: <netdev+bounces-283276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPk6IZP89GnFGwIAu9opvQ
	(envelope-from <netdev+bounces-283276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:18:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B154AF1AC
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0023040216
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6A4219ED;
	Fri,  1 May 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="FVZ39C47"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A7421891
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662959; cv=none; b=ogSze0qrqu0zsR52ohMesafkAFRNXXopw7HC5VkF2zIVuc4vf41Gw1zl6oGOW/RwyKgNCdsi2Ph1IuM5fjRiyVk9Ua6lKoZLgy2WnLpB3/46UlNc9js00tIB5uN1THIUAcsi9a0I8cgPUPbPJPPHEWzyibuye2uLgOsrnS9SnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662959; c=relaxed/simple;
	bh=CrCvzzpbIGC5e/F8DOu720CYebb10L9vye12PlnuGX4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Td8lL/PUqR+tL9udr9gkwSJEJ02NjWotagR/+H+CWPpfBA79vDfo9imgeDiKeXiiYnMoBM3wBKSkywvqMC71z2x3HHyZSxtk+7UD7fLFDes+qnvHCGFIevOEnKuItcDRqr/8quaJfLzA+0zG48A4l15AoXnupCHtDg/YMW6es3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=FVZ39C47; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777662950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pfHdz45mHN4PU97nDvk7/lnRbbnLThjnWWqF1xQHYjU=;
	b=FVZ39C47WsYZ0rRa98v/yQ5mcGtE9oRiGoucLKxoc0+pBG4ewOgkvoHd5pX/crhntHCLJX
	+N0qy5pwHnIW9gRIPEWYC5wS14tOL/vTgSxGFo3JDUhgyiXYPkzNw00M6SEY+oRPCMt2qR
	WLR1mgPMsVOq/hcAckUBlUzpdWETLKIXxQ+/5J6lxy2wSO7eWtDNmiplHD8TY3oIQ28ooJ
	NIwoxfW+DKJmuAmEBF1EmeZhICZ3BgTH7Gysy6Ja6QQc6gZYQVMeKvnv2O5SDkZUrmNN3j
	u+WZROJq2+1ouOhhNgeIi73IMJdbQ8/paPw6w0bWrdVmzhU96E5zgS+KwDu44A==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-26-qu_AFM5UMCKa9a99qWalBQ-1; Fri,
 01 May 2026 12:15:47 -0700
X-MC-Unique: qu_AFM5UMCKa9a99qWalBQ-1
X-Mimecast-MFC-AGG-ID: qu_AFM5UMCKa9a99qWalBQ_1777662946
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB8595.namprd02.prod.outlook.com (2603:10b6:a03:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 19:15:43 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 19:15:43 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Topic: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Index: AdzZld+FrVHyslWiQ5KiIZOby61/UQ==
Date: Fri, 1 May 2026 19:15:43 +0000
Message-ID: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Enabled=True;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SiteId=04e1674b-7af5-4d13-a082-64fc6e42384c;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SetDate=2026-05-01T18:44:40.0000000Z;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Name=Public
 Information;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_ContentBits=3;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB8595:EE_
x-ms-office365-filtering-correlation-id: ca26ef07-c324-4c3a-9695-08dea7b60a95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|21026099003|21046099003|18002099003|18092099006
x-microsoft-antispam-message-info: owQm5DSRHCTlxJ6R21l2NyAY2t5FEQ2Vk0isFPq3SIg8YTqgNapRNwiP/VhSO2YGHHA0OPo+CCfAJIqv/ajX2pcTv3FtCZ9EGjfZV3+FHndYtuXmrhAqhrmuWxT7fVY1m+rLhk0i8R65xS9QaPd4sPiKhqJoof9S6rA4XCyI4N999AN53gpkGGrEUinLmVQbBIzde3X8LudQ40g10Rm1exYfqKRMyOBFowh1gmq7LCA07tOJdgSoLqSw+FQ8AE7iU1yWZ8bk0WrMzJ1lGpgICpPjbtMnPAtrXbO5awrW46WeWiOwAQoXVNUjP1eMRyeKg4PewpK/9+JSFlMG1AYWFpIOpeSCQo81IE1LOG52nd4fQ/Wkt+Wru9PwJnnntbuwQZsD2dmV6Znkan2jmXd0Quc4zx/yyxDpqUKjhCcAYMaINZMszfcMpU0NMqn3TmfEFkkQSGuLZpv6/84ThVH3rbIezrnJKrE5ogmx/6qLLW9giiB6cyxtb5Rrn1VYBby1dEcc7k1jZksU11XF+aqxJJJBJgViGFzJp69NnwEOvEOF6BZ2DmXlCjpEjyKTFNFFobyMHRJxwfxZ/W16HcHLKTU9q0jAYGMnn8VkooZbilvS7pRMDRQeSZCM3aZn9dKR+s7SLX+IqQtN5KKW8tw6MCdzwo4NdxGoVp4CMefrJ/n4SpjlHXIq/MPBc0cQ74PJxdF3/SiFq1vandSez41F1PyqHN9ZaNx23B8WjS6/Lj7QaogD04uIRFxI/YV89cbS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(21026099003)(21046099003)(18002099003)(18092099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOxVnUuDM5JgaBfcT2+13e8KiNczHlImHsg9DGcQtJ2DyiOco+XmDDQN4U/V?=
 =?us-ascii?Q?rPbsSlPvJiTr9r3FL7WI00EoPWhZGM7yqS+scIgE8T+h/Cbn4UuXAznBeHo+?=
 =?us-ascii?Q?MsAYPuI4Ddpfyg2huSaCfL/mRlyNIpbhc0hL0VwzfWJdCsXgSf5kx5IDtqRR?=
 =?us-ascii?Q?GuEvsaMix42zYKJCyxzm2kVKs4pnzXg6Rb8qKPJzMiw3knT9k2Wc5wWWiO9j?=
 =?us-ascii?Q?WnAfuQKrKnVvjvvpF/snN1HQ1qVMW1Po7uVTdUumhoccpiHU7FdHpUbv7MoJ?=
 =?us-ascii?Q?iJhz3BKXUl6WfWW6ZdxcC05O9dpSaY1R/TWItl5CbX/0qtfrU65Pnju2MCtN?=
 =?us-ascii?Q?MaNuc7Dig/jDi/FTax/JELRzvqkSmm7TfaBh6dkOkmowkGQXTfnacW6dZxe7?=
 =?us-ascii?Q?hyug4yaG6D9+pMWJvYOPlAN5aIa3O7qEvzNJF8BccwyV+g4UQvc9gA0upRe+?=
 =?us-ascii?Q?yhcV2H7REn+hMZxD/0Jpz7vzEI4zBw2ncC/v0p35jbEpnumCwfCaaWBw0U3Y?=
 =?us-ascii?Q?0H+dq6myuH2G6cS2OuXLgIZ+0TE74kqVXzswtpL2PXKNDRJVgbDAMyWFb2WD?=
 =?us-ascii?Q?SXG0Ay0e+BF3g2HG5Sly0EXpbQcDY/Yl++o8VrGzjiV2eHkd8uOlB2gtDTe2?=
 =?us-ascii?Q?EwR/PnlwXVLUgj7E1dnL+Zp0/yVnzJ5ui9bsg2TNUX81gHCe2Lc8YSsxEpMF?=
 =?us-ascii?Q?ne5gbJ+UfcHb5uVdwOrljC4xYg9OkDBb0CCV59vU3FmqhUjUtA9M1xiyyq9h?=
 =?us-ascii?Q?RkFIWut8QEtpFAUcN7mxePfzhvOpV8JJXLf39M0D0aefaA76wtA6HPqC+Is5?=
 =?us-ascii?Q?Rucv6tZp+YbK5BjJYx1vOwOF6wb61LBpBo5hxSqcQSjCI7IdC8Ae+6mdmDgv?=
 =?us-ascii?Q?qnsRWnv5x1Yb2mtFDZGMvtyyuXYV+n8KlIG5GsK+ZTkq1yWXaleNS1sEEhXq?=
 =?us-ascii?Q?M8l9g7z/8/IvIIy5+gJ5zHMboU8ozjcPRyMmIhBrxTQbv10+1Gc+v613ovN+?=
 =?us-ascii?Q?g0RGVXNsBhgOR3w3/R6LslPqBw2Z4PjLFMNqnA2Q5fNB8Ys2CZagA8ZU24QK?=
 =?us-ascii?Q?3lw113tdjUgDLkCmmnfX5aI9msNVjrL0JiqMo17J9NmB9hyTfZrKayYhjeSZ?=
 =?us-ascii?Q?G8xk3c1hnUX/0MfpohD/+6w2HQFUmlpQ0pOz/zq4p/7WC85jDDp9LHfkzr7L?=
 =?us-ascii?Q?ZKYo68bUXer5dU60MtWaUwr861zpwFvwyEbouYEUB4K7P9z0c76fq+BtTQ8p?=
 =?us-ascii?Q?uXE1VPL3lamBSNZmpFyoIm/pFlsoi+Ghwn6A2e42WMwgcC2HNeh4nsnbUzT5?=
 =?us-ascii?Q?XthkLns6WaAABznQmWsaWwqajZ1fhKIE33/DvaidFPY0yfhO1Z3J0DfwM5XB?=
 =?us-ascii?Q?jWeZaEcO3GyKhN301EqGgF3MVPUNM4/U+prbOjuwa+MNLEeWlVo2HNFloyIL?=
 =?us-ascii?Q?t29CIqbbzYWGlc/RSIqqrt/aRsLl1kCjUBvz2Aznrg0tBsPjGRcro0QN4aYf?=
 =?us-ascii?Q?YR6uHP5gtlMTVK0zMpPmvMdJDwAPU0l2zc/m84D9NAlf2da7CQZdbZvNAHd1?=
 =?us-ascii?Q?Rj6iycG1/K3aJihsLyOwHMSRS6MH0Erjv+81gTRs43UJjGe37sDB2diRsJfK?=
 =?us-ascii?Q?u/ssvxa/aVW+CCDEYGqPlZvmgRHGZebcrvY9jIBxy37yfaIvHejwswNQBiuq?=
 =?us-ascii?Q?xmrZ60wla/4J0xnFDKBFDlfqb7+XvwxCMo/Q325STtd9MvRHNNBp/6W3FU/8?=
 =?us-ascii?Q?CqJIDFIaf0RN12diAATUC86ZTQzfqJY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kX7gNuX2Ym+0BaYHVBUqV9L82AyvNlQ9DCCE1ZqyxP1unGTmRed+AlOAzdAeJ6rV+mhHhWag3qhcpne9Kak19qyZUwvcb+DoQu1AKaGOqSDNTskLwrg5fV6vAwBdYtT1Z32e9UYk69N+UFQU6u4chL/tB4sgHkZ5zXC7UKrwJOs0WHkFaOYLAs26lcKmaVUw+IxWkTiE6+zaeuCFBJtIMDzkM0yOQlxc7w6M3ZXcN+Ov6JjnGgKtelPk8iIKt6m5fTNk5JA8D9GnuvxS5aXdF1p9lrINsHj2RVI/qu9aDOdwAJhuATQga9Nd04k+pR92tvVRGKRq13sy/H0UsnOuuA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca26ef07-c324-4c3a-9695-08dea7b60a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 19:15:43.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qr80sP5ekO60h9KCBehm8+wIUZAuVPVnhEcUKe9cmQRBgF8lLvsz5yxgI+t22hsDC1Ghe/Ge2Nva6wx+5gip7GvK2eq4VNRorehRbue8iRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8595
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FdqssNTwmz-VVxZPXZMeJKV_U0GzyNPoXn0qFvoCuN0_1777662946
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B2B154AF1AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid]

Support for onsemi's 10Base-T1S MAC-PHY products. Works with
Open Alliance TC6 framework in the kernel.

Hardware timestamp support added only for TS2500.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 .../net/ethernet/microchip/lan865x/lan865x.c  |   2 +-
 drivers/net/ethernet/onsemi/Kconfig           |  21 +
 drivers/net/ethernet/onsemi/Makefile          |   7 +
 drivers/net/ethernet/onsemi/ncn260xx/Kconfig  |  22 +
 drivers/net/ethernet/onsemi/ncn260xx/Makefile |   7 +
 .../onsemi/ncn260xx/ncn260xx_ethtool.c        | 259 +++++
 .../onsemi/ncn260xx/ncn260xx_macphy.c         | 927 ++++++++++++++++++
 .../onsemi/ncn260xx/ncn260xx_macphy.h         | 283 ++++++
 .../ethernet/onsemi/ncn260xx/ncn260xx_ptp.c   | 253 +++++
 11 files changed, 1782 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/onsemi/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/ncn260xx/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/ncn260xx/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_ethtool.c
 create mode 100644 drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.c
 create mode 100644 drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.h
 create mode 100644 drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_ptp.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index b8f70e2a1..a42656120 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -134,6 +134,7 @@ source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
 source "drivers/net/ethernet/nxp/Kconfig"
 source "drivers/net/ethernet/oki-semi/Kconfig"
+source "drivers/net/ethernet/onsemi/Kconfig"

 config ETHOC
        tristate "OpenCores 10/100 Mbps Ethernet MAC support"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 57344fec6..38527c249 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_NET_VENDOR_NI) +=3D ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) +=3D nvidia/
 obj-$(CONFIG_LPC_ENET) +=3D nxp/
 obj-$(CONFIG_NET_VENDOR_OKI) +=3D oki-semi/
+obj-$(CONFIG_NET_VENDOR_ONSEMI) +=3D onsemi/
 obj-$(CONFIG_ETHOC) +=3D ethoc.o
 obj-$(CONFIG_NET_VENDOR_PASEMI) +=3D pasemi/
 obj-$(CONFIG_NET_VENDOR_QLOGIC) +=3D qlogic/
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net=
/ethernet/microchip/lan865x/lan865x.c
index 0277d9737..fb1ef0855 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -346,7 +346,7 @@ static int lan865x_probe(struct spi_device *spi)
        spi_set_drvdata(spi, priv);
        INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);

-       priv->tc6 =3D oa_tc6_init(spi, netdev);
+       priv->tc6 =3D oa_tc6_init(priv, spi, netdev, NULL);
        if (!priv->tc6) {
                ret =3D -ENODEV;
                goto free_netdev;
diff --git a/drivers/net/ethernet/onsemi/Kconfig b/drivers/net/ethernet/ons=
emi/Kconfig
new file mode 100644
index 000000000..43c778a55
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi network device configuration
+#
+
+config NET_VENDOR_ONSEMI
+       bool "onsemi network devices"
+       help
+         If you have a network card belonging to this class, say Y.
+
+         Note that the answer to this question doesn't directly affect the
+         kernel: saying N will just cause the configurator to skip all
+         the questions about onsemi ethernet devices. If you say Y, you
+          will be asked for your specific card in the following questions.
+
+if NET_VENDOR_ONSEMI
+
+source "drivers/net/ethernet/onsemi/ncn260xx/Kconfig"
+
+endif # NET_VENDOR_ONSEMI
+
diff --git a/drivers/net/ethernet/onsemi/Makefile b/drivers/net/ethernet/on=
semi/Makefile
new file mode 100644
index 000000000..02f6f88a0
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+
+obj-$(CONFIG_NCN260XX_MACPHY) +=3D ncn260xx/
+
diff --git a/drivers/net/ethernet/onsemi/ncn260xx/Kconfig b/drivers/net/eth=
ernet/onsemi/ncn260xx/Kconfig
new file mode 100644
index 000000000..350d3e82f
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/ncn260xx/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi NCN260xx Driver Support
+#
+
+if NET_VENDOR_ONSEMI
+
+config NCN260XX_MACPHY
+       tristate "NCN260xx support"
+       depends on SPI
+       select NCN26000_PHY
+       select OA_TC6
+       select NET_DEVLINK
+       help
+         Support for the onsemi NCN26010/TS2500 MACPHY Ethernet chip.
+          It works under the framework that conform to OPEN Alliance
+          10BASE-T1x Serial Interface specification.
+
+          To compile this driver as a module, choose M here. The module wi=
ll be
+          called ncn26xx.
+
+endif # NET_VENDOR_ONSEMI
diff --git a/drivers/net/ethernet/onsemi/ncn260xx/Makefile b/drivers/net/et=
hernet/onsemi/ncn260xx/Makefile
new file mode 100644
index 000000000..7d392bb90
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/ncn260xx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+obj-$(CONFIG_NCN260XX_MACPHY) :=3D ncn260xx.o
+ncn260xx-objs :=3D ncn260xx_macphy.o ncn260xx_ethtool.o ncn260xx_ptp.o
+
diff --git a/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_ethtool.c b/driv=
ers/net/ethernet/onsemi/ncn260xx/ncn260xx_ethtool.c
new file mode 100644
index 000000000..fe117fed0
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_ethtool.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's NCN260xx/TS2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "ncn260xx_macphy.h"
+#include <linux/ethtool.h>
+
+#define ONMPH_NUM_REGS                 38
+#define ONMPH_REGDUMP_LEN              (sizeof(u32) * (ONMPH_NUM_REGS * 2)=
)
+
+static u32 phy_addr_list[ONMPH_NUM_REGS] =3D {
+       (0x4 << 16) | 0x8000,
+       (0x4 << 16) | 0x8001,
+               (0x4 << 16) | 0x8002,
+               (0x4 << 16) | 0x8003,
+               (0x4 << 16) | 0x8004,
+               (0x4 << 16) | 0x8007,
+               (0x4 << 16) | 0xCC01,
+               (0x4 << 16) | 0xCC02,
+               (0x4 << 16) | 0xCC03,
+               (0x4 << 16) | 0xCC04,
+               (0x4 << 16) | 0xCD00,
+               (0x4 << 16) | 0xCD01,
+               (0x4 << 16) | 0xCD02,
+               (0x4 << 16) | 0xD000,
+               (0x4 << 16) | 0xD001,
+               (0x4 << 16) | 0xD100,
+               (0x4 << 16) | 0xD101,
+               (0xC << 16) | 0x10,
+               (0xC << 16) | 0x11,
+               (0xC << 16) | 0x12,
+               (0xC << 16) | 0x1000,
+               (0xC << 16) | 0x1001,
+               (0xC << 16) | 0x1002,
+               (0xC << 16) | 0x1003,
+               (0xC << 16) | 0x1005,
+               (0xC << 16) | 0x1010,
+               (0xC << 16) | 0x1011,
+               (0xC << 16) | 0x1012,
+               (0xC << 16) | 0x1013,
+               (0xC << 16) | 0x1014,
+               (0xC << 16) | 0x1015,
+               (0xC << 16) | 0x1016,
+               (0xC << 16) | 0x1017,
+               (0xC << 16) | 0x1018,
+               (0xC << 16) | 0x1019,
+               (0xC << 16) | 0x101A,
+               (0xC << 16) | 0x101B,
+               (0xC << 16) | 0x101C,
+       };
+
+static const char onmph_stat_strings[][ETH_GSTRING_LEN] =3D {
+       "tx-bytes-ok",
+       "tx-frames",
+       "tx-broadcast-frames",
+       "tx-multicast-frames",
+       "tx-64-frames",
+       "tx-65-127-frames",
+       "tx-128-255-frames",
+       "tx-256-511-frames",
+       "tx-512-1023-frames",
+       "tx-1024-1518-frames",
+       "tx-underrun-errors",
+       "tx-single-collision",
+       "tx-multiple-collision",
+       "tx-excessive-collision",
+       "tx-deferred-frames",
+       "tx-carrier-sense-errors",
+       "rx-bytes-ok",
+       "rx-frames",
+       "rx-broadcast-frames",
+       "rx-multicast-frames",
+       "rx-64-frames",
+       "rx-65-127-frames",
+       "rx-128-255-frames",
+       "rx-256-511-frames",
+       "rx-512-1023-frames",
+       "rx-1024-1518-frames",
+       "rx-runt",
+       "rx-too-long-frames",
+       "rx-crc-errors",
+       "rx-symbol-errors",
+       "rx-alignment-errors",
+       "rx-busy-drop-frames",
+       "rx-mismatch-drop-frames",
+       "ts_frames",
+};
+
+#define ONMPH_STATS_LEN ARRAY_SIZE(onmph_stat_strings)
+static_assert(ONMPH_STATS_LEN =3D=3D ONMPH_STATS_NUM);
+
+#define STAT_REG_OFFSET(x) ((ONMPH_REG_MAC_ST##x) - ONMPH_REG_MAC_FIRST_ST=
AT)
+
+#define STAT_OFF_TX_BYTES_OK 0
+#define STAT_OFF_TX_FRAMES 1
+
+static void onmph_update_mac_stats(struct onmph_info *priv)
+{
+       u64 *data =3D priv->stats_data;
+       u64 tx_frames_before;
+       u32 *regs;
+       u32 *rptr;
+       int ret;
+
+       regs =3D kmalloc_array(ONMPH_NUMBER_OF_STAT_REGS, sizeof(u32), GFP_=
KERNEL);
+       if (!regs)
+               return;
+
+       ret =3D oa_tc6_read_registers(priv->tc6, ONMPH_REG_MAC_STOCTECTSTXL=
,
+                                   regs, ONMPH_NUMBER_OF_STAT_REGS);
+       if (ret)
+               goto out;
+
+       rptr =3D regs;
+
+       /* Workaround for NCN26010 version 0x01 */
+       if (priv->model =3D=3D ONMPH_MODEL_NCN26010 &&
+           priv->version =3D=3D ONMPH_NCN26010_V0) {
+               tx_frames_before =3D priv->stats_data[STAT_OFF_TX_FRAMES];
+       }
+
+       /* TX bytes is a 64-bit register that spans over two 32-bit regs
+        * note: HW does auto-freeze when reading LSB and un-freeze on MSB
+        */
+       *(data++) +=3D ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+       /* run until the next 64-bit register */
+       for (rptr +=3D 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rp=
tr)
+               *(data++) +=3D *rptr;
+
+       /* RX bytes is a 64-bit register that spans over two 32-bit regs
+        * note: HW does auto-freeze when reading LSB and un-freeze on MSB
+        */
+       *(data++) +=3D ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+       for (rptr +=3D 2; (rptr - regs) < ONMPH_NUMBER_OF_STAT_REGS; ++rptr=
)
+               *(data++) +=3D *rptr;
+
+       /* model-specific fixes */
+       if (priv->model =3D=3D ONMPH_MODEL_NCN26010 &&
+           priv->version =3D=3D ONMPH_NCN26010_V0) {
+               /* Add 4 to transmitted bytes for each transmitted packet
+                * because the HW is not counting the FCS
+                */
+               priv->stats_data[STAT_OFF_TX_BYTES_OK] +=3D
+                       4 * (priv->stats_data[STAT_OFF_TX_FRAMES] -
+                            tx_frames_before);
+       }
+       priv->stats_data[ONMPH_STATS_NUM - 1] =3D priv->ts_frames;
+out:
+       kfree(regs);
+}
+
+static void onmph_get_drvinfo(struct net_device *ndev,
+                             struct ethtool_drvinfo *info)
+{
+       strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+       strscpy(info->bus_info, dev_name(&ndev->dev), sizeof(info->bus_info=
));
+       strscpy(info->version, DRV_VERSION, sizeof(info->version));
+}
+
+static int onmph_ethtool_set_link_ksettings(struct net_device *ndev,
+                                           const struct ethtool_link_ksett=
ings *cmd)
+{
+       phy_ethtool_ksettings_set(ndev->phydev, cmd);
+       return 0;
+}
+
+static int onmph_ethtool_get_link_ksettings(struct net_device *ndev,
+                                           struct ethtool_link_ksettings *=
cmd)
+{
+       phy_ethtool_ksettings_get(ndev->phydev, cmd);
+       return 0;
+}
+
+static int onmph_get_sset_count(struct net_device *ndev, int sset)
+{
+       if (sset =3D=3D ETH_SS_STATS)
+               return ONMPH_STATS_LEN;
+       else
+               return -EOPNOTSUPP;
+}
+
+static void onmph_get_strings(struct net_device *ndev, u32 stringset, u8 *=
buf)
+{
+       memcpy(buf, onmph_stat_strings, ONMPH_STATS_LEN * ETH_GSTRING_LEN);
+}
+
+static void onmph_get_ethtool_stats(struct net_device *ndev,
+                                   struct ethtool_stats *stats, u64 *data)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       onmph_update_mac_stats(priv);
+       memcpy(data, priv->stats_data, sizeof(priv->stats_data));
+}
+
+static int onmph_get_ts_info(struct net_device *ndev,
+                            struct kernel_ethtool_ts_info *ts_info)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       if (!priv->ptp_clock)
+               return ethtool_op_get_ts_info(ndev, ts_info);
+
+       ts_info->so_timestamping =3D SOF_TIMESTAMPING_RAW_HARDWARE |
+                                  SOF_TIMESTAMPING_TX_HARDWARE |
+                                  SOF_TIMESTAMPING_RX_HARDWARE;
+       ts_info->phc_index =3D ptp_clock_index(priv->ptp_clock);
+       ts_info->tx_types =3D BIT(HWTSTAMP_TX_ON);
+       ts_info->rx_filters =3D BIT(HWTSTAMP_FILTER_ALL);
+       return 0;
+}
+
+static int onmph_get_regs_len(struct net_device *dev)
+{
+       return ONMPH_REGDUMP_LEN;
+}
+
+static void onmph_get_regs(struct net_device *ndev, struct ethtool_regs *r=
egs, void *p)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+       u32 *pbuff =3D (u32 *)p;
+       u32 val, reg;
+       int ret =3D 0;
+       int i;
+
+       regs->version =3D 0;
+       memset(p, 0, ONMPH_REGDUMP_LEN);
+
+       if (!netif_running(ndev))
+               return;
+
+       for (i =3D 0; i < ONMPH_NUM_REGS; i++) {
+               val =3D 0;
+               reg =3D phy_addr_list[i];
+               ret =3D oa_tc6_read_register(priv->tc6, reg, &val);
+               if (ret)
+                       continue;
+               *pbuff++ =3D cpu_to_be32(reg);
+               *pbuff++ =3D cpu_to_be32(val);
+       }
+}
+
+const struct ethtool_ops onmph_ethtool_ops =3D {
+       .get_drvinfo        =3D onmph_get_drvinfo,
+       .get_link           =3D ethtool_op_get_link,
+       .get_link_ksettings =3D onmph_ethtool_get_link_ksettings,
+       .set_link_ksettings =3D onmph_ethtool_set_link_ksettings,
+       .get_sset_count     =3D onmph_get_sset_count,
+       .get_strings        =3D onmph_get_strings,
+       .get_ethtool_stats  =3D onmph_get_ethtool_stats,
+       .get_ts_info        =3D onmph_get_ts_info,
+       .get_regs_len       =3D onmph_get_regs_len,
+       .get_regs           =3D onmph_get_regs,
+};
+
diff --git a/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.c b/drive=
rs/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.c
new file mode 100644
index 000000000..4c033d65f
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.c
@@ -0,0 +1,927 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's NCN260xx/TS2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "ncn260xx_macphy.h"
+
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+
+/* ONMPH functions & definitions */
+
+#define ONMPH_STATUS0_MASK     (ONMPH_SPI_ST0_CDPE_BIT | \
+                               ONMPH_SPI_ST0_TXFCSE_BIT | \
+                               ONMPH_SPI_ST0_TTSCAC_BIT | \
+                               ONMPH_SPI_ST0_TTSCAB_BIT | \
+                               ONMPH_SPI_ST0_TTSCAA_BIT | \
+                               ONMPH_SPI_ST0_RESETC_BIT | \
+                               ONMPH_SPI_ST0_HDRE_BIT | \
+                               ONMPH_SPI_ST0_LOFE_BIT | \
+                               ONMPH_SPI_ST0_RXBOE_BIT | \
+                               ONMPH_SPI_ST0_TXBUE_BIT | \
+                               ONMPH_SPI_ST0_TXBOE_BIT | \
+                               ONMPH_SPI_ST0_TXPE_BIT)
+
+/* Converts a MACPHY ID to a device name */
+static inline const char *onmph_id_to_name(u32 id)
+{
+       if (id =3D=3D ONMPH_MODEL_NCN26010)
+               return "NCN26010";
+       if (id =3D=3D ONMPH_MODEL_TS2500)
+               return "TS2500";
+       return "unknown";
+}
+
+/* Initializes the net device MAC address by reading the UID stored into t=
he
+ * device internal non-volatile memory.
+ */
+static int onmph_read_mac_from_nvmem(struct onmph_info *priv)
+{
+       u8 addr[ETH_ALEN];
+       u32 mac1 =3D 0;
+       u32 mac0 =3D 0;
+       int i, j;
+       u32 val;
+       int ret;
+
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_SPI_PHYID, &val);
+       if (ret)
+               return ret;
+
+       val =3D (val & ONMPH_SPI_PHYID_OUI_MASK) >> ONMPH_SPI_PHYID_OUI_SHI=
FT;
+
+       /* Convert the OID in host byte order */
+       for (i =3D 2; i >=3D 0; --i) {
+               addr[i] =3D 0;
+               for (j =3D 0; j < 8; ++j) {
+                       addr[i] |=3D (val & 1) << (7 - j);
+                       val >>=3D 1;
+               }
+       }
+
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_VS_MACID1, &mac1)=
;
+       if (ret)
+               return ret;
+
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_VS_MACID0, &mac0)=
;
+       if (ret)
+               return ret;
+
+       /* Pre-production parts may have 0 */
+       if (mac0 =3D=3D 0 && mac1 =3D=3D 0)
+               return -ENXIO;
+
+       addr[3] =3D mac1 & 0xff;
+       addr[4] =3D (mac0 >> 8) & 0xff;
+       addr[5] =3D mac0 & 0xff;
+
+       __dev_addr_set(priv->ndev, addr, ETH_ALEN);
+       priv->ndev->addr_assign_type =3D NET_ADDR_PERM;
+
+       return ret;
+}
+
+/* Writes MAC address to macphy registers */
+static int onmph_set_mac_filter(struct net_device *ndev, const u8 *mac)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+       u32 val;
+       int ret;
+
+       /* Set unicast address filter */
+       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDRMASKL(0)=
,
+                                   0xffffffff);
+       if (ret)
+               return ret;
+
+       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDRMASKH(0)=
,
+                                   0xffff);
+       if (ret)
+               return ret;
+
+       val =3D ((u32)mac[2] << 24) |
+              ((u32)mac[3] << 16) |
+              ((u32)mac[4] << 8) |
+              ((u32)mac[5]);
+
+       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDRFILTL(0)=
, val);
+       if (ret)
+               return ret;
+
+       val =3D ONMPH_MAC_ADDRFILT_EN_BIT | ((u32)mac[0] << 8) | ((u32)mac[=
1]);
+
+       return oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDRFILTH(0),=
 val);
+}
+
+static int onmph_mac_ctrl_clear_bits(struct onmph_info *priv, u32 in_bits,=
 bool clr)
+{
+       u32 reg =3D ONMPH_REG_MAC_CONTROL;
+       u32 rval =3D 0;
+       int ret;
+
+       ret =3D oa_tc6_read_register(priv->tc6, reg, &rval);
+       if (!ret) {
+               u32 wval =3D 0;
+
+               if (clr)
+                       wval =3D rval & ~in_bits;
+               else
+                       wval =3D rval | in_bits;
+               if (rval !=3D wval)
+                       ret =3D oa_tc6_write_register(priv->tc6, reg, wval)=
;
+       }
+       return ret;
+}
+
+static int onmph_init(struct onmph_info *priv)
+{
+       u32 val;
+       int ret;
+
+       /* Configure the SPI protocol */
+       val =3D (ONMPH_SPI_CFG0_SYNC_BIT) | ONMPH_SPI_CFG0_RXCTE_BIT |
+             (ONMPH_TXCTHRESH_8 << ONMPH_SPI_CFG0_TXCTHRESH_SHIFT) |
+             (ONMPH_CPS_64 << ONMPH_SPI_CFG0_CPS_SHIFT);
+
+       if (priv->tx_fcs_calc)
+               val |=3D ONMPH_SPI_CFG0_TXFCSVE_BIT;
+
+       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_SPI_CFG0, val);
+       if (ret)
+               return ret;
+
+       val =3D (u32)~(ONMPH_SPI_ST0_RESETC_BIT |
+                    ONMPH_SPI_ST0_HDRE_BIT | ONMPH_SPI_ST0_LOFE_BIT |
+                    ONMPH_SPI_ST0_RXBOE_BIT | ONMPH_SPI_ST0_TXBOE_BIT |
+                    ONMPH_SPI_ST0_TXPE_BIT);
+
+       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_SPI_IRQM0, val);
+       if (ret)
+               return ret;
+
+       /* Read the initial value of TX credits */
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_SPI_BUFST, &val);
+       if (ret)
+               return ret;
+
+       /* Program the source MAC address into the device */
+       ret =3D onmph_set_mac_filter(priv->ndev, priv->ndev->dev_addr);
+
+       val =3D ONMPH_MAC_CONTROL_ADRF_BIT;
+       if (!priv->tx_fcs_calc)
+               val |=3D ONMPH_MAC_CONTROL_FCSA_BIT;
+
+       return onmph_mac_ctrl_clear_bits(priv, val, false);
+}
+
+static void onmph_shutdown(struct onmph_info *priv)
+{
+       u32 val =3D ONMPH_MAC_CONTROL_TXEN_BIT | ONMPH_MAC_CONTROL_RXEN_BIT=
;
+       struct net_device *ndev =3D priv->ndev;
+
+       netif_stop_queue(ndev);
+       phy_stop(ndev->phydev);
+
+       onmph_mac_ctrl_clear_bits(priv, val, true);
+}
+
+static int onmph_set_promiscuous_mode(struct onmph_info *priv, unsigned in=
t rx_flags)
+{
+       u32 val =3D ONMPH_MAC_CONTROL_ADRF_BIT;
+       bool clr =3D false;
+
+       if (rx_flags & IFF_PROMISC)
+               clr =3D true;
+       return onmph_mac_ctrl_clear_bits(priv, val, clr);
+}
+
+static int onmph_set_multicast_mode(struct onmph_info *priv, unsigned int =
rx_flags)
+{
+       int i, ret =3D 0;
+       u32 val;
+
+       if ((rx_flags & IFF_ALLMULTI) ||
+           (netdev_mc_count(priv->ndev) > ONMPH_N_MCAST_FILTERS)) {
+               /* Disable multicast filter */
+               ret =3D onmph_mac_ctrl_clear_bits(priv, ONMPH_MAC_CONTROL_M=
CSF_BIT, true);
+               if (ret)
+                       return ret;
+
+               /* Accept all multicasts (any address with the LSB =3D 1 in=
 the first byte) */
+               ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDR=
MASKL(1), 0);
+               if (ret)
+                       return ret;
+
+               ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDR=
MASKH(1), 0x100);
+               if (ret)
+                       return ret;
+
+               ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDR=
FILTL(1), 0);
+               if (ret)
+                       return ret;
+
+               val =3D ONMPH_MAC_ADDRFILT_EN_BIT | 0x00000100;
+               ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_MAC_ADDR=
FILTH(1), val);
+       } else if (netdev_mc_count(priv->ndev) =3D=3D 0) {
+               /* Enable multicast filter */
+               ret =3D onmph_mac_ctrl_clear_bits(priv, ONMPH_MAC_CONTROL_M=
CSF_BIT, false);
+               if (ret)
+                       return ret;
+
+               /* Disable filters */
+               for (i =3D 1; i <=3D ONMPH_N_MCAST_FILTERS; i++) {
+                       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_=
MAC_ADDRFILTH(i), 0);
+                       if (ret)
+                               return ret;
+               }
+       } else {
+               struct netdev_hw_addr *ha;
+               u32 addrh;
+               u32 addrl;
+
+               /* Disable multicast filter */
+               ret =3D onmph_mac_ctrl_clear_bits(priv, ONMPH_MAC_CONTROL_M=
CSF_BIT, true);
+               if (ret)
+                       return ret;
+
+               /* Disable filters */
+               for (i =3D 1; i <=3D ONMPH_N_MCAST_FILTERS; i++) {
+                       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_=
MAC_ADDRFILTH(i), 0);
+                       if (ret)
+                               return ret;
+               }
+
+               i =3D 1;
+               netdev_for_each_mc_addr(ha, priv->ndev) {
+                       if (i > ONMPH_N_MCAST_FILTERS)
+                               break;
+
+                       addrh =3D ((ha->addr[0] << 8) | ha->addr[1] |
+                                ONMPH_MAC_ADDRFILT_EN_BIT);
+                       addrl =3D ((ha->addr[2] << 24) | (ha->addr[3] << 16=
) |
+                                (ha->addr[4] << 8) | (ha->addr[5]));
+
+                       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_=
MAC_ADDRFILTH(i),
+                                                   addrh);
+                       if (ret)
+                               return ret;
+
+                       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_=
MAC_ADDRFILTL(i),
+                                                   addrl);
+                       if (ret)
+                               return ret;
+
+                       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_=
MAC_ADDRMASKL(i),
+                                                   0xffffffff);
+                       if (ret)
+                               return ret;
+
+                       ret =3D oa_tc6_write_register(priv->tc6, ONMPH_REG_=
MAC_ADDRMASKH(i),
+                                                   0xffff);
+                       if (ret)
+                               return ret;
+                       i++;
+               }
+       }
+       return ret;
+}
+
+/* Deferred function for applying RX mode flags in non-atomic context */
+static int onmph_rx_mode_update(struct onmph_info *priv)
+{
+       unsigned int rx_flags;
+       unsigned long flags;
+       int ret;
+
+       spin_lock_irqsave(&priv->lock, flags);
+
+       rx_flags =3D priv->ndev_flags;
+       priv->rx_flags_upd =3D false;
+
+       spin_unlock_irqrestore(&priv->lock, flags);
+
+       ret =3D onmph_set_promiscuous_mode(priv, rx_flags);
+       if (ret)
+               goto out;
+
+       ret =3D onmph_set_multicast_mode(priv, rx_flags);
+out:
+       return ret;
+}
+
+static int onmph_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       if (!netif_running(ndev))
+               return -EINVAL;
+
+       /* Shouldn't pass hardware timestamp related command to
+        * PHY as it doesn't support natively
+        */
+       if (cmd =3D=3D SIOCSHWTSTAMP || cmd =3D=3D SIOCGHWTSTAMP)
+               return onmph_ioctl_timestamp(priv, rq, cmd);
+
+       return phy_do_ioctl(ndev, rq, cmd);
+}
+
+static void onmph_set_rx_mode(struct net_device *ndev)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+       unsigned long flags;
+
+       spin_lock_irqsave(&priv->lock, flags);
+
+       priv->rx_flags_upd =3D true;
+       priv->ndev_flags =3D ndev->flags;
+
+       spin_unlock_irqrestore(&priv->lock, flags);
+
+       if (priv->thread)
+               wake_up_process(priv->thread);
+}
+
+static int onmph_set_mac_address(struct net_device *ndev, void *p)
+{
+       struct sockaddr *addr =3D p;
+
+       if (!is_valid_ether_addr(addr->sa_data))
+               return -EADDRNOTAVAIL;
+
+       eth_hw_addr_set(ndev, addr->sa_data);
+       return onmph_set_mac_filter(ndev, addr->sa_data);
+}
+
+static netdev_tx_t onmph_start_xmit(struct sk_buff *skb, struct net_device=
 *ndev)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+               priv->ts_frames++;
+
+       return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static void onmph_process_events(struct onmph_info *priv)
+{
+       u32 val;
+       int ret;
+
+       if (!priv->event_pending)
+               return;
+
+       priv->event_pending =3D false;
+
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_SPI_ST0, &val);
+       if (ret) {
+               dev_err(&priv->spi->dev, "Error reading ST0 register");
+               return;
+       }
+}
+
+static int onmph_thread_fun(void *data)
+{
+       struct onmph_info *priv =3D data;
+       bool update_rx_mode =3D false;
+       unsigned long flags;
+       signed long tout;
+       int ret =3D 0;
+
+       tout =3D priv->poll_jiff;
+
+       do {
+               if (update_rx_mode) {
+                       ret =3D onmph_rx_mode_update(priv);
+                       if (unlikely(ret)) {
+                               dev_err(&priv->spi->dev, "Failed to set new=
 RX mode");
+                               break;
+                       }
+               }
+
+               if (tout =3D=3D 0) {
+                       tout =3D priv->poll_jiff;
+
+                       /* Force checking the status register */
+                       priv->event_pending =3D true;
+               }
+
+               onmph_process_events(priv);
+
+               spin_lock_irqsave(&priv->lock, flags);
+               __set_current_state(TASK_INTERRUPTIBLE);
+
+               update_rx_mode =3D priv->rx_flags_upd;
+               ret =3D update_rx_mode;
+
+               spin_unlock_irqrestore(&priv->lock, flags);
+
+               if (!ret)
+                       tout =3D schedule_timeout(tout);
+               else
+                       set_current_state(TASK_RUNNING);
+       } while (!kthread_should_stop());
+       return 0;
+}
+
+static int onmph_open(struct net_device *ndev)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+       int ret =3D 0;
+       u32 val;
+
+       dev_info(&priv->spi->dev, "%s", "onmph_open");
+       phy_start(priv->ndev->phydev);
+
+       priv->thread =3D kthread_run(onmph_thread_fun, priv, DRV_NAME "/%s:=
%d",
+                                  dev_name(&priv->spi->dev),
+                                  spi_get_chipselect(priv->spi, 0));
+
+       if (IS_ERR(priv->thread)) {
+               ret =3D PTR_ERR(priv->thread);
+       } else {
+               val =3D ONMPH_MAC_CONTROL_TXEN_BIT | ONMPH_MAC_CONTROL_RXEN=
_BIT;
+               ret =3D onmph_mac_ctrl_clear_bits(priv, val, false);
+
+               netif_start_queue(priv->ndev);
+       }
+       return ret;
+}
+
+static int onmph_stop(struct net_device *ndev)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       dev_info(&priv->spi->dev, "%s", "onmph_stop");
+
+       onmph_shutdown(priv);
+
+       kthread_stop(priv->thread);
+       priv->thread =3D NULL;
+
+       return 0;
+}
+
+static int onmph_hwtstamp_get(struct net_device *ndev,
+                             struct kernel_hwtstamp_config *cfg)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       if (!priv->ptp_clock) {
+               cfg->tx_type =3D 0;
+               cfg->rx_filter =3D 0;
+       } else {
+               oa_tc6_hwtstamp_get(priv->tc6, cfg);
+       }
+       return 0;
+}
+
+static int onmph_hwtstamp_set(struct net_device *ndev,
+                             struct kernel_hwtstamp_config *cfg,
+                             struct netlink_ext_ack *extack)
+{
+       struct onmph_info *priv =3D netdev_priv(ndev);
+
+       if (!netif_running(ndev))
+               return -EIO;
+       if (!priv->ptp_clock)
+               return -EPROTONOSUPPORT;
+       return oa_tc6_hwtstamp_set(priv->tc6, cfg);
+}
+
+static const struct net_device_ops onmph_netdev_ops =3D {
+       .ndo_open            =3D onmph_open,
+       .ndo_stop            =3D onmph_stop,
+       .ndo_start_xmit      =3D onmph_start_xmit,
+       .ndo_set_mac_address =3D onmph_set_mac_address,
+       .ndo_set_rx_mode     =3D onmph_set_rx_mode,
+       .ndo_eth_ioctl       =3D onmph_ioctl,
+       .ndo_hwtstamp_get    =3D onmph_hwtstamp_get,
+       .ndo_hwtstamp_set    =3D onmph_hwtstamp_set,
+};
+
+static int mmd2mms(int mmd)
+{
+       int ret =3D -EOPNOTSUPP;
+
+       switch (mmd) {
+       case MDIO_MMD_PCS:
+               ret =3D OA_TC6_PHY_C45_PCS_MMS2;
+               break;
+       case MDIO_MMD_PMAPMD:
+               ret =3D OA_TC6_PHY_C45_PMA_PMD_MMS3;
+               break;
+       case MDIO_MMD_VEND2:
+               ret =3D OA_TC6_PHY_C45_VS_PLCA_MMS4;
+               break;
+       case MDIO_MMD_VEND1:
+               ret =3D ONMPH_OA_TC6_VEND1_MMS12;
+               break;
+       default:
+               break;
+       }
+       return ret;
+}
+
+static int onmph_update_model(struct onmph_info *priv, void *tc6_handle)
+{
+       u32 val =3D 0;
+       int ret;
+
+       if (priv->model !=3D -1)
+               return 0;
+       ret =3D oa_tc6_read_register(tc6_handle, ONMPH_REG_VS_CHIPID, &val)=
;
+       if (ret)
+               return ret;
+
+       priv->capabilities =3D ONMPH_CAP_MACADDR;
+       priv->version =3D (val & ONMPH_CHIPID_REVISION_MASK) >> ONMPH_CHIPI=
D_REVISION_SHIFT;
+
+       priv->model =3D (val & ONMPH_CHIPID_MODEL_MASK) >> ONMPH_CHIPID_MOD=
EL_SHIFT;
+       if (priv->model =3D=3D ONMPH_MODEL_TS2500) {
+               priv->capabilities |=3D ONMPH_CAP_PTP;
+       } else if (priv->model !=3D ONMPH_MODEL_NCN26010) {
+               dev_err(&priv->spi->dev, "Unrecognized macphy. 0x%x\n", val=
);
+               return -ENODEV;
+       }
+       dev_info(&priv->spi->dev, "Macphy model %s, version %u\n",
+                onmph_id_to_name(priv->model), priv->version);
+       return ret;
+}
+
+static int onmph_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnu=
m,
+                                 int regnum)
+{
+       u32 address, val =3D 0;
+       int mms, ret;
+
+       /* Only PHY #0 is supported. */
+       if (addr !=3D 0)
+               return 0;
+
+       mms =3D mmd2mms(devnum);
+       if (mms < 0)
+               return mms;
+
+       address =3D mms << 16 | regnum;
+       ret =3D oa_tc6_read_register(bus->priv, address, &val);
+       if (ret)
+               return ret;
+       return val;
+}
+
+static int onmph_mdiobus_write_c45(struct mii_bus *bus, int addr, int devn=
um,
+                                  int regnum, u16 val)
+{
+       u32 address;
+       int mms;
+
+       if (regnum < 0 || regnum > 0xffff)
+               return -ENXIO;
+
+       /* We support only PHY #0 at this time */
+       if (addr !=3D 0)
+               return 0;
+
+       mms =3D mmd2mms(devnum);
+       if (mms < 0)
+               return mms;
+
+       address =3D (u32)regnum | (u32)mms << 16;
+
+       return oa_tc6_write_register(bus->priv, address, val);
+}
+
+static int onmph_mdiobus_read(struct mii_bus *bus, int addr, int reg)
+{
+       struct onmph_info *priv =3D oa_tc6_priv(bus->priv);
+       u32 val, mms;
+       int ret =3D 0;
+       u32 address;
+
+       if (addr !=3D 0)
+               return ret;
+
+       if (reg < 0 || reg > 31)
+               return -ENXIO;
+
+       if (reg =3D=3D MII_MMD_CTRL || reg =3D=3D MII_MMD_DATA) {
+               dev_err(&priv->spi->dev, "MMD_CTRL/DATA read not supported\=
n");
+               return -EOPNOTSUPP;
+       }
+
+       onmph_update_model(priv, bus->priv);
+
+       address =3D reg;
+       mms =3D ONMPH_OA_TC6_MACPHY_MMS0;
+       if (address < 16)
+               address |=3D 0xFF00;
+       else
+               mms =3D ONMPH_OA_TC6_VEND1_MMS12;
+
+       val =3D 0;
+       ret =3D oa_tc6_read_register(bus->priv, mms << 16 | address, &val);
+       if (ret !=3D 0)
+               return ret;
+
+       /* By mistake, NCN26010's PHY ID tied to OUI. For NCN26010,
+        * return a consistent value for DEVID1/2, which is the same
+        * value that is used in PHY driver of NCN26000.
+        *
+        * Please note that control comes here from oa_tc6_init. Which
+        * means probe didn't have chance to read the chip ID to figure
+        * out the model.
+        */
+       if (priv->model =3D=3D ONMPH_MODEL_NCN26010) {
+               if (reg =3D=3D MDIO_DEVID1)
+                       val =3D 0x180F;
+               else if (reg =3D=3D MDIO_DEVID2)
+                       val =3D 0xF5A1;
+       }
+       return val;
+}
+
+static int onmph_mdiobus_write(struct mii_bus *bus, int addr, int reg, u16=
 val)
+{
+       struct onmph_info *priv =3D oa_tc6_priv(bus->priv);
+       u32 mms;
+
+       if (addr !=3D 0)
+               return 0;
+
+       if (reg < 0 || reg > 31)
+               return -ENXIO;
+
+       if (reg =3D=3D MII_MMD_CTRL || reg =3D=3D MII_MMD_DATA) {
+               dev_err(&priv->spi->dev, "MMD_CTRL/DATA write not supported=
\n");
+               return -EOPNOTSUPP;
+       }
+
+       /* Prevent the PHY from being reset from the control register. The
+        * NCN26010 triggers a global soft-reset when resetting the PHY.
+        */
+       if (reg =3D=3D MDIO_CTRL1 && (val & MDIO_CTRL1_RESET) !=3D 0 &&
+           priv->model =3D=3D ONMPH_MODEL_NCN26010 &&
+           priv->version =3D=3D ONMPH_NCN26010_V0)
+               val &=3D ~MDIO_CTRL1_RESET;
+
+       mms =3D ONMPH_OA_TC6_MACPHY_MMS0;
+       if (reg < 16)
+               reg |=3D 0xFF00;
+       else
+               mms =3D ONMPH_OA_TC6_VEND1_MMS12;
+       return oa_tc6_write_register(bus->priv, mms << 16 | reg, val);
+}
+
+/* Rest will be initialized by oa_tc6.c */
+static void onmph_init_mii_bus_info(struct onmph_info *priv, struct mii_bu=
s *bus)
+{
+       bus->read =3D onmph_mdiobus_read;
+       bus->write =3D onmph_mdiobus_write;
+       bus->read_c45 =3D onmph_mdiobus_read_c45;
+       bus->write_c45 =3D onmph_mdiobus_write_c45;
+       bus->name =3D "onmph-mdiobus";
+
+       /* Only phy#0 supported */
+       bus->phy_mask =3D ~1U;
+}
+
+/* sudo devlink dev param show spi/spi0.0 name plca */
+static int onmph_get_plca_status(struct onmph_info *priv, struct devlink_p=
aram_gset_ctx *ctx)
+{
+       u32 addr =3D ONMPH_REG_PLCADIAG;
+       u32 val =3D 0;
+       int ret;
+
+       ret =3D oa_tc6_read_register(priv->tc6, addr, &val);
+       if (ret)
+               return ret;
+       if ((val & ONMPH_PLCADIAG_ERR) =3D=3D 0) {
+               addr =3D ONMPH_REG_BCNCNT;
+               val =3D 0;
+               ret =3D oa_tc6_read_register(priv->tc6, addr, &val);
+               if (ret)
+                       return ret;
+               snprintf(ctx->val.vstr, sizeof(ctx->val.vstr),
+                        "No error. BCNCNT =3D 0x%x\n", val);
+       } else {
+               snprintf(ctx->val.vstr, sizeof(ctx->val.vstr),
+                        "Error: %s%s%s",
+                        (val & ONMPH_PLCADIAG_RXINTO) ? "RXINFO " : "",
+                        (val & ONMPH_PLCADIAG_UNEXPB) ? "UNEXPB " : "",
+                        (val & ONMPH_PLCADIAG_BCNBFTO) ? "BCNBFTO" : "");
+       }
+       return 0;
+}
+
+static int onmph_param_get(struct devlink *dl, u32 id,
+                          struct devlink_param_gset_ctx *ctx,
+                          struct netlink_ext_ack *extack)
+{
+       struct onmph_devlink_priv *devl_priv =3D devlink_priv(dl);
+       struct onmph_info *priv =3D devl_priv->onmph_priv;
+
+       if (id =3D=3D ONMPH_PARAM_ID_PLCA)
+               return onmph_get_plca_status(priv, ctx);
+       return -EINVAL;
+}
+
+/* Nothing to set */
+static int onmph_param_set(struct devlink *dl, u32 id, struct devlink_para=
m_gset_ctx *ctx,
+                          struct netlink_ext_ack *extack)
+{
+       return -EIO;
+}
+
+static const struct devlink_param onmph_params[] =3D {
+       DEVLINK_PARAM_DRIVER(ONMPH_PARAM_ID_PLCA,
+                            "plca", DEVLINK_PARAM_TYPE_STRING,
+                            BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+                            onmph_param_get, onmph_param_set, NULL),
+};
+
+static int onmph_probe(struct spi_device *spi)
+{
+       struct device *dev =3D &spi->dev;
+       struct net_device *ndev;
+       struct onmph_info *priv;
+       struct mii_bus *bus;
+       u32 val;
+       int ret;
+
+       if (spi->irq < 0)
+               return -ENODEV;
+
+       ndev =3D devm_alloc_etherdev(dev, sizeof(struct onmph_info));
+       if (!ndev)
+               return -ENOMEM;
+
+       priv =3D netdev_priv(ndev);
+       priv->model =3D -1; /* 0 is a valid number for NCN26010. */
+       priv->ndev =3D ndev;
+       priv->spi =3D spi;
+       priv->dev =3D dev;
+
+       SET_NETDEV_DEV(ndev, dev);
+
+       spin_lock_init(&priv->lock);
+       ndev->irq =3D spi->irq;
+
+       spi->dev.platform_data =3D priv;
+       spi_set_drvdata(spi, priv);
+
+       ndev->netdev_ops =3D &onmph_netdev_ops;
+       ndev->ethtool_ops =3D &onmph_ethtool_ops;
+       ndev->if_port =3D IF_PORT_10BASET;
+       ndev->priv_flags |=3D IFF_UNICAST_FLT;
+       ndev->hw_features =3D NETIF_F_RXALL;
+
+       priv->devlink =3D devlink_alloc(&priv->devlink_ops,
+                                     sizeof(struct onmph_devlink_priv),
+                                     &spi->dev);
+       if (!priv->devlink)
+               return -ENOMEM;
+
+       ret =3D devlink_params_register(priv->devlink, onmph_params, ARRAY_=
SIZE(onmph_params));
+       if (ret)
+               goto devl_reg_err;
+       priv->devlink_priv =3D devlink_priv(priv->devlink);
+       priv->devlink_priv->onmph_priv =3D priv;
+       devlink_register(priv->devlink);
+
+       priv->tx_fcs_calc =3D false;
+       priv->poll_jiff =3D HZ * 5; /* Poll interval */
+
+       if (!priv->tx_fcs_calc)
+               priv->ndev->hw_features |=3D NETIF_F_RXFCS;
+
+       /* Pointer "mii_bus" is not saved in anywhere in vendor's code as
+        * oa_tc6.c owns it including the responsibilty to release it.
+        */
+       bus =3D mdiobus_alloc();
+       if (!bus)
+               return -ENOMEM;
+       onmph_init_mii_bus_info(priv, bus);
+
+       priv->tc6 =3D oa_tc6_init(priv, spi, ndev, bus);
+
+       /* oa_tc6_init may release mdiobus on error */
+       if (!priv->tc6) {
+               dev_err(&spi->dev, "OA TC6 init failed");
+               return -ENODEV;
+       }
+
+       /* Clear RSTS, if set */
+       oa_tc6_read_register(priv->tc6, ONMPH_REG_MIIM_IRQ_STATUS, &val);
+       val &=3D MIIM_IRQ_STATUS_RSTS;
+       if (val !=3D 0)
+               oa_tc6_write_register(priv->tc6, ONMPH_REG_MIIM_IRQ_STATUS,
+                                     MIIM_IRQ_STATUS_RSTS);
+
+       /* Acknowledge all IRQ status bits */
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_SPI_ST0, &val);
+       if (!ret) {
+               u32 mask =3D ONMPH_STATUS0_MASK;
+
+               val &=3D mask;
+               oa_tc6_write_register(priv->tc6, ONMPH_REG_SPI_ST0, val);
+       }
+
+       /* Start with non-protected control accesses for single register re=
ads.
+        * NOTE: the device starts in this mode after reset, but it is poss=
ible
+        * that the PROTE bit was set by a previous module load/unload.
+        * In this case, non-protected register writes won't work, but -sin=
gle-
+        * unprotected register reads will. Therefore, we can safely probe =
the
+        * device using regular control accesses and switch to protected mo=
de
+        * later, when resetting the device.
+        */
+
+       ret =3D onmph_update_model(priv, priv->tc6);
+       if (ret)
+               goto err_reg_read;
+
+       ret =3D oa_tc6_read_register(priv->tc6, ONMPH_REG_SPI_CFG0, &val);
+       if (ret)
+               goto err_reg_read;
+
+       ret =3D device_get_ethdev_address(priv->dev, ndev);
+       if (ret && (priv->capabilities & ONMPH_CAP_MACADDR))
+               ret =3D onmph_read_mac_from_nvmem(priv);
+
+       if (ret) {
+               eth_hw_addr_random(ndev);
+               dev_warn(&spi->dev, "Using random MAC address %pM", ndev->d=
ev_addr);
+       }
+
+       ret =3D onmph_init(priv);
+       if (unlikely(ret)) {
+               dev_err(&spi->dev, "failed to onmph_init the device");
+               goto err_reg_read;
+       }
+
+       /* Configure PTP if the model supports it */
+       if (priv->capabilities & ONMPH_CAP_PTP)
+               onmph_ptp_register(priv);
+
+       ret =3D register_netdev(ndev);
+       if (ret) {
+               dev_err(&spi->dev, "failed to register the ONMPH device\n")=
;
+               ret =3D -ENODEV;
+
+               goto err_reg_read;
+       }
+       return 0;
+
+err_reg_read:
+       dev_err(&spi->dev, "could not initialize macphy");
+       devlink_unregister(priv->devlink);
+devl_reg_err:
+       devlink_free(priv->devlink);
+       return ret;
+}
+
+static void onmph_remove(struct spi_device *spi)
+{
+       struct onmph_info *priv =3D spi->dev.platform_data;
+
+       dev_info(&spi->dev, "%s", "onmph_remove");
+
+       devlink_unregister(priv->devlink);
+       devlink_free(priv->devlink);
+       onmph_ptp_unregister(priv);
+       unregister_netdev(priv->ndev);
+       oa_tc6_exit(priv->tc6);
+}
+
+static const struct of_device_id onmph_of_match[] =3D {
+       { .compatible =3D "onnn,ncn260xx" },
+       {}
+};
+
+static const struct spi_device_id onmph_ids[] =3D {
+       { "ncn260xx" },
+       {}
+};
+
+MODULE_DEVICE_TABLE(spi, onmph_ids);
+
+static struct spi_driver ncn260xx_driver =3D {
+       .driver =3D {
+               .name   =3D DRV_NAME,
+               .of_match_table =3D onmph_of_match,
+       },
+       .probe          =3D onmph_probe,
+       .remove         =3D onmph_remove,
+       .id_table       =3D onmph_ids,
+};
+
+module_spi_driver(ncn260xx_driver);
+
+MODULE_AUTHOR("Piergiorgio Beruto <Pier.Beruto@onsemi.com>");
+MODULE_DESCRIPTION("onsemi NCN260xx MACPHY ethernet driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.h b/drive=
rs/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.h
new file mode 100644
index 000000000..dbd1d402e
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_macphy.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's NCN260xx/TS2500 10BASE-T1S MAC-PHY driver
+ */
+
+#ifndef NCN260XX_MACPHY_H
+#define NCN260XX_MACPHY_H
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/phylink.h>
+#include <linux/spi/spi.h>
+#include <linux/oa_tc6.h>
+#include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/ktime.h>
+#include <linux/errno.h>
+#include <net/devlink.h>
+
+#define DRV_NAME                       "onmph"
+#define DRV_VERSION                    "1.0.3.1"
+
+#define ONMPH_N_MCAST_FILTERS          3
+
+#define ONMPH_MODEL_NCN26010           0x0000
+#define ONMPH_MODEL_TS2500             0xA7A8
+#define ONMPH_TS2500_DEVID2            0xF411
+
+#define ONMPH_MAKE_VERSION(maj, min, stage, build) ( \
+                          (((maj) & 0xF) << 12) | \
+                          (((min) & 0xF) << 8) | \
+                          (((stage) & 0x3) << 6) | \
+                          (((build) & 0x3F)))
+
+#define ONMPH_NCN26010_V0              ONMPH_MAKE_VERSION(0, 0, 0, 1)
+
+/* Number of stat counters for ethtool */
+#define ONMPH_STATS_NUM                        34
+
+/* List of device capabilities */
+#define ONMPH_CAP_MACADDR              BIT(0)  /* MAC address in hardware =
*/
+#define ONMPH_CAP_PTP                  BIT(1)  /* PTP support */
+
+/* ONMPH registers */
+
+/* Definitions for MMS defined in Table 6 Open Alliance TC6 standard
+ * that not present in oa_tc6.h
+ */
+#define ONMPH_OA_TC6_MACPHY_MMS0       0
+#define ONMPH_OA_TC6_MAC_MMS1          1
+#define ONMPH_OA_TC6_VEND1_MMS12       12
+
+#define ONMPH_MMS_MII                  (ONMPH_OA_TC6_MACPHY_MMS0 << 16)
+#define ONMPH_MMS_MAC                  (ONMPH_OA_TC6_MAC_MMS1 << 16)
+#define ONMPH_MMS_PMDPMA               (OA_TC6_PHY_C45_PMA_PMD_MMS3 << 16)
+#define ONMPH_MMS_VS1                  (ONMPH_OA_TC6_VEND1_MMS12 << 16)
+#define ONMPH_MMS_VS2                  (OA_TC6_PHY_C45_VS_PLCA_MMS4 << 16)
+
+/* SPI OID and model register */
+#define ONMPH_REG_SPI_PHYID            0x1
+
+#define ONMPH_SPI_PHYID_OUI_SHIFT      10
+#define ONMPH_SPI_PHYID_OUI_MASK       GENMASK(31, ONMPH_SPI_PHYID_OUI_SHI=
FT)
+#define ONMPH_SPI_PHYID_MODEL_SHIFT    4
+#define ONMPH_SPI_PHYID_MODEL_MASK     GENMASK(9, ONMPH_SPI_PHYID_MODEL_SH=
IFT)
+#define ONMPH_SPI_PHYID_REV_SHIFT      0
+#define ONMPH_SPI_PHYID_REV_MASK       GENMASK(3, ONMPH_SPI_PHYID_REV_SHIF=
T)
+
+/* SPI configuration register #0 */
+#define ONMPH_REG_SPI_CFG0             (ONMPH_MMS_MII + 0x4)
+
+#define ONMPH_SPI_CFG0_SYNC_BIT                BIT(15)
+#define ONMPH_SPI_CFG0_TXFCSVE_BIT     BIT(14)
+#define ONMPH_SPI_CFG0_CSARFE_BIT      BIT(13)
+#define ONMPH_SPI_CFG0_TXCTHRESH_SHIFT 10
+#define ONMPH_SPI_CFG0_TXCTHRESH_MASK  GENMASK(11, ONMPH_SPI_CFG0_TXCTHRES=
H_SHIFT)
+#define ONMPH_SPI_CFG0_TXCTE_BIT       BIT(9)
+#define ONMPH_SPI_CFG0_RXCTE_BIT       BIT(8)
+#define ONMPH_SPI_CFG0_FTSE_BIT                BIT(7)
+#define ONMPH_SPI_CFG0_FTSS_BIT                BIT(6)
+#define ONMPH_SPI_CFG0_PROTE_BIT       BIT(5)
+#define ONMPH_SPI_CFG0_SEQE_BIT                BIT(4)
+#define ONMPH_SPI_CFG0_CPS_SHIFT       0
+#define ONMPH_SPI_CFG0_CPS_MASK                GENMASK(2, ONMPH_SPI_CFG0_C=
PS_SHIFT)
+
+#define ONMPH_TXCTHRESH_1              0x0
+#define ONMPH_TXCTHRESH_4              0x1
+#define ONMPH_TXCTHRESH_8              0x2
+#define ONMPH_TXCTHRESH_16             0x3
+
+#define ONMPH_CPS_8                    0x3
+#define ONMPH_CPS_16                   0x4
+#define ONMPH_CPS_32                   0x5
+#define ONMPH_CPS_64                   0x6
+
+/* SPI status register #0 */
+#define ONMPH_REG_SPI_ST0              (ONMPH_MMS_MII + 8)
+
+#define ONMPH_SPI_ST0_CDPE_BIT         BIT(12)
+#define ONMPH_SPI_ST0_TXFCSE_BIT       BIT(11)
+#define ONMPH_SPI_ST0_TTSCAC_BIT       BIT(10)
+#define ONMPH_SPI_ST0_TTSCAB_BIT       BIT(9)
+#define ONMPH_SPI_ST0_TTSCAA_BIT       BIT(8)
+#define ONMPH_SPI_ST0_PHYINT_BIT       BIT(7)
+#define ONMPH_SPI_ST0_RESETC_BIT       BIT(6)
+#define ONMPH_SPI_ST0_HDRE_BIT         BIT(5)
+#define ONMPH_SPI_ST0_LOFE_BIT         BIT(4)
+#define ONMPH_SPI_ST0_RXBOE_BIT                BIT(3)
+#define ONMPH_SPI_ST0_TXBUE_BIT                BIT(2)
+#define ONMPH_SPI_ST0_TXBOE_BIT                BIT(1)
+#define ONMPH_SPI_ST0_TXPE_BIT         BIT(0)
+
+/* SPI IRQ enable register #0 (use the ONMPH_SPI_ST0_*_BIT constants) */
+#define ONMPH_REG_SPI_IRQM0            (ONMPH_MMS_MII + 0xc)
+
+/* SPI buffer status register */
+#define ONMPH_REG_SPI_BUFST            0xb
+
+#define ONMPH_SPI_BUFST_TXC_SHIFT      8
+#define ONMPH_SPI_BUFST_TXC_MASK       GENMASK(15, ONMPH_SPI_BUFST_TXC_SHI=
FT)
+
+#define ONMPH_REG_MAC_CONTROL          (ONMPH_MMS_MAC + 0)
+
+#define ONMPH_MAC_CONTROL_MCSF_BIT     BIT(18)
+#define ONMPH_MAC_CONTROL_ADRF_BIT     BIT(16)
+#define ONMPH_MAC_CONTROL_FCSA_BIT     BIT(8)
+#define ONMPH_MAC_CONTROL_TXEN_BIT     BIT(1)
+#define ONMPH_MAC_CONTROL_RXEN_BIT     BIT(0)
+
+/* MAC address filter registers */
+#define ONMPH_REG_MAC_ADDRFILTL(n)     (ONMPH_MMS_MAC + (16 + 2 * (n)))
+#define ONMPH_REG_MAC_ADDRFILTH(n)     (ONMPH_MMS_MAC + (17 + 2 * (n)))
+#define ONMPH_REG_MAC_ADDRMASKL(n)     (ONMPH_MMS_MAC + (32 + 2 * (n)))
+#define ONMPH_REG_MAC_ADDRMASKH(n)     (ONMPH_MMS_MAC + (33 + 2 * (n)))
+
+#define ONMPH_MAC_ADDRFILT_EN_BIT      BIT(31)
+
+/* MAC statistic registers */
+#define ONMPH_REG_MAC_STOCTECTSTXL     (ONMPH_MMS_MAC + 48)
+#define ONMPH_REG_MAC_STOCTECTSTXH     (ONMPH_MMS_MAC + 49)
+#define ONMPH_REG_MAC_STFRAMESTXOK     (ONMPH_MMS_MAC + 50)
+#define ONMPH_REG_MAC_STBCASTTXOK      (ONMPH_MMS_MAC + 51)
+#define ONMPH_REG_MAC_STMCASTTXOK      (ONMPH_MMS_MAC + 52)
+#define ONMPH_REG_MAC_STFRAMESTX64     (ONMPH_MMS_MAC + 53)
+#define ONMPH_REG_MAC_STFRAMESTX65     (ONMPH_MMS_MAC + 54)
+#define ONMPH_REG_MAC_STFRAMESTX128    (ONMPH_MMS_MAC + 55)
+#define ONMPH_REG_MAC_STFRAMESTX256    (ONMPH_MMS_MAC + 56)
+#define ONMPH_REG_MAC_STFRAMESTX512    (ONMPH_MMS_MAC + 57)
+#define ONMPH_REG_MAC_STFRAMESTX1024   (ONMPH_MMS_MAC + 58)
+#define ONMPH_REG_MAC_STTXUNDEFLOW     (ONMPH_MMS_MAC + 59)
+#define ONMPH_REG_MAC_STSINGLECOL      (ONMPH_MMS_MAC + 60)
+#define ONMPH_REG_MAC_STMULTICOL       (ONMPH_MMS_MAC + 61)
+#define ONMPH_REG_MAC_STEXCESSCOL      (ONMPH_MMS_MAC + 62)
+#define ONMPH_REG_MAC_STDEFERREDTX     (ONMPH_MMS_MAC + 63)
+#define ONMPH_REG_MAC_STCRSERR         (ONMPH_MMS_MAC + 64)
+#define ONMPH_REG_MAC_STOCTECTSRXL     (ONMPH_MMS_MAC + 65)
+#define ONMPH_REG_MAC_STOCTECTSRXH     (ONMPH_MMS_MAC + 66)
+#define ONMPH_REG_MAC_STFRAMESRXOK     (ONMPH_MMS_MAC + 67)
+#define ONMPH_REG_MAC_STBCASTRXOK      (ONMPH_MMS_MAC + 68)
+#define ONMPH_REG_MAC_STMCASTRXOK      (ONMPH_MMS_MAC + 69)
+#define ONMPH_REG_MAC_STFRAMESRX64     (ONMPH_MMS_MAC + 60)
+#define ONMPH_REG_MAC_STFRAMESRX65     (ONMPH_MMS_MAC + 71)
+#define ONMPH_REG_MAC_STFRAMESRX128    (ONMPH_MMS_MAC + 72)
+#define ONMPH_REG_MAC_STFRAMESRX256    (ONMPH_MMS_MAC + 73)
+#define ONMPH_REG_MAC_STFRAMESRX512    (ONMPH_MMS_MAC + 74)
+#define ONMPH_REG_MAC_STFRAMESRX1024   (ONMPH_MMS_MAC + 75)
+#define ONMPH_REG_MAC_STRUNTSERR       (ONMPH_MMS_MAC + 76)
+#define ONMPH_REG_MAC_STRXTOOLONG      (ONMPH_MMS_MAC + 77)
+#define ONMPH_REG_MAC_STFCSERRS                (ONMPH_MMS_MAC + 78)
+#define ONMPH_REG_MAC_STSYMBOLERRS     (ONMPH_MMS_MAC + 79)
+#define ONMPH_REG_MAC_STALIGNERRS      (ONMPH_MMS_MAC + 80)
+#define ONMPH_REG_MAC_STRXOVERFLOW     (ONMPH_MMS_MAC + 81)
+#define ONMPH_REG_MAC_STRXDROPPED      (ONMPH_MMS_MAC + 82)
+
+/* First/last statistic register for sequential access */
+#define ONMPH_REG_MAC_FIRST_STAT       ONMPH_REG_MAC_STOCTECTSTXL
+#define ONMPH_REG_MAC_LAST_STAT                ONMPH_REG_MAC_STRXDROPPED
+
+#define ONMPH_NUMBER_OF_STAT_REGS \
+       (ONMPH_REG_MAC_LAST_STAT - ONMPH_REG_MAC_FIRST_STAT + 1)
+
+/* Permanent MAC address register */
+#define ONMPH_REG_VS_MACID0            (ONMPH_MMS_VS1 + 0x1002)
+#define ONMPH_REG_VS_MACID1            (ONMPH_MMS_VS1 + 0x1003)
+
+#define ONMPH_MACID1_UID_SHIFT         0
+#define ONMPH_MACID1_UID_MASK          GENMASK(7, ONMPH_MACID1_UID_SHIFT)
+
+/* Chip identification register */
+#define ONMPH_REG_VS_CHIPID            (ONMPH_MMS_VS1 + 0x1000)
+
+#define ONMPH_CHIPID_MODEL_SHIFT       16
+#define ONMPH_CHIPID_MODEL_MASK                GENMASK(31, ONMPH_CHIPID_MO=
DEL_SHIFT)
+#define ONMPH_CHIPID_REVISION_SHIFT    0
+#define ONMPH_CHIPID_REVISION_MASK     GENMASK(15, ONMPH_CHIPID_REVISION_S=
HIFT)
+
+/* MIIM IRQ status register */
+#define ONMPH_REG_MIIM_IRQ_STATUS      (ONMPH_MMS_VS1 + 0x11)
+#define MIIM_IRQ_STATUS_RSTS_SHIFT     15
+#define MIIM_IRQ_STATUS_RSTS           BIT(MIIM_IRQ_STATUS_RSTS_SHIFT)
+
+#define ONMPH_REG_BCNCNT               (ONMPH_MMS_VS1 + 0x101C)
+
+#define ONMPH_REG_PLCADIAG             (ONMPH_MMS_VS2 + 0xCA06)
+#define ONMPH_PLCADIAG_RXINTO_SHIFT    (2)
+#define ONMPH_PLCADIAG_RXINTO          BIT(ONMPH_PLCADIAG_RXINTO_SHIFT)
+#define ONMPH_PLCADIAG_UNEXPB_SHIFT    (1)
+#define ONMPH_PLCADIAG_UNEXPB          BIT(ONMPH_PLCADIAG_UNEXPB_SHIFT)
+#define ONMPH_PLCADIAG_BCNBFTO_SHIFT   (0)
+#define ONMPH_PLCADIAG_BCNBFTO         BIT(ONMPH_PLCADIAG_BCNBFTO_SHIFT)
+#define ONMPH_PLCADIAG_ERR             (ONMPH_PLCADIAG_RXINTO | \
+                                        ONMPH_PLCADIAG_UNEXPB | \
+                                        ONMPH_PLCADIAG_BCNBFTO)
+
+/* PTP registers */
+#define ONMPH_REG_VS_PTP_SEC           (ONMPH_MMS_VS1 + 0x1010)
+#define ONMPH_REG_VS_PTP_SETSEC                (ONMPH_MMS_VS1 + 0x1012)
+#define ONMPH_REG_VS_PTP_ADJ           (ONMPH_MMS_VS1 + 0x1014)
+
+enum onmph_devlink_param_id {
+       ONMPH_DEVLINK_PARAM_ID_BASE =3D DEVLINK_PARAM_GENERIC_ID_MAX,
+       ONMPH_PARAM_ID_PLCA,
+};
+
+/* prototypes / forward declarations */
+extern const struct ethtool_ops onmph_ethtool_ops;
+
+struct onmph_info;
+
+struct onmph_devlink_priv {
+       struct onmph_info *onmph_priv;
+};
+
+struct onmph_info {
+       struct device *dev;
+       struct net_device *ndev;
+
+       /* model information */
+       u32 model;
+       u32 version;
+       unsigned int capabilities;
+
+       /* tasks and synchronization variables */
+       spinlock_t lock;
+       struct task_struct *thread;
+
+       /* global state variables */
+       bool event_pending;
+       unsigned int ndev_flags;
+       bool rx_flags_upd;
+
+       bool tx_fcs_calc;
+
+       signed long poll_jiff;
+
+       struct spi_device *spi;
+
+       /* statistic counters variables */
+       u64 stats_data[ONMPH_STATS_NUM];
+
+       /* PTP related variables */
+       struct ptp_clock_info ptp_clock_info;
+       struct ptp_clock *ptp_clock;
+       u32 ts_frames;
+       void *tc6;
+
+       struct devlink_ops devlink_ops;
+       struct onmph_devlink_priv *devlink_priv;
+       struct devlink *devlink;
+};
+
+int onmph_ioctl_timestamp(struct onmph_info *priv, struct ifreq *rq, int c=
md);
+void onmph_ptp_unregister(struct onmph_info *priv);
+void onmph_ptp_register(struct onmph_info *priv);
+
+#endif /* NCN260XX_MACPHY_H */
+
diff --git a/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_ptp.c b/drivers/=
net/ethernet/onsemi/ncn260xx/ncn260xx_ptp.c
new file mode 100644
index 000000000..8c3ebbe73
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/ncn260xx/ncn260xx_ptp.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's NCN260xx/TS2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "ncn260xx_macphy.h"
+
+static DEFINE_MUTEX(onmph_ptp_adj_mutex);
+
+static int onmph_ptp_get_time64(struct ptp_clock_info *ptp,
+                               struct timespec64 *ts,
+                               struct ptp_system_timestamp *ptp_sts)
+{
+       struct onmph_info *priv =3D container_of(ptp, struct onmph_info,
+                                              ptp_clock_info);
+       u32 data[2];
+       int ret;
+
+       ptp_read_system_prets(ptp_sts);
+       ret =3D oa_tc6_read_registers(priv->tc6, ONMPH_REG_VS_PTP_SEC,
+                                   &data[0], 2);
+       ptp_read_system_postts(ptp_sts);
+
+       if (!ret) {
+               ts->tv_sec =3D data[0];
+               ts->tv_nsec =3D data[1];
+       }
+
+       return ret;
+}
+
+static int onmph_ptp_set_time64(struct ptp_clock_info *ptp,
+                               const struct timespec64 *ts)
+{
+       struct onmph_info *priv =3D container_of(ptp, struct onmph_info,
+                                              ptp_clock_info);
+       u32 data[2];
+
+       if (ts->tv_sec >=3D (1ULL << 32))
+               return -ERANGE;
+
+       data[0] =3D (u32)ts->tv_sec;
+       data[1] =3D ts->tv_nsec | BIT(31); /* bit 31 =3D execute set comman=
d */
+
+       return oa_tc6_write_registers(priv->tc6, ONMPH_REG_VS_PTP_SETSEC,
+                                     &data[0], 2);
+}
+
+static int onmph_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+       struct onmph_info *priv =3D container_of(ptp, struct onmph_info,
+                                              ptp_clock_info);
+       u32 sign_bit =3D 0;
+       long adj;
+       u32 val;
+       u64 ppm;
+
+       if (scaled_ppm < 0) {
+               /* split sign / mod */
+               sign_bit =3D 1U << 31;
+               scaled_ppm =3D ~scaled_ppm + 1;
+       }
+
+       /**
+        * Convert unsigned scaled_ppm to atto-seconds per clock cycles.
+        * The scaled_ppm format is Qx.16 --> 1 lsb =3D 1/65536 ppm.
+        * The clock period of the TS2500 is 8ns (125 MHz), so 1 lsb of
+        * adj register LSB is 1 atto-sec / 8ns =3D 0.000125 ppm.
+        * Represented in Qx.16 format, this is 0.000125 * 2^16 =3D 8(.192)
+        * To convert scaled_ppm into a register value we need to divide
+        * it by the LSB value, hence adj =3D (scaled_ppm * 1000) / 8192 to
+        * minimize the precision loss due to the integer arithmetic.
+        * That further reduces to (scaled_ppm * 125) / 1024.
+        */
+       ppm =3D (u64)scaled_ppm * 125;
+       do_div(ppm, 1024);
+       adj =3D (long)ppm;
+
+       /* check overflow */
+       if (adj >=3D (1L << 28))
+               return -ERANGE;
+
+       val =3D (u32)adj | sign_bit;
+       return oa_tc6_write_register(priv->tc6, ONMPH_REG_VS_PTP_ADJ, val);
+}
+
+/* Implemented by using "settime" */
+static int onmph_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+       struct ptp_system_timestamp sts;
+       struct timespec64 target;
+       unsigned int period_ms;
+       struct timespec64 now;
+       int max_iters =3D 3;
+       s64 scaled_ppm;
+       s64 remaining;
+       s64 target_ns;
+       int ret =3D 0;
+       s64 now_ns;
+       s64 num;
+       s64 den;
+
+       if (!ptp)
+               return -EINVAL;
+
+       /* Nothing to do */
+       if (delta =3D=3D 0)
+               return 0;
+
+       if (mutex_lock_interruptible(&onmph_ptp_adj_mutex))
+               return -EINTR;
+
+       /* Try to slew the clock using adjfine for better accuracy. For lar=
ge
+        * adjustments fall back to setting time directly.
+        */
+       remaining =3D delta;
+
+       while (remaining !=3D 0 && max_iters--) {
+               s64 abs_delta =3D remaining > 0 ? remaining : -remaining;
+
+               /* If the adjustment is very large, more than 1 second,
+                * use settime to avoid very long slewing periods or
+                * excessive frequency offsets.
+                */
+               if (abs_delta > 1000000000LL) {
+                       memset(&sts, 0, sizeof(sts));
+                       ret =3D ptp->gettimex64(ptp, &now, &sts);
+                       if (!ret) {
+                               struct timespec64 delta_ts;
+
+                               if (remaining >=3D 0) {
+                                       delta_ts =3D ns_to_timespec64(remai=
ning);
+                                       target =3D timespec64_add(now, delt=
a_ts);
+                               } else {
+                                       delta_ts =3D ns_to_timespec64(-rema=
ining);
+                                       target =3D timespec64_sub(now, delt=
a_ts);
+                               }
+                       }
+
+                       if (target.tv_sec < 0 || target.tv_sec >=3D (1ULL <=
< 32))
+                               ret =3D -ERANGE;
+                       else
+                               ret =3D ptp->settime64(ptp, &target);
+
+                       remaining =3D 0;
+                       break;
+               }
+
+               /* Choose a slewing period depending on magnitude */
+               if (abs_delta <=3D 1000000LL) /* <=3D 1ms */
+                       period_ms =3D 1000; /* 1 s */
+               else if (abs_delta <=3D 100000000LL) /* <=3D 100ms */
+                       period_ms =3D 10000; /* 10 s */
+               else
+                       period_ms =3D 60000; /* 60 s */
+
+               /* compute current time and fixed target for this iteration=
 */
+               memset(&sts, 0, sizeof(sts));
+               ret =3D ptp->gettimex64(ptp, &now, &sts);
+               if (ret)
+                       break;
+
+               if (remaining >=3D 0)
+                       target =3D timespec64_add(now, ns_to_timespec64(rem=
aining));
+               else
+                       target =3D timespec64_sub(now, ns_to_timespec64(-re=
maining));
+
+               /* Compute scaled_ppm (Qx.16). scaled_ppm =3D ppm * 2^16
+                * ppm =3D (delta_seconds / period_seconds) * 1e6
+                * =3D> scaled_ppm =3D delta_ns * 65536 / (period_ms * 1000=
)
+                */
+               num =3D remaining * 65536LL;
+               den =3D (s64)period_ms * 1000LL;
+
+               /* Integer division rounds toward zero; keep sign in numera=
tor */
+               scaled_ppm =3D div_s64(num, den);
+
+               /* Apply frequency adjustment */
+               ret =3D ptp->adjfine(ptp, (long)scaled_ppm);
+               if (ret)
+                       break;
+
+               /* Sleep for the slew period (interruptible). If interrupte=
d, clear
+                * the adjfine and return with -EINTR.
+                */
+               if (msleep_interruptible(period_ms)) {
+                       /* Clear adjfine */
+                       ptp->adjfine(ptp, 0);
+                       ret =3D -EINTR;
+                       break;
+               }
+
+               /* Clear adjfine and measure remaining offset */
+               ptp->adjfine(ptp, 0);
+
+               memset(&sts, 0, sizeof(sts));
+               ret =3D ptp->gettimex64(ptp, &now, &sts);
+               if (ret)
+                       break;
+
+               /* remaining =3D target - now (in ns) */
+               target_ns =3D timespec64_to_ns(&target);
+               now_ns =3D timespec64_to_ns(&now);
+               remaining =3D target_ns - now_ns;
+
+               /* If remaining is small (< 1us), finish */
+               if (remaining > -1000 && remaining < 1000)
+                       remaining =3D 0;
+       }
+
+       mutex_unlock(&onmph_ptp_adj_mutex);
+       return ret;
+}
+
+int onmph_ioctl_timestamp(struct onmph_info *priv, struct ifreq *rq, int c=
md)
+{
+       if (!(priv->capabilities & ONMPH_CAP_PTP))
+               return -EOPNOTSUPP;
+       return oa_tc6_hwtstamp_ioctl(priv->tc6, rq, cmd);
+}
+
+/* Support is not available for alarms, programmable periodic signals, pin
+ * configuration, external timestamping, programmable pins, and PPS suppor=
t.
+ */
+void onmph_ptp_register(struct onmph_info *priv)
+{
+       struct ptp_clock_info *info =3D &priv->ptp_clock_info;
+
+       snprintf(info->name, sizeof(info->name), "%s", "TS2500 PTP Clock");
+       info->max_adj =3D 100000000;
+       info->owner =3D THIS_MODULE;
+       info->adjfine =3D onmph_ptp_adjfine;
+       info->gettimex64 =3D onmph_ptp_get_time64;
+       info->settime64 =3D onmph_ptp_set_time64;
+       info->adjtime =3D onmph_ptp_adjtime;
+
+       priv->ptp_clock =3D ptp_clock_register(info, priv->dev);
+       if (IS_ERR(priv->ptp_clock)) {
+               dev_err(&priv->spi->dev, "Registration of %s failed",
+                       info->name);
+               return;
+       }
+       dev_info(&priv->spi->dev, "Registered %s index %d", info->name,
+                ptp_clock_index(priv->ptp_clock));
+}
+
+void onmph_ptp_unregister(struct onmph_info *priv)
+{
+       if (priv->ptp_clock)
+               ptp_clock_unregister(priv->ptp_clock);
+}
+
--
2.43.0


Public Information


