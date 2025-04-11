Return-Path: <netdev+bounces-181743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0AA86532
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B09444E70
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD5258CEF;
	Fri, 11 Apr 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hpa23dtV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DPVld3fK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30F259CA5
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394548; cv=fail; b=cmkZsv2+UKB41YBmsR0jKnYEbNv9oj+KbBhj2//aB1pOIAn1bcBS3OeDpWc1W3vCKk21GvRHS+wSUjBFi+l7BpZebj1STD4ieTQDQKWNOS3R/xrskuTo0FgO0wDdyb8cx2S8f2MfTRayz976Ht8BlBn9GXGZKEAUK+OskHkmuUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394548; c=relaxed/simple;
	bh=PKSq6btSsQ50HieFFrNCntm5oBB0CwNivuop3156iGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2yayDKKKnDx26W0ClgNJuxecOjcz6kCeArlLQe8PTLbWJ28l1qAGVa5U6PqiB6nABHbwcQjH6lB4pVRkAC+ZTnxmiXLlUlJfFRMYi17B6knJ0YQpBgSVtArsPm3FfpcGYpVx4tkYIN0SPj1VmnuMKnzAlxc50K+siR+MZUaTCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hpa23dtV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DPVld3fK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHiisU031864
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LOwaLbb2omh3dU59NYVRDEq8DM8KYfH2TFob4n1Ys+M=; b=
	hpa23dtVvuVaa1rCuraQJreKYHZJmMFOlD8PUg9JhYW0Jzlmz1YBF2WxgIW8oqea
	nQBQJ7zgW8p5Pk1FPTY3KQPYnJfVuVWN/5wbOmAcwIb63Nfp0txhK1jHK3KVgGVc
	y7I0CANgbsjpC5ISfSUc3o4g/+GDiiDCq6Ir/gfM1Pz3q98ysj9aq3I1LMvuWXig
	rsPLTsg/0oLHdubcE2gGgXdn7YaX+PhJvpf2Zcz5vxjLXXsGlEWLUJyEZv5nEjTK
	8hn2cDwsCo1GcQxwYhU4WPVrSCs1x3i6L4g+IPU0jQB6pbSQArVnpVy4E+vBvmOR
	LKp+qEyRGtHGYLc455JFIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7drg2m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGYfkP022165
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyequh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr69vb37V3ERAjxguJHB74x3ema+AbsPxJqJ3EyDzSE/hG/b3VgFV4kpe9QJnUsFLqNMPp6eMrOCFMlp1C/3bjnANPHYlwy2/qQti8t4ugcm1wQNRzS0X8qQ0aXj6FeA7GnyTIex5+UKWBmZ9SeT2Cmj7KMO0hCU86LYtxA/fS9iQqgGJXh18h+x8pgn/iFBsJ59AuxM2DruZUiGmsO4SGCbxZUu34qW0JJxAkyP88WE7ar3qaQNpqS4gya53qeBC1c8QdENx2m7gbMxSfTXAV7blBOqwJdUuXS824Ti/fzxjTh0OJogZpkRpfTcmkTjjEYsXVy9Zz092QLGLDc5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOwaLbb2omh3dU59NYVRDEq8DM8KYfH2TFob4n1Ys+M=;
 b=sbE820MNXOnGYiBElU0uoT7aEcrUFB9V/wuNDISPTZYm3pO26uPWuF4/0mnhnwtYm9TpiW16WBGNT35smSkYjE4wDsiNEqsPooA9Km72bVS+pPq708AGw4v6EVEeTwgkS06czPtEqD70+Xn04lcScjqJZVN4YnMlLCmfszwKfZ08WbS+cJkdL24mMSm07Jk3MfyaPfaV4G/P8OBhEGEmvpGYuOOsfgVUkKIrTp2sJZhmxhZ8v+TX0Fm6P1mWDlxF9ib1OENIAqxQrGUWbl78EeMgq5y1uovHw60RckCesv2mqm6GrBfWLuN9vXEo2FXSYYWnoAMjqn3vi4K5hcNfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOwaLbb2omh3dU59NYVRDEq8DM8KYfH2TFob4n1Ys+M=;
 b=DPVld3fKkSzNbCsTRdez3RewYcWkUmqApo+WulEHuKCmi6ZaMlVQ3qD4bSoKrWlUNBLFtr6DUa0RCZwynhSKBy39mCcr+RC5gi9rNcNF0G/P6Jh2WMDr0NARWZbai4u3xudcfctCGbyI9M9w50aYkBoKcmqAlZKjeLO9UQA1UJM=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:23 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:23 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 8/8] net/rds: Kick-start TCP receiver after accept
Date: Fri, 11 Apr 2025 11:02:07 -0700
Message-ID: <20250411180207.450312-9-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 05757006-9953-4d91-0548-08dd792302a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t89HQFRMrRfeq8zwhqu4tSA4rBVWg4MAHOqrhkClm8aeA7hwb2kVtbc5MDHu?=
 =?us-ascii?Q?2q5xXt9iuQ5n4os2txR73duGwo7MGcUxa4qlose979a01zNUfQ7Y4bWQL3xf?=
 =?us-ascii?Q?0CmaXZYXv9xVwjU8SW34hzd8SsTx3CqYDetC5gbPygSX8zgM66gAqEgOzkaT?=
 =?us-ascii?Q?mxKgE8k0ECjPnIMaosJGXgbrhorbmWWANhs3XBj/KoC4KbM7HVJE+ElXEAcO?=
 =?us-ascii?Q?/QblGTWPgHrlBBnTwXP45hGHjHX2iLcRfnpqHEnXYp3KoM23vcurp3dM9pOI?=
 =?us-ascii?Q?d7v5IQx+5FLaamvJ46PX/Tu8YQwKH0KQYb6bdiCMe7J9oYJPNO4GKL3CoRrs?=
 =?us-ascii?Q?j7xXkspIEIjLVYGNNaC0myiqJErkWkahHN99EtR31Tqi62GGU75KZno8i6Mb?=
 =?us-ascii?Q?cHHE0QWp98FRMHnd5WSTmehwhhc2CHMoU3KgqP5/CkbCa3tVQ0Yet50uqg6N?=
 =?us-ascii?Q?7txZUTmEHjpzQpFygURwTQMVc18FATEXeUyHZH7ynmiTGPNcI3xBHkvUxu9f?=
 =?us-ascii?Q?in+mtekheyDIHUOzMIZB0+XfZyDAF59q1Rjofwd/fwO2Ml+i1fnGPk7DUpwA?=
 =?us-ascii?Q?TyhSkR6e03p9paN3EwDSfliSFy2If+dggv3QJhzGd2kTRKi8KO7atHfUN/UH?=
 =?us-ascii?Q?PdA5Aej04Kuw7Yuc1WzALXT1sLVdVKgv77ANgdWJkZcYjj4dyXXn1dknUhfY?=
 =?us-ascii?Q?y/sgdh3qj/wS2P7vgZz/K/O6eaasN1xZayUa52OaQXqG9SJ3LXiRDCe0vfXy?=
 =?us-ascii?Q?xAcc9CKi5HU5bvFqDCSWEF04uD/uA+lwyM+Qn6G+1N0DicASte2NPuxPWKU1?=
 =?us-ascii?Q?FMDBNRH+KALnp99eiw8hzUeNPpMKoRZhZbwdq569G3McjI224rWGcKGcE4pd?=
 =?us-ascii?Q?t3YbcUeYsYbz/anruuzGnYww1IOWFZuN2kuNAoJTIYFdfEu1ISW05aMxMPfS?=
 =?us-ascii?Q?OsezLddHezRpWNbhWdfOIjaG7TFUa35A0aUIUG3qfPy6Pa1uGQH6FGeal1MC?=
 =?us-ascii?Q?x/laxaqRM1wiPnZh4x1WpcEW06GKvzvV9OnCyGOkMVJNFvcAOFbwOf74sckw?=
 =?us-ascii?Q?LdaJQ3XNf+Pk13dZShP1wOsrVrfafeyF14gvz5smsRr5gxqnVorgeEy4h86E?=
 =?us-ascii?Q?50fX3TB6g8RZloLr18tQ1q55RMNOoVbXDUqpfJfiWhE8ZbTLSjW8fG/Z852Y?=
 =?us-ascii?Q?Fgo4NT7SWh9kRScMv2FU5K6rsDLuZbgcdwnnZTWzz87KlQlTaoUQeTFD/PgO?=
 =?us-ascii?Q?VykcnZTDFqxQVfdvE9A22Jt/3lgpkPiBEmT/L7TFrPcS3w+JUG/SJofLySkG?=
 =?us-ascii?Q?vrZvkhNsMEtRTFxXswYpemyyS0tu/4tGN9jvtCVC1G26gW+qHiwhCII4dZpN?=
 =?us-ascii?Q?Wnz7L4HMvV1D3MLjXto5xoa0sGmBKAMuIiKYyUQvS2Ae0+5/qR6gV/SzkQ55?=
 =?us-ascii?Q?qMUFtYRX7iA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+yt8K91JUKV7/wFbIEvnpNEHsRfeZGco34Jaja53MZsPnm5SAxfVUixHxTm?=
 =?us-ascii?Q?7plHSPSZuCmuRc11CGtYNKb8EOLT0eojZ2A6kPqgGD0VKrUhnfXrg8G/FPEo?=
 =?us-ascii?Q?YXAjx36wu5r3BSTbT6ZLQUO2oIOCjpljdqa3+NuZkVcksOfX1tBk4yfwuBwa?=
 =?us-ascii?Q?sOkKLnkWvRonSyRK3AruiGlAXayjHDknCXJl3VbTMSW1moEZjUpt4jLigowo?=
 =?us-ascii?Q?Jpum2BNF1uzEdJ61KU41q+iTpJLeXyVxlGGieWXNcVOLqFoB9XLvc1WUfBc4?=
 =?us-ascii?Q?IB9VPhG1QGzTZNwaDE09Q05Vfsse0FY+vONab7vrpDfwiRIw+zKab0F7bS4s?=
 =?us-ascii?Q?w3KU3AXL6sI2/G2jxIFlj4voJ106D7uUh9nqEfZBZ9wpOGQKaHBGLd/jlIoe?=
 =?us-ascii?Q?C4//LGysDbWvQtZADId94+wjG96XAYIFgaGdVRcv5bSEC0dVDKAX9mouGaIC?=
 =?us-ascii?Q?OjatigykVOiOvSr7H9rLF3+4jNhs1tqFJb/bK6KPOgVCo7mfgzuh6I6U2m+S?=
 =?us-ascii?Q?wq+ONmkbTzqat5c1O57WsXLlPFHvKvNdCY+S8SVneK8KmZzvvtDqFE2TpPCb?=
 =?us-ascii?Q?te1b6YS29Pwimt5oBq7/g2LqCmPbFVTSsmh4dZj64zqZ6OA62OX1y7H+XOtu?=
 =?us-ascii?Q?8rV9/uxgD95asXGxCglw5tbUYBp/eeHA5Zk51rpmqOX/F0DeHu9MPD4W1bqv?=
 =?us-ascii?Q?/b1eeNe5oAIkOlZEO11RUYRJ2ynYYlluRYBaCI2FNbRhcUJbHpmCXV0D8LxW?=
 =?us-ascii?Q?OYYUcLyrHT2/y/0dJ63KJGDgUtiU3cZh3W/4gqoaBYIOyT7hiOzPDGDoXSHC?=
 =?us-ascii?Q?rHSDHuthiLM/FfXznqlWEoP3tkIUjh5idQxaSv3EDpisWPXmqBAFkFFFL/uw?=
 =?us-ascii?Q?NuQF1wmV2Z6RYurDgConRwaH5EdXu1/9M+qTU7vL6D4FLUkdx6bqvKNNL060?=
 =?us-ascii?Q?dZN0RVY7JcIqM9z2NVO2dofV8lr2Xh9MNOxacgpjmJ/rK9cAkAOif8KO52CC?=
 =?us-ascii?Q?OjMGoHu9qBxuX+Ihm8zuHYjT4ogG3gD6XQcfsjqZq0nOTsid3exjkXQDdgOu?=
 =?us-ascii?Q?9F4USN4nBucMRoCfsxNtOpE+DrvvdGhXX0a+vf9yvunETs9/1224KliGNHIl?=
 =?us-ascii?Q?VmF5ZMJFIpJgxgFWxTrx16BQjFYgWP331UEKQx64zsg6s0xrlO6qnN9fgqUg?=
 =?us-ascii?Q?6GPwo/W6N73RDudPN6cGXdHAhmOud9R34hJYbl+uMVlio3Xq+Xj5QAFYtTD1?=
 =?us-ascii?Q?43gg+wOiBdyETWqtBTNau5mi3yZcoWSP0oTDWVru2EzCrJI0E5sPVMercA8p?=
 =?us-ascii?Q?mDP/b/4N3UXI5yiAONM+mLDhvzxDpaQxdHyS3oBkH+NRxygQMPbR+slVGuqZ?=
 =?us-ascii?Q?1kCYsdS5z4JH3Ym5MGuNP/ox/gpVBiobbf20jzqYdCnoYF3LGN3wv7ZEIN5g?=
 =?us-ascii?Q?ow9uXDZ5WsxUo8+WafTLZuknvKkdywuYnPaQ07aN8hOgy2tOK28Se3Hie5+l?=
 =?us-ascii?Q?r/k6uoF85MyGOuk5BOxub16gsX9dFL5kheVuaSKC8a8uSL5PaQbyHldJZ4JI?=
 =?us-ascii?Q?Y68xsJiWlpcsTEUVhLOIvi+lOdvIUTx6R3P0ujlWVlEXTz5vp4hZJqXQy3NP?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NaJQ77dYTXeq3wWmElMC9T7W/YhpXClXnmPGuKUczhnJbxWROk5wv5+FFdqQgF+Fi1KvVYzpgqNnxqFnrS5n/90G/8YoKeHY9eSXgD/LHda1kF5ozGscm3Xa1eKPtmCiPkgdyeP4kUoIRfwqbbjiWSVe3Y0LQwTed0TEIfT+2JWvxDyNKXlgcYfk9GqHDTlhNKLBCdNa88BIwu2TwbHfWjnkGne69gqAKvRFtQOD+ERYC/t0Jj4LIJxfP0ZoygPmSNowit0nNVhkjTd46SvMJYdd8BSlKM/UpTKCh1n3gd1Ol1UQDAznlWbE8h3e38T2I2EZARtg/1oKWU63ENAorSQH2uG16jZbGcBOdkzSby+brU5aokmfr966BFHI4dBbOEaVN5W7pxcDeJr2STvl6DGgtuQIl7T7ygKMuY2Xx7hPwytREoguOiYTL3QXhSusx9SWXuVgJWC2yq8h4k74TSvYpJNNu6rIhUgMqTW9maLJ9Uw+szbr0L7T7T02mIeYVZq+L3Qmyx/cflEyJtsBT1IUrB9tehmcXoyN1excE45lSbBMwznzbUo4xAYcQ8cObjnM6bEUxZtCuABzGRJ+PgfJY/bqRJrFAgTcQB/AetE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05757006-9953-4d91-0548-08dd792302a0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:23.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB7d0tjIPnlLFN2MTuUkceRGaT0FJU/DxtuQ/sJxvRwTpmCKyE9IroH1YCnNUyZ9XmGeuZTiLyXDU5xP76uWwGDQOoOonEWrRxGXxjv4gWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-GUID: 9MBahX_3NB9V7hFySodGf01h3iUEdiin
X-Proofpoint-ORIG-GUID: 9MBahX_3NB9V7hFySodGf01h3iUEdiin

From: Gerd Rausch <gerd.rausch@oracle.com>

In cases where the server (the node with the higher IP-address)
in an RDS/TCP connection is overwhelmed
(e.g. by a client continuously issuing "rds-stress --reset"),
it can happen that the socket that was just accepted
is chock-full of messages, up to the limit of what
the socket receive buffer permits.

Subsequently, "rds_tcp_data_ready" won't be called anymore,
because there is no more space to receive additional messages.

Nor was it called prior to the point of calling "rds_tcp_set_callbacks",
because the "sk_data_ready" pointer didn't even point to
"rds_tcp_data_ready" yet.

We fix this by simply kick-starting the receive-worker
for all cases where the socket state is neither
"TCP_CLOSE_WAIT" nor "TCP_CLOSE".

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index a9596440a456..39e6cf071fb6 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -312,6 +312,8 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 	    new_sock->sk->sk_state == TCP_LAST_ACK ||
 	    new_sock->sk->sk_state == TCP_CLOSE)
 		rds_conn_path_drop(cp, 0);
+	else
+		queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 
 	new_sock = NULL;
 	ret = 0;
-- 
2.43.0


