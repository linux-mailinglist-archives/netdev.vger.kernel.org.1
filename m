Return-Path: <netdev+bounces-251759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCAuJSlLcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:42:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6077750851
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DFFB5E5167
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F23A63EF;
	Wed, 21 Jan 2026 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DUlqcFL7"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A33A1E73;
	Wed, 21 Jan 2026 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966524; cv=fail; b=OHG5SDJgeo9vcEaWzywuBd0KwixicN00ASloLlz9P/XLI1cBx3Aq4MdiBhB/+Zyx6gPi4tsWpVyVBAiHbVLYOG8fXA4XGSHAMKIC5wxwnzBO2LNr2O0rcR3ZMMbrXcV4ZnB7N0hiIajldnxnWNokjox2m3R+pnvm9QwHzs39WVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966524; c=relaxed/simple;
	bh=qwAPqiBgk2agDkRsWIKzPoCH1XwwALRjv08oHrCrqsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXApMQOJ4SMBF32DLa/ytEhQ/lnzaC6k04h5/sufcAFSOFyMojuZDG0fNSFiH7l9B69Zn7hiiNjsvD7tmhzr8ubdR10YWDP9hkfVUxIVOa0CoTKCt1uurF6h792UpZhP8CQb+Osr2/kC0GNWu1ECxWDtugCjpC8+AlHY9XARj7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DUlqcFL7; arc=fail smtp.client-ip=40.107.130.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDo0sZsb96PmALCxCI5e+qd0syYp6o0tL+h4E15z00rkLvgpYv+cRgUFro1ohLAmJC8ebzlufqZJ5xyd/vo2WKBWIaHrMLw3EZl0kwKrapp3ZutKxM3DmIDZdwM3ao52p713cbDKjrYZodSq4X9ro779B+APu1S1GcqKfZadBTA9arCXdoSnCC/Mmi3cnpLE+O/npPKSK/c6vGjSaaE2oABucRorBcaKx/iwL4c/7FkzCj3OjSkH7MIZGs7samAWmzaZQOmV7y2aJwqKn97/VKxxFOEs2FNYOgQ0IlEni3aDpIO/qYx0eAkDN2X5GuM2Tz3dlKQr383s0upuPVH4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf/7MiE9fcwL3xbvx1ZlnP6rIVzrxcyYWZE9Zq8EFmQ=;
 b=j9DPowo0AcDFZy9iMBSO/5gLoO950BDrAN3nZZEw1VOBaMic75nJt0NRH5P2gVE0BCfrQXgNXtP+dX4qhesfFQBJiPvz1ftHZlghIuCWG7S2qR/25+NAioQVs0WBRj9c19ezhbcgTF7SN8uc+52rRWYHbvuRAobR9Gi0Hw3QJzyBRwhfgL8utG3jAZov3aAbSqzsNpuR2UbpDmowiqSA5jG234Hpg0OvRkyBLNkPYRtziyi++hD4nfVGNFFYrsMU2Oea+TI6u1qbMWHbpW7JUkIDXq3zTWHtf+Rc4t/Y9fi5/xQhAHKLNbk0D0hJ11Mp7cWZ0AujY64dKXJNHIrcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf/7MiE9fcwL3xbvx1ZlnP6rIVzrxcyYWZE9Zq8EFmQ=;
 b=DUlqcFL7egjOc1td8MshjamFIBHsYKpJ7gsz6KEbRvEMkq2nr46Vf+ffUaI4Eb14KjtdRZb9pWbCGf/LoaTD8P1+IKFv5RDFxGZPt5brj3svcnuU3EP8uUBB9xb/GshW1XvcrSnXDH5wrJB7W3iOMdsI7WPCfpwI2HWPiJqdT1/nUQq0KpujB5mnmJQtpY8gGB9zlXB/UEOI6mlUmFEVQx9IqxodjFklGdwCnqQPWv2EXYVB2xPXu5uHDZ8ZDyFE8fho0oMNmVpv1fDMRJd6mzkJ+qDH80v3jCH8vWipChZCe8c9OqKhRB7LHRjMR05YOjwYQAbJUFYv4EbKC4JhaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:35:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:35:20 +0000
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
Subject: [PATCH v3 net-next 13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Wed, 21 Jan 2026 11:33:55 +0800
Message-Id: <20260121033357.3261464-14-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d75953a-284e-46f4-4b56-08de589e1a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sbALrsE8aPCd5Nn1ksO3ml+YGE+Z/rMoyUJrRi6/3P/kNGzN1q13w5oBxNv?=
 =?us-ascii?Q?1Lfpo8dSf35hT5MxEeqveRJFVxsKeP6IAPiSbpMOpb3LNIAmCoWIhj2xIsxE?=
 =?us-ascii?Q?buA+Gwi9U7FJVJy1BQM32p7SNHEWLgJ/9VF2QqqIkp6CRerFPdih+BHkaF4n?=
 =?us-ascii?Q?gZx9W0A8lMBSevG1ADpNCGtkfLJsUu7EVLTuYbI59ZpM7WT2BR8GnDindcNo?=
 =?us-ascii?Q?Po0CDWOHU3ybk37HObVit1ZO8ROMQ/h3sIYjDJxsKgpVnY8z+l3+tkRSIQq3?=
 =?us-ascii?Q?eAb1SqcRzUa0+8ImN5MGfiVhFON0pLTVZJNJuLSm62RNp17DfSKTVEzNH4NQ?=
 =?us-ascii?Q?scfkPzc/aFcURz971irKh5sf1FklLyeTptPS2lAdCBWjljoJDV7QNz+RWT/w?=
 =?us-ascii?Q?aPVmrrcuzLjRZ+JL4UvDIVyuIdSJATYAFnsPNIylzKGQWWIQtgaaExBuBpiw?=
 =?us-ascii?Q?qqXGxCNuqX38Qp6cpuAdgClVCogY0KwcqCvYt3xaJbthSWL5fJwKW6207/xt?=
 =?us-ascii?Q?MHwPdieMDcIOqu/NUjfj9lfJ9m8ze8I7TrXJ1x825jxlAH7GSnnjOn/i0K/O?=
 =?us-ascii?Q?Z1YqjfKt+6hOiCZtbYWrfzppYIA9SDczL+9iDnALlQqsUuZ0z3V6lhJ+wTeg?=
 =?us-ascii?Q?SPp3nowrtym3D17JwqLIH7Pxys46YcZ2CIop+4kXbRV0bwR4wQlAI0qItjlw?=
 =?us-ascii?Q?5ntnTCi/5xEjIArq5Nlug8cCVKz77fMey8EvDCFGHkCrCyA4kAVxR5pRvIRx?=
 =?us-ascii?Q?dsIa6f93v4fhjLIK3fPXTGGesRpSLdIhGpEouCVFRHPydVsG1Y5KXW0xbs1m?=
 =?us-ascii?Q?8d4VrXJ3GksVRnKTIxn0x1bMN0qzlpPG+RkFFrWRszJO3F7yO2THxXHPmJqf?=
 =?us-ascii?Q?LiKUlUHocygCGyWvYHe1lvEJbgXr52xZWsWOaceNuGm4x8T7Hev0I2MT7QWX?=
 =?us-ascii?Q?b+QYZTPxdwgOfGgDgAr2+5izNMYTbxrjWyXgwFiQycCJy7rmJOYseQEj94xr?=
 =?us-ascii?Q?oirGfHv6zmnDfulsKu1QYHL0T0j30de9DUlelTWj+lkljWFkxu9Rn1BsfXLo?=
 =?us-ascii?Q?LxZBoEFuHD8F9NWQS2BgBOx3VatqBgoBrhXIUXVnKJdltx/1xJ7gj10xegIK?=
 =?us-ascii?Q?JMOpC7RNAiw85XKBWc2W6DyBf81uzO4ZnwV/XIj1JVM1ZTTBfhLiyeVL/SpI?=
 =?us-ascii?Q?SwUht4cdQ8hgz9WoIVp95hnBnKY4tJjbeGB22X2vTRTj33nnP2rb2nKkjmaw?=
 =?us-ascii?Q?uyPFz7hS4UhVISgslTlt++WPmpPaMAfBkj9ZJNvPReatfZ39IbpzxFBb9+l6?=
 =?us-ascii?Q?Dz+YwKaB3byt1aKtlTIBmTg2oLstgo1kDMquhju/C01KSoJEUU3AnWM60Trk?=
 =?us-ascii?Q?AzcTs+wQMnNOGPuFBLLdHk6XrKtwyuL5ELK/rICLYwhkk/lipToPXQpw8fz5?=
 =?us-ascii?Q?+j3c32sTwsZntD7MVLVEetvAmD+1z3pc7H7c8Ucentz9qMZNr8F/dNKqbLQG?=
 =?us-ascii?Q?UqFkPebU05dv6MHuGqjb29x38x3cyHi/jbDW+J3Ox9lOGECvUOysWliGoXEa?=
 =?us-ascii?Q?C8217I8vQtSa+LRb8iU8Lo7cN0bLI1EhMDeu/fUlpChsOSG0uf1ttOLYZ1VY?=
 =?us-ascii?Q?2/ULvriC4l7nGIKePskmdy4v1FHwQmMI6b7xkY27RJ1H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4WeA5sXbdxH4coYezlcWuUQY9PZcCLmqGF5xgxtrIYBTDEZ0zSG77/FIhyOn?=
 =?us-ascii?Q?VLLHj7KgsqBYs/PK5jE3G13UzsvH3mOqSwB4DyGH89lv55VYd5ihZDUBrZSd?=
 =?us-ascii?Q?Q9/ykyVc4UdCSh+wWa91WKDGeyQzLPj4SnDWtWjSZ44eQYQJR2IuGzey6Oqr?=
 =?us-ascii?Q?1QzxPv9ppeYe4CkdAdhpVKhK22SNZjDstO50BErrGnFP/hek9Oc05NnWr74p?=
 =?us-ascii?Q?acmQKAI66F2LGz1dqaL3uKrACQz5FEN5S4Y7p97MnB9n9QN17dc78IxLTymM?=
 =?us-ascii?Q?D4V2MxvVhJ24Gj4II358U5dLtuIKVwV8HDGSjvBiOCte/3/3zMf3bZVMCyVn?=
 =?us-ascii?Q?mJ56t8ub9Ct8LU5tmxpbZzMMDXRkokhqQmLVDTGyXDpV2S15UB/IKIfOTgeW?=
 =?us-ascii?Q?CUQxIDCzZQos+dl6DDBsNXNO3n7R6xg9qyA+gDkTZJgEupMySqwBN4+Y9k9E?=
 =?us-ascii?Q?K+HpFSh4k62JY1axrsli4sH18+niePL6KOfiIZb7+SWAL9QQzxq+ngHJp70z?=
 =?us-ascii?Q?yRaMuIn4t9TjIahU0k32eozilw0iJM03Hg88rcB7aFQ+7kWG+mUgp1HIa811?=
 =?us-ascii?Q?rVV4QB31+qFKUWcpJt95SNPTsQ639zA4mj07rmymWiJmZGB0G8jSG8bb+AMX?=
 =?us-ascii?Q?Z9g0zL0fsvxPQATDS0jnh9flhVQYt8V2gcfT5vGPM4JgffNBBBkXrUvPXsgH?=
 =?us-ascii?Q?LI6hrhuMUZrgRSC5fhpjzbJWJUCBbj7N+HyU4MvxxZOWDG3b6TL7JBcgfn5P?=
 =?us-ascii?Q?so3qbaT00vKqY0RYtxZAShseAF+RlVk9NOOuo0Si6L8WAmDw61bc/7BsiJlM?=
 =?us-ascii?Q?sZH3eCxV2Rbi4ZTtfQaeOhi7hBW1TcKvMAgV/LL5UD1FtgGDhI44gXcaGHIV?=
 =?us-ascii?Q?+ITo5zCF9I1Tke9eN1xKqA1zJqe92bTsW9FpztJdU5xAL0gFI0ZK1oixf/QM?=
 =?us-ascii?Q?nGfzTHlVrh11yOikhzyFUQa/NFUv64w2nUjTQhJSKhntEpI0dW87B4TjQa41?=
 =?us-ascii?Q?epOzaCLP/NvvhTGf2/E4RwxM0ZrgJ1tvBkjL/Ec8DrRLtgBbUiy9hQ1I9xGG?=
 =?us-ascii?Q?ZxgxFp/oHo5UBXpShWhKgBYeq61DNEL/Ab0i5jMengH9gJWPwNYop56RTuU6?=
 =?us-ascii?Q?AjV8UKmMMFzPjFy4k8CkFPqcr3M9/1CqLfST0vKCenT0NIxovqQ5acFGeALD?=
 =?us-ascii?Q?3ELRufZ2qSbNgV4a8+4w3x9ZRVpzHCQj1yFBlEmKs2/H61CS7fkeMIUC3x2L?=
 =?us-ascii?Q?xbkHNbJng9rZCtmilr3NAP3JMrG1EUuF7Zu5we1ckvIxeJ81UVtvMpwUqydS?=
 =?us-ascii?Q?gcSuVsvPE12Ma0oB6Teu4rZ6IcM7ZSxg1d2G2GiM4zdZKECbrOZRhh3NGYbk?=
 =?us-ascii?Q?SogABsylD5oE3F1cfc7prnyGAZIUqmtHmTruYEO5Do2SZrwOr5eZ9416RFMq?=
 =?us-ascii?Q?IvMBHoomFaGXnA2SH4sJkPI3wE9rIqsU4eJTVuZsc0dTal+CXReT7Ib+njW8?=
 =?us-ascii?Q?0WBX+LaFKXFT0tDLaCSalTsgwGQfnR1NPWU1Se8bxJ0onys11mXScKlfH6Nx?=
 =?us-ascii?Q?Se/QdI7xMpBvEn3tk/h2u3ms0+GmxCTPQp6v4PJJM4PwaAQtjbiOcU5DiO4f?=
 =?us-ascii?Q?V/x6WwddQ2RzcIu9nvATxPEra9/XMlI8LDTygOFYx0bMqztMrTpoxBUJ8nE7?=
 =?us-ascii?Q?iuWDtxX3iixr5d8upu4UX+iFNQAKxxYltkQ7C8kAVBkkLdyW6D6DTsf8lWFK?=
 =?us-ascii?Q?lOjiQSAeWg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d75953a-284e-46f4-4b56-08de589e1a58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:35:20.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83a6IDDxFkbXdr3dT7oHGehS/9NsFmvAM6nSs6w1b1yhNkROobzj6wiGMEhueNnk7XE+vJQR6AIuBLHe/nX4EA==
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
	TAGGED_FROM(0.00)[bounces-251759-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 6077750851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the buffers of RX queue are allocated from the page pool. In
the subsequent patches to support XDP zero copy, the RX buffers will be
allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
from fec_enet_alloc_rxq_buffers() and we will add another helper to
allocate RX buffers from UMEM for the XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 78 ++++++++++++++++-------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 44a3a6d1ded1..79ab45ed6fa1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3435,6 +3435,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 	}
 }
 
+static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
+{
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		struct page *page = rxq->rx_buf[i];
+
+		if (!page)
+			continue;
+
+		page_pool_put_full_page(rxq->page_pool, page, false);
+		rxq->rx_buf[i] = NULL;
+	}
+
+	page_pool_destroy(rxq->page_pool);
+	rxq->page_pool = NULL;
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3448,16 +3466,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		rxq = fep->rx_queue[q];
 
 		fec_xdp_rxq_info_unreg(rxq);
-
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
-						false);
+		fec_free_rxq_buffers(rxq);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-
-		page_pool_destroy(rxq->page_pool);
-		rxq->page_pool = NULL;
 	}
 
 	for (q = 0; q < fep->num_tx_queues; q++) {
@@ -3556,22 +3568,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	return ret;
 }
 
-static int
-fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp = rxq->bd.base;
 	dma_addr_t phys_addr;
-	struct bufdesc	*bdp;
 	struct page *page;
 	int i, err;
 
-	rxq = fep->rx_queue[queue];
-	bdp = rxq->bd.base;
-
 	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
-		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
+		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
+			   __func__, rxq->bd.qid, err);
 		return err;
 	}
 
@@ -3590,8 +3598,10 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
-			goto err_alloc;
+		if (!page) {
+			err = -ENOMEM;
+			goto free_rx_buffers;
+		}
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
@@ -3601,6 +3611,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
 			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
 		}
 
@@ -3611,15 +3622,34 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 
-	err = fec_xdp_rxq_info_reg(fep, rxq);
+	return 0;
+
+free_rx_buffers:
+	fec_free_rxq_buffers(rxq);
+
+	return err;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	rxq = fep->rx_queue[queue];
+	err = fec_alloc_rxq_buffers_pp(fep, rxq);
 	if (err)
-		goto err_alloc;
+		return err;
 
-	return 0;
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err) {
+		fec_free_rxq_buffers(rxq);
 
- err_alloc:
-	fec_enet_free_buffers(ndev);
-	return -ENOMEM;
+		return err;
+	}
+
+	return 0;
 }
 
 static int
-- 
2.34.1


