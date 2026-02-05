Return-Path: <netdev+bounces-256981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPIqHrs1hGlB1AMAu9opvQ
	(envelope-from <netdev+bounces-256981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:16:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8CEEFA4
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDAE3013D53
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47134D4C2;
	Thu,  5 Feb 2026 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c8Cx8AGA"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FD31B101;
	Thu,  5 Feb 2026 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272174; cv=fail; b=Wi4m0Tlu5mUaDrKNL8X1Uk754jluojoextVdVBZOAMERTfEDsDjT31qjNgI3v6V1FPISpLTgSxzoxjLlGq8LZZMbpbeb4PCUIouQEAmo9xTZsCFxOwsZx93xnbhHbF+FzAwGqUmB3VzGnE3db1P8V4RDFZZJZG5Evn36xMvsnjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272174; c=relaxed/simple;
	bh=OApJNR2vfFTlRr0c9yeBiMvBHKpRQT0ZBp7nWZ356Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cp2P9wDjIWJfBw9ftC3xmqxFh4QHxj7Hh5n5qM6L4ZEk+//DFv8yzTo6aNCJIJYUcDf1T2CVm+S4/PpWiPeg0Tp2DVwUMT7G8HGk4U72iWjLm9C6NhYyCs2sVhI1dpHgHM3yjSD9EWNOwB9y9dVgSIsEG4Phfks7GnSMUh/srHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c8Cx8AGA; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgNnRg3TAeOjes2ToBgK/kWxVt2s3siLljfv4iMV8Y2hrgZqMkfkPBPzIaypO3nZJo18Gm7jOWrAZkEfNYTSRead0qzEx/GlfvJ5NSVacRB4p1IQjnk2+bEEuxhWO2Da5Q26Lj7PliJrad7VKoSlttGtOiSN1gw4CiMjInjf5oduHseQvb/Vh7TxzrhUbIMjV7v5OCA7jXjQN9RMeLP+39tgktjg67IiX508grf8yTeaHtsSJzP9mTRqRDJYmmKRwEnY22/wxsPJrHqmxLZpjjD2tmVuv7TouJHv4K56SH+pcUr636A0+4wxVwjsdgyVlu8V6hSW8mGYWDBce2ylNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mCUcr9yROACfAUnOp7nL1v6Bq3d+7wvd5j+YaWplMY=;
 b=jspA4MbhGro31x4EBeakWdxifMU0qa5T39UpfMVpfgn2PCpQodevQxyFuhvpCaJUaGCbzPUFMx2tjjk35gcSprioECR5+RMRQSoITzbNEZG9XK85inQzft9rnmHSvJNWIdfeAmBzeIIO/01dHrsUzp7e8cB5Q0gOj9L7SAjuaoe6PyJfAB8VU7j2iL0tT0OO24mW2JeIOCtry7V9D8lxAbolcF+M4Em7qNQNPYBlQ+HM3sFgoak6Ve8O5IY44UL3ezBExtJJ6zE0p3fcMXo9mpaAt8uy64LiNeCe8ykET8pq43XjtT2ztzn5iXxInIlDfjKzdE1qoXplhaa+IXXzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mCUcr9yROACfAUnOp7nL1v6Bq3d+7wvd5j+YaWplMY=;
 b=c8Cx8AGAQviH3YXlKBeRzYRKfUuTdmKgUgvh4aW826ZkjmzL4aokFfS7t+GTK1vs92kEVXr2fqegpoaZORurxENFRqjH+d6gRobm9ufLVFmUqnDhMVa5qbCPLjnxip/llHWsUnkfRsbPvRNnUgwB/NH+4Jf4z/dM5b94xHs5ZDR5slpjIz/t3nyVtuWvgCzxg9q1Mntvk1vndGI2MmZpX5pgcayTJSSypL3qDM7YU9mA0amgc1lVsIVZVb8MrVfhdhXnO7n+o1JbPF2pMI7dH3m+k3BrEiGoZLphvZjJWRsowThVw3+yEh7rNGcs1wvPVj9kB5EQpjteiCt0GorxNQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:16:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 06:16:08 +0000
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
Subject: RE: [v6,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP
 path
Thread-Topic: [v6,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for
 XDP path
Thread-Index: AQHclmBLEIj9kUWVTEaaHreGFHtR+7VzoNTw
Date: Thu, 5 Feb 2026 06:16:08 +0000
Message-ID:
 <PAXPR04MB8510844B724FB984FB67E9138899A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260203052329.1085444-7-wei.fang@nxp.com>
 <20260205052837.2449389-1-kuba@kernel.org>
In-Reply-To: <20260205052837.2449389-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9761:EE_
x-ms-office365-filtering-correlation-id: 093bcb5f-6e4f-4aad-a754-08de647e0d37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4NlFtCjP1lZZ4arUgtvimdhI9tuOfnQXYP66u+0l11QHSlKoQJhwavfGevQU?=
 =?us-ascii?Q?OsBjWf75DNm6z/19IK+jButXBgIAQiUX4WUvYDanJ54sxftM+0mkC66Nps/t?=
 =?us-ascii?Q?O2FZ7wTsVCZDB7Rr+npIobPLHpY4cmVuffBETRARW0QgJZK2Sy+WO5EmPPPe?=
 =?us-ascii?Q?qHmqD5kh1oJdbSKjgeLRFEc99A8Pxzhed3a+U1RDaZ+KbcD6S3caQBK+FQXQ?=
 =?us-ascii?Q?L4M6TBVpd7VFvTXp0ro7GQXKu7Jwsnncj7ygeLw2PmlasvG6T03mu/m44yHS?=
 =?us-ascii?Q?DEa92bHWCD83Ry3Zi2QstfP3ym5RJpHBzgL7HgS94pgJChUNB9N6uqkk/Bc3?=
 =?us-ascii?Q?aW1ygD9Uk7+4WOm514stO4iNvbpLgyJGCzMqsDC0lTJyngyGaM0wQME9ImN/?=
 =?us-ascii?Q?fXy5I67lZWFKm/VmI/VbiBJZXtzmtNK1pQPavPV5JHRBYB8w2u5sRzIM2A3f?=
 =?us-ascii?Q?UZ7rQj2IxfCf2D3NcNpvbeSq54MB5K6VVtD79jlaax6IR2wnjJTZFLf9dpw1?=
 =?us-ascii?Q?c1oLAMDP6HgXuH4eeyBTwgV9fXw0ZYPRZkn99NNlBb6FD9M9KK1XjwbZJSBm?=
 =?us-ascii?Q?JskryOlK7U8gBAIfoGh6K5G2L0ldymak9GOM30FIK3RY662xdBpkFgAUXwHF?=
 =?us-ascii?Q?IYDSZ58mhCgzT2Fo9on8+cfIvgmP9Qh9LpXfhA5Cj3OoCvrSY3uySe67JHYe?=
 =?us-ascii?Q?xOkWpUZlSENagDINekK2Hu9IL9MU1QGblvg4IfvParCJ3cRFoLS/XCTObJ2e?=
 =?us-ascii?Q?EoOacxfFGPtHq5/Ep98pwV52rKrvx/Aek/mxuQKzxJgHMxW1bApHVnRA0o+k?=
 =?us-ascii?Q?m3GnkVp6xW3xPVTPmWk+r+eIAjcMzgHX6od52qgqa0aluG8oMr6LYoHIwY3Q?=
 =?us-ascii?Q?eInJGDXLmeeowasOJz/mLBHu/Y/GltyaHCQKG+/rxiPmg6z/olhuHlIrknyF?=
 =?us-ascii?Q?XJIvqBrv4VzFneSP2sliJC7tdjyEAb3Ktcn3Rna5kIHlI2kmFVPvYzZD6wuN?=
 =?us-ascii?Q?PsKi6yowuMi1eFqonga17QFG3eahHamNC00UI9pt+a+uT9vTogzvDhJmBKVK?=
 =?us-ascii?Q?ervkWk9LT/lxA1rJXLkSaT/5qsCIoGFwECn2WrWbrbzkOoiudLWW0aSfKLas?=
 =?us-ascii?Q?0untxEo4m7xly20qeG60JB59VdlqmQnMr82SMRN4a7NTv4hQqU4qjTiKKfFd?=
 =?us-ascii?Q?whulcjZGInl0XZDZJtZaUlRS7Pt0eIvNPe1wlQyjxoitqdCU/S1XenIo930/?=
 =?us-ascii?Q?B7+AIx550qNzWXyB8TaOoFLmysITIKecbfClr+yxVuR4EbFo5hrciNh/TiGj?=
 =?us-ascii?Q?NI70X6C0qEPFb4+IpbOLG+vHzLjhblJiNISzIEdFJVlo8s/gci36sK0XiVgq?=
 =?us-ascii?Q?rJzOCNYdvOSv2+c4KK0P0QSrGBd5fgJ+H39sOXdng5ecGIOJJbh78IbiTz61?=
 =?us-ascii?Q?+7zi8dqpI8FCrHWSvlCx2B771ecGUYZL8rU1RmIdLV54Nx5JpQ0PeuqAvpJP?=
 =?us-ascii?Q?l5gYTX0f/oHVk0QuYrj9mjrHy93nsflzzlW20qSN9a1tr3vBYvbHMLeodZjt?=
 =?us-ascii?Q?gnv7uGOPqpnevprO+Smsw//z+iweXMzLcuSUbwJS+9Mxy0NgnXG7seuTN0Pn?=
 =?us-ascii?Q?3LeRwXrRkLpPTTvkI9aP5Pk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WBhvBZg0rIR2SKKGSD/9A7aEI6oJr8WfjytzQ+rEiGu//hTwaLlsLm8Zt3Ri?=
 =?us-ascii?Q?2B8Sgic2cadkdawjovObTuFHRIMeTQMotURLjFL8ns4XQwu0WZlm5Xoh7NjK?=
 =?us-ascii?Q?oPpEVxzzn6gpcvlwQVvbTrctN1CaqRlOqFqdIzl/BHEZpNLQaIEP0sp5kLrr?=
 =?us-ascii?Q?I/g+YxYZG7YKD86V469IOOuNzH6ERLXEOo+ScnXYEDdpgzEONQR/IKLFY6kj?=
 =?us-ascii?Q?Mkmt3o3Fk4uu7m6d0612WhPzbFACKthFSIzOdx9ufY05VZj3yZewH6zwt+fG?=
 =?us-ascii?Q?ncX+bUJ+ghJBj7K5stuQegXp++oPI2+FyfhjxYBg65M7ye6nXGXiTPVLnieI?=
 =?us-ascii?Q?vRq3q6n0aciP4XlpkPJiooF2pusg/qqd9lYEmLH7eXqCfU8opzzI54L73a6f?=
 =?us-ascii?Q?+T/NvE8/IZmdqXJh4AXDKICEPIEt2DcS/WLazT6Db57KlHA1o3ZX9RSNXPlf?=
 =?us-ascii?Q?Ds7BG71GM+fKWK2zLXAzCSyqjoSvlqGP3CF4eIJGbP0DApIUjxspWAC6LuJL?=
 =?us-ascii?Q?9Drid2JQUXgGa+4gOmWR1uJbgZclB6fkp/mRE8CouFYDt6Ok4VkNkVRI/5w1?=
 =?us-ascii?Q?KWGxWdXNf0WObNbIp4I8dOkR7o+tF9C2IfprXR/hBjiWGmtowuKNdLPomQgn?=
 =?us-ascii?Q?+EPBwX1yg1snUDdn7ApmQVjBg+AvJdjXtFDT2Cikke82Nf937dekZYQL4gf5?=
 =?us-ascii?Q?9PTukFPoxAEFal6X8BL3mwZB02wzBTpDNyWP5TQtMuhCWMvEOs5llKxPRXeh?=
 =?us-ascii?Q?FChAIG3dN2T0LFMaj8uGk+gH4V0Nt0+pqOJVM3x5GjbdN05rvqiHULdQHbX8?=
 =?us-ascii?Q?T8GR5JmhBFNSaEUSS6YTGic2nc/QHExaWFTLj7M7rhEcr8Srzyzu0xSu+0eb?=
 =?us-ascii?Q?TxpUce5GdIv0+GqbM0dI+r2c+Dsxk00CqKGyMQLf/BfmvYgKQu0FZrwNb5Jw?=
 =?us-ascii?Q?5wHARDdMzPBOip9J3AbWVBvi0dzAXv6dS9rj8Wdt4rgH82e4g8GNpsvjhKf2?=
 =?us-ascii?Q?Y9xKNwJvL/R/Igg7OOLCnlqvlKmrBF1A2dpKu65eFchMS9JRc725A45BvyiU?=
 =?us-ascii?Q?eOIEpBDyG8CIH4B4fqlpFxO7emfPj4bf8A50HjLJToclEMhVkxVgdQGwbMpc?=
 =?us-ascii?Q?UOYbr8ZCGmk2cX6uqTi0oFheT9Tz4wOstorY/2lqzoWpliw6Fk4mDNh4yuHq?=
 =?us-ascii?Q?uBlzz5iZit3uGD/G8JpkDORjBYoxbNwAJ8FDerefgkxnQqPtep3qfEbkFhib?=
 =?us-ascii?Q?LZqxOHbOw5NpboEpSzvCSxtXpy17QB8rWLtc7ahwXZRMyHSfqSIGLdkCfRL/?=
 =?us-ascii?Q?eDMqXn5/SKu2deCm5wWCQgVwGl5TkImk5Jlez7b5mFeJnZXlBpz8oAzuZnVh?=
 =?us-ascii?Q?yceLzZ6LBE+wYieEEPg5C2RjLYoHs3i8ani1W2/d9vVpdwTbEUUH/+PBAxBq?=
 =?us-ascii?Q?SmucIcy9cfHgRWZJ4N2Rj6nyx5Vj9YQDq7y42GtzfZmnX2bXA/Mb+WgF6e4u?=
 =?us-ascii?Q?yIKy4SeWrx1WB2F4gH2WrShJarFQci2+EX/0ate463td/MURzBl0BRczY7vf?=
 =?us-ascii?Q?JBXMEJlGUn//lkQqxP96nn6rCMcu7WJd5Z2ZTffaH4q+hw+vrpZIEcOUhM4w?=
 =?us-ascii?Q?+VHynHpjzHz/qfWqUNsjma+E8LVV4yfV9Iu5RR9sffExspaHd+7wdBEhaIwi?=
 =?us-ascii?Q?PeDRdo7gtsSd0QHGJhvDx6LSIhCwwIwP5dxNnOb45K90b6yV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 093bcb5f-6e4f-4aad-a754-08de647e0d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 06:16:08.3009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujHQXJ8typGnETSsibWL9b7xiScxp9FsMV8j9CPaA9M+Z2yGKYkilvsUnf9IGe5mQNShrHevNRbXGD7GO8SCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256981-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 24B8CEEFA4
X-Rspamd-Action: no action

> > +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int que=
ue,
> > +				 int budget, struct bpf_prog *prog)
> > +{
>=20
> [ ... ]
>=20
> > +		switch (act) {
> > +		case XDP_PASS:
> > +			rxq->stats[RX_XDP_PASS]++;
> > +			/* The packet length includes FCS, but we don't want to
> > +			 * include that when passing upstream as it messes up
> > +			 * bridging applications.
> > +			 */
> > +			skb =3D fec_build_skb(fep, rxq, bdp, page, pkt_len);
> > +			if (!skb)
> > +				trace_xdp_exception(ndev, prog, XDP_PASS);
> > +			else
> > +				napi_gro_receive(&fep->napi, skb);
> > +
> > +			break;
> > +		case XDP_REDIRECT:
> > +			rxq->stats[RX_XDP_REDIRECT]++;
> > +			err =3D xdp_do_redirect(ndev, &xdp, prog);
> > +			if (unlikely(err)) {
> > +				fec_xdp_drop(rxq, &xdp, sync);
> > +				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
> > +			} else {
> > +				xdp_res |=3D FEC_ENET_XDP_REDIR;
> > +			}
> > +			break;
> > +		case XDP_TX:
> > +			rxq->stats[RX_XDP_TX]++;
> > +			err =3D fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
> > +			if (unlikely(err)) {
> > +				rxq->stats[RX_XDP_TX_ERRORS]++;
> > +				fec_xdp_drop(rxq, &xdp, sync);
> > +				trace_xdp_exception(ndev, prog, XDP_TX);
> > +			}
> > +			break;
> > +		default:
> > +			bpf_warn_invalid_xdp_action(ndev, prog, act);
> > +			fallthrough;
> > +		case XDP_ABORTED:
> > +			/* handle aborts by dropping packet */
> > +			fallthrough;
> > +		case XDP_DROP:
> > +			rxq->stats[RX_XDP_DROP]++;
> > +			fec_xdp_drop(rxq, &xdp, sync);
> > +			break;
>=20
> Are XDP_ABORTED and invalid XDP actions being traced properly? In the

I will fix it, thanks.


