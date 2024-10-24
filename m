Return-Path: <netdev+bounces-138579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBC9AE324
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651721C2220F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6962D1C07C3;
	Thu, 24 Oct 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvpS2dnz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE414831C
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767313; cv=none; b=R1QmbS//zMXhng+o4y3/KBiCTU4MRE1fFNijmz4V/NJ+OxwcupIGyNFTDyvIvj0BjMJj+gJhuOyWuqzIEA4QesLzmHILAIK6BBXW2SDbvc14YdgrgNocc7HDZgCWBO1CJycvbb7HJevaniEEsjkW29JKOsfEWimLDy1IFavLLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767313; c=relaxed/simple;
	bh=hDTvFDbEBfD6VwZVlMN8QpXpqPX/ZzCaQXlWMbV77PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCUgovf58uRoHjwvEyBEkvSOMAWttCYrgvBs3d+BRSUmjIut726qYqvIfzzFoctUXmlxPbaYu8ZhMD0/4kRR8rgQ0q5vToZGXEkCD6q7y+94kE+OazJBjm7H92fcHsyFmUZ6h9tm2GxqG4mg7FpY54cXx6eB38Yf7AMZ+vapGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvpS2dnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F04C4CEC7;
	Thu, 24 Oct 2024 10:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767312;
	bh=hDTvFDbEBfD6VwZVlMN8QpXpqPX/ZzCaQXlWMbV77PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvpS2dnzg5Q12Oz015qUoIl6fcOni6EigpoSMIYMGBiTHBVwl3ILpmliVOihN7szn
	 4jPK/Qqyh1RrMmIEXGh4QzztAg6b7YBGd4I6aSwcsaBtdwq0LZonCf/t+5p6GSPZlq
	 Vh8YumQYwfH57XJAApJFbe+dvr8kt9pfSHzdW6U7MlVxannU9GXMWETVQ+88zKmxta
	 p1vG6fZGd4f6r8xz8a9CKWM+T9y1hOtr5Wxk0DztuaxA1L4C68kTtwq/LrML8dHKYx
	 iahwkVxAr7YA/yu0L3gh6dKFr8B7ntUdNqMLeTrG1d/cyf7Dup7EMUjPwgJnXssPpV
	 NDFY5/FhtnMkQ==
Date: Thu, 24 Oct 2024 11:55:08 +0100
From: Simon Horman <horms@kernel.org>
To: Gax-c <zichenxie0106@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, petrm@nvidia.com,
	idosch@nvidia.com, netdev@vger.kernel.org, zzjas98@gmail.com,
	chenyuan0y@gmail.com
Subject: Re: [PATCH v2] netdevsim: Add trailing zero to terminate the string
 in nsim_nexthop_bucket_activity_write()
Message-ID: <20241024105508.GA1202098@kernel.org>
References: <20241022171907.8606-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022171907.8606-1-zichenxie0106@gmail.com>

On Tue, Oct 22, 2024 at 12:19:08PM -0500, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> This was found by a static analyzer.
> We should not forget the trailing zero after copy_from_user()
> if we will further do some string operations, sscanf() in this
> case. Adding a trailing zero will ensure that the function
> performs properly.
> 
> Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> ---
> v2: adjust code format.
> ---
>  drivers/net/netdevsim/fib.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
> index 41e80f78b316..16c382c42227 100644
> --- a/drivers/net/netdevsim/fib.c
> +++ b/drivers/net/netdevsim/fib.c
> @@ -1377,10 +1377,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
>  
>  	if (pos != 0)
>  		return -EINVAL;
> -	if (size > sizeof(buf))
> +	if (size > sizeof(buf) - 1)

I don't think this change for the best.
If the input data is well formatted it will end with a '\0'.
Which may be copied into the last byte of buf.

With this change the maximum size of the input data is
unnecessarily reduced by one.

>  		return -EINVAL;
>  	if (copy_from_user(buf, user_buf, size))
>  		return -EFAULT;
> +	buf[size] = 0;
> +
>  	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
>  		return -EINVAL;
>  
> -- 
> 2.34.1
> 
> 

