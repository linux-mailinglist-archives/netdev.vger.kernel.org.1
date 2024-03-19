Return-Path: <netdev+bounces-80521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4087FA13
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77D31F21B72
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BDF54BE2;
	Tue, 19 Mar 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k13XFDjK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD55380F
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837759; cv=none; b=JKMHK/uQMZED6nQE+ZVm0anaHg2yTWatjWgnpx7h2jLdoCStZak86PTrdjfxDroxIS+Q1gat+kDjE5a5P5AVZzu1519zyKCf0sZdpoTbrRQUjtsqANTwtD2Sphl3XQkeoKOn+UiyBcuiEXgFrpHMNXJVHiJHRKP9dWiboDHh/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837759; c=relaxed/simple;
	bh=URLZf9E/ffxS1vrY1iWFJlKv5DWZ7Ca+KZCfll41/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG0m5QsHl3jMfJXRWUdUcW3i9d+iKwSqQx+D6Fr/U0aUk9MmkHeeSjbXkxQGnZTrcFxVWv1Hf2MEKkg6pfcbi4DtaEVsEGsiykCyPIjg7hluP2wng35OoBQhqsXbl3TR3bcBTL9nmvVvWc7CL8hHlsNH811/wSxnLeowNDPGi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k13XFDjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611CEC433C7;
	Tue, 19 Mar 2024 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710837758;
	bh=URLZf9E/ffxS1vrY1iWFJlKv5DWZ7Ca+KZCfll41/+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k13XFDjKYsG8Za0AC3b329y+9LDqMCTsGZGMpBvugxqIfRO23pOQ3wowB8pysUALQ
	 KNC2ygO1Ho9Cea+EyXrh3QCWakv1I9VfuCQVUcYF3eKUd9lxFSltdN1MHY2L6REc0L
	 frc/RXGWTUsvgy72+Qlv4WlaLB+LHndWNbSjK0E52L31W9V2LJqqL9BcDYGfmpKDvu
	 BtsebG8NahxUz3KqoX7DHhjjx5ZjfVcD+iK4yJQSUKgHjHZkSdHgOYLYVlbWMI1KKj
	 6MY+lsEtccyo+XzNhz+P42meDrW42LCJHnSWrNr5JBZq71aOc3Yf+0uwVEl1vWrA6g
	 q81jgF6HYdaWA==
Date: Tue, 19 Mar 2024 10:42:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <20240319084235.GA12080@unreal>
References: <20240318231328.2086239-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318231328.2086239-1-wangfe@google.com>

On Mon, Mar 18, 2024 at 04:13:28PM -0700, Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> When there are multiple ipsec sessions, packet offload driver
> can use the index to distinguish the packets from the different
> sessions even though xfrm_selector are same. 

Do we have such "packet offload driver" in the kernel tree?

Thanks

> Thus each packet is handled corresponding to its session parameter.
> 
> Signed-off-by: wangfe <wangfe@google.com>
> ---
>  net/xfrm/xfrm_interface_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
> index 21d50d75c260..996571af53e5 100644
> --- a/net/xfrm/xfrm_interface_core.c
> +++ b/net/xfrm/xfrm_interface_core.c
> @@ -506,7 +506,9 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
>  	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
>  	skb_dst_set(skb, dst);
>  	skb->dev = tdev;
> -
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	skb->skb_iif = if_id;
> +#endif
>  	err = dst_output(xi->net, skb->sk, skb);
>  	if (net_xmit_eval(err) == 0) {
>  		dev_sw_netstats_tx_add(dev, 1, length);
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 
> 

