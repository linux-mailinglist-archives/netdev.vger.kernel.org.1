Return-Path: <netdev+bounces-286423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGOrN0U9AWqcSQEAu9opvQ
	(envelope-from <netdev+bounces-286423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F050728D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F9AC3001A59
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CF263C8F;
	Mon, 11 May 2026 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JiHxmAet"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC21EEA54;
	Mon, 11 May 2026 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466111; cv=fail; b=HUvYHR4YuNgcDpgGGWgvbIgF+xOgVOwIxaF6KhyERAyTBi3dxNLf3C0vVr9tvB9qLP7/6Ab5NCBiFtieYOBQKuPbcNQN9LzUEil2kQuKWoHtoQgoM+ZiM8U8b7gCD/GO6G3JFYdhTCi9Gusi07YKeWK9F9MxI9nm19LNm7Sx28I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466111; c=relaxed/simple;
	bh=3IfkbAT0BTmPcwYrd2hi+wxitvSvYVt+08oU0I5PG7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+/UhuhP62tObCedyJev7bvKxJ12Cs8k3sbwAbFmEilsblGHaC9ZqIuZ5MpkHKbl6gGJ4geysviH7oohTCRaODpImTNLMdL9E3Xqeqjf5IZY3unRooxy6JOyztccevdIKMsBpBXSdUn21aXDDyLHW+c+a1JOOYUvH06C+PHR7SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JiHxmAet; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/4NC3TP45eTKtw84PlDyHdFrq832aB+gNzbhDFaA0/pDS/fKa9MrtMfTTcMdBNrVBuI/taPT2sJF7mBBTj7G/Nu2Yd/TYSprkNiuacGYuupqZciaHJrKAD4kbTk81LNFok0Zq+/M8KARltUyMrbq4yniobXe1JxVydaWLVCqgg5qJ0sdMXkCg8DAMbIv9jK5H3xOi7R4ToboZfOR9eJ18bbWnGExcJuLy02hr7+eofvohH2hbp509fNJLdkWADi+2C4E2PlIr/y+fhEFg+Gy9pE1pvMOttZvNlA77i3bRc69Lv4TDiQnOxcQlvQ870xuiX1LVsxgIQShu0S5bk3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JKwJdqHc1Pp4KegdYdPkRS2g8lMJFHl35InjtX60Po=;
 b=mfUdF+Sdljpdfpx7g13b5aW/uN48rQP4kM2EB9dOXhLgyMXmvkP0u6cNmoMQ8EWjqtGLWJeRPvSeUkxtdbw4GwSNzW/2a3P5gY0l4gyVKgoPjZhtWU93F/Af9w4LJO7ON3yzWcHpC6ZagzlSzp/k6/eSe1GHHrcNoWlnwbpqihyrEz0nI1jewm+c+kjFyRH8eVaaOwfpNYpsqTEaz/sGH8PrJqZYTTo4lVwGqCOnt2AePYYUMoEktMQe5B164FlLNusCeQ4adF4A2ky2MYK8FdqnoHUKs1J6yi8cAyvzJnDL6bGldvUKS5jugVsBfcuqEuQjxVMxXdk1kRK0uiSw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JKwJdqHc1Pp4KegdYdPkRS2g8lMJFHl35InjtX60Po=;
 b=JiHxmAetApJra/RixAEG00RbuUpCCQ4uU/iFyGQFeLGcIUgkeSLaFjx8hEiIkdZJWEA312rd10xXX042hPannM30/8FGTsyHnFQyS1SItmY4+sdpWiDRTYrF8pUax02UubDKkjN73QqkpzuND11pnBHEzmEqLo8bvwHI52JcTrdkxxk2NIb8lAy7wAEAClUiHlpJDmrD5L7V1kLvGrljE9xdDa7SvnkHBulrUcwfz+SU0NcLqG0aUrTHT5AWKltkMU53MYiRMS+NOR+5/u4nC1JEjFM04y0qQb9lg8cYZCuvk0q8LRcPDC9Z/wv+ysPWY2vTg4JKrgbx/Z/htM/6sQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 02:21:46 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 02:21:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 05/15] net: enetc: add support for the "Add"
 operation to VLAN filter table
Thread-Topic: [PATCH v6 net-next 05/15] net: enetc: add support for the "Add"
 operation to VLAN filter table
Thread-Index: AQHc356LyPdy4BukeUK0kaUjIPELnLYHFdqAgAD/WlCAAAVOcA==
Date: Mon, 11 May 2026 02:21:46 +0000
Message-ID:
 <DBBPR04MB75007228C6F07B4ECA08818A88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-6-wei.fang@nxp.com>
 <20260510104834.3FA23C2BCB8@smtp.kernel.org>
 <DBBPR04MB7500514E13E2678077462D9188382@DBBPR04MB7500.eurprd04.prod.outlook.com>
In-Reply-To:
 <DBBPR04MB7500514E13E2678077462D9188382@DBBPR04MB7500.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS4PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: 587c6fb5-01d2-44f9-0318-08deaf040cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 PtFbNHOythEOposM82s4P5aiz8dSfR0vfR0FeBnwD0aT+bSDBdk6uc7N5sBTwF9jD7fT1zLM3+8wNfcJN8rr1INxaAlm0yg0TfVuh8PyqgmJPXqMiy93CgSBI28Wnui5pd7E+oSt8eAGTM7HVChl/ePSd1oqCouhTdx1E/jA/P/5Xfvwl7eJ6nw5ZQC0MJYx80n5zObNFqPye33Lngk71Xg4jv0C3k5gMhOVcaG3QK80ZGbnhD2KUkWdHYwWlEKLuJ7k8d3PE9wY1DLliNhnMqa96AmOu/fcXVjfAvtzsyeEmPNlQ+4CAC5iS4aox52xgwA2UMshRFbyHmFg632F6zqPsLjTJi0+tEtZASjhXHFCQyBtpYsYg57tec793TVdmpj2yti5J63jIqcUg/Pmy5GTZl3GtoOdwRXRPrYe7uj00nShKq62C17+YkIJu3+fd1eaWFlvbNEsJ6XbkLx7P8ip8/o2ssEEMVkBZe7L055E8t4JXwCK0uqTrBogApj6PacP9uDgVoDdDnrWBFdb5RCNsIE+i7awzX2hyfclr37/+yOYVeUIi2k4YoV2HTG9O10A1iy9rawaR5A4EPuuwUOn/++xdrJbW8QmRCU0XO5AoEbN9VY69jphBC4dUEN9AHb9IUjVYTNXCNN+VI75DlZGPqfFGmsJZwUXCrmILV76nU2YCMtaEdvHcUzCizjMMIinGgBHyJcHHVYFxBEvXuS1Pr/B8G0MYEOsJ5cfiSUN7Vqik/WZ01Gr+Y6+vT3a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hl/X5AovP7hB+Zuc5PWOoS/jVzR5mcnExJtvaZa9b8Ajfuf+qXGdpnrwtcLd?=
 =?us-ascii?Q?N/uyMSneG76zI3vkpX8VoJZ6aR+94YhPaG+I9HC0jwyuN4R2vfo36Wh7hybl?=
 =?us-ascii?Q?M6TthGSeToWutU8XDrq1GeRqkhwNXrIKNstzmx4gEUGmRiMcLoXivRwpxO3F?=
 =?us-ascii?Q?nXkpUTqZ+gvcglNi1samiXwT9dBlsCBwXFRMaAb8gzUBXRf/jO8d2jQJd581?=
 =?us-ascii?Q?Z7Hlk6H4pEQje6fqg/Rj+QK4EUyyrL9+Ddqc6I3iiIa3lM1mO3XYCbqkzn8c?=
 =?us-ascii?Q?K193dnZX7cXkcNkRkJrEbKvAowjtBfzteEosO6PMs0RdO18LXu/oWobnO5go?=
 =?us-ascii?Q?K+bh+F9t125mT4+KWzqXXT3M0QHUKFzAQvcZwx6EBp6fgW7Pw0X+KycGYNYx?=
 =?us-ascii?Q?lOEDCOWOCPks34xe2dy+gYTM0KrFLscKl21Us9gC9hZFH9gopmZXlQxOEZQA?=
 =?us-ascii?Q?IUr067G3b0vP7niqGZuwlu4Z85aVWsJFxUI1lGTRPmly0lEcoAKUzHbJ1+jp?=
 =?us-ascii?Q?add8Lty0WinH8PqRFkbPzejT2zuvNFktBisBBM5f7wl82fE2FuJ+n9wagsZ2?=
 =?us-ascii?Q?IVXxVBO9n0zeREJmfsEIFx9nPW+NqCUEhkwyjqQjvdQ3WKEVYELBy292L5eR?=
 =?us-ascii?Q?kcVNodofnaf5S8XsdxtpnanDszWfGE8sVfu49tVX9DzevTS5u7j8AqDUqwky?=
 =?us-ascii?Q?djL8kX3zdpxj2CUQaTDrnls/SJKsLuO/KkhGMbqDBtzmxowm1oIRbZ2RY4BZ?=
 =?us-ascii?Q?yGtyZ1iSKMITp78e7iH10EQH9GYmSFeOaleFmWqqOeSzsBRbkOR5bqCgyz3u?=
 =?us-ascii?Q?enOlD8zgCnbBf68lM6Y0aeY7E/3DJStpb0yU6n6AtizDsGFDdmkjiI3Inp4Z?=
 =?us-ascii?Q?xnK3r9Ewc9nqqEBEIetScEeGwRI5NXP5/Ub+c7RXcis6ty24sHSLxjtCDjjC?=
 =?us-ascii?Q?1lfZg3XFMpqZH4Vm6A5YxxEAvZuOUqEj4pNcd4RHQn9X1gR8HHa5dUHd3f+u?=
 =?us-ascii?Q?uSwC/Ht9d9x5HFzWrKYy8snmP9ZZbvk62hfQLKifiagSYLAuykeTG67DlehF?=
 =?us-ascii?Q?taOltHinm8+tiAGO9lIPTZsagdrmqJQoK9vXEc+LSkjHJeOJLjFSAi4VROQW?=
 =?us-ascii?Q?GhCPS7RmCWDMqV8sDpM1hYYfaACBEANSgAmqJkmAdJT15/amg9MjcUYi/i1C?=
 =?us-ascii?Q?pI5OwdMMSP1dk3WzUc7WdsIcuPFVGwIIWa/lC1vrk8IS0p0uVssls1tRnOG/?=
 =?us-ascii?Q?qbu09ZXY1sFxlHfWD2lBAUoMaFZT1wvzz4SDHBchHucLy6Wgx6H3T4wO6AJ5?=
 =?us-ascii?Q?2glPPfV6aIFRRBNvIy1KNUnfXtJ4F4uJ79s7RPgZD4WcfWZwnd275lFXXusC?=
 =?us-ascii?Q?lf5XlyV/fkLHTY/Cp10nl6jdjev1/aPxwrG66aM2LA2ZvUpEc5TCj9xOdCFw?=
 =?us-ascii?Q?BMJBeEXlHkEPsRo+dgtJRZSy8sKxkdQXUXfLk4RkgWRfFuoQJtOWLF/NQWVL?=
 =?us-ascii?Q?zXtdOvh7w+QY1ViiEdt7neAbz/MInABjAGmOwYo3jTM8LNrnjImvOiRSr/kp?=
 =?us-ascii?Q?o1g9UvKnyjkqDqzpn7YLUK0y2tp6U4B8yO/ulaspjfrnEc9sDZrHlxoxz9Na?=
 =?us-ascii?Q?Iq62sVbg+80m+AqmqBpxt4EPSeMSv96jK1Q7Hym335xWC7/KOsMBa+9Ruxwh?=
 =?us-ascii?Q?RnsNFzgIQXcw+Clsrw46ncnx+jzxwcnDsA3awYjNbnEUecB1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 587c6fb5-01d2-44f9-0318-08deaf040cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 02:21:46.3361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIKach/dsx4YOLLTcAKHcVGWMs8sTWjLmSOBxEX3GkF/h+koWasBjPeULaAlUJ7UwW7WnyXdLGYMfjTBAzSbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
X-Rspamd-Queue-Id: EC8F050728D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

CC netdev to avoid the same comments

> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to
> > consider:
> > - [Low] Missing dummy implementation for `ntmp_vft_add_entry` when
> > `CONFIG_NXP_NETC_LIB` is disabled.
> > --
> >
> > commit 5e0769b9fed651ba9fec062f5b68e9fec7739814
> > Author: Wei Fang <wei.fang@nxp.com>
> >
> > net: enetc: add support for the "Add" operation to VLAN filter table
> >
> > This commit adds support for the Add operation to the VLAN filter
> > table for the enetc switch driver. It introduces the
> > ntmp_vft_add_entry helper function to facilitate adding entries using t=
he
> table management protocol.
> >
> > > diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
> > > index 4cfff835954e5..3672e0dc7726b 100644
> > > --- a/include/linux/fsl/ntmp.h
> > > +++ b/include/linux/fsl/ntmp.h
> >
> > [ ... ]
> >
> > > @@ -125,6 +147,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user
> > > *user,
> > u32 entry_id);
> > >  int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
> > >  				u32 *resume_entry_id,
> > >  				struct fdbt_entry_data *entry);
> > > +int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
> > > +		       const struct vft_cfge_data *cfge);
> > >  #else
> > >  static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct devi=
ce *dev,
> > >  				 const struct netc_cbdr_regs *regs)
> >
> > Does this need a dummy implementation for ntmp_vft_add_entry() in the
> > #else block?
> >
> > Other functions in this file have a static inline stub when
> > CONFIG_NXP_NETC_LIB is disabled. Without a stub here, configurations
> > where the caller is built but the library is not might encounter build
> > failures due to an undefined reference or implicit declaration.
> >
>=20
> No need to add a dummy implementation for ntmp_vft_add_entry(), this
> function is only called by NETC switch driver, and the driver will select
> NXP_NETC_LIB. So
> ntmp_vft_add_entry() is always defined if NETC switch driver is built.
>=20
> This is a false positive, please ignore it.


