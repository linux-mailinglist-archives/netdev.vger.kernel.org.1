Return-Path: <netdev+bounces-179237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D1FA7B727
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A5C3B8C3E
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 05:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17361632E6;
	Fri,  4 Apr 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="W0pI6xZo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8A15990C;
	Fri,  4 Apr 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744421; cv=fail; b=jk+6Uh6r0/D5xw/T4mdzYgHjUAkHDr6wO0fK7o9Xu404wLAyjxqfMFflREA5nm7fvKG85oJ2aiQZBG4ojoPboGr1Lj693CsVEPV9/JopSaNKFxrX33KbiHzrLQOwglvV6kjFtfz58LrNYC+KdHVxnYvyLhN/yDaMVaDOnHY+gqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744421; c=relaxed/simple;
	bh=g0x3kfJI+mNn+MRRd4LSl41QrSmzfmdN5xWbE1o/HC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/un+K4jBpHRacPrhPYWSX/xR7CIgJn5xmWiN1NTsPr6KyAEGoCY5iGkp4lBpCGz085FjvVKkXYTVSs7UsfIbjsPLFh6NHdG8l6CeJtiPfCbWCXNc/kOTk+LHMgIXwfwsC5dQSYs/mIwum+4JhWYyHNzDL6sKQY4z+uyebnrFXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=W0pI6xZo; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5345FZT0030869;
	Thu, 3 Apr 2025 22:22:19 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45t94b008m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 22:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqZOstez8yfpCL4tHVnzssYMuHLGCTc23obLrI0/u+KRF39fHs21YfFtE8mbFAwywv9g956vBBo52nDFTxBtv6QpHmI5DpBS4fv8KRYcFWVe3qJDz1gGVQa0fu8CLVn1G0aE7PtlGEhQ/d4SPxmq2d9MaB9MdV8iUkTEyVCfC75TwaduoNXthVO3l+1pbcVm6s6ohkw6f/yIibcTp3ECIGqPlUTdOB6hswIvHXplI/OKK+bATYv90BY61j/X7X6HVEuju4r+9XP19dnZhWVioz81RZ9EZgSqY2/EOFrFmWpiGxJYpbjBLCh7xdqKyo+UDD+bFCwCw17jI6QjvKeuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLPgVA7hl8aZVxM/ul7Yd+FBBgmF8GcWUsaXRARiYzs=;
 b=mnT6/pxeI8K1F2JtrfiADCwaDPgnbp/CcTAWnHd0GKkhSe0r1EKJ419px0KZpRCGnfo/gRk02UWyTiDsXNy0pH784iqgNOLIXz3Zuh1Be4H8UeCkum4QA03rU5Ot9ORzf7ePmDf672NbOslIXDPn/7bR2KYMoxMEH1McyCsLaxUlzGFEDZUvqdmF/j2ZqvsiU50/+CpmzWqYPtZvP32S4EnGlNngxAae+Y+v7tDI148ifdws7sLUGx5RWPad5zJiyZLb9Ky7HVM4XKDHbRQJLmrcLAa/DZ2wT/YKc4701VN1hzB5XX80wKzxGGcDukaPWritT21Sah4xBets/IkiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLPgVA7hl8aZVxM/ul7Yd+FBBgmF8GcWUsaXRARiYzs=;
 b=W0pI6xZoKAKMc+L3TBbdXP6R6qnGVH4rqgNp0k59gkwo8zB0gwYW0sFhNRqbHnmONwjenuynfx7+Cj8z1Fr9ZlaNpkWjrV/7JvmIRpnzj98zXHHZO/uLHIFtkXvHiU5MnzGXvGPG911XwVPj57/ivclLElim5O6y9NZrzt8C1Hw=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by SN7PR18MB3901.namprd18.prod.outlook.com (2603:10b6:806:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 4 Apr
 2025 05:22:16 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e%7]) with mapi id 15.20.8583.043; Fri, 4 Apr 2025
 05:22:16 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Wentao Liang <vulab@iscas.ac.cn>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad
 Kelam <hkelam@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Thread-Topic: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Thread-Index: AQHbpSGH0QCd+ErTRUiwi0AjsSnhjw==
Date: Fri, 4 Apr 2025 05:22:16 +0000
Message-ID:
 <CO1PR18MB4666D076ED0162018D4256B2A1A92@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20250403151303.2280-1-vulab@iscas.ac.cn>
In-Reply-To: <20250403151303.2280-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|SN7PR18MB3901:EE_
x-ms-office365-filtering-correlation-id: 995ca811-ae7c-4591-05f5-08dd7338a9df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3iBL+Wy0swqEG181Qq8IftXF3ag4NhtyGq16+3lCnlcb33ppzd4me8OMRgph?=
 =?us-ascii?Q?TFsccOBY9/RC2uYeIniCgy+m+wcbNUMPnldsSFzBaYAL7APE9BVL3LZt9ED1?=
 =?us-ascii?Q?fHPUe2Vu2g8AB55SzYz7ZUpjzoeR8uOYtI0o4AhjSnLfGShTvRjfnRr2iHtR?=
 =?us-ascii?Q?+UzAyKtVjV8SIxCeh5lcKE5cYyV8+rNS8i/IJd+6Z+4NQHUTlUsh6Wfcv7cm?=
 =?us-ascii?Q?gMl2cytIDNO9qwUw1+hEBBZYDUC+QOXfEI6I7ZeavEFCyYAUnGfZn8ZhfzdH?=
 =?us-ascii?Q?H4U0GB86FcAzFM7QbBM2n1vKMNrbJBLWCYAawgsZKp1M86mhlpakxL1JGWH2?=
 =?us-ascii?Q?vwWf/GsR9nzhCc4pxMQjj51kpHs3Tlt+3VO5ldAMmROgbQb6Pxhi5JOYHxYB?=
 =?us-ascii?Q?MBFKqFch4RF9fXvzXjvYUXsecdm8QFeLrnNZRT5Hfvc1EYS35DDzJTq6lXv0?=
 =?us-ascii?Q?1g9ZKpuyML2nAAcpKdkD38OXxiw1fefRZcKmng7Vf4qkLdUWGuLTi8pZvI42?=
 =?us-ascii?Q?Llro53kbLiNPYdlA9okB+lojp6gZp8V3uJie0DbhSWjeS6Knz81IqIIHgRTJ?=
 =?us-ascii?Q?qgxT3ccMt46D5AEEF/2cM/VMnSjSSHjMZ6N1e3iBRnICnohHQC51wci8QuN4?=
 =?us-ascii?Q?Qw6D7kvJnbaS3u2FZgNdPMSBpQcKnoQ1gHVUasHSHpPyJJWAIX/sMynP5uK5?=
 =?us-ascii?Q?cOCNbn9d2JAUDvOAfG6FDyiUUzns4E8F0zHraW1zzm31Lqg2WeqN8lxtguNR?=
 =?us-ascii?Q?QonH0dCIGluPQwNSXI7F+Jt36Vi3K+n8ds978avG9Tmf6glrJmXjvjd4mBgW?=
 =?us-ascii?Q?EMeFG1AWQ8fiEhomg0BTRGm/DqhWGox5S6ihiQfYQUzEvU/LbTTFwW/lolYn?=
 =?us-ascii?Q?moqZIKEzNsXcxSrWhz0l3Mzum/egg9lcEHFp7DOgbw2ksNr2ykBvNN83zcRz?=
 =?us-ascii?Q?VVc0c9GN7uwHtCGF7cQN5AzS1NXILUJiGO5MI9MYlhKTrd9BQVSM2YXVmnVa?=
 =?us-ascii?Q?8/9arwqDqEl4maO1eQUIreqhKqMmon1YIiudxYNulCZ/u0rl/7KnDXER8vZd?=
 =?us-ascii?Q?hviw73cpePTwlf76GnDrPJoHwt5HqncUL8a79eZjxBheURzalm2GnEGrzOae?=
 =?us-ascii?Q?uhl6YP9pS7MFw96b6gMEJKzTk5QgFV8xYtSYJYwgmmyC5R27qt6FP5clUUNR?=
 =?us-ascii?Q?2055/gVKge1Vn+XMzZuSWyrgCSyYfuCMDKSARLoIkBP0umBa9ruO15PFy06s?=
 =?us-ascii?Q?ZvDCYBdoEQPjPpb9KaelmlOhczVmwD2uZY7C0vcWaBrIpukq30U9E1kcfPpy?=
 =?us-ascii?Q?ALjZug7lM/TsJgIMaxEivLjvdi1UO28OcR/4Q5THfmY591PCdqXdUcCWSV6G?=
 =?us-ascii?Q?J85fwXXCN5UBe+C3F20GnlOkrvcUN84/zBJS3NB9K/4o6PPlyVpje2ROk/RB?=
 =?us-ascii?Q?9ERRbmI9P5ca5v4QhFv2WSLYUKzAdJn7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pYSjEqN3k3JpN23QyGrejNSRkbbee31vsLLa4s/LSZiN/03SGFQeeJb427sE?=
 =?us-ascii?Q?8cJrNfhMOgAe9OY5BkTjmo4wKQhgHsaq3D2dGpgVCtJi1DWbgKCu+8xHo4k/?=
 =?us-ascii?Q?AoHN4iWx8RCCxabuiZZtmtQh9ntZfBrh8fXSmMi/u2dpW3t/85lJoGer6LyU?=
 =?us-ascii?Q?+d8AXPTOQNDERIx88scANzDI5IdYisyGA6/0ymbNBB5g/tterdi0dgMqvmHt?=
 =?us-ascii?Q?2zmGEGPRjgFenbsrn7/tIYqi8Vr8QewOD8tr64shFjZiytEO1qOKZI4pNvrf?=
 =?us-ascii?Q?8grTcUtBom/JKXnD5qfMHQg9yVgJVTHoBXR6pHcdtsLqyHUqqxd4+0ON/fPM?=
 =?us-ascii?Q?hTSyEl2xJFsQoe8wPch9Y/zz3tWacwdnnAlPI2aiPLU0iIJS+mXj/PLui5By?=
 =?us-ascii?Q?7UG30emxh8SfzpZvecJ6UDmxBhzS/2vhxNPG2Miq3+QGb8OLPWOxZ6wZmuig?=
 =?us-ascii?Q?arxd3Y0uVihK4ocPl83VgDDLDDS0Q6IFoRW2q8gHBg6+B7h0eLQPon0oxedh?=
 =?us-ascii?Q?l/cJHqgLzItQI9Cq8Ir28Awit/bo2Sg/kkx4V+FF997qamGvvFCu8iv4K+fl?=
 =?us-ascii?Q?uyyvZI4CIhzn8siikbVet9VF5mf2LdIJF/KIzQihDWOXW9S2AySfCPVP834E?=
 =?us-ascii?Q?Zijxf9ZVz0ZPETrGGoJlDjNEd4r6Ajn3oJ43pA7UPvI06Z/PRGYlLToRVDBW?=
 =?us-ascii?Q?oB81LXWmZgWrDqvHLmu/tvo8HYuJYDTGgxbiun7AK7hnxmGhGhkrbV8P9QNc?=
 =?us-ascii?Q?x11y1dEeP4TfdbHg0D6j7SvUkH7tHp2E0LmaOg2jy0Dxy9/XSDF3Bm3/xe6q?=
 =?us-ascii?Q?PEyEYkr7NzwTKthaWH7qhiSPLtdlc62x96Oj3tJS2TbNaN770HzTesR1rlQH?=
 =?us-ascii?Q?APydtnZDZilFJfFlSDJbmLj666o7YisItIVlN57PUJc4H0xKdinb6IJWYbZy?=
 =?us-ascii?Q?L8RFfjKRrkm2V7mhfRhnhPm0js5O1eKHr4YOTH7uscfR4bER9vnQkmbcdiJK?=
 =?us-ascii?Q?JrYzYIn9mVVlt2bkd5DfdT2XPvzs/Gn990beeYsErAX6yOwxstkJ5m1cjjE0?=
 =?us-ascii?Q?WTK+yPMSfysSxgk6OmI5q+N9t8DMbzItZN41+ezakOzXDYUbAJ1vStgbMs5b?=
 =?us-ascii?Q?cclzpEZhPE5+Gt3TVB7L9k5KJVPP/XB2OPjfD1OJGQ+PfT4r0tM4Qe35K4fr?=
 =?us-ascii?Q?aRH89rIhsP6ilotbZxPSDlqx7GeABHluQ+fhnOSarqV9u11dPtKfTjf/twIt?=
 =?us-ascii?Q?qaWgPH0Rt4uH4LdQcZPbfhrgX+KqJh855ol8FjEgkLZh0lYoRCeo8EcOaf8Q?=
 =?us-ascii?Q?1syTGJTIGi6oqBNjIAY2lTAGKB6uhhVrumsUwd9InULl+RMNYfakiY+PFpEy?=
 =?us-ascii?Q?VMuu/EWhxoEvw3AaSkxrc7CSo85rfD0EDWSQ3IibezdxrqEPm1d3qrSGKZoe?=
 =?us-ascii?Q?kV2qk/79XU9o2phGeOp9GKAemZuAcM2B9JonCxFZsQbmpDEcOBoBqXqe8ksa?=
 =?us-ascii?Q?mTfYRlOajCMu3i9hpMp6dAXx+FhJBfqrDbLOA0v/ygAT5BXF4uOeSTWs0mYR?=
 =?us-ascii?Q?fn2DIHHD9IqLCUw9CpXwgSNfsli6cRupsRTqNgsT?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995ca811-ae7c-4591-05f5-08dd7338a9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 05:22:16.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rm9VXfMnfkMLvpSI9D3Fk0v/CE92TsVjVSdgZF8o3NxCF9xe864Tr3bSod1+vOSaSIZRSyvT43wDG3FkMoXwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3901
X-Proofpoint-GUID: HvSCv489tYzWINwYD2FEHJZn8ymAHtYX
X-Proofpoint-ORIG-GUID: HvSCv489tYzWINwYD2FEHJZn8ymAHtYX
X-Authority-Analysis: v=2.4 cv=CO4qXQrD c=1 sm=1 tr=0 ts=67ef6c8b cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=zB_nYMf46UciNYmz8joA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01

Hi,

From: Wentao Liang <vulab@iscas.ac.cn>=20
Sent: Thursday, April 3, 2025 8:43 PM
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula <gak=
ula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasa=
d Kelam <hkelam@marvell.com>; andrew+netdev@lunn.ch; davem@davemloft.net; e=
dumazet@google.com; kuba@kernel.org; pabeni@redhat.com
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Wentao Liang <vul=
ab@iscas.ac.cn>
Subject: [PATCH] octeontx2-pf: Add error handling for cn10k_map_unmap_rq_po=
licer().

The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
for each queue in a for loop without checking for any errors. A proper
implementation can be found in cn10k_set_matchall_ipolicer_rate().

Check the return value of the cn10k_map_unmap_rq_policer() function during
each loop. Jump to unlock function and return the error code if the
funciton fails to unmap policer.

Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offloa=
d")
Signed-off-by: Wentao Liang <mailto:vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/cn10k.c
index a15cc86635d6..ce58ad61198e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfv=
f)
=20
 	/* Remove RQ's policer mapping */
 	for (qidx =3D 0; qidx < hw->rx_queues; qidx++)
-		cn10k_map_unmap_rq_policer(pfvf, qidx,
-					   hw->matchall_ipolicer, false);
+		rc =3D cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, fal=
se);
+		if (rc)
+			goto out;
=20
Intentionally we do not bail out when unmapping one of the queues is failed=
. The reason is during teardown if one of the queues is failed then
we end up not tearing down rest of the queues and those queues cannot be us=
ed later which is bad. So leave whatever queues have failed and proceed
with tearing down the rest. Hence all we can do is print an error for the f=
ailed queue and continue.

Thanks,
Sundeep

 	rc =3D cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
=20
+out:
 	mutex_unlock(&pfvf->mbox.lock);
 	return rc;
 }
--=20
2.42.0.windows.2


