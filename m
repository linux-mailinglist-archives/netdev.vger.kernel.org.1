Return-Path: <netdev+bounces-206659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F0B03EB3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB794A1D67
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6632C24729A;
	Mon, 14 Jul 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXgFLMuq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE481C3C1F;
	Mon, 14 Jul 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496171; cv=none; b=IiX+6Imp2fYENfFLdYrnDliBEzyfj+VwT6lpTMABVa8ilSCV+L1pWR7FGOa7eTorkwDrTdB1y4G4DyP0Dpe44FUzwpbLIsOKwS8WyE5iFaBh+FwqykW8l+ECMtrp/YDI7vveZDeJU9C21UBvd1phxfnhZwvLOFaNSfBQ1qHLokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496171; c=relaxed/simple;
	bh=RhLNxo06TopDltvNQ10QbOeodkasb358/7Z4dl89McM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbnQp3TXuS18erjIHUbBt9EyBTAwujcIzrOz4l9pO1yUg9vR9EfwfislU9DHfYt00ZPUcwN2LeyxMpya8rzre+cmqcL5TI559BLYyIUQ8cavC40ZReF+g4EVvv6z5tONfwBZ62edpVtieELUx6msI0Oz/KGLOdceRrKsZnfz6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXgFLMuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAE5C4CEED;
	Mon, 14 Jul 2025 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752496170;
	bh=RhLNxo06TopDltvNQ10QbOeodkasb358/7Z4dl89McM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXgFLMuqkqn5DEjEavM0B2VB1BXBSFe+wo79V+YKSEW3Md+KjwnMSxhkYMuom5kb7
	 bIo/dihV+admE+rTBSYeNx+hlW0t3epT1S7tZjOPNWbBDod4VYxvHn2eQol1CycNWg
	 H/ngmkqz0js6BjGA/f13Q987HtmaVTGWbvnUP727FLoOMfEHJdj9aRtoVVDm9IppGA
	 zIaayIhW9+ZoeYfz5rdjfkeNFvdNrPn+e8lZFGtAS+LC0+MUzXc97mXDQav34ajNNO
	 kdYD2Of/o2Nc36DwYBvnG3ijEAteSPbvhJ11tG57For6MjvirVFPiG0uD3p9GUCV5z
	 YcV+FPYPA8vuQ==
Date: Mon, 14 Jul 2025 13:29:27 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in
 ip6_mc_find_dev()
Message-ID: <20250714122927.GM721198@horms.kernel.org>
References: <20250714081732.3109764-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714081732.3109764-1-yuehaibing@huawei.com>

+ Iwashima-san

On Mon, Jul 14, 2025 at 04:17:32PM +0800, Yue Haibing wrote:
> These is no need to check null for idev before return NULL.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/mcast.c | 3 ---
>  1 file changed, 3 deletions(-)

This appears to be a side effect of
commit e6e14d582dd2 ("ipv6: mcast: Don't hold RTNL for MCAST_ socket options.")

I've CCed Iwashimsa-san, who wrote that patch.

But in any case this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index e95273ffb2f5..8aecdd85a6ae 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -329,9 +329,6 @@ static struct inet6_dev *ip6_mc_find_dev(struct net *net,
>  	idev = in6_dev_get(dev);
>  	dev_put(dev);
>  
> -	if (!idev)
> -		return NULL;
> -
>  	return idev;
>  }
>  
> -- 
> 2.34.1
> 

