Return-Path: <netdev+bounces-18932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA87591BC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57C61C20E05
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834911CB8;
	Wed, 19 Jul 2023 09:35:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960511C8E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A4CC433C7;
	Wed, 19 Jul 2023 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689759313;
	bh=vsamswljwBhG+Oj+tc9UBFitB0CaGnREdpOTF1Vs9Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi0uzYct84FmJlqVENNxUuFYHjjr/sxwMnZoYyZeperIdSGBoXyUQlMwEdutj0g+i
	 b1koTP+gnd2O7jfH4IEKRHkm5h5ZQSXke08c16mdzlolH/c+SpFkjywGOgvOL5wgO9
	 Jm/FJPTlGgXq20cU/LXW6tdyKzdcnNIfhxeDG0TqnCnOgwDScxctbZkpE2/eLTZ821
	 SRdtusdJ7onypi70bO0hh2HMR0AtZeTbD6vawVoRRsBrSbjBC+IKozMmKwMXuRMdlU
	 m1oVtW7qxjvSrzRNrzR+C8c6/5qIzMbTCLrq+CzkdDPqZnenu6n5vRCaoYGQLl0LJq
	 M6MzBbm2EyISQ==
Date: Wed, 19 Jul 2023 12:35:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Louis Peens <louis.peens@corigine.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <simon.horman@corigine.com>,
	Shihong Wang <shihong.wang@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next 1/2] xfrm: add the description of
 CHACHA20-POLY1305 for xfrm algorithm description
Message-ID: <20230719093509.GJ8808@unreal>
References: <20230719091830.50866-1-louis.peens@corigine.com>
 <20230719091830.50866-2-louis.peens@corigine.com>
 <ZLesfwnwXZ22A0fA@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLesfwnwXZ22A0fA@gauss3.secunet.de>

On Wed, Jul 19, 2023 at 11:27:27AM +0200, Steffen Klassert wrote:
> On Wed, Jul 19, 2023 at 11:18:29AM +0200, Louis Peens wrote:
> > From: Shihong Wang <shihong.wang@corigine.com>
> > 
> > Add the description of CHACHA20-POLY1305 for xfrm algorithm description
> > and set pfkey_supported to 1 so that xfrm supports that the algorithm
> > can be offloaded to the NIC.
> > 
> > Signed-off-by: Shihong Wang <shihong.wang@corigine.com>
> > Acked-by: Simon Horman <simon.horman@corigine.com>
> > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> > ---
> >  include/uapi/linux/pfkeyv2.h | 1 +
> >  net/xfrm/xfrm_algo.c         | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/pfkeyv2.h b/include/uapi/linux/pfkeyv2.h
> > index 8abae1f6749c..d0ab530e1069 100644
> > --- a/include/uapi/linux/pfkeyv2.h
> > +++ b/include/uapi/linux/pfkeyv2.h
> > @@ -331,6 +331,7 @@ struct sadb_x_filter {
> >  #define SADB_X_EALG_CAMELLIACBC		22
> >  #define SADB_X_EALG_NULL_AES_GMAC	23
> >  #define SADB_X_EALG_SM4CBC		24
> > +#define SADB_X_EALG_CHACHA20_POLY1305	25
> 
> Please don't add new stuff to pfkey, use netlink instead. This interface
> is deprecated and will go away someday

Steffen, I have general questions.
From where did all these SADB_X_EALG_* values come?
And there are they used?

As an exercise, I checked SADB_X_EALG_SM4CBC usage in github and didn't
find anything.
https://github.com/search?q=SADB_X_EALG_SM4CBC&type=code

Thanks


> 
> 

