Return-Path: <netdev+bounces-132112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAE990727
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48041F21666
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844C4481CE;
	Fri,  4 Oct 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="obdY3XcO"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF41D9A4C
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054394; cv=fail; b=ASb0SAji3yobZIkzTQf8ZcR9BXNhxRLbjRwmMEaH9hEdDRoxVPWaFcWEN8olxweL1pY0/Mk4Cz6w0rZjtpQTJhmw2l99MV7JlT3WB7TsjSf/vZsVtgnhm9AsVOm+GaMP99rZ7ISeBVA879pzKZ2ymY3YuXQ/JgOs/fp7wIc6QY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054394; c=relaxed/simple;
	bh=5N7FpsQaTO44F17uH2vOvCTYK4rS64N99hZPB0bmw5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrm8G+gYnABKQ9LVDFI6GiZr9z6zzNdgh61YGBwOC2NDNGtJhD6+SF5oXKO+51Xo2SXbYZzywTbcQg8XuIhE5rr/cu3yRQfxQKzpI4sD+5E26acerSF8IEPzHssf8KSWBTYw70Swafqt0r1rVAO17EwpTcecXeMWo74bPR2pxTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=obdY3XcO; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B981824299A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:06:24 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AB5A1740074;
	Fri,  4 Oct 2024 15:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boNfR3+CVTXT3d0Ib2bUZwheDArkon536V1WQrXM2Sw0x352ZMmENN5TgtVItVC602hTxZ/p7bPO2RbNO/+Zbuk45YuhU21lHXV/395+BHpghT9M+f8VGIfGH1Bt98PqSXRRf1OSzNOvI30n8QuVcLwvalsG9TPouPah5U0yD7zocSTO8HIEeXpdtC17WX4pKxoxdM1Ic0z5onVMJpEL+BayTcvQoIOFZ50PMFIe/ljprgHihLDvjGCnZg63T7bbDIjoCnxO2VaDiOsoc2EkcTklGPcQ0O/dghDOXT5Z8VxdFTwx26dyOrnpagoSg3XT3+B6HDxiY3XavwIc8gdpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=815asTomQ9/WnrWjWk4lBBWNq0+zaqEi7zJrAFNU2Qs=;
 b=AfM6qDiu7POjd1pK1fRVZLG8BbyYt1CZBIQwUNx7fUS3AEB4664n55zHg6JwnGQC3kKHzCPEzKoCOR8AyQK9nWpLdY5Fu8wEMyDaWmLvUZJJdebZ/LhdjstfNpPmclB7pX9iVMyBNNQomP4ax6FPUdUBIoWpJNq4QBNHjlcN5x0TheqQu1eTdltRfIvB/BcrKDkANOXmlfQKQIP3V3wj35wLJV0VWmUrg13IDIWwcsTRM5+jNwngbU0Pe46e+MH21WcGG/8NKQkaJ7xPGShpWQuPi3S3s5S7kfiEWP8sAEj+x8q4ypcU1gejhh/rJvF6dWDTaQHnPiAG99WgRYvC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=815asTomQ9/WnrWjWk4lBBWNq0+zaqEi7zJrAFNU2Qs=;
 b=obdY3XcO928z8m4s/chZI6VLm0l9sIOVcs9+WCqeQhfxdZEDbyvQ+e7VZRFW8jfGUCkUZr/NWLqOMmsIVgWqPIidZohbUEatSL+KO3wEz2cLk/Jp3uR8sw5J50IQ0WvYIzSTkGwDPuFP+QJjFgRNgk9z8WBeciIbB6ENlZW4kxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB7790.eurprd08.prod.outlook.com (2603:10a6:20b:527::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:06:14 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:06:14 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 1/2] Convert neighbour-table to use hlist
Date: Fri,  4 Oct 2024 15:06:06 +0000
Message-ID: <20241004150606.3968051-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241003112317.GK1310185@kernel.org>
References: <20241003112317.GK1310185@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::20) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b20edc-f7fa-411d-4963-08dce486172c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z/qVmBy2/sozocCdxG/nb4rJLHeCexYvy0Rd0CCv9iC/OwBbW3UUH/jr6Fv8?=
 =?us-ascii?Q?pJB8zvR9TTJa4L9063ZjVMj0gzSdgjSUZoqcd7PsjE5NSjm2OLEQts+VLqxs?=
 =?us-ascii?Q?UYyTtMUP4jx0s5F37T6OBdIyhzzCB0sT2JjVpLGkNcZeGjvwVVhO+mfsOB6l?=
 =?us-ascii?Q?44iiIM5s1HwXqANVXhnXotsnqzYM/9JTdcep7qL8xo58xuOas3iop3fUH0ah?=
 =?us-ascii?Q?W9qv+Uuh5lAlSixh6Ib6qyYnb7qyrRIcdK8W1O59o9qV0IdKdSVjgM40u3th?=
 =?us-ascii?Q?MWvolT5z4E3NZcQ47i2QdSFKtNmcEZHBl3AEVpYfzkPKFWXGZoODJv+nsK6x?=
 =?us-ascii?Q?0xYYPQrDXc4jUKzR1ZMCcBoX40Q0NMYGzNeGeBdr+qu6sVnk9fDurDY9+POQ?=
 =?us-ascii?Q?xsFo18MbKtwowrB83rinF2qEUwetMDj7jM08/gVd5AxNJgsQ/sXkyQQlCMli?=
 =?us-ascii?Q?nro4jb+71LPmH1Fj+bQCWJRNUqo283EznslonLFFYHzN4BXxRJyl+zcZ3UIs?=
 =?us-ascii?Q?rww/H1o/Bkv0ycxaoBz+oHpAINIP/OqRQ1IWmkNFsOWFRYa9dJ6X42+ECK6f?=
 =?us-ascii?Q?jMFh+osPWCC8G473Jd1BA7Vbw5p9Netts1zU1aAZxY/tjM0ke2TJPv6wlxBf?=
 =?us-ascii?Q?nJ37r9ZArtzbgvboR1ns9Ouo830mEadQtaP2UPx5bY4Pn0z+zyBhLsEzGnZJ?=
 =?us-ascii?Q?uDrwyBaxtmLx7zvxOH4rjms8Xrgoj1krv2Q1KZozFbfQ/SpoQLRaan3gVGee?=
 =?us-ascii?Q?OcesJRaAdRM9fcvjpNhFJlgAoTP6LRb5f2VksDXYRU1+93j7xDJDuYjXaBXz?=
 =?us-ascii?Q?LpXkBw6t7CT+EZir6+neU9Fln0W+Wdp3vCz4EjluJ1Um38JTrLh5r/P9Ptmq?=
 =?us-ascii?Q?XohcOurL/jeCt4lHy6NlaLsUQ4NLV7SQtiHSEox035AXtth7I0Fg1PjWOhgZ?=
 =?us-ascii?Q?iCGfGoHHD5C2sk41emLxhHw4XWO6DmFg4FQXDBKi/5RgwtBRCKPjrKLgtHnr?=
 =?us-ascii?Q?H5rXRiypxZOpmEiwRkQ2WVHw4JF/2M81v0JQx+dY2eRsqf6sKHI7kK7RxDiu?=
 =?us-ascii?Q?84xARKe/MKLph18vYEK4nQExQMY6/eJMG8mfZQ2JHEmahrgOk7ddN+dlHQae?=
 =?us-ascii?Q?HUFer1dZG0JbLF9B9xCVYctXjs5m5KRtBxnWP6LaB/2kwZDk6Nk30teGfaQ/?=
 =?us-ascii?Q?j5iKYGh0JCZL5IpKdGVdxSLSuYXXG6IVZmYF0nfsvpo2mP7l+l6LTlqiKRh/?=
 =?us-ascii?Q?PTS+HWr7I3/mJAr3r/M4lERUCPN5xXFug9ZNNm7Czv1zlSrGpeM/vr9J8n10?=
 =?us-ascii?Q?1LcPmcHcJKtj730jWv++DjpLLKuphIncJFAWt8gDCUCWUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcR+tzDwCF58PoIYeTanzy7CbkvwJNNKAvmz7J4G50HYGPseV+TqqLullZ1a?=
 =?us-ascii?Q?cYhlWCfh1YuvZlsMp7c1rJHC6z+6OtuescFJn8xzu/G1SzCbmFtlH+A5vduJ?=
 =?us-ascii?Q?UAnlrfRL+IkpF5A0XVynbid87xAbIJdK5Ek1CsP3UpyXMAtYisJ/zlLDC+WM?=
 =?us-ascii?Q?o1zmrMGDScgp5M+QQotgyFpi1M6gC4sMp6xmXJAPM7naykwS3QS+rLoVqRRh?=
 =?us-ascii?Q?R3IQkRxUJETZ9whSdPQRTpY4GeALVbnncjR6bRcjbAa2QSCA60ua1qB4jeN6?=
 =?us-ascii?Q?4LD9HfbItPYKpbg+h/JvFkY1YGmslN58hHJJup+OKdkNXuqcfwFsP0pbnZ5A?=
 =?us-ascii?Q?Zp7K2t5N+sRqcQXm62JALfdTmDVJTnua+t8DdDxURhzonuBqyeGgh7XnZnEh?=
 =?us-ascii?Q?24O+SqYMiS4smt5/SpRHs+7pBphl8drEkJXhrkIxWCmLRYC3r0ugJY+p9ljM?=
 =?us-ascii?Q?dIT/3Fh8qtJDJ/Hk4YN9eTofosYICtj39zyXjOGwIcmCc1Isi/c7/72AB8Jy?=
 =?us-ascii?Q?1qw6pi1Y2EJzr4E8JSD9USMoS7URfFygXEDuauhn5A03lGR8vI8Q9EDrftVJ?=
 =?us-ascii?Q?Av3zZcP7kwOyF6Y2e2KvOqLuJSOJa/799OK2rJ8rw/J2TGykz7+92LIkfIH6?=
 =?us-ascii?Q?JpRCSqxUs7qYX1p+l7E+CwIZtlVHCfQa6FrdqAjmX4hbUjZ/UE7K01asu1y7?=
 =?us-ascii?Q?U+tHGLOpKKAr2JiTe3vJmMyaPru0Vdvk99HjRhibOPN+J2p2XUoL8R5H8r2G?=
 =?us-ascii?Q?V0uB+gyBOcEuwHGQ/21Xztu73I9QJYctB1tugHSR4sfTNTM7bIOW3Z+hXW41?=
 =?us-ascii?Q?SFCygOJRPjLQyLq3DFOH/d6tF1rnvnbrQOhJPn9d7RJ+FLW9tKuYWaz02b1g?=
 =?us-ascii?Q?7s+OTKkPBKb4dyTksnzptvmP3qTehUmE5kOUw7XANJAcfEw2taVApN81HqhK?=
 =?us-ascii?Q?+rvSB3zb/AJOZMov6944leEuV7m7nOMgunOR3RhI5AJFAoEEsTAn20cZtciL?=
 =?us-ascii?Q?GqLlMUh87sAgQOS2eOeMDHChG7jMaKgCjmoU/BASeUDdc0ajWXOjfWw6oRig?=
 =?us-ascii?Q?E+30Sxuc+1BVGVGabaVsST4WDN4OUFwcce9V7dPq1Aazekw4Xz9EVoWoWHBs?=
 =?us-ascii?Q?/FMBl0YBK7DAjqdFe5W9JuQ1ChdoXjIhfeGgvNRGr+f83WQ+1UdfGOKKLMao?=
 =?us-ascii?Q?taf4EXlp0JkIfOWtNaxw7huser2IBIqZN2PFQe+g30ysweeEtIehTKJeAX8L?=
 =?us-ascii?Q?hU1C8Nb+LwqxH+UYnNkYZ0MLVcAZ/ZEhlN86kGi48O906vhNCn7pdqduAIVw?=
 =?us-ascii?Q?92UqK5Fu7SiJyi5oDqh3+RArsGtXRgDtGi5/n3PCJovi8ybwNGhqdIHmxN9x?=
 =?us-ascii?Q?KdvnuVj8ui31Cj15s+ftXjcmzblmnQwBoHRh1bNFCMfFyxLsC+S304BHJfYU?=
 =?us-ascii?Q?0PwSNJsKgTZEnIfB+ulxFbfBu0Bx9VWIbqG2yFUEPWT/RKkj2dNEnKLVBLbg?=
 =?us-ascii?Q?3X/tnv2BbEmGJ8qKpig6xbEEh5AtksWzNTSUk3DyXQ/RiexCzqGKpaPjnRac?=
 =?us-ascii?Q?Yi7O4Qu/rxX9Svv0ypFvEjVzJFvSK1JbY5EhDBpklZYr1gsb+PFiWLex3t8I?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aPPU6pBtvUUTzUW6BHVjaq6Sq44rTAAos41D5rtVR3K4T7yGrVp9LXYmxLhGz82rYwSZ6IhUDuzYfGDdpgs/9SfNb5t8oKlhO8nzVwwGrpukNQsjDsAye/PddTRh8IF0brqB9FBnz9R7l6Zn0ZM8T2FnYPz8b8i7GI/OscDNb8UigO/PMEEXBkC30buVCe0K46UDTiAoNm+CkKJkuqbySHhtT/VvFm9GLLQoJgVwWCfaLNYVmt+9m6OnAieO2NLtRiODz3Gc+q3d/H4K4qmbaEAhQihMxe8pLlS9XyVW8eAOlxZk9nEkfnJe7GBEF8/NUzxHMW3jAo/gWKSg2spc8327heHCPRNUb1wyvzv8z/lL6B45jeOAhjbnSEnkiGhRYn7Pgy4C5/5PQdTnBEauH8YZURF+49nVcnWSJjsQpEIAAbtOzX+2xQ6xi7cVGl/pzyAs7Z2u/27pGf2X3XUKrlJwrlXWIp5VG8xff8wwb4bIIKr642WFYQ9BtgiPcx9tTFSDQwKAgLMbNOJzVdotGur9ifrXbjT9v814hXnDCTlmSkzaN3bfsl74uGUOui8+MQCNx6bMmgsKmXgobSwvfpn6hBJ7aO+LW+Hv4vu1lgWOp+9Xsq++QJbPLU3s30b6
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b20edc-f7fa-411d-4963-08dce486172c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:06:14.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmPxFJGAKCSCrHBKx4q//+c/E4AD4DSdmdRmWjG3DbP9cBbyzgkHyTkianA5MvWLLbwmkHs94oyBw95O9vDXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7790
X-MDID: 1728054377-8tm41pnPf2dX
X-MDID-O:
 eu1;fra;1728054377;8tm41pnPf2dX;<gnaaman@drivenets.com>;05cc6bc3819eff5d3849ae111b806195
X-PPE-TRUSTED: V=1;DIR=OUT;

Hey Simon,

Thank you for the notes, I'll make sure that Sparse is happy.

For some reason I can't get it to accept `hlist_for_each_entry_rcu`,
complaining that the cast removes `__rcu`, (even if I add `__rcu` to the
`pos` variable definition):


 > static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 > 			    struct netlink_callback *cb,
 > 			    struct neigh_dump_filter *filter)
 > {
 > 	struct net *net = sock_net(skb->sk);
 > 	struct neighbour __rcu *n;

<snip>

Line 2752:
 > 		hlist_for_each_entry_rcu(n, &nht->hash_buckets[h], list) {

Sparse output:
 > net/core/neighbour.c:2752:17: sparse: warning: cast removes address space '__rcu' of expression

Do you know if this is solveable without reverting to the previous style
of iteration?

Thank you

