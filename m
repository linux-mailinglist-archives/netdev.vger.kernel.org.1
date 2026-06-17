Return-Path: <netdev+bounces-300033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uEr/A/wwMmrHwQUAu9opvQ
	(envelope-from <netdev+bounces-300033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCC696970
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:30:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=DNPHKEvn;
	dkim=pass header.d=ti.com header.s=selector1 header.b=ki1OdV+9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300033-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300033-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15976300253C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA4342507;
	Wed, 17 Jun 2026 05:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894C2E1F0E;
	Wed, 17 Jun 2026 05:30:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674229; cv=fail; b=HSFY11/XzYHwV3axnRgHObx3uq7ItEcMbDntcSKw0NLO/lYGwOOh0vp51fu3owkxlwwI3rUjwaxEbzTIUxKawJed5gogYdHxz0u3O3Fopg2AuEetVQDZjTFnI3NOxln8rhQtz6KKvZRYAESAKDOnuP7bXLfW804xIjjlXP/C+I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674229; c=relaxed/simple;
	bh=gpbffas4BiHWBJJK0BWwRWP1aX/sEpR0TQ2llZuubQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u/MWvexHmKgcMG5nMSFZRZLGVGQUTXJ3F8gJIZS8UV29Fj1vC10BEqIry1Lso+qD/Z79Bdwmk93f7DyJMMA24ALKSCyLLc5ZoziYVZmWhIJitXVaOeSl/J5GOS5lHnSwH9vRb9OD30uhBi5HXDYjdv+7INSArrf5fE2bN0l3j88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=DNPHKEvn; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ki1OdV+9; arc=fail smtp.client-ip=148.163.150.75
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65H4STd54146306;
	Wed, 17 Jun 2026 00:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vJpykL80rTQRvnRia3WFg2L43XLyk2BtotfDSsdOP
	RI=; b=DNPHKEvn2Y13Y/b/3uwfI1qxjuPbZYxjxrbEiNNp11JnM35JXQK+9p1cY
	G+5wm/K74tqCxCILiar3mqfx3hitAAIpaFQknj0JWU6IIVp2GAw4ptJKfRof+Sbj
	RI440nbGoue0S0w3DQ5zN1rpGmJwkGZq0PTKefP0nqeZSy3ew8ctwlMmoxwlCZud
	oN5EFzXo4+MZeu0M2JZM+s8SchdjpVH3mLeC0pwKgyAO06oNrylyIOjwlrD8exS4
	21dkEzDL6KefdX807Jr0sYMkcwVE0xCTJAsPlAHtkX32GvLL4+J4lIiTCo+w9t6e
	/B3JP7QeZ1WKv1CRF2vIly+UVn18g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	by m0380145.ppops.net (PPS) with ESMTPS id 4eueeu2j5m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 00:28:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGSwNj42Q5hMVCMrYZ1xx/oNhZHSuPQbNtCOXVentDKqx66eiutSiIlotylitkTRNpEGVpArM56afmGOE6qvnFHXP0aEAB0rlkodDgaExqMa1JxmAa1mDxhh05nmKauH4oKYk7E4GPItvF9PyssGPkSrguA2WmzgeFCYcXpkqqmlyA9U8B0hft1GtktmNPI+guzCPbsv4/cNouQ4weep53y8klSOY49sW1acTJr0rvjdA8L3x/YqatCEKtIm/Sjk8Rx9PFvlzuv7ubqsCDOh/FKQjfLDku+uxT8M49A35bRkzLiUw0LxmWpuLPmbD+aFcn7Vi46yUjAH5T+R7z2kZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJpykL80rTQRvnRia3WFg2L43XLyk2BtotfDSsdOPRI=;
 b=Z0OOSMGFZ45UAlZIUCz3yjqJFU4vW93jT5/gJAaHEHrMrVgEohCX1vDYwhfVFtXlNRjaXPYWw0dKZfK/YowGuqr7zaOiSMZ2tkxfoIVSssxi7rfy4wgNVp/AyZAf5h7o5i0CaYKxN4BpJWNrXsoQJoa8PNmzCz98mCRs7oCyIcuygPSU9CIbnvpkdbWjsBs8CNPV3hokqq0KSVp9aoZH+/pIgvwDr6DguTebxHSsle0uM5+Zrhwpe0/2TbkjyBsyiIQ93TwRAy4pxpoJHw/uZUNu9zmoPB+i01RyppLox32jsQm1ZJmMyEi5CQcVMZ/mhCNLBacBpdvoDxllSzvnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJpykL80rTQRvnRia3WFg2L43XLyk2BtotfDSsdOPRI=;
 b=ki1OdV+9PVUr7rViEFcV7J2Ql5neKht5WN3BI0vBkFh2XMQ9mEp6KmOnzmZPyOnWBr4nO+TPL7+gLLXo+U9DtzikcX/yj2E6gOmMPWeQu74Gqnrk1AX95IGNaLj1H/n+bg7zFVm9IWY6XMr+HsAHHOz2Vy8/IeXVECT+RzwIukg=
Received: from DS7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::18) by
 IA4PR10MB8541.namprd10.prod.outlook.com (2603:10b6:208:56b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 05:28:51 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::2c) by DS7P220CA0121.outlook.office365.com
 (2603:10b6:8:25f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 05:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 05:28:51 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 17 Jun
 2026 00:28:51 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 17 Jun
 2026 00:28:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 17 Jun 2026 00:28:50 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65H5Si8W1608292;
	Wed, 17 Jun 2026 00:28:44 -0500
Message-ID: <a62d5243-d641-48e7-a1f5-88150513be48@ti.com>
Date: Wed, 17 Jun 2026 10:58:43 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
To: Meghana Malladi <m-malladi@ti.com>, Jakub Kicinski <kuba@kernel.org>
CC: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
        <vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <arnd@arndb.de>, <basharath@couthit.com>,
        <afd@ti.com>, <parvathi@couthit.com>, <vladimir.oltean@nxp.com>,
        <rogerq@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <vigneshr@ti.com>
References: <20260610052511.781752-3-m-malladi@ti.com>
 <20260615231041.1007484-1-kuba@kernel.org>
 <20260615163932.50bb3df0@kernel.org>
 <d0123269-b1e8-4fba-94b0-b94d3d9a5405@ti.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <d0123269-b1e8-4fba-94b0-b94d3d9a5405@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA4PR10MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: ce539259-d96b-4a7c-7f7e-08decc3150f2
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|376014|82310400026|22082099003|18002099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ECKBD9nKE1uLoel/rzHX0bWlAyiNbfKhhggJK0NhzDHmSfG1GEdXyrkjkajbkZldxOJGwkhPp9afQLbVrjEk6AWxkR0VZvg5QJJ2mYDAQYSfZOzm/zYfVT2d3Yp2+YcZCblyh+1y/rU9hAvt+YXh7Lm3DBm4PLuShl3zMKcv+txGlasylGZiH/DXWM1lUQ+xUQvuJ+Sjf4GyqQPZ+gJrGQ5kS8VWpqlhpmqM2dDL2+NLk0jJAVurPLYaaz7Wi5Hmrs0pUjI9NTC0LUo8dwpSR5QTwrM5xfjHY05bRO5v9/sGA3jMfE/QHk7+RCsguY//GJu5FHsSRvh61sH0Lk9yJT3sRNO4yw+mbKkEDYV8vxknMoiV6Hye/jb8xj6v4rZCMxq++Py5aT4FfWwhHJD7Oqv73cMyOC9CgQ1Lvod+yb8UWAcjmLSjRwUUXUdTIYhwta7R/r/kMn0dP/NIGvvLlDGkFzGAvsJiVDpAFdX6n+aam4iN5afajrInfuih2ZLd+yGoQNwhIIAW4HPCuJOcfCQb2jZbmDvaUw5cZcYZcsRfbORabyFDaqETOA1ZR4e6ie5jSxhwmUxTFRbQEFv1agwvIB8fCtG6Y+BQOhq6/8+gdFXZzLfMupLlQAvOmc/+ahOEQjM2kHPBDtW6J6xzB13DiooVka4Z9M+bTG7LZo3cnW5vJit+dpSj5B0WKH9AFEcoN8eC8HQfI5cFHGHmfVq/QAfqWj9XyJnQp4d2v1U=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J1/MrA0CXY7zjVf7r0z9QvNGvGAr6rV4KY+qTfa50x0QYSxXCVs3WYC3nsJ9d2SYYGTY5lYUFmtGRsH5tSp6jD6iIYuIkYCy5h//MZAxN5ZU87q4E+o9lgowliHIVgFgg4Yhi1avu6JTc8AqBmVAoFSUIenaAghU6rJpqJZYgRG0+rKQi0os9+ss2YhR++s7xPoXGwTBba+1r815rpWT0ZdJTfXl+ZIh7wLwPJ8H1k5hreQ4bTPkdjTv3fFeysHccqEhlMRnYZXkUWmCH6NcP2gXZvmiL0rx6PaUv9Iz0C/S3ZfhDXwsPKwB/zG9vve49bOHWaYwMbDYER7ebn35BsLBTreEbP8DGRIWvN4nUNxxeKYX64zjfUYzE5kxXZWig+fZWtFTn9i2QZQM3Dl9klHxTCF5h1laB+VSwMIX1Cy6jZ5sBRm5WxOGUbf6CuqP
X-Exchange-RoutingPolicyChecked:
	TtU3PNJJxlH6NlltcfICZI0H/GPIZITnZT501hC1zdNT8zv6onInKZkEcSu3tfn20hN8Gfi6PnIlaxv9dJ4rE7KRtapDZnCNLJ0iEDurGkcI+nxcUx26gwiMeRcx0ZDj5C5NUDZubUqPs2Xp2V8rq3VaYlBsnxnr+6T8VB756NqmkfQ3bIHmG0FFU3NRufrY4QzrSaxSrmVJ5HQpVT4jWFbdyhukC32GT2Tox1H5kQewwyxE9b6WsVvoBvz2cjnJRSzky2ovaUzHXVHbgy9u+LMHwZofVlq2bgeX5PPNiddnS2lh5Pa7ILvpC5EbdVH/37BNmiKigtNiA92h7A9cvw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:28:51.5738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce539259-d96b-4a7c-7f7e-08decc3150f2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8541
X-Authority-Analysis: v=2.4 cv=YZONIQRf c=1 sm=1 tr=0 ts=6a323097 cx=c_pps
 a=OJmONvCW+i+0F2OUQkAdQg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=grig9dWVmO9VqFHnrocA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0OCBTYWx0ZWRfX3o57DDSVYtjQ
 ddxGztycv2HsDDE/dtGc8lGMhtFQ47ytAmerFz4Z7ii0NLnJ6AuKKLkJ2x+uAMPMXGK5/CdYSoe
 1TylgSA6/OqdUZ3sbmQ4dkaAvT0nC1Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0OCBTYWx0ZWRfX5GcbnEx4b/gh
 72EkOwWNE4RHACuGIKfCcEmS/0+2NlUZOTi+FUuihB90GX4yqxwYTp1P13/iZI7YpA1zH+3YG06
 HweQZtx8PhQL4ZuPbKrdKeokY9nPSCWWQ8yIa8oZLiw2qYOkbqz9/CbnK8xYsJVzNbOlH/nRbec
 2DcsqlqHoXPU1LFhI6+dmdhXpUziXihL130Ewo64MfssVR0yh51DlNlOYGDCpJkJXqFLeJ26fS4
 1xESFur1SUkFvpaN+JqPWdYqzJfySZpsNvvdtqL8Uya628c4Jv8r/Z39gUmAOGx3uU54N0KTI2q
 u11DG0IOD8RZ222JEcTuz3j+cyYHc+wuEAvgzFtwhUiaYfcBSHU+ndnIthOa7lx66C3xiKd5OYU
 sX6PlccryuxIUx3FaM57eq5ab7Qa0Yp5Ox3QJPaqoRBaLSiNzs20mM0542nMf2RpWHFoR94YG4Q
 mOqbyJwi6wnLmCxEA5A==
X-Proofpoint-GUID: BdNRJNeKE1WSEcp7t3_YZbbPArkt7qGw
X-Proofpoint-ORIG-GUID: BdNRJNeKE1WSEcp7t3_YZbbPArkt7qGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1011 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170048
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300033-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:kuba@kernel.org,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:dkim,ti.com:mid,ti.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5DCC696970

Meghana,

On 16/06/26 6:24 pm, Meghana Malladi wrote:
> Hi Jakub,
> 
> On 6/16/26 05:09, Jakub Kicinski wrote:
>> On Mon, 15 Jun 2026 16:10:41 -0700 Jakub Kicinski wrote:
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/
>>>> net/ethernet/ti/icssg/icssg_stats.h
>>>> index 5ec0b38e0c67..8073deac35c3 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>>> @@ -189,6 +187,11 @@ static const struct icssg_pa_stats
>>>> icssg_all_pa_stats[] = {
>>>>       ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>>>>       ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>>>>       ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
>>>> +    ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>>>> +    ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>>>> +    ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>>>> +    ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>>>> +    ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>>>>       ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>>>>       ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>>>>       ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
>>>
>>> [Medium]
>>> Are these five new entries duplicating values that already have a
>>> standard uAPI?
>>>
>>> The same five firmware counters are exposed through the new
>>> .get_mm_stats callback as the standardized MAC Merge stats
>>> (MACMergeFrameAssOkCount, MACMergeFrameAssErrorCount,
>>> MACMergeFragCountRx,
>>> MACMergeFragCountTx, MACMergeFrameSmdErrorCount in struct
>>> ethtool_mm_stats), and adding them to icssg_all_pa_stats[] also
>>> publishes them via emac_get_strings() / emac_get_ethtool_stats() as
>>> ethtool -S strings.
>>>
>>> Documentation/networking/statistics.rst describes ethtool -S as the
>>> private-driver-stats interface; counters that have a standard uAPI are
>>> expected to flow only through that uAPI.
>>>
>>> Could the firmware-register lookup table used by emac_get_stat_by_name()
>>> be separated from the ethtool -S string table, so the new preemption
>>> counters feed get_mm_stats without also showing up under ethtool -S?
>>
>> This -- not sure about the other complaints but this one looks legit.
> 
> I agree that this is legit, but right now there is no other place holder
> other than pa stats to put the mac merge firmware counters. I believe

You can put a boolean is_standard_stats. Only those where
is_standard_stats=false will be populated via ethtool. Others will be
populated via the standard interface.

Look at icssg_miig_stats for reference.

> the effort needs to go in re-structuring the hardware and firmware stats
> implementation to address this issue.
> 

-- 
Thanks and Regards,
Danish


