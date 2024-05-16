Return-Path: <netdev+bounces-96712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0EC8C7436
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C514A1F244F5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6114386F;
	Thu, 16 May 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vl2QTcgx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8EA14293;
	Thu, 16 May 2024 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853444; cv=fail; b=L7K1NqN3hQB/ONxc8VyW9h7Ovdg8YvrW87Ufj+hV74qLxAVBOGvI/4wabJvJcAE83hQcuHpH2ChMN9kqAJkfp44RFQPhkFfAG0wSQnAZb4PcoBM9MO1Uztk3U9g5XrWxJuUH7aI2EqUhv/KdjbzPrNz9b45MjJGFvZxFVuMIHlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853444; c=relaxed/simple;
	bh=IdrFGpYIs0aPZHxH4U0L8xeCT+7tKc3E4HzOmFdJItU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o7kW+HFR8jfzxciGBNiv/Lb4tWEH6AeLub3RWMP1N3mW+gIfZMb6H2n9dvcmwbOAdkCbfzVMWNY36LvEG8V5KTSMYzpiOIgz1C9TXDUIOpQkLcswgN8cy6beBCVY23IAh7q1/U4y7spRcWfqszEb3xwe7bSpEXmDeEL29xyL2GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vl2QTcgx; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G403ku017213;
	Thu, 16 May 2024 02:56:29 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y5aqxrwm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrhoMDh1AWFVSdX8QPjDPOxgDvah7xu2YCLFXD1Xp6FU118ZWuW9ToMyHdoEdR2woEgJco/KG3B+cY853yKcfWoSuw4POE9QXky1O6h3odCm2PhXEP3M4t40ZAY1gHViHu98zQWSiNlgtOPYWc3FB08MLJCv7ZU0Fh4pdc4hMtfFM8ILd67aO0lHOZ/KJWdKSLz4raU1sB26uXzur5vGDnrr3xa0f7EaFPET1diymgEhurnyABgbW8rZtC5uyJN7FqVmIltEXNtIj1p2k+esOd/0MWHdUxXpeaIfXj2G5jnv8FkaBcTUbrRyf53Zee0knKMZwqgdqhXenfQILzXhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtogAQBGdbQp7v7pJjNF5hvP5bd6cN/6aCd6VzpGpmI=;
 b=MEpIMXfq4Lhy6CXJr6vndf5HtnJN79rwiEVbkSC/1k82qVUUgGY80j1DXSpuC4WITeyukm4va3aCpTbpMHJ4ED8anTRafSpGfGmTjJxck5P2V6m/NnJphigjiBYgIv+eaR/kH8CkrT7rmwwWTj0K3wYdj/1gnjTNQZ7yOKYEzBAU3VLswP8W/Ycdwt1j76M6i0Xf91GjOYtYh33a6SeObkV/osJwuZU0o76uoFxCuCK+zanNa1X8Hx8dAngn4PHySKfSN6UV5XUA8bhO5eeM0jEQLe7J//R9IVe9Hj8NuaLcvYZWWKJaQgZ7gs9JJf/GeCujRVgrqwienT868pptIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtogAQBGdbQp7v7pJjNF5hvP5bd6cN/6aCd6VzpGpmI=;
 b=vl2QTcgxn8dmIWFMPrNEks+5L2o6ODum9fDNgUUhwJ5k6r/OXMbIDYYamxbqjdlEOM+X9pBPlsBLt0nyHOzGneOU88Gdyf0T6pJBwIk/LhSTXK/Oo5yTi6T4BVfI5+AqKqJ6Ac88kVTqduB3PJxfECpS4xMEI59foGBVAh0bo0I=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by MN2PR18MB3605.namprd18.prod.outlook.com (2603:10b6:208:268::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 09:56:25 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Thu, 16 May 2024
 09:56:25 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Chen Ni <nichen@iscas.ac.cn>, "nbd@nbd.name" <nbd@nbd.name>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "Mark-MC.Lee@mediatek.com"
	<Mark-MC.Lee@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: ] [PATCH net-next] net: ethernet: mtk_eth_soc: add missing check for
 rhashtable_init
Thread-Topic: ] [PATCH net-next] net: ethernet: mtk_eth_soc: add missing check
 for rhashtable_init
Thread-Index: AQHap3dQVMNVjNkdZEasWxrQ03s9qw==
Date: Thu, 16 May 2024 09:56:25 +0000
Message-ID: 
 <PH0PR18MB44744D577E2114AA1B72857DDEED2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240516092427.3897322-1-nichen@iscas.ac.cn>
In-Reply-To: <20240516092427.3897322-1-nichen@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|MN2PR18MB3605:EE_
x-ms-office365-filtering-correlation-id: 5bad6d3f-70a6-49c6-135a-08dc758e7309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?lqtIwCb6M8NZ1prkKvtaUN4hveQvizC6g7fC6fZzq2GTwU16MiyZjnO7EdfF?=
 =?us-ascii?Q?i+QRlxQK/opDvTF26m6QR5T+JUUdggMPQz32Z4Dokm5pcg6l8xb/8uGJ0rhB?=
 =?us-ascii?Q?FQ6VjvE9+YPt6snMlTcUl60T+V/3JxXJkUPk9clA+l/fyekhOQJazuLnDaUW?=
 =?us-ascii?Q?T2SHtuurMkS1yqRV3poMo5mGyP02MQBeKES4g1tcLQmi/0UQVr9soy7Q3ZKl?=
 =?us-ascii?Q?H4CD7kHvhxqKJhjZN9juhgzpCaOyhsBktvDjk80XQy6QwcKaSIR9tap0hRsX?=
 =?us-ascii?Q?R+66/D8Z/Oa56Nyua0qvFsZB2ThUGAY3YZAKKgRzhA0fh9O4NdPVlL1P7Yhl?=
 =?us-ascii?Q?MBtoHQGP0lsC2eRRDjV80KUlkiokPPFj8Hp/E7ewZ2d1slfYJa8uTV0hcGlE?=
 =?us-ascii?Q?eLBPP+mTSIB+iwbCkpGa+o5g8xQ6P1GViljnUjfcUUV6LMeQpDWfKBw57tiN?=
 =?us-ascii?Q?bhWYMVi3kiU1hCpg0/5gEQdvEFuOLUIBTDZ6g0RJTAqY/VLPB3W+AekB1omb?=
 =?us-ascii?Q?FPLBE8GiX7t4ggWH23z03robaTvQtUPUOaXIIHHWrDfJE+vloH1cGCjZdP+O?=
 =?us-ascii?Q?RFcL7MJ/D0ZwK57Phgx9MuiyQuuedNnUeA5uEgRf3FfJAWb1s3IWhsSo2AZc?=
 =?us-ascii?Q?Jyo5z6bvG3oHEW3AqFaR2RzaO6LdPoO6zfOKkaWoow5BetLslBzOO3N8p5S3?=
 =?us-ascii?Q?LCO8BQwlqo9oBujATpHMGaMNpHAqZqYEH2tIrC37nbuX0/HeD0WK8Ae9/dmt?=
 =?us-ascii?Q?ivreOTkfzbCQLJPQarizaqCmySW8+BAyJmfb5KdcKkR1+jsq8t5G3mEpEE2I?=
 =?us-ascii?Q?jJMw6s16s2KUJC59RsTrD4T09pYqhrfgBioDk+c/SbZnVGR9uQxuasluQ+Dy?=
 =?us-ascii?Q?h461feF8cTb+MNs8BveCtooi7blGrkHGdLjrurRa/U94wgbIHLTAp7hGD74Y?=
 =?us-ascii?Q?PQkPXFFk2pCHkDwdeb9++MhwpImUNXytoAtMmShHQFqJVfDGkDpJPbZIkFq1?=
 =?us-ascii?Q?6HEa3w1wJiH/m/FnWlEtf6zd1P29p0ExoJLXRod10QPd2iK/9WJaa7R4sIoH?=
 =?us-ascii?Q?QyFDjYJYzoEMvg+X984QOAKmDUUUlb+e4CK7XwJ+oayqQ2UBHyIfve06JMJx?=
 =?us-ascii?Q?l3oGJ7Ij1laHOQZLXwl6wkYswhprRf0tC8naMGI8xZsgJ1dHvoJfuaRRwp91?=
 =?us-ascii?Q?CtEnsgD2DVCjIvoX4mGv6gzBNf+s7N2YxPbvDW+GyLZqpkp3kfeW/3XRfVjU?=
 =?us-ascii?Q?+Z0TKvA47wjEFjOXWt0H2OlaCIMQazI2yIzg2Zy5zae4MhTxSQ2WUcoQkABD?=
 =?us-ascii?Q?pOgUaW3+UK3imU7Bs9kKPgS62Qz2VpCRzoESnD6FGE2KI+h8MRg/uUpG8fJr?=
 =?us-ascii?Q?0w/Z0RM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OGPtNnYsGPao/8/WveHfgUzqcb++irPKLtdcWRJXIHbjMCqZDDgAG8qtkyqG?=
 =?us-ascii?Q?nQhCUi7ruQ3ECgyLMx94IFMBktGTt0vERBX8xJO9EFjUJFnS9Xh7Zd7r9tNM?=
 =?us-ascii?Q?uA1I0wYqn/FUqZM2n4II3AhJiJXpY2OMytTkADu4MQeuX6KxefpOSvyb2lfU?=
 =?us-ascii?Q?fS/3dTosuq0XgYEW0VcEsE3O9ElJUF0E/pkQC9MG6zNc5fIsLks4cd57MSf6?=
 =?us-ascii?Q?UMheySMJ3na89rQZ6If/vFXbhQ/x4ZJDDMoGAgGa0bf0tstRVbi3Iv0elWN+?=
 =?us-ascii?Q?j2++tW7Oq0R86caMF3neqIRiaLKnLtKwi/dcGQyY78hAkM+Ir/kbeSbmgDus?=
 =?us-ascii?Q?aW6CznK1JQbXKBc9hDfvQeqYN8gg5sz6rrBWdl9c9MQRlzw2lVXvRlr5JB1Y?=
 =?us-ascii?Q?MSdKWHKxOwH1TVzOXCzufFtWAWPEeY3DP9zN2+MJ5BapLSIxPxw4rvEX0Yib?=
 =?us-ascii?Q?/vGzXYiJHExXpMny5g0PdMEIs99WGJGM5kiFti/yGRLqQrbmTIKfFb3gXmWP?=
 =?us-ascii?Q?AYoq6/pwUai6Py+Dtgr2ZIehNrbcgO7b2nWZRMttWuFrX4EIlhSIwXWS0MuE?=
 =?us-ascii?Q?mymLxHrjpWMnfS1LbSIK4bPI8w29/A4PbEKp7DH9iox86Y0bj//LcpreeuGl?=
 =?us-ascii?Q?AYK0X7VKlY4u1BSMqCm5pT1aj+OOdHY9d3hEe5WrGy8XW6YUuQ9sXeLgddCM?=
 =?us-ascii?Q?ndZqa4JqHEuSar98xL5NsWGIB6sCK29spdCiePysYvvNjBXxB5HQYcbiPkhv?=
 =?us-ascii?Q?pRKUj7Vfzv7dc4z2wvePIHFAUrcMMFlueAykb0D0fE0M0nEGidWjXIgdeYVF?=
 =?us-ascii?Q?Nhx94fxFBg9KWZRT4jiQeE9GBxtdIzIrvmY6TKFnzPWXXaF1o3CqWA+OE6X4?=
 =?us-ascii?Q?lEziOTPWOhk53lJdcS3RvscuBh3d9fRubP/Qh+gVsP6U49F09qWMmWeGcgb/?=
 =?us-ascii?Q?w/TI0KF1VrnvO/o2nARNzRqUAY51oDiMe+5VxUt2GNhp4WhyQoRShYPGYQ8j?=
 =?us-ascii?Q?nIci3WNlIm9P9eJKhV6TAH+8IYVVL9jh5ztJOZ2fNE8aMQxkdgnIgzxca5Kh?=
 =?us-ascii?Q?uqoxOWpZzDewexVTfyxCIqK81UMlL8UpcBu+wQ/hXMy39npWYz8QGjkR3G8V?=
 =?us-ascii?Q?5tJWjKE/Rp+fkWIZdKmHI5w5Ey4vjOlz97dNvaNphcKfZcfijJ7S08gfeozA?=
 =?us-ascii?Q?h3LPZQ+JpzCmEjQoeBuE4KXE1DDAqfumKLaJhVT0NgABB588CgJHdBv9IdEV?=
 =?us-ascii?Q?fNJX+irc87q4KPm4IUG4lHb/tB9dWmIDO5vAMJTlxTp/tRrxX20Y+bcXRtu/?=
 =?us-ascii?Q?NXui3Gz27sNUxkv76h6L2iq/3l6KSYo67ZsADECh/lp/MmNNEDFNV6Wewxaw?=
 =?us-ascii?Q?3QsWODUDp9H7BmdmScxGSfJnh30S7lNdNwhGEVCz5KIfaM6CbTgxJJTsdLAO?=
 =?us-ascii?Q?CbnpnLTcpwR7OZ+AsmduyF4yuszleyY0VRxK/jBpjkQzvfyXYLnHGggPZnJj?=
 =?us-ascii?Q?NxcETglajlCxDu5bPsw+yPobmtJv/9CjyPokNAelkrxYwIcwzIuo0GOIv/JM?=
 =?us-ascii?Q?ROzCD2ufsJakAFOjclw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bad6d3f-70a6-49c6-135a-08dc758e7309
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 09:56:25.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTnV78523HN5oDryv6JtBhVAbhMNFiyO5ApiuNh1nv7FsPCcXQVzEzrrTCD+aAjTxb47JBeNDjTtoyJGDSHBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3605
X-Proofpoint-GUID: UyTGBgPlA-KBuRTLYRL7rrqFtpz3nbDO
X-Proofpoint-ORIG-GUID: UyTGBgPlA-KBuRTLYRL7rrqFtpz3nbDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02



> Add check for the return value of rhashtable_init() and return the error =
if it
> fails in order to catch the error.
>=20
> Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac
> address based offload entries")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mediatek/mtk_ppe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c
> b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index 0acee405a749..f7e5e6e52cdf 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -884,12 +884,15 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth,
> void __iomem *base, int index)
>  	struct mtk_ppe *ppe;
>  	u32 foe_flow_size;
>  	void *foe;
> +	int ret;
>=20
>  	ppe =3D devm_kzalloc(dev, sizeof(*ppe), GFP_KERNEL);
>  	if (!ppe)
>  		return NULL;
>=20
> -	rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
> +	ret =3D rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
> +	if (ret)
> +		return NULL;

Instead of returning NULL, return actual error ERR_PTR(ret) and use IS_ERR_=
OR_NULL API to validate the error

Thanks,
Hariprasad k
>=20
>  	/* need to allocate a separate device, since it PPE DMA access is
>  	 * not coherent.
> --
> 2.25.1
>=20


