Return-Path: <netdev+bounces-78358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AC874C75
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA731C22AE3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367D8528E;
	Thu,  7 Mar 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="MfO4aSb+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF185297
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807617; cv=fail; b=SPZViZW7U/g1vRqKI68Y8RHD+n3pGLICUu1zIrLgOH4unbJV7X9tTzhfaPqzvqU+GF8lHGnzFiNrlsugSV6YAKNCMBTd3axC4xaKWfnB/D1160y8iyZQZ780UUBpeylI7ffs4kfWKOZK+KFtm2RKMEaDOV/39Yo5oXkMpeW+Xoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807617; c=relaxed/simple;
	bh=3iwdcxfgVqMijUL1jRKdZJwiu6epDOTgnyoz6yfEbDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+D0VxP31TqWSptqSUAQVVHeOmz2w4HFp6FQzR9l7RWYi7IjGEIeB2kS2tFcrJy8jqVONYTfi0IWL78luU6W932ybbtRqym9l8PAAK9W+R8UGDxSRgljEnbw26PhomujHsMuIXNkNd+b3icU3W13YnaxCfw4WaAWEZ8F+hUldlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=MfO4aSb+; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427129Na031657;
	Thu, 7 Mar 2024 02:33:30 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wq3jfsg76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 02:33:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaY8yr/KmhARnQdaDwd92iJik2qxCXpfluJitgmAbLDFDrNF+c1vHK68eB+IGOeChjYU/27svyuItAJ9QFkQHxk0cc54MBIgPiMubviME2fVtq8qZRWMT8d/Yiwj/jV6EDUJqnLMmMol07gfllQH5zP/97rDPpPEf8sb8MkagEKWE8mqfFUKLA9/vgSmvpGsBnkWUGUw207wG1ochz4XNryW6PJIgl51ELxLQRkkPJIWglT0a69zrsgaGau27D48QvSharg2C4E0seR1J5028YMcYYkFDQ2MbX0C/nMmKr5yWZ4+2+o7QWF4EZrTaE6eWZoBTeikTdJwWthjd0jhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG/4+VtC/YT87C9TZPFbuGTCW0jqyBnKwtCsb3Z749k=;
 b=llbg5r678cFN3JiXuu8lWyyOZYOJPUJH58CEcBHOfeUA9ia1HCwy6orREowRQhtT/w631BvonpHVzp9ohtduqQ9QGh6OA4h9qSJAIgzRxdaINz4ZNNl7KdGqh+cOQQlBb5NkgvnoVWyJwrvOMCbws/nXDcuqSgH0bgWmGyLE7Ir6zcQTQuyiwDIoW57xV1EozTSzicFExD8RaQxyaRtbSqgaQQIioGBNoB3c3LOjSEtAyOAvPtCnMNzWUDSb/WqOdjENJK9SlU+ukQ7LGWQIjWT9+fibnnNCphVNU2RAHqC551Xa8HDv+UiLwYoJASzFbxUCJ6oug6/GZmepb+R32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG/4+VtC/YT87C9TZPFbuGTCW0jqyBnKwtCsb3Z749k=;
 b=MfO4aSb+Ma64i5R7QFOUr3j4I86KKXdPP5JqIL3dZLq48w/HlV/S5jrXvCW3YWbbF5SrYT/+hDdM5wl5DuACXpDoEAws9sLZQhpNilOOZz3rWVt+NQfawDxlcyigUnnU62ek/GX9H+zvas/TgPVhYHyJYNSRvTCSuK9rFFAzdyY=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by MW3PR18MB3692.namprd18.prod.outlook.com (2603:10b6:303:5c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 10:33:26 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:33:26 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiawenwu@trustnetic.com" <jiawenwu@trustnetic.com>
Subject: RE: [PATCH net-next 1/5] net: libwx: Add malibox api for wangxun pf
 drivers
Thread-Topic: [PATCH net-next 1/5] net: libwx: Add malibox api for wangxun pf
 drivers
Thread-Index: AQHacHrjtpUFbxJEI0+VHTW01ysFWA==
Date: Thu, 7 Mar 2024 10:33:26 +0000
Message-ID: 
 <BY3PR18MB4737291987BDDC0B6DE88E13C6202@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240307095755.7130-1-mengyuanlou@net-swift.com>
 <0402EBB760793D47+20240307095755.7130-2-mengyuanlou@net-swift.com>
In-Reply-To: 
 <0402EBB760793D47+20240307095755.7130-2-mengyuanlou@net-swift.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|MW3PR18MB3692:EE_
x-ms-office365-filtering-correlation-id: b5056061-c527-44af-375e-08dc3e9205c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2G9Kd7hoOkyUIKdmDjPnjiSP1J4M/3qIM76ktrhEne0cLgZ15SI5QQZe1myK+BX25wuNFlmithxV/4r/Wwg4K3cw8U2IfDO1q2YZNwJwI+tOTkZa6bYh9gPpV4Q9B/3XW5C19RcH3LTdhv+E8wcmb2WG9u1AkuQpro7K/YwyoLgBWb6GB7Z/pn4yzG5bUdDu1yAzdW8V8gWIWtNgF78g6PLrJYQ9+muxT3cyIwbrzaE8L8rBjcLa2HGU7iKaPEHaHZJgYprfBTJc/q/nzxnmwfDzu6ZwPTsYWzrp5et1nlpP9UccdYHV3QUYpyzZLGguuk7RBUq4V1RLWuMS7koWbP2hGyL4SA5QDcoCvrdneQ2r0ddBnzx7j8NGn8YFfojmHSs/qAGaSVPrFOJI4Q+ZBLqznVwvsluXhnh8FPekzelH8lK62ggBBTJNKtJZ4zbmqAPYZAsDwOg0xWK3GdJd8aenNWdnIj4SZD4N6b7La297iXJxVrQ7kdyqfbSNmHxmAVWcBnDS+IDP6uQbeFy4HSW0H0aapxD6ezkDGaba8EsFcZRGxLcqOfJ8bNIKCGi/Y/mmes5qz0QkTH+6oMTexi+RrMdehUsUHUHVgN9w4//cEUdexLOHiWzD27opQJOWdd0I+2druXGAtYHuUrj0H4X0kyyqrIPdQbOD+LaO7c6dOSO8cd5P5T/lN4aZiilbk2YFKhU1iycDnbBXG9U5vg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?e3KI8KVjUkd3m3Gd8/AEfMniCjOa4B5J6Wi31YCof9zePbmI42qQL9pOI7ZX?=
 =?us-ascii?Q?MZK/b7Le3G36xFlrH+EwL6QOA1asEkxkMuoAaBS9Z5to6R02P0oYzJFuLPmW?=
 =?us-ascii?Q?gbJUgUYSkc2W8w0t1uMXvPx86GYHgvZtIj48NEXvlapkH0MUrqjvToP24vD0?=
 =?us-ascii?Q?1rcTTN9lCMBzWGw99QOKG8KYbA4i+7O0OIdU92YacTMSqeb9xxaChqhXugSO?=
 =?us-ascii?Q?ta/hs2zPgOF6nRGfkqKzMJMwj5WldTkxwM2SNIJDx6gqc9LzagkAWzrZtanp?=
 =?us-ascii?Q?me2lDxMElbNZ0SlyVfnRSH2kitwK/apAPH0Qc9yNHlT6hsAXYi8PVvw16PYJ?=
 =?us-ascii?Q?VgbYJ0Ft8X97bo6CFZWgXXhf0vQMAOOPxgkmBfBAmC39xMzUbTxve0cDM9Ln?=
 =?us-ascii?Q?FwyUVrAQonqvQxBl886YBAXo0wLQaSlydhWmWzxH/vJcOK2rL3/O/LUF1N6o?=
 =?us-ascii?Q?E+/Kvmq9zEwQfV2XoM3NkHQfYvzo7aJ0f24uwBI8BmrXqEQSB3dSgZCksHAL?=
 =?us-ascii?Q?yRVmBJL6AS7aGLGOnrNuvAFFwBcn7StQPcHtvZIh0Dpp2+VlzspnHLfR0fk2?=
 =?us-ascii?Q?ggp2y8XMq3UySs5GDgVoVDg8WteYmdLHZrb7Tq6c1xb7m1cmmrIX08teXpvZ?=
 =?us-ascii?Q?+nVAVQoNWUeOaY8X3Q1I5BWZ2oT1UOXYr7o5+3j1Tand/kg8Dr08z96vTr6A?=
 =?us-ascii?Q?xH5oo1mk1SK9V3MxH+7HEqGuzrrWsfExCUrt3Xyu9C19sHQgrjCVJ7c6ybBn?=
 =?us-ascii?Q?cjfjD3awb3eeOBW50FEdXpkQMmbyLp97Dr+kUAQ614WCvnXcx3MJMi8pxbFQ?=
 =?us-ascii?Q?z7/OPeVz8KjKuz561djdVtNFBSbjGeJzbHnu07DXujsHtQuoZerAHZzmA3aR?=
 =?us-ascii?Q?XrnWeLbU1NtvpyulZRZPqJ++LiaFLbdzQSrB8CsEuqGymixObNUgzfqyHEg6?=
 =?us-ascii?Q?yvvKm3SkCQhXookJ89GVsh19PYQEkU0UNIVcn7QT0/Gh95knZbvVoFxTdzgt?=
 =?us-ascii?Q?oEWfXaHHT3Rqne6eT79BJqQZ6xY6DXtX+rVr9ZKIu+X/GgdLFy2DZBL3uzvc?=
 =?us-ascii?Q?4CT8B/WvLjkj74Q8ilWd4kQMzU3CoHETs8cfZ4asPzNzQQvBGso2NmXIGMUy?=
 =?us-ascii?Q?kWKK4voBvbpQhQpeqlAnPtnvhUXWDvwoJIP7PELvuRxs2cBGwoBBaXGJbWFu?=
 =?us-ascii?Q?mzdSVqvbfkBNJ5ljj1ENsvg0rNXPHRywFHQN3vCNCNZtCdzhw2ao5KZRmnnF?=
 =?us-ascii?Q?hnYn4lXvaH/RQ3ISn/VykAA5tB2k75us9qrsetu2jGVXkXF9Gs/EfChasE9k?=
 =?us-ascii?Q?GdQMaAA0Op00+c109s2D440pYM0/yP2YcZsCXFRe0xjBi/M14SRtXxANWwqy?=
 =?us-ascii?Q?r0daAGMg5GdmBQg7pJ98Dg9PZBuEjI7BW7oDcFfR2C09KJymC3NftZSiJwe3?=
 =?us-ascii?Q?wixXL8dIsUx9yU2V1iUV1YX3gfqyayRvxsd7qBEP6QLh5QadXLzYUrInbobb?=
 =?us-ascii?Q?sM5xxFH/ZpmxkRjdqlTvZfzD5U8BNtYugXeYkcEUZcmI/+A9dyK7ger/RlB9?=
 =?us-ascii?Q?uRHtwsDAbVaH/mTA44wrpkzMriNJ/Hc/27Bh6RCu?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5056061-c527-44af-375e-08dc3e9205c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 10:33:26.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NL1n6Ue4gdQBEWRwmHVDd/CjG6J3xO35m0U/IJgqoegkzd8ExI8yb2fdv4OAIM/AFGrSoI0anZpuSoCZRWcJxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3692
X-Proofpoint-GUID: 67R4LbWTGxhfUK6P4ZUu22LHPQveJ0N6
X-Proofpoint-ORIG-GUID: 67R4LbWTGxhfUK6P4ZUu22LHPQveJ0N6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02



> -----Original Message-----
> From: Mengyuan Lou <mengyuanlou@net-swift.com>
> Sent: Thursday, March 7, 2024 3:25 PM
> To: netdev@vger.kernel.org
> Cc: jiawenwu@trustnetic.com; Mengyuan Lou <mengyuanlou@net-swift.com>
> Subject: [EXTERNAL] [PATCH net-next 1/5] net: libwx: Add malibox api for
> wangxun pf drivers
>=20
> Implements the mailbox interfaces for wangxun pf drivers ngbe and txgbe.
>=20
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 190 +++++++++++++++++++
> drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h |   5 +
>  4 files changed, 228 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile
> b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..913a978c9032 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>=20
>  obj-$(CONFIG_LIBWX) +=3D libwx.o
>=20
> -libwx-objs :=3D wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs :=3D wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> new file mode 100644
> index 000000000000..5fbde79a5937
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#include <linux/pci.h> #include "wx_type.h"
> +#include "wx_mbx.h"
> +
> +/**
> + *  wx_obtain_mbx_lock_pf - obtain mailbox lock
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return SUCCESS if we obtained the mailbox lock  **/ static int
> +wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf) {
> +	int ret =3D -EBUSY;
> +	int count =3D 10;
> +	u32 mailbox;
> +
> +	while (count--) {
> +		/* Take ownership of the buffer */
> +		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
> +
> +		/* reserve mailbox for vf use */
> +		mailbox =3D rd32(wx, WX_PXMAILBOX(vf));
> +		if (mailbox & WX_PXMAILBOX_PFU) {
> +			ret =3D 0;
> +			break;
> +		}
> +	}
> +
> +	if (ret)
> +		wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
> +
> +	return ret;

Even though error is returned here, rest of the patches seems to always ass=
ume that locking
is successful. Return value not checked.
If getting lock is essential, it may be better to convert this into poll + =
yield with delay instead of busy poll of 10 times.



