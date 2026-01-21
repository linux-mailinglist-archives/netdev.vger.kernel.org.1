Return-Path: <netdev+bounces-251695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BIuOusycGkSXAAAu9opvQ
	(envelope-from <netdev+bounces-251695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F94F6E3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30087B68E53
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE3205E26;
	Wed, 21 Jan 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PKh77YLD"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01F2C08D1
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960671; cv=fail; b=I8uyQZiAuTMDB0BOS8Ar5fdy7E1b6AjBXjFGAiXwa5b2BCyD5BnFmv3JvBaHxGyL46x2vLoQ6f2Y57plwUyf2j3EvmPfxZ7iu3k7iXjfeTMOiArUBX4vSg/CBalQI78vLm2zEYAFujtk/C95pnuowea9OZ4o7Sm6MA4YDlopHSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960671; c=relaxed/simple;
	bh=hX8PQCuGfblHVA5KWlQnhDl3tV7oyqZ3JFx4o2F1hf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6B7KOS63yLk6AM/dF+acF4T7lUQWKFgogAKCbwXB5hoJjxIQ6Yyr8dmbTLrTxToc6f9GFdny4OXTaquISw/g63/1RJVqAgH1aKuDjBupnmWVV4biDhR725Z4Um9kEwseRNR5Lh1tHycRLGdTybf1lg1DYT7l1qpCh1WUlg1rU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PKh77YLD; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekaqTrjXnVizMR3PhQ9MFHkM65aRw4ci7/vSXxDHEOUJPJQYaXhSyk5/ykas39KJ5vy91UIya9dwENdy3DScXhlUIuAFT34XKEuWBePg9Of9EYZxqAR6JOSH/jwQoRHPE2vp1hNKaAGitdaLlgsQWoJOVoxBbiJx6VPiQ/jk/yZfu0mK4R2rY1GZixLOCEMOYn3QkV5iX7yj5FPcr2Ko2wlt6TQWvbMBFPG1K+soam709Rt9EHgZI3GVncAloniXuobWBpQaI6XmQ/NOmW/+v9e7nuCdKPvhgOEfvY//7njB53fzeQmjNtWh4W8BZ3vVrJLY71EOw6xFfTWdfm+M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiFZFu3hKt66JR4IUtYnMwYKrO/wrr9vy+FllSj4RSg=;
 b=tw9OxU2OZNAP9fGpCv8+34OXe2xdclXPUaSDHWOlVoh20dsqigykBbEwiMNdu6P9tjcsdSCQZ1nPMH+T8rCgp1YK1sK9tnHtfvmQo5OGpuNMI2ELOs4jMEqOzo9VncKYnBC8lpl5pwaZ+zmqahQlzdMfcjCbO1oGypviQStd8zZFloqcRo6Zb7UnJ265glgG3oOEGUmE5rY8ugawbxE1AaXI6kQqaxTNy1EbZH7mrKEn1cB87XS9lTr4pKkCPXsYRjmIyrm2BrkK+68UyqNmxecFs5T4MJkI2lz5K5z+6r3MK9b8rxpw2nulZcbjfm0WAPqLq+AK4FuAg7iiBGylug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiFZFu3hKt66JR4IUtYnMwYKrO/wrr9vy+FllSj4RSg=;
 b=PKh77YLDJCOxUsN9u8MEwT4NFQlUDCbqdeAlm2jrld+S6h+lyeE9JUyIoKzlRA2kKb+JW0nSTAK9I2/PYlrp316KM1ehfnpT107SWTMTSEmaKuN0TK450bDPtapxOpicZPE2w7mr6e/Pf6oAaLb61MNgurrzMYUrljv82luFH8BWyAw1KMIQR2SScV5JIqVkd1ZdnVyKEyYH3m9oyHWnioxckLLM+jm/FhqWTOo8GDUB0G0pAi0pw3RVx0BrkZk/uAjScJNQoa6+OcDghzwl8aMjj+fGT5mIwDvNZBDgTiDUfO/Q2ztLyHfE9ogFtXYVmEWPMQNmnbeFTRkzF2jvZg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 01:57:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 01:57:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Clemens Gruber <mail@clemensgruber.at>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@kernel.org"
	<stable@kernel.org>
Subject: RE: [PATCH] net: fec: account for VLAN header in MAX_FL calculation
Thread-Topic: [PATCH] net: fec: account for VLAN header in MAX_FL calculation
Thread-Index: AQHciiZ7qTF3p/vWgEGfopUeHFZUmLVb2siQ
Date: Wed, 21 Jan 2026 01:57:38 +0000
Message-ID:
 <PAXPR04MB851064BB30B2D5A39AE49CCE8896A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260120160407.101273-1-mail@clemensgruber.at>
In-Reply-To: <20260120160407.101273-1-mail@clemensgruber.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8619:EE_
x-ms-office365-filtering-correlation-id: 0554775b-fc28-44a1-0ea7-08de58907490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kNv3UvofbdAbc2qcY77gHLsq9kyL6kNudB3Mo/UCekqR8MsjgSZp95Q+kauL?=
 =?us-ascii?Q?wy3nQ8gyRbxzNBJa1JSha0uJi375e4BI+oEki8JJ3Dbtcinca1LxLky/r7sk?=
 =?us-ascii?Q?ZGUpWHQqdUi/Hx6E1Q4JXHxWXBTRSI5Pp2WFY9mCEflT+MPEng/tHZD4fU3g?=
 =?us-ascii?Q?fNux4za2SZpMNif9KbO02PIlDn3h5pllxST/tsnN51uH7BeXiB7XpUnYKJdp?=
 =?us-ascii?Q?LiITO73+8U2FHECNTF5NdCya0Cquk4JTvPWHawJ2pGcQbHa0Qh/AI++zmPgz?=
 =?us-ascii?Q?lEWziRfRDY4XIpi79Z6WrGJKUl2FIIosqc2uNELSah3pdwQVYwM6nH5AM8xU?=
 =?us-ascii?Q?A6MZyff3C2mA/g8qd4fzWo3KVhLHeISipYKtjf/2kKt09SKMuIPYc9efJJMg?=
 =?us-ascii?Q?RVg9b3OOV6DV231udzAiwRQ1c8+UYPe2ydD+7V8aBM2Enp2CBDnIXRqZ1VRs?=
 =?us-ascii?Q?mu6ahF3WqJlzyrKduC5UMP3G4y7Guf8Vb9YIYlD8pKSB4V58xJMfI9SDw5ld?=
 =?us-ascii?Q?Twu+I1cip0wnS/8bAxBR2nyQa9TNfAm7C3ksuynKSWrp9i+1HDVeGnwANLOB?=
 =?us-ascii?Q?qITCYTVJ67gcX2Z2LV0kxBM2DXEJE8d1eF2sW9v124AZaTlFl8EBHiYTy3Ic?=
 =?us-ascii?Q?9CnOLSWzzugybBxdviNsZFCotHsHZ7HzXmgt/CvLglk3vnQKKI02zH+0aFXA?=
 =?us-ascii?Q?hSfnHaFA6Dc6PM/bXpzBEAaSYe066XCHmcF8YhjWv75q5EuSGS6Pf5Qvq8wd?=
 =?us-ascii?Q?v/N9/btBlYU+iBRvZerE/7KuPBu7oVy6Dpz5nca4gZU+2rqUWCdjtlDAwTqx?=
 =?us-ascii?Q?PB3Yft4QvnYnRBSx2gxf/EdeNXfLqh/CUywyuJ81sUmHITpno+ilpa1VW5oY?=
 =?us-ascii?Q?kPsy31Chq+i9/ZyGeVI//RoNCWGgfttqlIzyaiAysAY5oHuQpl2gc3rmlxCl?=
 =?us-ascii?Q?yvtax6jp1lTAm6m2qstCSl4NFzmGH4SshZh5+m/x+TL8bJMXd8myJRSWqIqg?=
 =?us-ascii?Q?RLiIjU15uWTiRdZ7ylVoVWi/RQmhJ5fQQ5VSrj4xbYzZj8J8X4V2hLXWBO1e?=
 =?us-ascii?Q?jqjbEkVSu/na57j+p7zsB91qNgDBp0jB4zw1P93HwhreQMeuw/FRvvKCjz3v?=
 =?us-ascii?Q?1M5xk2SLSQY4zt/olSCyzcBEROUEZTPLyz4Glllbyltrsf5DvbqBSPp06bmm?=
 =?us-ascii?Q?/xAHHIIletObcj8pKaremF0c5ZBtGFDw8rU6mlz1h12OBehSOaRYcnyb6WXa?=
 =?us-ascii?Q?PS+26L/mOGybVPGLwu/k5KV8gJJxFc2gv9A1vaqkgXmi2pXJiuCaoPJZcb7K?=
 =?us-ascii?Q?F1aFM/QCiErEB3MCReKjCHZCfMJKwRKrub+l+Z/J/E5ePVKQiY0GFAn5wpVd?=
 =?us-ascii?Q?uFUKj9wm95vtDgi07lDSOTUAkK90FjCW9eORtkSe2mfoUW0A/681OK02iQ7S?=
 =?us-ascii?Q?B0t7CcgGBVTTCB60gXb2Z/qi6qo85kcF2NP5Yn09sD+8ouEGMwYcPIaV+ASw?=
 =?us-ascii?Q?/1MV8yQXoPrI5UvEk6Mg0yg1c5DAcNX//+C17HYHzvy76v6NU+neSltg6MGA?=
 =?us-ascii?Q?vVrGScMQNgZpNRkKCDd7QjDOjt9vbGRfGI9f0CZzk1HdkHD9/qwmNQXSd7+T?=
 =?us-ascii?Q?m7ge1p6byae4FG6KywdgzCw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bB7YI+rTOo34SAzvO0inRATYtJ8HJfBAe9T6o3T1tbM/g5cudi9tE+Qq34f3?=
 =?us-ascii?Q?Kfcf9eueV5Bk0jOZ0W7j4I07t7lZMWrQzYC436Oqr0OokfIIukDUdl3o49nv?=
 =?us-ascii?Q?i+hNP1liLMZZ2q5tGEvuvBb4ZmrV75N1B0h7DTTjW0eg9Cn4ELJL/lxanTXH?=
 =?us-ascii?Q?FCiHiSnul2ObdjQV2D+o/qRuPLLtyqeAxjWtA9/NyZHoLwOy1v5U6m67L7tH?=
 =?us-ascii?Q?fN8uQjXP+Sf+YLDHBWIIX0rsSYNRbhbAPr+T+qoTDksMZ8CynqqrMvOzYbcn?=
 =?us-ascii?Q?KmTo8Jdc8LW2rUPXt6HyIWVYwgdLvFncJo+KoVSSDZTf7da8YJ3pssitQJlp?=
 =?us-ascii?Q?4lbYQZqdhX7W8Ndea04duIIXfxvAGz+FyyRsWg+/pN7KMSTFlpTNSYBjCaOU?=
 =?us-ascii?Q?yNmAQzkgwIGQ+KkwOmWKy1ggu3uB0UzcUJPrTydJa+M+Ryfgh4Kp9a39d+5A?=
 =?us-ascii?Q?wBAjpWHw+DGbI/+Stv+kMF/+3aeokD+MDG0HNgvK2jN46asWmFZ5cFYJXibx?=
 =?us-ascii?Q?zQcUW+Mckxb3QFcOFhoqoyZW++kwuQwD5u/Zh7Xf5FxuYOcx+setP7/EyX5f?=
 =?us-ascii?Q?OkyZ+l1p5DEpjkGa/JpZYYa8rbxf9j9Mrak+yb3+c30/1wTTAM3k1wsUzGok?=
 =?us-ascii?Q?Tkd9QzyM9UnrVhPEOE4WwHyOQzChrTL1DyjCwNzoHow82mXOWHfcClkA0eGz?=
 =?us-ascii?Q?1ffN9B1/jOsIG2zDVIRnfPAmkMq3TMbeweFdHgMJ2kmflHe36DH2EPfJAOAf?=
 =?us-ascii?Q?ROOW3fhzxKXYORVZm+0FBF07uA0rzXDI5fuNFvZKxOSE7Sc+iteFeFU4IApr?=
 =?us-ascii?Q?cxME0WpYsnuCWmfAJnPchWV8LvIha3mnYghBlG6EUatT7YQcaro+nyitYuWH?=
 =?us-ascii?Q?bdyuC7IsKsAc6sAtF3b8k48klwKHEVoXgMVEnCQuyvOyvw4/XfKKDbG/PBUU?=
 =?us-ascii?Q?9H//bMjqEU6QwjamhjPsL8ACUL1HQK2odCPMnSRlIZvh8QDmXN7U5yDw6EU8?=
 =?us-ascii?Q?6i6omC0FZfcKjdNwN8aqRBAR+2l/Okx6ugRdUImqLk6fQi0Wa32kQrYBFnHB?=
 =?us-ascii?Q?kDzPFRkkj/uth0muw0xveyIsYNWprd4GHFSKT/G+yvYnzagcA1mk7pOSqPC6?=
 =?us-ascii?Q?pNi8OZFUJkvh6TpI6xo1zeQ/ag3I4cRgerKflkgl4JctjlzV6ijHlKuzG1FY?=
 =?us-ascii?Q?C+KPwHWyHO80sYtol9fN4nqz2oKcLu/fjQNNb2Mi4Vc01CLOc5tqCYiZ0jze?=
 =?us-ascii?Q?nxmbNWs+GKpvkHbaiOljSg8EAYmZv9RkAMakaUKh5ses6tCFXMiTHLrsr+se?=
 =?us-ascii?Q?Lb5ZcsG2xGtAn70a7kl+uhlxoQb9o8iiri9APvRtWf1VBEGG3n1/rRHW7e53?=
 =?us-ascii?Q?carK6ggrLtKVnYeNPxagPm8qb5OACswaFlS5ghOKeYDV3Bk0LVi1wX2SsD1Q?=
 =?us-ascii?Q?k++TlcLMhKp40w6ee5DJEZxGphCeC/7/NgmXWLIABLqv431knEV1eD6SNZEO?=
 =?us-ascii?Q?zlHSNX2LYIcQQtjMKBbrERjhLDOiVn+m4mcg4ks3507gN/E33SBBaFbLWsYo?=
 =?us-ascii?Q?M9FsBr1m3lfcicIvuf8XHH6Ru8C/BCrjH6KDbheAIpdbyzLTRIXg8zKfDd3Q?=
 =?us-ascii?Q?XlSdlq2vh7DAH3oFBRIsj4wjdSV+JROjYKPAabROLhIt1pSSR4uGBHkY/o/I?=
 =?us-ascii?Q?bfMwhQ0AOVj1Gks03jhQpGwEMNRnXGOme/nMK5kg396ML9Tz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0554775b-fc28-44a1-0ea7-08de58907490
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 01:57:38.6908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WO9/Z8cGd4IZ2F/9NaY+AFAhkpqp0rM+8a8Ii6CB4YJ0qQSh+YFEZR2DyofMUAtO1tc6y3V4p+cB0qHochoLvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8619
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nxp.com:dkim,clemensgruber.at:email,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 5D9F94F6E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Commit 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")
> changed the MAX_FL (maximum frame length) calculation without accounting
> for VLAN-tagged frames, leading to RX errors / dropped frames.
>=20
> Add VLAN_HLEN to the MAX_FL calculation.
>=20
> Fixes: 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")
>=20
> Signed-off-by: Clemens Gruber <mail@clemensgruber.at>
> Cc: stable@kernel.org
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index e2b75d1970ae..f8f88c592323 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1151,7 +1151,7 @@ fec_restart(struct net_device *ndev)
>         u32 rcntl =3D FEC_RCR_MII;
>=20
>         if (OPT_ARCH_HAS_MAX_FL)
> -               rcntl |=3D (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) <<
> 16;
> +               rcntl |=3D (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN +
> VLAN_HLEN) << 16;

The line is more than 80 characters after the change, so you can use
VLAN_ETH_HLEN instead of (ETH_HLEN + VLAN_HLEN).

Additionally, I believe the code in other places also needs to be modified
accordingly. See below.

fec_restart():
if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
  (ndev->mtu > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)))
		writel(0xF, fep->hwp + FEC_X_WMRK);

fec_change_mtu():
order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN
			  + FEC_DRV_RESERVE_SPACE);

fec_probe():
ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;


