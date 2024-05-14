Return-Path: <netdev+bounces-96291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B38C4D57
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0940B209A1
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282714F6C;
	Tue, 14 May 2024 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QZFeTVE9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323A13ACC;
	Tue, 14 May 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673263; cv=fail; b=IZYbPclP+ix6HazXonjKYxs8cPNXRCwdpo/ZShggmgEzd2+w3roBkICnH/om3UE3wm6okAMYYT/m5ZhYOfE+lvSInv4RTEPyPtUKsaKEpBh2ZfLA/nuPlTjwMFCgm8nYhxyKPAClvjP+mknTpzGKlFXv18zCDI1dC4+Rme99mNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673263; c=relaxed/simple;
	bh=ycEgVTSwceQWkhrIyJlpNOp9FCrLkRDlrv/w98lQq6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mbvlqn/6GPbkmRfs6eymSc/ddU85xX7FjCHswpZLiI1ALhPcePI3SBxTpZL0lQV8xaYHuNIZKtWOQgb8E9+YYxoAQbdSmaJNHNneAkjmdb1ZiZzVQLdHKx1LbNT0LBdMjwmoJWsNVx6W82LrOlqeXoI/NQDNr09vmtDk8YRdPiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QZFeTVE9; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DM9rJP013251;
	Tue, 14 May 2024 00:54:13 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y3udn99ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 00:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9oQI1HOtu6w1pCDEWjT4P1/eJT15bgSWDQIvWVRGQByn9cLcTH8srbIzKGh+ovIes6lkqVvOBEa4BkQ0UMwUE6/6mniV8GGpSXtNwGmkKQPfgAQ10Yl9e7kRbzP1f4jGSVZgNA1k/vLDzrCoWsgfUcNkf8n8KpTg1ZSyJfO2h83/Vfoyli1pFnF1ub2hOdVN4h1nuMaJsEQ4PRuFGHwJP+bOe68kmfBpMXpBCA9463nKo3BatWwIuX2l2g5vE2Hrx2M0MssHAfTUmz4vp9oM6Qcn9ASrFnOsUYQvvYygIoNs+yHP9XUkORHVU0tvzt6ysLqkYJYiVnVYc+Rgezp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFKZxC9d0+AYDpMUTxo4gF1fGq+hTb2vLD2pZSo/ckA=;
 b=AMuoNHTAGdhFGjNtmDiW/8bVIJXFYWCiKI519Ks5NaA87/S3ecOSBI8zArzYO+/uwFXJ8w3j4UCTRCuoz3KhPuqy3kH1WBNL1bWqjiLbBOModWaTUSCsmpfAGSOGZQTPdvsiBXSlB2JxPpa1Dq1mbcrvmxlJiLTFcvbDGNy6kwzzlsvVml/8CRfzLOm4aQnI3hjYgLR0MQgnvNXp6WKqToQX5/Ta/x/NRghUPVJZggjL55Vbm+2H4S7xhsgSO824yPnJG8QqdG+sp9xfchWIFHLK2TgVcCpemNvYOd/DUjg3tZ81/+3kJCQBU7Ay/pPaQ0BhCc+jIJfe4itr3/QEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFKZxC9d0+AYDpMUTxo4gF1fGq+hTb2vLD2pZSo/ckA=;
 b=QZFeTVE9pzi7v8aWvhxfPulO9bssqwtLtVfECAFZToNURXG2srSLm0Xq4CPmMY1V3M9ck6TcXbw6zrnK6e+lP1gKasqGFCc94EAIjl72Mqzj3046IGNQ6MElbjQB2kHQVVon0S3GptAtLG/ZxAjeCYYcdhM0Gy8MCLI+YO3Llvs=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SA1PR18MB4646.namprd18.prod.outlook.com (2603:10b6:806:1d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:54:10 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Tue, 14 May 2024
 07:54:10 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin
 Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH] octeontx2-pf: devlink params support to set TL1 round
 robin priority
Thread-Topic: [PATCH] octeontx2-pf: devlink params support to set TL1 round
 robin priority
Thread-Index: AQHapdPn4dklFnNCykOp5VltXQLq0Q==
Date: Tue, 14 May 2024 07:54:10 +0000
Message-ID: 
 <PH0PR18MB44744704A95A0BAD5AD05856DEE32@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240513053546.4067-1-hkelam@marvell.com>
 <20240513161817.048123bf@kernel.org>
In-Reply-To: <20240513161817.048123bf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SA1PR18MB4646:EE_
x-ms-office365-filtering-correlation-id: a12b631e-c04d-4fe9-fc2e-08dc73eb09ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?KJGRuevarRR38nvNHU9k1ba4Kd55RC4XkKBQsR/rJT/98rMaugFUqiMDrlw6?=
 =?us-ascii?Q?tjA58jGg6jwV/lzlect5t5cFKc7egfosv26rOFYUvXA63DGKIGTnui4zsxYD?=
 =?us-ascii?Q?O97DGLzIzekQJNSL4D0AhEOaQA507h1gwdy5wJ9etP0LC4UbmY1hzooI8W76?=
 =?us-ascii?Q?jOM5Su4UOsJp3l4mKnKJ9JLuUeBqfRbcWz2bzSAGGfTCyVXZohkITa0UNBoa?=
 =?us-ascii?Q?LZg3jbBfI42hYFPw2OI8ls2Pr3g8j07SX4KKOKOM3f1udLlWYvEf1mAleDue?=
 =?us-ascii?Q?A8/P86EUzYsnIn4Ei8A7546iHEbHY2ddaf1ClPc2yzbKGq/E2BZeSR5ZzTx8?=
 =?us-ascii?Q?yZJC29xGNZClxezcS+nkq/aArhFKa9vJRDBClK106RUnkKd6bFmyNKCaB9rr?=
 =?us-ascii?Q?vJ8ErkcPPJp1k4E71wauR/pjiZi3IRBnFTOgxGOuK8/YaJccH87g/z/vXvfr?=
 =?us-ascii?Q?RGOCaWj/GFs3qRTpIfyCRTVrmkyyNx7KXY5UokJSoLsg5/YdrClWDi3OkW8f?=
 =?us-ascii?Q?WrufKlg0jQZUPabaVLRlUjJIgPuyCYNSDJQjB4XzMPeXRuYyuAVdpXsOzKfa?=
 =?us-ascii?Q?tszOUbz/aROU3GihQlyrMG9RLfhXbfauoBTPlZH38RxNbAjg0CbByXgedExh?=
 =?us-ascii?Q?GklHEL+pPb3lft4wAebsnWeO0OqoWB5okPM3eOl2NR5xhuxOBRBN3sWkGj+h?=
 =?us-ascii?Q?ERATik8yx+Y+8UBHDhtHXlgcV/LSnqGmepDSbZyOKtsyegI/cCBPuRcuoWZJ?=
 =?us-ascii?Q?puL5n66to2Enf2tryhgwexslqVgNUZhgVYXnVxvBrDMBu8aqkK/Fi32B+yrr?=
 =?us-ascii?Q?B8GByfihvcpldedpYRkEQDEH+arESgj0wrvp/DU/X/Uu9ihP4jcn/2WT/vV/?=
 =?us-ascii?Q?JOzNLD40/I2qS3eXbbTIJ/WRz2QadhOsSkQmvJivsuOkBzu6fjrebywJac0C?=
 =?us-ascii?Q?BXvKdG//2N9BWe4IBBRNaKQ9O/EffwhWH4M6SRYNrlPNtNg68+iyexf9KI13?=
 =?us-ascii?Q?bJ7WCPiU0Hr2t2BVSm+fcimKSw/i0uiDXDEyBRRBY+hy+jvMD1Yy+jGqVtpI?=
 =?us-ascii?Q?5bYZBb/6eymePYU0Mz9C6q+p3oZBSgz6zetLHkyZEXenXzKSBcuyzyDXN2cD?=
 =?us-ascii?Q?UqJjyfNf5OeHWSl7S+9LMUhZVlPaDaGlbcLyHP+byaJQh0JN8hqSAOlsIkgr?=
 =?us-ascii?Q?aLYuUJat01SecF556/QPl4JPVx5fMgOJN/KhNMutF1vWtiX3KoIYUgP51dnW?=
 =?us-ascii?Q?3uTHx9V8L/2fC60VF9rXNPKrIcGUbD8d/dHJstCgTkM4if7+y0ySVFbBSBZd?=
 =?us-ascii?Q?62sb1kCIxX0cMJX5Y6fhlsewKjBeXFry7Fb+yWvfI0fMPw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Q1gfEHs6bZ3iNzIYzjrDFmylGAQGD/UAjv/P5yBzrVOHq7iiCj1Tkh6eaOPy?=
 =?us-ascii?Q?OuhXkbkBpaAcuVJqKLhv2cswdoZ2//90bcE7I5abdoWjZpcasBIqysct1dWv?=
 =?us-ascii?Q?r7smOLOA1hw32z/ieYb32a4AiFy3Zn1ZDjFieqnq+qLxGBxrM/eSBEdO7/lZ?=
 =?us-ascii?Q?GXC0oWgQPGTEOJBB86UDbNuzfXeNvNp2hlYLK1BdSXDtSXcxaVTm7gsqLil0?=
 =?us-ascii?Q?5uSS3YQeSnxxCBl3QDBTLUUjuouEOY7QPVTHWxmIoBfdOgYOifMBVG3f/5xV?=
 =?us-ascii?Q?2HiOaMyILi5UfMIToYvJthgRbELVUsKaHbUfO8dT6B5Ai3cD1adXJUASWKzE?=
 =?us-ascii?Q?X8suxdA8SzjkQ4fegAu4A0ArBAuFbeUEi1CtwG0oX0BsBM9VzUpUXBagx2g+?=
 =?us-ascii?Q?gZzqiOcb8Vj3pEC8N5MZPHFO8YV703O8NPY32otyP6K4n9XW2NqtkSaJUEOH?=
 =?us-ascii?Q?wtvoJ6chTppCSxGuToUx/XSXVovCe5fw5ghBNDLz+OhHH34YK2Mv8Lz8/NAv?=
 =?us-ascii?Q?XCb3xgzQ0DsnrLJFhNKd7Bx/fqEaZ2t3AB4Xg++2EvOejE87235+3FUmtpDL?=
 =?us-ascii?Q?De5e3SENDzHU/KvLlO94HbB8YU9qDuuGqqu66Pw6NeWNaSL9hZPwuOvwrYzE?=
 =?us-ascii?Q?zGpR31lS/lRjVOS1wgR2iuMf6LEqJL3rKYp3LRNyp7X7z1hJieQnyitgKcd6?=
 =?us-ascii?Q?lP1V8IJGfqt4i1QkZugFy/TpgM0w3EeS0lN0kbFRtlxCCfxeShdbvCmrOJ8Z?=
 =?us-ascii?Q?I/crVBjEOJ1YIx3oe4F3/3LHNuyjRZC3w4j1Hpi8KJ/1m5ZZwKxAfUHj1Vgb?=
 =?us-ascii?Q?jWTkaeLgjDFPIqwWhMftl8TDpSBgubK1p0bI/F9lF8/4vCMS/n+7xBLKWEa4?=
 =?us-ascii?Q?ZRt/nEkPCO0qPhEW+5Bck2GB2myQFPacfhW+s9Zqj6VM7u6mTz53Ypw9WMtV?=
 =?us-ascii?Q?SrElE7q1nwmBizJN94XcgrBBGd0sbsT/OYchX5Luw+MnlP5Hnd6C44E0TV/7?=
 =?us-ascii?Q?0Qoiy6O0MFR3S4iCseazEj0OsLv/YSZ5UVhlErIQcJRgX3mFS+ifywFm3wOl?=
 =?us-ascii?Q?1MYEQE1Hd0wEzLhOjzm4Iix0o/D9btqlk0XDeohqR8N0GnrYhYoZPAzk9TCk?=
 =?us-ascii?Q?+KphPhq/tGXW5Fo4Veb8bA7+caxX5OcQBfRX8cxKuppGw2PXNPoU7Cr7ELRL?=
 =?us-ascii?Q?SxJiBJCGJ1ryxnpcJGiHgnGDeQ8CKF9GTkll3sEFvYpCNHjexewWd8Y6Bco9?=
 =?us-ascii?Q?/wyoC4mJ+tbVNgPn459HMsjdxarGwhD0vMl5ci+Nt9RzxN1DobcH7LQodH96?=
 =?us-ascii?Q?YLOBoZaJMX9VibTdcev+ZdIM6hzyLXGm/BYd46uYBASxwb0HAMCvHvmsj9Xv?=
 =?us-ascii?Q?JrAYr8zDN/Zx4r0hDeUbsIkOMHt07sIdV/0KLFe8JUjAHiq9Gq/hFTMew64g?=
 =?us-ascii?Q?BiT5YhZzPP0VszlqgxGUzRk/dpSajW8PNFwTgqLOrczUwpiH7A+1MknSrpL8?=
 =?us-ascii?Q?hDR621Lvcx4oYcmvnyzZN1Poqo3+0ZO8a/Z1icI00VK0b4evkb62bC4pd4iU?=
 =?us-ascii?Q?fGOYkQJdtqBgLXFMm65hENuqLOj8NzmV0O8qMM2f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a12b631e-c04d-4fe9-fc2e-08dc73eb09ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:54:10.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YFqOELl7WvmvumGYYvvWDVZIflQtQjvcBsvKo4Ish61PLdc3zJuMaYO+NIhFLc6n5yYQnIYpKhkoE/yQUIuBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4646
X-Proofpoint-ORIG-GUID: H-I5C1P5wtGVdXGPoWLUA-JfLhZ8k4QQ
X-Proofpoint-GUID: H-I5C1P5wtGVdXGPoWLUA-JfLhZ8k4QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_03,2024-05-10_02,2023-05-22_02



> On Mon, 13 May 2024 11:05:46 +0530 Hariprasad Kelam wrote:
> > Added support for setting or modifying transmit level (tl1) round
> > robin priority at runtime via devlink params.
> >
> > Octeontx2 and CN10K silicon's support five transmit levels (TL5 to TL1)=
.
> > On each transmit level Hardware supports DWRR and strict priority,
> > depend on the configuration the hardware will choose the appropriate
> > method to select packets for the next level in the transmission process=
.
>=20
> Configuring DWRR parameters seems in no way HW specific.
> Please work on extending one of the Tx scheduling APIs to express this.
>
  The driver offers per-interface DWRR params configuration with HTB offloa=
d.
  Below are example commands having different classid with same priority va=
lue

tc class add dev ethx parent 1: classid 1:1 htb rate 10Gbit prio 1 quantum =
2048
tc class add dev ethx parent 1: classid 1:2 htb rate 10Gbit prio 1 quantum =
3048

Due to a hardware limitation, only a single DWRR group is supported on a tr=
ansmit level.
To address this for physical functions (PFs) sharing a transmit level with =
their virtual functions (VFs),
 a devlink option implemented to configure a priority value.

Thanks,
Hariprasad k

> pw-bot: cr

