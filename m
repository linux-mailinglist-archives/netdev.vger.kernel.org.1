Return-Path: <netdev+bounces-28979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4BC7814E8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C2B281D4B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0251BEF9;
	Fri, 18 Aug 2023 21:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03946B0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:52:56 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D63C34
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 14:52:54 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a7781225b4so917774b6e.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692395574; x=1693000374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBwktppDTX5NBZEJHh8nmoWzBkCfUzclaH+HmpPyNv8=;
        b=1MiGhz0olEVCOWgg/3ksDWrbBpqwJQV+vkRJcRsg8mD3cUnVQErnzsObdcGi/Pwpmg
         QdPfkqOGlXZ+77eYkmgdrmab8txc6PWH8sXDB1x2xBwE1ciuHTnB7aylMIwWjOM0fT2l
         20xzO2pQcPKMyvv91zVg75G3nJaGK+JgpeI1tL1Lj5boEoS5nVyiuOdp3tq0MgqBHlD8
         BIazlhTtJrmLcBxzrcuXpQtAuLao/mLSld9BLAD1YmF8UqEeZhNPBbsVb0CZ/Fik6/MY
         9CD5/m3CtltcKO3Qb8z2Df1ZD5lAL3SLRNpYz+i+b105WBI3IcJAIrKr6siaFwrULf3X
         rdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692395574; x=1693000374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBwktppDTX5NBZEJHh8nmoWzBkCfUzclaH+HmpPyNv8=;
        b=LqS8XplLZ+lEN4Mi18cZDIvO6wvMXvaYYH7VKNnZ/nvDfJ54QuA+1n/COm2h+Y+tn4
         4tPom1VwQisG2tiCsWXrYtA1AcZ9a0XnEPnXKbx0CrEsKsgt1RZ2XW7kFEm4Yt/VtLnH
         K2FbUZ4BaLcg7kzgCxYUz5NBYqqtDoQ8c4qDTBQKySgjcZgRuCAzxhMp034KCfcbESQR
         mT+jXn5g+IxwkZRRb/j/lKpz5IGAiiJiWsn0XQWRSWby+x2tKrsM+HpJy9k7XMvhjvVK
         ugEU5600EZd1rFbMCEMtgTHTvAv5UWp4cIoc2ezBy4qj6gkgmt/tNS6ShAK3getzLuhQ
         WgJA==
X-Gm-Message-State: AOJu0Yz2Dv+GF3yi9vRPd3TsFxw2w1lgz+LiUVKC+DRQKbdRHYNUljm6
	Vdky6T0oftoeSp2Pt/ySh3O7VSt9SzNz814XcYhnow==
X-Google-Smtp-Source: AGHT+IHS4XZfPnc32yTxhnQCo7isMuMqHT7Tx9+9eEnjPqX3yLjGaentfvsXdlPeGNOX4h1RMIWvQ8vJxlaRqwbmkf4=
X-Received: by 2002:a05:6358:5286:b0:134:f0c7:90ae with SMTP id
 g6-20020a056358528600b00134f0c790aemr577299rwa.5.1692395573634; Fri, 18 Aug
 2023 14:52:53 -0700 (PDT)
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
In-Reply-To: <20230817190957.571ab350@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 18 Aug 2023 14:52:42 -0700
Message-ID: <CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
To: Jakub Kicinski <kuba@kernel.org>, Praveen Kaligineedi <pkaligineedi@google.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com, 
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

On Thu, Aug 17, 2023 at 7:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 17 Aug 2023 19:33:47 -0600 David Ahern wrote:
> > [ sorry for the delayed response; very busy 2 days ]
>
> Tell me about it :)
>
> > On 8/16/23 10:12 AM, Willem de Bruijn wrote:
> > > Jakub Kicinski wrote:
> > >> Let's start sketching out the design for queue config.
> > >> Without sliding into scope creep, hopefully.
> > >>
> > >> Step one - I think we can decompose the problem into:
> > >>  A) flow steering
> > >>  B) object lifetime and permissions
> > >>  C) queue configuration (incl. potentially creating / destroying que=
ues)
> > >>
> > >> These come together into use scenarios like:
> > >>  #1 - partitioning for containers - when high perf containers share
> > >>       a machine each should get an RSS context on the physical NIC
> > >>       to have predictable traffic<>CPU placement, they may also have
> > >>       different preferences on how the queues are configured, maybe
> > >>       XDP, too?
> >
> > subfunctions are a more effective and simpler solution for containers, =
no?
>
> Maybe, subfunctions offload a lot, let's not go too far into the weeds
> on production and flexibility considerations but they wouldn't be my
> first choice.
>
> > >>  #2 - fancy page pools within the host (e.g. huge pages)
> > >>  #3 - very fancy page pools not within the host (Mina's work)
> > >>  #4 - XDP redirect target (allowing XDP_REDIRECT without installing =
XDP
> > >>       on the target)
> > >>  #5 - busy polling - admittedly a bit theoretical, I don't know of
> > >>       anyone busy polling in real life, but one of the problems toda=
y
> > >>       is that setting it up requires scraping random bits of info fr=
om
> > >>       sysfs and a lot of hoping.
> > >>
> > >> Flow steering (A) is there today, to a sufficient extent, I think,
> > >> so we can defer on that. Sooner or later we should probably figure
> > >> out if we want to continue down the unruly path of TC offloads or
> > >> just give up and beef up ethtool.
> >
> > Flow steering to TC offloads -- more details on what you were thinking =
here?
>
> I think TC flower can do almost everything ethtool -N can.
> So do we continue to developer for both APIs or pick one?
>
> > >> I don't have a good sense of what a good model for cleanup and
> > >> permissions is (B). All I know is that if we need to tie things to
> > >> processes netlink can do it, and we shouldn't have to create our
> > >> own FS and special file descriptors...
> >
> > From my perspective the main sticking point that has not been handled i=
s
> > flushing buffers from the RxQ, but there is 100% tied to queue
> > management and a process' ability to effect a flush or queue tear down =
-
> > and that is the focus of your list below:
>
> If you're thinking about it from the perspective of "application died
> give me back all the buffers" - the RxQ is just one piece, right?
> As we discovered with page pool - packets may get stuck in stack for
> ever.
>
> > >> And then there's (C) which is the main part to talk about.
> > >> The first step IMHO is to straighten out the configuration process.
> > >> Currently we do:
> > >>
> > >>  user -> thin ethtool API --------------------> driver
> > >>                               netdev core <---'
> > >>
> > >> By "straighten" I mean more of a:
> > >>
> > >>  user -> thin ethtool API ---> netdev core ---> driver
> > >>
> > >> flow. This means core maintains the full expected configuration,
> > >> queue count and their parameters and driver creates those queues
> > >> as instructed.
> > >>
> > >> I'd imagine we'd need 4 basic ops:
> > >>  - queue_mem_alloc(dev, cfg) -> queue_mem
> > >>  - queue_mem_free(dev, cfg, queue_mem)
> > >>  - queue_start(dev, queue info, cfg, queue_mem) -> errno
> > >>  - queue_stop(dev, queue info, cfg)
> > >>
> > >> The mem_alloc/mem_free takes care of the commonly missed requirement=
 to
> > >> not take the datapath down until resources are allocated for new con=
fig.
> >
> > sounds reasonable.
> >

Thanks for taking the time to review & provide suggestions. I do need
to understand concrete changes to apply to the next revision. Here is
my understanding so far, please correct if wrong, and sorry if I
didn't capture everything you want:

The sticking points are:
1. From David: this proposal doesn't give an application the ability
to flush an rx queue, which means that we have to rely on a driver
reset that affects all queues to refill the rx queue buffers.
2. From Jakub: the uAPI and implementation here needs to be in line
with his general direction & extensible to apply to existing use cases
`ethtool -L/-G`, etc.

AFAIU this is what I need to do in the next version:

1. The uAPI will be changed such that it will either re-configure an
existing queue to bind it to the dma-buf, or allocate a new queue
bound to the dma-buf (not sure which is better at the moment). Either
way, the configuration will take place immediately, and not rely on an
entire driver reset to actuate the change.

2. The uAPI will be changed such that if the netlink socket is closed,
or the process dies, the rx queue will be unbound from the dma-buf or
the rx queue will be freed entirely (again, not sure which is better
at the moment). The configuration will take place immediately without
relying on a driver reset.

3. I will add 4 new net_device_ops that Jakub specified:
queue_mem_alloc/free(), and queue_start/stop().

4. The uAPI mentioned in #1 will use the new net_device_ops to
allocate or reconfigure a queue attached to the provided dma-buf.

Does this sound roughly reasonable here?

AFAICT the only technical difficulty is that I'm not sure it's
feasible for a driver to start or stop 1 rx-queue without triggering a
full driver reset. The (2) drivers I looked at both do a full reset to
change any queue configuration. I'll investigate.

> > >>
> > >> Core then sets all the queues up after ndo_open, and tears down befo=
re
> > >> ndo_stop. In case of an ethtool -L / -G call or enabling / disabling=
 XDP
> > >> core can handle the entire reconfiguration dance.
> >
> > `ethtool -L/-G` and `ip link set {up/down}` pertain to the "general OS"
> > queues managed by a driver for generic workloads and networking
> > management (e.g., neigh discovery, icmp, etc). The discussions here
> > pertains to processes wanting to use their own memory or GPU memory in =
a
> > queue. Processes will come and go and the queue management needs to
> > align with that need without affecting all of the other queues managed
> > by the driver.
>
> For sure, I'm just saying that both the old uAPI can be translated to
> the new driver API, and so should the new uAPIs. I focused on the
> driver facing APIs because I think that it's the hard part. We have
> many drivers, the uAPI is more easily dreamed up, no?
>
> > >> The cfg object needs to contain all queue configuration, including
> > >> the page pool parameters.
> > >>
> > >> If we have an abstract model of the configuration in the core we can
> > >> modify it much more easily, I hope. I mean - the configuration will =
be
> > >> somewhat detached from what's instantiated in the drivers.
> > >>
> > >> I'd prefer to go as far as we can without introducing a driver callb=
ack
> > >> to "check if it can support a config change", and try to rely on
> > >> (static) capabilities instead. This allows more of the validation to
> > >> happen in the core and also lends itself naturally to exporting the
> > >> capabilities to the user.
> > >>
> > >> Checking the use cases:
> > >>
> > >>  #1 - partitioning for containers - storing the cfg in the core give=
s
> > >>       us a neat ability to allow users to set the configuration on R=
SS
> > >>       context
> > >>  #2, #3 - page pools - we can make page_pool_create take cfg and rea=
d whatever
> > >>       params we want from there, memory provider, descriptor count, =
recycling
> > >>       ring size etc. Also for header-data-split we may want differen=
t settings
> > >>       per queue so again cfg comes in handy
> > >>  #4 - XDP redirect target - we should spawn XDP TX queues independen=
tly from
> > >>       the XDP configuration
> > >>
> > >> That's all I have thought up in terms of direction.
> > >> Does that make sense? What are the main gaps? Other proposals?
> > >
> > > More on (A) and (B):
> > >
> > > I expect most use cases match the containerization that you mention.
> > > Where a privileged process handles configuration.
> > >
> > > For that, the existing interfaces of ethtool -G/-L-/N/-K/-X suffice.
> > >
> > > A more far-out approach could infer the ntuple 5-tuple connection or
> > > 3-tuple listener rule from a socket itself, no ethtool required. But
> > > let's ignore that for now.
> > >
> > > Currently we need to use ethtool -X to restrict the RSS indirection
> > > table to a subset of queues. It is not strictly necessary to
> > > reconfigure the device on each new container, if pre-allocation a
> > > sufficient set of non-RSS queues.
> >
> > This is an interesting approach: This scheme here is along the lines of
> > you have N cpus in the server, so N queue sets (or channels). The
> > indirection table means M queue sets are used for RSS leaving N-M queue=
s
> > for flows with "fancy memory providers". Such a model can work but it i=
s
> > quite passive, needs careful orchestration and has a lot of moving,
> > disjointed pieces - with some race conditions around setup vs first dat=
a
> > packet arriving.
> >
> > I was thinking about a more generic design where H/W queues are created
> > and destroyed - e.g., queues unique to a process which makes the cleanu=
p
> > so much easier.
>
> FWIW what Willem describes is what we were telling people to do for
> AF_XDP for however many years it existed.
>
> > > Then only ethtool -N is needed to drive data towards one of the
> > > non-RSS queues. Or one of the non context 0 RSS contexts if that is
> > > used.
> > >
> > > The main part that is missing is memory allocation. Memory is strande=
d
> > > on unused queues, and there is no explicit support for special
> > > allocators.
> > >
> > > A poor man's solution might be to load a ring with minimal sized
> > > buffers (assuming devices accept that, say a zero length buffer),
> > > attach a memory provider before inserting an ntuple rule, and refill
> > > from the memory provider. This requires accepting that a whole ring o=
f
> > > packets is lost before refilled slots get filled..
> > >
> > > (I'm messing with that with AF_XDP right now: a process that xsk_bind=
s
> > >  before filling the FILL queue..)
> > >
> > > Ideally, we would have a way to reconfigure a single queue, without
> > > having to down/up the entire device..
> > >
> > > I don't know if the kernel needs an explicit abstract model, or can
> > > leave that to the userspace privileged daemon that presses the ethtoo=
l
> > > buttons.
> >
> > The kernel has that in the IB verbs S/W APIs. Yes, I realize that
> > comment amounts to profanity on this mailing list, but it should not be=
.
> > There are existing APIs for creating, managing and destroying queues -
> > open source, GPL'ed, *software* APIs that are open for all to use.
> >
> > That said, I have no religion here. If the netdev stack wants new APIs
> > to manage queues - including supplying buffers - drivers will have APIs
> > that can be adapted to some new ndo to create, configure, and destroy
> > queues. The ethtool API can be updated to manage that. Ultimately I
> > believe anything short of dynamic queue management will be a band-aid
> > approach that will have a lot of problems.
>
> No religion here either, but the APIs we talk about are not
> particularly complex. Having started hacking things together
> with page pools, huge pages, RSS etc - IMHO the reuse and convergence
> would be very superficial.



--=20
Thanks,
Mina

