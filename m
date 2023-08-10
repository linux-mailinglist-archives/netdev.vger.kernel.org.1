Return-Path: <netdev+bounces-26539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987B778098
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDB8281FC8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE620FAC;
	Thu, 10 Aug 2023 18:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71D62A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:45:07 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E8270A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:45:06 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-791b8525b59so427189241.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693105; x=1692297905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJOLYvirEbTcTz/cZZPdQ88ne7irvm58XPg3wuYDHTQ=;
        b=4OMf+RbXMCV3q8WS2zgzJDNbRBusKRgpLfBwP7Qi0BEdMoDYjima6tACk4tSCXLbZE
         15YGb8uC9JeCafmRLfdQP/iZi7BPTgdVQV3A7LdqXmq/11WNfQ5MKlpanT/30tYVjaYI
         ii23sbNM3TO3ZHjt4s/cqQP2X3OtYS2VsyPQb9bpsULNK6Q3mgYanHhcajokKrKh8oyR
         1QRjWSr0zuYhAv08g9FjehcM9PlNaZ91lqRtWxZCb23LhPNRZt8rGNVF7t58DiS9Rb/u
         L+A0kpld6LXn838LuVRRICT+b0Ej4BezwwhHBJI58aUnosXUTePjo4bb/TNqX48fCYHJ
         WOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693105; x=1692297905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJOLYvirEbTcTz/cZZPdQ88ne7irvm58XPg3wuYDHTQ=;
        b=EXy+VmaRMhg+qY6tD1AWe9eCeJbx4n60fej8b6Hb4L8rtktLon93p1yzTuuZvKmoYL
         xTgTnayYaui1LYaF2KvV+O4ao9A6hvWVDyidJfWfpalZxKPL3wK4ak5XfHuMEbxl9Joo
         9z8OB9Z7gzwtVykvDjTGrT0nBfmd+LNI4zcq/PxgpazxbrFtHaNivbDF37Cldd57yc1G
         FDgpTxX6W+PRiYoSPuP21RlPWgrl62MusJkyCpkfASFh1YSrNBJTxLAH5YQ0Zx7JTE1+
         IDJEtdlDM4gSw/Ian9gqkldwlj5jsYK6go4lZ5LVbR2R0gw6yJBXHQ7DisRcXzxu7Ow0
         QTog==
X-Gm-Message-State: AOJu0YxRsD0GnRDJNt/OEMYGZ9Ky3Hy6p3pEJ83fR3EKrp3fSZaS6Tql
	8uF7V+qutaj48PdmCTNRu5MpP61zU2wXl3vZbXiM1w==
X-Google-Smtp-Source: AGHT+IHM1oSo6XktKuBAApMaC3KhaIyouHeqMPfG6PRlybeYMUqn0OBzfdXtowimtp+kduJsa0ZltscvUoI0CXPMu9I=
X-Received: by 2002:a05:6102:3c3:b0:445:5005:d7ab with SMTP id
 n3-20020a05610203c300b004455005d7abmr2533271vsq.18.1691693105227; Thu, 10 Aug
 2023 11:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com> <1009bd5b-d577-ca7b-8eff-192ee89ad67d@amd.com>
In-Reply-To: <1009bd5b-d577-ca7b-8eff-192ee89ad67d@amd.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Aug 2023 11:44:53 -0700
Message-ID: <CAHS8izPrOcrJpE1ysCM7rwHhBMPvj0vQwzfOyVqdxsVux8oMww@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Device Memory TCP
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: netdev@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Hari Ramakrishnan <rharix@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, 
	sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 3:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.08.23 um 03:57 schrieb Mina Almasry:
> > Changes in RFC v2:
> > ------------------
> >
> > The sticking point in RFC v1[1] was the dma-buf pages approach we used =
to
> > deliver the device memory to the TCP stack. RFC v2 is a proof-of-concep=
t
> > that attempts to resolve this by implementing scatterlist support in th=
e
> > networking stack, such that we can import the dma-buf scatterlist
> > directly.
>
> Impressive work, I didn't thought that this would be possible that "easil=
y".
>
> Please note that we have considered replacing scatterlists with simple
> arrays of DMA-addresses in the DMA-buf framework to avoid people trying
> to access the struct page inside the scatterlist.
>

FWIW, I'm not doing anything with the struct pages inside the
scatterlist. All I need from the scatterlist are the
sg_dma_address(sg) and the sg_dma_len(sg), and I'm guessing the array
you're describing will provide exactly those, but let me know if I
misunderstood.

> It might be a good idea to push for that first before this here is
> finally implemented.
>
> GPU drivers already convert the scatterlist used to arrays of
> DMA-addresses as soon as they get them. This leaves RDMA and V4L as the
> other two main users which would need to be converted.
>
> >   This is the approach proposed at a high level here[2].
> >
> > Detailed changes:
> > 1. Replaced dma-buf pages approach with importing scatterlist into the
> >     page pool.
> > 2. Replace the dma-buf pages centric API with a netlink API.
> > 3. Removed the TX path implementation - there is no issue with
> >     implementing the TX path with scatterlist approach, but leaving
> >     out the TX path makes it easier to review.
> > 4. Functionality is tested with this proposal, but I have not conducted
> >     perf testing yet. I'm not sure there are regressions, but I removed
> >     perf claims from the cover letter until they can be re-confirmed.
> > 5. Added Signed-off-by: contributors to the implementation.
> > 6. Fixed some bugs with the RX path since RFC v1.
> >
> > Any feedback welcome, but specifically the biggest pending questions
> > needing feedback IMO are:
> >
> > 1. Feedback on the scatterlist-based approach in general.
>
> As far as I can see this sounds like the right thing to do in general.
>
> Question is rather if we should stick with scatterlist, use array of
> DMA-addresses or maybe even come up with a completely new structure.
>

As far as I can tell, it should be trivial to switch this device
memory TCP implementation to anything that provides:

1. DMA-addresses (sg_dma_address() equivalent)
2. lengths (sg_dma_len() equivalent)

if you go that route. Specifically, I think it will be pretty much a
localized change to netdev_bind_dmabuf_to_queue() implemented in this
patch:
https://lore.kernel.org/netdev/ZNULIDzuVVyfyMq2@ziepe.ca/T/#m2d344b08f54562=
cc9155c3f5b018cbfaed96036f

> > 2. Netlink API (Patch 1 & 2).
>
> How does netlink manage the lifetime of objects?
>

Netlink itself doesn't handle the lifetime of the binding. However,
the API I implemented unbinds the dma-buf when the netlink socket is
destroyed. I do this so that even if the user process crashes or
forgets to unbind, the dma-buf will still be unbound once the netlink
socket is closed on the process exit. Details in this patch:
https://lore.kernel.org/netdev/ZNULIDzuVVyfyMq2@ziepe.ca/T/#m2d344b08f54562=
cc9155c3f5b018cbfaed96036f

On Thu, Aug 10, 2023 at 9:07=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Aug 10, 2023 at 12:29:08PM +0200, Christian K=C3=B6nig wrote:
> > Am 10.08.23 um 03:57 schrieb Mina Almasry:
> > > Changes in RFC v2:
> > > ------------------
> > >
> > > The sticking point in RFC v1[1] was the dma-buf pages approach we use=
d to
> > > deliver the device memory to the TCP stack. RFC v2 is a proof-of-conc=
ept
> > > that attempts to resolve this by implementing scatterlist support in =
the
> > > networking stack, such that we can import the dma-buf scatterlist
> > > directly.
> >
> > Impressive work, I didn't thought that this would be possible that "eas=
ily".
> >
> > Please note that we have considered replacing scatterlists with simple
> > arrays of DMA-addresses in the DMA-buf framework to avoid people trying=
 to
> > access the struct page inside the scatterlist.
> >
> > It might be a good idea to push for that first before this here is fina=
lly
> > implemented.
> >
> > GPU drivers already convert the scatterlist used to arrays of DMA-addre=
sses
> > as soon as they get them. This leaves RDMA and V4L as the other two mai=
n
> > users which would need to be converted.
>
> Oh that would be a nightmare for RDMA.
>
> We need a standard based way to have scalable lists of DMA addresses :(
>
> > > 2. Netlink API (Patch 1 & 2).
> >
> > How does netlink manage the lifetime of objects?
>
> And access control..
>

Someone will correct me if I'm wrong but I'm not sure netlink itself
will do (sufficient) access control. However I meant for the netlink
API to bind dma-bufs to be a CAP_NET_ADMIN API, and I forgot to add
this check in this proof-of-concept, sorry. I'll add a CAP_NET_ADMIN
check in netdev_bind_dmabuf_to_queue() in the next iteration.

