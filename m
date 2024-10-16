Return-Path: <netdev+bounces-136050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFF9A0202
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F00F1F209AE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA91AF0B9;
	Wed, 16 Oct 2024 07:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E211170A37;
	Wed, 16 Oct 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062003; cv=fail; b=BTsLYqfWgdRgL2ohPSaNpOuZRaPeHelSRR5aRRvruWUNuWJO5ME79zsnjGFh4d8uom5Zf3YBS5fh7tgalrNnezDCLzZV8bGjGcbY87ulzYdjONQtfygnjVcZKrXSAbQIp2m+oBBZyLsJXVmrHJtpMK4mkk+hq7VjhmNxnF+b35I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062003; c=relaxed/simple;
	bh=Je8/JiAq+jCFOhMqUwDcgjqO5Y2TVK8Tv1Ue2QWsXCU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u11CHA6bt3H/KzSQnLFznaXUxgY4xGZaHTF+GRfIfvkIdkGu5qZjP7cBxuqoc6H/ZzY6WmAjtf2yVIkcmEg5KFYVyRjlcSwxng0axd/bj+jblJJC9Ldk1SUglzsp3iIxQI02qdL/uI7etacndHA3kQR2InuDbKmFT+HdHkTUh9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDPNv3U4Jjsxiv8HwGy8GCnV+6kNT9EzXP0UBrykegkmNsmE2MpLCd+cKHrKoDWtEusUpvLg1K4EBXCOojOnO5+fYPueWeYBvF/+5SRUQSwBwTPuWd3sbjQ6UCJG7Hh8fMmeUIMQmqYCZ21eMtYnZCHt2Va8VLtDBP77iCnBkxFsiu9pC6hdUHAtQOkMnYh7JKFvKTcQgL3Dc2qwnSxLcy1TDSltGlDX6U0EOdEVozmM0HnWHKNDkle87cETRR4+ZCgtjIZxGF1aC3KoanFR0W+PdPEgS7htcgZvlrkDO0jZKx8RvsRI1z8ikw6v0Pth6BAM7wTR+XCM9vqUih1uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je8/JiAq+jCFOhMqUwDcgjqO5Y2TVK8Tv1Ue2QWsXCU=;
 b=R79Ame0WqfAt6etuTPrQQl9qNNw0H//I+LFOenLxYUlnchgARfgLyJI/TklLFd2zxfaHssMEFEcP2aF84NkgNaC1c1i1+nxeyGdFD+q3K+QiofG7KIXB+Nm9+v6VPlVnYOtCTfiPja7DeDUv4PBtIYx2H85P1ShacpwAj55Am4DrCVdldAw6v/Kc2YV6+9f2wyVfdqJuiO1tlAq2GTrQPfDyy+wXsJw5UL+RjX4skC6FobiqETtqfP5LW2CHAvwxj0rAVLWMqF3k7bPuNaHVpffdfLSJ3/1uYej5zexxU7EPZlnrJO48DxPQrVNxPni5hUCrVSFSj08RspYVVlF9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0961.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Wed, 16 Oct
 2024 02:25:39 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Wed, 16 Oct 2024 02:25:38 +0000
From: Leyfoon Tan <leyfoon.tan@starfivetech.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lftan.linux@gmai.com" <lftan.linux@gmai.com>
Subject: RE: [PATCH net-next 1/4] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC
 mask and shift macros
Thread-Index: AQHbHs+EDa5qCNz7PUiaD/wu3WV237KIo4WAgAAEDZA=
Date: Wed, 16 Oct 2024 02:25:38 +0000
Message-ID:
 <ZQZPR01MB09793D5AAFFC51427B9A0E158A462@ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0961:EE_
x-ms-office365-filtering-correlation-id: 7788f24b-bf53-4ea0-023f-08dced89d326
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 QSs9+gELsdZUzv25qvDLyR7bq+VtNO1PXQRgHV+tBavcZyO0GtjekbeaqpUYcDz4iSfeTj5IzyC/imSLIvwTDKBUImbYg+CTr6W797PMd5bO0rsamIDPA8GqXztbpoz1oHt/PQT68yoNnuFZaclF9d7TuFMjk3jc/pGqntDmX4e6o6Iy779gQrkbEZbza8r3c10EZmoOnmtzD0v6EuOUF/4FsFZbcNtnEpcNSeWhtoa1lBbLSB1sOX8Ss3cK1aATmsUkxMSHrwS23uh9qYGtXMxtLGV7ayYtGufZW2O6DIuSmVMh00u9lXJIU7+eDsrpRURVuGtEmGEt0pBd22jz0bcjP8djr2T6rYi6mrUMaoO5euKHnWEsjM6TyvrErQjKrHusWQsy4dCbWZbaM8KGzSlN0hUW+8+1r9vrk9kFt98VTd3XkBI3YpZv1FJTk+rfYPFOEvZeLAr1gybiJpmniGwhbIh56CE4y393bQ2qDzA8fgP4caQvc7A3EZ74MrC5uXTb4T8AnUIHFUNc2jRSy0HRvwjMK2bJHwEK+pP3AJ0PA1gajfkSIxWTv+0w8B5YqU3OlexnIZB40SScrnveUh5Gmy3QuiYwKdTZxqRn7Nvbw0w6P6WSoIk0bijA9KqG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ykMfhD5JE8XmZd7QnmH/FTFu+ru8obgfclTavfHh/ES8s5U43KJmKjeX0pwF?=
 =?us-ascii?Q?HViXhO24M3efUVpN+9vnEyoEPRF1u7bZLR+tkEYkFFY+YrY3fBUdyeXSS4A5?=
 =?us-ascii?Q?sRO1r2tGpdB033UhjcOIxcXtbP4hyALTNNPNL95gW4OE3Q2+YOuDI8b9ivOP?=
 =?us-ascii?Q?8Zra9IfkZeCCT9JotpGEt09nsuPKkUfs3wf7bnrGkypIDVZ4/M+uXKg6VpId?=
 =?us-ascii?Q?jjADLnvimqaZpFhM6Da3HSe1+CcmCyA9w8kcH4W3en0WfsOf9YajY3uJUAtn?=
 =?us-ascii?Q?VBshg52y34kaCeDGZud9J02TRIMeLyS2HFtKWNn/JCWwaoEjHukLVmU5T8sG?=
 =?us-ascii?Q?DkYIgLQ3e53vmBXLcz3cI+lUYu7aX8daKGS3drKJnTQtVTVl1b74LpTcPFIU?=
 =?us-ascii?Q?y8g/I6lTvm3mlHmYFDFeJgtqPEht3IYHcGO/3IdBW7Rv6z+0PvI/ULSB+c7e?=
 =?us-ascii?Q?iVf/GcdGlt8SsOneDSKM+LjX1RFRj0/PeHLk/jHczyQ+ufzQG3SuTLy6dIAh?=
 =?us-ascii?Q?LpJtW655cgZUr/PNyX/R0b6ko+LWedrT5mDGrsuMFGBoNodPLQZnBtYROgwP?=
 =?us-ascii?Q?U9654UQYxTJqvzpE2KqlxB6r3ds0NvRJ3TYUS7G6bcUZxnKSIMCJYO+M9g6z?=
 =?us-ascii?Q?jq4bFUIb9FSR7lr+VQ0e0lV4Kq+ROE4q6KfqZqQ5eSFsyB/SOGFg0xrxu5C+?=
 =?us-ascii?Q?XcvlLaDuG/N4j5n2z859Zpa4PTXFF+8OLNJeNjdOtXR+f4+jvXqoaYlXdynK?=
 =?us-ascii?Q?520LOBpGORlfKGi1l+RB+0PUtihlvkx/LfKebesFTdtL4AGMADkDE4+qLKKO?=
 =?us-ascii?Q?Maa9a3rcNEAHVGhqNbtkP+jUrHXjdp5IgwVlh/cjLj1zaswsRwhSY8Xn4igh?=
 =?us-ascii?Q?qXBi8LqWii3Y5crDFz/1MSFNPqLBXVHyzQq57bSQf/HNoHC5kz0tOvCMSJE9?=
 =?us-ascii?Q?Q+k8Tyx5wQUAGytBYJuwgnRQKElTbYRTwpZ0ddou9x37h8pQsj0108P7KM6H?=
 =?us-ascii?Q?V1ld9ITCNcpyiWn2tW3qQEGBJ9RCLWrd/u2efpjCULAy+zfjwn4K49REo0th?=
 =?us-ascii?Q?XhdMVd+ukucMZLBuGwe8mb4bKz8KmnoB6gfoRTgSngqkAs6ffRc2oln0FbiW?=
 =?us-ascii?Q?x+nWQIYb31hjT5Bpd8Q/VpyZQ+u+z2BUB78JJOyGu4Evvz0I1pMjCD47UOrU?=
 =?us-ascii?Q?mJ0Nv4RLDyMndJzZJl1ZQsHj1RyBRmPUVecIdOaPL6Yxh3hFDMakVegIppQK?=
 =?us-ascii?Q?65ZXd0VQpcQ3qWUC3JiLUCvzSwGeOUANJLcmEfn5RBFQagIcr6D5X9AX6fB7?=
 =?us-ascii?Q?E/VahZ53sEPVFtFwt98e8TM6djq7OvOJxqXsjfuQXwRICP9cGTPf4PSp8T2B?=
 =?us-ascii?Q?EXhHKxwOkJokh47QVx0bQ5xBoAnDcSbkRsTIPfkwMvU+UWeGcxCKGg5DpBCW?=
 =?us-ascii?Q?rxlePprM0T4tSyyMxCkkHsATfj7HaZPrqr0RkZTjPBV/b8MrPIMAbHsBulZH?=
 =?us-ascii?Q?RyANAqSeknRtZfd70Cj6y9q7JkuTZMNX5f1oEa0ImzeFv8aFKyr6xXk9UlSr?=
 =?us-ascii?Q?OC4O1goBWrvK61gmAVEy1AdcI+PRmbxL36N0Eu0MoODClmZfTmrWTo/xpU9d?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 7788f24b-bf53-4ea0-023f-08dced89d326
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:25:38.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 827SE0xBHuyqGxAHyd8r4ViRg5qYBSXTtcw6gsy+lMeecweLbWx5gr9kEuUEP2n4l9lH8vDopCHquyvWL3TTXC0jmY4dXQRb1d600my38MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0961



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, October 16, 2024 10:10 AM
> To: Leyfoon Tan <leyfoon.tan@starfivetech.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; lftan.linux@gmai.co=
m
> Subject: Re: [PATCH net-next 1/4] net: stmmac: dwmac4: Fix
> MTL_OP_MODE_RTC mask and shift macros
>=20
> On Tue, 15 Oct 2024 14:57:05 +0800 Ley Foon Tan wrote:
> > RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
> > macros to use the appropriate mask and shift.
> >
> > Fixes: 35f74c0c5dce ("stmmac: add GMAC4 DMA/CORE Header File")
> >
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>=20
> no empty line between Fixes and Signed-off-by lines, please.
>=20
> Please fix and resend with [PATCH net] in the title.
> All fixes which are needed in current Linus's tree need to go to net, rat=
her
> than net-next, see:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#git-
> trees-and-patch-flow
> --
> pw-bot: cr

Noted, will resend.

Thanks.
Regards
Ley Foon

