Return-Path: <netdev+bounces-286913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJF/DeqIAmrVtwEAu9opvQ
	(envelope-from <netdev+bounces-286913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7C518834
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33359300CC01
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A52727E2;
	Tue, 12 May 2026 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cgz9sZqc"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226EC246783;
	Tue, 12 May 2026 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550890; cv=fail; b=j6nlk3kd6myQXi4QNiLURQoR7SreMpcBO3TYMUDIY8MQAPzmHQJ+8m3XhDoahQxPvJXUkEMuNi9eSxkLQ+R0RhdGGg5kHDs/NJtNugVMIWabZ7mbBwxn1YPBeQvpoGfwnmEdHd3wizWIE50O7qviBkarnTRKbphLOBp6glpfq1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550890; c=relaxed/simple;
	bh=OJD0S52rvzLWKElG2qMZyq/Akj9yurNdGXqlPGnTb4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQTPxdtQDiAyzIFKfYyQuhxoUgVG8dbPCrIcDajdKZTGQ94KwJTURJZusqiG9S2b3z2/TV2CJNeZAsEJ+F0nDAxNDW1piblfMNnhNxL80WpqC1xT3sI+M/B89CO70FS5ZBFx2c5aCPHayeD3ABX+rctwekuwiQZgbEc3bRNj3xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cgz9sZqc; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/d5uR5aC1W153OmuMP+f77h9w6LBN0OSxpIOsvHdqX3SWTvH6hZw2HpGp9bI4fGQUNUqm4OJls9GjEXxNhbGv7Xg6T/aJUMaoXLD/55LUFRyaOCiBn4FjFr/AeTSp6TmDdNd6Ih+BEerONEjMrVJNPKKCjk3y1GHffb+1FRCfKwfypCSt9/Grq4Xzl/n8Orqq8VHE6FZA6zYhTR8KuEeTM4qlJBnp8TfOORW2nL8Of9ZENyJYO/2jy2fWd8szrwyHE5CyH9pjHlUR4E4hTHf18TKAuEn2/+w3uHtaapVAcV4GTOjrs1WBD6HInneAmqdqm+g8CIJNmgZ40mH2pLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ7JFQrTlFf+qGw6Qz7xt3pEcxTSVKB97Jty/mi/SfM=;
 b=qFyFP6ByDXztUMJA3H7GMWhjzHQKlCyNH6XN1aM2hI/dIOtgCeRJp+g5xVQdGJppAdfIl1Y5VyZIwpnTM9+Zmpj2mKrl2JdNE1HfbFWfePc+lpRnuPsy09M5L6etPueU3bcWzEW17AKRIYisNH3FzDkADGTGqSdB/B64L7sy1cFEoJ5QNim/0NwW06JXNuu3azkWZ/+JDwvf9YGSAqmUjliM5nYLgaeei8loia93Havk0k4SUdbLvJ291HYHHlFakpqvGGxq+1uNYsFQFGnpd6nPFXxYqz1ORir1egSKsEIoz4alTf8MREajK+5nAF/90XNrgQIvKTNHhn1z5fVLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ7JFQrTlFf+qGw6Qz7xt3pEcxTSVKB97Jty/mi/SfM=;
 b=cgz9sZqcvkjXPD7IgpK6U/izyh0oCYGY58e5fnAxcMYWQuLPhlLX6XKkzO9cIUcA7M7A1pghE16d4OQPyGenqCIxQXwYEy5zaqkQ8MGnSHBRUV+kf28/kEea1foy5M4oDeUOWv/BuBks7++Z+h0cH1WNOwt2+FEdZCcy9lQHvww66rIcWCE/LH78LayXbTBRwxmyYLs6Ms6OF3JugPfgXAt4gMuX1fAS7mcNA7jEKMdvB3UR8G3/vJICAIkJsXQlSK89OlUV2M84UNcfkgUf27N/Cngx5GWIqxGNreVRMWztKVzM0COfEsyNncFVMVQ9Oxg7/O6znIvRBhlsnr/c6Q==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 01:54:46 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 01:54:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 01/15] net: enetc: switch VF primary MAC setter
 to PF ops for commonization
Thread-Topic: [PATCH net-next 01/15] net: enetc: switch VF primary MAC setter
 to PF ops for commonization
Thread-Index: AQHc4SEDj409e5xQSkGhVwr//iFeJbYI9vwAgACpzFA=
Date: Tue, 12 May 2026 01:54:45 +0000
Message-ID:
 <DBBPR04MB75007311A166AF01F536355588392@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
 <20260511080805.2052495-2-wei.fang@nxp.com>
 <20260511154124.u77vbojcyhic27d3@skbuf>
In-Reply-To: <20260511154124.u77vbojcyhic27d3@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DBBPR04MB7929:EE_
x-ms-office365-filtering-correlation-id: 70632310-fcb5-4c2f-5e42-08deafc97166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021|3023799003|11063799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 yeYFHryQ5ohLspF4B+jIEkhuZKMthxq4yJmwvWILlZauHnb79v7EHarkNRoupS+OXIZ8coN127TgJz0P9nmO3NOfxVRFM/rgZkljZ6AGGl3ekgh8gBtTPyHMroBTq2m9pwHk+g5ZeFMI3e/qLAn4xEOwb92IwSSy4GB7Kd1dnW3rkbzfiNLfjief3wFcexx5f4s3dBBdsu+TfpavEY/Zot7CUQT/PHjQXcI7Rzo+qiQDmA4zfWtADnvKMYrm1l2TAZzvabDPa+r8iOqtzjEuMKHKcQNb0k49U9QKlppDf53aorMBMlXm1b7MyIpi7l7AueVPz2aeQyC3hGsiTYD6/+Aj4DKr/NFXiNjECsXutb03vu3dg4nXmqOOE1r5xTQS8Fj0JOx9LwJy4+cPbWiMi/9CPdl4t/xGd435GEtL46qP/CeClCRyB/XFWlpYSBkJUGWSLH2LAPjC8s/sEejAysrMVrNZL1t9KQHf50vnUNne2eArlAulxYGS6Nhpdx2cMx+h0klumziShpHX3GjHNajxJLP94mmhr9yOdyrOLsGKS2u4q3te4ydh5jwQKAANhiNMdyoqtn8WDeogxTMC8n1lWGUVTP+CIVrmCLaYSaK9+COkPwLwMJoTnb/vPyBZ5Rp5ARoYsXjmgX/FxjitcEhbEQ2jd30ioHcPj3GmUEaEA6Z+FL/r8U2CCIYLJkzE9MtMbm8sYnIrlwcrvN8z4W2A82BBhTlFJ3nOWZK+y/BNEYKQMfKR5Z/Tgwomw0c7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sX6+9kaBpnXasnKi0VEw+KP+r7nd6HaWaYCQJLjfx3cRmptUR9K/Bpe5Aq4c?=
 =?us-ascii?Q?ua4HPkLcWQTDv5b4Dx9AxBTijXEOHC+A1Qoq8VfNq4AZTW01rF25NZkAiRnH?=
 =?us-ascii?Q?vJbRgAFy5AMHnyNIty/veQUdHGJmLb937TYCfiCZAKzCH81jAFTuVl42BGHH?=
 =?us-ascii?Q?8YCp2OzlgvPAbEP1ZiRIStOn0mb6Kk9BBjAKmPfwKe5GOv/xGX9M0IQxdxGt?=
 =?us-ascii?Q?ILoNXje1PYfErf0U4NM3JyyR4wtlN5iDQD1meaOgnoJnRR8x8Fit1ct38Iar?=
 =?us-ascii?Q?viD/TFfyMDcKElZEj9D+Si5uTRtxIaAI0xoEvZADMplvGUwuGRXsGVD+WSPt?=
 =?us-ascii?Q?0EkOB5M1DimOLSK4e0j//lkSf4GhVjn4zuSN2XbVOGJ9qwMtvKPfbxbpPVLj?=
 =?us-ascii?Q?wyC/Ryum3iBp/RazXWV22CiqqRm1SweNKEfhLiVGWe+BoBbop4Y87GBTnoh3?=
 =?us-ascii?Q?u8HBgH17WXUbCadVlByhmSly1rWz+mfghdy/wFmIWs47vLA3u/MVJCi2p6mN?=
 =?us-ascii?Q?S7dyitiZiFQAZdaDEUux/gj9O8WlqA6dsMZw8yIv0MMnZhrkJtlWAUEqxhSY?=
 =?us-ascii?Q?DK8vrlv7NuiekkpoT/rFHWPtXiy8/rMAhOQZWJ6RrX+WF6yVagAr6s4MqXb1?=
 =?us-ascii?Q?7aqIWKrNxe7dCA2tKnv0MmsagnNupFs/+6bwSavQcNypWjycKBZeV9G9yEIl?=
 =?us-ascii?Q?Nxkphy1240gS3gj+zYOpBC4tf57fWkkYa1Z2p++6g72g7x8sZWpGlwt1N8h6?=
 =?us-ascii?Q?Melq5Kid3seGbDCA3DK9K0FuVMY9DNAvWl2zX5Fz5IGWbdBRIucQt4Af+KrW?=
 =?us-ascii?Q?Or9m9hjTmqKH1FrirYVF9SUrdRzJqh9XnIcUOKFp6HI78OtTdfNNOrYoROBH?=
 =?us-ascii?Q?Lpzb6AOdugON3xoykXoi4lU0LNLB8usvMRrbavIx91N8GYY6lvQhy8qfoiEb?=
 =?us-ascii?Q?oG69ba2MhV24IQO+tYtvXaI3GJiUKM0xy2cUzgMH8Cit7mFSQS34iKd7W5Pj?=
 =?us-ascii?Q?HalzoGEEHg90/dF32OlDel275xhnO61lMzDaug1z6A5La0mjYYH/DQ4LCtg1?=
 =?us-ascii?Q?+U3fKEwlEVrONdphDv33YebiWqRMK10MDdMOY39nnQFDnJ3eSFUOy+/N3sgt?=
 =?us-ascii?Q?/B+IfOctYNPDQ+j+l4X3WvMbwGciMhuo2Io7wN7nqwiG6ys9CRsUzAtw/ZfO?=
 =?us-ascii?Q?Rwy+OAUGCM4AFL9zl+qQzNXXOQ8gH7KbBqrVV7Po+9IGOs5gzVCIr8C55kHb?=
 =?us-ascii?Q?ifLFt6iRUaBV7CFGWWi6QlRqp9hI77q0K2bK551vw+j/3Xh3cR4dS943LrTL?=
 =?us-ascii?Q?kT8n3uLhcnpvhnQRJ5Ye6T39t8OhzGqfbJNsqaqLCtR9jl0beY+6bIv1KyhW?=
 =?us-ascii?Q?O1V8ClhUJ76odi11aZiI68F9vEfVpCGA30zXaH8GogoFnEkv1Iiuf7wesbZ6?=
 =?us-ascii?Q?yNAui9frM3Q1v++AvB8H+L9c47smdGK8bkf/nIYALA2VPWdyFKlcnihnHPfm?=
 =?us-ascii?Q?AshFHTMKWAguTRacqfD6jSbqgQDuFizYoagy9ymflXm5kMy1s5yzIG+CDBJ5?=
 =?us-ascii?Q?B2y9COgfd20G+3vNy0pFnzAeHAMeo5j4HvQ9W9tI3ZoiWPdHIp5wtaGPtMbQ?=
 =?us-ascii?Q?eOPZ7TZ1DX+Mr1eyStIz5L96k4ZgvQ0ufFQUpcJaKD1ySUROslEKiz83ZESt?=
 =?us-ascii?Q?Pc2oWoH5Mr/sqfW6eqTrXVrBoeOsiG+FcvzooQUiccqnAlZT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70632310-fcb5-4c2f-5e42-08deafc97166
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:54:45.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDMS6HKF9v/+tF5btZ8/HJfRxDVpuezqm+BdT+qsDx2RzArZn4K490zWTMnGr4TlbAulwr0TJCj+wzR5i0RyrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929
X-Rspamd-Queue-Id: 83D7C518834
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286913-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

> On Mon, May 11, 2026 at 04:07:51PM +0800, Wei Fang wrote:
> > Use pf->ops->set_si_primary_mac() instead of direct call to
> > enetc_pf_set_primary_mac_addr() in preparation for moving
> > enetc_msg_pf_set_vf_primary_mac_addr() to enetc-pf-common.
> >
> > This enables both ENETC v1 and v4 PF drivers to share the VF MAC
> > configuration interface. No functional change.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > index a12fd54a475f..9063255d8ca5 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > @@ -497,7 +497,7 @@ static u16
> enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
> >  		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
> >  			 vf_id);
> >  	else
> > -		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
> > +		pf->ops->set_si_primary_mac(&pf->si->hw, vf_id + 1, addr);
>=20
> Doesn't enetc_set_si_hw_addr() exist as a wrapper around
> pf->ops->set_si_primary_mac()?
>=20

Yes, enetc_set_si_hw_addr() is the wrapper for
pf->ops->set_si_primary_mac().
I will export enetc_set_si_hw_addr() for enetc_pf.c to use.

> >
> >  	return ENETC_MSG_CMD_STATUS_OK;
> >  }
> > --
> > 2.34.1
> >

