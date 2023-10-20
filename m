Return-Path: <netdev+bounces-42900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38C7D08DD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15B3B21460
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6BCA5F;
	Fri, 20 Oct 2023 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDT+MNOb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B07CA57
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:54:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76675D5E
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6MKtJ69KkbxUcM/SgZXjJHbQJs1+BI9mQaef+ju4hs=;
	b=eDT+MNObxNsY+KxwuI1rAxALs7IT23vxsa6+Qk+4+znD8oEVKjSHkbVujMenLgfypgyAKE
	oGHHTAhjVX3eZ8ZjcrNAHPkkN6/iKH1cgS/H0vbpieNtO81XApFwHn1CbW1rJ2pqAFI3FA
	ZDEygjDXIlM+R3DNSdpWB/IHeMMUGis=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-7YeqdobKMaqstaDsMaE3BA-1; Fri, 20 Oct 2023 02:54:11 -0400
X-MC-Unique: 7YeqdobKMaqstaDsMaE3BA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso450864e87.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784849; x=1698389649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6MKtJ69KkbxUcM/SgZXjJHbQJs1+BI9mQaef+ju4hs=;
        b=goMXA+MutpvxI2js0dcVwQOgzEFD1IEeSK7y9U19tc5vNZpKTbPE79z9FXKY9Orl23
         4ZmMiuLm0q8XT/u0sRP8+91Bklentcny4MCWYnOc4WXe3AY73/suiw4uHwswC/m+Q9aY
         BWz/djuIra93Kmpo9ZKu60DDEVEnpauFRi5Ld/6q1B8xgQfJeTxoHkT2mDR6ScJHBTXv
         mZPRFNLwb0z1ilZQVuAPCfRbH/qBrqtSaas9aRVF0B3kzHq6n+1ZbELc4yYJ+PZg7k+A
         ZEtSLm0vEPvv9pMvVQrYA3FQXLjkO59aMG/pXK5ycxMItJAyJ7R7UMVJge6952R686rX
         fIZQ==
X-Gm-Message-State: AOJu0YwG2ZEzIR08+JnUiAJ3f1lFI32lO7SDT9CHHXfOYxFNc1LGdOMq
	ob1RgetHtTgcLyNE81drPUVOz4/4+HtVtFUJl83D30wnELnI2qzLFOLaiwHLTxo1U0ShkyCHGQY
	LTg25G3Fq2nf1FuF8isnZyWPmz+yobbeo
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id i19-20020ac25233000000b00506899d1994mr568148lfl.52.1697784849617;
        Thu, 19 Oct 2023 23:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOn/oJyJJPOYLBOv/fMkCipSGgZNHIW13oOFcOt53IHv46J5tRmnf3LsN5yPokvReRkUsdi5w2tb1PpviVoOo=
X-Received: by 2002:ac2:5233:0:b0:506:899d:1994 with SMTP id
 i19-20020ac25233000000b00506899d1994mr568135lfl.52.1697784849320; Thu, 19 Oct
 2023 23:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-15-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:53:58 +0800
Message-ID: <CACGkMEvHRcjeomqqxpPQc1wjw64qcthNT=AbDoUJUkMWwgyDag@mail.gmail.com>
Subject: Re: [PATCH net-next v1 14/19] virtio_net: xsk: tx:
 virtnet_sq_free_unused_buf() check xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtnet_sq_free_unused_buf() check xsk buffer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/net/virtio/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 1a222221352e..58bb38f9b453 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -3876,10 +3876,12 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!virtnet_is_xdp_frame(buf))
> +       if (virtnet_is_skb_ptr(buf))
>                 dev_kfree_skb(buf);
> -       else
> +       else if (virtnet_is_xdp_frame(buf))
>                 xdp_return_frame(virtnet_ptr_to_xdp(buf));
> +
> +       /* xsk buffer do not need handle. */
>  }
>
>  void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> --
> 2.32.0.3.g01195cf9f
>


