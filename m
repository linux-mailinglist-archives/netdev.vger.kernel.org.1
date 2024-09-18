Return-Path: <netdev+bounces-128750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7B97B69E
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 03:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279B42852A4
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F396FCC;
	Wed, 18 Sep 2024 01:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB6D299;
	Wed, 18 Sep 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624086; cv=fail; b=AMcXWA6E45N4ck+Oi2fbaxEODdleGWq4KgNyJXZSIOHfita0a5j4qekXB0r8h3N4Rso65vrKr0+TKuHzCp0ntbQ9iNZAKiy1n1KEHuNSYXkqsIhHloE48lA9IvwXCJPkDC6wzaFYF0HqD2/DWFFVquLwVlxFUJynkMo1V7bAIlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624086; c=relaxed/simple;
	bh=v941vaBwqsSji5ILT7d8CpKyb9MZ9P4C2mmCOh8zPO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CeJCTxLekrEWFkDyuCDX2OwvJx0ozazMTTmqD1c5ptKfVJbElyq947JnAm9Pwi/k60yGrfY2RYfomRvhcsfqd82nszCyC37lEPYN9kPppFV9Avq+OSzpH9XN4xhThemROb6RW3CBAN1jEkGikh7bHJbBtymHfcOQpWvVAz2B0UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNgkq2j9ATKgdWcGeDZJbiS2ArpvqSoUHb/8+bbAh+BSkoy7IwrTzmHVPci3qPO8w2WOhboIzFdNW1jjDS0IPrbFNaSqwsKBM9xrTE7lS/YsLeYyl4dwj67yWiXyqshFwYg/dFshLV4gC39/9mAIVt26wI2vd7qDOlXn3FVWvMmNwUkZd34S018lFVXE6c/lv2Ul+/skQhGpclHaH8DoMIMkPWxstFl+4YdF9DkYBACa/1BNpu2x+EACJf4hcQmkIxn9RElu8S16at0EGK1hHykjzmZUpYzkYMZChhIyPkmTYnnNcNefXVta1GSG3BkFnoj514dD9J228wby7gblsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+ipgbcmYBwqiqty7qanJ9jeT3tvGo5u3mreL/UGAKM=;
 b=QYbFHtJ0vdh2xQee1aQnhwbVOGqQvdT4XrbvX3MLAU6FqJWsoSqckT3AxR8pcjn2NL47IXcXMvsCiRUxZH3hf1Sy9cq+XkpcBZzaKh1Nqn+nKTFQGwBFgOzSJ4O/W1nR1JM6tJkMLlnjrkftRhCXtZklq3ayMpfafJKJCVRkud4pErmymX/TyAHeRbP5MOpzxaAHPTcxrEkW5mfhldlBioMZ8+K+EfZrYK5tEibP6XGL4JLX7Apf/yXsqu/tSpdT7GVef+r37NkmS10aAjvKFIRtRIey7kOJAhFlXP0Bse5dTxez9C9KOKAFd3FWocqfKsY+7CWThI9HooVXFqfkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Wed, 18 Sep
 2024 01:15:20 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%6])
 with mapi id 15.20.7962.022; Wed, 18 Sep 2024 01:15:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Simon Horman <horms@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v1] stmmac: mmc: dwmac4: Add ip payload error statistics
Thread-Topic: [PATCH v1] stmmac: mmc: dwmac4: Add ip payload error statistics
Thread-Index: AQHbCB2PHZuINr2cHk6mAhsoMuUPOLJaiIOAgAI3tVA=
Date: Wed, 18 Sep 2024 01:15:19 +0000
Message-ID:
 <SHXPR01MB0863621A177B2919B51A5694E6622@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240916094812.29804-1-minda.chen@starfivetech.com>
 <20240916152325.GB396300@kernel.org>
In-Reply-To: <20240916152325.GB396300@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0640:EE_
x-ms-office365-filtering-correlation-id: c287f8ae-28bc-424b-7ba3-08dcd77f5ceb
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 5mWFn4/UbqxAVQVLyauBidRMAYeeP6x4OAXyo1hAtMUmdyVDDJ4hZ2wvUzThxIac/tRhZ9b/YcgWr8Oo0UAlwD1YnSk+1/x8BPWPRTvwQsQrcTW7iU7gEVy4xkMtUUYmKFUbOaHnJNlGOtmThezHH7YDUVLQSgF5+/pGPVmzFyLMzeFNflR4hH6WwtJ8Iq7tcE3LrxNp1IdlIR1me9ywTMqwZVFLCcwGOKJJ0QKueKQr2l6Jm12uQ9gsTcGgO3g/gJUXx2nsMUSKf1OoC24h3ioLqLEi9Hvse5Sme93nikNlnFsYq8fxgSDt+cI52+0j8U7UIQd8lm9eGebkMYoyGzXCYJ/w1u6OgTZbkywBykDjzDxqIpqPj6hh3kjTwCFfehe/0OkNn3Bhp/g5F7yAMqK+biaf5s2FUMDUH+ib1zSLkOK9pg/8xnRw9QPcOk4Lb8KfqJs6dI/IFGhGgfx2alaTZ9IfcbAAwXJSLk7x2ZAiK0/DP0L564n5bX8YcgMMb0dpUbF8oHunbVPJrkjNccHnA4moqlTdkiFXHotxWqXM2ISw+uFb4D105PH1KgWDQ5/8JePpdzO7BlBM/4momDCFfs78Fwpq5y41Q3r1Za6KadP5ZETlHzDMAq2jO0Fu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PN+XiZDFlhr4kcaOcycfA78jqx+O/pJgjUAK1BqNlzQMZpcYAyU8GkEqssq3?=
 =?us-ascii?Q?BXTLtjyeOriizf5x9allosthkMBJHAcopcEuj28MTH8weQ750GEgQoD5mzXy?=
 =?us-ascii?Q?NWd3M2WDq3L49LXLU+hvUEAF+frUxnQ24tZ1RlfdC2KrdS9Ru40wLjH20Dn6?=
 =?us-ascii?Q?aNfjlQ0A+lEO33LlVMDwqLAKK6QCwVEeQaMw+/cIKxvU9zgp9Ug+WLLkkbFO?=
 =?us-ascii?Q?6Vh4NR45b4D8UVRKSG02uZjCRqVXVcWDoH2FNYCCziJq39Jr6Pw1GdZIBqBB?=
 =?us-ascii?Q?9EU00JW8pvk6PsCAjsCZgqdN/siiq+HLcr8uE7o3lgpeojbVd1IiMMyFkj+g?=
 =?us-ascii?Q?iykFsmT0+2EScgCPjtLMzzks2W6ao3ZaUWnlYdAYbMbqA0/SOhiP2cD4jrqU?=
 =?us-ascii?Q?f8DzqzWeCb7GBI9yCZLU0Q19+WnurmTtD3GaDod9DCyibFDbewcS/YrvLCtt?=
 =?us-ascii?Q?TTcC49bNMReiCHKNU2r7xM2ETo/RoylBc+5cvSzhQ8uDsT8MCaBA7yy0FPeJ?=
 =?us-ascii?Q?vaJO4MJLHhY+RiGN6xiJxI0TQbFIY2NudyM04kyV0uIR3yDBSVLVNuR/k4Ib?=
 =?us-ascii?Q?JY35DiJjfLY8xCC+EgivoZOz02fRGxDXUlZUbPD97sK+Pxc890iWjm+nQhtd?=
 =?us-ascii?Q?w2BcbxA+GUCKPB3kH4CHcGGiPhkD3GeqqtkZgDeVTFsnpC4zvctt+8FBa/dX?=
 =?us-ascii?Q?euxUjPMc3cYLgr6pEEO/cRAivIPeeXPS/WhMmUP/u3De4TtuqiRssjPvGRIo?=
 =?us-ascii?Q?O3YmN9A02kN8mrDtX/A2FMlnr/771A1b2m3TtNm03NRPGjQd2weC5p7o3VLU?=
 =?us-ascii?Q?NLJJmuRD48z+k1/F6zi+C20WKKYIm5xRKE9wL6j0onDMNhbpnaf/+2+zFulc?=
 =?us-ascii?Q?dFlz1KaNgL626OP1e873H4yJNy1gcAC9x++ouWAevtU+lVSKRxJpGgrDh2Hq?=
 =?us-ascii?Q?Pvi/EawcTO3THk3OgS0zRLGLSCvrv+A5DnmyhlmNQV7peN1JmFVGPUN9o/hs?=
 =?us-ascii?Q?IAcGbcB84zW5wDvksubfGqX0J0YLk2aCs1QBPJ+issj/YuFbdFG0hyuh75nt?=
 =?us-ascii?Q?VZ8opNyaM7Cg9ksTGvdeOxnLqI9lEx/k3u5K6eerpVcfYhj/TA2FiJ1RZYbR?=
 =?us-ascii?Q?UoPBc3QSYNNsnTy6i4z1aDksMaMvhZtM5PgwpVn77X9X0p/LN81bYptcJlo8?=
 =?us-ascii?Q?GGYxq0O2okWng27GQfmBJu6pkUH/7MLAwc0A5uH9Mh0nIquOHbs+frsdfg33?=
 =?us-ascii?Q?cQEqakOyv8TDIhPpzZp7tk1piMuFdEMR7Xz79h0cj5+GBxJalCD0dHs8ztWu?=
 =?us-ascii?Q?kQC1cmQR44mr9zDQJbuxx1UfZXz3G0K7qxwd0/zn+dcAWkfM4UlDKw5Uz95W?=
 =?us-ascii?Q?5MKuFJ+7D+r/T1cT6yzAtXBcZauM4214yKmyvM7hrXu5f0lXP7qXGDpEgO2t?=
 =?us-ascii?Q?Zo+oMVqJZfUOV0XoHLddBnJapI0mVhUs/zkOv8P84noQmaWNmqdnX5+yDU+J?=
 =?us-ascii?Q?F1dk+3KAWJGSNiOpR9gFQ8ceh0IGmtnkS9kHhrSYHzv5Wwg4R3b+bEgC9GUD?=
 =?us-ascii?Q?bdYG/F1KPvaGMRKEg7I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c287f8ae-28bc-424b-7ba3-08dcd77f5ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 01:15:19.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFRETBxrJmxKppWzXxaDS+CJ8Oez47wFRzUWapYzArFLHSUIjyG+9BeoNFcKQxkV94NgR0guxDh3bJdot+fpcQ4bNiKpyZR9giJE9WZ2dpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640


>=20
> On Mon, Sep 16, 2024 at 05:48:12PM +0800, Minda Chen wrote:
> > Add dwmac4 ip payload error statistics, and rename discripter bit
> > macro because latest version descriptor IPCE bit claims include ip
> > checksum error and l4 segment length error.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>=20
> Hi Minda,
>=20
> Some feedback on process.
>=20
> net-next is currently closed for the v6.12 merge window.
> Please consider reposting this patch once it re-opens, after v6.12-rc1 is=
 released,
> likely about two weeks from now.
>=20
> RFC patches, and fixes for net are, OTOH, welcome any time.
>=20
> Also, when posting patches for net-next, please explicitly target them as=
 such.
>=20
> 	Subject: [PATCH net-next] ...
>=20
> Link: https://docs.kernel.org/process/maintainer-netdev.html
>=20
> And lastly, I don't think 'mmc: ' belongs in the patch prefix.
> This is an Ethernet driver, right? Looking over git history, it seems tha=
t 'net:
> stmmac: ' is appropriate here.
>=20
> 	Subject: [PATCH net-next] net: stmmac: ...
>=20
> --
> pw-bot: defer
Okay, I will resend this on 6.12-rc1

