Return-Path: <netdev+bounces-299801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4RUNJqAmMWorcwUAu9opvQ
	(envelope-from <netdev+bounces-299801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:34:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80668E56D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=ONYXwIKM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E0D30BDD06
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02F3B7B6B;
	Tue, 16 Jun 2026 10:19:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A535504D
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:19:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605192; cv=fail; b=CYcPl2uZ35AAdZQLLNYEo0C9p437rqFmhyHPSqk25BcBRWOGVGlQPtUw3l0Cyx96uS4mHcYWR+rBO8Sg25cQ8f/4Ygrv1tlOOj2AzqbrR1p5FUcFVWjdrFKgtHMkIR/JjRLw5HbsaNIvMEocSx1i3YHRlyfu3/U3cL7gWrf+YKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605192; c=relaxed/simple;
	bh=mTrcFjXRz+8YfA2zQS69Fm7+HQQLgraY4Ad2Ie5WEeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aoUgQkI68HzeNRAkCoMxzm0hNJB2d377Nx5pLEvDeomKOizlM9YhX0KaGKaqRdB73JVu5/poigp3a4xAx08krSlZYQBf2FrFF980ZOaBhrcPP52RZdugDQPiEIGSKutC5hwEdOqLvaSxAnydoPxBUonWIs5boplfwT8rxViodhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONYXwIKM; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpeEX3HrSfdzUSdOiWDOIxfCdrowKj1KKFrFmvXdzGMtXV0vb/kjcIpz0+7Iwq7RJw0Ia4wzJ42HJiISYyDQWLMFQ3qkZVNOaGEkN2dO5ewc8qGpfTH8vFasSPlK90F+rIEGygA+S0ednp1IVD2XaJ2NBml2ng6RqJfxBr1LWMlRNGSyknZXRh8UNoBQRYkQFgta9c9mElCNl+ehXPEZDQBayxMDbZmGaQfCfWw4yxR3wp/h6yn85al8rx/v3PJAXkN7Wor64GM9E1twDAVqPHzuf8yIzCc+2Zf31YxpiYk8iPlKVE6YsfHYv+aRrtZRFFKhSe8Nxws35llWTdvIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTrcFjXRz+8YfA2zQS69Fm7+HQQLgraY4Ad2Ie5WEeI=;
 b=I817v20SanY5E6gufSycVLAc+AqYiWb9tfyVKdoySQ+zHLx2hO063hu2c5OBZIK237SoGkAUxQIPo9thTNJAglpIYFX5wlSZSddEuimEsuk4J4r5+nwZPcEoBy8nQnflW2f0jsJkmpU/BdaIh5WRzwhtRNqLKg6mffhf17H4d+o7kGqYGYLwc2WI3Fp1T+IjG41moHXF2I6rADlp9luBKw7FNnVg7AtRfHg87S/66P2oJJGHCsjI4UnjOl9ectTTnPuK250gwQ0kMCbClz3DIpmooSTBEIKCzTkaPwXtw43ucOMoF1HAow6m21GN2yOvVRFGm+RdEnKybNbdJ02cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTrcFjXRz+8YfA2zQS69Fm7+HQQLgraY4Ad2Ie5WEeI=;
 b=ONYXwIKMwoVwYyNXDOBn87sThGNVIsF0AJjjO6eVGZ+uKlI4WSUjh3mHP0SDO2tpFuQwBO23xdAUhgmnrQ7TYUHw/0JCK9xyUubfT7bDksgONfEaYHDBH5Jv4x5Kz+o9yMp8yGyGxx6sKKWRNEJ3jGBtXCultUXkfUz+RW3L0NVcgX2Ow4fNNG2xFg5JogOFzYP0fsbsH9oSd7BwMQs7NovVsjKm3V4WxgqjGd2FH4Qv8Hjzb6R8TqQCGIR0IifqG2/I4VJ3wHWQQq7WVBiBxU6FUE7ll6lG8AZCX4lvOl9kSaA+Dw5uDzDxrNp86RuP+pj4GTEV87zgThhqlZU6TQ==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by PA6PR04MB11909.eurprd04.prod.outlook.com (2603:10a6:102:51c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:19:47 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:19:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Linus Walleij <linusw@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Sashiko AI Review
	<sashiko-bot@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, Hauke
 Mehrtens <hauke@hauke-m.de>, Kurt Kanzenbach <kurt@linutronix.de>, Woojung
 Huh <woojung.huh@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "Chester A. Unal"
	<chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Clark Wang
	<xiaoning.wang@nxp.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<clement.leger@bootlin.com>, George McCollister
	<george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>
Subject: RE: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
Thread-Topic: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
Thread-Index: AQHc/XOk1qmL4b0tPEC0CudH9P6rW7ZA+A7w
Date: Tue, 16 Jun 2026 10:19:46 +0000
Message-ID:
 <DU2PR04MB8629E9B6928DB2E3D6782A0488E52@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
In-Reply-To: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|PA6PR04MB11909:EE_
x-ms-office365-filtering-correlation-id: 82430722-5ea6-4aee-ed61-08decb90caa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|19092799006|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Y5lUkdD+tVcVpP729okBraByvRGgbDuPu2R5IeqID710La8ZpXYsEYr3A/+fmanv2a/mn80dJgd53ErqY/hO5JwFVXRLkayFYpHnZF2e2j9YSfM4ZuQCNtgISrlXQN0WLnL4dg6XLfjo9+2KmBinJ5aU5pM1RSYVkrwp3bCrwdQNjeMkG5SS6hwVWhqDP2StHPrqMd7khRsU/RspaaPcR698XjL4RxQZL6uhc1+/NwN2YemayxCzn/HINTiOqB2oDhxH+XOLerHwrMhSIhObY3uPq7rMAba957L2ixxxwnFDSZfChz1BWwCid8+9htbO09nMhM4VANUxSdBTCHxpGeTq0GTN9k1B0LJqo5j2BcFk76fOWwdIp8N6aZizuzamsKwJA2DapsSOXVNY813Qmvs7lkvETutS0gicGpGYDtJThuhaniRoCsl5ZQn4bs+pKGdbQTIBSQ43bLFw3QHxgCcdzb3RyT5ctZToo1zP/ENxcJW+wWtp79NyCwB+n4Cy+quvJZyYU5G1idyrqRTldGJujIABXZf8/5NyG5vBLR3axBPC6xKktEGJPyBVhUhZH2rQPn0PSYxtvICwkoJ8djEO5A/X3Dor5Um/xf/p8pq6uc5yy0CLWbgQjdB6zUdFuPmxbUmpZQg/okPsX7huHLMW2ow/2ZkKFYuMFtquwn6z85K9H8hTuSA1IrmMsx065jV2rCAVXBKfm69oUavBUM9LL47erwpy523xGRk8YrWeXiY/Ra1qVFAGMtNaIqTC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HAL/9ToI7UQSXy1DlSMOVZxCpxKzbxlSamjdsFTCKBsmlsvIXxk9tYrcoB?=
 =?iso-8859-1?Q?04XwFabSPIDFyzl39BOxbkT9x0PBtFal11F9TSGrTPlEE5CXZnHqaBLKq3?=
 =?iso-8859-1?Q?rco6MdZ4jARGRFfbHCRDzg/VI1re2/YV0GKMFzKDyKtcyN7cHox5m8iA+J?=
 =?iso-8859-1?Q?GU4AGpyQ/mXk7AcxEuASySSO23RSDCIa3S7n0ykFtHJ6+0ePLc6PbtDkFz?=
 =?iso-8859-1?Q?xAxMReCu8/SvwYvbpWuomzpOmX7R813mJOgyLe7mTJ4KjWP/86/BzKfG2n?=
 =?iso-8859-1?Q?zU8/wPN3UathA1oRqyVbkV9fBCUfsKTcJgbtgowzh+PXuDvVidDmaX5ECH?=
 =?iso-8859-1?Q?KCJFG/lVJddBNDML96AYxp1X6noA/wBSpiPHklzIRhUV3jDmA/UEj+I91+?=
 =?iso-8859-1?Q?DmpkYrrsfWOuq0ki5MIZtu3Ehpyv/CN+7o0wIjmWkxhNGpibTe8Xsd/sKO?=
 =?iso-8859-1?Q?GUmpFiuudyEZ/GFJnHg6MUkO5YvTtT0oQu4Vm641MOWZdR3sXXIDgvEbnh?=
 =?iso-8859-1?Q?hImsk1DXTbLFaEj0YgQIamyyUoeFGD3sCo7D+ryBJNFluIq7s1VOPjV5ZS?=
 =?iso-8859-1?Q?EXGq0I1UVk6d0eKsfjA5n73aoGpBS+Zosj5SvRacIa6b7Wr6qgVxp8mn8y?=
 =?iso-8859-1?Q?yiA5XspjfLszc/VBC1KfKngBr0pcS4zoPTOxl4U4moBhHBadIurIKSI3ZY?=
 =?iso-8859-1?Q?weDcnem3y50s29BuguuJ4wANJ07rB8TFK2erwrAq2NBVoYiYRbCb1e3x+B?=
 =?iso-8859-1?Q?SC+hhkuX2Q9RPCOPnqWrdEvxlBdeOsTnUfzXnCuyg3glQS7OBJsY5OE6Ma?=
 =?iso-8859-1?Q?5k1WlwndHSQczfoaU6P8TWtR9Tl3ksqwvM2nsuuFNHNoNsoCAfAf4odV7y?=
 =?iso-8859-1?Q?7zeEsg+uGF3YzIXNOQCTsPbMdCiVrDy3GVE4c0fjuq0q+LO6LXU4mBtfAw?=
 =?iso-8859-1?Q?TsltUZjQg37ItfjVn1JbENZikijZipSuRLn10b4GllZ8LSLApOODdK5KSj?=
 =?iso-8859-1?Q?8tRgwcKDUjk4foETkCKXxl1rCCz5rCj4sSo3IH4ff/6MMh7Du8858m3dk4?=
 =?iso-8859-1?Q?7Ya3VOQI+XS/aSFr6SjP1ph56fPSHHRPIj94bPVpuOcZj0RQo7s3cO3QKh?=
 =?iso-8859-1?Q?S82NbhvT0/LFpQ5XNFtT7oIsMX6qhx4WjVLucm4D7wiDNg4pD06tFko7hs?=
 =?iso-8859-1?Q?4h15M4u33E5BsugCfDrIMTEvQJ5iAaf19BnyuhkGaoZaTDqPA4vXDCWs4Z?=
 =?iso-8859-1?Q?d0bLqDrHNbYEZGmpWjgIH54Kl3y9ZiObuDhhhwM2Ovz3aKfaDZARdARsbB?=
 =?iso-8859-1?Q?8xyo/lqvsf9PJmPOocNsn2fXURYv46NMvWfyltfuqGFDe/VHW8ufSu+0Yc?=
 =?iso-8859-1?Q?aAKApsf1/jp4g/WtEbRFtOHJTQ7XdY/kBu89V9aD8nEKieFkn2BHvajOVJ?=
 =?iso-8859-1?Q?iI7R141YpItiF/poV6f3Zq/V3M/nVaxSQPccBHj3xdS82oalQlaf/z10II?=
 =?iso-8859-1?Q?qbvWqxVSpjXtMG82dPWgdMp2D6xAXK3lFGQ0Lmyev6775MSCB5xjqUhRuU?=
 =?iso-8859-1?Q?F4WktD5U+w0VIZDLz0p+9gkCNUAeiK8BTMN5ww5I87WElgVMc/3T6HsZUZ?=
 =?iso-8859-1?Q?bZllnjIO5y7h3en5380wXVy+d/knw1P4NdcrzqPmBHjkw+q4B6hKq3Pte8?=
 =?iso-8859-1?Q?LOVAuSiO8nZOLbk1KOplQt3K6rXHjzErWaGtkyx1oTliB2pMnFxALA3I1+?=
 =?iso-8859-1?Q?Y8PFNB8sU4ZSTEHRFS1YQf6dV9ifPXYNQlIT1ugixR9gy0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82430722-5ea6-4aee-ed61-08decb90caa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 10:19:46.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbB/mAHZjId45+3YoaVfyVRQ7vy20TiuvoCtOlrEvCQJsNJpAEptoBbne8oUsmubJt4PXyb9VFddplqb6gCZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11909
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299801-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,DU2PR04MB8629.eurprd04.prod.outlook.com:mid,nxp.com:dkim,nxp.com:email,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED80668E56D

> The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
> vlan_insert_tag() will consume the skb with kfree_skb() on failure
> and return NULL.
>=20
> When NULL is returned as error code to ->xmit() in dsa_user_xmit()
> it will free the same skb again leading to a double-free.
>=20
> The idea of dsa_user_xmit() and dsa_switch_rcv() dropping the skb
> they held before the call to ->xmit() and ->rcv() is conceptually
> wrong: the pattern elsewhere in the networking code is that consumers
> drop their skb:s on failure.
>=20
> Modify the ->xmit() and ->rcv() call sites to not drop the SKB if
> the taggers return NULL from any of these calls. Move those drops into
> the taggers so every callback error path that retains ownership consumes
> the skb before returning NULL.
>=20
> Keep the existing helper ownership rules: VLAN insertion helpers already
> free on failure (this is the case in tag_8021q.c), while deferred
> transmit paths either transfer the skb reference to worker context or
> hold a worker reference with skb_get() and drop the caller's reference.
>=20
> For SJA1105 meta RX, transfer the buffered stampable skb under the meta
> lock and return NULL while the skb is waiting for its meta frame: the
> skb is not dropped in this case.

Reviewed-by: Wei Fang <wei.fang@nxp.com> # netc


