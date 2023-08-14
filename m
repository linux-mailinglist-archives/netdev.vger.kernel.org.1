Return-Path: <netdev+bounces-27301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F877B65B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291B91C209F2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7153AD51;
	Mon, 14 Aug 2023 10:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ECB8F77
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E340C433C8;
	Mon, 14 Aug 2023 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692008231;
	bh=R4RIz0crQa3HblhWK5yDOqA+zzPG0nqc9QqBWCxcGHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjy5ImfY0I3gO3HW2Dty1baXzNqc8rndVVLUupda4zlAQmGtnl3k/8Fseibcc0PwR
	 BSJFim8T79H3Cs3zgWRBmfht4rH7oyYicXR1XyBiFEylxL3esjlqSBjWZMjTJ+GXZ4
	 IZMGBO+D9LMUxzF6BfNR4W40UoH/SDqwVv6/lWKJjcCsW4fWDsxzbot77XuWjpKOdn
	 nOq34LBaC2Y2oHxnsjCHOoumxLq5xXJb+O0y/iuluwcF+Cxq82+gwpRDl1SCXQFZUu
	 zFHD8Q8rjcd8WeMytdm7N3KsR9dN6D04hKn8ZpoSnoNGv3zOvbJlnEYY2QpRwD1yaF
	 DUVG5VuRHiwyg==
Date: Mon, 14 Aug 2023 13:17:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tun: add __exit annotations to module exit func
 tun_cleanup()
Message-ID: <20230814101707.GG3921@unreal>
References: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814083000.3893589-1-william.xuanziyang@huawei.com>

On Mon, Aug 14, 2023 at 04:30:00PM +0800, Ziyang Xuan wrote:
> Add missing __exit annotations to module exit func tun_cleanup().
> 
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 973b2fc74de3..291c118579a9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3740,7 +3740,7 @@ static int __init tun_init(void)
>  	return ret;
>  }
>  
> -static void tun_cleanup(void)
> +static void __exit tun_cleanup(void)

Why __exit and not __net_exit?

Thanks

>  {
>  	misc_deregister(&tun_miscdev);
>  	rtnl_link_unregister(&tun_link_ops);
> -- 
> 2.25.1
> 
> 

