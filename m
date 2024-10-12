Return-Path: <netdev+bounces-134870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657AC99B6A3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B31C20F4B
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546284A4D;
	Sat, 12 Oct 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="ccdlqy93"
X-Original-To: netdev@vger.kernel.org
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306A43173;
	Sat, 12 Oct 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758959; cv=none; b=m3B8QI9F5whrHYN45WLPazKWPEniABdWnlMJi2PaeqOAWj6irG3M2QE/OBUuQNs+p3IahmU0u2aLMKykOnBWAcr5eTOnewM9KAN3k83q7med/82XGXmw+R6i5pXZjrhi28cduh8PSJT+CivsWSTXRdutKxU0hAIp48VfhKtrf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758959; c=relaxed/simple;
	bh=WTOAJxAmlJGtHrKLllDBenmOvdMX8ckNkVnWU2XR9jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlsV9auQAB2QvksSLoJ87p7x/cPaGZBDixCMC6jDCcHIPX1mXQFXttsv7VArmlnX3OMVZnl+78JkjpQIE5fiEmsdw2qIdUJqMTog45hFAQ8/MVm1wrScS2gCN20sl8bzgdKE/eiYGxanmpIeZiB8gc2koraMFhuItHRetEbcwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=ccdlqy93; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=whpQlU3hR2/YXN1DhRTRvCI/ym7MCRC4OzO6uxuM/GY=; b=ccdlqy93TurNdfokQXprfkjeRQ
	mc8SGfgQPyrQlQ6y/VhI/h77wySjL0a/4yYvPYQfG33Nzi956lZT+DpN1QaA2tEBkKtDrxfVDs9vz
	EAJoW82c82G5McGn+0hLK6QCkVxqGGk7e9xHIlef4FcMvK0L40roOwyfaTxvM9bFtWEU=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szgsn-000000002LP-2rRm;
	Sat, 12 Oct 2024 20:30:29 +0200
Message-ID: <75072c5d-9145-492c-b99a-4f47ae88b069@engleder-embedded.com>
Date: Sat, 12 Oct 2024 20:30:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: ethernet: aeroflex: fix potential memory leak
 in greth_start_xmit_gbit()
To: Wang Hai <wanghai38@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kristoffer@gaisler.com, zhangxiaoxu5@huawei.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andreas@gaisler.com
References: <20241012110434.49265-1-wanghai38@huawei.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20241012110434.49265-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.10.24 13:04, Wang Hai wrote:
> The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb() to fix it.
> 
> Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: Using dev_kfree_skb() in error handling.
>   drivers/net/ethernet/aeroflex/greth.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
> index 27af7746d645..adf6f67c5fcb 100644
> --- a/drivers/net/ethernet/aeroflex/greth.c
> +++ b/drivers/net/ethernet/aeroflex/greth.c
> @@ -484,7 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
>   
>   	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
>   		dev->stats.tx_errors++;
> -		goto out;
> +		goto len_error;
>   	}
>   
>   	/* Save skb pointer. */
> @@ -575,6 +575,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
>   map_error:
>   	if (net_ratelimit())
>   		dev_warn(greth->dev, "Could not create TX DMA mapping\n");
> +len_error:
>   	dev_kfree_skb(skb);
>   out:
>   	return err;

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

