Return-Path: <netdev+bounces-137878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDAD9AA436
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0CD28414C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014D619F41C;
	Tue, 22 Oct 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="qxqcUkl6"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E511E481
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604651; cv=fail; b=jS0/uyXRMjyru9dK3ZLWKeZD8H0ZYd4hSa1T1kBrZCtiDPq6SQJSkH6JR/XMjHt25eGycwvZr0i8LOz0XUcXllV73pwY1cNFYCe7EiNM3tY/Dsp6M30KABsy/kKzJRugu3W2o7LzrYIp40LxqX1PNqg92NABwNxPnor7ZNY6q8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604651; c=relaxed/simple;
	bh=A+5WLTVTgKnbJgd5p+xzqrEFTvxsdewGTqgillMnlVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLuxXGJIHokOGN38j8PcQL5FLzQtpDqd9naCGP19AuB8RZTQ+8a9V+8KTJiSKfEA6+g209HEJwW+gmB7IFTRAGt2tLEb0twMZzuMhoKc2mxRKZa9PRT2WNCESIHu6B3tFlbSSZPbNaOYdVtaclOXtX7afLKIQOmQ3wiJWnT725s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=qxqcUkl6; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2239.outbound.protection.outlook.com [104.47.51.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 02D75200058;
	Tue, 22 Oct 2024 13:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbAP+jehdwIIoc/AIQB7M9ZiP9kNVEO4lhrKv7sgdYQD/RshywM7SA3G5gbG7K+6Tpc3RXY1hd6CiW8rgk+W9c5JwlIj2DOjify/zMWJ9JrbxXoNJvGl9S0DABDraZvYC/fHjK/xL/diL0n6XXa1QaYRggfZXEyHUFvsqXDlQ2++ndKisuHDXQXpPzlC02kmN+g0PVyIAXbamMZAseplK9ytEh1DwRT0aJLonMoinq5WoqrpbTtEbWeSv90x8hS/WoLW7ksKQuCxCTm6X39O38EgGdAqjo0o5Zn4R+3rrZVusfmDqeHqHN66wpcggAZhYlBIuViwKenCz9ihSya+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S82OqHsPVGbQfGIM4S/NdJl8U8lhgnpRIP+IpeCwvVw=;
 b=fy/ACKewfP7sEl0cZE4T+cAE4k27kkH0B8TZrwPgTLxVnb4AjcffJGpgOFG6GbpRIXjBRXCG3vLKaXxYS9D/j60mA1yiXHXFzJH9cvrejN6rqcPX2Y7mE/Ykc6aJVMrrb/3YZ5oHAKupXJdFzyp4y5jYpvYO/OuAjpbsCZrftUs4t2tDSRGgLtZa7FMmQ2C71EbCUFCcMJj0fT1Vo/kxK9wOtZRjuZa2V8aDz+Rtdcc1vL3iW6xB6hhEGbiMncjFXH4CfHgs583qQ7wzhp0zcLapJPUy3EocjnUe3ehrQHALz++0yKNd+DLR4M91Tcw3dLQcyJQ35HlWWSPbMh4z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S82OqHsPVGbQfGIM4S/NdJl8U8lhgnpRIP+IpeCwvVw=;
 b=qxqcUkl6Nl65V+4vSMkMk9cGpgcwYrmh6Wum7R0lK1rnexWFFBmbvzRM0G5RzktY7bIHYl65livMrKC1svfS4evj1z8cQUE6khWVlntF8dU4ThowG2NI1Mpzi1ffW6fEmTi8sMRJrO0irBJNNepFYCYSTbWD5GCo62mFjLhrBN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9077.eurprd08.prod.outlook.com (2603:10a6:10:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:54 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:54 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 2/6] neighbour: Define neigh_for_each_in_bucket
Date: Tue, 22 Oct 2024 13:43:37 +0000
Message-ID: <20241022134343.3354111-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241022134343.3354111-1-gnaaman@drivenets.com>
References: <20241022134343.3354111-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d41c71-600c-4a6c-602a-08dcf29f91fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LiXeIKJ7LumMcRhby78IIue/qkZAKUFqFsXBz8/BNajg1gQ8L6pHDabbQyq7?=
 =?us-ascii?Q?5/ueMCg7fF4nlDys3xJfQVsmsiXNvonLxQjZGeYOeG7S1hHJ+rrHnoe+9/sL?=
 =?us-ascii?Q?6nWjuopzwmbd3WfCMSstpBATHINnHBGEUp2jWdF9D9kxDQ1VpnyDHYoDWLdx?=
 =?us-ascii?Q?Ynm9mKaybnfwsctPMebrTggq66ykByUA+Z01xM4VBWZCbx+ArqdD/ix4sfja?=
 =?us-ascii?Q?zpfqADjvD0AL+76nffxxNPTi4nz6r/QWLQawxLnfbC96EHqLPsreSm94nkAj?=
 =?us-ascii?Q?3u1xD0jMNDdJ6TelxLN1yclFbA0SoWLjmfhFy04GZ6Rq8VRfuBsGqKGWnmmd?=
 =?us-ascii?Q?KtboX8YLa48/PwjGlJlYVLy+iKh8cc+tm6zoGWyfLo9WUDAKZIO7NyzTdrY5?=
 =?us-ascii?Q?kxKiWgfvg0Q9/MxT/FRElNOQ/9fPo/wpXq53moZlvVeao5OP8v7MoOqAT8Wy?=
 =?us-ascii?Q?NuoNQv7DtbA3ZWmqpnfOLtc07/xisqfcu7sUQQm1g20I/iTieykIySDc5pNI?=
 =?us-ascii?Q?/8deGiuCYsdlVgp7FqN0Li12VK95vFyScJ0aZCfwGA0MclkowuKKfuec5L88?=
 =?us-ascii?Q?+lnnEuvW8j2Dcc0oBmrewp+tZgXwIvuoZw0NziYzwP6n2XRCdK1E/oGIPuXl?=
 =?us-ascii?Q?xc82VYOAe36ZlT/m9NQBSe+QKCH+zhiHvIL6H1asnzrmSbt3UUQgJgbVqMXM?=
 =?us-ascii?Q?wn+QPmZobBpGXiHZUxkDETivqynOHKSzRQkHYZKhvPdngY72RCNSPSHF21AY?=
 =?us-ascii?Q?K5CBOWZFIxpKmPo/TJSugCHYZTRLYxtCHeL2kaStcXTeqyZSdEjvdfMPVJSb?=
 =?us-ascii?Q?3NYlcmdKZVTfjW9+q1RGdFd2/d/4jyml5gPVK+IIwk9yq5aBUbwx+Yc5Kzz1?=
 =?us-ascii?Q?lC2UknXmu1gKfEM+4b43gDZqFTt99c7yicdv+4t6wnDjyh4L+Vo8x34q3CJF?=
 =?us-ascii?Q?rkVqOdiFnrNQ4HvMlDDcDggIhWKJRg59pXbUtGm5U5/HpxJZURrvQe2qNNh6?=
 =?us-ascii?Q?g+0hIvDWl0TMxckLpGQugIpVPFPN5OAr81M9G2ekea3Oj38fDRyyXIkxWo9r?=
 =?us-ascii?Q?MeQRbsq380pZtJJm0NExhjeh8hc7FlcEGc602KWjh2bfC6KcA/SfLhv0uozS?=
 =?us-ascii?Q?WjIh65xm0y8asHREyGaq02yeAQyuD84Ixc6hEt7tQGNqbtfu5/xHXHQmRXXX?=
 =?us-ascii?Q?DFOaAyLPqaqwstCm0pxoab14G9SEohjjS9ENp6oaEz8j8vRMe6v4NCYpxm3o?=
 =?us-ascii?Q?rfzzZ23r9I2kWf7uFpFr7smskQ//TfIGVYZtP89qoz94b+/U+HciyZitF8i5?=
 =?us-ascii?Q?A+GwiVIiTp2BKJpRJb8o30K6KLaH/tQWB1IzjqfXv6NUccyJHXWOE3g8jPvv?=
 =?us-ascii?Q?1uVRHXg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sh5Cj8pRBH11tvKhv406hZ8T1jwUgIQEJ/YOnxxI49yIbnTwPAX/Hek5zzP7?=
 =?us-ascii?Q?KB1eu3OehZb4lY2rh9PtKM3EeSM2714G7/YyZ3c4HwXAI2kSNeUAuDeob9PN?=
 =?us-ascii?Q?qPMA9LlDxkOhz6a1+lVCaF9YZgXaTrRQ5F0S9nGgQY9Fu8GDAZlsq9GvpVLe?=
 =?us-ascii?Q?yYOBPWI6Ka+HzRHh8Q2z9ha5WZ8yOWqQVMdCylOQxdIbjKGPQ37S4TONf38a?=
 =?us-ascii?Q?nDdICyQ09feZWR5DEDc6n7plHxOPNk5G4qlUM5OrFZ1qHZgaA7nCmMA2vC5I?=
 =?us-ascii?Q?VaVqKCEI4fxgulodANVYm0ze6bSsGZIaQ98dKFIXYJCEaUyyS6R/qillu9io?=
 =?us-ascii?Q?aDCOQuYuSSk66BUON8X13j0pOiRTrcmueE6ErGdml82jnZ1phVsn5B4szM1x?=
 =?us-ascii?Q?p8V8mAXLA86vv22ZZYBEOUvTVHAwlzYRttx0VVy7dpA9b9XyrgDzV9plLvqc?=
 =?us-ascii?Q?fVtVHNhqOwEkY56xkHFm5//SSMlHgeCr8L4Vuosi7rEy7uNL9CXc+Yrj/EtW?=
 =?us-ascii?Q?jPSot7dULS6WIqvCaMX+aL6qR0wdAXmHx4CAAuBgtEOdWORsIpNlh22puB0f?=
 =?us-ascii?Q?a5RACGtQq5OTs7v0JXWyTK1Qz88xXdnczbyyI3xWfhEfbTGboWPPsUZaAqyZ?=
 =?us-ascii?Q?jJHNOmJphFC69obOJTSydGnl0F40h6C8AgLb3ROSU4zCmuUaK6/gCqp4G7/h?=
 =?us-ascii?Q?r1wEEOj0t091NKJgt/OA/7+rO6DV4I3+c6L49zLiGEAMKc6gwXuuVwRPahpk?=
 =?us-ascii?Q?hOXdyGOJ5jtQNpBcZWQ/PrVVN1F/xbhxiS9Gg1gL3/GTeTbsEk6Hdr1EnxT/?=
 =?us-ascii?Q?4eLdM9pqyTI7BXwZ6MpOuJnpkJzVt5bvadyWuG/2E3yiyTe9skusK7AOm9xe?=
 =?us-ascii?Q?TQXIGOTHsllM6AfOZeZBDWzK8/l//8KcYFIfVERJfJ6432fcyFS2C0ebzTWG?=
 =?us-ascii?Q?7A2HzLc4Q/Bjx0+2094tQ6CA2rGF0rfL28q3AK6WqKwYycZ9Jn1l+9g8VWi9?=
 =?us-ascii?Q?FDeMFokFCFCbEeFALtFv6JaoLT90hX4FczlxGAELJwkACS9HCF4W0LuP9AVS?=
 =?us-ascii?Q?QyTvsQxYDbKGOVqOCWvwup119Dz0sWomnmHlDCZlRe/dkvfGW+zPeCGp0GAy?=
 =?us-ascii?Q?fmviRzepw8QYFctgu7yZuLYp7mtMC1xu8TzS2gux4voZTAXFtW8wNo4h8709?=
 =?us-ascii?Q?PpZ/7IqxCdFogusaCfHzX6O7bpoCAm9b2ikH2WHZR5Xc+lzUTqq7mIoX4Sfe?=
 =?us-ascii?Q?j3I1qjJQs1/rEXVYq4hdv9lPNNfjf9BYRtIxjbyNlaq9fnT794eV/V2tnXsv?=
 =?us-ascii?Q?SvUgM8zC3A5GglOtPzQnG3ZFGM04rjKIHbpet5oRiV71XzW9Wj9CKy9olLiF?=
 =?us-ascii?Q?RIj52HAFWkfrQ3Y+uXXiUoIArrpbrDjwV1zyuRrkwSM96ApINlTjLu8tFHv1?=
 =?us-ascii?Q?xEzdC2ba29IXDEPSgmP2C/aPpp/i2ZyRwdQ9vo+6UB/p9r0DeGrN5n30NMhP?=
 =?us-ascii?Q?L3MLPXt552GyrzFz+ZkbNe+q5utcgpBWIbwotPKZ/onNtE5lzB1JgqOaYMGO?=
 =?us-ascii?Q?3eJ1tYzsbIlxeGAOHXuOAlWCT7YlMdg6nmtqWPQ0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c598k69gp/3AwzVtgv/LnmwamJQy19UCq7R+pbbBkRFGalvikWFqC30MLJ7ecnKyNF6oWKnn1YITr4aEAHTl/QBfV5Ic19F4Ew3W80Om6jDl3p6WWPToAk1c5suoeXsZUf9+ptOr74t9Q/0C1lVzPgzig5hc/L8jhQ3RwoJK9u2K4J+7cfkyiQjvEBk/DxokCd1pM+4eRVIQljGJH1vnwDrl3EnWs4Y3Fc8GNevJ7Ia1gRhlMRE6ITkLAc3kO0JoDEzxGG3vhGEdeWXCz//3Xf5njvCN7Z/MM+BaGOvHxU7JJb84Wzj8PDRpVq3h3oCmIr9ATSeg2fAU9bndQXYxAcw/4/rAuU2aOrsRwCylSzHO0I64fE2WwrpNmnkKvMKg5GXukfnHAwy3ehnmuyeYveF6gfR6oBQL7mz0zEKVApDSEdsa5g4x9tnGcfVAGfVwWulgemUPcP5Y+i7Nwm0AFa19LGwkKI2po/cjveHqkQ/RDh4GSs0ywACiE6rn/wSCeahE4d+TeqYiqpsla+qlAdsAGNVh8JO0jwJ1Nij6aNMMVbjFsinPq0BIwgIvGjP1o/k2pWmOcwf0NL8zAeYPheNHNSZamkIsyPpmFMHOTzUkxH612xBjoQ4HfulExE0x
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d41c71-600c-4a6c-602a-08dcf29f91fc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:54.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXasvq61ZRYSjMQkFf9ttTwX9x8urxmIwpYUx5bhqN9/TKu94WvSj26dHCDzpxKc2xq4Py5lkfJwB3+nrXWBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9077
X-MDID: 1729604641-BJzk2hdVjgyq
X-MDID-O:
 eu1;ams;1729604641;BJzk2hdVjgyq;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
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
2.46.0


