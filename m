Return-Path: <netdev+bounces-280573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKJoGoiA6WmdbgIAu9opvQ
	(envelope-from <netdev+bounces-280573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:14:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91744C3AF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F34B3028C00
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8B3BB9F3;
	Thu, 23 Apr 2026 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FmNk2g6P"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0A3B47CD;
	Thu, 23 Apr 2026 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910467; cv=fail; b=WdgjJFIvcTr6aDYk6JlTZABT8e9po5d5f15rB3Hlcr2ivNKuXXSFggck0ChAvuGnw4SRTL3CT/023hPTtqmC0EplNt9peFQIPzFxtwKZG5UD834l0QXMVDcikm5NpNYu4r5kpONL5FY4eh2h/n6R1+wltLTCoUjBvSnoiPtlYc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910467; c=relaxed/simple;
	bh=jyXY/2yklL5eSqmSNqSNMf8kZ+aES5DqNxZBOgqwMJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eGJts3un3Knq830f9Td7lzDEVmeQQo9VD/Rp/5yXOuI91IsrIb3saEE/flkgloW4hF7vnAag69F5dfBJ530SOqQY5ySRLaoGuAFK9PiCaa243hn1Hx+91eYqMSOiMFWE1+zD6zBhfY0HXT8F/iPTDwE+tOpQwz7olu6/+bXZ00M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FmNk2g6P; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW+Qaxykt1+eA7S15Iy1n1GinbR+STCJvE/QTBkDgeoR7U9uzKDBdQTrWgq6F7e1v8zqq1AB5QUza6PUdaqsaKvYNRR6EfwVTE6VHQuC5SP983DDs0ncMZvZShg071SkRqhYbia37KXzQOA25bpzbUQMNCTKYTf2VGMbaBuMhqG5JjNbmNBHChhMRL9EzBmAS4/dczGM7DhCqeNosuA1Y8OEw67nuuAyUW0CwAfBAWWDoDwG72/429CgAdwQbxaj+vajT8KCSL3xPM91Ec82p7QqTdMYLcPxfqUcRj+uHzyhk29imow+HKnnlC0sZaooXCByJ4jvKpcwpHtm5CLd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyXY/2yklL5eSqmSNqSNMf8kZ+aES5DqNxZBOgqwMJQ=;
 b=DYhNzHOgL2dkHZkDrUD8WsAr9IE3kIY/OzwB0MagVaGq+J0nyj64q/fioUJWeBNx7NVJOuGurDIBDvBzIr/yaaBYvwbn2H/YpRg+MYPTieMKpRXOQH5XFkJv3KyqiGt5p5s0iKqK4ul6NW/2Uh6GKS3tLN4ktxgf5aGW2gPCycehRIB+ubjBSOTPEEinjxGCvL4T2bQXmIi+nUi5kzyqQ6T2n1zlPAXcFKWSgUNjRCNGeDxE6ESlyCL9vICGqQWnwzuC0b8dUCxpUSas9CMLbq71XKdCJtt7448Zf5nc2Qnv0p93Hi1qwKvi5T7JolDGDN8fhfZE/Z6OrzQpNkyFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyXY/2yklL5eSqmSNqSNMf8kZ+aES5DqNxZBOgqwMJQ=;
 b=FmNk2g6PfDK5XjfecDP5vo9llXuBGS123vXNeLrZIVU9S87dGhJEIowGB/9JXz7jerub1ckRNdbLG35V/wqWCncVq+dUt6l8xH88tahFPLxvb7NR26AZwapfhd+ede0IEQL2lX4ycnpsxOQ1alZjwqq+aWww5JSjscSo09ffIZCZBMT3oITDY7IG/MYndubFMllXJTJKKRhzlzeA202WUbzU1ETIjyberUti6iRCB+EKNAGi6fQVUg9R1wm0StSrtt7UQEScMiYzUzgSSCsgBlH/QdHHAWKtoz2yw8OlW26kj907fFgK+tVQaIMLN4fdrQqO3REc3veW6pBasxRJyw==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Thu, 23 Apr
 2026 02:14:23 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 02:14:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Fritscher
	<michael@fritscher.net>, Byron Stanoszek <gandalf@winds.org>, Daniel Palmer
	<daniel@0x0f.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH net v2 03/15] drivers: net: 3com: 3c574: Remove this
 driver
Thread-Topic: [PATCH net v2 03/15] drivers: net: 3com: 3c574: Remove this
 driver
Thread-Index: AQHc0oJQ8+3syQnMdk6jO3rMXEuuNbXr6FJw
Date: Thu, 23 Apr 2026 02:14:22 +0000
Message-ID:
 <AM8PR04MB7284CF79628FB99F7A7F20D5882A2@AM8PR04MB7284.eurprd04.prod.outlook.com>
References:
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-3-08a5b59784d5@lunn.ch>
In-Reply-To:
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-3-08a5b59784d5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|AM9PR04MB8539:EE_
x-ms-office365-filtering-correlation-id: 35bdbe61-1224-42c0-24aa-08dea0de093c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 dOmp3twg+gV8FNah6kLQZ2Y+X0P0QoUGSnjJGj2um9TrVTc1g+lXiGGR3/09lAnw1Q72oOBatVgGGNV3omldXF7hhLkqkt6rhuG8/E/7hi3FZd5U7GIX+9P1HiNnXpHkMl7AVIxpK8/+dy40Uo+clTvqsG7CWIr0ARKuYixMU27ab4fJNXbOvxXV93BuBR5aYSi33PmbviUkqc+u+GohmiUvDv7hC258DBGNf1KBG4Lbui+iTlewVPorVWpmFkCABH1Ybh/ks4kasJMdqpZwhyBF8v4ua5wAEgEpkIHFw18hMfmERFqX3MhEr5N7xO1P1Z5wW8Z3josrXYkxjttgxw5sey2AxGHztQuKJJ4VBS0m3c1NYKVeoMkIP3Q1ZFCq1fUM6rVdcHVQZzDqaPoUSkQmscPIg19Ws9mYPlD3SLOSVfDnmma59WEMjddKLLNO5Ud3Wnrd7vEU6zvVSXdajyXSj1oCPuZsvTYQ4fDOnKEQJCkZ3c+6mC5RgsPgn0GZr8FnTuFH7Cl3XVBCFDH9HpFzY2rXH/9tpMrJERjfTU8BEQ9rEIkB86BLA/dzcXZHwPfiBXmYpNaMzBytE4YSNTNpqcGboCyU8W3C8cMZsverUmL3R3Sfk4zs31k1gT8a+hXfazoOWDFdmj2ksfKklNJy37AefIvt9WqLYkO/kcFfhHHnCqHRXFxp9bJ47LmEdnvUFgB+6Ktu0uY6LMlnMvPYUgWXtsQtdGIcUQGqMDAP+a4BpDPlwcdt9gCrzHUO3+JOnXSHQmPw2I65kLNWUexnzjYdA/tdrpbReYWE0Jk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g5wMh5hkqgjIjD+p4CawLhv6FonBcmW3h9bcuUrm69eagZ0C18daX89egZF0?=
 =?us-ascii?Q?PYAB7d5SMOCsBgmhLNd01gU9L8zPhemQSRc0BnBNQSVAtLndxiS7uUrIwNHJ?=
 =?us-ascii?Q?dPJEKah2xy9Ebh5mK7E457vElIhF5EZtNZ+/3VkGghu3XXsSovsLhENHBMu/?=
 =?us-ascii?Q?8SWlErZ0iv5J0EnBPDSxD9pf2Ry9ljYuQDwjRuNQwqDkTRZqfDOR1TrErf2p?=
 =?us-ascii?Q?iTNOjQ+oqqdwIlLeK4tmepZOXj+Sv5TEhOQybtZsBcctg9JkcRI+XQNNKHri?=
 =?us-ascii?Q?giVoRWtSzHfAMuDQ0CQwcdTXzjg6GJzpFnnQnVL3glwXsNLX1t+IaF4bZXDL?=
 =?us-ascii?Q?bxNdtJ19XPLFDU9qW0p4Ms6Ln+xe0pPFOvLuee0KJIk+WwQQocFVFrLDFMkH?=
 =?us-ascii?Q?zfeIWX89rjBFQ6z5WdDIJRJPncOwesLiVzynTpzQXbuaVlpWFx0CqCDUsbNh?=
 =?us-ascii?Q?1f6oKuBuZBXx/QibjXJl10IvituUqI8RlFJlh43z2x2xJE3nat1k1okW0/WN?=
 =?us-ascii?Q?Y2U/WGU9NNEeN90KfFykQA8bvYq7tyXQ3GuxWbRNRYYbSt7L0vMYNu75YXbA?=
 =?us-ascii?Q?u50VQKJQbOhI/jCC72CXmTExz3HjSud5m2Dxpwr/5/VEX0MiJGG4nXTq10CW?=
 =?us-ascii?Q?z5VX09mn1kIxaJYNEyEeCZnp6Ac7zu7z7z0su37WpPTSQtbq7G+DCs7G5YCs?=
 =?us-ascii?Q?1Ag5VXKyNCz7TevebE0t7l5bz7m9M9RNybvqpM3q2uB26WJ1QU2EEN5cOyyL?=
 =?us-ascii?Q?CkE6osxm3ZiQ6wOMMSPh3hiDcmr1btWep1UOQDtuFt7eXKvBmhkSYCQ7/LWd?=
 =?us-ascii?Q?PThK3ZhbZ2hgSbf/SfmuxtIMcPWYbkbY98FD7ag19OmAQXQ6NUOomE/fmM8F?=
 =?us-ascii?Q?EoxtTu2MP9FFD7h/0kZadcNY86ehyeH3KQHNfXE7NFF/MQMy2CbF2BTc+VQ0?=
 =?us-ascii?Q?8WsrhhxCmLkzW22oE61wG0jw0J9dpYVnSKkOaQmoIL64mfHLBNbKn5O2rQqL?=
 =?us-ascii?Q?V23S3NqWtgigP6h+5VUtEBmBLuHqQCASTsgbB0kJ5+GwZwlzBRoRAeYIdbJl?=
 =?us-ascii?Q?QuVlAQ4ysISo7AWENPfjX2pzFmU3RBapKePpJvA3waeFpFFdEhJwGHbfU4ul?=
 =?us-ascii?Q?DxoCjLdcELMZRGx/Fs5rr9LkBpb3///h7N99bAXGVLjvDbKJpwTbg1qnhl02?=
 =?us-ascii?Q?Hu2VhAs4jqyWb/mMGLRWBLTBBEulhYN4KGatSAnKb8sGQ7EfZ+dfn3GJcgqj?=
 =?us-ascii?Q?FTTYiRkrzmneGmtXCX5w9z7wD65bxYZZtqQ7NTpR8MjoXcVoB4nkUwhhhWvX?=
 =?us-ascii?Q?8TEE35ui/3IfdZJoaypRhaSB9ki+X/Vf/d6C1hfjwG3HKMxrDjZ2v5EaPfel?=
 =?us-ascii?Q?KfECz9ds7eRbynfy4e727Dyh0yZFbHILGRb7bw5xdXc3Ot+CS0wpxwrQ8Apl?=
 =?us-ascii?Q?mnTiHUg6c8EzKuO2gYiLKEpmVT/yLZvIrLaFowPOI0GjRSoAuAYVKbyrhqaT?=
 =?us-ascii?Q?Xt+PvxjJ354+qhsBVmDIId/NqKRi9M0XpfOqqlxxQXZ/MgHG7K5ccDCrRQsx?=
 =?us-ascii?Q?o9N4WSJupAo6eo6U5PRApLJ6Ey2VyylH7T+QQwzhd39qyugd/215PwiuhArv?=
 =?us-ascii?Q?iIFc/yteeUlrqx4RlWxo5k5DdEArquLo5cGqgcI4AJPjIiO6O0LWSpmEHY5L?=
 =?us-ascii?Q?HxEAEk18YvzsFrnuU/+04gpzy4XKkHPlDbhx20kmOJti0s1q?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bdbe61-1224-42c0-24aa-08dea0de093c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 02:14:23.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r965QZzL7xBi1dBHvclfZAQgjlsemampzFJMXjb5tCStXK363A6C2MwF7W6R93CPfQFF4x0FigPC9pjbM6f9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280573-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,AM8PR04MB7284.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 2E91744C3AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The 3c574 was written by Donald Becker between 19973-1998. It is an

Nit: 19973 --> 1993

> PCMCIA device, so unlikely to be used with modern kernels.
>=20


