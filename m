Return-Path: <netdev+bounces-160127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E651A18604
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 21:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD773A9612
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB651BDA99;
	Tue, 21 Jan 2025 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Sx7IT4EW"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE34594A;
	Tue, 21 Jan 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490702; cv=none; b=GIy6phxtXFrxMRHYFKmuR0jRz/CkujKr52ExaZnWHJ6N8TEQlNL7eUupy6QSDPD4ECvWT8GqISs4s0TK8FPpeIlNmdO1+vdZJDauVErjNIiMHvwkXHHa/HE+ZTh8dPOH7K+All8XZ+Z1RqvQrgxGGxJBtLthByDidywPU+qnYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490702; c=relaxed/simple;
	bh=aBf8pcpfISOX5E2A4ZFLSTA3RCDLnTvs+QKm9xw1dk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQX4q4MB1OGtN+wlNSksn3GREQ0j1Qm2Gsl0I68tWaweRPcw7jGp3R7jAbHV/D9Cln/ZoJcskhBpGLhlVI/5PrJPq9CQhOCThbIO1VUzBAz2ItEUmgyAJcbqPV1mRPeBiiJqA6iSaENWbu6IawbVyDrn4HqiKUPpJujqeVW5GTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Sx7IT4EW; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ha4YjCaFvmJ5twOiNCjirJfl+KA+frV5RLEO3KLb4bM=; b=Sx7IT4EWMLTbFA+d02+BlTD7tn
	ezhDSIBR7YzrR2V8VUgbZeR4u0RdzMzo6PwbwxAYEkSzqupSyYKvtX9pkdifg3fETi1vPPjumpHAN
	VY4JfK76jV6M+Sy6K6Llpq/WLmm6YW1LrnK3GvMVdrb+XQIJp9ERF114678bootX0Ps0=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1taKhW-000000002Q3-36EH;
	Tue, 21 Jan 2025 21:18:18 +0100
Message-ID: <f837b473-80e3-4e53-9b8a-39209247c6ea@engleder-embedded.com>
Date: Tue, 21 Jan 2025 21:18:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 4/4] virtio_net: Use persistent NAPI config
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: jasowang@redhat.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
 mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-5-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250121191047.269844-5-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 21.01.25 20:10, Joe Damato wrote:
> Use persistent NAPI config so that NAPI IDs are not renumbered as queue
> counts change.
> 
> $ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
> Current hardware settings:
> Combined:       4
> 
> $ ./tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/netdev.yaml \
>      --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'type': 'tx'},
>   {'id': 2, 'ifindex': 2, 'type': 'tx'},
>   {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> 
> Now adjust the queue count, note that the NAPI IDs are not renumbered:
> 
> $ sudo ethtool -L ens4 combined 1
> $ ./tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/netdev.yaml \
>      --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'type': 'tx'}]
> 
> $ sudo ethtool -L ens4 combined 8
> $ ./tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/netdev.yaml \
>      --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>   {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>   {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>   {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
>   {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
>   [...]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   rfcv3:
>     - Added Xuan Zhuo's Reviewed-by tag. No functional changes.
> 
>   v2:
>     - Eliminate RTNL code paths using the API Jakub introduced in patch 1
>       of this v2.
>     - Added virtnet_napi_disable to reduce code duplication as
>       suggested by Jason Wang.
> 
>   drivers/net/virtio_net.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c120cb2106c0..e0752a856adf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6411,8 +6411,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>   	INIT_DELAYED_WORK(&vi->refill, refill_work);
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>   		vi->rq[i].pages = NULL;
> -		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
> -				      napi_weight);
> +		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
> +				      i);
> +		vi->rq[i].napi.weight = napi_weight;
>   		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
>   					 virtnet_poll_tx,
>   					 napi_tx ? napi_weight : 0);

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

