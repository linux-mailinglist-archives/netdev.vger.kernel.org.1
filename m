Return-Path: <netdev+bounces-127040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F270973CD0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623B11C212D1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710019F47E;
	Tue, 10 Sep 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vu69pIpw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453219E827;
	Tue, 10 Sep 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983920; cv=none; b=LIuDxPZCSg8VvpPuwjLZ9LNy2m4gv+DgLrYLolhLgl8LQVmQcMqm5EYWG9TDdhn/708Ug/J/RU78nkb2syVXjoHBa2sqaBOGn8L9ftLXeY3byTwfoE/2yOSxAIjuEYXIVRn/ZTbCO61Cdj+4FCb5uVF4yr6k4s1u7pZiND/2GkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983920; c=relaxed/simple;
	bh=JLJaCOiABB/oP/JYn7vUsmEd/L1StlhDnijFrQJ2s7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuVQTGWxh6SQQtE6053apULsX8Zo/eccKTjZPszZB4vm9aydHYUNL/oYrmtgAOzpy+L9idPpW+8KUPRA+k0YyslY10Woaz9b25AgqrZ6E//LZbSQUohGjVxvLw9Tdi0WVIiDECsHV/AYwmAnotj0Wmaesh3Mw/q6sVl790uYYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vu69pIpw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QDxDa9XCwWgMAD9MF1Dm8QsW5pDstiAmlvOyC9GXuKU=; b=Vu69pIpwOJbG/4sxBpf8rxtsMU
	EZ7eu/YM/PHyBUOGEtkI3nGgGrzP7Q2ET9GLiuRPP5Q+Cs+ueavD0Ii0LjXQMvJg19r5nv59PuAtE
	oi/N7lybsEMC22fitMpxgZ1boY/LAG2QOTgEYqt/brs5oIBLPG+3vhSPXSoH/quDfho4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1so3G2-0077k0-O0; Tue, 10 Sep 2024 17:58:22 +0200
Date: Tue, 10 Sep 2024 17:58:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] net: ag71xx: remove dead code path
Message-ID: <196dc563-85ec-491d-8e2e-8749f3b07ff4@lunn.ch>
References: <20240910152254.21238-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910152254.21238-1-qianqiang.liu@163.com>

On Tue, Sep 10, 2024 at 11:22:54PM +0800, Qianqiang Liu wrote:
> The 'err' is always zero, so the following branch can never be executed:
> if (err) {
> 	ndev->stats.rx_dropped++;
> 	kfree_skb(skb);
> }
> Therefore, the 'if' statement can be removed.

This code was added by Oleksij Rempel <o.rempel@pengutronix.de>. It is
good to Cc: him, he might have useful comments.

Your changed does look correct, but maybe ret was actually supposed to
be set somewhere? Is there an actual bug hiding here somewhere?

     Andrew

> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index 96a6189cc31e..5477f3f87e10 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1616,7 +1616,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
>  		unsigned int i = ring->curr & ring_mask;
>  		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
>  		int pktlen;
> -		int err = 0;
>  
>  		if (ag71xx_desc_empty(desc))
>  			break;
> @@ -1646,14 +1645,9 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
>  		skb_reserve(skb, offset);
>  		skb_put(skb, pktlen);
>  
> -		if (err) {
> -			ndev->stats.rx_dropped++;
> -			kfree_skb(skb);
> -		} else {
> -			skb->dev = ndev;
> -			skb->ip_summed = CHECKSUM_NONE;
> -			list_add_tail(&skb->list, &rx_list);
> -		}
> +		skb->dev = ndev;
> +		skb->ip_summed = CHECKSUM_NONE;
> +		list_add_tail(&skb->list, &rx_list);
>  
>  next:
>  		ring->buf[i].rx.rx_buf = NULL;
> -- 
> 2.39.2
> 
> 

