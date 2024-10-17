Return-Path: <netdev+bounces-136423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F29A1B46
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5121F22986
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DC1C1AAC;
	Thu, 17 Oct 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="StUBxYCQ"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F51C1AD6
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148707; cv=fail; b=LzmAVZrNOi7d8hCU0nkOhQlvpttIJUysWcJyu6cvUbEj2NMGVRQSujWvgpNyVipbBG8yl8nIJxdWs7T50XtzR00RK1cY8mvYzynfAqU7WRQ7xt8dBHikCYIBdUPrQg66yPxLHivUoyUjFfuSJ1aQqJ9Kv61woBnWY2kSMRku7oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148707; c=relaxed/simple;
	bh=ob9evqrrXV1K2i5/wJcxzuC0+0fmPRPwHmKT5d92GQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9mEMQRrh/W92E6MJNpXR2isYGIdHhhi799fgI7GxYBaR+2XoPSDGMfNIknoNGj+IqlFioAeWyHpLYou15UN55LXE2kJ30uJIkk9n8f5snXHI4P1gLodUvBb4poNOV05fDAZpchJmz8NqSvxQD/kG9wNV4/JfJ9blYP3PM8toi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=StUBxYCQ; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7366320005A;
	Thu, 17 Oct 2024 07:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+Jj4A3zzfURBe4WxvvqzEGWvkcYGdQu3Xw1A9aI3VDN0y3zN/vCaiFinVFLaWImj5la+4F1VTeoVQ+IC8UYOg7ktOIpT9+ffwKpWSDSt7T11wDABvy5bH3NhntNH5qM8dQxIzisDWqAEsJsMEo7pO5+00cMTq1HaoIf57Gk54taV9x+5PZwLtgoVaJ+lE+uaxQ+bdWztiXfdT7dwWNyK8mfRy6nzzcwOpfMmVjWZP8SNli/Peqob3MlUXOP4S3N/WIAIuuc20gjA89vYE/djJfSj+mPn1Y6ff73JxMiHXK5lVS9bSQrH16EKADTF6HfZtDfyZ0VYo+yPZM0v0//8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae0dcIy+Pn3EjEsk3zsYExCoJ4S+szA+rXitOlvVQm8=;
 b=AXKxlAegejLXbHeBCTflX4YQFyBNNCW0paSuUm1jMl+jP3fhGx1v2wrDY3aCjP4rhW/rFA5huxMoIC72b3UjutwJuqMJ/8UVTcjw+nSa4S211a40JLx9zhpn6g7+YFRTwbWHnFRU6bDmzXtirw4fvDB4SbX37/tXOh6rBpN58bYc8QPbo2y+uc3l0asJsEHAq61xL83ZIXtee1dX8qdWUhEK8QYoJDGT+cM3W9w1dcBJYEbK42++dPV0tWHMGjp5LYiOLHLvgQyL5zcho3/A1qW+Eu4CcnPtUH7CGmfMRskvrz8J5objkNW1vpTlDN26MsN159K1sPJTLq9T0v3zyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae0dcIy+Pn3EjEsk3zsYExCoJ4S+szA+rXitOlvVQm8=;
 b=StUBxYCQLdRtyokNuaNRxaMiIve0haKXBdtsbAiQIuZ+YzLul3adnhQRib5eSpm/1hMtksfioe6sDU/r+lkzO/Fl9vpwjmsJSuI9osmQ/HAvE4KLVpMFZg9vbYr7fGl0a20pOvx6CS+owwWx3Pp7HlI5WHSXHD7p9N53szLIkRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:05:01 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:05:01 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next v5 4/6] Convert neighbour iteration to use hlist+macro
Date: Thu, 17 Oct 2024 07:04:39 +0000
Message-ID: <20241017070445.4013745-5-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017070445.4013745-1-gnaaman@drivenets.com>
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM0PR08MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: f527203a-6770-4384-ff6f-08dcee7a04c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBxTP5jl0wYX6IiiOW1fi3jcJHmjV7hFCd2pMgiUfXGuwBrj5xkRB2t3IwF/?=
 =?us-ascii?Q?PimKCqrkfdacLWmQ6NSvn1asiVHWRu/6XaKQGWohOtfhhIXXQwmT57anCg2B?=
 =?us-ascii?Q?aNpMnNnvqlCW6WDVQVAuvM8TCirgF6wdVQob5Af8VEXx527WFjy2wI9LinBY?=
 =?us-ascii?Q?0oP/ZwHH0fHUHEjw+22UxPdBgiWfNW+iJwChY7HTKoa96t+iWL+YXj3nZ6J5?=
 =?us-ascii?Q?AvHRc/Q75mxvIT/KP/mZVcW100PmQ/gcFwOpDveGHF2fUjFIwAW7k84yb5Wn?=
 =?us-ascii?Q?JD7VLn1sW0x8QTD1fvuuagkda9N1XRgUoHvEdkJAR3zt/1tBVyxrSK4kGsPr?=
 =?us-ascii?Q?2lvZbDV8qrgbXkjiYzvn7//jIx4iEvRhm9kwmSacPrKCu80m+a4g9HAbKG91?=
 =?us-ascii?Q?rIV7uRzQzA6+niSbfnjFwgBSXRrncmgFyf7sMqZnXDQVzrgbD2KhcR5HDiv/?=
 =?us-ascii?Q?ydV/aXTm31TS0uZulIhNEOgNpY2fxhCkU/9gYHwVihcyM7vdzLCnlE/vj7MY?=
 =?us-ascii?Q?ZMAKHJPwm5by7xybDqs95Wwfs7Y3UsiYI2ogmTr6bEWccisB7jslkEYMzN8/?=
 =?us-ascii?Q?hKf1ETbKAwwkagm4dLqBLv/Pb5oGZIkGJhHwYMJFp3mIvILTxfB3E1S1jqVa?=
 =?us-ascii?Q?quSMCe4mxjDtckzG/gtrgrGeQpPZZO+sOrgDxIWJ1IZV9BquavystY6AvZms?=
 =?us-ascii?Q?GHgp6uEs4fDNn4rGvXYrQ9bz6OkEg5kcfuhvKgTY6+Gmp2tYeTEbqjrmzN+S?=
 =?us-ascii?Q?AGsWpZZ8gOBwIR+9eEG5cPQTH/64ZWqokOUmocc12iasYT+LDskmSUZs3965?=
 =?us-ascii?Q?bmXBIEW3bQPlESIelMldHn8vyoLNOLKPpzoJauY1lorBeJbMeF3V12zgzWT3?=
 =?us-ascii?Q?kVYLk9nFlk+MSiX8FqV1DWLzmhxqjETRSc2l09mJ/JyT29Atf9utLNft1D8s?=
 =?us-ascii?Q?JE686xUzuGpcFFpdVNalaQTaLxnrpfi/EtiS5DgiA0sRu6OAmbO8ShEJf5UA?=
 =?us-ascii?Q?e6wFAxmr8AtDdTBeqUZiCjs5Mic+6UQzE/MhvNcZbPepKf9RhhYaPDJkFROo?=
 =?us-ascii?Q?oshZGs1jrFQRtAQ9n/jMCAPu+Z3hHwUKdTSdD/zCeYslq3ZE+C6/zQH9lW2o?=
 =?us-ascii?Q?BHDzHCcNufZ2vLjmmyECXv2RGHgNxIY69IStnmAAq7Kc5KJPvH+ogzeMTl90?=
 =?us-ascii?Q?QPrvZlrVmJ1aA0Vmf+brHzr++Emrs85nRkog6VltxKHe6QQ/mZPqlRwTR9v8?=
 =?us-ascii?Q?yXZiWKkddQFu9B0WzaBOjnoongkgyeolYLqoXed31H/8UlUs9kDimLjIxH7n?=
 =?us-ascii?Q?rBHFdPfMdYtuJvDY+Itryu+Xu5/bIapohAbx76IcOGWv//tLytgCNZiyH6+w?=
 =?us-ascii?Q?b1jUcVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QW+TWCj2rZEl+GAT7e5XVB3oL4HUT6XiayLkh/M7GNIMZ15c5CkkljolzcU?=
 =?us-ascii?Q?+IfDTbRz0GAGoi/RsDSXBIQtbWtyFoNK7a986uk+pPiZm2q4UzrtTlB23cr5?=
 =?us-ascii?Q?q3/v/8Xn4LwnF7lpb0Xey+4cO6zXyFhWdxoxSXhPUDIdrFi2SOU/DFzRGPnH?=
 =?us-ascii?Q?t/qx+x6PApTiYpqB/6/tzeQ8N5zmoGP4msmt90ZvX5DJbLfXNxGUJzL5eVph?=
 =?us-ascii?Q?e+45Xj84x7XmVnH9z/+1Tmu1ahMECV5bRP3R3Pg2vTsDdReO8IZa3ctU0mnu?=
 =?us-ascii?Q?Q0xSlW1/9qoWXsTCZaPyzZGgltzrO99n1KfZEhKBT79MJKLeRIKx7opb7Cve?=
 =?us-ascii?Q?1kjVgt/p7/ArVvhH1VjhwmqBpLcK8IevQksLwG/cqfCKpIhWUEq3bHIzf7ia?=
 =?us-ascii?Q?o3I6d4cwQucQ6T2IyCLCMn6aOaFucYbEC9bz86EeAAf2T3gjxAfVjGoZ1TaT?=
 =?us-ascii?Q?kq8/NbBs+5c2Lpe29niTGsbErgszDIeGmCmoHSIIsVeGVLGTOeRvia26Q1Mj?=
 =?us-ascii?Q?g+US2Nf86dg0NKq72eY27zoJ34gT0yb9t5My/eyWubFcJbDR8+IIEwTPA+d8?=
 =?us-ascii?Q?thV4koeUl/5fj6z26qr6U+F/feqD1PQUGd8IINnNBY1epoKMvQ44lz/uDeq+?=
 =?us-ascii?Q?T4MxIZHCnXw157eu9Ykh8APH7SvNBFn9dxfkl13fDKgg+/bt1RC2i/QVs6iF?=
 =?us-ascii?Q?syX31YF+ixi3/FvIEMBszu6Yp3fgdMLsa7JGrG6Jz3fnBSFKkjLzaob67L8I?=
 =?us-ascii?Q?sa36Nlc4mNe8SlN5a+fhUXrgy4TRZLsRdUDIDwRtFCZARozcgh3Sp82o3ejk?=
 =?us-ascii?Q?+BGe7j3WLSfBGfmiXzfzn3nCPOtnYfisJi6OfXNH8ngJPSA9Cl/aCa05/Gdb?=
 =?us-ascii?Q?YEIjC0qZ9cUssgBX8/9dQLnR9umrWJFhIQeJCstEGnEavMroK03rfUhKtFni?=
 =?us-ascii?Q?EP1+OjU839u+4wbS3miJMOcRvBDNU4lQVtHVxHrBfO84a+l3VL366kwcWshC?=
 =?us-ascii?Q?7kBbF7f+qi6SKrOFNvkEC2UZbHC7fWPDMSft2rOAhmkk0ZUmNUAprK/zHDHY?=
 =?us-ascii?Q?resbNUNoqjEEBcn8Js935yBB8YCF7nwsftKxor/TM6p5gEcHDz50w7UaEt7K?=
 =?us-ascii?Q?39aKw/qPQ7oLmJ/J5zSYKzAQJuyFCYor6AiBSNPTa5DPkBS8CN34gD0qsEVT?=
 =?us-ascii?Q?RCjgMDRNTYqN5jS+qE0lvVhr9ZdmzlbL4sfmEJMxW7S70vJxt43zDajIPl6B?=
 =?us-ascii?Q?ScrJv5J5xwDml2MIMUoEO7kHyo04F4bTIhKPBiXXED66YjO5bzxNxad/6Hlc?=
 =?us-ascii?Q?ZzYfAe15/32Z2tl45CiYT+SlIcVJcMNYo6CFzaEGY5fk8sSb6KA6BOOLt70P?=
 =?us-ascii?Q?2n+eo2FcFYXguTTka8WH99GqkCLQ5mcGoPSSMWxdXCpVBjms1ArMLTFC5nKr?=
 =?us-ascii?Q?Z/d0zEdbeBFtxQuwyJ1moQ7BANDslfONaKU5lwBY0KDNOYbbe6Gb0xDMWSQH?=
 =?us-ascii?Q?XV6LMiujUh8dpAHTxl9+9EUNYOyvmzdkNmAD2axx/oNSl03cyZpOsAWzvAii?=
 =?us-ascii?Q?ev1pCnwXUnGHCsj2ZpkHxdidit/JFdHFPBeAmxdz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p/WGA4V6ZriXKTLjDfb3C6dPkPtsAtTGKhta0qXU+L6x/qxZBC1VGIxI6UmKIAy4pvVVAu/T7YQXHkR/LIAGSKOvgvxCDV7es32kiuJOoAjU3tiXvX4LmEJKlD3MyzHlRwp9ouND7GO8rxv+uGwq7LaCGqn0Ar/s9kme3aG5XB/i6YxerAud63oOGeUr+9axE2R5hz2Z9FjOfqzhjRMNnEzwqy2+Ze3+J5PqAiciS5te1OpI747ZtqNhA7MgN/XktkMYfPgnRK24MXPEnBmnGIY+4AGcoijPSsl7FxBuvGCD4sfY5ln/L9HoWw3AwGmF3bsIjEwGa88AhXOpPQvJ9nWxEowq63mf0gWBLm9gul0b7hKF5hnI400wB8zPDG921ZHDBD5zp8NIqEa44Au8TP1KjHLk+pfCk52c7ZG7Dd7dQS5am6PUDVAd55fCWjS+6OefVUVqzxuMuMGX/sUjE8TCQX4ROZxxoELE5WJRsfbpSHf96NrC2dHolSQWu/VJRhnDM8IqECafZhFSpwD5mhctIW3/Ln5pgk/y8ap8S40nBzzp1Te6Z1EeVnGU7ApH3k2zU8tMyTLKHKy6+CAO6BTt4wXaIhEoCR9QKivvByLnWoTzG5pd+ZW1IRc66KUn
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f527203a-6770-4384-ff6f-08dcee7a04c4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:05:01.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgBsvnmJKHej9wBvd+9kUX8qX15T787Fcg7d+YUSBGmO1C97LW5bL2VSL+hv4y/xaRIMo25NpwUcfqytdKRNAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148703-w1N3UEng1keP
X-MDID-O:
 eu1;ams;1729148703;w1N3UEng1keP;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove all usage of the bare neighbour::next pointer,
replacing them with neighbour::hash and its for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  7 +++----
 net/core/neighbour.c    | 34 +++++++++++++---------------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 14f08a2e4f74..96528a6cd74b 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -278,6 +278,8 @@ static inline void *neighbour_priv(const struct neighbour *n)
 extern const struct nla_policy nda_policy[];
 
 #define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_for_each_safe(pos, tmp, head) \
+	hlist_for_each_entry_safe(pos, tmp, head, hash)
 #define neigh_first_entry(bucket) \
 	hlist_entry_safe((bucket)->first, struct neighbour, hash)
 
@@ -309,12 +311,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	neigh_for_each(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
-	}
 
 	return NULL;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e4e31d2ca2ea..a1dd419655a1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -391,8 +391,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 		struct neighbour *n;
 		struct neighbour __rcu **np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each(n, &nht->hash_heads[i]) {
 			if (dev && n->dev != dev) {
 				np = &n->next;
 				continue;
@@ -621,11 +620,9 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
 		struct neighbour *n, *next;
+		struct hlist_node *tmp;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
-		     n != NULL;
-		     n = next) {
+		neigh_for_each_safe(n, tmp, &old_nht->hash_heads[i]) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
@@ -726,11 +723,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each(n1, &nht->hash_heads[hash_val]) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -982,10 +975,11 @@ static void neigh_connect(struct neighbour *neigh)
 static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
-	struct neighbour *n;
+	struct neigh_hash_table *nht;
 	struct neighbour __rcu **np;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 	unsigned int i;
-	struct neigh_hash_table *nht;
 
 	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);
 
@@ -1012,8 +1006,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
 		np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -2763,9 +2756,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each(n, &nht->hash_heads[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3124,18 +3116,18 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
 {
-	int chain;
 	struct neigh_hash_table *nht;
+	int chain;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
+		struct hlist_node *tmp;
 		struct neighbour __rcu **np;
 
 		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
-- 
2.46.0


