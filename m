Return-Path: <netdev+bounces-37638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE17B66A5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 387E0281646
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E6134D0;
	Tue,  3 Oct 2023 10:44:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D142D516
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08610C433C8;
	Tue,  3 Oct 2023 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696329891;
	bh=qXnD6pzcI1FwgXP0GfEI9XgrjQyk4vcg/50PoYtUKH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkGH2UoN9EZPNQGovmd77/YXDupulAqwmwkNSrlhfdWkS+oI/PRdOOzWqujwxCXfw
	 FKihICWqmxs3eDF6EBVgb0gvszvF6Zo265l71dEjXrblEgiqsWpkC1K9Qljofbihvj
	 KQ6xyPSCHu5kCIOPAKWyc4UyT8Y4gASTkbafjpEzeW49IyPJBi8C6VuEHVnfiOyn2q
	 9bMsIDrld+m6goRci86YUkXBEMaE5zFtVSSBcTFAOesLYZOPinVyTw0IC624A8HBEX
	 kqMLI6BnspTjRrA7pIFzCn/ApTnsMQ9JGiqCSPxy9N/e9L/aL0k0JP2ihf07g3Mrsf
	 /QZAFnZwsHUqg==
Date: Tue, 3 Oct 2023 12:44:47 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: skbuff: fix kernel-doc typos
Message-ID: <ZRvwn8lTaFxJ83X/@kernel.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
 <20231001003846.29541-2-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001003846.29541-2-rdunlap@infradead.org>

On Sat, Sep 30, 2023 at 05:38:46PM -0700, Randy Dunlap wrote:
> Correct punctuation.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  include/linux/skbuff.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/include/linux/skbuff.h b/include/linux/skbuff.h
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1309,7 +1309,7 @@ struct sk_buff_fclones {
>   *
>   * Returns true if skb is a fast clone, and its clone is not freed.
>   * Some drivers call skb_orphan() in their ndo_start_xmit(),
> - * so we also check that this didnt happen.
> + * so we also check that this didn't happen.

At the risk of bikeshedding (let's not) perhaps "this" can be dropped
from the line above?

In any case, I agree that this patch improves the documentation.

Reviewed-by: Simon Horman <horms@kernel.org>

>   */
>  static inline bool skb_fclone_busy(const struct sock *sk,
>  				   const struct sk_buff *skb)
> @@ -2016,7 +2016,7 @@ static inline struct sk_buff *skb_share_
>   *	Copy shared buffers into a new sk_buff. We effectively do COW on
>   *	packets to handle cases where we have a local reader and forward
>   *	and a couple of other messy ones. The normal one is tcpdumping
> - *	a packet thats being forwarded.
> + *	a packet that's being forwarded.
>   */
>  
>  /**
> 

