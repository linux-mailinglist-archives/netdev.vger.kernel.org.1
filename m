Return-Path: <netdev+bounces-188693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5205BAAE3A8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97501C008CD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D5289829;
	Wed,  7 May 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b="uR50pqpL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2109.outbound.protection.outlook.com [40.107.244.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5618FDBD
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629857; cv=fail; b=NmBGDh1Iat6FuDOUAQH7Ifi3OaNc5KDkcFk+7f+huQpU6enoLK0Tg9CkrEj8qezXmSJ/z04bLm328h0SPyQPWhIpsGn4mdelu61DoILFchGmDtQpuaKcpew3unQ+oOyhg/hgvW52512RdZkhx44QnrUegjikos7bJfT/3Okjekc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629857; c=relaxed/simple;
	bh=O8YpJb0mE4zdTEBY/ZU48mCaL+myj48SB/YPw7zpXdY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nDc0igrJ1Xbl2zvFriX8dQPjaDyYPAs+g82JnZqgXIFpTOZg/4qEH92c7EKTfdys8MHdErnZTp3HIDXkc0khBzqBq4wp0LrMmPVwk5kIrCDpkbmZ/TUgFm1d5MzLFdR2VvFSPyJhKbtc5sSJSlOcXAN5kdUeuyJmvzMPtcq3pso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com; spf=pass smtp.mailfrom=palmerwirelessmedtech.com; dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b=uR50pqpL; arc=fail smtp.client-ip=40.107.244.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palmerwirelessmedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvFI6HZjAiWrSBhCRmIZDRSMkrEQMisQ6YvkK2Vh/vt4jcetmMNT+1a73EGtZLU4P57qzKQNp50ZcPfHizuCMy1/d0pILLBhzFRQLzkE9wztx8wB6s1jvABBjnTzXYx3DPZ3ZHvZAuXA8t6U8pVzD++61Ewefyy7kCwBF7kEVHC+mMGdXUZdx6NvuHbYHOhr9W7QatajvjCqKrygg3dIsDrNRmDGLb4jSCwQuVXQNJNNw81f+O7EjwLQPjd46amzs83hdH9UZtJSh/ERXDz9JidGVoHNaFtlhlr6h+OK3YZ6o3488ecV6NcxDMggIniAjgd3anJQBdB4PoBh5VJkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMfySgOT7Rfhu4WgDXe/54T5oAHzT8mQn4p7unYHz58=;
 b=wOz5UDD0HLBpNhJnd58ySNTvtKP7MQhKrAQKg4Zc1TIn6gQ8j62fYaKPLhR9/ithjGJ057DskBA2sYNdCOm+XTI6/vN+nAkHGp94izIGRIus3ckiFDekCWcuGGjTUMa9cZJDxBEcjRiKf20w1pzZe1hO6jP8QpRXwTtVBVwUtV8L2EE0h9BwAahAd0CNLcfdevTKZTQqTV7wbTS+CaJ/I+gH2JG3quPHw1VpJDcdUhrUqRj8vJQz8uAgRfWmSnpE8CVT8vRc5deFZnRYaMQhP0h8OYoWgurtjajN8Z5+0EstpoE90p6rt4zf/lgzGHztKa0N/OybEEDR8gEkITHjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=palmerwirelessmedtech.com; dmarc=pass action=none
 header.from=palmerwirelessmedtech.com; dkim=pass
 header.d=palmerwirelessmedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=palmerwirelessmedtechcom.onmicrosoft.com;
 s=selector2-palmerwirelessmedtechcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMfySgOT7Rfhu4WgDXe/54T5oAHzT8mQn4p7unYHz58=;
 b=uR50pqpLA6qvs5ugGD8q2qwj+zs7moBGBDtOfj6tMq46blvBrfDEZwCyRoQt/CTNZyACQlQLfVZNyG2ThJqCLgTVv25v+cGmXYSDq6PpqVMeeVMMbwM6XN/byOM2y+GVUCovic66hkH8cUDR+7z/n91Ad5sIRHFLWOl44szSpsU=
Received: from IA1PR15MB6008.namprd15.prod.outlook.com (2603:10b6:208:456::5)
 by BL1PPF3EEE25392.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 7 May
 2025 14:57:33 +0000
Received: from IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e]) by IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e%3]) with mapi id 15.20.8699.034; Wed, 7 May 2025
 14:57:32 +0000
From: Steve Broshar <steve@palmerwirelessmedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: request for help using mv88e6xxx switch driver
Thread-Topic: request for help using mv88e6xxx switch driver
Thread-Index: AQHbv2Bc+TYavxBZNEG3KPwJ+KHfDQ==
Date: Wed, 7 May 2025 14:57:32 +0000
Message-ID:
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
In-Reply-To: <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=palmerwirelessmedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR15MB6008:EE_|BL1PPF3EEE25392:EE_
x-ms-office365-filtering-correlation-id: aa5859ea-0df3-4536-0a22-08dd8d777f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FUSeh2zGIhLn40s89vuWklRwQR5Qw01EmgZQHos8opBqvKJ48nJhqH0pEwld?=
 =?us-ascii?Q?a5PsIacGm9agxK+oIDBGEZwbngnmstB0l3hrdUQwmNxn4vwSq3LdZg5ySDBb?=
 =?us-ascii?Q?BJEute9qxGSPg6qW8JXYaziorWKV0Unknd14U9qo6bXLtWmwvY2iAwJO6lZS?=
 =?us-ascii?Q?aLlHiHQq8Oj8jRDHG2xSk2QykeCVm4XYM453WV2Ha7pQz1egXryWWwf6Hnkw?=
 =?us-ascii?Q?7WlYuWJ1whWyHGLsfEJWZbGtdbF8QsFAjHgQc4droXATXKdgU5RoiRdSFXlH?=
 =?us-ascii?Q?w6B+p1uGgF3BbZwpj4IbgF+Nb+sq8fcZam+HHBUUQpy8QU0ekZBON5irU6jJ?=
 =?us-ascii?Q?LLU0EvPN7BrVwp1T1nIW2GaypNJBadbHUVI1xBdp+/fIy+dlnKIa5eB6NbUb?=
 =?us-ascii?Q?9Je4T3OZdlsB/sjIBmLmd/5uVURJUTeIl9z1OCqELy20+XqquuOnwJhmUGNU?=
 =?us-ascii?Q?rrR6uNqzCACHIi4wCa+SQHqMZbvnRpP6J6puncAy1pdm5EJb1b2gpwMyCpH5?=
 =?us-ascii?Q?YPj0vvIbhagCQguCiiSD1Kjlg3mnEV8AAJRrIt1MmotdZ6M4Sflz23MhBjGw?=
 =?us-ascii?Q?WcSg/v/pA2qWv53U1wcDeOOvUojK1BLtlinrubqCPj5bdXDd4mzPDeTBda0A?=
 =?us-ascii?Q?EE91iNefFnkM4aEkJOvr8cY8rvqbE6lWaxtA4eHUWHQKgQQ6QLAzgsfHopAl?=
 =?us-ascii?Q?F3wHN4E34q/qTJkkD1wYSezo2drXgzYdkpwEeBGbdQpaa+4f+73QWaLITfXK?=
 =?us-ascii?Q?yhpKBBjYNCdzXMC9Id2yqE93xRi9OHhc9WFyiRBQSI3RpcazwrY7WtrX664x?=
 =?us-ascii?Q?pDTI96kY9FjyMo4BCwpZ/g+kXCb+vtgDzh9KCiCeRcIL3vyp/U/OaGJmjs4m?=
 =?us-ascii?Q?HLNGx5WUEGL8M79L/fr/PnIwF3+oea6o7ZoNyPaP8gq+81Alfwq3bbf6lH1D?=
 =?us-ascii?Q?QZSHrLz8Aq9ox01qAc2HXAqA3C5incLLDDfA5Q5V1B0jIV/aE99UD9n9TL9c?=
 =?us-ascii?Q?wM/jAxym+1T3FbNWVW0jyR/FEv9ROlhPokAIxwqvadgLoMTYCebpMF1GHA5P?=
 =?us-ascii?Q?8rVq+/fwrtOiOkYLZoq6WTL0VdulB5US2mSOg6bmaaqjkut8pWGB9xjVSWw8?=
 =?us-ascii?Q?ekYkYp932AA/ZSeeg+GtZS3SwaMg0NxQkzx4Po6nsi6qIKlGZe6TzTpGO/I0?=
 =?us-ascii?Q?YVi+Ln+OC6HYPxT+RaEmexBO8ie2+YsJQCgV2ZmOsM8q/K7/bOxiXWHbnSPC?=
 =?us-ascii?Q?RRtWvXpfcPAebWME8Rd5WUW7ZCI2ySry6HhVcKrZDX9MDzC0IaK7Xup2LWLe?=
 =?us-ascii?Q?HyrowlKC0+LSoZO29bFJOcJajUhFv00xUla7mVXohAIaCc4iZRaf/7kJTMUl?=
 =?us-ascii?Q?1WavBAvkvHV6+ij+v8DgaN3ISoKQTu/F7uDyZgH8WlFVcApbFl9jLM4xXmQU?=
 =?us-ascii?Q?iQnkw4IixERnkS90Nu85v66BGiHzbqyu8OLAvUOeIgkKLFY0QFApow=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR15MB6008.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xxIrtXgYN4cjUq2xmDXLqNX0qlEvfmnBA/IxbHQvInlNnytr1GU+80D7QU+X?=
 =?us-ascii?Q?63FQIvXu1/Z1KYB4l/7CDkWXHKh7XCudcz5XAHXz1L4v+289OZcyD8D//f5s?=
 =?us-ascii?Q?c5pGkymbWH+nvNSMDcq4LcmehsF1S7YMqFuEP7CMlzCOCQp2keczkmuHVyf7?=
 =?us-ascii?Q?W1enXqsY98htqDmxWZMdMj4MLq8A33++jhagkCsQh1J9KHUHsrUrV9b1ieW4?=
 =?us-ascii?Q?2c4UySKqdfQQD3a0SrRB0lg16A9QCvG6Tl1QImIwqCVch1SZL3/WWSwVPwhD?=
 =?us-ascii?Q?5Pqnqu8XDWKDbbVT5YwtpK7nWsmwiQ4g+eWRl3AV+5S1u5jyFsn/AFVzPxJM?=
 =?us-ascii?Q?WKH8t/zASieC2vpjpVyCxTLV089WP9qgGKiRoMffl6jmDScqRo+wfZprdqBR?=
 =?us-ascii?Q?PwGQPNntSwlX1AdqyF9JcWj7aH13IrzUqfm69S1egqyy075PxnuQWQRoPhgL?=
 =?us-ascii?Q?tHf8Y89pbFOs3HcrZuwi8uJlGdHFLg6niR0poVrhmMjJt6pz1UFOGNzLW5t2?=
 =?us-ascii?Q?fB2tVdhTlvYDtfWFA8j6uq2oGVZ18AvMTj2+PRvJmXuJHaE4swI45yHBE2/y?=
 =?us-ascii?Q?GT/jtuvfnpxdBAxPoaUVEHOna5shYWRaaS6C9Ty+jPmj6AaQPwoZqpTTXE5l?=
 =?us-ascii?Q?ObdqMedHTPEqO5NNR8nj61KfkORxRgUt7ilzl9qlABrswd8FCDjgtzltGJ5h?=
 =?us-ascii?Q?VzzBaXaAFSFjZke6PmFbeKbrMbKxsVDwFvR84xVIJUx4Iq+mw2NeU5gXQ4+2?=
 =?us-ascii?Q?Fu1OW96AoFcuVGD703gAdftZGmNSWKWYn2VaTcip0LrwNNX6C+0YViS13jOm?=
 =?us-ascii?Q?9QhNcxNwTiBhs59r9gVH40w9UwcYglLfLwPQE2Rs8KdHjPXqTT7ADHQKbrK1?=
 =?us-ascii?Q?NcWc8ewWPGLiodsVdvf20eMKOpFp7UnBT6XzQJqRx7gk1TNxA1PoQfH32zvj?=
 =?us-ascii?Q?xwnpcsSj5LvU1z1Yanozh4AtaObHZvUsn2qGokZx3+5cIrHoLuQ6iysDBgko?=
 =?us-ascii?Q?ZKSM9IAFtUI37HTl/gIwMit7s/NufmKoRIt96M2t717/LZ6bcixbrf3F8Wpt?=
 =?us-ascii?Q?8E/m/MGw+OsGqK81NF6FMRmUNxsA7UcfhIuk6bhgO082nkRJdPCNITn95sph?=
 =?us-ascii?Q?I9uIciv44AWK8kiy44lxCueILoDKWeFx6OJwzoLKN1DBR4SYQUjOrX19ZQFf?=
 =?us-ascii?Q?Bm1HlVaalbxAbhgj4FTT77U15nZ9HRYHLEkHavgN+LSYmVirfxWrkAmqKOmn?=
 =?us-ascii?Q?6bnkKgdtwIAk3QnvW0F2EoxT9j0Ph8tqTCgrG3SYgIFuLdzi5XFXTRca6ew0?=
 =?us-ascii?Q?JRrzGyypRdrkvQ+VL1NYRPsCUNtkOiIjW6hgj57MNVmFb1QP/hKVF8ekILlX?=
 =?us-ascii?Q?lZIwYp5y6OCG7WtGI19FZs+pU5Q7IyqLsbEh1tbcMdXnpX2J8R/uH5XEcddm?=
 =?us-ascii?Q?1+qOUyRTp9+2KaWQlLjyfXyuvPKd41V3vTVxCDVzO4l675Hir7p+eHulhqZH?=
 =?us-ascii?Q?rAoRRdoqeJdfiXO+uo4TUneqW0FYud8WPRiZVD+VE85NYwiJt45CrYk+Q1/L?=
 =?us-ascii?Q?8v5VT7M5Bg9yyRthstvXv9QnESGLIi4a0aApSu+TWose4FhDFIAgLiD4AyCN?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: palmerwirelessmedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR15MB6008.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5859ea-0df3-4536-0a22-08dd8d777f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 14:57:32.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18187d5c-662c-4549-a9f0-3065d494b8dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxORQxdYag3kTpXEK8deMkswPiwGznFFoQrQfwEKV1cS6xy1ARAPYDmtxq72/1ustJj14+REv2N1pvT9Br6tVGQT3yXzjo65q7dOZ9CsoVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF3EEE25392

Hi,

We are struggling to get ethernet working on our newly designed, custom dev=
ice with a imx8mn processor and a mv88e6230 switch ... using the mv88e6xxx =
driver. We have worked on it for weeks, but networking is not functional. I=
 don't know where to find community support or maybe this is the community.=
 I'm used to more modern things like websites; not email lists.

So that you understand the context at least a little: we have MDIO comms wo=
rking, but the network interface won't come up. I get encouraging messages =
like:

	[    6.794063] mv88e6085 30be0000.ethernet-1:00: Link is Up - 1Gbps/Full -=
 flow control off
	[    6.841921] mv88e6085 30be0000.ethernet-1:00 lan3 (uninitialized): PHY =
[mv88e6xxx-0:03] driver [Generic PHY] (irq=3DPOLL)

But near the end of boot I get messages:

	[   11.889607] net eth0: phy NOT found
	[   11.889617] fec 30be0000.ethernet eth0: A Unable to connect to phy
	[   11.892275] mv88e6085 30be0000.ethernet-1:00 lan4: failed to open maste=
r eth0

And trying to bring it up gives:

	# ifconfig eth0 up
	SIOCSIFFLAGS: No such device=20
	# ifconfig lan3 up
	SIOCSIFFLAGS: No such device

For reference, if I specify an interface that is not configured (not in the=
 device tree), I get a slightly different message that hints that eth0 and =
lan3 are at least partially setup:

	# ifconfig xxx up
	xxx: ERROR while getting interface flags: No such device

Can you offer any advice for resolving the issue? Community sites to post t=
o, instructions to read, videos to watch ...

Thanks for your time.

Steve Broshar
Palmer Wireless Medtech


