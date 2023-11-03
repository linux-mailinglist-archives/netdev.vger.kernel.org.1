Return-Path: <netdev+bounces-45841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7297DFE93
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 05:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80348B212CF
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F132D602;
	Fri,  3 Nov 2023 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE65238
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 04:43:49 +0000 (UTC)
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98F1A1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 21:43:46 -0700 (PDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path when
 possible
Thread-Topic: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path
 when possible
Thread-Index: AQHaDZx2DjwnGoCXVUiRNSdWa8EgxrBoASeg
Date: Fri, 3 Nov 2023 04:43:40 +0000
Message-ID: <6cadd420741145b897cc18237ce78688@baidu.com>
References: <20231102092712.30793-1-lirongqing@baidu.com>
 <20231102145418.GH92403@linux.alibaba.com>
In-Reply-To: <20231102145418.GH92403@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.206.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM



> -----Original Message-----
> From: Dust Li <dust.li@linux.alibaba.com>
> Sent: Thursday, November 2, 2023 10:54 PM
> To: Li,Rongqing <lirongqing@baidu.com>; linux-s390@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: Re: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path
> when possible
>=20
> On Thu, Nov 02, 2023 at 05:27:12PM +0800, Li RongQing wrote:
> >these is less opportunity that conn->tx_pushing is not 1, since
>=20
> these -> there ?

Yes, thanks

>=20
> >tx_pushing is just checked with 1, so move the setting tx_pushing to 1
> >after atomic_dec_and_test() return false, to avoid atomic_set and
> >smp_wmb in tx path when possible
>=20
> The patch should add [PATCH net-next] subject-prefix since this is an
> optimization.
>=20

OK

> Besides, do you have any performance number ?

Just try a simple performance test,  seems same.

-Li


