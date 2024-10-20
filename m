Return-Path: <netdev+bounces-137258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B373D9A52FB
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A0282E35
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356D17BA9;
	Sun, 20 Oct 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="NTcK2wVB"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0EDDBE
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729408608; cv=fail; b=ZnzNG3BuPbn1D5rAd/xeBvXxFfUxuo1McN5Ueyb94umTYokbvY1OMcaFIWn5NQV73h5dy/wO5I0Cbg6AjKu+OyIWQIpQgBhoZvPHx+0OcwNdP55dP3sFmEHJZQRq+hA7a3tli6cHFXLH8AMkHZglAnrQ5TvMbi0NoOLKL0LeKIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729408608; c=relaxed/simple;
	bh=FU/5zGxyFYd2XuFFotIFU/hLiowkF3j/r71NrNNu5c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DhqP39Qrbm20JGHRx0DsKfNHmIaKniutgt6Wk/Xge7jEJiWCDEeRyUPEiWLdVs4b4v8rOleBAvPzbuEBGU4M25GLBeGi5CyjCf9wlPH1slsMv4JM+7MrDVnKEBUBJgOhgG57moNj4FDTWOdu7p3SBU4sNUiaUyX7Fqa5dW8c5rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=NTcK2wVB; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3D874200058;
	Sun, 20 Oct 2024 07:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs9hPSLF2+9LUSc59OFkTMBwys62tiGajbTLxb9s9PRDKvyoXTo+3p0YTw3LOsMQBDEz6hNb1mRXCg2Y65Pp508kIkXmG66P7gEmQibwOXn0p7v4OjBqdX6DS2L0QhzuhZszazOyyCaEr6FVPh9I9q1CHDnQbfPYNB6E1ChEu9PvCwXJjtFRtzot1LO4PembGDyGCWEJ/af8RApJek2Q7scx18behMnhyscJe98DwzuITlJPag8c1pq7LIUyclFWsHTJFtUyUd7EqFuAx6ELBhEc29ZsOdkodk7Ty1mChiWvkZHPE12QTKmWzCFn0Ji1Khk5/AqVd0yZfsQRxO6axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxjqirJquhcoexBA4cI5qVJkqD+zbUrN0zQOQU4tgBg=;
 b=xqQgAVNzlehW6eJUN2qevvAi3Sjwe7hhGKLuxzhVecI84QuDEMU5EgwCFjqdyr2oJyvpYOhvoqhR9sjOA8PzmaK+ZCzl9qITLgGbcHDHgPRx8005pbeyKH08xTxCVljWx7AeYb0zeQuCk1CzxopGLmbTNLQRB9lngX5x74DV6ShHBRW2+WxgUnufXuTSRp1BmPWaMAAVVRBhs0tQcOXgTnmcW/TzEYPtwTgUjLCjIo8e6CL97PLm5qvxAdX17yKyk5P5r0KFgaR0zWgZgD/n86BMXJ8L+CLvly6Cq7yG+oYFPVs4J2eL1VqeYo28s0lIaREh+4waT0jUhtGXUKyg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxjqirJquhcoexBA4cI5qVJkqD+zbUrN0zQOQU4tgBg=;
 b=NTcK2wVBKIGfV/97WmAYzlkZaWoboZidzKAQPsUi/G5ibhEJCkxpl0akEqCK7aVZK1ywKmcUJQFX6uIjGAkEZw4RPW/d5+OOCOKYJH8rPL+g39pVTfTzf50XP2x2mZK5sRSQa0nIChy5Fp0Oz7oHqxhFxgDCdwphBIsdyN1g1Pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by VE1PR08MB5774.eurprd08.prod.outlook.com (2603:10a6:800:1a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 07:16:35 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Sun, 20 Oct 2024
 07:16:35 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: petrm@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v5 2/6] Define neigh_for_each
Date: Sun, 20 Oct 2024 07:16:26 +0000
Message-ID: <20241020071626.500958-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <87y12mk6f0.fsf@nvidia.com>
References: <87y12mk6f0.fsf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::14) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|VE1PR08MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8540ef74-6d19-4c4d-ef53-08dcf0d7214b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JMW4+Cd2XdzhIB8fmCRZynoKYt3rYWLq9TVqxC6oO+D5LONM4LdHiRcb9usM?=
 =?us-ascii?Q?BvZAbGcriVZmKCn24u2nO37JbYWZZlNuo5XYSklw/okVU/nOs01siekTa3dx?=
 =?us-ascii?Q?NQyQD5drj6flwBSRzTyylZRWgymDPVeyGUXaRSJINjIasPQrAORo48ROsySc?=
 =?us-ascii?Q?PtZvpwEGRdCfvxErbO60eO7NDSGGrioNVUzSEB9y8ZZBGqka2jk1yuRZ8cz2?=
 =?us-ascii?Q?pwvTlOHk5ho0PiRSA/6Plit/PPpiAcY5YUecJ2eAnL8JI6FjC9rV1SbDuvEx?=
 =?us-ascii?Q?UI52JZi9i3zCgnoZRHjhblvI8cJZ+Yf5UusFg/aw7IWbDZEwzr03XBSz6dMS?=
 =?us-ascii?Q?BRUUdp8jeJgAkZ6avcTch1+7MxsX8zINqzH3WGoMOh6t6G6dvok7nEAI1CRq?=
 =?us-ascii?Q?MBkN3qJW/bTGbsJ4Qoo4l6/xghUMFbv7xWb8XPYF58/IfaX96Mvcw5Sa5XEt?=
 =?us-ascii?Q?MlhDi0ISlGCW544MdzkMN83x0nMuEyHiXlBRBGFTSjtiE8QB9nN3G5jdF72q?=
 =?us-ascii?Q?AlVk/TkaU87IF+RxwOTDKsJ7UHdR4h4vTz5HwOjmmLkyewK2ynamqZdOGR6o?=
 =?us-ascii?Q?Zd/WTD5v/hMlJiRaIz/5mP1EyhZye/jiQgsJyOZM8F/K0COwAvhlZ2tdkeJs?=
 =?us-ascii?Q?hBf7LwV521m6QWAQLJ9lQTeftB2EndN9f2qhGOy+1T2UeTdcsNUVtaI4oed6?=
 =?us-ascii?Q?JVOQ84BboeWlbeKRQXox1XDb0Qc+2Fx9mgct5PRhVtDLP3BYV6NQ2TmJQ1tz?=
 =?us-ascii?Q?+66B8zOrQOh86IPoJ6847h7CzFJpuBvOKq6/QQ8NyRXtSj4xyLh+n+qHROYG?=
 =?us-ascii?Q?NBiCaZuMf5Q0PchAIGmanMLx5vNOEUk3f9guKiwPSM3tzRX0TazTDD0IWegc?=
 =?us-ascii?Q?vm4qewU6K/bUh6JMxYmiMdukRmXH37DLuchBOXL/qNLtdcMgqfuH4dQEUkC7?=
 =?us-ascii?Q?ALcI26Mcgg3OVFp1MrRY32TuGOWCMP5C+r/58TzviPqYDX1vbqsKR9KIRM2y?=
 =?us-ascii?Q?l8UxtZ5R2MCa/W4exxcCsOI3WX3vA/hbYQJqE1ZUu1LDxZUSAVkB6nP2bnk1?=
 =?us-ascii?Q?dMvKC/kYXPXA6t58sKT6p8HkYf/PRhUpDYQ/l3XaQBfGiPmmQHOAn4DgFjdn?=
 =?us-ascii?Q?qVHarLL3ukpwHH+pCl8iOTVn5W9hV9FLWO+CKd2jATA/DZTFfsoweenStHH6?=
 =?us-ascii?Q?wtCTXti+f9j8AkM0P/Jgwt9jxfL1zKo7MFbCluq7MzbkGm67U67r/pj9I0h+?=
 =?us-ascii?Q?3+n+7dmEiDquiOuO41hhP7855cv2HkyFxTSH7Uz44S5IZzF8eDBwthvVgSVU?=
 =?us-ascii?Q?nYxzT7kN4TXCuQZg1juzWqlT2IXTrROXH5q98C46vqBxpjV92PKBRnSoEkaT?=
 =?us-ascii?Q?qbjSQwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pp5dmEAHHXl4hv4x34Q63aiCCa+PlfWmxcv9kZ78sECKgutorhha3fM1hHqy?=
 =?us-ascii?Q?9EDBtScENRXVjukA9iciEkwXIs/dDDpgpwUKaSqPGFAy+7DZCeXJnP4O5VwR?=
 =?us-ascii?Q?7FRGfEZDPyk3v6S56X1ol564wL4vKzs2Dd64UoiD4T8rFwU27AY3AThVdagx?=
 =?us-ascii?Q?YCMyOHMTIf6ObVFYiroPwYndwXBAXo0i+Ji7RFG8xGH9nIfoqd7J5U3w929E?=
 =?us-ascii?Q?hbOlb4VMbPG7A31mgR0phidT/eZVaqelltkHSGQiplk9lD1B1uSpVGNvFMdQ?=
 =?us-ascii?Q?cbrUkHtX8wJG6Nh+x4ah6wtyCJ1lvbGzH6DMcY3zWHQSD8X7QIKFOZy3Q/gE?=
 =?us-ascii?Q?HaDhxlZXZZ//fC1DkflzS8jYU09k2vkNGIH9phNQmfHaLOxUKqkeASgV398C?=
 =?us-ascii?Q?y8/mYI2CqJruZ0QMJYPMG/RqmTy00bBSGEwfqZ/G41E3wsi/BhmX0/WmLFXi?=
 =?us-ascii?Q?tZyVyUxrM2Cy/IT9rLpDfngLZdSVgOE/1GoZCOYme7H4wsfK+MSF130ZXnvN?=
 =?us-ascii?Q?Hv60f6cx/zQ2MERbzYQBAGudktseUJZYFk7EVy27AFtt3UNRiQRiyOO1ThAS?=
 =?us-ascii?Q?7C7MnPARJkbcuzvdHuDVL8LjmKzmNqj/XQ4iuLjgSt3Wxf3V6YKEKoUP683l?=
 =?us-ascii?Q?hO+lYNnhZ3UuA8iD2bXHMFDbJflGtVmiGtokQhWHER5HANbQIkiumvdcS4yy?=
 =?us-ascii?Q?w9M2udEfWZag0jpvXVebeIQA0LEdfbIAVVjIMVdluqKBHBKJHaYjX6pjrs8/?=
 =?us-ascii?Q?eE4z0d88wgtfsWr/YtM35bT/hniLNmMi6iCyVoHHnwbAB5uS4StZ8GBe2C5X?=
 =?us-ascii?Q?Ziq+BDVnTUQmTci9UsPNTkPkdKfHHbqyvrLabcJKV2YWAbkiXTtznmLbmoXK?=
 =?us-ascii?Q?Z7gV1ciyQ5SqfehPU9yqCuVNpkKtMaaL7fDFT4sWQO/ZJWpN7i6uJshMKgUm?=
 =?us-ascii?Q?8jLwNwqDdudQQxT+YKNPHdc2DFRIfimx/EVt3YRMt3uZrHPfflpAUV1JzJhX?=
 =?us-ascii?Q?sXM7sweuW4jkNYkxjJymxHT3WXdcgKYGtXTDoCq7UAaWAixexnri2ncc2DR7?=
 =?us-ascii?Q?wHrHWCGngaGzeQCO11urNcdejwXDIPEmO7+Xv4IK/LZka47R91TfKFgo/YWo?=
 =?us-ascii?Q?lyvA3aUMdAy9/ufCK1l9vGYD1IAi3qNlggSTYe3szUSn0jnq6Oxe6uMlMzLJ?=
 =?us-ascii?Q?FzomVh/GxlzVaznZaaKxD0ExK8JrzGCgvGkQXLroNmTFZOdGRTipz6X/VQSY?=
 =?us-ascii?Q?Nnm7OAHjYcPC2AWuV/xijONk7bzKM3MaA07fGAsO30TXTt+QEVxxbF2ytfc6?=
 =?us-ascii?Q?CIfL8hm50d6AzQ9dNu5bFFIoflaihrP2J8WpGj2h2MjUmAnYRK2WFThx2n1C?=
 =?us-ascii?Q?jBe3t4S5lTrDpGwcJFhAmLwemM2Fe9G/TKtaxp/e/yc5brW65Y7NUW5/GFhW?=
 =?us-ascii?Q?beASWoRqCdqOeRvlTUzbkJTpQxqV1gfCXlE2QpPjC+0O6nIKh24U7PcM9NaS?=
 =?us-ascii?Q?qSmNT16rhBlj8fE0Ozzl+rBaVvnY/wm7GlIZ2FzQhQXIMy56TWgQysI+UUW/?=
 =?us-ascii?Q?NsPBwv3kzOEZrZTwL6V1CKGBLPA3HDILrngYXaOq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lg6UazyigBi2C2lb8Nu0uzATQ3CbtikAieaNnxrdc6JLV/tYVeUBYVzA2igiqJjfWwcBSk4XDjOTa+O9FqdVgMtRZwvT2kwCiC19Wjt8qci5Lg5nRKy0iBatDT9QZwOYlT5fI7x7At59vZrCFuF28wIqTtHmEbuNwT5S5JSbnU4QIs8C0KZOcxNlYcec0Ej1qTO6Bh+TSsDlZBhSQEwGGwwe5RwFBgyGybYa2EvMOSj5iy4faerMlsxxn5PoPN4ATlPB1EmXmeNVjBH4HWo/JbSLEFGpYSTtDuGvZsdCBjF7xO0e3bCGbsMgq4ANp2L4GlBYH7Xhk/wCZe3liJvMNo9e/GMDidRVjNmFOcf8pE9hGim0/1pUjgsn01GE2m4n+ThJ38UAw7C39ZMyNNXU/Be39PwheewZ2CrSzW3Pt7W12COVE/H4n33GOopiUM6YnqWUc4bsgbSWtLs64iaQqqodm4VEH+VhzZH9DVrRHLx1hb8bQRSzpjd0yqfzIcjzF9XnCgeoBOtC7Bxt2Kuw5JR58Vbk7Fxy9ssDkCIRUuMePWbwYgdFRcpHtM3XBKX4nAzvQzQEixEaMIBcxrp2e5Clqw7cdFoAMUQ+zTTAxZAMMscxiYkPh+rKJg5vEttD
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8540ef74-6d19-4c4d-ef53-08dcf0d7214b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 07:16:34.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roI8ZOc7fZSaf9S/6Vd04UoJFD9geNjSe4BCdAACfUcvwZUBPXdWNvAoo4HIcPghLduX9zd9cLIKCbry2SI/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5774
X-MDID: 1729408599-v16Ed81IMkrJ
X-MDID-O:
 eu1;ams;1729408599;v16Ed81IMkrJ;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

> Note about subjects: all your patches should have an appropriate subject
> prefix. It looks like it could just be "net: neighbour:" for every patch.

As in:

    git --subject-prefix="PATCH net-next: neighbour v5"

Or independently, after the prefix, as in:

    [PATCH net-next vX A/B] neighbour: REST OF PATCH

> Also giving this patch a subject "define neigh_for_each" is odd, that
> function already is defined. Below I argue that reusing the name
> neigh_for_each for the new helper is inappropriate. If you accept that,
> you can add the helper in a separate patch and convert the open-coded
> sites right away, which would be in 2/6. Then 3/6 would be the patch
> that moves neigh_for_each to mlxsw and renames. (Though below I also
> argue that perhaps it would be better to keep it where it is now.)

Noted, will revert this change and rename the added macro.

Thank you for your time.

