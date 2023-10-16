Return-Path: <netdev+bounces-41568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2653F7CB56C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B69EBB20E8B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F4381B3;
	Mon, 16 Oct 2023 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pBWs+/DA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858C37CA9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:44:35 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06074AC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:44:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7d9d357faso63707527b3.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697492672; x=1698097472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+z4FdNXSLaYJMM+7GsdkqBi1wZsXN5MciTaA77+IsU=;
        b=pBWs+/DAT9mn+6BfCTZRH8in2qzjm35pz9VKmOAtc8uA1nYTjNcLKZYmYvVBisDErC
         x15Rv0nCrWGuvzGK6FkmO7hTcc/z8BikGidxD/4N2mKDKfIaAeTqiMEA6XBahRClfhU2
         JqqcmZykfaEXBRptxSYDLlU4ujOKN549T13G243K3387tr+eiAkLe8uPL0tEUHaXCRrc
         OD2kDYhXCo5fpKi4XK8GrkFuboBoCyKNmoqJPgEoyFtsyJjDQke3IBZJDsqGKz/5UPd7
         q04bQjkUTlSIi8eUHQjD30SzjdWfQpDMRQIgyP5auryExavN5wlIWiEooOVA7B5qZyqA
         xIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492672; x=1698097472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+z4FdNXSLaYJMM+7GsdkqBi1wZsXN5MciTaA77+IsU=;
        b=koYhMnuI435Khvu5MIPq+MNVEA/yPY46nGFOMgd7P6j1yHD8k/AcXNmXVVu5bOTH99
         qcLxa1FKCbco/2AZBazbw0T1voYDmzdFNenAfRN3u7MZ0waD3B7pIwnTOnqJNBN4agdD
         tHezclPy+Wz+XUDtQgp1zijTBq6dZPwer0EWchZKeCdJzJIqaFANpllS2P0OtAgsO3Tl
         pBQzwB0h73rDEr9RynhLlgtacBjO4KYHfDQamMVEsm7bCn1XIlvrnPGQYn2LCeIn1rRu
         QKz5JX48erGxitxMavddrgW0DXUhqQSrI+JYVOK7L7AwbYlfHo8oHKN75NI+ugUlECtK
         UAXw==
X-Gm-Message-State: AOJu0YytLpapDUEAqTpUNem2sAERLNCKnxeRqLxJDoGGpPn2ofpisteh
	+wF3A2xckuJY6tauvjE7HH8mFzeG2FKlxg238HfgfQ==
X-Google-Smtp-Source: AGHT+IEFNCibBQ2Q4oc8peUR2dKel4bZjOCkefnP4KOAT+87805Ot2qgaLA7TFytSqsaOnkW7e+tWQM3cAVZC2F8RpY=
X-Received: by 2002:a0d:df50:0:b0:5a1:d63f:5371 with SMTP id
 i77-20020a0ddf50000000b005a1d63f5371mr428154ywe.20.1697492672209; Mon, 16 Oct
 2023 14:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093549.181952-1-jhs@mojatatu.com> <20231016131506.71ad76f5@kernel.org>
 <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com> <CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
In-Reply-To: <CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Oct 2023 17:44:20 -0400
Message-ID: <CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, anjali.singhai@intel.com, namrata.limaye@intel.com, 
	deb.chatterjee@intel.com, john.andy.fingerhut@intel.com, dan.daly@intel.com, 
	Vipin.Jain@amd.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 4:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Oct 16, 2023 at 4:38=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Oct 16, 2023 at 4:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 16 Oct 2023 05:35:31 -0400 Jamal Hadi Salim wrote:
> > > > Changes In RFC Version 7
> > > > -------------------------
> > > >
> > > > 0) First time removing the RFC tag!
> > > >
> > > > 1) Removed XDP cookie. It turns out as was pointed out by Toke(Than=
ks!) - that
> > > > using bpf links was sufficient to protect us from someone replacing=
 or deleting
> > > > a eBPF program after it has been bound to a netdev.
> > > >
> > > > 2) Add some reviewed-bys from Vlad.
> > > >
> > > > 3) Small bug fixes from v6 based on testing for ebpf.
> > > >
> > > > 4) Added the counter extern as a sample extern. Illustrating this e=
xample because
> > > >    it is slightly complex since it is possible to invoke it directl=
y from
> > > >    the P4TC domain (in case of direct counters) or from eBPF (indir=
ect counters).
> > > >    It is not exactly the most efficient implementation (a reasonabl=
e counter impl
> > > >    should be per-cpu).
> > >
> > > I think that I already shared my reservations about this series.
> >
> > And please please let's have a _technical_ discussion on reservations
> > not hyperboles.
> >
> > > On top of that, please, please, please make sure that it builds clean=
ly
> > > before posting.
> > >
> > > I took the shared infra 8 hours to munch thru this series, and it thr=
ew
> > > out all sorts of warnings. 8 hours during which I could not handle an=
y
> > > PR or high-prio patch :( Not your fault that builds are slow, I guess=
,
> > > but if you are throwing a huge series at the list for the what-ever't=
h
> > > time, it'd be great if it at least built cleanly :(
> >
> > We absolutely dont want to add unnecessary work.
> > Probably we may have missed the net-next tip? We'll pull the latest
> > and retest with tip.
> > Is there a link that we can look at on what the infra does so we can
> > make sure it works per expectation next time?
> > If you know what kind of warnings/issues so we can avoid it going forwa=
rd?
> > Note: We didnt see any and we built each patch separately on gcc 11,
> > 12, 13 and clang 16.
> > BTW: Lore does reorder the patches, but i am assuming cicd is smart
> > enough to understand this?
>
> Verified from downloading mbox.gz from lore that the tarball was
> reordered. Dont know if it contributed - but now compiling patch by
> patch on the latest net-next tip.

Never mind - someone pointed me to patch work and i can see some
warnings there. Looks like we need more build types and compiler
options to catch some of these issues.
We'll look into it and we will replicate in our cicd.

cheers,
jamal
> cheers,
> jamal
>
> > > --
> > > pw-bot: cr

