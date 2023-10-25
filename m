Return-Path: <netdev+bounces-44077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C67D6007
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F07B210AC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205D1842;
	Wed, 25 Oct 2023 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVVDXW3Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4617CA
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:43:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A710D1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698201797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMy0WvwakBGIjMhprmavDWjMT3nj91uWvZ7aWtqt65s=;
	b=bVVDXW3ZgEOvDO/so3va7WLHmo/+OBidZR+TR+K/ps7yI8XxdneoENYzk4i+fKlviB0qnf
	nAnY/JYWbRBURWWcXy8Q7eyZm/b2jYF05wqyPfwv9pdumhTS7l4DhL49+Vi3m759QGHmUk
	VhKOHjIKv9gcAGhoPi7SKM9ejFaU3Yk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-IeR-RTR4PCyYc_yyxu0wHQ-1; Tue, 24 Oct 2023 22:43:15 -0400
X-MC-Unique: IeR-RTR4PCyYc_yyxu0wHQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5098fe88bso2118601fa.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698201793; x=1698806593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMy0WvwakBGIjMhprmavDWjMT3nj91uWvZ7aWtqt65s=;
        b=hKtcvSoVN/tq8GmHUJFAFeOugttte0ocgNELyTy4V1IftN10YGVrtcVmTRtKvZ4Gb6
         FI3pmGKvcSbXkmJIChBxlmMMrm4za3DQUUcKXZNSD4/1Ws53MUzraoA9FnJYO/+lh8lf
         fhQv8eoceoAPqUF8iaGqFaj2hENnc8bUtnNUZfQV9GaLz8KREi4OhAq+jwYKbJSi/hBH
         tYO0o3V8ZTDXeI8NA1ec6D6HSRFbxUy61TS+MuI3qTdE2qp4TPxwdz4t11xiuLkI2UGK
         ypnCRZ3WkREV+2cDstx4dcPL4wL2arivEMWqz42lptGrNlLx4DVliy9atecm6EmTanI8
         QXJg==
X-Gm-Message-State: AOJu0YwkP1VD9ERgRLf9i1Y2b3lsxv/HJfQk9qFZ5F9AmwJTLSzGJpvi
	m2DcBeIcnotpcKZnSNlP/8ZMeWz5ZRPK/t3nHz53lZU4wtPM48tckcP3LBx4s2ebM+rL6qjPiwW
	pRMXBA9corm/3mXq7eBUoEZ/JeYlqMejT
X-Received: by 2002:a05:6512:398a:b0:500:d96e:f6eb with SMTP id j10-20020a056512398a00b00500d96ef6ebmr6516398lfu.19.1698201793693;
        Tue, 24 Oct 2023 19:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf1Tj4bCK7ErZJcY6f0xD7qjhSzka+4hzM92V8cxi0KqWCOwX9cAmCnfZbOj55G5BLUs8xYtGJXPKaaSizYpc=
X-Received: by 2002:a05:6512:398a:b0:500:d96e:f6eb with SMTP id
 j10-20020a056512398a00b00500d96ef6ebmr6516389lfu.19.1698201793294; Tue, 24
 Oct 2023 19:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com> <ca2cef5c582bea958e300b39eb508d08675d1106.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <ca2cef5c582bea958e300b39eb508d08675d1106.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 10:43:01 +0800
Message-ID: <CACGkMEskTyU6i82ZzN8Rt_ROAXLzM-Wni0zA31ur2QZ6wht8PQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio-net: returns whether napi is complete
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Liu, Yujie" <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> rx netdim needs to count the traffic during a complete napi process,
> and start updating and comparing samples to make decisions after
> the napi ends. Let virtqueue_napi_complete() return true if napi is done,
> otherwise vice versa.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a52fd743504a..cf5d2ef4bd24 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -431,7 +431,7 @@ static void virtqueue_napi_schedule(struct napi_struc=
t *napi,
>         }
>  }
>
> -static void virtqueue_napi_complete(struct napi_struct *napi,
> +static bool virtqueue_napi_complete(struct napi_struct *napi,
>                                     struct virtqueue *vq, int processed)
>  {
>         int opaque;
> @@ -440,9 +440,13 @@ static void virtqueue_napi_complete(struct napi_stru=
ct *napi,
>         if (napi_complete_done(napi, processed)) {
>                 if (unlikely(virtqueue_poll(vq, opaque)))
>                         virtqueue_napi_schedule(napi, vq);
> +               else
> +                       return true;
>         } else {
>                 virtqueue_disable_cb(vq);
>         }
> +
> +       return false;
>  }
>
>  static void skb_xmit_done(struct virtqueue *vq)
> --
> 2.19.1.6.gb485710b
>


