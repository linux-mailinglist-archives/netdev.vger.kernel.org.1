Return-Path: <netdev+bounces-52961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F5800EE1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85ED1F20F91
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9387F4B5D8;
	Fri,  1 Dec 2023 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EutDptHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86110DE
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:58:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c69c61b58so4237a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446315; x=1702051115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4XTRLCjQNY4AaZPgLHYq/6hjlTc5C/AJGeUvs9n7yQ=;
        b=EutDptHiUw9rM5JuCY25WabPBKiHNyPj2O8tbnWZTfTULbh5vz19L9UJegjVgsyfFk
         cnKJvb6nZkgmUV/rwAMaUGJpGZd5hX+RNq71upD92ZX8d39R15O/ERxAo+csVA1cHGWe
         h0OnMhCRHTvVMVwlq58HGZcvhgh8dXO/L845Y5SGYxAnrGLYg1wa32vEFvVYHLTDwi74
         DcqSouehddDVIVFPWQvFQpRD9HoV23wB/cSE+MA+OPlrc3s+nkEMeoP6qN9tABLvpLY8
         q+dQtyl+0cpur+BJ78wT1WjMlm2YoK1B1qdFMTR9sk7jDFwd7ZhDtm4Ji3Pgeq2EcIM+
         c4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446315; x=1702051115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4XTRLCjQNY4AaZPgLHYq/6hjlTc5C/AJGeUvs9n7yQ=;
        b=HPkeOcJ4mAhqazOE5A8rGsbAAmM6R6kYuoMN7E43r7+QDGoXlHCXFXoxwjoQkJUPoA
         XkcRFr0M5dmHiRVS7QQ7c9i9rrZveLPSamX2+1OR7s0vR1PtYtkqEHh7kTWocG938muN
         uTS+sviF7lL03Sx63COqOGdKxAVVlRVucH0gJIgWjPHuSEDxyUXz/peQA9vo1z47aHA9
         61PeUdT0npfgXYomhhpDRp02LRZ/K4YX9u74ZrRqGMvJCekrHe8TKvlp9rE+3D8uLIC9
         SsZb1ioZqtYruT+7Tu0HAWuNWDuBAX6N3wp0midl4fNS71AljaYr9LT4wS2uuxLL1io6
         Oj4A==
X-Gm-Message-State: AOJu0YwP2KuRPwh1rRFpew60R0bwtaaDiMgtmFVBMrZgV14CwrPwSaWS
	mO4R574pNeTs0wKVk9hpuTQfUON+hiwzY0e0ksJ+fA==
X-Google-Smtp-Source: AGHT+IETZC5B9Y3xnn8xU2T+GKS4UY7ZOf1kGKXZS07ClteBVWmFc9YIExz8FHVfWlSRa04bkafc9UBaoXCV5Z1s4T0=
X-Received: by 2002:a50:d49c:0:b0:543:fb17:1a8 with SMTP id
 s28-20020a50d49c000000b00543fb1701a8mr83421edi.3.1701446315174; Fri, 01 Dec
 2023 07:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com> <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 16:58:21 +0100
Message-ID: <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Doug Anderson <dianders@chromium.org>
Cc: Judy Hsiao <judyhsiao@chromium.org>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 4:16=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.o=
rg> wrote:
> > >
> > > We are seeing cases where neigh_cleanup_and_release() is called by
> > > neigh_forced_gc() many times in a row with preemption turned off.
> > > When running on a low powered CPU at a low CPU frequency, this has
> > > been measured to keep preemption off for ~10 ms. That's not great on =
a
> > > system with HZ=3D1000 which expects tasks to be able to schedule in
> > > with ~1ms latency.
> >
> > This will not work in general, because this code runs with BH blocked.
> >
> > jiffies will stay untouched for many more ms on systems with only one C=
PU.
> >
> > I would rather not rely on jiffies here but ktime_get_ns() [1]
> >
> > Also if we break the loop based on time, we might be unable to purge
> > the last elements in gc_list.
> > We might need to use a second list to make sure to cycle over all
> > elements eventually.
> >
> >
> > [1]
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d=
23ef09bb4b0db53b4
> > 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl=
)
> >  {
> >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> >                         READ_ONCE(tbl->gc_thresh2);
> > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
>
> It might be nice to make the above timeout based on jiffies. On a
> HZ=3D100 system it's probably OK to keep preemption disabled for 10 ms
> but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to use
> jiffies_to_nsecs(1)?

I do not think so. 10ms would be awfully long.

We have nsec based time service, why downgrading to jiffies resolution ???

>
> One worry might be that we disabled preemption _right before_ we were
> supposed to be scheduled out. In that case we'll end up blocking some
> other task for another full timeslice, but maybe there's not a lot we
> can do there?

Can you tell us in which scenario this gc_list can be so big, other
than fuzzers ?

