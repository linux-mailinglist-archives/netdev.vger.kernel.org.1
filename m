Return-Path: <netdev+bounces-157276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18265A09DBB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C819B7A1D2A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620192144AD;
	Fri, 10 Jan 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="E6Khc7bb"
X-Original-To: netdev@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07B1ACEB8;
	Fri, 10 Jan 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547945; cv=none; b=K/2lxRbeb9bmdeucnW90tEhxaXC/QvyK6wMhKDDtCyxbDT7Q5gvNy2SEjg0FWUAouAP4RFbpHtzODsUFjwSR0FltGy3YOBtfwC2j74mJuht4GM8gOPYV9upUoLCrQMaikrhTbO2BNeVHUaMKFkpl135uWrlrmi0CzXnsNzQQXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547945; c=relaxed/simple;
	bh=3cZLhoahw8tAhdHLTxjwPoTAopgoXI8pIV8h8cojALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9z6T6e2P1eq1wlEVkA9w+ahHA3l0t5NP0QXTseEDbQ9qyxj15zGf7Nhhxlsf+rXOKSgrEE7fWT6Nq4VKSfqq17h6mP9MkgTqtfhsJTHayqSLO6PffjPAwgNh866OPml5NBYQAsvtpNhoREnGzcG1wbYLYfGwV9Q+oR/Hc2Fyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=E6Khc7bb; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1DatnNNBXnD3NcaK7p7SNN7CWvmL/nLa4x627eCUijE=; b=E6Khc7bbIpN+J0vATj6IurrxHv
	mjMSmvGSuUbb0IQdzVVy/8TQxw9mxgJnlXtN/ilWu6/LXpLp1AXUtrtacEi6jK9le8n2mpW7gX1/l
	ilqQ/xbglPkKRuCSe5YEnbc3AV+EpmYdmGUG9+nko3lyJAT4jRpn8rsMzAtJlXihZGag=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWNRk-000000004dT-0GSY;
	Fri, 10 Jan 2025 23:25:41 +0100
Message-ID: <60af36b0-a835-4ba1-994d-2aad527ed4e5@engleder-embedded.com>
Date: Fri, 10 Jan 2025 23:25:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
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
 <20250110202605.429475-4-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250110202605.429475-4-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 10.01.25 21:26, Joe Damato wrote:
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
> 
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
> 
> $ sudo ethtool -L ens4 combined 4
> 
> $ ./tools/net/ynl/pyynl/cli.py \
>         --spec Documentation/netlink/specs/netdev.yaml \
>         --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'type': 'tx'},
>   {'id': 2, 'ifindex': 2, 'type': 'tx'},
>   {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> 
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4e88d352d3eb..8f0f26cc5a94 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2804,14 +2804,28 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
>   }
>   
>   static void virtnet_napi_enable_lock(struct virtqueue *vq,
> -				     struct napi_struct *napi)
> +				     struct napi_struct *napi,
> +				     bool need_rtnl)
>   {
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int q = vq2rxq(vq);
> +
>   	virtnet_napi_do_enable(vq, napi);
> +
> +	if (q < vi->curr_queue_pairs) {
> +		if (need_rtnl)
> +			rtnl_lock();
> +
> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> +
> +		if (need_rtnl)
> +			rtnl_unlock();
> +	}
>   }
>   
>   static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
>   {
> -	virtnet_napi_enable_lock(vq, napi);
> +	virtnet_napi_enable_lock(vq, napi, false);
>   }
>   
>   static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> @@ -2848,9 +2862,13 @@ static void refill_work(struct work_struct *work)
>   	for (i = 0; i < vi->curr_queue_pairs; i++) {
>   		struct receive_queue *rq = &vi->rq[i];
>   
> +		rtnl_lock();
> +		netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> +		rtnl_unlock();
>   		napi_disable(&rq->napi);
> +
>   		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> -		virtnet_napi_enable_lock(rq->vq, &rq->napi);
> +		virtnet_napi_enable_lock(rq->vq, &rq->napi, true);
>   
>   		/* In theory, this can happen: if we don't get any buffers in
>   		 * we will *never* try to fill again.
> @@ -3048,6 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>   static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>   {
>   	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +	netif_queue_set_napi(vi->dev, qp_index, NETDEV_QUEUE_TYPE_RX, NULL);
>   	napi_disable(&vi->rq[qp_index].napi);
>   	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>   }
> @@ -3317,8 +3336,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>   static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>   {
>   	bool running = netif_running(vi->dev);
> +	int q = vq2rxq(rq->vq);
>   
>   	if (running) {
> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
>   		napi_disable(&rq->napi);
>   		virtnet_cancel_dim(vi, &rq->dim);
>   	}
> @@ -5943,6 +5964,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   	/* Make sure NAPI is not using any XDP TX queues for RX. */
>   	if (netif_running(dev)) {
>   		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX,
> +					     NULL);
>   			napi_disable(&vi->rq[i].napi);
>   			virtnet_napi_tx_disable(&vi->sq[i].napi);
>   		}

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

