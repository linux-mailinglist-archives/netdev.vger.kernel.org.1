Return-Path: <netdev+bounces-95969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4578C3EE6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611D21C218D1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317F14A4C6;
	Mon, 13 May 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZWMoPLuG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA17146A9F;
	Mon, 13 May 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596142; cv=fail; b=WswpWpNTIvXLxjL6o9sGaCeh8zBNoIkiflTx+49bfLNIHXt4M6EoZg2RpuA/tS8m0uBa0ED5K4/rRhHaQQOsQQQkOCi/IFC9MpFnWgkARKMQbxJaDw1vsPvTx7ED4WmzM5YRrCKDWchQQOOyd/uGcEZ2HWUFFJvIX0Np2hRAW60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596142; c=relaxed/simple;
	bh=mEZjwY6P7ZUC3Apmrary82il/nDGkYx5+3CDRa8FPsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNj8lGQsouD+i92yJwcXgSE1k+CQiwohv82jfj6/Np7+DlBO45sMYpp2dJUJOKcEEboVwgotnkTa3wO7D1bpFdvq1kZvd4UhBFrbV/4DJOhG6MNXt2GQ8p2MQXIDxBLpLfTyzmsshfZJd2u9mSbkmuS77kuSLNizFKd/r9i6Kqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZWMoPLuG; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9g9XW015072;
	Mon, 13 May 2024 03:28:49 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g3ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHKw4AywIDB6itPrWTF63sDmmu+r5i/ZAVN2JWq1ZsTeKP6KmrOnJh/jSsIzCI+vuRzNBv8piR59OLk0o/p7zq5fWo3ntHEUNCv8TTvo3ywfnc02KKmTLQeUokkUIpk79n89uXZ7xUMrZ8AnU6042T/IHD+e3svkmvm/eCLxeGZbJhIjAKd48PHok68mk28fN3AIOfi+wkin+Yt7HxJC80ilawe+kfNakxcRXLK0DLl/OdHmzM3Pjv8RadPCJrJB41+eLvx+isdF8oLIwC5GU2x/8I8pKD3UiU5VH9ByJMgz2HzEXAsSU5KOyxbBrKz3tZjltTM8MhKARXg8avmNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEZjwY6P7ZUC3Apmrary82il/nDGkYx5+3CDRa8FPsw=;
 b=GT5XjZ1tEimknH+pdHn+rGDJGjgIAZP/uHB9hTf1DwD55kEb7Z1rd5doN5fHuAZnzAnJFZmqlzExTF7vWZpeMeX0RfwcQoDPrr+OxCub2bl2Zh8Vhi9K1zCAgHEN6/1qhcv1n/M3rnZbZTwc8PvFIWcNVoLNFDVGbBP/FO1KKLQwxicV7ZCsVOHcrMpYZp4MqhAOihS36cdSNRde7ZpWgIFLy0YjPLDwpulgJTzRqXq4exOm3h7WcIdjZJuff0KdMmFzGI3ASEuoakqTxwnfCzaGqbUgCBrPLLFpXxZv49T/rI2ajqYlpia0iCdprlrCN2LR+cmPEe3g2huGxctF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEZjwY6P7ZUC3Apmrary82il/nDGkYx5+3CDRa8FPsw=;
 b=ZWMoPLuGZzVCWx51bXtXRn7mN/hpir1fBLc7D4xe8JfcnwZrA4nLq24kz923t9SaHb77vVLeRMQQiyxgtNiCkYDQI+LxOlirBNNtc1EbLWIO5FKf5qezRFoQHEU5sw8oNHCzVGvau0BmnGrJbznPw3VD5rneToJ/UYiJmchbS/w=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MW4PR18MB5082.namprd18.prod.outlook.com (2603:10b6:303:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:28:39 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:28:39 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v4 02/10] octeontx2-pf: RVU
 representor driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v4 02/10] octeontx2-pf: RVU
 representor driver
Thread-Index: AQHaoJ0p8kX/ixOuL0m51COcvSl7QrGP1NgAgAUp/vA=
Date: Mon, 13 May 2024 10:28:39 +0000
Message-ID: 
 <CH0PR18MB433924F5DCB7AF630F3EF770CDE22@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-3-gakula@marvell.com>
 <20240509203500.706e446e@kernel.org>
In-Reply-To: <20240509203500.706e446e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MW4PR18MB5082:EE_
x-ms-office365-filtering-correlation-id: f461e81a-0843-4c9e-a313-08dc73377480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?rThIjG3xpFnIG85jMl9WUCDc0pa9KwzQ8Kvtr7cI4rWcmIxfhtWiVvuRhaBa?=
 =?us-ascii?Q?JxzquuADaz6P0p0Y63bEzy5ba1QMlbbYhIQKeTre2NeEv24s6OXhBk448ch+?=
 =?us-ascii?Q?DWMnJtEX0yC9gye4VMhK2v4ogfaB0g//TR8iLllt/XS6jqH0HE9qsAXT863b?=
 =?us-ascii?Q?9CvONOyGCDL3nwR3On5LVjVJReLH86ue8ipCdXXYdoueFF4Hr8mGuCXahHDh?=
 =?us-ascii?Q?YSB0y01BVqWo5w92sE2YTI0H06QX6MPrhjkJ71GDSDCR9GKCSkZyyg+uisGX?=
 =?us-ascii?Q?9mLi/fyBrrinJqF5HWUqZhgr5u3AI96no5aKZlfosXW/zKCRpf723/47+UCa?=
 =?us-ascii?Q?5gFMdHxttIWno4syV4XIsA6iZ/bZJZtrPMjNGsx83WsfvYS2ewsmssuePkBA?=
 =?us-ascii?Q?v/tFccNVrg4B73wFvBR1/AsBiPmM4ymhdKZ84resr7l0skOLl4ZVloJLUpuU?=
 =?us-ascii?Q?+/zb4H1IdAObl+PmXX/yZ3nQmHm9K2l4Lo2Rvs8+S3So5WicjDggrKmu7ThA?=
 =?us-ascii?Q?9spH46K7/hWLktUl00WXPhjJg+tHHv4G4g362MxPTrSpTZ/LXMakohJdOjgA?=
 =?us-ascii?Q?JIxXsXv9pSnh99Gglo2QCa3cwq46Yj1PMVN6ev7xUmaRPnla04yiHcXO80Pa?=
 =?us-ascii?Q?Qp8ZGbPRvqF50oq1cPkznlszk6uKcQFg7nVMC9wKjFTWld2MF4BIKvohtXSm?=
 =?us-ascii?Q?95Jd1xIytS1Y3pFMfPiDDbBpR54kjZl3JmBjFPCKaMA1F2/SB9A9K6ZMNlZ7?=
 =?us-ascii?Q?OafBdr76y6Qhxtk/iMo37IVK85vH5QflDolUyOk3mE9DqFbz+nnppZIjF74x?=
 =?us-ascii?Q?vQsWIyO8Z0pN0TXMjNPwuT9xLX/g6/HNTjRKcbhvbLF1b/ZhjJEGdcTQmrr7?=
 =?us-ascii?Q?I3DVow9fdOTWaTerwgnpAcwnD/KQLZyqT32HQSu+2jHyo1loTh4KD6aBDpCI?=
 =?us-ascii?Q?xgBkcY3Bf4Kz/1ccSx/95g3GXQbLGoLpK0lOUZegWwNvTFdVcNVWqywnh22e?=
 =?us-ascii?Q?SPbT9/IBlX49ndlBqbmCDFxhaNjcC0HpG77MfcjpMIyAIKdzgE6Ij+oqwdY8?=
 =?us-ascii?Q?2DV9vUqrHebAyNNTlVRQXxnOGOzw0mRfLasUywBspvo9j6GVBIy2KsDJVXX6?=
 =?us-ascii?Q?+ypDZGbsj09xH2t0clx3MPO43w2AAopjrtGZQpb2W0RcgHNbvdaGgyW2ZPC/?=
 =?us-ascii?Q?Pm0hPL9114Kta7tQCKVplNTECfv4sZbi/QFJcszDIwRxymMN7rHh3tzW/bVc?=
 =?us-ascii?Q?SthPnd71e1zYb31eDRUaMWIHzt0F7lAbDAt8IMPtCkFWWNlU20c+lnpN1eyi?=
 =?us-ascii?Q?/Sd3aRwxlG9G+MeLnzdIxHErSVCK/xoL2JBUmlooWHORCQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2EJwxBcxteBnj17ByP1s8HYdkDveC3ctcJk8KokwqqH8hoga80dO8MbZ7m2Z?=
 =?us-ascii?Q?607GH7tMltlYvdzsvokuUKMjvQc9FjYXPBLNEyWM8pJGCN3K4R5h+xR8+kih?=
 =?us-ascii?Q?rOQ4ZnfmRJdTxEzK5nGyjI36/HcVwFO+ZYDeIvDsYPiDrhkPJ7hre8t4XWVr?=
 =?us-ascii?Q?61Jt3BaHCamYVNNceZrM0CMj/sEmIVQqQ+TrHJYLu7hzlE9qKk33nMnYmW9n?=
 =?us-ascii?Q?yYv0quE4OvxTKccQpgiZ36C7xp4eoNEDWKBWW3XMZr5/ybakGdiyUQMBkNDd?=
 =?us-ascii?Q?Vwe84Fs8e25UY2ZDusCUXVc5ubYURlfbJO5ZadKMcLMtTh8Acf4J3xcuZ9rr?=
 =?us-ascii?Q?122yAo/J5eZ8h4rktYMTT0vdlwT5UxnBoSL7tThJNUOxKiBpn6UeK6R+GsLk?=
 =?us-ascii?Q?3i63Kn2WKQhrgXxlJSqazqeFvDD9/+Q4VdQ5fkmgKTDimr6syPr02bmlml3O?=
 =?us-ascii?Q?j0Slqr/0c1zeUsIAvYaKJCjhA1m03/bvHrZYXIDvnArLSM7OMfjhjvLosbbM?=
 =?us-ascii?Q?N72EHpAfObBrGFV5uJS78s+ejuCmCAjNRqPpKSoz72GTwkKwqxgrb8fnSfPb?=
 =?us-ascii?Q?idANMIpXR5mr0tSd5sWlY1Q6sp+oanmDPQaJ4csdPUL3ppGxVP7DluAHFCnm?=
 =?us-ascii?Q?b9rUXXLaLXhpQbGAch+bSNWluGAuzZFhrB5wAML7G8rZAwLhLwSIvJKT2kY3?=
 =?us-ascii?Q?xrkQLyAID/PBcj8Sxv/60aWNi/xAtL9HIiM4DzHP+I7WZLWdmwmbwiHMfY9Q?=
 =?us-ascii?Q?L9PcOjyIJahAqyHe7XTtlB0TaZyJtHSpksLz5SPttu2CDhVIh5HFKV0s/d1s?=
 =?us-ascii?Q?bvWWcAyPMfdU85xOcux2PTAge/4IwF+s+qRonqv/XvGXZzifolmqkfP7PS+w?=
 =?us-ascii?Q?ki+j4SJlE3XZ0NgY7Hms+rfH/C6J1yuSP0fq0RGCdqnIOy8NiBAPIPPYGbez?=
 =?us-ascii?Q?FRUHWJAy8KcJSSYiFFpSgvgOmj+1s61z5jjlobwRFvfzib/g3R2J8U0a6TTW?=
 =?us-ascii?Q?/QJwhQIeLwFiEq2TM2kB9ZFU85F0xV39ZPDJmh5NkeSQ0rJJs5fW8FYwuLt1?=
 =?us-ascii?Q?dO7mNWgUug3k9nLwdx5X8eQB3dmOp5XQNzByvLSjUWLUM537zwiKe9DXmcNz?=
 =?us-ascii?Q?aLf6yh+J+1qFto2VL3uYqsXaStKMmYwE0IZbh6MauIbi5GgekHrnFVG0fP0H?=
 =?us-ascii?Q?m7KljhrsvrFhlHXBWxDGBFWW22f5I1b7lQiFUIy+KuXIj06JwS6yksw6gARU?=
 =?us-ascii?Q?ASEoR5s80JMN5assPJjSrqFpZlFqY7RU8GbqlVSBiN7NiTb1lbwuN8/Oikep?=
 =?us-ascii?Q?ZPLRPToHu5ToVYQJxBpKS9TD6W6cX+v3mPSClwCL1N6ucDGk6hGTPskxQSGW?=
 =?us-ascii?Q?e7MXdBrvpf4rrsr9tqhuBty0Zm8S0klQFUZ8GArNV5rv/VJ6YVXJVlS3gBWc?=
 =?us-ascii?Q?aU/tNDsrayEKRHXHyeUvF2t3Ji7wpJorU/FQfON5YQMudHHhzQvxWIxuqGyK?=
 =?us-ascii?Q?nEGPU+BDsDKueZWp2fT7spYyfJPooLd+ZOUM8wI5nIs1TPg4xre6lffJ37JS?=
 =?us-ascii?Q?LzW8LMIUhNKzSz86Q8w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f461e81a-0843-4c9e-a313-08dc73377480
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 10:28:39.4479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bwrhqb6qzmVd4sNKqWbdpVLO+73yewToGpIX4nlE88hfg78UgJFk/Q+M1Xa/yaOy1lMdasNOkOwCgXDltktlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5082
X-Proofpoint-ORIG-GUID: AC4pneFGjCJYCHXr2oiFDU6eOAeW8tVu
X-Proofpoint-GUID: AC4pneFGjCJYCHXr2oiFDU6eOAeW8tVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, May 10, 2024 9:05 AM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v4 02/10] octeontx2-pf: RVU
> representor driver
> ----------------------------------------------------------------------
> On Tue, 7 May 2024 22:09:13 +0530 Geetha sowjanya wrote:
> > This patch adds basic driver for the RVU representor.
> > Driver on probe does pci specific initialization and does hw resources
> > configuration.
> > Introduces RVU_ESWITCH kernel config to enable/disable this driver.
> > Representor and NIC shares the code but representors netdev support
> > subset of NIC functionality. Hence "otx2_rep_dev"
> > api helps to skip the features initialization that are not supported
> > by the representors.
>=20
> It's quite unusual to have a separate PCI device for representors.
> Why not extend the existing PF driver?
> This driver spawns no netdevs by default?

Sorry.. strangely this email went into spam folder, and I didn't check till=
 now.

Our's is a multi-PF device and each of the PF has it's own VFs.
And in HW, packet parser identifies pkts sent or received by each of these =
PF/VFs by a unique PF_FUNC (15-11bits PF & 10-0bits PFs' VF).
If representor netdev is registered from a separate PF (ie a separate PF_FU=
NC) then at packet parser it's easy to install pkt forwarding rules.
eg: representee <=3D> representor

