Return-Path: <netdev+bounces-304826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TA7YKLMSS2p8LgEAu9opvQ
	(envelope-from <netdev+bounces-304826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 04:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F670C1D6
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 04:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="dU/PDrvI";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304826-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304826-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81582300614F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 02:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38D37CD2C;
	Mon,  6 Jul 2026 02:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407832FBDE0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 02:27:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304839; cv=fail; b=d0M/Ju2m0ohTP6BuaT93pXgudvMuqJDPQYyJhF/RYpaBZzxPKpcosN5fFA466XAzgJfNE+jZbNKHyeq4nen39qpMdL7/28oQI0N70HvDO2l1QVZqF8fiL+YsvY6z5WgPYmBZQaHBYpod4x97affdQso+TlViW3VZILfPxb+6fzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304839; c=relaxed/simple;
	bh=NPzQjGlaHp/MSNIp1rUBeRysJEsGHTFC5WYpX+AXSxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGT9+kLkx1xp4rcmZrgQRT7CAE4mJJfZwq/gbmr8f2s6GvznA799qdY0i64UhmJLBhRvePx9lRmCdq/ziGUkmVfM1FuOENm9vRp/T4EkkzM6/F7IFV6A+vEpdn4YoeqIP6xtAG1o/rf61ct9WAEMTPEMggMLY1SfhOzS5OWX+qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dU/PDrvI; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9WYsUZS7BZmlwjKlYcC7M2VIa5TyRxP7GOxqD52LqRpF9D+9gsYpW7e2TXTMBQKN3+tQFipdzUA5nwP+/w7xWWNnqVpu4KDQ+8v1tH/Vg2mAP+P20GD5BMTCoY6mTzUoGIMAvxQWEgtg+Tuc7mAbCBuP5J+7/ndyidErC5je9QLcRyNFyLcYU0baYERZPkjTOBcaSqHUfKW7L5tuCzo8mdc87wCq0d2CgCW4/5WXFjRAoyNRcUxhshc2mIyHKlvBeTa1TiVYBfufVccWZHK3jNxfeuzpA0bPPmzCGpKypM92cLx1VQzhPqey9iw/m6M0om2X7mFXvwB3A6iCOR3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltFs5X+UI0sdAOMoJW88OuNsgNNs27hss8Daiyq9mQE=;
 b=WfxMRFp/+2hNNFH/1v5GjRmwLYsQwbHxh+BrlIi5sU0MO+syFipTDN6vbkyiGdkI4nUrxkqh72V1UU7O9RJQyufLKkNx+0Zdtk6ZoEz6O8gUPoC2qCxM3tv3fwmWA5Gv0EBGIKtFPiliBeVU/lF8WWW9c49OoMQjak9MnvU6iP04hAR72HaxyhyUoibQ5dU7Ou71RtW6ONxyqKW5N6NNWBnAom/9LchbuOV5nIK13dzxnPmpuz1p0FZFIkcwPm9SXYSaVzd+A+L2iSvmDd13R1HMQt+GwjjDiiISPrGaLhKV2P/MHFOnu7lKZQhRgdLChB6x87XE1GuvClaKh7e7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltFs5X+UI0sdAOMoJW88OuNsgNNs27hss8Daiyq9mQE=;
 b=dU/PDrvIcUQsNuvJyuorc+SwH9xOFtDH/EfUmb4gNWwwcCIN0u2UrNBuZw5zhGZ5H49gCSA1aOnWz2gdogFA/uv/Qe5OCq10FkMxPUsotv2pGljkgg+IAVo2oXDJlcnEzuF2dRabhQ3qxHNM9aMZGC3w08nGlEJPI2QzFIvvUAs3JpmsATIVSddOUz8eYgcMNG/6AhS35joN4ibuDwdk9fUvLNcdNvrkCFiwAyu65/xCdlHHoHY/X3eT/pl2KPhc765uHBlcC/zZG4Z9EBWHWX3Lj8ew1BMQJL623FDHVgnccLQ9W3w0bgkDhJb6rrKEz7BR/VgWGSl57pX8gpjlPQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS4PR04MB9412.eurprd04.prod.outlook.com
 (2603:10a6:20b:4eb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 6 Jul
 2026 02:27:10 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 02:27:10 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 12/14] net: enetc: remove redundant num_vsi
 field from enetc_port_caps
Thread-Topic: [PATCH v3 net-next 12/14] net: enetc: remove redundant num_vsi
 field from enetc_port_caps
Thread-Index: AQHdCtjEfvc9w9H5EkyJWpXYqeiHgrZdLkkAgAKZ5xA=
Date: Mon, 6 Jul 2026 02:27:09 +0000
Message-ID:
 <GV2PR04MB1173938D9F16EA1D1AEBD596B88F12@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
 <20260703101328.550714-13-wei.fang@oss.nxp.com>
 <20260704104346.D7A561F00A3D@smtp.kernel.org>
In-Reply-To: <20260704104346.D7A561F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS4PR04MB9412:EE_
x-ms-office365-filtering-correlation-id: 8454824e-efbe-43e6-7f75-08dedb0614ee
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|38070700021|6133799003|11063799006|4143699003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info:
 R7D6J1U2Qcz9xX4vDy9mGNFHzhR+CUMo72c1v2o/c3TtHU2MaC+c30FlteUWJNCRACIKY48mGqOUzogOy079TxzgUyi5YL2xoxSHx7ev1hSBbSaXVKPSPWQURTvqE87RtRQSKaMxo2tdZg2y+xjLU5phq/sPiyJzP0xTJdOtFRlNsEJQ8iUj6PwTU2KBC1UaQz11yTHzpd9J3YqF9Yxr4r95baxfb1529L4/hfaqq9lhVHu7mm6OnQnHNttGSlFOKItdQJi8Y/pHz7YIdMHjWu3bjzHH/tsnohHB1Moq5fOzXD8rUBvVZ/+THyQbur1g7m/BRPZYSBYXmng2p78X9PmAr3189QseB4qsxeAQhQo3h72TGjL6cFz9sqgDMTgnBDpCuwdXHj4IV4p05o6RF8OtZgfB256Sg/psxPuOidg0vaPMY4w7YF8uKJcHFDpDjS0+iRuTH7+N5gaHidboIZdpkUJBrPeLM/llwYbjw06c2TfaraI/Khzi2fsNmETruEk35Rq7FaxXgiHJ3qYzXzSEVfc0ifOCWADZUaNQaf2zEcWifaARF4+thE4FLL70F2Pe3boott/H1zeSrXFUpUiVzs/tp0HC/P30VI7QUp0nG3wDxcTy9buSclBWPTwE+yEjzyMhR0VOpnYrCPh4Cg0c7Ouxr/zleC3+kQNxsfaRIUmHjYWURSu9aiPmRfTE9UHk9/rIo279JAvECspUBG26GZFXtU2BiwsMZZEYPGA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(38070700021)(6133799003)(11063799006)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WuZMopkOhA9xpJYHbak7kbx6/wtL0MJaHFBaAKS05GJuUJYDZ97SDcYEVTjW?=
 =?us-ascii?Q?clhBIIW9T0f7csegMFj+fC6oNDNUlshqTu9JOjPOv9VveuLQn2S/5mXRIAn7?=
 =?us-ascii?Q?zekNtRSVwMyEMwY87Le6PAVuk0HkAj9AAJe3xl3SCgvuKRjWwA+6K+bynA+y?=
 =?us-ascii?Q?MrTfNQ7YVLxcTXP0tZOooJkgIzJdFrBCwn7XwzswMu0EPnvwLUr+TMGykN17?=
 =?us-ascii?Q?C3/xzcy4jAs+sDIINJpvzAng+yFO+5X5eNk4xUW400mcGYzdGaSGpfl8Jwz1?=
 =?us-ascii?Q?xve1TplMMsldieB8+JUHuUX8pc0KH1XcImwX0HGiBbQbHtMKZeGoa5udtxeL?=
 =?us-ascii?Q?wSMkVrdGqnud33y6aIsTr5MMh8aiYr4Z2T6S5ejI6bRYnEO8kj7F/E9qGMHK?=
 =?us-ascii?Q?7C5trUGktq0YtZgrWoo450t4Btkg6IuViZETIHjuV9w6R016/tOhsd8QH5A6?=
 =?us-ascii?Q?2D/mRPSo+ZZH1WTklwF6rda4AELKHkusvxy3SFaeTHie+zs85+8ZEELu4i0A?=
 =?us-ascii?Q?+xORy/L1ptMUS4jwyT/olr9lJ7yaO8/uqOQY6OJHO97Xu/NmF6U9rREt+BYl?=
 =?us-ascii?Q?vlpizFUyveuntzhC31gN4GjezLsWWMnTXbiT2CRF20cMlNAOCtBJ2pWwWhLW?=
 =?us-ascii?Q?QHy22MxThzUGpEIO84IBcMvRCqRskoOneShxc55qgeRsgy3HBVob9hHDJhJp?=
 =?us-ascii?Q?yMjp+bKNcCzVn6JwpHs8vbbHDzkTzJQHtMRQbRML4ad8pbRTexdfS325VZA+?=
 =?us-ascii?Q?By4zrdteRpzip9ZhD2H4+dMB/LEIlVLQtXBnVbNx7+r/bER+ANxThaFKJDLT?=
 =?us-ascii?Q?wOPdsiW+hGSsts6ruZCZa3LOZ6NEVqvO9IQYL6UIwOlPH7cgaif8Nrvjo7NC?=
 =?us-ascii?Q?qIXwqlHdpdRbkJRaOgZYKyUWYS7Hbz1p7jo9GgRUDh5Qfxs7u32G25s0WjK9?=
 =?us-ascii?Q?RN2K3EwXV9mzlE6a+6W97sXfxr6RtW9oJDsutcLVVLr0lCNTmWrX+bnmftYG?=
 =?us-ascii?Q?uqx8IkumuM+g14eN7aeYFRfAWdNVxInF8suFBmuB1bzOP21iRUd4EVY+g03x?=
 =?us-ascii?Q?c1QPodirO23T+UBMBkqrjlsK1FpcVJaIc24yDwkGkSNHmFnpULBmfwrUOw4e?=
 =?us-ascii?Q?NdlkUA5UiYSSeKFfF51ShDT7WT825LPeUWoqgkuz+wyzTz3YLxGggn3y5SYX?=
 =?us-ascii?Q?jM/Jsdl81zoeui50qJN5w0lBlVIlVJRRQ+beFvZFLjFHHe9PUQusKibd+/m3?=
 =?us-ascii?Q?57CxbNOO494YTgJ84i3oLqET0vudVa7GQl2+FNmFklnsoB1/Z5EzCAciIhLA?=
 =?us-ascii?Q?J37X2B33fNWrCNXlTYLciDL6EWDFBKATwiFaGdEvITvXnwJKrZGiZLQmZZm6?=
 =?us-ascii?Q?egEG8ZEnrd0/avt4DI02uh3QQS3/LGovMHSvCn/cfrqwFmTYF9uFFC550K7i?=
 =?us-ascii?Q?O5Fr03x3DbtaudPaMxMX0niSXNqa2DDizzTK37WGCMWJu+egFIt1m0esZJJp?=
 =?us-ascii?Q?xrr/NytqYplFy2wjnptSNWlo5DNHx367Hdyyxx4btETEB3FTEyxgYgSKFRbT?=
 =?us-ascii?Q?sgOytdN4kwI1a0poCWDRjbmzTBvzffX59Og3gkNxORvjHLdIUtCm2xqHk9mC?=
 =?us-ascii?Q?0H3mpV9A4UY71GRFLBEuXej+z4pplRuVg+ClHa2CmCqq68Zee/ZEUrgU0m3v?=
 =?us-ascii?Q?t4YktXGNqm1ZL/SEodZGO1kKfYX+CRTn0jQ61+tALH2yHUvl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8454824e-efbe-43e6-7f75-08dedb0614ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 02:27:10.0178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xVS+ZCgvq99QbjX8qsp6Wcg6RkkXjSD6URj9E4UQqVFNISYd6mQYD7Ncdi/T9yyPbBWgL/SqLg1qqI0ejPTqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9412
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304826-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E91F670C1D6

> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> > index be378bf8f74d1..5029038bf99fa 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> [ ... ]
> > @@ -28,17 +28,14 @@ static void enetc_show_si_mac_hash_filter(struct
> seq_file *s, int i)
> >
> >  static int enetc_mac_filter_show(struct seq_file *s, void *data)
> >  {
> > -	struct enetc_si *si =3D s->private;
> > -	struct enetc_hw *hw =3D &si->hw;
> > +	struct enetc_pf *pf =3D enetc_si_priv(s->private);
> > +	struct enetc_hw *hw =3D &pf->si->hw;
> > +	int num_si =3D pf->total_vfs + 1;
>=20
> [Severity: Medium]
> Could the unconstrained num_si derived from pf->total_vfs cause undefined
> behavior in the loops further down in this function?
>=20
> The original code used caps.num_vsi, which was structurally capped by a 4=
-bit
> hardware register mask. The value total_vfs is read from
> pci_sriov_get_totalvfs(), which returns an unvalidated 16-bit PCIe
> configuration value.
>=20
> An arbitrarily large total_vfs from a misconfigured or malicious firmware=
 would
> cause PSIPMMR_SI_MAC_MP(i) (which evaluates to BIT(i + 16)) to shift beyo=
nd
> the bounds of its type when evaluating:
> str_enabled_disabled(PSIPMMR_SI_MAC_MP(i) & val).

Actually, the value of ECAPR1[NUM_VSI] field is equal to the value of
PCI_SRIOV_TOTAL_VF register. They are all determined by IERB register
EaVFRIDAR[NUM_VF], which is 4-bit field.

When CONFIG_PCI_IOV is disabled, pf->total_vfs is 0, all hardware resources=
 can
be assigned to PF. When CONFIG_PCI_IOV is enabled, pf->pf->total_vfs is act=
ually
obtained from the PCI_SRIOV_TOTAL_VF register, while the ENETC hardware onl=
y
supports a maximum of 15 VFs. And for ENETC, PCI_SRIOV_TOTAL_VF is a read
only register.

>=20
> >  	struct maft_entry_data maft;
> >  	struct ntmp_user *user;
> > -	struct enetc_pf *pf;
> >  	u32 val, entry_id;
> > -	int i, num_si;
> >  	int err =3D 0;
> > -
> > -	pf =3D enetc_si_priv(si);
> > -	num_si =3D pf->caps.num_vsi + 1;
> > +	int i;
> [ ... ]
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index cab79f81d6fe0..8d536a3831e3a 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> [ ... ]
> > @@ -255,34 +254,35 @@ static void enetc4_default_rings_allocation(struc=
t
> enetc_pf *pf)
> >  {
> >  	struct enetc_hw *hw =3D &pf->si->hw;
> >  	u32 num_rx_bdr, num_tx_bdr, val;
> > +	int num_vfs =3D pf->total_vfs;
> >  	u32 vf_tx_bdr, vf_rx_bdr;
> >  	int i, rx_rem, tx_rem;
> >
> [ ... ]
> > -	for (i =3D 0; i < pf->caps.num_vsi; i++) {
> > +	for (i =3D 0; i < num_vfs; i++) {
> >  		vf_tx_bdr =3D (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
> >  		vf_rx_bdr =3D (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
> >  		val =3D enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
> > -		enetc_port_wr(hw, ENETC4_PSICFGR0(i + 1), val);
> > +		enetc_port_wr(hw, ENETC4_PSICFGR0(i + 1), val);
>=20
> [Severity: Medium]
> Could this result in out-of-bounds MMIO accesses if a misconfigured or ma=
licious
> PCIe device firmware reports a total_vfs value larger than the actual har=
dware
> capacity (e.g., > 15) in its SR-IOV Extended Capability?
>=20
> Similar to the debugfs issue above, replacing the hardware-capped
> caps.num_vsi
> with an unvalidated total_vfs causes this unconstrained loop to write pas=
t the
> instantiated ENETC4_PSICFGR0 register bounds.

For ENETC, PCI_SRIOV_TOTAL_VF is a read only register. Its value is derived
from IERB register EaVFRIDAR[NUM_VF], which is 4-bit field. So I do not thi=
nk
the total_vfs will be > 15.

>=20
> >  	}
> >  }
> [ ... ]
> > @@ -299,26 +299,25 @@ static void enetc4_allocate_si_rings(struct
> enetc_pf *pf)
> >  static void enetc4_set_si_msix_num(struct enetc_pf *pf)
> >  {
> >  	struct enetc_hw *hw =3D &pf->si->hw;
> > -	int i, num_msix, total_si;
> > +	int num_si =3D pf->total_vfs + 1;
> > +	int i, num_msix;
> >  	u32 val;
> >
> > -	total_si =3D pf->caps.num_vsi + 1;
> > -
> > -	num_msix =3D pf->caps.num_msix / total_si +
> > -		   pf->caps.num_msix % total_si - 1;
> > +	num_msix =3D pf->caps.num_msix / num_si +
> > +		   pf->caps.num_msix % num_si - 1;
> >  	val =3D num_msix & PSICFGR2_NUM_MSIX;
> >  	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
>=20
> [Severity: High]
> Can this cause bitwise truncation and starve the PF of interrupts when SR=
-IOV
> is disabled?
>=20
> If CONFIG_PCI_IOV is disabled, pf->total_vfs evaluates to 0, making
> num_si =3D 1. The driver will then attempt to allocate all available hard=
ware
> MSI-X vectors to the PF (num_msix =3D pf->caps.num_msix - 1).
>=20
> If the hardware supports more than 64 MSI-X vectors, num_msix will exceed=
 the
> 6-bit width (max 63) of the hardware register field PSICFGR2_NUM_MSIX.
> The bitwise AND operator & PSICFGR2_NUM_MSIX truncates the value instead
> of
> clamping it (e.g., 64 & 0x3F =3D=3D 0).
>=20
> This programs the PF to receive 0 vectors (effectively 1 vector due to th=
e N-1
> encoding), starving it of necessary interrupts. The previous implementati=
on
> divided by pf->caps.num_vsi + 1, which structurally guarded against this
> large allocation.

This is not a problem for current SoCs, because current SoCs support a maxi=
mum
of 64 MSI-Xs, so there will be no truncation issue. However, if future SoCs=
 support
more than 64 MSI-Xs, this will indeed be an issue, and I will improve this =
logic to
better support more capable SoCs in the future.

>=20
> >
> > -	num_msix =3D pf->caps.num_msix / total_si - 1;
> > +	num_msix =3D pf->caps.num_msix / num_si - 1;
> >  	val =3D num_msix & PSICFGR2_NUM_MSIX;
> > -	for (i =3D 0; i < pf->caps.num_vsi; i++)
> > +	for (i =3D 0; i < pf->total_vfs; i++)
> >  		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
> >  }


