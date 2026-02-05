Return-Path: <netdev+bounces-256979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKUbGP8yhGkw0wMAu9opvQ
	(envelope-from <netdev+bounces-256979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:04:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9FEEDE3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35CDF300B580
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAD3346AB;
	Thu,  5 Feb 2026 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q1LZb0uQ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F806332EC5;
	Thu,  5 Feb 2026 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271452; cv=fail; b=uVsQo/xVuY1Cj3mexy/PUuKcryBgN+FVE3HGflfFY83GWN1v7MpwEtTjL/Z3dCJiyCMHcIHq9/CrKYL8Vhc+FuI8KcWKV4XJZSIqrmqw/VrvsU0cBjuiwsPtdD6G7IaFKKMwaW8caEOs9tyov+k5BQhT/x/KXbX+cnlt2LoXpiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271452; c=relaxed/simple;
	bh=X4BlnY0h5JWucGScZ/+U4v/kDi5sdxmFtmpcCcuQqyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQYgIJtuNCLbcGSDnV67sIrvRlLOtcEG33SfD5autQcvTa4auYMK/cNEI3GBog7IZDvP9/REsc+LUs+x80dycviLbLHpdwIs0HJZe0CccS9dJkKBYvDGyrDIm1YLByF2XCiRN1NgIsztMaUEA78sar65vX6tRFEsNerUYdpSa98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q1LZb0uQ; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVzz4CZQXkmOg4m4JKDC1Q2XqQjFepwhFt/DwzsybCat4z6jDnv02A7SkayyKc4BRA+dInbo1EK1Dh+EkYmDBZEkZpwr/kCsEVO6/wYEYBrAIoeo+mU+a4Own7sORbCSwiqAOgwmI9rIJ2QkDwcHyGpsdbYGCXPlwU7+6+GCvZY2cHLwUIBtP6G4QLVRPOKzzi8MEsQinI4lq9x9OdnNSlAiAutM3bEIG02Bkn1M50At2cuhI1YxibbW/XtTfTOOlluCVkgB8QtdHvsZHYKDzxOiG7vx+iYMFPJXjO9JnHDFzRuLHaJVSPjr2rvWD0wicquMjf7zynFd23KBRvWV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tvXbt82GMAtSbKeNsxv5l67Z3j0b/GH85WpH7nO9j4=;
 b=VPmippqIUbvKDHjCfUbnqFpYf0D0Sln1G0f9rGEci5+cAvdejexLOIADvcDKd2RCB6ZVgxQ8DJBpvsNo/EQQWqEHDWKywBVqdcLjPm0Dgg5zNtmUbV6TOEaqK+JxLN9VBK8zMROm5hn7cbWThrINDI95sn/btJORgS8/ZhxmsfEZsdWxpLmziOpoBsqW7Tjj6L8T1bYHQVgqXpITnOTAc9fqNFYE8BL/4hIi+iyv5qJDIBSKxg9egVa6dfSSDvjc8FtyCx55uR1k5kggH7bu3cZ8HBiIMiKnRk+Jdd63e0WPxrcdOpUsOHbjp49DXGozmOYzjI5EZdyBKV+GHmrlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tvXbt82GMAtSbKeNsxv5l67Z3j0b/GH85WpH7nO9j4=;
 b=Q1LZb0uQRaleJ0yC3WgvgqkFPDHlbh8tajjYAHul2bZYjWlbaqwjV49EpvOj3cZmWN8BFOsGLHimUo9UXo1hO0UDZHInuO8e8qyhClY/tsAaq0EDwxs4FIc1AFdPDJtmhs4EjE+kqpi29HmRbLebs0Cp9Eug5Pos4u0WqoIbBixdRUI1SgkkLTYBlAPgYvF+yVcck0KfraK7pceD4B0TYNzRI2p8RuUQWC1aE7GyhIOh0y8Yz1bflmNZJPk2ujzgioNWuipkJzdkaOTLrI9K2zVq4yj0/hSDNJB9W2G2OMhp4Qiznl3zBNk7v1/3WAGZRYjaXQmZhDyovyfvL9yVQQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:04:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 06:04:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "ast@kernel.org" <ast@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "sdf@fomichev.me" <sdf@fomichev.me>, Frank Li
	<frank.li@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Shenwei Wang <shenwei.wang@nxp.com>
Subject: RE: [v6,net-next,15/15] net: fec: add AF_XDP zero-copy support
Thread-Topic: [v6,net-next,15/15] net: fec: add AF_XDP zero-copy support
Thread-Index: AQHclmBM2EZoqSdhsE2t9mtnMpPufrVznXhw
Date: Thu, 5 Feb 2026 06:04:07 +0000
Message-ID:
 <PAXPR04MB85107AE45D517D64F37FDE5D8899A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260203052329.1085444-16-wei.fang@nxp.com>
 <20260205052839.2449416-1-kuba@kernel.org>
In-Reply-To: <20260205052839.2449416-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7940:EE_
x-ms-office365-filtering-correlation-id: b9bd06eb-6f39-4f9b-3f96-08de647c5fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?elpPvODYHrTRexkzAHXKNsni6H9Ath617UIVXN1gyzEldsT5JLFBNdyS17rs?=
 =?us-ascii?Q?WZk4+p+WXuG57BmXCxp4uCk8RIZxWKFW+sjCRkIh6EYsDQdCXvYRHQcDf9YJ?=
 =?us-ascii?Q?g+NovEAicwT58EXjcDoQnXow7MkYDCPOlWsZhY2Egav+8fO4jOmlsKxC9ryQ?=
 =?us-ascii?Q?vVrqnzIL3mvQTjSVUk74kTIeI4yxEfn+VNRyEMcrryyX2i24bFuGAkkwseL3?=
 =?us-ascii?Q?dYjxCbRcYToMqrR+tbosHZfHzmZ1rrIPHVP5pZ1GtRTvYA4Bu9P92H19w5nM?=
 =?us-ascii?Q?aX4pOloyPK2/DP5J7MV+LrFJGLFaoZlYCZP4kYfJL3bPDFNT68x2H/xTPn8P?=
 =?us-ascii?Q?lOSUguB+FiHrbNnIJ1y8MUPHcCaUP9TstO4CRoTDHMCW18qzfOpNLWBFi/Uk?=
 =?us-ascii?Q?BlXIenlMuUEOGcwIK2MHPoz+bIgz+7htDfpIxMLN3qs/eSbK3IY3ixzec5hy?=
 =?us-ascii?Q?mP9zdtdGen25e9AEnu5rXsTeBosocdrB4Ej6ECAgJw0UGjlAuwhCmjcLAIE1?=
 =?us-ascii?Q?3aXp7yXFKlGujdqrNSXZHZd5cfEf6C788QoOFXAmnIyGVmq/vL2BKdOwEl01?=
 =?us-ascii?Q?/cxkFYz36fs6qjZmIGiNuhO+ORlcqX4NcakkG7vsDxGMr74AXrS7lMu2zu3m?=
 =?us-ascii?Q?a4612MH6hhestO8YA9AmkP2Aqt+jUlUYsxOb3HFnAu4FN3vjnLZaGKHtfreP?=
 =?us-ascii?Q?AWg+ZZ7aXwsVvuaX0oaecvVsV+OiIf0H/X7CH818uFu5DIQ0MZOgujzfagP/?=
 =?us-ascii?Q?erOxiTI0yFMfQVMEO5NkeT51+Cnj8Y6TSEYCevIW/zk6f3jHnSVo9+kVRpJq?=
 =?us-ascii?Q?Rb0QqjsXmrQjnPxFOon9SeUauUiTIVHOcREO22pOPLgTt6sa4BzEeDWlaDqg?=
 =?us-ascii?Q?BGmXz/hoGL1mDIE2rdDgldXb66t25B+Qdj+9dE9aA0yW7epBSf5IR9qZPRyx?=
 =?us-ascii?Q?MzOr6t+BJq5l8w12+dDqTFalzG2071eG/72nvg5ptgt4LNf4YamgbPaw4bB6?=
 =?us-ascii?Q?7AsUyA89mojCt1VxjWD242juodcCifEaXU38oA8UncrwkT3w/pUan+yxPcOt?=
 =?us-ascii?Q?rwo1KSVoADqw8gO4uvr3YSIu/9QlJqD0VU8WLxp9t0mN4zrS/TWyll/dSRql?=
 =?us-ascii?Q?EL9+j2ADyQq25cvzfNGrgpTDSsqP+gv898slOGdjZ+HOuKb32Io2UMPtiV68?=
 =?us-ascii?Q?d7Uh4T0W6Ci3/dH/VSB7MUr0sckvFc4RuhQgvQS1QET/Dq+xtLcnXGa8A9ML?=
 =?us-ascii?Q?W7KcEW3CpVqkJBG+/GenKh69mtzCwVczqNYQpsFz+8RAWlIY1dxmzazUFMj2?=
 =?us-ascii?Q?UB8+Mlbd3Mu5ytSREtwhZMdE7iy8kSqhPLwonHLTVZqlFKKscPJZ0JbQMrUD?=
 =?us-ascii?Q?zkWcFb9eOcRH/6j/Ij4gvGgsWLFcWh2r2u+jgQJ+Ciaxm6TWSbvETIHXNzZj?=
 =?us-ascii?Q?ifJaJlOvtDUnBIfgpwERUYBU/d1CILZvf0lwIjbusLFOoNdePE7mPp3nBgY2?=
 =?us-ascii?Q?xZYrRRgi5fu0arSnWLbubaIg9pfDSOieoG0zBbd8cKtZ+KxyImUSlpu09uVJ?=
 =?us-ascii?Q?IlmHQTqd1mXsa/rIZSN9SHdGjV1sWeju0hXUZeiFnEyHLQZNhXwXrUKqs9Y1?=
 =?us-ascii?Q?QA+/kB2SKYvDq0qaypBeVY0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sW+lM7qKYhyHZQP6j2pKl4g7QdJtVilGZb1Mw4JMZJ56kImbus7bAJNqeLN3?=
 =?us-ascii?Q?B6isvuAdHZB2dnpR8g5wEoNLdL5K7cJfGSeqXUirjnelsuEO+a97q3tFPxkm?=
 =?us-ascii?Q?tIA+wc5r+CfkPrcMAHYF2iT5h0V4kaIpkjNX2OkgqHrHjai342/U2b4A+FmY?=
 =?us-ascii?Q?6hNn+4Zk3Hotx8lftafxiP6dczTFb8GoiO2sdlqJhhgmP3CLczxDfPqSEerd?=
 =?us-ascii?Q?OtyvlcFFVLZVSUfXo7IKBlsuj2UL5JMuy5OPtBNl4ULrP4dF56O7OqZLKpOH?=
 =?us-ascii?Q?lACxWP+rVxHKOtRyJLuLuaPNCQE7UbHY1eBnO80mknnH2R2SuxGz180qwjzD?=
 =?us-ascii?Q?djvMO7UGma4i9AJ4RjtMGgk8UyGTHkCJS7tyZ9NvJawkGFzdf+BM3OSblBTl?=
 =?us-ascii?Q?1VvO2eIPRmbJHIk8IxqQkJTz/r5Ew5RB7gRsEJUIYtyOCKR+PyIr2ApqkfSr?=
 =?us-ascii?Q?+WymibzhlZnX6C2Roe+nuUleKAgWAb8ifH/UPLZwD5vQlQbv4EUZVWzDL1zE?=
 =?us-ascii?Q?EyMBrK+NrmvFqJ93eEMvsaNa6LtJEFfW5Tom2zkb/XPq1W0+EKvy4eBLVQdT?=
 =?us-ascii?Q?hbBb/ZaY2ljDfVz43Qa3oVYrQR4t2cDuqROyZO73kF972W50lcGH34CeR9yu?=
 =?us-ascii?Q?m22x0lh4Oxg0MpcO1BUOXpdKRN8g/TafyasYC/QZ1CPbiYkRCy/stbjlHdXC?=
 =?us-ascii?Q?M6BsT5aMxb/ItT5e+d/yz/gU0vTmJ7aUuuxZyX3a7oRiaYDjn6AFPqJiXoWA?=
 =?us-ascii?Q?7B/P+RKc0Q/9bgYC0bv6Wug7r2M9SjtGriFhEAne5MqijAfsQl7nQt6TeTZq?=
 =?us-ascii?Q?IJgnAfgruXuS2+DiMO2XL0idIZLXE4w8fuh+wrQenlXiry5nqhLDNBRda8jA?=
 =?us-ascii?Q?aGZKJy88CvNFzpNZ8uLft5+cqu384giEmBOlkxDTlWrnUr4Me0n7uB48TUh9?=
 =?us-ascii?Q?C+16cz7i4AnMD/444S15sszCjGk5dkNOtJ+oLtHwQmBFm8zVHvAgYpgCnv0Y?=
 =?us-ascii?Q?+9oMV9cVrokgt90U0w0fpgVLWaVRuTMwUiuZ2vRY84DekxlSu5WU5l287JfJ?=
 =?us-ascii?Q?NA6FOMDt/EI44ZK3W6vkBSLk0XtvDbufD2OMnm60ibHPeG/Ms9A5H5nHGwb8?=
 =?us-ascii?Q?XhgqYQhucYG5G9KXXODNPhaYyUJ85/WUFuzTDt0+3sVPDp2RrB10tRUyuQWd?=
 =?us-ascii?Q?K+Mp+Na0wLDjfhoK9vPtDgZgwaKJG5WOPctOw0sx2YyVcC5JsMHlEF4cHEUV?=
 =?us-ascii?Q?CywZItc+QKoOMiNnclXYEuSe/Er7oNNgqWPPX/9IhvlRBVw43uvopUoDJNJ6?=
 =?us-ascii?Q?dwnTeOYs50rrIbfNJsUN70a4ZNDihl1Q2/kcIUOfdxKBpJdp3vVT3Q5jNUwc?=
 =?us-ascii?Q?nldqc4WlciqyfkwIEUdIUPoRi8S+ku9uuRJPCXKWPS094lmUmdcFMyaYnO7b?=
 =?us-ascii?Q?Mzx+V2mWDonj8BvseQ7kmoE7aRRKnONobACJGmaBQMLN0/JNd05gIYQ8HEPh?=
 =?us-ascii?Q?/ZRA52B4o6q50AVRqs5VHiZRs9Rv5mMv4n8IfQbDDxaHbdP8kvXoafaf8G2Z?=
 =?us-ascii?Q?RlgUvnq/Q6zdg+txB4Sbba39sM+fitHh4jjW2WpHp97VidUyHtMbazNcddh5?=
 =?us-ascii?Q?z/CCxO8c2HXgfCnm+mg0zDNntUvp4u0SA4zCqvVlKkhwzN7mYw7lvDO/Lh5q?=
 =?us-ascii?Q?wYglraxejOhErBZH6Dj1eF/8LKj3xI/HbAte4XGG1Nup+kjT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bd06eb-6f39-4f9b-3f96-08de647c5fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 06:04:08.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym4hB1TCvBxpsm5ao/Rh5245bBQNNadQrKU64+GoEgvdapbVn7FGmgX8YbNMg2vn7apM126/R9Cl420lgu+fLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256979-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,redhat.com,nxp.com,gmail.com,iogearbox.net,fomichev.me,vger.kernel.org,google.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1BD9FEEDE3
X-Rspamd-Action: no action

> > +	bdp->cbd_bufaddr =3D cpu_to_fec32(dma);
> > +	bdp->cbd_datlen =3D cpu_to_fec16(len);
> > +
> > +	if (fep->bufdesc_ex) {
> > +		struct bufdesc_ex *ebdp =3D (struct bufdesc_ex *)bdp;
> > +
> > +		if (fep->quirks & FEC_QUIRK_HAS_AVB)
> > +			estatus |=3D FEC_TX_BD_FTYPE(txq->bd.qid);
> > +
> > +		ebdp->cbd_bdu =3D 0;
> > +		ebdp->cbd_esc =3D cpu_to_fec32(estatus);
> > +	}
> > +
> > +	status |=3D (BD_ENET_TX_READY | BD_ENET_TX_TC);
> > +	bdp->cbd_sc =3D cpu_to_fec16(status);
> > +	dma_wmb();
>=20
> Is there a missing dma_wmb() before setting BD_ENET_TX_READY?

Yes, my bad, I will fix it.


