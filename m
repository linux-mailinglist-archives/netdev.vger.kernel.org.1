Return-Path: <netdev+bounces-157309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE281A09E9D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E2A16B6F7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690A221D9E;
	Fri, 10 Jan 2025 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="jJDpReDn"
X-Original-To: netdev@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF65221D82;
	Fri, 10 Jan 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736550418; cv=none; b=HCJ0Eed9QFBljaDRZOviF5bq6D3aawQfdqwn58+Vl2AKLES+iP/uPDcAzAF9rzh6RkxQkbv0YdQPiJTL9r9qmR/64NSE2JVj0VMLQpU7VynRM708AGpcqBkBFVb81TybKzw9r965AIqvyKkJmpI3LQJ1KyITwGTbHL7upFcqv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736550418; c=relaxed/simple;
	bh=7bVyhUkOUmdxXhBTntK4B9SLDUUw6qekQTdQcvk+6I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUWuU9u7WGWW1hH2Zg9Bvp5FB3r0FYQw/aL3YYSnwZSDbQ2oGNuyLv/NW5jQqI+49bD7L39CDfcZ4H8A0S6hMZhD9GD9RfC4zFZzGVcC9q95oI0mIWk04iTE+7anSeT5JiCDo8fWioVYTVfEcm01bZrD0nn9fH9dVORaYqXuIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=jJDpReDn; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2NaWeoONQwEPrslOdzU18dxIg5ue4NuE8CgSqzKfz+w=; b=jJDpReDn/ax6joK9ZJ+BBibOqG
	z/29J2w9eO953RP9ToEMpDDFqqLLU5u5dMhng0asgxsnrLCFKI4obZq4KMD4r+nyRH8EakerV8Vup
	3YDFltg5HNlZiN8AvAHqxpG045cgvHnWKeqJ3WISiKWoNjNc8GmXpT2iL40yXuz/e8eU=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWNNr-000000003nJ-2QII;
	Fri, 10 Jan 2025 23:21:40 +0100
Message-ID: <ed648ed1-8696-4120-a6f3-db1f325147b4@engleder-embedded.com>
Date: Fri, 10 Jan 2025 23:21:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] virtio_net: Prepare for NAPI to queue
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
 <20250110202605.429475-2-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250110202605.429475-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 10.01.25 21:26, Joe Damato wrote:
> Slight refactor to prepare the code for NAPI to queue mapping. No
> functional changes.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/virtio_net.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..cff18c66b54a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
>   	virtqueue_napi_schedule(&rq->napi, rvq);
>   }
>   
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +static void virtnet_napi_do_enable(struct virtqueue *vq,
> +				   struct napi_struct *napi)
>   {
>   	napi_enable(napi);
>   
> @@ -2802,6 +2803,11 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
>   	local_bh_enable();
>   }
>   
> +static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +{
> +	virtnet_napi_do_enable(vq, napi);
> +}
> +
>   static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>   				   struct virtqueue *vq,
>   				   struct napi_struct *napi)
> @@ -2817,7 +2823,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>   		return;
>   	}
>   
> -	return virtnet_napi_enable(vq, napi);
> +	virtnet_napi_do_enable(vq, napi);
>   }
>   
>   static void virtnet_napi_tx_disable(struct napi_struct *napi)

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

