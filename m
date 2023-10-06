Return-Path: <netdev+bounces-38658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7BF7BBF8A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A622820D8
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68E3AC06;
	Fri,  6 Oct 2023 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xg77lH0z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DD200D5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 19:06:59 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297DA6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:06:57 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso2689897276.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696619217; x=1697224017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZpPRsBUjOXxt5IypfkG995z5itVKazxFFz+RrCAxMs=;
        b=xg77lH0zGzFV5a++B8QDBeKaSGfpLGcdwqq8AMUzkZjVdmOeO3G5L4H9CrVYxNS5+Z
         8ECLoOmiVk9rRLZjYe0JvlobKg8H5AxhHyIXDaSFQ9wGewPNFLbIaT84zzcxWW8z1ai4
         0LI3j74zSD8vR9a7BobTph639sGMGLAt46zyaloS1MFR/Hj4eRgL25+Er2FF1pyoDaf5
         20p4xZdRrc9MGbvTy260LvrCzwgdJB2GS5RGM3pCwrmo/3e6NNks8lt7nsUwL4IcJlxH
         j9tpplzupgId/olH9sObEXStkp8RqfflBPSy0VGAUpo3UyrWWaI4jErIQfvkUqZ2Jk36
         guwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619217; x=1697224017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZpPRsBUjOXxt5IypfkG995z5itVKazxFFz+RrCAxMs=;
        b=QfY4Yyj15Lcf6U+Fg6xe/R0GPUL94rgw/ekvvtNRa0sOypa3yICydBESTZuT9kYgjm
         VeVTiG1k8Me8Kpcg8D/xR9aOHcjiMPbsD49QDSnTVKuX5x80fwVpT1tbGfmdFnHZT8HT
         tpb30lHlfHUBph0ma1A/zTVYxZ2gQZCSYpz2YzQ8Vv8hAHDCKsqPM+yK4ejIBgZsQbLZ
         5+pOPaROz+SlrWqcFNx+CIJV91V5BWgAOBA1HQsR3BMp5XO5rW5XOy4gGJrA/Zv9vlHm
         CGhPAPm/j52sPjPu6xMhfa8WB2RPyr6CN3GfoYDmbwdy/k6Qcjw4aDJ9qwp9SoS/opBM
         /58w==
X-Gm-Message-State: AOJu0YzXf2q8vgeB0+cpsERCCmyk5DUR0MOTUooc40+v09VjdwV86Lvc
	PcwcSC2iapanMWzJHjeB7HNz0lOocFXk9owkrxDZoA==
X-Google-Smtp-Source: AGHT+IGHTjCgX+/2QiWS+SMpS9cKC+4oE/6qOlt/hD/bzaS7Rh3CTOQOqUXf2preSwKP/2doCh1zOFrtYL2o3hsWL0w=
X-Received: by 2002:a5b:f01:0:b0:d85:22:8215 with SMTP id x1-20020a5b0f01000000b00d8500228215mr7832660ybr.34.1696619216947;
 Fri, 06 Oct 2023 12:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005184228.467845-1-victor@mojatatu.com> <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com> <ZSA60cyLDVw13cLi@nanopsycho>
In-Reply-To: <ZSA60cyLDVw13cLi@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Oct 2023 15:06:45 -0400
Message-ID: <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Jiri Pirko <jiri@resnulli.us>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, mleitner@redhat.com, 
	vladbu@nvidia.com, simon.horman@corigine.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 12:50=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Oct 06, 2023 at 05:37:41PM CEST, jhs@mojatatu.com wrote:
> >On Fri, Oct 6, 2023 at 8:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Thu, Oct 05, 2023 at 08:42:25PM CEST, victor@mojatatu.com wrote:
> >> >__Context__
> >> >The "tc block" is a collection of netdevs/ports which allow qdiscs to=
 share
> >> >match-action block instances (as opposed to the traditional tc filter=
 per
> >> >netdev/port)[1].
> >> >
> >> >Example setup:
> >> >$ tc qdisc add dev ens7 ingress block 22
> >> >$ tc qdisc add dev ens8 ingress block 22
> >> >
> >> >Once the block is created we can add a filter using the block index:
> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >  flower dst_ip 192.168.0.0/16 action drop
> >> >
> >> >A packet with dst IP matching 192.168.0.0/16 arriving on the ingress =
of
> >> >either ens7 or ens8 is dropped.
> >> >
> >> >__This patchset__
> >> >Up to this point in the implementation, the block is unaware of its p=
orts.
> >> >This patch fixes that and makes the tc block ports available to the
> >>
> >> Odd. You fix a bug. Is there a bug? If yes, you need to describe it. I=
f
> >> no, don't use "fix".
> >
> >Ok, Jiri;->  we will change the language.
> >
> >>
> >> >datapath.
> >> >
> >> >For the datapath we provide a use case of the tc block in an action
> >> >we call "blockcast" in patch 3. This action can be used in an example=
 as
> >> >such:
> >> >
> >> >$ tc qdisc add dev ens7 ingress block 22
> >> >$ tc qdisc add dev ens8 ingress block 22
> >> >$ tc qdisc add dev ens9 ingress block 22
> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >  flower dst_ip 192.168.0.0/16 action blockcast
> >>
> >> Seems to me a bit odd that the action works with the entity (block) is
> >> is connected to. I would expect rather to give the action configuratio=
n:
> >>
> >> $ tc filter add block 22 protocol ip pref 25 \
> >>   flower dst_ip 192.168.0.0/16 action blockcast block 22
> >>                                                 ^^^^^^^^
> >
> >We are currently passing the blockid in the skb cb field so it is
> >configuration-less. I suppose we could add this as an optional field
> >and use it when specified.
>
> I don't understand the need for configuration less here. You don't have
> it for the rest of the actions. Why this is special?

It is not needed really. Think of an L2 switch - the broadcast action
is to send to all ports but self.

>
> >
> >> Then this is more flexible and allows user to use this action for any
> >> packet, no matter from where it was received.
> >>
> >> Looks like this is functionality-wise similar to mirred redirect. Why
> >> can't we have that action extended to accept block number instead of
> >> netdev and have something like:
> >>
> >> $ tc filter add block 22 protocol ip pref 25 \
> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
> >>
> >> This would be very much alike we do either "tc filter add dev X" or "t=
c
> >> filter add block Y".
> >>
> >
> >We did consider it but concluded it is a lot of work to get it done on
> >mirred - just take a look at mirred and you'll see what i mean;->
> >Based on that review we came to the conclusion that at some point it
> >would be safer to separate mirred's mirror from redirect; there are
> >too many checks to avoid one or the other based on whether you are
> >coming from egress vs ingress etc. This one is simple, it is just a
> >broadcast.
>
> Perhaps it is a nice opportunity to do such mirred cleanup, prepare the
> code and implement block send afterwards?

I was worried about breaking some existing use cases - the code has
got too clever.
But probably it is time to show it some love, one of us will invest
time into it.

> If I omit the code for now, from user perspective, this functionality
> belongs into mirred, don't you think? Just replace "dev" by "block" and
> you got what you need.

If we can adequately cleanup mirred,  then we can put it there but
certainly now we are adding more buttons to click on mirred. It may
make sense to refactor the mirred code then reuse the refactored code
in a new action.

cheers,
jamal

>
> >
> >
> >> Regarding the filtering, that could be a simple flag config of mirred
> >> action:
> >>
> >> $ tc filter add block 22 protocol ip pref 25 \
> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
> >>   srcfilter
> >>
> >> Or something like that.
> >>
> >
> >See my comment above.
> >
> >cheers,
> >jamal
> >> Makes sense?
> >>
> >>
> >>
> >> >
> >> >When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress =
of any
> >> >of ens7, ens8 or ens9 it will be copied to all ports other than itsel=
f.
> >> >For example, if it arrives on ens8 then a copy of the packet will be
> >> >"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens8.
> >> >
> >> >Patch 1 introduces the required infra. Patch 2 exposes the tc block t=
o the
> >> >tc datapath and patch 3 implements datapath usage via a new tc action
> >> >"blockcast".
> >> >
> >> >__Acknowledgements__
> >> >Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this pa=
tchset
> >> >better. The idea of integrating the ports into the tc block was sugge=
sted
> >> >by Jiri Pirko.
> >> >
> >> >[1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to=
-share-filter-block-instances'")
> >> >
> >> >Changes in v2:
> >> >  - Remove RFC tag
> >> >  - Add more details in patch 0(Jiri)
> >> >  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
> >> >    Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.=
org)
> >> >  - Fix bad dev dereference in printk of blockcast action (Simon)
> >> >
> >> >Changes in v3:
> >> >  - Add missing xa_destroy (pointed out by Vlad)
> >> >  - Remove bugfix pointed by Vlad (will send in separate patch)
> >> >  - Removed ports from subject in patch #2 and typos (suggested by Ma=
rcelo)
> >> >  - Remove net_notice_ratelimited debug messages in error
> >> >    cases (suggested by Marcelo)
> >> >  - Minor changes to appease sparse's lock context warning
> >> >
> >> >Changes in v4:
> >> >  - Avoid code repetition using gotos in cast_one (suggested by Paolo=
)
> >> >  - Fix typo in cover letter (pointed out by Paolo)
> >> >  - Create a module description for act_blockcast
> >> >    (reported by Paolo and CI)
> >> >
> >> >Victor Nogueira (3):
> >> >  net/sched: Introduce tc block netdev tracking infra
> >> >  net/sched: cls_api: Expose tc block to the datapath
> >> >  net/sched: act_blockcast: Introduce blockcast tc action
> >> >
> >> > include/net/sch_generic.h    |   8 +
> >> > include/net/tc_wrapper.h     |   5 +
> >> > include/uapi/linux/pkt_cls.h |   1 +
> >> > net/sched/Kconfig            |  13 ++
> >> > net/sched/Makefile           |   1 +
> >> > net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++=
++
> >> > net/sched/cls_api.c          |  12 +-
> >> > net/sched/sch_api.c          |  58 +++++++
> >> > net/sched/sch_generic.c      |  34 +++-
> >> > 9 files changed, 426 insertions(+), 3 deletions(-)
> >> > create mode 100644 net/sched/act_blockcast.c
> >> >
> >> >--
> >> >2.25.1
> >> >

