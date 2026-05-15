Return-Path: <netdev+bounces-288439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG3aJmd4B2pL4QIAu9opvQ
	(envelope-from <netdev+bounces-288439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:47:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711255717B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5DD301A3A7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22282F7EF2;
	Fri, 15 May 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="iy251I0r"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06895384CF3;
	Fri, 15 May 2026 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874460; cv=fail; b=qNJJwmD3CzhuaMZF9GpxW9DQlUOvOjjOcO+5FyLCSloqprEDG0+Dg7u81Oh+FFZg6TWw3onzdeZ6z14y9NUqCQWFmR/Y+ZpfKPS2UM1y+BoXYUXmOhLpRFmOPsco/FSzzfwmvL+o5yQ1J7X7zuuNvK4ihtTxs4xtmnh2JKbaQGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874460; c=relaxed/simple;
	bh=4FQ5XbJNk6M9GoeGA1rDTYi3lqdh+p16GdD0D6KodMc=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=AG0HRLZibGMDD6DjWQAboS4z/iU9sW1nbHC/66fi1q4D74Z41RV5EcX8qFWHgABwazJs7qibLiaw1iSZ5Le2iRZKKQ2XLhEwQuv1BzydEy8yavMZGIO3Eb08NTNkmepjJCcvha+k2kIYSRfhS49CKSu/8Sy1uOLw6+vhmv3nndI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=iy251I0r; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces1;
  t=1778874450; x=1810410450;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=4FQ5XbJNk6M9GoeGA1rDTYi3lqdh+p16GdD0D6KodMc=;
  b=iy251I0r+jjk+gYXJUNBqz7nu0/YVHc6Ye40CHMHBd0+Vd4yPI1CiWlB
   tDz/PWjLdtxRT00zfYXPHc8qwRv+LkKNYFPpgVBpNgXY+OoxPTF8afotH
   a1AVuiAuvLwR6YAPydMOlKV2FNbX9WPbv6GflaH9bOBmO89qk7qDuJQvY
   Y=;
X-CSE-ConnectionGUID: Ui5wfQ1OTGm1jhaj+w5imQ==
X-CSE-MsgGUID: F2dEWvBOS8S/LsHRY7B8sw==
X-Talos-CUID: 9a23:ejOpq2+uocvDzLJgrp2Vv3MVR98rSyT68FjVek24AGQqV+CUTGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AZGNzhg7mEGGwpxrBSRqRM3/KxoxGuaiDN14ntq5?=
 =?us-ascii?q?WgI6gLgxKCmi33C+oF9o=3D?=
Received: from mail-canadacentralazon11020106.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([52.101.189.106])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozJKF7/3L916hqYmn+Wom/CE79cOHAK/wjU4k8lPyxV+AaKiz3Mz+81ACc8D2tjMMGRQOVZSQoFlnbR2d8Rf8uz28eRri1iECGofF1Bt+KPBh2w8uRU7Dvmh7gJEsOeQ0RfBIhHHKNNDXpWubxHXswLv2hw2NAOtSADBxq6WXra5Okgz7WxRg7W3t0mduU+P3nD7ZOq7pVQl9f+S5Xs9rX+gzvNrit6QtKO2gGKerCDIef3kc04IWkb56GH1CvvRendg/oW2NQDTiyaHoB6vzTGgKmPyFSyIoKGOVxynk2O2Vm9eyXM6XyBuTMmxZqiXpnJZdEAtHu4rg00R1yhG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOn1X0BTLgEXzx+lKn+M7MlWagj1+zHokYkLfLKVqPk=;
 b=XMG516tRmpsUJhKP0TIbMPh+KXKUjf+1Z6Eayhupmvc95KT8PT+DaLQ6QgRsX22mDHVBisDnSaKw1gmkZkZ5zM4Hdonu2UKyoQe7h0yOW/0ObMdTDkgXK1N4pWgLYrssRQwqw1bkXVyRqExWS9oL0lNvEl5VbrKXwXFu1afIvRGDrciF2FEHJamOrztfY+deZVAUWLCGMb/Kx2OXKoswqSdnQlshXj4NdliYr65l1yfn9rvX4zkXkvCA9djjS8pzuxDU4xkaCeBNc5etEv0W2lVX0AS3bzK8QDOcMm3HJ0KNd2J90psf4D9SVJAyFIHHFJTj6/pcgsNsAHnMM76ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB10275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 19:46:15 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa%6]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 19:46:15 +0000
Message-ID: <f0ecdde3-de16-47ba-b795-fe0042114e96@uwaterloo.ca>
Date: Fri, 15 May 2026 15:46:13 -0400
User-Agent: Mozilla Thunderbird
From: Martin Karsten <mkarsten@uwaterloo.ca>
Subject: [PATCH net-next v2] net: napi: Skip last poll when arming gro timer
 in busy poll
Content-Language: en-CA, de-DE
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 mkarsten@uwaterloo.ca, Dragos Tatulea <dtatulea@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::6) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 208e3429-45e0-4a1e-ffee-08deb2ba9fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|376014|7416014|1800799024|3023799003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	A+GDhAUQyzejILEifbQUSBSKrYYGyDEMbqFHW8U8usvDk43RxG8a/jbQ/MKiowUlcXyZgqgFiqtR60uZhQsdZntrkm6mV/IUS0JjDCgo44zkeK4K/Oev5FsPCF1wPzIm973sUWrctm9XadFnmpFdophqpcLf14/WWDMUqtO4BRku1VhVCap3/JZngW7RRWOJC4/HPIDy8JqzsWMnTSSko/g+YVGA1q5Cx8EOM8FuI231LDCNSLyhHA1H779ScqIcW4C9gQv8aJjKKnPbjNSGLvZHK8AuRNs4wQ7MOo5oU8ApOHF3issho5vyjUKRzOVixEihWnf1AqyHbNBKXuxhRF1aInf1d0bVc1mH88ecApkhEJFlEKCG71t7X9wsTlDvvJScXva6IIUyUm/tppKEKWX/xv6G21sbjd33NWTpaUup0nt9o8iflq7kaVOWUPoC7/urq4/K2jKntPIvVbdMMdDkgMb0lvbMJYuWtrcSrh6TaN1GGhivMRiE5ONDl5sbTNasYmxdIQBfaaxi9OhTPEt9+06qoXi6HwHm9HXigLPUUchO1IgGCfE8e/DFdmiBN0fzawXD7Q0CQ3i5oQJsSiV95fWsZMEexti3WP5mPbgF/7ruQWicK2VUieLJN54CcT5szvMa4F96TNLmqHD1kqntO6u/mdJn72Kc180dFzA6pmD1hJ51ehLUF+68Ujjz92Ui9anajMVxbdHkhsitjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(376014)(7416014)(1800799024)(3023799003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXRjVzVHZ2ZIcDkvZ2RwNGVjT3cxTHRaazE5cndOU1I4cEh6VWRLUWJVek52?=
 =?utf-8?B?ZE02ak0vL0wzRCszSlpWKzFmVE9POEdCR3l5T2g5eUVudUJvek42QVZEbTJ0?=
 =?utf-8?B?b1NiKzBMNGMvM0ZOWHl2bkREcllDaVdJOGpZNlBVZ0dZcTg2QzNZVUo0UHpX?=
 =?utf-8?B?UFNmNzd5d0U1YkhmM1o3cnNhQ2JvdVFKRFRhR0kyVHJFOWZiWVNINWYvSEI2?=
 =?utf-8?B?b0d0eXZOTGhLeTdNMkhvL3JuZVFtVHFmSGpmL2g4MUY0clRvUVpxVDRJeWQx?=
 =?utf-8?B?a2JsU2NLWGRFYzVHU0c3enNPT3lmWXdYdFdDaFovaS9aTWhueXVSb2tjM3RJ?=
 =?utf-8?B?Q1ZMd2pOZTd5R1VzdHpVWlBsZ2ZBdXUzRzhoRnZISk1yR3V0SldoSWxFZDh6?=
 =?utf-8?B?V3Vta1pyUmo4VU9hTlpWMjRob2dIcXlES2RHa0NqYVJ5YWZyQkhpK3daajdQ?=
 =?utf-8?B?N3p0aFg1ZHJGaHZhMFhZRUsydkdDNTVTUXJCSzdKRGNXZ1RYTGZmUzU5ejNV?=
 =?utf-8?B?a2Z1bUxjbjYzdFA4NVYzdWV1bkJoazhkN3R2TElkVzg2SXE3ZG9ZUkl3QUlZ?=
 =?utf-8?B?c2wxclZFNHlueDYwZjVVcjFPUUMwb3lJUTAvcUNSQ1ZwS2JCWk5BSWMxWXQw?=
 =?utf-8?B?a1crTE5PZEVBd0ErTWZ3SHNXQlJWTDNSREhvUjlIdzdmQXIrOEJOanltQ0Zt?=
 =?utf-8?B?QmhUdllxSC9iRTV5V2JxbVB3RUZaLzNJM0VyZ2NJcmx4VllhR2NERGxWb0Zo?=
 =?utf-8?B?V0lGK2RJaDUvd3FXZmVRb0lEdUQ2dE13bHRlSDhmbmxSdTBMNHhsdUhTWW1G?=
 =?utf-8?B?TnZiVk5MMWtvc2RxM3hrV3c2SE01eTBOb3o2U1hiQjNIaVVsVkQ5cXdoVXVS?=
 =?utf-8?B?eVlyWjM4QTVBNS9aeEtUVUpSbVd3MWhUKzBENllKOS8yY0ZKRGJ2ZWVvaDcx?=
 =?utf-8?B?ek5iSkJYUHl6RHFpZ0Nna3l4OTVUSi9SSERXc3lGQk44a01tTnlnMmg0cVM5?=
 =?utf-8?B?RFJQNU9aNDJ5NWhnQitpZm0wT2hRUjJMcmpJMXZQSkY4aHpEb3o3SzFiSWNO?=
 =?utf-8?B?OW0yQ1VlL0s1UHZ0ejBNY2pXcFcvaCt1OUFUY0xmdCt1ak0vUHRTNjlOS0Iv?=
 =?utf-8?B?bktkam9XTCtXR1BNVDVqQ1dYQks3S253RFVXdjVjNlVxVXdLalFqUUlCWFRB?=
 =?utf-8?B?Zk5kalEvZFVibENuNS9NOW54Vmd0U1Bsay9XQjFCWU5UbVI5WVBDdWF6Zkhz?=
 =?utf-8?B?TXJ4TXh3azFyekVvaEtkYnprYy82Q3QydTlRSWN1WVFZMmwrQ0FGUEg0RmJs?=
 =?utf-8?B?NGhaVFM1V0N5V09McnQ3aEs1dlFoSklJYlJyTDhSbEZiV3BNVXc4YitNL2g3?=
 =?utf-8?B?ckpQbGtDUFlEOFMwblR2ZEFFY3llMWo2dVl1Mk5kL1p1ZGRwakRTaHlUMlBk?=
 =?utf-8?B?dUdMcU9RZC9yODJoVndoQnZXZHFJUXRCZElQb3p1NWtwTmErcjJxYzRtK1pE?=
 =?utf-8?B?ekE5akY3dHRnTzdSOEdCbUk4dk9mRmVrWTVONlFkcDhZaEdhdVhZWlZOdkdI?=
 =?utf-8?B?S09jaXRtZ3M2bWpIbTVPR2JQYjR1OSs2VXZtY0g2Uy9hd0JMMEp4WkZRT3pJ?=
 =?utf-8?B?a0NodTJPQlRiRTNhOVVhOFBmdno1ZW5yTGZxQ3oxcVlCek5BL0tWbG8xckNM?=
 =?utf-8?B?bVFqWGNrYlZnYmVKY1pFQ2NhSU1jSnN2bW1XSkdFTGdLNFdMZm96ZEVzenZN?=
 =?utf-8?B?NVB6ZE9DaGhQOUlkNHI2MGYrSW04NWxjMHJkcVZVN1NOZndmUGJKb3VJOVV2?=
 =?utf-8?B?bEpaQmpnVXBTSFZSRGtEV3dMd3hFcW5ub1NiR2xlVkQ1b1p3TUlNTUIyZFF4?=
 =?utf-8?B?c0dqWnZZWGltZGU1L1lkd3A4bjBWQXJ5WGNwQ0VGc3Mvb25XMFRNWU1GWllz?=
 =?utf-8?B?SWVpT25Xa3Y4b2tCZCtHckErVm15NVlnbUdEVTBubkZHZXcrWERETHZkVTBy?=
 =?utf-8?B?RW1TUmtWbndsbHVMV2htSG9ydTdQRXpqajk5RTQvQkdWNGpJYmpsY1N3RTJH?=
 =?utf-8?B?QUdmWkdOb2VlZ3paengycjYrT1dFMEMrQ3FHOU96NVFtL25PQ0dKaEgzNDlX?=
 =?utf-8?B?WFN6K25iOFdkc0IrTjVyVzQ4NDlLTXl6MWl4d2FqMjlaYU9Nb0V0b0d5TXh4?=
 =?utf-8?B?M1VQOW1Fb3BRbUJ4dnJ2TWU5UXlTeHNFZW15cXFMakkxQkdtU3AyVjM4Q056?=
 =?utf-8?B?QzZkVGw1bGxwNTR3NmVhRjdTeHRtdWpMdUpuQVgxSHFtb2lZYkRiWE9tS0Ux?=
 =?utf-8?B?OUdFbGVzWjFKV3JPdjIvT21odm96anpLSWx1RVEwMC9ZcDFxU3Y3Zz09?=
X-Exchange-RoutingPolicyChecked:
	slYA59Q8Ywb7z9tycqhXkHWJTxTn8GxDG88CvkstBpEdzrhu90nlsKKepAvoPbvgwJcY5brZ0urtUcUQKCryey/EN1L4zyAtTXIVcDgcCD6SPg99OhFHfA1XoyCTJAQ8eS/KYaWmz19UW7/huwuMSVFktgQ6E2waIGfIVVrdb8q9dUyZEnPBtZJu7t1JxQfPlKlG3wk28SkwoK1dIMi1x8ynDiH4A6cFztApkqLKM3pt2kSQA32e5Mln36EhqAgRrjzJtcm4YHnTu7Yo7HFyJC2/2RZC4uehJd+HenAVZk3uxmn5xADaUIvw7VNxmPpG6fd/2acmRl9Ht3nb3NUmZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KEytp28B0fKiLKQFNo2ZNBrZ+3pZYpiGtJDfM8ULegCbXx10O0XA+H9VaM3mcZqnAwwXlA75mDIu8luSA0qBa2UHR9jeGqWmOhc9alGhuJ2og77UdK0SnkfjkI5Ux1BUR0Y9RzrLRvtVedSjN/bNOxSdycx5Ig9qCsxOtQLwx7R7gqqNhc4nOqNt702CpgouNyqA2yIRTRH8+NqnxaZG2U2/cs7B6mUoFYbmEjli7SghqGDMoGMVRskHgmAt8UvVTJp5UbSv9Mkc9P3C8GHfHwVH168ONVUK6rOlH79r+hg0884/A+sn1HKyiliM/NLjXSDrsQgCmgev/ATwG/5Cl+SQ86L15LDQwaaKVgFQn8DhYZlriT80FERGfMLNbSSpopUZI891tHHdAXp4CRdDeI679Q4qXkVJoY1ikqD5m6Qyyk4RMCyrK2QsUDAyc2Da0byOmn8ZqmBfv62I0jxWm7hBaGsy8fmN9MCZWEsI1KpaGrCkF2Vd8B80SPhuR1P5BXUIiAbpo4GtRNgiJhujCas9jD0QCx3iWB7w6f+YOfcSrIZtFsNx3ogVPQ7TiVTGOpN0Gxsei+5EqArHfgl6RMwKRe05FYH86WBf1SCjo3bylIW4oJXLSgSbL4jA70to
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 208e3429-45e0-4a1e-ffee-08deb2ba9fd3
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 19:46:14.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znElMAvsv2itBxONfOQJXvU/8x+nFZhJTLbjS+M/1tP0Anah0LICZ7/1FWb9T0+bhMWkNak0kA+5RN1O2sXndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10275
X-Rspamd-Queue-Id: 9711255717B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=ces1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288439-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uwaterloo.ca:email,uwaterloo.ca:mid,uwaterloo.ca:dkim]
X-Rspamd-Action: no action

Skip the extra call to napi->poll(), if the gro timer is armed at the
end of busy polling. This removes the need for having a separate
__busy_poll_stop() routine and its code is moved directly into the
relevant places in busy_poll_stop(). Remove obsolete comment about
ndo_busy_poll_stop().

This is a follow-up to commit 58e2330bd455 ("net: napi: Avoid gro timer
misfiring at end of busypoll"), which has deferred arming the gro timer
to the end of __busy_poll_stop() to eliminate a race condition between
a short timer and long poll that could leave the queue stuck with
interrupts disabled and no timer armed.

Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
Changes since RFC [1]:
- Sending only the cleanup/improvement patch to net-next.
- Expand commit message to summarize original issue.
- Streamline control flow.
- Improve comments.

[1] 
https://lore.kernel.org/all/20260428175134.1197036-4-dtatulea@nvidia.com/
---
  net/core/dev.c | 68 ++++++++++++++++++++++++--------------------------
  1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 267cf3854395..f9f705255498 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6862,22 +6862,6 @@ static void skb_defer_free_flush(void)
   #if defined(CONFIG_NET_RX_BUSY_POLL)
  -static void __busy_poll_stop(struct napi_struct *napi, unsigned long 
timeout)
-{
-	if (!timeout) {
-		gro_normal_list(&napi->gro);
-		__napi_schedule(napi);
-		return;
-	}
-
-	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush_normal(&napi->gro, HZ >= 1000);
-
-	clear_bit(NAPI_STATE_SCHED, &napi->state);
-	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
-		      HRTIMER_MODE_REL_PINNED);
-}
-
  enum {
  	NAPI_F_PREFER_BUSY_POLL	= 1,
  	NAPI_F_END_ON_RESCHED	= 2,
@@ -6893,8 +6877,8 @@ static void busy_poll_stop(struct napi_struct 
*napi, void *have_poll_lock,
  	/* Busy polling means there is a high chance device driver hard irq
  	 * could not grab NAPI_STATE_SCHED, and that NAPI_STATE_MISSED was
  	 * set in napi_schedule_prep().
-	 * Since we are about to call napi->poll() once more, we can safely
-	 * clear NAPI_STATE_MISSED.
+	 * Since we either call napi->poll() once more or start the timer,
+	 * we can safely clear NAPI_STATE_MISSED.
  	 *
  	 * Note: x86 could use a single "lock and ..." instruction
  	 * to perform these two clear_bit()
@@ -6907,27 +6891,41 @@ static void busy_poll_stop(struct napi_struct 
*napi, void *have_poll_lock,
   	if (flags & NAPI_F_PREFER_BUSY_POLL) {
  		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		if (napi->defer_hard_irqs_count) {
-			/* A short enough gro flush timeout and long enough
-			 * poll can result in timer firing too early.
-			 * Timer will be armed later if necessary.
-			 */
+		if (napi->defer_hard_irqs_count)
  			timeout = napi_get_gro_flush_timeout(napi);
+	}
+	if (timeout) {
+		/* Busy polling has completed. If NAPI_STATE_PREFER_BUSY_POLL
+		 * was pending from previous unsuccessful attempt, it can be
+		 * dropped now before releasing the poll lock.
+		 */
+		clear_bit(NAPI_STATE_PREFER_BUSY_POLL, &napi->state);
+		netpoll_poll_unlock(have_poll_lock);
+
+		/* Drain aged GRO packets before clearing SCHED since the NAPI
+		 * won't run again until after the timer fires. When HZ < 1000,
+		 * GRO age comparison is too coarse, so flush everything.
+		 */
+		gro_flush_normal(&napi->gro, HZ >= 1000);
+
+		clear_bit(NAPI_STATE_SCHED, &napi->state);
+		hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+			      HRTIMER_MODE_REL_PINNED);
+	} else {
+		/* All we really want here is to re-enable device interrupts. */
+		rc = napi->poll(napi, budget);
+		/* We can't gro_normal_list() here, because napi->poll() might
+		 * have rearmed the napi (napi_complete_done()) in which case
+		 * it could already be running on another CPU.
+		 */
+		trace_napi_poll(napi, rc, budget);
+		netpoll_poll_unlock(have_poll_lock);
+		if (rc == budget) {
+			gro_normal_list(&napi->gro);
+			__napi_schedule(napi);
  		}
  	}
  -	/* All we really want here is to re-enable device interrupts.
-	 * Ideally, a new ndo_busy_poll_stop() could avoid another round.
-	 */
-	rc = napi->poll(napi, budget);
-	/* We can't gro_normal_list() here, because napi->poll() might have
-	 * rearmed the napi (napi_complete_done()) in which case it could
-	 * already be running on another CPU.
-	 */
-	trace_napi_poll(napi, rc, budget);
-	netpoll_poll_unlock(have_poll_lock);
-	if (rc == budget)
-		__busy_poll_stop(napi, timeout);
  	bpf_net_ctx_clear(bpf_net_ctx);
  	local_bh_enable();
  }

base-commit: 822d4a8e390a08ccfaf2abb347ae670b230b196f
-- 
2.54.0


