Return-Path: <netdev+bounces-28148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC377E615
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B15281B1D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269C1641F;
	Wed, 16 Aug 2023 16:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D88C8FF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:12:54 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED62704
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:12:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6471e071996so17608046d6.0
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692202372; x=1692807172;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy2pvEhGr6RPbpFPVLBlXgv3CduRYhptS8Sdrh/QV0Y=;
        b=AbiJ/Mq03ymL24aiicJ+SOxr13XrpPRN0Z2HD34D08o0yFLY3ykfIpx++/eJNFmT3u
         54Ww9JBhEJNSXRnI75p86VV71Qi6cUPjzf/f5jtFomnFhkopWrqW5FQeU2uvKbEZ8v7C
         QFawG399Bdesyw6E5dH7YXM7a7whlf4MsSt5aeuRgVIp4wk4SIaf1Sh11jzRAMm4++qE
         Q8hbvWfvoWyPEiVHTpNaIZ6WJHtfKrcmMyAJorhqv4uJPYlpn8Vst+Dj04Lcd58os8ow
         y9vh5L46Ag7Lc5RnGYGDJQs8lqQYbbKKJ1gk1XVvR/tVzrRPVPkNub/X7zvT/jfXJ74Y
         Jn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202372; x=1692807172;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hy2pvEhGr6RPbpFPVLBlXgv3CduRYhptS8Sdrh/QV0Y=;
        b=K5624zIZ63zRztzTNus9Pydqn6mYhgd33+hCQsAd2arzDClJ/KEfQdgi65M8uFKGVp
         OLj1AeZeDGp3AbsAXulOQFxo5iCe9DvmVqh3F+m7kHSttGOmiE5dCDzaAbEhucs9mtwe
         P7eGzf2IFhqfnXlJAVDKbrPzlvvxFfHTa6AWxodsIC1RvNzOSALBqnZ2BAv9blJzxqtF
         HgCyZzAkm2TfWmP8nWNLWeP/pBL/0nCnC2BGdHQ9CtewUgJf1CN7axr6HxhlYPDQjY/n
         N/JBLZ05WbxA7wQxT9UO/RaU+reA205oavOxDyejo0UCP8FdAZuxsJuc7gee01VpqvPS
         9CUA==
X-Gm-Message-State: AOJu0Yy8izVrhRjmbft1bzR1r8hje3trN6CM9vv3qwpXxLGCgmdndaiI
	/HRu8HLHybvtJ7qbgonbBx0=
X-Google-Smtp-Source: AGHT+IF1X034VASr+hC+b0L6pn0PPWys7+AkDTq/hBkpFObXfwHsync4I1gAIOp4ageviiSz9wiosg==
X-Received: by 2002:a0c:d982:0:b0:62d:f170:f6b3 with SMTP id y2-20020a0cd982000000b0062df170f6b3mr1902712qvj.19.1692202371853;
        Wed, 16 Aug 2023 09:12:51 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id z8-20020a0cda88000000b0063cf4d0d558sm2791094qvj.25.2023.08.16.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:12:51 -0700 (PDT)
Date: Wed, 16 Aug 2023 12:12:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 sdf@google.com, 
 Willem de Bruijn <willemb@google.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>
Message-ID: <64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230815171638.4c057dcd@kernel.org>
References: <20230810015751.3297321-1-almasrymina@google.com>
 <20230810015751.3297321-3-almasrymina@google.com>
 <7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
 <20230815171638.4c057dcd@kernel.org>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski wrote:
> On Sun, 13 Aug 2023 19:10:35 -0600 David Ahern wrote:
> > Also, this suggests that the Rx queue is unique to the flow. I do not
> > recall a netdev API to create H/W queues on the fly (only a passing
> > comment from Kuba), so how is the H/W queue (or queue set since a
> > completion queue is needed as well) created for the flow?
> > And in turn if it is unique to the flow, what deletes the queue if
> > an app does not do a proper cleanup? If the queue sticks around,
> > the dmabuf references stick around.
> 
> Let's start sketching out the design for queue config.
> Without sliding into scope creep, hopefully.
> 
> Step one - I think we can decompose the problem into:
>  A) flow steering
>  B) object lifetime and permissions
>  C) queue configuration (incl. potentially creating / destroying queues)
> 
> These come together into use scenarios like:
>  #1 - partitioning for containers - when high perf containers share
>       a machine each should get an RSS context on the physical NIC
>       to have predictable traffic<>CPU placement, they may also have
>       different preferences on how the queues are configured, maybe
>       XDP, too?
>  #2 - fancy page pools within the host (e.g. huge pages)
>  #3 - very fancy page pools not within the host (Mina's work)
>  #4 - XDP redirect target (allowing XDP_REDIRECT without installing XDP
>       on the target)
>  #5 - busy polling - admittedly a bit theoretical, I don't know of
>       anyone busy polling in real life, but one of the problems today
>       is that setting it up requires scraping random bits of info from
>       sysfs and a lot of hoping.
> 
> Flow steering (A) is there today, to a sufficient extent, I think,
> so we can defer on that. Sooner or later we should probably figure
> out if we want to continue down the unruly path of TC offloads or
> just give up and beef up ethtool.
> 
> I don't have a good sense of what a good model for cleanup and
> permissions is (B). All I know is that if we need to tie things to
> processes netlink can do it, and we shouldn't have to create our
> own FS and special file descriptors...
> 
> And then there's (C) which is the main part to talk about.
> The first step IMHO is to straighten out the configuration process.
> Currently we do:
> 
>  user -> thin ethtool API --------------------> driver
>                               netdev core <---'
> 
> By "straighten" I mean more of a:
> 
>  user -> thin ethtool API ---> netdev core ---> driver
> 
> flow. This means core maintains the full expected configuration,
> queue count and their parameters and driver creates those queues
> as instructed.
> 
> I'd imagine we'd need 4 basic ops:
>  - queue_mem_alloc(dev, cfg) -> queue_mem
>  - queue_mem_free(dev, cfg, queue_mem)
>  - queue_start(dev, queue info, cfg, queue_mem) -> errno
>  - queue_stop(dev, queue info, cfg)
> 
> The mem_alloc/mem_free takes care of the commonly missed requirement to
> not take the datapath down until resources are allocated for new config.
> 
> Core then sets all the queues up after ndo_open, and tears down before
> ndo_stop. In case of an ethtool -L / -G call or enabling / disabling XDP
> core can handle the entire reconfiguration dance.
> 
> The cfg object needs to contain all queue configuration, including 
> the page pool parameters.
> 
> If we have an abstract model of the configuration in the core we can
> modify it much more easily, I hope. I mean - the configuration will be
> somewhat detached from what's instantiated in the drivers.
> 
> I'd prefer to go as far as we can without introducing a driver callback
> to "check if it can support a config change", and try to rely on
> (static) capabilities instead. This allows more of the validation to
> happen in the core and also lends itself naturally to exporting the
> capabilities to the user.
> 
> Checking the use cases:
> 
>  #1 - partitioning for containers - storing the cfg in the core gives
>       us a neat ability to allow users to set the configuration on RSS
>       context
>  #2, #3 - page pools - we can make page_pool_create take cfg and read whatever
>       params we want from there, memory provider, descriptor count, recycling
>       ring size etc. Also for header-data-split we may want different settings
>       per queue so again cfg comes in handy
>  #4 - XDP redirect target - we should spawn XDP TX queues independently from
>       the XDP configuration
> 
> That's all I have thought up in terms of direction.
> Does that make sense? What are the main gaps? Other proposals?

More on (A) and (B):

I expect most use cases match the containerization that you mention.
Where a privileged process handles configuration.

For that, the existing interfaces of ethtool -G/-L-/N/-K/-X suffice.

A more far-out approach could infer the ntuple 5-tuple connection or
3-tuple listener rule from a socket itself, no ethtool required. But
let's ignore that for now.

Currently we need to use ethtool -X to restrict the RSS indirection
table to a subset of queues. It is not strictly necessary to
reconfigure the device on each new container, if pre-allocation a
sufficient set of non-RSS queues.

Then only ethtool -N is needed to drive data towards one of the
non-RSS queues. Or one of the non context 0 RSS contexts if that is
used.

The main part that is missing is memory allocation. Memory is stranded
on unused queues, and there is no explicit support for special
allocators.

A poor man's solution might be to load a ring with minimal sized
buffers (assuming devices accept that, say a zero length buffer),
attach a memory provider before inserting an ntuple rule, and refill
from the memory provider. This requires accepting that a whole ring of
packets is lost before refilled slots get filled..

(I'm messing with that with AF_XDP right now: a process that xsk_binds
 before filling the FILL queue..)

Ideally, we would have a way to reconfigure a single queue, without
having to down/up the entire device..

I don't know if the kernel needs an explicit abstract model, or can
leave that to the userspace privileged daemon that presses the ethtool
buttons.

