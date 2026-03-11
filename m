Return-Path: <netdev+bounces-266569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJLVGYBCsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:22:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C32620A7
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6212134915F2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265903D0937;
	Wed, 11 Mar 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LPDwhaQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A03D0930;
	Wed, 11 Mar 2026 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222045; cv=fail; b=OZzC0/1PHcZ98YNzrcVpkIPia462JFNVt3WFZlX9KB9FGzb13kid4B7qFBYe1X+VchpYB/8hefE7Y822qYg2+40GyHURUKmH5MsHEcuorTOez8gnF8aJd4hJsQmzs/r2ms/BXOFcxEXWAvrYU2OPcybZnKs9KTbNFagDEjWLleo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222045; c=relaxed/simple;
	bh=dALh1iG7fuskp7aM5oU0JtyGRuNZy8Fp2JAFqZoWLvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5HkrZLhfC8mMKCO8xbw2tNmQ3Y6P7t2t8Ar7PcJ6sLLYXa+z0lEE/gDO0zUvEIJHK4yHi+3qD4xRJY12tfvzqi1nXj8kp0Kbl+ZsxB7enTO2OQ24Det7220k/4t653cRs8Q1Yr7FuNiQQ8xm+0qhXlUU8DD7knraPQyo6dxcc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LPDwhaQ/; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B80d0g2701829;
	Wed, 11 Mar 2026 02:40:21 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022126.outbound.protection.outlook.com [52.101.48.126])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte7r44pt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enQnXot1zPHEQoUqe5psVabmyTnm59NKt0wNGdW5t0H9M4RECCGu3VnNeT9kqXneEcvcutq9WMI3fpySiWRKSsrR1KXK+gUYoQaEsX7ZYaBwIAJQ7QeftVms8aSKyQG0sCMmM3oYB0PYHWr89AUTkPZAki/uByXpKZsPdD8RqLsVThNoDNWVEB1jm/HEaYVecyEAFfg1xC+K9P+9n1b4MHP5PISCPa+dpBKAHeiqI55E5b1OtLAd36TWuSgEewVGG9YvEz2WxHiG79/vSZvexqfeAPRFQ/8vsjxhyv73KOck0lH0bnjIPovcjQv+7ewssk+GdpsPYfMok9EBWfG8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnXM22N9v1La0kTf/YPIkKn9+KTY0RthyWnimFCAHJY=;
 b=U6OmJwtih5GovwDaxKMsu5ylL/abO/nsCILp87IW11a9q13UR63lnrsXe67L8hnbRZuamOaGUQ+hWDj5jpApKeWRrc7robDGqDAkxLa4IQ1SuyaNJFi+I8No7pgagTvcgBs/m+CEfojQi7Ay/9Y/aRrkf1lS8x9PSUz4TsfNa+0ggqdgJlACss+n14HjWmpKcS0Fnj+05SvAM08/jxljcZYXrxJEHPW6t708Z1JYqwSwsX836ZgZi0HkSdR5JRK5pYYJ4LBAziLL3/wUcidXYMsNTy8ksraSiUk/c3eTsmLaQCQzEZqshp1iLlUQZPSBpTf0StDIJ3vxMbdv6+Qj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnXM22N9v1La0kTf/YPIkKn9+KTY0RthyWnimFCAHJY=;
 b=LPDwhaQ/OveipCJ1aYeb6iYp6jglpXH2gYV56ohSC3KCWXIttHso/nbIjSsB1mdnNpLjLm9O2kECt/jn5+1nMxqgTwTGJ0VWNsbDO5Cp7U7k3qDsrmvSfhqDgtJTqRRapglxS7Zljl5N7H62T9wyfOkJPP8m1grCnmHsAcdeb4g=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by LV0PR18MB927505.namprd18.prod.outlook.com (2603:10b6:408:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Wed, 11 Mar
 2026 09:40:18 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%5]) with mapi id 15.20.9678.016; Wed, 11 Mar 2026
 09:40:18 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Wei Fang <wei.fang@nxp.com>,
        "claudiu.manoil@nxp.com"
	<claudiu.manoil@nxp.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "Frank.Li@nxp.com"
	<Frank.Li@nxp.com>,
        "horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net 2/2] net: enetc: add graceful stop to safely
 reinitialize the TX Ring
Thread-Topic: [PATCH v3 net 2/2] net: enetc: add graceful stop to safely
 reinitialize the TX Ring
Thread-Index: AQHcsTsSfnOEjrUoKUuz//TUDEz1vA==
Date: Wed, 11 Mar 2026 09:40:18 +0000
Message-ID:
 <BYAPR18MB37358BCA45E9FFB570221492A047A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260311084105.3982037-1-wei.fang@nxp.com>
 <20260311084105.3982037-3-wei.fang@nxp.com>
In-Reply-To: <20260311084105.3982037-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|LV0PR18MB927505:EE_
x-ms-office365-filtering-correlation-id: 5d37bb93-e79f-4cf4-5a94-08de7f5234bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Q9OlhtKbi3dARSxcU94fFmaHqRxYfkU0ftMWAzz9FSXqXBhuR1m5MmFNivUDiBIsJiwmPcYJnb1RCUMy0TxnsevvOw4PbS0kQ2MVUwZz5hNFWj/UAqXD9dJO7bDgB+FtAdzRgk7YDbjfvmtMUAQmIvhcK3temYqr+s9IFBez2W6k7ysDyCqBPs+2ZJp5VzywRvSWt2PIECpE0fNOc5QzFvS0g+7aLA0tB5OBPq4l3Ss2pXo8OLgntCnNDplPEdWu3u1eP8oLD1zKML3PNDDp8Qg2A5TidhgfwKj9+iMlES8s3te0iq7drz5as6N1aZwGJpx4LbQQFE45JtD7Ogq7z5DiSM9ROIpE2klNTK2mKLoOYPZgEX6KixpPYyDipYRcVG9yVGFSOKR0lh1TB890GGP4p4azCL+WBFxdhNR5QdcnzSqFLoqfC0OD6YpCK0785JhrnSE9+oUMUC03VBVUzoLZpKe5hJY9RlVpN4rzDl1P9LOMOtL61J8TScFsjoccJcuAupkCa8sJ5zDcoMXzdR5ieaKUtcS8/tqqjoqIy+0RMqXrcgelEmI1GrtR+BtpigOlzriNiFTrIzDJGk4D8KVs7oqeSxhXvwQzTax8mkjf0m/bhNVXTSkUn7Rel6ZqdsYOjI82PM2ZenzYhu1S6WYLM5mCAcXeLy+AjDVa1ySM27vu5k1rf8hvOiptZm7UXKcsR1yYE8+Cra0og1KUvNrzrCg6y7neJq9UsCTaxTkB9+8npIloG5BwR1YZ6sVt9KDwg9ikbkPSXayZbbCYX5+fSpeFrwfwsrrmjb8nNbl9BGLJseVpGpveaqAVBx8/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?azH1hk2fL5O8kxceOhToTYbzF2o2KRwMKDq2jhXVU7Lp+JHz+8kXM0awInDX?=
 =?us-ascii?Q?OU0EOWB9vqyj2dUcJDy3+TM7UTJz0dND1eegnG+kSgOdothrsQb3WrB37MMD?=
 =?us-ascii?Q?q8ElDeILjai9McUud3EvWobno0mZ0L2ekNv/RBMf/jQOH+dC0wuWXxt9Xud1?=
 =?us-ascii?Q?lKOVml46DxEHbiengBOnragCNoNsBjaBLLzl61DBAEzVJMS4NbWU+/8jTs4f?=
 =?us-ascii?Q?LHWLhyjftTmA6ApgF4Smo4qEGjEN5tAZMEnmdmRt6fUNeXk9U6Gp0/68tB+o?=
 =?us-ascii?Q?KP/G0I/gVi8abSJRBd8DEdEDoYnpqCsTnXscKAgTFxOqO1124K+kBJMXKaGi?=
 =?us-ascii?Q?rztRWKCUZP/pdG8c5z5pS56uIu/T0JN/PARkT7K6+3+FBDEWEYZpzzJ3qyNJ?=
 =?us-ascii?Q?ihPpbSW63ethvnrnE/5m6IhKDljB/K1dIaADX06X4+FTa7uFNNyDEghORKD1?=
 =?us-ascii?Q?ioa0q6S3apE7LbwZdpTwkC3JgCh4gui+IVu+jbBzpee3m0cTUuxXU2q4ubpc?=
 =?us-ascii?Q?N0Yo2r5mZdkYPbDJPpmCyWg8+D6KCq2BfobCLQyZq8c4LhjkeXkptzDBBLJ9?=
 =?us-ascii?Q?6FSB5X9MPcM6R18EmXca/QkGVczGJjjP8kYTJnGpuLiLukvKROh9TCwbvEl/?=
 =?us-ascii?Q?8Mlv5BC58LLAwNcvP6Tiz7GLKLTHUqCqnK4zMvD8XdTyrPQfsXUfkKIKuGVJ?=
 =?us-ascii?Q?Kzys+J8pQ3qfSlNeEohjd6ip0nQKrhencjLAevpA0+PqQSEpJAG+TSAJ/2LT?=
 =?us-ascii?Q?1E5agHvJazXHtrjvqkxdpBqi/z35549xpDZhRQUHujbAJG6LzYZhg6Deb0uV?=
 =?us-ascii?Q?3ByOVLj2+hJWv6lKUVCPvzCVCRs+mUCbl+TKiN93hD31GnCaeRuD3FKAjDQf?=
 =?us-ascii?Q?RQqI1UnCegWNypI5PupaA6hCqeyRBFthIpyb9fCSbhBSN5e38SCoaNoqVo7j?=
 =?us-ascii?Q?IuplaBPNJBHZC55Lt5RVJDhjXu1sANIXq2UpiOd3x4e7PhmTFBWI7jrxONBF?=
 =?us-ascii?Q?k2asoeaQ0edFhpElGsqfwnT2h9i6d2rVkueJdUeOX1jA+UK/5OAV/Qr2tSQC?=
 =?us-ascii?Q?jb5ZIpYgMEDmdYyFkTuQy5PGtZJo1nW5PV/YIgMt4+Hjp6YGzWlnbCE533/O?=
 =?us-ascii?Q?ql4lk325qVVDTgyRZQ5WtjsD5O4zuCJkJ3GkH8TG/SuRvFkriuoEuP8aAJ64?=
 =?us-ascii?Q?RyooNxQi/mz+8I4xXFAPvPPBwf8WV8BfTKcQ0dOHITc/SQ/nQFEUE+4bUVLO?=
 =?us-ascii?Q?7yhkXpl8m8YhQT2uGO7HoO2uGN5jgDmyHr1iAjskCxpf3rLGilJyT+Vgdq05?=
 =?us-ascii?Q?KpGd+qgaI1eZ/z+oEe6kzrcdRpQUOpK1ZC8RczrtmaQhkCpZs9dhqIdcJa4S?=
 =?us-ascii?Q?bphl7pVsvi8a/jnp4onnjqpDSXK1upWhDTdh1kEO0MdhiZahdppBvQBy2P0T?=
 =?us-ascii?Q?DRAWe8DtJfKv2dBU8nBFsZJCI/9mFcvMXtGT6RPtx8sYWjNanFQCFCeziXhJ?=
 =?us-ascii?Q?F0CANhjLIWnxt39ApwRFeMQ8CY23TElBi4079iJDlLLLVzI4bnIaQnoIINru?=
 =?us-ascii?Q?cxZbRdoN3kzal7/5lwo6/LQCRwKQ9rTlMah64Mm8J2/CzD1MneqLqNXfKpkk?=
 =?us-ascii?Q?+ISNbzKoQjSYCqjp74OG0hgyxzMtnn80xSNbUCdCVCGa9g3/BJ2nn4O2hViF?=
 =?us-ascii?Q?CxTahwORNBOG2/VkaACVtqBBfnC7myUm43sw/34i8i8QR6qVIf/GQmmCf7X/?=
 =?us-ascii?Q?eLhDUK5enw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d37bb93-e79f-4cf4-5a94-08de7f5234bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:40:18.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuLW8sPdMwPjYIKjFWa85URuLrOIj2lxOJ+NHHCIfd7AG6ySFskabA81xvVgbstOANj0xamWVR/MqV7KI0ssyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR18MB927505
X-Proofpoint-GUID: f7NlusW9ytJY7rs1GUTiEjeQ9ZscO6i-
X-Authority-Analysis: v=2.4 cv=boxBxUai c=1 sm=1 tr=0 ts=69b13884 cx=c_pps
 a=mkJZCfqsFbehGldAc6fL1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=H6tCUXnCM2TtN9kE:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22
 a=8AirrxEcAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=PHq6YzTAAAAA:8 a=nEYSNSq2irS8w_U22MoA:9 a=CjuIK1q_8ugA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-ORIG-GUID: f7NlusW9ytJY7rs1GUTiEjeQ9ZscO6i-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4MCBTYWx0ZWRfX0p/7rVIL3b/3
 DmqDx30uYtVW10OPZEB6kVBDgCSkmmbp1h7edAtYH3CISp3QEhafI3DOh9nuNnsawpjv25L54Gr
 dczfaDl7N7j4LhiDgLjNyBc3FEJ2PBx4CQXTsNELz/AE8LZqrDTTq7t+yMWV+FF21MyZr/s3RA3
 JjcpL1nZdI86Ak7U6nTXFgNPLvX+0PhBGMaWm9H3EXjtdn6jYfWtHnTCNKqB2WiDJtXithTZUnW
 cUENvzyCDEDRMO2XWl51spJ9RjzuWck0vdFur9Iqqd30YpW6prtl1uxPagyu+JtP5J0TUGOf1EG
 F8b5A2die2wt31psK6X1vF8yy+n8aOe4ngtJm7y3KrUX8FBMHLYcARLkHtxQVBzVW66oHfEwCXX
 SYBrdZUZJEown5kncZXSz5QQ/PZ1dM1MLomYRs1xii41DEhZQBwkNLlJBEtv4JWf+/DWgMfDy9g
 w2F5kv2QZTUjQFsr/xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: 932C32620A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266569-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saikrishnag@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Wednesday, March 11, 2026 2:11 PM
> To: claudiu.manoil@nxp.com; vladimir.oltean@nxp.com;
> xiaoning.wang@nxp.com; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> linux@armlinux.org.uk; Frank.Li@nxp.com; horms@kernel.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux=
.dev
> Subject: [PATCH v3 net 2/2] net: enetc: add graceful stop to safely
> reinitialize the TX Ring
>=20
> For ENETC v4, the PIR and CIR will be reset if they are not equal when
> reinitializing the TX BD ring. However, resetting the PIR and CIR alone i=
s
> insufficient. When a link-down event occurs while the TX BD ring is
> transmitting frames,=20
> For ENETC v4, the PIR and CIR will be reset if they are not equal when
> reinitializing the TX BD ring. However, resetting the PIR and CIR alone i=
s
> insufficient. When a link-down event occurs while the TX BD ring is
> transmitting frames, subsequent reinitialization of the TX BD ring may ca=
use it
> to malfunction. For example, the below steps can reproduce the problem.
>=20
> 1. Unplug the cable when the TX BD ring is busy transmitting frames.
> 2. Disable the network interface (ifconfig eth0 down).
> 3. Re-enable the network interface (ifconfig eth0 up).
> 4. Plug in the cable, the TX BD ring may fail to transmit packets.
>=20
> When the link-down event occurs, enetc4_pl_mac_link_down() only clears
> PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
> doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitia=
lizing
> the TX BD ring at this point is unsafe. To safely reinitialize the TX BD =
ring after a
> link-down event, we checked with the NETC IP team, a proper Ethernet MAC
> graceful stop is necessary. Therefore, add the Ethernet MAC graceful stop=
 to
> the link-down event handler enetc4_pl_mac_link_down().
>=20
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENET=
C
> PF")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
> .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
>  2 files changed, 108 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index 3ed0f7a02767..1ce6551e186c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -134,6 +134,12 @@
>=20
>  /* Port operational register */
>  #define ENETC4_POR			0x4100
> +#define  POR_TXDIS			BIT(0)
> +#define  POR_RXDIS			BIT(1)
> +
> +/* Port status register */
> +#define ENETC4_PSR			0x4100
> +#define  PSR_RX_BUSY			BIT(1)

ENETC4_POR =3D 0x4100
ENETC4_PSR =3D 0x4100
Minor nit, are both macros point to the same register offset?=20

>=20
>  /* Port traffic class a transmit maximum SDU register */
>  #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
> @@ -173,6 +179,11 @@
>  /* Port internal MDIO base address, use to access PCS */
>  #define ENETC4_PM_IMDIO_BASE		0x5030
>=20
> +/* Port MAC 0/1 Interrupt Event Register */
> +#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
> +#define  PM_IEVENT_TX_EMPTY		BIT(5)
> +#define  PM_IEVENT_RX_EMPTY		BIT(6)
> +
>  /* Port MAC 0/1 Pause Quanta Register */
>  #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 689b9f13c5eb..53cecbb23a97 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct
> enetc_pf *pf)
>  	enetc4_pf_reset_tc_msdu(&si->hw);
>  }
>=20
> -static void enetc4_enable_trx(struct enetc_pf *pf) -{
> -	struct enetc_hw *hw =3D &pf->si->hw;
> -
> -	/* Enable port transmit/receive */
> -	enetc_port_wr(hw, ENETC4_POR, 0);
> -}
> -
>  static void enetc4_configure_port(struct enetc_pf *pf)  {
>  	enetc4_configure_port_si(pf);
>  	enetc4_set_trx_frame_size(pf);
>  	enetc_set_default_rss_key(pf);
> -	enetc4_enable_trx(pf);
>  }
>=20
>  static int enetc4_init_ntmp_user(struct enetc_si *si) @@ -801,15 +792,10=
5
> @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bo=
ol
> tx_paus
>  	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);  }
>=20
> -static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
> +static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac) {
> +	u32 val;
> +
> +	if (read_poll_timeout(enetc_port_rd, val,
> +			      val & PM_IEVENT_TX_EMPTY,
> +			      100, 10000, false, &si->hw,
> +			      ENETC4_PM_IEVENT(mac)))
> +		dev_warn(&si->pdev->dev,
> +			 "MAC %d TX is not empty\n", mac);
> +}
> +
> +static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf) {
> +	struct enetc_hw *hw =3D &pf->si->hw;
> +	struct enetc_si *si =3D pf->si;
> +	u32 val;
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val |=3D POR_TXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
> +
> +	enetc4_mac_wait_tx_empty(si, 0);
> +	if (si->hw_features & ENETC_SI_F_QBU)
> +		enetc4_mac_wait_tx_empty(si, 1);
> +
> +	val =3D enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
> +	val &=3D ~PM_CMD_CFG_TX_EN;
> +	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val); }
> +
> +static void enetc4_mac_tx_enable(struct enetc_pf *pf)
>  {
> +	struct enetc_hw *hw =3D &pf->si->hw;
>  	struct enetc_si *si =3D pf->si;
>  	u32 val;
>=20
>  	val =3D enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
> -	val &=3D ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
> -	val |=3D en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
> +	val |=3D PM_CMD_CFG_TX_EN;
> +	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val &=3D ~POR_TXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
> +}
> +
> +static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac) {
> +	u32 val;
> +
> +	if (read_poll_timeout(enetc_port_rd, val,
> +			      val & PM_IEVENT_RX_EMPTY,
> +			      100, 10000, false, &si->hw,
> +			      ENETC4_PM_IEVENT(mac)))
> +		dev_warn(&si->pdev->dev,
> +			 "MAC %d RX is not empty\n", mac);
> +}
> +
> +static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf) {
> +	struct enetc_hw *hw =3D &pf->si->hw;
> +	struct enetc_si *si =3D pf->si;
> +	u32 val;
> +
> +	if (si->hw_features & ENETC_SI_F_QBU) {
> +		val =3D enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
> +		val &=3D ~PM_CMD_CFG_RX_EN;
> +		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
> +		enetc4_mac_wait_rx_empty(si, 1);
> +	}
> +
> +	val =3D enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
> +	val &=3D ~PM_CMD_CFG_RX_EN;
> +	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
> +	enetc4_mac_wait_rx_empty(si, 0);
> +
> +	if (read_poll_timeout(enetc_port_rd, val,
> +			      !(val & PSR_RX_BUSY),
> +			      100, 10000, false, hw,
> +			      ENETC4_PSR))
> +		dev_warn(&si->pdev->dev, "Port RX busy\n");
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val |=3D POR_RXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
> +}
> +
> +static void enetc4_mac_rx_enable(struct enetc_pf *pf) {
> +	struct enetc_hw *hw =3D &pf->si->hw;
> +	struct enetc_si *si =3D pf->si;
> +	u32 val;
> +
> +	val =3D enetc_port_rd(hw, ENETC4_POR);
> +	val &=3D ~POR_RXDIS;
> +	enetc_port_wr(hw, ENETC4_POR, val);
>=20
> +	val =3D enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
> +	val |=3D PM_CMD_CFG_RX_EN;
>  	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);  }
>=20
> @@ -853,7 +934,8 @@ static void enetc4_pl_mac_link_up(struct
> phylink_config *config,
>  	enetc4_set_hd_flow_control(pf, hd_fc);
>  	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
>  	enetc4_set_rx_pause(pf, rx_pause);
> -	enetc4_enable_mac(pf, true);
> +	enetc4_mac_tx_enable(pf);
> +	enetc4_mac_rx_enable(pf);
>  }
>=20
>  static void enetc4_pl_mac_link_down(struct phylink_config *config, @@ -
> 862,7 +944,8 @@ static void enetc4_pl_mac_link_down(struct phylink_config
> *config,  {
>  	struct enetc_pf *pf =3D phylink_to_enetc_pf(config);
>=20
> -	enetc4_enable_mac(pf, false);
> +	enetc4_mac_rx_graceful_stop(pf);
> +	enetc4_mac_tx_graceful_stop(pf);
>  }
>=20
>  static const struct phylink_mac_ops enetc_pl_mac_ops =3D {
> --
> 2.34.1
>=20


