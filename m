Return-Path: <netdev+bounces-62988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A282A95A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F61C252EF
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8407F9EA;
	Thu, 11 Jan 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqnSOELt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C392101CF
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704962932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbUkvBoj8gxLrACYWyhfe3FGuAwpnKYJCy4ANl1OWAQ=;
	b=FqnSOELtB3EPH2NePB34bE5N3nJ4HKZqAyXHMWjqFFqvfvAG2DP/JanoyxZHdFL7rBpmeC
	QWY7+bCpvftVpWuwMlRaAdBRgXPtGAaxKTHKDTset3JBsfwb34TV/ewqD1MQLoURu5xeM2
	UjxrpdjIIkMMEZybu+1KgXZafygjdj8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-rwRy97D8NZG2-gP1zhSfiA-1; Thu, 11 Jan 2024 03:48:51 -0500
X-MC-Unique: rwRy97D8NZG2-gP1zhSfiA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42991c00fbbso60521371cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 00:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962931; x=1705567731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbUkvBoj8gxLrACYWyhfe3FGuAwpnKYJCy4ANl1OWAQ=;
        b=BNyfWzq8iBxsWSicRBEdsjM6k7wF9ucim65Q8cn79m6XbNh1aopBDkenoT0J6ygoXz
         na90OT50KB2FiMoIDyrnakuomG+fGV1exPciM+NqKhAptxFEE5k/dWzMqcor+J8/b4ZX
         Wa9fJ/NWsvJy0yNQPKz3zoLcORVlYUmkbFk52gwQVDI1liHc6vACbvO6FC0w1PO7Lz1n
         9e0xkKdPOzhX1sbBCOfok45wdSyS7OUmSR6EXFGrhWzIMV5THXNmacHAt+SgrmP8780H
         zLnQf9FLogqGJxAFu6Cu1nd2L5MEUa8eCi/W0W6av9pZeMB2TtZck6I2EbTpaiIpBEgN
         nNeA==
X-Gm-Message-State: AOJu0YyNPe7Sz0+XIZKsxY0TspZ8HAqXMvhzcOKVEVYFa12CmRWIvlKg
	sJMjc2I5FyMTEcCr+tTQ/kiGlJ1ivKrDBh7UXOuqT1gbfv9w9He3XtMAHcttcClpaQnKvJufBhG
	5K2lpMFBqyX6NqR8VPJOSTGwx4nJx3lh3Q00Oc4a43aKRNsR1
X-Received: by 2002:a05:6830:1ca:b0:6dd:ecfc:6231 with SMTP id r10-20020a05683001ca00b006ddecfc6231mr1072243ota.49.1704962548371;
        Thu, 11 Jan 2024 00:42:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBRprWzEj5DmMX32LaMUs1+qfaZPU6alpcl5pE809RY8gFTAICGop4IB9CnQEXSpHBKdpk2dfokvLOl5dCxe8=
X-Received: by 2002:a05:6808:128b:b0:3bd:3225:4be3 with SMTP id
 a11-20020a056808128b00b003bd32254be3mr801909oiw.71.1704962060197; Thu, 11 Jan
 2024 00:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com> <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:34:09 +0800
Message-ID: <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc. Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.
>
> Because the BAD_RING is called (that may set vq->broken), so
> the relative "const" of vq is removed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----------
>  include/linux/virtio.h       |  16 ++++
>  2 files changed, 142 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..1374b3fd447c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +/*
> + *     use_dma_api premapped -> do_unmap
> + *  1. false       false        false
> + *  2. true        false        true
> + *  3. true        true         false
> + *
> + * Only #3, we should return the DMA info to the driver.

Btw, I guess you meant "#3 is false" here?

And could we reduce the size of these 3 * 3 matrices? It's usually a
hint that the code is not optmized.

Thanks


