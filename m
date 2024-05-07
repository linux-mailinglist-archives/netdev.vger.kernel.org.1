Return-Path: <netdev+bounces-94069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79D8BE10B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6531F22756
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57F1514F5;
	Tue,  7 May 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="YhYe5IZD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1886522E;
	Tue,  7 May 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081627; cv=fail; b=jzFGWO2OtUH8lubSzJUFFNiQyYRU/bY6HzkIgEHV5dgAa0RusR41FWBmnUDCy9reHdEzj8ncm9/jl1v1U+c7kUreGsdqoGvqYFS2nonksP3D0lq9uiXJ7TKJwmPs0ro+t6a+8lBdGiiYbugN6NfLjDbQjBCZu61vGr1Vw0UJsUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081627; c=relaxed/simple;
	bh=8WkP9dqWDFyeifukTS7nySYpHQUwSH29tjwn9Gmm2aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DuGP1CuQrgRAaB8DP6fzxzVdLru4uTwdCGjELtRNZRG6tzChZAipQ+mpWRFVgHrr1Qj+ABWoFgIne2SxzsN3Bwr4ZnBiMvfA+LVDGeZzDYmFjkuAVwhquCZ0Kmn4r9l/uhE9nRApKDY/RlkEwXYVWxpGbIrpd4MYg+L8OzlhmUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=YhYe5IZD; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4478QxKR005025;
	Tue, 7 May 2024 04:33:23 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xygt2rfh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj6GiMYvZQEdwBAiZfwtdZwmRTLaMz32Lscnmh0BaM9aT2DEOzLcKo4tyuiq/VVMuMbEQAvtCb/j22SMjwgUvgxYs6y9gpo/sdG8cU3z6XfFh+bMSZDIl7dTfa4k4GQj1xbmEqzWUirWXPWyQ3b7gNC1tboDQKnq0ru/lNpF7oiNA3AGECJdupF0BJiJo+7OkvBZGj1kQsfQnamUvheS3LzV0MsrEZt8VzFQ5HurDs8YQ8GLZ2pZYvmxK2TDNRxaXf+pxy3GRdDZNFLq2M56rGRCMYAfyiuzIoonsVUaJ5SWByYqzYvsIPyBbhvRW5AOWTe2+9792s1YngmJolWrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdPkMqrcyzOHzjqJ7iKFnlVPoxdkGF0xjLFAuUvsBA4=;
 b=KiTUgPSKusXX3BFlz3E1/CvheNwefJF3wLZnpsd6aSG8wneksx3nMlkaKtoWoP9XmwpNkkVuaMxRHDQxCOi0QDPXoGqXX4YGF0iQ76PNBNryaXP2/Wazynrr5mFUZ6aIjIcpz1GUEZJAeWeS4/GYALRSFha703KoMYexGLkETFA9r4lzKBpNQlTQSc6JACkDXT1IDx9O8XVAv0MuD40FT2IGsRiv4VpXN7Hbh5krmKQmJfaNsRShZZyp5A6RR7zSElIJgMwZDKibZFd/7MPyzDpSVk5zCkquIJ64mUHwjhSYeOTq3ThJx6Z1fU1e+z2WOtPBEUS32lc2aFJ/KXEc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdPkMqrcyzOHzjqJ7iKFnlVPoxdkGF0xjLFAuUvsBA4=;
 b=YhYe5IZDswI0UYlegvmw/Kg8YqmETVvOdvZSpfS/nG2Zsc6BtXAEfx4BxwRsGzqmKCDHpGNQK381PYycdDxHCeK0nIoi5jqFKp21qdfoTQsQHzBs/HVSQI9SeQuV/Ol04xsipvOkvkYULdk5FAFbfYXs7QYjRqDJqVbPrdVBCQY=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by BN9PR18MB4265.namprd18.prod.outlook.com (2603:10b6:408:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 11:33:19 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:33:17 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Felix Fietkau <nbd@nbd.name>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn
	<willemb@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] net: add missing check for TCP
 fraglist GRO
Thread-Topic: [EXTERNAL] [PATCH net-next] net: add missing check for TCP
 fraglist GRO
Thread-Index: AQHaoGPJEB2DdFr3+UCCiAc99tDRbLGLo4vA
Date: Tue, 7 May 2024 11:33:16 +0000
Message-ID: 
 <SJ0PR18MB521604310B1F7DC297C2870DDBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240507094114.67716-1-nbd@nbd.name>
In-Reply-To: <20240507094114.67716-1-nbd@nbd.name>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|BN9PR18MB4265:EE_
x-ms-office365-filtering-correlation-id: ae34a1c4-203d-4cfe-f7a8-08dc6e897d27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?H3VmVAJzG2zUp29EsYF+UeC19E8pdECVytvWw0z3XW1f29k/Qh75l9DN+X8E?=
 =?us-ascii?Q?6IJYLBidcL+kzOtwtXIoxE99gRIc6U8Doeazj1abMrBFNi4nozz0co++IvOb?=
 =?us-ascii?Q?Z3b15n8Ej4riVx+3bZxla8QVnH9x9oc8sU0smP0OnAP4jZ4SySCmKP2wuZYZ?=
 =?us-ascii?Q?hSRSpT8T5JJH5k3L9gdWFC4DlbisuVsN4meVcu6YBbM1Fte0np9qmVxPyr6U?=
 =?us-ascii?Q?XBEZGJuSEQ0SwS04rWJYTWkD1wzX+ei3YM5kTAzMlEhK3lsRBhrNmXDDUOp+?=
 =?us-ascii?Q?YmRIArRgV6I/tfpNatXqDvUN2GCTEROJehCOuzRgCkMkcKpQSGurXE/f4Qff?=
 =?us-ascii?Q?kiwOUjBuDcx8TT/j+D9UwfGwoxNbHuS9XPoVM7qysdyfz4aoXBdJVCXslhMK?=
 =?us-ascii?Q?xQeDyjrdqdIaUY1NlATvCbIs5a/4EednT/9n0sTs60M+IuppreJlVbaEGLWJ?=
 =?us-ascii?Q?6+cjb3287n3gB4oyGB0sehO3vSXgaO99uDGJczLR1Ndx6rd664fql4Ah5rOo?=
 =?us-ascii?Q?ghX3NmEUXIBBwf2VA4UDiV5+ICFgkMPDvOPJ88giwZmnC7/QBFO1gSlhFWok?=
 =?us-ascii?Q?FofKbxSSKOo3P2YsXWQQSljnncPdPK/3qfyOi0UzLFQknLmOsaSCdXW0QpNM?=
 =?us-ascii?Q?ap8XJExCO10qbwBZdvkVR9JSIsh8L0kuLapt+Zov4LUnbr2gNtesutXs7RBA?=
 =?us-ascii?Q?ZDgm9U4pIBm7OQjNCd2H2HKsEZajM2LlUNK/yoOwQ6YJ4ydc0pR2twLltKfp?=
 =?us-ascii?Q?bSq/bFiKWoJNrX1N5nytOXGC5Jt50GFnHJT+4aL5uGRAWjvgV9ZbmAeuQ4c9?=
 =?us-ascii?Q?CMWZvPlN35STIfZqMSgpsD0Pb+yKeoZU5Ijbx0e0uvn6JX2pL6uiWwDjAFlw?=
 =?us-ascii?Q?uRkkUuP8BvBbGZXVizpfrmuz3iSdwaOxFuqIaLQ4g7NaPeQsbCDkGfhMtQXK?=
 =?us-ascii?Q?LDIEySQjwzrdtY3cH/rtymzIUFBeHNf+nlisGMW2W7YiXV+mPxBIpV0+LueQ?=
 =?us-ascii?Q?Es+DIcrF2CcTmthQalGFfmSgBz3mTWM2Y/JhMNBTreKR7n7n35AdnpPe8XSm?=
 =?us-ascii?Q?c7GrmYcTcyG+uBiuWoCEidEApLRqkaQ5FCboCD4g9KEmsMiSwQVd0bBIa2Ok?=
 =?us-ascii?Q?O7DWm22VQ+2ZoSuA0c3NjHAoVkpAaw2zfClXgMXR5hiIpuae37GiIWbs2eT1?=
 =?us-ascii?Q?ai/SmsE5x9tgGWp500rv4XjoB3Hl00nKOY2mVgmaQ8CGyGJ/ueA/N7WqzUHv?=
 =?us-ascii?Q?/LtD474ryCwSO7c4DompqVJS5MRK9f+q26P+R+vw1ryw0VBmWyp1pFzVBJ0W?=
 =?us-ascii?Q?WNNtvKS+lEuvLebcD60HojbvYy2kUJXqcRlGed3yHglpcQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Bcm3GZwjt+Xej5pc+nn4Tpxuw96+SUjJ5wv9NdJfFh2IKD8oJC0KWWA1QOdO?=
 =?us-ascii?Q?UcHmY7hesISKmovDue5GFmoRfiVIQcsaM+1bHNdoLkj7NCLYWkbsI81ZBkFD?=
 =?us-ascii?Q?TX39mqXtCu2VrnEDBBvXlaxYdd0/bcrwbKd+iGGtHyYuv80SJ5VpdN+zs13u?=
 =?us-ascii?Q?a8/kgUj1vqREJ54mAkB71iiDYYRkWlVkAnsVRXhGFRTPryx8wKqaE0CQcuKJ?=
 =?us-ascii?Q?ge6HVQQ+Ak3BeLd2pbwfULe17MM+Tp7xz58LB/woXCgpVNz07Zts/O+jmWAY?=
 =?us-ascii?Q?pb+0gzM7l5WEV4C3paTkK35u57MGBqxA+T7KGTOCtDcBArYTWctla7EuyIcL?=
 =?us-ascii?Q?i1pQMsQw4iJIjwaJ3EUVSpjpFomE9r2jCffI1l6Y2ja4zp+TMuWeHErbRRJJ?=
 =?us-ascii?Q?KmdDr+OQuHSw1EjBSz/3sKsTOwHKqAvWiI2t0+ir15clcCN+T2dvoIHoDka9?=
 =?us-ascii?Q?VyTnM00lusJCnroHXpFhG5knUlJZ9y22r6hnE7I6gWaJ0INQl5uDLv6+qvg2?=
 =?us-ascii?Q?C7P9ScaNmXSpXF8RbzcbnXbew5Dxshu/O007rNnyiINeI/xolgEXETPo1u11?=
 =?us-ascii?Q?1UN5K3i8eCAaAHqSVZYzVCspiFZTXeAfOcUkr3nOBU86OFhEssGA+FjA8ryP?=
 =?us-ascii?Q?ppUQkrdveTTFig20zBfM+Mxtms15Hert6q++c2hGvuxVtNYk3/OjI3a/f92A?=
 =?us-ascii?Q?4sRJN/z209hPvtd1jvDKbUt20//JAw56wjrXWB89Uhjx4Bm0zM3Gyha5mHVA?=
 =?us-ascii?Q?5yGgIdJZLzl7YP3hbAzUPWnPEwj5nKgAQwAWL6jutqEdkJ1dKJwPK2S0Frj4?=
 =?us-ascii?Q?RRMpLvBtQpM8oQL1B+GXDVt6p11lIBnQSVkQL9nD4Cn3OI2/E6iwYZGH9gDy?=
 =?us-ascii?Q?eMond2ugp1PWsFmF1c1wztRg+nTDFv5PGNVTncSFO+Jm5X8bidcofPIPRJ/g?=
 =?us-ascii?Q?VfEgsnBDUtw1io9xH1HMfNJyWLAOnf1U5NJZz1ftuvt+W8KU6n7UGYmFT9vO?=
 =?us-ascii?Q?vDzmVhKvb8oyYUUi9gcBVKJHpp++HrWbeelB6V16W7tBjzqZBOYZ5Ur75nqv?=
 =?us-ascii?Q?D1gWEAQjAvseUdVGC9sKuQbhIo2PeUS/sHjsRytif6hK+pW46hiDUX8rsleL?=
 =?us-ascii?Q?2YF1b6y9fgBDK4Q5zEubddtM9lYWb0nWTZZdTAPe6uRIS/g71DVCK6y/dKmn?=
 =?us-ascii?Q?XoWw11dqabhVNOqLMD2Q00qF5FmlhZ6aJJHL60tzX9d5aKH+jX6ywVPdedqm?=
 =?us-ascii?Q?7AwY9+9x26VIl/cTVFXsMCHWZMg4DEoGNQLUwMpMRwSXu2jcg9maKM4JyhwE?=
 =?us-ascii?Q?pJmlGYxf+I9OsShPAouUT56aw/qFP/o5lzcLOQtMedwv1FoTrbqFh1aveQHr?=
 =?us-ascii?Q?ERCBCaU5xdjsVQddbEXvNf4HDEVHJZ70bKtf5mwNPO5OfkX1Rzwfr7leFdL4?=
 =?us-ascii?Q?acwap3lPGbdaoimfl4vwdArmAJf93xPDBxPGK4WU+U/r7k6mfo6vagf0/Ugc?=
 =?us-ascii?Q?FJPlUQVENs26Junz5qr1I49bPB9F/3LdwY9XTtO/Y6n2Y2GwRCnsw15mYsUV?=
 =?us-ascii?Q?o7Cjjvr5GwLyVaMHGSWreI3BnROV1dSb4X4o3BxM?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae34a1c4-203d-4cfe-f7a8-08dc6e897d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 11:33:16.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+oyStDZ2FJGaOFIL1q66Y8ML+EsXco+phWqoxH1Fw9lijVYD8tGR0dM5DnURA0RHPoypqYgsZLLYc/wQuD+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4265
X-Proofpoint-ORIG-GUID: t27bbFJKUGlZFrFFFEHQGUMaPgYhGYkG
X-Proofpoint-GUID: t27bbFJKUGlZFrFFFEHQGUMaPgYhGYkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_05,2024-05-06_02,2023-05-22_02

>----------------------------------------------------------------------
>It turns out that the existing checks do not guarantee that the skb can be
>pulled up to the GRO offset. When using the usb r8152 network driver with
>GRO fraglist, the BUG() in __skb_pull is often triggered.
>Fix the crash by adding the missing check.
>
>Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
[Suman] Since this is a fix, this should be pushed to "net".
>Signed-off-by: Felix Fietkau <nbd@nbd.name>
>---
> net/ipv4/tcp_offload.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c index
>c90704befd7b..a71d2e623f0c 100644
>--- a/net/ipv4/tcp_offload.c
>+++ b/net/ipv4/tcp_offload.c
>@@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head=
,
>struct sk_buff *skb,
> 		flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
> 		flush |=3D skb->ip_summed !=3D p->ip_summed;
> 		flush |=3D skb->csum_level !=3D p->csum_level;
>+		flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));
> 		flush |=3D NAPI_GRO_CB(p)->count >=3D 64;
>
> 		if (flush || skb_gro_receive_list(p, skb))
>--
>2.44.0
>


