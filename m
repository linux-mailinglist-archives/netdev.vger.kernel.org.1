Return-Path: <netdev+bounces-157275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34DA09DB3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37457188D718
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96E20ADD1;
	Fri, 10 Jan 2025 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="IWFbjvaR"
X-Original-To: netdev@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B883208978;
	Fri, 10 Jan 2025 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547740; cv=none; b=ZefM9+jgYaTyw/nSMSWgDURXBvKEy8OvKwDT1q3rkPeypD1YJWqAWnAtwBASAVGHdF6IE94RBscbFlYMUVFDHGFRv/G2B6sLxUVLZKJq8R0Ox9PzFi83781oAzcBgxmzWwPT0jjpLCt8zWqCCWunqy60nHvTlBwGCOnCIKbz/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547740; c=relaxed/simple;
	bh=WoyLhPAJ2/3wIE773vQV7jqXpKS+poa4F4cfWpggudU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAnOh1eNw3xC/1gTnjLNec0uZ126w9VFZ5erBSk1oAZ5JdMamtUOqHS4qALn9MmRJeHCtcBMzRqa5zm1kKhLIqQtEOV/vSOqyRfmP8EkAf2gRGw1hjyH6f19FBZh3WZmld6Rt2piHfbpTjEcqbstes9SGHJBNK82Mx6DC/BfZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=IWFbjvaR; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RtS/od1OTJJw3DmEHKDb7MLkq2M1cFP0eCP4sEV8ha4=; b=IWFbjvaRrTRH7tfXpl/Loc0XGi
	bg9Vk8iwOzEjF78+zZKM1msEVBcXkgQvtpVHPj6Xu4tiLnfn7PTfh3QKf/oSEpWvxajc5WsTKK5tv
	1nj1NudvP4fiH4Ig59HoPWmFMKHpvmrfFYreQ0VuD6Hvf2v/1AM9AuHbacgf6m8WV5K4=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWNOQ-000000003uX-2nZm;
	Fri, 10 Jan 2025 23:22:16 +0100
Message-ID: <253f7ca1-758a-40f1-aeda-411a6a68e31d@engleder-embedded.com>
Date: Fri, 10 Jan 2025 23:22:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] virtio_net: Hold RTNL for NAPI to queue
 mapping
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250110202605.429475-1-jdamato@fastly.com>
 <20250110202605.429475-3-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250110202605.429475-3-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes


On 10.01.25 21:26, Joe Damato wrote:
> Prepare for NAPI to queue mapping by holding RTNL in code paths where
> NAPIs will be mapped to queue IDs and RTNL is not currently held.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/virtio_net.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cff18c66b54a..4e88d352d3eb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2803,11 +2803,17 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
>   	local_bh_enable();
>   }
>   
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +static void virtnet_napi_enable_lock(struct virtqueue *vq,
> +				     struct napi_struct *napi)
>   {
>   	virtnet_napi_do_enable(vq, napi);
>   }
>   
> +static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +{
> +	virtnet_napi_enable_lock(vq, napi);
> +}
> +
>   static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>   				   struct virtqueue *vq,
>   				   struct napi_struct *napi)
> @@ -2844,7 +2850,7 @@ static void refill_work(struct work_struct *work)
>   
>   		napi_disable(&rq->napi);
>   		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> -		virtnet_napi_enable(rq->vq, &rq->napi);
> +		virtnet_napi_enable_lock(rq->vq, &rq->napi);
>   
>   		/* In theory, this can happen: if we don't get any buffers in
>   		 * we will *never* try to fill again.
> @@ -5621,8 +5627,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>   	netif_tx_lock_bh(vi->dev);
>   	netif_device_detach(vi->dev);
>   	netif_tx_unlock_bh(vi->dev);
> -	if (netif_running(vi->dev))
> +	if (netif_running(vi->dev)) {
> +		rtnl_lock();
>   		virtnet_close(vi->dev);
> +		rtnl_unlock();
> +	}
>   }
>   
>   static int init_vqs(struct virtnet_info *vi);
> @@ -5642,7 +5651,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>   	enable_rx_mode_work(vi);
>   
>   	if (netif_running(vi->dev)) {
> +		rtnl_lock();
>   		err = virtnet_open(vi->dev);
> +		rtnl_unlock();
>   		if (err)
>   			return err;
>   	}

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

