Return-Path: <netdev+bounces-251755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH33LJRKcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:40:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA53507ED
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C6E35A1FEB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3871387572;
	Wed, 21 Jan 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cg15X/yz"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4618366572;
	Wed, 21 Jan 2026 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966505; cv=fail; b=a8R9fsaNcy3PICsS/Yr1Ihg6xUgHrqBxLeIwQ9wedBK+sDt5lMZsn/qY4k4wjdpPsnutzrODdojINmdyR0rUQLVN/24xEP4YU5gfQw2F/BePmYurXkK14keIyTl2/5uOb2fV02zXO9R610caCBk92WdPq88b0fpRJvgAP/ldKc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966505; c=relaxed/simple;
	bh=LJaBZDLGsVzkUnV6jwACgYaMtntPfS7ZS8lGzsZ2JzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nd/vxKIuc8aJgaI4fp/q1a4aBa4CdCWob5wBdfnA3qVd0pCnqiQaHL31wHioDg4octo5sNQfpL4V7cWC998NhLVpd8CQtr+BIdCw8QB49TqIqdECjCRc2YU8MS51pUN5VkhqB8IC3hmFKOYFKJXftqMrh9zvYjdygtOY56Zf28U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cg15X/yz; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygeK1jp/xzE0In8Tz6KSA/aYC7hHM+3Xj+LJWC2cb9QQRfHcBv0MkcBq4hJ94Pgt9wU6G84PE5dH8WpIVPx8zku1ncuB9pxaQ5z33p7TksU4lTkwXzpDlTSG9/3DII/Cmqhw7TaRFrB4upO89kD9FATd0m2GVvtTGJm9tJWArz4UW24yxOophKNILtek3n+ZiXZChO1jkX/9VZ1Lupw4XdUNo4CEQ4H+gi8UglU3mWunY+BXPCuD6ZWYw817m6cwOHoQ/pvLCsCzQl1KFNc4KMh3H4uSmnQlwJ8XRnBwTSTWBbCFU92G4njn8HO9uJdXg/jF4a6+Tw2NNG9QofVjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdKx3aTF4+M18OkMCC09P25K94+un9kL5OO0k9sQQmw=;
 b=paexUB6mp/0FHR/QJJuGGlFlkKXjv+Mna0F+Xqn5ngBriOc3QFwphIId4GMBVsMzZ0ra/lv3M+FK7PhfSDA8mJuQjDLAyH0Rbkkkw2vZl7/YS058frooI1ytm3d0m3NJuQWsFFT2J9BRAmS02ouoTIp9Fc6T/XOt0EUjK8nVnPNSCdv05xK8F5FIVAKoZDz1U5ig9I6l5TfyZtQ3MI6y/Tzc5Nvr1lMN6FL7K7eOwcjLfjd69s2ZB+qkCLZ7TgUbJ9cKNbRKG7Q9pRO3J2ypqyOI17fqOWgmL7HLbMz6sFq3wzKgp5PMaQyVSfuXy2irW9K+oyg0hfe9hGPsg08/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdKx3aTF4+M18OkMCC09P25K94+un9kL5OO0k9sQQmw=;
 b=Cg15X/yznt67VihyN8rP16GohwBfN3eJIVIekQhBFbM0M31V8BOEo9iGFXY+X1Zs1I4kyI4nr//Y0Mz7L9EqE5ld/z/9z2yzzip+dgl9thN6uk/sG+v7VWP1oWaQuvFuFWEzoS8LAFRetlxFYYNvOVrORSfRJ813XrNtmIIZkRg+I7Fa0IVUGSdMJpMFhgCN88rw/2MpECQ2Nv5DbxKUa4+OUR1gh9p1ESCvFkJpOLPQZ1H5FOWXfNeLhDGaatnHKG1SyI0EP5KrhUrmiRkEWWHuQ5MjecPJu5aHtRQPDeFt6XFYwO41hpOaGTKt8f1eazpEBTKsVBIIxkEQk7jGjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:35:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:35:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v3 net-next 09/15] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
Date: Wed, 21 Jan 2026 11:33:51 +0800
Message-Id: <20260121033357.3261464-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee23c68-6dd1-4ac9-2593-08de589e0e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?leigP24Xs1pB5v6AwoFnGqPngyqParzwNgAMMhxmRuZoKRFzsykljphycuFf?=
 =?us-ascii?Q?yYueE30tW3B98fSlPsin+t88cAX1wBLDX69c7oU6XtsPYMYHpCKktY524rlm?=
 =?us-ascii?Q?/aRcnMeh1RmbQHIGYcsRfhWItqusVWREHYasODVzS5Tf84aJYXRONO2BnpEY?=
 =?us-ascii?Q?nniELDRdBOvbXTdEKzwGejSUcacCfrVzwElsjg07URQr0yAfMqZZN548D6kP?=
 =?us-ascii?Q?mWG6+PUpyI9AZFUMDH9CF0b5CYDjPd5p4KF1kKMsH2i/47zXnxkOC65GwI9s?=
 =?us-ascii?Q?Kn7TNP8sSng1F93+lqihcKYueaeIgJV513NAb1RZ/ds9FBeuQJuHlCWNMRsA?=
 =?us-ascii?Q?h3ZdKtlK3d5SOIMBp4fcXXBRoPIzr3KGeeZyIK5Q+Uk+vdXDERt4hM1SWmiq?=
 =?us-ascii?Q?4jQBdzhdiKttuge2rVN1wkE9WeWaa/5Fqisnq35lWTAbiTZj3vLFnwJeSwsJ?=
 =?us-ascii?Q?7GCfcHWMXlLLRnnfartjiS6i4tI8VOC1MtZ9efbnSEyEaoHbkxpA7GeaxslC?=
 =?us-ascii?Q?mEz/KhLPdYE5UtMxU45kNTVHMEjpCCDXPtDWQR8MFxlzJ6zsov1jDhkmO6bw?=
 =?us-ascii?Q?+IiM49oqV8G3+bZX765/2cbctEANm6FV7hZt3THvX5zZuF7kzIg5mXpi42b7?=
 =?us-ascii?Q?b2KFo24TJAwAm2G1qJd+TjfpN2iRCBn4RtB8zV60Fa7SSMvcotPyEnF96Sx+?=
 =?us-ascii?Q?j15r55YVo1TMAQhivmAlexserPJ6jTJ7e0CED4Gl2K+TU0uSAsOh1fidZo/2?=
 =?us-ascii?Q?zKXKBhDPJ8apDAMc2yfqPeNmDO57CRrwIDfmAVs4pUCjwbCuxQPMYbRL47/c?=
 =?us-ascii?Q?xbvq7dSigFSQbdeN/qrwX+l3g2RqV8aIrFIo5ZDGiDperpBcgUAgG5bT4sen?=
 =?us-ascii?Q?BGqEqZfuIKTYsKmirG8/9IsjdIOiqETLKr7ymFY2nyibiS0qKo4bwMz+SVTH?=
 =?us-ascii?Q?gOFx+p7R0PY8yiJWA49QugYhYldn1zBGCcs10PvM++pAZkceo+NyPcVoh/i0?=
 =?us-ascii?Q?JCDcciBCTAQGQs9B2dKwCARmZGK+Z+oOht3lz+Dtyiv0kjcQzj1eUCYK1tg+?=
 =?us-ascii?Q?r1W+OgBRWsbvhLfuerbwtWxLMWwHRzvy1KsTrYwv3GUF3Cg7WM3leoJs5N/h?=
 =?us-ascii?Q?VsBEoMjhTKgGd+soTLDgqTLuuwSsOJ6kyvsIkZbrurUY/yp/y+kxKhAJ8cnR?=
 =?us-ascii?Q?R07gLyPXTxHKgq1io6ycqD/lxqjKe4HOUMJytDkvSPNV1/Y6O+ikQxAGO4gA?=
 =?us-ascii?Q?YLTDydvJWFWaXos3OZ/aZgUk2QibRdsVB3ocwFIUWLZSn5vyQS2EUmKwIHUz?=
 =?us-ascii?Q?Sl6vcNZk1aHiXaeoSKGrX0MfJSjLvKZdsrTXaVc+t0Nv5EjJBCMEpoPM6W3d?=
 =?us-ascii?Q?qtiTHzi9G0aokOVxxX/i+Wv8WcEzB5LzkCevo0r6MuATy+2Q471q8kNDivZG?=
 =?us-ascii?Q?TeoltmJpt2KGEsVhLCNaUv9m8+DXfaZpSzSDFevzzAj5+AXdjED/aA39cfRy?=
 =?us-ascii?Q?bhjqmlG7mAhd63HNutKv9gD5pBZTXbBkulqCr9mrsiFNnAYyVbDTmCjK/w5q?=
 =?us-ascii?Q?sk1hWaDVxvXlxeoqJXRIO8KaYAxhNkjSfY8MZEzHV52BvS1n/YaOsrnZ9n+s?=
 =?us-ascii?Q?MB5FfHBUr12L8aDkk9RYh7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fo47jAYy5G+7MPybsrIAk54s5BUYjijJ78kYF7eF/Pb1K/Ay5/j0v9bnE2c?=
 =?us-ascii?Q?OkkwkI2uo0IJqs7yHUHByAsrXMS6aqWdgolaZCrAzEZ9JQm6iyE5swCTqWyZ?=
 =?us-ascii?Q?UATReKKaethHQbJgMXLSMHd+IqbTfyoSowua6lMVgb9RSxCCpBqqiy0MBcXF?=
 =?us-ascii?Q?4vRO75SSQgi0AviLjjt8dGiDh+eIn3GmhKVi/FSbM3btd2EXK1Br1kVvMyQ0?=
 =?us-ascii?Q?uXubcXZhpqHD+ll+JL4LcggtiG/2n+rFb0OXpZiYkskcztb+RMxCy0Yj4zik?=
 =?us-ascii?Q?P2iIoi7cYxVLZpdcyxJsFVxATkwqrMDPfE+IpH32gzAnIvBr3HxMTITA63xt?=
 =?us-ascii?Q?7FBEqRc7UM3F96e1NO4IcdlcKjQMD9JqL+fgw/vevDjRTrBA9yAzUE5so0I9?=
 =?us-ascii?Q?R3MtdBDL1hjw+KYUVYzrhgz9hRiCv9/lwrXn9mNTYc2i94UQcn2g61eEMezM?=
 =?us-ascii?Q?xuMXGQ2OaCYBl/R6mrr93Cqk3bBICUT66K1ahV7I5fhOJWTAB3doAVHIhvIA?=
 =?us-ascii?Q?vdXLvyxE3+PPrl9kCnMj7nLnl7+VYoEtYTB0cudc03t4sk5vo1xkYdfky8lu?=
 =?us-ascii?Q?cbHUeaYU0HddbRSN169bV5WXYdBxBG7W2WgdlosZQg92p9lv+5UhqwlGWJaH?=
 =?us-ascii?Q?+fEquOaWATNavpep8VpLEpPvpTo30O4nTA/P0KeUmAfOse7bTsBx+gYBrxUY?=
 =?us-ascii?Q?M1B3rhsvT+p13xLDqEdaQ5mmZnwB2TBusz47rt+ncv6spRVTYDDAUlIuWpBM?=
 =?us-ascii?Q?WFCImF+MQWF5Lz1AeggTLod98s9KGaxrJKefpgCf8Wr6trBy9CJu0iQKQ9UM?=
 =?us-ascii?Q?IFcnYoHKfDW5R0uO8LOT70mPw35v8GUEzXzSy8DAb+bUxGqZn5MIJRtaFwsc?=
 =?us-ascii?Q?MehkfivlYSpSkb/leHTrfG7VbuVY31EDmx1zp/n6UpTzkHAN/E/Z2D16nfY7?=
 =?us-ascii?Q?3hKA+/i0eFbZ1ACgnmyR2TZwi4AuQg9nOJRCJezmgMCznfJhszpljP1dWx7/?=
 =?us-ascii?Q?dA3nww2L45rGabJnJrEDc2q+jp9UKYDnQf6WTNzfWqXi05Uy+URhR6zukmWv?=
 =?us-ascii?Q?VGZzJNzVezMlkrRCNaxoU1yIWaMlS9mw7y/83DwSB5nJjsNpbqpOl8ZrGrx+?=
 =?us-ascii?Q?tFt5YqJQtRKw6IBIlLeCtsVjeP03doVVYs0UMd0iRWqJT1N4dikBXGpBRVCs?=
 =?us-ascii?Q?ZFQUn78PSxciUW6flckoFTvxHEzOVYD/4QNJTZlkupwx0OrNyBInvvMTgiiG?=
 =?us-ascii?Q?tEOFiIxFW+0ntwPowWNjDp1cW+HSxFjGvafX3FLOmN9FhdOyJV1ceHlQxLA3?=
 =?us-ascii?Q?XsAh9gc6Q65AsTArGc04Ir4aKG1R5VVz5Sm1z4Su+cNYlpr/iB3pw30h/tKw?=
 =?us-ascii?Q?FuMP03znvkuYUXTLbUSr4ONs2i1kC7oXCcXSfmZGQnprtFXKc7qBJIE/GU0q?=
 =?us-ascii?Q?p2t/hND0RauBmqfdnMBDCDeYxLVzqJ9JNSn/6lbZ+hfP8pAxsAkadze5Zwtr?=
 =?us-ascii?Q?LGED1ub2Vp1SVdFH4zhi+my1j77FiteJ3nYgJsPf3fVdHpqu14o78Wd5uWSp?=
 =?us-ascii?Q?uXExYsjtMErjfgGbeElEIdr9oLYVYIv/ul9pyYxSjSf8S5KXC1n1IPNPoKRL?=
 =?us-ascii?Q?aDN+a21N2tBEl83koe6ZpY6S7k7qj9Dicf9Mz+eqsSDupi2AX5FzorGD8K6o?=
 =?us-ascii?Q?ClCWQ0Wi2OjlZ4k6mn4V52caCZyhsZ9RejksIugY1LyQRWeBdhqMkDnyPP/F?=
 =?us-ascii?Q?EJgWK2wn2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee23c68-6dd1-4ac9-2593-08de589e0e9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:35:00.8123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bDyoc3ey3kJdL1hn3XmfE9NQ46dWtfTh2dnldfh//3iHdiQxVxTyBaIt7UIdE8+6Dp+WR+kTGI/LIrl2z5+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251755-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8BA53507ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
will do NULL pointer check. So it is unnecessary to do NULL pointer check
in fec_enet_bd_init() and fec_enet_tx_queue().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c927ab5ad8a8..2d486a62c178 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
 			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1537,21 +1532,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 			} else {
 				page = txq->tx_buf[index].buf_p;
 			}
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
-
 			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
-- 
2.34.1


