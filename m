Return-Path: <netdev+bounces-156442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E396DA066DE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458DD7A04B3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3179A204686;
	Wed,  8 Jan 2025 21:05:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2090.outbound.protection.outlook.com [40.107.121.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E12040B2;
	Wed,  8 Jan 2025 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370322; cv=fail; b=fNDhEdIg3EnywaVKaZUiX7ER8BWH3M/aP/cwd573Kd897Ny+N1FwtnVfjAgn7wdZcv2H/lDvy9TnHjM2MWdvpeu9g0qmwKWSx7fCiidikqOiPYuUVhvMTcfak1EJnAI5LkDy8+rjb/F5+h7Ub7cq00IL42R4kanb6UzFVWRiboM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370322; c=relaxed/simple;
	bh=C/7DpoC+WDpUhmoEKFUq3J0JyxWPDYG1YtilH27ECYI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=BbbtQfseqdYyIkucc6yTHBwE1tm6Q0jIRvLqoXfKYyHCuq3rMtuI7qVsTX7n0VP0mKq0KE5DLAvt98wr6hwVycnMTjY6xoYOsu0Ydo6IXPPcaNKGRMYcqSFfOnGPCPhEQSoQedbuST72TE0LDxw3R6TKfd4Z72OzNWS1rkjXg2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.121.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA8E1BwNWZXBkDLgmRT4ckvVO9NHdbZa3POG9g+Hfx4C5hmCs+4pVBewjV8iZctz43Iy/EIxAljK5qvb7w1kiCl8CalH+LtMHCX2XWOR6axj2fmii+2+IfSF9mym94Wjv5mpbug1NRgjs3GDKg8l48dQVjKHgvY3JP+YpW0qk2ShBbt7T9XUDdIUdJEYItCwReslHKIisTWF85ho41hPG+aq7hsfX2obH6Q7vp5tVFHel54AxwcJk6X2I9ZzVAdYzd/siJafZ+MAq9ZE/Ncif+5QIVAU5thL/r6/j+t9vhPQZqhsgvgB+3pCui4GNJ78j3YBhTSRf6D/PA8MG9P9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP3zp+SEU9ynW7bKSztnh+1pzFIyzh90YbSaOcVFB4k=;
 b=HDA1XJ99xO1QiepvghIqseL5G7QwuYLz59apqftw9L2zAPjy/chtR3jb57WcpEwtBglqgYnKqL6hMydWwtpxBZb9Dc6lGVa0oizU9DPgtmHYrFZANCQYTJM9n51Qia95FgjX6is2JsN4wYBsvRB9upNRooKkPvh7xwafUQNWgBtTLYeNdWCwjmUeIBtSDrrGlW0KcmmS8SWpoxu1H7NsIBe/bHUS81Y0ZATNLc58G2cbD8Hh926+BsBUX0jXFKSrDvwtuDbjj4Ex3VhGIO0qmkhW+89M7H5oycFvHIowjayu0ZJVl+ma2XK41ZSvP60yYx/6dzeaASfbm/QiRA2lqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB2712.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 21:05:17 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 21:05:16 +0000
Date: Wed, 8 Jan 2025 21:05:15 +0000 (GMT)
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Aaron Tomlin <atomlin@atomlin.com>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, ronak.doshi@broadcom.com, 
    andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
    pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
In-Reply-To: <20250107154647.4bcbae3c@kernel.org>
Message-ID: <71e6ab28-be0d-b85c-900b-537295bc81d1@atomlin.com>
References: <20250105213036.288356-1-atomlin@atomlin.com> <20250106154741.23902c1a@kernel.org> <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com> <20250106165732.3310033e@kernel.org> <2f127a6d-7fa2-5e99-093f-40ab81ece5b1@atomlin.com>
 <20250107154647.4bcbae3c@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB2712:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cff143-7b25-4d08-fe54-08dd302826ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUoMv0F4NkiyoMIW4gYCVknwF/8s2oqDVMur4LucECdBsEAenIb9eIeY/haq?=
 =?us-ascii?Q?e1OBJwZ85oghY49yMwszCqjPe32w9QCN1/SHxsFADM931C/DXUjTxzHIP/Vg?=
 =?us-ascii?Q?2pYzI98waO6AhS9aMPjASyFlmjgMymEugmWO1ULVF2wWBZ2QyXIVOwCE8p9C?=
 =?us-ascii?Q?+RX1dHi5u8UYS0c3WFDhGCli+N7G5HSGy7Cy+vvzyTvte6NshhgV9LTQWk9s?=
 =?us-ascii?Q?IKKdR4+8JhoY8xrmEXolEGQZb9Wifuy9Va5n822hyzezn39TY5rq5HYw/D1q?=
 =?us-ascii?Q?KnIi/ZBxaMJufza2EVLumdjPCOMxO1AxmqhPJBCu3YSx2JF9BbRqwC93HZxi?=
 =?us-ascii?Q?xrvQaO4SvovHqlTxU55f5F/UgfK1Ueb7vbYXHE8iwiAbjlxtBF150pQpA+vY?=
 =?us-ascii?Q?ORkTyXIoguWFd/yVo3uNIUh42aYY1fHZAZ2r/LLc7fqdot3X60tNExoCwkdL?=
 =?us-ascii?Q?x0mUdMToEYcV+GiR1AR3B3ZVsENJ3x6cxwVlf6I/Ndc1DetjwgQHvFF7Zj3w?=
 =?us-ascii?Q?fiBQ8A5/961i2seiKU8+jPetzrUxKjjXIPJuckk7VzpMpCp/0HSWmW+w40TB?=
 =?us-ascii?Q?hn0zxu0APqEzMV5gcBUupxtgHAd0A4AnTLb/sLz9sMQrTCL+vIfVlKSOoL8J?=
 =?us-ascii?Q?R3s1J+98uaQB9NW4D6fRzx7Dsk48Q3wN2K+yklAMfLYrA2b9nM6qFaPPSvHT?=
 =?us-ascii?Q?31QMuScR/l/WieEGK4WqEmOj2u/7JO/tuGj2zDxpCzKuzNjpK25xwt9g/FqU?=
 =?us-ascii?Q?3hZSZGmtwJBh1cq/e0tcYkBlxJSU1pWwtgogUrQetpQpZE8wsTUlcUIdlV1v?=
 =?us-ascii?Q?FQpRMkhxTAarC5U/nkF5FIGaWptlZ3+aoJQ0u3eg550J07+dyBh3MeTcHH6d?=
 =?us-ascii?Q?Ugw3cPmw+5yK0c/nn1S6NoZ/SsKqsLNJCHLNeH1dctpo9dHUsqnjS2PsexsK?=
 =?us-ascii?Q?DaG1KRYKM9Qy5geNyGaRiNyW4QwlgD0HWk6W81afRWuJnTSM/R5QLRh1uZ1d?=
 =?us-ascii?Q?RsQbbmo13jjNl7gzwktNCj+GJHpeZ/EgLz53rhzUuifvDiMCQPOzXN0RdodM?=
 =?us-ascii?Q?Ezgpm8I9RgBi9t8qUiUWHyXgQb4taYPiepsWQxnF3wmXco/5uQpCX904jvTl?=
 =?us-ascii?Q?8sJJt2EYZLFai9pJrQzcvll92zWq04SxEmWp7+Tr52HZ1pmBKkAgwDi1NgNH?=
 =?us-ascii?Q?dYZAyvaLVWEH3OkC21kdKHsVadlezd6Ne6RLCrR0oAJgIr83IbEzs1tFMIf7?=
 =?us-ascii?Q?4LpxgAR6QWPsBY+FsQR39OrUf5O7dACjfTxNdksrBVSYrx5bjPaVEdigELOn?=
 =?us-ascii?Q?9+C0ghXts39s+yGQao6B91dw9EKlLCsmr63AR83e0bqzPIcDseRLRBlph5tn?=
 =?us-ascii?Q?nZzWY5a8iVJps1DImx38nvL/kwro?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lP+xqIERTLAUhpmresybcI57M/HVxK6O3EXsBX2Y96uWq9+czcdDzGgXs7rB?=
 =?us-ascii?Q?/+GJG8jxOwus6BhXifuzdQMlv8FKy0RpILogZToF4oZmKDZiyZXtvuzvqMKZ?=
 =?us-ascii?Q?gAU+PFAnORPlMwLa5fVxRTA11Xv60RPllohpYXx98qqYfooJXLelykXDK3S+?=
 =?us-ascii?Q?NIGFmr/MXx6SpbbrDm0zluf+HrwfgQM6eL0oRA8B+7PDvkIt3kl7F4ggX3/m?=
 =?us-ascii?Q?LOMfweMweW7wU74Y/FHtWmZLdUdODN9yUBd/2UBPOdrHb1YssI+zUGmZ/6/9?=
 =?us-ascii?Q?zy824FRJ14ZA4uJ3fLvzsds8u4UlWAYH+vQaHi+qApw0x3DYW9cSDXfwPAln?=
 =?us-ascii?Q?/Xy/FOi66nSNEtwEd2kSH3UHU0kGNaoivE36qfacusb8G3fjN/KJzMpeUxnb?=
 =?us-ascii?Q?C299ZzCZBHq+TY+dLBIU/CFDA67bUQw6dgPR/xkhzM8LV7kor6J4X/P+Re9O?=
 =?us-ascii?Q?qPbouP/6w7PwwzHLXSBO5+vWRrLtR0UvhGfxDxQO0JP85Po0/jRI8fqMuFbl?=
 =?us-ascii?Q?m3J2hi8plA9RbcMzB8kKQSkQ2r+imf+sUc7N17Jk7bPg+Q2lkD89EDwYHkhl?=
 =?us-ascii?Q?opdvA364Ys5p38BkrBBscZjFJs61vaoU4RDbuSn4wxPv00wmQRXPThpvE/rF?=
 =?us-ascii?Q?f27zbWPjGsFfw13aZkuFOIwt0bmuFch8gRLdtVMCc00ecfYD6AxXcp7i1MRl?=
 =?us-ascii?Q?b5pycCe84yGmZVPr2mWlaumh4cA0Dg4sf6vYWlTsr5uLy6mQGV6+etjivxDY?=
 =?us-ascii?Q?DP0IKy0/iaWOVU8RJts2S4+cXECI89lQq/K6ph2mDoqxEeX3j77zFAfmi38b?=
 =?us-ascii?Q?ubbWJbakOPejUwViyrvFhoTocOUXAgyblN5mQ9Jhu4kvDpY5Ah7dmI6Uwksy?=
 =?us-ascii?Q?9/XmTx28dky+hwtkH6+YtQiKiRv7rW0ZhNGxOdmMscIqMsSQt/5T5deYdlu4?=
 =?us-ascii?Q?kI6cqOVsgk8Y/loAVii7/D9wfoR3KUY5x7+fVLBcaUfYTzBHRCSVksLQkQ/N?=
 =?us-ascii?Q?P/6NAPc0E2r2Ayua9hYnuTE0qYzBeuD4DhVevIgEYOqGaUZLEu2KDw8wrQWi?=
 =?us-ascii?Q?UURcHJ9vxogTVPcdbCabF2MLFODptSAjrOYxEp+EQUnIaAm8NQ/cGZITfMmP?=
 =?us-ascii?Q?O1YdYyOKUyLte8ynZd8JFsqzdbJTBeSAArVqL+CL/yfkpidbpaJLWFVC+SV7?=
 =?us-ascii?Q?5udKnvLdLecXC3OnIw7i4pa+ztN+C5FuV0iYHKgLJAj4pss4V8eWwiOE7GXt?=
 =?us-ascii?Q?IedeP+r2M0c9D05mwvzVaweguV8tD54aShatZWbaFaae1QYMya97R10dmNIU?=
 =?us-ascii?Q?W5nS3rzIir4MIEs4bR3fre2YlfLkC02cOf6FLjkXx45sjNL8XclY2H0M8M3g?=
 =?us-ascii?Q?eKwAhTzEpgCKs9lpX/YKNbzpw3Ypq5S/KYPZ8A5jaPCI+meposvfZpOFV/GH?=
 =?us-ascii?Q?sVupDmqjQKCFAPVAEYC4B68S2FHAJw08f1dgA6Ywta7zM+LxVODi+iZ+zR6s?=
 =?us-ascii?Q?eEHnPupxzcbfsT/T73cqCncoeTC0cm9IW/wCad2YLxju5f/9FSi4NgatXQOe?=
 =?us-ascii?Q?FZB2taQchhFIbEnO/OQjNEO1H+XjHSiRsPrMJJFk?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cff143-7b25-4d08-fe54-08dd302826ca
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:05:16.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE5tp0texgO76StG8yuCozoRSIyOJZTRc7n/I2Xuax8PWrv4bbG26Jgq6MOORCSNPTV31SLjSfh63sXbYLT/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2712

On Tue, 7 Jan 2025, Jakub Kicinski wrote:
> This is a bit of a weird driver. But we should distinguish the default
> ring size, which yes, should not be too large, and max ring size which
> can be large but user setting a large size risks the fact the
> allocations will fail and device will not open.
>
> This driver seems to read the default size from the hypervisor, is that
> the value that is too large in your case? Maybe we should min() it with
> something reasonable? The max allowed to be set via ethtool can remain
> high IMO
>

See vmxnet3_get_ringparam(). If I understand correctly, since commit
50a5ce3e7116a ("vmxnet3: add receive data ring support"), if the specified
VMXNET3 adapter has support for the Rx Data ring feature then the maximum
Rx Data buffer size is reported as VMXNET3_RXDATA_DESC_MAX_SIZE (i.e. 2048)
by 'ethtool'. Furthermore, See vmxnet3_set_ringparam(). A user specified Rx
mini value cannot be more than VMXNET3_RXDATA_DESC_MAX_SIZE. Indeed the Rx
mini value in the context of VMXNET3 would be the size of the Rx Data ring
buffer. See the following excerpt from vmxnet3_set_ringparam(). As far as I
can tell, the Rx Data buffer cannot be more than
VMXNET3_RXDATA_DESC_MAX_SIZE:

 686 static int
 687 vmxnet3_set_ringparam(struct net_device *netdev,
 688                       struct ethtool_ringparam *param,
 689                       struct kernel_ethtool_ringparam *kernel_param,
 690                       struct netlink_ext_ack *extack)
 691 {
  :
 760         new_rxdata_desc_size =
 761                 (param->rx_mini_pending + VMXNET3_RXDATA_DESC_SIZE_MASK) &
 762                 ~VMXNET3_RXDATA_DESC_SIZE_MASK;
 763         new_rxdata_desc_size = min_t(u16, new_rxdata_desc_size,
 764                                      VMXNET3_RXDATA_DESC_MAX_SIZE);


Have I missed something?


-- 
Aaron Tomlin

