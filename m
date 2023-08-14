Return-Path: <netdev+bounces-27334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ACA77B82E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A1128110A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA7BA56;
	Mon, 14 Aug 2023 12:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646523D0
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00DEC433C7;
	Mon, 14 Aug 2023 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692014719;
	bh=FbT2dGK+KjdiPggXst+c0SjzNrm3X6tj0alE8n8blc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z02heUrNzW4mdGNQuujm4F0j2KYvG9Qt71nlXUi/p9zou8bCpfWjhPIN4TPkl4xMg
	 07xfW4f7OoByaGluZLFIBcFq/C68ovyku8OXbrWpQyhvJwhIm6dn7dNMFm4kCMBiDO
	 yLoS3++zqiWHF996sVS9GbKC5uHwEcCHB7TmcRbXG8bgoIskk4uPulA2UD//GWI+to
	 PEgkWRVcgcwVy71KPCv3o7eXvmVYm3GRNF6GLZxdxrTa+fvp2ylVtymEYjaA/+hYdA
	 B3GeCmKd3/CfzRomfOVGscK0fpAeE+USwtZMqhEPQQr5bo9TilvXA2ZMoaeK3D+6kd
	 Jog7geFyn2rKA==
Date: Mon, 14 Aug 2023 15:05:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tun: add __exit annotations to module exit func
 tun_cleanup()
Message-ID: <20230814120515.GH3921@unreal>
References: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
 <20230814101707.GG3921@unreal>
 <0b8a2c5f-0d53-f5e5-f148-b333c0c89a14@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8a2c5f-0d53-f5e5-f148-b333c0c89a14@huawei.com>

On Mon, Aug 14, 2023 at 07:27:59PM +0800, Ziyang Xuan (William) wrote:
> > On Mon, Aug 14, 2023 at 04:30:00PM +0800, Ziyang Xuan wrote:
> >> Add missing __exit annotations to module exit func tun_cleanup().
> >>
> >> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> >> ---
> >>  drivers/net/tun.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 973b2fc74de3..291c118579a9 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -3740,7 +3740,7 @@ static int __init tun_init(void)
> >>  	return ret;
> >>  }
> >>  
> >> -static void tun_cleanup(void)
> >> +static void __exit tun_cleanup(void)
> > 
> > Why __exit and not __net_exit?
> 
> tun_cleanup() is a module exit function. it corresponds to tun_init().
> tun_init() uses __init, so tun_cleanup() uses __exit.

__net_init is equal to __init.

> 
> Thank you!
> William Xuan
> > 
> > Thanks
> > 
> >>  {
> >>  	misc_deregister(&tun_miscdev);
> >>  	rtnl_link_unregister(&tun_link_ops);
> >> -- 
> >> 2.25.1
> >>
> >>
> > .
> > 

