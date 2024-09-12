Return-Path: <netdev+bounces-127854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21925976E1B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB7B21594
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C8126BEE;
	Thu, 12 Sep 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q6p+f+A2"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87272C144;
	Thu, 12 Sep 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156012; cv=none; b=DCbxfrXNS5feARoutd9NVZxffrRsHYtge+ckT+16vtnqEmrIQdr2ox+pyxSDANSGbt30M1s20mNTJNEHx1HDtBZpljZMEoVksozbvNIjjQAXEcWxTDA40G16nhwwKadNTI7NqXvk3R5KB8S5UfT5l6q5UUy7rI9doN0LKjJbLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156012; c=relaxed/simple;
	bh=ixe1NwvB+Ap08jHkTseRNdlPRemLsbn7IlJGZ3SgnAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1557ZYejHNf02L49CrRKCGh9PztmVKa/1DZejQi/QnSfnXdvs2LQKdzDkH9sdPlDH946Rk0h75P8pUEHqTR9cxfAOZOk17gDAa9dQjdAIgFwQcuaSpKOwnkuFiWoFWM3gkFJCeumacnTvCVX4U0YNsuClk4NbIoRN7jDpfnsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q6p+f+A2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xxUxrZ1bLLlD2bEmJAo1fVUINGNgaZyWOtszqPfWAa8=;
	b=Q6p+f+A2jMMF74mtVoi1ISK4lSKRD7hOaXO2FQ/EgcMOcjUC5TDU/92iE9omaH
	bHJd8fsw2HFFg6pJEf+4NRqF0lyjXy6wlPDBeZQ+q4U1W1xRwAilsI/VYUMQX/++
	nbDJBGeCbYojlNpoVXHV1k3fZE56a4G8iUUD5YdhJ9/Tk=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wD3_0zKDONm48JaBA--.14683S2;
	Thu, 12 Sep 2024 23:46:18 +0800 (CST)
Date: Thu, 12 Sep 2024 23:46:18 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: kuba@kernel.org
Cc: andrew@lunn.ch, o.rempel@pengutronix.de, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ag71xx: remove dead code path
Message-ID: <ZuMMyv9_npZ8txU8@iZbp1asjb3cy8ks0srf007Z>
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
X-CM-TRANSID:_____wD3_0zKDONm48JaBA--.14683S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45uF18Gr45Xryxtw48tFb_yoW8XrWfpr
	W3KayIgFW0yr1Uta4UZw4xZF98Can0yrZ0grW5X3yFvr1UAryYg3s7KFWUKr1xWrW8Cw4a
	vw18ZFnrAFsxXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j60P-UUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQVYamXAo3-RrgABs1

On Tue, Sep 10, 2024 at 11:22:54PM +0800, Qianqiang Liu wrote:
> The 'err' is always zero, so the following branch can never be executed:
> if (err) {
> 	ndev->stats.rx_dropped++;
> 	kfree_skb(skb);
> }
> Therefore, the 'if' statement can be removed.
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

Hi Jakub,

Could you please review this patch?

-- 
Best,
Qianqiang Liu


