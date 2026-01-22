Return-Path: <netdev+bounces-252221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GXeLsO+cWkmLwAAu9opvQ
	(envelope-from <netdev+bounces-252221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:08:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD3622D2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51C2438784E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F0313524;
	Thu, 22 Jan 2026 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JHaP4CDS"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031147278E
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062055; cv=fail; b=W4xYzst/mi9SMbgCOWY8EJb5uuGXf/nEwzsa+wlB+DHRqbzLEP4eOfO/YGG0px1+h9AsF+IiKR4BSba4pdQvuRGMX5kaHiNUCQbaZnsJ+IoRQeeeXO4kANi8IPtBfWBgS0p/b87IBRx4c1kZxrP4mEo8EQHS5/e9eqp6qaw9LoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062055; c=relaxed/simple;
	bh=bK9FwRX8BCkUVQ+hTW81Z5khoHW/JUBu3szimLheByw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=enwRii2RSo6t1mdlVTitrkiXPeDqIWaA5lhjPWqedtwqFHQCAeCl4yEIG28gYQ+3+5vmy7NllkgOlnoIx2nCbB8nPGgPeRymvc4F6wIch7tRe621vme8CRSxii1LMzoX7S94RbM9/y6BsG2oSsckMbHwfJUs66jMg7h0BeLsLgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JHaP4CDS; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCl0FKK5c2CcrWOEh2RmITU76+RhDZ8KVixKO18F637K+tqxax7rzoFaQ8kZ5t6pqqDHRU56/tc9wyy9kXxTqh5BevgfvUpm+eDMAEA7r4EA72eh6RBK8mEZOeYnjmeNrYQf9CqUIQsYHgOOL4O4m2cSS2+o1f0Mc5IpjZP/8t6J/zmezrYzkh2gKE6YyuwoMFWEmmcyVZONjdz+8gV+dUmc/Ce80Obov8e+xQnbW9tIZxwE9m842RhKqFr8cDdjsHrtWng52MxwYjAQ079KyyjAGjDTQR60gge7w8QaeIG8Gn2XUcWNDja/b+I/ls8WKxKZu2QNsi0nTa1YNZfgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bK9FwRX8BCkUVQ+hTW81Z5khoHW/JUBu3szimLheByw=;
 b=nZbZmMwJpz5JlteCPgmZgZGpOgvF1QKtDm+AgbC2AUsP3affXcdIUByXubQwsXFHC6fDMMEDPpA7+cP2V9oL60xXAPtib8avc9ITH1ba/d+H5/BTudwyK+cH4pYsXmWU0DwxXD0cey+le04PiYV0qwUyqs6spJR547a4C+COxVoUAcknne05ekGqGAbUkH7cybdi0Rk6nJUh8/VgZYJcdbIRCpj3s+4OtOrYuKu7dBnjrFGdZgEB8eybPIHoEuRfDcyLTETJU5fNJiH7dSAfsBprUUUNCzA3VF3bSIGRDFKF6SzrkK+m7RgDy2jt9qhnplLcL7d1uy0g79oAEOrohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bK9FwRX8BCkUVQ+hTW81Z5khoHW/JUBu3szimLheByw=;
 b=JHaP4CDS0NkKtzF0ASHSBwsqyrlLrqAKpK4x6cr5sf2wjljbzlcLwopM1+HwY0kiiIPSDgDGfZxNFMmVzib13vHpZ84j7kBJmta2XyonU9O9erRWZu+Z6NReBNU2CJUfLEz1jpEXEwh4JsnA7dZzBUprYJoHgtj+WcB6p96+gvniPxOQcfS+w81vh6Wj2bMioDfqKJgDg4QqqFqbCPzAJRdfIpiFAeRAa9BrDRFkDP5FcN+siqGJfv2lvHVGH5ghi5XKcuohwNv9Z1eE9+yzDbpI4U7JceV8f4a/zXSISH32CdBTc66O9elgZlKhhFk528uJL0znH6IsNlasP/oyPQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 06:07:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Thu, 22 Jan 2026
 06:07:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Clemens Gruber <mail@clemensgruber.at>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@kernel.org" <stable@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH v2] net: fec: account for VLAN header in frame length
 calculations
Thread-Topic: [PATCH v2] net: fec: account for VLAN header in frame length
 calculations
Thread-Index: AQHcirFlimMo1iYLPE26IbVnahikpbVdtRIQ
Date: Thu, 22 Jan 2026 06:07:27 +0000
Message-ID:
 <PAXPR04MB851065772CADABDB29F70BD88897A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260120160407.101273-1-mail@clemensgruber.at>
 <20260121083751.66997-1-mail@clemensgruber.at>
In-Reply-To: <20260121083751.66997-1-mail@clemensgruber.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8677:EE_
x-ms-office365-filtering-correlation-id: 244e089e-5fc9-49f0-e742-08de597c853d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OBI/tnXw+IHIhbZNx33fjkvurrqFByX+fj/C7CXXsS1yPfLS3OFe5OSr+17V?=
 =?us-ascii?Q?i4ijfB+rbLOZdbByPx1DsNjFG717a7k54RsHI4mxb8uygNHXaBUapEnIS5gl?=
 =?us-ascii?Q?P39BgmVwXddRJnJcgDvDrXBuP6OLmBQxtXjxtOYpWLI8Kun3MBTAAIc8bCmv?=
 =?us-ascii?Q?HBxwA43AjWPgdzt4XRLNLe+6LcLJUj/nVeXnqlfG5fV3XH37IZCoWOilkkXE?=
 =?us-ascii?Q?Koxk71SO92Hb+4sed+10RgVnoSzR3jF6H1o6dFhuyxUaJBQUMqtGFYOt7w4T?=
 =?us-ascii?Q?eMomsi7HRB8VEwoLoHEUKPUGxS8mNRv2mg+Wbycv4CpWqu6HuTZqpLESj1zI?=
 =?us-ascii?Q?K0zSzoKumhnnVJfmwfb2h1FFr2LAsLX6I27oZmBifw9e9yaLepqSfTDnU6pB?=
 =?us-ascii?Q?5fn4zYNiVsDmLFxGoSpBLllJQ2C5m8MoTJCipyYcYq8HIPBQivgxaVhCmDaJ?=
 =?us-ascii?Q?HyGn8l0c1z2IOd4iTm0VSOh+duFWnZse3DbmkkDsJRaUwpRwPyznKRxHTDmS?=
 =?us-ascii?Q?LTwMUOx9XQPPEByZIw+tNqHGXptq83X5/upzDc0FH62Hc9bv9szU7gc8MkPJ?=
 =?us-ascii?Q?m/haLi5p8Of0SxXX1qxfT4ExewgZtddVxrvTeVTV3yFV/Y9TnJ75li1tD2L6?=
 =?us-ascii?Q?n7w5SZXCBoeEiwPUeU9v3Hxn0KV24CaJ60BuW/N9/x++HzAr0Aew+RsGq9jy?=
 =?us-ascii?Q?/W66iUfKYadoBZsC7eteYBvPF/MkP33J3YKZ5G7awmHTqO2LTOBownnkxXak?=
 =?us-ascii?Q?nPXY2UI4KZAMQXk50qSFsHJ9IytvDaxWScd3WQ6MM22cQ47WY3JDQnnNlFLt?=
 =?us-ascii?Q?9eG91E6gNV+aaEohrzn6O5nGtYpd+kVehlnECQxDdevahw+CJk0L/QWjp3ih?=
 =?us-ascii?Q?ebuaDR0DhBiD0ivTI7dp7qVeO9oOD584BxKsgxMkU0onGYLgj0gMTCdkzbel?=
 =?us-ascii?Q?mvVuHb8fHb7hwvckz4IJSKYjE6RG/Xzy8VYCIiFHSrvXhDwJ3qf2AHVyZA0f?=
 =?us-ascii?Q?RWX45r+60VWVdPwM7tedW1V6hVeFijxxXs0/+ZZG9xHwEs6PfUJvK3d9x4Qy?=
 =?us-ascii?Q?P5+dZZHxen7h6RDJkG7q/JKDfm/o2KjWrghJim7le/bNdBBNfdg2adcCUkIC?=
 =?us-ascii?Q?euxRFSNYBP5qcP22PbpXAjqti3fCQkVaqv299AUOXK4g8gZbHDdar+y5EzdU?=
 =?us-ascii?Q?mT343vYa04Qh05RURtdecCHFt7oK9gbkPqMcAoGDIW9NjaMP4m1SRjlI0VYo?=
 =?us-ascii?Q?oOGKLVK/r6RJAso3mTpme9cPp+LvBodQjwzMU2tvQY4OLTlUVv6+zJL57XKP?=
 =?us-ascii?Q?fB+bFrrS0101fhTTDTUZzakklCZiqb9ZNRV7VU4VszqbxjCLGkto7ZEfXqDW?=
 =?us-ascii?Q?g22dRkpudOFMhmODov4BJ0FvIs5aqBhWR1pFtI9sK5QmC0lHfkT4GauV50Yk?=
 =?us-ascii?Q?d9x0dyqyueoygQDGKvGAfTeCknyBFD6448gkqx0sL4gH0IkG+pjIbOAxbPVK?=
 =?us-ascii?Q?dKdSbFj9xqZs6U++wxaDknAWgrL/JekJJuyP12wbLa4IJBY3pk79kafaIHxE?=
 =?us-ascii?Q?VH0pEXKj2zxMTntxr7MQJmxod1t5JhxwBs1w3sYSDdk4bYr738Tn/b4LrLDt?=
 =?us-ascii?Q?sQnEX7Vubx7dfxVa7Kk1tUs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wqNY0lIR+iixp83GxqYiF8AhlKI9dt8uoVadNXvTQqanVuKahoMwoXJAzV5s?=
 =?us-ascii?Q?SDwQJ/j9RPflx9NHNpSmttR9MnkalBxW/I35f/gESOXKyd2uwOeSt7K/2s9d?=
 =?us-ascii?Q?kWftrB5Cld3pWZVt6H4131+eM5/0Nm0PYpEnH6DeYFn8awGOIeop+UbwD/zB?=
 =?us-ascii?Q?q8KJujy1K5jGE/yK/LyjvkprBD/IU2iZrs0qGemt7Dv2s/1+tQN//zOO4p8Z?=
 =?us-ascii?Q?0Gqt/qnmmqnsf3lNn+Vai/nB4W3CzG3takl5Y+ofmmpKXsNQj2e997hAUa3e?=
 =?us-ascii?Q?0hnx1ZX/3bsGQDQZY30xUnyWLMETNxldjrubuHpJFB1twZ2HtQC8K6go41/E?=
 =?us-ascii?Q?B7ESEKykBdp9g3ASugmQ2JLEqQ8GxKUE7D6ssODYF8lFlstWoqhuuZYvHyRV?=
 =?us-ascii?Q?33EA0Mwr09hyejr1kMFuTJMqG535NNUhc2RMdxNmElDdyXfWdAVb03d7qCbC?=
 =?us-ascii?Q?c5ndyg8jxPw2rIqacp5wk5yfBxFjsrclKyKS8ZDGIJ2d/snN9wil6dWjLMTA?=
 =?us-ascii?Q?WvsjVi6a1GLPPQrQtNCXkppukxlZuI4NH0YixRplifIXi2mJ3xmQmeEF68aL?=
 =?us-ascii?Q?3AgvAubgPwuJMpNhgSFT1STEuM2a4BUqNsQIETDETHsH2PoOcK0qx3ENyOvp?=
 =?us-ascii?Q?V7EMyWgA07MkHpBOUfmgQ4C3tLgAXsBeIco3KxBp7Ephiq3UuVX5xdz5eB6D?=
 =?us-ascii?Q?X58sGf4dMHK+bb9D3k87Gim3ulgPYfuyDDkNTy1XAHQx4S82HhRDUj2KEBVY?=
 =?us-ascii?Q?tHYP2ekDyazwjYBhyyQNucIsDDD6p+DinxfGOenbGBCh3E1htk30JwQCWc6B?=
 =?us-ascii?Q?XQx3WlECpbZwAVZRJxiirzYPfF1CHoimTS0489D/zyp66Hug0vAFARqsjHz7?=
 =?us-ascii?Q?T46RpVUSdHbcyilg0w0npMwjUS/sII31ZBndcj30RTby4ut+jZODhaQC8eRU?=
 =?us-ascii?Q?JasbwePWYNELAQdxN/zqzbg/mCgloC9juHGFAQuacxGAlBcfPuZWtYZn/EHL?=
 =?us-ascii?Q?GbFMfjMLqy12RD8CUwuFZHVbrxiuqJjPgAjCJIXv6ECLuiFRWuYIdI8J28Be?=
 =?us-ascii?Q?rJ4hpaqOhTCRWGv4nVLpnWC287nDEP4Emi9U5q5ghLMk7RKE47sq6qe2O+/q?=
 =?us-ascii?Q?LaTBXGVdMkn8UdixH5uIHJIp/CBlIAm8i12Yl7s1M8VMMM5OSfBQ+CsGZWsp?=
 =?us-ascii?Q?pEahKEaicYwZAnZfgWUIafpY77JGftdsGWZAuPcErAeF8rvRsYHB5dss408P?=
 =?us-ascii?Q?uoi4fov1pWsq507SEJDJXbrcGjykCDT6yGiEck8vWT9gW6AfGSQd9tVU+TYR?=
 =?us-ascii?Q?oIBvarogR1wrSvTfBIxASUUGnvAolYUlG4OYQHpOhZA82Yucfq6qA++PAxX5?=
 =?us-ascii?Q?pZOgWx5Q9pyp6N492D5yonLg8jq+Gebp2BjgfvTD9t3+JxtQ08ddVHjRGQys?=
 =?us-ascii?Q?r9DwatTN6mu1KdSqfamrjMTU6TTts6/gZ3PnTJ8tAW+G/Ngnkqb3hG8iU+G4?=
 =?us-ascii?Q?QaZKcVfTbO/wQ8tSlg5imhQ7GOfEEtI4RCN9JT6dLbbMsaIcOf/DRTIfC0PD?=
 =?us-ascii?Q?3dfHzolnnJH7lO0+PDVeJoMRJIOlSS4JajlZD0dMFNa/k63ogjbNOfTLpT4Y?=
 =?us-ascii?Q?htT8eIwSFy9Piz6o7kg72Hw9Wt2mg1JlvpBVg56YFAgP7sJYYDAz68rF2ave?=
 =?us-ascii?Q?B1Cpy2Y9BfJz9/QW1qbdCio95DPV4nl5cQRcBQykZuoC/BUs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 244e089e-5fc9-49f0-e742-08de597c853d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 06:07:27.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1fJLn18Pg8a0eWds3qi3bSCiVtdDJaNNmRkZne4mrrqToQDSJjTma/1YsLhposGZH7yv/R9AOE5rMblUHU5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8677
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	TAGGED_FROM(0.00)[bounces-252221-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 60CD3622D2
X-Rspamd-Action: no action

> The MAX_FL (maximum frame length) and related calculations used
> ETH_HLEN,
> which does not account for the 4-byte VLAN tag in tagged frames. This
> caused the hardware to reject valid VLAN frames as oversized, resulting
> in RX errors and dropped packets.
>=20
> Use VLAN_ETH_HLEN instead of ETH_HLEN in the MAX_FL register setup,
> cut-through mode threshold, buffer allocation, and max_mtu calculation.
>=20
> Cc: stable@kernel.org # v6.18+
> Fixes: 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")
> Fixes: d466c16026e9 ("net: fec: enable the Jumbo frame support for
> i.MX8QM")
> Fixes: 59e9bf037d75 ("net: fec: add change_mtu to support dynamic buffer
> allocation")
> Fixes: ec2a1681ed4f ("net: fec: use a member variable for maximum buffer
> size")
> Signed-off-by: Clemens Gruber <mail@clemensgruber.at>
> ---
> Changes in v2:
> - Fix the other frame length calculations too
> - Improved title and commit message
>=20
> One line in fec_restart (after the FEC_QUIRK_JUMBO_FRAME check) has now
> 82 characters but I think folding it would make it less readable.
> Let me know if this should be changed.
> ---

Thanks, this patch looks good to me.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


