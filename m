Return-Path: <netdev+bounces-46524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A47E4B44
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 23:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE2B280FF5
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97B2F85E;
	Tue,  7 Nov 2023 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gVfz8Ka"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745B2F859
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 21:59:55 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCBE2116
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 13:59:54 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66cfd35f595so35141446d6.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699394394; x=1699999194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PqaUmI2qs4cLDwl2i5pZd/bBUshC/jimD2IW3jRBHQ=;
        b=0gVfz8KalPjgblFZOXAbcpyzLc9BmNmEpFXDcildKc7o0K/fILzLgDnG7PUv3VdMMG
         VIcmMhQCdbPSPBtp00KzhOO7TKJstCRY6j5nEnW+XbXXj9SNlrnEfcs8MUVYwZ+TXg84
         xXP1c0C2xs2FQxncZ6UVrnW6kRR8MlSOk+y+gsCdm+FQ4yT0RD5jMDpMdrFRo86u3sGA
         UhQcbSPohGI3HGdSfd6C5ROOuiYu8iEGpm4jtA7pGrR3742gGsYBUkVabAZhQuDRfdLe
         lV+i7tMG6qN3WX2n7EV+U3SZVnPU65Rz1YEyTFzhnn+kRGknLdv2VmBPpVB3Rj0fURP7
         u/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394394; x=1699999194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PqaUmI2qs4cLDwl2i5pZd/bBUshC/jimD2IW3jRBHQ=;
        b=LoHPgGVWQyxZ/pr/hub0Uask2bgzgiWMa0sPekN1jzsMP/sawNJST2ytJCaU40IPKd
         oN4oA+v2DWEjEW2DpTjECn5UbjTF/Sra5uMCF9/ez7VISfhFWZLnKVMcIWQcKCNKMz3d
         osuTVzwRd5TtgZx6vUt0GIpJYZk5OjD9cC2qUS6mJaoNm0ac6AR9NYUKD0rH0/hz2jM7
         yapVcTaCHNcwR0dGK2toJXGsMU5wNN1r4O9CTfhkaCULeALwizZr4ZG8Ra5DYhYag11a
         G4wCZ/qaDdOpwIBTLkjuWo/JwfSF7crOFYakH8ko48YCJl4XbiIXxCtyU0wxqD2p6J4R
         IVIA==
X-Gm-Message-State: AOJu0YzKzSU/zNz8j2fX1Bl/iPb3NSrqxNyKqu7UzzIerQW7OgU5M75U
	dr2yRnN8yY8NUptYpUP3TzEuYs9al1U6zGMM0BPYhA==
X-Google-Smtp-Source: AGHT+IHVrgEKfASjC5rH9bq4RglRT8VPoPtK4Z4u/BPe0YLNL57TLwT+bbLdmq9/ZlUZX9/zJmxQ+t+E7PsoyRnnNeQ=
X-Received: by 2002:ad4:5be2:0:b0:66d:a22a:464f with SMTP id
 k2-20020ad45be2000000b0066da22a464fmr79490qvc.16.1699394393800; Tue, 07 Nov
 2023 13:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
In-Reply-To: <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 13:59:40 -0800
Message-ID: <CAHS8izPV3isMWyjFnr7bJDDPANg-zm_M=UbHyuhYWv1Viy7fRw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 11:46=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/6 10:44, Mina Almasry wrote:
> > +
> > +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *bindin=
g)
> > +{
> > +     size_t size, avail;
> > +
> > +     gen_pool_for_each_chunk(binding->chunk_pool,
> > +                             netdev_devmem_free_chunk_owner, NULL);
> > +
> > +     size =3D gen_pool_size(binding->chunk_pool);
> > +     avail =3D gen_pool_avail(binding->chunk_pool);
> > +
> > +     if (!WARN(size !=3D avail, "can't destroy genpool. size=3D%lu, av=
ail=3D%lu",
> > +               size, avail))
> > +             gen_pool_destroy(binding->chunk_pool);
>
>
> Is there any other place calling the gen_pool_destroy() when the above
> warning is triggered? Do we have a leaking for binding->chunk_pool?
>

gen_pool_destroy BUG_ON() if it's not empty at the time of destroying.
Technically that should never happen, because
__netdev_devmem_binding_free() should only be called when the refcount
hits 0, so all the chunks have been freed back to the gen_pool. But,
just in case, I don't want to crash the server just because I'm
leaking a chunk... this is a bit of defensive programming that is
typically frowned upon, but the behavior of gen_pool is so severe I
think the WARN() + check is warranted here.

> > +
> > +     dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> > +                              DMA_BIDIRECTIONAL);
> > +     dma_buf_detach(binding->dmabuf, binding->attachment);
> > +     dma_buf_put(binding->dmabuf);
> > +     kfree(binding);
> > +}
> > +
>
>


--=20
Thanks,
Mina

