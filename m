Return-Path: <netdev+bounces-46771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B157E654F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0574B20BDD
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1B71096A;
	Thu,  9 Nov 2023 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODIGiN1R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600110944
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:30:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99492D54
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 00:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699518600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qGu6ReB5a+EcqdKKJhEiSap1D12mNLXKF1UNlxFd2w=;
	b=ODIGiN1RNwWY21DlbCMNQKsTXvSqV6WP7bnpfvsmOjCbEFuOJq6dViDbwqla9IA+P3SpeR
	74BrJLNxJ4fT9UER+dZYUXipbHhrd0qhPCSxSkcRN33E5K8WvAG863DC9I4ljDnL/x/oTh
	xIL9biFaT0jNQ5ftaQVj+d1m6x8B/2Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-OSzRa2i5M7GuN2LJ16b7Cg-1; Thu, 09 Nov 2023 03:29:58 -0500
X-MC-Unique: OSzRa2i5M7GuN2LJ16b7Cg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c45a6a8832so11662966b.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 00:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699518597; x=1700123397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qGu6ReB5a+EcqdKKJhEiSap1D12mNLXKF1UNlxFd2w=;
        b=mBmB/Jip4SQ6EL+e0hxThzsj+x+MXRRe6IK6J+gsRvwvgJ+pZdDDKsxyfrzO5/p28T
         UA8MCq2ISUH8jkd+QdSZqbnltaoE68rt8lud96hTiLVf5+S/+qM0OIpD501k61LTaW0m
         jOGVy4JEWNM3FQnSOCSkvLoaeoN1SD0P2UkCl6v1RvFLDP/bVtfRE1qLPlmB0VrvzSyu
         NBsmK6ucgZjcfwz/gkLqWilVpLPr+PwmbSfTs/WP3MFXCAlGS8RFsa4sgmBCeCUhnMNC
         IrIRujl00kGs7hLcGbTLOVyLqNehDNyaBNiluBXA4bmjN8+TvbgcY0doJIH+pcZJXzaI
         NWBQ==
X-Gm-Message-State: AOJu0Yx5dV71WaFEYMefJM6yf1O7i8bN738BnEFNqF1Ats52ZPz8hBCb
	97ov+toFQNDB7qsoleTW0fCeaViesaBY7VwtpgENxzZ5A+nsOZGTd+GoMuexzmcvu5b0hBMPaVm
	2YLA0FQidwhT5NoZ3
X-Received: by 2002:a17:907:9725:b0:9dd:b624:dea9 with SMTP id jg37-20020a170907972500b009ddb624dea9mr3415529ejc.7.1699518597404;
        Thu, 09 Nov 2023 00:29:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFQLHA2HdtAUf7yiWJ3zu6Jf15htwDL4OIcB2ox9NPft2Q3sVGGotT9BWcb+BUEytSXl5ggw==
X-Received: by 2002:a17:907:9725:b0:9dd:b624:dea9 with SMTP id jg37-20020a170907972500b009ddb624dea9mr3415493ejc.7.1699518597043;
        Thu, 09 Nov 2023 00:29:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id v25-20020a170906381900b009dfd3b80ba3sm2221221ejc.35.2023.11.09.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:29:56 -0800 (PST)
Message-ID: <076fa6505f3e1c79cc8acdf9903809fad6c2fd31.camel@redhat.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to
 netdevice
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Date: Thu, 09 Nov 2023 09:29:54 +0100
In-Reply-To: <20231106024413.2801438-5-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-5-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       struct netdev_dmabuf_binding **out)
> +{
> +	struct netdev_dmabuf_binding *binding;
> +	struct scatterlist *sg;
> +	struct dma_buf *dmabuf;
> +	unsigned int sg_idx, i;
> +	unsigned long virtual;
> +	int err;
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	dmabuf =3D dma_buf_get(dmabuf_fd);
> +	if (IS_ERR_OR_NULL(dmabuf))
> +		return -EBADFD;
> +
> +	binding =3D kzalloc_node(sizeof(*binding), GFP_KERNEL,
> +			       dev_to_node(&dev->dev));
> +	if (!binding) {
> +		err =3D -ENOMEM;
> +		goto err_put_dmabuf;
> +	}
> +
> +	xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
> +
> +	refcount_set(&binding->ref, 1);
> +
> +	binding->dmabuf =3D dmabuf;
> +
> +	binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.parent=
);
> +	if (IS_ERR(binding->attachment)) {
> +		err =3D PTR_ERR(binding->attachment);
> +		goto err_free_binding;
> +	}
> +
> +	binding->sgt =3D dma_buf_map_attachment(binding->attachment,
> +					      DMA_BIDIRECTIONAL);
> +	if (IS_ERR(binding->sgt)) {
> +		err =3D PTR_ERR(binding->sgt);
> +		goto err_detach;
> +	}
> +
> +	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> +	 * binding can be much more flexible than that. We may be able to
> +	 * allocate MTU sized chunks here. Leave that for future work...
> +	 */
> +	binding->chunk_pool =3D gen_pool_create(PAGE_SHIFT,
> +					      dev_to_node(&dev->dev));
> +	if (!binding->chunk_pool) {
> +		err =3D -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	virtual =3D 0;
> +	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
> +		dma_addr_t dma_addr =3D sg_dma_address(sg);
> +		struct dmabuf_genpool_chunk_owner *owner;
> +		size_t len =3D sg_dma_len(sg);
> +		struct page_pool_iov *ppiov;
> +
> +		owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> +				     dev_to_node(&dev->dev));
> +		owner->base_virtual =3D virtual;
> +		owner->base_dma_addr =3D dma_addr;
> +		owner->num_ppiovs =3D len / PAGE_SIZE;
> +		owner->binding =3D binding;
> +
> +		err =3D gen_pool_add_owner(binding->chunk_pool, dma_addr,
> +					 dma_addr, len, dev_to_node(&dev->dev),
> +					 owner);
> +		if (err) {
> +			err =3D -EINVAL;
> +			goto err_free_chunks;
> +		}
> +
> +		owner->ppiovs =3D kvmalloc_array(owner->num_ppiovs,
> +					       sizeof(*owner->ppiovs),
> +					       GFP_KERNEL);
> +		if (!owner->ppiovs) {
> +			err =3D -ENOMEM;
> +			goto err_free_chunks;
> +		}
> +
> +		for (i =3D 0; i < owner->num_ppiovs; i++) {
> +			ppiov =3D &owner->ppiovs[i];
> +			ppiov->owner =3D owner;
> +			refcount_set(&ppiov->refcount, 1);
> +		}
> +
> +		dma_addr +=3D len;

I'm trying to wrap my head around the whole infra... the above line is
confusing. Why do you increment dma_addr? it will be re-initialized in
the next iteration.

Cheers,

Paolo


