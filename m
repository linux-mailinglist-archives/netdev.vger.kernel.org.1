Return-Path: <netdev+bounces-278941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF2RJ/J/4GkKiQAAu9opvQ
	(envelope-from <netdev+bounces-278941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9D40A9D4
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58DC3124D76
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0232F742;
	Thu, 16 Apr 2026 06:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2134.outbound.protection.partner.outlook.cn [139.219.17.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE019A2A3;
	Thu, 16 Apr 2026 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320361; cv=fail; b=Un4MavzRmvtTRxcrpv+8JVK+Z0pvyeBhYRGykB1R07Ug/xJQEY0N2m51EqNSMnI3tEWYSXTE8aJ3l5G1DhOu9t/rLMURiLp2QFkKPyuL7VpPfx6nV2cOOwj0t5f2o1UmeZaupY9VOs43Boq1mK5fFzrJ3vnfYTh41L9BHFBM43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320361; c=relaxed/simple;
	bh=fvI49G8qNnTRF7EkXlk1+yk013NPmseBact2Lqw3pyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L9gjmWL9p6TF/5ImtPh7ZiVHHycL9cVVyRrdCVTNwouAIpsXm7m4uJfCSfYXXUhr7sJzqj81NJMPxqgh01lZZ46Kmf3D8Zw1xR8fXjynuovrWSrTnFZblt7z7WJJK2aGjHqf3yPw8kS32hsFVV671blPspC8zgFSoTiP/f/N1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPKuzAu6HhGBhTjiefmCCK4kLwZStBRamLxn1LpaUB/pw6olnD2hPx8y3xRqSnu6CD/9AKI5qJnjcNgiRCx/MEg4my0fsekqHgWNLu0NoCNpkTuskSl2G1tZuJhjs00w9XIj38vg90ncJgTrdxzhfj7/7preur79iE+VI3NwB/3nae5A1VOy0Yi09oacrA0YcB1SIFVjTGQHXj69RVcviM67476pe0miIJYZg7oJhtrd0EpmWxCFVDrwaWCNgLBeeWZp433fPyPvuQ3dSKlRu9aBe5xc+1MefnAkDjP0CyyV/NQQyU866Ty1VHhAlIuDcfYZB8tfx0ANDe0QrlmM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp/XSv1GBOvrB7zrsB5cwctLL+QL5370I0xOj/+0G/Q=;
 b=Lu+LPN8IcXuvOP8oVSkTzdOn+TgaTy26IrOolwBIzgv13ZMCMVcKB3eNIu1JR8w6xiL0OXI7OqYg7KD7PJtyVrJssyj3kLAPVgXNNafmKdsaBhGDLw+sdFXJi2uUE0i5JmolaDVOJyyz6dTr7dT7CdHlbyrmOO23saGCqWJMMIXZu3IkwoAg6mg+JgNsT4t9JeAoAXIGB3U4CZo/xBAUUb0VQDQFRZvl1O55aAxdnuFyS5AS+c+Lr/2GuH9rO2Fi0F5NG/+BxN/Cb8oFIj6yapx7392SLf19NnRwiFqpWQeo9CfOgWTET1qgaY+E1EZUiAp8SXG8tXGxNXpV+1eZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0775.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:19::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 16 Apr
 2026 06:03:15 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Thu, 16 Apr 2026 06:03:15 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [net-next v1 1/3] net: phy: motorcomm: Add yt8531_set_ds()
 mdio_locked bool parameter
Thread-Topic: [net-next v1 1/3] net: phy: motorcomm: Add yt8531_set_ds()
 mdio_locked bool parameter
Thread-Index: AQHczLoFZuY6sqP2M0GwTMYtfeTAqbXgMh0AgAEB2sA=
Date: Thu, 16 Apr 2026 06:03:14 +0000
Message-ID:
 <BJXPR01MB0855E0A66E8F32D5F0DEBF90E6232@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260415092654.64907-1-minda.chen@starfivetech.com>
 <20260415092654.64907-2-minda.chen@starfivetech.com>
 <f308dd00-e589-48e8-8edb-d3b9ed5565e6@lunn.ch>
In-Reply-To: <f308dd00-e589-48e8-8edb-d3b9ed5565e6@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0775:EE_
x-ms-office365-filtering-correlation-id: 28b99df7-9616-43ba-822a-08de9b7dd93c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 +TLtH+0PTUPpasqwIvIc7JIYTn9awWi8AZ1EnkVfA5WelTQcUUoqrZgHDOWjl+skFxJTm9smdAvceACr89tBNUjxFFZu9MWuXH/E7q615UzHfXUV30jUsDZjMlmCJK2ViooONSM4CL92fCrE1hyyNG7tj0HqXIr5jxhq53rPQLqphLrC9jeuJeeJI+hzbF2Ivtbnbx8UW/lO/x0BMyd7E/fNQ1BjPiT5XZgFP3QG/zmpKLqU6LT+i5nbioeyVRwLub8dT1fR+eHw7rg1HCGhP0JTOGFL1UxHVfEgqQvgmySTbnwq3HTCE7js9AQEfOfEvDNv4JEQ9fUfWnUhzREe5L7kGOgHTNFnCU6xaXMn8SNt9yeE18lr4c+LfX+Z566uGz5DIohjeG8ZFhDqNb7J1fz6xvGCtEl/wMZp9n3Zala1kDhlgvoBsdCiaK0dvQoC19R4I5WBa7+Ez4KVBt92nckueCCA9BgQfchbZnQM8Tj3yMXUFnEJQARjNetYvJfkECD1rfeNtcAaqTyMS4zgCalzUORYyzv74f8F757DJtZHqc5n3SscJH4ZVnXasj+9UKd7AEqw7PlolR9KvgEBeg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1CZ4zWCAMJI8qQmpxQUlX5SAJlWfAC1pYdqHtXw7Q7NOG2CA1f/a5qgxrWLd?=
 =?us-ascii?Q?wIC0raLD20XbBPzzxIoqSFNy6HS4fSsv0GxNFVOKyNklK2oSdhqL8BUkp9QW?=
 =?us-ascii?Q?u1sZOtlXe7+XX/SEPISIuc2a/w2QyFXfNNTgaUwX1STiaBzAyeapZ8LNzH+5?=
 =?us-ascii?Q?sYdNV3UZM48vqVD4b/MvD4t7Nncnci/Mefq0gXKgOjSQBY7JFJEgcFdg/qwG?=
 =?us-ascii?Q?fH9k2gsiKdHisIl0JO/yCIz0Qr8Z/jFTIYpwWJjtVFHZegG8Tlw4X2JAE8H0?=
 =?us-ascii?Q?FKK2dIUqcX0WwPKcGxJTm0MTHlI1JghiXS689wGHgEkrun1c3Lm1HCiETjxW?=
 =?us-ascii?Q?N3Fu+fraR2PA3SWXaF0xvh2X4Sc2WolyuDxhn6GAjTflfYOnciAnX9+RCf2d?=
 =?us-ascii?Q?m1mYao69XrEHYdtAXkB2PWjAG948Am1zUaBYsb7lxnU8TMNo5vPM9IIr3qhk?=
 =?us-ascii?Q?xWW+i8tRIq/TLC6qpdd6FwkVYPrkg0vHpdsEKY60/Eq+HUB5yiWYvp3Z5Q/7?=
 =?us-ascii?Q?YX51LTDfhcOGVtroBqVOsw2qviLf0JBULTck0zm5xnJiTh38UGpLmGatT5aT?=
 =?us-ascii?Q?3bLAOaQNtqsk6MnMq1Sut98AATTr+YROZi8j9d9TY1QnR6pzPEpuGLvdWmlc?=
 =?us-ascii?Q?w+eFej9zYLWhU5HMLUy05JX/lcPQXmyQKASCyhfnvUWeHUQ/ppc9PVg3yUZa?=
 =?us-ascii?Q?5kqr89knXuKDOz3h1U5B7T6XSxfPgnbfvic/BQMH061OtrZdlIOMnvQWlZfv?=
 =?us-ascii?Q?04xbRKq1BjAi/Oe5g82hHTcgVhm1RlkqUlQ9UUP8d600DAPwJV+bR2ruQn9n?=
 =?us-ascii?Q?FKuX7c7fpRDS6NBdWtrlT85+JxPxFKMJRdPYHfbMD+Yr+0n635LrDB96+nsz?=
 =?us-ascii?Q?MroIv4fwof6yXRoe9+TTo4Fr1oGzhwuNIhFk2i+ePuQU3/ojkWZC2QrA17mg?=
 =?us-ascii?Q?K+fEcCFUqE3KRxDBiFumpcdF+IiJLr/xDkXIArv/6mXTXq4WO7gGzGpHYUzq?=
 =?us-ascii?Q?GTwJ+wBVxpt0eMC+z+4166l48hD1J5KdDvC5O3+uUDK8Vfhjc88CmRCZEhJr?=
 =?us-ascii?Q?Ia11jhdmoLCaxPzds6NBTOupCr5herkYa7oUZM8CViu4h+VthW3zTJNoJMWA?=
 =?us-ascii?Q?REo8O5tlkBqh6ge6yPOhKalixUghlbdkMNzNyMEDp6KhF9OwQFnWSKpoWntP?=
 =?us-ascii?Q?xNqcCbQiVJ7bQMqDeBl2TgiLIL8WWIy2boHqlnGLBSOifQIlo6IFgZIVeYr8?=
 =?us-ascii?Q?QEADZZAiVAZ8hr+liOK9Vweuccn3HKlrqgaWdJ3s1152oWHHO4JMlaJnGD4n?=
 =?us-ascii?Q?wn9KXpS+yskr+Gk2qmSbGu9fAZvlY8J8HcFb5SNwHLCJ1lMrN58Op9T/gp1f?=
 =?us-ascii?Q?SG1+bdo/IJ57xv6eJz1TS3Q7+auMoBG2BgOacnZSyY2Zzri/QZDwZ+MpehtX?=
 =?us-ascii?Q?pCWTPgGoFYjEzL3gid8PY7SIIon6zpQHk5mn/46aIu7UMLMgUDUTa9M5J/KJ?=
 =?us-ascii?Q?wIAeaWjNqvix2xq5fh0wqtx9QM7emlMof5UDVQubH/Iwm+OyvddSrwl4dX8s?=
 =?us-ascii?Q?Sr9AE/ENas3yzl/p+Fn6IArFAxk2qs6rrrkugbGKvKLLfLm5jOWvBsqL3PpT?=
 =?us-ascii?Q?JdWM5bIMhVaiwuVvm6b1jX/f+uxob1M+Z9qbm/8JfnzcILJ8rUyTeK6XEUqS?=
 =?us-ascii?Q?pXRGHLZ+8QorLVBBMXZRLwxZqIewp9xZv8LIj7EZ8nuvHPETrFmX90HI2KLx?=
 =?us-ascii?Q?qMy07lOIhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b99df7-9616-43ba-822a-08de9b7dd93c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 06:03:15.0214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCnWo1H+HQpYm4bIUyfS9d+FgiM8Cx7ehdJZEjq0hePPetV5mXxUkAHp4p616XBxuUB3EZMkEjQJryzKwsj77budoambcG955XM+W7qM7X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0775
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278941-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: 06F9D40A9D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>=20
> On Wed, Apr 15, 2026 at 05:26:52PM +0800, Minda Chen wrote:
> > yt8531_set_ds() default set register with mdio lock and only called
> > with YT8531 PHY. But new type YT8531s support RGMII and has the same
> > pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
> > setting pin drive strength. But Its config init function
> > yt8521_config_init() already get the mdio lock with phy_select_page().
> >
> > Need to add ytphy API without lock in yt8531_set_ds() and a new bool
> > parameter for YT8531s RGMII case.
>=20
> This is ugly.
>=20
> Please try to modify the code so that both PHYs can call
> yt8531_set_ds() in the same locking context. You then don't need the
> mdio_locked parameter.
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

Okay Thanks Andrew.

Hi Frank
   Could you review patch3? Thanks.

