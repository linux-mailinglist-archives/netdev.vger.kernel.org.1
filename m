Return-Path: <netdev+bounces-236602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE2C3E42D
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51AE3AB7A9
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E09E2D8391;
	Fri,  7 Nov 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="oK5ruJAp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94802D641D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482899; cv=fail; b=TcuuSCr/64Z9+84IVBRNKSrDv4NBeWUTVaGAlGMqZ+jTG2QpgSMbXy8NvWiqjILpW2bZRpF9oYT25eVUhj4zoRHAn29Iolos/uNoJdE0w1K8wUyEo+JnvVpejr32u1//GWM1B4o8lK8WD4QdnBdacTTjrqBeoqM+wtrLzACmX6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482899; c=relaxed/simple;
	bh=eAui5K2lojQ2ieAep+QIYYcCnVuXYYSz/dGSJX6KyMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FlL+dVHDCZ9mTbycE1pcS/TrFs/RXwawxeOfLjpfAWjXJn7xeKROwKqV5XWJ5ZV9UC/avamkQU0QS0msDCiQnX8rlfvVaozeLVvwp2g+frArq3sDHEpOfYb3/EIBSO72V6y6rgNOXuQHcGGR5Lnsd5X7xSKtEZcLTwuINTfB9AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=oK5ruJAp; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6IB63U3943004;
	Thu, 6 Nov 2025 18:34:52 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021095.outbound.protection.outlook.com [52.101.62.95])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk64at4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 18:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD7MbX8P/TtiLM4nCEwAZ/ZWLgEyJAr6FeEV1RGIBMUlS9E6gikUalLsmn7deqNNG6QI0zDnrnUg+WyGsE9IeOJ81ki8VW9DpqKTBOWmdPy4wEy9i7DDqxKaDdylXa66SEBNTIoiEzUtOjcrNivVJ8yHAFo2mVGVzNgwVC///QFce549dp4EwAXpRstRmABdim4gF5tD2YNTzsfWhxeGwK75SFTDu5yeMZ+NK68feNY/nGeZ5d44CJzCsIq2KYUywoNOrioWULITv3HvjPCpS83rau+JtdVyzE42gS9ztpGCcKOMrNlRXsuU4L2fedrrYlbG7vk+lqIZu5U2RCf0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2m+kB/6QCzr1sXeg8zmAeGaYCRiQ2mmRALGZkq7Yuk=;
 b=sIe0Q8pBpNpXyFa7i2hxkWLdh6gFbn/oHYTddifmn1TU4oIuUZhjGOH34f8R2iaeoQS6dvIGVfeiYyVnGrN3r32EpJ5uaHDGowMBtmBY9aqGEMfAp2Q5nkDtCc9EzXg0ykzGcrMfkgoq1s9xhgkpFDXx6oeJ9setbrX/XZYKEqwK0C5xyg+M5E6xpEN2YatigFdIWnUfOD5Z8Q0GxPJjYFbnSXE5Uq7Tq/ekcXDS5KGq5xFHIvwTBN1eNzKwpvSQPTxVSaeTWr2ayeuqb5dG9IZTVXR60NZyHFWm3xjCapP0Ax7L7Tm6wHOzs/TfoP6sOm4hkh2/BoQFFSVkDfGjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2m+kB/6QCzr1sXeg8zmAeGaYCRiQ2mmRALGZkq7Yuk=;
 b=oK5ruJApcVC6pwZ9zMkV1RAO8NPBTiHSNYdA2W5C8oM9cyG6rXDCG03uFNVUs87dYCVqiUy2s6+Hz9dMLzbyvnqalquT+2QQozm+cBNG6wtGGNiU3fXpu0LW7iw7V/D4m7KWjg/H9bsQLp2UxMMKoE0XcF00S+qKOsRfARSHOXw=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by PH0PR18MB3896.namprd18.prod.outlook.com (2603:10b6:510:27::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:34:49 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9253.017; Fri, 7 Nov 2025
 02:34:49 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "joe@perches.com" <joe@perches.com>
CC: Netdev <netdev@vger.kernel.org>
Subject: RE: check patch error.
Thread-Topic: check patch error.
Thread-Index: AdxO1di7t3Q7enJFQLGamYbens3tkwAuR3mg
Date: Fri, 7 Nov 2025 02:34:49 +0000
Message-ID:
 <MN0PR18MB58476F66445B5736B213E9CBD3C3A@MN0PR18MB5847.namprd18.prod.outlook.com>
References:
 <MN0PR18MB5847DF4315B6265D4056DC7ED3C2A@MN0PR18MB5847.namprd18.prod.outlook.com>
In-Reply-To:
 <MN0PR18MB5847DF4315B6265D4056DC7ED3C2A@MN0PR18MB5847.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|PH0PR18MB3896:EE_
x-ms-office365-filtering-correlation-id: 7b2544fd-4b9f-4805-f8c8-08de1da63964
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u2ISRclss6gYQJHnzIiP9iK92v6s+yuotqDsyb/yHTsK7XSosLt9Gb6fHoep?=
 =?us-ascii?Q?xxoyqlVSeU6mArB1nZnuxQneMyKWuIavR8S8jCauin7xvHAVQcWoHCnm23aE?=
 =?us-ascii?Q?q9Ljh7P2HIM0tGFZeMCWfwXsyPZxCAQIlcCU0oy1Rj5qzvKQYe5LICa3eVZj?=
 =?us-ascii?Q?6YrNt5X0xMivDlWRrx/sR3Hy6q/xuH7rId20xSOejDhgDoXUh9NDEusGrAl6?=
 =?us-ascii?Q?YUWRJNKA8rvL0qdesE31LoyljWFguMFKALZjkYfN5Kupd8VNN6Hbqy8VPwro?=
 =?us-ascii?Q?7Ji0Tt63p0zuuYpZf1KByKACaRSzCyrh7Ym+//1nQ2c6/m/7HzSYTR3CGvXo?=
 =?us-ascii?Q?wXzfs/eBj213WfrDco7gH/akfwNrakP6GnDNs7WI38JSsLcV48a019nACNdu?=
 =?us-ascii?Q?f3Uur3/WK8j/xBe3+o0IxOZt6U2bRnoswzdMb8cvPAlWNXDndSEBj/Vbwu9k?=
 =?us-ascii?Q?LYFfC8bkNWqS86bFB6KtHQjDHNGArdjfX93THvkdCZrHAYKOYrAQEY5aCj1o?=
 =?us-ascii?Q?F3+X9SBfwxNhu5Ms9z8Xq4L+QRpFp9G89ptF/bnE0CwymwgqhB9TCp5BUd5j?=
 =?us-ascii?Q?Za/OgJRilPiIaiAaUy7SzBhBbdhRrfK+fychd8GQLDG97S6i05Dwimf8g0kW?=
 =?us-ascii?Q?VgzjhBZrEsfMQSOaWNViP87NNTYu/Vm98zYjQ+2Vr/ScNR//aCZL6K3TLnSx?=
 =?us-ascii?Q?Ltf3rMpjo7Kssv2EggYAoUOePh7OeNVdtyO387Lmrp6X/SDQnMVJzJ2+sXzC?=
 =?us-ascii?Q?+Hv8/C2AFLhwFMrkgUj9rZHeY9I4ddd1slKB/V9mwvd06/7Kp7gNjLxKDasT?=
 =?us-ascii?Q?I5jPdwrkQvd/z7vikoEM3FmkZYqN4vj/aBc3nJOMV1pIF+yUMq229t3Cc0Hi?=
 =?us-ascii?Q?b82XC27jlmSofuYl5/78FYypeBdmXiXmxroCnG4Bi1ByvhUqeH+u7k0yVZMc?=
 =?us-ascii?Q?Y3I0Dpd+FiI+B13Rag1ecfHusGuaR2TZz+iju5ZzPYZn61JfxUdXCmR/K4xe?=
 =?us-ascii?Q?/06Ho4hljNcKBpvH8Vx21iYDd2qHMykIeWtIuJjRiE1BNgz/lWgqokiAFtAy?=
 =?us-ascii?Q?59lUUuTkYJtNBffriZ7B9fwttNzMOJp8qw3FLkJMVNwLwGHbe4dUqMbk/I4I?=
 =?us-ascii?Q?BVV6v5lMYnxykSj4dzurSBIMXn1RSly8Te1gPEPgHKhvmRR7oLHQ4zqKLk3Y?=
 =?us-ascii?Q?txFuD+6+bBOLpHTq6GiMh6Y92UtxtKwKNWCNCmMCwipInqJGeNN4B0Yf1HCA?=
 =?us-ascii?Q?9igOys5A6UdD+vt7oEUKDLNCj+s0MQppM4BWdilvc+2+jKUfe5FmlflhyMlg?=
 =?us-ascii?Q?dao1ZjXUvu/uOyVu4cwvfTc6U7KjYGIw6RccXtRoIn/41tkrCRhdziUP+Krn?=
 =?us-ascii?Q?DSx5Cx7LJDLVNMjlDb06pEc8t7dDsHfXAppux6isnXz76CoYt/q8KwBVGGNY?=
 =?us-ascii?Q?8exrlY5CwFoA+BRXuZLVaw60Qf2w63RYU4tY0aOKk7iQf7IbQAzb7CRVBCQN?=
 =?us-ascii?Q?EysXA6X3kY+VGt2Pp02PgaoBhK6SnyU6WRu+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tb12ti4tQdpkjhjDaeCeBBhF8SyK+I0PnWCokH81Qw5eG8C5O9Z7ZjUaO2Ie?=
 =?us-ascii?Q?+3ARVx+nOPspfwsu7yS1Yfydjrx56A9mQChiOuURF2T53xMS79MoRPmk6xRS?=
 =?us-ascii?Q?0GlJ9iVu+ipw+xRni4XMHepk53tXv03RuKzTF5E4A8AgtYreciXTpsKxquhr?=
 =?us-ascii?Q?uG/US/d9pLWuQ+hAzNi4bWo6D3auexA+IwTg3RoUf40A5mh3CKkVDXKyXg6L?=
 =?us-ascii?Q?XbnFMH1fPwH7LsVOoNXwFn+h29mLaHKlcYHbMWPeNcM+38e/W88m4vBJK4Y9?=
 =?us-ascii?Q?y6aVEsx3RFTBY2Njsxo4/5EO9XbmOIAdhIxqIEkFpHh9P+y2rTAZ5Nw8Yj+A?=
 =?us-ascii?Q?MJ0yFaYQEBp6f6/uCSO4ed8opwGb6fGCdd7g+QWh5+6vskpzy/Pr585Znj74?=
 =?us-ascii?Q?RsXreeMQl7Vf88W7erCGoDIpb3qRMaP8LiPSVquuHDz4MAQoYLqNYcXtRwgn?=
 =?us-ascii?Q?iQcy24AUd6yMUIXUKf90q2xGTZIsWU+e+vwxR80WeZCdMWWmlXwJXomWuoNC?=
 =?us-ascii?Q?KeTx8DQn1d0xqGNmDc649AYKll2he6CgGQphjpc7nyIWz442/SU98a96XrVz?=
 =?us-ascii?Q?Ywp7cX2+usUiz8nZ3UzCpLTkfhiIWwDJSjWzzBedGTmrvq328o/aOPDj4/Ew?=
 =?us-ascii?Q?uuN4KUAek/XkY5/2P/qPl2PuJtKB0UlgU1JryJsk9IUBz8vgfKTB1vawlOtZ?=
 =?us-ascii?Q?SsDG3YNc8/CNAYuJZQcseWNt46P5E6ExZzyIY30FcKuw2NKfSTwI2rEdzd1e?=
 =?us-ascii?Q?ARvYnMsu9+ZTgyaLEElwAT2UHoPc8tJ/235/rUw7AJuzW1Eemysys0PY7pD0?=
 =?us-ascii?Q?zKJWZ7Xq97sdW8LRXOcCYb52U2T1qGjGjfUT1/+7aU3Z6WZluTX3P2zR/RbQ?=
 =?us-ascii?Q?5wyviZvmETsKHGC1wSiRy3YcfqETmfDXJhDaqqaFxwUDysVwgwt+5AROYGg4?=
 =?us-ascii?Q?ogE6aBCn/peyEdHqelz18gwi1HU9YTe/LPlYXJOXE+XFaI7mUBVCYqqn52oS?=
 =?us-ascii?Q?QdSLOkBDwOiNDH3t9LPMTwrLS8K0vxd0Mmt1HknXjVcKDEjASTjNn7QoJDEI?=
 =?us-ascii?Q?V0e2C9KqQ42R3+SJzfXu6wanmL1nKHK3TGvNo8yYs9pCQWM4WmZ8ryQOLF2F?=
 =?us-ascii?Q?3VDj1pm7gCkC/Gli2jOOBxgvxep/RHWqM8zfptCNFU4fKgmpdiS3Nib48KYd?=
 =?us-ascii?Q?NPUY9kXJF30ZMEJ4U4j7QLEXTSgCWPZg16oVwcGxNocxljFZneOAje2URNmj?=
 =?us-ascii?Q?6E6sRGwNjxUTi2lnJaT5ckmk+I92xCALxJbJjGBwK0VZKP1wyvtLevRqPIfU?=
 =?us-ascii?Q?x9MLNBo80asIc0YmbimGtWYYW/CxGr+omb6LaaZDUtk1N5nda8UCndI6RXAV?=
 =?us-ascii?Q?chIVF/es/sLDVEUqKA/0E3vbFMhezZfCnhD47c6ENI7s22BL8VbeYgvYyhov?=
 =?us-ascii?Q?d8zsFg6UzRfgMWqRomp9XhUEyCZiN0YfclPwxBvnjn1FE84ApcY1P2xiQRDi?=
 =?us-ascii?Q?HCVtyufisBSr+y/injClOrcRe7599MbGwwUeSFP4LhzCb9WkhlbE+Kv/vm9v?=
 =?us-ascii?Q?HYoLASsJRBhmtIvKLXszUABAn9xM4QfDS1YlWbPg?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2544fd-4b9f-4805-f8c8-08de1da63964
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 02:34:49.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix0r7PG6YXDpbsWjnYa+azK/P+J/V/4nNzbbP4EZmcY0qMR7EDlxIKp7llIjrMrTXwePjQQuTPkOhg8+RqBnBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3896
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690d5acc cx=c_pps
 a=XQ5R8ZYH27Ke1DXIRfoPQQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IJv9LcIfAAAA:8 a=VwQbUJbxAAAA:8 a=o4rTqY9oNd3yaXah6aAA:9 a=CjuIK1q_8ugA:10
 a=cmr4hm9N53k6aw-X_--Q:22
X-Proofpoint-GUID: XdncLfoNCRLVivmXfIdONCJq6M-XR3oW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAxOSBTYWx0ZWRfX14zFGOxuLVxy
 ws/dj4XCsOXlnSld+pVenv74Elz9BLhGnLD5TOoVrBk/cGgt7m2LAW1sZvdf+ma22Qu22Jjsba1
 Nn2nHIiDP7j+Rz+tVY50ahK5TUHKLFtmCGc8gNzpq54Q7E/MvF2fK57fYj4Kfz18UKhUtwKqnZx
 wb0qxqK8BDWMQRSt38nBaGtFVMFkRa0Sv0PMD2wxdzbokm0Aps/E0SJ4UPXxzuLr8M2GFYIH45D
 2ig92F1QgvqblFQumveJmr35CgaRALfNZqoohBNMnOVeULMfuh1HjvmpOIB+b95Si8L4aMAdncG
 h9d+t1UPERBzEWmzTTZBr/eDqylzlmHuC7y+Wf4gxb4BO+qQ2nfAzu0S8/dWUMCgOGzQxSS0X8k
 KlKRaV4tfepGyZaN64G3bCTSbR2zzw==
X-Proofpoint-ORIG-GUID: XdncLfoNCRLVivmXfIdONCJq6M-XR3oW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01

I think, this is false positive.  Could you comment ?

-Ratheesh

> -----Original Message-----
> From: Ratheesh Kannoth
> Sent: Thursday, November 6, 2025 10:06 AM
> To: joe@perches.com
> Cc: Netdev <netdev@vger.kernel.org>
> Subject: check patch error.
>=20
> Hi List,
>=20
> Check patch is throwing below error. Could you help ?
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 1692033b46b0..2345eb3474a3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +
> +int func(int (*arr)[2]);
> +
>=20
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
> #$ ./scripts/checkpatch.pl --strict ./0001-octeontx-af-Test-checkpatch.pa=
tch
> WARNING: function definition argument 'int' should also have an identifie=
r
> name
> #22: FILE: drivers/net/ethernet/marvell/octeontx2/af/rvu.h:1161:
> +int func(int (*arr)[2]);
>=20
> total: 0 errors, 1 warnings, 0 checks, 7 lines checked
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++


