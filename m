Return-Path: <netdev+bounces-96333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF48C52A7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA081F22831
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41EB1420BC;
	Tue, 14 May 2024 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="gywDCs5l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365241419BA;
	Tue, 14 May 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686040; cv=fail; b=ITHM6w9+gEXtVCAC+uCOEarILoKh2zPJc/O216enqSVy9xnzt3KRiZmFj3gndOEbrZjK2ihpp3XTC9rDvzpbvcbNLRbQbRe5lI1anaDS/oczesqNMubBJRpWqHC2DxN4RkjAe1EBeaDgjRgETG+SoMoONS8dUQSgq9Rq1fuG3ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686040; c=relaxed/simple;
	bh=q19zS0o2Oe9ynorQQ4Qam7gZhyFrvQdGo/6keLgpd8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jaAPfGGj0iFS3OPKCGorwkzQqvyBgTfH71Oa6LYqWteCh5Kfe6Rn8ixtmwsuzU58dDJQmLGRUg2jh/sGhMJm9mcS8sZvowqg6EiaPSJTL/mRz0OILXCdPl0QL6SxEOW+np8O86xSq0VJhAFf8ftxGSBF4X81u+IZ2JPVpo5mdTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=gywDCs5l; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EAj4xk014208;
	Tue, 14 May 2024 04:26:58 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4kyu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 04:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWAu9M8WFj1j4jy3LjH8805K3/wtDtdSdtOuMkpUSecUDBHTG0AhZoab0lGu6EUNwG1pYvBQTYRUFNn0ceVLG4+HkdIN2uK3pslt0ldLB3upziC7hzAPAft/Yu+wUGL5HDrVgCUZlHFIAXXLv+piopK8rfBP9frbJWTG9RpcBTD02lcr0cgC44AXzmWbNMc2ZIqYhu8ZG1eH1z0Ma6Xr6z0OPA3FrlIr3ggl5UuobyF+Zf1ZqNglksiCgfrAK6q5Jenw/qCa1M2L6M5usee3P4Q6HvXBtYcDeXcTOU46uKt3It/DRktUAFrS0mZVbiPLAOSZ+BH8sUCSnze5BwhIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0H4Boezj7P0hR+5Jyb1nFz5YaZybzrD/oQr8lkVq0c=;
 b=CarX+jKTHsyrCHLWq2Sh2J0TwX7Uil0sZD2bKMlQdJOUJyNMVF11b6zfNvT1iW6J+JIMwkFS2W5Lj7PHq0YgXgg+QvcqJPIc9Z/JlfPC1uP697fxYs7WpeMdJ4VwqeY5QlIw1fmLA/FTutvd9M51SXWzmiTd4FZ8MJMMxTvO53I9r8Zu/6qK2XdBMSZDW6g4MZVyM3z5HdC2ZU8SQZQVRhFPe92v/2oNINFxkdqyrQLdJ3Dj5J3mmKf3eWnj762zjGz0XfzE1SuY8WqFiXcu8qq9Ju/7J6n4zignVCn66EADL+LDS4qlGFKtBMHporCN4kaAVArxFQ9blk6sSwQlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0H4Boezj7P0hR+5Jyb1nFz5YaZybzrD/oQr8lkVq0c=;
 b=gywDCs5lGz7/hjlQxseELY/qZ2mPCEoeA1xX9zOVf3ZHJC+1e3If7BAgzl1v1QdEGEla56Gw8NQZFZaeKnMEs3aEIsZjyqwvVIw3OFVMHRLzq4qnDGxkROflw/VxyNAThPfRKjChylQ20kd4ugWvtcm+k/0LY+N5tipb65kkyVs=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by PH0PR18MB4800.namprd18.prod.outlook.com (2603:10b6:510:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 11:26:54 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7544.041; Tue, 14 May 2024
 11:26:54 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Jerin Jacob
	<jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
 backpressure between CPT and NIX
Thread-Topic: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
 backpressure between CPT and NIX
Thread-Index: AQHapSQKuOy9XZhP3kiH1e4gTcWZRbGVVxCAgADtLRCAAEgEgIAABgbQ
Date: Tue, 14 May 2024 11:26:54 +0000
Message-ID: 
 <SN7PR18MB53148EC4FCE8C06611A284E6E3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-4-bbhushan2@marvell.com>
 <20240513161447.GR2787@kernel.org>
 <SN7PR18MB53149716909DE5993145509AE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
 <20240514104125.GD2787@kernel.org>
In-Reply-To: <20240514104125.GD2787@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|PH0PR18MB4800:EE_
x-ms-office365-filtering-correlation-id: 96cce783-0199-4b72-6a71-08dc7408c1ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?AHWmvgntOlRlee+5k/qbEonpDnuxnlPPQAbiLLRGUCpn54Kbz0OckNsCpduB?=
 =?us-ascii?Q?rSu4j4sQ2jxAysHpf33RXa8LiKhN2RGvgFy02o5cRNz0XuRjw5OKRpZXVU5H?=
 =?us-ascii?Q?kMsbyMd3J6T8URDOYu+cpm6OHqTUNBKeIl8emnub2Wpt8mjzyh4nauV8H2tN?=
 =?us-ascii?Q?aOAzqJZRhD7yatX3T93h8Q8lcymMXFSAZlUb86TWmJIRth5dr1tU5g5QeXcj?=
 =?us-ascii?Q?z4fu66Owlq4OqGQ/iN4RMtiGdqDdSd/lKDgXGTIM6mlsiNeGzFFLjscTYImj?=
 =?us-ascii?Q?3U+G0d9EGnlDe0WibaMUvZlnnLN/h1Sut35hzmphTLHW/ffsnFuqBWD1RDNQ?=
 =?us-ascii?Q?M7HwKeZd7bw0o8exQpcAMlL+0NwDLgQxLYLJsxj83NllF4J6PwEJUu9YJEb8?=
 =?us-ascii?Q?UxTNoJvQOzDPQaeKnuOLViB/RwTYmGnFD+7ur6Kpmzq/SKWOhVaXpFx4zAXy?=
 =?us-ascii?Q?1/Oto9iKzLwmd0+d2Ada82sjaVhYMFqtlTwp90yV0toyDPt4QK3swLCDMY0R?=
 =?us-ascii?Q?SJQsIatSop2DqHUM6jscBxayFPYSSsE3mH/8f+t4VnIr3Ewf4bQSCRBu5yNK?=
 =?us-ascii?Q?b0kwPdSSvp5kT8A7Mt9kZM+zA/fZD1uNEAAcsofqfq4SMqcAF2dEiAObzoAV?=
 =?us-ascii?Q?KP6Z/n4NbyLdWYpmvM4ul0V4ceyTf0Q9dQ0Kp1urY1Q0Uf7Xfny0VcPFeHcb?=
 =?us-ascii?Q?MQGdqZX+Ob6x+bPCZL1znANoHNVj/gaeAASPoSD/XlGC+NHeYuXlHMy1Eqh1?=
 =?us-ascii?Q?Sd49+B4y054jDUvK1udS/zYCGiDpWdvJgfpAYCoLLkiUHDwSdVZ56nGkmezD?=
 =?us-ascii?Q?cqLL0ZrIVpGEssMvmh4b+T2l1yYAeYI+Tkkf3Zl/7R1zJ0oMdKG4CdUDC1GV?=
 =?us-ascii?Q?4plfzpgD3Ej95P0KJoOw247vla9fOksASW0o+W6jj8Sb2SG87XluBT1WHxn6?=
 =?us-ascii?Q?c91hZu2fmNISZsgt4XOnBrdn6+STIz6AovzOVbBDxMDlYN480ZizzLnDo0xp?=
 =?us-ascii?Q?zk8qzc8S8tXZcJ8zq33Uj9KPqhdUCU63mNqYoO3vYCEnLEPDCsm+4olgxcq6?=
 =?us-ascii?Q?FvGSnx6eP+jKmBCscfrhLWX1QL5qGFc7iZ7gfp4hNEB9ZFXlPM7LP2evKv7R?=
 =?us-ascii?Q?4VmFC6PF76uE4LIEZKQuBjqz2MchWQX0jkErF2Eukc43Ul4oMYgfHCjlXRm3?=
 =?us-ascii?Q?KYhLAZ0Cv1RIdVnK+HTdrne3JCDxkS3p1Z4FNDR4pR1pmAr7wLQavR/Wbg12?=
 =?us-ascii?Q?5amLLy5UIjz6VFRzNj5f1vZCW8qVKQ4doQJ91REP27e849hafx6PTssJyQ5g?=
 =?us-ascii?Q?TlBgVGeJkC2OqIIdXaNSoL6fbBOJjWdvlcJ2GBiCgV1gJw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SxtRe3DygwMSYJn4hoV+1nCj/cI0P0xORwdQt86/RFx/NKnJKRCAmbjvMX4J?=
 =?us-ascii?Q?TcIT0TpUAsHs+Ttkkr00G76im12f497PXVDxpV5fUmSWc9wX7cxE2OEIA1WA?=
 =?us-ascii?Q?WeTb9BM8lCTayaX2cXTvZ8Ee4d4KgDJKJGK8qIsAv/Mbdd1NF+1aiZxRrWBI?=
 =?us-ascii?Q?e52rVmcmdpNXTcsVmNOF+ZJpDFcACIriU8HoyJPKT+AELJvLfTJBw2V4daWq?=
 =?us-ascii?Q?0aVrJaj2ebgXr9DC9HfQafbW6C+q6S79bOSZPaagdw+gdbGLVowEg26aSiob?=
 =?us-ascii?Q?i45t8Oh9N4fM3iaWW9mUY//UK1j4vugVbNErVBJNveUm/FEiXOOnaH+tB+WR?=
 =?us-ascii?Q?OEoFxQc3rxkmTmxCJsTnW6HaDd8MDrf57YDoZ0SQljWuKhJkqNOrlxZWE+FE?=
 =?us-ascii?Q?so/GZK5/AFAXSESuZ56hk1vss9vfCtgwkBq0e4QAFRpVDQxcU2MybYsceSVi?=
 =?us-ascii?Q?mFQgnYOgZvGpg3hlkd8iCuBMj3ywkYdvgjoYAyi3Vyn/X8OJAW/hWO4ef6qK?=
 =?us-ascii?Q?oKTBtkaJ47IcES3vA/DP0JWlPcdDhN5MJ2763sCmfmv9jDAmHi/FQB4FPS9l?=
 =?us-ascii?Q?K8NfUbjZdAnxJt+7YA6XQTzYJzjcXdV8BYMGG3F01qycwODPtU3l+u4jA164?=
 =?us-ascii?Q?JUc3Ukb24i0XNIBFj5eOWSLCNDqu850JIKkxfsJ9ujKWafhI1UN8EO8I4bvE?=
 =?us-ascii?Q?8ee8SaqUa0cVTu9pLtQmnL8O+URueoCispUsnP7E0JioVqShsBdc8hFWcg7i?=
 =?us-ascii?Q?V2/tiIbhiOt0AgF+ddjaXi1taUwZo1M8MyFhJb8Yn7oFkZF7ijDg4XZKkt0h?=
 =?us-ascii?Q?ChPRlfKWfP06GI662c1SWRUZlb67JTsDfJUa8zgIACcaMIX89ULmxKvheckj?=
 =?us-ascii?Q?JZs/YLIAHo7+aHRTNVZMNYe2z7+WU4WbCvdOwVHFwErTnY8lul2EAL46pXXf?=
 =?us-ascii?Q?FCmhMLQ+nUBo8DmGrf3IwUF3qo/hYppTNnzSSDZA3YSdVtQbdwbNY2yFx1c+?=
 =?us-ascii?Q?yurXlfQ3iV3WOGy6HTG8zi9KPfXZZ7mfnduWDZxanC5kCJm5zvXyK0AKxmQ2?=
 =?us-ascii?Q?3MQDri9x0rJkjRS+fyQ8wbP5qu8qHsdJWX7I2p2sUgwt57aI74gTotYmKrkF?=
 =?us-ascii?Q?1TnXdzkLI5ReKxN+9HTUdsMAbA9apNgsB7Z8wSIzrXI9pokC5TRfXW6IG1Mv?=
 =?us-ascii?Q?JV87TBLJ0BCpK4JBoZwZmSQNne7U6NfLKtLumNAxDrJyk0TdfwnM5vmhOYp9?=
 =?us-ascii?Q?6jM/3iYtJY6W6UFCc6/e9cRnzRGcblp9wJ76c2CiUjMZ/hdQkYnqkF3r0zWV?=
 =?us-ascii?Q?+DCXDjWdQS2+4EV5FfbkE7z92UXqNTmgLeJRfpWPgrwTP4BUVR60RAcU2IkF?=
 =?us-ascii?Q?6VVMylQC5orMByH1GpgXVMryN2iluC3giB4UBHd6Wvr6bb23yR5nA8STZViR?=
 =?us-ascii?Q?PtOfhp2jyMR4dI3wCtqfoTNsA0tvA4LBJWKpgUcnBH4+4ONAxolQxkjb9vhZ?=
 =?us-ascii?Q?ehUATGSojp7nNBgJG20FcokeAVjTOCaEhCJJDS8c/DpM5DS8sQSqbO6f9NfF?=
 =?us-ascii?Q?cSLjdb/8StuFhjN8jrzsyKI1AMjXd0svdESvcV7F?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cce783-0199-4b72-6a71-08dc7408c1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 11:26:54.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8ERLbFgL7UijXEQQZd/UGCEwQJ7AEGDa+ZJEWtF2VqOhzys/73456aoGJbyA6WA6Dy0ilT9A6r8JWL+AMeXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4800
X-Proofpoint-ORIG-GUID: vu19PNBqdHwQDB-DXqlfS6anPjsQpROy
X-Proofpoint-GUID: vu19PNBqdHwQDB-DXqlfS6anPjsQpROy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_06,2024-05-10_02,2023-05-22_02

Please see inline

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, May 14, 2024 4:11 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> richardcochran@gmail.com
> Subject: Re: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
> backpressure between CPT and NIX
>=20
> On Tue, May 14, 2024 at 06:39:45AM +0000, Bharat Bhushan wrote:
> > Please see inline
> >
> > > -----Original Message-----
> > > From: Simon Horman <horms@kernel.org>
> > > Sent: Monday, May 13, 2024 9:45 PM
> > > To: Bharat Bhushan <bbhushan2@marvell.com>
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil
> > > Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> > > <gakula@marvell.com>; Subbaraya Sundeep Bhatta
> > > <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> > > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > pabeni@redhat.com; Jerin Jacob <jerinj@marvell.com>; Linu Cherian
> > > <lcherian@marvell.com>; richardcochran@gmail.com
> > > Subject: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
> > > backpressure between CPT and NIX
> > >
> > >
> > > --------------------------------------------------------------------
> > > -- On Mon, May 13, 2024 at 04:24:41PM +0530, Bharat Bhushan wrote:
> > > > NIX can assert backpressure to CPT on the NIX<=3D>CPT link.
> > > > Keep the backpressure disabled for now. NIX block anyways handles
> > > > backpressure asserted by MAC due to PFC or flow control pkts.
> > > >
> > > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > >
> > > ...
> > >
> > > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > > b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > >
> > > ...
> > >
> > > > @@ -592,8 +596,16 @@ int rvu_mbox_handler_nix_bp_disable(struct
> > > > rvu
> > > *rvu,
> > > >  	bp =3D &nix_hw->bp;
> > > >  	chan_base =3D pfvf->rx_chan_base + req->chan_base;
> > > >  	for (chan =3D chan_base; chan < (chan_base + req->chan_cnt); chan=
++) {
> > > > -		cfg =3D rvu_read64(rvu, blkaddr,
> > > NIX_AF_RX_CHANX_CFG(chan));
> > > > -		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
> > > > +		/* CPT channel for a given link channel is always
> > > > +		 * assumed to be BIT(11) set in link channel.
> > > > +		 */
> > > > +		if (cpt_link)
> > > > +			chan_v =3D chan | BIT(11);
> > > > +		else
> > > > +			chan_v =3D chan;
> > >
> > > Hi Bharat,
> > >
> > > The chan_v logic above seems to appear twice in this patch.
> > > I'd suggest adding a helper.
> >
> > Will fix in next version.
> >
> > >
> > > > +
> > > > +		cfg =3D rvu_read64(rvu, blkaddr,
> > > NIX_AF_RX_CHANX_CFG(chan_v));
> > > > +		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
> > > >  			    cfg & ~BIT_ULL(16));
> > > >
> > > >  		if (type =3D=3D NIX_INTF_TYPE_LBK) {
> > >
> > > ...
> > >
> > > > diff --git
> > > > a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > > index 7ec99c8d610c..e9d2e039a322 100644
> > > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > > @@ -1705,6 +1705,31 @@ int otx2_nix_config_bp(struct otx2_nic
> > > > *pfvf,
> > > bool enable)
> > > >  }
> > > >  EXPORT_SYMBOL(otx2_nix_config_bp);
> > > >
> > > > +int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable) {
> > > > +	struct nix_bp_cfg_req *req;
> > > > +
> > > > +	if (enable)
> > > > +		req =3D otx2_mbox_alloc_msg_nix_cpt_bp_enable(&pfvf-
> > > >mbox);
> > > > +	else
> > > > +		req =3D otx2_mbox_alloc_msg_nix_cpt_bp_disable(&pfvf-
> > > >mbox);
> > > > +
> > > > +	if (!req)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	req->chan_base =3D 0;
> > > > +#ifdef CONFIG_DCB
> > > > +	req->chan_cnt =3D pfvf->pfc_en ? IEEE_8021QAZ_MAX_TCS : 1;
> > > > +	req->bpid_per_chan =3D pfvf->pfc_en ? 1 : 0; #else
> > > > +	req->chan_cnt =3D  1;
> > > > +	req->bpid_per_chan =3D 0;
> > > > +#endif
> > >
> > > IMHO, inline #ifdefs reduce readability and reduce maintainability.
> > >
> > > Would it be possible to either:
> > >
> > > 1. Include the pfc_en field in struct otx2_nic and make
> > >    sure it is set to 0 if CONFIG_DCB is unset; or 2. Provide a
> > > wrapper that returns 0 if CONFIG_DCB is unset,
> > >    otherwise pfvf->pfc_en.
> > >
> > > I suspect 1 will have little downside and be easiest to implement.
> >
> > pfc_en is already a field of otx2_nic but under CONFIG_DCB. Will fix by
> adding a wrapper function like:
>=20
> Thanks. Just to clarify, my first suggestion was to move pfc_en outside o=
f
> CONFIG_DCB in otx2_nic.
>=20
> >
> > static bool is_pfc_enabled(struct otx2_nic *pfvf) { #ifdef CONFIG_DCB
> >         return pfvf->pfc_en ? true : false;
>=20
> FWIIW, I think this could also be:
>=20
> 	return !!pfvf->pfc_en;
>=20
> > #endif
> >         return false;
> > }
>=20
> Also, I do wonder if the following can work:
>=20
> 	return IS_ENABLED(CONFIG_DCB) && pfvf->pfc_en;

This is required at more than one place, so will keep wrapper function with=
 this condition check.

Thanks
-Bharat

>=20
> >
> > Using same like..
> > ...
> >         if (is_pfc_enabled(pfvf)) {
>=20
> If so, perhaps this can work:
>=20
> 	if (IS_ENABLED(CONFIG_DCB) && pfvf->pfc_en) {
> 		...
>=20
> >                 req->chan_cnt =3D IEEE_8021QAZ_MAX_TCS;
> >                 req->bpid_per_chan =3D 1;
> >         } else {
> >                 req->chan_cnt =3D 1;
> >                 req->bpid_per_chan =3D 0;
> >         }
> > ...

