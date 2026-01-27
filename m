Return-Path: <netdev+bounces-253666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGm/CKYqeGl7oQEAu9opvQ
	(envelope-from <netdev+bounces-253666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:01:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA58F56A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A08FF3029623
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FBB238D27;
	Tue, 27 Jan 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KK/pMKta"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E322836F;
	Tue, 27 Jan 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482907; cv=fail; b=jKuvDaqRAj9G13HU3ZAisR+cVXktLrU2Vr9ea5t9ynqRu7YeNqgFqBNNQjrrMdH2CQ/5UJJWlYOJKlQ3oZun6F1k8iVjhL3o0qmDlI1lWuVz/nsO3dihQA/55Pa+fcCem2M8JX4XKVdjaAWNNSwG48L2Gl6gdRj7LqmuQxIZEFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482907; c=relaxed/simple;
	bh=227HhpIzeZ5iBg3EZJF9I+x4B5hx6nlDchPF/EQ5IyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZX+2f7kSNb2UpPvxw393DeNOZJUGr3QgtilB3ZyRwlChufODmAFQ3r7EsNgbf7BLFrGdNRFw15nk8PLT5/QXO2NioIQHoIlelUBc1s1SopxyG4+VJmDJHxTpR0zlFZ+fHxVQskV66ueZ3Vm0iOmpU161auooHN7RbBrD+bI2xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KK/pMKta; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCfxinNrXUHmvDlX6L+ZYAh5JRcxkF551SbWtwmTh9Dkt997JSMLBEQ80JtR9spMccjvnWEcjatEmIrSnmAZSmjF9VBgpXtB/cwuF7QnDX6D38hFWg4dhkYuBDiuyr+DA9ma9VgwnftCGx/+vqSpC4NAN5vQEcTh/VYCUVpsTuzwoLksqNiyvGVdywGNcxiNOnOL8f+siw5uP7ER20hTZlXxLTr2bIGDe1/iRT4LdkL5rUpbyZKIdXJvlLt8hfyDb6yroBEuVHmzFjdzWZT1AteWn07LMlLhg1wgjrkZgr5ru/XTZ9ADVnuQMe3LuStPqnAxImMO7dXwYaV7NhjOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=227HhpIzeZ5iBg3EZJF9I+x4B5hx6nlDchPF/EQ5IyE=;
 b=HTcpFmIOTRi+hAiodqQiUNfPYyYJ398IE5TjHOMN8qLFHAZnjzCKuNd8dQODU9AyWVRxiSCSPHR+5Ptb4oWzs3K6vUZ7iknhlhEKCEe2zJ/ijVa89DgDwd5Qv0c+enHww0ItrKXG1XVhJGugBwW1u6RCCAVlJlIiahb2QqVo/kLU50zu+jyTORtMwU31jSoHPc3ebrp07f7We8ml8VuRfRfmpIU5Rg1s40K0WfvTmzN0Ctp7+yn4R21OFEhBQBiArgn1FlE5tAkYsY65DgepJxJFjjZW7wKX8TtTP0Av/4QWx+Z8Pv++jx4aFq33sF/r+MIDTZd+PZb/eDJMFGI9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=227HhpIzeZ5iBg3EZJF9I+x4B5hx6nlDchPF/EQ5IyE=;
 b=KK/pMKtaf1VVeV6NuFe+HO6V9yEY4TqmIrRg9lkuN/eYRFWKSELc9lWMC9n8FjtF8goa1GgSuAp9OQneXnMuUwl4ZB792yeklkRP1teJfujx5qoxdDUVYh7VWikGzAI6aPkwEMF2JwAocJ+E5ssaTSorcOeAhJ3t7DVpZ/AI9xiglDGaQjUZhyoPpkwMyTU7cyQPcV0nUrtcxPSz5CljQewaiqpMgGQwpkBjEpw91qZdF36sysH8hitsP09y8JupQofbANkxSZQAggYbSlvKtC5td1rJ3TVkl6VNDf2njtR+8UDSAj7r8bJWoD1Gbg4JeYLgtEOm4hzVUW+fySpCuA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB8000.eurprd04.prod.outlook.com (2603:10a6:102:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 03:01:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 27 Jan 2026
 03:01:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>, xiaolei.wang
	<xiaolei.wang@windriver.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "quic_abchauha@quicinc.com"
	<quic_abchauha@quicinc.com>, "quic_sarohasa@quicinc.com"
	<quic_sarohasa@quicinc.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
Thread-Topic: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Thread-Index: AQHcjrC8X7fZpJnZe024lfTnDwQHCbVkfn4AgADLAYA=
Date: Tue, 27 Jan 2026 03:01:43 +0000
Message-ID:
 <PAXPR04MB851096811F2CEC62BEDA67898890A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <2344001a-08c4-42f9-b4e6-116e39fbf1a3@lunn.ch>
In-Reply-To: <2344001a-08c4-42f9-b4e6-116e39fbf1a3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB8000:EE_
x-ms-office365-filtering-correlation-id: 3cb315e9-b4f8-4e64-5d5b-08de5d5066e9
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e3whp0sN5hBk2yMSyCdafFrlC+e1FAIxQnmTXZ+hw0LNgW0CJiaMuAUFeM75?=
 =?us-ascii?Q?7KVXla472r/m7Bmi/YTot9JDjv1tTzgLnwnnUZoGMw0FUxoyw+rjqCu0W27T?=
 =?us-ascii?Q?6MjMel4paT9QXOsRKXexORBMSht/RZ2qO7LOomqlqymqTwl3432yyJyi7Fet?=
 =?us-ascii?Q?StnMdlRhauTLemc6wibjsvhq99eoClZ2Q4sVEN2SjBTCYJVPAR1ewk/GaOfa?=
 =?us-ascii?Q?WOWgOuCFskFwP7xeC6ai0zA3btHRYKmYi+RK231ZOcdL0QQU6x1jZagCkxW1?=
 =?us-ascii?Q?O+j9XHnbSQXqnaR2uqWxT74eynL2t1ffMMbIMyM7WVf41r6+rOzd211ZxDb/?=
 =?us-ascii?Q?+MwNSaq4PBUpop5QFbL9N9pUcgNShobwuuJXj4mE8FK0zjCwTQnkBUd+byLO?=
 =?us-ascii?Q?g+fhp8mHmnupDjX8PHZ0nk+zh/MTXPqC/ROiQnDChb2I9S4VzAG61M7g0S0Y?=
 =?us-ascii?Q?Gego0PJbtVAys97GKnLYcotf6YJ1pz4/qPU4V3+9NIBXgzBotcRs2ixxbeTf?=
 =?us-ascii?Q?vShBiix5AMgj31a4dNcog9sChmUfMiacbNuHisEvuhm3TG/zK9r5c0uZgu4z?=
 =?us-ascii?Q?oJBZ19mCo4SV0mqhJQsJb2pHR56r9jns0zRlo7UhjjpPKlNpk7uMNKwf71QD?=
 =?us-ascii?Q?RDKyO9ZUFj23JugTWZdtf7lW9NSBVtflsk8pm5hplfYzwdYzOeFVKea93Pbz?=
 =?us-ascii?Q?FIsLkcHvNDtcpICUfLKPYFjzTGJ6NyAahczSqJYQ0UnkBofdsNoqkB8JlXHS?=
 =?us-ascii?Q?VvxZyNW1f6X02WCAJEuPShNPqEJdAwzBbkTDrD9PcRxag51to2nSTEOL0P58?=
 =?us-ascii?Q?VIMnqQshOQiWRGjT7060rbGUS7Uo8vz1uPHYQO5ks3sF8XlG3xk8KJsBDpTO?=
 =?us-ascii?Q?H//RELrxu4N2w4QI5bsOJxylwrykhBqnC1c8G+HZmYE4GJKEljKfVg8nAUUt?=
 =?us-ascii?Q?pXZ9CHGHfgfIR43vhSF/Gem99lZwX/wHURBNSVE/CHbI1TKaMbr2ZsD3L8yd?=
 =?us-ascii?Q?dmk8c2Wh1jE5GDF3UQATJ1sucYDIKjku0pX5WTvneEVEVjofcVQHAqH6bdWO?=
 =?us-ascii?Q?0YZ5BO9EtuoyvtZyq4ZfwhanLg/vzfhhtqXZi/CN78qeTO94Hmz3WhFE/euk?=
 =?us-ascii?Q?GKQvs40wjkpjAaHPi3r3Vvi0uyyJZ1ZxfmoV4mLM9SnQE+2921nq76XP9+Ix?=
 =?us-ascii?Q?V5+d3egu8oxvnK621O8OOX+sTj5ppem0my5Sfq3vimqSPksOD8S5014AOI07?=
 =?us-ascii?Q?ZD1zOW5QEeLwsnv1MYPLDlvYJ11QzXSwNZm6IDPvnxfHFIE7GLSpq9BG88SA?=
 =?us-ascii?Q?mHYNBdwav6aGkEoTJLoW8WMcVy9OM5pkgWa9kr+VM3wxkrsLDejja8n/MbBT?=
 =?us-ascii?Q?bsMrqKfR42H80uQ9jY9+sswmEJcqmemGrP6Gq1FYaxoiv4qwrIPSOLtXpqzG?=
 =?us-ascii?Q?0XovAXgTcK9SgKpImf75hqYQlvt+x0eLkpj7nFRXxQPQHU8vpfXNn5ljZyBv?=
 =?us-ascii?Q?r3h+f4GE+zWoH+EcHwzh0vKsJCErha3MacJO/vZN1AwId9CpKHqOEGg4G2Ck?=
 =?us-ascii?Q?h6+ZVgAMMIZUoNINb4zbMnFgzk+7O9Dc7Jcea1ZdxXAotsSoCQy2bFrYj1De?=
 =?us-ascii?Q?fMwxhxknA8dDVn6b04Hl240=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r5UlgGeEkDBz2uk5JNn2NSA+gzGQxlx35xxx5gMAkagnbvZ8e3a4kCgeyhFy?=
 =?us-ascii?Q?sZYhZKJdSNS48ko49vzDCp9IMG6QsnzEMeNdXgaIWofiLK9TVe/f1GuFq0js?=
 =?us-ascii?Q?lkozCgOaegol31hpAWcSLsCvhLzQBTpx5eL9sgrTlL72mlXr7Wp+Z7hepGXZ?=
 =?us-ascii?Q?9MFNCvZjiOPfa02aCHPcjOBLp4b14AdPOtABk9kXEzkYXEXonY18T95QaDmq?=
 =?us-ascii?Q?gmpdcidCCjjFwN+T/SqxQJv/jCsyNOb90XRoAEihvjx989KYNjWJni9CV+4r?=
 =?us-ascii?Q?vLjV4HCjMbF2APHie4CQooVqiaKZc/oUqvtISL9ZKbiK6YVz0TCzWnA5Y9bf?=
 =?us-ascii?Q?Z0o64udAXsMyBBDKN5AVeJfG750EZpsJ25jofRPl9bOI+YpWVxO2WDt9tiKh?=
 =?us-ascii?Q?3G0KQQlYOaHGiP9rzuGDOkHvlu22d6W0TQOnFWV10YTOJnQI4EehPzjx/S/T?=
 =?us-ascii?Q?vDtzxXewJYlMd11iMfcQTPYsHO+K7as717XWSGiMJm/nMMpBcxCwwEnmqyq2?=
 =?us-ascii?Q?Fdf+nilXd6MPPvQPDHXFjran8ZZt6LfItBtHOw5CK39I2jRZ1R9Aha3kf3Sv?=
 =?us-ascii?Q?Of31Qh72J3ve38NyJ9OldTobLL95MAqxKg9HJ1Mi9UmDcrsbStWH3lvTZtY/?=
 =?us-ascii?Q?UowbgYS+aERLeYqKem/iKbM7xqCoViM3P67jdUl2YHEtdertZPbSLaDcIfYc?=
 =?us-ascii?Q?bMdDYq7NdN5yGV3YDWPHvJK57BKPFBNj8eWN5MvzTrR+6Vyw791A7bb0d52p?=
 =?us-ascii?Q?VKhm8pZBbeKtFSExqDtBgxz6jfJLoILabtQngAVYpeoE4TXX28dVsOb54fEn?=
 =?us-ascii?Q?th0MZ4oixax1D2GG3ni/5yeksej0OzChDoGGHoeCyJpvZZpL9ZlHFTiG8wG0?=
 =?us-ascii?Q?Q0IHnqS6PJupSCvHl2y0uBPYHYLAbmaE+8+FVR/5KP/3psc5qwBT0JYBVRW4?=
 =?us-ascii?Q?inwfCTbHuKrizIWrpLXwZbWLloaKD77ntnGahBohrmWltL+nuajTkKs8u/Mb?=
 =?us-ascii?Q?bABZXVz0TPFEur/egapqyhOg/SqXH3PrBFAQifr8S21JVBxmPwTKhwWvuIon?=
 =?us-ascii?Q?6cxe245S/mVa+TKVVpuRugKL4e1W5/FMYptW6LVgK+HavjP5DSqFoCYe+48V?=
 =?us-ascii?Q?WCHBbKlmMvpwwY+YCgkpeb9JRIMv/FrkWLh5Wc6tyehht6HUE8pbRpswc3MO?=
 =?us-ascii?Q?wK76eVSV0TvBH3Lzl6nMtozdxg56lggYYuCVQHbX1/Ntf44IYe9ntDXy2hhp?=
 =?us-ascii?Q?4a0Q95pzL9IR3N0BLEl39jBPmOuOuGfljqAsA6u4QoM2w4gZtGbHIwR4WQjB?=
 =?us-ascii?Q?DhHLfKvV01BB6q9MHZZ9H7F9d1PxOqoaQ2n0kj1cGhEec+qshWHYfyWbEPw5?=
 =?us-ascii?Q?XF5cu0dgyg0R+6C2kzyDKSUD1FXJI0xW4cSbTCykTaWt1pP5rz1KctKkAKdl?=
 =?us-ascii?Q?Vm2ZCyoKi2/KUEur+4noruRl33L7NLQMs5S+TTI0JaVCUbUzZr5e/B+nq5j3?=
 =?us-ascii?Q?KgW6GSW7R7JODylEZ9QIFF0qo/yUPk7UP2wTbQWNW1IPoqoUZifwRCFBVR/y?=
 =?us-ascii?Q?QIEvD1CDTOeOlOJXkmuMtq/MueZ25WaRtamc9xHBNlpOr5Ls/0Thonvf2ZMj?=
 =?us-ascii?Q?823r6WXoVqC+7CH1uLcxPhwbJAw3S9JMURdrSnSRWwX3ZyoxYLddYpP7r/LR?=
 =?us-ascii?Q?l9QoCfCX0EVfDH1JIn5CwY2LrMwCCkLOiKP+LQxvsLahmVsg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb315e9-b4f8-4e64-5d5b-08de5d5066e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 03:01:43.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwndOPvL1GNIFZOI+DpXE5yp6aui3E++Q2P9lOzgqWpkm4l8cjCDcolON++FWjldYwUaKuMlLjZ9qfOT0ZWpyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,bootlin.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253666-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ACA58F56A
X-Rspamd-Action: no action

> > The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
> > dev") has created a device link between the MAC and the PHY if the MAC
> > uses a shared MDIO bus (The MDIO and the MAC are two separate devices).
>=20
> > Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
> > DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the solution
> > does not take into account the hot-swappable PHY devices (such as SFP).
> > so when the PHY device is unplugged, the MAC driver will automatically
> > be removed, which is not the expected behavior.
> >
> > Therefore, to solve this issue of the shared MDIO bus, we create the
> > device link between the MAC device and the MDIO device, rather than
> > between the MAC device and the PHY device. And when the shared MDIO bus
> > is removed, all MAC drivers that depend on it will also be removed.
>=20
> Shouldn't there be a full chain here? MAC->MDIO->PHY?

The PHY is already a child of the MDIO bus device, so the MDIO->PHY
relationship is already represented.

>=20
> For the case of the SFP, maybe it should be
>=20
> MAC->SFP Cage and I2C MDIO->PHY
>=20
> So if the PHY inside an SFP disappears, the I2C MDIO bus is
> removed. But there is no link upwards from that, so the SFP cage and
> the MAC are left alone?
>=20

Sorry, I have no experience with SPF module, but from Russell's reply,
it seems unlikely that the MDIO bus would be removed when removing
the PHY. I also modified Sarosh's patch based on this premise (the MDIO
bus will not be removed due to the removal of the PHY).


