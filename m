Return-Path: <netdev+bounces-104950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C690F426
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27F11C222ED
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282B15278D;
	Wed, 19 Jun 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="na2lzXSf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34941D54A;
	Wed, 19 Jun 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815038; cv=fail; b=SWCP3vdj8QkptiU1xr00297Co2qQu3TfTcXiKLd65sHXRF964zT64qbg/SdCqS8fw5/ES3Vo6CbdmyMu1bPpA307/VVUmRHV83lMEnI29HecZsJoKULEn/MKwBjSd5ofrrcu5GKCr9ORmpOGAmzBdKn64jm0Zsh6spOPpkg6FaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815038; c=relaxed/simple;
	bh=Yqtd1NJZd4tVwVHCzvRPKzcH0ibzNtQiJOc4sYzzHd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+FBH+Xfmn9KjbePJVZl+P3H5ubyMCxfNCbis70pSFQcII9/NF0OR8jA/1SHE8ok0g5l7fqwaPWLMuMdKxt5jgP0VHeGSONiZj/DF5/6Iqu6/5THU9ZdlfINDmRF0PMaKI+xGIAxJq0p1IZz0/fw6sWcVG7rGu0ZaDOaarLIeEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=na2lzXSf; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7Rn2X022869;
	Wed, 19 Jun 2024 09:37:09 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yutyc1ncm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 09:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbNz9h2DO1+tPmpeY9Zzy3u6xDXm2FTvLcq5elaCEwjcl0lmww2H9Ipi4BNe0t2QJuU9EVshgklkUj3tq19+kCPpM92xtzphQANIw0+/A95kaXjRGq061kPSQ0WU6EehOCgBQgVBdFqM1h0YB8WeFIMdAUOx0kTALtPgctbyZqApZ7Uvs1/ZGX2HSwrRQcmqS+me33qBIu/Nb7lTP5li577/0hSr655jEoSRPekMy4lquXL/GrKrRsBMjnxgUl/fKbc4Ob1k88BaQjnLoi9dNQblEc4AumiZkhizSvcWDfX2LKPm+vetTQqTeJe0Recssq3gHNfH/sgoL3Cdwx0i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhgUifnMKLJDW3Ezn+fPmnsIAzPZoo332D9SmsaqJzM=;
 b=hm3b9f6bBu7/ySvZoN0crYkUD84mnC1pSonIngpbCV9U/wxjKQCdAwWLihFwYcFcEu8D2IxnK85VgfnpvXieDdVjx26hEwsIsWAYA8U08I4cNJJDTps2zMET4och4NL/NU3+6GaP386Rrp3GN9ucHrkZCyxV4uCHCMrvgPSU9PC1JEZ5v3X7Chxb355gzteXCMbyPXkyHI6oW+BH51p5wLAhBV+3ef/qMlOQmdrPZ6rBeCYVhL+2eGLOUna5ldqsAlUS4PO/QXhLYN6AcQF9d+ziFV8l9h3yOG04Aiy7IXn63DQL0buGRkJ70Ly1OQ3qGFRhGT2Jq0SGKyCA7Y9WsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhgUifnMKLJDW3Ezn+fPmnsIAzPZoo332D9SmsaqJzM=;
 b=na2lzXSfIC9A2hkvO1MU+5TKhEaJo//jEm8YF6a95Ky4R7CRiwo4RoEwqw3ff6BRqAvlAQJBlytq60MNxmqmqp20MbYFxJCpQHfN3TI/74rUS1m8VeOa+zNaW31HTYSF2vz1krmfBoBFv50kSMKiS1z590aVJPGuJZYNNhPO46U=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH0PR18MB4784.namprd18.prod.outlook.com (2603:10b6:510:cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Wed, 19 Jun
 2024 16:37:02 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 16:37:02 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] docs: net: document guidance of
 implementing the SR-IOV NDOs
Thread-Topic: [EXTERNAL] [PATCH net-next] docs: net: document guidance of
 implementing the SR-IOV NDOs
Thread-Index: AQHawbW2K6RD9mXK6UuO1c973CDXuLHPSZEA
Date: Wed, 19 Jun 2024 16:37:02 +0000
Message-ID: 
 <BY3PR18MB473780CD47EEE6E4456C8169C6CF2@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240618192818.554646-1-kuba@kernel.org>
In-Reply-To: <20240618192818.554646-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH0PR18MB4784:EE_
x-ms-office365-filtering-correlation-id: baf1a8ee-cc9d-4a5e-0454-08dc907e0c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Em3hJiI2Q0qlhH3AXA0xxegXg7y46Wxa8mzpXfzydwLdQNgyEOp8lrG6kr1j?=
 =?us-ascii?Q?jY7wR6HkhXdj1C4h8Sk7MOatbv1eD1YI+xHuTtvoqVGXI2raUqmxWNpOx5kW?=
 =?us-ascii?Q?OefjyMhK/wZPztOT5fx/WA8hmHiWrts35Ync777QiDgSG1n9zZE2Des/Z8sz?=
 =?us-ascii?Q?UJf+83rdvk9sw90/fzVZOu9ZburvGtLJzSGihbslqj53CuM/cr0uoU4rVC4M?=
 =?us-ascii?Q?fQXHOzy8OiTiwKEZp5BxqjB54aPobmUJEDZkMLKARcZFtGHH12CgYvPxt4UL?=
 =?us-ascii?Q?u/XwQgwV3t1mqlxgOF0wZy/FtDhrQJXufaiojdYqGG9wRiRDP+KEaejWHjwZ?=
 =?us-ascii?Q?31XE68pcMbQysh+/z/Tajj4WVWxAvEgWrvvE7RMaoZmSWX92wsi4F7pyQH3w?=
 =?us-ascii?Q?ZxCXZRdz+ajoxa0nq+BOrca/qalpU3sT6V4sBR3AgG+r8wsd2yMZZLkPNuh8?=
 =?us-ascii?Q?9Y00z5dleO3298JHUcvx8ctKJE/CYAvftFz5gwRtrJkeA3/PYbfkvuWuKjLt?=
 =?us-ascii?Q?1aiphzvGSz8KbX806KIuxTcd/3EDFZ+3DXJsxuixwlGXB5F32syPxqXWR9eb?=
 =?us-ascii?Q?05ckyYUlDrF3b1/ohTDfxgahVr4U0yWwqpBWeXytzstgYZPxxXy+FNCSxg5o?=
 =?us-ascii?Q?dACq9emmdXyzII48Ry6MqrElE3FJzzzmLGiP9CGh9746L+sbvdG1RQZBcvDD?=
 =?us-ascii?Q?PFMfoI2kxjXUIBEpANTy3Eorg8lMh++IAMMqqHmmkb4/KHGD1hW1gVSt/Kr+?=
 =?us-ascii?Q?mk4ZF8sNvdqzgM37FerzkbQphxwFhS1QQRr9eKxwRwVz7fBwIBah3FD7z57K?=
 =?us-ascii?Q?66rr1o7zKFIjXIDWs9CEbj49H/XZClbfyQfQPBqi3Wn3GABupnXabPYa4zui?=
 =?us-ascii?Q?xnBPpU4XvL4usev5RsADaZy/EwXKrENSVaoK1VuticAUHNf+ipo6JwOOKs/C?=
 =?us-ascii?Q?xdn3AWAD6D8655SqoxtVAEcoHvBer76g+3Yg4f1T50FyG4m/Jf8v1CA1WuF2?=
 =?us-ascii?Q?Uo+u0rDr1HWM3tib0YiwXpxmcVp/eDtGnHpoJC9rZEQHHH1taiIMdcapx1Kj?=
 =?us-ascii?Q?j7sgWzhp92KgBD5idRRfiGFmbCFfkgiH3qeEgDJ/FpnB6Yu0oawRzN3Qh/R5?=
 =?us-ascii?Q?Y+ok8yvT795ve2wQAtYRejFTXX0omWMcNJYHEmbyxK7AZk1IHzPp3EkcIm48?=
 =?us-ascii?Q?qLyqwhvc+EFjiQtbcQ7FLpp9YlEKHXhrsxTV8/x6kY10I3F4FoRB98F9Mvbd?=
 =?us-ascii?Q?fFQceh128hkOVTaoFl1WLW/+gXFxjegKDLh3QOLEY9U6vXjKS8seTYd5hwlE?=
 =?us-ascii?Q?Qt5qU/yYXwqIFjjshmFa2Mv6OyXDpUZUdKt1VxuIasTQ/aYsb24Dx/MoCaYi?=
 =?us-ascii?Q?3ZmmOWM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HrRZHDkUnf8U60dAjyPB8wOfJV7reYGbS1GUxmDFa5lg++cS6rptGujClfY3?=
 =?us-ascii?Q?ip4McUWw+wmSlsbbUHOO/1KQhwma8HiZD8bCoK7GxVRhrJgFpcsrbFxLLfcM?=
 =?us-ascii?Q?bLkejEQIU8mwTxm6/erhvEbRhokegaPD+BpARgTgD0NXFE9a8tl9XHJVfDiP?=
 =?us-ascii?Q?af/N4O5tI5f2avICBnt+5J8uSU9eRH9v2RvIWRCcSY0wGS8z4DuQ+et0yf9s?=
 =?us-ascii?Q?qPgYjvQmsLpk8T30GfSz2lNC4pGd+k4UosXl6lIE7a9ec1gu2jXowCvjzYTj?=
 =?us-ascii?Q?6gFir9F4UopPNoGlFvzZ9tfR2rnuC5g7tlEuvqH3TxHReFfBM9V4kGdUKGjS?=
 =?us-ascii?Q?m5xHtrsG+tE8iMCcF9e17U7M8IpOK/AHj/EZmaaWr6gX4rxfLmiVg+vFymYZ?=
 =?us-ascii?Q?Wu73usQSwRBlx/N1u7QdqIYPBqFO/lyNSrZB+f95W/pHhDApnYKe6mkY0+CT?=
 =?us-ascii?Q?Jd1EQkpAwurDX5juxsiEIXaZaJYG3/hc41vSO+kddtwXOKAb4AXSlwrbWSvR?=
 =?us-ascii?Q?hkjgYr/SzMhA+BVEtCMsADKLSrO8DUiv+tTuTARHItw0f8NDvvkqwAaBiRqr?=
 =?us-ascii?Q?84U9e+dy8lN+7DygbHKIuLuGd0tDwCap/sTlRsgpiN/uZJ0DGww3YoYmgWGu?=
 =?us-ascii?Q?VScQZCxXEMGudBTmC2jn0cmvISNDkVwMXbgc7B6NQnGqd9zQlhIdIulB0nqQ?=
 =?us-ascii?Q?6T6zIOA+FCLA4xXls1cdViQTP8nbG0dc572jFd/deFOwGMua7oytB4U9ft7w?=
 =?us-ascii?Q?2N3YpVl8BZSMshEEFCSrYNnR8PPqyZrB3OWIw4PfxQNFOjngVfSN0LYkj0fa?=
 =?us-ascii?Q?PW56cW+H1wmeNBp3tVU2yrtp0zvQuBl1MjxBOeC5OKRmBT2ouqb0IMEQjHuZ?=
 =?us-ascii?Q?YEmCPI+kI4MN9HwTAXXKEqEYFfZBNXC33FCZ7LPCriLwkP/Qy2L5ent9bBDL?=
 =?us-ascii?Q?cJx3Y5pGwsFOQ1nDJNFHcCVsuLdIUHTYSVHnde5NuWPy35qs/28a1pbHs+Be?=
 =?us-ascii?Q?DW4PQ3wxEhFr80q0bL5aBjSeou2Vmi19hnvWihCwj7t+lop/Z0UQmrhABeYt?=
 =?us-ascii?Q?Ne22pYtwAIG+tO5LRTJE6zu2i0v8ZSiQf4GRGdFQQkf9ZVK6VyosyKpLpjyF?=
 =?us-ascii?Q?WrkuFEAYolL/2yCEdLvpzrXhrB0v/ieVOwwzgmrSYuNIU3IOpmj9dLrLscxF?=
 =?us-ascii?Q?qlLS6knkClTvhERB3OLeSW4t0jh69zn0Kv6Iu26t6Mb1cOqEWB9PeVFpuDzz?=
 =?us-ascii?Q?MMlZV27vRQ7u1X6NDUVoVnWoHQm9KVXbRxo552pvwAwg+92zNDMJp7PyA2be?=
 =?us-ascii?Q?Gqmq6DUk3uoITeYmfeBK87cILAI97MQN3wXCP1yDSIc9knM4vnIHpqHMggq7?=
 =?us-ascii?Q?8vUgRw31gDdCiH8Q8/UWnGo61J8q7L6QyhJbbLFiulDOk8hNuNNvV3nPFc+6?=
 =?us-ascii?Q?XCHXI70tp2ZJtk0zJXzcMZpZfdFUSyirqTT3kJbx6kXLQCrCZoLKhiqxa4FW?=
 =?us-ascii?Q?/kuFwZjRSuQN0l25OPVOIKlb1YQi7sDolv3spHq7WFm3F1HoXJVYaMkFq650?=
 =?us-ascii?Q?zpbBd2rfAQs9DVpzQr89cmD529cZVeTFxa/fa9Dx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: baf1a8ee-cc9d-4a5e-0454-08dc907e0c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 16:37:02.2888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCZ1Pv/aG5sj5lXqCLrQlyyykS1fcxLipjyoIwNdBI2ecEWsUDveHdIEuqjnWg8os1emxTXBwFaOtdGztXFhBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4784
X-Proofpoint-ORIG-GUID: T-y62y51GedR0KhJ5sbHNi_xg-DkF5zB
X-Proofpoint-GUID: T-y62y51GedR0KhJ5sbHNi_xg-DkF5zB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01



>-----Original Message-----
>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, June 19, 2024 12:58 AM
>To: davem@davemloft.net
>Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com; netdev=
-
>driver-reviewers@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>;
>corbet@lwn.net; linux-doc@vger.kernel.org
>Subject: [PATCH net-next] docs: net: document guidance of
>implementing the SR-IOV NDOs
>
>New drivers were prevented from adding ndo_set_vf_* callbacks over the las=
t few
>years. This was expected to result in broader switchdev adoption, but seem=
s to
>have had little effect. Based on recent netdev meeting there is broad supp=
ort for
>allowing adding those ops.
>
>There is a problem with the current API supporting a limited number of VFs=
 (100+,
>which is less than some modern HW supports).
>We can try to solve it by adding similar functionality on devlink ports, b=
ut that'd be
>another API variation to maintain.
>So a netlink attribute reshuffling is a more likely outcome.
>
>Document the guidance, make it clear that the API is frozen.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: corbet@lwn.net
>CC: linux-doc@vger.kernel.org
>---
> Documentation/networking/index.rst |  1 +  Documentation/networking/sriov=
.rst
>| 25 +++++++++++++++++++++++++
> 2 files changed, 26 insertions(+)
> create mode 100644 Documentation/networking/sriov.rst
>
>diff --git a/Documentation/networking/index.rst
>b/Documentation/networking/index.rst
>index a6443851a142..b4b2a002f183 100644
>--- a/Documentation/networking/index.rst
>+++ b/Documentation/networking/index.rst
>@@ -105,6 +105,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev
>development process specifics.
>    seg6-sysctl
>    skbuff
>    smc-sysctl
>+   sriov
>    statistics
>    strparser
>    switchdev
>diff --git a/Documentation/networking/sriov.rst
>b/Documentation/networking/sriov.rst
>new file mode 100644
>index 000000000000..652ffb501e6b
>--- /dev/null
>+++ b/Documentation/networking/sriov.rst
>@@ -0,0 +1,25 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+NIC SR-IOV APIs
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Modern NICs are strongly encouraged to focus on implementing the
>+``switchdev`` model (see :ref:`switchdev`) to configure forwarding and
>+security of SR-IOV functionality.
>+
>+Legacy API
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The old SR-IOV API is implemented in ``rtnetlink`` Netlink family as
>+part of the ``RTM_GETLINK`` and ``RTM_SETLINK`` commands. On the driver
>+side it consists of a number of ``ndo_set_vf_*`` and ``ndo_get_vf_*`` cal=
lbacks.
>+
>+Since the legacy APIs does not integrate well with the rest of the
>+stack the API is considered frozen, no new functionality or extensions
>+will be accepted. New drivers should not implement the uncommon
>+callbacks, namely the following callbacks are off limits:
>+
>+ - ``ndo_get_vf_port``
>+ - ``ndo_set_vf_port``
>+ - ``ndo_set_vf_rss_query_en``
>--
>2.45.2
>

Does this mean=20
ndo_set_vf_mac
ndo_set_vf_vlan
etc
will be allowed for new drivers ?

Thanks,
Sunil.


