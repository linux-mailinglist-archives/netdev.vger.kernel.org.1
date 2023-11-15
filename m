Return-Path: <netdev+bounces-47917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1947EBE72
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2771F2556F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEBA4687;
	Wed, 15 Nov 2023 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B274685
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:17:35 +0000 (UTC)
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922DFDF
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 00:17:33 -0800 (PST)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"anjali.k.kulkarni@oracle.com" <anjali.k.kulkarni@oracle.com>,
	"leon@kernel.org" <leon@kernel.org>, "fw@strlen.de" <fw@strlen.de>,
	"shayagr@amazon.com" <shayagr@amazon.com>, "idosch@nvidia.com"
	<idosch@nvidia.com>, "razor@blackwall.org" <razor@blackwall.org>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH][net-next][v2] rtnetlink: instroduce vnlmsg_new and use it
 in rtnl_getlink
Thread-Topic: [PATCH][net-next][v2] rtnetlink: instroduce vnlmsg_new and use
 it in rtnl_getlink
Thread-Index: AQHaF0s2AvjmgJQbKkeACp0CxDL/lLB7CTOg
Date: Wed, 15 Nov 2023 08:16:36 +0000
Message-ID: <09987c1f637f495a99b1cc74954f9543@baidu.com>
References: <20231114095522.27939-1-lirongqing@baidu.com>
 <20231114173757.0910964e@kernel.org>
In-Reply-To: <20231114173757.0910964e@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.206.6]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex14_2023-11-15 16:16:36:846
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.37
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, November 15, 2023 6:38 AM
> To: Li,Rongqing <lirongqing@baidu.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> Liam.Howlett@oracle.com; anjali.k.kulkarni@oracle.com; leon@kernel.org;
> fw@strlen.de; shayagr@amazon.com; idosch@nvidia.com;
> razor@blackwall.org; linyunsheng@huawei.com; netdev@vger.kernel.org
> Subject: Re: [PATCH][net-next][v2] rtnetlink: instroduce vnlmsg_new and u=
se it
> in rtnl_getlink
>=20
> On Tue, 14 Nov 2023 17:55:22 +0800 Li RongQing wrote:
> > -	nskb =3D nlmsg_new(if_nlmsg_size(dev, ext_filter_mask), GFP_KERNEL);
> > +	nskb =3D vnlmsg_new(if_nlmsg_size(dev, ext_filter_mask));
>=20
> Why vnlmsg_new()? nlmsg_ is a prefix, for netlink message.
> prefixes do not combine like you're trying to make them.
> Can you call it nlmsg_new_large() or similar?

I will rename it as nlmsg_new_large


>=20
> >  	if (nskb =3D=3D NULL)
>=20
> You need to fix the alignment of the continuation line.
> Perhaps it now fits in 80chars so line break is not needed?

Line break is not needed,

Thanks

-Li

