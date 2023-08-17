Return-Path: <netdev+bounces-28637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52997800F4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 00:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB30E1C21514
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089D1BEF5;
	Thu, 17 Aug 2023 22:18:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C481B7EF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 22:18:48 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC44330D6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:18:47 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44779e3e394so102491137.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692310726; x=1692915526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i90jKdNjvYHfOh8lmPDp40Qdp095YCdh1Oy/+Cvt5J4=;
        b=nzRIbPr05yBxns7Ih/cfXcZJ30f+k1kQZlBxBe2yWnkmc9ysAOdx9pXxuvy5SYpvc3
         +u0MfgV71NhJualJhPYe5Xad/yI7An051nCYOvcshM/+JCtph42QKThML1xR1ERXrVZY
         2s5552xNfD1RblGd5AXsfUZ7n5qvSTZRRt/XBYLmDnMK/fG1nMyQvbYOVtS9QvXKNXGg
         BQjS8494d4cFQvMCgONrVePKljTc3VA88SfKjYSzbJrRYBZOLecuxu78FCpdwew70Kx1
         UxejfnKPH+oYpEzqUDKLHzrUqaTCuHDXvKolh445LRugaIAwVaRw2/Gr6+ssL9DLVr/0
         VeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310726; x=1692915526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i90jKdNjvYHfOh8lmPDp40Qdp095YCdh1Oy/+Cvt5J4=;
        b=ZTlw7SssoNj5J+2Uzsa58w4W7BMWtymiPFOSyY/iisb/4QP970EpN4PQVdQJ4z4Fi0
         eMSIM6uHUVzNEeg5GcsyyRhBbtRHIhf1EY8q3h9oM17ElofB1nGzWLl169AQy/P8yNhI
         GM1l4MFhLK163qncsHd/O2Ztz1c/A5prvIwbjfPBScBu0/yAC1SWo4wFXv5xcFxNeQxx
         RNf85T0qrWKcnGeWDBkrfNmisisP4EB3Kz1LeydFsDw3UoIAPxNz7XIWoKvFGdjeWSXL
         qy3dRPgNJua1KhbUnIUM4Xa54eIeszRR5UH3UfuYm6rYZoSToCa236ZkOBmq+KEmG1So
         McIw==
X-Gm-Message-State: AOJu0YwIHbdvrFbxJwkuqYbb1WsXHcTwArPIqbFZFW002S8Gba140KMx
	pIHgOmRageHLfkYBUg2YsevLK41g/iglIAiOvva2Gw==
X-Google-Smtp-Source: AGHT+IHxiahQBibd9E5tQcywrVqF/Dce4Pc5zTgH7kI9+WMihsI2390MeC2HVHwqce1iFLC7pwbzbsRWAEGIIPh2JH8=
X-Received: by 2002:a67:f343:0:b0:447:4cb2:74fd with SMTP id
 p3-20020a67f343000000b004474cb274fdmr1190943vsm.8.1692310726590; Thu, 17 Aug
 2023 15:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
 <7dc4427f-ee99-e401-9ff8-d554999e60ca@kernel.org> <7889b4f8-78d9-9a0a-e2cc-aae4ed8a80fd@gmail.com>
In-Reply-To: <7889b4f8-78d9-9a0a-e2cc-aae4ed8a80fd@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 17 Aug 2023 15:18:35 -0700
Message-ID: <CAHS8izNZ1pJAFqa-3FPiUdMWEPE_md2vP1-6t-KPT6CPbO03+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Device Memory TCP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Hari Ramakrishnan <rharix@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, 
	sdf@google.com, David Wei <dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 11:04=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 8/14/23 02:12, David Ahern wrote:
> > On 8/9/23 7:57 PM, Mina Almasry wrote:
> >> Changes in RFC v2:
> >> ------------------
> ...
> >> ** Test Setup
> >>
> >> Kernel: net-next with this RFC and memory provider API cherry-picked
> >> locally.
> >>
> >> Hardware: Google Cloud A3 VMs.
> >>
> >> NIC: GVE with header split & RSS & flow steering support.
> >
> > This set seems to depend on Jakub's memory provider patches and a netde=
v
> > driver change which is not included. For the testing mentioned here, yo=
u
> > must have a tree + branch with all of the patches. Is it publicly avail=
able?
> >
> > It would be interesting to see how well (easy) this integrates with
> > io_uring. Besides avoiding all of the syscalls for receiving the iov an=
d
> > releasing the buffers back to the pool, io_uring also brings in the
> > ability to seed a page_pool with registered buffers which provides a
> > means to get simpler Rx ZC for host memory.
>
> The patchset sounds pretty interesting. I've been working with David Wei
> (CC'ing) on io_uring zc rx (prototype polishing stage) all that is old
> similar approaches based on allocating an rx queue. It targets host
> memory and device memory as an extra feature, uapi is different, lifetime=
s
> are managed/bound to io_uring. Completions/buffers are returned to user v=
ia
> a separate queue instead of cmsg, and pushed back granularly to the kerne=
l
> via another queue. I'll leave it to David to elaborate
>
> It sounds like we have space for collaboration here, if not merging then
> reusing internals as much as we can, but we'd need to look into the
> details deeper.
>

I'm happy to look at your implementation and collaborate on something
that works for both use cases. Feel free to share unpolished prototype
so I can start having a general idea if possible.

> > Overall I like the intent and possibilities for extensions, but a lot o=
f
> > details are missing - perhaps some are answered by seeing an end-to-end
> > implementation.
>
> --
> Pavel Begunkov



--=20
Thanks,
Mina

