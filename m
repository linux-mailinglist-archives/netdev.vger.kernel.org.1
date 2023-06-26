Return-Path: <netdev+bounces-13917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF773DEB3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 14:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12F3280D94
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF98C10;
	Mon, 26 Jun 2023 12:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AF8C0B
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 12:15:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853562966
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687781679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22WmVT+7Zmhki4DbVPIS8XuRnrKCCPWq47wid/h9Rn0=;
	b=VGRp79AUwoVoeGsbUANfuxGHsXOqLrb7vM79IZ9YNqPXN3JQxGhAsqRjjaOXhoMzI/XwZI
	RGBuKIesCBWHJiRqi+nFaLUZhjfMcZkq6UDBXM5HRXXmrtpUsDbA81/cKVgEZCxHBd1dIC
	ouKnsalnRrkrwtWK8MiQWVsjql7ZZEo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-vp-t8XKFPCaQJ6eO1hCHyw-1; Mon, 26 Jun 2023 08:14:37 -0400
X-MC-Unique: vp-t8XKFPCaQJ6eO1hCHyw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb736a7746so818433e87.3
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 05:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687781676; x=1690373676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22WmVT+7Zmhki4DbVPIS8XuRnrKCCPWq47wid/h9Rn0=;
        b=JQC28Pj34kehJiU3jvtyc3mm6xog3CvAsNr/CaFsvH5j9jkTHK7dpIViNvzcXTr932
         UTS4fWUmBpqmq7ls85KN7dRjEFQc2VIU4Yvyomhb+W2H/uU3UFnf8EykuOyfl66Wp1UN
         1VHwdpW7yLlUORFmbEHfgyX9qhvNwiDBeN1f27oUSEFkSsGkB2t3kYmvrzwRSk7bM8vS
         GIUuRzxcaMcY27umnqCpmmZGgTXHYY+kUg5eOl2n2ThARdWOLS4DBC6D8q5mZJllsLHm
         jrgo2j2vLFfNUQ6PJb0P4g/2dm6Ig9pd2KEY6+WQVqKcingLTIRx2gxCt+JGyqMUqQiA
         U0kg==
X-Gm-Message-State: AC+VfDw6Hs7t/vHMr8+/5d+RhS6KG05KW0Xpt2JpZZbwjNRYwAahggMB
	6ktQDFCgsUh+9h+tiIdoRTEUVUyMVXItdcp5bNWPvbhaFry/UKc5fCrQGk0q5Ltc9d4uidoqSUt
	8sn2EAVfTwRDheUDx
X-Received: by 2002:a19:e602:0:b0:4f9:5781:862a with SMTP id d2-20020a19e602000000b004f95781862amr8962202lfh.38.1687781675995;
        Mon, 26 Jun 2023 05:14:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55GtGYtuZHkDMDjKepbhLCFc+83Ou0uEamg9IC7SkfjaY0Zu3aOZfXSgKOYHGrIGxJiQt99A==
X-Received: by 2002:a19:e602:0:b0:4f9:5781:862a with SMTP id d2-20020a19e602000000b004f95781862amr8962188lfh.38.1687781675607;
        Mon, 26 Jun 2023 05:14:35 -0700 (PDT)
Received: from redhat.com ([2.52.156.102])
        by smtp.gmail.com with ESMTPSA id q15-20020a056000136f00b0031122bd3c82sm7249465wrz.17.2023.06.26.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:14:35 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:14:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] virtio-net: remove GUEST_CSUM check for
 XDP
Message-ID: <20230626081418-mutt-send-email-mst@kernel.org>
References: <20230626120301.380-1-hengqi@linux.alibaba.com>
 <20230626120301.380-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626120301.380-3-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 08:03:01PM +0800, Heng Qi wrote:
> XDP and GUEST_CSUM no longer conflict now, so we removed the

removed -> remove

> check for GUEST_CSUM for XDP loading/unloading.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v1->v2:
>   - Rewrite the commit log.
> 
>  drivers/net/virtio_net.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0a715e0fbc97..2e4bd9a05c85 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -60,7 +60,6 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_TSO6,
>  	VIRTIO_NET_F_GUEST_ECN,
>  	VIRTIO_NET_F_GUEST_UFO,
> -	VIRTIO_NET_F_GUEST_CSUM,
>  	VIRTIO_NET_F_GUEST_USO4,
>  	VIRTIO_NET_F_GUEST_USO6,
>  	VIRTIO_NET_F_GUEST_HDRLEN
> @@ -3437,10 +3436,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> -		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
> -		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> +		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW, disable GRO_HW first");
>  		return -EOPNOTSUPP;
>  	}
>  
> -- 
> 2.19.1.6.gb485710b


