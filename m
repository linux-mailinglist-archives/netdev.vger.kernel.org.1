Return-Path: <netdev+bounces-141417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E99BAD9D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8CB1C20E2A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B419DFB4;
	Mon,  4 Nov 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="JfUFf4B/"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1819D086
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707509; cv=fail; b=lf72GmfAvfdSsBRzcN7JPAbZNhGALK5NIPyaCIgHdL5dIwupeykEEwHVR7bsqeFS8+0gF9RZIuRQAx4xylrDTcq5bLH5E9Dg0gQakT2N+rCkEeOudStUwB30PkxZSJ48Q62sPxGNTgZ7PUnT5Qpdj2c7y6uTkKfPcR90flKC1GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707509; c=relaxed/simple;
	bh=LwMu4h2Ye+0tuGnGuBfFIiHEXf6MgETVtnCzvS1mL78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HmqYyXc8OPUlv4FOKDfpTHhHA9UZx5NBH8uuJ+9sQOMoed1SVoSHCeA90FLLeYep2PAvMOBSxDvkw9A3djMiyVHKJUJzcswuABOzHpesfzaJl0WJaHjL+LW9sn7JN1C6JXQjvoa7ct2BlvnlBqhg+FKZUyIc8A/LlR8u8WHajQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=JfUFf4B/; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D038734005A;
	Mon,  4 Nov 2024 08:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7y35UKVShj5vVzjGIAmsqOAyjtD/2a6U2rMczQYSJ1CHhAWMdyUwimYDoX8TTQqlbwowoNhzG85f1DQrshRdHpSzlGvZLpWnWeBZ8fLwh66HUcKsZc0H3yW7aDwRggoQIcxRJ1CseYe9T5hJ2oMthoT38jpQjGk8hm4fRI4rQk6boBxFwHaX7FI1NjOH/U4CQA926YwJTSg457H4CFAB6D3aGJWKO7rW1KGA9OS4T0Tp0KNWLz9Zx2/Pqtjpanw58RMxpkp6nsIhRYlZWVd7TIox47W0daxb3ouHSnnLpFJG1LfUKw2bqDQViI4KgdFlbiGmSLMSouJAAbQeSgsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfI6vxSqWjoLvb5Z9vMWxTB7MGLt7R8kjlSMGt19DWE=;
 b=k2OVymWwPEFMNbCnFQGQJJt4xYbORlSDewK9Wn1Nl+/IeAS07FX6eXkOsB15WDvdPLmHm7uMOOd/8p5H760oThxi7jW3izy3QiHQ2XgMLUZhJ3SPy0h9npz+uOb0cctA7RHbg+Q7gh15IcuAhio4FSdOOBe/UBHroi2QWO6BxDPqo2H7NZ89SX2utu9i6xd0OfOA81uRfRD7NFh1eq296C7qFaPQhpiRNENw4yBY4EhjjkzJG5HnshrFqcBfinK6us43E8gG8BQTQiSuNGwYmWVD415pYOgfjzzmQ/G55FgsfWdIDaZyuo6kB01p+G10w/6tAWDljg7hUwFNSaTRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfI6vxSqWjoLvb5Z9vMWxTB7MGLt7R8kjlSMGt19DWE=;
 b=JfUFf4B/yEee6OP4y02pe5W8gN1oB0Q8sNY3TML2UIPyfSkerJuTorSvZMqzWwd0tXUP5tN0rJGvkif1FWaO7BSCvdPcEs3U5M76kJXCHo3BRwU614B6r2CkG2duhTqCP9UPOq6wpzhM17BhgeB0sX5nWxKC135+oxAHLJHJfGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:04:57 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:04:57 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 2/6] neighbour: Define neigh_for_each_in_bucket
Date: Mon,  4 Nov 2024 08:04:30 +0000
Message-ID: <20241104080437.103-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104080437.103-1-gnaaman@drivenets.com>
References: <20241104080437.103-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d92bfb9-e6a5-46e0-b43a-08dcfca75f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mVcDOr1FdtfFnXzkYYBSm2OExP3OrEMBq/jXz9ayllpjvYyry6l9p789b69A?=
 =?us-ascii?Q?ocWbUJhJJwGysxGtsiVbzlL3VxrfAiiGVV6rPuACFSOSZqhpEH8ywu91kwrX?=
 =?us-ascii?Q?g9PyiKYnCcuE+jJFz6CRM86fpkzs23jkdBnBibCojTDIAxtf9vXWmAcT9mI3?=
 =?us-ascii?Q?4LRdtcbBoj7E2g9vz1eoWCxVrwkM+jMqTOokgiaC4CHizFOu1BXDDCBXPz06?=
 =?us-ascii?Q?XmyQm1IQIQPQZSHQ1vR09H6WpmdyTpaVcTFT97U8JsOlv3HRQQ5rVrRIfZyc?=
 =?us-ascii?Q?IlNIOULG7iN2DdfuPxlwKB2aQvAX/hmiY9hvtidyJ5qWzM0pFqf74v+4bB3K?=
 =?us-ascii?Q?aSquWRyzLJBo2IFXLPuTHzBuEFXv8NatT6fKs/Nqzj8xwgGteXHZPGp7jFlh?=
 =?us-ascii?Q?NN9e0EMShYZ1RONEaRsJ1r7Z0pHDiB85E4BOMlgGHfWkfHv4eOBPAA7dUxxj?=
 =?us-ascii?Q?m9yh2FX4T79ZmDxwV8oSCoNS+UXV4SuqE21vZgBDGX1hSIi3ycjVqfVY2Ysn?=
 =?us-ascii?Q?QDpd4AitndwApqjCFSoGTDApDIokFElaFzG6z74ZLnnb8O7ZyfdXwCso0Efh?=
 =?us-ascii?Q?MKkfZB12sxvkT7akSPVXxjN2Vbqjlr5t9hMlsz2CmaFJQkxiOratf4U8nWw4?=
 =?us-ascii?Q?EwuG1efF2nY6/Bx7sXN9EgZ3jbXjk0wNq2d6hErO9ThRZqHWSKa8V6WV48tF?=
 =?us-ascii?Q?zODIuGeRKKrQPVLMm1gmlQmpv5+9GfU1lwvBaHP147hXWLprVe3/SwqnDCdK?=
 =?us-ascii?Q?prLAvf8kG90j0EoGmT7nIDcy5Tl7P8JM0rfUVjvKX62nwoMhUZuI8NCKenMI?=
 =?us-ascii?Q?035GIlVol+pCWMc0a6LcfJVnIuUgqhu/U5rELsoOERvos2CcliZ7yA2lDxY5?=
 =?us-ascii?Q?POQnSl35UbLX49AY2VrTL5L+84V9WREzXSYPGjyj+l+hxt1i8FvDp33O74gQ?=
 =?us-ascii?Q?ouO0OWhr+GwHD9O0fJlxX/Ieh4aLok7cE7o66HxJDdaruJIlmxU97sq3Yqrb?=
 =?us-ascii?Q?p3zkrEtE33eIYG4Xr99zPO5IrI4xwg86g3lGgSTB2fRm//Ug7fHlWYcA156U?=
 =?us-ascii?Q?/y6EIgkqgos0Co8f67lvuIByd5i7qjuvYhIw182Y5IpVOg5U0Os7Iv80iuuv?=
 =?us-ascii?Q?v9lKnb1PDA9u9aVjccdp9lRLnUg+k2M7n34erDFt57ITRvuH5cTVW4YIHEPM?=
 =?us-ascii?Q?gEAZgB9MFQW9CXjF3AZqX8rREqW/8JKAl0MEa20uym/JleKSdD7dNcnBXiMI?=
 =?us-ascii?Q?mj55JIeVxAURblZ9TbbYCi8Y+YD2cgAKcdbJfs5TnLQ0tGrmKsKCvMEdlajP?=
 =?us-ascii?Q?gwNNVfwTmQ5GPouYmsfY48RRyJgBEYbvf/BFwTnY57p/Fn3DaHV9zamJPwMi?=
 =?us-ascii?Q?JkvjoYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AI0DLQNCB7i3yj5N6HVONi6Pd/I5oueX9nDCUGzIHEqGH5idlO1n+Gv9+7Dd?=
 =?us-ascii?Q?DsoVe1K1SaAxEz/adS14Z49cYOF90c38dZQ9J1GthGxMlba2ZtKSClivHTK6?=
 =?us-ascii?Q?uN22msFUrHeptZ6nsDIAH/TOBOfctB7etxAN7fGBNk+meYDcPq6OP3e+tSE/?=
 =?us-ascii?Q?sKjAyTkn8+vJWfoNLhlYhLHgmPu+eeuHC3CsT8h5mdyzr+Sh62Z/2dU+VIRJ?=
 =?us-ascii?Q?Qd7RpPwjCfwReUokblcsRokQPjXEfOKYOXfpOvg/niJg1j76aXKBWeb+SKRh?=
 =?us-ascii?Q?ICFgwKg/0Qh/aHD3/v6vUn6TItL7SYswc0/1und/bXykstxtC27l+HWzS3GR?=
 =?us-ascii?Q?phTRT9BogWb9RU06j/zhPuelfDKG6Xousx7BUecpXo11zpXS9pFn4yNcYxiX?=
 =?us-ascii?Q?VhWHJ4aQEYoxfIrP3bLPG3/VmSGCO4Q+leIljXsz5bhx9SsP9Vkh+2lgj4zo?=
 =?us-ascii?Q?e/xAPDYTG74IyNakYxdNa/lxobEIwmoFc4ZV0bWMipIaZo0uTvLsFVQP1r/z?=
 =?us-ascii?Q?JIqBeAavaOX4FvN/gar9uiHrrkQywabj8IspLSx/0Ewg/+rX1wMqylJoQ8D1?=
 =?us-ascii?Q?u9DKhiYHm8DjNm9GPSMkCGUTtPZLTyhohwq46O9oz9nHqFKvglpPeuEK240n?=
 =?us-ascii?Q?sBC7899Wvvi3AR4niVk50MWC2BEdPmnvR/qZaLMtAXM5Ch3ReuesTq7Qg9fP?=
 =?us-ascii?Q?uifn31V+OHygyh6ZZE3x6vGDWkG+VYhfnc1870TtxlroNcjYY++uQvGk4tju?=
 =?us-ascii?Q?1gtt+gUmgIxLtFxW3BNViSewE+ASKGNfA+GzgGBVcInRGGt1CnPxdBaP0bVe?=
 =?us-ascii?Q?bkEmrGR04gH8rOXRv2xbkcwB2ZF5gulxmRDrKroN4kAZuUl/ekJAgfYhCj5P?=
 =?us-ascii?Q?up4LzRLOx891wdKxzn8dRcdKRZqFTJMXXuTYrsnsBG3mczXrsCPBAHGUgnsi?=
 =?us-ascii?Q?TbGcdx0OM9GohmZmDKAKDEYTYYsNqr/k2JfUBRN7loDRQyy3YatZ8jbBFhyw?=
 =?us-ascii?Q?cc4nXMU9coQm/ALtdHqwoxmNmZoh/EQ3BEL7tsq6CESot1Amf0LV2zSrNVhU?=
 =?us-ascii?Q?zLtbFtwJ29ckhW1naj0CS1Mq4x6bNQXMEDPaphuMo3BP/NOUuV7m6kgXuXEI?=
 =?us-ascii?Q?fWXA/wiVGahCOEeSyKJR5J9Fe421UziaO8Yhuy+A7mmb9QkpMLg573hTDM3d?=
 =?us-ascii?Q?UrjyLavsKVPCmGYAe4pBSYysvlKD5+LW4hMlvvlafIOf2Zpf4hlNEMVFxuL4?=
 =?us-ascii?Q?OsoycFFzMsxEsINNu+M7cExiX61ze3xEWp9bxE//Q7tokHM8m0iW8fJUIEsK?=
 =?us-ascii?Q?k+oZkVViFj/AJwlDFLyZxy9dX9ja7si6Strjees3Ie80aF4FMPHWPQuBrH24?=
 =?us-ascii?Q?11cGTi4Gvnx2mORCCbe+6Ogw6RvTDc+TnIXndrBKAmDOq6N5Eve8T4jBzFNL?=
 =?us-ascii?Q?edHXSHBpqlTU1OTNCljFTZGMYfdM9JMS1F410bm572LToNIRrCoet9qWPDM5?=
 =?us-ascii?Q?98Vryr5e6xc2tkYWFGy5y4igR2dv9/1BbiEuAsCtRSJNkZI1v93E6oq0zuO8?=
 =?us-ascii?Q?ALBWiJ9LML7J9dxAeRfKkVhPJUDh2Ogtzkt5wm5299upV46vapXHc3hw1e0m?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g/EK8/S/9JartVvpiuw6aaduBYtRD2tpaZn2wE2137nkbeW8POFifCGohiK/GoIb6sUkpDl4dOvDRamh9LYu/KfpDTQhcXEDPyowNt0CcMAUE58AM0XY9ABiRZ36oVdBJV3oljzZLoopd8MYH5apx0H7lcZiNxaPbgXka9IoEOyL/5SYmz25MvBH3AebQw6eSbUiqxWkOXdMsb7UoD6Z6SmRuL7hx9ggrYr7zoCTWna1t1MX3MbkDowTs9rvY1O/fojLd3clYHQPY+x+/6H7US45oU3okQb1h89hw2LcToIQdVLZjiJ35AfkQg+uha4UnxcyW4geaXW6djiTwDhfF5AAKmKUy0QuK8szoQG2TzMDOj2ZWVJ1A6UTR4W9vd3cifWtXLmQu8PyggQTE8eH0vtzPNi8Ch5OfrSrGBYE5ubtpjbHi0cDbfD9rXyZ/0zIdOca3nRyjkw6GluoPyg7ZbrnW7XbAxgzSHrSV4QYasSG8wjwLOg+U8JYOfCpFBq3T6nkuTbz08sG7//VblCztXUUmHuf4t0HlqaSkeLhOxm5N0o16U1KSbxf4jWGySg+ZAFnJEphedN+5isPJASE4CKQp59L8idn50uPwtQZc3H+plLMs/bxrGwP7RDor3go
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d92bfb9-e6a5-46e0-b43a-08dcfca75f76
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:04:57.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82sa+rSyBnNrJLGPG5xpvN98LGyYKWCZUpUh4O9F0zI42sWQpgJyBjLkyfp90cGjDpL5Aq0WXbCBGNUt+CQ2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707499-rYjyf8LOoc2a
X-MDID-O:
 eu1;ams;1730707499;rYjyf8LOoc2a;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Introduce neigh_for_each_in_bucket in neighbour.h, to help iterate over
the neighbour table more succinctly.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0402447854c7..69aaacd1419f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -277,6 +277,10 @@ static inline void *neighbour_priv(const struct neighbour *n)
 
 extern const struct nla_policy nda_policy[];
 
+#define neigh_for_each_in_bucket(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_for_each_in_bucket_safe(pos, tmp, head) \
+	hlist_for_each_entry_safe(pos, tmp, head, hash)
+
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
 	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
-- 
2.34.1


