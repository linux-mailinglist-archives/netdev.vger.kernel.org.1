Return-Path: <netdev+bounces-156063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B2A04CB9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885E7162710
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF11E0B96;
	Tue,  7 Jan 2025 22:55:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021093.outbound.protection.outlook.com [52.101.95.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F586330;
	Tue,  7 Jan 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290544; cv=fail; b=ODENShE04fs5A0W/4a0N+0lQKebRbJXU/12whSuvx0tN5XcPrxqrgu2zdWrhYvj7YlVTeNGzlc47LOD2TmWySsOqnRpF+rqkj6iV5nfoWHRIdiWCQ6FKP6wZm5n45zo89H19TrmGTMC5meO6Zvne1Pwdtpsd5XCgZgpJhOG43Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290544; c=relaxed/simple;
	bh=MpG/HOag/7w+49u/TVadUHT9Fh4YFm8CqpetN8UscZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=NahDNMgc3XGH9AQ8UpnOxLkeeSKqzpYi/YXNzanaWPkQ50MoUzJkOIr3IuaDyfeeDl6X0itiClTO2s6yMfSUEMvM5RGmTrRIyI65w+m6UrcIumm/MOPO67a9NPbKPR8S6rSKP8e6rspi+2FjD0W7P9pFbzWmEKr3f+AxyofE3Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX4+bFD3Pb9jGKKcFFNzEq9gc06ABeMKC3DOyJQGD6kNPlpEDajY2bhPTQRertqDBox3eR9kdDX5Dj3LSpojkNfLzENLWV9HgwA1yBr4HEJ7PPxdepvBF3wF3Y5b2PVv7rpDSGB/2hmU1PxP20YOkvbBYzl2QYPKCF0afhIuSh7daewEov5KCnbD1TI6v5Vi0peT0X4sKZZ612iBks8uA6Uivi0ctwV/glgjlMedDEcnJfxHK1/rrimlhj3gV/mLquSWiCyvWDvsYDstTOJwz5FI1OKEKcQ19ggpqkIeO4R0B3361kKO/3nLjhSh7L472r2oQK8GQc2FF0RCVMdvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nal0nt891vBfgJPRwCxlnXFSPh6yOq8gfyujWwUd+Y=;
 b=YOc+UrIBrFCTY9kbNtlbg1bf1zoiWfhb3L+sPCCVvNA4OQq91FWqyoqb0IyyZw+3GgQFvXCNJfo+vZPGX1F+t9wqb92QuAwrk1ZJo5lurNbAMXXoE/+yyPgWfwtp8ElSQ8wHfjbeVeOnmcsURiGJejuN6JNigh3PEGS9aCF4UI4oJxeg2AsLFd0u64QLKji35WVhD9AZqmtrYGn+X2cXGBHwjuBpzb7UO/c4IXzraFTXLyHCLc86xtSzqHo5sFSpTmGjW7/mUxSpD4aVYUfKPEK8qaAnSalIG/x0GQAIhDULtoAbdIotsYASmVxGjbxJyMN7iXr+9z4JCtFQ35KnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB3917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Tue, 7 Jan
 2025 22:55:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 22:55:39 +0000
Date: Tue, 7 Jan 2025 22:55:38 +0000 (GMT)
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
    Aaron Tomlin <atomlin@atomlin.com>, ronak.doshi@broadcom.com, 
    andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
    pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
In-Reply-To: <20250106165732.3310033e@kernel.org>
Message-ID: <2f127a6d-7fa2-5e99-093f-40ab81ece5b1@atomlin.com>
References: <20250105213036.288356-1-atomlin@atomlin.com> <20250106154741.23902c1a@kernel.org> <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com> <20250106165732.3310033e@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB3917:EE_
X-MS-Office365-Filtering-Correlation-Id: c719875d-6689-4d16-2074-08dd2f6e67bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxfkL26cMqetPrQhMiG/nMelkhnIXCky/rtitUGDyuMXtrq4v+CdMLEq0yuO?=
 =?us-ascii?Q?U9cF1AVQy1eIkwbwnUmRqbp/x+kbsy7AlT8yduvIZ3Y4SyA8uDxWfDrdAe6z?=
 =?us-ascii?Q?4iiC3OgJm2x5gbrf/jWm0lK00+O5KYWXVQClnuf2QeZ+zdgOkdEmvkcTcYIZ?=
 =?us-ascii?Q?zvH8wLLQf0Z/E72p2GlzqNsa6rticgrU6VP1ufUBx1E587hA+KrJ8mdqD7Vg?=
 =?us-ascii?Q?XNLRR5HP2rbRXVOxW+FqBpZ17XJ4dExdZch2uoWAiLmea+ea4Jw8/kAu5Elb?=
 =?us-ascii?Q?72rfzm8AJVjDWEzKRF0JyazxcWaMMf2vaA45vlAP5Wa9+q9Pi1LjC528rE20?=
 =?us-ascii?Q?KYawwpJ76PFA05ravXXoUtdiYa9mX+Wl/Oh0FNN3otcxIuVHkvG1HS9iVAcN?=
 =?us-ascii?Q?8XJgxgfphj36ucTIg4/v6xl71KzD22yvStvRrEGVweV8r/rl2pr/Qj7vo4Ui?=
 =?us-ascii?Q?U8Qamg7EuOF1RV/bzxB8mwg3KQ0ZfQ9Uggk/FDTL/Nu+9uAf+8+xCcAyL/QE?=
 =?us-ascii?Q?qof1Wge14IcHkGOjkXNvrQ9NccxsMvg5L7WPwQ9peMkoJvZtNXIYpWBFxH+Y?=
 =?us-ascii?Q?qJw2O78bt7Y3VxtNA0FBK9aIbiuBQELzl5UqkZWq2UJYyzmmbGEntdobLGXr?=
 =?us-ascii?Q?nCAt1vJ9awxlMqMIwbHTSuFDjEelF/mHdbuI3HNIUxfSM0E+iiFBUi0qK3Y8?=
 =?us-ascii?Q?1LAyQHw8Ie2k7C3vEbqv/pazlA6KUz5gski7sctGHV4KvSHnxeti2lUWIh3a?=
 =?us-ascii?Q?N0fyW4X7/L6VumqP0RxGvUYM0x7AIlY167GsvYMo1J0cWELyOoGYAE/e/GE3?=
 =?us-ascii?Q?VMmdJqiZVVbBJek9Tbx4s6pXIic8oOI9AbwO+18IPVJ6nyQRjhP5R37OPfsQ?=
 =?us-ascii?Q?aNk1eDN+VicQ0C65n6eZk81/Ki2NRrR2qzdkG2YMmyYqxezRhCkH3BFi4NrP?=
 =?us-ascii?Q?HhzPDdA5QDssyS9uaMNZIQ6HBn+1c59cU1yM6Dc3JjVm0mCnRdnlKekrXYA1?=
 =?us-ascii?Q?7xZQFzV+9xlOln/AyzW+/auX8sOyRwGFiSHUa2OGAD1LbkCUQ6RwtiNs3ogM?=
 =?us-ascii?Q?T7t5d2/mDAfzv2B43M4H1YnTH8RF4FGVH1J764mYIhybLahcX6FtZ1Xqf5Ym?=
 =?us-ascii?Q?5x5eY0EQ89W/f9RVnX+pUd7e33itILsDyEjOHLJmhI7XjnhmNz79ve9ebeEA?=
 =?us-ascii?Q?ZtKN/p1BkrxWY+XtJPCvZahoe56A7n+T8DnRCmKjIVAZZtlZ2UsAqLJZ4C+f?=
 =?us-ascii?Q?5SYrdtHgHgKBbolhw+VedYXOzYOGI1k+C7WbJnDO0PrUtIf29uCgQdHXUxHW?=
 =?us-ascii?Q?MZkVK3qY1YEzTUP/RzbLzfPCf2Q0IzUnHx28Sk+XcnVELEBo1tKkSCdswOPW?=
 =?us-ascii?Q?BhByVS1llYxAjwilok1DIeHnIGtj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XsvPeWKGYDwdHu+S2MyfaNG4eMBpczkPhTT08XJcglzuwkYuhoEqrRsTjgZD?=
 =?us-ascii?Q?Bsv8ByZMQ9j23SDXrUh3Yn/B8Dc0mM5zkXEsGp2XqtZefOw74yOId2pAxkA1?=
 =?us-ascii?Q?lB9iihBSJDoYkrPx9pctnJnzQ0OKM3VCyeNxbXjcS3ybNKarij60yoreVTyS?=
 =?us-ascii?Q?HGTNUGvgQLSSWHPnV9Us+lSsu0YW5pRsyZUlrYK7MKgRsiRBWGa8IUhcolMe?=
 =?us-ascii?Q?KvjkT/IsTWp9KvaeXzggMCMs7dMteJ128/vHhjqyV2Bb/4tQP+4VpKscyQg6?=
 =?us-ascii?Q?NHTWvPyuB0LLQ4yplewnOiUbZwYgzxuxl96XYR47tAQ3vDiGSKP4F46SJGWE?=
 =?us-ascii?Q?VD3DWZMidycfzFTTjGeWtPukuYOKr6E3+kyfLtuoVZ+VUPiTrrD296wwYTwH?=
 =?us-ascii?Q?082xWQhD0Oa0Om10PsENiWUh7htuJcWlzCrPZ8fYH0KldKv2+GdCeuppWaWD?=
 =?us-ascii?Q?8WXC73N3AbCoDzOp/HYDojYZgvWVBkfYDpUrpxKH4ILDjnTEju/CjvA357Yf?=
 =?us-ascii?Q?dOwWq43we8UyVGFCIwHV5kf1kp6QpdhgLDH14xCrk7sGPHltM2R+HNxM+oQo?=
 =?us-ascii?Q?GT2cBcepDPe07LT2HLBc0SGQY/4Ibxqa9A7hlQGDiA5z6GtXJo2Ycx2h9xUj?=
 =?us-ascii?Q?LvMMKsC4zT0zniXOqFddc4/+otuf6QKbPPmtwoZjhLiMjjN+1/RWDMURIQ56?=
 =?us-ascii?Q?qnLdJqJKSER3IIHpQ8sNagXRhuf0ITHb7EgGlRg3iZwTrkp/2RXguAmzOPA+?=
 =?us-ascii?Q?UHceJ8PyASTx/orFO9PSOcKEGYiKR0e7BLmPF5G9wYr5I6V29SOyusdsw5gp?=
 =?us-ascii?Q?9zIq9pnFoY6H4kZwGYhHdKUUuXOAvCqJzoiZeA9zhWLATYzDDaDh3KKi+Z6U?=
 =?us-ascii?Q?lPdY6D3bSWte+WGlnY7sR8v04o+hyey8ONO93TumJ5P4mD9GKcwNNjnSuhQn?=
 =?us-ascii?Q?Eed056prIjyCz4CLd5D0EMKfK0RgsPwurlR0YCTELQ7kQ4utw59BCR99eDGr?=
 =?us-ascii?Q?UzjzU+H8TvzMe690dwelnbXVy9jVk5F8O+1CyQ8abK40Zc25lKSDKAoqje0A?=
 =?us-ascii?Q?iA2jVr0xl/RylKhRt46u+UdFxQU6MT4lfwvi50TiXV6nxkXIU3t5hXAHGS7c?=
 =?us-ascii?Q?YXvMarZEAxKkifCAGCXhxyLH3jgWlDG65GECK0YaAzy6UqB7aKcr06Hhrw9P?=
 =?us-ascii?Q?+mYngRvj28fGAX/XQtXSItW47e6xzYCfWYLS1s5JMTpvPm13ze0+TMwkwidL?=
 =?us-ascii?Q?q5JyczAtRlWhx8RBvk4Phlv1Dwp5t/o7qr96PxSd7ALrn8IA7egVhQ842JTG?=
 =?us-ascii?Q?MOXaowtfQVURnMBtvH/rbEuu2xxOrCattJcbsi4/gG5SHxEd7xyvz4de4PMf?=
 =?us-ascii?Q?OcbAnM+MX10evGQn2E+xXu2vnjzb1N09dR9SzpZ+OGr3f32DEhb1+n8C6Y9O?=
 =?us-ascii?Q?Sp3IIpoNIeSdr/tW8aekyRbqN3y5zi1ZPaMW2MaTKIttAdiNpqPuzCpN0PWH?=
 =?us-ascii?Q?IXW9SDuCe/A9+BkuiAelY7SZurDK7pfX8xGvF3T08xZrw0+i+59zI48lVp2+?=
 =?us-ascii?Q?mghStYTgY4MESLGrUfZ1BWx0uUBlaY5hqaSYvxj0?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c719875d-6689-4d16-2074-08dd2f6e67bd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:55:39.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp/nDjiZbAKr5fuWo2IXrK3tvDPoAMfvCYIceI98OFMF0JZb9K4mnTIXNQQwJ+zWqYbrZQ+WK5bE4nJJ95z9pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3917

On Tue, 7 Jan 2025, Jakub Kicinski wrote:
> True, although TBH I don't fully understand why this flag exists
> in the first place. Is it just supposed to be catching programming
> errors, or is it due to potential DoS implications of users triggering
> large allocations?

Jakub,

I suspect that introducing __GFP_NOWARN would mask the issue, no?
I think the warning was useful. Otherwise it would be rather difficult to
establish precisely why the Rx Data ring was disable. In this particular
case, if I understand correctly, the intended size of the Rx Data ring was
simply too large due to the size of the maximum supported Rx Data buffer.

-- 
Aaron Tomlin

