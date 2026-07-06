Return-Path: <netdev+bounces-304825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U+ZuFfIJS2q0LAEAu9opvQ
	(envelope-from <netdev+bounces-304825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 03:50:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94470BFC8
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 03:50:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=rVLuUhSd;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304825-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304825-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD2C2300CE64
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 01:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0837B41F;
	Mon,  6 Jul 2026 01:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35583612EC
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 01:45:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302337; cv=fail; b=GriXjCk/cLJ/kCIGjfDiaEaVQ2liXUQivt9bBU5TZi0N9rWMMfCmhZw2hUnIaqGk2t9Om/WW6fx4ZL1ycRxQQSftcVKZzDy55SyXryFlHMkwkV6JPtVJsUmjAt0XJjXn4BLLoXVgW4JAu7K6yT+nBwuIWy9bvymQeyLHg43V6WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302337; c=relaxed/simple;
	bh=Mf9m4/BMFr4qAh6NdETJgrTTmzlKNKKaf3WTVkI68Tg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=buFO/5y0DRUoMmVpONG0EmEOQeuy2eI09wZQ/x3JxGeCMW8vWc8CDBl34hRK2jRVD+O2ZPm9+tg2INirOVLnSZsgUWCRuW/GmTzi/Svv8GZEEK/Ik1XHIyvRdb1xgBHkQRjZnKqwlqaDAmlPta7NXdEACalvt1kxnfj3xY7wkZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rVLuUhSd; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO/IvHyoFtTZDv7vE5uMi6sq3Lwp2A4e0PSF26XBZ9eCixDeQFvZJ4C2zYFqwOb1XI/agA+VU8BQNNQq7+u9En2fntsjBZspIoD195lLAnJa/E2k0lliqYKLEsH1w2ufx30UyufJKbkTygB2XPYheba3GOwgR76gh8Ji/8ADQdIMblcGre99wbUN2Cfpj0FjtfOM6mhwiQmKgdaRzVu6Z/hFNb2E6k4A6ekShe6epxMT9nGtfpVGg+OuodbssZ4UqGdCJ/Bhw6+T8gdux4HL0eecenkSoswyuBgsth50nfkpZAJS7p6hejrT1klMvapZUrQ7kN/3pX7XMhTKRJRKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmoGpVXM6qT6lbIKk1CEduksYfMm6CGQVWbqKIYkCg8=;
 b=xHTImiMZb8xC8juOKnoWAm93j/EnnBwV1L6yKLjK2p2jCuxeM+UQUew/38NrMo6KZ/E6/tULfNfl+BcaCNXeqnKwIJ5+zH8oe0YTZBQOsioz6H/Kfub0efcq/gmrwHDWP2xuD3JcCQWa22j6USD8hQcu3i4njxeWv/qf3gXs4OK/9PmUaoS0w/nGjDLvYvUD/EF09ZOj7SJu7HA3F/DPKwEz5KDTMfTPk/H41DvXBWIwjmfADOZTKFL/5Y+kU5WvIZ2rR1L4IBQqdR/iQvUNzBDjwINXNIpddKYxxyNYP4332cui5s6/CMh6nsFSnmOcEhrx3etW0rQ1sOrmwdSZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmoGpVXM6qT6lbIKk1CEduksYfMm6CGQVWbqKIYkCg8=;
 b=rVLuUhSdx+PSUp8EEKyyoP/vbY1iEaBpB2symH6Fapw7Wq+0rqa+uhcNlHidpipmhQT1BB6z1d4Ll9NZ9HqJzMERWJwCVEwEoikRn1R2QabouEItu/ZMuD6xqi+2z5TJ3KOSxJZiopmirRVIwxeoc4RJL+DjmxK5zLWk5QFL+2lll4JlX+5ti9GbzaUeByaB1adJolWnAspqMwwDcednaRa21r3YjaPURocBYEe0B3+eDERgKpLJBG4MODHlf8yosVk2fepO1F4ROHRLJDzf3cHtzrJcZ1KSoa3bdxYaLCwXEZbnESQv9cB9qDm2BGWCQ6u9BljPWiFOlJEOeNd+7w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM9PR04MB7714.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 01:45:33 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 01:45:33 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 10/14] net: enetc: refactor SI VLAN
 promiscuous mode configuration
Thread-Topic: [PATCH v3 net-next 10/14] net: enetc: refactor SI VLAN
 promiscuous mode configuration
Thread-Index: AQHdCti67f/+BMg6kk2Dv6pjWUoljrZdLkiAgAKOR5A=
Date: Mon, 6 Jul 2026 01:45:32 +0000
Message-ID:
 <GV2PR04MB1173996B31ABAA8312EC2339B88F12@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
 <20260703101328.550714-11-wei.fang@oss.nxp.com>
 <20260704104346.232751F000E9@smtp.kernel.org>
In-Reply-To: <20260704104346.232751F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM9PR04MB7714:EE_
x-ms-office365-filtering-correlation-id: 069321d1-f084-449c-96b8-08dedb004499
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|23010399003|366016|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info:
 DdGTLA0l1FAYhyFl/9wn+jiTDX8E6UfS038stgnToo0mCjmzVYwY+58/lYLxXFpiT9AOA72gxg30Gef89CQ6Upz8Lfcn9k12O3mrr55ZvW8TWPov5AsZihMZEW5cIsbwgRLPwIsfcqdXkb2SWCXnJGV5MJriYOJObBOTu8VzxzKyn3SgBfgQrC7uTnBvlFirCy7MbLjv8Cp9kYpcdbfK9KVZuzKqiCeYtQSdvXFirgq1/uXSRDmrPZYy7H6wLrkaLNR85Q6ook/H8dZ4F/VEmuVpSsrqPAQP71sEbAS7Kq0yWOhPRqWLVtu7ury5RTmq521tKK1GOy21tjS0LOGkr04VY7EQXPWQOGwA5VVLnWnw5ZVex50gGtPBQ/44WimKhSIatNZKyxHSPiOZt4BC2GAHImkCgnJ5egt+BoHNeFJ02guk9aNiVCwbYEcMbgyP9lmMzKzUJPyapaRpmCzrXHtrGGM0sO2hVnsPQCyQIGdr6OBesUxjXQZFsxPRIcACY3b/j4sEXicC065hsyhGWAcNTb7rP1/blDSGJdStbxHkA9gzWs4RvtWui76Vl2fHxYVMPz9IaN8AqC5Hawlc3Tc/RSLvyh7Tfk45MbzlEGeQ5nYQFDCX/uDaHQbHBw2erVjxY21ZGLvdAQZrT4AgeDy4kjaeqGQF08LVUuBp6SL2zH+cDkPpOFUgNyvYAC72UMk4ewA3xcP6HVjjZ0hcHB6nd+Ut2BAx3HJoesti6Fo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EOEUZlvpZv8WETJxK59wjUWOZHicl3AGhH6Vp/dRaiCr5Jcuij33upGws9Pr?=
 =?us-ascii?Q?rg08btwOiNtLsuKmBKVA+0+cqKLly8X3XRM8MsRjSIDrsTNTinoYvT2iMubh?=
 =?us-ascii?Q?1+7rty5wW22498oxzBnRAoFhMc6DuIKVEIKsGPsXL1lBeI+KeI2bdLYI2FOj?=
 =?us-ascii?Q?0WczUD3t/gZVw+nzdZR8qRHeNRrbH2eCFb3hDkZBnsehEqPv/4+ru0qQXEa4?=
 =?us-ascii?Q?/J6rKWF10UhoSVdkZY11OvglwBLpJZCLB6OPqKo72KVhbMhU7/SPg9ntLsQV?=
 =?us-ascii?Q?lXBlL+5o34laL6wCyM4SQVSTqjDNo+rFEaUMZS/b9aeJpnabVpFZqeQCsl/j?=
 =?us-ascii?Q?nTQ31iGoWS4QkikzNzDPjGrRBtB5dgIb1GffTdfHVoQBErlG7TqSppIQKj2W?=
 =?us-ascii?Q?15MwDbLfneOahhY5u0EYKLs+18+RZGgonVVJ8E/x1IF8rSQ7p+F9XyIwfv0q?=
 =?us-ascii?Q?0CnxEbbulPMiYVOpmrnpKjAaJNyvvznFrjLYCVrWBwqP+LnXgYsGmaySdz0J?=
 =?us-ascii?Q?b/wpyTBY8kP6bv+PVq5q09Z8/A78Ph6J86WSK+nwy+JSNgIMRzUgMWEcg0rc?=
 =?us-ascii?Q?KyxSaMHvYgypCJBDhqUTmIrr3t/iz4hvC/1RQoIoc66AEYzGdIFBC3KTIUU8?=
 =?us-ascii?Q?aHnSqBUyMQAc1kU5gOu3ikp2OBb5rnL0X7m9q9sdhz06mRGU/Q42pnvk3kXN?=
 =?us-ascii?Q?CKIYndP+41ArM65XCrb+RgtGHRY86GEA0GWGykgzx10okCdC2p6JGsl9iFcA?=
 =?us-ascii?Q?JfRrMWDUbqIt9Il882sDKbDz/cvvWARuAUEE0EdYFhCvo+rQGg4bc3RKYBK7?=
 =?us-ascii?Q?SFAREB/67fTPtgDkWHvUC020XGFpHV2mWDJ8VkHlmtpz+fymhFb9kDysSIVZ?=
 =?us-ascii?Q?XgjQ2eHF9vSb79CGK6F39Tg1B8k82+gvaXbDPM+8yAigs2Vv5BtvntFgp+Sv?=
 =?us-ascii?Q?QJ9OkJle0bPL9V2R7eZ6eoJhjWXyAMPd1oLUJFy86Lzx8axVSJRI2UBDqRyB?=
 =?us-ascii?Q?zuCmaIjaSd1qyQHpdWOQV78GV/kwT7fGPbmgwEKCc/4Uwrhdo3hcdMtoYADn?=
 =?us-ascii?Q?LWuhN4gnBcw46M916ARAUkrXsG1CpU4lCY0rrH5IE3gzdEvE3mzFxfotfIIF?=
 =?us-ascii?Q?zibTofe1Vw3gHeKUkCTt2gCI079i9n0F+10CTJBE2mvCIV4dIZAFwUc/IY8p?=
 =?us-ascii?Q?Dw8ybzcJq7FHCQ17pSqViaSwsmst3NMdtxTL+pFvvfTOqJ9fBz9WypXSnQEq?=
 =?us-ascii?Q?lbqQMSdQ6I26BMJN+QOfkiBlkQcFuM6kA4KRgD9ctK0j89E1tlumOOkYC7Pk?=
 =?us-ascii?Q?gBOTdGixOYrjPG12v6Q6wzOAzeVvhaYcWBA7zmDcMje2RNC29yfe7LaU7KNt?=
 =?us-ascii?Q?wSj0ehbnKEzrKqVjIRKlhW2qEVQBs8cTH78145i2Ivzl1Lkgx0Xf0R7ZYZqo?=
 =?us-ascii?Q?EWxjYk6ncpFZTUGmK4gyNDffcuTxuvnQBO8JxzqGjTdzQh6sjLWzCUN8Fm+k?=
 =?us-ascii?Q?wWeWx7yY0sNYBZOI6xQs7wVHroXepPrhZdGWhJRnUKOJIIGQ7fVc9ny3ByZR?=
 =?us-ascii?Q?lPMuqvbzSHGR/ganUrBHOsFQ4uEbHgCgGHJvZsg2hvQrj0VeKlh4oI1dqmJx?=
 =?us-ascii?Q?nnrfo+zUAnIDzM9+gfv9VFZ9XAxU5akv83scmwG1mLE8UevB8qfJ8XpToc3o?=
 =?us-ascii?Q?fiQFac+N60mm2bh14sIhccrQxWIa2NHq7ZWJCF0sGPgRQd3b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 069321d1-f084-449c-96b8-08dedb004499
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 01:45:33.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxQKuQLUfq8cOuVCEQerO5RH6NhRDYPgrfSUHcmFtojBdSAO/vRBp98LqvAAxstrQ+QWZLNtBy3alt/ticMaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,GV2PR04MB11739.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C94470BFC8

> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > index 66bfda60da9cb..16da732dc5de8 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > @@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
> >  #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
> >
> >  #define ENETC_PSIPVMR		0x001c
> > -#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
> > -#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
> > -#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
> > +#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n =3D SI index */
>=20
> [Severity: High]
> Can this result in a shift-out-of-bounds if n >=3D 32?
>=20

No, the hardware has 16 SIs at most.

> > +
> >  #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n =3D SI index */
> >  #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > index db2a800a7aaf0..afc02ed62c770 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > @@ -42,24 +42,20 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs
> *pcs)
>=20
> [ ... ]
>=20
> > -static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
> > +static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
> > +				      bool promisc)
> >  {
> > -	u32 val =3D enetc_port_rd(hw, ENETC_PSIPVMR);
> > +	struct enetc_hw *hw =3D &si->hw;
> > +	u32 val;
> >
> > -	val &=3D ~ENETC_PSIPVMR_SET_VP(ENETC_VLAN_PROMISC_MAP_ALL);
> > -	enetc_port_wr(hw, ENETC_PSIPVMR, ENETC_PSIPVMR_SET_VP(si_map) |
> val);
> > -}
> > +	val =3D enetc_port_rd(hw, ENETC_PSIPVMR);
> >
> > -static void enetc_enable_si_vlan_promisc(struct enetc_pf *pf, int si_i=
dx)
> > -{
> > -	pf->vlan_promisc_simap |=3D BIT(si_idx);
> > -	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
> > -}
> > +	if (promisc)
> > +		val |=3D PSIPVMR_SI_VLAN_P(si_id);
> > +	else
> > +		val &=3D ~PSIPVMR_SI_VLAN_P(si_id);
>=20
> [Severity: High]
> If si_id >=3D 32, will this silently fail or corrupt the VLAN promiscuous=
 state
> for SI 0?
>=20


si_id won't be >=3D 32, the hardware can only support a maximum of 16 SIs,
while the current SoCs support a maximum of only 3 SIs.

> Since val is a 32-bit integer, even on 64-bit architectures where BIT() w=
on't
> overflow, the result gets truncated when applied to val here. On 32-bit
> architectures, the shift wraps (e.g. 1 << 32 becomes 1 << 0), which would
> inadvertently modify the state for the PF instead of the target VF.
>=20
> >
> > -static void enetc_disable_si_vlan_promisc(struct enetc_pf *pf, int si_=
idx)
> > -{
> > -	pf->vlan_promisc_simap &=3D ~BIT(si_idx);
> > -	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
> > +	enetc_port_wr(hw, ENETC_PSIPVMR, val);
> >  }
>=20
> [ ... ]
>=20
> > @@ -441,10 +437,9 @@ static void enetc_configure_port(struct enetc_pf
> *pf)
> >
> >  	/* split up RFS entries */
> >  	enetc_port_assign_rfs_entries(pf->si);
> > -
> >  	/* enforce VLAN promisc mode for all SIs */
> > -	pf->vlan_promisc_simap =3D ENETC_VLAN_PROMISC_MAP_ALL;
> > -	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
> > +	for (int i =3D 0; i < pf->total_vfs + 1; i++)
> > +		enetc_set_si_vlan_promisc(pf->si, i, true);
>=20
> [Severity: High]
> Does the driver validate or bound pf->total_vfs anywhere before this loop=
?
>=20
> If the hardware or hypervisor advertises a TotalVFs value >=3D 32, this l=
oop
> will pass an unbounded index to enetc_set_si_vlan_promisc() and trigger t=
he
> shift issues above. The previous implementation safely bounded this by us=
ing
> a hardcoded 0x7 mask.

pf->total_vfs is got from pci_sriov_get_totalvfs(), when CONFIG_PCI_IOV is =
disabled,
pf->total_vfs will be 0. When CONFIG_PCI_IOV is enabled, pf->total_vfs is a=
ctually
obtained from the PCI_SRIOV_TOTAL_VF register, while the ENETC hardware onl=
y
supports a maximum of 15 VFs.


