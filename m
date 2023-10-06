Return-Path: <netdev+bounces-38629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BC7BBBDE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419031C209A9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8127EEB;
	Fri,  6 Oct 2023 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0dIBLAB6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311327EC9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:37:55 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221BCA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:37:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9191f0d94cso2453796276.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696606673; x=1697211473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXV02auOVKY0Eh/1Lf3xYajyYJX1gh0qNrCPOAqR7RQ=;
        b=0dIBLAB6EqTXLKy6y2Sr1h33qeAwqWxekhcehxvvVDl0ks00B+sCIYEzwP0c+G0OLN
         vH42I1aqdb1A15uZuS7Fud3fP7wiHSW03/dhqi3oMJpT1gNFRp3bOCWCpNKodDuZ482x
         a30cWV8iyS3vdHC3nVfq5l9mQC8X06XP2uIoDwZcJT7BEVilZjrkODlSmfQZoMAwOiNN
         u7WBwsqhIwDLftcD3yfIMcMMhXKYROqYWuZNJ5XU0yVlbfBWP7zdkcdNeJ1BADVfV+Zn
         B46nILydcFsgtUubqcQTv8b+VCEZyAjJwtnMWsq5XB2adBRE1f2qDbwoO6YvGsDXUD0y
         +4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606673; x=1697211473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXV02auOVKY0Eh/1Lf3xYajyYJX1gh0qNrCPOAqR7RQ=;
        b=Wcvp5L2tBFi4AlrS78W+jcpcwa/jpqHakLkh6YBToB55GvBuuEsM39S+1z/cQJpjt9
         xzrSuBcw6oI9A6FzoIX6n7inOlisgj/0xxV0+zlQ2UX7xDdlyXDq+ps4plRPL+9kuYRG
         WjQR9fM5aHxnPXzuEhwvuDe4kUXJXwUZ/oY1+bOUhes7Arxk0F9zDGTEKWT5Y5AKhQ6c
         ExuMLwdGwncEunw4OfmFGrqNzIXbwNNjAt0j+E90vHDOfBBJ+bFlOm/D5MwMce0vPm8u
         iNY1dd4sl/WrMiUja2S7jPEXQWCsp1h6pwF+agenpWc2bTk2SDzhUMOSCwfwxK1zAJX/
         BOIw==
X-Gm-Message-State: AOJu0Ywmsmacpttb3c7n0vM6JTPATwIhfkJ1nq2dq67sAZxbqRSXfGCN
	q82/bS/Sfm9Vdqk60p7FImk6bM5ANVX/nWwAaDnGvg==
X-Google-Smtp-Source: AGHT+IF6duaix7Wm0AEVmIWIiLwSHJ/xhoyBZKk+OltOaLCzYcH65hughoQVPeruM9mvNP5X6OEfGA4QOCmJY4+jyJ8=
X-Received: by 2002:a25:2f55:0:b0:d78:35cd:7f5c with SMTP id
 v82-20020a252f55000000b00d7835cd7f5cmr8649796ybv.46.1696606673592; Fri, 06
 Oct 2023 08:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005184228.467845-1-victor@mojatatu.com> <ZSAEp+tr1oXHOy/C@nanopsycho>
In-Reply-To: <ZSAEp+tr1oXHOy/C@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Oct 2023 11:37:41 -0400
Message-ID: <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
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

On Fri, Oct 6, 2023 at 8:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Oct 05, 2023 at 08:42:25PM CEST, victor@mojatatu.com wrote:
> >__Context__
> >The "tc block" is a collection of netdevs/ports which allow qdiscs to sh=
are
> >match-action block instances (as opposed to the traditional tc filter pe=
r
> >netdev/port)[1].
> >
> >Example setup:
> >$ tc qdisc add dev ens7 ingress block 22
> >$ tc qdisc add dev ens8 ingress block 22
> >
> >Once the block is created we can add a filter using the block index:
> >$ tc filter add block 22 protocol ip pref 25 \
> >  flower dst_ip 192.168.0.0/16 action drop
> >
> >A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
> >either ens7 or ens8 is dropped.
> >
> >__This patchset__
> >Up to this point in the implementation, the block is unaware of its port=
s.
> >This patch fixes that and makes the tc block ports available to the
>
> Odd. You fix a bug. Is there a bug? If yes, you need to describe it. If
> no, don't use "fix".

Ok, Jiri;->  we will change the language.

>
> >datapath.
> >
> >For the datapath we provide a use case of the tc block in an action
> >we call "blockcast" in patch 3. This action can be used in an example as
> >such:
> >
> >$ tc qdisc add dev ens7 ingress block 22
> >$ tc qdisc add dev ens8 ingress block 22
> >$ tc qdisc add dev ens9 ingress block 22
> >$ tc filter add block 22 protocol ip pref 25 \
> >  flower dst_ip 192.168.0.0/16 action blockcast
>
> Seems to me a bit odd that the action works with the entity (block) is
> is connected to. I would expect rather to give the action configuration:
>
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast block 22
>                                                 ^^^^^^^^

We are currently passing the blockid in the skb cb field so it is
configuration-less. I suppose we could add this as an optional field
and use it when specified.

> Then this is more flexible and allows user to use this action for any
> packet, no matter from where it was received.
>
> Looks like this is functionality-wise similar to mirred redirect. Why
> can't we have that action extended to accept block number instead of
> netdev and have something like:
>
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>
> This would be very much alike we do either "tc filter add dev X" or "tc
> filter add block Y".
>

We did consider it but concluded it is a lot of work to get it done on
mirred - just take a look at mirred and you'll see what i mean;->
Based on that review we came to the conclusion that at some point it
would be safer to separate mirred's mirror from redirect; there are
too many checks to avoid one or the other based on whether you are
coming from egress vs ingress etc. This one is simple, it is just a
broadcast.


> Regarding the filtering, that could be a simple flag config of mirred
> action:
>
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>   srcfilter
>
> Or something like that.
>

See my comment above.

cheers,
jamal
> Makes sense?
>
>
>
> >
> >When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of =
any
> >of ens7, ens8 or ens9 it will be copied to all ports other than itself.
> >For example, if it arrives on ens8 then a copy of the packet will be
> >"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens8.
> >
> >Patch 1 introduces the required infra. Patch 2 exposes the tc block to t=
he
> >tc datapath and patch 3 implements datapath usage via a new tc action
> >"blockcast".
> >
> >__Acknowledgements__
> >Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patch=
set
> >better. The idea of integrating the ports into the tc block was suggeste=
d
> >by Jiri Pirko.
> >
> >[1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to-sh=
are-filter-block-instances'")
> >
> >Changes in v2:
> >  - Remove RFC tag
> >  - Add more details in patch 0(Jiri)
> >  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
> >    Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.org=
)
> >  - Fix bad dev dereference in printk of blockcast action (Simon)
> >
> >Changes in v3:
> >  - Add missing xa_destroy (pointed out by Vlad)
> >  - Remove bugfix pointed by Vlad (will send in separate patch)
> >  - Removed ports from subject in patch #2 and typos (suggested by Marce=
lo)
> >  - Remove net_notice_ratelimited debug messages in error
> >    cases (suggested by Marcelo)
> >  - Minor changes to appease sparse's lock context warning
> >
> >Changes in v4:
> >  - Avoid code repetition using gotos in cast_one (suggested by Paolo)
> >  - Fix typo in cover letter (pointed out by Paolo)
> >  - Create a module description for act_blockcast
> >    (reported by Paolo and CI)
> >
> >Victor Nogueira (3):
> >  net/sched: Introduce tc block netdev tracking infra
> >  net/sched: cls_api: Expose tc block to the datapath
> >  net/sched: act_blockcast: Introduce blockcast tc action
> >
> > include/net/sch_generic.h    |   8 +
> > include/net/tc_wrapper.h     |   5 +
> > include/uapi/linux/pkt_cls.h |   1 +
> > net/sched/Kconfig            |  13 ++
> > net/sched/Makefile           |   1 +
> > net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++++
> > net/sched/cls_api.c          |  12 +-
> > net/sched/sch_api.c          |  58 +++++++
> > net/sched/sch_generic.c      |  34 +++-
> > 9 files changed, 426 insertions(+), 3 deletions(-)
> > create mode 100644 net/sched/act_blockcast.c
> >
> >--
> >2.25.1
> >

