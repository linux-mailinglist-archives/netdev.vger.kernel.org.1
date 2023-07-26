Return-Path: <netdev+bounces-21337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5F763505
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89023281DA4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7230AD3D;
	Wed, 26 Jul 2023 11:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF90AD42
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB8C433C7;
	Wed, 26 Jul 2023 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690371168;
	bh=UCA/zUEUlPK15DIXEbNn3z5Vb1Gy3GK4OStI8Ik/d2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xob9Gc/c6cn2oSecJNvZOs1+fENSRgcpXx9dnUov/fI3/5uD6hcbZh3eQjGc+InFt
	 wgTqR//YwWmltumg5cqjMX//RXWSgwhp6IuBIo/aeZIdfGzMijXNTEqsNfoQKV82kH
	 qNjj+OcQCD3gZLnsCWrgtKy/PunC0CSUlkfn24aw=
Date: Wed, 26 Jul 2023 13:32:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Ming <machel@vivo.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH net v5] bonding: Remove error checking for
 debugfs_create_dir()
Message-ID: <2023072633-backpedal-hunger-0a2e@gregkh>
References: <20230726112913.4393-1-machel@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726112913.4393-1-machel@vivo.com>

On Wed, Jul 26, 2023 at 07:29:00PM +0800, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in bond_debug_reregister().
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/bonding/bond_debugfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
> index 594094526..a41f76542 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -87,9 +87,6 @@ void bond_debug_reregister(struct bonding *bond)
>  void bond_create_debugfs(void)
>  {
>  	bonding_debug_root = debugfs_create_dir("bonding", NULL);
> -
> -	if (!bonding_debug_root)
> -		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>  }
>  
>  void bond_destroy_debugfs(void)
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

