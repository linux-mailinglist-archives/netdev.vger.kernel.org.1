Return-Path: <netdev+bounces-263536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF0qDCyOp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:43:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840991F995A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB298300615F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933322BE7DC;
	Wed,  4 Mar 2026 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ThKGyeDY"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858324397A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588332; cv=fail; b=mUXisE//jIA5V3EFllxJfmbR2T5hQMlYahxQRxWquKWhghQiiBF6YekhWb6zxRf0ULNdFMn0/C/l+hg6MQZK7lx5gYElpUhe3WQLboK2TJJc3pssrNQ4fgaiGnQmUWZnYziTXchsHH5mP+aNBUgsrLC6xxhAN82C+NJ26ciYeEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588332; c=relaxed/simple;
	bh=xJe9cTnHUbAVagDu7F/Tt9rYHa730WyNLlXUQq+f/Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RtrUJs9f7XNDoSYsodPUnUZNKptbZqwgq+d047rK1lVnUniqSF5vH+FJM6xuob7kxeCRO/o/7JzbfpavKgdJEMxLx6dBl9Jsfwr9pZK5ZkvJuScJmKn7T0WtfKEPvdyJ+PVl3Vkf0NasAnzV/sgHzw80nGV849CI7kJNK3kXclQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ThKGyeDY; arc=fail smtp.client-ip=40.107.130.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaxoNp/ME20IWxXf90cseJzugOD8+HXrrvh6mfjn23/fcr+bK6sydt9WwiAwbI6SMDsVM/lzvugCd1jHzrYOmetO71Qw7VhJuXgXFgctIfPUea82WuZ6U/rTLcOtVXf4vSWSPSP5lb/dUPiIi8nd93dmLTBJa/y4ATGQF2h/FRd5SqA8K4eEMqNpmPtcNtX/Y0zV6B47TuAF4trZ4mkwwy0RdTLy28T84zkcYpzJc/56lXdpGIO05b5+BWBs2Bs5O23B71iOWSJ8GPsFbpleQls3kK/usSDGd3/OqGmgZZLGW3pVI21X51vuFyeRvSf5vORUwYbzgSgFFFVKeNGaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DnOWmSOSkU2SJ64Rxgp7M9B/wkQi9L3trT093lQIPw=;
 b=I79+BP8wr/5yB403UfF6qPh7dT5fBj83gdDUmMvDcPiXDOWl4So7Z+3pvTihxRfGI5CFS3jwCpZvO7pZevrBNJaNFTpTa2uG+4SSnDkNd3/pvbpgJyvkoDUWwWxXzyDxyrnc7nfzNrWMW0KIvwm+ftAnNNY7WSYBO4i6F4jNfSccYmku3uO9VS5iO+KWaW/eAiPXYaWbA1uDyyYW5CxcCkgxGszLrl9orpXkvgiRCRfAJETEpyOm5YpfP0wdIMMn1TnP4s2B3Sqm+KqcfTpjzbhhFTxEIJg3OCbOYnOneMwYPlHlS+hVjLDUpWEV2JbLyVJr1Kgn6UWtyYovb7O5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DnOWmSOSkU2SJ64Rxgp7M9B/wkQi9L3trT093lQIPw=;
 b=ThKGyeDYTNFMdqb4NMS7HOgsOFUwpr81EldZHNNB8nRGeQ1wpr6Dyc1IiTXF5hJt1CC4tvJjlXBH0syqFwoQ6lNA5/gZxtebXtV+2Qzox4+12pbkbVP9hDRy+zqTyVoN0UfpIcX50jYJtS6UbqbJOnMAluYBwpGMtC32GHFxVOZ3NcNj/96BiEX1AjTG0cRVddY+fObQV9spZNAoXQdjI33SbrKwCaibOsffXo8EBX4J5dIGZshD0Tq+08ixOqAaq+VcqN0W5TXSCuSzmQXQ4rt+bQazoxxF3Ajt7oSYFJGzyuDltESXtOv5OnEHqOVSchMKxnXnS5N8GhGD+8xDrQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 01:38:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 01:38:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>
Subject: RE: [PATCH net 07/11] MAINTAINERS: replace Clark Wang with Frank Li
 for Freescale FEC
Thread-Topic: [PATCH net 07/11] MAINTAINERS: replace Clark Wang with Frank Li
 for Freescale FEC
Thread-Index: AQHcq1g76AUp59U7s0yhAJtboy77e7WdmCyg
Date: Wed, 4 Mar 2026 01:38:47 +0000
Message-ID:
 <PAXPR04MB85101C7845540E75D3E807C2887CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260303215339.2333548-1-kuba@kernel.org>
 <20260303215339.2333548-8-kuba@kernel.org>
In-Reply-To: <20260303215339.2333548-8-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB8020:EE_
x-ms-office365-filtering-correlation-id: 63167c38-7401-41ed-be2f-08de798ec7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 di9eWR9FMDFyQRqvVqZbbnQ/xY+NF0/U98MLWTeg3dLL6SMIpphrKkIWLCemePbD72NQSod0hL7W9+//NTTHO27achgeD8S3pKLxJ/pL5b9XyJplA0cEszKFcHY9FqzuPUBJ3t5dBh6v95B1go2SuYB3r8T8N8VMm73T3jqLCEGLow9rl6LhyFnzJtLRY834HfARYS1vm4I9d/oih7BW0DPlabXYK8vEyaJUH+ynNi8xXWo78wC745esoMRYILGd244ALZmhg9qJQjRmnuPt+MlHgvlfJGEO75oyt6BsWE3plYNiR1Ow2fmtXMuESMc6QhBTctXnHzidEzAt3hyMSF4SPPxPt0jIZ66pVLyDZ0wrUckfu4kDsHTABpdItedo1fyzHxgMzyz3sLIBEyTRdI6/U/Ci9/yYVtibDDlA9RtPL/8+G4RHTwn/nQaac+17pYBEm6CJ2YUjphSkjk4trNFn60929F4Y8aohQmhWt9C+KYOUqNFsO9j38p77SmpZQUG+/w6zz06S9DsU2uiWYt8md7Tho5MS9zpL/HXvQmGtJgQ7cjl3MGCnysqX8tv8XviuQd89/AOoexMrgjuK7dTOOZhldlbt6yWfFH8NrirZWsg06JioZg4PdZ8u3VKWV6HjbNpgo6mp4dEErwBQQsYBZeV0AX9zQl9cmagIwb/bXB+rzNKoPsJiikK8oDbN1HQYc4Qme8avIu6j/Aeni+Z1SuirwLUnSz4ccne31hbipBsXDPpWbJfk38qJIEcbf91y2XDUdC12Bf3kIDDQOXKhvNVdh9HcLYoiG7HueIA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PDUw5Dhbb97wpXFRFN8WBHJaCUsfZLeixkvX1XpZYYbre/pLCoo+pAEXaM0B?=
 =?us-ascii?Q?HuS1u/6goMb8nuv9JUlACOazXNCZ+x5C433tscGCHScQpPC3dVpcGBFrY5Xm?=
 =?us-ascii?Q?PkujBRiIeyneXjqSowiIfw1oBYqdsRkVV1as7eePeXlogjYKX9E7ZjTWI3C8?=
 =?us-ascii?Q?8BKCwx8YZzn6FsUZuEZTn9imbicea4ddGdiIqIHkj8uolrqUUqwFRI+OZR4I?=
 =?us-ascii?Q?/r3Gi173wBaplARmyQ7i6XEwNr1TuhO1hwTaLV7EOohu19aGVJ2xYWuuZ8MI?=
 =?us-ascii?Q?yKSIsm8DAklv92is0anO7DW2j5ifG1gXnTMd1Xvuypm/yQZ2RtIy2uQNa431?=
 =?us-ascii?Q?9lvCEYRz8OhXRddTPaEjDG+slN2gu5pe76gYdRmJYJ+hC9tBz/PJ8uXs1TIw?=
 =?us-ascii?Q?lWqtaiX6lKzsuGR8BOViIOsi2rmL7wqBrtJx7QDO89SP8y5AeXb9fOwBuhZG?=
 =?us-ascii?Q?ijiZqnGIw6IRAeOV7/mmy1rbrDKolEROvN/ZfhQ6kj+aqSI1uhOwlp2Yl7Qy?=
 =?us-ascii?Q?SLr06otVycTvJ6r0yalzp4jZpjt8oubMLgSCqgDltpAtALlzxqA7v+DtTH5P?=
 =?us-ascii?Q?04mbc/cE0QnMd11tu1rdZ1D40zQRQqnhrr97ycfC9T7I6ySYG0onZl/k3va+?=
 =?us-ascii?Q?hyzu9EQAWpr55NmLuZNRWh77HydLot6pr1ylfYkO+sAHJXMVwVfKR6XsUHXN?=
 =?us-ascii?Q?C2SQ1V7Y/eHjhI7iZVpI0YB/DDrhrdGns78j3fRygis4b23Z1NSH3gIugyAQ?=
 =?us-ascii?Q?DivJvnak1MJGttDw2sj/9CRlx31TIpyeRMmGkMBNMa6gJP2VI8yIPby1ngBh?=
 =?us-ascii?Q?Dpx3SnPs9mQJva9eeeBG8zn7S4zAuAUNBDK1lnXWA94Gpx6AWPu9AiVjj8YJ?=
 =?us-ascii?Q?31/rhEqiqVhrrkF1KOft/xIKI5JPIawmEn1/pMA/nNABMUIvjSuCGr8mHb2w?=
 =?us-ascii?Q?qM/9zQzMxyPAtTjliRmnV47hXu1l44kD9CuRAuXhDi9aAmTKP/VQowbnF5Tz?=
 =?us-ascii?Q?wQlR2pMNITOY4wPAFCg0J1vAiCtLBWKWqe4Ja8c9P71723BcDG1yLfoC1v+i?=
 =?us-ascii?Q?QqS3uBs83uA3mr81EjX7aukfTjYGbUsuCK5unvrdKrW6dlFOuv62/FbnCTxV?=
 =?us-ascii?Q?zdTrcXwiQmDwXKo2AEJlvJSpXn4ZuxHBF6onBFqekSiicKgRuwVz2VEFVSyp?=
 =?us-ascii?Q?qw/1fWtmZKG15Yg22R1DjHuBf+ZfieTrFaIYAAUhdZUOZfxVeIXLTYYFj+wV?=
 =?us-ascii?Q?6hYJ/3cYFdIxsJ1D18BjVVggDRtDIerR4viHZae3kzzKXcOW4lBfFO4aG4Gl?=
 =?us-ascii?Q?inCGB7iSItHY9PITFzl09P02xoX8C1O4VT6zwyAEg+zDCCiS8X/srAj7WIRw?=
 =?us-ascii?Q?jkwTnRXm+Q+cacFZDOtDqef+FoKC844Av4tuZ0IHiRu/e5A1bs2YEPLcq3Vl?=
 =?us-ascii?Q?9MzO2tsmcCZnqsnnJNnDwqd7Q1ikG6x4J+UfM1caikJu9m116xjRPzqDJre+?=
 =?us-ascii?Q?8nkfiIaJNH/sSmDqxzICqMQD4jV5hbcqHlGEIS1kfqzFIGX0JyqytPGla2AI?=
 =?us-ascii?Q?kDAoaoDzjP3ZVugbjhf+OaKH8GC6o4NB3MOm+XaPN/bFILMIQltUIkeU248T?=
 =?us-ascii?Q?DKKekhpuDw+NYRrJNea2Z0GaG5N2ozd98TjYmQA3uRkXnZJxT3A20+3RL8nN?=
 =?us-ascii?Q?VtP1wN6Q18MrpX53qOOv5YQEwK/GpxhDWVBmuEnIZ6uoyFPW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63167c38-7401-41ed-be2f-08de798ec7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 01:38:47.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8PoyWVrqIv7yPF6EbU/E6JhNPjfAMfIq1lapT+eD88oRLiSbp572den0UnT4juYCn2QowHMsZV0d2P5Jx94yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
X-Rspamd-Queue-Id: 840991F995A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263536-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

> We have not seen tags from Clark for FEC in over 5 years.
> He has some limited recent activity on the mailing list in other
> NXP subsystems (stmmac, phy). Wei Fang and Shenwei Wang are active,
> with decent review coverage (61%).
>=20
> Frank Li has been reviewing code actively more recenty, let's
> make it official.
>=20
> Subsystem FREESCALE IMX / MXC FEC DRIVER
>   Changes 57 / 92 (61%)
>   Last activity: 2026-02-10
>   Wei Fang <wei.fang@nxp.com>:
>     Author 25eb3058eb70 2026-02-10 00:00:00 33
>     Tags 25eb3058eb70 2026-02-10 00:00:00 61
>   Shenwei Wang <shenwei.wang@nxp.com>:
>     Author d466c16026e9 2025-09-14 00:00:00 6
>     Tags d466c16026e9 2025-09-14 00:00:00 6
>   Clark Wang <xiaoning.wang@nxp.com>:
>   Top reviewers:
>     [23]: Frank.Li@nxp.com
>     [17]: andrew@lunn.ch
>     [4]: csokas.bence@prolan.hu
>     [3]: horms@kernel.org
>     [2]: maxime.chevallier@bootlin.com
>   INACTIVE MAINTAINER Clark Wang <xiaoning.wang@nxp.com>
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Wei Fang <wei.fang@nxp.com>


