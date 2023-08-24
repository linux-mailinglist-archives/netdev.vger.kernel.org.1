Return-Path: <netdev+bounces-30380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA707870CF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073332815FA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4879100BC;
	Thu, 24 Aug 2023 13:47:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD42891B
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:47:36 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FF9A8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:47:34 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58dfe2d5b9aso12980567b3.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692884854; x=1693489654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w2OhhcQJjuqQ4ahLURtI+WyuwCALYntZIUGJyH2H/c=;
        b=IOLbb3RHErgwQaeIl+eG8kaZPTR58zn+Crjd/Rr7LAZntNiWQNwi+1FL1yN8zUjMrZ
         ZvTUJKnJ3jDRTCH306yunZningJZxyT5XBOXZL6LhcGTW1KNbU5AnqPE6zoAi44AZHar
         LeV5u512VD75Y2Z5LRJQ1a1jN+26uOE+LJrM79oNri3zqIymGdSDdzbxuTYC+KyYd4wC
         U1qMoQrTVoBtWp0NgVqX0pQuwYyXXpn8XvRZwvRiGBsFXXV1nKafKhX79OQDVqqOOJC6
         TTHU24RqbIjF820nxuHO9RZZN0Q3jVH55Tx+38/kacpm50+vtrmQ2Ye1TsvIjFJMHPtp
         tCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692884854; x=1693489654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w2OhhcQJjuqQ4ahLURtI+WyuwCALYntZIUGJyH2H/c=;
        b=O6YK7cyGAbvQqF6M0yUc2oMOz4Tex1WcyjzBx7D2w9gfdU6BKHIoRy9oiksnsqK1Et
         gOoaegTCgTfOkpY4xA/vZCllOhK2IbpL2uYVNo83gCw/TKwNYxxffX8RYt4sd6EnHCXG
         3eisQ+oYHveB9unXfy0qwaHapcdXwQObVluLeA9ON26xbEp2Giok3irtx3ifMNgzAxF4
         wvR07YyBsVoahKGnAsKGQfG6IkUp1E/XdydJIab7IBqJqFqZ8wimFz06/8+gdLpyEq1v
         ReHX5SI7dcYHbMPYxaXeestLao2vcZ2ix3Z/CTJsUu/m9DGrmPKjYbcs4BJMse/2eWm1
         jRAA==
X-Gm-Message-State: AOJu0YwyTDFR6a1dySmqXVWNgF/79rqQFlZzgAbLg38uAZNzVR0lTuwE
	hTW/UmZufHVmXmiqKPWVtiz4arTY6pcrHwBujfBa/nL5Nrige2zH
X-Google-Smtp-Source: AGHT+IFBqLY4xL/WAPWJysdexoFxTO8J7/oC39jT/pBG0zbgNPECsiqQzIAGxuIOexHYvod+UgMfj40/ywiZ9WFkkqU=
X-Received: by 2002:a0d:cbcd:0:b0:592:4c2:1514 with SMTP id
 n196-20020a0dcbcd000000b0059204c21514mr12606667ywd.25.1692884853840; Thu, 24
 Aug 2023 06:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819163515.2266246-1-victor@mojatatu.com> <875y586whs.fsf@nvidia.com>
In-Reply-To: <875y586whs.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Aug 2023 09:47:22 -0400
Message-ID: <CAM0EoMkae4AnM=j3v7dMTwaxZQjmQR9LDmp8fPL8k7KX9kCqgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, mleitner@redhat.com, horms@kernel.org, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 3:12=E2=80=AFPM Vlad Buslov <vladbu@nvidia.com> wro=
te:
>
> On Sat 19 Aug 2023 at 13:35, Victor Nogueira <victor@mojatatu.com> wrote:
> > __context__
> > The "tc block" is a collection of netdevs/ports which allow qdiscs to s=
hare
> > match-action block instances (as opposed to the traditional tc filter p=
er
> > netdev/port)[1].
> >
> > Example setup:
> > $ tc qdisc add dev ens7 ingress block 22
> > $ tc qdisc add dev ens8 ingress block 22
> >
> > Once the block is created we can add a filter using the block index:
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action drop
> >
> > A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
> > either ens7 or ens8 is dropped.
> >
> > __this patchset__
> > Up to this point in the implementation, the block is unaware of its por=
ts.
> > This patch fixes that and makes the tc block ports available to the
> > datapath as well as the offload control path (by virtue of the ports be=
ing
> > in the tc block structure).
>
> Could you elaborate on offload control path? I guess I'm missing
> something here because struct flow_cls_offload doesn't seem to include
> pointer to the parent tcf_block instance.
>

Sorry - that statement was subconsciously over-reaching as far as this
patch is concerned, but talking from P4TC pov, (even though the
current submission for P4TC is s/w only):
A single PCI device is mapped to at least one PF and possibly many VFs
- this gets mapped to a tc block...
Then the tc filter adds the P4 program to a block. The goal then is to
send a table entry towards the driver, once instead of replicating it
many times.
This can be achieved either at a) the tc layer by keeping the entries
per block and only invoke the driver once or b) let the driver
maintain the state (with or without the tc block).
For P4TC either is achievable because the tables are "global". The
challenge is how to get the driver to be aware of the tc block.
To answer your question, the idea is to be able to pass this list of
ports per block to the driver (which as you point out doesnt exist
today, but should be easy to add).

Thoughts?

cheers,
jamal


> >
> > For the datapath we provide a use case of the tc block in an action
> > we call "blockcast" in patch 3. This action can be used in an example a=
s
> > such:
> >
> > $ tc qdisc add dev ens7 ingress block 22
> > $ tc qdisc add dev ens8 ingress block 22
> > $ tc qdisc add dev ens9 ingress block 22
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action blockcast
> >
> > When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of=
 any
> > of ens7, ens8 or ens9 it will be copied to all ports other than itself.
> > For example, if it arrives on ens8 then a copy of the packet will be
> > "blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens7.
> >
> > For an offload path, one use case is to "group" all ports belonging to =
a
> > PCI device into the same tc block.
> >
> > Patch 1 introduces the required infra. Patch 2 exposes the tc block to =
the
> > tc datapath and patch 3 implements datapath usage via a new tc action
> > "blockcast".
> >
> > __Acknowledgements__
> > Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patc=
hset
> > better. The idea of integrating the ports into the tc block was suggest=
ed
> > by Jiri Pirko.
> >
> > [1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to-s=
hare-filter-block-instances'")
> >
> > Changes in v2:
> >   - Remove RFC tag
> >   - Add more details in patch 0(Jiri)
> >   - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
> >     Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.or=
g)
> >   - Fix bad dev dereference in printk of blockcast action (Simon)
> >
> > Victor Nogueira (3):
> >   net/sched: Introduce tc block netdev tracking infra
> >   net/sched: cls_api: Expose tc block ports to the datapath
> >   Introduce blockcast tc action
> >
> >  include/net/sch_generic.h |   8 +
> >  include/net/tc_wrapper.h  |   5 +
> >  net/sched/Kconfig         |  13 ++
> >  net/sched/Makefile        |   1 +
> >  net/sched/act_blockcast.c | 299 ++++++++++++++++++++++++++++++++++++++
> >  net/sched/cls_api.c       |  11 +-
> >  net/sched/sch_api.c       |  79 +++++++++-
> >  net/sched/sch_generic.c   |  40 ++++-
> >  8 files changed, 449 insertions(+), 7 deletions(-)
> >  create mode 100644 net/sched/act_blockcast.c
>

