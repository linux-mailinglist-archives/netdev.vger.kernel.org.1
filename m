Return-Path: <netdev+bounces-100110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6118D7E59
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD76C1C2099F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DF5FDA7;
	Mon,  3 Jun 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jxkNB/qi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136553D549;
	Mon,  3 Jun 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406330; cv=fail; b=e6jP4x2S9KiGFYuLR2LhE3LN3WTfIfJSwht/RpFj3A7JZRTY7ws/5CAgoMmgfl0KQlLG85AP8G9pQdL+ut9uFRwWFc62ew8LsyJV7GO6Vdc8YNxbyzniCyPyMeYge++47F5t5xWR1DU5lvFQlOV5qyVLh7J7m1xbEtOW+1mfSxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406330; c=relaxed/simple;
	bh=oUcyX1QC0waMplmcpxrRbcZrtuB/I8uhW1/YSoTIiDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPEh+HVyz3qwAtZVT7RMGo0bmvmYhb8LgWFOzttuwpaSgxvnsDrOlijkwTChUW91BkGaBikAxN0jclU3pWM0Ri63ltff54FBE7PdHHk+UnyyLEC+jajVqGm7QGAH6JCGL19nuOff1iQpTaHjTzDA5BK51MVY+r2FUoTcAG186qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jxkNB/qi; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452Nmwsx027485;
	Mon, 3 Jun 2024 02:18:38 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yg35hcaqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 02:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR3nQbPScyMiDitXHDEnmRnZFSJluKOVnlGOJ/wNcJQo47eNvL0W8sEDSIuVDwkOaMXP91zBvmld/PvvDNXBMcUVRhROSpaHIZTw0p2qjokLZw9kL/BQ2wGZQdA4Uo12mv63dj9oE3ySs3S05dc554D7bbqfnAEL17DsMjJKW3IOxQLtD/Ou0bOuXkFhpne4mmenGNlUR48wZG386AlKgvCRK7/hGE5QT0NoI8RYH+UfaHEn6O4hXmuCYpO+LXtQ5eW55E2W1pZ07LyhDHGGu5Zia4aTvkxOLqXE01sYl8sjd9+mVIe+NlFQBVrDBoUZS6qbD3jTq9Dxu/Dv9hwu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5jmciu/SBM7tZAlCf8NES35V+eEnr/kswpmSN7Y7Fs=;
 b=W9MGUbBXKdP6Qk8GRWglQiXtfYQ++Yot9bSFgrthkR6Lmb6psex4bF1r9SLHN6Pp7fHgYpnbLncj4JsYZaTMDng2V1v5w+l80raZ9xzXGmTk7vagELrwXI5ooyMSsokwAnMG6j7OpiR9GrhOm4JWHdtKrQqpVDzIJvh0quCbUp6OprEo1DfWt6khHv0TGjCm6GaYUKcSQCN0TaI1n1xBDIruXosNEFNLnx8r7LU73hjqeMyn5PbqBhnm3ye5WkIrUpTayIWT8/2DfJkW3U6CuHrMlhAJ0j2lroTPZ1VYmVDJ9meTAPXj1zYTonAt8/w+2shvE5Ap9iW41tfSyeC7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5jmciu/SBM7tZAlCf8NES35V+eEnr/kswpmSN7Y7Fs=;
 b=jxkNB/qig3BlAecHnRLjjFrD0Pli/buX8Z9xDNvGGVQktRfWV/b0xHExe3KI6sgD5kvwjrdlD+SwDQ8btIACzGf4mL/C9uKLXUDGpjp4d/n0qwud8/7tIHqlDfkiMQoEkQdTGfMow4jnvHr/uzt1oJKEC8Y4moCGr0VVLfeXyyg=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by DS1PR18MB6135.namprd18.prod.outlook.com (2603:10b6:8:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29; Mon, 3 Jun
 2024 09:18:33 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:18:33 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Leon Romanovsky
	<leon@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geethasowjanya
 Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Jerin Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
 ipsec transmit offload
Thread-Topic: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
 ipsec transmit offload
Thread-Index: AQHasQaTfyi6mWkXDkOBPclCj0tdJLG0EIWAgAFrzACAAE9NkA==
Date: Mon, 3 Jun 2024 09:18:33 +0000
Message-ID: 
 <SN7PR18MB5314D17F56C125A6AB36AD88E3FF2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-7-bbhushan2@marvell.com>
 <20240602065125.GH3884@unreal>
 <BY3PR18MB4737F1C148F2C230A4ABC49CC6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: 
 <BY3PR18MB4737F1C148F2C230A4ABC49CC6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|DS1PR18MB6135:EE_
x-ms-office365-filtering-correlation-id: 06c24045-bd7d-4ff6-2a99-08dc83ae2424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?hqHXOz/VID+KdoW8H/PW/C3LfaiyItN25evkBz49vH+b3JOLsbs2sAR2RQHv?=
 =?us-ascii?Q?2BTHS4t72HNa5lvOo2/Lg2ZIbslJLuz6akuQ1rlfaPY/aGWflr5Sur8DTzZC?=
 =?us-ascii?Q?wzJCVxsJgI9yT+G2uPID5fE29Bj+PMZdQ3JOgpo/7VD/8J+c23sHkbCCN4lN?=
 =?us-ascii?Q?Ey5IrymjRMuPsHJvRiOoxdd+Mc4GKvJ3VZQFlJROBk1YRSdp7NLd/IzJtHnI?=
 =?us-ascii?Q?8KjUD9FKFFazbBPogfEy4Wbs0gFCrK4vczWf8UJklGixhmzgYPBnL/5ZjYYS?=
 =?us-ascii?Q?tMMB8NgdDy7V5gMSUuSvrmy+oZEOzxjn7mXHDxLTDz8jDklQSe5wwcv6r8ee?=
 =?us-ascii?Q?T8lNfGVCq1lX01+QphiuEQicvmDPi9mU1VYV5LZ+flBEgHx0oIp8aOjawr86?=
 =?us-ascii?Q?FJ1IhbW/b2Ume4VkWn7R7w76NkIiUs4HtmROqA0BHkXThKbl7vdY0tWGos3U?=
 =?us-ascii?Q?U5pxmU30Op1VgYjJhODp9+BnqnvSJGqmBM3nu5wckJyz09ko4qfxBlwhPHzo?=
 =?us-ascii?Q?ntTaChVSgZ209idJeuMT07y6VhzFLhBx/T4oEcGSjOe2mA7megHiHg9qK+bP?=
 =?us-ascii?Q?fbXdksFcIdxTyXtYsug4FSLg0f8fJrOp/30xcJTRDHbBrNThPJPZcfqjxFRD?=
 =?us-ascii?Q?pmHEl5CmQQYcQ2XvI2ISwwATanloSnx7EXaEDc9C88rqjtFkaWbEDE3EciJq?=
 =?us-ascii?Q?odI+m9EPuWXO9YsHtJw8g11XlSvfWaYgfSRIpEXPSR4zBd6ZeoBStgDWugm7?=
 =?us-ascii?Q?IjwtScV+c5C1VOgTwwwg+pH8khXW2zMkMQJ6ImUGRq68zDBy/G/7xSGgRKc9?=
 =?us-ascii?Q?rcvZcHgPD/hf8rb4lmBy3I1u/8fZPB0U8sBq6TEr52mH5hhIHlLIHYkQlELx?=
 =?us-ascii?Q?h7pALuPK6Mb4LM/n54dhUShDJvbHbOM90GrrFl2fW38JEtuHeKvG1NkEu5Hq?=
 =?us-ascii?Q?tusMM+mPgDR+gTVLcSxWh38sFg69Y9l65ltwHgg/QiuDwfWmlGO8IeXIhs0E?=
 =?us-ascii?Q?sGeILHhK6jGda2qGUvZgFlvAGxJatxUlbN4jjJ4ipgXOo+cE2K9++P71Uzu8?=
 =?us-ascii?Q?RVtH9zsktSbdCOMdoxOWswA08teRfmt+yVPvJCsi9B6HgJTt4xwItQAL3XbH?=
 =?us-ascii?Q?26jTcWLznOZkNDbpyMbJRy/85xtbcJdm3RktEOWivSNq/VL143h+n7kxI5Np?=
 =?us-ascii?Q?FN40MZv9VzLI06bI9i+PtDDSnhKBRqwyJXySmt/kchbcLdwdCjb/q0UF7kDp?=
 =?us-ascii?Q?gotH4qAXO3wciCA29WbQdCvgbK4xcAgdqjVwLorOG1/wQfW0UKzLM2dFzmCf?=
 =?us-ascii?Q?NUFuVUbOYqsQhdjzKX1076J6?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?E+9/1waeyODTJ96j70yiSHqwwyV7hwFoEQ2N+dQhmv63y+wU4joxcvaP0M8k?=
 =?us-ascii?Q?q6RrtnHR+XQsAYDfp4nPqDj86kzqdix9W9MIx9kajuSgeDg9L1WWbRTxaIKj?=
 =?us-ascii?Q?+/uKTvn/61lQ7pC6hkn+ZCD/hW+q8+3qC5O+NfNuhV/66CaqJI0CsnxAabeJ?=
 =?us-ascii?Q?ULfoNaKVDNik+JGhNNjxPC8rhKPVgieieBImipWMqsEFWfkNe4N6H5FY2Ayq?=
 =?us-ascii?Q?K+MilXMEgx394mNQ3I42O7jfXRk9nowplgzZIdXvsG0SuEOuFu0ZvAwrQhhw?=
 =?us-ascii?Q?pn4Aspneza430sPEvO31at6vcfKT6YDAX8lDEix4I8fUFf9qux2/K79caNC4?=
 =?us-ascii?Q?yKFXXXfJ8lTrGLM9N7COMeiqePZsMBwRJkD1abMeGjiAdcPWKx+6FmtOb2WD?=
 =?us-ascii?Q?XSMNb0AeV+6PT2nJrt0s5ms6bViFw6sx6VbAL1Slwx9sTtRFhMSJyLLoWCp2?=
 =?us-ascii?Q?y1nu4ZltCqmQzm3dWYGxoizGgFrzpN2ig0rcbz94lfF9LAeQvVE7oCX4srDt?=
 =?us-ascii?Q?jZhVwKm8vmcNy2p2xKHBqQhCt8gBaEgHCnzH0ROp2dhA2glPE2rI6rO+5KxI?=
 =?us-ascii?Q?VbP5R5xkjZy7mLODmA+yH0/A33WCcpckj1jBRtmNQrr90jMgABPwV5Ws+ZjH?=
 =?us-ascii?Q?XZs6QzD4HeqXdY3x4U/zbDA4gExt2QMe35sxP84Pym5C9AVYcB6g7a0OdiPC?=
 =?us-ascii?Q?Xe6FgRmCHu/3NnsBmHfmo7agJTtWHoEFAHlLqPArSOTLKz+rW9klaGFR5Vd8?=
 =?us-ascii?Q?7hA0O9vD72sKIUs4GE0l1kBtqw9Y2+JaZyiZJnJqLQ08r9MeENmi1wH8OgqH?=
 =?us-ascii?Q?GZRlAh/rJBXRMQxXBuz9T+w1ruf3S/TyUDG2YLcDBJGc0Qc6EysulkPpa6ng?=
 =?us-ascii?Q?/wLMCl2gjey2PmboNOg0nek2qJZglgHZ1aTybFsXbU4MqZfb2WSm7bZV3xxP?=
 =?us-ascii?Q?BVJc3Sed0pKjCw9lu8mfgiJtsDhKqeQC7nKqzMBK5WoUofqrFXF/BXf17NGH?=
 =?us-ascii?Q?et5wOz4D9vPKMI0iLJJWDgzY8+BP4PjILTvox+PuA/5V2axn9F6LjVvdyco3?=
 =?us-ascii?Q?3bIKlyHE7XWMy0Zse97jorl8H6Fsmy9/+H5qWsE2hprCx0WL9armZDOaGFmh?=
 =?us-ascii?Q?zbSrhMV0zmaE+yCb8ia5q0opWFIJhajTlxi6DAB0MNnHitBy0esfPZA6gnSx?=
 =?us-ascii?Q?7kUEAQUeowT7hMpAjY1lX1o0+6xLco1GMZArO2uiHUizteIoJikBFqcoMWP0?=
 =?us-ascii?Q?jI3nYFv6puIVG2cPJZ+ewuqYx/O8RthFfinZUtTEbZKVpd8LQfJsGam1avUU?=
 =?us-ascii?Q?YamAnXL7uLUqnFBJNel14OeX2+KopUoQf4lUMq3iadQdnXdYPd+ikddmXbSH?=
 =?us-ascii?Q?NDHEUzg3QCV8Ggitnx/8xvOsy9ecmjzKH+d+8c7HNAp3dEYXESFP2ZB84+Li?=
 =?us-ascii?Q?iKCWbOlvv81UVR1SLGPr7SRZNfBlh6WyYOMkt28hOulmOUzosqsUmIvYAuoZ?=
 =?us-ascii?Q?ckgxAntJ5bD/3WxSKymrwaMsCG1LGjIC5VlK2b0fjCgTcWIZZYxRo/q271Sg?=
 =?us-ascii?Q?j2z21EBJtaN39Si7mOsC+ya2j0x6hALuNquMMQkE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c24045-bd7d-4ff6-2a99-08dc83ae2424
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:18:33.3090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWK0hWq02prW8eYguU8LCoszLp0UrcK5AN/s5WsVjO9j3NOTc/48BMra3smGpsByXLaWgZN8MrTykI13f6rBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6135
X-Proofpoint-GUID: WjCdkk2mpP-Sc4NK8upQsHdQT29zHC-j
X-Proofpoint-ORIG-GUID: WjCdkk2mpP-Sc4NK8upQsHdQT29zHC-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_05,2024-05-30_01,2024-05-17_01



> -----Original Message-----
> From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Sent: Monday, June 3, 2024 10:04 AM
> To: Leon Romanovsky <leon@kernel.org>; Bharat Bhushan
> <bbhushan2@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Geethasowjanya
> Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Jerin Jacob <jerinj@marvell.com>; Linu Cherian
> <lcherian@marvell.com>; richardcochran@gmail.com
> Subject: RE: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
> ipsec transmit offload
>=20
>=20
>=20
> >-----Original Message-----
> >From: Leon Romanovsky <leon@kernel.org>
> >Sent: Sunday, June 2, 2024 12:21 PM
> >To: Bharat Bhushan <bbhushan2@marvell.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> >Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> ><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> >Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> >edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> ><jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> >richardcochran@gmail.com
> >Subject: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
> >ipsec transmit offload
> >
> >
> >----------------------------------------------------------------------
> >On Tue, May 28, 2024 at 07:23:47PM +0530, Bharat Bhushan wrote:
> >> Prepare and submit crypto hardware (CPT) instruction for outbound
> >> inline ipsec crypto mode offload. The CPT instruction have
> >> authentication offset, IV offset and encapsulation offset in input
> >> packet. Also provide SA context pointer which have details about
> >> algo, keys, salt etc. Crypto hardware encrypt, authenticate and
> >> provide the ESP packet to networking hardware.
> >>
> >> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> >> ---
> >>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 224 +++++++++++++++++=
+
> >>  .../marvell/octeontx2/nic/cn10k_ipsec.h       |  40 ++++
> >>  .../marvell/octeontx2/nic/otx2_common.c       |  23 ++
> >>  .../marvell/octeontx2/nic/otx2_common.h       |   3 +
> >>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   2 +
> >>  .../marvell/octeontx2/nic/otx2_txrx.c         |  33 ++-
> >>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +
> >>  7 files changed, 325 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> >> b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> >> index 136aebe2a007..1974fda2e0d3 100644
> >> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> >> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> >> @@ -7,8 +7,11 @@
> >>  #include <net/xfrm.h>
> >>  #include <linux/netdevice.h>
> >>  #include <linux/bitfield.h>
> >> +#include <crypto/aead.h>
> >> +#include <crypto/gcm.h>
> >>
> >>  #include "otx2_common.h"
> >> +#include "otx2_struct.h"
> >>  #include "cn10k_ipsec.h"
> >>
> >>  static bool is_dev_support_inline_ipsec(struct pci_dev *pdev) @@
> >> -843,3 +846,224 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
> >>  	cn10k_outb_cpt_clean(pf);
> >>  }
> >>  EXPORT_SYMBOL(cn10k_ipsec_clean);
> >
> ><...>
> >
> >> +bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *t=
xq,
> >> +			  struct otx2_snd_queue *sq, struct sk_buff *skb,
> >> +			  int num_segs, int size)
> >> +{
> >> +	struct cpt_ctx_info_s *sa_info;
> >> +	struct cpt_inst_s inst;
> >> +	struct cpt_res_s *res;
> >> +	struct xfrm_state *x;
> >> +	dma_addr_t dptr_iova;
> >> +	struct sec_path *sp;
> >> +	u8 encap_offset;
> >> +	u8 auth_offset;
> >> +	u8 gthr_size;
> >> +	u8 iv_offset;
> >> +	u16 dlen;
> >> +
> >> +	/* Check for Inline IPSEC enabled */
> >> +	if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
> >> +		netdev_err(pf->netdev, "Ipsec not enabled, drop packet\n");
> >
> ><...>
> >
> >> +		netdev_err(pf->netdev, "%s: no xfrm state len =3D %d\n",
> >> +			   __func__, sp->len);
> >
> ><...>
> >
> >> +		netdev_err(pf->netdev, "no xfrm_input_state()\n");
> >
> ><...>
> >
> >> +		netdev_err(pf->netdev, "un supported offload mode %d\n",
> >> +			   x->props.mode);
> >
> ><...>
> >
> >> +		netdev_err(pf->netdev, "Invalid IP header, ip-length zero\n");
> >
> ><...>
> >
> >> +		netdev_err(pf->netdev, "Invalid SA conext\n");
> >
> >All these prints are in datapath and can be triggered by network
> >packets. These and RX prints need to be deleted.
> >
>=20
> Yes, all these error messages in datapath should be under netif_msg_tx_er=
r().

Will delete a few of these prints and rest will be moved under netif_msg_tx=
_err().

Thanks
-Bharat

>=20
> Thanks,
> Sunil.

