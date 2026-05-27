Return-Path: <netdev+bounces-292105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP6XLoaNFmqCnQcAu9opvQ
	(envelope-from <netdev+bounces-292105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ABE5DFC23
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F230E30028DD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E330596F;
	Wed, 27 May 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AfvmkMK7"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985054739;
	Wed, 27 May 2026 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862911; cv=fail; b=NzAouapu42oMzVl6wFpUho+r+voQM9tfEtXmTHJvYG1i3QkrTS3NqX3+0XttyHPS0jOM9sQgbPUtrK0wdqQ4Dl3P2VnMkNwxnshKgaO9LYPXDuBVXI2E9VOxO0PYJNXuhY+M5WvC6TkGIaYSqvv8ry+rqU1oruVu1nnTPsSo8P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862911; c=relaxed/simple;
	bh=Eou6n2SMDVkvR+iEsiKb7zJtJHhwTeFo9yDnFFk7tj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocr2Rbgb9xZ0XSLz9M0HyA1G7owM5UUFS0psq796inIAEBVP2mdlLUO+z3Y2mqWdu51Sh9CK+sr+JSJdeIiILQrd1ga7uUZL+m7oAEJrkpMuQC0EZORI+hVZaCQ+EBF4QPoFzviuLWXNjZ7BnZQ0wZSkxpD1oKgFg+xIP6lZrDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AfvmkMK7; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoFLYR0U+GTYip/dgztbyvV2ImlfyxLebfV77vle67F1TBwJK2W/daNxw9ciavLzZP87CaEuKue5Am9FNdnptfgCZbsjqGaVk8g32fdZTITJxqyubwPdA56otAsuZpfa2aTxroedYY3q+h5oBVLv0DYs4tuiP99Jh8XDVs1uKVeuj/kR+ZlRBzQo/4VPMB+e6P5ZBmfR5Xp5vzY1dfBfvnkYIv4Eb+ljs3AKOKg9ojY7u0pxOInT8Vj9itwRwbv1SSH85ZrBimLuxDi1Hvbcovcp+/JmOWARlxFJ4xJL2ctKAhVNFcX3EWH2YFZJaHiZrDxEB5p7ddSNmkWHmZUGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlO6oUhFVDJua1T1KXDtuzwzmuCBZQ4kSQJv4CctWGo=;
 b=Q6XRXRF9h/zk3Cqu0htEpB1UEcBwtWfefScGduP+8tZbyMRdwNZRcj+dVI+Z9WXFNZOl99lP9KU6I6dT31J5KdtRQozmAXnsv8v0I1IVrcCT25aMNIySop0gmaxsbXCmpudg89jK70PVWLPR6h7BmdoIjQkhhCI4sx1vzinRFcSjNO9acjGm4IJJUq1/nhntfKIR489+umWZhfdYYQgi4Ynr0aHBv+ZqB9ahgphZewJvf9jC0lXdkkjdG8A8H7TXME2vqH/p1HDYTcCEsXa+0OVLIYh8LP2Y8AmRbKSp8d/lnjHbX6PzqCfBXw8wTl/TophVYktq3PQucUIq8cK07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlO6oUhFVDJua1T1KXDtuzwzmuCBZQ4kSQJv4CctWGo=;
 b=AfvmkMK7ZM2AJPg7bbRK0C3du7p2dR3SiRh87sdjWeOwPeOC33r+5bu0hcHr0VL0Si8Rh2chG9BKr0meTjFxqHNGS40af6xfItBC9lWeGab7Ll8VixaCO7rkIdyzMDaeEd+J5uYfwckfYjgFYLHhMOT0tfi/dfheOBbqI8G3/fxGqWMmRM+IgTndbyosoG5zoYJOgOsupqGsTQfOytXflsH38fGH10TNc4UjKQq9ZtpEjiL7HuBp2v7gQ85RmeP2zFO3u20tWrEeC7ehEy9QmTeTQGAxpemBYw/CKP3dAMoRUmgAXngzjn2vCu/P35iMj9x3DojAbbI79KbWaGE4MQ==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 06:21:44 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 06:21:41 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] net: lan743x: rename is_sgmii_en to is_pcs_en
Thread-Topic: [PATCH v4 1/5] net: lan743x: rename is_sgmii_en to is_pcs_en
Thread-Index: AQHc44+N6sbu7cOXi0mORQ6W0hdOxrYNdgsAgBQAZ8A=
Date: Wed, 27 May 2026 06:21:41 +0000
Message-ID:
 <DSWPR11MB9715453848874BAC818F4890EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-2-thangaraj.s@microchip.com>
 <d67d44a7-26c3-48ec-aaf2-9b6dd73bfa83@lunn.ch>
In-Reply-To: <d67d44a7-26c3-48ec-aaf2-9b6dd73bfa83@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|CY5PR11MB6210:EE_
x-ms-office365-filtering-correlation-id: 6bbf7727-dc78-4ed8-5539-08debbb8377f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|4143699003|22082099003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 l/sdsgOBA1q+CwhFIrgOHT+oGOQWubjukYrQQe4L047cESBcgvH5lYPyyN1yYt/C6coV8PoJtLw53gHHPUuqdhjaSqS7wDrqt11tEchkf8dWGkoWw+RrdkshaOv0og0dvFMtLH5ODVVkRY7bVe6Ld6XKbwW+XD+oRQ1/nTFW3iESA4JfMJgioK0d9NStC5uJ0gPRVdrJ+ocpzcgT7rOodRd64JhG/8XP8EE62xi7T7QJemo5nOc67Vh4B8hGV1FkvO/l9oUEI3Tcj8i3A+/93qUKdoS71TYdF7MunwkOeLddk8xPc9NmSenxIoDL3se5aqaEIlzsCuUPJoOuuWXJTFfgNXf/sjJQM926vSq5gU4sXKt37obG54Xj49+0wldMXXOBQjegsus68j/tVmCbRZxcrQMVAhp/bf/N5ca3Kwu5avdNAt4xjGJMi++5GCYeAKV8a97NVcGr1bOwxcSDuvCQU3EaMLe7VChYXasVfaLstSC02L561GRuibcGSgGIfjIljpYsHZzS/blhQIB5H10HZPe4PP48UE4HzFo2aCg3cKuYfva8PEhBZBXgfqi5i8RlqnvMyTXudFAOV/e35Od30yq53YluWAigr3vNHeyQOEfsOIa+fawBZ8yYqfI0y5HtLuqDlkyaADUOIEPfpLDfj8n3ZpCsFwc/SHNdCky9VKgEu7Rz0FNZk7KrISiBH3HeX6ln54uA/xtORaFDcAMvcy6Ka9S9VuC3vZTvvdzrf8aPPdKeLG8+bxF6V3rQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nVSjxz7bc3QymbXlNyLSIs2KZt70L0i3mWvGQeJZAFLG1+dHNS8mGKOmYJI4?=
 =?us-ascii?Q?QL39Jj8dQJkUsPcQvC1uQbiFux3ll1EaGSeoolhPeproXFmgf1V9kpGIIFZ6?=
 =?us-ascii?Q?vATQG/yTgcBPmgkWBnFAWTetFGamBIXfbQKRtxpitxV1Si5lOUiVA/h5tgL9?=
 =?us-ascii?Q?wk68H8x30lgfsonFXhZ0+Pb4z7cEpK8z8RlMjnN5tqkXI44H9/+8QFh5yOpS?=
 =?us-ascii?Q?YD+Lb+B65FJeihgX+Xw3KBuABY4fOqPWkYUJj4yr0KHNZT9M84WUPWBwIAsy?=
 =?us-ascii?Q?k9vLM1dxN+91EPuj2QOFIGImbk/StUVeXhqQzYLwh50o0KYn9vwsC67opVdx?=
 =?us-ascii?Q?XXgt2y8qFBKcY9XHdburF48n/VHoRFdV6ph3zxrPJYrw0i+MbAxHM6p512WV?=
 =?us-ascii?Q?ebzz8Jxh8ovjt0NVIHozRHJxEdUOhYJa+XRVobPxwtCOJJ5pLP3aJq+6emgK?=
 =?us-ascii?Q?uCQ/e6cXrIfZ84uBfF53rvjiwfUpsIyoJlJqiLudP7FjLNF+zDQGBQkSnOE1?=
 =?us-ascii?Q?ESfiWOXEmsFR0RPvPFrfyXqeARAccw+PQg68MmX8mMQA9f0v8Ke/yCx0ekh9?=
 =?us-ascii?Q?z0x7g+1/IUxbgeNMkJHgZ3EhBga9O1o21OtZTIIBZm8h9fuxkueOMbIMBF2i?=
 =?us-ascii?Q?EpeWseF1+K2GFqJC9afFxmotu1XPhTfrLoW/KJXiTujpcN3aU/+YD0kpsm0Y?=
 =?us-ascii?Q?gIjMwwtTDpVCkzQCvDxcFxFtFNJVWPrpqm+99stffc5bOmDOAd9Swf5qYuag?=
 =?us-ascii?Q?KDuy6B7DMd61A7oc70OaiWP4xDhP+Hhx+D7O6tRviHLYPJcQxjSTiHjU436b?=
 =?us-ascii?Q?Q5398C4O9O0ARGiXtxGqaZ1j9tjmd+0CfYWIp0SX7oivSRNW/nBD0tsMc2uQ?=
 =?us-ascii?Q?pa36kAHdqRmXoFh/oedrnGFGYy33vnzduksOrlKb93J0QsmNYdbde98zqv8t?=
 =?us-ascii?Q?/O/9mnv9m7RuAxjgYbAdsYiDiAz5ya8PkV35j2kbV/wrYaSKWjpiWCGfQMCy?=
 =?us-ascii?Q?QSshpu9rIUm2AbY0oDQ2UeDVyKp98Ct/t47khZ9ozkATdt0DGnsyFMch6w/4?=
 =?us-ascii?Q?fJq9LY4gU5arcFZR/FZiZDoWDASctmVKDUqTOPhZbf1NUWGe+QymQfuhEawi?=
 =?us-ascii?Q?gLeeWkH0SHvGwOwMCIlT/QI4y/6xLRQScg7wtjjG26aX+xGGcRmkUoxRTiZ4?=
 =?us-ascii?Q?o3fryrFqn4VknHG9MKPfXQunUPvwOW3QIVinXyPMwJMpav3TAc3HZI7DmbWQ?=
 =?us-ascii?Q?2M+7nRgUCT9ie6HA7e8AD5LY487lGMnluNAnxfOsG7jiMF3aIggyCv/lR2lT?=
 =?us-ascii?Q?7PkLRepb1SiW6HKACyGJ0OLyztGrkOriZJ/3bIFlATkgLayzUNtIUpSpnY9D?=
 =?us-ascii?Q?2knbj1meDANw/dWgXNo+jjQBdqMx4IX8QJ9RnLPaqBEWvJdsOrcS9bzD7cz6?=
 =?us-ascii?Q?bHT76a2tmswOMW/mi1iMIhVbDmwVs5YtT3nGGdvOhqzNK2YeFaR9O2AHtTxR?=
 =?us-ascii?Q?goGNMhmll79i1OIMgn2b+ftEAsF273PuMQPni8KVWcuO5+BuVTqWl6S9x7Yg?=
 =?us-ascii?Q?hQ40HAYK3DXVXq/x2o0R+vNQtu36UGxag0TQ5UjgHPdSyv7JIm2xV5Do7j0U?=
 =?us-ascii?Q?9kndugssPwpc4L1ebVQXwFqHx3ZspCDgKYwx6g9V0UIsVFkw+XEsZot/TUZc?=
 =?us-ascii?Q?8zoMggrthoHKb8r1Dem5voKXZn3rwQgATC/fzBofuJvW/9e/WJVuBKQ72iGo?=
 =?us-ascii?Q?ix/h3HI1MA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbf7727-dc78-4ed8-5539-08debbb8377f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 06:21:41.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiubeNvQA/kaGM/juo9M7jSy2Q1gxMKK1ATLvBkPEPpRfdPDOqRUxWPTxmAYIBeuQ8vGp2hSoCHxDIxcXj8dlVv+7w+BOesjHzttc6mp4qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-292105-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,armlinux.org.uk:email,microchip.com:email,microchip.com:dkim,davemloft.net:email,DSWPR11MB9715.namprd11.prod.outlook.com:mid]
X-Rspamd-Queue-Id: B4ABE5DFC23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,
Thanks for review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, May 14, 2026 6:09 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 1/5] net: lan743x: rename is_sgmii_en to is_pcs_en
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, May 14, 2026 at 04:20:24PM +0530, Thangaraj Samynathan wrote:
> > The flag is_sgmii_en indicates whether the PCS interface is enabled.
> > However, the name implies that the interface is strictly SGMII, which
> > is misleading.
> >
> > Rename the variable to is_pcs_en to better reflect that the flag
> > represents the PCS enable state rather than a specific interface mode.
> > Update all references and logs accordingly (but keep device registers
> > unchanged to match its documentation).
>=20
> So the documentation is also broken?
>=20
> Can you get the documentation fixes, and then replace all references of S=
GMII
> to PCS?
[Thangaraj Samynathan] , Datasheets for this product are already released t=
o
customers, are not under our control, and cannot be reverted. For this prod=
uct,
these changes can be only done in the code at this time. We will provide fe=
edback
to the hardware architecture team - datasheets evolve from their architectu=
re
specifications - strongly recommending that the terminology should be chang=
ed to=20
PCS" in future products=20

>=20
> > -     if (adapter->is_pci11x1x && adapter->is_sgmii_en)
> > +     if (adapter->is_pci11x1x && adapter->is_pcs_en)
> >               adapter->phy_interface =3D PHY_INTERFACE_MODE_SGMII;
>=20
> Maybe this is in a later patch in this series, but i assume
> PHY_INTERFACE_MODE_1000BASEX is also a potential mode?
[Thangaraj Samynathan] Yes, the hardware support 1000BASEX too.=20
>=20
>         Andrew

