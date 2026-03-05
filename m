Return-Path: <netdev+bounces-264134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEgLER/mqGk3ygAAu9opvQ
	(envelope-from <netdev+bounces-264134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1620A1C5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A30305147E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474324DD17;
	Thu,  5 Mar 2026 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MYofXkQq"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EF23C4E9;
	Thu,  5 Mar 2026 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676636; cv=fail; b=GZ0d5XVDmYM96avWexwyT6ViLQbSJrmHw0z9tbp0i6i8kkdl6W8KSXyDolah7wSXxZ0/jtdx6XpS2g51CgCqNvH5a12wBAGn4Aahw4IuWFOb/LjUUGfTxpsJOWtx4yaVlv1X/1nY6Yr7wXKY9s85x2kRJoUTN4H1XgFRDmusK+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676636; c=relaxed/simple;
	bh=uauJIK9RFFthbrE96uwaBjGEctWCGyGegaFlS5xVDbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mvijxb46xthCL/rqEZbAuEIyccej1ZZ7WPbUqV5BVJyydPc8fIU3bSQYPVzlnYucoA2Tpm0RPr0xyeJVC6uTWY7Cxno98Zb1FqfL+JxzGFXOsSMtRoOgE/gi9cDrV1ZBQ9b/lN7o95F9FzdKIx8Y7x+0IgV5Gx3P6KrZlUsM9aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MYofXkQq; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV5gB9e3jofkbG/ZMktwxgc6h+e7qokKLWUvnaS0VEzMX+ebNydKSV0zCSJn8Xz0/RDMcZKl+y4Kd5nRxi5Vtr2IebNYF5iEKMXsD3jfiA+NxGgT6n4679JedHQll0PDl/MZo3azk0Qb36GluFVWt1UIb1OXAaoao/qIAirLxDhEVkcMUY1TDWna1qBX49SFCZEI/68HNOqTNa902HZgNYZ3GGb12Dh1TGyGwYM9tDHR1dWJ7mI2/LWXAGl2S3A0gQrLXd5ZuuweOMnoKI2GzhdKiIO8towNDr/cWkSLg6HdEcT8s7+Ppb4Bd5r4B5G+bCSg7kAMxKk9U5hCclKOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAj9SmtZVfwpgrpynd3kzzss0OV5lgP4qT7vYqkSsEQ=;
 b=bjd3mWfmZMSGUgBqYlVbEH/Zoh8cbKNddf1VU+tGTCkuwYQLA3m+/3LWmEnCzIaZaabU7tPaXeiQXG9A0HBTlqSs/uBGLUnn7rCCXp2sjOY3U2DI2jS1Md4sAxPIobM0gTHBE1krCfhkU4BptjitnbCqQe1mYAds1sMkFG0+3GocDr68cXsQsXvoeQxpFNPEgmaDA9UVtrzWvz5mFFTZLeUA1iKU/WO733/KDZycc7jH09ijei2z3dVs/lVe6cwh1ldGikM0suzB7sgFW08qJI9Oa1xPWxHnOwg0VaSWPryCpop+tnMj0Qtt/Qf+h4za3deb+/AuJUnDTCwH10/K/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAj9SmtZVfwpgrpynd3kzzss0OV5lgP4qT7vYqkSsEQ=;
 b=MYofXkQqQlQv70naInRo54Z25lgQCyCUdIyAvTI6ylh133QfoHDcG9MuPTdJD/6RQN7Y+bcolvxi4Boi568ywiIIhyj982xW4WIF3IKkWTKS57zkDVSMlvL0OGpaTbd7XPM7ucAds5c+8ohlrBXn2azqOPqMgi/1lPYw2Mhy0t+f3tQq22zzR3O6X4JWh7okcxFGmvZfGES4+aCIndRkJbiHi/iIvxW7W+x+kbt3xCGdbsTFM+zsax0lGoNRzbXqaZzaiuhXmG4wEtilo+AsVEvRJCoyec5U1f9z7a5InEQfP/lQXTzhWtRjX0rDIYXu/KPHf40XNAbYnPsrPEMlsg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 02:10:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 02:10:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, Aziz
 Sellami <aziz.sellami@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: fix fallback PHY address handling and do
 not skip setting for addr 0
Thread-Topic: [PATCH net] net: enetc: fix fallback PHY address handling and do
 not skip setting for addr 0
Thread-Index: AQHcqviNV5i/rdtERUO7W2G6tFygxLWe37IAgABTFPA=
Date: Thu, 5 Mar 2026 02:10:31 +0000
Message-ID:
 <PAXPR04MB85104438CBA862AA45288C7C887DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260303103047.228005-1-wei.fang@nxp.com>
 <2746e5d8-b471-44c2-9625-b009e6f1581b@lunn.ch>
In-Reply-To: <2746e5d8-b471-44c2-9625-b009e6f1581b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB7002:EE_
x-ms-office365-filtering-correlation-id: b2ba2dd0-6e1f-41f6-54a2-08de7a5c60e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 gz3OfFBCTWL/5jmkXATHJzbdEwH/QLopbVl0kELQU7sc5HHfW34sGAEMY6ZH8G46goznbWHpv8Iuk6bX+0+9AZiZvx8RJrvKTqvZTAkcuQ3Dh/mQGObX5tfZ9vJ6+P06Z2eSenM0ALLSJOSRaKBz6NGD9YL6QPrrMEbbdDsji+XhnjAiGRi+d7LFK09usyl+3+v+9Bx6gzyss03FEc1DEQXGQ9T5JDtUuLZCr/zvEAmCj73no3VduuNwHw8Qc5qoSvr1gfR8VrDylxI4iry426X0TxlKTMWJuDiaowM5B7ruA/nLAZPeWW9jk9T6F74HfaCfMi76Ryd1Of3M2o3GI+PviYYoqm5HUdXIqN6sLojJ3wJAOGPkDRwF2THJxQkSnHhw3nxTyX33jZ/vKHUV8oRXgicRFWB2hfqhSJMlK2NdEALywbBsYz9O7sky0b2EPA2f10Zc5LjfMRiwR80aO/oGRhOnt3OUaJaqDziHkySkTRfS8kkj96EB+453L5xwTSLxGyc2/y2XdysoF1G45QZZiWOjiXVZAnseIwpLn/m3qGTFHSKwTh8PMeyUBXrP/A+mOqq65KfHOWJ6wE/7KdHigFncZkhl5CQn2NMXjCSWVejUQ7v+354RIKPmCo3UIIzqO5NthuJtAk/VodbmgeCv+VyXcVrcdT+6eD7UKZ/VzYhOcbLwd0hIOzLzisXaqij+h4SPLFJrh2BbyzM/9J2/CwhEmbacTWFxmT86dknqIWNa1oWiP0ZJNWafI9PKQJdpodZAiRx77S330WqMrMkVX1QtmFweNzWFeW7XVww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BkeNeJfSzSYTtJlAjs1Crvanb06UXreH6hWmws9fcTv/o5X4sMG+B/KROOrD?=
 =?us-ascii?Q?32v7FaxuE1Jfs8zDu8IeeQBZRoR1MUMDDs4KQAzwRKyArBgteVDhwFEbZE0A?=
 =?us-ascii?Q?sP0NTuNRGimYF/9yZv09GksuQ3CeV4jil/M7/KgRgQFGrzKqHQqu2DvoFrmJ?=
 =?us-ascii?Q?uH9+CVBMS6xdMY1JMCDpDaa7Ujjx77UeF8eJIRx12tdOESGjLbMiyATnVrfT?=
 =?us-ascii?Q?cT9chCM/1UAjS2hETEFaVs2iAbzQpfHCZYukvsiSKlFbb4Q1cNKpFjfdZtiy?=
 =?us-ascii?Q?8Fvx4q1qEgR8WNAWHvk5Yv8hALU61NgedqH9tQkVHFB39F1M7jWVeL/nvANn?=
 =?us-ascii?Q?Ql7trzOmZRLxW1ln1r+UHPI7h4j4kMlGi/h34vlZO2lRYgJv061HjQ0iT8tc?=
 =?us-ascii?Q?RAUR8tcCy0O2GZTj4XVqLaPJMiTA9ZAKCjD3YR2qjv4VvJmMZhdhi7RkEIJw?=
 =?us-ascii?Q?wpMsjU46oE7v/T0cC8KvOKTE/jHRWwWCu+b99xAV9J8gAPLiOtqKQ8/9AY41?=
 =?us-ascii?Q?6TnSRTk7Y93XjjRpFAD1PiOHmjhEw4445R79VDZnwxqWmZ/kwSY5w2+BtTks?=
 =?us-ascii?Q?htKHgjms987e4z0A4XfGQdd2CwuCqVk8+gliANZds5IVEiktn6y8xohDTm5m?=
 =?us-ascii?Q?0s47s4CnNsczwMo6dewNiSCGGZAE74hrvrlHWz/al8i4DORt+4q6FHfhkjaA?=
 =?us-ascii?Q?GIiX+KrLJ5UlM4cNXO4ekopzJST0LJBtvVU1j1Aer2s5nnYyZ46YyMFoFZCc?=
 =?us-ascii?Q?Uoh9OCsvk108IoTBTRYsrR7ZsAJOPqyMK4M//oRseXSpkEdomGsfWtmjkhqz?=
 =?us-ascii?Q?eYYJuQNsOl6+15tNnc087cgGDu9FS04CR/CNuNnbWaRF0QgDS78xpP2dk4WB?=
 =?us-ascii?Q?xX4L4TXOABOA0LUMs3tCqA06GCzLFAA8wykd8VqMWO/drsuyOl3qKsnyXmBC?=
 =?us-ascii?Q?vdRcZ/BwN3QOUBhWshVfyGsl2RZZ/cenMnnRw4qYly8GIHaLgh6c3C1NRtlf?=
 =?us-ascii?Q?iujiJm+PeFlDTqw5XAYy24kp/6xabVr9AdZwNlYrAvqwKCwQ97qUI+dBcffh?=
 =?us-ascii?Q?XVan3/JbJuJ57ye5KR1np16sDlEGdfC1cBU5+8Af4xfiRUJcxfLnijQd7jiq?=
 =?us-ascii?Q?DU8+1mbqMt9qeTx4cYPMEnpX24JD215qe1ApYztnJx34qVFCffnTx5ly8ImU?=
 =?us-ascii?Q?PEqwA1ABXN+vVAr8pd/540DdmUBtab2p/KgTjAyWWmpATMSBkJ+dWhL9og0Y?=
 =?us-ascii?Q?/pRYaEeeeAm+IZqTY50wJz6kxlQUwFoK4Oj2yr5h0Qq1mjU14ESkCISZ4lh4?=
 =?us-ascii?Q?bZ0jnmQ8lYlF2IVsQmy0ir+qfzUZLP4xHV/QZ+7V9GqzJNVov6xENUP1Haes?=
 =?us-ascii?Q?w7GIWswXOJt3Ugxl9VDCurSom/nxhnRVXG0yhshw0f4Lf9LqYGubN3CqqneC?=
 =?us-ascii?Q?OSmuwZPbwVPwYkCgqLap9AiOpxF36YbwNpCtxHwrTzL1uI7wMfCOn60sF8Xb?=
 =?us-ascii?Q?CJXVTWhsZc7IPz3TFQFvrI/jp0qEyRjTkXsIbMp/oSnVW9o7u5K0m5NJKygp?=
 =?us-ascii?Q?vGNUHxJB3n6T/55dtLC9vcJtA1aGCc0+P4bIo3B5QxAJb1JeuPNbX7+ICA+8?=
 =?us-ascii?Q?EB/cO/nfjIX1OC/K5EnbnDN7eku3ufd10Wn6LdbNTGauGGkGrmYOo7E9qCMD?=
 =?us-ascii?Q?C73pqw1mPeDrxsgnxOW78WrZzH3wMhB62YMZzKy2t5ZLYf/w?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ba2dd0-6e1f-41f6-54a2-08de7a5c60e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 02:10:31.4442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NEPzJgB8Zs/yczyj51UVwB9XRKdySqU6F0xZIfQ6KFPd5mQ3aswe4THqNK1BsT18t4Fnkh1IcLURvC0EsRD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002
X-Rspamd-Queue-Id: 9AB1620A1C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264134-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

> On Tue, Mar 03, 2026 at 06:30:47PM +0800, Wei Fang wrote:
> > The current netc_get_phy_addr() implementation falls back to PHY addres=
s
> > 0 when the "mdio" node or any PHY child node is missing. On i.MX95, thi=
s
> > causes failures when a real PHY is actually assigned address 0 and is
> > managed through the EMDIO interface, the bit 0 of phy_mask becomes set,
> > leading imx95_enetc_mdio_phyaddr_config() to return an error, and the
> > netc_blk_ctrl driver probe subsequently fails. Fix this by returning
> > -ENODEV when neither an "mdio" node nor any PHY node is present.
> >
> > Given that some platforms may use PHY address 0 (I suppose the PHY may
> > not treat address 0 as a broadcast address or default response address)=
.
> > It is possible for some boards to connect multiple PHYs to a single
> > ENETC MAC, for example:
> >
> >   - a SGMII PHY with a non-zero address (selected via DTS_A)
> >   - a RGMII PHY with address 0 (selected via DTS_B)
> >
> > For the case where the ENETC port MDIO is used to manage the PHY, when
> > switching from DTS_A to DTS_B via soft reboot, LaBCR[MDIO_PHYAD_PRTAD]
> > must be updated to 0 because the NETCMIX block is not reset during soft
> > reboot. However, the current driver explicitly skips configuring addres=
s
> > 0, which leaves the hardware in an inconsistent state.
> >
> > Therefore, remove the special-case skip of PHY address 0 so that valid
> > configurations using address 0 are properly supported.
>=20
> Please can you break this patch up. I've not looked at all the details, b=
ut:
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> > index 7fd39f895290..92a0f824dae7 100644
> > --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> > +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> > @@ -333,11 +333,13 @@ static int netc_get_phy_addr(struct device_node
> *np)
> >
> >  	mdio_node =3D of_get_child_by_name(np, "mdio");
> >  	if (!mdio_node)
> > -		return 0;
> > +		return -ENODEV;
> >
> >  	phy_node =3D of_get_next_child(mdio_node, NULL);
> > -	if (!phy_node)
> > +	if (!phy_node) {
> > +		err =3D -ENODEV;
> >  		goto of_put_mdio_node;
> > +	}
>=20
> This looks like it could be one patch.
>=20
> > @@ -423,6 +425,9 @@ static int imx95_enetc_mdio_phyaddr_config(struct
> platform_device *pdev)
> >
> >  			addr =3D netc_get_phy_addr(gchild);
> >  			if (addr < 0) {
> > +				if (addr =3D=3D -ENODEV)
> > +					continue;
> > +
>=20
> This seems like a patch when combined with the if (addr < 0) hunk
> below.

This change should be included in the same patch as the one mentioned above=
.
The change above changed the return value, so the call point also needs to =
be
modified.

>=20
> > @@ -433,12 +438,6 @@ static int imx95_enetc_mdio_phyaddr_config(struct
> platform_device *pdev)
> >  				return -EINVAL;
> >  			}
> >
> > -			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
> > -			 * 0, so no need to set the register.
> > -			 */
> > -			if (!addr)
> > -				continue;
> > -
>=20
> This can be a patch, along with the same delete in the last section of
> this patch.
>=20
> The point of having lots of small patches is that it makes to find
> regressions. If something does break, git bisect will quickly tell you
> which patch is was. The less a patch does, the more git bisect is
> useful.
>

Sounds good, I will split this patch into two parts.
=20
>=20
> ---
> pw-bot: cr

