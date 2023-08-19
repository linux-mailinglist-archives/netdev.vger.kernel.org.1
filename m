Return-Path: <netdev+bounces-29128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D90781ABB
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6F2819AE
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D735619BC1;
	Sat, 19 Aug 2023 18:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6806125
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:00:05 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0955B1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:00:01 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-44ac7b81beeso650633137.3
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692468000; x=1693072800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha8GUQ0FSmue/in3ei6lYcQWYDNfoweSBFhq3kUyyPw=;
        b=dJQuP7YGf/R6pYv5j7UL83J3HjfISrCtbPmK73befv4by/VlPVGRb2L6uFkfensXez
         D8z40gjjDQwQYqI9nESzj9mtXEtN50zq9zFJZdd7X+EswMP+eTjsTiCdzOSWO2OUzCPc
         Y9W6MvvH8n+65Iv2CS1vSeF7P5rCmltF8y3gYxd29O11H307E+t7pDrV4Awczbxi1grn
         DtGpDdOflzJaj3hrNNDajLuOtJB9BF9AYEJc9is2zjHHerrWmBppw4XuxE9GTQpIIMNA
         cSm/7Et7UDozdkDNpt8El9MORCgKf65AauX/fP8178uG2AivfltEvQ7vQwKokzkYh8d1
         8hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692468000; x=1693072800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha8GUQ0FSmue/in3ei6lYcQWYDNfoweSBFhq3kUyyPw=;
        b=aNA5Mtht5sGjwWpUQYzAjHDT7CbEzWsHGVJj7obf4pO9FEVobKl9Tbb2OYbKijKaNi
         L8TEvqxTSTLeVWR5X1KBWXmlyKJjr7xiregAaPMDwwJghSR3Qsle+vkpebcHba6f2dps
         3NzZsMVM/ktRmRU9L3ozE6AJPyfb28vUHdLPGE5ly1s7vxqS9pfL9psNhX1uqFZsIfv+
         t6BoT3uglZzKQZ1ELwpwDRVr7xFNBBcC/LIvO8JiI43NGra9H8nkyIPZOZqV9R2QDKhu
         3eIvfzQ1yVPQtMGFlbgKBUTyFhSzSQeCjEMAQSjmBgIzQSEcB4wIfkA4rzTCv0nTI5p7
         qSVg==
X-Gm-Message-State: AOJu0Ywofh/zt1EKLbCstlTb0t3mJt4OjLPQbgk6Kwl6uimtYLLlKq/8
	mhJhAVqYWl8vfhbaZdzGINc8MEwzTjQy0WiUaMAFYw==
X-Google-Smtp-Source: AGHT+IEx4visv84iQX1CgUSPtwr8i/RRoRZySydD5q9C0YBpUGS0S9UuCNUKVKKAaVgk0gTUtSBPmJ7oBcjoxBIv0GU=
X-Received: by 2002:a67:fd6d:0:b0:44d:4385:1621 with SMTP id
 h13-20020a67fd6d000000b0044d43851621mr18984vsa.0.1692468000146; Sat, 19 Aug
 2023 11:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
 <20230810015751.3297321-3-almasrymina@google.com> <7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
 <20230815171638.4c057dcd@kernel.org> <64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
 <c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org> <20230817190957.571ab350@kernel.org>
 <CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
 <7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org> <20230818190653.78ca6e5a@kernel.org>
 <38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org> <CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
In-Reply-To: <CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 19 Aug 2023 10:59:48 -0700
Message-ID: <CAHS8izOaxD6qLHNwuSBSZK1gx7OpW1mY3kwT=H-i9h6Ycap-_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 7:19=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Aug 18, 2023 at 11:30=E2=80=AFPM David Ahern <dsahern@kernel.org>=
 wrote:
> >
> > On 8/18/23 8:06 PM, Jakub Kicinski wrote:
> > > On Fri, 18 Aug 2023 19:34:32 -0600 David Ahern wrote:
> > >> On 8/18/23 3:52 PM, Mina Almasry wrote:
> > >>> The sticking points are:
> > >>> 1. From David: this proposal doesn't give an application the abilit=
y
> > >>> to flush an rx queue, which means that we have to rely on a driver
> > >>> reset that affects all queues to refill the rx queue buffers.
> > >>
> > >> Generically, the design needs to be able to flush (or invalidate) al=
l
> > >> references to the dma-buf once the process no longer "owns" it.
> > >
> > > Are we talking about the ability for the app to flush the queue
> > > when it wants to (do no idea what)? Or auto-flush when app crashes?
> >
> > If a buffer reference can be invalidated such that a posted buffer is
> > ignored by H/W, then no flush is needed per se. Either way the key poin=
t
> > is that posted buffers can no longer be filled by H/W once a process no
> > longer owns the dma-buf reference. I believe the actual mechanism here
> > will vary by H/W.
>
> Right. Many devices only allow bringing all queues down at the same time.
>

FWIW, I spoke with our Praveen (GVE maintainer) about this. Suspicion
is that bringing up/down individual queues _should_ work with GVE for
the most part, but it's pending me trying it and confirming.

I think if a driver can't support bringing up/down individual queues,
then Jakub's direction for per queue configs all cannot be done on
that driver  (queue_mem_alloc, queue_mem_free, queue_start,
queue_stop), and addressing David's concerns vis-a-vis dma-buf being
auto-detached if the application crashes/exists also cannot be done.
The driver will not be able to support device memory TCP unless there
is an option to make it work with a full driver reset.

> Once a descriptor is posted and the ring head is written, there is no
> way to retract that. Since waiting for the device to catch up is not
> acceptable, the only option is to bring down the queue, right? Which
> will imply bringing down the entire device on many devices. Not ideal,
> but acceptable short term, imho.
>

I also wonder if it may be acceptable to have both modes supported.
I.e. (roughly):

1. Add APIs that create an rx-queue bound to a dma-buf.
2. Add APIs that bind an rx-queue to a dma-buf.

Drivers that support per-queue allocation/freeing can support and use
#1 and can work as David likes. Drivers that cannot allocate or bring
up individual queues can only support #2, and trigger a driver-reset
to refill or release the dma-buf references.

This patch series already implements APIs #2.

> That may be an incentive for vendors to support per-queue
> start/stop/alloc/free. Maybe the ones that support RDMA already do?



--=20
Thanks,
Mina

