Return-Path: <netdev+bounces-292143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HAXFg2dFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:28:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50A5E0731
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEB17300DEE2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F13C2B81;
	Wed, 27 May 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mKHU9i8W"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE903BFACE;
	Wed, 27 May 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866891; cv=fail; b=EwnHaM83DZ93UjWbVSbW5F0Ub+6SYxgDpgHI9SDVh7xCfKWkQqKzg9CSVM8nzqiujXyOsa9ggDJY9QLoyJO8qdiDrWwLAccilq5CPczAVyKDg/L5jQZepbAY2L2nA6FUYBo29fnZHQNF4j1L0eEP12mJfg1lt4KqEKSX1IM7/to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866891; c=relaxed/simple;
	bh=czkypZG7ZAtU9jTTACKE+kUJZrWsJE9oh7Vx4BW7LsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lql/6NsknnhhnKf2l8UULT/Qcf11ij+JOzgPHFpkSwn1ziuZOkLjyAwNWbCEvXGsb13FTK4LymI0N+OXJwdwg+rudHWBgcAAhhFtva1U9s8G+K3YpK/tcxyFIui3feKXG4f7jooc5p0n0eTUQZNwnEFobKhxTAhqK/ENDEK86Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mKHU9i8W; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE4mcxhF1Yw5kiWx+MGNKWK6yM4nFI/djIMD8z5etEoXpusTh5Na8WgsARr5l8ZtXck3OqkEmiMXg9cnFePrk46SAiUch3+sFb5jqFLbMjmhaX3u8apDFt3wbXwcDyLnrJCpPzmlw/1iprCEsPPwGZeQE+iN/I3ewg0bkz4rF5gLxdbtY+j+c9Jhyg+tYhNNsYZ1hHnB+EkIVrmps88SrrZRaLk7v8r5EmZE/BEwQtm82MK4GZlznVjccfj8vCt+pablkPDrpRDEx5JfPaNV4fud9h3bzR0yrdQvdUvAPTQ4eO1DYwR8zZRpNe5MjiZmwBLkX9QNWjMSoAoYaANW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZigvuQFlU/iJqoI7ONQ/d9JVJD4ChlMhxDmSlgz78o=;
 b=lWHKy+2v5dp8CxTl08Oo9YQTZnviyhcmDG+pzx1SDqGgkmrQD6L8jfRabyvIqiIn6RTdzTqvGoXhB36xkZTTxwBY7K/z0A9XgcxmGaJgn+vZjgWcIRRxcureGHX/x0oZGjWk0lvqw+c7u2iJ+ncNp2iDODYHXtGop2g6hUDZu7ZFCFe7iwcmWgfoY+b1JX+bOUEleSwjevYe8/f5CDPQ4qwLre9ykJUKpO6mZx1RYYGdiLOOr/8sPQFyLU9u+npmgo4sJcjv4mRq/qJsZcdBM9qogKHPpwGRJGGGSrg7Tepk2pKtBNzM2D5BP5auj0bBs/wZqUoXt0YtaUDiOobdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZigvuQFlU/iJqoI7ONQ/d9JVJD4ChlMhxDmSlgz78o=;
 b=mKHU9i8W7pAr0DKxaWuD+tznr1n5HccjLYos0EMJDH0Zi8BIxI2cIAeeaHgLKRcc0b/kqfdsblDZ9GYUTmoWACAA/AyrC0t866RisfmOarBEtGRhN9ItpRW/PRhSTxlNDM2DEv8xNh57LIBEn5MA9idokkn9W9re1PafJiGzYWmtDAH88CLPWySyu6wp4Q8nazBVlkCFiGlX4oIS2BC3VnhEfNtIACgowN8+IooyLM5cOgGTu/e1IBnfHd4PQGuzV1yko2YProMBskD07BOEHWOE0yRpjLOGR2FwTPEtRarEg8p0+4/kcYvd8nqCiftFy+mG5qfUKZEWLtCtd40dWw==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 07:28:06 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 07:28:06 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] net: lan743x: Add support to software-nodes for
 SFP
Thread-Topic: [PATCH v4 3/5] net: lan743x: Add support to software-nodes for
 SFP
Thread-Index: AQHc44+Tx03qOqEBGkqYGw5EphtZjbYNe1SAgBQOhjA=
Date: Wed, 27 May 2026 07:28:06 +0000
Message-ID:
 <DSWPR11MB97150CCAF4008FFA5193F5FDEC082@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-4-thangaraj.s@microchip.com>
 <40f567f0-e6eb-434f-9d54-7f226f0f70fb@lunn.ch>
In-Reply-To: <40f567f0-e6eb-434f-9d54-7f226f0f70fb@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|DM6PR11MB4627:EE_
x-ms-office365-filtering-correlation-id: 1ae024b7-2d5e-426c-ffff-08debbc17ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kciAmAvQP2hMmttKYy/PHVlI6JC4Dk1w9KnbuwwpQFfZIvSfMFTyUAQcZO/awzEAIrN6NVwfHyafHUmbNu+Lj2oYUTW2mYemPrqbIq1yI7Ee7dVwaCo/3nfdRug0u2I0jVRJJ51WXIkJD8h09NkwN4PYGtdaeGjkMwiyG0Up+PWzvTdAyGyaLZreBBULGifzHStU5IoyGz6VXaU5qkfvj1Kax3eikCuPkrfsaYfT7Yfq04XbXDLHnbXM55g1m1MpymE0ANOrhVQ9G7VSW9bC8G0YomFftlUfxlmbFYBvMZence0d7lcMcYWPGfUvYeWSllKOilqYdPxITh/c0lGyb0ipVQQCj4vlwjidZcQCJUsEVBbRUDmNiboVZUZT5HmaNWY0r3wbEt+eMYmzP88t82mUfpwZh4CUKDi82CqAmEYQRa8KDDpZGRwjqd135oMzkGI0VaoOMb3waqcx1HXYS7U+KVgZ7H+UBVZ9v6RWC6d4EJI9DVczgPPTLt3uQI+PMrtsVhm4ydc51zcrBDfkRUvPpKIo1fWh2deYL2u5bLzBNeaFjpASuD2Dnfpj8x8jf4JfG5SKHW4Cbbi9xkEQfK9+zttrnniw1Zm1HBW9gS0wqG1/qrQgSBCiXzQLukGLQWeEPbu0/47vsVasXkkOG5aDVnMJBkIjB32EdZY0WjPBGz5B+b+T8yGFDmVXai4l3jCrXu0GlIhIudYsfZT33S03y9tp3lTlfRglXOz3ZkEPDzHHL2WTiX3HNDgQlbnq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K74FX5IxqYbmVd4FkXoqPNPCewd+M6ckNTPupkfKZWQI0ayVQ3H9eRxPIduD?=
 =?us-ascii?Q?dvY7bs57HWxCW9EzAoRaShluplwUX+eAGg2fkgGHJx4SM0USZPNQ0uLqxHLG?=
 =?us-ascii?Q?HTQLjn99ovDARmZGFiI6H3UxUNM27kMnoSd3qzwZ2lIr1MqENpHvBNwgDNIg?=
 =?us-ascii?Q?/IlRY+jIfkeRa9O8zI7ZvkEfsAtYXO4+/iVFA2gWs1NOkAtIk5ArAVjuYORt?=
 =?us-ascii?Q?8aAhbdV8WI7xLiVcdCT9ppi4sSYfDjF4tDME8h7be3UQc0hoHTRIZn/32VOi?=
 =?us-ascii?Q?LCoWPk5mBO9VA0FtpCb06R7Ja+k6IvwZzR0NfkWXItuzG/mqS7SHgFlGq6FP?=
 =?us-ascii?Q?nW+P+2eqzdWBktYURwVCd1ipZpiKOlV/mrgazQw4Jv0SXceZGqbuuRbKCtEe?=
 =?us-ascii?Q?xldO+PV/s+PSpb5BMPshSxNLI2Q4AHsd6Yi7eJN5PSBRvRlNCwkTxt/riaCc?=
 =?us-ascii?Q?6U42/5jwIKI16Legtm/gvYGAJQn+0Mi6QorgweyC/UIXTY/lKG3uk9pKJRrS?=
 =?us-ascii?Q?4i3JYXnATa/QGscCpeTP3Q1zYqGHAlaEBl60HjNIFG07pB7K8fgEjEqZDeE3?=
 =?us-ascii?Q?4wtJpsa9d/B9vl4OjLUmb8H3L3XzayPl7/4f3DjwGhR/zBN0PPdYDprN/5nW?=
 =?us-ascii?Q?staswVPsPJzCmqB6slibumUPS+/9Glfhk8t0Wd1L2JGwwE5/skOun+sixz/u?=
 =?us-ascii?Q?hc3Gzv1o7KK6+cn5sufI9VgfaOHEk3BLvRawUglHnDlobZ5RHuRwxBSfGYxr?=
 =?us-ascii?Q?qzaR+ssDDds6OR8gkLg2UZKneBSKb4ja1OIX7unBw1CAr8hR28ykntcqCZAH?=
 =?us-ascii?Q?dZcaFj7ZKa1lf6OMsYFGvcEPpyQ/Sshqm8k4RpE6woKvjFVFihak+qHbHlU+?=
 =?us-ascii?Q?NNQoE+lsXEi/AUE1lLPGZVrrfgVPCq5cxl+O4kVZicGxYvBb2xswdt72t6ju?=
 =?us-ascii?Q?lcpDk88JHEJgGhWHtg+TT+SM0S3rELkbXb9hzjbEfs5edm0gj9P95CTfQsBT?=
 =?us-ascii?Q?0Lf0Xootfi0MJs+8VL3uvRVjoDaE+nzFauDR7K5izt4yw9uunb0WMgBu/GB8?=
 =?us-ascii?Q?bNfnN+hFa8OTqFODbdacQ51sAwPaufneOWTAOjkwFbHsM0TSPMGO5Z3SNXth?=
 =?us-ascii?Q?PmzU9ThReM69Rc48iK1BCO6vjCqyqV5jz1qxR2t21FMH6XdKpOVh1rBbEJgE?=
 =?us-ascii?Q?Jao8YI1b5tleg7SB16UK/I03bSAAjVRt27m+e3p5MQmZfaBRlS8wfLdlUEYe?=
 =?us-ascii?Q?IDO0n+eqk6kV/9Jz+ocdcAj2QQgq296m3DUy0EUM8rvvqFkglMV7bnIHRE9k?=
 =?us-ascii?Q?k0q/1M8aE7Uc58nbIEgvM0EkDyxqcbrWcmTJHVx4azDtfTiGJvjDtATXUB/Y?=
 =?us-ascii?Q?8/ZG8V9T+UHOsleRVj15k7+0VhZ5RshcyFS5ts9lPWMWzSoVzNW1YAnMli0j?=
 =?us-ascii?Q?qFcuXGPa4yLM1MNT7UD1M+yt+P/c1W73F2SwLue36G+l0iUAvoZUoNrZkjhk?=
 =?us-ascii?Q?yn+zthsmCKp8cpyG9wP7mwm73LXWPFvMpcVh6pnloiZdclYaSjZJFgsGARwc?=
 =?us-ascii?Q?XJgmUF+HdgZFQXoZRuTsd+4DG558ezm6VG6iC+EiYra8qRQXTGu55p5iuuzc?=
 =?us-ascii?Q?PAeEnj97o0Uw1wZ0E7jhp8cRRr9j4mbTuB1ZSAeGaOuyc/TK8nuN03kqm2Dj?=
 =?us-ascii?Q?VRfjF0TPz1ieyTeiB16bBOQH3pPmAlyOkwcAw3XssBdWg/+UIrgjPNmxI7d0?=
 =?us-ascii?Q?/ce3ySiyng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae024b7-2d5e-426c-ffff-08debbc17ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:28:06.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPHzmd8JbkbLNeIHzAwmY/d5WbkpyqDH7EmwkGFide57waQCxa+1TtpyOehgHGQXpNyXAqL8hmh3UN8OVm6eWMF+FurpeCgzfw0SDvcrPa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-292143-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,armlinux.org.uk:email,DSWPR11MB9715.namprd11.prod.outlook.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: EC50A5E0731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,
Thanks for the comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, May 14, 2026 6:28 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 3/5] net: lan743x: Add support to software-nodes f=
or
> SFP
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +#define PCI11X1X_TX_FAULT_GPIO               46
> > +#define PCI11X1X_TX_DIS_GPIO         47
> > +#define PCI11X1X_RATE_SEL0_GPIO              48
> > +#define PCI11X1X_LOS_GPIO            49
> > +#define PCI11X1X_MOD_DEF0_GPIO               51
>=20
> How do you know these values?
>=20
> Can i buy this device, design my own board, and decide to use a different
> mapping of GPIO pins to SFP cage pins? Or does the data sheet say you MUS=
T
> use this mapping?
>=20
> Maybe consider drivers/misc/lan966x_pci.dtso.
[Thangaraj Samynathan] ]  These values are from the Microchip EVB reference=
 design,
not mandated   by the datasheet. A board designer is free to wire SFP signa=
ls to
different GPIO pins.

However, the PCI11x1x is a PCIe add-in card that can also be used in
standard x86 systems. A .dtso overlay has no base DT to attach to on
x86, and ACPI _DSD properties require the platform firmware vendor to
add them - which is not realistic for a PCIe add-in card in the field.

We propose using the EVB default GPIO values as a fallback when no
firmware description is present, and reading from DT/ACPI _DSD when
available. Does this approach seem reasonable?
=20
>=20
>       Andrew

